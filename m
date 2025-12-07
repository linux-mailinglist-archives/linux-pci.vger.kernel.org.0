Return-Path: <linux-pci+bounces-42732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9EACAB081
	for <lists+linux-pci@lfdr.de>; Sun, 07 Dec 2025 03:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BCDC3069023
	for <lists+linux-pci@lfdr.de>; Sun,  7 Dec 2025 02:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F119F121;
	Sun,  7 Dec 2025 02:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wrh+iGgt"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F7C42050;
	Sun,  7 Dec 2025 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765074780; cv=fail; b=R+yY/QtQHDutfnh38qUdF6KS7W9udcRtID5O7kEONhGha0DHzB0sCg0qnh8NzpuzeSGZikGdAU+wxr2VA0/XWlv+M3rypaPbRtfjWJ8Ccbf+qO0lDtfWSqJeEQBcVelkX2YKce0Mq0wjyfMiMjYwx9tds7xTe23SzGufZPLKiKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765074780; c=relaxed/simple;
	bh=xUwZTWmtqcIwiRyC0h47igac5LEsSty1gto9U0pTt8I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDOqoqDef9lRQOOfhhpf2hMezctuDPE9ZgT9o1z/Av/oHymKaZbVX9AkphYqJjh5Rn6hHO8NvGOLjd3y+zKTEqlChveTilKCDQH2vXN5iooWkLcN6T81Cb47Wsforb49urlt2uOcf4CxQmBeIe2875MAOsNTSo53N/qR9nCY88M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wrh+iGgt; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzeG7dXkw0+ZdAdIpN7r20SS0y2JjIJfcPPF2UkZUl0wX6xmwBtXg/nDrU7l9QodFEPstciKqhTufF+MM4RBuWFGoVR0fL9GHWMWNTIx1gTNb7zkTQR4RGcyNPh4DzJR3j9wAOOJOXIVcjzBa0RMCQZwlgj7q7Sqsq92k3oiWeMb/Y7kB6gPaddQ82IdzaQoL7qZQmZiEA8qmPitPd9K966RiDHJKgtTQYOpam2jj8eqoRbhMHjOeOjzVYX4F3/ub6O5uNpKgQ3rFelZx3MFU1QPVFeDsjbA0A69E70vj+OhfBIGPtxxVUxZrOva1qTTrdlMkLtkV73pGZHi9z43hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcsn1Sl5Fhgzq2WwrCF7p0kfID42GnakmrKQHb9B9vM=;
 b=afTFnLqmZu+6WpK6V8oELlolTBe/BneUL97vD0W3zL8f6kkbmp0H44yGD8xkP35dNWSicgx8TQloaXMOO0b0iPsCo4ZVjj2BcHRiDyItBRMl8BcJu8wMSlw4NsQOayLBV2jIUJ0PTysh3cbr8+9sxPonWbY5xkuJWXdP7tbbdUdGfaTdHNVIsCRO+0pdLZSJuLci6KWRTYa3j1yOvTquiEFCd+g9tcS0HTYJLgY1siK9h2W8iBVFkioHwErPQ3AR4ATWEvr1ZgrKPxLUoF/AosS14OucFmHcSF1DWlhM2i06mWNbdo4Nm8ANrpTMHdApb3wFJTr3BD9bJH36uM0dgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcsn1Sl5Fhgzq2WwrCF7p0kfID42GnakmrKQHb9B9vM=;
 b=Wrh+iGgtiZj49DD4CxV7Lrd1QlM/8PeAGtHqyXc29lmOgE+6/6acIBnMem+YBtSyzE3CouF3iVAw7ybDdTjiDYQmwegUltVaBcoswvvPPS5OeBWR97isn5eeaNkabMweyVo12iiwccMENAqOd9AQF8nYg0E1iJMVwqCeoca24oc0o4hh4RMvg2CqiHHqZMg7F8hTW6JZU2hIYHE0qAGe4ZPR+Qg9nO/mqZ6Hf2KcLsHwDW14LSQDZws+vQrqWToraAiYyo6dtHH1IG5uLIFmwvSh8wEK23+AhmtKCNTWrgTKlcxPvQ8+n/4E8utRq7uiCocKNx5NjialvxFMJZl6wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Sun, 7 Dec
 2025 02:32:55 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%2]) with mapi id 15.20.9388.012; Sun, 7 Dec 2025
 02:32:54 +0000
