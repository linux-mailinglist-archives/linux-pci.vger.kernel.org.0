Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25325B448C
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiIJGcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiIJGbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:31:55 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68871AB4CD
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bq9so6603101wrb.4
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=BmOWU26gjLBIOonkKcZ0ILBj0OeiqDzaVAugyvdHpNQ=;
        b=l8jZi7lseGJa72/OntBTkuPuDk/P0PB9iXvlzvIORfvCfD3bXM3yCQTFf6XSgv1PF5
         uyMWu5P81vkQ9UYzOTchcdoXPUH/ztw2MMP5AuTylhJ7nfkxrZq3IRBybGeFyJuZu9dO
         idUP2QdUQgCCi5gO7MNy+n5crbG3CzVDVYhL2ZRLnzdQXaz0bn2LqshBCiZ5EmqqiEBt
         0nO03a9wvb+74+eBY4Y85UJmUmEzs1MeLuw38Nslu3sxwuY4TmmvZKozlCndTt9buUuk
         AoUxjpMHh9bck/Srs8CPpu+/xcz9pdxiXZ9IxqgbHLHPbYTR/CmXlOtmPVgs8f4cZohU
         X+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BmOWU26gjLBIOonkKcZ0ILBj0OeiqDzaVAugyvdHpNQ=;
        b=CXjAvwHEISvsSHkNTMZ/rD8NGKz0k1zOGYF6xP9zhoRBaO2LA7f/EBoKt07VzxGiHp
         jqGAD7fRMNfqmtKoeq9LVgi/OlH11mN2+nfMtQ5iGePRLR98kLQ2d+R2qCO89g815jS3
         r3c97KtR7QEjkNZ/EnfLM0azQwG9VxV2iUaKBfRuwaCYGO7JVH/8u6UajdRq9aM+9Osu
         /tAnicZI22c854Vwa2lnOZw+Zoup9YaMEAZPu21z70A7CoER/3Hp5COVCHU9acX9x/QT
         whLT9PTm/pCDVuDx6VlywSoertJXzP/JUyWY6OcJO/4AxzrK3CmmSiFVuiembhsYm2/t
         1OFw==
X-Gm-Message-State: ACgBeo1wAGZbFbYCcqbp7OoytzdmsWKv0qHHyvgx9j4BjiWbX1XaCCH4
        pkC8QaT/fl/npLg3JpDGp5Yx
X-Google-Smtp-Source: AA6agR5ZancBBxmGlu6F9A9DnmcErtq69rlt5YyM7B+L6IQsVG0GzH5XSK9uI+ElK78X2QCbI0zevg==
X-Received: by 2002:a5d:6484:0:b0:226:dd0e:b09c with SMTP id o4-20020a5d6484000000b00226dd0eb09cmr9899589wri.388.1662791501106;
        Fri, 09 Sep 2022 23:31:41 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 05/12] PCI: qcom-ep: Expose link transition counts via debugfs
Date:   Sat, 10 Sep 2022 12:00:38 +0530
Message-Id: <20220910063045.16648-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
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

