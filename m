Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CED453438
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 15:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKPOfi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 09:35:38 -0500
Received: from tomli.me ([31.220.7.45]:17872 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237383AbhKPOfd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 09:35:33 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 4f345bd1;
        Tue, 16 Nov 2021 14:32:33 +0000 (UTC)
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO work) (221.219.136.22)
 by tomli.me (qpsmtpd/0.96) with ESMTPSA (AEAD-AES256-GCM-SHA384 encrypted); Tue, 16 Nov 2021 14:32:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:subject:message-id:mime-version:content-type; s=1490979754; bh=uRYxxnQe24Rgwi722KS30HiLpHAXqmuIhCb6oiw2y+A=; b=B9grhZl3PZAvz1QQ7CecQGPSITtjBgq97mIYrfhe+LepFe6vHBDmcFJ7+wzmKI0fPE8eC/iOhQJdFplDGvnk2J7Gehum6JyqkBNiH0EvMHMua/w1RjaOqR1Ab9Cw3JnVUitpmIvDKNIKjxdJfeyTdRgDZ2mFtBP+g66A/orYpBGwJN0fbUTryiUD3NCC9LF3QmJ1bfcr7vwAIk3SacUF6pENEDc9u5mZpZYZNx/YVOOV6iSC0Aj+orHaqhj8uE439WvDPwg+RF7DRm7zXjzkzoU7MuqjqAXrZqBbDrd/Hy4EdYyM3HE+/ivvGJjdf5vo66W5eNyc02Wb/nLGUQIfWQ==
Date:   Tue, 16 Nov 2021 14:32:26 +0000
From:   Yifeng Li <tomli@tomli.me>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: Add func1 DMA quirk for Marvell 88SE9125 SATA
 controller
Message-ID: <YZPA+gSsGWI6+xBP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
Reported-by: sbingner <sam@bingner.com>
Tested-by: sbingner <sam@bingner.com>
Tested-by: Yifeng Li <tomli@tomli.me>
Signed-off-by: Yifeng Li <tomli@tomli.me>
---

Notes:
    I accidentally sent an earlier version of the commit without CCing
    stable@vger.kernel.org. The mail itself was also rejected by
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
