Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2603C5B8263
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiINHzI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiINHym (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 03:54:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A625CA
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:54:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j12so14100825pfi.11
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BmOWU26gjLBIOonkKcZ0ILBj0OeiqDzaVAugyvdHpNQ=;
        b=ScM8Pi5xIEHRfZElpQvyLnPbEmuIDVDUfS64bTvorxQf3MQlJGCGSFwwhlTpQqXajY
         dEOnCFWcI8pMFn7nYJ7QR4JrW6WTQK9v5Nbyc/3pnDtdcmCOsDfe+LC+Ot5Olr/fQ/hW
         Ra9ZQceClL0Xh2ESP7pjfaGkI/Vo6aJHCOSIUi91jHDf5+7hDCP/CIYSPb7VwnU4j3J8
         ALqMGXIk6bz7roWDxnyriH9XiqDPKxVbhoRFESq0VFhSIsInSok8Wepimlx/V7CyHLCK
         pyMmq+/37lUgTMduEQbKl6lIgwxdrRo6YCIF+qhiN7iwR9xf3IRF+Q8ILzSguc6ET2WB
         1yuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BmOWU26gjLBIOonkKcZ0ILBj0OeiqDzaVAugyvdHpNQ=;
        b=FXstfv9ClAg8ZWwgZ1mygLFNYzEdXcZwFxjpmkPbpgnhz4Vc3UpIj9E/p46NmgB6H6
         TG9w3Qrn1ptzNHIcHBtpzKvsvWPX7bdMsbGD2D1KnxQoE02MwgzqRV2C+5vEjlifSLZm
         pwKkmqg4DifLJBtmVME5qmRuSTD8eECCmE32hipK3DErpGAidOsTVcCsqPx4JsDDSL4f
         T8kTgJeZ3KhANOdp4ArPyuf/aYJWThRhFZK4gtvbbmV8TvncaOncS+AMwlb/7ke0BL9U
         BYxSylOzRgsb+8t8M/TVjr0TApk7A0OsV58RbeLzXVYw6yd28ujVB4Sjvj0GljQNfvy0
         t0JA==
X-Gm-Message-State: ACgBeo1nr8kt6vKap8ntne2XgBgfLeZP1yhS3QXkub/HmzCRvRjfh5bX
        kw1M/GuKgrY8arQZgLcna+Md
X-Google-Smtp-Source: AA6agR7J9lOpcH4DAcMCYZmGgbbWz6EuCww8Cg5abiUxwkNkJP96/s3sSYcJ793K0ntpPo/MN8xAmg==
X-Received: by 2002:a63:847:0:b0:439:22e4:8e49 with SMTP id 68-20020a630847000000b0043922e48e49mr8965145pgi.165.1663142071017;
        Wed, 14 Sep 2022 00:54:31 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b00174ea015ee2sm10119054plb.38.2022.09.14.00.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:54:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 05/12] PCI: qcom-ep: Expose link transition counts via debugfs
Date:   Wed, 14 Sep 2022 13:23:43 +0530
Message-Id: <20220914075350.7992-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
References: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe controllers have debug registers in the MMIO region
that count PCIe link transitions. Expose them over debugfs to
userspace to help debug the low power issues.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 72eb6cacdb3a..2dc6d4e44aff 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -45,6 +46,11 @@
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
 #define PARF_SRIS_MODE				0x644
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L2		0xc04
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L1		0xc0c
+#define PARF_DEBUG_CNT_PM_LINKST_IN_L0S		0xc10
+#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1	0xc84
+#define PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2	0xc88
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_CFG			0x2c00
 
@@ -135,12 +141,14 @@ enum qcom_pcie_ep_link_status {
  * @pci: Designware PCIe controller struct
  * @parf: Qualcomm PCIe specific PARF register base
  * @elbi: Designware PCIe specific ELBI register base
+ * @mmio: MMIO register base
  * @perst_map: PERST regmap
  * @mmio_res: MMIO region resource
  * @core_reset: PCIe Endpoint core reset
  * @reset: PERST# GPIO
  * @wake: WAKE# GPIO
  * @phy: PHY controller block
+ * @debugfs: PCIe Endpoint Debugfs directory
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count
  * @perst_en: Flag for PERST enable
@@ -154,6 +162,7 @@ struct qcom_pcie_ep {
 
 	void __iomem *parf;
 	void __iomem *elbi;
+	void __iomem *mmio;
 	struct regmap *perst_map;
 	struct resource *mmio_res;
 
@@ -161,6 +170,7 @@ struct qcom_pcie_ep {
 	struct gpio_desc *reset;
 	struct gpio_desc *wake;
 	struct phy *phy;
+	struct dentry *debugfs;
 
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -446,6 +456,9 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
 
 	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 							 "mmio");
+	pcie_ep->mmio = devm_pci_remap_cfg_resource(dev, pcie_ep->mmio_res);
+	if (IS_ERR(pcie_ep->mmio))
+		return PTR_ERR(pcie_ep->mmio);
 
 	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
 	if (!syscon) {
@@ -629,6 +642,37 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 }
 
+static int qcom_pcie_ep_link_transition_count(struct seq_file *s, void *data)
+{
+	struct qcom_pcie_ep *pcie_ep = (struct qcom_pcie_ep *)
+				     dev_get_drvdata(s->private);
+
+	seq_printf(s, "L0s transition count: %u\n",
+		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L0S));
+
+	seq_printf(s, "L1 transition count: %u\n",
+		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L1));
+
+	seq_printf(s, "L1.1 transition count: %u\n",
+		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L1));
+
+	seq_printf(s, "L1.2 transition count: %u\n",
+		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_AUX_CLK_IN_L1SUB_L2));
+
+	seq_printf(s, "L2 transition count: %u\n",
+		   readl_relaxed(pcie_ep->mmio + PARF_DEBUG_CNT_PM_LINKST_IN_L2));
+
+	return 0;
+}
+
+static void qcom_pcie_ep_init_debugfs(struct qcom_pcie_ep *pcie_ep)
+{
+	struct dw_pcie *pci = &pcie_ep->pci;
+
+	debugfs_create_devm_seqfile(pci->dev, "link_transition_count", pcie_ep->debugfs,
+				    qcom_pcie_ep_link_transition_count);
+}
+
 static const struct pci_epc_features qcom_pcie_epc_features = {
 	.linkup_notifier = true,
 	.core_init_notifier = true,
@@ -661,6 +705,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie_ep *pcie_ep;
+	char *name;
 	int ret;
 
 	pcie_ep = devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
@@ -686,8 +731,21 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_disable_resources;
 
+	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
+	if (!name) {
+		ret = -ENOMEM;
+		goto err_disable_irqs;
+	}
+
+	pcie_ep->debugfs = debugfs_create_dir(name, NULL);
+	qcom_pcie_ep_init_debugfs(pcie_ep);
+
 	return 0;
 
+err_disable_irqs:
+	disable_irq(pcie_ep->global_irq);
+	disable_irq(pcie_ep->perst_irq);
+
 err_disable_resources:
 	qcom_pcie_disable_resources(pcie_ep);
 
@@ -701,6 +759,8 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 	disable_irq(pcie_ep->global_irq);
 	disable_irq(pcie_ep->perst_irq);
 
+	debugfs_remove_recursive(pcie_ep->debugfs);
+
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-- 
2.25.1

