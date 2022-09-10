Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C05B4490
	for <lists+linux-pci@lfdr.de>; Sat, 10 Sep 2022 08:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiIJGcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Sep 2022 02:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIJGcB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Sep 2022 02:32:01 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB7BAE85E
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 23:31:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d2so6606301wrn.1
        for <linux-pci@vger.kernel.org>; Fri, 09 Sep 2022 23:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zNrBu1Ho157JvXJ7EWepzZnt5L0+FsXJv3lwmZhG3S4=;
        b=x5AhAk6exijllo3hNAdUCc/4Toj6Fn5p00CYLk3KAbz6bGFHb2RbQxUuuVQIy/s6bt
         t6DQeEBmuigNnf68+8pqMKJrKD8//MARKAom2/5NUSVbT7Ibp9xdWvts8LOuISarlO5E
         f9gOzHsuHIcuxU+fqM9e2wdIMeaVwis4s0awIpMkmHB+5KgWJD+CCqFJPHztLROES8oq
         sVrSNl3t/hM5Dpgn0+SfMr+qB7YnULMkLqyiZfYqQvBrArzYIfbnovKcrSYrHd6pufNG
         RSIBnPieZ/kA8OHDVh1TBACiXSRXXSICtNR9SsBwTaWlA1VBaFeffS+LxBHED7oE+lqb
         6Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zNrBu1Ho157JvXJ7EWepzZnt5L0+FsXJv3lwmZhG3S4=;
        b=zsvM/fTqVIns+cIABaoKOnO5DmcjmrWIBbK4NWTaBWLTf514j4D5GnC9Wq4p06w4Ie
         TVY105v/OUiPD0zgRwx4dppZxQA5svP2e8tYtqGeC45EOZCYAo9qPNbTdeTrR2jAbOis
         MxZgHSbL+b1Ge+Q2suyW9VlCFggn2KJufnEPSRh3XnnnoI60iTW+5hxSSNxPNWxFN8ss
         0P3Bx1cBEBtnKP+IJx2LZq304oC44jwrBw8AcQqLCsgGD7trXya8ZRCwJAttc6U+Iv/n
         AeVJ592D9WwxWzzMn+4K3U3p3oKtTaOIgehujwRD+jGPpnpHI2M1E1sukSHbpgGv/fqH
         D/KQ==
X-Gm-Message-State: ACgBeo2k8rCeAnm++Bfg6fT1UgNPYjJnQ2VVxjKznFgH3UrifW7WX0/L
        6JxeAHSGQjxFmHpQi9aTEoFs
X-Google-Smtp-Source: AA6agR6RGh+CQ6g4xAlQmbBII7NV9PH+o29Gc5/y26U4UoIaVaxA3Ua/VTMtS7JC4FEoIW7q8wV7Cw==
X-Received: by 2002:a5d:64eb:0:b0:22a:47ad:f0d8 with SMTP id g11-20020a5d64eb000000b0022a47adf0d8mr1110128wri.140.1662791508722;
        Fri, 09 Sep 2022 23:31:48 -0700 (PDT)
Received: from localhost.localdomain ([117.217.182.47])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm2828122wmq.28.2022.09.09.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 23:31:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 06/12] PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS
Date:   Sat, 10 Sep 2022 12:00:39 +0530
Message-Id: <20220910063045.16648-7-manivannan.sadhasivam@linaro.org>
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

During L1SS, gate the Master clock supplied to the MHI bus to save power.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2dc6d4e44aff..526e98ea23f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -27,6 +27,7 @@
 #define PARF_SYS_CTRL				0x00
 #define PARF_DB_CTRL				0x10
 #define PARF_PM_CTRL				0x20
+#define PARF_MHI_CLOCK_RESET_CTRL		0x174
 #define PARF_MHI_BASE_ADDR_LOWER		0x178
 #define PARF_MHI_BASE_ADDR_UPPER		0x17c
 #define PARF_DEBUG_INT_EN			0x190
@@ -89,6 +90,9 @@
 #define PARF_PM_CTRL_READY_ENTR_L23		BIT(2)
 #define PARF_PM_CTRL_REQ_NOT_ENTR_L1		BIT(5)
 
+/* PARF_MHI_CLOCK_RESET_CTRL fields */
+#define PARF_MSTR_AXI_CLK_EN			BIT(1)
+
 /* PARF_AXI_MSTR_RD_HALT_NO_WRITES register fields */
 #define PARF_AXI_MSTR_RD_HALT_NO_WRITE_EN	BIT(0)
 
@@ -394,6 +398,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		       pcie_ep->parf + PARF_MHI_BASE_ADDR_LOWER);
 	writel_relaxed(0, pcie_ep->parf + PARF_MHI_BASE_ADDR_UPPER);
 
+	/* Gate Master AXI clock to MHI bus during L1SS */
+	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
+	val &= ~PARF_MSTR_AXI_CLK_EN;
+	val = readl_relaxed(pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
+
 	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
 
 	/* Enable LTSSM */
-- 
2.25.1

