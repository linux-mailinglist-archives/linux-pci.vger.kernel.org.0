Return-Path: <linux-pci+bounces-37650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA24DBC0641
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 08:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644B03BE1FD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 06:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795F24677C;
	Tue,  7 Oct 2025 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHr5peCb"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8FF24503F;
	Tue,  7 Oct 2025 06:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759819917; cv=fail; b=ZTKwcY4Qt4tJFZyPwhiFInJl2NmQbKjsRXo5SNSb4kJy+/QJWrhhq0AG2czBFe5VIA3Whnh2swTonciGxY+tI+8eHR54NB5oYAYN+TY18JS/TD+lf8oW56bcZu0+3vIputcBU50woBl87V/nedR5GKzBLO6D4qqmQ9U+0N/dJKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759819917; c=relaxed/simple;
	bh=kocTyJYbSxmQpG7P3Fh+B7k5NHjQBxdzGAM2ZwaKABg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q43tTvfXhDwT15NsPYOUs56mBDjui6Ta6Pfgd2iircW2jkKgSZwSzw3DcBu00xOb2/fAXt/VxBcNp1g7IE9C0TtGCgoHAs0GYnzAGjeyyYiCoyMe7OCVst5Ek+eLY8xkEv873fOpxQ7h8aSrGDVAHfo4R6Vs0j4anLpnZ3mI81o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHr5peCb; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QocWavQileRnEuvqdmw5sbVqRYa684R/lZ5/QqbmIG4u/GM2imZJH6Gh95ZpbkgpFKfC9bYWPLG6OpU9tswKjo6ZxpBc6lhWQWcWc2HwtFC9o1duGkGBtVZ6qgMRrQhH8t2K6hEVUCgbz0Xx06B+qCGjWdwszoP8cZ/qnyD8lujOOZmDZRy76pAW8sS2Tlz0C4A6WiidfMZItzBTqoFnfgqzYIbR68WPSW+3IXxDsqK42Gfivselu57hS72n9folmu/YdJY3NpyCzREliwrqKtx80K9glYJZ5VkO72G3J7caWtIJpbqUocgJnHo9ap6+7KkJVFRp9yaQlfSY1EyHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kocTyJYbSxmQpG7P3Fh+B7k5NHjQBxdzGAM2ZwaKABg=;
 b=hJsF1cFDgCoPWk/gyrjkmStY7Qauv84JHxxVbIGFzpYsPnuzN64YcDLb9zuOxnSkbGZls5E7j83LYSooWtvBIxI/Phk8O7PLWwfP2Vy4VCbEaypM41oJvpPHKwiM3IcU24ZbmH+gexmT8GEs7DnEBTPPd03eouvQIHA+2cDWKKmcm1tjjZvdKa1oyAMeMk2Xfb05xk6+tl+jiUXMZaGmbn9ICgCh4JZoyOO81KeWZwxs8WPYwC1Zk1Qlmy3TyokVFmff7WB0YJJViIbSrlYFovXl5yJtIpTo1hfMXB80+VYvixlGSonU8pkWqqoHBCyh31tQe+SLGOU0WjNMthxi1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kocTyJYbSxmQpG7P3Fh+B7k5NHjQBxdzGAM2ZwaKABg=;
 b=iHr5peCb6NnzHcoQ6TWs4J6H9sKhCJLvRHaQ8yZ4ZMU/hqfGummAqeUzQmZboKaOmuXDpXPz6zJQfg4IfV69D1/HUtwoGZ5JaGM0ILwPczniWmVvV19ra/kVWkSKiq4eyILNZiqGMJqx9P+FyzYLKMdwWLWMfJUoATP2kaMdrvUy12h18JJyHyUFiZrhkr8EGYh6KQ5T5dhR0qccZ8UgoHbl6eSKG0iwdAk7dSSpZJ2ALV48rmPrNwzoLSDHphAZCN2PvJwkrSAdxY3Sn3qg8JjJQcsnUb0BLmEj74YZsYf/HQraV3Kw2NjeyUxpsy54i7uXJlTt5CeaxZkVeDTVSw==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 06:51:48 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 06:51:48 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: John Hubbard <jhubbard@nvidia.com>, Alexandre Courbot
	<acourbot@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, Joel Fernandes
	<joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Alistair Popple
	<apopple@nvidia.com>, Surath Mitra <smitra@nvidia.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas
	<bhelgaas@google.com>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kwilczynski@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?=
	<bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, "nouveau@lists.freedesktop.org"
	<nouveau@lists.freedesktop.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alex
 Williamson <alex.williamson@redhat.com>, Neo Jia <cjia@nvidia.com>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index:
 AQHcMlax46GxNkf23km9cIaKZr5arLSsb4WAgAAQmYCAAAOXAIAAAaCAgABrcoCAAG9gAIAAa6iAgAD3WYCAABEVgIAAC9aAgAANE4CAAACYAIAHW0eA
