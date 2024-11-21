Return-Path: <linux-pci+bounces-17182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E99D53F0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 21:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB1B22E51
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133331C82E2;
	Thu, 21 Nov 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jv/WT8Pv"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A14E1BF58;
	Thu, 21 Nov 2024 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220667; cv=fail; b=p9dRBZKwj0ylw5EbJYQZkFomB4rH7IoDu1QJCBsaxXtBoUeGzzDvoBQSX4g8xHFhmylMtzVk7hgQ1f+6Ai6ygOIAOY5eYSzKLz77TU8Lvk0gwzVej/xY05AgIrI5IfXc13TAGQgNC+A3yM2mAaWSDo0H7i4hM1TmB5XJlqET8vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220667; c=relaxed/simple;
	bh=X5GV0FILgsWrVLRyU8JTmAcoAjCMlFjLZ1inUOO75Ec=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1vsKhrqOjQHysJBa1I76lTFo/LRygiXrO1ouCjPbvHwtYnedD7o6yN6uLRASfWiTISL+ZH10t1qWKsZLYy3pQDj936TJD6wDgcrcafnW/9Yc755gG1kD/gqqQcU5QfCPYLMfXyjbULv57qPOPcmZpOVAezoPzH+4HJSYam5SUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jv/WT8Pv; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNXd5KM/1y8O9D45aShR+QKasejm/88R+3blmmVU6s/zv3gTteSgadcE1MD2GFxPd4zWFa6bFVa1wgBVf70i28Qw5GRqfp9qLmUD6KDYnuDtajB9KoO1wDzm8VqPLybK4N8Q43Qm4SkPet7MUo8r5lVUSNDnVBefoZkoIk3+fmxcOBbsgbGlBxdrFA6X3fc8CGAWjU++kBHTR+16F9HGwRZZa2T5TFF0WqzTi9j87SZ/5ErZhws84lgCL9ESI5MAJQAJc/2/1tXS920vjYt/nsCDIY7B/slj3KYwPXI5qxQ+PJULEVAep60rXDEiL/yvmPCvOjZduuM+nALdMkvIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvRO5oFy2/gjeCekXRje7OtYGK0H+hcV5HVLjhlAPYo=;
 b=F9kVQlUybZZWrjXWAHWGMhZ9cDeKwi1t297QFpK3dCUzEKkbpu7HRDVOwXV9nUWa7PukmrYiuPxg25ud5awMedox5+BDB2CMHIULoHjkXyj3XpukkeIB4KaROD93srJDk2gOwEgqZZS/rFufcU629H8kANj6Jf3NztCKnmwbn7hWVLf0ceVPboOpqBiapqaLM+ng74gLepGwjhtb91Ctrmf6UvGN9dlDqMSL1WjGs90Q9UTjeUWdyzKdaU+ZNvgOYXsnwwpwxft3u1ofBCxynOsHPhACoixyRSp/xi48viG/KJAnLEjGTatE516jPIoh6MMcTl2SS/oart44B3yNzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvRO5oFy2/gjeCekXRje7OtYGK0H+hcV5HVLjhlAPYo=;
 b=Jv/WT8PvuyJSoR1j4wRw/CmHqyES8iNyaqOZtfiCprkP97dP/4p/qa3lnzTOVfNeWxMUC/8SV2TFeQ2EMO/XyBK9OU2L2AHV0gOPjgqX0p26K17AV4e1vj/bCuvVOp1HhraxQiMVLmWdwpQJ/G5li5qaRdzyIq07TH77y3DDdK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Thu, 21 Nov
 2024 20:24:22 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 20:24:22 +0000
