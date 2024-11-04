Return-Path: <linux-pci+bounces-16010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70079BC095
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4AEB2161F
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 22:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951D1CDFBE;
	Mon,  4 Nov 2024 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LHm2pDA4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7191AAE27;
	Mon,  4 Nov 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757960; cv=fail; b=unICcgLCzrbP6suX1ClmhZZMpnf28QrNiDD0Rh5dXaKaFZF1TI2jfLx/EYKa/uaec6i1iX26M3JueXQTwHzxeyBgqf5I23JoN1T89eprczzIBeD9iZ8MTMl90C5ABz7bybItMcqmcT7cxNai2bL3WiWyrxihiflid8QGnT0iQxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757960; c=relaxed/simple;
	bh=xsygl/qspePD82OvA2VpKOni4cTiOxkKltqnSegvMn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6eA5O7O4lcfX9472LHIyO2gBl+yV7gnHbYRDpJ1lP55IDfSw7UT2ULn8PBzLwJB/89X0Y2ct/vUNgU9ykACHJk5AlHaDIzsZqONbEK6Fmo3P4iT1jLfvRlNvMfQpPaFScb9H+Pv+jsCnQ1A1kxH6Gj/MofguF9/iZMLvmMjQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LHm2pDA4; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etTD7pykbFPnmABkrBdI7EX3v1MClkCY9dvcMD0ZkOW/MB2TRkS+RWWoqtDhcjpXFv3e6Ch1rAx6s5JYW34hjGEy5eMYkpj5OyKSmMxIlRYz54m5WfcZpaPWKaZ8PbIFuBgufd+W5AiVBzvB9U0hHmG8fsiFnk9dkEx3nSv5hhup89WnQoTU9YEvM5y95muZRymE1T0w195xNOQPZ1F5Ab2Fepe9zNbwb7QvhruE4i+6VwXNhKz80X+M1EYf3SPrp9TAd5s+wjjcZBpuquby0zAqwUmvuPH8NuLROWiiq0OpTLt2XyUPMz2kGPLZPMhtMYMb7N88hp4IRTlqwBWZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsygl/qspePD82OvA2VpKOni4cTiOxkKltqnSegvMn4=;
 b=lAUk/yBYqpVLADqboqOeGSpZTRpzZMxNQSNg+Bv3qFF+RegK2/AEmS5enyFXXoRqQpzZhgHgsmMRkbpqFDpeRyJmb4WaSucqM6e/UyX8YrT+qBkU/KzmUfKY/wN5ppp5VxrqglnxrymvQXHy3l7qlXDVuS42kpdfkAzAF7D3FfOhxGrhK6gPhpYeunU3neqkE42F5yww5OCQfqQoTo1lRPcWeXJ1RUN8GA+Rz3lDb3/Y3zunno49VROY+h02yc0p650IpOt+VZ2hmjZcOk1eiK9GhDPlQ3z7lKC/1780GYVHl16XXxnE8AIAoT0y16UIELynbplm5drVnFHZWu8w5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsygl/qspePD82OvA2VpKOni4cTiOxkKltqnSegvMn4=;
 b=LHm2pDA4YqFhn4EImpSHYJXrJ7k23Zup3vMbzDvFncGB5b8M1fBjUacUMOc9jgG+FxB4PTzNQ4HfYYu0gj2ZKzAEtl655mqZZ34Su5tSZ1F9gtm0f4P1ONHr4eHbgUw0oxzJQfGBMcKEdk1vtZp62+T4KUUZwXMn+5Gypa+XwP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.28; Mon, 4 Nov 2024 22:05:55 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 22:05:55 +0000
