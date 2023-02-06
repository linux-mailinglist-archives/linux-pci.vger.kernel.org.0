Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919B668C8B5
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 22:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBFV1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 16:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjBFV0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 16:26:50 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC87A2FCEA
        for <linux-pci@vger.kernel.org>; Mon,  6 Feb 2023 13:26:37 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id g6so3763052wrv.1
        for <linux-pci@vger.kernel.org>; Mon, 06 Feb 2023 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aeOmpqwMmxkY1QZikHKLyuYAS74TD49W362Zn8wzwc=;
        b=EtKTJ8mp0jdzkf2iMnOgBw8bDcyge4SJkBz4MtMJNup3kqZWTAChYo8Z0HnutgLiX6
         7XVTZmswY5bC2zfXsWVOmImBINV/T1AXby0+zUzSAMc6THi57T6avTDkBVQvmWPbWZy/
         SeJiLE+XFuw11M3vTMgFQbR9pjqUaLWrEudcw4Vn16mQOtJ6FcD/mEcSH6eaMde9tDkd
         3t0LwTB/1ETG4GdwOlNiv0nDFfLpEQAYknmQ/6/Wsmgzo3eWDs4W7k5ITtGLLERCxjw+
         oASC/dNMDKZ8Y7T6hY2zNQ5wGrxOOFzg8iPvpB3rsyD/nskTsr3avhjxTxlJL7DHaZ0k
         vJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aeOmpqwMmxkY1QZikHKLyuYAS74TD49W362Zn8wzwc=;
        b=c0C6qM1YA6F8C4wKRRLJW4lU+IyGcIysWoO/3EKF/LR/kJzpXlPyJV9QgThIsEO7G6
         G0puWnv+avK6LWUaP09THdgNtTzj4ZVPB/iDJCc1Q1M7SCXbq3yLxFWG5Rbq/2wtjnOt
         gN/RvqxK3XvbARyOKk8Sw4sKqi/BU9nTmXXAqHM9nb4Y1bOJlM7A7YVuGOFyxC/SHTEB
         +2zAjMby1vhLLX7EZMfE7vW7fJLfSniPe2JEIG24KUAT68im7MjL+rSfsma0O+koy9Go
         71Zo2wqHAi9qyup2cwzx4M0OczzFXd9W23hm7h4pbsvzR0fa6O/MD+7XyWdPyIHPvQOf
         AAHQ==
X-Gm-Message-State: AO0yUKXh2gVtTsb814uzNPkQ4vMARKmWwL8LoESpEmkOSBo+7o7Hylbb
        RAJ2cPXvsC84TFcXsV3brOJ6GA==
X-Google-Smtp-Source: AK7set8SxEThn2/ItZXlViJj0RdcC8gMUtTvDLo0wHW6YjfHnkk839xo7xpm4yhRIwVxhtuBBhekcQ==
X-Received: by 2002:a5d:5486:0:b0:2c3:f026:9082 with SMTP id h6-20020a5d5486000000b002c3f0269082mr253212wrv.35.1675718797127;
        Mon, 06 Feb 2023 13:26:37 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d604b000000b002b57bae7174sm9783341wrt.5.2023.02.06.13.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:26:36 -0800 (PST)
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
Subject: [PATCH v8 09/11] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Mon,  6 Feb 2023 23:26:17 +0200
Message-Id: <20230206212619.3218741-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206212619.3218741-1-abel.vesa@linaro.org>
References: <20230206212619.3218741-1-abel.vesa@linaro.org>
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
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---

The v7 of this patch is:
https://lore.kernel.org/all/20230203081807.2248625-10-abel.vesa@linaro.org/

Changes since v7:
 * dropped the enable-gpios property as it is not used
 * added Johan's R-b tag

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

 .../devicetree/bindings/pci/qcom,pcie.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 872817d6d2bd..eb7f5a9aef2c 100644
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
@@ -205,6 +212,7 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -639,6 +647,37 @@ allOf:
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
@@ -724,6 +763,7 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       oneOf:
         - properties:
-- 
2.34.1

