Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D250544722E
	for <lists+linux-pci@lfdr.de>; Sun,  7 Nov 2021 09:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbhKGIf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 03:35:56 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:63607 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbhKGIf4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 03:35:56 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id jdbymh7FXsoWhjdbym9Yyc; Sun, 07 Nov 2021 09:33:12 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 07 Nov 2021 09:33:12 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nsaenz@kernel.org, jim2101024@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PCI: brcmstb: Declare a bitmap as a bitmap, not as a plain 'unsigned long'
Date:   Sun,  7 Nov 2021 09:32:58 +0100
Message-Id: <e6d9da2112aab2939d1507b90962d07bfd735b4c.1636273671.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The 'used' field of 'struct brcm_msi' is used as a bitmap. So it should
be declared as so (i.e. unsigned long *).

This fixes an harmless Coverity warning about array vs singleton usage.

This bitmap can be BRCM_INT_PCI_MSI_LEGACY_NR or BRCM_INT_PCI_MSI_NR long.
So, while at it, document it, should it help someone in the future.

Addresses-Coverity: "Out-of-bounds access (ARRAY_VS_SINGLETON)"
Suggested-by: Krzysztof Wilczynski <kw@linux.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The BUILD_BUG_ON is surely a bit to much of paranoia :)

I'm also not really pleased about the layout of the DECLARE_BITMAP. This
looks odd, but I couldn't find something nicer :(
---
 drivers/pci/controller/pcie-brcmstb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1fc7bd49a7ad..15d394ac7478 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -266,8 +266,9 @@ struct brcm_msi {
 	struct mutex		lock; /* guards the alloc/free operations */
 	u64			target_addr;
 	int			irq;
-	/* used indicates which MSI interrupts have been alloc'd */
-	unsigned long		used;
+	/* Used indicates which MSI interrupts have been alloc'd. 'nr' bellow is
+	   the real size of the bitmap. It depends on the chip. */
+	DECLARE_BITMAP		(used, BRCM_INT_PCI_MSI_NR);
 	bool			legacy;
 	/* Some chips have MSIs in bits [31..24] of a shared register. */
 	int			legacy_shift;
@@ -534,7 +535,7 @@ static int brcm_msi_alloc(struct brcm_msi *msi)
 	int hwirq;
 
 	mutex_lock(&msi->lock);
-	hwirq = bitmap_find_free_region(&msi->used, msi->nr, 0);
+	hwirq = bitmap_find_free_region(msi->used, msi->nr, 0);
 	mutex_unlock(&msi->lock);
 
 	return hwirq;
@@ -543,7 +544,7 @@ static int brcm_msi_alloc(struct brcm_msi *msi)
 static void brcm_msi_free(struct brcm_msi *msi, unsigned long hwirq)
 {
 	mutex_lock(&msi->lock);
-	bitmap_release_region(&msi->used, hwirq, 0);
+	bitmap_release_region(msi->used, hwirq, 0);
 	mutex_unlock(&msi->lock);
 }
 
@@ -661,6 +662,12 @@ static int brcm_pcie_enable_msi(struct brcm_pcie *pcie)
 	msi->irq = irq;
 	msi->legacy = pcie->hw_rev < BRCM_PCIE_HW_REV_33;
 
+	/*
+	 * Sanity check to make sure that the 'used' bitmap in struct brcm_msi
+	 * is large enough.
+	 */
+	BUILD_BUG_ON(BRCM_INT_PCI_MSI_LEGACY_NR > BRCM_INT_PCI_MSI_NR);
+
 	if (msi->legacy) {
 		msi->intr_base = msi->base + PCIE_INTR2_CPU_BASE;
 		msi->nr = BRCM_INT_PCI_MSI_LEGACY_NR;
-- 
2.30.2

