Return-Path: <linux-pci+bounces-6926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B408B84E3
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF8C1C22C03
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7990447A62;
	Wed,  1 May 2024 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi+DDutj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B734596E;
	Wed,  1 May 2024 04:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537743; cv=none; b=WAtVUdOHkFptgbjhImVbBdLK6E4MExzlDzK1WcAWuBiGhl8hqCvWjK33vrfVwY5470nd8Aqg+CPAxFKZWaBt7qQ2oMWraM0kt77fxops1cmJJkYpUtRa1MQiy2izwauP7LvurQzCSb8yQ2n4g804EIbmzNMhbi1eQMCiCsCmcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537743; c=relaxed/simple;
	bh=hTXTBAcEL8gMHMEYQjxjqOhus0GQvyCJWh1hLepjz8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhqmuTOsyMhMPpEh6qM+oAjIJC/4qJXeS13LynFoqUp1PWe95xd4lKw8pLvQ0lmveeLp0Ai1EgawkB/Bb5djIZ/CImJMPlhDtgH3nT002py+gYmZoa53mEIzHvOgLM1yXb3idTqOYbXc64mBcKqvj7D2r87Fl7Ys8k0FSD6zzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi+DDutj; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ea156bee62so169653a34.0;
        Tue, 30 Apr 2024 21:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537741; x=1715142541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53QnHnVF7bqkRAf/NYE3eZQ50tFTHOIRODlZaYfoSVE=;
        b=Oi+DDutjeqc01jr1Dg7FF/52Jb0TZswoSyTj93eAhOlty6jGgo5aKC+XZ+FxW12+MF
         IPPiL6BcN6/NIJdv7Rdic/+UoVAewr5t4zAlekM+J64ohoyJB/x54frQuMbBJchccAJ9
         qvcXvRcYdINY3cXEt11nHSOVofUkhr9tg2Fk/GgjKJt7U5P8vxq87EnUZHV9BH4WqEnI
         B3oe+8vA/XbmmwaP9Xnv6lG7RQx6rZpGHLsGasShfX9pS+u4W4DGBaI8FIOR6tZbUTlk
         p/OUJlugyswuqkUSYkQfxdmTlljvZbFkCPI1oxbl4Zbi8yT2Bxqxtnc20PEOth+qsK8c
         IX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537741; x=1715142541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53QnHnVF7bqkRAf/NYE3eZQ50tFTHOIRODlZaYfoSVE=;
        b=pPai6TrY34jqo7RwwfDdb5rWouFHjiwmWipj2k3Xu5nbWUwqCCfG3sXyLzukhtYiEq
         GK5xr2Wx/S7KUGuv6MmVPD568TptSXc4evipKJALfsJy5b/uSiuWF8573N1+AWzKEVM0
         VDxiDYbmNxYo4FynPpnwy54dIDUbTuSC0chZJxeejyD851+gCShSxg7lFbS9y0pQ+cfn
         j1PGnbutrn02pFpELhsrro3Jx2jCxHhsigsNqOOBAZaG3T9PufZD/ZWqd8ZUOeKPRRZK
         xhxNBJs59XbJnHBrrfIRl8oJKh70TQLcIxjItQMnQgvl11nikKMPpsIx6NDYm8CAPdDJ
         Kwew==
X-Forwarded-Encrypted: i=1; AJvYcCVa3oyBppHwDIqUs2r9npkrWPtNb/MESlGP2eFpT7IomW4EudmnwCYRlXXn/uOmIpNWs0Q8eROtHDHZODyQGPAIbXk0Y36G1pNXOQVA+t0o3iayag174d2kwtEnq9+XrIFXkHCkxToKExezEPEI6/Todp6I5Ha/LKd5BfGiWXXtY81cK8H9UbyPH/sdZUs+B4xZWSxzCT/XKG+E8N8hk4EdI/DdJo88tvyq84+8pY0fTmheVuVRjb4WVKonO7Q=
X-Gm-Message-State: AOJu0YzF73YbFY1UakOj3Nxj5qSk2S5CWJDDhuaDWU9636LTnq6xB0Hw
	CwIhCT2XU8f37KIAOPAdHMAdXA7Ye1gzjvOVen0HBtYeiNHkRZWn
X-Google-Smtp-Source: AGHT+IGZ6Bq0eAhG/carm/csp8ApgnvJNQUPq/GxvHn40hwIEdBr56IsFv4ZyhDbwV1GMjYFEXYYaQ==
X-Received: by 2002:a9d:6e12:0:b0:6ee:1654:c391 with SMTP id e18-20020a9d6e12000000b006ee1654c391mr2064810otr.7.1714537741133;
        Tue, 30 Apr 2024 21:29:01 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:29:00 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v4 RESEND 3/8] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Date: Tue, 30 Apr 2024 23:28:42 -0500
Message-Id: <20240501042847.1545145-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
The difference is that the "iface" clock is replaced by the "snoc",
and "anoc". The "sleep" reset is replaced by an "aux" reset.
Document these differences along with the compatible string.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index cf9a6910b542..ac6d2b1b8702 100644
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
@@ -161,6 +162,7 @@ allOf:
             enum:
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
     then:
       properties:
         reg:
@@ -397,6 +399,39 @@ allOf:
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
+            - const: anoc
+            - const: snoc
+            - const: rchng
+        resets:
+          minItems: 8
+          maxItems: 8
+        reset-names:
+          items:
+            - const: pipe # PIPE reset
+            - const: aux # AUX reset
+            - const: sticky # Core Sticky reset
+            - const: axi_m # AXI Master reset
+            - const: axi_s # AXI Slave reset
+            - const: axi_s_sticky # AXI Slave Sticky reset
+            - const: axi_m_sticky # AXI Master Sticky reset
+            - const: ahb # AHB Reset
+
   - if:
       properties:
         compatible:
@@ -507,6 +542,7 @@ allOf:
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
+                - qcom,pcie-ipq9574
                 - qcom,pcie-qcs404
     then:
       required:
@@ -566,6 +602,7 @@ allOf:
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
               - qcom,pcie-qcs404
     then:
       properties:
-- 
2.40.1


