Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E26542DB0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbiFHKan (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238235AbiFHK36 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 06:29:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E009196A84
        for <linux-pci@vger.kernel.org>; Wed,  8 Jun 2022 03:22:17 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id c30so5614282ljr.9
        for <linux-pci@vger.kernel.org>; Wed, 08 Jun 2022 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzqGnSkfjGsd12VJjeT042q1msdDMzMuRj8aU0uV6Z8=;
        b=huYYSIPYJabkVv6iOA5Qyi452ek1PximMa2LmjR+lozTKxMkf4fSZkKhAF7IvmvfWC
         5gZI2nk+azIFbzVwS0vfm+n23vSgjDNNvzPA7fGNTfJwU/4YFGyM2QhKPzmvGTI0o+uq
         mmyOcZY0AoD/7IwfoXWyyLvVgdmf0LF+OHjQngPJAScfAfqK3OzMQqYeFs5ZNqiWuvmM
         CzMhdwyaQShKGX9xhvDQS9fgqpa5e6HHEifveXhh1gJUsftB8OJv8aMvkMxYqXRqZl6C
         6TApeKszjfbjqkbITUQtUznu7MBbGc7WGL4sm4OsylBymfSUB1Drh/eGr3Uy7uszQjMm
         QS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VzqGnSkfjGsd12VJjeT042q1msdDMzMuRj8aU0uV6Z8=;
        b=tcjAKJkHLj93ClO+e4CTs0j0Miqr5VV/m0Zf59SXNu894Vu2E3Ceg/3jAIQ1QNil3k
         OM+niiBpNU2M1GBhSizsxzUx64YMTgorjZnDQc2wgxiZPrQHqDiTtT2zWOzdh1GjcO+0
         lakWV8eBfB1NxzJ91P5c1DzSnRL3PkTmT4pyZQfCXjl4HWXbvn7d1ILEpskxTcjM+GYA
         OWvKDpmjqoXWBMTeTT7NK3UwC6RCgodgw4uzoNwr3tpTH5ESEIXbCxDgf79LOh1QZOcI
         fVq2el7dtsT0UNRo+u+PdURJAWhH27WSvy9pIXji8b1njoylpDZGitnEuvN4YR3Rq0y0
         T84g==
X-Gm-Message-State: AOAM532gxd4G3FJXZa4ynM5ivKeej7R9aDNWf5SmeFzVphsGDRvSvuER
        nAfxHAmdesVJjIclxeuYXPuCUA==
X-Google-Smtp-Source: ABdhPJwbhkXbnf0lqZXZ04r71sRF+TE2DrHIaOcJawGtAOKWyQnuwOlkXyTXsawrnCvOXrHQmea3ow==
X-Received: by 2002:a2e:9b93:0:b0:255:7acf:e21b with SMTP id z19-20020a2e9b93000000b002557acfe21bmr15251714lji.419.1654683735954;
        Wed, 08 Jun 2022 03:22:15 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v1-20020ac25601000000b00478fe3327aasm3642934lfd.217.2022.06.08.03.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 03:22:15 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Subject: [PATCH v14 5/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Wed,  8 Jun 2022 13:22:06 +0300
Message-Id: <20220608102208.2967438-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
References: <20220608102208.2967438-1-dmitry.baryshkov@linaro.org>
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

On Qualcomm platforms each group of 32 MSI vectors is routed to the
separate GIC interrupt. Document mapping of additional interrupts.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 53 +++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..fe8f9a62a665 100644
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
@@ -623,6 +624,52 @@ allOf:
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
+              maxItems: 1
+            interrupt-names:
+              maxItems: 1
+              items:
+                - const: msi
+        - properties:
+            interrupts:
+              minItems: 8
+            interrupt-names:
+              minItems: 8
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

