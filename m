Return-Path: <linux-pci+bounces-42728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10081CAA68D
	for <lists+linux-pci@lfdr.de>; Sat, 06 Dec 2025 13:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54193329502D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Dec 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43F2F6162;
	Sat,  6 Dec 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UnKHxsaP"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010016.outbound.protection.outlook.com [40.93.198.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5E12F656A;
	Sat,  6 Dec 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024956; cv=fail; b=VGT6OfGoeHptUofzFnZA6TxBBtFaQ9zSbEnKePiDhvryi5Q8HP5CZRmBZkz6W5nZ723/rAM0umVdTQwB6Yumljrff2uoh5DR+p1nEUtFf+cCv8hHMrYU1Zzpefi5UW0ljxcNpC0pKtBcIkfhj5pGVncPvhCNGu4o9EmBU/OnrWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024956; c=relaxed/simple;
	bh=WvpMzmBjSz8MLPc/Sv0SGMsxHnAGWxtUqn7AvuBfLNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWlKU/tt6ursVyrGSX4kG0cmuMY5PPMLCs2uRuQIEDDmHnMso31/e+AThxrfJUnE2Xif6dxRXNOed5cxIEVr5kYNGCMQHp7CzBYsyRqn5sGUoil5zQaE5PhdXZUEBfkSW3eHofWdkTClIy8GOhnONsSht4bOLfX/DDjhHz7q8+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UnKHxsaP; arc=fail smtp.client-ip=40.93.198.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYD5ao/Bo06mmrR4ZuDDNuFe1zUPmtwU10MeKG1/1xdWjzw2nebRu696dbcahGMdoQnhKQZJpxF3XQ6OrRc+KbUvX0QqUH52t64y+ZXhvDzgsP2tDDM7fs793bI48roBY2NoEls8gQW+ZJLPWga5MYPZ4lvFmeFuaWskpZzAuXnjgjX6Yb0nRnDI7o52o0CrlYeHWHqEawBp+wyZ6eyTLIrLhSoeKYpDon72twZWpKMhFRmKYorFIaTYFkPWqGMuELhI4R9fnGBTsTazLd58F66ialV/Al6fuQbR0SMmbV15IiUEAKlOfGXdt7Ut6uIoj+Co0QolywfueX2n9vRgKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev9iM+k9pw+8MMLQgpOYOSl3+29xvukupMcfyqRVfnA=;
 b=nCWqVxYcrj10FunL7Y+fWfT8sA3D1bUFu3i21JLuV8+ln7XbJVwPgys0TcvO/svvkw26anUqe4YS5oyUbzU9QvO6RvbyetSL9utWa+W8GLmvZO1SQ0q1awEMzjS12MtVh5HBtssf68/h3Ce7zdTAsrQ78YEaa/UuExgy8zq3BqQAjah4dSkWFFWqUp66Fcj3KBZkBLe6Q8/QMBbPI57UDDAEqPm/XWAwoHomYSykdWXF8Ph5JHrnnE8vhhMbA6Nj75XOg9YUn5b324+LzG54jajN8VE2kz4x/GzOzx0CfpCZhU6A5uGPs1g4vLW2kcWwgaJJTl8WOEqT6ZcBAV/vwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev9iM+k9pw+8MMLQgpOYOSl3+29xvukupMcfyqRVfnA=;
 b=UnKHxsaP6x8OEEOO+7T5pAlz7J5mrczYJeMS1Pcaayb/QP2HFWsJfgDqnFFGyI2HjAwM7rLMiZ/eDdl5JRHR6wMQZT6m9GNmyNU7xAtcocKOCZD5fdfY8js2gKQgBR8UaQaVLrI4w3lPOlw7AIf6Ki55aMvOfQQwC02Y8EWfJ/yv7b7Ne+31M84xj3qOWMSYIF8NU9gglO1TJwPrAXbwSz2wN2PMLQoXOVhHh3ar84mbzkIsOxjLt8Dj24laVYAmOqbUUAFh5W2p8OWyczKXfS3//gyIUYnawkCIO124HE9ZsSsIQ1MLWmWomui0UsS42Z7oq8LBEwXT/yjCysA6XQ==
