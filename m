Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF76329FE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKUQuX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKUQuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 11:50:16 -0500
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Nov 2022 08:50:15 PST
Received: from osmtp.xiscosoft.net (osmtp.xiscosoft.net [5.135.184.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AD521251
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 08:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=klondike.es;
        s=xiscosoft_net; t=1669048837; x=1670258437;
        bh=js2LHMKLow50y1NDsDdJlb0AbdCa2FUViUgjQ8BJYMw=;
        h=From:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
         Message-Id:Date:From:Subject:To:Cc:Date:Reply-To:Content-Type:
         Sender:Message-ID:References:In-Reply-To:Content-Base:
         Content-Location:Content-features:Content-Disposition:
         Content-Alternative:Content-MD5:Content-Duration:
         Content-Transfer-Encoding:Content-Language:MIME-Version:Content-ID:
         Content-Description:Autocrypt:List-Id:List-Help:List-Unsubscribe:
         List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
         List-Archive:Original-Message-ID:Require-Recipient-Valid-Since:
         Solicitation:Organization:Jabber-ID:Auto-Submitted;
        b=Gg9jv/Yk9mVi0mNU/3sWjkXE5GOO7BbjHUAanPZA/tqOkEbcHk3pelFf4zRRt/xPr
         js937pLW/nlajYDUhgkkco91WKNbedZjpb91yb00erxIkCwGFYygUaAlPmj8m2/WRJ
         rWoHPyI+vVAZtFLlQRNqdQ0fOXNr1M+oMK+KynPE1JKdwsh/V85rpfBblp4Fcnv0aj
         /hvGbab1Vm8h6BYpGZaD5fDtXxPtl31Dosm6Jsj2lZR19nPPVA8pD/AhHtJLvIeoXI
         P4gSfep3tvEKQ/rQFT0kzAuFmZ9Wda/DLV+uAEfcfUSpxZv9XDXDCAXcoC50xyIIHl
         WXquRTKSK4i6g==
From:   Francisco Blas Izquierdo Riera (klondike) <klondike@klondike.es>
Subject: [PATCH v2] PCI: Add DMA alias for Intel Corporation 8 Series HECI
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-Id: <20221121164037.8C73110BB536@smtp.xiscosoft.net>
Date:   Mon, 21 Nov 2022 17:40:37 +0100 (CET)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI: Add function 7 DMA alias quirk for Intel Corporation 8 Series HECI.

Intel Corporation 8 Series HECIs include support for a CRB TPM 2.0
device. When the device is enabled on the BIOS, the TPM 2.0 device is
detected but the IOMMU prevents it from being accessed.

Even on a computer with a fixed DMAR table, device initialization
fails with DMA errors:
  DMAR: DRHD: handling fault status reg 3
  DMAR: [DMA Read NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x06] PTE Read access is not set
  DMAR: DRHD: handling fault status reg 2
  DMAR: [DMA Write NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x05] PTE Write access is not set
  DMAR: DRHD: handling fault status reg 2
  DMAR: [DMA Write NO_PASID] Request device [00:16.7] fault addr 0xdceff000 [fault reason 0x05] PTE Write access is not set
  tpm tpm0: Operation Timed out
  DMAR: DRHD: handling fault status reg 3
  tpm tpm0: Operation Timed out
  tpm_crb: probe of MSFT0101:00 failed with error -62

After patching the DMAR table and adding this patch, the TPM 2.0
device is initialized correctly and no DMA errors appear. Accessing
the TPM 2.0 PCR banks also works as expected.

Since most Haswell computers supporting this do not seem to have a
valid DMAR table patching the table with an appropriate RMRR is
usually also needed. I have published a blogpost describing the
process.

This patch currently adds the alias only for function 0. Since this
is the only function I have seen provided by the HECI on actual
hardware.


V2: Resent using a sendmail to fix tab mangling made by Thunderbird.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=108251
Link: https://klondike.es/klog/2022/11/21/patching-the-acpi-dmar-table-to-allow-tpm2-0/
Reported-by: Pierre Chifflier <chifflier@gmail.com>
Tested-by: Francisco Blas Izquierdo Riera (klondike) <klondike@klondike.es>
Signed-off-by: Francisco Blas Izquierdo Riera <klondike@klondike.es>
Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4162,6 +4162,22 @@
 			 0x0122, /* Plextor M6E (Marvell 88SS9183)*/
 			 quirk_dma_func1_alias);
 
+static void quirk_dma_func7_alias(struct pci_dev *dev)
+{
+	if (PCI_FUNC(dev->devfn) == 0)
+		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 7), 1);
+}
+
+/*
+ * Certain HECIs in Haswell systems support TPM 2.0. Unfortunately they
+ * perform DMA using the hidden function 7. Fixing this requires this
+ * alias and a patch of the DMAR ACPI table to include the appropriate
+ *  MTRR.
+ * https://bugzilla.kernel.org/show_bug.cgi?id=108251
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9c3a,
+			 quirk_dma_func7_alias);
+
 /*
  * Some devices DMA with the wrong devfn, not just the wrong function.
  * quirk_fixed_dma_alias() uses this table to create fixed aliases, where
