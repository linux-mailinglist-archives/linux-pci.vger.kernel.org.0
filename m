Return-Path: <linux-pci+bounces-13475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6898519A
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 05:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1BA1F21EC1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD12139579;
	Wed, 25 Sep 2024 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sA953Axy"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470EC20E6;
	Wed, 25 Sep 2024 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235997; cv=fail; b=Y4DGy2mW891c0BVNkYwvD4Ri9SwFI0FIesKydW8vNN7GS1laiPKswqq7dLi8e8ukctqSoxpMq9FVMRwTbfCCU7xYGpW2drR3LuSFzmICpxzcgNLRv8yp5WsQn2X9bzXv7djmqu/+zZO3/sV4rbQaubZI07Y/s7/ZuOY8z1WGIMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235997; c=relaxed/simple;
	bh=kGlLw5/QR5OG/tSplVm2z7O6eZ1S+E+iZIY0uutieac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hBi5OColCxIW0FBFmdXmsSnHyea9EMg/gfG8XjA/RZ36ZsmyDIplE5ZspAp8wyJKTTmmj9GJVv1GSJgfVSsgPkgzhK7Y/kAqTIC4KkKD6uKHSvY2sfG9MJclVi3V53NauDIhvtBY0VyevvxdWGH1PfnrtRZkX0fQmnH+Y/MOyMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sA953Axy; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIZkR8Oy6XAN7s4qpeEtxV9xbvCOozvZiPjovZInhnCacDJRc//t//W74QMRLPlHkUxAt5C3KiloPq7u7OI5KQRYY5n7G2ZZiaBveWhso0wVtvaeKqr3D2tlVZrRxGPR6pcujqGLnPHzu8aHorNCfMAuyLBdRxOLyayZle1BtGXP53QKG3UpR6pKovbXQflXs+iB4wUQ929cjVTSLzjTh/EYsWJDBPYCfpRASmXXvzd+IiBeqiMcWP6oulNPRF9e2wxSHcX0SJs3ED3DoYTi3AbekFHJFxprn8gZNi/JnDZcLutXeIQbmzcdnRpopFyYl3170mMuWuXON+7zhsU9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQj1pGfozrTplRV5PiFWVWUP0aJogvAz67p69hO60aI=;
 b=d0YGUYBAqYo0Bc2qXglASy/fAPaOkCLLaLniNAIenDgpQYbvI29V8I240Q67VC03e/dQ+TNXvPGXv6fRWq0Di0xDV9v+km9OM8ll8dDTPgKF4TwzO5iRGczfIKcCTF1rDxT6AMFy9KgktDz58KOCP0Ayt3y+A9tcGHRb0i9euv92IqmmgLjHnBBrkkJ20ojAU3fx9bvJUqfdESx4ncMNexzGY4LAZxqng5RGHQl2u89z6IcMvFHyMAESszG9gA36/V+q6zfRd0S456q2UZGwdaiFCB1yAznYdn0QgGols8we0xkxObwpuwo79ULOYjDbE7YA0jeJH0WJ6GDc3cGb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQj1pGfozrTplRV5PiFWVWUP0aJogvAz67p69hO60aI=;
 b=sA953AxyEBByg/SuZoB2H4VWh85vyRcnNSNYSv4IMACN4+AlGUzw2Xd/BmhVogEAxipIn4xvLd7vElN67Z6tLssAUSLgSrYoyUH8ys9tCquO4KSth9uidxhQQVhp1CzTImeNjqX6PDdSKFnH6jpRqJ9vmW9BZR+JJ2ynupxFXtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Wed, 25 Sep
 2024 03:46:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 03:46:33 +0000
