Return-Path: <linux-pci+bounces-40633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C1C42DED
	for <lists+linux-pci@lfdr.de>; Sat, 08 Nov 2025 15:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1BC3B3E2F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Nov 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5DD23A9AD;
	Sat,  8 Nov 2025 14:03:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022141.outbound.protection.outlook.com [52.101.126.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537C21FF36;
	Sat,  8 Nov 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762610599; cv=fail; b=LiKcS0Kfu43cA7DgN5ze0QQyMa8/3XC3iYppEkyramjyeXciM279TB/NXcFs0leSSQdRDq0rZq6HSEP2bu+6eiRBVcFJ8lIHFrMzI2osQgGIUuu9xqxpUKdM+3EgAN3qU44XDbxoLlzVyfbL6JjTpq+X5LeuhmyIRP4cF21qffI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762610599; c=relaxed/simple;
	bh=X+k7Iigd2NMGn/R26vLP63F94H9w9AxUntSWq+w6fJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9mvdd5+etOopf8tQ9gHJ9Y8n8PQZEU8sNh3OJ52dh/Ca5n9+rRX4e4Z5I30v6ROcAZc8CzT0xLQzFsc1IEbCgCO3fE3wMosRwaYeNb/bTB6cLIp5WpvpgRORmqN7QCSx2RsVzCJBXYCt5zQidzQ5tHCuEM9l9IK8b0J+UqmaAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NggqGcRBshSQZkVy+dvPcq4Q2rQ4UBE1edrKfZRmyTIIIEqq13/m+X69LZgO5XLW+uNugEaZzMqRak3fFTtaObbMhyOYVYsKXPWFeM/A3sxbXlLk9wwYgO7iaasashgwON85bNea/kkx9wshC01wMUp2T7RonvrRyqAENFGTQpAL9H+tEcUY1qp6mcFs9EoNuoYjbp565Ahrxckqnq8Tzq95+Pz0tdrzqskK8OwnW5ej2rQ704FMuGnqRYECFIOzaxS9e7wuWEdBp5nqF0A81dBZydwCsdZyU1p1i4Gw0CetVTeUyIh/OgUBC3EBzHQ543z0gOKzI3eysmN7drBJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+udEMxIaEkITBc0fDjiQfdSxHcDgn+KJXyxrpbyPnU=;
 b=PvSEv3ayRRJYOUwa/zhE+KhqSPtM0P/6g1yPOXCgf/jK4bPS8Vf+3gOUuITjP2BR+ySOqmHCbtKVatJKL66ZF6g24ueg6IxtP1t+eBbxOGM2Z4VXCXbpvgV/o+aTDL3FMSFUwHEW9Sh6PkBD7bZF1T4WP1dOTrrwAEp0v7ezqDJ/GAvNAmN7pawsbecRd8Uug4pKy1QavbK0ZlkUi01U4Adn6ndG0RVprpE5NmUpjS/X/4oWR635kIRx1ND218QvVgBM8xei2qOLckq5IK68W1GEdrwGxxYaCvuW9ZnEMlHz2m+clxhAmsjGLY7E46I7XG9tO7IDDs9sI1R3e3Rm4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0070.apcprd02.prod.outlook.com (2603:1096:300:5a::34)
 by KL1PR06MB6257.apcprd06.prod.outlook.com (2603:1096:820:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Sat, 8 Nov
 2025 14:03:12 +0000
Received: from TY2PEPF0000AB89.apcprd03.prod.outlook.com
 (2603:1096:300:5a:cafe::53) by PS2PR02CA0070.outlook.office365.com
 (2603:1096:300:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.14 via Frontend Transport; Sat,
 8 Nov 2025 14:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB89.mail.protection.outlook.com (10.167.253.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sat, 8 Nov 2025 14:03:11 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 61F294143A8D;
	Sat,  8 Nov 2025 22:03:06 +0800 (CST)
From: hans.zhang@cixtech.com
To: bhelgaas@google.com,
	helgaas@kernel.org,
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
Subject: [PATCH v11 09/10] arm64: dts: cix: Add PCIe Root Complex on sky1
Date: Sat,  8 Nov 2025 22:03:04 +0800
Message-ID: <20251108140305.1120117-10-hans.zhang@cixtech.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251108140305.1120117-1-hans.zhang@cixtech.com>
References: <20251108140305.1120117-1-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB89:EE_|KL1PR06MB6257:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 74592b3a-d3e5-4ddc-bae3-08de1ecf8d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1JHrkTtjzRjBQAgAaovIqCTFTjE7WkJGLPnMbZ4Bhycalnw0G5Gb+8EIS90w?=
 =?us-ascii?Q?GS1g+/9NpdJUdwKci8xPm6TXwz6FJZOSjxc3ft/4+Z0B6SVOjymvN8rittqD?=
 =?us-ascii?Q?gXnn+Gi1U86iS+sxCLHz6KeWM21mhSK//0uuWJTxoD/TxymX+BamHV8XvVHs?=
 =?us-ascii?Q?sYrLmA7DPKZlg8n7E/AgKv0pwYLlJ7iL/6jcOiRVVzf3TYj6JcdUun2O8T1t?=
 =?us-ascii?Q?VnCm7qWsvhmMAU8tBGtG9iPnvhAQ1YW31RnNxgPO3gULWsZ1/CDclgJNvSXH?=
 =?us-ascii?Q?MJGgKyqDpqHOJv1ffCzNc2ozacxZeAxm/5vFcqGUqEUSjuFOyVBKJhvvIrcd?=
 =?us-ascii?Q?tqSL8YeAZjzmsHhjRnVAhMRJAv8QJBfAZFGIhcKbvoelLKkvn3ev0zjgF47K?=
 =?us-ascii?Q?wfKMid40MGRL6MkWjWmsS6FEe/ED+LjgPzQiuWkigJapqJVa6ba5T2qunR8T?=
 =?us-ascii?Q?79Vb0z6tb3bE0rbURt7rJTPdeu6pEO2vwlqPg0Zz4iTx/bqA/sbYgmPRDeU0?=
 =?us-ascii?Q?BE5R8YNlUNDfCojbL0X8qjUPgrI/3qTxPS6pQNMgsUW6LNBQoxZVBPHxg7Eo?=
 =?us-ascii?Q?ldKAneQrrNQqZUhbXopGKrTGy/msJhSYMYZWtQOwlZfx6Z8YM12ruWc/58tT?=
 =?us-ascii?Q?mE2YAYMYXl+rvpxbQwdxf6wbHdoe0pVv5PUOP3AJ1xZIQt0obQZslMtjvMlm?=
 =?us-ascii?Q?bwHCwAcmNG0yXE0NIKkth5jYzKzefQUZwphCTCktd2k6lC5n1E+hwuWKlN+a?=
 =?us-ascii?Q?9iLwYuBwYaVP8k3sd08eHmjQGNnSD2YYG9uBtVF/kXiKEWELNdclLgVc4HkU?=
 =?us-ascii?Q?6N8S9digM8f8Z9bT8Te77NSDDkQxfakQeEJsDM2ngYIp6I0sTEMt6j1hU9TE?=
 =?us-ascii?Q?K9B27pGUd51KpaW80ufdeWm7XXxJMNSUCLPyP7iR3+ixpmNjAmtvDegzzu3v?=
 =?us-ascii?Q?06b8nW3ydmrtro7Xlxi+wCVAWQMrgxp/uZE4hvqm1lw27iWWDDxonV4RliJL?=
 =?us-ascii?Q?pzgDdh6yAjRoGIiYQAYiZ8RXHmgz2l6M7dWm7KOh6fhajReZjcHhG/h1F/JU?=
 =?us-ascii?Q?k0EaSO4WFY3FFkOGG4LC4QwaUBEXU+RedbbAzd42z/aKxDwdKV72C7Z1ytzJ?=
 =?us-ascii?Q?gh8PfW1RA9t77In58VSpB5GWViQEX09B4Si9V5tO9FBv8+qszPefkwfn0dr+?=
 =?us-ascii?Q?bHJmjrQjbNu/tMYIJvieUrjbO9ARr2OPA1Ql7QxV5EbO5p96Lw8utLnWb1VK?=
 =?us-ascii?Q?AmF4czZVDfbK7MaFEXn8oTYelpULJcyNp1Zcvays+s9j6E/olrE6lEWkY48w?=
 =?us-ascii?Q?U29nCt8rgHBZyT4uIMeAz0mp8h2N+LVhnuZOf5h9yfgvkU2HDFXYlyw1hPaV?=
 =?us-ascii?Q?zGKoW/gb7ylMnqsZABmZTOS9Rv1rXFym4ALfp8avRsnivCq81eQAd0gj6hP8?=
 =?us-ascii?Q?RK34Ukdd4jD47VPBTCQLnPaJLkm5SHxcLzVyIgV6YMvqvLSgE30kN9dWs1ru?=
 =?us-ascii?Q?SP+exkmHWZYHQYbAfQ5gUpZqgCkYVcBoEjSP1EnDfng6JzqbYfKI9o4HEPZV?=
 =?us-ascii?Q?5wzlL1KtMKWoQSU+zJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 14:03:11.0606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74592b3a-d3e5-4ddc-bae3-08de1ecf8d6a
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB89.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6257

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
index 2fb2c99c0796..1abafbfc3c9b 100644
--- a/arch/arm64/boot/dts/cix/sky1.dtsi
+++ b/arch/arm64/boot/dts/cix/sky1.dtsi
@@ -388,6 +388,132 @@ mbox_ap2sfh: mailbox@80a0000 {
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


