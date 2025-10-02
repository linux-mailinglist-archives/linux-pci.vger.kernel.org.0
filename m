Return-Path: <linux-pci+bounces-37455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CF8BB4D6A
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A76783249CD
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E237C274FD0;
	Thu,  2 Oct 2025 18:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p/cAFcJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542087D07D;
	Thu,  2 Oct 2025 18:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428335; cv=fail; b=YY1Wqj3vPVu2iY+zJXGbRAY1UkKzDAmT/XD+w3C8YUdw52AwGNyEUR2EucZl72IaNPXjCF1qXYXe764ughOYIFOMWFtlndMRzAWvjOsIsQjwXn3404LYx1C7bLYcq0FEQrZJlEW3X+aQmK/+MQ5OhLSIZL51kKXVIf6mkj2msnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428335; c=relaxed/simple;
	bh=TN1Tmoeqper7D8enmY+rXrPvC1CnNNiH6E46gahHXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pLgzOuegbA/8hep308t9OIezVrvhMW80UgDXuQSqNZJFQ/HwoNBT4dOzhidHG/G6BN/aAvhNF/8B0i4hhyLH+YnD3dZ+somxfF4DX2FKa7rS5CuWCDl13CiNNLNKT9aCFM57EggaWqRlLW5aj0lf69XeP3f7TlhK5kzlqLBatKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p/cAFcJX; arc=fail smtp.client-ip=40.107.208.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pYO54MKE5esnxy+rZ3cf/QYvSsUHr///0492+nvDsJ2aPI00ljgeoM0Se/OI07B6PfZJl3EUcQbAZ8DClltfESGrHTVc9l8mD5ivl8SNsBMy7PISoLXIwtX0MBoI0O5t1s7yJzh914B/5MCw2fZ7EzhFX/q774CMCXaxKO/ODQKNuOIT95y9sByuFFlbIm2/tvUgx+PStx9LTf6rl+OK2G7yrl96T+3zu6GaWwCCqFrTFiblda+uETdYxvNwSx85MkKj/v1SK6gbK1yEQsLA25PTi/SWBRSFPDY/5Ap0CC/JwSsm99Re7ZWn9uuNTv2hqd6OtwinmQolj5wzFNIU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GES8mwVaJJOto7/VfggYzvM3bP1DnD9kxEznwJyKaQ=;
 b=XjzkpCLHQrKdGn7uZ1MpbPHeZeq1pm5N65rEhcN1g3d4V4CImaZ/vwDLkiiD3I9Gbo0pbyGSDP08si4EImtG+29xZkXC2JQTyXUE8RYrl4xI0SgbkTNN9KrL48JTLpg2rbBQY/FgwGPeSn6fKiiULjgikFaHcfAnh9nrnEQlWyN6hilyzw78+tZR0KTYYz3USGFq/N4Rh7o+VGHx84Tm79eitgBksUKjVAvqpSrhEAHEjyMfVFEBxqhDS4tebWGkyQyDbUrJHKlUyFfn3Ci0EGbWyC3R9QbfapxXyU4JIWc4zIPIz+y3joaj/d2iqC0gJRac5yY0eauifkBK0o0STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GES8mwVaJJOto7/VfggYzvM3bP1DnD9kxEznwJyKaQ=;
 b=p/cAFcJXFWsF9F9XKv1PRF/34OY9hq5KrCt2sjy9Ep9Mqbgb1Xgsx3Q0gKdVxTiVlKvCJ/gnRiiTT12hJpa9aJtQezwKhdHnFjKbmppLzjspuK1ZQwk16McbpFvIxjwxLBucEYjlFm9S5NMH39kVbtRx52kgOa5PdvBnDsxqD87L3d3FGQGPV6dwsxq5KVz3VvCFk8c5xgt+W64xOeuOlIs2VNWAhlYZTMWnXsG3SFQuUuR/pQNvHYVjiMPSDJkQah2an+MOaGC2B91Kotdz5E2Q3bG6WXx4iMLATnkS4otTTMzlu6ct7aF/nrwWexWyFoCMHUyiWVm8aNgX1k2ssA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by SJ1PR12MB6361.namprd12.prod.outlook.com (2603:10b6:a03:455::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 18:05:27 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 18:05:27 +0000
Date: Thu, 2 Oct 2025 15:05:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	Zhi Wang <zhiw@nvidia.com>, Surath Mitra <smitra@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
Message-ID: <20251002180525.GC3299207@nvidia.com>
References: <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
X-ClientProxiedBy: BL1P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::33) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|SJ1PR12MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: d5558b98-88cf-484d-084b-08de01de43cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aoPoG0s4PnVk+I2AIulY5W1VtIWnDTsbimTSysozwcCX4ql5KAJVbXTAJcVi?=
 =?us-ascii?Q?dTb1r3P5ZxFU2lMwT9G2raiq3qcFq0IjrqfmgYkrUQb5J61RHvSe2gWik4hD?=
 =?us-ascii?Q?/cDvfYCOstgHHH90X2F2OaFN3zk41Z9aM8bmsmzeQojC86YPU4UvoV+H1XzY?=
 =?us-ascii?Q?gcqRV2/gyo4Cm5nFj/kna1ToGI3gq/Ru4iMyqL7mAZzWFbtpsBeHdPG33kHx?=
 =?us-ascii?Q?09k8u2vgsUJiI0bIAeagwwLbCzAvZzNttsO6lIaZR7V1gxU44uZvQwy+xGJy?=
 =?us-ascii?Q?irDrSFjzWq2q9klY5Neku2GwQPcCOWBbNV+G1V0segELObKGKbWlFnl4jOMS?=
 =?us-ascii?Q?e34qwoWEgsUmbn6uPOTUFZ0NZBB07NUNisV2dDmjU4o9zpQY+SNYy5XrhJhX?=
 =?us-ascii?Q?rhXTmGLI54DP7eVEuHozK+7QYJ8PnFhO1OxQmgfqVY5LKnaX7hat1PEFamS6?=
 =?us-ascii?Q?WCywIDrFgTQm/nNAt6cZKRe1XQfakSGFEP+H/Tn9kQC6SvK0S93cfV7Fw5Jn?=
 =?us-ascii?Q?Ny3XN8EfqmomCR3zXtdl/BQsWzrS1khAk2EObbN5WN5rYylGiE1khkrt0diG?=
 =?us-ascii?Q?jkHHetmRSpOEMxdhCU8PxtEBxAITSRiQfoF4YVsx7Prre3PeF000YPNwruA/?=
 =?us-ascii?Q?eP0mxbFqhJxz/h0mCBfK3KVVTiTWK4BZa1BquEL0g43KIYwoJZZmScbii33n?=
 =?us-ascii?Q?dO64aqpNiEO9qr/TbVJp1L1q9yuBZKLnu2aWxntsp8yrDyyE+G714Zc6w8oH?=
 =?us-ascii?Q?h1v62GB7sIoOgwSrK+dmymsUXZnocR5MasVBzmyoEw/1PL+X2nDa6LVC/aLV?=
 =?us-ascii?Q?o4JSHSZtMLYDt6kmlEOL9tvBk0c1v3ac6IQYmbqD1MAIrLuXrQLD0b4v8rhH?=
 =?us-ascii?Q?zC0PHD4s2FxovMcXRA0m9DWQKBzs25CbT7mP6SigeJWNivpsXUEtEVXNYoJ4?=
 =?us-ascii?Q?5HHn6kwjIfXdGcD2eyecmOQaHZhz5DZXjKC47mMIkjoXXi0UHrDquBc7Lt4T?=
 =?us-ascii?Q?a0UzAF+MtnCypViIn9JxzY/jGkA78BHvlBnwpyCUQy6Pc6noXMYEQEzkEGTY?=
 =?us-ascii?Q?UF3qbiiYoHQHypd15VY36dSVMyRc9sFVjEONJ9pvpr5UE0mfCaXOIxNvgbUL?=
 =?us-ascii?Q?tzXQxn9pK4bAhWXyOvLMBNKj6E8MJRNpBjTYAr+2K6Jf1qwnJrSVgAjgKC1L?=
 =?us-ascii?Q?FV+OxWF60zROPgNsiOiGZh6ZjsDXRo/nDxQS/7w7jFsJU9Jpbz3Y4Zig3nGk?=
 =?us-ascii?Q?TiFepGy/Fhc1y4WSKiZ4byHZkcH9bBNySmVvowNxmhaEdfdUliR66nm6hnCA?=
 =?us-ascii?Q?w5g1V71XySSEq6uJI0xpgLDV8xY0Fszrah3hZItMpslCHMysZ+v52JE7cxw7?=
 =?us-ascii?Q?4FCjKJv3z3V4eGUMUm5M16YHr8XrThxn+bi50kdL7nd0SsMj8GIBdKbR5eCV?=
 =?us-ascii?Q?9RUiJ/eg7gUldb6RsNJyBs0DxwHoqoCn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKagfGrPsrUejOBb5D50Jn52louvc3ryk8DEfyh9Dj6lERDJ2uKe5LrFUDmT?=
 =?us-ascii?Q?ARnJT7NoAYjSvsUqr1+jaHVic2hTicJPGfzHSDTyAnLMiUG83SlH87hDoGMC?=
 =?us-ascii?Q?X3KaGOEC9WzFKHpJmrIW5TeQJBMsG/c2/rj+0xKquhOojfPbNSs5UKWnjFUz?=
 =?us-ascii?Q?EeHzSy47yy9RJgvZXnXDdhqUOZiSys008OkT7EDNZt5dbIM2ptRugwbgYh5n?=
 =?us-ascii?Q?+jVbYrv2uRq/4hpljEztpm/dScQswV0F5sUvSf/hcH8hy/nEruNiNCHFVfL2?=
 =?us-ascii?Q?/pHcf20OXt99PfPnU6oAbYhmlLz+zY2pPlrLarnvUHv21FbxsFGHPf8569by?=
 =?us-ascii?Q?Rrx3rY2e3piFv+Kkb86mpT2lRjYP/kuhqrs5Jlfh7eWjB/BsBK/PHD36qz2r?=
 =?us-ascii?Q?oPKYuvMRKVoipFwkQ7VpdZsmgEK1dNgm7kZvnq4XNz7VY8hL+B5hsmtUD/kM?=
 =?us-ascii?Q?OlshWo7AEfwjaYxLEXLI7u86T7EwkG+g5CQWC8kjxHHkIQBJyHdHav1lZfsS?=
 =?us-ascii?Q?DJLK1Ddr0wo7T72+57Nis5O7uIrUPHThiSVCmGRdpQ+eZcwbkGpauXhYLepG?=
 =?us-ascii?Q?aw/1M/CyEyBw7KWe7UzO0uPrvWpj84USz6zeyVhR4uvTMPgeDX7vRa+CJJD3?=
 =?us-ascii?Q?+whwTb+O5W6C601niEykoeJlDU31ZXlRnO4b228D0RdQeBJach/ow1ZuXH8X?=
 =?us-ascii?Q?oJh1ctDdr33TpEDvblZvb1P2bQ+uk0GdcqHWdAao0F32Tasfe/Oi/whxl4/A?=
 =?us-ascii?Q?n/eTHx5bcbKMZnsKdL5FBph34HdpzvCOYZT2z/E0lbFS/XrHJ6+VIPJPtobF?=
 =?us-ascii?Q?cEgH24M3ziWIN7tvpEjXg0R9xwZBX4eL0mK02sfeU7aTcSuS1jAqcgnMc0Be?=
 =?us-ascii?Q?ruAfj7tcrJWgbVJmxuaTRuioUo/P4zP6bJRiDZYxP1r527q8sUk5lEksRJTe?=
 =?us-ascii?Q?peuXEaiL6WfEfd+OXOhkNV5He2BYkCigP91E/T9u7BuDHLteLm0AQ1mwepRE?=
 =?us-ascii?Q?qVuv8NGVHyE3edEVHgr8I894/+SBZP4hTDvHIVEzETA2Jt+d9erLwG+7ExSq?=
 =?us-ascii?Q?JltdbJiELKxk1PVvNMLnmVHMHmnFHRP2/xyBg6TQVr/3A9mwjUkEuHVi52dK?=
 =?us-ascii?Q?luzgGKOfpskGZ/olraVrxRgzG/gBMAX5DfhG9kE6xXLmLjmtFX9JgoNAjnFI?=
 =?us-ascii?Q?ekHUC8RcIxKGVtAh2apKAUUGm0ppzJys/Ehktcn4s/vzEV7E8c8ooDBY/82b?=
 =?us-ascii?Q?F/rDX01U5qFSEwqqEHOrJy7wLtLGlHoLJ8MN/qS2aUaSNzGMw7q/m+GHsrOH?=
 =?us-ascii?Q?zVUxI3alxO0HgvPNKZU1AKyWcJRZgRhvT8OrYYe/ZShbqgAxpN2+ofJ7d38T?=
 =?us-ascii?Q?akCSUikh4Q3uEJS864EOKsCHHe8zjZ+Tf2uA429Pj6Y+Ga7e07MtVfjqMRGC?=
 =?us-ascii?Q?+E+6QCAtsgGlg6H16k9UMfwPA0XUQJ7rCKz5UNxnn4YaAjDmz/pW2vzOzMiq?=
 =?us-ascii?Q?CODQeQZ3iJyEjUC/YtmdAO8ObUEkUMWpnP6hZZ+o4vU5L7RJfMm83X58fQ+c?=
 =?us-ascii?Q?uiJXk9xzb/fyRCkPJc4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5558b98-88cf-484d-084b-08de01de43cc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:05:26.8537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr4hRu1R+6yNUD34OHpht2GTfwP/qNNIxeUSZAB1gGJT6h33qRumeOmWmrqcWYb5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6361

On Thu, Oct 02, 2025 at 10:49:21AM -0700, John Hubbard wrote:
> > Forgot to add: But I think Zhi explained that this is not necessary and can be
> > controlled by the VFIO driver, i.e. the PCI driver that binds to the VF itself.
> 
> Yes, this is the direction that I originally (3 whole days ago, haha) had in mind,
> after talking with Zhi and a few others: nova-core handles PFs, and the VFIO driver
> handles the VFs, and use the "is virtual" logic to sort them out.

To be clear, no matter what the VFIO driver bound to the VF should not
become entangled with any aux devices.

The VFIO VF driver uses pci_iov_get_pf_drvdata() to reach into the PF
to request the PF's help. Eg for live migration or things of that
nature.

My point here is that generally we don't put profiling code in the
VFIO driver and then use pci_iov_get_pf_drvdata() to access the PF do
actually do the profiling.

The VF cannot/should not control profiling of itself - that would be a
security problem once it is assigned to a VM.

So the profiling resides entirely inside the PF world and should
operate without VFIO. As I've said this design is compatible with VFs
for containers and so on. So it is the strongly preferred design
pattern.

Jason

