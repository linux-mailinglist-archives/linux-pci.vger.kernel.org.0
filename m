Return-Path: <linux-pci+bounces-34964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69784B39215
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 05:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E2420528F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 03:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29CF261B76;
	Thu, 28 Aug 2025 03:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JjRrFuF4"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC581AAE17;
	Thu, 28 Aug 2025 03:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756350477; cv=fail; b=O2xLYhnigXcBMFKEMlx6OKui3B1QyjznRlTfee0jvuu78XeCf2lIIbg+ZaZ80dwcAH17kevJos3K/ZRIxL0P9M7ZozmKHkIxaXKgCiX7/xtOo5txtaWxNia9KyLg+TdD6TQzROZVmF0MV1mP0GMWGDVfb6QB65z6eFLA4P3cG0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756350477; c=relaxed/simple;
	bh=d6jotTJWtkHhoH9ncGOswOlgkDBndRqI172zTMiqhIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sO1vqjhOxStjaPSaaG24zkTspMYxK1ZRtmHJhJ9h3brpzQXq4saYlsUlOBYPR2fpyXAl69CzZ+dHjmAPhsPFo/4GY47mcToaXKvq6GKcxCMTmsCv5cskN9H2J+s9ifmz8OoDGDqsdKsJ89suEXcVYjvY4uTJuHRwXNmMs2yefI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JjRrFuF4; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pv+wY9UL15HRj/bZpK4TYy9nj6jhjjwjBfzml9+/9IZX9qnZTcvL+TlIk4JASwULwvuqAaLsIbbAe3fI+b9GguDKmYFaCGtp8HkfQ0Uw3GT/+NU81E7bfP8cs/u6YcRGm2ndic8PEF61yrddRwXyj4eHRWqTATe6Zcst/5w0S/d/Lem0D4oriGiq1D01tl3ui+ci9ckrIYovzD11yhiv3eHZZswAReNvAeDWm0XadCGpliKR7UZYm35WXp69JVSf1W8bVLEd60BHbM2nHDCP5GeYHKW7xGK4PCSm9MRDyZsir3+O8B1IYitof/6jmeySoIwZ9g1VoIbbg44wkdNP1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiceY9n7CtHiHrkTRAYDsNOjYgD3qv/0KZkR/YC7b3Y=;
 b=KytR3jf+EHp7QeD664DVHweavxsOA3X65MiZ2QXHCB/0+78lpgT88Mz15YbfIae/KfOQwHW85w9A+m85sTIyXVKeNZ10Y13capNCKYuK1yHpZpNwOC343gdKEqfqUZ7y2B2wnaxiSufGPs5ZU6SIxooXY5SaXOALBdKEPicYHQenqydsCfTnyxAWKlSjBNxfp1IAGNElszBo6+LqJ67dCnZFfmYMWKkD0cldFbZhkSwxBJkuvrDNIfp4S00w/rzqWeAuahhGPsvlgSC5iXFc24o+4IdzBIy9Z0PX7EdsjSy6YodPEDhPPSRkxIFPMfPQ2DWDARfo7e3VPAKZVQ9pFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiceY9n7CtHiHrkTRAYDsNOjYgD3qv/0KZkR/YC7b3Y=;
 b=JjRrFuF4fBnf7avx8fi1jRZM2aT8vOcWir6iipluN17crPqmL2wIMoqOrvbB2FSA4glGKcqH+yR5ZBKZWz+i79oV7zm8c+YFsU7LpdctBKavi5m3n1tuwcZsPgJSJxx3Zbun+BBbXI9gOi1V1uYYbzAyRhu5bkUKNTtmMFJfa2amGEqYgMPi+h99zYo9Ws4mBFUw+TXMXMA3rsUDOMOAZEaUiC24z01TGTK+aVBZyRHn+u8QOMtj1CS+JYz/Mi/pwBhAHD00cRJIbvSu875ipxtf5DVkJs2+VVVX0c4DL47Yd0HbI/5J9wlQ10ZLTTGssP5Up3mH+JZmvPjXPfAJEw==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MA0PR01MB10057.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:12d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 03:07:47 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 03:07:47 +0000
Message-ID:
 <MAUPR01MB11072BD9282B8B1F9F9C653E1FE3BA@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 28 Aug 2025 11:07:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