Message-ID: <5012908a-9ece-4c16-9d01-2633df740fbb@amd.com>
Date: Tue, 24 Sep 2024 22:46:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: unexptect ACPI GPE wakeup on Lenovo platforms
To: Baochen Qiang <quic_bqiang@quicinc.com>, rafael@kernel.org,
 mika.westerberg@linux.intel.com, ulf.hansson@linaro.org,
 bhelgaas@google.com, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
 mpearson@lenovo.com, markpearson@lenovo.com, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <370d023e-ec53-4bf2-a005-48524c9cb4b2@quicinc.com>
 <79d288c6-6042-4f73-b465-0ddcde14509a@amd.com>
 <b51c89f0-035a-4e94-adc3-e1b4fc31dfdd@quicinc.com>
 <91e179ca-ff2e-48b0-813d-7b819e300dca@amd.com>
 <115efc10-60fd-436f-99b6-0b141f9585e7@quicinc.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <115efc10-60fd-436f-99b6-0b141f9585e7@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0120.namprd05.prod.outlook.com
 (2603:10b6:803:42::37) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb7de83-ae3a-496c-a28c-08dcdd14a5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXEyay92TmZqbTNlTjFHMnRYK0lEeUg0SlI3K0gzRHdDVloweWppQmtEZ0J5?=
 =?utf-8?B?Sll6d0FDVTJpYWx0Z1R5cXNwclprQXBsNzdOMjJtOFd4d1UvR1BQS3RYdlRB?=
 =?utf-8?B?NFJabGJaNmdob1g1ZjdXSnJWWUt5a0FLZDlhYjdBR3h1OGlYeStEV3BhbWxz?=
 =?utf-8?B?UlJOQ3FUNkc1WEc4aXJZVFg5Mk10Nk9KNFROcjJHU1lGZU1VdnhjYStxZHJj?=
 =?utf-8?B?R2tHSDMvMzZZVXpHYVM4NS9lZXhxMjN2L2tGUW1zaGV2ZWRJVEV4QVF3Vm8x?=
 =?utf-8?B?dDFNQ0U4dmMwOTAwdndZV2M5QzE5UTV4WkdmMmk4alNJQ1djaVlYYjNhaHVP?=
 =?utf-8?B?U0xyM1ExcnlweXN6cUE2eGRBMmJLRmgwL1Y0dXBKQU5nNUtwSCtmUk9iaTFQ?=
 =?utf-8?B?ZGJJSWNBbXhiL2p3Q3RDQmh3cXNMYmNDU3lGOXg2V013ZlZyRi9pRVZXM2NE?=
 =?utf-8?B?SktuN3g1bUpSaTk0MmtSbDVNbGs5eStSQ0s2bHZFUUV5OFZsTzFnOWJacDZv?=
 =?utf-8?B?eVFyWUxhemdGNzl4Z0c2OU5zMkZEbzBpOEwwZXlucXlxYTMwODVjdFd5dlhJ?=
 =?utf-8?B?UEw4TlY2Z3NEWDJFYllIOUV5akpjdzgvdVFNeGMzMnFEUTIyd0VEUFI2a0F1?=
 =?utf-8?B?QUVDMHl6TzdNSkgxVGM3ZExHSDg3eE91WFNqMlNScmlhakdmcjQ4dXJxQVR5?=
 =?utf-8?B?NVJlN2Eybms2VXVOZVJjYVJYZmdFb1U0Vm1kSTA3VFh6TUNuN1FWNWExelli?=
 =?utf-8?B?TmJOOHFJMVQ4Nmxpbi80bUVRWllDRHY1eW54NXpXdjk4VHdsMjVMVVRjcVEr?=
 =?utf-8?B?RG01ei92T2VWVXNrTXZRSWpmRTFKaVpsWlo3dEY0TXREdVVwdnZHTGRuV1cy?=
 =?utf-8?B?VlJUbVQzTHFXUnpGRS9ZUXBkZTJvb3A0VXNFWmgyaVJtYTVqU09CMkpVVUlj?=
 =?utf-8?B?K3Fmd2cvMWExaHNCRUYwczRvb2ZMN2NoUFpFY3pmZHoyeTY3RzNCemNhZi9F?=
 =?utf-8?B?SGNlWVFYMXV5WHlPNStpZFBZTGRDa01LNHFkUTRTejQ3RUtZcHBmVWFEMzJp?=
 =?utf-8?B?b3pDSVhubEVXcTFxc05vRlBiRHdHK0ZoRHh2NGZuVUNZMzBJOHQ2Nm5rVmJu?=
 =?utf-8?B?c0dFc00xZlh0OHMyOXBpbzF4aERENmhzTzFMb1RHYXlYMU5IcUxwYmQ3T3Fo?=
 =?utf-8?B?QjdGMDQ3SlQzZnQydWgrQTdIRThtNDdnc1U3MEtzMkxHSVR3dzk5eUZUeE1F?=
 =?utf-8?B?MzJEdFFqUlNwdmpmeGg1N215Q1ZFQlp6dHdpTUlpWUlja1RnM29kaUtMZmMy?=
 =?utf-8?B?RXk0dVlCTzNmRk4wdExEVlZmZ0pxVmpjOVVqMlkvcmw0VVg2bW15QlBZYTJ2?=
 =?utf-8?B?cGtqYWE0dWFhb2xuUmxuK2xRUU9oQ1RpeFpyWnNnK0x2UUxyakVlY3dwblk0?=
 =?utf-8?B?WWJXZlp2ZWFSUE5OZmVXMmNyb3hSbmFpV21lOTB2K3pxYTdsT1ZlME1qcjJj?=
 =?utf-8?B?NU9RSlRPWUUzalFQNnlrZjhjRDQyOStmRE4zU3N2dS9YYVA3NDE5OEkwOGJW?=
 =?utf-8?B?NnB3cXNUNCt5VWdjNkRxaUZWVG5KQ01EMHpNMXFxcGFyOFg3WEE0WWY5V2p4?=
 =?utf-8?B?bFFtM1hCNjErR2s4cXliWUdVODlKdUhhUWJKMkhqWWdid3JOanBWZU1xVWRy?=
 =?utf-8?B?T3lET3M0Q3VSY05QaTNVSGtCQUxKZGo5Z2ZTYjlxdWdFdkxYbTBWbjJxRXVN?=
 =?utf-8?B?YUw4d3lveVF6Z2pJNndPQ3FuOEZKYnZlN0hGd1A0NFhiUUplbmJpK0FOOEVt?=
 =?utf-8?B?SzlpU2tOSFlUMEc2Qlg5Q3dHVlRzdDVuZGlBWXV2a2lIUjE1WEdDNVNLcE12?=
 =?utf-8?B?ckJDQjU3amRkcjBVajV4TWJ0UDRrRHV2QU1wTTdKSGtqTEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1hiQWhzQzhyN2hGU1JQeDI1QVpLQTB0VHp2ZTZHZlB3OWI0dnFNbmpvcUdZ?=
 =?utf-8?B?YlZBQVl2eitJNi9Ic21pTitvV2FhN1FuK0JRMzZ5cHphTkQxTG9HeFpSTDdW?=
 =?utf-8?B?U0RxOGZYZlRzelVMcXhXZDBZeWx1WVdaMDRoMERQY0YxeDVtZHRpa1VnWmhD?=
 =?utf-8?B?TFI2WGpqNHdEWlA3VUdyamlVKzRoN0o2b05DYllYNFgzZWw0VUpldzVHNmE4?=
 =?utf-8?B?ZDI3ZCsyV1pBZmxuN0hJSDFBakVlY05tMTdORGdwV3RCWGRROHkrQmwyKzlL?=
 =?utf-8?B?Q0ZFVll1dmFLa0IrMCtSdzBkWkM0ek92ZFhFTTdhS0x4WU5UUFJ0WVh3N2NW?=
 =?utf-8?B?VnRSc2FDeFBhdEZTOVhJMVc0cVcwVis3VnQrTnlCOGVHY1pXcitvOVVCL2VI?=
 =?utf-8?B?VmsrYWxvaExGbXF2VWZCVVg4VXlzZXBtT1lJUHJmZXFGZDAwSEZ4QWs4akFi?=
 =?utf-8?B?YTNDejdNTVlGVGxtcUpvWUdaNEdmeG0vVC9IR0hEM2Rwek55bERxYVBLbWpX?=
 =?utf-8?B?Ym51WDZFSytsVHJYdXorOFlCTTVYL3FBRFE1WFJyMi9RNUg1bzVLZzRuOFBO?=
 =?utf-8?B?MlJ6VE9BU2xHMENpWWo4RVk4VXpBR1RTMXJCVXBvMTV3bUNhUitleVcxWUhK?=
 =?utf-8?B?cGJkdHdwVzA5OEZ3NWZJdEZETm03VGI4M1d6K2dmMzZkOHhubTNyS0dQdG56?=
 =?utf-8?B?WGhaM3pBMy84eVFoK0o0SFNzZWdXd3krWWJqUVZYaU54eGpLd3E4RkJFdk56?=
 =?utf-8?B?SGh1ZG4rSDZlckZ2VGxzbjJIazlqNGo0alhkdjZOR2tvVENSRkpBajUzYmRp?=
 =?utf-8?B?K01xaGpyelpsbEdyY25rUjFJUnF6KzJSS0dqeXE0RjZBOTJJWjZzcDZnYnZY?=
 =?utf-8?B?WkxnRGpDVkF5bXZiVkpLU2xva09GZkU4RWRVSDNGYUEvdU9Gcml0c2lIUXN5?=
 =?utf-8?B?czY3czBleGpXbTJxWHdkZmdQVVhMK2FPeDB4NzVoaVhUaU1jUEY4V3dLMktZ?=
 =?utf-8?B?a0FneXFXSFdHTU5WR2thU3J6U0svTFNJcHJwK3dKbWwvTmNsdVdoZUtkTXpj?=
 =?utf-8?B?MGJWc1lNTFI1eEZxNDBCa0FmbFJhcm5tMnBYUFRaWStkSUU4ZG9zNEtyNW1o?=
 =?utf-8?B?Vk55M3ZHeEJUWDB5emFISnRURG8ydjF4cHp5Wit1Q21YaXo4bEhEVTZGd3M2?=
 =?utf-8?B?ejRZS09FeHE2b0hlRkkxVHoxdVhKa05QRUxBb0Job3lhc0o3RzU5SVB1Y0dn?=
 =?utf-8?B?WGE3eU04SDR6Zy84UUFoMTNDT2hjQW15di9ORDhKM2c3WVM4T1VnOHIwK29k?=
 =?utf-8?B?a1VOeXFIdTB1S1o4ckJ6ejA5aXF3NUY4Qldpai9ZVlpOdUJMM3JJU2cvRE5D?=
 =?utf-8?B?TXEzZE9mOHlhK3ZwdmFwaFZkUDhwdGNtQ0dBMDd6QXhTZFlEaEt5NzFsV3BK?=
 =?utf-8?B?VVRMTFFJMkJsZVphQUY2SHBldlA3dnJpcGdVaERJMXV2b05sV2VWWW9ZRFRh?=
 =?utf-8?B?ZjBZMzBIQ3A4NEhEUHhBSXpRSWV0N3loM0xxUXFJRFRxUzluVXowcVBiQ041?=
 =?utf-8?B?RHpaZ1k4b0wxaGM0YURzcnp4MUJJVlUzV0pKREh5MkZDbEZneitwTUZUaHpu?=
 =?utf-8?B?N1JIS3lHRWo4NDdqUityR29SZ1o3T3g2b2FJRHVObDNEZFJQd0ZJYkVYWSt5?=
 =?utf-8?B?MDlZQ3E1bUgwRG9xalo5VTFTQjZnekZiZC9ZaXpEbUpMWVJET1Z0eEozN3pK?=
 =?utf-8?B?SUtibHpjNGhDT1BKSVVIYW1VRDBRbnB0ZW41MDQrYkVPWC9XRGVpdFRWZDdm?=
 =?utf-8?B?TTBIUjNGdWF5VEdqdGs4aHd3dXFCdXZyamhzRTZtL3IvOHVOOUFmTU56Qmc4?=
 =?utf-8?B?TU9hclUreGx1TngxVzNkSUVwcVhEdUp1Ympja3dxakdrbnY0WDRKdldQNTNV?=
 =?utf-8?B?R2ZpSmxycUVWbnRYRzhhWXlVeXdFL1YvWTE4L0ZsTEx5WnJIVXVzbXZ4Zzlz?=
 =?utf-8?B?dzBXakhOWmNHOHZiWGNQZHlHZktOS0ErVHBBbWlsWlJ3cjYvVFd6UnJMN1U5?=
 =?utf-8?B?TGludVhKeUVNKzlZYk13QzFtQXg4RGowWTlBVHBpVGdRQmsvWnlKVXVWWE94?=
 =?utf-8?Q?6IbbJbN3ptvHRWk0PHGY+QvQz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb7de83-ae3a-496c-a28c-08dcdd14a5f6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 03:46:33.4583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuPHe/0C5+R9t0f4+XoRw8pK6w96kzdd1rU7Fy3lWF+yzE2pOMbkcTS0+A9Tp5oqvhRYkCtVk7s9lyuykCUyyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300

