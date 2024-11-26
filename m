Return-Path: <linux-pci+bounces-17333-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA90E9D9569
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2D166E3B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 10:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686E1CDFA9;
	Tue, 26 Nov 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l15ybey3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1F21C4A13
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616581; cv=none; b=IwaouckGwDJVY87tKKz7obQvVNQ/qB+aJtL8w/lyZego65HAysBBldoqthN98hvFoqktTelSJSnnNyt2k/K++CKSM4pcwm6L3C1ybs/6XSxeEwWwD3bpVQlmsdZdoWbvMRCjVRo0jGx8+GDpMRe2ATdww3RVm9WZ8UfPyZxqQck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616581; c=relaxed/simple;
	bh=3y33KwWV3X6ptS7V9W6/9HJibX4ha/yfLJjiTJa0VgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlY9rMYgJrnOa7PpvS/rxpFLb5ocEGNwIwIlLOZUt3Rbyym/J83g3DIy4tnTcPZ3aS/eDORpJoXEFajxWQM2NljDNBJ9iB/K+Y7iAOtob+yLT0iHnJ7ExAJTB9oYh6iPh/DAbGjF2FO+zjHdZ9/Aob2b79ValHhoc8hZ2xC6Bms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l15ybey3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4349e1467fbso18220405e9.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 02:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732616576; x=1733221376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8o3l6m5vwxoJdK2INVmuuDNErcbA+zded2JvEzJ8vLA=;
        b=l15ybey3Wds6Mdw9+HRTeyivx1Gxq9fLWS9k5R4bn733MTPr38c2DIScteg6gtbio6
         b/PmtddDWaFHCRt1V0O4U8MRyFJTSMFjvZqTV24tojB6NxapBOwrEYovzGMvOpIrlljv
         16ziclFEfwn9i+pqTxFbnC5qIbsnEvWebih7F/TTGnwdY4I2zGzuwSVygf81JWeB+faG
         eyW0HcQ2oHaKybjMvc9am2cRKOBJWohO1N/bAobu8VeF+0ilGOiXmIt4HwRFAUbuaDr0
         C8tyvOpTOwTtbzI6WcaIZseoP4c8qXNX40oZaja0YmjEk3/GKS1s2NeW8E35cx9WAtcK
         1DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616576; x=1733221376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o3l6m5vwxoJdK2INVmuuDNErcbA+zded2JvEzJ8vLA=;
        b=ijasuh6dH+cwcToJLCziATpvhD+8w4sSRbAqCXiz16czi0fOlN2Yl0eSaAVr1zkZ2D
         CjT+z61IUO0nvAZiTxwQ5Ut0HqhRujX/QfhrLHU4qHng7cdaATNxy2KFwM/VbqV1CmiY
         hJFW0bv2WyzJ0O5aPyuPX4wBtWLBRRNWL135l0NsDZy9gl5HnsOh2xYxyxBCcN7VDsuV
         c5Jqz8J4D9fg2HMbc3oggEmxSyTaOO2ljUWj4/SrT2lxbvYMacK24bzedCwZs1jsb1HB
         9opWVmwdE3aAyMuCXC0WCHphRUgcAdV6wH6CmNiUgBwDMhHP8fTyKIoFnXBNHlA4dmK9
         Snpw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzRD4zsSXckWq2ryp7XQl8kMY0SjYOX2yOYcSCO+Wt+kPf9X+216DkCRrjglGtDf/CnqTZW+7dbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLvIfWxBMKGqrR25Zowk0haxkeTePfZ4QsCm3Af9RDYlNI/yh
	e4C+4x4TW0qNrDihzkDwrUERvwIJgrhIS8ZZ/iVse7nz6b1qiTWFl/unN8GYSh4=
X-Gm-Gg: ASbGncubbTUhmKwywxCFG2t5WzvAr7ThwsXGUvmqN+by6p1BhRmySz50R9SJe2OTPlZ
	12H6CXDiV7BtRErcsd5Lqe8R+RkNSs+ZYCt8ti0PhD7GAjM97rIgablJw+qejRuUfPp2F5I9ni7
	EIN5UK3p2Jt3QUyZkTKyMDCZZOlO/CAlFvUAAYgZYNcN87pX+xdw7WsHX94gy4NA8YiRsonmb13
	RAHDNvb7QTCAubCG5iQEmQN8q4F/ovPQoyjCEhMySE0PjZqL9lsg6ms6HIgbP5mNw5vJtw=
