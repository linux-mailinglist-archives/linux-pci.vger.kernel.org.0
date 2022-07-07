Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBD256A41C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 15:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236031AbiGGNrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 09:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiGGNrm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 09:47:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3052656C
        for <linux-pci@vger.kernel.org>; Thu,  7 Jul 2022 06:47:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so31204992lfg.7
        for <linux-pci@vger.kernel.org>; Thu, 07 Jul 2022 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EJTA02/8QXX9XvDJhyvBrvr6FldFkxhecJWImdsVDeQ=;
        b=vOXIUL85g9vcc+3/hiAIWqQUx5HG7miXRUckIx6dmpOj3wH8joyvvjAO5yMxu8nJOZ
         f4n9bXd1mzhgHWgpTuRGPZg2DOHYtQU8GQdUbySLKL8yY+sOE9USpwwlBxOy+pTOwwYp
         sliNN/MeKibL9hgdgyOyaURavdE4z+0Innytyesi99Bi5fx2yz0hcCq95W8QTJGoUOdN
         kRoAetsOGX074uxAcLyC814I91ASJoDRd8ZBbkdIHrZb7zAXwaaIdg3mLJltuaND2LpL
         oMdi2jaTq/z/vcZRMUMiHADUDa+/mmQlbKHDPfko5PAKrPhuRHlU+QJ8khb8Bq3deWX8
         xNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EJTA02/8QXX9XvDJhyvBrvr6FldFkxhecJWImdsVDeQ=;
        b=C8snsBslmSt2ApHMASZkpzDrnQ/7eKG9D2GVxY1fWLMrCfvNqiKpvIvLRoOzOD21cz
         Z502R+739hPawpC0okZjN6ftoKoJ8tIvomlCA2XiRtln2a4IcbNsCWhZTL+HGMAzOn3+
         cOYkrtGI7eMAVRAK9NFY0DIBHW+h4o56QpXpYUhVWAWpD8CjNngVW74/j4ZKjEHPUJkJ
         JV8hx8CtActQPQxHMHLd1XQ9UBItKgS1MhCWn7RMyDWQmuSeEf+KsAWUZG9fhhVyYh1P
         Bc9Bji1pwI+gT0CCA25hUdYuBzpt+T4uExyzvoncD4v7NlOy+ln2bodmmqyL7hkm1mZJ
         /uIw==
X-Gm-Message-State: AJIora+9csh8f0dSxGKj7X7VW+DNKUzU3uav1ay8LpgLm1G//20RfVxp
        Y9cncw4pFHKbI1QZwkS0Ehuu/g==
X-Google-Smtp-Source: AGRyM1uLNjsMQzqAwj35DQt580kLg6qYr5oXQ7r3vDzmLNQ/fjVlYB3xUpt977GoIUwWy1CCQxRgew==
X-Received: by 2002:a05:6512:1691:b0:47f:ae89:906f with SMTP id bu17-20020a056512169100b0047fae89906fmr29797908lfb.229.1657201659410;
        Thu, 07 Jul 2022 06:47:39 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u22-20020a197916000000b0047fa941067fsm6856966lfc.29.2022.07.07.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:47:38 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v17 5/6] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Thu,  7 Jul 2022 16:47:32 +0300
Message-Id: <20220707134733.2436629-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
References: <20220707134733.2436629-1-dmitry.baryshkov@linaro.org>
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

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Document mapping of additional interrupts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 +++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 9b3ebee938e8..a1b4fc70e162 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -43,11 +43,12 @@ properties:
     maxItems: 5
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 8
 
   interrupt-names:
-    items:
-      - const: msi
+    minItems: 1
+    maxItems: 8
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
@@ -623,6 +624,50 @@ allOf:
         - resets
         - reset-names
 
+    # On newer chipsets support either 1 or 8 msi interrupts
+    # On older chipsets it's always 1 msi interrupt
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-msm8996
+              - qcom,pcie-sc7280
+              - qcom,pcie-sc8180x
+              - qcom,pcie-sdm845
+              - qcom,pcie-sm8150
+              - qcom,pcie-sm8250
+              - qcom,pcie-sm8450-pcie0
+              - qcom,pcie-sm8450-pcie1
+    then:
+      oneOf:
+        - properties:
+            interrupts:
+              maxItems: 1
+            interrupt-names:
+              items:
+                - const: msi
+        - properties:
+            interrupts:
+              minItems: 8
+            interrupt-names:
+              items:
+                - const: msi0
+                - const: msi1
+                - const: msi2
+                - const: msi3
+                - const: msi4
+                - const: msi5
+                - const: msi6
+                - const: msi7
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: msi
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

