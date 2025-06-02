Return-Path: <linux-pci+bounces-28787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB160ACA8A9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 06:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81443B6B99
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 04:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA32AD2F;
	Mon,  2 Jun 2025 04:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Scj4tCI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3013B797
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748839985; cv=fail; b=fbIAs3FISt7F+XydDiUpg03QM+duxuX/6RdS/AJ+pId/PRK/yPGFC3uduz8uFzWNoAjL6S5bcLJOpwh2+d5xnteZ5K6zSLbBhgNJEqJNITgFIfllMkHz3BKdZD9/VtEz9wHeZ2/Aw08nJwCQ8hom44cbC/RPg5AHXYB/IHYhS8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748839985; c=relaxed/simple;
	bh=mx7Tiow8g9I6uMY9YRZSmmIuUc4BAfIeeyQJYR9IeXQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iisOScM50jFSISEOv7XdllDB+E3XUKW4DvVVylJUA6VEkVAhNLAfiFfQJ1H5zCwDVsxfYAwVsyg6Yyz7qIxOBVA5qhF+lwBFl9kkatJjot8BO9WI5Ox7SYJ455TmaxiD9ihdxMa11ado996sYZNdkJvOkKHajLv6ibzQx2+O18o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Scj4tCI; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDecds2ichbtTfZDRKhrKyFQ3/OdPSPf7hUNx6MB1A1ZyZK7ZuUWxWStAB2tu9X+5n9fwMivR/LOn/5v1LJ9IdBYvg3VYAY3JJKYa6kp6tm3pek53cl7V7yn1kES46aENtKz6MvUUBJKK3t9uzz+AACkZXLyNzF525iOdu159tsHBfUJTMT7sDpn2F3FhJ9etLx/9v8B+y2cB/2ZAcIO9j+yGZFQ7rhxgxhoBAa2WKbfqaqEB1vFhdT//SqbRo3olEuV72cmnOWcIpQlppmplvS4yAUiEXZBG3tV6P+8RhCJBDjDt0fb152mylc1QNhH3aXXVOTBBNr5QIO5MekYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iFkL6T+Tq2EIfIkaFqtEutym62/PAMBCXUM5B1K+7I=;
 b=EOm7ilnFYQPVRdBxGFw7vRQwcZZFVqdKsSmO7RgrXHzQGhAncpIIbfw6seBmFEgT1IhHN44jM/R83vLiUOqrWrHWCKpMKaL7sPd43teUngbQy2T6ofnZNigwl++NHXbg7s+gy0AxFdSRfcQuizE3lwmXebDZfTq3khJus2zNmGWlSeCu6GWfISgg9GOUlJv1OA5H5M2rVX/veHyPVRN7wW/1bvPvn1EwWWegWV8ZeRJw8y2x4t1Xe0zv8bXRmn3kz2L+aFDnE+ElKoYaBON2AjzeHYG1zUc6i7qcyc2v1lwuy7vaKIPMDhm38Ls3B+ywzPXvq4sQSBBAr4lZUdPpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iFkL6T+Tq2EIfIkaFqtEutym62/PAMBCXUM5B1K+7I=;
 b=4Scj4tCIlL34bTeW8cm2qDDLJYOjNP6hEni0o3IR+a4zlceLoZyE4aga/I9eksf7PUpyKIn9lXcWjYjOm2os9xf7Hu/oCp9ESNBgo8kKZXJyZ8IIvFuNntZhuQUiEdx16m+hlEQ57R0XSv9LJ7czPrrSBZuWRvTEFArEj+8fiUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Mon, 2 Jun
 2025 04:53:01 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Mon, 2 Jun 2025
 04:53:01 +0000
