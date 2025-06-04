Return-Path: <linux-pci+bounces-28929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB3CACD51B
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 03:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0413A4513
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 01:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC832AE74;
	Wed,  4 Jun 2025 01:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n8NDP6FX"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BBB661
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749001650; cv=fail; b=RswE65CsYc5UsO5sa7Q8ERnAqpe9qfhLGVLsEJXmrxaNJbdykeg/ZrpCB6xMnXL0NwOiP3XERz8kKPh5x5uTGjbnpP4HDbBCA/7cCZhr2F3gID990CLh7SjtZnraXucW5D9aYZpivA/ncQ3n1hu9sQeSHWkzepUN52p/xM3p+d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749001650; c=relaxed/simple;
	bh=e+FxEjalKR2csSCu8oOhTJIXEdfa4N3BBvvR3u2WoJ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UkLULH3wah7I+V4bVofx7hJu8JlM50ICKLKhjjUSQCSYkDGMCP4nqopOEYpe7qXzVjXsSC3Dkcu4cA4FrGPmAIgUUUSmIkqvT4uT5RmwDOleS1oTlZkiTkacMugaiCsJsiJHyoBiyuSy6KHV2Sex2fYK7OeYeRHhu0dgi2CC448=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n8NDP6FX; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ3++BtOeVQGEpOJfFBIYkYw3Y2fZR0zcWQVzpqBUzwK7VJtZFX/L2o4aovvDx/LVsfhLk2uN3JJktHCzDyOahDOduStKQa5fqOJLYODrqxQKzSaXvM2vBPuSb3inruIRp2r4r+7o+WAdCjH1oV2oLS6WGL3gmpiWr6vXSLGDC11DrdrBQPwlx8vYwszSsyXLq0xhj9308iQf+Jk9VPUu7awFr1rJRfn/b1/6GaktursOdvyv6RJYDEOwoZU9BPILWvUmYeEvWAZOt09a7H1/7J0n+AmaoPEeZ3eniWj04p3peyW8X+6iaJl7P9kV6OUJ6Cms1vxlyt14NWRnfc+lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWZ+AQEd8jpV1ZGPIancf69dpAmPwXUUtJQKMCZEmpM=;
 b=Kyz8S3cJppqfMuU6Jr59/7UghfdwonAl4RS+kTkJkS3HjrbLg/CU17IgbIJOMwDjtA1lac+C/xn/2Vk/aPttDr0cbObgHoGnBlqTQkHLb0HyjKmPYh8morzdpUSUxHagpePC3qu75DXKKk4nDyN/Q0M7qmghZ+pcKUtPjOG40/yqOKzfcJglkiJf922guyrAIPZDhT3nS8y0adY4SSPoLs/sqogXIQM659Z39hZCJ9SqYK1Jr1K1onWELpTzRwK09QOwTdo1W43uEy4eRyQkXEsiH/doBGAliHBTBUKYR0z+C3xERS+j0EsPK67IGicEjqDBDVcMDKMyZonTobSOog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWZ+AQEd8jpV1ZGPIancf69dpAmPwXUUtJQKMCZEmpM=;
 b=n8NDP6FXMpK1DENEBmzLGIEH9HhGPP5IDK72z+VO0FIZlKKNcEp1V6oJqrDw1V7uumBrXb0CaarIL6kbbyuccHal0q+JVb/ZVX8cmnbstL6vj8nQ8GXOL2QNKMsqhz6gP8WuLhqdnvy/7TM1xQ11BMRk81sQl3SKApoL9MKFFmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 01:47:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 01:47:21 +0000
