Return-Path: <linux-pci+bounces-17962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 696569E9FD1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 20:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082CE281FE1
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9735019924E;
	Mon,  9 Dec 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vZxeP0Fw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEA1990C5;
	Mon,  9 Dec 2024 19:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733773529; cv=fail; b=bjRJRxLOWqb8QCgrvwirlvG9Gii8mxNTrnxEuFCeocTV7sZh+OHpddUdXr1nSgEu3jVmEJ4I2wOXu06hWN/ef61x2lIMqfhuVwJJoLMNKVhhtyowPb4STAdav5k6kLTb/BiDLeokxAqaZfslbU2Yi0hsQOTozURKsI/E7cPiKvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733773529; c=relaxed/simple;
	bh=+iXaAxY1h3Kje4dDMUtxcwk4qU3UsPr7qV8ATRQGrM0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jz46Bp90Fe3uf+/89Tv3JhYq37pQW9M/yLoJPjVZwaEliaDJy8BnDu3Im9vdmfee5tLhKXOoCZtHectoK70qbfPFmHi7mNve60QmGSf+xbQeU3MpexTlcQgo+2vh8zugA7ZClzp18pHKv237gX02QOil8GfeZP1KqvqSVUrJuFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vZxeP0Fw; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOSPo4cGwdhMq6U8g1TLAN+E/ybfXVkSKf1KFaIL1j7GAGB//pUp2fuc7pnRyPizsL3YGQX4Mo36bYlhGmJc5qrW361xSbAZRGsgQjKWWHjx3x+c+J/GeY0r0ch4LOLFMbhY0qlpSgTYzfULcHsJPxC1uLFCz4jOtKcsFmQGBoDMgMKjIZS/S7GGvZkwXcD+Fhu1N5nkVDS2KRLq/+n7356SIBObi6Mqy4FauYHics3HEEC68Af9whskJkFuhULPOPst86DF6FwQI7ItUuLaDioZ2KL6HJe2Dfci/YloTX3sWwKSx4Oxt0gix8wlbNfPzKN0m0ctL3ZdWLcMnZ5+Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55LsMiVvQ4eV5pzb2wnWUtf3w83hKvsk6J/NbbnCD1s=;
 b=cub0wLXgcuGEiLnVm83DFhFwgcs0g2uFwRcoc4GdegKdliIDrvn6nLoOXY/jjD2PKU+37y0PirO4aqFJQrl0497atNnvBNyAOe+eju0QVHj+2QSZHAe7V2Lmlwvewl1T+lQ86BOuvxxH8cJoFbkSAy86qjTje7zp/COBqNm3QdJeColMJdbU3QPm5LUZPBjdxtoMCl8Gxd7jeaNEkEq/Bo8nLwBAwkLcc/JxzsPfO/RIZK9cWFV0lNHmNIemY6MIfQNC3vrDMdWXVPf/8zXxSG1S9qKHA5cIl08qj+o1uW6FfzmYRhbMJ4rRrZX1hWXuDxSJ/mBD4c/Z2OLcMnIcrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55LsMiVvQ4eV5pzb2wnWUtf3w83hKvsk6J/NbbnCD1s=;
 b=vZxeP0Fwhwh8mB6VSAojLf8bh5asP18+sUxtNtgtZN0iAKIAT++l+nJW9gGGmgf2D273OfUHx0tKC1xdcVeRq2pAHzgXxTY5es7gswoNUAjeky96VcDKMGiSkZWhT3bT5VcP+SBdcJlR3vtIfpYpMk3o+4CRf6/LPvzNMVXxpL8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.26; Mon, 9 Dec
 2024 19:45:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 19:45:24 +0000
