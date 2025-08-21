Return-Path: <linux-pci+bounces-34435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B23B2EE52
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 08:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC531C83055
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 06:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC9C182D2;
	Thu, 21 Aug 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ersEvnMx"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F519255248;
	Thu, 21 Aug 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758348; cv=fail; b=a0UCfQ8aJ709OZDGUH5khaiPYzGoAQiczhdcjsHDSSopP0sf1VqRiV3YzQFb2KhSR3/0okhPeIP5alyFje2ICwfCXemawMjdlbR68VyBP5ZEazlpAxeZeoHH0U5ImMzFQjvQyRgHntRLwwAEQuS5ggIxtxHUmOvGrbvPjj0aYsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758348; c=relaxed/simple;
	bh=eIM22b8+F8h/4Crk71dHCkH6bf422ismSDbVReIIGj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsmUU2byjIwtx7YAZa1Ia1dkbh/CUCKFadChYqjimnpjY+3QDOQU9kQ9wPB5GXRNvLFiSYtsBDeCWIeNXDzJc/g5I9a7qGKx0DO4lVZ8R+luskyUaShirTElgOm+pF9Es4FlGfNPSgDTTdNMwQZAUlY6X1XxvaED5nt7TOkKhiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ersEvnMx; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NOgnPlfNVVTEBIbcmuBoM8RBOziOxd+y6vPdCWVGYdu9wjXNSY6dryrvYwn1M6aS0IalNwEBm9N8z+0KDVcLdy0NulHC1gFQMT110jGMAzf7MGTRQtU9dq2XIp5+dWEms5wcwejhuof08hW5h6jio6+ckhT3sznbeka4SKhM8bmr1WAq0oyhOut8tXPn34SuxgoWtE5ZLFo7vBpjTeoL7FIqnHroc6+a+cP/Re7sbJhQDs15TkhXIliD2hSQr91VyPkTV7PQFk7TacUaD7R0SUSvTkTkZhe+STHarc0DaLeBn2P/JJXqek1UFUNQkVnCbctJXSidQLcgSKtGdz8TxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgoIkqhX/NiDtF3w9qRPsvHerFxoAq+yOTz6R2NPR1Y=;
 b=hRRqFy46DRowTtO9TWZ9++KnnI1eINhFjWOLdwp44vTY3ESBxQ7KBuWohdZ9EOoaOwKQR/qStD6YDtZ3OunsLARUSZTQBeM9bkK2T1xUSfvRuS5OBZAUaTHhUQeX2L+kVzWK1EZRK65VqLDihaDsbGG5R2L4KIVVQyMB94dN0vqbR1h7n/E6lm6hdQw55yuotykQjCyL12BxsB8fwgjzTQK34+scf6olnk3qh4MemxKsuHKJLcHTJ4UtaRibfi2H4XJUVl3zcVUHwmTkla3TF72zO+ccZe+zpAnhYUVfW8JHW5tpOMkB0ZwAOnV1t+vteg+Uhvg49i3ZHKZ0HLEw5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgoIkqhX/NiDtF3w9qRPsvHerFxoAq+yOTz6R2NPR1Y=;
 b=ersEvnMxCqSVKUKVce67mzKmKjzMEW8YsQnYllZEOgh0SfeVvvXC9H9GhxuBkpMc/0ovVOuqcIUc3XYKr7sCKLU1cO8QvnqmNk7N1zlNiW/qdPbfFt6jQSIowYRIPOBbbM80hSxu/ip0eMIWjjt9Fnb7aU6G8iktuU31gt6BFilrvZ+zXNGZWL/IKsrHKyZB3Quq5I8wJif0nV0HHAFlIal2VnavrKWxSiV4WRVhuzl+fM3qaq1RnXYvhp4Vl1P1vftmjeKVICN0/w1Q0oTGSMDuVM5Gje1N75MD70UuJy6Xsl1gqcVaxvkJdM6k/ugKGct/O1PK3XR8a8lQ1fmhqw==
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16) by MA0PR01MB5868.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:49::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 06:38:59 +0000
Received: from MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b]) by MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5dff:3ee7:86ee:6e4b%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 06:38:59 +0000
Message-ID:
 <MAUPR01MB1107244E647EC28C7E7020EBBFE32A@MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 21 Aug 2025 14:38:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] irqchip/sg2042-msi: Fix broken affinity setting
To: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>,
 Juergen Gross <jgross@suse.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
References: <20250813232835.43458-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250813232835.43458-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0211.apcprd06.prod.outlook.com
 (2603:1096:4:68::19) To MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:16f::16)
