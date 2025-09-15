Return-Path: <linux-pci+bounces-36142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45256B578A2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998BA169E4E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78E72F5303;
	Mon, 15 Sep 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Chcz6E0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320520C463
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936287; cv=fail; b=swCdZD0SfL3tTJndcF+pfgNxd3h3NGANkkQgyQOJgLMTC2bjK5uHQhTKQhPosrHo1Tmp7L98pUJDG9YsezBW2peApbIhhsXkcxt/Z/b1kAL3aoSDQLUsj6I5fppO0R8EqJRJDOGGOCGnXAZ1l5dWCIVG8m+L7+3UTGO9cTk0GWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936287; c=relaxed/simple;
	bh=JoS/Jnm6qMqfuIi2op9oM25/HisA6KDkk6hY0iEo4fc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HaciD/E7Vi5JXRYOY7GY2nyfP5CXDaiU3AHevDanwV1zeVZZdbPJ9S5zjaIjxwPKGBbgH5vhsAnfSXuSMnnpJY3l1YeoWjnjtaI8QxnN2nSAgP864tPywa8jF8f7ha7ACMDADGh8LiZGYFXAxBMINLouk9B/BBX/5eCTBkbnA3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Chcz6E0/; arc=fail smtp.client-ip=52.101.43.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLrnpJAv3Mq2Wzp0SSJDALiIzeNU08fkidc/bkA1Gtttuut4Apy98h5BdXL0cvwihT7xNdCfGV8mI9XmC4oy7qLUIDq/A0drSlD7iMRzRYkLg997GoDZLZ83Wv7qWjm0Z2nlbY+UPgpwUGFOVOKuU12xf3Ltw9qHpSc34rRBgJxYFQ1/mj157j1VJXaTWfhDlA9iqg0CRTbvhsRY9CHLhjCiTU6edwvfVQL5YArXAToaSXVA7AKpXL65vZcgyDxMX82LV1pB+YnZJtmAa8xdWdIBjAnuvRz9hqYX1fEA3BsYyrpl/uHxrLRzpRyJQDBVYxc47uTKN4GNykEZjxxHhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ibsj5CJbTMC4G4i3cWAmRyzazQMyUTFVTqkLRlykMrk=;
 b=Bf5tl4enFE/XLUm1OPw875EFgHUdAeVx3KJGHKtPr65GsYd7ChK4bWVw9hc76jVea0KIectgc19sQi6UmIBEDbR3BJ9f+a/Y+62EmrDhBK4O2hTHok4Hl63kGkPDILnp3f/KWLpudpMvSnXYx98e1x+b1wn13wmLwZKwwGyHi3Q7snIzSWxLxYR4pxEE5/FOc3MKw7rgA52yfjiN0c1y+OkMMd8ZrnrNhC1q780wDGIWBaHGYoj0Yxx4rqsX5c8dt9W4Nsg2+oZLdF22858yLsSxlfbfhn3xJfXKDHPTEzMNPJV2HJw8TEV5fBr4PuDo7zRXS/RPiqaQLovMQzFp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibsj5CJbTMC4G4i3cWAmRyzazQMyUTFVTqkLRlykMrk=;
 b=Chcz6E0/L+t/IkKKazxqqzUFtf9FvoKM+z6tog/ttD1qeUeKVLHWsqkta5iF7rpRBR8/kE/48L35VcfY8w5TjxS8eooNdS9sdepg/z9AgdWcpOH5mcMt3x1M5OzMXyCyzYeN9Fep2aFaQPWKo7ZqMmECGnjVM13JfzFRLEnbEIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 11:38:02 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 11:38:02 +0000
Message-ID: <9ca082b6-ff38-4401-860e-e40d4437c3a3@amd.com>
Date: Mon, 15 Sep 2025 21:37:56 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH resend v6 04/10] PCI/TSM: Authenticate devices via
 platform TSM
To: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, lukas@wunner.de,
 Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>
