Return-Path: <linux-pci+bounces-21226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42CA316CC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 21:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A421887231
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5826158E;
	Tue, 11 Feb 2025 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKnr97s+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB78265626;
	Tue, 11 Feb 2025 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306336; cv=fail; b=MjHcYxyBwaXpag2n1BWWhkeokFAUyOnhr+B2Bx6uS9o6EQvbeeJ4sCaQZVt5wMJCmI1u0R8oVMJNxEHMkjVpv4eu36KAGg5LdX7lFJlR25WDI6QToIk8FwuCr7DvQCpVeieY9FSO3++KD6CaQ5Db3yt6rDS0q8DDbcnb8qRKRVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306336; c=relaxed/simple;
	bh=49nwqTu+UQMdZ8xk7r8At+LtqrIfReEck06bNG74Ax8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WmOxDo17IhX7cfd+8V2Vfebzgd9eCJ7AWI2dWI3YelIERILd9iNUCSLfwFiymVJI+qdKKngUwQh1TIEZrmKposnuABryvHX5KDFTLsn63XVrFkqvTNDtRcLK53bVWdZr4B1o8VsEq5sSwVEKuKUB6dTrQ6rDSCCbuzsJSQJakRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKnr97s+; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRleI23Vss0wD1kVaXtQNh60UNk39tMAAIhnhvITyRGD2nICDr9fROh27A7gAQSms5DGVjgg296owb8b4pNZfo1Imwrw8G5NB9UbvMLhi5Si1orG/lU67ktJkMnSLsUARt4QDIGjeJsM9QyrvByd7n5uvZK5f+Z7Z6EghlRnGcSbelcjOWS1PGsHGaBsLj2WjDOmjmkl2R9BzPDzWaNwlSTAZ+EPnVc0C8G8GqRYOLjOKgWheutv+flIliao3Mf/FFkF+tHX/hDGbXtvDWvMIwJaqezF859MMnGG5qAEMI+fGj+xLF0Cky/iILcBrDG+yq+n9bn3i1q5LoZQpLfscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/rMQyB7ozeOElsK2wYLeDei4/f8gbOxL9lCeGJiTP4=;
 b=KjRb0KyxQ13OEjY+LSyD6mAvq8cYhf0OmlEsTCYlbm/QuFAEhmDf9EoDFvFoUoeDREY6JHbZM9rYxVhhQSZPg4ITbtawXt7yoRR0ZW3AW8zuYBMy3Uzod7bCJmpSHdFH7PhQJHRhqWkavLiAqVBslMJcW9RJ2Ad8CBR9Bi1kXX9NmENJ/1lsSiM1xaf/bB/CcbTp2wa255jzp51uq+c3uhYT4SnBX+evv9Q0sbSrDJ9esQiNPqQjORiHf8OszN9ZwLz33+56OjF0U/QfrjXE0uOFYu/Ec1xEp1as4JUGTOWLZjLTfSCukzuqpbqRWE5UWHk6O5Xa/LwQRv7qYwyjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/rMQyB7ozeOElsK2wYLeDei4/f8gbOxL9lCeGJiTP4=;
 b=uKnr97s++p+BONHmQDkQFOv68p9JYsmNN76XUQmJEAy+XgMhkXXBO5bZEQ86AntTd+7Bf1Kb/UzRxVtCvTRDVcHUlupHVf6Ll8p/vr5kaqkmutV5FBOdo4rAD2lA2+vL2VEIKJJIzwMvHppd9tdXQqNV5FA75ijxUR3Bo32Kpvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Tue, 11 Feb 2025 20:38:51 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Tue, 11 Feb 2025
 20:38:50 +0000
