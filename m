Return-Path: <linux-pci+bounces-20237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC7A191CF
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 13:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A764188C8FA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86196211A33;
	Wed, 22 Jan 2025 12:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qvqnStu5"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45C212F90;
	Wed, 22 Jan 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550378; cv=fail; b=vA7UOUpKN9Vw/Ka5JyXKs6hKkQsx3f4qsSZ+KlFDwbcvpUhSWx8+NUfHncwNdd9m+A7yvQjD2Gjaju6WwnQkjHDbctHblqB9Nc78r06rpUEuwapV2ypz/shq3+XbV9QBcoONnNXBTVOWpX9oE1dcEzHYMVddHSkdcRI/bcqxzfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550378; c=relaxed/simple;
	bh=lVQ5lLCWQ7TKvKAIDoubhuJxLI2z2RhS27SOVPeaqBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JXgHSk+0PrtN79cqKBQQd/5SrRnhngrEnAPIPjgGiiWl+HxfToRykgsxtXR8vh56sYTkh124lGyk05CaZmWd0F+xk2DTFM4NS/8b4IXAfY9/6kIws7XSFmxYqrEInDaXPGVseJcedF8L/xADvyqHzyHC5QMXjwrYWX2ipnMx0gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qvqnStu5; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IS5YsM0fw6IN5oePQ2akfi16LKNlYGYhcm2X0xLPCJl+wQV1PY571gbECDo/yyOV8Juy3tV8WhLhzT7EWZLIzzSAMUbdurHIgdXGKf8g3jj4UYtlcZjPhSZPthRNOxi/IXePcYrVFPDVhpL0kRb1VKgsw5130WywsXMKYm/zIDNN2hRuJKdR69/NFyXEJ026T0n7gl7dzzvjSlemRT4OVXH4oUu8c+BNy2gw+jih66rpMggltNBluw7TOhAiTNjhO8bEBv+0hxCRWQeEpMVVHAoNGuojosGkovqQE1wox7ZpE6+keyAQtBPELE35QUaq8LbzQYz3G+MsN0GX/DbXlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biO5eoSMfYy1e5Yjd1THFJ5+Rx0eRSL3RlEaCAZWbDg=;
 b=btdQg9B3jtdCwFHSn7G8KUbVetKhlIHZq5AvYuywUkpKt6yOheifblDlJtD6uOlrGgYiWcnf0ATcp2/l4QbxuLAQ+KPqV02SZ1/EHni12nIzrJ6L28mSNYQ4f9sBnEqNV9eP43sByfbKqWz1fJHe/dLqDke/6eBg1w3EwAUlREEQ212Z5gJnQBGjNzpC+ctfHzNrCDuPSWP2IetHmS/M0wV8iRTk4c0kJFlQKIalyxRCCcytss/mq2v/R1RIvypFrxPWJcxJnktlU7mMpDykCKwU+7Lb+QHx6heA2OaPBdtYR452+uWtSJeDZQpjbYH7Eqr11IC5eTja8iv/dMSTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biO5eoSMfYy1e5Yjd1THFJ5+Rx0eRSL3RlEaCAZWbDg=;
 b=qvqnStu5c7VbplNiqLoLLtjtTjuohCnrY9pvSGROghZghntAvYJuKaTLIYkNu5aTVTHF+p0Z0k5h0avwhb81FKXEQekp9Y/ODqZ2WDgl/e7ZAPULBUXoehiF9EG0kzwwbSJ+pDEQDlM0JKw3hVy1jCABkmmASGW8tjes3RKH6aIOOB6ES3hOu75L7gng+f6dyE03rI6g5SWcJ7VTR/Vj265MbGGBzONwcvGlESNAYHlTR5YyGd/iNVEAyMVILjVGi2Kan9Ao1eoy7WWpSz9+QF2bweFBsWkbAhdO+vZuCWxZ6VKRZRukxoHVAsmfmeWWCOMm5XD5kuhQ2z2oW+gV0g==
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:44::15)
 by MAZPR01MB7184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:47::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 12:52:47 +0000
