Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31996228DFF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 04:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgGVCZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 22:25:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37227 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731053AbgGVCZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 22:25:29 -0400
Received: by mail-io1-f67.google.com with SMTP id v6so878241iob.4;
        Tue, 21 Jul 2020 19:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v7XJhzTA6102delF3DpjIqYKFtilWigh34GV7eTcdd0=;
        b=MOo9gBtnxojsaTqkN9Vqr7afHSEpuZuGK2uT8zuR70TrrX44aMUND4ho3i9jr1aCAD
         ZjnegTuw9+p/qUX558DJjMnCATXNRBT26WERu7qfbZRvNoziiKk5DX8+qV8T28C4Qacd
         4Vl469eVxObVHAar1k1upvhA/fpVHdFPG3P4IISGL4PMO6+J08erWqrCi5MfVw29D8Zb
         ATodnZ94IJ72EjqzrWASD7//kXfmB2ljHVijIks+BU8zO8SRUE+r575gMGWEw3NYL9hI
         4g/Ckwjs1Da6Vm5G8ZEL4b4xoJe961WOwHO6VkEBwC/BhK0qBt2NNMqekeuywOzJ5BxF
         Y2eQ==
X-Gm-Message-State: AOAM532zuYKeQw7NkTvVdafGLABmkLm3xTglEF6E9n9OpVmT/76qUosy
        w2QHlqETjaUfcFxdNsexcA==
X-Google-Smtp-Source: ABdhPJxSDk03cAG57DuYEG85mz4Rz6BjdksKFdm4mcs2hIajP3ovUbTb0I74gMDuOFLmTlQK0dLpMw==
X-Received: by 2002:a92:89da:: with SMTP id w87mr31911370ilk.236.1595384728469;
        Tue, 21 Jul 2020 19:25:28 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id y2sm11687981iox.22.2020.07.21.19.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 19:25:27 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Will Deacon <will@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 03/19] PCI: Drop unnecessary zeroing of bridge fields
Date:   Tue, 21 Jul 2020 20:24:58 -0600
Message-Id: <20200722022514.1283916-4-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722022514.1283916-1-robh@kernel.org>
References: <20200722022514.1283916-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The struct pci_host_bridge is 0 initialized when allocated, so there's
no need to explicitly set fields to 0.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c       | 1 -
 drivers/pci/controller/pci-ftpci100.c       | 2 --
 drivers/pci/controller/pci-mvebu.c          | 1 -
 drivers/pci/controller/pci-v3-semi.c        | 2 --
 drivers/pci/controller/pci-versatile.c      | 2 --
 drivers/pci/controller/pci-xgene.c          | 1 -
 drivers/pci/controller/pcie-brcmstb.c       | 1 -
 drivers/pci/controller/pcie-iproc.c         | 1 -
 drivers/pci/controller/pcie-rockchip-host.c | 1 -
 drivers/pci/controller/pcie-xilinx.c        | 1 -
 10 files changed, 13 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8210bf88734b..f38663af795c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1185,7 +1185,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = pcie;
-	bridge->busnr = 0;
 	bridge->ops = &advk_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index 5037aa9f6fd8..84b6b5a21a89 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -438,8 +438,6 @@ static int faraday_pci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	host->ops = &faraday_pci_ops;
-	host->busnr = 0;
-	host->msi = NULL;
 	host->map_irq = of_irq_parse_and_map_pci;
 	host->swizzle_irq = pci_common_swizzle;
 	p = pci_host_bridge_priv(host);
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 7be6db851614..db93823a2dcb 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -1117,7 +1117,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	pcie->nports = i;
 
 	bridge->sysdata = pcie;
-	bridge->busnr = 0;
 	bridge->ops = &mvebu_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index e8b5e55803b2..d79af39e6e60 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -724,8 +724,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	host->ops = &v3_pci_ops;
-	host->busnr = 0;
-	host->msi = NULL;
 	host->map_irq = of_irq_parse_and_map_pci;
 	host->swizzle_irq = pci_common_swizzle;
 	v3 = pci_host_bridge_priv(host);
diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
index f32ef8072147..80f594beea81 100644
--- a/drivers/pci/controller/pci-versatile.c
+++ b/drivers/pci/controller/pci-versatile.c
@@ -155,8 +155,6 @@ static int versatile_pci_probe(struct platform_device *pdev)
 
 	pci_add_flags(PCI_REASSIGN_ALL_BUS);
 
-	bridge->sysdata = NULL;
-	bridge->busnr = 0;
 	bridge->ops = &pci_versatile_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index fbb461cf8eca..1d3286823c16 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -625,7 +625,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	bridge->sysdata = port;
-	bridge->busnr = 0;
 	bridge->ops = &xgene_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4291a15abdcf..a92b337af20f 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -996,7 +996,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
-	bridge->busnr = 0;
 	bridge->ops = &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 	bridge->map_irq = of_irq_parse_and_map_pci;
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index cf1cb717c7df..e98dafd0fff4 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1523,7 +1523,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 		if (iproc_pcie_msi_enable(pcie))
 			dev_info(dev, "not using iProc MSI\n");
 
-	host->busnr = 0;
 	host->ops = &iproc_pcie_ops;
 	host->sysdata = pcie;
 	host->map_irq = pcie->map_irq;
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 4eb79c60d627..fb88030161f2 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -1008,7 +1008,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = rockchip;
-	bridge->busnr = 0;
 	bridge->ops = &rockchip_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 7c0f3268fc5c..cce67cb8fb2b 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -652,7 +652,6 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = port;
-	bridge->busnr = 0;
 	bridge->ops = &xilinx_pcie_ops;
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
-- 
2.25.1

