Return-Path: <linux-pci+bounces-6920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BA8B84B5
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85E81F26268
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D18502A2;
	Wed,  1 May 2024 04:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwGSnOoO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61D50277;
	Wed,  1 May 2024 04:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714536505; cv=none; b=XamzCPhuKxvnjxdHafp0QUf3Ryobf8RoAbUC2lCR3rsWpuuq/qaviUKPTr1x3DcV07B/7s8vtEgBWSk008dRV+5zdnnMqHPWM6Rq5MO4DFIYwrNi4YKatoEujsDrINCiL4ky+g8MAmHlQW09GvoNZuPyMUJzcZmVSQ9tW0p45mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714536505; c=relaxed/simple;
	bh=hTXTBAcEL8gMHMEYQjxjqOhus0GQvyCJWh1hLepjz8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rViRiQgnDmvvSNKg8ffATZKYbeu10IIAw0m6lMR/QtV+wMX67HeBokP53n5MssAuzMciOrDrVhEsxzosuH1pPBdJC9PELlmaWBXbqZcrlX9gS8VTn8pgm6N49HYwlLLxsVj/x5RVEHdMd5AyMN2QkFIOWsduST9rAKipye9EtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwGSnOoO; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c74b643aebso3805097b6e.0;
        Tue, 30 Apr 2024 21:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714536503; x=1715141303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53QnHnVF7bqkRAf/NYE3eZQ50tFTHOIRODlZaYfoSVE=;
        b=DwGSnOoOk3VVfAp7AbHIA84JtWRDl9AlYrnRXcN1JH6ToKJoTkvbrhpGP2SnPkOuai
         dUw9ZcOpYCCkXJr3HbzY56rHba3pTFG4tb5v3oSwmt3ks1OXYG/+cSmXliUVKHufeAq2
         EKUsIh4o53ylUtDCC0jBZFi76FRDsWGYEFxIn6UaZMla0hx+uDrdswuP6YbAIkWaBPgs
         u6eJVOEC5xeXqB6H7EZ43JB53jC2E21pX2qf3UNYwZrKcoYphI+5IY9vI0+NbhzS0o+l
         GJDM6qyJTusyK3Oogmx7bhnCOQon/jPH+jbqyKG7d+urZsqNI4F21izAD2gXl6o9q2IG
         1eYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714536503; x=1715141303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53QnHnVF7bqkRAf/NYE3eZQ50tFTHOIRODlZaYfoSVE=;
        b=dFoEauB2Ky9su2DeGi0aS0ttu8wPem0WXe8x5MqavW1OmHDYVXmrZzMmbFf9Uhq1wR
         IJEjiXgT37k5uF6x0mR3AK9Iw6PbCZU1YcWXn4wzfZdfMKJDko4xVhumWCnHnsS+Y7Oq
         Vl3MEPhRDFyTU2oghLyf0EHhM/0M/vYWvModONWs2mSjbtnquWz7DLSWMnZpfdJjx/Hz
         dEu0Oi1iszVyJ/lokusbghuIUQtQefqNEmndXMaxwVXZk4DK9AsweZTWY3TSTq4faopZ
         JU4AheW5zKae23SHC8Eul/F4LmyQHc/BIi4u0nTwVkj0XpD4XCcaXxnMkv2va/T9vKOZ
         BOZA==
X-Forwarded-Encrypted: i=1; AJvYcCViH6jAhwyGuiw4JqzcXZD2fNeLd9OU7mE08jWNPgOd+T8+TA4+giS1F4nwxm5kj5Fm/qhzDWaIbjfyXXkGtGTRUlNQrZ2V7xe/fiEe8fH7iJ81xkcmorRHaMZhHy4Ppcmj7gf5aWkBVB7UYWhZBgPxRF9kUKfjRjestKOWVJwUt9NmaqQ=
X-Gm-Message-State: AOJu0YzPTOtLUPzJjh9KMNk/aPvpcyaTgPc+1Yfs5cbT1LwqZidG0vIE
	bAu9UV+HgoMgcyOKCkar7t6/rhUFYim9Rg7XhyY1TZ/QmZDNoSWs
X-Google-Smtp-Source: AGHT+IHQCeqDtAWwHxJq0EYDpCrAbEJnNRyv4lCYJPcXsODkyuZoZMaQ5pZHQOZD5UnnPJ3dl/zZmg==
X-Received: by 2002:aca:1009:0:b0:3c7:999:f5d9 with SMTP id 9-20020aca1009000000b003c70999f5d9mr1791399oiq.15.1714536502642;
        Tue, 30 Apr 2024 21:08:22 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808018200b003c8643f0e5csm1067872oic.16.2024.04.30.21.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:08:22 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	quic_kathirav@quicinc.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 3/8] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Date: Tue, 30 Apr 2024 23:07:54 -0500
Message-Id: <20240501040800.1542805-13-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
References: <20240501040800.1542805-1-mr.nuke.me@gmail.com>
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