Message-ID: <9cf6135e-43c4-4c31-acf5-03fbe32e2bae@nvidia.com>
Date: Sat, 6 Dec 2025 21:32:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/7] gpu: nova-core: populate GSP_VF_INFO when vGPU is
 enabled
To: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: airlied@gmail.com, dakr@kernel.org, aliceryhl@google.com,
 bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, markus.probst@posteo.de, helgaas@kernel.org,
 cjia@nvidia.com, alex@shazbot.org, smitra@nvidia.com, ankita@nvidia.com,
 aniketa@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
 acourbot@nvidia.com, jhubbard@nvidia.com, zhiwang@kernel.org
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-5-zhiw@nvidia.com>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20251206124208.305963-5-zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 31051092-248d-4a81-2191-08de3538ed3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGhldXp3SnNYNW1wcWs2L2crSC9DaHBUeGxWa2lVOTg4MC9kaitySU1SaFhM?=
 =?utf-8?B?WmUvcGRBRXljdWpIcU5yU1dIWDNJbm45cWh0TDVCVkk1WkZkei9wQzZsL2s2?=
 =?utf-8?B?YlQrSHRqbXZoMGVZR2VtbWRwL1FSdHpWcEZkK09pdm1KZlJ6Rk9lcWdqTjli?=
 =?utf-8?B?NjJVZ0pGUW5neUtkcnh0c3N1WHJPc21qYXdvbm5NemtBb0EyNFFUdFRBTkZs?=
 =?utf-8?B?UTQ2MWFwNHljOFlQQisrcDNJQy9iU3VjZVYxTkpLV0ZxRjNGdWxPSUtKQVQv?=
 =?utf-8?B?R1p0Y3NGMmprbFlGVDQrOFErOHpkakszTm5yUmlJdkcvTnVYWGhRUkVMenB4?=
 =?utf-8?B?MVBhNmxMQVJWZE04V29ZV1lmaXA1RC91S0ZjUjVWUEpZTlRTc1VJU1pzZ3Qz?=
 =?utf-8?B?TVcyOGdpTHpsbDZGcG5IM1FOaFNZY1F4ZjQrcVhxbmJFT3NqQ25Uc1owTkE3?=
 =?utf-8?B?RTlRMU1CSHl4N0VWc1RhOWpaWlZwdHZrTnZ2clVPL09PUmFvOGJCZFBpR2tQ?=
 =?utf-8?B?T0FVWTl1ZlVBZFJpSHE5R3hIUXR6TEU4Z2R5czZ4TzdYc01WMW1SRGxNaGs1?=
 =?utf-8?B?NXF1TGVGTlE4MWxDZVJTTGoyTVpadW1DYlA4VU0xRy9QTzVva3lIQklJRTdr?=
 =?utf-8?B?NHR0eU1razk3Q2xiaGF0VjdtVEJ2dnVRN2g5SDh1RENxS3FYajREMlpxVGRw?=
 =?utf-8?B?QWZSWUpBWlB5Sktab29sMGxjOHNPRitzYWhleWRvQzRNSEp1MWZ5eEl3bUZ1?=
 =?utf-8?B?b2xES3A3UWF3V1Zjbi9tRjErVHQ5bzVZeUNIMEZ4UnByOWlreCs2QTBjVVNk?=
 =?utf-8?B?OGtUdFNzeUJQekkzczdzTm1XVlVRdUlUWHJDVk9MZXNSR3UvdGp3dDFZN1pw?=
 =?utf-8?B?VWJGa3lpMmZ1M3NvMGhmMHN5NmtLKzFTc1RhWXptMWNqNC80VEhPbmp6WG0z?=
 =?utf-8?B?ZUw5VzVITXdFaTZJc2NuWkVhVXhUdlY1c3NjVDNaL0dpMkR6UGVqM0ZvVUJ1?=
 =?utf-8?B?c0lCNVA4K0tMTVBXbE1oLzNXOFZlelRLY25QNlo0WEI3dTdtVTMzcjZMZU1B?=
 =?utf-8?B?RGU1aEM5R0dySXNpRUp1U0hTOEJOOG1Db0V6LzBJLzB1Z2l4em9TYklWTlQ1?=
 =?utf-8?B?dlFKdXV1R1BZOGxtNnhWV1o2di9vVTN0d09jWjRjd05jRU1YYzZjbkZNNEJi?=
 =?utf-8?B?QU9sNlVFbUpsOFQvZkQ0ODZhY0E2T1lzRFNmcjlkRnBHbUVucThWWjFmTSs0?=
 =?utf-8?B?bUFKNkdvUHNHVzlmVTk1SGRqRzBpL2ZEdWpFZnZUVmtwS05TYzNnZGJPWjZa?=
 =?utf-8?B?MGk4SThoMFRpdTloWVZkdGhxSGZpaDJSaDFGK0ZKU2QvU3dKKzZqbG16QnR6?=
 =?utf-8?B?Rk1URmdzek5zU2dEREVweEVSNGpzaDBYdXVvYlpCb3RDcU5VUXBCL1Z2SUEr?=
 =?utf-8?B?VzJVV3h4OE5wQkF4Sk9UZzIxdlNNM1RKOWJnUkhic3d1SGxaZnVlSldsT0ZR?=
 =?utf-8?B?ZmNnTnlnK25oWkEvVzJyYlB5TGV1U2w1YWx6VXRSRnVzMjR2UGZQYnFGSmRE?=
 =?utf-8?B?dElqQ0VsTFF1dWh6d1gxM3hDeDhDYVBNdkl1NWpBSmMzNTJjQ09tKzNhZFV0?=
 =?utf-8?B?dmZOdStHdzBHT0hJR1pCMGtzb0RkYTBwQ0VXZjhCTDkyNGZSNFZQNDJJdHNt?=
 =?utf-8?B?aURsSnFxNDhaYkk4anlsQVZ3VnRlWCtBNmlia3paL3VpSHlvNU1SNmc2UkV1?=
 =?utf-8?B?SmppaGZrT3VGSXJPcXBTbWlRQlJWWmF0c3d2MERpT3M4WUVocTNVZ3JYMDhP?=
 =?utf-8?B?TndUajFwclJJc2JadE9GQ0szY3dEK0gzNEkzeGRib2lDTFA2Ry95dnpkWVVP?=
 =?utf-8?B?YVV6eWZoWG1PRktFaGVyV1MxWDgzRWNwNkZpaEJlYVZldmc2MVhZa0FZcnRt?=
 =?utf-8?Q?LYa0YrgHofNKV8Hqz4qBaGPSKygF7mb7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1TbWdicGlmYk5oYTZ6c2kwWU4zUzdLOThzMnpnNVN4ZW5CZFBOMGNCQWEw?=
 =?utf-8?B?S0s5VVQ0WlF5L1ZGMkxNRXlvcDZBTFNiUUxSSXRyM1l5VTNLY2M1NFZiY3gz?=
 =?utf-8?B?czdqZGVTdnljWWRFcDg1YlFKY3g3akJ0TXZjQjFJbUhWenhNSStPUHVnaG9P?=
 =?utf-8?B?RWwxa0hsblE5RGgwaXZwRzNOOERmMG00T1FCMm5ZdkZJdDFyQkVSUUxwV1A0?=
 =?utf-8?B?cllHaUVhZGZwUnFROERYL0ZFbGp3OEVjTkVCblc1cmdwMXRIcFp1QTIwVkZQ?=
 =?utf-8?B?V2l2bThLZm5WSkZSc1VzTDgybVhJVFRCT0R6QTY2SWZMWDRvdFpjU2k2RGZt?=
 =?utf-8?B?N0pIRVpYallTalgrYnUxZ0RUTUVVblZ0SG9jN1l3WVlnTkxJaXE5bkt4UjJU?=
 =?utf-8?B?QnQxV3hDUStPYzVmQTkwbzRRS1hXZFVUazN6QTU3RktBVkUxZmZVTHowMExL?=
 =?utf-8?B?M2ttM1FoMFVzcTg4VVZBVHkxeklza0I3UHBad0d0VWJMYllBc1BrZG9hSWVR?=
 =?utf-8?B?b0pVM0R5U21XVGptajc5bmo3ODI5KzRRc2xxQStjbjJzRlBkdjFaMDBjTU1N?=
 =?utf-8?B?VngvQUQ5d1pRQVlSRkMrdEdOdVhMZFpQSVpzUCtsaDQzQlJTS0FLeGN2RXhE?=
 =?utf-8?B?TDlmclRDM3BrVjFBMEpGQVovcjBSQU5LRHZoYTFhRjl6K3I1VFVvdnZzN0RK?=
 =?utf-8?B?dmpobUpmbEtjTnBlMVkwTVJSWlRra3M5a1V2cHU2RHRTN3JsUWhNcEN3WjEx?=
 =?utf-8?B?VVh2N2RyS29pQXRmeUdLTzZKaVdKaEhXbjBTMngzN285R21Sc3ZhTmVyRmV2?=
 =?utf-8?B?NzNaQmFTQ2JVWVJZQXEzMklNWnNvSG9zbVhSUFd1NHQ4d1VnMTRWYVovVnkw?=
 =?utf-8?B?d2VHanF3K1l2Zk9xSC9hY2VPbWJYRXRFaG1jalM4aTBOc3dDMHpURVk3TUli?=
 =?utf-8?B?Z3JSdE9IeWRBQWhiYWN2UlZ6b2kxcGYvSElzWlZYV1gzM3I2THNYd1I0Mkl1?=
 =?utf-8?B?K2tEN3ZPaXRkbDBuejI2VVl3OVA1UWdNbUFoNFBoc2wxNkMrSGNFc1RsOVFF?=
 =?utf-8?B?VGoxWHBTK3pNNkVmOXh3QVFPMFVOYnE0ZnZXeE5mY2NKNXVwS3VteW1uSEww?=
 =?utf-8?B?NmR1NkcrcjlGRVRvYmpqSXJnWC9mUVlRWDRhMXEwVnhPUDVVYWtub1NOZ1E5?=
 =?utf-8?B?c3VuZENCNjIvVm5GcjBCQ2JnUDJ2VnlTaG1lc1dTdGxBY1Q4bHpnQmIzbFJ6?=
 =?utf-8?B?bHN3d2VUMjVhcER4OVd5WlVrUEFDN3ZwTzJwZnhpWVNqSDhIYlU0dFlpSDRG?=
 =?utf-8?B?T0pVRXp5VHdhVkZObHF0eDdxajBHcnprVUlPSEgvZmYzdDh4ZHFKOTlBZGF5?=
 =?utf-8?B?bCtHQ3FIZTRibkxqNXdEN2JsemlxWUZ4SmtHWTFhdmwwNmRSdnk0ajNLejVv?=
 =?utf-8?B?OWdNTEhSamV3T2E3SkV0cEc1NWhXdjMzbS9uaitMTGhvU0MvM0UvY3lNNWVs?=
 =?utf-8?B?ZUlSamlOSUJlNEtvTjNOQVJwblcrZDkwZzJ4Y0hMdXRaemlVZ1k2RVliaytG?=
 =?utf-8?B?R2hYcGV0cmJ0Q0hTYXZrY0Z1NmpxS0ZKVGVUU01GVmhyS1NRcnBpOXFvUkth?=
 =?utf-8?B?WVNFb0IwMTVYZ0V4V2F6SERTTDBHVlZVaDBDM09kU1BDY1FIdUpEclBHczBY?=
 =?utf-8?B?RWNQTjBWdWxBMDFyYys4NmU4Q0FXTnB1NTRQV1ZnKzhwNFdtbVk0OWxzRHRH?=
 =?utf-8?B?UmhiQ256UVV0aDJsazZEVXNwb2loQlNXRlYzYnlzY2dYOUdXc1M4UFp2TlJy?=
 =?utf-8?B?dStGcG5naS83RHF2U2N1RXRzY2F2V01kRkZqV1owTEwxampMdUY5STFXdFAv?=
 =?utf-8?B?dlhrdVBpLzZKenJqYXpCQjdES09QVDZjelR2ZFN2T0RIdlp2am13WGJGZHVo?=
 =?utf-8?B?L3cvOVc5Y1hvbmJkVjFJR29pVVVSQ0xMSmI3TGp1TXVKazZ4RDg1R0Q0SkdQ?=
 =?utf-8?B?K0JCSkpTOStoUUEvK25XVHdWZk5UcVQrYkhTZjBYZWpXY2VRZC9yekJjNFpa?=
 =?utf-8?B?Nm9KMFZoQ2g5M0wwZ29aQ1kzZGd4V2VOR2Z3YUlDdTNOVGN4VWM1b3B4SjQ2?=
 =?utf-8?Q?wGxufI/Gj1lGJVkkXnI16p8+k?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31051092-248d-4a81-2191-08de3538ed3c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2025 02:32:54.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKxT6YX1QtfM4znJd5XCzGk9a4wNidQIPw+LYgskutQG8okKj6gWWiRVKGCqQWRBrmdm1BqkBxZIIkSB1cpTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

