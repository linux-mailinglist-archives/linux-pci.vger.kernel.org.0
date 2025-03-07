Return-Path: <linux-pci+bounces-23125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 386C9A56AB8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 15:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 754EF18881A6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639CE21C17E;
	Fri,  7 Mar 2025 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lKKaDyJD"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD2321ABB6;
	Fri,  7 Mar 2025 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358664; cv=fail; b=OgGl2Erjdi38jY13cpDi5oBmda68ElaENC1R7HPG0k5BXZAyYSWiWTQPW+nblglNnqzQzqTd4zrjcqo+gJOLKRYspnC3ARPWMX2FbyTQuIJZbOhyvMwCYvCSweAMvGHpP+VWXfhcwfpq4aVIRE5Q3KAYHwoFvs9ghSCRbisE9dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358664; c=relaxed/simple;
	bh=LTG/2Gd9yCpyuT5NVGACuci//NuVtYmIEcm2Eo0FGwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kK6a46IHSQXyVT7QAc+IO3yzLchK5K5lutpj627Gc5/WqfZVeVonmpPKmdx1dzmZWE9GrueG3JSwhxCqsDppbIwZiQeT18alaGOO4AQ3K0oEg9lBtjxXnrAlK6TsdR4EVWWMmQ5yvpWiraX4aMxe372MsVBnucoPUJYXccI+bcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lKKaDyJD; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwCFr+XB/AuAG8sNCGAKVM+trqFTK5YtKmo+Gsh+7XdGiyiM4x1443imiGcIarqsOaH0BRUnT1pQ78kIDZBQRebC5/UoVNcKpBNNWGc1KPjVuLc8NgVWRwnLtSNoqDdjVfdEokVIFIJwH6ZhD409gSOTaVUFTfqoNiIfbSsgxSA+SF3adV2SGX+mygWZB+q4xEQqDlDMW0Sg6nDLaxMyu0dVWSxK9heJKY0o6D7+2LByAMrIEKVGwesJKGGMuUZwM8W98mnkCm3nv18VIVD0/RwS7b9LIfSw83r2d8na+wW8zE9i7ZD/20EWun5kJ0LZPZIDc0ps/o6sVhJQPasaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TmA0mFT0fGOyoUT13PrInWs1lHXprLbbvTgefFxJ20=;
 b=JEFSII/BQm5BnWLcWUiDKXDBeYQVpn3h2XkdUut5srjmdIRGpYx4HWNdCCf8UCdJGxdEiwI+4CrpEtnRLbt8gScrruJeqDBFNNuZ4svvgVSOJMKooHnsKcD/OUwpY0hldd1BBqLGydCHUs+4rP9++Wq39P0thjUQ8RZfheHDnxvD4qB3F4ls5SxQofjcqrgjQd3RMldo6e3ivuWvLzz6Gg8Od7h18qofKVbvmYn9T3IskFxcTRKlKUWHrv8jua3NOweyqtkwL9fbi+2/7m6vdl8gSiEbkvrDEVsI+sO1TJUDx6BJQICuU0SGC8O82Aqo8j64Up4wLkGV1o4qnYEjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TmA0mFT0fGOyoUT13PrInWs1lHXprLbbvTgefFxJ20=;
 b=lKKaDyJD2qP4kP2UarB9HIT7ixmHK9v/UjRVlD9iIt3woimE+oF2V5lxGrGw/GbxW1cXAvy/Wet7l+Aq3RaDEBOyEXMiKBiO7RyD7k/QUvE7alKYATgAgGtuDKwQKXxr0bBkGcPlrvqrFiFnOTfDETjBJg9ImEt7Zpb9uPdfJkNuaY9wCl1aD9xbcckXQ9Qxxv9c6J1njzX/JE9yn0xzjbgt2XshXJlVVMFeoojiPHnyJJorfP+5LEzGs+AFhFY2h7JgebrYO/+xPujp2anW8bb1Q3rJVsCnIwmFAlBDeloUPRIaOsb/d2UuJFas/FLTv0PweiQTtn5stmARbrnq5g==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by PN2PPFE3A607474.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04:1::3ac) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 14:44:16 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8511.020; Fri, 7 Mar 2025
 14:44:15 +0000