Message-ID: <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
Date: Wed, 4 Jun 2025 11:47:14 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
 <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0073.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:203::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f612ba9-b8ee-4dd1-e591-08dda309beee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVNaazRucTM2Zm5YZlJDbGREUlZpVmpiU1hZTnVUQW5QbDVwTXIwRlRKQUtV?=
 =?utf-8?B?L3dnUy85WDJWOXI0QXlhS1pDRzBtb1M1MTE2NEJ5Mld2M3k4RDd5VlRscHps?=
 =?utf-8?B?Ry9IcWdRSzY0Z0ZCcm1teDFMQTN1ODg1YzJNVVcwOFpBTm5oMkhKZFc3TkVP?=
 =?utf-8?B?MStYVklOUUlFTndUNCtDa1dCZ0QzZjBSa293UVN5elRkK2l5dlZzMjZvbWdi?=
 =?utf-8?B?dEdmSTl3MVpYU09GMmdOM1cxd2FmTUN5MzZHTXNSMzVPdzRGSXV6OTZVWmtJ?=
 =?utf-8?B?Z2I4d1BtS3BwNk1zanoyUGxTa3VpZnpjWFJvQlhjM3hxcXl0SE9TbFRNZnhG?=
 =?utf-8?B?cWtwYVI5eGtXTVFqTklUdkVXMnA2bXNCN21lNlVjMWdDMzRzTzRGekM1TFlV?=
 =?utf-8?B?dTVWTGVEaXdzRjN2Q3V2K0ZENFpCQ0hvYkU1Wk4wUGlmUzRkUlJnWFNUbTdX?=
 =?utf-8?B?R0Q4M3RNUjBmL2RwdGNud1g1MjMrS1lxMkdvRDJOYkMvWlRrUVRCa2xIU2xt?=
 =?utf-8?B?b3g2eTVQa0Fld1d5cnlmR1dUWWNVNjhYaVNjKyt5S2N0U0prTXkyYUlIZXZJ?=
 =?utf-8?B?aVRKK0RUeE9zNG1EaXdqQzFaOHh0aDNEa1ZOcm5sUHc0QTNzUnRoVUJueWRu?=
 =?utf-8?B?YmljaW56YXU3S1J6aXhtSjRUQ3V0V3NEMllsbDU2WUF5VGd1VlNQMWkrdndo?=
 =?utf-8?B?TGNoNFdPVEFDQ0xpUWg1V3NQYlhLbmIzcG9CRlBBNW52Q3J5NGx1T0d3UkpB?=
 =?utf-8?B?NWwyaTNXelJDazVWcU5icFlTQzBta3hBYnhmcHcxWkRoZVJJa3RUdXpUUytq?=
 =?utf-8?B?aXJ1UWlpTW9kZDloRTBxaVdRV2gxVjZWeGRRRjRmNVkwMGM0YWdyczlPMWRU?=
 =?utf-8?B?TWorc3BuejlNc29HelFBTjBpTWtvYmpWUHNrdkxSMTRDbUNhZklOMHVMUTRF?=
 =?utf-8?B?L3h0dTV5UXlTYnBnejM3djd5MlBDWXVMcTF4d1Rrcy80WExYR21KcGgzN3Bt?=
 =?utf-8?B?cXUyak5HNHJ3aS9zckNlQnhyWVpzYjlrS2ZVYXdyZkRjeUFPV1grUkxWaDZB?=
 =?utf-8?B?SlhNWG1ZekIwU2ZmNGdRRmIwSThQMzlMZzFwT1RQQ1VscDRrR1drTUlrM3Vs?=
 =?utf-8?B?dVNoZjJBZ250b1BISnhsUjhqRkF2YXJCNFVRcWUvY3FlRlp1QzM4QXRnVlVC?=
 =?utf-8?B?UEFvTWpBejNuZ0VnV0x3R1N3VUFxdmQrTkR3MHdTbk1oeGdVNjdkam1sekxk?=
 =?utf-8?B?V2JIQWYrTEtRcGkreUhjT1hSVmxjQ2ZkR2RJaEMyNC96UUdsOFl3V280YXVI?=
 =?utf-8?B?NDhreVVVdU5oWlVDYVU0cnZiVjQ3WUFwbS9YTUFvM1ZWWlFmRDI4MUNFaGJQ?=
 =?utf-8?B?RXgrU05jZ241amE5REIrVGNOWm9iOU85a0JIdk9PbVhhOUdnaVh2VzU3RnRq?=
 =?utf-8?B?WXNUV3d6amNJdVYvYXNnRXNmYzA1QjVjZGJra2VoYi9oeEtYeWVZa29Vd1Zx?=
 =?utf-8?B?aCtabFpOR1ZiVkx2NmpUSkt6aEJrUWxqa2JGaXZtNFVYL05Vc3pYblptSnNP?=
 =?utf-8?B?Kzc2RWpRQlpUVXNqRVpwRGxRbFBvSFV5OUNnVjBMZ2JVWVVOR2ErcGVNRld1?=
 =?utf-8?B?eXY0Qms0SjJDa0NoYzNCV1htaUlIT2xWN3lXL3lTcUFhc0RBLzF3UjVSblNC?=
 =?utf-8?B?RENBeTN6NFExQ2xZYVdjUi9HUVovVmsxZG9MN2g4RGxMb2ovUU5jSTVhTlVL?=
 =?utf-8?B?YmNPVkVNOHVvRGJvWU1KUzl5TGJML3p2NnphTGRXaXB3UmduTTBOOW56NTM0?=
 =?utf-8?B?bzJlc0c3Z28yMHM1UkZldTZFajk1REpuajZSQWUvcDErNnRFVjY4aG9XMWxz?=
 =?utf-8?B?VUlOcE41U3E1R3JQSEkzSEtOV1F6TzZSYzRmWU9RMFRoSWRhRGUzODErVWts?=
 =?utf-8?Q?ZUmq5fS+SKs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZ4T0pJU3pUVXhLNlROY0V0RzNNWVZ3OHN6WTZaVGYvVVFJTTRaMmpaUjlY?=
 =?utf-8?B?Sm9ZY1FKZFVkUmFZVFZ0Ymh4RWNuekxJRnlBSFV3VzJ6TUZiczNyYUdrL1kw?=
 =?utf-8?B?N3psWlRPLzgwbGQremR5dmFhdzJOemhpYlZmMmFZczVyTkxwcWpEMnhIZzJy?=
 =?utf-8?B?OXI1N0RjSVFNdjNZa1Z3b0VJRXFTaU5XdHg0aVpPUmlWWUIvUXlFamtEbEJL?=
 =?utf-8?B?ZUlJMmtIcFhTWlNUSS82TWEvVXp4b052Vm45ejRuUTdkM2YvZEp6ODRYZ0RB?=
 =?utf-8?B?WEZLL1l5bjF0YnlzbjVrRkg2ZkVKcEFjZEw1c21FUEt3Q2xNeTliVGV4cEFr?=
 =?utf-8?B?Y2dwQW9HSXhheTJQazN0L2lKZVp4UnduQVhFeHQzYzFHTFBobGlTMFBIM09Q?=
 =?utf-8?B?Ym8xZ09xNlBRUXlPU29sM25wSDQ0a2hUUjV1VVA0b2JLN3c1MWZQSUxUT2VP?=
 =?utf-8?B?czFFNnNVNnpxYmxoWWxERlgvd0hVMHhQalpYS3Qxa1FtdzBpU0U5WUR4bEJK?=
 =?utf-8?B?NEY3SVp2SWVsb1ZYbXMvUWl0dHdELzUwQTBVZDdlRXQ5RlBaT1Nvb1hnR1I1?=
 =?utf-8?B?WmFlKzVVREQya0tzN2pBaGY2MndsT2JnamQrQndJNFd3b08rY3JhNjBieFZv?=
 =?utf-8?B?OS9DYlFKSjFvM3NHaXdBMmEyVGNURkVwWnphR2VjRTA1aGJYNzBveGhpYWQ3?=
 =?utf-8?B?QWZib3JtQ3JLOWJSZ3VnSldSNlZRbVlQVXFDWkt0MVY3bHVxSUEyTDUwc2FD?=
 =?utf-8?B?cWZmSUJEODNRcWJPYkNzZW5UNDRLaVEzQmJWM2F3V2sramJKMVUwM2phVGFk?=
 =?utf-8?B?WE5hK01Qak95ajVBVm1rKzVyMHlkWEN6RVlMYkZXSGVXd013TjFZV252eTRk?=
 =?utf-8?B?VEM2L0hzc01LZzBhREdJcUdNT01BWGlyblNZaWVLNzFiT2RjNksvc3hic0dQ?=
 =?utf-8?B?SUp6RVNPUzFYMzNyeCtTaTlIekphaTZBQ0lLZnlQZ0VnRTVFaVRKZnRGQUo2?=
 =?utf-8?B?S1FxWHVqanBPK25BWlB5TTFsQkFkTGo0UkZBOTFxQmNsTGVQSDJrUXRnS3JN?=
 =?utf-8?B?a3Ryc0p3UktWV25lWTc4RUo1R3lBM29JKzU0TEtaeTRlRHJrbEhzSnVJZXh3?=
 =?utf-8?B?eTk0ZlN6OUlzL2F1S0Z3VWx5Y2ZROElNVjRMR21CdlpveDhQWHNudFlpVHZz?=
 =?utf-8?B?OHNtMFNEVUk2WGljdzRLR0R3ckpYZUo5ZGhWRzh0ZGJBdzJoazd2c3RNdTNq?=
 =?utf-8?B?bEI2bUxRVE92VGo0UVJEOXhHdXNnbHdZQVBuWkNiMk5iUWNnTVUxN0hIaUE3?=
 =?utf-8?B?UGM0S3JXQTR5bVZYSWkyRWJ0bWVNL2lSazNHZDZOcHJsL1YzdEpTTGQ2RW1j?=
 =?utf-8?B?Rm1UNUkzR3NYTUI2MjVZRW9MK1NDNWZnVWlGMEs4NHMwVzZTKzFkdjRRRy9U?=
 =?utf-8?B?c04rMS9GdXQ0S01TdWhZYTBLdktCcG9BWTZaT0pyU0I1YWVtR1VyVTFkQmRx?=
 =?utf-8?B?b2YveGJ0QWc3NHcwd2NHamE3VGlTanBIdzJkZzVXdEFKeC84VGI3KzRCcVJC?=
 =?utf-8?B?M1hnUG40cUIvb0tuRGRucklSa0tKNnZZWk40QXJNZVpxOWJXaG81NGpVQWE5?=
 =?utf-8?B?UUUyQmZPZk9BQ0hEZEl0R2VXa0pua2hHUE02bmpOQnZPVjM5Y3NEcmtDaHB6?=
 =?utf-8?B?YzBNY2pzQkgrOHBtTnVmTjVpU2NUZGJZdmdoSVRpbFJERTdGMTNVREk0WmF0?=
 =?utf-8?B?Q1BPaHlydDY1azZ4NlpKVHpzaFlQUGFlTUppOVN6Zmg0VDNqMlljZEFWWXdl?=
 =?utf-8?B?cTUzS3A3SDcwSUtiaGZFSnJjS2VTNVIxVHV6VTg4OWpiRGNxQ0JURmlLcHo0?=
 =?utf-8?B?YlZpSjJsOHRrWWFUdmN1RnBSVThLYS92cGVvRWwzQmM3VjcrK1dHSUViZWxM?=
 =?utf-8?B?VVVGMjRuYldLaksxcTVuVGoxZTViampiS2R0TzlOeUlPY3lTREZaNmY4Rm15?=
 =?utf-8?B?TENGV20vTFFsZTltMjZuZzRybkFZVDJybjh4UlZKYi9RRm1UYzBrbk5zWjBR?=
 =?utf-8?B?MHJyNTZ3RmlnZndUVkdNTW51NG5DdWk3KzF0OXRLTUJvWE5XVTkvMDJ1MDN6?=
 =?utf-8?Q?wbpVZZgoNfDpSbzs9I57F3Cww?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f612ba9-b8ee-4dd1-e591-08dda309beee
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 01:47:21.4351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JnpWjvXP8Q+EjPP1R8H44zdjJ7HO8MrSBFXuo5VyiGgGNFOq1A0koxjyxXOXugpikLRwoo99JybNilvotGAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508



