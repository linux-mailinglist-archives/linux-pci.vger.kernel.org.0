Return-Path: <linux-pci+bounces-9194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68D915177
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE051C230A0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 15:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D9619B595;
	Mon, 24 Jun 2024 15:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+ZUhwS0"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2075.outbound.protection.outlook.com [40.107.95.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2A119B3FB;
	Mon, 24 Jun 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719241732; cv=fail; b=HcuJ6aeDiMPnys7iiwtF+Gy/PfjMRUO6ltfhhWUJNA4A6KfpzmL0fYjiZQQ9pRn2JhCsHxXypsHvDsLs5uAhs2Q/+8idyFICTEZQfRzfBNrAX+BSAP591pJlm5ZF+4l26wMCi4DBKBFwiXNyG+eQPlFbqDKnMpnwaLt0Rs4t8SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719241732; c=relaxed/simple;
	bh=N4V7Ry8+2/8UoR9ARw2txcFt7sHlFPowpVrjrVCoBBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLUc3aebkUNEOlxDRuEXbudjL5fl0VtqzK0ouSwnqFBpLOSIEDJTyi9Dhr1qRvG2DvIGwCSZJS37pgRdA6OGPzhxfW1ecoUvn0whiJGWSMWBItyE0jrWZf3Nyr6R3wG5vd3yK8LO8BucFv4Sj35j3VM2DuDXGaKHv5nko/2ghY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+ZUhwS0; arc=fail smtp.client-ip=40.107.95.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVm5UVV0Aom2mp/j1K5wmfaHP7Oa5M3CjWEygCicu3ASWz++MNWLDVSNI+Hw8rsLsR6s97plMW4URYAadh3WWhGCi3Zq/OUxjYyFfJdz+6Ff+tFTNYutu2pCiT24Pprc3CsQkUEZLq+lOp2AAfh61jvOFrp06GBcvl/rwaRUFQbdfR2My2cw/7vtKJrEk7aV/G0pFGFy7G6Kbhdo1EOVKeDlL55KQOjFm18RS5tx1k5MSmwVjypdklUwHbI0D4aVbndCWwJXTGAyfpJrjla94YMTPb+hn0ClP7Lhf5chPEqbVcLumpuKKF0aNkkUoWZTjrzybjONnmWKNwKNuXnOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w43dsPLy469S81lnRZr2xbFgloHlGyXHn4jq4zuW0s=;
 b=fL85HXCTwFIxHTJUGRpLTugWou5iquh2upr2Bm7FmZH9c55QrzM1Q/IqdOfYk946AyAtvtslDOb053Za16uWVIMieGLneFBWQNOD+Dx4vVgTXdy2rOiKvg+7/gjLE9A6kFjsH8qQ0zgSuyfs16EyLUM3xziVkWJrEW5Kj78FSL22XuvYFPtXRz+CLDzOWiquszhxj/lH2V4pKV2MeQXQEmu/auOdoWCq5e7RTf3X+hvSJ6jWu3A9M0er7hcYe+oiu4O0vxjqDtnUE3M2imQcPmIc3Pt3WRddLNq33rTSNjdybIqcsgA2OJjcJNRBBT0gzsOIz/rZEjJFP2qQijJe5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w43dsPLy469S81lnRZr2xbFgloHlGyXHn4jq4zuW0s=;
 b=V+ZUhwS0caXc/nSC/1Un41SPvKhUBU6SCwu9tJgzLt/t+Y4xrsja0YtJlstqsN/28kW1+3lxNbnKT136Yf8PkswaRTe6C0CnH+8fAApkjUixDbR19MQSxX1qVm0zpjnsVXzJnC3g5Ok4778p4R3MMcqehGsGi+bfDPqxfG0qiW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:08:47 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:08:47 +0000