Message-ID: <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
Date: Mon, 2 Jun 2025 14:52:52 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
To: Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, lukas@wunner.de,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0119.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: 205f5b4f-502f-4a59-bb71-08dda1915a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDJrS000WGk2dzlhTkVubUVKWEYxejNiWlloRWFleHlDY0FqR1JqNkd4aUg2?=
 =?utf-8?B?TklwWXRHSktuREZ3bm1CbGoramFDWlZ5cWREV0VpWjlndEdBVXNvOGczMklp?=
 =?utf-8?B?T0gwU3ZTUk1QaWJjNEpYcTc3ZWV0OXRWWm1wNEFwbHdQWWRxd1k3K1ZCOGJC?=
 =?utf-8?B?SGdXZkppL2hrSUdlS3BqTmxlSGJxcHVNai9QRWI4RDNjTk1FZWJ6amRnNHRE?=
 =?utf-8?B?djBPbHZEZFdOVVJGbm5ROFJhbURNTDhLTEh6YVUwZkx2VC9RWmprMEJscDYv?=
 =?utf-8?B?UUlsR3o2cllxYWRlaHVXZ3ArYUVXU1R1WUpxa1BLQmtqL1ZQNFMreUR5cG9q?=
 =?utf-8?B?OW9Uakd5UStGQWpIK1lMSkJjWjhpcU1mRkNEUmNKQkVzeExTWmpTR0hpTmxy?=
 =?utf-8?B?WDl5UFdkMXhkeXZsc0F3Q1I4RXF2NkRHczRpYkZkODFkZDk1UUJtVnZQeHI3?=
 =?utf-8?B?bkFCeHY3QWVKeEhtT29YQ1h1SFNMZHp3K011MkV0alZ3ZUo5eC9heU1DMnBi?=
 =?utf-8?B?emZzOVc1ZTBlQWRWZU1zQ3pxcnQzWHBSYWdYTU9Cd3QxbE94d2tUNUpYSFdl?=
 =?utf-8?B?c1c2SGI5WDZZVTdUeHV2eks0NjA2UUF6WUp1alNhcCt6NnVjUmxwYXBxdjVF?=
 =?utf-8?B?d3lYa1lHc1VmNkVNbURZeTAvNnJBMDQvWTJRMUpXekVwaHFNbklnOG9FZWRr?=
 =?utf-8?B?VjVVNnVUUE9BTkZUY2RVZUtWcW1WSUV3K0JPZUNlSERTYXZ0czBvamxxL3p3?=
 =?utf-8?B?VzlGZHYrUERuZ3lWa1YxcmMrQklQYVoybHA4V3FPVWpybVJYZHhFSU1FTWtN?=
 =?utf-8?B?NzVHSC92OUpEeDVtcTIvVUVtVDdGVWJycWN2b3RHQlVReHlrOW43cmExcG9n?=
 =?utf-8?B?aWlyaWQ4VWJvR1RkNlFDY0orcUxURlU0dUFCQnJHRk5IOEQydXRFZEhKMzUr?=
 =?utf-8?B?ZFMydk8ySDVCMm11by9OYU9wYW9IOS9WazZmK3lBM1JTM2JQZnBGMEF2c0pq?=
 =?utf-8?B?RGFBU0RuRk4rSjZzdFhyMkNOMTd3TU85RHg3NW5kWjFGV1hqMFMvemhRT1pi?=
 =?utf-8?B?cW1pUTN0Qy9RSTZOdXdvM09wdUxpajVMMU02REVWRWhFSVJ4T0dCSXV5TVFP?=
 =?utf-8?B?dWpjendPaDRydkVEQXZNZnppQUY5cjdXSW5qa2dLZE9LMFh6RW1uT05WMXEx?=
 =?utf-8?B?L3ZKMkF0K0ZBOG45aDFjaEJpUVN1VS9sY0NGY05WcjduVFFsa1oyZlB4RHhp?=
 =?utf-8?B?NCs0SW9LVDNRd3FCdnJvTWVONE5rREhKS3JFZW13NnM4TjFtLzJUbkNteHVS?=
 =?utf-8?B?eEVBaTVqZ1FLeUF4ME1Yd3lja0NrdWNIQTZVbGxwOXFrMEZ3RDB5WENHZ1JW?=
 =?utf-8?B?eEhyNy90eVVDdWlEdzFvKzNpUDh0QnJvS0wrQkRDaGNPSC9jUlJCNWNFbC9p?=
 =?utf-8?B?eFlWS2cyUDNJQVFzRkRUanRVWSt6TjdsZFFmbWxwNFVVWGhUeUZOS3RzN3Ry?=
 =?utf-8?B?RXMxMk5IN2Y5RWFYWWkvZHIwSDVWYmg2clVVeEtxRGxmME4wN1hrbnNTK0Nj?=
 =?utf-8?B?NWxBQ0xIeFA4RnlHUlVIamJheHQ3b3Z5dEFXM3VCOURyblRvOHk0WG8rdVYr?=
 =?utf-8?B?bzIwc084RCtvZ2xJMXhlaEd2LzJVb0Q1YWVJKzlxeks1NlExQlZFTUVJd1pC?=
 =?utf-8?B?TzlINW8zcW0vU1Z1b1pLSEhsMlBPVUdVVGRSai9LZnIxT1IxdnFaRVd3VDc4?=
 =?utf-8?B?bHIyREVPeithTEdxRStlZVlrUzRpd2pOclZybWluTElLZTZuQ0U3djZaWTNK?=
 =?utf-8?B?c0lJYUNMZzRPbEgzaldNUWdDQTR6SHBJMjhpVEFCNS9zaGo2eXBsdGtDK0Vj?=
 =?utf-8?B?Q0tPOEVXQldjR0hzcDVZM3hVMkI0ZlpYME1mcG0xUUR1TXk1S05FbjFVZHJJ?=
 =?utf-8?Q?c97h6MjNaO3LE3SUyLPHiCtXSFs3Sd1z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzl4UjBXbjR6RSsyTS9aaEVWNXppUmZOYnpwR1JXcTRGRU55OEM3bS9oQ1Rh?=
 =?utf-8?B?TnVFc2FhVDJRbFJXVkJBMUdmRmtJMEpJMURyTStJSE9YYWtWc1U1aHpCLysr?=
 =?utf-8?B?NGdaclE1V1pNZWZTcHJDL1E1MUxOWlJnR3BsMWhRRDFRb05DdEJFOS9pNDVS?=
 =?utf-8?B?NC9yTlVxM2dQMmoxeVB6aFpzekpOSnlnQVdBZEFMNnZUYXRvN2RWRm9oWmUz?=
 =?utf-8?B?dmxSaDNUTStLQ1AvK0I4aEhQL3Y2d3kySDF5R0E4SzF2ZTlvR3pyRktCSjZv?=
 =?utf-8?B?Nk9qa0JBNmc0dWVBTWtUdG11R3Y4ek0yaTVoelU0T3ZtVmgzd2ZYYVpEOXJF?=
 =?utf-8?B?SDdtaUZZc2hiZHlBM2pZbGlwRFJCSHZpMmwyeTlkYjdPYTRLNzZNL0YrTGJs?=
 =?utf-8?B?djUyTUwxK2kwS3RVSFMyMmUzZ1NIazRNSzE2M1hqV3g0YTR5d29YM0xFOW9P?=
 =?utf-8?B?Z09wcEJ5NEVBQStjc2lmZVRnNXN0UmsvekJLZjVzMXp1c3VqTFZNYnRHYk5P?=
 =?utf-8?B?MHJnUEpnbUxtSTVzVGVTT1plcnlJTHRCRUI1aFJGeXcyaitiVElMV0twZWNH?=
 =?utf-8?B?SGcycEcxbnUxcmo3R0NwMFE0RmVpRUM3Vk5YSHJHRlJpSERZK012UFljeS9x?=
 =?utf-8?B?RG05K0g1MlAycVlEbVdibjhGRGN4MFhHaWZjaTQ0ZCtvUUxKQWNudTdPWmZT?=
 =?utf-8?B?UmVrNGJuVTVhSEpaNk1UR0ducXdhUndYQkYwdXJ2a0g3cjMyMXcyVnVKc2Zs?=
 =?utf-8?B?Qjh0U2tOUUh2cUtvMTlQZGRXdFdDcm9ISEN1enBuMHpXTDJRSmErL0VPM1dj?=
 =?utf-8?B?MHhpZEdYaGpSbmF6NStIcnRVdUU5Umg4QTNIWmJXUXNIM3FEVkE3UG1DL1ZQ?=
 =?utf-8?B?RjgxYzhaWUlwd2lKWTY2VytjZFltNjFLbkpXM2tPUXhDczFZMHdWVy9mTWVQ?=
 =?utf-8?B?UTc4d3cxN3ozQ0JqRHMrV2ZCSnhPMWJKMTdGL0QxWHJUREt5TUIycyt2ais3?=
 =?utf-8?B?emVJdUlDcktmR0dXY0pqV0c2eDdYVGRxU3RUWVlRakQ3ME95L3Y2R1EvTFNQ?=
 =?utf-8?B?UjFuWkovdFdWQnY4dXk0SkNuTkhYSnRFQUZqRTd4S2I3THQzVjNCaEgrZFRE?=
 =?utf-8?B?WkxpekFPMFBKSGt2Z2NDTXd0dEprUFdnOWpBYnh5N0xpb3V3ZUxVSGJFUzhX?=
 =?utf-8?B?dWdUdW1EcEdqd0VpbUt6U3Erd1N2c0hLemRwMEl4RkdTRENrLzVxbWhra0dE?=
 =?utf-8?B?TmxPcEkxdTNKK1hEbGd1eXdLemM0K1lmMzFmeFJpaldpSU5oRnJVTHRvTjNv?=
 =?utf-8?B?U1lpNnlFTExkU0RxSWEyV3hTM281WDRpWXVpVnU3SWtyYlRkbmVveDc3aTl4?=
 =?utf-8?B?Y3hpYmdNZXVkdVhJaVcydEtIZHNLMzdhZkNNcTk4dk5oK2JDNDF0WUY4QnZo?=
 =?utf-8?B?MnV2SjdWdzhwL05YU1VUTWY5b3dnZlB1RWRXODFIUitRSU1TY3BvdEVRd3lv?=
 =?utf-8?B?eW5KUmdSaWl4aFBpK21JWmpUM0NFdnVpRnM3R1REanZxQmJQS1MwZW4wZGND?=
 =?utf-8?B?WDExcXN3T29saGlETnhtT3E0YTFycUw2WnZDeEtPQzVGNEFUbGJRTmpEQ041?=
 =?utf-8?B?d211Z2hmRDhnY2VBdFhyekducTI3SW9waWVSRUxaVEFHNmtTcENsQU1rejVk?=
 =?utf-8?B?d1NLMHFYeldtNHBadllZeHdxMmZBUXVBdzZHenJGWHZxOExqZFpLdGlUMFBz?=
 =?utf-8?B?K09xME5jSUx1c3FHeVFJUmxVK0kySjdMZjF1eENtUm9TUFlBcjJaSUZjZzU1?=
 =?utf-8?B?UFBoRGc0am9oMmhqVXRud0wxRCtmc3RNQlVvcHdvOHZHWjFRbGVQVCtpVk02?=
 =?utf-8?B?aFF6VU9oazhRU3BMQ3NlMDU4OXJBdTJWMlU3OG1qWXVMdGR2TUdHTm1xTGJM?=
 =?utf-8?B?ZnRieEcwNmFQK0pOb1ErQ1V4R1ZGVlZXcWZRRkFLUjdMbCtrdXlLeWI1Z2JD?=
 =?utf-8?B?dnBSM3BFZ1d5cHpnNWdlZVd2L0tJa3lERVFPYVY2UFQzbkN1aTZpM1ZWMGcz?=
 =?utf-8?B?ZkU2MVpNOG4rU1Z4L0hUQVFIc3o5a0pzd2NrMTdFcUo5L0hVYi9ldlJlOFpr?=
 =?utf-8?Q?F8tvNGm8eKBB5j4E96lrQBid/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f5b4f-502f-4a59-bb71-08dda1915a58
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 04:53:01.7475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjV1SKx2PAFwcFeLApcZzmOpdFqTEQ9gETxSpViQU1swjrLBoxdgfhBdhMyJkyKUhcY2ftIzHR25VeIphguoDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126



On 1/6/25 02:25, Xu Yilun wrote:
>> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
>> + * @size: sizeof(struct iommu_vdevice_id)
>> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
>> + */
>> +struct iommu_vdevice_id {
>> +	__u32 size;
>> +	__u32 vdevice_id;
>> +} __packed;
>> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
>> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> 
> Hello, I see you are talking about the detailed implementation. But
> could we firstly address the confusing whether this TSM Bind/Unbind
> should be a VFIO uAPI or IOMMUFD uAPI?
> 
> In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> behavior so they cannot be iommufd uAPIs which VFIO is not aware of.


What will the host VFIO-PCI driver do differently? I only remember "stop mmaping to the userspace", is that all? Or, more to the point, what is that exact thing which cannot be done from QEMU? Thanks,


> At least TDX Connect cares about this problem now. And the conclusion
> seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
> VFIO reach into iommufd".
> 
> And some further findings [2] indicate this problem may also exist on
> AMD when p2p is involved.
> 
> [1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
> [2]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/
> 
> Thanks,
> Yilun
> 
>> +
>> +
>>   /**
>>    * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
>>    * @flags: Combination of enum iommu_veventq_flag
>> -- 
>> 2.43.0
>>

-- 
Alexey


