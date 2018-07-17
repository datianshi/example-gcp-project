resource "google_compute_route" "vpn" {
  name        = "${var.env_name}-vpnroute"
  dest_range  = "${var.on_premise_range}"
  network     = "${var.network}"
  next_hop_vpn_tunnel = "${var.vpn_tunnel}"
  priority    = 1000
}
