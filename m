Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB335E53F3
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 21:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIUTtT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 15:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIUTtS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 15:49:18 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C35C3A0254;
        Wed, 21 Sep 2022 12:49:17 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6251A92009C; Wed, 21 Sep 2022 21:49:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 5C5A892009B;
        Wed, 21 Sep 2022 20:49:16 +0100 (BST)
Date:   Wed, 21 Sep 2022 20:49:16 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Bjorn Helgaas <bhelgaas@google.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: Sanitise firmware BAR assignments behind a PCI-PCI
 bridge
Message-ID: <alpine.DEB.2.21.2209211921250.29493@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix an issue with the Tyan Tomcat IV S1564D system, the BIOS of which 
does not assign PCI buses beyond #2, where our resource reallocation 
code preserves the reset default of an I/O BAR assignment outside its 
upstream PCI-to-PCI bridge's I/O forwarding range:

pci 0000:06:08.0: BAR 4: no space for [io  size 0x0020]
pci 0000:06:08.0: BAR 4: trying firmware assignment [io  0xfce0-0xfcff]
pci 0000:06:08.0: BAR 4: assigned [io  0xfce0-0xfcff]
[...]
pci_bus 0000:06: resource 0 [io  0x2000-0x2fff]

Consequently when the device driver tries to access 06:08.0 according to 
its designated address range it pokes at an unassigned I/O location, 
likely subtractively decoded by the southbridge and forwarded to ISA, 
causing the driver to become confused and bail out:

uhci_hcd 0000:06:08.0: host system error, PCI problems?
uhci_hcd 0000:06:08.0: host controller process error, something bad happened!
uhci_hcd 0000:06:08.0: host controller halted, very bad!
uhci_hcd 0000:06:08.0: HCRESET not completed yet!
uhci_hcd 0000:06:08.0: HC died; cleaning up

if good luck happens or if bad luck does, an infinite flood of messages:

uhci_hcd 0000:06:08.0: host system error, PCI problems?
uhci_hcd 0000:06:08.0: host controller process error, something bad happened!

making the system virtually unusable.

This is because we try to retain any BAR assignment the firmware may 
have made here, which may be necessary for devices on the root bus with 
some systems, but cannot work for devices that are behind a PCI-to-PCI 
bridge where the BAR assignment is outside the upstream bridge's 
forwarding range.

Make sure then for a device behind a PCI-to-PCI bridge that any firmware 
assignment is within the bridge's relevant forwarding window or do not 
restore the assignment, fixing the system concerned as follows:

pci 0000:06:08.0: BAR 4: no space for [io  size 0x0020]
pci 0000:06:08.0: BAR 4: failed to assign [io  0xfce0-0xfcff]
[...]
pci 0000:06:08.0: BAR 4: assigned [io  0x2000-0x201f]

and making device 06:08.0 work correctly.

Cf. <https://bugzilla.kernel.org/show_bug.cgi?id=16263>

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Link: https://lore.kernel.org/r/alpine.DEB.2.21.2203012338460.46819@angie.orcam.me.uk
Fixes: 58c84eda0756 ("PCI: fall back to original BIOS BAR addresses")
Cc: stable@vger.kernel.org # v2.6.35+
---
Hi Bjorn,

 I have trimmed the change description down as you requested and left the 
change proper unmodified, as discussed in my earlier response.

 Let me know if you have any other concerns with this fix.

  Maciej

Changes from v2:

- Change description trimmed and rephrased, link to a full bootstrap log 
  earlier on in discussion added.

Changes from v1:

- Do restore firmware BAR assignments behind a PCI-PCI bridge, but only if 
  within the bridge's forwarding window.

- Update the change description and heading accordingly (was: PCI: Do not 
  restore firmware BAR assignments behind a PCI-PCI bridge).
---
 drivers/pci/setup-res.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

linux-pci-setup-res-fw-address-nobridge.diff
Index: linux-macro/drivers/pci/setup-res.c
===================================================================
--- linux-macro.orig/drivers/pci/setup-res.c
+++ linux-macro/drivers/pci/setup-res.c
@@ -212,9 +212,19 @@ static int pci_revert_fw_address(struct
 	res->end = res->start + size - 1;
 	res->flags &= ~IORESOURCE_UNSET;
 
+	/*
+	 * If we're behind a P2P or CardBus bridge, make sure we're
+	 * inside the relevant forwarding window, or otherwise the
+	 * assignment must have been bogus and accesses intended for
+	 * the range assigned would not reach the device anyway.
+	 * On the root bus accept anything under the assumption the
+	 * host bridge will let it through.
+	 */
 	root = pci_find_parent_resource(dev, res);
 	if (!root) {
-		if (res->flags & IORESOURCE_IO)
+		if (dev->bus->parent)
+			return -ENXIO;
+		else if (res->flags & IORESOURCE_IO)
 			root = &ioport_resource;
 		else
 			root = &iomem_resource;
