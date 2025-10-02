Return-Path: <linux-pci+bounces-37457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E78DABB4D94
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A983C68E5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 18:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D8E23C4E3;
	Thu,  2 Oct 2025 18:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sWYktmRs"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151819D092;
	Thu,  2 Oct 2025 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428645; cv=fail; b=GnaT/rZEILchSkYM1sft+hdKE6Xupu98x0EN3L4M2YHpPvVZ92C8PrC9nfdbEjGzQgnRBW2N41jvwPAMA/whS3ENRn6CnexKoCGpeqQy9syrAm+/aLUS0GugvCaF8MS0PtEVIPw5oew0Org94r4JQndWzRtFt1iyx83Y99FPMn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428645; c=relaxed/simple;
	bh=GCd9LKPyH2HtJgDPE9xz1xdJNbdua1a3bTMnvccluWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PXHOoTBPe+DgjM0sdeu2Dfq0aPjWE/5IGf3JMo7HZGFJ/DTOhe3ShHXjjlEYop1uach1aHUfO2uxYl0xCVvfYneyNJ998gpuSBema5g0KjoTd49zh+HowAc4oQ4ULleLP0niFQBe8Ee+7E9kH5x0faRGH1max/mBi/TV18/pLsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sWYktmRs; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x17jI0kzjH2p59FKqX5eys2vN6fzJsxmPeilWkH6cpKHDRtJx519m05mXss9fSafoyu3MIyZ1X7tqhRJ3kwmezWkN9pgxWsrmuJegn3NlF0g2dA00Vwv+TuviTwPKDeRUyMe+21FYG+zg4OJDx1UlpUkycgFgK7b4xlIDNaWnZQa4cZ8Kdph1Yutqj6R9hwoR8wg7OShpv+uAtPeOi82kQNisqTJlUQeAEXzpq3exRqvN56kDafY7DNPApx/XiNWVBqVV6KF5+4Y2MPeRueEZIfpiNBKaV5g5U6fjTr9vRWa7ORjsk0v5BGsBGhTVmj4Imqt+rtN8cYQn+85e5VBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGEsqTB6kiEGjcQHaTmvkB46qqjiK4SnaPFSnSlhS/g=;
 b=N7r7SbUf6axb9GwLF1xKHJEBD2PR/ftmxYPNYIxIrPbj8ZSt+YQ7mE9R2uI/pGcQi5wk/AdT7GId2uHHsYnXI81l1+ZTvrDlIiibjEzY/d1otd15oP9z1gf9Lxaz0kBbpJOTcQ3UDH4rckrjMU2F5VSPWf31vhFEv+FIfqe1ZAQElW/4ErnWoqJUaUvt1oztabeWWxsCR8Ww+2/7Lzit8KZWLVhznuQlaz51XodsyBO+xJztXKChPhPicXucvSo7vnNLKh+7PaHua9IZ5E1dnESd6ZyhGsmQ13fdNgncUoItI6PIg2bzJfdUXx6oH2/+CW8E6YJRxgdVl5oDRfmPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGEsqTB6kiEGjcQHaTmvkB46qqjiK4SnaPFSnSlhS/g=;
 b=sWYktmRsdtE8Dd5UbUBO3f8GSega4f6U7Vk+sxX8P9qN4wOevju9/Wv/0M+6xwdGUxjQ+gTRWoUAQudB2DkQPQheJIxC4nPguR8Kaj8iM1kf3/z6gLh23fDL/9fjr9wy5zNkGFdFQwQSSCsjFZyxIRyez3QVRgXVB0/jcbU/ODNBwA7LQCG+QhfuzWF6tneIVFXxjOD38Vkhh2xSWJGiWM5FEdYJqQO+2qg2pwJd9A9lT9lzkMEjm5tP7F/lYorAZulQ/7RY95P5ksbdspet2ZH0QPBpYf1UyrOQ5lQnsjsVQj7xsSyFmdHbycQ0aJP426owaWgapYOnLTM2cKXSFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 18:10:38 +0000
