Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1071E63064D
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 01:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKSAJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 19:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiKSAJd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 19:09:33 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A289E972
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 15:32:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c1so10619429lfi.7
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 15:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A6rilHFZI6MYdzHjtL9YOIpSlyXP0el9z1gbix2N18=;
        b=oOU7yE9qXDOAgFpSHdkzaJB8QWRzZPXm8BJ75Cj1dDj1tclwRuVIuTQNe7K8dbzbxh
         PkboBWf2XsZxcZ3RhCKvkHcVA4zQ0TKKVkCa0xN7/dfBNkkPZQDNOHbQsrsxU2ht9Xzv
         2wd2vPrOd8rQ5J+NO9nDRKe9CHdlWMcA+4GR0hb82+txUIExVPkRAouY83dWWWMn8Nyf
         FHN3ZfgfqWi57zlV21xUybvShXZ7FTP7Ruj5HeIB4BUuNSmff9+pvmmhZOYSLa0xeSqK
         UPL/HguKX/tgMfzdG2Ce5aRuVp4bpgSq9mIrXKUiziY8KSpTDTJkklG0uuQGOR3ZejvM
         85tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+A6rilHFZI6MYdzHjtL9YOIpSlyXP0el9z1gbix2N18=;
        b=GzsjtyhxguLbc+EbRLxmIb0TvB00n1YtW1cllsp+V+b9SnxQrMtrcRYlpXIsN0FZAn
         s8xUIF9DxK237dTmNI8gobnPI5689XJ12zODYS4fn27y3Ldxz/YpnhP5VG9BBE3wk4Nf
         cOircreyWxd/dWoDD22biSxjIfTeUYiDbjyN6To8JFc6s5+UG/eHpBV9Dt4H2NNKwnQu
         S9roNiTDqhoHOBptI/hkVLlrfe6jLBTqkaBEfN7gxijasevup3zaE94CEmmlhfpFWe2I
         Wi3pvYc69kILzi5hAM7YTCnZ1Q0l3q+ZTCzkl7e8OZ7rfN4xAGEe1ARreEgr0sWqE5V0
         UAZA==
X-Gm-Message-State: ANoB5plh2w+asf8ErjvUONgINMVq/AJLrC+tT6THEPaJlxzcziBqumHZ
        18NgFzuKu98vAkiP2ozSFmKpKQ==
X-Google-Smtp-Source: AA0mqf42nQntitlvu0C5N/oHufK7bSWByH1O58uOQ5GalVNLYodSXuk1OmCznTzWJ97hZTgyjS3LnQ==
X-Received: by 2002:ac2:5f9b:0:b0:4a2:5163:f61b with SMTP id r27-20020ac25f9b000000b004a25163f61bmr3006817lfe.177.1668814367948;
        Fri, 18 Nov 2022 15:32:47 -0800 (PST)
Received: from eriador.lumag.spb.ru ([194.204.33.9])
        by smtp.gmail.com with ESMTPSA id k13-20020ac257cd000000b004947f8b6266sm843900lfo.203.2022.11.18.15.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 15:32:47 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: PCI: qcom: Add sm8350 to bindings
Date:   Sat, 19 Nov 2022 01:32:35 +0200
Message-Id: <20221118233242.2904088-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
References: <20221118233242.2904088-1-dmitry.baryshkov@linaro.org>
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
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 2f851c804bb0..ea295bc30504 100644
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
@@ -193,6 +194,7 @@ allOf:
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
               - qcom,pcie-sm8250
+              - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
     then:
@@ -548,6 +550,35 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8350
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 9
+        clock-names:
+          minItems: 8
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: tbu # PCIe TBU clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
+            - const: aggre0 # Aggre NoC PCIe0 AXI clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -690,6 +721,7 @@ allOf:
               - qcom,pcie-sdm845
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
+              - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
     then:
-- 
2.35.1

