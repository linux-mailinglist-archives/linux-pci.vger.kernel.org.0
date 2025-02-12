Return-Path: <linux-pci+bounces-21292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E5CA32B84
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 17:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DE93A6A94
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 16:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71951E766F;
	Wed, 12 Feb 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="og6CL0Bh"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F520B7F7;
	Wed, 12 Feb 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377439; cv=fail; b=GVkp743Yrhe2X4qqsgtFsoxN3WtdFJYuvz+yAe1RSi+ainztJJLVqkWC7X40ytBCJXRQWTdTjX4mgmWqPjjwxaZBPkz3yffj9Xi3DDOQZx7b+trDvmnj7Ujyd/zqLHEzfCbJH3bjRRg5hmm8zf//28Yd0++4Nj/LprfSmjncId0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377439; c=relaxed/simple;
	bh=fnz6Uwzus/vNng1s7yufdQR0a3pGu5nEoRXkp4oyiMM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dtDd/hoWz/ysCj5hBP4Iy39Wm/i5seuSjnYoz7+9uHsW2Gtx1xles6g1vmkve1NvlZOMYqY1NyL19sU+BkdZRp6LEukRU/wGIVPPYK+0JQb9fYVLwXtP9Njw+srN+qdz8p4MBl2KOX61NCIS1WVLrjw9oLU4kti/OKU16VvNbGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=og6CL0Bh; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRnDBG1mTqmP3mIb0uOybRNn1UF5uYK+714hjsQd+M60lMDupO04FMh+QL+3louFUol3IfYwgnRR0y6aSRYCnh36PDikwoEy9IiPvuB8TQF5VeNX8nNXTEMd/6QFMff9zVTgpQalbW6BJBL8ufkRiH7atImtLplhr8v8kcwgMXjEq7SMZsQYjArA90RjzWJnzX7oU0OVFk6XMEL77i2GMqp6XdBkJJQ9CxGE6+TrqSZKJoLITtEDcD4ihgGPOY45REpSH+v0HDnT7miefQGugqaVYpXC1bsxOWlIO4OktkTrsYk0fnWqE0uBVXxKTqb+JueyGpvC/KhmZXfaXoz1yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR9EdCG4uoxwW6QydleccUAz7/g1Gd4dZx1JIbo7H/E=;
 b=wRXIpMVSLTZbXwfgVN1DNMXKqORmzZTTTHIRfZ+fra4vCSAGytc5gSRWCTMe6xDEvWY1V+00H4WFen/4ZveV8TP6p5/dqJKTuBWZfrLmNTpSDHIOtwN7wwP+e7HNKS69vydUJQxCWkRvIYfDEo9Y7qKKiG5eO7X3fKaEojzBGzpJDMm2VzbSKgXrHZLfNj1w/ndesTZm5kGiqwbI72O+TPtn7GiKAFUicJ0oavTbzozqkMLeHIzMdTqQuL9CnbnFnEitNYXAQzaIl0oM+cEFwLQ1za7qFkW5iCepvq4foIz1rlvews5YRwrygDfygh/o1DZ8ehtzuU0tJ6YIKNAfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR9EdCG4uoxwW6QydleccUAz7/g1Gd4dZx1JIbo7H/E=;
 b=og6CL0BhUTjsCNT/QlkLKLSH57KYyer8l8//mesSjbfGZAtUBd2a2dTR8DtbNr2XldwVpx+VScCLMCzPvcIT3eWo2KrgQdd+biCWmpwCeu7ASoXKeYF/4l+ZZbN4d039c0EiyZSw+8lrrxRlG/G5YHpNeMxwxUUzme/+PlMdRvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 16:23:54 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Wed, 12 Feb 2025
 16:23:54 +0000
