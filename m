Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4CD29BF24
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 18:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814990AbgJ0RBL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 13:01:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37571 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1815001AbgJ0RBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 13:01:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id 126so1268885pfu.4
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=71+u6FRijkoEpDOdg3DRr0Oc2oaGmI+yxEaraGKKORg=;
        b=yO1RhcWmIgUhFqLNVBEtSTONRWDrGMS3rdb2Z48LtItApUZWRciYT3ctZo4Ahoq0Nh
         74lSzz9i3vLwXMLn7J8JjIbQ+XMjqIgqguv0pxstLHcrPPOK/qvqhDsehSPS1ILmEbiR
         Bxh6xnWxAM8YQeuutDQTCfT1ne/8vX2v1pcH7o55UZAPC4D8DBf8sbeoFKw6mHrVYsFn
         f8jGm89J6Q+8Y/kikTt0act9yzAC2ekyT23XhGBaNTe2zVSzfdjcePzko6p13VmYkLP5
         192XYSNjNpxdSL4quO8WnCbCYVto/8szf8T58xxD4juSP9s4j5WngYsX42uAWaF6HFrq
         4tNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=71+u6FRijkoEpDOdg3DRr0Oc2oaGmI+yxEaraGKKORg=;
        b=lCsyJE7AeXgKTCpU9sWWej+yDIo8k786lLK4zjgII8qBqI9ipyGr5gwOLnznn+DB0M
         rX9t0WVns9tlHLqZhEtUPT/L1XT3m86E7qYFowCyLBEvcEGjw2toWz27UeCW8o3GGV7I
         a1tfDms9vUesWZSjfQfjCG6cPtpALCXy82lpbhM8gSIAuq0kIpbAiVjwCDc0q1QGVuxU
         XPBYkHMO4J+ImK/5f3eU5K5b97rJmxGEiukbSVF/zwQv8BVc7zhMop7WXR9zvGjBZtlX
         dCVi8Z7dt7Dzdihu76qB+lvQR1T9rtLMs3bXOwprFX7YfUbJCv+3BEsN1wSDUIRnF+1C
         raEw==
X-Gm-Message-State: AOAM532UBCw8zMLUd1C4s/qt68r5eATV2s+sr3EW3cGx6NdHLeRrudEO
        B4uHdEK10qbMvVHwwTwg3YdZBn6eR8uOknY=
X-Google-Smtp-Source: ABdhPJyT682CP4WnIlBCpAnGRH1ruBybut7MV6l+wroy5IG+kF5XMgQ6/zwezjjeJZr3jT3yZypwzA==
X-Received: by 2002:a63:3d8b:: with SMTP id k133mr2693111pga.413.1603818069652;
        Tue, 27 Oct 2020 10:01:09 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id x26sm2845206pfn.178.2020.10.27.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 10:01:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org
Cc:     svarbanov@mm-sol.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgautam@codeaurora.org, devicetree@vger.kernel.org,
        truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 5/5] PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
Date:   Tue, 27 Oct 2020 22:30:33 +0530
Message-Id: <20201027170033.8475-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
References: <20201027170033.8475-1-manivannan.sadhasivam@linaro.org>
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

Rob: I've dropped your review tag as this patch has gone through some
change (mostly cleanups though)

 drivers/pci/controller/dwc/Kconfig     |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index bc049865f8e0..875ebc6e8884 100644
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
index 0b180a19b0ea..2148fcf74294 100644
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
@@ -97,6 +99,9 @@
 
 #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
 #define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
+
+#define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
+
 struct qcom_pcie_resources_2_1_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
 	struct reset_control *pci_reset;
@@ -179,6 +184,7 @@ struct qcom_pcie_ops {
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*post_deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
+	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
 struct qcom_pcie {
@@ -1261,6 +1267,74 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
+static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
+{
+	/* iommu map structure */
+	struct {
+		u32 bdf;
+		u32 phandle;
+		u32 smmu_sid;
+		u32 smmu_sid_len;
+	} *map;
+	void __iomem *bdf_to_sid_base = pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N;
+	struct device *dev = pcie->pci->dev;
+	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
+	int i, nr_map, size = 0;
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
+	nr_map = size / (sizeof(*map));
+
+	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
+
+	/* Registers need to be zero out first */
+	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
+
+	/* Look for an available entry to hold the mapping */
+	for (i = 0; i < nr_map; i++) {
+		u16 bdf_be = cpu_to_be16(map[i].bdf);
+		u32 val;
+		u8 hash;
+
+		hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be),
+			0);
+
+		val = readl(bdf_to_sid_base + hash * sizeof(u32));
+
+		/* If the register is already populated, look for next available entry */
+		while (val) {
+			u8 current_hash = hash++;
+			u8 next_mask = 0xff;
+
+			/* If NEXT field is NULL then update it with next hash */
+			if (!(val & next_mask)) {
+				val |= (u32)hash;
+				writel(val, bdf_to_sid_base + current_hash * sizeof(u32));
+			}
+
+			val = readl(bdf_to_sid_base + hash * sizeof(u32));
+		}
+
+		/* BDF [31:16] | SID [15:8] | NEXT [7:0] */
+		val = map[i].bdf << 16 | (map[i].smmu_sid - smmu_sid_base) << 8 | 0;
+		writel(val, bdf_to_sid_base + hash * sizeof(u32));
+	}
+
+	kfree(map);
+
+	return 0;
+}
+
 static int qcom_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1292,6 +1366,12 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
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
@@ -1369,6 +1449,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.17.1

