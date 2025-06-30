Return-Path: <linux-pci+bounces-31040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C47CAED34B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6441895213
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BD95695;
	Mon, 30 Jun 2025 04:16:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5B92AF1B;
	Mon, 30 Jun 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256977; cv=fail; b=Y/RuIy8SV7d/3Ym39KzYXptl7J3pgLPbJfLjalgBRgTHgjlbreJ6Cla0eK+55e9b6Jp3WmIe7qAwgndx2PbxKvvCPTMKOEZ2hbX4gTn7TNYMkRQ3hJJHo1ZFLLTlR0paoERQh2wjwboqeCZ0eNgFaXlAoYp8Y9aXMoQd+9v1fnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256977; c=relaxed/simple;
	bh=wvKgjxJMiwaXB2xp2qBiu6KT7pP9aTp3EyjWrq16n64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGkwQJJeeUSzdSnA1Khh32B9JAt82jKkR1RHjZxmVCQtYUc9Bl+JWMV10ou8fvXgmj5Z37M9SA9qjSg0IqyNgRwjxWM6Dbz+JdImXuSFtZLjUreFZoSurrlCSofr7/RNEsXNj0YuAanKpDf52/EWGibPMbGsySKT81/uTbYNYX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElU86kWQHxeB++kAiELx00eO7k0SX5Vj8WYZc+cMIUXCfu616meHjCtkiS1+f9+h8BDuN77LSNogqhTxHG0T8u4UMvHzbKzNSbRH1CuvWkrDEgDwbpGObZIQoZ5bMf6g/hq6d/UN1fYWIhuksMDMeoE60ODkCRhZD/d5DXD7M8TyKazjGsjoPVp1dQctGo0uVUa8sMhs297IOi5AZDjG2a9e/B4wFUvpkkdimXDO1HxTPMfcoIz8i3TciPYf0D/4uONk5ZFrqFBnCiHurZqJK5kq5dVFBMB0enECGIw8r+jh6Rm14fs9y08kYwb57dkryJdSVITx3q7G4aEH1QP7DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vClJE8dOysat8bDscG0Y+y/5aZLN//ro9gd/ABk8WXM=;
 b=CePFkww5CBF3k3STylmn7WoSDc0dfTTCZzRGnbGMyMeQ6X9M5yL+7/IYaToA6clu123RpDq0/6iytkGQrcbmFEJTCxcxeBMd+cnLG/BIiRv934ZajPiOC9jhcph9cRpulh0YbIEU4OHZoSZt9pVcvxaGTCgpPlSSGvUhhKZZUBHauXXCLKA6Fpiy4x+WRJP9+tePm6z5hI5AHUGWkLeiVzAP/1PipK4lBKcNf+mLP89EWlAUv6W5EjkVUhwCCTccbaaJQW8hPGwqTlFPa6et+QwBdBcRqd4j9J38NxfBYTQBPUu7CYSYUK5GKmajPrO302SZR585aGiX05QMiERpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SE2P216CA0160.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2cb::12)
 by PUZPR06MB5604.apcprd06.prod.outlook.com (2603:1096:301:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Mon, 30 Jun
 2025 04:16:11 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:101:2cb:cafe::da) by SE2P216CA0160.outlook.office365.com
 (2603:1096:101:2cb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 04B194160504;
	Mon, 30 Jun 2025 12:16:07 +0800 (CST)
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
Subject: [PATCH v5 13/14] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Mon, 30 Jun 2025 12:16:00 +0800
Message-ID: <20250630041601.399921-14-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630041601.399921-1-hans.zhang@cixtech.com>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|PUZPR06MB5604:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 17a1cb8c-1f71-4136-24f9-08ddb78cd848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HtnqClRmrUmxbcx45BCTgBDK6k8/37zx8VDOzTUO3dx8PllR2x4+/BGHHKl0?=
 =?us-ascii?Q?3FsYYY5GVoZq6FgpecqbhfqBmFKNCaWmr1hBHJb+8mL4Q3y/nn1sP5LQltah?=
 =?us-ascii?Q?pa68qHH1kQzgr43VPex0g1uW57vovOTsWACxNTrimUfLe/TzsToPMFxOZ+TS?=
 =?us-ascii?Q?g7chaNKX4MJMTVpb6gd36MczsTnp47Yhelz5bYOK6TcLjllzalHd/+7VqAF5?=
 =?us-ascii?Q?eOkjOCK8jwCxdM0nJGwBW28Znf4ak1i0lqo2/YVnC4bAr6lj2c6VXPKSdN5b?=
 =?us-ascii?Q?Mnvp2w7igSHq6qpCfVQeT1r6/XA1yjz7Hzc7e5tQP3bROiMWyo0kQfqXIT8b?=
 =?us-ascii?Q?fLC70ujtOeCBwawHtlateizaQBMJbfnuWbAK/wUj4UpfF3pDsS4l1BZS6Eal?=
 =?us-ascii?Q?351VRjtDpAXTKeu67x6+xvLlz+cPoXBCeZBuqZNWvfiaJwaxOzWhw63X211C?=
 =?us-ascii?Q?5LGwxAmoxZCuIdo5lGZCAtPHD2XmnDa1UP/3JZXQTwe+/x4Un1MlpFBwS9p9?=
 =?us-ascii?Q?m4KFVz3+kkekaFCDYhXrrCCBn0szUp5Xse7eT1cwKSJDpNYOLpvcWBqKD8+w?=
 =?us-ascii?Q?TqDYuU4SytbFAtN/Q/LMFPanpffAB/Y31TgUlGSKRBKd6+bymv6etX/bsX34?=
 =?us-ascii?Q?IQ1+VKHuWJXwAyb1pZkUb4s5IVlszQXmymU17cKQzqhARuhnQIxCdq6Bo5ns?=
 =?us-ascii?Q?BLwlCrAMsBLhAXh7vBBAil4p09GCGzrhBUZX2XQ+Ox7OKzAVC3/TQA8FLlyn?=
 =?us-ascii?Q?aTqIP312zhWae6hjUuirTO3/5QuletMXYgEc0mGRvKoUyAkR66TzUX6aqARs?=
 =?us-ascii?Q?+QAzEDmMEuYOdEA03ThDwQ2gkq8bK2ysp1cTueTNK4ZHs//sBxFeenYB0JFU?=
 =?us-ascii?Q?P/3Y5888IBEv9eUFOHQi7nEMsv9zCLqifliX/XK2O8Om+vgnoGk9E8g0fKaV?=
 =?us-ascii?Q?/3L/L3iVXTt58TTWHCuYANXgjm4ObD3RT9Dh61Qex+vYQrumtvVRg7lhdbDX?=
 =?us-ascii?Q?UL4GAoAtvjHAQ+MuzVeeTK4Gd3ElpxhPPmMKMZHB0x580PLkNKUYSMlatx17?=
 =?us-ascii?Q?Cn5922P+DE1lTTlXz1AiH4yVvSBoC9TZmaZPQxUNqzN+xCYMR6zOcZF6ML40?=
 =?us-ascii?Q?5krYtbp0xdi7LI2JxYBebK9bk7zYlf2FVBNHdhQh2q6hkf2AVx/Sfk6Za/Wc?=
 =?us-ascii?Q?hQXT15HusCTNJqQDyY5s2vnvf9RieZhtuKJSxjZrGIX45TzSi83z5rME+Bjt?=
 =?us-ascii?Q?u1C/QmObS+eQEBuYBxXvHuNba6Xp2pLocfPWDSsJsarUHMJMBn6UJSuziaQN?=
 =?us-ascii?Q?IOHGVWAiMPUl78DnfoSDoUQDZovpCDcvCZElsqRV2FepCFikCb456cOpg8O3?=
 =?us-ascii?Q?DoEkuBBturNIg32rZgNuRcIlwNA47k9msKGqtn2iLn+87R0CSWhMXTXZcX0B?=
 =?us-ascii?Q?4s03HZG9AV5Un6PzTv/HiHsYBZh92EaGlHSIFZ+7M68I330eIiozPzPLGx78?=
 =?us-ascii?Q?SFLIH+u9q6CQzNaTgCKD7yzeVs8N9PM6D2gd?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:10.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a1cb8c-1f71-4136-24f9-08ddb78cd848
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5604

From: Hans Zhang <hans.zhang@cixtech.com>

Add pcie_x*_rc node to support Sky1 PCIe driver based on the
Cadence PCIe core.

Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
using the ARM GICv3.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 150 ++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 9c723917d8ca..1dac0e8d5fc1 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -289,6 +289,156 @@ mbox_ap2sfh: mailbox@80a0000 {
 			cix,mbox-dir = "tx";
 		};
 
+		pcie_x8_rc: pcie@a010000 { /* X8 */
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a010000 0x00 0x10000>,
+			      <0x00 0x0a000000 0x00 0x10000>,
+			      <0x00 0x2c000000 0x00 0x4000000>,
+			      <0x00 0x60000000 0x00 0x00100000>;
+			reg-names = "reg", "rcsu", "cfg", "msg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-link-speed = <4>;
+			num-lanes = <8>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0xc0 0xff>;
+			device_type = "pci";
+			ranges = <0x01000000 0x0 0x60100000 0x0 0x60100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x60200000 0x0 0x60200000 0x0 0x1fe00000>,
+				 <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
+			msi-map = <0xc000 &gic_its 0xc000 0x4000>;
+			vendor-id = <0x1f6c>;
+			device-id = <0x0001>;
+			cdns,no-inbound-bar;
+			sky1,pcie-ctrl-id = <0x0>;
+			status = "disabled";
+		};
+
+		pcie_x4_rc: pcie@a070000 { /* X4 */
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a070000 0x00 0x10000>,
+			      <0x00 0x0a060000 0x00 0x10000>,
+			      <0x00 0x29000000 0x00 0x3000000>,
+			      <0x00 0x50000000 0x00 0x00100000>;
+			reg-names = "reg", "rcsu", "cfg", "msg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-link-speed = <4>;
+			num-lanes = <4>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x90 0xbf>;
+			device_type = "pci";
+			ranges = <0x01000000 0x00 0x50100000 0x00 0x50100000 0x00 0x00100000>,
+				 <0x02000000 0x00 0x50200000 0x00 0x50200000 0x00 0x0fe00000>,
+				 <0x43000000 0x14 0x00000000 0x14 0x00000000 0x04 0x00000000>;
+			msi-map = <0x9000 &gic_its 0x9000 0x3000>;
+			vendor-id = <0x1f6c>;
+			device-id = <0x0001>;
+			cdns,no-inbound-bar;
+			sky1,pcie-ctrl-id = <0x1>;
+			status = "disabled";
+		};
+
+		pcie_x2_rc: pcie@a0c0000 { /* X2 */
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0c0000 0x00 0x10000>,
+				  <0x00 0x0a060000 0x00 0x10000>,
+				  <0x00 0x26000000 0x00 0x3000000>,
+				  <0x00 0x40000000 0x00 0x00100000>;
+			reg-names = "reg", "rcsu", "cfg", "msg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 427 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 428 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 429 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 430 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-link-speed = <4>;
+			num-lanes = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x60 0x8f>;
+			device_type = "pci";
+			ranges = <0x01000000 0x0 0x40100000 0x0 0x40100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x40200000 0x0 0x40200000 0x0 0x0fe00000>,
+				 <0x43000000 0x10 0x00000000 0x10 0x00000000 0x04 0x00000000>;
+			msi-map = <0x6000 &gic_its 0x6000 0x3000>;
+			vendor-id = <0x1f6c>;
+			device-id = <0x0001>;
+			cdns,no-inbound-bar;
+			sky1,pcie-ctrl-id = <0x2>;
+			status = "disabled";
+		};
+
+		pcie_x1_0_rc: pcie@a0d0000 { /* X1_0 */
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0d0000 0x00 0x10000>,
+			      <0x00 0x0a060000 0x00 0x10000>,
+			      <0x00 0x20000000 0x00 0x3000000>,
+			      <0x00 0x30000000 0x00 0x00100000>;
+			reg-names = "reg", "rcsu", "cfg", "msg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 436 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 437 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-link-speed = <4>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x00 0x2f>;
+			device_type = "pci";
+			ranges = <0x01000000 0x0 0x30100000 0x0 0x30100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x30200000 0x0 0x30200000 0x0 0x07e00000>,
+				 <0x43000000 0x08 0x00000000 0x08 0x00000000 0x04 0x00000000>;
+			msi-map = <0x0000 &gic_its 0x0000 0x3000>;
+			vendor-id = <0x1f6c>;
+			device-id = <0x0001>;
+			cdns,no-inbound-bar;
+			sky1,pcie-ctrl-id = <0x4>;
+			status = "disabled";
+		};
+
+		pcie_x1_1_rc: pcie@a0e0000 { /* X1_1 */
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a0e0000 0x00 0x10000>,
+			      <0x00 0x0a060000 0x00 0x10000>,
+			      <0x00 0x23000000 0x00 0x3000000>,
+			      <0x00 0x38000000 0x00 0x00100000>;
+			reg-names = "reg", "rcsu", "cfg", "msg";
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 2 &gic 0 0 GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 3 &gic 0 0 GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH 0>,
+					<0 0 0 4 &gic 0 0 GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH 0>;
+			max-link-speed = <4>;
+			num-lanes = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			bus-range = <0x30 0x5f>;
+			device_type = "pci";
+			ranges = <0x01000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000>,
+				 <0x02000000 0x0 0x38200000 0x0 0x38200000 0x0 0x07e00000>,
+				 <0x43000000 0x0C 0x00000000 0x0C 0x00000000 0x04 0x00000000>;
+			msi-map = <0x3000 &gic_its 0x3000 0x3000>;
+			vendor-id = <0x1f6c>;
+			device-id = <0x0001>;
+			sky1,pcie-ctrl-id = <0x3>;
+			cdns,no-inbound-bar;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller@e010000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0x0e010000 0 0x10000>,	/* GICD */
-- 
2.49.0


