Return-Path: <linux-pci+bounces-37795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77294BCC104
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 10:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B9534EC66C
	for <lists+linux-pci@lfdr.de>; Fri, 10 Oct 2025 08:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B910283FC2;
	Fri, 10 Oct 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FGm8wC2+"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87F28135D;
	Fri, 10 Oct 2025 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760083443; cv=fail; b=SszGrqNZCew8kikqTunoNrJbcVicMVscxZN+9JHLJNe+n2EK6HGu0kaxvi164eLjiNRoQd9T+eJpkQnSYRzMi0xt/ehCJY4U27IrRh3yb2h+XsLsxEavWdyCU2SGnHq75h8yEi344oi2rhRC0r6vtkI6+H33Y9HWTQ4gZqX3Mmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760083443; c=relaxed/simple;
	bh=GarHk45DPv6WH/xGBwkvr+BWhgezJ1ggcGny+pvMwik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ls8bJiu3SbfdIq5Z/2wEzh6Tee+2cdF9IYfS5/7gPcUr+OYzYLoM1HB18o43ZWwcF5QR/nd8tqgjdj+FGVpcqbep+6z0/Chvdx034PQddo9+RhQndrklI0Nhkr35RPnp6wyQlRApWsW8rwp8XSyISGddKDgz8PXlQyV326Uj/OA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FGm8wC2+; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yK5Qw8Snjhnonh5fyH5hmNNbDR26sWutYidohzYin7mCb4LNK770XOdRBkuUX70DZl84LF2+U5AsKI10B3N5LbaGgfYm7+5vzjlSmUzIfDU9HTZoKYZmUmQtgdfeP4YYAZVwTR/DXqxOoZUXhEzSiWm2AxduXgEq6mNJByerhp6H87giex3HNEh3Sv4RkCb/SPtpYChqED3OTk5yzcc71ioUsd0DSlM1XeZQD7jtuyBQEbo16X8emZ5UZHf3szbpBt80de/TGV41URuT+mW26Gx7rdlqyEndC0Sneo3llsiA4XPY+2X5Th45Xbw7Dn9GVmBEK2kxMriQUueDd9I1ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPQGulD05p4i0YiGtOLX0WteKpyWM2Apik3jxnkF9kQ=;
 b=LZwjPVJi4JbuDtXV3FK5nCYVMAp1YYhhzaO62i2HuCOLAH/gvtHF8E27EupSOlZ4kaGvkZNbEiN4PF/HMk+8XGFcp4gpugsQ/HUCwG1KKE42GDwsiN+BFyEL+SV8nW/EWAgI0tIJQXNTAeQEmozaFtshCWwYOUDj3xIlENtV01xe54l27fjPUSvfMYJlLSoG0/yLuJh6/qMCSZDXw77wUuGc3978KU7bMf/UV5U0zBFxXt66AyqRdoj5YV4ihv4BXRUQbPT8SGSKkA1ZCGfWC3umMMo9naInStTyiADSUHMc1JAzIrMWm/XAqC9lSnbP52SXcG/ULRyzrFKkw/28wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPQGulD05p4i0YiGtOLX0WteKpyWM2Apik3jxnkF9kQ=;
 b=FGm8wC2+djw7EHACr+BilFRoqcDaKENvTHYik799D+h5FVRJVgFJr7qvqMUTTcCdTbTJftbbd6E/k1VV5WgLUNWfxgV6x6bXa6zjhXg3C3Q2VCyiy7IX/jhyE9YXoegd4vOoBL1LIeJsi16N4EEtdDKuoZykeLoKf8ewtHKeL5OPt2ZEr8DqKPKib1egS4tTWGSU9IYgYkuFb6ps9kmOZl/nMJ6Zr2zpIkbvNIISDWRSdpHcTOeB0fgyL69JDWi4GVYKg6UIc2F5ScmKpOCXGOCWm/TczdRKhKRJiIbsBj45GP0tH9N4G7+/DO82QStey9N5YWQ0vmKOHen+lLlmZw==
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 08:03:53 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::70) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Fri,
 10 Oct 2025 08:03:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 08:03:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 10 Oct
 2025 01:03:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 01:03:42 -0700
