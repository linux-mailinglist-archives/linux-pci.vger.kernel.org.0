Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6816891DE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 09:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjBCITT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 03:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjBCISh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 03:18:37 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CDA66F86
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 00:18:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so5198514wmq.1
        for <linux-pci@vger.kernel.org>; Fri, 03 Feb 2023 00:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUv+/DP5HDqVUjJCYqm6NcUIHYkGwBcSmMbmyV7wExA=;
        b=AOL0oTxqcg2qzd89qJjYczS9Wt2ZkOs27AzBaNx6SnAXyJJMlN/g+BNpCGPCgjlB1Y
         pjH+fFPwjnF832C7U1nwDC4eje5kIYH1kQZYU8o78Eu5Ikeo9ikHZvP7G5z5MCn/DMRC
         TyzRgAp8PJUrmMLFhZmuD/u9+5DuPdBblndFcT3PGYt4swjYBfbG+LA//6gbewzsOSxt
         fwkYEVXU0Nfpp0ScHgWWrR+uvhFDcv7XOIV5kj4/r+lEsA2KBq+OwG8QmOO8PN5mXEEA
         ce4pc1+OWOU7Yp/4gimAgqU5uVHZRJQCOBM+cuTLKVc+FAENm6OI9SwsD1NanJy9MTiq
         sgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUv+/DP5HDqVUjJCYqm6NcUIHYkGwBcSmMbmyV7wExA=;
        b=cHI+UoGPuCYCHKXx1Vt0wLCAprFDi5R6qUxbyZFzg0G2lRb4yKuJsECJTPhf5ynyNq
         AJI6Mt9cObHqSZl/MgEbYOoo0f1PiCfCPwB+ZcXPdgK5KPVE890D/ddHrxNg4hG2tVH8
         4qzLzBK8fBUUmtG1AGqRg8No1be6U+9gyhQam4daWpMiVq/ztC5p+f8ecurc5J9fGoXQ
         0wT4lhvDOfn/kLttTzPROM1OybC5Og5pnzgXzt2QUSTpQufhwKKXN9dVJ9X9zW/UGqcu
         TwV0ukeZbl+dkUsGlm9hV5tbJITCOn42bySqUs+hcXZ/3YHQEx//5hySSIKA3Cl4jhDE
         nS9w==
X-Gm-Message-State: AO0yUKVXc4RdSsU0m+UXNOOJFYQDxBSs4qj+b5VNO/eieSnvYPSk1W9F
        838pUTcsa9V+m7stsU76aOLbXQ==
X-Google-Smtp-Source: AK7set9C63cnvgsYup2NUETpwPRF1AULiuo2odlLyVAlHHgKSBJjX2F4mPijG2j44SjUQTqWKPwLWg==
X-Received: by 2002:a7b:cc12:0:b0:3df:1673:90b6 with SMTP id f18-20020a7bcc12000000b003df167390b6mr7431314wmh.39.1675412306033;
        Fri, 03 Feb 2023 00:18:26 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id az24-20020a05600c601800b003dc4baaedd3sm7316591wmb.37.2023.02.03.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 00:18:25 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Fri,  3 Feb 2023 10:18:04 +0200
Message-Id: <20230203081807.2248625-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230203081807.2248625-1-abel.vesa@linaro.org>
References: <20230203081807.2248625-1-abel.vesa@linaro.org>
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

Add the SM8550 platform to the binding.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v6 of this patch is:
https://lore.kernel.org/all/20230202123902.3831491-10-abel.vesa@linaro.org/

Changes since v6:
 * none

Changes since v5:
 * added Krzysztof's R-b tag

Changes since v4:
 * dropped _serdes infix from ln_shrd table name and from every ln_shrd
   variable name
 * added hyphen between "no CSR" in both places
 * dropped has_ln_shrd_serdes_tbl
 * reordered qmp_pcie_offsets_v6_20 by struct members
 * added rollback for no-CSR reset in qmp_pcie_init fail path
 * moved ln_shrd offset calculation after port_b
 * dropped the minItems for interconnects
 * made iommu related properties global
 * renamed noc_aggr_4 back to noc_aggr

Changes since v3:
 * renamed noc_aggr to noc_aggr_4, as found in the driver

Changes since v2:
 * dropped the pipe from clock-names
 * removed the pcie instance number from aggre clock-names comment
 * renamed aggre clock-names to noc_aggr
 * dropped the _pcie infix from cnoc_pcie_sf_axi
 * renamed pcie_1_link_down_reset to simply link_down
 * added enable-gpios back, since pcie1 node will use it

Changes since v1:
 * Switched to single compatible for both PCIes (qcom,pcie-sm8550)
 * dropped enable-gpios property
 * dropped interconnects related properties, the power-domains
 * properties
   and resets related properties the sm8550 specific allOf:if:then
 * dropped pipe_mux, phy_pipe and ref clocks from the sm8550 specific
   allOf:if:then clock-names array and decreased the minItems and
   maxItems for clocks property accordingly
 * added "minItems: 1" to interconnects, since sm8550 pcie uses just one,
   same for interconnect-names

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 872817d6d2bd..9f1bdbc4b0fd 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -38,6 +38,7 @@ properties:
           - qcom,pcie-sm8350
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
+          - qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8996
           - const: qcom,pcie-msm8998
@@ -58,6 +59,12 @@ properties:
     minItems: 1
     maxItems: 8
 
+  iommus:
+    maxItems: 1
+
+  iommu-map:
+    maxItems: 2
+
   # Common definitions for clocks, clock-names and reset.
   # Platform constraints are described later.
   clocks:
@@ -108,6 +115,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  enable-gpios:
+    description: GPIO controlled connection to ENABLE# signal
+    maxItems: 1
+
   perst-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
@@ -205,6 +216,7 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -639,6 +651,37 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8550
+    then:
+      properties:
+        clocks:
+          minItems: 7
+          maxItems: 8
+        clock-names:
+          minItems: 7
+          items:
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: noc_aggr # Aggre NoC PCIe AXI clock
+            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+        resets:
+          minItems: 1
+          maxItems: 2
+        reset-names:
+          minItems: 1
+          items:
+            - const: pci # PCIe core reset
+            - const: link_down # PCIe link down reset
+
   - if:
       properties:
         compatible:
@@ -724,6 +767,7 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       oneOf:
         - properties:
-- 
2.34.1

