Return-Path: <linux-pci+bounces-29118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7FAD0959
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 23:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802E416E48F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5839D21CA03;
	Fri,  6 Jun 2025 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPVlZSpf"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5052E1E231D;
	Fri,  6 Jun 2025 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749244141; cv=fail; b=skA4nHPHCHZU2wu0J1yL0vJ3zJuDS7/NxhxOXepveS+3QxYMqb2jo0tVnxyOlLQmhdIQt0xV9bGJG5xIefPnwWnkCvmZHvs+ygAJX9+2fnSga6Hbh81lBoYsJ9FyTaR+WPb3RRnLTYK5zjNdjIa1slt/WQRusfSaKpy2FmY7FBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749244141; c=relaxed/simple;
	bh=intUT2F6LusaFPxJAiPFHOZ23OFmIXG2OA03SAxTI3Y=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g4/4DiJRmKHa72mBjv/zKBKchbbQvM13uKZiiUqWUwMNzK3ri2Qnm7bBn9buP9IcYT9rJkpH6cUC11iIMfSWA9mTbEBZfk+CHuqpnSsqebuC6KbfZidfkDZMxnEmNq0KmaQr/nuJNZNNGMG6ehKNiZcT6BNOy2mBKTdSdDLDAv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPVlZSpf; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eR6/3loiZ7dudI4mwZCwUyTeYJOlANq4gIcH9YDiy1+sPj69J6pgXE5Zk9IZvuhLBNfdKX0v28KwM9tZOU0vkB9FmSq1nlal2lC04ZtXLz6vFNou3ifbNh6ZFQKdR1Cm7jStNViH85KY1aP6+HZxIZqNVrix9uah1jbCDjm2+/MmLwL2eo0J+lsMRJ9Titz5ikXU43dhRSqnbC6pPde68DnOlVkUKoPPTlflolm0JP/klBPZ/eMy82YeqTmwFsmELoj6HCL7X2sdZeqKYPoqvPVhvxh+fVYVJLXR+ryxiQmXrKVwEwjzX4hmK+pk9MhM1DfyB8jLPXAe5cgbn6AkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBnLO35yfA9guPwFQtdnEnwoZttiTZZNBVz+HKmUu7c=;
 b=d+Q1SvPxMQRBQieWE4f2TVFEl6z+0vRhYq+wSW2CPiL/FHEK6oHgF2x+ABcowPZImA7HYlmHvKGojPjcfwwl8lY30SrM2oV50o4BgBmLQv+Qmbbt8vvhotqRMuWsymj5i+0TrP+kZ2yHbnA2jo8iE5CtTGNb8sR+xcJ8S5JZ/r1rdQBbIJWbMSpn+m541socAwwVSGcs2bx6MZI/3o+3WJkZEkEMoMkpJSPlhmXPeE6Ch5tW/64HvqXf6utYq98t0JbOoSy//TvTTzqdev1hRnSCOgsxJjbOcKkl9JE3pncMJx2dAOU63QLzLyrCpnYxwLmhsmIN9lRHmn0hSW+pXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBnLO35yfA9guPwFQtdnEnwoZttiTZZNBVz+HKmUu7c=;
 b=VPVlZSpfCtu3m8PvC0895wbQAwFbMbouf73p0S/RLr2ZC1WfmgAyc7pVENXI5KmE9t9o/2gxu1sYHfUAofMsnGgkfk6rLDYP8JAQX7QFYShPSEN+SEwWFG0lXVdBmwRa9envFTuJKj1B65IWJu6IdjhQYtV8tWD2EMbkUv0l+2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 21:08:57 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 21:08:57 +0000
