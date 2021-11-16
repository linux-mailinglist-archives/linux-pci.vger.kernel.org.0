Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571B6453746
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 17:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhKPQZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 11:25:43 -0500
Received: from tomli.me ([31.220.7.45]:48015 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhKPQZn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 11:25:43 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 6fb07e06;
        Tue, 16 Nov 2021 16:22:44 +0000 (UTC)
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO work) (221.219.136.22)
 by tomli.me (qpsmtpd/0.96) with ESMTPSA (AEAD-AES256-GCM-SHA384 encrypted); Tue, 16 Nov 2021 16:22:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:subject:message-id:mime-version:content-type:content-transfer-encoding; s=1490979754; bh=bOCrpZ2RjHxF2pFYdnVUvO3AaF9fNozXR7lvIsSGFCw=; b=ppTeRYfzWYaOLPE8m81mZC8HibAy44hC8p+GzDjqJGZVJTgaAOAuh7UzlZpB9AKPH8xSPMqH5Ew5TSG5XwezlRk8AK8TX7CTCcfoD/m1qysoXok4YfLKkmmHfkmLO/kpNlodIrVuCL+Bug6jw4Xa4Z64yVUB2LtfFXmGY5OCYGBh+gUzLffW7vWQ/QcTRZLnX6m/kIz+xjiCs+dRdoGzgbE4vwFfQKVtc1gtuY4y+vbjDo5EvGCykzv19uYlpGThQ5kLYrdVMiQfjnX0rm1f1BE2kz1LctwZm4uwWEpPFr4+WZR3HWjV4I43tmT5EmMXcO+LlRfKGuMcW49PFTof5w==
Date:   Tue, 16 Nov 2021 16:22:38 +0000
From:   Yifeng Li <tomli@tomli.me>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <YZPazpc0/uUiFL/n@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Like other SATA controller chips in the Marvell 88SE91xx series, the
Marvell 88SE9125 has the same DMA requester ID hardware bug that prevents
it from working under IOMMU. This patch adds its device ID 0x9125 to the
Function 1 DMA alias quirk list.

This patch should not be confused with an earlier patch, commit 059983790a4c
("PCI: Add function 1 DMA alias quirk for Marvell 9215 SATA controller"),
which applies to a different chip with a similar model number, 88SE9215.

Without this patch, device initialization fails with DMA errors.

    ata8: softreset failed (1st FIS failed)
    DMAR: DRHD: handling fault status reg 2
    DMAR: [DMA Write NO_PASID] Request device [03:00.1] fault addr 0xfffc0000 [fault reason 0x02] Present bit in context entry is clear
    DMAR: DRHD: handling fault status reg 2
    DMAR: [DMA Read NO_PASID] Request device [03:00.1] fault addr 0xfffc0000 [fault reason 0x02] Present bit in context entry is clear

After applying the patch, the controller can be successfully initialized.

    ata8: SATA link up 1.5 Gbps (SStatus 113 SControl 330)
    ata8.00: ATAPI: PIONEER BD-RW   BDR-207M, 1.21, max UDMA/100
    ata8.00: configured for UDMA/100
    scsi 7:0:0:0: CD-ROM            PIONEER  BD-RW   BDR-207M 1.21 PQ: 0 ANSI: 5

Cc: stable@vger.kernel.org
Reported-by: Sam Bingner <sam@bingner.com>
Tested-by: Sam Bingner <sam@bingner.com>
Tested-by: Yifeng Li <tomli@tomli.me>
Signed-off-by: Yifeng Li <tomli@tomli.me>
Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
---

Notes:
    v3: Use full names in Reported-by and Tested-by tags.
    
    v2: I accidentally sent an earlier version of the commit without
    CCing stable@vger.kernel.org. The mail itself was also rejected by
    many servers due to a DKIM issue. Thus [PATCH v2], sorry for the
    noise.

 drivers/pci/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c73..20a932690 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4103,6 +4103,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9120,
 			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9123,
 			 quirk_dma_func1_alias);
+/* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c136 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9125,
+			 quirk_dma_func1_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MARVELL_EXT, 0x9128,
 			 quirk_dma_func1_alias);
 /* https://bugzilla.kernel.org/show_bug.cgi?id=42679#c14 */
-- 
2.31.1
