Return-Path: <linux-pci+bounces-23569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4B1A5EB58
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 06:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DD7177109
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 05:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50C1DDC3B;
	Thu, 13 Mar 2025 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Du9yDP53"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2028.outbound.protection.outlook.com [40.92.22.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9DA80604;
	Thu, 13 Mar 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845352; cv=fail; b=E3WyvK0LF6I+KAcUJu2YO4C2Ruval/U2xY4IEaJyMm1G9EqiRggdCfwyl4oQUP+iqeAOipeyymhtD45G84dIjhnhq5vLKyest/2p9kjLE65yOwi6FUz4THp4I6agbRnd3rsgwhDfLHe7eayo/L3Th3ELdyMiv3XwB6vPc1R007g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845352; c=relaxed/simple;
	bh=YPIc0gqzM6n8ZRsfd8wzjx/7+Zub5t/eOO6KjqXj4Wo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XBAC1ZQypbwktGHQbD4KA40bw0xTInCWDa+7V5vmaO7/9a/GnTKn4YuKr7mH3/v5YDypdK7rgYtD1iy2Yt7a6YSWCKT7Fcmf1DwQuOaheWc4gSPtNyK2XiID9hm+ua/Q218wSVGsCiVnJ/A5ljrh9rJxqAtI+uRnNqeMYPDhXtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Du9yDP53; arc=fail smtp.client-ip=40.92.22.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTLbMcfPJMpVZOwIl54xKFvva8EZcwMYmjxyYafe+zSSUX1l8a9kOPVd+XKt5BQJY7xSaB0QUqFtMDSG0q0EwX0MT50AY/iX3DhtXXgFaT12pOtfjGkZ7vsB/ozfYo369vw8/IiVFWLGpx0xp6z+CqClu8+39xR6CbakL2rIBvVfiZBx6P609IM411DFkEdtsaJYHxdnDmVE0IV8bAbN1wWPiPbY/rWwJzaSCTb6ZOTDT/xckWO3GerD0TCVplFBJMI7lN8T9zrzC5Cv9DlFaurYiOBw9hFOJfHBn0O55MXRPIkozREpE80Nmb3yN1dW4BodXyPsR1MW8e4caEgP3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wRLmCj2mGS2yZwYc/J67Nl9fcaV6P06WwXzyWcrn9s=;
 b=iM7TFyBFnQFgrDs+axhf7RI5vLhmwR04jook5jr01XHGWK3n2KHMaoe352A5/LNKWZS+jmnrSXMqGdAtxP+LP0quxJqZuG9TX8Y+9M2boi2hkfWDiL05BdSIbpSvCHoRUPAWuftHvtgxogmUVxarwTS/h8V6ROD2ArGC/SNUr5Wib91FpgudtT4Z6MtxF3ELC4x4coyeSMxLwciuYdIpS2uXPJ9NeoBF0jjuatHYGEC9OydOAaWaO408IucVwZOk4XtmlAtgkE0H0xwGCa5f1Lsb+xJkNND3FkFBddpe9mVS3ssDSh+otI5lAoSRMwCRWCHQ8NyECdoLWegB8YAsFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wRLmCj2mGS2yZwYc/J67Nl9fcaV6P06WwXzyWcrn9s=;
 b=Du9yDP532jNwCZPgbx3IKG+rd7WZoIZByIFWogdOXloxYRRiSfCIGitzRG4a12vFqHJQAf/rtjgxhLaJh7iRTZfKlYXp6/IMIEwF4Y7AVluC5dzXGiX3QFewApL1u4i/JGFcyItjg3GA/ncJxjm/9jFKz0J2gwJQVpp7U/jBfi/l3S9XPUq/pf9exgT+AcJn4JxB6qURYV6/V6dyNjkJFf7xdDAcsvAtvtXe/pOvwtT9vhBSdHTWkjIZLKMBWiRWYtJqmwDw36uFeIT+AgohzMqJ8HDVGAzTEKveNO/59Pz6RfT61fASUvbu6TdNdVb3F3e//G5FhGbRr18ioxCWTg==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by CYYPR19MB8103.namprd19.prod.outlook.com (2603:10b6:930:be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 05:55:48 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 05:55:48 +0000
