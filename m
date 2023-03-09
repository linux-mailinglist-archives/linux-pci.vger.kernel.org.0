Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583BF6B1EF3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjCIIxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCIIwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:52:54 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F43DD36F
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:52:28 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m8-20020a17090a4d8800b002377bced051so5368459pjh.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQSjdI7jzklikUEcdFC/m9MKhjlXYCglW0uRGmTAYhE=;
        b=fOHCl1w/vpydV4SanCAdP4AgKdJPu5X/D1/LkXCzzUWDoawzum2LlhP2j+XlFvk/hN
         BMDhEt3AZdUgup19Idm6ZqZMZDQBYABKDgM6BcnrmCGsTf9Kvm7kNqgJ3EBmGjv9FQmF
         aqwVymweCO8SZ+brd7QIMyAMslcd4Yd8EQjVJNj8gBkGLNK+rVIR4TdeGqkdaDpAttIl
         MOiipCd+34o0gKcSN0DfhEp5zlWqtNjWMTWuK+2kYZLXIW6CQw3w4393+AKck9f4W6Up
         aSHKrRBxvmsWzeGDTvyZqSGFRVOtU4Bmm3ruudRtvVv0CdjDlrOXdMQqrWsEjva3N8lk
         bSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQSjdI7jzklikUEcdFC/m9MKhjlXYCglW0uRGmTAYhE=;
        b=E9LYaEYkjL4pzYQg5GwLWkxGiZG5nfQ+auIuvy4YbpPzlL+C6DxbYP0Ce0L6JylLEw
         M9gEko/D00rUTt2j1p/VQl3SGVT1Yr8+K+HnlwJrB7QhpdL0XGiWiuEMQaGy3qIUg4oK
         4DQinyxpIOqbuyGJ/ncdPuriN4Q69AYrQl9p6Mqm9tCc4Dl/IP4RAjiLVArMWiuM/t6d
         cbClHgzzFwGTva7qcF9whlwCvqfbCemGSCHM6P8agu3hM7ASn9kpWZp5aSWerv//Lxjg
         c+ktmpWjn4ATV/rDCmOTDoK2mK4tSEO35u1585FvKISKi08SOFA6+8mI5GIushpajXTI
         wnoA==
X-Gm-Message-State: AO0yUKVA8o+p/Io5AEyaDzeutUyBcrfoy5satp1lKsDWL2aXJXThXuOI
        iDmw2uI0wBeeXNbMpFQa1gg1
X-Google-Smtp-Source: AK7set9fsx8sYunEDvW1PqagCAlC3u4vE1vRV9pLEEe18EaDlAQngqaTW9w43cIy3fyA2gZwQx1zKw==
X-Received: by 2002:a05:6a20:430f:b0:d0:4361:9720 with SMTP id h15-20020a056a20430f00b000d043619720mr8704590pzk.61.1678351942370;
        Thu, 09 Mar 2023 00:52:22 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:52:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 17/17] PCI: qcom: Expose link transition counts via debugfs
Date:   Thu,  9 Mar 2023 14:21:02 +0530
Message-Id: <20230309085102.120977-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
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

