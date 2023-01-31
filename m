Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC17682A96
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 11:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjAaKbq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 05:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjAaKbn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 05:31:43 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ECA3EFD9
        for <linux-pci@vger.kernel.org>; Tue, 31 Jan 2023 02:31:41 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:fd54:3eff:f16a:8c82])
        by laurent.telenet-ops.be with bizsmtp
        id FNXf2900b3oGUMV01NXf6P; Tue, 31 Jan 2023 11:31:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pMnvB-007vjk-Pw;
        Tue, 31 Jan 2023 11:31:39 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pMnvP-000NWt-NJ;
        Tue, 31 Jan 2023 11:31:39 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend] PCI: Fix dropping valid root bus resources with .end = zero
Date:   Tue, 31 Jan 2023 11:31:36 +0100
Message-Id: <ecea3ffade000556419683b2a89ab402823bf323.1675160811.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On r8a7791/koelsch:

    kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
    # cat /sys/kernel/debug/kmemleak
    unreferenced object 0xc3a34e00 (size 64):
      comm "swapper/0", pid 1, jiffies 4294937460 (age 199.080s)
      hex dump (first 32 bytes):
	b4 5d 81 f0 b4 5d 81 f0 c0 b0 a2 c3 00 00 00 00  .]...]..........
	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
      backtrace:
	[<fe3aa979>] __kmalloc+0xf0/0x140
	[<34bd6bc0>] resource_list_create_entry+0x18/0x38
	[<767046bc>] pci_add_resource_offset+0x20/0x68
	[<b3f3edf2>] devm_of_pci_get_host_bridge_resources.constprop.0+0xb0/0x390

When coalescing two resources for a contiguous aperture, the first
resource is enlarged to cover the full contiguous range, while the
second resource is marked invalid.  This invalidation is done by
clearing the flags, start, and end members.

When adding the initial resources to the bus later, invalid resources
are skipped.  Unfortunately, the check for an invalid resource considers
only the end member, causing false positives.

E.g. on r8a7791/koelsch, root bus resource 0 ("bus 00") is skipped, and
no longer registered with pci_bus_insert_busn_res() (causing the memory
leak), nor printed:

     pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
     pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
     pci-rcar-gen2 ee090000.pci: PCI: revision 11
     pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
    -pci_bus 0000:00: root bus resource [bus 00]
     pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]

Fix this by only skipping resources where all of the flags, start, and
end members are zero.

Fixes: 7c3855c423b17f6c ("PCI: Coalesce host bridge contiguous apertures")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
Is there any side effect of not registering the root bus resource with
pci_bus_insert_busn_res()?  This is the resource created by
of_pci_parse_bus_range(), and thus affects any DT platforms using
"bus-range = <0 0>".

Perhaps checking for "!res->flags" would be sufficient?

I assume this still causes memory leaks on systems where resources are
coalesced, as the second resource of a contiguous aperture is no longer
referenced? Perhaps instead of clearing the resource, it should be
removed from the list (and freed? is it actually safe to do that?)?

Apparently Johannes had identified the bug before, but didn't realize
the full impact...
https://lore.kernel.org/r/5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net/

v2:
  - Add Tested-by, Acked-by.
---
 drivers/pci/probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1779582fb5007cd1..5988584825482e9f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -996,7 +996,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		offset = window->offset;
 		res = window->res;
-		if (!res->end)
+		if (!res->flags && !res->start && !res->end)
 			continue;
 
 		list_move_tail(&window->node, &bridge->windows);
-- 
2.34.1