Message-ID: <91dbfcd7-8ea5-4ad1-a975-cda0a8af2b28@amd.com>
Date: Tue, 11 Feb 2025 14:38:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/17] CXL/PCI: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211202827.GA53859@bhelgaas>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250211202827.GA53859@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0133.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::18) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b3b402-c351-4467-9122-08dd4adc178b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODQwQTBKVUgydUdOOHhGdzlLRmpnNllUOElZRUZVZENWdmhmbm1ISUFkWWRm?=
 =?utf-8?B?ZndjNlpXeTVTakxjVzNOaWtMaFcxNVRCWTFNNWNENjcwbHozUERVVnZ2OWRI?=
 =?utf-8?B?VVFHelV6RjdPMnF1aVEwUFZPVmlQbFVqSERRbk9zWThmbVpVdHo5WmVvVld0?=
 =?utf-8?B?UEdwcm1PeEY0SVpUWnlMNzk2Nk94WU1nUWtieTE5eEJqVGJVMGhJOHVGMzdQ?=
 =?utf-8?B?ckdOSEFjSFhrYTR5WWVjTmpjSTdZZWIzY2FFUlM4cTZCMHRKYmg2bTVWakNS?=
 =?utf-8?B?NzkzWENNaGJYTllVMThxdlRhdWdxeWYyVTB2U1pCWkIzSnVPZkYvTEJqK1pS?=
 =?utf-8?B?VVpWMzVhZndDb1F1bzFQellwbTE5SzRGWDBTMDVtTDQrSjZNZkFMQU5Lb3pw?=
 =?utf-8?B?VGI5OVBZN2RNQ0FXc2gvLzB0MHRxMzlWZ2FRWTlkYWxwdWNUYTZYZC9obnRQ?=
 =?utf-8?B?SHBHU3NnUnkwVVV3NHViUkVva25zc01rQmNvY21pYy9sTWZLZWw4Y0ZzeC9B?=
 =?utf-8?B?eXhmU1lmWnp1RGUycTBzd3lQZ056K21RWFMxVzhxWmtDM3NLdnI0MG5TOHNO?=
 =?utf-8?B?djV2Tm1vNXUyQUJDQVBKK0tNRFkwTWtSdk1lb3d2ZUo4NDBWTW5FNktKQ1pD?=
 =?utf-8?B?bkZGMlVUSi82WHoyWjlsVUMyNFZ3ZmYzMFo1QVphN3A4bmRvTFVsdEpMNCsz?=
 =?utf-8?B?S0ZXN0hPTnk2NE80bDV4cjAzVVdQOVVUL29yNVhMbUJnR2poajk3SW56K1Av?=
 =?utf-8?B?V1oyNEJwNElWS081QkNObWZoQnRGTkVsSUNEdWhZcTkrNDN1U1NRK090aG5V?=
 =?utf-8?B?d25QL0FxVzRDenNiT1J2RVlRSDR6cjgvV0dVYm51WG50ZDBkdTI1UFY0ZHhj?=
 =?utf-8?B?eXNxNDE4SUhiK2FJNmRJVGdid1VNOU9LUW42TW1xRXoyK1ppa2VRdG8vU1dM?=
 =?utf-8?B?YXJMRzJoRGg0NXBiUHdSWVR4NnRyV3loNHY1U2Y2MklVRGRYMGNTRFNNZVdi?=
 =?utf-8?B?MjZhMG81am93dVpVVFN2QWVSc1NLZUtlZWt4bnY4R2hPK1VXcUFnUFVTckhD?=
 =?utf-8?B?ZndvK2IyTE4vQVc0UWNEWTd6djZINklqYS96NllIK3JJUk9LQlFwZVczS2Zp?=
 =?utf-8?B?SlFHTHFmaHA1OWJ1VG0reFVwUy9QYmRBT0JibndGV0xWZ2I1ZElreUtJZERj?=
 =?utf-8?B?YWdXZ095MGorQ04wTFJYM0wrVkxhdGoyYlpZbFovM21ZQ2Zwek1QeExBQ2Qz?=
 =?utf-8?B?UHpMdXRmYXZKM21Ycmczd0M2eVpra1EvVTNOS24zODBXc0lOTDYrc1Q0NWRv?=
 =?utf-8?B?SjNFeXVMZkpzMitFZmVWQjFza2pqdXRocnJXU3BUTE5MUzZyNHp1VWZ1R2pH?=
 =?utf-8?B?bGJVWEY5UCtSWXBaV1Rsd09sZ0E1bnB0b29kbnF5QVREZFpheGpuUjVzVTFM?=
 =?utf-8?B?ekc4aGd4OE56MzJKamR0WExONHBncFdOUUZkMityY0dDL1NyS3lsOHNDRDJa?=
 =?utf-8?B?NE92NklwY0V2R1FRSEVZZFZNN0FYVDh5THM5UzhBTDhPVkJjM3BqT3pyLzFI?=
 =?utf-8?B?Q044SUIyNXpMdXU0UEVHUUtjMWdYcU5BT2pvaS9ja1dFYVFvRi8wUzlZS1p2?=
 =?utf-8?B?UVh4NVdlOVd2ZmJLVzlUZE9VTEo5NnV0SXlOK0d4NUxxZ3ZXa1Uzb0pQQ3ho?=
 =?utf-8?B?dmhJN2h3ZnFLbUU1Vm90cEN6U3pWTmVxVTVkeDNpRGh4eWt0OUswdlNKaGRV?=
 =?utf-8?B?ZTBSVE0vMXNpbVFhUDdwbVRFOG4vSmJzN0M1SWRFQ3ZlZDhqTXZBSyt2SFE3?=
 =?utf-8?B?U1FlbURIbmtFZm5IWHhuc04zTCtmelR6Tk9rUzJ1MGRsOWlOZzZvSHhLWmhz?=
 =?utf-8?Q?IxQrz9XaUI2XU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0dHeHl1ZnpFWmVCajlvVGFibG9VdEdTNlh5bTVva3VlODFBVHk4SEROOTBT?=
 =?utf-8?B?VGVRVnFONHBjQzZxSm5iL1U0VzV0NEdEcHd2RVdaVE1Yb0JMVFlYU0w2VkJo?=
 =?utf-8?B?TGRDQkE0L003NEZlV3BrRm9JVi9ObWRrbzR1TDZRT2h0UWNvQTVFK21HaDB0?=
 =?utf-8?B?Q2d4S3VzK0EwcC9MN2ZZZU1kc1FBVTg3TUdmM1A2N1FLLzlJYVp0cFpoSEFZ?=
 =?utf-8?B?cW45RmVwNGRXWk9UVEJ0YllidFQwZmM0WGRZZWh0YUxrcWtEZk1VcUhxc2x3?=
 =?utf-8?B?S25ocG5jZ0o5M2xzOFo3eGIxaDN1QlJIT0hMR3ZaKytCYkE1S0kxNXl0eE1y?=
 =?utf-8?B?QTB4eloyMnNEQ0ZOOFBCWi9qTERNSVQzNzdzek5yNEZjRUwyOUR1bEdodmN5?=
 =?utf-8?B?VlJsSTlwM3BNZDZlVnIvdWpyWmIxRWtpMmNmbzMwTFhuUkxKNkcvYmJNcVJl?=
 =?utf-8?B?UVQwZ2dUQ3dybTQzNzh6VWRqTU5SOVNRMk5RR1UzdEh2RERwalpjMTJRSC9k?=
 =?utf-8?B?cUVidXBTZi9yZElSdWpCQmNXZkduYjd4RnovL25Hb0ljSFdpeUx3ejRBOEgv?=
 =?utf-8?B?U3RmRGsrakFSU0VkMGNhUlZLVnA5L0FRM21JQmZpaXIxaG14N0hoR3l1T1NK?=
 =?utf-8?B?VDVtaE5HL0h0UVlmY2VsczZDNDNPK1R2Y2RIWnVod1JDOWx6a05Idm5CakhJ?=
 =?utf-8?B?SnhJblgrekYxVi90SEVhS3ZGdnhBVGhuKzJCaUUzTy9SMjh5TDhxN3pxM3Jh?=
 =?utf-8?B?K013c3B6bkdudG15cjRTVkJzRTVwTENxQ1p6bVNpYkplcVl3emFNYTFWQ2JO?=
 =?utf-8?B?VmJYSnhTOWcxdXpVM1lOSktVNnhKVFM5VXhuUVhoSGRVOFlhbFdrU01qdlJE?=
 =?utf-8?B?dXM4MElsZC93Ti9WbUZwM21pQTdtL2VKOThjdURUWVdBZW9LZldPbXRGcWd3?=
 =?utf-8?B?c1I2Ty83eE9CeVIxZTh3Qm0wcUU4T3JJZWljUkh0UVd6VFRwSG0zOUNaZlJX?=
 =?utf-8?B?ZS9uU1VmcEFVRVFqMnNoN0djK2VRS2VLSXRTaFR5SENNTG9oOHpRbXdkcmJP?=
 =?utf-8?B?QUVMWkNWZDFkWi8rY3pLdWNWYjNWamxlSWFtNWY0ZlhTOFE3eHN2QVU5S29o?=
 =?utf-8?B?bFB1dWlzVTdOYmtVUFVVVHlhWFBTSStIM25ldVRxRkJPWjllVTFNamZLN29q?=
 =?utf-8?B?VS80OWJxUXduYWg3bi9VSnFJdjdhZXU1d1R6dUN3d04wUWdvU3l2UlZkem5k?=
 =?utf-8?B?Ykxqc1FHTnI2NHlRdWw1ekVKRmV4YU43Vytmd1Q2ZVFJdkwrQUduNDl4VHVO?=
 =?utf-8?B?UVYxNDdhUW1qYTZ0VmxjaVhmMG9KU1gyZUtXUkFuQzBzdG1vZFJIUmt5Yk9y?=
 =?utf-8?B?ZlBXWlJCUjBXWkxodHVUMVJOWWhvdjYzbW95clc1QTFWWVRlSUp5ZHovMi9R?=
 =?utf-8?B?a1VQQlgwYWhtSmJPcHA1ak51VGV1R2NKb21sNTYrZDBBQVRYcERDLy9maSs3?=
 =?utf-8?B?Y25ZeTJING14SlN4b3pZMm1ENElQeWhDSStFMU5IZFV4aUViQTZTdVVIV3oy?=
 =?utf-8?B?UFNKMWR0U2xWeGk3R1RyY0YrTlFyWjhJekE5azQwckQvOEw0M2RDcVBtVkFL?=
 =?utf-8?B?dEJOeW52eWt5VU1Rd01TMnZXRTArRHdSNVo0K1QyemlQWGJXOHNNWXd6N3c2?=
 =?utf-8?B?aGlhTElneW5YUmN5Vml6dC9hMUt6VWovamNtNG54WlJEcThhbGMzeUlpUndZ?=
 =?utf-8?B?dGYzVHJSSU5aZ1lnLzFnTzVBOXVKblQyeEFvdEFmT0dBbXhlYnFYWGRDMjRx?=
 =?utf-8?B?WW9CTFRHUmpjQnpQVEFka0x5OXc3WkM2MnNaanFOZHJmeXZYcEVMN3YyV3V3?=
 =?utf-8?B?ZHV5M0xVMExINys4Z0J3ekMwKzYzcndxaDJkMHlVd2VvTWhQTWczR0loZUJy?=
 =?utf-8?B?RzlsNTdrbGRsRFQyeElsOGhDQXNTSFdXSkI3TGgvVDFEblVEZThYQ0Z6citq?=
 =?utf-8?B?bml1bGgrWjZma216ckJEYUZhSkdCMlFMeURvODVwVUhxeVZ0L2xrL0lXcmxm?=
 =?utf-8?B?Z0lzNGs3Q3V1cWwweHRpRnlmbjZRNWRvL3hxRDZRZnkyekRKVWIxVGJGcjhW?=
 =?utf-8?Q?2JfOuaOxMcn6TrYwqipIrQkHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b3b402-c351-4467-9122-08dd4adc178b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 20:38:50.7857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85kMc9tLHnXYPrHJHbmwh3v1vpOQCjThXERwtXrTwhI95mf2kcOLHmBiF8Gi54+ngkziBbNt0Ly/gULTOXkaXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111



