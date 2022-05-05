Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E395C51BB9A
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 11:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351855AbiEEJQU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 05:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351987AbiEEJQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 05:16:17 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429924C40E
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 02:12:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y19so4784540ljd.4
        for <linux-pci@vger.kernel.org>; Thu, 05 May 2022 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CTHkilprIvL9A/8ur+bw1pjnP/4ABBDDnOBt355kY54=;
        b=MtVHPH+tkf1YNfY9FifF4Ub1Vf/DvqV7wJV7BBt6pPpe0WSzEFCk7IN+oEobRWnfF4
         Ge+x9KE0pRCW/1TAdxY5AqywQbtXZA7lIMb7I+b7Ima6BdjJlFnRcfadTqUtQohlYLT1
         ihrF+FtM96PeZ9GKH/MuOWBlQTTmG8bjcKIIG/xbX4QtPAD3A2n3Q07zEDSXma+rFnDF
         8UJD05ozoC5+ur6v86Ee3iBiSfp4r2+a7L8U27ZqcVPgptI9CkpYh5IZYAfqkTz2+JUT
         Z9K+MDu+I7bkh0serbw8Ugy2r9u/tUvIsrEUsDv9uhRcPRIE3STky0krP3b3QE6GTL8P
         X9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CTHkilprIvL9A/8ur+bw1pjnP/4ABBDDnOBt355kY54=;
        b=E9bw0BgJ+8b/z2QAoiW/4IdtsinMqA+e6RGm9qrGvnJcC2lGOPDiCUak87tf5e3ZqM
         fSaTVU1vS15URlADHey45pe8JKjUcjaMboauHKx7WU21pMntvZ3COD52V8EneTX6t8lH
         vHfSlGxUYn2+In2Ep8inbHkaZBpLRccXwSgc/QnjQa07acp1BfX7m19F6aJJjMrFoJsk
         ORqNlIeceuWhXR/vn3cAehvm8S06/a+j2Y2Lt/ex90nrlo9RxKskILIbwYXl7XRrkT3p
         fK/D4eflWqN9l8UCGs8FLn/fVxt1i1oWEWHFBfa6oNj266Ip3cseeqimMYc8iGCqcFG0
         NiDQ==
X-Gm-Message-State: AOAM530igFSBkACK6Qd6OehhOC2eFtBdTlRQSgbto+xVyZT+ubs2ajKW
        zLN3OuGq/GNVtGYsFDw+nhJvKA==
X-Google-Smtp-Source: ABdhPJw+zrP5UZN20F6mshaehcVua4TB0NWgYUNpRbfWLql7Hgdt0MsCQPsZYuzdjNU45bQY3YP2MQ==
X-Received: by 2002:a2e:b88f:0:b0:24f:4fbc:6628 with SMTP id r15-20020a2eb88f000000b0024f4fbc6628mr12830576ljp.38.1651741956466;
        Thu, 05 May 2022 02:12:36 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2593a000000b0047255d211e8sm133564lfi.279.2022.05.05.02.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 02:12:36 -0700 (PDT)
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
Subject: [PATCH v6 6/7] dt-bindings: PCI: qcom: Support additional MSI interrupts
Date:   Thu,  5 May 2022 12:12:30 +0300
Message-Id: <20220505091231.1308963-7-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
References: <20220505091231.1308963-1-dmitry.baryshkov@linaro.org>
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
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 45 ++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 0b69b12b849e..fd3290e0e220 100644
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
@@ -623,6 +632,40 @@ allOf:
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
+        - properties:
+            interrupts:
+              minItems: 8
+            interrupt-names:
+              minItems: 8
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:
-- 
2.35.1

