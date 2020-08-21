Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440A424CC4E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHUD4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:36 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37040 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUD4c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:32 -0400
Received: by mail-il1-f194.google.com with SMTP id v2so342340ilq.4;
        Thu, 20 Aug 2020 20:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxlIWP5s8Q0eZi3EvYbo0258HR6L8rBsGw9E+WBQLQE=;
        b=HnySkvNBU/Hg2T6M9KqOYjFgeRztpk6RoSNRzP4ktM8qlYz0dKJUq9l6O+xC9YdfYl
         jg/NOPEJUa/htKM46xw+dXRfwMKukRz2ZLue/i5GY+txtNHA/awxWSoALXrBEzHVXypd
         mZeB/PQJUbiFhPzo5mNmmGgH6zTPM6A9WmGvw27W9aHpD+K5lJI8XwW8MPgvCmCLcQxT
         yXK8deZEhB/YbpHI9+U0QzKMPA0yFW2zlMNke8ta2S5aNnwmDcOJNd//5Xr0yIQAEGsB
         XDX2ggTA0M1k1QV52OJxYgU1u62t2S6FAhvhPbS25YeRyQSKz6qsaHVihdoaCTMIayOo
         axHg==
X-Gm-Message-State: AOAM5331OJaKO3eba0EzXdc9ycZz7y80MtPapgxk5hIcSuT06kEIKLir
        s+oj94vpyLWzowdIldm+Kw==
X-Google-Smtp-Source: ABdhPJwbGI9aHlju4p44HOztNYkvAORMbfv59GH0OOd/zH7h5ig35dQDgCJgHsilkLRRWaU7TgypFw==
X-Received: by 2002:a92:79ca:: with SMTP id u193mr950065ilc.185.1597982191043;
        Thu, 20 Aug 2020 20:56:31 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:30 -0700 (PDT)
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
Subject: [PATCH v2 31/40] PCI: dwc/tegra: Use common Designware port logic register definitions
Date:   Thu, 20 Aug 2020 21:54:11 -0600
Message-Id: <20200821035420.380495-32-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
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
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.h |  6 +++
 drivers/pci/controller/dwc/pcie-tegra194.c   | 56 ++++++++------------
 2 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 40c3766df096..73c119437fee 100644
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
index a5dce56b3b7a..f121ac25d418 100644
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

