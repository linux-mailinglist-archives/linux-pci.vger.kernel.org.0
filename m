Return-Path: <linux-pci+bounces-37453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4ABB4BE2
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 19:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C2819C8DFE
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2462586C9;
	Thu,  2 Oct 2025 17:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ly62bmQN"
X-Original-To: linux-pci@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D026D4C7;
	Thu,  2 Oct 2025 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759427378; cv=fail; b=cECbsWg69+I80PyJnEjHkN3h1X000Ar33uwA0fcTlKJZUTvLwllQbxIF3NxNPNiHN9zUXNgbCgz2mojMBoTTIfar/mP08dm21OT1Qukh5LHv3NbGHgg9y9uBH+seHFvYvYZFF397jSXpyGIdFBw5irsw+nG+Engohu602hhNNsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759427378; c=relaxed/simple;
	bh=dwV4ZX2T86GqpiMnPH3VuNzuYlqlhFWqiDCrib8SvAA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOwGK/e67/g6xlLTzXoQy2AElFfkJMXXdo9iwjBYL4qEmItt3HD2eFBTzvwcN6tFdgSi0vf6yHyRS4K7G4WDOOa6PieAhVar78bGj78e+6xJ5jc8JhJqSDgLcNTHCA/nhR/OqtfGa+GWyevcNDjK9OVPpQeNDE9qN5VrZtP0xd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ly62bmQN; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QurvU0dxP1+i+5VbpKNMUb76jlyr2slv3FwGhlRm2ty9IjJzX3g9SjbG96ua1QcQ+RyDA802nQRfN3Hct+16f4guFlQjQ31ANHgdQmYY51Y4q7jXvZOvv35HxTgrthTBfDagfqIURym/f8BZTdLBC9W5nyJV23BhNQSGlH8TvuL1EsllPYGNKdBqan4Mny0ylecRff1xWF4VeHAbMtUhtypQLe8oydkxS1uZlPBOm2PlPVZyrfFgAx2ZwksDGD9B/t8/3s6V+aaiKWeZoA/orANduxDOSr160mUHWGmLXzk2kwrU3nPrKDODJYbZZ2bK66cDhL/1A6RrI+mt3tBflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CMsIAo+oee/GyFA3hG+bQ7gq0+wIknbnYPMXrf+OSg=;
 b=gprbMMwoAibl2073jOFQ8orqlJe49TpmT7btRt1nRup2rxtW9KBXi+JugXVHg8DNlVJB60NFqJHInS+et3cK3SvGRfaMgTclnePrlurMa89BdbMM/F2BTJdPFlLDDICay5OrhoVLAC+BfmmMxqnxRc0qE+7hNvo4WepQ7ltCHa5ZcOZGv05wo3Asn7cL9NgdqK7eLfCx0ndjcI/MSCcNvo3mfYUXJtFuwn9m+xSAMAYP9PGPf7RtirzOd+jfu3qbmtzZkRQQS1toMDwg1GQ5D4CcJjid6Rw6AufdT/mLkYhPf2XkIpyMMDeakdTJxdqWQtktHG7H80IB4j20twMHug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CMsIAo+oee/GyFA3hG+bQ7gq0+wIknbnYPMXrf+OSg=;
 b=Ly62bmQNOxv4lsw5Vn1t/kgCKv56dotoJ4crZZXv+R+8I9D6odvr+XiI8HAnNCzOngeZjP4JWu1Z7mUYepGFxX0MU1FIzTXB8/ecLq5XxDPRvcuP4/uNAbONE7XL8uCbxBAt5lSQ7E1nqy8kfLicIDRtoNBei/5580ZFcwUlcr3uus+IfGiYh+45CbITdSEGbLY2ePa5J9TvERtHqKrjXGbHq51eQnHOPr0NWCsF4wTQLmYbgvXxYdnXwC5ZZH/YcMfwcdjg1XsYFBabBBtUpSY2A481Zx2/IleEgRAqawF4F8aWjWYlnQrbYcO3pmsPxy8413UErXX6a8wVafZ7TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:49:29 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 17:49:29 +0000
