Return-Path: <linux-pci+bounces-39826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F764C210F6
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 16:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099AC1AA3D92
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADACC3655EB;
	Thu, 30 Oct 2025 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6IN14CN"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5A73655E1;
	Thu, 30 Oct 2025 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839351; cv=fail; b=GiJEBAkXmBLMyOZPKEOMyoF0GMhw/uQk97PKpOekWL55rN5bKjLZUCBwLssAN1DUpVzHgnmfP4+o7aPWaLMMnOs9ijpb/QwWSjogZWIn2e3S7PmROco+57huVRtMSG7MnceDL92z6E2XuS5sxXlwW7NuZcgcCKj6c/VQc/vFlsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839351; c=relaxed/simple;
	bh=TOVory4S9vFIx71r4yaDJG46MLW/MkXNwWKbBg8D4ZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp737+rPBUag6563spLSZjM98PWGqR0NtnV/Z3V5T5OcJ98+asmj7H13CX4iJZosYBeZ8zXXHeGf+w8+fEIoI6PHYry8JTz0RDo200GLpuJ2awKTJVRcJirPhFDoJe44yzHJOpEbcfxClCqph0JVQkh0uLMDgXr64w6CEAqU0S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6IN14CN; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbkbyMhPJqpL98jFEJzwmHubocylIzvLv6j7h0+0tnE3Ll9UDfyXTJlXTWuadVdfegIwDyHEk5gMo1qto8MIz0J2ml2A7GxaIjaVYse7PYVFP8WURifrni0dsfuuZuJuzwO47FTHWonUftj6md0TBswgF4+lJhhaFKoyVogTI8aC2agD0L/S43tpUgM0CBrfsrJVvQjjc5ur/JJcuT+CJRvjFWKgehvi1BdwDRJHPAMDtYrZaWgY0dtUvvJEaEY8j1iPbk8RPDreI54argeGe9/Xhmppj9XgzeqMzwxw6qbDOa3NYziH1RLmWRJhip+iRqMT4AWqM51yyE92HSvV8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNmF9p/0lAx5vQFBCi95S/JBPk0uhJ0EOmkjarRavZc=;
 b=wrd2BsvS73MPmP7SwZBeRCkCAkTGkmnLeGoDS8rQDdrLKzULsrcOVKdnpwRfHWwarui+3ICNV5D8QQKbFRR6DOfMVT7AFOdYfi+7X9Rhf1ca2ystzBB9QJLr8O9tAkZbYaCBaplf4ho5I70FGTB9BsNiGGf0mi1Q32Ps/KLUW9y9RbxJjrVdnbb5TwhRTq873Dh2qpMci65zR3UmbAAJ8uLFLPv5TF8ZQJJPlxoshWy7wLkgm+Y/s7ItAzuKZSNsk4IUnCBfD0w/yNEKIkRnr2CMdE3IfkKoMjWOATfg1HYxsulngmyG2q4BVkJCMIltiOuS8GjXeSO1DYULkbzbnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNmF9p/0lAx5vQFBCi95S/JBPk0uhJ0EOmkjarRavZc=;
 b=O6IN14CNWX0Uwk3Nxc/T83jAFx0YITiHPANAxT+cDi4iMxBvofPSRQgc12GfYYO/eqFt+XRPdVNf7XAuZ7EPd1DISdg/nJKKebEal+JXn5hHtLIL5olqrgkaGP2S5uogYUPFN2JDDB3FfWx3J+/Vg5eCMcFH4v92sGu7Rc8XP3+0AX3c96M7tj1nB9Pn1xG6V5eALdXfpulhmIUrhCPBkdp1WYLOtlGpAtV0lKCKaJm61LAA5k+M/vTS1c40p7kA4phU5/3pe8kTUwabcPzBFMWDishjCsbDZqiCzodrD95vFK9uWFnZDscFEMuHBnSdQ0qqc86obGofze/EJOoSLQ==
