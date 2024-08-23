Return-Path: <linux-pci+bounces-12121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89F95D1A2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CEF2855C6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B92E186E33;
	Fri, 23 Aug 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C545SXX+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D9718890B;
	Fri, 23 Aug 2024 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427393; cv=fail; b=fRlNizKEFgsuijrZCKNQ2vIGNjbebtEvVEDh/M6gZbJmPItJSNlevf1OmcfMq8ekxI+No03JFHppEtohyIrmwC3IiPPPJQ6fFVIZs9tWQDAhWGeuDEX5kEMKrhzzZ33s0Enqqd24U/QKtpl3PUmFlofUdka7erXH7sxJlDPlN6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427393; c=relaxed/simple;
	bh=GM4wBPfzt5qXzSjDeyh2jKZ+/gpUuqBVgUOHtpsKegY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HqbdEmNCPFbck2XAaG2Sx8168GX9KwE4iQeCFlxj1gqmRqQW2Ii5/ruEa/8OuBNkWBMO5si3RMpRXuyF2czDKexgvJ9/djIsYH+qCKAy6TTElV8mrx3veKd7koHyRvaG8n6mS4XuVs2FVSKAMre1vxIzeKjDSN2yr1KjwwgQ4po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C545SXX+; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDjoZ7yDed9zMnDsS9rMFfY1Tw/31uSQ7IPBnJSufWuB/r0kq6ICO1puQvfQaCR9+a0IFPokiDxrmHyFEaDGkq7WdlPYgAKjfWBrfx9RTQ3jaIpKQG6YVnQt/2EkuQCeTNaLxWQrKp8GjxGPJIv0bkmsnBHxhGLnV9f0jY7qZu50XZxrC+0RJ36vj/FZt3DSe3Pgrn22tymsKdqsum3+x3fWoPxf5rk6DQlsSJEZ3ymsvxSakKVZ3o1kkIr58eC39B4d4IqagQw82/iapwWa3KQoF0oi1bDxiY2wzyUjettjxcBSon01SrLUkFVv156qKbPxx+rTTJCQCnn7zdsnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii04TsounDUf/6DkAyfaIAlf9E0Jtrr8QIds4piVqxQ=;
 b=gexRl9N44dXa5WgByCSU8KTTasZ7oZTAvT/9wv4dXbY4CtyA2tzw/NBuJtZu4onFf8om9u0VtWgGih7VuJ7BDfdiT397+uBjEw2nj7Yx2WlB0VnKAfC7tEjBxE/zFNRsuOv+RL7AxSMb3kMSZIVrJBMuowzwmCqQyY7ieYJWTv0sL4xU9tc8QjBMkNpgJn1Bd2IKSGwgw1RC8huMb5SVYwiYITo4MerpULTPIfrLWwT+vVjALVF9I50wJrVZkQcIN2vA8bGHfKzCJRHBhDxE9uS1kNb+yCCib56ckHDk5YAP4RmYNtBNb8GWxdJqvnDoo0F666qmSda3bPJDtI8lBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii04TsounDUf/6DkAyfaIAlf9E0Jtrr8QIds4piVqxQ=;
 b=C545SXX+6G2JQEfKAxf2jdgqg/59cQW36ZjcBNmTScXHAIl2QiggwpeV/7ULpQW4IrC3OIJVHim3KoU75qNLAogMgFLZzcuV1s2xMdl8N6Jjq/qBzD2SMyKMwi88tujnpDmXJnJb7ntdka1FCg4PHrkA5UjNS1VUiNHHqmjtHHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB5960.namprd12.prod.outlook.com (2603:10b6:8:7f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17; Fri, 23 Aug
 2024 15:36:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Fri, 23 Aug 2024
 15:36:27 +0000
Message-ID: <e5ca4c50-f64b-4a1a-82bb-f87a43020f7e@amd.com>
Date: Fri, 23 Aug 2024 10:36:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Detect and trust built-in Thunderbolt chips
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, iommu@lists.linux.dev,
 Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org>
 <6da512d2-464d-40fa-9d05-02928246ddba@amd.com>
 <20240822155329.GI1532424@black.fi.intel.com>
 <54feb448-b8b9-49ca-bf29-02b9884c048c@amd.com>
 <20240823050120.GJ1532424@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240823050120.GJ1532424@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:d3::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b86d5d-90e4-4b7c-bf13-08dcc3895a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFFjNmM4M0pJalpLb3NDbFFzS1ZBWEF1QTBUNjBQOFYwc1ZVNGdic2lYb2Yr?=
 =?utf-8?B?Y0lnRGMzR25ia2tWVnhqVXQxYkhKYVFxc2w4a2JIS3BQa1lvazJnRlh5R2V5?=
 =?utf-8?B?cSt3RzlWV0VhV0lpMmJIME92ZzRDd3VLSG5wRy9GSnBrY20vWGFtaTlzSEl4?=
 =?utf-8?B?Vm5pRTBqR1FwVFFXYXF0MS9Vc2UvbWFDUjhLZHNicEpmcnZBcXFWYXhVc2Fy?=
 =?utf-8?B?eVpzN3R1SnNOQy90TG9FUDdqTGg1c2NuM1gyWE1CZ3hrUFhnVkM5cDVZNlhu?=
 =?utf-8?B?K1cxbDE2eGtOS0lmWXhVd084OWdtMEljcXBZUDYxdE1LYTd3cjU1eTR1cVR5?=
 =?utf-8?B?UVo4YlVZSnhkUHAwMWg4OUZ5TXZ3dmsyaEtzaFJJcFNPR3ZYbVFvSEtwWlVS?=
 =?utf-8?B?eThQNW9xd1FLNFk1UHlwUlB2UVdoMHlnYjNoa3ZGWGtIYUFGWFcvUHQ2NlUv?=
 =?utf-8?B?cjROaXU0dVhzdHMrdE95VDhWVHV0TDVyd1dzd1FTSEJnVmlnWUsxUThVaFcw?=
 =?utf-8?B?OXNqQkZUblJKYzdHek5qbW5NMGRjZFBmcVpYc3kyM0lzeUR2dXhjYzBpVUZC?=
 =?utf-8?B?bXNVMHROMWx2bERodEgxT3pFUy9BRWU5RXRmdkRFSngrYVZvRnpwdG15N3VF?=
 =?utf-8?B?YVgyTFIrRnJxcmdRT1VCRlFiVFpadWRkSkNIbzdtMDUxb0pYc3JwdElYZjlw?=
 =?utf-8?B?Zmp6VjlRcDBITnFLRXl1Qi9wRWhGd042WCsrSlpmV0hvdUg4UW5rLzVJRnVr?=
 =?utf-8?B?N204RE9RdS9FUXN1eHdUNjd0SGY2eWIwYk4ydXV1SExITGthSzludEJHcUNY?=
 =?utf-8?B?NUp5WmR6OHBNUkMvZWVxRk5yUU1NT2JkaG1VM2MyaENMV3B0R01UVjd2TlVY?=
 =?utf-8?B?MnBXZFExT1VBczlPdHBkVUQzZmF3aHZwTFNIY0FkNllGR3J0NWZLVCtpRFNv?=
 =?utf-8?B?VVR5S3ZEdndzcnpXRSsveXRlL2J6dzdKcXUwQ0txaTIxV0pNWVRzcmxmUHNL?=
 =?utf-8?B?bUN5QmgvSDYzUms0M0UxN01iOUo0WjFEcUxCMzFQeVpwWFlMY3dQSlEvY044?=
 =?utf-8?B?ZEtvUUF6dFNLbEl4Mk1ZUEE1VXNpdXdQT3JIa3JUaE9Cb1g1RzQ0REt5S0l3?=
 =?utf-8?B?Y1MrS0JabzE2NEN2SGJtbFUyNHV0NWlQZjh5N0tOTjhzT0I0YnNSTG90TkY3?=
 =?utf-8?B?ZE9mOC90Q3hoZDY1K25idUg1SWNwK0laWjFGd1huVUpwaUlDR1lGQnYxQ1BK?=
 =?utf-8?B?RVlZYTZzWmk5SktCcnZtbGxvSXIxL2NZVmlEaWp1Rm5iZzNJTnFva3BUVEVh?=
 =?utf-8?B?RXhldGhlUy9ibDJ2MnJNMGRzMW51Rk1aQTRGNFViR1c2M1FPWTBuRzhVbjZj?=
 =?utf-8?B?emd6aGgyNWMrOFlmdDMwRmtyQkpiUlF2TnArWVhrUXhZVS9QQXJuYWE5TjNJ?=
 =?utf-8?B?ZkpFNTZsNitWbjVJTC9VaElhYW5vK0tkMXV0c0hIOEsrQUU2VkMvRkxDZXc2?=
 =?utf-8?B?RWVpVkVmNlRzQWkrYkFwd1Y1RXl5Z1MzbmtZOWNWQmRnaFdSTG5rcXljVEhZ?=
 =?utf-8?B?bkFBTDJzOUN6ckNuamluVllsTGVRak9WOWlRejE4bE9JV3ROT0I0Zkk1Uktq?=
 =?utf-8?B?U2pVaEtwUE8xNUs0YjdmZVB1V1JrZjVWUW0yVE9JVEJtMks4a29UblZvQUw5?=
 =?utf-8?B?aW5lMDRndVdNOXFaLzFhRjhGa0NkSlYwa3h3MnhXSHRpSVRhSnJyUWNHM0ZB?=
 =?utf-8?B?cUFoMWFNS2F5UnBFKzg5UkpZNTZZZGQ2Umh2YmtxTENhUVZCTVp2SEM0RWZS?=
 =?utf-8?B?bFVtejhwOXAza0daSU4wUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YytTQk9jYVpFMzZIZ1dLYVpiRVlRRzBKell0cnIwV1JVS2YveWkyR3gwTGJ1?=
 =?utf-8?B?T0dTOERhckYwZTltZjZ6MlJtNEZiNDgxbkVPSTNTU0c0cFcwRjN1Z0l2ZzZ4?=
 =?utf-8?B?d2UvTmxQczg0V2pEQWw0K2NLL2xOc2lQZjl5LzJHMng3QzV0T3VhTFJEZ1Nq?=
 =?utf-8?B?TXorTlRzbVJJeDVFUWhnQW1lajJPMXBMYlFrWE9MMG85TkNncHFrNTRzKzJO?=
 =?utf-8?B?dVg0RjlUYjluWGtjM2JybkFrdmFyVUMrUXkvVjdkUkdjTVlGSkwxaHQ4TkFw?=
 =?utf-8?B?czAxdnFuRnpTSERLeTVpdVBkVm1Id21ySjNDUHk3eHNWZjRzNG1EMTg1Y3Nx?=
 =?utf-8?B?Nm9oRVl6WkkrY2VqZEdmS0l6S24venBLTGtrOGphS29pY25rRVp1bElEMTJm?=
 =?utf-8?B?K0lnVmhNL1p4dHJhdGV1Y09qUC9majZ3S2VkYlZUaVNNTGcxNEFXVGFlUUNa?=
 =?utf-8?B?YVI0bHdWQVZjWTl3dzZiTmd1RFczQmRRVXFjZ0tFY0hLMHpFOVU1NW9vTldx?=
 =?utf-8?B?dkhSS3RjNHhjNGlVSUVUZk5rWWVLcm53OUFxSHI1NzlGZVQzTnNJWTFTZXRU?=
 =?utf-8?B?VUxobU5wbWh4Sk9LUHAweUxpLzV2SXJtZGdvZWhSMUVOTjVSM2lOck1odWd1?=
 =?utf-8?B?Y1VEeGh3LzJUZ3kyc1pHUTM0eGlGdVRhLzlrbU9HUTRRVVRwWGh3VG12UDh6?=
 =?utf-8?B?dHNMUFM4OVFGcUVSaHUvcFNVWWNFOWMrZ3JwSTlaZkpZTzhSdUFKWko1dFUz?=
 =?utf-8?B?WnBXdVBsd0JyS29yY0dOeWJqVTI0SFdqWkNCSnl5U0N3Z0N5REx3NExlRjhO?=
 =?utf-8?B?K1dNMWUwMjlFR3V5TGFSL0FXNy9GeG1RMmZwckZWV014SHBvL0pkKzd4QWhn?=
 =?utf-8?B?dE9rbktnR3VUa0NtT01HZGd3d3VMcG9UYjRsN3NDRkRnQ2FzbCtIbzZ4c0V0?=
 =?utf-8?B?RHVFNllJSWMyQ3hMK0p3RkgybVFnTnJ1SnBJd2lLQ1VNSFhma0FJSEtlZjlO?=
 =?utf-8?B?RjYvMTRtaEdoWHI2WlZPc2o3UXpCTjVtaEhWeHNCK09jS0FZWG9jbkU0a2VU?=
 =?utf-8?B?Ym1JbEw5ZGUyMFpaUnJGZFdmTjAwYTlicEVOSVM5Zzh4NGVOY0xCSHRNczZt?=
 =?utf-8?B?eGlqUFRqYlR3TFN5V3FacGErVm5NaUZSTHpaV2RnYXBPc2lzUk9QaVFKT3o3?=
 =?utf-8?B?QklWaFdsZzh4U2Y4OXJKUmkzd0pZczF6YkxlZXd5VlVqNTRoeXJuRkUxMXly?=
 =?utf-8?B?bzZBalhhVzFxcXZ4MFBLeVpzUzNjMGppWUNod3dJbnZqdDcyZlJIam8xcDZK?=
 =?utf-8?B?UUxyRUQ5RlJIU1piZDR4YW5sN25oTUVOQ1lhdURsSGdLVmltUE5uM1BoT2Qz?=
 =?utf-8?B?ajVOWjc3SU0yZzRXQ24wU2tkVU9zMFFtb0FUUUcrS3pxSDJsMlBWZnRFZHZN?=
 =?utf-8?B?cEE2NTFKekFJcHpIZ0swL05VWmRBbWMyekl1Y3ZiWitqQnBWZFlLTzR2Vkpp?=
 =?utf-8?B?MlZUYlNMYjk1V1k0cVJxd25IYStOSTRzQWZXT3JqbXZxejdHU0dqQlQzc1Zy?=
 =?utf-8?B?UUJyNS9mdXdwVmpMRUU3bVozRVlSMElIVlBsVVNnL2VzTVgyeG9rUzNLMFdG?=
 =?utf-8?B?U0ZOcTFJc1h4dVdBaU1pbUxOSVpBSHhhRUZWaWRqNHdXSDdROWVZbld2RU9k?=
 =?utf-8?B?N0cvQmdNQXhlZnR6eDJoc1pFNG8rN1RBR0E0N2xNYm9jdHk4Y2d0VXl4eWR6?=
 =?utf-8?B?MlNvQU1wZ0lhWm1oOEFsM3dwUDFMWHlQdE1sM01GVjBaOGJhV1hmR21SOEtq?=
 =?utf-8?B?b1dSbmRtTks4RTNidFcrdjFMK0Z3dE4rS1pQank3aHdDbWxYYkxzYVRXOCt0?=
 =?utf-8?B?bkRmU2pPUjcreC91cUE4Ykt6Z0FyV3hpN2liV1RRb3VKRmkzSkFZam1jVUpF?=
 =?utf-8?B?b1V2UzFaVUtSQ2Y2YzEyYkNYYzRMS0EyUHlZZk5RQkFUd0RMSjlORmNBTkxj?=
 =?utf-8?B?RDljcjRlYjJ2bmJHLzVaMGx1NFJna3BJbi9VQWZ1c1pRQVNQbGhtdFprcnFJ?=
 =?utf-8?B?ZENMZHFuajZDRzhXUjY4a2kxZmhDeHNFeFVGOXp3clZpbGFrbjFPTEhQR2Zq?=
 =?utf-8?Q?5Uy5O8ISnA/K0WT4+SFK6ERpq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b86d5d-90e4-4b7c-bf13-08dcc3895a3a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:36:27.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hnCTZk1KY2epkAMQc1lLwDjM76bxJQ3hf3MxEiwDTtZqsmL9urM6SpYc4RVig2CQfmotct8jv8YzM558Ry7mpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5960

On 8/23/2024 00:01, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Aug 22, 2024 at 10:56:44AM -0500, Mario Limonciello wrote:
>>>> Here's the snippet from the kernel log with the patch in place.  You can see
>>>> it flagged 00:02.0 as untrusted and removable, but it definitely isn't.
>>>
>>> Is it marked as ExternalFacingPort in the ACPI tables?
>>
>> No; it doesn't have an ACPI companion device.
> 
> Hm, how can it pass this then?
> 
> static bool pcie_is_tunneled(struct pci_dev *pdev)
> {
> 	...
> 	/* Internal PCIe devices are not tunneled. */
> 	if (!root->external_facing)
> 		return false;
> 	...
> 
> Would you mind adding some debug statements there so we can see
> (hopefully) what goes wrong?
> 
> The intention is that pcie_switch_directly_under() is only called on
> Intel pre-USB4 discrete controllers (well and Maple Ridge as that's
> still using the Connection Manager firmware).


Ah, I made a mistake on my system and was mixing up 00:02.0 and 02:00.0!

Everything is working as intended, thanks.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Mario Limonciello <mario.limonciello@amd.com>

