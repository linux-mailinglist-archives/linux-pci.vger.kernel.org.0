Return-Path: <linux-pci+bounces-29074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B930ACFB22
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 04:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20FB3ADC63
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E921C700D;
	Fri,  6 Jun 2025 02:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HuIkt9Xn"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F411DE3BB
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749175755; cv=fail; b=DrjuK1YO1r6DipwTsbm2aGMozOVYGjMvVatLiLq0XrgWoMjxWy8Gr5e7YoXqLV9ONR2lb8zc6ZidsIkLK/OHnbFrvJbTYL0lpGK27Z3IwP+BuoLZwMxTyoPY6HDCBYSvZ5Zzk9DQC9TdxxotP3++7ogGl09mTLba8gp35loe76g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749175755; c=relaxed/simple;
	bh=eRouBwGgFA28XWB+vXp/62rBLmCQ80siEsAVy3REtoo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1EPEu5Qk+v0zCbiE1GCnTE/6B96o4cGd5PJV1RrNILBY04uFLL3vxV6QbsGBR387RsUgaF7CS0H7ukXGPB1Y+h8Q43UuCFNs2PiaZ8ZCfnYFGgRNLkS9ENXKmmyCiBmkcZptqinssFzLOaXdQXtNAGwHgHqp+jVR4Oi2IwMUMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HuIkt9Xn; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y26Um19OJcjHUvyXYtH+PG8srEuOo+QW4Ba5QOvazVLxiJr5md/VTwSl9yUCMt6O2mkDik/ASyXeNkNnWGfbXw+oaQ/GAwZPH+PnV+yRk9XfbiuSF2S/6USYGwEjIdPJ2Vi87XLiM3SwOQPkLCX1P4SB0bN10Qc8s7cUEsTlaGnzaVx2FOh8TNjwq5BvxiLrY31MXVxbQL2wcWbV0OR3t0BzEVTq6ics4iWiFcfl2HN8clfSk23OaF5LjmNFToWlIQvVZMEEWi7nvjaDhBw65YJ4Z7eTnIoJo5vQJUfgYIl8dmx113CTB5tl/pHwci5XEkrwhNFLXhGkDmSmIgUcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8RtPcv/4GtIR7MxyE2sDodMPsdt3fsyL2oOvGm5jAU=;
 b=g/KVFUKq0ypWDKXhHOxfWrBNN0kejhKuUvQVab7ekVKYzKN5rOCfDqi6fCh2aSvDPhX8Uu7YMaD1TZ8fWygu9DYxD5+/k3eMseTcrXCDOQMH3y4cm7yEno5oGauI7jguNUnhEi7nTHiIbFkP9e/6gvXrKq70TdjU/+dcQ0hh7vbQcto9j+eBIrnCFJWTccYwtTuOnwaFU6YYsfw+a8Q9A/d38wvPlRRNwv2qB7D9ksIkZvJ0i7smY1eBySz31Y5fQoiguwafeEPVdTMYzZ9tqacZk4crotPsjlpTahxnrKkDL/KCO7VMXscY0pSLktiMJt0pb3OKS3ORuwGfHuqXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8RtPcv/4GtIR7MxyE2sDodMPsdt3fsyL2oOvGm5jAU=;
 b=HuIkt9XnzbhD15SEY5iA2utALvQ1V6HIUjtNRWAUVbF879m3bPSYxn6ybuoWCMLCj7wPWkYwhNoWHdCp6ML3waSTrhFXGsFcuDw4a23zboR0/VS/uUMKNb+2+GreDMHdMSEwDKjY/523Y4Dby6TO4a/xwuEE5/Y9UCynZ7C4NtI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Fri, 6 Jun
 2025 02:09:09 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 02:09:09 +0000
Message-ID: <986e3749-750a-4a7b-b800-7939f65fb97a@amd.com>
Date: Fri, 6 Jun 2025 12:09:00 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 01/13] coco/tsm: Introduce a core device for TEE
 Security Managers
