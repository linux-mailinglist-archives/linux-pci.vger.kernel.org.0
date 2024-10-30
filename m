Return-Path: <linux-pci+bounces-15658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1D9B6EF5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8501280D60
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 21:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694621A4AB;
	Wed, 30 Oct 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ROU1knbs"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0F219CA8;
	Wed, 30 Oct 2024 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730323861; cv=fail; b=O9aKShoxSMA0LLtF5/f/+JJKTZCeB+VuiedrvoWSh2Gi+pyjofGNxr0mh7uULziHraxOUMOSrbfUI1bNC6I/EJ+cz7BsNurOHET9P23jXKCzSKkgjYqoZy4wq5JBMxRsUcx886/BjlUcITQlCWNRLKZxP9H58+k64H2Psgd00Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730323861; c=relaxed/simple;
	bh=YwjwGURVaYC2NtWPudhe0HlK/UE8tyoomslccByC+Xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FpImNDhOfiZ0dO/L1GLEv8PKETe9lfZA/zf6AlNAdkvnj3D9dDzyTZar/OYxocJQcMRM24Hgl7rDaUqgamXiCjkqGOS/U8zvGZPsgdlDKpRZgei8BomXrLCYXZ1S0Xz5JET3jfbnTZxXCIyQD59RU+OOJf4jVtsilU13P63neII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ROU1knbs; arc=fail smtp.client-ip=40.107.237.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzeoVP/7YG76ntKVuqwQamKZowZh+ShLqEgeHQVwUBefQ87NX/943C+hx1UIizFd7579Qim2nDzmmrarNWU07+aTA8s8T/dFWcyGslalqjEAS0/QLiKGpHlqXmm5iPT5BWT5VVtFCnUn8d2qtVJfy7nakvxRxG0kfjT440n6+W7yviRC5J6PYFJNzYRwQXmVADFa8BwgUXo5eI9uuI0fyiVfQJS/fb82yvsYc1tvhSLjcFN9eVcz9IwGxn803fv4ztuf7qk5AFBVLaTSXLXnarlMgFqjCEhDKVKozDkFAJ6yCJIrqWb0jleHJeXGzFhRZP+vuwQQDrPGyguyJcSIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VL4DPQGAOi61Kwhr8VVpUOJE6hK9LF+Gp+LRHby1160=;
 b=a3LLqHObeanybs7DXJS4w5VKfQZhc0CqFyQWcR7ZhLt3d5JoIqmhyYwQTMlLXm1oohtcsZN9Yuiu7c9cw4C6hz/39yubJPIlEZeSqiePRopwAjh3ntcV/NI3s8QlXwhLJPu/vxecB/T9755SsML+LGdQmIE5TtRMBw8wHgI3w9YMain3dpUPblB2r9LLhd6AJ7EU6f3Mj71h5xFW2AFvVoZizQ404gZbeh0vqUwhVc6qrEl8cD97LmmS0qr88kte6Ibw/jzIFKJ9+1ScsxS+uNLuG0/Wt2w2andYpQis1qosMOfEsqhLm9CF1jixZAYqe65tSXcxCACiHXFlMAXUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VL4DPQGAOi61Kwhr8VVpUOJE6hK9LF+Gp+LRHby1160=;
 b=ROU1knbs8bo8KRCdEF/8f1NBDXQz1j7ItUflihqjPwflre9jcr4qqKXBNHu61cSHDZMRPR7fVj/2dT4DqQUfx3dGY43lvXSt3aui0umVa7yfzXLyY0jIQ4Eyq739iUybkAV7HZOaD4HvgfHEgOVDLCAa7ui8YUPD/W2z6ILbtgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 21:30:56 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 21:30:56 +0000
