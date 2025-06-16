Return-Path: <linux-pci+bounces-29898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2150ADBCC2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 00:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722967A79BD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4428C1B4257;
	Mon, 16 Jun 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DwRQMrDi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C251917E3;
	Mon, 16 Jun 2025 22:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112251; cv=fail; b=PM/tYHL6mN1VhnuPuO8Sa9E9mraWjnq2ttSP8SNcoD3M3O6hx6Wf8p8gmAQJxusQa762hr1YTsQHIYaxvrJM3FW0lUpfjzR6a3R3GIsCqtloja5shhwIG41A2aDwTqWVJ2yxqMVO5EJRVBL31NHcY/Ovr4Op1d2RbITlrXHh6wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112251; c=relaxed/simple;
	bh=a4WvfvalSgS39FOMLYgQE0PA5UJHaIzu0syTLAfwxP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Di/UcFJrh15MT79hYK5oQjDSU9GNfY+mXg7kCF8hYlAZAPul1+sD7pIq1JG49UI5Axzz5t3daAWTrY9bkW/y7fqcGEznQW1Ut6z2CSaFlGlAXUj1Ga+SajHDTPPl4JjafkZkC9NC3JiZaDJ98U8muegkCw7BXoIhqNmSDx6dmo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DwRQMrDi; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EazKR88eecfaJ2Ph0kN3CpVjIS0lnzFL0EUI09TSGWhHtOxFfKA0j3m1zFxbpW17WP4bmU1SkTW3dAA3v6uu7EteYGhm3c1C9z9JqpXJCKkV7BN4jfPSf1C5HpdLRyfavNH+FICOuQ7fSY6PXiVKnIDcHrJ3CCi/UdzeK+dq51TuX9krD7PRprVkCodG5HSFTbh1pmn7McJXBOJ4potQ4fH1/ApRki/UEE1XttxD6T0qwWRAOjnS7+nxhZgaRd70qajBtk4svwLaTQdNuC9STIi5/V+b5ZHWcmPqQx5JN2B+cHtBfpp9RlB+95IY+0s0F5Lz3V0oVYRf9iQWX6l2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edBRXC87zwVQEhpbJmzCAHMO+AD5l8AseZ2dCSaamBA=;
 b=WLvrrHvl6/AnHMc7mYdI88OZiz8jpB5GPp42+JtXjZ3L/iqRunbp+yUUJnZhDwlwaCEwjpkOFI6eLa+wuamJk8p2YZpaG2vc03p+RIS1uBg6Kb9KG9J3NSdVuveeNWlUid8j+VpXGdnBENESYkJE2u6+owf2SwI81AE1SkLipPCrtLVSh10IGPMb0y8jZg9XvC88KQoij6zcCGYDYwe73J5CJNGp6d7QUUUJBcDBZ1cwVzvX6Ub/nXzxaKaH15OeiZIgtBnFrlrDZt64+qwmhV4JzJm+CkUH8XeoERbgKkPp5meFFVAsoIP9VIhzQ/Sr1xriVJfW1Bh1HVO1iXBAHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edBRXC87zwVQEhpbJmzCAHMO+AD5l8AseZ2dCSaamBA=;
 b=DwRQMrDiUVJLEdeJxKcnupaOcbc7PwwaxCnpt98K/ph1T2EfjmKZysGZBd6JZDGpQQzuxTPS+4FwGylSm07L8MfGM2YB8gl7Z05K/IIBiaC7SwjmNz6v2Z5c1+uZfjfRKUhNMg+NBiTV3muTlcdru4Y4giiN62/Dg4EHAmQpKlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 22:17:23 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:17:22 +0000
