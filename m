Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AAF375745
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhEFPdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235460AbhEFPdr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15D12613E3;
        Thu,  6 May 2021 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315169;
        bh=qGv5xT5gD11qmr1DVmxcsAYsbpUCl4ZOEgFpdd7GuZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcczHnvLIHF6Yfx/K/MGhuGZyKTj2egYnSsbv/FT+g6FvPAVLwvBljubTWSu0MLC/
         8cJ5tvUC4mbyvkJlm76qAUB8QGJ6/Eudcc3qTnBMBkv/HRuGb1c3DlG5vGWR1ludqo
         uLZDbsTHo8YXU9pMepGBdLgGHvji8yxuge/lIi57C24hDVnOadn9S0A2FtuiC67Tk7
         H1nnRear0F2QjTLUDwPcBS7Dqd2hqNSIB8+N8z/Y2DAJxvJJDzU/2ZzOvglFPBvDt8
         ouxkk52VzJ33d3sj67QQtdVtGTZmuXMyPAmLYGsv/VaFcJn/pbqrcsKjsberwgqd2w
         RuPj0zexOE0NQ==
Received: by pali.im (Postfix)
        id C357A732; Thu,  6 May 2021 17:32:48 +0200 (CEST)
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
Subject: [PATCH 16/42] PCI: aardvark: Remove unneeded goto
Date:   Thu,  6 May 2021 17:31:27 +0200
Message-Id: <20210506153153.30454-17-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Simplify advk_pcie_init_irq_domain() function.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index c50421af9d06..366d7480bc1b 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1013,7 +1013,6 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	struct device_node *node = dev->of_node;
 	struct device_node *pcie_intc_node;
 	struct irq_chip *irq_chip;
-	int ret = 0;
 
 	pcie_intc_node =  of_get_next_child(node, NULL);
 	if (!pcie_intc_node) {
@@ -1029,15 +1028,15 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	pcie->irq_domain =
 		irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
 				      &advk_pcie_irq_domain_ops, pcie);
+
+	of_node_put(pcie_intc_node);
+
 	if (!pcie->irq_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
-		ret = -ENOMEM;
-		goto out_put_node;
+		return -ENOMEM;
 	}
 
-out_put_node:
-	of_node_put(pcie_intc_node);
-	return ret;
+	return 0;
 }
 
 static void advk_pcie_remove_irq_domain(struct advk_pcie *pcie)
-- 
2.20.1

