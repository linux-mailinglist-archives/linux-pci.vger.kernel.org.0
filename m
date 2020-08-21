Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A924CC31
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgHUD4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34415 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHUD4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:10 -0400
Received: by mail-il1-f196.google.com with SMTP id t4so349016iln.1;
        Thu, 20 Aug 2020 20:56:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plPAfT6jsv3fD4ktL6XVG9iUJUN4lTKUvUyacbP7UOE=;
        b=FhNj1D9+/iO6IfqC0v7A8tlFkC5qewqOybqkqRv/X1LIgXy3LjDRf/lhfaoY0goNtR
         3K5lcHcgq46i5NwaWEFV20uJruo2DE3YYJDeNB0XLEwbvjVMtIYjKirdjagWreL+O+WU
         OWjmsbld//VsX+3jsQ0D6damiSwbrO7Kowu1Uvbr8RUIuAt27IhSJ+fX4WdLZSyhH3uV
         wCgpT2riV1GVAeCJRDRxx2O5C9WVKObgxGYIIXGUEVQLoJh+6namdSz3T0CFyjop3+yJ
         bMPNBdQzauGgOitOS+EnggRjz0YoKIDC4qfP5Drl2TkkbPCZlWtTmfKmeaX6ae2uXNoE
         KPyA==
X-Gm-Message-State: AOAM530XJplyL0lTVG5BJUS3vq3MnJflBwEbFhoHso2rZ+OtCsi6uDs7
        TRDTaa5t8ngS1T3+hxVaXg==
X-Google-Smtp-Source: ABdhPJyRffWnopuuNv/0Z5NXVEnyP27O7kgM+pkiMrghGFx17DPrdLFvgAOgtagD9saPcgT9z5takQ==
X-Received: by 2002:a92:d089:: with SMTP id h9mr954256ilh.60.1597982168647;
        Thu, 20 Aug 2020 20:56:08 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:08 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 25/40] PCI: dwc/meson: Drop the duplicate number of lanes setup
Date:   Thu, 20 Aug 2020 21:54:05 -0600
Message-Id: <20200821035420.380495-26-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The meson lanes initialization is the same DWC port logic registers as
in dw_pcie_setup(). We just need to initialize 'num_lanes' to 1 to do
the same init.

dw_pcie_setup_rc() sets the PORT_LOGIC_SPEED_CHANGE bit, so setting it
can be dropped.

Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 29 +-------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 67ca73528aad..96308743faf4 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -22,18 +22,6 @@
 
 #define to_meson_pcie(x) dev_get_drvdata((x)->dev)
 
-/* External local bus interface registers */
-#define PLR_OFFSET			0x700
-#define PCIE_PORT_LINK_CTRL_OFF		(PLR_OFFSET + 0x10)
-#define FAST_LINK_MODE			BIT(7)
-#define LINK_CAPABLE_MASK		GENMASK(21, 16)
-#define LINK_CAPABLE_X1			BIT(16)
-
-#define PCIE_GEN2_CTRL_OFF		(PLR_OFFSET + 0x10c)
-#define NUM_OF_LANES_MASK		GENMASK(12, 8)
-#define NUM_OF_LANES_X1			BIT(8)
-#define DIRECT_SPEED_CHANGE		BIT(17)
-
 #define TYPE1_HDR_OFFSET		0x0
 #define PCIE_STATUS_COMMAND		(TYPE1_HDR_OFFSET + 0x04)
 #define PCI_IO_EN			BIT(0)
@@ -288,22 +276,6 @@ static void meson_pcie_init_dw(struct meson_pcie *mp)
 	val |= APP_LTSSM_ENABLE;
 	meson_cfg_writel(mp, val, PCIE_CFG0);
 
-	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
-	val &= ~(LINK_CAPABLE_MASK | FAST_LINK_MODE);
-	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
-
-	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
-	val |= LINK_CAPABLE_X1;
-	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
-
-	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
-	val &= ~NUM_OF_LANES_MASK;
-	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
-
-	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
-	val |= NUM_OF_LANES_X1 | DIRECT_SPEED_CHANGE;
-	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
-
 	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR0);
 	meson_elb_writel(mp, 0x0, PCIE_BASE_ADDR1);
 }
@@ -513,6 +485,7 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	pci = &mp->pci;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
+	pci->num_lanes = 1;
 
 	mp->phy = devm_phy_get(dev, "pcie");
 	if (IS_ERR(mp->phy)) {
-- 
2.25.1

