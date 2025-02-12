Return-Path: <linux-pci+bounces-21328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC809A3336B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 00:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FF63A83E6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C28209F40;
	Wed, 12 Feb 2025 23:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HJiQegNF"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535B1EF0B9;
	Wed, 12 Feb 2025 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403293; cv=fail; b=YfY731FWmGOJbYFu3qOMocSUPzJygFDmDwrtkjvszhzaAJZlBDw1x3bdqH6F0cz1SHFnphHrCj+gyB3KR/OTi2PRINl9jN4srAE0nlB+hSXMRLB/j0qJ5IgKrevbEYLAK2CSz3B3wALQE1apSliIWw747kooVx92CO9LRkWk8HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403293; c=relaxed/simple;
	bh=Ya2nBMHUtqOKOObsBg5/D2v+0Ieh8rAwlPk0wozAeOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WzXOy2haxTC4nRY0qWsrDDUZ3c6t+OYsWduw812lrZSNn56+bCAOSnpVURT60uS37n+X3251OUyRXVoC3zRZJcqhPddNUEylkb6IKB/PyT8oiouqHgbBUwnt9i/QctdkMeoIaOcE36TFJSOKAN1a37DJ4lx1ZIB+Ev9vcQwUFB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HJiQegNF; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/CLqv6+QCV0dPAjCQ5/WyGMD8GqgYoTUk3hz0fru38zCI3a/2HCHKMeZ5NmEPuWAPqPBO+8CtN1IjvKpnIyd+kABCtYv2q01UJ2Nbz8Oo4TQ0k3jHP4ugGfd7gRB2TvPATIJ6GiAMHKKCj2oLBmvuZSTXYZNsatLoGCpwEIcUQbj4XYADdX4X5VtoI2W2dSk0T1HKLBJ6rjLnyMI87x1Zvl5P1dnDEq86qCLKnzW85K7fC2zE3VY/oQG9nms/Ch3Onv7XCs4xhRWUTo2qg4A/kMqZEpUeFpaQSXy26OkZi9GvKzVUeipiJvwVFOmmlDmKRdBSaLeGxz3IDGOKJqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5BTRfS8lDapgjs2hKnuuW6m50vGOu3wGEGqH4KFAuQ=;
 b=G0mY8onQfGbbgRudqVMqbhrCuEd2LjQnbG/+07tCouDVb69LL1YVUG29c5nWaw87bTKKUOgBbUWMeIs1Nc4wGy5f9pSpGik8K0zAAC2gz1sMuf81+kBnLUHD906VMRHGKqkUO3HyTMP88kIBd2afCx8qV0w10M898Od8m2URlsnAUx7q4rOzrh1IDQF8DiWV5CR5GSqKTFB+s8N+1V5MZTZ8AstB/eFwMKo78zdW5NYH4x5wG3cJKsdk+Cj2uoYS6FzkF/keeTc4apliFi2yp90G/Yl03jmxug2onMpL0M0VnjMgz0+b7JvMcKPQ3YBLk6+g5Ybhl5dAapQATKGXPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5BTRfS8lDapgjs2hKnuuW6m50vGOu3wGEGqH4KFAuQ=;
 b=HJiQegNF5flfSXvf0gDRuXhTsBqBzx07L/3DGY2NdXso5ZA07hc60nlgx34w4GW1Yz50X9F/BWPmVQBj/W0Y5y8oK5IGtEMXT+fz2EmlS0On0ujC+trBMdZkmEIcRLNGAv9vMstrurn6gi9Tr5Bb5ATgEweG25lKMDyImDMmFG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB5718.namprd12.prod.outlook.com (2603:10b6:8:71::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Wed, 12 Feb 2025 23:34:49 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 23:34:48 +0000
Message-ID: <6ca5eea6-2219-45f1-ac9b-2fb83f7c4f3b@amd.com>
Date: Wed, 12 Feb 2025 17:34:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/17] cxl/pci: Update CXL Port RAS logging to also
 display PCIe SBDF
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-15-terry.bowman@amd.com>
 <Z60vJYIJQxJ7Cu9d@aschofie-mobl2.lan>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z60vJYIJQxJ7Cu9d@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0122.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB5718:EE_
