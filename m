Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7C96AC573
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCFPfM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjCFPep (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:45 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66556367C9
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:34:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x34so10197885pjj.0
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQSjdI7jzklikUEcdFC/m9MKhjlXYCglW0uRGmTAYhE=;
        b=oGw/hu1X4G3ndPSHZlB2CwZ1u14B1WYeLN+VJ8vLY/537eulqI4hhOd+tY+F7gtwk0
         EInBDUc+DABgs4PmoOYDoiYk6FEHTIERbt72x/NncWPS16cdys8sucX+bevwtwx1FY0W
         VMKdDGoB+7dx3BkQ1kz/1FfKkvYRDh56UI7Tc0rsHrAWFuVG5PkGim35BpxIAH+MnO25
         q7JeT+F4sg53C0HbJb12ZM9+9CYi44QI4pGiLbbzXET54AliynlVtCs0dzCo0uGbAD1R
         uaG/5KwjQ5TnqA0fpf5HfQr31lCvGgcQCcPXyfEoFjZn8ZXPkpdilC7+uXRhGwaZrv2c
         WhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQSjdI7jzklikUEcdFC/m9MKhjlXYCglW0uRGmTAYhE=;
        b=ASuxOSggkSv9t7GSPWw+gNDccow59Fq1tVoHaJ4MYET/U8Fx5aYxrmHkdn3Ph5SKRY
         KdbQ0JfXIjOG3jNHiMgqpmpmbm8yLW///Rv7ZN9nhxKVbr2M+A0VrFw3ZgGagKtdjFDO
         BSuZTphtxZHtV6aC/AEsY0cOOvGYo5xPgmxS380c7RDR7lmDzgCRFPyv2aYJQAAsDe6T
         l87vZwu43+fPjAQi4zr7ialDSL+zxoAP47KRmPRIi0CJ/+k08+VF4Uat1irvJb52HN7u
         skne0OG4PaPVATe1KuvAYh65MZFkhZXeUuX17a79rjLgoB1BXpP/gZYu1iUbUKILIPTt
         982g==
X-Gm-Message-State: AO0yUKUaI/IEGGJ9jmQzqrgFjQRG+0fcG6F92NymK30+ueuRdr0IrQhL
        aZqyMOvHpmgecLs9pobz1h6W
X-Google-Smtp-Source: AK7set8YCJcbzbYudivA+ICnxXe6OZxc8x4lQ7rD0D0O7XCz0vraQeG88OIyptrFcyxV7E/UdRgKUQ==
X-Received: by 2002:a17:903:283:b0:19c:d309:4612 with SMTP id j3-20020a170903028300b0019cd3094612mr14325092plr.6.1678116839683;
        Mon, 06 Mar 2023 07:33:59 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 19/19] PCI: qcom: Expose link transition counts via debugfs
Date:   Mon,  6 Mar 2023 21:02:22 +0530
Message-Id: <20230306153222.157667-20-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e1180c84f0fa..6d9bde64c9e9 100644
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
@@ -1385,6 +1395,37 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	}
 }
 
+static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
+{
+	struct qcom_pcie *pcie = (struct qcom_pcie *)
+				     dev_get_drvdata(s->private);
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
+
+	debugfs_create_devm_seqfile(pci->dev, "link_transition_count", pcie->debugfs,
+				    qcom_pcie_link_transition_count);
+}
+
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1392,6 +1433,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie *pci;
 	struct qcom_pcie *pcie;
 	const struct qcom_pcie_cfg *pcie_cfg;
+	char *name;
 	int ret;
 
 	pcie_cfg = of_device_get_match_data(dev);
@@ -1439,6 +1481,12 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	pcie->mhi = devm_platform_ioremap_resource_byname(pdev, "mhi");
+	if (IS_ERR(pcie->mhi)) {
+		ret = PTR_ERR(pcie->mhi);
+		goto err_pm_runtime_put;
+	}
+
 	pcie->phy = devm_phy_optional_get(dev, "pciephy");
 	if (IS_ERR(pcie->phy)) {
 		ret = PTR_ERR(pcie->phy);
@@ -1469,8 +1517,19 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	qcom_pcie_icc_update(pcie);
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
+	if (!name) {
+		ret = -ENOMEM;
+		goto err_host_deinit;
+	}
+
+	pcie->debugfs = debugfs_create_dir(name, NULL);
+	qcom_pcie_init_debugfs(pcie);
+
 	return 0;
 
+err_host_deinit:
+	dw_pcie_host_deinit(&pcie->pci->pp);
 err_phy_exit:
 	phy_exit(pcie->phy);
 err_pm_runtime_put:
-- 
2.25.1

