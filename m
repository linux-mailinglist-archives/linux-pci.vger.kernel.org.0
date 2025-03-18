Return-Path: <linux-pci+bounces-24027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E420A67007
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 10:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560701639D8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 09:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800CF1F4C9C;
	Tue, 18 Mar 2025 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pDJgdXCK"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2013.outbound.protection.outlook.com [40.92.47.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C671422AB;
	Tue, 18 Mar 2025 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290899; cv=fail; b=kZSzOrzs1EDaxerJkuAIvbYpJoDBnNuP/WGdtxaaaJaOPt5Vd7aFXVPImiYPMaStxIyxGfULhzI0SCwRk4+Us1f2rXNY2vR14EEs7YXR7v8GJ0Um0izUMB41NRr2C/9PW9oXx6DirMSBr0ZrzzIwXu/XaKGz8cUYoN4Ybn1ouoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290899; c=relaxed/simple;
	bh=RkVmviwFSyVRa1FkGJEfsU2AHLxwgCd8D3RPGScECxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IB1eOW7H3rkoVngQolKLiblIkGYiTS/sPi0JfRQdlxmFDzIXgOMdJqhrXQ5fNHSD8XOtxSrPjd4Wvy2QRyjMTYDD2Ez5U/wOhZMEq8sOBr52cIcqhisRVJ3HVoq9ScOAZ5HV0mlrKWEmUBFsDw7vahL3CVeNVv8KLRSmTVgRRoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pDJgdXCK; arc=fail smtp.client-ip=40.92.47.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STzdSwJ6JB99cpacidU2b4eFmUcjsAVaiZRLp0YdDjnKT59X95yb28PqVlO+ztZPU1mCWizT44m2YHEfwGJIEjNfZpxXE82QH6qaBasZh3glXfBbgC7VFT5WtFIOzSNmhPNaVse9ADyvOO57pbGja2EKEfAk33JR/Oe8QLGUaeXAV4pnj18Jqh976thpgEHaHd1AT4Nt05LPZUF9NK8jIbfym9YeSW3r8aEszXk89cv43kRTMU8DO+3AHSZ21fVG2Oj8Ajnv2znvsMLTDhIspo4kwlqsDxnKytA4X534YkccGakxHIhyez3j30QZHwVGjCeCZZtqNB3t53zhgBEVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyxLtsSo2uCEjy7O/5c7GlukNU+eiY5/yUc5MH/jbAM=;
 b=ppgaRalljnqqJgsskfqB8Y9XaW1fE3MTuyuX9sltT6wZzGczLkNWk2Lj31MFLyNY0XVd7qOpH4Mi9tPHa9L+qW0FXNGS5TppWiG7K6dh/SmrY/mvaRokUtEKOAZeLSM0PPxfuPHqVNcdtQZghydwTbLqBd9rFqay7v3BPdl/3ulrHULsu2mmIhYQ30/fJrYQweb3pGIQQwFQdLIamglE7SRumNmiJO/Vf1Yy4AWNsik19lKq+1ADapBLpZ5bE4a6AH594xk8GElo1K2xQFa9FBsQLdrdMvNg1ZbdmqZXLVGraOVYwS8z7XcYODxTzNZYgx3sb7/D+3OKyfrTji/rVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyxLtsSo2uCEjy7O/5c7GlukNU+eiY5/yUc5MH/jbAM=;
 b=pDJgdXCKAXRIok33IbfocyEC4F2wnd8jeoI2AEWIZWoj/9lXXaIGPnPRR+awUMwizBoSvJpWknP7PFc/ZJmDLHIcbeKej+WoQxSPDmq+skSm3rZeh708DRi96hg8RZqJm3QUUe4SWA8r4m5Ua8v+LaQeJ7cC8RQqt1FkDBbL6OgKCEjuEBbffYnWUpfFZj7ga5xD5JfbNSlgn+Zs8x9kOulaKjYtgMW0zZNXREZLCP6rS09V7+5I1IfCo9Stq8le1QUOLdLgjyAe0xDiehVmviY93SzT/yIknvhTVF59EiIoF/XYunpF52qalF+PcjCegVsNJ2Td8VewX+WzJpXKrw==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SJ2PR19MB8028.namprd19.prod.outlook.com (2603:10b6:a03:53a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 09:41:31 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 09:41:31 +0000
Message-ID:
 <DS7PR19MB88838C8F5959955CB4AE14959DDE2@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Tue, 18 Mar 2025 13:41:19 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] arm64: dts: qcom: ipq5018: Add PCIe related nodes
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
 andersson@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, kishon@kernel.org,
 konradybcio@kernel.org, krzk+dt@kernel.org, kw@linux.com,
 lpieralisi@kernel.org, p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
 robh@kernel.org, robimarko@gmail.com, vkoul@kernel.org,
 quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883E4A90C8AFF66BCAE14F49DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250318071756.uilfhwfzgr5gds3o@thinkpad>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <20250318071756.uilfhwfzgr5gds3o@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX2P273CA0017.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:8::29) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <46a9fa5c-fe98-4069-a74d-c11caeb4e94c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SJ2PR19MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: ad84f573-01a8-4ea5-5125-08dd66010fe5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799003|6090799003|8060799006|7092599003|15080799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzQzRDFES1JTUXFRUldaeThOL3JMRkwwRUFOYnMxa1FTb3lQV3QwcW4xTERq?=
 =?utf-8?B?K2hRcHVxWWRFL1BNUUhBK0l4ZEM3V1BGbk5yNXNrbS94YThRamkwTnNjS3hk?=
 =?utf-8?B?VGdCYjRBVTU4TzNxTStXK0YrTnpUQkxzeCtFYmxKcitDTytVSGprV0ZpK0d2?=
 =?utf-8?B?U01jb3BoNlVJdG01cDVjeHN0eXJYaE1mR3lmMzdwdnhhYXRsa3B1V3IyZG9O?=
 =?utf-8?B?emVTR3kwTUd6dmR1REVVa01XMDVDeXMraFJJT2xwb2hNbGc4VkM5cFd5TDVX?=
 =?utf-8?B?WmpGNEd6dllUWGJlbkdvYWZBbUhmUXdTenZCbVk4YlhYSlFpMklsdjNieENU?=
 =?utf-8?B?OHU0RzJEWkEwUnkvRGFyR2c0UFVJc3lrNHdvUXpoR21sZXNMT1d3d0dyeUs1?=
 =?utf-8?B?RE8ybWxQUUVTUkZGV1M3K2srcElpQndNSUluam5ONGpqb0lVdERtcm5jQUtZ?=
 =?utf-8?B?dGU1Y1RUbmIrRTRmMEJPWU9EbXZyampUVDBqWVNMMG5qQ1JuR2lpNUNwNHJ5?=
 =?utf-8?B?VDArNlQyN0FSdlEyRlNLZVRieGxpWVlLcE9sWUcya0hsVnNoeE9uNnFYc0tj?=
 =?utf-8?B?RWVla0hKQ0YxYUNPNytoZDN3aHFIVkkyTzJLV0xCWVFKaFlnVVZCUXV5SGVx?=
 =?utf-8?B?ZjNrbnJQL0dPV1BFZ0xzVGd3V21rVjBPZ0dJTk9paDREenRWT3AxeTRHTno1?=
 =?utf-8?B?TCt3ZzBRREdjUnFqVFZnUFNjamF4LzN3bFlKZW96eWVQT1N3SjhXTWFEUFJ5?=
 =?utf-8?B?RWxDdFpwNnMyU2lsdHZYS0szblhMaWYvMEQwZjhma0swcFdkMGFLNG9TWEhK?=
 =?utf-8?B?N1lYbkhxeXJFRys0bVlJU2xKRFE0WjlTREd3VkpWT1lKaURQMlFUWnRudUFI?=
 =?utf-8?B?WnppWUo5dTdxb1hpV2tHYlVOd0owY1hNZnN2bngxNmFpdzRXMnpSU2Rzcmh4?=
 =?utf-8?B?ZkhWZUV4MEVOSlFSVFdmcFNPWW9QZmNCVzFnbUF4MVBDeDdSVDFTZ2dkc01m?=
 =?utf-8?B?YmNNZ2JNZjNCaTZTOExsdGpTZ1ZKdGk2V0tacWhtMExwZWNQOE1rcEZrR1VV?=
 =?utf-8?B?TU5OSUdEc1pVMFVUbzZ4MG9qOXBDMk53bGFxSitrbTA3cWx1YjdQQ1pFRkhu?=
 =?utf-8?B?RmEvNDJDWGx2emdOUkhJVHg4cjdaUXJpTHJ6bE9lN0RJZm05WmlBWXpjRVl0?=
 =?utf-8?B?NGF3THFPZC9Ja2ttOGpPaWVZUWRCNS9ldFkvNmtONTFwbExOUWl1SC9KMDZy?=
 =?utf-8?B?Ym9QWnJRSVdkdS9JVm54aWE3bng2UjE4MHZ2Q0cwUVpJcnUrUHhCT3ZvU3RJ?=
 =?utf-8?B?dE5GNUY1a2I0NklNdklxWE9uOXZBYnpuek8zS29NY3JjaHRxZis0SFRsU0M3?=
 =?utf-8?B?MHMzOCtBd2pFbFN1bXFVOGowdTJ3VVNVbmpSK2ZqeFV3Qms3RmloRytjRmR5?=
 =?utf-8?B?c3NvaUp2d2RCbjdnb3pPbHVZcmh6M0pLN0gzV2pSR0tGUXFjQ0RGUzdQeVB6?=
 =?utf-8?B?OFlYTytQRUhIV0s1NGc3OVBkQ2FDczN5aHZPcUE0dUwyNjMxR1BERVZ1c2Vh?=
 =?utf-8?Q?UkN/d0n6BtyUAeW8swZUmHaHs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjA3UnJodmgrZDBvN214OHA1UjhFZDFseng1SVUzS0hpbWwxaWQ1aUVHc0h3?=
 =?utf-8?B?RldNTXhVWEM1ZGRha2h1VGU1dTdzZ01ZbFE1SHVINnNYUHhhbG5VbDJnRDNO?=
 =?utf-8?B?ZlpzUWhReVNwS3ZUYjZpMlNUc0dWYW81clZmYWVDQnVFTzdZNSs3em9EMFFr?=
 =?utf-8?B?M3ZBcmxFUWltNTgrMWtsNWFvWFlnRWdOb1gwMldSVnloUU53QkdoZ0lNT3gv?=
 =?utf-8?B?RUlTZndJZkZhK0IxYnZ2SzJQM1lUOGRQQm1sRFRyM0pOb2QxZUdiV1BzVkUw?=
 =?utf-8?B?bDJaSHRNbEhKbW5GbWQ4bDR2QjNsNjRlYlFqZEVoUzFmNGhIT1IyV3ViVEtp?=
 =?utf-8?B?M201Wmg4aXhmQ2EwK1pEWDJwRnFYNDZheXVwTTJXVVdoOXZOUlhSRnI2MTRp?=
 =?utf-8?B?UnRqc291NUlJVzhCaUUrTUhlTnc1L3ZlUzI4eUxUSE5LWkJ4R1IycThuYk9B?=
 =?utf-8?B?b2E0UEd0UDcwa0h4Y2Q5NXJORUhKbzFUb2VlcWpkQ016ZldOQjlKeXRObGdO?=
 =?utf-8?B?ZTRtdjVpalVJRVpUYjFVZWhlbDUza2huZEtZdGZqNUhTTktUbVVNL1RlL0px?=
 =?utf-8?B?czYxYXVESkp2ZkRFamRiQjJORythc1B2b0hyRzBFOWZlY3lMaGdZUUwyd2dh?=
 =?utf-8?B?RXRCcXBEd1lNUTl5R0huMkh3MytLNWpac0p2ek5UL1pjOVVkeWs0alZzN1Ez?=
 =?utf-8?B?UVU0WXYzMjYrOTh1c0NteXg1NVpmVlVIbnRkd2R2SFpZRDllOWsyc0FWelFy?=
 =?utf-8?B?QW8zMjZxdDY3ZU1IWjcyUFN4dE1jOTNXOGorWVlEQ3VBYXg5bTUzUVJYUnNw?=
 =?utf-8?B?Vld3NzVoOEJtUHdrSW96MEx2bDQ3WW9WdW9vT3UwaWNHQzBubTI3T2swQ2hp?=
 =?utf-8?B?N3laUTF4dmNnNWdndE4zbi9sRkVqUklucVlRN2FSMDFmMU5XZFFLc003TWZO?=
 =?utf-8?B?OEpMYkk3SlA2OTNydGU0RjBjU1VrSlR6cmNMNjh2ZzA3YndJd0dVVGdGWFpO?=
 =?utf-8?B?ZkFRN0lBeFo3ZjJaNFdSVnZDTDBwcmFDQXUyVU9VWmFJbjdKeG5DZmhKU2pS?=
 =?utf-8?B?endwUUxGM1NuRFB4QzNudWpabmh4dUsxMVNaV3AxRGRSUENmbUpZcUdac2M4?=
 =?utf-8?B?RTZXY3I3ZjlMcTEwTDZFcVdzQVdxdGx6MHNuVWU5TnVDblBKYXVnaXN6eXhS?=
 =?utf-8?B?dnViK0tjWW9MWCt4U0VSTHhNYTJpT2V1UW1ZVUNFU3BMRWV3TExtUXVnRlM1?=
 =?utf-8?B?ZnZjQ3ZocHgrWHNQdlEwODU4TjN3ZWtuSG9xZSt5bmlybS9SZ2Q3Zk5KQTFU?=
 =?utf-8?B?c3QzVnRwd2JpWm5jOFlwOUxoK2V3VWJ5NEYxNE1RWTNQbG9Vc0FFd0c5WmdX?=
 =?utf-8?B?TzB5cnRueFRTVk5NOFRYakg1UTd0M1FSZkYxR2Fua1B4OW9xc1Z0VEY1VTVX?=
 =?utf-8?B?c0JMMG1NRmNRZ0lIc2pETk5Fb090KzYydG9GMWgwOHMrS2JjZWpjVEVhZG5u?=
 =?utf-8?B?a1JhN0RIbTFPbDBnZStmZDBEcjM1OWZRandBMzZvZXA4di9VZm04VDN6UTJP?=
 =?utf-8?B?bnB5K2JRY2R6R3NLZGRCNE1CRFNoOEx3YUJkREk3ZXlxSDc2dE5OcWpxK29U?=
 =?utf-8?B?VzZVZWswRDRFbVQ4cXpxRXJrUTRXY3ZYajAyWXlEUkdSbmM5cG1ISk5BRldY?=
 =?utf-8?Q?cVS/3RXdBU5LxZZ3NW0q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad84f573-01a8-4ea5-5125-08dd66010fe5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 09:41:31.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR19MB8028