To: Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Nathan Chancellor <nathan@kernel.org>, Wei Fang <wei.fang@nxp.com>,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250827230943.17829-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250827230943.17829-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::18) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <71d906ee-81af-4736-80fd-15b236420989@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MA0PR01MB10057:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f951e72-d376-4161-d932-08dde5e010ad
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|19110799012|8060799015|15080799012|5072599009|461199028|23021999003|6090799003|4302099013|51005399003|3412199025|440099028|40105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmdHNHlRTEpDM1MzdUJGdVlmZ3lIRHFVb1IxTHd1Zm1MbU5JRFJEdzg3R01I?=
 =?utf-8?B?MTdTc2pzYmtyU3Yza1VId0VORnlmTnRrN2ptdTRHSmw1T29qU3lqWVZad0VQ?=
 =?utf-8?B?UzAvUHNVS2FacDQ4N2Zhb0ZYbnJFUFJtd0MrT1JhY1ZxWDRsT2VEUWxTUFVa?=
 =?utf-8?B?bE5YRW1pelFoZUdqRzlsQ2JUd2tqSm9Vd1pyUnVIcVZSZGdhcDR2YTFOUzJC?=
 =?utf-8?B?YTlMaWQ5QlJxY1FOaldjcDhTUnlPb0FlWFNST1dNRDlCZWNlT3Z5dU8rTDBl?=
 =?utf-8?B?SWRUYlhGUUpBNS91UnhUbU1KaytCVVhFZk00SXF1eXVmRkQ0Q1FJMFZzOFNQ?=
 =?utf-8?B?YjdnZFl5ODh6Zzg0elk0bEsyMXl2ZXVDVVZXOXVyeEtRemVCQ1hFeHdmWWpS?=
 =?utf-8?B?SFVMcUhXem42UkRWbTJvS2JiOENWMFF1cVYxRXVhVGpMaW5oc3hIZ0FHbEd1?=
 =?utf-8?B?SkxxbHNXN0xNem0zZHB4cEF4aGdDTGxIMnVCMkVIL0tKOEI0cXhaSmc5SlR0?=
 =?utf-8?B?V1FBclE3ZTN6cklzTHYrMU9vcmw3UXhXUGhGbzFrK0YxS3llS3Btc0Fnekpz?=
 =?utf-8?B?SEFveHN3M1lSYW12NWg0T2lFKytQOEJMbUtkYVdoazRMRkx2V3pkR1RsZktj?=
 =?utf-8?B?SU5uMG5CR1I0alc3S2ppMkJBemFaSUJrcFcxVDlUNUtINlpHcVJKa1hyWU8z?=
 =?utf-8?B?YzVxUzVxcjhBRnhRdVJXelBBb0FrdHVtc0FpdHFkWW5ZMXJ1TXZTdHgzQ2RX?=
 =?utf-8?B?cTRQdXREeVZmMmZaVWFMV2graDdHc256cTdTU0ZLL28yMEFxc1RKblFvRGFU?=
 =?utf-8?B?cS9SYXN2dVNocFduR0RDT3JRaEoydXczcU5VR0IvS3JRT1h3TkZIRWd2V292?=
 =?utf-8?B?MUVHcWpPMk5UZ0dkUXFWRHJwMnBBdEpiclhGVE0rYzdydmlFTVMrVEd4ZmdI?=
 =?utf-8?B?V3FEb21XMGVsamlONWtJUHBmcnJsMGY5cHNpdUtSTUFsWEJUZnFrMWY1SDNj?=
 =?utf-8?B?aEFIcE5wWWpMTXNJQTh6UWhxTEIzWlRhYWVzcUk3ZzkxMDJQRlVUWlRoWGUw?=
 =?utf-8?B?TlBCSXV6YXlkSzdjTWdWdHdkSTc2RHZ4OVRsYUhtVy8xNmVZbGV5SjZKRnZV?=
 =?utf-8?B?S245QkNaWE9ldmJHbVRsdjU5ZHZlZjBtZTRqczlXbVVQcFZsOGhhV3FZNmJz?=
 =?utf-8?B?a2I4MUhlalBNdGFCYXZkcmpnUEl5U2F1ZVBCeXQ5KzRrR0Qycjc0TEdqT0pp?=
 =?utf-8?B?R2hHenpVVHdjLzBmQ0s0ZUNKSkFDYmFzNzlwb01PUUJoWkh0REYzVTk1SUZL?=
 =?utf-8?B?bzZ2RW1GQTRoMUxOK1BFQnNWNjNsdGVTTnJnd2pCMHZCOFAwVlJoQWtNK3M5?=
 =?utf-8?B?NFlveFlQMkpzVHUySTRaS0l0QXRQbENjRXdVdlNaOC94ZTFnRHltaTF2ZXVs?=
 =?utf-8?B?OHIvRXNxYUN0MmZ6MDRTeStPUFdyKytnY2R3WWMyY1ZZd1laV3J5bGdDVnlO?=
 =?utf-8?B?dzVySnBvZVRNUzYvZnJkNkVoa2FmMUh6N1ZDWTc5NVdUQnp1d0l2dnNZdHdZ?=
 =?utf-8?B?M29jUThwN0ZtVXF5TDBpeUxnVjVlN0lTV3ZpVnFGS080dFNPN3pxOHRzRE1S?=
 =?utf-8?B?L2U4YmRDL0FzUXF5LzRzUW90elhBMllzVDhPYlMzSzlyMkQxYkNxZ0hHN2NG?=
 =?utf-8?B?VWJRLzlBcjJkeVVNbnBQTFF4aVBJT2tOVW5jYlBQNWRxYU1uYnNmWUFud21t?=
 =?utf-8?B?UHdQR25ReFhrallvaUh0WkdvZmN5SjVwTnhyd0hXUmg5cHZLSmJVbFMycUgz?=
 =?utf-8?B?cm50K2J4c1Q5aUM3cS9qQVZmWWZDQW5CczdDUDFkL2J2ZElpMTRITUVHMHh0?=
 =?utf-8?Q?MqzAhbVQLLouQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3pnYjRTODFXUjJaWjFyc1N4THNpcE9zMDQzQVdVanVtNVVDanNNaVo2YnJt?=
 =?utf-8?B?WGlTYi9CM3hiWDVHMTRhbUNsZUFydG1KYlEyV1VEZjFTV0FQcnVMNGQ1UW52?=
 =?utf-8?B?T3h3a2R1akkwVnYyYXMzVTR3bGNHMmwrVWllVEZpeWJLYVlJQUN5UGtMTmIv?=
 =?utf-8?B?b1AvemFEYmJqODRsVFRRaHpUanlCODg0R0ovWHYwWUc5b2t2SHpIK1RYVTd5?=
 =?utf-8?B?QUNuS3Y2WXgxN0xCdGZFM0UzRFB0V1Y2Q0RNdjhBK1JhWDNXRUtLWUxDTllM?=
 =?utf-8?B?TWNETUFNR2I1eG1tVGJLeUcxVHZRN3NFYXdRZkFCcG9TRWdqMGVxYUNvMDk4?=
 =?utf-8?B?M0h0NGpaTzZnWGNuaGtTWitFSXJiVkhPZ2YvRjBTbmYwZi9odTVmMjEzSFFR?=
 =?utf-8?B?ZThQK3JadWtRWkNMU0k3WUkvMm45Nk5oa3hPcUNHREYxOEkxYXFZT2o5NFo0?=
 =?utf-8?B?SXpaaXk0SnI5TVQ4b2VwY3VaNVRBNTUzanIzSExudm9vZHlvWUx2RmZEd1VV?=
 =?utf-8?B?a3g4ZzMzWHA0cWYwSXZWR2JwaGlSTUtlOHpQeVh6MTd0YVhZODZnckhhQkdQ?=
 =?utf-8?B?QVlwVlVTNENsdWtmTVFVVFg0ZjQxSDFxK0VvWkErcHpaQ2lqRHBFMHMvU0o0?=
 =?utf-8?B?UlZkSFViVGxiYmJmRnRrbmQ0NmpEVmh0SDFybWIrMnJ2VTk2VXRsZDZ1NkRr?=
 =?utf-8?B?QVhyKzhWaEwrQmZuZFZOUG5LbHBFS2JSbzAvbFpscXZHYmxMbnRnWWI2SWtS?=
 =?utf-8?B?ZmJMRlcwUE4vMVF1cnNYYUs4L211QTNKR1pmdm9ROEFvaG8ralUrRXV2WVJm?=
 =?utf-8?B?cWZNN09wbk4zNGdiYWlnWDdnZVFDdEVlcmlzSTMzcUt5UVFYblFGaDlzRko3?=
 =?utf-8?B?ekliSjFvSWFsMFRQL1c5YUdKNWVHYVZwWWVkay92YnJhdWU4SDc1YVNadFJy?=
 =?utf-8?B?YTVJd0NnSXFHanhKckVwOHF2dFdxQkdWQUZ2SFFqTWIxVnAvclppU3NpQ1cz?=
 =?utf-8?B?aW5OY2VaSjlrRzdHMGcyWHpFb2tFQ1ZaRzBpREVHRmJnNElmblN2ampubGtZ?=
 =?utf-8?B?OVVSRVlrcm84bGpBeWNYTFhRalFtTkFXMTdMcDRnWVpxRmhKaVNkdWJPRU1U?=
 =?utf-8?B?L29sNEYrYlhvOEx1S1ZxRzd0MjdQaW9tbUxvMnFMcHpSbVVNdVdUd2hnTnZV?=
 =?utf-8?B?OVNGRTZVQ010UDVKSnBpN3pUalRUS2Nwc1Q4OVFUbEJYTnVGbzN6bGpFQnpK?=
 =?utf-8?B?cGxhZTZ3QklleTBoRTNhWktjK1BaVFYraDB1TjBEdXhhT01pdEszSzYzR1Vp?=
 =?utf-8?B?Z3lrUUVkcTBlenRZd3V1RkxoV2pYRmhlR3I3NVUwWS9oc0FCL3hKQ3VaMDBl?=
 =?utf-8?B?cmJUTjY0UnNDR2dCWjVDMmY4bk56T0VGM29sa3RGaFYzcmJkNjJxS0k0bmt2?=
 =?utf-8?B?ZW1xMEF3QkZ3cW9kVUVpcDVxV0ZMU3NYWVRmeWIwdW1ZUE1BZ1ZFOWFpUU5N?=
 =?utf-8?B?dC9rTkJEWlNaNmlXVW1VclViS24vZU5OVlI2MlFkQjVJVUJKUWpFbDJ3eTYw?=
 =?utf-8?B?NVhHL05RdmEzbWcwMkR4YTlMQjFzUVlKbjJQSXRBd3U1b2tZRktIY3RiMUd3?=
 =?utf-8?B?S0s3dllqV3hpZTZzRTdFaWF5cC9xRFFRM2JjMGhESU9zUzhGbm4xTS9mRzFh?=
 =?utf-8?B?ditvL2lJRTBMdXRiY1lwYWxXcTFMVnFuMkIxc29NTWNjSEdoclpnM2F5T3pC?=
 =?utf-8?Q?U7AkEe3rRRclJmeIMBoMIRNPHvWt5D0t5pbxRfS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f951e72-d376-4161-d932-08dde5e010ad
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 03:07:47.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB10057


