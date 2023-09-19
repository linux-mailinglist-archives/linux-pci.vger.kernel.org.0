Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CB37A6ACC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Sep 2023 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjISSlf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Sep 2023 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjISSlf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Sep 2023 14:41:35 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC319D
        for <linux-pci@vger.kernel.org>; Tue, 19 Sep 2023 11:41:29 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6B8141033362A;
        Tue, 19 Sep 2023 20:41:27 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 3959A25D6FC; Tue, 19 Sep 2023 20:41:27 +0200 (CEST)
Date:   Tue, 19 Sep 2023 20:41:27 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Schroeder, Chad" <CSchroeder@sonifi.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCIe device issue since v6.1.16
Message-ID: <20230919184127.GA13587@wunner.de>
References: <DM6PR16MB2844903E34CAB910082DF019B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
 <20230919145921.GA8609@wunner.de>
 <DM6PR16MB2844AC71B336A5AD50005221B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR16MB2844AC71B336A5AD50005221B1FAA@DM6PR16MB2844.namprd16.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Chad,

On Tue, Sep 19, 2023 at 03:08:08PM +0000, Schroeder, Chad wrote:
> 0000:64:00.0 PCI bridge: Intel Corporation Sky Lake-E PCI Express Root Port A (rev 07) (prog-if 00 [Normal decode])
[...]
> 	Bus: primary=64, secondary=65, subordinate=65, sec-latency=0
[...]
> 	Capabilities: [90] Express (v2) Root Port (Slot+), MSI 00
[...]
> 		LnkCap:	Port #5, Speed 8GT/s, Width x16, ASPM L1, Exit Latency L1 <16us
> 			ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 2.5GT/s, Width x1
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-

pci_bridge_secondary_bus_reset() calls pcibios_reset_secondary_bus()
to perform the SBR, then calls pci_bridge_wait_for_secondary_bus()
to perform the delays prescribed by the spec.

At the bottom of pci_bridge_wait_for_secondary_bus(), there's an if-else
clause and based on the lspci output quoted above, I'd expect that control
flow enters the else branch (because the SkyLake Root Port supports more
than 5 GT/s, namely 8 GT/s.

The function then calls pcie_wait_for_link_delay() to wait for the link
to come up, then waits 100 msec per PCIe r6.1 sec 6.6.1.

Afterwards it calls pci_dev_wait() to poll the Vendor ID register of the
VideoPropulsion card.

My guess is that the VideoPropulsion card requires a longer delay than
100 msec before its config space is first accessed.  The PCI system errors
that you mention are probably raised by the card because it is not ready
yet to handle those config space accesses.

Since this is a PCIe r1.0 card, I've checked whether PCIe r1.0 has
longer delays after reset than contemporary revisions of the PCIe
Base Spec.  But that's not the case.  PCIe r1.0 sec 7.6 says:

   "To allow components to perform internal initialization, system
    software must wait for at least 100 ms from the end of a reset
    (cold/warm/hot) before it is permitted to issue Configuration
    Requests to PCI Express devices
    [...]
    The Root Complex and/or system software must allow 1.0s (+50% / -0%)
    after a reset (hot/warm/cold), before it may determine that a device
    which fails to return a Successful Completion status for a valid
    Configuration Request is a broken device"

Those timing requirements are essentially identical to what contemporary
PCIe revisions prescribe.  It's also what the code in the kernel follows.

Which leads me to believe that the longer delay before the first config
space access required by this particular card is a quirk.  So I'm
proposing the following patch:


diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 20ac67d..3cbff71 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5993,3 +5993,9 @@ static void dpc_log_size(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+static void pci_fixup_d3cold_delay_1sec(struct pci_dev *pdev)
+{
+	pdev->d3cold_delay = 1000;
+}
+DECLARE_PCI_FIXUP_FINAL(0x5555, 0x0004, pci_fixup_d3cold_delay_1sec);


Could you test if applying this on top of v6.1.16 fixes the issue?
(Apply with "patch -p1 < filename.patch" at the top of the kernel
source tree.)

Thanks,

Lukas
