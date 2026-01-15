Return-Path: <linux-pci+bounces-44991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F6D28B7D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 22:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 413CD300DB14
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236CC327210;
	Thu, 15 Jan 2026 21:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UItkw1Y7"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA772326D75;
	Thu, 15 Jan 2026 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512464; cv=fail; b=Haq5XdeRcTYyMTDADOkiCowDUXkscjqotNJ9slvSH8YWS4Z0UubY0vGzObHq4yzALsAHc41F9DbG4tts2ARW6JMbTZhD0VNzMgbF/TWc9egK+HJ4qSyrY6l2Bt+OPvm7Ket/xcQVTp45YoobknA4Z+hOm44t+xnKNEgJcsMQ+oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512464; c=relaxed/simple;
	bh=Lxj4PkBapAtBNnB2X0r047B1aw4vPK6YYG+v7Ht85A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mr/KeIMkrE3L0+2KCxT8zSykyWnRZaa9pNVTQj1FAzoJ9MttD0ciOP/ejkva53udPeuYaEZWhUsZQdsAFtgbiUwFfIW+0A/f4GOEg4b1tznCL5pcpLqZWxxTNBRZ/jZaD7bkXf8N9SUY8HGOJ5hdbKorSEPWd+pqBfzNW8ZjW74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UItkw1Y7; arc=fail smtp.client-ip=52.101.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDoElKLZJ2GzJIg1jl4qzl9Q/dVaHW/iSwitWLvaAvNcJdaQ9xheL8bCGoxmWoVNFoxbWrrJ7DVo1zxfHYFZ1/kKtrOWV72qS0rrvtREg7Y3ATGOHp4OqTnCcEs/XSwWUzjMd2RsL94yEqizacsorPOe98H3pa55TnIQHnY/KrEM9S8mfgRiGcIsEMV52WVzdFE2AMkbPwcVtcVRg2rknUi1UnIcXtbg6MY1g8WSNKyk7iqnioiH5duenYu/QhtUM5j21CWKsjXWUD90ZLkaY3RfUbGOrzMVKYQ59SX1kLZrOEatp9QD7R0D+//+USLZsAAGC+jnjS38BCzNkK/wZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVr6029GJBT27W7/udV0dd+wNmZk+pMBNPRUNVuJAYA=;
 b=o9O5GpkNM7TjUmYS0CLha2ELiEhjasN+wCeOxPZE1Ncg37VyC4jezKobeymzjDnq8CPRlwi+hSNgbMmw7MRXyKVI5h5/YFuYNBxHMsNruysAcOs97ffek9JZCEBWP63BmyZlBJFIYrKJsf679aR96PSOG5x6jAz6MGvNJFBgztNlafqASgqhlycqGWD0IgYXxVmzmzbz/AOZkjAwDqnJAhCin4Uo4T0N81K0CrEtoEjtuP7SVd3M7ktOkAkafEd1oTbcmdjA2TEC/9pDyKwsGJydk0+nNyNeUZw5VR6c8zwFFuSnulrN723yHZeMQ8W5GiKvUOYRHtdXzo5O8LSfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVr6029GJBT27W7/udV0dd+wNmZk+pMBNPRUNVuJAYA=;
 b=UItkw1Y7SPFKrQZM+Mtrbzct4L2BFt1bNLHNRDamlfwgqZFU0PSY+dDq4MG+WzanbdK2j2E0Wn2Q87sMB/Q4RDT2FqKaiKuTsAKJgjGEq4Z30wwAq2Aj5q+PycCKL1D3qkEmHBWnkAGjSVqPwc+PqQhy5HBOoc1d24TFNuktdGZc+J55ab3FrffxVbkMsIySCqqrc45Ds9A2Rmxvjy3eYnj0hGS1TJkqQYWS0sGTMnUojLA1BTYv+ArsAD18QRY5PVBwjvqgObd1TyRmVCh2/xJtURxAxzD5/cvLcdkJey03uOxM6gQ5UmDKjd9814p5Rr4QZQHFOI7rq1oxp9tXsw==
