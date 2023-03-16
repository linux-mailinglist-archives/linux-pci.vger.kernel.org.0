Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD5D6BC8B3
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCPIOl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjCPIOR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:14:17 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A51E5FC
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:13:21 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i5so899344pla.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XfRU46h/LdNPZlNmzHa3o2bfWEEqqbeXYLd09w6/jk=;
        b=Q+p7maJ3CcszEhUPzBF+S8zKel0Cr+MJWS+wEy3YCu/qKWNSHcsPlkQEkjg1WJAJ9R
         cQs5M89L7wQ4pz4f3ygtSP6tTDl1A6Xbk7lpy0qzBR1K87zqhAT7A4tTSGNBYohMhbWO
         eKQILOX0e4nvf+AZ7ArmIr5qzFORbee28qcjPhGlGPGx3ICBRjj2+MlnLHPMP1+G2RMC
         nYS6KscYo+KG1ycHE+WTH3l9bWoZzvolDS7GBxifIk62sQnUnOUR64viEkPZNMTZ08ml
         RmipQiUmgcIbnsblDftgW0g2J+Uc2s/WKTlgW7cpavTIzCLzcurGkp8UTW2PvYbm/jS+
         /ocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XfRU46h/LdNPZlNmzHa3o2bfWEEqqbeXYLd09w6/jk=;
        b=Ils6MxRL/3KZXgZfjSvgq1+QrZd6J9mG3MBay9b8rA0/RuHO/meMnP3fDbnpy1w5L4
         xtP2CQkvgDnrmPN/uTY5qGDEWyf774ZrNJdDxS9mL2rcgFvFnQ/ZaGSMPlrCVJR0td+h
         UQd/Z7RNbohzpwxbPEWGmWau3qHjS0pTcNOgMPX6WgZ/E4oh5a7AdhFom5CLctlA2YPt
         MqjLojXMbUUodqpkLb4TgiDI4pMqjViv1i0Yu5801Tkmf3OeHLBc+LHGkvdBF2OtB04f
         0eQAbmx2/dc647koP/3KWYxaE47U5glPfoWvQ1x8ad4y8cGQFaciPziEjcAqCZ4K0E3D
         j49A==
X-Gm-Message-State: AO0yUKVZLz9SoppMpZugrMl/USXawSEpGlBBrABijgkwP5yAHvFICXTI
        YPj18V9RuEYQJ6qpp20bdU4m
X-Google-Smtp-Source: AK7set9rShOagr4wGVhZzZQxx1Sv+ZpidxpOkxZ7c5l1ej/2LxvxmqL3DHaomGRW09MsbFQgnefXXQ==
X-Received: by 2002:a05:6a20:b704:b0:d0:15c9:4e67 with SMTP id fg4-20020a056a20b70400b000d015c94e67mr2528810pzb.19.1678954377430;
        Thu, 16 Mar 2023 01:12:57 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:57 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 19/19] PCI: qcom: Expose link transition counts via debugfs
Date:   Thu, 16 Mar 2023 13:41:17 +0530
Message-Id: <20230316081117.14288-20-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe controllers have debug registers in the MHI region that
count PCIe link transitions. Expose them over debugfs to userspace to
help debug the low power issues.

Note that even though the registers are prefixed as PARF_, they don't
live under the "parf" register region. The register naming is following
the Qualcomm's internal documentation as like other registers.

While at it, let's arrange the local variables in probe function to follow
reverse XMAS tree order.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 65 +++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 7daff0421b86..f3e606b038c3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/crc8.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interconnect.h>
@@ -62,6 +63,13 @@
 #define AXI_MSTR_RESP_COMP_CTRL1		0x81c
 #define MISC_CONTROL_1_REG			0x8bc
 
+/* MHI registers */
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L1		0xc0c
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L0S		0xc10
+#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
+#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
+
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
 #define MST_WAKEUP_EN				BIT(13)
@@ -229,11 +237,13 @@ struct qcom_pcie {
 	struct dw_pcie *pci;
 	void __iomem *parf;			/* DT parf */
 	void __iomem *elbi;			/* DT elbi */
+	void __iomem *mhi;
 	union qcom_pcie_resources res;
 	struct phy *phy;
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
 	const struct qcom_pcie_cfg *cfg;
+	struct dentry *debugfs;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1382,13 +1392,51 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	}
 }
 
+static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
+{
+	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
+
+	seq_printf(s, "L0s transition count: %u\n",
+		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L0S));
+
+	seq_printf(s, "L1 transition count: %u\n",
+		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L1));
+
+	seq_printf(s, "L1.1 transition count: %u\n",
+		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1));
+
+	seq_printf(s, "L1.2 transition count: %u\n",
+		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2));
+
+	seq_printf(s, "L2 transition count: %u\n",
+		   readl_relaxed(pcie->mhi + PARF_DEBUG_CNT_PM_LINKST_IN_L2));
+
+	return 0;
+}
+
+static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	char *name;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
+	if (!name)
+		return;
+
+	pcie->debugfs = debugfs_create_dir(name, NULL);
+	debugfs_create_devm_seqfile(dev, "link_transition_count", pcie->debugfs,
+				    qcom_pcie_link_transition_count);
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
+	const struct qcom_pcie_cfg *pcie_cfg;
 	struct device *dev = &pdev->dev;
+	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
+	struct resource *res;
 	struct dw_pcie *pci;
-	struct qcom_pcie *pcie;
-	const struct qcom_pcie_cfg *pcie_cfg;
 	int ret;
 
 	pcie_cfg = of_device_get_match_data(dev);
@@ -1436,6 +1484,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	/* MHI region is optional */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
+	if (res) {
+		pcie->mhi = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pcie->mhi)) {
+			ret = PTR_ERR(pcie->mhi);
+			goto err_pm_runtime_put;
+		}
+	}
+
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie->phy)) {
 		ret = PTR_ERR(pcie->phy);
@@ -1466,6 +1524,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	qcom_pcie_icc_update(pcie);
 
+	if (pcie->mhi)
+		qcom_pcie_init_debugfs(pcie);
+
 	return 0;
 
 err_phy_exit:
-- 
2.25.1

