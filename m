Return-Path: <linux-pci+bounces-37791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E1ABCC0EF
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2B1A65183
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B158327A108;
	Fri, 10 Oct 2025 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QU+nufO6"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0F255F2C;
	Fri, 10 Oct 2025 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083435; cv=fail; b=EwLVRCQ5ZdV3SnML1PtcN71sDgboPvCIMyS+6jXKJJtqoA/KCGFpoqIHSBUc+sfLN9s6k61mfR5qv2/+MOeuVnqlzNDFyFvKFp3+dbMKIUvLyaw17mVnSrSfRZBvZQ8ccSQu1cbeXNUdt5dj9qSVMfUXBLGjWSDBaYp3NTK9u8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083435; c=relaxed/simple;
	bh=eaVUQv9s6GlxjdSQCHgiSeS2lOmtoD8QF79ntRykCH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izU/693XCyagcZ1/ECoTbDZL9hCRy1G8o6zTUXCyrvHtsZTmQqj1S5kQSRkGG3/mg8cg1YF82TyNGBVG2DejEe2tSYE2JVdlHNTfsrdFXrJuLk+XvRzLoL1yN4XE44cd3WDFzZyBI6XV8lGkXZT7PS/e9S7bHD+bX+ryj8EmRa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QU+nufO6; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUMx3UvEMyYFtqJfLz3/mqUrGXeOa3ICnLiplL1DH18+8MXKX/SzAoeeaTepRds4WV7wmSB7GxoXA1Ldkp/l1YdSsEX9R7KVvS9834i9TUgJ8EaId7Lwzju3L68Dy+QK+AwLZqqDaeF9vl2pIH9VwB0TBeNJRVJM0mWL7eXvxU4o/K0ApOvEcZDpHKOFUY3Lcv5/vOr79zzUMZciT+JvF4xx+bBFgkeNX+Rs0PzZ3zlbQvqHXQzJpM/Lrejxg9diiWnBocRI4P6wHmM0LJPLSnDTf9QlDd9rd5L3zHRF5LOymTbakdeeRHycQ2cpFIDTvdAKjjQGrrHBWPKAcSjzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGLl4pc+LsoII1coWln8LUuDKulq/ixxZNXyscYzmS0=;
 b=IQso0yEYV7Nt90M+bcSK6YY7s2/LQ7j3ln9K6vF87NEe0N64rX05ppBlt9dmBka8GcMJOGwbiKJom/9oaZFRiSVLsitRz3HeTQkg3bBScL7Mam7OcHUwFApOK3e4KWcCUTgovaSC+OcAnx4aY/bj5zHDIGgeU6uhT3yinabgMrVlnpwOsr9lfYEJQlWMNTeu33ndT4R9r44lHQQ5xVNAEhaHR7fQP+Ix9/nCApPW3/jGWcNKf6OxbEk7kAx5oZTgxulKE55/1vgmNyUbg+Ol3+8TYQaE/O2aUwcMkw9h3C+k22NEhlXcxtvO8Urp+EEtWYih7UVq2yJCeP7E5oRjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGLl4pc+LsoII1coWln8LUuDKulq/ixxZNXyscYzmS0=;
 b=QU+nufO6+i0CjuOmjnxvd7F4eKIcfV4+OQySiZ1PhuOTkDYUB1/CvoxODOxFbE43UNv2DjKclcLMl9HGc3HnDW/bsZYfCKXn32ff5UBJt5LuAoQYyo9Jt0Pedis3TiyDeecsBgXlpmpoOsN5b5tzJNM1LPTqlkZcvOiPA+Dzk7lwkR9LD0J0JGtwsA33YVBhL+Vn/EUBAlztD2KwrueoP4jrdUfcIYNyiP2NKXU7HcyvxQOC65elSkSuBMlp34Xitm++snnGYiI5gW2EA8i4iEoubKMAS7BtRl/QiF0Ey5Cjgk0XnLN6Bsmn2Wcr4Ox2xooYMhu4Sa1DXp3PMGAEjQ==
