Return-Path: <linux-pci+bounces-44594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC85D17B0E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B2903046EE0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62355389447;
	Tue, 13 Jan 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VbwGSawg"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3825938BF6D;
	Tue, 13 Jan 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296297; cv=fail; b=XyDAhr1SZjaFO7gJJvgn+H8KeWLNBGOoSLjHReltPE7egcB9jOvIRa2Xe4Y597O+ARnrClGQXjvKzksr9S5D7atR6cmF351sZCZgqgAhzBVlrumt3Ttcnqrz3WZAzj26WIzKKfHQ1JgM5XC5H3gGoA88GY2E0lUMSX9IfACC2xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296297; c=relaxed/simple;
	bh=eSBQ0il1ynUFBg/uSuucB92pc3HRvj81Bv4jgwugH/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4AvmY6tWMVwizp+VagGDbXPlqY2vhhaW7TQuDOtzjO8VQQJjBZi4AEaNu8yE0pjcztyFRClQ44xSNeDtMe8G0DTcceOmGpp8mOFhsln9LiI3AYYA5jWSnnKQCzgE9IKZeni2+/qc2M9+yHl4sVkFm3KikBqhqIoAs3BOL08/TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VbwGSawg; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gq0Bg1p3HGPoIK5lzQL8X/gtoWuitAuZrUKmBjPHmtrdjbTm619s7sDi3ki9sv4ddq9lbGmP3HOUhl+JGNTqoIsWW4o1nQhUYtJOZeddIwI4HMQa6VxyZiilOM4syB2694RaaWH8JQFNCxAcDcZRxtya5CZ/tQgnJAGvs6JCwLIGDV6Eph8WCPOwgQ5EeupJTOIIfz3xapMs8hg1jI590VwB+amwPjj80V+8gXwcHqlPnCNbn7lezGx9yX2aDE6Ax4b5Z7Non+9zUZmxNeO4SXbtSeBsKVyCXj69s2cdVBCseXwIYKSPHZgGOz6bRPToZVMOX0ThK54Tiz/XKW9kYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCyAOHA5w4C5TTvDHvY+eiRF664aprcDWS63x5OAgig=;
 b=AzdVEGAX8ibHc3B6ewGvtKNAqA9hl3hPfZm/J1V4wzzMM3i0+mRiWQKja3ltbX58r6NIUgFN+iOuUu9vloQw2uRkmsJGTH/Fz4ouA8LvXFiFoWDIc81vXpgW6bkUTQBsO5nfcP9+F3nQk4k/XJv8xpIMq07ExA10ez8ifArhu5M/rbRzEU+VVOOZY1jfbpSjrXIKl9d1zdtMrm1Zy1E5l36QmpyMhimflcyk6+golkqbSFQ8ygEqVvcjBXqriPcJUdN8k07gwGbmVC7RHsFAtPXEmzniUSYgb3r7kG65SeEAtE/0zE7ZJri92BB0OiFkN68/hOwSDcQFYh63FYtgBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCyAOHA5w4C5TTvDHvY+eiRF664aprcDWS63x5OAgig=;
 b=VbwGSawgmLKnGZVdwU0NN8lgaJHIODMUSV+RfRgf9ip4DEfIA5L/5vD7qS/dYerbYJfjpy1qMccWR/XveUFzkVmYoEDIjoEu51T4WC4bbp4icxDBbevbpzST5y9b5DjEDmJ+yrRhRN6boG3F9G2nK+luiLIDZHTgieTwLmAz07fZ7R6Kf/S/fT4bv9hifGZyPAShRrIcL+bl8OzQ2zLwcCyqUXGTkz+Nrcn5ajH6MsvnAZo9v2TSzKZ6YMZ+OGFNhsCVvY7iv2HZK97E4/0xzB2S6wO9jKqQ375S0FFrHN+oywFbQEE71cDnHd3z+zrw9P5EtlScKBZlRGVoZ9ossA==
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 09:23:26 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::f1) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 09:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:23:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:09 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 01:23:03 -0800
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
	<joelagnelf@nvidia.com>, <jhubbard@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH v8 1/5] rust: devres: style for imports