Message-ID: <eee81573-6c87-4f20-afec-37f114fa7759@amd.com>
Date: Wed, 30 Oct 2024 16:30:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] cxl/pci: Add trace logging for CXL PCIe port RAS
 errors
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, shiju.jose@huawei.com,
 M.Chehab@huawei.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-14-terry.bowman@amd.com>
 <20241030160726.0000533e@Huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20241030160726.0000533e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::21) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 640034cd-16ad-4c90-ea10-08dcf92a236c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkJsazNWcklpV042VFBhczBYd1UwNmYrSDFPeklIVjJMazJ6TTdoVlhxbFZU?=
 =?utf-8?B?NVhFOVNVM0dXMndWVXh6QmZIYlZLK0JoVHQ2MGhxcFBLWUl0YUZnaEdlQzYr?=
 =?utf-8?B?eXJRUkExVDlrQWx6M1BTRHQyaUNTMU1oOHR1UmdqS0lCdmxHWmtVSzFGMjdL?=
 =?utf-8?B?eGVmUk85cHcwV09NNmx5ZkUxUG9sMG52a2pEdzhuaVB6MGhrRkh5OTQrMWM5?=
 =?utf-8?B?eVJHTnNvbDE3bllYVTVyMFFqdk1vWmZ5UVlOeFRDU040OU5BVm5nUC91R3Jt?=
 =?utf-8?B?cGNESktMK3F3alMxSjJvZkJYYWFPODZ5cHhSc2lBS3ZBQTZodEVON0Y2dUxY?=
 =?utf-8?B?OEFPeDlodFhFd0pCVkMyY2xpRDk0SlVPdjduRWtVQUs3L1ViQTJzQ0JkQzhB?=
 =?utf-8?B?MkJZRWxNRkU2dHBqS3RxdnZmNXZseW1QaWFGQnhVMTd2MVNOaUFWUnZZOGNn?=
 =?utf-8?B?Sk9qQXZheTNHNlVXYlVIOEM5V0NObGszTjFadTgwOFVVZ25GMWpSZi9mcEVP?=
 =?utf-8?B?NnVmdlRYV3FFaXVPS3RzeG9YOFFjRWtlUXpEUWx4K3pwWGdZeVB2cXNwTndM?=
 =?utf-8?B?ZEs1TGF1V2piTXd4U1FmTVk3NWVSMmVjaFNUOExhNldNNGhWdEpPN3lSeDZ6?=
 =?utf-8?B?SHdDWlQrTzNKWUIrdmU3RjZuSVhFRmptV2p0MitONmM1SjFVWVUwQ1dncmZQ?=
 =?utf-8?B?VnBLQnZEdHc2a3NUYm1KNTdZaVdJTHdsOE9oaVRhQmRITnl4Qksxdm55OFVS?=
 =?utf-8?B?RnhiWG43a25nUlBFRi9hUGE2WkFoY1JnWGdrM0dkak1BN0ZJZHhvMUt0Mk9v?=
 =?utf-8?B?Z3NwY2gvZXRBRXgwdjRGcURYcmJ2M0owUE1Zd3o0eHlaL21Wa0I5NjRITjg3?=
 =?utf-8?B?TTc4OGlkRUZCS2FQQ1gzMncvU2xYRnZ2b0kxY00ybEJucFlnNWVJcWJTZXA4?=
 =?utf-8?B?RXNzVzFZSFprSThKTmFUeWNzcDNrSXZZK1dacE1tamZRKzlHNWVuUHR1QU5D?=
 =?utf-8?B?OXd5UGpvY2Z3YTNqak9DczJyeVpST0cxYmZ6emp3VldCZUFBNUJuYjliOVZO?=
 =?utf-8?B?ZUpSNmIvTzBtNU9qVlhFVUZaaW5adUVEdkduaEk0eG5iM1FPdFpCWXZyTUF6?=
 =?utf-8?B?TW5zN1U1TW1wNjE2RElINlpSeHF2RDhEVDZOeDNUZUJEWFozOFBZaXh6MFdY?=
 =?utf-8?B?NHpsV3ZkV0pJSjk2b2t1ZUJMMkJoVUtwZWhsKy9MckRVS1BWaUV6SmxtZjY3?=
 =?utf-8?B?S29WZzNidXJmaTNrdGtuUVlMWDV6ZSs1MzA4L3NoUmV1MkJoaC9laHg2VVE0?=
 =?utf-8?B?dHRNeERiRGh0OGdqSURzald5dnJkWnZ3TVpNV0lSU0lxSVVyc3BLMmg0clJn?=
 =?utf-8?B?bXhvSmlhZUdwd3lPRUQwMFl5Q0pHdXBsNmVsUmFLM1ZlUHp6dENOaVlTL3Zl?=
 =?utf-8?B?OUV5NFFlR21TV0lFVzhFbWNIdWkzNEdkUHh0a205dDZETGwzVDJBQ1R6dVJJ?=
 =?utf-8?B?a2c1YVVmWHdUMjlTOEhSUjFPYWU3amtORlI0N0w2aGZibXBQNUIxVExNREdD?=
 =?utf-8?B?L0ZIZmhhK0xPSjUwamFGMmtjOTNmbVRzejJNbU9pOW91cmh0TUhqQm92UFlP?=
 =?utf-8?B?VUsvdW16aU4yRjRCQjdHYUFvWkIrdGNaR2NJZEExUSs1WDJudVUyalUva2w0?=
 =?utf-8?B?VEdJSDZRb3Z3VDN0QmJUMEduUGQzSUpsc0c0Z1ZLVGNaeVU4dExWcVhKZFUz?=
 =?utf-8?Q?wYLNp2aARdJXs489Q4PaaI3apnOSqj3HDfNzWOE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUJnN3RoYW1pd1lsd2ZHRmhzZVI4bjNuNDNzNzBzUk56TElibCswc2dwMWdm?=
 =?utf-8?B?czMrV0o0M05YeDZ3MUtSNGRZRS9VQkNvc2Y1M1RjWGRxcWs3U3pXM0VRbFNw?=
 =?utf-8?B?dTU1N3FqWWFhSkhMRXNLTWx3U2Nlb0JBcDVUVHdOZVplSURzSTljQTRoclB4?=
 =?utf-8?B?MEFxRDJoODdPTUFVOFYwSUdHQUYrM1FzVWJlVmluL0FQb3g2eVdOS1F4cldw?=
 =?utf-8?B?c0RBcFJIY3BWTjV3STc2Z1dBaVFFOGFGVDM1ZDREL0p3V1krOFAzcUx3Wnkz?=
 =?utf-8?B?UW1Rb2FFTjZEUXc2b3lFQTVaS0RHeHFIaEFHK1pRVnEwTzJ2Q2IzY2pGS2N3?=
 =?utf-8?B?ZFJhQjliWXFSK01obGF3VFBxaE1BcWlxMHZhcTJmbUhSWTFtb3lDWTE3S0do?=
 =?utf-8?B?WXdCWjcwcDV0M2o5VkRTQTlTK2FVSUFkOWFZRlhnL0FvU0ZOZy9UZWhYOXZH?=
 =?utf-8?B?SW1zU2p4TWhkamtBWWd5Vk56ZlNxTWljMC8yMVVmSWdaUmY5d0YrbmRzNEQ2?=
 =?utf-8?B?YWU4dVRmYXRncXVKMzVUMmJGTnkzUGJ4cjR0VVFKNDFQMXp2Nmx3cnp0dHZK?=
 =?utf-8?B?dXkzWVpPOU1XM3lIOHYzUnBYUUVrMVdOSGtaT3FBNEVtaWhodzQ3aXkxSGVi?=
 =?utf-8?B?SGFHTU1FMFJEaktzaWJJbnJEK1REbHk1eDNDLzNGVGdBb0ZVQWk5akgveVRH?=
 =?utf-8?B?OUIxR1M3WnZZZk8zb1BhRWl3RXV4Zm9wRG1iWnFDV3RaUG1pMU9wQkNlNHA4?=
 =?utf-8?B?Y2szcmIyRUM3VnhSWXVSb3pTcGFzTktrYm44K29nNjY1RDJCYkJDOTlaUzl2?=
 =?utf-8?B?a2g3NXFWMThMTEp3VmFIWEluK2w1WWV5endaa2tMaXp1MnRtNGdjTE5XVVRK?=
 =?utf-8?B?eDBIMjVUTFJ0ZFNBcmg1UDRiOW9NZm9pN0VtN0ROaW5iWVQyTHR5aEhjOGx1?=
 =?utf-8?B?TTNFUlRqN29TN0JHdkVqRGxjTUhzZkU1aTFlNkxvdTlCeXJHajBZbjZ6ejN3?=
 =?utf-8?B?WnV4djZiTFd5Q3BaUUVYOXhkLzB0Sy83VlRKZWVmVnFqdU1OUmVrUW9pMm15?=
 =?utf-8?B?THRJS3lTS3EyRmlvMitvM3ZhdWJ2NFVobytaTUpwSUVQVUE1Wi95TUZjMTdI?=
 =?utf-8?B?ZzdmSXIzYkdGOGYyejdmMk5NN0NlUXVpeTBZQUxaQllnUmN6TFN1UmdvWHpG?=
 =?utf-8?B?MmZxTllkMEFuaXlram9Ga3dpdVRKV1hNTHVMWm84ajlhUHBZbm5KSXJVeSs1?=
 =?utf-8?B?WFJRMkFvT3BqcGpLdllic0VMWmx2RVJqVDd6VE5lQmM1SXl3TUlRS1NGYTl4?=
 =?utf-8?B?clJUMGRJbFpnemtzNWh3VmZlU0l4MnZ5VVo5Y3VRUFhPalpVeS81TmFpa1NC?=
 =?utf-8?B?TjdsSWNyN050cjYvWVI3UGpXQmN3MW15eCsrTGQ3eWI1aDJQWGxONFJJY0li?=
 =?utf-8?B?aXJqVG9yQjNYZEFIbXdSd3pjTnZHNlpyRE5OdkR3c0NKSWpJd1lQVVZuS1ZI?=
 =?utf-8?B?aDVOajRvc1dtKzVCQkVaeDkzbWQ0NkhvSWZYMVRmWXZmeW5mWEdTaStEbjJl?=
 =?utf-8?B?amhRMnc4ZHdRQ0hBZ0w1TmNwazBnSnRYYTRUMmd3MUl6RkhLRWw5VUw3eWpt?=
 =?utf-8?B?SUVTUlIwSHFhaHFuUHJobHVpNmVETVdYVVFnT2hVdnpwU1JyT2N3MTBPT2hu?=
 =?utf-8?B?bFFuNkVBdUhveDNucmtHWm16YzI2VXhYS2ZaR3lwMUNzajZSdTlXSTJtTzg5?=
 =?utf-8?B?U3djbWtDQktzL1MvdDlCWE5KTVlOMUhQOVpBS25kcDhzVXZUR0Jkc1hPWVFl?=
 =?utf-8?B?Ukt4VjhWL1ZvblRCdWxSOHorc0pxNUlxb1ZYTm9rQ0RRR29CTllSTGZvMjdP?=
 =?utf-8?B?VkYzNDIrbEV1Qk5JWmEwakFzK0ZmRW41L3BDWUE5b0w1N3crQXV4cHlrUlhS?=
 =?utf-8?B?ZnhxYjBLZGxGT1hoRXc2QmFyd3U3Tnl0T2RQTnNiVGxVWWJRRVJNWnVVMUlE?=
 =?utf-8?B?S3A3cG40cFVUV2pZMmlWN2FMMG1JQXhYRnM2L1F3bndMWXJjNi84SnhCdHVW?=
 =?utf-8?B?cmhFSkNnY3hUZ2FuZGVWMGM2OE1BMEFhK3ZHaWIxMU1zN1k5RUxpNVNudjdn?=
 =?utf-8?Q?wxjrJFmkMCEsiuPwWVT915x4C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640034cd-16ad-4c90-ea10-08dcf92a236c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:30:55.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IpsQzqqVbZ4XDVhvgl1IkFwup2EW1urFlb8uLXhmjxHUSA1g91CtEC9p1MXXxOtRImdxQAXCtJSlIag4J/jEtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989

