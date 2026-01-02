Return-Path: <linux-pci+bounces-43926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F370CEE3A1
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 11:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E571A30046FF
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395DF2DEA89;
	Fri,  2 Jan 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i8VowPLM"
X-Original-To: linux-pci@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010007.outbound.protection.outlook.com [52.101.56.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE42D7DD5;
	Fri,  2 Jan 2026 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767351508; cv=fail; b=X82dFZurVGLEuKhzSbRUjGwoOzrvcKYHNr61M0W/6vwxRJhDMDmDx5swFFq9CtpLOboT8SPSsfi3BoFPrTkJfeFPJkmPm7McJDa+97Y2A5X7aPi9mJN/0yPJmdzZhzDvhQJeYq/4DQTAF0NW/W2xVCHfsnTMEgVaWykkz5u8OfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767351508; c=relaxed/simple;
	bh=4oWczeJWivhs+IX1V3CFJYip6R5nDNKljxHvufuX8AU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hBIBuuy7S84Gy4NaIrrpHRBK17xEqzm0ZPuPxdrGnqRuDJMeLTlO5dTSgkVumL1UsclPB2WrOwOYlIEi7Z+kCyFaX7Tv1RtdL87Mymwnug6Xqraeb72VzzNcPhq6S20jBTSkd2HeUmvzb6C2BQdPBDCUrDXhvi80qYwukb1vhDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i8VowPLM; arc=fail smtp.client-ip=52.101.56.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJKd6MtNwVuvrNSqpx9G+6a0YgyVZdSJgTx4+ZD5OQnCI4E4Ak07Xv+kkRsCTWp7mIB6B+yXoLUuwofGRXz2Kxa0CfVI4EodugXlmMiI4vtuuja9rhmklNXOMzBse1K+fyyR3ZXV1S0hYP7jKYn4hw9FB/a53ovzzHmensluWLcHDLVEcUoNAzpY/Q7Flm/6MuGrBpiuyHoK/kuTritBuYSpP7DyCq0dDpU0bBmgpGQ0iK0pYFJ+6Rh5Sdo4Vp1DzQwksdR6+qeAc+DZPPQQZrY7r9jVRUA+S+orNydVKV/35x8wRthXrRoYng/h787WlHyZtQwJlo9yTtms5MmQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouLVUpvbrO4wNxL3+VRx3UKlhBz2vTdhmsk6mkQZkfs=;
 b=yT9tFxxNBLzaew4g1NG4THkayk1EHgLzkoQ6PpmwCsYeD2NxDt43YGIFSauq/D/obttbMp07MLjSddfCb12euiN9tUACIxnFvO5V4YM/5N/fibxZi3+pAHqDMha7mv7tF1dD7NID2a5cNfXP6yTtcjspSPWTJiRf3WL8YzKwxWDR3iUWRn7nG/OFyNJl3BxsGcvyMWaUX+nquLtLUllcHL3ZfLb4xihGYLBRSUbOKaGEGTVzqjW4NA90yogMezj8Gf+93/IPjAZI8/lMz17O9f/J+SN3w6BI+7ec6oJs/wbZfBinjRB+3sp/ERVBEtUe3XxFgskAJ3g5GBNToWP1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouLVUpvbrO4wNxL3+VRx3UKlhBz2vTdhmsk6mkQZkfs=;
 b=i8VowPLMqiQNH/Ti9VZYKhjJBHfE47deOUh99DzGIB/C2FJXihu/1jseCQwxALYAt1TAn2vC+J5pUF8Zll1BI/xUhiORVK9XzsR8harfhbK7lt0rGEoqys8v0iOpojkXlhdcSzYyJ+3rgtAnoS9JN6+XskEdNecJmaOyfyVRBCR3at34gFUk+iwZ9HnSdnXvjqyabN7CPdCQ+R+Bp2MlXqRcmDFwPAJBI5Bihr9P0TUWK1aC51CthvnSC/7BwJJwuArMwoJzFBf6FgKHDDRGFR3zAJOgGyl8mnCPp8A0MciJDTgdI9z1OFW3dFtC6vS0oR2nrEmbxEl/KsgSX5dIXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA0PPFDC28CEE69.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 10:58:22 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 10:58:22 +0000
Message-ID: <e900f082-fb3e-45c6-a94b-935132190249@nvidia.com>
Date: Fri, 2 Jan 2026 10:58:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
To: Manivannan Sadhasivam <mani@kernel.org>,
 Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mayank Rana <mayank.rana@oss.qualcomm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shradha Todi <shradha.t@samsung.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Inochi Amaoto <inochiama@gmail.com>, Vidya Sagar <vidyas@nvidia.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20251126102530.4110067-1-flavra@baylibre.com>
 <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0066.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::30) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA0PPFDC28CEE69:EE_
