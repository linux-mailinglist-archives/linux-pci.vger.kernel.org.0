Return-Path: <linux-pci+bounces-42651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D27CA5173
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FD131B268B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5F3491F9;
	Thu,  4 Dec 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vtCpu+KK"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA91834846E;
	Thu,  4 Dec 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764875408; cv=fail; b=Rkih8wPqgXlwOSEE3qvlgiBzKLUICZrNgKGEfW0epeSvoV1SDkpwvHrPUv677cVjMZ3yephjqMTOuuqal/7qi8ZqrfEjWCNFcLmc0MYGyuofjgMv/lsnnOg9J0Z6Gt+JbxLXcXlCORemzx07yxQhVGqUGw5TwLWIgnml/wr3ziQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764875408; c=relaxed/simple;
	bh=wio9fE26FKTPuYWnQbzkTLRsPyOGmAg8C9aeZnkwKMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NKFxUYGFwwrH0NuAnxwxmjVG3m0wjc/YBw2bjZ+YfDz8fbgqxSpFg/lGVJYBWmZCZSdCdf3WRY/0s/Dk2UQxWxswmrTuzai9NzONvew8Em4ISD/enSV5gCkkCp/0QPhZ8o+lWRaxYWuUIaQSUoSnUZsEi/Hk9f2vWacruqnBG+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vtCpu+KK; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vj9Bty7bmHxoeymTDOkwgwCrgjAy9GTNRvYt3dBT0a3bspLzM1b1X6tSKySzYNTFDhLhbQ0j1caaaxgpIol14R1E8lvTvM3VeM3jXpK9EE8bfDeJsQuHJbTZf+lX7QNYZgZxG9L+Indbfn/p/owIw5FG+xcslpSz7y0EQQO7+epmfxVAeUGk40cH61u/daxNiB9G0j1VMlyny+kCnL3GphaB+haW4Z0fsMRJoOFhs4Js/XLQKT79cw3QIavnZHJscJphMG0KDv+xSt7qvcyfVXmRj58qPH2TJKuJPa9SFsTYafDPYK1p/r6k+3kOmBHt3VA3EwcEaoKJPRC04n/zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap3T+kL5Bc+s2cc+QNoKbq05utKg9saAW9GbC2d41HU=;
 b=XNhqsIQfGJU5C5OkbJTt8FBdDyIHIUH21bJIQfl7PqlYRH3dGaPw6MqI209TEPzQ9XBQb6rPuTEMaCcqWM91dG+1pzBy6oYdACxVWWCAAOlVzcMshYLTlnqtkrzVjRe2vwNA1c+K1XywAkoG0pDhSP+DzPnuGC+Q8/aqotx2YRMFqKq9uqMGZ3FfuWcss3mozQmNxAUYwJ7wPI/hDf2tVjOOCLXmLT65jsmFSrt+RDW3p+rBj4Jhro4kXKrIwBSWFjqTco7cvcmARbzxuTFFLIpBBzZGlQNS+xd2xinOSqrahLYTByu32eX4KWgqRubg/ETus5Ftwdk6Lx5rDGCh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap3T+kL5Bc+s2cc+QNoKbq05utKg9saAW9GbC2d41HU=;
 b=vtCpu+KKOk8mcw55Zc3KBk7yJjeNA9ECp9KIo8KxrLCEaMBu6nLTa3/HyIDHV6xr5z/7+FUV6H10NEdNEQIv/ig8ifwBdP5gBVHXHnmph2aLAQbnp0gd8cTtfNO8dmPqs2mdbtimc50oY6Dqha/HHO1xBxdlaT0jUgI+J1s8nDs=
Received: from CH3P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::22)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 19:10:02 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::72) by CH3P220CA0017.outlook.office365.com
 (2603:10b6:610:1e8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Thu,
 4 Dec 2025 19:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Thu, 4 Dec 2025 19:10:00 +0000
Received: from [10.236.179.173] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 4 Dec
 2025 13:09:59 -0600
Message-ID: <d13a0305-3506-4627-adf8-7ff9544b645c@amd.com>
Date: Thu, 4 Dec 2025 13:09:59 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/6] cxl/mem: Drop @host argument to devm_cxl_add_memdev()
To: Dan Williams <dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <alison.schofield@intel.com>,
	<terry.bowman@amd.com>, <alejandro.lucero-palau@amd.com>,
	<linux-pci@vger.kernel.org>, <Jonathan.Cameron@huawei.com>, Alejandro Lucero
	<alucerop@amd.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <20251204022136.2573521-6-dan.j.williams@intel.com>
