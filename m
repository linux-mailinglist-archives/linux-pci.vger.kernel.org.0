Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4FD9AD9
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfJPUHA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:07:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34045 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfJPUHA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:07:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so21320678otp.1;
        Wed, 16 Oct 2019 13:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIj9ILT7VVE9OfDmkYQ8ktnxwCT3rx9dL7R3IKVsvuI=;
        b=MRWusENvwT/a+0wwLewlEIqtke13CKjmAn2W/1XkuKWehPXrASS+XM2/Cdk+hODflJ
         bGDkh9LSrIQmUVWACEAcXoTRfxmvg+ChJA0wnQyDP6DJjxb2/K3oUKtDs9EqVFDLv2My
         SBIuTQ7eZDCWnj0AdBLVtRZlaKo2p7MZgUOBWBcVyiWSMROO7ogM5l6vzzUMWILz0QAG
         yk5lCg6LNk1H3ea3T9+UfCHGPILYmSR4LboYnY3c29XUdpPDzBkTLGLnHI3yBAhyzGnc
         +h1lERBGVv/WhLRdlkJF4Ak32+n2Mvex0aKLfJ8A5MRF7JUfwHTublUEASixxx47oU/A
         4SEA==
X-Gm-Message-State: APjAAAWqx3j6Wae8jRs8p5vo1vpBnYNhFtegxAiNsOgsAtqB8btucC2m
        7Cm/rsbwBPGZU+bKIHHj5w==
X-Google-Smtp-Source: APXvYqxoimT0iMDdNMBOkPALG3bNj2ukak3LOt++z8YyoJ8J+qkFKwFheJMFoSp4/qlthDVO+w/7CQ==
X-Received: by 2002:a9d:61cd:: with SMTP id h13mr49260otk.84.1571256418364;
        Wed, 16 Oct 2019 13:06:58 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:06:57 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
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
Subject: [PATCH v2 04/25] PCI: altera: Use pci_parse_request_of_pci_ranges()
Date:   Wed, 16 Oct 2019 15:06:26 -0500
Message-Id: <20191016200647.32050-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
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