X-MS-Office365-Filtering-Correlation-Id: a452ad15-d42a-4daa-4e1c-08dd4bbdd711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGVQZFZtaDBjaVRTeEJoNlVJNkJoZlU1azJVeDd4engyNU1jWU0wdUFkdkxT?=
 =?utf-8?B?eHBCMStWRzJpQTY4RmcyQUxtUHoyU0RkV3ExY05BTGFBWXVoSUdLTmdrNUJv?=
 =?utf-8?B?KzhVTWh1V3hLcjM2U2VmNXJYMXdwR2lPUy9VM1Z1OW52SS9zVlNMdmF0T2NH?=
 =?utf-8?B?R29rWkJZZzd6N1BDWXNPbWdSbUFqZVRkYjR0cUt6QmRNT09IQVIxRWQxVnJV?=
 =?utf-8?B?U1lkOEI2V3hXUmk5S1lmYzFQOW1YdFZhbGdkR216TmF4RWhPT3FMcDRQaTRQ?=
 =?utf-8?B?Qmg5WGFiNTBDbG93Um5sazdUeEdPODlBbG9xV1BhTEl5bEcvbTUrbGtITUtG?=
 =?utf-8?B?VnlHMVk1Q29uajRIRW5pOSsvSmNjZFM2YmtCa3M4THhuZVo0QkN4MmxUZ0Uv?=
 =?utf-8?B?a3BrZkRSVXBSUWlnOXlDQkl0YlNxUUZXT05BUHJESlNJUGw4bDc4bzNKSlZ1?=
 =?utf-8?B?U2FnQ0ZoWlRjbTVZZDc4eDJiZnlSZ2UwYXhLQjVPMzQ3OTYvdCt0cXR6QTAx?=
 =?utf-8?B?Wm9UblNYNTE2MlptOFo3czFaeGFhK25nM29Wa2ttbjdhanRpM0l3ZXVWU0Nx?=
 =?utf-8?B?dFp5RGVtZGd4aWxKRHZzOFY3c3NUUTlqbkZHNXgvRTMzblU0YzNkeFpPd2h1?=
 =?utf-8?B?Y3lQSTRoSlM4NTg2ZkNmMmR6a1Z0eUh0RXBFYW9WUzNRb1pTNDNDRVd6aFBF?=
 =?utf-8?B?WFkxMis5RGdmYW5aRnVKUGV1M2VGRUt0VmVhYStCRkt3Y3FVY3VnTGNvWll5?=
 =?utf-8?B?clg1MC9oUlJ1Ukh5SzFmT0IvZ1hJclFvM085OWtqTG45RWcyRS9wWExzSWlN?=
 =?utf-8?B?blR3RUZjazBGLzQ3WFpFcDQvNm4zUEw1WHB6VlZZckQ3aGZYd3hrSVFpN1h3?=
 =?utf-8?B?UHcvcFNQWWx1ZmpOei9GY1k4Sms5Uk1zZFVhc0V3cm01RVZIUktEM1JYRkJp?=
 =?utf-8?B?U0Y3V2JtNDd0d3U4NTBlRjB0QzRFMmQ4dEFqMnpSQWpwZnFwcXZQWC9TVTBt?=
 =?utf-8?B?TFkrVmZSR0V2WmF2dzdKUkZHUzVyOEhBcHRXNWt0cTdOZW1udVVZMnl6MEhi?=
 =?utf-8?B?SUdvWm5qV3RtWmdKR3ljQjNianFhQXJiQ2pkWCtPNnRROGhsQ1R4QlBWcmdH?=
 =?utf-8?B?RmpCWENGcEVTNUp0d3hIdmJHVDBoOC9vMEY0NlZ1Qjl6ZFdsTlV1K01nbnEv?=
 =?utf-8?B?QUMxanhhYkV1ZnVYc1N3TDJqUkU3QTd4dmUwQVFyMjJ5TzkrR09RUFZMTFFa?=
 =?utf-8?B?S0puTVR4NndJNlFuNngvOU5GR2h6M0ZadGpMUTFJZ0RsYVlPOVN3ZXRqMXpk?=
 =?utf-8?B?MkF4M29XVyttOGp2Z2RoL2gzZ0cyalpuRmZDZGlVQjlrVTh5UmpINXNpdlI1?=
 =?utf-8?B?L3dJbnVZVFZkNEFUQ09wdXlPa2txbDBjYm9FSzJqSVlPRGNJVEFxbXg3RkRs?=
 =?utf-8?B?WUFHM0tnMVFNV3o5VmFieEJBMEIrR3lLT1lTbmNsMHJtVGlJRXpLQWdIMHJq?=
 =?utf-8?B?QTd6THVQQUdvNGgyR1orTHpiMU9zOVRnR2VsYXM4aW1YT2Y5YTk5TzhsbkdG?=
 =?utf-8?B?NWVZVHE4dHU5cEdDcldiNzhGdEFhcGVPQzNEbnhmNlR2c2xSMkJ3OGM3dVc0?=
 =?utf-8?B?TyswV0JORXNvRjRoWEZySWJvVDc5T1ZtdHprSTdOc3BaN3FNT25jYmFGRFJ0?=
 =?utf-8?B?Y05qc21KZkYyazgvcGtaR3o0WEdBTS9ud05VbDNML0ZvbTFFSW53VGJPRSsw?=
 =?utf-8?B?UzV5SU5BTmhseHBtZTNkTVdsbmhBcWRzZ09Wam1iTE85MHZ3OHNMMHRDWXFm?=
 =?utf-8?B?S3RBRnorQmN2K1BWNXBIdjhrNFN5SVRkaGtIcmszdUEwd01yRWtEbDhsZ1FD?=
 =?utf-8?Q?LwD5eP3+VrF8I?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmtoczVTVENTa1VmaDd0QndNYlNXYVJrQTV4RWRXcGt4bDMxWjF6b0xpblpi?=
 =?utf-8?B?eWx6L0c4Sy8xNlE5cDFGZ0dJcDNjT05FSjYxUmt5NmlWa0xlL3pPejRqdDY0?=
 =?utf-8?B?cWxVczYwTzJmZXJWYTgxSHh3V2JvN3A0NThlREJEdHdMSWZXcXlVdHphTExq?=
 =?utf-8?B?THEvaUNYc0VPNWYrVE1lT3hXY3RLR3hjWHovNEU1TEJ4dlhLd3I2NW9RaGY2?=
 =?utf-8?B?S1lteUR6a3lIbUZNSEtWdS8wVUR0ZFdKSjIxOXQ5YUFRWkNrRjd1Z0VmVnBU?=
 =?utf-8?B?elBFVGFaQjRaeFQ1MUp0WkRwTU1ScjgzdWVoK3RPQ0JMYlVmelREV09hUU1X?=
 =?utf-8?B?ZHpKQkFqTTc3RnlrTmtkRnBYNU5UallZQVEwenhwemtiZm9EZHNoYnRpYmQw?=
 =?utf-8?B?U01LQjNUelFzcjIvS0Z1R2dSbEFBbkFkSUhPS3F2MTZWTUVPdHhGenhxQlow?=
 =?utf-8?B?TThpemlNTUhKUTh1OGpsSkN0WVA4bXJucTR3NU90cWlid2FEMEpSaXVsTjhP?=
 =?utf-8?B?RlpWYXE2ZzRxcUF4aWJvaktndUh3MVdBVXhoZFNHLzdtWWowRjhMUXF2eXY4?=
 =?utf-8?B?YVBjZm4xaFFrNzRESmp6NGhzOFQ3aG0wYmt3RFBGa08xcW05L3BqQ1YvUG14?=
 =?utf-8?B?Q0RBNlpvd2wwOUVaVUxMcWRYc2VCTCtORzJYd1I0Q0NvSEJ1aDJMUER6TnNY?=
 =?utf-8?B?dkhvcU4rRVJGeVpWb1RjdDhYKzVkMG1oVmIzY3YzVFlTcHpuamd0MmtEVHBx?=
 =?utf-8?B?bHQ3b044Vmw4aG53TnE3Y1FhU3ZmSWhEOUhOOTZJM1BvMkJTMnlmOW5lQzZa?=
 =?utf-8?B?aHFzejk2Y1FMOUtYeEFTVHJCYnhpTWx2OEN6bkdHYWJWUjZ0RDl4ZzFweldG?=
 =?utf-8?B?TlUxeUtZNTUyT041OUhkK3lxV2Vua2hOckZFejZ1KzY1MyszMFh5L2pQK2Jt?=
 =?utf-8?B?MFMyeCtkektsQU1OMkhXV2JtUllwcDIzLzJha3d5bHluNmJJMDB4RnBzcjhY?=
 =?utf-8?B?SjBQNXpaOEFGb0ZBaVAyZFlGVDJVdVZyL3FEOTB0MEd4c0tYa3piL0V5YTZU?=
 =?utf-8?B?ckQzdkhzLzBKUG53bE1MMC9hdnRENGhsSHNzU3JUTEdYSUpDZFFxZmpXQUto?=
 =?utf-8?B?NFE5ZzN3RWt6Uks1dExWcWlPRXloMDdJcFgyWGoydE83a0c5dXJQWlcrcGZP?=
 =?utf-8?B?WnFoTWcrV1dPL2gzUlgycGJ6OVNjSUV6QWZkd3hOV1B5TkZCNkIvMzNOem1m?=
 =?utf-8?B?V2NVVTh2M05LZ1I0Tldsd3B2MWNCWHN0aWVYOFBLZXpGd0pTb0daMTBGR05W?=
 =?utf-8?B?dTdzZklKZ0p2TTlidzZyQlhvbmhtQVpCZDc2Y2NTdTZzQnVPelJIQWZUeGlu?=
 =?utf-8?B?ZDU3b2dPaS9XcG54ZzNVZDVsNGpMY0dOQUppSzBFTk9OYU9IT2NSb1BUUUJE?=
 =?utf-8?B?UnBtYVRtRTRYdGgzTGNrME9JeE9kQmFoa2NXSGh2am5ZSHpPekc5YURmQkx5?=
 =?utf-8?B?Rm9jYUdQc2ZDVm9vbzlydmdNVXBOMWEvakp1MTRBTjJCanZtbjIxcEZFRk1i?=
 =?utf-8?B?WUhvRnB3RnF4TTg3WVoraDRjVU1QRHhOVWVIdEhXSUNDVCt3MzE2aXBrejM4?=
 =?utf-8?B?NUM5YU1WaDZjc2dwOXNDdWxWaFNDdXppY1cxdGxmeWswWUllUlc1QzZNYmtY?=
 =?utf-8?B?WURyQ0RBN2xDUkM3WFdLUXYvWWZEalIwUGNEeTFGVS85ZEt2N01KNjhJTXox?=
 =?utf-8?B?ajBHQ25jZjNsR2R3TzQ3b01IU1FMVHFyYUdrU0swUVh2U2ZFQU1HR0NLWWxh?=
 =?utf-8?B?Q2o2M2R3TE5yTlNNY2dmaTdBR1NFZGpFSWJCZXNXekc1SWxtVFRoMm4rQytz?=
 =?utf-8?B?NE1KWTdIcytzRU9MYUFBN3R2ZlNnaDBDYzBsK2FQQUltM3l1SjdoU3g2Z1Jy?=
 =?utf-8?B?VVpHTkZTT01Mb0N0cExLaTZNTlBXYnhaQTRiYXlaR2N5WlhwcXRrQVVZMFVt?=
 =?utf-8?B?MGJleUVDRXBNOUVoa1BuWnM2eVBjNzZFZ0pzcWxXMGRxNng5RnpXS0VZM2tw?=
 =?utf-8?B?YU90eVhFanlxaDlaMC9yaTVqcVJWdFM1YVJVeVhmb0tBVEJoVit4RVdaK2xD?=
 =?utf-8?Q?91Nucz+RrCE/dKbW2V5dJdJrN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a452ad15-d42a-4daa-4e1c-08dd4bbdd711
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 23:34:48.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrNnpkr7dmdDCaXnYBlvPB3XVz98K4xh1F0NXkYWIt1zx4UErCS2f1n3pgs/y6yffaajb1VOyxeckGpyw2PuPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5718



