Return-Path: <linux-pci+bounces-44992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D56DD28B83
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 22:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B436930146C9
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8238A327798;
	Thu, 15 Jan 2026 21:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CJW4TClv"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC80432AADA;
	Thu, 15 Jan 2026 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512469; cv=fail; b=ktoxvCx5sN8UNtKtFx3TrQ/XNT76gx2IXELOU8SsxHk9ebr9R07JWQ1jwtxOxYnGAxe02x1XwZL9fcH0ypPvTGG/MyLQLHvojMMzYkjKM9GF+ZbbAzUJ7AvllfrN3r5YkEwPrXfFYO2+2f2qoKk6JuwgEbizlty5Qeu03KbbB+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512469; c=relaxed/simple;
	bh=EsShzTv5X+LIYL0VqXOlCJdlv7K33vhnAuzsuxrWxLY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNhztx4wWee9P6VOnheAxG/dwrYYWOlRKtBEpzxXyCCLqiZp1B2ASmvEAKZbHC2xkA2gJ83eOaH0yGTaJMwyVpaZP8VKOSnWuqFyytexN13eAuvEPZvgQX91YIlXN6RLQURiSd5GU4YfAdYfUB1Z/FjmCCQQ1dFZMJ+kNplz+1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CJW4TClv; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0Y1yZMASy/0og8k0zWVCGI4/gt0jwI2BLwpMtu3WPKXSUkU9FNxbzTCH2INI4EdVQ15rHOlFDHH+xsTewiYw2kYBSwZsOv8X86Rke38mvNI814CkvVAdy66FtKUmrdn6VPkzKY7JIf993SD85oZfsTXlhlaswlIFvjVSDzJz7btV9nbatuXdzWEsduParSqtOnnpbkzNgjvvfslxCFJQPDcOI8BqMaoCqhOWqMBeh+XzS1lSh5cYKpdq5ekC2azgYo3aGjMa/rozjUBboa+kJutUEzk/EGgslm1OK1y6C1hby8r7v9LcC57ftJ31+Ch9ybG6UdmKFcmQjVN/lOU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZM+2II1Ld6KVGrHl9AO5KF9yVfacq6NPmCO61Ovqe0=;
 b=vMcCvkwXsGPGw5Y/2n+YaW027oYe2xT2xlLbNrL0QwjNsXFV2xkDocijTFAvjd+npJ0Nb+btipNK6485sp1R1Z2CZizXr67V6/h372IrN53g6zw/wnLtOvhEghFQKM0jGSvA58odhHro57ZqxS5ObScCqF01QDW/m8FjZJyd/s1tbN7d44TFD2w5jqXkg8Tqi4Gd4N4JQNA4FKB3TfadrXGjHacbRoRaGEqS9qHtM9g6IuszHs4E3PCntPlQKKAu3IUFuYOk30aOUWRrkbmwDTktuRM7wisyswFAOaT9ccQ81wcb9L20N0UJG35pXoy9Piz9UH/JjTc3QWP9UT/pPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZM+2II1Ld6KVGrHl9AO5KF9yVfacq6NPmCO61Ovqe0=;
 b=CJW4TClvsvqsAARpdCpb2EjlvTErBHfNbksdL0SEqcrCjgyxGKJCu+WhWYf9gqoonqS8+8g3MhkjA0Ef61FPhxzgmWJrxI5ZCV5kLvY54gpRi8JHt30A4BP0h0FkVJ6TazUtBFTUzbB9K7coEAWuxKK1Sok71b6Plcda92fRKxdrpw6PPf7ZuAJcC/TtFbwSPqA5yi09iHg4osISe/nn5js01ZAJmOvqcyr7s+eSeWtJ1vXO6EV0PIGzYDJktlYA22mhKNNW9Jm4PKk72EaWJpnVnU1sDH8gB4C33YGRzmAwsGXKQetiV+d+a75RHJLUQ0BpJeTfDKHVutqRfmfrEQ==
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by DS4PR12MB9745.namprd12.prod.outlook.com (2603:10b6:8:2a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 21:27:43 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::f0) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Thu,
 15 Jan 2026 21:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 21:27:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 13:27:37 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 13:27:36 -0800
