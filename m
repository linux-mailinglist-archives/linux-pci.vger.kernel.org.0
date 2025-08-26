Return-Path: <linux-pci+bounces-34803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67434B37554
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 01:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEDE681BE4
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 23:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE62830103E;
	Tue, 26 Aug 2025 23:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IGnpB2Ls"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C5B3009E7;
	Tue, 26 Aug 2025 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756249957; cv=fail; b=krkuod3VkRyKSBXX5+TZHiYYR56cuDC/F5yyvfc8RG8eW8vwEuymWGrSzOIMY/DwCjrGk/R9L7ucXUHsOqkWV1Vm0zoXKKq4GMBUSfk5P7kE2qW7JbQNLxG5NdrMZTxdt05Z69lRPoL3ih1sROmTg1f/MpOPKV/DnXnMFVYOdIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756249957; c=relaxed/simple;
	bh=1KQAXHwnDQNFYhhVnn0wpTr8ONClJhylYFqvYqtMYCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2nteErRi+xf5uEGSFCRK5A0aHuBvwm7v1k8QeK2GNWTuGF0la5/ymNOuqGrN/5Hm7SkBLIqHG33G+ENeT9vfMUo0Ma6Zzm2rnp1ex6ZLvkoT94C3pAzilnjGBJiQ7z1o485RjcSrhAL9SXPgDHu81RcD2sDmdJd2/gvAQYHcH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IGnpB2Ls; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr0RE3hnm9H1Znz/GaLnaGjngXfKE15jAlksndkt8+hXagx+R8fz12Pl6YIpALkbyY/Mp8Wh94S2TUVMMELRdYVTUxxc5tanbgoRQd3OGK31qGOeS8PbfiuaPjLeWVJQlMALQaY690F4KTHCpJVbQYD8P3LH5k3iS6Z43znkJWhW/8MLlCgbtV0EEdcW40tW92zRlseyKJcoRegwqQh2WgMi6hHg8BSZP6O07QFX2BXYbVeO1J8qFNCp2EQChTeDcC5JKbwVXVkWdGZ35P330R8Nhtx/nJHsdSjJJcy0rmvCpSJ7nGL9+5M+vxymsJaGCDmmhERLSiM8VIi7Dugslw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7OQ2sik0c99Pqy+Et94x01yXzL/u9SyfUJEEjE81FM=;
 b=mws2zjwpWB1jon3rJbJzspJS+XYSU6efDmGx1S3hYl34DTIjkXL3+woAFWrmLXVGCXRnBj1VAa8xI34dR4iiSHtk00b4sfS41MkkdJ1K5+gyBnmDarmjFfHBmdmG1OajKyrkkt8VG2axcVWW8abSorB7+ORtEwX+fmO0tNMz4fmRBEsB6I+dSgq+ifPjhKWXrxRob7JpPGbPBO060g9us4FAkM1J1GYfBMMiiNDVPNtHJ70WwqXRpNvXNUgWKSppmrQSApCZbW6no0/GHqmvwgdJvKifTe8SAvzyY/IqmZ5M755efoj2l6tb1Zwo+MXWloW1bcCTg2vEjmnggeMIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7OQ2sik0c99Pqy+Et94x01yXzL/u9SyfUJEEjE81FM=;
 b=IGnpB2Ls2vy4CGtoRfMDyDRO06LAG/jj/skV0wCgVTg/rjzQ/mvmGm0Q/S4FSjXk/BPLD47GDskCfJ529Kyjo4gL8dwf2v+ZbnRv2VeDy8Z1AcrA74y+voE5WBR6cY4f3iE97YQ8SduqgN74EPhRin2qpL3ozmrb9kC3S63CPFcDmB4TK5vwtGNKZLcM3oksZv47U8osq7VhhnxRNwAQngYjBG3T67KKr0abpRquhYj7o2Z2UNU83YQ3X8Evh0G/hJqgfirlTriBcv187Twx3Cq/PseQJWYZdT7FFG0QL3yfov4Wzpm1q4WC9ema0c/ImeYWaGdpfZTHd0KOm7CmOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Tue, 26 Aug
 2025 23:12:33 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%6]) with mapi id 15.20.9073.010; Tue, 26 Aug 2025
 23:12:33 +0000
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
Subject: [PATCH v7 3/6] rust: pci: add DeviceId::from_class_and_vendor() method
Date: Tue, 26 Aug 2025 16:12:21 -0700
Message-ID: <20250826231224.1241349-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826231224.1241349-1-jhubbard@nvidia.com>
References: <20250826231224.1241349-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0088.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::29) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f69370-ecd1-4b87-1e3d-08dde4f60973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPVqGuaRwG+Dp4SdCrHCMJ8REU3qPBShZava7QmcfU3tT59BFpP6+frE0T+n?=
 =?us-ascii?Q?ts1UYAq6PAKueBaQMe1TY081dHJmtRmFBOM6aQ7kqPZqQAU9kkdTA039DmYO?=
 =?us-ascii?Q?56niUkd9lh8p0UhYOWja/CNHyD7tHoxmgBMXT8wi+cBp4SCKLDyeJUNgxbfL?=
 =?us-ascii?Q?O8h7+/h7HpPG5AK458gbqR2PyRcgHigIJWhMJOa76ELGu/N1NHIKAZhqws95?=
 =?us-ascii?Q?OoPkfWaCvSG9udcwaYI1vA12ljcoEn8UO4xBchGSPfkGKWYyWQks7vTit0//?=
 =?us-ascii?Q?qIyWd5QnNNQ31R5pyAle7fvsBxBphBLaM7Fg/X2C512x1kypmchr6Pm9zAky?=
 =?us-ascii?Q?Vl9PWsXQqQ0HioSOv9a+vs2AjiV+YMVEot9IZy0IKYTxY5HVVU4TXHoJXR2i?=
 =?us-ascii?Q?GmsR+u9sntkSfxwMcJBFIRNACIB2tYC9wRZY2iN+d4s33fgpfIHA7ryyuct0?=
 =?us-ascii?Q?e4vonogxb2xTV7VA8BlcMgGqSax6BDlHZq7z7df6GeF9MxGBH4GIt3tHSZyO?=
 =?us-ascii?Q?l4cJrJ7M7uIyUQxlC9pM4qFXooG1jUQlQ5NM4ggtaLDALcaJg24chljwzXvE?=
 =?us-ascii?Q?Tth7+yyQ0G6wAjLO9+n1vFiwejFd8s/HKCEAANxFrLenxJAKgWyYkIWszGv3?=
 =?us-ascii?Q?jl3HvBgbWSly0eA09n+4+vJHE/6bdp0SO8E97VAk5p0k97raeTFp9yYvimVW?=
 =?us-ascii?Q?bZR/bLGrbvX0aJcrTDv75C4c4M6j2E8TDeP9cz/wFv/HjQMAe3RQBHhYyKdC?=
 =?us-ascii?Q?kcbRALFjdsqPu67qIdHnS1nvT5oEN4r5XjgjDI3KuUp3uG37WQ4Z09aC0AH6?=
 =?us-ascii?Q?6FzTbwr1zT20v0RWb25P7w9XfuwNiLRLccVoGTNcujg/nl9+y1BLvrkVeapr?=
 =?us-ascii?Q?eDqEI7rzn2OncRK8mABgerjotGaqiQoYdbS3X0OE+opc8Ga9Ix16S6WJD90I?=
 =?us-ascii?Q?ARINVIeD57A4wH00BjjgkHZXkDRSw4psimVEZZz8//s2LXe4YbpaUHvzcIgY?=
 =?us-ascii?Q?GjZKSUbgCYuhXbOgzbAuxm0PcGw8SbmYfcxsTYnl4YEkcl45y4a1nYSzZ9Ta?=
 =?us-ascii?Q?8CYT6U8LdZY3YrlcWEIGX38LhbMdhqdyvxexjD/yXlwrMqcaEYppz6yK4tT9?=
 =?us-ascii?Q?Ln9v4ZR8nWTUGctZak+fRWAEdeMlrhJgYuUbThvzhjgRQC5ojrDqQA98+Gd9?=
 =?us-ascii?Q?N4+wJ7it0aKQE++OnSMRcdkpQW15HWkHKnA6wrbx2GTbyFM6S9g6f5BHl160?=
 =?us-ascii?Q?tKgUPS6y+wSe1+7Mq8AvWaeYGMC8d1wNAjhS8S9ZFpqJUBiCzWWYicL3PRjz?=
 =?us-ascii?Q?nalpcpfJixzTOe4bAlVFkHUhrphW7FLA7HZHwGe5Yr6bZmggXHau5MQ5bnOI?=
 =?us-ascii?Q?RVMjxmkQEBJ/neHB9JVcGpCgYdVupb343DNF8OLh5q+febkx9rO9vZjKHdpw?=
 =?us-ascii?Q?jnYj/WkF4+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I6HsiPMOMHKUnTI3k9IcfNpg3J3Me375psLYEG6YlFkTEe0py7OSi2ilYisR?=
 =?us-ascii?Q?chJ0eLqLC+iZejq5KrTrCeycGCy0jyLD6LaUgsFazPhqRs4rogSmM99YFs8o?=
 =?us-ascii?Q?CJ+RgtevgAt8RqZoz9dikseUJvoK1Z4JFfr2clhUJVdJTf4de/M6rJvoMxSU?=
 =?us-ascii?Q?k1gK5FZv9pJqRGEcKbxlL+yuCDmT8wCbJhhCc7BNPb8RWJ4+JnpmNnRVRX4t?=
 =?us-ascii?Q?MxTOrpE8d2kpL1AkSXrUyJefou0GqLPpt9umjPmbOBshXHQVGqIkShxwFxwE?=
 =?us-ascii?Q?qeVnez4Si90vKsWsB8Cuukkj5jFSXJRPGg7eSTgWY5L/t7PtD1upqH6mYd4a?=
 =?us-ascii?Q?mvlTkCl7lM1bAiWAjg6VoKrl6NaIvK5OjhwzD/MtRymRYHP3nf2o6HYSN/ge?=
 =?us-ascii?Q?Zgo+FapHZZ2O08bQjRhmI0vxYzK4IanRGEN9op49myrdRbyhPdgoIJuyDjSZ?=
 =?us-ascii?Q?X2fQi2spsMXwYDRd2XtlTxDr5PB06jGRTJ/6eWnIjEhKByNX7T+11anLerRS?=
 =?us-ascii?Q?lS948rqruOGrZQn315Vpde7I9Y28AnHXV3Kgld8oPPb3ZB6DfRWP6FW5eQ1q?=
 =?us-ascii?Q?1LMmLZtSNjU7tZsKCOLnvwNRPV7mKmmb5w+fjcSv7VXSuRfMHMP71BD8Ey1g?=
 =?us-ascii?Q?S5X/0m3HoRurSNZmTsIr+HAUjscWrwHdpJuWdoQ7kn1zRpHtd/QFTBt+nP2q?=
 =?us-ascii?Q?Nxbxq8I6kVpP3JJBdVyf/0hp/DlMTcwVwKtIL43jufilNEFa9Aqj6GGuXmKo?=
 =?us-ascii?Q?ib8YGh9V4Rq4PBxYhOdB2YW+UNyOkQy0wNRy9V9ZZvRQ0ycdqusKujzgAxxK?=
 =?us-ascii?Q?6MpNUY4H53ucJP7c72wZZBuHGJo/ZMCVJb0NWZaVVki6bz+3RacNWd0GBHLl?=
 =?us-ascii?Q?oZdmqYx4f5HfWjfTYwxCmg6++JFYN3YORIVkCqLW5nPIVnCd3emPhHDlG+nS?=
 =?us-ascii?Q?EEymjC7wKAtF4xCBJ22mygvL3aBgt9vLb6X5B/hmc/zwQXMN1D3GgC2kozmP?=
 =?us-ascii?Q?5bdbZU7oMUKiBRvdeoc4l899UWMIJEuMwUaSRfh4mOgo63m9Y1K9bCvkFAfc?=
 =?us-ascii?Q?QzgTW98AUQau0eyoF8vEceZn+1XQa7xaPxqNrZ74NbkTsY/tZ1Rb7CiCcQvQ?=
 =?us-ascii?Q?vv6Mh0z99H7cxmpqfDFWoPJu4oC6J9yOVLXYeinbVWiyHWdoJ5CflY1gs+h4?=
 =?us-ascii?Q?oH2sH+SE8ZUMJ3eGO/MlSDjIqKMyrl3tOYxsa1XlL2/HuLw/Dpot+QjDpzlZ?=
 =?us-ascii?Q?iCAHUkawMtx9N3b/x1xQSgeHB6c2u1Ho2x+V0IYI1ab4d5Da251HJwMp+Yp8?=
 =?us-ascii?Q?e9Hk359jkJJdsQTmZCgLpo8GtRAYt0jiieR4Qf/TS2fy9R2UlM8EO73p4GFf?=
 =?us-ascii?Q?gSf4gBhbGE7qlD5aT0lzgYSX25RNcaS0Y8SF2k8s7Fg31ONbpUQVcuPDC95F?=
 =?us-ascii?Q?PmAnkO1riHjktamsidKHUydqraNcW29WEm+pzMg2E8qf3NXuAvu31kqaKDS/?=
 =?us-ascii?Q?BWHmZqqe41JN2Waaz4IgnnbwQLGPVy4Q/EAPmrnGjSPdCmqu8haYwbkoAtdz?=
 =?us-ascii?Q?Eumtbc6f34xLwZiznC0NTFScx/e8d/To340e2y3P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f69370-ecd1-4b87-1e3d-08dde4f60973
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 23:12:32.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RU77q1c2L1sbbESqyI56OsqD3uQqkBq84MgtM1OPS4wDY+IAyAnCVU3ksv7wR5IQAx4r0XQC0uZ0H6j6m77iww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913

