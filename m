Return-Path: <linux-pci+bounces-34380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B200EB2DB95
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 13:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB031707D4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 11:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D6D2BE7BE;
	Wed, 20 Aug 2025 11:47:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2C2E7BBD
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690467; cv=none; b=j22IZGZ2VkNicS0lZHCluzPsREYDT80udxlo0Lf0VYEqsXjRrVsYwEmCSkQBxqTHQDOAJ+geqbEkO8vq75iw91Ec+bA7FN8L6BfUrdiH1BVOi57Vw4BPQSGjztVYl2LSRy5FHQcN6GZL3f92YhI4JrES/PFvgjRpOhqb8KJM07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690467; c=relaxed/simple;
	bh=n0MLgJevDA/sGNXnR2RpzBLorrwCyqbwQYoui+XivCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdgwhFJPod601EYNpgsV1AUmehJahWlX9FXP9iytHnzfr/4xGM4BksG7UuIXc7XSaaUiqMILVk+juKBk4Zp06Q8EmaMosANq+ur7s5H04q4OWxIRF3jRD4buTZ0rMBj6O1I8N0dj1GQYkST4qahBF7YFN49B03XAsndjyK0HsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57KBJNxm019179
	for <linux-pci@vger.kernel.org>; Wed, 20 Aug 2025 19:19:23 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 57KBIsdH018800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 19:18:54 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Wed, 20 Aug 2025
 19:18:54 +0800
From: Randolph Lin <randolph@andestech.com>
To: <linux-pci@vger.kernel.org>
CC: <ben717@andestech.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <bhelgaas@google.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>,
        Randolph Lin <randolph@andestech.com>
Subject: [PATCH 4/6] riscv: dts: andes: Add PCIe node into the QiLai SoC
Date: Wed, 20 Aug 2025 19:18:41 +0800
Message-ID: <20250820111843.811481-5-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820111843.811481-1-randolph@andestech.com>
References: <20250820111843.811481-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57KBJNxm019179

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/boot/dts/andes/qilai.dtsi | 76 ++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
index d78d57b3bc52..9a0e32499621 100644
--- a/arch/riscv/boot/dts/andes/qilai.dtsi
+++ b/arch/riscv/boot/dts/andes/qilai.dtsi
@@ -183,5 +183,81 @@ uart0: serial@30300000 {
 			reg-io-width = <4>;
 			no-loopback-test;
 		};
+
+		/* DM0 */
+		pci@80000000 {
+			compatible = "andestech,qilai-pcie";
+			device_type = "pci";
+			reg = <0x00 0x80000000 0x00 0x20000000>, /* DBI registers */
+			      <0x20 0x00000000 0x00 0x00010000>, /* Configuration registers */
+			      <0x00 0x04000000 0x00 0x00001000>; /* APB registers */
+			reg-names = "dbi", "config", "apb";
+			bus-range = <0x0 0xff>;
+			num-viewport = <4>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x02000000 0x00 0x10000000 0x20 0x10000000 0x0 0xF0000000>,
+				 <0x43000000 0x01 0x00000000 0x21 0x0000000 0x1F 0x00000000>;
+			#interrupt-cells = <1>;
+			interrupts = <0xF IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			interrupt-parent = <&plic>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 1 &plic 0xF IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &plic 0xF IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &plic 0xF IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &plic 0xF IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		/* DM1 */
+		pci@a0000000 {
+			compatible = "andestech,qilai-pcie";
+			device_type = "pci";
+			reg = <0x00 0xA0000000 0x00 0x20000000>, /* DBI registers */
+			      <0x10 0x00000000 0x00 0x00010000>, /* Configuration registers */
+			      <0x00 0x04001000 0x00 0x00001000>; /* APB registers */
+			reg-names = "dbi", "config", "apb";
+			bus-range = <0x0 0xff>;
+			num-viewport = <4>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x02000000 0x00 0x10000000 0x10 0x10000000 0x0 0xF0000000>,
+				 <0x43000000 0x01 0x00000000 0x11 0x00000000 0x7 0x00000000>;
+			#interrupt-cells = <1>;
+			interrupts = <0xE IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			interrupt-parent = <&plic>;
+			interrupt-controller;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 1 &plic 0xE IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &plic 0xE IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &plic 0xE IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &plic 0xE IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		/* DM2 */
+		pci@c0000000 {
+			compatible = "andestech,qilai-pcie";
+			device_type = "pci";
+			reg = <0x00 0xC0000000 0x00 0x20000000>, /* DBI registers */
+			      <0x18 0x00000000 0x00 0x00010000>, /* Configuration registers */
+			      <0x00 0x04002000 0x00 0x00001000>; /* APB registers */
+			reg-names = "dbi", "config", "apb";
+			bus-range = <0x0 0xff>;
+			num-viewport = <4>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x02000000 0x00 0x10000000 0x18 0x10000000 0x0 0xF0000000>,
+				 <0x43000000 0x01 0x00000000 0x19 0x00000000 0x7 0x00000000>;
+			#interrupt-cells = <1>;
+			interrupts = <0xD IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			interrupt-parent = <&plic>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 1 &plic 0xD IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &plic 0xD IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &plic 0xD IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &plic 0xD IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.34.1


