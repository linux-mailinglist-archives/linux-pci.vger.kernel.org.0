Return-Path: <linux-pci+bounces-19941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14718A131AA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 04:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C991886212
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 03:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F6E78F3E;
	Thu, 16 Jan 2025 03:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="puWhqXP7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674026AEC;
	Thu, 16 Jan 2025 03:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736997097; cv=fail; b=Bm6/EQSKa+7juGnK33/bb8aUcW5un+3cfeMV1y1C5yQoPMpo3LQzCzC5g+Eh9tYdO6D3tTbqm01JfOuKxEmw5E4KR4alUAkbsXEW9rDdUJYFwiUzs2JyIxb9KADXCSuKIpiJBckc+vuM860DppIvqhHOQv+u19NlIIrdQwqE/Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736997097; c=relaxed/simple;
	bh=fvEOoAS0Nso6C3/n7BXbXEFzl8vUw4xuxEnzHQ9acmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YeVWGZYYiD/0S0ZZFNTmlnp3zPTtHZHDkCFqprJJwpgQyzetaaGgWRPx8EYlP3ie5Ss2GVJmvLO4Fddxbf/fy4JBUmYZOCgD8pNO3Ab3RuJjT9GboIFLtIuHFPVGyMe87UhTCXPYdX0+0zYceLfHjiLqDpMHKSO5ehxPew1wh8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=puWhqXP7; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOEKjBoouI6nF7TTdqdDsaU+BtCCqJeFwTWCAAvcL5B+cvG0d2pxKGCLdb0nGdEqbtXepQGF6F9lvBKCk+CoOSyK6k/TbD8fSivSX0omtqkPFENatdHAKaV3Cr4BJkpXUbpG/8TyFk4+EUjzlw5tYYeXdSSquoJDQHLOmoUabDQAfQPnwIdl1kYMe5i43nkCZi1MCvO1hM4fQI3NKTGU4ibX2s8a/WwcUphOnPIpPXw6YwAUsyITbJOIcOXlwb7wSL2R60KcsGRusQgya+VqdbKJhr51QfBr/3Y53vk7n59PHMfLPHcEWLc+XK9evtAHs975Q9leuigKXMzge/dp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2H8kN60+HUUg0PB9Qp4pDbDiVNGXMIW87f9XcS8idss=;
 b=IegfbmAS6g8BqO1XThGyvja86no9F/tSYD4oMykGddTrdkPsy6a3eb9d+7nFk1FdRKYLCvho5l5Y+fPJeFLLR4pxuuWg2+gz4sdM255T41Mneyi46p23QsFGNMuPpTfwkB773pbc490ZWRfiSRxGtI58I1Oc5BJFrM42Ec2IvfZM1P7/U5AW7MMrU8SpiqbFBvx/lD3sDqyooxieaIzT+aq4Un3/0ml4eh55Nml1QQMxM2qkdv9bDUzbYEGVGkkEQ2AV/5575F/DYyTnA7WSoOuYW0s2zVkXvbLt4vwrTKFtV7ggMMDdY8qmJZOQbO2A0vPW4R9uCb/1278isZ1o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2H8kN60+HUUg0PB9Qp4pDbDiVNGXMIW87f9XcS8idss=;
 b=puWhqXP71UNt+wiXidIIiNx/TT0YW6PG03Qido0WJYvM+yEX5Ss6lnEYtAum9RUssD2m5nPxqWe2HhBjijC16o69a4f0QBzw8q/06rNLU4ONqjPOINa7cDoDpTBvlUK61rYAsVrtW35kodpde4GeM984AsmBEhi1qT+ye4x9luPfwKgMRQDsm0qTnXK3gDrMc7hft7lJbjXrPTqWfHfLa6bT+3HZRe/0RQ2g05JRfrKHGNEDYiCU6Y7trPpXVt87TGXvAIxRXzuva6r3AlfNSatz5rnlMA66X+C/BSmw+FB1SUQtoDxuomgHP3ycwaEpmFs8sF9JVbmd0CfhM0Vdnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 03:11:31 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 03:11:31 +0000
