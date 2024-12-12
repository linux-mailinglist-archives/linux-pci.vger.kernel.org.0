Return-Path: <linux-pci+bounces-18334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE009EFBFD
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341C216D1F3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F25186607;
	Thu, 12 Dec 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="svPqgta9"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0B188736;
	Thu, 12 Dec 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030073; cv=fail; b=Gp8oUl0z1HRs7cQZEddMuJxx+oe/9+7lHTG1jm4zcoorsvQH49cTbo47Y3H3DvHnXn5Ji0lOFnMGMYOf8J0EZAF1Gmi1LKlpbkK9Ojt2p7SG/eXaJTm/LJuDutoVAKFFvaCkZ3XIw1c1B896vWLQvZM5N/FIYc75qlcRcJw4gxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030073; c=relaxed/simple;
	bh=+P68hIbwZSWguqlP42TypdgifZ4qwYYQzhPbsYsed8c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRJB3jBW6pYgRhE3Lg/tpicvRA4hmFdqYkhK/7BaiZhcrLDgEJ7gGXOOetqobTGgsTCmZDqFmja6f5PPKiRJlkbcJw2q+iZ9Q+cgcEEw9hyyX7QBP0lkgkozMM7vopzR6MEl2v722xNidmgz633TUpdGxoMjsExi9jZIaQVYFmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=svPqgta9; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Myqh2utSCx9wHU0uregfAj6Nm10PMwRpZRR1eGa46DJHtVTihyP1L1/xvH3IX5ItU7GDzSPKz1YgmN41j8KcVShEV7xko8ok+88g+vVBauMltjYStWzihA/eP0TYe+p2Cjaj5mCxK/zSCkCt3aLW4QrOgf4DNhK9NG48JUcDMOYu2ILX2eiOMVY1TDQUqdOa/bvjsYl6EEniZR/UKGu7ImIlm+vlLPFruYdx3BRyH16SF1uuQbN9ncxGQ3RnCEElDS++iF2s2oL2zzprUhoz3g8P/sWdlHGW4cDwEj8msRRSNy9VJZ2jBbnPH7r69d3oZGHrPBy9FPsg/7tfavucxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUpBANfG+GzqUGfuaQ0fu1hFPBmk+DXpE1R/esi3Kb4=;
 b=rKYrxbPNkvfueCQkP0jo2bbUK2df4OFWeO/+Rkko4dCW+hyepQl7LOQhgQSicwzefgMAS4HcPpD0Z7TQa6+u1Rg0gbFltQKwyI+emyRm9fdLbwlGvEKKUzx/Ko4GEZD1NELDOl/XmnBAKeOgu5OlgJQmZwsuV+Iy6dBdcrQ6C4lZGHCtvqW7RWYg50FAQHIfSZPIp2+5WfILkr4VoZJM5SkbTnl73FdrfrnuGuuoaVyIIIivMXUZ5HKQlgpinsw9W2QxFjVKddx9bVnJVFW0xz5d+xQNNO1+xsoxWLuv+Qh04NCRDB3wogWEznN3DqVaxgeBQf0FKCctLaYr5ZMnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUpBANfG+GzqUGfuaQ0fu1hFPBmk+DXpE1R/esi3Kb4=;
 b=svPqgta9IVetgR7UlddawhwS2fRyHZxYfLIp872xxDFnaptRL720J+/KRmgsPkNY595yfSpNUlsZl3B9F0Un1Y72ZeX1CDbYDi2Q+3xocuKQoiBXarznY7xqD+YG+XyHjA6q12KzBjyQmpp5d2S6kYb5/mPtqAliGuvTy4lPK6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 12 Dec
 2024 19:01:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 19:01:04 +0000
Message-ID: <20cfa4ed-d25d-4881-81b9-9f1698efe9ff@amd.com>
Date: Thu, 12 Dec 2024 13:01:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Avoid putting some root ports into D3 on some
 Ryzen chips
