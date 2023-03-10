Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE166B355C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 05:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCJELK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Mar 2023 23:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjCJEKB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Mar 2023 23:10:01 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD05AF6909
        for <linux-pci@vger.kernel.org>; Thu,  9 Mar 2023 20:09:27 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id x7so2860045pff.7
        for <linux-pci@vger.kernel.org>; Thu, 09 Mar 2023 20:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678421363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=LrICSFqab9sa220RDrempiZSjRDQplgHv3z1kbyoEOT/ijTMZbLM4D1iwR2/pV4kvT
         6rxEAOX1omwOTymgO3kQ0OScjnrpAvz5EKNFlZCBsibJqbuki3gsXUN/yRp/yXxzWUFI
         U+GilDA8TOvGpjqGcTNgnUkfQxDY+ysZAuD00bKyJSiJTegN3OqIjggofI5xVYY8FWii
         9mBDYrsTssG08AKNvvoHaDkT1wOIdHlRYW6HADTWruc+comsXn90TdrdroFtjXUFS1NV
         nk84plpj2drw4dMxYjNZ9kWMRyAGkHr7fHTcTHUhaKYdEdI5rl0rEYDw0QDZg+H2m2k0
         fwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678421363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtO470wsQrdefT/eZbqt8rDglQCA1uZJNkLG9oF8ql8=;
        b=pgqnirPzLTs2OWsinVRNTL0aHAbWluirB38AqOF71lrgR6/v2As75KGIn7lCRkjw1R
         h+OQm/XyqiaFknVcd7ocgfQ7axuwScl+D/budCQ49nktypuvGhNQ+KqXqXaBxohgmsGt
         dYArDDJYgNlo2wTaDD2V18yNaTz8zq7ADuVqlHRyvYXFOaPfH9xSYimhMGxQ3NSUQ/JH
         1UFPpzOxcjwHFX0A+zOUTpFbdHRVjM8ni4lbtMSl5fokKtMLGSybiZVaw4vEadKb7i6Q
         PvpohMSg/jrjpvUy7NokuTywEyz8LOt1f5x/IKMnMr1pWvD1t5AAwCYIost9wrkrSdam
         5tpA==
X-Gm-Message-State: AO0yUKUj/UpKJ+7bzFThyH87nGgisR8wc/oPUerrRCDxcoGZk1OVBJ4e
        oBE74Q87VFIfCvMJeq25dEmc
X-Google-Smtp-Source: AK7set8H1fACULgIZERB36U07Ny3aiWHnhePswZao10IH74MtNEgDCkNTY71Rf9Z1djaSBxZJGuGVA==
X-Received: by 2002:a05:6a00:4004:b0:5a8:4c8a:2ce4 with SMTP id by4-20020a056a00400400b005a84c8a2ce4mr608223pfb.3.1678421363481;
        Thu, 09 Mar 2023 20:09:23 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.67])
        by smtp.gmail.com with ESMTPSA id y26-20020aa7855a000000b0058d92d6e4ddsm361846pfn.5.2023.03.09.20.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 20:09:23 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 12/19] PCI: qcom: Use macros for defining total no. of clocks & supplies
Date:   Fri, 10 Mar 2023 09:38:09 +0530
Message-Id: <20230310040816.22094-13-manivannan.sadhasivam@linaro.org>
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

To keep uniformity, let's use macros to define the total number of clocks
and supplies in qcom_pcie_resources_{2_7_0/2_9_0} structs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ed43e03b972f..e1180c84f0fa 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -185,16 +185,18 @@ struct qcom_pcie_resources_2_4_0 {
 	int num_resets;
 };
 
-/* 6 clocks typically, 7 for sm8250 */
+#define QCOM_PCIE_2_7_0_MAX_CLOCKS		12
+#define QCOM_PCIE_2_7_0_MAX_SUPPLIES		2
 struct qcom_pcie_resources_2_7_0 {
-	struct clk_bulk_data clks[12];
+	struct clk_bulk_data clks[QCOM_PCIE_2_7_0_MAX_CLOCKS];
 	int num_clks;
-	struct regulator_bulk_data supplies[2];
+	struct regulator_bulk_data supplies[QCOM_PCIE_2_7_0_MAX_SUPPLIES];
 	struct reset_control *pci_reset;
 };
 
+#define QCOM_PCIE_2_9_0_MAX_CLOCKS		5
 struct qcom_pcie_resources_2_9_0 {
-	struct clk_bulk_data clks[5];
+	struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
 	struct reset_control *rst;
 };
 
-- 
2.25.1

