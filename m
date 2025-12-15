Return-Path: <linux-pci+bounces-43029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB5CBC76F
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 05:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1151030051B4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 04:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCEB2D9EE3;
	Mon, 15 Dec 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtPZZTdy"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6306B2C11CF;
	Mon, 15 Dec 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765772895; cv=fail; b=QW3T3JxDBTR7jrqCUVKD7ZKy/taQkq/1qyJtbNSG7GjXuc7t9E3CemIwosCntq9W8quob2AlAss2BtMg2zREbzwWEONOu02hUgHxKCstXleO8gGmhSIAlPEDNo7GzDoSGDusjJt5lc5PiTZyHLRNqf4rIoWp/aN+2TXbO+QUU6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765772895; c=relaxed/simple;
	bh=XWkw3oH1vc0aUBNbl8WJ7egDzmvWP8A5rmaTZRcsI8o=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=TET2opn3ObG/3aMFXLMic8FSqFY+dpW/vZwslZjPJFSqm6Du0FWQG3EbGQ0GXQRAuL5Fp/SkbDO8xJ8dDu3Exs+aCb6Jo0/2hszUJFFnrPGrYfhxLR4QzgAAZIw9vH/QyaqkFPW5eLK0tFDI6y5hI0MJ4/B3sPQVML1jcUMnstE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtPZZTdy; arc=fail smtp.client-ip=52.101.56.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgzLhQL/UkC0zCG58KtMbuMwCRFbk3itoGjJ0NfxMMuNLIJQVZgaPnZNs1YwSrU25JJjySGPricwSA1lgOGjJX4bszJ4UbIJk8E6yV0bUW+/SpkjBf4/dCD7bF5gFmhbE4y0BSpMUlOhG3ndLtcZ+6QhD0EUi5+KbWuAQhdsbapqowuxRn+C9ed0HxiyZuEdTlHAf8gXlmHm3kkgdodXNrVBGnPvDLNoaFE4HQejymxqggyhFsjBFO3R/aj0bJ9TiSaqdfqgqsDE/I/QYI8ktC224aI7MO0+KkCDSp5XFwNtWwMaT82KY+ExsKLPgXzxdE6V+ctKuZmt7IH7poIy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWkw3oH1vc0aUBNbl8WJ7egDzmvWP8A5rmaTZRcsI8o=;
 b=XoMZancilrgApyx9ZRzGIDvxZh+wLUAzLmynq+orhlS0Hr1QePi6pzpFOEc9V65Rqk+he0s1Xi0DcuPezEBZwhEvK0Ky8fQL6bs0syPlBRkiqCqrwbfyFjDQLnBIAVa7qteJpQMQefd6eDzRxq20mZZl0SMSX0QjQiYvRnWWFph+Pq8bSxtrFqIr70BJ+EBLi8a9uPzsgmfsJSdj/ntm38Y0ZK3mX+z/aRYWX5/WUIDUy4Qm8AFZDadP87xnvgWTLdJTzLLtlXYErm8HPqW8hyixk+6xzuid8K2g/gceUiLCZcsw/ObyD6xSojjQqG6HCZnfmJ/+mbeLX+PsEciyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWkw3oH1vc0aUBNbl8WJ7egDzmvWP8A5rmaTZRcsI8o=;
 b=QtPZZTdyzE0dUCI4Rawm20Z13TyPdqD4rQAy0VXSqqmUmW5OOb9X5O8VA6xifNjKYyQgA8PRGq03tFbJEaLtdH5tJMqFHFJ89JBbMJXLIaV1dtjAww4qr5CTxZlg/ftKPlcr0cAWuj9OyHuP8zH4Ygsy2AwGk98FpahPm5bxrrDTs+oRZvEongOi6IzLFQW0Tjjl2y2Jf3785i4+V5ZXhULED5qvD55CCrzBpxTB9bc4kte7GBQXebMtCMpS1jX285RAqLdIjI2HjgOgewvaIk7eZMrRchBS37QTfpV/ct5kuaUXmy2vgmxCJ8PkiWBceGt7SWzFmB4yDyf5MZErTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:28:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:28:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Dec 2025 13:28:06 +0900
Message-Id: <DEYI8XGC8SM4.34XY9POC523A9@nvidia.com>
Subject: Re: [RFC 5/7] gpu: nova-core: set RMSetSriovMode when NVIDIA vGPU
 is enabled
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Timur Tabi" <ttabi@nvidia.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "Zhi Wang" <zhiw@nvidia.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
Cc: "Kirti Wankhede" <kwankhede@nvidia.com>, "a.hindborg@kernel.org"
 <a.hindborg@kernel.org>, "markus.probst@posteo.de"
 <markus.probst@posteo.de>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 "Neo Jia" <cjia@nvidia.com>, "ojeda@kernel.org" <ojeda@kernel.org>, "Aniket
 Agashe" <aniketa@nvidia.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
 "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>, "helgaas@kernel.org"
 <helgaas@kernel.org>, "lossin@kernel.org" <lossin@kernel.org>,
 "alex@shazbot.org" <alex@shazbot.org>, "Surath Mitra" <smitra@nvidia.com>,
 "John Hubbard" <jhubbard@nvidia.com>, "Ankit Agrawal" <ankita@nvidia.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "bjorn3_gh@protonmail.com"
 <bjorn3_gh@protonmail.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 "zhiwang@kernel.org" <zhiwang@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>, "aliceryhl@google.com" <aliceryhl@google.com>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "gary@garyguo.net" <gary@garyguo.net>,
 "dakr@kernel.org" <dakr@kernel.org>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Nouveau" <nouveau-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251206124208.305963-1-zhiw@nvidia.com>
 <20251206124208.305963-6-zhiw@nvidia.com>
 <6c2e13d934c11170edba603fb88e8f2d67a2a049.camel@nvidia.com>
