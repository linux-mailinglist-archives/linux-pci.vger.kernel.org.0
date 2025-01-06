Return-Path: <linux-pci+bounces-19355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F6A0317B
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 21:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B712D18865FF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 20:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B451E0480;
	Mon,  6 Jan 2025 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mDRrAdI1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925901E00A0;
	Mon,  6 Jan 2025 20:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195656; cv=fail; b=d3Db8AY/Pk+IVy83Fz4UatFxIGK2KU8BCxWMUOvQt5mAEWb3Ft43gYqALjYtUgGGL/k4oYKRCmK65+Y654CDyG4FyYuzzVFrqMHyvnnDXYW9XsRE74Vb4nMq1vpktHaS337Xuvp/ena0+pZzd6XZFAPCtZfc3vKm4cKPWRwDtr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195656; c=relaxed/simple;
	bh=mDUfdCk94KrqwbbQ1SXI5UNFnIlTE6cyphA+33KQeWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=reaZTWrFN56fLHlF5/5GyQnmFiWDVXfNIhfb33pMjbpme5+bu/QTOBhDiUDnEezNL3beqM1PGcxagOLmALB3XTPH4paIoiX4bqpV4p2oUDOgHx0CguklhU1rc2TyDGsQ3UqMFDblDeRSzWPWUKsuBwz7J9HQhIwcfbJ7PN9yuN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mDRrAdI1; arc=fail smtp.client-ip=40.107.100.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KygKuGsfdS47NGdO+yGbqYgqTRcjjt49kgAhgyIwiW7lY8GVV2h48JU/loECtBzaXeHU6w1jpwiKi1+xPqTiz2E3CRuewFXdYrYO1iBsP1BsoYui4EBoloGVyBfPJMm3ysRcpKkAC/os7oxGyKUZgkn/ITn0aWsaekvSyGbn9F4l70AycUoc8PhRy82M7qbdR3YImjjBo5AmHAxSwfSuL1KPSinCQC4MYt+NKvQiIQl1YfPh+HD6dW5bhG/OPhmykU4+b8lAmTIjmTBgh+uPQUnYu4boW6ZI+RPrnXGKZd365cjJkyx8sYstW9WR5P5MNeWuHwRe24KEcD7HAUr/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sIj+byRtCnFEPcUnBNhaN0IBJBDqkAr9Fbih5cRP+Q=;
 b=vKyr3sR3XmZLtDA3iDFVNDjNsKlovt4ZtmmUNE+SoEl1EDtvoZ07M1a2ddHlzxdUy2BfBVItgW5F+9Fd5Y///gYtmB3cexmhbYxOi4QRUyZ6HIbNQap64kW91L2chev5hcXCDB0dD+Q0jELYRKj+SjZku0yJjPTD9EkC5puU7fdQdoXX8PRHbUgmW5tzX6U2cPe/kOIaHbYei+K9c0NXdU6Xi0H2JJyWhXcwu+Va/R7M9B6AtVcFejWeqCbsLSt94MH5G8Z2v3W4uZ7i1tXawz4WPxaQwyHPlS6hEfuqdMNmuFJyobNVWqJ2gCSvUGWS0wkJggziKAVLiJcfEMflIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sIj+byRtCnFEPcUnBNhaN0IBJBDqkAr9Fbih5cRP+Q=;
 b=mDRrAdI1sevz/WPPOfqkmzRD036m2L8Rpp1heCuoDT4w8QGql9gHnbliUjpDrbJCBb/c4TNGksxdiG+oVI4feilwFgFWgBZj7QUzZaue1qbrYQ9RsjfGwp/l5Qa+FiagdwgHxNNBG3zbNoMD30/PTcW+/5q42Ae0JhzQqs7pLx+tlz+NVvLldD+tYDw5fXzkze3oCV1KYPV8SU++F5b9e5+Pa+cBEs4Q7cghR4uZLDeMtxRnyMlTRJvxkJ/bpeHo6xzce8uRDIlA7bkzTzJeYFMZAKpsT6TfVS3Rfed8a2MKm4JaVOfVuvmSuXT8vPMITYnS2BYStvgm76Gj1ySAxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:34:04 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 20:34:03 +0000
