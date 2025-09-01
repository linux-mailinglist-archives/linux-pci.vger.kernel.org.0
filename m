Return-Path: <linux-pci+bounces-35248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6792DB3DE39
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 11:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9861887EBA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55330EF71;
	Mon,  1 Sep 2025 09:21:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023119.outbound.protection.outlook.com [52.101.127.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D630E838;
	Mon,  1 Sep 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718475; cv=fail; b=CBY50NHqfOoVxucuuDul6eyhQ8HKz2bWuXowhsAD4cSG8N+ymeZxL2bOdM8FqAjF234D6E9IXfgajAY/J0CjSEQYQYQCdsAhQFGTSEIJBdGAvoBkV0svY/j9t0o077Yj+fdJRCAwJP2FBpu7r2NPYBx0os8aBMP64l4a41yIyWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718475; c=relaxed/simple;
	bh=9KK+FebMrcQ9PwJxqrwMxmoQrowiqs1vbl3xv+Rb+Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0mUesauYH3bDCvfpQ2lVPRQ1TetmI4ph0ARgpfQ3iwHvvi4HK+GlVkh9s7DRR3JRuKeZeIZ5ASTpuipC03a9eEHIXByypmAlPUv14XhMGPyYgwfZHnTsbnj1kH1ebA3vd4EQ4M11KxH1xddFmJx5e4X8lbaZXMNUxIONxosBS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7HCnVdKLgxEcvDiYrRx6jF8tOu6aCrN/Webuir2ajDOWK90/MJrvoXhyivdXTaXiJofX0mj7SEVUZgJcR0zMbpmi34csfFpqGUlHFIyu3Gua3rrRKliXHB9mTO1YBAmnjSyh1AW86dhyaKQn2WJB1StSVQM06xtNGKI+nUBeos347/7LhdPRibnIofsvJ2NZFW7PLJk4pJeV+3JSOA9+OqE9g/RYmbijky7sqNMouK8SXxZatbbrdoKkkh9tNtD0Xsc+rhV/VG0EUql4o6kB0obR4dreO5X1cKsR3Rh2LbTmfiWmt24ZYf0YW6D5s0nvow1THh6EXrPLqxnEeoSdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElntNolIzyNwndJZoXeaYfR4YB8bX6LoTFozl0leLhs=;
 b=jgLGM439jRMq8TdjXgo6ZLJnT/+du6BKdnhhlnO5PxkG8NxgMcmZVfsZDZ6IlzmWsEO3C0SKUBCy4j0Que7aG/UbtrEHvXyyEJwnklQvXr7tDQzEc0DYP5PlpZ88xivh8orSRtD7YWgsg7Ds0S+JIQrxw3xnkEvJC+xR4iKCZFtDXSORmW4w8Vi8EiPpLCVO0g1utmnC59Voy52QBLwHUnhALdqkqFHpAyXUtaSEI43dkoRTPmnZLLrTeQ0Rw+DZqr2KF0qP42+jdmNhezqvY2XPNB4uWv7tmO7jFwtdw382PbwcE2qJIvXfPRRHeUDujOXY9ieH9K4WT8Xflnjg/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SL2P216CA0077.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::10) by
 PUZPR06MB6148.apcprd06.prod.outlook.com (2603:1096:301:11d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Mon, 1 Sep 2025 09:21:09 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:101:2:cafe::94) by SL2P216CA0077.outlook.office365.com
 (2603:1096:101:2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 09:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 09:21:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 871F741604EF;
	Mon,  1 Sep 2025 17:21:05 +0800 (CST)
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
Subject: [PATCH v9 13/14] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Mon,  1 Sep 2025 17:20:51 +0800
Message-ID: <20250901092052.4051018-14-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250901092052.4051018-1-hans.zhang@cixtech.com>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|PUZPR06MB6148:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ee339c8-c325-4947-77f6-08dde938e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7BzNQ3gACebuQoaZYPblaXMD9T7rVfxmWVRAfTy+L+/TvKnLSWD9SFSDlrFn?=
 =?us-ascii?Q?9Z6poda45x0rLTPlXppLj0MUlom96l2ZUTgGxwiBVnq+PUnHLacAUYxZTa3t?=
 =?us-ascii?Q?rj9013JU85dX6gdkTDDam1qndZuua7lD4inaO7qvN1+jE3fCW8o8v0EBAkO6?=
 =?us-ascii?Q?/+bVR8R4Bn5lPbnFQu5EUMz+vjn+KIXe5WUWvhtXZn3HQiPxJNaj4x5iwW+Y?=
 =?us-ascii?Q?AahvUl3yIe4m0rjA35vJ4nZSeUzKxDI8UQXSeVc8oaRiSJAtULca5V35/fwW?=
 =?us-ascii?Q?54aAHPFyMCOu+qwOVNinFwkRkURZN0I/qlFDQPC/tTznswuc7dc3mr2n556O?=
 =?us-ascii?Q?nplgZvBdh33UMJgwvAREKeHKniPch0hFghaaUwUYO+3Q/lLzthwfWkUPn6ig?=
 =?us-ascii?Q?A5Wm0zMfO1HZ/if0AOS2JQpbVb2SjKJkslHdDQjE31Vw9wLEdHA5MS/8oKE7?=
 =?us-ascii?Q?xjfaR5RCXmS91CgtQigbcsa6LYbBzEmY3YprgQ2v4/hWdJDvFcne7X4D/PKm?=
 =?us-ascii?Q?U/ot+AvUub4I2j/5RnmPScoJudJhnByx068EP5s4c/dJRsJ8UuvdY5PBoe6X?=
 =?us-ascii?Q?Tnmv7M7xhClMShMPE0oqMYVcrqFtmivD3izbavb8SJIYwytu2R+gliG9tvNy?=
 =?us-ascii?Q?7B2sg8IQvGURI6qB5PzGA5KSlt54lbWweUUTvhmYSUrB58vE1/5L7E28rEUT?=
 =?us-ascii?Q?yNwWYUbZpxfkwgIYf1Z4tPaBM01JIXG8vquL9wscnM+nBD4YZ1Fz177maEqj?=
 =?us-ascii?Q?hJvL9fD0H5XNoZ2XPRVuU3W9732Gb/dKUc1MfXZhaGxToj1/cB0wjN92jVY9?=
 =?us-ascii?Q?ykZw/LKQwGE4mSbZJAeCXuSW40wtriFnecyOCrYPZDVAK9Eq68YTGp1quqnI?=
 =?us-ascii?Q?hSQwV7GAAGOF1BCc1JzYXATtXUu8ydY58WCwL+/lr6KGg0K4ip5/291XpxcK?=
 =?us-ascii?Q?PooqaFuiOT1UTBAQ6BTcp/L91HthV5iAxxkoufGjrNKztzVL6PcY6wlR9Zhu?=
 =?us-ascii?Q?XpC0TIgb99qabRnL2MuAUtDvN5ZV0j4aM1VrPVaj7QEx4PNWmBRshJlaj8s2?=
 =?us-ascii?Q?gEOwsQlvUUXIcsjNxO6ACe9DTvExY9FwmFfqsVzI0F12J1ZpIvDUfwyNttmT?=
 =?us-ascii?Q?xblsJqYjpqYunMB1LuqqYxs4kxcBUzSEoS6IJDkFMhKf/uXjLxkRasbtccHL?=
 =?us-ascii?Q?ePyScF3HD0EX0veyIy/BYy8ARdksoyolk/5+H8YK9duEEwOmTGLzSdkI7kqU?=
 =?us-ascii?Q?zxON3qpjeMdo0LBHj72u/4K5jdui9BA1RKJNWBHd4+6rp7Oq8OGgMqxTvIlO?=
 =?us-ascii?Q?DvXprlcdRoxw3zuE7WqAufwAChfXHL9n9MxksXbKZHRNptl2rPVC7IfW/60Q?=
 =?us-ascii?Q?LSw9HdnZCouX4KL5vj90JcnswRjXGz1UMwqRvFJCwoATcvQey5FV6+18tgFK?=
 =?us-ascii?Q?PPWUve9SzQYX6ChzeiesYHkBgJFdPVODS1XIDRzEaeCC6k7LibaojB77i30U?=
 =?us-ascii?Q?rQs3Jx8KHvlV3zTt1xDqZzzwkgnl5JZ5tj/H?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 09:21:09.5488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee339c8-c325-4947-77f6-08dde938e354
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6148

From: Hans Zhang <hans.zhang@cixtech.com>

Add pcie_x*_rc node to support Sky1 PCIe driver based on the
Cadence PCIe core.

Supports Gen1/Gen2/Gen3/Gen4, 1/2/4/8 lane, MSI/MSI-x interrupts
using the ARM GICv3.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
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