X-Google-Smtp-Source: AGHT+IFD1SUZK/wzIE5wrG+sA6a7sit0Bs1O5qLASWCEnOzhJbRnej/agfqThpwvYDHI00Fmt8odsA==
X-Received: by 2002:a05:600c:34cd:b0:434:9cf0:d23d with SMTP id 5b1f17b1804b1-4349cf0d3c9mr68830285e9.25.1732616576639;
        Tue, 26 Nov 2024 02:22:56 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1046sm228378075e9.4.2024.11.26.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:22:56 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 26 Nov 2024 11:22:49 +0100
Subject: [PATCH 1/3] dt-bindings: PCI: qcom,pcie-sm8550: document 'global'
 interrupt
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-topic-sm8x50-pcie-global-irq-v1-1-4049cfccd073@linaro.org>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2273;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=3y33KwWV3X6ptS7V9W6/9HJibX4ha/yfLJjiTJa0VgA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRaF9wevUPdMUYIutNZvInUfAq/oBR5ApvS691s2M
 lhUxmR2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0WhfQAKCRB33NvayMhJ0cclEA
 C1iAj0zWzZ9YFUQdMHFxz1FrUJQLrlgSJw27jNJt3k8mgVXcJUZbRbdqqwtiIa1D5aZcldv2+v2KVB
 A1yG6l2UsGgLV2ciLU/cVdV1O2B30t9qvsNQ8Qtj7piyKchR+ekb1PJrDDmWXrPGoPd2/ek8JfLMAr
 HixKHM3zOQ0TRiimKFnfhEzZvf6kjd7CIB3zbJv3IniINoDP8xeuWSqm6ct2mB4LDkuU8QBvdiIYpW
 6AUnrZZYidpu9d/2XPHIiu12S5XLJRUuDUv+POeDEFhhw2rv7LD1yolHog6qq6b2a967zUvupRLyDc
 7iv51wUH5MuS9HvwvLhRz8o76ZwdFXAWDuqgbmMZ2s8H4K+y9h7b/KnJOD6jfDyRm7mYlNOTtCqdef
 Gb+NvobOoIVOpDgTiTSeBTybAytZPRnEntaMRpLtJC93ufg5CuAeTrhqOzle8+us3nfrr2dNurSWbg
 PrRRF6J/Y2+hv7U5BIO1UyKzkCeMCs0SItNbzzc84UbaVZLkzje+STMKlVz9LNmtJ9KuWiBjKf9t57
 6TDSOJav9SnhElCnN84XBG4VS3fkvHcmUUOwGwUgYrM+F4j1k5Ujig1TjZl+aJYEDH72AHnGPrp29u
 wngL4wOoKH748Y9301DM3/SySc3+VOU/umwG61CnYU+BGggB9Q7vVpAz9Z8w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPU. This interrupt can be used by the device driver to handle
PCIe link specific events such as Link up and Link down, which give the
driver a chance to start bus enumeration on its own when link is up and
initiate link training if link goes to a bad state. The PCIe driver can
still work without this interrupt but it will provide a nice user
experience when device gets plugged and removed.

Document the interrupt as optional for SM8550 and SM8650 platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
index 24cb38673581d7391f877d3af5fadd6096c8d5be..19a614c74fa2aae94556ae3dfc24dcfcd520af11 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -55,9 +55,10 @@ properties:
 
   interrupts:
     minItems: 8
-    maxItems: 8
+    maxItems: 9
 
   interrupt-names:
+    minItems: 8
     items:
       - const: msi0
       - const: msi1
@@ -67,6 +68,7 @@ properties:
       - const: msi5
       - const: msi6
       - const: msi7
+      - const: global
 
   resets:
     minItems: 1
@@ -137,9 +139,10 @@ examples:
                          <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
             interrupt-names = "msi0", "msi1", "msi2", "msi3",
-                              "msi4", "msi5", "msi6", "msi7";
+                              "msi4", "msi5", "msi6", "msi7", "global";
             #interrupt-cells = <1>;
             interrupt-map-mask = <0 0 0 0x7>;
             interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */

-- 
2.34.1


