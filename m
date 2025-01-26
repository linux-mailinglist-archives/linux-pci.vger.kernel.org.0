Return-Path: <linux-pci+bounces-20359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C1A1C5F3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 01:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148263A7989
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2025 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77D13B29B;
	Sun, 26 Jan 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DnvRCFlG"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354F25A627;
	Sun, 26 Jan 2025 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737851406; cv=fail; b=V7XU//a/j6M0JZVuGEtaXWFPkNwRQ74Nead/UJEPiR62WpXzdVrZs4yBCjCrR3ZdiOiL3ObL+H7M3OyHjNgzvCaYsaoyCWjaVhh4NzZz/cXuDb62oCKn2M6W9Lhu9DO4rVPEZ7cSkB6I9dr0VwBTkjBtSEV+kP2RYlzrGfDrSYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737851406; c=relaxed/simple;
	bh=hS6P+P37NQHzBB3SOZH5HkQHIb9c5KiRWTc3cAC9yWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fjjoZRg9FE6AAxKApII0Qg8uefutQAM4UUwYvorAyf9k7QAHBB9/ag0ZPfHAnU0rjIrZ8Mm7YHvKuiKzfupDpCRhjzUayZvGgL+vQy8+m1TmS0u9kSFUmbObvygFpq9vYywBHhMPNvspGDUKYeRD02t7F+EQnt2SqesCEUhUeh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DnvRCFlG; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZtek5aL2jrHmApkKuPj9IX5x/ylx1ZVmbcSh6KM196o0QGkLzbFluBumJ1b5OQDoaXgaq/IdZDwAMMkKVgUnL30xDP56p6e9hxWgosc0H/8vfPlI0l5W1na7iFbhiUpbi/MHIIDLZL5dTnfHSOVVGduNMUwvE603aW+TYLS8mfDJxOPTscV9sarEaAbm0kz4zXVPKlSNhHwYWxNt4pb71mUTzXTr8/52iTMkA/s9pW/LM5G0bEQvN7Cubu5Ly/2W2DED3Zpy3JbL8/Xn39FoK/MQ17iqytGpDF4U4wynsdWFsGjLNlupqkqp3wjQwcfyeofCqWCRd6AXrcLbLSvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WEdezbBhVKbrXAOwL90Cx8qJLjM/Tf633tnxI6Mtl0=;
 b=n6xaRJXGKsEGIqHT+d8eZ337oiwXCa7t4+9ubt1YaJSsXHlhz0jNwV7su3Q/BV+oE2nVfaM1TBXzOGU6fwXsQLvp3gRrG2VoUL8PlFjNqX/VrlhXPYRyZmoJEWlJPOz6W8r68GF3JsnrWAxr+EmW5GN1SR00vN9YzPVtHlemIFJUChW284kngtSovCeXUY+Am4iBR0c+yUs9ozcizpkQjrGtuhshk92ClhcBLP2HIZjSqDABD6IYLLiM2nI29DnHfseSUl/al2XvzS4YMNYFJNAqwWv4a6F3hPHpTQxeK3VppUpAH6SUqXYmQNOCvDkO8sUWCk0f7iP7QCYJgi1JCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WEdezbBhVKbrXAOwL90Cx8qJLjM/Tf633tnxI6Mtl0=;
 b=DnvRCFlGQKH8/qDMd1kaIsQbgMcYdLwUjdbiVi2P9iRhwPZ6/3aAWrizSRlz4fAdpdPJWWnhhb5txLT0Ym5fMYqpl58+gYx1Pg2Min9ZgyB16gCj1prPAvzMPr7tgZUBExAXPqPuXlyCmAfIbP5iXGkqzLDqCkxQSYEtTTz9Pdrv4I5/4WJTSsRlHyNXI3sO1K1B9t+AhIJsZ9qqUzS33rNBRUTWKdJHV+HV7JwyPNFn5DK/6exFzouOJlURs6vz0molaXtCHGF7dXRNiKo86Ax613iG/dtPf74q1o9dR3cRjRZTT0Of1H/+0LC/0HA0R7GDERvZ73wk0WZEFJDP2w==
