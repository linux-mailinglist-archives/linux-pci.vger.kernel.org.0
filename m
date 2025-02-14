Return-Path: <linux-pci+bounces-21520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACFEA3666E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 20:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA92B1893CC8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195FE1ADC7C;
	Fri, 14 Feb 2025 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IUpSUXox"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C218CC1C;
	Fri, 14 Feb 2025 19:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562428; cv=fail; b=M2FMtjdi2wKLCeW3aTLqC6Ni6gEw4m7tr7O3EeAfnE97dGJX0WqnpCdost0219J+wkDynIRWSG7KPqmuAYP60HhugrSvvobjHrWwh6zui7YCVjZFTUx/hDAK/HJCvHt8QR4T2Iab334g7RYFt+JHJ4zci1EHG1McqL3dgnZ1IoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562428; c=relaxed/simple;
	bh=QvoKyRHiQGSVFhWTdoRFNI6Zpf82B4cWG6GdEfmFSjM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HHj0lg+7/tkV1aQuwha1xJwOerud2KlOJ08bEH4SYOg6xq94PYuSCxB2eSZf2YUKE8zSKrwXXIXQ9gzqjKRbcDc2uZxobJZnR5fYNd2cVaAeI42uNDtzo2BNhDiw5tltVMCiAeR1si/Xa5YlpjC2Ucb8MQstvN/tbe35GcX68jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IUpSUXox; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbrVokX29xXx5r+eUDUIWSyj1/EwFxH7ktmL3NQ/elvsHmkjOgUj+Aw8NW8fmitUFv2PS2yJvxQuKAmaJpC+HnfmuyCLOx89A5dOSnpJMIaFsRTkDWKHq59+JWZsPL6fJtJe0oJVQMKE1ARaK2BBu1KOmYdjLmgX7UBwuXF2XVdcgUmJoRARgORU3dzA0mXwU4gp49xhYuln2iOLPkU5pIVRLR8XrtrgZ7BX0le7kYWN6OiGhn5U8kiFYfM0q666qGTvXClOUJFo4CsFs5eDI2XZLXp4DQxqX6+nownRdBbb+IBduVKwyHY/ZNuS4oW9vxxLWxVuijVuEezJC1Xdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvoKyRHiQGSVFhWTdoRFNI6Zpf82B4cWG6GdEfmFSjM=;
 b=BlzjMfknGundZv/hrVDzHNUzRbDxcxXZkbVLyvs0aX9+lp8ogwk3oftTx3mZrGO54TV5acrt4GfGVHcz96KOA00DtWJcomxhdtQ+vGFbPYWcA5BoX3Ja0GfkvPgRl+D8Q4CiRpWDj9ZzHxWAH6TfHKtyqVlEYJHNhL6J8Foc7SFytUlHp8EI41dz/6i+FKRoLU5+rQQ+MLNtzmgD2JlotJqTAbMT84PPvyJLKlcUCZLcof1YG5civ1xuc2Y7MFJXH7e2i9l1HFIO8sGt5o1H5GfGNfL5hpIhvjqhXikfgqE2Ndqxr10cKQFkrJMx5VCQRU8otfWXJiMTMts1jZVAMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvoKyRHiQGSVFhWTdoRFNI6Zpf82B4cWG6GdEfmFSjM=;
 b=IUpSUXox+DH1KgifJRZp4vcDvRkDZEIk+B4WbibdAuUISxFwQegEo4p0+hhaGCBQcNSYLC3Mibwha/rLtMKJ3IM8HNNTbaZ1Bw83N4A6MslzXSR5ImafI1tMnx5tWswRE3hxiKwPlyIKpqpOO7fZHtk2uy5yBFPRbH/P9J6A/Fo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Fri, 14 Feb
 2025 19:47:03 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 14 Feb 2025
 19:47:03 +0000
