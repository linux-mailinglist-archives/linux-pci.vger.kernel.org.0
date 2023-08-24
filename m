Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44F47878B6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 21:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243246AbjHXTiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243321AbjHXThu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 15:37:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1B1FC6;
        Thu, 24 Aug 2023 12:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 713ED644D4;
        Thu, 24 Aug 2023 19:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64CEC433C9;
        Thu, 24 Aug 2023 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692905864;
        bh=JF4aoYXvhwwGY1nb0JRV285aw6syiWjGXPP5TBk/igk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snJa2BGFl5Ba0EhWPJ2mWaaO/1hwW09WM6INqlYgW00qYXDrs0d64NJz/agaptRSi
         CN5Zo6ynxQQHxAKqo6cnRiiyC2T1qK7my4gMoYoZGDWWAfrmE5ENj6nz+6jZ4poHxk
         gAb2wmliJ9lRhO9IyEBgDKdQa16pvGetmb0jGcUPrTgFgWRJkwyaBu2A8Gu1ZgBaO0
         w/DZRj76sUR7KtKpw0UoDzxNJUtwccqsVe3LUo/vGiF16Wt67qpNw7qqNFYBvhYZ+W
         +v8qYFT3hfH9A7Lsfomk4gj4vtRICf4YU6LFEyyW1lVaK+E/zHBRi460cNte6y4oWt
         Ks+t/Rupy+fLA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 10/12] PCI: Fix typos in docs and comments
Date:   Thu, 24 Aug 2023 14:37:10 -0500
Message-Id: <20230824193712.542167-11-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824193712.542167-1-helgaas@kernel.org>
References: <20230824193712.542167-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos in docs and comments.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pci-error-recovery.rst      | 12 +++----
 drivers/pci/controller/cadence/pcie-cadence.h |  2 +-
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 32 +++++++++----------
 drivers/pci/msi/irqdomain.c                   |  4 +--
 drivers/pci/p2pdma.c                          |  2 +-
 drivers/pci/pci.c                             |  2 +-
 drivers/pci/probe.c                           |  2 +-
 drivers/pci/quirks.c                          |  8 ++---
 drivers/pci/setup-bus.c                       |  2 +-
 9 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index c237596f67e3..0c7552a00c8c 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -17,7 +17,7 @@ chipsets are able to deal with these errors; these include PCI-E chipsets,
 and the PCI-host bridges found on IBM Power4, Power5 and Power6-based
 pSeries boxes. A typical action taken is to disconnect the affected device,
 halting all I/O to it.  The goal of a disconnection is to avoid system
-corruption; for example, to halt system memory corruption due to DMA's
+corruption; for example, to halt system memory corruption due to DMAs
 to "wild" addresses. Typically, a reconnection mechanism is also
 offered, so that the affected PCI device(s) are reset and put back
 into working condition. The reset phase requires coordination
@@ -178,9 +178,9 @@ is STEP 6 (Permanent Failure).
    complex and not worth implementing.
 
    The current powerpc implementation doesn't much care if the device
-   attempts I/O at this point, or not.  I/O's will fail, returning
+   attempts I/O at this point, or not.  I/Os will fail, returning
    a value of 0xff on read, and writes will be dropped. If more than
-   EEH_MAX_FAILS I/O's are attempted to a frozen adapter, EEH
+   EEH_MAX_FAILS I/Os are attempted to a frozen adapter, EEH
    assumes that the device driver has gone into an infinite loop
    and prints an error to syslog.  A reboot is then required to
    get the device working again.
@@ -204,7 +204,7 @@ instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
 .. note::
 
    The following is proposed; no platform implements this yet:
-   Proposal: All I/O's should be done _synchronously_ from within
+   Proposal: All I/Os should be done _synchronously_ from within
    this callback, errors triggered by them will be returned via
    the normal pci_check_whatever() API, no new error_detected()
    callback will be issued due to an error happening here. However,