Message-ID: <6ea9260b-f9cd-4128-b424-11afe6579fdc@nvidia.com>
Date: Wed, 15 Jan 2025 19:11:25 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, vidyas@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 sdonthineni@nvidia.com
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
 <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
 <20250113200749.GW5556@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250113200749.GW5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::15) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd89d08-00eb-4815-6bf7-08dd35db79ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVvZ3p5QTl5ZlN1Zi8zbFNMN0MySnZ2ZTcyLzh4bTU1dzBVU21SZXgxeUFx?=
 =?utf-8?B?ZmVaN1ZmWEM2aWNCUHVWNDI2bG94UlM5MFFZTUtCMVVWU1gxaG8rWkh1aG52?=
 =?utf-8?B?OU9RckZGREp0VlV5cXRSNFFxSWV3SVl0b0VsZGpQUkRqcnhrakt5dXJ2YURT?=
 =?utf-8?B?MFg1dUVVMGF0NVAyWityMkN0TzhlWGZkTUJmRUUrNHZaMUdIRmppQ3hoY1JY?=
 =?utf-8?B?MUpVc3FzYTZQcTdZUHMrVm1LWmVid0FpQnJLdjEyZkZyWGh3NFN5dGhKUWFx?=
 =?utf-8?B?V3JqVGlpd0drdGppTmpwNStiVlN5c0F4UWNYV1YvMnJQTDdwc2dkdmk2Yk1E?=
 =?utf-8?B?Mi92MXI0M0oxZ1l5Rkw2K0VmUlpRQ0dFZmVPRmNrMkJZaWNlMUJxU1AyaGJE?=
 =?utf-8?B?cnRMWkxFclV4Z1RTNkx3emRNNWxhczJCZ0NNMUQvWGtaNmtlQ0xTSDBva2V6?=
 =?utf-8?B?LzUrczFQenpNRXBYZHY4WE53ME9IQjNDYU1PR3FVeG5vZklVSXpVS3VGSGNa?=
 =?utf-8?B?NDBzb0pZcCswOXVSNFl2OE13RGs2YVQyOER3dFRNVWE2bEo4MGhBdHpxeTBO?=
 =?utf-8?B?V2lER3hEZVJuejY3eUpGbFlJcGdJT01ndEh2TXYyeDlHQzlwSzNSWUhzTXQv?=
 =?utf-8?B?dWg1UWxzeGdhdHllcUxuYjJpS1UyMS9rMkxZSDdCQXQzRHcxcGtQSDN6Yi9j?=
 =?utf-8?B?VFlHcG44ZG5ZN3Rsa2RPZGJoYWk1b1NBNDI1Nlp6VnVxbGxCNGZHaVdSS29J?=
 =?utf-8?B?ZENlckJ3VzlCemo3T1JQRmQ5L2FZY3lRRGNMdldadFhGdEl3T0ozQ2RSeENH?=
 =?utf-8?B?V3dqUzE5enNVWTRmL3Y4NjRicnl3SFd2bVFNNW96cE53TWZHZXp2bGVSRENl?=
 =?utf-8?B?MUNqVlV0d0V2RDZmLzdaZkxNVnUwUUk0M2tqd1Qxa0gzZmhwOERRZWtFWVBG?=
 =?utf-8?B?RzFxLytGU3h1TU1NT093TmZWajZsS013M0tCbWNZWGVjbnhObHZoL3ZlaGcv?=
 =?utf-8?B?SjJSMXVUYldzdWRFdFp3TW91SjFyKzYxOWhQZmgwdnZhMnN3Zmp4UTdaaGdS?=
 =?utf-8?B?T05aclRZU2FUVitvNUIyb2luT0RUQ2Q4QVhScnhEd3BSOFU3WGNiNzhOcW1M?=
 =?utf-8?B?MERpaUNxRTZVbElmUEtOMEs3TGIwdHFOV1JwU3FJVDVvL2NLS1NWT2FhTHZa?=
 =?utf-8?B?dFYrUkgybXgyTEZBT3Zwa3lBMVR3bGg0QTFiRFAzVnVmUlhSbzl4Y3ZrV2Ux?=
 =?utf-8?B?OEI5Rnp5ZnZZZkJCMzVqVUV5VlhTTjByYmcrNUxjMWNkM1B4THBWR29iUjJa?=
 =?utf-8?B?SGl4aXRKaVBQbVp6UXIvL3NTMTAwTXhXNDBJc0xES2xvT3ZrcDAyRjQ1akpj?=
 =?utf-8?B?NlRpcnVDcThCaXY2V2xjNHlwdXYvTjdnYWZldFBkYmhOcUZ2allhRC8rM0NF?=
 =?utf-8?B?b3N4RHg5dlExZFlzY3BIOEJKMEgzYzZBL0hMYmVBQk5lRS9Tdkg5Z1lBTnlP?=
 =?utf-8?B?aXJ3bnY2UEhWVVZhb2RlYjYzT0FtN3ZVdGRjK1JOYWpDWGNZbGpxRVMrVGxC?=
 =?utf-8?B?dTA2K2dHQW9lYnBQZnBrNFNERmdVUmJNeUJBS1BGZFhxd2VWWERLMERNSjkr?=
 =?utf-8?B?UWhqR1dOZ3MyQXByWVk0U01yV2tWYVRVbE02aVpEaHZDTFptRm9GZ0tOWHpj?=
 =?utf-8?B?OURwMkl0SXFxdExLMVVTTVVJV3FRQ2RGTzJPTThYTkUwWG5uaDBEZ05PeWtE?=
 =?utf-8?B?aU1lWU9zVmRySVNBQ0R3d0o4ckpqV3NpREV4Q0JPZjlXYW9ETmFqMHdlTU5I?=
 =?utf-8?B?WmJnbTE5QU1SVkpodTUyZkpsV3VMYVNQU3R4THU3OVY1dkhSTy9zQ2ViQno1?=
 =?utf-8?Q?EUTMZ196q/EvB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3ZtdEVEVVNGdStoT0NSOTlZeHFLMkJuWWNuaUZ0TGhTUHBWTzZVQmtQSDRC?=
 =?utf-8?B?WWlTazhxMVJaNnptNlpuQXJ1L2RldHZlYVFTWWZqQUpXZ1JESDZKUWRjUjJO?=
 =?utf-8?B?cFBCVTlrUmozaWt2c3M2Nis4aW5KN2R3dHNmb0VEMFFQQ2hBTjQrWEpwM2Ix?=
 =?utf-8?B?dGgvRjdKTjdKWFZJLzNySXovd2dMMFVvMDQwb2FYMEtwaHBTM1o0NExNSTdF?=
 =?utf-8?B?QmtuOWtTelBhc1JtWjNOUXU1Y2JBWmg5bG9NbDJibTR1OElOOWJ3SjF6V05I?=
 =?utf-8?B?WEJEWnlLZ09lMWV0WGczRWExS3hpTzRSRkVGSzV1Z2plUEZMTjhIenkwQ0pr?=
 =?utf-8?B?cG9pKzE5WDBMeTVITEh6U2xlK2pWS0g0SDZpSENGNUdnc3BiU2RjbjdFQUlh?=
 =?utf-8?B?eE1WRGN3Vk5qdVVidEhVZDBNMnlhcVdpWkxLMmpzcCswVzRNdWFEVlRPMEVH?=
 =?utf-8?B?Z0NLTGQ4MGJDcHBxVytnNStqWUVLbXREc2ZCMG5MVXNxM3F4MmZPaDhnR1Rw?=
 =?utf-8?B?bjJYcjM2ejlzdEt6N0xITm1lcy9hVTNLTG5UZklCbmZxaUI2Ny92ckx0eDcy?=
 =?utf-8?B?Z09EWkMyTUt5YkZlZGM1QmE1VC9OaWE3d042eUtmbUNpQWtTYTNjS1BFYmVj?=
 =?utf-8?B?TTR2bUplSlF6WXBzY3V6NTVVY2IwVk4xaC95bHk5S0JXODBDeUFxM0Y3a29Q?=
 =?utf-8?B?VjFveEtsdkROWFI4Tmpnd2FzWTVpYjBZaUxacTBPc2N5OURCNUFBb2lNZnJQ?=
 =?utf-8?B?WTRDRmF6c2c5VEdYcFh0Nm1tZTN0ZlF5em1xczFYdElHa1RoTWFqZGlNZkpW?=
 =?utf-8?B?THlmKzJodFhRTXlXN2g5NzhqTjJhUFRBenRCK2VaZjNpM3lCOTZURWFDTjJR?=
 =?utf-8?B?bUVYakNzMFA3S0MzY0JWU2V3OHN5aGlXcEkzNjBYSlNhN0V2bXZaODdQQWsr?=
 =?utf-8?B?RFVZdzRVQU85SnhFY0Zzc1dmd0RwM0dDSXpLSFlEQzJMZjFRZElFaHVrQUYv?=
 =?utf-8?B?dm1OSEVSK0U3eGZDbElIQjJHdlFUTzhYUzI0enJhWDcvVDhxeTNJLzgrZDdR?=
 =?utf-8?B?SkJGdDB2V0FlMEtLQ0lBdUhzdUVZcktGemdPb0o2dDA3SXRtemJOVjNwNEl2?=
 =?utf-8?B?Q0RFMjR5cnpiSENkUktIU3JlcFhsZ0ZQNlk1a1BwSUMxUWJla0J4VW93OVh0?=
 =?utf-8?B?UEk0RUQrZlVNc0h3d0R2ZGEzYXB3cTVxZ1pkNkV5MU45d3gyOWJCV1lXQW5V?=
 =?utf-8?B?Q0cxQjV5dXdKUGdFa29oZEZkc05VVHBRTEFvNlh3cVdCdXJodWJscTJtd0pn?=
 =?utf-8?B?clZ3RWhvR3dZQXppSDcyR2FCQ29xbWRlbS94RmErUG42ZVN2WjR1NlM0YlYw?=
 =?utf-8?B?WGl2cjloNVNUVldjTzVOUzB3OW5FYkJwWGZXaU51V2lUekVrUUt2eDMyZXVJ?=
 =?utf-8?B?aDJZenpQVVphVXhUY0laRHBOdFpBcDdNMUM0QzZRUlBXS09WVis4cmhIbUVR?=
 =?utf-8?B?WFQzeUdzakp1d2dOTUM2NWhyQjlENGhRQXRzUENZWFV3WVNObTR6U0dzNE9Q?=
 =?utf-8?B?WE83Q0dxUWwrd21pamladzFLdTdzZmpYaHlCOTdUSTBtMWxsQmxsWHZ6akow?=
 =?utf-8?B?cW56RWU1elVDV1paVkVVNTh0azFLamUyQWIzcXRGZ1FMT0VkVkxDaFkyc1dT?=
 =?utf-8?B?U0FUZUljV0kzbnlTOGJFRHRUWjBJQ3Q5SHJscEJWM2xNS240cXFhbEpRM0Zj?=
 =?utf-8?B?cWYzK01nRkVRcGpOMUMxdzFmZUtzU2JQdWJTQ2Z4dnNvWDVnM2FJejZjWXBm?=
 =?utf-8?B?bmEzaHVGdkErWGhsY252QSs1YnhKU2toMlRBTFdsZ2UxdFN1MjJDcE5PN0dp?=
 =?utf-8?B?d3RnSW83VUdKREJLZGhmMmoyaW5tMjU2dXYyVXJJTEtwZFRBdDR3eDVHTVhv?=
 =?utf-8?B?V0lPazVzTERrbTRITzJIMDlIZFY5ZUFqQXo5MHBQL0hzbFVDV0FMR0tvNThi?=
 =?utf-8?B?SXV0UTRjNFhwU1VzVW5jT1NXTktEblBhck1xVEJRNGd0NjVLaDlQcEFZbVFR?=
 =?utf-8?B?SFpSQ1BaNFVFZXJIdFUwZGJGNnBjekh1VnVsWnUyQWpITWVnczBSVkpRSlla?=
 =?utf-8?Q?kazXy/GbCOm2nzl746PoFLkfS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd89d08-00eb-4815-6bf7-08dd35db79ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 03:11:31.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEfk0069ZNxZu5X7keLVmd76Ffhmt7xdCo5suM6P3Wsv/K4WSuINjLRpL17+Czii5UNmtaMV40eVLa/wHtIhTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122



