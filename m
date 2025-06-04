Return-Path: <linux-pci+bounces-29005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E8ACE627
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 23:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1127C3A8A32
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 21:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A91121885A;
	Wed,  4 Jun 2025 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DDiElLie"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F64221F38;
	Wed,  4 Jun 2025 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072612; cv=fail; b=mPdF9d2DAwwbXjXAOfDfa1qSXwMWDVuUYTSuMhmMVhB0GSIA3JQzpJJFk+rnriL7LIwPYQmBptmSFq3Y5aQKgjNil9bCGPJKmVeWgKijNwFEfdVIHf8Ba0Q++miNzX0CdOtHTsCEJS2QQ8ZR09UT5n6L32RwbuVlkEJaVlZpKo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072612; c=relaxed/simple;
	bh=BuqPGj5+684djJPJD++4yI2bE/KxHWmx+ZvtXN2bdK4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rO1tTn+7urvKZILD17hRqLnlGHWC86iPVgvihHJr5QMKIOW89ZzlvYAHBZgwBm0jJRPoaJh/QLLPDnPEq/kCTxxioZ0rZ4GEEJRI7Lw5gnxD9w+gsKpjsamjKhKOhRzg9mji5NRAus7Ij9ShPu4Lk3H7La8NyXUkpbX16qb/4qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DDiElLie; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymmaBCC/qJkVUE7ru6XVW2Mwb0nhlW3ZDTKe3lC0G6h0c45YqQJAeL6wusLcc6JsL/OvkTRVaUUL1b1G2XUHxvp16i4ALrS0ELBo2VAnBDuedo3JBMEa38diFA0jxR8lXhwTT8tpuGpHueEWpcVtHqfuurPyxFNAGJ8TZA4KzIgO4nYOPdBs5LBdDlVVppI4W6N67/bt7Nn4AsgnG/lzChoN+QRovwEme5XLoAVtIEHyCvuzrtH6cxD87Yso1qW1vmUduqLtVaKdK+BFmZBT1s8Tsa9gvZt0rvUhryvDmLhskD5BWEpSzG87VM28Si05Kt0W7+BBmdITEJetG5dLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrhJUILrl3WBxuSbluHn8DHtIWpr1PLimBykJctHK48=;
 b=CIgluE6kwxIRWCg9MxWlFPQQtA2h2sweZqv47ySAmCzLhW/+H3VUTJBT8/6xXNSllAKk7CuiaAb2dXmjsYqC+XJdRBDhfobg3dYj3S3nze3OD/52gVzz8bDEouSCRJ+plj0FELQGJFwnry3Ep5reH1gMJcKNL3D7Br3BBGhExIyLQNQbewIqkWmKpQx50rT3zMS7O3cLkSshDGSyEMfX2pfbcGU/dci+K17bCEyXL8o2XsOXKVhUrojG0tSRTMjFH+3pnmsY+yBmTJOtR+BP1kmFSbuDTLV4UWrJIRGf+ghG75ALPqW1Empt2V4MEkVju1zt67aehuYZm7airEKX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrhJUILrl3WBxuSbluHn8DHtIWpr1PLimBykJctHK48=;
 b=DDiElLie67FyErce/XkautnRRphISioJv+oUihsrC/jEtlx5vIWimX8iu0KkHbtx1pxeFpxj0ASUmXhS+ZaHMbkrAimRgzcuNwOOGWb0Jr65TMDW8PijZHY+2fiF0HQQExpwruDInZwubC27Opmhp/D8K/YCKCj9vLQAcumUogg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 21:30:05 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 21:30:05 +0000
Message-ID: <c4f88c14-293a-4fd7-8a65-03ee3cfec93e@amd.com>
Date: Wed, 4 Jun 2025 16:30:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/16] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-3-terry.bowman@amd.com>
 <0619c83f-84d9-4dcd-866d-d6df1da4d1c9@linux.intel.com>
 <7d9030bf-8d27-4c9e-b995-89ce1a63dd6c@amd.com>
 <1222c005-9d0c-4f02-a1d6-02c14b61673b@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <1222c005-9d0c-4f02-a1d6-02c14b61673b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:805:66::17) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: df37360d-8a43-4b2e-f059-08dda3aef8a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2tYTmlPT2lkUnlIclJ3UzlyYTlHK2o5N3ZZM3RPejI5T3N4bGpNSTc2bDNw?=
 =?utf-8?B?NVFSbEwvSHBJM01OUGl3U3VKUk5iN2VJaExRNUEyM0FnMEV6ZnF6MmpRZlkw?=
 =?utf-8?B?THllMGMrakgyakJ0MjdBTEU2cUtlR0M2VEwrcWZxbURYOEdOMzBodkEvaTlP?=
 =?utf-8?B?dUxBdU5xV3NYM1dpeHA3ZVdwbm0vRDNONUxwdkpBM3pEUjZ1dUR2SHlvUGRK?=
 =?utf-8?B?TmVKV01tdlI5ODg2WG1sWVo1RkR2OVdUcXhHK3VzYWgrWmhIWmdmakU3K1lI?=
 =?utf-8?B?MzFxUDc2NUR3bjdYbG9ScU1JUE1vTFZ6cmRWQ3dEYTJncGc2V3NVV2tlQTE0?=
 =?utf-8?B?VExleERBcXZrYlY4OGxsSTlzd1NBekhhWGk2UE5UTEt6K1hTMnRkZ2JwRGdJ?=
 =?utf-8?B?bWtIRXgvYTA5SDFQd0dMcExOV1d6amwrTUVtVkRRdVZ5bE1OMDRjL3Mrc0JO?=
 =?utf-8?B?Ymt6QTRqVSs5cDFNam9XWmNOOXY5aysyZGRnT2dNOHJBbGhmMjlPQzI5NHpG?=
 =?utf-8?B?RExJM0F0Z3p3NHRSQjhESUtVRy91bmowNkRTNFlXOW1pM0czRUZPdFBwZTBK?=
 =?utf-8?B?WW15MFRzaW0zVENaMzhId1p5d00xUFpOYWtoL3FQa1R2YzFST0JIMUhFQ0gy?=
 =?utf-8?B?UEhlRGdHWjUzZlYrV0pIbHVpZmVLT3BJWHZ1Ukd5QWhrOXlVTWM1MWZwQlBO?=
 =?utf-8?B?dFhMQkpvRFZrUURtZEM4R1JOaWlkWW9LVks4Q3ZGb0RFMmYvamZTUWlNdk9q?=
 =?utf-8?B?UGg5QURFNGtLQXdkWmlpOXcweFdrUDEycmtVdTIvV1NDU05ZUldmdHdscEZ6?=
 =?utf-8?B?QlUzM2hsekI3YWl1ZkJYeWc0VHNwZEdQM3duNjVVL1pSbHdPdFBMK3BhdjBa?=
 =?utf-8?B?b094ZEdqSXN2S25OVzlMS0g5MkZOWmVIZVcvaGF5UG14UEswSzY4bmJMZG1v?=
 =?utf-8?B?aHhXY09UZ05OMHZQb0JQckd1ZkFldm51SWZIakxZcVhaUTNEcVg3bGp3ZEJT?=
 =?utf-8?B?dzBWQmFPckI5azYzeElmVkxXMWtMaGRwQ0JOQ2NxakN1bURDdUNFQmx0TWRK?=
 =?utf-8?B?M2srbytyVE5XR1U5KzI3dGMxUTZ6cEw0ZkhMWmNQMHdneHZRNU1zTVB1ZGFJ?=
 =?utf-8?B?czNHd2RBcmpYWXF0SHo4UlNpaEFndkowZ3NHNzJ0OTl1SDFTWHV1N1oxMGdu?=
 =?utf-8?B?ZnZGRjhLV2s5WmoraVRSN3EzRjFEeURvR0NBK3g4YmRzczlNRWhXMTVBN3BL?=
 =?utf-8?B?TGJJVER5U0ZhMWZmQ1VidU9TeElMZHBJSkF0aytJMzVlTE9aVnArV2N6TVJR?=
 =?utf-8?B?U2IxRDFZTW1aZVhFUGFMZDBuUkVqUlA3Q1Z4bG5BYnpOd2xNWmtaK0JoYVBy?=
 =?utf-8?B?RFdyTVYwT0o2ay8yK2ZkdWxHTFVvV2dYUVp5TkhVTzQxZVV4MTZUWTF4M3Bz?=
 =?utf-8?B?WVo0blBCeENmQWlTMUZJMk1JTEJBaExBbzlqNDd4YTdZaC82Y2ZMMjE2N1ov?=
 =?utf-8?B?RzVob2ozTWo1a0U0VzVMUS9BSk1uMjkrZXZYQzlEZzd5aWswYm1qVlhXWFRp?=
 =?utf-8?B?bFRPWEE5QS92dU9YRGZ1S0YzSUdVR3NTRi9kQ1NMZEFZZzgrTmlGdFI2Rk90?=
 =?utf-8?B?QjhJVWphQWtkaUdHZUVQZ2lGVVdNSWphZ1YxMCs2RS9FcEMyaGZydzFwUUFw?=
 =?utf-8?B?NkI5RGRBcjRUQ1ZuZkkwTTFRUmxFSjVvcWRuMW9vMms1bHFpRUNpRjNwNExQ?=
 =?utf-8?B?QWVvRGFEbkczbzBmVEorcnU5RzZNWEdNeWdYQUF0SHhUUVJNd2xUNFBsT3JS?=
 =?utf-8?B?TzlHZzFQam9YOUJVUUIrOW02UUFuM2VCRkxhdEF4ZWNTYWxIek81WjE2dXgv?=
 =?utf-8?B?WS9SOXFhOE5SRElVRmpqVlVWQm1GSDZXc01uM2pZSUVoc3NOcUp1R2lHRjE0?=
 =?utf-8?B?a1BoTWxBak5iTjFnbjM0L1RaVzFDaTZ5MTNSWjc1eWdoSFU0NW1qMXExSXBs?=
 =?utf-8?B?MTN6M2JSdXd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFo1V3g2dTNBemRBZUhqU3ZybStkUXZFc2k3TE1yQ0RqcTl4TCsvVVVaTGhj?=
 =?utf-8?B?MThxd296V0ZJZU91OXlhMTgzN0xRRnYxR2grZ254QWhZdnRwSnpMWXpvbTlM?=
 =?utf-8?B?VmFZUjhTeUdTc3dUajg1Zm5pcEdDUmg4Vlo0Z3Y5cEp3T0dvMzVOcWVVMmlr?=
 =?utf-8?B?SlRobU5YRGczWjQydjNVSzI5cS9GaXBtdkRmZ3RnOHNZeDhoSXRLOTI1RWNO?=
 =?utf-8?B?RVBFTlY3RzQxc296cFhkbWlvNGZ0dnQyNDd1U3poU0FSU0YxMHZaRVZuYnph?=
 =?utf-8?B?dGo4aC94OVc2YmQyc1liZm42c0FsNUQ0clNBek1BN3NBVzI0UWhlUk4xVWdZ?=
 =?utf-8?B?OTVPbGdlM3VTUVNiblZvZXRod0JaYW5ESVhmSjZ6RVJwdW44TkRabnhWK3RP?=
 =?utf-8?B?cDdtb3N6K3UzUWI4MW1PN0s5M0E1cHhOUlk5bS9pRDhDVXdHQVNXb1BNbzcw?=
 =?utf-8?B?U2hjNDdpVXllQnlBNTNlbElTdEplcWMwd1JDVUEwVEo0SVdBaHpHUy9HZmVM?=
 =?utf-8?B?WC9aNHkvZnF3cmhseXpDSS9FbDhwbktLdlRvd2pBc29xL2Y3WjdOeFJWem4r?=
 =?utf-8?B?eGY0czVzcFBmSkc0TWY4YVI2ZE5VeVZyaFNDdmpNcDdta3dQeGxZZUdoeDVS?=
 =?utf-8?B?WUo3T2ozMXhrVkl0VCtWUXVSc1c4RlhveE9aclVZZHVzbmFEc2hmcXlqZm1E?=
 =?utf-8?B?c1BodUlKZ2pzNjV2MS93dmFaNjdVRms1QTdCYnJhZlJ5eEtVSXM3MGpUZGRG?=
 =?utf-8?B?eVBacGQ2Vi9hWldxdmNCK2IwblVpVkduckRhK2hlbDk5d2MwUTVPYTFBSzlk?=
 =?utf-8?B?WU1FZXBpbDVKc3JRbWZXb3VRZnppVHIyRml2aXd4UUtacU1xdlRkQThGMG1i?=
 =?utf-8?B?dGFHaDUxR3VTUzVtMDdYUGtXZlZ3TitqeGdTbGtRM0NwWXgxVFZoTkp4YzlL?=
 =?utf-8?B?cERMZjdoZlJ2cG1hZXdxeU05UGRhNjlKZUpYd0gwVklONGhTWS83eG5zV3Ey?=
 =?utf-8?B?RUhWWXVyZUZCaDBkNFdBbGFONXRha2JpS0IyY0ZNVEJaNm5ETHFyUUJRMmJX?=
 =?utf-8?B?L1R0Nm55U3Rna0tsUnFrZGpUdTQyTmkza2ZVSlhSMEtjTXZsVXRRbnZ1VFhk?=
 =?utf-8?B?bDVnL1JScGg3SThtS2RQTno5QUVyb0FxdnArVFdVQXl0Ukt3R3dlaFNhUGcx?=
 =?utf-8?B?VW5YU3NZUUtveWNxTGxXeWhKd1hIUEdsaXVHSkptR2k5c0p1c1RmeStGNWdj?=
 =?utf-8?B?WW5KdG41ZG5reTFxTXZ2d2xuWXpxQytGM2RhTXlvU2ZlbkRiR1dmaXZFK1Yy?=
 =?utf-8?B?THZqM0RvclkvWkNUMnB6VGNwL3RtMHJVZ0dIaTJUdmxzTlJDdW9meXJHMjRM?=
 =?utf-8?B?S1NLenQ2V0lrcC9zTmVTOXptY0xEVWExamxaMFRYZ0NBMlR0VGNhK2VrQUU4?=
 =?utf-8?B?QlcrY09nYlFjMVBhZWVUQkc0K2N3a0hxQmtQdlBkWk5QSTNHdS9HZHlyQVdJ?=
 =?utf-8?B?NDRKWG9aM0I2bFJ6dDFYVWMvRG9ZNlBIWnpkNVVjNVdBWGphQzlEcGFKMFdo?=
 =?utf-8?B?WTFHVlZBb2RaZlkyNVdFeGV2a2NNSE9tSzZlRkRKRkN3NDZBa01XeVYzV25X?=
 =?utf-8?B?anY2eVhhTHZUdjBkdTJXbWp0c0FhdUN0TzgzN1RoTW5qb1oyV0VLdEU5MzVW?=
 =?utf-8?B?NmpnVDZWQ1NzRDlwWTg5ZWFWSVVqR2lTZUU3VWFJYi9uMGMrc3JRS1U0bmc1?=
 =?utf-8?B?MExWZHNUSzRtKzU1dlBPWVVzMWVkbFpFNkZOeElNdDdaWWJqMzhtYndyY1Qw?=
 =?utf-8?B?ZHJNekFOUFl4RTBTN2dOUElOOEZKOEJLWUVLVHRQa0cxZE5zWkpMZDV6RDk3?=
 =?utf-8?B?VjAyc2ZkeWczUjI1QXlLNEkxMWt0bXpaS0M1SnZlWkJTL3NWZEJhZGZSQ1B5?=
 =?utf-8?B?b1ErTklod1Y0a3dCbFoydnRERHhVbC9Fa09JMk05QllybUFnUFFRaHUyaEZU?=
 =?utf-8?B?UDdqK0VJZFl3QlBQM210L1UrZTNFS2RQNEowTXRmaXFIWDF6ZHJrT2lnWXo3?=
 =?utf-8?B?bWJiNW5vczNZSnJkWGJLT2lHY3pvRzRmREkzZk1pRUxpdjY0REZZVUFCdk1t?=
 =?utf-8?Q?0kuK0BnfhhWiJnx5g0i0MG0V3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df37360d-8a43-4b2e-f059-08dda3aef8a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 21:30:04.9575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGcDGBJDxc48e0fumzSyV8Do5VJ6VMWpAzsNxN0wrNpisTbsxJrz59jKT96MIRZ03gCFJCGo7s96EUe+tKFM1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

On 6/4/2025 2:24 PM, Sathyanarayanan Kuppuswamy wrote:
> 
> On 6/4/25 7:32 AM, Bowman, Terry wrote:
>>
>> On 6/3/2025 5:02 PM, Sathyanarayanan Kuppuswamy wrote:
>>> On 6/3/25 10:22 AM, Terry Bowman wrote:
>>>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>>>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>>>> Type' for CXL device errors.
>>>>
>>>> This requires the AER can identify and distinguish between PCIe errors and
>>>> CXL errors.
>>>>
>>>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>>>> aer_get_device_error_info() and pci_print_aer().
>>>>
>>>> Update the aer_event trace routine to accept a bus type string parameter.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>>>> ---
>>>>    drivers/pci/pci.h       |  6 ++++++
>>>>    drivers/pci/pcie/aer.c  | 18 ++++++++++++------
>>>>    include/ras/ras_event.h |  9 ++++++---
>>>>    3 files changed, 24 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index b81e99cd4b62..d6296500b004 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>>>>    struct aer_err_info {
>>>>    	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>>>>    	int error_dev_num;
>>>> +	bool is_cxl;
>>> Do you really need this member ? Why not just use pcie_is_cxl() in aer_err_bus()?
>> This was added per Dan's request instead of using pcie_is_cxl().[1]
>>
>> [1] https://lore.kernel.org/linux-cxl/67abe1903a8ed_2d1e2942f@dwillia2-xfh.jf.intel.com.notmuch/
>>
>> -Terry
> 
> It looks like it is added to accommodate some future use cases. May be add some info about it in the aer_err_info struct. Just looking at the code, that member value mirrors pci_dev->is_cxl and where ever you read info->cxl, you can also read the value from pci_dev->is_cxl.

Right. pci_dev::is_cxl is currently only updated at device creation but could be tied 
to alternate protocol training and link status changes.

Terry

>>>>    
>>>>    	unsigned int id:16;
>>>>    
>>>> @@ -604,6 +605,11 @@ struct aer_err_info {
>>>>    	struct pcie_tlp_log tlp;	/* TLP Header */
>>>>    };
>>>>    
>>>> +static inline const char *aer_err_bus(struct aer_err_info *info)
>>>> +{
>>>> +	return info->is_cxl ? "CXL" : "PCIe";
>>>> +}
>>>> +
>>>>    int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>>>>    void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>>>>    
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index a1cf8c7ef628..adb4b1123b9b 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -698,13 +698,14 @@ static void __aer_print_error(struct pci_dev *dev,
>>>>    
>>>>    void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>    {
>>>> +	const char *bus_type = aer_err_bus(info);
>>>>    	int layer, agent;
>>>>    	int id = pci_dev_id(dev);
>>>>    	const char *level;
>>>>    
>>>>    	if (!info->status) {
>>>> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>>>> -			aer_error_severity_string[info->severity]);
>>>> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>>>> +			bus_type, aer_error_severity_string[info->severity]);
>>>>    		goto out;
>>>>    	}
>>>>    
>>>> @@ -713,8 +714,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>    
>>>>    	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>>>>    
>>>> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>>>> -		   aer_error_severity_string[info->severity],
>>>> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
>>>> +		   bus_type, aer_error_severity_string[info->severity],
>>>>    		   aer_error_layer[layer], aer_agent_string[agent]);
>>>>    
>>>>    	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>>>> @@ -729,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>    	if (info->id && info->error_dev_num > 1 && info->id == id)
>>>>    		pci_err(dev, "  Error of this Agent is reported first\n");
>>>>    
>>>> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
>>>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>>>>    			info->severity, info->tlp_header_valid, &info->tlp);
>>>>    }
>>>>    
>>>> @@ -763,6 +764,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>>>>    void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>>    		   struct aer_capability_regs *aer)
>>>>    {
>>>> +	const char *bus_type;
>>>>    	int layer, agent, tlp_header_valid = 0;
>>>>    	u32 status, mask;
>>>>    	struct aer_err_info info;
>>>> @@ -784,6 +786,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>>    	info.status = status;
>>>>    	info.mask = mask;
>>>>    	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>>>> +	info.is_cxl = pcie_is_cxl(dev);
>>>> +
>>>> +	bus_type = aer_err_bus(&info);
>>>>    
>>>>    	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>>>>    	__aer_print_error(dev, &info);
>>>> @@ -797,7 +802,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>>    	if (tlp_header_valid)
>>>>    		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>>>>    
>>>> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
>>>> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>>>>    			aer_severity, tlp_header_valid, &aer->header_log);
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>>>> @@ -1215,6 +1220,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>>>    	/* Must reset in this function */
>>>>    	info->status = 0;
>>>>    	info->tlp_header_valid = 0;
>>>> +	info->is_cxl = pcie_is_cxl(dev);
>>>>    
>>>>    	/* The device might not support AER */
>>>>    	if (!aer)
>>>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>>>> index 14c9f943d53f..080829d59c36 100644
>>>> --- a/include/ras/ras_event.h
>>>> +++ b/include/ras/ras_event.h
>>>> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>>>>    
>>>>    TRACE_EVENT(aer_event,
>>>>    	TP_PROTO(const char *dev_name,
>>>> +		 const char *bus_type,
>>>>    		 const u32 status,
>>>>    		 const u8 severity,
>>>>    		 const u8 tlp_header_valid,
>>>>    		 struct pcie_tlp_log *tlp),
>>>>    
>>>> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
>>>> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>>>>    
>>>>    	TP_STRUCT__entry(
>>>>    		__string(	dev_name,	dev_name	)
>>>> +		__string(	bus_type,	bus_type	)
>>>>    		__field(	u32,		status		)
>>>>    		__field(	u8,		severity	)
>>>>    		__field(	u8, 		tlp_header_valid)
>>>> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>>>>    
>>>>    	TP_fast_assign(
>>>>    		__assign_str(dev_name);
>>>> +		__assign_str(bus_type);
>>>>    		__entry->status		= status;
>>>>    		__entry->severity	= severity;
>>>>    		__entry->tlp_header_valid = tlp_header_valid;
>>>> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>>>>    		}
>>>>    	),
>>>>    
>>>> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
>>>> -		__get_str(dev_name),
>>>> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
>>>> +		__get_str(dev_name), __get_str(bus_type),
>>>>    		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>>>>    			__entry->severity == AER_FATAL ?
>>>>    			"Fatal" : "Uncorrected, non-fatal",
>>


