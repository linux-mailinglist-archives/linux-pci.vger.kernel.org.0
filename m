Return-Path: <linux-pci+bounces-6282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77B8A59BC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD0A1F23073
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882FB13BC1A;
	Mon, 15 Apr 2024 18:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsSyRz6M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9C13B7A4;
	Mon, 15 Apr 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205281; cv=none; b=cfbXVro7igVCoTsglgMStL7cWrnSVlO07z1Tgm7UeVPdZCMjeLzN1SI/c4qjyDxVD/EztD38b6SpW5KqNbQ89PCyGSJ2GCmVwFRskAcqFklHxkicRgwLjzM9pgAxm+VDC0cMs+65gFmNf2l8TZ0QLvaotr0C1SmyRTYV9JDK97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205281; c=relaxed/simple;
	bh=k1JJ3fdr8iAG3mv1vRQYhmJ/tsONyAZSjPN0oIsaeNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDdUZfzkjhzVHTGG47xi1uV8JeSwvu5dxm/BBrRl24J7wHSXNOMJ7c+0/FL/WcYZQGxf8J70QuyGa3hgwHs0qxjBW8SIGdHYpsZF4058heWAU4IMwP2OFArtRulLl83+S/+M9aJWo+otK8RuIODh5FPDt88BtMlxcEENe+xUTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsSyRz6M; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a9ec68784cso2100123eaf.2;
        Mon, 15 Apr 2024 11:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205279; x=1713810079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSUxhRAqtSpAkOo8bigYXpnuJtyRvKgYbnzdNf6wuKY=;
        b=UsSyRz6Mbj/nrM2NfjYTYQ7yzlJM0+fWsMHnnmPSx2QLu9j97YcVfEtqt2bj+3NIaM
         uihokkvnsZFdLBZTnDw1VQsZmgicx47s0x0BOJpjblZAxfjJKOT0aS+EhYqaI/0VUutU
         aCLn7VzRkQrltSGWb25rnzntSVV64z2jPNh2foZHnmOXIuJnt0j98ELjOnGWp0+LQKYz
         wOxWlKAderoHq3FVIe0+lNMH4KoVOwiiJCEu366iFsbt0UfLeLIqwW+kWbl7bQGmr4CW
         UBHFSX2jG3DWn8ZRKhvSLaNF1+TtIPtdx76LXPmZZAw7O7+wNklenclXJKH2/bnUfgfL
         vZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205279; x=1713810079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSUxhRAqtSpAkOo8bigYXpnuJtyRvKgYbnzdNf6wuKY=;
        b=mRh3jYTrMBgrT81r/Lf+3qRR5N4RxGEsbtRme/AtoDvBp4SBu/lv+ic+vhmvqE4vxw
         KmzAxplwuuHcKX6LVF2UyVb+XSQOAtYRRF/p/gMYmDWNvm26r9+c/dpcqZJW5OB/4kjF
         HFTFCIzBvi1hWvYmL050bJDMHJsG3VngQk7P1BrJF5N9u6PaY+KqTs9tzgwl58FeIS7F
         L5MydGZ/8wgTCFx9ys0Me+esJ3OKVJ40rydPpNiXT07ubNlg2t3xTFHgcqKFuoZF3cCO
         HltLKYGNRej/B7sNN9LhRzuo1JFRqmuFgqBAjP2e47dQun3v1pAjoTqpd0cW5vZFzbe5
         daMA==
X-Forwarded-Encrypted: i=1; AJvYcCX1dlvsIVBMvBXIeLkjgIX0sgx+2GkyduQtaKU2i3a4a3uSjXZr3Xk9LoxNoqS1y4hw2ksYehQOO+KP4TNhFx6mFDDGgKmCzhi8q1c6LDITDKtJP/TppsmWXjPNpMeNgZE7GyxX10e7QYLx2FwKT8u3K8FX53EG2yqe9CAQfyzyBqInawErVApqVeaM0Us+WyZnjGoMvLMonvq6pe/+egP8SQw8klF5fnn8FKFcIfU6YOJFb0mA0jyTSOKrmGw=
X-Gm-Message-State: AOJu0Yzdjy2ZwX5vrrmvizsLEyg1x1A2zV/9C9vOuIpdJKMWKjUc/WcM
	XZRoygInCEqUSkuGyTkLezBWVHHPeZQSyciTfu8H7IoeHMHWqxKi
X-Google-Smtp-Source: AGHT+IHWDOfDR262vpiTAuGOuGAJ+9982G4HI7/75giU8A9pOm9OGbS5vpH7wkRuMoZaxW+ulBWPpQ==
X-Received: by 2002:a4a:b045:0:b0:5ac:9fec:c32e with SMTP id g5-20020a4ab045000000b005ac9fecc32emr4272840oon.8.1713205279255;
        Mon, 15 Apr 2024 11:21:19 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2177494oot.11.2024.04.15.11.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:21:18 -0700 (PDT)
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
Subject: [PATCH v3 3/7] dt-bindings: PCI: qcom: Add IPQ9574 PCIe controller
Date: Mon, 15 Apr 2024 13:20:48 -0500
Message-Id: <20240415182052.374494-4-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415182052.374494-1-mr.nuke.me@gmail.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPQ9574 has PCIe controllers which are almost identical to IPQ6018.
The difference is that the "iface" clock is not required, and the
"sleep" reset is replaced by an "aux" reset. Document these
differences along with the compatible string.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 .../devicetree/bindings/pci/qcom,pcie.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index cf9a6910b542..2d9bbcc95c31 100644
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
@@ -397,6 +399,37 @@ allOf:
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
@@ -507,6 +540,7 @@ allOf:
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
+                - qcom,pcie-ipq9574
                 - qcom,pcie-qcs404
     then:
       required:
@@ -566,6 +600,7 @@ allOf:
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
+              - qcom,pcie-ipq9574
               - qcom,pcie-qcs404
     then:
       properties:
-- 
2.40.1


