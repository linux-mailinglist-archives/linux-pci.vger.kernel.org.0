Return-Path: <linux-pci+bounces-35920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A387B53996
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 18:47:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B417A8A78
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 16:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D0335A2B2;
	Thu, 11 Sep 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAZ7nyPE"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C8B236453;
	Thu, 11 Sep 2025 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609258; cv=fail; b=Wbfdn2pC6CVAnMIM6ujvHmw8ySihR8nqQF1NwQCypGn2LriA5FVK4bP9o+b/n6/oGvW6xUcW5kT+TnKEiH/xsewAPIfoUiDpBBCn7BqEDaz0Fof3CryWBWPOPQh76V+3rJKVg5uAVPYFgYN5rXiBMhsvLYP8+RYCktECBECiblI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609258; c=relaxed/simple;
	bh=V1yuggXbqXtbsHKvnMQSlQRn+OxhJUO68tdutVVeeFU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FLrFq0I1IoCsFweHIqa0riQc1MzS6VvGxq7cTDgJA8RDkNEL5Ddso+vDrJMoActafbT0g0242u9NsQzAUNvoiebg/ggCBPRuxuhGDvhP3T/gat+ab+ix6qIxXK0hNrY3onwz4QA+MJaQhDs5kMOtavYpydrtD5tFsYLLtLitwHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAZ7nyPE; arc=fail smtp.client-ip=40.107.212.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/UpRFFkEw8AADVw/dyWRhL0Fi+kodfUdtuH3Z8lF8H0T8w1/ieSVgXS46xrtks93vLeO/IvvDGQt7VERiW3BxLqA2lvrf+KdNbV5lvq1OmZmMc0aMjTsTfk885ZHOui9uJWg0leAufc9TyC6zFJk7UGyVgc9/Y+rLK4QD5Pvv1SfOoKvUbW+gM4Sxe9j4aKq6acOVYiN7rM/lGNqLRLk/HDBuLSVDYNGOnMBkq6c6pPEwzd7xAq36DVyKgbRPYnU0AqnByn+LRnVnK4LixuWdzy0WOF2NZaAgzckC1fvf7HkGf5KavPI+IsiidGvcLQa/Uup96jd8xpDKKJpK0C2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ngetm0A/NBOiR6iDQFzkRQNVFCbjyY76WfqmJ7mHhc=;
 b=GktibsuKRGX1snalxwvrTdJf5eP9x4Gewm7iJdnU5f5453TSpkP1MOab/1AgwwgszEdoGCASQ/H90chDOieOpn7AZdMgXFo5f44bDflxMPXmYrHsW2Oj656OjIIRd1OqcVCcZ9pQlyqtjlegnFLgm4lLslKYh7H6LtwBOuD8O7Om0kq2lg4cwqsGlPG0CF/qWou1wDbQsFcXYuxNsd5AgrWz4l3dkl+LsKxot54j9vJuIB0Y23bENgjRSyVLOxnfpDgYxUGVQKS3P0Cp2lboDz0R1NoGqKCo61CcH92dNxa8dyulW933g+crLGj9tCgEwHerM0W2oewn9i92Ps3rfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ngetm0A/NBOiR6iDQFzkRQNVFCbjyY76WfqmJ7mHhc=;
 b=KAZ7nyPEXhXLK9b2h4C+hgh1x+KsB1FsC/HBA5C+d324AIeB3c6iO0FH497pyU3KPOK7oqxWZzsXd0/WxCnDk6NpVkfG7QvNerYpIrqmVqeeO7N8i1htr4+aCA0O2Z7pT26GdXHRXnWVPxwz0UNwQkL42NJ/aKUGLG0QdyBu7mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 16:47:33 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 16:47:32 +0000