On 2/12/2025 5:30 PM, Alison Schofield wrote:
> On Tue, Feb 11, 2025 at 01:24:41PM -0600, Terry Bowman wrote:
>> CXL RAS errors are currently logged using the associated CXL port's name
>> returned from devname(). They are typically named with 'port1', 'port2',
>> etc. to indicate the hierarchial location in the CXL topology. But, this
>> doesn't clearly indicate the CXL card or slot reporting the error.
>>
>> Update the logging to also log the corresponding PCIe devname. This will
>> give a PCIe SBDF or ACPI object name (in case of CXL HB). This will provide
>> details helping users understand which physical slot and card has the
>> error.
>>
>> Below is example output after making these changes.
>>
>> Correctable error example output:
>> cxl_port_aer_correctable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status='Received Error From Physical Layer'
>>
>> Uncorrectable error example output:
>> cxl_port_aer_uncorrectable_error: device=port1 (0000:0c:00.0) parent=root0 (pci0000:0c) status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Error'
> snip
>>  
>>  TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> -	TP_ARGS(dev, status, fe, hl),
>> +	TP_PROTO(struct device *cxl_dev, struct device *pcie_dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(cxl_dev, pcie_dev, status, fe, hl),
>>  	TP_STRUCT__entry(
>> -		__string(devname, dev_name(dev))
>> -		__string(parent, dev_name(dev->parent))
>> +		__string(cxl_name, dev_name(cxl_dev))
>> +		__string(cxl_parent_name, dev_name(cxl_dev->parent))
>> +		__string(pcie_name, dev_name(pcie_dev))
>> +		__string(pcie_parent_name, dev_name(pcie_dev->parent))
> I get the rename of devname->cxl_name and parent->cxl_parent_name
> since now we have pcie names too.  How about making those changes
> in the previous patch where devname and parent are introduced. Then
> this patch doesn't have any changes other than adding the pcie names.
>
> Having said that, should/can this merge with the patch before it?
>
>
> snip
Yes. I'll merge the 2 patches.

Terry