Date: Tue, 7 Oct 2025 06:51:47 +0000
Message-ID: <75316915-fbae-487a-b710-ce01f088a2ed@nvidia.com>
References: <fb5c2be5-b104-4314-a1f5-728317d0ca53@nvidia.com>
 <DD6LORTLMF02.6M7ZD36XOLJP@nvidia.com>
 <12076511-7113-4c53-83e8-92c5ea0eb125@nvidia.com>
 <5da095e6-040d-4531-91f9-cd3cf4f4c80d@nvidia.com>
 <20251001144814.GB3024065@nvidia.com>
 <c56bd720-d935-4b51-b507-d794df3f66f4@nvidia.com>
 <20251002115851.GB3195801@nvidia.com>
 <ea82af0d-663f-4038-b8c9-cf1eba5bc4df@nvidia.com>
 <20251002134221.GA3266220@nvidia.com>
 <0c94b94b-68a7-47e2-acde-0a2082ed36bf@nvidia.com>
 <20251002143116.GA3268803@nvidia.com>
In-Reply-To: <20251002143116.GA3268803@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|IA0PR12MB8976:EE_
x-ms-office365-filtering-correlation-id: b80964d2-53c5-4db8-41a9-08de056dfc8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkxjaEF4OTVlL1RMaC9OSDZ4SjZBRk50SitwUVcwN1F1MWtqLy8xSzJJZVFl?=
 =?utf-8?B?d0h1c0piZnc5NTBrUkZsamgxVWV1cE0velgwdHhNeXRkQ2tNK0EyYUdNeGZ6?=
 =?utf-8?B?ZThwQTV1ZVF4OVd6SmNROUVGckdDVEoxQkp1VTdjUlJ5MDB2MWgyYUlSRFR6?=
 =?utf-8?B?Nk5OZWZqbE9taVhRQ0UrWnZ4aWxrWlNkVEVtc1pJWGROM2xjQWlDQmJtT2hu?=
 =?utf-8?B?YldlbEw4UEVvellWUEdnelZvNUF2Rmd2Wnk1NUtZVERvb1dyc3c3UlZMU0xY?=
 =?utf-8?B?MG05M3dJVHZIejhBSWxGajJrS0t2K3VCdEVpampsYkIrajA0bGgzdW5hTlZt?=
 =?utf-8?B?SXZVSVhmTithRDZERmQ1RWRwZGRubWZpTUpNeW9DOE10QTQ2bngzODZwOHZC?=
 =?utf-8?B?VFkyTy82blFacENJMEdTZFJBZXh5UmFXbVhJRGJ0b2lDT2wwcjhhL1krR2N0?=
 =?utf-8?B?T2pzaDM1cUtDdmR2QnVOTW9wbnNRRERubHczSkhPUm9MK2xjREs5N0FYeXlM?=
 =?utf-8?B?UzNyK2NPWkdadFlYSndKUkFRV3NpZVFOTlVrRmx5Q3Rtd3RFMmtaL2pYLytq?=
 =?utf-8?B?M1l5NzFHNzFvUkNMcDRyTW8vY3dUaE5TOVNMRWhnczJmaDZSVEpmQ1BUcUJ5?=
 =?utf-8?B?M0FSeGZ1aExrS0FqaGY2L04vTEJwdVBENTJxZjhacXlSZkxTckR3SmxwK0xT?=
 =?utf-8?B?S21FVTc2VUN5N21SRm1QMTc5eTNOZmZoSFZES2ZnUEp1VUtaSjEwMFg2WDMz?=
 =?utf-8?B?eG1tOUJXc0ZENXR6ZTlPVEtlV0NrTzRtWnFXQkt6YXA1L3ZVb0dIVW1JaVJW?=
 =?utf-8?B?Y0k5WHdnaHhhTVA5b1d4RU41VjZvMzdXMFUrNTJodXl6ODJCMTFuaHlEcTI4?=
 =?utf-8?B?YXd3djlFbm9weitXRm9BbDV3R2FtK0FhUHlBdm9rakd4TGVpeDFYYnFHVGRa?=
 =?utf-8?B?SkR6YWZkY1hkdmY2RWJUS1ZHK2FPUzgxWEhXWlVWbHdZVS8wV0FhblkxdDZK?=
 =?utf-8?B?ZDgwZ0R6akdud1VNS3pMU2RTazljdGtnYlQzVkF0THNvang4a3AxUGhmeThp?=
 =?utf-8?B?YlIzMTZoaUZvcFdTa29Fb0pFbnV1dWZGK0JJWjlOR3lQWnhDUktDKzNQSWE4?=
 =?utf-8?B?NXpHZWExSGVZMGdtMmdKWnkyT2RsMk95YTlqQmMxYkcvdWZrMXQzK2hXdlpY?=
 =?utf-8?B?a1JKWWhDR21GcVhtV1JzNHd6MFVMQ0kxTXozZG91Ylg1RFJZWm5NL05UOUJX?=
 =?utf-8?B?UjhWWFc5QW1HMGE0Yy9hMFpka200YUVna1p0cTJZdnVMWUZWZDNmTEdKRk13?=
 =?utf-8?B?aFU0OEkrWis4ZTg4YUt6ZmJKYlFrY0k2QndPeDFlSVZkSVp6SHNEQnk1UlMz?=
 =?utf-8?B?MGo0bnJnQ2ErQVJIQmJkNEM2T3pzQlJHY0x1T28zY3BZMWRLQXVtb3QzTURF?=
 =?utf-8?B?WHdMaFJUdzJDMEc2OE1vOVF6YXI3M2tISlo2QXZKcy9QVkVDb0dYdE5hRDRs?=
 =?utf-8?B?SXlZMUMrSlczWk9mNWtMN0NMM3ZsaHBvN0xvZGdEWi9oYjhHL3dVZmRNd3hv?=
 =?utf-8?B?SGNMNC9RcERjUVFiQU9JbERGclU3NE1DMDlEbU9CRnZxWVYvbTZSK0Qyd1Ns?=
 =?utf-8?B?UkwrR0J4b3JJblNCQ1FRZzdnZ2RYTnRsRmVBM21zWmgzTmNpV1ZoTWxmNkZU?=
 =?utf-8?B?bWxab3VldGJXdEh4Nno2QmVMOGtNaFRWdHpPRk1LODE3MTFkYThtUzBMV25n?=
 =?utf-8?B?SjErY1BCWHRtVXMzUE1qYSt6cElqMnh0OE16L3p0blZnL3QwbExqVWhQZFMv?=
 =?utf-8?B?endwNkl0R2VhM1BMbjVJeU1DeE5XWnZHSy9yVHp5Wml4ZjJhaFNpU3RKQUty?=
 =?utf-8?B?b0lLcGRueXB0ZDFIZENzRkZFODhoWjROd1dTWjBQUFFVVWdQV1BnU3poYWlL?=
 =?utf-8?B?QUFNYTIxRkdRYStVTjNmTzN2c2NLOHphYk9SbjRGYW1tb2lia1BDWWRzQ255?=
 =?utf-8?B?RGU4YU5mWWVnY3lwN2o0WjJRR09NbGUzTVByMk9TL0pxTHVpMlppdnM4TVJF?=
 =?utf-8?Q?yhYdNE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejMvbit2TnM3Y3VhUVJ0akxzaHA0RFNHVnlvcjVCaE1NL3kzYkVGOXllSnM1?=
 =?utf-8?B?Uk1GeUhOaWcvU3Nrbi9NY1laaUlYR01CbXRQTUlTK0wyWHA2ajZJSm03U2xa?=
 =?utf-8?B?WWplS0E2MGl3Y3dobFVzS2lOMFE0Ylo2UTVNQnh5QlpRY0NOa3NvSkV1MVNE?=
 =?utf-8?B?UHNYMDRFVnB2akJyWmtOamdtM1NxMWtLSCtWZk5sUGRaN2l2K1VGRi92R2hz?=
 =?utf-8?B?cS9EUklwUEJ2UVVGRjYzRDRRenh0d3VXRExrZ0YxWW9MWXU0dWhVMGJ2M2Ez?=
 =?utf-8?B?VWpJdmxyTmtrUDc1ZmxFRjcvWnVsd3B0Vkg4ZG4zMUN3RHZWM2RDMjFxakNO?=
 =?utf-8?B?YlM1c1hrUHpVOUlOdFhWam5Ka29rcS9YVE5XQzRSbHBqME9IL2RBR2dUc0E5?=
 =?utf-8?B?c3pSYTJxeTlCeWNJZjJ0WlI5L0E4RlY3bjBmRnhxYlVxdWVGVXdGcUh0TjJ1?=
 =?utf-8?B?cytSN1hrVmJRUGJwbjlrNG5iT1dUb2c4RHlXbVhMNXNZdlJmdmg3V0syeDVk?=
 =?utf-8?B?OG5uSEx3elBsQkcvQlFkQkdHcU9KNXAreEF1NGFQcXI4MWRjcjJzckdGWTRW?=
 =?utf-8?B?N2tNMDZTSWNzcmJSMlVqbFJxdVNGSVYyQXlCVm1qdWNZK3BFVVUxV0hHaE1I?=
 =?utf-8?B?YWlmUXdaaVJnZW5FZjQzV0RpaXZocDc2USsvclJ6Vy9yVUg1UEMybUxLSE5X?=
 =?utf-8?B?aWJPMjFiUFVDOEY2V29uOW84aDVtSkRjZWJnNkxuUDlRbjVLbXNUbWNPOEdz?=
 =?utf-8?B?emdhejBPQno5RnpNOFZGcDlhNHR2Z1kwdmE2TFhQNUEvLy9uNE5mUE9aQTlk?=
 =?utf-8?B?YXJ0Rml2R2VHRHNQbWRkRDc3RTFOOGI4VXh5N0pqbnppZTVYMlltU0JKQnY5?=
 =?utf-8?B?QlBaSUJjd0gzMUpDRWUzYW9vZ05PL3h5c050aitQNElqcVltV21Pc08rejlU?=
 =?utf-8?B?ZzFKaUNnWXpqS2ZRVndoc0k2MytTNGc3cHU0cFl4cTlKUXRINk5RT2EwZEdF?=
 =?utf-8?B?UFF1ZzduV1RWaWpBMkhNc3lJMEUzMy90Z3pCNlVkZ0VhVENuZFZRZ0xKL1pC?=
 =?utf-8?B?QmdiU2FhTEZRemc0azdMd09SZWdUR2NTY2VWWVI4VFk4bGUxbURINkZQWC9t?=
 =?utf-8?B?aTBmNHlGTXlzNUhzRHJEL0J3RFdvZFRQNlVWWlJtV09QK1QyY3Y4OGFiN3kr?=
 =?utf-8?B?bXZISy9vR3hlc0hlc0dEeno3RXNuQkVhN3p1T2JqZWpFQ05NRXNROHUvOEc5?=
 =?utf-8?B?ZHZNZkVEeHA3QTRiSlE5VXh2b3R4UExTRHhCQklKQW5CQVJBYmY5QnloY2lp?=
 =?utf-8?B?OGFPWDVqWTYyT2FOajhRUlE4U0xRTVdpNkVrVE03bnJueW8zTE9Vc3FIZzA0?=
 =?utf-8?B?Z3FqaklPSW02TFlXWGswT0xiR0wrbWRRdXIrcGxoQ1lreSs4cmhsU3F0Zmhp?=
 =?utf-8?B?UWlScXRMRzdtdnpvSy9YUGRnMGtsYnFCek9kNFBPbm55aFJNaXlZSy9xZ2JN?=
 =?utf-8?B?ZGhCUEFpL2xMZHBHK2JvMUNsbGFGaXNuQW9BSWJCeVE2U1gzTlM5SDMrNENH?=
 =?utf-8?B?Uy9DU2Z5S0h3L3AvM2x0dnFudnE5d05TZVhIUjZrRThPSG9GQU1qcGR6SDcy?=
 =?utf-8?B?K1MrQXJsZWJPbVRpSmI1YmhvUUlKU1BiSGtZV0ZBenVESzYxaTJHQ1VMaHVm?=
 =?utf-8?B?R1hIdGh6TTk5UXNKNEZBSkZEVEpzKzVFa0U0UFZERzg4L1ZGT1JYeFdkSDE2?=
 =?utf-8?B?NUhHYjg1WGVsbG5OWS95L1d3dzR2OVd6MXNmSVplVzdwOFJndk1OSDNNcjZZ?=
 =?utf-8?B?Vi9YcjNGUDluaEd4dDJ2T3BqTmJSVFNWbkN2VEl1K1hhMHdYK3BOcHljZS9Y?=
 =?utf-8?B?c29VOXFLSTFMOEREdWdlVEo5em41WWtRTEU2bms1aGJhS1NIbjdTcmIrYkk0?=
 =?utf-8?B?TnozN3dnOVlDai9GM2dZVGJ0Uk10eFNobjYrSGJsbzUvUTZoSVlFbU0wLzdZ?=
 =?utf-8?B?SWJJU25tbWRWNXNFcVNnMC9CdG1VdHZna0tSemhydHpEdkRLYnljazdQZGJJ?=
 =?utf-8?B?a1BscG9vVXpOYzJDUk4ranUrc2RZa05UYVplekdSZFRxYmorTmFYQVFRZTJr?=
 =?utf-8?Q?1Ths=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2215703076F6D94FA90042DA43276F9D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80964d2-53c5-4db8-41a9-08de056dfc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 06:51:47.9778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiHgtfi0kiAeUUP/ckZwlPB4iMFoZudGzE/1qdhRODHf1GTXJkdYN/W++j4wa4r5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

