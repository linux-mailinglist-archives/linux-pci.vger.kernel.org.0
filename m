Return-Path: <linux-pci+bounces-29373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA0FAD44B4
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 23:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C085317A134
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 21:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA96A283C8C;
	Tue, 10 Jun 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g1vrfvUN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053BD28314C;
	Tue, 10 Jun 2025 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590460; cv=fail; b=AA5SKxFrRl3nrwyb/00AWgcKhjbvzOTug5eu3zN69ZJwQR1G10H4uAZHCD4APNP/SNqGjMQo/AJXQrVf+prKJ1ffhOaMyufh7M+oHICD/YfXs9Lnw7DwDSRSM1s/9YuQmagMtldoh/fDNc3zEAoJ0bmn02IVjfb8nWKz4PxanSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590460; c=relaxed/simple;
	bh=3/gybv08tviGYGJhDTdztyaLMjXIl+aJCmMRG6eIKjs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+j6bb9IyA6vwBBWzc5BQKUgePQJ4CRVcVjQX/9qucHFPwjAI/mJsjmLacVf02U0DSBKM35HLyqLG5jOVqCWexo/a3zVmF4C4aynHafJxXYhf+GCbSNtzMQwarV+Wr7NNMge4CFDfw8pgv7RZfS1DfwSnVJRTlXKBB5xsH6YtEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g1vrfvUN; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgVlE2RRV9A5BuemO//4ECY44UprUIubdDtwkprAEGbHbQkDza2pbjWCoO8MJ516hjr7+rQIrXNPXyylcA4GBB7BReg+rw89cUsDgOUkXnsCby0p1ORNBOXQWjA3K8LGgvJSuVk2cFm5+uwVrsXLQAgoO0OaijKh4uzEwPBs2GQTsiQaN6aGKASV0CAwaJhgz5a+Z3LGE5hKt+9W9+Poyfcps06tLiI09lnb8RFN4j1dPbXOGeEkKi8OsmWYwLyrk04DiTImNoRj2RlGUmye7V+cy0LFZ6s80WZUP7oElDL6paAqX1/Ca+k4ZeF9a8HI4AR+lmeFEx91NT9kGDpYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ8Vi5+KmCK7MgZNOoFUMOJQAbXkZzJVWgg98oPaJ6o=;
 b=UKe0cf/N7LFzip3hlhVodlGvwI3Ptzpa0UFegniN7OhU5CwVcd1y6DGaJgbqve+ziGDJGMXHF5ELHk25OHZUNVW2+d4vQ1ZvEpXn4o5YJGlB4QlE8omBwgsMmh9U0GVlOQUxiQi5weM8dm2FUy9ZHX9KIG1DCZulKFNs/Oq1HzTaIna7LZU4NBlrCRgAPpvH5K9dEkN8umhO3gwVj9SJEJYCN7dGOH+rFgPRFWflNeBw7Ef/R3V8EViFHcCPSZZR+Q8fJjwKNjR0V3S9ENVu30XgmzppXlo46KTDsvQIkbwDGYFkkCfSSGOWyErc2HS8ODBXw7PC3RhKNS1BmfKVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ8Vi5+KmCK7MgZNOoFUMOJQAbXkZzJVWgg98oPaJ6o=;
 b=g1vrfvUN5LjDQ3U1kSlpRRWKc7H/H6BMFlrHIMZ4IZFdDtPfWkPHw3OSZOVcaM9+qcZ4Bfx82UFTkY+tAFo2qoZNpZNWJ/58mX4aX4FNsBWGcENwJiEA7lE/FMx7z5wNGqWViVT8zcI/kxp4qxKJYYNRjdIROQKxqxdpTLMweVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 CH8PR12MB9742.namprd12.prod.outlook.com (2603:10b6:610:27a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 21:20:56 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 21:20:56 +0000
Message-ID: <a602603b-e075-46a1-a4bf-3653954faa08@amd.com>
Date: Tue, 10 Jun 2025 16:20:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/16] PCI/AER: Dequeue forwarded CXL error
From: "Bowman, Terry" <terry.bowman@amd.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 rrichter@amd.com, peterz@infradead.org,
 fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-5-terry.bowman@amd.com> <aEexYj8uImRt0kr9@wunner.de>
 <aad4372e-d73b-47f9-9736-31dc1e6e03b0@amd.com>
