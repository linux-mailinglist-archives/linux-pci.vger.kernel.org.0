Return-Path: <linux-pci+bounces-23723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8DAA60BF6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACF04601E4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481D1C84C0;
	Fri, 14 Mar 2025 08:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CZPaNvTP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2080.outbound.protection.outlook.com [40.92.18.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4D1AAA1B;
	Fri, 14 Mar 2025 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941778; cv=fail; b=HvrvA+iKD3pHBufR1sPJQqK09FgsbY+xU5Vhty3iSw4H7T1SFB8uY2nORBaWGJZ1hbNe9sDC111j7DtmoGn+PUNG3b9rOfNEy23csfTDrlvihSJfTEzUxgSjRFv6mnaoN8pnEyhKlhEOemHApKoQeIJCF/YOz+r1o3qdg7XTpN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941778; c=relaxed/simple;
	bh=etnW6AhG27u5Cd04RlT0eSY9FOwUBJJ2vq7UH0SsPoE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HuFjNRyWPrDOAlBcwvKg73jR96lEl3Q/kGEOJvCsUL1dYfBR6crxkbfxK+gsRQsFW+nY0u+ttcLOoagpf7KsIGSHreYN35/9cKB9dHzxwSKTxPBrsXdXYe6XylqQICUuLAMsz5CATc1HiwBWyXo49IX5mTiHA7eCuQRcssKzYgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CZPaNvTP; arc=fail smtp.client-ip=40.92.18.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QA2EkPzdOGqzAk0oOPNnG06pKNkIJhKXDPTpvppW3Nwxj+zvRhFJkHp3LI+bwrkIBmLluHGigrZEecqJjUssQkb9w6kr5/s7anCXwmoMFliQ8l612NaXe4OcYPDyRteKIsGW1Ra4K3i/BRM9uemOktrmPTdrIbCaDBSzB3M0Xt6da8HSJyjvkWChdMZj5N0CwB/NpHH5ODVCZFtAHUFvoKYBrNqKI7HG2FoUO3fq4c7RnppALOqOarvWGoIxPC7AW2dHMK02u8UMYKpNmDSAjDdTkSuqc0QK5jPyrywiA2MVjtxVcIxoqYc8h9eEonDfYDK/V7JTzCjHeSWG78nYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/v7WoCwnwjE97zXGbpDS63tNBIzXDOQf1nJcYvNhJek=;
 b=XL1E/uFMZETMb6Ixe0G1F/xYyYUHejb5ojh7WBq2WPmw9qzeyoflkStS/pIYkgeBYRHXg1X6HbhAie0PPBAu+zlhtPX7qeoKdg9vX1Ie6n3udhDTh2fXAhmbS6wZD6kCQYLIgM0PieOqazQQB4XXGlcaL2juj3q4HtG/KO1ZZnwntXJj+dr39YHBEX06YyuNHlqhAk3VOtZj4yqxVd3sV2rN2a9gp9YQlUnH2An1vHfyGoAET6N7hdmIMwhjJBUUyuoCfj5A8OTC2tA54xzVnjwAo7KXypNwF5sY6r//fJLdNtCurds3K/MgsHqGnLSUsowD6M5RKb+5wJ7yt9bfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/v7WoCwnwjE97zXGbpDS63tNBIzXDOQf1nJcYvNhJek=;
 b=CZPaNvTP0njmdrVX67yRUA1/KTlVDJDt6d8LVLrnYgYNTJk/wT/SJCR3EuuS+yYqL4WJXTNS+FsgFL85IxjCAdpWls6w4Fk+q29+hMbouxQtGa3nUyIjB2dH/QBN4WVlg5N/70peLesn6uRUcqD+3fYZAj+zCccn6OjTm0BWnCkWqdfW0bMpZ3RfEi6zLd+QscD+mzw+83octSBn2DZxRIAwyR+9/bS5/m3uRIMml+vql05riRmJsYYN051U6PJaxaEV5r6xgn9+BvIe6Gl0RaFSfTQ5vUWF0FJOQfQ9ei8kDZswvqi+KAzfsXyf9bUEqeNRTm3+H04qCWgPFok6Vw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by PH0PR19MB7602.namprd19.prod.outlook.com (2603:10b6:510:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 08:42:54 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 08:42:53 +0000
Message-ID:
 <DS7PR19MB88839F5961CB1C0AAC1902959DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Fri, 14 Mar 2025 12:42:41 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, lumag@kernel.org, kishon@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org,
 robimarko@gmail.com, vkoul@kernel.org, quic_srichara@quicinc.com
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
 <DS7PR19MB88834CAC414A0C2B4D71D57C9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314-greedy-tested-flamingo-59ae28@krzk-bin>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20250314-greedy-tested-flamingo-59ae28@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0087.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5d::9) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <904d5d18-55cf-40cd-a768-a69ab8f86c9e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|PH0PR19MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 00ffd402-2262-4a54-2f82-08dd62d435b9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|19110799003|461199028|8060799006|5072599009|6090799003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUp2dWJ5ejFHRjhBT2dYOTFoL0RjK0NZZnpHcGJIKzNjUHQrbGVENzAxdjFH?=
 =?utf-8?B?SVlxalErNElvMjFCNGpILzBBcXBlL2YwQkVoQTZVZGtIaVdXcW4xbjljZXR5?=
 =?utf-8?B?UXA4RVNjR2Fkb2NDYk4xZWJrWlNZUC9wWkcyYjh2aDB3QlhEcWkvUDVWbUtM?=
 =?utf-8?B?eUFGMkhyOEk0TUVYYk9majQyL3U0RWp6eXRwYnpoYWVueXBpaEEzTE4ramRp?=
 =?utf-8?B?NTZVL0E5M01FUkYrR0pRNW9kVHlveUNUdFBNT2lpYnNxTzB2YUNkUW42akJS?=
 =?utf-8?B?d1VBa0xoVUkyOFkwSzIyWW5UYkNBTlFYTGxZajVpQXgwTGhGNmxuSTR5Zk10?=
 =?utf-8?B?VTI5WWdwSTczaUQwMGVZQUhwWVZwRkpURjVrN0ZXMlFMTzhuZkJuRjNXaStl?=
 =?utf-8?B?OENuaUxJclI3TjZ0VE4zZVhLdzFKUFp6cnpDZ29xWVlhUEVLa2dqcW9yTUtG?=
 =?utf-8?B?K1UvR3UrZldtSCtIYk9rSS8rU3c1RWxHeVV5YXcxV0hSNDd2UU5ZSnNadVdT?=
 =?utf-8?B?WnpBc05LY0cvS0ViTXJybDMvcldOdEQyZFE5MDhBVFUrQUovc04vUUdDdXRv?=
 =?utf-8?B?d1UwZjlWY2JpeHJobjVwWngxOXN1Q2hJdmxiQ3ZKSXJtMndqeFlHVnJ3Ri9j?=
 =?utf-8?B?Y2NBY3hyY1gzbEViVVZSNkdiaEZUQ3hCM3o1ZjdNTVloYTdNUWY0WFVjV2tr?=
 =?utf-8?B?MDBUUVJtc3B0aTlyWEhEbWJITGpqdENtR2drWGJwZnVTLzRhMWQ5UnoyUXM1?=
 =?utf-8?B?ditVWXRYMkJrNmVIR3RGVTJxZEdSWDhEVnQwejBTaHZ1a0pWb1h1eVBXcHdz?=
 =?utf-8?B?cFEvNnh6YVNWZm1sTmtwNEJLZmFDODFuZzFWQTJzY1lOSkhlbnJYSTdDUzc1?=
 =?utf-8?B?bDFlZ3gzVWRMdzcvMzRXVjNlZ3hxY0RiZ1hpQUlST3E0NXRUWGxaQS9tNGZR?=
 =?utf-8?B?enV2MWNoSFltV3BReGppTTE2V1FjUTdTSVVJQ05tK0toUE1Lc2EwaUxiZVpV?=
 =?utf-8?B?YmR5YVdtb0gxRlR4amJPYUpUdGtJR21GM1JUNThrbGhTQ3hxTURITGJLSnBN?=
 =?utf-8?B?clZqQWFOSFhHTHNKYWNXRmxsYzZab0tHdnBseDhGNnNjNUtZTnhXd3lZYXpR?=
 =?utf-8?B?SEt0eGVwSVpHajhDa2hHUHAvRDJqeTZtUXFmcExiSzE2WUMxdWUyZXUzdGcz?=
 =?utf-8?B?SW5xc2IrOThBei9KRjhpZEVBYUpxQzJsa3FTSUFrYW1Ra0REWDU1c1JMTld1?=
 =?utf-8?B?R3BnUCtpSUxCTTRJNEx5dmhFL0VtUHdoeVY5cHZDbmlnS1l4T3hDY2NkN3pD?=
 =?utf-8?B?UW1vNzhWd3FWSzJ5TkxtQVgrUHFuZ2JBakpyV0dzeWtHZ0Z0SklUVzhJSGtC?=
 =?utf-8?B?NmJHK1ZjZWY4QWFLZU9MTHAyU0R3eHdYcENvanZPRzNCV0hPRGc2MkZXZys0?=
 =?utf-8?B?R2xNOWYzbHR4MWVERW96SVBmNTZ4Z0daazhmYm50MGVjNUJTczlNdzB0d2xJ?=
 =?utf-8?B?WitXZ1NTU3A3QndBaTlZeG91aWU1Zy9BcUVxakQ3Y1gwYk5ncTZvem5YYStZ?=
 =?utf-8?Q?yzyp29mUU2U96SkQKdAnufu6M=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEczeUJjYktDK1FnaURUV0ZvYVZCUjF2TmZ6RjRxaG5jYkV5M2JFbDJWWkdm?=
 =?utf-8?B?VEdSeGI0Y2JCcldMTU5sKzVRVWlXeW9BMFkzU0FTYjd6MkR4VHFxVW1JV3B0?=
 =?utf-8?B?cjU1QlV2LzIybW4rM1MyTFUwWHg1ajg5ZzJrbHVFbzBJTzZiSGkxVGlrcW1I?=
 =?utf-8?B?eWVhUE5ZWTM0cGFHMUNnMFRJNTk1cnBibW9kay9sYWVleFlGS1Ird2h4UXdj?=
 =?utf-8?B?QkdneUFXcmNQdUt0R2RuMzNWTU9HV0FHSWJSYmFWTXJLRm1XU0w0SzJITklS?=
 =?utf-8?B?YUZBbWViMVg5WTd1YTZoQTR2UGJZMGZTZVpRNExabE00ZG1LWCt5aXBhRHlO?=
 =?utf-8?B?VTh2UGRqbDVONUNGemNYMy9IczVlalJpUHlmR0dWbEd4L2Z1RHppemRxRDJ6?=
 =?utf-8?B?WGxYOVZla3MzVlpBdWdWdzNWQkFiZFZyYk5ZN2tOZ2UyT3ViR1ZOUUd2YlJn?=
 =?utf-8?B?UFRvakZ2MDN4MTJidTRQYW42NHNZa0k5dlVSakdzUllvaU1XbTFBcWRqMEZ0?=
 =?utf-8?B?QmFYREozUVBWajBrVXFYbVZZZ0l5TWdmd0g4YTFQWGZyWGNMQ0d5UkRERkN6?=
 =?utf-8?B?b1ZNOXdiYVc0clVQL1ROamlRU0ZMd2dBQUFSRkhwbkJOcVpXVm9iZUxSZWhn?=
 =?utf-8?B?c2VwYnBUU1ZxZVVvTkhacnBQa2Vpc1M0cERFbzYzQk5DV2tnR3A4VUU4OWQ2?=
 =?utf-8?B?Q2xFaDRUakdZT1BRaTBydEpwbVo2amN5WGRYZVRJVGVDU3FnL2FkSExDUlB1?=
 =?utf-8?B?Sm81SVVzY1ZBTkxiTlkrY0hDS0t4eTkybGtQL1FONEk0MWhsZS9NSTJZN25t?=
 =?utf-8?B?emZqYkNycmk5V0pWbSsxWkJxN3Vwdlo4bnZLMVU0UC8zZGN6enVwRmZYUHdo?=
 =?utf-8?B?TTZ0V3RwVStWbzh4Qm02Q2szdlFuRVRmWlo4YlU4dXZvQVNzU2NZYmJFS0R4?=
 =?utf-8?B?ekxidW1UVjZJb1FzTVY3M01LdWVmRmdEWkx1RTZsVDNQSU1mUFN0WkZFaXJD?=
 =?utf-8?B?VFZ1Skd6cU5JMTJPUXlmalVSOEFVTWtDWVRrVzlQTEZYRzV4Q0daVXpvb09s?=
 =?utf-8?B?Q3NNK3JidlgyeEJLdGdiWFJkalZlV1M5azJ4QWw2cVFiNThGUXdQbmt1Q01t?=
 =?utf-8?B?dWxqd2ZpVlVobGYrS2pmTzFlVE9QdzUvZXhvbVNiM2RXME05RE42amhWWUkv?=
 =?utf-8?B?NzVhbjYvZG5MeTlEWlptUFIrOXFMcXFkbEVLbVkvZkg5S2FCWnV3YnVsbWZy?=
 =?utf-8?B?bTdvUFR3eEViSnNWRnFReEZJVk9XalhnbDd1eVFsblZYV2I0SVp3SWFVZFVD?=
 =?utf-8?B?b3NBdUFwRHE0MmxPYnV1TlJyYlIwM0NYTWRVdytmSUlPN3BLU21rZ3dvcHNa?=
 =?utf-8?B?WVk2QnV2cmx5a29TOHJXczhYd2xIMUJSck15dEJxNGYyekRZcDRPcCs2RHBW?=
 =?utf-8?B?VzAxRHR5bVg3QTJsQ1QvZGRYS0d3aW5MT3NNMDZYVkJjV1ROaThMaEFybVpp?=
 =?utf-8?B?Sk5zZVdIb2VVTFhhZVhSRllXVnFCUEl1RGdlZ1daRkwyNzB5QitlelQ4YmND?=
 =?utf-8?B?dlYvUlhBaDJVd0xEVDM4R29rTzR0YXVwVEt0SWg4bWdRVmpaZzFJVHpUYTU5?=
 =?utf-8?B?RFlreGdqcXR1TE5wek1sN25rOENBYTFUSUc4bm1yWFgxanhJY3pwTmZnTFM0?=
 =?utf-8?Q?kl+f16ipQCvoUh6n2GH9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ffd402-2262-4a54-2f82-08dd62d435b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 08:42:53.8993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7602



On 3/14/25 12:20, Krzysztof Kozlowski wrote:
> On Fri, Mar 14, 2025 at 09:56:41AM +0400, George Moussalem wrote:
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Add support for the PCIe controller on the Qualcomm
>> IPQ5108 SoC to the bindings.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>   .../devicetree/bindings/pci/qcom,pcie.yaml    | 59 +++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> index 8f628939209e..d8befaa558e2 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>> @@ -21,6 +21,7 @@ properties:
>>             - qcom,pcie-apq8064
>>             - qcom,pcie-apq8084
>>             - qcom,pcie-ipq4019
>> +          - qcom,pcie-ipq5018
>>             - qcom,pcie-ipq6018
>>             - qcom,pcie-ipq8064
>>             - qcom,pcie-ipq8064-v2
>> @@ -322,6 +323,63 @@ allOf:
>>               - const: ahb # AHB reset
>>               - const: phy_ahb # PHY AHB reset
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pcie-ipq5018
>> +    then:
>> +      properties:
>> +        reg:
>> +          minItems: 5
>> +          maxItems: 5
>> +        reg-names:
>> +          items:
>> +            - const: parf # Qualcomm specific registers
>> +            - const: dbi # DesignWare PCIe registers
>> +            - const: elbi # External local bus interface registers
>> +            - const: atu # ATU address space
>> +            - const: config # PCIe configuration space
> 
> Keep the same order as other IPQ, so dbi+elbi+atu+parf+config. Same for
> everything else, so standard rule applies: devices are supposed to use
> ordering from existing variants.
> 
> There is some huge mess with IPQ PCI bindings, including things on the
> list. Apparently it became my job to oversee Qualcomm PCI work... well,
> I do not have time for that, so rather I expect contributors to
> cooperate in this matter.
> 
> Don't throw your patches over the wall.
> 
> If you need to rework the patch, take the ownership and rework it.
> 
> 

Thanks Krzysztof. I did reorder them deliberately based on unit 
addresses as discussed also in other threads about IPQ9574 and IPQ5332 
as I thought it would be neater that way. I'll change it back, reuse 
other sections in the dt as much as possible, and follow your guidance 
instead.

> 
> 
> 
>> +        clocks:
>> +          minItems: 6
>> +          maxItems: 6
>> +        clock-names:
>> +          items:
>> +            - const: iface # PCIe to SysNOC BIU clock
>> +            - const: axi_m # AXI Master clock
>> +            - const: axi_s # AXI Slave clock
>> +            - const: ahb # AHB clock
>> +            - const: aux # Auxiliary clock
>> +            - const: axi_bridge # AXI bridge clock
>> +        resets:
>> +          minItems: 8
>> +          maxItems: 8
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
>> +          maxItems: 8
> 
> 8 items...
> 
>> +        interrupt-names:
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
> 
> And here 9 items. You got comment on this. What's more, I doubt that DTS
> was tsted.

Will fix, thanks.

> 
> Best regards,
> Krzysztof
> 

Best regards,
George

