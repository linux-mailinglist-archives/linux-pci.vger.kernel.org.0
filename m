Return-Path: <linux-pci+bounces-19588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D8A06BE3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 04:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6341E18880CA
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 03:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF29139D0A;
	Thu,  9 Jan 2025 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="suUnu9im"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ABEDDDC;
	Thu,  9 Jan 2025 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736392421; cv=fail; b=o2ZbcxtJWejWC5SWVB/7lxZ6xZE4oBNXYT3XzrVlS8rM9IF1AhuIR+jyUUC8Q/z/1IEVdwVOR1LD0BCaDxx44dBEk4Q2v5jd/umfglUkTGWQyxFY3KBglr9XO2+CXT1MEq3qzPIduLdEEUn+ibznxXKrIrK2M1luQ04gM+84uBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736392421; c=relaxed/simple;
	bh=rpUMrLsJS2kXNUoMUzmcW3i2VWt6PnANEC8bupkhc/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T8CZMndm9qoPzfNF1cGH60L3NmYqXA/WDMzGwyc5+/yL7vnZKNGGcWWrhpUiC5nwdKrQG8L9ZfRDzlCZEUCFN3n0cmdoHQOIh3bok6IR9ImSZltV4DdBV9b+GlSjmr8F1KsYsgfMSqEFg8oFzxeTOMjqIIjAaprNkD/e7qicNTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=suUnu9im; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCmybXw9VNkpy+ig3UhptzNpgWkf+XUawVx7g5O2m7U4Ul1biMK4I1Dyc4MMPsMNxnWvBteACxJZoHeI5yVKGytTuHRhuCx0pF3I+IE9lcpx+lv0pjUjlPVe7TF72LdQ3zA8GgvCMvWnjUHtZIlxluqUE6+vIyG7RvdUNnM0bZIH4yRhHDbGRRDgFIXfGu1q53fm4QMRHUG/tsIzB3NdlLLQETwsBM5zWF10fN0QmBV5Yhw0rFJyhOMx9/pfJ4kSz7eixyl4AhsGSEdH+TBmHblXk9vfdZhXvsBlvxqEoi4M/AqfMU2mW8qyBfTk8iJILX0smib/DJkgU4jaAc3c7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLaVVtPCe5bF7uE++ZeFpYd0fCt1jNuW/4Ani9gE41Y=;
 b=LcSu5QO7ugXOk2JzsuECfe5mzuedI/vb6HchsSLD+BR746qU9yjNy5xMtzxIqi94ZX5F3DiGHiB+yZ7tqpwc339LRoBKytTp1MctCkU1RxNk/mv5LSvGTYEPwn9trp/O9rTf3DtxjIEamB5+FYlaJBQhwg3tHKqq1jAmmkYsYcdmbRTmn8/fWac2xJJaorrvj6ZvOOfUM+oCp0UfJ2IxX+gnZLIy9Dxc/95ql9gOh4DhLE2FXIt6Lk9Wfevjr8FHIpT4z8gq+UnqAnG5YY2yDreVUHPMfjbUu5S7PwpygNIhVoHfyz12aWSuEKtJ1uaE9JzmK7IhiHf9SkvUYJQXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLaVVtPCe5bF7uE++ZeFpYd0fCt1jNuW/4Ani9gE41Y=;
 b=suUnu9imxMOCwIPhy9CuhYw8w6PBfeGUR9MZlrpW29ExJNbuqrmySg1xu/9jvN7KOkNG3/M8uduscmoN+M7gXKlfBWfNn+j47W5RxR/TE8Az72myXD42glw6IWLzFLLovgdG2HBJKNQEbS/GK3+Im6xKYj6Shy87VKHg38Q/rM8PPPXURuWb9cYNbsG6srQy3yFL92R5EX9JQXju0Ed4nXrqdWR2RWj4DJNn+nIvxPwmkGkiNaWzec3bzj7xJtZzsJdFV1Pu9uWA6vpRjwdpxa2CRldChyve/OwOQ0daKApJGdzgUg6ku+u9NEKH42W2/v7k/6nZCxQGeuTdeKlihA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 03:13:36 +0000
