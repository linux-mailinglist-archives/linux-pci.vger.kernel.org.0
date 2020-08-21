Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B09E24CC7E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHUD5C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:57:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37259 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgHUD46 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:58 -0400
Received: by mail-io1-f65.google.com with SMTP id b16so485080ioj.4;
        Thu, 20 Aug 2020 20:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9/YPThWKebuepD09jEOhLOS7SrW7ksPYY3UHELax/QU=;
        b=d1qJeTUtDUyEYXJ3St92Tp8URiCGPgf3NhXE1psc1WG8XNZ3+0ROmkjWxRWxvK6q+k
         CXrM9hd4k1dBXUncHhPPB3d5eodNKy+Cmv525A1aQLEsi80uNX+VYDEdsRCv8dqNcfxw
         03WM6RRhPF7qmxUXR9E3Q6/FaDVaSBP3vjNIA6iwB4WfLVLWU0pKZEdqliLfMzr5AyO1
         4IHe5pfca+oky+T4pF1Q6X7e2rmZc0/3KEeVviaX91b3sxw9JVREhUeQb8VCJLqc6otW
         UhUHJQTarVqTKz4CRV/ZOAnmqzL4f/74U8Ra0qFR2RHywspbKOEPbiWtZbWA/TP9gt4n
         rmGQ==
X-Gm-Message-State: AOAM532qxeNRuBBheL2y3JpwvtMEup2brvdSUpkMWVzc2/cgJxwIMbde
        D+rPMjifHHikTQq1HOGTRA==
X-Google-Smtp-Source: ABdhPJwTwqsPsKVkMoMEXHOo2cKMWdbZxZdy/oInmh65Y7ywfHBijNwvFaSB2WL1YEbhA5nsNJVKOg==
X-Received: by 2002:a05:6638:1690:: with SMTP id f16mr859543jat.91.1597982216882;
        Thu, 20 Aug 2020 20:56:56 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:56 -0700 (PDT)
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
Subject: [PATCH v2 40/40] PCI: dwc: Use DBI accessors
Date:   Thu, 20 Aug 2020 21:54:20 -0600
Message-Id: <20200821035420.380495-41-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the remaining cases of register accesses using dbi_base rather
than dw_pcie_(read|write)[bwl]_dbi accessors.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-spear13xx.c |  8 ++++----
 drivers/pci/controller/dwc/pcie-tegra194.c  | 10 ++++------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 0d8d0fe87f27..e348225f651f 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -86,12 +86,12 @@ static int spear13xx_pcie_establish_link(struct spear13xx_pcie *spear13xx_pcie)
 	 * default value in capability register is 512 bytes. So force
 	 * it to 128 here.
 	 */
-	dw_pcie_read(pci->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, &val);
+	val = dw_pcie_readw_dbi(pci, exp_cap_off + PCI_EXP_DEVCTL);
 	val &= ~PCI_EXP_DEVCTL_READRQ;
-	dw_pcie_write(pci->dbi_base + exp_cap_off + PCI_EXP_DEVCTL, 2, val);
+	dw_pcie_writew_dbi(pci, exp_cap_off + PCI_EXP_DEVCTL, val);
 
-	dw_pcie_write(pci->dbi_base + PCI_VENDOR_ID, 2, 0x104A);
-	dw_pcie_write(pci->dbi_base + PCI_DEVICE_ID, 2, 0xCD80);
+	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, 0x104A);
+	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, 0xCD80);
 
 	/* enable ltssm */
 	writel(DEVICE_TYPE_RC | (1 << MISCTRL_EN_ID)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1560c449757d..aa511ec0d800 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -816,26 +816,24 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 
 	/* Program init preset */
 	for (i = 0; i < pcie->num_lanes; i++) {
-		dw_pcie_read(pci->dbi_base + CAP_SPCIE_CAP_OFF
-				 + (i * 2), 2, &val);
+		val = dw_pcie_readw_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2));
 		val &= ~CAP_SPCIE_CAP_OFF_DSP_TX_PRESET0_MASK;
 		val |= GEN3_GEN4_EQ_PRESET_INIT;
 		val &= ~CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_MASK;
 		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
 			   CAP_SPCIE_CAP_OFF_USP_TX_PRESET0_SHIFT);
-		dw_pcie_write(pci->dbi_base + CAP_SPCIE_CAP_OFF
-				 + (i * 2), 2, val);
+		dw_pcie_writew_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2), val);
 
 		offset = dw_pcie_find_ext_capability(pci,
 						     PCI_EXT_CAP_ID_PL_16GT) +
 				PCI_PL_16GT_LE_CTRL;
-		dw_pcie_read(pci->dbi_base + offset + i, 1, &val);
+		val = dw_pcie_readb_dbi(pci, offset + i);
 		val &= ~PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK;
 		val |= GEN3_GEN4_EQ_PRESET_INIT;
 		val &= ~PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK;
 		val |= (GEN3_GEN4_EQ_PRESET_INIT <<
 			PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT);
-		dw_pcie_write(pci->dbi_base + offset + i, 1, val);
+		dw_pcie_writeb_dbi(pci, offset + i, val);
 	}
 
 	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-- 
2.25.1