X-Microsoft-Original-Message-ID:
 <d6493986-7db7-43e0-8d02-8665c188264c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11072:EE_|MA0PR01MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: aae838a1-c1df-46d3-f2fe-08dde07d688f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799015|19110799012|6090799003|15080799012|23021999003|461199028|3412199025|440099028|39105399003|4302099013|40105399003|41105399003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U203a2RZNjRiZERIcFJ6dFpCall4UENaWGJ1REx0R3BWaWhUQUZpMjVpcGts?=
 =?utf-8?B?MW5pUVlhKzVhZFlEdmM3S29NWThzTGVMZVUxcHhaeUFSR1FmaUN1M2FEWWY5?=
 =?utf-8?B?LzJSbGwxeEVPb2Joai9WUHRvT1JLWitnaERzaEIxWDhOemRZZ3UwV3VtbXA1?=
 =?utf-8?B?SnYzQlVpV2pPdTJtRkJtRVRFdE9iWTNsbzNMQ2prakFUR0JYdWtQd1JzcVpI?=
 =?utf-8?B?b3hlRmJBb01QSHJtdzZnQ2xNN2RiVktjOEtiYklkU09sczNHMGxac253N29n?=
 =?utf-8?B?TWtCak1VZndNSk1PQ2xTU2FHQjhHZ3E5K0dESk1YUjVOWi8vclZhYjVlS1dN?=
 =?utf-8?B?cTYyaFIzU28xWmZnVi9iK29NQlZVMm5jTU54OU1nRjQzZ285VjUyQktiTjBJ?=
 =?utf-8?B?dStmNkpQNFV3SkpVazRBcDFOL2UvQzJtRVZJRm9GcFZITGZkRks3N2pjdFBQ?=
 =?utf-8?B?RWZtbFZmNStHcDB0L0twQUwvV1JXVURxZHpSU3JrM0t4UVdXcnFoVkZ1QzNZ?=
 =?utf-8?B?b3ZCNXJDWDNTV3lMSmFsaEd5Q2g2TVVHS0xFeXc5SHJBcndVZUlZV2V6VElB?=
 =?utf-8?B?cEN2dkFCcWJLV2l3ZDBmcmR6R0NyVlhBbVEzVzZxVVlJTXI4N1oyRzdmM3c2?=
 =?utf-8?B?NUdlVFVSRzZEV3Jrb2VoQlQ4bkQ1MFpNcGphd3Z1VzdzVHJIc0Jnak1OeC9E?=
 =?utf-8?B?RnJsWXRPZnV5ZjBIeGlGeFl6RklNcnJsQ3FobGdqd3BHNEw5cUpTUDZZaFZq?=
 =?utf-8?B?L2VPRGpHN1lFV3F2UjFtcVlmWVJLOHpVcUhQb1dlbHhpeDBiN1JjUkVMVHA0?=
 =?utf-8?B?KzhtVUx0cUNtT2VhaHFOR2M2S2Q1YTRFVk81YkVpMXVFVWlXMEIydGwxOHNS?=
 =?utf-8?B?YXdndEpCTXlBeGdFMjk3LzFISCtOSGg5NkhYZ2oveEpDZXk0c0ZwRmZWSEU1?=
 =?utf-8?B?bGlPMEJKN2lFSXRhNzdmTlVzbmhUKzBRMUtjTnhNMEdEaElhMFdOdHBDVCtm?=
 =?utf-8?B?NWRBMXNTUi9uNHdtSzM3ZWlnb3lJV25RMmowUE8xZG1iSEErempwOVRoSGxW?=
 =?utf-8?B?eTUvRVBQQ0VTWmhlVkZUUTQrVjAyNDFUcHBibU9LbWJMUWgweUlSRmxvNi84?=
 =?utf-8?B?V3Y3ZVlObVNrdGp6M1pYVFcyanFUeE54U08vSkIwVXFVc3NaMW1pNVZwdit2?=
 =?utf-8?B?SVpTZ1RnVzRQczVHQzB0V0pKejVwUUxjNDRyM0RXdDlTOXJqdDVLNml1c05K?=
 =?utf-8?B?WkNxVlFheXhsN1o2ZFd1R2Z4TnpVYStvYnBvaUF6MzJ2TFR1S1VUaGhZc0xr?=
 =?utf-8?B?YU5uNHFpdEhibVNvQ1JzaUpGVGlQTm9rZXpvbnJ1WFNzbzQ2ZlBDMVJvdUJ3?=
 =?utf-8?B?dU05c1NneUlyK1dib1VGRnl3NGhUby8rakFJb3hwamdoM1BYZ2FFZkMvcW8y?=
 =?utf-8?B?a3U1U1Yra3VGUzQwTHJjeExVcVRqQURtYit6SEh2U3ZiZU5hSDNBUTYyRGYx?=
 =?utf-8?B?Q1NNTjl5WjRMMkVaQ0t5bG15bStIUmtoWEpVRnJMbmh6VHBlNXlOVStLOXF0?=
 =?utf-8?B?RCtMc0Rla3N6eFZ6YXdXM3kxUUpsTlRTRHBIdnFIUHdPYnBSNlhPSUVKSFNH?=
 =?utf-8?B?RDBkSW5tQVpHNEhtalpML1hoOG54eldsSzdNK0V6U1JCUm1hUWNGQmV1SW9R?=
 =?utf-8?B?ZlNOK1Q3RmZYZXFpdzF0ZTFBc2RsL0pJS0NlU3lKeFlsRk41MVBMeE9NZVMw?=
 =?utf-8?B?SE84aW4zUC80VTFjZSs5dGVZczZxRlk1bkszakxNeTFBK2ZMWTFrSFdvOEdt?=
 =?utf-8?Q?kK+pbt/HsBf11bD2e7+l+ak2dGJL6ST3avxPM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENJTElaYVc5U3d2R0hZNjlPOWU1OW96OSt6eExQMUNMOWw3dzR3NEVpNjJ4?=
 =?utf-8?B?Y3NkRWpBOE44dkV3aCtGRzYxdkFqZ0RBczZOSlpjbU9IT0hMVFFtVSs1WTMz?=
 =?utf-8?B?aEJ1Q0xxTjZBcUd3TDE2Tk81Q1ArcnBablhMU2VTS3cvSjNHaFdBajVlTm1S?=
 =?utf-8?B?Ym5mQU5Vek55anhuWVI3b1UySEpvdUtSdWx2K1lDS1BsMzgwenI2YW4xNDgv?=
 =?utf-8?B?cmRtUndvSDU0R0dWRUphNzJLYnZvZDFrYmo3NWpKcWVHZmVWWTNVUStjbHhN?=
 =?utf-8?B?emVUTHlkSDRXc0dBdGpKRTVMYXRGeGs1endEZFdJMmwrVklrOS9aaU04WDF6?=
 =?utf-8?B?WHZVbDFnc3Q4eWN4U3RkR2xSM2ZjTUJtTEFOaGJNcjI0U0d4TUlHbndkVU04?=
 =?utf-8?B?d1cyT1BrbExEVkdodEtXNmltQ1lzV084aXdPZlZWZzA4RE84cGJUWkdzWGZW?=
 =?utf-8?B?eDY4TStFdDdhV3kvVFQrTFBPdDJ3WHVLOWdZeTZ0OVdUcUU0SWlQNm5CMnd5?=
 =?utf-8?B?N054Ry9ucDU3UFV0L2N5OTBZRDRVQWN0THpMRHlZMjhXTTA4V0M4QWlKZEtv?=
 =?utf-8?B?NnR6dkRkSTRXRmR1NnQxSExRakhKeHc1RG1uYWRwa3gzSk5qQUdiY0k1aHRS?=
 =?utf-8?B?V1hycE9STTJoS3BCeUdORWRyeUNYSjN2YU9XT0ZuQVRiK1laSjg0Nk5SaVpT?=
 =?utf-8?B?Q0UxakoxS2hiOGhPUFhJRlVzUkJ2Mk9zOVFjQUxaa2xvRlY1b0FROUU0UXl4?=
 =?utf-8?B?ejdOTGwzWTAyRllzOVZXSHZ3dG1lSlVNcUxYN3hqUEtWR21iTlJ1NDhSRlpV?=
 =?utf-8?B?NU9ibWVWb0FIYkh4WVhyR1VLSm55aURLMVpQZHpYZWNTNmpNck8wMCs4SVlt?=
 =?utf-8?B?ZUowLzJudlFXL3NZQVZ1RnNCVHpKZHhtS3dId2loZGZ4NGFtdFBUL01sYWdB?=
 =?utf-8?B?dXJBM0JTWVRnNGVwcTlGWmlXWEk3TnNqR2hMZ2ZobkQ3dTBjMzh0U1E5MGlN?=
 =?utf-8?B?c29KMFZjVXd1WlZhOWNGQk9PNzJnUnQ0VlVqVEJSZlg2Q3dtOFVFUXJmaDY1?=
 =?utf-8?B?dVVzNGp5SU52S29kN0EzL3U3cU9vekFQaTdHMGxneVQxQU02QXlnSTNDNUFy?=
 =?utf-8?B?ZC93MUVvUGlNTVBaSDJwN2xHQUdTNTVLRzRXU3haaUo1TWlGTmVpNVNPRGhk?=
 =?utf-8?B?blIwSzgva0hXS0hUWlFYWUdBSy9QUjdlQWhYTnprZXJ2Z0FWYnltd2pJK3RR?=
 =?utf-8?B?dG5aamh5MXpoR2hCZjFDbnBDV04vNnFBMlhFYW1wbEs5UGFscFNxeGNZeFdC?=
 =?utf-8?B?OVVuS2NOMlpyUkNsU2RzaUpWSmJmWXFoQ1FVeWp4SjF1UzcvNFd0UVg5UUFl?=
 =?utf-8?B?S3VpL3pUVCtHYUtIYmcyYS9FTXZvUWNITkZUcmY4aXkrM2FpYXN5UnBWamM2?=
 =?utf-8?B?bExnakxVbytQdHZhcmNHY2pQTkMyUzdNTzc1SkgxQ2NuYVZmZkhoR1JHQlUy?=
 =?utf-8?B?VFVmMkZyRW1QcUdZdWxHdVZNVzV1RWl5dlkrNngyRmVldGVncWpPSU1vL09K?=
 =?utf-8?B?dTJBSkMvQ3V0YVIzYWpjZzJhU0ZuOXp6WjJseDJFQ1F4VjZSV2FhNndxdEh0?=
 =?utf-8?B?SEdDcFhWTUNNVFQ4cE50bk0zY1lhVGpYY2JreFRPNklEU1NydzBRYVRKbk5W?=
 =?utf-8?B?V2JSZmJyMi82MmZYMWkrTkVXQUpGbjN3emVBWkU5VnpqdWp3c1ZCTEFHMzNC?=
 =?utf-8?Q?DW+4RcideqyH6sgjNSOLp2cB9cdNM1D0yX4v3H2?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae838a1-c1df-46d3-f2fe-08dde07d688f
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11072.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 06:38:59.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5868


