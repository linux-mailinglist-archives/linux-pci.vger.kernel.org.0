Return-Path: <linux-pci+bounces-12378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B706962F42
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F0B23935
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7641A4F0F;
	Wed, 28 Aug 2024 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="ee0xI95/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDD1AAE19
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868093; cv=none; b=lcwvsD9JbhZaVhnc0BIUo76v5Xoe09m3b9m1Bxi2L0D6DLCew5NFbP/V8Aw2tKOpslzB2+uwiN4AdTBat5rVHfoecaDN4IkkrHnog8Rm+4jyl3Ersb8yWH23CTpzcUzyxSupYn0lLzHtPpsMmZ+25rV9XcDtlpjhUU7UrogtP78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868093; c=relaxed/simple;
	bh=Y+83Zq39yj1aZRu0hrD5EBGhQ3sOjxsXdYa32F1Vygk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk+7WID+lYSKalcBpMiOO3tbvd6aomHyh38KXnrHtXRhiF1gTRz7Sr00JHlRb2MJlNd3Ts4qPal7UOpbu9qxVHlVqR2E/+FRhg8zfQ15yVtJ/7FUtM6+J2SOHSNQ6u7Y/UoqJhwc3dGCZiRuoYUyXbDnbL/072gJLwYYr0sCTpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=ee0xI95/; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202408281801232b1ca1c66c5d34f34e
        for <linux-pci@vger.kernel.org>;
        Wed, 28 Aug 2024 20:01:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RWcQ/RmTGCXM7N+YzgeBVxjrCMTcl4LLzbDbsVMgp4w=;
 b=ee0xI95/9WRvYC4Y0kcIY/Wdp4iO/ldBeuowpvzdhzAJAUTfnbFs7Yjj/HQR/mdsJYhqXN
 w5XDG43OtTR3YM+irRx/Y1Hg3Rosj0WM2WgyPaJR6rggZQtjl3TGp4B+YvLbEdXxoaeT0S/R
 0Qztr35A9/atvyNa5XooBB6V3sbtnDKNo0Bps1Zl0EVVFZC1Bb5B/PyLOVG5+UftC8Q4XAxy
 lV7wHBD6ifZgUO43BrrqK1vTVi7hQcF/PtCABdoCwifxbbRNvV3xt9mtEeqCzpEoA9BBpN4c
 jsonEACcOa4gS6BUcJxFDzlBTG62kRIEFAiTJoaFONZQTmqsKs2febUw==;
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
Subject: [PATCH v3 3/7] arm64: dts: ti: k3-am65-main: Add PVU nodes
Date: Wed, 28 Aug 2024 20:01:16 +0200
Message-ID: <502f266994398ef2e26d825ab3e60776bcee85cd.1724868080.git.jan.kiszka@siemens.com>
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

Add nodes for the two PVUs of the AM65. Keep them disabled, though,
because the board has to additionally define DMA pools and the devices
to be isolated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index a8664b246795..08ce765828a4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -833,6 +833,26 @@ main_cpts_mux: refclk-mux {
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


