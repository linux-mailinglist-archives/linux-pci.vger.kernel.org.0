Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7243E8B3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhJ1S7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhJ1S7d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97876610CA;
        Thu, 28 Oct 2021 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447426;
        bh=cIk5CTmQGMvBuZSubVxd7w+ybwyutKyYpsutNgifE1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WibUL8601yx7NaIOHXp5mcqSdskYmf6uyUmrVQfMIhMDjPq3fpDHh2ITay2vdCAgi
         ZuJfvw7WtqqyqgzQrJsz8ODQ7rDwbAv01K5RXy4Ogx7jp96bFo3dLAQShVFwjxbauF
         cjn7hzw92y0wMRpjkdVwGi5KZTmxIy+PwtFmG9KLHIkrXgWPuFAkZZdBeI1MyNlwSW
         w+Snz9sDfCrnGav9EmR1FDT/slIrynsWOK/ypPjXdICJ1JAKg6da/PINogygAERmYd
         JZbZKwyckQYg6EgsSeUzxsmLvPnGXA1xjRIj8+w1vltqtmjfwYozKF/vduUTk+SPzc
         qmCC8l++H49Kg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 3/7] PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG
Date:   Thu, 28 Oct 2021 20:56:55 +0200
Message-Id: <20211028185659.20329-4-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211028185659.20329-1-kabel@kernel.org>
References: <20211028185659.20329-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIE_MSI_PAYLOAD_REG contains 16-bit MSI number, not only lower
8 bits. Fix reading content of this register and add a comment
describing the access to this register.

Fixes: 8c39d710363c ("PCI: aardvark: Add Aardvark PCI host controller driver")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b45ff2911c80..389ebba1dd9b 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -119,6 +119,7 @@
 #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
 #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
 #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
+#define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
 
 /* PCIe window configuration */
 #define OB_WIN_BASE_ADDR			0x4c00
@@ -1319,8 +1320,12 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
+		/*
+		 * msi_idx contains bits [4:0] of the msi_data and msi_data
+		 * contains 16bit MSI interrupt number
+		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & 0xFF;
+		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
 		generic_handle_irq(msi_data);
 	}
 
-- 
2.32.0

