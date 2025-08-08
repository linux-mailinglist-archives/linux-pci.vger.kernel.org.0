Return-Path: <linux-pci+bounces-33608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF9B1E390
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A0D16679C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552CB274FD7;
	Fri,  8 Aug 2025 07:29:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2554723C4FC;
	Fri,  8 Aug 2025 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638184; cv=fail; b=TAjyQRmbUTx/IZQN/zsSrjM1gzA4vDNffP5iKUVEIWspG7x7MUDN3t/HydNPT+u5BvL+AR/hJuMquDe9jW0m4nFIWd2YGviNOfkO7FfuEYp60ao5ELJvr44IdtUidERm74Vmagxqbx6PXw2+AWjgoXDQTF6E/IkfdK2HzxbHUs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638184; c=relaxed/simple;
	bh=r+Qkefs47oY6jF0PEqr2QE+PsGCgJIkkgwfbMofRvbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQptFq6SAdG4xkuou2veWf//Cg4mVZ4WCHnLiOg7WIBXWvbeWDha9Jpcck5Yz09nB2U1k/VAba5t+BDZk9o/XCRyz8GsioHH+anr91Y1VQdLRqW8Jd7jYuEHrETqnrF1sKdORoZ8s8JSYYYY5s53pe2RjsZkk5VjmRkDun9fwuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eker2cvojW5An/e3aYoALn3PCbpj842QLnxOGLp/hQ6HoJhEfMA+gY3qOR5rdAKqkd+WKDlJ+EOyv51yOkZ040WQ720CGhODMn5NsrIJGDDfhhc6Ez0xLSh0ZrIScpO2gIEJ22v0xhq0OENG/U2lcGIOjFw1ga8ljqZdRVcuVZR8EH/bAUeqBTh6ZLSSLl0oY4EP/VuJ2Pnu5NaswSL7vFti8BnzzvurfRklm0fjInWj03kI0G/mdf9FuVFLLRecxkasel6hjVDRNUtCiEE1EpJDEqxrYQW+RLl8VqxL5i9L7GOWG0YFTuEepO/ibKR61h0uqVPW7VurNZ8CweAX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+5ibsszrIdg2MynYFSRWpz2hkTGEqoGCPPfJGeKGNk=;
 b=Xhl9Kfc2uC3yxihlojRBQU1Tu50ShDZdzDu08aVryegXcn/X0lgbarcvXu02+3Bqe0B7lXu1N5a8tz54pvidCKCoR93hmKS6q0nCBCm93QWfFB++NOtPH41T0igI96x1CgRX13aarkeycVLyqFVFdeVW0s0KN4qbEJS0/0009qteegbGeQIjVYmz8MwkaApmkqYuiNZd/SsML1zwBDJ1J3dQZQgsZpFkLAYKspcjFObes+piKxroD1G2Tlzc34bS9o5iHgbRJm934aEjGsldUZ3IWRGGvPsqa1L4KaGDghDgozrJpWA7woD/eZE3mXZcsu8lGvi2YbIX/fCU5GlUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7) by
 TYZPR06MB6914.apcprd06.prod.outlook.com (2603:1096:405:41::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.15; Fri, 8 Aug 2025 07:29:38 +0000
Received: from SG1PEPF000082E8.apcprd02.prod.outlook.com
 (2603:1096:4:140:cafe::d5) by SI2P153CA0001.outlook.office365.com
 (2603:1096:4:140::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.9 via Frontend Transport; Fri, 8
 Aug 2025 07:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E8.mail.protection.outlook.com (10.167.240.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 07:29:36 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id AAE9F4160511;
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
Subject: [PATCH v6 12/12] arm64: dts: cix: Enable PCIe on the Orion O6 board
Date: Fri,  8 Aug 2025 15:29:29 +0800
Message-ID: <20250808072929.4090694-13-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E8:EE_|TYZPR06MB6914:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fccb934d-03f4-4614-5c0b-08ddd64d5430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c9HPCUoYmIMdzr/E0ep7ItL0yh6PeoVQrt2Y+kduHz0eIhNjMAh1kuNDrY/1?=
 =?us-ascii?Q?lelv0E3JU3+81BTl2I0CQK7zOQEPt7OIBQlhbECKd2XKyT/r+UNoOLs/eaQV?=
 =?us-ascii?Q?Ksd7C9j1AvicJmmnknWVo7LNjD51SVKxtpGIJou2GcDX6zvZma2nG4Zkn+ZJ?=
 =?us-ascii?Q?iow5HE0oKfyd17LSFPW6zFGdBW4j0MkQgtXA863d6FKEerAXVqU1kvy6vsnh?=
 =?us-ascii?Q?Tk5THiJKqCyQQm4koVZmX0gaK1ez4irdDFh9t8Ij7z9xEEk5X1VR8mRRhHxa?=
 =?us-ascii?Q?Zwq1FdUjXDehsNcWQ3wDFfCLoeQ07GOlKbGwHuloSDvGKSLj0mCisXudjqko?=
 =?us-ascii?Q?SOT2b+XU2tdn4AP9MY7oQBEh/A3BZLovYP0XasYpP0ThbR1kwCndbc3PNxNU?=
 =?us-ascii?Q?UyFVaZep+NB8uZmwlACEvRgffKbwabX1AwOb65KJVFMYBwnq21PJMKIxGbID?=
 =?us-ascii?Q?O/5EIDQBqnZs3Syz9DwNAZd8yUFkJVs2t8u5UcYNK6x3I8U71nBX7bpAB/Cp?=
 =?us-ascii?Q?4sP0tlhB6pFmi88u1t57UVo5KaDn1oMrruja+LpYm1KUy5M94v8/J9E45s8z?=
 =?us-ascii?Q?4XgjX1tt8AW3+mVdTLe7/2zFPFzozeiyrAjahAK9aCcofT02Pf2xoOpTCsLm?=
 =?us-ascii?Q?NaeNMPaMmBszxzEfSvrcWcboIHehEa1shtFZG37pGRcbDnD3aqC23urz60Ub?=
 =?us-ascii?Q?TjsDas1BApAgVi7xy/d5qvsdG5OsgRjX1/Z0qShwjymShfMcoaJRKMtc5cFQ?=
 =?us-ascii?Q?uGQrbSsOfTwx8zoWbXbiki+JBzDkK++RP5Kp7lYnksUQJWDox4t24VH6L2WZ?=
 =?us-ascii?Q?4bIw7Uw+7SG+eB31aLPv/fjZ+cdb98l84xFULb5g3X9XkYppwoz+eIqn8WDW?=
 =?us-ascii?Q?f+C5kQgWkYw6hS5sIFCwJ6b39WbYv9n0l+Xp8FDIz7rW4iVcpMFlcWs9lnsp?=
 =?us-ascii?Q?AHC3/Hx8Yo1kNVLWVOF2xYCrW9k2fHTlFcl20L3ylrtbR5FPDMmnh4p0O54F?=
 =?us-ascii?Q?K/vZ+gUh5EkLM53cMWM80TUsTZW4Sv+xEmLPUau8D3rdkvym2p54c0tPjYjw?=
 =?us-ascii?Q?tdilTLTlJb151xm/XQEzFPUkyLfUzU/zA3oRuOCGFrWmUxzXVZnRTlma9uEc?=
 =?us-ascii?Q?uUzY9BIKyboaB06GFgABFf25N2Shto0QaNi8vFShG+lqlplTyXfMUiIA/7BI?=
 =?us-ascii?Q?pBkHbCjrv95luFaKYYcQEIu+5/XdBspipTxoTD8R5WtOM+sjpB7oCGOXdM4J?=
 =?us-ascii?Q?wyotAYnWDWVbwcFcLatHKr2yIxvcSdnhBONxEj0NNydKeirJsp0UGfImn3Ob?=
 =?us-ascii?Q?hVdg+pUp0xciPsBLP+j5zmbKN1ZxYWLg6Bfz5jBDQOe7gDE2DoSsVnGvEqSw?=
 =?us-ascii?Q?+4V7Vq9mzAqrfCN+u6tgadXrGvzrKAP/OvsoKmAZ4EjqW9nQ1xKQCG7mFzZ/?=
 =?us-ascii?Q?beQtHkZd22maQAGbaadb6YIXNJAnsXZQJKiwX2M6OwNfUd5lXDZNPX10qIjr?=
 =?us-ascii?Q?CgRF3eyg7Ly5ZKwQ5uM+kIwUYhdEhnD69p4D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 07:29:36.2956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fccb934d-03f4-4614-5c0b-08ddd64d5430
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E8.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6914

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


