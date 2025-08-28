Return-Path: <linux-pci+bounces-34982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C839EB39797
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0969982C0B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD521B4244;
	Thu, 28 Aug 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yDJSW10X"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93B1C01;
	Thu, 28 Aug 2025 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371486; cv=fail; b=Ww5qwwsn7U0pvzn/iEk9sPSgWOAJ7sili/c5IYHZw/qtDgEdvyKu8wliVTYaBeXIjD0e+LEpdlrPbKQpZpD0CuO6umaT2umB7ZWMaHJaM0ac2iye84VgBWRB4ePQ3LHW4ZDmjGN/6j/jjajV7kR8ywjrUrvyVWJ8pZuo/tJ109s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371486; c=relaxed/simple;
	bh=iOr0wix/Ym9ReANoDvwyeXjo8UyCKyYl9NkSLrz3+7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uB/j0ufijNiRSxX58YXTv9ouAtecb/XKgRjzAA55IfAYZRpD1aXKXiJWhwPYwsxfxwrG9YoYlKJBd8BziaGTV7ydQspVbD5EgUCr25FKKnc7AlARqL+fY1FfI/E4mdedEqIcAuBATgxVffB1/dVknJ3nYcX5gY/qhHpUPyWZa5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yDJSW10X; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL0YxuiqnMnzfGIGXQJkjUePwwOao/Ah94vFWQPkDasRYr/MnMQJPBiFoFYboGzKwCGZJDRj5b/FxrWlWmE1fyUJGCapGrsxR3Ct7Fm5JaF0kKIK0DeUbFIQ9MOYeeRJD6SN64RmPeQhQHjEO9iAvSPvsMKgG3b8XttPFiq6Qj4a2zVvtZtDDHQjMqhqV4XpMLWsm1RhQ3U/2msOM1B9qUOBR2bajcYviVDY2bl20U/PWwDYScfmg+YlTAgcCSWpi5ryin7kcDCWLY4nEY/ITsC4BZy7Md6UFakWAc8ht/bHnCItjZvxecYhn2wrot4F87sH946h14W/29rs9Kthkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cj/qpXLbECrzog/+GUXmVxpsPlroiBkKh5s2EYwDn1o=;
 b=QtvL2Mh2AVqFRohwQU6/nNzhPzlSekK/VzlE1oGpxiL4i8fwktqhRjgI3/x/LLTUwFfGUS5ZMha5HGF6G+7U1cWVAeLugX2m2w5rt2AqeZd0UNMNyCR9s4pDVnVd8Ii6T+xZHCskdNK8905ZQymuDY83dPeA5voL1FQRGLOBTLWwcIK2re0h3l1+jtIfcASrzISqT8I4s0e8SQTT7O/AtKZr8Q9liQPI3a7KmyLc+UD/I4AfpFmzsqTbgfS7vmp16r8JjMTB97IWW6I6ujlzB/24bPoKyT5gnNy8TJRKilJgAR0yWPO6k0DsB+BSVjJw1HgK31+uUKLSQK88aWtCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cj/qpXLbECrzog/+GUXmVxpsPlroiBkKh5s2EYwDn1o=;
 b=yDJSW10XTA5SYhfsZj2Ae7phzI9t9zJCU8GP1GEqxup0g6Jm9XJJGhdDjrljLUrXIHe0zEX9eh+Gq/Z0lwFuJNws3hnTA5CIsdQUj6nuKlhUxccyg5akMRMhz/eqIRIn01bGijH9cuL4z/4BJRJTKXwNPTzhbEK9nHvBMCTeajI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 08:57:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.9073.016; Thu, 28 Aug 2025
 08:57:57 +0000
Message-ID: <12a3ea6e-56c0-4d7b-9d75-43c13c03e9a9@amd.com>
Date: Thu, 28 Aug 2025 09:57:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 05/23] cxl: Move CXL driver RCH error handling into
 CONFIG_CXL_RCH_RAS conditional block
