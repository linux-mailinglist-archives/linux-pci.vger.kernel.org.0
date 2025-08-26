Return-Path: <linux-pci+bounces-34807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AEAB3755C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E38360B8B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5693054E5;
	Tue, 26 Aug 2025 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofzcABIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AFA304967;
	Tue, 26 Aug 2025 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249965; cv=fail; b=SVjcPi1Oo9gEE55rixGCQgFjom01L2AhyCWGRxu6gf+1M5ZBjQkPBczzm0N/oNXi/ppG9VPHnLh89XwL4D4GsZqLg0N29Ftg62Ru1eXmkkzcFuP6FM4fIpd3+SZxP3wKa9AHuSJwMPzqzcxWSyW6swnpA7YREdINJtAFakNSSzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249965; c=relaxed/simple;
	bh=sDR9EfbIQuIjvJnYKOs1H0Ye1si8DDj9V9jbJPL921U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Me42y9zGG/jF4MFQkz9PmGu+SqHGpquPnYXsJF/iSVynfXa7vhQIplzPGatm1QIelyFVS1dak7G2ncpIPNWwJOUvZtq7Nw7LavndRyowzSiSMaH+od0Jxb+rTBFa4+lAc3lzwEWoFOY7rLHcdzKWbF4qlPvJ02Xug0Q7A4w/BvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ofzcABIj; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYmeuHKP7FE2D6rvG1o+PPEEwCwc7XphmeUlmskmNc44asizxfDzyz1OxCVoOWDhC+0Xxx9v+aAtjNrd6v/vYdkJiEG7E3BrujpeR8/ngylY2krOU9veQXMzuo2+jsMXalx4tO0U/PwrPwAytZg04lSqNDCz94es4QsYqWmiFicsdXBuSvRicrLCApk/tIbFs+VqutjLROQzPNkYHlVdOW20/X2t6/RB/Dw3rhfu14HF7zlzl+Y7ZldTwlaDs1vFufGhkX2zbWCcm8AUPJh5Hkw7MfJtyp9Gf1vKN6ZeHwAZ28rr33fxIn4stpI+qRT322hHxKcDDdyuxsCxeYEZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e67SOeeD1d3i+6MGq7BWVwfdet1RlBc7kfVpwTI/R8I=;
 b=hDGt47TsJagDATkVhik5xs/ucoo2z2jpzIa2DZHNyY7hOAI1W5t6e9v1zU3fsVsIpDeiitYYcagqSmBhZg+1Tixn6a8lV7IuO9KyUKu6BwXDOABzw7+mmTGgK2zx0s54Q9lXwfafz9dUHxUHBDxUNUJiS6nJYLXeStmBLAzLTsNtrZKAIwlFeF2gOOTKLW0rL9Fz//AwUFmUt9OqVp5xhHupKealq/q9U67r+MMa9E4tcsKC0/2UN7ygSoHA3MWT43+ULXsdxuZlALrIBcOzf5JGLYfUZe2+8oSIxxaYq31xW7Yn3LNA0PqHkiJia+Bu07bHWj/6a53FmZjQrZHqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e67SOeeD1d3i+6MGq7BWVwfdet1RlBc7kfVpwTI/R8I=;
 b=ofzcABIjzcK0VKHX+MaRpBCrGqSTjuRCQfpdNwFR8dRY/0Cs7c18Imu1RnzYWbZDKvc5cFy8WOqS24VHYe3bgVfxN/jVC4ff3RLIvemGU+nJtnomcf2vr4r7pUjLXQHfRyhH6Z1Kbvj6Qs8k3jmH50ceWp2sSxJRf/Ez6PpihB7iZPnrRsHY7qYbxHjD1lPnPyhuDCgRHir1/IV5QoGb0NIRl4j4JTmsfakQr07b1/BB9upRjDFtcn/j1K4yXTu92iO4YEjQq/Oot72qDKojz2KaNDYNczy8EXyWFxIF9JTcmKKZ1ljYuiAEDBdDzWQ0SUaamGsIN/3qRSAGNVgHGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:12:39 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 23:12:38 +0000
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
Subject: [PATCH v7 6/6] rust: pci: inline several tiny functions
Date: Tue, 26 Aug 2025 16:12:24 -0700
Message-ID: <20250826231224.1241349-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826231224.1241349-1-jhubbard@nvidia.com>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0087.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::28) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd7791f-0d2d-470f-f550-08dde4f60cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5gefdbWuihIkQ7NawuCC9W7n1E37p74l6D7qVim/LW68/k/h242I31FD45mL?=
 =?us-ascii?Q?1yI6+iUX4w4kC3sR5dJH0098pcs+NDnjrr8uNPPtSXMy02RDS8FZAV7O4QWl?=
 =?us-ascii?Q?WkW4DF9eky4t2VS1ZOd3x108/0n0gItZPO8METr9rn4x+2TlbReJgllRgyNk?=
 =?us-ascii?Q?PBXUMAf0nS0BUbprp58TLyQk4t0vRc4n9TK2OG2Xfdf3Htm5deRVYzOlRlws?=
 =?us-ascii?Q?GPB+fYl2qOFZRQ0lr7M9fZxYK6142BQvX2wg68pzjwqAQ0cgj/axb6GIM2uG?=
 =?us-ascii?Q?Jqjc7ZDMlq71kb+GIonew+UaDZA1tb6y/ynAf64GYS5uaMumz4m/NMlKxup6?=
 =?us-ascii?Q?Pr9+OUBctUTNwi/o926OiBj3NvZt+pq5qNVHpjbhQPhBZ6gwoPVN4S6Zvd6U?=
 =?us-ascii?Q?0S+P5ZZm0N26ZvWKKL3qYmTMkfdF81Xsr4aBuYqj/roam38qxuGSGDQfjX9W?=
 =?us-ascii?Q?qE4i9UdMXf3bjc6e76J3hGKkehwwCr8c03V0x6jASFnuaAwLKgcbpnMglCV2?=
 =?us-ascii?Q?d31T5MtbaIEIbyZawYyAWBQRZmFxQHUpTKW9gHoUsP6Vff5eOARwEbhsh2VY?=
 =?us-ascii?Q?TJbCunoCzNLlfkrgliqQDSHQUxxwW4DtKHGavGteOP22pd9pdX149PQaqX4b?=
 =?us-ascii?Q?Q9CR9OfRg+/VdUx8xbPREnPCxCEtEkyIUuqefW3izJhV2yGuAkaTR22Nq37V?=
 =?us-ascii?Q?N+PMG7nbuBrRq3TIXW6nTHl7jZy1YpPbXfNugT5fWga5mUXZM87pIekZ9FIA?=
 =?us-ascii?Q?2fQgLsdIQRHzv8ZCeP1B0MfaLKG7oYcVICsyQTjmyEPzs5RgrRZkTGC4Nf9q?=
 =?us-ascii?Q?mER9FjrUlto/yB3ltisgDVIrrE1jwVCuog6+YApFdn02NxoA6zmgmy5ZqNMg?=
 =?us-ascii?Q?u6fKwECxpGLj7uVpBKjqPFBgCQo/o8bHdpxDxaI+qZZ4M5v7RbpKIC4Euwfh?=
 =?us-ascii?Q?Zo2tt75F8ymFD7EZoTG5BzUuYvpB9jfbVu/olDW0vXhbdApqmD9HaG/qej3r?=
 =?us-ascii?Q?iUXW8nHMaHR586IBgg4Rergy47ah882eNHYbHFgsMKn/TogMkdWclcYI667n?=
 =?us-ascii?Q?XKCy645644xsHAgHltjdFkxpVYL1VClL3cJuHxXaWt02JML7xYDZFqh/SyVa?=
 =?us-ascii?Q?Yb1z5rEcBJ1gr7djpN8zT6FLez1FieKgMYT1X2JDCcT8b/wu7796k7hqzW97?=
 =?us-ascii?Q?HcJbB2pYQ5hMZqhF7+Ws/xqnNVXlhVkj40ZVFZStlUB3j5POsTToYFQh/N6S?=
 =?us-ascii?Q?VEKVyBuqO0t82T5Op2GNMNYsWq0iIkXzWiZTV+ylr5w6+kOuWjp5zV8r4JYY?=
 =?us-ascii?Q?6H42vC+Eu5+5eJ5OvnacQj1hbSAKtAqnXnbPn8TKzzbMDl99sP0R0CWdZX1w?=
 =?us-ascii?Q?EgkZhVKG9TOhD0Wlb8s90WZO5avYe/x9UDlMjY1io5didAVUUGIqVHg7s7TG?=
 =?us-ascii?Q?y4BDCeY3lbE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JfCOVn1o92hfeuVPzmQSejwsL+AUkff0C4CZLTVqyrwsGIHHrG29HfmlChV3?=
 =?us-ascii?Q?OYiniZ4IGKryPKEOXyOr3dxE5bmrYo4GQ/Nm++YRY2JQ4AObsD4OWiL2lsm4?=
 =?us-ascii?Q?GeVCTv49zzbJRGvhccSVUoL80bPpFggb7T6/WgF7olF7fHLlhdvyf6Mv06lR?=
 =?us-ascii?Q?2cKJZvKkaSTWle2m/QMQUnGZyC9i2nNdGiU+auB8vMf0qwGpMNTxL/P0BxOb?=
 =?us-ascii?Q?luRliw2HPm1DVuIHy83YMrA+47TdudNmPe12GXHpn0OhKws5eCet787KdQzE?=
 =?us-ascii?Q?k3QrD7UW1DNT3uTYrGdsuOPTjrsto0lw4eS6vOaNzTFZR2ndw/o5vB14ss0c?=
 =?us-ascii?Q?c4/ehzXjNOc5ZdltgYWKrKc5ZY8rCetHLPI+hkhnjfy7s0qreUODZAle1HYu?=
 =?us-ascii?Q?fUWEUt2SOxDly1YO07vfHI5rn9gNa1MUOEiCrpTKfuqQwYoY+ZBM5m9e99Cu?=
 =?us-ascii?Q?zTiO07IQCcdrHf7UjOGDHXS8+E8XqniMJlkzd9XUtHo3UgPIwHWpnof72/LK?=
 =?us-ascii?Q?qF9N2f/z/O/b99DK7FI0Cyds50D8elWr1L4ayI/RCAolmFMApBXyIsD0vqgU?=
 =?us-ascii?Q?mUbgU5rtLmMUdfiy6SWNG9zy1QjhiownsnGtrO1E0BihJPyMQym69t6tKISo?=
 =?us-ascii?Q?7z/Zr37AamrpFLkBffJsmv2NH91RomtwY5a9AuraZm8TevT8qPEYeyotyL08?=
 =?us-ascii?Q?5UkeGOxM20E/SRGlYcQJMrXqk96u191zOaNfyQtrSD2FDP9CFeQAzVICkUlz?=
 =?us-ascii?Q?F4Tg7GjosYWF00GGlezG7WGZRqC1ZcKWg/Iw3OCPcX1i0nbGidnaiBK1re3r?=
 =?us-ascii?Q?izCliXoHu0ckMGSv6LF77DxSbY+wP2ITfdWPNhbtI3h1egaUUFXYk7ABCtmd?=
 =?us-ascii?Q?+YUYKpnl1sKr+rUDmbo8gT/ioxea8nKv4D8KIBAqpDnsnSQqsmRy48kj6mHR?=
 =?us-ascii?Q?PZdR1TesF8qPTjks+4Upc9L3p15IATn2YC1UphoC5MCYuZQk73VKF4czbWwW?=
 =?us-ascii?Q?JmoRawB5/PicAz3zcWz3Tdnjhy1n8LtMLkBKJKIEhOryzKmk9addMT6xeb1/?=
 =?us-ascii?Q?KQJU1WmW3Y7YdWH5eS3I+YIIxKWrg9ReEcxRMgc7LtIgiuFsDKruf1vf0J9G?=
 =?us-ascii?Q?HaCT1CPVqQlOjEFB5hXgCKsG0LKiiR5/PKevBlLc6s0eXBN/WVlU9duk845F?=
 =?us-ascii?Q?PhXQVNyNOir/QPnYat14GFKazAw1/IT45SDUbvrGKsA43gukOsXArTOSF64A?=
 =?us-ascii?Q?SLRCHO0CZU2ptrMGYjTsI8l4n+xfnzi+dF2SUC78QY+QuBINvyHlRRvXuPXS?=
 =?us-ascii?Q?jE9qkwujGgzx86ERraJjw/aH9lYJ4SDLfAF/9mF5SulvNgQgv+ucjH01FL9c?=
 =?us-ascii?Q?mdxoPyYixihKfnjF8GlVlm2rOtNL3I9cHoQXryqtQFjGXUqzoSObBlAgF9Yj?=
 =?us-ascii?Q?YOM7QfK3UGZuNsHIfb7/b0XWSXKvWQ4O4VGAkQhCcaNgrBg8lckpuxVc9uBs?=
 =?us-ascii?Q?UoIu3nE3pJwpQdBqmxE//0STRsrX6wNOD0SPCNN5WqBJ3aZRi2dMnnKg+DyE?=
 =?us-ascii?Q?voKj3yLgVkkTXHSYMWaN8ZmWawz+vgpI1CCpTR0P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd7791f-0d2d-470f-f550-08dde4f60cf5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:12:38.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NsugjC7EHznpqlkkhPWjHrnoLJK0qY81xQKXJ8otd5TIK9XdUKqD2ty2JV7EBB8NYhdHR3wyjMN3evKGclQYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Several previous commits added Vendor and Class functionality. As part