Received: from inno-vm-xubuntu (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 13:27:30 -0800
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
	<daniel.almeida@collabora.com>, Zhi Wang <zhiw@nvidia.com>
Subject: [PATCH v9 4/5] rust: pci: add config space read/write support
Date: Thu, 15 Jan 2026 23:26:48 +0200
Message-ID: <20260115212657.399231-5-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115212657.399231-1-zhiw@nvidia.com>
References: <20260115212657.399231-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS4PR12MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 84659009-8a74-4d15-e2bc-08de547ceb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M05DRnBiRit6QXd4S3ZBU2ZFdkxpakpXVTd5VVBVUUlaMndWZnhZeEZFTG9J?=
 =?utf-8?B?cWxQZzFOL3N3SDRnQ1JzODF3UVhWL3ppRGVYZGlkZDRVL3htN3RJU3kwbGZV?=
 =?utf-8?B?SVVuNTROdkVjb2pkbmxUbEZjQzJGZXNFbGNQZzc3TU0rN21GRzJYdjVocHpo?=
 =?utf-8?B?Ty9QTEdBWWM1WjJWQk5yRnN5Tk9uNFRWenRvS1MwcHF2ZEdmZHpWWmFSUXBo?=
 =?utf-8?B?UStSQVZ6RVQwVVdTQnR5dVBRWEIxckxVbUZ5T21lVUh6dlAwbGFQUTRLaTNC?=
 =?utf-8?B?QzVIT3B1YjFXLy9aOTdhQURTOERUT2ZRak5DelhxQTViMkc0N2FONUdtVkpW?=
 =?utf-8?B?akNESG8rQjVRK3RCU3VBNDF2c3hpYWRvc3BTWGFqMzJnbUxUbXhoaWtOKzBz?=
 =?utf-8?B?SEhlcEgwbXBmOWF5cTNEY0FGK005TTlNcjZxRW9LQXZWQmpmdzg1ZXJnRGl2?=
 =?utf-8?B?eXZodTN1N2VmZXZmL0liakx3bU1ETWpnaUIzQWszeURNNHFhS1Vtd216SGNo?=
 =?utf-8?B?UmI5Z3c0SCs5U1hiQ3lWTmZGaXFjWEFBamM4Uys2WXR0N0ZTT1laMVd1NDlo?=
 =?utf-8?B?RVRWQzd3WnJRZ3hnQmY0UnlGS3A3UXZTaTJTQ0Y0NXk1RjNzTG8vdWZZR294?=
 =?utf-8?B?d2VjTXJJa0RXdjNwSklyRkpERVBKeENTQ2g3d0FOS1h5azJGejRFMVhyQ3VE?=
 =?utf-8?B?WGQrZjc2azZ5MmtseDEvM3hxY1BoNkNSekZqU2dRYmZVRjQ2R0VDVlA5bmpo?=
 =?utf-8?B?b001a3gyeUZIZ0trc2xJd0k4QWs1M09RMVFaUjlDQ0NsRXRwT3haN1lOcmRM?=
 =?utf-8?B?SFJFTjBKendYdU1xNGdheVZwU0FBQkp4bFIyZmFlQW1XMGVhcTE0aUN0WkUz?=
 =?utf-8?B?ekxMVWU5bjJEOU5ReDN1ckpLQVhPclUzZUV3STlGdTFMSC9NcktkZ1JrQ2xJ?=
 =?utf-8?B?WUI4UDU0S05TRHNMd1pPaU5xWVBxa2xaWnhOdG4yM0xoaXd4WFhPMnZ5dkN1?=
 =?utf-8?B?SFh4Nk5GUm94dzdhMXNlbzJ2Ymg3aFI1cEEyRUIvZnZpL1ZqOXBCNS9VcStr?=
 =?utf-8?B?Wk9TVjFSb2I0aWFIWmxGQ0dCQ3ROTG1laTlLM0hiZHJKd2VnOWQ3VEhidHJt?=
 =?utf-8?B?ZHJybEpoTlVHRmlvc2EwbUFZNXU4cVJKQm1JdjhBUStqNDB5S0E1cDgydys5?=
 =?utf-8?B?SG5jaStUSVRNYU1qZ082NlpVOU9tQ3pYdTJxSjN5dlpRVHg2dEpoT3U1UjA1?=
 =?utf-8?B?MmRqMTRkS1NjOXpRaW5SejE0QWZ4Y3IwbTFGYXBIOG1CbjhGNzN4TzUvQXlF?=
 =?utf-8?B?N0g4WVdYbDU3dXBOVExpbFBzS3QxTElQMVJMdUtKSGNGbVRlckw0bnBxNm5r?=
 =?utf-8?B?c1paOEgrR3FiTiszdHdHS2pQSmw3djBZZGFCN2FBN0M4ZkdkK1hJT05HRHBQ?=
 =?utf-8?B?Z2hTVnk4M3gyZHBjakZkOTdobkdXNVZZKzVsdXBZNENackkrM1p2WjlxTjN1?=
 =?utf-8?B?NTR5ZVRuMWNQMEV0cXcyaFVUaVMybzlXbUM1NE9YUEdTdjVGZnB2eU1JdXBo?=
 =?utf-8?B?S1pCRzZOZU4vN2N2WjAwUVNTVmViZmRzQjRwWFhtcVJmcG9mc0lkOURlUXV0?=
 =?utf-8?B?YmZydTFCOWhlZFdmak8yMW5LSVhCNHhQOTJDSnZiU2xZdkJqR05vNDg4MmY0?=
 =?utf-8?B?YTg2SzZRcFlvV2lYblJHVE1Qemx5YXhPK2VLN3pkb05nMUVxZkdqK2dFZWpP?=
 =?utf-8?B?ZzBBdHlNQWNkWExjZGw0YUk1VGJPdnVwb3J1czBNa1hQOTZEcm0yNzBBT3Rq?=
 =?utf-8?B?TXlpZzNmY0pDSWhPWThhamJKWmlWWUhNOGxmMVMvclJwMDZwdU9jZCtUU0dq?=
 =?utf-8?B?VG9xQnN3Y0E2NlZaVGYyMUorNEZnUHFYL2ZpNU9MaXBxSm9sVWRhWE44K1B3?=
 =?utf-8?B?WS9HN0N6QUlTbzJLRThURm8vcDRKU0ZObXdkTmp4eFBZQjZRN1dReThSVVBG?=
 =?utf-8?B?RGFtWS95QWZrdEhKMXdyTDRrYXZwWFdtSzZjRUdsVGovL2RibTIramc3UWV5?=
 =?utf-8?B?eUxlRVlLNEZmUEtkVytzYXQrSmFndlExaTNuc0lTalpPa1BmL0MyVURDZzdS?=
 =?utf-8?B?aHJiai9NVkVGYVY0Q09zaGFyWXI4WVNmVDQ1aFJvYjliV0dxc1A4b1EvRG5D?=
 =?utf-8?B?c3Y4WGNxQ2YvWDlheDNIc2c5OFNDMk1BWmZSRnZ4QkkrTjZJc21HTVpmUDc2?=
 =?utf-8?B?M0ROcis3WFc0K3hqVlNvYWwyOUl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:27:43.4846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84659009-8a74-4d15-e2bc-08de547ceb62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9745

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
 rust/kernel/pci/io.rs | 151 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
index e3377397666e..33495d063af3 100644
--- a/rust/kernel/pci/io.rs
+++ b/rust/kernel/pci/io.rs
@@ -8,6 +8,10 @@
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
@@ -16,6 +20,125 @@
 };
 use core::ops::Deref;
 
+/// Represents the size of a PCI configuration space.
+///
+/// PCI devices can have either a *normal* (legacy) configuration space of 256 bytes,
+/// or an *extended* configuration space of 4096 bytes as defined in the PCI Express
+/// specification.
+#[repr(usize)]
+pub(super) enum ConfigSpaceSize {
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
+    pub(super) const fn as_raw(self) -> usize {
+        // CAST: PCI configuration space size is at most 4096 bytes, so the value always fits
+        // within `usize` without truncation or sign change.
+        self as usize
+    }
+}
+
+/// The PCI configuration space of a device.
+///
+/// Provides typed read and write accessors for configuration registers
+/// using the standard `pci_read_config_*` and `pci_write_config_*` helpers.
+///
+/// The generic const parameter `SIZE` can be used to indicate the
+/// maximum size of the configuration space (e.g. `ConfigSpaceSize::Normal`
+/// or `ConfigSpaceSize::Extended`).
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
@@ -144,4 +267,32 @@ pub fn iomap_region<'a>(
     ) -> impl PinInit<Devres<Bar>, Error> + 'a {
         self.iomap_region_sized::<0>(bar, name)
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