Message-ID: <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
Date: Mon, 6 Jan 2025 12:34:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] PCI: Fix Extend ACS configurability
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, paulmck@kernel.org,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, vidyas@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, vsethi@nvidia.com,
 sdonthineni@nvidia.com
References: <20241213202942.44585-1-tdave@nvidia.com>
 <20250102184009.GD5556@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250102184009.GD5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: a488b769-5165-4b66-3cda-08dd2e917563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjZsZVhSMEhrZE9NaENGNGE4bzFiYXVKK0VySnhQTVBPeVZNM0xjQnl0eUlG?=
 =?utf-8?B?TlE4Q0xTREs4VFl6MTB2U2NxWGsxUUJZTEhFdDJoS3B0RmtpaUJjSURickNh?=
 =?utf-8?B?UlRkZVVXTDZQUDRpaEhxRDc0WTBxcCs5REhxbWFnenROS2NPQjFBOVpNcEhN?=
 =?utf-8?B?a1A0MEM5Y2pFb1BMR0VnQXFlS2ZQRkUzM25KT1IyZEkwSVFPMWhWNlFTL2di?=
 =?utf-8?B?eitIWWp4S2tZcUNDQ2x0Wlk4ZGtCTDVjanlscmJpQ2dlYlJKVDZZNXdxMmkw?=
 =?utf-8?B?eUhDNnJaV21zalhkS0h5cWtmVDhnaHIwZlE1ZUtrQjdvOTZFZG1WK3VtcWl2?=
 =?utf-8?B?dEVVRDRickZsL21TMXRxbXRZOHhCbVl2RE1ydnVMeTg4SDY3S212c2JwWnpv?=
 =?utf-8?B?eExqdGR4RklWMjcrOUtUZThvcm9yMm9sNUJRNmMrdkZ2dWc1Mi9mUmNhUkpk?=
 =?utf-8?B?MWMrVmZJNmhBNDZwdk9ROXpEUGMyN3Mxd29ZLzJydUIwdVpocFNwWE8yLzV5?=
 =?utf-8?B?ZGdEQklMQ3hQNUU0b2tNaVhjaHpLS09SYkhQbGZFdlhqeVc1WWRBeDhpV3RN?=
 =?utf-8?B?ZjVHL05SZkwyYzlIejVtMFVCY25FZnozSVNuN3JrQnhvVEFnQlBTTDdrU2R1?=
 =?utf-8?B?Rnp5K3c4bUhBVTl6TE5pQStQS0hOZmd4Y1BZdGFlZGVsWGpKSWFuOW94VmhP?=
 =?utf-8?B?QVZUa3NzWGNEU0VBZlpxdFhGWFIzV1NqalV6alcxalFCbzBobHJGaDFtRHV5?=
 =?utf-8?B?a2NqbEQ0d1ZrR1FnTk1nUVUzNDBUMjVKblBtNHRsSTBBTEZ4YmlsSTA4Ymxx?=
 =?utf-8?B?UUd1RUxzOWswcWtGdTJ1VE1rcjlsd2RNZWxINFY0OVM1TjZLV25FekFmWHRI?=
 =?utf-8?B?ajVKaDBvRTdKRDhBdThneTRRWm1KeVloRC9aUTE2VC9QeExHU0tYYzE1WllM?=
 =?utf-8?B?RTREU1FPTVo1d1pkeWt0UXN4NkQ2SGpIeVJoMktQYmpHTEd6bU42YzZiYUd4?=
 =?utf-8?B?QzZJTUU1MTFEYW85RnYycGc4S2s5NzQ1WjE3RXQ2bEVBaEs5bzdLcER2bmd5?=
 =?utf-8?B?ckVzYXgrdDJiRUJoTDgrMW5jZXI0ekJiMTdycW11V2JMTHFISUR4R2Y4NG0y?=
 =?utf-8?B?NE5FZjU1RkNEaTRsTEpBeU1LOHNVd2g3OHdCekRVSnRGWVpvR2s0cGJCK01S?=
 =?utf-8?B?TTB3M2oxTjlGeGpQWmJEeU1RMUwxVDZEaExDL1gxSm1PRW56N0VWVy83UmN6?=
 =?utf-8?B?UGtKUWJjZVNYamF6bzJmU0syckwzYksvaTZsQU1peUxWUWNCam1wRFBwSnVK?=
 =?utf-8?B?YUZSdmZSMlY2cS9ZVDNaMXRCd2VONXpUVXFqSkJHSlZKeE5XTTIxUGUvMy9p?=
 =?utf-8?B?a0xCcHR4dkpuUjh4M1gzWXBvR1FHOVBDckxlYWpKTWJ1bjVNOGllOUJJTlVt?=
 =?utf-8?B?SkFGWkdWZjQ4V3dENGFvSms2eHl1TTlVQ3M3V3U3SHgybzIwQTlQTlBQVDVD?=
 =?utf-8?B?aTFwak1BdlE0M2xzTEJRSUpSKys3WkdmbkxFNjNLQXNLQXdvVWU2eUlkcERw?=
 =?utf-8?B?Y2lraEcwbGk5TFBxWi9mZE5rZTh0Z3hiWmhsbE5lQjlEdGgvbUxndHJ2SGtt?=
 =?utf-8?B?S3dYejJ3aFRBcndXLys3WEsvR2VxYkx0ckFFdGNVWTBLV29yU0FKNGpiYVBT?=
 =?utf-8?B?NWhSK3ZoRWpQY2dFSDgwOGVRQ1pMZVJYMU52U1gxMjlCWXoxY3ZYUkpCR1Ru?=
 =?utf-8?B?V3lSM1FXSXdVMnVvREdBbk5MYzkyQksxdnV4cGFCUWVhUDdOWG10T25ab3lV?=
 =?utf-8?B?aGU4OENRRkw3WVgzZGNMR3k2UmZIOVQzRTZwUnZILzhSeVQyR0tJN2UyWGpR?=
 =?utf-8?Q?MlYT5T0YGzNkj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHJ0WHI5bDdrRlUzOXc4K3B6RjJUK29DS0JUWjJabVdiUzN4a2RrRUFJeWJZ?=
 =?utf-8?B?VCs3djFRUTBwbCtLeWxveDhDcnRkSlYvd3VyOEpQSkdDelVvRDg1UjZGKzFL?=
 =?utf-8?B?dDQ4Z003ZjFCSlVIVmRMVGY0U0dHcUlPNThFekZ1VkdQbUlxcUgrbVB6UWNa?=
 =?utf-8?B?NEtuTWpkeTkvSCtLbUdseGFJY1JyYXY4dCtkRklzcUtqV0VTNU9nbTlqNEkr?=
 =?utf-8?B?V1QxaC9Lc24za3FyWi9KR0dFQVBtSzRIKzBENGpMQXRRUVdsQzFkSnZLcjVX?=
 =?utf-8?B?R3plYWI0eFNWanJ5N3drcjVISmxzMW5WOWNaQzBLaEdRc3BlUVBQUGRjNFVL?=
 =?utf-8?B?TzFYL2FmR1prTGJIdFFHemh4b1JDZWQwcUZIN0EwZjVpWnhQYkhyd2RWY1dP?=
 =?utf-8?B?SFgyWXl4NEJTa1hNb0JOVER6ckwyQ2Jya3JONEU3aW9Yb0duTFFpZE5zNXdT?=
 =?utf-8?B?YzI4N1VkV1B4ajV5ZEFPRi9xVi8wNGgrUkYzUWp6TDF0RXZaaWlJOG5LaWFy?=
 =?utf-8?B?YXU3Z3ZDMXRCaXRCcWtCbmszcENCMHE5RXNRV1Q1NDJJQUY3emhwajRyOGNH?=
 =?utf-8?B?TmtWQUhVU0g3S3JQOTRtTE1BdkVlQ1hydS9KUjh1azUrQmdKTmR2VUMxTGhk?=
 =?utf-8?B?STlucThKdTBFRVlZSWVBSW9TWmNqTmxUdGVkVThOSjBzbDNsdHZlbDc5cDhx?=
 =?utf-8?B?SU9YaHVzTE4ydGRWVGdRdTFxWXFtem1EbmZ6R1drMHNvUy9ZUFY2U3FwbG4v?=
 =?utf-8?B?YW9wU3lwNUNRQzVCNXFRUDU2U3U2MU95VGZ4OG1IUGN4ZzZYbGFyWGFVN1o4?=
 =?utf-8?B?eFA2WGlnSDRJNGVkVjFwNHowVjVKM041TU15UldJQXhhckZKcmJXRDJOQjc3?=
 =?utf-8?B?TzdwbnZoUExhdDk3ZFhqVVdERlIrVHBjZGh1RXA1bjdZcVVsT2dKc0tTTTBO?=
 =?utf-8?B?WnlvaWU4a0g2QjhlajI3NTJXaENFc2gyeVpMMFNHRWxOL09XVjVreEMwNnV4?=
 =?utf-8?B?OEwvSmx6SUlRS21LWnBZb0JwZEQ5SVI2UmFVNUNOczZockdieFZDK0Z2RWND?=
 =?utf-8?B?WkduKzNGcENKK1dOeEJCUWZnTEhtVnhyYWI3ZDFvMXkzWnZPMjNlblN3Wjkr?=
 =?utf-8?B?T0hjVURPVVM5S3pqRjV1LzNNNGNlTDByRDdOaHNxVzJ6OXBoMU5JZGpEN250?=
 =?utf-8?B?TXUwRldCaHZ5WXg3TjQySnhxVW5FbmZMMithRXZMV20zNGdwcGgvRFVrWnBq?=
 =?utf-8?B?Z0NHejdNZjF5UWtyMXBjTXdCVVl6NVJ1SVZDc3hrZG1udEVwckhyNStSWitD?=
 =?utf-8?B?Nk5lZXB2NU5ad0RxNnZnUktoajdvMC9TODN2cEQxdVVjMmhKMjBFYmxVWnRL?=
 =?utf-8?B?eVFaa2xycFE1K1ZUY0d4UkpoTSs4Q3M1bXp1TGJ3dXFLNXZzakMvTHBrSkFS?=
 =?utf-8?B?MTlmSWpqTXRxWk0vckVyYnMvR1o0Qmk1RDNxOWxTTVU4ODliZzJtUjI3a0xD?=
 =?utf-8?B?c0daVXpzTWhUeEM2V2hCMlF3aTV1dkhkZ1lNbzdLRkE5V0hyRDBkNCtpVmpL?=
 =?utf-8?B?NXF4UXFMQWIzZHBHYW5VdHVqamZvZEluaWtnNDY0RTRuZGY5RkVQcmtmUURk?=
 =?utf-8?B?Z1RwMTRnSFJ1WjRVUU5hbWl6V0tKWWEyK0VUWHJoTTRZRFhFdWc4YjBaYlp2?=
 =?utf-8?B?WmxvUGFHQUF4eU8xeGhJNjAvbzZ3M1NzZm9PQ0plNUZpS0QzTTZKY0tsRkhR?=
 =?utf-8?B?Y1N1NnJlSGV3VXNTRDJzOXZnUExJUW1IMUlhM3pPd0R2Q2k5TW1CQXJhQllq?=
 =?utf-8?B?eUVzemRCZVhKK2lCTU5hRkFBcnJMeHlNbDRwRGY0anlDbXRSVmI3Y0sxRFpN?=
 =?utf-8?B?Rzd5dUxJYjJXYlVSQWVpSGdqazZLc3BFckFpMUFVRWQ4UG1ITFJjbmhWejZC?=
 =?utf-8?B?OEp2STlmMEhCczZLR2ZoY1V1WFBXWWFaNmxZTUhpOWVOcGEwNXNEUGE5RHBz?=
 =?utf-8?B?L2FSM0NmNDA0RWkybnhUNWtqdllPT0NBVHUzZk53R0RKdVkwWVI4TkMwYW1k?=
 =?utf-8?B?eFBhQjlJeGNBOHl5Wmo0bHJiNUZ0WEZUUVJZc05mVUU0MHg0YlBkVHQ5bk5s?=
 =?utf-8?Q?dekt7ARcCEnN17on/p5sURPBu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a488b769-5165-4b66-3cda-08dd2e917563
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:34:03.2969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnUWIMBr369VAzL2h5NIetcDbv0Dgo4G4LZDUNdiApVpM6wfeoJvgGFF3T0FWJXAdWUGLfAkFH1VkUvn3orchg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052