On 8/28/2025 7:09 AM, Inochi Amaoto wrote:
> For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> the newly added callback irq_startup() and irq_shutdown() for
> pci_msi[x]_template will not unmask/mask the interrupt when startup/
> shutdown the interrupt. This will prevent the interrupt from being
> enabled/disabled normally.
>
> Add the missing check for MSI_FLAG_PCI_MSI_MASK_PARENT in the
> cond_[startup|shutdown]_parent(). So the interrupt can be normally
> unmasked/masked if it does not support MSI_FLAG_PCI_MSI_MASK_PARENT.
>
> Fixes: 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/regressions/20250826220959.GA4119563@ax162/
> Reported-by: Wei Fang <wei.fang@nxp.com>
> Closes: https://lore.kernel.org/all/20250827093911.1218640-1-wei.fang@nxp.com/
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox/SG2042

Thanks,

Chen

> ---
> Change from v1:
> - https://lore.kernel.org/all/20250827062911.203106-1-inochiama@gmail.com/
> 1. Apply Tested-by, Reported-by and Tested-by from original post [1].
> 2. update mistake in the comments.
>
> [1] https://lore.kernel.org/regressions/aK4O7Hl8NCVEMznB@monster/
> ---
>   drivers/pci/msi/irqdomain.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index e0a800f918e8..b11b7f63f0d6 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -154,6 +154,8 @@ static void cond_shutdown_parent(struct irq_data *data)
>
>   	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>   		irq_chip_shutdown_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_mask_parent(data);
>   }
>
>   static unsigned int cond_startup_parent(struct irq_data *data)
> @@ -162,6 +164,9 @@ static unsigned int cond_startup_parent(struct irq_data *data)
>
>   	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
>   		return irq_chip_startup_parent(data);
> +	else if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_unmask_parent(data);
> +
>   	return 0;
>   }
>
> --
> 2.51.0
>

