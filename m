Return-Path: <linux-pci+bounces-22993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAA4A505D7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 18:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A91886D58
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 17:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B41AAE28;
	Wed,  5 Mar 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="amxf6MXY"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2089.outbound.protection.outlook.com [40.92.19.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A56151992;
	Wed,  5 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194001; cv=fail; b=qWB9yIKUoJ69J56PXyL44XQc6DMcgUuw2IRl0DJYp1EC1T3MEeVLc1bnbXDgQHNGM8o51S9xo17UeZ69tBKkvbbmqTnG7WSBHUXvZNJ8UamjNWsQQ/crlNE4w7u0n3L0PM/HAYPPzKfN3twD3nK8JcnltGlYpR6ADSFlj4RI8po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194001; c=relaxed/simple;
	bh=bKuyhAqSTuSog0m6FfcZ0/pUGBKVHN4aYI0Qcj9puy0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G4T5FoD2c98HvYzcJn5OwxRLPEFZPcBU8oAAZoyEUU1TnsvNydTDAxZwYU0UOVRvJONONXNBzyFK3FzD+qUHp9At7vdK2HRTx4bslks+c7Lv7XyEbWJpE7pfz1GHObBaNV11YQ38Qk7PfXpj4zsqq7fzkpUg1fSdktXb9Ffuvds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=amxf6MXY; arc=fail smtp.client-ip=40.92.19.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYrG+QdXSAEnEoLOc7WXxLYCedDS74/KW48+KlZ/cnODhJHpd7UZVuIoay009z38bC7iENbbGFTHcYbuC1MlJtGNjQugp1Jc74ReRo4iWJ7tCftu+Let8MUNokz5Cf7XZ7xk4Q0jRXOzEwPyCg3d6PCuaW2Df8fIGCFZJIkHEExuPJQ+4i3TsfsjPsnCd/fWNbO+irxA3chJRBbm6zlvh6NU8/G7Kez1vTjoXNYD5fz4NWiBydsMRWs6TIUTpdlx6mHmPxC7Xol1mgpvMWgljq5LNp8vraTsvnvy8jI4QVa9QtSr4csJfRZJ9fX+MbLjIhPOhnqAHCyvw40KFiejUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkEspnWbsMIj/zJAhp3hKLNxAQbgUCmMYFsuVlWpB38=;
 b=TuFiGJM1S0s+sN8SUuXz1dNISywm+OX0cuds7iyh52qphwoVh1tybq8vFV49uZazjmuZi15ZgqWbe9bEodmpX5CsSPiVnPxan1vCgycXPczhzmCz28Q5PNlw9cGNUUEuUSlf14GT9clLa481Y9lipYTpngBrUcneLeClOIHWSxNcieI/9oLmGempbiKarfQAVVjlLa2/XmdhZfXV/qB0kWOF/f219UJkXGhpxLaHaOTMULNV7tPW9QddnhRjHN16WOxrFVQfflLVOYp6xpwg8Xvpj/8WZqVwDpLn6ItCfBAFn2LebXLpKhdhIzQTLv3SJ2hW//vBcVnoRHwDa6LLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkEspnWbsMIj/zJAhp3hKLNxAQbgUCmMYFsuVlWpB38=;
 b=amxf6MXY6fBuiQNQk/r/I81T1MGbpBg8eaPbz1bIGVFTAVBp69NeMwTb/8K4sxL4l+5bgbhWH8aD2DPpo7U3T+iObTxgpF4ZKgL/l7qP2M9yQN1ec3UnaADOFKIs61jEjPvB9zz4/UQ/ydlEUyifKZH87+mwn4QlsVXU1QtNePLJr7D+lGCWvXA8KWQeF/d56W51uHfAEYzp0aNxKljQRCAYZkm+4LSEFY5geUlBmQyfUREkaUMtD6+63qeW12BmJlCRa8wTXh0azmMbHt4wEf51ISEH5t0EE6VlFTJjcmh308DFvIq4GMaWVGsR640Z9NOsHbFCDo99TWoKgbuQzQ==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by SA0PR19MB4635.namprd19.prod.outlook.com (2603:10b6:806:bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Wed, 5 Mar
 2025 16:59:57 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%6]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 16:59:57 +0000
Message-ID:
 <DS7PR19MB8883484545BE6AE9E12B5AF69DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Wed, 5 Mar 2025 20:59:44 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Enable IPQ5018 PCI support
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, andersson@kernel.org, bhelgaas@google.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dmitry.baryshkov@linaro.org, kishon@kernel.org, konradybcio@kernel.org,
 krzk+dt@kernel.org, kw@linux.com, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, p.zabel@pengutronix.de,
 quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com,
 vkoul@kernel.org
Cc: quic_srichara@quicinc.com
References: <20250305134239.2236590-1-george.moussalem@outlook.com>
 <DS7PR19MB8883B5F3CC99C0F943BEE9DE9DCB2@DS7PR19MB8883.namprd19.prod.outlook.com>
 <b28b1778-8996-48a5-901e-807a1b820999@kernel.org>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <b28b1778-8996-48a5-901e-807a1b820999@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: DX1P273CA0026.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::13) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <50b21ce5-9fb6-4bd7-92ec-a8ec2593f961@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|SA0PR19MB4635:EE_
X-MS-Office365-Filtering-Correlation-Id: db6dd93b-584b-46f7-88fa-08dd5c0727f0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|461199028|5072599009|8060799006|6090799003|19110799003|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVBUVlcrc0N5ZmZ5SGFTaWxWQnQwU3FXL1lFUUxST1JJbnBIeHBZZU5IR2FP?=
 =?utf-8?B?MlY5TGJHZ1pIa1YxcWZQSE1UNVFHK0p3V2hrb0FCYjVUbzY2Q2F5eUVaV29R?=
 =?utf-8?B?Y05jUW4yQW9lWG9MVVQ0NGd3RUgwcHRoSEowUVJMN0hRb29pRWJnd3BVNmFi?=
 =?utf-8?B?UUZVMnhVRzdMa3UwYzV3ZzVjYkRiRlJWbzFDb1kva01RV2QvY3J0STFsTGtw?=
 =?utf-8?B?bjlWMGZxVXlOQytZODJKWmFrbGt2TldxV3Rtc0I1cTBCUDUrSnVOTlQ2bzFy?=
 =?utf-8?B?OUs4Kzk3SnFMQ2NCSGVoR1pJbFZuK2FPSjRwM3VDN0lkSk4yc1l6T2M1cSty?=
 =?utf-8?B?U3piemNkMW00anNJWTBKTHV4SzNDenVLdy9aeWJUU09BMVJNOWdtbG54OXk3?=
 =?utf-8?B?bkNURkd6VDhNWVBPemVaWVR3V08zcXZNbkowbFh5M2VlVGw3ZENBYzlJREY3?=
 =?utf-8?B?UEh2SWZoQTJ5TWQzd1FZQUJDNjdrbUgzMVRhM0lRMzcrQ2ZUeEN5V3NDeVQw?=
 =?utf-8?B?TTZYQlRWMUthbmJ1RFo3bFVSQnpUQXdiYzRuMGZSZjgzZThIenZyMTltWThW?=
 =?utf-8?B?NVNPenJvYUxaa3VsUld4L0U4SC9NK2thZjhYRDdNZ2RQYStyNHYyZWZNRDlp?=
 =?utf-8?B?aFBRZU51dy9CclpCdEFnNExOVDIxamxmNGJDbnMvekRCODJhVk01LzFaSmR5?=
 =?utf-8?B?S0kvT0FLb2ZTMnZhakZyaHE1THBadm1HVGUyZ0s4UGZmSkwvWEk3eS9kcXVQ?=
 =?utf-8?B?TkNvam1yTTY0cUZGYXZpTzRpMkcyOVIwWWNRaFp5aVpIWlNtK29JbndiYjZO?=
 =?utf-8?B?cXhpeVBIQmhiclRsYitBYW5Kb1lyOFoxVUtCdityZzdxWURJcHdlNk1oSTVh?=
 =?utf-8?B?ZXFOeHdrL2pBcjAyS0Z0N3h3U1E2QTBsSEl2WWFVOHNHK2FGSFpFQ0RNTExT?=
 =?utf-8?B?anloVXFXY2lsTXNkNjJKMVhHUDkwMS83elBNR0wzNEFyeGU5MWpkRnR4RmxJ?=
 =?utf-8?B?d01MU2luTzYyaVlPbkRMSHY0dHpRbWEvdkNDOWxlQ0JYYzFFeFQ1QU9nUXdh?=
 =?utf-8?B?V0RqMkVzTDhoWjFaTUpjcDh2bkh6Yzg5R0FXMEV1eTljbVo1NjJEcnhWK0ph?=
 =?utf-8?B?b1V4bFdlVmFxUmNwQkZOS1JYdkhBUVFIN3pQdDh3QVVlUWtsV1IxQk96NEhS?=
 =?utf-8?B?WjN2byt6UHJZZ2JpVjhDVXNxeFZKbzVyeWxXUStxd0VmWG5jT1Q0RXgvanNF?=
 =?utf-8?B?U3pUWjBjaERQSkI1SUwvTlkwNVdHbVhVRnFKK2RkZEo2ay9tZHJHdEhySmVh?=
 =?utf-8?B?RUp2SGNwZkRUb1BPbFo1VWptRFpxdi90UlFDT3NPeWx5S0JHZmJ4OFpiaUxE?=
 =?utf-8?B?dzBFVDZXb3MvcGdBSTYrQjM4WFJTUjJMSHpma3VqV1NTWnl0ZHdhT1RreFdM?=
 =?utf-8?B?cHhRdERBREhYNW5NcVd1NW5xSkkzemRGbXRhay95dk1lMWozWkdzNmVNYUd5?=
 =?utf-8?B?VzNwV1BZeUZyZW0zUGFLS1poUHNndERnUW8wMmdnQUJKL0ZCZ0U2MkJGQ2lk?=
 =?utf-8?B?Ym5FUGpSOC8yWCtjU2dNeGs3c1luM0RYN3ozVGN1dUg4Nkg0TW9uUUtUUG4z?=
 =?utf-8?B?a0NGTjQ0QmhNVEpxcUEwbmZQVzlzL2lLSVNZanhXeHYyVnBkS0RPTklla25C?=
 =?utf-8?B?KzQxbUNRdlNrdzQ5OExkS3lnb2JWUUZ1djZJKzV6TVhhaHk5ODNub0hBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFh0MXErUldTcDBvZDhUaTVJZTVoMGdwdFdreUJmVmt6Mi8zSE1majlRYklZ?=
 =?utf-8?B?Snc5T25zSlJuSU4rVW9wMURPYlpHeUd0Ymt1YW9TanpOZjlvbDMraFRwbWQv?=
 =?utf-8?B?YXkrR0dCMVpsUTlYVjNKc1lwcHQ2MVdiZVNuU3YxTUtVWkRPRkNvR3ZZOFlG?=
 =?utf-8?B?aFhlTk9IanJWRXptR21UZVhGeHpCMjhHVXEySkhEcmYwKzczYUg1V2tXZGx0?=
 =?utf-8?B?cFFzbCtqYmw0TDIzcm0vS0UveUlkQTlnN1MrOC96TXNPbVI4eE1kSDgzRTRl?=
 =?utf-8?B?bkhVdU5Yd3kzSGpaamRBSFZNYmQxdXRqb25UR2pkRW1oTmFCZUN4Q3lYTzFH?=
 =?utf-8?B?OVBJNVpHb3ZDcmQ5T0M1Ry9YUjRyN0ZURnhvUWY2eVZWMVZhVlYwVXhMU29L?=
 =?utf-8?B?VHYzcncxVmEvSDdROVgrSG9RLzhlNU9PeDdhUjlZY2lONk5PZ2c2RjFjZXNv?=
 =?utf-8?B?cGFrbVBlM2U0ZnM1a2puSEkrRExlUHFhL1BGbTh0bk1kS0diMTRvUElnMmVv?=
 =?utf-8?B?Rm5QbVJzcWo2NnVxVG9POGw2Z1FLeFkwZ0dkYVI3cnN1TUI3N0ZvcnF3OXJG?=
 =?utf-8?B?M0E0NzkxUmZlei9OVTFYeGFFUlZhcU5zSURPRktoZTBTRVNMQ09QaTkydEk5?=
 =?utf-8?B?L1Rla3lzZmNCWkRXQ3Bkdkd2S2RYUWxkVU1NMXlaaHhGZEJreHJtSXl0U3Ra?=
 =?utf-8?B?V0hGaEtnczdSWEdYcm5ZdEhlTTY3aGtsb3l3NVpPVDA3N1liZGdjTU55UEcr?=
 =?utf-8?B?UVJJZ3M4WExXUHhGZjJzL2x6Vzc0R09Bbm1OcUdoUUhTenIydmhRQlhyYW5t?=
 =?utf-8?B?dDR4UG13cCt6VGhuTlhjeDRxdU52Z25jVm5jZnF1VENxZjlFeWd1elRuOVI3?=
 =?utf-8?B?aDJGMzBlekR4YjNrQTMwRCswckhhVzdDNFBtRXFEdG56U2FodncyVGM4N2hU?=
 =?utf-8?B?VDluNmxrNjNCWWJzMmcvQTNad2dHT3pKRVdYaVpYenhSRmh4SzJ4VnJVeHBF?=
 =?utf-8?B?NThJSnc1SGdBNm9WdHplVnlPbHhqUExrdUFLQndnVUxPR0FsTTlzZzB2TVM1?=
 =?utf-8?B?cnpTS2h1S1FJSE9DaW5MSnM2VjFQczZKTTBNQTEyNWM0UVJ4RHBNdytxbkZ1?=
 =?utf-8?B?MDh0U0RiQTZ1NGdUZWRiMGVnMEEwSytCL1AxNXVXcDg0bm5zOHk0UmE2NWtJ?=
 =?utf-8?B?K3FkZkxrMXcwZHdpL0hIbTdVZk5CdU1IcHlNRDdOWnRwWGhvbUZsYXdJM1NZ?=
 =?utf-8?B?aE1nTkgxZDRlOXdhM0w0MVZ5THczbGNWcWlXOHMvT2dsaDZpcmNkWjlmdDRy?=
 =?utf-8?B?dHZoMnpmUUErL3h3Tk9FUkZJYXVWM1h3anRDWks4QzlFS2Q2YVRhc1JkMFll?=
 =?utf-8?B?MlJjQlBWRExCS2NCd2pDVGxsSittL2hDVi82L2FnZ05DYkhocy8yUHNidnBL?=
 =?utf-8?B?bUR0eXVidzh6V1lmQjhxV1c1S21wc29PZ3VZa1ZPVlBBZ0xkRDNMVUlxRlJo?=
 =?utf-8?B?VEdFbkk0QUJMSWd3a1k0MGNMQ0QzV1VXeE5jcWRjcS9QK2NoSUtsbU9YYkJy?=
 =?utf-8?B?b3BUa1U2T1lPbDVzVktRREM3bHJ0MDgxY3IzT2drZm5HU0cyQVZpU2VBZEpU?=
 =?utf-8?B?aWg2enpYRmkxZWVIajFTSGlRemIrZ1o2NWpMR0sxdHJXVDdickxLR3FzQnc1?=
 =?utf-8?Q?emDtiFJDtz9bWzWY7HQq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db6dd93b-584b-46f7-88fa-08dd5c0727f0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 16:59:57.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4635

> On 05/03/2025 14:41, George Moussalem wrote:
>> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Not correct From. Cover letter should be written by you.
Noted. I thought I'd keep the original author included and added my v3 changes which you rightfully pointed out should have been v4 instead.
Will remove in next version.
>
>> This patch series adds the relevant phy and controller
>> DT configurations for enabling PCI gen2 support
>> on IPQ5018. IPQ5018 has two phys and two controllers, 
>> one dual-lane and one single-lane.
>>
>> Last patch series (v2) submitted dates back to August 27, 2024.
>> As I've worked to add IPQ5018 platform support in OpenWrt, I'm
>> continuing the efforts to add Linux kernel support.
>>
>> v3:
>>   *) Depends on: https://patchwork.kernel.org/project/linux-arm-msm/cover/20250220094251.230936-1-quic_varada@quicinc.com/
>
> Wasn't this applied, so why is it still a dependency?
I explicitly added it as ipq5332 has not made it to the master branch yet. Should I remove?
>
>
>
>>   *) Added 8 MSI SPI and 1 global interrupts (Thanks Mani for confirming)
> Who did it? This v3 or other v3? Which v3 is this one here?
As I mentioned, I overlooked the v3 submission and based this series as the next version of v2. Thanks for pointing it out.
>
>
> Best regards,
> Krzysztof
Cheers,
George

