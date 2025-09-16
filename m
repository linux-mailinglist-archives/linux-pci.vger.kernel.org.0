Return-Path: <linux-pci+bounces-36217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F9B588F5
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 02:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A011B25B7A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2757179A3;
	Tue, 16 Sep 2025 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QYvZa+zf"
X-Original-To: linux-pci@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCD41096F
	for <linux-pci@vger.kernel.org>; Tue, 16 Sep 2025 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981665; cv=fail; b=h878TfdFaOPl+d1mJU4+e/x2uFQcnI6rhygSECISpXmRzJyoGN6vGMWJdrQS8oCstxXPpHy/HEN4dyoJLYXLGIimdW3UjFkzb70msVpdHbQh+0vErt/E9RXt58BPIJi9gKTxZzdtyCxjRaAhxuhc8HhKsgnwUdUCb9pJht8DU3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981665; c=relaxed/simple;
	bh=NiVmgJ+HbYiK3HVKsMC6HoB7Kg9Sxp0gsT6vtIUwTPI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NwCXaY5zHBhYR/ILx1SAw4ZYOwT7pbj5nmYSTULmufCMvpyMbhoggFGomB99jeXwR6wN1miLto27HCGzXzwQAjwQGRUF9KWm2farLH1CdQt7ZZxCBFcVo5wedZ5dhXQWLtUj/yxnVcmFmW6cIHwluUNUEK+X+N+KYxCXNgoGC4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QYvZa+zf; arc=fail smtp.client-ip=52.101.85.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lelAWiLi8aedPoK78prlhD5Xhx0jm5LWnFMaY2LUNbilHF50htpqU1QELCIDsNQGH0Z3D0xLXPqeswqUqf5zTXJtWWaj8S+s3qE31crIZqKuFiMP4Cow+rv+J2Wjzi/tSKic3jG2dqppdoPhScepjZJbMKDMkSz9DoDxVXeh24Vojdk9198JTuWbvnzdSFKt4mT9XPnC6l7IRPwAf7kq8sBWuiO4eG46pRixhKt1VLzP/HZdkboN42t9JPbHgNEaGKZq99+LYcKbPQ6S/9JmW6tclbvxVR177ONjK1Vr0jI0xwydrBrXUrejXy8CYDEvWyDO4pXFLPrDclyd8e+1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqhxdvAGkosA9Gh/QmYbR0zRNL4XxqIA4jBDZf1nQpI=;
 b=jO5eIuo8CRRxXbfFF1BhWUVXASUYHcShovlxItqlegUoG7qnglJ2kUf/u2E6tyDrXjVCxDBK7JDx5b9EAxIQN8eqoDYR7ez11bYgaLe8y3qbZwpFQn8OZBKWN9poSd+oLoemRrgOGZqGY92C3huIwyqBifgaIOJSbiXh0qRNdh0XyVk+rviOKqTv4YsJH7tICA6dzjzGzEj043UTpMMidsYbXJKB8RmtPYTFxqfQCiqjfd2Plv3p17vcSVfcc8jtASuiaSe9ArYE7oqYSsHtVRKZrTd8XXxHoKmjclq+cqskuWGoVZdCw8xgjyXkR2mX8paFzWrARaafK/r7RVFTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqhxdvAGkosA9Gh/QmYbR0zRNL4XxqIA4jBDZf1nQpI=;
 b=QYvZa+zf0GWaOFRb1XNwT6o4oAJYe1we/trmSLWp85v1qyP8BF2dNUz/iBNc5HQFXaYPU4o9Kd+RKY0EZPCCOIZWbRfyNiCCBriPxz5fbIHKb0eE7v9cJ8itjlXZ9INur2WUxsSQ+k/mGlYyh0W+eaKnvxdOk3jwosgwZT+4U/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS0PR12MB6631.namprd12.prod.outlook.com (2603:10b6:8:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 16 Sep
 2025 00:14:19 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 00:14:18 +0000
Message-ID: <58386de5-7308-47ca-bedd-6844a1d8cd5f@amd.com>
Date: Tue, 16 Sep 2025 10:14:11 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH resend v6 07/10] PCI/IDE: Add IDE establishment helpers
To: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-8-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250911235647.3248419-8-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS0PR12MB6631:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac5b7d8-b314-41ea-3cf5-08ddf4b5fa55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2l3TWh6dFVZczB5cGRkbk5pUno1aG5wS0E1ZCtHZXJwc3FxNUloLzNPSkYv?=
 =?utf-8?B?SEh4czAzdXBpcysxQjdrSUdlb1E1Zyt0d1c1TW9HVEVxL2Z0Z2ZHeFNVV0pM?=
 =?utf-8?B?azhHTzJTQmRTN3pMS2lEMVVhMHplZEJVRDBBWWl4VmNWQ3F3c2t2NXZlMDRk?=
 =?utf-8?B?UWNzVmdGaDFhbjBvcVdFUVlhQURFMVJ6NE80RmhramhtYXBqbk9NMExYS0VN?=
 =?utf-8?B?M2pNWlZQZUZ6WUNZYjhrUjkvR28zbW1aVnJXaXRzeUFPZy95NnQ1aFgyalll?=
 =?utf-8?B?M1o1a0RXVGY1ZHhQUWpqRUZkcjdWUnNnb2tlUjUvOXlkb20xaDMxcGNSTTlF?=
 =?utf-8?B?U2hkb0FpVEthNlVNVURkdTBwVzlkYmlrUnBwUnVINnI4M0V4d2tQSm56Mlcw?=
 =?utf-8?B?U2oycnZnU2ZqYlNoNmJKSE9pMm00OVNZaEpySmR5RlNxcDQzb1Q3eTRjYzZU?=
 =?utf-8?B?NEo3Q3pTU0tyT25RZkNnV3IvSUp2OHhnS2k5ekF1OUxUUHEvRVljMU1DZlBM?=
 =?utf-8?B?UUFaa0tHYUpmTlZObkVjTXdrU096Zy9nbFNtR011NklPaS9BWW8rSzNTMjRt?=
 =?utf-8?B?akE0UGptMXlicE85TzVRY2Q4VkFLc2piMG5VZlIzNHRDbHZBYmhIR3ZSTExn?=
 =?utf-8?B?VXRLYlpQS0x2Z25HZUQ5SW0xdElROE4yR0dGY1M3TzhuMHdJRnJpVVQ4THk5?=
 =?utf-8?B?dnFkN1crLzA5eWt2NzhHdXlGaVRQY0dwdjlNS1ZmcGF4QjAvUTBKNThCTGRM?=
 =?utf-8?B?OWVULzVCLytYV0xGZW9mbjNBTk1yUkdqczB6dnNyN0ZheVpVNkVTSVZvV0o2?=
 =?utf-8?B?Q1FFdkhqQkNzanhtSEh0ckV2K2wzL0dWSFRWemlhemVkRjlmWXY4N1N6ck1u?=
 =?utf-8?B?aSsra29MUU9WTXQ0NmtLcnF0aUhicnVmUEM5RXAzQ2VSTzhleFlUTm5tQUk2?=
 =?utf-8?B?NndKOGRDU2l5Qk1iYzdXRDhGMlp6KzhLUFJmTmRSODdNM1BTQ1RsaUk5NnQv?=
 =?utf-8?B?MW15bWczN2Q4V1V6RkUvWUE2UzV4RXczT2NmQ3o2eFgyVm03dWt4L3NlM0dl?=
 =?utf-8?B?UTE3SjZLbEZEQzZ6K1JEbHEyY1RmdVBZV1hSYVEzUnMrSkRFMzRKYlNFVXlm?=
 =?utf-8?B?MlJNYkVSUW9POUw4U2xBUUdTSEdtMXlOV2pySS93eGlISW0wbUVzNXFweW9i?=
 =?utf-8?B?NWkxeXdxYkc3SjZtTW9DZno2U1lYNGVpYjI2RTI0d0Q5OUd0UnloQmtTc3dF?=
 =?utf-8?B?SXEzQnozaGphdDNTVnJ0MjdwblRYNFJnSnJsSlFrd1UxRThDbFV6S05yd05h?=
 =?utf-8?B?TEMvKzJ5b1NjbXZrV3AyL3ZuQmRXbjJzd3NTWDVUVWFsVVNjRkMxMnZncDVR?=
 =?utf-8?B?S1NlMGc5VkJYeEFBVUF6SFhIL1Qzek1ZclpBTG80aXVRZCtaZkRiOVVzSWFD?=
 =?utf-8?B?T003M04zbHRtL0d1OXM1NGgwd3B2cGRNTTBmb3RXYThHNnBmMllwWGFyM3Ry?=
 =?utf-8?B?b0pwZWNEaDNxN1loZms0WSttRGpLWExQYXFrelhpSHhCWk1hVkFpL2FNMnIy?=
 =?utf-8?B?UVZRck5uRHlaNFZGRHE4UDZxU2liK0N3cGFqK1Jvbi9jRCs5aE5RREg2b2l0?=
 =?utf-8?B?QWhhMTFlZExGNHp6TjM3bUtyWkM5Q3kwNDZUTTR3MkhIS0NRMHRzYzNqcDE0?=
 =?utf-8?B?VkM3bmlRTGhXVlZTRk80YVNHTWZHQkpjM3NOQkJNWFhHbU9ZeDFEL283UzJF?=
 =?utf-8?B?OUNkMGsvWWpTM09kTEE4M3hnckZhTE5JNWlBc244TkxnZmVCZXJWU3ZSb1Y4?=
 =?utf-8?B?VUM0T2xpRGVndFVETEZyTnF2T1lyNXhSTGRzSVllSG9UdkxTSGswcENSNXBO?=
 =?utf-8?B?Wno2MTlTNXMzayt4cU9EZGVPN3FKNk5BRlZzQXVJcnJ4T3Rab0cxWkhsSG9U?=
 =?utf-8?Q?FBh6KQOm80o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUxTb2d0SHFmY0FxZjB0WHVBcExIa2hXOGdjdGROMkl3TjlTZm9CekZ2U0RV?=
 =?utf-8?B?cG5MVE5tUUVINWgzcHZ3ZGNKSVpZUzFsRjhNcDRLNlRsbk4vRDc0YTlFbkdQ?=
 =?utf-8?B?WU9EQzVBSHFpUHFFbEVUaDBvbkc2SitLTml0ajdoNkVtY1lNYkJ6OW9BYVJ1?=
 =?utf-8?B?L2t3Y1dzUm02dlJPZFBBckxYNWh5cHJHMlhzcFFTRjhGeTVVUTF4cXNZR2RR?=
 =?utf-8?B?RDVvWEFDcVF6YTBWelkreFpldU5KVHFwb1ZINHhDTEE2V1pTV3RYRXRjaGlG?=
 =?utf-8?B?SHVGdkk3a21IbWhxR3poaUFlaU9XNHpKcmdpNys3SVU5bERGOU12c2RkaThj?=
 =?utf-8?B?Tmtsc2UrbUtGQmpKczRIaUdrNk5LYTVqa0JER1U2b082T3hzaUNkd0pXcmhx?=
 =?utf-8?B?bHRmWWJSR3hjMEZOdnp5THNCVE9nYzFBUzMxMGtENG9jeUxTQXlLaVd1Ympu?=
 =?utf-8?B?WG5ZV1o1dmNlK20xTjlZbHR1U0ljOXYyTVZNYUdnUmhlTjdBTnJQQUdVdWxq?=
 =?utf-8?B?NS9McnNFMFlYeE5ncU1QdTdsM3Y0RHo3MzVGRkovY3luKzF1dm5LaFZVWnNo?=
 =?utf-8?B?VEhkcGlweU5lTHF0NXFBc1hzUTlNWE1wVndmRmdia28yeFpWV1JZZUx3SlpT?=
 =?utf-8?B?SkFEclNKR3h6b1ptVldtYzdvcCtLbXAvLy9sSDl3cFIzc2FpeExnNExFcjQ5?=
 =?utf-8?B?MTB1THdVK2tORjZqbmp3YmZlbDVVelQ1QlQxR0JBQ2htUldQbGVxZjM4Qisz?=
 =?utf-8?B?VTloaiswcHlsUklRNU5aUzQwSTRpc1dQL210QWtoc1dhZ0NST3Q0eDV4QnRS?=
 =?utf-8?B?VUNDMm9PeHN5ZUZ0UmJTN1hKQ3RLL3Z5TncrOWkwUWxtZ1ZHZWZIVElmZUZz?=
 =?utf-8?B?bENIY3Y5enluUVR4UGlMN1oyN01lRzRoVkxvSUJUdUxON09wanBVRUFiWHJn?=
 =?utf-8?B?eWJ2VkJHMGJaOGZ2Nk1uT0o5UE5BQnNIeUtUWmJBMk5GUEVMU0Zmd1RTaTNl?=
 =?utf-8?B?ZUxxTkN0ZUdkNFFiVnlGQXZvRCttWFpsc1ptQ0gxZlRhSUZIZkhieklncEhI?=
 =?utf-8?B?azFTZWorUmdZWCtoVlp3eTVrbEtKdDJYT2FHSE0vYlZrZ0ViUU9DdnBtdGtu?=
 =?utf-8?B?a0NBeTlFbENFTnZZN3BITUN2MVUxNFBOcHZqTEs4eXljYW54SFVleGRUb0ht?=
 =?utf-8?B?TFFoYU5SbUkxa0NPdzJrYmlWamFkZ1FHaTRxRkxJczNXb1NocUVpRFBFS2wy?=
 =?utf-8?B?bDdkSjZhdytxUUJSMjNRKzlZcXJpejd3Mmp4N2ZiUDBHb2VQalhGR2VXbjdq?=
 =?utf-8?B?VEhtWm1uVDZBa3ZWdVF0QjY0RTYxT3hFcmxNd1VVYUFQSDdSaWVCeFladWYy?=
 =?utf-8?B?c29PVG5MQUltdEtXSk55N3BCZTJ1a3pmZm1ydWtSb00reVBueUordmR3TEla?=
 =?utf-8?B?c1dtejVqRkY4N0lucXpXNUVSRnBUeW9YUm1rVm5PNXRmYzB2ZnNEWmcvUlQ2?=
 =?utf-8?B?MFd6ZDZGbGNISTFydlk3SStBa0Nma0Z3TjhuZC9YSTlxSS9sSmJ3V0NzZTFs?=
 =?utf-8?B?VXZNZGxCdGYrbmpZekM2ZGt5b3d1SzZTRFl3WEMrYlNXRDZYbWtQT1UxVzdz?=
 =?utf-8?B?VDFRQjhRQ3dRaHFPblZod2lUSG5XTEptTVBWWUdzdm1xQnJXMVNpWjZrcjZF?=
 =?utf-8?B?aW91dFdPRHZDOFJGQzFoOHpUbEYvTEFUUkluVm1qbDRjK2h6YUdFZFh6eFRE?=
 =?utf-8?B?V0ZYa2t2a1VQZ0Q5aitZNm1yRUE0WGNRMlVrajg3SGhTdkcwSjJBVFRtSGVz?=
 =?utf-8?B?MHVDLzFpSjFFWStoY3BoZzR2czNTU0xQN2xvNXgwOC9xclZYaXlJOVdiWS90?=
 =?utf-8?B?b0I5UVBQUU9iMHJybHN6QUxuTHdqRDlNM1AvRlBMaFBNZGk0aDhCQnlpcE9j?=
 =?utf-8?B?cTVLWVZEK0xyTHJJbWVwOUFYUUgvdFNpVG1aWU80bC9HT0tGaktSQjdaWDlU?=
 =?utf-8?B?RTZVZHR5eTc5L0NXTG5GNGp1RExPMDNPRmFwby92UlRmL2xnajd6bXkzbTdm?=
 =?utf-8?B?emRRcVJnbkI4bmtCa1lXQzlZMXVIQktCN1BpUnNjSjZ1WkNCNVhMbHVOV0ht?=
 =?utf-8?Q?zHY8YDi0KzKRw4//evkWLSAJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac5b7d8-b314-41ea-3cf5-08ddf4b5fa55
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 00:14:18.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MibkZ7Py03MKPXYUYg7jnBIWZ3a8w39KgKA/IjtZ4t+lwff3alUCcKglo/eXbCSawsMEbK/eZ7sMYaDbhz+4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6631