On 9/24/2024 21:18, Baochen Qiang wrote:
>>
>> Yeah that's what it looks like to me too.  The easiest way to confirm this (without a schematic that is) is to look at the _AEI / _EVT in the SSDT and see what is notified when this is active.
> seems GPP6 is notified, does this mean GPIO18 is NOT bound to WLAN wakeup pin? but instead it is bound to the PCIe root port?

There is a concept in AMD machines called "GPIO mirroring" where the 
status of a GPIO pin is mirrored into a GPE.

Particularly GPE 0xE is often mirroring AMD GPIO 18.  This can be 
changed by BIOS though, so Lenovo would have to confirm it is the case 
or not.

But it could explain why you see GPE active.


>>
>>> [  899.306089] ACPI: GPE event 0x0e //GPE 0x0e triggered for the 2nd time
>>> [  899.333158] ath11k_pci 0000:03:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>> [  899.333190] ath11k_pci 0000:03:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>> ...
>>> [  899.826378] PM: suspend exit
>>>
>>>
>>> But I don;t think it is the wakeup source, it is just toggled during WLAN reinitialize AFTER system wakeup. actually even with ath11k module removed I can also see this GPE wakeup, but without GPIO 18 toggled:
>>
>> I don't believe that just removing the kernel module is enough.  Can you physically remove the hardware?
> not possible, it is soldered, not a M.2 module

