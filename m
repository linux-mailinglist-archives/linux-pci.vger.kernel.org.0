Return-Path: <linux-pci+bounces-27148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7CBAA9217
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 13:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60D0B18952BD
	for <lists+linux-pci@lfdr.de>; Mon,  5 May 2025 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EFB202C3E;
	Mon,  5 May 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4f6NVRnl"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61A3596A;
	Mon,  5 May 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746444836; cv=fail; b=okkhgtYKK4Je3WQDd/6kU2vDICu1GySm0p9eAYmZquJ3Q8ny/aB3PZY1le/QZ2QBYkDLt+vAii3Nlqh3CEtZlQcd79pMSpJ/D9nPcf9KLS/Eh6Qzl3iCqwtMIL9ODIMbJyS6T5w3ZYQEIWVhuP44OKhFgArvEg7s1XAxuGUgLuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746444836; c=relaxed/simple;
	bh=QOMfajPo2+ezes/9gRo4d8SyA37LQB+BcGEv+Q/+R1o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HZEOwvqcQKYuOgUqhSq0svmOB4N3V0PsbPPcbwXsvfX/zGrnrGMhfxjcVCWXZtbvR+zCOEPnaMtopCSbqeDebnrtevMmQem/Pg8WccQ94SD4H1l/Ul3ujSuHcuDB1hUwZ2OoBPKXBjmmjAFlx4omRn2lWNiwAkl10ZU7CDVdpPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4f6NVRnl; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjMaDUN9mBWFm+9uzeE+VK+FbjVfVnN6TWqvM8nAaEErH5N3hYf111mugIJnW8NCAPj/Qep4w9gHwF2lsutnOqMSJyiBVht7Caza8hrvTaMwueyfMaGwtOdwW2GzrUWgr2oxy+dj8BxvjxDEc9dYcio33mg8ieQu2pxMeAnsJpE83Cfa8Sz4bUuVXHnTJ4BgXREzK65x7HQLyRX2T+Y4Q/VhizNtGLvPftnLo6scMILqNSFJpPDKdHJOkv+YY35DMdD5SkBD/trfXL/5Vh7KE+E1Qcp9VMhYxNDFMISBAudL5C8eiVzF+tp3tQoc1tzbZGdklO42bTFLVrZMpFoeaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0POv2tbu3vz7bfDW1VSuOZO6QxF9LYCMDiS95DxOQAQ=;
 b=q7+SzsAJXwcePfWUoj49IJqCuPbq8KQZiDQ2bgqJ6kWkoMELC5+ny0o1xUnf/k+BnYEKll7CLULcsr9qvoB4vYD4GEFgnV/zPTVN4x7zE64oisyu1EkVDFvI0G0/ZoLn25e5ZAUVYCrOsGAyw+QfnOYBFd2gsw65pVcYwtMq9GXkPMEDWHNXsB47ZvkafRgiZ9WYlSxMkzlUDu7L9ZZLB9J6i4Amyu5pTuv8Gbdo1KPS2dpjsItOxiRyV4aJf0wn6pU/FhtVr2n0yraCu4EhNDVTrs+I1HSgvsGWNlpsZpZUxKIgrW7m4y0mKiCNSnC/nyNHoO6yrL/d+T4KswJvqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0POv2tbu3vz7bfDW1VSuOZO6QxF9LYCMDiS95DxOQAQ=;
 b=4f6NVRnlqWmu31XQ0IcGuecPu4sb7rHsPX+zGTse7s9sGbVTDH+Cl2Yj8xz6y7ZKTd/TbDvJKoe3D3NBhKNaTdf3OOrncuCMJwQwfj8lb19eBM8CUGK7M58CGDSzln8qS/8unJ4uPHOvQmEYwJIb1hy8QE7xWtes9Pj7aTQVSPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PPF0C93AC97B.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Mon, 5 May
 2025 11:33:53 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 11:33:52 +0000