Message-ID: <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
Date: Thu, 2 Oct 2025 10:49:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
To: Danilo Krummrich <dakr@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Surath Mitra <smitra@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251002020010.315944-1-jhubbard@nvidia.com>
 <20251002020010.315944-2-jhubbard@nvidia.com>
 <20251002121110.GE3195801@nvidia.com> <DD7TWUPD83M9.5IO0VX7PP1UK@kernel.org>
 <20251002123921.GG3195801@nvidia.com> <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org>
 <20251002135600.GB3266220@nvidia.com> <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org>
 <20251002152346.GA3298749@nvidia.com> <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org>
 <20251002170506.GA3299207@nvidia.com> <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::11) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: 81f9a786-56a7-4ba7-e58b-08de01dc0915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekNIWmN5bUdQMkYyN1pXbUpoUGRyM0k5WG5oSEsrRnNkMGxmdHZmYlg2aU5S?=
 =?utf-8?B?S3o2RGlZNmV2N3owS2d4dUs2bm5nMXdBcXJJR3IzM3FtRkdKRDg2ZDRod2s2?=
 =?utf-8?B?NFJWQ2RpbTY5ZCsvNVZlUHkrUVFwbkM2R1YrcHo1cjNmVElwWXZCeFBCQ2Ez?=
 =?utf-8?B?cGM5dWI2MjhRZkwwU29Oay9JSFVuSGFZMGYreTg5WHBiTVJsZEtPY1R1WEhQ?=
 =?utf-8?B?UTRpVXAyVDFtYVo1Y0NHMmJCeXltUDVxVmhrME82Q0w3UWZ2QTBuclhpZUZN?=
 =?utf-8?B?Y2REZUhFWUtqcFBGTGFKM084RTAxSmdrU3lkcHcwM0Y2eWZqZHJ5K240TTFq?=
 =?utf-8?B?ZmVwOHd4VWJ3NVMxK0lVdkVIMDdLNzB6c1hUZlhXTm5OaHRiMXRqNHUrTXVx?=
 =?utf-8?B?REM5aytFQjdVYjkzOFdJMGVyZ1pkOG5jUVEzL3hWK1NtMWZBVFdKN2dYWlp4?=
 =?utf-8?B?ZlE1M2hDTTFvQTFvdEpUZ0tsdC9uRjBMNjFKV2dTVFVEM3JQMFVaZW5teGxT?=
 =?utf-8?B?bGROODVrREVlVHdQNTJnb3RtaExtR0xHZFhYZG94RlRqUDBGcUkwelhPRTFV?=
 =?utf-8?B?QWxzZWlFcU5zcWxzTG9xV3IyamFTc0YyUzQ4NSs3RkdVc1hlU2JuSEp3MVIz?=
 =?utf-8?B?MHNQMkpOSHdnUlpxNUlLclFQVTlEbXJZU1E0QllnRjBuNk1aanNnTk1xTlJk?=
 =?utf-8?B?R0J1b3E1cFpVcDQrK0hudWZqenkveXdGNzJFaEIvazdGWVpRejVkWVJYMTZ3?=
 =?utf-8?B?cmF0dWhKRFNySW1QK1p2Ujl0RnhjSmZ6c3VoOG02N0xsKzJCSnVyZFRlK2hI?=
 =?utf-8?B?WVhLeCtpRVE5UjBFMWIyQkVnRTR4UzRjUnNWL3gzbUt1ZnljMjBHTDJtMUNo?=
 =?utf-8?B?OG9hb0NJVnU5M0pKZ3ZScHBiYXVlc0ErbzJqVVA0L3VqY0JvSXBXek9PRE53?=
 =?utf-8?B?SjNSRTFhZ0Z5bFU5TjNSRWoyMUdiR2RtMjYvaGI2MlFKbWRLcHpGRWRFYXc5?=
 =?utf-8?B?bVBNOHpjQUVQOVdJaVMva0luNlNDMWloMUlpRVdmdmZGaW9ZRGo3V2VDVVAr?=
 =?utf-8?B?a3A1ZkgrR3Q5dndwTlloUzMzbnQrcEIvckZkbC8zUDBzWUJGNHEwNGtLaTlk?=
 =?utf-8?B?ZEs0Qm9Ma0kyOGNXaXUzS1RqVEdWVmdGcjRPdHNsdFhheHQwYmc2dFNIZ3cw?=
 =?utf-8?B?SDVtMXRVclJxMzE3bmNDMklxc1dETHBEeVZnUzdaZTlKZFo2c3NveW56OXN0?=
 =?utf-8?B?NnJSNmpvekt4ekM2Ti9DM25UQlBEVExmOWFZQmdJbzZ5NlR5b3JoRDFLYU9i?=
 =?utf-8?B?cUpTSklsU2RpQTA5MlhOa0JZMkdpSm95Z29FOUM1NHAwaHB0NTRYL0c1SU5U?=
 =?utf-8?B?QjNIT1pjVGwybTgyNXBBYWovUHQ5aHA0NTl2L2FrRWIwa2dKdVd0dlF6Z0tB?=
 =?utf-8?B?bXF0NmFUamo2dW56cXIyUEVGcWdFaG9JdkdnVUp3M0FWelVldnZSd3VIWFNx?=
 =?utf-8?B?bksvTGgyZXBVWTI1VlRQUzZKNU9lNkFYOUYxdFFKOGluNG9FMktpanJ4eHJI?=
 =?utf-8?B?NkNOVEZHMTlQZDRiTGkxRkFnVkNHSU5sejZ3MzFSSVhWOGNYL3Y4SWNFdncy?=
 =?utf-8?B?RTBzS2Y5WVNkeEZyYnZ3L3Q5NzMyN1FyWjBQanlaOEQ0NHpsWUpOMnREdFZy?=
 =?utf-8?B?T0FzRTd0VVdQVWVPRWVNcGs1YmFWSjJuYVZLallqNXI1bTVmKzFhNEcrRU8y?=
 =?utf-8?B?K0xHWmNHZVdJTlgvcWlDa2t3cEZ3RjYwQ3RYRWlGNE8xWTNNMW95eEVxZ1RR?=
 =?utf-8?B?ZmJkSjFHTnNzSmkwMkMrU0hmK25VTTg0Z3oxb3Yvdjd0YlZLdnMzMzVydjh6?=
 =?utf-8?B?bTdibnZIb2V6VTJhaFNUNmRLbzVRTGU5bEhITzY0M0xRNWZPSTUxNzhIa2dV?=
 =?utf-8?Q?HenMcIlB0owCmZoq9DPNB7JBPlbnefgZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXZ1LzZHRnVmYUJCOFRnVDd2QjZ4ZE8xd0piQnlBK0ZnUDkvdG5FNmI0UElP?=
 =?utf-8?B?ZmNNRDBsb0FlVy9NbXZmNGh3aHFaMTF1UDJ4ZDhaOS9maHNnNGVjZEJIa3hF?=
 =?utf-8?B?b0phNXRqK1F2bVBFbUxnNllTTVBWN2lFMkVRWkpVeTJDcVVvN0hRUjRQTVpa?=
 =?utf-8?B?Zm1hTzdnVEZhcElJdnZOQVN2OUE0aDd2SnNrVjR0U1duWExtSVBZYU1JT0VY?=
 =?utf-8?B?MzBxMGllOC9YTDFhVUkyZVNKTU1xRkltQ2E5eWkxd2o2MEJSOHVKNGxGUVpq?=
 =?utf-8?B?NDEyRm13WEFZaHdabDJWdDQwd1Y4UHJVOWc5ZGlKb1VCODI1a2NQb2pnbkky?=
 =?utf-8?B?OFUzeFlPdWFXcE5SWmNmSU1pUkJrSjNVcE41SEJLYmYwRzRJcDVJak96VlEy?=
 =?utf-8?B?UTBEbndEdUphcDhsdVhQd1RCeDlBNkd5aVF5aGJJRUFWcHQreHFsYWpZYTRV?=
 =?utf-8?B?YkNHQmhpM1F3NlRCQjh6MWNEQWYxbkpyb3V5WExvV3FpSHFRdFphREFwWjQ2?=
 =?utf-8?B?MFM5bEN2U3JFWmhOREVOMDhHVGhjSjNJbStENlhoK2JBTm1kaERPLzZnNHow?=
 =?utf-8?B?MWZaOTI3dVdsY0llQXJmRGNiSzI1QS9oZnRCeVh5aXRpWnVWRjhZdlk1ZnNi?=
 =?utf-8?B?Q2pWTzBydVg3MXdqUXl3bk51TmFKaVZDTkJjUXlJaTFuek5vRDFrcXpoOEdP?=
 =?utf-8?B?dnJlaGk4ZTdKRHNwMnJkUlY4am1ZNFEwckJaREFkN3U4NXpudUJrNDNOYm9Q?=
 =?utf-8?B?Rk5nNTY5SlBZVDAxUjhnL1QwclRvL1UxY2ZwaGE2RE1hWFdCOEtmTHJDbzNk?=
 =?utf-8?B?T2ZBSU5td0ovOGN5eFFvOWdXTkh2eHNPc0VTQ0pBdkd1YjZIYzl2OGp1L2Va?=
 =?utf-8?B?cjRJWTZKY1NTK3h6ejFXNUV5UDJLdFNlME9vVzVueUZFSEM0MXR2UUhpYUFp?=
 =?utf-8?B?WDNreEE5dldRNVFZVFdoeWdqOW12c1lraWR5dzVyMWxFNlR4Rm9UVWVmMzlj?=
 =?utf-8?B?dkpEdkp6TVc1Zm8zbTlsSFhpY2hpeHBqVC9iMHREUjJqNEJsR3IyTkpITGJp?=
 =?utf-8?B?MC9jeVptSVBSblNWQyszd1I2ZFpKMnNYQUFBbktjeWI4THkyWTl2My8zdVdt?=
 =?utf-8?B?dkxXWkYycHRBb3VVYmRSbW85VzJpSkdlTzVieENyM2dGMjZjb1RKUHF0SVhP?=
 =?utf-8?B?bDBsNU9nNnYwOEdmMlhNZEZuR1hoWjRKbHd6cEdDT2JaTWgwVU1lbXpYSUFY?=
 =?utf-8?B?QnNycmNzOVJ1OUZmbzJNaDFCOVRRZTFSLzM1NlNVUVJaZXA2WUwzMm9aL0Np?=
 =?utf-8?B?Mk5GbTc1Ty9nWE9BNlEyd1VpbUlIRWNkSzVRYjJ2dlRjNXVuYnRvS081ZWsy?=
 =?utf-8?B?UzR5YmFKV0x5NEJCWFVTRWRtMU4vUXlyRFNtOVQ3aXhtd0lZUSsySmxhWFU5?=
 =?utf-8?B?LzBTQWVGMWROYUpFenhMa2ExRkRRb093VnlIdnJINjJsM1pHYjlTQ2s5K0Y3?=
 =?utf-8?B?ODF2TGxWcTVUM0VsUmdUVlBmMDVXRUNOWGN4RXpSNWRIV0Zmd2NzSk5Wa2M4?=
 =?utf-8?B?S25iQ1ltNy80UnRxdkhwSndpbzVtOUVKbGIySUU0VHpPRWFtOVV3NUR0K0Er?=
 =?utf-8?B?Mzh5LzdCR3JBYmVPRWd0NmtUcExhVzErMG8wMXROWjl2cWFVQjBjM2xCaXNE?=
 =?utf-8?B?OFEvS1ZkZm9WUWpZdUZoUVVTWkd1cUN6b3YwK0VhMmpZNTFkYUs1WHUzVG1p?=
 =?utf-8?B?L1NDSHdBMkhYTEY1Zmt4ekZqYnZYVWRIbnBtZUpsS3hnS1BtWkZjRjdqQXly?=
 =?utf-8?B?bG05WEtiM1ZzYTBlajNjWVZLRzBZWEJvYyt2ZmE2dUhuclpZc1A5UkJHYkNm?=
 =?utf-8?B?T3ozWkFDeXdTSGVjS1orWjBISFdRVWM5N0RnYjJkMXNUZm95ODREMmxyMng1?=
 =?utf-8?B?QWRrZ0RzQ2RNMlR3U3lOTHFqeitCWGdoVmRjaEl0akM5djZweHBGMUV6K3dW?=
 =?utf-8?B?QWJ1RlNtNzhraWRPZjhkbWloZENScTIvZDBxcFB2dVY2YzNteDJPNGJjWTBa?=
 =?utf-8?B?bjVEd0xjZ09pVkkwVjVwMnVQZGxhNTdSMGptU2dTOEYxUHJRYnJ6eGV2ZVUx?=
 =?utf-8?Q?nCw/ReBlEpMVvtJQGLeZIYD5A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f9a786-56a7-4ba7-e58b-08de01dc0915
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:49:29.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/Bw0/NlPja7OdaV9s0LmYqVIFvboyJalG3PoCMgIyTyGu2ZbKwU2ZNgQJhfuT8UhaE3SfWArbUBTvdXywadAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