Received: from BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29)
 by DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Sat, 6 Dec
 2025 12:42:26 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::d8) by BYAPR04CA0016.outlook.office365.com
 (2603:10b6:a03:40::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.13 via Frontend Transport; Sat,
 6 Dec 2025 12:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 6 Dec 2025 12:42:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 6 Dec
 2025 04:42:14 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 6 Dec 2025 04:42:13 -0800
Received: from ipp2-0489.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 6 Dec 2025 04:42:13 -0800
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
Subject: [RFC 6/7] gpu: nova-core: reserve a larger GSP WPR2 heap when vGPU is enabled.
Date: Sat, 6 Dec 2025 12:42:07 +0000
Message-ID: <20251206124208.305963-7-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ced8b4-b65f-4097-2776-08de34c4e8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JCgrpkKoW1SZJCqbywqg3EbpUZOSRmXwRLxdCEFD6KUdnVAp6Pu/5zxQnZfg?=
 =?us-ascii?Q?qUc34JC+1G9DDK2ph0VaX0f2zT1K1DIuKW6AmjJZvIg2C6uQdkbVcRsMS4Xg?=
 =?us-ascii?Q?yJ/sg7oesWeHRRIL7fErWBvCe94/5UXLUiX1Q9/M+YOCsslswMVuS9YVCFCC?=
 =?us-ascii?Q?243V8uqugxTP/IXZiem6syjGArCMF/tkzD891cY/xkPAy5cSQeL3DiT/I2no?=
 =?us-ascii?Q?5pHtiUD6uPf+5GpT9nPgddg01j6L+gIOLbsAqMY7/bIbuczSjDcHPYYmDAVs?=
 =?us-ascii?Q?t43HkDWJteBHLcZo1Sg8w8ZpoW13J30fB+VKUyEwUiYe14BuyFMTzRxswJQg?=
 =?us-ascii?Q?9Zib2un21T7bWzEM3kCWqlGSTz+tpxt8tJEWQZmupjRD9QI//FIRplsGWFI8?=
 =?us-ascii?Q?Mmd8VKsotQqC2QydU3SZ5OkKhaIJNOOeKmQhHX8eFbEM840aVwvABK8wzF6T?=
 =?us-ascii?Q?VkPNe/cgEy06kxoTufA7lUCFqheWb/+SeLmDwPXSlx9p6lS5UdC9aQyDMmU2?=
 =?us-ascii?Q?/x7M+EPI4bZdyHtLxDbOx46JL06Y5/Y2QtNwakI+pMcDUHEUAdxYi/4Gh7g7?=
 =?us-ascii?Q?OmhbCYDNA7EilTQyXipDtFz0n4xcHbjxcq9CLThGJSUKEacaDG7TqunRQd3O?=
 =?us-ascii?Q?uka1M9Ik3LhI4yqWACMkYuG9M6MI65iEh8WfXOkCXjQfnIV6PmFXNfgKR/0T?=
 =?us-ascii?Q?N62zL40708PDcDatZCZOhGEHrJGiJoNh/vlZvBDwfXwRZQvcSMizTo9U7khQ?=
 =?us-ascii?Q?mlqxIdhkPVSiYurTYN/bm4yx8duKsJEUHX6bnlM1Y165gZs0cfEB6wrdkRA1?=
 =?us-ascii?Q?w82RvSkVwbE+fV9Kei7PkM/tiEAXZROLWkxVOzoRteuh+/Fau3G9as+o0XT6?=
 =?us-ascii?Q?YxqfWy4zXXhy3XUijGA9frpojTgrbbYbGT6UZtxo2i7/WRPf04uhUVskEX8k?=
 =?us-ascii?Q?NnPvGd/A4LZy+/UQCuVjFb7dkMylPd0FMrw52zx6+whZaU0rPfc7PjiQnYyV?=
 =?us-ascii?Q?P4PNVEQb9TvVjewWuNXASVy+rjEX/UTCySR5MU9jGMtmP/Ucw03Bjz+8YfOJ?=
 =?us-ascii?Q?ROMq8iBIQ9Gtnyw1jwtcuPiRFbn51RwJGYpJzYCWq6s4DH/neV4JDHyBpblG?=
 =?us-ascii?Q?eSK6+TlUaCA5oUd9UxudAIn8mr1khgbk1xTNzUEhZQHOnLHeamYhUQtHhvgX?=
 =?us-ascii?Q?GSgl6iPgCHkits8L+u4nIUEzuJWp1PgG/9jvo6+yql9d+oB1erFe1BfVa+Gt?=
 =?us-ascii?Q?07RW5swfWto4XXqcVHjLuzB7F5Bmsl7tewOJHjQiC57bmMV6bSuXU6XHKBOX?=
 =?us-ascii?Q?Ya/0sOqcFObceWY1VEbMrt+YiW45z/jOp6VwS6MiTpVuJCe6qA/hl4AgyqXF?=
 =?us-ascii?Q?Kcs4bgH+jly6f1NMDsBaV191wNAZ5SFM93BsPmPaUK3Tm21O9SPlV6NlpJz+?=
 =?us-ascii?Q?CDPoFb5sSstNWUCJ4vMdjVfmwaIXAZuuIQQlkhwxRbjS+wyozRL/mebOBsfH?=
 =?us-ascii?Q?yggGnVrrr1y0rbF69nNbQoWfMapgysfGVZbU60o1/BB6uZWrINRoK5KCFdgQ?=
 =?us-ascii?Q?Ja+3YVdA0Lsr+aaLmkY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2025 12:42:25.7510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ced8b4-b65f-4097-2776-08de34c4e8d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911

To support the maximum vGPUs on devices that support vGPU, a larger
WPR2 heap size is required. On Ada with vGPU supported, the size should
be set to at least 581MB.

When vGPU support is enabled, reserve a large WPR2 heap size up to
581MB, set the max supported VF to max in WPR2 meta.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/fb.rs       | 19 +++++++++++++++----
 drivers/gpu/nova-core/gsp/boot.rs |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 3c9cf151786c..9a5c40029f3a 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -119,7 +119,12 @@ pub(crate) struct FbLayout {
 
 impl FbLayout {
     /// Computes the FB layout for `chipset` required to run the `gsp_fw` GSP firmware.
-    pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<Self> {
+    pub(crate) fn new(
+        chipset: Chipset,
+        bar: &Bar0,
+        gsp_fw: &GspFirmware,
+        vgpu_support: bool,
+    ) -> Result<Self> {
         let hal = hal::fb_hal(chipset);
 
         let fb = {
@@ -181,8 +186,12 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
 
         let wpr2_heap = {
             const WPR2_HEAP_DOWN_ALIGN: Alignment = Alignment::new::<SZ_1M>();
-            let wpr2_heap_size =
-                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb.end);
+            let wpr2_heap_size = if !vgpu_support {
+                gsp::LibosParams::from_chipset(chipset).wpr_heap_size(chipset, fb.end)
+            } else {
+                581 * usize_as_u64(SZ_1M)
+            };
+
             let wpr2_heap_addr = (elf.start - wpr2_heap_size).align_down(WPR2_HEAP_DOWN_ALIGN);
 
             wpr2_heap_addr..(elf.start).align_down(WPR2_HEAP_DOWN_ALIGN)
@@ -202,6 +211,8 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
             wpr2.start - HEAP_SIZE..wpr2.start
         };
 
+        let vf_partition_count = if vgpu_support { 32 } else { 0 };
+
         Ok(Self {
             fb,
             vga_workspace,
@@ -211,7 +222,7 @@ pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<
             wpr2_heap,
             wpr2,
             heap,
-            vf_partition_count: 0,
+            vf_partition_count,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 847ce550eccf..ec006c26f19f 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -146,7 +146,7 @@ pub(crate) fn boot(
             GFP_KERNEL,
         )?;
 
-        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw)?;
+        let fb_layout = FbLayout::new(chipset, bar, &gsp_fw, vgpu_support)?;
         dev_dbg!(dev, "{:#x?}\n", fb_layout);
 
         Self::run_fwsec_frts(dev, gsp_falcon, bar, &bios, &fb_layout)?;
-- 
2.51.0


