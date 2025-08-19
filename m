Return-Path: <linux-pci+bounces-34293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F4FB2C270
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 13:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FADA7269ED
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 11:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD802337686;
	Tue, 19 Aug 2025 11:55:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023074.outbound.protection.outlook.com [52.101.127.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205D3314B1;
	Tue, 19 Aug 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604519; cv=fail; b=tBdyBf6IiCglCd7IwM9Q6bTcwMEUs1wA6ydDh7jKIYF7H476UKAmRIlj9d4bTkbL/4RvvUlQleVs1JmFFcVmV+ne9odXFPypHy5kaY1kWOGpbxvK12z/HrX3MijDIAILRDVf770yqSwlAQ+CxxJjNhvaLYPWJRXGaPAgdwUU9c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604519; c=relaxed/simple;
	bh=r+Qkefs47oY6jF0PEqr2QE+PsGCgJIkkgwfbMofRvbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLyHwx+poVV4NFLkKtCN3O/AwthFKOkJ7V9cUyfsj6vUAVtWDtnEBh7S+xbYaIfkST9woy8bcKTHtNWlGrKUBaUp/1elSGHQh4/B4+Vp20OyapjnliksyIbynrbGGrmAp737fYOan5PQQBVoLQyS+m4xMUWQJ6zMFN2iJaV9h9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJljjfZ0KvTF15HTlQ6V/WudZc9UZk4U8T8SSTbSrh7suVFDUNb4Wo247tIad9bljkgVtSguiZpYUS9/+dUBX1PNNtSX95QzNIGHfoeDeDxmUU/iJUuzRj1WQxhNlihNc+BvwOqGnkp2EN0xtosUnabpQnXPwdGtFv/ZZ1mbELWa+6vQqlM+5STu2sPP21y0LBD9Gc4DyNpHCkKLSfrzEXGHX5ncV3Gu/iZY6GGOX5O5RaAkSS6A0/mpybXeG71RJg+sxsirSl40PYx/n0wErLpz0ruM+ddtMoc+S0gZ2Z9j4KHNR4SQ+FGSOGNOcLRLtGufdLDYyl00KOnJqoXLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+5ibsszrIdg2MynYFSRWpz2hkTGEqoGCPPfJGeKGNk=;
 b=mfz2Hdl1Mb6tP2uM93jCqm58GXlMzz/OEZ4vpVUsuiO9kj1EZ5eU+UbZp07O6R78u3FZGKKcytgHXwmogsayGhxnN5ckfm1RMoQ1EyKyKV0diWIxM5Alr868TRhGTGoNakmRwaksB7KLaVZdCiiptRSXpTXJSu/yYRj93yXl1X3PAjQOZCpSu2jrziPvdQMmhc+No/3MrW2SVPBFi+oOjRIBqCxmV1kqcjDEuDiQgs5Uj0nF5JQI0cIx0eGonjxYFlIgARw7oTibKkM0n9lk260zQFbXT659Cw+eYIY2ia9vEiRLBLEYYJ6CyugQCtHhpk7YS09IiQohmjCM2gTwvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from OS0PR01CA0037.jpnprd01.prod.outlook.com (2603:1096:604:98::8)
 by SE1PPF215029121.apcprd06.prod.outlook.com (2603:1096:108:1::40e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Tue, 19 Aug
 2025 11:55:12 +0000
Received: from OSA0EPF000000CD.apcprd02.prod.outlook.com
 (2603:1096:604:98:cafe::c) by OS0PR01CA0037.outlook.office365.com
 (2603:1096:604:98::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 11:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CD.mail.protection.outlook.com (10.167.240.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 11:55:11 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2C4254160511;
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
Subject: [PATCH v8 15/15] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Tue, 19 Aug 2025 19:52:39 +0800
Message-ID: <20250819115239.4170604-16-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CD:EE_|SE1PPF215029121:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa4c37c8-9a3a-45d0-c76d-08dddf17406f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H5trd3/VlEKQh9yHqJV8jWxU7svDLpCxSAmBlG1WjHk2F6XWlKSUUettcdga?=
 =?us-ascii?Q?E/gLCqg3/7dSKMBtWs5vhAdOYfZWejC7HPpLZJiUoDDuW8+p40C/UmadLio/?=
 =?us-ascii?Q?AlKGGlQ+3dQc/DcMrTkbxEMw6mkH0+Su7LaakmFvexa2sHjoqdp8YMLHpuPI?=
 =?us-ascii?Q?3QCG8xDFbf/CXvfcxWBuZfCAYPksHbdYrp1+ph9Lk6MmfgT0L0yCz5bZeuWw?=
 =?us-ascii?Q?xoNRaG65H4FL4dt9XjB0cpgRd2G/ufLWGcAOu414rB1UGKK0z7VBlLn+hTZP?=
 =?us-ascii?Q?piSJJD7Ku53Ro/J4lalZf62RexE11F6kRzss+BUhPGOpRZ2KweML+hLBxWpZ?=
 =?us-ascii?Q?C+iUMQn25YtZyTouTLxk3ac56HS0BMxz6imPA6hxCMpzVDxGX2KQUQfxSj6B?=
 =?us-ascii?Q?DdImds571K7tBkagnXni1z16KAiexKz40fIv6m/S97X2tKoHNHiJMIrYMSC9?=
 =?us-ascii?Q?HFgGlJnE9wj/i6j9cTzz41+ZxWKfs44IJ1+59U1Pz4wfVBE46ovELzwJDqmP?=
 =?us-ascii?Q?Ry5MGm0bl7/FgyHIWa6euJitWafHOGw54VQtMy3/DrNZCPi5cNX6dz5wBBuQ?=
 =?us-ascii?Q?PKphF0Q7c/28hDY+Hphnmrh9XN/iA0UO69hFh2PzRGs+1kpxziErfh4xQUQa?=
 =?us-ascii?Q?UPgTdcqL/MJyTe4FRHNhfpS8c07oPW8chjtxx1y/Wg14d2IjA9NngNxV3RUM?=
 =?us-ascii?Q?HtOZMJwwNmzuKeBLvLL+G0ZpioAShnh3o847rLiQhLKoAp9n0jdJ8BlLOUVC?=
 =?us-ascii?Q?WXnuwK4zzblBWPj01KWBa8HAbuGYMetCV9Ollc59TXEg3a3LsuHCeD3PxXPR?=
 =?us-ascii?Q?Leb56UprcIm8SdPA/4z4CcFaR6SkoPVcGvviw81q5iJ4/rzxOg1jLuAnXMhc?=
 =?us-ascii?Q?QxGxrCXV322bQaylr42nmpc6+RKLObGIPqCUnJnisYQL0ZK0p9NpFyn/+jB3?=
 =?us-ascii?Q?6nUxHqjiuLZy+JuFKC9XWeCVcWR+0aUeb91NN691llltjEIDRSKPBLZDW9zT?=
 =?us-ascii?Q?Udid18m2xMI8epsP8OrmwXS96crD/qwCrgd9KGdUp2iCL3LEHkShgutqdJAy?=
 =?us-ascii?Q?aZ4mxg5B4rbFl8VhScJsVT3gbFVuBwhboVi+Vs0RkgtzYthf2txluoHhrGbl?=
 =?us-ascii?Q?nnhgAwVurhn2hhOlCZwZBNmKdL9DVx15NrHBphB5G1wBcIp9kScDTl1E/wkw?=
 =?us-ascii?Q?bP8eRg774L4fYqLFhnEi0C7PLlHJ0J/+gJ8mMOnBWR1DhyPRFIWY6qMk7/Fk?=
 =?us-ascii?Q?d4GHf3JFr6CsYAra8+MaSgnbZ+BxUOkGQ4lrLKDb91AFEPtRZB5O/kvnfkNv?=
 =?us-ascii?Q?hjyDL3k5ydkGQGvsXCCL72w9AqmApTfLEus3zRD47xwL2XIyuv2QWiS9iRME?=
 =?us-ascii?Q?iHEXhVIfAabDCacA4j5f4bsX4v/J9gqjegm2/6rec6VX7oFMUB+rbhTJGmLq?=
 =?us-ascii?Q?tN2UtBLy9SpaO/ETKTiVij4T6czwSCwbex0sb3eQWnq6ht8E32oF2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:55:11.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4c37c8-9a3a-45d0-c76d-08dddf17406f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000CD.apcprd02.prod.outlook.com
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


