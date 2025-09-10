Return-Path: <linux-pci+bounces-35855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 854BAB5205B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF007A43C8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B566E22422A;
	Wed, 10 Sep 2025 18:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lbEBT3OB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403E2C235F;
	Wed, 10 Sep 2025 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529614; cv=fail; b=UBbsyp0NKyQY7Qo7YgO/yffx8PW5iykHEy8WogfCxTm0MZunGzvxPQzeZjVPpbDEYKqk8U04m7oz1gtpmsef/B9Cp3T/hMEI3np5iACuohz+FpF6MqA+AbBQQfGMTtgok/NQrhKu6rqPxgV9CdbRtAplleN0zu+fBCn5aTqKfr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529614; c=relaxed/simple;
	bh=pVCL2gTaA6EfZ0KZO1lJJeacg2X5masyBlSqlmfgJnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fBabPvW3ZtzDptgoJlt4UsUJzf+znrvcC61NIEynqPHE0tvlZ17YwEEUu+8AGAhB45obxB6A4HcbTFccZSxhlYzCGmnYC6wDOY5+F/H6YAMe0ySHsyff5cWQQyPO+j2IUSnmBJFGzWVgYwtHZdTjuLDNdsFG4hicnp0cTpDmVUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lbEBT3OB; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/4cRDuQ96BoUzPWk90aBVywcxI54Qu3yeFXrcfo68hP7+FNFUXVgryOWUhHLyqQULH4tepHbYArMZcRB4ZX+dpqAnh2t1ZcF0kFY88FhihP8XspO+y701B/JhrG1cDbj9IUIlZiPcaQxg0AgBR8CoicsD36jmHpiPTEBhWG8yctG1Z+Mso5j3BWWddfFJRaN6RP8nc0DlHTNgqzlQ755yY6XhxMo9zcRdV1cY5cB842EByXqB8rW/zhTJT69RcGQ8UrfsyS7HdqlE7zb6OOTIjWEXwMjXLdScilHYPutkhGcw1sJF8qw6jx0lDIELLyqVYDjyur51OR4PvZesrmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9vFykbZnMEDl9F/zdzOScbrY1mzEqiZIWNtTSW1NcA=;
 b=YpTRH62q2/+CncWmLSHNlAUt35ia/vaqLoUtR3/rLG08tLoZH/i/jLQx1N9b75qUwaA+VyK548z7O26yCKE/qZCFjtFUoFbUfJK525NVL7gECKqCc4A9/edBUG+ZtjVDzjpXyASuSPNcWvqId3ONyvSH7EwwzFG/05ly9XpXZ4FowiaHrs+ikGaB4RyEuyoF29vRlLPaMAQ5ZTdH1pz4HH9Q1NWplg1h2UprdCzvrdvZcR2RnhbfuRwQfL9Qc80A5keF93wa2+gAE8FEB/hDIZSUymaIy15/xM2yaKZ/3ey9IN0VN8S6Ya1wLlgy1zX5+nbf4wfF2Y5Ole9xj6Fqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9vFykbZnMEDl9F/zdzOScbrY1mzEqiZIWNtTSW1NcA=;
 b=lbEBT3OBSSmAO7DoSAmWi+aWmCIhtRI4mInhT97HzqiRU3V6unIKwXOQdfGBx3E4bRZHEBqJsITWf62ZwRgBlantdfsOuCIdP5tEA00iCZpXiTn2acTOdnKGdN2lHiNOvpoikPWwxI+4bUVQNKg4hIJDF2NdJGu8Ove4pgYvTrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 18:40:10 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 18:40:09 +0000
