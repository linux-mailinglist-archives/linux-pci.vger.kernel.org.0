Return-Path: <linux-pci+bounces-5572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03734895C7A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 21:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A280D282472
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556F15CD79;
	Tue,  2 Apr 2024 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/NwwL2e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0D15B987;
	Tue,  2 Apr 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712085967; cv=none; b=U6OSJAOE1pcitCb92zVTovLL4h0/jC42nmWOWhBUPS22eh810SvIb3wLV2Wbgx4G5e3yUaSFcCxBH9xMzcqYvGNGFnbxKA1uKWO9pzwuYst2d949Sj9y2e1H9uVclDimnxYkS9htC0ySlPNKAlAImf8MBxQw1TEG/dBkF1XpzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712085967; c=relaxed/simple;
	bh=GmSN0myd4xbipdydgTiAn4GDoy3OMepStdn8UQkbyAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpQQi3XCFngMtj7F5OPA1z/7JAVOhX+59WrhWg8l8vnuHrH5s/+79TRcCO3TbrW+RNzarYF2UDtgfruzlHc/0X8jk1bZhOILGpDnaTrAECl4+BoQjXgqZAzU5IG2GHXPTxckFb+YXrroOXYHgXpkf9nAG3gHq5xWvUv6mLTXTs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/NwwL2e; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22e8676c670so240104fac.1;
        Tue, 02 Apr 2024 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712085962; x=1712690762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhP+v60iBJxMjaZsBicLjvrTnnhoRviR8rTJgE76tf0=;
        b=Z/NwwL2e/mg+48wbMkI0RgKp7rnGaA6quYTZCt99SU+lhap3VtVY+sgog+FhoVdNRr
         Shhbar4BUnMQ/nOvIPE/M95P6g5uHSauUZ+AOF/R/2Jm6RcNkwvmooTOFvyi57ZGcheW
         tJfKCCkv3W9uljMPvlk4lFzNWEwOP0Y0FZMHEz9tf/F4zU3V3QKybxYBj6+H6NGOZCja
         r3kYNM7J74MPaEnmZ2P+oGSBrQqwLwOteLNiyCEhR+v8GFt45WYOcKb5j/VuX8iiYZhQ
         Q6azRNRHl2+/v8oV/mXQYfuGm6Bgmib5zLxMKmog4kQL/NNvqd/4tQQmrqRMwvUOIh5b
         MyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712085962; x=1712690762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhP+v60iBJxMjaZsBicLjvrTnnhoRviR8rTJgE76tf0=;
        b=xVNL7D/omDET0+ADMKI2Ln5h+TwwZ1omzODspaHTwvBqas6oGEWNisDcB6DkuppI0j
         rxbrrpRojd5O+xNER5KeJaHmYpk8v6z/szWYbbM8o51bQQ0qxTQGmF0TDs/fPT/N/3ro
         m9Rbl3E933w00Ii+ClS0D/n55CFVoXDe470u3jp6x+sGtai7WpjqVCrELAiFh3uSof9x
         qM+W1LRcBo1LZ+QIQbWPHHZr+/uPvJGhdOFRdC3uUAPKwpcph3aZBlgjcVqqdVqEw6HV
         LFnUInquXqZ4ch0IQO3vlbY94w6svvcRU0Rz/r+oqMeyLs/XXJQ8ASahpXXBMQTab4VO
         u5lA==
X-Forwarded-Encrypted: i=1; AJvYcCUtMGKugo5iviFuzbTKfizHFqwbiLKjWLRcKLBd7SGSDg3BzAHImVZfBdFI9xPTnIbvkAlrTKbd3bxwBGWU3WuE+VwG33uiNzC8l29hYQ7u8cxgQS+YiCHSZGZz0JfZxa+f5B/fS/l3pKesI9e923VxZZGPFf4afB46hTH/Ni9zejyk4BJ6T6EzyRjdvXB83U0QnATMQvs03fHAGOuIEeiBb4M=
X-Gm-Message-State: AOJu0YzvxeyQAJjKVXVKcrUremWsld5NbOtiozdorC/ExC811rPiwQQf
	+v+iikTaVocH8oAMLCqLpMLDmeHSc1N4qYKi086Ep6ziDs/Sgr/d
X-Google-Smtp-Source: AGHT+IHW9Et9K2oXjGb440sE7RzwCVYx05x8qvURyKd8DxZ2LaYz61fAik2owFUjpokxq5K33U6IEw==
X-Received: by 2002:a05:6870:b6a6:b0:22a:7b20:410d with SMTP id cy38-20020a056870b6a600b0022a7b20410dmr14833598oab.33.1712085962264;
        Tue, 02 Apr 2024 12:26:02 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id ld22-20020a0568702b1600b0022e8f9fa89bsm75622oab.57.2024.04.02.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:26:01 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: ansuelsmth@gmail.com,
	robimarko@gmail.com,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Date: Tue,  2 Apr 2024 14:25:51 -0500
Message-Id: <20240402192555.1955204-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
References: <20240402192555.1955204-1-mr.nuke.me@gmail.com>
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
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index cf9a6910b542..6eb29547c18e 100644
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
@@ -383,6 +384,35 @@ allOf:
             - const: axi_s # AXI Slave clock
             - const: axi_bridge # AXI bridge clock
             - const: rchng
+
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
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-ipq6018
+              - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
+    then:
+      properties:
         resets:
           minItems: 8
           maxItems: 8
@@ -507,6 +537,7 @@ allOf:
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
+                - qcom,pcie-ipq9574
                 - qcom,pcie-qcs404
     then:
       required:
@@ -566,6 +597,7 @@ allOf:
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
               - qcom,pcie-qcs404
     then:
       properties:
-- 
2.40.1