@@ -258,7 +258,7 @@ Powerpc platforms implement two levels of slot reset:
 soft reset(default) and fundamental(optional) reset.
 
 Powerpc soft reset consists of asserting the adapter #RST line and then
-restoring the PCI BAR's and PCI configuration header to a state
+restoring the PCI BARs and PCI configuration header to a state
 that is equivalent to what it would be after a fresh system
 power-on followed by power-on BIOS/system firmware initialization.
 Soft reset is also known as hot-reset.
@@ -362,7 +362,7 @@ permanent failure in some way.  If the device is hotplug-capable,
 the operator will probably want to remove and replace the device.
 Note, however, not all failures are truly "permanent". Some are
 caused by over-heating, some by a poorly seated card. Many
-PCI error events are caused by software bugs, e.g. DMA's to
+PCI error events are caused by software bugs, e.g. DMAs to
 wild addresses or bogus split transactions due to programming
 errors. See the discussion in Documentation/powerpc/eeh-pci-error-recovery.rst
 for additional detail on real-life experience of the causes of
diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
index 190786e47df9..373cb50fcd15 100644
--- a/drivers/pci/controller/cadence/pcie-cadence.h
+++ b/drivers/pci/controller/cadence/pcie-cadence.h
@@ -32,7 +32,7 @@
 #define  CDNS_PCIE_LM_ID_SUBSYS(sub) \
 	(((sub) << CDNS_PCIE_LM_ID_SUBSYS_SHIFT) & CDNS_PCIE_LM_ID_SUBSYS_MASK)
 
