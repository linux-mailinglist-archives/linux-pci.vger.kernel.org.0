Return-Path: <linux-pci+bounces-28254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E2EAC0351
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 06:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A363B5FD7
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BC8149E13;
	Thu, 22 May 2025 04:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BwD6axck"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39717A923
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 04:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747886879; cv=fail; b=YYwVxrHLLkQqBJ+sriQE/uuXGxBsKCMZedAIwsUEmoERho4NTSR0f5jzP10Lqr9kr9vk1J7wK7lwaax6MffxpLjBxRIKeBl9wogH99UhbVu7XHqJ+yzOKc0+lx/XInAmHAWz5yd7T7RvWg4P8RVH29Wrt2VRTfkugTqIgroX7Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747886879; c=relaxed/simple;
	bh=oeRGXUzEDCK57YVudtuMF9mR+0JGkaT62ascq5CGe3g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dwVgh4r8mUbKc8WcQfB125QBJn9igvTe+gmhiKQ+Zqa/Ikvpsl/dnwj9y3PQ+2BuJPRNNWsVpfAMBzq5cOiciqzXTt4X0DxltRU7A9qJm2lQTdn5xY2UGYItD2GPTv0FXq3njoCmFCjdD3syct+8ih3O1MOhS71IY6i14QOe5Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BwD6axck; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q00g/L1Jq7yJ1vXiS4Kw82qq0nkOnZd0Z3LImiGIg4QXeXN6A/Imc5rmeJDzkYAYNphPrGiCEAGCcLudvqa9fG9oWAd6qa4RemXH2XdG9r3+SGkkJihMdtfjIfN7UniJejwR3+6MJ02xAM5iwqP4OJ8j1T4Hf4EkdJg+vlAE3uA5hF2PPXqmj+fBAAQ6wohahKxuDVgkuTYQ6FSPLibHxeZgro3k0ap87KXk91ZWKpoHbxr7WRzLv3KCwy81rGCVtSsWkSmkcrhP23gGdS+Vls3IA/sYfLt+2pu+ejT5Osh0q0PBO/GyZYuvwJjbxb33g+hNptFBmiKNVuPeIvFmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQe+IjXHo4cmhvNgNh1VPrlFWlE/p2Lt1+JJKA9mtiw=;
 b=Twh052HTmXBjZxQJUX5eOKO7L9pgB27FLiAEWI3BpIOPj37oTcTAaJ+1+s5bs64GZyTkCaGWza3MdLyv6UoPQJeyJ8jvRWAMeTkWw/iSUHVmR3thzm+215GDQT4ZEXmefRISsKwCnLHb5YkqS5NnTHTl0wIHVAFmkp2zdNClYVsmtjr2UZpMwad/Nzp0iLJBlsYAKpQC3eGWOZkqc+zsJt+AibrUJBaVpfn8eFP9siTeQPX4MJnx6XNnwmDJFpsvbfrx6iQcnYpYVkw8Qt+jXV1QFMJ6f8w5nsawKUn/Oc9AmO69etlm6LPMjR89fj9SndE9YIw7VXhu/Tk7Qr4jpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQe+IjXHo4cmhvNgNh1VPrlFWlE/p2Lt1+JJKA9mtiw=;
 b=BwD6axcksnk8yd/MCCuF7tDctEqzATvqNNB6hm5PDQcjjo7cWtzcqxCxtsug5ALhvDEZrc/Y3+KuCIgxzSsJxJUI/YZhYv2BStwkuAXyCxoGj41f7FPNkL8Z2HlM+l2ESi97OXJsv6U9suz9UhbCZIZPYUAj4AKTsK07Fzt6Kkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Thu, 22 May
 2025 04:07:53 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 04:07:53 +0000
