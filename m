Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84BE763E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732978AbfJ1QdI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37013 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id y194so1822446oie.4;
        Mon, 28 Oct 2019 09:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2xpUbChHFjHyLZeTvcqjOOLjHW6EiB7rU1pguJS2Eg=;
        b=r9TTe8iQM2Y2K+5+c1im6s2qjoTvjmw/AW67bIsWp2GoaOVQWkGQVc56XIm/UZBFKD
         8gYg/WCflTASK9gK9D276gXmS6gCokb8yznE/svFM5p/hMhf+ziv6VhGB4okQnyGYpev
         1doj0BJcSIFlbrvuX8QFsnz9X1tYerl6zdpUHLrY769rh0PP9h/pZw2j5Ie7XgymuMgY
         Y/b9l5ebI4Mb14Uccncz9iIKQADozXW92mAdOU+pQzIvnLnsWA87zc5QUuA2n4l8UOxK
         GDs+56XQtl35VUz+kVDSBOlaxyMWelv9FeEfSDqZqtvQf0DZ2HHls89rjh26lML2GHHu
         xhig==
X-Gm-Message-State: APjAAAXac+peCtkcOBZinMkNAKmwFw7HWbwSG+VErNnLaSBi5xKCtQXN
        iOgTRvo0nl8d9AkAZUNEhIRdyTQ=
X-Google-Smtp-Source: APXvYqxZ8ey0YEh8bAOZGGeVRLpA2ZABAh6GC8RKam9rkxWgH4qFebetMS5T/qIzXrvDlJgloyLHhA==
X-Received: by 2002:a05:6808:1c7:: with SMTP id x7mr122892oic.67.1572280387584;
        Mon, 28 Oct 2019 09:33:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:06 -0700 (PDT)
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
Subject: [PATCH v3 04/25] PCI: altera: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:35 -0500
Message-Id: <20191028163256.8004-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert altera host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list first. Just
use bridge->windows directly and remove all the temporary list handling.

If an I/O range is present, then it will now be mapped. It's expected
that h/w which doesn't support I/O range will not define one.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: rfi@lists.rocketboards.org
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Remove temporary resource list
---
 drivers/pci/controller/pcie-altera.c | 41 ++--------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index d2497ca43828..ba025efeae28 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -92,7 +92,6 @@ struct altera_pcie {
 	u8			root_bus_nr;
 	struct irq_domain	*irq_domain;
 	struct resource		bus_range;
-	struct list_head	resources;
 	const struct altera_pcie_data	*pcie_data;
 };
 
@@ -670,39 +669,6 @@ static void altera_pcie_isr(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int altera_pcie_parse_request_of_pci_ranges(struct altera_pcie *pcie)
-{
-	int err, res_valid = 0;
-	struct device *dev = &pcie->pdev->dev;
-	struct resource_entry *win;
-
-	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
-						    &pcie->resources, NULL);
-	if (err)
-		return err;
-
-	err = devm_request_pci_bus_resources(dev, &pcie->resources);
-	if (err)
-		goto out_release_res;
-
-	resource_list_for_each_entry(win, &pcie->resources) {
-		struct resource *res = win->res;
-
-		if (resource_type(res) == IORESOURCE_MEM)
-			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-	}
-
-	if (res_valid)
-		return 0;
-
-	dev_err(dev, "non-prefetchable memory resource required\n");
-	err = -EINVAL;
-
-out_release_res:
-	pci_free_resource_list(&pcie->resources);
-	return err;
-}
-
 static int altera_pcie_init_irq_domain(struct altera_pcie *pcie)
 {
 	struct device *dev = &pcie->pdev->dev;
@@ -833,9 +799,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	INIT_LIST_HEAD(&pcie->resources);
-
-	ret = altera_pcie_parse_request_of_pci_ranges(pcie);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows,
+					      NULL);
 	if (ret) {
 		dev_err(dev, "Failed add resources\n");
 		return ret;
@@ -853,7 +818,6 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
 	altera_pcie_host_init(pcie);
 
-	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
@@ -884,7 +848,6 @@ static int altera_pcie_remove(struct platform_device *pdev)
 
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
-	pci_free_resource_list(&pcie->resources);
 	altera_pcie_irq_teardown(pcie);
 
 	return 0;
-- 
2.20.1