On 1/2/25 10:40, Jason Gunthorpe wrote:
> On Fri, Dec 13, 2024 at 12:29:42PM -0800, Tushar Dave wrote:
> 
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index dc663c0ca670..fc1c37910d1c 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -4654,11 +4654,10 @@
>>   				Format:
>>   				<ACS flags>@<pci_dev>[; ...]
>>   				Specify one or more PCI devices (in the format
>> -				specified above) optionally prepended with flags
>> -				and separated by semicolons. The respective
>> -				capabilities will be enabled, disabled or
>> -				unchanged based on what is specified in
>> -				flags.
>> +				specified above) prepended with flags and separated
>> +				by semicolons. The respective capabilities will be
>> +				enabled, disabled or unchanged based on what is
>> +				specified in flags.
>>   
>>   				ACS Flags is defined as follows:
>>   				  bit-0 : ACS Source Validation
>> @@ -4673,7 +4672,7 @@
>>   				  '1' – force enabled
>>   				  'x' – unchanged
>>   				For example,
>> -				  pci=config_acs=10x
>> +				  pci=config_acs=10x@pci:0:0
>>   				would configure all devices that support
>>   				ACS to enable P2P Request Redirect, disable
>>   				Translation Blocking, and leave Source
> 
> Is this an unrelated change? The format of the command line shouldn't
> be changed to fix the described bug, why is the documentation changed?