Message-ID: <cc0e125a-a297-4573-a315-89f4f95324c4@amd.com>
Date: Thu, 22 May 2025 14:07:46 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 13/13] PCI/TSM: Add Guest TSM Support
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-14-dan.j.williams@intel.com>
 <363a3220-e43c-4965-b138-b85f09a5907b@amd.com>
 <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <682ceffd717b4_1626e1006f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0001.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::6) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7cc40f-d6ca-42e7-1f73-08dd98e63945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REMyWW0ydHFjNjIrT1MydXJvUFZFQzhuSkdQT0hKYjVXUnFMSlNHQW1GTmVI?=
 =?utf-8?B?RWtLMDJ5SXI0OWNNTjFJRkNIanp0V25CNktJSXoySkRicHlBOHJ2RG5LMy9q?=
 =?utf-8?B?OWxudEhjcEU3cll6VnJHbWVWK2pMYllZOUFVTlBTOWdtYVo2Mjl4U0JYNUV6?=
 =?utf-8?B?bzhuSW5naWVOWnJDbzVOay9VR0VnTGxRc3d0amVuVW8xYU5FVWE1NWZKWElV?=
 =?utf-8?B?RzJoN3BQMitIWUcvbzJHZVZONENYYys5SXI3NGxPWlQ0S0pqbHg1YlNyR2w2?=
 =?utf-8?B?T05lMW9yaXNtMDQ3ZU1tWU9vbkJHUHp4OThOU05mYXVXZnZZMjhpdXh2MDRV?=
 =?utf-8?B?OGFKckZiZGZHdkJCTzdKNUFqaUh1VzUxck5zUXNsVWF3WlVPS1M4RmRwZ0N0?=
 =?utf-8?B?RkpzLzNQMFdjUnFlbzY4MWxsME93YXZaWjh5czJ0Nm90WHNoQThjdVUzaVJu?=
 =?utf-8?B?cFNmS3dCVTE0SUdHRkpjdzk1WFVhZStZdExIZXJKc2l6aGk4aDZvWm14UUFr?=
 =?utf-8?B?Mk4vdmRScCtjWDdURXBuaFc1bk9WMDNOajZaREkraXRTOGV4VzJhb3RkaXMw?=
 =?utf-8?B?TFBLclVYUVF1a2VEZVg0RnRGRFhreStJYXpyMi9UaC95aEtpRzJQUGNoQ3Nv?=
 =?utf-8?B?RmNiV0orNWUweUpqeW5GZ05yNDF0U1FpdEZqaHc3L0x6dUJMM1F6NGRjbkE4?=
 =?utf-8?B?NzZoOWlCRWlwQnluY1dwblVySmU1dlB5d216bXJiVmN2bk8yWVFMMFAwVWVi?=
 =?utf-8?B?anJsK3IvSFlzVkJDYTJqbGdJK2tnSDRQZlVUOG1YWTZRa3dCTUtLL3VnVEN4?=
 =?utf-8?B?aDFqcHhjRFVqTmJCbklTSEtoNUJoQTgwVXhZTUVCbytMVmJSTlducmJZVWx4?=
 =?utf-8?B?Y3BlQzVTa3BaOHJzRHd5QjhHeWNmUGdmR2hTbW5ybW9BNlNRRWx3ZGZTNmd4?=
 =?utf-8?B?Qks1elQvMzhnRHhZUnhsQ21Ea3RKN1pHVVFRbXc0czNtOUt4Nkd1cGhOdVZL?=
 =?utf-8?B?OHdpUlNSeUJGZWg0Ym1IV2RibjhCL3FqT1U4ZE9nNGhBb2JhYzROYWoxUWsr?=
 =?utf-8?B?WWFsMEI4QmVlK3lwU1pCVnIvMXdBOGtsaGU3QXo0TGhVek5QckQxWTM0bXdp?=
 =?utf-8?B?YjBjNE1wZ2pVQmdHT1U1Q1M4MHBHQ0JIdW9mSDRSbVcyaUo5LzJ6M1Zockgw?=
 =?utf-8?B?NlZIK0s0VXlDUlI0Vkp4S3duUWl1bWxPbUhGVkVZZk0yTWFTcFFpTzdqUE1r?=
 =?utf-8?B?TXJkR2lQV1ZUWEhVLzZXcys0MFhqMTRqcWhyTno4elIzcW50ZnNsaDd3RWtL?=
 =?utf-8?B?VkFqalhNWThUVFlybjdpTHdCQmJoNTBTK1RhK0E5Mm5GSXppY2x0SWpSZEJa?=
 =?utf-8?B?b3U5RWl1WGFCclVhbklKRVBweUlBL3J6cERlVEhieDVkY3U5MnIxMERBZDZN?=
 =?utf-8?B?b0NhNlNQbDAxUjh4bEQ0RXppMzRhS29sWEE0SlM3cWMvTFdxcG43RytrOGNX?=
 =?utf-8?B?aGdvc01TWVlOWEdldnVsSFNZUkhLeWZBWDZHK0pnR0RIVnRiT1ZWM05UM2xu?=
 =?utf-8?B?SnJyKzdNQlRsRU5BaThEbHpFWmtlME5IMXRvM2tkRDZ2ajZrK09UT0pOa2hN?=
 =?utf-8?B?RzdiUWRIN3FTNG01RDdSSXk4UktxTnFmdGFCa1F3TDEyOExpbnhVRG5wdVFQ?=
 =?utf-8?B?cEdlMjV0Wi9ONEpHZjd5aGJVSUpobmtBYVlYVDJtRjJzeTBBNlo3RStyNWpF?=
 =?utf-8?B?VC9ETTB4VHllSFNBSlcxUG8yVTBINTI4RysxelR3Rm9BWkJxOTk2TWdzZUxz?=
 =?utf-8?B?L29RQXJIUDkvaXB3dUZpWFJtRDd2U0xaZzJ5SjBJS0NHalcyT3plMllFdkdw?=
 =?utf-8?Q?bQfJhckGZC/U9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajBnNkZ0ZFYrZDZEVHRPaVBhK2tPalZuNkFjQ2lkSWFBdC9KRm1VUGtCK0pZ?=
 =?utf-8?B?SUpvWC9nOTZRZ0oyemdiSW1uVUd3TU95WnU5QzU5TDJ5TllGbm1aOXJvblh2?=
 =?utf-8?B?WTNjVDhjdWE3WkgvajdlTk4rYkFIc3FVbkY2dEJOSVhkYjVWNkh3cWdkcUpR?=
 =?utf-8?B?VFRqTUxQQmdmeW9KYmF4b0dTcjlsQUI3ejhvUWdLVG02YVYyTFhvNGxwb29I?=
 =?utf-8?B?eXQ2bFlQdCtyWlhRNkpYUHA2aE1GazNkUmk2NEFTZWFYRDRIekkxMXlMZG5p?=
 =?utf-8?B?ZVpkeVI4S0FBNnQvL3lQT1RKdDIrTkxEYmZpYWVNUlc0cCs3K0JGR2JDdzJj?=
 =?utf-8?B?OTJ1bEg0ZElpTUpYRHJWb2lLMkVSM0VnVU9JcWRZSHlnVVkzZWZESkRodGsv?=
 =?utf-8?B?UTl6WVdSaDBtaDlWU2l1eUdZK0p6dmdFMGRZZWZKLzdPVTQyOEY3Wi85SlRQ?=
 =?utf-8?B?Q2lqVGgyNGZWZmI5MDkrdmlGd1ByVlMrSGNiOWQwL3NaQk1Gb2JMdW9tQVly?=
 =?utf-8?B?T3M1Z3U4aUZxSE5OK21QQWRKSnlpd1lKK1lKVmxDdTloc3VlVzF0WUpWcTk1?=
 =?utf-8?B?N0RRcjM3L1dvcVpnVm1Ec3RNQjZqaW4rQnQxeGF2dm1MdmdiWnIrYVlNSzRH?=
 =?utf-8?B?T3hOT1luQ2ZiWlB0ZklzQXRiSEhjWlVNdDVXaHMrM2NRTnJrNEdicTJUMFg5?=
 =?utf-8?B?RG5RREJTaHVUVDZiMmw4RzNyNDJFOUFvUXNwUUpoSFgyNkxScGIrN3d0Ty8x?=
 =?utf-8?B?WkxyMTh2SmVNcHk0OXBBKzJFTWdyOC92d3FxVTg5UlNuVHcrVVNiMjBQdU44?=
 =?utf-8?B?RDNNSXhJb0xVeDNLMkE2SkVPT0tRTTE5L21ubGx0TDlCVW5JWDlqTXpDMStx?=
 =?utf-8?B?YmdsYzBubnRTMW1CVGhwSjdRK2VrbmF0ODFGY3cyTVJTbGJrL3RNU053dUZh?=
 =?utf-8?B?bWtlSlY5YjBZUHZJSmQ2WnNlNHRyQUZOZlhFUjdmc0tMc2oyQnlMeHpzWFhV?=
 =?utf-8?B?RksxNDBYMTR4T01vN3JlSGROdjByNXdYVzlDUUpHckkvaGY2dGhyKzJBNW4w?=
 =?utf-8?B?OG1DRXZVa2RlQ0FBekZiRUQ2QzlFeDlwbmhNOWpnbkNJR2k2TjQ2WkpFQlBS?=
 =?utf-8?B?cEk5RGdoeVZJZ1V3REtWQXYzVmZPOFNBM3RqbmFHVzFtUUkwZTRKbDhhTGlp?=
 =?utf-8?B?eXN6ek5iN0Fmd0VrNWc2K0NlNkQrM1haUko5ZnlYUEIwNFZLakdWcUU0VkVP?=
 =?utf-8?B?dHdNSDdlU2kzNFVZSDUzN3pKVlhFWno5a0crd2dvQkhRUHpYL2FoUEVCdzRv?=
 =?utf-8?B?K0ZocnNpL0VtVzE0MktXSmNuV2lPNjMvRDFnUEx1Qi94N1NEMkFBWWRUaFRv?=
 =?utf-8?B?OE1WZmpBVGcwWEhwQkpQR3NjSStmcHY1NmM3N1ZNVFIvenUrKysxM2RDSnRW?=
 =?utf-8?B?R1E5WEhYRFlkWUswY3R0c2FNWENZQ1UySXRYQmpQU3dvL1ZyaXZxamFoUTBN?=
 =?utf-8?B?SzBGNUdnWVZsQkhFWnNxalB2RWZtaHc5aGRmSkdteDBUbzB0VjBlMGJ6Yit2?=
 =?utf-8?B?NlhtQmsrRHhkdzZnTGNKTm1wV1VWMm1sSCs1OUdvcVpJaERXQ1V0bk1pcWpt?=
 =?utf-8?B?VGhLZHVDaXNXZEJ2cUJyd1g0THN6OGpUV3BjRDZQRmYwMTAyOXdtWDJRa2hu?=
 =?utf-8?B?Wi9WVHRjSmdQUTFKWHRlMTZNaUMvQWl4RzhsY2J4NWs0Sy81clhaVE5kUWJN?=
 =?utf-8?B?cjFuekdYNWluTXl3SzBrRk91a0lBdllmaXAvaFhhdVgwTzFlS0t6anJxZDht?=
 =?utf-8?B?b2dQNDhZUDhlbENmOU9IUnoybTFHalY4SG0wWnRZVVY4dzhCTW9HT2tFN1Ny?=
 =?utf-8?B?c2oxbmtoc2kvNGFSczdORzhIcHl1S1ZuektPK3pUeUdpSyttRzhqR2hoV0JE?=
 =?utf-8?B?ZWxKRWhMeWRoMWUzRktLQ2trRlkzZU50R2pBMCtmN1V5ZDZYTVptQ1pxREd2?=
 =?utf-8?B?SGcxVXNnZGd0VXVNUFUrL09rMlg4THNzMmV1eVVmb2JmbmFjM2wvYVFSKzRp?=
 =?utf-8?B?ZllGV2RhQ1JoYW01eVIyQkpXdlhWeG1lNWRwNjVlL05IRGkxeTRlRzVnT3ZC?=
 =?utf-8?Q?QgX45q2eSkUa7ZdVh0jMElvdN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7cc40f-d6ca-42e7-1f73-08dd98e63945
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 04:07:52.9112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LD5T299fIlEL9NDq0gCn6lUfVawxsFm4oYO37jVfk/P5MIhC1khHDvz5GQrNhHFWYp15ic54PMXlfZewOKpLcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882



