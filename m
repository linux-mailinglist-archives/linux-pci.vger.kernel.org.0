Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E896B3575
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCJEMg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCJELQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:11:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0694EE774
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:09:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x11so4285309pln.12
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cfp/acTiWdK8wUm8C9dXVBGQPGUivfzPYcratFFfeXU=;
        b=IS3acGy5v+D1VrXLpVM4lVMitkBA6ZuCnc6t6WwzHNiDo99e6PL6fuhKYY/+Yq/yMZ
         LdZat7BftgHuO2RraexQ1g77BV+Iz7iCa5UrrspEL6OT7wykulaC0h6Yd4h/JTBCz30J
         FCSJMwZARxsKLBmXk5AzY9vcsd7hnx9Q47KT+pLYE0FOJEArcER7cOWmMZP6K9zgbs15
         KJSMQv5e+JhI+WA4xdf1Yfxy1dDLvzbSMhivgV8JqxUd86wnhq6JfNkZ/XnrI77uK0+W
         0kQ1oFhSV33XY1D0/YTfp42tBnyEsgYoxF6R8pAELjDFhsnAHB9hv9R6Vh6vSROBErEE
         62KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cfp/acTiWdK8wUm8C9dXVBGQPGUivfzPYcratFFfeXU=;
        b=XrUd5whmhSl2zYyAEmBnEq3exT8e0k3zKQi0+m1aJhcTri7XL33+vKAumfVSfSOS9l
         CMJMwxRq9h662jO1JO8i56UT0X+7BJ/fkPO62A0oZcbKCxaoGPlaZnicOWP8Nb8rh+Qk
         61D6rjxwjVVe/QlYuFZQDVZ9FueM6cxe0gZxsKB6SjTJl12tZBjVkZCxqyli+nDJ04Y3
         OeK6oon6gOFKbkjoaRu7OZQ6f/NOQ3DYU0LPEvGcy+JSyN4K/Fjkcjb2OBBLHRgi9epB
         +C4TFP0zVkITfXrYHDBm9c0PGnFwS9ZXLPrMH9jryyTsCzDJOhDTzEslHGCmRDRbrg1C
         TCVw==
X-Gm-Message-State: AO0yUKWHl3gH/BFra2Y83Z8Sntr3rgJPYP60wE73s50dbNlSY4y3YWxJ
        R7Am5ObiwvXasRl5AaA6oS+i
X-Google-Smtp-Source: AK7set+IKlMWqaM2XNdJYO2si2eZpmwBP99pU4gDIsIruNSA7QDd6FFNQO9ZrRMxs4CL8ydTBTeo1w==
X-Received: by 2002:a05:6a20:548a:b0:cc:d891:b2b1 with SMTP id i10-20020a056a20548a00b000ccd891b2b1mr31419746pzk.35.1678421392094;
        Thu, 09 Mar 2023 20:09:52 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 19/19] PCI: qcom: Expose link transition counts via debugfs for v2.4.0
Date:   Fri, 10 Mar 2023 09:38:16 +0530
Message-Id: <20230310040816.22094-20-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
References: <20230310040816.22094-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Qualcomm PCIe controllers of version v2.4.0 have debug registers in the
PARF region that count PCIe link transitions. Expose them over debugfs to
userspace to help debug the low power issues.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index f99b7e7f3f73..0b41f007fa90 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -37,6 +37,7 @@
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
 #define PARF_PM_CTRL				0x20
+#define PARF_PM_STTS				0x24
 #define PARF_PCS_DEEMPH				0x34
 #define PARF_PCS_SWING				0x38
 #define PARF_PHY_CTRL				0x40
@@ -84,6 +85,12 @@
 /* PARF_PM_CTRL register fields */
 #define REQ_NOT_ENTR_L1				BIT(5)
 
+/* PARF_PM_STTS register fields */
+#define PM_LINKST_IN_L1SUB			BIT(8)
+#define PM_LINKST_IN_L0S			BIT(7)
+#define PM_LINKST_IN_L2				BIT(5)
+#define PM_LINKST_IN_L1				BIT(4)
+
 /* PARF_PCS_DEEMPH register fields */
 #define PCS_DEEMPH_TX_DEEMPH_GEN1(x)		FIELD_PREP(GENMASK(21, 16), x)
 #define PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(x)	FIELD_PREP(GENMASK(13, 8), x)
@@ -737,6 +744,31 @@ static int qcom_pcie_post_init_2_4_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_debugfs_func_2_4_0(struct seq_file *s, void *data)
+{
+	struct qcom_pcie *pcie = (struct qcom_pcie *) dev_get_drvdata(s->private);
+
+	seq_printf(s, "L0s transition count: %u\n",
+		   readl_relaxed(pcie->parf + PM_LINKST_IN_L0S));
+
+	seq_printf(s, "L1 transition count: %u\n",
+		   readl_relaxed(pcie->parf + PM_LINKST_IN_L1));
+
+	seq_printf(s, "L1.1 transition count: %u\n",
+		   readl_relaxed(pcie->parf + PM_LINKST_IN_L1SUB));
+
+	seq_printf(s, "L2 transition count: %u\n",
+		   readl_relaxed(pcie->parf + PM_LINKST_IN_L2));
+
+	return 0;
+}
+
+
+static void qcom_pcie_init_debugfs_2_4_0(struct qcom_pcie *pcie)
+{
+	qcom_pcie_init_debugfs(pcie, qcom_pcie_debugfs_func_2_4_0);
+}
+
 static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
@@ -1300,6 +1332,7 @@ static const struct qcom_pcie_ops ops_2_4_0 = {
 	.post_init = qcom_pcie_post_init_2_4_0,
 	.deinit = qcom_pcie_deinit_2_4_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.init_debugfs = qcom_pcie_init_debugfs_2_4_0,
 };
 
 /* Qcom IP rev.: 2.3.3	Synopsys IP rev.: 4.30a */
-- 
2.25.1

