Return-Path: <linux-pci+bounces-37344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F79ABB0924
	for <lists+linux-pci@lfdr.de>; Wed, 01 Oct 2025 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF4D2A44CB
	for <lists+linux-pci@lfdr.de>; Wed,  1 Oct 2025 13:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A8D2FC871;
	Wed,  1 Oct 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OOxdiwHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFB02FC865;
	Wed,  1 Oct 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759326764; cv=fail; b=RDwaJKwbv8a5sVY+45vXjH5qaq+7XwiohecD4Birut0M1LBQ156syKKDZqYgNUoI93rNWNLtWmxg4GmElxNbiuNwjynWI6zsWOtWxqEoWmfPBXyRZpei3e/Ot4YHlUtDWLAt1Dagpp3NEqASqONIAoFWxT2XVcfO9kMYOZz5dP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759326764; c=relaxed/simple;
	bh=xb6UtI0Rqwjnsf0Rw55AxLttSKB3pAUK6Kb3A9m+bnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSFkHGEq6e95tL7+CUxOleoWB79t18M/roRxSol68hOL4pPFUSKke6V5XToNcfXWMSunO5opfhVx/dBDZV7ya2ahRVScmt13AOs9DQVV7r94l7z+V9EDWlx/LI34NBTrjVN4ylzCy6yKF+zvVP7hTZT2cAXYQ5bfNJxsL86tJy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OOxdiwHB; arc=fail smtp.client-ip=40.93.194.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKhqgPfhlQY+/DQdxRSl4GvKsPMC9R/hXiBtpAlYV+dd5NI964nYAixxS5hQN6THp8z+kqbXUKcrqEorzBFcivpPjGMynQdv8pGAOiiQ6d8xsvatOPSROiJQRQQWi5J5G8+e+26x/oJvwD7GCPRIJ0m1DeeVIy6MrRWEMGJtiM3ncLeTfvnPSoCwgDS83K2MDB/BPaNr60TFtK8r22BavgDtbkfWQMji2VTukB2F/7WTZUYXGAMoCjS/X7BiBpmpXc5pvAk4I3FQCnY4OHsl4q3pY+Pka78is/iWFddakMbcgijmcr18hN5iIMEvC2qrWeB/sQcaBhGj4X8b05FKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xb6UtI0Rqwjnsf0Rw55AxLttSKB3pAUK6Kb3A9m+bnA=;
 b=U83b6hIqy2qafNJvfPAEViWsDaUJjVf5ORLnZvXwANb28i9G/eWDHf6/kjn42M/5AnSIvwgrJ39fqkJy2EroVfS59BOIZMZcFcD0U4lZsiAAzXeMV6zjLV/st8sdK/OySXWQVDLT3suYe3FvF2q+7OL1LKbFekqmBau4STsawUvVH8H2wNZsKbjzJTdMw2gT1NREDKjbfQJ+aiuc3TvUbhQptKRWHhKh5ZkkWQRmkgK+JWakLb0/aRjuMJ0nBSqirG1j0ocTZMjuUohnJ1y778zbD5syRlii+R+hnIvVBNsMDyxx/eGuN+rr2AoEDWFZJ88WmDGhgZBn0KcIEWbgFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xb6UtI0Rqwjnsf0Rw55AxLttSKB3pAUK6Kb3A9m+bnA=;
 b=OOxdiwHBy6PSYe0kErbi2Io2XmClZoaij2BZVhe9vAuc2Xgv/jl4e21VPiJ5fM1YjerrTTC2k7HjfTGWJ/DkyRr9x6pMBmmAKTpTrvn1KPow3AZHT9a3i+OccNhX+OdXaVP78OggFVj5yUV4ypAhTea6h6WF2PhWYrli3XUwGFkLfnOJ+ZFB1bm480gXgaF74PUegxnkgTyhS1gD4Wse1hGAwAKuPJUDXEqpiheQlusHvvh1rJPvKr1U5wci+XoI9a3G6NKtvknq0Rrkj12qze0qfteQ0Zzt49FH7glQdJtg/zgWU5haiiaNj54++jjPj2In31LG479iwhUarpZvtg==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 13:52:39 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 13:52:39 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
CC: Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes
	<joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, Surath Mitra
	<smitra@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Topic: [PATCH 0/2] rust: pci: expose is_virtfn() and reject VFs in
 nova-core