X-MS-Office365-Filtering-Correlation-Id: b87f01a4-0b1e-4a7a-770a-08de49edd84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtIcmZFcWdQS1FYTEtHdmYzam5Za1lqcnQ3OG5BNURUYmRrUFRVTWRGcVE3?=
 =?utf-8?B?djJYUFY4Z2EweHdyWTVjb0JtQzV4VU96WnBONW00S3lRMElhbWwrUzhLK2Rs?=
 =?utf-8?B?eFRtaHE4dytoaW9kdUh0blFkaUFKVzRqWk9oaXFpUmlUYjBBbXBmeWJNOWJo?=
 =?utf-8?B?eVI5SjRWSmxUdm9WY1NqeGJuaERkOEZRQXpURGFtTk1EMWRURlAyR1F1RlJi?=
 =?utf-8?B?V1h5Q1NmOHFLZjlhTEZ5M1NUdjEzK2h6YW5IRTJ2Y0pnMkRNcTNVSUV3dmcy?=
 =?utf-8?B?Y0dBbXR5UlZndWFycURhRTRzZUw1bU4vSWdaM2FDcFhac1JFUWpGVWt4ZkRk?=
 =?utf-8?B?cnU0Tzdsd2dxajVaSVpjTmNKbmZqME1DMk55Um1TUitBN2s1c1BQZUlaRFor?=
 =?utf-8?B?VTZIaVJIQnNxdndTUE90WUJ5OExZNEI3WGRQQ292NlNtclRMU1RXcytIbVNM?=
 =?utf-8?B?ZVRGU3dUand0bm1pYndtMzgrWHdmWWJFR3RncWZyZE5DVWpKb3Yvb3l3NWZO?=
 =?utf-8?B?ZmxRcVNXTDNJMnE3TnRreXhTY0txdStTalZCcUk2OTZBSzZ3UzBFK2w3V3hr?=
 =?utf-8?B?N3lKYU1BcDVVYnJ6NFgvK1JEK3NFMmZhbkdxVTU4SmY1Nk5MOXp5b2JBT3N2?=
 =?utf-8?B?T0RNRUd4VVQyTWQrNnFKWFJxTnl3Q0l6K2t5SFlvVGRMbzVXSDFRMTVGY2tv?=
 =?utf-8?B?bWF0RGhQNWNHY3FQenVLZk5mYnQ2L0lMc2ZBcFhxY0VUcnloUnZERlZpaWZW?=
 =?utf-8?B?dmRLclEwc0tzZmEzNXpkNG5EalBEOWZZVzBiWVdNQk9BZSt1Y3BaeXJhOEZz?=
 =?utf-8?B?M3I0M0k1VDRyaTUvcUJGMmQ0SGQ2eGVaS29PdjFvQitMRWhBbWJvU2tRalBl?=
 =?utf-8?B?L1VGanlIdHJua0ppUWhtSlVoeXVJMFlWS0hmcmtqMmtVaHEwd3BVOVhVem1E?=
 =?utf-8?B?Tk1nNy9QYnJJdmVCV0tPdWlkU0tBenErME5qd0xEVnJmbFZSeW9qSVphNVc1?=
 =?utf-8?B?RUl3QkVjSGg0OTVXT3VaSnZORnZHWVFvYkxsNWdvWmZBYTBiU2ZydmRqcnlq?=
 =?utf-8?B?ckRXZHBzK0FBQkovNmJVVWMzYksxUlpVbHZidUl0UUI3amxTN0pvakhVai95?=
 =?utf-8?B?VmhIS2F0bnIzM3dIQXBUdEsxUUt4WlpNK1YwZjNrL3dKdVZHOGI5QllKOEVh?=
 =?utf-8?B?Z0h6R3pubU5xTE1PaEhxMVZCM0taekw3cU9LRGlqZU9kOUQ0NTRWU2hveXFH?=
 =?utf-8?B?VWVnQUxITVFVSXJORllTNWNzdXk0WVhjTXREL0lhaVlWcnpFVzVKY2dRT1hP?=
 =?utf-8?B?ckcxK1pIeG9LQ25RemlMVHNNbmlRdUY3bzlUQmlCRU9BRVFTN01aeDVRMDdr?=
 =?utf-8?B?RTA3aUpTdXRwbU0xVkMya0NVMWVsYUVPWVFqR0NNQ0JBRlZpOTF2cDlYMUpx?=
 =?utf-8?B?a09mcHZZYk5MYUpkWHAvMzU4NVhkTE1HaFJtTEhpRHNZZFkzQmE3SFpGTkNp?=
 =?utf-8?B?dDN4d1ZOZDhISHJGS050Q3FRVjNvM3U3b3V5T2xQUGVkc1lEbHMrdVZhdDN1?=
 =?utf-8?B?QzRyWmJTWnVmQ1JleFk0akpJNFNBZkhnWTdXU1RhRUpzVVV2WERsUFJPekFE?=
 =?utf-8?B?MkRxV3FMcXdhdGQydGhETzBpTUFSLzViWENWVm8wZVJSODJoRlEyWm5JQnY4?=
 =?utf-8?B?bnRHTDJRM0dtZ3M3Z0FDcW5EYW9SUHlCc3h4cTd4dmd1NEFEeHBwUkhkaXpi?=
 =?utf-8?B?ZVJzcmpBcHlIQVYrb05DYnNRSGtMcXdwNTFxczUxd0daRFo2TU1nSk5uaTFK?=
 =?utf-8?B?c05qd1gxOUJ2ZWF1MzQ1YU5pMVN2M1NReEgzTWNQeFgrQW5NZDJqZnZ4V05z?=
 =?utf-8?B?d1krT2pJcDlSelRGUlpzR01aLzdkQ1BUTVFxVjRKVFJlTUZEZ3VBaUpXU09w?=
 =?utf-8?Q?uyXlpoPBgYBsOi2Jmg+EQcG9VukbbWSJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFByTlNIcWNzM09rUVFQUzN6QVFVeGZjQ05XOFRvTE1qVFZRZEJNb2Y1UVlh?=
 =?utf-8?B?dlhiVXBldHQwa2dyUjloZWxCUGNCV0pYMzhRSC9Ib0RtVU80cFBvSWtHVFFH?=
 =?utf-8?B?d1lRbXdNWko1M0hOTVNVNkVIWkppK3FhUnphTVV4aGNZa3NSUGFmTXFNUmFh?=
 =?utf-8?B?OXFJVUtpY2ZTYllPNkdZU285ZjBjR0h4RzlqNjlzSmF0R0drMnJZb1NUNHZR?=
 =?utf-8?B?cS9mMmpZeUtMbk1LbVlFaHE1MEs0eTB1bDZPcDdobWZyUlJmemlOUU10Z1p6?=
 =?utf-8?B?V2JaTEFRSHRtLzAwZWpCL3pCZFNGWEZtYXA1YXEzQnVlME42OXB3cGhXcDJt?=
 =?utf-8?B?QTdJOTZrU09iZnJkVy9Wd3hZdXhvbk83cE5OTUpadzJiRTlUTnpFbThWVElT?=
 =?utf-8?B?TEE3YW55VHc3aUtnNDY1dkZ1TDR1a01ZTHJNTGhtak1mRENOeGg5QnIrdkxM?=
 =?utf-8?B?a2x3RXdid2w4RzZ2QzhtUDgzdjExdnA2QmpCVGdvczk5dm1SVHIxbzZSY3Zm?=
 =?utf-8?B?TjZ1aTlWRm0xTTh6RXp2ajhjUGdaMXpQcmZCNWNjMVl5cThDbW1wcWlENEJo?=
 =?utf-8?B?U3JpSHJrNkxQOWJIR1RoelJCQlI4VWhmWkdQZHJRS1l1cHNXblZqSHZEajYz?=
 =?utf-8?B?dFg4RkI2TDJRU2JCb2Q2c2Q5NjQ1VURQZXN0ajdOaVVoVVBmSHpYc1VmT3dr?=
 =?utf-8?B?azI0SklRM1RHYmVhVGhDQXJ3Nk9mbllEM1AydEk5WHZzazdnOE14VkI0Ymxl?=
 =?utf-8?B?dkJDdjF2ckpSd3lBbG94TGpRbXlmdkZJNmREYVBuMUlPNlFuZTdUL1p4Y205?=
 =?utf-8?B?WmRlait1NUFXd05SdzlqajdHZkg1dmV3VW54a2VJZ3pMTTA5WHdFaDU5THFa?=
 =?utf-8?B?dDNGTmRzMTVocHlPUTE4WU4vRFNXZ29uUFpGR1ZEUGtFdnIzc0ZtRWpVU0F3?=
 =?utf-8?B?ZWFLNTQ2UHI5MndoQ0I5azBpekVUeENvdi9yR1JRckVKZ09vT3ZTWDMvOG12?=
 =?utf-8?B?TnRxUk9OeWJGb1dCdUpWWEc4dmNhb1lad3pmSFdPS2EvbS9kakJQdHNibUM3?=
 =?utf-8?B?a1ZOUW1xdHRjOWNoUWVnR1RxNDhReTduZlFQZFNuNHEzMEt2dm01S3J1Ym1O?=
 =?utf-8?B?UjFBM1lRTU0rSU5aaVhNeU54dWlncTdGOExJa0JGeEdVN3BKbnYzMEN5L04v?=
 =?utf-8?B?TlpxZUFzNWxKNjRZQkhCK2NhNVpoeGl0RzFYM0xDMzkrN1g4ZGZkWGdVRUlH?=
 =?utf-8?B?UU1LSlU0dWVEYXpGVnM3eVVwc0JJS2p2aGtwUDcwdHBJRUZ3RlJ4QmZBTmIz?=
 =?utf-8?B?ODBNQWtWSnRPcUE1U3hVcnd5NHFzU0ordlRyYy93QVVKQmhYUFRZUVlRc0Fh?=
 =?utf-8?B?WGoxNjhzQzNrV1pLT3NzRGhlMDBTM0RzZDhNWGhac3dEZjVCVXhqd1BEdjJH?=
 =?utf-8?B?alR6Q2hIdExYeGtFdDJkMUxaUk1UeDZPQWhzZHJaMWFJQk83NTlkeUtoNWp6?=
 =?utf-8?B?WlZGdUZpb1N2SzE3YWVHdFRvNTdISWRRSmhFaWF1dHN2UnAyTUtERXpGRXZL?=
 =?utf-8?B?WTNyZWhCejNWNUltOVVmVW9KVnR3YTJBbmhCUlVWRndGeUpFUW0wandWc1JB?=
 =?utf-8?B?UjhQNXBaSzVIQWJMNThIRG4wN3hmaER6dEJiUFhvbGp3NkRSaDZxekFTV0Ez?=
 =?utf-8?B?ZGNqK2hLWkxZckxiQm83aHhwaDdDOW1ZTjFhQ2tuNHVCNUtDUGttT05BS05Q?=
 =?utf-8?B?WURGK2pKZkRhMUZmWld2Qk5EWWVzVS9NcFNtN3YwRkZOLzAxZmR2elJxRjBs?=
 =?utf-8?B?OTJveDVIMWVlcnVvRlgzQkJjTlI5eXBxbVdXc2JIZUdURGFLU0RoRzhPYzNi?=
 =?utf-8?B?QXVoeUtWRFNRVFRmdURNMTkva2ZMc1duUU01N0NncU1qWXoyd1pkTVFiUDk0?=
 =?utf-8?B?aDR0VG1QVDVBK05aSnV5RFVLU2c4Vk54ZVU5aTQ3OXZnTUhmZlBrZDFXaDBG?=
 =?utf-8?B?MVo0VVNwUW9OelBucnR3RjQxblVpaE04WnN6d1ZDeVY4eS9GT2YrckEvVVBs?=
 =?utf-8?B?S0ZVd3FFckRyNmx1bnY0b2IwMENCRlhhRWRSbFA0ZHlzSEc1VGUrS2E5VDZN?=
 =?utf-8?B?cVJERGUzUnRjZVJ6Tjk0S3VyQ1N0OEJONGtSNHlGQWhUUzFQbytYUmJiL1Fi?=
 =?utf-8?B?KytaSmdmdjZJQWlMaHBLMmdYMUpseDByMkh4Snh1TlRoZXF4M0VIZjBIbHlt?=
 =?utf-8?B?anVQY0FtQ1ZjVTRWOEcvMkVIelE1RUlteHVOSDIyblU1eGVqT0d2aWdwamdM?=
 =?utf-8?B?RVRqUUt2aG0xaFNFc0JaZzhDVmhoWlgxYXNoanlGK1piWDdLOUE3Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b87f01a4-0b1e-4a7a-770a-08de49edd84e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 10:58:22.0469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwRjfZm84NtQ7HJsBhdkYaE5h84CMCg5Z/tnnpLl/vu3umIiZ6czzen4hn/GmSw392iT0VdhohK6EEy3orWg5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFDC28CEE69


On 23/12/2025 06:45, Manivannan Sadhasivam wrote:
> On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:
> 
> + Tegra maintainers
> 
>> This driver runs (for both host and endpoint operation) also on other Tegra
>> SoCs (e.g. Tegra234).
>> Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
>> dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
>> reflect the fact that this driver is no longer exclusive to Tegra194.
>>
> 
> I vaguely remember asking about this a while back during some other patch review
> and I don't remember what we concluded.
 > > Thierry, Jon, thoughts?

So ARCH_TEGRA means that this can be enabled for the legacy 32-bit Tegra 
devices as well as the current 64-bit Tegra devices (such as Tegra194). 
Given that this driver is only used for Tegra194 and Tegra234, it seems 
it would be better to only enable this for Tegra194 and Tegra234 instead 
of any Tegra.

Cheers
Jon

-- 
nvpublic


