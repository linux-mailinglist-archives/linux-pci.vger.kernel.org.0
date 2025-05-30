Return-Path: <linux-pci+bounces-28739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E09AAC97E2
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 00:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D227AC2E1
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 22:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E3A28C030;
	Fri, 30 May 2025 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TuvIHkAd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DWS0EUCH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340C28B7E0;
	Fri, 30 May 2025 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748645753; cv=none; b=drRTrSxL70SwboTNEXTD5Lw8ipEQomC3Qy/Hf2ZSfPundq3qlUccBKkz8vdCqevSO0pd6aaGa7j7djv2Vj/NVQ4K71VMJqISRSSAgWAjqhW1RoJP4exEzQxvwCPtGNvElMXEQey5fE3PxxpWZvIF92QFT9mDchln9Wn0j0Mkjc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748645753; c=relaxed/simple;
	bh=5CQhdqDvxFRyXjUrXHRDlKOYL4wlGrP7ruqNjEl6k20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0T/ZI3EeE9+UrB4nKOngGbQ7V3tcoRSBNsEAmzy0ehSxKDyyJwRX5FaU8XLHPeAEsyCiYNUPuhAdJAPGKfk22AEm/lz+LhU89rX5r6DhpDyA8miuS2j/F+gjHahJu2S05ORDNiqwzUcnOZP8jxzsqm4xtwStF0mD1302IhmK2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TuvIHkAd; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DWS0EUCH; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b8JVs3HsFz9t27;
	Sat, 31 May 2025 00:55:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748645749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDVWNwdVtG1KZhnutJdWeLg3yjHz2NQpZ8yUV0l1SDI=;
	b=TuvIHkAd4CYFNKwS7j6IyBdIMdjkJtm1d/DR2TwkRythVPTgrWsoqUc/azn4lwb+XKTDLd
	/bFAZZTdpKJQfvCCrUqtIbqONgaWg/dT9IZeVagvvyx+ksNDEGqf51D65f5avhh/gsLndL
	39yt1waZ561I2pKseLC2/KhNNdmD0a7ssFSHrhGTfptB/d+Gu8aIJY8sqKNy+6SF/o5ELA
	Yw2FSTJaGAnNLM66CudnC26QWUg4uxecfWrhWhBWogVch42dx2LKZMBKHRmtdGzoU51C5k
	9sIRaavuxVfRazMAeqVtaxCCtmsR/BtG6hxg34D0PrKZd4YTjrJrdnhlaD+eeA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1748645747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDVWNwdVtG1KZhnutJdWeLg3yjHz2NQpZ8yUV0l1SDI=;
	b=DWS0EUCHpxOq/PXIS6Lk8FBPzX1MHT0uvXTxst/lN9954kFb3KTTdamT47y2ANt76tA8Qr
	g+queoPd4gK5FKbrWLhmeWiS2FNLpWQifedWeeYA9wq0R29H7MinTH6uB+W4Q3NE4UWKRj
	0zk3kDlIwseiaIxSpdwdPdekmSSMlVdErRdHOy9+1zyFr0t31hYI6AcWF9KVYyggxTkpBl
	unc+VAImPEEcICVQIqEsJtDImypky97OxnKE64rD4H9/AXs2m5dZogJTuvVwzuYPz63DLD
	2c4O6Kc5P82b3z6yHBvgKreujutZMi82TFPS9EMKVYeeye9eR2DQ1Tthtzkjew==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: renesas: r8a779g0: Describe root port on R-Car V4H
Date: Sat, 31 May 2025 00:53:20 +0200
Message-ID: <20250530225504.55042-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
References: <20250530225504.55042-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c1f4a7b45a214c9f739
X-MBO-RS-META: p36aga13zprur5pijcq3q7ogtmuqeksh

Add node which describes the root port into PCIe controller DT node.
This can be used together with pwrctrl driver to control clock and
power supply to a PCIe slot. For example usage, refer to V4H Sparrow
Hawk board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: New patch
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 6dbf05a559357..8d9ca30c299c9 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -798,6 +798,16 @@ pciec0: pcie@e65d0000 {
 					<0 0 0 4 &gic GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>;
 			snps,enable-cdm-check;
 			status = "disabled";
+
+			/* PCIe bridge, Root Port */
+			pciec0_rp: pci@0,0 {
+				#address-cells = <3>;
+				#size-cells = <2>;
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				ranges;
+			};
 		};
 
 		pciec1: pcie@e65d8000 {
@@ -835,6 +845,16 @@ pciec1: pcie@e65d8000 {
 					<0 0 0 4 &gic GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>;
 			snps,enable-cdm-check;
 			status = "disabled";
+
+			/* PCIe bridge, Root Port */
+			pciec1_rp: pci@0,0 {
+				#address-cells = <3>;
+				#size-cells = <2>;
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				ranges;
+			};
 		};
 
 		pciec0_ep: pcie-ep@e65d0000 {
-- 
2.47.2


