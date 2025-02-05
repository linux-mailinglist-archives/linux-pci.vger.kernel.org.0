Return-Path: <linux-pci+bounces-20725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7848A282F8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 04:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEF73A34E6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 03:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8960F2101B3;
	Wed,  5 Feb 2025 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2jM3aG4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBC91EB3E;
	Wed,  5 Feb 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727199; cv=fail; b=ov/27UZLMdNuxxPplO0TJKbP6gTGV3YMUcZg/bjbJNV5IMY+iqtiF9lx3ZUyOL5pd8OYNtTR971rjm19Dq9i994VduMDvGnNlLaNM1ScCMH1lqU1v4ziz29/yBTl8yt7W3tLJCbEhByUK/Sz+cLiJ7VRK4QzyK6qdQqE7B3psPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727199; c=relaxed/simple;
	bh=IRGvQb6mMD3wqrbDA7FQKg5uFKkYW+dZUxjoKlRiz5U=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BH/g7pLX59WoHlccmCnIfrxuwsP5/i0g6vpgo4N7DVKHgoG/PUtbB9fwqBfZdOwdCmfaXXJ+t0nRiOPViCvF5tACZRAZ/yFCOrprRmQo0NlfVTwZZMKaYxfnfBTOcSeblPbUOmEpWNTjd41ath3HHQE/dLVqAviPLcrJL8/0SgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2jM3aG4U; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqq9WHu03/XzZNFkRLhMVogfGCwou0WeDnrh3dujQhkzkHYjzuQSq+UcgJwfh18fRl7x2tmMR8X45ioO/aOZhVFyjGRr7OntJBlS4K8KsPHJF5N8KSD6ZEiwtLlslrQznii8xVEGjnGlfllgSAPKlmGrPhCYNhBTNMGfjhvkCXOzrY4i4ZGK1pZyFD5f+ExCGtYsVs3zErsbYoqKOHfT5lEpmcgFgLLHIRorZ0J5aQ/R3K1csnQL6Va6xj+37inhlmClFWWIjhXLnpmDPLTqNsKtRX8kp7uQ1HMuL2YO0EciB1eeRDjBbMsR1AVIQTmgMCiPuj7JDF8gOepvD29ToQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb2EybRonf31FjWYITHqeTLwGBIlhJSwnDb216yu9MU=;
 b=DAO7AJuw2zGnTF7yUgu+RgMpOppxmvTk8nkPGOLCSm4a49MsDcmG7INV846UlVdDti3mpgfP46x++S+YLGZ1ajpbRiXuwaDgmTHfDYnMGQOjI4VEF3ptUpjKunOYhvf6ry1zlShZ2lKKpauUJVOAeKczQLwTwsOqI2J53mEUBs6FKEawmIpbJXWlL5UOHrvKfTo9U6pYia4ScAWo9ZiWOjkm+1BhRbXJWlgk/h34Qgoe/V0UfVf5en/EOPYdjdml6hYFC7PInXUgtV6C/nXUUEGhIKsSdowtiO1sPB5s8yPjvdO1T2QUj5LWaP/q1MsZUqBxAKEOQt3CJd4p/4ZYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb2EybRonf31FjWYITHqeTLwGBIlhJSwnDb216yu9MU=;
 b=2jM3aG4UiycXdSOkG4Vg0iWCBAu6QSArTeO4TZVb4YetVH0UPLKxxZ8FyQhw3KDZchgkdGBx5GIhcSXddoeI26lLrA6hoaKrCPY5xlyxKqh8Z8JkBBKL8oW3EVpMS6F4sa4je0OvytddWz0tneoOChrPgOWNlHGxmWgdAlekCag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:46:34 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%4]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 03:46:34 +0000
