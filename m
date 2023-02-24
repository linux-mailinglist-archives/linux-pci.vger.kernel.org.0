Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE116A1AD7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Feb 2023 12:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjBXLAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Feb 2023 06:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBXK76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Feb 2023 05:59:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523683C798
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so2465175pjb.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Feb 2023 02:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzdP0f8Dd/LfcCPdQr780PzK2RvZAJKB5vPc2XD3ufA=;
        b=mByJV+JaU1+Ltx80aDVz38O8fe/liFVHft/qdrSEETLmITXc0LZv5kudxwrQJHEM4E
         2RP0gsLabTBSZH79fsU3NEHMCeOW0Iqr1TcZhzUE9B7tGDss784ZxY3AotfpkL6jWX2/
         6HMJBJEt7J+vIZ5LMgqVreWGU2Lcz8u/UgO9U8zBTWamxRmKNBZJP6YfXSnA2eN4iPk/
         X15O/ck2XYbJCcauOyeuXxchQlLYNaOq7J6UOFE9O5V7S0FVHzlkswu9pzD1R5IausqO
         535j2BWGe7lKIRbK/nef5No9zFZ7ku4gO34mFvnolSNCGNgFpU9xfpODylons+mkw7YN
         tlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzdP0f8Dd/LfcCPdQr780PzK2RvZAJKB5vPc2XD3ufA=;
        b=YybQhDjPgXZ0/p5Lcli/Mhd/ZXvZwZ8aExJ2RcEeadfm30BCoohmly8Wr+XLQv6L65
         Wop+aQs9XvVfpXMJF26bfYkF8isJ9cLiJ8ZSiz994Jbk+BeY8sJlt9hRMd37a0nuSa8e
         ICFme0is7gqARg6yZY3i8v+lX3eCPMdugHbmeE+QlhWdSK5/YRD/RprwTGa3KfwDYsi6
         P0YkvYPXQK5B0a3ve6qc/lK870dPIdsmfxuCRqfFjw2wF2P6NYxeOwJWmtIzUWkAbef4
         u+h/BZipuh2OZ+RbVSOhoAt+4E47Ys1rbSNSw4O/nAKLeBiuxPQHGRaCGmWRMQMSL4uj
         9Q5Q==
X-Gm-Message-State: AO0yUKUe2FVUVuI1+tDA64U2zx9QlvWEheZ74/noFRV8W6iw0/hWOcVn
        vIAU1WJ66k27okGaMD7jHCym3opYwHytk7s=
X-Google-Smtp-Source: AK7set/00/XkHimswh8A/lTlMaf9uljLO9Xk++JlggP7Y2nYgIaIkn/kcVov3dPdmMzyvCxW50D7Yg==
X-Received: by 2002:a17:90b:4a4d:b0:234:148:4b27 with SMTP id lb13-20020a17090b4a4d00b0023401484b27mr18089652pjb.17.1677236369819;
        Fri, 24 Feb 2023 02:59:29 -0800 (PST)
Received: from localhost.localdomain ([117.217.187.3])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm1263853pjb.21.2023.02.24.02.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:59:29 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/13] dt-bindings: PCI: qcom: Add SDX55 SoC
Date:   Fri, 24 Feb 2023 16:28:56 +0530
Message-Id: <20230224105906.16540-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
References: <20230224105906.16540-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for the PCIe controller on the Qcom SDX55 SoC to the binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index f48d0792aa57..3bba1ef3cff5 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -30,6 +30,7 @@ properties:
       - qcom,pcie-sc8180x
       - qcom,pcie-sc8280xp
       - qcom,pcie-sdm845
+      - qcom,pcie-sdx55
       - qcom,pcie-sm8150
       - qcom,pcie-sm8250
       - qcom,pcie-sm8450-pcie0
@@ -199,6 +200,7 @@ allOf:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
+              - qcom,pcie-sdx55
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
@@ -646,6 +648,32 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sdx55
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 7
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: sleep # PCIe Sleep clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
-- 
2.25.1