Message-ID: <f5133b75-5d71-4426-8447-b0ed391c4709@amd.com>
Date: Mon, 24 Jun 2024 10:08:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/9] PCI/AER: Call AER CE handler before clearing AER
 CE status register
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-3-terry.bowman@amd.com>
 <20240620123104.000029cf@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620123104.000029cf@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0036.namprd11.prod.outlook.com
 (2603:10b6:806:d0::11) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1c3f2a-c926-4b7c-f44b-08dc945f8bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lTcEJpN092Z3BBMy9RNzRvRUJONTVyQnlESEczdk1wc01EMVFUa0FmYmNN?=
 =?utf-8?B?Vkh4NmZPSEYva05qYjliQ3JYOFUxRmhvcytnQTZRTHd2dENuOFViZ1NMN1Rp?=
 =?utf-8?B?TnBpSFRpa2E2SVg4UHZiVFhrOFJvc1R0Z2xDTlNKQjAyR1lWRkI4Q3I5YW54?=
 =?utf-8?B?S0ZtN2JUZTlTOTBsZlhkbzRwTUVjUUFOMXIra0Vjb2lRWXVUa3NycFZuQ01B?=
 =?utf-8?B?Y25oaGlFNVl5dmRGUVZRWjhMb0g4eFVLdVNtVXJUY256N1NnVHVzTjhsZ0lV?=
 =?utf-8?B?MUNQQU95ZWcxOCtLMU9yaVRRd045VG5BclpHK3VONWh2Z3ZUYW94UGxsS01n?=
 =?utf-8?B?ekU2c0J6bXlMclJ2QWxIWnRvWkZTRk8rVzltNkY1akxVQWVteXhSSjRPZ1dq?=
 =?utf-8?B?aXZuT2QvR0dyVGJQUnA5Y3VLZGc0TWk5U0hqN2gzWldEQXg5V01PTmRBYkp6?=
 =?utf-8?B?MExpMDFQaG5nM2VxVVo0ZnlvOTU0anJFR2pFMVdQcDdwM2Jkb1FRemFiOWFC?=
 =?utf-8?B?RnhvTldrZm93MUFjWnVDZUx0N3ZWenU0T1FUUzJEaWovTk05bUxucXBjZ21C?=
 =?utf-8?B?Y3BQMmtZaXJMOFRjd0ZzY2ZvUVV5RCtiRk1ZY3VIZHhBQXprKzlOSnpOd29I?=
 =?utf-8?B?eGhNVjdYMHp6YzZrdklDZzAvV2hMekR6dm5UYnFDY1d5bEJWMFgzV1BUNWRI?=
 =?utf-8?B?VCttUStmV0Rxa0phaGFSV0VuNWRLMEM4QTdCWENwdU91WURnWlZjZDMvMjEw?=
 =?utf-8?B?MHFjd0E0a2FkT2FITmZ5QVAxWThGNlZraGJiaWhLdUhhVkFYdXltVnBkZXA0?=
 =?utf-8?B?VzZva2ZrcWRVUmNvRzRETDBxSmxiajM1WnBXOU0wV0NpQ1R2MGdqL1N3SDVL?=
 =?utf-8?B?cVVWb3lIZDdCeCtQdE1qSXZhbDl0aHMzMzFzblpKMVJRVWpGZjVzQmtxODdw?=
 =?utf-8?B?dFhVT3hBYjEwb1ZYQVVCWlIzQ1dnMDh1VGV1U1pINXhjSFVTMG9EZzdYZ2Q2?=
 =?utf-8?B?b0xIUWV5YS8yemprSkh0TVY4czFVR2Evdjg0ajZJaEljVzRNVlNCWWFxRHRR?=
 =?utf-8?B?aTlWRkNidnk3amZwTC83VVhEcXRoVkl2Z1lWME1Ta3B3SWgrNWlra1AzS0Nw?=
 =?utf-8?B?cysvL3JaRnl4TEw1VWJLTXZsVUhlKzZMYWNEUUh0WWpoWERrdFAyTGZSaGdn?=
 =?utf-8?B?WjVLUWFpZ2lEUmFyRTNrdlA2R2U4Zm9kZWVraE5PR3N6R2pYSXRydmNDcGNL?=
 =?utf-8?B?OG1HNlNqSWJVL1lvQXQrNFRwSytpV3dRL3VZaldHUmVENVRucTlNeldROXhw?=
 =?utf-8?B?ZXBQQ1NXTnFtSkttdHpOSDRkdDV6SnlvcjVOSnlCUUdUa2JFQ0Fhb0RuNUtC?=
 =?utf-8?B?TFJ6dmY5ZXdldDZoaXJ6Q3MvUkZFVGxycENPa3pOZXFYZmJxNk0yZ3ZYb3FS?=
 =?utf-8?B?VzJZdDFpZUkwcE5ndHFXNG91ZmxFNjMvUnJiblZTMUc4SzFuUkk0TFI4THM3?=
 =?utf-8?B?Qm41M3ZHUXNiaHBWR21zcWw3RUs5dVpaVUh1cTVuV3BZeThtM0pQMXI4eUp3?=
 =?utf-8?B?N0toNHQzd0ZUV1htY1c2QXk0cmF4WVBKdGJRU2pMOWlzbmV6RlNMcnJTVUtt?=
 =?utf-8?B?UTVqK1lzb3k4OE84eWJ2ZlY0MldQLzY1cjhaT01tNHZsZUtScElDSjh2ZVhk?=
 =?utf-8?B?ZHJpVGlaNjVlT2oydFZBb0JtaEtremgzcDIyWkRTWmw3em1MSHpzc0Q2OG1o?=
 =?utf-8?Q?VJWm0CpCoBlLRBGIYBKLmrUFoKTItDNqB0unjdA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzRPZmlUM25TNVpCTGhmeVNwRXhHb3l1UTdUamFzRHptS3U1QzBPZUtkdVJ5?=
 =?utf-8?B?MFNHOGdUVytGLzZwVmR0Y054ZU52V0I5SkQ2d2hDcWdCWnl1WVpSUWxpWjMz?=
 =?utf-8?B?VittT1ZjK0NoYllId2FoOWpMQ3VrTFZiTWpGRERYY1dlNUVkNUVXbzU4N3B0?=
 =?utf-8?B?dEN6d1VZbEhNMmRVanlPZVE5YndqRCtxSWZ3SlhZcnBBWUlpekQ0WTQ0aVZO?=
 =?utf-8?B?bTRaZUFESk5BSHFwYXU2aXBqNTdLaTVxSDJIK09Fb2kxVWpubGlKWnViY1ZO?=
 =?utf-8?B?UzFiQktzVWoyT08vNFlxYVBqeHEyeXhQVGtYWk5pbzZ0UGpnNStXNUFTdFZv?=
 =?utf-8?B?Um52UFZxdDNEUW5rY3pzQ2R4T25nVzlrYU1pZFNxU29lcHc3K2lvSGh3bkly?=
 =?utf-8?B?SzJwMVlvSFM2MVA2VXVCZXluc3l6ZDA1Q0xwUmtCMEMwUFpWODd3UXBhcnJu?=
 =?utf-8?B?ZmZqdTJQK2RhVFVhZkNTc0xTeFhDQm1kVjJjV0hiUjl4ZENRZUVMMjAyTzBV?=
 =?utf-8?B?aFdLd1FhTzVzQkFwblVFN0hLYldWZy96Uno1TDlBenplZmhTVXhjdVJrVzhD?=
 =?utf-8?B?WjBaQVozazBCVUxRNmEvc1l0eEQxSUlacjhaNWZ3cjRiT3Ywb3ZVQ253dXln?=
 =?utf-8?B?K1pUOXZnZnpqVko4bEwrTFh6NlBRcmwyRHNLV1RpU21SWWF6eW5ZMklFczdI?=
 =?utf-8?B?TW9ZZ2QwWkpHU0dkcEFwZHRDb0ZONnIwZFB0S0dKdE5tWXBwQUg2dnVVZE5j?=
 =?utf-8?B?bVFCV1hEc2ovVlRPcWJYUjBCWURNdHZxWGZuREx1dmQ4bHJ4Um9WbzZYWUEz?=
 =?utf-8?B?RFVpVloyb2x4c2JWbHZLYiszeXhEL29jUll4WjBPYmtMN2cwa1NoQ01yb1ZY?=
 =?utf-8?B?dDRiT3QxRGpKa3hIdXZnT25tZUZtbDFpajJUREp4N1hFOC9qd3NIeUNOanB5?=
 =?utf-8?B?S2dxdS9RNU81VDI1UDVXZHVxc1N1a1BDRTBjaU9WTGlkaXI0SXVIT09ZczV1?=
 =?utf-8?B?WTk0OFpEWnk3Nm55TVdVbHFab01FY1BTdnN0Y3A0dW9vQkVaVVJTQ2RPb0tz?=
 =?utf-8?B?U0FQUVpROEt0L21qeTJiekgzWXBNQXJUNXo3aDZXZmtkZTFCWFZsdkpaNG1P?=
 =?utf-8?B?SFBWMzN5TWZnU0ovMXJzRzQ1ZFgzck1meElNaVBMNm0vQVNPS0haU2R2b3Ra?=
 =?utf-8?B?VzIwZnl1SjdNcHJ5SzJhV3o0Y2E2a0RLUU9OSkpUQitGdkZzSDFtUm1NZUF1?=
 =?utf-8?B?ZVdIY0tUOEhkMzhVZmgxU0hCTWppdDBuWkRvekdiYTRNNzlpaGNtY2RSYzZs?=
 =?utf-8?B?RFJ5Nld6TXVwWmJPYXlmS0ZxYzBzSnBMNVgrRmh5Mm1ZMEk2Q1VPeWI2L01a?=
 =?utf-8?B?Unh2V0VndVJ6aWswQ3FYMCtZcWFwK3FRZTREclR5RHNpaG9IMythNnZLMkdT?=
 =?utf-8?B?V0NZaGtTRWdEcWlIVE0zQXN0aVpYUExCZjRqaStrVENlNlFuQVExSU1LcFpw?=
 =?utf-8?B?TGRXakpxZDk5N2xzb0RyQXhMcXRkclY4SU1Db29NWEFyTC9WME5JWDVGL2Zs?=
 =?utf-8?B?SjJXait4Z2pYcmxYOFpycEg1eDNzTnAzWnZQZ3dXcis5cHRUNmFkWHJPVmNo?=
 =?utf-8?B?d0pZMm9yZktHWkZSS2ViRGlKdXI2OHpNR3N3TE5GZUdSSEI5VFZnMnlYczF0?=
 =?utf-8?B?TUZoNURlbnNHZlF4ZkdENG5KSlhKbTFvZ1h2K2RHVzYzYWozRjVkY2FSTGpC?=
 =?utf-8?B?TzdtR21TT0dvTzcvWEtkRUlYQTJjckRQTmFYOUZIWUpNRllBUVpDclVRWXJm?=
 =?utf-8?B?S2d1V1lDZWxhWWNRVkNHeXp0UUlpNG5uMjhVQWNTSGdkWDMxYmVLNENSQldD?=
 =?utf-8?B?ejRWM0RnNlAxbmtXdVRPQlk2OXQybGtORWVtYmZDbHRFWUJLNWYwWUErVmkv?=
 =?utf-8?B?Y3lzT1p3cEtzU09LTm5XemRScUtZNVQ1ZVozdVFuN0NCbzdhZWRBUFdqUXNU?=
 =?utf-8?B?QU01dkJQQjExMnNxenhlRWIvSzZXNklzUUtpU2NTakpsbEJDSm5JeDNiVURh?=
 =?utf-8?B?L0UwblhlcEV4azBuc21CN2RJNHFSSWpZRHB0dElOcVlNWFlldmpUVnk1eGY0?=
 =?utf-8?Q?PEGOFXxdkilHBMBiBQo9OVWeH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1c3f2a-c926-4b7c-f44b-08dc945f8bff
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:08:47.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /P02NIlPSiD8ERdbbXgFDiGQ8z60TDJseNjYnhDaQOxbXTjE9+E5zwUV77TKjD2tGjhB+MQR59G9QYfqgiKdBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143



