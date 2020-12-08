Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6EC2D2A86
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 13:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgLHMPs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 07:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729510AbgLHMPr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 07:15:47 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDD0C0611CC
        for <linux-pci@vger.kernel.org>; Tue,  8 Dec 2020 04:14:31 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so12004266pgg.13
        for <linux-pci@vger.kernel.org>; Tue, 08 Dec 2020 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDvekhOZBy1MNPHrRwusPFUHFCSthZomwsqXTmVrS6A=;
        b=b57gCj3UqYC2jWUo3rElLUcjxh75NG1Xpelz8Ncw7Nuw9O5zApb3SyHUb8dfCpdeaj
         g8xZzNz8yhFzM10zEmfwyCcL3XRCuE/pDAZ0ZZYY+aRKIeNMxS6pQZ6UMPuYrP90Ocpk
         09tSJWTh7fuxKMsquS6x7VLYuCN/cWWy1OlruEFXxN6JLhR/H2to9x9YGzAk/20DFBPU
         O47qZuo9O0WQBaHUJsswsLe5tjMS/QtF3LglbwK5hc/bsMjOoHP8T/DxQeY9x/UITmuE
         rPu9WJjZpRrxNh3GHZJ4sbX7agT+dwTiG3emfxYLFFTqfksnP3s0JXKhI18ohSF0FQ5/
         Pdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDvekhOZBy1MNPHrRwusPFUHFCSthZomwsqXTmVrS6A=;
        b=pTyKHs8KdCZLXp6eHQVhqqC62CyILB8lW6lknSRZYZR9Efinr+9hihIo1MPFD1UK7B
         fE3PDv5pf+XsbSv4HFTrzqjfQtN0mlKMZ4u/fJGIHtdyC0PyWj9ytqPwRUCt4h9Fn++h
         9o2d1FzxIn6uGjTRo1BNNJSQ+qA/j/IlSiakBdLUcjw4JBdw30vEMgej7+SiMmBswtjA
         FFnhzCzGpgiA5ZeDfWGSHyUWi+qNdOv1fLHMbcNniuaZhBMYssSMxgEye3JW5XQLXgp4
         dVQ9COySp8gjyNuB7RT8g7dbML8PdXxv+RjydHIGy2EDIxeQpU/7EroybCHvFL0gBFIl
         CNQA==
X-Gm-Message-State: AOAM533WgGK3ZQl9Apy7wOdlwLdUdpmok9XyBxSgrOddyW4dhZEHgDyP
        2CFSdNmKdsBhnV00eGQtIrLv
X-Google-Smtp-Source: ABdhPJxY7Q7R5gkH5nVweDLNXS1SYrKGYlXeQ6/KiaRFLagU/42KD+8+ryvgCJyK38CqFeg4ZXWDbQ==
X-Received: by 2002:a63:150b:: with SMTP id v11mr22915166pgl.257.1607429671390;
        Tue, 08 Dec 2020 04:14:31 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id v3sm3489889pjn.7.2020.12.08.04.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 04:14:30 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To:     lorenzo.pieralisi@arm.com
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        svarbanov@mm-sol.com, bhelgaas@google.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org, truong@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 3/3] PCI: qcom: Add support for configuring BDF to SID mapping for SM8250
Date:   Tue,  8 Dec 2020 17:44:02 +0530
Message-Id: <20201208121402.178011-4-mani@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208121402.178011-1-mani@kernel.org>
References: <20201208121402.178011-1-mani@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

For SM8250, we need to write the BDF to SID mapping in PCIe controller
register space for proper working. This is accomplished by extracting
the BDF and SID values from "iommu-map" property in DT and writing those
in the register address calculated from the hash value of BDF. In case
of collisions, the index of the next entry will also be written.

For the sake of it, let's introduce a "config_sid" callback and do it
conditionally for SM8250.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pci/controller/dwc/Kconfig     |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c | 85 ++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 9ee1e248e744..dd4596bdda49 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -174,6 +174,7 @@ config PCIE_QCOM
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select CRC8
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 750ff7378870..8ba3e6b29196 100644
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
@@ -1258,6 +1264,74 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
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
@@ -1282,8 +1356,18 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 
 	qcom_ep_reset_deassert(pcie);
 
+	if (pcie->ops->config_sid) {
+		ret = pcie->ops->config_sid(pcie);
+		if (ret)
+			goto err;
+	}
+
 	return 0;
 
+err:
+	qcom_ep_reset_assert(pcie);
+	if (pcie->ops->post_deinit)
+		pcie->ops->post_deinit(pcie);
 err_disable_phy:
 	phy_power_off(pcie->phy);
 err_deinit:
@@ -1356,6 +1440,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 	.post_init = qcom_pcie_post_init_2_7_0,
 	.post_deinit = qcom_pcie_post_deinit_2_7_0,
+	.config_sid = qcom_pcie_config_sid_sm8250,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.25.1