Message-ID: <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
Date: Mon, 9 Dec 2024 13:45:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241209193614.535940-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0076.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6b7336-4355-4982-06ef-08dd188a063b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmV2ZWhrMXZJVU5JVHpSTXZNSTJ3cHFmWTk1V2FRTURjUDVqNkpObGhXZ0FP?=
 =?utf-8?B?WVBWN3laVE42V0VTWWs5d0t3NHppNmptMENFSW9RaEFHckp2WjJRM21aczlp?=
 =?utf-8?B?UWNrdmk3cGxQYXJkbE9HclZJcmNrLy9NNFBwUGNKb3lCblJNelRGR1hoOVU3?=
 =?utf-8?B?VWdvMDhpTld3V2k5WDNPSTdDZ0RML3BVekVOWHN3cm12YWkwNy8weDh3aVZv?=
 =?utf-8?B?QVRkRXRUaW9QSS9mWUFnWHlpVm9TQnJDVnE0MEhFa21HbnhBN0tRUjc2aEdj?=
 =?utf-8?B?SHk4NFV6akdVamlzZ3VNOXZYWmN1em1kTDV6UjZaYnZLZHJlNzBqSENGdEE5?=
 =?utf-8?B?dUp6NDd3TjVlR2FsUXNyRFVBVXB3dno4dkUrbVlnVDdGSWRpaWsycnJVOGx1?=
 =?utf-8?B?L1p4MnZ4Qk8zZGhjSExaVS9jRkU0cnllR0hNa2d6UWtKMlcySmkvaS96a2sr?=
 =?utf-8?B?Vi8wTExCbjVOUmUvYjQweVFwa2krQms0WWd6QnBFT1BHejRldUFIZmZUQ1o0?=
 =?utf-8?B?YzRqTjFQSm9FMU55WFJLYjNjN1h5OU9vbnFVK0RONHRVSjk2UjlhMGdGVVFk?=
 =?utf-8?B?VzFuRENLS2hDeXJLNlAxYk9INkdnT3Q3NTY1SUNlTS9ZRm50L08vUFhOSjA4?=
 =?utf-8?B?NzJjZnV5ZkRPSHF5dTJNV3YyNjU0MmtidVV3c28xQ1h2bk5ETnMvS0sxL3RV?=
 =?utf-8?B?VXdwOW1GdzV1QU42MFcxMmJ0S0FkekpVN0VxY2prTHJwNWpsYmtPR2F6NS9D?=
 =?utf-8?B?S2MvNXpISVVhQU9LSU5KMEk2UytMaFZ3Sy9oNkJXeXRnMmdZUFhYR29EbkJi?=
 =?utf-8?B?VW05eHJNY3FJNjU3Yzc0b0xxZk9qbVkrVjBQVlZOSjd3T3o0UVBSWk9yRDRS?=
 =?utf-8?B?Y0Y0dU1xNzNiT2ZIMVVFd0lqYjVTczdLdStMOE9CZjNHQTZhbGlUZkgzYWcz?=
 =?utf-8?B?QStBaE8yWFJIMWVIeHYrU0EyMG9HRm1Ma2NyY0tPYTgybTN0Yy9PQVVzdFZ1?=
 =?utf-8?B?T1FyZll1UHgwQXJQamtKMnVtS3VNMmhTVXMwU0V2eVdwMmlzZDFJenVmZjkr?=
 =?utf-8?B?b3F2OCtoVXJxam1rS2doa0hVOW50STc3SHNJTFBQQ3lkSzcrZEtva1crNmor?=
 =?utf-8?B?cHAyMzVaeEZJdXBYc0w0YWlXbVgwclFvY2Y3VlBYY0JHT1ZjUHpsZHpadStm?=
 =?utf-8?B?akloalNnV1k0RnNNN3ZIditna3EyY1RnV3R0MnJ0bjg5Uno1Q25BMzE0M2dI?=
 =?utf-8?B?RFJ3czRuVTNRUTAyczBNNmpIYkYvRGpxdWJtTiswY2FXdzkvZVplSkF0Qktq?=
 =?utf-8?B?Qzg4SUttdURuOGJJZEQzSFU4RzNDSHhxdW5DL255Wm9oRHZ1c0hoR1lPU1lW?=
 =?utf-8?B?RW42Y1JZblkwdXZDYVNoT050M1FiVlNEbjc1TmU4clhtY1RmMWxhVlZhUTZS?=
 =?utf-8?B?Y3ZWUUxyQnJLeW9iSzNrS2ZNR0xWWWxKMUlpUERHak9JUXJ6VWtLbTNWNzl4?=
 =?utf-8?B?KzNKUFlzYTBFZldEeDdPU1FWYVQ3WEdRYUl2QXZWQnVPSUVnbUNacFNqNzN3?=
 =?utf-8?B?dzljaGErSGx0bGk1UUhNWHc4MGZPdGxoQUNPRHkrTjIxTzF1YWkyTy9XcmNz?=
 =?utf-8?B?WXlpRzExRUlUMVl1aW5jZUllbmJrKzkwQ29abGJWcEI2Q1NLWWdhM0RqNjhw?=
 =?utf-8?B?Z2RVYzhaUGs4c1dwRVFMdlRBYzlIblVKZzdPdU8xeVpOb0UyYjNvRDEzK1ZP?=
 =?utf-8?Q?890Bs9X2c7CG0dDEbU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZXdGFyeHNMS0E0T1QwTWU5WTdsQzJYUFo2SkErVUdpdFBzdjErZ0VTMmFp?=
 =?utf-8?B?WEFKVEhOOG4rUS9tbGJiQW1YaHkyTW1JdW5OWGtRTit5Tnpac0d0M1NxNzcw?=
 =?utf-8?B?OFRXK0lWYXVUZW5mV3hhQmU4Q3VnV0NlTEQ2VjBNK1lSM1V6cDA2Nk9QcVZX?=
 =?utf-8?B?K1hiQkVhV0QrenFmMk1sQlAvajZha2NKUVNyczdVUWR4WDVxNWg2ZWl3Rm9G?=
 =?utf-8?B?bktrNS9CYWlGZWI1YjdPRXdGVThKTUtYTmErRnVVTjBlZGRZd0tlaXM2Ky9G?=
 =?utf-8?B?SFRSaXdtd3pmdXJLam5kaXpkTmRlRFpha01YRmY2alBUaHpaVCt6bUhzbFRn?=
 =?utf-8?B?QytRdFJmRXhIbGZxOG1tbXJJdWRpSHU2K1NCMnY5Z2tsRy9BcDc0L2EyU2ZK?=
 =?utf-8?B?WC9SOWg3bTlCcGtEV2p0RVpKd3dyaUVnSys0SWVESDdxcmZlbmxremEvRXc4?=
 =?utf-8?B?dGdyaGpMT0pKMDlUWXVVVFZiUll2ekdhaEk4Q1BVdWFsNTdScFFEditLN01D?=
 =?utf-8?B?Z1JSbmw3MUNSTGsvMlBkejNkQ2V6eUV2akFyOHVIMDh2TEFOeGJuZ3RYWFVZ?=
 =?utf-8?B?VUM4NjRNMmlGUkxEOFRWckNYcFhQVjBjd1MrTXMydmMyTDZnbWtCclYyYjZC?=
 =?utf-8?B?MU1oamxWKzIvdW1iQmQ4TklFaG9qK1R2d3ZRc0hjUytmbUVud1hRZ1VGSEVw?=
 =?utf-8?B?UldPS1V6VDU4a25HOVRyQzB3NUNuVjBmalpscm5Ga3dRL2x2N201a1hHbWQx?=
 =?utf-8?B?ajNwbS85MUtsaFFQTXc1SjBKSWk3MkdSNEJqNGo5NTE2UHlNbmhjaFFiZmh3?=
 =?utf-8?B?Z2FEdHkzMm9wRlg0WHRMWFp1SXdDTTdBakpZNk9tL0F1ZmU1ZmlTUXQzMFFF?=
 =?utf-8?B?dllabGd0OFV4ZUZUc2RIM05rQ3ZGWnVQMG1JVVRnaGZ2emxOUWpCWDBDa3Rk?=
 =?utf-8?B?cHZEdi9DUGZGTlFXcmorYjJBU2FmRVdSL3BMMEhSTnQ0eFJEUnVFMzUzY0Q1?=
 =?utf-8?B?NjlWYUlwN2l6a2s4UE15NEN5bDdhVmQvTVZ3NWFLdzNCMTBBcDVqbDJ6Rm82?=
 =?utf-8?B?dXh4RnE4ZVRNZjFSSkNsTTRwNTN3QVVza3JtWVVYTmRVV3J2V2hPN3crd0VW?=
 =?utf-8?B?aFpnb05vemlST3NRdFE0T3UwY0t5NDNWMjd2ejlDL08yTTZEeEpMZURweW5J?=
 =?utf-8?B?NFI0RW9yNmF6RHZRK1FrZms4a0tlSXlVWVMyazU0RXlhaFh6L0pvZDNOSkNU?=
 =?utf-8?B?ek5hcXcwY2NJVGlDQnk4c1Z5cDluUTNZTWVIdTRFZjhwK21zcGhVZHF2NmVU?=
 =?utf-8?B?K1NaTE1YeGtKdGhWcjdiUzFteDAyRzJubDNhQVFBMzdGbXhSQTRrRTA1L1or?=
 =?utf-8?B?Q3Y0cnVLajhkZWFkL0txdEN2ZGV3bVlCMjN4clUwclNPdy8zTFc1dDNYTEVH?=
 =?utf-8?B?Sm1kb1JCcWlwV284Sk9ET044U0tmM3c1am1uazZyV2NGUEhDMVBjbXkwVG9H?=
 =?utf-8?B?cUM2QU1wMVFNb3RwWFhJZTJhK3JiaDlWNmM1b3p1QjUwR2l4RjZ5SW1mWlla?=
 =?utf-8?B?VWtxZXdKdHhMa1kydzA3TFZLM0Qzb3V2VHhVV2RQamFVVVR6SE1yd2dkbXdr?=
 =?utf-8?B?WngvQ0d5NFZCUWlURkpadHNUVXlLN0F1KzNyL3VBL1FJWEI3U2RzdE5KSnZ4?=
 =?utf-8?B?TUpxcUd3bTZIT3lvSlM1STBzWjh6Z3QxOXVFLzZXRmp3M1dQK1IvbXU5b09N?=
 =?utf-8?B?c25TZ3I4ZnFMejMwNjN3T3l0U2pnR2p5MnRRQTBDazJMU0ZqbVR2VEx1dlU3?=
 =?utf-8?B?cjA5NVlNWkFpWFZ5ajlrZ2hVdU5EMjdNUHlJaWg2aFo3clM2SDFhN3loV3JZ?=
 =?utf-8?B?QU1zWGtYYXJLYks5WDRRcUJUQUVMTTI2ODRyYmhUdmRZQUJ6YTBhTlZVVnVR?=
 =?utf-8?B?MG13bUZvMTZLaDVrcm9PZkZOYXJ2a2ZLcjR0c2Q4Z3A2dkRHM3pFOEFpbVV0?=
 =?utf-8?B?TGFNRUp3MEF6L21WdjdoaCt6UFJIejlxTTdTNUpVNmo5dWU3bWFsT3VScDdq?=
 =?utf-8?B?K3FRN3hVNzRvWm91WldHU3hVYk9iMWg4UGx0WldrSWg5UnVKSDZGVC8vV1Nl?=
 =?utf-8?Q?ddsXB5VD7IABlgsse1+NQriyO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6b7336-4355-4982-06ef-08dd188a063b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 19:45:24.7117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nM1cQ5qpB48YXaen3rFfcZHvoMn9cyI8VyxGLzSRI1LqLzqSIwDzUQBeTjDblJ0WTJF2LjvJXtkYV8pFCoT2Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

