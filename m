Return-Path: <linux-pci+bounces-45035-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FBCD30217
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190CF3061DE3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 11:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EACA368285;
	Fri, 16 Jan 2026 11:07:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE43C3659F5;
	Fri, 16 Jan 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561647; cv=none; b=ZWduLoogBOp6bGBTRynH7q794230Do1zNrO3nytompcZyQLIBocC1cS3PtsJjK3Gjn/DlxfqeP/kgIUxHT/KFYNfl4Z5ucGYIh7FSyqMQkE7KDvOsGVQ4jVsYemX6AfDmXzuSPC4Q77NXdfq9AbfoqIqmuNS10dziJ6oMREbc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561647; c=relaxed/simple;
	bh=3v7Af6pWGk03W6bNXeT/pJxNN4SEGFnLZ70E1ejvFBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTKWHHS5HmMPRAonG4bH5hE+gU5MEtC60FYALsXwGS9h89jaWlLGctFwIlnzYJkL2TLltGa9QUUka4ctP6/lTbiWqol0P2VehLVajYwCyoMw58FbshPpstyjHxKpSTK5zSmUDSiP8XIyGIMfjKIX51rNhPMgooYJs872cemLeUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 60GB2fnx031253
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Fri, 16 Jan 2026 19:02:41 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 19:02:41 +0800
From: Randolph <randolph@andestech.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <jingoohan1@gmail.com>,
        <mani@kernel.org>, <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <alex@ghiti.fr>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <ben717@andestech.com>, <inochiama@gmail.com>,
        <thippeswamy.havalige@amd.com>, <namcao@linutronix.de>,
        <shradha.t@samsung.com>, <pjw@kernel.org>,
        <christian.bruel@foss.st.com>, <quic_wenbyao@quicinc.com>,
        <vincent.guittot@linaro.org>, <elder@riscstar.com>,
        <s-vadapalli@ti.com>, <randolph.sklin@gmail.com>,
        <tim609@andestech.com>, Randolph Lin <randolph@andestech.com>
Subject: [PATCH v10 2/4] riscv: dts: qilai: Add PCIe node into the QiLai SoC
Date: Fri, 16 Jan 2026 19:02:32 +0800
Message-ID: <20260116110234.1908263-3-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260116110234.1908263-1-randolph@andestech.com>
References: <20260116110234.1908263-1-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60GB2fnx031253

From: Randolph Lin <randolph@andestech.com>

Add the Andes QiLai PCIe node, which includes 3 Root Complexes.

Signed-off-by: Randolph Lin <randolph@andestech.com>
---
 arch/riscv/boot/dts/andes/qilai.dtsi | 106 +++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/riscv/boot/dts/andes/qilai.dtsi b/arch/riscv/boot/dts/andes/qilai.dtsi
index de3de32f8c39..afa7b75a7e7a 100644
--- a/arch/riscv/boot/dts/andes/qilai.dtsi
+++ b/arch/riscv/boot/dts/andes/qilai.dtsi
@@ -182,5 +182,111 @@ uart0: serial@30300000 {
 			reg-io-width = <4>;
 			no-loopback-test;
 		};
+
+		bus@80000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
+				 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;
+
+			pcie@80000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0x80000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04000000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+
+				linux,pci-domain = <0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x00 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x1f 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xf 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xf 0x4>,
+						<0 0 0 2 &plic 0xf 0x4>,
+						<0 0 0 3 &plic 0xf 0x4>,
+						<0 0 0 4 &plic 0xf 0x4>;
+			};
+		};
+
+		bus@a0000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0xa0000000 0x00 0xa0000000 0x00 0x20000000>,
+				 <0x00 0x04001000 0x00 0x04001000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x10 0x00000000 0x08 0x00000000>;
+
+			pcie@a0000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0xa0000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04001000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+
+				linux,pci-domain = <1>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x7 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xe 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xe 0x4>,
+						<0 0 0 2 &plic 0xe 0x4>,
+						<0 0 0 3 &plic 0xe 0x4>,
+						<0 0 0 4 &plic 0xe 0x4>;
+			};
+		};
+
+		bus@c0000000 {
+			compatible = "simple-bus";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
+			ranges = <0x00 0xc0000000 0x00 0xc0000000 0x00 0x20000000>,
+				 <0x00 0x04002000 0x00 0x04002000 0x00 0x00001000>,
+				 <0x00 0x00000000 0x18 0x00000000 0x08 0x00000000>;
+
+			pcie@c0000000 {
+				compatible = "andestech,qilai-pcie";
+				device_type = "pci";
+				reg = <0x00 0xc0000000 0x00 0x20000000>, /* DBI registers */
+				      <0x00 0x04002000 0x00 0x00001000>, /* APB registers */
+				      <0x00 0x00000000 0x00 0x00010000>; /* Configuration registers */
+				reg-names = "dbi", "apb", "config";
+
+				linux,pci-domain = <2>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
+					 <0x43000000 0x01 0x00000000 0x01 0x00000000 0x7 0x00000000>;
+
+				#interrupt-cells = <1>;
+				interrupts = <0xd 0x4>;
+				interrupt-names = "msi";
+				interrupt-parent = <&plic>;
+				interrupt-map-mask = <0 0 0 0>;
+				interrupt-map = <0 0 0 1 &plic 0xd 0x4>,
+						<0 0 0 2 &plic 0xd 0x4>,
+						<0 0 0 3 &plic 0xd 0x4>,
+						<0 0 0 4 &plic 0xd 0x4>;
+			};
+		};
+
 	};
 };
-- 
2.34.1