Message-ID: <8433dfb2-efb8-422c-9c2b-aeb62a7b4865@amd.com>
Date: Mon, 16 Jun 2025 17:17:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/16] cxl/pci: Introduce CXL Port protocol error
 handlers
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
 dan.carpenter@linaro.org, Smita.KoralahalliChannabasappa@amd.com,
 kobayashi.da-06@fujitsu.com, rrichter@amd.com, peterz@infradead.org,
 colyli@suse.de, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-14-terry.bowman@amd.com>
 <20250612181445.000045ab@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250612181445.000045ab@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ceee4ab-1350-4129-2599-08ddad2390be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0F3anpsWEJBdFV6ZlVQZWUyaTFEL1Znb1RYL1NSQnk0eWgwbitMVG9sWnJU?=
 =?utf-8?B?Ym9DTFVoSHhSKzlsWkh1NlhKMWpnMEdCZW5ZN1JEWEpqUzRNRHJ3cHEyUmNp?=
 =?utf-8?B?QkxvWlczQW5KUDE5QUZIMm5MS3BIdE5yY0xMMWNZQzFzU1J4NDllMFI5M0g1?=
 =?utf-8?B?dk9LU282amc3akRoeThXYzdiUjQyU3RqMU5nbTlFR2RvK0RNNjVmVGNRa1Iz?=
 =?utf-8?B?ZmNWcmg4ZFI0NDhQTGtjVlZPc0U3eTJjeTdOZTRwTGRqc1ptYUtuSkphSGhT?=
 =?utf-8?B?WkFPblRybjh5c3hMdmRmK01xMnplc1BaT1FrWUVtTHFDSjdJRWdIZE5weXlh?=
 =?utf-8?B?NFFDV2swMUxlbGRTM3VIWC9WaTgvSlloMGVCeHlGeG5ncFZkeU1HLzBkbExL?=
 =?utf-8?B?bmxncVVIZU43aFJDUFhQQjE4UGNub21SbitTZUpRYTFSbmNLQjU5aTNyb25k?=
 =?utf-8?B?TEJZdFpJMzJGT2czUmNUTS9ELzVZeDdGMmJvclFtWkR0QlNWMm9uNVJlVGVE?=
 =?utf-8?B?Tk9FclhzY1huTy9YejMza3lFNmUzR1JTZEZoVVRIKzkvbnkvTm9Sb3JmZjZR?=
 =?utf-8?B?bDdiVXRXTm9YMDA4a2dYbTFNWkI4UlVEUldzL3VYbGtxa1NrdzZSZEpyNWEv?=
 =?utf-8?B?SkRIdzZJY3JGQU44cHo4N3VmMmxoZXZ1Y1hHUkpVWkd6MVFZK3ZxU29KM0VK?=
 =?utf-8?B?bGNQbEc0aWJRdTZWSlZxUzgwdGYycEU5YnYzSXZoRTZKTE00N0lraEFidy85?=
 =?utf-8?B?VWR3ZmRvUHd2ajBnQ0g0d2F5TjcwNDlSYjk4WCtpQUtkVFFTSlhSSzNyZy9o?=
 =?utf-8?B?QW1WSWVxai9lcnJCbWZUWkRncGMrYnRRY3lHdDl6UTd0aXdaRTdidTF4Y2tX?=
 =?utf-8?B?M1JYaytYTWxSaU8zdWxJSk1GUHBGSzRvVUEvbXkrUGY5UVpQYm55QTZuMmxm?=
 =?utf-8?B?Qjc1OVBvcFR5ci81cEVCeml3Q1hKRjdYdlJDVEVzWG5OOWFpRDVyMzR0V3RD?=
 =?utf-8?B?OUUyS2prU2ZadXVSYVNoRDhmS25YT1ZIbHMyck5WM3lUZWFFcFV1eGsyZjB2?=
 =?utf-8?B?NkUxbUQyU0JldDE0ODJ4ZmYzNHRXQlhDa3RNNFUxbVBQNGVwNWtSQyt3MjZm?=
 =?utf-8?B?Tmt5N29mdGYxS3hSNnJBZ3dlYkUvenJObWNmdWl1cE40ZTJ0Y1ozd21DTDdS?=
 =?utf-8?B?eU8xVzdkNXNJRU9QcWgxQnFaTnA3cE4ybzRwSkJEdHZsRDd2M3U2cTZhR3E1?=
 =?utf-8?B?amt3Njh1MVUzNkxlUG1ueVFzVFNNMnpQeW1sYUZjK0hFY1NadTlMMG0zOFZM?=
 =?utf-8?B?NDBBY3lId0tVSm1oMlJvV3VEcDJsNi9TYVIvYmZ3Wit1dENYR1FoVnQ2V2V1?=
 =?utf-8?B?cXZ2bDJMRjlpNUZuK2lPQTIxRzdDSDZxZVo0bWd2cGNtc3pBakF1T2cvQmIy?=
 =?utf-8?B?UVB0K0EzdUVzNHNKOHAyRGJnSXorOG4ybjdrL3dzVG9XcTFmNXEyWlRhcGFT?=
 =?utf-8?B?M3R2OXlBQi85TkZlUjNSeng2c05MN01nNDFvOC9RMWI3L3FKRkgzaEdJaGk2?=
 =?utf-8?B?VDlnWTMrY2EwL0lhTytFRDlQL2Z1dkxYVlhoemo4TFNvdytiR2JNVkk0d3BD?=
 =?utf-8?B?WWdiRW1lMHdYUk85ekw2eEg4Y3RTNU10aFRURVRuUVZCKzlRN1NQSmpMejJ4?=
 =?utf-8?B?NVdsVHJEMm81ZkRiNWJTdkJuTml2aURzLzJtdjY4RnhqSzFzYWV6cjR4V1ln?=
 =?utf-8?B?S0krVFFmRVBsZnFTaEIzVEQ5dnBNeGpPNjVhcEFLWkloT0V4OEEyOUg0TkJD?=
 =?utf-8?B?MGY4WW9LYzk1R0tCL1drNnVkOWZBVG5SZVRhUnl5cVFNQ1RjbTVTejhsajVa?=
 =?utf-8?B?b2U2VWtpTWlnR21IRVROdHpKSFhRVFg0YnBkN01mV0NLQjBoeEFKdG9PNC8v?=
 =?utf-8?Q?FBBW05xsPeA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Um9rYnNKb2I5ZitET3VreWVlbUkxZ0RvOUdXTkUwaFdScUgvRTNMVnEzc1Vu?=
 =?utf-8?B?NysybGJ6dUMzTVBPeTMwekRpaHQ1Nlk3OXRLc2ovY0dCVUNPVXB3eVQ2UUpv?=
 =?utf-8?B?Q3pXWnpKSnIvczhCYnFjTVV3OGpIL3I1SVFZVkZVMDEzc3o0dGpqTUFJaFA3?=
 =?utf-8?B?eXhCTlBxZDdOSDBMdzlvbEdlZkN4bnkyN1JqcXd3VE10U0cwRmdBeXJ0eHNU?=
 =?utf-8?B?QkdneEdSeWtkeEhZdnVYRkJab1V0cnpwOEdZUVlPQlc2eDVKTHhPVmRkcnZ0?=
 =?utf-8?B?VWZZeGwzSHVXUWl1d1phZzdqNVZTRmVsYjJacktGY2tsa2xXUlRsa3VkSjll?=
 =?utf-8?B?NGkwMjM5SzFsRm1OMHJFVDVoNDdmMWh5THI5cmVRQll4WmczMkRKdzV5VS9z?=
 =?utf-8?B?dWN1dlZyMUZLc3VYVmNLdzYyUW0wNGRONlY4VTZRVlpScXNqWUUvSTRSSkZE?=
 =?utf-8?B?amViSGJLZjZjQU5MWkc3cXJDa0wzVFVDbGZ6L1pKNU9JL0RhNDN5cTRsUlZS?=
 =?utf-8?B?dllhV3FuUFhWeUZSN0xTUjBUbitUaU1xdWp1L29wWG9uK2duUDZlc3RibUVu?=
 =?utf-8?B?YnF3V1FwRkduRERRQVRuTHYxVWhCd0hqa0pQZHp2bnJLMW41UHloSjZuOWdy?=
 =?utf-8?B?TjFSM1BudWR4b0hWZjY4Ly8xbFMzSC83NWk0dDdpMC9PNmQ0ZVVDb2VOYmwz?=
 =?utf-8?B?ZTVrNm12VXpELy9adVNNakVTRWxJK0RwQTI0NnZaSWZkK1gzSGd6ZVRLNjF6?=
 =?utf-8?B?eDZTY0FrdVVSNGpTK090ZnRyL2tYMFRJekVLNzE3RjlsTHM1aVlwQ3dUaGho?=
 =?utf-8?B?OEtXSVJ1YjJsNHdoKy9zL1RGeG9tL1JHWlFFc2M1UDY4SElVRDVSTE4yQUhp?=
 =?utf-8?B?ZXFSbTdSSVkvZjFoVm9zc3hxR1YwUVdLcXdZQWFWRG5pQi9wOGVnQTUreWhL?=
 =?utf-8?B?TUdmVjR5dVBsV01JMGFKaFJ5QXRBOXhkenpKT3RDQnp1bU5mckp4ejFaMytn?=
 =?utf-8?B?YTdaaDhYNXhFSVc4OE5zNFBnVExBTlpnM09FYjB6UFlSbVljM2Y3V2RFSGdo?=
 =?utf-8?B?VTc4Q1dBNlpmOGsyTitzYUp1SklCYzBqSmlHQU01WEYxWitpQzRXbkMyaDl0?=
 =?utf-8?B?MVhKMlRrQi9SSGVaeG9CVksvSVdQWVp1Y0NJQzF2TDRuQXZoUkdqWTVUY3Z2?=
 =?utf-8?B?M29jZ3lHaE54UHZMNjgvaVZYQysvOW5OK29VZC9xYXBsa2NwVjRWeHFvSlNN?=
 =?utf-8?B?T3lzbHU4QUVQRDE1SzBqaTJhOWVOT2QyYXZYSWRHZ2ZhOFgzdEtjK3RmL1FT?=
 =?utf-8?B?endmSFVvZjh0eklQK0ZlcURLTGcySzdqL1NseG5Sd1l5SjNZNVdVQUFsYzBy?=
 =?utf-8?B?VFNjdGxwUEVTQ2pDeHVYbTArK2ZSYkVFM0FUWEJLRTVCdXdmWXR6VkxVMFY1?=
 =?utf-8?B?Z0l3SVhMM1R6SjY3MUFrQTFETXg4WkdJS2ZiT1pMeVRIMFhHZWdpeVQwR0pV?=
 =?utf-8?B?VlFYTVRiRnBWMzJaZEtEQWNOWTdFblJVN2RNMWhsVk11UDVSQWpCendjdGZs?=
 =?utf-8?B?VDBKT1V6UFVXTDFHY0ZoWkFWMklHMlJMWjBpL1ZsU2VFUlA1NHJZN2E2T0N6?=
 =?utf-8?B?N0pMUWNOMnQ1aWVqVkFLRENSS2JxZXI4emtUdDVESHgwcUFETVI5WlBIZ0J3?=
 =?utf-8?B?c09vUHc5TEdoNW81cUp3Vk5pb2xYN2ZDQmRYS0t2ZE9kdlVvcGxOZUhKOHFz?=
 =?utf-8?B?QXEyUVQrY2tvQnZubG9sT2htdnR3OEg1VEpyR2tlemZVRUFiMHNTdzJSaUlt?=
 =?utf-8?B?RDBMekpFYnBWd3JmSVZSdmdWaXMwbDQ2bndVZ3gwbDlqRG5qYTd4Wk9oRjNO?=
 =?utf-8?B?ZUJaeG5JUHV6UjhUY25FWlByUzRoMjI5SmdwZHFxMXdlVWZmQVdCTWNlT3FM?=
 =?utf-8?B?WGlacUNBdG9OMVR4ZjE0L1VBOFBEaFMzVWZ1d0R3RktXVDhRWGptc0tFRDVD?=
 =?utf-8?B?QlFQSUthQlRwMWtqVm1oWWJGaXcrZDB2b2s0VXA0SWhhNjFSUHhKMEdlMGRB?=
 =?utf-8?B?M3NQNDg1dVlYY0dMekF4clV1dFVXdjYraGxZam1XdEJqQU1oL25EYUlvc3Bx?=
 =?utf-8?Q?CcRpWYXFli4xXmSU5rs9vmwsr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ceee4ab-1350-4129-2599-08ddad2390be
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:17:22.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8KG0ba1o67dfRtvB3Y6/3TxbBVpWfaF72Qoa49FGO5B/X14nTLEwlcwtCtaUL0Q8BvSseCvKbLFZsbwhCBwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428

