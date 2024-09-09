Return-Path: <linux-pci+bounces-12960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C24971FEF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05929B22EBB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7718317ADF6;
	Mon,  9 Sep 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="JratCYA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0516F27F
	for <linux-pci@vger.kernel.org>; Mon,  9 Sep 2024 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901450; cv=none; b=Ue66N8HJAG/3gQFEF2KDhzM0FVGmFF+6ivZFrr9Fc84QCABNPuEvBDPHXx8mpGhnYbarL5RU+nZ+vDGjKUOm1XXgsfiNOfiv0eMPS+4XCdbScLTROLEOCZqRoj2IVHioPAVo1uyHvhYjyxIIpxy7QfgiOIHECqMEEBDgzGIK/SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901450; c=relaxed/simple;
	bh=YFhEhD2DDFAzOc5YRN506WbRhSuqs9WezZihnyy8brI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pIgxuFGLgJHTcwzybZekqAH6HVDaahFgP8mDJ7uPzu1GntO+2jC61FELbPq4Oes0yIeBivBaBTB1LLV0Y1EffL6fD633MtZ9lW94JmUg0Hei6G6eK0zf1wDnGcHFuJoaHRvR2sCvaWYnJUNeWn8Pw+FDtpI5bUuCpXuiZkxEwME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=JratCYA+; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202409091704039256fc421dc492a366
        for <linux-pci@vger.kernel.org>;
        Mon, 09 Sep 2024 19:04:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lEToRIXgwmYCaLisxjDuneMdvn7veaPhbgDLaE9G4uY=;
 b=JratCYA+vxPMGwri2jLrg5gYEFpK0ZcEAI3VUD1YPqTGoeqeCzuMeruJW7p1PnpN3Fbt67
 5fBU/D+6aDzKLGrzuG8NP1OD0+FBeNb7QP/D4K7G3EzkepRT85nsxPz05kl551TejHzS11br
 glmXhSK3l26Fa71clFBNLYK2VKyrLT3d0d/JhZQ6vs1LqaUQmVQWagVkmrCDro5nAS+lc0Zb
 jDb5drOa287okWaAr5KFcmYUwWDx+IzRYjBLUkLGLBdOat0IJ+DHpZg1be3+KRMY6jyh0V83
 7LCjiyebk8mRtqPJ3Q8YMl0nWummSng1wVWqQMxHDYVY84IzmkbcMSUA==;
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
Subject: [PATCH v6 5/7] arm64: dts: ti: k3-am65-main: Add PVU nodes
Date: Mon,  9 Sep 2024 19:03:58 +0200
Message-ID: <a747b4df2ed36a9339b157d4f8011e1e7a37eeb6.1725901439.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1725901439.git.jan.kiszka@siemens.com>
References: <cover.1725901439.git.jan.kiszka@siemens.com>
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

Add nodes for the two PVUs of the AM65. Keep them disabled, though,
because the board has to additionally define DMA pools and the devices
to be isolated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ba43325c0eec..2582dad68dff 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -841,6 +841,26 @@ main_cpts_mux: refclk-mux {
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
2.43.0