On 2/11/2025 2:28 PM, Bjorn Helgaas wrote:
> On Tue, Feb 11, 2025 at 01:24:30PM -0600, Terry Bowman wrote:
>> CXL and AER drivers need the ability to identify CXL devices and CXL port
>> devices.
>>
>> First, add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC
>> presence. The CXL Flexbus DVSEC presence is used because it is required
>> for all the CXL PCIe devices.[1]
>>
>> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
>> Flexbus presence.
>>
>> Add pcie_is_cxl() as a macro to return 'struct pci_dev::is_cxl'.
>>
>> Add pcie_is_cxl_port() to check if a device is a CXL Root Port, CXL
>> Upstream Switch Port, or CXL Downstream Switch Port. Also, verify the
>> CXL Extensions DVSEC for Ports is present.[1]
>>
>> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>>     Capability (DVSEC) ID Assignment, Table 8-2
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> But I would change the subject to:
>
>   PCI/CXL: ...
>
> since this only changes drivers/pci files.

I'll change to PCI/CXL. Thanks for the review and 'acks'.

Terry
>> ---
>>  drivers/pci/pci.c             | 13 +++++++++++++
>>  drivers/pci/probe.c           | 10 ++++++++++
>>  include/linux/pci.h           |  5 +++++
>>  include/uapi/linux/pci_regs.h |  3 ++-
>>  4 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 869d204a70a3..a2d8b41dd043 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5032,6 +5032,19 @@ static u16 cxl_port_dvsec(struct pci_dev *dev)
>>  					 PCI_DVSEC_CXL_PORT);
>>  }
>>  
>> +inline bool pcie_is_cxl(struct pci_dev *pci_dev)
>> +{
>> +	return pci_dev->is_cxl;
>> +}
>> +
>> +bool pcie_is_cxl_port(struct pci_dev *dev)
>> +{
>> +	if (!pcie_is_cxl(dev))
>> +		return false;
>> +
>> +	return (cxl_port_dvsec(dev) > 0);
>> +}
>> +
>>  static bool cxl_sbr_masked(struct pci_dev *dev)
>>  {
>>  	u16 dvsec, reg;
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index b6536ed599c3..7737b9ce7a83 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1676,6 +1676,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>>  		dev->is_thunderbolt = 1;
>>  }
>>  
>> +static void set_pcie_cxl(struct pci_dev *dev)
>> +{
>> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
>> +					      PCI_DVSEC_CXL_FLEXBUS);
>> +	if (dvsec)
>> +		dev->is_cxl = 1;
>> +}
>> +
>>  static void set_pcie_untrusted(struct pci_dev *dev)
>>  {
>>  	struct pci_dev *parent = pci_upstream_bridge(dev);
>> @@ -2006,6 +2014,8 @@ int pci_setup_device(struct pci_dev *dev)
>>  	/* Need to have dev->cfg_size ready */
>>  	set_pcie_thunderbolt(dev);
>>  
>> +	set_pcie_cxl(dev);
>> +
>>  	set_pcie_untrusted(dev);
>>  
>>  	if (pci_is_pcie(dev))
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 1d62e785ae1f..82a0401c58d3 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -452,6 +452,7 @@ struct pci_dev {
>>  	unsigned int	is_hotplug_bridge:1;
>>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>>  	/*
>>  	 * Devices marked being untrusted are the ones that can potentially
>>  	 * execute DMA attacks and similar. They are typically connected
>> @@ -741,6 +742,10 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>>  	return false;
>>  }
>>  
>> +bool pcie_is_cxl(struct pci_dev *pci_dev);
>> +
>> +bool pcie_is_cxl_port(struct pci_dev *dev);
>> +
>>  #define for_each_pci_bridge(dev, bus)				\
>>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>>  		if (!pci_is_bridge(dev)) {} else
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 3445c4970e4d..dbc0f23d8c82 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -1208,9 +1208,10 @@
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
>>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
>>  
>> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
>> +/* Compute Express Link (CXL r3.1, sec 8.1) */
>>  #define PCI_DVSEC_CXL_PORT				3
>>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>> +#define PCI_DVSEC_CXL_FLEXBUS				7
>>  
>>  #endif /* LINUX_PCI_REGS_H */
>> -- 
>> 2.34.1
>>