Received: from BN9PR03CA0372.namprd03.prod.outlook.com (2603:10b6:408:f7::17)
 by DS0PR12MB9422.namprd12.prod.outlook.com (2603:10b6:8:1bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 21:27:39 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:f7:cafe::22) by BN9PR03CA0372.outlook.office365.com
 (2603:10b6:408:f7::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.8 via Frontend Transport; Thu,
 15 Jan 2026 21:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 21:27:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 13:27:17 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 13:27:16 -0800
Received: from inno-vm-xubuntu (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 13:27:10 -0800
From: Zhi Wang <zhiw@nvidia.com>
To: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dakr@kernel.org>, <aliceryhl@google.com>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<markus.probst@posteo.de>, <helgaas@kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <acourbot@nvidia.com>,
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>, Miguel Ojeda
	<miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v9 1/5] rust: devres: style for imports
Date: Thu, 15 Jan 2026 23:26:45 +0200
Message-ID: <20260115212657.399231-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115212657.399231-1-zhiw@nvidia.com>
References: <20260115212657.399231-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS0PR12MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: bbf7fda2-d34b-4168-620e-08de547ce8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eh9+srZSgOQJyLmEq/yRU2MXxt+WpCgFx6HxEYoBWgHN0pNlvgMkVUXVf+zE?=
 =?us-ascii?Q?+w/2y8VaJvu0xegQhCF85O63CpaxW4D1wdkrCSq2MGAs0murDTYXmBVLPyDP?=
 =?us-ascii?Q?bGzl51mCnRRLdjkuZArpmKk9PlXK90vG/4Ov0FzRUOezIxoBOxkWIBYEwk9E?=
 =?us-ascii?Q?O4JfTxLC52al94Y/EHN34rt80KG7U0L8XQ3LLHUt+yTjLRdGqUmKM0Fs3ZUk?=
 =?us-ascii?Q?Og3bMT3IEfDtqUVrfZlZXhCOZ7ohnaobUvamii5AKrEBSYJ+KwaNzccGIyjS?=
 =?us-ascii?Q?5z37KSMvwTu1vDmdnnDhcilCKFXnZkdTVLL1CeNQS8t7dJ9u/VwEUEDLzSCD?=
 =?us-ascii?Q?jbQexNy4vvpO7MI08N64b3vRH/hU6EpdfMa6/NiLNDmb3b6iGHmGnGLGgeqL?=
 =?us-ascii?Q?FFfAFdEjC8u0ZeByCtWg4T2H48Ck5qJnxppwxE/+VTjjdq3FDfmNQsYbfkvE?=
 =?us-ascii?Q?DQ/I92EGepK0sZzCAEclRcYzBQftw0upZCUszIwxuIRTlpPFnaWQIa2OPxqU?=
 =?us-ascii?Q?ERqxVNAILigJxvipJ6xGWJKr8znM0wt43mZAkOTLKMlVD2R4utzeQgl/ICZn?=
 =?us-ascii?Q?F/KSsexaLfPx7rwEb+EGyr8u7y+A6ezP3fV181EDCiOORxuSGWW3Xz8+3SCM?=
 =?us-ascii?Q?NnqiIqZhhBc+q+03q48Vd0mXaG/gLP2hnI/mggvocmmsGBYVPK5I7uJ9P3iw?=
 =?us-ascii?Q?/dwaJGaUHmQMhoTzVvnMgE5DoZ4xh8veV/U8Cz8puBHxc/5mgS/iraDMahMy?=
 =?us-ascii?Q?mCemeW0UfO4lIJfz9rAPJ9HzskftREJiX/ez2f0N+LDMdNA2OBn/VKJrMzXY?=
 =?us-ascii?Q?Q3fYvnrn3eaJ26WiNUNbfd1XP4CA/F7PIcsghdMGNKGxZNDzjbH/eOBNln13?=
 =?us-ascii?Q?Ev93iHF2Ljn641EGQgWFT/D4yRRCxyescFQdBYtWfzlP4Hgf0C6T/xrjk9or?=
 =?us-ascii?Q?UUDelb1P3vpvr09ng+QWLewZRhuWs7iTw2AmARoUxFMX8WVmf2U021TUZodE?=
 =?us-ascii?Q?LLSkz5/aY+XkL8H5NNRy9PGhjbYj9bmTG/xb/Q7En/4c68Uq5RcKe+J38OX4?=
 =?us-ascii?Q?9O/cYutJFyWR9IW6zDMGuhVTL7xBTSCQn3GYq6r6oOEQn3ItTokZ0GHByrpq?=
 =?us-ascii?Q?R3NzGq9Si8OAvXRBGTIKO5JihJoSfX9eAeu3xJJQs56FAmx7lMK7Qeirn2Jm?=
 =?us-ascii?Q?EesQRG1Oe/EBGKQGqgqbUVoDX5F03rnsZWINF4Bx6g9Q6etSfz+vPv6ofYHG?=
 =?us-ascii?Q?mZmjvZZNjkL3gn5t1aqhXPUCruA6sNqYExC4SMpZdJLA7Y9RoQRRXgFh8o2X?=
 =?us-ascii?Q?Yj9eOa9pwtm4qGo4BPmp3hIlvF+zuPGkTHYZAqjM8oEvezT/5//GqBrwugjt?=
 =?us-ascii?Q?6Du4wBWSaaZNaUH4nXRBDaJj2B4gD24fGW9qVOe9xc/qhIP7CzIPcsKbmxyq?=
 =?us-ascii?Q?cxsGba7YEX5QSDcCitIkT/PUsfNbmWBLAHWeAmZWucMDZoMc2SXzmHd+VZAt?=
 =?us-ascii?Q?J5hi8dflJnjNfjXCjBVHrCnx4p/69GFEnfahpjmjDCz/WqSRLL4wXjf1bejd?=
 =?us-ascii?Q?YiR6fYpIAxXvPJ9fDLS+/IT7z1oGajf590VyxknVkMMudvFbzfVDogzyjwHF?=
 =?us-ascii?Q?lVKqLuku72S9AU9IBMPk+sMb07hf6HQcKCQmM0M1xGUcz/hhFhSe+zV1vJUs?=
 =?us-ascii?Q?Ey7pJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:27:38.9278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf7fda2-d34b-4168-620e-08de547ce8c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9422

Convert all imports in the devres to use "kernel vertical" style.

Cc: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/devres.rs | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
index db02f8b1788d..43089511bf76 100644
--- a/rust/kernel/devres.rs
+++ b/rust/kernel/devres.rs
@@ -254,8 +254,12 @@ pub fn device(&self) -> &Device {
     /// # Examples
     ///
     /// ```no_run
-    /// # #![cfg(CONFIG_PCI)]
-    /// # use kernel::{device::Core, devres::Devres, pci};
+    /// #![cfg(CONFIG_PCI)]
+    /// use kernel::{
+    ///     device::Core,
+    ///     devres::Devres,
+    ///     pci, //
+    /// };
     ///
     /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result {
     ///     let bar = devres.access(dev.as_ref())?;
@@ -358,7 +362,13 @@ fn register_foreign<P>(dev: &Device<Bound>, data: P) -> Result
 /// # Examples
 ///
 /// ```no_run
-/// use kernel::{device::{Bound, Device}, devres};
+/// use kernel::{
+///     device::{
+///         Bound,
+///         Device, //
+///     },
+///     devres, //
+/// };
 ///
 /// /// Registration of e.g. a class device, IRQ, etc.
 /// struct Registration;
-- 
2.51.0


