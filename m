Return-Path: <linux-pci+bounces-42849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BC8CB0366
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 15:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671B930D3943
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 14:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4135F2F7478;
	Tue,  9 Dec 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="Rfsr7aE/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail42.out.titan.email (mail42.out.titan.email [209.209.25.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F52D6E67
	for <linux-pci@vger.kernel.org>; Tue,  9 Dec 2025 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.209.25.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765289376; cv=none; b=sGAGyXVBDD53zP4zGfJs/U99khhy8kq+rq5LBq5Vq2T63qWkqLqzrEEqsmAWldPxb3oaKkhNkqWWmPo8zHuNl39zBJuHsZUxDYr4NZxFtuC5esD3K9emUFVRO4T65P0L0VRmT2wSNkU10YGcyb2KcFQNsr0kSabVvXfNzGuxbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765289376; c=relaxed/simple;
	bh=mLxHM7v3nc2eSPeHc66Rsm2ca/TBQClwE1qkrXRjbiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMNtgfh9kpDurKfRBV+mW/Y3Au3yLUt+A1tFfYOGdpHtBBGd59K5xlXzNdHWePqvLRNicvC1spm9C2HXcLYNSNyiwH5OxSl7sRuf+EAfTkzhCvSKIdMXpSAy2SLk+dn4rAMdi152zmJFQrVSAD9fY7fAjjGeIyDaQFO/FBPcICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=Rfsr7aE/; arc=none smtp.client-ip=209.209.25.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dQgVB3gRZz9s0g;
	Tue,  9 Dec 2025 14:00:34 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=A7BJ2vjwLN9PGUv41KyJdSJlE9d2VhELFYZ/HdmZbZs=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=cc:references:mime-version:subject:from:to:in-reply-to:date:message-id:from:to:cc:subject:date:message-id:in-reply-to:references:reply-to;
	q=dns/txt; s=titan1; t=1765288834; v=1;
	b=Rfsr7aE/YKzbZWePife2RDVHBt4e//dtbnKSd6Lb4fT/Qy7fEss4BCcdM9+ojpku1NH8gpJP
	c/W8bJYEHI7nBBlTAiKYE1uyDxQ6La+eqoTVjGol04jxbSWIzjI4OLoLmc2Sp7U7kthlqTTz45Y
	XoQ7HFBrpRudksz8YwBtM7wQ=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dQgV40ylDz9rxt;
	Tue,  9 Dec 2025 14:00:27 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Cc: linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH 1/2] LoongArch: dts: Describe PCI sideband IRQ through interrupt-extended
Date: Tue,  9 Dec 2025 14:00:05 +0000
Message-ID: <20251209140006.54821-2-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251209140006.54821-1-me@ziyao.cc>
References: <20251209140006.54821-1-me@ziyao.cc>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1765288834073928996.21635.2100463422223919414@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=69382b82
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
	a=W4-7hV26G1j7c2fSSyQA:9 a=3z85VNIBY5UIEeAh_hcH:22
	a=NWVoK91CQySWRX1oVYDe:22

SoC integrated peripherals on LS2K1000 and LS2K2000 could be discovered
as PCI devices, but require sideband interrupts to function, which are
previously described by interrupts and interrupt-parent properties.

However, pci/pci-device.yaml allows interrupts property to only specify
PCI INTx interrupts, not sideband ones. Convert these devices to use
interrupt-extended property, which describes sideband interrupts used by
PCI devices since dt-schema commit e6ea659d2baa ("schemas: pci-device:
Allow interrupts-extended for sideband interrupts"), eliminating
dtbs_check warnings.

Fixes: 30a5532a3206 ("LoongArch: dts: DeviceTree for Loongson-2K1000")
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 arch/loongarch/boot/dts/loongson-2k1000.dtsi | 25 ++++++---------
 arch/loongarch/boot/dts/loongson-2k2000.dtsi | 32 ++++++++------------
 2 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/arch/loongarch/boot/dts/loongson-2k1000.dtsi b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
index 60ab425f793f..eee06b84951c 100644
--- a/arch/loongarch/boot/dts/loongson-2k1000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k1000.dtsi
@@ -437,54 +437,47 @@ pcie@1a000000 {
 
 			gmac0: ethernet@3,0 {
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc0>;
-				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
-					     <13 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc0 12 IRQ_TYPE_LEVEL_HIGH>,
+						      <&liointc0 13 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				status = "disabled";
 			};
 
 			gmac1: ethernet@3,1 {
 				reg = <0x1900 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc0>;
-				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-					     <15 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc0 14 IRQ_TYPE_LEVEL_HIGH>,
+						      <&liointc0 15 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				status = "disabled";
 			};
 
 			ehci0: usb@4,1 {
 				reg = <0x2100 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc1>;
-				interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc1 18 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			ohci0: usb@4,2 {
 				reg = <0x2200 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc1>;
-				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc1 19 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			display@6,0 {
 				reg = <0x3000 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc0>;
-				interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc0 28 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			hda@7,0 {
 				reg = <0x3800 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc0>;
-				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc0 4 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			sata: sata@8,0 {
 				reg = <0x4000 0x0 0x0 0x0 0x0>;
-				interrupt-parent = <&liointc0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&liointc0 19 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
diff --git a/arch/loongarch/boot/dts/loongson-2k2000.dtsi b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
index 6c77b86ee06c..87c45f1f7cc7 100644
--- a/arch/loongarch/boot/dts/loongson-2k2000.dtsi
+++ b/arch/loongarch/boot/dts/loongson-2k2000.dtsi
@@ -291,65 +291,57 @@ pcie@1a000000 {
 
 			gmac0: ethernet@3,0 {
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
-				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
-					     <13 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&pic 12 IRQ_TYPE_LEVEL_HIGH>,
+						      <&pic 13 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
-				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
 
 			gmac1: ethernet@3,1 {
 				reg = <0x1900 0x0 0x0 0x0 0x0>;
-				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
-					     <15 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&pic 14 IRQ_TYPE_LEVEL_HIGH>,
+						      <&pic 15 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
-				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
 
 			gmac2: ethernet@3,2 {
 				reg = <0x1a00 0x0 0x0 0x0 0x0>;
-				interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
-					     <18 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&pic 17 IRQ_TYPE_LEVEL_HIGH>,
+						      <&pic 18 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
-				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
 
 			xhci0: usb@4,0 {
 				reg = <0x2000 0x0 0x0 0x0 0x0>;
-				interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-parent = <&pic>;
+				interrupts-extended = <&pic 48 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			xhci1: usb@19,0 {
 				reg = <0xc800 0x0 0x0 0x0 0x0>;
-				interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-parent = <&pic>;
+				interrupts-extended = <&pic 22 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			display@6,1 {
 				reg = <0x3100 0x0 0x0 0x0 0x0>;
-				interrupts = <28 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-parent = <&pic>;
+				interrupts-extended = <&pic 28 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
 			i2s@7,0 {
 				reg = <0x3800 0x0 0x0 0x0 0x0>;
-				interrupts = <78 IRQ_TYPE_LEVEL_HIGH>,
-					     <79 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts-extended = <&pic 78 IRQ_TYPE_LEVEL_HIGH>,
+						      <&pic 79 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "tx", "rx";
-				interrupt-parent = <&pic>;
 				status = "disabled";
 			};
 
 			sata: sata@8,0 {
 				reg = <0x4000 0x0 0x0 0x0 0x0>;
-				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-parent = <&pic>;
+				interrupts-extended = <&pic 16 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-- 
2.51.2


