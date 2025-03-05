Return-Path: <linux-pci+bounces-22989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F60FA50572
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42DCF1765C6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760781A76AC;
	Wed,  5 Mar 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ervejHsf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2039.outbound.protection.outlook.com [40.92.19.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A246619E965;
	Wed,  5 Mar 2025 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192902; cv=fail; b=UB75HXmrbA5MK/SMbTXnNQieaXpopwWQxZgi4aYUzHtFDkBcg9jiHQLQqlfXTpVlGvLS17ShxqrWfbgPhvy5pcN6eqPKNO5CF9gbt2wGWZsPZIQ3zzWxSrHWDSS5VoEyX0+ABIOMKUslzntPH7TN31ZOBuhUHFX5SSeVgI6Dme4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192902; c=relaxed/simple;
	bh=VSqmdyVM892Rn7NMoGsEXfBj/vABq7pFBJRKiKzvVKk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hjKVnE2kOkdQLi0s9WF3Wwc93mkaRoB1ZWN7OZJPGn4L9Im5OzSDLK4WpR3fQkDx5LzGRX+mN8pwyBA5ryTZujbjaFGBkoAfgsc3qr3m6JKDXsRmDDZRrPBkG9gvC4LZcgwbM2RBnOIibrb5NDxFCks0oMgU5jvHvMA0fEOMFbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ervejHsf; arc=fail smtp.client-ip=40.92.19.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNS3LA6UJM1BpahwlG6afLarknGnnVeFlHlhzZ4dhwVsenbCfShYe/QESzWAY640GB7J+zFlCRSyRJjhDeR0uaPYfv6VxJU2Ixwc3GaIuCTs7IFH81IaBeGZDX6X/oFYfAh5ykYr4D7utiq3k6hdlFi5QNsLDwmLztCqCcq1TL+v5JwVogTWRd6t+Vp2Tm8rSMgUrzAr7nMBCEjAAOgOK0nD9DAQwjMOe1N3sC+VxmydEWM9VtjCFMx3XEh+nJlheRZfBYJbHO/Q1BAaNUrxB/FG+MjoxX2pnFqwblIToaNmqkLqUWRH5kV5vsOxAPFl1FWfvVQJK07Om4Piy7LeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Uel5AP0Hf0xYH3Vqj+kswkDCLqdXYKjXFqnuffM19s=;
 b=PVlXLJC/KRsZaq4i6aCW5zpjpMohwgdckl81lGjHnjNrGVlb7mxj/gY0x8FJV9Nalua1yfW1UEwBoJCmUuSjG9BjFHpsd93iZCJj5regbC3Abmb7xoXAMs3JbodtkPTqbFllkz5jdnWIYrvFopMoAgYKfOxhM0sRjx1t/Z95MNDn40yFpZkOpfmCvZLBWplPL6M6/nEpClhRIl0sLcK37DxbPmgBQsdiBHuS+zw2QvQty1QOsfI0l0zj9Ndjk1iyMdZwUk1t+43XU4fFvtIXtvzJzn36tKPXDkkdQ1d5TZ6w5bTBgz+AIG998E/RX93bgkwgz+7FuAaaGPgDq05yTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Uel5AP0Hf0xYH3Vqj+kswkDCLqdXYKjXFqnuffM19s=;
 b=ervejHsfRkZ0gbAAvbgY6tWbQz+M7A3zkQPg6JQR8BviZDyZyreHD1H3TbW+pruET8zxzzbBKB/D70I0xK0JNDRaxAFWjkWlrQ8JkbJHB9dyKP+2/yqZNk9UbI18ThUpa3WuvhnICu3WLurLEmuk1dpQCfFXxQkVgfnvx+EE8F3BtUh+spLUqj2tXMuoShWt60vIHD2SD6WUeJICWHPGEhXdQR1U2xATaDg4gv5DOUmXIf+BMUgYgwxvVfOGEHlZMMm5G5c93doiamPGGfjVrc5iKW7Dq+MNTQXOglEbzvO+o6k0yrMCLURPtUG8EIdsh8iqDIWJcHDUp6FahIVN5A==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by LV1PR19MB8898.namprd19.prod.outlook.com (2603:10b6:408:2b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 16:41:36 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:41:35 +0000
Message-ID:
 <DS7PR19MB888309B506D25ABA03F218EB9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 5 Mar 2025 20:41:24 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <a95b4c01-9d8c-49eb-8242-93ae411caec0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0044.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <5fb93121-c8e9-48fc-bb06-ccd95996aa59@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|LV1PR19MB8898:EE_
X-MS-Office365-Filtering-Correlation-Id: dbe5427e-fd93-44ec-6af1-08dd5c0497b8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799003|8060799006|15080799006|7092599003|461199028|10035399004|3412199025|4302099013|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG9kUHlnOUs3ZllvNDRoMmxmMk54dDBSZlZYajhkTHEvTzVrRXl5L3pZRjN3?=
 =?utf-8?B?eDNIbXFXa1diTERzbDIxMzNpZkdhZUZoc1dUNUhNNlVHSldWeW5OcDFvSmI4?=
 =?utf-8?B?UVJubzVQeWlHZFBGU0FtdjR1V3N5bGZmUEFKOTlOSU1CRFNML1NXakhLdEYy?=
 =?utf-8?B?NFhScWtWb0JGSkxhbmNraDNFWGd3SFVvaElna1JNTjdZWkpwQXRtQklGdi9x?=
 =?utf-8?B?aFdacEo1ZlZhR25ndk51ZFFKelRuS0JvMjJPa3NWWERrOEZiYkhxcjJzWlBT?=
 =?utf-8?B?bDlXWXQ0dnJPRS9NRDV0ZVFMZ2hKSkZwa1UrNnNWMmM4S1NMTFh6RDZUWjN5?=
 =?utf-8?B?TmoxaFlhaWhrOWh4SXZrSllZVGhnNkJ6eE5KRFRmTm1kVmFrak9YOStNcDNk?=
 =?utf-8?B?UGpUY1lqZUVmc0FTNVhQUmxDQm9Kc2NjVTZPZHJGd3poODdDVHFneEdqclRz?=
 =?utf-8?B?SEZZamZFMGRSL0lCeUx2dURXam1rYVd4REFLR083RkVTSnpCTGJkOE9xUzZE?=
 =?utf-8?B?SHRqSlFHUXkzK0tyZ1VvNlJEc05BUnJETGRWOW5EUFRWYmFUaFBwakdSTXRl?=
 =?utf-8?B?a2gxNHI2YXJ4c0Q4Q1hyOUhBWHZ6ZWxpdG5ScGt0S0g3K25ZaGVRL25scVlz?=
 =?utf-8?B?SUkxaUtEb3R0c1ZKRDdWc3ZWS3AzMjgvUU1kQ1dDM0V6YmRmZkFsa2pnWVRZ?=
 =?utf-8?B?MVJZSXNwZXlkY2xMK0xGbGduR0tTMGJnZHJVYWJxV1l0K1g5ekVKYzlaS3ll?=
 =?utf-8?B?SkEzTWhmTVZDZHFsdnR2YytFUk1KbTVHU1dhZ2kwVStGK1IvVnNHZGgrOEdG?=
 =?utf-8?B?eHR0WmZoMWN0aEM1cFowV1ByWE1ZNVNJSG5LTk9lZ0pZTGQwNkFaRHhLdjVr?=
 =?utf-8?B?Tk1sS0k2UEVkYVJwT1p5Q2xvUklUQjVYSEVQZW9ZTjRrK1Mrb3FBdkVQMnN1?=
 =?utf-8?B?aTBVY1ExYjM0OXg2NWV0V2ovTDNhaVZDV1lyMFpDWVppRUtqclJ1Tm9nNkww?=
 =?utf-8?B?T2M2SkJWWU1KMmhFdXFqcDluNHNFKzRGcVAxZFVSeUswcWNhSDZZQ1ZhalBF?=
 =?utf-8?B?WmJ0ZGdFNkpQa2JDN1ZQVVdrOHVKaXF6YUNnOGpSeVZNbWc4ejRJUFkyNUpw?=
 =?utf-8?B?VXVnSFg2Y2Jtc01xL1h5VFFDdjRjR0tHOUFhQjlJbzdGeThLNkMvS0daaHNX?=
 =?utf-8?B?ekNyUmJJUDd3Q3ZUOUNrOVZ2ZTdwSExEdFpONzJWd3orc1QrV0h1Z0o1aHF6?=
 =?utf-8?B?bTgwL2o2UjFYMzg5eXczYU42OXY4T1B1Wko4UVBONnZBQUtOL2xDNk5HMmU2?=
 =?utf-8?B?alpnQjdBN3IwVTRxU1JvR3huN0V3LzBvUGtyWUlEZnYzRWFzQURxUVRDSFQ5?=
 =?utf-8?B?T08rd0RCTExCbVJJdDh6SXJOUUV4cldnSjBtSjB4RFlac2d0cGk5c01uV1A1?=
 =?utf-8?B?WllieEFjdUZ0eXJMUG8zQncrL2hXekhMTlVIR25pMjM3bGZISzlaUmk0UTVN?=
 =?utf-8?B?T2kvUUxKSkN5OEhRTGd1UDRkUm1sOUp4SWpRNzBnWDlXb2pDcThoNEpCT1JJ?=
 =?utf-8?B?V3E3TjJSNlIrNmgyY1hZdWkvSVowNGFJUHovOFlLeEpyUTRYaVBodmh5NjBE?=
 =?utf-8?B?MlMyZ0g0R0JrWUhkVzZhdmdndEx5a3dqb0gxaGwrNGIzWXZzZWN3MkZRd1JC?=
 =?utf-8?B?aUd0SG8wUU9GVStSV2UvMExzQ0N6d0h1d1ZrVmtSTVhLcGJDOUZLaGVRPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QThrOEREODdpOTJDZ3dONVlVazh0RHZpN01mWExTdGdsblhadVYyb3VGcC8w?=
 =?utf-8?B?cTEzN1RUQ3BpNi9paGdDaTJFc1B3NHVNbSszNlN1TUJCZFFHZEtDRkwwMTd5?=
 =?utf-8?B?NllIdFVueFpjeThDS0JnY1YwOW1abHIwWGprZFRRL0k0ZFo1ZUhrMTVlNXhJ?=
 =?utf-8?B?QzZudlk0QXZ2akdDampYTm5mdXU4MHAxbDZjRDNmVmsxUWN6V1ZYOTRIZS92?=
 =?utf-8?B?ZUJFeVpUR0RFaDd4akZZMDJURFZ6V3U5OWlqcXhpbnBiMUxuR3ZFOW1BZy93?=
 =?utf-8?B?MFp0MzI2ek0yT0dGVGo2WGxZUlB1TG5obXVlb3A1aWxZTWVveG0xTk4xc0E1?=
 =?utf-8?B?Z1B3R3ROeThONkIwY1RCRkJxK2t5bnNnMGtxWGJVUWxVY1VxakNTbkNpc2NM?=
 =?utf-8?B?VXN4QVBKOWpxYW80dHQyMkViL3h6SXV5RGRoMC9YTFlPaENWdGpWYjVYTWdm?=
 =?utf-8?B?N2FPYklMOTRsL240MHNwOHVyWENjMU02dmt3TDFjVlR1WFMxcGhLVE16c3Jp?=
 =?utf-8?B?YWxCM21DZzgvSDR0K3FzdXg5MzRqNUxENHFaTkRvQ0pja3Ewd2lENzNCRnBi?=
 =?utf-8?B?c045NkNSVS9lUTNTc204aTh2eUd2NTJsMkNIY3ljZGVGUFJLS3R0WkoxNElV?=
 =?utf-8?B?L2swaTNnWnNEc09FN0RTbEVMcFBkazYxVDVWajc1SDJYdVh6UGMxWmZwZzE5?=
 =?utf-8?B?dE1Kc0M2WU1aZHV5d2ZweGF4NEFOWnRlM2lDVEFUTWVIcFZsazUrakJvN2RO?=
 =?utf-8?B?TU5jbmhJWjE1Uk03bEQ0VHU4WXVsQmNEdC9iN3NrYkd4U1RVQUxhU2ZSdkdM?=
 =?utf-8?B?endZTmtOVmtWalVvNWttY3pnTjN2OXpXOU5vbmtzUzFuMm5QRllIMzh1YXpJ?=
 =?utf-8?B?SE9rbmdEdHJwdVhhd2JVWUw4QlJab2VWWUUzRFRRc0QrSHNrc2ErcStOY0pV?=
 =?utf-8?B?RkRvOURrUytRWHhoMmF6YVh4bTd0Q3hJZGJUUGNMNjF0SlJqelUyRjhmc3N0?=
 =?utf-8?B?L3orbGgwSnNMWU9vdWZtTy9kZU1IZVE2V21oMVhwRDVjRTBpcTFHb3puZ2NW?=
 =?utf-8?B?SzIwOHZkWS9zMXZ3b2Y3TjJtQ1NWVU9Ta21HTjVJZTNoZzA2TElZUGlDSUZv?=
 =?utf-8?B?Qks2TFdaalZkZlRCVXBQZ2hPYWNHc3hnRExYTytTQnBYblE5Y0Y5ck9jeFdh?=
 =?utf-8?B?S2gyWWRoOW5CM0xYYXBKNFJWVU0yN1dOemNhV3hVVzllR3Z2djAvYWlMaDdY?=
 =?utf-8?B?L2w5ZHhmNnpsWlBzb1RoY0d3d3RLNEkydU8wTU9ycW0wNnp1S2NwdEhzY2RU?=
 =?utf-8?B?WkdKUmF3OTBiWlEvOTgzOVFBR2tmMmlkWFRGOWcyNVNKUk8vZWQ0S2FCVVg0?=
 =?utf-8?B?cjZZUUhxai8zK01BUmU1UXFuVzlCa1NXUE94a25wOWpoTHQvZ0F0dmc3TXlm?=
 =?utf-8?B?aXgrU015amloYnpGWVlEeUZpbnRSNk1JMzdlRFpPcXVlc3d6S0lKd0UrcSsz?=
 =?utf-8?B?UlpsVDZsOXp3dFNaV1MxUHRmd2MyQW9kVk1tWGZqRkJNcHJlRExMS256V0dj?=
 =?utf-8?B?MzJmamxqYk56MU93NXZCbTZZa3ZUNy9GOTJ1RzRCNjhyTFY4bXpwcVAvU0hV?=
 =?utf-8?B?TFI3T1dvejhobmlqWmc0M1RVemlxcytEU0o1N1k5OXhyTDlGSHVtMmR0MnZ4?=
 =?utf-8?Q?11f2JKhJnAgsCFV5SSho?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe5427e-fd93-44ec-6af1-08dd5c0497b8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:41:35.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR19MB8898



On 3/5/25 19:51, Krzysztof Kozlowski wrote:
> On 05/03/2025 14:41, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Nope, that's not a correct chain. Apply it yourself and check results.
this series is dependent on the series to add support for IPQ5332:
https://lore.kernel.org/all/20250220094251.230936-1-quic_varada@quicinc.com/
which was applied to dt-bindings
>
>> Add support for the PCIe controller on the Qualcomm
>> IPQ5108 SoC to the bindings.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Also not really correct. I did not provide tag to Nitheesh patch. How
> the tag was added there? b4?
the RB tag was passed on from here:
https://lore.kernel.org/all/20240830081132.4016860-3-quic_srichara@quicinc.com/
but I'll drop it as it changed quite a bit since.
>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
> ...
>
>> +        reset-names:
>> +          items:
>> +            - const: pipe # PIPE reset
>> +            - const: sleep # Sleep reset
>> +            - const: sticky # Core sticky reset
>> +            - const: axi_m # AXI master reset
>> +            - const: axi_s # AXI slave reset
>> +            - const: ahb # AHB reset
>> +            - const: axi_m_sticky # AXI master sticky reset
>> +            - const: axi_s_sticky # AXI slave sticky reset
>> +        interrupts:
>> +          minItems: 8
>> +        interrupt-names:
>> +          minItems: 8
> Why is this flexible?
I'll restrict it with maxItems in next version, thanks
>
>> +          items:
>> +            - const: msi0
>> +            - const: msi1
>> +            - const: msi2
>> +            - const: msi3
>> +            - const: msi4
>> +            - const: msi5
>> +            - const: msi6
>> +            - const: msi7
>> +            - const: global
>> +
> Best regards,
> Krzysztof

Best regards,
George