Message-ID: <2b9a8693-2218-4109-b20f-8a57618d9006@amd.com>
Date: Tue, 4 Feb 2025 21:46:30 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
 <cb087065-f2f3-481c-84cf-aca2c5fd5ac4@zohomail.com>
 <708db61f-2a69-40a0-ab9a-0fdb889ff443@amd.com>
 <c7e6298c-ae12-4e86-a74b-8b3aea698772@zohomail.com>
 <5ad954c8-2254-4f45-8018-7fa345597ee2@amd.com>
 <a8950b91-3485-4dd5-9d84-7d3a3031b752@zohomail.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <a8950b91-3485-4dd5-9d84-7d3a3031b752@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:806:d0::35) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7f39ae-afc5-4647-1a8e-08dd4597af71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFl6WWNoTkk3M3ZUTTUyWmRjdUtlcWpzaEdLV3AyRFduQWVqNnZ3Z3E5eENs?=
 =?utf-8?B?c1VxRnZHN2RRMTl0aUVMV2plV1RuWUNpU2Erb0VwalA1dG9nNU5UbjFiSmIr?=
 =?utf-8?B?V0NOTGlEUXlNZmpMb1BnZUFXNnNSK1E1VkVDRUUvc2VoWGhTaHBwQTZmSSt5?=
 =?utf-8?B?bWdZdTlla1FkejJaMERTMklXMVR4NzNFcTdJbVhGbXZaV1VGdHJra2lBWWdz?=
 =?utf-8?B?d2pWNWRWYnoxTFNORUdEcmFLZnlYTTZ3T1hVT2RMK29reVZ6SXpUbGVNTzJr?=
 =?utf-8?B?alFVaW12RUsvbjBnbGlDNXkrNlFwemk3WFdxT0lneEFoWXQ3YWwzN2tBT2Fu?=
 =?utf-8?B?bEJVRHlrNHlXR2ZsbnJiUzc5NXk5KzFiUndQZEN4LzhyVDRoMjN6K2g4UXZL?=
 =?utf-8?B?TWlkZUNvK2krUmJGNHovMk5UemJVYmNXWVZQazA3ZU1teFYrWTM5Q0d4elpX?=
 =?utf-8?B?a1JKZmh6N2YrZjV6UUdhaU1mcmphUys4UGRKVlU3VFFod2Zkb3FJcG1qbVF0?=
 =?utf-8?B?MHoxM2F5MlBmSU1zRzJXZDhOWko2MmE1YmZaTkYvOFZ0cndGYk41d2tMdTc5?=
 =?utf-8?B?RlNQZVpRZkwxZE1XdHN2MlNWdi9hejBPQ05vQ0I3TWpLUGFHNTd6eXg5dVdR?=
 =?utf-8?B?c3ltSERWMWtYWDk3d0VuUWY0Ym5SVldib1duL2xsUHVEdUoxTzhRY2lOTUd0?=
 =?utf-8?B?RUdNRlBiRVZkbGF0UnZwU2ViT1ZIT0J5dmY4NDNhZjVET0M2K1p6TGlaUXF0?=
 =?utf-8?B?RGJXU0JZSmN5dzVMejl3OSsxWGc5RUtYM3FIYmhOQzE3RWVuc1JZbHVEWFZS?=
 =?utf-8?B?YXZ1c0RhVUsxQkhjR0VlVGtHaHJlREhXRXVNZnZ4L2RVVGdXMnVmbXBRMmJ5?=
 =?utf-8?B?aU5qRlFHNm0vNC9VZXhlOWE3bVFYWGlhdE5ySmhMTkE4enpFUnRseWFoRHp6?=
 =?utf-8?B?amUxQzFOTFBSbmpKTkNXMHpFanhJRk5ieXdaWFZKaDltNkpzQnE1QzBka0g1?=
 =?utf-8?B?dUZaYm00eldrTU5JU3FmR1BVMFVWZUk1eGFlSzZqcnMvenNYTjJMOW5mYURJ?=
 =?utf-8?B?M2tPcERmQjhybTUya2sxSlljMjBxbm50R1c5SUMvK1dacDdpaDkwU25iRGVl?=
 =?utf-8?B?RXFkQXh1MUsxenlJMll3UG0rKzVqNUg5YTBrSzZsRGVGdy94dHZMTGJJaTcx?=
 =?utf-8?B?YUhNWXRZdEgrb2VqdXk1ZXJSZEJ1cVJaVk5mOFRqVWZZOFo0eE0vZFNSRENL?=
 =?utf-8?B?MUorWm52NzR6Qm9yRzNETWUwb0hMVjlzc2J4RGFRZUxNblJBOVp4ZFBMTDJD?=
 =?utf-8?B?S1Vwa3ErYkF5S1R1MHV3RGNXSW9nUmRJMXNFZGZPQjdkQjZhUzRBL3lWeElY?=
 =?utf-8?B?UkJzUkdpK3ZMaGdnZ1U4Q2xhMHVOa2RmVUltTC80QnhrQnhqdExxWnU0OFd6?=
 =?utf-8?B?Z25qNmRMamxVYUpYYmxUTGs4eXhwNUV3alZlT1VYQURDVk5KNHVQTUlsbWR4?=
 =?utf-8?B?RnN5NTlDK2tEM2NIdHJZcTFyM0pQc1RIL2lSeitqWTRiZHZNTTh1WmlSU2Rk?=
 =?utf-8?B?ZDVNc1d0M2FQRDdPeHZkc1JneXVWTCtza2RJRmJUY2ZoaE5CZ1FmdDVvUFpm?=
 =?utf-8?B?SUh6VWlMOTh4K1JiUDM3T3BPYWszZk0xL3RZTDU2V3ZBeGtUSFgvSHNwMzBs?=
 =?utf-8?B?Vm5CUmxUcERRblVJaHFKTkk3RDYwKzBDeGlJUU45a2dSeDJ0Yk9GYy9pRVl3?=
 =?utf-8?B?OS93cng3bytJWmVPVXQ5SDRLU2hKS3RKdVcvc1NSQlduYkRRVHFFZHhlZDd0?=
 =?utf-8?B?NlpUZ0wxU0I5WUpjaG9aQUNXUlE1c3M3TnFTWEsybWlFZzJvamoybkwvMzU3?=
 =?utf-8?B?dlpLejc1OENwR2xZSUIxdDdlYmUrRHpMbUpPT29DcWcwMFpRdTBXTUxMdndx?=
 =?utf-8?Q?SNkm86Ozytc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmxoRVB5SktzSzc2eGx0U3g5TWFLbWhMVStEaTc2UzQwd3oyOEw5NnZOdnhw?=
 =?utf-8?B?RCtvMGRRU2ZEazlDZDVQL2szTUNENkN5SU5yaVJpVlBlMy9seVF4Q3Q5OStH?=
 =?utf-8?B?OE5SeFRyc043b0JCNWN6T0hSWEl0Q0hwcHpoVU5VcGxoZmZya2JXNHFOa082?=
 =?utf-8?B?V05vOVNYY3ZCOE5FNU9SVm5VT0VXV3JEazE4dVFKaWo0TThJUi9aZkJEaHlx?=
 =?utf-8?B?ZVFmM1h6T09MdkcxeXBPdzZpRllCeEJ2RzRJVk8xdnlCeXhmRERQblRacUha?=
 =?utf-8?B?Q2V4VVpUQ0Z2YXpOc3ZzbmR5Sk9kU0xvSUtSbFVVYUR3dW8rdE5PTjFTZUVE?=
 =?utf-8?B?bGR0czdYRksrT1lnRy93cEg2bjJwMFhiWS8rSWlCNTRRU09CZVNKdTVqQjNz?=
 =?utf-8?B?N3N2eUxNSnBaWmliMERaZXAwUkpLMjdpYTBlRzJaek5xbFh5bUlqU25sblUz?=
 =?utf-8?B?cDVHL0FyS2FsNVBLVXlqVVpkbFFXZFpkRDN6WVp2K2dIZjdBTEh2NFA0UjNJ?=
 =?utf-8?B?S3RmSVJVK0wxTTBHR2RGVFpiVGdBWjFRc3oxWDRrSE9IYmdVOUdSVzhjbDRC?=
 =?utf-8?B?UW9LcUVOVGQ5cS94UzRITmxLRUxvOTBUOHpUcWZQMC9iZjU2WkR1ZUx4RmRG?=
 =?utf-8?B?a0JVeUdXMEkydEZjd29QeFJidS90NGF1MCtVKytJMDFZdjdMdldoRHNIUzhp?=
 =?utf-8?B?Sm5XNlBPQ25JbEMvVEFkQUhrQlVZOHloRGdhd1h3c0I5NXdlZy96WXhDU29E?=
 =?utf-8?B?YVYwcXRlOGJOcmhnWFFZQ0VsdGJIQmJmWC94WndraENyQXVqVFpjVWc5aDBC?=
 =?utf-8?B?R1htRDFJK1RSUytNNEFHYkllN1RPNUxraFNxSU5BWmtkVmNhUHB2cWx2TGRG?=
 =?utf-8?B?V1o3N2c1VjlmNDFubVcycCtoZmp0RzlGb0dXa1dmVjRUYk5TVHVtVDBleUNJ?=
 =?utf-8?B?RmcwNkxCdnBoUWpVNStMYnpBSGlJbzg2SEJtVmlPUVVpejFNcGNra3lCeTdN?=
 =?utf-8?B?SWplTkpvNlNXSlhpZHE5MUdmbHZUa1RLaURIZmt0Z3NFTHdnajh1TERPcHk0?=
 =?utf-8?B?aHZ2VmpxaE1sTWhGTFUzVG90THgyY1FQazVpZnZBQXk5Nll4aHl6M0J4UXVK?=
 =?utf-8?B?MmhyNDR0djJhSG5IQjJkdFRJVE5JMVk2amdFd2ZERVJ0OThxbGk1TzR3cWdX?=
 =?utf-8?B?VCtqc1VycGpWR3IrdWtzcW9Va1RzcXhqRkE1L0RDa0pQUGlVaWpGRmo2bFZM?=
 =?utf-8?B?TUJCTG9zbmdNYUt5Y0RubTA3aSs2V29HcCt2d1lhVVhGSnF5YjJnNldIWHJ1?=
 =?utf-8?B?em9FZWROOXN3TStqUGRCRjFQM1ZyU0N3bFdhY3VYa2N1b0dSOCtnVlhWb2hh?=
 =?utf-8?B?RXpta05kSkVSMUpVelc0Zkx6SGR5cHE4TTdtRVdsOURLVDduYXVhT29wZU5L?=
 =?utf-8?B?Vk9WTjZ6MUZKM2VURGRmSWluWmVrcHY4ZWNCL1VGdDJobjVHdEdsQ0JCWk1q?=
 =?utf-8?B?QXdBdXZNMjJkSGQwYTBGRHpibVQwUmJqdHlYQW1vWHYrMmQ0Z2hmTjZaWjVo?=
 =?utf-8?B?YnJHNFY0Mi91ekI3ZGNRbEpWeFMwcERoSjV0dkg2Y1JJemZWbEwvMWF6bk9s?=
 =?utf-8?B?cGVEQjUrdmI0Tk5BTXdKK1ZWVnk2QlBhaldnM2c2TVd3YVpBV3N2V2dQR0k5?=
 =?utf-8?B?am1SMllhbTladlFqNUg5enBRb25KSDBrSVRmSjZrVGNWNTFsYnFlLzc3eFdI?=
 =?utf-8?B?V1RuTGloM3phMlJsV1g5dElYbDZQYkg2ZkJjcHErOVo3L1hRSTNPQWpZRk15?=
 =?utf-8?B?alFZbHJ6R2ltMTlGZmhZYk8yQlBrN3V6VjZLY29JL2loSnJwR0p6UzF0K29p?=
 =?utf-8?B?Nm1zUmY5cldNSGhRbGwyL0R6Yi9qbW0vdHJBbGdZSE9pNXZTWDBVNzZ3SGtk?=
 =?utf-8?B?YTl6REV5Tk4zQ3lpK3BiQmJkQW5nb0doYWszV0JRRzBHSmx5WEE4K1pHNFVp?=
 =?utf-8?B?WFhUQlk0QlRoeDVlZkVYeVJlS3N5YWYzRVBPSmEyTHlzUjZIWWdPS0ZaZThI?=
 =?utf-8?B?cTNGcGVuZktFdEJvREJveXY1Q2RoYURrSitvSUE4YW5keEZVcXFMeGRnbUlP?=
 =?utf-8?Q?A9NmjnbYtoQxmtntp0u101nrW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7f39ae-afc5-4647-1a8e-08dd4597af71
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:46:34.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKPFw/sd/4wdVrxsUsR+VZMrDJmBL15AylKYDW8rS+0FiHviiPtVbavp/AfYv9m3jtaCuhnKLukd2v12DJJS6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652



