Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE49375744
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhEFPdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235453AbhEFPdr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4FA4613EE;
        Thu,  6 May 2021 15:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315168;
        bh=zoiVY2XI6nExpUKOXT9A0hPboS1rFrKCjUz6eR0Qm/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWR1wIeo72aTtyzz5OLdJt76iqVyuXbceGj5Q/uy61i57HtsZ+9M/68WFGLZVmVdL
         lP6mcXCe/m7gYGy7wPMO/0uGwUM3eWPvwFi8Bvvqo5kOYIN8n/2OFZr/yrF8ykeLf6
         rFcq87GBCQzC7jqHlwRwGhQ9ejlGRq8hzt6BI9R9s2XCVZy+jBl78cTAgE2uiBsICa
         9OPd4hsI5zUrA/P7U4JWDEpfku/xLArJrGEnRUIyysATpQ8hbiAkHJC/wWEGVqFqHQ
         9X2W8YwGV4iKY0ApEIqMLY0vyw3jVWpXBwFGhgIg9MDP7m7JmkDOj/JOQxXg8O2Ys2
         WDlvbGFWcNYlw==
Received: by pali.im (Postfix)
        id 7BDF98A1; Thu,  6 May 2021 17:32:48 +0200 (CEST)
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
Subject: [PATCH 15/42] PCI: aardvark: Change name of INTx irq_chip to advk-INT
Date:   Thu,  6 May 2021 17:31:26 +0200
Message-Id: <20210506153153.30454-16-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This name is visible in /proc/interrupts file and for better reading it
should have at most 8 characters. Also there is no need to allocate this
name dynamically, since there is only one PCIe controller on Armada 37xx.
This aligns with how the MSI irq_chip in this driver names it's interrupt
("advk-MSI").

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 08f1157e1c5e..c50421af9d06 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1022,14 +1022,7 @@ static int advk_pcie_init_irq_domain(struct advk_pcie *pcie)
 	}
 
 	irq_chip = &pcie->irq_chip;
-
-	irq_chip->name = devm_kasprintf(dev, GFP_KERNEL, "%s-irq",
-					dev_name(dev));
-	if (!irq_chip->name) {
-		ret = -ENOMEM;
-		goto out_put_node;
-	}
-
+	irq_chip->name = "advk-INT";
 	irq_chip->irq_mask = advk_pcie_irq_mask;
 	irq_chip->irq_unmask = advk_pcie_irq_unmask;
 
-- 
2.20.1

