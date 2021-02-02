Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1293D30BBB6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 11:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhBBKEf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 05:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhBBKET (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 05:04:19 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A387FC06174A
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 02:03:38 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id QA3b240094C55Sk01A3bCq; Tue, 02 Feb 2021 11:03:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l6sX0-002fzy-Ga; Tue, 02 Feb 2021 11:03:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l6sX0-003TgU-3y; Tue, 02 Feb 2021 11:03:34 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI: Fix memory leak in pci_register_io_range()
Date:   Tue,  2 Feb 2021 11:03:32 +0100
Message-Id: <20210202100332.829047-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kmemleak reports:

    unreferenced object 0xc328de40 (size 64):
      comm "kworker/1:1", pid 21, jiffies 4294938212 (age 1484.670s)
      hex dump (first 32 bytes):
        00 00 00 00 00 00 00 00 e0 d8 fc eb 00 00 00 00  ................
        00 00 10 fe 00 00 00 00 00 00 00 00 00 00 00 00  ................

    backtrace:
      [<ad758d10>] pci_register_io_range+0x3c/0x80
      [<2c7f139e>] of_pci_range_to_resource+0x48/0xc0
      [<f079ecc8>] devm_of_pci_get_host_bridge_resources.constprop.0+0x2ac/0x3ac
      [<e999753b>] devm_of_pci_bridge_init+0x60/0x1b8
      [<a895b229>] devm_pci_alloc_host_bridge+0x54/0x64
      [<e451ddb0>] rcar_pcie_probe+0x2c/0x644

In case a PCI host driver's probe is deferred, the same I/O range may be
allocated again, and be ignored, causing a memory leak.

Fix this by (a) letting logic_pio_register_range() return -EEXIST if the
passed range already exists, so pci_register_io_range() will free it,
and by (b) making pci_register_io_range() not consider -EEXIST an error
condition.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pci/pci.c | 4 ++++
 lib/logic_pio.c   | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 09b03cfba8894955..c651003e304a2b71 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4037,6 +4037,10 @@ int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
 	ret = logic_pio_register_range(range);
 	if (ret)
 		kfree(range);
+
+	/* Ignore duplicates due to deferred probing */
+	if (ret == -EEXIST)
+		ret = 0;
 #endif
 
 	return ret;
diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f32fe481b4922bc1..07b4b9a1f54b6bf5 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -28,6 +28,8 @@ static DEFINE_MUTEX(io_range_mutex);
  * @new_range: pointer to the IO range to be registered.
  *
  * Returns 0 on success, the error code in case of failure.
+ * If the range already exists, -EEXIST will be returned, which should be
+ * considered a success.
  *
  * Register a new IO range node in the IO range list.
  */
@@ -51,6 +53,7 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
 	list_for_each_entry(range, &io_range_list, list) {
 		if (range->fwnode == new_range->fwnode) {
 			/* range already there */
+			ret = -EEXIST;
 			goto end_register;
 		}
 		if (range->flags == LOGIC_PIO_CPU_MMIO &&
-- 
2.25.1