Message-ID: <ead829fc-8e3d-4b9c-a343-a3b7ec1b3e0f@amd.com>
Date: Fri, 6 Jun 2025 16:08:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
 coly.li@suse.de, uaisheng.ye@intel.com,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com>
 <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <81214183-fd94-428b-abeb-3ec3d2688030@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:5:bc::43) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH0PR12MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 3375cec3-896a-4300-2fc0-08dda53e59ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHRWbkVQcVBZRUs1V1hheUFuSDFyWjdCalhjS2xmdmlaTzAyMHRLMHYvNjJD?=
 =?utf-8?B?Z0VhdW1xUHNJbFNpWERBZmlyMGl0aXAzOWlHVExwcVIxUVNlQmVYVnh6eWlh?=
 =?utf-8?B?bStTRThDdTdlUEFyb3ZMZE9mNkhlUXNNUHRXMkJZNGpya1M1R3c1WFVEbTA1?=
 =?utf-8?B?STNQVCtab2hHTGM0MXNMdVBFUlRpcmEwSGoxNnk4UGNoRjcwekxHd2kyb1Vz?=
 =?utf-8?B?V2lkUTYzK0JRRkJtU3pDOVg4aUo5UGJTcDJia2RDRjhKcHVOS1cvMGtHM3Y5?=
 =?utf-8?B?WnpYVzZJa3l2Vks0UW5vaDA2TEY1MU5zQUV1VU95MVQwMWhaL2FCa0VmTVhX?=
 =?utf-8?B?ZktKN3h5TUtxL0FyeWYrdjVybnQ3dU1TT1hiSTFoVTgxbVg0T1IwYTZQc1py?=
 =?utf-8?B?dVlXRWh0MnRjU1REa2lBRHlEUC91RjYyS0diSjBENXUvcGNITm1YeThLL21o?=
 =?utf-8?B?a2k2NTZTSWcvN1VXbU43NWN0MG05R09GbVJBWUQvaWZlbWRwN05DS1BKYVZB?=
 =?utf-8?B?Wi9GTG4vb2x4RHFQS2tSU1AxUGxlaEl1NlJaY1BTVmFvb0NtQ1JDS2lpNTV0?=
 =?utf-8?B?S3NtbHZIUmRoekl1UXNDYi9ualdYVHhOVXhzb2xGeHJNSDhOQlpmMEoyanMv?=
 =?utf-8?B?K3ZLdncyRHBmSVJSZXAzVDFZR2o3WldnR0JoUHFWUnU1TkpWcTZTNVRsT1Rp?=
 =?utf-8?B?VkJ6Sm12Mm1zMW1OMU1ISFNPYndKRjVtMm1jdlBNeGxDMjltbDR3MGUwRTN1?=
 =?utf-8?B?OVRXWnlSQS9KSXNmbkQyM1JMNGJxUzNjbVhMSUVrOVZpd2hSbG8wV053eklk?=
 =?utf-8?B?ODhJcSs3bzFqVlJmb3NVS284NUZvMjNmTEFaMmVjWG1lN2t3UUwyd3g5eEpm?=
 =?utf-8?B?SStKODJBNjhrdnlyRk85ditZSmc2aWJVaWYxdzcrSnUrODhmb1QvK25NeVlk?=
 =?utf-8?B?ZTVKZnhiZTdCU1NXZXBwa0FBcWF4K3FPbWhockh5QlNjQk5ZN3R5VGtDZFJv?=
 =?utf-8?B?c2dNRWJWRUxNcDFvbW4yc3daM1pPTUlvd3RNUlBMbU8zMFUydDRnR2l0cGVE?=
 =?utf-8?B?eTRzKzBrdFhHUU9iRDN6RDR6ZlAxUm9GUllNU0tJUnFCUXZsRXpSdSt4cW1w?=
 =?utf-8?B?WmZGZTRZRytYMEJ5TXllLzErRFpJTXA0a0QvamErUkV4MGJxbmtuYlQ4WHll?=
 =?utf-8?B?eU0xMmgrVGNBUEROMmNMVEVtK3Jhcy9VUmR1ajROK2RPcmx3V05tek53cnls?=
 =?utf-8?B?UHpXUFhaMXdhNEFnUTlQeGo0YXBJMVgxMWpuWk0xTG1WNStqODVZUGZRRUVV?=
 =?utf-8?B?T1RkVDFha3VvRXFaNUNPN2NCYmVaMURqenlWK0NnM2JZbnMxdy9uRW11UWZl?=
 =?utf-8?B?U1BnZXN4TmxHTlVJN3dOeTErdHYzYW9STTRwOEFvdWRsaEtOeFlTRGtEM0tK?=
 =?utf-8?B?dlRveVBnZXJlQktGREt2RkNPMkxlYi9Fc0VHZHpOSHVIektrZXVFUUoySnFy?=
 =?utf-8?B?TU5tODlnaGJXV3FiT0pLSUtUMHpmU2pIRzVnZEt3aWpiL1pQYXViVkNKZTZa?=
 =?utf-8?B?WFcyN2g1U3hwRjNYKzVRbTcwdDgrUVFmbG5tZ3U0bmwzTlpqd3ZUZTF1VDBq?=
 =?utf-8?B?YVJBQml6WVM2Nnh5YUhNNjdTNWpLQ2REaXNadmJzNnRPWFp2bzByTWh3SHM3?=
 =?utf-8?B?aTFwUkFISXNGd21Vd0RHcUVqNEhjTjlxZU13c1pLQk44cm9aN01NSVhzMkJq?=
 =?utf-8?B?R09HNGRSRUszK0RqSTdNZjJ1cVdWREEySXdpVDl4eDRmZXM3cXFYZkxtdlIz?=
 =?utf-8?B?Q0JHVWRZaUo5NTJ5UTA4UjFJWVA3YXQ1N3NuZjN3cEcyblpxMCt4VmxoT29r?=
 =?utf-8?B?bm01TlZSdG13QlhTc3VRY1g1ZmhheWVpemVLOHVpM3ZRUmszaG9IK1hycDRC?=
 =?utf-8?B?SEc4YUo5dGNLR2ZqZzRRdFhCK0xJLzI2MWpSMHFnaFdSWHBpczZPUURmb3pU?=
 =?utf-8?B?Z3hOaTVsdXZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0ZFVFk5QkN4amNmQkdOYjhmRlBXMFJqaExMQVgybVJBcCtOa3UxNmQwUjZI?=
 =?utf-8?B?V1d5M3F1K2syRDVnQ1pYSDdxOFh0RTFJYzJYWFkwclV4MHFpdXNtM3puSTgz?=
 =?utf-8?B?TSs0d1BDYnJrekJXZm9mMXJtSkwvbG54WldQYVN1REdIZnlkYnh4QmR4bjNS?=
 =?utf-8?B?c1pFNXBmR1VkdWNvcUdGa3EwdUtLVHhEVFJnbWowYXRDd3FIMXVvb00yWnFJ?=
 =?utf-8?B?dHFzNHhTR3BEMVZLaGpjTndEQjl3d1dCeFErQXdoV3VkYWJzMS9KRHhtcmI2?=
 =?utf-8?B?ODZyMEpKVkNkZmFLRjhSN0dScWhweVdOWVFhOXdnbHJ1VGNvTEQ5WWtwUm9B?=
 =?utf-8?B?b2grQWE1ZWlrbmIwMC9WcFN2SkhLaldIU1IwV3RsdmJEV2UrTERlcmJ0N25i?=
 =?utf-8?B?NUp6cVgybVUxaEF2MFg0SjZpTytmdFkvUHZoYVNRVlAxa3hHaEMwZDAvcGdM?=
 =?utf-8?B?bWpxYzVNUk0vNUZaekFTVUpiUTRFTmxnQWlLZXpzUHAwNVJIQTFxWGVMSnJY?=
 =?utf-8?B?UHZjamFnSjlDMkpvOXlLdmxvVHExY3NCNTcwNzVhUVdtbW1DK2RrZVFDK0Vh?=
 =?utf-8?B?dkdCd0s2QkgzelhqcXRjNkFKRkg2S0hxZ0gyUjVERVZpT3Focll0ZUd2eTJY?=
 =?utf-8?B?YUU2MncybWZiT1dpTG0xMFpENHJ1SlVrYzNITTIrbDd1blUvd2R0R3h0QUZr?=
 =?utf-8?B?SXJUbHJkOVFQQVFEYWZIMXV2dGl1cGZuMEs1N242WDhleHV6aTlHVGVIUU9q?=
 =?utf-8?B?ODJMMnRORnJqcTNxdk5MRzVjU0xzS1d5RzNJakFNQkhBV3RSTERsQVQrMDdF?=
 =?utf-8?B?djdVbmh4Z0NTa2h2REkvNXZkQlhYdTVmWkJvaXZGVEs5dzFlMTd6Ry9yMWhG?=
 =?utf-8?B?NThMQzBXOTA0aXExYld2RXF1blJxUURnSUQzSWlQMzdxYUFBK28vYnRVMllD?=
 =?utf-8?B?cVVOSExyWi9uNk4zVHVYb1pDdlJmSEhxRHp2QitzUFREVUYyeGQwK25nVmZv?=
 =?utf-8?B?Slg0YVcxaUxVVnlVbFBzV2hrZEZObnNXOFUreWFLMTY0Z0VGWlo3VGtWVjB1?=
 =?utf-8?B?dkRTUm1XZzc0MEdseWhyTis4bzRNUmhtTnRFa3pnMWtHNmRvdTkrazdrVUpa?=
 =?utf-8?B?dUt1RXV4U0lERmpxY280MyttdXZSRWt0L2VNV2p2aUo5WTV2Z2ExWXg3VWlU?=
 =?utf-8?B?Z21LUllxT0cyU2hsYmNNL0NtbHdIVFBKV01iblcwZGR0N0toM0RnWWgvbW1X?=
 =?utf-8?B?V1lWQjVwMVRGbHZHZXVxUTF6ZFV2dTQ3M2pJaDFXNk9ZRVhtL3VNcEV4MTJl?=
 =?utf-8?B?Sk9BTjg0b0tLRVNNRXdWOCtWSXowRDIrRU5VbVNuaWtYYyszcHdRelFyT3pB?=
 =?utf-8?B?Z2hOUC9LdEszeDFKUG56SFBTU1FuWG13MGZnYzg5RFNHSk10dzQ1VjhQUTFu?=
 =?utf-8?B?TDV5UGJ1WTRiV2pVWWxUT2xlcDR3UmhoYndsaDVFNUx5NkphTTRIUEsrQzYv?=
 =?utf-8?B?L3BWZWpUMm9wckV0QWZzYVhlVnY3LzZHT2NlQnJlOFRtQWhpU2ZqSWlpY2pW?=
 =?utf-8?B?SHg3WWI3cTI1UkdhWVh6bHI3c0xYcS9NZlJtb3ovVkxWeDJzeVhhY3lNbzgv?=
 =?utf-8?B?akJuMEdnRFZReElUL0RjTWdUYkg4bGlFQ3IxOUVzRE5qanVGbUtaT2ZWL20v?=
 =?utf-8?B?U0lwTWtlcVdCZzVLUGZTYUpEVmpwQktXck92WkN2UkhzVVZUai91RmUvR2NN?=
 =?utf-8?B?dkJFYWpzTXBEd1YrRHhqbGJDWjgxVzVHU0IvRkVsM3M5R0dkQVZWZXdodzdE?=
 =?utf-8?B?Zmk2aEZxMjBqbUxtRFNIOGxPM25MZ1VPUmdvb21oKzh3aThWVXVLR2lBd1BG?=
 =?utf-8?B?YytqUFU0TVBJeC94SzFXa3Exd0Eydm43cVZlZ0thOUU0YU1GOE1oOTJpdTg2?=
 =?utf-8?B?MkV6amF0eTRqZVIwcHBEQTRPVW1QdmxlVmo0M3pENnF0N2owM2VwL3NMK0RN?=
 =?utf-8?B?c0hkVFBSbjJKTlAreEx5aUxiT1psZzN2ZTVWMW5rZVlJOWQ0R1RLSTV6VU05?=
 =?utf-8?B?L0U2Z0ozblRydlJINkVMNGNhbkllYzM2S0Q0WkdLYU5XOWhWaTlPRXI2eUhF?=
 =?utf-8?Q?+gn6snehUIe9QOlb4jLnB21UZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3375cec3-896a-4300-2fc0-08dda53e59ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 21:08:57.0946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAbmyEcSdrf9XlYwSeCn9QeBqc8ZwW6Uror/COEnhzV9hUFf1uNg2qmZ7xCb7w6dI/EucWJVQBxI+uqx2o7QLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505