Message-ID: <69ef452c-f31d-4955-9a93-5381dbf39ca7@amd.com>
Date: Wed, 10 Sep 2025 13:40:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 15/23] cxl/pci: Map CXL Endpoint Port and CXL Switch
 Port RAS registers
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-16-terry.bowman@amd.com>
 <d327d8c5-0633-4556-a021-56afff421a64@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <d327d8c5-0633-4556-a021-56afff421a64@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::24) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: 906d402d-245a-40c2-fb15-08ddf09977d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2ZuYk9GV0hoWE5iYkt1anFmbkp0Z05Zamk4aldJNlVaOENjMzlhUlk3Q3pL?=
 =?utf-8?B?SHhlVFdaYjBUd0dXd0ZaT0dwNHMrYTRHTDJxT1pEbnp3UnlWYnB3dVljSmtz?=
 =?utf-8?B?d3FNSXBIeVRPZjdEcEdhZFVSUExZZWZ6SmpjL2p3UEhpVFF2Vy9uMVFuUytr?=
 =?utf-8?B?OXZ6N0RNVDFEb2hIbGJZT3FjTlkxRTJYaVNkRmU1UUlSZG1qVmw0UEpndU1a?=
 =?utf-8?B?V1JOSmUrdFRqcktzbkV3MC9nejZQMFJybnVhNDVEa3Z0Ykl0K2lYTjhEREFs?=
 =?utf-8?B?b2RMWFRub291WXRWaWpNL3h4VUU5SXJpYVJ4d0FOVERvOXNjdlpGZG5uL3pP?=
 =?utf-8?B?MjRWRHRJL1dJdEd3UlMyc0xmM3RyaXNuYVBmVk9rNEhwMTE2dVlIWGhwTDV3?=
 =?utf-8?B?VGZmaVY5TzZ1Z0xoYjA2SkdLMGdvY0g1eTlSeTJMaUc5Zk9DV3lpMUdLTmhR?=
 =?utf-8?B?ekI2cmtIVkdPOGZYcldGUml3T1lZdUZDeFlzcDk0WklEZ0QzalZYN25kdklU?=
 =?utf-8?B?NGV0OVowalVJaW1BT2ZCTDRUL0JUUlo0VUZ5VkYxVWJwQU9IOEVTNGFEV2dp?=
 =?utf-8?B?UVJCSi9obE93VEFaUUJmdXF3ektEU2hCUm96WW9kMWdrUmIzNG96SW9RcFJr?=
 =?utf-8?B?UGJVMEh0aGVxTWVIV0F4azA5UzhCNmNhaW03WGZ5OC9SS0pEeFZ6a1BsV3VE?=
 =?utf-8?B?ek9HMFhlMjdEaGJ3d0RMSjJabml3UzFpVzI1MFUyK0lSQ1piMFpIRWIrS2R2?=
 =?utf-8?B?dnRaWlgwdHNYbEJnejNmbkRQdGxzQnpZeFNueEpnRW9EN2oxYUJBTTQvYWlQ?=
 =?utf-8?B?OXJrWXFvWTRHUTdRZCtrQXQzRy9XOHVCYXpVbnFqOEE3bFNJL3VOQm96R3NS?=
 =?utf-8?B?aUVLd1AveTJnMFdJQmlUMnJZdjZ0NWI5QVE0OERQVi9uVm5CUW9LeHhCbXU0?=
 =?utf-8?B?clJmcHRGRzJlRDhhQ1ZtSzkreG9Hd3ZaU0pZemVmTmQyakU4YnU5WTVld3NF?=
 =?utf-8?B?THdseUJWTWh1K0hoN1VDT2pnYVRtcTNRWEI2cjgzdEpDYVU3Nzl1Vk1Qa042?=
 =?utf-8?B?VlJtVEhRSmtpaldxTlJ5NTFNN0dRUW1KbThTNU5pTU9rTWRjRmdaS09FZ1I1?=
 =?utf-8?B?TDVmaEhGRW80OVYyNFNibTh1SXptTUE3alF4Y0pjNmNseFF4bXNVUkkzZEta?=
 =?utf-8?B?bTNiQUsvckE3Q1BuOTd4VzhBQ0JCbDMrYkNTVUJBWUdjWEM1eDU1R2hHUkhG?=
 =?utf-8?B?SXppTi9ydmFxOVYxOFYvTHdsc1FESEVTVXVwalNYbXBUOUJwbUtHU0Y2NHY4?=
 =?utf-8?B?aEJTeWNIcmhFZXFYOUgrRG1uTEhHU1hhUU5zL01YUEpOeEorTkRreW5keHRw?=
 =?utf-8?B?alE4Z1VtcWc5ZUx0YnBKZEJVWHhkVi90RFpUWTVKZTJOckIyRi9oR0lZTm1P?=
 =?utf-8?B?ZUVBZi82S3orb1lXdDRZdHlVWkp2VXpEdXZ5K1BrbnpRZnpwQ1hSaEFSL3hJ?=
 =?utf-8?B?QWZEaUtQaFdvMjlsTDBXTUNqeEdnSXZ6VnUxY3JReGdsYWY5YlhoMGFMMXlp?=
 =?utf-8?B?amlQQnZTRHZ6VGczZVZFNyt0QlphaktWQmtuQjNnWE93dWZ6T2VkTmpadTFX?=
 =?utf-8?B?dGxZZ1dZaExYQjhTa2xtWEFQbS9zbEJOMWR5N2JWbFhySnM5K01GempUclU0?=
 =?utf-8?B?eWZBYXlweFUyYTFIQUVIZGtZVmI1RzA4OUtmNXdOVG9jSDZjL2dOKzJNRE82?=
 =?utf-8?B?aTBmK1EycjRaTkJqa1JBL2JxajJIQTIxOS9FZkVLUkl3bXNxM0N2Y2xOZDhi?=
 =?utf-8?B?dUdtZHN6NU9PU3hTRkFyaFhqWUdIVlhHZDR0czduWDgrbUlrdEI4d3Q2UTF6?=
 =?utf-8?B?eDgxbDJkdUd5MVFhTnJ6UU9ITFJ2YXJ4bmkyYkpVOHVzZG42N3p4cDVYc2J3?=
 =?utf-8?B?M0pkL3pKV3RyWVhCMDFFWVRTckluNmtPanFPUWtSN1Q4VldqUlFGNmNwdklP?=
 =?utf-8?B?ak5Pd3pNNmN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THlmVDFKQzBpcThQWVRIT0RRaHI1Vk9QeDljc1JGYWNQVDc1d3EwS3U1TkQ2?=
 =?utf-8?B?ZTJrYzRyTVltcjFNcWhyMjcyRlJTQkxCcnE2SjF6U0NtNUY1SzhxMldKM2Qy?=
 =?utf-8?B?RUhiR3ZUNkJKMXdXMjRzL0gyZGxMQXBMSkRQUGhKQ0l0eE1CcHkrK3FCcSs0?=
 =?utf-8?B?a2lNaEliYk1pVnJEMXhsNmpvRFJzMThVdUpvc2JiemRVK2RiZVgyTkdTcEVD?=
 =?utf-8?B?UmxlSExPcFdlQXZmdGs0SUJqYjN4Qm5NS1VVZnd1bmdtVzcrNTkrMVd5ZnVZ?=
 =?utf-8?B?bi9ZMVQ4b0lpWUw0KzZGVEJ0MWY2WUtwUkxsWUJUK05NUXNMbmRZVVRWb2No?=
 =?utf-8?B?aEt4UlBVem1tcmZyUndMZ2lRWjIvWHE1UFczYnZvWE1SZndnczVrbXZIYWIw?=
 =?utf-8?B?VzdJQ3oxMmRzQmlYZ3BXcllyOExWUGdQcEVvK1hjYmd5anEvRzVmTHJEOTZ5?=
 =?utf-8?B?Rm01VzFwU2FHYnljelc3eGxnYzkrUTlyY1Y2aCtaMWpWTmhlUGNGbmFVcUlt?=
 =?utf-8?B?WlJja0p3NWNjYytKSmtxYmgwR2tMNUxVZjlvMGJpSTZJcnNhem5KUWRsVXJY?=
 =?utf-8?B?TG80S2NVRWY1SGY0UUF2NHpZb3ZpZWowWXMxNEx1N3BxZVpjSU5DUXQ3ZWRL?=
 =?utf-8?B?SUVtQmlUSGdIOVZwVytPZDZOQ2kwZWtkbjI0dnZETzNMbXRqWDE0V2dGYVlD?=
 =?utf-8?B?c0hTcDV0TWpkZnE3a3pEU2JlWTZKVmJoRE5RTmFvWnJ2SGEyWUFkc0hTMms0?=
 =?utf-8?B?a2F2TXQzQTY0SFc5QW8zaHc0ZnZiNSsyUDZlR1ZRZTIxSDk5QXJ4NUVFQ3hW?=
 =?utf-8?B?emlZYm5acmpZYURyRGRhQ084UmVtRnFBdjJGL3ZaOTRQMzZ4ck9TM3d2ZHly?=
 =?utf-8?B?T281UXBia2hoVEF5YTNhYy9BZDhaY3o2eW1aMlo0emcwK2xueVg5VnZ4QW5s?=
 =?utf-8?B?N2g4djJJWHg4T0Q1V1dIdDIzZWdLdkQzQ1JXT2tXTXp0bU1NZlYvaUhkT3Za?=
 =?utf-8?B?UTZWODRCbjNvOHhrYWYzT0lOUDcwWUZtZzJ4UUJXK1VNUU15SVNicWwrRnAx?=
 =?utf-8?B?N3doUVdLVFg1Qi9XM2dUWHUrWXg5VWVqU042ODMzSjJpUE5abkN4UldjTFkx?=
 =?utf-8?B?b0pvRjhWTjZTa1VzL2VsOGNmTWtrY2ExaVRWT2MrN1pCRzlWMmgxd2l0cmg1?=
 =?utf-8?B?MGo5VmFuSWtjMzBVRTZDbnUzaWM0WWRlbi84N1pocWZzTFRndElZTmZrQnda?=
 =?utf-8?B?dU1uVVkxWDcwcU5EQ1Vrc29VMEZqMVNRbDVmTnpOelBOYlRKRGVnUCtkUFor?=
 =?utf-8?B?bkxPWXB0ay9rL09sVThOdTJCL3lpVkVBaHdqamVnSExTTjZSK0wwR1RSY3ox?=
 =?utf-8?B?U3czUEJXNS9LdjRpSG13dWZiemxMeHpYWHYyQmZBTzJZcXNOUituNFlGZUpx?=
 =?utf-8?B?RmoxTHpzRUhOVTJ1TkJobnFUTFNVM2ovRnNSVzRZWUJMVWduOTFwMnhzcWxE?=
 =?utf-8?B?SVY1Wk5NUytHOHh2YnhMRTdhdmRKU0J3SzJ3YmpFZ3lZdUJMQjVTSzMvQWRC?=
 =?utf-8?B?Z3oyNndiTjdJVTFSOEV2ZmdJZ0VBVXJLenhHVGpmK0ptdnB4akxGUFRBMDlO?=
 =?utf-8?B?T091V0VmbXpxZW1qbFRSaTRoNW9oUlREbDNqenE2VHdxcGVXcTFzdTltQ1Ju?=
 =?utf-8?B?SnRwcGxicUdHbldVS2VzVUVKcE5sMGhXOXNPNVBCN1U3L084RDhHM0lES1Rl?=
 =?utf-8?B?Z09yVkdjWmViYmtGTy9PVFFyckF3SVNpN2pUdWJkYW5yMkhXeXVBaW44R1JU?=
 =?utf-8?B?c2ZoazdEMG5OM0ZXU2dCTUFSaU5KNHJmSHhBSnR5Y0lrRHZ6Z2xObTNyK05P?=
 =?utf-8?B?aDNYell5OTBXNFlyRVdFR3lnT3p4YnZwaVdkcUhaWlBiTjB6OFRKNkZFSjdN?=
 =?utf-8?B?NXhiYlhxeUErRDh5WjhpcHBvT0NrZHFxS1JRaVpyQ081VUFuZ3cxQzllbXRl?=
 =?utf-8?B?NUp0OEs3RTdjOUEvQkMwSDVTNWVzRHNjaXNlVzVPSzNwVG94RWRqWmJOaUd6?=
 =?utf-8?B?Y1ZIbFRxa3R6a2Y2TTlVSWtUZHNkcmhUUnJIVUJDd05NeUd6NUZteWEzUmJ1?=
 =?utf-8?Q?vr6NATTX2FgDB6ZBR6SPDDhmI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906d402d-245a-40c2-fb15-08ddf09977d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:40:08.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bmG4K9ToCDjqJkbTI3dtj9LvK8fASStbT5Y4/+/wfOoHxp9fnN3E7haEv7yV/zfdYCKLciF6qxEx7dCk72BtbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666



