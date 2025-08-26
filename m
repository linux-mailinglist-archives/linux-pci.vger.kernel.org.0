Return-Path: <linux-pci+bounces-34806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AF7B3755A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3523A687C13
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06193304965;
	Tue, 26 Aug 2025 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A9rqcHCR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1976F303C94;
	Tue, 26 Aug 2025 23:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249963; cv=fail; b=NyeWA/PWJ5txvrReu8ww9GShdQIgrmorMFvWfPFTfuFH9FRFlUq5H3+cuu1pdmJ5H+h5zgn9Qcoe4Yg9rhHRMl2Nbec47ItkPPUxqcnWS6F4VShT/kY4YI/1P5h42sXc8emUe6w4fDOv5+eD8+dPPDo8yg0V4a9UtwA8pmNuv/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249963; c=relaxed/simple;
	bh=SR6+PuZJEUBND4pWPc43lDHObweirmQFiK3YprZho6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aCUABWGv2bnLPLbIZojASkUcFwlGWC8F62ozzpArmrc2kXp21UR3bj4PXxbLoa40n9JokOkLHsLjgl7DqtAaRivTEpNGETbTCtcuwpCw/Lrz7VLyGzUHiALY61S6eoRJxWdgXVguxHw3NlpurIIKXUxp+JBHbA1OKWWdDjmC01A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A9rqcHCR; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr27Ttm269hMi/8mM/aad6Gev0HasnVH/lntKvMLi7We+ncdQ1eV2WvkF7hUCnSqaVYn7+U/eZHYGZ5DFq4btUfdtupMmu2F9QfkdsTb7WdWTCHhF3jFZ+1/sLR1ysYyYkX74aG81ZRMsDldxkS4yrdQjSopGpI+sz1ZtlOS6L8mw/jLst4W1PgyLByv7G5TSXth9JFcCST9OjhInAhN235auG1IZAXlpAttAV4kyUxQ+x+xNWvC4SlMX/DumzBTyHOPEHLz0Ojup9EId0yTNGexk1gwKhBlcHns43y8N+Ee+YfIQCKKieH86xK5YmC8FSDlqf7mQDxWJELz7mbivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lt+iICwSSGL53KdpNeOwx+kA98lmP9pHkMhZoHkIx8M=;
 b=cM2KwFhIYqLVrD1z5AH0cWjnpTfdbZ8S0Efy4zycSRIItWl+rTZb2dgShhqnA3lwTdZZ64Y1DSdzw8yr9SQVS7jic0vhSQa9I1nygiAEgio/ghKuJRPMq/m6HjrbYLHmVQ9KsVRYhdfRp0nR1JjkFgGiBopZ3vWyC1kjb4tG/7nYyIaPmikCoR5kFLJgvH+3T0qcpbcvBEtRzToNgq22SRERFhrjKADbi2ARlOEKUKgHBcFWi7F4aGZWaYHBMAUD1FyRVcOCZSeuVKCMrD8iP0rF0vdAbRO706pSkjMFPFms6eRyi9oHhcsdH2zQLypsOyrpaDJiHSOHfwkYQFrPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lt+iICwSSGL53KdpNeOwx+kA98lmP9pHkMhZoHkIx8M=;
 b=A9rqcHCRuSfYq4oTNOCGEahOb/4TAPyZBcimlR3cPMSF6EMYl02esTCI+XHNnCJUar7lospwfyP6NU8dsPv2h6/3XDYBZ3MBPIPIqJUgIPSe1uv7BDIFvnRP+S/e48vH21KWgQiGhh2WBmAOassmuNZEbkQ2/IYX0qVBGUgzKaCNunO+mID6Ok870PO9cVtzpkDMumlCK1F43pI/YlKxp3TapqE7cjMYrmqGROpXf0AkRGWHFU8eFl8LWJGEIzZMOQxFDvTqHhl2c8KY6fdSolwPvuCJ1n5XK0z5YU9LTS9MTVFwll7Uj6eg7DN4931c5FyAhwssFZamy142dXS+Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:12:36 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 23:12:36 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: [PATCH v7 5/6] rust: pci: use pci::Vendor instead of bindings::PCI_VENDOR_ID_*