Content-Language: en-US
In-Reply-To: <aad4372e-d73b-47f9-9736-31dc1e6e03b0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0062.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|CH8PR12MB9742:EE_
X-MS-Office365-Filtering-Correlation-Id: 79fdd7e3-172d-4d16-bf70-08dda864b040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHF6RVdEWDBtZkNzRW55elpwbjliTHNYaGhML2o0MWh4YzZqWjNUT0QweGNl?=
 =?utf-8?B?OHpJaHprTFFrb0ZwUm9VVS9TdXBzQkVVQll3aEpiMVNFdnMzTnF1NkxQOFBD?=
 =?utf-8?B?UXZuM3NqSjl0RVdycmdpcWZnMGRTSEtjZnE5aDFjQ3Y4ZmtHNExQREh5djhj?=
 =?utf-8?B?WTdwOE1oZHVNOVJXYnY1WnRmUDBydU4xemNYWnIxRXN6UHkzTnJnYzNaajB5?=
 =?utf-8?B?NEJxbGFhS2hETG1VZ2JiZks4dE5pajJpNGxIaytwekgxWGlMSTNZUnpJSDJT?=
 =?utf-8?B?UmFXRWZPRmR6SjFNdDQyc0pTOTBvZWwwVnJnVEVnTURyamhYQS9pL25tNXFp?=
 =?utf-8?B?c1pDSHMraDZWTVFRaC9DeDhFUWhvUjNLdE1RMi9NaE54V0p5c0pFYUs3ZkNX?=
 =?utf-8?B?Q1VuaFR3OERncFIwdk1xZnZaSnEzZWNsUVZERTNNUnRtc2ZmeERvSVFGMjRa?=
 =?utf-8?B?dmc1dGIvWjBkMVlsRXg5anBybFcvV3BWMHJNTVI3VmpkUmRHaXpERHFsamFr?=
 =?utf-8?B?dzh5MGlta3ZRbEprNUxsSGdwMXN5L2VFcC9URGVvY2sxTnZ1SGxuMzBJU2NW?=
 =?utf-8?B?MHlKS0x1MSsxU2pkUVp5N3BoQktaVTNTeHZDWm50SkNROHZibStVaFo3a3Z3?=
 =?utf-8?B?YjdoSUZ6aDhnY3NqQldZaTJXWm5CblVWd09RZWVWVWxIMzY2NGw1REdlTDBJ?=
 =?utf-8?B?VkV1aHJYd09VUUx2b0o3Qm1VNjJHMGNEdk5nU0FvUS9lK3h2N1U3ZEg3S1hJ?=
 =?utf-8?B?RitQYVFOOWhYSytnTlJNcDl6dTdqOWt4MnpqaFJBbkdRK0FZdUhvUlR5R2dL?=
 =?utf-8?B?WGhWS0ZVK3hjVlNnbHlIZlNOT2NtalZSNEYzVlErWThkeFFDZXIxMXVGTHJW?=
 =?utf-8?B?VnFvcytiRkdnTk5QMDEybmgwbUVjUFZCRTNCTHV6TVhBcFd4bFdWMWNVSVNr?=
 =?utf-8?B?eFRSQzZ4ckk5b3BFWkpSMXgwandxUE1lVjBrRVIxQm84elhKUVBMYmF1L2li?=
 =?utf-8?B?Z0lVcGhKbldpWllLODNRWk5pSVBBcjZxUStWTmRPcy8xcU5nc1BEVHF3alJY?=
 =?utf-8?B?cjZKTDBCT1lLeUt5OGJWcWJ1dFprV2hEYVB1dkRuMXo2NFAwVzFLbmxKZTZn?=
 =?utf-8?B?K2pPZGVGdW9zWHdiOUNBMlYxVklmTzUxbXVUdVhoRlpQNUdFY0RXMVkyNE9K?=
 =?utf-8?B?VVhXR0dZbVRqbFlEeU93aWwwdUFoWXJVekRQUDZBSjI3N2kvS1ZNZGxEUUM5?=
 =?utf-8?B?RitvN0QvaHNyTXBzampQUERFeU1wU1pHV1ZWak0yT3hxV2I0ZFF6b2VTOXN3?=
 =?utf-8?B?TS82M1BYU29hMDZEL3Q0MmVVM2h2Z0NsYlIySk9OS25WQ0VQZU1sZ2dNd0xz?=
 =?utf-8?B?YU5tNkVudHliQ3J2Q2xSRzNtOW53N295eHFlek9nbFpJN1J3YmIrVGorY0dJ?=
 =?utf-8?B?NTZ2dlJacXRwSUFHSkd2VENoaVBqU0NHZEtub2FKYXlVQng2VzdrWGR0VjBP?=
 =?utf-8?B?YzYwNmhkcnZFNkQzSThORjMzckFVTWJIalVnTzdKMzdtMi9BU3ZzT1hmNHRt?=
 =?utf-8?B?RlFSZXRpMHNoNWRmV0g2amtveTJXWmNpS3JPZzBGT2o5di91MVpCdGpkV0Fk?=
 =?utf-8?B?Q1EwLzZvT0hseHZtRUMzZmk2U3ZxNE1wRFFUYnFsaFBqblc5YXF0MjREQjdC?=
 =?utf-8?B?d29mSCtwcTcwQVl2UzJhdTBpaUJZcnJuWG5ETy9SRGNGRDV3dFNsYjVzUjRO?=
 =?utf-8?B?ci8ySnhLQ0FUUzZKWlJDcHZiVlVpZkZsV0k4NVQwVTkzY2RURFA0bkd2Z0t3?=
 =?utf-8?B?L0xwOG5JQjFML0Y3V1VPL2xWV1VRMVYxWXJwb1Vwa1gzdjVPcUxHTENhY3pC?=
 =?utf-8?B?OVFGLzlFeS91UnBCMkJwdTJkcGk3VG44TEEwcXkvb1hlTWJKdDdhL1UrajNF?=
 =?utf-8?Q?LOpp73ho924=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0syNTNSa0dGdGRrSVM4cHQ2MENvYmxPd0JyYm1BOW5OYnhYZTBESzZFeWt3?=
 =?utf-8?B?N2s3elFOT2ZDWnlyK3ZVazBNd3o0cHpqN0pTUXB6U3UvaG10ZWIxVS9qbktt?=
 =?utf-8?B?UVo2K0w5QlcwMHR1Mld3bG1iaUF4ZXpKWlVTZ0dNYXpJbndZY1Npd1RPSnVx?=
 =?utf-8?B?amlpMEltUzR3QjZjLzMySmlRMGswTzlwZWpmb29OQzlNNDVvK1Erdmt0cFI0?=
 =?utf-8?B?SGgzTGp5bmtCM1RBWmNqNGZ3aktVN08yb05mZmM1Qm00bXNRNjRlMW1ic2cv?=
 =?utf-8?B?R2dYTWJwaFlxMlkxSGgvcDNjelROMnYxVWR6aG9pU2FWTXZaTzRRYWw0VUZZ?=
 =?utf-8?B?ODJzYUtidVFhNnMvYTNudjFTeGNkRVZyaUJGQ1VpUWhCeHBFWHFCKzhWUFEy?=
 =?utf-8?B?eU81NFlNL2paZmlrTkZrME1vWG9vNUY5VXMrWVorODFucVEyWG42Nlk0aERU?=
 =?utf-8?B?TSt5UWhEVG1tSEw2UEU0WHpSdjltSS92M1lEYlo1VFBNZG1kTFNHYml3dDRn?=
 =?utf-8?B?aVRXWlFRalRMQldDQ1Awb2ZBUlZwU1RLVnVvMlBHR3QvMEttZkJrRDV5eFNQ?=
 =?utf-8?B?WFNJUjRKWGlHVmM3S2hFVS8xRjhhbS9zcEl2UXVYQ1I4WXlmRDQwQ0xrZC9V?=
 =?utf-8?B?Rys0clR4V3pQdHJYNDRWbUk4TE9USFhIemU5d1IrRFN0NGxMV05qcWZGeThS?=
 =?utf-8?B?VTY0SFc2UmU0eTVOTDdyQmRoMTVBWENsblJvKzlVWWg1SWl3VCt6ZzE4S3dx?=
 =?utf-8?B?OVB4ZnMzelpHa0FJM2ZtVzhiNSs0bzlkaVcyZkdEQ21XZU1IMS9jdUdFTnBr?=
 =?utf-8?B?ODdjLzJEdEtSaEgxV25xTkd5UGZQMGF6ci9KbVZiSzVEb2NQS20yRzYzbEdQ?=
 =?utf-8?B?K0d0RW1HV29xSzh4RWVrOEFWQTZlYWx5TnRoMVlyWkJYYlovNFdGWW14aU9s?=
 =?utf-8?B?SXo4L0NxNFR6Ry82ajUyZENQeENVRFYwMW15bk9GR1FLR0lLOUg1bEpUV0lT?=
 =?utf-8?B?WFk2V2x0cHZpbW9BT3p2MXR4dk9sc1ZTM1d5TXBFVVUvOXZod2lMeUxncjZu?=
 =?utf-8?B?UUZYTjFBQ081bVF0TjRJNk1GRnZmQ3g4a0loblAvdjBSOXRJNmdOWGRJd2Fx?=
 =?utf-8?B?b2xGLzEwam1GcjcyZk05UlhFZTFzcjFvR0FhUHltRVlOOUZHdUNoaHhJWm1S?=
 =?utf-8?B?L3lHSFpJenhOTkwyU2lqSHBYVE16Zi90SVVsU3lnNjFjajZvNXFXeFJab0Z6?=
 =?utf-8?B?bDJHazZSM2svR3ZQckpHdUtza3Z0c3lqVkNWeXJhV0dKZkxlWlhlUWdzMnJy?=
 =?utf-8?B?YkpTWHBqMVFlLzRnWTdzOTVpdForRkw5bXlqYytkVHBXT0E0NUpnQmpLUStM?=
 =?utf-8?B?Q1dGM0VienI1aGNua2NaaVhkWU52VkJwMGVRTk9zUFg5MnhZMHY1RVp5Rzlo?=
 =?utf-8?B?SjN4cXdZa2IzRWEvREJTcVMvUW1hZnoxblR6REJlclJOMnhIN3c5VHA0S0ZU?=
 =?utf-8?B?bkNTRVc3dFdJQzJuT25WMlllQ2k1aTNzV1dkZVRBSlBjTm4vdjdQVitkUnBv?=
 =?utf-8?B?WTQ3NitpSkFSR1RMTiszTUk1bDJTVmhMWGsxaG1URzNqdWJ4b2tNTDRrejE1?=
 =?utf-8?B?MnVDbUJ0eXM3eEsxNFJtT2w5Y1RZOHA1K0N2NGZCUFlkZDBUa0c0b3poOGRr?=
 =?utf-8?B?TytsVTZVQzBpQ0sxOW44dzFPSDM0QWVKTkI0THZlUjczdmhvZDRqTTYvL2xX?=
 =?utf-8?B?aFlWOFppRnlTNkNCTXA4Y3p5RTd0V1hid0hDTzd3a0NZeVljQ3A0NU8ybkR5?=
 =?utf-8?B?Yk1VL3lHOVhQN3o1a1poZHpUSnZOcFkxUUU4NXNoYWoxcmkzYXlkZ1FnUlBj?=
 =?utf-8?B?ZXN5eURybTNTVjRtY0Q5VE42eS9Db3RmTGpWZE9IQXFBT2tybXZ6eVhWL1JS?=
 =?utf-8?B?b3FJLzRrMXJRWC9WakNZaGkveWlWUE5RVk55ZWtqZjhub2NxRzdTRGZiUkNk?=
 =?utf-8?B?V2tlUXRhUXhTaFlZQWNNSms4aVBQN0hhKzYzVVoweWNiRnhQbEppMER5U0tE?=
 =?utf-8?B?V1FyZXc0c2NOOVJoK2phc1pzRDVXdERtNVdCVk43TktrTXhoZkZEa3cwMVZZ?=
 =?utf-8?Q?vatztyNoB4WaO4Fb0Lt5Nyv1/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79fdd7e3-172d-4d16-bf70-08dda864b040
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 21:20:56.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1IacE7teSkZIExg+LKUjOADZnnDEQShUi4Wjrw4/yk68Gft24IwlgjuG8RnbULCI5tqH/rfaQTA9RbpiM7wEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9742



