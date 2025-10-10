Return-Path: <linux-pci+bounces-37797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3998BCC11F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9041A42608E
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60497285069;
	Fri, 10 Oct 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dFGi0pBN"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7C72836B1;
	Fri, 10 Oct 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083445; cv=fail; b=LQAL6f46fr1Wi4Aa4ahel2PGd979X54tGIVFlLQ/RxNS5tkNXne6JFzCcGUlV1zLgkD79hQlbz6QaOmod7qwK8flf6juW5+FgB0G5ubhoobHZwy43GKUsz88qsjUHz9yAHRKUiMYEetWVBhFy2znzExe+PJKvhfWXwptX4oZVCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083445; c=relaxed/simple;
	bh=Q1IvtBInZcWICb+jmlGGEHaEPdjMGjCUM33ov4I2fL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cdjdKqZSrjjzc8juXrV3ONl3H430c8focg2iQ3gg1HyQ9ZLAmfSNka7afSLwUXoUHudOvuybmtdIqTOT1hHkVgSiqT9+D5cTp0RbV4IF2g4Trk8HQK9rNkPxv1PG+UPoyblAEY/xjnzY1Xsee1G4EKOaRDybp6oUbNLJpANKaiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dFGi0pBN; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJJTQeo9a6/vRmCvrAE00B4PIGeUQ3h8pP4TD8bRW7wCX7sMq++lcEMT3KdKydwD0+4veP3X4xFOZKRuSv/83PteIex6zbngQOGypaYKDe257DbXd7tBEPP2iifz6QxaeVgejKn04D35cYWmwN4DlOXwMJzcdk2kwDAt1zIwHoRqXWtren34WC+mcIDzNS/nfnJD+J12jJACuMQVhtln6tPB90QCMWrptOh4UybNLcEv4xAFF+Cd5T7IqADBICmAcHnsqSNWgPuKYcERG1Cw+EhddeS3Uw2lJcshBz21mYn8+tsQVFGcU3z9MJqZXpMPzT8HpNRjMUW9kiEBsgag1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLtMwY92dw1xgQ0tb41bxcj1i58Kz4RRWOTUn9i3N7Y=;
 b=Bh7ETbpuWGoK94UcgH1ERiot+PmzZq1Jhcje6+XFa3as/LXmAGOnLPCXS5aM3Z2w2V/w94w3J2v/FT95FRycnfgNA8rdds7Nc1ZJhoBz4mWT3K4CdxPyocsUv8U3bannDq2hFYJV8lQNrm/gMpfk6lvtEWDDqX7awoJAJX+uq+vBviOnXsuNPQYnourQDkuV/KtLJvqIbn90o6rsZWN/H4e1UCapl4uxWSI4tWD4Cew5WiaZgUjmQwPWEbDq3Gw67SjpsOvcPGQ/izW04kH/SaYTMpi1QkjsuTeEQ6pm95nHYdbyYyVEO1iRImH4rQE0CKrKexegj7JPq6yw0DoTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLtMwY92dw1xgQ0tb41bxcj1i58Kz4RRWOTUn9i3N7Y=;
 b=dFGi0pBNRi7mMwsPdKnf9F+nx4JfNR4+N4IkecVUNz0ulhlltgMYRFgAMxVgTRUbT+3wEhNqV31npqetJNqHAip2dtZeKrbHync+7o4WYAv1trQXeLY2hkutICVnKldOBgoxCoBFteD+EAWHUyP/WMoYF1/dkoYpioneM42xGAKfVDLE8O8gcmHjw+aeg1tAezeY3+4prr7QiqbUYAxOfcPQmePTpX4+6MpeRZS0qn2hU2O6C2vonQnU+fPVAFWs2wqr0uPHyUykn0NgXnlxkjo+PgpUC3D9RNcVEc8ZVLX+dqqkv54X9Wm61dX3s/eQx8axQb+3KWsh1sLu2nQbmA==
