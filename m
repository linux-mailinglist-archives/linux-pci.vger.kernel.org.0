Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9705145324D
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 13:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhKPMkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 07:40:07 -0500
Received: from tomli.me ([31.220.7.45]:31118 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236306AbhKPMkF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 07:40:05 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 07:40:03 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 7130ef63;
        Tue, 16 Nov 2021 12:30:25 +0000 (UTC)
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO work) (221.219.136.22)
 by tomli.me (qpsmtpd/0.96) with ESMTPSA (AEAD-AES256-GCM-SHA384 encrypted); Tue, 16 Nov 2021 12:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=resent-from:resent-date:resent-message-id:resent-to:from:date:subject; s=1490979754; bh=KBfiT1w0XL11Z1fG5BYzBut0m+TzF/AfNmY64Lyh3Tk=; b=yKaAZBFD7DJrTT/M8n6HusL9M1/ruIi790LL/47aMOTz6naAMEwevu+4J2oMBH0hnQwcGwUCmxsuFi9LhLWSYBE9ioqnG5zophlHDLey5TKfO2eexYJqBoW7abP2oRul0tA1mPzZ0S0TwtmxQ9LMTYH9OKy/ouIH/JL24D7LEO6uJIVkT5bsm877OzwANgERr29npLatg3ZSpzOKqoZSI81HrQGkaJz+mYs/6fplWhk4QUekmB2miDlRR+8wLs+fdTku7aq4EL1vMsQVgWgYuBm7fXEDleNy+tUEhGKqgxb6rn9NxE54XDIlnJVhmBc6pTl0XqNemGrjVn9r3zopEw==
From:   Yifeng Li <tomli@tomli.me>
Date:   Mon, 15 Nov 2021 14:55:16 +0000
Subject: [PATCH] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA controller
Message-ID: <15293b9898bae404@tomli.me>
Apparently-To: <tomli@tomli.me>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
To:     unlisted-recipients:; (no To-header on input)

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

Reported-by: sbingner <sam@bingner.com>
Signed-off-by: Yifeng Li <tomli@tomli.me>
---
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
