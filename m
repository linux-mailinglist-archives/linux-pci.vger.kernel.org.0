Return-Path: <linux-pci+bounces-39889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BFFC234AD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE68C3B512D
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 05:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1491DE8AF;
	Fri, 31 Oct 2025 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KxXG+JYs"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010004.outbound.protection.outlook.com [52.103.12.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F273B5C96
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.12.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761888905; cv=fail; b=ChCycSvm7yGmGqCxjGwKfyULfCPuprUCobOLDTAjZx8wxinNeg+AmPg37xZh+rZJ/l6EOo1A4lNkI1xvsywz9euBRNdAXRv/F/RyVRMtFmF1MV9OfJqgpH2BpePMR7jEZzx4CujfcWbfxPHlc1WCPTBpt/znkwh3vv0rFtShPic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761888905; c=relaxed/simple;
	bh=B5qF48Kd4T0GGvyu3F/aKAIiYEZl+HcgIwmMBA9UGrQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NefJ/NwdofcyTu+OcD6uQMk6fGavRwVFRmA88eIusdoxEQ1XFth60uO14rwJdjFmUxLDWEMurVU1exfnp5pftrLfbBcE7He1vFqYgCo06CaUw5kurf/ayGlACDTE1doq5JW9ZT4UAYWIRCIyLaC51KEjZDDXjOPUPKM/PGBvGG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KxXG+JYs; arc=fail smtp.client-ip=52.103.12.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sm/DXW7Q71mddtbwEQvKuLtJTm8zyplvkJNxsNYlhx9Sr0emnSwU6E39051FF8k9ZWgUY1QJFclbV1T+UpypHQcFJ6lliTmwZlIynNSxFxPlMurGdusa2titk/aGLpG/p2kdGt6OB4uCuDPutD8ovjx/4wv3pmwmx99jodei83sA8cvWo5zb8Stsuk5ML8Ab/C+se3pBPsgzCSCr/R7/hugT1D+ExsOJqZo9zDlctk3bX1WzeMtQh8KKgT53qyXQ7lPGharVq3TiBB7vbCRWx/Qu4orX8ZjCKSxyNNvSbvGrSgX3k1YKEJd0CGbE01nB68LbvknufdLp7rsfUD/vyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9An2B4gVE6M3/uZVRBIB3ujMNHLIsTKpsfWSM3i90g=;
 b=umGU2yq3Hy7/2wGBTWHi0a9ZGDeL9KTr2ELXZvgnkHEJE2ziWMECyJgPLPg3FufVOCZfwu5FlCd8fZgAJeJgR7JyHiyIKMTrYphHWd6TaWcn3FyCO/+S6wldorVGvnL4GNhajuDRrxDvINi4QsVSEa+qwDWNG5naWHHNHL8o9s+k9xzPWiviyAiHBFtkdiZESSNswHkbTTJPUNWrX7b2/i3/GnUDmWP+fRTvvazsGkMBxQgWihNSHk8G7spSNY5V7q+YuxN77AQKmJkqX/Dv2yTPJJzvgSmUqJRJvyz/MkVVRP4sGDaEdvZiM9N+le4x3KbOzrrlCQi9UU/HuP84HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9An2B4gVE6M3/uZVRBIB3ujMNHLIsTKpsfWSM3i90g=;
 b=KxXG+JYsIfXGLeEHWY8rGPxiw0tj4s+UyD5yCQFLVADgxKJZldoOT7OOR6uq/Kr95YkNCCihmtQQtYdopdqMX+H0ItQLY/db0Jq0AaUkn6Ev3gwK8gYIDetsAICOJ2gOubLvzX6QGm/pKO7MTnqoSx81t5tr9aXzQO0CrFbn5ZKqnatT7I7guLM8Kx6OvG2KTPC4iJdlNAZi6Bw544qAGQscofgkfyJbFtecYE2eK02BmIu9XmOpbJPPkSyMMEGmqWFGe60fE5WM9A/zUT1KZaDvvKzcad6QBqw6JqeQnjS+701DZPlepElLYWMNMV8vpA5dG1YBAsBF1RWeyyIyjQ==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by SA3PR05MB9667.namprd05.prod.outlook.com (2603:10b6:806:312::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 05:35:00 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 05:35:00 +0000
Message-ID:
 <DM4PR05MB10270506AAC1FCE53C4915CC2C7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Fri, 31 Oct 2025 13:34:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251029171542.GA1566240@bhelgaas>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251029171542.GA1566240@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To DM4PR05MB10270.namprd05.prod.outlook.com
 (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <593551a9-4716-4630-bfd2-8b13582ec5c0@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|SA3PR05MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: 15df0ec9-feb5-4c0d-0dc8-08de183f3a74
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799015|5072599009|6090799003|19110799012|12121999013|15080799012|23021999003|8022599003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OENwcGJQT0d3Y1hBY0h4TjFDYVRKRkVNV3ZUa0tsVjk1NFVDckFTOGcrWWRn?=
 =?utf-8?B?dG1PU1VoLzZKME5hVjlCVmRKSFg5MWtVK3lOdkhvM2VldStTbXlNNmdFS2dI?=
 =?utf-8?B?LzdsdUtrdGMrT2IycGN5aWNsQnJxTFUzK1pvdUE0ejFaaFJPVDFoRG91THR6?=
 =?utf-8?B?WjF2eW9NZmZ0cWdEbEtyT2N3d3lOZHQrV3R1bkZkSjJjNlA1SENlKzkwZWlJ?=
 =?utf-8?B?a0gyM0w1UVp6TG1acndUWFYzVUpXZ3lvYmQyeWEvcm5zVDNKYklaTTJ4VGh2?=
 =?utf-8?B?Rk1XMkd2R3ZjR3JNL2xMTndBVnpkUlN5OXpQdnd4T3NOU2FtS2NUV3g0Y0l4?=
 =?utf-8?B?aHNrelZmcmxwb2dEdkZ2MFFoUGNxRGtscUxoR2QxNjgra25mLzZIQjlyYTNu?=
 =?utf-8?B?MFhLVHlxckk4OWg4aVhLM2JtZUY1aWZJL3U0aytvT2cyUWFHQ09xV0s0Z3Jq?=
 =?utf-8?B?eXI2QjFWV1VZOERpWjgzdWtYSWV6N3hWMUxpcWhtRXRvdlNacDViYThXeHh4?=
 =?utf-8?B?cjZoS3VSUjRVTDkrZ3YzZCswelNpSm9XTVFvdTRqUnhBNmJ5aFNybCtWQWtt?=
 =?utf-8?B?RUpUNWozYW1HWlczQjJ2K2N2RkZyV1ZKRFRMbkRMTS9XK0Y2YkF1bE1BT25J?=
 =?utf-8?B?YUxRTnF2T2xwTzdHWGJuelRGRTlMaWlvQ24vVDhsa1hoZVprV0VrNVZMS0I4?=
 =?utf-8?B?RGZzWnhuZFl1UXRmc3NQcHdiOVh1eTRzdmJ5TUZjcUIwZTV5YmZlSWVjUFdo?=
 =?utf-8?B?OXR2bGZLdjV4YVJJTlExc1grOUZPRDd6bVpmaCtLN3h3cTVDVEFGUnAyRmp1?=
 =?utf-8?B?ZnF6MklFc1dlUmR5Qk1hRVJEUDA0RU0xZFlYNU5ES25VUjFuMWdZYjBUOTky?=
 =?utf-8?B?TlJ4d2VIc0FMelFFVXd5SVZNb3JqT1ptZFdZS09NeWtOWXRTYlQwaVNza1hi?=
 =?utf-8?B?WDdta2U1b2JOU1p4a2ZNaHhNcjVDVzBCTW1UZ0hWSHdpN0hwTU12OGk0OHB4?=
 =?utf-8?B?bEZlR1FlR3hlUDFpNEFlM2lBMlhiSTVNQVJrNWo1VHhTOTd6d2JBb0xTV0x5?=
 =?utf-8?B?c3JqOEd4TURHYmFuY2ZIKzVGWkJwSTFLOFgrRWovUEJKdlJPWlJDVnlTcWVB?=
 =?utf-8?B?MjBKN0JNSElWUkZDVWY4Y1FvallKU2hRejhxSjFpTzkxd1BMYTBtK3V6bWJJ?=
 =?utf-8?B?QlJNN2dZbmR5dyt3SW9FSVBDak4zOGgxUVNmb3pmZU53VzRwNmZIaG5DNWNv?=
 =?utf-8?B?QlU3KzhSUG5WN2huSzk4VUdPQ3ErZFVyNDAzbEtsV081R0JxbGsyMGZXMm1v?=
 =?utf-8?B?WitIREdtSExxSytvYjJlY2xjUnErVmVhYkZTUkNFOE9NOXUrSlpxNVlDYlJq?=
 =?utf-8?B?WktkejZNVDh5ZGJPRnRJN2JUTE5SVElHTDNtTGhMZVVHcHJ0VTd3QnZwSmpn?=
 =?utf-8?B?S2FrbzdsT2JsUWxYK0IxRVBKUUJvYXN1c2ROTDg1bjRROTg1bGxlRnBEbWhI?=
 =?utf-8?B?akFaRVVhOFBKd21yb1NLMkc0TTBRTUc0WWFYMlJHdkVJa21tSnBnQ0NhZWVL?=
 =?utf-8?B?RzVNZW9lQzkxcXdUeUlZY3lwbm5Ka3llMmFTZmlKOU9iQlpGWm94UTFZSHBy?=
 =?utf-8?Q?THZa5f9ebjl97vbvhqPpckkqNrTyeTXPpTNjP4+7EOt8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTViZzJHUTJ4NUJ6VDM2Y2VSMW5KbTZQcVNIcTRjNUUwRFRRR1kvS1RsYVNQ?=
 =?utf-8?B?bStXaTBKWXRndDl1SFZlR01wQ0kwTElMMW4rMGlJeGFTQThVSXV5Um43V3Rk?=
 =?utf-8?B?TlY3YzhRcDZ0azJoVUtTVHlOTXBVREF1M21KelBVaCt3Sjc1ODQyQ3NMcmFG?=
 =?utf-8?B?V05OelhoYS9wUElTS0FIVGxSK1MxZ2xqeWovYnJubmFHelRnWExSVDVvOTZU?=
 =?utf-8?B?KzIzMXdUdkM2MWIzb1FzZTkvWXh3Uy9sOHVyTmtlL29tWEhPYzl1TGNUUDRx?=
 =?utf-8?B?R1lydVBlRWJlRWZmWDcrcis2aENqUUlzbTRWRDNZWGdvb3VHOXFkVXo3V2Jw?=
 =?utf-8?B?UUM3Q1NrcnpDbEtmWXFNeTFFalUzeTQ0SlZXVG1qR0M1dFJjOWRIQXUvQzZT?=
 =?utf-8?B?ak1ZZ1FIMlI1cFlLeklVMjBmTEpaUnRHMG1jK0VlNkNINkhTVlF1QitsQzBs?=
 =?utf-8?B?Q1NOWG0yOHJxc0FUWk5XTi9jZktuMXhwZExBb3ZDaEdRTGdjZ244R2o0Q3FR?=
 =?utf-8?B?d0Yzdm15cXBnVG9uYXN6TmxzclBwcGFabVcyaktLalJMd1lLbGIyLzNuTzR5?=
 =?utf-8?B?alJoQ3FLb2c2UlVScExOLy8vZWVuL1d0RktKUElNd0tMeVZaQW1CdlZ6Um5Z?=
 =?utf-8?B?NHk0VjU4cHNFK0QzdkVrdjZ2VytnSnlLZlhHV1VYNUkrZS8wQXpwc0tOS3Za?=
 =?utf-8?B?K1lpT3RidktyVWtFOUhoSk00Wlo5N3dJK2tVSzRXUStxMFBZa0dPN2NPTFp3?=
 =?utf-8?B?ajRhcXRyZ1pVSWYxcFQyKytTMmlZN2NpL2h0Y0tNNkh4Y0xTaStCZTRUb1lE?=
 =?utf-8?B?OVp2Szh4TzZ5Qmdab3BqVTRqakRZdWxCV0g1SGlVUURMQlZLNmx0SUNHemtB?=
 =?utf-8?B?SEdlbnp0UkJQVnhPUVNiZGdQdmMxd1BKaWJST29ERk44K1BUbU15VDdrNE95?=
 =?utf-8?B?Q1MrdTdFZlN2YkpYeFgzVkdvRHZtdGorOFV3dGlnaWJHWmZhSFlJb3JVUlRY?=
 =?utf-8?B?Q25lUG5iVmFCcmEyUkROVG5JUFZFU1RqQUtacUpQa1ZNUURrOFV5OWMyTXVY?=
 =?utf-8?B?KzNEaDhRbjRhVFhqM3oxc1BOcC9ZYmJzUTFCTXptdjk4aXBzSEhQU01UZEtX?=
 =?utf-8?B?bW1obzBwSnd1QnpoRDhYN3puRlA4eldVNmZsTDFzVXZmTzNKcnRYbU5TVVQw?=
 =?utf-8?B?dE83WWVBdU1kdTNUcnVXSkVyQmlVeUM0Mk9CL3NldFVMUWNqWlR2Rll0eXdo?=
 =?utf-8?B?ZldqeUYzNnV4ZnJldnFQVjZ1TnNJdFpoS2NUaDM3azI4WHBTbDUwc05LMmkv?=
 =?utf-8?B?UXhYRjJIazU5WkRmVFQya1RXRkNtbXFwQy8xV3BhYXlCUTBJZWdsZFJSa0lN?=
 =?utf-8?B?ZzVyMzB0OXJEeUdJY1hNOEpYV05pZkExay9hVlZZUGY5YlQrbURicG95Ulo4?=
 =?utf-8?B?cytmZGg3WERYQnFlRFFJa3h4V01NTWw0QlVyNW9tSGQvSUlLQUZBZlVTTXRZ?=
 =?utf-8?B?TkpCR2RUd2dHam9QTFk2bzVhOGNMZmRXeFRpRW13ejFlaXJLQXA0bVZzd2Y4?=
 =?utf-8?B?L0xrWlROR1JTWFY0U1JUZy84RlpBa3BxNnA2K1FWVndYcGErUTlKeG55bEFR?=
 =?utf-8?B?NE5DbEpqeHE5bm5HYlNkKzFMQTBud2pYQ21BMkFRNmtvUVFSMkdKVE9rNm4y?=
 =?utf-8?Q?hujICBbx4KGdAZxyVyUn?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 15df0ec9-feb5-4c0d-0dc8-08de183f3a74
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 05:34:59.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR05MB9667

On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
> On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
>> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
> 
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 214ed060ca1b..9cd12924b5cb 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>     * disable both L0s and L1 for now to be safe.
>>>     */
>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>    /*
>>>     * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>>
>> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
> 
> Sorry, my fault, I should have made that fixup run earlier, so the
> patch should be this instead:
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..4fc04015ca0c 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>    * disable both L0s and L1 for now to be safe.
>    */
>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);

L1 still got enabled

# dmesg | grep -i -e pci -e iwlwifi -e aspm
[    0.130298] [      T1] PCI: CLS 0 bytes, default 64
[    5.243878] [     T48] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.294697] [     T48] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.298580] [     T48] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.307484] [     T48] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.324258] [     T48] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.366020] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.371376] [     T48] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.375932] [     T48] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.381390] [     T48] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.388280] [     T48] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.395226] [     T48] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.402942] [     T48] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.410068] [     T48] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.416900] [     T48] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.422838] [     T48] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.429605] [     T48] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.437147] [     T48] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.445853] [     T48] pci 0000:00:00.0: Disabling ASPM L0s/L1
[    5.451334] [     T48] pci 0000:00:00.0: supports D1
[    5.455104] [     T48] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.480231] [     T48] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.490539] [     T48] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.503464] [     T48] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.525959] [     T48] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.534845] [     T48] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.560448] [     T48] pci 0000:01:00.0: ASPM: default states L1
[    5.603416] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.606141] [     T48] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.636768] [     T48] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.636812] [     T48] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.693932] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.735461] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.778011] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.820548] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.821633] [     T48] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
[    5.870950] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.913471] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.914547] [     T48] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
[    5.964337] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.975124] [     T48] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.988201] [     T48] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    6.004583] [     T48] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    6.018790] [     T48] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    6.032400] [     T48] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    6.033164] [     T48] pcieport 0000:00:00.0: PME: Signaling with IRQ 24
[    6.045204] [     T48] pcieport 0000:00:00.0: AER: enabled with IRQ 24

