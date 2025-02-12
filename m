Return-Path: <linux-pci+bounces-21265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE9A31B88
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 02:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4308A1676ED
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370356DCE1;
	Wed, 12 Feb 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aAITlcDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2D4D599;
	Wed, 12 Feb 2025 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739325031; cv=fail; b=uYPvJLL9tyLdk/JD/Dw/sufEF5gKpwrb18AID5BRZQK2iQZiAxnRczsnDjpl4s4BvUD5JbEfoy2ObwAfcSMLcbExgQ/Ad1LNrHHu9CKlLASrWLJOqiUkJbO7RCxsVHDO4kzmqv/yQBV0BhMGfKoCefQMep/TXoXBqE7PLfhopmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739325031; c=relaxed/simple;
	bh=tx3tukYbgtPORNTRzqV/0GRcqK9H3+Qxd9uwyM17QHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S3qlwpDl/AJgI/upMsNse9hZBXPGU7WDJ+cMuzD7eMMK7SjNHG/dZQLdqHrna7wPCPsjgyLCpeXbhaO7RdvQxtujGSlTT9NxY24gMBukPs82HFC/FRGITWqFYwuAkuHnnzNxF4tOG29bUN/pl2pZpBnxuuWLhE2V+KpdE+Ru44c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aAITlcDV; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EF1RsyUcOWXfbL5gL6hzdTwaiIw4pFGa5g1y7UTcLeJY5k9Glk6QTexMiohQjDbB+qI8lyY0V2rP16aLU98QxLVZ3FrOXsJOwd+oRfy8qIztDAVA4hjBJh0/vpckU1Be2K9Ge/oeYEbBPJYzlxfhENYkE7+skROGaOWjNQbRITKCyc3nsDRM8L4W7KqbyqqqnGHOL9QgdDrbfDrUl3Kb+U09FgwrGV5r3FYnqHHyWTTxBpsVn95ktNPr4zKj7TPasR/wR6+VMqYx1dvFh3b8OpAieQuoCos06VP5PoyGCbn//fNXLg+mMKvZ69YT+3toNY0AD7piW7M6AUQq4kL5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe7MKNbGhjNEVFAfFAnq2WeO4qUvvW2qCmpQ81LQeIM=;
 b=YQfel8u8mdSJ2XfC7sM4G8TSynF77pEUiTRbg0mBgDcO8zrN5D4La5HWOgT6ceYR1Nu2/4Obs5xevA0sz4u93YRj0z+DQ9xpFbLOqkIrcH5E2UM9AMspifcIyCY9ONCifNOLXnbw5PhO5dGy1UH5fKsBgt5ex8DxXE1Pj2K2a27a5+PSeYOhsaC/1dRs86vESaSkfI78SI4F4yekYN8RnPo4SlwVFhDgH3qS9gqS79bQE4qYdmJ9ahpJqqttILlvdKOWK6EPbuwls9SEj5b6kvsm24mECHh8+6b1TqgVOs+LAAtBFwHUtEWnK3P93j/LHQbmRUlvagKs2CdBwmiX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe7MKNbGhjNEVFAfFAnq2WeO4qUvvW2qCmpQ81LQeIM=;
 b=aAITlcDVFhROyscYyyaJQKAmx3ctc678sHKonByj1VeUliRvolQTTG2LqtOLdOZF5HsZ5i+R/xDRG481SVOuLN3zUH1eGHjNtn+7/VriIUuN5wRH8qzCXNvLaF7jAYmnzB8PBSD2gcz7JVa0iQJRl4qQ24zpuv3X4FE3RTtmR7srlyvwwd8J0/uBl575CrPw1H8umt769FweCGed2wX5dFcyCcKOqH9t2HVj0POE7h6jAPDgINpQojm7NMA+PHv43620afZYr/TAfPNVCHCPpnozW1XZp95HshsaQq9QSgzcO2tJR+er/nqCb1BbxJesaTT/kLNB5JmG6SG6X+My4w==
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:3a::19)
 by MA0PR01MB6005.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 01:50:19 +0000
Received: from BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71]) by BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::2148:4778:79a3:ba71%4]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 01:50:18 +0000
Message-ID:
 <BMXPR01MB244057AE697903F8C2947FB8FEFC2@BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 12 Feb 2025 09:50:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20250211233430.GA55431@bhelgaas>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250211233430.GA55431@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:3a::19)