Received: from DS7PR03CA0021.namprd03.prod.outlook.com (2603:10b6:5:3b8::26)
 by DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:03:51 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:3b8:cafe::1) by DS7PR03CA0021.outlook.office365.com
 (2603:10b6:5:3b8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 08:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:51 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 10 Oct
 2025 01:03:40 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:39 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:39 -0700
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
Subject: [RFC 1/6] rust: io: refactor Io<SIZE> helpers into IoRegion trait
Date: Fri, 10 Oct 2025 08:03:25 +0000
Message-ID: <20251010080330.183559-2-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d903c8-a3a3-4231-ee89-08de07d38cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z3XOFPQdNqgbcOv4UaTI56nob718liAtQ89r0o2D2eLXEWdfdklgFnmzOv14?=
 =?us-ascii?Q?nBuPvXsouv4h9lxrGRXoZrhcBgQ/3+6RcWvz7JLmes7Ui3bpV56e6TlJKc2z?=
 =?us-ascii?Q?DO9LzA7LsRMJXYKfM7eo3F0p40zxBUuOl+wLWfkdG2+6yhHqaRy3hbjm4cWv?=
 =?us-ascii?Q?HeojoOWkJTBP9y1+4nfld5qbBD1YoePfBJC4LDLsSAN3fDMGgZBI5WoI7iMx?=
 =?us-ascii?Q?EbSyJpX3qGzrpQbyda+AJT0yRO99XbxA+oUXKnClKqdP3Wgo8mmjXTo2wE6b?=
 =?us-ascii?Q?nnd9i4YDusw1n+N8b/VMlQUQRwjEwlXOx4DKooilNxR2EIAD0Y4tlRyK/P/3?=
 =?us-ascii?Q?y/nHdrJKbkrMqEqU57TocwZE16ihfjrTDgYBxFq63+S8mpXYOuBwAAR5i9Il?=
 =?us-ascii?Q?APr8gJDLHe7G+s7/KRg8191wCbXDjkphT0R1mhSivaUrdMlkEEQwp+odETZv?=
 =?us-ascii?Q?FQorW0edPZBsIzbvkoWZQsPDUFRlHBuKDemhI47TCdY7t1T+n+yDpS/2Uv4W?=
 =?us-ascii?Q?qSEu7C2o6ld2UPptt5VAdPUwVcPtAg7uq5f+cL0zwUlDgzaJbfpyONb2t++E?=
 =?us-ascii?Q?l2nxtX18EWItP9pgh2KVBl2ICF0uLIn3NL+TtC7w3qw+WfdzWHJvWXhBgxWV?=
 =?us-ascii?Q?1+O5/eqORc6AXgqemZI/uVLgk/aw2J+fkYeMSwFnrJc87GT7ytlAol+lb3rw?=
 =?us-ascii?Q?bhgoZOBWDGb791BF8BJl7dx21BMJy418TqhJwLDVzjUd6/jMInsI+cQTtdC7?=
 =?us-ascii?Q?QBCJOFx8qkigpxen6ykeq6woMr6HDLRONPdPa1relQpmKE9wr9s7DURdYxrO?=
 =?us-ascii?Q?faRHl5M8hQ5BFM/cFoxAegK2nwJYJ1uwPdl28i87JHwprz8nxzqSEsZXRh97?=
 =?us-ascii?Q?AEGMS1oPXl9B7BKV1r4wlz/VgFkax16TMlyzrUalkwTVewlQ/apM4PF3gG3E?=
 =?us-ascii?Q?N42mi9n4N9HSqqaCXOHy+LBffO3T/d4sbG399qbnquX+hqvEgyP1D0qCKDfG?=
 =?us-ascii?Q?ZaR6d3AbBvv2/VkBp6j+7XLXOz10Y4F4FEl94aL3TZL3m+kluokdFgWahZVe?=
 =?us-ascii?Q?sYedBZDHBXYi21QN60tUU1buWWg7yiH7r/04wgJA8hfvPhMTWgZ4W/cvmRlN?=
 =?us-ascii?Q?XjbnxMQpVRchQq4aHsNZdG9i+zL4q8zmzVzw7UPDNIdCAkFfYWMAHJi1EkV0?=
 =?us-ascii?Q?25mraKEtcXTej4dx/ykzERNu/h4RbCxTtbd4odk1evK8hLJUzoUSSC2LFI+p?=
 =?us-ascii?Q?fT7SVIeMRVMF5pe27PV3MMsnCtUMwmpcx7RHIdoXCRBfJhnMcckvxoXR+Y4z?=
 =?us-ascii?Q?qVuLIbKyXYogZlDWqNnI6w3E/w5cLUcmSODo08yvhvdXIMAWLKddtKyyqgaC?=
 =?us-ascii?Q?jklD1jvoeo5OZg9A5FxcfhGh4FNS95efpEP7XCAc/hLYXEVz2HJpf51f9bdh?=
 =?us-ascii?Q?UxZnN1VqoXvH7hid2LO6Ka/lFmZXw9qFoVAKxlzFgjGV0SXEYbgtrV2pm1dy?=
 =?us-ascii?Q?YWqOHoi9aeXALlArslNMH6JPen4Unmq0Ag+n2k0RwqBfKWDaEOglIRTxmB71?=
 =?us-ascii?Q?0FsKNCfXizGFhb2xVlA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:51.2977
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d903c8-a3a3-4231-ee89-08de07d38cc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

The existing `Io<SIZE>` implementation embedded utility methods such
as `addr()`, `maxsize()`, and offset validation helpers directly on the
struct.

To allow sharing of I/O region check logic across different region types
(e.g. MMIO BARs, PCI config space), move common bound-checking and
address arithmetic into a reusable trait.

No functional change intended.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 65 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 03b467722b86..f4727f3b954e 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -171,32 +171,24 @@ pub fn $try_name(&self, value: $type_name, offset: usize) -> Result {
     };
 }
 
