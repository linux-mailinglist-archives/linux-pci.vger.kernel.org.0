Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7785A2E4E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiHZSU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 14:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiHZSUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 14:20:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BDE6554C
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:06 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m2so2255037pls.4
        for <linux-pci@vger.kernel.org>; Fri, 26 Aug 2022 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=raWHLS6gJR669YXmkR8TC0V9o68cfdUpfACEFenHvcM=;
        b=JrqGTPs+vSMg7n6WgErUOw1WUM5yEgdqyFHt15gy7+XCg3z6gpa3q+O80ZhyBBgrF8
         p0/lSOe+zsor0vYA5twNS3krJAwOaNKrxusNdZ2Dv1whZSDcgTeUrGz+i1giQowOJs4M
         xpdpqKAW2JURhIxXcZqChUeThrPImDKb1qb81RVBaMxl7swMvAp3Q0KGEBR04RBQxQUB
         ZrfbrHRWVn05qZep6CX5bid0c+idexDCFhAhvvn1SMql/a0NwI0H3SlBCveIchTvYCCf
         dUipwa0nNNcxBsPFhRVRIOYiL2oriSUSxbxuPkJwBYffSjaYIcUugTDqhKtenHBbCZTl
         qg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=raWHLS6gJR669YXmkR8TC0V9o68cfdUpfACEFenHvcM=;
        b=1XYnIxWnXXhyUwOGVzvJ9ULWCSWpPUjmsdRk12OLh4MTAaiXlm2XiJ9ouzGnISrd3g
         AWsWHosQvHh3XfnaGfJsZbR0pEcpxczZdeNdt0LB/nn57jooEz6OHlVRxrJ+kRJ0wKLX
         8GNUlQNQ/eKILdgvB/fr5jd1v59zBOBZdzQgpHX1RxmSwHtBx7gNL8g+DHYX1jvZ/nxb
         I+fGip6p65ek7IQfdYuoccJQpBO12bz84CdrtVT67feuyvmtQgox9uUdvD+HM/YJYcB4
         McUUszcDf9tIowtgqnnM7rnZ8tv3FMouZTUwOvnktyn1pYQsAOc+vyMYxbdhcUoP3/Om
         lrbA==
X-Gm-Message-State: ACgBeo2ep3Q1lwuh1nm+aRJ2LVVSRuYaLjUyTCpI75ixv7Wo8Tlb2ZRp
        W9dt5aJw8wBUny2dp9CWNNbG
X-Google-Smtp-Source: AA6agR5+XMOm1CY+Y+9/gAbDkyJNvVCVUYRuyL8PZtt/fW45j6L9kvyl9xQ1rNUkMTwONYT6zr0TDA==
X-Received: by 2002:a17:90a:150f:b0:1fb:aee:cd2a with SMTP id l15-20020a17090a150f00b001fb0aeecd2amr5693261pja.47.1661538006334;
        Fri, 26 Aug 2022 11:20:06 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 06/11] PCI: qcom-ep: Add debugfs support for expose link transition counts
Date:   Fri, 26 Aug 2022 23:49:18 +0530
Message-Id: <20220826181923.251564-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe controllers have the debug registers in the MMIO region
that counts the PCIe link transitions. Let's expose them over debugfs to
userspace to help debugging the low power issues.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 98ef36e3a94d..54ac2fef8b88 100644
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
 
@@ -136,12 +142,14 @@ enum qcom_pcie_ep_link_status {
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
@@ -155,6 +163,7 @@ struct qcom_pcie_ep {
 
 	void __iomem *parf;
 	void __iomem *elbi;
+	void __iomem *mmio;
 	struct regmap *perst_map;
 	struct resource *mmio_res;
 
@@ -162,6 +171,7 @@ struct qcom_pcie_ep {
 	struct gpio_desc *reset;
 	struct gpio_desc *wake;
 	struct phy *phy;
+	struct dentry *debugfs;
 
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -447,6 +457,9 @@ static int qcom_pcie_ep_get_io_resources(struct platform_device *pdev,
 
 	pcie_ep->mmio_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 							 "mmio");
+	pcie_ep->mmio = devm_pci_remap_cfg_resource(dev, pcie_ep->mmio_res);
+	if (IS_ERR(pcie_ep->mmio))
+		return PTR_ERR(pcie_ep->mmio);
 
 	syscon = of_parse_phandle(dev->of_node, "qcom,perst-regs", 0);
 	if (!syscon) {
@@ -630,6 +643,37 @@ static int qcom_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
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
@@ -662,6 +706,7 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie_ep *pcie_ep;
+	char *name;
 	int ret;
 
 	pcie_ep = devm_kzalloc(dev, sizeof(*pcie_ep), GFP_KERNEL);
@@ -688,8 +733,21 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
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
 
@@ -703,6 +761,8 @@ static int qcom_pcie_ep_remove(struct platform_device *pdev)
 	disable_irq(pcie_ep->global_irq);
 	disable_irq(pcie_ep->perst_irq);
 
+	debugfs_remove_recursive(pcie_ep->debugfs);
+
 	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED)
 		return 0;
 
-- 
2.25.1