On 1/15/2025 9:15 PM, Li Ming wrote:
> On 1/15/2025 10:39 PM, Bowman, Terry wrote:
>>
>> On 1/14/2025 7:18 PM, Li Ming wrote:
>>> On 1/15/2025 3:29 AM, Bowman, Terry wrote:
>>>> On 1/14/2025 12:54 AM, Li Ming wrote:
>>>>> On 1/7/2025 10:38 PM, Terry Bowman wrote:
>>>>>> The AER service driver supports handling Downstream Port Protocol Errors in
>>>>>> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
>>>>>> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
>>>>>> mode.[1]
>>>>>>
>>>>>> CXL and PCIe Protocol Error handling have different requirements that
>>>>>> necessitate a separate handling path. The AER service driver may try to
>>>>>> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
>>>>>> suitable for CXL PCIe Port devices because of potential for system memory
>>>>>> corruption. Instead, CXL Protocol Error handling must use a kernel panic
>>>>>> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
>>>>>> Error handling does not panic the kernel in response to a UCE.
>>>>>>
>>>>>> Introduce a separate path for CXL Protocol Error handling in the AER
>>>>>> service driver. This will allow CXL Protocol Errors to use CXL specific
>>>>>> handling instead of PCIe handling. Add the CXL specific changes without
>>>>>> affecting or adding functionality in the PCIe handling.
>>>>>>
>>>>>> Make this update alongside the existing Downstream Port RCH error handling
>>>>>> logic, extending support to CXL PCIe Ports in VH mode.
>>>>>>
>>>>>> is_internal_error() is currently limited by CONFIG_PCIEAER_CXL kernel
>>>>>> config. Update is_internal_error()'s function declaration such that it is
>>>>>> always available regardless if CONFIG_PCIEAER_CXL kernel config is enabled
>>>>>> or disabled.
>>>>>>
>>>>>> The uncorrectable error (UCE) handling will be added in a future patch.
>>>>>>
>>>>>> [1] CXL 3.1 Spec, 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>>>>> Upstream Switch Ports
>>>>>>
>>>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>>>> ---
>>>>>>  drivers/pci/pcie/aer.c | 61 +++++++++++++++++++++++++++---------------
>>>>>>  1 file changed, 40 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>>> index f8b3350fcbb4..62be599e3bee 100644
>>>>>> --- a/drivers/pci/pcie/aer.c
>>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>>> @@ -942,8 +942,15 @@ static bool find_source_device(struct pci_dev *parent,
>>>>>>  	return true;
>>>>>>  }
>>>>>>  
>>>>>> -#ifdef CONFIG_PCIEAER_CXL
>>>>>> +static bool is_internal_error(struct aer_err_info *info)
>>>>>> +{
>>>>>> +	if (info->severity == AER_CORRECTABLE)
>>>>>> +		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>>  
>>>>>> +	return info->status & PCI_ERR_UNC_INTN;
>>>>>> +}
>>>>>> +
>>>>>> +#ifdef CONFIG_PCIEAER_CXL
>>>>>>  /**
>>>>>>   * pci_aer_unmask_internal_errors - unmask internal errors
>>>>>>   * @dev: pointer to the pcie_dev data structure
>>>>>> @@ -995,14 +1002,6 @@ static bool cxl_error_is_native(struct pci_dev *dev)
>>>>>>  	return (pcie_ports_native || host->native_aer);
>>>>>>  }
>>>>>>  
>>>>>> -static bool is_internal_error(struct aer_err_info *info)
>>>>>> -{
>>>>>> -	if (info->severity == AER_CORRECTABLE)
>>>>>> -		return info->status & PCI_ERR_COR_INTERNAL;
>>>>>> -
>>>>>> -	return info->status & PCI_ERR_UNC_INTN;
>>>>>> -}
>>>>>> -
>>>>>>  static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>>  {
>>>>>>  	struct aer_err_info *info = (struct aer_err_info *)data;
>>>>>> @@ -1034,14 +1033,23 @@ static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>>>>>>  
>>>>>>  static void cxl_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>  {
>>>>>> -	/*
>>>>>> -	 * Internal errors of an RCEC indicate an AER error in an
>>>>>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>>>>>> -	 * device driver.
>>>>>> -	 */
>>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>>> -	    is_internal_error(info))
>>>>>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>> +		return pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>>>>>> +
>>>>>> +	if (info->severity == AER_CORRECTABLE) {
>>>>>> +		struct pci_driver *pdrv = dev->driver;
>>>>>> +		int aer = dev->aer_cap;
>>>>>> +
>>>>>> +		if (aer)
>>>>>> +			pci_write_config_dword(dev, aer + PCI_ERR_COR_STATUS,
>>>>>> +					       info->status);
>>>>>> +
>>>>>> +		if (pdrv && pdrv->cxl_err_handler &&
>>>>>> +		    pdrv->cxl_err_handler->cor_error_detected)
>>>>>> +			pdrv->cxl_err_handler->cor_error_detected(dev);
>>>>>>
>>>>>> +		pcie_clear_device_status(dev);
>>>>>> +	}
>>>>>>  }
>>>>>>  
>>>>>>  static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>>>>> @@ -1059,9 +1067,13 @@ static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>>  {
>>>>>>  	bool handles_cxl = false;
>>>>>>  
>>>>>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>>>>>> -	    pcie_aer_is_native(dev))
>>>>>> +	if (!pcie_aer_is_native(dev))
>>>>>> +		return false;
>>>>>> +
>>>>>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>>>>>>  		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>>>>>> +	else
>>>>>> +		handles_cxl = pcie_is_cxl_port(dev);
>>>>> My understanding is if a cxl RP/USP/DSP is working on PCIe mode, they are also possible to expose a DVSEC ID 3(CXL r3.1 section 9.12.3). In such case, the AER handler should be pci_aer_handle_error() rather than cxl_handle_error().
>>>>>
>>>>> pcie_is_cxl_port() only checks if there is a DVSEC ID 3, but I think it should also check if the cxl port is working on CXL mode, does it make more sense?
>>>>>
>>>>>
>>>>> Ming
>>>> Hi Ming and Jonathan,
>>>>
>>>> RCH AER & RCH RAS are currently logged by the CXL driver's RCH handlers.
>>>>
>>>> If the recommended change is made then RCH RAS will not be logged and the
>>>> user would miss CXL details about the alternate protocol training failure.
>>>> Also, AER is not CXL required and as a result in some cases you would only
>>>> have the RCEC forwarded UIE/CIE message logged by the AER driver without
>>>> any other logging.
>>>>
>>>> Is there value in *not* logging CXL RAS for errors on an untrained RCH
>>>> link? Isn't it more informative to log PCIe AER and CXL RAS in this case?
>>>>
>>>> Regards,
>>>> Terry
>>> Hi Terry,
>>>
>>>
>>> I don't understand why the recommended change will influence RCH RAS handling, would you mind giving more details?
>>>
>>> My understanding is that above 'pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)' is used for RCH case.
>>>
>>> And the 'else' block is used for VH case, so just check if the cxl port is working on CXL mode in pcie_is_cxl_port() or adding an extra function to check it in the 'else' block. I think it will not change RCH AER & RAS handling, is it right? or do I miss other details?
>>>
>>>
>>> Ming
>> Hi Ming,
>>
>> You're recommending this example case is handled by pci_aer_handle_error() rather than cxl_handle_error(). Correct me if I misunderstood. And, I believe this should continue to be handled by cxl_handle_error(). There are 2 issues with the recommended approach that deserve to be mentioned.
> I guess that what you thought is the recommended change using pci_aer_handle_error() to handle CXL RAS issues? If yes, it is not what I meant.
>
> handles_cxl_errors() is used to distinguish if the errors is a CXL error or a PCIe error. if the returned value of handles_cxl_errors() is 'true', that means the error is a CXL error. Then invoking either cxl_handle_error() or pcie_aer_handle_error() depending on the returned value. I think no problem in this part.
>
> handles_cxl_errors() is using pcie_is_cxl_port() to distinguish CXL errors for VH cases. the implementation of pcie_is_cxl_port() is only checking if there is a DVSEC ID 3 exposed on the CXL RP/DSP/USP. I think it is not enough.
>
> For example, If a CXL device connected to a CXL RP, there is no problem, because the return value of handles_cxl_errors() will be 'true' then cxl_handle_error() will be invoked to handle the errors.
>
> If a PCIe device connected to a CXL RP, the CXL RP is working on PCIe mode, the CXL RP is possible to expose a DVSEC ID 3[1]. If the CXL RP has a DVSEC ID 3 in the case, the return value of handles_cxl_errors() is also 'true' and also invoking cxl_handle_error() to handle the error, I thinks it is not right, the CXL RP is working on PCIe mode, the error should be a PCIe error, and it should be handled by pcie_aer_handle_error(). So my suggestion is about checking if the CXL RP/DSP/USP is working on CXL mode in pcie_is_cxl_port() for VH cases.
>
>
> [1] CXL r3.1 - 9.12.3 Enumerating CXL RPs and DSPs
>
>    "CXL root port or DSP connected to a PCIe device/switch may or may not expose theCXL DVSEC ID 3 and the CXL DVSEC ID 7 capability structures."
>

