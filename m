Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDD9283357
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJEJcj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJEJci (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Oct 2020 05:32:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93ACC0613A7
        for <linux-pci@vger.kernel.org>; Mon,  5 Oct 2020 02:32:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w21so6464786pfc.7
        for <linux-pci@vger.kernel.org>; Mon, 05 Oct 2020 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKDeQ+IosCKCy2VJYLI4jBwAgZsjG0uDvbjuAjcvB74=;
        b=LSHVzIitOUNuiMhH/Z1zVVHIssPgiRlKh8Xmy0SSJDZgbbJKb32iUs0kwnCxzhbV8Y
         OxyGg7r+kwCTvq30UyoZjNAEN9hQS/2DDCdfU1RJCNikitvlsQqT4KTH7nPvy4j26eoN
         MzyzqN7OOTzIIRh0ICOud1sZFkZ9hXvazQTzorgd8F3qnZ83O1efuSXr2V1Wuj621dfJ
         lsIWfsdzrCAyGxoAPzM3fci8OBvLVPY5c797qKKYQwUgb3Q4j+vDeFWDAqC2V8dp4k9C
         g8oudm/Z9qkIp1d8PdXxWid/ySbXgCRStJhAo+hQgg0SwCnEVs5QoqYPLt9DjlHMZ7y2
         Bbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKDeQ+IosCKCy2VJYLI4jBwAgZsjG0uDvbjuAjcvB74=;
        b=TdL+j9+TrgdiyLSFQsASl8MHf8fo37uZjoeVtZiCz6bMJGe1s9Q9q5/iEtw1ntjNby
         Fm+XaMLg65vY5xYPh7b1YqDEon1vziJ4PpMeMXZ6s4WH5hAkJ3+PZlwvRCfw66a9+yAv
         kQEHyF/3zUg3sAlTdmuUFp+W3VvTej7qNHm7RaL1QIS6KMO9o/4ZOlbSunFur/VZSegr
         d0TEkIJW6afhTsptyVQW9mVB9qy/RVcPQiUzXEYOW6N96nT4oFGQu4bqjfWifjALN1es
         6V5DXW5Ekg7nBrha0j6zQxPS272tEK9z0UBlxHy9O6jfxdkCDgjJjccBksF0zUhlBBWe
         dwoA==
X-Gm-Message-State: AOAM533hXfWrlFPUQ1vLquiMqJZaTkfNPbNHZoDJ2m7iSxaEDQoeYc+0
        snl3/5eozOdtthBYjNKl8Hme
X-Google-Smtp-Source: ABdhPJwZ64lOMWCTtda7JMZhcuWAv9qtW3jvGVmrfDJyxRlNSRj72fpF254Jlf81utB8Nk6w7DOdLg==
X-Received: by 2002:a05:6a00:2d5:b029:152:197a:a23a with SMTP id b21-20020a056a0002d5b0290152197aa23amr16237233pft.66.1601890358121;
        Mon, 05 Oct 2020 02:32:38 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 124sm11298894pfd.132.2020.10.05.02.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 02:32:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 5/5] PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
Date:   Mon,  5 Oct 2020 15:01:52 +0530
Message-Id: <20201005093152.13489-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
References: <20201005093152.13489-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For SM8250, we need to write the BDF to SID mapping in PCIe controller
register space for proper working. This is accomplished by extracting
the BDF and SID values from "iommu-map" property in DT and writing those
in the register address calculated from the hash value of BDF. In case
of collisions, the index of the next entry will also be written.

For the sake of it, let's introduce a "config_sid" callback and do it
conditionally for SM8250.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig     |   1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 138 +++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 044a3761c44f..3e9ccdc45ee1 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -169,6 +169,7 @@ config PCIE_QCOM
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select CRC8
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3167ad66413d..5e1b88ffc23c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/crc8.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
@@ -57,6 +58,7 @@
 #define PCIE20_PARF_SID_OFFSET			0x234
 #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
 #define PCIE20_PARF_DEVICE_TYPE			0x1000
+#define PCIE20_PARF_BDF_TO_SID_TABLE_N		0x2000
 
 #define PCIE20_ELBI_SYS_CTRL			0x04
 #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
@@ -101,6 +103,9 @@
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
 #define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
+
+#define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
+
 struct qcom_pcie_resources_2_1_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
 	struct reset_control *pci_reset;
