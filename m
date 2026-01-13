Return-Path: <linux-pci+bounces-44591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D7D17A51
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 10:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CCE730EDFEC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0E738B997;
	Tue, 13 Jan 2026 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mIwkobO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A7638B7A9;
	Tue, 13 Jan 2026 09:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296237; cv=fail; b=YnYC3H7qOFppX0bJQPDJw4C0ojLCqF57fF3ohJyEcLbFPRO6r8iKD7aatmcDfLiQbJHTP89Ahvh1ldWXfPSi5Eymh6mYwgOZ5BSFIm6WosGL+jqEvMiA1T4sG7HuAy5GWjVxdx9pRU4XjTq/BV7wOBJMiWgj2YizrA2jreE2ekI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296237; c=relaxed/simple;
	bh=kzYoeuokPunEtsTYzoA+hzASkC5c3bXNz5Bad/HFDeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0tV3J1QrOeSfYHK0gh74vhM9yM1L/pXz/Sgj4olv6TOAGDANmsYwHQJnPd/gMr0TYjnSRfNlbvvRm7SgsKUxCWkjvUaV1KK2faNVQe/V6r9fCYjvUdnKnbXoo0GKghbcdbiOVaBqubuUXfE6LAnuH7cciOPKubaNZT1Gfw1LUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mIwkobO8; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dermEm6VLX+boeRPEFp5l6kZP89SrfL1RlurnBDFxzhkqZgjk3eOBxbN9iVm8a1vjmpHjV9AaMxeLR7JLHU1olVBktYSnx/67oXmsnAnERb9EeSBAAwNnjS7HsOkf1a8eP++9hL8sDuMVZ2d2dcuK36saAOtPTQjJ3fhFMYuQxBCTYhUncVsJ9lPDaOybU/7acq6+IV11tsXRrsc90EPIa6jESDEhr9wH0RZn+V9qL3OcAGT6WtjeD5uvK/G3AeHmUG74ZhDH7jlydTLUMZ5vlDifhFV6PlCU+VcbLpJrPsi30dI43oqyslgTV6dfxf+tgqjtcqMi5jP4/d9Y7RgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8r1OKwuA6HKWItdGQHC5SNEQop1mrjWntr5zpDARcc=;
 b=gnWK8yC9eZGctYhKbzwjr9zdUVsviBVua+p6WLz5N+/KMfP7W5ZgNANz1j220cE9I91g3mXKFuEpzK2SDjryquv7SYRfIBUt/+E9dTREHeNswCmmeiUjYQOJP7PAr8whrdyJQd7N7vG0hse98mHN30uEfHBqaDz6FspwyKwQr/v2Z/BY+pJEBNaokrxmT/gKKPmzDGLnbqORVJq9sXisfXjf9svgFTR0IH6tp+aanRcKBh3WUxbEcnOgL1p19WVjAaY8ciEvLackd6aF9qqbwQM3ZxPMLj7rUHVzEjV6DdttxDgIc/BSe42eHgPlGdV9JPfWo2WQJFtvwiT+QWGQ2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8r1OKwuA6HKWItdGQHC5SNEQop1mrjWntr5zpDARcc=;
 b=mIwkobO8zYd0ABqOKASXqCp4Uwg6PADU/ZdJLLLdkK+VATl7t+wNZr9GTH+xh1jFULz2taEF+9nKbLdhFXedyig9sNiPH9p+5Q7Eq+uBeZt9TEOQFJ0e0H8RA46GmaRs7Bmu0EzUJXhWvk8C0hpuozjlOdeq2WM9u9N8fPgvH93wjGVYOcyy6Mg7oZWn8Aupv95gleHRYa2BmKSFhQE9hXjzVOFpQ7dHpSeNNDxZdFRjkMzfJZIafUacUC9w8aFBMyXdSe72HxMcY7na2coH4M4gQZXSRTp8lPHiDYHSrs2UZWgs1GEDxWXG7yW6lXC70wLx0NzR1ZHgYlb4cK73Hg==
