Return-Path: <linux-pci+bounces-42647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B70CA512B
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C4903021147
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ACA341062;
	Thu,  4 Dec 2025 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rj4W3qXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD43315D4C;
	Thu,  4 Dec 2025 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875375; cv=fail; b=AmpnLcgJihDPyy8pa8eZoJfi7qsdneSCARGqmCbzqzeCy9ivEuYbc47rg1AHX2CrWYQ8sS9crahoGXzBN1wFqstGZy3gj7PNpkAXMiAZ7QUez2oap6mbU1ErasaQt9vhPGFMp3ZDYNtdzdcndmxseXIW+KtwPddrGucFB0wSams=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875375; c=relaxed/simple;
	bh=22KakfXdftU2Fca3zxRccvZgQYRGneUkDLFedVixTvg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=k9/jQLduXSudXKc5AAZJZoAmd9UqrMJ5VFosjjUkhVwTy1yESFlqaS48U6HBHC+nMJnwKxbZ4HS90QJ+2M+ws3p89Bc2My+yHuI4GaOY7wJcnVqrOoWWZv3xLr01abAmpiFrekNF9AS7eNNiL/zAS1zimbgmQOTjWrKCNijStbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rj4W3qXN; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J03PJpuw839Vr7ZmUmokY5L2gQJLppr3Ao/f7pF1dULjX0yiMh/Wl3jnU0LbNbRhyqDW9xPOJIyVcX7hFSlY/wCT9LO7FEN5JvZYzc2JoD1qwUVDu4/VPO6UXm6DCyRIc2idDMrH/ihyd0wbwtC6u7+EMNW/xI7BdnRPS4KeSOQ46wsZd9RhQRflecUN8X92UeVcf/Ue1HW4MeXiA1GUv66sNQd+uzjdIz6AC78J2YP4jS+dAwk9KAEDdiJBwW7imruP78CHIoNpsex++DOuwTVe+qrFaPhp4LlQCCSY/gsm0x1xKwbC+IIwYINd9bRxiSae1YP+HieENAYXfKCWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEKmxEKJkWgitkbudju0uqjxnaf/WygfpxVkynz4omo=;
 b=J6KqL1Z7l2MhKuggEbOQwgv/9PSExhaJBrAN4PuyEJYV1MzmYzZX4VX9mPseLfvO8iQHeAOZKfKRDZNLLaD4j68Lk3ePFGdKV3UI4IRu7M4h9Vts8C7v4UX5JQHsl2w0HVlGJAoFy478b8BO2rkmhTvelJyfo9n01sc95ylyaZKzFQbJaHJAtQENU0S5bsFRPCyJrzbS1vRnRoCKrxnHLewS2IRvx3wySc00R7VSzBbvbNO3txPgwaKTDSy9NqjDOt5QaCFrqxOvKiUB15eXQNQL22sw5VrLMBQKiIatsEhVAXnBpWWuGR0J0Tvx2VKl3FULQc+077T44v2tKGD8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEKmxEKJkWgitkbudju0uqjxnaf/WygfpxVkynz4omo=;
 b=Rj4W3qXNP15ntFZOW5iNS5EMWtf9KnuBpHbjoW+LYGTWNPhBQHqzkdRBFY6TnUQVWn46xkaNcEJz5gTqcTt9aDlDZaNqBaDXYEmTIUxDP/wwNZONOajdzaviHzicV0jIfkWHeCRaouhFNA1Na8OKDYxrJjo5Yd0h5n3492AhKiA=