The documentation as it is (i.e. without my patch), is not correct.

IOW, config_acs parameter does require flags and it is not optional. Without 
flags it results into "ACS Flags missing". Therefore I remove word "optionally" 
from the documentation text.

Secondly, the syntax in the example 'pci=config_acs=10x' is incorrect. The 
correct syntax should be 'pci=config_acs=10x@pci:0:0' that would configure all 
devices that support ACS to enable P2P Request Redirect, disable Translation 
Blocking, and leave Source Validation unchanged from whatever power-up or 
firmware set it to.

> 
>>   static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>> -			     const char *p, u16 mask, u16 flags)
>> +			     const char *p, const u16 acs_mask, const u16 acs_flags)
>>   {
>> +	u16 flags = acs_flags;
>> +	u16 mask = acs_mask;
>>   	char *delimit;
>>   	int ret = 0;
>>   
>> @@ -964,7 +965,7 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>   		return;
>>   
>>   	while (*p) {
>> -		if (!mask) {
>> +		if (!acs_mask) {
>>   			/* Check for ACS flags */
>>   			delimit = strstr(p, "@");
>>   			if (delimit) {
>> @@ -972,6 +973,8 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>   				u32 shift = 0;
>>   
>>   				end = delimit - p - 1;
>> +				mask = 0;
>> +				flags = 0;
>>   
>>   				while (end > -1) {
>>   					if (*(p + end) == '0') {
> 
> This function the entire fix, right? Because the routine was
> clobbering acs_mask as it processed the earlier devices?

yes, that is correct.

> 
>> @@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>   
>>   	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>>   	pci_dbg(dev, "ACS flags = %#06x\n", flags);
>> +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
>>   
>> -	/* If mask is 0 then we copy the bit from the firmware setting. */
>> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
>> -	caps->ctrl |= flags;
>> +	caps->ctrl &= ~mask;
>> +	caps->ctrl |= (flags & mask);
> 
> And why delete fw_ctrl? Doesn't that break the unchanged
> functionality?

No, it does not break the unchanged functionality. I removed it because it is 
not needed after my fix.

If it helps, using 'config_acs' the code only allows to configures the lower 7 
bits of ACS ctrl for the specified PCI device(s).
The bits other than the lower 7 bits of ACS ctrl remain unchanged.
The bits specified with 'x' or 'X' that are within the 7 lower bits remain 
unchanged. Trying to configure bits other than lower 7 bits generates an error 
message "Invalid ACS flags specified"

-Tushar
> 
> Jason