Message-ID:
 <DS7PR19MB88830A8EF1DC8B2C3685EF3F9DD32@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Thu, 13 Mar 2025 09:55:35 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, kishon@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
 robimarko@gmail.com, vkoul@kernel.org
Cc: quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E7167E44F92DBC29FF3C9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <a95b4c01-9d8c-49eb-8242-93ae411caec0@linaro.org>
 <DS7PR19MB888309B506D25ABA03F218EB9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <2ef018c4-884a-4390-906c-8898b31228a5@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <2ef018c4-884a-4390-906c-8898b31228a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: DX0P273CA0095.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::11) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <99d2ae52-b438-4d09-bc95-cea3f1cd04eb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|CYYPR19MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: e4460669-42e2-4dea-cf8b-08dd61f3b35d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|6090799003|19110799003|15080799006|5072599009|7092599003|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FSUTBaUHFqL1k4dE4wVksyOUdBcjhkejRlczd2ejJTcm9ZQ0psZVFkTE5t?=
 =?utf-8?B?UkVXT2JHV1dUUVM1WGVRcDJ2YnBQbWZMRmQzb1k3Y2EydERFUGk1UUVHNTJD?=
 =?utf-8?B?NGd5NXJCVVJuaHNOTzJlS1BRVjFFNW0zbFFwY0ZncUtUWFBYN1daY3d2eDIw?=
 =?utf-8?B?SnFYdWllUGtaRS81NndLb1NVa1psOWVnSFo3bEo3SDRCOGVFVlhHbWVGN1kv?=
 =?utf-8?B?K3JJb0pZTmlzeWdLVENpYW5RK0RReisrK2lrMytiK0hiQkRLTjBSWXZmclF1?=
 =?utf-8?B?NVJ5clJjV0dOeHcvWkdFb1JjV1ozbnh5L3FDVUtLQUJ6Nm9vUVEybGdUYVRk?=
 =?utf-8?B?Q0FPRkR4d3FQcTNnckRlWUNldjAvNjJtcFVNam4vZC9Yd3pWajN4RXBlMHRj?=
 =?utf-8?B?NDhFcm5ubU1DMlNMSS9EZWNTSWhHVEVyVFV5dWcycG9oRm5udjBnYVhxRFY4?=
 =?utf-8?B?NXhiNXJib0Jxc1Eya1hEVS9DK3piQzczaVdCM3lHR2F4OWtHdmZjc0dydzZW?=
 =?utf-8?B?ajZVcjZiMm5GTVpYSW1EMXBCbDRjVkJjZy9FaUJTRC9RY0dzTUVOMEcvT0lo?=
 =?utf-8?B?MEtDb3k4TXVldTlWR0tPT2tvTUFaSnQrNW5oeEU5bTJhNCtBRC9hRVlJU0d3?=
 =?utf-8?B?TzVWUWJ0b1U4eEhpU25CaDFwTkFrNGpsZGhkbVZ6WitvS0pyZGloeC9OdnZL?=
 =?utf-8?B?dDRPeloySlJOSWYxcFNPVytxcmVRWjNnSTBZU24yR0tJMHMwRjc4eUUyMGxs?=
 =?utf-8?B?T1ZGaWluYktEbmM4MEN4MGtZY2RzU29UMklxbGE5VWxsNmZwT3JYc2Y0Y0Ir?=
 =?utf-8?B?R29ZN3lnM0JJMDd1emREbVZ2SmgwdW9VSGEzWnIyQWpRZVd3b2d5ZjhTTU5y?=
 =?utf-8?B?WUF4R1FYRzFFQmdGM0tnUkRFYU5HbEd1eEdmYjl4elpSK2Z1emdJK2V3UjdZ?=
 =?utf-8?B?WWdYQlVlWld4NmlYL3k2aW0rUjlFQWtHSFkxM1dZeUtLelVET1Q0TlpWSjZ0?=
 =?utf-8?B?bVM2US91Q0ZkQTUyQkc3cHA5OUYzZE04VTFlR1c3YjFzVnR5a2JVZ2RVeHJL?=
 =?utf-8?B?dkc5WlowK0ZkY05acHFPRVdZSDlNRW1NQlNUS3ZvUm93cVNUak1XeG9IaXlW?=
 =?utf-8?B?VkJYWXVERWYvamk0blVYbC9tbkVoV1ZSZ3NBcWpBSWJxQ3VxekJCNVRnWnpM?=
 =?utf-8?B?NEdpRkxDQUVXL1dOL0xtaFppdHBTcDZnMTBGbC9TNHdJY2R4RllLdVQyaWlV?=
 =?utf-8?B?dVNicEZXWWR3V2MzZ0ZQZmxTdDBvUmdObVZUb0taeHY0MTFzaXQvUXlBTGc3?=
 =?utf-8?B?dFdGSzVkRXZjUEhubjM0YVgzWDlkaE5heUJWVFhJeGFLZHE4dzN1S0FpWnA5?=
 =?utf-8?B?MFErR2tpZlNwYWM2c01yQmhER0k4UktxUUJqVklxdy8rZnlQYkZLbXAvTzdT?=
 =?utf-8?B?NzdGbHkwcXZ1U1JNbnNpeUIvVzdTc2ZTTWJSVmZnSlhUTlR1ZUFwWE50UVFq?=
 =?utf-8?B?QnpxM2paKzZTa0VqSHBUZkhyVkJnRml2Y09ZdHFCaXdqQ2loR3NOQkZlVk5N?=
 =?utf-8?B?WVd1bWtyT0FuNlJqaGhTMkY3ZmJ2ajlBb0VaVmo0cUEzRTdEUHlOa1I5cXJH?=
 =?utf-8?B?Uks1cWxLNnpWcDg0M3gxbDNJQmdsZS9ocE5iMGhURnhqSnlnbWRxOXRpajYy?=
 =?utf-8?B?aUVMUDVXZjBlZGxEK2t1cThEeFVObHJCeUdGQmxTRFVDYzZ6Rk5jaC9BPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2hoK0lpQ1NPQUd3MjZiazU5cEdmSEhmSFcwVFJqUWRyRjRtYTV0dWlNa0NG?=
 =?utf-8?B?c3U5L1Nid2M0Q21jUmR4aXkrK1dIY1RCb3VQaGhoekVKZnFlbHZyWEpZMDV2?=
 =?utf-8?B?R1NjMWtzU2NvT3JiRVZNZUhndU56TDBKTFd3TTlkNG4xZFIzcTB3S1VwWjNU?=
 =?utf-8?B?MHlnS3NPQmh3MkMyQnNsb21FaTNGS2d4SEdva3VmQTZGKzZzM2phYWRVOVJH?=
 =?utf-8?B?c2JsazNOcXFJaFdBM3Y4ek42eFlRZ09BbXF3KzlZTGVlZW1CbThINXZVRXBu?=
 =?utf-8?B?UFBFdnRwYlJqUnVGZzNmcW5KWTlOVFZEM3p4K0JlejV0MFYwaitDbDVkejFT?=
 =?utf-8?B?UkxuUmVJU1JjZTArT09sNS8vOVY0V2V4TGZwamRhVmlHVjlCSGVXV2UrWnJj?=
 =?utf-8?B?aFhlQ0Y5SHJzMUNPa3UvZ3U3N1MwclphVFFTWUl3UlV5eGlKQkJVM1FwL2p1?=
 =?utf-8?B?ZFdZbVQ3ak5hUGl2Um52bk9pWHNjQm9pODRVazBLNHlZclcwZW1Da09DL1Rq?=
 =?utf-8?B?a3F3R0xOYTdGODBzUElTMHo1WlM0cXd4ZFk5dHdvWDVmdnJ5akI3Yy9WK3VY?=
 =?utf-8?B?WS84VHlPcHVhYnF2TlQzT1E2ZmRwbEdReUZ5RGxJM0IzZUN0ajBNNFpldEdC?=
 =?utf-8?B?SHRuUjYxRGdJNUxYUGN5b0M5RmVIckgrRFlHNmxhVWlLV2JidGtwbmNFNmJl?=
 =?utf-8?B?blQxOEkvaHpSV21QbTVzdmhkWFN1TE1xSGwrcGw3N3gvTEYrd3JZdWZvYW1p?=
 =?utf-8?B?elpKdUprbG1KZzYvSE9HTFZnQlFUOGFPVDNBZmdHbTNPTWlmRVlSZjZIRnZU?=
 =?utf-8?B?T2ltQW14N3RpVUNYOGltUHlqVkNzUGNveUhYSk1uS3FibEwzL05nUE5ycHJw?=
 =?utf-8?B?NGJIZG9UMjVjZEgwTFpJc0poUElLTU8wTUdSTDN1TUpGbjcvVCtWOCt5RHc5?=
 =?utf-8?B?bGYyODI5T1JSSzFwbFdKVjV2cWhrMDJCeG8rUFNXOSsySENBNnVuL0ZybmMw?=
 =?utf-8?B?bUNOMUkyYm5XWmo5NzlkK1loVVBuVVFxUmdveTFMUEtJTDg2ckEvcXFGWkNk?=
 =?utf-8?B?K0xvV2RYalZLbVZyOFFFTFFpQmsrKzh1S0pnaXhUVU5GM2JYWEt2UWxVRDd4?=
 =?utf-8?B?NWhQZHdGMU9DRkVRRjM3Q2tuS2p3OU42Rkt5TUl0a3lVbEhtNzdrK2ptQXMr?=
 =?utf-8?B?Q1pzb1p2L0dKaTQ4VGxqdkxBeEI1SG5ZQWZ2OVNXV2dvNW9nN2ZBaTdjVTIr?=
 =?utf-8?B?dlBYdERua2tMRWZRZzBRUDVSdWRhUTA5WHp6LzZkc2wzTjBZV1N2b0pja1ZL?=
 =?utf-8?B?Mm1PeGZ6dWdjVFFvYjlkN0JsVWpiL2tROXhmUVdoMkVNZFlRNk5vR3JlZWE3?=
 =?utf-8?B?WHVPZXQrcUJ2ZlBRQTY3VE5MYTlma2wzLzVDRDdDNXgxaHJVMmlhcnh1SHZu?=
 =?utf-8?B?Qlo4ZDVtTnFxdTJSY0pPYmhIa0ZvZGZPbXdGc3d2MGM4ZWNQQ3hTODNVd2xj?=
 =?utf-8?B?MFN5N1F6SDlweHorYzUwSDkzZVNkOTJLS2ZNcUU4ZmFMUVZjYnM5OUMvYkl4?=
 =?utf-8?B?aUtXMWE1dEVsQnkvb05lN1NyVGRPSTZYNE5Qa2dlcUtxdXZIL0hBbTlDWUdY?=
 =?utf-8?B?andYcit1MUtBamxUcVkwTE5abW1QMWt6UG52anhIdWVwN1FKS05hZUFnbUp1?=
 =?utf-8?Q?Zoe3ZBkMZ0ZnBjLK4S9F?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4460669-42e2-4dea-cf8b-08dd61f3b35d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:55:48.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR19MB8103

apologies for the delayed response, was on a business trip.

On 3/6/25 11:24, Krzysztof Kozlowski wrote:
> On 05/03/2025 17:41, George Moussalem wrote:
>>
>>
>> On 3/5/25 19:51, Krzysztof Kozlowski wrote:
>>> On 05/03/2025 14:41, George Moussalem wrote:
>>>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>>>
>>>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>> Nope, that's not a correct chain. Apply it yourself and check results.
>> this series is dependent on the series to add support for IPQ5332:
>> https://lore.kernel.org/all/20250220094251.230936-1-quic_varada@quicinc.com/
>> which was applied to dt-bindings
> 
> Your comment is not relevant to reported problem. Instead of
> disagreeing, why can't you try it yourself and see?

I wasn't disagreeing, but I now understand what you mean. Thanks for 
highlighting it and I will fix in the next version.

> 
> Best regards,
> Krzysztof

Best regards,
George