To: Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
 gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, zhiw@nvidia.com,
 Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@intel.com>, Yilun Xu <yilun.xu@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-2-dan.j.williams@intel.com>
 <20250602131847.GB233377@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250602131847.GB233377@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P300CA0103.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:248::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: f4963d07-be88-4d77-aa4e-08dda49f1f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFsWnQxWXdvU2Juc1J1OCtsYzNzQW91TnVuUU5zRnFQT3lENUpqbWZYdGxn?=
 =?utf-8?B?c3ExRUZ1TWoybGVscllNYTNHMUJMZi9MZ2JRdFdJS2kwVTN6RlB2bEJJWkMr?=
 =?utf-8?B?VkF6K01NVWlwc2dGWWRHU1ZOS01RRWlDdUdjM3o4NGRXdkpUODlHRDlBN00y?=
 =?utf-8?B?L1VOWE11RlZaSm9EdU90dzNxOXRYOENTMWVWL2htZkVIbUY2VHhkLzZuWHQ1?=
 =?utf-8?B?ejY4ditkcGpEUkZRWURXS1p5YkpEU3I3aUVBeVZuR2JYYnFpT3I2Nmw1elpH?=
 =?utf-8?B?Q2FuSXprVUNrd0cyK0VOR2hHbktqNlFjZVJ5bUNqNG9jVjFsV1JQSmc1UFY0?=
 =?utf-8?B?MmdoazNiUEV3MHZQVGdwdURBTytjdjEwdFU4SkVXN0VlNjJJdWtPRG9SeTBv?=
 =?utf-8?B?MnB5OTc2UzZQU0ZEaEJPZVo3QVpGSlJGTllNaDZCVStIbFBxbDRQd2NyOUJp?=
 =?utf-8?B?S3h6SXplcExzekpyZlpsVERZa3Rjbk5VTURJd1ozWW56UE43ZjRLbDkwZHBD?=
 =?utf-8?B?bURWYkYxU3RwTFZLVTA5bDdCL0s4RGNVU3E5SC9NSmJXTlNQK0R1VWlhS2lZ?=
 =?utf-8?B?Q1hoZ0xFa2Rwb1d2RWp2NlF1TDRhcHVianltVXVsOUFqZmhNYXJJaWFSNWF2?=
 =?utf-8?B?ZW9RZVBZQXZ3d085dHM3NGsxaU1DUGVUcys4Nkxwb0VCNTBXTGRIeUE3cm9u?=
 =?utf-8?B?MkR0MERCTFp5ZlFRMUFWaHB4b2JVeDM2WmNreld5WFlFMVBlYU8rL2lMeWpL?=
 =?utf-8?B?TDdEYkNTQTRQU1pRSGFObDdEbmNYVHY1Y1VTVDBhYm5DSzZvaWd5V0oza3Y2?=
 =?utf-8?B?K1pWWkR1SUdSall4ZUI3ejB3ZXR1UU05OWIrYkxocHVqVjFxQkdqTUtBNHRj?=
 =?utf-8?B?RUJSMUNlZUUrNEh3YitkSXRVTTJzM1lpWnRIZDNiY29hY1lianIvckxEU09B?=
 =?utf-8?B?dnh3Vmk2WnV1SmlpRFVMc29JMDB0WXp3UHhMU2t4NStKdE5oS1FYMnN4aENW?=
 =?utf-8?B?MmFuTGxXUFdheVJWSnA0UVNKVWJ6Vlo3aFBqTkYvcC9UcFlFY242clZNYWkv?=
 =?utf-8?B?WDZWLzdnOXZ2UDdWcGhsQ0dtc2dXdG83RUNZQzhOdlEzVnh3U0ozMGJEcFNR?=
 =?utf-8?B?YWpVVWdKR1JUbHc5bk9hRXJTL0FXSzdlYnlvZm9uejYyRGliVzlqdkNOY1Bm?=
 =?utf-8?B?VkRDbTZJbE9CWVkrdWthMkIzMFRySUdqdnZ2WUdQUSs2YmMxTXNJY0s2MnJu?=
 =?utf-8?B?WGMya0dTVnh4TDVMZE5qYndWTXhIQnNOU3JWWk91cVgvVjZrUjZPRk51empJ?=
 =?utf-8?B?bjdFV3FzODFiUHFKVHJKOU9wdm9HMXh0OStFTmpQckY5NHREcW5UOWVZRGpR?=
 =?utf-8?B?VDY4dWF4RGdMZlh1QUgxRVdVU0dvUm56Ty92K1U4VE5VYzVMUTFQTHdFN2Vp?=
 =?utf-8?B?L1JVNkt3clFPcHA4SUo4amVGM01rRHBHYmlyTjN4UDFrd3oxSmNWNTFqTTRK?=
 =?utf-8?B?MVAwT3ZEVmEzczVkSmV1Vk8rb1VYTGxSRllEb2wweElqUkJOMFRHNGJpdHRs?=
 =?utf-8?B?OU1pdHNTNzg2Snh3dDFlRjRvOWMxeVFZSFVtaEVtN1pPdGNTMm1DYnhTZ1Qz?=
 =?utf-8?B?WG1nc2J4S1g4LzJVM3pkRHNqOUFuMEhCL1VlUU1DUG84MHVVemdrVTNUcmho?=
 =?utf-8?B?c01DcWdNak8ydTVaby9DV1drYjE1UnBrVTRXdDczMFBSaXYvSmpIVDhEMk45?=
 =?utf-8?B?emlkZWJkWUFKdmZxdnJudGhNTDlOc2VzUXVjejBvMWE3djZ2Z1NORWlOYjhn?=
 =?utf-8?B?VkEyb1V5dU1hQ1kwbzB5ZWZCcUtOd2w0TDFIR2Q1MHdmRjFuM1Ird2MxZ0hz?=
 =?utf-8?B?SVN4QnQ4VkdtR3k4ZE5aZldGYy9OR2pEbDhGOUlFb1kwbW9aSFVNc2x4bjY5?=
 =?utf-8?Q?Crc0pXaghuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE51cmcwTXZRYjM2bUVjNVRvM010WnoreTBjSTE1bDAyZ1RneVhWenl2U2pD?=
 =?utf-8?B?dHQ2ckdQN2NPa3hISWNMVDFKR09iZEh6N2ZOWU01ZzBPZGdXUjhFN2dFZk9i?=
 =?utf-8?B?QlRFQmpiSWxOVncya3pHdnFOd2l1cjFxK2g1M3oySXgxcnpUREsyekZrc2N0?=
 =?utf-8?B?dDFHOVNqczFja2lJVVF1MHlkN0V1eHpDZEFDZWY4TWRsZVB6ZXFpL0t2ZlFU?=
 =?utf-8?B?OGZmbVQ1T0FJYSt1L2tXNjN5ZTA1aStxNE1HNWx0MWVNdUNKaE5jRkloVHdG?=
 =?utf-8?B?NGNuZm5LQkkzZVlHRmFLek9mYXZpbHhEM2ZRWGtmUWlSSWFzZElIUGp2alJY?=
 =?utf-8?B?bnE2ZnZZenFtWC91WStPaHFlcnA4Y3hwWlBDQmc1dnBKM0Q1Q0hqN0NnVFBR?=
 =?utf-8?B?a2J6VGIrOGxURzVuV0VWTndPekpyY1U1WnNIdEkraEdOTFN6cWlaTi9Yam00?=
 =?utf-8?B?cGxJWGU2ODR2RXdtaklDUlRudHJFZU5RZEtZWkRSVEJLR3RZZkZtZk9jMEhr?=
 =?utf-8?B?NldnOUF4WGtwU0dmWlBqVFlMWEdoS1pSTnNYempiazNUUkY2d3I3dUEvWlJj?=
 =?utf-8?B?MjFCdHdHMlo0cTg1Q1ZkWDgwWWI3UFM2S2E2MFVYVjI2QnVzWnk4NGcxRWhj?=
 =?utf-8?B?UnhCUkI1UGlTZXdVemNsejU0TnYveEZhaFF6VnV1WkhDOFFCMkUrd2xlMHF4?=
 =?utf-8?B?NGZGQlhSZVMweVJTdjBoMDJDZk5xMW1Yaldxb3EwaWd6RVhFUXdreVh0SHg5?=
 =?utf-8?B?VmNWT0xLS2RhdnN6NUpndXUyd0NHZXkzc3ArSHRoMloxbzV5YU5Obi9Ud0lO?=
 =?utf-8?B?dXVRcmhXUTNqN0pXNU12VGtXTEFSbUV4dElqaWo3VXVLeVQ0YkQ3MjQ2cTJl?=
 =?utf-8?B?SndiL3RtVldYNUE3cmd6L0poZk11LzJWbnRUUnEyZEJtNm9tZ3QrcW0vNXBw?=
 =?utf-8?B?WDZwYnhqNnZhT3VMOVVSa2R0aHBhNzJSeFcyWnpPSUUwQzE5LysxMWh0L1Bp?=
 =?utf-8?B?TStUdWZVbUp2Q3pvVFR4OURRdHF6MHN4S210YlVFTmVOd1FBN2x2VmJhd2s0?=
 =?utf-8?B?SjhreWg3aFlKdnhYc295Mit3czVLMG0yL1pnQW41eW1LTlhEWlhRMEpyLzhj?=
 =?utf-8?B?MmV0SzQ1RFVRRFBNTkxoWmdkdmNRQkN5UE9YdWVHcG9VUnlzTDJ2K3ZTbGRH?=
 =?utf-8?B?ZE9ndUFXRTdCNTQ0VWpwWm1xcFJpYkhwQkxUS290bzJ3TVBkWGdMWFJVN1Mv?=
 =?utf-8?B?MGFEc1lkZWl3RWF3OHVZMmxIN3c4Y3FmVXQyNHJiZGtTbmVSQUN4Yklha2hn?=
 =?utf-8?B?QlJEaXJkdDRaOFpxNllFb1luZ1N3bStXZnJjMDd2RU1xS0UwOFpGNUJMUHVB?=
 =?utf-8?B?WWEzaUx5QUwxRUZoUGFvUTRyVjZRRVhDcytlQjgxYlVHbnp1VXhrbmozeTli?=
 =?utf-8?B?TzhyRkQvUWlPSTVlQStsdXgxY0V4QVpNZ3Q4c0drb0VnaTI1MktvdVJsa01R?=
 =?utf-8?B?R0JBRTVVc05Qd1AzYlJtZG5hK1ZDR3RrTGI3Q2tJWGpNTFNVbnpkQnRGVmNn?=
 =?utf-8?B?aWpKemlhTmduZHdxOHdXR2h5UkJDdS9vNDZVUjVJZEUzQXFRRWswUUpjdWxq?=
 =?utf-8?B?a0pzbHhpak42dTdSRFZINlZEZk1nNEdnMExaQWpqTDU1bUtuOGk4T3hPM2tW?=
 =?utf-8?B?ME9peGNBV3pJWVBieVhyRkY4Nk80VlhRNHlzMERpaWt1K3hvNkpBNE81c3Ez?=
 =?utf-8?B?eng1K0libDh6UVdwVWMwKzk4V3BQanRQQWhYajJWTHBBbElMNWZhdGJvdkpp?=
 =?utf-8?B?M0F3T2lDdnRvMlNESzV1RHZaUXUrT3ltTWUyWFV3RUdrb1JXMTNNV09pdHJN?=
 =?utf-8?B?NlpyVnphZTBzRFpZZWxPKzlCWXZwRm5YRWEvUFg0TEh5WnV4dEtwVURaYVBm?=
 =?utf-8?B?aU9IY2JBMmtPdUVzWVdyU0tMVWVlVEpTN3crOGxrcTNUV1pxOEFtMXNuVUxO?=
 =?utf-8?B?ekI4MGZ2L2xjNmlEZVhPM0l5eVpYQXNKN1l4RDd4WFdhUFFIdkZBUnBpYVJq?=
 =?utf-8?B?R3Bmb0d0RGxCRldZa0h2VzlXcytjY1VNTjlFcS9iekRnc3plTUh5ZlVuQm1J?=
 =?utf-8?Q?KvPekGFRjFoiIUEfNZa6tJGpC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4963d07-be88-4d77-aa4e-08dda49f1f21
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 02:09:09.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7BXHa758fZuHo4FyrqfqlKbx/fmpU8mFP2wBRnvFL7Fs7heK2Cski697ngO/6Ka+A9lFiG96Hhf2Eu7cKZUSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125



On 2/6/25 23:18, Jason Gunthorpe wrote:
> On Thu, May 15, 2025 at 10:47:20PM -0700, Dan Williams wrote:
>> +static struct class *tsm_class;
>> +static struct tsm_core_dev {
>> +	struct device dev;
>> +} *tsm_core;
> 
> This is gross, do we really need to have a global?

Sure we do not, such pointer happily lives in the CCP driver in my case.


-- 
Alexey