On 6/10/2025 1:07 PM, Bowman, Terry wrote:
>
> On 6/9/2025 11:15 PM, Lukas Wunner wrote:
>> On Tue, Jun 03, 2025 at 12:22:27PM -0500, Terry Bowman wrote:
>>> --- a/drivers/cxl/core/ras.c
>>> +++ b/drivers/cxl/core/ras.c
>>> +static int cxl_rch_handle_error_iter(struct pci_dev *pdev, void *data)
>>> +{
>>> +	struct cxl_prot_error_info *err_info = data;
>>> +	struct pci_dev *pdev_ref __free(pci_dev_put) = pci_dev_get(pdev);
>>> +	struct cxl_dev_state *cxlds;
>>> +
>>> +	/*
>>> +	 * The capability, status, and control fields in Device 0,
>>> +	 * Function 0 DVSEC control the CXL functionality of the
>>> +	 * entire device (CXL 3.0, 8.1.3).
>>> +	 */
>>> +	if (pdev->devfn != PCI_DEVFN(0, 0))
>>> +		return 0;
>>> +
>>> +	/*
>>> +	 * CXL Memory Devices must have the 502h class code set (CXL
>>> +	 * 3.0, 8.1.12.1).
>>> +	 */
>>> +	if ((pdev->class >> 8) != PCI_CLASS_MEMORY_CXL)
>>> +		return 0;
>>> +
>>> +	if (!is_cxl_memdev(&pdev->dev) || !pdev->dev.driver)
>>> +		return 0;
>> Is the point of the "!pdev->dev.driver" check to ascertain that
>> pdev is bound to cxl_pci_driver?
>>
>> If so, you need to check "if (pdev->driver != &cxl_pci_driver)"
>> directly (like cxl_handle_cper_event() does).
>>
>> That's because there are drivers which may bind to *any* PCI device,
>> e.g. vfio_pci_driver.
>>
>> Thanks,
>>
>> Lukas
> Good point. I'm adding this change. Thanks Lukas.
>
> -Terry
Hi Lukas,

Looking closer to implement this change I find the cxl_pci_driver is defined static in cxl/pci.c and
is unavailable to reference in cxl/core/ras.c as-is. Would you like me to export cxl_pci_driver to
make available for this check? The existing class code check guarantees it is a CXL EP. Is it not
safe to expect it is bound to a the CXL driver?

-Terry