On 12/9/25 09:56, Dan Williams wrote:
> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc():
>      Allocate a Selective IDE Stream Register Block in each Partner Port
>      (Endpoint + Root Port), and reserve a host bridge / platform stream
>      slot. Gather Partner Port specific stream settings like Requester ID.
> 
> pci_ide_stream_register():
>      Publish the stream in sysfs after allocating a Stream ID. In the TSM
>      case the TSM allocates the Stream ID for the Partner Port pair.
> 
> pci_ide_stream_setup():
>      Program the stream settings to a Partner Port. Caller is responsible
>      for optionally calling this for the Root Port as well if the TSM
>      implementation requires it.
> 
> pci_ide_stream_enable():
>      Enable the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>      stream%d.%d.%d
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>

This still stands true, just a few comments below, since I am commenting on other patches.

> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   .../ABI/testing/sysfs-devices-pci-host-bridge |  14 +
>   drivers/pci/ide.c                             | 429 ++++++++++++++++++
>   include/linux/pci-ide.h                       |  73 +++
>   include/linux/pci.h                           |   6 +
>   4 files changed, 522 insertions(+)
>   create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> index 8c3a652799f1..2c66e5bb2bf8 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -17,3 +17,17 @@ Description:
>   		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
>   		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
>   		format.
> +
> +What:		pciDDDD:BB/streamH.R.E
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. A stream
> +		consumes a Stream ID slot in each of the Host bridge (H), Root
> +		Port (R) and Endpoint (E).  The link points to the Endpoint PCI
> +		device in the Selective IDE Stream pairing. Specifically, "R"
> +		and "E" represent the assigned Selective IDE Stream Register
> +		Block in the Root Port and Endpoint, and "H" represents a
> +		platform specific pool of stream resources shared by the Root
> +		Ports in a host bridge. See /sys/devices/pciDDDD:BB entry for
> +		details about the DDDD:BB format.
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 05ab8c18b768..608ce79d830f 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -5,8 +5,12 @@
>   
>   #define dev_fmt(fmt) "PCI/IDE: " fmt
>   #include <linux/bitfield.h>
> +#include <linux/bitops.h>

