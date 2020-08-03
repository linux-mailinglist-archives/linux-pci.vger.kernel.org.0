Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAFA23AF52
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgHCVCb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40326 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgHCVCa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:30 -0400
Received: by mail-io1-f68.google.com with SMTP id l17so40001373iok.7;
        Mon, 03 Aug 2020 14:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwFTr4t0lrmNy8f4Fgv3/l49uahHgczW7Wdy7hSwZ1w=;
        b=LORzLGQCc25xfattQ/r/eucxR1jhevA1boxWsnpFezxp4FAJH8zXFAS55YebAQxt49
         h7OtBc4Rk3Es3JBBHnKpfKL+HGl0MiW0fDRZpCCLs1kEM/T4tdr3CviNX8FNvuWwplVw
         0syBl5MkVIX8PJVjRD4ejJo7rxJ87n2tlAj8De73inJKZZvIgOFpabtSSa/btmXiVOwW
         5cfjhryp9Sa5+CUY6Mee1jqIK5Ip5g8WdUvaf+UcHMhBXSvFHaoVklyZfwFpN6DfeF05
         tK452SW3+4DSxiIqaGUViYGYCv0m8+KMtJcLbNJiFLOZvNX/X2f4tZyAAwxG7w8V2TUI
         4x0A==
X-Gm-Message-State: AOAM530dT9iH43Gsh1KoPGuU1LF4DdqnW7pOPVXRL5Iw+uEISKFI9hbG
        4lWsoCqdtNi1jAa2AUaeeQ==
X-Google-Smtp-Source: ABdhPJzMEhzv37+IQcarhuMxavAyD+FE8gqZIx02+KuoDY977KQ4tDj1eOPm1iwpPoPc4bKstznlOA==
X-Received: by 2002:a5d:9b96:: with SMTP id r22mr1878334iom.66.1596488549634;
        Mon, 03 Aug 2020 14:02:29 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:29 -0700 (PDT)
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
        Yue Wang <yue.wang@Amlogic.com>, Andy Gross <agross@kernel.org>
Subject: [RFC 25/27] PCI: dwc/qcom: Use common PCI register definitions
Date:   Mon,  3 Aug 2020 15:01:14 -0600
Message-Id: <20200803210116.3132633-26-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The QCom driver has its own defines for common PCI config space
registers. It also hard codes the capability register offsets which are
discoverable. Convert it to use the standard register definitions.

Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 27 ++++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 9f1d3ba686fa..dba5f7d7f727 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -39,11 +39,6 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PCIE20_COMMAND_STATUS			0x04
-#define CMD_BME_VAL				0x4
-#define PCIE20_DEVICE_CONTROL2_STATUS2		0x98
-#define PCIE_CAP_CPL_TIMEOUT_DISABLE		0x10
-
 #define PCIE20_PARF_PHY_CTRL			0x40
 #define PCIE20_PARF_PHY_REFCLK			0x4C
 #define PCIE20_PARF_DBI_BASE_ADDR		0x168
@@ -65,10 +60,6 @@
 #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE20_CAP				0x70
-#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + 0xC)
-#define PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT	(BIT(10) | BIT(11))
-#define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
 #define PCIE_CAP_LINK1_VAL			0x2FD7F
 
 #define PCIE20_PARF_Q2A_FLUSH			0x1AC
@@ -974,6 +965,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int i, ret;
 	u32 val;
 
@@ -1047,16 +1039,16 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 		pcie->parf + PCIE20_PARF_SYS_CTRL);
 	writel(0, pcie->parf + PCIE20_PARF_Q2A_FLUSH);
 
-	writel(CMD_BME_VAL, pci->dbi_base + PCIE20_COMMAND_STATUS);
+	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
-	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
+	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
-	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
-	val &= ~PCIE20_CAP_ACTIVE_STATE_LINK_PM_SUPPORT;
-	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
+	val &= ~PCI_EXP_LNKCAP_ASPMS;
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
 
-	writel(PCIE_CAP_CPL_TIMEOUT_DISABLE, pci->dbi_base +
-		PCIE20_DEVICE_CONTROL2_STATUS2);
+	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
+		PCI_EXP_DEVCTL2);
 
 	return 0;
 
@@ -1209,7 +1201,8 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
-- 
2.25.1

