Return-Path: <linux-pci+bounces-32612-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C66FB0BB23
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 05:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFF37AC4BF
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5EE18EB0;
	Mon, 21 Jul 2025 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b="CvkXuMS+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A07129A78
	for <linux-pci@vger.kernel.org>; Mon, 21 Jul 2025 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066862; cv=none; b=J5FJRuUqQqr0RDanh4pw2z39S9SqGMRk0HITmSYCGThKfwLH0Mvs98kVrzdNrsaCP3hakQ3fur1vzZTbo9vJoQjAf2pW8ttLwBTUL5nbAG2ZdvJao8Vy3ceNNhLRtDlA8J/wjv0jDOyALxgCs7cd74YAkL0WwkgFco4t7DWLIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066862; c=relaxed/simple;
	bh=6lqg47ZzHvYuqgvo+kg+TR1pSFW+bHqDcSaP517sWY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=plLezh6BIt6EFsCHyeg5Cn6nKgoIMFIkYkXBK/fmQQ4i+vuJ98MJLkj35WD7oE7wpOAGzHN9u9UX0FfiEC+hUorLDL80+gArG0JKqHXYddhfJ2Gw2f+Sckv8PEgBtOwSVHYfXz3fB5We3x5kR3+5AXqjMY6WwOG2/s2bitIbD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=huaqian.li@siemens.com header.b=CvkXuMS+; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202507210300535188f3111abfbabf29
        for <linux-pci@vger.kernel.org>;
        Mon, 21 Jul 2025 05:00:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=huaqian.li@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=q/BKbhuL0vKp+y2KpfAqEHa8O7EtSQwyOm6GZvSm+1w=;
 b=CvkXuMS+U9++KsW6UQFzd1r2SC8DHb9CVpVvqqDrzQiYEyB22sWIaHexUAEsxV3pqPSVnK
 Esbui3nybGHrKrEdIPor1ebTxpwr08yW67U/xtrJZnxGi1yhTug0Jv/HCoaAm1cD52Vg9gmW
 is9fGGD83kcVN5hCdRm5+5risKQroKh0VCGHphprxG/olP4+elmAy0Ldtmw1DCFd1iHvjatg
 FPjypANuey2hmIS749s+P2UwU/3FY7WFC2I/nOnDRgI9mmyL2fAvOa+u097v5XR2vh2V9TuX
 MPZJbVRGLqqU7B47Oep70LwPK3RdWuCoIta9YFI/0FyVI9Y3PcOL3h6A==;
From: huaqian.li@siemens.com
To: s-vadapalli@ti.com
Cc: baocheng.su@siemens.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	diogo.ivo@siemens.com,
	helgaas@kernel.org,
	huaqian.li@siemens.com,
	jan.kiszka@siemens.com,
	kristo@kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	nm@ti.com,
	robh@kernel.org,
	ssantosh@kernel.org,
	vigneshr@ti.com
Subject: [PATCH v10 5/7] arm64: dts: ti: k3-am65-main: Add PVU nodes
Date: Mon, 21 Jul 2025 10:59:43 +0800
Message-Id: <20250721025945.204422-6-huaqian.li@siemens.com>
In-Reply-To: <20250721025945.204422-1-huaqian.li@siemens.com>
References: <20250721025945.204422-1-huaqian.li@siemens.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-959203:519-21489:flowmailer

From: Jan Kiszka <jan.kiszka@siemens.com>

Add nodes for the two PVUs of the AM65. Keep them disabled, though,
because the board has to additionally define DMA pools and the devices
to be isolated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index b085e7361116..be65e6aa7b80 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -843,6 +843,26 @@ main_cpts_mux: refclk-mux {
 				assigned-clock-parents = <&k3_clks 118 5>;
 			};
 		};
+
+		ti_pvu0: iommu@30f80000 {
+			compatible = "ti,am654-pvu";
+			reg = <0 0x30f80000 0 0x1000>,
+			<0 0x36000000 0 0x100000>;
+			reg-names = "cfg", "tlbif";
+			interrupts-extended = <&intr_main_navss 390>;
+			interrupt-names = "pvu";
+			status = "disabled";
+		};
+
+		ti_pvu1: iommu@30f81000 {
+			compatible = "ti,am654-pvu";
+			reg = <0 0x30f81000 0 0x1000>,
+			<0 0x36100000 0 0x100000>;
+			reg-names = "cfg", "tlbif";
+			interrupts-extended = <&intr_main_navss 389>;
+			interrupt-names = "pvu";
+			status = "disabled";
+		};
 	};
 
 	main_gpio0: gpio@600000 {
-- 
2.34.1