On 21/5/25 07:11, Dan Williams wrote:
> Alexey Kardashevskiy wrote:
>>
>>
>> On 16/5/25 15:47, Dan Williams wrote:
>>> From: Xu Yilun <yilun.xu@linux.intel.com>
>>>
>>> Enable PCI TSM/TSM core to support assigned device authentication in
>>> CoCo VM. The main changes are:
>>>
>>>    - Add an ->accept() operation which also flags whether the TSM driver is
>>>      host or guest context.
>>>    - Re-purpose the 'connect' sysfs attribute in guest to lock down the
>>>      private configuration for the device.
>>>    - Add the 'accept' sysfs attribute for guest to accept the private
>>>      device into its TEE.
>>>    - Skip DOE setup/transfer for guest TSM managed devices.
>>>
>>> All private capable assigned PCI devices (TDI) start as shared. CoCo VM
>>> should authenticate some of these devices and accept them in its TEE for
>>> private memory access. TSM supports this authentication in 3 steps:
>>> Connect, Attest and Accept.
>>>
>>> On Connect, CoCo VM requires hypervisor to finish all private
>>> configurations to the device and put the device in TDISP CONFIG_LOCKED
>>> state. Please note this verb has different meaning from host context. On
>>> host, Connect means establish secure physical link (e.g. PCI IDE).
>>>
>>> On Attest, CoCo VM retrieves evidence from device and decide if the
>>> device is good for accept. The CoCo VM kernel provides evidence,
>>> userspace decides if the evidence is good based on its own strategy.
>>>
>>> On Accept, userspace has acknowledged the evidence and requires CoCo VM
>>> kernel to enable private MMIO & DMA access. Usually it ends up by put
>>> the device in TDISP RUN state.
>>>
>>> Currently only implement Connect & Accept to enable a minimum flow for
>>> device shared <-> private conversion. There is no evidence retrieval
>>> interfaces, only to assume the device evidences are always good without
>>> attestation.
>>>
>>> The shared -> private conversion:
>>>
>>>     echo 1 > /sys/bus/pci/devices/<...>/tsm/connect
>>>     echo 1 > /sys/bus/pci/devices/<...>/tsm/accept
>>>
>>> The private -> shared conversion:
>>>
>>>     echo 0 > /sys/bus/pci/devices/<...>/tsm/connect
>>>
>>> Since the device's MMIO & DMA are all blocked after Connect & before
>>> Accept, device drivers are not considered workable in this intermediate
>>> state. The Connect and Accept transitions only proceed while the driver is
>>> detached. Note this can be relaxed later with a callback to an enlightened
>>> driver to coordinate the transition, but for now, require detachment.
>>>
>>> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>    drivers/pci/tsm.c       | 160 +++++++++++++++++++++++++++++++++++-----
>>>    include/linux/pci-tsm.h |  15 +++-
>>>    2 files changed, 152 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
>>> index 219e40c5d4e7..794de2f258c3 100644
>>> --- a/drivers/pci/tsm.c
>>> +++ b/drivers/pci/tsm.c
>>> @@ -124,6 +124,29 @@ static int pci_tsm_disconnect(struct pci_dev *pdev)
>>>    	return 0;
>>>    }
>>>    
>>> +/*
>>> + * TDISP locked state temporarily makes the device inaccessible, do not
>>> + * surprise live attached drivers
>>> + */
>>> +static int __driver_idle_connect(struct pci_dev *pdev)
>>
>> Do not need "__"...
> 
> I am ok to drop. The thought was to make this nuance stand-out more, as
> one more level of indirection than typically necessary, but no need to
> push that preference.
> 
>>> +{
>>> +	guard(device)(&pdev->dev);
>>> +	if (pdev->dev.driver)
>>> +		return -EBUSY;
>>
>>> +	return tsm_ops->connect(pdev);
>>> +}
>>> +
>>> +/*
>>> + * When the registered ops support accept it indicates that this is a
>>> + * TVM-side (guest) TSM operations structure. In this mode ->connect()
>>> + * arranges for the TDI to enter TDISP LOCKED state, and ->accept()
>>> + * transitions the device to RUN state.
>>> + */
>>> +static bool tvm_mode(void)
>>> +{
>>> +	return !!tsm_ops->accept;
>>
>> tsm_ops->accept != NULL
> 
> Yeah, that is a bit more idiomatic.
> 
>>> +}
>>> +
>>>    static int pci_tsm_connect(struct pci_dev *pdev)
>>>    {
>>>    	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
>>> @@ -138,13 +161,47 @@ static int pci_tsm_connect(struct pci_dev *pdev)
>>>    	if (tsm->state >= PCI_TSM_CONNECT)
>>>    		return 0;
>>>    
>>> -	rc = tsm_ops->connect(pdev);
>>> +	if (tvm_mode())
>>> +		rc = __driver_idle_connect(pdev);
>>
>> ... or just open code it here?
> 
> I will do with dropping the "__" and keeping the helper with the
> comment to keep this function less busy.
> 
>>> +	else
>>> +		rc = tsm_ops->connect(pdev);
>>>    	if (rc)
>>>    		return rc;
>>>    	tsm->state = PCI_TSM_CONNECT;
>>>    	return 0;
>>>    }
>>>    
>>> +static int pci_tsm_accept(struct pci_dev *pdev)
>>> +{
>>> +	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
>>> +	int rc;
>>> +
>>> +	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
>>
>> Add an empty line.
> 
> I think we, as a community, are still figuring out the coding-style
> around scope-based cleanup declarations, but I would argue, no empty
> line required after mid-function variable declarations. Now, in this
> case it is arguably not "mid-function", but all the other occurrences of
> tsm_ops_lock() are checking the result on the immediate next line.

Do not really care as much :)

