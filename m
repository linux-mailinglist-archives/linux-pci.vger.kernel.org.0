Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AB673B37
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 15:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjASOG0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 09:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjASOFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 09:05:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F7680883
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so1605720wmo.5
        for <linux-pci@vger.kernel.org>; Thu, 19 Jan 2023 06:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmxDEmjJAIZF6pBIcHDYYCg28aDDwgUhbVh1uCP6umk=;
        b=ijj1Sbml5IM/ADUkkgnEpuWAxJxQdH8gs5DcECvy0wOc6ZyyHF9E1qt+kClZERSR1I
         1tFs5yeziEVIG0YXwpVxRZwhjctqmXUXNSZzRrHvliOdrfFVex5wq6tIPi+1FhaLCmY2
         pQNTojW31NEbzA2SEaXoJvWFsP8apB6lF4dYxMkMNY2L4dMTyfvJBmkY8I1BdJtjUJe9
         gbMV81bvemhMsjTqBEOQJUo6Ta13+88ubzvbeFhsykw4/wrERB+JldyeigHqRavbS8e+
         8ZdrkvYk83H+/BYl0I5sRb+xjYUE5wT+n92/EigxuZ0vhmlcvDLI3BT/dI6GtPa4FBgl
         REpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmxDEmjJAIZF6pBIcHDYYCg28aDDwgUhbVh1uCP6umk=;
        b=DL/PsQiWFpK08x69gzjMrIZdIn2dVBCKmjT5h6Ivr/gxDZf50uPT57z324MEqp/x2b
         xIvMxu38j3txe5Oqt1KLsjZ6XL9K0+lHrZ3DPcfYfHwE9aF0EC09WX7CLU/GC94znxcs
         zkby2h3SDCYc4SXRvU+XgJD5WaUDn++0r89N/77BV4crSJw4g0I4SX8JcfzKEb72Tpzl
         mamBjstoinGkTSIYsE87tJkibAnaeThogLo80TSZtrf+2huMqgIlb3Ao5wOpTccm+dSC
         j+liL5CXfwD9qUH3ulSuEn/8F1pdV0zIKCyNwVUfYFuULuRUVuTMOujPVaPMjs1FISIC
         h6mQ==
X-Gm-Message-State: AFqh2kq7o9ufBqtmVA0qggt9zqnefrHerTiwPHmjijfXleGc+8R3h5hZ
        FEOrykttsOBqWK+fY9uG26Qutw==
X-Google-Smtp-Source: AMrXdXum2sSZR7Oz5BmWxE2VnxankJvf+hVdqN0OqZLhSIT79NVjMSMJDLSgmQVZCNL85yfovCj/Wg==
X-Received: by 2002:a05:600c:4d91:b0:3da:fb96:53d with SMTP id v17-20020a05600c4d9100b003dafb96053dmr10097926wmp.4.1674137121358;
        Thu, 19 Jan 2023 06:05:21 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id m10-20020a05600c4f4a00b003d96efd09b7sm5263883wmq.19.2023.01.19.06.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:20 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Date:   Thu, 19 Jan 2023 16:04:50 +0200
Message-Id: <20230119140453.3942340-10-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119140453.3942340-1-abel.vesa@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
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

The v3 of this patchset is:
https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/

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
 * added "minItems: 1" to interconnects, since sm8550 pcie uses just
 * one,
   same for interconnect-names


 .../devicetree/bindings/pci/qcom,pcie.yaml    | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a5859bb3dc28..58f926666332 100644
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
+            - const: noc_aggr_4 # Aggre NoC PCIe AXI clock
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