-impl<const SIZE: usize> Io<SIZE> {
-    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
-    /// `maxsize`.
-    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
-        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
-        unsafe { &*core::ptr::from_ref(raw).cast() }
-    }
-
+/// Represents a region of I/O space of a fixed size.
+///
+/// Provides common helpers for offset validation and address
+/// calculation on top of a base address and maximum size.
+///
+/// Types implementing this trait (e.g. MMIO BARs or PCI config
+/// regions) can share the same accessors.
+pub trait IoRegion<const SIZE: usize> {
     /// Returns the base address of this mapping.
-    #[inline]
-    pub fn addr(&self) -> usize {
-        self.0.addr()
-    }
+    fn addr(&self) -> usize;
 
     /// Returns the maximum size of this mapping.
-    #[inline]
-    pub fn maxsize(&self) -> usize {
-        self.0.maxsize()
-    }
+    fn maxsize(&self) -> usize;
 
+    /// Checks whether an access of type `U` at the given `offset`
+    /// is valid within this region.
     #[inline]
-    const fn offset_valid<U>(offset: usize, size: usize) -> bool {
+    fn offset_valid<U>(offset: usize, size: usize) -> bool {
         let type_size = core::mem::size_of::<U>();
         if let Some(end) = offset.checked_add(type_size) {
             end <= size && offset % type_size == 0
@@ -205,6 +197,8 @@ const fn offset_valid<U>(offset: usize, size: usize) -> bool {
         }
     }
 
+    /// Returns the absolute I/O address for a given `offset`.
+    /// Performs runtime bounds checks using [`offset_valid`]
     #[inline]
     fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         if !Self::offset_valid::<U>(offset, self.maxsize()) {
@@ -216,12 +210,41 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
         self.addr().checked_add(offset).ok_or(EINVAL)
     }
 
+    /// Returns the absolute I/O address for a given `offset`,
+    /// performing compile-time bound checks.
     #[inline]
     fn io_addr_assert<U>(&self, offset: usize) -> usize {
         build_assert!(Self::offset_valid::<U>(offset, SIZE));
 
         self.addr() + offset
     }
+}
+
+impl<const SIZE: usize> IoRegion<SIZE> for Io<SIZE> {
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        self.0.addr()
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.0.maxsize()
+    }
+}
+
+impl<const SIZE: usize> Io<SIZE> {
+    /// Converts an `IoRaw` into an `Io` instance, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that `addr` is the start of a valid I/O mapped memory region of size
+    /// `maxsize`.
+    pub unsafe fn from_raw(raw: &IoRaw<SIZE>) -> &Self {
+        // SAFETY: `Io` is a transparent wrapper around `IoRaw`.
+        unsafe { &*core::ptr::from_ref(raw).cast() }
+    }
 
     define_read!(read8, try_read8, readb -> u8);
     define_read!(read16, try_read16, readw -> u16);
-- 
2.47.3


