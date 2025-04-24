Return-Path: <linux-pci+bounces-26699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D79CA9B2F9
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7141BA139B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FA2820A4;
	Thu, 24 Apr 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2S0kpaYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E989E27A926;
	Thu, 24 Apr 2025 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509800; cv=fail; b=YZxUBeVIjedJnR1nDekEh7E4AMuIcEFROewQxAllbC54ZbFHzZD84kk6aEsZKIV4YShPdd9+oE3dW5OHOZ/wcN0iSsKY1iWNwOGxInSJqfYUk18u3oQ6cKhtYFvu/11DtiAT4TvpUAOXvwOELWmmONQ7EQ6Is3Ghl5OdSbQGIac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509800; c=relaxed/simple;
	bh=7SdxM5TxCvhSzhpX2bWozIKMnYXiylh1go+W2XYd9FU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmUuliRSyk5kHkEgrjShPx73s1XMMy4zv2D8oDs5wVTUoiFgls7cK1TGdFWuD+JnmxC15/fWvGeldhqrIKjejJ9nCZjrCZE3XyooH/xyK/l6GlV0aN630yLctZVr71Br2GhiD7Qv09naCROyorVDVuHnA3SlHwzetnH65+3HHIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2S0kpaYu; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMAcqCSKGYlijkMc3v97Wfdk3DGGQb1QnzkmjWFzZRFEtgXqhDxAsGsIl1qo6aEXHotTMpC53gKCr+XZtgJsBjy/EpLxUMjS0lXY5Y3zrW9pvMKmXhjKnjKEUKXDrQMBje4msNXw59Dh814FF+Sj5dkf2Wq1qcoL3dJgnKZZQ04kodDah3g5QIrLsmi7d7TOuRaoUtIKag/ZgCu3zdORpVvzKOvxQkQ0+CcVCjWa5gJset5DBN4I34mAq7GG9499uTM/hV+Drpo8hvFhXE3I2KzNNWyL+ice/WPo9C8H+6WFSwkab+Vsp3uLSy2Jfi51WHfLFXbElR1Twy58WNwwlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzR2LnSKoIgtYTFepTwiqnUg4d3BD0KXaVhU5rB9rBI=;
 b=S9ZVtEYs6HHPJUMfvnSOOZ8DEUuT5ekrxgmaz2JjCwnfGCZ1TCA+Yb4w0SAx5d/XSaHPpcN729t86lRgy61UROzi11AGNqbRLV7hiQLVHx2/DpjqyVmIn8KPOPzvlHUhwpphgW4SsGDsUp86UN7Hp7CEmKbVcW5C/18D/hH5hJA5xynWfJnZQcmxMLyKJnGwgNwfDLwrqr6UKLazgC7rJXViIKM1SSXDVsBfFii0mLv33waeulUCOV8ca/iJoV+EK48HF/lTw8WkhokgYK9GH4ELjwtsWBiJDhzZc6AwRJbmbIrv2DPhraF2IjqRDjPKoktudvd6xBRGqSc92mk85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzR2LnSKoIgtYTFepTwiqnUg4d3BD0KXaVhU5rB9rBI=;
 b=2S0kpaYubw+EBpfpGBwSnyCTw3Ty0AW69lnEL5wEr7/SswmABQhiM2GWW07DTVqu0DuxPKEc7jqOGkGVzVPm3aWUwrq/SOPP428YADMhKQv4fB2RrJS7Q3weGh6Mf6Jpd+uWIrreccjO+Xb6/ceVZFaxtehJr+IKzphOoGDoJaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY1PR12MB9603.namprd12.prod.outlook.com (2603:10b6:930:108::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Thu, 24 Apr 2025 15:49:56 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 15:49:55 +0000
Message-ID: <25d0dbf9-2ed0-4d8a-befd-b954adf095b7@amd.com>
Date: Thu, 24 Apr 2025 21:19:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without PASID
 capability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Tushar Dave <tdave@nvidia.com>,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
References: <20250424020626.945829-1-tdave@nvidia.com>
 <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
 <8ef5da0e-f857-43a0-8cdf-b69f52b4b93a@amd.com>
 <20250424123156.GO1648741@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250424123156.GO1648741@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0109.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2ad::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY1PR12MB9603:EE_
X-MS-Office365-Filtering-Correlation-Id: 957a84ef-e05e-44ed-7efd-08dd8347a8b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ti9ML3g3YVdoQ3k0dkpwc0tYK3BwYzAxTWpmRC9ZUjZrUEw4YUw3Zys5WTNK?=
 =?utf-8?B?VWJaRks5OGtLMlhQUTE0YmZVUWdvVjd5dmordUJtTnR2Q3V4YVNrVGZKVHda?=
 =?utf-8?B?dTFIem43UVlUZUtNU0hjWEorblFNdldoczF5VGZ0bmlQamZCZnRnMGFtRC9X?=
 =?utf-8?B?TVhycTBrcm9XSXpCSUZWeHN5RE00dlpZMEtHUk1WTjV4clo5eDJ0Y2lmWHpi?=
 =?utf-8?B?NGFnZDVVNUl1a0xPY2NOUSs2TFRyUUZzbnByaiszQ1k3eDRFUk9XMGVrZHZ4?=
 =?utf-8?B?bmI3UkJJbHJ0WER6WG9OL1lDdmdSNktpWi9vUyt3YWY0Y2JzeWlkN1ZVdldm?=
 =?utf-8?B?SUFnSk9Bd1ppU3BYM2Myb2dqRWMvWGxVWGFORlA4YzBTekdSZTQ1bWt3a3Vl?=
 =?utf-8?B?M1ptT3VpbjVMU1FNUDNtSVpENWtYbno1SUZLc2hncXd6bHZmUnVVT3BtTkpr?=
 =?utf-8?B?Mng3czlFTjJMNXRKdVNFQXZUcU01QzFqRVBuZklZYjFKdHVnVUc1UEZQcXVM?=
 =?utf-8?B?amQwSTZYd21sVnlkYzlUYkp4TkRSZm03RytEeHllR2hpbzBoTDAzazZnUXRs?=
 =?utf-8?B?dEVBWjltRnRPY2NjZnNoR0RKUXJ6WFAyYVFwTXZRT09NaXRvejNmVUc5VVFz?=
 =?utf-8?B?VVlIMGtTTjhabUo4clBFN3p4WURMOXRCdXNRZkdxelVuaU1PWlJZYkFOZkY2?=
 =?utf-8?B?SUNYV01Lb0d2SGRHR1Jya1F2bG5BeitlcWhBUUI3QzUxM25MT01yb0tNSkJD?=
 =?utf-8?B?dVRVejltdUhMazZHNUIwNWdzZDlkWDMvOEFSaE93bEgyMURTZm5WTU0rTWNl?=
 =?utf-8?B?bFJ6YUpXMk9Qb29BYXRsVmtvTXNqQjhBdUdGZExkTW5YQ1EydFl5aEh4SkVq?=
 =?utf-8?B?K3J2UmJPZ1UrcytMWm0vWkwzQTRWTjY1THpRaXFRTGFIS2NBSy83YU1XaC9N?=
 =?utf-8?B?SkFQWjkzcHZINUpLcHhRRFo4SHVnUTZhT0R0SC9CWkZEMGUrNnlaMnZkbTZr?=
 =?utf-8?B?RFRpVC9XTExUZ3dzL1NiZ3Z4N2lodW9wOURZMjE4NmJ2N2I5aC9KUTR1MERv?=
 =?utf-8?B?VTIyTThXb2VjcjNjb3QwVE5GbUdYamtncm1PRHd3VzVDQ1NGRjVOcVRycS9E?=
 =?utf-8?B?ZHEzMS9KVmhrUFNFZzVBT1EwenIzcHhBSkoyc3RubmZncFpCSE1BdVV6NXRq?=
 =?utf-8?B?cW1mVFpYWVRQVHMySDcvZGlDM0hHUlV3M2RwZFliNjdUQVFuc2d0UlFkc3FP?=
 =?utf-8?B?eXFMejFBZXQ0MzFsVmF0N2Jhb09jSE05ZDZGMUhOQzhlTUwrVytONmpGTFJo?=
 =?utf-8?B?ZU5DUm84eEttWVFSM1oyeHNCSFhZa28rcytoUVpTRmNOSzhOemdXclB1MEtm?=
 =?utf-8?B?VklJZTNDY2xXQmRCdkFnUWNrQm9SaVk4SGprTHVVUDVTdm15QndPQTVRUlpY?=
 =?utf-8?B?T0QyRld0YUlCeTJYWmdIbzBMcnlVdEpDQnA2ZSt2K3F5VG42R3NXTnRUR0Z5?=
 =?utf-8?B?ZjZLekZHTmZ0Tk5YMW1pdlRLb2xhMW5zamZOWmE0b2JBZUs1MDZhNUNjQmkr?=
 =?utf-8?B?WkF6elJlQXFiaGFBNHU2N1Zqa042T1lIQlp4QTZIR0k4Z2Z5WWc3QlR6a0J6?=
 =?utf-8?B?SSs1MXNOWFU2b2JwSjZVemZqU2FsZkFVaTQ4eWt6UkhNSm1TSHFqRlJBNGR0?=
 =?utf-8?B?VHBhVzhESkptNFlPcFBZVHlodVZUeC9MaTNMM0krYmp5QlI1M3dsMjVMNEZ4?=
 =?utf-8?B?VkVEdmlnNDVWcVptY3R1bkpFSWl0cE4xMS9ZMWpGcUw4RXdVTTB3eVJEYjFk?=
 =?utf-8?B?NC9MU3NXcDllbWhoWFk5L2R2dnJvY3h4TmFrNEVGT0FkV3IxQ2RzV2NaTHA1?=
 =?utf-8?B?cVdYbTIyWFZxdkkyMXR0QjdDb3lKSHU2Rm52YitsTENLdy9wZm9qOHVYWE00?=
 =?utf-8?Q?qd76cCLaE8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZsaDZ0djJxWkx3UExUK29hQW0wejhjRHpCQWhPQ0ZmWDJ4VW9uSzQzK0Vw?=
 =?utf-8?B?L2lDNlZjYTlQMlZVaFdMUzkzUnRMK0ZxWHdCcFhCZ2pyS3hKaTF5Yjd0NmtB?=
 =?utf-8?B?WXRSYUM0MFdMTWNISDl5T2NOQ1JyYlFEMHkwZ2l1TUZlN2NQZWtlSjR3K1hJ?=
 =?utf-8?B?Zys0M0ZBYkVKSzlmbUxhbkpnb1JHeDAyM1NVTDBlVVBRWUx6NXhZemFFdGhm?=
 =?utf-8?B?aVUxREZpeVEwdHFUNDFOTGx2OUZhL2picy96VUxWT1VUNnhndkVhUjRTNndM?=
 =?utf-8?B?cHNaLzVwRUpKOEJxSHZuN29kMkhDcEpWdHZSM0Y2SzVBb2lHVWxCWlJIb1NV?=
 =?utf-8?B?eVNhSVM3RGt1amFXQ0xiUFowazlNSTNLQ1hTTUhPV1NFRHpoOG11cHFoQytK?=
 =?utf-8?B?SHdiTkJPVzV4UDVxeTgweW5pRzk2bXpIcHBaUnAyeXcwOG52OU1YVnpVNytn?=
 =?utf-8?B?VVJucjBYM2F4Mi9TdkswdVhSSWYvMFdlbUJ1VGh1QWZvOUIrMHFuZ2NKU2xG?=
 =?utf-8?B?Q2sxbkZ4OUVucWZidm5UNmJ4dnBqdEhvSDg1dVZYOG9DczF4TjU0ZUkxSEJQ?=
 =?utf-8?B?Mk55MFFhcEUvRnkwWkZGaE40TEVxR042SlNtOE5QaDVIY0hpQmp0MVZnU3lC?=
 =?utf-8?B?NzJUK2JodExySWczeGoxdmlNVE1DTWZNRlVFV1FsMHJMdEY4Lzl1TTdKa1ZF?=
 =?utf-8?B?MEszcUdrcHZMS2pOM25ScXZkRjE0RkRzM0RselVjb0lZdmNqSGtqUGkvNS9i?=
 =?utf-8?B?d3hoci9RUUo0VGs4Vm5VS2FqK1JNdm0yaWhBbGhpQ1Z1RHZpNHVaWW5EVktt?=
 =?utf-8?B?SS9wUlZSWDEwRzNOUkkwOVl2cXQ1QnpqbkFQQ1Z1KzlUYzQ5TWVVQjhCa0Js?=
 =?utf-8?B?MmxtYWJ6RHpGZXFOR1ltS3dMQU9NY3V5M2tRcG4zNlQzTW9pd21naUc2WlZT?=
 =?utf-8?B?MnRlcFRpQnRtR2tpNXBrNkt1SkovcEpkbTNGQlZIOTNNMXF4enVVVUV6aE9E?=
 =?utf-8?B?MzVPek9ILy9MS1hKUTY2UFZMb25LWnFXR0E1OWNCNzBVbUhLM3hEeW9YUG0r?=
 =?utf-8?B?dEM0ZEplZzNlTXJyYzJ4ZHdBWG5aVGNFZTRxQzk4eG81c1ZFNDdyaGU0M0VX?=
 =?utf-8?B?OWRFTVVBb1c3bWhST3RlZWFpdEx4VnJFbjN4TnZsUkNWRE1RVE1sc0ZKRXVC?=
 =?utf-8?B?T055dTZOV0xqT01GZE5tUXFPVVpMSmQzeGNOSlJINzBKbEFINFhOWkFUSHJP?=
 =?utf-8?B?M2FsNnV5eVd5ZHlFWmpMNnpVUDZ2Z3JoNng5aVFqTzkwdkJ2NzFzblB0ZWtN?=
 =?utf-8?B?L1F1T3VtUTUyNVpVQzRaMGVTVytPdTRBVnExcWpBaGwweWE1L2lPLzJMSkNm?=
 =?utf-8?B?K0EwYnRGeVkrZndFMU9tMTRHU2VUbXM4VWhOTHJYSVFHNTg2L0RBa3dYN1pp?=
 =?utf-8?B?M0UzeFpsVFBlb1VNSzNUWTNaV0pDbWl1TU9lbnNuL244UUlqTnlvZXVmT1FT?=
 =?utf-8?B?YWg1OE5EWXhwdlhNS0JIMjRZbmdXd2dSZFZqcUVCTmNBQ0VXSXZwWkhMZkZK?=
 =?utf-8?B?V0gvdGFLTEJWVEVJdExoN1FvdjIzQU43THVvZVZVd1lVQ0VLcm1JUU9Bd1Nz?=
 =?utf-8?B?enJWVngzTmRQN0dMYW9hTU5QMlM3T3VuTGY5eXZjOXpLQjloQ3R0Rmtrdmpj?=
 =?utf-8?B?QXVJWkpqa1diYlpoUUVrVFlzZGpiMnVhemxiRjB2WkRSTkl1NmxRaUxKc25I?=
 =?utf-8?B?ZFl1bDkvNUFkbFZTRVAweENuWjMwNERhSEk3MjVyZ0p4Y0w5NFh3dUdTQ1BH?=
 =?utf-8?B?d3NCN3Fvc1FscGdEYXZGWEF2dmZKOWhrUTJWQ3J4VVRSK3lhWUI4T0JLRGZB?=
 =?utf-8?B?NDBBWHo4Ty9UcWQ1dC9HeWtETGVmdnI0UHB4K1A5aUVJaEN1eU5ZZ1JFK0VN?=
 =?utf-8?B?ZFVmandYQlhtRGhoSFcxOG1KaGhTRDR1ZjBuNFo2SGRqL3I3WnQwaFZMYVBx?=
 =?utf-8?B?OU1Bam9UeXF4QU1YdUc0aFdJdWJtcUtJVGo2ZlF2V2REaG96TUVpeHRhV3Jv?=
 =?utf-8?B?MTJQRHA0d0lzSVU4M09iV3JVbE1hcGcrL0trUXVnamVQOVlPM1NNTXdJUlNi?=
 =?utf-8?Q?TfBd10QCi8xR3EzjU5LXK+xMQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957a84ef-e05e-44ed-7efd-08dd8347a8b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:49:55.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: werNoh8HS5zVutNCFoIZvzJU7lWTuXRvPymLFR5elU4qpSI+g52/QtgW6zZHW2mYB6FQWQJa2Skmxm7WvR+IuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9603

Jason,


On 4/24/2025 6:01 PM, Jason Gunthorpe wrote:
> On Thu, Apr 24, 2025 at 12:08:56PM +0530, Vasant Hegde wrote:
> 
>>> What the iommu driver should do when set_dev_pasid is called for a non-
>>> PASID device?
> 
> That's a good point, maybe the core code should filter that out based
> on max_pasids? I think we do run into trouble here because the drivers
> are allocating PASID table space based on max_pasids so the non-pasid
> device should fail to add the pasid. Tushar, you should have hit this
> in your testing???
> 
> We also have a problem setting up the default domain - it won't
> compute IOMMU_HWPT_ALLOC_PASID properly across the group. If the
> no-pasid device probes first then PASID will be broken on the group.
> 
> Tushar isn't hitting this because ARM always uses a PASID compatible
> domain today, but it will not work on AMD.
> 
> That's a huge pain to deal with :\

Agree. That will complicate things.

Just to be clear, I gave some of the AMD GPU as an example of group where we
have both PASID, non-PASID devices in same group. But currently AMDGPU is not
using PASID. But currently I am not looking for supporting SVA for amdgpu with
such configs.


> 
>> Per device max_pasids check should cover that right?
> 
> The driver shouldn't be doing this though, if the driver is told to
> make a pasid then it should make a pasid.. The driver can fail
> attaching a pasid to a device that is over the device's max_pasid.
> 
>> FYI. One example of such device is some of the AMD GPUs which has
>> both VGA and audio in same group. while VGA supports PASID, audio is
>> not. This used to work fine when we had AMD IOMMU PASID specific
>> driver. GPUs stopped using PASIDs in upstream kernel. So I didn't
>> look into this part in details.
> 
> Uhhh.. That sounds like a worse problem, the only way you should end
> up with same group is if the ACS flags are missing on the GPU so Linux
> assumes the VGA and audio can loopback to each other internally.
> 
> That should completely block PASID support on the GPU side due the
> wrong routing. We can't have a hole in the PASID address space where
> the audio BAR is.
> 
> I suppose the HW doesn't actually behave this way but since it doesn't
> have the right ACS flags the SW doesn't know? Guessing..

Honestly I have no idea. Since they had stopped using PASID support I never
digged into the details!

-Vasant


