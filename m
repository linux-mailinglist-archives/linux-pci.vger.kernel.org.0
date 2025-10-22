Return-Path: <linux-pci+bounces-39050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F13BFDA80
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 19:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A8C95344B62
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 17:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55DA2D94AB;
	Wed, 22 Oct 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXuaHZu4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E9A2D7DF6
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154996; cv=none; b=WXFeyNoyijLzUrCvYpaEXfjja4yCCXo0i5SlwE9TCea+Yf/oRJvC7Hxa8mZaG1EZ4SJ2MY8FFbXAmbstjqnRAG0KRPGGxVaIMOf9z5JlWzxcYysh3Ww5mMqPhzXnvmrdiV5qYE94xIb3N65OflPzHOgkvKgueaUnCw825H+RVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154996; c=relaxed/simple;
	bh=/WvSXC7W4Q8hEck5OteLiosiwPd50zkgon/bnQ1zTTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxGQ2mqPCVIWYSNts2MUA8KT3PxX5Qu44GhoOx2q9NhoMkgZ1vIi7Xtuc5/Qxv+F82BypLjXcUtXFIn0wcu4AA2uw7qMR8w81d+k4RXYVQomefFkNt5sU1cadazph2746ouNo0zT6H35K4a+n4mQ0+iMMnz4FaCqoUGR7zxBefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXuaHZu4; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47112a73785so54981475e9.3
        for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761154992; x=1761759792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/K6pNfM50RfxSgZt1gAI6BQibb85E1lqSjk2vGJD9Y=;
        b=yXuaHZu4Qp59MjLK5Bo4dTmY0edoUTYcX6LEBGg+HQ0tSomdA//dUllVedoyz2J2ov
         ucRLhl0fv5oPwn4BPED1hqZOB1ynbdswKN4bGmJEM+qVNQ5edlfe1L2nNF70NJk5jlyG
         A7wOApcM6fLDp+BZODTD2zYASxJoG5hnpPFHIjFkkQEV5vxZYgWM1aEnONNn/UKX+Cey
         8/CXZReNyS/GtLt1PQJapg1H27HKvfYWlmm1iSGSWpCVrOCAJjdA/Haned6l58svEO94
         8+2vv6d6cVdfWfnISSo9T347jjsLcVGE4Z3QBJExv3zLw3BijeQGzSNJ6AAg1VMxKNwM
         LFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154992; x=1761759792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/K6pNfM50RfxSgZt1gAI6BQibb85E1lqSjk2vGJD9Y=;
        b=ZhhWakIN0BktTsv4sKMprvsgdbfOm9UAvMJwbviqmYWEw9pBZvjr38kiTmzLI9Y68x
         lzTfXAT7EBQR7YdL6M/o8MUyLdZCJ4aEM6Rxi0Zlyi3t5Bcgu0cTtRt7hWiAWL9cK/kw
         2Fe42P2T0WEFdlEzaPFet/BrMu8x2EP4h4XcI+US2rySclRIk2whZKFJSo2HEPpt4M4h
         0vUScSBfPwE+ruUW/PzXvyjYJuWf9LTfxqNVRdZAii8X9xjO6Woijd/YnQFmsN+AMPcP
         dMxMO0AY4DWEvkHMGyAT8mVnf8aAwE5pYnrdHYQs4InAdonUv28xJgU5o4JKJgFgR1rW
         J8vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv7mCLMcfgijj9TFZpu1AjXTTL1EQWvbJs5tcibpNGzHRAGGZ9G+FZGiE89KZoEhpAje5GwSiVX8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOmP+4YYI+hag9VjluM4opcn2aMWcdukIUtDAZ/ePaOp80Npvj
	a3pMcV5e3GY6QMxo1q0fG+yLOH5RgyjWAbXt6/7tJMLKNdnlJ2eFYUyYYTOXch+OnEw=
X-Gm-Gg: ASbGnctzuJmSglsnpQw9VX0aBF0IdhHMntPYSaXmf3sKfOTyMO4Zee/1A9DJUL5eDV8
	eprwiNOpHFRy59IUWOwp4/7xYffXxBmN6twuSmMtXEIiYaojMsBFHy4RX5b5HK7fbPG4JNipENe
	M1TOcaV/6xA8C+YJJIDZ9vsQjtTo5T5B6pt/O4F06qqi2Yl8pu2Vo0CmJxxymyary0gd5aFnocT
	r3WVxT7ZDJWaApFWqw6bA/iLtX3Vhu9iJeY5qL3FEIbNNHoGdFIDU0cw+qbIM+fx6L7qQ6/hU1m
	3Je+EAj7Bcr5ad0HhL8grbOJ90LKZb28fBgvzBMTJ2SLTuOVdEyV5K8pCicgrfwy4YAlVwZYDFL
	bnELQNnDQDERS8cxLtkFroG6m2fpUx3wiBtFW8XwzOslAzfrokEwlGLhxFlR70hKqGiu3V6rjSM
	rG6i7F8VXQsefjV/FDlAs=
X-Google-Smtp-Source: AGHT+IGaffzb8yHlNU55p9rF8t2TGW4QRT5HNlWnXs4LSZW3Gb59mNXLLVvwX2nvyEKIz0B5fJhCCw==
X-Received: by 2002:a05:600c:c091:b0:46f:b42e:edcf with SMTP id 5b1f17b1804b1-47117925d66mr115832685e9.40.1761154992519;
        Wed, 22 Oct 2025 10:43:12 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:edfc:89e3:4805:d8de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494aad668sm43434755e9.2.2025.10.22.10.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:43:11 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
Date: Wed, 22 Oct 2025 19:43:06 +0200
Message-ID: <20251022174309.1180931-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022174309.1180931-1-vincent.guittot@linaro.org>
References: <20251022174309.1180931-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the PCIe host controller available on the S32G platforms.

Co-developed-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
Co-developed-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Co-developed-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
Co-developed-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Co-developed-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
Signed-off-by: Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 .../bindings/pci/nxp,s32g-pcie.yaml           | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
new file mode 100644
index 000000000000..2d8f7ad67651
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nxp,s32g-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP S32G2xxx/S32G3xxx PCIe Root Complex controller
+
+maintainers:
+  - Bogdan Hamciuc <bogdan.hamciuc@nxp.com>
+  - Ionut Vicovan <ionut.vicovan@nxp.com>
+
+description:
+  This PCIe controller is based on the Synopsys DesignWare PCIe IP.
+  The S32G SoC family has two PCIe controllers, which can be configured as
+  either Root Complex or Endpoint.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,s32g2-pcie
+      - items:
+          - const: nxp,s32g3-pcie
+          - const: nxp,s32g2-pcie
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
+      - const: dma
+      - const: ctrl
+      - const: config
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: dma
+      - const: msi
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - ranges
+  - phys
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@40400000 {
+            compatible = "nxp,s32g3-pcie",
+                         "nxp,s32g2-pcie";
+            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
+                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
+                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
+                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
+                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
+                  <0x5f 0xffffe000 0x0 0x00002000>;  /* config space */
+            reg-names = "dbi", "dbi2", "atu", "dma", "ctrl", "config";
+            dma-coherent;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges =
+                     <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
+                     <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x80000000>,
+                     <0x82000000 0x1 0x00000000 0x59 0x00000000 0x6 0xfffe0000>;
+
+            bus-range = <0x0 0xff>;
+            interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "dma", "msi";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+
+            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
+        };
+    };
-- 
2.43.0