On 8/28/2025 6:05 PM, Dave Jiang wrote:
>
> On 8/26/25 6:35 PM, Terry Bowman wrote:
>> CXL Endpoint (EP) Ports may include Root Ports (RP) or Downstream Switch
>> Ports (DSP). CXL RPs and DSPs contain RAS registers that require memory
>> mapping to enable RAS logging. This initialization is currently missing and
>> must be added for CXL RPs and DSPs.
>>
>> Update cxl_dport_init_ras_reporting() to support RP and DSP RAS mapping.
>> Add alongside the existing Restricted CXL Host Downstream Port RAS mapping.
>>
>> Update cxl_endpoint_port_probe() to invoke cxl_dport_init_ras_reporting().
>> This will initiate the RAS mapping for CXL RPs and DSPs when each CXL EP is
>> created and added to the EP port.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>> Changes in v10->v11:
>> - Use local pointer for readability in cxl_switch_port_init_ras() (Jonathan Cameron)
>> - Rename port to be ep in cxl_endpoint_port_init_ras() (Dave Jiang)
>> - Rename dport to be parent_dport in cxl_endpoint_port_init_ras()
>>   and cxl_switch_port_init_ras() (Dave Jiang)
>> - Port helper changes were in cxl/port.c, now in core/ras.c (Dave Jiang)
>> ---
>>  drivers/cxl/core/core.h |  7 ++++++
>>  drivers/cxl/core/ras.c  | 47 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h       |  2 ++
>>  drivers/cxl/cxlpci.h    |  4 ----
>>  drivers/cxl/mem.c       |  4 +++-
>>  drivers/cxl/port.c      |  5 +++++
>>  6 files changed, 64 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>> index 2c81a43d7b05..2fa76a913264 100644
>> --- a/drivers/cxl/core/core.h
>> +++ b/drivers/cxl/core/core.h
>> @@ -146,6 +146,9 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>>  #ifdef CONFIG_CXL_RAS
>>  int cxl_ras_init(void);
>>  void cxl_ras_exit(void);
>> +void cxl_switch_port_init_ras(struct cxl_port *port);
>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep);
>> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>  #else
>>  static inline int cxl_ras_init(void)
>>  {
>> @@ -155,6 +158,10 @@ static inline int cxl_ras_init(void)
>>  static inline void cxl_ras_exit(void)
>>  {
>>  }
>> +static inline void cxl_switch_port_init_ras(struct cxl_port *port) { }
>> +static inline void cxl_endpoint_port_init_ras(struct cxl_port *ep) { }
>> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> +						struct device *host) { }
>>  #endif // CONFIG_CXL_RAS
>>  
>>  int cxl_gpf_port_setup(struct cxl_dport *dport);
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 69559043b772..42b6e0b092d5 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -284,6 +284,53 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>>  
>> +static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>> +					 struct device *host)
>> +{
>> +	struct cxl_register_map *map = &port->reg_map;
>> +
>> +	map->host = host;
>> +	if (cxl_map_component_regs(map, &port->uport_regs,
>> +				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
>> +		dev_dbg(&port->dev, "Failed to map RAS capability\n");
>> +}
>> +
>> +void cxl_switch_port_init_ras(struct cxl_port *port)
>> +{
>> +	struct cxl_dport *parent_dport = port->parent_dport;
>> +
>> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))
>> +		return;
>> +
>> +	/* May have parent DSP or RP */
>> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
>> +
>> +		if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +		    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))
>> +			cxl_dport_init_ras_reporting(parent_dport, &port->dev);
>> +	}
>> +
>> +	cxl_uport_init_ras_reporting(port, &port->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_switch_port_init_ras, "CXL");
>> +
>> +void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>> +{
>> +	struct cxl_dport *parent_dport;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(ep->uport_dev);
>> +	struct cxl_port *parent_port __free(put_cxl_port) =
>> +		cxl_mem_find_port(cxlmd, &parent_dport);
>> +
>> +	if (!parent_dport || !dev_is_pci(parent_dport->dport_dev)) {
>> +		dev_err(&ep->dev, "CXL port topology not found\n");
>> +		return;
>> +	}
>> +
>> +	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>> +
>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>  {
>>  	void __iomem *addr;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 8f6224ac6785..32fccad9a7f6 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -586,6 +586,7 @@ struct cxl_dax_region {
>>   * @parent_dport: dport that points to this port in the parent
>>   * @decoder_ida: allocator for decoder ids
>>   * @reg_map: component and ras register mapping parameters
>> + * @uport_regs: mapped component registers
>>   * @nr_dports: number of entries in @dports
>>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
>>   * @commit_end: cursor to track highest committed decoder for commit ordering
>> @@ -606,6 +607,7 @@ struct cxl_port {
>>  	struct cxl_dport *parent_dport;
>>  	struct ida decoder_ida;
>>  	struct cxl_register_map reg_map;
>> +	struct cxl_component_regs uport_regs;
>>  	int nr_dports;
>>  	int hdm_end;
>>  	int commit_end;
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index ad24d81e9eaa..a6da0abfa506 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -84,7 +84,6 @@ void read_cdat_data(struct cxl_port *port);
>>  void cxl_cor_error_detected(struct pci_dev *pdev);
>>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  				    pci_channel_state_t state);
>> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
>>  #else
>>  static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
>>  
>> @@ -93,9 +92,6 @@ static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>  {
>>  	return PCI_ERS_RESULT_NONE;
>>  }
>> -
>> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>> -						struct device *host) { }
>>  #endif
>>  
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 6e6777b7bafb..f7dc0ba8905d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -7,6 +7,7 @@
>>  
>>  #include "cxlmem.h"
>>  #include "cxlpci.h"
>> +#include "core/core.h"
>>  
>>  /**
>>   * DOC: cxl mem
>> @@ -166,7 +167,8 @@ static int cxl_mem_probe(struct device *dev)
>>  	else
>>  		endpoint_parent = &parent_port->dev;
>>  
>> -	cxl_dport_init_ras_reporting(dport, dev);
>> +	if (dport->rch)
>> +		cxl_dport_init_ras_reporting(dport, dev);
> So the endpoint port probe calls this via cxl_endpoint_port_init_ras(), and if it's RCH the memedev probe also calls this. Trying to understand why it happens for both drivers for the RCH case... 

This is legacy and I was trying to leave it intact without changes unless 
necessary. But, it can be cleaned-up. I can remove here and will leave the 
call from  endpoint creation in port.c for RCH and VH. I will add an RCH 
check used in discovering the RCD endpoint parent correctly. Thanks for 
pointing out.

Terry


