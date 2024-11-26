Return-Path: <linux-pci+bounces-17334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E09D9572
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5541D167676
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79961CD1FD;
	Tue, 26 Nov 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkhxSiNM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E51CD210
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732616583; cv=none; b=sNA53rdL0wtBCuolE6cUP5S9Eo3MFTvOfU6/CMk/pt46krfNNMnXPNpsUREa5NIM4KdzT52AmZ/vgIV/dtq2ESdyI3hrpZeY9rAE+k7Ugo/bqBKl8zrD/6CmmegfG+36LawmlWnoZ++M2k8hFpb7N7pyEj5ivcDIDTpaqW6rtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732616583; c=relaxed/simple;
	bh=WD2Ififyc67QT7itZr9mWxPZ1InWr4O/7CEhRE0kxnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XOwMhodpC3/7A39BnHD6bOVNRj0cAhHfCA08cnWVqXxAZ0SQzO2yxpWVygxqkSxIcaU4xQnbCKb7MrJa0c0rbzEcUmtFJXVuEGhpgDbnq1MnldgP8ojDMq5MrUeHc7vG8arYN0MZspMwTHGvqyb3C7p5AGSbmXrfGgobwmYMlcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkhxSiNM; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53de880c77eso942630e87.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 02:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732616578; x=1733221378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U6DI9UiS7mCrw7uF6OaC1EisPMexi0/iLw96bOdlu0=;
        b=PkhxSiNMgp/MVtG/H+dKZMfu8VKIgEEuHFh4Z8tcu3/jO36KLLLg0/VNTq4ua0gvce
         Sb3iOHQ9thuf+xVsDGRxmc9+kgo+e7Hq6vgS+rCQxHwX3qnza7d2/TYjl/AgLX2VgYCY
         LGtCz1kI434/SEU5BzN0hu0F/AvQPUoBmMPcRL4haQMQhrDkmj592Z3UxHBXsDs2G/na
         7QtCWneDn8gAE4K4P/LldmTmBJx7YMBogSbqWxWObByb6wJuiTvBEM43Hx+nDvrQTvPO
         JTCRf+r11n/93EgERgjH8oZWG+cLwLLooWWGV8GpUxrMJIa3YMIEcOEjQhBc9yo0v07J
         Rr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732616578; x=1733221378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U6DI9UiS7mCrw7uF6OaC1EisPMexi0/iLw96bOdlu0=;
        b=sfY6ComCFS+oTREHoJHVmi1uOqyMuOmK2n6vOS7mgw3YQ0hB9D+AcUSrab1/nYrPmg
         TLoi5Okvsz0J/O7pDdpD+zwYYoN0UH3b1I4qnAfuyeQM8kKPtvVht1Lkq+56mIFWrVn/
         +NYIwmeqNZdffkI88kwhnMPRiV8rffayPBhGqzMSQxetBazErFlo7/OHIg0cIxrVJHsO
         A9XkWvLS80YHhitQZCEw1F0KNsiAlQNv4OPkeJpZAoI7LCTH58QnrcZdhOAoLCJ/S3c/
         yOJmMTZu6AxeWRKI4lIzqnieZ5PKgeebSLmq4x7l9VvWTw8E2b0E6zPs9/et5T9GP3OG
         Vf0w==
X-Forwarded-Encrypted: i=1; AJvYcCWKMZMcnCYt1cZThaCUZVKpznJnc3U5Pg8BunafZoqYoo6DKgukSEQZ0t0Sf2OG3vjSZEkLxloANxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oiFzGA6cVJMcXVQsvmz9RqZCiZd9A+9QD/O/2br8AdAZ/FQd
	uTMMd6hN6evtW6RVCQQS/e63LtoGUc4qPvbvDeVbmMv8TCWGPWzf3dUYRf3Z42I=