Message-ID: <c7c9d417-5c32-4354-825e-58f736726114@amd.com>
Date: Thu, 21 Nov 2024 14:24:17 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/15] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe port devices
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com,
 Shuai Xue <xueshuai@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-7-terry.bowman@amd.com> <ZzcVzpCXk2IpR7U3@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <ZzcVzpCXk2IpR7U3@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfa8787-ebaf-4857-3922-08dd0a6a7c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0pZcmhFanZwYlhQSlE0ekVZcHA4K1Z5WTl0bmNFamRZSHozVGxXZUdRRVlz?=
 =?utf-8?B?RjZGSnh6NUZFQ2J6SVcrTWl2Sk5SU2I3R3Y0THZmZVFCWnVwZzIxSDQzYk1i?=
 =?utf-8?B?NTZHNUZQM2ZTbVRtS1JuWWlTU2hhMSs1b3dGMDBrMlBhcURmZTgveVNiWWdm?=
 =?utf-8?B?U0hIVE4wZFY0QkloWHBpaEZUM29ENFVvRWIvMU9RaWZ2QU5xalF4d3MyVFh5?=
 =?utf-8?B?dFZKZFdLeGtxZTd2b2JQOFhMQmdYYlZ5bFdBR1FNOUtFNnJad2cxaGxrTFNq?=
 =?utf-8?B?ejZHbEVHdDJ1Ri9SSDRuV3k0Yk9VZ2M0N05aRXFWaG5OT3ZrUmc0eno0Rng2?=
 =?utf-8?B?L3RHWHQ3WERDY1BKWHVpRyt2SlQ4SWpzWndZNFdiZmpmVTJYK2lNeDkyM0Ni?=
 =?utf-8?B?T0Z1eGx6NE1LV0RadFRkOTZreE1ERzh5ckViWmFxd3o5SEV5aWlQa1hrUEtU?=
 =?utf-8?B?R2dVaE9pamUwTWdZOUEwbUF6WjFtNkM3d0dic1NZdHpWTUxPOG1NaG5oa01W?=
 =?utf-8?B?azhicENMaDRndUpnZSt4SVltdU9KTklxRVdwRUw3cHp2WWplcU5MQXlpTUVU?=
 =?utf-8?B?MGJiVlRLa0JaSVNPWUl5dWJLcGZMdWwrZ2hJb1FsRVJBSThKSjZueVoxRzlD?=
 =?utf-8?B?ay9ra0xWek43WHlXczVLVVZrOHNxQXNrQWcwTTU1Q2R6TjFMaC9LU1RSMEdM?=
 =?utf-8?B?ZjJOa1g5MjA5bjBtbnJVdjhDY05La2VHNDNLWStVMmh3MnB4b1RmOXNXQ2JE?=
 =?utf-8?B?TmgvczhBTldKbWZOZ0lIRmVSK2JJd01lcmhVa1hEVHRaSlNkRVpCUm5YRkpH?=
 =?utf-8?B?SWhLWUhYd2h0bVBuU09rZ3kzUjRSWDB4ejBWaGlRbEE4bTVPYnBqbWFmVkhP?=
 =?utf-8?B?KzhqdGxGbHlGWlkyazhQUVJBMWRWbEdZVFNPSzE1emYzNGNxVHdPS2p6MThq?=
 =?utf-8?B?dXE3MDB2VEs1VDY5cVd2RWd0UzBBUXNOZTR6KzlVdUdtc1puelhtTnNtb0tz?=
 =?utf-8?B?WjdLcXdMVzBSTWhqYitRb3FkeHlEaFJpSkowR0VRcGEwRkFram5UdWF0WVhO?=
 =?utf-8?B?em9id0ZDMDVoRWJOSTJMRkIwNzE5R2tEbFpXMWY2WndzNjNXclR0bzR6OFdI?=
 =?utf-8?B?WHZyc1NDRmhBcUgyanVnclF2MmxOTWwxTzc3TXp0T3ZqTTV3VVk5M1E5R0N5?=
 =?utf-8?B?cWJMTjdabCthOVl6ZDM1ZG1mME1LVVl3SWhycHdxTUFvMytKMnVONjYwd2Nt?=
 =?utf-8?B?Nnh2M2ZHUGlWMHpLeEJNN01haGw3VDlMaU4zQkQ3ZWNITjBJeW0yckxya1JK?=
 =?utf-8?B?d0NudWRpd2V1WVNhTkJNdGtYd0VxWlFyZ3J0eTlQZDZwQW84Vldqc3pFc3gw?=
 =?utf-8?B?YWM3ZEo1UWZ3N0ZlYWpBaWMwQ1NLU0dnQXo2bTdpK1B0UTNKZHRsVVkzMzgv?=
 =?utf-8?B?UlgrR1g4NEpZRUFIcjJqcU1jRktuUGl4TjIyck9iSU9takRZOXd5aWNLNWVF?=
 =?utf-8?B?RnJPMFNUbG00NHdrWk5iUmZTQmsrNlNMc3ZPRmpLMGRSNEl0L2lUN1RQdkZ6?=
 =?utf-8?B?ZkpUKzBXcUwwT3Y1VVFGeFptUG85cFlHZTlRbC9Ddk03Uk9HNmR4N1RidWFo?=
 =?utf-8?B?WFpnQWYwdk52dWw2R3E5WDhMZUp4Z0dCaHhuL0NPMmJRZ3ZzV1JMbFhyQ0I4?=
 =?utf-8?Q?hjR32TAkn5dErOtWLe5p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjNsYkNBRElHTzBiLzQ2MkhhSmFCRUE1ejVIa2JZWU8yekVTdU02WUZlQW9V?=
 =?utf-8?B?WStJWmNZUVJtTGdKdGw3WU41QnB3M0g4eDJSTU5waWEyWnZIVFBzQVM1SER6?=
 =?utf-8?B?S1ZaL09MdjVtSExnYWxLM2NOTmJrS1doM3ZVZlRENWFkWklDODlZNXJaMTZh?=
 =?utf-8?B?ZkloRmpIMGI3WG9IMXpHYTBEQmdUeW51Y0x5V0NqODA3TThKTnBSeE9KbVRv?=
 =?utf-8?B?aUk1eDN3eFIzTzlHTW1CUjNXTDMzMjI3OFdWbXl2L0hpcWFKNDduN2tpNG5V?=
 =?utf-8?B?bmN5R2tJak0rNUQxYThjeVFKYmV3R2ZuSC9TV1d4enNTQjZpQjJrMXZxbVhY?=
 =?utf-8?B?clkwcmRkbDBndy9Dcnh1OFJHeGw4V0UvV1pTNHZrZUxYcnE3WjZxWi9rV3pK?=
 =?utf-8?B?NEpyNVAzUlAvd2d1UDNEYVZNUjgvZW5tdUtmN3dVMHJvM1NrT2FJbmlGcC9m?=
 =?utf-8?B?bGVWU2xlMWt6UllwbGdkUnhPZXgyZ3pxQnNHNWZWMWxVZmNjK0NsMndKZkdH?=
 =?utf-8?B?ejdzd3djSVc4RUxFTmxXSGw0dURCaEFndnhvYXZKaXUyWFhEMEczcWVMTEJL?=
 =?utf-8?B?WjhObG1jWkxNMlNKc0M2Q0VFbHpieHZWb0RiTTdnMVZTa3N0Q3ZTQTR2VlVy?=
 =?utf-8?B?bk1CYVBid0pZRTE3VHZLSUhGWFJyajZTS3RiRnBWY1diV3V4eG9sMHNFU0hZ?=
 =?utf-8?B?RzV0dWpkSUFWMzhpbWZjSHZ0WnBVcEFtV216UWZGbTl6UHhuLzFwbmxPNnZm?=
 =?utf-8?B?Qlp3V1JkYnljU2JDdmZvZzBnTGFiUWVHT1dzdFVwVUlBT083VlgrUFg2SXFO?=
 =?utf-8?B?R29CeGVLYktXczJEQnMrZUM3aE5wSllVdllsaDF2YkpyaTA4a1JDWlorRmRQ?=
 =?utf-8?B?YjJOWHdCbHplOGVlWlVFb09CSEI2cnZwcUIra3BNRkxVUDIwQ2Z6VktycnY2?=
 =?utf-8?B?bEtUZUMwWmlqdkVJaDRkNStMemtGOHpKc24wODVjOEdrMnY2YXRNa2ovdGF0?=
 =?utf-8?B?bi9BSUNkdmJBRE9QdkhsY1MyYlZzNEoydFN6M3RsL2Q0ckEvczdRd05pMyt1?=
 =?utf-8?B?OEcrUjBLT3dmU0NUWkJsN2JKYkFOb3RwZWtzQ1JZbkIrY3FqVW1YNXVQNjhp?=
 =?utf-8?B?YzcxSGZLUzhuQ2FFclYyK2RjVlo5VXEvRFBWamlRa2ZjSGthWDdaS2NicmUz?=
 =?utf-8?B?b2VYU3djVEpQb3Fwem9YcHgzVEpsT3hja2xCYWh5Z1ZVdGtLdG5seGdWN0RJ?=
 =?utf-8?B?STd2cWZuN3pXQTBlak11c3A5VjlJdVMyMnNRYlVPc2h3N1ByMjl4OEtScTV4?=
 =?utf-8?B?c0RzM2V0RWhaRmFzSnZMOURGc3hqdU9lM2hxWGdiUXZsbmNLaVdDNXF4eTJF?=
 =?utf-8?B?Z2ZWandnSE8rcWFVNWlQYkdETXNKYUhpdHRJbEU2bGttZFBnUjJrTWRwUTdC?=
 =?utf-8?B?dXhCZjFtOFlxdnF0bmZxWVpuYkNGUmYzMUMxejd5ZjduUWl3TmpwajIwVTdV?=
 =?utf-8?B?aytCY3MwTkNEU1Nsbm04b0p0VkVOR1JKTlJBSU4ydHNrWjFmaEJqRWtzRXh2?=
 =?utf-8?B?Y25WamtnbHhQcUd6bVJRTFB4SWhuT0ZPRTFVNC9yTGlVeGNjenlXVDdyblZq?=
 =?utf-8?B?Z2xpcDFzdUtuOFJEKzEwUjhib0tuQ0trb3ZmMDFMMTFEU0FBTmZKY0JFRHpk?=
 =?utf-8?B?NGZJMm5Gc0oxSWdobFkyYVVUZTNrV3FuY05uKzZLVUN5WW8yZ3RINmJDdEhU?=
 =?utf-8?B?QVVxZnZyVFluSnBtYlQ0QWlwSkd5T1FkZlZZSmV5UVl0ck81SHhrZXBvd280?=
 =?utf-8?B?OHRnN3lxY2p5dVhyYzRXUThTQWNQQ2Y4WDBPdG1BR3VQbVBVcVd1NkJwbFpE?=
 =?utf-8?B?ajc1dEJoUnpJSDRlR1d1cGk1akduYmVsc2VyWVg5aW1iY3VBbHJuV2lHeTRq?=
 =?utf-8?B?RHBUcy9hb0EveW4rYmVVTmhOMlc3aEx0MjBXY1oyK1hxNlpIUjFHbGZnUlR0?=
 =?utf-8?B?RVpJOVFUWjFjaHV4S2dwOGpwekJyM1VFV0NJNFFTT0Vta1R0TVBRZThYS1hO?=
 =?utf-8?B?QUMzakhEd3dDRmR4ajA4OVpuc3pZSmR2Y2ZTNDhHSXFzbkJjSUJPMURMQVhM?=
 =?utf-8?Q?0CdK0IsOiVog7R7xov/ChXFea?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfa8787-ebaf-4857-3922-08dd0a6a7c11
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 20:24:22.2646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJVUB40CJJtTxVSpSlamJeZYSvM94bJjKseUQ8E7CcVCalr4Egkv3wH7qSbl3Gelzg7zy/pJhHI6DOSsakzMhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471



