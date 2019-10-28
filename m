Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1A7E763C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbfJ1QdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41392 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id g81so6399615oib.8;
        Mon, 28 Oct 2019 09:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y8FNka9VqW+GuyHhrg3YYeRr9rwrH+ifXsb5oKqpMlo=;
        b=quOp+Wj+X/WnwH/353nM+Hv6mTyrNSmGLT3+gh3mTwiAZnzczGMR1NaZQigTqj3VH7
         dcVMtwC1zY2Rjrx//AvDR2jOg7+c+Dqx6QhiNgl8MaoPV8sKjmHSKNpQzlj0KC+iJhh3
         Q2pV0fXSfdD7OkGyHwpVYuGAHM+vEGeHz4W6v+G49dP6+ZrpPdKXjx9k/1nfnshgStaK
         cC0CP/ih+6dxfO4GBBIphed7GeJshH+/G3SI1+0ScBlY68YKFZ24t524X5y/mVlEiFOZ
         QwfZ4tMtJ7eL+KJRL5PnYG+/nfPcDrPVQOC6xF5oBELpEpZ2kClitUkMeJnEweL0C1vs
         dXSA==
X-Gm-Message-State: APjAAAWwXBuTy/VQ8DkWgLrzkkUo2JW1zUN3Gp6Ki99X+/qOBrht8D0t
        gmVI5BKqMdc5mBJDbX98QQ==
X-Google-Smtp-Source: APXvYqyUIRHPK2FSnzpcsAJEGlsEmDJCiz/greX4s1l3COXvilcvI5rrPN21yJJxsAwhuvZFPOfz2Q==
X-Received: by 2002:a05:6808:ab1:: with SMTP id r17mr118801oij.75.1572280385099;
        Mon, 28 Oct 2019 09:33:05 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 03/25] PCI: aardvark: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:34 -0500
Message-Id: <20191028163256.8004-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert aardvark to use the common pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Remove the temporary list
---
 drivers/pci/controller/pci-aardvark.c | 60 ++-------------------------
 1 file changed, 4 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index fc0fe4d4de49..9cbeba507f0c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -186,7 +186,6 @@
 struct advk_pcie {
 	struct platform_device *pdev;
 	void __iomem *base;
-	struct list_head resources;
 	struct irq_domain *irq_domain;
 	struct irq_chip irq_chip;
 	struct irq_domain *msi_domain;
@@ -910,63 +909,11 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
-{
-	int err, res_valid = 0;
-	struct device *dev = &pcie->pdev->dev;
-	struct resource_entry *win, *tmp;
-	resource_size_t iobase;
-
-	INIT_LIST_HEAD(&pcie->resources);
-
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, &iobase);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, &pcie->resources);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry_safe(win, tmp, &pcie->resources) {
-		struct resource *res = win->res;
-
-		switch (resource_type(res)) {
-		case IORESOURCE_IO:
-			err = devm_pci_remap_iospace(dev, res, iobase);
-			if (err) {
-				dev_warn(dev, "error %d: failed to map resource %pR\n",
-					 err, res);
-				resource_list_destroy_entry(win);
-			}
-			break;
-		case IORESOURCE_MEM:
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-			break;
-		case IORESOURCE_BUS:
-			pcie->root_bus_nr = res->start;
-			break;
-		}
-	}
-
-	if (!res_valid) {
-		dev_err(dev, "non-prefetchable memory resource required\n");
-		err = -EINVAL;
-		goto out_release_res;
-	}
-
-	return 0;
-
-out_release_res:
-	pci_free_resource_list(&pcie->resources);
-	return err;
-}
-
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
-	struct resource *res;
+	struct resource *res, *bus;
 	struct pci_host_bridge *bridge;
 	int ret, irq;
 
@@ -991,11 +938,13 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = advk_pcie_parse_request_of_pci_ranges(pcie);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      &bus);
 	if (ret) {
 		dev_err(dev, "Failed to parse resources\n");
 		return ret;
 	}
+	pcie->root_bus_nr = bus->start;
 
 	advk_pcie_setup_hw(pcie);
 
@@ -1014,7 +963,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
 	bridge->busnr = 0;
-- 
2.20.1