On 6/20/24 06:31, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:04 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER service driver clears the AER correctable error (CE) status before
>> calling the correctable error handler. This results in the error's status
>> not correctly reflected if read from the CE handler.
>>
>> The AER CE status is needed by the portdrv's CE handler. The portdrv's
>> CE handler is intended to only call the registered notifier callbacks
>> if the CE error status has correctable internal error (CIE) set.
>>
>> This is not a problem for AER uncorrrectbale errors (UCE). The UCE status
> 
> uncorrectable
> 

Thank you.

>> is still present in the AER capability and available for reading, if
>> needed, when the UCE handler is called.
> 
> I'm seeing the clear in the DPC path for UCE. For other cases is
> it a side effect of the reset?
> 

Depends on when its being read. I'm assuming this is after recovery in your case. 
And after recovery it will be zeroed.

Regards,
Terry

>>
>> Change the order of clearing the CE status and calling the CE handler.
>> Make it to call the CE handler first and then clear the CE status
>> after returning.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
> Seems reasonable, but many gremlins around the ordering in these
> flows, so I'm to particularly confident. With that in mind.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>
> 
>> ---
>>  drivers/pci/pcie/aer.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index ac6293c24976..4dc03cb9aff0 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1094,9 +1094,6 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  		 * Correctable error does not need software intervention.
>>  		 * No need to go through error recovery process.
>>  		 */
>> -		if (aer)
>> -			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>> -					info->status);
>>  		if (pcie_aer_is_native(dev)) {
>>  			struct pci_driver *pdrv = dev->driver;
>>  
>> @@ -1105,6 +1102,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>  				pdrv->err_handler->cor_error_detected(dev);
>>  			pcie_clear_device_status(dev);
>>  		}
>> +		if (aer)
>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>> +					info->status);
>> +
>>  	} else if (info->severity == AER_NONFATAL)
>>  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
>>  	else if (info->severity == AER_FATAL)
> 

