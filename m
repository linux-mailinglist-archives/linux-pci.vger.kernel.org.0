Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832D550B673
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447174AbiDVLvo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447179AbiDVLvn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 07:51:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1C74505C
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y32so13841986lfa.6
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDrG5kFEfiEp4skFz7xt84FxE16P9MWo3XQUbKtu4KM=;
        b=SkW7y1+StTiCMgxzBtgzStz1GKVnM9Gar8g8po62dwqfSndeL93ajz+CP24Nqzibxv
         B5Q8e2nHktgTzCX9mrjUFu3IuErPTnFeuLbVultV1m+NpC+HRbAsI2wlISSDW24gQyGQ
         fHghmZ6kiGmnuXSAdzvJLVD3BEXjAWaSyyVwFX7bX6SY0f9iWxJNt/qONiUD0FQSOow4
         C6k2OV3xdWNYwf7U/evxs79V8Wd16yMCDjFHpd0Gj4ainzNzfiPEKfGrR31if/3Fi1/R
         ExKZsy2FRN/1sAcrEQzZaGIgcpujUeMV3TPapHt6tavbJcdDxJds4iiqKYyV/Sjo/0Tz
         +REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDrG5kFEfiEp4skFz7xt84FxE16P9MWo3XQUbKtu4KM=;
        b=ro7QYOItcJU+nwdqlvTPwyrF4fljsGmG86vdk6Ob3C+e9/DLEzCbLm3yvrZV8I7kDN
         s9lmwAr/FmBk7wtTEbcleCM19ijoCp5Eiw0aY380T09Nid6JX2DafvFXpL+FTBdXSQuZ
         HRiI6CU1+In2Y9Rl9PCsd6TchnZaE1upcWgddcwRDpBJaoRbXfpSAAuqBzlU6corZTu/
         RoP+H6sWML9ggMK8WDHJbmR87+nPGaoKZ/GoUJN9BcObpLAkqbZiGtHSAiyCDqu5QOLE
         ryR17Qy7uc26Oa+agS+YYn39Ss29wusag2zLTvybNR4WAZg/Cem6o3Hlbu3SizhrGXqa
         4ugA==
X-Gm-Message-State: AOAM531DEd/TJIyMx+H/3BpzdZ3Na06x7+jOuJiEiGQVBje0wxWtgsWM
        yt7n4IB9CGkdMMpnefZCOBux6N/9GJeFdA==
X-Google-Smtp-Source: ABdhPJztUoGTLA7Ncs+GjbXSHtTvr8s9D2wVQ7ahOW9+2OUHZnR+PtmXhusx0lm5Z1zDO/O8pFNquA==
X-Received: by 2002:a05:6512:1148:b0:44a:6c26:e5a9 with SMTP id m8-20020a056512114800b0044a6c26e5a9mr2724122lfg.491.1650628128470;
        Fri, 22 Apr 2022 04:48:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.65.189])
        by smtp.gmail.com with ESMTPSA id h7-20020a19ca47000000b0047014ca10f2sm200695lfj.8.2022.04.22.04.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 04:48:48 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/6] dt-bindings: pci/qcom,pcie: stop using snps,dw-pcie fallback
Date:   Fri, 22 Apr 2022 14:48:39 +0300
Message-Id: <20220422114841.1854138-5-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
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

Qualcomm PCIe devices are not really compatible with the snps,dw-pcie.
Unlike the generic IP core, they have special requirements regarding
enabling clocks, toggling resets, using the PHY, etc.

This is not to mention that platform snps-dw-pcie driver expects to find
two IRQs declared, while Qualcomm platforms use just one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 38 +++++++++----------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index e78e63ea4b25..31c11a9f716e 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -16,24 +16,22 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,pcie-ipq8064
-          - qcom,pcie-ipq8064-v2
-          - qcom,pcie-apq8064
-          - qcom,pcie-apq8084
-          - qcom,pcie-msm8996
-          - qcom,pcie-ipq4019
-          - qcom,pcie-ipq8074
-          - qcom,pcie-qcs404
-          - qcom,pcie-sc7280
-          - qcom,pcie-sc8180x
-          - qcom,pcie-sdm845
-          - qcom,pcie-sm8250
-          - qcom,pcie-sm8450-pcie0
-          - qcom,pcie-sm8450-pcie1
-          - qcom,pcie-ipq6018
-      - const: snps,dw-pcie
+    enum:
+      - qcom,pcie-ipq8064
+      - qcom,pcie-ipq8064-v2
+      - qcom,pcie-apq8064
+      - qcom,pcie-apq8084
+      - qcom,pcie-msm8996
+      - qcom,pcie-ipq4019
+      - qcom,pcie-ipq8074
+      - qcom,pcie-qcs404
+      - qcom,pcie-sc7280
+      - qcom,pcie-sc8180x
+      - qcom,pcie-sdm845
+      - qcom,pcie-sm8250
+      - qcom,pcie-sm8450-pcie0
+      - qcom,pcie-sm8450-pcie1
+      - qcom,pcie-ipq6018
 
   interrupts:
     maxItems: 1
@@ -618,7 +616,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     pcie@1b500000 {
-      compatible = "qcom,pcie-ipq8064", "snps,dw-pcie";
+      compatible = "qcom,pcie-ipq8064";
       reg = <0x1b500000 0x1000
              0x1b502000 0x80
              0x1b600000 0x100
@@ -663,7 +661,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/gpio/gpio.h>
     pcie@fc520000 {
-      compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
+      compatible = "qcom,pcie-apq8084";
       reg = <0xfc520000 0x2000>,
             <0xff000000 0x1000>,
             <0xff001000 0x1000>,
-- 
2.35.1