T24gMi4xMC4yMDI1IDE3LjMxLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+IE9uIFRodSwgT2N0
IDAyLCAyMDI1IGF0IDAyOjI5OjA5UE0gKzAwMDAsIFpoaSBXYW5nIHdyb3RlOg0KPj4gT24gMi4x
MC4yMDI1IDE2LjQyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4gT24gVGh1LCBPY3QgMDIs
IDIwMjUgYXQgMTI6NTk6NTlQTSArMDAwMCwgWmhpIFdhbmcgd3JvdGU6DQo+Pj4+IE9uIDIuMTAu
MjAyNSAxNC41OCwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPj4+Pj4gT24gV2VkLCBPY3QgMDEs
IDIwMjUgYXQgMDk6MTM6MzNQTSArMDAwMCwgWmhpIFdhbmcgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+
IFJpZ2h0LCBJIGFsc28gbWVudGlvbmVkIHRoZSBzYW1lIHVzZSBjYXNlcyBvZiBOSUMvR1BVIGlu
IGFub3RoZXIgcmVwbHkNCj4+Pj4+PiB0byBEYW5pbG8uIEJ1dCB3aGF0IEkgZ2V0IGlzIE5WSURJ
QSBkb2Vzbid0IHVzZSBiYXJlIG1ldGFsIFZGIHRvIHN1cHBvcnQNCj4+Pj4+PiBsaW51eCBjb250
YWluZXIsIA0KPj4+Pj4NCj4+Pj4+IEkgZG9uJ3QgdGhpbmsgaXQgbWF0dGVyIHdoYXQgIk5WSURJ
QSIgZG9lcyAtIHRoaXMgaXMgdGhlIHVwc3RyZWFtDQo+Pj4+PiBhcmNoaXRlY3R1cmUgaXQgc2hv
dWxkIGJlIGZvbGxvd2VkIHVubGVzcyB0aGVyZSBpcyBzb21lIHNpZ25pZmljYW50DQo+Pj4+PiBy
ZWFzb24uDQo+Pj4+DQo+Pj4+IEhtbS4gQ2FuIHlvdSBlbGFib3JhdGUgd2h5Pw0KPj4+Pg0KPj4+
PiBGcm9tIHRoZSBkZXZpY2UgdmVuZG9yJ3Mgc3RhbmNlLCB0aGV5IGtub3cgd2hhdCBpcyB0aGUg
YmVzdCBhcHByb2FjaA0KPj4+PiB0byBvZmZlciB0aGUgYmV0dGVyIHRoZSB1c2VyIGV4cGVyaWVu
Y2UgYWNjb3JkaW5nIHRvIHRoZWlyIGRldmljZQ0KPj4+PiBjaGFyYWN0ZXJpc3RpYy4NCj4+Pg0K
Pj4+IFlvdSBjYW4gZWFzaWFsbHkgcHVzaCB0aGUgY29kZSB0byBub3ZhIGNvcmUgbm90IHZmaW8g
YW5kIG1ha2UgaXQgd29yaw0KPj4+IGdlbmVyaWNhbGx5LCBzb21lIHNpZ25pZmljYW50IHJlYXNv
biBpcyBuZWVkZWQgYmV5b25kICJ0aGUgdmVuZG9yDQo+Pj4gZG9lc24ndCB3YW50IHRvIi4NCj4g
DQo+IFlvdSdkIGhhdmUgdG8gYmUgbW9yZSBzcGVjaWZpYywgSSBkaWRuJ3Qgc2VlIHJlYWxseSBh
bnkgbWVkaWF0aW9uDQo+IHN0dWZmIGluIHRoZSB2ZmlvIGRyaXZlciB0byBleHBsYWluIHdoeSB0
aGUgVkYgaW4gdGhlIFZNIHdvdWxkIGFjdCBzbw0KPiBkaWZmZXJlbnRseSB0aGF0IGl0ICJjb3Vs
ZG4ndCB3b3JrIg0KPiANCg0KRnJvbSB0aGUgZGV2aWNlIHZlbmRvcuKAmXMgcGVyc3BlY3RpdmUs
IHdlIGhhdmUgbm8gc3VwcG9ydCBvciB1c2UgY2FzZSBmb3INCmEgYmFyZS1tZXRhbCBWRiBtb2Rl
bCwgbm90IG5vdyBhbmQgbm90IGluIHRoZSBmb3Jlc2VlYWJsZSBmdXR1cmUuIEV2ZW4NCmh5cG90
aGV0aWNhbGx5LCBzdWNoIHN1cHBvcnQgd291bGQgbm90IGNvbWUgZnJvbSBub3ZhLWNvcmUua28s
IHNpbmNlDQp0aGF0IHdvdWxkIGRlZmVhdCB0aGUgcHVycG9zZSBvZiBtYWludGFpbmluZyBhIHRy
aW1tZWQtZG93biBrZXJuZWwNCm1vZHVsZSB3aGVyZSBtaW5pbWl6aW5nIHRoZSBhdHRhY2sgc3Vy
ZmFjZSBhbmQgcHJlc2VydmluZyBzdHJpY3QNCnNlY3VyaXR5IGJvdW5kYXJpZXMgYXJlIHByaW1h
cnkgZGVzaWduIGdvYWxzLg0KDQo+IEV2ZW4gaWYgdGhlcmUgaXMgc29tZSBzbWFsbCBGVyBpc3N1
ZSwgaXQgaXMgYmV0dGVyIHRvIHN0aWxsIHN0cnVjdHVyZQ0KPiB0aGluZ3MgaW4gdGhlIG5vcm1h
bCB3YXkgYW5kIGFzc3VtZSBpdCB3aWxsIGdldCBmaXhlZCBzb21ldGltZSBsYXRlcg0KPiB0aGFu
IHRvIGZvcmV2ZXIgY2xvc2UgdGhhdCBkb29yLg0KPiANCj4gSmFzb24NCg0K