Received: from ipp2-2168.ipp2a1.colossus.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 01:03:41 -0700
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
Subject: [RFC 4/6] rust: pci: add config space read/write support
Date: Fri, 10 Oct 2025 08:03:28 +0000
Message-ID: <20251010080330.183559-5-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 97349583-a175-44dc-2a91-08de07d38e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+4FcGkjNouv8amBWG2+nB8aeTZ7CC1TKjDDuIjL5+vYvp39ObYaaGbkVCj8E?=
 =?us-ascii?Q?K4ZjYLHvzasRLD+81cZsl+2byaYUG4ERvfLeEg3bT+W6wwoSZSENH85j/pbx?=
 =?us-ascii?Q?VrjzcNpc/rjyeLEUXMgNtiZW+CHsp7ju1PHGgpL/Qt9z93+vFATKB7VDg2Oi?=
 =?us-ascii?Q?IvreWzzSvuqzJ81zx2CwgvfF8d7aNF4cgqhezz4v89ZuhNlziaGWu3m42I44?=
 =?us-ascii?Q?GJnNXW/YWRaKJVL6VFggSK8dq233hVv/cvvn5pDTVemqTjpCiSc6JLqToR6G?=
 =?us-ascii?Q?21FOB0iKpxxYe3odo4KSHleiK5KfcIyrsgQT2E2gnElY4AJOXf1rNyDI2bbA?=
 =?us-ascii?Q?ub5asDpCIqhpQu4SvuIZG7u13QEVDrUfDTc3MUL9y2HQ7Fh+kvpvMFDCrJ4l?=
 =?us-ascii?Q?yHMj3j5+VyVXe48hIT3J1AxiEI55pf2z0N7dyIng8sk5LnzTgCkSmfrbiU5Z?=
 =?us-ascii?Q?bkumiX/BHWumIGw+z1tkSlU4waOKelpQSWc71S/0fLKXZzQ5gthwYZteEhzS?=
 =?us-ascii?Q?o4OMv3nZwfR4tBYmgRWEflT74MIMNvmxQLaUW3BELlJX52ufwDIK21Fy8K1J?=
 =?us-ascii?Q?hM6V4KrhEZVWTAxTDZQ5KJmttMTWQRzXAjP9gZhlmhcnFg4Qvad3AzbNBb8p?=
 =?us-ascii?Q?3UrWN3/io+HUL/n18C0Znwf3wQBN7GJFWZ5PlBbm4N8TSsIqW1dWroyutSg0?=
 =?us-ascii?Q?WKvqMEo1vIdULyRFGE/f3A/x9wtV/jHGxr75Bm7TdeddYu6g5KF29BVSicYU?=
 =?us-ascii?Q?Ii8AjkIup32wFVwjp9k7IZR/lXw6EpdOUmO4dNYKj+q8KgcI04dHD4QCj+BV?=
 =?us-ascii?Q?/czp1tjtlzNQJQJHX19fBfyZ3ttB8EsqKs2wVONC94ULQxcRo4hkBjkgQUSw?=
 =?us-ascii?Q?DVM0yCm+9FLiQfWv8g1J3xH/d72ew6/14fY3zvo4f2RbjltqOM6ELPVSFgjM?=
 =?us-ascii?Q?EjbWLu6P1giJWKHW9+P33i1I9dX9fA/Nk+fyuDWks9zTMK9WnyHqR98SHsfH?=
 =?us-ascii?Q?cU5iSQPZ81zR60iaR6vadcPDhh2QysFR3dCfxs/9R81KKJHyIBwhvSapY9ZJ?=
 =?us-ascii?Q?uBXii57RkRpdXwcZxjkPnmgBCK9NhgBLDnxvoa4l/ZQ+3/58mn1VhqHWdJ0y?=
 =?us-ascii?Q?8vs8h1/7u/cmIx2I0HNqRm0aQ/H5qFr53ILhugZ+5ymCXbK/VBXUXP1jtfSz?=
 =?us-ascii?Q?FSaCnOM5GfwTtmBod0zPvkjpjxxbX1WFQqy2uqcXr6t7nwc7mvs6JnkFykpd?=
 =?us-ascii?Q?kQqX+IJeQxHax/DSlTHYm1qqLjN3NP4FhhKNVWBI468ZChgbOBMgdipBQEDe?=
 =?us-ascii?Q?MgeCv1/jogEOTVp2zGVPWV2TSPV8H9HRo0/8JTSeyDspuNDbFMpVceiFisA4?=
 =?us-ascii?Q?9jOUCFmMhmlg7x3OldkAm1dqbje2nZmgc6HCztMaaROhOA2ECij8oa40gjFQ?=
 =?us-ascii?Q?RRLSxisTF/sZiHGfbfs5mdn+UEqN1Ls1NG3/RfPHnkLdqILdVJaJOntLYLSz?=
 =?us-ascii?Q?ZOncmjH3SSQ8bSV1VJhfL0F/gs/eQRgS8gxQhoPzC+PFwlKH7HskyYqAYBS5?=
 =?us-ascii?Q?s3SXkXfl80Xjms6xdNI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 08:03:53.4996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97349583-a175-44dc-2a91-08de07d38e10
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI configuration space. The new type implements the
`IoRegion` trait to share offset validation and bound-checking logic with
MMIO regions.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7a107015e7d2..2f94b370fc99 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -12,6 +12,8 @@
     error::{from_result, to_result, Result},
     io::Io,
     io::IoRaw,
+    io::IoRegion,
+    io::{define_read, define_write},
     str::CStr,
     types::{ARef, Opaque},
     ThisModule,
@@ -275,6 +277,65 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
     PhantomData<Ctx>,
 );
 
+/// Represents the PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. 256 bytes for legacy,
+/// 4096 bytes for extended config space). The actual size is obtained
+/// from the underlying `struct pci_dev` via [`Device::cfg_size`].
+pub struct ConfigSpace<const SIZE: usize = 0> {
+    pdev: ARef<Device>,
+}
+
+impl<const SIZE: usize> IoRegion<SIZE> for ConfigSpace<SIZE> {
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size() as usize
+    }
+}
+
+macro_rules! call_config_read {
+    ($c_fn:ident, $self:ident, $offset:expr, $ty:ty, $_addr:expr) => {{
+        let mut val: $ty = 0;
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $offset as i32, &mut val) };
+        val
+    }};
+}
+
+macro_rules! call_config_write {
+    ($c_fn:ident, $self:ident, $offset:expr, $ty:ty, $_addr:expr, $value:expr) => {{
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $offset as i32, $value) };
+    }};
+}
+
+#[allow(dead_code)]
+impl<const SIZE: usize> ConfigSpace<SIZE> {
+    /// Return an initialized object.
+    pub fn new(pdev: &Device) -> Result<Self> {
+        Ok(ConfigSpace {
+            pdev: pdev.into(),
+        })
+    }
+
+    define_read!(read8, try_read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(read16, try_read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(read32, try_read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_write!(write8, try_write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(write16, try_write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(write32, try_write32, call_config_write, pci_write_config_dword <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
-- 
2.47.3


