Return-Path: <linux-pci+bounces-45213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83640D3B829
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 21:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05B30300B34F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7A32ED15D;
	Mon, 19 Jan 2026 20:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAbl8K9R"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012028.outbound.protection.outlook.com [40.93.195.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19A2DA768;
	Mon, 19 Jan 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854224; cv=fail; b=bPaeaXMoTo2KcGlA963WbMAjGGgRfgPWG0qBTwVBrRfVdc+kYjQtoqe8V7rPtyWuz+JGpmBOVGeEUO0siiK5CLuswdEnyOmCw2ybjqPbIau6ZODY4hfFGsLcDisoZdbaZCW6P5yHyzgYAZwqGSCTpd/tCL/+LvSr6mh121por3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854224; c=relaxed/simple;
	bh=4qiRBpEWTFGSupIWM9bLuCtRJftI+SvoDYEJXDggYXo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0XS2NjNh88SB4sncGJH48OJi9DzmJNVouVw1t0qW2n7FyBOltra5/h082XiWvSOjMFg6b3SO06zQUR+f+1H9YOTkVZQi502xhd8QQK9dJH0Bh268jdG+LrRfTzg+6OwTiML933m44Z23smO1lDHSFMLUqcnthBk4eksSEdiRdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAbl8K9R; arc=fail smtp.client-ip=40.93.195.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWTJXeQTA3fFFlLuBD2CU4PCduZGuOQgVZo057H/OTeP8tTDc6qDqvsWijYVdpqNSmABg23lmpq9/8SVeP78rJEwXdZ4cqCi9u4EERsX2RGzBIebMr2iHpzqrGoFkKQLx2a92K2cLHvv5IyQP2eV8iuT18kj1DlhaG692Pf9TspJyJANc6fu+dYbgMc5bvjTjZheGXTMKcdVCpfDc3QOtBJvv9gaRHslIXspdxleUMp7W+l98qyfofP2TPA6hqVYCXuBwiPb+WV6JIscWSv0kkn38z08OhMF3NF94DWg5UgJnA+idXPGVJ4dsSXw7YB5rNAgWML0PlMSNWrpPBwvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEJpsWO+OXzIreZ+28KCLwoaC7g5k0NECLUfsRxjnX0=;
 b=rIjL/uWezl4Ohevpbj0BHjq5ykWopm+n6ftSpWYDQ5cta8tWo8k+Qy7hhs40aEdqqfR0yC0w/j3NEBEi0ioOgTMR/oX7PeHQTMbZjrKC3ictb8MJzPzjgu+khBDd8Neh4sa9nsvG6q6S7FAkDI/iO6PHOejQqXKuVJEHYOuB6gsxzjjFwc+wIWlcf5S0HUv0Cbi87nFvMkRor7mM1vFatrXxTTolMnL62LMBcm9XeqcN2MyElVSr6m1hryit7zyn2qtsKcSLxGZiZAz2YB2wZEj9mxFRehHgFS5ukgsBH0Bqe0a2XI4rPOAcKRpjhTnKpEWUGN3FX7trontdHayp3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEJpsWO+OXzIreZ+28KCLwoaC7g5k0NECLUfsRxjnX0=;
 b=gAbl8K9RdAjaOUBWa4fEjTzIDL5IqwOl5TAd//Etub85nvwt3qnPnbQ+oXuVAsWN5RM0TCC9RsMuYK1QU7n9Jzv19dEBqRAbvlsXB6zuEfb2h7ABTlJB3ryhhyF+BAtI94nAMeKAGqx9MKLIG0jV3LZT1cTw1Ac5dItGqXlA4u31SJVWqYgEQIcceXR2Lsus8zMtHjPJ5sXC0yRAo0ZMYT3sLFQyhSTiDTvU7OVN5FqN0+Lolkg9W5NXGWateKT9E+Kb6T3mAdiPS0RDWrXxX1dW9SnK6KX14nrEZSsqxlanlOuaJDLAZfSxxG4lLL0MRg1lg/gd5mJaMYSrGLRkiQ==