X-Gm-Gg: ASbGncufbMqZ+3dAwuv4EjBYZI0LREk5ImruuJuq95pULnIAdY8qyPJT+6m454qaG6d
	q2m7c+FSxGOgmFS8pD/GOhnni4J1vgqhPDY1uWr2Lt38NRkTAMuoJjxyoA3UHX+P2WrdRwd3WF6
	2NptzOzH8dSKOTQBf/FXLcQA2hY8hh8NTwBO3cCdL6T9MUz94lbMBz1RSk8Y9tg4/A7Kye5sY1h
	HHeTIf/lF0WjUvV6PeNaT11/j9MIqjo2sewalIdaOC+AOGYCL65d2Z/czrTD+xMju/pbeg=
X-Google-Smtp-Source: AGHT+IFaLK9Pd5Um5Yaikuh0FrdV/CYyyTM3uVzHgbDOgQuibopiqUgJ00t+FAWEy2IzhwY/faRjag==
X-Received: by 2002:ac2:5de2:0:b0:53d:d434:500a with SMTP id 2adb3069b0e04-53dd4345056mr5681073e87.5.1732616578454;
        Tue, 26 Nov 2024 02:22:58 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1046sm228378075e9.4.2024.11.26.02.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 02:22:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 26 Nov 2024 11:22:51 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sm8650: Add 'global' interrupt to
 the PCIe RC nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=WD2Ififyc67QT7itZr9mWxPZ1InWr4O/7CEhRE0kxnc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnRaF+2QmFQqhnVY1DSzumR+/6knam238u03MuV636
 /zgDejCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ0WhfgAKCRB33NvayMhJ0X24D/
 wMmt7rkM44OWagYOI9CEjt33RIgQwB1KHAvRxNWq/m5WeGtPfR8rJDFm/u1QS+yDvJETaZXzoFUVhe
 eA6PMLxkFR1l/wHU1t+F1O4uzs5k5/Qrq7cOVk+ZeBTL8nrdEmmIgjyUGz8e6IRnahlgR63BN6g1yF
 unDY/rC6asESMyweqW2OwAYgVqPIfe5Zlv2M8ydNoQat6SR15is5mVWeCmWHb4MljcDyOI+IByP/nu
 NV8Y34YAu3b1Zox4VF6BQhvo0hQmhz6UVH3/nCVSgfAz7ZHzdpECfVvWUhzoVfo2youChlGSU1mTLA
 vJRNJy8BS5viN5xmb/IlUG/JhSgx5G+PAMW7DPERUJsmxQuGUYuX8WO4wpTq9cPOZBtQol8A9p/FNr
 usm/qF4CenijJlcpOK1XdCNQxTP/jf5vwVO3pXqC6qBMpr1XyGDbVatomQj9PcYWUWClNXYvAFfAwK
 3juOOxZneew3bjBZd43FX6se8hRRQBa9eOZyX/9rCAjQ7hAdtv+icL1KqqgpHFIYsiTwbU9xvFueDV
 jq/KqXAOWHymXRcoWbetS2JV3EIGXjeEnY8NarRTubdE27KlVvya/lddZFIW8OD/pZfK9ZLeBzhMrZ
 vMpRg06HJ67f7FuMOfJYk2KXN/uXHrZRbNxQE9pkJVTen8lFmo7eYqRiMz7Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
to the host CPUs. This interrupt can be used by the device driver to
identify events such as PCIe link specific events, safety events, etc...

Hence, add it to the PCIe RC node along with the existing MSI interrupts.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 01ac3769ffa62ffb83c5c51878e2823e1982eb67..f394fadf11f9ac1f781d31f514946bd5060fa56f 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2233,7 +2233,8 @@ pcie0: pcie@1c00000 {
 				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -2241,7 +2242,8 @@ pcie0: pcie@1c00000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 
 			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
@@ -2365,7 +2367,8 @@ pcie1: pcie@1c08000 {
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi0",
 					  "msi1",
 					  "msi2",
@@ -2373,7 +2376,8 @@ pcie1: pcie@1c08000 {
 					  "msi4",
 					  "msi5",
 					  "msi6",
-					  "msi7";
+					  "msi7",
+					  "global";
 
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,

-- 
2.34.1