On 1/13/25 12:07, Jason Gunthorpe wrote:
> On Wed, Jan 08, 2025 at 07:13:34PM -0800, Tushar Dave wrote:
>>> Yes, but X in config_acs should copy the FW value not the value
>>> modified by disable_acs_redir_param
>>
>> I see your point. In that case (for the last hunk in my patch) something
>> like this should work IMO.
>>
>> -       /* If mask is 0 then we copy the bit from the firmware setting. */
>> -       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
>> -       caps->ctrl |= flags;
>> +       /* For unchanged ACS bits 'x' or 'X', copy the bits from the
>> firmware setting. */
>> +        if (!acs_mask)
>> +                caps->ctrl = caps->fw_ctrl;
>> +
>> +       caps->ctrl &= ~mask;
>> +       caps->ctrl |= (flags & mask);
>>
>> Wish I can have better condition check instead of 'if (!acs_mask)' but let
>> me know your thoughts.
> 
> It should be per-bit surely? I think the original logic was the right
> idea, just the bit logic had the wrong operators..

Here is the updated _last_ hunk of my patch with original idea but bit logic 
corrected:


@@ -1028,10 +1032,15 @@ static void __pci_config_acs(struct pci_dev *dev, struct 
pci_acs *caps,

         pci_dbg(dev, "ACS mask  = %#06x\n", mask);
         pci_dbg(dev, "ACS flags = %#06x\n", flags);
+       pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
+       pci_dbg(dev, "ACS fw_ctrl = %#06x\n", caps->fw_ctrl);

         /* If mask is 0 then we copy the bit from the firmware setting. */
-       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-       caps->ctrl |= flags;
+       caps->ctrl = (caps->ctrl & mask) | (caps->fw_ctrl & ~mask);
+
+       /* Apply the flags */
+       caps->ctrl &= ~mask;
+       caps->ctrl |= (flags & mask);

         pci_info(dev, "Configured ACS to %#06x\n", caps->ctrl);
  }



