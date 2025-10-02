Return-Path: <linux-pci+bounces-37472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F0BB569C
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 23:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EC374E604D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 21:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B86F228CA9;
	Thu,  2 Oct 2025 21:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ky5Yh8XF"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99321B0F1E;
	Thu,  2 Oct 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439084; cv=fail; b=sjfh4VV+ug8+k46Nl9BCwbsGq2ZEgQj8hnHlNz0F04s/UrnZaEEzCaQu0rfl8w0twiyCkM89fr20YkyS8e1PDldkvPFYFojfyFUyhjFHa+zlX1xUaXWeveUefr5kwsNwKSN2G4cKe98DPEtZcD1aWrg8ewbXeCsgVv5ErkyKHIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439084; c=relaxed/simple;
	bh=AtbqtwcQu6rWwIEhF7871qx/CDMJubFTOIse7nOPKaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZKHmPB97sXJkRv6VMY29rz8bUkLSkiGdu6JpPScZyaGApzVjhbT7cwzm1IYdFJIwGxWGbsu0X2LMn/eBUrAQtc030Lyq809jc1S/hQ/a9Q7r0IQfWJd5v5QSbSJNVOOCaBXQPn60Jf/0JF1TYRGqnztBFogcvqb+FXgsF4sbh1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ky5Yh8XF; arc=fail smtp.client-ip=52.101.46.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqJklNHZatYesbmjGxD5uf/SLZdxu2YEt/OGw2EHj7CfrQrWQVDa3cA8NVr+uDAR8PWwKbl5v4DeUpZYHYum7aBzJgQ15QOoi32gc3UPdG0L0Gv/ino3Swif/2JWEh8SF/G+6BPuRPirkWKcKh/a7Gh2fqyIVr1rUM0EqAG0uxAAnz6X2g0YeOluIg1nyEMGazXHfZEhHH40FNbOPW5+ir2iVT4CPOCId+MT6fcY1wu9Gb16n7xUlUYO/ceaaCkTM42HyGulgfEQrcvrG+U2gJWkxW6ry+BCjSSbnOH6V+jIzmMcq9IJ3uahIT+IlcXH0VSPKPbI6cO35oT+HXn6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi/IJ1uzSmdox7tazuY3IXOZ5rzCUaXM5DmFC5YYxE0=;
 b=vw0SPyMt/tRbL6t5iegr6NjL3oKKaeoqTW9WjQYXc9nWb2Iu6I3A3Bhrd5UZujbfmgjhhBdDZZD9I+Tgl1Zsh/KG2oLhVeamCiOavuXDAIBMRWVTPosnn9iZy1NGzPiq403ASiVOEkuf2+SyZiu1hpSstBKWagZnJDVPyfIrSvZvTuI/ZFL3YI779266lz+kB+SWu9H9sMMZ1Fkd0Fw8Nd1fE4nn6yVacfovN9QrP+NHUwjlYOfbOAeXSJ8CaY1nNwxzWVWcshLjwNwYnWBRnoWY24eV7KmdvgdIgxvh1lQNmX/T8vZ1d0L9ElY5CVVJrBp4XYKT82izeuuXM3jTIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi/IJ1uzSmdox7tazuY3IXOZ5rzCUaXM5DmFC5YYxE0=;
 b=Ky5Yh8XF9wZcrxUgJ2HFlnpVdXyVtZw7MFyaUEJ9h3FzlHLkgi72nF+lz5jil4oJcGpd+hiPCG75xEAM736hJN5G6KQdbx21urBYnAfTNKdaibjD/AFwxoUWTi3vfUFrH4/OBSFj+StWo7v7xeeRxVt8gi+5LN/pitP8TagxxG7Gge/E5DrCoqA7VxKUTgzsGkvXaZWejOf+UnOghU9/QH57wlZTrU61Co1aD/IM69sKRCTTho9q2DbcLlvDD7RHHqFNFCpCoT2RLdTnWx8SqoIQSBIJDpdxxupYCjZgBj0Ldu0arUJD86RQQT36VDlZgacObskXzEM1zpVKLgmkew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.19; Thu, 2 Oct 2025 21:04:34 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9160.015; Thu, 2 Oct 2025
 21:04:34 +0000
Date: Thu, 2 Oct 2025 18:04:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>,
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
Message-ID: <20251002210433.GH3299207@nvidia.com>
References: <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
 <3ab338fb-3336-4294-bd21-abd26bc18392@kernel.org>
 <20251002183114.GD3299207@nvidia.com>
 <56daf2fe-5554-4d52-94b3-feec4834c5be@kernel.org>
 <20251002185616.GG3299207@nvidia.com>
 <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD837Z9VQY0H.1NGRRI2ZRLG4F@kernel.org>
