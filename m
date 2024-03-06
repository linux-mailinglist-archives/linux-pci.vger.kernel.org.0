Return-Path: <linux-pci+bounces-4562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9028587336E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30B92B2926C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6F85FB90;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhoIEeDR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E995F576;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719189; cv=none; b=b4e6wY3xg3f+mLP271HdcKdp/OFzNoJG4DD5yLiizrLBnCth3be0w8M2ogJqFTIoackOjanZVuYzmxsEfW7XK2p/sw7FN1EG6sKgzcfP1Pu+VIs+E4BJgWaFkS6JGyvkshr+tQQzQFtozcr0rdx6DzUf1SgxLA0ZtOiFELUCUss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719189; c=relaxed/simple;
	bh=ojYPW7jE2rJIAUqkKuKAwwVsYcr465YkRrcIVQM/NDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgtTEuHu7+PPV9jj4pXw5rvwG2i07WsvU1HsnKuAmZdp7jdVB0mpocbd6xntgkPDEZwlj+VcX6uKjpKZkOxmu0PAY563+SjSRRxuPQj3wyBGHVdFyKZmaf1VNhlIt9kooZ1csrFl8mN6ifpLdKqDlbgrOlfE5LEZ+kxdUpzpqLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhoIEeDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B8CC4167E;
	Wed,  6 Mar 2024 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709719189;
	bh=ojYPW7jE2rJIAUqkKuKAwwVsYcr465YkRrcIVQM/NDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhoIEeDROIaO8AA16Uum4Jfj6q12UBAvn3pYSlFTbJnaVJhwiVMNublQEuWDG3yZR
	 JpM1gQgmw9RaHpxVTegRt7ahmT7BsXW+49mj97Dw0LgSSCRsNS1BY9uaFObTxVTOVt
	 +0csGMJeKdOoWd6eZ+Lqs2Vdju2s2FLtTNQOv836oh0jKC50EUDU3p6Int4i+3hO6+
	 rXV7qgepKR5dxXHsI9Ngvg96O2kVxzxbnkmAXInMZe3TQpWlfFGTfuejH+fwSj87Dc
	 hLLoCf3vyVJSatkk69eWSYf3sFG3r25tBo7DBlx8e9vjlD6HvCSr5jo9MU78Vk/mLZ
	 865AlormdHJUw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rho44-000000001b8-40Qa;
	Wed, 06 Mar 2024 10:59:56 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>
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
Subject: [PATCH v4 5/5] arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
Date: Wed,  6 Mar 2024 10:56:51 +0100
Message-ID: <20240306095651.4551-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306095651.4551-1-johan+linaro@kernel.org>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
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
controller on the Lenovo ThinkPad X13s when ASPM L0s is enabled.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index a8279ba6a756..906dd4a656a2 100644
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
@@ -4424,7 +4434,7 @@ intc: interrupt-controller@17a00000 {
 			#size-cells = <2>;
 			ranges;
 
-			msi-controller@17a40000 {
+			its: msi-controller@17a40000 {
 				compatible = "arm,gic-v3-its";
 				reg = <0 0x17a40000 0 0x20000>;
 				msi-controller;
-- 
2.43.0