Hi Jonathan,

On 10/30/2024 11:07 AM, Jonathan Cameron wrote:
> On Fri, 25 Oct 2024 16:03:04 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The CXL drivers use kernel trace functions for logging endpoint and
>> RCH downstream port RAS errors. Similar functionality is
>> required for CXL root ports, CXL downstream switch ports, and CXL
>> upstream switch ports.
>>
>> Introduce trace logging functions for both RAS correctable and
>> uncorrectable errors specific to CXL PCIe ports. Additionally, update
>> the PCIe port error handlers to invoke these new trace functions.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> +CC Mauro and Shiju to give the tracepoint a sanity check and for
> awareness that we have something new to feed rasdaemon :)
>
> Jonathan
>
>> ---
>>  drivers/cxl/core/pci.c   | 16 ++++++++++----
>>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 59 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index adb184d346ae..eeb4a64ba5b5 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -661,10 +661,14 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>  	status = readl(addr);
>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>> +		return;
>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>> +
>> +	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> -	}
>> +	else if (dev_is_pci(dev))
> How would you get here otherwise? Is it useful to know it is a pci device
> here?
This dev_is_pci() check is not necessary and can be removed.

>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -720,7 +724,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>>  	}
>>  
>>  	header_log_copy(ras_base, hl);
>> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	if (is_cxl_memdev(dev))
>> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	else if (dev_is_pci(dev))
> as above.
Got it and thank you.
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>> +
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>>  	return true;
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index 8672b42ee4d1..1c4368a7b50b 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,6 +48,34 @@
>>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(dev, status, fe, hl),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(host, dev_name(dev->parent))
>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(host);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		/*
>> +		 * Embed the 512B headerlog data for user app retrieval and
>> +		 * parsing, but no need to print this in the trace buffer.
> I'm not sure any printing as such goes on in the trace buffer. It is from
> the data in the trace buffer I think.
Right, the comment indicates it is not printed but included here because the buffer can be accessed by applications. Regards, Terry
>> +		 */
>> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> +	),
>> +	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
>> +		  __get_str(devname), __get_str(host),
>> +		  show_uc_errs(__entry->status),
>> +		  show_uc_errs(__entry->first_error)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>>  	TP_ARGS(cxlmd, status, fe, hl),
>> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_correctable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(host, dev_name(dev->parent))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(host);
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s host=%s status='%s'",
>> +		  __get_str(devname), __get_str(host),
>> +		  show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_correctable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>  	TP_ARGS(cxlmd, status),


