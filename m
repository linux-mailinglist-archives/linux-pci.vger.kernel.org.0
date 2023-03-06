Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4946AC55B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 16:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjCFPei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 10:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCFPeU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 10:34:20 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E59C1BDB
        for <linux-pci@vger.kernel.org>; Mon,  6 Mar 2023 07:33:44 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v11so10766571plz.8
        for <linux-pci@vger.kernel.org>; Mon, 06 Mar 2023 07:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678116823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjVJSbpM4JHJqj6krv3lIQKDxhwB+dMqIuVDDztiVfQ=;
        b=lq3LCCOxjEEkFrpCl5klok4qbkFBi4U5sOn1wrDGtT83/vF23/qAYHM0ZThwR+kQSG
         JjXJnoCOAKWlGcJn7LqkEEAbxp3nLA1VtnLnNOO1+kx6BZjedrB2AkZiNkNvmfQfEuek
         /NZzRRZYrsEc8VlLVcO7nMaPkkezgD2R8p2SYJfmDuffn5FM12i2Q7YUzo38/bdNgvBP
         tc/2vyDhJHoyWEaV+rGvFVW949sf/YQ9AIQ8Ts/CoV7SJ+rTKf9+LsVXN5ca8j8jPTaI
         j8YUobKBXP3hwzqc4txh6JuzH+/tRSZegs8ctiNh2nOamhov/emD7RLGTfSKpSJygHit
         AFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678116823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjVJSbpM4JHJqj6krv3lIQKDxhwB+dMqIuVDDztiVfQ=;
        b=A4igFgSHEVNyLAjEmA82IYoWtTn79S0lRGu0LHEBZDZRIGjMRk1CJxsNmAdMAR6+FT
         iNDHLVU8fqv+rjSXJ8tQDlwc5194prIQPj4jBL81+6Gm2nY8EPjjXgCw5L5V1WO5t7ci
         vltyyvf+0M/GWIqX0rbHGEGPSdMYHq7xSbsvcWyvY9F49hYHgXoGAWuIGpZwbzVM+ySI
         PVb4MPVi8ujYLrhNrfMQto8/pIOYQydCGx0dIOKIDP59SlhUlOAmtqwjVwI//C+HefiW
         pIEF2S4519vlpDEOu6HLrWFpKwCKNwXlvSdsOpd5dm4zqOe/N5gkpMq7GSS5w4aw2EFv
         YEUw==
X-Gm-Message-State: AO0yUKUQp1ei13rRrwMVVHMnGzsc0DG9a9b/FnLtcXlJEzvTEWLcfc7p
        JrZz9PC1jBh0MB9vpy69tZV4
X-Google-Smtp-Source: AK7set+tvsgC/gt8pVwsFXsv3pBtQFnZtVgPVi+YHiD0roBeKelE9q9Ag+mrYIaR9+tEdyklDdfNpg==
X-Received: by 2002:a17:902:7007:b0:19d:47b:67c8 with SMTP id y7-20020a170902700700b0019d047b67c8mr9574772plk.48.1678116823681;
        Mon, 06 Mar 2023 07:33:43 -0800 (PST)
Received: from localhost.localdomain ([59.97.52.140])
        by smtp.gmail.com with ESMTPSA id kl4-20020a170903074400b0019a7c890c61sm6837430plb.252.2023.03.06.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:33:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 15/19] dt-bindings: PCI: qcom: Add "mhi" register region to supported SoCs
Date:   Mon,  6 Mar 2023 21:02:18 +0530
Message-Id: <20230306153222.157667-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
References: <20230306153222.157667-1-manivannan.sadhasivam@linaro.org>
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

"mhi" register region contains the MHI registers that could be used by
the PCIe controller drivers to get debug information like PCIe link
transition counts on newer SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index fb32c43dd12d..2de6e7154025 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -44,11 +44,11 @@ properties:
 
   reg:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   reg-names:
     minItems: 4
-    maxItems: 5
+    maxItems: 6
 
   interrupts:
     minItems: 1
@@ -185,10 +185,12 @@ allOf:
       properties:
         reg:
           minItems: 4
-          maxItems: 4
+          maxItems: 5
         reg-names:
+          minItems: 4
           items:
             - const: parf # Qualcomm specific registers
+            - const: mhi # MHI registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: config # PCIe configuration space
@@ -209,10 +211,12 @@ allOf:
       properties:
         reg:
           minItems: 5
-          maxItems: 5
+          maxItems: 6
         reg-names:
+          minItems: 5
           items:
             - const: parf # Qualcomm specific registers
+            - const: mhi # MHI registers
             - const: dbi # DesignWare PCIe registers
             - const: elbi # External local bus interface registers
             - const: atu # ATU address space
-- 
2.25.1