On 10/2/25 10:40 AM, Danilo Krummrich wrote:
> On Thu Oct 2, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
>> On Thu Oct 2, 2025 at 7:05 PM CEST, Jason Gunthorpe wrote:
>>> On Thu, Oct 02, 2025 at 06:05:28PM +0200, Danilo Krummrich wrote:
>>>> On Thu Oct 2, 2025 at 5:23 PM CEST, Jason Gunthorpe wrote:
>>>>> This is not what I've been told, the VF driver has significant
>>>>> programming model differences in the NVIDIA model, and supports
>>>>> different commands.
>>>>
>>>> Ok, that means there are some more fundamental differences between the host PF
>>>> and the "VM PF" code that we have to deal with.
>>>
>>> That was my understanding.
>>>  
>>>> But that doesn't necessarily require that the VF parts of the host have to be in
>>>> nova-core as well, i.e. with the information we have we can differentiate
>>>> between PF, VF and PF in the VM (indicated by a device register).
>>>
>>> I'm not entirely sure what you mean by this..
>>>
>>> The driver to operate the function in "vGPU" mode as indicated by the
>>> register has to be in nova-core, since there is only one device ID.
>>
>> Yes, the PF driver on the host and the PF (from VM perspective) driver in the VM
>> have to be that same. But the VF driver on the host can still be a seaparate
>> one.
>>
>>>>> If you look at the VFIO driver RFC it basically does no mediation, it
>>>>> isn't intercepting MMIO - the guest sees the BARs directly. Most of
>>>>> the code is "profiling" from what I can tell. Some config space
>>>>> meddling.
>>>>
>>>> Sure, there is no mediation in that sense, but it needs quite some setup
>>>> regardless, no?
>>>>
>>>> I thought there is a significant amount of semantics that is different between
>>>> booting the PF and the VF on the host.
>>>
>>> I think it would be good to have Zhi clarify more of this, but from
>>> what I understand are at least three activites comingled all together:
>>>
>>>  1) Boot the PF in "vGPU" mode so it can enable SRIOV
>>

