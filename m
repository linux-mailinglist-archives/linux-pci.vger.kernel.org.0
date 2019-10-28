Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3EDEE7644
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbfJ1QdQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46655 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id c2so6374691oic.13;
        Mon, 28 Oct 2019 09:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YIfpHXHDoS6BpoLM/5OtgGD1veZ0kiS1z+l67O5mhv0=;
        b=stzsuHe0hPWnVaIAsKn2V+F0fPyQG0OsT9ESdLuEXD9EvkfFGrMp1tExIVWfoHsuyS
         Cz6Rsqr37WOMy7+FA0/3dlpQgegXOobsx1Kb33iUKQmBuuxxWVaLoSGMszthaF3vdD6f
         aG2ombLVT4xf1PXRCDacLMvGadfIT2zOt3wVyHvJ0MFrGhsa/TJqaeM2a3kuozahWrYa
         nHtS/f+qntrT9PSjUpoSrKyjjxIlPE/bvqKLL0KOt5aDUKJwPHBRgLJfAb3RtteS/rNb
         BPB2WPeGkMv0wRk7F1d6DOcMsg+tW6axxB4yQHcJ6pRbOy7CLwD4/KPlPM+8TtlPBOSO
         BkPw==
X-Gm-Message-State: APjAAAVeuMpXhuq0F9ibUKqJif9vaOK+AAhQQfIGQ3ZLZEy43ony2jT0
        uNHZkxFhPCuH2ftFoXg+hQ==
X-Google-Smtp-Source: APXvYqwiII4tT6mUV/WZPdOOYCJP3razv09fHNkFp9JLAVkZPyu7pCRKafjRWtkftQVgR7SzFninKQ==
X-Received: by 2002:aca:494e:: with SMTP id w75mr95048oia.159.1572280394774;
        Mon, 28 Oct 2019 09:33:14 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:14 -0700 (PDT)
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
Subject: [PATCH v3 07/25] PCI: iproc: Use pci_parse_request_of_pci_ranges()
Date:   Mon, 28 Oct 2019 11:32:38 -0500
Message-Id: <20191028163256.8004-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the iProc host bridge to use the common
pci_parse_request_of_pci_ranges().

There's no need to assign the resources to a temporary list, so just use
bridge->windows directly.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pcie-iproc-platform.c | 8 ++------
 drivers/pci/controller/pcie-iproc.c          | 5 -----
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
index 9ee6200a66f4..375d815f7301 100644
--- a/drivers/pci/controller/pcie-iproc-platform.c
+++ b/drivers/pci/controller/pcie-iproc-platform.c
@@ -43,8 +43,6 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	struct iproc_pcie *pcie;
 	struct device_node *np = dev->of_node;
 	struct resource reg;
-	resource_size_t iobase = 0;
-	LIST_HEAD(resources);
 	struct pci_host_bridge *bridge;
 	int ret;
 
@@ -97,8 +95,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 	if (IS_ERR(pcie->phy))
 		return PTR_ERR(pcie->phy);
 
-	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
-						    &iobase);
+	ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
 	if (ret) {
 		dev_err(dev, "unable to get PCI host bridge resources\n");
 		return ret;
@@ -113,10 +110,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
 		pcie->map_irq = of_irq_parse_and_map_pci;
 	}
 
-	ret = iproc_pcie_setup(pcie, &resources);
+	ret = iproc_pcie_setup(pcie, &bridge->windows);
 	if (ret) {
 		dev_err(dev, "PCIe controller setup failed\n");
-		pci_free_resource_list(&resources);
 		return ret;
 	}
 
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 2d457bfdaf66..223335ee791a 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1498,10 +1498,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		return ret;
 	}
 
-	ret = devm_request_pci_bus_resources(dev, res);
-	if (ret)
-		return ret;
-
 	ret = phy_init(pcie->phy);
 	if (ret) {
 		dev_err(dev, "unable to initialize PCIe PHY\n");
@@ -1543,7 +1539,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		if (iproc_pcie_msi_enable(pcie))
 			dev_info(dev, "not using iProc MSI\n");
 
-	list_splice_init(res, &host->windows);
 	host->busnr = 0;
 	host->dev.parent = dev;
 	host->ops = &iproc_pcie_ops;
-- 
2.20.1

