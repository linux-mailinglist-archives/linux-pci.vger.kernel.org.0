Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8111F50C333
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 01:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiDVWTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 18:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiDVWS0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 18:18:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE232A9F9
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bf11so11075720ljb.7
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lBJpSd262mq4VkDZA8xlcXegv/Udz316/wj3RuGwRjU=;
        b=Hnz9vbCcuIAJUtwii/DB42Kv7XZu3D+ZAVpGdYq7spRNjTA+JUv10kJWYtpy59461O
         nXvOBuOd2QFPnZ7/2RhgcE5CigKj150SugxyMZNiJvlkFp+/HpqhZrnwf37kShTakvqA
         /NGdNTT+Qy38ZSKr1u6D0Sj+L+RApA2YdUaQ0bOntNBdcPAxRLLgzxXhFfBe5nZllP/M
         3CVS0qJwhvE0gyUs3/h4a84KiynUbvwfl2pmS5Qtlrfnu8CvdEJ7ALYXT+f7x8BuD9Hv
         7goS35PuA5nkj4FE0m3C5ip62FweFdUwTLtQvB1eMj184dgeKHp3ILmt8Pr4ZKkv2sfw
         NYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lBJpSd262mq4VkDZA8xlcXegv/Udz316/wj3RuGwRjU=;
        b=XzDdOLX8vV6806jHls+Xnsp7OVB6UxbPIOBUPswdxKXYgETXbBmIekUsBhwfvfQT3M
         TOBzvXfiVcsrxLFHaW3gUCtVK27r3iU8Mp//2Dcbwc4A2zpY/Th1efu8SXXPRXBk70sY
         Q8brwen1x7TP21kHkr1KLiMJ6/359xUfpbWUEj+Ob3TwYfpxuIHTmyyM7efsWN1BuopO
         fyR3jfDFGAYx+BDmaetXfkP7p9r1nIcwGeojgX2M4i6KrJ9fwj2Psh8tUACcU08AJGP3
         wxcXH0f2b4LfT4o0wY61HjyXZd3zYxbSe7JPblzOgsEPv+VSrLXiC9Vs4c2nqiuo8L+w
         a/mQ==
X-Gm-Message-State: AOAM531gX3gttjysF87TWzLRAso6DbQ2ZBbeZBYFEtuakwTh5iHKGoq7
        V4V7JHdQhP7//gXO6/rdWWjaVQ==
X-Google-Smtp-Source: ABdhPJzu/dykArcfyzvcbPkny6xHW5jxyHIlE3ds6pczL+7b4QfY1GkXmTomASpntZEn+0J/SyNPnw==
X-Received: by 2002:a2e:9856:0:b0:24d:c8ff:76 with SMTP id e22-20020a2e9856000000b0024dc8ff0076mr3843047ljj.363.1650661806874;
        Fri, 22 Apr 2022 14:10:06 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 6-20020ac24d46000000b0046bb728b873sm351240lfp.252.2022.04.22.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:06 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/7] dt-bindings: pci/qcom,pcie: add schema for sc7280 chipset
Date:   Sat, 23 Apr 2022 00:09:58 +0300
Message-Id: <20220422211002.2012070-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
References: <20220422211002.2012070-1-dmitry.baryshkov@linaro.org>
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

Add support for sc7280-specific clock and reset definitions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 4b3c5f98c839..04fda2a4bb60 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,pcie-ipq4019
       - qcom,pcie-ipq8074
       - qcom,pcie-qcs404
+      - qcom,pcie-sc7280
       - qcom,pcie-sc8180x
       - qcom,pcie-sdm845
       - qcom,pcie-sm8250
@@ -334,6 +335,36 @@ allOf:
             - const: pwr # PWR reset
             - const: ahb # AHB reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc7280
+    then:
+      properties:
+        clocks:
+          minItems: 11
+          maxItems: 11
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: tbu # PCIe TBU clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
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
2.35.1