Ah this makes it a lot harder for a debugging.  Is there option in BIOS 
to disable it?

>>
>>>
>>> [ 2640.849342] PM: suspend entry (s2idle)
>>> ...
>>> [ 2650.806234] PM: Triggering wakeup from IRQ 9
>>> ...
>>> [ 2651.467653] PM: noirq resume of devices complete after 558.943 msecs
>>> [ 2651.467880] ACPI: GPE event 0x07
>>> [ 2651.467961] ACPI: GPE event 0x0e
>>> ...
>>> [ 2651.848848] PM: suspend exit
>>>
>>>
>>>
>>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219286
>>>
>>
>> Is it possible for you to put a scope on the GPIO and/or PCIe analzyer on the bus?
> it is hard to me -- for the GPIO I need the schematic which is not available, and for the PCIe analyzer we need hardware rework for that, but I will try.

At least from WLAN perspective, it should be well known pin for GPIO 
even without board schematic, right?  So should be relatively easy to 
look at with a scope.

> 
>>
>> It sounds to me that most likely what's going on is PME being asserted from WLAN controller.
> But I don;t see a PME interrupt fired on the root port:

Hmm.  I think then understanding what is happening to that GPIO over 
this suspend cycle when and how that maps to your expectations from the 
driver and firmware will be key.