> 
>>> +	if (!lock)
>>> +		return -EINTR;
>>> +
>>> +	if (tsm->state < PCI_TSM_CONNECT)
>>> +		return -ENXIO;
>>> +	if (tsm->state >= PCI_TSM_ACCEPT)
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * "Accept" transitions a device to the run state, it is only suitable
>>> +	 * to make that transition from a known DMA-idle (no active mappings)
>>> +	 * state.  The "driver detached" state is a coarse way to assert that
>>> +	 * requirement.
>>
>> And then the userspace will modprobe the driver, which will enable BME
>> and MSE which in turn will render the ERROR state, what is the plan
>> here?
> 
> Right, so the notifier proposal [1] gave me pause because of perceived
> complexity and my general reluctance to rely on the magic of notifiers
> when an explicit sequence is easier to read/maintain. The proposal is
> that drivers switch to TDISP aware setup helpers that understand that
> BME and MSE were handled at LOCK. Becauase it is not just
> pci_enable_device() / pci_set_master() awareness that is needed but also
> pci_disable_device() / pci_clear_master() flows that need consideration
> for avoiding/handling the TDISP ERROR state.
> 
> I.e. support for TDISP-unaware drivers is not a goal.

So your plan it to modify driver to switch to the secure mode on the go? (not arguing, just asking for now)

