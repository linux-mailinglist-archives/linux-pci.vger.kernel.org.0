Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7579B37576C
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbhEFPfm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235761AbhEFPeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:34:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE35E616EC;
        Thu,  6 May 2021 15:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315175;
        bh=/+gs0ZSRDihhAytQvQhC3JU9pmLLRIVi8fOcngMUlsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBQZNg72+zIsTIei99cO7gRYKbGHxRUVBO5CGID3UxRoGYu+U85fMo2ixcw6GtMSZ
         +AJYhmcwD+5KVQJK6NAVIB2WZ2eMp91Y6fiY8/Gja5yIJ9QF/CSWZ2EUT8BfQtgX9J
         pvpjak348W8hfbPmhJa8KwXcv/XVWB8+3BTdCyvPn3wHrRojMRZncLBtANVl3fjGpJ
         sq54wrNotp0r3s9rKeERiwtQuwt7lMX6xJBL1alUyiltzld8XyRmfOzUx5xeJn5j0A
         GetZtoMwAO2cHe9UixL4dihnIMJcTEn3U9dkAp0BBmx0n8MvQkxBR6jg5a9wGIFEsc
         lKyZtsV/I0IaQ==
Received: by pali.im (Postfix)
        id 75174BF9; Thu,  6 May 2021 17:32:55 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 39/42] PCI: aardvark: Add comments for OB_WIN_ENABLE and ADDR_WIN_DISABLE
Date:   Thu,  6 May 2021 17:31:50 +0200
Message-Id: <20210506153153.30454-40-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a comment with explanation of these two bits. These comments are taken
from U-Boot 2020.10 PCI aardvark driver.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 3c18e139b095..ac3ee48e69d7 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -428,11 +428,24 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
 	advk_writel(pcie, reg, HOST_CTRL_INT_MASK_REG);
 
+	/*
+	 * Enable AXI address window location generation:
+	 * When it is enabled, the default outbound window
+	 * configurations (Default User Field: 0xD0074CFC)
+	 * are used to transparent address translation for
+	 * the outbound transactions. Thus, PCIe address
+	 * windows are not required.
+	 */
 	reg = advk_readl(pcie, PCIE_CORE_CTRL2_REG);
 	reg |= PCIE_CORE_CTRL2_OB_WIN_ENABLE;
 	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
 
-	/* Bypass the address window mapping for PIO */
+	/*
+	 * Bypass the address window mapping for PIO:
+	 * Since PIO access already contains all required
+	 * info over AXI interface by PIO registers, the
+	 * address window is not required.
+	 */
 	reg = advk_readl(pcie, PIO_CTRL);
 	reg |= PIO_CTRL_ADDR_WIN_DISABLE;
 	advk_writel(pcie, reg, PIO_CTRL);
-- 
2.20.1

