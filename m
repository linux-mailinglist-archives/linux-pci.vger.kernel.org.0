Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B53679877
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 13:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjAXMsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 07:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjAXMsH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 07:48:07 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F71457D6
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id y1so9269285wru.2
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2023 04:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrldaaWGIUz5RWdh+krK3nRA9Yar72lQE/bz4xdVemE=;
        b=zmLLwfcAgYLnCSUjZSGRit/IreL5dJktxVITjcVonR1DrIorWJUEa5fm+gebYcyx1J
         5094NgB8SQCfIo5ruW8oSa3JznsLVavyKTomZuMEw5h229zMbBpeUZf+pIGuwBqRDkKy
         cXbu+BsR9cd6y9D3t1Smm9ge2jp3L6jG2GpAL6MBL79vtimsj5n4cqhgyRlCilmVNd2/
         O7KpF6PBkng0xuofFTkD3laTulNVyj3p9O3dTW2uRfDv2YpSw5tlUTLssNwJ0UrZrPuY
         CBkhKCrhQWtx5GdWOXmN5eT6GoxHVPcloDocw4xjR9FVquazUOQAJnvfMr7vfKVYQsBw
         t8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrldaaWGIUz5RWdh+krK3nRA9Yar72lQE/bz4xdVemE=;
        b=heybgvDK0QmkR9+2B1xNaxijUE4eNGrImTEeAmpUt33VaO6p1HugozWbE5TrOthvQv
         UyZjh4q4tzfnZmOcf/uJ9eLD9MKRXVC78RrM2m9a/ZLh1ETgHnHwUntd9PNVUBA1vMsb
         qGjLHSPAa9ybjya+wGfCBSuQJYTwM84kNVv9ws+gOHhyNP9Wq6PL93OmiK94zkinF4gX
         bShVP7a0a0qzgJ4hM5mIUlKvB4UMP5AG3E8HYSHAiIh0a2mpVz6tSJ8y5TEDIBiYfNXA
         XRUaO59D4FhvMI3pCx0s1/dpZFshKUtLInAshx6tedX/bOsj95nI1C+lKy6+5Y0ZTCRq
         YC7Q==
X-Gm-Message-State: AO0yUKWlRt88nUJr+SS1Ne63iAGSCXfK3udVWoF9sioGlC9lwh2AOyo1
        rWvf7zN14aMkLfWbZfoPs6Eavg==
X-Google-Smtp-Source: AK7set+kFPxHL5wIiuB75PmesHeCajX0j7XEcHR5vWoOGw2q9NZ0wNQlwJvtuwXrl014YhUQ2X03nw==
X-Received: by 2002:a5d:58d0:0:b0:2bf:b26a:3404 with SMTP id o16-20020a5d58d0000000b002bfb26a3404mr1180174wrf.12.1674564455213;
        Tue, 24 Jan 2023 04:47:35 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d5705000000b002bdbde1d3absm1766840wrv.78.2023.01.24.04.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 04:47:34 -0800 (PST)
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
Subject: [PATCH v5 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Tue, 24 Jan 2023 14:47:11 +0200
Message-Id: <20230124124714.3087948-10-abel.vesa@linaro.org>
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

Add the SM8550 platform to the binding.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v4 of this patch is:
https://lore.kernel.org/all/20230119140453.3942340-10-abel.vesa@linaro.org/

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
index a5859bb3dc28..c690152dfbf2 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -34,6 +34,7 @@ properties:
       - qcom,pcie-sm8250
       - qcom,pcie-sm8450-pcie0
       - qcom,pcie-sm8450-pcie1
+      - qcom,pcie-sm8550
       - qcom,pcie-ipq6018
 
   reg:
@@ -52,6 +53,12 @@ properties:
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
@@ -102,6 +109,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  enable-gpios:
+    description: GPIO controlled connection to ENABLE# signal
+    maxItems: 1
+
   perst-gpios:
     description: GPIO controlled connection to PERST# signal
     maxItems: 1
@@ -197,6 +208,7 @@ allOf:
               - qcom,pcie-sm8250
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
+              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -611,6 +623,37 @@ allOf:
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