Message-ID: <cb579c8f-a9a0-4ed0-b0ec-77282fc82806@amd.com>
Date: Mon, 5 May 2025 17:03:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250430025426.976139-1-tdave@nvidia.com>
 <85cab331-d19b-4cd7-83cb-02def31c71ac@amd.com>
 <5b74482c-38c3-4720-81b8-67c599184e39@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <5b74482c-38c3-4720-81b8-67c599184e39@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0025.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PPF0C93AC97B:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d06e04-4f4f-47a8-cc46-08dd8bc8b656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akNzY2o4ck9ta05OQSsrZ3FSRnJtRGFERVhEVFIwQTRLUFN0ME1GNnNPMDJR?=
 =?utf-8?B?a2pZSTdaendtREN2WHV6Rkg1WGZ1bysyVDJ2VlNKc1FLRWhLRGhVajQ2MElr?=
 =?utf-8?B?NlV4dXp3Uy9wbFo2aGRvWFB1L09CQlFSNlN3VkVFWVYyWDBIMEMyLzBHNW5m?=
 =?utf-8?B?QldlMXNMeVNmamI4Z0ltUjhOdHVLbDBZaFRIc25YY1lpVGxkdVZlaVcxTHRI?=
 =?utf-8?B?QytSY0NPV2pTRWpnL2I1SGtlTmErRlJJOHdmK0huL1FlQ2VIcmxzdEdlcDdn?=
 =?utf-8?B?Q3NNZ1dzeEVXb2l4L2VYUWFrcXVNdm13bkZSUGI4blJrMjJYSnFpeHd4R2or?=
 =?utf-8?B?NEY3TWF2c3djbGhGNCsrSG9hUnFEdWh5aWtNVVlqZVpQNGttUXY2M3ltWkp2?=
 =?utf-8?B?bWlvYWZNQjZpd2NWMXhEVXNUclN6S3NXMjhSMGJEb1c4RXNZektyN3I5Zk1m?=
 =?utf-8?B?ajhPT0FnWTJwS1M5NFN3c3hPZWRNRXIxZ0RqdXlkOUM3Zk13NGxYbGtzb0V0?=
 =?utf-8?B?NHZ2elUzallHN215WG1lZzNic08wRXdGUzdUandlOEdKVTZUNDRPekVUdVJa?=
 =?utf-8?B?WkxHdTJha0VNcGRKbUZtNVkzQy9jV1JHWUdCa2RrKzkrZEwxblYwd2Q0ckI1?=
 =?utf-8?B?WENUMURRSHEvYWV0OVppSmZFcWFIZGREc0VVd3VST21sellUTVFRNldlT1dT?=
 =?utf-8?B?N3RIUFVyaFcwM3JwNEhzUmo4cXZDTkp3MGtNNmdWK0FVOVFBNlB4eFFYYW4z?=
 =?utf-8?B?VWNXSDNaQmVrb1VudWsyK2VKU09rcGpkMGliVjM4NmNNWFR0bG04blhMN2NL?=
 =?utf-8?B?K1d5WUlscXJzaGZPazVCUG56T3dpMURqelo0YnozVDgxRStIRTA5SlpkZWVC?=
 =?utf-8?B?UGdBR3ZsbjN6R0VpVDJJNW9ITmwra0tFRy90ZmFhWEtydWlRbjhNVjlJNjlr?=
 =?utf-8?B?Y3hhYktOQ21mSGw4MGV0MGYzYVJsZHFMblAwVG9zZkIvdG5YaE9rNkxzWTBq?=
 =?utf-8?B?UUwza2p0RkQ0RWg4STFRMXRnU1JuTWl6WHBaZTk2QzAwNlBLNXdKclQ0alpn?=
 =?utf-8?B?SWZPUHFxcGZxOWFQWmNNb0Nqc0dwU05vVDR5U0hVVkNacjhWZ1R6RS96QmxY?=
 =?utf-8?B?aVQ1NFlPcEZabmFUbHpscGNGLzJ3S3lqQVNKbEI5cWdqMkhaaVdnNkE5akhO?=
 =?utf-8?B?V2FHYXkvNUJDdEs5bkExV0VyZCtEVWhhMDJzdEFUQS8vS0lDUHIwSUZrUWxJ?=
 =?utf-8?B?cDlwcHQxRENzdkl3Wlh2by8rWTl6YjVxMXZlT29qMEZJalpmMDdEOTRqU1Rh?=
 =?utf-8?B?YThhNlAxcEtBcG9qekh3MzR2Y1FVM1hINm9yQ0RCV1gwc1pqb3JLa1NTTGh4?=
 =?utf-8?B?eU5PelFVMzZGc3FpTWV6dk1UQmhnY2NZTWQvbitsNzAwbVJGRXd2aC9OMVc1?=
 =?utf-8?B?K25vTVdhdzF2SU9FemhwODJ1WUNKK3FBSzlaRjJXTGFoeWJFZ09WbzlFQmZP?=
 =?utf-8?B?bllBSjFPMlp2bVZyU0RxVU93NW5wK0UvdStNUEV1UlJuVmdRQnFiM3U2VVlj?=
 =?utf-8?B?VTBzQzlnVFlGSThNZVBldHg2MFBJR0pqK3Y5Q09ZUHdQRVp1Z3pTWDc4WVcx?=
 =?utf-8?B?bFQzRmI3ckJoVlZxSEpPM3BaTUd3aHRSMkY2cktmMGZSMkVTK21TRFE5QWoy?=
 =?utf-8?B?NkZibi9JUGRDaEZ0WHRuZUliYnVOU0tZWklNU1QySFgvMzlqRk1McW9VRmpG?=
 =?utf-8?B?N2hmY0xaWU5keEZrRXU2Z1BtNStQVHlVZ2Y2Y2pwSkdmSm5KaDlVa05CdS9L?=
 =?utf-8?B?QlVLTnRZRWRVb1pJRURxQmNZU05kOVc1SGxESzZDNjdST1M1MDc5ZkZZQ0lq?=
 =?utf-8?B?NkNCRjcydEtFOXIxdncyaVNBU0lJWjZ5dzBrMHlDZkVmUm5CNUV2cVAzNm9B?=
 =?utf-8?Q?4Vlk8NLxJsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1k2YS9TaGdTOTlaREN1SDFDbDBPcmgwNENHeUtrbDZrbDA5Y20raFJwNGZk?=
 =?utf-8?B?ZWlJN0pQb1gyalcrakJhZ0tMMFN0REVNT3dLeFh6OUNaVitCV052QUh6U0Y4?=
 =?utf-8?B?bFdaV0xuU3RQSUpXdlFJQnkwTHBEejQza2ZnOXZMV1JVTm8xdzdzSVVjWng3?=
 =?utf-8?B?WUh1Zmx4bSt3NXpEL2E3dERuUlZiNEo4Z25jNkZLS2E5YWhTNWdCbzMzWXFp?=
 =?utf-8?B?VDNPbjdSbS83blBnSlA5ejVWZDBLY1lNUG5TMW5aQ2hIanV0akQ5dGRwSHov?=
 =?utf-8?B?aTMwR2hhOFJwSnd2Rk81eXBsbHhYQVBSQXdGaTlPRmRETEZNWmk0NnlQY1pZ?=
 =?utf-8?B?L0hTUXRzYW1BUGZMNmZsZE55aTdOUlVNMzB1NmJpNXlsRWViT2hIUEhVV0hw?=
 =?utf-8?B?aUczRDEzV0lLODdjRDVoUGt6L1g5dWxTOUJWdGkyeDMycW1XcjZ3RXpMdUFO?=
 =?utf-8?B?RElhQ1lQUUl3ZkNmL3JOMGtRWHpuNEh5clkxdXdNei9YVm5TUmplajgrMGpO?=
 =?utf-8?B?OExjSHkvc3NYdGkrblo1eFRKbGZaNkx0bC9iS2UreitLRDZrOXZma3BTMmVt?=
 =?utf-8?B?cGh4eithczZwZEs1cFUwMTIvRGZ3bG5KWDMzRTFMV2NaODI4dG9MRXVQb1hh?=
 =?utf-8?B?S1pMVWxOYXFBMk5zbE1HWUNEMUNTOTlJYWh6SlFra0t0U0pURS9JMURDb3h0?=
 =?utf-8?B?RktxL3d2YUF1ZVhZdUZFdDJvcmY3UHRxTU5FUEowUzNMQytCZUUvKzNYbFpj?=
 =?utf-8?B?TXNENEtJSmFCNkVvVDIwL1FkN2lYQ1N3Nmhwak9LSXN4eVIrdUNTeHlqLzRD?=
 =?utf-8?B?TGxkU2RWc3JVcEtFd2tHM3c3WnRZa2wyN2tCZGlLdWZVa3htWmh1RDN5L3Bh?=
 =?utf-8?B?ZTA5NkJJb3dDZmx4bm5VMjk0c0p0UWV4MWFZSnUvTXRFMzlqNnpPRVhmNjEx?=
 =?utf-8?B?UGNkKzQ1dGNpcnpDZHZpMmxRRjV3NmFUK1FZc0wvQkpQVFR5Zy9aQnRIUjZV?=
 =?utf-8?B?TVNvNldPQWUvemoweWFSc2p6NkdDUFdUenBVdzEzbzEzRTRxRTlEdzJQTkYy?=
 =?utf-8?B?dmh2YUJpN2NqZnNjYzJISVk3WDNFeDZJT0hDRnJwRU1PR1lIMmYwV29xTktm?=
 =?utf-8?B?WDFpbnUyMlNNaytReHp4VkNCdWx1dHVoUXptc0hxc2NFSmt0TEVQbDdSUTUz?=
 =?utf-8?B?cDZLMC9XMTJnTGxtWW13ZUZXSEpmeWVXN1RLdzRvK2krVERLQTVoUkI5YWVP?=
 =?utf-8?B?ajFrODZqUUgyd0xVUmdqTFlmditlSE1ZdG1sTGRFQ3B1a0ZkUURrakNOQ0VT?=
 =?utf-8?B?NkhDMFdjOG1UL05LTkpYUUd1cm1lOU8waFcxM3oxYThpVUJRTS9tbDFwYkk2?=
 =?utf-8?B?VUdqeHJ4bzRWSHlUMWZkZ0xZdGxSM3gvSGo4ejZtRm5CMnh4elBhMWwxVHRK?=
 =?utf-8?B?djZOV016VXJJV0E5c2RJdWh6OGJzbThmbzJhRHl4bTd3N3Y5L2ppR056S08x?=
 =?utf-8?B?Yis4YUQ3Qnp1bjVFakd1YVBocXlDUW1xSDVYdU0yTlRiWVdHTTQ4aTBXVzV5?=
 =?utf-8?B?eHArQzZmREpjL05wK1cxOVNXaHVkdkdlMWM3eXlqcCtLUEgvdEl1MXI4WmJ2?=
 =?utf-8?B?dW5lVm5hWkZxbUY2SEFBUk0rNkJUd1hkTHpCQnFhazhhbCsxejMra0pmZ1B5?=
 =?utf-8?B?R0N1T2d6dUVQbVdoeDR4ZGVrdmlmZHlkczlMT3JIQlBmdGhSLzUzUGJmU1B4?=
 =?utf-8?B?N25xZWhUdEJFdjlMRFVjOW9NVzl6OU5IQ1o0OE10OTdYK3ZzUkJFYjJmSFV6?=
 =?utf-8?B?Wm10Nk5lRGFhR29ZaERVazlIL1laWkE0dlpjOXM4ZjN6azR0alRadS9SRHgx?=
 =?utf-8?B?UW9iTlN3aEpuQmpaYXBGd3pBdklSRGNYeDVoaWZUNUNzR2p2S0pia2JSN0tF?=
 =?utf-8?B?MnhXeE92UDRaWjBpYUt4dzk4djVBWHpLM29BM2NjeE94Q2dqOTEwaFRjRCs0?=
 =?utf-8?B?cWM4Q2xSU3JZbVRwQURLWG5JVWMvdjNQZTNVdGdQVnRicXBhQ0RybjNDMmZU?=
 =?utf-8?B?MmRLTVRTeTFLbDU4SCtUMkdndVozUms3YlRjNytITWowd24wblR0TjFUY1Vt?=
 =?utf-8?Q?tHkxXuSse5N+0PFzUppj2i6g9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d06e04-4f4f-47a8-cc46-08dd8bc8b656
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 11:33:52.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dWLE26ffGkyebzspNpxeOvW74WMpdpNPWKgdIZ+t08CPggiC8J0AlrWNyIGpqLH7Ut+GmZRtwsYjOYrwoGaJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF0C93AC97B