Date: Tue, 26 Aug 2025 16:12:23 -0700
Message-ID: <20250826231224.1241349-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826231224.1241349-1-jhubbard@nvidia.com>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0090.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::31) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f42589a-3bc2-4666-cca1-08dde4f60ba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yajm+ahb1duTA1RMN60cIbjDO7NGKVNnuW0RyKEJdYAk+he9tIACKSiX1bP?=
 =?us-ascii?Q?2HqpsJcz3oy8zcO4bJzemC7XI+T/o+jnSfKHgygkrW9qaUt4jLLeP73FqNgi?=
 =?us-ascii?Q?8VNlnX06md9ZwTJmo8GlN3bxio8WhfSDv2DgpbMiTPZ0B/Fjv0bL/9a5jTWS?=
 =?us-ascii?Q?kBkeVWshrAf6n9ntB3jZ57RE3e+1hUqI1qGL9FzgASZGO0rLZC04uD22xLWB?=
 =?us-ascii?Q?7Deg1E0oa6GnQkSsmbUjVmobzUfkJp83yVjpHuX6/XHpgrltaZG37yFZaI7Y?=
 =?us-ascii?Q?jJoxbKbI13Ug3igmCpZir4s5RM0oeqXjWtdnxWm/14hFcyv4ErTlgJIjz4Cs?=
 =?us-ascii?Q?tjHS60TzWYrC2nxktgWruF+vVPzIiDt6mjvjL9m2KurcNonqVPwCHXhGLJKn?=
 =?us-ascii?Q?zEm+IXls9jUg33r2mu/gziyPMaDZDRk36xZ2ALDyoChrUAeB9hz32yRTNcAl?=
 =?us-ascii?Q?ybrUgINScM1R18BJEDoq2ljTBIN7VM2FcbbGaVxnF4+z/BwvFT0ksh0UyDLt?=
 =?us-ascii?Q?LQBHiFRdckDcCY28ulWmVigR2lJLHAXboRxBOmSpks4Xexrs5V+zR4rZ9mhQ?=
 =?us-ascii?Q?7U5icZgVt7G7OzTtZ5u8ifuKwkFiaaPkoF68eJlfkZP6VgttIuG0Rf3XW2UW?=
 =?us-ascii?Q?ONp5erZMhrQImz5ruWmts4xoiHsPgYd9w9bXQLty9oGYgUWpmFR9AcgQkwBj?=
 =?us-ascii?Q?EzVtMsTpR/SUB2/kuWL1s4r6XG9pn1Zn+LeoP5NRrYAriByocJ6KY0mIBoOh?=
 =?us-ascii?Q?wrgsFnBhc/UPbpaZdAh6+xevWGkVJCdAR9atxd8SIa+T3GGTGRyUPMAuJGSp?=
 =?us-ascii?Q?6xplEjOh9bx92V1j3D27iOoHvOWrPLYLNKQoOuNvX0/fhw55bgNNj3vufCcb?=
 =?us-ascii?Q?clWy26no/s9qfYRCycMQpZRG3CLF5M3ZlmlqueznC/Cm6Jx+CE0YMap4gMWB?=
 =?us-ascii?Q?MF4JmbGnUrw0x4sj9nwvz0baYn1xrkIV9viT7qpKirf3FKZUoFyGI4mteyzM?=
 =?us-ascii?Q?6HlH61AQAmQG5e5RYWiwX/Ayl3eFNybJjSxZzeLX6nH0gUeaicZl+Dz6mXpw?=
 =?us-ascii?Q?4Im357ACD++13UmNYU/axJ89L0XEMYIxVQaX7nzYA2qFo1FWysfcFoAybP2E?=
 =?us-ascii?Q?PbuB7ANrR2y5nIed/6P96w8LVJQxn9bk1zcaKpXZu1CavhjXuydRtIyMNo1T?=
 =?us-ascii?Q?JZjQeOY5KhWG0rYNklBNAimXjLi6xeuI3r0PHnjAgyJ2u4HUjJQr5I2yAscB?=
 =?us-ascii?Q?TPweyF+sdQmphpAFsosNdn/To/TqjBdikTw7oXy6ZAMeFYG4D/vUlTEuv1cg?=
 =?us-ascii?Q?ktiJV+vWseWArefy8JB9WVxOGmX4XR4Q4e4g0rYA9g0eqrR+ZnWBoXrkIEL/?=
 =?us-ascii?Q?s4qlbQm1JBAX5YTwNPpLoyAhPr5l38uxhKD+ua3fTkELYvgq72cxqi0JtPu9?=
 =?us-ascii?Q?D4ET8TPy1Us=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aC9bHpLyfK3YAUFEgXUnFNavvIuhDutkSGu9gFAzw+HJpJtPW/sz0YR+l2in?=
 =?us-ascii?Q?1sUPbi/iS21vJ6JumiXrS5E6i63AQh4e67c19ccQALj8V0aCON9V3uzhK3z6?=
 =?us-ascii?Q?DEXZbyZQAlIjQ8fwfQjmTAI/pphDUogptnAFs4EGBeRdGi4i4YzHKhlV+fAP?=
 =?us-ascii?Q?YtvAb03+wMiYlPoRm9gUPrPqih8sT7F62HzeAYK2IfU3A/W+J2WGnh9zFpnl?=
 =?us-ascii?Q?7MrvTlV5hIdgPFZaaPvpNeqT3et0cVZ/wkO7O004pMec5MMKefVqQEsqpnhr?=
 =?us-ascii?Q?vTPp01Zzr11p5LcAPU0LJSpyIHZkp16PAGfxKnZT5noE/KhePiJPWCMmW8fl?=
 =?us-ascii?Q?Py3ag1fWy2DMEV5+vTT3y3/wD41G/2+v9EhqGg/pqR/CqNcr+z407GFoqUG2?=
 =?us-ascii?Q?SHB7tFo/+OXTkBA4apKHIUTIVYpWM/Na58dCTtNrIcmDvigBI5W+cFwedsG+?=
 =?us-ascii?Q?cHR6mCBewsqVRN5oyUXipVJRPJFg1w7sTxm7ZBlYqV5d6/0o5lTxcyGjTJYo?=
 =?us-ascii?Q?fONQAg0+uYKlHwQSSkdmHGAojzkBUy7OUiz79Q2QJpWpKGMfkQW0J/2aTnIN?=
 =?us-ascii?Q?Z0e8LD9rK1UwVoSkK2lavd8ge++NzyzGc8jPL3JWqp2UNPbxHWMOMtfVOlvD?=
 =?us-ascii?Q?IxcaywyN1F12Ri8NulLkecTgNOGlLWhMMvjh5E/tdZxfnHe2htDAXY6/8JBq?=
 =?us-ascii?Q?+fLWOqBAwpsT/oV02moxNP3wt3gkTjWlnGEwWRMH6jrQnJXUMSXe04BMPjz7?=
 =?us-ascii?Q?fxTzHZNcP9469n3LsfqipJIIHiZ1yt8JcM/44xht3DTPODB9c0XNHeKQBO3Y?=
 =?us-ascii?Q?2LxPCEX+RexAMnnYgmlUFFLNc7NpRhKUZ5P3V+w/Ly/86RalX23MmTMWF2YZ?=
 =?us-ascii?Q?ICD2qvAwhLbRgssVMDRd0PIoM0YKWFgJ0GpS3aegdhg88Xd81HJxIREPMCLF?=
 =?us-ascii?Q?gz+pNWhkpPMTXMsuTNOfIH3xQyQ/uVwkdtwkY+IlGt/bsqsDk7f107X06Slg?=
 =?us-ascii?Q?qhPM03wgstwUXV4vi1h2oCqwSbejAMVHDLr9B117y4GRFyvShT8lCoe2ob/e?=
 =?us-ascii?Q?cb8hqtXpC6a27NNqHleXF41PUnNiWmE/6GWDe2A+txg5e+D9CH8RGo5KEi4m?=
 =?us-ascii?Q?cgx/oMtIXBAbO/edeGjYrmyTsfeVADTpjnbvRYLE+PnMvZRbnYgQnKUcHEDQ?=
 =?us-ascii?Q?flW8188uOCdaXxaSS3omdWlBDFrqKgDiW3bStGMPXzdUlEbdiqZbDrVDnDE7?=
 =?us-ascii?Q?r4J3wO6TMUzdVst/IdP1KZINlTBHfHlMSs3/aozsxfGzw3Ouc+NfHcfPrqzj?=
 =?us-ascii?Q?abdOgnjONOMRRMtvIthRvS7+4/h/f9yWsPMYv1kGr4uULAxaDeMSBQKtLoVI?=
 =?us-ascii?Q?/txIy3pbcvAIASWLC55Ij784FN8kYuc/Wgso2kD1OG7PTj5lAh1h0go37ozd?=
 =?us-ascii?Q?GVha3GvedRzjUs6SIwKIa6YSUM1vPO+BWqrjKtZa4TdmuLKev1q0bEiI4Nl8?=
 =?us-ascii?Q?mcLtkUaT2eoddCDfsaukwRxqf/BycKrbuViN3anGzQE+jYa6YeaWTcjtOrEY?=
 =?us-ascii?Q?ZSH3Gkuv6zWghhczIoNNNTHP0Udb/ww7YQQdD1bs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f42589a-3bc2-4666-cca1-08dde4f60ba2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:12:36.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwFpRwDuFXBOemwJVWSQxyKEBGQkeYgp6NGFLMIdcRIk/u0D6ZAZlScQbEYGfc1wuhOVIxD2fkcEnmowOV23bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Change Device::vendor_id() to return a Vendor type, and change