Message-ID: <1968415b-d217-40b4-a8cb-5465f958016e@amd.com>
Date: Mon, 4 Nov 2024 16:05:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-6-terry.bowman@amd.com>
 <20241030151308.000005d5@Huawei.com>
 <672941925f59d_2ce729465@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <672941925f59d_2ce729465@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:806:d0::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 6999e7fd-56f9-4e36-c61d-08dcfd1cdad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2pmUkc3Yk1kdmt4SCtYK054OEU5RWNaNGtNSEJEL1JYWXlNdjdPalFHbFdI?=
 =?utf-8?B?T3MzRTBuellYaDdEWHE3dU5JcjNKcFEzL0l0eVFOK2NZVWI5c2Z2NkYycW8z?=
 =?utf-8?B?bkttV0lCRUxJaWtCQXJIVkJzM1hRVk92Q2x5aFJldFEyQ05EL29rdGhnR1Vk?=
 =?utf-8?B?WVNmU21TRkg4cGpETWlxVXMwVUk4TUxxNVl3Q0FkcmprTlh6bDdWNjFjTzB2?=
 =?utf-8?B?M1VodmlMZW5TSFRYcWN6WDZPejFzMWNFMGk2a2RhL25CVEJpMUdJR3dQaE9W?=
 =?utf-8?B?WjV0am5IZzkxOWxMSENtUTBPRlBCYTRrUVlRZlpLd21ZYlcvck9pcXozQnNE?=
 =?utf-8?B?RFE1b2RlUVNwY3BReFZ3YjEvMHhNK1VkNm5TdUs4eC94Zkd3Y0NZZUZJUmYz?=
 =?utf-8?B?ZW9ZVEZRRktxS0JmVU5FR3gxQXdTNzBsVzFEQXBSQ3JuaGN6amRraHY0S3dw?=
 =?utf-8?B?NHNQTDcxY21tYmtEUEpNNVcyZms3Z3NMd0ZFS0hEMFd0ZkNpYnZPbC9UM3NE?=
 =?utf-8?B?amdEdktOMmpHZXM5MTZEdDFWT2lKdFlKSmxWbHhoWWx1UzA0bkhRSlZmcmtY?=
 =?utf-8?B?SDN5bjRzTUNPckhINU52eCtrRkI2c0FsTDBodDhGYlZGaHBFdUtiWTdXcWhr?=
 =?utf-8?B?RjVEZjZnWVh4dGxpQSt2NXhkVEt0RlQycEtxUFdvWElsNGE4UUJOVGVkbTd0?=
 =?utf-8?B?cjVDVEhnTW5icVlPSTVpSFdzOEJvcVA3SzhoUGpndkZZSlg5ZEJhdTVzTDdV?=
 =?utf-8?B?QWcyRm5WQ1U1M1pGWUNRVXVvSFZLK2hsN2FSYVVjTE1HV05XVEUyTGxhVzYz?=
 =?utf-8?B?NEd1WEV6VWZkbUh4emt6b0xWVDBtZ09HRTd0U2tmd0lmbVNHRzgvLzNDcURM?=
 =?utf-8?B?VWFvWDBkTThxWkNmZ0FIcW9UUE5YeFRBTnd2L1BVK1pYMXJpSHpPL0had242?=
 =?utf-8?B?dUYrNnZzUWt1bktMdzliOWJ4VEs4Y0YwcStnRGQ4MVFWNlltclIwVnNCbXpL?=
 =?utf-8?B?cVg3WlMybXBlWXhYOTZOSHM0SXZtLy9CZVl4bVVJNTRiWFFtbmNacngwMkZR?=
 =?utf-8?B?UTNsMEt2dnZoNDJ0bUhaNDhYZWt3YnZJOFF3aTdoQTcybFpKaHp1b3FhYW1X?=
 =?utf-8?B?K21kbFEzRHBwMXl1dlVCMUdiSVpsK0s4YUZQQ3FSeUo5MFJ1cFFjMjVjdmpS?=
 =?utf-8?B?M05PaWpzUi9sTTM3WlNsbzNxT2VtZmZuWUdBNThXQmUrYjFsQUd4Z0N5b3N5?=
 =?utf-8?B?blgvTGVxN0p2RElUZ250Y0ltVXRZSEFWQUR0Tkp2WGNWWlZYcEdRM0ZCTzBi?=
 =?utf-8?B?dWljMGVLdjhNL2tEcU5EU2xFNkpPKytyUEx6U1N6MmxEZTRKazcvTisrZjQ0?=
 =?utf-8?B?ZEgwdEZBMXhQaTY1bzJKMS9CL01sOTBFaSt5anA1OFNGTGNyVzBMSDBYV0Rp?=
 =?utf-8?B?ZE5OaUtTaWNSaHEyYUV2OTNERVdUNnN0VXMwT2NCbXVQS3FQNllzMTRZZllj?=
 =?utf-8?B?WXRRQXlPQis3cmw2a1R6UUJ4VkhxeGVnK2Z0ZjhiazhJQWh0cjM4OWViL21W?=
 =?utf-8?B?cSs2RE4wbVgreDBaeHkvbktBVGtNd2lSZDZCbkd2TC9jbXBvNWVmWmozRXNP?=
 =?utf-8?B?eWRTWEZCTzV2VmZDVnpMNlhrYkdQLzUwT283dGVkdXE1SThxMWsrMkdsZTlp?=
 =?utf-8?B?cHZiM2RrUmcrdzlvcFdMYXJlR1hibStTZXVwcDR4Y1RMK0NPYllYTm53OFk3?=
 =?utf-8?Q?WfqWC9jlnIhGxuvPUvzr0Yhxgqp8y5meh7pf0SG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2tkOXVIWlhRZTdrenJleEhjWHZpeHlTWE00R1lBdE0ycDV0WGZHYjJZWW5j?=
 =?utf-8?B?NTFZQkFrMlFmWTZkem1tZ1FmU3hqRnBPZDVIN0NDUERiUDFjYWFvTGowSDZS?=
 =?utf-8?B?VG5TbmlXVHphcjdMSzhyUXpsN2RCWkkvb0hHYTdqS1dKWktSN2I3Sm5ZbTYy?=
 =?utf-8?B?RWRSSEFyODljdUdhY25Ha2c5MVN3U1QvN1hKVzFyZjdWcjVZZTJJeHk3T3FK?=
 =?utf-8?B?WGlMeWQ1d1ppL3pWODFVc1RQSzVPNWVNc2JobmdFb2ZCb05ucHJtbitFdG1u?=
 =?utf-8?B?b0NHd0c5NjFBM1l5Vk5kK2F6alBtemU1WHNrNkJHMXZFbDJ1WGh0UGEvbE92?=
 =?utf-8?B?M2JKbGp5L2pSWUJmbkozK0t3cS80OC9iaVFtQ1FyRzBIcGRuOWM2bjdKZEFU?=
 =?utf-8?B?MEt0VGw2QmttUUJHbzExZVVjOHBVczhNTWVteG9MQU5oT1NPdm1YK0pUSlRD?=
 =?utf-8?B?N2hDTzFYSm5WZmdySVVOTDNianI4a1lGTGV3RDNmcGZsb2FsNXQwR2p6bWpj?=
 =?utf-8?B?WlpLMGdSVlhHbUJOckNCVHVBSXIyVVZEc2pYQnh2ZFpwUExmeVlQSmdCREZv?=
 =?utf-8?B?YUhwazhSYWh4NStNbEMydVhyeXVtUWxBdnVQRmJGWnNTb3V2OUYwdDhtaENk?=
 =?utf-8?B?VG93eDlQUVlXeDVsYlI5bHNiWDlxbVY2d1p2cWo3dXFySG1jRmJDcHFkRTdB?=
 =?utf-8?B?MmY5c1pjTzdFdXhHZmp5czZJcmowcXpBRFZBNThueFhoY0l6eEw2azh1bVR3?=
 =?utf-8?B?VGZEUXIxZE52U28reDJQdGt4SWw5ZzZHQkhLdmtvNE9zNis1OUNrV3M1dk4r?=
 =?utf-8?B?NVMycXVycHJkMmxoUG5BaEJXUC95L3YwaHlzdHd4QXBTaXd1NXE4djNDRGhI?=
 =?utf-8?B?bHcvSEdoVGlNYUloVkx0aWJuYzc3eWVmRnBnQ3NTYXRxVHdVVmk0cWc3Qm5S?=
 =?utf-8?B?UzU1K0cvYUI1TzdjR2plV21CZWJURDFoSUIyNUtVR0puQnJobjQwQ1Y4aFV3?=
 =?utf-8?B?Zkh0Y3R5WU5XeTdnVFV3bVBVaG5jeEJvTm05N2VMSTJtMmFrZG9iSGtxNmJz?=
 =?utf-8?B?LzZTUjBsem1yaFJkQUozajllZm1WcktxZEJFcC85S3QxVkMwNXk0UEVjdVp4?=
 =?utf-8?B?RSs1aGJtbjJNbG5Cd3FmVzdLd3h0UGhWb2RWVlVxY1hNWnlsWS82U2Vja2xn?=
 =?utf-8?B?NjB3N0Ywakg5YWI4MTNpNUV1WW9xN0RpNjdTaUQwYUVGNE9EYytwU25HNTMx?=
 =?utf-8?B?Y0tmTlRnYU1jcnlFaG9MelQwMWdwNjBXbGNYQ25xSGtMdTJrT3JmVUE3YmlK?=
 =?utf-8?B?OHlqaGtYWWpnMnRkZi94eTR3bWltVzRIT1c5Y2psUEF6Vy9xMzlFWG10UXZZ?=
 =?utf-8?B?MGlqNnN5OFZJYk1LMEhMYjA5K283WkUvd2dZd2NPWEw1TW5ZQjBiQlJ0dEZB?=
 =?utf-8?B?Nmdqb01RSzlPTVF3VjM5ZXpadjJNbW5SS1o0UTZ0dFhRUzlYcklZN0VGOXFO?=
 =?utf-8?B?cUd0bHpNYmwvQlZBeUlUMloxSVlyOW81UTNUOElwS0g1Ukh1Smg5L3Y5Rzhp?=
 =?utf-8?B?ZmcxSnA5ekx1ZmI5KzNIVnBoUEc2Qzg1MkhFNThhRzNJcExlbjh1eGRWZ1V1?=
 =?utf-8?B?ZEtublUrV0VhdzBRN2R4cW5LUWRlQ0FNYVZxTWpJTGRzMXlEOGdMRktXamRu?=
 =?utf-8?B?VzUwQm1oMHVGK0VPenVDNkZDWExNeHRMWkNleHI2ZmcwVkc3VzZJMTBnaWZ0?=
 =?utf-8?B?Z3NqN1dqL3AvSTlGVVRYazI2Y1k2MTlpU0p6b1ZrN1BnNElWQ2VlWnk5TnVB?=
 =?utf-8?B?TE16bXJpdFliWDcxTkprZ1NFQkVRa3dWZVZxQmtJUjAvcVlDQnc2M25Xb1d4?=
 =?utf-8?B?cmY2UjVEdlVVQ0hBeTNMRGJBNXZUQTQ3Z1NUYUVYVzd3VkVneUkyMjFhWk0z?=
 =?utf-8?B?Y05SM3hRL2kvYW1INVNHNGgxOXZ1R2FlUitqSGRsNTJUVHNYK1RBVDlWTzRP?=
 =?utf-8?B?VTQ1dE9iMWdUR3lEclc3bHlHMjNjVHY4V3l0QmJTaEh0OTBFcVNJSG5jaDd3?=
 =?utf-8?B?a2lwRmhLcnpIKyt2dFVReVB3S1ZKeDl5c3c1UzBsQWhtYis0Z2g5NjhPMjly?=
 =?utf-8?Q?YtV5p8lLs3Ornp7pDC5bbdnQ7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6999e7fd-56f9-4e36-c61d-08dcfd1cdad4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 22:05:55.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3w6ngcYvgFTPTpN3xJlslb6OGPfF0asQ13lm5waPJvhpQfmKg3RRBKrCwM/KZdVweEDuBJoEhd1JlE5UloTWfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278



On 11/4/2024 3:50 PM, Dan Williams wrote:
> Jonathan Cameron wrote:
>> On Fri, 25 Oct 2024 16:02:56 -0500
>> Terry Bowman <terry.bowman@amd.com> wrote:
> [..]
>> Anyhow, I think it is fine but I would call out that this changes
>> things so that the PCI error handlers are no longer called for CXL ports
>> if it's an internal error.
>>
>> With a sentence on that:
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> I'm not 100% convinced the path of separate handlers is the way to go
>> but we can always change things again if that doesn't work out.
> Hmm, if that part is not clear there should at least be more
> documentation as to the "why". For me it is the fact that CXL
> potentially promotes endpoint errors to region scope recovery actions,
> and that PCIe native AER has no concept of AER triggering unrecoverable
> system fatal reponse.
>
> To date panic on AER error has only been logic that ACPI APEI can
> deploy, and the kernel has no chance to evaluate the error. So, CXL
> error handlers is a reflection that these errors are outside of the PCIe
> AER error model.
Hi Dan,

I'll elaborate more and touch on what you mentioned.

Regards,
Terry

