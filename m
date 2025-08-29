Return-Path: <linux-pci+bounces-35159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D04B3C501
	for <lists+linux-pci@lfdr.de>; Sat, 30 Aug 2025 00:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAAD1BA3049
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0E2BE03E;
	Fri, 29 Aug 2025 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lxfh//ky"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E0E2D8381;
	Fri, 29 Aug 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507015; cv=fail; b=dsAF2+RukBNkzMnyWAFGdCzMw5YEZqRE15diFCX5tJuZk2FgOmN6UxXtAfc+1B/TfUNNWapcNEfv4GdgZ1WucNm7JM9acpB88wZIZhATO+Jd41rNG8uLKhuLcwmWL4O/QWMRtAX1rl0B7IqzXfJ5aKYKVk6R0ZMZOR507kTAgoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507015; c=relaxed/simple;
	bh=L2oH7cfYUjGiH5dR3AX0M6VGlGLH59NJN995F0gNpUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+YqzbQK8lqL1hXyaERb1Yn7UZaNDgcMPBL+dagHdrVmaIqrP4Qps6tfKUVY9hsO4Cq9Uj49aoRmS+7kWvVpRzvsk8KIxjMQIuVp2GXGhhwEmraJfqwn1T7n+5QaOAzdCRM79sWkvqsW8GafJvd3EXYt+Ok+deODws1xLJXK4tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxfh//ky; arc=fail smtp.client-ip=40.107.220.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFupSXP3yuAcxAKYF9Y0SKEpqDgVackyQUmAVXUEWzpU78wJeqpAO6mjW0rDAr2Ml/GULSedcG+OOl2gqfF9fcw2y2cPANcHnw6Gho7Ru4neLe4QWq0VCNzPqv0hM71nqrvaXACfpGqTh3KIB5p8macFwlRfFVlzHXoIgc6Nr9HUytN4iwGjY2D8vLb7Got1O4hUuG1ZNxSml5gDqQwrtMyRj5LCqIRqfshxChOXgTclUsvvWqxN5Dh8xJpX2tpFN9sIMeE5j40sLlFiRkhjVm14DRlGZC0/lMg7RZ//4hG/sZrTii/aAf2Hf80E4JJhXJe4yLWoh8mp5lqPnyXP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A0WuTr2Jl3IgdH5wFnQbNZS7jPnOjnxwJvKnDv6OsA=;
 b=lCfQ4Lu/7nYiLWWyBY3YchNs6OucB0CTxLsiHHLrDM47rnyZlehwppm5MaoFhAyxT9VK4undWkh/iTRYcJ8TNpFst/nnbQzibAAruvSRaoguqawGBvl89vuiy0htTST+NuZevUu+zV2B4qjlzmJq5vbyGFUCM3Sn5gIZSDvQ+blvLxzr/eBfxrt23Vu4AHilluqGXN1gESegIqydlrBnFUcw60WO58GFnR0zZcKLIBr6b49gB01qRbc1hVJHjbR4XvSXZS4CLRwC1bzSEEY5fSFj2v/J7+8kCSO3DO99njUYmJjskRHPsPndrO7t3znTznZFq18xc8eE6OZ/uDDQvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A0WuTr2Jl3IgdH5wFnQbNZS7jPnOjnxwJvKnDv6OsA=;
 b=lxfh//kynKxhCo2IlcTVbIf+8f8cftLjqvYfLOW243IgvX7PqrvgDgoXS6WINzVBAXxz97s6Y/l5lfiAlCSz1ifX63Fo0fsjEh47+BzKF3qOSBhlyHXtyJ9WkgQMHVrrEDHwnv7p10f8szTZoBlt7yuCHXQ91hNl2EWLpXA9hAPazAf4OUlIssphXN2y4rdONAhyuDhQSS+2M02GQZpTGugop3vKbEN9wXMutQFdBNQAa5Hj0ckqMrLxskfygRpAxpzwLqMqwuM1Yj2tu5HFpKkBbP4HjO0Ig9EeWixsUeaZGbwd6W05ch16akBjrwqXm3YckX2Fo3WT58BfFbaPOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 29 Aug
 2025 22:36:44 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.021; Fri, 29 Aug 2025
 22:36:44 +0000
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
Subject: [PATCH v8 6/6] rust: pci: inline several tiny functions
Date: Fri, 29 Aug 2025 15:36:32 -0700
Message-ID: <20250829223632.144030-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829223632.144030-1-jhubbard@nvidia.com>
References: <20250829223632.144030-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::21) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8faeb5-861b-4ce7-8fcc-08dde74c8839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T2r6KCfw+xguYBeQAGf2zQIsSOvuJvYzabDYXxGvOQoYZwn2nqzUMNVPT0w5?=
 =?us-ascii?Q?+HMeF1QMtO3o4m7V6VqiJ3eYydMMDE2eukfC/6xht9W4n10kxMlcZa4ej+IY?=
 =?us-ascii?Q?WM32BIN8K6EnEWvEaTAMSYzpwxjDoxgSVbziM3EHec6xe5t67liUazroiFlo?=
 =?us-ascii?Q?0DCJLdQW+qJIir7jgw+hdYrTgIyWvEYrR2tAhf9f4i5Bb3PVy3Vfi4Kuz1BF?=
 =?us-ascii?Q?s0MOOcwXlsuArrktaACcmtrWoNJ+VHWqKknigHDBST3Pbca7eHPKgdaNsHga?=
 =?us-ascii?Q?vcabOneeQV1zNKmxFuQZPbHDqjeeGv/kYhe6ObcmNXKlebX6KCEYBBcrdMw7?=
 =?us-ascii?Q?SFKQ5H/OlGu7H50GRFnK0AtYwYV0upYYVQyCUckMALJJNiC3rYWfBDjawSL8?=
 =?us-ascii?Q?APbVPtaxZK6kREs3MagLEa9t9vFxGgN+6tQqYWdBvL1+4M9hwLCEt9h3+cuh?=
 =?us-ascii?Q?hAXRFCbhFWG4H7w2OaZcnvdNRAArDA+cwxp47JYBurmdB7F8ZeIs0Y+ozvkV?=
 =?us-ascii?Q?Vqcc05uhS6uOjfrf8PWNTu9NgSOf5XFucaEdHVLwlOHFLDoyKlCa5QxVx/3R?=
 =?us-ascii?Q?EuqjDjGnelGAYcO+mYD71obeZ/8b0+uXQY0mpS8Tv011Q2q6qHE9GXKG7xDY?=
 =?us-ascii?Q?xM1J0AkddLkvaaCJg3xTSAP2fuGogu79B8X2vBM/rAlr22WbaRWCQwlYFsEG?=
 =?us-ascii?Q?ietigIXIxMZuVh/ElKXGBfoAWi+2sBc4GssldG0wxNEqDUMlARgcol7BhgOq?=
 =?us-ascii?Q?J99gBBitvPzmGkHoLPFhS/wC00MtL+zCyPx7gXRwO6anqtRJjWv8OhsGnX1f?=
 =?us-ascii?Q?jIKnMsuErWT22MQbWL33aVTBNQ9ivejiKrYy/CSXFdKhy8TkEJdpARPzSBiY?=
 =?us-ascii?Q?Rvix7LczNuFpGNjfqY6AUn9LOG++3o6pNSOjeEKsDZOm8UH2n/fnvlDxg+WG?=
 =?us-ascii?Q?3USLl1lgfcA1eaavUXPKNYmIns6SuI302cG93hF/hWC9VfS0WKrYABqAfPIl?=
 =?us-ascii?Q?MfZ03AJYgCh5sl2hR+1ErNEVPuYnLmb7E09jaJNCL2eIJHkhUrjaLCab2MaP?=
 =?us-ascii?Q?SkX4DpDjfDdRPIxzLCzYnj2n2wHKH3TJPmGAO8BatDUN715sw57Cz+vnLkqS?=
 =?us-ascii?Q?plpiXXt1ZeDs+bW5/yUx/xEFMWX/At5lqPJBBfxVLZSQT9tFIJQdATBtVk8W?=
 =?us-ascii?Q?ciPBMQKP7SVhpR9F++8d84xBQiPsrPi9KZ7xpZtAOl12FbYd5HFt5f3Ptjm+?=
 =?us-ascii?Q?iSZbRfb/q/rydPu7w1k8Qn4y8UEkZqleDW3VVAemhoemEhxKY99WJ8zXy4ym?=
 =?us-ascii?Q?UDPyjnshqMI43CCN28K12lGFW/c2cz8lN/2rsNwYCHp+qhNda5jIcZCs80+2?=
 =?us-ascii?Q?Oj4BpEOyPMFCjY6w+WtEoK2bH6oLXjn3QQ4UQFG/4pecpGi3IejV02vW+kQB?=
 =?us-ascii?Q?17j6V1RGrwM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UwMH7jFUjCLndb4k37CGQ110liavmcHe4upQgRZ2dQzAUElY6EivTL6fou+F?=
 =?us-ascii?Q?0BmbkPGctSumXXDp9FGIt9tab8OrqUBE24ecEUFsRewty3GMD3IVO3srYlga?=
 =?us-ascii?Q?FTzIJNICzrEAaDjgJXxgLTPcJk/9EwT03WZ7r0M0RfKqiAAy4GE6nR+RmDqf?=
 =?us-ascii?Q?vjopOOSB7vFTlQhSsSU/vwTV+k4cHstgZTzz5Iqw5o3BRGVPabCcXJ8b8IQi?=
 =?us-ascii?Q?kekSLlaWvO16WTaGNCHAT6FO5dSJ02cM/tuZ+KZHIu4UWglhk1k3Qbx+CrtN?=
 =?us-ascii?Q?S/ePL1bjqkCOzj6AClPCUHvmin1qbXN073e8h94fWIhINgIhgS+OtOxHi42l?=
 =?us-ascii?Q?3rF6H6c1c3ArfrpEeiWVw3z4jT7DxKyh54hIhKtrHEyV8GL1Ml7p+XRS/uvG?=
 =?us-ascii?Q?rqni04dtH1BsHxS1szXuvSKq+LRJNq+/mnJp/03OhhiiXBnJUs3mefCZachm?=
 =?us-ascii?Q?HGD+Bsp0jeacBmoLRr2+PDshq8VAywE2N9qjNYs0B/+k48Ni4aPI3K6jmA43?=
 =?us-ascii?Q?yY2DJMPV71K3PzeHYurTLjmm3vczJCZEQeiIAyPNOArcwTk/HXBWdb2jc/hE?=
 =?us-ascii?Q?rZVte0NNDD6RMooaRt9OGc6ezRuLj6G9RPQshenhlhilI1aKBH6Fli28Clrx?=
 =?us-ascii?Q?1w6hWpRxxIfAwWot6tDKlsrK0xP00wSjpTUR3ppUAN1NNpFiudBPboFPl8Bm?=
 =?us-ascii?Q?5073CBEMlcQtWNV1d9NgttAdaeKQYStCq0lOXbfZYgrU75exnE8WjSqpke/m?=
 =?us-ascii?Q?jMkWlU29pTkrvxwLifMpaa1DGweZ5wKwNQkcHx0zTf6J+5DkOwqRTNeXsKH4?=
 =?us-ascii?Q?WFKVMbUPAK84AJ78wLncMxLGYF0IP4fFZ4Q570HXRqbZso+6aiLGS1vno9l8?=
 =?us-ascii?Q?D5AOfS+xwyGBkLry8zDumh/ArqiExcyZSdQBMMIXu+OYD7Zdyy+a8xvk9a6Q?=
 =?us-ascii?Q?NF31rXdCfxMSRM78koOfI8HGgUrIIgyIGpInZLHk6nQxuzly7P5mgmAVvBoD?=
 =?us-ascii?Q?yKSmT9An6K/hSFnMpu68SO9wADo4jPRBrHrava/v4q5MNVU3gL9Y8UWG+w/g?=
 =?us-ascii?Q?z5QiwVg19CGWCw/j7xVMSxFLYpH+Zeoz/8j/Ns/GH3F2iYW7Szg9D+O6xj/F?=
 =?us-ascii?Q?hcSXqGArH8YynJ/tyFa5d6JL5kjQqGefHG9OCr9p7OfzIh338NEBpsRJ58Fr?=
 =?us-ascii?Q?0Uoe/CD8YS0VuEi19U9+PbmFdhZ70gLKCNgBZ5dA6bAfy5Bb23DlEgo7vq0H?=
 =?us-ascii?Q?1II03bqt+lGEtUXKdXyBKp0m9tybHt7M3tDjs3Tj4C2bnfmlZe1rTiacR9/c?=
 =?us-ascii?Q?UeZcoEP6B0abU2+Gjn99+WtaXUykV9kx2Vg3GToOsnH/khGPXNe0/YbnT2+S?=
 =?us-ascii?Q?NEaFwpwpEYSxo/mE+ZtSQy/OA1ZetIX6ku83vbjdy9QGEp5xUy+4skDgQhNO?=
 =?us-ascii?Q?qxBTaURepGsi9LDjcJrCD9Iy0da47/vKaVu8BPcShCZ8+selbD/YUFuT0oKw?=
 =?us-ascii?Q?kBXZAj6tdGquC710+eF4/xG+IxReW40t9MrL1Cjxg6J/ec4fyftJEh6gta/B?=
 =?us-ascii?Q?X/wnMwjENA6qUFWNXutj9FbYJJY40y2KN9pniDsp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8faeb5-861b-4ce7-8fcc-08dde74c8839
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 22:36:44.7151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVEGBL7cR96Jvg3Jriqnjqly5y2UUdCo96xlCVrbtwDgmaPdSARyGTC7z/CnyJ/oOhoI3zXpZn4vpPTnsdclYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

Several previous commits added Vendor and Class functionality. As part
of that, the new functions were inlined where appropriate. But that left
this file with inconsistent use of inlining. Fix that by inlining the
remaining items that should be.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 39a152da297c..f683af938628 100644
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
@@ -439,6 +443,7 @@ pub fn vendor_id(&self) -> Vendor {
     }
 
     /// Returns the PCI device ID.
+    #[inline]
     pub fn device_id(&self) -> u16 {
         // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev`.
         unsafe { (*self.as_raw()).device }
@@ -493,6 +498,7 @@ pub fn enable_device_mem(&self) -> Result {
     }
 
     /// Enable bus-mastering for this device.
+    #[inline]
     pub fn set_master(&self) {
         // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `struct pci_dev`.
         unsafe { bindings::pci_set_master(self.as_raw()) };
-- 
2.51.0


