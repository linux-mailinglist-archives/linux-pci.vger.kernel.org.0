Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA41687D92
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 13:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjBBMj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 07:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjBBMjn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 07:39:43 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD98DAD9
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 04:39:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bk16so1554917wrb.11
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 04:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3cpLmQKkpTI7Y1psq2KMOuaf6aMRXzbT/aYEgPUMCk=;
        b=bfHCkzh/dFq6Rgtnx4cPXqOFw0qek9foVTrhwK2ENI+lj6yCnWexKjNRMMWkAUCNHe
         VC5Jf5E1ZEerGI+426bCgyp7WZjeATfFQH4fpTMjhCMrMPq8XVuIfdBkyN/Wfn4Rw4C2
         b/d9YN+2rGd8OB1yhbivLSOO0dGqu6Mxp3gLEJIHnFnjhtIfhcyGqhCx869IOA0CtII6
         BZD68SBnfAE6aO3EXU8F42sPQTXXyAZC4Lx+8z8YTnKAYheNEB21jvlpoKB5SW8H1jru
         p5WTrvJLsmPr6n9/GDVkuWfqdWhBTFylSx7No+Z2dQu2NYvSkXQEhrKwbbuuZaPh4WYa
         qhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3cpLmQKkpTI7Y1psq2KMOuaf6aMRXzbT/aYEgPUMCk=;
        b=XtNgezZlRQhtKs2xkUz1qJclKTHkrpDfbHFa390StY7TNxU8dc3qBMbO1Ux20KSwhn
         XxRoED8pSWVg/awzJ6BLdOQBxhCsrwhQkmYGDvWmftd6jNwEA8WmcZeeOmZVpEWZDeD+
         3a8QJvKZQHTqQY7g/4xLhhqatuy3QRC9uytJDq8ZevqWahS0fd8coTcuK7q1do7Un9GB
         +E4v+37VzcaK/FMqry6ru2/TC0f1SWlO+0iZS7cxotYCTThwf27aHIB+C9LYDgO/4h2Z
         mkxAldJNr8hBVNwZnY/WU303mB+rDB54NK0oQdyEry2PuSB0c1ovuM0Fsr9mvk0i51GX
         GXUQ==
X-Gm-Message-State: AO0yUKWRr1N+EpmR5kpf25y/n0ZDodGHQA19pPyrYgBU6FobjTSsdVzf
        or7Cl4dALFhdR3Ct31+GXK9wVA==
X-Google-Smtp-Source: AK7set9HEpaSgaWlFtFya4ohwrlN79++x0IRKbAnmXHCQ7Wu4iTcXEdV67l4kobLPf5S86I0N8gtzQ==
X-Received: by 2002:a05:6000:1c08:b0:2bf:c805:7b36 with SMTP id ba8-20020a0560001c0800b002bfc8057b36mr1660477wrb.49.1675341564490;
        Thu, 02 Feb 2023 04:39:24 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j5-20020adff005000000b002bddd75a83fsm19525644wro.8.2023.02.02.04.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 04:39:24 -0800 (PST)
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
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Thu,  2 Feb 2023 14:38:59 +0200
Message-Id: <20230202123902.3831491-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202123902.3831491-1-abel.vesa@linaro.org>
References: <20230202123902.3831491-1-abel.vesa@linaro.org>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

This patchset relies on the following patchset:
https://lore.kernel.org/all/20230117224148.1914627-1-abel.vesa@linaro.org/

The v5 of this patch is:
https://lore.kernel.org/all/20230124124714.3087948-10-abel.vesa@linaro.org/

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