Received: from PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:64::10)
 by PNXPR01MB6754.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Sun, 26 Jan
 2025 00:29:55 +0000
Received: from PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c520:8ca7:e83e:e1e3]) by PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c520:8ca7:e83e:e1e3%4]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 00:29:55 +0000
Message-ID:
 <PN0PR01MB6028F4C8A9B203B3F0A0B487FEED2@PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 26 Jan 2025 08:29:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Chen Wang <unicornxw@gmail.com>, kw@linux.com,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 pbrobinson@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com, helgaas@kernel.org
References: <cover.1736923025.git.unicorn_wang@outlook.com>
 <5a784afde48c44b5a8f376f02c5f30ccff8a3312.1736923025.git.unicorn_wang@outlook.com>
 <20250119114408.3ma4itsjyxki74h4@thinkpad>
 <BM1PR01MB25450B47C36ADE01F53CAFD1FEE12@BM1PR01MB2545.INDPRD01.PROD.OUTLOOK.COM>
 <20250122172122.vquwlodeyjpkx6gs@thinkpad>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250122172122.vquwlodeyjpkx6gs@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:64::10)
X-Microsoft-Original-Message-ID:
 <99e2c6f8-446b-4c70-98c6-1d543c4b9d22@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB6028:EE_|PNXPR01MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: c2979400-fd58-4866-babe-08dd3da08d79
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|19110799003|5072599009|8060799006|6090799003|461199028|7092599003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdFUVlpL3JKc0p4U3FkQllHY2JMc0gvd1d2NlB2RWFlWHA4SUdnSmhjdTc0?=
 =?utf-8?B?bkpNV3A1UHJPS1hlZDNZajZ3em5qaHA5QWVGOVVOQUVTcitQY1pJU3E1dDdM?=
 =?utf-8?B?QWFrMUU4N3ptblJyV3NteWRQV002eEVTUkNDZG1uODB1a2puaWV5TVlVb2Ni?=
 =?utf-8?B?cVBSQ2NVb2lWaXBEaUM5ZlJ0RFFmUktmRDJqWmpFK25aalBDYmNhTXdoSSt1?=
 =?utf-8?B?QmRudndmV2s0WDdGRW93eXZ5SHBKOEdZclEzRTkwNWYzMXZOV01jSkMrQkJ5?=
 =?utf-8?B?UC9ZaUhxWHlUVFN4dXZVRDVQR0ZBc1BkZElGam1rUlRaL1U5dXB1V01XVTBl?=
 =?utf-8?B?UGhRNnFnTVl4VVV4SjhHQnRmWnBGZ2FwdlAzbkpyblB5OE9ZSVJtQ3dWQWhF?=
 =?utf-8?B?VmsxZjNTaHUxY1lhVHFPNHNOa3pHajVkVXRzRmxHTi9NRGtCZmxOTXRZYWpO?=
 =?utf-8?B?ZjArZ0MrdytNeWdyYjdzYUNzeWFnLzJiQ0tjRmhrUG5ycDVpVkNmdjdzaFpr?=
 =?utf-8?B?UjVKR3d1Q0ZpSllyRUVwLzEyd2l2WFVSck9qZm5qY2VDVEhmVFFxRTF6UUtG?=
 =?utf-8?B?Z003aFZIWDRiZE4yUGVtd0JheHNPbm93NnExMEhTaksyMm5aM0hvbStBK3Ex?=
 =?utf-8?B?UGtRWk93eVIyRTFBM0xDdXh3bVk5Q015OCt2RjZzRFRmQzZpUTRPVXFyYXJP?=
 =?utf-8?B?OHdaSndOaEdMK2xiSnRpck44YjdKNkJkWUUvR1hIU1V4SXFhYzdGb2hBK21Z?=
 =?utf-8?B?OGFLL3ZYNUNSZW9zaGR2VE1Mei81Q0J0K2xlQ0NYdlVCcy9GZTJ1d3BDTG1q?=
 =?utf-8?B?TTZZbjBBVEh0eGNUN2RSTER1WXBqQ2dyUmU3ZXVrd0lZRFhjQXdDQ0hiMGI1?=
 =?utf-8?B?b09Tbnp2M3VtMWtKRmw5ZVM3TmxwRHkyRWpPa2VveTFBUDVuVFU1T3NtOVJh?=
 =?utf-8?B?emtVWFBwcmtONlV0MjZTZ2lHQ2U0aVVaZXFVclVSaGNaS3R5d3VwM3Q2L1pu?=
 =?utf-8?B?NjJ5RVAvOU8wME9Dd2N2YmthenBmVkJYWmtZNnRzUFFPVjBRdU5wTXl1Q2dK?=
 =?utf-8?B?NVB0MjYxZ3huUStpMDNPZ2hkTUczQmx5UC8xNWtldUxGTmw3QzhXbFgzOXJp?=
 =?utf-8?B?N3diNG9JRTQyWlhZTVFJNzNSRis1ckZvUW5OUWREVlkwckE3Kzh0UmVWOTVK?=
 =?utf-8?B?dEZ4S1NXb1V4N1IzUkhOTnVoa2d0ektTeWtVRFhFSDRabUVYR3o0cVhQMUNC?=
 =?utf-8?B?SlJ5TU1va25ucXFlWlZ5WVhEbDdJdm9KanpsbnhDSklkeUoyU2x1NmxSWFdY?=
 =?utf-8?B?SFg3R2p6aHo0WDEwS3RwYmtGU25wamZjSENidUphcWhpa0dyd0FqcVlMQkNK?=
 =?utf-8?B?R1FjNm1oYWZZQ1BBbmVFUnU4bGRHc1VGdEkvclloVnk5ajdZRnVXcnAvNWNx?=
 =?utf-8?B?dWI2aXBzcWFXWEtSemFRbVpyb0FDNjNibXNkV3M3SXZBQ1VURHVvb0VlazJW?=
 =?utf-8?Q?0OY9mw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2tlRXBLSFVxcUQweXNSUndJZmR3MHdveTlnTFdrNkRNYWFwUWpuRnlRcVFL?=
 =?utf-8?B?SWsyYU9LREhaUmhpVTlJT1ZVczNTeFBVVjMwOHRScmdhOTRCYUhHOE91SkZX?=
 =?utf-8?B?UngxbDJGcUVYeVMyblllSXRnbnZSQ1VNdlhlQWdTL3RmejNBK3BEam5XUlhY?=
 =?utf-8?B?MUR0ek1wL3NBWnA4NUh2Z2JwSzlxWjNuRU9YWVhuRmxJNmVQdGxvbkJhYjNJ?=
 =?utf-8?B?cUovWXBqSTl5UmtienZoTzVJL3grc3Vud25ZRmNvZ285bDFrSk1kcFoxa0Z1?=
 =?utf-8?B?OVo0bUUyNGJOYlZFNFVOM3lQZWkvdTBVSVdPZTlxdUVJOHFpSUJWbmFzaFo2?=
 =?utf-8?B?bnd0dVFMZmtJQjB3Vk5HZnd4SXlNMXhKOG9VdjVXcmY3NnRSM3R1V1FIU0lC?=
 =?utf-8?B?SFVNK0k3dStKNlJ1eWpSU3dJa2ZDMWNCZ1BCaHJ6Z1YyT090VWN6THRQMFRN?=
 =?utf-8?B?WDd4ckN2V0NMRkU2VHhqNUsrTElybllOL25YdDhFTUdwZ1MvdWNRdjBFMm12?=
 =?utf-8?B?YVZRRXlqbVBRTVRzbkpVRHhmMzc5YkMrUlZEK0hQT3ZqMDYxanVGeU5VZlNo?=
 =?utf-8?B?MzNyeXZqUTVyemViNDNOaUtsU3o0MGVCVVZRVDdIay9wYkRtU2ZUMHVkRnFH?=
 =?utf-8?B?Z3FxVHZTdm9ScmdUTld2OUxqZ0pOY2ZZbzZ6OUpYWkdDS245Z1NnT1Y4M05y?=
 =?utf-8?B?eG5zZzRyTDBkS2k2b0x0S1ZtWUpjcVF6Um5QNVVPYjhoRVlzUG9BT3FLS3Zk?=
 =?utf-8?B?eGFFY3ZxMFU1NzliLzZhWWtIOXhkUzZKMTkrRkVFNjl3dVczUENpN0xtN3Bl?=
 =?utf-8?B?Y3NvL29yeVNCdFkwSUQ0V2dYTVdZdjdnNmp5eEphYmF3UnNkaVRSeTB0dVV1?=
 =?utf-8?B?ZFJ3NTd0Zk1NTFlJWkpCazZ1MTVVVW4rVUJscFJqdkZyMFJNODNLRll2YVZm?=
 =?utf-8?B?S0srZFFNUHVOZXZFckw2bk03cTZ6a0MwTFdiKzZzQy9xemhXM0U4Q3VaSUhK?=
 =?utf-8?B?TVpkMmJIazVoT2piSi9BRzEySnZNcHNQZmptS3pYQ2JjWjZRL3ZPYnhwYWFt?=
 =?utf-8?B?Mm5MdFMxeTJ4Y0hkYzhCTXU0MkRjblpFN2h2YlM5OHVtc29iUnp5N0VEeFh3?=
 =?utf-8?B?NzZlS051ZHV1eks2eUZmMXcwcko1NDZ2SjlNU09DYm9rQ3BrZDR3K0p1V0Nu?=
 =?utf-8?B?dGFEendlSU1oaW9OdFA2Zml6alhMaTRETm41bE02RVNZZWJDL2xRM0grWk1z?=
 =?utf-8?B?TTNlQ24xZEZ6cDVhYm5HZWRWQWlZSXpEcU9ZWmRMdVZPbkdxNi83dEpsOWlx?=
 =?utf-8?B?UXUybHRJWm9qQTUzRzdwUHhqaEJWQ2dxNXZlRG1BVnRsWlphSTNYUVFjaERJ?=
 =?utf-8?B?bDBMN1FXZWYxcnQxb245NkFhRkQ3c2NhaFRUc0p4eEdTaEVIWTBieDZjN3dK?=
 =?utf-8?B?RG1MbHNmVHFTdUhKYjJvNk9MTlZ4ZFJST1YremhTV1YydGhUTDBnamNBY1pm?=
 =?utf-8?B?Wk5ETG4zOEliMDNLdXVLVVgzcDZxeVg2WHZEejBTQTZ2bkhEQU9MSHpRVjB2?=
 =?utf-8?B?dTV5SmYwdWhoN3BPelVTaldNLzF6Y0lQaXRVZmFBNld4MG4xSDM3SjZuMnVR?=
 =?utf-8?B?dmZzd2UrbUdEU2FQWC9sMnJ0SVRLTmNUMnNheE1kejh2SHl0V0E1Q2U3dTNm?=
 =?utf-8?B?U29ZVkpsZ3JSWTNRb0p3RkxoR1hKdDRZdzhRTi8ySGJlUVRFMlJSakxMTiti?=
 =?utf-8?Q?w9bELjNGEy/neJTZ3Fw2vIlG8GNEdVokol6s96x?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2979400-fd58-4866-babe-08dd3da08d79
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB6028.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 00:29:53.7119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6754


On 2025/1/23 1:21, Manivannan Sadhasivam wrote:
> On Wed, Jan 22, 2025 at 08:52:39PM +0800, Chen Wang wrote:
>> On 2025/1/19 19:44, Manivannan Sadhasivam wrote:
[......]
>>>> +      msi-parent = <&msi_pcie>;
>>>> +      msi_pcie: msi {
>>> 'msi' is not a standard node name. 'interrupt-controller' is what usually used
>>> to describe the MSI node.
>> OK. I will corret this.
> There is also 'msi-controller' node name used commonly, but it is not
> documented in the devicetree spec. Maybe you can use it instead and I'll add it
> to the spec since MSI and interrupt controllers are two distinct controllers.

Yes, "msi-controller" is better, I will use this, thanks.

Chen

[......]