On 11/15/2024 3:35 AM, Lukas Wunner wrote:
> On Wed, Nov 13, 2024 at 03:54:20PM -0600, Terry Bowman wrote:
>> The AER service driver's aer_get_device_error_info() function doesn't read
>> uncorrectable (UCE) fatal error status from PCIe upstream port devices,
>> including CXL upstream switch ports. As a result, fatal errors are not
>> logged or handled as needed for CXL PCIe upstream switch port devices.
>>
>> Update the aer_get_device_error_info() function to read the UCE fatal
>> status for all CXL PCIe port devices. Make the change to not affect
>> non-CXL PCIe devices.
>>
>> The fatal error status will be used in future patches implementing
>> CXL PCIe port uncorrectable error handling and logging.
> [...]
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1250,7 +1250,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>  		   type == PCI_EXP_TYPE_RC_EC ||
>>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -		   info->severity == AER_NONFATAL) {
>> +		   info->severity == AER_NONFATAL ||
>> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
>>  
>>  		/* Link is still healthy for IO reads */
>>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
> Just a heads-up, there's another patch pending by Shuai Xue (+cc)
> which touches the same code lines.  It re-enables error reporting
> for PCIe Upstream Ports (as well as Endpoints) under certain
> conditions:
>
> https://lore.kernel.org/all/20241112135419.59491-3-xueshuai@linux.alibaba.com/
>
> That was originally disabled by Keith Busch (+cc) with commit
> 9d938ea53b26 ("PCI/AER: Don't read upstream ports below fatal errors").
>
> There's some merge conflict potential here if your series goes into
> the cxl tree and Shuai's patch into the pci tree in the next cycle.
>
> Thanks,
>
> Lukas
Thanks Lukas I took a look at the patchset and reached out to Shuai (you're CC'd). Sorry, I thought
I responded here earlier.

Regards,
Terry

