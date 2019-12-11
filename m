Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF411A741
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2019 10:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKJfB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Dec 2019 04:35:01 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48212 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfLKJfB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2019 04:35:01 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C8A9B28B413
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: rockchip: Fix register number offset to program IO outbound ATU
Date:   Wed, 11 Dec 2019 10:34:50 +0100
Message-Id: <20191211093450.7481-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit '62240a88004b ("PCI: rockchip: Drop storing driver private
outbound resource data)' the offset calculation is wrong to access the
register number to program the IO outbound ATU. The offset should be
based on the IORESOURCE_MEM resource size instead of the IORESOURCE_IO
size.

This patch fixes the following 'synchronous external abort' bug:

[   15.362128] mwifiex_pcie 0000:01:00.0: enabling device (0000 -> 0002)
[   15.369655] mwifiex_pcie: PCI memory map Virt0: 00000000a573ad00 PCI memory map Virt2: 00000000783126c4
[   15.381466] Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
[   15.389965] Modules linked in: mwifiex_pcie(+) mwifiex uvcvideo cfg80211 atmel_mxt_ts videobuf2_vmalloc ...
[   15.461095] CPU: 2 PID: 269 Comm: systemd-udevd Not tainted 5.4.0+ #327
[   15.461097] Hardware name: Google Kevin (DT)
[   15.461101] pstate: 60000005 (nZCv daif -PAN -UAO)
[   15.461116] pc : mwifiex_register_dev+0x264/0x3f8 [mwifiex_pcie]
[   15.461121] lr : mwifiex_register_dev+0x150/0x3f8 [mwifiex_pcie]
[   15.461123] sp : ffff800012073860
[   15.461128] x29: ffff800012073860 x28: ffff8000100a2e28
[   15.509043] x27: ffff8000118b6210 x26: ffff800008f57458
[   15.515055] x25: ffff0000ecfda000 x24: 0000000000000001
[   15.521069] x23: ffff0000e9905080 x22: ffff800008f5d000
[   15.527082] x21: ffff0000eecea078 x20: ffff0000e9905080
[   15.533096] x19: ffff0000eecea000 x18: 0000000000000001
[   15.539108] x17: 0000000000000000 x16: 0000000000000000
[   15.545118] x15: ffffffffffffffff x14: ffff8000118998c8
[   15.551128] x13: ffff000000000000 x12: 0000000000000008
[   15.557138] x11: 0101010101010101 x10: ffff7f7fffff7fff
[   15.563148] x9 : 0000000000000000 x8 : ffff0000e3c24240
[   15.569159] x7 : 0000000000000000 x6 : ffff0000e3c24148
[   15.575169] x5 : ffff0000e3c24148 x4 : ffff0000e7975ec8
[   15.581178] x3 : 0000000000000001 x2 : 0000000000002b42
[   15.587188] x1 : ffff800012c00008 x0 : ffff0000e9905080
[   15.593200] Call trace:
[   15.595970]  mwifiex_register_dev+0x264/0x3f8 [mwifiex_pcie]
[   15.602398]  mwifiex_add_card+0x2f8/0x430 [mwifiex]
[   15.607920]  mwifiex_pcie_probe+0x98/0x148 [mwifiex_pcie]
[   15.614033]  local_pci_probe+0x3c/0xa0
[   15.618275]  pci_device_probe+0x110/0x1a8
[   15.622812]  really_probe+0xd4/0x308
[   15.626856]  driver_probe_device+0x54/0xe8
[   15.631491]  device_driver_attach+0x6c/0x78
[   15.636224]  __driver_attach+0x54/0xd0
[   15.640465]  bus_for_each_dev+0x70/0xc0
[   15.644804]  driver_attach+0x20/0x28
[   15.648847]  bus_add_driver+0x178/0x1d8
[   15.653186]  driver_register+0x60/0x110
[   15.657525]  __pci_register_driver+0x40/0x48
[   15.662359]  mwifiex_pcie_init+0x24/0x1000 [mwifiex_pcie]
[   15.668469]  do_one_initcall+0x74/0x1a8
[   15.672810]  do_init_module+0x50/0x208
[   15.677050]  load_module+0x1a78/0x1d18
[   15.681290]  __do_sys_finit_module+0xd0/0xe8
[   15.686120]  __arm64_sys_finit_module+0x1c/0x28
[   15.691247]  el0_svc_common.constprop.2+0x88/0x150
[   15.696668]  el0_svc_handler+0x20/0x80
[   15.700909]  el0_sync_handler+0x118/0x188
[   15.705444]  el0_sync+0x140/0x180
[   15.716955] Code: a8c67bfd d65f03c0 f942ac01 91002021 (b9400021)
[   15.731548] ---[ end trace 1488ca6d6b162849 ]---

Fixes: 62240a88004b ("PCI: rockchip: Drop storing driver private outbound resource data)
Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Suggested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/pci/controller/pcie-rockchip-host.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index d9b63bfa5dd7..94af6f5828a3 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -834,10 +834,12 @@ static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
 	if (!entry)
 		return -ENODEV;
 
+	/* store the register number offset to program RC io outbound ATU */
+	offset = size >> 20;
+
 	size = resource_size(entry->res);
 	pci_addr = entry->res->start - entry->offset;
 
-	offset = size >> 20;
 	for (reg_no = 0; reg_no < (size >> 20); reg_no++) {
 		err = rockchip_pcie_prog_ob_atu(rockchip,
 						reg_no + 1 + offset,
-- 
2.20.1