On 6/12/2025 12:14 PM, Jonathan Cameron wrote:
> On Tue, 3 Jun 2025 12:22:36 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> Introduce CXL error handlers for CXL Port devices.
>>
>> Add functions cxl_port_cor_error_detected() and cxl_port_error_detected().
>> These will serve as the handlers for all CXL Port devices. Introduce
>> cxl_get_ras_base() to provide the RAS base address needed by the handlers.
>>
>> Update cxl_handle_prot_error() to call the CXL Port or CXL Endpoint handler
>> depending on which CXL device reports the error.
>>
>> Implement pci_get_ras_base() to return the cached RAS register address of a
>> CXL Root Port, CXL Downstream Port, or CXL Upstream Port.
>>
>> Update the AER driver's is_cxl_error() to remove the filter PCI type check
>> because CXL Port devices are now supported.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A few minor things on a fresh read.
> 
>>  size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index e094ef518e0a..b6836825e8df 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -753,6 +753,67 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>>  
>>  #ifdef CONFIG_PCIEAER_CXL
>>  
>> +static void __iomem *cxl_get_ras_base(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	void __iomem *ras_base;
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport = NULL;
>> +		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!dport || !dport->dport_dev) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		ras_base = dport ? dport->regs.ras : NULL;
> As below - perhaps a sanity check for error and early return makes sense here.
> 

