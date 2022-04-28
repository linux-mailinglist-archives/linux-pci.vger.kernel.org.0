Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B757D5132AE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 13:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiD1Lo5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 07:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbiD1Los (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 07:44:48 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A864168327
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu29so8183511lfb.0
        for <linux-pci@vger.kernel.org>; Thu, 28 Apr 2022 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/QSONSEpjxrPZtFb9gmtNnByfU6eZhR98/Jc/QyZERA=;
        b=WgHfnJZW2T7FGBV601uUbbJgno5r9Lxi+hIvfua+TPmSYONX+PWUcLMcaL4mGkel44
         3f0ApL0J19WoHscvvuVCvALudbggu3QS3Rj8uPPicySA2InUrxFvikyhEKVI+ehod/IL
         xmQqGf0WpK7TocarfConpzwJTHOt8oP3QIyv+qAep1L17sRXwq8QET+x+y1gug4c0gmH
         +ATqSODrcG+zIa2xX8Yrhvex6fAdd+mvQSbY1H1bRcRzeTRO8KyNIYoWYepntwIeKV7+
         7v7BfrwsKuz6yhpRI8ilbwlE6IgFJpP/dNgwUpuPoJaqGEDkHVCAmvf0cbYznBKuRBmV
         ThQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/QSONSEpjxrPZtFb9gmtNnByfU6eZhR98/Jc/QyZERA=;
        b=SFGCdIiqgiVelBktNMZ32EmBHApnk3Ywi0T9BoM6HxZnHxQGiUS4UBaQ0/3pX3YvUR
         ETWMYZHGTdu7CoQXTXc3K1F0KcCVNVaooGUdXGih1RNgL/hsmnrjqWbJ7NSMtzPVAWey
         ytjHX5Kil7awNpS9/prIwqPoOYYmPinynX/HKCghQmd5CE9XtZ6PQOdzO+xPcxtWaGzE
         J56CEc85TKYHKsqzoMVcpxVj9Fj9g2qxvUHVpzoLdPDTsYkzmC1UZqoP3CVrht1zF9e8
         o5MURGHsnwAV4x86M7e/2jNQN83YU/oBQxELPs9KGnng3JEjaGGtNtsCScUf8RFR+G+X
         BhfA==
X-Gm-Message-State: AOAM533Z3CtVYSFL5Otl+ioqtKiv6KNpFo7RSVTsohHJSQDffCj2DlJM
        4NziJbwFqMLMXGGi/QPrqAheIg==
X-Google-Smtp-Source: ABdhPJwdXa+qlYDE8Y/a/HDiCzjlWOJpUqVG3mCRzHu0lGE3wEyv3QZg4u0GCxkYtK1svHoBRT3dvA==
X-Received: by 2002:a05:6512:5c6:b0:472:9a4:9382 with SMTP id o6-20020a05651205c600b0047209a49382mr13077933lfo.333.1651146077583;
        Thu, 28 Apr 2022 04:41:17 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bu39-20020a05651216a700b004484a8cf5f8sm2338790lfb.302.2022.04.28.04.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 04:41:17 -0700 (PDT)
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/8] dt-bindings: pci/qcom-pcie: specify reg-names explicitly
Date:   Thu, 28 Apr 2022 14:41:08 +0300
Message-Id: <20220428114113.3411536-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
References: <20220428114113.3411536-1-dmitry.baryshkov@linaro.org>
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

Instead of specifying the enum of possible reg-names, specify them
explicitly. This allows us to specify which chipsets need the "atu"
regions, which do not. Also it clearly describes which platforms
enumerate PCIe cores using the dbi region and which use parf region for
that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 91 +++++++++++++++++--
 1 file changed, 84 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index ce4f53cdaba0..e91ae436cafe 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -40,13 +40,6 @@ properties:
   reg-names:
     minItems: 4
     maxItems: 5
-    items:
-      enum:
-        - parf # Qualcomm specific registers
-        - dbi # DesignWare PCIe registers
-        - elbi # External local bus interface registers
-        - config # PCIe configuration space
-        - atu # ATU address space (optional)
 
   interrupts:
     maxItems: 1
@@ -117,6 +110,90 @@ required:
 
 allOf:
   - $ref: /schemas/pci/pci-bus.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+              - qcom,pcie-ipq4019
+              - qcom,pcie-ipq8064
+              - qcom,pcie-ipq8064v2
+              - qcom,pcie-ipq8074
+              - qcom,pcie-qcs404
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: parf # Qualcomm specific registers
+            - const: config # PCIe configuration space
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq6018
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        reg-names:
+          items:
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: atu # ATU address space
+            - const: parf # Qualcomm specific registers
+            - const: config # PCIe configuration space
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8084
+              - qcom,pcie-msm8996
+              - qcom,pcie-sdm845
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: parf # Qualcomm specific registers
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: config # PCIe configuration space
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+              - qcom,pcie-sm8250
+              - qcom,pcie-sm8450-pcie0
+              - qcom,pcie-sm8450-pcie1
+    then:
+      properties:
+        reg:
+          minItems: 5
+          maxItems: 5
+        reg-names:
+          items:
+            - const: parf # Qualcomm specific registers
+            - const: dbi # DesignWare PCIe registers
+            - const: elbi # External local bus interface registers
+            - const: atu # ATU address space
+            - const: config # PCIe configuration space
+
   - if:
       properties:
         compatible:
-- 
2.35.1