To: Werner Sembach <wse@tuxedocomputers.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Richard Hughes <hughsient@gmail.com>
Cc: ggo@tuxedocomputers.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209193614.535940-1-wse@tuxedocomputers.com>
 <215cd12e-6327-4aa6-ac93-eac2388e7dab@amd.com>
 <23c6140b-946e-4c63-bba4-a7be77211948@tuxedocomputers.com>
 <823c393d-49f6-402b-ae8b-38ff44aeabc4@amd.com>
 <2b38ea7b-d50e-4070-80b6-65a66d460152@tuxedocomputers.com>
 <e0ee3415-4670-4c0c-897a-d5f70e0f65eb@amd.com>
 <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6a809349-016a-42bf-b139-544aeec543aa@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:806:f2::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: c89dcf61-f99b-4fe4-02fa-08dd1adf541a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cW9QL3BodEhmamNjWHpUeTBSRzRKaC9yQzMveUNYVTA0U0VqSnYxbzlYQ0Jv?=
 =?utf-8?B?YldCeFpTeDFQL1c5K01YcHNCN28ralI0Q0djZDZXRGhhMzNTQmpPYnVCNXpy?=
 =?utf-8?B?K3hrZEJlbC91UVFDZWIxRXdkajRLVWozMUhIb1lCRFpQQjV3V3V1VERxcGRT?=
 =?utf-8?B?anB5ajZCL3Fualo1aGpkQmxlckd4encxdHJTcVBaVitvcXpuYStQS3Fvejkx?=
 =?utf-8?B?YXRtYXFSYUE3MlRhbjlLYmdTNnpPSXNOUUMxZ0NhYWRWVTZUem1NRjdERVls?=
 =?utf-8?B?QVNMLzFhSUxTbnIyZTFRRXZwZGtoQWdSNTVMRFJxSFl6dWRBNk42ODBqUU1R?=
 =?utf-8?B?ODB2R3ppWHJMOElObERHOTlVcU53OXgrMVlidTFkdjZ6QWszbkZ4TEQ2eWt2?=
 =?utf-8?B?VWNVejRyWVZkb3pHTzlIUnJyMktDZW5FUHlWTmREdDFkRllPQkxpQXRNMDRw?=
 =?utf-8?B?dDBnYVBDaFJRb0Iya0FZSit4ZHN0RGJEOVdwUnREbDlKVHFPVkNsR25DZnBs?=
 =?utf-8?B?SVpWVTByN1IyQVUvaVN1YkVVektManhOK3d4Ly9OSHVhdlY5MTdoT1BobUlK?=
 =?utf-8?B?WDFVSHZHTnY3NXVpd1EzQi9ZMWgzT0N3YWFmc3JkUndBVUM4QkpYTEZldzlw?=
 =?utf-8?B?ZVZ6V21obFJseVcxZ0VpbVNtc1d1aEVGU2Zxa3VaMnE3YlpLQ0lWcnI1N3R2?=
 =?utf-8?B?L2ppZzNpVjUzV2hlenF6Z1R4UzBGWTNSOTU5emFrYjBIcW1tK0dJeWI3YlU4?=
 =?utf-8?B?L2hVV3E0eUIvWXdJS0VnM0x5ZHZhMURramRSN3B3MzFQVERNK1pGcjZ1VjFh?=
 =?utf-8?B?eGgrcnJlaCtaUzBjcmpHTjJQeVBPamVpZHc4dUh1VWhNNzJBclVGU081dElj?=
 =?utf-8?B?eDF6cVY5TlM5ek5YeGdIdjBSQ1NlZVlJYzE3aU1LaGxVcmd4Vy9HWHlISi9M?=
 =?utf-8?B?WVp5WnRhWUpFMU1OSkc2ZFlKUi9TSFhKNit6dkNwL0Z2cFliUDRDeUJ6bXk4?=
 =?utf-8?B?T2cyc0ZHbnMxRVE0TDRMOWV6Y3d2NnVFTzBXWkRDWlp1d214K1dZOGJJbE1G?=
 =?utf-8?B?bER1VzNMQ08xWi8yc0RUUkNEYnZoZnp4VGNNWEc4cUZmZHVsZW41dHRYT1dY?=
 =?utf-8?B?QkVUNnd5dE54WkV0SUFUaFdQSWsrdXJTRFNQbUlmZ1Z5Y0pnVjhkVHFaNHBk?=
 =?utf-8?B?MnROSlFwZzU2NkVyK29lb2JQdTlDS2VOZnRPOUF1TU1Qb3VDcUtUQTFoNmRl?=
 =?utf-8?B?cVNJazhXOHFWRHc3NmxCeXJPSWJiOGdBL2VFRGxYbXEyWjJRS1lpczM4RExv?=
 =?utf-8?B?MXRRSDFmZERwL1pnQnNCRGU4RDRrSkhJd2k0b2ZsdFpETlM2T1JNWEcrS1Jr?=
 =?utf-8?B?OUk1dVo4WUpDci9zM0lkcW0vOUpHMWMwei92QjF6MW1xaFVaNWFaN1RJcjFj?=
 =?utf-8?B?alZoazNIQVU5ZVlOclh1YVp6dEw5by9oNTUreXFGa20xSzdsd2pJbzVLMUZY?=
 =?utf-8?B?YTZ0SVpLZ2RLU2dUeW9WNTUwQXZiUE5ZOGV1a2VMODhhOU04N3FHai9lLzFN?=
 =?utf-8?B?RXBzN1c3UVZNU04zL0xmaHN5YkNicEVJSVpBZXF0dnhUTnhrbFdxQ29iQVFD?=
 =?utf-8?B?cWtaQnJQbVEvUjRFVldJaHduVnZFbHEwUWUxTm5DVW5ZNjdUZXFFZ2c2ZUJh?=
 =?utf-8?B?VnZIY082Y29BelU1eDBraHVYVEp1dXdjbncrY3NYelpzRXZiM3hPYWVZV3BH?=
 =?utf-8?Q?zCBgCD76XBmfcRWqKI8KgS36B7he4vjNz+X8CBs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjlOOWJxRjV3MUtFS2FidFdJakgzNGpyb3MxUzNTYUs1NUFFanhFQ25Ic0pI?=
 =?utf-8?B?cis0cTR2Ly93WEo1RlhWczkxMFVrZHdYYlA5WGhDQU9PRUFRVmRNMU9qK0pq?=
 =?utf-8?B?bUZMYUo2UlNEQTBReTVKSjlRZVVhODhTc2VrWUpxby9pOUgrMmhYeVZKaThk?=
 =?utf-8?B?Y0g0QVJlZC83L0ZIMmxQNE5ybzBxclRaT3BNRFllM29LSVBNcnpBLzJTQTFP?=
 =?utf-8?B?WEkzNGQvSzZCWGFoQ2VDdmVwR0kyZWlHZkZDVmx0ek5aM3dHeVAvT1YxbUd2?=
 =?utf-8?B?d0JTSHZMSTcweG5MbmtwWEsydUZkWjhFMHd3RDdIa3gzQzdqbkdGUmVOZmtL?=
 =?utf-8?B?K0puWnpDUGRma3NoQnkxWFFaUkRpUWJ4cmp2OFZTVnQvcGw3TWczMEg5aW5a?=
 =?utf-8?B?bzNXcEczWFFKK0drVWVHU1pVL1psRnZ6OEh4c3c3eU10MnBOdFZWeHl1NHl0?=
 =?utf-8?B?T0Vja1RBREQwYzA0T0RtU09pRnZQMFJXQ3B6VTVZU1ZtKzNLZUpaTmRiTHhl?=
 =?utf-8?B?L09MWE1vSDZJYmdpdm9IY2cwS1JXYzQ1RkluV2RyZmhrd2dzTktSZDkwdlo1?=
 =?utf-8?B?UkVYbVRObjZRRHBwRi9UeHdPK09pekp6aHdTbWhlRlppOXJldzFBQ3BWTGRp?=
 =?utf-8?B?cnhvbXZUZTZ0TmhwVHVEd0svKzRqVWZBMCtRQXljV1pPS05Xd1laSXhKaW11?=
 =?utf-8?B?bmJoTHQveFJ6TGNGRUtJRDY5WDQ2Y3lSNm9qTm0rWXdsRUZ6aEJ1T2N0TDVW?=
 =?utf-8?B?YzVzM1UyS29ydDAxYSsrSDJiRHBLMFBpZE1mbXBTa2pCZ3k0SHpMcXc2ektX?=
 =?utf-8?B?VVlHZ0hSN1J3NWZldjdmeldncThYZGtLSFdGQXNNQU9ia3JISmhveGU1emp4?=
 =?utf-8?B?aTVubEdHNVQ1VEhMNlo4bWY0VUY1V1EvcVVaY3Q4azBaSi9zd2NnZDU2OUow?=
 =?utf-8?B?ZHd5bnp0dE4zdGFNSHZsd2txbzAzNW5KeXBzY2JiMFc4NUZzUEU0VU5Yd0RS?=
 =?utf-8?B?NHZpb3N6QXA1b0ZTOUUwQWRiU1pKWXEyYURzQmlQMWZOVm9CYWxJd3ZpV1Y3?=
 =?utf-8?B?UXorMzlLMkVXZGpmMnJ3a0JsSjRLVFdjUzM4VmFtNnA5Z0tzdUJNQ1pQUkRO?=
 =?utf-8?B?S2dCUXZjMEhXZEF1enNScDlwd0Fzem1rTTFlU1ZIMTJCNHFKTTRLSzVnSjFW?=
 =?utf-8?B?VHRGazNzKzEvMTVlZHNHODRZUTdTQ0R1cXoyVUwzWk83VStBR1JwZHFlK2hM?=
 =?utf-8?B?ZnhDMzJITG11RS9taGQwRWgrUm5tK2FEZkJjZCtLY29NcUdMekpZQk15MUR4?=
 =?utf-8?B?K3cxd1lWd0FSWCtrazVYTFN0clhYaWJZdi9qSCtYcW0wZUcyYjZPK3RkOFBn?=
 =?utf-8?B?cXVQSlhSdWZNUkFzWEh6RG1WUWJjWlh0TnZHekZINXFvM0xQRFlXV2Jrb2NH?=
 =?utf-8?B?bi9yM3FMODJxcVJhZ3g1R1ZGdEpVTldhNnhzaHh4dDAyMWpjUzN3eFJiZm90?=
 =?utf-8?B?ekVVTzJjT0lpNVc5dTYwbmhBNFNSVWtOWEZLSWo2SVhsNUMzOWFzNVl1Q1Ny?=
 =?utf-8?B?MkdYdzEyOWx5WXRkMDJRRXBFNWx1MTk4MXkzTWRsbnNnZk0reDdTeEtRT3NH?=
 =?utf-8?B?OHJLNm4zY0Z4NHlKMlpJc1NTZDNBbG9sZThPY212T1VwKyszeHQ5K0MrU3JS?=
 =?utf-8?B?WU90RnRSdDk3TWdNZmZ5NnNJci9PTDFkRXNBVFZaY2pxOE9zSzBVQWhJMHlo?=
 =?utf-8?B?M3hOSjIxbVZhSHRWWTRiZFliQzcxR2NTaFZXNjN5VVYycTBOWklNNUxXb09a?=
 =?utf-8?B?Qy9ub01wZE5sNXV0eGw3dXQ4K1FCRDdpeWk0UnhaMSt2UFBSOG9RdG5qbkR6?=
 =?utf-8?B?cHR0RnpZdFZuM2dqMHBnNGIybjRZMEdzZjEyMnp5UTVseW16QlB2RGxkYmFj?=
 =?utf-8?B?Zys0bDI0K1BoOTZ4clEzNmxZc0IvRkdZNUpvM2hpVU1VczhwYlprcDNpVjhw?=
 =?utf-8?B?cEFreklyMnIyeVVFQ1FXV2RwSE9RV2RadC9ZcUd1TFROL2VjQXhWMVB6VlN3?=
 =?utf-8?B?aWR3ZGNDWDJqeUs5NEtLY3Nqayt5dnltRS9NUEE2UFhRTjdkZnFpTGxsY0g2?=
 =?utf-8?Q?huRC4uDrO3ae3yr6j77U07IU5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89dcf61-f99b-4fe4-02fa-08dd1adf541a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 19:01:04.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w98GlQefZ1JClu6tf9dbfmGGRTJyi65bC8TOuL4dpkjhdA8y9KK8aIZcjWOPBYG09hAPyS2zUpJCMesirBQGKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

