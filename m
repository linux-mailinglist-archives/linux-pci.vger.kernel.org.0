Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A4D6BC89C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Mar 2023 09:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCPINi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCPINF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 04:13:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F0DB483E
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:12:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so4508445pjv.5
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDp9iUBZsCwH8QMFEBG7fLRnQFzAu78e/Q2Yut6AWzM=;
        b=CjFdJf4wrkcowm/oR2ZXiZ6gEZsOmi2m5wjpBCAYf5Lqqomz1hanAuej52p2N/RSaT
         5/nCzNIr4pVvvtBVbBLj7e9CBeMkerWm8639BRSvI0vm6Yj7YBogv2v2u2PXV8S+nV11
         IHvW4UU0fuRF2bWxqKZhpIFNwjO9IJNi7JdAZlGNVlQ+rPIH/YoeFuWPJW3Ptm6dPjKH
         FCS+RUWrIhr523xAz1n2b/YmMX1BqbQXsebBl7+4TUAfoyUOJso+Pe6r9Xj7TEydiuYI
         i3yVnpHzRXkxhTKRtJnL8Si3KiLrzWw1v91hIyEd49YJZjs/LFv2dRB3d0hNuJQT2Xdx
         sGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDp9iUBZsCwH8QMFEBG7fLRnQFzAu78e/Q2Yut6AWzM=;
        b=qYm7DEzAmLpByQ9divgR6Ep4B7N0XycKZ88+FMD0uLgZg3IapjHTbe2ID/Tk0koJTV
         U66uzPgbCDPGE0L8J4Fr3QcoDVF5f5kyFPjmoLOptL26T+Yw9scBQsqpslY2qh96sjNS
         UM97Q+JBWDH2MgmuBbL56uMKis7WMkmPR/NS6NqjridwlEsbgoe+w0AczP4hxukMrZOk
         h2h1dxHw1OQ4kq4BnITnAlGY7h1OqQw58Uq28U/Ptan3ChPy4WnPhzPQuQm28F6NZMfZ
         99hK3dWzvWGZjpMcC50SN214NgC3OGqeGfjYqjVZyrovQaW6RY4h+qr/jjB8PDMUW706
         Jnpw==
X-Gm-Message-State: AO0yUKVBaD6EU3wPfAq1LDuBfZnqwiDPVwYApbWQR/PGh/XtbsV8XKcL
        2J3IuN6UUk5TIexhIGv1iled
X-Google-Smtp-Source: AK7set+SdjtQIWb0j9DfFPmfrAYxu6ZX/P/2/DqUO2ZWVnIASGk4ZvtpZN9eE8L3tIeqd68CLOvZ9Q==
X-Received: by 2002:a05:6a20:3d11:b0:cc:c3f7:9193 with SMTP id y17-20020a056a203d1100b000ccc3f79193mr3267783pzi.3.1678954354267;
        Thu, 16 Mar 2023 01:12:34 -0700 (PDT)
Received: from localhost.localdomain ([117.207.30.24])
        by smtp.gmail.com with ESMTPSA id 13-20020aa7910d000000b005d9984a947bsm4804422pfh.139.2023.03.16.01.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:12:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 14/19] PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
Date:   Thu, 16 Mar 2023 13:41:12 +0530
Message-Id: <20230316081117.14288-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
References: <20230316081117.14288-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

qcom_pcie_config_sid_sm8250() function no longer applies only to SM8250.
So let's rename it to reflect the actual IP version and also move its
definition to keep it sorted as per IP revisions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 143 ++++++++++++-------------
 1 file changed, 71 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5aef890e627a..7daff0421b86 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -961,6 +961,76 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
 	regulator_bulk_disable(ARRAY_SIZE(res->supplies), res->supplies);
 }
 
+static int qcom_pcie_config_sid_1_9_0(struct qcom_pcie *pcie)
+{
+	/* iommu map structure */
+	struct {
+		u32 bdf;
+		u32 phandle;
+		u32 smmu_sid;
+		u32 smmu_sid_len;
+	} *map;
+	void __iomem *bdf_to_sid_base = pcie->parf + PARF_BDF_TO_SID_TABLE_N;
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
+	of_property_read_u32_array(dev->of_node, "iommu-map", (u32 *)map,
+				   size / sizeof(u32));
+
+	nr_map = size / (sizeof(*map));
+
+	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
+
+	/* Registers need to be zero out first */
+	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
+
+	/* Extract the SMMU SID base from the first entry of iommu-map */
+	smmu_sid_base = map[0].smmu_sid;
+
+	/* Look for an available entry to hold the mapping */
+	for (i = 0; i < nr_map; i++) {
+		__be16 bdf_be = cpu_to_be16(map[i].bdf);
+		u32 val;
+		u8 hash;
+
+		hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be), 0);
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
 static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
@@ -1075,77 +1145,6 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
 	return !!(val & PCI_EXP_LNKSTA_DLLLA);
 }
 
-static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
-{
-	/* iommu map structure */
-	struct {
-		u32 bdf;
-		u32 phandle;
-		u32 smmu_sid;
-		u32 smmu_sid_len;
-	} *map;
-	void __iomem *bdf_to_sid_base = pcie->parf + PARF_BDF_TO_SID_TABLE_N;
-	struct device *dev = pcie->pci->dev;
-	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
-	int i, nr_map, size = 0;
-	u32 smmu_sid_base;
-
-	of_get_property(dev->of_node, "iommu-map", &size);
-	if (!size)
-		return 0;
-
-	map = kzalloc(size, GFP_KERNEL);
-	if (!map)
-		return -ENOMEM;
-
-	of_property_read_u32_array(dev->of_node,
-		"iommu-map", (u32 *)map, size / sizeof(u32));
-
-	nr_map = size / (sizeof(*map));
-
-	crc8_populate_msb(qcom_pcie_crc8_table, QCOM_PCIE_CRC8_POLYNOMIAL);
-
-	/* Registers need to be zero out first */
-	memset_io(bdf_to_sid_base, 0, CRC8_TABLE_SIZE * sizeof(u32));
-
-	/* Extract the SMMU SID base from the first entry of iommu-map */
-	smmu_sid_base = map[0].smmu_sid;
-
-	/* Look for an available entry to hold the mapping */
-	for (i = 0; i < nr_map; i++) {
-		__be16 bdf_be = cpu_to_be16(map[i].bdf);
-		u32 val;
-		u8 hash;
-
-		hash = crc8(qcom_pcie_crc8_table, (u8 *)&bdf_be, sizeof(bdf_be),
-			0);
-
-		val = readl(bdf_to_sid_base + hash * sizeof(u32));
-
-		/* If the register is already populated, look for next available entry */
-		while (val) {
-			u8 current_hash = hash++;
-			u8 next_mask = 0xff;
-
-			/* If NEXT field is NULL then update it with next hash */
-			if (!(val & next_mask)) {
-				val |= (u32)hash;
-				writel(val, bdf_to_sid_base + current_hash * sizeof(u32));
-			}
-
-			val = readl(bdf_to_sid_base + hash * sizeof(u32));
-		}
-
-		/* BDF [31:16] | SID [15:8] | NEXT [7:0] */
-		val = map[i].bdf << 16 | (map[i].smmu_sid - smmu_sid_base) << 8 | 0;
-		writel(val, bdf_to_sid_base + hash * sizeof(u32));
-	}
-
-	kfree(map);
-
-	return 0;
-}
-
 static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1266,7 +1265,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.config_sid = qcom_pcie_config_sid_sm8250,
+	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
-- 
2.25.1

