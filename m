Return-Path: <linux-pci+bounces-34288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D6CB2C256
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F0CB1967343
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B903375AA;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022073.outbound.protection.outlook.com [40.107.75.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5E32C32F;
	Tue, 19 Aug 2025 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604519; cv=fail; b=l8RxXpWjh7GomVDrRl0T/+hbvNL6f6hJLMqu6Z77p/EXs0A5RLAsUbJfdP/NPsC5bbzN+zLMh4l0Sm0gHABfaiezgUwDcabwNBKiDWRRiBkbZFw/aS7yCqHcSvjl14UYnWhzk2AVhTbh0AwxvAzTiowoDLYidbim6LfA4LxXELc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604519; c=relaxed/simple;
	bh=hlwHpD6U9hd30V0DbrMF98D4k3Jg9M5t0eePag/3xuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L8JmNbFHHNHecHBc9ZrEqUtV5PsdJUNbDHXNJAbPqeJOch4KaX2/nh+rm6c55V6SMBZ4HPfCoduuI92YJC/GMh7uCb2K6RdZh85K9QPy4ezEJgxZFPeICAkq/r06SuQ7nvMItNZyB/I55HwY592L/C1dlKJBXNxEwr5EWsSHdeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UuFluLVHnK5onlgSAJM3DI9QjvkulSAplYcACb4ry0QnxqiCc1pdkHR6hiNglsexU04EnTVnWkF9TQny1heF7+Rfi+BEwy51u8acxp3+yQduG1WZvcW7+Zv0cE4wWr+sqaPFE5mHGZPTmVkX8VGNMzdUeknJB47L5ZKy1xOzDfrdXYn4WVKCfMWXPmGMxgs/ILtUzne3fKBgZxOGM1/cuvLKfDPLxxRgkMYkPV56dyHDfWhFsxVuXhr7F3PxoCBSFX2EGuVS5MfuIZMqnjYit1UetSLp09O3BpNv1jNRCV97u+QaiIgRTTN3HJk4jCuxWo5QZgZ03B/JqfAefnGY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUzzzppm0tR8i4D89YuYPzYsS8HSUaapnMQGRL9NYK8=;
 b=pk5rbKBrWzNPaZGBPomSFhFrsKQ6RAoJXW7KIlWeK5VaBWmlNgpUecAaodWC2OqnzVe/Gk+1Vpei8wnVBPrA8SDvEG1S/QjbB/H590q1R0ykoMfbzdJzgk3BU0leVTFGdGJkZhiR8sLpO/cOeSthS6X4ZUl4TCMHmITqfuTzc3teeBo7lfRocpwO2ei+4gfz6oNxzfEaJG3KRw4+OeM4lUhdFN+bsxRmh1I/6tBVx8x0CJGl8F2NlLJnJ9i8Vhy/Gd37RUlm+n8oL/jmBO6sc9aY5YV4E/J9BFkzMXFX65IM3lKHfn2GTgQc6xD+Kkp4VzvVK610mObgMoFKnMmBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYCP286CA0096.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b4::12)
 by PUZPR06MB5827.apcprd06.prod.outlook.com (2603:1096:301:e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from OSA0EPF000000CB.apcprd02.prod.outlook.com
 (2603:1096:400:2b4:cafe::61) by TYCP286CA0096.outlook.office365.com
 (2603:1096:400:2b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Tue,
 19 Aug 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CB.mail.protection.outlook.com (10.167.240.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:11 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1BC2C416050B;
	Tue, 19 Aug 2025 19:55:10 +0800 (CST)
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
Subject: [PATCH v8 14/15] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Tue, 19 Aug 2025 19:52:38 +0800
Message-ID: <20250819115239.4170604-15-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250819115239.4170604-1-hans.zhang@cixtech.com>
References: <20250819115239.4170604-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CB:EE_|PUZPR06MB5827:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 62a0fa84-7d5f-49f4-2490-08dddf174073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MkZvi0q9R5IHtS3qBsl4dA2I2JXjqFTg3oerBmn98ZqHs+wAsG90We2THGGY?=
 =?us-ascii?Q?hX7LY/P8EwpCDVE8WAsbraAY1YsQKVVECuHaKLiGez1JYegJO63AelC7/gxa?=
 =?us-ascii?Q?vQKMpKyabYT3d7/ZxvxQOoich2VQWkrfCoaJVt2oS76xZZcgZLipZdXqiSRk?=
 =?us-ascii?Q?wFjmf1SXCESWb5ixr79baaZnkLecymR0rrYwi2DFvyy33EBIK37newEfPyMq?=
 =?us-ascii?Q?ralRUJKJiKvoYVMpIvHTSjWvypbhGoki2iqlURaSyVhE/7vjaRagtLOKo/vH?=
 =?us-ascii?Q?eYQm3iIYkfVv4RNakJeATYarXihwJPM+IST0NgbjaQyObQxeQxfIkMoaqn2m?=
 =?us-ascii?Q?9nt51txOMHVmDjJ2XHRPp1TGzMwQvWYYDR0C3hw/wxYgOxC6b2FErme8tdXo?=
 =?us-ascii?Q?di4FQNQ0zA197fHb3dcKgsMMg67LxhNM4COugKMKbg8bgKHlVeJ4Me4BsGbT?=
 =?us-ascii?Q?fqYWz+YXCh5+VFAblPoHuXI54EQQ8OayZNJu7/SiFr6gcynf2fkpq67znzPI?=
 =?us-ascii?Q?TmJNzUJeGBHdwn89uK4ZVJ+QNbGRbC0di8DyQhlqxhbRZfB57J1eGJW2WQBN?=
 =?us-ascii?Q?qzHwhuasCqdSb8vXAPM82wSndhVGzHocorrM56ldC4rhI6ZkyVTCZFOgGTHh?=
 =?us-ascii?Q?NnkeT4GsDU33xTFrG+S94xj34yKFre2jxxdA9ZpG+7hQQxP8pBwsj+U8l9of?=
 =?us-ascii?Q?lYK1D1SmuGVwHQyaN5ofiYfNWqj1RDeLojPGXLIHqF+FeZEM2WwG61xS+Gfz?=
 =?us-ascii?Q?CbR+fd140JoyOCYm0X2OLPSU5enOPxgow3v3iOn6QVNLHqlO/jz4EhVAmNm1?=
 =?us-ascii?Q?/EzoQAUfi9pm1qAjCLp8rgg5OY9/gPv3mipbArv3YY99j6LSV9z/+d/n7vyF?=
 =?us-ascii?Q?zyMbon0YLzCMZRYMMeYhAGPqxMEipZa6WnJkQsVavnDuxWMYiNC6GI893Q9w?=
 =?us-ascii?Q?dSd+GBAcgo3cnj0v4nty3V7bH0BFGdzNgmZqcWFTdbRdde+4vRbGC3H/KGtG?=
 =?us-ascii?Q?J07ryb5N65gyzHuoO7VJoMtEvvYrTUdeKkBjvjoytQr+58YyOGVdnmuD3IDv?=
 =?us-ascii?Q?PWhN+tqDzCfnuIF7msQQIxcYl1rDwklY4pU5iSV2yYaV8owSibInfi+kilf0?=
 =?us-ascii?Q?KN3GKdidT7aTtf5BD/RLUz7JMUCx/kwTQpHFzoUBVThCoxK20+JGZR9wJht8?=
 =?us-ascii?Q?XkZ/nfdjl2wFhobpKD81mJVCkLh/L7tTeeiqsm1bZkVsMcH/3lzzqwoJp63/?=
 =?us-ascii?Q?FlNchP4RfX2oT4ia1ZMnV1btLW1SwOro1BgtjiEUJ1bnG+mqIaLqykIDfC9b?=
 =?us-ascii?Q?pJwVlGQ17GwJYlssIrKSth/9WtLJbMNYlUTKRDHz6Z9sYQRA4qcgE9x3oKuy?=
 =?us-ascii?Q?VIUkPRVCuHzeepEdp+SEucaU8mVCuJkeOmmI2wGIA9oNjbYauz2eSb7m53J4?=
 =?us-ascii?Q?uaEummWpwnEXl/sRIhvxebEd3fQlJAHe+n/IMbEiWWzs5Fcok8TFW8zTKdXW?=
 =?us-ascii?Q?zIpjxvd4CYT9FB78ocmgCQcn5SRTBF7d3isf?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:11.2941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a0fa84-7d5f-49f4-2490-08dddf174073
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CB.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5827

From: Hans Zhang <hans.zhang@cixtech.com>

Add pcie_x*_rc node to support Sky1 PCIe driver based on the
Cadence PCIe core.

Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
using the ARM GICv3.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Changes for v8:
- The rcsu register is split into two parts: rcsu_strap and rcsu_status.
---
 arch/arm64/boot/dts/cix/sky1.dtsi | 126 ++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
index 7dfe7677e649..26c325d8d934 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -288,6 +288,132 @@ mbox_ap2sfh: mailbox@80a0000 {
 			cix,mbox-dir = "tx";
 		};
 
+		pcie_x8_rc: pcie@a010000 {
+			compatible = "cix,sky1-pcie-host";
+			reg = <0x00 0x0a010000 0x00 0x10000>,
+			      <0x00 0x2c000000 0x00 0x4000000>,
+			      <0x00 0x0a000300 0x00 0x100>,
+			      <0x00 0x0a000400 0x00 0x100>,
+			      <0x00 0x60000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
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
+			      <0x00 0x0a060300 0x00 0x40>,
+			      <0x00 0x0a060400 0x00 0x40>,
+			      <0x00 0x50000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
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
+			      <0x00 0x0a0600340 0x00 0x20>,
+			      <0x00 0x0a0600440 0x00 0x20>,
+			      <0x00 0x40000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
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
+			      <0x00 0x0a060360 0x00 0x20>,
+			      <0x00 0x0a060460 0x00 0x20>,
+			      <0x00 0x30000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
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
+			      <0x00 0x0a060380 0x00 0x20>,
+			      <0x00 0x0a060480 0x00 0x20>,
+			      <0x00 0x38000000 0x00 0x00100000>;
+			reg-names = "reg", "cfg", "rcsu_strap", "rcsu_status", "msg";
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


