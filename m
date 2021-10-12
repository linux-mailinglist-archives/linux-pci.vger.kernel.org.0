Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B345C42A9BE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhJLQny (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230148AbhJLQny (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7159361076;
        Tue, 12 Oct 2021 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056912;
        bh=bVdFcbLnOJnY2aUH/T5B3G9D+/EQBtky0JV3WGLfMvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESFau0lJMz9VP4T0otjgKPBQQvVRfPaN3A9SfZS5wWzcEkEDycmj2PEGVH/wCi1TA
         n3MxF9zNLOwjHXs8ZzoZ5m5SftxS/kp2YPx5pjycN9ywqqZV7k7WmFnx2RDTspJ6R2
         IUonKgT/IiFNl5w7Y6FlrunTekcXZedM3Y/y8B8rqFtqvju3tn0CkoURFhavp2lHy8
         f1VsDrtNUze9XMlUODZGw19Nj6v5mAH0TQ9DPFpRDjyWC+AJS9wQZ7bLTqyIAR5uzy
         31umG1rpMn4nIFZp/092xrB1nVL8Q1dOlemuo8FA0CigoJOJWATTJsC2e4aYoPLi9x
         HMF4PZJwB7vcw==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 03/14] PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG
Date:   Tue, 12 Oct 2021 18:41:34 +0200
Message-Id: <20211012164145.14126-4-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211012164145.14126-1-kabel@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
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
Reviewed-by: Marek Behún <kabel@kernel.org>
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

