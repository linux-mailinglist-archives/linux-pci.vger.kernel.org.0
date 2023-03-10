Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C426B3561
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCJELg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjCJEKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:10:30 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BB5103ECE
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:09:37 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so8516371pjb.3
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwnOfx0fvyN0EVTsIZtRO7GfnRR3nR2D8SXkkwhJ4Fg=;
        b=o5wWWCRwfCXHSDaJxzI5Mf0pLfNmuyFz7riyLzkoGymmZQfSSsmTjU+/5Mlp9ssne7
         Ep95fbLjk6WW5RtwHDocEkWwpq0QL/sl0s+Nagd/8gKTsbf2G1h8Jn+RAqLWb1izc3uj
         NdVKgXjonyb+mTtpUY8PqCTMqgqcIX9/evmnxS1uoECVYoutQOT1Vfd9X1atz3pF6sny
         OjoTlHqIEY2s5Huxk/GYz8kgINIs0s6bbbzxw4A/QFa3Yq/MFcNHyQQmWalZcVXxVW5O
         mwADWZN5YQyi6s807g6yhpnxeCCYtSbmlwiuPbCIUxqSDqQfoPCxrWmyvOWy4MROTLnm
         OJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwnOfx0fvyN0EVTsIZtRO7GfnRR3nR2D8SXkkwhJ4Fg=;
        b=gfgCBlWiH3e1go7HdUxwG6xwzDi5+t/ol/cKWI27tXb992wx4J312KDPHB9XW9m3JO
         3QOGaRU/l8ezawcVCHCLsS/IUe+lPKzgUHP+nblZHo30kU9RJhGjoa/fngmikymvhYg9
         MeJm5go4edGQMTZ3ayJWw11QuAESNKl8hJdBTrD0MmVK2JNXEBhI0cU8jRG2q7r+o4Ft
         5j6k9X0MdRJ0AEYZ55GhzSZiIP36igtAa16okKqj7m9a7+2+9G1gprQFkEoSpPosDJFk
         Beiinjuow2vQKdrEVHx0LOD5YHe4+SL/rEY2359HKGaZMnZ4OwrtZ+5jgB/A1/crFzo8
         vB1w==
X-Gm-Message-State: AO0yUKX54VmH7mfVhxvbvrtA/MsIYO7znU3ZESxQZZtFwDgWZ4ZOl+eu
        P3Tn7mMwMA42dR1PM9yHmrG4
X-Google-Smtp-Source: AK7set/GexmOu8Sz+VUdsdW4q2IO5caUK8Y6GG/EjOSAGqfhM4ouRgYxJupAJJ1BfkVuhOIdAvpsvQ==
X-Received: by 2002:a05:6a21:338f:b0:cb:b92c:b46e with SMTP id yy15-20020a056a21338f00b000cbb92cb46emr1056989pzb.9.1678421367512;
        Thu, 09 Mar 2023 20:09:27 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:26 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 13/19] PCI: qcom: Rename qcom_pcie_config_sid_sm8250() to reflect IP version
Date:   Fri, 10 Mar 2023 09:38:10 +0530
Message-Id: <20230310040816.22094-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/pci/controller/dwc/pcie-qcom.c | 144 ++++++++++++-------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e1180c84f0fa..52f09ee8dd48 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -963,6 +963,77 @@ static void qcom_pcie_deinit_2_7_0(struct qcom_pcie *pcie)
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
+	/* Extract the SMMU SID base from the first entry of iommu-map */
+	smmu_sid_base = map[0].smmu_sid;
+
+	/* Look for an available entry to hold the mapping */
+	for (i = 0; i < nr_map; i++) {
+		__be16 bdf_be = cpu_to_be16(map[i].bdf);
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
 static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
@@ -1077,77 +1148,6 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
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
@@ -1268,7 +1268,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.init = qcom_pcie_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
-	.config_sid = qcom_pcie_config_sid_sm8250,
+	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
-- 
2.25.1