Hi Zhi,

On 12/6/2025 7:42 AM, Zhi Wang wrote:
[...]
> +/// VF information - gspVFInfo in SetSystemInfo.
> +#[derive(Clone, Copy, Zeroable)]
> +#[repr(transparent)]
> +pub(crate) struct GspVfInfo {
> +    inner: bindings::GSP_VF_INFO,
> +}
> +
> +impl GspVfInfo {
> +    /// Creates a new GspVfInfo structure.
> +    pub(crate) fn new<'a>(
> +        pdev: &'a pci::Device<device::Bound>,
> +        bar: &Bar0,
> +        vgpu_support: bool,
> +    ) -> Result<GspVfInfo> {
> +        let mut vf_info = GspVfInfo::zeroed();
> +        let info = &mut vf_info.inner;
> +
> +        if vgpu_support {
> +            let val = pdev.sriov_get_totalvfs()?;
> +            info.totalVFs = u32::try_from(val)?;
> +
> +            let pos = pdev
> +                .find_ext_capability(kernel::bindings::PCI_EXT_CAP_ID_SRIOV as i32)
> +                .ok_or(ENODEV)?;
> +
> +            let val = pdev.config_read_word(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_VF_OFFSET as i32),
> +            )?;
> +            info.firstVFOffset = u32::from(val);
> +
> +            let val = pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32),
> +            )?;
> +            info.FirstVFBar0Address = u64::from(val);
> +
> +            let bar1_lo = pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 4),
> +            )?;
> +            let bar1_hi = pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 8),
> +            )?;
> +
> +            let addr_mask = u64::try_from(kernel::bindings::PCI_BASE_ADDRESS_MEM_MASK)?;
> +
> +            info.FirstVFBar1Address =
> +                (u64::from(bar1_hi) << 32) | ((u64::from(bar1_lo)) & addr_mask);
> +
> +            let bar2_lo = pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 12),
> +            )?;
> +            let bar2_hi = pdev.config_read_dword(
> +                i32::from(pos) + i32::from(kernel::bindings::PCI_SRIOV_BAR as i32 + 16),
> +            )?;
> +
> +            info.FirstVFBar2Address = (u64::from(bar2_hi) << 32) | (u64::from(bar2_lo) & addr_mask);
> +
> +            let val = bar.read32(0x88000 + 0xbf4);
> +            info.b64bitBar1 = u8::from((val & 0x00000006) == 0x00000004);
> +
> +            let val = bar.read32(0x88000 + 0xbfc);
> +            info.b64bitBar2 = u8::from((val & 0x00000006) == 0x00000004);

Please no magic numbers, please use proper named constants with documentation
comments explaining the values.

Also BAR reads here need proper register macro definitions/access.

Also the above code is lacking in comments. All the steps above need proper
comments IMO.

General philosophy of Nova is it is a well documented, cleanly written driver
with minimal/no magic numbers and abundant comments. :)

Thanks.


