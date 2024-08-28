Return-Path: <linux-pci+bounces-12375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B898962F38
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E60B1C215F8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBC1AB532;
	Wed, 28 Aug 2024 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="KU7xaW93"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF41AAE0F
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868090; cv=none; b=TgQ+dCZJZEuyJefRqjxt64YY9dZhUit7HJ54pEunB0GU/fBNdbH7sYsBstUsh02yQkFsIxZdVqpxZtsl1mJYe1fx1dT10WlKXv1gsMH1yll+efECM3gDOMwasaSms7e5L0Q1K6RxS1gq6tFyGQ1TKhdNE07GZGXsOoeVHrTl53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868090; c=relaxed/simple;
	bh=/vb0aTsU3lEvl+N81JvCAwUMclMq+XY5Iril9SbXX7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Msk9QYP0gxtmOVjtPEoxNRWItRSVJqMgbsWt9eblT8aAD6OM1vKGLgybOCJzbnDh26vkxQe+4hScriSSjciL3btWxw0ySgHY438S0Q8pZKHFv/xy3AsdlL97pv3vwZ28C9d2vxUaVjXqC2N6me3azPcRzqT5rPSXgI6zfjyfonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=KU7xaW93; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240828180126a951b03c67d32e9955
        for <linux-pci@vger.kernel.org>;
        Wed, 28 Aug 2024 20:01:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZuRHyhIm+3ZABVNx8IC9K5UScOLCFU+YW3yDdJnu7hQ=;
 b=KU7xaW93CDs0NGOXBZ5A2KZMmd3zKxfcBouQgkpVtCsBYfCzcyMB12w1/gh3NQKxalWxTY
 L3sQhZzYYuO5cgfS5YkXchqg0HBAfRkKUVc8e4rQQx3mrz5xKxq2O3uEkPCQLuznfLAhDTD6
 IiD0EK+ofiuSjKuAnA6b0pvE142XG7havfBZgLIgrlOJpKNUz8cPokZ6K2sdntWCWEZj2be7
 B70h6bsKuLPo4EaIoRSXNXm6tdBIWJShCkCdSOHLuPxWmJe8qYGyOz5p7vc/o9cN1bu2P52X
 YzvPMFxAIt0V63Cp3me+xblQeL7JtXdbbCkfdcwyS4+VGg3VoR1bs63Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Hua Qian Li <huaqian.li@siemens.com>,
	Diogo Ivo <diogo.ivo@siemens.com>
Subject: [PATCH v3 7/7] arm64: dts: ti: iot2050: Enforce DMA isolation for devices behind PCI RC
Date: Wed, 28 Aug 2024 20:01:20 +0200
Message-ID: <4cc8a653bb9f22e51d203120601f69aa59a4a09e.1724868080.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1724868080.git.jan.kiszka@siemens.com>
References: <cover.1724868080.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Reserve a 64M memory region below the top of 1G RAM (smallest RAM size
across the series, space left for firmware carve-outs) and ensure that
all PCI devices do their DMA only inside that region. This is configured
via a restricted-dma-pool and enforced with the help of the first PVU.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index e76828ccf21b..8af4bb132a10 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -82,6 +82,11 @@ wdt_reset_memory_region: wdt-memory@a2200000 {
 			reg = <0x00 0xa2200000 0x00 0x1000>;
 			no-map;
 		};
+
+		pci_restricted_dma_region: restricted-dma@ba000000 {
+			compatible = "restricted-dma-pool";
+			reg = <0 0xba000000 0 0x4000000>;
+		};
 	};
 
 	leds {
@@ -571,6 +576,10 @@ seboot-backup@e80000 {
 	};
 };
 
+&pcie0_rc {
+	memory-region = <&pci_restricted_dma_region>;
+};
+
 &pcie1_rc {
 	status = "okay";
 	pinctrl-names = "default";
@@ -580,6 +589,8 @@ &pcie1_rc {
 	phys = <&serdes1 PHY_TYPE_PCIE 0>;
 	phy-names = "pcie-phy0";
 	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
+
+	memory-region = <&pci_restricted_dma_region>;
 };
 
 &mailbox0_cluster0 {
@@ -640,3 +651,7 @@ &mcu_r5fss0 {
 	/* lock-step mode not supported on iot2050 boards */
 	ti,cluster-mode = <0>;
 };
+
+&ti_pvu0 {
+	status = "okay";
+};
-- 
2.43.0