Received: from BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4]) by BY5PR12MB4116.namprd12.prod.outlook.com
 ([fe80::81b6:1af8:921b:3fb4%4]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 18:10:38 +0000
Message-ID: <41a58726-ad31-4514-aa76-d0afd9b58268@nvidia.com>
Date: Thu, 2 Oct 2025 11:09:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rust: pci: skip probing VFs if driver doesn't
 support VFs
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
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
References: <20251002123921.GG3195801@nvidia.com>
 <DD7UVCEVB21H.SQ00WZLLPINP@kernel.org> <20251002135600.GB3266220@nvidia.com>
 <DD7XKV6T2PS7.35C66VPOP6B3C@kernel.org> <20251002152346.GA3298749@nvidia.com>
 <DD7YQK3PQIA1.15L4J6TTR9JFZ@kernel.org> <20251002170506.GA3299207@nvidia.com>
 <DD80P7SKMLI2.1FNMP21LJZFCI@kernel.org>
 <DD80R10HBCHR.1BZNEAAQI36LE@kernel.org>
 <af4b7ce4-eb13-4f8d-a208-3a527476d470@nvidia.com>
 <20251002180525.GC3299207@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20251002180525.GC3299207@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To BY5PR12MB4116.namprd12.prod.outlook.com
 (2603:10b6:a03:210::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cc20392-9b5c-4999-dc5c-08de01defd71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NFlaZEdNZ2t6UU80YmJLeUZoTEcxbUNJV0wyUFFrRXY2N0lFZTcxMnhtQW9M?=
 =?utf-8?B?NWJXL0NIWm9KejlzRDE4a2NyQXAwbkYzYlBjNURxM2VSM1JWdXRBSXZMWUV3?=
 =?utf-8?B?WWFRdHBhU3N2UTRTc1NEODZkaUx1RnQ2c05jTUFmb2pxL0pPbk9xeGtkMGpl?=
 =?utf-8?B?NW5ZR2w4OW0yM1UvMnNjMi9vSFRYSkI0U3IveXlVcGFHek1Gb0tOTEs4T3px?=
 =?utf-8?B?SWxMVzgwRXg0ck8rT0RTak8vKzAxYUdOWXRHQmFPUUhCZWNvMWkyT2Jpa1pJ?=
 =?utf-8?B?ZXhpOXp0MW1meU9iNFh2MzRYQ0gyV1RUcjlCbUQ1eVRwS1pic3luZ0tSTmpz?=
 =?utf-8?B?MlFEMUFsVzNOSGpValBxZmlaNDRzRlV4VklPNGlaNkh6Wlh5SGxNRnQ0REw1?=
 =?utf-8?B?TE9qYVQxUWRIZ1FyaHE0TE9KNU02TWxUOE9YYzZlQ2Zkdkd3U1pnM2NnbjVU?=
 =?utf-8?B?T3NhRjdST3U0emNLMm9QL2oxQ2dLdDk4QTlxSDB1WEJuYmpoL29hSHQ1RFdZ?=
 =?utf-8?B?NHlIb1lFZ01YQUdGK2RRQzhuSkhMb05BTnFydnIwajN0dW9tdXAzeDZqRGE2?=
 =?utf-8?B?cDlNU253YytrYmZjWEdxclNEWElXZE9pMUQ4ckxyTFdGd3J2OFR6RzVTODln?=
 =?utf-8?B?bUMyNStDcmtmQkJnb05YMGk4c3d0VW1kZWNWMjhEWjdManhTZ1pKRTZhZlp3?=
 =?utf-8?B?MVhlajV3QjBGai9XbHhDcXozTVR2bnNZY3g2VUVJRGRmSmNuVklVVkw5Q0hY?=
 =?utf-8?B?d2IwZmZhcmNzZHE4NGdxdVMxM3dwWTFxZUtkMXpQd0tQdDlrVnd3LzdPVDI3?=
 =?utf-8?B?SmZCK2NkS3dwOWZvSVBBWjBZQ1JCbWQ5aytZZlY2Ynh5dmRQb2pBcmRvRTRw?=
 =?utf-8?B?Tmh4U3hnZXVHZmthN0dxbS83Y0YxOXphVVQvYU1GaC93R2s4dzUyKzJLUUZB?=
 =?utf-8?B?Ump0NDY2SkdHak1KSFhNam5GM01YcEtYM01BdlVIVy9KQ1grRk5TczBVYWdO?=
 =?utf-8?B?NnBOaE1Fdkc5eERDYXhXYmFGSGJiMHRmL0QzUTJNSUdDTUIxMGdRYXZ0bHpO?=
 =?utf-8?B?b3dERnplbFg2YnNPWmNFelc1WXV4UmJxMkdXaGJxaUNvbGhlaTEvcTU1MFRq?=
 =?utf-8?B?RVNYZFBlYVZBVUdvaUVoOHBXdVdreXk0ZUl6RWo0V3YyY3poalJiUGNqd1dX?=
 =?utf-8?B?L2tXaVJBcGd6aWhWSE9wUnFGeGJaRTh1cU5EV09zeEdUa3V6U2JQd2dxTVcv?=
 =?utf-8?B?R1I4REdNMW5tWGRIVzc0N0ZYZEh4ZGZTY2tORGlITWhIUjgveXkzdHgvc0F1?=
 =?utf-8?B?Nm9jYU9IbG9Pd0FJRUduNzFJQ09qU1ZPVHFxSFFvUzRqK0dPYVBydjJ1RkZz?=
 =?utf-8?B?R0xQMWJHdGl3N1gwTHhCMFo0RlFmZTh3amZnYVBWS3hZaUVSQnNxR29HMVBI?=
 =?utf-8?B?UHFwdENpTzlhREtBNGF2WGUyTGJDM0FRNWJRWlQ2N0RpUXBJYmVvM2l5eWUy?=
 =?utf-8?B?UU9kMGNBMmE3dkRWOEhzTm1nR2dabHp0MFNmSnFOejNBMnRZSHBSRlcyMXo1?=
 =?utf-8?B?aTdCY2NLWFpEYXNVTEVpOENEUTVPYVp4QjQvQ2VRTU1GR3daVE44dlAwaFVy?=
 =?utf-8?B?dHE5V3Q0RkMxd093eHgrSG5oRG1yTWVBcUdNT2M0VGNaVDVSMnY5Vm1vTnpE?=
 =?utf-8?B?SDRmWVYwSnByc0JUTXlYZEp2NHhKRVFBbDk1d1dXL3Ryd1hsdWhSeFU3L0JY?=
 =?utf-8?B?cHovOUd2a1huTFdFU2wrTnNTUVdnelRvbCs3QTJqbGlZUWhtSk9sdUxWVi9G?=
 =?utf-8?B?QkJBS0FFNWhvWkpPVWUzekZiaUlaZUxzcEJIRU5Od096WHgxbkZwYTlWaTAr?=
 =?utf-8?B?ZVd2MFdkQXU3dEtDQjl0RmUvQXFkbFhPZ3BuaGdnNnVoMmE3YlNCeDlseFBk?=
 =?utf-8?Q?Qz5EThi2Jz2BCZUJche8b5Uh0GLZohW7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4116.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW1ZMnI4M0t2eXFwMG9XVlJ5RFJRdkxhMGlMVkJNcGlxaXZqMHZ6WE5tYi91?=
 =?utf-8?B?UUpCcG44OXdyMVVrRm10OXpRN3k4K1JvSzZYUFAzTFJnRTNMbVJVRC9mQ3dy?=
 =?utf-8?B?RGoxSzJvV2I1b1ROK0puTGNLWnFnc2t6K1RpVmlnZ243Mzhjdk92QkdzUHVr?=
 =?utf-8?B?ZWdaQUFmZTFRbGxsc1RUbmY2Z3dDVHlEUEtEUGloSlFwMXNPQVFuZUhEVzQy?=
 =?utf-8?B?TERLUi9PdWxTZ3JoTzhlWEN6NlJTNk4yMTRkOU8wcit5TTVUYVZiVDJ5WU9X?=
 =?utf-8?B?clhaN0RZQTk3bm9PWk5OMFJtcU5QWWRXck01dU1ZTllHNGlUU2E4VzBTUm9r?=
 =?utf-8?B?U0JLVGJCclh1VGtGcmYxYzFoZHVNNi9vOFpBQ1ExM1R3a1hZL0V4dXBBZjl0?=
 =?utf-8?B?OCtBdG0zbmE0cjU3K3hUVk1zT2N0ZFhpQmdidE9Vakw4R0ZRYXlzM0QwelFu?=
 =?utf-8?B?K1kxUHZRWHdVM2R6YTUxZU4rN2lHYkczaGZWQnF6a3VVRXc0ME9kSkNabjNp?=
 =?utf-8?B?d0x0RXJSNUJ3N1dyd1MrV2lLLzhzTjMxWGVtbkNBMVE4TVhJZk1pM0JzS09D?=
 =?utf-8?B?VW00QlI0Tm1sSnNTMmpwdy9JTHkvQUlQOGR0cDVycUY2WCtJZ1R5eGQyVTlj?=
 =?utf-8?B?d1dIYzl0YVkxUlMxREk3WGdvSDBjK3N5bHNHc3NsQ0xMVWJBWGRRSU0zbzBx?=
 =?utf-8?B?WUt6dk50dHFibUFIbTlZY1dmN0V3MG1wcGthTXJXYWdySGVVY1EzUzlzUG1U?=
 =?utf-8?B?MVlYOGozR21pZldrV3A2ZU83TWJ0RnU5WmhNOFo1V3ErWUZhOE5VV0s3T21I?=
 =?utf-8?B?V0lzMjF3ckFtS3hNTExDUkxGZEZIbXU4bkVWRXNhei8vNU81ZzFBMXg5czFV?=
 =?utf-8?B?M3drRFFSZ1hoSEc4Z2VLSWwzR1NGQXdkWURveVAyQThSVE9ZZFNWdGZ2Wk9H?=
 =?utf-8?B?V1NmRTdaQWRQalJBMmJCM05INWRlM21VZ3ZGWk56ckREU3ZYVW1kVE9COHpp?=
 =?utf-8?B?UTdiaFRXMWhOUUxDMVFmLzJ0VkxSdFRWL1A5WE95WUhzKzF4ZWU0SDQ0bENx?=
 =?utf-8?B?RVVhd2I5Rzl5MTVDZlNWY3ZPb1dndkxDYmZNeStyVFBvOGhyOVpGaUtMSmsw?=
 =?utf-8?B?bDBVZkI3YkRJZUVZanc2SnRkMEdiU29PTVRpZXJlSi9WakppdDBKbkdmT0Ez?=
 =?utf-8?B?L05JcnZiVDRPQWtTYjZFQVZqekw2elVsZUhITXRqa1FDNlhUTnVlNDY2NWNv?=
 =?utf-8?B?cXVkQVdrc1IyQlRLYUJrdm81Z0dKK3p0M0hEQWlReTBVUGJ3UVlORzVkOWtj?=
 =?utf-8?B?ckF5N1BxVFlydjdaMkF0cHVGL0VEK1RKeXpzS3ZZbkhIZ3ZtSlZ0Skg5KzFq?=
 =?utf-8?B?SjY1V2RZV2ZwVzhzdFJWS1VsTmdaWllmNExHaEpEaithSkFoUDdLYlBEemcy?=
 =?utf-8?B?NGo2Q1dRT2xpVnhpQjJjNkpKZDJsMEZlVmdycWNlYnV4R1o2Tjd3M0hybzY5?=
 =?utf-8?B?RVF6SlVSUS84UDY4Nk1TWUEvbjNDUElOWUV2SjdVdkpiS01WOElabWk0b0tz?=
 =?utf-8?B?bFg3VHVDdHJKYmZ6STd5am1DeDg3Sm5DaC9icmJsUHduZVFzQTl5R1Z4VXZF?=
 =?utf-8?B?MWZJTnhKQXFDTHJHc01oU1I2YSs1Uk5YQ2gxK3hWQTI1WkxCMW9KdnlCZjI5?=
 =?utf-8?B?SlJBTHVLa0t4TDRtMVJUZXV1Q3FPM2dicnJydTc4a0s4Yk85blVaQWpGOVEx?=
 =?utf-8?B?elhZMEd1c3NGM0FCVERIYXIyWUdZbm9mNmo0WGk5TFNrdzl4VTlKNWRJOTRo?=
 =?utf-8?B?akJHek50Ti95dFN0NnNOZlJlUmRCQzNSeTFDRVFuRjEzangxQ3FTbEtzYzFI?=
 =?utf-8?B?Y0tPcCtuT28ySm9pd3N0anhZY1RLT3RDMWYwdkpVMXBJMDRsUmx6eUU5TGl5?=
 =?utf-8?B?aHZHRDBlN1FucDBzejFNZG5WaEx1OUF4aGltMms0RHA0UFdtdDkxQmhYRkJq?=
 =?utf-8?B?V0dwbXRHZnppL1VhdDhwdGV4NzNkTFBZRlBLak53Q1IwTkxibUxKaUFQSlZz?=
 =?utf-8?B?ZnBmTjRjOW9qaWFWWTlqaEtDQUdjbDMrWUJPZm1EVjNXUVhjWk5pYk5HbVFL?=
 =?utf-8?Q?iMcGwqvNpGQDRnGyI/7rau0Js?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc20392-9b5c-4999-dc5c-08de01defd71
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4116.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:10:38.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RtRFFMwGcJ1b/a9V5Sxj3ykpvOJpEgNVZEMPsQnbHCu8LfBBYcKzPCVws9GwrcZXmKC1n/T3uZZlcaIfyvvxgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

On 10/2/25 11:05 AM, Jason Gunthorpe wrote:
> On Thu, Oct 02, 2025 at 10:49:21AM -0700, John Hubbard wrote:
>>> Forgot to add: But I think Zhi explained that this is not necessary and can be
>>> controlled by the VFIO driver, i.e. the PCI driver that binds to the VF itself.
>>
>> Yes, this is the direction that I originally (3 whole days ago, haha) had in mind,
>> after talking with Zhi and a few others: nova-core handles PFs, and the VFIO driver
>> handles the VFs, and use the "is virtual" logic to sort them out.
> 
> To be clear, no matter what the VFIO driver bound to the VF should not
> become entangled with any aux devices.

I was fine until you said "aux devices". :) What does that mean in this
context?

> 
> The VFIO VF driver uses pci_iov_get_pf_drvdata() to reach into the PF
> to request the PF's help. Eg for live migration or things of that
> nature.
> 
> My point here is that generally we don't put profiling code in the
> VFIO driver and then use pci_iov_get_pf_drvdata() to access the PF do
> actually do the profiling.
> 
> The VF cannot/should not control profiling of itself - that would be a
> security problem once it is assigned to a VM.
> 
> So the profiling resides entirely inside the PF world and should
> operate without VFIO. As I've said this design is compatible with VFs
> for containers and so on. So it is the strongly preferred design
> pattern.
> 

OK, that all makes sense.

thanks,
-- 
John Hubbard


