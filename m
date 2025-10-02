Return-Path: <linux-pci+bounces-37390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBFABB2516
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 04:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D78216AEA1
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 02:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B7413D638;
	Thu,  2 Oct 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pk/YAQ58"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B59017A2EA;
	Thu,  2 Oct 2025 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370423; cv=fail; b=BCJvImtuP6nJhmBI6xh/JpQHBWMHKXS2nTzLXkdA+/S+j9L4O9XE1nW/1HTPMNbhbNtQLoeVyor3YgYb3UNgyG44aI/CzjVERjdbprHRddKDnxbJvJKPFLFMgOsZJ3Ok4xAGxjvlCpElua/0VdgBYpSkrRDdZ1lVtQ3CNAMjZV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370423; c=relaxed/simple;
	bh=wrP+X9LQrRQA5C3UBZzae4t6LLa3PhTUJKVzTmjRxFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D/sNHgaSgn7eysF1Oq78vz8C9/sWQx9NqJVthY1FpUYQqdQ5V8YHBYT/jJ4wC0hAx4yAMAvQ/WHB1SSAjYSZ5pLLallF+DhUvUVBlvUJmfcozWoAYtSX4Fen+R1Ag1l1Sil/kR7xF0IfzdMVr02plW6b2PWInfEZoYn4x/XI29A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pk/YAQ58; arc=fail smtp.client-ip=52.101.193.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzmiFwfapxAAGN0fiNnHnWksXuXF46a8gDqTzLkFfvOxJRQ6rTAGPP4xIefwk2gdMV7nWAwWRWOoX7J9iIdescv1tUEyb6emY0OJTqERCz9thbG0I67voXOvF5DiRDW12OFOsQjQa/0ARewKF1XYGQMSQO6dnKbUwD5VsehNxhOz16H9i4UIc+k8N2fKcEnF/hQXXFewZT5xSbLjy/LRu9JlmtAQ3B/mI8NT+Ma4XxE1CnVfqvnxPi48OOtkc3G4Z4T4C30m1GRhkFkEZQJDPBdgnbDmgSU8Uu21ry3kMME2FCBr+5hde6S9TQ12PtquvKjojwEgKZgNXE0MV3tMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZkaVaapca93yNTCmDdV/53wYl6g6n8jwWRZRuj21Oo=;
 b=tqaGbc46NN3w7fahRA0J50n9MPV6S12CH9v2eBkluL2fjKP8NQV26JQVXMSRuzw5QKCY9AeFeVPIyjPzu1cCrZY2OxkjIctq+/aD4Y81sjIE4yLBWZ6QlezYsgkpJngMMxSOqf/aOUy/4GerNzviwcMMIAF2ENOFtZZh+bNdz41s/MankwbXKMJ1v9jsbtBFHD2c6FGWoI+DQVBrHRYlkSOf7ZRBTwMM3BRouJPwm2PmBkWXisberFCFPcoTf5xXLt0fvGiVA9dNq0OOfXCjCbx25KOT/no9kfOWbKw0FY2axrr3xGQwGaAya2HfYbg6OcW86emZXqB4Lz2ed/R8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZkaVaapca93yNTCmDdV/53wYl6g6n8jwWRZRuj21Oo=;
 b=pk/YAQ589/RYrYQFUeWu0XDy64FjsAUsL0TgA3fqKG54lXho3aRrPuwF9f5BQsSZk+SxlMG0oUU7X2ZCcW06+xpLCG3KVIQO2iPjWEKj6bM46GKgUFN29cGaAvemz32qrm3ILjW7A4dqMrepI33UvYZSsX0isW9OBFAmOP4G4zzR/rULTYSUHqpSYoYv4CwH63kMf8xubWUn92PBGJeXNT+tiR8fHCDLU3YPL/SVvek5adlnCAJceZEkwy/jF0lDgr+GkmoqhO/Vm30bb7HKwHtCCpAt5IXmR2ODTrY2VIAA1koU5PvfGEWsA1JX2fNbl+2KZmF1Bpp42qklwt7/ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 02:00:14 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 02:00:14 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>,
	Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
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
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 2/2] gpu: nova-core: declare that VFs are not (yet) supported
Date: Wed,  1 Oct 2025 19:00:10 -0700
Message-ID: <20251002020010.315944-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002020010.315944-1-jhubbard@nvidia.com>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: 364078e5-826b-4324-a385-08de01576d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3G++OrWpwy5WB7JASdLK4O0E9u8qIU3Boe8qcEWyl1ABVDWYFYFyNyJu9r4V?=
 =?us-ascii?Q?MEGLJi3MN63dlcr1hFKqdAvlxONJ8zcn21cvhWuhF/5d2ghl6gUy/KuS+hRy?=
 =?us-ascii?Q?M2jDVFGZUavcfswMWdpuOFmfJeX4Pm50deX1Wy2t0LyS5OO10bjJY2ONjF9/?=
 =?us-ascii?Q?V4PLGSogL16GTFKAap/IU2kSCeSr9Hxws3/Soh5m+Qk7Asr0XZiULKqeUe0w?=
 =?us-ascii?Q?y3Fj/DB0QrV792dbAtU6+6Zw++WOfFsLHEYFMNs0vvEpqRKSav2GE6LzPENM?=
 =?us-ascii?Q?DZBjhVUv4WGAGvqrqsGTYusHih1/g0i297o8hn/JnZ+4XF4KcRLTL3km9i26?=
 =?us-ascii?Q?DyFoOwZ1QdEoHHSK6WlggCW3O5em0p+BryW83gBwM4rLbXIwkQ60tcyzURbN?=
 =?us-ascii?Q?6WGICS71Gf2MhmAMp1ZnL2XGfW3mX+RkmT1wpb60mkglQwF3h9vVjQOMM3Ch?=
 =?us-ascii?Q?RhEeBFfRdMCZAKlhaKwp3vHDjwuEfX6AWIYues3H+/WGk7hLPcOrOGW27qWU?=
 =?us-ascii?Q?K7P7RvS64J0Uk3VFDg/9JELIqOUBWPdFNvvmz6wnl1vEkDr37zQCkPvfoBNv?=
 =?us-ascii?Q?kwMGyUUAElR/Mb2KRwiNrEi8xkRD7tSIwFjF5WoRa/wgDgfXEG7EiPveBwz/?=
 =?us-ascii?Q?5zmFjFkpmp500TEIQlz7VHTkthyE0u9GN0+6pazjzOnKFL1Zt1S2SusAyRO4?=
 =?us-ascii?Q?XbuKsUQdbqmWnRX+epntonxKHF8Hi03Ooh4gAly6EgcDF9iN0oFb1qQgHIOW?=
 =?us-ascii?Q?R4U/gmZ7Dct1v2Y6AuE4hrY5FODg6EPHeTcfPZ/olaIkM8OMYGA2zIky00a6?=
 =?us-ascii?Q?wG20Qv8IaWgOEbadlBrEkyDrwUwce93tB+eR2OSf2znkID4Fez6PV6YoF/hc?=
 =?us-ascii?Q?5yG9tZRGaYANOO4jbp4jvaEifvu9DcPHV1BVaBv8sxoJSo5pg9PaaKSoQggf?=
 =?us-ascii?Q?95C3cxRWFKFu79XfXTb6a9lM+oXPwPdRYfM0PtkhckI02ApjVQorqXOhmC3H?=
 =?us-ascii?Q?QjpL436KOGF8VJ5BOEMt0wM6+AGvvPd75viisD3CeBYvC5wX5RoY5PP7+ouu?=
 =?us-ascii?Q?qkK0R5+PFsxT5p41lCVUImFYeK15/55x/HtDuuRQJu11CU1Hvq5T9XLf8qNI?=
 =?us-ascii?Q?4/BIOaEvjmfKyFk5jHRBy9GwmpvziP9wDc26VJ/KwCwMSvRP7xtpossvfBTs?=
 =?us-ascii?Q?OTrFJNJgcw3Hx72HPyGrYu2/ie6CRFXzRTAS6L9UBVgDHHGACe/7siKPUJiR?=
 =?us-ascii?Q?Q+g/UjnRk4OE2sGR7g3Zto8YS3pz7bsATPikPDCh+Kv0lBgSPrvU8luJDBEB?=
 =?us-ascii?Q?X6XjN/soobESPX+BjeDvh/+E8D5fJ1Z0Ai9aVqSKxt9+Dm7NgEdMM1Va4Ic+?=
 =?us-ascii?Q?15+DfqWZWT0rHv9QHx4XzzeM78gMrAPBmFos2rYAPGd8QD2/u/V42o3axYcb?=
 =?us-ascii?Q?3R0KnKBubOHfhgHc/DR6M5tTAVHpyLEu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MHo1SWl6196HapI5QUf+bCPSbTBlDIisISvYk9VzwMRIHdKLAfyCldT6o9i2?=
 =?us-ascii?Q?xymn0xfhehPi0Lu7QRYZZp68q2y4/Rk53KSY3rw/oA0mR5w4qw72AHa1Q9oy?=
 =?us-ascii?Q?1qdBgzZpV2Y0VXBEg29vz/kl7cfRswEM8kxkKbZ1lvYSM8o4oVh7S2XvapaG?=
 =?us-ascii?Q?TcF+eTW8jA3Mun57ILbeXfpesK+P/5MQHEgtWKdM5WLGPQhPolEZ386nfOyT?=
 =?us-ascii?Q?MsenOnJJtWYQOkHJbK5H6uj4QlqIzAHI7LLtxMyZeho/u4z/jidaVAvgplz4?=
 =?us-ascii?Q?C5l1WSDqh/rEd5IJchUVZb0Q3TETCiuTCDxQl5IAg2jNX/kG4iKSqOr3w/CC?=
 =?us-ascii?Q?cdWDcw0DgyU5gLzMGCstgh7EoJ23/nQuXDtOq8U0XWwTw9kM9yspV3iShGWF?=
 =?us-ascii?Q?gt5YklwD+ZHZQ0Eb6oZd8y2rymRV1IJkMnObw2H1u9DZRauCTP3qT2bVyQd3?=
 =?us-ascii?Q?tr3A4SfCw0idB+4ahQyf18Gxw+qnxEVmCwKEjrbsuqj2PKX78CTG4JQzZ0hj?=
 =?us-ascii?Q?DqqlsXMNeN/Pn7R2VWFOZWR3/6THEH+HFJZj4IDXtotdPrBrXuE2DyiVEGxV?=
 =?us-ascii?Q?sEEPmDwt+VKdAvcyS2HQJNFDMhENh9FoO2Zn4uluFwsSnSsVe9uMHEsHLbB2?=
 =?us-ascii?Q?k6QepIdNRIZ577PFjC2eiAeyLcuZgMQ7hs1559CPCVXja7ubNB51r3ls+pGH?=
 =?us-ascii?Q?/5JAX+aMQqYTFcGrwlisRC4j/xciIcn6Mqpci3OevRxzlOUuddb72sl37TxZ?=
 =?us-ascii?Q?Pg98A1mvZoPk04QE4laDq6xOjcYvT2cSrVS0GwtXZxO7XRrboaeApDitdvBf?=
 =?us-ascii?Q?fKKspES3bRgbYv4GTuBB+NkUGY4lesi/NBu55HT9dGspKKdzj4JDqr2jgquG?=
 =?us-ascii?Q?jnGWQOMggmxPlp8iQbcFBIzRysJuoTY4vs21bOjVlxLWMrrRmopqD1T3ACpQ?=
 =?us-ascii?Q?7+A3AzKL6kx9hf/8nxkuxP0YCxkivyrkLlTCkFew+orvNGCnEPj56JDC2SKL?=
 =?us-ascii?Q?JcZTRplDM9RskvKRZ+XI0DYsREn21hB9l04vGsYa95C+X/T3rxuR0hRI5IOe?=
 =?us-ascii?Q?70FeHXjpeBbD/LcG9/8NL5X5Y6FgjqXXRuOUofUABp0y5Fnli9nV4xiLVgAU?=
 =?us-ascii?Q?tpOvRcQu/sMOEvbuw19ciYp9xjC60WRovnSGLFThrJxKl2ufyVGKMOyGK1lR?=
 =?us-ascii?Q?g+CviLyGL7JhvHabsxBygA18zSX/DU64O4dkk0qDXsPEezvCwx6a0FQYOULy?=
 =?us-ascii?Q?EStsTvJyDrMTWBulLwIUMm7FCqZuQ0B/hSr8NG1Y+EPnnqik279HGZF2Wj+A?=
 =?us-ascii?Q?nUyBslSmxm1atosN0iymkuBuDxloRdQwU8EhB9b7j1dGpYsQnp632GGL2+Rd?=
 =?us-ascii?Q?g9yXIv8dREz6tYe42tuCIOWfTJeUMM3c67/8LREwkB56wvQMeNTlcmfbELGP?=
 =?us-ascii?Q?jNjfPMY8bjvAgDUjS/J8wulYV8+pJu4jLmx8Eknulr+wlN7ZBFQByuQHhhqi?=
 =?us-ascii?Q?aVYSAsFzYS3qPFDX1m4ELUZtckrnA8Nw4dfws+/W9pBiKlN5cG5+B/iwiyIE?=
 =?us-ascii?Q?aMrGNUaMDHad4qg7DAY3skiYZPBA09xtO8prca5N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364078e5-826b-4324-a385-08de01576d94
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 02:00:14.6719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udxyOTd/Z61Aa9tdLHozXP7e4eB1FczpDdCYQzIMbDEFWqWgq3zjxkYlsgMuc+hoJ4HRF6Gz3H/mAA0PH7EG1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927

nova-core does not yet support PCIe Virtual Functions (VFs). Until it
does, declare to the Rust PCI driver core that VFs are not supported.

Because the Rust PCI driver core defaults to Driver::SUPPORTS_VF =
false, this change is not strictly necessary for functionality. Its
purpose is to provide a self-documentating line of code that can be
easily changed, when VF support is being added.

Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Zhi Wang <zhiw@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 5d23a91f51dd..4c19b0067862 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -51,6 +51,11 @@ impl pci::Driver for NovaCore {
     type IdInfo = ();
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
+    // PCI probe() will report the same device ID for a PF and its associated VFs. This will cause
+    // failures when trying to bind to the VFs, until NovaCore adds support to handle that
+    // situation. Until then, tell the PCI driver core that we don't support VFs.
+    const SUPPORTS_VF: bool = false;
+
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> Result<Pin<KBox<Self>>> {
         dev_dbg!(pdev.as_ref(), "Probe Nova Core GPU driver.\n");
 
-- 
2.51.0