X-ClientProxiedBy: BL1PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::34) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cf2ae2-fc79-4ef8-4754-08de01f749fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2FBOgUdkOUgO/uLKMxpGXz/uzbypo5txB9/7LfACGr2CXDoEMdQpHQXn/ec?=
 =?us-ascii?Q?Z4qXlEjyc/CQHA5lrnfXX7XZQCgq8055Qz0PAnH66AhQJLFajKMs6yr3LNRG?=
 =?us-ascii?Q?eUBV2ItQbMD3CKfeVEyU8LyjHJV0lJgg6KXY64ChkRGrxwYwcU/bYFBPUIyL?=
 =?us-ascii?Q?bphgpTJaPIwgQ+u3bbHFQSgv1tyouu+tZRo5A+uRbu8DV/x2Rq7+DsXg+Em/?=
 =?us-ascii?Q?6VGitcjdMizI8IaE9e8hLiB/k3qf9c0pCwqk8R7ZQevz/Hk7UX0NwuLnJ3mY?=
 =?us-ascii?Q?sBkZzS9FuNjD4CyQ5pz1SjCzuyt7QG3D7JPi+r9js1Z7toziRqATlJZdDmIl?=
 =?us-ascii?Q?c7khrem9foYm/AhhIz4mleCbhvK1omDrwoJH9w/fi7yM8oDMoHvGgPPFC9Nq?=
 =?us-ascii?Q?PzcNsa1v0aLdA1EIZYu3hVES2WvnHTHET0B7KDCiLhdFScf0s++GWt/5DNmO?=
 =?us-ascii?Q?nCcyAqjUOw0E+0fQP9WG2xPOtd9Y2yEHBU36beSdxOah1wX0WSg3SAGImBEH?=
 =?us-ascii?Q?R3FwY7LDG1w3CD79GpuAiOreu2K1KU8Z/JSA5P6jZtuPL5IEn8PkKpXcCojA?=
 =?us-ascii?Q?e1boE9BKtX1D+PdyIvdl8QlJu8l3CbhI+4+vlqfh9BrNZSRnk+FbeRG7TpLE?=
 =?us-ascii?Q?RAkh3r7O4qaw9sVV2lRv3hgNnvSfXUHDIiI3RXKa2yXIFnGraJYPeurtFvhr?=
 =?us-ascii?Q?mnI48GS4XqJVQuz3rBfjdPAjRaJxGG722Cnsg0ceVjG1r5Fbs6kXGrsafQ1y?=
 =?us-ascii?Q?J0qUwZbJxr0mJvOrjH1Qad8i7P/wMFPreAZ8g6Wiuj8OP9YYxd2Pm4KGz6cz?=
 =?us-ascii?Q?FRvjwA4THBEpo4dMiInyL5X7JHbAnnTa9ew3aCaRns60QW02lYYNmSMGWLqX?=
 =?us-ascii?Q?xoCItYrtCkAmb0lhoZSYFprZzE6i/UVDCil/iV/g33Cf7ORYEFoo2PeJ/uj/?=
 =?us-ascii?Q?WrNs5kHTqRT0NP/7yGPgPonxEiA4bxTU8ELilTxIQE8yuZEI7tnWSfACTksf?=
 =?us-ascii?Q?Gzubo/yFXVuoNTwNLBWNkuA2MR4ngbf6DlwCZEyB9WThODCb2eTSUi14zmb8?=
 =?us-ascii?Q?hKquYwyEpnM/HV+MyNp+m/hUINm69Pm4O4Ya9hcMhYxKoKkT+v/shCEfBpis?=
 =?us-ascii?Q?yvkiFIjx7/yJdvjWjENwLgf91/nxQBCDdVBMmHeyca6hKeWsCjFTN41wdIUg?=
 =?us-ascii?Q?C2VeTv0EUl6dh5m4Vf/HYi4D3Kp6P/O+grLgzx0i8DxSgmVFbA8uIcAIXh0Q?=
 =?us-ascii?Q?88Curu4fnExgUC1cTZPokblOGSyzDJ16iuQQzQJSYhqJoCWGht0THElBiRuD?=
 =?us-ascii?Q?pKEBTLP1T2CqMOKztyEQDShMTkABgeDHZimYS902e02hXTIGuFqWXLV+bgTj?=
 =?us-ascii?Q?EbewB6jttYajqDxpPdmu6TsnQNwOMnCUqa+6VZM+Fi2mhxLNdioWhV3NwkmD?=
 =?us-ascii?Q?wyVlJhaK1bsaAVwtYben96h0xmEHVNvz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EL2fUWvWE2oE6z3bEsG9dSTyzjBYg8HIhoXP5ef86+0IXeqn3AI8cJMYNftg?=
 =?us-ascii?Q?UCTZ4v/K1rjuqW8ZxCh+ud9LumyieujUTqRWbhLc4gBVaW+a9QGPr1V7SYIG?=
 =?us-ascii?Q?z50rGK5V1gik7QruwqslV8UbzcvfQ2eqCYmomVNjAm9buidQ20+nm8+sUm5d?=
 =?us-ascii?Q?+yK6olL0fh/hdE33AiXpGmljEM/Scjse7PYJX2X1q+LPidU1OEMgvoMaCs3e?=
 =?us-ascii?Q?Ze+GO2vzzBu6OUB+te35ms4JWqYL7LJ2UVsQ4Mo8OOd6WswSVH56y9QRnEDu?=
 =?us-ascii?Q?IiREskrVbBtYkHmCkemEQGixygDn3o4UA+PupAC0GFPNUwRsvEvMBrNlWKce?=
 =?us-ascii?Q?dW6IDXlqg0rda2ERdHO1axY/bUQymcrn9LITWB+HzpKl1AX6VO092RADZyzC?=
 =?us-ascii?Q?7xLBH4UgNAbxuDCKnN41uEUBM9biaEfKSUUcAIKCY96i7+MX300gksVQuQn9?=
 =?us-ascii?Q?1syZaK0mz4Y5leZDuD1SLek7ZaHzh6y+zw1yz3aLGJqDEm/obpHbM0xisamT?=
 =?us-ascii?Q?poLp7lRRfTeGeD6WMhpi5uz6ayiG9udMx7NVqQWddaorwbf4/BQV5KbVTzrM?=
 =?us-ascii?Q?wdvBKMC5QixjiHe21FdTusBz6oChMH+lT2vCBwIEHmYoemDIKrVUvzLCx1LH?=
 =?us-ascii?Q?BzbrlUyppmvRgdXNoroNuV4UEUzyYhubrYYM0BTATwCESC5JxhvwWqZ4mPDu?=
 =?us-ascii?Q?bkZDuDAA5GwMkEF6YXCI7nk4WPCzTDenuEuWAcT3mxlUVeQeXG7Y7imgMASM?=
 =?us-ascii?Q?HH4dyU0qEhoodaL09Yp9Wz/6F67Gw6svy1VMWRgaFQxvDZb4HR7Zs7g4lml+?=
 =?us-ascii?Q?d6sxnyoru7/zE5Fu6Txi429JpyzqbgZ4KUhDUcB7xnZvW4hzGD4tAacQZUWB?=
 =?us-ascii?Q?ENdPFv7qkFht72CU5TY0XCemBAsLGalRsFOtQFh3gUhRfCSbHqp9D/T613kI?=
 =?us-ascii?Q?9w5JGDNjl8ymxn3QkN5gTi+gHjfRcj8GfDhEAe2gTY3aip33qnEBNtHQdoAz?=
 =?us-ascii?Q?5KEVyAlntqpLJ9iWaH96BJNTRzL5HvtUd4A94lGZFXjdP2tz8pMy0oPXR9fQ?=
 =?us-ascii?Q?byeZGPksHCy+Q5NzXgvs8E5usYt3vzXqcFfikUtOKVeSK7tZU3cW5weVO5w6?=
 =?us-ascii?Q?+kpOokcfjAIGqrVRj3K4G2oUMTj48MrIvswATz7dFEneGXyIaj0Vgef6c1mc?=
 =?us-ascii?Q?kIC8P5ncwjvuDbkZbs6tkA3Bbq8E5Rcah/Z9xoZDXCTX4vPfnxgZZYQU0XGW?=
 =?us-ascii?Q?WcP5pdzmwwKlpGq0N5D4JRisdxOkwQ3W9jl3AIdxnWtNFylLz81afDJgyWXx?=
 =?us-ascii?Q?4QpKmHPqDKIoYM30t0WcmvUs+15D6zPXPs4cQwdXTb/4WvDM+rhR5NM6wsgq?=
 =?us-ascii?Q?ii30F0FwZhfBPVkiWEkv5cKgO/us5j7/W7k3Pe6WM0eoz4bvItLhTUnFni3R?=
 =?us-ascii?Q?7u3Z2KIBU9L1uCycxdgmRYZJHSfZhGneq6b74lTwJ0VZRfVCZN9UDAYDi8Am?=
 =?us-ascii?Q?B51owOrtgyLYDa2lYTcSNqusutv5xE7AwqG4PvqhxD72835/9TPoD1rf8gOW?=
 =?us-ascii?Q?UCN5PWq6/2oKfzmC4tM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cf2ae2-fc79-4ef8-4754-08de01f749fa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 21:04:34.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmnPOSOTz0MPiaoarGgLx6s/mwP13yE+a2tWAuQBxVUmGmG3+MMz8i8mgHPYgjim
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293

On Thu, Oct 02, 2025 at 09:36:17PM +0200, Danilo Krummrich wrote:
> If we want to obtain the driver's private data from a device outside the scope
> of bus callbacks, we always need to ensure that the device is guaranteed to be
> bound and we also need to prove the type of the private data, since a device
> structure can't be generic over its bound driver.

pci_iov_get_pf_drvdata() does both of these things - this is what it
is for. Please don't open code it :(

> > Certain conditions may be workable, some drivers seem to have
> > preferences not to call disable, though I think that is wrong :\
> 
> I fully agree! I was told that this is because apparently some PF drivers are
> only loaded to enable SR-IOV and then removed to shrink the potential attack
> surface. Personally, I think that's slightly paranoid, if the driver would not
> do anything else than enable / disable SR-IOV, but I think we can work around
> this use-case if people really want it.

I've heard worse reasons than that. If that is the interest I'd
suggest they should just use VFIO and leave a userspace stub
process..

Jason