Message-ID:
 <PN0PR01MB10393326D387DD49EF563F787FED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 7 Mar 2025 22:44:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: cadence: Fix NULL pointer error for ops
To: Siddharth Vadapalli <s-vadapalli@ti.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Chen Wang <unicornxw@gmail.com>, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, thomas.richard@bootlin.com,
 bwawrzyn@cisco.com, wojciech.jasko-EXT@continental-corporation.com,
 kishon@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 sophgo@lists.linux.dev
References: <20250304081742.848985-1-unicornxw@gmail.com>
 <PN0PR01MB10393C44D1F4B9189C52D31EBFED52@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
 <20250307134727.m57er2ky6e3dmftl@uda0492258>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250307134727.m57er2ky6e3dmftl@uda0492258>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <cd5c779d-18a7-452f-9abf-ac2acf76a5ac@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|PN2PPFE3A607474:EE_
X-MS-Office365-Filtering-Correlation-Id: 74be1fed-3218-4ca0-f4b8-08dd5d8688a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|7092599003|8060799006|461199028|6090799003|1602099012|440099028|4302099013|10035399004|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXJNNnJRZkpMN0NNQ3dGNXU3TExpajQ1b0Y1dkgrYk4va0c0ajZzUG4yQ1Vz?=
 =?utf-8?B?UldYNDhKemdTMkVEaUI4a0F2TnhxZUh4aDU4ODdRMWhudlFQNUZCV2QvL3Zi?=
 =?utf-8?B?TTRXUHN5U2VoRzlrNWo3OVFNNGd6UjVVb09yTEhWeGFzSVIzRkd3QjJIbnZt?=
 =?utf-8?B?WU5lSDNGYWFPWW92emhoczQzNTRnTkFPQmt5aGcvV2tmTUF0OXNxdDI4aHNP?=
 =?utf-8?B?d2VCS052WW5LSjlkd2ZESkZBQ3QzSmFzMFVxbWh4RmtPODFlQ1R2Z0k1UHZR?=
 =?utf-8?B?cGpFVEdpa0pVUFhMVktVcW9GS2ZMcUFESlF2dGVQTWdhdTlMclRjQXV4VWtT?=
 =?utf-8?B?VU9SQ200R3AvQVY2aE1OeklRY0wrc3dlOFJDSkRwYzNaZldrYjRrNXVrR2wy?=
 =?utf-8?B?cSt2cU55WDFiV1JWQzV3RENSY3M2THkwSWx4dWw1Z2VnWDFpOE1RQU1sMUdq?=
 =?utf-8?B?cVdkM09GSFh5Wnl2c2lPU0ZDaWprb1hrS3o3M2JaaXVxb2FCcCtBRUZLN1hD?=
 =?utf-8?B?bTROaDJHa0xLWWFtMGRobWRlUXI0R3lJVnFDMHQ2bDdCa0RXMTk4R2NyTE9h?=
 =?utf-8?B?YmI3YlR1NHN5eTQyMEREcFBseFNCVlJvcVcyV080RUZhbmVpSHdnTW5PMytL?=
 =?utf-8?B?YXZ0MlVSSTVVYTJKTDJPbklEMlhra243U2VZcGRVcC94ZlNFZHZNM1hCYXBB?=
 =?utf-8?B?RDBoM1ZTT2NlMXFxdHlNWkM5M1owMU90QjI1cmk4cDhtejBXMEl6aktIemgx?=
 =?utf-8?B?cHl4NnVNWm1nZFQ1b2pJVk9jam1ENml4anNDT1JwZ0ZPeGdTWEg1UzZsMmMw?=
 =?utf-8?B?dkNoaVZzbWhNcDhCQWpvSHVQMmJ0cGJubTBVYjBkZC9KMDE4VmdNSXA2YlZF?=
 =?utf-8?B?L210ZHUwY2xMbnRjU0g2WEZjTEQyYjRkRjI0TU9mVEJnNzJ6TnQ3SjZiVElW?=
 =?utf-8?B?dFdDbHVLK1JQNXIyL20yQi9lbnRCeU1FdFYzWUg4TFVpeVpKQWtjWi9XL2JB?=
 =?utf-8?B?SlBRMCtvaURnUlVxeGsxVjg0K0x0ZlkzZ3R0bHN0bHU4L3JNTWlXWnVNKzl4?=
 =?utf-8?B?OFFCeitnWUlhMUZIRm9zSjRYVDArbno4djBjZkxqRDNEUGEzbjBpT1ZWNTJB?=
 =?utf-8?B?SVBESnhEMGpkK21oL2M3ZGNkNGh4d3YvRStYdFdZd3VDQmpmMTMvR0RVbTB2?=
 =?utf-8?B?N3haaHNoQVI2WndIUUwwdXNrVUk4NDNHaEVUSnY4czA1ejg4a2tTUVNGVThF?=
 =?utf-8?B?Ulk3S0VwcmNOdnRnNnBIaGhhN1ZaYjNqVTh4TS82dEhXN0RwNHpUd3lFOHJy?=
 =?utf-8?B?WXd5M21QR3hzTjRuVkZNRXFIUlBKaGNmR1ZYbEROOW5jZ2IwNkJrR1F3U2I4?=
 =?utf-8?B?N3FVcXJUUFBQWG9wZC82cjVGV0hBMUxFMTYwUkc5aEpWZ2UwR0EzQmk4RjBo?=
 =?utf-8?B?VlViNnVoczlJbm0zd1hOTG00U0R5UHRERXZoSXV2SmVLYmNYTWpRM3d0NGZr?=
 =?utf-8?B?QlFTQjc4MnRnR2RzN3A1WWdIaVUzUmZnY3hLcHZFc05ucVZjTXd3WVZKZFpj?=
 =?utf-8?B?UEhiNzN6cnJ4Misvb1JXVmdXV0JKbFUyL2oybTVxRlh3dDQxOE45UHNjYkZX?=
 =?utf-8?B?K1Z6OGw5RncvZ0VmS2RzWjZZRWd6ZnNSWW5qUnJPWGoyQXhOdzJpSFNyR0hy?=
 =?utf-8?B?V3RWM3JXRi9sWXhVdHFWOC9RUzVwNlVaOFhzdy9qakhRSmV0QVJaRjV0b3Q5?=
 =?utf-8?Q?8vcRvk3zR19/L6UeSfnhmP5uZzDeM+cVk/nOpSW?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXdvZkw2N0I3T1R2a1JsdW5PblZEOGFCT25yUGNRUkRETWg0ZnlDcTRvRnJk?=
 =?utf-8?B?Z1VyejhxeG5LSFVHSmpNMjREVHVlcllsUVpUOFJ6MG5uU1BWZjdLV3RBK2lk?=
 =?utf-8?B?dzcrekxBcVNTR0QzdWFEQU5GT3RYQ1MwQitkMmJYYnZ0OEE0RlJlMGpuNTJ5?=
 =?utf-8?B?amZTNlZLVmFYK2lGeTZwOGx1Q3Vyb0RTSGZSOHhoT3l1Nk9zV09QcUhHeDI5?=
 =?utf-8?B?aW5oVENoQWtXSlVIMmdhMThwVlcvYzVJb1hmNmlXQjZ1MXFac0ZYNDVPQ0xU?=
 =?utf-8?B?RE92ckhvMkI3dmgvcmZaV0d0V0R2MDdnWEdwY2xQcnlhZ3pPU2VBYUVWVkdD?=
 =?utf-8?B?bG5ObzZSbjU2Qi9aZ0IvY0dGRnhGaUhUQS82RGtjdmVKVzN3R2NhSERDenB4?=
 =?utf-8?B?ZC9Xa1lJaUZNZlpCNXB3ci9GRTlUdHdoaldWSyt1dlFVMlk2ZkJpYWFXbDJk?=
 =?utf-8?B?cklMdzBNUVF1OGVySCtBSGFPeFZXbjJQanAyM2EwdE81ckx3QlFDMXMvYzFF?=
 =?utf-8?B?eTJhWTdobm8zWVV2Z2oybWpBZjhOTmxDbXNqNWgrYWs5UXJGWS9Jc0ZsSm83?=
 =?utf-8?B?UWlUTE8wL1dHeE1ZYU10bWtyWjZJMnJWZHZWMm9ZZldXaEZGd2htWFpPZW84?=
 =?utf-8?B?VXJtMVZRYlNYWE5xOG8wcVc3WFVpWndvN0dQM25FRUl2TVp6QW8xU1dlSGtu?=
 =?utf-8?B?aHl4L2pjSUxiekNrWDdCYUNKbys0WnJ4L2EzaWtaY0ZsNXl4MVhTT3pEYkc5?=
 =?utf-8?B?ZVNqRUJ6b2F3a3FJR05QMTVoN1A2NzBzNmt4cndNc0RUV2NOS3VvNUhXbnEw?=
 =?utf-8?B?RHdzSXlCWDNMbWFKeVVYSThSU0FwWm13aXd0RVFGQ0ZIWXRkR2tYbzJDalcv?=
 =?utf-8?B?SmJSLzJDQUc3b1hTa0FGK3NBbjFoYnI3V3dJM0NaT0V2QWF1YjlEY0lYYktE?=
 =?utf-8?B?ano2QmFkSndyb1p4QmMvZm42N1VhMXR4aytIc05PWHh5aWxVYzFEaGozdXVZ?=
 =?utf-8?B?MmQvZDdjMVJuaWFLVm13NFkrbEtCUnZSWWxJdmxGV3JIMmFWNUg0anQvaU5n?=
 =?utf-8?B?SFdkMXBEZDlGOUliTVpxbU56TlJUdlNKS2FJQXZDUDFKTHVoR0JTZXM2K1NF?=
 =?utf-8?B?Q3NCc1BwbW5IZlV1QlJsV1FJZEdwVHJvYXJQODNDTGJkSG9hTVB3N0lhRVRH?=
 =?utf-8?B?cEZ3K01XVE9yYkpDWHZxQUxMZzloY05OTWdhT2c3RUN0Q2JtVk9LalpZNE5i?=
 =?utf-8?B?QUdGRVhNelVUdDVoZFY0a05sZHBwdGE5UVFqKzVYOTIyMHJDb1Q0bFJwcGc3?=
 =?utf-8?B?RElsb3hvdTZQbjJtSHN3VU93eURSQ0gyMDdWNmFLZ0kxUDE0UjJwcU5VVEdo?=
 =?utf-8?B?Rmc2SDVKckFISlpKR3pYSy92ZHdoZTZTdnF1TGtDTDRMMGVhVUVZL0x1YlBK?=
 =?utf-8?B?MUxnTHhReXlWYUNyaVorSDBqM3R4dG80L2pxWFFwa0laR3ZIL2xVMDhzTHZy?=
 =?utf-8?B?VHZJUENlQVZmMWN5dzRyQVhuS2M2cHdJMzRXNW5aR2N0Mnd6b0g2SXBoU2ll?=
 =?utf-8?B?MHYxQmZLTDFoV1Y0YmxVWFVxVGdQRjlGQ3RDLy9iYVQ2Y1IzNEtCR0xYZmFz?=
 =?utf-8?B?N3I0QnNia2IzM0l3bDN4SlF1OElvcVdiUDdCT3pvb1Z6TUVPMUlNdHk1d2tB?=
 =?utf-8?B?cm5ZMnhxL2EybjVpYWkrWVl0enZQU2o3T3lDRTUyOHoyck9oU1poL1Y1SXhV?=
 =?utf-8?Q?eF+ASzTYX60lnIsfpECzW6JYbpBQsYK6Q8PRrb9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74be1fed-3218-4ca0-f4b8-08dd5d8688a6
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 14:44:15.9010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFE3A607474


On 2025/3/7 21:47, Siddharth Vadapalli wrote:
> On Fri, Mar 07, 2025 at 09:07:35PM +0800, Chen Wang wrote:
>> Hello~
>>
>> Any comment on this? Or can we have this bugfix patch picked for coming
>> v6.15?
> Is there a driver in Linux which is affected by the issue that you are
> trying to fix in this patch? Please point to the driver since I don't
> see such a driver.
>
> Regards,
> Siddharth.

Oh, sorry I didn't explain the change history clearly. I am developing a 
PCIe driver for a new soc (SG2042), and this PCIe controller uses 
cadence's IP. In the code, I found that if I don't assign a value to 
cdns_pcie.ops, it will crash during operation. At first, I didn't fix 
the bug in the cadence code, but used a workaround in the SG2042 driver. 
Later in the code review, Manivannan pointed out my problem and hoped 
that I would submit a patch to fix this problem in the cadence driver.

Adding Manivannan who should know about this.

Please take a look at this: 
https://lore.kernel.org/linux-riscv/20250119122353.v3tzitthmu5tu3dg@thinkpad/. 
For your convenience, I have excerpted some of the text below.

```

 > +static struct pci_ops sg2042_pcie_host_ops = {
 > +    .map_bus    = cdns_pci_map_bus,
 > +    .read        = sg2042_pcie_config_read,
 > +    .write        = sg2042_pcie_config_write,
 > +};
 > +
 > +/* Dummy ops which will be assigned to cdns_pcie.ops, which must be 
!NULL. */

Because cadence code driver doesn't check for !ops? Please fix it 
instead. And
the fix is trivial.

 > +static const struct cdns_pcie_ops sg2042_cdns_pcie_ops = {};
 > +
 > +static int sg2042_pcie_probe(struct platform_device *pdev)
 > +{
[......]
 > +    struct cdns_pcie *cdns_pcie;

[......]

 > +    cdns_pcie->ops = &sg2042_cdns_pcie_ops;
 > +    pcie->cdns_pcie = cdns_pcie;

```


