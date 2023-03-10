Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5888A6B3570
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjCJEM3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjCJELG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:11:06 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E3687DB2
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:09:48 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y10so2863593pfi.8
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyhF4Lknyw7VhB+OiPeq4AnEmul/Wt/H/6qIG9Bjj1E=;
        b=jnxoVqzy+QhCv5b6dfN9qTqFUJp/2zsKEmrMDPkxUmM2VqMsWxFw17benA1A6OJaZp
         Tvtv5QhYUBJiyYIFZ9calAKmFteyHK/4Ka6Wa41Z2KrW95Af54If1saMvLiATqu2CQ2w
         EfRjnyjtDAPporuSvaC+Cj7wbQqqEBJFwixudI2f8GKOe45Y7Nc6iXQOkex0e9sypie5
         P+YEtYUvk6AsrgNgd4erokttTOpWmv4tfMztvd2wXjsmFxJJIDIl2RgVSGJC1fQDZbwV
         S44vHWrLLdam+t/fcqvQot6v/umkFD3oPQhxzKXKfbzQqP+LxYakoenPzBz16vniDUd/
         dYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyhF4Lknyw7VhB+OiPeq4AnEmul/Wt/H/6qIG9Bjj1E=;
        b=z97H4Hc0jq4Ij125FKqgARp6+8ytiIyEyot9ZMpmqqY1X533STXbwcuh37Lb//RsOd
         6Ym0hQ+aK9Vq6pjG3vgJu5pcobT+k26g64tjpUKNKDLJ+OgTJ572AfKbhYpNrMFxUiMH
         rD056aVYaQM2DzQXS4AE6NDLD3DxLP+LSuoySe+/aIPSGkoJHYusEnRkchQvrPqO9Bls
         GtERJs0KI9+PdztisbSU2j/4Z7qD6ssAV0Mj8LmwfkJp7OiOQzdhAkd/zO2pTkf/fHfN
         ph2NZa2OWHtaF2xIrbQWvUsPFYpS6Q1efQp3yGYl2GSiMGDg9ejE+pi/l41hlbMljB+L
         FxIQ==
X-Gm-Message-State: AO0yUKWI2CIapM+YG+Isz9eigisRoMl3EYaLl63/9ED9fuaWNga7frLn
        VDRpe9/QMAosL6qBeCgViBr/
X-Google-Smtp-Source: AK7set9ZX8UhdAEwDPaszTWbmwqyxZMNYDiXQa3ja5uPdbIpthw6Jp1yRXD/uXL8FEnEaZbydO66SA==
X-Received: by 2002:a62:4ecb:0:b0:593:f191:966 with SMTP id c194-20020a624ecb000000b00593f1910966mr18792008pfb.1.1678421388038;
        Thu, 09 Mar 2023 20:09:48 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:47 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 18/19] PCI: qcom: Expose link transition counts via debugfs for v1.9.0 & v2.7.0
Date:   Fri, 10 Mar 2023 09:38:15 +0530
Message-Id: <20230310040816.22094-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe controllers of versions v1.9.0 and v2.7.0 have debug
registers in the MHI region that count PCIe link transitions. Expose them
over debugfs to userspace to help debug the low power issues.

Note that even though the registers are prefixed as PARF_, they don't
live under the "parf" register region. The register naming is following
the Qualcomm's internal documentation as like other registers.

The debugfs interface is added using per config callback because the
register interface for accessing debug info varies between IP versions.

While at it, let's arrange the local variables in probe function to follow
reverse XMAS tree order.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 77 +++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 52f09ee8dd48..f99b7e7f3f73 100644
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
@@ -219,6 +227,7 @@ struct qcom_pcie_ops {
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
+	void (*init_debugfs)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie_cfg {
@@ -229,11 +238,13 @@ struct qcom_pcie {
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
@@ -263,6 +274,23 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie,
+				   int (*debugfs_func)(struct seq_file *s, void *data))
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
+
+	debugfs_create_devm_seqfile(pci->dev, "link_transition_count",
+				    pcie->debugfs, debugfs_func);
+}
+
 static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -963,6 +991,35 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
+static int qcom_pcie_debugfs_func_2_7_0(struct seq_file *s, void *data)
+{
+	struct qcom_pcie *pcie = (struct qcom_pcie *) dev_get_drvdata(s->private);
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
+
+static void qcom_pcie_init_debugfs_2_7_0(struct qcom_pcie *pcie)
+{
+	if (pcie->mhi)
+		qcom_pcie_init_debugfs(pcie, qcom_pcie_debugfs_func_2_7_0);
+}
+
 static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
 {
 	/* iommu map structure */
@@ -1260,6 +1317,7 @@ static const struct qcom_pcie_ops ops_2_7_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.init_debugfs = qcom_pcie_init_debugfs_2_7_0,
 };
 
 /* Qcom IP rev.: 1.9.0 */
@@ -1269,6 +1327,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
+	.init_debugfs = qcom_pcie_init_debugfs_2_7_0,
 };
 
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
@@ -1387,11 +1446,12 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 
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
@@ -1439,6 +1499,16 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1469,6 +1539,9 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	qcom_pcie_icc_update(pcie);
 
+	if (pcie->cfg->ops->init_debugfs)
+		pcie->cfg->ops->init_debugfs(pcie);
+
 	return 0;
 
 err_phy_exit:
-- 
2.25.1