Received: from BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869]) by BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::954a:952d:8108:b869%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 12:52:47 +0000
Message-ID:
 <BM1PR01MB25450B47C36ADE01F53CAFD1FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 22 Jan 2025 20:52:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, helgaas@kernel.org
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>
 <20250119114408.3ma4itsjyxki74h4@thinkpad>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250119114408.3ma4itsjyxki74h4@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY1PR01CA0187.jpnprd01.prod.outlook.com (2603:1096:403::17)
 To BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:44::15)
X-Microsoft-Original-Message-ID:
 <0ac8baae-3ccc-47ac-a91a-13b6e735f92e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB2545:EE_|MAZPR01MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: cfd43150-950b-4083-4d91-08dd3ae3ab97
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|19110799003|8060799006|7092599003|5072599009|6090799003|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzRjQ1lySVVrS3V2eHo4QlNSMzlmL2VkaEwyeTJ3QnJ4MkNQb2RuQW96K3c2?=
 =?utf-8?B?VzhYK2YwRFJWczVYNnFBaTIvdUY1eExONkd4U2Mzd3BpVHJETjJwczJnOU9X?=
 =?utf-8?B?YmJUWWswcXB1dyt4K05nSTlBUWtVOERZL0VGTGlDWSt4NEpvanN2cVFKUCtK?=
 =?utf-8?B?dmpsSTd0QjcxNVZQMUJhTUZKemZWVkpsRG5UUEo2MWVYc0Y4U1NBV1FKdGd4?=
 =?utf-8?B?YjNydVB3MHBTd0VhTHR1MmVOdnlGcWxUZC9CNXNsSmgydklETHh2bUY4eEN3?=
 =?utf-8?B?NkpUdVRCQzVlY2M5NllmVEw3SCtHM1RKY0NqOUtIV1RPTFVHaHIvOEdPeFJu?=
 =?utf-8?B?VWZDTUNlSzVpdXY2d1F6UHRlLzNDMGtpdlF1eGY5bDBmSWlPdTVxWWRsalBS?=
 =?utf-8?B?NVVLczNPSmxPc01GQWp0eWhOTDNZbEtaZ2owWm9GRWliZVZQb3BZTFdLdUdD?=
 =?utf-8?B?bkZjVElnb0owaWZqaXlWZFB4Rlo4SW5mUUs2MnB5S1k3dnhtdGt4OFU2Mms2?=
 =?utf-8?B?UGVDYVNwN3JZUVZ0YlI3c25LUElCeWVkMXhGVHlKZkRaQ2owVlB2QVNVWXEv?=
 =?utf-8?B?VFM4KzVsRFJKeTNzZ0xPTkd5WlNrZFlSRXdmaXpROTlEbzV4ejJhbnVOeVdw?=
 =?utf-8?B?V2JhSjR0d2lra1JjVnRRSkhMSHR5dmVqaGt6UEpoRzZ0OTlvV00vZkhjZmVr?=
 =?utf-8?B?WjN1eUZiSHRYQVVHK0todHU0ZjBxNW9YYVF1N2ZHazdGQW80bGF4UjQwZjY1?=
 =?utf-8?B?VU90ZThSK0RVc1VKZGpvTWhuZDBzVGRvb3lGQ25wOVIzUGk4L0o0ZkVqTVUy?=
 =?utf-8?B?ZmQ1N0RMQUE0YnM0WlRuV3VRQng4dkdTZ1BNWm91V1lyeU5yOFRrNGJGTTNL?=
 =?utf-8?B?YVdyVmxIdmF3VkppSlgrc0dqR0xVb0Fnei9SdWFQQ2ZLRU1iZ1R1OXcyeU8x?=
 =?utf-8?B?eFc2cGE2Q1QxMHJOQUtSR1JIa3ZsNXFyeTkvcjh0eXlGalJmNkF0eEJQKytZ?=
 =?utf-8?B?MlE4N2FNRTRwQmtiRVFvZDVrcloreENibGVCU1hyazdEcGtJbUY1elJsYzBN?=
 =?utf-8?B?UjI5RlFNSG9JL0paUTRkMHNIbDZ1WDZ6dVJuQjFpZ1E5L25GalBxNWhwbUk3?=
 =?utf-8?B?eVBVdVZnU3RLK0tCZEc4QVBJTjFrdldPL3NSMzY3WTZSUkErbGttZUR3TlFu?=
 =?utf-8?B?ZmlsQ0FQTFBFd05IVnhkeDhiclFNMHVtQ2JJZkZhWUM5cUJDeWhONkd5QU52?=
 =?utf-8?B?Q3c3eEs2NzB3djFBU2xNVHIyQXVDRWdKMzNsSldYN3VYNEd5SUo0Y1FSQzBw?=
 =?utf-8?B?OXFobitxM1VIUUk2ekdqN05YaGNiQTZiOFdpTG5OR3ZyN1hnLy9ndHZkOWtW?=
 =?utf-8?B?bUlheFVwOUQ1OTlJQlkwME1tQnU4NXVhdWE4S044MDBpN3pob09BbzZEOWF1?=
 =?utf-8?B?SkRmR0kzOUpvSEJiQzZ5UjkwdElmS2FUb1F2M1p2TlMxV0JTQ2VZaHZ4N3U1?=
 =?utf-8?B?NVlCOER5c0V4VW9IUnQ3MjdtS0s4di9xR0toNXFwQVNHa2kyeDFxZlIzVUhV?=
 =?utf-8?B?V1Rwdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U09hOXVkbC9NR1RqdmU4SFd4Sm9wU2JFQ2xLUU1hc1NVcDgrQ3NlNEhuTVRi?=
 =?utf-8?B?b1IwcG1kcS8rc2tHcW5QODFrN2F6WXNmaFB0bU4xOENkbTlwTXlPUVg0cUg2?=
 =?utf-8?B?YzRvUzZLLzBITitJTENqeEVnNCszc0krZlhRcEw0WXAyK3hCU29MTERLSTBR?=
 =?utf-8?B?bjhnUjJhSnM5aWU2LzYyYUJlVFhna2dqL0xCK3NXWDRQKy9qSGgwK3l5eTlI?=
 =?utf-8?B?Uk5KUXFHVjhSKzZJTFVJMG1zbk9oMGNJbmFoY1Rvc0M2MGloYnhyNFJCY3VN?=
 =?utf-8?B?ekRGdlg3UHNyQUcrY0RZemhMckYzYlNtV1lhZXlCTkltdS9xdDFqVzRmWWd0?=
 =?utf-8?B?RTF2WjFZMS9hNEpxVHVCdFpKV3JhaldZcHVyelptUVVjZW9YOEc3VWpia1Bx?=
 =?utf-8?B?MkVMVUtlMHJtL0wrb0lDYnZ0OWxqeE1lNjNsWlBNT3Fxbm9kREFxUUNlQUor?=
 =?utf-8?B?VlZEckNwR1dCMWdhM1lpbUlWT3J1NWJHbWdUcE5VUGlCM2VKc0RGZzVYN2hn?=
 =?utf-8?B?dmVRbkpRVXVSbHJMVm53T0VDNE1UQmVpRE1YalErR1RYNGpyc3IzbGVzRk9z?=
 =?utf-8?B?V2Z6RnZXQ2ozWGNnSFRpc3BmV2ZXcWlBNkNySmwraXpwYmN4amNXMndjMjcw?=
 =?utf-8?B?Njk0NjMxL2xpd2RYaEFxR0VwVXB1cTd6emM1ZUFrQkpPb0pvNFlpNTQrRENU?=
 =?utf-8?B?YmRlWFYxcDFYRXBxSVFiM1pUTk1FTndvMHVmWm1IcWJTbCtZUnhrZ25DV3V4?=
 =?utf-8?B?Zmh3UGR3M0RyWlhmUCt0U0tlS3hUUEJzVWFUN1FtNEpTT3RBSXNINGZWcTBr?=
 =?utf-8?B?UDBtNkc2TGI2MTdSbjFocDZYL3RaWGYrc3BRd0dTdll2VGVxODJrRmtqSnN2?=
 =?utf-8?B?dXUvb0dnZTdyYmRGTkZYaHVDbDVSM0tROHcyd1krQmN6Q2RmaGRmbnc5bFVI?=
 =?utf-8?B?TVpucTFLNktPZ29HNTdxWDdEeC96MW1TL2ZGa3Q0VmdFeGxMMjNuY21TdHB6?=
 =?utf-8?B?ZmFVZk45cDJ6Q0JtTnQ1WWRVYUl0Uy93N3piOUJUVUt5NVhQeVc3RWFHM3Nw?=
 =?utf-8?B?dFlnV2l2bEZMNkowWUNGaTRWWXdSb3B2Wlc2ZllvMU92ZGhReFowRmVpcFAz?=
 =?utf-8?B?VHY4QWFJL3hRVlcwUkpjQ2ZXK2RlV1pPUkFGaS90SldBQytQSHZrYkxVL0pi?=
 =?utf-8?B?ZlhTbFlHYUZZQ3B6SlJwT3JoUDR2cW9mQWk0OTFUWnZJUXJIWWs5cnFqNTEv?=
 =?utf-8?B?aDJrRlU3aitnMGJ3djFLb1BITUVKK25aSHdhMkY3enBlNUFyakMveEJ4UUVX?=
 =?utf-8?B?cFFuc1JGalRBMytLeXFzZjR2ZXcwNXo1U2lMZzVvckI2bVFTNnZReUtiMnZt?=
 =?utf-8?B?V1BNYTZlSERTVVg3L3hZV0dZSEhsY0tnRVRvNCtGaDFJcDRERXhxOE5KVjRh?=
 =?utf-8?B?Tit0MEEwR2ROT1RJck16UmUyZmdJWWx4MkM5MWZmT0JyaTlyUW9mQVlVNnJz?=
 =?utf-8?B?d3U1Q2VSRWVCeWJuT2FwTUNIMWVuOW9rVU9kWFJRdDZkMGs0TTlZbkZlcFgy?=
 =?utf-8?B?cHhWcUtLNlNnVmNsd0lYd0pkQklWb2JBUFZPUzQzRmFuY0YySkFJRlRrOVRI?=
 =?utf-8?B?UlNoQmpwQlV2TVdqTFdaQ2Z4YUVKdXhGcGgvbnNlR2F5RXQweldKSUlwV0E3?=
 =?utf-8?B?dWxqQkJoL1o0djR6cDFrdXQ2ckJSRlZDbWlIMlpncEtCL24vbXAwM0VQcVVr?=
 =?utf-8?Q?M9+mtgm3keE1D0Z6AuLabp+DH1INk5787P+U5JP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd43150-950b-4083-4d91-08dd3ae3ab97
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 12:52:47.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7184


On 2025/1/19 19:44, Manivannan Sadhasivam wrote:
> On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding for Sophgo SG2042 PCIe host controller.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 147 ++++++++++++++++++
>>   1 file changed, 147 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

[......]

>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pcie@62000000 {
>> +      compatible = "sophgo,sg2042-pcie-host";
>> +      device_type = "pci";
>> +      reg = <0x62000000  0x00800000>,
>> +            <0x48000000  0x00001000>;
> Use single space between address and size.
ok, thanks.
>> +      reg-names = "reg", "cfg";
>> +      #address-cells = <3>;
>> +      #size-cells = <2>;
>> +      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
>> +               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
> For sure you don't need to set 'relocatable' flag for both regions.
ok, I will correct this in next version.
>> +      bus-range = <0x00 0xff>;
>> +      vendor-id = <0x1f1c>;
>> +      device-id = <0x2042>;
> As Bjorn explained in v2, these properties need to be moved to PCI root port
> node. Your argument of a single root port node for a host bridge doesn't add as
> we have found that describing the root port properties in host bridge only
> creates issues.

Got it. I will try to change this in next version.

> Btw, we are migrating the existing single RP platforms too to root port node.
>
>> +      cdns,no-bar-match-nbits = <48>;
>> +      sophgo,link-id = <0>;
>> +      sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
> Where is the num-lanes property?
Is this num-lanes a must-have property? The lane number of each link on 
the SG2042 is hard-coded in the firmware, so it seems meaningless to 
configure it.
>> +      msi-parent = <&msi_pcie>;
>> +      msi_pcie: msi {
> 'msi' is not a standard node name. 'interrupt-controller' is what usually used
> to describe the MSI node.
OK. I will corret this.
> Btw, is the MSI controller a separate IP inside the host bridge? If not, there
> would no need to add a separate node. Most of the host bridge IPs implementing
> MSI controller, do not use a separate node.

Yes, it's a separated IP inside the host bridge.

> - Mani

Thanks,

Chen