Hi Ming,

I apologize for the delayed response. Thanks for the patience in explaining.

In your example using a RP with downstream non-CXL device, the RP AER will log the
RP's CE/UCE and RAS status for a protocol error. It's not helpful in this case
because it's a non-CXL device but it is failing alternate prootcol training that can
also happen with a CXL endpoint. I expect the RAS registers contain details about
the failed CXL training in the endpoint case.

I believe we should give the user as much error details within reason. And for CXL using
AER CE/UCE errors, this should include the RAS logging. If we rely on the PCIe handling path,
this information will not be logged.

Also, CE/UCE AER is logged in the CXL handling path. The AER driver logs AER status before
calling the CE/UCE CXL handlers.

Are there any other use cases or reasons why to use PCIe handling if alt. protocol training
fails? Is there anything lost by using CXL handling?

Terry
>> First, the RCH Downstream Port (DP) is implemented as an RCRB and does not have a
>> SBDF.[1] The RCH AER error is reported with the RCEC SBDF in the AER SRC_ID register.[2] The
>> RCEC is used to find the RCH's handlers using a CXL unique procedure (see cxl_handle_error()).
>>
>> The logic in pci_aer_handle_error() operates on a 'struct pci_dev' type and pci_aer_handle_error() is not plumbed to support searching for the RCH handlers.
>>
>> Using pci_aer_handle_error would require significant changes to support a CXL RCH
>> in addition to a PCIe device. These changes are already in cxl_handle_error().
>>  
>> Another issue to note is the CXL RAS information will (should) not be logged with this
>> recommended change. pci_aer_handle_error is PCIe specific and is not aware of CXL RAS. As a result,pci_aer_handle_error() is not suited to log the CXL RAS.
>>
>> The example scenario was the RCH DP failed training. The user needs to know why training
>> failed and these details are stored in the CXL RAS registers. Again, CXL RAS needs to be logged
>> as well but CXL specific awareness shouldn't be added to pci_aer_handle_error().
> For these two issues, handles_cxl_errors() is always using "pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl)" for RCH cases. I believe no change on this part, the return value of handles_cxl_errors() will be 'true' as expected in the cases you mentioned, cxl_handle_error() will help to handle these errors.
>
>
> Ming
>
>> Terry
>>
>> [1] CXL r3.1 - 8.2 Memory Mapped Registers
>> [2] CXL r3.1 - 12.2.1.1 RCH Downstream Port-detected Errors+
>>>>>>  
>>>>>>  	return handles_cxl;
>>>>>>  }
>>>>>> @@ -1079,6 +1091,10 @@ static void cxl_enable_internal_errors(struct pci_dev *dev)
>>>>>>  static inline void cxl_enable_internal_errors(struct pci_dev *dev) { }
>>>>>>  static inline void cxl_handle_error(struct pci_dev *dev,
>>>>>>  				    struct aer_err_info *info) { }
>>>>>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>>>>> +{
>>>>>> +	return false;
>>>>>> +}
>>>>>>  #endif
>>>>>>  
>>>>>>  /**
>>>>>> @@ -1116,8 +1132,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>  
>>>>>>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>>>  {
>>>>>> -	cxl_handle_error(dev, info);
>>>>>> -	pci_aer_handle_error(dev, info);
>>>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>>>> +		cxl_handle_error(dev, info);
>>>>>> +	else
>>>>>> +		pci_aer_handle_error(dev, info);
>>>>>> +
>>>>>>  	pci_dev_put(dev);
>>>>>>  }
>>>>>>  
>