-/* Root Port Requestor ID Register */
+/* Root Port Requester ID Register */
 #define CDNS_PCIE_LM_RP_RID	(CDNS_PCIE_LM_BASE + 0x0228)
 #define  CDNS_PCIE_LM_RP_RID_MASK	GENMASK(15, 0)
 #define  CDNS_PCIE_LM_RP_RID_SHIFT	0
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index c8b423c3c26e..3f60128560ed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -986,22 +986,22 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
 /*==== virtual PCI bus driver, which only load virtual NTB PCI driver ====*/
 
 static u32 pci_space[] = {
-	0xffffffff,	/*DeviceID, Vendor ID*/
-	0,		/*Status, Command*/
-	0xffffffff,	/*Class code, subclass, prog if, revision id*/
-	0x40,		/*bist, header type, latency Timer, cache line size*/
-	0,		/*BAR 0*/
-	0,		/*BAR 1*/
-	0,		/*BAR 2*/
-	0,		/*BAR 3*/
-	0,		/*BAR 4*/
-	0,		/*BAR 5*/
-	0,		/*Cardbus cis point*/
-	0,		/*Subsystem ID Subystem vendor id*/
-	0,		/*ROM Base Address*/
-	0,		/*Reserved, Cap. Point*/
-	0,		/*Reserved,*/
-	0,		/*Max Lat, Min Gnt, interrupt pin, interrupt line*/
+	0xffffffff,	/* Device ID, Vendor ID */
+	0,		/* Status, Command */
+	0xffffffff,	/* Base Class, Subclass, Prog Intf, Revision ID */
+	0x40,		/* BIST, Header Type, Latency Timer, Cache Line Size */
+	0,		/* BAR 0 */
+	0,		/* BAR 1 */
+	0,		/* BAR 2 */
+	0,		/* BAR 3 */
+	0,		/* BAR 4 */
+	0,		/* BAR 5 */
+	0,		/* Cardbus CIS Pointer */
+	0,		/* Subsystem ID, Subsystem Vendor ID */
+	0,		/* ROM Base Address */
+	0,		/* Reserved, Capabilities Pointer */
+	0,		/* Reserved */
+	0,		/* Max_Lat, Min_Gnt, Interrupt Pin, Interrupt Line */
 };
 
 static int pci_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val)
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index e33bcc872699..c8be056c248d 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -336,7 +336,7 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 	if (!irq_domain_is_msi_parent(domain)) {
 		/*
 		 * For "global" PCI/MSI interrupt domains the associated
-		 * msi_domain_info::flags is the authoritive source of
+		 * msi_domain_info::flags is the authoritative source of
 		 * information.
 		 */
 		info = domain->host_data;
@@ -344,7 +344,7 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 	} else {
 		/*
 		 * For MSI parent domains the supported feature set
-		 * is avaliable in the parent ops. This makes checks
+		 * is available in the parent ops. This makes checks
 		 * possible before actually instantiating the
 		 * per device domain because the parent is never
 		 * expanding the PCI/MSI functionality.
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ec04d0ed157b..fa7370f9561a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -435,7 +435,7 @@ static const struct pci_p2pdma_whitelist_entry {
 	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
 	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
 	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
-	/* Intel SkyLake-E */
+	/* Intel Skylake-E */
 	{PCI_VENDOR_ID_INTEL,	0x2030, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2031, 0},
 	{PCI_VENDOR_ID_INTEL,	0x2032, 0},
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6b62795425a7..749ef90c623d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1290,7 +1290,7 @@ int pci_power_up(struct pci_dev *dev)
  *
  * Call pci_power_up() to put @dev into D0, read from its PCI_PM_CTRL register
  * to confirm the state change, restore its BARs if they might be lost and
- * reconfigure ASPM in acordance with the new power state.
+ * reconfigure ASPM in accordance with the new power state.
  *
  * If pci_restore_state() is going to be called right after a power state change
  * to D0, it is more efficient to use pci_power_up() directly instead of this
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 31fb02fbb2cc..deb5286f8533 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2136,7 +2136,7 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 {
 	struct pci_dev *root;
 
-	/* PCI_EXP_DEVICE_RELAX_EN is RsvdP in VFs */
+	/* PCI_EXP_DEVCTL_RELAX_EN is RsvdP in VFs */
 	if (dev->is_virtfn)
 		return;
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 321156ca273d..e2afa3918367 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -362,7 +362,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	quirk_isa_d
 #endif
 
 /*
- * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
+ * Intel NM10 "Tiger Point" LPC PM1a_STS.BM_STS must be clear
  * for some HT machines to use C4 w/o hanging.
  */
 static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
@@ -375,7 +375,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *dev)
 	pm1a = inw(pmbase);
 
 	if (pm1a & 0x10) {
-		pci_info(dev, FW_BUG "TigerPoint LPC.BM_STS cleared\n");
+		pci_info(dev, FW_BUG "Tiger Point LPC.BM_STS cleared\n");
 		outw(0x10, pmbase);
 	}
 }
@@ -3073,7 +3073,7 @@ static void __nv_msi_ht_cap_quirk(struct pci_dev *dev, int all)
 
 	/*
 	 * HT MSI mapping should be disabled on devices that are below
-	 * a non-Hypertransport host bridge. Locate the host bridge...
+	 * a non-HyperTransport host bridge. Locate the host bridge.
 	 */
 	host_bridge = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0,
 						  PCI_DEVFN(0, 0));
@@ -5729,7 +5729,7 @@ int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *l, int timeout)
 /*
  * Microsemi Switchtec NTB uses devfn proxy IDs to move TLPs between
  * NT endpoints via the internal switch fabric. These IDs replace the
- * originating requestor ID TLPs which access host memory on peer NTB
+ * originating Requester ID TLPs which access host memory on peer NTB
  * ports. Therefore, all proxy IDs must be aliased to the NTB device
  * to permit access when the IOMMU is turned on.
  */
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index fdeb121e9175..dae490f25641 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1799,7 +1799,7 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
 			 * Make sure prefetchable memory is reduced from
 			 * the correct resource. Specifically we put 32-bit
 			 * prefetchable memory in non-prefetchable window
-			 * if there is an 64-bit pretchable window.
+			 * if there is an 64-bit prefetchable window.
 			 *
 			 * See comments in __pci_bus_size_bridges() for
 			 * more information.
-- 
2.34.1

