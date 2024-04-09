Return-Path: <linux-pci+bounces-5967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98FA89E2F6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269DD280A20
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CFF157A57;
	Tue,  9 Apr 2024 19:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yekc9yEA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1415748E;
	Tue,  9 Apr 2024 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689725; cv=none; b=oxSsU1YiF5w/u4PjNWIIRtUsolZo7eGiVkbOZSjYGFoULECrN7XfzOa5ZABFV14CFux0anid7NEycWtbqO/nYU2dbYuOML8Jv+IELzZwyq++vLWn+wpIdekXwrO5XywGqLTY7pFcgoWIo2tB1AfVz30wvi7KaAx3N/MjMe11sNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689725; c=relaxed/simple;
	bh=qBEff6GBxK4EKDIooOGD6z891Ry9NSi5zZldTEdx4DQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxQanvBjrUcm/a5IkePAOTKnaq15JzfNlZYlFEZCF0VPFfg/t6OIOp6j7NsMv/bnruVhYhYR6Fln6MJSxkNKtWhZ4rF7SMOGbf2Qd2dsjyIFy5c7zy+cGeEKpiiXBC2YB0fpDC6274S9Wz+qSVdL/TZ9nr7HeD1Zx3PnKylUi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yekc9yEA; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea0fd9ca89so1729835a34.3;
        Tue, 09 Apr 2024 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712689723; x=1713294523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAUXrnDjVNNhAghGFpeuevgQOeC52MpGlmfKhcik4y8=;
        b=Yekc9yEAN+kBtYicbuyOXz6xWb0EKQfontp8ogKUTQG+x5L3aGLhF/mnJUZrsriOzz
         0rYIiBN36U4qFNggKhXs0Y8H7kXtx4ZeyxnIA1jmGkkBMypSg74qnyyqWjrUz1E1+bWm
         Y7vTY1SEjLhl1rfdRxEUXX99zCzwaWY+Mwwwcp0cR/QTvdnFGkP1/vXaKXYhyWgg+hcD
         cbbaKtFG+X4WZd4SoWU8ZsdatxSq/PdqtEEAqW5PjdXXnZe7NZdtd6+YVRiPyBFau98v
         xBNhaQm3XP2GD6CfMFwJyAnttXa41ZFNevMI9TSanEmfWTgtajjFdwerMNxeWxSzGKZw
         uDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689723; x=1713294523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAUXrnDjVNNhAghGFpeuevgQOeC52MpGlmfKhcik4y8=;
        b=fAe/ZioIjngEm4iIQkYlxjLH45HREyOfwRPD35HqRRps8U05Rc+Ey0eIMPnRXjLKQ8
         9YBbyjKP/AkvO25Hmb73z/ZLoRF1xkqa+0LZt6Fc1jJhPSlHBFinGvWghWp/o95v/OY6
         5vW8q3LijLlMGjMHiTp/zGGUwo9QxCod0+z1Qdka3vtNqlbg67DtiWVR82+iB7U7X43E
         H24JN4RkYw06K13MyFTo1J0o/SVJVPCqOuENekCcbqxzKaGTaEb+TkGYtCYwyR0xtw7m
         uUVkhc5Ulk+4zqeQWto1EiXbaOix/I0fd/ctga5meilnNs/JuJmIp7vIUuYISeoHE5dq
         3plg==
X-Forwarded-Encrypted: i=1; AJvYcCVgr9q2Cvu7TirNfBi3u/NMGQWEKfnupuAhm4QUMd6QK+AQvxVVcWcF3N2RY+V4Q8uPQYN8a4mTzZWbR7j6u+qjVmwDxeafdrWku0ZBkYuqjDWRov26UOoWKcIy+3/hT6ck4k7uU76CfM7R7CT4NC8g9q3fcqHbc7t309HGuC7zQt++r5xuD2ACtWrW2IPyRtsDnYfVhOYD1g07iS6v6uFdpjE=
X-Gm-Message-State: AOJu0Yx3BBT0QMHtmg3fxbIkJSCCdwMaJ596VVBKyQ+a4biysOgI8tCE
	wxVsfS1wfIjBrsqpdXbOMGWQnv1Qer5/HgIT72vsigiHkXtzSHJj
X-Google-Smtp-Source: AGHT+IEWoRotBhgk/BeM3JGvmJbd1EpaVpjJlGZOeL1cB+hdVgtvSIkdiMLKOpa2Odh8VxZIvZm9Tg==
X-Received: by 2002:a05:6830:439f:b0:6ea:133f:b0 with SMTP id s31-20020a056830439f00b006ea133f00b0mr892709otv.33.1712689723084;
        Tue, 09 Apr 2024 12:08:43 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id f11-20020a9d7b4b000000b006ea1cf91a8dsm674920oto.40.2024.04.09.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:08:42 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Date: Tue,  9 Apr 2024 14:08:29 -0500
Message-Id: <20240409190833.3485824-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
The only difference is that the "iface" clock is not required.
Document this difference along with the compatible string.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index cf9a6910b542..1915bea580d3 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq8074
           - qcom,pcie-ipq8074-gen3
+          - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
           - qcom,pcie-sdm845
@@ -397,6 +398,37 @@ allOf:
             - const: axi_m_sticky # AXI Master Sticky reset
             - const: axi_s_sticky # AXI Slave Sticky reset
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq9574
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: axi_m # AXI Master clock
+            - const: axi_s # AXI Slave clock
+            - const: axi_bridge # AXI bridge clock
+            - const: rchng
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: sleep # Sleep reset
+            - const: sticky # Core Sticky reset
+            - const: axi_m # AXI Master reset
+            - const: axi_s # AXI Slave reset
+            - const: ahb # AHB Reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+            - const: axi_s_sticky # AXI Slave Sticky reset
+
   - if:
       properties:
         compatible:
@@ -507,6 +539,7 @@ allOf:
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
+                - qcom,pcie-ipq9574
                 - qcom,pcie-qcs404
     then:
       required:
@@ -566,6 +599,7 @@ allOf:
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
               - qcom,pcie-qcs404
     then:
       properties:
-- 
2.40.1