For this, we could pass a kernel module parameter to nova-core.

>> Ok, this might be where the confusion above comes from. When I talk about
>> nova-core in vGPU mode I mean nova-core running in the VM on the (from VM
>> perspective) PF.
>>
>> But you seem to mean nova-core running on the host PF with vGPU on top? That of
>> course has to be in nova-core.
>>
>>>  2) Enable SRIOV and profile VFs to allocate HW resources to them
>>
>> I think that's partially in nova-core and partially in vGPU; nova-core providing
>> the abstraction of the corresponding firmware / hardware interfaces and vGPU
>> controlling the semantics of the resource handling?
>>
>> This is what I thought vGPU has a secondary part for where it binds to nova-core
>> through the auxiliary bus, i.e. vGPU consisting out of two drivers actually; the
>> VFIO parts and a "per VF resource controller".
> 
> Forgot to add: But I think Zhi explained that this is not necessary and can be
> controlled by the VFIO driver, i.e. the PCI driver that binds to the VF itself.

Yes, this is the direction that I originally (3 whole days ago, haha) had in mind,
after talking with Zhi and a few others: nova-core handles PFs, and the VFIO driver
handles the VFs, and use the "is virtual" logic to sort them out.

Looking forward to Zhi's reaction to the other approach that you and Jason
have been debating. This is all very educational to me, as a VFIO newbie. :)

> 
>>>  3) VFIO variant driver to convert the VF into a "VM PF" with whatever
>>>     mediation and enhancement needed
>>
>> That should be vGPU only land.
> 

thanks,
-- 
John Hubbard


