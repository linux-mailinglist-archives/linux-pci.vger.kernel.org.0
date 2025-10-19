Return-Path: <linux-pci+bounces-38644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBBEBEDD5D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 02:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB41B4E42F9
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024021A00F0;
	Sun, 19 Oct 2025 00:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qiR4lFh/"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FE1553A3;
	Sun, 19 Oct 2025 00:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760834217; cv=fail; b=aOrYmSj7K900IUK9MofaFZfaD+41er+8cMd/cWfZ0ZEkBu5x+r7j0WmHmzhk0YWUzLJLEcGVsD7Tk78AXKS9VQhJSgTSuEsR6KEC2GrcYB7A5vQCqT0lG95l37dKQO9UXJjNsIt0HBEl+sDUNvTc8efcrs5n83D5HMuHx70Z5os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760834217; c=relaxed/simple;
	bh=rOJ/pKWLjwazzNT9E6ZFYpqaXriuNBO0jqLJuDbpwdo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NaFm0UnQDLDiCTsMVBG/4CDVJ2LUfYPnyNR07HAR7/+TJJdUGiCvz41FZV/PdoIC4faC1IsYCMiGMHR+NBgJYcCt5l1jxdcfYh9SkvLxw1eQ0+aY+ippqOsXq50kBKFTdHstfyQrQ/bheBPNMQ5i8m/ES830PJqLMRJWFTiU850=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qiR4lFh/; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mp3zt5b8duMHkXMvx1Ec6ScHUx22xNrVFkMznJBcpzuLN/kMo7Fkx4WKYYksktgHDXhAodtohKZlRZmE+OPSI0gfx4aagaEVVWQA3nwnn4DTRnUj9Uz+JDcqGCiIxtUzTuRRPx0yYkzHOYG10o0ZtzSoxybKbdoy8OxDGGFOtxBIjIrdxpRUjVO/8Yc/LtHa60PfZPcxLjoVInlB4lnpnHtLmHfLsXi94OznQOkGWM5/aNMMBGeXnxYaOdDtoq2xKGHyBt6ozMIIH03ZvsRVo2NsDMzluXjfB+44n90fntieM9QDiLQpqxu7LmeiUL94FsXCOABn2uykIFZ70E71Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdIIto963DhZ81t6ShFpSh496z2k0QCsAsIu6a//k0g=;
 b=OBhhZRTYmpHN7yXgV7vQRgfU0zeFEs/1DmQ8UEsRqj8aD/FtwkjcocQcL/HApKOHhCjFTESA0lafrBltcWsZY5IZTliL8V62iB+M1gDWAW1yBTIMsdxCyPN2THwq3w7VCsnslA2/jQPGmeUnGg7xj1kzfWDQ1xfe2R40ZP7ziog374ffzzSysrqQBxVNke58IYRgnp9rOrN5vkJ4ugOX+jA9coRhFE+ySQcLMk3xmIuc6/Aa7kkAY/PUeHS9COZIk84NQk+NivNXDF54Y3R9xm1+odScr2Fq0kVUpTEsRFNv0xloR2QIJBEViorT6107yBudnfDT0jfhJxGMVw0GdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdIIto963DhZ81t6ShFpSh496z2k0QCsAsIu6a//k0g=;
 b=qiR4lFh/6Oe2J+CAiO5YU7Bn/gmdLc+Tw9JphkEByca5iOy2feoHCR8vz0jKBgCytGUKYBDb1mo/zODZPaMemifTlFIdQyMHiNOtpNHuzb6pcwBtyfDQFSXE8/pJJLBMNImOMtjVs2R9pD7p3AGbrfbBWH7e+n3DMMcfbJ7hhA9jzvLKapaVrcQERWPo5f062o1392UQeVBk1W30zabv9KXBQULaHJa6woHnLr4f3tO41nNIQq0cOOrhONKSseWL5JwxIJwsEhyYHBgzI+JO//iIYxREN7J0B0fDERSq7tkhDHO9KSPT8vtgw3nNGebaIG7PbhbcDBqqR9TVJ2SESQ==
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2f1::8)
 by PN4PR01MB11732.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sun, 19 Oct
 2025 00:36:50 +0000
Received: from PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f]) by PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2e35:fc95:ee3:bf0f%6]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 00:36:50 +0000
Message-ID:
 <PN6PR01MB117174C06FE98FC0322A0B3F6FEF4A@PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 19 Oct 2025 08:36:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: sg2042: Fix a reference count issue in
 sg2042_pcie_remove()
