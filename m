Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56794624970
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 19:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiKJScF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Nov 2022 13:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiKJScE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2022 13:32:04 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B03A4B982
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r12so4876489lfp.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Nov 2022 10:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/is0taNXLslowunLGClJmRq4bGkunbgWU7W/P30/eU=;
        b=QLcHEj8tmldSMsk/xD24UrMK9a7oBI0QD81Lb7DRhio4Bq9+sev6S9cYliQkZi9IZJ
         A9LeCM0F8uHoSqHbAc1Ljs6XAkA6qtEeq9jCnJn6HxOdtmelKpGo/whY7X+XPsCnGQZQ
         rZZ3Ght1t9tvoyGUI0T8NrILngxwf1gkEbLrZV+A2LKo/4ZW8sWAg6SKp3SnxTYWsKUE
         J9nfihYuBB/Lurb+0g+4vNhP96ADQ2vBV1+tyks84QNllXrRwl24Smb1Nz2HBSU3ICNS
         rCbQM6hJGBdxDWAsIUK8vrJwAWHkdOpF/UPNs+t6Q+AmePZXo1dgF3zbdgoQr+L76dGF
         uiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/is0taNXLslowunLGClJmRq4bGkunbgWU7W/P30/eU=;
        b=FxpNY+Oq13+9yfoGbeyGIXrCaQKBCKUgiZGuZ2iVnexRnqdv8cP5IniGeRwj5eRmkk
         f7NHNu8ZYzpMNcSIqmT30FrnE3Xl4S1PTQOJLB14X0O1KenPjYpaIHPr1lbUBaHR7cbg
         /w6xisOPHZT8kbEIPNuCQopzr0DPOX/Gu3Ghz4+XmD55uvSVLmGVXIBVqmp3vNdMLGG3
         QsQCNSH5WyLM5/ucG69Bi0dNVXd8WJMPjrD+fZfEU3GkXykhaWj6+o6YvYWRm1ph/pYc
         aBSTpp6BnmCh+Iyxhe+TN+YY8aNn8M/QzPLR3hJhPPM+pIKIoD8u4W0bWR60BfOlqKoP
         qk7g==
X-Gm-Message-State: ACrzQf3DhXrzzDd/0/4Lg6tfpre0kOw4tdcmr+HefFGa8mkxTPzekl15
        4CsPHV2paTtVezuZdB4efaV0GQ==
X-Google-Smtp-Source: AMsMyM7opwENk69nQT6Sh/+9iZQMq3uo2+A+baUuYbxu/3Zee88ILJtAneYkibZ6izkX9PgzoE93ig==
X-Received: by 2002:a05:6512:3093:b0:4b0:2457:f1e9 with SMTP id z19-20020a056512309300b004b02457f1e9mr1824201lfd.58.1668105120634;
        Thu, 10 Nov 2022 10:32:00 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m18-20020a197112000000b004a2550db9ddsm2837087lfc.245.2022.11.10.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:32:00 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
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
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/8] dt-bindings: PCI: qcom: Add sm8350 to bindings
Date:   Thu, 10 Nov 2022 21:31:51 +0300
Message-Id: <20221110183158.856242-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
References: <20221110183158.856242-1-dmitry.baryshkov@linaro.org>
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

Add bindings for two PCIe hosts on SM8350 platform. The only difference
between them is in the aggre0 clock, which warrants the oneOf clause for
the clocks properties.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 54f07852d279..502c15f7dd96 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -32,6 +32,7 @@ properties:
       - qcom,pcie-sdm845
       - qcom,pcie-sm8150
       - qcom,pcie-sm8250
+      - qcom,pcie-sm8350
       - qcom,pcie-sm8450-pcie0
       - qcom,pcie-sm8450-pcie1
       - qcom,pcie-ipq6018
@@ -185,6 +186,7 @@ allOf:
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
               - qcom,pcie-sm8250
+              - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
     then:
@@ -540,6 +542,49 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8350
+    then:
+      oneOf:
+          # Unfortunately the "optional" aggre0 clock is used in the middle of the list
+        - properties:
+            clocks:
+              maxItems: 9
+            clock-names:
+              items:
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: tbu # PCIe TBU clock
+                - const: ddrss_sf_tbu # PCIe SF TBU clock
+                - const: aggre0 # Aggre NoC PCIe0 AXI clock
+                - const: aggre1 # Aggre NoC PCIe1 AXI clock
+        - properties:
+            clocks:
+              maxItems: 8
+            clock-names:
+              items:
+                - const: aux # Auxiliary clock
+                - const: cfg # Configuration clock
+                - const: bus_master # Master AXI clock
+                - const: bus_slave # Slave AXI clock
+                - const: slave_q2a # Slave Q2A clock
+                - const: tbu # PCIe TBU clock
+                - const: ddrss_sf_tbu # PCIe SF TBU clock
+                - const: aggre1 # Aggre NoC PCIe1 AXI clock
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -670,6 +715,7 @@ allOf:
               - qcom,pcie-sdm845
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
+              - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
     then:
-- 
2.35.1