Message-ID: <ecf48ab1-d681-4145-b9a9-9c2d6984f7e6@amd.com>
Date: Thu, 11 Sep 2025 11:47:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/23] PCI/AER: Dequeue forwarded CXL error
To: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-19-terry.bowman@amd.com>
 <2312cd83-9faa-458b-9960-72760c769101@intel.com>
 <39c70b76-c109-48d8-ba4f-ef7535f7ddca@amd.com>
 <c52c2178-d50a-4dae-ae21-cd464e2dd56e@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <c52c2178-d50a-4dae-ae21-cd464e2dd56e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:8:2a::13) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d5065fd-8677-4c6d-2dd8-08ddf152e751
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZlTUJadm14eXNOOE1FN3dMNXJ0d3ZQS2JKS0dHdEcyQmtPTUlWakdZcUZn?=
 =?utf-8?B?TnM5V3hEalNkR3R2b2VCNWV4bnJJNFlJcGdXL2dwekFvQ01BWEVuSWxUeG9W?=
 =?utf-8?B?VnNwVE45enErcEFpTzNYbGpOUnFUcVRpZWdMZXJ1Tm1VNHJjL1lJMW5JREJI?=
 =?utf-8?B?TmZzaVExMkRjRUp4UDh5bjRTalJkNHZCNHJVMmUrcm11d1ZjWUFsN0pObkZy?=
 =?utf-8?B?bHJQbmlxanFaMXFwNmYxWTMyelFjQ2dyN2ZMcXZneHZIZW44MDJUc09Sc1o0?=
 =?utf-8?B?KzYyS2w1Z1JtRFIwZWZiK3hpUUY2b0RRY1VyMHZSbnJRb2dieUVDTm1xY0JL?=
 =?utf-8?B?LzBwU2hNVjFrZFd6RGt2SDN1Vk1hVmtXU3FpdVNvVkFwUzhMeXdMWEc0MmlK?=
 =?utf-8?B?T2dpT2NEcmYwR3dVOHAwMW5jUFNOZUIwRkNtMWo4WU1xVXd2dFNHaDQvYWVN?=
 =?utf-8?B?c1hNaVBQNkR2cmV4ZVRVSzZUcDUya1hnZFlKLys5SitVa0NKOEYwNkE4cjNi?=
 =?utf-8?B?THEwTll6YzJjbmpKajdYMnV2WkUreEZyb1BQUjJuVlFCckFrejB4ZnJEWnBD?=
 =?utf-8?B?MzkzK1ZIaE9SbS91ZVNlTVNpWDhYQ2Ywb0kweFhyblUzdXk2Vnl3YWZ4SlRh?=
 =?utf-8?B?UCtNVDhxUG5tUVJwYjhvS0Z1WU4yTVBOQWdaSWs3c3h6QzVHKzNRZnZVcGFw?=
 =?utf-8?B?ZjREZk9kOU1NSzZ5cnlSUE1MUENPSUJMZ0RJRnhQLzFTa3RKbzQrUFNkZXBj?=
 =?utf-8?B?R1N0NFNLeGZFVlkxb3RZbnZDdW9yTDgvbmNhWUJxdUt4UWJoN1VWLzlZVzcw?=
 =?utf-8?B?TEtEajJNWUQ2QmVjTzRueWVEdDZTKysvRDY2SktDaHNuSXd0ZUFMNWcyRDAy?=
 =?utf-8?B?eUdNQWtnRmVWQ09wdzY3VFVjQlpQYllsTXhoMHh0YkNKNTZKbW9TUzZ5K09K?=
 =?utf-8?B?OXBMdkZjTGp1QzNLQ2R4WnR4aWJUVDlKdXJ2YlpRNlVRa3dpT1EzY2lRblQ4?=
 =?utf-8?B?ZUEzeWlkZ1JLTjRWVUFQTDg3R2Fxd2U0UXBqL2VzUkxNQ0h6d0pNNnVueXVF?=
 =?utf-8?B?Y3JJL0E3eEV5Ylc4cmt2cWk0ZjN6bkl1ZE1TYWFvOFBiZFl4YWJFTUJzb0Zh?=
 =?utf-8?B?Y0VSYVpDMTZPQ3hrOXBsem96UHp0L0NEMWQzWm5UbWI1NEVnb2JpaEMyKzlU?=
 =?utf-8?B?TGNSTlhray9EZVRBU2dsN1N6ZGdnMHpobUx6WThSSjdzdnh5QzZtcGgxQkNo?=
 =?utf-8?B?cHpVeUFVcEFUV1YvNWgwdWJKTnYyWjlQTjdET2JJT1FTZDk1bmxOdmJHSWFS?=
 =?utf-8?B?ejk4YUZTajlmNGJDbEVzVUg3cjdxc3B3ZWtjRkNsSE5rQzVtR1Rpam1mZ3dV?=
 =?utf-8?B?MTh2a1orRWJpbFpWakJyc3M2b0dka2wzaFNUVW1yQW5UWXhmNE43SzNNTjdN?=
 =?utf-8?B?c2lCQjRhMkZYTnlBcEN3SnY5RDJNMEI0QlRrZmdMVEI3emJWSzFHSzk5N1pI?=
 =?utf-8?B?SlQwa3ovTTMrb3d4Q2Z3dDdtL1duUEZLYWNZaGdZMzZxZ2twUndWVFUvM0Fp?=
 =?utf-8?B?aUF4cUI3Zmc0Q1JrK2FxdS8wZ0xVTThKeTQ0R09LWGJzdGlLRFZPT2Z5ZW9C?=
 =?utf-8?B?RDFuOG44TDdhYjlTVW9tcUlSOFRQYStWd0lIVjh5OE1seVEvWGRVR0FiSi9r?=
 =?utf-8?B?Q0FKUldwUk42bmFKcUt4OWtjYzJlUmlrV09sNHhUdURieFArR3RzRkFpbFdI?=
 =?utf-8?B?R2hCQ2E2R2p3ZUxUOGhKNzVnMlBQK1dCb1JQYUw1RjlYS3VxekR4NCtybGFu?=
 =?utf-8?B?cHZXYzhRS3ZIc3JOL29qdHpyS3Uya0lLdUc1SUV4akw2WFVaV2xnTXYybkVx?=
 =?utf-8?B?bld3dXJpdWE4R0xqN3FxcUR6R2hDZmtiZDg3NlAvMGZrRHlac3RXOEt2d3N5?=
 =?utf-8?B?Q1NWdTU4SkZjZVpQenlVTXRQUjJnZzk3ZEVUV3FGRXoreTVGU1lLditvanRy?=
 =?utf-8?B?bDNCSG9lZnhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXZjQlIvZzBvTFlNemtVM3IxTGptTHNBZW1MUzJLZUxNKzFSNlBBZkZWS2ln?=
 =?utf-8?B?blVVTERDOXhWTkMzZ2FCVzA2OUJpcjBlSllURE5qVjFIOTZGUUFlWHNBRlJX?=
 =?utf-8?B?Q3paWnZMWXN2WVBCM2hpV0JmWVFlSU1Sc0hGL2JXU1ZLbVZtRkdkUW5zYXIw?=
 =?utf-8?B?S2FqdzFnNkFDenVRSFRaS2QwZG1sM2xPNFVsN2JCUnNzSTdrMndmcUllMjJT?=
 =?utf-8?B?THZ2dmc4Sjc4MUNCbXFPeCtDL2JCMURnZ0F2ZDFzVFRsQU5neUNmUTlDK2Ix?=
 =?utf-8?B?RzZKdkpIcmloN2pXWk9OVXc0bWd1NkZhYzZmeXVPbmh0blF0czR2SGVuK0p1?=
 =?utf-8?B?SkVNYVdGYmJPZjAralRrQ1QzUUlsd2Zta25tWGpxbGpsRWFPbXhBWkdRUHZB?=
 =?utf-8?B?elF2RkN4dkdZUnYvMkk0UGNpS2E2WktvcTY3SVRJb2c1SzRjN2N6YUJQRGtH?=
 =?utf-8?B?NFlIRUVLMVBFT0tVN3puUHBycmZISExxODVPWmlWTCsrRXkySEZGenRBVmlH?=
 =?utf-8?B?RmVvSFBjZHpydmp4Ly91a09XaFdURmlTUmEzUVU3T2NBZHFGbzY2V2QzUGR4?=
 =?utf-8?B?QVY5bm1iNjMxNEhrWEVxMnY2eW5CSWZHNzV5cDF1czYwTm5SamRSUVppNVRY?=
 =?utf-8?B?b3BWN3N0U0k3S0hOMU92UDk3UWZqRk1ZSEtYdnRML2tLalM1aktsTEJrZEJa?=
 =?utf-8?B?T3pCWWpBUEJwVFJuc3gvQkVFalpzbC9ucjQrYjlIeHJZbmIyTzdqMGRYckhT?=
 =?utf-8?B?b1Y5eG5iK3dIQUZVaFllNksxZmZlby9OdDNrN00vMUlMVDV4WmlYYkdWdlBV?=
 =?utf-8?B?TU5aRE8yL3hzbUlYc0I5Y01xVFpzMVJ5SERuaTE5U1Z6WCtuWCtubUNuUFU0?=
 =?utf-8?B?ZTJxckdnQmlmdkxDTlNtcjJSR1hMM0RVSHl5SnAvZ3k2a0wxOUlVZzZROW1z?=
 =?utf-8?B?V1JDV3RRNFY5SC9oNDlZeVp4MmhWT2hrMHh2QmZIYVZxclJySmpoUFo0N0x5?=
 =?utf-8?B?QWhhRDdUWHNNZjhWclhmQURsVUFucVdEdmpBc3BXL0ZNdzBsWXg4WTlwKzMw?=
 =?utf-8?B?V2c3OVQwQTErTVozbnRwRU52N29oSWg1TnhCTnp1dXJlMTdSZE9oSEZIRGx1?=
 =?utf-8?B?VVloNE5GanBlQ1V4ZjdHMTFuNFpuYnFhMVFxaStGamRQcTdzVklaWHdHaTVN?=
 =?utf-8?B?a0w3aTd6eW85ejFYVXl4aEt1c2YwR3ZkVHpKN2dTcUVhUzlac0hNdlR2Nlps?=
 =?utf-8?B?VVNOZlRVQThIOHg0NUxoT01rUkN6ZXJwQ3FiRm43Wkc4djM3VklsRDYyRmJL?=
 =?utf-8?B?djBHR3hVaW05LzUwcmkwR0kyWHVzeWlubGFsbU9UU2U4TFBVSWxRNnVrdFJz?=
 =?utf-8?B?NlphQXRYMXVSSElTeTZCYUFHUmx0V2w3T0NBdHI4VnEzVmtzZjRYd25yWGxy?=
 =?utf-8?B?dFZFL3VBTEhYVzE1RURGV3p4UzNRZzBFTTk3ZGxsL2c3VFpSZHFLQmhUTXZ1?=
 =?utf-8?B?bmNvS2FNVjNCcldESWdyWmJCdFRxdTBPWGh1cGNLTlF6cmVWTmJSVWcwbzht?=
 =?utf-8?B?c1BnclpqeXBDU0EyVWszNTZ0cEpVM09GT1RMOCtaeEhiTFNLcmZrWndFZUpr?=
 =?utf-8?B?WHFIUExhRVBNM2IxaDMxdy9GZlE5Ykt0UFg4QkFmV05LVTc0dlltL1l6U0NX?=
 =?utf-8?B?YWtCUThYM204NXhPVjFhSE5IMUpObFQ1aTlhOVRmREJtRkJFYlIxZTUyNGlU?=
 =?utf-8?B?SWlPeTZqMWY1WUZ4M1V5cUNjcWwxNndwdWpHYWJtREUwOHQ0anBPc3E4ZHJU?=
 =?utf-8?B?ZTY0bjhVcTk5VjNod3YxVXNPWXAzU1hxOUlMb05ybk5MMUttUldNQURJNk0z?=
 =?utf-8?B?cFpIcnNPemI2eEMxdTlhalRXTVRURHVZcEhKU2lsaTgySW1KMDl2clZ3U242?=
 =?utf-8?B?QWRTM2dENFRuOXVicktSL0x5ZGR3RGljSnExMEpzdmtDb1RPVFJpYXprN3Zk?=
 =?utf-8?B?SUtkUzBzSCtIbGxoanFydTBvOXRqUk1yVkZiQWNmaHlQV3BiYUpnNkdpVjhz?=
 =?utf-8?B?MTdxTkpmNUh4NXVSVkt6Y1phVWZOMTlxbzlIb3NKNXp0NHA2a0JGdlRIcG90?=
 =?utf-8?Q?owZL3QpfqwYiWoR03zXoBj9Ud?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5065fd-8677-4c6d-2dd8-08ddf152e751
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 16:47:32.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrh+idwpFSlAhinHcYyE8hNAPti1fbW7fXvJqqz+NWT82mWZlGozofgb7KKBJtApVZ0f/rn1QJswiSXnJPB+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065