Received: from BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:23:47 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::a1) by BYAPR11CA0078.outlook.office365.com
 (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 09:23:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:23:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:30 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 01:23:29 -0800
Received: from inno-vm-xubuntu (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 01:23:23 -0800
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
Subject: [PATCH v8 4/5] rust: pci: add config space read/write support
Date: Tue, 13 Jan 2026 11:22:51 +0200
Message-ID: <20260113092253.220346-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260113092253.220346-1-zhiw@nvidia.com>
References: <20260113092253.220346-1-zhiw@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 209f8fad-a206-4a06-4df3-08de52857447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0cyVXhzSGdhTkloajEzNXBiczFUNnN5NlNTb0ZtZDNUK0VmTnQrM3IxbUlp?=
 =?utf-8?B?TllXY3BOTE9od0UwTGlzaC9XSXFCallmTkNhaEViT1l6Vm8wNW5qRWtJSVdq?=
 =?utf-8?B?Yjltd3ZYK29ua1daczF2VlJTQ0hNbEJBd2xJS0gxVERkQmhWRHFGdTQzUlNI?=
 =?utf-8?B?a3A4WnprNTFwR0pZN1B2bTF3Mk5jNEVHOVpjd08xOHZnYXMxazlmaWJ5ZVJy?=
 =?utf-8?B?T1ZHeFAzV3B2NCtFOEhRYnA1dENmRld6MGVCT0lWekVOTTU1MGE2NGJYWTlQ?=
 =?utf-8?B?eVRPU0FDVStEelVGbFozZXRQcUptYUtWbzNsWU41eDBQeHN4djNRMWdlenlP?=
 =?utf-8?B?NmdtejVDaHNaUXdFS3lXRnpWaHlrQUs4SlpacGp1cnpFS1F0cm43dXJaam5m?=
 =?utf-8?B?ZDhLN1oxMjNpZGxUdGZYOWVVbHBaZ1E2WEQwbUJUVFM3NmcrSHYvNUJ5TWdM?=
 =?utf-8?B?ckZvOWtydE1QL0JGbTNzOVNQTmgrcElEK1Jrd2ROUHZDRmZFclVZeGxOejZ3?=
 =?utf-8?B?VFJ6ck1MZ0FWTXRidjVzbWlqdTgxQWVGZzJPWlBmOEc0YVkrT3pqRGg4YTh5?=
 =?utf-8?B?VDByZ3Q5aGp0NnRMZHV0Qm1NcitBTVphWHF6aDZsV2JjSGk2SFI4Q25IU3VT?=
 =?utf-8?B?S0Y4NXpZckIvU2t0c1ZMV0Q4Tkd6aFgxZHpmbERBbzMrRzN2bTdwVWxjS3ZG?=
 =?utf-8?B?V0JoaEcvTTRaNmZzVWhEa0phV0oyRnYyaGhjemFpV0lSRkk4SjhPc1cvVjB4?=
 =?utf-8?B?a0h4TWJxQThjbzN2ZTQ2UEpEeHB1R2h4UkpSbGJ5bW5rQmM3bVgwa2I0bnl0?=
 =?utf-8?B?bHdKWHBOQXFnRWIxTmUrK21UOURLY3Irdk1QLy9wYmhPdTEzUTVsTXNMWENw?=
 =?utf-8?B?OXR3UVp0c093djkwTWNRRlRHeGR1eGVlU3ROQVdJaGNrK24yWElMRDVsTVVX?=
 =?utf-8?B?UEZ2dE45clJKWmRtOThjVnFjUkIwdXlQTGZFRkJ0VGkvTFNHdlpGOW9uT2VS?=
 =?utf-8?B?aFNnQ1VyZFVpeFFWcmJBS2JBU0t2cW02dFFQa0M0Z0NkbU9Nc1R0bHNwMURD?=
 =?utf-8?B?WVB2SnFQMTE4bzIxU0dGYzI4cGovTS9IcW1aeXhpNGxWVkwycHNxSmZpZ0Fq?=
 =?utf-8?B?dHl3M21ocklrV3JoSG9zZ05aT25OTk5TWkdsNEZXNm5jOWtEd3ZkUFFpS3BL?=
 =?utf-8?B?RkVFSzM2VloxcHM3WDV0eG9ObE4rUUZTUEIzNmVydm1IeTNzeVU4RGp1WWtL?=
 =?utf-8?B?aTNka0t6cHd4dTAwYktlWEVVM3ZuY2FkTmpoMFJ3dFBuTHpFbmpIYjN6dzRq?=
 =?utf-8?B?T1c4S1RQbEE1WDVodTYzQjFLRFg5VUlOdjdxaEZzTUVqcnZlUXFYV1hOTTUz?=
 =?utf-8?B?TFlWZXN6WHFTNXd0ZUtlUU8rNzhpSjdEeDhUeHJCWk5nbk5kUk9Fbkd0d0k2?=
 =?utf-8?B?RHZEbWFDOXJMUEpZR29hY0pQci9vQ1FJR0E3aGxwNmRjTWhlcSszdUVQVmRy?=
 =?utf-8?B?K1F0TlZPVzlvWjMrdHJLd2FueE5lT29vZWtWb2ZvV05wb1ByUUREYm1ySVZj?=
 =?utf-8?B?MTJMMjU5YWlMZm02VjYvSVdBUHdTK3JvVk9ub1RkTWthNG9wZE52YUEvZkp1?=
 =?utf-8?B?dU9keWttYVpndmxwWVhUUzBURFJGK2JQRnA3WG5uZitybzJyaDNhUVowbjRE?=
 =?utf-8?B?UCtNTFhldjIyUDI0ZjZybWp2UEwvYjRKaDNlcktQN2o5NWt1ZXp5T2xYZ3Av?=
 =?utf-8?B?MDBoUnlON3FIYTVWS0JZSEhNcXdjMTVjRUx2WjRONU5INk1Nc0svU1FrOWRY?=
 =?utf-8?B?QzY1SE52VXFpZ0NnQWFmVmsvSjc2dGh6YXV0RmFCYTNYSnRvalNkQ1NxUFMx?=
 =?utf-8?B?eFc5UzNGdm5PZTBlTHJCT3ROTmtxVXlLS1lwM2hSVGZqZkRTZHN2ejMzbUtj?=
 =?utf-8?B?UGFKU2trSU0yRHVKQW56RS9zZzlJbHVQSjFwVS9Dd2svMlk3b28rakVWNWxZ?=
 =?utf-8?B?VHdnL014TE5JZW83WllSdUtWOEhOOTM2RDU1U05LbTlHMmlDRGw5OXhnQXh4?=
 =?utf-8?B?M2hBcExzYkhFVnlrQlRYRE1HSEQ3WmlmS2N6R25BeXJuM1NpYjlHZE9WNTg1?=
 =?utf-8?Q?rbbY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:23:46.6900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209f8fad-a206-4a06-4df3-08de52857447
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562

Drivers might need to access PCI config space for querying capability
structures and access the registers inside the structures.

For Rust drivers need to access PCI config space, the Rust PCI abstraction
needs to support it in a way that upholds Rust's safety principles.

Introduce a `ConfigSpace` wrapper in Rust PCI abstraction to provide safe
accessors for PCI config space. The new type implements the `Io` trait to
share offset validation and bound-checking logic with others.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/pci.rs    |  43 ++++++++++++++-
 rust/kernel/pci/io.rs | 118 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 82e128431f08..f373413e8a84 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -40,7 +40,10 @@
     ClassMask,
     Vendor, //
 };
-pub use self::io::Bar;
+pub use self::io::{
+    Bar,
+    ConfigSpace, //
+};
 pub use self::irq::{
     IrqType,
     IrqTypes,
@@ -331,6 +334,30 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
     }
 }
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+#[repr(usize)]
+pub enum ConfigSpaceSize {
+    /// 256-byte legacy PCI configuration space.
+    Normal = 256,
+
+    /// 4096-byte PCIe extended configuration space.
+    Extended = 4096,
+}
+
+impl ConfigSpaceSize {
+    /// Get the raw value of this enum.
+    #[inline(always)]
+    pub const fn as_raw(self) -> usize {
+        // CAST: PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `usize` without truncation or sign change.
+        self as usize
+    }
+}
+
 impl Device {
     /// Returns the PCI vendor ID as [`Vendor`].
     ///
@@ -427,6 +454,20 @@ pub fn pci_class(&self) -> Class {
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
+            _ => {
+                debug_assert!(false);
+                Err(EINVAL)
+            }
+        }
+    }
 }
 
 impl Device<device::Core> {
diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e3377397666e..c8741f0080ec 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -2,12 +2,19 @@
 
 //! PCI memory-mapped I/O infrastructure.
 
-use super::Device;
+use super::{
+    ConfigSpaceSize,
+    Device, //
+};
 use crate::{
     bindings,
     device,
     devres::Devres,
     io::{
+        define_read,
+        define_write,
+        IoBase,
+        IoKnownSize,
         Mmio,
         MmioRaw, //
     },
@@ -16,6 +23,101 @@
 };
 use core::ops::Deref;
 
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. 256 bytes for legacy,
+/// 4096 bytes for extended config space).
+pub struct ConfigSpace<'a, const SIZE: usize = { ConfigSpaceSize::Extended as usize }> {
+    pub(crate) pdev: &'a Device<device::Bound>,
+}
+
+/// Internal helper macros used to invoke C PCI configuration space read functions.
+///
+/// This macro is intended to be used by higher-level PCI configuration space access macros
+/// (define_read) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
+/// return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the PCI configuration space write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to read.
+/// * `$addr` – The PCI configuration space offset to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_config_read {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr) => {{
+        let mut val: $ty = 0;
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
+        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `i32` without truncation or sign change.
+        // Return value from C function is ignored in infallible accessors.
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, &mut val) };
+        val
+    }};
+}
+
+/// Internal helper macros used to invoke C PCI configuration space write functions.
+///
+/// This macro is intended to be used by higher-level PCI configuration space access macros
+/// (define_write) and provides a unified expansion for infallible vs. fallible read semantics. It
+/// emits a direct call into the corresponding C helper and performs the required cast to the Rust
+/// return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the PCI configuration space write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The configuration space offset to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_config_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `$self.pdev` is a valid address.
+        // CAST: The offset is cast to `i32` because the C functions expect a 32-bit signed offset
+        // parameter. PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `i32` without truncation or sign change.
+        // Return value from C function is ignored in infallible accessors.
+        let _ret = unsafe { bindings::$c_fn($self.pdev.as_raw(), $addr as i32, $value) };
+    };
+}
+
+impl<'a, const SIZE: usize> IoBase for ConfigSpace<'a, SIZE> {
+    const MIN_SIZE: usize = SIZE;
+
+    /// Returns the base address of the I/O region. It is always 0 for configuration space.
+    #[inline]
+    fn addr(&self) -> usize {
+        0
+    }
+
+    /// Returns the maximum size of the configuration space.
+    #[inline]
+    fn maxsize(&self) -> usize {
+        self.pdev.cfg_size().map_or(0, |v| v as usize)
+    }
+}
+
+impl<'a, const SIZE: usize> IoKnownSize for ConfigSpace<'a, SIZE> {
+    define_read!(infallible, read8, call_config_read(pci_read_config_byte) -> u8);
+    define_read!(infallible, read16, call_config_read(pci_read_config_word) -> u16);
+    define_read!(infallible, read32, call_config_read(pci_read_config_dword) -> u32);
+
+    define_write!(infallible, write8, call_config_write(pci_write_config_byte) <- u8);
+    define_write!(infallible, write16, call_config_write(pci_write_config_word) <- u16);
+    define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
+}
+
 /// A PCI BAR to perform I/O-Operations on.
 ///
 /// I/O backend assumes that the device is little-endian and will automatically
@@ -144,4 +246,18 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
     }
+
+    /// Return an initialized config space object.
+    pub fn config_space<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Normal.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
+
+    /// Return an initialized config space object.
+    pub fn config_space_extended<'a>(
+        &'a self,
+    ) -> Result<ConfigSpace<'a, { ConfigSpaceSize::Extended.as_raw() }>> {
+        Ok(ConfigSpace { pdev: self })
+    }
 }
-- 
2.51.0


