Return-Path: <linux-pci+bounces-33614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36AB1E38B
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09EAA7B2124
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8C3278146;
	Fri,  8 Aug 2025 07:29:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022121.outbound.protection.outlook.com [52.101.126.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E54276020;
	Fri,  8 Aug 2025 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638194; cv=fail; b=Es9VMfgvKHqM+wJkVd5GTgCQ+kivrkE7dMjCNDRVF5uJOVTFHSTFILEMWqzL6YIWDe5JoY/dQkC+8q5WkzkvUUi4z+dpUBtw6x/snypM8rkV9T6/eGEjt3a3T4dlAmsEJqmip8eqSnYLm6nG/mL6LOb7ZM6uGLvkI4J9Z6ruX4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638194; c=relaxed/simple;
	bh=5r2bP7wVnpDA+nj2eWxEMkp7ZJM3qp0xftH6fsdbeKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9QnEYeVTyHNY9KvJpOvwFYoDsj5d2/NlaGSCdKB77wGtTRyh/YmBk59k1PTQr2e2D06LxNIm/Dr3vkJiikMlkQwzeRyHnU17xr3EOcwOp04h8SI5ooAHZEzOwwuCzTICmeRpGbLPDFkNXjp+Vl90mxs5Oa4x517yiZQ9OOqY6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXbsSen6CQXPQ2NcZjhvelqobT+DlEubAg34XWM9RK3owgjR97IdVMYrtXy/Ckajk3pV+cGYS5d+oUU1biKri72FJRBXs0dQ9gdYHEtGd54O2yNVdrEx9a3vF1DVNie7OIIvXDHrv8U6KIUidGabje80huKlAHvBP+6/v+Axz78YtA2MO/+uImK4bSwGrqionpcOpT3Fx7jVzPhdxYZqdQexQ275D1V9k2aNZz4PAS85v05JYUC2C8C8GdnS/IuIFxmWqJB4phmfX/D0IhwOR9OW7dVk+Esx/UaGvwrm4aR+BJO8HgEkNZ9oLQVFPy/yRz54x5G+qPVBTxilrOX0Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iodmOlYm0/HiWFPiDth8gwAbe72TTsTeVjkZRlbI26I=;
 b=imPKikdkgEgYgn8fXaNQdbm+D3gNpyU/h6ahRouWl6ackszpZgsDT62KLjiccFcdmN8SVfMWqrmXwp/6tH8xFgTDK3yPVR6fBbnwKkQrUmOKVYG63iUjWPD6m+TpULk7jNYJvVgMpA8VVJb9cW5nIQYaLdo+swb0lxvsnad9NUkYjUOx4hH+/Pvcn/SC4vCPhFcLE1OLmhAZCc+FP/9lnzA4r6h4tQkaD2Te3GyCnbyCQayVn51iBLq2Doj0j6xuagX3saTWdM8W0tDXq5N5bb5gbjlV5AkZisUevi+C6CdrC290lq1X6Ipyk5jGxsoyxD8wyis39RzXvTBjXyZh6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0027.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:263::18)
 by KU2PPF1A2CB34C0.apcprd06.prod.outlook.com (2603:1096:d18::48b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 07:29:46 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:400:263:cafe::c7) by TYCP286CA0027.outlook.office365.com
 (2603:1096:400:263::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.14 via Frontend Transport; Fri,
 8 Aug 2025 07:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:36 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 9B9D7416050B;
	Fri,  8 Aug 2025 15:29:31 +0800 (CST)
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
Subject: [PATCH v6 11/12] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Fri,  8 Aug 2025 15:29:28 +0800
Message-ID: <20250808072929.4090694-12-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808072929.4090694-1-hans.zhang@cixtech.com>
References: <20250808072929.4090694-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|KU2PPF1A2CB34C0:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2d392f48-e042-48a0-8938-08ddd64d5415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aWtA30K0zA4f3lve4U99k1FaysfMZYYocY+XQa5UWNL2ELcw6Ps0U+FTgTTz?=
 =?us-ascii?Q?dsQYrUgr9F1ohzjC5hWL27+doz4umxdjWTHgZuX2Wv3yeKNtDrrDdkAMdYc/?=
 =?us-ascii?Q?Z2iSuCMohNiJGS34YqnCTRudATFuUlF520DsRkQ+Z5YXkJ0fxnlNx2VMrEzk?=
 =?us-ascii?Q?foMBoZ1z9Nzi2j7Sz0qoOfaVw49XZngSZIEgEBSdEHgvbdf2tI/YWmnMkhpr?=
 =?us-ascii?Q?1L5S3O8u9XYTTexJS9xuU7QdCIlRp32FlSB1fh8N1Ki20RpwYy6jHiOOJqdH?=
 =?us-ascii?Q?O9hqkYfvaIoiwHX/DL3RXJv3ADmrb+Fa6KoWqOgBjxJFzjlrN7C5Kj4GqaVN?=
 =?us-ascii?Q?Ceh7jq7+JbR6SqsIHfBc19oHzEaaKWU4k0huHLpRuQhgGzFIvVqqRKQxp5c0?=
 =?us-ascii?Q?/mOQnl0LS3AdNNMgfU89zIyjCuFeFqIvv82m7/bzLBQglh83M6UnNE+TZtjQ?=
 =?us-ascii?Q?5Aq39Q4wc3g11tmcGF8RtBImIadGChfWMTi+ns4LSvI8KFZT368vpIzSyzEc?=
 =?us-ascii?Q?kl3RZjvfepSV7vLeD03ymRoMDxbAQLj26doHXABFehgrjH+PtQM2muD4cj44?=
 =?us-ascii?Q?83bbZvbEh1rr+8Zy01K/zzMqQvCRakOqIT8ZJAaW3Ty2LAwIw5AGfmDHcjg/?=
 =?us-ascii?Q?oCGPKuI+/Oi8PM2eRaIKZ5rlqCNh8bwqpFm5UIGFoON6jnWxdTfXRPul55Hz?=
 =?us-ascii?Q?37hGHFuHroU+WPjqJj8TWtIpjMWwzIEks8h9A67iewVzfCMirAW1TDGt/YL0?=
 =?us-ascii?Q?cJIlVpGKATlJKBHGGhEwfl9hoPqN1cAu8k4/5wHIlwkg8LvQH2IRpWbID3tf?=
 =?us-ascii?Q?PsnmhIePx2qha6RcLsrHaSwYkxmAEdEHoFxaq3l95ZBZ8a5GoIjcDz+JpOEk?=
 =?us-ascii?Q?DDeNtz/WIFW/0vpJVwWx4q0F1W7CSWZAafRCtaAWPe9+la0N/3RorvClKWfv?=
 =?us-ascii?Q?wDjwWBXK9mlKkHySZuY3P48bBC37bbZitp6LnJjPYAys7fEHA2KLHoNg0liB?=
 =?us-ascii?Q?WJAPwPhfZV2vX+E1217PGvQPO9uEqQTKHVl6ynd7dANX66FpzzTDZQfV2OFT?=
 =?us-ascii?Q?omcXvoWuDPVXxdVTzImk6I1QZ0RBiTvu6F7g8rnljRPLW1DfnYdDEuFKVT+H?=
 =?us-ascii?Q?+Ueopq2aI7GrwbtGy48mX+/V65iegorDVnMgZ5LPW+0OQnW25GMGxqvl9dlS?=
 =?us-ascii?Q?ld0HpWDtjBW8m1Fdr3nPNoNaoV7hA0UZmuFrwl0gZHWmDiN2Z/RPQuUUx42Z?=
 =?us-ascii?Q?09aJYNOdighGeRD6SyFwYzrW4uvuJ/PtQc92XrhCWdCv+gQwXMR4qcoHsZU3?=
 =?us-ascii?Q?JIpo+e4wo0zCbjC9DoF2ds9navrluB98YrAP7LN+ttcneHm7tqReeM2jEz8f?=
 =?us-ascii?Q?Cj7M4M7rBeUt5RWkIZceNQTHsixMRTWPXapmLLfXTxVkV7uThTASgVIyWoj3?=
 =?us-ascii?Q?3Ul5FxP9TbzKiFp6XYDJOpOfPGmJ2l5FcoLD09Ef5dWhR4mGwOQiX+JdOgSY?=
 =?us-ascii?Q?EOF0klQKQ7ptYMa/BW2DH5BNgruKkATtY7qh?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:36.5729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d392f48-e042-48a0-8938-08ddd64d5415
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF1A2CB34C0

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