Content-Language: en-US
In-Reply-To: <20251204022136.2573521-6-dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d62f94-c65d-41be-7779-08de3368b900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TldlUDM5YUx4ZE5GK0ZGQm5VdHJodHFGV0wvNWtpK0dMV09rS1F1QUZ0S0ZS?=
 =?utf-8?B?VWRnNHJ2Sk5lbk9JOTc3RDBERFpkR0JnV3Z6ZWlOU1poNWRSVkprVEMzUDk2?=
 =?utf-8?B?aE9KTVdMbjBORVdQQkJ3UXJqanBkYmh1K2s1ZDJlbGhIYUZWY2Jub3lXQzY2?=
 =?utf-8?B?c0RzQXZmVlFMUldheWZkTHNtZkpFVW5XVXZuNzlnVGdGUkgyWGdiWkV5K3hS?=
 =?utf-8?B?K25SY3lMQUg5SUFWZWNZRjh1Z1ZlbEFrRE9haHV3Tmtmd1daTVZOWDJhVnBJ?=
 =?utf-8?B?N1lmNnlIczZqU0I0eEJJZU5uOW1sRjRsNnJaKzkzK0dxYUhXSXRqcGJxMXFr?=
 =?utf-8?B?Q2JPYnE2SGVwMkZPYkgxaXljVVcyemQ5L2pOcis4TDgwTTZBSzljOExSR1Ba?=
 =?utf-8?B?M0tITXFDTU15NU5sQUNhZ1l0bmVBV0wwWERQMU1hMmVXS3lmdkx5d0lNU2F1?=
 =?utf-8?B?elJYNVBvZnY4WWNUUEtUNnJ3cmdkT294Tk00SzRYNm1nZnk3aFM2UHF4Q05p?=
 =?utf-8?B?WTVGa21zTHl3Q0tEd0ttOWt2NE1pdlhydXRESlZqM20zMDR3QVdCdWN2MHhu?=
 =?utf-8?B?cEVha1YvbldVRDF3UlEyVHFNZDVPL3RaV1NORHREVCsyb0ZZWE5UOTdRTnAx?=
 =?utf-8?B?OUNIczdZckdYUXFCTFRyU005YW92WWVtU2Q3L3NESVoveVRFRkFUbjlRNThv?=
 =?utf-8?B?R1lzS29OdkhMV08xaHFaazN1V0hJZUVZWHZCOGRnaHZGbDZVdmE5c0U2WFBE?=
 =?utf-8?B?aU1xbjd1alp2SmFtUytNbTJ1S1hjTjg1RENiZldTbFgzem9GQ0dkV2pSSjBQ?=
 =?utf-8?B?eGd4MVM3OXJpNUUwdE1nZllZZ1lGT0pSRkl4RkNGNlM3QWVTdnZXbGFQZVJW?=
 =?utf-8?B?ZGMxWWFIRkhaOVQ2U2dpTmNtMkx6NzR6S21oNXExcUhuUjNvdEZzbmV1V1ZT?=
 =?utf-8?B?bTI5UkVNYS8vc2x0VWxFeTUwa2JCck1uUi9PY1RrUTl4LzZMbk5IaUppak91?=
 =?utf-8?B?eEUxWmZzcjAxL3VJWHRVN0w0OHYvaVk2UHRkWjVFNUNzWjVnY3RqVHRjSnNj?=
 =?utf-8?B?S21QRVk1elhkWFFLVDNUYnpLV2c5Vm8vWW5sTGJ2K3dTcU5Ed1pPczFxNGQ3?=
 =?utf-8?B?UithNDBQMWJGbGZybUxBcHpUV2VoenZZYWM3Wk5pT1MrdzdBYzE0UnhHSDZE?=
 =?utf-8?B?Smp1aTdJdHFvdFczTXlYTk1JRjZQV0ovbHlRZkI4YXV3N1ErRDB3ZTRvY1U4?=
 =?utf-8?B?WmpjYjcrdGRIcjF3djNHUHFDc1M2R25CVFc5UHRDblpSWU9uYkRMOGNVa0s0?=
 =?utf-8?B?UWZiZnRyY1dvWFVmekRoT3ZESWhac0w1SFEwa2Mrc1UrTHhPRGt3KzVyNElu?=
 =?utf-8?B?aGRPMDRNUTJ2d0JEazJNdmI3cUlJK25GT1JTNUlWTDNYVlBRcnBEU1k1SWxr?=
 =?utf-8?B?dGZ4V3RucnJxMmVHSXJwZDVDUjVabGRqR1V6UjBWTFlVaThVVUMrR0ZoRWlt?=
 =?utf-8?B?MDA0L0hjRFh0aFgyQ1dTbmEreVhIMHlNQXNzYnFoZkptc2ZVZHVITUlsTDUy?=
 =?utf-8?B?N0tNYjI3Tlo3czVxZ0kvditDWVdxSDFNZVYvei9wbm0xVkZ3bTJYQkJhbzE0?=
 =?utf-8?B?S2IyLy9nVDJMa1hvYzJodUtHbjVYdDVabEYyd2JXNXhJNzFvUjFLZWhSK0di?=
 =?utf-8?B?UklDZWFwSUNXbUluVnBiOVBiNDRBbzQyS1BjYVpUUFA3NU9FbkRPbFZ2STd0?=
 =?utf-8?B?YUcrdlVDU0hWdWh3UzlCMFlPTUQvRWJMVTZMMXNWTTN0UE5VdzlUeE16NnIy?=
 =?utf-8?B?QW1CWGVMZ3lodWU3Zk1vTUJ2YkwvVjdzY25ES3NPNFh0VVpsajFyUllLREc4?=
 =?utf-8?B?VXgrcjZBalY2UlVEUVhlS2VrMmJMa21sa2diOVltL2ZzdkZYL2RJZi8xWXVh?=
 =?utf-8?B?NW9tMGw1K2ZNRFlCanRsby84QnQvdHhKRERiblYwMlFsQWhERTFSM0hGQ1lh?=
 =?utf-8?B?ZjRXd1hYVFlxR3NxU2VwejVFRVk5N3o0YzZYQ2dMbTFQSjRWVE5PL1laUWxF?=
 =?utf-8?B?NGl2c3I3M05MWndScWZGclR3M3pVU2hnVUFRWGd4UFErQlZOanBmZUc4cmtK?=
 =?utf-8?Q?Ah7c=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 19:10:00.5996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d62f94-c65d-41be-7779-08de3368b900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146

On 12/3/2025 8:21 PM, Dan Williams wrote:
> In all cases the device that created the 'struct cxl_dev_state' instance is
> also the device to host the devm cleanup of devm_cxl_add_memdev(). This
> simplifies the function prototype, and limits a degree of freedom of the
> API.
> 
> Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

