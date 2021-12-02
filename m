Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF98465E4B
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 07:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbhLBGiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 01:38:54 -0500
Received: from tomli.me ([31.220.7.45]:12778 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240839AbhLBGix (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 01:38:53 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id ca9aa9be;
        Thu, 2 Dec 2021 06:35:29 +0000 (UTC)
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO work) (123.118.114.103)
 by tomli.me (qpsmtpd/0.96) with ESMTPSA (AEAD-AES256-GCM-SHA384 encrypted); Thu, 02 Dec 2021 06:35:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=1490979754; bh=bOCrpZ2RjHxF2pFYdnVUvO3AaF9fNozXR7lvIsSGFCw=; b=XgzS5bE/Zsljd92Q5lqyRkv/djF3PV4pmEKe3ipRAkMbslgUUn1KKBJgQ1phCgntMGmV5IfOB4i+FUl3HezGQYA/28IOHpxlPFArSC7tx4lAgJm9gvIHpgwdG9Pr58JCqLqgjMq6Aw/r+zxT1lvTksAnZ7LzHrSeSZSPJLAO8prxniZAE4ppyqN65HgAGozwIsNhZJBNNDnFj7bzZBAYZOj7NpZ/rxtsmt1bIa077LZ0Olo6uQHFVKCZSnTz4KfascwRlR9a/ZC5VFdS5oQnO0B+1TbZ2h+Gn65OaP6vrDZnedkKwM+0ldZ4OvKJFpCC5ezCgs6m8z/9vVf1zka4Gw==
Date:   Thu, 2 Dec 2021 06:35:21 +0000
From:   Yifeng Li <tomli@tomli.me>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sam Bingner <sam@bingner.com>, linux-pci@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 RESEND] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <YahpKVR+McJVDdkD@work>
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