Thread-Index: AQHcMlax46GxNkf23km9cIaKZr5arLSscEuAgAAO2gCAAJltAIAAOAkA
Date: Wed, 1 Oct 2025 13:52:38 +0000
Message-ID: <f145fd29-e039-4621-b499-17ab55572ea4@nvidia.com>
References: <20250930220759.288528-1-jhubbard@nvidia.com>
 <h6jdcfhhf3wuiwwj3bmqp5ohvy7il6sfyp6iufovdswgoz7vul@gjindki2pyeh>
 <e77bbcda-35a3-4ec6-ac24-316ab34a201a@nvidia.com>
 <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
In-Reply-To: <DD6X0PXA0VAO.101O3FEAHJUH9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|SA3PR12MB9131:EE_
x-ms-office365-filtering-correlation-id: 120338cf-a858-44b8-526e-08de00f1c8b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bVdRK1lEVlorejU3cWM1SDAwbDU3Q1dZaC9DNGwvZ0pLY2I1dDlUcVFMNXdR?=
 =?utf-8?B?c3J2aG9GbHovK0NDMzNnOEVDWjFscWk3L2xkU1VHdFVzOE50a2ZCRWgvUk4r?=
 =?utf-8?B?ZHduVXZBU2thWXhRR2NuNXZzSmpHRnRlM1Y0S0JyTnBtYXRnMCs0TEJPUFBP?=
 =?utf-8?B?UTRpSDZkaGxkZExndWsvNytUWmw4bDZnS2UwVFFZb0pQWCtxeFZobkNWN1lW?=
 =?utf-8?B?S0ZkRkRFQzRZSlRGTS9GUUtKTmxtM282bTU5bmFRZjZVaWRkOFM3TFFmTmZE?=
 =?utf-8?B?WDRHbDEzTW1XVFdCRllBQmhrWlFkRVJOWGVCa2l6NHhsTEJSN0FGa0tjQ0Fj?=
 =?utf-8?B?V01rcnZ6S3pROXYwbTN1NmVOOC91ZjdOeFRLMFYrTklYZFFJS1ZrL014RlBp?=
 =?utf-8?B?T1p0YzRlcXgxQWt4eW1GQmErODVPYS8wQjAwTnZGeFdlZy81T3hRbFdLaEk1?=
 =?utf-8?B?M3hieS83WkJpRGFXQ2lKeUlLbDh4aDh5ZVhFODdEVkJXVW9aN0E2NFQ1YnZs?=
 =?utf-8?B?MFh3ZDQ4SkYvQUlVNENhK3FnbEZVQkRpWk5yUUlWNFFnQmZkVVdQZFlHUXF6?=
 =?utf-8?B?VjllMkxLK2oxRWZ0cEQxTmpaUnBscVN1Y0laaW1sZG9ub01xNXg5WDZ5UVh5?=
 =?utf-8?B?bGxFR3ltZHlZemhRc2RReHhSUUJlRXNDeDNnNW9HQmQ2OE1JM05jZVRTVVE3?=
 =?utf-8?B?WXhqd29TS2lma0RCNmN2UFFsT2taK3lYakQ5R1FyWGZXSjhhdUFIcFVjd094?=
 =?utf-8?B?R3NXQm1UQjJQTnliK05LU2owQVpTeWFuTUVxQ3JDMXNUb1pwbUxTa3BCaG5w?=
 =?utf-8?B?YVVZNHZzYVQyYWVPSGtWNG9udUgzVWZOdmhzV0YzQmpTZnNaM2hzWG1FTnVH?=
 =?utf-8?B?eU10blVsSUt4UWhnaHFweERndWVlenRqNHFOVnBrQVlMSDJqV1ZRSFY4azhp?=
 =?utf-8?B?MmdxNjNLZjkvMmVZQzNZeFhnL2RZUUtLTTJET3FySU1VVTJuRjFwMmpqRkVU?=
 =?utf-8?B?c3Z1ODB3K3IzTUlsL2ZBY3VHWmwrRFNFUmVFRGVudzJ0RzI2RGVRaldkRm85?=
 =?utf-8?B?RFNkVUl6c25yY0dvK0laV3VKdVUvUDhzQzF3ZjVBYlZiTEI4WTBNcTA1clU4?=
 =?utf-8?B?cWFLdEJXUGcwUk56TUhBVm56QndHMXQ1QUM5VXVCQUVsRit0SEpFRzZFQ0Fp?=
 =?utf-8?B?b1hRTGRYUWJTMXVYY1V2ZGlGNWQ5U2trRnR4TjFHT3F2ekM0b3hLTGsrekxr?=
 =?utf-8?B?cUNFVm1yQVMwNUdEb2YzUGloczdJUVdjdGRDbFRWZkJIN3l6NXJNWWdGdmov?=
 =?utf-8?B?NmdBUUxINVA5UGRqU0J5eFh0VWV5VVpRLzI3VXVzdDZhSHJjTmNWNEVlT1Bw?=
 =?utf-8?B?eCtEUitLM2h5K0RGVEJGSW1JOGUwQS9wUlgzY05yZ2dxNFhsWDE2SDd0RjBW?=
 =?utf-8?B?YXRvdXZ0Ny9YV09xcmhaMlg0dkhBbC90eEkrbGlHRlo5S2NTenlXOFFJSDFj?=
 =?utf-8?B?NExUMnhXNlNqbzBFK0lBU0NZbGJSbXM3Z29RZDFtdWpNV29HOHVQRllNTGIx?=
 =?utf-8?B?bC9COVRXRFhCTTVjU3ZrZFVJR2srM2xxSE0wcXZ2T0ZnSWpHejV4SEExWktC?=
 =?utf-8?B?ZjgvTVRqKy9CU2RUNURDdDVhZWNuUnZwS0t3Ym5obThPV3ZOTURnbjVyNjZJ?=
 =?utf-8?B?UjgraUlvK2E5NkN2WVNISlN1ZGFNWXl1MDVZYm83SXpkTUhxZkc5dTB0TkNT?=
 =?utf-8?B?MzlBWU9VQnVJd0JPSGliUVpSYjcyN085MkJZaFpZbmVZZUZGWkdIbkhTRkRJ?=
 =?utf-8?B?MlUxTmZtM3czc3l0MUh6YWNUYUgwYjlXRVVCMXhKZ3c1TE9KL3lmL0pPeUtt?=
 =?utf-8?B?WXBDQ1ZKU1kydE84MWVKMm5UUjR1VWdwZmJKWkl5UlpEVkIxMDhBK2JRaXFr?=
 =?utf-8?B?RFh3VDBkcW53N0o5ZldicVpSTVlmb3U1bHRPSHNNd3dWdXZZT0htZGhoanVr?=
 =?utf-8?B?c096VUxZd3duQXkvaUNyb3ZhclBJeDdxeWhJYVErMWFKRkNjYkNCN1Exdldi?=
 =?utf-8?Q?K/FoYK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cmVibjNXTHFtWHRNY283NkNHYVFlU3lNRVgrd3pJSzVSZ0padjVuMlo5WWlk?=
 =?utf-8?B?QWplc1YxWGhSNFdrd0hCUFl0MEIxam56WWtPeExUeHk0SWdGUVc2LzcrQlZZ?=
 =?utf-8?B?M3h3OGkyZWszUVVEdU1NMlE4eTJpR0cxdk84cTcwSlRSY1JCTEYzUkl6ZHY4?=
 =?utf-8?B?dEhna25FMlFGZWhnYTJ1K2ZtNndWeG1raEwxTTROazBnS3RNMGZoVXFOb3U4?=
 =?utf-8?B?TVBZWEprN0MrbVpMNFdYQ0w5Ly9vdXlwUjRuQVhpQmlGNXlOci95MXNGRkpL?=
 =?utf-8?B?akE2cmx3b1VVYW4vYlY2ZmNCenhUb0s5SUhNOHgyVEtNbTZOdHhhdEk1a2RJ?=
 =?utf-8?B?OXliR3Q4V1hZaGpzSHVkMWdPOFg4QklOMjR4azlCZTBaUmVwck9ZcFpNTHlJ?=
 =?utf-8?B?SG56SDlOYTJab21xTUFGQ3NLMXVNRmxrNUI4Slo3WDRYdGc4S21kRmpxeDE2?=
 =?utf-8?B?NzRVVHVEZlEwU3llS0JqU1dydVFQbGNTMTlMekVZbzJEbEgra2YyRnNBRHU5?=
 =?utf-8?B?WUk2WVNtVjNQdkdPSkE4N25lcVE5QVlRMlU1MlNZSWZkN1g1WU13ajlUTXFH?=
 =?utf-8?B?OW1MbmR1U2lBN1RYbk5tM3VhdGtxNDFPYTgrSEVWOFZJUy9kZEo3T0F5REpn?=
 =?utf-8?B?Z2g4WXlZZ0FyVlpVQ0ZHbUtkMjkyWHk2RDRmOGNXMlRlTUtZcWxZSzZmaFJm?=
 =?utf-8?B?Qm0zeUJVUTdYTk9IeUl6Z3RiKzhIaHd2d0VTMk1rdlk0MVpBODRlMTI2MG5m?=
 =?utf-8?B?dXZRUVk2LzByNlhrSVJFSjdMMlI0R005d1FoVzZxellaTjVDeEpINVNPNE1o?=
 =?utf-8?B?eWpBbXkzalZkZXBVdnd4L1pLcFpBNVZPdjVPYzFiOHpKZFV0RVJkNW9ybDZG?=
 =?utf-8?B?NzRLaXBla3BnZ01DdllnMk5Qb0d2VWJqVlFRREtUYW15R3dxejNKZmpuMjdo?=
 =?utf-8?B?S3krUDVJNk9YU0MvdFlIMmNhSzdENnovSUNOVEY2WHZCcWpDR2tYcUxPSVFB?=
 =?utf-8?B?Q3NXZitWYm0vUWNlNkMycDVVOXRXbUJpSlVXOVUrYXBhUmFiWG9WcHk0RWdE?=
 =?utf-8?B?eHFiR3VhbEt5WXBOUWI5ZS9Va1VHcjZmOGRqdzQ2Ly9zczR1S3ZvVmg4YlVo?=
 =?utf-8?B?RzdFQTZCOEpzcnhNbGVDbEdoSU1QUzBzM3Z1MzdCUitLVlh3VmYwQ1Y2WnBr?=
 =?utf-8?B?bEpJcWVnQ1NzOUtWZWRjR3hqRmpkVnlRN3ZWMUp6TmgwZUp0Qk03akd1VmdX?=
 =?utf-8?B?a2R2aytjQURDcU11N09GZnFaNkJMVDhxblZCTW1WamxlZmNmakpyaTFxTXhh?=
 =?utf-8?B?Z3pOQVRMREt2ZXFvc2l6TEwyNjd4NE82YVNsbEk4WHRGWnBYRVpjNmxHYnl0?=
 =?utf-8?B?d1crcnUwbzdneE9NWXFGWnZpUWdnelJIdnFQZk5iSXBwU0NHNnpyQ0dvOGNl?=
 =?utf-8?B?aEYrUzhjL1BoWE5yOWl2aUluV1dodERIaDZBMy9pcEhPQjN1dWc0b0pXbVhE?=
 =?utf-8?B?WWt4NmZkOTRrNGRpemc5UndOSThZSklkdTVZUXJBU1NZNEViZzQwSFpKV1J2?=
 =?utf-8?B?YVpLZno5dSs1Z0FyNFJ3SkdOSWNhellZYi9ncUpESnlONzhzdXR6NjgvOGZI?=
 =?utf-8?B?eDFlZ1cvUTBmSWN4NUJUTC9UamJQNmlQZDVpdllhc28zeFVnUjl1S3B4czJ6?=
 =?utf-8?B?eE4wUk9lQkFYVzc4Zm9aZE1jSk9wNEw0aEhpakdQYzZDM00vYWxNUjMzL1Nw?=
 =?utf-8?B?eUpENnZhS3pvM0dtSHdVOFJPdWY0S2RRQ05HN0pwRTE3NW10MDFpaVI0c2Ur?=
 =?utf-8?B?L0hZOERvQklHcHhWL1YxMTRhTEJoVDdPMzBRU1R0Rk12aTRyOFRpQUhJSWxR?=
 =?utf-8?B?NWN3TmZjTzR0Vkt0eko5TDVzM2E0b1dtU0tJUi9jbytzWE0zeFBUUnBraDlp?=
 =?utf-8?B?bGNuWlVmaWRuNVJ1R0FDQjNsUll1b051aHRHbStPaC9oSStoRzhCbjZQQTBq?=
 =?utf-8?B?eC9zQnJEQkROa1ZkeGltUWd6QmpxRzhtUm5CNVVkYnJMVnJ0LytOcWhnWmds?=
 =?utf-8?B?aFVSOVg4SlpjY01SREpmaTVINTZCU1RXWkU3V0t3VnNYUVJSNkYvbVVua1NB?=
 =?utf-8?Q?X81s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70510FEB9549114EBB145B66D10C6075@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 120338cf-a858-44b8-526e-08de00f1c8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2025 13:52:38.6850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKhrfNRGh2hoMuBmAkBmwAPBneWk9qsmiNOvuhFPYBak4UfQAiIxOQDUV9AyJMK+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