Some test results with debug enabled,

Test 1: 
pci=config_acs=xxx1000@0000:02:00.0;101xxxx@0009:00:00.0;0x1x0x1@0030:02:00.0

[   12.383327] pci 0000:02:00.0: ACS mask  = 0x000f
[   12.383330] pci 0000:02:00.0: ACS flags = 0x0008
[   12.383332] pci 0000:02:00.0: ACS control = 0x005f
[   12.383334] pci 0000:02:00.0: ACS fw_ctrl = 0x005b
[   12.383334] pci 0000:02:00.0: Configured ACS to 0x0058
[   15.416919] pci 0009:00:00.0: ACS mask  = 0x0070
[   15.416920] pci 0009:00:00.0: ACS flags = 0x0050
[   15.416921] pci 0009:00:00.0: ACS control = 0x001d
[   15.416922] pci 0009:00:00.0: ACS fw_ctrl = 0x0000
[   15.416922] pci 0009:00:00.0: Configured ACS to 0x0050
[   22.271312] pci 0030:02:00.0: ACS mask  = 0x0055
[   22.271313] pci 0030:02:00.0: ACS flags = 0x0011
[   22.271314] pci 0030:02:00.0: ACS control = 0x005f
[   22.271315] pci 0030:02:00.0: ACS fw_ctrl = 0x005f
[   22.271316] pci 0030:02:00.0: Configured ACS to 0x001b