@@ -183,6 +188,16 @@ struct qcom_pcie_ops {
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
+	int (*config_sid)(struct qcom_pcie *pcie);
+};
+
+/* sid info structure */
+struct qcom_pcie_sid_info_t {
+	u16 bdf;
+	u8 pcie_sid;
+	u8 hash;
+	u32 smmu_sid;
+	u32 value;
 };
 
 struct qcom_pcie {
@@ -193,6 +208,8 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	const struct qcom_pcie_ops *ops;
+	struct qcom_pcie_sid_info_t *sid_info;
+	u32 sid_info_len;
 	int gen;
 };
 
@@ -1257,6 +1274,120 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static int qcom_pcie_get_iommu_map(struct qcom_pcie *pcie)
+{
+	/* iommu map structure */
+	struct {
+		u32 bdf;
+		u32 phandle;
+		u32 smmu_sid;
+		u32 smmu_sid_len;
+	} *map;
+	struct device *dev = pcie->pci->dev;
+	int i, size = 0;
+	u32 smmu_sid_base;
+
+	of_get_property(dev->of_node, "iommu-map", &size);
+	if (!size)
+		return 0;
+
+	map = kzalloc(size, GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	of_property_read_u32_array(dev->of_node,
+		"iommu-map", (u32 *)map, size / sizeof(u32));
+
+	pcie->sid_info_len = size / (sizeof(*map));
+	pcie->sid_info = devm_kcalloc(dev, pcie->sid_info_len,
+				sizeof(*pcie->sid_info), GFP_KERNEL);
+	if (!pcie->sid_info) {
+		kfree(map);
+		return -ENOMEM;
+	}
+
+	/* Extract the SMMU SID base from the first entry of iommu-map */
+	smmu_sid_base = map[0].smmu_sid;
+	for (i = 0; i < pcie->sid_info_len; i++) {
+		pcie->sid_info[i].bdf = map[i].bdf;
+		pcie->sid_info[i].smmu_sid = map[i].smmu_sid;
+		pcie->sid_info[i].pcie_sid =
+				pcie->sid_info[i].smmu_sid - smmu_sid_base;
+	}
+
+	kfree(map);
+
+	return 0;
+}
+
+static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
+{
+	void __iomem *bdf_to_sid_base = pcie->parf +
+		PCIE20_PARF_BDF_TO_SID_TABLE_N;
+	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
+	int ret, i;
+
+	ret = qcom_pcie_get_iommu_map(pcie);
+	if (ret)
+		return ret;
+
+	if (!pcie->sid_info)
+		return 0;
+
+	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
+
+	/* Registers need to be zero out first */
+	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
+
+	/* Initial setup for boot */
+	for (i = 0; i < pcie->sid_info_len; i++) {
+		struct qcom_pcie_sid_info_t *sid_info = &pcie->sid_info[i];
+		u16 bdf_be = cpu_to_be16(sid_info->bdf);
+		u32 val;
+		u8 hash;
+
+		hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be),
+			0);
+
+		val = readl(bdf_to_sid_base + hash * sizeof(u32));
+
+		/* If there is a collision, look for next available entry */
+		while (val) {
+			u8 current_hash = hash++;
+			u8 next_mask = 0xff;
+
+			/* If NEXT field is NULL then update it with next hash */
+			if (!(val & next_mask)) {
+				int j;
+
+				val |= (u32)hash;
+				writel(val, bdf_to_sid_base +
+					current_hash * sizeof(u32));
+
+				/* Look for sid_info of current hash and update it */
+				for (j = 0; j < pcie->sid_info_len; j++) {
+					if (pcie->sid_info[j].hash !=
+						current_hash)
+						continue;
+
+					pcie->sid_info[j].value = val;
+					break;
+				}
+			}
+
+			val = readl(bdf_to_sid_base + hash * sizeof(u32));
+		}
+
+		val = sid_info->bdf << 16 | sid_info->pcie_sid << 8 | 0;
+		writel(val, bdf_to_sid_base + hash * sizeof(u32));
+
+		sid_info->hash = hash;
+		sid_info->value = val;
+	}
+
+	return 0;
+}
+
 static int qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1290,6 +1421,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		goto err;
 
+	if (pcie->ops->config_sid) {
+		ret = pcie->ops->config_sid(pcie);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
 err:
 	qcom_ep_reset_assert(pcie);
@@ -1367,6 +1504,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.17.1

