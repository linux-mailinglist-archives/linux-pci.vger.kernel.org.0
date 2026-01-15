Return-Path: <linux-pci+bounces-44995-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F654D28B94
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 22:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C95A3015BC8
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C50328621;
	Thu, 15 Jan 2026 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s/DDMP+O"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13702328616;
	Thu, 15 Jan 2026 21:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768512491; cv=fail; b=U1bpZeRPfEdhRMoorSi5yfA7u46YA3XBr7oDVcnS9Uvu+WZUBoUHSNJ91O/IvfBhpHER+yzM/Ejx3zlRDMDBo1pB+wovRoieG2cahnasRjyqUe+Iw5G+Dve2hQdUodvmJvbXOySrhfLR6oUHGrCNECbdQ3oxOeOFxxuNKBNhe5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768512491; c=relaxed/simple;
	bh=DqyakB0pczd5oYXz81URJz+EL9N87PSXXAOJSLHMGMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyKEK0NfyGhgSfUtCjtFkuca601rsFC97XrSQqQz525ajKnVVlp3jO/x2/2HeoUwnXdRIiUvvt0mMyyKn6/dJUy3hSQRv4r/unKU7sFcWni5G9djS6dJ8Jqol0nSwbB7AyOuoUjUyikUlyQRtq/qfnLhbYCGPRyb0eYDi1rWdiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s/DDMP+O; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZUA4U1y3phPT5H5RhYO8Y/g09pXvKASL+sFfOQpye6tjzsqSvgLtZRFXw5CRblsGxNRNgmytxOCFzepbQim3hHRmTYB5yy0gek/wM72zi06LN5LCgwijmYyeTzZMsWCyFQrvz0713vZm0aNOOlq8TQ+iQydJ5ozvYP4EK2mlX/sHXGErxssGBbFGg/ZfNAenYKYpMqrCgjkSeoOLc55DTMTwWAJDmTLiTdE9GgHkcIzow2R0OMrVGzytZzQWIm57pCn1MHzi3b5aufQUxWL6dmoOO1yxNFkweDSHx48OG6rOOiAaQWg8R9Ntq+dDy9kM2G9XCyivNzarGF+X+55cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQdYErDN5g/yqRD4VrU2ofGutzfO+60Dajjx7jyM5Mo=;
 b=mzzY53AYPLqLCMOvoCFVDl1MRG2NAvfT6074FgnVuOgPP9HudxyHOnu4P07IO+RQ1UeZ+FrmHs92n1EHloHMtQ6wsU5inY3e6Z+2rnK+FdMJzmMmu/Bf6pWFu7z6gSHWAqZ7RfwY9q8sDuPid2YgaGxlK6YSoeq3RT8y+z2GzODve2w+9HQ1EQiAM6LUa6KYATU9OpUVzDO8QsrHdTeJ4n+D1E4GvOT/KNVOOR0enld515tsSRssZtmm1E/OQ0fQHYQBDvSuTktWigDo8ItdVklpg+KqN3g4BQUfepAgJQIMWjkEsfb8hHutVVfBo1bPlCDEjPrvPTOyU3tlh2FdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQdYErDN5g/yqRD4VrU2ofGutzfO+60Dajjx7jyM5Mo=;
 b=s/DDMP+Ob0beqkBlmk/cyLw9aki/HmlgMmSjMjZ47ESpzBL3DIfwrb1J9Z9EElAeK1UYJZZF1dPAxL4NR3nEAJhz2R8JjoaVPyuoEJkNbwfbaPH4/gRrvHgNpL1s6tm0BJ4KBw3/HAXoWXBcIFC7siapXOgAU2DlnxNDGkO+GmOL3hmjkG99moH32PzFfVEVPsrBPRwywyNT1X/cAs0emLNsdL31gV2waJRLppAU54ufpHqdZpXPrrjjfT0p44doGYdt8dIzjz2qvfq//ULwmk/YLwgZ8JtOS9aa/fDwcjhVVGWrEcWI3CuwJnYopRJ0P7cQzvzRYMmyAoScqvlpUw==
