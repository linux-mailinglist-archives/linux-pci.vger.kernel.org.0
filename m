Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1601C6FF5D4
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 17:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjEKPXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238671AbjEKPXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 11:23:33 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED56E64
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 08:23:31 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0AD0F30008206;
        Thu, 11 May 2023 17:23:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F26312560F6; Thu, 11 May 2023 17:23:26 +0200 (CEST)
Date:   Thu, 11 May 2023 17:23:26 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, oohall@gmail.com,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>
Subject: Re: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and
 AER/DPC
Message-ID: <20230511152326.GA16215@wunner.de>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221104101536.GA11363@wunner.de>
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
 <20230510201937.GA11550@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510201937.GA11550@wunner.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 10, 2023 at 10:19:37PM +0200, Lukas Wunner wrote:
> Below please find a patch which
> sets the Surprise Down Error mask bit.  Could you test if this fixes
> the issue for you?

Sorry, I failed to appreciate that pcie_capability_set_dword()
can't be used to RMW the AER capability.  Replacement patch below.

-- >8 --

From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI: pciehp: Disable Surprise Down Error reporting

On hotplug ports capable of surprise removal, Surprise Down Errors are
expected and no reason for AER or DPC to spring into action.  Although
a Surprise Down event might be caused by an error, software cannot
discern that from regular surprise removal.

Any well-behaved BIOS should mask such errors, but Smita reports a case
where hot-removing an Intel NVMe SSD [8086:0a54] from an AMD Root Port
[1022:14ab] results in irritating AER log messages and a delay of more
than 1 second caused by DPC handling:

  pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
  pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
  pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
  pcieport 0000:00:01.4:    [ 5] SDES (First)
  nvme nvme2: frozen state error detected, reset controller
  pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
  pcieport 0000:00:01.4: AER: subordinate device reset failed
  pcieport 0000:00:01.4: AER: device recovery failed
  pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
  nvme2n1: detected capacity change from 1953525168 to 0
  pci 0000:04:00.0: Removing from iommu group 49

Avoid by masking Surprise Down Errors on hotplug ports capable of
surprise removal.

Mask them even if AER or DPC is handled by firmware because if hotplug
control was granted to the operating system, it owns hotplug and thus
Surprise Down events.  So firmware has no business reporting or reacting
to them.

Reported-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Link: https://lore.kernel.org/all/20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f8c70115b691..40a721f3b713 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -984,8 +984,9 @@ static inline int pcie_hotplug_depth(struct pci_dev *dev)
 struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
-	u32 slot_cap, slot_cap2, link_cap;
+	u32 slot_cap, slot_cap2, link_cap, aer_cap;
 	u8 poweron;
+	u16 aer;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
 
@@ -1030,6 +1031,17 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (dmi_first_match(inband_presence_disabled_dmi_table))
 		ctrl->inband_presence_disabled = 1;
 
+	/*
+	 * Surprise Down Errors are par for the course on Hot-Plug Surprise
+	 * capable ports, so disable reporting in case BIOS left it enabled.
+	 */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer && slot_cap & PCI_EXP_SLTCAP_HPS) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, &aer_cap);
+		aer_cap |= PCI_ERR_UNC_SURPDN;
+		pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, aer_cap);
+	}
+
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 
-- 
2.39.2

