Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8CB24CC46
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgHUD43 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40615 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgHUD40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:26 -0400
Received: by mail-io1-f65.google.com with SMTP id b17so473393ion.7;
        Thu, 20 Aug 2020 20:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edvGUGpaPjRq5umLUm+6u58eZpeK1XpSMHPWcWJ22Uc=;
        b=UeCersc32yRemzL4IlseLVNQEUMUzTbmw0gdfgK1I0WF2BvhtsEiS9VhBGjCGgYNFB
         0BWZJugI7xR8P2mnS5jbJEIs0NdfiGD3bJUFhNuwyCbqu3tR/jRx2Cl+mQ8KunEj3IR4
         8fQ6T17s2SDLYlpYz98NURpffpP3OBxz+nwed8UDSLjnzT854e9gLUgZZj1MPs5pxqui
         jsQSEcCr5KYNd6tbpXzCWwK84JOz7qvDq7RvtRIBpcPmQ8qWZR/4jUC62YtFFawuOqBf
         nuIB0YL6S1Z8dQ0U/P2VW1kAg7yFcV0FvmrDIeKhZe3IfHlg7Nd6ST3zU2v9YPK01gO6
         MVtA==
X-Gm-Message-State: AOAM531UEHUDlnJs0Dr8LixWvGYEFeL2kkjU9wwTeTdryRwESSeLVt/8
        +71RMHbdKD3fupPIoAX/SBhLtizVag==
X-Google-Smtp-Source: ABdhPJzMKcXOoA67DdtZomKXJ3hcCjg+p+4UND5Vd7stRJubIRYKDJim6SwRyBPjPn5FZKEVR20Ruw==
X-Received: by 2002:a6b:c94e:: with SMTP id z75mr898531iof.196.1597982185446;
        Thu, 20 Aug 2020 20:56:25 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:24 -0700 (PDT)
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
Subject: [PATCH v2 29/40] PCI: dwc/qcom: Use common PCI register definitions
Date:   Thu, 20 Aug 2020 21:54:09 -0600
Message-Id: <20200821035420.380495-30-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
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
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index fe7fc2ccd76d..d8d1fb7e0b8f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -67,10 +67,6 @@
 #define PCIE20_AXI_MSTR_RESP_COMP_CTRL1		0x81c
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE20_CAP				0x70
-#define PCIE20_DEVICE_CONTROL2_STATUS2		(PCIE20_CAP + PCI_EXP_DEVCTL2)
-#define PCIE20_CAP_LINK_CAPABILITIES		(PCIE20_CAP + PCI_EXP_LNKCAP)
-#define PCIE20_CAP_LINK_1			(PCIE20_CAP + 0x14)
 #define PCIE_CAP_LINK1_VAL			0x2FD7F
 
 #define PCIE20_PARF_Q2A_FLUSH			0x1AC
@@ -1017,6 +1013,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
 	struct dw_pcie *pci = pcie->pci;
 	struct device *dev = pci->dev;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int i, ret;
 	u32 val;
 
@@ -1092,14 +1089,14 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 
 	writel(PCI_COMMAND_MASTER, pci->dbi_base + PCI_COMMAND);
 	writel(DBI_RO_WR_EN, pci->dbi_base + PCIE20_MISC_CONTROL_1_REG);
-	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + PCIE20_CAP_LINK_1);
+	writel(PCIE_CAP_LINK1_VAL, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
-	val = readl(pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_ASPMS;
-	writel(val, pci->dbi_base + PCIE20_CAP_LINK_CAPABILITIES);
+	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
 
-	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base +
-		PCIE20_DEVICE_CONTROL2_STATUS2);
+	writel(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS, pci->dbi_base + offset +
+		PCI_EXP_DEVCTL2);
 
 	return 0;
 
@@ -1252,7 +1249,8 @@ static void qcom_pcie_post_deinit_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_link_up(struct dw_pcie *pci)
 {
-	u16 val = readw(pci->dbi_base + PCIE20_CAP + PCI_EXP_LNKSTA);
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
-- 
2.25.1