Content-Language: en-US
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-6-terry.bowman@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250827013539.903682-6-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0232.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:238::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b171e3-c0ee-4293-342b-08dde610fbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akl5bVp1K00zbElDb3JvdzdkQ0kzN2NNdlIyR3ZwT250OHdiZGNneTRBcDhP?=
 =?utf-8?B?TFBWYkUvbHhrWlVpa3NCQ05mUkhzZStuOWl5cGRUMktwV3p5MDRZSlBMdzl2?=
 =?utf-8?B?cWk4TGxtdUNJSWx1eTRXdE9oSCtleVUxYTdwa2NhWlRBYXJEbG53NE12V3J3?=
 =?utf-8?B?MjJaZm5KTXYzUDJrTUd6QkQ1QVZ6Q1UzZSttMERqYWxpZGV4VjNFb3NhRnpB?=
 =?utf-8?B?YnZmSXlpdzRRVVNiNE9oWWRTSTIwczh4Q2g3S0E5ODZTbDQ2TnM4SnROMFdF?=
 =?utf-8?B?TFdnMVpUcG43Z3l4eXZpWTE5eXhYcmQxbkwzc2J0WndvRFZOSWJwZnhvY2xz?=
 =?utf-8?B?aFBJdXhUMnZTMlJkS2hsV0VSMnhZV3lvWURIRGtCNHhDQlFkN2dTdFFsSXdR?=
 =?utf-8?B?RlNKRU10a3dpMFJoa0NZeHB3UGxiSTdGZzRyYnp5L24yamJWSUs1eTdIL2tM?=
 =?utf-8?B?ZzdxUm02alh0djVWbWNWQis4MnBiUUdVSG55SUd4NHpEeUpFWmJncmNFQXpo?=
 =?utf-8?B?RzVRbkU0SWRMa2hqaUNvTjRnV1dodlpKdHJZWHFwYmx2Ri81aFdaU0VpS09E?=
 =?utf-8?B?WDZ4QTc0bjRmWjBncFM3cW5vUHhsNzVoUzlwMy9MMjdrenlZN1M2by9HQW1m?=
 =?utf-8?B?YTIvR0MzTjViVDNXazBTRVNqTVNRbjgydkhhVkxBSVZWRTlLQjVXTnRhYjFz?=
 =?utf-8?B?YS8xMmg0OXRHeTlVR3owT1IwNUt4NUhiNjJNVlFnc2hQWUNGdTRJNklQa1Jo?=
 =?utf-8?B?RmFtYlVKWWNUWStsU25pa3VvdFdvN2lmc0llY0xKTSsycUtJeEV0Y1VjcmJZ?=
 =?utf-8?B?QWdQL3VzTytEOXZWRnE4SFlTQkxNOForSWhodkR3Qzl4UzNoSmVmQ2Ric0h1?=
 =?utf-8?B?RXVjQVVUTHBXa3hDeWZaQjlZVU5jNmFXamhQVWo1WGdTT0JPSGo2R0sxaFBG?=
 =?utf-8?B?Y0wzNzAwczZWelc0YXZNYlFTdFovZDk2VXd1cUJsb3krMU56Mkx0amxvVXhN?=
 =?utf-8?B?cmJIOStxOTl2b2lnL0R0NUcwTUpReWJnUDFzWnNsZmhGd0VFNXRrd09jdlpj?=
 =?utf-8?B?VHk5V0NMNEwwN00ydkQyeGFQQ2RpVzJnMjVHN3A3TElBLzU4OHFBVHA3dUpn?=
 =?utf-8?B?Y2U5aWlRTkY2aEtYcDltSUxWMHgvaG85am50ODFQR1dLQ0hoeDFLZzdRSWlR?=
 =?utf-8?B?ZDFPOElsSVF4R2NYamUxZFZpUTRSZGdPY1JtQ1JZTi82S0R0Q2ozMTM5Nkhh?=
 =?utf-8?B?QjFwOTkzYXM2c0llU2wxVGVDTi9tNVRINnhHTGtnUzJJSW5ITUV1OFdQOHRx?=
 =?utf-8?B?Z3F1NlRKNDZYQWhodXVmRGpaSnpkNDd0NXh3QVpOVGphZW1KV1FFRUlRbkhB?=
 =?utf-8?B?ek84TEwwOHB6SEFxVDQwNTYySkJnOHQxclpMc0lrWGRRbDE3NTFVSW1LaDBK?=
 =?utf-8?B?TGZjMlZ1SlJlTWtPSDFVd3RUNHFFNGU5YXp1bldEWmJyVEw2NExaSFBDVVQz?=
 =?utf-8?B?b3BibC9Zd2VEcTUxWkNzT0JxREpsL0l4OHhBN2dFSnZqcGRzZnpCSzhyNDVM?=
 =?utf-8?B?bXA5WHZOUkZXNUd0cVdYa1B1bGp3ejcvSU1ZOGhDaVpYL0pIVEV0c3dZOEJu?=
 =?utf-8?B?bWFtQi9ma1RtZVQ3YjgzWTlkZ0pIdmNyNWR6TENmbzAvNnZ3eTZLOHJ6cEVs?=
 =?utf-8?B?MlFjS3liZkdRWFpJYlJQc004VmtROGovYWV3NDhqd1ZLVzZibzYrWnZrY3Z2?=
 =?utf-8?B?VHZaSkJsS3orY3ZYT0NXY1hia1doMklFcTFGUnlNa3UxdFFVYTlTSVFJWHRl?=
 =?utf-8?B?YnFHYStqbEZ4dzA2Z29oRWZzbUlXbXFOTHZLZUY0Zm1CMU1xdmJqSis3K0k4?=
 =?utf-8?B?TDZWZXk2WGdyUkFPQ2NRRkY1aENQK3pRT1lXQU11N3J4Zit4SmNqT29QYW9q?=
 =?utf-8?B?a1dwWi9Dazkxc0VXMXdKeE91VmRrdE9LVEZzKy9QZUd6WFZrV0pJQWtLUnd4?=
 =?utf-8?B?azZzbjJpQ3pRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVpYWUI3eDVBdzl6TTBSZzBtVDVtMHNKTmhIKytaVVlRUUpsL0puazhqS1lj?=
 =?utf-8?B?RzdaUWIvVDM1UDFjdk1sYlVDQ014Vmh6UDJXZDAzcW1obDBjZ1RsTlNia3pZ?=
 =?utf-8?B?bUhHS1BPdGQrOWdKMEdCMjUzdnZRWUhaaXFOZ0JGVkxEK3FPV2tSRmk4TFpo?=
 =?utf-8?B?RFVCRjNKaHFKUTZNTDJ4WW5Sc1BuSGlXRklHMzlrbExQWFJQNzZvTE9kK2tX?=
 =?utf-8?B?MXBVcWllV3R2SWFGTzRwVG9vVEVNT0s1Tzk1Z2NYbW5PTVAyTXZzRW9aTjlz?=
 =?utf-8?B?SWZrVndLazhZeEZDRkplUy9UZU94Y1hSeU13end2UUNUVGxzbmQ3bDBlNVVa?=
 =?utf-8?B?cWk1ZVpETlpMTjdRRldzUDNoaXV4RENCV3drbUlOcVdTcnhrSE1ieVBHb1NX?=
 =?utf-8?B?L0RlblppK0QvUm9DaGdQSG9WdHV0ZlE0UkR5eFUzWGJMM2hGSGd1dksrZEhZ?=
 =?utf-8?B?R3FTVGRwblgrYUVPNGdKZldaYmpxZEJ6OVpqRXVMeXJ3eHE1c1NmdGJ2TmdX?=
 =?utf-8?B?YVFrNGg3c3NaNUREMkhFOWxSOTVkZEVMMU5aK0NlMlcrendrZTJ5MzUzdHNj?=
 =?utf-8?B?TWF0MFg2dTJRcWFGaE93MlNDOHhBVUZPcnFna0tKOG5aVi9pT3pRUm1DbmpX?=
 =?utf-8?B?NEdRMlRlODZtQ3lJRGF4VGJBNmtkUE9Kdk9IOWtuMEY3bW91eVIwaEpvKzlU?=
 =?utf-8?B?dm93ckpndDBtNUFyclBBem1VblI4RUVWTEFJNi9EQXh6VzhUL0laU01UNUtp?=
 =?utf-8?B?MHdwK01RN3p6SXhNSmM3Q29UMzZqVThYZWxSOHZoL1lGYkREdXRGWXJuWHcy?=
 =?utf-8?B?ZktONWliNTRFY0p3UEkrampJR2ZzYXJYRkl1MjkzWDVrVThFcTcwWi9zMUhk?=
 =?utf-8?B?ODErdjJWQVBleTRaa1NpdWUxcFBSTTZoV2VqK2E4enZjVTlSRktGZTRWam54?=
 =?utf-8?B?dmRGVjBJTXp6UDNSYTdEZDdVMCtQSUJrS2hHc1cxWmUzQkViVXZWU1ZiUFZO?=
 =?utf-8?B?Z1BJQzlXbThMcXE2SDRwU1orS2ZPL3JUczBjNkhsR2ltVDIxN3Y4Z0tpVkNk?=
 =?utf-8?B?cmdnNnBYTms2c0VhNnF3K1ViY1pmMmVGOVlkTmpsZklPSytNUEc4bTh3TmlO?=
 =?utf-8?B?UkRFSWVWdmZ3RlQ5djU2cGFodWc5N0tPYzR2dDZ5clVkUlpZRkVnTVpMd3FN?=
 =?utf-8?B?MVRUajhhOC8rZFlUczBSeGxZYmdIbUs1d0pMMkRFZUpnLzlMU01uc3dUTDRN?=
 =?utf-8?B?b0M3QUJQeVZ0dW5jTWN3eG1nNGE4SkcxeHp0WFV1bXVRMUtqUXFkbklyalpB?=
 =?utf-8?B?UWxMcTN5UkUwMzVhbUlMY2NSeVFDeStIV2FZdGN4S2V3amp2ZGZqaGM0bXpV?=
 =?utf-8?B?NllhZ21VWHZrOE01MUMxTUZldWMyUzBvMTdwaWYvRWFocmRXeFZTd2V6K2Zh?=
 =?utf-8?B?azNQSHdUZzNTckN2WlkzM2czYkVBOUZIZHRYcE5ZbWkrNXZRUDN6ZTZmNDlx?=
 =?utf-8?B?Q2NmT21pMTdreWpVWGl2VEozMzJqamU2MnpteDBQUTMvTmdJdVU1eStKc1FY?=
 =?utf-8?B?RExjYmZ2aGRMUWJrQzk5OUgyMm1jSTRlakRWZlBrL3hsV3gvb0RKcmRCNWZi?=
 =?utf-8?B?UGUrajBocEFZeU42YXRlL2hTbmhaRTc1SUFuRWM2T0xaM1BVUktTQ3pPRC92?=
 =?utf-8?B?eXJ2K3VJWWprbnlmSHlJZFdJUE8yZVhoQm1YMVhneGsvR085ZmExTXhqK2lx?=
 =?utf-8?B?VVBqTVR5azM2TGM4cWIzZG5FbFpJeU8rUm1hZ1QrTXYvQlZrbTNrZVdBaERx?=
 =?utf-8?B?SDZnR0pWVmZnb25tVlIyZ0x3Y25JRi83K21UdkozZEdOYU13clhIaEcrS0Ju?=
 =?utf-8?B?Z21KNlRwL08xT3FpWXpwQnc0N0dZZllwUWdEVEhtdXR1VitBaWUxRTdzcjdW?=
 =?utf-8?B?L3EyWHN4aTVpWC9sWUN3clBqQ243czUvWGVwSFdkckZWbTAvaTVmdWRPQkgw?=
 =?utf-8?B?elIvc0t0NUR0RWNEenpPSXhYOEtUZDZYMzhLUWZCQjViemcxd0hUMVMydE92?=
 =?utf-8?B?YTVmZW50WC8wYVgycDdFL0RuMFN5YWxsb3RyNDRYZ1pVbnp5dFBNUVRNTUtq?=
 =?utf-8?Q?YoBMzE+nJMhySWWP8nAFXpAqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b171e3-c0ee-4293-342b-08dde610fbb9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:57:57.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GASxdJCOxnn4fx0tBs3ySQaSHh+EIagvA0wq6jcWVbBfK/m6i2HyvJDsDpA6lrC/qtdx8V9IY0+HVCNeWwkxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688