Received: from CH5P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::13)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 19:09:28 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::eb) by CH5P222CA0015.outlook.office365.com
 (2603:10b6:610:1ee::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Thu, 4
 Dec 2025 19:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 19:09:27 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 13:09:26 -0600
Message-ID: <adb50a0b-d00c-4c99-a169-127ad68e858a@amd.com>
Date: Thu, 4 Dec 2025 13:09:26 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 1/6] cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Shiju Jose
	<shiju.jose@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-2-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: bb997b98-f712-4e12-d94b-08de3368a53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V280bksvS0Ntbkk2YkN1dDFVZHBLMmVYaU1MMWJoZDR4emloaW92UkRML2Rr?=
 =?utf-8?B?OGlNRDhwUzcvSGxLZUM3VGg4UlRaOW82RTRBcnJMR3prR05ZeHZ4RjN5VjNz?=
 =?utf-8?B?Rk9scVk2d0Z5WDc1a2tsZHpvVzhZUk9wbkNQN0VyYlRnSDh5d0lzQjcrZFdU?=
 =?utf-8?B?SjR4QklLcGRMTXRuSEtEd2prUmRzNnI0YWtXSXh2WFdZbENjZEZpNjJTYXRy?=
 =?utf-8?B?V0VCemdQbE5FQ0hURjQwUkdUQmowbjBab1d0N0I3c054Y3JTK3ZTVlM0T3JJ?=
 =?utf-8?B?RjByZEFuU0xCZmNKdU1wQ2ZsYm1haklDQmx6a1AzQlpZaVdBQkxLN2RBYlRC?=
 =?utf-8?B?NjR6YThVTzA5U3FYYUFwRUl0QW4rc2JxRDAxRDA3R0t3U29Xc1RlaGFsS1pZ?=
 =?utf-8?B?aGJWWkRNZk8yMmRNQXVXaUZvb1NxSW1LeGtZVXMwRjVubjJVbUVhRnZHQXFH?=
 =?utf-8?B?cVhiYnJSU1ZsajhBSkRYQnArWXgvbTJidzlQeVU4dktNdGtBNU1SUmpOc3ZB?=
 =?utf-8?B?QUhJemVKYUpnZ0hxWlNROGpOcEdqVHhDYi9FR2pDMkdUczhhc0M2UEUvdVZZ?=
 =?utf-8?B?cm5DcWZOdXM0T0JzeW9GWlhhTSt4NXIwUTIvRnlCVHJBaDVkcmxpOWV2WDVB?=
 =?utf-8?B?M0lNdmpxUjRHMmZFdXhBOE9UQk9VZDhVVG56Q1lXVnZGUWY5Kzh5SGNkUzdR?=
 =?utf-8?B?Qkg0Zk9BVkFsdzBFaEZ5bGhMdmQyVktiUXlvTmNVU1k0WS82b2hTYkdRUUJt?=
 =?utf-8?B?NWtZUEZDdU1CQzN0UWNOenFBY05raDRza1VUaXpSem9PQy9tV1RxVEViVjls?=
 =?utf-8?B?Y2xFdnJzd1lCUUhjdFF0NTQyek16ZXZrTWdmdG5yb094bEYwdWhOLzk1WGJz?=
 =?utf-8?B?NnhINm04NHIzeXVxRlpwSUtYS0VtVVpHWEt6WjhXOUFjTzBtL1AwMUJVWXpu?=
 =?utf-8?B?TDRUOFVyWnBPc253dVVyZUhSV3hrejkvNXBrbzliakRiTzA3Qkhobk05cFlB?=
 =?utf-8?B?YkU3c2ExLzdiWmVzUzJmS3ZJMnA3a1dxeG16d1BZMkNGS1lmd3ZSVGhvYldu?=
 =?utf-8?B?ZXhobld3NHZxMnY4S2pGNjQzeDd3ZG1mcW42V0tjK0tDUjAzU2FYWWlHQ3Qy?=
 =?utf-8?B?V3pEL3RmODIzdDVkUGpNNlZrbGxIU1JuTTRsLzgzSlJVUzRPRFpEYkdISy9K?=
 =?utf-8?B?VFE0QXQ2WmxyMDNPcWdBZHpaRFlaaHdPNzBDdUxMeGQ5U0c0bmxzY2JCL044?=
 =?utf-8?B?RS9zbFF3S3Vnc1hpZE90ZWpuQXA0SVkwb0Q2eW41V1ZEZ2FtRithemEwMUll?=
 =?utf-8?B?YnI0TFVUeThtWUFGU3NNT1I4TG5KdWNjc0wxUzRmVzhZSUJhQ3VFczhrakJL?=
 =?utf-8?B?MDRNOHY0QkYxWDh0M0xBb29vTXVBMExUbmdCZDBFekppZy9oSW9lOExXV2VP?=
 =?utf-8?B?eitpNEliZSsycE1WcU1TZjFnbzZCaDFDWFV6MXdUSlp4MmpBM3FuZUkrMzNF?=
 =?utf-8?B?SkNxQmJhMzFPZE5hTElsc29OT3pMV1BKQ2hFc25QZEJhVDJKMTN5K2xEMllz?=
 =?utf-8?B?djFsRjIzNkZhNHA2THRxU1JjcjJDZGI0NVFFdEFENjV0bG1vdGI3S1FLckdG?=
 =?utf-8?B?ZUI2NWtlQlQwZVBtVk1IZXlKbnlMSFE4cUhKRkJ6MVFxNUxMN1BnazUzdTZa?=
 =?utf-8?B?K1BsUDFFZHNhUHljSElEYnBHU1VNUmc2RjR1WTRJTkhXcDZBbkRVdCtqc2lO?=
 =?utf-8?B?TkJZdnBNWkg5MytTRVFlTUJmaDdDSGt6NHp4MnRaK3YwaEk1TExubDRHZEo3?=
 =?utf-8?B?SWxWTHZXVFJMZ3IranZpRzNRaTRsYldDaW13dExZZW9oaWFqNjZkcWc1cTVa?=
 =?utf-8?B?YjR5VkhURjUrWXMveEhRTldlZStCQ2FjWmgwa0s4OE5PMmkzU21zZHlBeDBO?=
 =?utf-8?B?RWU3TnpWcDZQb09FQzFPK3lVT0Q2UlM2TDU5eDRSaXI3d3V2T2R4VG9uTEV4?=
 =?utf-8?B?Tk5USTkvdjNQL1FscGFWZnJJME9tQzVxdElRUEdKV3NSL281WUM4QW1uR2cz?=
 =?utf-8?B?dmtHVDAwZEtKZEZmWDRmN09WOEJEWm1mcnVMclo5UEIxUE9YMENsNGtUOFJT?=
 =?utf-8?Q?GNNI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:09:27.4529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb997b98-f712-4e12-d94b-08de3368a53e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049

On 12/3/2025 8:21 PM, Dan Williams wrote:
> A device release method is only for undoing allocations on the path to
> preparing the device for device_add(). In contrast, devm allocations are
> post device_add(), are acquired during / after ->probe() and are released
> synchronous with ->remove().
> 
> So, a "devm" helper in a "release" method is a clear anti-pattern.
> 
> Move this devm release action where it belongs, an action created at edac
> object creation time. Otherwise, this leaks resources until
> cxl_memdev_release() time which may be long after these xarray and error
> record caches have gone idle.
> 
> Note, this also fixes up the type of @cxlmd->err_rec_array which needlessly
> dropped type-safety.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Shiju Jose <shiju.jose@huawei.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