Received: from BN9PR03CA0547.namprd03.prod.outlook.com (2603:10b6:408:138::12)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 21:27:53 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:138::4) by BN9PR03CA0547.outlook.office365.com
 (2603:10b6:408:138::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Thu,
 15 Jan 2026 21:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Thu, 15 Jan 2026 21:27:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 15 Jan
 2026 13:27:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 15 Jan 2026 13:27:30 -0800
Received: from inno-vm-xubuntu (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 15 Jan 2026 13:27:23 -0800
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
Subject: [PATCH v9 3/5] rust: io: factor out MMIO read/write macros
Date: Thu, 15 Jan 2026 23:26:47 +0200
Message-ID: <20260115212657.399231-4-zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: ea21955e-e6a8-445b-d7c2-08de547cf128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFJzbStLR3FNZk9YQ1BFNXg4dTFqdVpFRVZwWUMrZm1IWWFlTjR5WXd6dUI3?=
 =?utf-8?B?cC9jakpKOHpoazZ6WEl5OTIxSVR3eUVRcndiTTZxWmlxN2ZTam0wQzNhaU5O?=
 =?utf-8?B?UUM1OHdXUlJkV3FSbGlvNWRJL3U5b21sT1MxRXFtQUJ6TWpld3pkcXFYaG5U?=
 =?utf-8?B?L254R1FQTDUxZXYxSTRPT0RaT1lEaHN1a1JMenpBQU5HUTh5ZXpLUjcwK1Vq?=
 =?utf-8?B?VkNydjhWQjh5dzRuaUFFc1owV3k3Q0xlM3U5TGFqMmt0bEw1aDd4RGx5bXFi?=
 =?utf-8?B?dW9XcGVma1R1eEtIc0NiN1JlYlZzUnhLMHJuYmNuZ3JiT3BrWUN3dVpzRHVu?=
 =?utf-8?B?UTFTcFlXdUJIVDlidTRCQ0xxTVUxMlJ3V3ZWb1pjdEtOV1F3bDNEZ2hsWUVs?=
 =?utf-8?B?RmJKRFkvTUloQlVZNUhvLzRKclNlTXUvOEJScUlHeXpGK3FsU3R6NlZtTEJt?=
 =?utf-8?B?a2JSNlhMTzd5Z0orcW44Qkx4dGZFekFxd1ByVXBNbEk4NU5waVZkclFDN0FK?=
 =?utf-8?B?QTh2ZVBjaDZlZW1QRmt2Vkt1ZFo0czdvT0JlK0dqa09HblBJMCsxamM2RFRU?=
 =?utf-8?B?RmdjZ0xZMHRnMVJNNnVrem02dWhqNGlFWWhmek52R3h6OFBvRlZhckNzcEsz?=
 =?utf-8?B?MXEwMTdtMmxGK1RITFV0TVhqSTZYd1htTlpGUWo3eVpKek1zNDFDeWkrRzJN?=
 =?utf-8?B?clZiVnN0YUN4OHU3UUU4SDVTQnZIVUg3TEFVQlU2SEw2RitXVE40T2xDaC9r?=
 =?utf-8?B?ZmtpU1FaQldlTVhENGdwb1RFUWlKNFRMQUJ3dFlpYkVFMWJ0Q3VTRlM5OHFY?=
 =?utf-8?B?c1BBdnUrSW1ZOUdFS0srN2FDUkE1MXNEVm5jTmk0MmpBZURMSDVMZWo5ZjhT?=
 =?utf-8?B?WXVvRkZLS2Z6UG5HV0w0TnZVZXF2OU9tblhZbzMrRGJPeDdJQ1RrR3dsRXF5?=
 =?utf-8?B?SjlLdVlKNWo1NG4xai81ZE93SUMzOE1TYkNVWXM3OGI2UW5vSFJBcjFvZ05y?=
 =?utf-8?B?N1lvUC9MM0xyUVhhOWVNbVlQS0pGYUJqYlBuN0NTNFBTS1NoWVpxakJDRkhp?=
 =?utf-8?B?bXNmTGRUTGFyeHo1V0pKRW1NeEN2eWV5YTNndk5KQ2YxVG9XL3VOZFBsSG11?=
 =?utf-8?B?TzdOckhxL1pFc0hRQzNOSTIvRjZmYXc4amhoT2V3WStVQ1VTRmJyM3BVajNl?=
 =?utf-8?B?WTRiQkYvVWxmSVNKZFRXQ21LS1pvbTdiWHk1b2xMKzRwMWl1dWI2bXN2SzRO?=
 =?utf-8?B?eEs3ZlArb0hQbEFheVl0SXpaWjJvTmFodVRkOW9BdTdqenRhbW9sTW1HV1la?=
 =?utf-8?B?aWNJM1ZMWlNBVHl1MVplbDNHcVIwc3ZuRmVQMmZrTjg2bDFITUlOTjR6Nm5X?=
 =?utf-8?B?QXo0Yy9HM2k2a1VWeTZEMkorejJEeDFOYmRaalJ0a0lOeGptM2c4RWxlQk1B?=
 =?utf-8?B?MU1VTzNZQnNBY202aVNwRjM3NTdmU2FQWDBHK3c3OFo0dVhzeVpGNkRGVFF5?=
 =?utf-8?B?N2ZLS25aK2tISE96SWNFZUJSZ3VXUHUzSmwrSERldjZpdURNUU5GZDNhZldz?=
 =?utf-8?B?dWl5eldvKzI5RDJzWXFTV04yS2E0emVGUmZ0NldSTEVDdlBqbG5QOS9LVGd0?=
 =?utf-8?B?Y1dnNU1UUVduY0FxWnVFakVTRHVCVDZrZnNONjdGMnNWSm10ZnZhS3hjd2tr?=
 =?utf-8?B?UVhoa2ltbWg4VTdQQ2E0WTlzVmxkb1pFaDdTTnlheVpERmxPREQzSWZVUkVn?=
 =?utf-8?B?Qk40UWhzWE9CcDUxVHNEaExKdllFNkgzMTNKMzZsOE0wZzFhOSt6anEzeEQ4?=
 =?utf-8?B?QlliMkRZcHBjM1dRQk1nOG4rZi9YcFZ4T0RuMjE1ZEhrQ2hGZzhSU2RxaTRJ?=
 =?utf-8?B?UVBZQ2hWbW9VVXpWMUhhVWhXbndWQmJ0cElQMVA3WWVjMWhVZ3JHRnp3aERU?=
 =?utf-8?B?S3lhNFk2dDE2OHYvK1ZRdEFQaGgrakNYTXZwTXBzTkNpY0oyUm16WGt4L0Mz?=
 =?utf-8?B?MGd5emhORU5DVE1GYmk1VFZwemUrS2tobWpGWTQxQVNPV2R4b0RRSDJMSGZw?=
 =?utf-8?B?dHRybTZyY1FFTi9BcWZ2ZUplRU5KSTkrZVdnRlVRY3NQZzhkV2hBcHF5MXI0?=
 =?utf-8?B?eVVOenNLSkxVQlRCV0tzcERZTjBnaDIrM2Vnc2J2b0xEWFEwbHB4WGRSTm02?=
 =?utf-8?B?elFkc0JFbGJLM3VZOFZXUXBNeG41cFpYTDNTNXhESDhaYjN5Rit3Y1JNZm92?=
 =?utf-8?B?UG9uVUV4RHQyTUFqSktWUStrNjh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:27:53.0061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea21955e-e6a8-445b-d7c2-08de547cf128
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

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
 rust/kernel/io.rs | 149 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 104 insertions(+), 45 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index 89d94e4fb1e3..acf8b39bd516 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -137,8 +137,65 @@ pub fn maxsize(&self) -> usize {
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
@@ -148,12 +205,13 @@ macro_rules! define_read {
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
@@ -162,14 +220,16 @@ macro_rules! define_read {
         $vis fn $try_name(&self, offset: usize) -> Result<$type_name> {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            Ok(unsafe { bindings::$c_fn(addr as *const c_void) })
+            // SAFETY: By the type invariant `addr` is a valid address for IO operations.
+            $call_macro!(fallible, $c_fn, self, $type_name, addr)
         }
     };
 }
+pub(crate) use define_read;
 
 macro_rules! define_write {
-    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $c_fn:ident <- $type_name:ty) => {
+    (infallible, $(#[$attr:meta])* $vis:vis $name:ident, $call_macro:ident($c_fn:ident) <-
+     $type_name:ty) => {
         /// Write IO data from a given offset known at compile time.
         ///
         /// Bound checks are performed on compile time, hence if the offset is not known at compile
@@ -179,12 +239,12 @@ macro_rules! define_write {
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
@@ -193,12 +253,11 @@ macro_rules! define_write {
         $vis fn $try_name(&self, value: $type_name, offset: usize) -> Result {
             let addr = self.io_addr::<$type_name>(offset)?;
 
-            // SAFETY: By the type invariant `addr` is a valid address for MMIO operations.
-            unsafe { bindings::$c_fn(value, addr as *mut c_void) }
-            Ok(())
+            $call_macro!(fallible, $c_fn, self, $type_name, addr, value)
         }
     };
 }
+pub(crate) use define_write;
 
 /// Checks whether an access of type `U` at the given `offset`
 /// is valid within this region.
@@ -352,37 +411,37 @@ fn maxsize(&self) -> usize {
 }
 
 impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
-    define_read!(infallible, read8, readb -> u8);
-    define_read!(infallible, read16, readw -> u16);
-    define_read!(infallible, read32, readl -> u32);
+    define_read!(infallible, read8, call_mmio_read(readb) -> u8);
+    define_read!(infallible, read16, call_mmio_read(readw) -> u16);
+    define_read!(infallible, read32, call_mmio_read(readl) -> u32);
 
-    define_write!(infallible, write8, writeb <- u8);
-    define_write!(infallible, write16, writew <- u16);
-    define_write!(infallible, write32, writel <- u32);
+    define_write!(infallible, write8, call_mmio_write(writeb) <- u8);
+    define_write!(infallible, write16, call_mmio_write(writew) <- u16);
+    define_write!(infallible, write32, call_mmio_write(writel) <- u32);
 }
 
 impl<const SIZE: usize> Io for Mmio<SIZE> {
-    define_read!(fallible, try_read8, readb -> u8);
-    define_read!(fallible, try_read16, readw -> u16);
-    define_read!(fallible, try_read32, readl -> u32);
+    define_read!(fallible, try_read8, call_mmio_read(readb) -> u8);
+    define_read!(fallible, try_read16, call_mmio_read(readw) -> u16);
+    define_read!(fallible, try_read32, call_mmio_read(readl) -> u32);
 
-    define_write!(fallible, try_write8, writeb <- u8);
-    define_write!(fallible, try_write16, writew <- u16);
-    define_write!(fallible, try_write32, writel <- u32);
+    define_write!(fallible, try_write8, call_mmio_write(writeb) <- u8);
+    define_write!(fallible, try_write16, call_mmio_write(writew) <- u16);
+    define_write!(fallible, try_write32, call_mmio_write(writel) <- u32);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> IoKnownSize64 for Mmio<SIZE> {
-    define_read!(infallible, read64, readq -> u64);
+    define_read!(infallible, read64, call_mmio_read(readq) -> u64);
 
-    define_write!(infallible, write64, writeq <- u64);
+    define_write!(infallible, write64, call_mmio_write(writeq) <- u64);
 }
 
 #[cfg(CONFIG_64BIT)]
 impl<const SIZE: usize> Io64 for Mmio<SIZE> {
-    define_read!(fallible, try_read64, readq -> u64);
+    define_read!(fallible, try_read64, call_mmio_read(readq) -> u64);
 
-    define_write!(fallible, try_write64, writeq <- u64);
+    define_write!(fallible, try_write64, call_mmio_write(writeq) <- u64);
 }
 
 impl<const SIZE: usize> Mmio<SIZE> {
@@ -397,43 +456,43 @@ pub unsafe fn from_raw(raw: &MmioRaw<SIZE>) -> &Self {
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


