Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3375B448D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIJGcV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiIJGcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:32:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F8FAF0CF
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bz13so6603961wrb.2
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=rmpTVMmLmv6UMsIzgv+O74eFW0TvLRItNBIUwPHHvPM=;
        b=iioP0BMmvcNpq6HImiS4UkO/GYKg4fbiNSsSnj+PLFr3RPiInszuRUzAIZsd7UZozL
         nmEMIs7+8KnQP0KQ9i+RirLy2yGuv/YNjC+Agz6ul6Aw5wDb92W0VY/n/GEFWaHfQ9w0
         J/9eeXo4msG1/F+g+tlorCHQIy4FS9p/7HgAxGTaaI/TA76KJZJfuO81i4lpBIwJbY+V
         srpkcDVpxeI38AgoJxz5TuciIKIFzY1wChN/X7JG0CZn2XpxPUD7tGO4HCv0vZv+Wb+d
         FX6O20fMiZz+ZAW30iKWUUCI2NOBIizMWc1nKFBz3yMSFY/78m4e0Y5bvV+vmER9Eu6c
         JfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=rmpTVMmLmv6UMsIzgv+O74eFW0TvLRItNBIUwPHHvPM=;
        b=RdwRMRPzqfS7XHm5h5PYJkl/MMlF1ud/qx+5V4Emskw5E5myqndTuOkt/PajxXot9J
         er29RE4dhPBPNVkUPQ4FyM8MlddqLOObR6iaH8UcyrtYu/R1y2WFCabIXdLnpDP2pyI2
         EX9sNZCYxXG//CK55DHUVsDXBe8vVyoxnKvoyfyVR2WtFJitPO1fQyogwjN+pYNKEnWx
         c7Y4zcGG/UMkCTd97NHkpMC+bKIvhV1ZVSKa0DbsYrJylAq1gZKub1SKRknCrp5z4WGr
         F8uXgnEvTWe6wi4TRxGzfjueAvvpNTvnVOD+h4EMiX9XNUT5nJbZFI760uwRZafHFE96
         MPzw==
X-Gm-Message-State: ACgBeo0EpdfsPfiuP8YKZIFyo17KUDDI728Rgws53RbOTp5KHXWSiIJe
        Je6i8l73u7+drtW3okoiN41r
X-Google-Smtp-Source: AA6agR4Q8jxvtuS/qb+btewBXZxVvCLbKGjP/928PaqQJXfbTK3gLEFs14eLIqaAJ3o1NoFPYErGsA==
X-Received: by 2002:a5d:588b:0:b0:227:1c28:f470 with SMTP id n11-20020a5d588b000000b002271c28f470mr10052229wrf.331.1662791516424;
        Fri, 09 Sep 2022 23:31:56 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 07/12] PCI: qcom-ep: Disable Master AXI Clock when there is no PCIe traffic
Date:   Sat, 10 Sep 2022 12:00:40 +0530
Message-Id: <20220910063045.16648-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
References: <20220910063045.16648-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Master AXI clock can be disabled when it is not used i.e., when there
is no traffic on the PCIe bus. This helps to save power during idle state.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 526e98ea23f6..40f75a6c55df 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -105,6 +105,7 @@
 /* PARF_SYS_CTRL register fields */
 #define PARF_SYS_CTRL_AUX_PWR_DET		BIT(4)
 #define PARF_SYS_CTRL_CORE_CLK_CGC_DIS		BIT(6)
+#define PARF_SYS_CTRL_MSTR_ACLK_CGC_DIS		BIT(10)
 #define PARF_SYS_CTRL_SLV_DBI_WAKE_DISABLE	BIT(11)
 
 /* PARF_DB_CTRL register fields */
@@ -341,8 +342,14 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val &= ~PARF_Q2A_FLUSH_EN;
 	writel_relaxed(val, pcie_ep->parf + PARF_Q2A_FLUSH);
 
-	/* Disable DBI Wakeup, core clock CGC and enable AUX power */
+	/*
+	 * Disable Master AXI clock during idle
+	 * Do not allow DBI access to take the core out of L1
+	 * Disable core clock gating that gates PIPE clock from propagating to core clock
+	 * Report to the host that Vaux is present
+	 */
 	val = readl_relaxed(pcie_ep->parf + PARF_SYS_CTRL);
+	val &= ~PARF_SYS_CTRL_MSTR_ACLK_CGC_DIS;
 	val |= PARF_SYS_CTRL_SLV_DBI_WAKE_DISABLE |
 	       PARF_SYS_CTRL_CORE_CLK_CGC_DIS |
 	       PARF_SYS_CTRL_AUX_PWR_DET;
-- 
2.25.1

