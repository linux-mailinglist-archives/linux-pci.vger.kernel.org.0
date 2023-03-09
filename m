Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C36B1EA6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Mar 2023 09:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCIIv0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 03:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjCIIvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 03:51:24 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900A3DB4A4
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 00:51:22 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h31so600639pgl.6
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 00:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmhzqQp9Bpxccy6mDdW3lTo4tjr71oQJII7ujI7fl58=;
        b=nh/pE0tl/ur/aOCSFBmH2ncPGNbOTwJJwvXHqdlLD+uPH/cPU6qpW51OtUOgZPnT7K
         eL/Y8NH5/LbYfpRoeqC7p9lYrM9N+YqMKn3H8rxjGgBz8FVcdBbgzX268HJTCvCUjK7r
         ljbQFSSxKbdhQ8wl/JDJ/NZw6ejkFYDsjlDOGrLJJiFJwOWqwdkNQ15vrSsc+wapIT8C
         0LMkq75IDw25NF/Et38AotiIjCuTI2LHL+R2cogoNkCVzP6bWAs9dg/SOSzST3d9g19v
         LWwtrWjP9DfYjBDgNLdcTza0rLKDDZd/vUUZtnHAfsvNjNUVe08QPmDMRLanMZpOeMOR
         lAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmhzqQp9Bpxccy6mDdW3lTo4tjr71oQJII7ujI7fl58=;
        b=B0tZ4MS/YnmlQGZb2uTOK//lFAY/B6na52ywkRhB91UynmTrQwqqbr2YB/zkH9HQl3
         OCeDBTaC478Twn4tzg3fzS/zMVKRDfU2Z2Dano9E9Jny8wwyiiYmNir718g3+M+GNx3P
         c7DPgigyTmtZrF7jQ0Oo269gH3LjdFgKHZHf67dSHUAf0FNmyoZeSvvDZwnf23cDnVtr
         1uffCdqe+Uys8+nJiTpakzVegYnHz/hzCJBLUCfZfwR1Su1qDREQaj5kNJb9Ht8JMSYh
         Qw9SeFw2bru8mXUA0UkKeNsqDxtzQLKMOjVpp4U559hA/TfrCntQ3jb0nHley4X4eo6Y
         gvvg==
X-Gm-Message-State: AO0yUKW99thvYw6gfBy5GcpMzOZo2Wi5z6oOfdfoaPuvppxMmCH1slTN
        tjs7rgovkX9xlEUTpNLjvaYw
X-Google-Smtp-Source: AK7set9i9R3aPcFTuerd/YiSmyA7sUKX44JPBLyUN+9RSZ61O9Aq8nerOTVBY3oZgtlDcawbVsgKrg==
X-Received: by 2002:aa7:9426:0:b0:60e:950c:7a55 with SMTP id y6-20020aa79426000000b0060e950c7a55mr16609652pfo.9.1678351882014;
        Thu, 09 Mar 2023 00:51:22 -0800 (PST)
Received: from localhost.localdomain ([220.158.158.11])
        by smtp.gmail.com with ESMTPSA id u4-20020aa78484000000b005809d382016sm10638604pfn.74.2023.03.09.00.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:51:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/17] PCI: qcom: Sort and group registers and bitfield definitions
Date:   Thu,  9 Mar 2023 14:20:47 +0530
Message-Id: <20230309085102.120977-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
References: <20230309085102.120977-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorting the registers and their bit definitions will make it easier to add
more definitions in the future and it also helps in maintenance.

While at it, let's also group the registers and bit definitions separately
as done in the pcie-qcom-ep driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 108 ++++++++++++++-----------
 1 file changed, 63 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 6930bc9ceeb5..9223ca76640d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -33,7 +33,36 @@
 #include "../../pci.h"
 #include "pcie-designware.h"
 
+/* PARF registers */
 #define PARF_SYS_CTRL				0x00
+#define PARF_PM_CTRL				0x20
+#define PARF_PCS_DEEMPH				0x34
+#define PARF_PCS_SWING				0x38
+#define PARF_PHY_CTRL				0x40
+#define PARF_PHY_REFCLK				0x4C
+#define PARF_CONFIG_BITS			0x50
+#define PARF_DBI_BASE_ADDR			0x168
+#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP ver 2.3.3 */
+#define PARF_MHI_CLOCK_RESET_CTRL		0x174
+#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
+#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
+#define PARF_Q2A_FLUSH				0x1AC
+#define PARF_LTSSM				0x1B0
+#define PARF_SID_OFFSET				0x234
+#define PARF_BDF_TRANSLATE_CFG			0x24C
+#define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_DEVICE_TYPE			0x1000
+#define PARF_BDF_TO_SID_TABLE_N			0x2000
+
+/* ELBI registers */
+#define ELBI_SYS_CTRL				0x04
+
+/* DBI registers */
+#define AXI_MSTR_RESP_COMP_CTRL0		0x818
+#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
+#define MISC_CONTROL_1_REG			0x8BC
+
+/* PARF_SYS_CTRL register fields */
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -43,45 +72,56 @@
 #define L23_CLK_RMV_DIS				BIT(2)
 #define L1_CLK_RMV_DIS				BIT(1)
 