In-Reply-To: <6c2e13d934c11170edba603fb88e8f2d67a2a049.camel@nvidia.com>
X-ClientProxiedBy: TYCP286CA0303.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e224379-0f6b-4499-1a71-08de3b925a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFFlT2VIY3BSVS9LeXQyOThhci9XZ2RQaGhKN0ZCQUtaZ1RvNGJkT3BabGVz?=
 =?utf-8?B?aGF6UHZaTWVzOExGV2JMS3QwRTAyUTkvbGQ1UXh5dnNwRnVGQWZmVjRsVnow?=
 =?utf-8?B?Y3FuVmJIdUl6TkUwcTgySjB4cE50bUFPWCs0ZU1Xbk4xUWRrRzFvWjc2dHl6?=
 =?utf-8?B?L1JRcCtYNWpBRkUwRTBCdmNIMFlXMEl6Qm54YndONFlPT2pVVTRrbS8veHBP?=
 =?utf-8?B?R2xJbmVRcS9MWEsrNzhvZFM2YndUY3R4blRYNTJtQUhWeTROS21Tck1QalNM?=
 =?utf-8?B?cGwxS3hPZTRRb0IzUHJiUEt1WGExbE9OcHh3a3lndm11YW0zMlN0cklBcHR6?=
 =?utf-8?B?NW5GYXBBRDI4d2JaTEdSUDVzRUVYVkdleFNoRERpbzlTNzVKTmRzb3pRajFG?=
 =?utf-8?B?TlpoRzl6Q01TVlcyQ3REdVBVTVpDM3pFNUdXZjV0aXdaRkJSYnNwbFJaZEVY?=
 =?utf-8?B?NEFYZk5kWlFFbVdSYjRKN1RtUUNBNUdubkZ1eE5aNldYSnhyb2FScTEvdmlN?=
 =?utf-8?B?L1RGZDc5MDNaNUtyQ1BFci81SDM5T2xnV09RNFpKTXRZcStyMklkRU9jbDBj?=
 =?utf-8?B?NWlOdXV5VzlsOFZnU1NsbHM1VXFGVTVjaGh5dE1yL0lXS2RZK0hzY3RhZHNI?=
 =?utf-8?B?SkR0WjQvbk9hTWs3a2wwL20ybzR1NGo2ZnNUSWhXUE1aQS9iSWpFMHpHTFJy?=
 =?utf-8?B?YkxUN2VuazlWWkhnWXM3dW8zcFFnRVljOWpuWS9tWXhHbVpwR3QrOE82bTJa?=
 =?utf-8?B?bU1uRTRmbFVzZ29LRE55c0MrWVR3amlWRmxmSmlNeGxoQTFxMWRpOE11NkQ5?=
 =?utf-8?B?aUtvamNMeDFmYTd1U1RsZ2tuZEszMS85cUNhbldWa3pCVE81c3JUdU9Ka21m?=
 =?utf-8?B?M1RrVW1FVVo3SzFxaDA1aC9XNEFzTlpyREtlS21sSmx0dTVtRGN5ZmpmV3pT?=
 =?utf-8?B?UXlJV21xVlhDQWM4Smd1NVRrdWtkSzBDdTAvUnhIa25DcWNITnk4SHNFOHo1?=
 =?utf-8?B?cjY0c3N1aXh3emNRMjFlUiswdWxtTGxIMjJJT2Y2aUN1TUhrbitkUEI2NHpk?=
 =?utf-8?B?RUJKcnFjeVRxTGVtVHcwYmE2UGRhendnTDNiVUNReW1BOTErejV5U09RNlVn?=
 =?utf-8?B?a1EyWmV1RmJuYjlpRysyZi9yTVhaZHZ5Mmt1YVJHWllVbkdVQlNYdXEyZSs0?=
 =?utf-8?B?dEsxeVYvbVFLQ2RPRHJFQWh6c0dhRkJ5VXBTSGVKZ0FLdEJOS0JxMnd3cHRO?=
 =?utf-8?B?Ylh6bUV0dWVVS0VRWE9FTGRjMjRBMEJyWjhSaDE5eGhhWGVYQXRVWWlGK2t0?=
 =?utf-8?B?Y1cxWlo1M21lMnNZUnlrUmRSemsrdDhUdnFXajBQTDhDd3cvVFNlMmVlUUh3?=
 =?utf-8?B?SjFWT0ZkTSttdlVVR1BOOXlkamZzY3J1dG1BZmdBM0crQ1JvT1dGRXJWeC9v?=
 =?utf-8?B?d0dVUnI5WDdxRjJGM1VJMnRyTEhmNEhTRDgwenZFdUEzQjE3Q1RoSmVvb2k2?=
 =?utf-8?B?eEdLZVZUM3FSblF3Wmh1OTRFNFNzQnBCWTdXRFpJV2JzaEZMRXdmU3NkRWtQ?=
 =?utf-8?B?TVNOQjVDYW5JVFR3cFVsYkQ0UG5ETE1Ia2lkWE1ocmFtOGNIYlU0ZitiNDRk?=
 =?utf-8?B?Z2dxOFRNY0lSM0hkVTJjV2k0OE0wVnMxT2JBK3lJYzJ3Q3dNWkI2ckxkdG12?=
 =?utf-8?B?VjFLQ2JkZFF6MFRiSUFPZzlCS2kyREt3aWNNbFBoQWhKaUluK3g3M09WV0pz?=
 =?utf-8?B?L1loYkJhSUpob290TThIWW90ZkZMYU1HQUxIMXJTNWtQdEdkSGFEc29OVFRt?=
 =?utf-8?B?bEN4MWZiMXNpMlF4TDhCWHdQdDUxejhhdU4xNDI0OUV0QnBqV2VmVldDWUJX?=
 =?utf-8?B?S0VzSzZLeXc3WE9SalF6aVFxc20zYnZuZ3VITGRObTFadDZuR1BtNXlHbDlw?=
 =?utf-8?Q?bOs/kfZoG5h9oa6cnUXi1Sk4htGzYb7c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0w3Y29jOWJTZEZmQU5NM0NlRGZVR1kwNWJQMWFGWExaT1lDZ1JjT0dWaTJX?=
 =?utf-8?B?bkM0dmQyaGhqUWZmU092TFJBbDVsYVBSWXpsZUpNRk5CNTBkTlJsSk1vVndx?=
 =?utf-8?B?Q0tpdk5aREVNWHpEeDRHNlN1WVUrTVlmK2dKSk1rNHM1dWJFSVVVZXBRU3NS?=
 =?utf-8?B?V0JJRXFIYjdlSlZJMDFkUmtERlBYT1M1VlpudllKMDNhZ05jRGRhelB1c01Z?=
 =?utf-8?B?Q0hRUDFMN1BCb2JCc1BxTVFNSTA3RGJrTk1aUHhTaVNGWU9yTmRvMGF4NElj?=
 =?utf-8?B?b2hwaHR6QWNCUnZhZmlmalg0OEdWbFBHTFNxSURueTBMbHpGMmFlb1hleXBO?=
 =?utf-8?B?TVRCblh1QXJmKzJKdndKaGlaWWFGanZZdTQ1WU1YQThRcXFqcU5aNWRtaWVE?=
 =?utf-8?B?c2tVaDNMNVNaM3UrTm9rY2REYkZSbjd5YS8vQmR6TmFDVDkxaVhiQVQwc1Q1?=
 =?utf-8?B?NzdtVzZHQmZQMVltQlR6RmRaM3dJVDJ6OG9yNmZEMk1FVWtxOUI4QmhaMFpl?=
 =?utf-8?B?RHE0bCtZYlQwS3lEQ09naElBSFc4dnU1Mi9vSnBHYkhESUVjNmMwM1JXWGZW?=
 =?utf-8?B?V0ZUclVIeHZCVHk0TWdobzRCT0dKNU1ud3c3MmFGN3RnV05iQ0Izb0FZblRa?=
 =?utf-8?B?dzV1bThZZjRkczk5RG15TEk1NVc3RFdaWFBreGExczMxSDBQalMzNGw2bnU0?=
 =?utf-8?B?NnJRTTg1bm5Xekt5TmtIVThvSkhkSHNwYm1NdnhJV0VQOFVyUGZhY1EwZzNk?=
 =?utf-8?B?ZjUzL2lOSkQ4bUVTUHk4czFvV3cxeXJYWHY1Nm9uYU9WOHRJWmpxa0FiVFd5?=
 =?utf-8?B?dmpoTWs5bzJKQXRteHpadWkwOFJRcGNoZ2JyRVBJSlNEUG9iRURrQ2dUR0ph?=
 =?utf-8?B?VFNTNko3NXRvNU53Ny96R3J6WnNFcXlPQVdQYmtTUnJkTS9sRU1RNTBVbWVt?=
 =?utf-8?B?UkFmVmMxZVdSVk8xV0l4aHMrcEp2UU5ISkxSclNNV0hpb0ZGYmxKVkl4TmV5?=
 =?utf-8?B?S1N3aWt6c01jQllPRVhtK2pmeERWTDlzb2tNV2dweUNGNkJZcmVDT2hnaXdE?=
 =?utf-8?B?aUtXYWVhZEtSOGhnWU5yUW9ta1pVRUlPQXhnQ2lHak9xZXNJZUdlWmtxQVJS?=
 =?utf-8?B?UWhRc1M0dk5iUWxBWjFPWkxSVE5wMnFPL2JnSWZnT3FCd1YwYWJiNXR6SzlG?=
 =?utf-8?B?ckNMUkxlZER6ZUpKNlJDSHB1SlRMRVVHU3lBM2JaV1pvU0xndW8wMzZtNjRn?=
 =?utf-8?B?a2xlUmtkQ3VGK2dTTWJrNUVpbWViaGFKMnpXWTcyVlBGMGQ0OE05Q3puOE0z?=
 =?utf-8?B?bnZFUmw2S2FwZHRqVUtVdE1FMHUvcndrenNtZEo1ZWk1NWhhNHZNandPTUdj?=
 =?utf-8?B?WmhFdWY1a3ZFMEsvQW5hYnRNVmRKNE1JYngvazd5blIrUDR4NXRKQWRQUDBm?=
 =?utf-8?B?OVk4NTNESGw4c0Faem9KTGY3alZ5VHR5RTZTOUVBaDRQaVdiRU1MS09xSG1x?=
 =?utf-8?B?YnlRTFhTaWFSWWpzd1grbXdKTnVxYjBIU2dKZmxVdXpzN3R0clVwU1U5cXha?=
 =?utf-8?B?WXpjTCt2K05UK1lHdjlRUDVqbkQxM3g4N3gwNlhWNUM2aG5xY29LZ1ZzQ1BS?=
 =?utf-8?B?TE1sNUpWMEdSZVQvRFZMWlUyTUp4SU1XbDJoeVFYSkQwb2poYU9YUHoyaHA3?=
 =?utf-8?B?dHVSM2VXUHgzN01NZ1dRTEY5eWgwTzVZMldYbDEwQitBYUs4MDFoT3RTZG1L?=
 =?utf-8?B?RXdMb2R6NGc0WSs1ZjZ2Wm12SDBpZmxjckNIbFNKQnpYY1o0SkF3OFZVWUx2?=
 =?utf-8?B?N29FbUxSYy9ocFZzSWtneHJraUgvMWFwR1hrdWxWbGV0U1lQTDNsYW1DRTZm?=
 =?utf-8?B?S0ZnWGVYejMrT3JyQitxTmR6WHU5SE40eEx4c0d2U0pOT3dPSTVocnlWWlFa?=
 =?utf-8?B?N2QycnlSRlR3WDQwa1lCL3VkTXR6WFVBeU1xckVPZExzREZtS3JIckNvUVBj?=
 =?utf-8?B?ckw3TXhuakloaFRZN1ZyVHdjYnZOa3o0ZUZGc280d0RMclVrTWhFbEo0SHVa?=
 =?utf-8?B?OFJ5NjE5RXlWeUxGWTRLK0dsYlgwWnNDWlRTOVQ0eTBhbGxtKzBVa2krNWdK?=
 =?utf-8?B?QzR1S2h6UTI5TWhJck9aVUVxcVA3Z2dJOWhrV3dyYURzVngxYmZlTms5TGZZ?=
 =?utf-8?Q?yYIqw1VXrnHBlIPzZDRn3S7R89V7Kyl2wten8NJBgNiI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e224379-0f6b-4499-1a71-08de3b925a32
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:28:10.1834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNhXdH8TF/lOSe3jGmtC+5DtwlQEdz6JUgUPZx0nUXJOioP4qKjangnJedanzCca1MzZwuA0K46rWfmfIkIklA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988

On Mon Dec 8, 2025 at 12:55 AM JST, Timur Tabi wrote:
> On Sat, 2025-12-06 at 12:42 +0000, Zhi Wang wrote:
>> -=C2=A0=C2=A0=C2=A0 pub(crate) fn new() -> Self {
>> +=C2=A0=C2=A0=C2=A0 pub(crate) fn new(vgpu_support: bool) -> Self {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let num_entries =3D if vgpu_=
support { 4 } else { 3 };
>
> Instead of passing a bool, and then hard-coding the length based on that =
bool (which would
> require that RMSetSriovMode always be the last entry in the array), you n=
eed to do what Nouveau
> does: if VGPU is enabled, then dynamically append the entry to the array.

Yup, as we will add more stuff to the registry depending on various
conditions it would be great to make it more flexible.

The way for this would be to make `SetRegistry` wrap a `KVec` of
`RegistryEntry` - that way we can add what we need according to the
runtime options.

The current design of `SetRegistry` (which does not directly wraps the
type to write to the command queue, but instead implements
`CommandToGsp` to create it as the command is sent) should make this
rather trivial.

