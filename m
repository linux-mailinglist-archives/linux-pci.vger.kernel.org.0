Return-Path: <linux-pci+bounces-40215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3533CC31845
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 15:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC5B0349CD7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 14:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34256330D42;
	Tue,  4 Nov 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfqiNm1P"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6134C330B3A;
	Tue,  4 Nov 2025 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266524; cv=fail; b=q6YsZnUQQXI7ZZFarmPUN5TjZDvstOy/P1aTPfsI/1DnmNTc87K+OgoZLKam8CUO1ICUlLukjDJEUzMEbRqTvk8UfcFDEfAHATn/y9q5TAFR7RwNTV4zI/4F0tOWuSk0Y9CjMlHUMkwPSp57Ca6aHYPBgDjcXO7jHzYzbqtWvOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266524; c=relaxed/simple;
	bh=hias5ScZwlQTAfM7AyxSX1r5HSWoS05gYshDCTYBAU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1X5VStEI1DuCVRpygd3dru3t0CW+25/vNpbt8vCLCcCEQv7DPwdfuidiSX5gixarADh+foIplV4J5Zs0e5lEbrK5+gqOWkBKXmqKeHKkhgIy5p7T30cYBApASwikja7iGqpDZqOUJUVnNJMWx4KfPu1Jo3MVSPHkbpukXhEFuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XfqiNm1P; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNBW+/LBWeKZfMdsOAupOVPvmgaIGVuldzxwdGJ/r2HTTJlpVhRUHXs+k+R+X+mKbBJ2Dbs7dl/gOMJcb+IdJQh2OKkFdQQcF2K8yTq1Wcxwt0cuGZJG8S8mqaSGgDxHztpFYVY7t4IXmYhnKWIHee5A8TuFs2tt/gK3zK5V7i76PXp5csn48c8LdJxcFpwvnwzT85/qLe0yqVMReMV/A2/2EJXl6IIPhnKCOasGhk+yg1k2SALLNEvcQcqcOh+mYoJ55dh6Urschkq2hqFwr+07MGMz/hVU5hnHF0Rd4XzDrXp/bN0NQc1F/LGbrIR5IYKJA3RY0QHQ17Tw5YNLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrvTj8zDL1L/F1mrTFcIMVm1etwwUp3nfsuT9XwljkA=;
 b=iiPr7z7139alPQS54QGqOea+4cz/KX5asCTq5OmWCCEi3qA3iHF0GeLZA0x/BclUrYUkk9kRmhVnU2uB1nxIWJvnbboTkwzC0/WHsLfgUluhqmoruOibvf9EaFe06baC0EPdpwPdQZ0VrAp3UYHHAjW7Yhw0eejoY0WNRMs9T+JGy+/EP6AR8rVrbW9zFjMMKR5PQV6XmMi/fvtpJ+Z19X4m69y/aJdpe5K9TuprXvWMYKf3rtue77Y076e9/zg3L4HOSSelYuEsr7IeaukyO49jFuWs8fke5Lp6BwgmMZ0fewkFHGoF4IT/3K0LFDCGJ1NXJEPFTOaHqa49bpywjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrvTj8zDL1L/F1mrTFcIMVm1etwwUp3nfsuT9XwljkA=;
 b=XfqiNm1PlsF/dROK7EWLd7bT/OirUHOnKwy4T+o0fvqyNLvYA3OPJe7cidhN+JuFJcAqfZUSsd/akP5MntNxQ7IOl9jtFNa6c8Q6YwftDMDH/PFfuruYi2rUxgQVbX9hJuGjGRe5cOYMKCaOT9P+WeShFHJWiUH/Khtpie4G/NfFUXhXkzdVCZPvaNZEYcyNGYrtnQl30uv8eGIPadOVQwMUG9WCOKuNp+d1YEfQYunowM2DSkIuYc2jt98KElXUFdxke6FGoSqS4+k889QPKks4Ehk1tzA+nFfpPhUYY+/Hzs1wn39OD8yCpTDzSZwVDtw2p6WcGrQLpNgSV02Frg==
