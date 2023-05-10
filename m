Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89EB6FE4F0
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjEJUTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjEJUTn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 16:19:43 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DC30D4;
        Wed, 10 May 2023 13:19:41 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id ABF55300000B8;
        Wed, 10 May 2023 22:19:37 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9EF091AAC62; Wed, 10 May 2023 22:19:37 +0200 (CEST)
Date:   Wed, 10 May 2023 22:19:37 +0200
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
Message-ID: <20230510201937.GA11550@wunner.de>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
 <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
 <20221104101536.GA11363@wunner.de>
 <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba22d6b-c225-4b44-674b-2c62306135ed@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 14, 2023 at 01:33:54AM -0800, Smita Koralahalli wrote:
> On 11/4/2022 3:15 AM, Lukas Wunner wrote:
> > On Tue, Nov 01, 2022 at 12:07:18AM +0000, Smita Koralahalli wrote:
> > > The implementation is as follows: On an async remove a DPC is triggered as
> > > a side-effect along with an MSI to the OS. Determine it's an async remove
> > > by checking for DPC Trigger Status in DPC Status Register and Surprise
> > > Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
> > > treat the DPC event as a side-effect of async remove, clear the error
> > > status registers and continue with hot-plug tear down routines. If not,
> > > follow the existing routine to handle AER/DPC errors.
> > 
> > Instead of having the OS recognize and filter Surprise Down events,
> > it would also be possible to simply set the Surprise Down bit in the
> > Uncorrectable Error Mask Register.  This could be constrained to
> > Downstream Ports capable of surprise removal, i.e. those where the
> > is_hotplug_bridge in struct pci_dev is set.  And that check and the
> > register change could be performed in pci_dpc_init().
> > 
> > Have you considered such an alternative approach?  If you have, what
> > was the reason to prefer the more complex solution you're proposing?
[...]
> Second thing, is masking Surprise Down bit has no impact on logging errors
> in AER registers.

Why do you think so?  PCIe r6.0.1 sec 7.8.4.3 says:

   "A masked error [...] is not recorded or reported in the Header Log,
    TLP Prefix Log, or First Error Pointer, and is not reported to the
    PCI Express Root Complex by this Function."

So if you set the Surprise Down Error Mask bit on hotplug ports
capable of surprise removal, there should be no logging and thus
no logs to clear.


> So, I think that approach probably will not resolve the issue of clearing
> the logs in AER registers and complicate things while differentiating true
> errors vs surprise down events. Please correct me if I'm wrong!!

I disagree, I think it's worth a try.  Below please find a patch which
sets the Surprise Down Error mask bit.  Could you test if this fixes
the issue for you?


> And setting this bit at initialization might not trigger true DPC events..

I think we cannot discern whether a Surprise Down Error is caused by
surprise removal or is a true error.  We must assume the former on
surprise-capable hotplug ports.

Thanks,

Lukas

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
 drivers/pci/hotplug/pciehp_hpc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f8c70115b691..2a206dbd76b6 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -985,6 +985,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
 	u32 slot_cap, slot_cap2, link_cap;
+	u16 aer_cap;
 	u8 poweron;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -1030,6 +1031,15 @@ struct controller *pcie_init(struct pcie_device *dev)
 	if (dmi_first_match(inband_presence_disabled_dmi_table))
 		ctrl->inband_presence_disabled = 1;
 
+	/*
+	 * Surprise Down Errors are par for the course on Hot-Plug Surprise
+	 * capable ports, so disable reporting in case BIOS left it enabled.
+	 */
+	aer_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer_cap && slot_cap & PCI_EXP_SLTCAP_HPS)
+		pcie_capability_set_dword(pdev, aer_cap + PCI_ERR_UNCOR_MASK,
+					  PCI_ERR_UNC_SURPDN);
+
 	/* Check if Data Link Layer Link Active Reporting is implemented */
 	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &link_cap);
 
-- 
2.39.2