On 9/11/2025 10:41 AM, Dave Jiang wrote:
>
> On 9/11/25 7:33 AM, Bowman, Terry wrote:
>>
>> On 8/28/2025 7:43 PM, Dave Jiang wrote:
>>> On 8/26/25 6:35 PM, Terry Bowman wrote:
>>>> The AER driver is now designed to forward CXL protocol errors to the CXL
>>> I would rephrase it to:
>>> The AER driver enqueues the CXL protocol error info to the created kfifo for the CXL driver to consume.
>>>  
>>>> driver. Update the CXL driver with functionality to dequeue the forwarded
>>>> CXL error from the kfifo. Also, update the CXL driver to begin the protocol
>>>> error handling processing using the work received from the FIFO.
>>>>
>>>> Update function cxl_proto_err_work_fn() to dequeue work forwarded by the
>>>> AER service driver. This will begin the CXL protocol error processing with
>>>> a call to cxl_handle_proto_error().
>>>>
>>>> Introduce logic to take the SBDF values from 'struct cxl_proto_error_info'
>>>> and use in discovering the erring PCI device. The call to pci_get_domain_bus_and_slot()
>>>> will return a reference counted 'struct pci_dev *'. This will serve as
>>>> reference count to prevent releasing the CXL Endpoint's mapped RAS while
>>>> handling the error. Use scope base __free() to put the reference count.
>>>> This will change when adding support for CXL port devices in the future.
>>>>
>>>> Implement cxl_handle_proto_error() to differentiate between Restricted CXL
>>>> Host (RCH) protocol errors and CXL virtual host (VH) protocol errors.
>>>> Maintain the existing RCH handling. Export the AER driver's pcie_walk_rcec()
>>>> allowing the CXL driver to walk the RCEC's secondary bus.
>>>>
>>>> VH correctable error (CE) processing will call the CXL CE handler. VH
>>>> uncorrectable errors (UCE) will call cxl_do_recovery(), implemented as a
>>>> stub for now and to be updated in future patch. Export pci_aer_clean_fatal_status()
>>>> and pci_clean_device_status() used to clean up AER status after handling.
>>>>
>>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>
>>>> ---
>>>> Changes in v10->v11:
>>>> - Reword patch commit message to remove RCiEP details (Jonathan)
>>>> - Add #include <linux/bitfield.h> (Terry)
>>>> - is_cxl_rcd() - Fix short comment message wrap  (Jonathan)
>>>> - is_cxl_rcd() - Combine return calls into 1  (Jonathan)
>>>> - cxl_handle_proto_error() - Move comment earlier  (Jonathan)
>>>> - Usse FIELD_GET() in discovering class code (Jonathan)
>>>> - Remove BDF from cxl_proto_err_work_data. Use 'struct pci_dev *' (Dan)
>>>> ---
>>>>  drivers/cxl/core/ras.c  | 68 ++++++++++++++++++++++++++++++++++-------
>>>>  drivers/pci/pci.c       |  1 +
>>>>  drivers/pci/pci.h       |  7 -----
>>>>  drivers/pci/pcie/aer.c  |  1 +
>>>>  drivers/pci/pcie/rcec.c |  1 +
>>>>  include/linux/aer.h     |  2 ++
>>>>  include/linux/pci.h     | 10 ++++++
>>>>  7 files changed, 72 insertions(+), 18 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>>>> index b285448c2d9c..a2e95c49f965 100644
>>>> --- a/drivers/cxl/core/ras.c
>>>> +++ b/drivers/cxl/core/ras.c
>>>> @@ -118,17 +118,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>>>  }
>>>>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>>>  
>>>> -int cxl_ras_init(void)
>>>> -{
>>>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>>>> -}
>>>> -
>>>> -void cxl_ras_exit(void)
>>>> -{
>>>> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>>> -	cancel_work_sync(&cxl_cper_prot_err_work);
>>>> -}
>>>> -
>>>>  static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>>>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>>>>  
>>>> @@ -331,6 +320,10 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>>>>  
>>>> +static void cxl_do_recovery(struct device *dev)
>>>> +{
>>>> +}
>>>> +
>>>>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
>>>>  {
>>>>  	void __iomem *addr;
>>>> @@ -472,3 +465,56 @@ pci_ers_result_t pci_error_detected(struct pci_dev *pdev,
>>>>  	return rc;
>>>>  }
>>>>  EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");
>>>> +
>>>> +static void cxl_handle_proto_error(struct cxl_proto_err_work_data *err_info)
>>>> +{
>>>> +	struct pci_dev *pdev = err_info->pdev;
>>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> So this function is called from the workqueue thread to consume data from the kfifo right? Do we need to take the device lock of the pdev to ensure that a driver is bound to the device before we attempt to retrieve the data? And do we also need to verify that the driver bound is the cxl_pci driver (and not something like vfio_pci)? Otherwise I think assuming the drv data is cxl_dev_state may cause crash.
>>>
>>> DJ
>> Yes, this is called in the worker thread context. I added the pdev device locks
>> later in cxl_report_error_detected() for the UCE case. I found it necessary to 
>> put in this function and not in cxl_handle_proto_error() (here) because of the 
>> traversing logic in the UCE handling flow where it needs to be locked but only
>> exactly once. I didn't add for the CE because I wasn't certain a CE error was 
>> enough reason to add a device lock. 
>>
>> The UCE flow is:
>>
>> cxl_handle_proto_error()
>> --> cxl_do_recovery()
>> ----> cxl_handle_proto_error() <--- Added device lock here because of topo traversing/iteration
>>
>>
>> I tried adding a function checking for cxl_pci driver but ran into circular dependency 
>> because the driver is defined in cxl_pci but called from cxl_core. I will revisit
>> this again but need some ideas how to make that work as I expect it will require 
>> some code moving. 
> Is there a chance that the endpoint errors can just be handled via the standard AER flow via AER callback? Otherwise we may need to move the cxl_pci driver definition to core/pci.c in order to do this....
>
> DJ

I understand AER callbacks in your comment are the PCIe CE and UCE callback handlers. Calling 
the AER handlers for the EPs would technically work because they are initialized to CXL 'PCIe' 
callbacks already. The AER callbacks are used for handling EP fatal UCE errors.

One problem is this approach isn't consistent with the plan to use CXL device based error 
handling because it will now be using PCIe error handling for EP CE and UCE errors. 
Also, CXL device handling would be used for for CXL port devices which would be implemented
differently.

Terry 

>> Terry
>>
>>>> +	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>>> +	struct device *host_dev __free(put_device) = get_device(&cxlmd->dev);
>>>> +> +	if (err_info->severity == AER_CORRECTABLE) {
>>>> +		int aer = pdev->aer_cap;
>>>> +
>>>> +		if (aer)
>>>> +			pci_clear_and_set_config_dword(pdev,
>>>> +						       aer + PCI_ERR_COR_STATUS,
>>>> +						       0, PCI_ERR_COR_INTERNAL);
>>>> +
>>>> +		cxl_cor_error_detected(&cxlmd->dev);
>>>> +
>>>> +		pcie_clear_device_status(pdev);
>>>> +	} else {
>>>> +		cxl_do_recovery(&cxlmd->dev);
>>>> +	}
>>>> +}
>>>> +
>>>> +static void cxl_proto_err_work_fn(struct work_struct *work)
>>>> +{
>>>> +	struct cxl_proto_err_work_data wd;
>>>> +
>>>> +	while (cxl_proto_err_kfifo_get(&wd))
>>>> +		cxl_handle_proto_error(&wd);
>>>> +}
>>>> +
>>>> +static struct work_struct cxl_proto_err_work;
>>>> +static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
>>>> +
>>>> +int cxl_ras_init(void)
>>>> +{
>>>> +	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
>>>> +		pr_err("Failed to initialize CXL RAS CPER\n");
>>>> +
>>>> +	cxl_register_proto_err_work(&cxl_proto_err_work);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +void cxl_ras_exit(void)
>>>> +{
>>>> +	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>>> +	cancel_work_sync(&cxl_cper_prot_err_work);
>>>> +
>>>> +	cxl_unregister_proto_err_work();
>>>> +	cancel_work_sync(&cxl_proto_err_work);
>>>> +}
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index d775ed37a79b..2c9827690cb3 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -2328,6 +2328,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
>>>>  	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
>>>>  	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
>>>>  #endif
>>>>  
>>>>  /**
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index cfa75903dd3f..69ff7c2d214f 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -671,16 +671,10 @@ static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>>>>  void pci_rcec_init(struct pci_dev *dev);
>>>>  void pci_rcec_exit(struct pci_dev *dev);
>>>>  void pcie_link_rcec(struct pci_dev *rcec);
>>>> -void pcie_walk_rcec(struct pci_dev *rcec,
>>>> -		    int (*cb)(struct pci_dev *, void *),
>>>> -		    void *userdata);
>>>>  #else
>>>>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>>>>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
>>>>  static inline void pcie_link_rcec(struct pci_dev *rcec) { }
>>>> -static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>>> -				  int (*cb)(struct pci_dev *, void *),
>>>> -				  void *userdata) { }
>>>>  #endif
>>>>  
>>>>  #ifdef CONFIG_PCI_ATS
>>>> @@ -1022,7 +1016,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
>>>>  static inline void pci_no_aer(void) { }
>>>>  static inline void pci_aer_init(struct pci_dev *d) { }
>>>>  static inline void pci_aer_exit(struct pci_dev *d) { }
>>>> -static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>>>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>>>  static inline void pci_save_aer_state(struct pci_dev *dev) { }
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index 627d89ccea9c..45abe1622316 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -288,6 +288,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>>>  	if (status)
>>>>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>>>>  }
>>>> +EXPORT_SYMBOL_GPL(pci_aer_clear_fatal_status);
>>>>  
>>>>  /**
>>>>   * pci_aer_raw_clear_status - Clear AER error registers.
>>>> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
>>>> index d0bcd141ac9c..fb6cf6449a1d 100644
>>>> --- a/drivers/pci/pcie/rcec.c
>>>> +++ b/drivers/pci/pcie/rcec.c
>>>> @@ -145,6 +145,7 @@ void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
>>>>  
>>>>  	walk_rcec(walk_rcec_helper, &rcec_data);
>>>>  }
>>>> +EXPORT_SYMBOL_NS_GPL(pcie_walk_rcec, "CXL");
>>>>  
>>>>  void pci_rcec_init(struct pci_dev *dev)
>>>>  {
>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>> index f8eb32805957..1f79f0be4bf7 100644
>>>> --- a/include/linux/aer.h
>>>> +++ b/include/linux/aer.h
>>>> @@ -66,12 +66,14 @@ struct cxl_proto_err_work_data {
>>>>  
>>>>  #if defined(CONFIG_PCIEAER)
>>>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>> +void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>>>  int pcie_aer_is_native(struct pci_dev *dev);
>>>>  #else
>>>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>>  {
>>>>  	return -EINVAL;
>>>>  }
>>>> +static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
>>>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>>  #endif
>>>>  
>>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>>> index 3dcab36c437f..3407d687459d 100644
>>>> --- a/include/linux/pci.h
>>>> +++ b/include/linux/pci.h
>>>> @@ -1804,6 +1804,9 @@ extern bool pcie_ports_native;
>>>>  
>>>>  int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
>>>>  			  bool use_lt);
>>>> +void pcie_walk_rcec(struct pci_dev *rcec,
>>>> +		    int (*cb)(struct pci_dev *, void *),
>>>> +		    void *userdata);
>>>>  #else
>>>>  #define pcie_ports_disabled	true
>>>>  #define pcie_ports_native	false
>>>> @@ -1814,8 +1817,15 @@ static inline int pcie_set_target_speed(struct pci_dev *port,
>>>>  {
>>>>  	return -EOPNOTSUPP;
>>>>  }
>>>> +
>>>> +static inline void pcie_walk_rcec(struct pci_dev *rcec,
>>>> +				  int (*cb)(struct pci_dev *, void *),
>>>> +				  void *userdata) { }
>>>> +
>>>>  #endif
>>>>  
>>>> +void pcie_clear_device_status(struct pci_dev *dev);
>>>> +
>>>>  #define PCIE_LINK_STATE_L0S		(BIT(0) | BIT(1)) /* Upstr/dwnstr L0s */
>>>>  #define PCIE_LINK_STATE_L1		BIT(2)	/* L1 state */
>>>>  #define PCIE_LINK_STATE_L1_1		BIT(3)	/* ASPM L1.1 state */