Received: from BN9PR03CA0572.namprd03.prod.outlook.com (2603:10b6:408:10d::7)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 14:28:39 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::b7) by BN9PR03CA0572.outlook.office365.com
 (2603:10b6:408:10d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:28:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 06:28:24 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 4 Nov 2025 06:28:24 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 4 Nov 2025 06:28:15 -0800
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
 Wang" <zhiw@nvidia.com>
Subject: [PATCH RESEND v4 3/4] rust: pci: add config space read/write support
Date: Tue, 4 Nov 2025 16:27:32 +0200
Message-ID: <20251104142733.5334-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104142733.5334-1-zhiw@nvidia.com>
References: <20251104142733.5334-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 035d0237-e42b-45ac-6970-08de1bae7219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UvBhBs5Wshiej2sT3RfJyWtg6isWmho3xRQuvgd8Lwa9J4yn9Vxm4CNobM22?=
 =?us-ascii?Q?B3GkqTQ7Uuka42eaDOQeSP1TEHzbcXup43pnp3/gARYTfzJdEKiO0ota78qb?=
 =?us-ascii?Q?AVOT+EaiDqU84Qq6zf+/jKmGKTxGlATqSvOqb2WPBDc4IKUuTOdIm/sbNE7k?=
 =?us-ascii?Q?Z6rPjH1dNy1xUnSSDUdS620b5Q2sumiu64DZJs1l0HTuKYZ5s4U+/plGu/Jy?=
 =?us-ascii?Q?jUZpUaB90gJ4Zs4BJfHSjIZDU5o/OoDZBO8TJRVbxy9PHAgZjGv/yQdCRtQ+?=
 =?us-ascii?Q?GE2lQ/RsotKFmT2OEqFuaIXTQeextTUe6uNFwjF1lMm98SCn18GUqoWXFFZv?=
 =?us-ascii?Q?8uBN57UXz5M7qd8wkrLQIFMZh7RCE5YJa8DemxVM2OCXWSq6iNNTLtRMJ/2J?=
 =?us-ascii?Q?HKmLnev+ml99F643mt+xXzdfaPoRTbxefzt3dkRkTR4Q36fdb4k5kQvsYvGF?=
 =?us-ascii?Q?Fzkfu+i0OvqFHWLfBYTzonNlITj4xt3GBaln5x0FcCsf20KJ6FYxx0MR2UWV?=
 =?us-ascii?Q?vK0cYkkUeHXKkLZLfeMJH6suGmEvLLB9HkKCNuSLzgCBeIpvR3Us96+DfHaI?=
 =?us-ascii?Q?+ewEa6Wi53zHHHlCrI7Nrd+sZCLIvpHE4mnB2VFyFYklTLrFwuh7HAgtCAkd?=
 =?us-ascii?Q?LMvHKDSWcM8UeNsPiNmbsD3LYUNX0gxKa+Vky5j+7G74A4txkW4x8FHutZFS?=
 =?us-ascii?Q?4jzVMuG5D5j6nTEFQ5H5Cqsrjy/y6CPMjUuqqeMH8+LXA3JLYmBTHzHuRMGR?=
 =?us-ascii?Q?WRw0CAvBXMmw3kGwFLV4RokwqCZoBm4gKvY3KG2QmPphaTAxpo8iFrA7heCk?=
 =?us-ascii?Q?AKuL3WKCLdlks3cBY1BoU++qFN1Yx84CRmrL5CcWAPBkQbIqWFu06xi1Wf5h?=
 =?us-ascii?Q?K5AbukfWnlEIou7ELXvV7J0bq408Y3hjNyFu3rXb4wQ94d1YWfEcourmZEFq?=
 =?us-ascii?Q?X+O88mwv9N69F2fuvB25+mYRkCcQ/naqX0NhMeywyfPkIwloxtKqyH8OY1Jm?=
 =?us-ascii?Q?9hDMtCOX6EGNNykAS7kM7Fc+8MYNtruot+RuUzE7DYr6Zko7HoHA6OTzJ6kw?=
 =?us-ascii?Q?xg2wOLLg2JpHH2Ua7oBt4z/a1DlLPrg9aD9n5iMXwV2WZT+i+MbHjE+IS+aB?=
 =?us-ascii?Q?1FyLni0G6AnoQjt/Fx2DXGn7/8HhiUk3NW7Tf2OZoJh69y1IooN/W+88f2n5?=
 =?us-ascii?Q?NlKWswawT+kwTg30bRFDP7eK7MEWw2WC5PBCWzZ79nx7HRycPmixlw/KAPBb?=
 =?us-ascii?Q?i3WFf3qsanp/t2fhRPck8Xqo1R7Te7F0W9GvHruDiYIyZD2BHUO3jfr12EPf?=
 =?us-ascii?Q?gHk3Qp+YBPxsx4IGTWJr0hElWcKbzotwlOn6M4VfkEScDUdaLlgcAgc3lqK6?=
 =?us-ascii?Q?/S0FFS5HK20q6eRYDozcbE+d/L88nH36fzijZmRsSjUqRdr+C40ELN91OVaJ?=
 =?us-ascii?Q?gi4J3BmwlEr9c1XTmEQKrHem6rVi70+DRxs2jKmB1lSHsGvIaKRizVzvZBs6?=
 =?us-ascii?Q?Lxx3t1myZ6pROn4scYTRWH1UKn17dERDpJWTven1sDQ9ovFnGuhnVCoLh+1t?=
 =?us-ascii?Q?4ZDZgx1DsAm7TDUSPRc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:28:38.3975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035d0237-e42b-45ac-6970-08de1bae7219
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait to
share offset validation and bound-checking logic with others.

Cc: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs | 148 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 142 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 77a8eb39ad32..630660a7f05d 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -5,13 +5,31 @@
 //! C header: [`include/linux/pci.h`](srctree/include/linux/pci.h)
 
 use crate::{
-    bindings, container_of, device,
-    device_id::{RawDeviceId, RawDeviceIdIndex},
+    bindings,
+    container_of,
+    device,
+    device_id::{
+        RawDeviceId,
+        RawDeviceIdIndex
+    },
     devres::Devres,
     driver,
-    error::{from_result, to_result, Result},
-    io::{Mmio, MmioRaw},
-    irq::{self, IrqRequest},
+    error::{
+        from_result,
+        to_result,
+        Result
+    },
+    io::{
+        define_read,
+        define_write,
+        Io,
+        Mmio,
+        MmioRaw
+    },
+    irq::{
+        self,
+        IrqRequest
+    },
     str::CStr,
     sync::aref::ARef,
     types::Opaque,
@@ -20,7 +38,10 @@
 use core::{
     marker::PhantomData,
     ops::Deref,
-    ptr::{addr_of_mut, NonNull},
+    ptr::{
+        addr_of_mut,
+        NonNull
+    },
 };
 use kernel::prelude::*;
 
@@ -305,6 +326,83 @@ pub struct Device<Ctx: device::DeviceContext = device::Normal>(
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
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pdev: &'a Device<device::Core>,
+}
+
+macro_rules! call_config_read {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        match ret {
+            0 => val,
+            _ => !0,
+        }
+    }};
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        (ret == 0)
+            .then_some(Ok(val))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+macro_rules! call_config_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        let ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+        (ret == 0)
+            .then_some(Ok(()))
+            .unwrap_or_else(|| Err(Error::from_errno(ret)))
+    }};
+}
+
+impl<'a, const SIZE: usize> Io for ConfigSpace<'a, SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
+    /// Returns the base address of this mapping.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of this mapping.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size().map_or(0, |v| v as usize)
+    }
+
+    define_read!(infallible, read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(infallible, read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(infallible, read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_read!(fallible, try_read8, call_config_read, pci_read_config_byte -> u8);
+    define_read!(fallible, try_read16, call_config_read, pci_read_config_word -> u16);
+    define_read!(fallible, try_read32, call_config_read, pci_read_config_dword -> u32);
+
+    define_write!(infallible, write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(infallible, write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(infallible, write32, call_config_write, pci_write_config_dword <- u32);
+
+    define_write!(fallible, try_write8, call_config_write, pci_write_config_byte <- u8);
+    define_write!(fallible, try_write16, call_config_write, pci_write_config_word <- u16);
+    define_write!(fallible, try_write32, call_config_write, pci_write_config_dword <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// # Invariants
@@ -418,6 +516,19 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
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
@@ -514,6 +625,17 @@ pub fn pci_class(&self) -> Class {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         Class::from_raw(unsafe { (*self.as_raw()).class })
     }
+
+    /// Returns the size of configuration space.
+    fn cfg_size(&self) -> Result<ConfigSpaceSize> {
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
@@ -591,6 +713,20 @@ pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
     }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal as usize }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space_exteneded<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended as usize }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
 
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
-- 
2.51.0