On 3/18/25 11:17, Manivannan Sadhasivam wrote:
> On Wed, Mar 05, 2025 at 05:41:30PM +0400, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>>
>> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
>>
>> Add phy and controller nodes for a 2-lane Gen2 and
>> a 1-lane Gen2 PCIe bus. IPQ5018 has 8 MSI SPI interrupts and
>> one global interrupt.
>>
>> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
>> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq5018.dtsi | 232 +++++++++++++++++++++++++-
>>   1 file changed, 230 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> index 8914f2ef0bc4..301a044bdf6d 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
>> @@ -147,6 +147,234 @@ usbphy0: phy@5b000 {
>>   			status = "disabled";
>>   		};
>>   
>> +		pcie1: pcie@78000 {
>> +			compatible = "qcom,pcie-ipq5018";
>> +			reg = <0x00078000 0x3000>,
>> +			      <0x80000000 0xf1d>,
>> +			      <0x80000f20 0xa8>,
>> +			      <0x80001000 0x1000>,
>> +			      <0x80100000 0x1000>;
>> +			reg-names = "parf",
>> +				    "dbi",
>> +				    "elbi",
>> +				    "atu",
>> +				    "config";
>> +			device_type = "pci";
>> +			linux,pci-domain = <0>;
>> +			bus-range = <0x00 0xff>;
>> +			num-lanes = <1>;
>> +			max-link-speed = <2>;
> 
> Why do you want to limit link speed?

This was originally sent my qcom. I've just tested with and without.
Without limiting link speed, the phy doesn't come up:

[    0.112017] qcom-pcie a0000000.pcie: host bridge /soc@0/pcie@a0000000 
ranges:
[    0.112116] qcom-pcie a0000000.pcie:       IO 
0x00a0200000..0x00a02fffff -> 0x00a0200000
[    0.112161] qcom-pcie a0000000.pcie:      MEM 
0x00a0300000..0x00b02fffff -> 0x00a0300000
[    0.238623] qcom-pcie a0000000.pcie: iATU: unroll T, 8 ob, 8 ib, 
align 4K, limit 1024G
...
[    1.257290] qcom-pcie a0000000.pcie: Phy link never came up

> 
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			phys = <&pcie1_phy>;
>> +			phy-names ="pciephy";
>> +
>> +			ranges = <0x81000000 0 0x80200000 0x80200000 0 0x00100000>,	/* I/O */
>> +				 <0x82000000 0 0x80300000 0x80300000 0 0x10000000>;	/* MEM */
> 
> These ranges are wrong. Please check with other DT files.
> 

Thanks, have corrected them as part of next version:

ranges = <0x01000000 0 0x80200000 0x80200000 0 0x00100000>,
	 <0x02000000 0 0x80300000 0x80300000 0 0x10000000>;

> Same comments to other instance as well.

and:

ranges = <0x01000000 0 0xa0200000 0xa0200000 0 0x00100000>,
	 <0x02000000 0 0xa0300000 0xa0300000 0 0x10000000>;

> 
>> +
>> +			msi-map = <0x0 &v2m0 0x0 0xff8>;
>> +
>> +			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "msi0",
>> +					  "msi1",
>> +					  "msi2",
>> +					  "msi3",
>> +					  "msi4",
>> +					  "msi5",
>> +					  "msi6",
>> +					  "msi7",
>> +					  "global";
>> +
>> +			#interrupt-cells = <1>;
>> +			interrupt-map-mask = <0 0 0 0x7>;
>> +			interrupt-map = <0 0 0 1 &intc 0 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +					<0 0 0 2 &intc 0 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +					<0 0 0 3 &intc 0 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +					<0 0 0 4 &intc 0 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +			clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_M_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_CLK>,
>> +				 <&gcc GCC_PCIE1_AHB_CLK>,
>> +				 <&gcc GCC_PCIE1_AUX_CLK>,
>> +				 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>;
>> +			clock-names = "iface",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "aux",
>> +				      "axi_bridge";
>> +
>> +			resets = <&gcc GCC_PCIE1_PIPE_ARES>,
>> +				 <&gcc GCC_PCIE1_SLEEP_ARES>,
>> +				 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
>> +				 <&gcc GCC_PCIE1_AHB_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>,
>> +				 <&gcc GCC_PCIE1_AXI_SLAVE_STICKY_ARES>;
>> +			reset-names = "pipe",
>> +				      "sleep",
>> +				      "sticky",
>> +				      "axi_m",
>> +				      "axi_s",
>> +				      "ahb",
>> +				      "axi_m_sticky",
>> +				      "axi_s_sticky";
>> +
>> +			status = "disabled";
>> +
>> +			pcie@0 {
>> +				device_type = "pci";
>> +				reg = <0x0 0x0 0x0 0x0 0x0>;
>> +
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				ranges;
>> +			};
>> +		};
>> +
>> +		pcie1_phy: phy@7e000{
>> +			compatible = "qcom,ipq5018-uniphy-pcie-phy";
>> +			reg = <0x0007e000 0x800>;
>> +
>> +			clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>> +
>> +			resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +				 <&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +
>> +			#clock-cells = <0>;
>> +
> 
> Please get rid of these newlines between -cells properties.
> 
> - Mani
> 