Add a new method to create PCI DeviceIds that match both a specific
vendor and PCI class. This is more targeted than the existing
from_class() method as it filters on both vendor and class criteria.

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 rust/kernel/pci.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index f15cfd0e76d9..26974cae4a22 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -161,6 +161,28 @@ pub const fn from_class(class: u32, class_mask: u32) -> Self {
             override_only: 0,
         })
     }
+
+    /// Create a new `pci::DeviceId` from a class number, mask, and specific vendor.
+    ///
+    /// This is more targeted than [`DeviceId::from_class`]: in addition to matching by Vendor, it
+    /// also matches the PCI Class (up to the entire 24 bits, depending on the mask).
+    #[inline]
+    pub const fn from_class_and_vendor(
+        class: Class,
+        class_mask: ClassMask,
+        vendor: Vendor,
+    ) -> Self {
+        Self(bindings::pci_device_id {
+            vendor: vendor.as_raw() as u32,
+            device: DeviceId::PCI_ANY_ID,
+            subvendor: DeviceId::PCI_ANY_ID,
+            subdevice: DeviceId::PCI_ANY_ID,
+            class: class.as_raw(),
+            class_mask: class_mask.as_raw(),
+            driver_data: 0,
+            override_only: 0,
+        })
+    }
 }
 
 // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `pci_device_id` and does not add
-- 
2.51.0