Message-ID: <e797ceb0-d72d-4288-bddf-7e8e17999a47@amd.com>
Date: Wed, 12 Feb 2025 10:23:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-14-terry.bowman@amd.com>
 <1ba44c00-26f4-4373-8726-2874d32b61d2@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <1ba44c00-26f4-4373-8726-2874d32b61d2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0106.namprd05.prod.outlook.com
 (2603:10b6:803:42::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1b4280-6aea-4df0-4552-08dd4b81a4de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1B2VWl4YmljUGV2NXZOWDdOKzZHMDBjVHhlMnJrMXdQUWxtbnNBclpFVEw0?=
 =?utf-8?B?emVzTzVIUkFQNEs3ZDluU2xNM0V1dnB3c1l1WGhWMFdwZE83RE5iaVVoSWtI?=
 =?utf-8?B?L0ZaQjFqSmJGUGNuMGFQNG1BcHlCT0NIME9kU3pDaWgvVHhBcTAxa2o2cUF0?=
 =?utf-8?B?TmFoWHF4WmxBYkNTaXpiZW5QaDlISVNtSkIzNDZSQVBJYVJxVm5zOEpMZ0Na?=
 =?utf-8?B?RXdFSU9WSGpmK21FbjFyenEvdVBVek5sUjM3MFhmaE55UmcrZEdOTExzaTEx?=
 =?utf-8?B?V0FvejR1V2ZsaGwyOE9DdnVxN25pMXN3Tmo2dGJTNmhHMHFNT1R0azB3MkFk?=
 =?utf-8?B?Y3FYQXZ5VUthUmhiT0YxQ21FeHY2RXJ0QUgzSjdqa3BEN2E1U0VFTVR6NXpN?=
 =?utf-8?B?Rkd5aUZJU2V2bGNDdWVib0NJZjV1TmF6eUFBeVR4VFMzTG4ySTB3WER2TkNx?=
 =?utf-8?B?OFlmcHk1TlgxWmJ5WExxcjFjek4wbHBpUlRRblZzK2VvQXBHMHdmWVo2ZUlo?=
 =?utf-8?B?RzFhOEdmUE1ZVTR6aFMrQ0hvRVlQWEFZS1JHZTYxMlcwTnVxY2VUN0FINHJm?=
 =?utf-8?B?Sm00TXJ4eTFoMnBFL1N2QkIvZnFMSTJFYzMrb1dQYjRYRS94RzhGd2orUENo?=
 =?utf-8?B?K04xak9hL05Wa3FpaElCV2lvcU1Kc1FGbDJmWXV1NmZ4MHM5a0lPelEreGpP?=
 =?utf-8?B?K1RFUk91b2ZqeklLc2x6bGJoZ25wVVpEWGhCSlNCVmh3TGdGVHBZbm1hYmhE?=
 =?utf-8?B?cThCQnRvV1B4V2FNbFBXaFFFNHJhMTgvZ3NaNThTVFl2NmRsdUpaRC9wRVJZ?=
 =?utf-8?B?RmRHSmVFTFZuZWhUdXB6cmhmaG5wM1lTSmpGZ2pXT3hYd1dDa3NaTHBDckxn?=
 =?utf-8?B?d0xhY1lEMG5BSUI1SEVSOGh5U2JZM2V0aDNxNXp4Y1BhR3kwL1FlaVJTNENv?=
 =?utf-8?B?bzF4VmhGWmlCQlFYVGhmY3VtSEhNTno2TGgzUHpVMis1eTVDRkJRNUhhYlQx?=
 =?utf-8?B?R1dOOU1RazlRSzljZVNSQXpDaElYQUlzVzZqWkp3V2FjMVZKSzRVMVVFMGNS?=
 =?utf-8?B?U3Qxc3kxTVA3MnV2bEtlVnJYVUp6R25Td2h4cnJFZFNFbTgzc0pWUVpmaFh3?=
 =?utf-8?B?Zk9WQ3NXSmVwRHJIZW5wb3VLT3ZIYk0xYkJhQlI5bG12eXRtb1VCWGl0RTcy?=
 =?utf-8?B?SkFJL2Y1cmk5VnB3RE9VOE92YmpTUWxyRHRhSm5mWDg4WjZKOGFqd1lFRFNH?=
 =?utf-8?B?ZlhFUGJEWW9rdlBwMmZLTGJaczkyMHFSdkdaYzVqN2JPMDQzVlVhaG5YSVFr?=
 =?utf-8?B?YlI5OWtTSmZKQTd3Rml0Rk81Q2RaeXFJTFc3b0JzMkszNHVhWnBKcmVDRzBw?=
 =?utf-8?B?N0NvaUo2czF3MXR0UkViSkN0TllRZ1g5Z2h5M2YwRU1mVXQrRFdETVd4MDQr?=
 =?utf-8?B?b2pQeTdMdjRVUkdDdUg4Y0pITmFkSU1MaXJBMlA3TFo5bWtRbk9NdDRkMHMw?=
 =?utf-8?B?VWdNRUZ4Vjh6dnNTdE9TRjRwY0pDY0xqZjY1RG1kQTJvMFdUV0FJb2hIbG5M?=
 =?utf-8?B?U1hZSVlaOXB1SDA5UlgxVGI4VTc3Tmg4NExhdTZJM2dLRVJCQU9abVIyTWN6?=
 =?utf-8?B?aStZNUwxa2ZkNXRGdmhURWNIeFc4cFk3Rmx2b1FYNnJtU2NCQ1NEUnZXU25z?=
 =?utf-8?B?OVJiQU1JTXNhR1ZMNnFobEwvWlFoK0JKM3g5V1ZNY050UjhHRkZYUU1NSEdq?=
 =?utf-8?B?bmtmcUl2UnRzcExNdlF4SDhsenJEQXRqSTFCRFoxN2RjeFhmeHdyRUl4MWZX?=
 =?utf-8?B?Q3ZOZjNPcFR3NWI3Tm9GcWVyREVzbVEyejl3V2Erck4yTDFrL29KN2J0bm1V?=
 =?utf-8?B?dC9wRG9Kc2hmRUFPU3VQUU1TVjFFWkwremRnV2pJZVRpczZrQUs4L2R0eUJU?=
 =?utf-8?Q?q2FjQBaHvwg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VkNzRzM0TG5GMWZnd0hTMmJUTUVjOThEd0MzU2ZJVDZwSHl1WGs4N2U2Q2NL?=
 =?utf-8?B?Nkk0UU9OUncwajhDdEZ6UjkrUmgydHM1c0ZpR24vQWJTNjJWOWRUbkYrZlZk?=
 =?utf-8?B?cHJqSERETFVvQkF0NmZ3MG5JUzBTQTc3K3FBVDQ2UVJHNy85ckZaVzUwZHVz?=
 =?utf-8?B?N2NZZVMrNGpuYjBSWGZ5Tm1BbTRUQ3RwSXE2N3UwbG84ZTMrTjhqMTJiS3JK?=
 =?utf-8?B?ckR5Nitjb1ZxZGJZTVI2VWFiaDQ5WnpsQVA5VFFuWURoY0pHQ2dTT25TWFRJ?=
 =?utf-8?B?RXpHVjdtbDFUK1IvaC85dzdkNFk5K2tvbTkvVXdlenhHYWIyOERBQjV5Q1cx?=
 =?utf-8?B?T2JvV2I3cmVUTUpWV3lDcnptcW5GSU5jSFgyVzFMSDI0UllObWRqNmtQQkhO?=
 =?utf-8?B?QXArWUlKcGVwTk4wTVVHMS9TbE11R2p3MjhWQjhwRVkvc29mOFFqZkJreFlp?=
 =?utf-8?B?NGZUYkZNOWxSQ1ZGNHBvZFAxTzZxdjdxdnZlY1c2SnBBVjlBc05wYU5QUmIr?=
 =?utf-8?B?R3F1dUNBL0g3Z1BzNTA0ck5id3M2bTZQYjhNUm5jQUhyYjZCYUJOQUw0QWM0?=
 =?utf-8?B?Q1d6UFIvSVVZMkhvU2dZNkhaODJJL1E0U1BqbHZ3VldWbkkrWElyaklMWS9r?=
 =?utf-8?B?RGhIQk5ncGRTa0VEU1o3QzN0RDZ4NFpFU3F0RytWQ1JXYkdtS3NyZzU4cG44?=
 =?utf-8?B?VkswQ21XUzVsTUhTVkJWT0RBaDdDeW0vVXJXcWpvNlU0WXJBVGZ2V0UyRE5K?=
 =?utf-8?B?TXYvV2dIWWMvWGFYaXMrR09XbFBXSkRVcHZyR0VQeEU5c1VMZHJuR3VhSDRZ?=
 =?utf-8?B?QWJiWWhNQ0VkVlpoMXFjSy9YT0xUL0s2d0Z2RkJtNE14TGh4QVNGNkRJSlZZ?=
 =?utf-8?B?VnNUWVl5V0tyQmdrdE4vTEo3djhQN3dGblRQZWdhUXF3VzNudHl4UTBpUWd1?=
 =?utf-8?B?V0d1dEpTR2g4b1VNUHhYL2xNU0FaNEE5TVBHWG9CM3pqb20xaUhPQ1dpelha?=
 =?utf-8?B?eVArUkZTVmZ6ZUNYZXZCY2MyNFNtZm5HREYxRi95MHdDaSszemlHb2x5RS9s?=
 =?utf-8?B?aXZxYXQ0TVlWcEdOanBkQkhFbnVqL09vMlVySnJvNDRjWTZIUGRTWUJ4N0Zr?=
 =?utf-8?B?MDNQU1V2ZHNSMERZZ2xVOHBJSDFaUHQ3WG9hVFlkNW43R21WUkpSZnRianR5?=
 =?utf-8?B?K2RiN2tNU3AzczRXYjExMjdBQjJ2TUR4NmZkMnlwNnUvUktheVZZamFuOTBQ?=
 =?utf-8?B?d282NnhQd0FPc1JzWHpVN3VQdmNKWXNIMUtCenBaVlZSUnpwNDgxOXVKZitU?=
 =?utf-8?B?czJQdXpSZFdXd2IrOWhaamxvZm5hODZWUVFyUXBCaVZUNzgreXByNmJSTGVW?=
 =?utf-8?B?bUp6cGlzRGRkSy9RVVBSSnFOTW4zMmtvb0JoNGd2WmpNYW5Mem1Gd085R0Q2?=
 =?utf-8?B?Z1J0Yk9sQ0FYbmdrVDF0TmJsTGJqemJrcSt5SGlLSjJiTFl6VkljVkxheWJs?=
 =?utf-8?B?R3E4bk45VUtSUTJpWENlUDR3M1kxMnkyOU84UDg5Z1RGZU9SRlVuQzhsNEJX?=
 =?utf-8?B?OEhCWU5aTGJsSlJJdU40WDM4TTFZUW5vaVZJQUVha3g4aEcveVBONEFVMHNM?=
 =?utf-8?B?Q1hieVNyZ3haelA0M3lYcjJvR1lpcGFMR3pkL1VlYjRyM0FwcUphZXlGYTJ3?=
 =?utf-8?B?NjV2eFBOZW93N1dITndsYXlPclV2QkliVmJyRVZzbE9nK1RlSS9CTkhqeFgv?=
 =?utf-8?B?UUsvVnNkTHo3SUIwQ2krUDlwTE1CTEJzY3JJRS9pQlNnbDhsWHUyc3VHOUpt?=
 =?utf-8?B?Yk40SStOZSt1dmxlTE9xdEpxUlAzbUcxcVN5NWd0aUQ4ZDdzakxNQmdoRE9q?=
 =?utf-8?B?MEJqNXdFSEpZd0lyeGRYYVNZUWhhcGlQSy9icUhMbmViV016UXFtVFVMWE91?=
 =?utf-8?B?bWRsOTgrd3ZqKzhPM3ByOWRneVd4Q1B4bVAyRzNnU0t1VVkxa215YnpaWjZ1?=
 =?utf-8?B?WU52Q0xQdUVWMklyeGZyUjFjUDFKaEJDeURPREpJSmkvN2I1eU01QjRNV243?=
 =?utf-8?B?L01JdFdraWY2T1hrNmJkNTNyK290V3duL09CRkZaVGx4Vkd6OVZqS2RlVGZJ?=
 =?utf-8?Q?wwFUwLBHM9gTvs65g/obFl0Ic?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1b4280-6aea-4df0-4552-08dd4b81a4de
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 16:23:54.6989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bujXpPHViW0O/9HSGxylFJyy4yLop+rMezTE14qYGHlOaQgZurJm/QZWxXtQApugEji0MhZbXAlfD/y2T5m/DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508



On 2/11/2025 6:17 PM, Dave Jiang wrote:
>
> On 2/11/25 12:24 PM, Terry Bowman wrote:
>> The CXL drivers use kernel trace functions for logging Endpoint and
>> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
>> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
>> Upstream Switch Ports.
>>
>> Introduce trace logging functions for both RAS correctable and
>> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
>> the CXL Port Protocol Error handlers to invoke these new trace functions.
>>
>> Examples of the output from these changes is below.
>>
>> Correctable error:
>> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> Is there any way to identify if the error comes from the USP or DSP? Specifically the PCI devname for the specific port?
Yes, the PCIe device type can be converted to a string for logging (USP, DSP, RP, etc).

Terry

>> Uncorrectable error:
>> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>
>> ---
>>  drivers/cxl/core/pci.c   |  4 ++++
>>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3f13d9dfb610..9a3090dae46a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -671,6 +671,8 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> +	else if (is_cxl_port(dev))
>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -730,6 +732,8 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>>  	header_log_copy(ras_base, hl);
>>  	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	else if (is_cxl_port(dev))
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index cea706b683b5..b536233ac210 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,6 +48,34 @@
>>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(dev, status, fe, hl),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(parent);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		/*
>> +		 * Embed the 512B headerlog data for user app retrieval and
>> +		 * parsing, but no need to print this in the trace buffer.
>> +		 */
>> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> +	),
>> +	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
>> +		__get_str(devname), __get_str(parent),
>> +		show_uc_errs(__entry->status),
>> +		show_uc_errs(__entry->first_error)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>>  	TP_ARGS(cxlmd, status, fe, hl),
>> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_correctable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(parent);
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s parent=%s status='%s'",
>> +		__get_str(devname), __get_str(parent),
>> +		show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_correctable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>  	TP_ARGS(cxlmd, status),