Regards,

Chen


>> Regards,
>>
>> Chen
>>
>> On 2025/3/4 16:17, Chen Wang wrote:
>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>
>>> ops of struct cdns_pcie may be NULL, direct use
>>> will result in a null pointer error.
>>>
>>> Add checking of pcie->ops before using it.
>>>
>>> Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")
>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>> ---
>>>    drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
>>>    drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
>>>    drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
>>>    3 files changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> index 8af95e9da7ce..9b9d7e722ead 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
>>> @@ -452,7 +452,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>>    	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>>>    	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>>> -	if (pcie->ops->cpu_addr_fixup)
>>> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>>>    		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>>>    	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
>>> index 204e045aed8c..56c3d6cdd70e 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.c
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
>>> @@ -90,7 +90,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>>>    	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
>>>    	/* Set the CPU address */
>>> -	if (pcie->ops->cpu_addr_fixup)
>>> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>>>    		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>>>    	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
>>> @@ -120,7 +120,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>>>    	}
>>>    	/* Set the CPU address */
>>> -	if (pcie->ops->cpu_addr_fixup)
>>> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>>>    		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>>>    	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
>>> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
>>> index f5eeff834ec1..436630d18fe0 100644
>>> --- a/drivers/pci/controller/cadence/pcie-cadence.h
>>> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
>>> @@ -499,7 +499,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>>>    static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>>>    {
>>> -	if (pcie->ops->start_link)
>>> +	if (pcie->ops && pcie->ops->start_link)
>>>    		return pcie->ops->start_link(pcie);
>>>    	return 0;
>>> @@ -507,13 +507,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>>>    static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
>>>    {
>>> -	if (pcie->ops->stop_link)
>>> +	if (pcie->ops && pcie->ops->stop_link)
>>>    		pcie->ops->stop_link(pcie);
>>>    }
>>>    static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
>>>    {
>>> -	if (pcie->ops->link_up)
>>> +	if (pcie->ops && pcie->ops->link_up)
>>>    		return pcie->ops->link_up(pcie);
>>>    	return true;
>>>
>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

