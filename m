Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468B8513345
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345836AbiD1MC6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 08:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345229AbiD1MC5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 08:02:57 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A47ABF4C
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:59:42 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t25so8184115lfg.7
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2BucdX25yi/XV546unnoqK2cR6cu2U6EdyP9q7yCcs=;
        b=CRqlVrJ6RAiab3/cGrXcJ/cMByNz8OipWbfJqnKsd1vQd5a2/tOYg+bAEPtRFpqh87
         pgv7TDirghwGG5qSiUSyFtk3ETVTEK8Rcmi8H8kpwFdyVuAtkFKKU2CKFmODhxIPLiTB
         S8o8zAoflUxnq6njeV1L/x2qJVVUioIg/xPqbEK1sa46cHw1vgzTQhN9jzXYnJi8BKZk
         r0DfIMviIrH9E7Ktl7DjiqzcLnJ+CW+du21Z31tBvD0WDBagut1mcAT+D7BT8AaVFGw4
         EsEPHpTLBhUDOY0ZQHOZMJO5gsuJSVFyaMAausgYyqG01eUg/f3FMWS/Ab/27mARqyqw
         brYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2BucdX25yi/XV546unnoqK2cR6cu2U6EdyP9q7yCcs=;
        b=MzUNcGRZSNx5lcQ65Zp7kt3zTCFEd3KmlkZMQdB6KIogWOJ1yOslGYR2YB1cSin/lW
         13WP65I83DWtAC8y4v6wsuaa2BRFVJImg7zAo6epKLGoUfrEcJv09z66FepHDX8zbK7g
         hMHdz5eAEbtw04Bu2nEzFaXCviKRfryBiSMUg3+CJrD8uDW1fLuLzxPT5MCNpegfxNTo
         AOzog9e+fqkOcdYyx1gSIIpKv1TDOh1QsFM1n/YeVtEN0kWXLPLSqm3FKZETRxMJsWkh
         JoXJWP0T5g1Dh01WXv+DvdbSQgyCpPBdvVYeWYcFQq6sZsY3SpoMLJQqnCAwXfCHYNkH
         vWwQ==
X-Gm-Message-State: AOAM530GZqIFAMjViKTyj7JBjwbmznx72IdG5vWUtbNsei5o6XRxnVCW
        6Nx91oQNQrFMtzOOpi3EiBhSRA==
X-Google-Smtp-Source: ABdhPJzf77VSRnnNz4wLdcNGgBTDPEj7essUksXDkLlyFzyEOHvMCMBT9aBIjk1jbyuu1jiboM/GuA==
X-Received: by 2002:a05:6512:38a7:b0:471:ffe1:d7f1 with SMTP id o7-20020a05651238a700b00471ffe1d7f1mr16654895lft.216.1651147180434;
        Thu, 28 Apr 2022 04:59:40 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f1-20020a2e1f01000000b0024602522b5dsm2069137ljf.120.2022.04.28.04.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:59:40 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v4 6/7] dt-bindings: pci/qcom,pcie: support additional MSI interrupts
Date:   Thu, 28 Apr 2022 14:59:33 +0300
Message-Id: <20220428115934.3414641-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
References: <20220428115934.3414641-1-dmitry.baryshkov@linaro.org>
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

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Document mapping of additional interrupts.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..a8f99bca389e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -43,11 +43,20 @@ properties:
     maxItems: 5
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 8
 
   interrupt-names:
+    minItems: 1
     items:
       - const: msi
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: msi8
 
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
@@ -623,6 +632,46 @@ allOf:
         - resets
         - reset-names
 
+    # On newer chipsets support either 1 or 8 msi interrupts
+    # On older chipsets it's always 1 msi interrupt
+  - if:
+      properties:
+        compatibles:
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
+              minItems: 1
+              maxItems: 1
+            interrupt-names:
+              minItems: 1
+              maxItems: 1
+        - properties:
+            interrupts:
+              minItems: 8
+              maxItems: 8
+            interrupt-names:
+              minItems: 8
+              maxItems: 8
+    else:
+      properties:
+        interrupts:
+          minItems: 1
+          maxItems: 1
+        interrupt-names:
+          minItems: 1
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

