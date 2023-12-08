Return-Path: <linux-pci+bounces-678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8123D80A180
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 11:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38045281970
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4CD12B70;
	Fri,  8 Dec 2023 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWpUv5Fz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DD61733
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 02:52:05 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f47f91fc0so178299266b.0
        for <linux-pci@vger.kernel.org>; Fri, 08 Dec 2023 02:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702032724; x=1702637524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAfB7XP9qswfZDmppuZfzA/p4yR5CeCNI9dzwHD6WP4=;
        b=EWpUv5Fzt18xugwIn2mWF5ktL1004rnxGtKahBcRghb/hJvFh5kOlr9ecEIzN32/A6
         WVDxeOkDAWBHFRGb8AXp1Vvvs4tGfr02G+zZnEbSrlV/DJB3ubM5mUzw/UwSwI5Qebau
         VW0Q2kEnU7dqt/KL6vN8WwlN9mluY0pVw+xvqIy+HpxNhanp7M3JceRMtxwrU1lXfNq2
         egaNVk68E0ZqihF93hxLSZlTtepmnZoTuiH8SrCIBL2owkIo59TxpBokOw9B74MK3IGG
         0qq8xO/2j9bHkV3kS74NRXNBpe/Dck/AuO2D/9EL3AAFCbrEagGpU2lssxP8KfSd6mKn
         XwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032724; x=1702637524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAfB7XP9qswfZDmppuZfzA/p4yR5CeCNI9dzwHD6WP4=;
        b=HjKnjK/cMZSOwE9+fqT5CME0/uHSWahttjk47EHFLO4PoiXBDikpJSzqD7FU67JdJs
         qQt8aVeo4JmyzS/By9RcCGECZdF/reTBWZy7Q9M72vVs2OyCarCm3y8P8xE2A3M8E3I0
         4drLX1dmpLkne2K+jwlk0i4QhankDadVUbpaLkpAGjO75Xp5vNy2ZjmKKrdFjJoYc7iR
         mi3ScHiPUQiOiOjTlWMUMnbYpjE+gJR4q/1r8YtYBdvedQTuUIqZuziYxLBHgtWkLnHo
         U90SNCI3JOw77c9y+ZCjnVS2e/niKV6q5zG/heSVB+yPDqYnDu9QX+vcTOQRlGiMj7o4
         0hvA==
X-Gm-Message-State: AOJu0Yy0UvxrVJTNsb/8EelwwXEOs+zSGUh+f82SB/YGb0PAeA0k8RN8
	Dmj9xwuWWjUqtQVOUudTfybmmw==
X-Google-Smtp-Source: AGHT+IHQWFvI3cUlx05L62in4j7p7qC1FH/YrW2thF2CuQ0R9iAKMY25cPEvsPV2B+Moh/dQko+f6Q==
X-Received: by 2002:a17:906:f88f:b0:a19:a19b:55e7 with SMTP id lg15-20020a170906f88f00b00a19a19b55e7mr2336374ejb.119.1702032723901;
        Fri, 08 Dec 2023 02:52:03 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx17-20020a1709078e9100b00a1b75e0e061sm849976ejc.130.2023.12.08.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 02:52:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/4] dt-bindings: PCI: qcom: correct clocks for SC8180x
Date: Fri,  8 Dec 2023 11:51:53 +0100
Message-Id: <20231208105155.36097-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
References: <20231208105155.36097-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI node in Qualcomm SC8180x DTS has 8 clocks:

  sc8180x-primus.dtb: pci@1c00000: 'oneOf' conditional failed, one must be fixed:
    ['pipe', 'aux', 'cfg', 'bus_master', 'bus_slave', 'slave_q2a', 'ref', 'tbu'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Please take the patch via PCI tree.

Changes in v3:
1. Split from sm8150 change. Due to split/changes around sm8150, drop
   Mani's Rb tag.
2. Drop unneeded oneOf for clocks.

Changes in v2:
1. Add Acs/Rb.
2. Correct error message for sm8150.
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 5056da499f04..5214bf7a9045 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -483,6 +483,33 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8180x
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ref # REFERENCE clock
+            - const: tbu # PCIe TBU clock
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: pci # PCIe core reset
+
   - if:
       properties:
         compatible:
@@ -531,7 +558,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sc8180x
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
     then:
-- 
2.34.1