On 12/9/2024 13:36, Werner Sembach wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> sets the policy that all PCIe ports are allowed to use D3.  When
> the system is suspended if the port is not power manageable by the
> platform and won't be used for wakeup via a PME this sets up the
> policy for these ports to go into D3hot.
> 
> This policy generally makes sense from an OSPM perspective but it leads
> to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 1 with
> an unupdated BIOS.
> 
> - On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
>    interrupt.
> - On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
> 
> On the affected Device + BIOS combination, add a quirk for the PCI device
> ID used by the problematic root port on both chips to ensure that these
> root ports are not put into D3hot at suspend.
> 
> This patch is based on
> https://lore.kernel.org/linux-pci/20230708214457.1229-2-mario.limonciello@amd.com/
> but with the added condition both in the documentation and in the code to
> apply only to the TUXEDO Sirius 16 Gen 1 with the original unpatched BIOS.
> 
> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: stable@vger.kernel.org # 6.1+
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a1..2226dca56197d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3908,6 +3908,37 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>   			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>   			       quirk_apple_poweroff_thunderbolt);
> +
> +/*
> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3hot
> + * may cause problems when the system attempts wake up from s2idle.
> + *
> + * On family 19h model 44h (PCI 0x14b9) this manifests as a missing wakeup
> + * interrupt.
> + * On family 19h model 74h (PCI 0x14eb) this manifests as a system hang.
> + *
> + * This fix is still required on the TUXEDO Sirius 16 Gen1 with the original
> + * unupdated BIOS.
> + */
> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "APX958"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
> +		},
> +	},
> +	{}
> +};
> +
> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
> +{
> +	if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
> +	    !acpi_pci_power_manageable(pdev))
> +		pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, quirk_ryzen_rp_d3);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, quirk_ryzen_rp_d3);
>   #endif
>   
>   /*

Wait, what is wrong with:

commit 7d08f21f8c630 ("x86/PCI: Avoid PME from D3hot/D3cold for AMD 
Rembrandt and Phoenix USB4")

Is that not activating on your system for some reason?