X-Microsoft-Original-Message-ID:
 <4ed691d5-70b2-4624-bd38-25ce8cf713f3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BMXPR01MB2440:EE_|MA0PR01MB6005:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d95609f-a362-4ae3-3b26-08dd4b07993f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|15080799006|19110799003|461199028|5072599009|6072599003|8060799006|7092599003|4302099013|3412199025|440099028|10035399004|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amtZNjQ2dllHV2xMN1J0b2hQUWswL0VoZ2NYWEYzdjA2c01sT3VzMiszaGFO?=
 =?utf-8?B?c05vRXh3TFFMcUZHbjVRM1RJSm0vaGV1K3hDVUVLU3doVGxLMlZ2Qm5KSkxX?=
 =?utf-8?B?S0RoR1NRbTI2MWRYZ25Gc2dRMFpDUEFFd3V6enk4UGx2by85aGZjMHo5Rlpl?=
 =?utf-8?B?a1kybjF3aFV6cE1NOWxIMDZOWTN5dEFwZGdGUVBad043cUora2ZrVi84MWpq?=
 =?utf-8?B?SHZFWEE1bGJtbTNncjhFWklqVGQra1BkaDM1aGRoVzArMjFsR1ZBZWVETERZ?=
 =?utf-8?B?WFR6NllKbzZWZ0ZpZ2NVYzBXVGxWbk04VWVOUmJsdm9BZUJtYzJFdVBaVDl5?=
 =?utf-8?B?SHUzb01mdldqV0NsRnNxbFdIWUJXdE0rclgrQVJyUEFzeDNPQmNhUlQwbGJH?=
 =?utf-8?B?NEcrVTJEa2NrcXBJdXUwSnJLcktCZERnRDR6OHBnZWdtMEcwcHNvZXpvenBk?=
 =?utf-8?B?STJtNFJJYzlxUVg0Y0t6YWlUdE1kSFJVK3hHVUhpR3pCWVBqY1ZNMzFzVHpk?=
 =?utf-8?B?SUR4a2Z4Vld6S2VRRkNWWWRnMHFYdHJNYzl2WHgybXlVUmpsemtaZ0J1Vkxw?=
 =?utf-8?B?NDRmVXNVdndUSGlpQTkyRUZ3N2VkNHJTMmYwQS9LelJaMVZEM0RKUHNNblda?=
 =?utf-8?B?a1F5S09xVWtoOGQ1aVVPb3RYTWxTMXZ3OUVsamNlZkY3azZhSDNkdnFaVUta?=
 =?utf-8?B?NS80QzhGVFZBNVJqQkdSTk1zSnFLak1PNmFEUHVQYnpPdlhQb2hIeGpwa0dY?=
 =?utf-8?B?V0dsRVg4bFhOZFVpQkt6TjJnMHA3aXUrR0l6ZFBnT2hOUjVkcG5Vb05oSjRy?=
 =?utf-8?B?aEE3RklkQ3RSdDRYa0E3VnN6aDhOQmE5aUYyTnIrMjY2ZmplU0hZSzdiZEtt?=
 =?utf-8?B?RTI4Wk9qZzFPdjZWV2JRWmVuTlNOYXBLWllvY1lzbUJ6eG4xNCtGZ01abWE4?=
 =?utf-8?B?UjByaTlKVHE1aGpEQ1Y0aGYrbGUxVlp3U3UwNHVIRmUwRnFoZkxyY25FakVD?=
 =?utf-8?B?M0lLaUk2NWl2V09BcE1nVXRMK2w3bWJpOVFJUENiUmk2RXhobXl1QjdPVll0?=
 =?utf-8?B?YlppdGFvL1daeXViK2c1aS9zTEFQOGxpQSt5bDFCRVpiL2RsVE5nbmg1ZVhq?=
 =?utf-8?B?WUZuQzRYL2V1TDU1MmJobC9adjhUWC9mRUdiSUZQaFBIR0RUT1FJMkFuVURU?=
 =?utf-8?B?cGJEUXRRM2thcldRemRwZTVZU3VxbENpb01GUVpGM1VadlRFT3RGSlZ2TnVr?=
 =?utf-8?B?T2F0VU45SzJaYnM5ZHExeHFvQU9oY2RTTENPUllLSTF5Vnl6SjFNcm1ZV2hj?=
 =?utf-8?B?VFpmSlhQL25sVzFyRy8rVlhydUJsUG1Pckd1M1JRNFpzb2RhZEI4aXVlbkJU?=
 =?utf-8?B?NHM4dGp6cURIRDlnOU5UQzJ2Sk5kejhoMzlGL0hWUzBWSEpjY3VKMUhpWk9R?=
 =?utf-8?B?TGpFNEorZnFIR0tQTm5DZnZqYWJSOVZ2eWtjcmpzai9QRnVsWVhPTm94Mjl2?=
 =?utf-8?B?L1VYQUZhNGY0TXh5U1NYS3RJUFRsZUk0WGYyVytZRE0zMmQ1ZW1SQkhLMXA0?=
 =?utf-8?B?cXMxWWlPYWxpa0thS2RlWHNVbDZHRTBjN2QrMCtjaHZ6SmNlZko1NGFkK1FV?=
 =?utf-8?B?RXNKZGJ5dDdhOUhJWnpOZWEwRlllZDFQS0xHUUkxaThZcVJYMzR4NFN6WktR?=
 =?utf-8?B?NzRhZmhZRkRHSS9RL0RNb09NVndyS08rNXAvSko5eGd4QWVrUjRiOWRCeUdt?=
 =?utf-8?B?ZTllc0dLWEs3MlZ5cFlVdVFlZFlZRjNFR2swTDcyTkpkVzlCMVFNSkE5YkYx?=
 =?utf-8?B?TWEwdWxLejVKUjQ2TVprQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTF5THozWmg0NEF4d0VlQ0c4NEZEcno0dnJDZjFZNG1kVEdQK0U3d3RQQkJy?=
 =?utf-8?B?TnM4cEdDQk1NZDNPTjdBbTl0T3I4aXBOSnlyTmh2aDc1TGNXb29ZNm5jZjBq?=
 =?utf-8?B?MUhISVU2SHpTekdVcUFFdldSZjZQV1dQekQ2QjlsMkIyNjRBTTQxaHU3ZnJr?=
 =?utf-8?B?bzVWUnpoWXIwQ2NYV3dSVy9meTY3NlhrNHRURWVCY25SM0dta2d2cnovQUc4?=
 =?utf-8?B?d2wzeEJ6bFhVbEdUK0ZHSjhCWFV3czM1ZUlZaWR3ZG5ORTh6NEY2bFlUZlFS?=
 =?utf-8?B?dW5aeVI4dTNtQmoyUUZVdlExZk42SDZwb09zam43WFZkMGROOWtpU2hueWN3?=
 =?utf-8?B?a3ZmTjFDQmxEUUkvMVJjbGd1MTZyYm5ZbXB1ZFhtQWJ5elhKWWV5VHZtSmtk?=
 =?utf-8?B?bXhxUGNORWJ6MzdXTW5HUkRBSjQ5OEx5cjJ3RHdRL0lQcUVoZ3RZOVU5SDRF?=
 =?utf-8?B?ejBqZVAvOWlMZm5SeEJ3SWE4dXdvTkZ5YzR6d1pXM1pUcVJ1L1AwVGNoYjlG?=
 =?utf-8?B?cEI1ZWVqbXVmN1JpRmNQNFQyM0k3OGFWeDBFT3U5eGZVVFM2L3pMV284endU?=
 =?utf-8?B?V2VqOS9uanNJY3pQQmRTVDVNNVhSbjVhYjd5YjRLaFJWOXBRdU9ack9JWjlR?=
 =?utf-8?B?VkJHRDVWaTBBRTVKWEtGaExzVmNsR2ppZkluQmJxcWx2VUNwV0FvVWVYZ2d3?=
 =?utf-8?B?TkpMVjhnZExvZFVPakRzQ3pZaWVVMFQxaTJCOXBwMG8zNkhPaDJTNTBxMGdq?=
 =?utf-8?B?ckhIY21KbzkvSDU3cUs5ZUx4TW9jb1dZUDdqdktTRm9oZzZKQnB3N1h1ZEFp?=
 =?utf-8?B?VVhQQXM4Vm0zcUluREViQ0g5K3A5R05lVVkvMDkwWFJkU3FXaFBuQUdBT1Jx?=
 =?utf-8?B?bTdoSkdGZmxFQVVEbUwwdmpYamdjR25rUUF2Q1FGUU1saTJTdWo2MmhhOFBS?=
 =?utf-8?B?NFFYc0pXc3VGMWpvQmxaaHJSL3VCVWY2K2lQUE1uWjNhenV6VlZyTmZmVjUz?=
 =?utf-8?B?TUlkSk5ldzZYZmpiRy9LNjBPWDE3bm1yUzhFVEpUamxTaXZlNTd2cHRsZ05E?=
 =?utf-8?B?dDBwVkk3WFNya0k2SVlEZGJNTFVDNlE1N08yMHh6OEF3NE02MFg3K1RrV1o3?=
 =?utf-8?B?NmhCOEhNUDMwYUkvcEZCbkpFMXVVc3JuOFROR0JCb1hTaU8vTm9UeEFsb0c5?=
 =?utf-8?B?dkhYKy9CT29HOGw4ZGNsRTNHWXpiUmpXUkZZL0E4d0lIM0RjME5PaHppTEpQ?=
 =?utf-8?B?L2NzR3NMUlF6eUJLZ0FMREZpWGdQd3JwNGdzVUJmMlhBVWVsdjJsRTJNeGdu?=
 =?utf-8?B?aCtScW9hWk5nOTk0cW4zck8vbGdINUFSSy9ac0dNdG1XdkJLT1JwWm5QaE9M?=
 =?utf-8?B?VG1DSTByN2dPWldIZHBwTDMzRUI0bnUzYnYvV00rREJ6WmhkSnZ0ZGRNbkIw?=
 =?utf-8?B?L2w5NWVHZlZOcWRTR1FWVHZLbExMVHlWaGdVOVEzY04vOVNBNHFYYkhSNW5R?=
 =?utf-8?B?VjRQNWo4RUlQdFdFZnFHK3l6NDIwd1pDL0NBT2tlQk5wVWRLUnlHQ0xWNzB6?=
 =?utf-8?B?Slg1R2lTTmVRUUdzWEZTTjRFTmlYU2RSWmhwN1dpM1FPMzJjcDRNTDcvQ3Rm?=
 =?utf-8?B?N0hLVjFHSThHREpVdk5pRXROQ1kwUEo4VnhCY3JWaDRHendUV0dDMUszREFS?=
 =?utf-8?B?MTFmeU9WUi9HcDBZY3JjZzd0bGc1bi92OEFtN1ZNY3plcGludzIzM1g0Q1pN?=
 =?utf-8?Q?gsn4HrnuncdgR46os5IjSngQ0zUSTKEGKzclVXY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d95609f-a362-4ae3-3b26-08dd4b07993f
X-MS-Exchange-CrossTenant-AuthSource: BMXPR01MB2440.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 01:50:16.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6005

Hello~

On 2025/2/12 7:34, Bjorn Helgaas wrote:
> On Sun, Jan 26, 2025 at 10:27:27AM +0800, Chen Wang wrote:
>> On 2025/1/23 6:21, Bjorn Helgaas wrote:
>>> On Wed, Jan 15, 2025 at 03:06:37PM +0800, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add binding for Sophgo SG2042 PCIe host controller.
>>>> +  sophgo,link-id:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description: |
>>>> +      SG2042 uses Cadence IP, every IP is composed of 2 cores (called link0
>>>> +      & link1 as Cadence's term). Each core corresponds to a host bridge,
>>>> +      and each host bridge has only one root port. Their configuration
>>>> +      registers are completely independent. SG2042 integrates two Cadence IPs,
>>>> +      so there can actually be up to four host bridges. "sophgo,link-id" is
>>>> +      used to identify which core/link the PCIe host bridge node corresponds to.
>>> IIUC, the registers of Cadence IP 1 and IP 2 are completely
>>> independent, and if you describe both of them, you would have separate
>>> "pcie@62000000" stanzas with separate 'reg' and 'ranges' properties.
>> To be precise, for two cores of a cadence IP, each core has a separate set
>> of configuration registers, that is, the configuration of each core is
>> completely independent. This is also what I meant in the binding by "Each
>> core corresponds to a host bridge, and each host bridge has only one root
>> port. Their configuration registers are completely independent.". Maybe the
>> "Their" here is a bit unclear. My original intention was to refer to the
>> core. I can improve this description next time.
>>
>>>   From the driver, it does not look like the registers for Link0 and
>>> Link1 are independent, since the driver claims the
>>> "sophgo,sg2042-pcie-host", which includes two Cores, and it tests
>>> pcie->link_id to select the correct register address and bit mask.
>> In the driver code, one "sophgo,sg2042-pcie-host" corresponds to one core,
>> not two. So, you can see in patch 4 of this pathset [1], 3 pcie host-bridge
>> nodes are defined, pcie_rc0 ~ pcie_rc2, each corresponding to one core.
>>
>> [1]:https://lore.kernel.org/linux-riscv/4a1f23e5426bfb56cad9c07f90d4efaad5eab976.1736923025.git.unicorn_wang@outlook.com/
>>
>> I also need to explain that link0 and link1 are actually completely
>> independent in PCIE processing, but when sophgo implements the internal msi
>> controller for PCIE, its design is not good enough, and the registers for
>> processing msi are not made separately for link0 and link1, but mixed
>> together, which is what I said cdns_pcie0_ctrl/cdns_pcie1_ctrl. In these two
>> new register files added by sophgo (only involving MSI processing), take the
>> second cadence IP as an example, some registers are used to control the msi
>> controller of pcie_rc1 (corresponding to link0), and some registers are used
>> to control the msi controller of pcie_rc2 (corresponding to link1). In a
>> more complicated situation, some bits in a register are used to control
>> pcie_rc1, and some bits are used to control pcie_rc2. This is why I have to
>> add the link_id attribute to know whether the current PCIe host bridge
>> corresponds to link0 or link1, so that when processing the msi controller
>> related to this pcie host bridge, we can find the corresponding register or
>> even the bit of a register in cdns_pcieX_ctrl.
>>
>>> "sophgo,link-id" corresponds to Cadence documentation, but I think it
>>> is somewhat misleading in the binding because a PCIe "Link" refers to
>>> the downstream side of a Root Port.  If we use "link-id" to identify
>>> either Core0 or Core1 of a Cadence IP, it sort of bakes in the
>>> idea that there can never be more than one Root Port per Core.
>> The fact is that for the cadence IP used by sg2042, only one root port is
>> supported per core.
> 1) That's true today but may not be true forever.
>
> 2) Even if there's only one root port forever, "link" already means
> something specific in PCIe, and this usage means something different,
> so it's a little confusing.  Maybe a comment to say that this refers
> to a "Core", not a PCIe link, is the best we can do.
How about using "sophgo,core-id", as I said in the binding description, 
"every IP is composed of 2 cores (called link0 & link1 as Cadence's 
term).". This avoids the conflict with the concept "link " in the PCIe 
specification, what do you think?
>> ...
>> Based on the above analysis, I think the introduction of a three-layer
>> structure (pcie-core-port) looks a bit too complicated for candence IP. In
>> fact, the source of the discussion at the beginning of this issue was
>> whether some attributes should be placed under the host bridge or the root
>> port. I suggest that adding the root port layer on the basis of the existing
>> patch may be enough. What do you think?
>>
>> e.g.,
>>
>> pcie_rc0: pcie@7060000000 {
>>      compatible = "sophgo,sg2042-pcie-host";
>>      ...... // host bride level properties
>>      sophgo,link-id = <0>;
>>      port {
>>          // port level properties
>>          vendor-id = <0x1f1c>;
>>          device-id = <0x2042>;
>>          num-lanes = <4>;
>>      }
>> };
>>
>> pcie_rc1: pcie@7062000000 {
>>      compatible = "sophgo,sg2042-pcie-host";
>>      ...... // host bride level properties
>>      sophgo,link-id = <0>;
>>      port {
>>          // port level properties
>>          vendor-id = <0x1f1c>;
>>          device-id = <0x2042>;
>>          num-lanes = <2>;
>>      };
>> };
>>
>> pcie_rc2: pcie@7062800000 {
>>      compatible = "sophgo,sg2042-pcie-host";
>>      ...... // host bride level properties
>>      sophgo,link-id = <0>;
>>      port {
>>          // port level properties
>>          vendor-id = <0x1f1c>;
>>          device-id = <0x2042>;
>>          num-lanes = <2>;
>>      }
>> };
> Where does linux,pci-domain go?
>
> Can you show how link-id 0 and link-id 1 would both be used?  I assume
> they need to be connected somehow, since IIUC there's some register
> shared between them?
>
> Bjorn

Oh, sorry, I made a typo when I was giving the example. I wrote all the 
link-id values ​​as 0. I rewrote it as follows. I changed 
"sophgo,link-id" to "sophgo,core-id", and added "linux,pci-domain".

e.g.,

pcie_rc0: pcie@7060000000 {

     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     linux,pci-domain = <0>;
     sophgo,core-id = <0>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <4>;
     }
};

pcie_rc1: pcie@7062000000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     linux,pci-domain = <1>;
     sophgo,core-id = <0>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <2>;
     };
};

pcie_rc2: pcie@7062800000 {
     compatible = "sophgo,sg2042-pcie-host";
     ...... // host bride level properties
     linux,pci-domain = <2>;
     sophgo,core-id = <1>;
     port {
         // port level properties
         vendor-id = <0x1f1c>;
         device-id = <0x2042>;
         num-lanes = <2>;
     }

};

pcie_rc1 and pcie_rc2 share registers in cdns_pcie1_ctrl. By using 
different "sophgo,core-id" values, they can distinguish and access the 
registers they need in cdns_pcie1_ctrl.

Regards,

Chen


