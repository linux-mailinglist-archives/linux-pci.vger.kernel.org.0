Return-Path: <linux-pci+bounces-42722-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCDDCAA64B
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E532C3011AB1
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836C2F549C;
	Sat,  6 Dec 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dwpmSx1V"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E69252900;
	Sat,  6 Dec 2025 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024947; cv=fail; b=O0lpoC0lBZITgmGdmMcgHT1h9n6gqw+N9jlPXeZSFVAzOYHgCzHP5QtxxKRg+n5UX/F/ecJ58PlED/7HGVzAnRMWOY4Q4q9BQa1Z6UN9l98stRK0gs/2nnhHlS06lzXn5iSDljRE2ugt8I8RT9/5Ruf6k5H+qDSrsnjBlbiA1ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024947; c=relaxed/simple;
	bh=DR3fqE1smrbDHw0mqtwkpqkDQM15t5qZ8GcgS8apRgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3di8m9gsFdMKB90ckGflNSqUqcumT4ffXUiFHGoeMHBI9budVtxz2OjIAJMIx7ZJZGA/EXXCZF/JXPjS77iDN7s39Ackfn9HD9dgoAi68Nk5noIEmJLfZquNe9IrrDCwt6OzrBogZI6m+PBJ5qUuZiNlJAMaNITruFKZ0JTmrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dwpmSx1V; arc=fail smtp.client-ip=52.101.56.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a97quXLAJNAwfgHERvd+uJmb3zLKVPXSF5iX1tDq328rzieSLtVep32wFgzw2moe6jC7fYmsncBKW04VixJDngftvDnamFxDYW2dMKk/Qp0MkGoerjvufkFfKD4KOhvPwySPxsAoL/5OG38nw/zbJ3CYfk8UeNJegFpwtAj5uuqDBSw0+wZElKB4peecBtYyhYVkh8EdjCXFs/3bgx8qJYwJQARAn2LgzBR8UPmACD8COI39v3bOl/yXLz2VSWUhnfvUy5PRgpIprJ4SgDsGNlMxHhUghZSmVaf4+2qKVLQ+2fYiMCSK1BeEHoM0rgTrXVP8dIKotPWKbPJSKl/Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpuYC6+DwoWPBgIoiLRTT5sMKRdJsrL3XD6JmZbofFk=;
 b=pVzEC5pbwuLoP2ZdHdrfKsHyQpSMaA/IFf2jRuWMOsqoyMqwHRmU5wwXxIdf/TOio+l8ZUFFtqBZ2lt2XNzVqOyUopGHop0oUULn/PccbwIzcv/c/jcN4a5NZN/BvKsWrWPbsgBuixIVyjbxghA70X5Lv35iD/NTynOd/93cKO/KokpxttpOMmw2HTwHwtXZ8hfmu7LXTqljOvoCYgrg4CoybKeimbrDuZ/62F8ac1+JMWEmQ6X2+DsyfqKfh5qZqWEOfEwFf16DOQo/ZJGcq42StHuZBO3udGtNmV8QMWu2Pdqi8mye3krcGTTjri8kEjpRv49sjHJ19gtdzi9dKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpuYC6+DwoWPBgIoiLRTT5sMKRdJsrL3XD6JmZbofFk=;
 b=dwpmSx1VxPnL4efbDpo/jozAUvrz4Aq/MSQFo7A2PkHnwwXBiHMQ9PKS4gr05ULMeiVpxGRY9GmCUi//gOhddeMoO7Qq3tGM4/qf3p4XEbbji4OVtWFUWTC3h09LGHeSnD1HFR2AZUvOMVTG1WhI/O2GWgmiVLQA3nzEOK3gCGGAlEpWasUNzTgZMeze7GmJwfa6ADzBI53jOv+ayvaXd3IlgYoETX2XY+jSlMLsFZy7w8s5aoGfKre0BAUzvyX5NIan4hba2zx2GWWWQkpF7YOE4qALEthBaR3NOKOiaJO4Ec1fK+hoC+s/3u7hpAP2+UpcVoLWoVw7Pn3rPb0NDQ==
