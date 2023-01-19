Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EF6736B2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 12:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjASLZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 06:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjASLZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 06:25:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986171784
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 03:25:05 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so1534458wrw.4
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KhSiUckYJfa4o89CtDf2AZXZu6HVpjJ+//JV2rKmVLg=;
        b=WvcFi6kJBN9JAXBniyOPQnvo2unN7GntUV7VMw6qzjHsVIy5jHYUnhcRq++hAEZ+PY
         j0vI+SHcPqh6cfLmrpzHL+nE0kfZ6V4EXh+1jKfHL38b+NW4daapZvFLIxYXfb4/N7I8
         LHRI5dPr2PU6Y/WEAzqohuH4QfP2RSONIXoCl7ZrT12eRJRipR04Ij/a2Js5pvMCTezl
         mu/CfGR50FwaVQ0S1FueBqPI5ytLIrKTnrcC/Tw/Evl+9h7s6ASJKObzhlYUeFSptYWS
         pvnqQsr74m6Ul4JTxLnS8FgmOUu7IReNcayob4NEuLXoAK5pS75hAsViqPzHlvgR6k+3
         3wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KhSiUckYJfa4o89CtDf2AZXZu6HVpjJ+//JV2rKmVLg=;
        b=a4r5YfyYh2Wj+4l6y4qkIySAkg0CGFVHBvhw4o5nHhKYw3eMmkV1GtIriweesH/Udf
         8qEY8sMeM3OdQOmlAhUdJKIYXCJk02nTBgpGngKLXhi1ZcNnfxwJf4MM9KWmEGZE8WCh
         jkRjqQgGXjWLGm5l/UtqIG17uhuKWlqgC3EXZLtgrPRpUiLs9PDTHHIu9I4rI3Bro3Jb
         D+acaP8ZfnfRTUhUT+/qqa+8E4IGG1ydHQMMgCaRsYIplnUGRwl0Y3SCUkVs0GX9vEVm
         +7GRBr+KpPuXeQvR+EBzSPonKzjjZGWTB3/H60o7GoCNQci4bqBaerX0ETy0YkSKwvYe
         LNtQ==
X-Gm-Message-State: AFqh2kqb3N1ujczBfYS18qqumMGFj7mJi25C/aOPIOtzW1f6tnbQYM3h
        hV2zaGk20KQUE5H+/+LoXUghrg==
X-Google-Smtp-Source: AMrXdXtr/1SnwzKV1Ymz1oTGH63DnBZsafreFHgSL4qxEjoJgRNo39jDHtIL6+V7oqnUunap0UQDAA==
X-Received: by 2002:a5d:40ce:0:b0:2bd:e8a6:f7cd with SMTP id b14-20020a5d40ce000000b002bde8a6f7cdmr9099417wrq.62.1674127503766;
        Thu, 19 Jan 2023 03:25:03 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d404a000000b00275970a85f4sm33436999wrp.74.2023.01.19.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 03:25:03 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Thu, 19 Jan 2023 13:24:52 +0200
Message-Id: <20230119112453.3393911-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add the SM8550 platform to the binding.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v2 was here:
https://lore.kernel.org/all/20230118111704.3553542-1-abel.vesa@linaro.org/

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
index a5859bb3dc28..93e86dfdd6fe 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -34,6 +34,7 @@ properties:
       - qcom,pcie-sm8250
       - qcom,pcie-sm8450-pcie0
       - qcom,pcie-sm8450-pcie1
+      - qcom,pcie-sm8550
       - qcom,pcie-ipq6018
 
   reg:
@@ -65,9 +66,11 @@ properties:
   dma-coherent: true
 
   interconnects:
+    minItems: 1
     maxItems: 2
 
   interconnect-names:
+    minItems: 1
     items:
       - const: pcie-mem
       - const: cpu-pcie
@@ -102,6 +105,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  enable-gpios:
+    description: GPIO controlled connection to ENABLE# signal
+    maxItems: 1
+
   perst-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
@@ -197,6 +204,7 @@ allOf:
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -611,6 +619,41 @@ allOf:
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
+        iommus:
+          maxItems: 1
+        iommu-map:
+          maxItems: 2
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
@@ -694,6 +737,7 @@ allOf:
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       oneOf:
         - properties:
-- 
2.34.1

