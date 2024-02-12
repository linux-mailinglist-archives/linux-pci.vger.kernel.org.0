Return-Path: <linux-pci+bounces-3356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCBE851A2A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 17:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DB91F24205
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA33F8C7;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Qex5DE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED43D564;
	Mon, 12 Feb 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756819; cv=none; b=lT+J3lXlhwXtyXCq6QzsbSAYNE1dRJzA7+0Q+cGS51eR+1hiVI9RmTmQF9npz/PCU507gQOnTOiS6mVldNMNe5Y4iOlyn/B6P40kWM1pPnmq2KA/pOs2n5LPdnuMMSBq1N7QQ07QxXr3uxlt10mnYA9XgVPrF+H8N0lY+MUCH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756819; c=relaxed/simple;
	bh=do7qssSaOOsYhWX62CD8zYvmH36b7lYP/5NxcIsaPjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlInEwubJ7IFzxoUjN4G1nmL/8/AuaxTeLx9Wf80EQxt58OToiII3D6sIJf4+ApD36N3w0GyrIXskI1wtiBC3tv82xiWpojMj7M7N8vkiAKXozklrkxFoYnGZld0JLqCHSJgynbAZh/h/prUFZoTQR4u9aGOQbGCiVFtDzaKzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3Qex5DE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF12FC433B2;
	Mon, 12 Feb 2024 16:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707756818;
	bh=do7qssSaOOsYhWX62CD8zYvmH36b7lYP/5NxcIsaPjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3Qex5DEUTE0gyJzfX48bECZ6IBhE96hrd/5Q/RgbRDZYYPBP009ZSkMInwzN2DOm
	 P6XanD8S/U6r/a8bOZ1iknkabkKPyLCRV7ZrfAtcwRWBlt/kxhnjStNqYrfovGHNch
	 yVpvN/Ig+SjLgfCe37IhBTwMP8n+it1YSKvdltRT/1B8DOO9ldn5ZFkMpeal/B+tvz
	 j550IwlH6yteAd5MAMPzD9EYFEEzK+soG6ModfzaGOD32MNADY7fsLxVjqvkX9yXiF
	 20UcLfoyOH63PzfYz5OSeRYw2NNlPnXCrYXYCj6e4iVFuivVhy33IpZJzxHYNwZ7J3
	 u4jgReaP0Xgtw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rZZZ2-000000007N9-34RA;
	Mon, 12 Feb 2024 17:53:52 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 06/10] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
Date: Mon, 12 Feb 2024 17:50:39 +0100
Message-ID: <20240212165043.26961-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212165043.26961-1-johan+linaro@kernel.org>
References: <20240212165043.26961-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWC PCIe controller can be used with its internal MSI controller or
with an external one such as the GICv3 Interrupt Translation Service
(ITS).

Add the msi-map properties needed to use the GIC ITS. This will also
make Linux switch to the ITS implementation, which allows for assigning
affinity to individual MSIs.

Note that using the GIC ITS on SC8280XP will cause Advanced Error
Reporting (AER) interrupts to be received on errors unlike when using
the internal MSI controller. This will specifically lead to
notifications about Correctable Errors being logged for the Wi-Fi
controller the Lenovo ThinkPad X13s when the AER driver is enabled.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 36382b1bd965..ee6026f4f12c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1737,6 +1737,8 @@ pcie4: pcie@1c00000 {
 			linux,pci-domain = <6>;
 			num-lanes = <1>;
 
+			msi-map = <0x0 &its 0xe0000 0x10000>;
+
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
@@ -1838,6 +1840,8 @@ pcie3b: pcie@1c08000 {
 			linux,pci-domain = <5>;
 			num-lanes = <2>;
 
+			msi-map = <0x0 &its 0xd0000 0x10000>;
+
 			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
@@ -1937,6 +1941,8 @@ pcie3a: pcie@1c10000 {
 			linux,pci-domain = <4>;
 			num-lanes = <4>;
 
+			msi-map = <0x0 &its 0xc0000 0x10000>;
+
 			interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
@@ -2039,6 +2045,8 @@ pcie2b: pcie@1c18000 {
 			linux,pci-domain = <3>;
 			num-lanes = <2>;
 
+			msi-map = <0x0 &its 0xb0000 0x10000>;
+
 			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
@@ -2138,6 +2146,8 @@ pcie2a: pcie@1c20000 {
 			linux,pci-domain = <2>;
 			num-lanes = <4>;
 
+			msi-map = <0x0 &its 0xa0000 0x10000>;
+
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
@@ -4426,7 +4436,7 @@ intc: interrupt-controller@17a00000 {
 			#size-cells = <2>;
 			ranges;
 
-			msi-controller@17a40000 {
+			its: msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
 				reg = <0 0x17a40000 0 0x20000>;
 				msi-controller;
-- 
2.43.0