Compiles without it.

>   #include <linux/pci.h>
> +#include <linux/pci-ide.h>
>   #include <linux/pci_regs.h>
> +#include <linux/slab.h>

Compiles without it.

> +#include <linux/sysfs.h>
>   
>   #include "pci.h"
>   
> @@ -23,6 +27,13 @@ static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
>   	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
>   }
>   
> +static int sel_ide_offset(struct pci_dev *pdev,
> +			  struct pci_ide_partner *settings)
> +{
> +	return __sel_ide_offset(pdev->ide_cap, pdev->nr_link_ide,
> +				settings->stream_index, pdev->nr_ide_mem);
> +}
> +
>   void pci_ide_init(struct pci_dev *pdev)
>   {
>   	u8 nr_link_ide, nr_ide_mem, nr_streams;
> @@ -88,5 +99,423 @@ void pci_ide_init(struct pci_dev *pdev)
>   
>   	pdev->ide_cap = ide_cap;
>   	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_sel_ide = nr_streams;
>   	pdev->nr_ide_mem = nr_ide_mem;
>   }
> +
> +struct stream_index {
> +	unsigned long *map;
> +	u8 max, stream_index;
> +};
> +
> +static void free_stream_index(struct stream_index *stream)
> +{
> +	clear_bit_unlock(stream->stream_index, stream->map);
> +}
> +
> +DEFINE_FREE(free_stream, struct stream_index *, if (_T) free_stream_index(_T))
> +static struct stream_index *alloc_stream_index(unsigned long *map, u8 max,
> +					       struct stream_index *stream)
> +{
> +	if (!max)
> +		return NULL;
> +
> +	do {
> +		u8 stream_index = find_first_zero_bit(map, max);
> +
> +		if (stream_index == max)
> +			return NULL;
> +		if (!test_and_set_bit_lock(stream_index, map)) {
> +			*stream = (struct stream_index) {
> +				.map = map,
> +				.max = max,
> +				.stream_index = stream_index,
> +			};
> +			return stream;
> +		}
> +		/* collided with another stream acquisition */
> +	} while (1);
> +}
> +
> +/**
> + * pci_ide_stream_alloc() - Reserve stream indices and probe for settings
> + * @pdev: IDE capable PCIe Endpoint Physical Function
> + *
> + * Retrieve the Requester ID range of @pdev for programming its Root
> + * Port IDE RID Association registers, and conversely retrieve the
> + * Requester ID of the Root Port for programming @pdev's IDE RID
> + * Association registers.
> + *
> + * Allocate a Selective IDE Stream Register Block instance per port.
> + *
> + * Allocate a platform stream resource from the associated host bridge.
> + * Retrieve stream association parameters for Requester ID range and
> + * address range restrictions for the stream.
> + */
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> +{
> +	/* EP, RP, + HB Stream allocation */

The big beautiful comment before the function kinda covers this one :)