From: Chen Wang <unicorn_wang@outlook.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
 <f1887014-17b5-405c-bba2-1a441d50e1f8@outlook.com>
 <0e9b75d5-a1a6-4c5e-ad69-8e189af69bf3@outlook.com>
In-Reply-To: <0e9b75d5-a1a6-4c5e-ad69-8e189af69bf3@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::13) To PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2f1::8)
X-Microsoft-Original-Message-ID:
 <0f572eed-e20f-4f7e-8895-e5b6abc1fd34@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN6PR01MB11717:EE_|PN4PR01MB11732:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ab34ec-9757-4046-d404-08de0ea7953e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|461199028|5072599009|6090799003|8022599003|19110799012|15080799012|23021999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFNEL3grVm1vVWlXNlQyUXArc1UwVDliUy8xRDh0SGs4QUl5WmhhREVmTFpy?=
 =?utf-8?B?dTlaaE0xUy9Ta2VGczNhcmszTngxK3U2bmlTVVpJTm9VOGRjWWVRbk80MDZ3?=
 =?utf-8?B?YUxiNGh5Y28zak0xV0RHZjlnZUZCbWtxeXhmUFJsazBIWlVKOVpaQXN1WWl0?=
 =?utf-8?B?ZThTOWRLYmhZQ3Jydk5tdXprNjhrUWVUNWZ6UldJVzNla3hnOVpxQnlMMDJ4?=
 =?utf-8?B?Zkx4aGljZExUM2szb1Q3d0ZCcnNlN3NuUnhQazFMQ0FrUlFFNFNoTGhRSWRz?=
 =?utf-8?B?S3lVY24wSVhCTkFjdUZjQTR0N0lpR1hpbStlOU96MlFzUnBDMHVSR1I3YVNw?=
 =?utf-8?B?dzkrdTQ4WCttNXZ0SnRJaG9mTVBveHpnUWZXeUFLMDdDeUliQkFpb2dzMjhU?=
 =?utf-8?B?WUxlMGpLR2l4aUJpVlh6ak5MMk5nNTltTDJxcVpQMUhaQmFxbUZyN056OXJK?=
 =?utf-8?B?T0J6Q25sNXVLUitud0kvVm96UDR1a01WS294MGhDcDIzZjkvSytab3VCNE0w?=
 =?utf-8?B?Q2tUWmNWei8wVzdMVmwvNUFsRDhRbnM1YVNWdHVad0NxWDZDbU9YdVFXSG1j?=
 =?utf-8?B?V2tCdU83RkRWSDBxT2xGQzBkOXdaWUNzTEZKYTJOWXBia0lpNm4xeEtiS1JN?=
 =?utf-8?B?Qk9QazNuandwT0wvbG8venNIMFdLVUgzNWQ0THlSWFpLS1RuVXZSRDZMMUgv?=
 =?utf-8?B?dVZ4ekN5eVhQZkNHZ29KKzJqTVdwVVVJS0ZOdnB1ek1WRzhvUG5PZ3VnOWt3?=
 =?utf-8?B?a0hFN2oyN2ZyWkhBNUZYaGRsV0NZeTZLb3JmU1F4NDBPZUJXYTRkYUlONFdr?=
 =?utf-8?B?bEwyeEthZWJHTTVxR1hHOGNPaHlIYk9YRGxlWGllekJuMDIzaXVvRjB5OUxO?=
 =?utf-8?B?cUxqam92N05ITW9wd1dsNDBnQXhwTXpjbGlwV2xKbERTaGRiSW5OSHpQNGNU?=
 =?utf-8?B?bHZ3ZW1jRHdnby9jQmthWkpzZjNlYUlyYy9HSDB4TmZla0o1OWdLaVY1V09o?=
 =?utf-8?B?ZU9STEc4YXdtRjJ0RHJCVTdJZTVyTUdJRTE2S1N5Q0xjRnd3VEk5MW9ZSWFQ?=
 =?utf-8?B?VS9uZjNkSTArZS9MbnRwbnh5eEczUG9uUzQzeHhXcFBLdEc3TURKTlhhaUVG?=
 =?utf-8?B?WTdEUDlpbjZSWDlWdzkyOGJLOXg4THJnTTMvRHF1aDU4ekFBNEYzd3RGQkNq?=
 =?utf-8?B?VFg0OVBLaGdUNGZSUjQwTWpLQzNJc1lHeWQvZkM5ZTNvOUlKVXp0cjhwa2J3?=
 =?utf-8?B?Tm1OdjZnMnJ2MmJlRWowY3J6SzJsTTFuMnJma0UyeVF5cTZ1WkdqSWxvcWRq?=
 =?utf-8?B?VjlSV203S1Y3aTEwdDB3WVEzNjZGT0t1MGxYbHZadk5wK2pqd1k4YnNiNURT?=
 =?utf-8?B?RVdOVDdncVdWSHQyOHdwUlVzN0pjTHhSZWVUeC9wL0ZJRFl0YW1mZE55RUl1?=
 =?utf-8?B?aG1BcEVRQXNQQTJTTkVieklkbktIeWNBTkpVZlFFanR4UDFUYktaYndaYks3?=
 =?utf-8?B?eTExci9WNlhzeDRsaVFpNFFlTkhmakFmOW53akRNdmFyaUhmbEwyWW5mS1E2?=
 =?utf-8?Q?f85aoVxjPhf0J2j6/4zbQ7ATM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZW05YU4vbGphTDloQlp1STl1ek1UTmdMRENYUy9ZTGdINVJKcE1EbVhTQWh0?=
 =?utf-8?B?bXlNYXdoOVJhVFpyTkZLcGgxVkU1UUpJWko2RFdqOTZMWjBWWUU5dDNEb1hw?=
 =?utf-8?B?S21sbU85VDhocmlkUEswNHFmQWpVTXFvcHB0TnVOWm1sRE1KK21KZHVsbXo1?=
 =?utf-8?B?TnV3RTh1bUQ5L2RaYnRGckwyL0JSMGhORW5xa0syb3VkWTdhd1pPSmtjUjF5?=
 =?utf-8?B?ZjZwbUkySXNtd3JSZURjN1F0S1M4bjBpUTdlRGIramU1dytTOEN3NXNBV0lS?=
 =?utf-8?B?YmJESEs4Rlc0ODZ2ODhFb21SbTMxUXF1VklpL05MTVdVL2tpYk5JNkxNanZO?=
 =?utf-8?B?TzI1MEhpejZYNjVZdXppbG9nVXdjdUFzWktwR3d1QUxRd3J3NE0rNGVhQml4?=
 =?utf-8?B?WGd1RnM2SExlRmNTcDBBQVpmNTRNQkdPMnZxbU5FUFB0ZWlMRTd3YnY5anV5?=
 =?utf-8?B?UU01QmhJK3I0b1VuekF3TEQrbDQ0VzRWVDdudmU0ZGRtYzZ2SWhvZmZzZVdr?=
 =?utf-8?B?cFlSZ1cvYUwyN2Qvb0I5Mm1pck82YlZiSDM2Ri9QRDV5ZmQvZTBnQUoyNnpp?=
 =?utf-8?B?NmNDQW1zemMrdENMVzhaOU8rRGRGV2NVaUx6bEpCNzBMbTRVbit4OCtabExn?=
 =?utf-8?B?K3VlSnpyRm5RMGU2cE5VR1ZyWXgrVUdqTHFWeGY0WFI0M2ZtVkI3WHFPNCs2?=
 =?utf-8?B?bWRXOVVhWFRQTHN1OVNYU21MWDhYME9BRUNKY2cvU1ZJdkdYeHhUSVR2NUgz?=
 =?utf-8?B?VHVSUnJmRDJ4Vlk1cU5wMFNCdGNzYTltN0RGL05vd2J1dlZldDVNQ20vRjBH?=
 =?utf-8?B?RTNYRWJldXFQR1NSam85Ny9QQk53VjRnNlIxZmNISFlJNkNqcDVpUldIZUdJ?=
 =?utf-8?B?OWZRMXZRVUkwaWh2Ym9UTEx1WmkvZTJReVBDWlNCUDZrSklrb0gvSDM2VG12?=
 =?utf-8?B?azVxOGVrc09DQWVwR3pqbEFvVFhZZmhtOVRUa05QbkFHT0MydEtaa2lLWVZy?=
 =?utf-8?B?TVoyVHRkK1dyQTE1Um54TG9aMjg3OG5nekR1UzVRSlRKa2lMdUlEMHlsWW8x?=
 =?utf-8?B?cG1HekVyc2dUZFRlWkxpV2t4emptRy9mZHRRL01EMFZHUjhBL0Q0dHF2bjha?=
 =?utf-8?B?bmtCVTlCQ0VqVk5PUmJVQ2FIelEzbGZ0QjViUU1NR24xRk9HTDN0dXgwWURB?=
 =?utf-8?B?aVExbE1CV1RDQjdRUmM5T2dhdm1rYy9zUWg5aHZQZ3RwN3Fremw5Tnl1bnB3?=
 =?utf-8?B?TlRTU1BDeVdWbFBVd1ZZb3l0RXdXZThlWjJ3R1ZBc3FIK2dNbEIxc0RkaWk4?=
 =?utf-8?B?RTZKdmJpQlRrNUNvcHMrRnBmTko5Uk1ldUNSc3cyb24zanN3NkpOc2h1N2VI?=
 =?utf-8?B?OE1KQnVRUC9zUENFcTYzaEJYTmFyd2xLVnJDRTlZZ3pVMUtvVUxHMTNwTXA0?=
 =?utf-8?B?UEt1MWprbVRPcE1lcEYxTTBzaGQ1dWdxSzBqOXJMUEpWS0llZlhBd0tmQU1L?=
 =?utf-8?B?RCtwSm10aFlkUHY1YmtJVXJGNTI2a3I0aWgwSlBhSWxQZytVU0NvOVgzVERZ?=
 =?utf-8?B?a0MrWFgyMVg1VzI3blJwYXN3U1grcks2ZC96UG1TT3RJcDlTQlAwaEJUbGky?=
 =?utf-8?B?NUdXRUhQQnRCNUZRd09sRkdaeG9IYXlOQlBOVTNxNjRSWDhuTkhHdDI1T3pm?=
 =?utf-8?B?NjR5dXhIZyt5TklESWdqOE50aWxYSlBPdkpMMytrU2pKdE1jOUZyV3ZDQlR5?=
 =?utf-8?Q?TpXdRRuy4W6EAIRNqQ0T56mN0nOBoqnL+dKOPH6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ab34ec-9757-4046-d404-08de0ea7953e