On 5/2/2025 2:30 AM, Tushar Dave wrote:
> 
> 
> On 5/1/25 03:58, Vasant Hegde wrote:
>> On 4/30/2025 8:24 AM, Tushar Dave wrote:
>>> Generally PASID support requires ACS settings that usually create
>>> single device groups, but there are some niche cases where we can get
>>> multi-device groups and still have working PASID support. The primary
>>> issue is that PCI switches are not required to treat PASID tagged TLPs
>>> specially so appropriate ACS settings are required to route all TLPs to
>>> the host bridge if PASID is going to work properly.
>>>
>>> pci_enable_pasid() does check that each device that will use PASID has
>>> the proper ACS settings to achieve this routing.
>>>
>>> However, no-PASID devices can be combined with PASID capable devices
>>> within the same topology using non-uniform ACS settings. In this case
>>> the no-PASID devices may not have strict route to host ACS flags and
>>> end up being grouped with the PASID devices.
>>>
>>> This configuration fails to allow use of the PASID within the iommu
>>> core code which wrongly checks if the no-PASID device supports PASID.
>>>
>>> Fix this by ignoring no-PASID devices during the PASID validation. They
>>> will never issue a PASID TLP anyhow so they can be ignored.
>>>
>>> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Tushar Dave <tdave@nvidia.com>
>>> ---
>>>
>>> changes in v2:
>>> - added no-pasid check in __iommu_set_group_pasid and __iommu_remove_group_pasid
>>>
>>>   drivers/iommu/iommu.c | 22 ++++++++++++++++------
>>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 60aed01e54f2..8251b07f4022 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -3329,8 +3329,9 @@ static int __iommu_set_group_pasid(struct iommu_domain
>>> *domain,
>>>       int ret;
>>
>> initialize ret to zero?
> 
> Thanks Vasant.
> 
> How about:
> 
>         for_each_group_device(group, device) {
> -               ret = domain->ops->set_dev_pasid(domain, device->dev,
> -                                                pasid, NULL);
> -               if (ret)
> -                       goto err_revert;
> +               if (device->dev->iommu->max_pasids > 0) {
> +                       ret = domain->ops->set_dev_pasid(domain, device->dev,
> +                                                        pasid, NULL);
> +                       if (ret)
> +                               goto err_revert;
> +               }
>         }
> 
> Let me know.

Looks good.

-Vasant