> +	struct stream_index __stream[PCI_IDE_HB + 1];
> +	struct pci_host_bridge *hb;
> +	struct pci_dev *rp;
> +	int num_vf, rid_end;
> +
> +	if (!pci_is_pcie(pdev))
> +		return NULL;
> +
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
> +		return NULL;
> +
> +	if (!pdev->ide_cap)
> +		return NULL;
> +
> +	/*
> +	 * Catch buggy PCI platform initialization (missing
> +	 * pci_ide_init_nr_streams())
> +	 */
> +	hb = pci_find_host_bridge(pdev->bus);
> +	if (WARN_ON_ONCE(!hb->nr_ide_streams))
> +		return NULL;
> +
> +	struct pci_ide *ide __free(kfree) = kzalloc(sizeof(*ide), GFP_KERNEL);
> +	if (!ide)
> +		return NULL;
> +
> +	struct stream_index *hb_stream __free(free_stream) = alloc_stream_index(
> +		hb->ide_stream_map, hb->nr_ide_streams, &__stream[PCI_IDE_HB]);
> +	if (!hb_stream)
> +		return NULL;
> +
> +	rp = pcie_find_root_port(pdev);
> +	struct stream_index *rp_stream __free(free_stream) = alloc_stream_index(
> +		rp->ide_stream_map, rp->nr_sel_ide, &__stream[PCI_IDE_RP]);
> +	if (!rp_stream)
> +		return NULL;
> +
> +	struct stream_index *ep_stream __free(free_stream) = alloc_stream_index(
> +		pdev->ide_stream_map, pdev->nr_sel_ide, &__stream[PCI_IDE_EP]);
> +	if (!ep_stream)
> +		return NULL;
> +
> +	/* for SR-IOV case, cover all VFs */
> +	num_vf = pci_num_vf(pdev);
> +	if (num_vf)
> +		rid_end = PCI_DEVID(pci_iov_virtfn_bus(pdev, num_vf),
> +				    pci_iov_virtfn_devfn(pdev, num_vf));
> +	else
> +		rid_end = pci_dev_id(pdev);
> +
> +	*ide = (struct pci_ide) {
> +		.pdev = pdev,
> +		.partner = {
> +			[PCI_IDE_EP] = {
> +				.rid_start = pci_dev_id(rp),
> +				.rid_end = pci_dev_id(rp),
> +				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +			},
> +			[PCI_IDE_RP] = {
> +				.rid_start = pci_dev_id(pdev),
> +				.rid_end = rid_end,
> +				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +			},
> +		},
> +		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> +		.stream_id = -1,
> +	};
> +
> +	return_ptr(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_alloc);
> +
> +/**
> + * pci_ide_stream_free() - unwind pci_ide_stream_alloc()
> + * @ide: idle IDE settings descriptor
> + *
> + * Free all of the stream index (register block) allocations acquired by
> + * pci_ide_stream_alloc(). The stream represented by @ide is assumed to
> + * be unregistered and not instantiated in any device.
> + */
> +void pci_ide_stream_free(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	clear_bit_unlock(ide->partner[PCI_IDE_EP].stream_index,
> +			 pdev->ide_stream_map);
> +	clear_bit_unlock(ide->partner[PCI_IDE_RP].stream_index,
> +			 rp->ide_stream_map);
> +	clear_bit_unlock(ide->host_bridge_stream, hb->ide_stream_map);
> +	kfree(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_free);
> +
> +/**
> + * pci_ide_stream_release() - unwind and release an @ide context
> + * @ide: partially or fully registered IDE settings descriptor
> + *
> + * In support of automatic cleanup of IDE setup routines perform IDE
> + * teardown in expected reverse order of setup and with respect to which
> + * aspects of IDE setup have successfully completed.
> + *
> + * Be careful that setup order mirrors this shutdown order. Otherwise,
> + * open code releasing the IDE context.
> + */
> +void pci_ide_stream_release(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +	if (ide->partner[PCI_IDE_RP].enable)
> +		pci_ide_stream_disable(rp, ide);
> +
> +	if (ide->partner[PCI_IDE_EP].enable)
> +		pci_ide_stream_disable(pdev, ide);
> +
> +	if (ide->partner[PCI_IDE_RP].setup)
> +		pci_ide_stream_teardown(rp, ide);
> +
> +	if (ide->partner[PCI_IDE_EP].setup)
> +		pci_ide_stream_teardown(pdev, ide);
> +
> +	if (ide->name)
> +		pci_ide_stream_unregister(ide);
> +
> +	pci_ide_stream_free(ide);
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_release);
> +
> +/**
> + * pci_ide_stream_register() - Prepare to activate an IDE Stream
> + * @ide: IDE settings descriptor
> + *
> + * After a Stream ID has been acquired for @ide, record the presence of
> + * the stream in sysfs. The expectation is that @ide is immutable while
> + * registered.
> + */
> +int pci_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	u8 ep_stream, rp_stream;
> +	int rc;
> +
> +	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> +		pci_err(pdev, "Setup fail: Invalid Stream ID: %d\n", ide->stream_id);
> +		return -ENXIO;
> +	}
> +
> +	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
> +	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> +	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> +						   ide->host_bridge_stream,
> +						   rp_stream, ep_stream);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	if (rc)
> +		return rc;
> +
> +	ide->name = no_free_ptr(name);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_register);
> +
> +/**
> + * pci_ide_stream_unregister() - unwind pci_ide_stream_register()
> + * @ide: idle IDE settings descriptor
> + *
> + * In preparation for freeing @ide, remove sysfs enumeration for the
> + * stream.
> + */
> +void pci_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +
> +	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	kfree(ide->name);
> +	ide->name = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_unregister);
> +
> +static int pci_ide_domain(struct pci_dev *pdev)
> +{
> +	if (pdev->fm_enabled)
> +		return pci_domain_nr(pdev->bus);
> +	return 0;
> +}
> +
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	if (!pci_is_pcie(pdev)) {
> +		pci_warn_once(pdev, "not a PCIe device\n");
> +		return NULL;
> +	}
> +
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pdev != ide->pdev) {
> +			pci_warn_once(pdev, "setup expected Endpoint: %s\n", pci_name(ide->pdev));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_EP];
> +	case PCI_EXP_TYPE_ROOT_PORT: {
> +		struct pci_dev *rp = pcie_find_root_port(ide->pdev);
> +
> +		if (pdev != rp) {
> +			pci_warn_once(pdev, "setup expected Root Port: %s\n",
> +				      pci_name(rp));
> +			return NULL;
> +		}
> +		return &ide->partner[PCI_IDE_RP];
> +	}
> +	default:
> +		pci_warn_once(pdev, "invalid device type\n");
> +		return NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_to_settings);
> +
> +static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> +			    struct pci_ide_partner *settings, int pos,
> +			    bool enable)
> +{
> +	u32 val = FIELD_PREP(PCI_IDE_SEL_CTL_ID, ide->stream_id) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_DEFAULT, settings->default_stream) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_CFG_EN, pdev->ide_cfg) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_TEE_LIMITED, pdev->ide_tee_limit) |
> +		  FIELD_PREP(PCI_IDE_SEL_CTL_EN, enable);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> +}
> +
> +/**
> + * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * When @pdev is a PCI_EXP_TYPE_ENDPOINT then the PCI_IDE_EP partner
> + * settings are written to @pdev's Selective IDE Stream register block,
> + * and when @pdev is a PCI_EXP_TYPE_ROOT_PORT, the PCI_IDE_RP settings
> + * are selected.
> + */
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> +
> +	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> +	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +
> +	/*
> +	 * Setup control register early for devices that expect
> +	 * stream_id is set during key programming.
> +	 */
> +	set_ide_sel_ctl(pdev, ide, settings, pos, false);
> +	settings->setup = 1;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> +
> +/**
> + * pci_ide_stream_teardown() - disable the stream and clear all settings
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + *
> + * For stream destruction, zero all registers that may have been written
> + * by pci_ide_stream_setup(). Consider pci_ide_stream_disable() to leave
> + * settings in place while temporarily disabling the stream.
> + */
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> +	settings->setup = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_teardown);
> +
> +/**
> + * pci_ide_stream_enable() - enable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control
> + * Register.
> + *
> + * Return: 0 if the stream successfully entered the "secure" state, and -EINVAL
> + * if @ide is invalid, and -ENXIO if the stream fails to enter the secure state.
> + *
> + * Note that the state may go "insecure" at any point after returning 0, but
> + * those events are equivalent to a "link down" event and handled via
> + * asynchronous error reporting.
> + *
> + * Caller is responsible to clear the enable bit in the -ENXIO case.
> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -EINVAL;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, settings, pos, true);
> +	settings->enable = 1;
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE)
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);
> +
> +/**
> + * pci_ide_stream_disable() - disable a Selective IDE Stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Clear the Selective IDE Stream Control Register, but leave all other
> + * registers untouched.
> + */
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +
> +	if (!settings)
> +		return;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +	settings->enable = 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_disable);
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..5a7ffb1d826f
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */

A nit: may be refer to the version where it appeared first (r6.1).

> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__


#include <linux/pci.h>


> +
> +enum pci_ide_partner_select {
> +	PCI_IDE_EP,
> +	PCI_IDE_RP,
> +	PCI_IDE_PARTNER_MAX,
> +	/*
> +	 * In addition to the resources in each partner port the
> +	 * platform / host-bridge additionally has a Stream ID pool that
> +	 * it shares across root ports. Let pci_ide_stream_alloc() use
> +	 * the alloc_stream_index() helper as endpoints and root ports.
> +	 */
> +	PCI_IDE_HB = PCI_IDE_PARTNER_MAX,
> +};
> +
> +/**
> + * struct pci_ide_partner - Per port pair Selective IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
> + *		    address and RID association registers
> + * @setup: flag to track whether to run pci_ide_stream_teardown() for this
> + *	   partner slot
> + * @enable: flag whether to run pci_ide_stream_disable() for this partner slot
> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +	unsigned int default_stream:1;
> +	unsigned int setup:1;
> +	unsigned int enable:1;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint in the pci_ide_partner pair
> + * @partner: per-partner settings
> + * @host_bridge_stream: track platform Stream ID
> + * @stream_id: unique Stream ID (within Partner Port pairing)
> + * @name: name of the established Selective IDE Stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};
> +
> +struct pci_ide_partner *pci_ide_to_settings(struct pci_dev *pdev, struct pci_ide *ide);
> +struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev);
> +void pci_ide_stream_free(struct pci_ide *ide);
> +int  pci_ide_stream_register(struct pci_ide *ide);
> +void pci_ide_stream_unregister(struct pci_ide *ide);
> +void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide);
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_disable(struct pci_dev *pdev, struct pci_ide *ide);
> +void pci_ide_stream_release(struct pci_ide *ide);
> +DEFINE_FREE(pci_ide_stream_release, struct pci_ide *, if (_T) pci_ide_stream_release(_T))
> +#endif /* __PCI_IDE_H__ */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d3880a4f175e..45360ba87538 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -544,6 +544,8 @@ struct pci_dev {
>   	u16		ide_cap;	/* Link Integrity & Data Encryption */
>   	u8		nr_ide_mem;	/* Address association resources for streams */
>   	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	u8		nr_sel_ide;	/* Selective Stream count (register block allocator) */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
>   	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
>   	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>   #endif
> @@ -613,6 +615,10 @@ struct pci_host_bridge {
>   	int		domain_nr;
>   	struct list_head windows;	/* resource_entry */
>   	struct list_head dma_ranges;	/* dma ranges resource list */
> +#ifdef CONFIG_PCI_IDE
> +	u8 nr_ide_streams; /* Max streams possibly active in @ide_stream_map */
> +	DECLARE_BITMAP(ide_stream_map, CONFIG_PCI_IDE_STREAM_MAX);
> +#endif
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);

-- 
Alexey