-#define PARF_PM_CTRL				0x20
+/* PARF_PM_CTRL register fields */
 #define REQ_NOT_ENTR_L1				BIT(5)
 
-#define PARF_PHY_CTRL				0x40
+/* PARF_PCS_DEEMPH register fields */
+#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
+#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
+
+/* PARF_PCS_SWING register fields */
+#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
+#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
+
+/* PARF_PHY_CTRL register fields */
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK	GENMASK(20, 16)
 #define PHY_CTRL_PHY_TX0_TERM_OFFSET(x)		((x) << 16)
 
-#define PARF_PHY_REFCLK				0x4C
+/* PARF_PHY_REFCLK register fields */
 #define PHY_REFCLK_SSP_EN			BIT(16)
 #define PHY_REFCLK_USE_PAD			BIT(12)
 
-#define PARF_DBI_BASE_ADDR			0x168
-#define PARF_SLV_ADDR_SPACE_SIZE_2_3_3		0x16C /* Register offset specific to IP rev 2.3.3 */
-#define PARF_MHI_CLOCK_RESET_CTRL		0x174
+/* PARF_CONFIG_BITS register fields */
+#define PHY_RX0_EQ(x)				((x) << 24)
+
+/* PARF_SLV_ADDR_SPACE_SIZE register value */
+#define SLV_ADDR_SPACE_SZ			0x10000000
+
+/* PARF_MHI_CLOCK_RESET_CTRL register fields */
 #define AHB_CLK_EN				BIT(0)
 #define MSTR_AXI_CLK_EN				BIT(1)
 #define BYPASS					BIT(4)
 
-#define PARF_AXI_MSTR_WR_ADDR_HALT		0x178
-#define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1A8
-#define PARF_LTSSM				0x1B0
-#define PARF_SID_OFFSET				0x234
-#define PARF_BDF_TRANSLATE_CFG			0x24C
-#define PARF_DEVICE_TYPE			0x1000
-#define PARF_BDF_TO_SID_TABLE_N			0x2000
+/* PARF_DEVICE_TYPE register fields */
+#define DEVICE_TYPE_RC				0x4
 
-#define ELBI_SYS_CTRL				0x04
+/* ELBI_SYS_CTRL register fields */
 #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
 
-#define AXI_MSTR_RESP_COMP_CTRL0		0x818
+/* AXI_MSTR_RESP_COMP_CTRL0 register fields */
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K	0x4
 #define CFG_REMOTE_RD_REQ_BRIDGE_SIZE_4K	0x5
-#define AXI_MSTR_RESP_COMP_CTRL1		0x81c
+
+/* AXI_MSTR_RESP_COMP_CTRL1 register fields */
 #define CFG_BRIDGE_SB_INIT			BIT(0)
 
-#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, \
-						250)
-#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, \
-						1)
+/* MISC_CONTROL_1_REG register fields */
+#define DBI_RO_WR_EN				1
+
+/* PCI_EXP_SLTCAP register fields */
+#define PCIE_CAP_SLOT_POWER_LIMIT_VAL		FIELD_PREP(PCI_EXP_SLTCAP_SPLV, 250)
+#define PCIE_CAP_SLOT_POWER_LIMIT_SCALE		FIELD_PREP(PCI_EXP_SLTCAP_SPLS, 1)
 #define PCIE_CAP_SLOT_VAL			(PCI_EXP_SLTCAP_ABP | \
 						PCI_EXP_SLTCAP_PCP | \
 						PCI_EXP_SLTCAP_MRLSP | \
@@ -93,34 +133,12 @@
 						PCIE_CAP_SLOT_POWER_LIMIT_VAL | \
 						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
 
-#define PARF_Q2A_FLUSH				0x1AC
-
-#define MISC_CONTROL_1_REG			0x8BC
-#define DBI_RO_WR_EN				1
-
 #define PERST_DELAY_US				1000
-/* PARF registers */
-#define PARF_PCS_DEEMPH				0x34
-#define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		((x) << 16)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	((x) << 8)
-#define PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(x)	((x) << 0)
-
-#define PARF_PCS_SWING				0x38
-#define PCS_SWING_TX_SWING_FULL(x)		((x) << 8)
-#define PCS_SWING_TX_SWING_LOW(x)		((x) << 0)
-
-#define PARF_CONFIG_BITS			0x50
-#define PHY_RX0_EQ(x)				((x) << 24)
-
-#define PARF_SLV_ADDR_SPACE_SIZE		0x358
-#define SLV_ADDR_SPACE_SZ			0x10000000
-
-#define DEVICE_TYPE_RC				0x4
 
-#define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
-#define QCOM_PCIE_2_1_0_MAX_CLOCKS	5
+#define QCOM_PCIE_2_1_0_MAX_SUPPLY		3
+#define QCOM_PCIE_2_1_0_MAX_CLOCKS		5
 
-#define QCOM_PCIE_CRC8_POLYNOMIAL (BIT(2) | BIT(1) | BIT(0))
+#define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
 struct qcom_pcie_resources_2_1_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_2_1_0_MAX_CLOCKS];
-- 
2.25.1