DeviceId::from_id() to accept a Vendor type.

Use the new pci::Vendor in the various Rust for Linux callers who were
previously using bindings::PCI_VENDOR_ID_*.

Doing so also allows removing "use kernel::bindings" entirely from most
of the affected files here.

Also, mark vendor_id() as inline.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs                    | 16 +++++++++-------
 rust/kernel/pci/id.rs                 | 18 ++++++++----------
 samples/rust/rust_dma.rs              |  6 +-----
 samples/rust/rust_driver_auxiliary.rs | 12 +++++-------
 samples/rust/rust_driver_pci.rs       |  9 +++++----
 5 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 26974cae4a22..182b938459a4 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -132,10 +132,10 @@ impl DeviceId {
 
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
-    /// Create a new `pci::DeviceId` from a vendor and device ID number.
-    pub const fn from_id(vendor: u32, device: u32) -> Self {
+    /// Create a new `pci::DeviceId` from a vendor and device ID.
+    pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
-            vendor,
+            vendor: vendor.as_raw() as u32,
             device,
             subvendor: DeviceId::PCI_ANY_ID,
             subdevice: DeviceId::PCI_ANY_ID,
@@ -232,7 +232,7 @@ macro_rules! pci_device_table {
 ///     <MyDriver as pci::Driver>::IdInfo,
 ///     [
 ///         (
-///             pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, bindings::PCI_ANY_ID as u32),
+///             pci::DeviceId::from_id(pci::Vendor::REDHAT, bindings::PCI_ANY_ID as u32),
 ///             (),
 ///         )
 ///     ]
@@ -413,10 +413,12 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
 }
 
 impl Device {
-    /// Returns the PCI vendor ID.
-    pub fn vendor_id(&self) -> u16 {
+    /// Returns the PCI vendor ID as a validated Vendor.
+    #[inline]
+    pub fn vendor_id(&self) -> Vendor {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
-        unsafe { (*self.as_raw()).vendor }
+        let vendor_id = unsafe { (*self.as_raw()).vendor };
+        Vendor::from_raw(vendor_id)
     }
 
     /// Returns the PCI device ID.
diff --git a/rust/kernel/pci/id.rs b/rust/kernel/pci/id.rs
index 4b0ad8d4edc6..fd7a789e3015 100644
--- a/rust/kernel/pci/id.rs
+++ b/rust/kernel/pci/id.rs
@@ -118,15 +118,14 @@ fn try_from(value: u32) -> Result<Self, Self::Error> {
 /// ```
 /// # use kernel::{device::Core, pci::{self, Vendor}, prelude::*};
 /// fn log_device_info(pdev: &pci::Device<Core>) -> Result<()> {
-///     // Compare raw vendor ID with known vendor constant
-///     let vendor_id = pdev.vendor_id();
-///     if vendor_id == Vendor::NVIDIA.as_raw() {
-///         dev_info!(
-///             pdev.as_ref(),
-///             "Found NVIDIA device: 0x{:x}\n",
-///             pdev.device_id()
-///         );
-///     }
+///     // Get the validated PCI vendor ID
+///     let vendor = pdev.vendor_id();
+///     dev_info!(
+///         pdev.as_ref(),
+///         "Device: Vendor={}, Device=0x{:x}\n",
+///         vendor,
+///         pdev.device_id()
+///     );
 ///     Ok(())
 /// }
 /// ```
@@ -152,7 +151,6 @@ impl Vendor {
 impl Vendor {
     /// Create a Vendor from a raw 16-bit vendor ID.
     /// Only accessible from the parent pci module.
-    #[expect(dead_code)]
     #[inline]
     pub(super) fn from_raw(vendor_id: u16) -> Self {
         Self(vendor_id)
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index c5e7cce68654..f3385c4a7e5b 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -5,7 +5,6 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    bindings,
     device::Core,
     dma::{CoherentAllocation, Device, DmaMask},
     pci,
@@ -45,10 +44,7 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <DmaSampleDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for DmaSampleDriver {
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f2a820683fc3..55ece336ee45 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -5,7 +5,7 @@
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
 use kernel::{
-    auxiliary, bindings, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
+    auxiliary, c_str, device::Core, driver, error::Error, pci, prelude::*, InPlaceModule,
 };
 
 use pin_init::PinInit;
@@ -50,10 +50,7 @@ struct ParentDriver {
     PCI_TABLE,
     MODULE_PCI_TABLE,
     <ParentDriver as pci::Driver>::IdInfo,
-    [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
-        ()
-    )]
+    [(pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5), ())]
 );
 
 impl pci::Driver for ParentDriver {
@@ -81,11 +78,12 @@ fn connect(adev: &auxiliary::Device) -> Result<()> {
         let parent = adev.parent().ok_or(EINVAL)?;
         let pdev: &pci::Device = parent.try_into()?;
 
+        let vendor = pdev.vendor_id();
         dev_info!(
             adev.as_ref(),
-            "Connect auxiliary {} with parent: VendorID={:#x}, DeviceID={:#x}\n",
+            "Connect auxiliary {} with parent: VendorID={}, DeviceID={:#x}\n",
             adev.id(),
-            pdev.vendor_id(),
+            vendor,
             pdev.device_id()
         );
 
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 606946ff4d7f..f3819ac4bad6 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -4,7 +4,7 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
-use kernel::{bindings, c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
+use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, types::ARef};
 
 struct Regs;
 
@@ -38,7 +38,7 @@ struct SampleDriver {
     MODULE_PCI_TABLE,
     <SampleDriver as pci::Driver>::IdInfo,
     [(
-        pci::DeviceId::from_id(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
+        pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
@@ -66,10 +66,11 @@ impl pci::Driver for SampleDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
+        let vendor = pdev.vendor_id();
         dev_dbg!(
             pdev.as_ref(),
-            "Probe Rust PCI driver sample (PCI ID: 0x{:x}, 0x{:x}).\n",
-            pdev.vendor_id(),
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
             pdev.device_id()
         );
 
-- 
2.51.0