References: <20250911235647.3248419-1-dan.j.williams@intel.com>
 <20250911235647.3248419-5-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250911235647.3248419-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0136.ausprd01.prod.outlook.com
 (2603:10c6:10:5::28) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 45041860-bbfd-4723-5051-08ddf44c543c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDlpckZpclV0L2Z3cWh0QWxNN21kd25MTi9XRVk2MVpFVFB5ZDhVOUdsMFFH?=
 =?utf-8?B?NCtnN1NPRndvQ24yZ3pKbTFNWmRTZlBMVURoc2pRQy93dXIwTWhFWlJTT0xM?=
 =?utf-8?B?dXQrczRrVzY0L0RBRzl4T1Bubm9sTEZES1hSNTNXMXd6dGM4Q2cxMzU4Zjlp?=
 =?utf-8?B?UERncFJ6Vnc2U2hVaVRNekZaajN2NFZyWUNxQkwvNUg2Z1dCRnZRMS9CeXFk?=
 =?utf-8?B?cGxMbVVralJiUnkvdmZ6WnR3d1A1V3VTcWhtbnhvVkRkSFJZT0pIbGRQSjR1?=
 =?utf-8?B?MFJzUjkyWS83VUFPMi8yYmttQXJpdFh4N3NXWlV0bXdjejM0azhVb3hmcFFu?=
 =?utf-8?B?SkhLYkNUV09ySlBSaTFOSlRFV2lSRTQyYTIwN3Q0L245WVFlM0FLbENhYjJE?=
 =?utf-8?B?enNBM1hPK0tLcFNXbjdDUHVsdnI3VFRjdXcrRXZVejhZZHpvNVVMY1FVNFdQ?=
 =?utf-8?B?cEN2ZUJsazJwSklrOG9wWFNvV1c3WHJpOUFoUTVaeWtzWCtxaTJZNjVUMmdP?=
 =?utf-8?B?TnZQeEgyQ3RDb0RKR25jekpzWkVncTc2eU8zc3ZZTnl5eldtYVc3dGxhL1M2?=
 =?utf-8?B?ZWJqNjNyNDh1SEttTmNyY2thclZCLzBsTGIxOTZRY1JGTkR0Tzh2bGpvK2ZK?=
 =?utf-8?B?VjVka1cxb2t1VTVEOVRvTXZNdjlUay9PeDhzb0tIcDFtcmRQcExuVk80QUNP?=
 =?utf-8?B?dHVXZjVVSzhlaVhFNVloQWlzanJDVmEwall5dkFLeW91eG53ZForYmpjT0JO?=
 =?utf-8?B?WVhMdG5WUnhqaFE1Y21qNjd2dWZhMi9sUUdlMEJTMFNDTlF4TDBNVTRTMEI5?=
 =?utf-8?B?eklZZDBFNU52UjlsZUxBV2dYZVNjU0VEMnBnMTVieUhMMkFBZ29tTFRnZE9v?=
 =?utf-8?B?NTZoNU9LS29zc3ovNG96ditIQkJsMWFqSVdUVVZTang3cHZ2M05EbG8zcUw3?=
 =?utf-8?B?QUVGUnlJWHFTb0FYdjhnUEtzTURZNXVMWWxPUmlPaTJpTWJHdkV4amVIbytp?=
 =?utf-8?B?d0lzbkl1dW9IbzNkY3NkT3JhL1A5eElYY0ttTXV0VHdURnY4NlRrVjhvWFo1?=
 =?utf-8?B?MzFVWlRjalZBSDR2L0szbmVJL09yRjBhZlgrUytNYkNocmZtb3duOEdPZUt3?=
 =?utf-8?B?c2UyQ3lCSzZWVmVuZGk3RFdJNFplUXBVMzZpQ2NsdlhJbE1jWVluSXNQSUIr?=
 =?utf-8?B?RUFRQ2FES1JKUDZMN2pnYmw5cWk0RWhnL0F4cTRoRTdXdjJwTDhUOXFORDY4?=
 =?utf-8?B?MzVCamZBWUh0M3FBV2NQcDI3c2VvQVUyOXBudE5IeFZaTnc3cnhCZTBITjhW?=
 =?utf-8?B?NnprdmR5bUxhd2ZEdnY2amI1OVRQOGlQaFgybFNldi9oemNBTmhCbXh1ajR2?=
 =?utf-8?B?Q01mT1RoUXdIQXlMakFUOVVnTlRnM2RBQnhZN0ltT2hGbzdPSGZxckx5T05p?=
 =?utf-8?B?WGNoSkhHcFl1TjN1T0trSHdnY0svVXVWOURRdHViaGFCUXlIdU5xWGQybzhs?=
 =?utf-8?B?WkxQSUJmSXJHT1ZpWFhFQ3NFL256NmhQUWNLaUJpSndBN0VpdUJQUWk1MWJL?=
 =?utf-8?B?TTd0THB1dllqM25ETjZYNXQzNkZBRmovNyttWjkwd2FrS013OHZDODZwNzZT?=
 =?utf-8?B?TFJFb2wvTlpNd09VYU1jTS9wRGY3TXlaVy9xRW05dWFCdFAwdmVhWXNQd1RJ?=
 =?utf-8?B?dE5IOWQ2bkROYTEvQXlYbG12b1NPd1VjNk4vSGg2bkNHdVEzQTlvbmxsTWNR?=
 =?utf-8?B?UWQ4N2k5ZkhGOGNqdWFtc3preld0MVR5eUVLY0JrRTN0MWtiTVJnSVo3K0tv?=
 =?utf-8?B?Q3dyY05DTlU4VEtPNWZ1R3RyRjNYVlR4WGpNbnBhai9UZHk3bHdxSFRMZmRQ?=
 =?utf-8?B?aERjd05iNjNyM2l5RG5LTm8yaWl3SXdmRldHYTFKeWhpSGh2SHQ4NnlBUmtW?=
 =?utf-8?Q?EaSVo61E+Qw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUVIMGQzczBHL3ZsQllCWWNmUFQvWDB0cWRuOSt3bzZIcmhDb2dmdlF2VkNI?=
 =?utf-8?B?SUVmdjRKWVoyVzVXbnVjWGsvejF4SGdMNEREbUQrQzFTM29GWTM1U1E5QmNx?=
 =?utf-8?B?NjdkRC96a1VNUGFOSkJmUzhzWDVuMmJpd0lDSWVHdVNVTmdTVGQ3dHNBWmVq?=
 =?utf-8?B?Mi9aY0MzZ0ZkREc2K0tHWFM0OWFSTWRSMjVYZU1SemRvbkNwV1BOSUlDeFZw?=
 =?utf-8?B?MkViSFhUaHlFYTRnZkMzY0xtVmNxdGZ1L3pRNHo5RnBmQW5Uc1JSNmlXYUN3?=
 =?utf-8?B?YTlnb0ZsNG01RGtjZkYzV2JRU1NrbmxmTTd1MnNHMWJOcXdodVlydXIzMWhz?=
 =?utf-8?B?SjhuNy95cUp6MUpvekR2Z3JGL1A3TEYySnkzNHVGa21iam1rM1FLY1NzUTZj?=
 =?utf-8?B?cEVrL3FUaVlaeXpod0tWcHVYRnJGYlRSV0swNUM1NTBVVXJYaGJ0RnZ1Vlpw?=
 =?utf-8?B?c2FEQVN1b1VXbERTTTJoTFB2RXRkN1FocVRwYnNvOTFvS1hXbVRHWDZ3NUxo?=
 =?utf-8?B?eEFwRUlrUGtNY1FkQ204TjBsaHlYeFJEbnFNL0czUUdnTzhwR2tNSjErUFlM?=
 =?utf-8?B?TytOVTVsS3ZRcURJVmVHZDE2UlFHSTdVMWZkcWMySm5MY3lzQlgzcEMzYk83?=
 =?utf-8?B?VGI5TU8xRERBUzlxY0lHck1IeDdzTDlPNXkyR0NYZldXNzNjdXd6Y1BHUzhl?=
 =?utf-8?B?UW45VG1zNm1vTWE3OVB1aGlVTjd6YzN2NWFJSW9EVXF2L3l1SGFvTlE4ZWF2?=
 =?utf-8?B?L21yNlJWRkVIM255ZGRJTEQ2MjZnTkt2NFllSW1oN0dWMlIvREQrYnNPZW00?=
 =?utf-8?B?RDc2dUZ3VkNZMUJYUXNRMlVhWjZiaXh6dDYrY3crVWZaNHJsRHJGejRYcHps?=
 =?utf-8?B?WFBubXBmVVhzRFpQenNqT3JLYkx2WTJxTWVnUzR5bmZidzZjZUdmc0w4RmRW?=
 =?utf-8?B?cnNYeXQveXpwMHpVQjd2cDk5YWVhdUgweTAvZEsvNzM3a0Y4Q1NiM1FKQkVi?=
 =?utf-8?B?WVZYcEVsblN1MWNUZWRvTnY4VWtKbVFRSjB3TkxRZDBtdkJsRVJwbnVyU0RV?=
 =?utf-8?B?ZHpYY2NvMnhNNFFCWDZhRk9ralZyTGhYcWdoQ3RQZGQra09KREp4bXpEUEFM?=
 =?utf-8?B?Ni9od0F0SXp2OU4vZWRVRzd0eGJReldGR0plcFpZNnBtdjJ6NUJYdURBUCta?=
 =?utf-8?B?MFFTOFBkbTRxS0tQbTlmTFR5TThCRVJnQkE5WFVQSlFhenljM3Z5a1EwSkFR?=
 =?utf-8?B?NkdEbWZEeWtTVC9SSEtLVi9lcXh4NjNwNHpJNnZ2d212RjNzQWZhUnpFYWRn?=
 =?utf-8?B?Z2xSa3dFcktTSnI5UUViRzFHNllJalVtRHh4TElTTDA0SkdiZzU4LzZnS0c3?=
 =?utf-8?B?V0dnc0Nrdkg0OGowd2p4WEZtNkpxZ28wditsR1JEOVdmdTVDekVHbHRuc2V3?=
 =?utf-8?B?SkZsVmlxVVhvamlUT0JBU0pMdk9lSUEwc1pTaDNZQmJ6ek5EQWRMd1JSWmdT?=
 =?utf-8?B?VkhEQWdQNkxMQ1hPK1h4TC96NzNJcjU3Zlhhd2hYWFhuWElScG1ROWpCbkdU?=
 =?utf-8?B?c0VPZmtlKy9qNnJpcGlROU5uWW9TY1hOcDRvZTRrWlc2d1lRdkI3ZjR1YWRB?=
 =?utf-8?B?b0hNcEpvTnl1NyttcExvR04xRHRaZm9MTm1ZOVFxbjVpanYyY0F4dHEyNEVt?=
 =?utf-8?B?cHFya1BUS3BWeGg4cElRZm05MllKcVNHK0hmNzZFZ1pXZStEUTMwMDRWOCtC?=
 =?utf-8?B?cG1wQ0YzaHF2RWFPLzR2UEpLYmxmc0preHJ1cWNObkV2cmhhYS9hU2VuRXVD?=
 =?utf-8?B?d0tPMlJiM1lNWlQ5UU56ZS9meEtmSzVYRlUzNzBSUjJQZVZLMzhkRHNFdjhF?=
 =?utf-8?B?dCsrdzRZQlQvUWFKaWpFZ0I4TU8yQjZJUzNEdXRuRVFMbnhWRlY4YkhtMmlz?=
 =?utf-8?B?cHdkcUdxOFZHM2UvMVJFRTlQQ2lyQ0d4ZlpyOHpIcmhQWHlYOUE4OHIvTXhS?=
 =?utf-8?B?Sm8zSDRkRGZLUnpzN2NwRlZLOTh5OGttK1YxejJ5b0pVeTNuVExoN2g2WFcr?=
 =?utf-8?B?am1PV01SU0dBNTgxaEZjVWVuUCtyQ3pFcytMTFVJU3J6R2FwWDBpQzdDb000?=
 =?utf-8?Q?kR9kEoZ9ib/wk8g8KZAPS0Qda?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45041860-bbfd-4723-5051-08ddf44c543c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 11:38:02.7931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5V6nbDUIWkcGFLJJdZr5jbgkITMZDdn8prUiE5IeFTLAv4rcB4g8QcrxvzpmXI0tpZxlQQ1hT9YoYQB4ZbJIYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395



On 12/9/25 09:56, Dan Williams wrote:

[...]

> --- a/include/linux/pci-doe.h
> +++ b/include/linux/pci-doe.h
> @@ -15,6 +15,10 @@
>   
>   struct pci_doe_mb;
>   
> +#define PCI_DOE_FEATURE_DISCOVERY 0
> +#define PCI_DOE_PROTO_CMA 1
> +#define PCI_DOE_PROTO_SSESSION 2

These are "features" now:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b4db6be0ceec490f639d2e47449ffe3dd6db7679



-- 
Alexey