On 6/6/2025 10:57 AM, Dave Jiang wrote:
>
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> The AER driver is now designed to forward CXL protocol errors to the CXL
>> driver. Update the CXL driver with functionality to dequeue the forwarded
>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>> error handling processing using the work received from the FIFO.
>>
>> Introduce function cxl_prot_err_work_fn() to dequeue work forwarded by the
>> AER service driver. This will begin the CXL protocol error processing
>> with a call to cxl_handle_prot_error().
>>
>> Update cxl/core/ras.c by adding cxl_rch_handle_error_iter() that was
>> previously in the AER driver.
>>
>> Introduce sbdf_to_pci() to take the SBDF values from 'struct cxl_prot_error_info'
>> and use in discovering the erring PCI device. Make scope based reference
>> increments/decrements for the discovered PCI device and the associated
>> CXL device.
>>
>> Implement cxl_handle_prot_error() to differentiate between Restricted CXL
>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>> RCH errors will be processed with a call to walk the associated Root
>> Complex Event Collector's (RCEC) secondary bus looking for the Root Complex
>> Integrated Endpoint (RCiEP) to handle the RCH error. Export pcie_walk_rcec()
>> so the CXL driver can walk the RCEC's downstream bus, searching for
>> the RCiEP.
>>
>> VH correctable error (CE) processing will call the CXL CE handler. VH
>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>> and pci_clean_device_status() used to clean up AER status after handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/ras.c  | 92 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/pci/pci.c       |  1 +
>>  drivers/pci/pci.h       |  8 ----
>>  drivers/pci/pcie/aer.c  |  1 +
>>  drivers/pci/pcie/rcec.c |  1 +
>>  include/linux/aer.h     |  2 +
>>  include/linux/pci.h     | 10 +++++
>>  7 files changed, 107 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index d35525e79e04..9ed5c682e128 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -110,8 +110,100 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> +static void cxl_do_recovery(struct pci_dev *pdev)
>> +{
>> +}
>> +
>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>> +{
>> +	struct cxl_prot_error_info *err_info = data;
>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>> +	struct cxl_dev_state *cxlds;
>> +
>> +	/*
>> +	 * The capability, status, and control fields in Device 0,
>> +	 * Function 0 DVSEC control the CXL functionality of the
>> +	 * entire device (CXL 3.0, 8.1.3).
>> +	 */
>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>> +		return 0;
>> +
>> +	/*
>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>> +	 * 3.0, 8.1.12.1).
>> +	 */
>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> Should use FIELD_GET() to be consistent with the rest of CXL code base
>
>> +		return 0;
>> +
>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
> I think you need to hold the pdev->dev lock while checking if the driver exists.
>
>> +		return 0;
>> +
>> +	cxlds = pci_get_drvdata(pdev);
>> +	struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
> Maybe a comment on why cxlmd->dev ref is needed here.
Ooof. This is coded incorrectly. This should have been using the pdev/cxlds device (pdev->dev/cxlds->dev)
instead of cxlmd->dev. CXL EP RAS is mapped using the PCI device dev (same as cxlds->dev) as the host.
The pdev ref count further above works making it functionally ok but this line is not doing anything to help with the
reference counting, is misleading, and just needs to be fixed. Unfortunately, this broken EP reference counting
is found later in the driver to protect accesses to EP mapped RAS.

Terry
>> +
>> +	if (err_info->severity == AER_CORRECTABLE)
>> +		cxl_cor_error_detected(pdev);
>> +	else
>> +		cxl_do_recovery(pdev);
>> +
>> +	return 1;
>> +}
>> +
>> +static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>> +{
>> +	unsigned int devfn = PCI_DEVFN(err_info->device,
>> +				       err_info->function);
>> +	struct pci_dev *pdev __free(pci_dev_put) =
>> +		pci_get_domain_bus_and_slot(err_info->segment,
>> +					    err_info->bus,
>> +					    devfn);
> Looks like DanC already caught that. Maybe have this function return with a ref held. I would also add a comment for the function mention that the caller need to put the device.
>
>> +	return pdev;
>> +}
>> +
>> +static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>> +{
>> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
>> +
>> +	if (!pdev) {
>> +		pr_err("Failed to find the CXL device\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Internal errors of an RCEC indicate an AER error in an
>> +	 * RCH's downstream port. Check and handle them in the CXL.mem
>> +	 * device driver.
>> +	 */
>> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_EC)
>> +		return pcie_walk_rcec(pdev, cxl_rch_handle_error_iter, err_info);
>> +
> cxl_rch_handle_error_iter() holds the pdev device lock when handling errors. Does the code block below need locking?
>
> DJ
>
>> +	if (err_info->severity == AER_CORRECTABLE) {
>> +		int aer = pdev->aer_cap;
>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>> +
>> +		if (aer)
>> +			pci_clear_and_set_config_dword(pdev,
>> +						       aer + PCI_ERR_COR_STATUS,
>> +						       0, PCI_ERR_COR_INTERNAL);
>> +
>> +		cxl_cor_error_detected(pdev);
>> +
>> +		pcie_clear_device_status(pdev);
>> +	} else {
>> +		cxl_do_recovery(pdev);
>> +	}
>> +}
>> +
>>  static void cxl_prot_err_work_fn(struct work_struct *work)
>>  {
>> +	struct cxl_prot_err_work_data wd;
>> +
>> +	while (cxl_prot_err_kfifo_get(&wd)) {
>> +		struct cxl_prot_error_info *err_info = &wd.err_info;
>> +
>> +		cxl_handle_prot_error(err_info);
>> +	}
>>  }
>>  
>>  #else
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e77d5b53c0ce..524ac32b744a 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>  #endif
>>  
>>  /**
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index d6296500b004..3c54a5ed803e 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -649,16 +649,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>  void pci_rcec_init(struct pci_dev *dev);
>>  void pci_rcec_exit(struct pci_dev *dev);
>>  void pcie_link_rcec(struct pci_dev *rcec);
>> -void pcie_walk_rcec(struct pci_dev *rcec,
>> -		    int (*cb)(struct pci_dev *, void *),
>> -		    void *userdata);
>>  #else
>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> -				  int (*cb)(struct pci_dev *, void *),
>> -				  void *userdata) { }
>>  #endif
>>  
>>  #ifdef CONFIG_PCI_ATS
>> @@ -967,7 +961,6 @@ void pci_no_aer(void);
>>  void pci_aer_init(struct pci_dev *dev);
>>  void pci_aer_exit(struct pci_dev *dev);
>>  extern const struct attribute_group aer_stats_attr_group;
>> -void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pci_aer_clear_status(struct pci_dev *dev);
>>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>>  void pci_save_aer_state(struct pci_dev *dev);
>> @@ -976,7 +969,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>  static inline void pci_no_aer(void) { }
>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 5350fa5be784..6e88331c6303 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -290,6 +290,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>  	if (status)
>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>  }
>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>  
>>  /**
>>   * pci_aer_raw_clear_status - Clear AER error registers.
>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>> index d0bcd141ac9c..fb6cf6449a1d 100644
>> --- a/drivers/pci/pcie/rcec.c
>> +++ b/drivers/pci/pcie/rcec.c
>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>  
>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>  }
>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>  
>>  void pci_rcec_init(struct pci_dev *dev)
>>  {
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 550407240ab5..c9a18eca16f8 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -77,12 +77,14 @@ struct cxl_prot_err_work_data {
>>  
>>  #if defined(CONFIG_PCIEAER)
>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>  int pcie_aer_is_native(struct pci_dev *dev);
>>  #else
>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>  {
>>  	return -EINVAL;
>>  }
>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>  #endif
>>  
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index bff3009f9ff0..cd53715d53f3 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1806,6 +1806,9 @@ extern bool pcie_ports_native;
>>  
>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>  			  bool use_lt);
>> +void pcie_walk_rcec(struct pci_dev *rcec,
>> +		    int (*cb)(struct pci_dev *, void *),
>> +		    void *userdata);
>>  #else
>>  #define pcie_ports_disabled	true
>>  #define pcie_ports_native	false
>> @@ -1816,8 +1819,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>  {
>>  	return -EOPNOTSUPP;
>>  }
>> +
>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>> +				  int (*cb)(struct pci_dev *, void *),
>> +				  void *userdata) { }
>> +
>>  #endif
>>  
>> +void pcie_clear_device_status(struct pci_dev *dev);
>> +
>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