# lspci -vv
00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 24
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: [disabled] [16-bit]
         Memory behind bridge: fc700000-fc7fffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: [disabled] [32-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         Expansion ROM at fc800000 [virtual] [disabled] [size=64K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA PME(D0+,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                 Address: 000000000935f000  Data: 0000
         Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 256 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <1us, L1 <2us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+
                 LnkSta: Speed 5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                 RootCap: CRSVisible+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP+ LTR-
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                          FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: ReqEn- EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr+ HeaderOF+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
                 RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                          FirstFatal- NonFatalMsg- FatalMsg- IntMsgNum 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
         Capabilities: [148 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ L1_PM_Substates+
                           PortCommonModeRestoreTime=55us PortTPowerOnTime=12us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=55us
                 L1SubCtl2: T_PwrOn=18us
         Kernel driver in use: pcieport
         Kernel modules: shpchp

01:00.0 Network controller: Intel Corporation Wi-Fi 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] (rev 1a)
         Subsystem: Intel Corporation Wi-Fi 6 AX210 160MHz
         !!! Unknown header type 7f
         Region 0: Memory at fc700000 (64-bit, non-prefetchable) [size=16K]
         Kernel modules: iwlwifi

Something else I tried was to boot with pcie_aspm.policy=performance so the link and device can be initialized, then

# echo default > /sys/module/pcie_aspm/parameters/policy

# while true; do cat /sys/kernel/debug/dwc_pcie_fc000000.pcie/ltssm_status; done | uniq
L1_IDLE (0x14)
RCVRY_LOCK (0x0d)
L1_IDLE (0x14)
RCVRY_IDLE (0x10)
L1_IDLE (0x14)
RCVRY_LOCK (0x0d)
L1_IDLE (0x14)
RCVRY_LOCK (0x0d)
L1_IDLE (0x14)
L0 (0x11)
L1_IDLE (0x14)
RCVRY_LOCK (0x0d)
L1_IDLE (0x14)
L0 (0x11)
L1_IDLE (0x14)
RCVRY_LOCK (0x0d)
L1_IDLE (0x14)
RCVRY_LOCK (0x0d)
L1_IDLE (0x14)
L0 (0x11)
L1_IDLE (0x14)
L0 (0x11)
L1_IDLE (0x14)
L0 (0x11)
L1_IDLE (0x14)
L0 (0x11)
L1_IDLE (0x14)
L123_SEND_EIDLE (0x13)
L1_IDLE (0x14)

The card works just fine. I'm thinking the ASPM issue is probably from the glue driver reporting the link to be down when it's really just in low power state.