T24gMS4xMC4yMDI1IDEzLjMyLCBEYW5pbG8gS3J1bW1yaWNoIHdyb3RlOg0KPiBPbiBXZWQgT2N0
IDEsIDIwMjUgYXQgMzoyMiBBTSBDRVNULCBKb2huIEh1YmJhcmQgd3JvdGU6DQo+PiBPbiA5LzMw
LzI1IDU6MjkgUE0sIEFsaXN0YWlyIFBvcHBsZSB3cm90ZToNCj4+PiBPbiAyMDI1LTEwLTAxIGF0
IDA4OjA3ICsxMDAwLCBKb2huIEh1YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+IHdyb3RlLi4u
DQo+Pj4+IFBvc3QtS2FuZ3Jlam9zLCB0aGUgYXBwcm9hY2ggZm9yIE5vdmFDb3JlICsgVkZJTyBo
YXMgY2hhbmdlZCBhIGJpdDogdGhlDQo+Pj4+IGlkZWEgbm93IGlzIHRoYXQgVkZJTyBkcml2ZXJz
LCBmb3IgTlZJRElBIEdQVXMgdGhhdCBhcmUgc3VwcG9ydGVkIGJ5DQo+Pj4+IE5vdmFDb3JlLCBz
aG91bGQgYmluZCBkaXJlY3RseSB0byB0aGUgR1BVJ3MgVkZzLiAoQW4gZWFybGllciBpZGVhIHdh
cyB0bw0KPj4+PiBsZXQgTm92YUNvcmUgYmluZCB0byB0aGUgVkZzLCBhbmQgdGhlbiBoYXZlIE5v
dmFDb3JlIGNhbGwgaW50byB0aGUgdXBwZXINCj4+Pj4gKFZGSU8pIG1vZHVsZSB2aWEgQXV4IEJ1
cywgYnV0IHRoaXMgdHVybnMgb3V0IHRvIGJlIGF3a3dhcmQgYW5kIGlzIG5vDQo+Pj4+IGxvbmdl
ciBpbiBmYXZvci4pIFNvLCBpbiBvcmRlciB0byBzdXBwb3J0IHRoYXQ6DQo+Pj4+DQo+Pj4+IE5v
dmEtY29yZSBtdXN0IG9ubHkgYmluZCB0byBQaHlzaWNhbCBGdW5jdGlvbnMgKFBGcykgYW5kIHJl
Z3VsYXIgUENJDQo+Pj4+IGRldmljZXMsIG5vdCB0byBWaXJ0dWFsIEZ1bmN0aW9ucyAoVkZzKSBj
cmVhdGVkIHRocm91Z2ggU1ItSU9WLg0KPj4+Pg0KPj4+PiBBZGQgYSBtZXRob2QgdG8gY2hlY2sg
aWYgYSBQQ0kgZGV2aWNlIGlzIGEgVmlydHVhbCBGdW5jdGlvbiAoVkYpLiBUaGlzDQo+Pj4+IGFs
bG93cyBSdXN0IGRyaXZlcnMgdG8gZGV0ZXJtaW5lIHdoZXRoZXIgYSBkZXZpY2UgaXMgYSBWRiBj
cmVhdGVkDQo+Pj4+IHRocm91Z2ggU1ItSU9WLiBUaGlzIGlzIHJlcXVpcmVkIGluIG9yZGVyIHRv
IGltcGxlbWVudCBWRklPLCBiZWNhdXNlDQo+Pj4+IGRyaXZlcnMgc3VjaCBhcyBOb3ZhQ29yZSBt
dXN0IG9ubHkgYmluZCB0byBQaHlzaWNhbCBGdW5jdGlvbnMgKFBGcykgb3INCj4+Pj4gcmVndWxh
ciBQQ0kgZGV2aWNlcy4gVGhlIFZGcyBtdXN0IGJlIGxlZnQgdW5jbGFpbWVkLCBzbyB0aGF0IGEg
VkZJTw0KPj4+PiBrZXJuZWwgbW9kdWxlIGNhbiBjbGFpbSB0aGVtLg0KPj4+DQo+Pj4gQ3VyaW91
c2x5IGJhc2VkIG9uIGEgcXVpY2sgZ2xhbmNlIEkgZGlkbid0IHNlZSBhbnkgb3RoZXIgZHJpdmVy
cyBkb2luZyB0aGlzDQo+Pj4gd2hpY2ggbWFrZXMgbWUgd29uZGVyIHdoeSB3ZSdyZSBkaWZmZXJl
bnQgaGVyZS4gQnV0IGl0IHNlZW1zIGxpa2VseSB0aGVpcg0KPj4+IHZpcnR1YWwgZnVuY3Rpb25z
IGFyZSBzdXBwb3J0ZWQgYnkgdGhlIHNhbWUgZHJpdmVyIHJhdGhlciB0aGFuIHJlcXVpcmluZyBh
DQo+Pj4gZGlmZmVyZW50IFZGIHNwZWNpZmljIGRyaXZlciAob3IgSSBnbGFuY2VkIHRvbyBxdWlj
a2x5ISkuDQo+Pg0KPj4gSSBoYXZlbid0IGNoZWNrZWQgaW50byB0aGF0LCBidXQgaXQgc291bmRz
IHJlYXNvbmFibGUuDQo+IA0KPiBUaGVyZSBhcmUgbXVsdGlwbGUgY2FzZXM6DQo+IA0KPiBTb21l
IGRldmljZXMgaGF2ZSBkaWZmZXJlbnQgUENJIGRldmljZSBJRHMgZm9yIHRoZWlyIHBoeXNpY2Fs
IGFuZCB2aXJ0dWFsDQo+IGZ1bmN0aW9ucyBhbmQgZGlmZmVyZW50IGRyaXZlcnMgaGFuZGxpbmcg
dGhlbi4gT25lIGV4YW1wbGUgZm9yIHRoYXQgaXMgSW50ZWwNCj4gSVhHQkUuDQo+IA0KPiBCdXQg
dGhlcmUgYXJlIGFsc28gc29tZSBkcml2ZXJzLCB3aGljaCBkbyBhIHNpbWlsYXIgY2hlY2sgYW5k
IGp1c3Qgc3RvcCBwcm9iaW5nDQo+IGlmIHRoZXkgZGV0ZWN0IGEgdmlydHVhbCBmdW5jdGlvbi4N
Cj4gDQoNClJpZ2h0LCBpdCByZWFsbHkgZGVwZW5kcyBvbiB0aGUgaGFyZHdhcmUgZGVzaWduIGFu
ZCB0aGUgaW50ZW5kZWQgdXNlDQpjYXNlcywgYW5kIGlzIHRoZXJlZm9yZSBkZXZpY2Utc3BlY2lm
aWMuIEluIG5ldHdvcmtpbmcsIGZvciBleGFtcGxlLA0KdGhlcmUgYXJlIHNjZW5hcmlvcyB3aGVy
ZSBWRnMgYXJlIHVzZWQgZGlyZWN0bHkgb24gYmFyZSBtZXRhbCAtIHN1Y2ggYXMNCndpdGggRFBE
SyB0byBieXBhc3MgdGhlIGtlcm5lbCBuZXR3b3JrIHN0YWNrIGZvciBiZXR0ZXIgcGVyZm9ybWFu
Y2UuIEluDQpzdWNoIGNhc2VzLCBQRiBhbmQgVkYgZHJpdmVycyBjYW4gZW5kIHVwIGJlaW5nIHF1
aXRlIGRpZmZlcmVudCBhbmQgVkYgDQpkcml2ZXIgY2FuIGF0dGFjaCBvbiB0aGUgYmFyZW1ldGFs
ICh2aWEgcGRldi0+aXNfdmlydGZuIGluIHByb2JlKCkpLg0KDQpTaW1pbGFybHksIGluIHRoZSBH
UFUgZG9tYWluLCB0aGVyZSBhcmUgY29tcGFyYWJsZSBzY2VuYXJpb3Mgd2hlcmUgVkZzDQphcmUg
ZXhwb3NlZCBvbiBiYXJlIG1ldGFsIGZvciB1c2UgY2FzZXMsIGxpa2UgY29udGFpbmVycy4NCg0K
KEkgcmVtZW1iZXIgWGUgZHJpdmVyIGNhbiBiZSBhdHRhY2hlZCB0byBhIFZGIGluIGJhcmUgbWV0
YWwgZm9yIHN1Y2ggYQ0KdXNlIGNhc2UuKQ0KDQpGb3IgTlZJRElBIEdQVXMsIFZGcyBhcmUgb25s
eSBhc3NvY2lhdGVkIHdpdGggVk1zLiBTbyB0aGlzIGNoYW5nZQ0KbWFrZXMgc2Vuc2Ugd2l0aGlu
IHRoaXMgc2NvcGUuDQoNClouDQoNCj4gU28sIHRoaXMgcGF0Y2ggc2VyaWVzIGRvZXMgbm90IGRv
IGFueXRoaW5nIHVuY29tbW9uLg0KPiANCj4+PiBJJ20gZ3Vlc3NpbmcgdGhlIHByb3Bvc2FsIGlz
IHRvIGZhaWwgdGhlIHByb2JlKCkgZnVuY3Rpb24gaW4gbm92YS1jb3JlIGZvcg0KPj4+IHRoZSBW
RnMgLSBJJ20gbm90IHN1cmUgYnV0IGRvZXMgdGhlIGRyaXZlciBjb3JlIGNvbnRpbnVlIHRvIHRy
eSBwcm9iaW5nIG90aGVyDQo+Pj4gZHJpdmVycyBpZiBvbmUgZmFpbHMgcHJvYmUoKT8gSXQgc2Vl
bXMgbGlrZSB0aGlzIHdvdWxkIGJlIHNvbWV0aGluZyBiZXN0DQo+Pj4gZmlsdGVyZWQgb24gaW4g
dGhlIGRldmljZSBpZCB0YWJsZSwgYWx0aG91Z2ggSSB1bmRlcnN0YW5kIHRoYXQncyBub3QgcG9z
c2libGUNCj4+PiB0b2RheS4NCj4gDQo+IFllcywgdGhlIGRyaXZlciBjb3JlIGtlZXBzIGdvaW5n
IHVudGlsIGl0IGZpbmRzIGEgZHJpdmVyIHRoYXQgc3VjY2VlZHMgcHJvYmluZw0KPiBvciBubyBk
cml2ZXIgaXMgbGVmdCB0byBwcm9iZS4gKFRoaXMgYmVoYXZpb3IgaXMgYWxzbyB0aGUgcmVhc29u
IGZvciB0aGUgbmFtZQ0KPiBwcm9iZSgpIGluIHRoZSBmaXJzdCBwbGFjZS4pDQo+IA0KPiBIb3dl
dmVyLCBub3dhZGF5cyB3ZSBpZGVhbGx5IGtub3cgd2hldGhlciBhIGRyaXZlciBmaXRzIGEgZGV2
aWNlIGJlZm9yZSBwcm9iZSgpDQo+IGlzIGNhbGxlZCwgYnV0IHRoZXJlIGFyZSBzdGlsbCBleGNl
cHRpb25zOyB3aXRoIFBDSSB2aXJ0dWFsIGZ1bmN0aW9ucyB3ZSd2ZSBqdXN0DQo+IGhpdCBvbmUg
b2YgdGhvc2UuDQo+IA0KPiBUaGVvcmV0aWNhbGx5LCB3ZSBjb3VsZCBhbHNvIGluZGljYXRlIHdo
ZXRoZXIgYSBkcml2ZXIgaGFuZGxlcyB2aXJ0dWFsIGZ1bmN0aW9ucw0KPiB0aHJvdWdoIGEgYm9v
bGVhbiBpbiBzdHJ1Y3QgcGNpX2RyaXZlciwgd2hpY2ggd291bGQgYmUgYSBiaXQgbW9yZSBlbGVn
YW50Lg0KPiANCj4gSWYgeW91IHdhbnQgSSBjYW4gYWxzbyBwaWNrIHRoaXMgdXAgd2l0aCBteSBT
Ui1JT1YgUkZDIHdoaWNoIHdpbGwgcHJvYmFibHkgdG91Y2gNCj4gdGhlIGRyaXZlciBzdHJ1Y3R1
cmUgYXMgd2VsbDsgSSBwbGFuIHRvIHNlbmQgc29tZXRoaW5nIGluIGEgZmV3IGRheXMuDQoNCg==