Good idea.

>> +		break;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	{
>> +		struct cxl_port *port;
>> +		struct device *dev __free(put_device) = bus_find_device(&cxl_bus_type, NULL,
>> +									&pdev->dev, match_uport);
>> +
>> +		if (!dev || !is_cxl_port(dev)) {
>> +			pci_err(pdev, "Failed to find the CXL device");
>> +			return NULL;
>> +		}
>> +
>> +		port = to_cxl_port(dev);
>> +		ras_base = port ? port->uport_regs.ras : NULL;
> 
> I'd be tempted to return here to keep the flows simple.  Maybe avoiding the ternary
> 		if (!port)
> 			return NULL;
> 
> 		return port->uport_regs.ras;
> 
> 

Ok.

>> +		break;
>> +	}
>> +	default:
>> +	{
>> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +		return NULL;
> 
> Better not to introduce scope {} when not needed.
> 

Ok.

>> +	}
>> +	}
>> +
>> +	return ras_base;
>> +}
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 664f532cc838..6093e70ece37 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
> 
>> +
>> +/* Return 'struct device*' responsible for freeing pdev's CXL resources */
>> +static struct device *get_pci_cxl_host_dev(struct pci_dev *pdev)
>> +{
>> +	struct device *host_dev;
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +	{
>> +		struct cxl_dport *dport = NULL;
>> +		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
>> +
>> +		if (!dport || !dport->dport_dev)
> 
> What does !dport->dprot_dev mean?  I.e. how does that happen?
> I can only find places where we set it just after allocating a dport.
> Perhaps a comment?
> 
> 
I'll remove the check for !dport->dport_dev.

> 
>> +			return NULL;
>> +
>> +		host_dev = &port->dev;
>> +		break;
>> +	}
>> +	case PCI_EXP_TYPE_UPSTREAM:
>> +	{
>> +		struct cxl_port *port;
>> +		struct device *cxl_dev = bus_find_device(&cxl_bus_type, NULL,
>> +							 &pdev->dev, match_uport);
> 
> Doesn't his leave you holding a reference to a device different form
> the one you return? Hence wrong one gets put in caller.
> 



>> +
>> +		if (!cxl_dev || !is_cxl_port(cxl_dev))
>> +			return NULL;
>> +
>> +		port = to_cxl_port(cxl_dev);
>> +		host_dev = &port->dev;
> Actually no. Isn't this a circle that lands you on cxl_dev again?
> 
> 		container_of(dev, struct cxl_port, dev)->dev
> 

You're right, it is circular. I'll simplify it. Thanks.

>> +		break;
>> +	}
>> +	case PCI_EXP_TYPE_ENDPOINT:
>> +	case PCI_EXP_TYPE_RC_END:
>> +	{
>> +		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +
>> +		if (!cxlds)
>> +			return NULL;
>> +
>> +		host_dev = get_device(&cxlds->cxlmd->dev);
>> +		break;
> 
> Maybe just return it here? Similar for other cases.
> Saves a reader keeping track of references if we get them roughly where
> we return them.
> 

Ok.

>> +	}
>> +	default:
>> +	{
> No need for scope on this one (or at least some of the others) so drop the {}
> 

Ok.

-Terry

>> +		pci_warn_once(pdev, "Error: Unsupported device type (%X)", pci_pcie_type(pdev));
>> +		return NULL;
>> +	}
>> +	}
>> +
>> +	return host_dev;
>> +}
>> +
>> +static int cxl_report_error_detected(struct pci_dev *pdev, void *data)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
>> +	pci_ers_result_t vote, *result = data;
>>  
>>  	device_lock(&pdev->dev);
>> -	vote = cxl_error_detected(&pdev->dev);
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)) {
>> +		vote = cxl_error_detected(dev);
>> +	} else {
>> +		vote = cxl_port_error_detected(dev);
>> +	}
>>  	*result = cxl_merge_result(*result, vote);
>>  	device_unlock(&pdev->dev);
>>  
>> @@ -244,14 +309,18 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>>  static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>>  {
>>  	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> -	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>>  
>>  	if (!pdev) {
>>  		pr_err("Failed to find the CXL device\n");
>>  		return;
>>  	}
>>  
>> +	struct device *host_dev __free(put_device) = get_pci_cxl_host_dev(pdev);
>> +	if (!host_dev) {
>> +		pr_err("Failed to find the CXL device's host\n");
>> +		return;
>> +	}
>> +
> 


