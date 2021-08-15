Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821E83EC89C
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbhHOKhg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 06:37:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237628AbhHOKhX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 06:37:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BF93610C9;
        Sun, 15 Aug 2021 10:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629023813;
        bh=bbXZK0g3pZ6TC4QJ8y6NJ9nDgPzEQHXGdZWtHIWYSIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcdCaMg6wlfDiUdaXKSZmzSh5IDF6yaACXWv1OdiW7+ceHZnRMrqkaqSxdmE15NYZ
         7O8VHfk+wx1qaVWwX2YfQR4EXhs8NlFPe96OUZQ6LccNbMKGeSWFl2AZl18nu0Yh1U
         5HOAFUU3wnqF/ZkLnXB9eKXnupYskhgPobA5RrfgXuvxf4g/IqCAf38XqJhgnqJcnp
         zhT6mqkILfhSYppPYSvaEXv7YXonSCug/a+/hX1BuQWlNbJYjAJDYpceo+gkR/ZsiI
         7Biqbl64NziUj9s721apXHjy88Qtdcl/CcPi+l4bOxLkAKb89CPo/A3VYNuWXyZj5j
         H6guz08aFZ4Rg==
Received: by pali.im (Postfix)
        id 2BFC3280D; Sun, 15 Aug 2021 12:36:51 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] PCI: aardvark: Fix reading MSI interrupt number
Date:   Sun, 15 Aug 2021 12:36:22 +0200
Message-Id: <20210815103624.19528-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210815103624.19528-1-pali@kernel.org>
References: <20210815103624.19528-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Experiments showed that in register PCIE_MSI_PAYLOAD_REG is stored number
of the last received MSI interrupt and not number of MSI interrupt which
belongs to msi_idx bit. Therefore this implies that aardvark HW can cache
only bits [4:0] of received MSI interrupts with effectively means that it
supports only MSI interrupts with numbers 0-31.

Do not read PCIE_MSI_PAYLOAD_REG register for determining MSI interrupt
number. Instead ensure that pci-aardvark.c configures only MSI numbers in
range 0-31 and then msi_idx contains correct received MSI number.

Signed-off-by: Pali Rohár <pali@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 5e4febdbdd33..bacfccee44fe 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1199,7 +1199,6 @@ static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
 static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 {
 	u32 msi_val, msi_mask, msi_status, msi_idx;
-	u16 msi_data;
 	int virq;
 
 	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
@@ -1210,17 +1209,13 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
 		if (!(BIT(msi_idx) & msi_status))
 			continue;
 
-		/*
-		 * msi_idx contains bits [4:0] of the msi_data and msi_data
-		 * contains 16bit MSI interrupt number from MSI inner domain
-		 */
 		advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG);
-		msi_data = advk_readl(pcie, PCIE_MSI_PAYLOAD_REG) & PCIE_MSI_DATA_MASK;
-		virq = irq_find_mapping(pcie->msi_inner_domain, msi_data);
+
+		virq = irq_find_mapping(pcie->msi_inner_domain, msi_idx);
 		if (virq)
 			generic_handle_irq(virq);
 		else
-			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%04hx\n", msi_data);
+			dev_err_ratelimited(&pcie->pdev->dev, "unexpected MSI 0x%02x\n", msi_idx);
 	}
 
 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING,
-- 
2.20.1

