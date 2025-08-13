Return-Path: <linux-pci+bounces-33907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B4B23F97
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61B57A2692
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D9D2C1594;
	Wed, 13 Aug 2025 04:27:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023072.outbound.protection.outlook.com [52.101.127.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956429E0FB;
	Wed, 13 Aug 2025 04:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755059239; cv=fail; b=ogHi42r3zqVIxAL4e9lXaQgma8MRt9U0xAuOGcSFw3RGn6O5O3E8AYWf13ROZ2Fs75xJykJzTU4uVvoc4GqL/rhB2CVZtARLKapIUFHC7wXYOVbOSl7vzT/+NqoQ5HGJWeVaM34bPm3wjmMw8NcOpWxpGkxUSgMJg1oP27Zqm6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755059239; c=relaxed/simple;
	bh=IBplVlQQ53Xq64ksjXjHMM7hCm4vHwpV1fdDDOYTQIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ehrnj0D7ns6PNSo+B7F9HD1uuRaheeenp6ud1LsweLpaTcizqXQL4wmCJDNjZDndZBPZUl4bXhqF+xXEfG3fsM9erIL+lLjebe6NJrRdlulPda9U/ScCXegOAxzwZ0e1TMAqOmZSz4NO8SX4w2o67kkEqfkR58r+JREt1vSRiz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK6L0VCLhYr+XCBaXi3VPPvybxftoautbL3+Z4CZw/qayJB5NVTYuL91uf5G5BfIwGF53Sw14tFV19Gi33BGTIp8dOQmuzV7LrXJYPcKEL1sd8PAcwL9A4MKBxBU0BndtjK8MofXoRseXPsqWhjOhAIkXTR6eH4RF26lfVNnFjDxwAbTraF3a9m5LQT2tG14iNIb7fPPR/Od0KrPW8p8iWwyYM6cXxCaTvaiJQGX+gIRpcm0XfC9ggS3XD3qYi7pU5G9boxjWDIVTfaMi1jaDQZRJcQj7D0wTJOLI6/VoIA/AChMWnakeL2oJoNeG8jgjuXJrHP2lgOytg1vW8NwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQiAcxKsQCVeNuV3UGjWqPIlgkrajnNFkHvm0zQoqtU=;
 b=gKKudZ+kHsqMEXXdIcgU+6AUuFmAmQcnfcsh7UIbF4+za/j9JUmuVP0hbONz0TbZPSvNC0xHQzeoBM+IJkBJPNXBpKRNcbH7HkcXRFE7aBs7cSLA4HekgAUAsTVnECFhX6SffA/V7Iw8QSsB1aPUCWay+ralgSCebmnhmZ4FbfHoUFxR4FsSPX3AvtP3kbiNqVUxJWm4v7AYX+ZFw0OR6HInPZGSxkyywKG4ah/ipAHgmwv1Y+i/Dh7bSTisn20KH8HGgnxxCugvtphZgDu76Tbp4fxeCgwDZGnIczVjzkY9j9nJ4cHBdaeEv3fsvU1B71huq5quPKXuMAz203QhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=cadence.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYWPR01CA0050.jpnprd01.prod.outlook.com (2603:1096:400:17f::19)
 by TY0PR06MB5834.apcprd06.prod.outlook.com (2603:1096:400:32e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 04:27:10 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:400:17f:cafe::cb) by TYWPR01CA0050.outlook.office365.com
 (2603:1096:400:17f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 04:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 04:27:09 +0000
Received: from hans.. (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D2B6A41604E9;
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
Subject: [PATCH v7 11/13] MAINTAINERS: add entry for CIX Sky1 PCIe driver
Date: Wed, 13 Aug 2025 12:23:29 +0800
Message-ID: <20250813042331.1258272-12-hans.zhang@cixtech.com>
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
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|TY0PR06MB5834:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8eb77a9f-6166-4ca0-b239-08ddda21ab39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3MEV9KRW11StQdZlUQETKlvn4QKtE9vbkbTcR1B1QNPSDBcLjVXJ5hAymcOo?=
 =?us-ascii?Q?buCqhUGn2KZud0v8MYQlJyduX0SpzCmyW+OytztNjQcWaWE6nViZ55X4meR7?=
 =?us-ascii?Q?biotIG9dao07cbEgbpKd1wn8IHDnzKpinU80JjLIZoWWvWAeUx4wPs96VQA+?=
 =?us-ascii?Q?zn/K+2P0sjEZNLNtb/SaIbBafSxiGoeQkd9kJbPd0XEQNZHXK/bDddpCdT2e?=
 =?us-ascii?Q?I/vTxkd9FueNeGoRRmm2kTdkxYJ0sCh7usig1QVTlFUH909JbupQbPBAiuYl?=
 =?us-ascii?Q?tQ7XTbQESUs9e7u1ibIRO5Mjd7wRxJ5tatGLlLrqDi0Pp4cppZHKga3gXiyi?=
 =?us-ascii?Q?vYtQE9GZg9z13y3hS5etEMvjVrpWYk7Ujq8J/tCr1FV5zh8Mao0BdFQkX1wr?=
 =?us-ascii?Q?Lq0hkJAJsuKYdsOtxSevmKWQLm/5MQcjW7dQ2J+u7gH/tv6ToqCr9YJGR/lm?=
 =?us-ascii?Q?/atpLOXXQ2kh8BRBBKimZ6JstUg9XY3vKDU9iGIXFjlRHmisaB0b/znkr1Zv?=
 =?us-ascii?Q?lvqgvB982yChfdrLvgSP2dls05sEt2w5zLn3t26BpAwz17WGBrqFosB1Ctwz?=
 =?us-ascii?Q?kYpo6tOTzA3ZvMUA8kWdTnwq3bMKrEjk0kAhWlrK5NivizD4KCQOSYrS4/Sg?=
 =?us-ascii?Q?iKVRMauz69bTQVHEsoyZZUCievQh+51Qv+dTXSgOChxUAWUelcEBYP0wyLDn?=
 =?us-ascii?Q?opv2qv9mqLU0429Kxm7WfVQUNhievv8tkrXvFzwhx69VsUaDR63cNBdCuTbg?=
 =?us-ascii?Q?z6++zaOGnf8F9ViXVsnL36htI91IQkp6dIcFSOdPBwf7qpTOzmDc7r79S9T9?=
 =?us-ascii?Q?/Qy3nY+n1BCKYDmngz3B4xZvnmtWV1rqx4GjQfOD68WdHuoZfM2o3H5LbzIc?=
 =?us-ascii?Q?WjOo1zKY3slTqje8P/flFt1SfdbLdBC4MZwtf0jFd8JXPk7ziL16ciueO7RX?=
 =?us-ascii?Q?FugBLdAVokgbdv2mGLnIv2UNnPnFa19gT4A/V1whXLp6LNa3E6GGaeDdMHWm?=
 =?us-ascii?Q?OCczJ0D1fANzqo0sqLpRUYxFpzAwuKehK6xqWpGuLAojOpwtfwHBONxcMeae?=
 =?us-ascii?Q?Q2LpY+yVJ1CZ9IYt8CntNVHANnU3FAnqzey48DAP5i4d7dH8AkR7eys8RbPB?=
 =?us-ascii?Q?P+xypBYeadDWeZZs1lwsdpxlnEZY/ItbNMhNPBecgyknJsMwyMA2ezlUL9/M?=
 =?us-ascii?Q?tXKhgQaTC5trDu2Wu6Jb2F/ALW6uq6m4UtVAJArlfpxoDtEn1jOUDCfqPb0A?=
 =?us-ascii?Q?U5Bc7c2QWSF4XDb6SCAw5An2nua3W6KkZkl3Ssj3FTyQm5PPtY6HVSUlCX56?=
 =?us-ascii?Q?E4a4mc7zlCtOZSQmZQlL5QIZ7W6tw4x3gwS0sby3vhe3smQbC3dZwJqpcqTD?=
 =?us-ascii?Q?KL2L/fHxEAuJ4X5QKpc/Q0YS9U/w+0GVbyLfwvm/tu7HlZtFY9qxQACpchto?=
 =?us-ascii?Q?C1Uu4w+6+KmdwlKgzgXbaKoNM1KzkVZDcQMmF/d4S9jDyFDbJ3mYXENvdYBQ?=
 =?us-ascii?Q?lp9wcJjg7DkNrKZVbKYdEwN+c65dLFy8weKR?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 04:27:09.5648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb77a9f-6166-4ca0-b239-08ddda21ab39
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5834

From: Hans Zhang <hans.zhang@cixtech.com>

Add myself as maintainer of Sky1 PCIe host driver

Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..d84062b632c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19253,6 +19253,13 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/pci/cdns,*
 F:	drivers/pci/controller/cadence/*cadence*
 
+PCI DRIVER FOR CIX Sky1
+M:	Hans Zhang <hans.zhang@cixtech.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
+F:	drivers/pci/controller/cadence/*sky1*
+
 PCI DRIVER FOR FREESCALE LAYERSCAPE
 M:	Minghuan Lian <minghuan.Lian@nxp.com>
 M:	Mingkai Hu <mingkai.hu@nxp.com>
-- 
2.49.0


