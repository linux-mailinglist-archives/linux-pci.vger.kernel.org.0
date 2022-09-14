Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5035B8266
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 09:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiINHzR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiINHyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 03:54:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28509AE63
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:54:38 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f24so14324689plr.1
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zNrBu1Ho157JvXJ7EWepzZnt5L0+FsXJv3lwmZhG3S4=;
        b=DGA3wYlgIMRr/tBoLA04b0bxdGdZp4gQW0fFU/hn3RoVKLKlLEd9Glspjr4sTd9QSj
         vyI6pEUxb+AZ7Tj7uCBs+deTDY3SB3POaPWeHQKWS6pkewDhPDsTXxj+vlZLCf5YoAlo
         DdYjecwo6/JXJLBmHPtGXFv6paKve7WoQI7fjWDkyMn2sQSm413GwGH/Sng5IcN6q0RV
         y+s4hCxO2mkAoGYAnqn6lGuv3xSzBMeF0uCp64uk3EmiTEQEE8dmao/3Q/vOnbW92TAM
         zPNbtFJyT81KhV3BmK7q+uO3GLA+4qUpkSFb2CT8JrjYaIKfdH3TwM9dsMeafHyc5t6V
         h96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zNrBu1Ho157JvXJ7EWepzZnt5L0+FsXJv3lwmZhG3S4=;
        b=zTUPB/6+TzrPXMKS6skKUPyhjMrtRM/5+2ngELlAulsylCa31UpmKqGlPJULbiRvqC
         uDQ0wgdZzcFeqBjUOAXAFREYr8DoDI55oDh24aelg7340pEb1rQZDCZ19uHsRAzvOJtx
         gwZelfpuAT6m2pkVEEYrvtcfcoBfcXr82hFda+Tjcq5JGPyuwx8kqqV4YbNRXEBRJmkZ
         rIDoSRtB9q/GaIrZ1d5qSLQGi0L8N1Chgen3FZVSQZv0jPUVwQiJSvkYJ8nzoWHj4w4w
         y47MjKqBK0ho/h+aVfHIrHmHrtqxgInQ8kOrJUiTXkC9wfOhrxnk60Odw5NWDRwDZFn1
         56xA==
X-Gm-Message-State: ACgBeo3TieUnJqag211nzrp8VY74RV52e65nTbB1tA0uzS5KxmA53gMs
        7co2gzfBL0wrvTxvYTQewvBC
X-Google-Smtp-Source: AA6agR7h0otvP65TpQvb+ut0k5FYF+wWp4yrnNe48ERprrnT7y18sLkINKI/0EK30RIPJmGVahQrmA==
X-Received: by 2002:a17:903:32c1:b0:176:d67b:cf70 with SMTP id i1-20020a17090332c100b00176d67bcf70mr37160710plr.117.1663142077084;
        Wed, 14 Sep 2022 00:54:37 -0700 (PDT)
Received: from localhost.localdomain ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b00174ea015ee2sm10119054plb.38.2022.09.14.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 00:54:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 06/12] PCI: qcom-ep: Gate Master AXI clock to MHI bus during L1SS
Date:   Wed, 14 Sep 2022 13:23:44 +0530
Message-Id: <20220914075350.7992-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
References: <20220914075350.7992-1-manivannan.sadhasivam@linaro.org>
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