Received: from BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 12:42:20 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::85) by BYAPR04CA0013.outlook.office365.com
 (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 12:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 6 Dec 2025 12:42:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:12 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:11 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:11 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: <airlied@gmail.com>, <dakr@kernel.org>, <aliceryhl@google.com>,
	<bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
	<alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
	<bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
	<tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
	<cjia@nvidia.com>, <alex@shazbot.org>, <smitra@nvidia.com>,
	<ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
	<targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <zhiwang@kernel.org>, Zhi Wang <zhiw@nvidia.com>
Subject: [RFC 1/7] rust: pci: expose sriov_get_totalvfs() helper
Date: Sat, 6 Dec 2025 12:42:02 +0000
Message-ID: <20251206124208.305963-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206124208.305963-1-zhiw@nvidia.com>
References: <20251206124208.305963-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: a771fb6a-e11d-40fa-4959-08de34c4e589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f6rNC2Shn/yNrsJSHFfCogXlL+3WTbLpz+pQURKW0o834ueO752Ck2hYKPhK?=
 =?us-ascii?Q?eMKcK87s5sXWf3ba+wGOovQMxsoAVY3nVRR11QUK6JxnxArCuDUr7qVKdAX0?=
 =?us-ascii?Q?b32MTqbcNp67SsibBhuejpFOl8QcO3+0pJlu6umOA0mZQfm8ZLbH5Km0zA2O?=
 =?us-ascii?Q?WhBLR+iKLA0Eg84qgcFre09mzM9SW5/b0OycsP1EEwTK/qX+U8cjbzK1xv3D?=
 =?us-ascii?Q?ddasXMlXYwFW7LDc+WTKV7Ex/afl74mXH15gmPOX/X2KGlNVT78ochwGetFO?=
 =?us-ascii?Q?Jw8dfCI3ZjoxY3/FqQDobZt5xqhqtQCogpOpYUSmQ5euFt5IKcniWvFj6ZIT?=
 =?us-ascii?Q?SfrPHoQpb7+QmR0qKpdQoAHz1yyZUUnBkopfvaDc2j20utZeDf3XB5Y04/Io?=
 =?us-ascii?Q?iywtJubCgSZNiAk1nhKk/ymj/GOHQtJ7HdJqcyQVMdun7xKVHunn5hqGflM6?=
 =?us-ascii?Q?6unqGNTIEb20b6bh+UZZMiKnXrTwWOCzJpxpzMavQOXLie7VMgRmdcpxeL+l?=
 =?us-ascii?Q?akKUEc1EUZhhgphNZhrxU5sy9ZqGEGTdYvASXeNxg+6VjcdAXqvm9s/tRcdY?=
 =?us-ascii?Q?RstkbF75PkiZ6wYBUbtxr4o4IZK0Uydq/bf0caoqGuYNbChHvLNgIqxX135y?=
 =?us-ascii?Q?qhwjnumy+7nACm6Mp+2s+TSYYpApC9dP94/r8H/az2Y+xL41lBpd/4KNiDyD?=
 =?us-ascii?Q?ddrB/KTCP6nL6xXsMLEd1OLgCZn2Cs4ryKUXgqhB69cBOCojW0dLBeN30wqL?=
 =?us-ascii?Q?xShePoNXQxdeE2bW7vHKRuXWJ2livqBuIDAlP9GdmrhQjmvGMdacXe318iLI?=
 =?us-ascii?Q?zc6hTueeWgSdtRVAvOlBE17BsHD5XHb8rUfswi8gRAwL7i6kjtq9LfOwAzaB?=
 =?us-ascii?Q?/g2uyiBRhWN54cKPpuv2FUWdCQmI51uRpjFwI2+uUOJweoxm3wacv3SHYzhx?=
 =?us-ascii?Q?ag58GdVoroixouaXInF+WuscmcjIEBpsMbuoLCgCfpdHk3XtHWvitEBOLuIM?=
 =?us-ascii?Q?9FGGG5G+hYXDGLMA0xbD+75cR7XjaoG6Rh8ndpWRF+kz6UK8l3MALdzu6ydl?=
 =?us-ascii?Q?hIQdZz8eo00JYCJ/25y1CnmFEpheHx89tRqPw4yIRlfjDilFYNqZpPZrxT8H?=
 =?us-ascii?Q?6hPB2AGi75GkVwIQdTAPlechKeuxidtSjTzqaWVEqTftkN2H9XryZlOgtBL0?=
 =?us-ascii?Q?l7u9+I1yDtpbJP2K5PJT7NwLHrvLIsHwEpoUq7NacKNnevbyzVlQdV5ikRyj?=
 =?us-ascii?Q?3qzBvAV3D2Gj5SWjbNh1DKrLeM47PZ1idJO+z40mBIbg2qOG1wSOGA7P29u9?=
 =?us-ascii?Q?V3RTAoqGnfG6nYIZhQRSPM/roX5lXgqXTL0uupZHRPvsxrbEYvCDvT8GPp87?=
 =?us-ascii?Q?KYhiVhEUJ1VdOqLWrcb7IXdtxthHS3Ti0kcMmqWcBYystAi5aiisBPDjw9gq?=
 =?us-ascii?Q?X2/NCXRUnVHPO2u/E1i7N+OTXm3vO2scxgS9CkAfxVBoxwp7YQaMwuBGZ6H9?=
 =?us-ascii?Q?3+4Jqz/IwZAiERZ2fOF91NWcXBKTXJjMWkLlU42bpTjn4uyfnbYUNe6G3P3E?=
 =?us-ascii?Q?GAa3thiU2zKml1Z7+0c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:20.1538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a771fb6a-e11d-40fa-4959-08de34c4e589
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

Add a wrapper for the `pci_sriov_get_totalvfs()` helper, allowing drivers
to query the number of total SR-IOV virtual functions a PCI device
supports.

This is useful for components that need to conditionally enable features
based on SR-IOV capability.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..9a82e83dfd30 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -514,6 +514,18 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns total number of VFs, or `Err(ENODEV)` if none available.
+    pub fn sriov_get_totalvfs(&self) -> Result<i32> {
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct pci_dev`.
+        let vfs = unsafe { bindings::pci_sriov_get_totalvfs(self.as_raw()) };
+
+        if vfs != 0 {
+            Ok(vfs)
+        } else {
+            Err(ENODEV)
+        }
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.51.0