Message-ID: <9f2531dd-6ee3-4e71-9b29-4cdf9da410a6@amd.com>
Date: Fri, 14 Feb 2025 13:46:59 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/17] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 bhelgaas@google.com, mahesh@linux.ibm.com, ira.weiny@intel.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-9-terry.bowman@amd.com>
 <67ac00b78e492_2d1e29486@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67ac00b78e492_2d1e29486@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:6e::31) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b723523-80fd-4f9c-135e-08dd4d305a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2QvaUxNQmVSVTd1OC85REJxdVlaQkNkOEU1OW4yb0k3KzFUNHBCelpPb0U0?=
 =?utf-8?B?ejdVRFlBSnlhSjR0QUhTaHVWV002TlRlN1hUUUtETU9wK0wwRnRvdlVVd2RV?=
 =?utf-8?B?VEVuR0NvNko2WUVDdjdWSnhQRGp5M3cxeUNFa05Da3krVVdqaDdNeDdkUFJJ?=
 =?utf-8?B?RCs5eDRXN2xWZHEvOFB4Q1dIekZEYlhJTjB0eXB2Vk5GUUhBNGV4WG0raTZF?=
 =?utf-8?B?eVZIT2xCbnRJRUx1Rzd6aWZUZWd1Z0pLSXVUVUZuM0d3SnFrSDZ2NmpGMzdZ?=
 =?utf-8?B?dHFFVVNFbDd0azlKZmc2djlzMzlLSnRMWithQnhody9HTFBiOWZmeWlvbFBQ?=
 =?utf-8?B?d3cxb2VWcVBuU09VeENYd05iRXZvRDNQYnpZVEFNb0tIM2x0dUo2emlDUFZK?=
 =?utf-8?B?MnpVR1A1UzZHZFU5Z0dnNWRkeDZoeFNmTWlYR1FValIrU29xZTFVS2czOWxz?=
 =?utf-8?B?S2Y1dlhZZkFWc2Q1eEljb25iWWYrM2FGTFF0cmlmUmpIeEdGOEkyZStNV1RI?=
 =?utf-8?B?VEc0aUJFZWtLVGNuRjdHWlhLaGYrVlhRNks1cHdFQWVMeG5XTE5hS0lEc3Vw?=
 =?utf-8?B?QXdhQmh6UncwaUVCV3lzRjkwcFJwcnZ4UWkyajYyMEZuOHdLd1hndmFCbmlq?=
 =?utf-8?B?ZlJlcTEyWkJiVnIvbWFkMHBSWk0zbVEybkNwVGZ1QW5uSE9PRnZUdWN6TmJw?=
 =?utf-8?B?cjFoRGpHOURMQkZ1TU04Q2xXMUxaNTR3czIvRUdzY3FzSDJOK0lEaXoxemMv?=
 =?utf-8?B?d3pvT3V1Vm9FVkdRYnQyWTJyQm5uUURmSUd6Mzd3ZVNqa1lsTXRreVMyN3JG?=
 =?utf-8?B?QmJvaFdlclNXU3M3dzZMZlBqSFprQjFIZHdVSW1uc0IzZ1FPVjEza1NEV0F1?=
 =?utf-8?B?d0pBcFkrYnRBNjBUZmRSZXF1VWpOTmZmeDN3WVh1ak9UcTdsblZEUHNaMUJS?=
 =?utf-8?B?NUFmYWZZUUdvYlBtN2o1a0pHelQ3RDFIRXZ1cXBIYncwM2RhZVJiZTFEUENp?=
 =?utf-8?B?eUxpTFJrSXFnYmc0Q3pvZ3ZYWS91cmpULzF3KzhTUExBWWEyYXV1S1VEZm5y?=
 =?utf-8?B?aEJYQTdMNmFkdE8wcWN0Zy9iNEhoRHlNdGxEaG1IOEVuQW1DZnRvUnZQK2xX?=
 =?utf-8?B?Rlp3NFBMMmdnRmRod3pTdW5NbzVoRTNWMzNSQjVGMkQrNk85VjdvOVZkd3N4?=
 =?utf-8?B?aVJtNVcyYVZXYndYZ0ZGZ3JyUHo3TkxzYU1JUXFuSnRmS09sRHJlb2lSS21s?=
 =?utf-8?B?VEh0QzFJWldYNERQbVc1dUhnQmZ5N0VYU3pwYitFZHRVYVlsOVlJb3JxMkU4?=
 =?utf-8?B?WTlLbFJHR0xMZHFBM3JGV2NySGtta0lKcU9xTGVVdWZsRVZQbE5hSWdYOEhM?=
 =?utf-8?B?YnkvZEkrenFvMHJ4dDR2QjVZY280T1pWQ2R2aU5oSEdvNU9zNGtRSm5kaXlP?=
 =?utf-8?B?dThWbm9DTUNRR2NiTG9lUDVmZ3lpRFFCUytSNTdaa1l4aGNJNzBNeExWL2J0?=
 =?utf-8?B?MitzTE1hV091Lzd6UW83bWlxMW8rQUFRU3FmanBqaW4yY2laelhFS1V2aE5Z?=
 =?utf-8?B?Szh0VGcxUktlTVQxOTZGYVRCZU9IZENOOVdUU1lUSTI2amhTNExWVDJLcTd5?=
 =?utf-8?B?TWRCWXk3SkQySDh3cll3WHdrTkRzWnEwV01mYXZKZFpOZTRJSDM2M0wxVzhw?=
 =?utf-8?B?bVVzSWVrRG45RXRSeEJoQXd5bWxRV3NScTVEcWNRVzNXSTRFcWJhK3dhUWho?=
 =?utf-8?B?WUUzUjl6dUwvRkFBOU43NkFnK1J4RmhYWGorYmtwS1BrcG9VVTdnNFQ0ZC9P?=
 =?utf-8?B?YnBNKzZaNU9oNkNZZVYxV000TDlod3d4Y0ZGeVR4eHdCYys1cVVGaTZySDQv?=
 =?utf-8?B?SVRWV2NMcUpIVVFmSFNrZnFoNnkrS0ZBdWtxT3lIbTRxd01NcjRsdDRUYTlT?=
 =?utf-8?Q?bj2J7XqNZmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWYwQTlFN0JPbURGazR3ZWk3ZkhGeEZvQm9YbUF0MytnV1dReUlmNnR4b1BN?=
 =?utf-8?B?ZzFqaysydlNydEQ1SWhIbDdFbW53Y3kvV3RnS3FObW1iSVpjQ0k4MXcyMTQ4?=
 =?utf-8?B?d2JyU01SMDc3WUpLUjdqZlVLS0JiREMrTy9uMUdYWTJDL3I0c1J0YUNvOUZz?=
 =?utf-8?B?TksxeEc5QUZ3ZlFvMkV6dHQ4NndIUW8wYVl5Q2NTRG9waCt5Q2FZaHd3REdj?=
 =?utf-8?B?WUdSMUxGY1BzMHJGbzhzNHNidEtoYUtzVkw5cE9qU05KdmdweEF1dzlUUTZm?=
 =?utf-8?B?SzBPcTlZQ3Z3MzVQTkRiSlZkOUpiMjZmSmZLUWdTVWpNS2ozeDJnbElHbkc5?=
 =?utf-8?B?d0cxVy96aUJoNE5xbUt2eTRDWWVic0xmcWREQXhyWVRISWVHT0lORXFJTXNw?=
 =?utf-8?B?STdtSXhiUVppZVdBTXE4czhlaUViaUpCMmhNd0hHMVFNQ3Zxd25rQUEvUTZN?=
 =?utf-8?B?bXhhNktpalNUa1FiYW0zNkROU09SS3JrZ3lxWjBVWk9Kc3c5YTZob1Z1NjNU?=
 =?utf-8?B?VWtoWHd3T2YyWEV5dlBjQkR4VlcvQXhyV2lXN1VzTmR2QitEbFBPUUNyYldB?=
 =?utf-8?B?U3UxRWZBUGR5WE5tS2RXR3NSZW9yMmlyMERHSWJWQ2lwYXorMGxZdDEvYVgz?=
 =?utf-8?B?RThTSTZCY0FQQzl4cExpeG5pVHZIaTNOOG44NmtHcko2VmhIOERSZjV3QklU?=
 =?utf-8?B?T29UTnF0OHBsVDF3U3czRXFnVllNUmNKZGNYb2dVdVFZN1ZRZkp1N0tvZWVZ?=
 =?utf-8?B?UlVkM1JrQXQ4VTkwSDcxbm0zdzZwL2cwbWNQTUlEbCtjK0VLS2lyM3lVVm5D?=
 =?utf-8?B?bFM1RnpCSEd3anBIem5iTDdjRkwrU3R2ZzVLSlpoSDFFa2FCblEvZTFsUDBL?=
 =?utf-8?B?d1J1ZHl3L1ViRVA5MjdNZ016VkNvNERTdlBEMERKaUpUUnpsYTlDdkFuV1RN?=
 =?utf-8?B?Yzl2S28xV05aNUh0Zk1hRlRrMXhjU1dKM2pSYk5VcHZpMWVEZVZpcmNPVVQz?=
 =?utf-8?B?OTV0MHZZMEZWZ2ZRRzdpb0RNd0hqTmEzNm96NW9jdlRtOWpraHBZZ0xma2pC?=
 =?utf-8?B?K1p4L1YrZjFZN3hHaFA0eG9iRVdKalhXcWthN1NwWElDVGpUcEtQS0Y1a3Zr?=
 =?utf-8?B?L0MvenhzZzB3RVNNUmV1KzYrNkRvdzVOZEtYSVRYNXZCNlZZb1JZMTlOWUxY?=
 =?utf-8?B?M3NtMHBFL25lbUViSEhpZnZPOFBmcGVwa0FPWkMzOHA4L1lVWG8wNTZSSm5E?=
 =?utf-8?B?Umlka2JDendZSmE2RnVUbTFlT2hZRTBpSXE3Y0d6T0liUFJINXlUaFU3TXU2?=
 =?utf-8?B?MzE1WVNmR2JIdEJnclZsZ1hhR3ErUnVUaTBHamRsWkhqbWNHbEFqaWJ5bGsv?=
 =?utf-8?B?SXhKWms4MlExQnBIUmNTTkFHK2I0Wkx4ckdmOWhMREd4OXltQ29KM1pxTzFM?=
 =?utf-8?B?Nk9UOEtKRkFRL0I0WjVhTlJPdkhoZVhJZnk5RmRBSENvSDNxdjVWWVJwMHNh?=
 =?utf-8?B?NjY3SC9URHRLcWp6U2ZrSERxQnRBdnF5bmtLdlhtR0lpV0pWWlZXOFFxK3Ez?=
 =?utf-8?B?U0ZUbzJXQUpuQURHNVB1eklQd1dBenJrUXNNckxaQ0MyZEZuSWlsUkRRYThh?=
 =?utf-8?B?S2tOdUZlcGROQVpFSjVuRGt4YVpFRWhzaUNWd2Zhbjh5M2RhYzVZMVlnUHB5?=
 =?utf-8?B?TUtEZDNuZm1EVkhIMGIyb01SeU1HZWFtTFBpQzNUYWc4VTBNMXVEWVFZU1FM?=
 =?utf-8?B?Mk9qT1RuNExwcHJBb3NIUmI1WUFEbUlIV3BwWjFuN3MrTGxjOE1wS2hkeEhF?=
 =?utf-8?B?SzFnY2ZqUWh4blVreVJRRnVMYXRFOUVBem1rNE1DOEtPK1ROc2wvVW1MMkJQ?=
 =?utf-8?B?SDlrU1FFVWQwazI5ZFozZUJTaWhjVUZWT2ZIOStzTUNPMG1wM2o1OTQyakxK?=
 =?utf-8?B?MEwrZ08rMHhFTWhGTHFRTWdSMVdWYi9jK1N4WDdxSFNLWW1HR1hyeERZMmhm?=
 =?utf-8?B?MUJ2eDhMdklSOTFhdEhjeTM0M2VFUWhqMzEra2NuRFFyL0c4VzI5bk9kWU1w?=
 =?utf-8?B?RWJrTm9IZkd6UHlSQURzWnBWNlJpRzhiZWg2YmEzQkNvY2R4Tk45cVg2QVJE?=
 =?utf-8?Q?LkU0chgPy5+6mvSBPci8K4RiT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b723523-80fd-4f9c-135e-08dd4d305a87
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 19:47:03.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUa0puW0fqS8RX4v7ud7XP0q2eH3ih9E0aEzZejUGMjgLFoLGrOuxXgOPdLl4AgxgUso2nMMKakK0Ig9lsxb6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786



On 2/11/2025 8:00 PM, Dan Williams wrote:
> Terry Bowman wrote:
>> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
>>
>> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
>> pointer to the CXL Upstream Port's mapped RAS registers.
>>
>> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
>> register mapping. This is similar to the existing
>> cxl_dport_init_ras_reporting() but for USP devices.
>>
>> The USP may have multiple downstream endpoints. Before mapping RAS
>> registers check if the registers are already mapped.
> Yes, now this sharing makes sense, but the ras_init_mutex +
> cxl_init_ep_ports_aer() approach to solving it is broken.
>
>> Introduce a mutex for synchronizing accesses to the cached RAS
>> mapping.
> In this case, especially for VH configs, you should just be able to map
> the RAS registers once from cxl_endpoint_port_probe(). That will
> naturally only be called once when the first endpoint arrives, and will
> never be torn down until the last cxl_detach_ep() event triggers
> delete_switch_port().
There is still RPs and USPs that will be called for mapping more than once,
right? This will require synchronization, right?

Terry

