Return-Path: <linux-pci+bounces-31043-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F25AED351
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 06:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEEE47A431D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 04:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6702F1DDA15;
	Mon, 30 Jun 2025 04:16:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022074.outbound.protection.outlook.com [52.101.126.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1861C1F02;
	Mon, 30 Jun 2025 04:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256978; cv=fail; b=lo09ej0ZgDrS+xfOtTW8Yo4lb0Yw4gi43G8UQED2meXLc6UdY+GA19hHJsxO6oR4PBDt0axXRL7gjDM71OCSx69x5soolS+kHisgNX4liu/EmcDJJwUoek0IGi0L3pNfRgn5QEzkZPDTYP0CL1Nuda91i++RDdIeLKZ2QuPFmP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256978; c=relaxed/simple;
	bh=jL8QWrhFZcG0TeTNJuXky7/gx7CUKK2+HViwn7SWhiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIJgjtzf3YzMrjMcIBGvKXLeDmEdqow7mak0nKDH2wG0hpOfpsReNfXoG9F0B9HjTzTivLiMr4TQMOOgI7bWWvR0D09/uaPUaCI3itmHkgQRE5uTU5JBj5HbqVJt+qSumxar9lD5H2LTaqgCedYQxuRBJs3Ba1lpbch/FzWi6mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTfq8yMvAsM5gant9lptJzjYLeSdfyPpA81ojDqA97g9u1MITiyu1C7XZAxHLu6sgFDn+QEt7zDB7g3sfq1EYUV7l4o+YK2aawOO/0jrAoCq6BolzxJs865HN8mWAXRMulF8DUmdtC3juBdBytPxQeP8zfhtTgJ9Z+EYGmWhwKTIQ6PsgNPTLOHb/OquEXAXRLEVB4c4qF5ynxhuHpbNx5NkUWS8fOrvl3gq5SDSF5WuxkdvUo9Fkph3X9U2FEEHQNSNO2XdEC7PTQuIyZU4onZKs72KqH9VEEAG5xwSHjikNE8sq6uZFijhks2yY44aEEgPMpaDcWZ5r2ZI/NFtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlXtX51Rye0T7exI75JJh+af3xpLl1aUApTsZWsiYLg=;
 b=NvhD2AUbAd/B54CUGKQg8ar6JexBOPh+c7UpdoNI0BbW6wNXQ23EYaRn0CE3s9ZbQuUlKDSXSRZzTFIfsVhg061V4QKstBsGXErO39ZRTvjpKpPRWXedCIH+rQbOFgJKbcibdsem4zpmuXz5fEFcXqn+6WS0O8qzHZWOw7W2NnxAUwumeB9h5WGceKbsfq+EbFWkkPAXT/fl//8N9gLMmKsrBSd9SRejITKarsyigUXw2m896X6ppMR2dHRweWEFxVRMsqaEbiHyM9pEY9qcxYxetU6DLmHpXvBNvwQVBBP5pd2sgioHhR/Lwds4GoGDQrMWSmng/H5tmXUXikSxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0015.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::21) by
 TYZPR06MB6281.apcprd06.prod.outlook.com (2603:1096:400:425::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 04:16:11 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:140:cafe::3f) by SI2P153CA0015.outlook.office365.com
 (2603:1096:4:140::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.6 via Frontend Transport; Mon,
 30 Jun 2025 04:16:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 04:16:10 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 0B4704160505;
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
Subject: [PATCH v5 14/14] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Mon, 30 Jun 2025 12:16:01 +0800
Message-ID: <20250630041601.399921-15-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYZPR06MB6281:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51ee8e88-a233-464f-8fef-08ddb78cd811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tWUWhYLUXyr93gSt4SxdtXb7tI/iuMiLw2M0akmVOhkCawHjC8/i0VIIpv7C?=
 =?us-ascii?Q?eq/MucoijMJdW/5EitAVsOuRYxliVv0vxOfeYEVdBEcH9Fzw3FFm8l3E/S+o?=
 =?us-ascii?Q?iOICDlKVNZbp8BmIA5PGiyPVJOCPUw1jiT496VXhtFc0bLHDhSZql7Y4+g0R?=
 =?us-ascii?Q?SaloGPZuAzK+RPfARnQu4uSENdrW78heIzmMz0n/3BVX7oSTdv9tShwcP8l5?=
 =?us-ascii?Q?sbcH7Orxn9qErpm/8uGSj8yIScLzWdZ5JBIAIVZIo85lBZovym9qrvOUYyOu?=
 =?us-ascii?Q?YP1Zl1fC8SNMLZXbMHluESidAp1zaLYP/CEN7ajvtTBio9L7T+MiqrypcvOu?=
 =?us-ascii?Q?BlfCxWvr6P0v6lBj6IlO3LyDxjQB1SZF/FW9gmYNfZMG9Yxvpa9ygUvMUooq?=
 =?us-ascii?Q?guivrLK4gAOEzmbqRxp/IJJFY2vcvb4GDK/7I2InxZi7eJhiY/yeOLn+51jj?=
 =?us-ascii?Q?ciPt0h90EI6SLW1jXlKd+XgD5U1+xM43+/W+3v78j+C18Xrf7oDkSikUmN/3?=
 =?us-ascii?Q?p6AqZ64OKZ6leXuXjo2b8S4KETYAglDxJfmOuYXDF0xgaKdrD7s/ksKwZ0+C?=
 =?us-ascii?Q?dd5KnLmHdnwTC9KIEs6vgFPHUNtz1Pt9hR+Cw0jazwX2NmMGO6dPyY7dOW57?=
 =?us-ascii?Q?Tb9CHtSnU6tJzVB57CvGrjvO6EhBqhWnnE9AhgF/ia8wjIao/NNFXM2MET69?=
 =?us-ascii?Q?sr0Rjr7BTeLzaC25EjU7L2MV3mXeZn3lsFkL96LGNEEXn+9sVZoDLiih8NEj?=
 =?us-ascii?Q?rDmgPuG+wnM5i98SQ88zqEAVB3xf9j8Jp/u3CzROVIBMBAz7T4bxpkwSB9Gs?=
 =?us-ascii?Q?AsZhbB3OVWAG/IcpS4jBMoQaKRwHCP+QLBZp+k6+9Hq4b6MBXXOdb56yi8kG?=
 =?us-ascii?Q?gTf4tU3hzYSemap8l7/+Htk1TXIOP5IHFU3wVfBde4zFUfHfPUO1RdP1Nip+?=
 =?us-ascii?Q?+8qXYtxRkHTbmOL0GIOdUeeqKGVNVAGdDmUBUJfoT9baibmR6Gf5XlaDhAUx?=
 =?us-ascii?Q?Yn5z3RD5BuN/u+WgTeQ3PTjMfSpGvn7MxEJ6ePgvFPXzcVaClf/sNwHfSksR?=
 =?us-ascii?Q?62vF0KNwCll38ld711yJUjGyYpWPGZZmloX75URjbew5CpSYOFFa77ETvlTk?=
 =?us-ascii?Q?k1jZnU0mGJYPaecvG2ntPOr7DSEt+81Nt+51eGPZUqqBCh962a/S3r3bWOLr?=
 =?us-ascii?Q?saRJxJWPoaBAZpULiQ8MWb7O2c+0y4TiCJBJvXAzD6147a2P1b/LMN/zu/P7?=
 =?us-ascii?Q?3HVc8UwhHCmhfZGNH3yfOpDw1SzhRZpHRTbD0Bg1p9NFScAINuSRmokyOdEx?=
 =?us-ascii?Q?Hca9KS5AfJZT3GiMq32r14MB2EK9qLSgZ5ktsThDgTefvXcs6cHJSuQFXiyZ?=
 =?us-ascii?Q?hMCgK3QfNoefaV/gNeltc0qDIYh3ah4Lqy5FwpcEkYk3orWj/mNv3gfi9csY?=
 =?us-ascii?Q?EN0Gj3lzwP4gmUrJxb4ca8/I8yitTQGnm+VZXR4elIgIVLinJtFy8xw+rRiC?=
 =?us-ascii?Q?dHMvNsYPBHJQ3czp3LjOILHvQ3WzSULGy3I7?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:16:10.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee8e88-a233-464f-8fef-08ddb78cd811
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6281

From: Hans Zhang <hans.zhang@cixtech.com>

Add PCIe RC support on Orion O6 board.

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
Reviewed-by: Peter Chen <peter.chen@cixtech.com>
Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
---
 arch/arm64/boot/dts/cix/sky1-orion-o6.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
index d74964d53c3b..44710d54ddad 100644
--- a/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
+++ b/arch/arm64/boot/dts/cix/sky1-orion-o6.dts
@@ -37,3 +37,23 @@ linux,cma {
 &uart2 {
 	status = "okay";
 };
+
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
-- 
2.49.0