Received: from PH7P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::19)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:23:36 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::3d) by PH7P223CA0010.outlook.office365.com
 (2603:10b6:510:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 20:23:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Mon, 19 Jan 2026 20:23:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:19 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 12:23:18 -0800
Received: from inno-vm-xubuntu (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 19
 Jan 2026 12:23:12 -0800
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
Subject: [PATCH v10 3/5] rust: io: factor out MMIO read/write macros
Date: Mon, 19 Jan 2026 22:22:45 +0200
Message-ID: <20260119202250.870588-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260119202250.870588-1-zhiw@nvidia.com>
References: <20260119202250.870588-1-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 9201269c-a2e0-4301-a5bd-08de57989fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHJmcUJsOWZoTGFyb1pNaGlWSXRFa0I5MlJXUEI5WHEyaVNPd3lLSER4N3RM?=
 =?utf-8?B?aGZXOWorcjJHSkxhT3pvVVQ4Vnh1RmpUWkcwTy82S1cyOTcvT1I1VDYyNEk3?=
 =?utf-8?B?b1lTU1lwbmpwWTk5UnNBVW5JMjY5MGZ4YkJnb1lROGR6ZHBSV1IzajdrenZI?=
 =?utf-8?B?a2gyU3F1ZXBpQjN3cU01YjFpMHhENFpxa0pscmRoSlArRlRQTFZqUDRqQjFR?=
 =?utf-8?B?d3NKOThKU0sxNmVGeWg4cTlQWXJXWnVUajRWL1oyUWtETVN2TmZXbjJ2Tmx6?=
 =?utf-8?B?Mm9maUlCNlloY2p4eFJrcUdUOGI3bHJwbWpVUlgxNWVmYlEwQVlsMVRWUm1I?=
 =?utf-8?B?bUpwS0dTMFFDNklJc2E3S2dvSHJZU2dRWDR4cEpqOFJPa3hPc2MyQkZYQ21x?=
 =?utf-8?B?UFVGZ0xCMVdia0JvaitydkhaMzkvdW43V3oweEMvU29qN2FramkrTzFVTzNX?=
 =?utf-8?B?aldyNHNtUHhkSnNaNFlwbmc4WWlwVFRWUFpPZlZlSWYxMkdSR3JqZDVSdDJP?=
 =?utf-8?B?TzAweGZ6WFVEbWxpeFVCandqR21ibVcwQmtzaTZxbTJVYmxlMUZWb0x1NS9v?=
 =?utf-8?B?QkswK1ZNQWo1NDB2UVhZUTBWQTFsSXRBSmJXcG56MUhRQlIrTHNraHJqaE5y?=
 =?utf-8?B?Q2creUJkOGZ2RzJ3UHdOcWZFVmNGZld5cldOWk51YWtxWXhHTCtZSEhUazVZ?=
 =?utf-8?B?OHZDdEJaNzZrMUN6QzV4RDZjYVlxK01Kc0JCbUw3Ry92c3Y2c0Y2RWljMzBV?=
 =?utf-8?B?SERoKzVZeEF2c1NiU240NHBpNi9icm9OTU9KTkhDZjlWUjJwRjFjNXBlTDlm?=
 =?utf-8?B?WlFMQzJHUEIxckJHemxzTjIxTldXR3J4U2xwZDhTajZBM2RMU3pyWFRuSzVT?=
 =?utf-8?B?SmhxOGJySjhLcE9VeFdjWEJQTUExZnc0MzY1R3V4Qi9BWlBwbjgrT3h4OWdG?=
 =?utf-8?B?dzg4MHRzUWNneDdIQk92U3BGOHczb1hqYlpyS2RuU0tWUVU2aDhZa2dLYU9z?=
 =?utf-8?B?dnFTRDFJQ3I0SzNBU0duSW80VnlGMUZKdlp0TUUySDQzNG9jNGF3ek9tY2I4?=
 =?utf-8?B?aDAveFVlK3RHWm4xS1hUWUYrVEx6OXJHeVh3eVdzTUhscUNjSSs4NVVPUndF?=
 =?utf-8?B?YXZlaTRyWkU4R0FSRUFSRWhYa1FSY1ZPZjAxenhQbHJ2NWsxejduaHFNM2Zh?=
 =?utf-8?B?ZE5UNjNDWG1KVlF6NC9rSXNub1NkWWt2THhlRG9PakJjMjFxd0N1Tk1yZlB2?=
 =?utf-8?B?RWx5ZU9PbGpLZVg3NW50V1FsOVVBRWZ6enZZbGgzNlBHUDA1bmt2dEVLTkNT?=
 =?utf-8?B?WXh1OWtIOFlUbjI5UVJPYWNTTTlqZjlETVROUWVQWHhLbzhkSER5cE5DWUFS?=
 =?utf-8?B?UGowek5ONkRIbE9MLzMrUkQzUWhRWG10VUdia0c1cTRSOFlrQ0ZTc0JteEtk?=
 =?utf-8?B?OStsVjhqZVRScnFVU1kvemZZMVh6SlJNNmV5RWkxRDVtTWpuMzBENmFOT3Fz?=
 =?utf-8?B?aTBvRzNSWWhwQTJrNkgxc2UvNTdPNFF0eWpNQTU4b3pyNHVjL0NTRWJGamJD?=
 =?utf-8?B?dzhUbzUzTCtNNUJiQzRaRkVqSGxncmpqRFBOV1JBVE11YzQvdmpzTTRFYjZz?=
 =?utf-8?B?bmlWUzlXVlV5SjE3ZFhvQk9oT1UwUXp0MlVlV2JQNEEwYTM2MnVJZ0VadVJX?=
 =?utf-8?B?WVV2QUlZRnNCdTBLUGRZeTMxYWF2WmFYMFF6N1gvczdkZ0pteXNqZGRTMVpV?=
 =?utf-8?B?emM4c1FoWmQ1eWp3eTZBZjYzNm8xQnhlajNoSDNJZUIvdC9HampxbG5rYXRI?=
 =?utf-8?B?U3krZHFJUFR6UHdZcmdVMU1SN2J4SUZPaGtwNlk2dWRvcm1lSG9zYkpTbmdw?=
 =?utf-8?B?bVB2K3FCc3d4d1oxUnlWd3dWL0tQTzVrKzZFWkhhOXA2SVowVnd1YXhiQ2Z1?=
 =?utf-8?B?b3FaWXJGc2E5MGhQR3dTZExpYmxpVGwxem1Pa1VLbW5Bb05ucEpSaE9VRFZm?=
 =?utf-8?B?TmFtMDRZMjBJVTY4VGFjZUFCODhXTUNGbUlmTUU4TlgrR2Jwd1FZZWo4NHpy?=
 =?utf-8?B?Z1JHdmtTTkhHUE9PajExQWFPYTBsNzUxN0Q5UDM4cFdsdTJQOWFlcTBXeWxr?=
 =?utf-8?B?SU9LblRUMm1Rc1JDa2dFemRwcEppVGt6bTZsdlh4cE9RWUM3ZHlnRWEwRC92?=
 =?utf-8?B?WmhXUmxKS0tzWEFvaWJWejl3azJDMlBQdEdnR2tpZmp3WVFqbnVBNDEyUTRH?=
 =?utf-8?B?VVhoSWhoVHFWU1dTUi9FQno5SDhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:23:36.1110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9201269c-a2e0-4301-a5bd-08de57989fe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054

Refactor the existing MMIO accessors to use common call macros
instead of inlining the bindings calls in each `define_{read,write}!`
expansion.

This factoring separates the common offset/bounds checks from the
low-level call pattern, making it easier to add additional I/O accessor
families.

No functional change intended.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 rust/kernel/io.rs | 147 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index fa1a81ba656b..45a6120c3af0 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -136,8 +136,65 @@ pub fn maxsize(&self) -> usize {
 #[repr(transparent)]
 pub struct Mmio<const SIZE: usize = 0>(MmioRaw<SIZE>);
 
+/// Internal helper macros used to invoke C MMIO read functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_read) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the value to be read.
+/// * `$addr` – The MMIO address to read.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_read {
+    (infallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($addr as *const c_void) as $type }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $type:ty, $addr:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        Ok(unsafe { bindings::$c_fn($addr as *const c_void) as $type })
+    }};
+}
+
+/// Internal helper macros used to invoke C MMIO write functions.
+///
+/// This macro is intended to be used by higher-level MMIO access macros (define_write) and provides
+/// a unified expansion for infallible vs. fallible read semantics. It emits a direct call into the
+/// corresponding C helper and performs the required cast to the Rust return type.
+///
+/// # Parameters
+///
+/// * `$c_fn` – The C function performing the MMIO write.
+/// * `$self` – The I/O backend object.
+/// * `$ty` – The type of the written value.
+/// * `$addr` – The MMIO address to write.
+/// * `$value` – The value to write.
+///
+/// This macro does not perform any validation; all invariants must be upheld by the higher-level
+/// abstraction invoking it.
+macro_rules! call_mmio_write {
+    (infallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) }
+    };
+
+    (fallible, $c_fn:ident, $self:ident, $ty:ty, $addr:expr, $value:expr) => {{
+        // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
+        unsafe { bindings::$c_fn($value, $addr as *mut c_void) };
+        Ok(())
+    }};
+}
+
 macro_rules! define_read {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident -> $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -147,12 +204,13 @@ macro_rules! define_read {
         $vis fn $name(&self, offset: usize) -> $type_name {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(addr as *const c_void) }
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(infallible, $c_fn, self, $type_name, addr)
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident -> $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) ->
+     $type_name:ty) => {
         /// Read IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -161,15 +219,16 @@ macro_rules! define_read {
         $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(fallible, $c_fn, self, $type_name, addr)
         }
     };
 }
 pub(crate) use define_read;
 
 macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -179,12 +238,12 @@ macro_rules! define_write {
         $vis fn $name(&self, value: $type_name, offset: usize) {
             let addr = self.io_addr_assert::<$type_name>(offset);
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
+            $call_macro!(infallible, $c_fn, self, $type_name, addr, value);
         }
     };
 
