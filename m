Return-Path: <linux-pci+bounces-33906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7458CB23F94
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A19F4E32BE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B209E2C08DA;
	Wed, 13 Aug 2025 04:27:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023104.outbound.protection.outlook.com [40.107.44.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FE2BE640;
	Wed, 13 Aug 2025 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059238; cv=fail; b=lYnn6nbP6aeER/QujQMU8FgpNxYvGyZomNxFmbGvpbnFdL5PyhzPTQ4T9qJU+kq0DXGW98PoGrJzb6X/fP1TqMJSzXxxGT45fEdtnoR4lzWHNUpH2c11omxAu8FepC2YgvlpU1CnTE7bxnCbm9EeXN1eVwN5hCMyLobNbLo6I50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059238; c=relaxed/simple;
	bh=r+Qkefs47oY6jF0PEqr2QE+PsGCgJIkkgwfbMofRvbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M+QUrgwBEYeyxbHfwudMNIJ2sMCgZ7mqKFA0nDVG74Fjv24x68zduApQ6138Y2VfSFngCY0EXcAVxOozK83qNCXsZHi1mOSf/55MnoXrf/ZJw+6vCjc0AlCz3naA89ijN3cpxsJTtrleHvDmEd397X2z/GfTrrqfpSDqQMYL6wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.44.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEaVfVf08/pSq39p1LtrC/W+0+ORF+XTc2/A3F0umvaVuFqmaI8BmXzGxVL//9p/aa3RMLI2VM88PxrnJbf6REWSC7RHSo8cNnI1u0ELpU3mi1NytQMm5EgAlooQzWk/b5v4M3gtMb1/COqeDguwjwSKHXk6Hj1OcboG+QoCyKKGODIkdkpLWphWdMv1bQo6boeZ1wT/MeIzWRNXUAgUPKWv19Cuflyr/1EuQk03Nh1wEv9jkJCQtrBZ/fxEFv6xX4R4SSyFXGxY5rOA/XKRNMXiA0p9x55qYiJhEa5xPZ6alvLLFvsv0dc9pPW1NGQNwPIaqewUZICYAbVF8PAGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+5ibsszrIdg2MynYFSRWpz2hkTGEqoGCPPfJGeKGNk=;
 b=nloKpCtJ57rid0ZKoPF5omp36eS+MYyaVi/LsfpXC9H66MiMzgcGVFylzHdhIoW2rTBjW+lLNxXEcYOrN+Hb51VywG2Plrl5kswr05axA22nVHXeLGFNaqb3vHhOA8UfKWvJsimJznWrL/2dVN5nUNMIvAALZ8/zBGx2XZHsHTgjYSJ1M/GGz9d2VxY4q3jstr5p2RsXeIzQtwiqQVy1IhGXjkqCbi3dKXa2p2QiPYYqYDHJuHKOEpaESZNSNEl71yKHk+XT7vSQWPm/qeUzdS7kF+FqwStHY96zFnU3PN8mi89R05FySG3znNp4R3bBRAOhge4j0Ypmid0Gh2qwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR03CA0087.apcprd03.prod.outlook.com (2603:1096:4:7c::15) by
 SE1PPF215029121.apcprd06.prod.outlook.com (2603:1096:108:1::40e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 13 Aug
 2025 04:27:11 +0000
Received: from SG1PEPF000082E2.apcprd02.prod.outlook.com
 (2603:1096:4:7c:cafe::b5) by SG2PR03CA0087.outlook.office365.com
 (2603:1096:4:7c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E2.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id DCF2141604EB;
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
Subject: [PATCH v7 13/13] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Wed, 13 Aug 2025 12:23:31 +0800
Message-ID: <20250813042331.1258272-14-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E2:EE_|SE1PPF215029121:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 86611f47-5c25-4e9c-9d0a-08ddda21ab43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lp5/uYNXUVBL/t3kxlwocgEV8le8xyHlkWKITu89j+s+rKkDhGm49VtkVLu1?=
 =?us-ascii?Q?SpjXmeYm+O3ODieELwSmS+66BQJgSZOJUr9wtBR1rk6UwbHwRd8np3dLoZnn?=
 =?us-ascii?Q?Vq6aqlYvQqMsmRh5dOGhIaa91zWqLz81zip9nHm5COg/w9xVYHrb1P1xhXhx?=
 =?us-ascii?Q?p6oGpzBaAY6EliW00tU4fxFvGJGEwP+p/i7oWc3x+BKYCJO1wP+8Ue2VCybx?=
 =?us-ascii?Q?hDJtaEYNGjS3Ue2x1mNKP3WdFv+rAwe1aFbmeOWN7VYIOS30fMLdst6h+4zt?=
 =?us-ascii?Q?2KL7CLeQ4iZ0WrVAWLPcpN9Q8EpbQBYFNObbnECJ6qb9gBr2da+e0VcXHHRV?=
 =?us-ascii?Q?vpx5Z/LsaG3E31qsZTx+85+PXk/UDeEBJZ/Aa09VbUiTxbJBL8oXFnt5CfFr?=
 =?us-ascii?Q?aKwkKCl4h9tWIEwCwA0Ljsa5r2kFNhAO9TKIoKmIQklQ/DWLe6WxzgW2K4fY?=
 =?us-ascii?Q?gpn2VrDo5eX0b5+9HUjdGwUQBRYd949Ig6f50tRreFTT0G3Qzz7C2PjvyHDJ?=
 =?us-ascii?Q?UVDkYXUPGdAvGujTmF3fiDBt877LBTt2pfW/kHgAdlNJGbNquqdJ/Q1AknF9?=
 =?us-ascii?Q?Cdo+cIFE9LimHKwTLxePSUSiw8pBjI46fQABbgb05oZQn7Bm1ecGYaGbELfc?=
 =?us-ascii?Q?UjAKA1xPbEi8KVS5cMWVd+4s5iLENsYc74iPK5nE32PtUR6h8Ls9BQgBQzAR?=
 =?us-ascii?Q?P+HCTVALCIesys1iY3Z224/I6ZRx+2DSbLLhI/QcROOrDxIBXH9WfeFNUypw?=
 =?us-ascii?Q?0tWG1sYAhwvbcldI//77A5eWG5OWxa2oVkKrsGUmJV4tsRnxVm0jGXdRcMHa?=
 =?us-ascii?Q?3vtlVRMCAV3KWbXUE4T0HpHT7T2toP6D0pfzASUEU58PYZYqgSbo4CJLX9CU?=
 =?us-ascii?Q?SM6g5Q5B8o/90spi7v60rBntzQjEwDRj3nH/f1aaaEbzFAPvshOeGrVYUqGG?=
 =?us-ascii?Q?SWNPLnc0RMd0PSjsyAhr1IMO1u3VuJufqG80BmqkJURGPjScSUOaFRy04gMv?=
 =?us-ascii?Q?rKV3igaHChuXnI/Ip+S3/3a4wv9WcbvvMm5R4LTHz+YHFf8Pc754u1rGrKDb?=
 =?us-ascii?Q?ua1A5IxD9z6Rgsx9b2K4JT1pG/hD5pfg4iU/t9ZgJzPKKXocQKhS8aWR7MCy?=
 =?us-ascii?Q?pDIgszyAOUMRtZQdjgV+uI7ihq0kv2lycWQo8mEDPrlv2jISSeLyjfQMAsqN?=
 =?us-ascii?Q?XL2I//6GLjzxOb6zuB8cVbYY3PtZqrLKT9ekJLvGimJjC2F4UcDbYq35NtQn?=
 =?us-ascii?Q?yVDr2cRDc+M4ikhHcz/2U4rr99H2Oa39OgZd7WTb8wBJDvkwSlRcXp4LCVgN?=
 =?us-ascii?Q?Xmm3YHERef5RW4h/cVgn7Eyi4SIki8MBA9Fu3g0ogbN+lvB0GbOLZJXzd+IQ?=
 =?us-ascii?Q?w0llogHw+ppAFIxNEOzawRnG//20BdTKa/EOfoosIvB4JDPQTwD+cexk7xyt?=
 =?us-ascii?Q?oPMCpC+USx1LGZBm3cSeAD53kkV50gGEogjP6OZnwDMVGNgjvsHSFIcJEzkS?=
 =?us-ascii?Q?9c7SQsrQJmq2JAA0VQSMo920++Hes8c1HnEd?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:09.6742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86611f47-5c25-4e9c-9d0a-08ddda21ab43
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF215029121

From: Hans Zhang <hans.zhang@cixtech.com>

Add PCIe RC support on Orion O6 board.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
Dear Krzysztof,

Due to the fact that the GPIO, PINCTRL and other modules of our platform are
not yet ready for upstream. Attributes that PCIe depends on, such as reset-gpios
and pinctrl*, have not been added for the time being. It will be added gradually
in the future.

The following are Arnd's previous comments. We can go to upsteam separately.
https://lore.kernel.org/all/422deb4d-db29-48c1-b0c9-7915951df500@app.fastmail.com/
---
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
index d74964d53c3b..be3ec4f5d11e 100644
--- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -34,6 +34,26 @@ linux,cma {
 
 };
 
+&pcie_x8_rc {
+	status = "okay";
+};
+
+&pcie_x4_rc {
+	status = "okay";
+};
+
+&pcie_x2_rc {
+	status = "okay";
+};
+
+&pcie_x1_0_rc {
+	status = "okay";
+};
+
+&pcie_x1_1_rc {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.49.0