The alternative is - let TSM do the attestation and acceptance and then "modprobe tdispawaredriver tdisp=on" and change the driver to assume that BME and MSE are already enabled.



> There are still details to work out like supporting drivers that want to
> stay loaded over the UNLOCKED->LOCKED->RUN transitions, and whether the
> "accept" UAPI triggers entry into "RUN" or still requires a driver to
> perform that.
> 
> [1]: http://lore.kernel.org/20250218111017.491719-20-aik@amd.com
> 
> [..]
>>> @@ -558,11 +675,11 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>>>    	if (!pdev->tsm)
>>>    		return -EINVAL;
>>>    
>>> -	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
>>> -	if (!pf0_dev)
>>> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
>>> +	if (!dsm_dev)
>>>    		return -EINVAL;
>>
>> A bunch of changes like this one belong to 12/13.
> 
> Whoops, yes, missed that before sending.
> 
> [..]
>>> @@ -135,6 +141,8 @@ struct pci_tsm_guest_req_info {
>>>     * @bind: establish a secure binding with the TVM
>>>     * @unbind: teardown the secure binding
>>>     * @guest_req: handle the vendor specific requests from TVM when bound
>>> + * @accept: TVM-only operation to confirm that system policy allows
>>> + *	    device to access private memory and be mapped with private mmio.
>>>     *
>>>     * @probe and @remove run in pci_tsm_rwsem held for write context. All
>>>     * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
>>> @@ -150,6 +158,7 @@ struct pci_tsm_ops {
>>>    	void (*unbind)(struct pci_tdi *tdi);
>>>    	int (*guest_req)(struct pci_dev *pdev,
>>>    			 struct pci_tsm_guest_req_info *info);
>>> +	int (*accept)(struct pci_dev *pdev);
>>
>>
>> When I posted my v1, I got several comments to not put host and guest
>> callbacks together which makes sense (as only really "connect" and
>> "status" are shared, and I am not sure I like dual use of "connect")
>> and so did I in v2 and yet you are pushing for one struct for all?
> 
> Frankly, I missed that feedback and was focused on how to simply extend
> PCI to understand TSM semantics.

That was literally you (and I think someone else mentioned it too) ;)

https://lore.kernel.org/all/66d7a10a4d621_3975294ac@dwillia2-xfh.jf.intel.com.notmuch/

"Lets not mix HV and VM hooks in the same ops without good reason" and I do not see a good reason here yet.

More to the point, the host and guest have very little in common to have one ops struct for both and then deal with questions "do we execute the code related to PF0 in the guest", etc.

My life definitely got easier with 2 separate structures and my split to virt/coco/...(tsm-host.c|tsm-guest.c|tsm.c) + pci/tsm.c.


> Part of the motivation is reduce the number of details that
> drivers/pci/tsm.c needs to consider. I.e. there is only one ops object
> to manage. Can you share the lore links for the comments that convinced
> you to change course? Maybe those folks can chime in again here, but I
> might have been too focused my tdi_dev object model concerns to notice
> those previously.
> 
> As for repurposing "connect" that also comes back to question of whether
> userspace needs to see or care about that nuance. In the end "connect"
> is "prepare this device for follow-on TSM + TDISP security operations".

I see "connect" more like "set up ssh connection with some ports forwarded"

> If the "accept" attribute is present userspace can infer that it has
> more work to get the device operational in the TEE. So the interface can
> indeed be more verbose... but to what end?

... and these "accept" as connecting via ssh-forwarded ports. Not the same thing. But not really an issue here. Thanks,


-- 
Alexey