X-MS-Exchange-CrossTenant-AuthSource: PN6PR01MB11717.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 00:36:48.5605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN4PR01MB11732

Hi，Bjorn，

I see you raise some fixes PRs for PCI for 6.18,  can you please pick 
this one also?

Thanks,

Chen

On 10/13/2025 10:31 AM, Chen Wang wrote:
> Hi，Manivannan,
>
> I see 6.18-rc1 is released. Could you please pick this fix for 6.18-rcX?
>
> Thanks,
>
> Chen
>
> On 9/30/2025 8:43 AM, Chen Wang wrote:
>>
>> On 9/30/2025 2:13 AM, Christophe JAILLET wrote:
>>> devm_pm_runtime_enable() is used in the probe, so pm_runtime_disable()
>>> should not be called explicitly in the remove function.
>>>
>>> Fixes: 1c72774df028 ("PCI: sg2042: Add Sophgo SG2042 PCIe driver")
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>
>> LGTM.
>>
>> Acked-by: Chen Wang <unicorn_wang@outlook.com>
>>
>> Tested-by: Chen Wang <unicorn_wang@outlook.com> # on Pioneerbox.
>>
>> Thanks,
>>
>> Chen
>>
>>> ---
>>> Compile tested only
>>> ---
>>>   drivers/pci/controller/cadence/pcie-sg2042.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c 
>>> b/drivers/pci/controller/cadence/pcie-sg2042.c
>>> index a077b28d4894..0c50c74d03ee 100644
>>> --- a/drivers/pci/controller/cadence/pcie-sg2042.c
>>> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
>>> @@ -74,15 +74,12 @@ static int sg2042_pcie_probe(struct 
>>> platform_device *pdev)
>>>   static void sg2042_pcie_remove(struct platform_device *pdev)
>>>   {
>>>       struct cdns_pcie *pcie = platform_get_drvdata(pdev);
>>> -    struct device *dev = &pdev->dev;
>>>       struct cdns_pcie_rc *rc;
>>>         rc = container_of(pcie, struct cdns_pcie_rc, pcie);
>>>       cdns_pcie_host_disable(rc);
>>>         cdns_pcie_disable_phy(pcie);
>>> -
>>> -    pm_runtime_disable(dev);
>>>   }
>>>     static int sg2042_pcie_suspend_noirq(struct device *dev)