On 8/14/2025 7:28 AM, Inochi Amaoto wrote:
> When using NVME on SG2044, the NVME always complains "I/O tag XXX
> (XXX) QID XX timeout, completion polled", which is caused by the
> broken handler of the sg2042-msi driver.
>
> As PLIC driver can only setting affinity when enabling, the sg2042-msi
> does not properly handled affinity setting previously and enable irq in
> an unexpected executing path.
>
> Add irq_startup/irq_shutdown support to the PCI template domain,
> then set irq_chip_[startup/shutdown]_parent for irq_startup/
> irq_shutdown of the sg2042-msi driver. So the irq can be started
> properly.
>
> Change from v1:
> 1. patch 1: Fix comment format problem, and structure the changelog.
> 2. patch 2: Improve the comment title and body, add describtion about
>              the fact the PLIC is used as parent chip.
> 3. patch 2: Remove __always_inline for cond_[shutdown/startup]_parent().
> 4. patch 3: Update the align of the "XXX_MSI_FLAGS_XXX" macro.
> 5. patch 4: Claim the fact that the added flag is used by the negotiation
>              of MSI controller driver and PCIe device driver, and can be
> 	    only used when both of them support this flag.
>
> Inochi Amaoto (4):
>    genirq: Add irq_chip_(startup/shutdown)_parent()
>    PCI/MSI: Add startup/shutdown for per device domains
>    irqchip/sg2042-msi: Fix broken affinity setting
>    irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags for SG2044
>
>   drivers/irqchip/irq-sg2042-msi.c | 19 +++++++++---
>   drivers/pci/msi/irqdomain.c      | 52 ++++++++++++++++++++++++++++++++
>   include/linux/irq.h              |  2 ++
>   include/linux/msi.h              |  2 ++
>   kernel/irq/chip.c                | 37 +++++++++++++++++++++++
>   5 files changed, 107 insertions(+), 5 deletions(-)
>
> --
> 2.50.1
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>

It is recommended to add the following email link about the relevant 
discussion in the commit message for quich reference when there is a 
revision or merge:

https://lore.kernel.org/lkml/20250722224513.22125-1-inochiama@gmail.com/

Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox

