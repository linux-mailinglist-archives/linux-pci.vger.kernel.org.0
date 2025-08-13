Return-Path: <linux-pci+bounces-33910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F308B23FA4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA07682217
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59352C178D;
	Wed, 13 Aug 2025 04:27:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022122.outbound.protection.outlook.com [52.101.126.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245202BE039;
	Wed, 13 Aug 2025 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059239; cv=fail; b=lu7CS9f2mEXan3Y6A8NPNBbKb6JeEgQdUCT2E9/rXrNMfRYIiEon+0UoEIMm5Z0zPs+18iRJMEvPr1a8MA6zVHlO/fxUIdnT5P5T170qsPyG3ImggxvhwA9TdZ1gVfYejNFAlsg5Jgz8XnF2i2xs3beWuPMzOiQSllR6yElF0Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059239; c=relaxed/simple;
	bh=5r2bP7wVnpDA+nj2eWxEMkp7ZJM3qp0xftH6fsdbeKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eq56/yjkvqzPj7BF6e6rVGUSLJxg/G2HecQK9v0i5ChVW1LW4kLK9ZPmSi/rnyjWKUCRG2XogrROSuwWPD91JXOvqDOEUF/sL1W0b+4DtoDf2VUdPWH/ukqlaAf/AYiV3FVnYFy3ODlWhugmGSuyOPaa7rPREMn3lSNm1oD79WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqSDy9SZABuNGPtgzbIrQ7/41tbfujPIMQGfc8l8IScjTCW/qmnwx36ksT84ORBSKifqBRkXNxUULlwh5JscfShLL7QFhfkbCgrHmjHdI3B1XF207BbxWDDMvmKQWHrQSQyvFG7Plj2X1M7cxgJRjZlW4kNvFL7q49trIiiLOyecxsowPyuY8O2jLT+jTDMzt5Nbh0ag64XBZxVHromox1qVVBZrDm+WmvZuiTpx5PtL1Y+k822JTYy2MmmVbD12PVmaweHnrAzCFdtRhh7iMWP+Z6lGVCV/nsHT8Ji98NHk5VjYruvvx6NVeEjzosJ5g4/PB5kttAFk5dKhqw5COg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iodmOlYm0/HiWFPiDth8gwAbe72TTsTeVjkZRlbI26I=;
 b=TlP/4qw4r4g4VjJIaa2INXQkdltXQzbxJY5Xc9SGP/gQz+a8NkV56gKUXc0Dycd2CB/1Z3wI+ZvM68/vw60PUjOe/WD/zMCmcafe6WEp1CD4+DvhFsXmrEyikD+S2sG3l7igxI8p4Or8NuOIu+00CtXEQG9TvLN83b3+Z/FSCmas0VD9zsA15mWZGn8UJ0Pja0CCpm7sjikNRDZALruHvTJPwbckgV5rpf0taswgz7ZfBgbYTWU47PnYTIe9haSeC3m5soLMvFiLioA2vq4sumn5SBzs6sbwLIWZYRJyqRIAlwGIeXbd6f3kmZT1736IexYbzsplngpEZA2e5Db5VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0268.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::13)
 by TY0PR06MB6802.apcprd06.prod.outlook.com (2603:1096:405:11::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 04:27:10 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:400:455:cafe::81) by TYCP286CA0268.outlook.office365.com
 (2603:1096:400:455::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DA06D41604EA;
	Wed, 13 Aug 2025 12:27:04 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	mani@kernel.org,
	robh@kernel.org,
	kwilczynski@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mpillai@cadence.com,
	fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com,
	peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <hans.zhang@cixtech.com>
Subject: [PATCH v7 12/13] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Wed, 13 Aug 2025 12:23:30 +0800
Message-ID: <20250813042331.1258272-13-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|TY0PR06MB6802:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d199262-607c-4725-54ee-08ddda21ab31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qz3C4m5ctAlqEgG9qpvIm2v3XehBY2DCnxuoXwHZlxAQEXunJIuVtqJ04ySb?=
 =?us-ascii?Q?7X342gLg5iDOP+mdzbDDHJpJmjBRWrGVV7khUrZDBlLB4L3KZvQePk91bhoX?=
 =?us-ascii?Q?/8i9YaCz78/bsNF+lb9MVnQzNG4ZOd6rUyeEttHzbesIZVN7M/gieaqHn6Yc?=
 =?us-ascii?Q?TXxyNfmcDahFInwDlFHkvYM4Y6L+Oc3HvrMkn1H6ziG6CEXmgzOxLTnLrUZx?=
 =?us-ascii?Q?oRVgQDxLe1YXPZ6HYq+jMj03KlH0Vt9mp3fCGdyg5TEfBzpSIgJ/15tLLPnV?=
 =?us-ascii?Q?mtr4RR4TkUeb70U2dL1SGEm3ObGVSf3dN4kv2W2PtO72hbB0ApRpoALRA8c+?=
 =?us-ascii?Q?n1eBmcIMecwV631kEf8QOCY/ex9rx0gP8TxQ3J3LpZRuE6zm/MIR2KuZDzB6?=
 =?us-ascii?Q?v8YrfAqRZvm+cCb72HWUIplmWviQ3cnXKqglvQpBpN9etzmZoJgqYAJx8+Zl?=
 =?us-ascii?Q?UFlfCwdPNL6XpO2IbTJDEmenjq3ox6yJlYMltPm7JU4czmaTXdOO8iREuRcN?=
 =?us-ascii?Q?lgNuVLeVbYheuocNLR/Yb/+jSvNQz9/VAiDPH5+aUXoBqjtatw93hf104/Cz?=
 =?us-ascii?Q?7gnKopsmdl6zOJq86myJkdS1Aq5fbVPPnZ6r190+OvrpOmFyQPDMDvHGCXgF?=
 =?us-ascii?Q?aEGvK0Fne6/Z77ZAsIevxcUcdwQH0aDHgJpUAh7celWBelcVyZWXhAnYVLlL?=
 =?us-ascii?Q?lxubnRXj/ffLnpkJeRngCJJquQnctYI4tDgoMr14Y8p7hirpNYqc9Ypac874?=
 =?us-ascii?Q?KpRR6M5BHyTPhbq3KQPqkaUeUQL2RYKbzm+dZWKqdM3KOtYNK4jR6g9BaKnM?=
 =?us-ascii?Q?hT7Ldc/2Z+vFbnrtCtI1i0XSQAYnXfQF452WdInGCgtSwrn6wvQ9m+fnh7Ug?=
 =?us-ascii?Q?pkr4zLo1fUYxIeoCEmZaH6L+xzlJ5cimQ+BQsgN5eStIS+f7R+i9ugX4PW7Y?=
 =?us-ascii?Q?IwltmpHCra5MPaZT2stFGKSS5nllZmQk/xWjn+Tanba1aaRkeWEc2EvG3fEE?=
 =?us-ascii?Q?JYhz4MOk9nBAgUXHMy8W5yZwRnxVN6nfqvP8jPruaWU2GVkzrCenItRyOn3G?=
 =?us-ascii?Q?Fn4ckzwwsgHvsnPgnYOwxnymPpb1AVks93XB3zj5djgSNC2+5vlhF5K7PFC0?=
 =?us-ascii?Q?KchCLea78qG+n0zRXOkXGToAwwX7wxVF+UudrSBLuNSDK1wgW45JgxtiuOs1?=
 =?us-ascii?Q?zy7Pq5lcaM0gGbgP3aSS5AxcwtUZC5NurOpxdmdRHjx0auaYo9TggDswA9bW?=
 =?us-ascii?Q?UDd46AD4QtAHnSGaRkvRQpCCtozm64i+SjlZ3vkacOHfSPuhjwGFcKVEMboh?=
 =?us-ascii?Q?8n9+iSs8GNoGPCdwilBM043+U7XR+jzw9tGYd48XCYw9H+KFZIZm6BtAtD9x?=
 =?us-ascii?Q?QJS3N5WTyE1FINfWtggmkTCZQ5i7vfvfk7kSfV/TalcGArDP/X6t5cczAwNC?=
 =?us-ascii?Q?i/L8vLYO3U6EClZ7bFC2VTlxsZEF5doQ+XqrJ9NBcYMEfn9AtiX8qOQ/KPVp?=
 =?us-ascii?Q?P2Ki+FkUs7sj/s2e5NfhEJMMHkpjYd+hEhsB?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:09.5301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d199262-607c-4725-54ee-08ddda21ab31
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB6802

From: Hans Zhang <hans.zhang@cixtech.com>

Add pcie_x*_rc node to support Sky1 PCIe driver based on the
Cadence PCIe core.

Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
using the ARM GICv3.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 121 ++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 7dfe7677e649..04ba80d4fc06 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -288,6 +288,127 @@ mbox_ap2sfh: mailbox@80a0000 {
 			cix,mbox-dir = "tx";
 		};
 
+		pcie_x8_rc: pcie@a010000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a010000 0x00 0x10000>,
+			      <0x00 0x2c000000 0x00 0x4000000>,
+			      <0x00 0x0a000000 0x00 0x10000>,
+			      <0x00 0x60000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu", "msg";
+			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
+				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0xc0 0xff>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+			status = "disabled";
+		};
+
+		pcie_x4_rc: pcie@a070000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a070000 0x00 0x10000>,
+			      <0x00 0x29000000 0x00 0x3000000>,
+			      <0x00 0x0a060000 0x00 0x10000>,
+			      <0x00 0x50000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu", "msg";
+			ranges = <0x01000000 0x00 0x50100000 0x00 0x50100000 0x00 0x00100000>,
+				 <0x02000000 0x00 0x50200000 0x00 0x50200000 0x00 0x0fe00000>,
+				 <0x43000000 0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x90 0xbf>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x9000 &gic_its 0x9000 0x3000>;
+			status = "disabled";
+		};
+
+		pcie_x2_rc: pcie@a0c0000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0c0000 0x00 0x10000>,
+			      <0x00 0x26000000 0x00 0x3000000>,
+			      <0x00 0x0a060040 0x00 0x10000>,
+			      <0x00 0x40000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu", "msg";
+			ranges = <0x01000000 0x0 0x40100000 0x0 0x40100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x40200000 0x0 0x40200000 0x0 0x0fe00000>,
+				 <0x43000000 0x10 0x00000000 0x10 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x60 0x8f>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x6000 &gic_its 0x6000 0x3000>;
+			status = "disabled";
+		};
+
+		pcie_x1_0_rc: pcie@a0d0000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0d0000 0x00 0x10000>,
+			      <0x00 0x20000000 0x00 0x3000000>,
+			      <0x00 0x0a060060 0x00 0x10000>,
+			      <0x00 0x30000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu", "msg";
+			ranges = <0x01000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x30200000 0x0 0x30200000 0x0 0x07e00000>,
+				 <0x43000000 0x08 0x00000000 0x08 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0x2f>;
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x0000 &gic_its 0x0000 0x3000>;
+			status = "disabled";
+		};
+
+		pcie_x1_1_rc: pcie@a0e0000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0e0000 0x00 0x10000>,
+			      <0x00 0x23000000 0x00 0x3000000>,
+			      <0x00 0x0a060080 0x00 0x10000>,
+			      <0x00 0x38000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu", "msg";
+			ranges = <0x01000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x38200000 0x0 0x38200000 0x0 0x07e00000>,
+				 <0x43000000 0x0C 0x00000000 0x0C 0x00000000 0x04 0x00000000>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x30 0x5f>;
+			device_type = "pci";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH 0>;
+			msi-map = <0x3000 &gic_its 0x3000 0x3000>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@e010000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
-- 
2.49.0