Test 2: 
pci=config_acs=11111xx@0000:02:00.0;xxx1000@0009:00:00.0;111xxxx@0030:02:00.0

[   12.430316] pci 0000:02:00.0: ACS mask  = 0x007c
[   12.430317] pci 0000:02:00.0: ACS flags = 0x007c
[   12.430318] pci 0000:02:00.0: ACS control = 0x005d
[   12.430318] pci 0000:02:00.0: ACS fw_ctrl = 0x0058
[   12.430319] pci 0000:02:00.0: Configured ACS to 0x007c
[   15.461740] pci 0009:00:00.0: ACS mask  = 0x000f
[   15.461742] pci 0009:00:00.0: ACS flags = 0x0008
[   15.461743] pci 0009:00:00.0: ACS control = 0x001d
[   15.461745] pci 0009:00:00.0: ACS fw_ctrl = 0x0000
[   15.461746] pci 0009:00:00.0: Configured ACS to 0x0008
[   22.362102] pci 0030:02:00.0: ACS mask  = 0x0070
[   22.362104] pci 0030:02:00.0: ACS flags = 0x0070
[   22.362105] pci 0030:02:00.0: ACS control = 0x001f
[   22.362106] pci 0030:02:00.0: ACS fw_ctrl = 0x001b
[   22.362107] pci 0030:02:00.0: Configured ACS to 0x007b



Test 3: pci=disable_acs_redir=0000:02:00.0;0009:00:00.0;0030:02:00.0

[   12.425584] pci 0000:02:00.0: ACS mask  = 0x002c
[   12.425585] pci 0000:02:00.0: ACS flags = 0xffd3
[   12.425586] pci 0000:02:00.0: ACS control = 0x007d
[   12.425587] pci 0000:02:00.0: ACS fw_ctrl = 0x007c
[   12.425588] pci 0000:02:00.0: Configured ACS to 0x0050
[   15.460079] pci 0009:00:00.0: ACS mask  = 0x002c
[   15.460081] pci 0009:00:00.0: ACS flags = 0xffd3
[   15.460082] pci 0009:00:00.0: ACS control = 0x001d
[   15.460083] pci 0009:00:00.0: ACS fw_ctrl = 0x0000
[   15.460084] pci 0009:00:00.0: Configured ACS to 0x0000
[   22.347454] pci 0030:02:00.0: ACS mask  = 0x002c
[   22.347455] pci 0030:02:00.0: ACS flags = 0xffd3
[   22.347458] pci 0030:02:00.0: ACS control = 0x007f
[   22.347459] pci 0030:02:00.0: ACS fw_ctrl = 0x007b
[   22.347462] pci 0030:02:00.0: Configured ACS to 0x0053



-Tushar

> 
> Jason

