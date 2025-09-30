Return-Path: <linux-pci+bounces-37299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E657BAEA7B
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 00:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19A9320205
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5E14D283;
	Tue, 30 Sep 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRoZ1+4W"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21927A469;
	Tue, 30 Sep 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270089; cv=fail; b=p7uDsg4zY1ENDmf8RscMlH6jnlVt9vs0m0r7t19NoLVo7c0bl8NtoYeZ8cPvCXUSSflsHV8hsx+yMfiA8hUkGhNO3aMQIepvLE/H+KPUHSd8NJbFscN3ZMmHNCpH867QIDGzgwvx9+fxd/6/fEbTQSYNFj4CElUqjcRR+dm2a28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270089; c=relaxed/simple;
	bh=eFxc9Z5BL7h6C/CA9iMxTO5u124j5NvFxPvQznMO3tA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pV4mxxojpPJoIYh1Mle/eVDgrGdaWIg/4j8GLHmm7smdrAf2hvWyYi/rEm/zOhF/1U05uAfMBfb6EL8ul5Pmcp0Ya8KdjlgLP9XUamvvJAUMJ7ZU3ypiXV0BG+C/xRH2uBp01XwK1W/id+C7kFA6HDjSiyg/NDDLxdsBX6EK3AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RRoZ1+4W; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvFjqPOkQFHEvuzMAfenyvPqp3D3lU8ZH3UOKnHSaaqOIvI8UHZz7EH09AOYT+NQNSJDivoNB+w4gH7VJIflrWVpBT6VlrOl1SVhsSLVZpFbLMX1Mb8rqQf8TjOSHq1P40Z73MjUDB455ad9hGxfSyO8UOOhW0+eoqRbLKgdCd4pAkc9S1zwIlL/jK4+BK/5t0z9zYWq5OPHPSfJGkRboGwMDG8mqsIxSxPgNJv5idH2OwtLU4LropYEWWS9v/rXOzJl24sRpUoBTb+wV8eopxw3XCA7Zdva3/4XconI/uYzaXU+PnuY21Wm1n/63Bbdg7wK8mU5hXDFhWf4ljLCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fape1tZ8DtrC6P4lvtItiWx+cGJBv+jm51UZ7dijzl0=;
 b=dE0RZz5mQxc23PgFSEgrzHzdsVtjdh7xr63g+LSyfrzZfGkwoIuIozWAHVY7ERvOSYlzdetQt1BRSKC7Pn37l+k5aUik7qu5iIsgSwiKrCIMQBdLozKvxzk9YLEH5T/mlXWeNVOTzFJ24f0tPI234lBVD3SliQ+K8G3W4zz4TK2KhUTF3Cox6xG/g3Phui6rNssUJFiC1t/mlTVPiEgZ5gHvStKCIQ8DKSRK06oh1uJH7G227NWtUahFCI1TNcfjqdXV9qZVZGrp18SUh1PZiIhpDi67zRfmVLtFUMSpQb7/BXq1pceo3lnXta6awod8mw39AXm5rPtUT3uiZmy+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fape1tZ8DtrC6P4lvtItiWx+cGJBv+jm51UZ7dijzl0=;
 b=RRoZ1+4WZr9T1y3K6frXkS2mzb37SqNZW8WuduVpc08E7LnwZX5p+WcQ65mGX7fzDexaxsewmUOjLLsCLokHHd6GlCWtAgrQ+KXvQNs1zUlCmzBKZMAwViLTpLQg8UQH5aLQ0+k7YmFcwig0QmS2G8t8Da/goekXcdUaJaAfOCgkEXTgmLesnA+HDIVjNdsZffX024O9O1o3i5vF1Dz+USFnG3vKn9IRERm4SuBooABQc/V3mWiIE+AkPBun1xw+LDZwwsohjX/8JWtlI8dQ/5KgYDYCAVUzILX9W6WI5bmQ1E/UicPXyyTQvBoVYOCkghVmo6a6dPfiqHaJSpjeQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by PH8PR12MB7373.namprd12.prod.outlook.com (2603:10b6:510:217::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 22:08:02 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.014; Tue, 30 Sep 2025
 22:08:01 +0000
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
Subject: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in nova-core
Date: Tue, 30 Sep 2025 15:07:57 -0700
Message-ID: <20250930220759.288528-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.51.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0234.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::29) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|PH8PR12MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d448ea-9056-4487-111d-08de006dd272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e4TaGB2EESwu1Ef2ks1deg2sJzFdISb5O5/rHlDRqen/OouApEBCbRfRqw8H?=
 =?us-ascii?Q?tPuk8p1X4HqtOpMVCilzqyEvxHUcEEQ3lWy74u4KpAL7lCnZIB/nTrug/nzb?=
 =?us-ascii?Q?EZ9i1FPFeV9da2Bw8kICvI6gB3f9ekHde4WPja/viU+aWKtBQxbfQ56Eufs4?=
 =?us-ascii?Q?8miVp20Nnp9NCoS1P1YTuA5fE3nU5QgD5jntnNChBLAeuOFrmb18waxFOXJ4?=
 =?us-ascii?Q?1H22/+TFUYKl2VKAcA/mwPBA80klBifu3tu36fU1nhyOLD+WHi+bS7KTyV9m?=
 =?us-ascii?Q?WzZ+k/MJMiXvC2lZ3N4eZT6TUtztNg399ip0uEdtLJAu8WOP+c18lrcrsY6U?=
 =?us-ascii?Q?QMgR1ILTi1bM3i0Zx85SBcew1IF5K89GkNgOKTetQI/37MHCA08nXLDwyFFE?=
 =?us-ascii?Q?8latRh6N7xCJ3oLeEbuqqFzzaNndv1Z2cZ5rGCOdpJO73dmLDN3+9pYDWYo0?=
 =?us-ascii?Q?TNPivChlW7pT//iBdFGT6w5hjx58rkfq/7Q2ztb+J+M6xvNXk4BK/dXkZqjw?=
 =?us-ascii?Q?IHWhcN05J/AWwnlweXZvAe1L7NW7IA5LQOCHvy4AoAN5h6n94yj9MwHlKIEu?=
 =?us-ascii?Q?L4mz5BYwDX6jh1RXCaqtvo0jdRK8Fk2BFSofeYylrYhnSc/N3TJ73aUr4YUg?=
 =?us-ascii?Q?PZRVtGXwYajAvZfVAAiDvPqUbk43wjPh7qmWLzcC9KkpRForSlC2nlSOEsqL?=
 =?us-ascii?Q?8GJtM0ByxJYDBybMf2QRQ0vUnTSP54RQIOdNb77+T0qzJ1htap2bmu09Dxii?=
 =?us-ascii?Q?rh8s3sXhFWZmemuIrwo227XKROxqG7UuIzH8cOlNyrKKmvF/yRHdJttKjnWY?=
 =?us-ascii?Q?bEVeUWh2mvGLewC6zuosX0K1YFUj1fJBejhp44Jo2pAw7MsDz78gmKcoJI1K?=
 =?us-ascii?Q?phB+hNfKgzXJjAmS1dUVaK9wvFc14oRHZka1i9RQu4fqodj98bxk3omaLSyn?=
 =?us-ascii?Q?4acX3TLH1sY5kHn6TniAFNlOtHC57ieysd1TCBlqj4QCsY7ffodvSogDBGEd?=
 =?us-ascii?Q?rEOSWunT3bWJu5P5nrvN9BC/ojTJH7ZDVvkjw5md2IOBKKQO7X07+UDYopGQ?=
 =?us-ascii?Q?ggNKiIyGN+VR3E3EbiZfMlb089F8sYPoPREvZ6NDKC+eO7ev5eoEB8QyPRA6?=
 =?us-ascii?Q?ZjAVxDr/Vg5FuqivZ425Ie8saAC0aTZcdsMdCcj9n2qN7gUGEaCu+HEVlWFT?=
 =?us-ascii?Q?sZ3loaZqtUhKMEwXxejHqdC5Nir17EJb+OmCWRosaJYGZEFnbjNkTi/H4oG+?=
 =?us-ascii?Q?cXijhu+MpujE8BX2IZhZbqjjPInQPA+GO9XPzv4Qxm4fLc+JL09jLgFXxFvA?=
 =?us-ascii?Q?Z/CJ2nPHQ43UzW/FwQwVZ/7Kk6tnhIDdz08SC9FZBPFcv0K1MupTeBhGp70r?=
 =?us-ascii?Q?9rXwxQv1By94tflOmF5YUJ/UrPw0HBmyocT2tvZ1VyyDoypDxGGZnXirEIJr?=
 =?us-ascii?Q?3itSArjsDFDYMeaSDZs6mVnYWYN9POKe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/0e+3yzb1SXC/rGbStqQxyoX3hojOAmsjApb2z+tWGuwL4/7/+KBwPVewnGF?=
 =?us-ascii?Q?TNwnFPW6wEUvaUPhZkDWJEW6WCI7MiPBIIwxSAgsz+abAAySVCBn0RdY8szf?=
 =?us-ascii?Q?HdxstHHCSDs+2jPdgvkaWPrX88xLA2Fg75yTgNSP4UEcRv2ETJNe2aow0U3i?=
 =?us-ascii?Q?wLAqV2P5jNKzq96EYcTFo+Jq8Z7XfIhv4L7CGkrHeAJ7uLHCFSVZtSkjyit1?=
 =?us-ascii?Q?RbUcBYovPu0tcy3PEQURtCgK0WFoB6Or6KIICVZuV1grnjXB0k2r1BCc5/Ja?=
 =?us-ascii?Q?WzsWWPco5z0/PkvyFxHHq4Ykt1KPyUJT0NJyDt8q0kIv3ez08w0ysSRoJdBk?=
 =?us-ascii?Q?W4skBG9NB54sVJvQDbqf5PI1dNROuxJfj5Zro+u2ulbGyOvspvgJcjJfJnAZ?=
 =?us-ascii?Q?7d8EojCaBLgSuKtQEpZI9woMDSArncMlOU+ev1wkK6W+kGdaIcDqrVKwS0/n?=
 =?us-ascii?Q?8Npo63LT3HTzuCesMWOEJzqwkYcE5lYicb9l74Igfl2YbHFatWGFwsCt99J8?=
 =?us-ascii?Q?6Ck08bS5fL63SuGMqSqLocJEWhVuq9kGaGx2CUmey3/TfrzZXabWl22A2ZNr?=
 =?us-ascii?Q?4FGRMFBJ8RxEy9peel6ER5rr9NA8Z5ilemhRZRVRPMywbqoQDinO7gZbzk8d?=
 =?us-ascii?Q?hWJ8B2I2XNLwhU+DbEBS9EAlcQ7EvyVyo4ZPY87/euqoaiGpc8BbUxuLi4pE?=
 =?us-ascii?Q?kQc06VjdVNzUAQ1WAw0/iBAZlPDw8Plxx353h4/Zsle3zvx+qMmQntpiDOtF?=
 =?us-ascii?Q?7kJi0SBbDgI9GDsumBLZvrqAEhvZsM6Z3H12Bp1HiB6twYo3BUTGLXRQDz/p?=
 =?us-ascii?Q?RKwdSnrH/2M15/5G3KG+TYkUWOQRBs1WC8a3xRmWZG+wnCaMIecEeTvPdjAO?=
 =?us-ascii?Q?lz/wfo4QzUz2dQBJ47D07/7wjhpR3lkq4IlRrhkGibHc3t35sxAiMvBO7rWy?=
 =?us-ascii?Q?hrMWHissA2pC0XC6B+GNAzI7lLTOYrjQwvN1KkYsDuCy5sR0f8bqQ3/GFiAg?=
 =?us-ascii?Q?sRHJ81IHgBaLgN1nTM5KdBXhTapIc+cRJFVv3r5kHOYIRED+YD+aGqnaMVaw?=
 =?us-ascii?Q?wVLY0m4iWiocdhsyqSL7rb0EPOHDFngfnlyhsX2CSsddfPGNxFJG6lwqcAMS?=
 =?us-ascii?Q?aFE3EkfSnjO/W9vEKx06JpQT8B7+qj5+lV2UucIGGrLl7Aaw6AnGmMPb28rG?=
 =?us-ascii?Q?jM57z4Sg+n1Chsnd++oRP4Co1zABM1vy4o4VNI2Jm/i5L1vjzpbX3Hv73V47?=
 =?us-ascii?Q?wmviAV2rFRiXn4vyUdDZXVg/PTnnwAr8eGHaBRbwAlFAseVTphpyWPCVsX04?=
 =?us-ascii?Q?5lfXhC5hpiPxY0Rg3RQB1cVeV5FSXL+OngCZIWpd+FCGVUhca8+2eBdDbms8?=
 =?us-ascii?Q?8ah4vDKJiTHFLDFCW9vYoACKgeGQnWeFSBOSYl++Fy88OHmbcMoEQ3R/QdJR?=
 =?us-ascii?Q?w0T7dTpbKnYl4xwD7x5c8qm6qyAAiyDwy+saEEEBgbW4wrM3z4ctlF8KH15M?=
 =?us-ascii?Q?wCw2psxIRJM+FB8vKQqxdAQCfF75SJq/4fLqgLW+KxJnNop0paC9DIjYArws?=
 =?us-ascii?Q?x0dAzAV2IrBaWYKwx/IO/LYm2NZl7ipP2XxOHmQW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d448ea-9056-4487-111d-08de006dd272
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 22:08:01.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66WXFbwXggOAqez0AHo4DH16mi+596p5KEKawzgUX6tp1NwS7g/wurMYj4rD/tHI0dcE+AoyXNhbwQ5S2Aovtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7373

