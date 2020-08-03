Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41C23AF5F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgHCVCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43788 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgHCVCg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:36 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so39951531iom.10;
        Mon, 03 Aug 2020 14:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5V63dl5D15U/c4aTTJinxu1IGbYXot5HyJAyQBAcQN8=;
        b=lf+K0Ql0HCqhJcyF4kai/etIqiUZ5bNVUJd1+XspolRaUPLVLF6HBHldF/eAGa4TuT
         pxPeu7ETiPIkjyXkvnU3ZWVZdmXznDyHHSy93nOnTCrIYV2cy9EMWm8FCWdKvKRFDDSj
         bj95yG17VJ9ktftMRMUw+bhcIOpKW/KbyJqppiMFA8wpr8TkW8D7ozmuY1evdMp484Jq
         kVog3G7VEvBV+dIiF+cuEHt5FunipPMYC9l+3Pxo4oDYhz+7klGu1zcZ0tydwv08girF
         uOf7Z2qnsEIfEYSqg6hT/M9BaaVd62Lkk2tTBr6so+m8bb3+CqlPIlE3dQM1Fo1ZD7y+
         pxAQ==
X-Gm-Message-State: AOAM533M199Z9L1ErQJW2xeBpdskJyMIwQUIg32k+YS0Kxx2VA2t/H6O
        86r7O0LE3m2qQzGF9QN+6A==
X-Google-Smtp-Source: ABdhPJye2Mo2SgL9U7MmsN235jpxm7lOgHdwxN7y4uIMz2vtYYQ/vzsM/p/WbFYNk1hakIOySw24tA==
X-Received: by 2002:a6b:c504:: with SMTP id v4mr1853953iof.20.1596488554927;
        Mon, 03 Aug 2020 14:02:34 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 27/27] PCI: dwc/tegra: Use common Designware port logic register definitions
Date:   Mon,  3 Aug 2020 15:01:16 -0600
Message-Id: <20200803210116.3132633-28-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Tegra driver has its own defines for common Designware Port Logic
registers. Convert it to use the standard register definitions.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.h |  6 +++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 56 ++++++++------------
 2 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b18a9a5f48d2..3bd322db69a6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -32,7 +32,13 @@
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_AFR			0x70C
 #define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
+#define PORT_AFR_N_FTS(n)		FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
 #define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
+#define PORT_AFR_ENTER_ASPM		BIT(30)
+#define PORT_AFR_L0S_ENTRANCE_LAT_SHIFT	24
+#define PORT_AFR_L0S_ENTRANCE_LAT_MASK	GENMASK(26, 24)
+#define PORT_AFR_L1_ENTRANCE_LAT_SHIFT	27
+#define PORT_AFR_L1_ENTRANCE_LAT_MASK	GENMASK(29, 27)
 
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_DLL_LINK_EN		BIT(5)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index c567c9c09ff6..ad295c854853 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -183,19 +183,7 @@
 #define EVENT_COUNTER_GROUP_SEL_SHIFT	24
 #define EVENT_COUNTER_GROUP_5		0x5
 
-#define PORT_LOGIC_ACK_F_ASPM_CTRL			0x70C
-#define ENTER_ASPM					BIT(30)
-#define L0S_ENTRANCE_LAT_SHIFT				24
-#define L0S_ENTRANCE_LAT_MASK				GENMASK(26, 24)
-#define L1_ENTRANCE_LAT_SHIFT				27
-#define L1_ENTRANCE_LAT_MASK				GENMASK(29, 27)
-#define N_FTS_SHIFT					8
-#define N_FTS_MASK					GENMASK(7, 0)
 #define N_FTS_VAL					52
-
-#define PORT_LOGIC_GEN2_CTRL				0x80C
-#define PORT_LOGIC_GEN2_CTRL_DIRECT_SPEED_CHANGE	BIT(17)
-#define FTS_MASK					GENMASK(7, 0)
 #define FTS_VAL						52
 
 #define PORT_LOGIC_MSI_CTRL_INT_0_EN		0x828
@@ -401,9 +389,9 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 			val |= APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
 			appl_writel(pcie, val, APPL_CAR_RESET_OVRD);
 
-			val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
-			val |= PORT_LOGIC_GEN2_CTRL_DIRECT_SPEED_CHANGE;
-			dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
+			val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+			val |= PORT_LOGIC_SPEED_CHANGE;
+			dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 		}
 	}
 
@@ -694,11 +682,11 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
 
 	/* Program L0s and L1 entrance latencies */
-	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
-	val &= ~L0S_ENTRANCE_LAT_MASK;
-	val |= (pcie->aspm_l0s_enter_lat << L0S_ENTRANCE_LAT_SHIFT);
-	val |= ENTER_ASPM;
-	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
+	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
+	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val |= PORT_AFR_ENTER_ASPM;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 }
 
 static int init_debugfs(struct tegra_pcie_dw *pcie)
@@ -895,15 +883,15 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
 	/* Configure FTS */
-	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
-	val &= ~(N_FTS_MASK << N_FTS_SHIFT);
-	val |= N_FTS_VAL << N_FTS_SHIFT;
-	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
+	val &= ~PORT_AFR_N_FTS_MASK;
+	val |= PORT_AFR_N_FTS(N_FTS_VAL);
+	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 
-	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
-	val &= ~FTS_MASK;
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_N_FTS_MASK;
 	val |= FTS_VAL;
-	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
 	/* Enable as 0xFFFF0001 response for CRS */
 	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
@@ -1820,15 +1808,15 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
 	/* Configure N_FTS & FTS */
-	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL);
-	val &= ~(N_FTS_MASK << N_FTS_SHIFT);
-	val |= N_FTS_VAL << N_FTS_SHIFT;
-	dw_pcie_writel_dbi(pci, PORT_LOGIC_ACK_F_ASPM_CTRL, val);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
+	val &= ~PORT_AFR_N_FTS_MASK;
+	val |= PORT_AFR_N_FTS(FTS_VAL);
+	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
 
-	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_GEN2_CTRL);
-	val &= ~FTS_MASK;
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_N_FTS_MASK;
 	val |= FTS_VAL;
-	dw_pcie_writel_dbi(pci, PORT_LOGIC_GEN2_CTRL, val);
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
 	/* Configure Max Speed from DT */
 	if (pcie->max_speed && pcie->max_speed != -EINVAL) {
-- 
2.25.1

