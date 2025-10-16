Return-Path: <linux-pci+bounces-38399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97090BE5813
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A64F34865A
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D02E3B1C;
	Thu, 16 Oct 2025 21:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RnwQ72Ow"
X-Original-To: linux-pci@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010027.outbound.protection.outlook.com [52.101.61.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE22DF6F5;
	Thu, 16 Oct 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648603; cv=fail; b=I2nCEVPleVo/1qq2bmRGwxqvGbzLlnPYVT61mwhGe3gLWV5imAr4uWsT5Ozv5AS3lMHDea4oYRGvR0XktqGOWhpQW/pTWlXLDYbq7Mnmj0Gp0qT2B/Um2BWZbYmbHGRzKA1NRIHmVxinOmeYgfWimHk6p1UFoF+//q62/XI7/Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648603; c=relaxed/simple;
	bh=UNcnkrmp+fMiLJNMC9vgmbDggoYc43ldLcATdIKJjH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTkay4XFh75GhJtKCgiHxGARGiX/9YwtFcjD7Z9n00KEIkE/sfO/lizjWwtzH1curtJ9G5noR5K19kynQxqChrwDNnEI1aFp95HeJe64AGrbkxGangYHRum9yZaPZ6WEyMSpUI/7y/PhtWW6Z3hCH1jgPmEVrjBT6O5rgbAZJzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RnwQ72Ow; arc=fail smtp.client-ip=52.101.61.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hv+B6iDT0YPocFSlTpQ236+TXJ0eAGAJOiZAX1xVaJ3dixeG3h68ePs4uFljsobmE/3JVRsX6slfdN/3fuwbAXj3szbZsvjjvyxI54wGV3WcJSWXhglrnA3cJ8aAN2WN5o8U/ebek+amJMmu1P7dvkfnEFtppw6HsK91BVIp8jsjL7ht7lAxRdlS8rZ611Cah9g67FykezNLPjc8G2laePnq6P4f7Z6XFNTGfDnIgNvgN2PQUM21RDT+IGnNLSTqlid8tu7NDJd77Sy6/BxIaFJOSHq7L3OF/95nMeU51uLTEWFw0R8C2yZofwqw0EyI6Yiws9hRR7kB7HlbmFMZww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlKgQsg0Y+dahQeVLSj2JhcTYUyx3FxJXoSeiCn0r6A=;
 b=t7rugmtRomqQpejVjurvgM5iendjy3PX04ahhTSpE+oEVyRk/pFWtCgfaXsYr/53d9G3ugLYuciyhVKzta5t73ID2cz/fNmn29SlL4I6ifsYXeZ4f5BjMgte07CQe1zuLUU66evsBEy4kuEkTv2LQYJBeDqlN/F0fCV9PQKi68QcnBA35TF4Co1xgg0Hn0t8mbXUyIDEqkZUXaKSoj6H0Vk8ImGWPcuCVqciko1/sribj1WkGIzjFlGR5c/nvbvny53x2qh/fjadL6Gd4doS51kviL8WVNww2qZx3lpcOvXD+QudniRJ7w4fhnKDRP6c/9JKFX5e0pt4DQzyLrnr6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlKgQsg0Y+dahQeVLSj2JhcTYUyx3FxJXoSeiCn0r6A=;
 b=RnwQ72OwZ1JBNyqtcT8Oyflqc3yt07l4ONRosfOsieiFgS7YdE2h1+W0yK9s+jHGGDWYE4Ohqlij/UGIBKOu3nZ8tXwHipio0EtxjMFyNM9iFAFEun0oQMIO75dW++EjN2apNmkWcpLIA0C0OIceXQsd28IFhHNXchMJKi3SRHW7Uxz+R0hpN/tCN83K6J+yjvPjN8me2XFBRyHe7Ox2yChtEmvuou4aO5VZSHn9HOg5OWTSKPsrFJwUpG8Hi1rBMQQB4jZyAmMo2CY5WHV2dinjI+wbPB3AnTPaBQhcaqEuJNScQFYYm9LnmDqZ7UAHnldWMMwnhtP+ULlu4GpoTg==
Received: from BL1PR13CA0338.namprd13.prod.outlook.com (2603:10b6:208:2c6::13)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 21:03:15 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::89) by BL1PR13CA0338.outlook.office365.com
 (2603:10b6:208:2c6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.6 via Frontend Transport; Thu,
 16 Oct 2025 21:03:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Thu, 16 Oct 2025 21:03:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 14:02:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 14:02:58 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 14:02:58 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>
CC: <dakr@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
	<gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
	<a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
	<aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
	<zhiw@nvidia.com>, <zhiwang@kernel.org>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <markus.probst@posteo.de>
Subject: [PATCH v2 3/5] rust: pci: add a helper to query configuration space size
Date: Thu, 16 Oct 2025 21:02:48 +0000
Message-ID: <20251016210250.15932-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251016210250.15932-1-zhiw@nvidia.com>
References: <20251016210250.15932-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: c61a2901-ab5b-4b1e-c318-08de0cf76c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ls3Wy5Fsh5Z8m2i5FbrrQmcM4SStBqZsZCdKBJNlljSmxC4Fj6gkhPB5q14q?=
 =?us-ascii?Q?i5PhNfmhWgBjitrnbcT+ElAOr4KE4dkCwk7gCITvpp+zygzmYhx2BSiLk1N1?=
 =?us-ascii?Q?p+DeEKZY/BsdHR8PyNwpPvHaBU84lPXTaFS4COLCoLSsRGvkC/bWyM9Mjzfj?=
 =?us-ascii?Q?fWuxEGpfRUr9FApKGbmd52LAZSbIUixEkz3tD1jt7pTMxmZre5IaM88k7mRs?=
 =?us-ascii?Q?QsDivsnUBM+Fj1tCAfRi14K+GvRNfSWIQo0cOUcuq4wIOQKU/y2XdPpRwuf9?=
 =?us-ascii?Q?YXrRM8T4BpcPNR+OdG6rucJZqm5ZsGhATc6isfD1XSRZSbMmAbOj53GyKp3t?=
 =?us-ascii?Q?2QpgLHC9vOJtrdcW/ZIGYqis5Oky0dOYCkfnCc7tsK9e47HDbncZKYPMh0xi?=
 =?us-ascii?Q?joT4qpBN1wr6VQma7E2Vy66KWmROHgloRsLAckuf0o4j/s+9LC2ouvn9vQP0?=
 =?us-ascii?Q?mibBnDbaqj+313/lRQCFHbDoBSPIVxe8IOThb7FPq1WMa44CpyPyKAMPN2cB?=
 =?us-ascii?Q?3wpAACK4cJenwCRfMWYbQ/B0KbwO8UbLdjRBjOhmnPC4s9B4y2re5PULIVWc?=
 =?us-ascii?Q?Tp2vKLM30aqTMwyNVmNk3NJkrJ5e3y5k8vDB6+THd/HyzlYG5BBXSUvM5yE/?=
 =?us-ascii?Q?aIYrh3RmbOnsyJo7PpgoZPVGEfyq1XA5zPEZYgN/b4F0OYKSuR+ptb7DeW6D?=
 =?us-ascii?Q?eCn2OiAAVH7R1Vzl86dHayhkYJLaR37wN6wpVYHOMwF/23yA06wRjanbFZGV?=
 =?us-ascii?Q?Yk36bHNy1bQY+XC8PW4C4cvENK4bH8WeFx9gB8nziZYyXok9fmfYCJEpAGxc?=
 =?us-ascii?Q?Y0oKrZyVtQ7RCK5hkAdc0dWqAFx0N/E2QgZgYGOCYLRkHmoS1VNnHmcd8HQb?=
 =?us-ascii?Q?XvCw91Bz4Wvkwpk5llMsS/XlC80IHJ0ez8iNENlj/Xs0AHvW/6ij9/FuR5/X?=
 =?us-ascii?Q?xEJsyvRPaQW9lMjgzSEVcCArrogt4IR36ObRlQH+nBhIC20ST9lpo0AYU3+r?=
 =?us-ascii?Q?KzMdNPX3BLJFn0yKtE06/Ll0ot3GQb/lKImpTiNcRqqyHA0uwu0z2krs411F?=
 =?us-ascii?Q?osonUS3AcqHplJCmVFwjo0DyppafW+twbJDI1O20DypmZa2mo4niSI9kJAZa?=
 =?us-ascii?Q?fp3fpBt2mJzVYNxrp98EnWhkGshIOpm3hxY+IfuS83QAIcnmSbh9br/MAiYz?=
 =?us-ascii?Q?EHqD3wW4DJV1YCGmp9BY6cIZOlzlAvX1vplSRWeboPS0XAZA1so9csrpIrRw?=
 =?us-ascii?Q?DTGa8Ak4zEGsVPpl8StYgUj4QiwFtiUtOyJhzVEBfW2C2oytmuBDN1W0JviC?=
 =?us-ascii?Q?84oGc8UC282/1wlsE0xPd966klIC5GMF8q0FPrIsHABno1OOg7DaA87XngTd?=
 =?us-ascii?Q?OtZd8CbE/SIKJ4IvzKHdYUR9mRVGWsiGsrfKiazk0vePx/mQKgsN9AiAfTM9?=
 =?us-ascii?Q?dz0Kf9/xpvmM/DLH1V+3F2ipCo9qqyy0bxzRWBaYwJOd9tJdbNhFzk2oUwe4?=
 =?us-ascii?Q?vKahTwO2tH257XWlRGaucmXQdsxgdsDONDciVcPgWghwnEsass7y9mv+ZPqz?=
 =?us-ascii?Q?9hjaQgGCr72J/4UhIm4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 21:03:14.3674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c61a2901-ab5b-4b1e-c318-08de0cf76c3b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873

Expose a safe Rust wrapper for the `cfg_size` field of `struct pci_dev`,
allowing drivers to query the size of a device's configuration space.

This is useful for code that needs to know whether the device supports
extended configuration space (e.g. 256 vs 4096 bytes) when accessing PCI
configuration registers and apply runtime checks.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 77a8eb39ad32..34729c6f5665 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -514,6 +514,12 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the size of configuration space.
+    pub fn cfg_size(&self) -> i32 {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        unsafe { (*self.as_raw()).cfg_size }
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.47.3