+ Richard Hughes for some extra comments on the capsule issues.

It's tangential to your immediate problem, but I think if we can help 
you to get it solved it will be healthier for your future products.

Here is the full thread for context.

https://lore.kernel.org/all/20241209193614.535940-1-wse@tuxedocomputers.com/

More comments below.

On 12/12/2024 12:47, Werner Sembach wrote:
> 
> Am 11.12.24 um 22:24 schrieb Mario Limonciello:
>> On 12/11/2024 06:47, Werner Sembach wrote:
>>> Hi,
>>>
>>> Am 10.12.24 um 17:00 schrieb Mario Limonciello:
>>>> On 12/10/2024 09:24, Werner Sembach wrote:
>>>>> Hi,
>>>>>
>>>>> Am 09.12.24 um 20:45 schrieb Mario Limonciello:
>>>>>> On 12/9/2024 13:36, Werner Sembach wrote:
>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>
>>>>>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>>>> sets the policy that all PCIe ports are allowed to use D3. When
>>>>>>> the system is suspended if the port is not power manageable by the
>>>>>>> platform and won't be used for wakeup via a PME this sets up the
>>>>>>> policy for these ports to go into D3hot.
>>>>>>>
>>>>>>> This policy generally makes sense from an OSPM perspective but it 
>>>>>>> leads
>>>>>>> to problems with wakeup from suspend on the TUXEDO Sirius 16 Gen 
>>>>>>> 1 with
>>>>>>> an unupdated BIOS.
>>>>>>>
>>>>>>> - On family 19h model 44h (PCI 0x14b9) this manifests as a 
>>>>>>> missing wakeup
>>>>>>>    interrupt.
>>>>>>> - On family 19h model 74h (PCI 0x14eb) this manifests as a system 
>>>>>>> hang.
>>>>>>>
>>>>>>> On the affected Device + BIOS combination, add a quirk for the 
>>>>>>> PCI device
>>>>>>> ID used by the problematic root port on both chips to ensure that 
>>>>>>> these
>>>>>>> root ports are not put into D3hot at suspend.
>>>>>>>
>>>>>>> This patch is based on
>>>>>>> https://lore.kernel.org/linux-pci/20230708214457.1229-2- 
>>>>>>> mario.limonciello@amd.com/
>>>>>>> but with the added condition both in the documentation and in the 
>>>>>>> code to
>>>>>>> apply only to the TUXEDO Sirius 16 Gen 1 with the original 
>>>>>>> unpatched BIOS.
>>>>>>>
>>>>>>> Co-developed-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>>>> Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>>>> Co-developed-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>>>>> Cc: stable@vger.kernel.org # 6.1+
>>>>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume- 
>>>>>>> from- suspend-with-external-USB-keyboard/m-p/5217121
>>>>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>> ---
>>>>>>>   drivers/pci/quirks.c | 31 +++++++++++++++++++++++++++++++
>>>>>>>   1 file changed, 31 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>>> index 76f4df75b08a1..2226dca56197d 100644
>>>>>>> --- a/drivers/pci/quirks.c
>>>>>>> +++ b/drivers/pci/quirks.c
>>>>>>> @@ -3908,6 +3908,37 @@ static void 
>>>>>>> quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>>>>>>>   DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>>>>>>> PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>>>>>>>                      quirk_apple_poweroff_thunderbolt);
>>>>>>> +
>>>>>>> +/*
>>>>>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers 
>>>>>>> into D3hot
>>>>>>> + * may cause problems when the system attempts wake up from s2idle.
>>>>>>> + *
>>>>>>> + * On family 19h model 44h (PCI 0x14b9) this manifests as a 
>>>>>>> missing wakeup
>>>>>>> + * interrupt.
>>>>>>> + * On family 19h model 74h (PCI 0x14eb) this manifests as a 
>>>>>>> system hang.
>>>>>>> + *
>>>>>>> + * This fix is still required on the TUXEDO Sirius 16 Gen1 with 
>>>>>>> the original
>>>>>>> + * unupdated BIOS.
>>>>>>> + */
>>>>>>> +static const struct dmi_system_id quirk_ryzen_rp_d3_dmi_table[] = {
>>>>>>> +    {
>>>>>>> +        .matches = {
>>>>>>> +            DMI_MATCH(DMI_SYS_VENDOR, "TUXEDO"),
>>>>>>> +            DMI_MATCH(DMI_BOARD_NAME, "APX958"),
>>>>>>> +            DMI_MATCH(DMI_BIOS_VERSION, "V1.00A00"),
>>>>>>> +        },
>>>>>>> +    },
>>>>>>> +    {}
>>>>>>> +};
>>>>>>> +
>>>>>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>>>>>> +{
>>>>>>> +    if (dmi_check_system(quirk_ryzen_rp_d3_dmi_table) &&
>>>>>>> +        !acpi_pci_power_manageable(pdev))
>>>>>>> +        pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
>>>>>>> +}
>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14b9, 
>>>>>>> quirk_ryzen_rp_d3);
>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14eb, 
>>>>>>> quirk_ryzen_rp_d3);
>>>>>>>   #endif
>>>>>>>     /*
>>>>>>
>>>>>> Wait, what is wrong with:
>>>>>>
>>>>>> commit 7d08f21f8c630 ("x86/PCI: Avoid PME from D3hot/D3cold for 
>>>>>> AMD Rembrandt and Phoenix USB4")
>>>>>>
>>>>>> Is that not activating on your system for some reason?
>>>>>
>>>>> Doesn't seem so, tested with the old BIOS and 6.13-rc2 and had 
>>>>> blackscreen on wakeup.
>>>>
>>>> OK, I think we need to dig a layer deeper to see which root port is 
>>>> causing problems to understand this.
>>>>
>>>>>
>>>>> With a newer BIOS for that device suspend and resume however works.
>>>>>
>>>>
>>>> Is there any reason that people would realistically be staying on 
>>>> the old BIOS and instead we need to carry this quirk in the kernel 
>>>> for eternity?
>>> Fear of device bricking or not knowing an update is available.
>>
>> The not knowing is solved by publishing firmware to LVFS.
>>
>> Most "popular" distributions include fwupd, regularly check for 
>> updates and will notify users through the MOTD or a graphical 
>> application that there is something available.
>>
>>>>
>>>> With the Linux ecosystem for BIOS updates through fwupd + LVFS it's 
>>>> not a very big barrier to entry to do an update like it was 20 years 
>>>> ago.
>>> Sadly fwupd/LVFS does not support executing arbitrary efi binaries/ 
>>> nsh scripts which still is the main form ODMs provide bios updates.
>>
>> It's tangential to this thread; but generally ODMs will provide you a 
>> capsule if you ask for one.
> 
> I already evaluated this a while back with the results:
> 

Thanks for sharing.

> If the BIOS is an AMI one you can get a capsule, but this capsule might 
> overwrite DMI strings or the vendor boot logo if not flashed with the 
> AMI flasher and extra flags (sadly I was not able to find out what these 
> flags do under the hood to give fwupd the same capabilities). Also these 
> capsules often not include Intel ME and EC firmware updates and certain 
> bios version might only work with certain EC firmwares.
> 

It sounds like some bugs in the implementation of the capsule handler 
for this system.

> Last I checked in with the ODM that uses Insyde BIOSes we where not able 
> to get a capsule update. I don't know if that is an ODM or Insyde problem.

It's not an Insyde problem.  I use Insyde capsules regularly myself from 
fwupd.  I also know several other OEMs that ship capsules to LVFS that 
use Insyde.

> 
> For the rest I will come back to this on Monday as I'm currently away 
> from the testing device, thanks for all the feedback so far.

Ack.

> 
>>
>> Anyhow if you are providing scripts and random EFI binaries in order 
>> to get things updated, that explains why this is a large enough chunk 
>> of people to justify a patch like this.
>>
>>>>
>>>>> Looking in the patch the device id's are different (0x162e, 0x162f, 
>>>>> 0x1668, and 0x1669).
>>>>>
>>>>
>>>> TUXEDO Sirius 16 Gen1 is Phoenix based, right?  So at a minimum you 
>>>> shouldn't be including PCI IDs from Rembrandt (0x14b9)
>>> Thanks for the hint, I can delete that then.
>>>>
>>>> Here is the topology from a Phoenix system on my side:
>>>>
>>>> https://gist.github.com/superm1/85bf0c053008435458bdb39418e109d8
>>>
>>> Sorry for the noob question: How do I get that format? it's not lspci 
>>> - tvnn on my system
>>
>> No worry.
>>
>> Having looked at a lot of s2idle bugs I've found it's generally 
>> helpful to know what ACPI companion is assigned to devices and what 
>> are parents.
>>
>> So it's actually created by this function in the s2idle issue triage 
>> script, amd_s2idle.py.
>>
>> https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/ 
>> amd_s2idle.py#L1945
>>
>> And while on the topic, does your "broken" BIOS report this from that 
>> script?
>>
>> '''
>> Platform may hang resuming.  Upgrade your firmware or add 
>> pcie_port_pm=off to kernel command line if you have problems
>> '''
>>
>>>
>>> But i think this contains the same information:
>>>
>>> $ lspci -Pnn
>>> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Root Complex [1022:14e8]
>>> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> IOMMU [1022:14e9]
>>> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Dummy Host Bridge [1022:14ea]
>>> 00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> GPP Bridge [1022:14ed]
>>> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Dummy Host Bridge [1022:14ea]
>>> 00:02.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> GPP Bridge [1022:14ee]
>>> 00:02.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> GPP Bridge [1022:14ee]
>>> 00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> GPP Bridge [1022:14ee]
>>> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> GPP Bridge [1022:14ee]
>>> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Dummy Host Bridge [1022:14ea]
>>> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 
>>> 19h USB4/Thunderbolt PCIe tunnel [1022:14ef]
>>> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Dummy Host Bridge [1022:14ea]
>>> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Dummy Host Bridge [1022:14ea]
>>> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> Internal GPP Bridge to Bus [C:A] [1022:14eb]
>>> 00:08.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> Internal GPP Bridge to Bus [C:A] [1022:14eb]
>>> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Phoenix 
>>> Internal GPP Bridge to Bus [C:A] [1022:14eb]
>>> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus 
>>> Controller [1022:790b] (rev 71)
>>> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC 
>>> Bridge [1022:790e] (rev 51)
>>> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 0 [1022:14f0]
>>> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 1 [1022:14f1]
>>> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 2 [1022:14f2]
>>> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 3 [1022:14f3]
>>> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 4 [1022:14f4]
>>> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 5 [1022:14f5]
>>> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 6 [1022:14f6]
>>> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] 
>>> Phoenix Data Fabric; Function 7 [1022:14f7]
>>> 00:01.1/00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD/ 
>>> ATI] Navi 10 XL Upstream Port of PCI Express Switch [1002:1478] (rev 12)
>>> 00:01.1/00.0/00.0 PCI bridge [0604]: Advanced Micro Devices, Inc. 
>>> [AMD/ ATI] Navi 10 XL Downstream Port of PCI Express Switch 
>>> [1002:1479] (rev 12)
>>> 00:01.1/00.0/00.0/00.0 VGA compatible controller [0300]: Advanced 
>>> Micro Devices, Inc. [AMD/ATI] Navi 33 [Radeon RX 7600/7600 XT/7600M 
>>> XT/7600S/7700S / PRO W7600] [1002:7480] (rev c7)
>>> 00:01.1/00.0/00.0/00.1 Audio device [0403]: Advanced Micro Devices, 
>>> Inc. [AMD/ATI] Navi 31 HDMI/DP Audio [1002:ab30]
>>> 00:02.1/00.0 Ethernet controller [0200]: Realtek Semiconductor Co., 
>>> Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller 
>>> [10ec:8168] (rev 15)
>>> 00:02.2/00.0 Network controller [0280]: Intel Corporation Wi-Fi 
>>> 6E(802.11ax) AX210/AX1675* 2x2 [Typhoon Peak] [8086:2725] (rev 1a)
>>> 00:02.4/00.0 Non-Volatile memory controller [0108]: Samsung 
>>> Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983 [144d:a808]
>>> 00:08.1/00.0 VGA compatible controller [0300]: Advanced Micro 
>>> Devices, Inc. [AMD/ATI] Phoenix1 [1002:15bf] (rev c1)
>>> 00:08.1/00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ 
>>> ATI] Rembrandt Radeon High Definition Audio Controller [1002:1640]
>>> 00:08.1/00.2 Encryption controller [1080]: Advanced Micro Devices, 
>>> Inc. [AMD] Phoenix CCP/PSP 3.0 Device [1022:15c7]
>>> 00:08.1/00.3 USB controller [0c03]: Advanced Micro Devices, Inc. 
>>> [AMD] Device [1022:15b9]
>>> 00:08.1/00.4 USB controller [0c03]: Advanced Micro Devices, Inc. 
>>> [AMD] Device [1022:15ba]
>>> 00:08.1/00.5 Multimedia controller [0480]: Advanced Micro Devices, 
>>> Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 63)
>>> 00:08.1/00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] 
>>> Family 17h/19h/1ah HD Audio Controller [1022:15e3]
>>> 00:08.2/00.0 Non-Essential Instrumentation [1300]: Advanced Micro 
>>> Devices, Inc. [AMD] Phoenix Dummy Function [1022:14ec]
>>> 00:08.2/00.1 Signal processing controller [1180]: Advanced Micro 
>>> Devices, Inc. [AMD] AMD IPU Device [1022:1502]
>>> 00:08.3/00.0 Non-Essential Instrumentation [1300]: Advanced Micro 
>>> Devices, Inc. [AMD] Phoenix Dummy Function [1022:14ec]
>>> 00:08.3/00.3 USB controller [0c03]: Advanced Micro Devices, Inc. 
>>> [AMD] Device [1022:15c0]
>>> 00:08.3/00.4 USB controller [0c03]: Advanced Micro Devices, Inc. 
>>> [AMD] Device [1022:15c1]
>>> 00:08.3/00.5 USB controller [0c03]: Advanced Micro Devices, Inc. 
>>> [AMD] Pink Sardine USB4/Thunderbolt NHI controller #1 [1022:1668]
>>>
>>>>
>>>> That's why 7d08f21f8c630 intentionally matches the NHI and then 
>>>> changes the root port right above that instead of all the root ports 
>>>> - because that is where the problem was.
>>> For some reason it doesn't seem to trigger on my system (added debug 
>>> output) I will look further into it why that happens.
>>
>> You never see this message in your logs at suspend time (even on a 
>> "fixed" BIOS)?
>>
>> "quirk: disabling D3cold for suspend"
>>
>> I'm /suspecting/ you do see it, but you're having problems with 
>> another root port.
>>
>> I mentioned this in my previous iterations of patches that eventually 
>> landed on that quirk, but Windows and Linux handle root ports 
>> differently at suspend time and that could be why it's exposing your 
>> BIOS bug.
>>
>> If you can please narrow down which root ports actually need the quirk 
>> for your side (feel free to do a similar style to 7d08f21f8c630) I 
>> think we could land on something more narrow and upstreamable.
>>
>> At a minimum what you're doing today is covering both Rembrandt and 
>> Phoenix and it should only apply to Phoenix.
>>