Post-Kangrejos, the approach for NovaCore + VFIO has changed a bit: the
idea now is that VFIO drivers, for NVIDIA GPUs that are supported by
NovaCore, should bind directly to the GPU's VFs. (An earlier idea was to
let NovaCore bind to the VFs, and then have NovaCore call into the upper
(VFIO) module via Aux Bus, but this turns out to be awkward and is no
longer in favor.) So, in order to support that:

Nova-core must only bind to Physical Functions (PFs) and regular PCI
devices, not to Virtual Functions (VFs) created through SR-IOV.

Add a method to check if a PCI device is a Virtual Function (VF). This
allows Rust drivers to determine whether a device is a VF created
through SR-IOV. This is required in order to implement VFIO, because
drivers such as NovaCore must only bind to Physical Functions (PFs) or
regular PCI devices. The VFs must be left unclaimed, so that a VFIO
kernel module can claim them.

Use is_virtfn() in NovaCore, in preparation for it to be used in a VFIO
scenario.

I've based this on top of today's driver-core-next [1], because the
first patch belongs there, and the second patch applies cleanly to either
driver-core-next or drm-rust-next. So this seems like the easiest to
work with.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/

John Hubbard (2):
  rust: pci: add is_virtfn(), to check for VFs
  gpu: nova-core: reject binding to SR-IOV Virtual Functions

 drivers/gpu/nova-core/driver.rs | 5 +++++
 rust/kernel/pci.rs              | 6 ++++++
 2 files changed, 11 insertions(+)


base-commit: 6d97171ac6585de698df019b0bfea3f123fd8385
-- 
2.51.0