-    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $c_fn:ident <- $type_name:ty) => {
+    (fallible, $(#[$attr:meta])* $vis:vis $try_name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset.
         ///
         /// Bound checks are performed on runtime, it fails if the offset (plus the type size) is
@@ -193,9 +252,7 @@ macro_rules! define_write {
         $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) };
-            Ok(())
+            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
         }
     };
 }
@@ -428,46 +485,46 @@ fn try_write64(&self, value: u64, offset: usize) -> Result
 
 // MMIO regions support 8, 16, and 32-bit accesses.
 impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {
-    define_read!(infallible, read, readb -> u8);
-    define_write!(infallible, write, writeb <- u8);
+    define_read!(infallible, read, call_mmio_read(readb) -> u8);
+    define_write!(infallible, write, call_mmio_write(writeb) <- u8);
 }
 
 impl<const SIZE: usize> IoCapable<u16> for Mmio<SIZE> {
-    define_read!(infallible, read, readw -> u16);
-    define_write!(infallible, write, writew <- u16);
+    define_read!(infallible, read, call_mmio_read(readw) -> u16);
+    define_write!(infallible, write, call_mmio_write(writew) <- u16);
 }
 
 impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {
-    define_read!(infallible, read, readl -> u32);
-    define_write!(infallible, write, writel <- u32);
+    define_read!(infallible, read, call_mmio_read(readl) -> u32);
+    define_write!(infallible, write, call_mmio_write(writel) <- u32);
 }
 
 // MMIO regions on 64-bit systems also support 64-bit accesses.
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {
-    define_read!(infallible, read, readq -> u64);
-    define_write!(infallible, write, writeq <- u64);
+    define_read!(infallible, read, call_mmio_read(readq) -> u64);
+    define_write!(infallible, write, call_mmio_write(writeq) <- u64);
 }
 
 impl<const SIZE: usize> IoTryCapable<u8> for Mmio<SIZE> {
-    define_read!(fallible, try_read, readb -> u8);
-    define_write!(fallible, try_write, writeb <- u8);
+    define_read!(fallible, try_read, call_mmio_read(readb) -> u8);
+    define_write!(fallible, try_write, call_mmio_write(writeb) <- u8);
 }
 
 impl<const SIZE: usize> IoTryCapable<u16> for Mmio<SIZE> {
-    define_read!(fallible, try_read, readw -> u16);
-    define_write!(fallible, try_write, writew <- u16);
+    define_read!(fallible, try_read, call_mmio_read(readw) -> u16);
+    define_write!(fallible, try_write, call_mmio_write(writew) <- u16);
 }
 
 impl<const SIZE: usize> IoTryCapable<u32> for Mmio<SIZE> {
-    define_read!(fallible, try_read, readl -> u32);
-    define_write!(fallible, try_write, writel <- u32);
+    define_read!(fallible, try_read, call_mmio_read(readl) -> u32);
+    define_write!(fallible, try_write, call_mmio_write(writel) <- u32);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> IoTryCapable<u64> for Mmio<SIZE> {
-    define_read!(fallible, try_read, readq -> u64);
-    define_write!(fallible, try_write, writeq <- u64);
+    define_read!(fallible, try_read, call_mmio_read(readq) -> u64);
+    define_write!(fallible, try_write, call_mmio_write(writeq) <- u64);
 }
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
@@ -498,43 +555,43 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
 
-    define_read!(infallible, pub read8_relaxed, readb_relaxed -> u8);
-    define_read!(infallible, pub read16_relaxed, readw_relaxed -> u16);
-    define_read!(infallible, pub read32_relaxed, readl_relaxed -> u32);
+    define_read!(infallible, pub read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(infallible, pub read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(infallible, pub read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_read!(fallible, pub try_read8_relaxed, readb_relaxed -> u8);
-    define_read!(fallible, pub try_read16_relaxed, readw_relaxed -> u16);
-    define_read!(fallible, pub try_read32_relaxed, readl_relaxed -> u32);
+    define_read!(fallible, pub try_read8_relaxed, call_mmio_read(readb_relaxed) -> u8);
+    define_read!(fallible, pub try_read16_relaxed, call_mmio_read(readw_relaxed) -> u16);
+    define_read!(fallible, pub try_read32_relaxed, call_mmio_read(readl_relaxed) -> u32);
     define_read!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_read64_relaxed,
-        readq_relaxed -> u64
+        call_mmio_read(readq_relaxed) -> u64
     );
 
-    define_write!(infallible, pub write8_relaxed, writeb_relaxed <- u8);
-    define_write!(infallible, pub write16_relaxed, writew_relaxed <- u16);
-    define_write!(infallible, pub write32_relaxed, writel_relaxed <- u32);
+    define_write!(infallible, pub write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(infallible, pub write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(infallible, pub write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         infallible,
         #[cfg(CONFIG_64BIT)]
         pub write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 
-    define_write!(fallible, pub try_write8_relaxed, writeb_relaxed <- u8);
-    define_write!(fallible, pub try_write16_relaxed, writew_relaxed <- u16);
-    define_write!(fallible, pub try_write32_relaxed, writel_relaxed <- u32);
+    define_write!(fallible, pub try_write8_relaxed, call_mmio_write(writeb_relaxed) <- u8);
+    define_write!(fallible, pub try_write16_relaxed, call_mmio_write(writew_relaxed) <- u16);
+    define_write!(fallible, pub try_write32_relaxed, call_mmio_write(writel_relaxed) <- u32);
     define_write!(
         fallible,
         #[cfg(CONFIG_64BIT)]
         pub try_write64_relaxed,
-        writeq_relaxed <- u64
+        call_mmio_write(writeq_relaxed) <- u64
     );
 }
-- 
2.51.0