On 3/6/25 03:17, Xu Yilun wrote:
> On Mon, Jun 02, 2025 at 02:52:52PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 1/6/25 02:25, Xu Yilun wrote:
>>>> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
>>>> + * @size: sizeof(struct iommu_vdevice_id)
>>>> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
>>>> + */
>>>> +struct iommu_vdevice_id {
>>>> +	__u32 size;
>>>> +	__u32 vdevice_id;
>>>> +} __packed;
>>>> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
>>>> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
>>>
>>> Hello, I see you are talking about the detailed implementation. But
>>> could we firstly address the confusing whether this TSM Bind/Unbind
>>> should be a VFIO uAPI or IOMMUFD uAPI?
>>>
>>> In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
>>> behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
>>
>>
>> What will the host VFIO-PCI driver do differently? I only remember "stop mmaping to the userspace", is that all?
> 
> And do unbind before zapping MMIO.

>> Or, more to the point, what is that exact thing which cannot be done from QEMU? Thanks,
> 
> But kernel don't want incorrect userspace calls crash kernel, e.g. VFIO
> zaps MMIO on TDI bound then KVM just crashes. So you need to check if
> zapping MMIOs are allowed in VFIO, that means VFIO still needs to know
> if device is bound.  Scatter BIND/UNBIND & other device controls in both
> IOMMUFD & VFIO makes life harder.

I am confused. What is that userspace call, ioctl(VFIO_DEVICE_RESET)? The userspace (==QEMU) knows it is bound and can unbind first, no?

If it is the case of killing QEMU - then there is no usespace and then it is a matter of what fd is closed first - VFIO-PCI or IOMMUFD, we could teach IOMMUFD to hold an VFIO-PCI fd to guarantee the order. Thanks,



> 
> Thanks,
> Yilun

-- 
Alexey