On 8/27/25 02:35, Terry Bowman wrote:
> Restricted CXL Host (RCH) protocol error handling uses a procedure distinct
> from the CXL Virtual Hierarchy (VH) handling. This is because of the
> differences in the RCH and VH topologies. Improve the maintainability and
> add ability to enable/disable RCH handling.
>
> Move and combine the RCH handling code into a single block conditionally
> compiled with the CONFIG_CXL_RCH_RAS kernel config.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>
> ---
> v10->v11:
> - New patch
> ---
>   drivers/cxl/core/ras.c | 175 +++++++++++++++++++++--------------------
>   1 file changed, 90 insertions(+), 85 deletions(-)
>
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0875ce8116ff..f42f9a255ef8 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -126,6 +126,7 @@ void cxl_ras_exit(void)
>   	cancel_work_sync(&cxl_cper_prot_err_work);
>   }
>   
> +#ifdef CONFIG_CXL_RCH_RAS


You are introducing CONFIG_CXL_RCH_RAS in the next patch. Is it correct 
to use it here?


>   static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>   {
>   	resource_size_t aer_phys;
> @@ -141,18 +142,6 @@ static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>   	}
>   }
>   
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
>   static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>   {
>   	void __iomem *aer_base = dport->regs.dport_aer;
> @@ -177,6 +166,95 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>   	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>   }
>   
> +/*
> + * Copy the AER capability registers using 32 bit read accesses.
> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> + * status after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	/* Use readl() to guarantee 32-bit accesses */
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	struct cxl_dport *dport;
> +	int severity;
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return;
> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	pci_print_aer(pdev, severity, &aer_regs);
> +	if (severity == AER_CORRECTABLE)
> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	else
> +		cxl_handle_ras(cxlds, dport->regs.ras);
> +}
> +#else
> +static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
> +static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> +#endif
> +
> +static void cxl_dport_map_ras(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
>   
>   /**
>    * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> @@ -270,79 +348,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>   	return true;
>   }
>   
> -/*
> - * Copy the AER capability registers using 32 bit read accesses.
> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> - * status after copying.
> - *
> - * @aer_base: base address of AER capability block in RCRB
> - * @aer_regs: destination for copying AER capability
> - */
> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> -				 struct aer_capability_regs *aer_regs)
> -{
> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> -	u32 *aer_regs_buf = (u32 *)aer_regs;
> -	int n;
> -
> -	if (!aer_base)
> -		return false;
> -
> -	/* Use readl() to guarantee 32-bit accesses */
> -	for (n = 0; n < read_cnt; n++)
> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> -
> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> -
> -	return true;
> -}
> -
> -/* Get AER severity. Return false if there is no error. */
> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> -				     int *severity)
> -{
> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> -			*severity = AER_FATAL;
> -		else
> -			*severity = AER_NONFATAL;
> -		return true;
> -	}
> -
> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> -		*severity = AER_CORRECTABLE;
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> -{
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -	struct aer_capability_regs aer_regs;
> -	struct cxl_dport *dport;
> -	int severity;
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return;
> -
> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> -		return;
> -
> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> -		return;
> -
> -	pci_print_aer(pdev, severity, &aer_regs);
> -	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -	else
> -		cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -
>   void cxl_cor_error_detected(struct pci_dev *pdev)
>   {
>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

