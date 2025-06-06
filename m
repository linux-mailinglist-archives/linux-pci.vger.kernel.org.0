Return-Path: <linux-pci+bounces-29076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C531ACFBAA
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 05:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF031780D7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 03:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29635961;
	Fri,  6 Jun 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a6JA4Fwd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E614A0A
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 03:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180835; cv=fail; b=FmC/7qsh5Qg9bYN1ese2PzRhPSzC8rD3XwOl61mPywZhT0YYgXgFCFK02w4QH7Gfsz2CcR1sXlDpVyEEKB0hbEqAp4FD8fbCA11J7WknV3RRmLgZ+nkraxukKdm15OEhueich1JqQU0AzroolSUAARfvMKs/l7MW4B76qnOE3/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180835; c=relaxed/simple;
	bh=zUD8QeSmnESKJrWTtYAJ0tIJEg2CQiFVCP8LFkW5vW4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U0aVxE6llWpyCxiHYMBlX3zww/qDmH+fQbU+UncyvDtIqRqZT48QW4XH+wzvk2fXeoew+6aJg4eOCqYrHJactpQJ+ulXwvdoCg7wWPw8NFNfBqS/LSSlwqZ7lN46yF3QqHRkxfgX6TEVuJDu97BaQYObRQui7Ty/rcUIFxWGzbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a6JA4Fwd; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjjA3hZB5UH+0DS61zNyQOi3UMc2/eGS54nBDs9MEG9whFJ2ixfJdQe77sk3KM/gYBUQXISONGyQqOvyi1V1m4XSReCAfxQW9ipqJPDX7XsvZc9wKYSbn/XgUNMcA+cyXzASPh38b4LU5cOVnTrlcg+zXpmAmqzHM5O8NPo1p8HT1DgOeoVQApqpDbahlAWnQzPOqF9urPNYH6EZpynkuV9tQZEkaIC/nCJ49x15di3e5Ca/jb2ZZQSDcmo7qPaXqtyuRzR0m+NWMoECnaNLAYVM8eFUXUQMpqUMwSvU+BS6W+ONQJ+NuOoRO0H3e6Om/Ga7Rvtq6LiQsUJOvZbHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVsMZricAul99/7Qmjir+DLbwJSe7uD4R5swSG6PjJ8=;
 b=Q0/Nq+fJ870O5NpO4drm34pz/oWQjJKmqp8q7n0FD5Wx+ch7bIE+PL4cb5Wpv1hqNyDUCKrhd4nBDVc5oUVEqQSKLwTqsP35CXXi4koXiD3kcwETdk6jDY5a5aS8JhW6N7tFbKP3n1frV5HAa+wHvkVzK4CYqWJvitDzJkW9YtI+fTMCkx53REF3D2aJfr6aOcFA2yGP1wu8iyUSQmbvwws8TzQCM5bMTBItAoqcaZFyLAz5YokqKIulPhBSWx12Ewyr4r0fxy1dBQhQnvwU9hVsT2Tli5y9Cm49yZtLUYTgVzhaFErz+OWtpo+SDJH4Ppwtig3TMbJuPp2gwQDCPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVsMZricAul99/7Qmjir+DLbwJSe7uD4R5swSG6PjJ8=;
 b=a6JA4FwdNOJj9hqAiaAS5xka+PJDnsfI3BeSsELVkyDhihJ46Or4rFhAh99L/htxVNMParvkQrB0avEGKs+VSzDEvwteyUzP/HVBr+AWfPnBcIubS7+UDjvXPQNu8LKtPjMU0nCx3YeJO6mS4BrmsPcjAOXRkT5aTWIWljiWOWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB6579.namprd12.prod.outlook.com (2603:10b6:208:3a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Fri, 6 Jun
 2025 03:33:49 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 03:33:47 +0000
Message-ID: <b281b714-5097-4b3a-9809-7bdcb9e004dc@amd.com>
Date: Fri, 6 Jun 2025 13:33:39 +1000
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
 <683f965d41634_1626e10043@dwillia2-xfh.jf.intel.com.notmuch>
 <20250604121437.GB5028@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250604121437.GB5028@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0148.ausprd01.prod.outlook.com
 (2603:10c6:10:d::16) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB6579:EE_
X-MS-Office365-Filtering-Correlation-Id: 563a6550-f3de-4c11-f79a-08dda4aaf215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVZuZEJaSkk0VEhKYjl6THA4UFJyU0hkNEtwcmtSZEhxTmFyaE95bDVEUWUr?=
 =?utf-8?B?VHo1bkw4K3l0d2UrS1drbFA1MmhZNnoxVGhtV242N0REd1pJbWQyTFFlRjBm?=
 =?utf-8?B?WmtiaTlTT2ZlbDJoZkNZcFFkOXpzanBhNGtISUpJY3UyK0VGN2NUbHA2UWhG?=
 =?utf-8?B?T3pWeUQzMTIxMFQyNHB3YVhZNndVWHR1ODluQ0NzQ3V0dmRHY1JucGtWdXVh?=
 =?utf-8?B?Wk9nV2RFZDNuUnk4dTdHTmhZZzZxWU01NGhYZlhuWmY0bE5GM0NHNUdZMDhK?=
 =?utf-8?B?cFZWRkI1Q1JDMXg4NVdXK1U2TkZmQWNVRWtDUEJsNzFRRlJTUUJ0Tk1TZmxH?=
 =?utf-8?B?L0ZFanBtZ2hodllnOG9LZ1FtbEFVRWtxbWE2S2VxekZxZ2U5eFoxMjlVVE0x?=
 =?utf-8?B?SUQrOE1JU0dzTUdNMkdQSHFGdSs2S1A3QnoydVdwUGFFeXN4Q3Bpak5oWmI2?=
 =?utf-8?B?WWlacG90L0crODRBbEJscnEzQUZBN0ZNZ04vaXY5aSt3Z2lhaUNZbHpHc0pR?=
 =?utf-8?B?bUFKTUF1NHpBaFRlSVV4bWtZVS9vamREQ0dsUUhBbFFTbytvc2pGMlc4czF4?=
 =?utf-8?B?Z090aDhTNzg1ZFoyV0JIeXpEZm52bHJtYWRpekNZb0s5bWFnWWhXMUQxVnFM?=
 =?utf-8?B?Sjh1TjNUNE95UnlpcTJSam04OWk0NmQ0MWdtcGRISXR3L3VweXRBK2tpOXJT?=
 =?utf-8?B?Wjg4SnZtbnppb0tRazdJdktCeWtTNjhVMUUzaGJLSHI4UGQ3YUxGVGQ2MnBn?=
 =?utf-8?B?U3RRRWpQVEtveFdUOFRSMnRPa2svZy9yYnk0WFhqVi9LMzdWRllYa0tnTWlG?=
 =?utf-8?B?a2Z4NUdYeVBudmQ1c2RIQzRFUTZoa1RPWmd3NUY4VDZTbHVvV0pvcGFKVDZ6?=
 =?utf-8?B?TU8zaDYrRXpuUExlK3kvRldrZFVmcGJ6T1JtZDlvK0ZEdVgrNTFJbkFBblAz?=
 =?utf-8?B?amZqeVFvVHZvMW5YeElVbG00RWxMbFd4SUVrZnV0V3JobDZZdGhZZ3JFZW0z?=
 =?utf-8?B?S003L2gwaUNhdnRuRnpDSmtTK2VLdmxzNmFCdndlK3dyT1h5dzVKNjgzbzN0?=
 =?utf-8?B?RHhacFlkdEVOcC9hLzZ1YmtvTHVxdFlJQkxzeXB1WUVLYjVGcGZjbUV6WHdp?=
 =?utf-8?B?eTRCTjFwelJ6ckI3ampjcHJ4TmNSTUVFVVlkMzRUcmc3L3ZEdC9FeVUzbXpt?=
 =?utf-8?B?YU8zRXpYdkhUckkwQ1I0ZWcwdDhFUnhDTjFVdmUyR0IrSFBGbElLd2czckEx?=
 =?utf-8?B?dkxLZys1dFV6NktObmtkTDBjeG5tUFd6UlpSZ0NtRnVEVFB4YzVGWmI0WHIy?=
 =?utf-8?B?VHFZZWQ2SWJ1N2p6bnI4ZnlrRm5qNk5aKzEwMlpJTFJjMmtrUGNsMzFkNGI3?=
 =?utf-8?B?T1pLZDJqYUNJd0RYamptZ3lqYXA4cnphZzN3R0pEdnY5a0E5ZTBVT2tObnlI?=
 =?utf-8?B?R215U2JXRTl6b0dsT0ZPR1Nkb0xHZ29YKzhPdkRnd01vNGI2L1I4enJDWFZH?=
 =?utf-8?B?RXBlRUZxVFJKaFRQcFlCZUJwVml4dG8wblpWVzNST2xpdHVlZ1pFaG1sNG1p?=
 =?utf-8?B?QXcyVUs3ZnZIMDN4eEVpZVFhdU13NHBhTW9DczVBV3lFQUhxOTNpR1FMaWFp?=
 =?utf-8?B?U3VYM2x2RFEyUkhrWHVtNGVmTk9MTEhSWUN1Rkh0aE1lMlZDeXdENkVQODNh?=
 =?utf-8?B?OVBVSGxCL1dZdUtLSVA3WkVTdlNuMkVSNHdRd2ovTk5xL3Q0L1g0TTcrVEY5?=
 =?utf-8?B?TkVwRjU1M0NvUUVSL1hVR2Q0VUppbjNqRTJ0ZUdxc3ljSjU3dlZjYStSUW04?=
 =?utf-8?B?L1RNTWhHeFpRWlorcmxoYi9EdStLcUhkQ3d0RFNVaG9EbVZhYS9LanNuN3dV?=
 =?utf-8?B?UjR4S3h1RURrbjRFSktRc2M1QithTnlJWjlvVFdhbld6V0o2bkpYUFI2a3Ja?=
 =?utf-8?Q?frLuAJTVuPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmQwMlJjQ0tsNEhWNTA3RHA2Tks4MkpwU3BGcTQvOSttZU5BdTdtSHFpdlVa?=
 =?utf-8?B?T1FQTE0rV251WnBnRS9uUW1BNDAvMGh4SnpodlhNZUVaYW5HVk5NZUlocUpH?=
 =?utf-8?B?NjhaVE1Sc1EwV1c4UGtxMVFxdUtHbloveG9vNW55VWpiM2NNNVhSM1V5N29J?=
 =?utf-8?B?VkpjUEttcThJQklhMEV3N29sZDM1alJSWlphczYzQ0kvVmVKK3NUSE9XYnRD?=
 =?utf-8?B?VFV6eEJXWmlTeXVaWVpnWHZqWTNid2o4b095dnQ3TVFNT0VZZUJKekJaTnB3?=
 =?utf-8?B?WmtHVjQ3QWZKK1dYZGZxckZTZTdzMm9nbnhvWE5QTHdQQ3Z3djJkN2VSM2pq?=
 =?utf-8?B?NHNWS0g4bzZsTmVEWlRId25EaDB0NkpsYk9ySUE1MVRJdTVzc0cyRkE4b3gv?=
 =?utf-8?B?RnJGUUxLVjhHZ3JNczJNckVhR2phQ2tubk92ZmwwZ1FKOU16VGxPbllLWUNq?=
 =?utf-8?B?UUhXRzhRdGtlbmZBZW8rQlpnODFSMUFHbGNuTW9xV3NyYUVnd3ZEOExadmZH?=
 =?utf-8?B?WThrSkkrQWZhRzBEMWh6UUxtbXF3R1dqOTJOYThuaEJuQytFbGFXSGVKQW5P?=
 =?utf-8?B?ZFpzMGVEcGJoS2FBclpVbE1tV2FOb1NvUUNYRXRoWDZ0Rm55WUVxY3pHNm43?=
 =?utf-8?B?Q05DNll1a0dIaVZUQXhtUjhIbVNKd0crUUgzNlEvL2ZkMHQyYU9qcVZUc3Nw?=
 =?utf-8?B?RjQ0aXVYKytMa1JnRU5ZdzM3cDV5bWMrTmZraUxoOFl6SGdTWGtlVmNRcnV4?=
 =?utf-8?B?bXlWMlVod2ppNyt2djc0clJDdHUwYjhEMEc5am1saXlwNjdtc2RQWk5qSTVs?=
 =?utf-8?B?TEFsNHRtUSs4WlBPNVRxTjNrSmNkOElUTjg0emcvRmFNU2F0YmdaNEU1QTJQ?=
 =?utf-8?B?Mko1MUdNalZRQnNsbUFmb0x0NkpaYTdBbGR6c1docHhPVkR6cjM4YWtjcWRX?=
 =?utf-8?B?SzA2UmVMcHd5ZXdiV1gyWTBiVkozNXRqQzZ3eUJyZzFxclFoTmJ6QnRLODhY?=
 =?utf-8?B?ajNlWTF3V1owODMrVkhYa2FTcmE4OEh5Vkd0czlFWENPT1JnejUyOFppbzJz?=
 =?utf-8?B?SS9tQTFiRGpWRjl2OVpwNEZITWNyY2d1T2xPY1V0RVkwdExvVHF5YmNpRnN6?=
 =?utf-8?B?cm1xdm1CMjJZd1hyU3E0eW1Cb3E4OXFqTUQ1SkhUQldNK0xPeWF2Q1ErT3pU?=
 =?utf-8?B?RlpDbEtMMEFUckV3ekExNVF4U2JjUUVYL0VlS2Q0bDUyNGloVnFBNnFsWWZF?=
 =?utf-8?B?ZWUrV043Y3RhTGNJdjBxWGNPTzRlVlRSL0dHcTlWdXhvU2locFZoWmlJY0hK?=
 =?utf-8?B?MUhUSVlNOU1yNW1TZmxZalJYSTlmMXVva1BpNHFicFh5UGkwRm1KVWE5emhr?=
 =?utf-8?B?VWJIcUVlSk1taTVoLzlteWlXTXF4TTVOQnVoNXJ4Rm9rcUlxdXVKWVNrK1ZI?=
 =?utf-8?B?K2ovMUE0cElIVkxYc2RkL3J5MEJpUkpoTnljMGdCS2xRZVB1NUZOQnFVY1oy?=
 =?utf-8?B?R21zMHRRU0lTZ0h2QnZUVW03WDB3MFpxbURCK2NQZXRMYlBwZkdwUTRSMmdn?=
 =?utf-8?B?YklkemhITU9tVGxUdjNhTm93UmlycEtRTDJWL3R2bGVZdGVtWE1TQlU0S21K?=
 =?utf-8?B?UktJa3pFZGNmTVVVVGtsSlJlTllSQld1UDB3OEpzTFd3Ym12NmdRQlJMRlNW?=
 =?utf-8?B?OUdvK0dweVlmL0ZTOVpzdWJaRW1Wcld6blFCYW14WllhNXVURE1zSXdBQlE0?=
 =?utf-8?B?S0dsOHVpZVN2MHFXM250WWZWTnRqNitRNWJheTljaEhuSVNjbjY2a1lIQ1dn?=
 =?utf-8?B?cUVSSis2NERPT1BZL2xNVkJZVUZ1Nzc0OGlMMnFHTzFETUZESVVyeVdoc1NJ?=
 =?utf-8?B?NHVjNnNGSUhVZHYzMWMxR0NGR0txalhCOG14SC84SGd2bHlQVUlqVEhaclFW?=
 =?utf-8?B?ZzVqbTVka2hTOGhSOSsrRCsvdlExbS9KWHJramVIUTJ3OExaQnZ2MVZ1NnVO?=
 =?utf-8?B?Q1hUQWlHQnJIWVFrampENmJpQWlueVg2YThrUDZ2NzJ5c3pSNmxPdFlyQVBD?=
 =?utf-8?B?ZFBZYkk3NktTczdsUjI5S3VrZlZ0OHJnSmhGY1k2YWJoWFI2OUErelFTMmRL?=
 =?utf-8?Q?eYNpPzCta6KfYUoot+Aq7vT51?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563a6550-f3de-4c11-f79a-08dda4aaf215
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 03:33:47.2576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+MCRA8R3N999Ufl8rE/x2iSPiSAjurU4XtfLpQlgYQfeJq9dCOACvnQrgG51bXpJmzZMe70XrAC3QPD+fGVtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6579



On 4/6/25 22:14, Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 05:42:05PM -0700, Dan Williams wrote:
>> Jason Gunthorpe wrote:
>>> On Thu, May 15, 2025 at 10:47:20PM -0700, Dan Williams wrote:
>>>> +static struct class *tsm_class;
>>>> +static struct tsm_core_dev {
>>>> +	struct device dev;
>>>> +} *tsm_core;
>>>
>>> This is gross, do we really need to have a global?
>>
>> Let me restate the assumptions that led to this, because if we disagree
>> there then that is more interesting and may lead to a better solution.
>>
>> * The "TSM" (TEE Security Manager) concept in the PCIe TDISP specification
>>    and, by implication, all the CC arch implementations, instantiate this
>>    platform object / agent as a singleton. There is one TDX Module in
>>    SEAM mode, one SEV-SNP CCP firmware context, one RISC-V COVE module
>>    etc...
>>
>> * PCIe TDISP is the first of potentially a class of confidential
>>    computing platform capabilities that span across platforms.
>>
>> * There are generally useful details that platform owners want to know,
>>    like number of available / in-use PCIe link encryption stream
>>    resources, that are suitable to publish in sysfs.
>>
>> * Userspace is better served by a static /sys/class/tsm/tsm... path to those
>>    common attributes vs trawling through arch-specific sysfs paths. E.g.
>>    SEV-SNP device object for their "TSM" is on the PCI bus, the TDX
>>    Module device object lives on the "virtual" bus etc...
>>
>> So, create a singleton tsm_core_dev to anchor attributes in that
>> "cross-TSM" class.
> 
> We will be very sad if we need multiple TSMs or TSM flavours (like
> PCI, CHI, whatever) down the road as single TSM was baked permanently
> into the uapi.
> 
> It is far saner to have paths like /sys/class/tsm0/tsm/.. and remove
> the global than take the risk that one and only one is the right
> answer forever for everyone.

In my tree I do just that, ccp (a5:00.5 is it) and sev-guest modules each register themselves in TSM:

aik@purico-ec3dhost ~> ls -la /sys/class/tsm/tsm0
lrwxrwxrwx 1 root root 0 Jun  6 03:29 /sys/class/tsm/tsm0 -> ../../devices/pci0000:a0/0000:a0:07.1/0000:a5:00.5/tsm/tsm0

aik@purico-ec3dhost ~> ssh tvm ls -la /sys/class/tsm/tsm0
lrwxrwxrwx 1 root root 0 Jun  6 13:29 /sys/class/tsm/tsm0 -> ../../devices/platform/sev-guest/tsm/tsm0

No globals anywhere.


-- 
Alexey


