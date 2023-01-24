Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA0679853
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbjAXMr1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjAXMr0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:47:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76B3EC61
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n7so13757466wrx.5
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIpFvpObr+LCa35ptTAWlpq41PQzSNF4rShpYTqKeo4=;
        b=jszTm7+tL+Z7AsIsCF2rdWTTmytF8Ert+h60gc2L6dBOosSdPnP21X/HLJ2X4/5eAH
         ERdcByEYGEU0MRjiFSvR9re1+Obxdj0PhpiR7mpEYSmwcU1rfRyD6SQjT1y+qkd4iz4U
         0LROnYob6QBVHTyynLEnKRLnvt00zDqte9RJ9KUCmsQcOmCsW0OzeIVVL84zm/PNupMK
         GAGlscWlBY+Srld1uFiixA8LCdvesuYyxGwRm4nwWp0HzugH0G+CK9N6mlCI0gTKKPYD
         tHloUGp/jxtb/7wdAA1QGbr+dyb0eRpnWzp5zM6aTk8nyo9UxgKwZ5lbtb7SBfjYGhzC
         6eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIpFvpObr+LCa35ptTAWlpq41PQzSNF4rShpYTqKeo4=;
        b=6fvrc1oHfPuBPzAZ1D/w4vzJsTSLp2JBpfOP4ihPCaiwfLGphmYK+i2o+EayYwzdKJ
         cCSfNPK3I5pAYv3JYT9QBleiilI0fyvz14Z/3qt8A7D8KePtpG4woev33wQ0iQP8RGU+
         8B5DKPlGWLRIvm7ceIQ0+6d6xuViQEBxHGQvloqBWIxL5/HVsCpVSDvXEVxF/WPS927H
         gm4/T1uT/+jXlnUpM13tyOwqPmBEgl4F0yzpGtE6xqU/bojR2DHEph0dSpy1aFVh+H7O
         Kld/flmT5e5wXl1bIBKXPFgKaz28zuxswXcoEzBjVzr6UrQqvo1FW134ppCYa0FvcOHn
         M2lA==
X-Gm-Message-State: AO0yUKU0nQYPUvLP2a0Xy1TJZTZVT1PkbwrAQCVL1oTA3sZWuD2dJ7oo
        +BcyEZrgzlsFKo2lDrdUR2Pl9Q==
X-Google-Smtp-Source: AK7set+YMwedlvqtr7K1l0ADC2IbHJ3R8aLyO+c6ixu0trA29JDxkBdQ/I30lJtWzVrlA6+Q8Y/yjw==
X-Received: by 2002:a5d:4f87:0:b0:2bf:b2c2:e123 with SMTP id d7-20020a5d4f87000000b002bfb2c2e123mr1186333wru.34.1674564442394;
        Tue, 24 Jan 2023 04:47:22 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d5705000000b002bdbde1d3absm1766840wrv.78.2023.01.24.04.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:47:21 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v5 01/12] dt-bindings: phy: Add QMP PCIe PHY comptible for SM8550
Date:   Tue, 24 Jan 2023 14:47:03 +0200
Message-Id: <20230124124714.3087948-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124124714.3087948-1-abel.vesa@linaro.org>
References: <20230124124714.3087948-1-abel.vesa@linaro.org>
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

Document the QMP PCIe PHY compatible for SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v4 of this patch is:
https://lore.kernel.org/all/20230119140453.3942340-2-abel.vesa@linaro.org/

Changes since v4:
 * constrained resets and reset-names to 1 for every other SoC

Changes since v3:
 * increased the allowed number of resets to allow ncsr reset
 * added vdda-qref-supply which is used by pcie1_phy node in MTP dts
 * added both compatibles to the allOf:if:then clause to constrain the
   number of possible clocks to 5

Changes since v2:
 * added back the binding compatible update patch

Changes since v1:
 * split all the offsets into separate patches, like Vinod suggested


 .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 8a85318d9c92..5b491f4efd66 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -20,6 +20,8 @@ properties:
       - qcom,sc8280xp-qmp-gen3x2-pcie-phy
       - qcom,sc8280xp-qmp-gen3x4-pcie-phy
       - qcom,sm8350-qmp-gen3x1-pcie-phy
+      - qcom,sm8550-qmp-gen3x2-pcie-phy
+      - qcom,sm8550-qmp-gen4x2-pcie-phy
 
   reg:
     minItems: 1
@@ -43,16 +45,21 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   reset-names:
+    minItems: 1
     items:
       - const: phy
+      - const: nocsr_com
 
   vdda-phy-supply: true
 
   vdda-pll-supply: true
 
+  vdda-qref-supply: true
+
   qcom,4ln-config-sel:
     description: PCIe 4-lane configuration
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -113,6 +120,8 @@ allOf:
           contains:
             enum:
               - qcom,sm8350-qmp-gen3x1-pcie-phy
+              - qcom,sm8550-qmp-gen3x2-pcie-phy
+              - qcom,sm8550-qmp-gen4x2-pcie-phy
     then:
       properties:
         clocks:
@@ -126,6 +135,25 @@ allOf:
         clock-names:
           minItems: 6
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8550-qmp-gen4x2-pcie-phy
+    then:
+      properties:
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+    else:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
-- 
2.34.1