of that, the new functions were inlined where appropriate. But that left
this file with inconsistent use of inlining. Fix that by inlining the
remaining items that should be.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 182b938459a4..ee2215614dc7 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -133,6 +133,7 @@ impl DeviceId {
     /// Equivalent to C's `PCI_DEVICE` macro.
     ///
     /// Create a new `pci::DeviceId` from a vendor and device ID.
+    #[inline]
     pub const fn from_id(vendor: Vendor, device: u32) -> Self {
         Self(bindings::pci_device_id {
             vendor: vendor.as_raw() as u32,
@@ -149,6 +150,7 @@ pub const fn from_id(vendor: Vendor, device: u32) -> Self {
     /// Equivalent to C's `PCI_DEVICE_CLASS` macro.
     ///
     /// Create a new `pci::DeviceId` from a class number and mask.
+    #[inline]
     pub const fn from_class(class: u32, class_mask: u32) -> Self {
         Self(bindings::pci_device_id {
             vendor: DeviceId::PCI_ANY_ID,
@@ -385,6 +387,7 @@ fn release(&self) {
 }
 
 impl Bar {
+    #[inline]
     fn index_is_valid(index: u32) -> bool {
         // A `struct pci_dev` owns an array of resources with at most `PCI_NUM_RESOURCES` entries.
         index < bindings::PCI_NUM_RESOURCES
@@ -407,6 +410,7 @@ fn deref(&self) -> &Self::Target {
 }
 
 impl<Ctx: device::DeviceContext> Device<Ctx> {
+    #[inline]
     fn as_raw(&self) -> *mut bindings::pci_dev {
         self.0.get()
     }
@@ -422,6 +426,7 @@ pub fn vendor_id(&self) -> Vendor {
     }
 
     /// Returns the PCI device ID.
+    #[inline]
     pub fn device_id(&self) -> u16 {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).device }
@@ -476,6 +481,7 @@ pub fn enable_device_mem(&self) -> Result {
     }
 
     /// Enable bus-mastering for this device.
+    #[inline]
     pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
-- 
2.51.0


