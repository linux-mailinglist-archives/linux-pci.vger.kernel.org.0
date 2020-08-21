Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1DC24CC27
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHUD4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:02 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38804 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgHUD4B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:01 -0400
Received: by mail-il1-f193.google.com with SMTP id 77so338595ilc.5;
        Thu, 20 Aug 2020 20:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uu4tpLpSWlZgPNlTgALarmZOQ965fdEPoxw3GPbhQMY=;
        b=ZS0aolaOSj63dw9zWmqUM8dAmdnR125FofvrIRVoO11HpZf7hMYQ3+9D3t1rUeAYm6
         RxiNcJWPRd4Rm11hXBql846z/+iHFZhtzVJZgNT5C7sYARyCnQMYj2KM+PYGQSWyxNAj
         bs6OzqipuJRVxUrUq/lDKLcuwJ0hOWzREMGVZJxUaA1S2LuNKGlaUGcU9GqfKptXaWWW
         yVkyIu8s5pCwKraxESZoHzLj9mMnySjzm7psxKAscC8cBtgalqva/30IIJpRvPxTEVHF
         ykZ0HORL8zKEKBY4sJOKew15YZwpm6J4lHxd6UctVbPIPCREfQQdIdCTPtBXfxy9r5Sh
         thWA==
X-Gm-Message-State: AOAM530Mqa87c4/YQvmjAOEPv2LiuY8Bh7eQ5nclXgYuoTWp95Bs9svO
        CgxCJD+5uRrfOFYkKFBUHw==
X-Google-Smtp-Source: ABdhPJzZNZOWZm6KD7ItWV2xaPG0DqxpYvEl6L0qi9rFaLP6Bl6ngDqvWZqxYrl0EKniHIjOc3szPw==
X-Received: by 2002:a92:b05:: with SMTP id b5mr1008672ilf.14.1597982160472;
        Thu, 20 Aug 2020 20:56:00 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:59 -0700 (PDT)
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
Subject: [PATCH v2 23/40] PCI: dwc: Add a 'num_lanes' field to struct dw_pcie
Date:   Thu, 20 Aug 2020 21:54:03 -0600
Message-Id: <20200821035420.380495-24-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a 'num_lanes' field to allow drivers to provide a the number of lanes
if not in DT or using a custom DT property. A driver can provide a
non-zero value which is used if the DT doesn't have a 'num-lanes'
property.

Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 13 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  1 +
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index b723e0cc41fb..14ac87fa21a2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -548,7 +548,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
 {
 	int ret;
 	u32 val;
-	u32 lanes;
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
@@ -562,16 +561,16 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		"enabled" : "disabled");
 
 
-	ret = of_property_read_u32(np, "num-lanes", &lanes);
-	if (ret) {
-		dev_dbg(pci->dev, "property num-lanes isn't found\n");
+	ret = of_property_read_u32(np, "num-lanes", &pci->num_lanes);
+	if (!pci->num_lanes) {
+		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
 		return;
 	}
 
 	/* Set the number of lanes */
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_MODE_MASK;
-	switch (lanes) {
+	switch (pci->num_lanes) {
 	case 1:
 		val |= PORT_LINK_MODE_1_LANES;
 		break;
@@ -585,7 +584,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		val |= PORT_LINK_MODE_8_LANES;
 		break;
 	default:
-		dev_err(pci->dev, "num-lanes %u: invalid value\n", lanes);
+		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
 		return;
 	}
 	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
@@ -593,7 +592,7 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	/* Set link width speed control register */
 	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
 	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	switch (lanes) {
+	switch (pci->num_lanes) {
 	case 1:
 		val |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 		break;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7cc322f8596c..43d3729101c3 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -246,6 +246,7 @@ struct dw_pcie {
 	struct dw_pcie_ep	ep;
 	const struct dw_pcie_ops *ops;
 	unsigned int		version;
+	int			num_lanes;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-- 
2.25.1