Received: from PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a]) by PH7PR12MB6657.namprd12.prod.outlook.com
 ([fe80::e1a7:eda7:8475:7e0a%6]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 03:13:36 +0000
Message-ID: <0ea48a2b-0b6d-49e2-b3f7-ab4deef90696@nvidia.com>
Date: Wed, 8 Jan 2025 19:13:34 -0800
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
 <2676cf6e-d9eb-4a34-be5e-29824458f92f@nvidia.com>
 <20250107001015.GM5556@nvidia.com>
 <c9aeb7a0-5fef-49a5-9ebb-c0e7f3b0fd3e@nvidia.com>
 <20250108151021.GS5556@nvidia.com>
Content-Language: en-US
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <20250108151021.GS5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0296.namprd04.prod.outlook.com
 (2603:10b6:303:89::31) To PH7PR12MB6657.namprd12.prod.outlook.com
 (2603:10b6:510:1fe::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6657:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdae30a-d045-42e3-5ca6-08dd305b9b46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U25NOXFGeG5WT1JBTVVmWXJ1T01XWEF4MkgySkIrRXhTRlFQLy8yYm9aMFIz?=
 =?utf-8?B?ejB5emdoTTVsUXpGM0c1Ly84WnZVTkhzYjcvVGlqeEJRRHJKTXIzbGY5dS9l?=
 =?utf-8?B?dlNtTjVrcTZ6YlJiME5OVWkrbVVrNklRdmk0STNUZDZPWWVNWlhWam9oTmFH?=
 =?utf-8?B?M1BpRHJDa2lYSm5MRDR6NWk5OU5GZUd6bDVFZVh0VnB1UTFHaHJDTkVLL0VQ?=
 =?utf-8?B?ZHFLZW96QkxxckcvdTFHL2hQVE9hd3UwdFQ4bEJZV0t3aFVLQ0lKTmJMMFFp?=
 =?utf-8?B?dmxRZURBa01SYzdkU3NkVFU0OWwwbmFDYkFUemhHWHMyWkFESzk0ZHEvU1h0?=
 =?utf-8?B?QUtKbGNscmpKdjJ2WXR6Sncrc2NHTEFvcVVxd0hJMUxpR2xhNHRqMWg5MUhV?=
 =?utf-8?B?VDNQTzVZeWN3R3V5dW9xSTYrWFE1U1U0ZmNTbEc4eGZjWGNtcG40K0poRmMr?=
 =?utf-8?B?azI3VzJFN0k2U0RHbTNHMWgrbTJrUGJDRmZhU0w4RGZ4UVV2YTg5by9NSlVl?=
 =?utf-8?B?ank0ME5QSkRvNU9ML3MxY3V1UnQzVEYrc0U2eVAraWZHcVloYjFnUnBlbnJD?=
 =?utf-8?B?UWlOdFZFNnBIZzdpQktWU0Yxa0tzVjVKUTgvd2tYV0NzSE5QMml3U1dFYkpX?=
 =?utf-8?B?bEkvR0xFTENsTGFYaENHbGZ1YllaaGdRdm5UQU9Mbk42ckJLMWd2cVhQQTRM?=
 =?utf-8?B?QTBuL2ltQVRVT2VPTDdGTmdUK29MTlFhL01MWUQ4OHVFZm4wVlNkRmRyWDBl?=
 =?utf-8?B?QTZUWTZleWpLcDBZVHNEeW01ZXdLVE5FTHBPRk5sVTRKY1hRUmFBNU5uWXM1?=
 =?utf-8?B?bzBkekxkTXlkdDIwVzRaK1pBMEN6cG5QSzhudlBCRjF5eld3bVdjMUhZcWdK?=
 =?utf-8?B?QUU3WG5WSVVQSlh2R1Q4SktYaGw3ei9zNi9zeTdXVE8vdGhCb203Z3NaUkEw?=
 =?utf-8?B?enpKSzdJVnpKZHduMlNaaVdFVWtZWlo2Y2J5MW5KSzFiaGY1bUVkV0h6NTd5?=
 =?utf-8?B?TjIrRnlmU2QraW13a2RueXhjVTZ4clBZdGdwTENHMWtzWWxrN0ZvR0lWMk5m?=
 =?utf-8?B?Q2FkZXp4ZEtzNExyOHZQaDVKR3Q5UVFyT3R6dWlvL2pya2IrZEJ2VklSVysr?=
 =?utf-8?B?S2RSamZWR2x1YzdxdjJrajE2NjhVQnV4STJUUXZ6SVdxaHBHN09MUjJMYk9J?=
 =?utf-8?B?TmhVNlVUV1lpRFZwdGNLeTJCTVppNjRvVnpsZVVwTXNGVkFYTVZnSGZwVmcr?=
 =?utf-8?B?YTgralBFUU11SlBYVFNmV2JMNStmdDcwdmxWVVYvUU1MdW1wVWUwT1FiSkhr?=
 =?utf-8?B?dnVNcGdYN2tWY0o4MlpHTUNQRW4wZkIwMndTMEEwazNmcXdmQVRtZ1g3NEdK?=
 =?utf-8?B?VE95RUZ6aVlzZWNacEptbTY1ckNZVlVHVFZ1c1JmY1kxV3hqUE1NRHFYU2VJ?=
 =?utf-8?B?U1V6ZlRSdisyS1NPb3QzSUM5UEFDMkIxRDZHVlYxd3o4MFY1UFJqZENUOUpZ?=
 =?utf-8?B?RmxrQkM4dmNJYk9BR3h6U3dHT1dEeDN2NVdOME00T2xGL3JoOHZuR0tydXlH?=
 =?utf-8?B?YytGNEVRcjlMVXQ2RC8vR25DS3hoUGM2YmZ2SlhlZXNWQWlWWXNLNURpL2cr?=
 =?utf-8?B?anZhQ2RKQlBZNTVsZXcwalFVQ0VHbVUyM01sdHlZSGx5R3VwS0VHUUlUcDBG?=
 =?utf-8?B?MWswSW50SWNFMnIvU1lITXhCdnRINXBhOGNuZlVGQmQ2QXllM3VzaHJUOHpq?=
 =?utf-8?B?SnY3TGdDQzBnTkYxc3JaVks3VHFKTWhYSmN4SFRCUmFuME5mMWRpR3BJZFRq?=
 =?utf-8?B?V2JTMG9PUjR5NFVUMDB2Sm9DYnJYdGlYMFN6cUU1bHlYYlhpTkc1RmpsSlQ0?=
 =?utf-8?Q?huYAaStrPodjz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tm93a1QrQm1kSktnWURPSFhXNjNrM0tJRk5LNnM4UUpsWWxSbXlUb0pVc3dm?=
 =?utf-8?B?YzRySmEzR0VWTTNrc2txS2hoU0FlVUNndlVKd0hNUWRiNVU5SU1PRmQ4OWFr?=
 =?utf-8?B?VU91VmVkR2k4Z3JaMU1ES0dRVjVnd0VKS3dveWp3MXgxb09kOHJDZ2M2QXQv?=
 =?utf-8?B?OHZNb0IvVHJqei84dm1ySEJ4eFd5ME5GWmRxTzNFQzRRT1I0eSt4T291WHpP?=
 =?utf-8?B?dzRlQXUvSDlmb21rOWJZenUyaEV6TW5LK1haL3Y3TXpkZVdJN0NsODR3M0lp?=
 =?utf-8?B?M00zczMyRTdNS1dqVktESDFjc2VYOVZMcFY0VXUxK25iOVhkeWlzZkJrd0JS?=
 =?utf-8?B?U2dhWjdDcFQ5QjYzcWplVFByd3dlN0NidW1lMWNKN0NxeGp0Uit6bXFLRUxw?=
 =?utf-8?B?NTNJb2c3eFIyOGNJcVBBdmxXQkJCTFJTNnRGRk9RaHU3dDBlbXl0bC90RGJI?=
 =?utf-8?B?Z1VrU3ZtUktuaHY2NnpmSkdwT2xyWDgrQm1hVzVPbzVtVVoxbHY1RWJzRUhp?=
 =?utf-8?B?am93YjA4aERkS2tJSzE5K2ZCKzIyblAzU21ka3BrTHhDOVBrU0VzckRUNVdh?=
 =?utf-8?B?QmRua1pVakRMN2FQemNleUIxRmRFY1diQUVWVEZmd2hsTzIrRldKZlEyeFAx?=
 =?utf-8?B?VUQ2Y3JTMjJWTW50WnQ3bUN4NWx1eFl5ZEp2TGlzQUVUb0xGSm5NVW4xaFZi?=
 =?utf-8?B?R3BTaDJ3aVNJLzJlbFZUOExBdXFDaS9YWVcveGlvc3lCUTZBVW1zb3RpbWt5?=
 =?utf-8?B?U0F1OEJnTEtLaDF2SlR3WDlCcUFVMVRDeTZRN1dhK0hRN2tuTTd6bThBNGRW?=
 =?utf-8?B?di9KcHBqekR3VzlacThOalUvL2ZiUkg4RDlDNlpWVDRsczRaYmUxTmtTbDFn?=
 =?utf-8?B?NmdtOXhxS3B1Tm05UkNMa3dBaWpGZHVsMlNWQnVzajR5WGhJbDNhOUxZazBp?=
 =?utf-8?B?QitJQVo2RUpVR3RKb2drUEZlZUdOczRlSlBkSTFKRVJ2cW5zaUhreHQ3Sk53?=
 =?utf-8?B?MVRSOWVZZyt6OTM2MktaRkYvMXBQTEo4TllZd25wQVJtdDBlWDFmQVlSa1Fs?=
 =?utf-8?B?V1k0d1ljS25kbm1LMmtWVWU1S3JVTzF4WDNkamxzbHFwZy9yRFNjaHBTdnRC?=
 =?utf-8?B?ZjZJTWs3Z2pzV1o5SnN5Vk1SWjZ2Q0U4Z3hyR0ZsZk1ZTXhwV0FhTC8zbzhH?=
 =?utf-8?B?ek5KWSthay9vdVhlZXV5ekc1VVovejF5cHZhQ001WG5pQmhXdmY2eTdXOHI3?=
 =?utf-8?B?R1FHRWRrUjUxMjR5d3NXVDJDdVpXMHhPSm55TVlzbUhrcHRVMWl1RU13bThR?=
 =?utf-8?B?SXlRaWRYMktLTTVTMEVNQ0JSZyt5R1o2OG4ybWhBbjMyN3dTMWxReURyb2hm?=
 =?utf-8?B?b3ZYZGo5bE9xUm1VejA3WUExbm8zTVpDenRrdXlSY1hMM3p3RDl3MVJtOUVK?=
 =?utf-8?B?RHpuMHUrbzFzVVJEN29GeWw5VzFUcW04SWxtRzhUQ21LeWVlWmYvSEpkb0Zq?=
 =?utf-8?B?WlhEZHdZSXRYdnc5enRZbkJlRnVzKzE2TExiR2Qzb01md2k4VktMbWxNVitB?=
 =?utf-8?B?M256LzR6WmN2NGRoRmZBaEdJTGtMeEUrUHJRZzFJNnBBUjNpK1pLcHZYMUQ5?=
 =?utf-8?B?MzFJRlNDVjdVTnlMVWJiSlpQbm9vTDAvZTlKSmpqSEZhRThkazlLblBmVW5E?=
 =?utf-8?B?NzR6ZHd6R0ExNG8vQzREcnlJUkhkN0RBV0I4ejFjYVd3YlcyYkR1V21jYzVW?=
 =?utf-8?B?RjFjSE1tNTh4aHNuZXd0L0JJVlVpc3REem5JV2phS3Z5U0xPSXBqSG1kTXVn?=
 =?utf-8?B?MjVZSlNWYWtMNVBscHRzYlFFY0lRWHA4OTE5NXJsZzZnUGJSK091a0xkVUl0?=
 =?utf-8?B?aGpnZkFtNzQzSkVvMml5eUF2TmM5SVh5cXBhb2w4M0w4dzN5YWEzb2xiMVB2?=
 =?utf-8?B?OUJlWFY3a1ZtV0R6bm10bkY4aUxvT3d5eFpjdTM3eEJydGNxeG5PN3BEKzVK?=
 =?utf-8?B?QzRMZlBrZVVncHA5VENtRHZLdlczSkNwRmF0bmhaMWxXOEFtUmUxS3U0MWJQ?=
 =?utf-8?B?b0ltd1doZXNWZGtZM2w1dnhPMGxEQU5jcFZaOG9iQ2JYRitvL3lFRmw2TUQ5?=
 =?utf-8?Q?kB45To6ueIUrPXIllUktEfs7+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdae30a-d045-42e3-5ca6-08dd305b9b46
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 03:13:36.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lit5ezQw5Y7heisIOQXRPMv8faEB7jWaxZiBpKMg5orxe4Xodf2FIXP6UOki/I0hd3mrvQMmHH69ZMSqGr7IDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846



On 1/8/25 07:10, Jason Gunthorpe wrote:
> On Tue, Jan 07, 2025 at 06:32:42PM -0800, Tushar Dave wrote:
>>
>>
>> On 1/6/25 16:10, Jason Gunthorpe wrote:
>>> On Mon, Jan 06, 2025 at 12:34:00PM -0800, Tushar Dave wrote:
>>>
>>>>>> @@ -1028,10 +1031,10 @@ static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
>>>>>>     	pci_dbg(dev, "ACS mask  = %#06x\n", mask);
>>>>>>     	pci_dbg(dev, "ACS flags = %#06x\n", flags);
>>>>>> +	pci_dbg(dev, "ACS control = %#06x\n", caps->ctrl);
>>>>>> -	/* If mask is 0 then we copy the bit from the firmware setting. */
>>>>>> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
>>>>>> -	caps->ctrl |= flags;
>>>>>> +	caps->ctrl &= ~mask;
>>>>>> +	caps->ctrl |= (flags & mask);
>>>>>
>>>>> And why delete fw_ctrl? Doesn't that break the unchanged
>>>>> functionality?
>>>>
>>>> No, it does not break the unchanged functionality. I removed it because it
>>>> is not needed after my fix.
>>>
>>> I mean, the whole hunk above is not needed, right? Or at least I don't
>>> see how it relates to your commit message..
>>
>> Without the above hunk, there are cases where ACS flags do not get set
>> correctly. Here is the example test case without above hunk in my patch (IOW
>> keeping fw_ctrl changes as it is like original code plus pci_dbg to print
>> debug info)
> 
> Isn't that because the bit logic in the code is wrong? >
>> -	/* If mask is 0 then we copy the bit from the firmware setting. */
>> -	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
> 
> That comment doesn't match the calculation at all.

Yup, the above bit logic is wrong.

> 
>>>> If it helps, using 'config_acs' the code only allows to configuresIts the lower
>>>> 7 bits of ACS ctrl for the specified PCI device(s).
>>>> The bits other than the lower 7 bits of ACS ctrl remain unchanged.
>>>> The bits specified with 'x' or 'X' that are within the 7 lower bits remain
>>>> unchanged. Trying to configure bits other than lower 7 bits generates an
>>>> error message "Invalid ACS flags specified"
>>>
>>> But the fw_ctrl was how the x behavior was supposed to be implemented,
>>> IIRC there were cases where you could not just rely on caps->ctrl as
>>> something prior had alreaded changed it.
>>
>> I read your comment in https://lore.kernel.org/all/20240508131427.GH4650@nvidia.com/
>>
>> Looking at the current code, the sequence begin with function
>> 'pci_enable_acs()' that reads PCI_ACS_CTRL into caps->ctrl and invoke the
>> below three functions that prepares caps->ctrl before writing to ACS CTRL
>> reg.
> 
> caps->ctrl is supposed to be the target setting and it is supposed to
> evolve as it progresses.

agree.

> 
>> 	i.e.
>> 	pci_std_enable_acs()
>> 	__pci_config_acs(dev, &caps,disable_acs_redir_param,...)
>> 	__pci_config_acs(dev, &caps, config_acs_param, 0, 0)
>>
>> Here kernel command line takes precedence over 'pci_std_enable_acs()'.
>> 'config_acs' takes precedence over 'disable_acs_redir'. IOW, if config_acs
>> param is used then it takes the final control over what value is getting
>> written to ACS CTRL reg and that is how it should be, no?
> 
> Yes, but X in config_acs should copy the FW value not the value
> modified by disable_acs_redir_param

I see your point. In that case (for the last hunk in my patch) something like 
this should work IMO.

-       /* If mask is 0 then we copy the bit from the firmware setting. */
-       caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
-       caps->ctrl |= flags;
+       /* For unchanged ACS bits 'x' or 'X', copy the bits from the firmware 
setting. */
+        if (!acs_mask)
+                caps->ctrl = caps->fw_ctrl;
+
+       caps->ctrl &= ~mask;
+       caps->ctrl |= (flags & mask);

Wish I can have better condition check instead of 'if (!acs_mask)' but let me 
know your thoughts.


-Tushar

> 
> Jason