Received: from MN2PR15CA0054.namprd15.prod.outlook.com (2603:10b6:208:237::23)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Thu, 30 Oct 2025 15:49:05 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::da) by MN2PR15CA0054.outlook.office365.com
 (2603:10b6:208:237::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 15:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 15:49:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 08:48:47 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 30 Oct 2025 08:48:46 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 30 Oct 2025 08:48:46 -0700
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
Subject: [PATCH v3 3/5] rust: pci: add a helper to query configuration space size
Date: Thu, 30 Oct 2025 15:48:40 +0000
Message-ID: <20251030154842.450518-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030154842.450518-1-zhiw@nvidia.com>
References: <20251030154842.450518-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 476c8741-1051-4039-a0a8-08de17cbdac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ally6cFdKSfjirBm9LataYUsW7gjpzPgoECzkmLwMnUf4XMtsi37SzQbY0gg?=
 =?us-ascii?Q?BWo+RK41WdGDnYDglpSbAACBjnyxEzKIhkI8FBj0II6qV90sN6sgp23ErLTG?=
 =?us-ascii?Q?1ELm73BfQSLvf9CKg23QGXV7QixY2oE3g6cwcPJfsp4VOznz6i9ggs4IqE5Y?=
 =?us-ascii?Q?aNiU0FcjV0lofSd387n9xByRyY+VAerbVoKFZk1cQXjYedtsi0W4LeTDpwN1?=
 =?us-ascii?Q?HKq+cZy659T3CjHMnghr7aG40siTZojn0fAzxFgfNSUyfr4x3FThjtNvgp0p?=
 =?us-ascii?Q?y287nVWeywjMuUS/GbLIqWSBBNlHUgjDidzafilZ5c8QQqV5f9BhUt4gCIkR?=
 =?us-ascii?Q?u6ceYWeA6mXUuCORm3XmkdXueb0vDpe/hcsgH3BUxQKBl4x6Ot9Qz5eWjnmC?=
 =?us-ascii?Q?Pu8N8eL8+WTwpyiv1jZHGwu7NL8R7Xd84ud1LD8hHXxD4P7+P573Keq+stCh?=
 =?us-ascii?Q?CPjoU0hBoY6rOFbkZavaMywhJzj1RzZgFRA1t/3kNn4CUyhGlMRSD2/qZXjD?=
 =?us-ascii?Q?5wzOLnthHsgcBG/xAanAuCujkYHomA118MHSfRZmCbfAq2f8ZamyMyFFnIy2?=
 =?us-ascii?Q?/AVfogVEBKNzPdsdGgGhcvOYYxKukFQ2PTN0MpOdRBdW+zcU0zrIoImJ6drF?=
 =?us-ascii?Q?Rjrt51lFOLYKryOWJ7DvaIV8atWjIj2csDwFgHSObsl8XXwwhAJtkIqv9Oml?=
 =?us-ascii?Q?76lqjvsCYF77EEGvzqTBKzjGj+NMCNpclmJMkzz/KVJ6PR9TRBaFNGhsme0k?=
 =?us-ascii?Q?0MXx4i16SllzkyHnzCjzRlijqLXQBYNKhC1xp9uQ4MM5vyHMPMmj2ClMnYhX?=
 =?us-ascii?Q?Cj6Z2/69JuBmfM1P1VjJKWQNswgYhaXJLtgHCULolvN7ZSlqDDagXPnxpZhE?=
 =?us-ascii?Q?/HCVsVfkNeDfd9/vZER/73/p9yugzWEKZq6MYvAXvVSZikChiPLB4waMYHAw?=
 =?us-ascii?Q?flLNTvrAFQqJhlK0iMr6qmjof7ebOMDhJ2gOXWXp19Q1wgYuaJjA8PbKdjhB?=
 =?us-ascii?Q?zMJtp2u5T25/DqjU7V4Gf0XVaJFBvqUjzus5B/whtAfrbPQs7xSJEz0cRpKl?=
 =?us-ascii?Q?TUQuK0jTouNG2ekkk54g3HrpGN2TnpZzBIy/xKagRdc90lWu/cVd6I7L8Ot6?=
 =?us-ascii?Q?MkWgUpIiJOY0UvFVdpf+3d8AicH+ZBbjS6JyZ886CrsBqVeNBPJW+v/92cy6?=
 =?us-ascii?Q?Y+GlDNylaJBPaz/onc6GuaZpODjLwo00OcvAUKXldfcxYyB4Jtujb/tdnCr/?=
 =?us-ascii?Q?49y2Ip8k7lhR+sV+ISb7+ifWrz54CTbdc77tfwM1mLKv80SRAL5FMgwvkVaB?=
 =?us-ascii?Q?cBlj6kqt3mBcFnV/cIpHDwAuYCU7jKD2JDyvkmEa0fWSMI7RBvGLjqCvmB3K?=
 =?us-ascii?Q?M7uh2tn5x/OB8IGXiLANCIJhMXxhvAauEx95EHZ4E0oBPtO22/1vafaK5sjR?=
 =?us-ascii?Q?36lI90UTB2LAbblvEGysHxp+ueKfeAzdvI36uBibeOJZhXEgYFS46eFHP269?=
 =?us-ascii?Q?PP9v9RcwU7cLiHqVAP9EPGdr24A5wPVmIs96ICqfpoQStRXdKhY/l9EKnVmO?=
 =?us-ascii?Q?5J+qIfVfbKe3PlLJ/9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:49:04.7571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476c8741-1051-4039-a0a8-08de17cbdac6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962

Expose a safe Rust wrapper for the `cfg_size` field of `struct pci_dev`,
allowing drivers to query the size of a device's configuration space.

This is useful for code that needs to know whether the device supports
extended configuration space (e.g. 256 vs 4096 bytes) when accessing PCI
configuration registers and apply runtime checks.

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 77a8eb39ad32..9ebba8e08d2e 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -418,6 +418,19 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
     }
 }
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+pub enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal = 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended = 4096,
+}
+
 impl Device {
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
@@ -514,6 +527,17 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the size of configuration space.
+    pub fn cfg_size(&self) -> Result<ConfigSpaceSize> {
+        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
+        let size = unsafe { (*self.as_raw()).cfg_size };
+        match size {
+            256 => Ok(ConfigSpaceSize::Normal),
+            4096 => Ok(ConfigSpaceSize::Extended),
+            _ => Err(EINVAL),
+        }
+    }
 }
 
 impl Device<device::Bound> {
-- 
2.47.3


