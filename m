Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92475551739
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jun 2022 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiFTLU1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Jun 2022 07:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbiFTLU0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Jun 2022 07:20:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE013F13
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id c30so11520002ljr.9
        for <linux-pci@vger.kernel.org>; Mon, 20 Jun 2022 04:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Twg17xcmQWEnSCcuxYrkuJYo007S5FBy/DKO7jdPon4=;
        b=xQvRcC/Lm8B1kRDra+OiJMWgucDp6pK2V45nmSB+Rns1n6NAf76aGBCJK+HB8GEfhj
         w6bCPPoMEXNxd2/ako4kddU0IqaIP+iThHXV0NmPzdLq6eMGp8CjGR/VHvc74Fao0ujv
         WTLfFNQnp+le8xM9XEhJ9vYOZLru1Isn2JNm4vjqxI+2BTgDt3LIrc1nazseRupeZj8j
         G4Tknp7HjqkfMtXkk3EOZjHWA0atlcPv13pG5Ks4EFUTqkaXS3oFEcV/zE39PkjOLB8D
         UT9tzyHuz1iYuKIIgYC9kXHR/L6SPYZpFaqajdBUQPNhaqdpmdNRalkqo1UPFbLfA3fI
         gP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Twg17xcmQWEnSCcuxYrkuJYo007S5FBy/DKO7jdPon4=;
        b=dC8RllwmgMpCULrIfV50JyBm7npZPMVmYuQw6vrhve8z/SoQjKe+ESJW5t6tJ22CK/
         I5OrrRcC/q7osdSDIYYYzEJrdQWUW8EjvGgxlZ9Vpyitdfyxyf+vvsSR+7I9/2sl84vC
         Pq8kz8MFxNBvIsOGAVA+zB4+DepWz6P5QR4FVeEZCzYA1QSnUI4nAleSv1OzPEWuEOEs
         f/RNSy1ah4oIWpTLoBhuc8C9idHNvBn8S4F8xy/2j9NJ93wletVry2le6GUE6j/UqotX
         vnC9sQCMIuvVYeBdEAvZlBay9e+eYcJ3j2Flk+pyTzODwvyeMilGJi3ojEllV5yQq+w7
         45IQ==
X-Gm-Message-State: AJIora9vFN9kqpJ/5yTovRTIFrBYmmbrHIe2xR21mg19ErRZQVGvb1SO
        SueUx7H5G5pvUcmbUPcJZvfVCw==
X-Google-Smtp-Source: AGRyM1ti28tiaV/s8yvNZRrZpLJzxqmjN8fQPK4/G1PqC/WaWUZdQJLG4207+ImsAGFO/YBCwL8H+g==
X-Received: by 2002:a2e:964d:0:b0:25a:72d1:321d with SMTP id z13-20020a2e964d000000b0025a72d1321dmr946398ljh.511.1655724023503;
        Mon, 20 Jun 2022 04:20:23 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o23-20020ac24e97000000b00478f5d3de95sm1727270lfr.120.2022.06.20.04.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 04:20:22 -0700 (PDT)
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
Subject: [PATCH v15 5/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Mon, 20 Jun 2022 14:20:13 +0300
Message-Id: <20220620112015.1600380-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
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
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 +++++++++++++++++--
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..7e84063afe25 100644
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