Date: Tue, 13 Jan 2026 11:22:48 +0200
Message-ID: <20260113092253.220346-2-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113092253.220346-1-zhiw@nvidia.com>
References: <20260113092253.220346-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: eee2f5b3-0eb1-413f-02b9-08de528567d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?64pKIO+d+bsLMrKVZ3cRWRTifBYv/2RG0rOPBRVWRxnKNJ47k5FjTHsqtZBP?=
 =?us-ascii?Q?6b0d9/xE+pq9ZcQc5d1N7hqH+TmEhWuanF8eiWOPnxpxrHY1ZM455NjJWvcf?=
 =?us-ascii?Q?o7id9bb3lg1BCGfWV8ba3cjDsV/xVx2OuuEC3uB9UpDkoRaq1YaBp4MYBVia?=
 =?us-ascii?Q?cOXoYiLheFXRxofEcrCdjjrhQE+kJgoWMzY6pky9YSKO4wgELffrDjihcDpZ?=
 =?us-ascii?Q?R8Ae1ZCh8b/6indllKvuZL/k4JT+pzjFmCTCV1MDjV8PgrIqS6CuR3zLaMKZ?=
 =?us-ascii?Q?Ux4fzYPa6t0T0wnP7Xv+BGhiZVM/UwWeDQtIAjRGmDlCsFHejSW6vguv7/k4?=
 =?us-ascii?Q?v10uNK04qTM2BMKS1o6lmLYnEPrdRyalKY1dnCkxpTpFuG8aEWP4pzP4Xp/I?=
 =?us-ascii?Q?sDlxxhy/tVzblC5FblZ6RUISH6luhpoPpjnak46/XIfTsA5tJOCi9V1IFRdy?=
 =?us-ascii?Q?k9EfTqQkPnooda8Ox6Exlwc574kgKBNdccTtVijhHZwPdnj4jal3KIfHJkGQ?=
 =?us-ascii?Q?vUo4Xb/ceLvh5MPq7b8b5HyKHNUqmjFHqlThTJ54EWyxN0A0ei/w/j9XjOnu?=
 =?us-ascii?Q?obSVQybHIoVjKnWYj2DrkDWTy1iqhpJgFzejuk27Eb4D8JeVugLR9ccswUVt?=
 =?us-ascii?Q?uh8C0cKJFGm67L0ToMn368QlWzS06z1U4X9VuaCmqTMa5KVx5vQm8gfTSLTV?=
 =?us-ascii?Q?g2XiL8SGcAv9deaASuLgfTVq/TyCM3VbVahobATrNhrlExKnZhojl5bffK1G?=
 =?us-ascii?Q?zZpUBjlEYPVKCNJGN1TtZ07ykeOtGHqf4z9lo5X9kRpjRV0Ob0XoElCGRl0r?=
 =?us-ascii?Q?YCSq8hadWuueHs0GJ2cWi7ajREbshMp4iGdxmiGic5RjrxYKEztK+yRit+/G?=
 =?us-ascii?Q?PEfH9PGvNx1/OHDcQlRzgP5jq7OYgvh/xKErrg9u92vWu7fH//T556uJyOH9?=
 =?us-ascii?Q?OWMgCbbId8iwUkdiXu+z2U3ElIFEoK7eM1AHzUBfYqDGXcR02VX26zGzOYRq?=
 =?us-ascii?Q?qI66xOadQTaJd2orBR8kMKyiulEMwj0tftwvpGjypI7VwZ24kmvUj4OruSnT?=
 =?us-ascii?Q?KRJTce/YZHgKAVGaNOdf0M5mR9c7AYXBtRX7A5QirNKyf8LAnlv+qLVgNBYN?=
 =?us-ascii?Q?G+yh9TTl9Sfp5towc7OYZwMQfU7rjHJILXtNmG2dGtNjK2jOtvX83w/FOeVz?=
 =?us-ascii?Q?JTEmVvmM8Xwvp1XE75P3UDGBKvcJ2/dlp86tqhoybph4u2b4i+l1T1EvOdmM?=
 =?us-ascii?Q?Blh31k+Jj3Y0MULyNdOodL8p1HSwreeCY/BKvMEm6yI2iibFMXIZgIxjHLPY?=
 =?us-ascii?Q?rslZSMu3I8nPdC7dMK9RQXMFJb5CmB4tAcUBPOoXN1lyYDTxis+wr8cy2JGL?=
 =?us-ascii?Q?lrBP7hQ3aNCsmUj5ZGy+Wdvoyu0AyC5p6jK+wVz/eNs0OtCSLxkCZgcfa4Ax?=
 =?us-ascii?Q?Dmfjvlqv3XEnek7AHlEZBeEsnkYywrwJsboMnzzbicI17y9OslazsC+agPMT?=
 =?us-ascii?Q?qqacxgUzkV5LSOiC8vuwm+PTY4f0fUqFq7GtmAdxI38ERMajtreKcPR6vqhU?=
 =?us-ascii?Q?r+rw57it0cSM8tS3Hbo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:23:25.8041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eee2f5b3-0eb1-413f-02b9-08de528567d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

Convert all imports in the devres to use "kernel vertical" style. Drop
unnecessary imports covered by prelude::*.

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