Received: from SJ0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:a03:333::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 08:03:57 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::4e) by SJ0PR03CA0105.outlook.office365.com
 (2603:10b6:a03:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 08:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 10 Oct
 2025 01:03:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:44 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:43 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>
Subject: [RFC 6/6] [!UPSTREAM] nova-core: test configuration routine.
Date: Fri, 10 Oct 2025 08:03:30 +0000
Message-ID: <20251010080330.183559-7-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251010080330.183559-1-zhiw@nvidia.com>
References: <20251010080330.183559-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0c8f16-1326-4388-0aec-08de07d3904e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oqpt3Y4ynSQXhoaFli+42jDGZxVuBQWE4rzU/8XLdXriAEpFXeazhsjwPszT?=
 =?us-ascii?Q?BrIzv+zwnmcjzzM5AmjzX9a4JVoOeRxX27WPjOqGliPQCAx3pe7j1By+sjny?=
 =?us-ascii?Q?Cg+KVA4xA1LWCjRf/q3vdKjseakMH1B2WLfdSNf9xPzfIMvQmfzi2cFYectR?=
 =?us-ascii?Q?TmgShbefybXtrLKCR/VTtgVZXYveEoIbmV+n0dUM47YeNwcanANtEAJOMUWP?=
 =?us-ascii?Q?JHHACbVR2cm2XE/CSG188DtvUYy2kmVoKctJPmjTJFePgaSVZIBPo1J4VC0s?=
 =?us-ascii?Q?Q5dMQavRHDqBD5fxdzVnOsTaguuI635dLhrW189wUC8BOENUFAlSn1GZ0xcZ?=
 =?us-ascii?Q?iQcxh32S4v17/RVMmxVWmouS9yAZd1ohqYrQQbfpwyFlstOSlsd1Q+uxlU9j?=
 =?us-ascii?Q?3OmG+AiLC+fjc90DfSXGBxAR3s6bIAICs3hD/7/V8u58iECr68KATNPk66QV?=
 =?us-ascii?Q?x5NzMsyGiGTlDd0UEi7Hi7wpWJxZo8FE4ZPYa2lm0EfQ5eXhYISkIpK/ZUEG?=
 =?us-ascii?Q?VyOWKQC1cZfkmF0JngYXgJR2Ij1iDreKrerNUdiLj2oL1f6qMfD+0UPKMl9A?=
 =?us-ascii?Q?QcZ9xLBjBY37jg4KawzIF94H6d5c/uFSaVizBR7QIEWnWoSxBRK/WfVCGz2r?=
 =?us-ascii?Q?G2GT+7KU0lpdp7UMbnN+idAPZa4AptA/A5GKttOASLBJfSMiSichp2oEl18H?=
 =?us-ascii?Q?l90ZJtQ8jWfUWiFoIXcvSpDNJ7Dze0GT+mv4xciCEyBMpgOLkk6nXOQag5FZ?=
 =?us-ascii?Q?rkkUI2o8lOC8krdllMkZvdWLLANSI8wTk+fWGdRUtkD9Imr9EnaQH1x804zv?=
 =?us-ascii?Q?gt66wJMKZc+tCO1m4d/CzrQnVNwA+Y+jCX3ZgW08jejNYNeBhg8e1MNSWeIa?=
 =?us-ascii?Q?m5OSMCQf7Mb29557omz+GfMJC7gvfLK8PMBSJ/3gjKioFgIPDYaa9QpIMVyn?=
 =?us-ascii?Q?n/Xx6vXY8oGQZo6u950us+R8onEOKbq+mEtCE3tVtkQxl2/lhiTSIbwboEdV?=
 =?us-ascii?Q?dMIZ1N6RPxyiJo+EDrwNu4jvHfc1SNNYYDF7v01soL9v/HqXQE+TRxvaF7nA?=
 =?us-ascii?Q?fQT13gPsvmofi6Bj24GXfrwsI5sN4Y4aGCFC476O8qxSr92TcuMWNzKlogLi?=
 =?us-ascii?Q?8fzZwEWtGU4SG1mPYsw3LcZV+udn3dp+ATNRUzRiadIzE81zqhi44F7mHSI+?=
 =?us-ascii?Q?7kKgoqVta5sG/Dn4EcFPBSNMIDsPY7vLWf0W/lmZI61KVntp5EjqLhkd0cwo?=
 =?us-ascii?Q?oPK6VUog8x4Xrm4/Jk+tapitk4+Qc7KDJXwXQrCJvl0EA2Vl2cD6A3FQIWpr?=
 =?us-ascii?Q?efhwepsQHbqyC1czxw0oX7Y5u8STaKw17vak/T5d/kKLvRVl6FVXDOjLhT3r?=
 =?us-ascii?Q?CCxuXmiwf4XjcjUXiIhcTDj8BbX/BDWizCEgkZ0r/nzATrXLoR5eaEtPwHDW?=
 =?us-ascii?Q?1a8voMVVjAPGF+VByCKtlbDYYZ8q/zDae1WlFJnrgAzp9YjG2Q2xcfgX4kLz?=
 =?us-ascii?Q?LNVv3Y7T+Reh6qIGm5le8/knBUAevMql3CYkgl8ipP9BeRL5Psq6m2jq/NgL?=
 =?us-ascii?Q?0ZrLaGEFEgrxKSxkurM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:57.2653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0c8f16-1326-4388-0aec-08de07d3904e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 1380b47617f7..605d9146113c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -44,6 +44,10 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self
         let bar_clone = Arc::clone(&devres_bar);
         let bar = bar_clone.access(pdev.as_ref())?;
 
+        let config = pci::ConfigSpace::<{bindings::PCI_CFG_SPACE_EXP_SIZE as usize}>::new(pdev)?;
+
+        dev_info!(pdev.as_ref(), "Nova Core GPU driver read pci {:x}.\n", config.read16(0));
+
         let this = KBox::pin_init(
             try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, devres_bar, bar),
-- 
2.47.3


