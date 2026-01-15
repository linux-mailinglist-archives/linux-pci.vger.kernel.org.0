Return-Path: <linux-pci+bounces-44986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B53AD28556
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 21:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 517C7305133A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E268725F798;
	Thu, 15 Jan 2026 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8HGt+Tk"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA831DDB8;
	Thu, 15 Jan 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768507876; cv=fail; b=AiTl2+5gYaEmTNz43E8Yl8Y5uxveT5iBOpnG41qE+QIBBo8gi22CwXHfb29t7Ub0K7z4Xu/HuNaaTpJ8sxChDz9gew3fSgl0ssfQgE0BuCQ4VK9tMMsRgIoOukrvABT7Cv3GN/DfMvGhm/Cq8Q35bWv3rptH4pZo2YXXaD/usGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768507876; c=relaxed/simple;
	bh=jTfqkQuAOMuTOEXtkvYZgF5EhP40I4lpEH6Q8YVI40o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=doTQUL6N/BkLNtEHDE50NlJq6m5vlUt2BIFShthy0FaoL8JxD5u+CbDXFacuBmvpTE1Ny6451yifakJWR+W+TB6yzAfp3gwZgFGEETJeJcrK7FGGqJRf6XUrWyes2ZKixxG0zWA/j3+RBSBZk6O2EZKG2xsK7OgXH1iueXG58y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8HGt+Tk; arc=fail smtp.client-ip=52.101.46.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki/5ZQOu24rmiIhOaq663hmrta5fRS0w5WLJWSyN5FpVO5n2IuXndMWaEI80HVV+tE9AHLzlK0sC1QNlPNs6bGxrAcBVYVD48R+EVxfNivtzYJ4+S4WmOvtbvBMbGEgAa9jot2XlRTjHaOUyZvQXlsIe/azdYTDa5ioVrD0IrbY0DXOTXKBUY+8qYFoU5m/9pOtRYRcu+QKM92pNF6JMVkeuRWQTLcpV3Zj2c3kDAlmmiZ0b7lNpJWKBTO+YMV3XtkMGmLeqQoK36bjle7lQ+VT3VMiVMIHe7+MhGhum5H2ONBjn3ty+kbImCDN2i/2A2TVY2F/3MU8TSuB5OYjVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xI4pKJ0n2KxJSNU5FAVr0pZTi/4Sp065Vx/hq/kyS4Q=;
 b=E6I+CoFNq9JuR+Mj/C2D2xwo7nb5XxG4UnmjeE2DhfkWOh6d19iW4l5kHNuw4ewbSXug7AhaDexg+L/1zzQnAMsh4nm3Z4NokRYyyL//BKLttSoxJXW+ADMcK4wXfm95TzEzFycJhUQSFqipupKf7W/rsG/rsnGbvwCTutRag9lNdawl3p63LVnVh13wZiXY8XlAj53/le7szp2+DHROKbwPKm58Voa8x9d2iWDd3iHN1LXkf8+zQzHnr9mCseHIY7deE5HNCDNeubFcIDuNOYBVufIGa6Ya3zBw3co6ZpDbFNDpRqmwzdNqxT9427ea8l5H83g3mQ6KPmAdPNU9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI4pKJ0n2KxJSNU5FAVr0pZTi/4Sp065Vx/hq/kyS4Q=;
 b=e8HGt+TkqxlJcgWfChXRFmRkP77lVXce9n44/JhHTfTFjA0GhUl5Esim6N3yJ0Yh7aEaMVI5p/MBv6r5X9xc4XuWzL7NuosLJRGq+sMoCBunWRpsEXIihOBjpm5kr2BYc2kffralTjWtDYABEDh0h8P0TNho9UGUl1LYz9aHh7j52RLkn7P3MZV4KLsaG6NMSR7wBZLbFwZMS0jWReK0NewwFu3D3soaj3nZv122xp08lKyJfgTbSCYXMWV96UrCSS5f+yI8joSs+zBNNvDPQTJCwgjBMwTE4PgZrt2DIac9EWR5nj9ldgYeBBvRfKDaU0LXOrN1XGR3FxGZOx1LaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Thu, 15 Jan 2026 20:11:12 +0000
Received: from DS0PR12MB7630.namprd12.prod.outlook.com
 ([fe80::c81a:611d:7325:7744]) by DS0PR12MB7630.namprd12.prod.outlook.com
 ([fe80::c81a:611d:7325:7744%2]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 20:11:12 +0000
Message-ID: <db8fb91b-e132-4d8e-ab7a-d7954fc6629d@nvidia.com>
Date: Thu, 15 Jan 2026 12:11:09 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
To: Bjorn Helgaas <helgaas@kernel.org>,
 =?UTF-8?B?Sm9obm55LUNDIENoYW5nICjlvLXmmYvlmIkp?=
 <Johnny-CC.Chang@mediatek.com>
Cc: "lukas@wunner.de" <lukas@wunner.de>,
 Project_Global_Digits_Upstream_Group
 <Project_Global_Digits_Upstream_Group@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>
References: <20260114172832.GA822909@bhelgaas>
Content-Language: en-US
From: Terje Bergstrom <tbergstrom@nvidia.com>
In-Reply-To: <20260114172832.GA822909@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::28) To DS0PR12MB7630.namprd12.prod.outlook.com
 (2603:10b6:8:11d::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7630:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 0189dcac-7164-453b-9394-08de54723a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWdCNE5CaEZLV1RnanphVUhkek8rSzZ0M09pbkRWRVVZbVdiUFk1cFA0b0Ns?=
 =?utf-8?B?ZmRpL1ZKejI2ZFZoWDAySzU4T0lvcWdwQ3ByWDFFUlJPbW1zOUYrWGJPcVBk?=
 =?utf-8?B?OHA2VEFzZElLVWpPU2htOGZETElSR1dSSFhvVlEwM1VWVDd6LytyWDM3eU4w?=
 =?utf-8?B?VWowUmlqT1ZMa2VySTJ5Ny8xRUVKYXNXUllRb0kwZEtFZ0lOd0pvb0hLVXhI?=
 =?utf-8?B?RFhrY0hlQlJwV2NrTzE4RmtnWTNBQUI4RVFibVBXdDVSU0ZSMjdmZW5aZkY3?=
 =?utf-8?B?ZkxLZjJmNXJNckZOc3B4eFZGYzZVOVhaOG9DbU1xdW9IYlpYdlhrYnQ4VWk4?=
 =?utf-8?B?eWxtMlRVdU4vcjJPWExYYU9yRWVyWUU1bDJvTUJsdW80Um5Camt5R3hGVTho?=
 =?utf-8?B?dWdqMFFScDRVSWEzdVVJNkoxb3dMUFNCV2d5UGlFSWluOUtVcVFqRXhlN3dR?=
 =?utf-8?B?OVBCU05tdjlFQzJ0VkU0L0dUcklTWWJCRmlnVjQreCtOWDlBQjQyQkJlaTVz?=
 =?utf-8?B?dVVNbC96aUxzNkorekM4UnRkOTF5Z1Z0YTNhVGFCQ3lJb0NjaU1CaEYrQ2VZ?=
 =?utf-8?B?TjZrY2t1T0hBaTd2QjhtQmJYSTFjbk4ycVJKdlhGTGtkeDA3UXVhSkR2VU5y?=
 =?utf-8?B?YngxbTViTWpIc01ERWZTYlkzOUprencxUlpwR1ZPQVN1SjZ3MEpUNXh0aEtX?=
 =?utf-8?B?bFhxdTBuMW9rUEU4b0pMNTY5byt3cVFKeHRTdVRaWk95VkI2aGRkYjJqaS95?=
 =?utf-8?B?eTZnN3ZJV1ZTZjFuYmw2Y0kwL0U4amo0Z1dCR0t2TC9zM2xXeXlPa0VqbDJO?=
 =?utf-8?B?UVFkS25tcDlSRTBhNUV6dXNtenFTckY0a3hYdVdMQTdtVzRrZFRsVnBMZG95?=
 =?utf-8?B?blpNb2tiY0ZzMkdTdDBJK21HOUVLa2pNaVV4czZYSGx1dUZJYzB3UTIwbTZT?=
 =?utf-8?B?OEprOTNWa29WU0tBY0dnVjJMVE5vZVFIeDA5aS8yOFhKYUNOSDZETUlBSDVR?=
 =?utf-8?B?WjZKQVhYSG81TmVJTGw5WFJmTTh0cTZQTG55OEl0SVhrcWNhWjA1bEErenZR?=
 =?utf-8?B?SkdKd3dKZGRHQkpGUzd4SDF6MVY0ajAzUHVsSnc5LzFtWHBUVXJicXVlMk5p?=
 =?utf-8?B?aTJ6Tm5XVm4wSHlTNlpkZDZJNysvdmhsVjNzOFNwaTNpSW1XT0lVN3pLeW5o?=
 =?utf-8?B?RGpwTnBkdjZ2NXlJMktiYmd0dlpNV2lkek1IR0RscjNudUJGV0tUeHNHZHNQ?=
 =?utf-8?B?b25CNnFEaTBPT1g0MFNZaTVKeU5YWkNMOS9ncWJta2dQbnA5UGFTR2hFamE1?=
 =?utf-8?B?enZjZmovUDA1L3lUMTBza1VIcm9adlExQStxbG5iVzVOL1AvZUxyTDRjWjZv?=
 =?utf-8?B?UUJ4MDdsM1I0dDVxQmM1VUtZU3ZuY1NNY1NjUjVlUEtueDhLVm9hRk1mMUJI?=
 =?utf-8?B?ZjBEb3RVTW9FckpQUUVWSFVZT1gvWFlQTVd4eVpDcE50WUtGaUxRczRsRXhl?=
 =?utf-8?B?NFA1b0ZBK0EzalczcEc0eis1VnJ1eTBmK04yOFBoQWxVaTFSaVVxUENKRzNs?=
 =?utf-8?B?Z3lHQjNBTTRhbVNLRWl1SHk3YTdnNmJXemhwZTNxVjlYQzZybDhCTDNFWkc4?=
 =?utf-8?B?bmh0Z2NFdGpjWktQbGdJUGpsZ0J2SFBweUlpZUE0Q3NtT2lOaEVFUHRvVWhj?=
 =?utf-8?B?VmxkOGx1RFcrd2ppaFdYLzlnVlFFbElIamhMWkhPM2hFVjNqMGFCSENGMlh6?=
 =?utf-8?B?Y285Z0UrSDlrV3FXTlJRTUY5cTJQbkgxL2lrOWxXZFN0YWRJSUVVeE1WMTBC?=
 =?utf-8?B?Vytoa1FxamVSNG9GQkdXOVlzQ0hMbEZyVDdoMG4yNGEzTGI4RmNnTmt2dTJB?=
 =?utf-8?B?Mkt4dE92dEowR1dmL2pwZW9tNWlOamN4eGpVL09jTSsveE5WQmtXZVhhLzZ6?=
 =?utf-8?B?MURwdzBuS0JOOG05U05LQlhCc2FieTlHODlvdFNuYWJKRXpNaE5lY0d4VnFO?=
 =?utf-8?B?blFsUWx4aHp3aXhXdHhkNWdBbHFnWE5pTS84bEt0QVUwTzdMMFpaZzdCdXh1?=
 =?utf-8?B?emVKSkdKKzM5b2dCc1duUVhXRy90bDlvTGxyVjdUeDdORHlQNkpQZCtUUjZm?=
 =?utf-8?Q?DSUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7630.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnZRS1JEcmcyalBjcU5UNmJtcTZyMEdCVml4SElZUUNENjZxWFlSZWpLVDZZ?=
 =?utf-8?B?SzBzekthUUdiRGZ0dnduY1hwblpncEpueVZpUnlZOUlxTSt6YzBtV1ZyWlNK?=
 =?utf-8?B?SGJOWnN0N1djNnRocjdjMm5ZVG1hdnRuZHAyQmltUGJxenN0bkJaQTl6alVu?=
 =?utf-8?B?UFZlQUpRREhwK3dMdEY0R3l6bk1ocTk2Q0dNZ1liMnlOa0tZU3RmdXpQRDVB?=
 =?utf-8?B?cllNVnEzcjNDNkJML3JIU091OGJReVl3TXBjNXVTZGpleWNxL050Z052WVRZ?=
 =?utf-8?B?clMybzExOFAzcGk0QWNsbjVtRk0ralFjSnRZUkNCbTBEL3orTzFVS3FnSmlS?=
 =?utf-8?B?SndSSTJ6OWhWaEhBWWwrbi8vaEEwZENxTkdjeXc4V25OWCtONnNiTFQxbVJI?=
 =?utf-8?B?bkV1ZVY2S043TnZJL1RvQXNYZzFyTzZrRlNacFpsb0c0aGt3cFFrdTVaNEZ0?=
 =?utf-8?B?UktZZ3pvOCtSR0tGSE9lOXdKbmMzcXRYOW5NVG1MTDIrOVF4SEw3T3VhVmhi?=
 =?utf-8?B?UzJVVGZERTN2WTkvaWZwMXdYMEUxM2o2YUFyempYT0dvWWtHUTlEQUtmcGJV?=
 =?utf-8?B?R0pKZ1lKU2d1VS8zVm1BUGo5OWJxbnZQMFV5disrNWptVEljb2o5M05OMkNy?=
 =?utf-8?B?aHZWV2RJK3lySlU3WVpyUnBSenVBa3pWcWtyUDk1NnhIU0t5b3gzcTdOWDRx?=
 =?utf-8?B?eWk4SmI4N1dRb3d6eDFibmVNRGcrVW91bUVqYjZIMWVpbERNYmpRWWpmbHBK?=
 =?utf-8?B?eTJYK3o0QWplcFdRTEVaNU92akg3T2Z1cnRpWFNsak5iOXVlai90aDM2Zm9q?=
 =?utf-8?B?c1VhaEZPa1ZnUDg1ekJ4SFczb2JRc1U3d3N1cE80dW9OeVJwSzVlQmNKYnVJ?=
 =?utf-8?B?WmtTK1Uxa0FnbHhielZQbTFDV2lGWkwwbWNYcTc0RmpvV0kwT0J5MkYzS0hC?=
 =?utf-8?B?WG44SklrZHp6SlY2QzZIRWR3bWFwVnhBemI5U2dBdnRIVXZJdVByVU9SN3c0?=
 =?utf-8?B?TmZvL2hyVWVFMXVuT3B1MUdTeUhqWVd0d2daRVBvTUMwSndOZG9YWTkzb0ww?=
 =?utf-8?B?NVVEcks2bkRqWmlvQjV5ZzZITGZPNzVmNE40d1d2YndkWTk1ZlhLaUhlS3NX?=
 =?utf-8?B?N1dGZXhKWGRxUWQ4SnFmR3ZUalNHdG9WMlYyTysrQVl2QUxUcFB5YlZuUlVx?=
 =?utf-8?B?QzRYd1k0Nms4ckUrTzh3RlFWcmw4cW9GMmlSQkZRbWlZbEx5c0Q1bW5yOVBY?=
 =?utf-8?B?RXFHRndQRHkwUHdpeStwZld0cFhLcHNjZC9OK1h2VVE1UWtkVjFYQmYwYXlq?=
 =?utf-8?B?YUtDUmY4WXo2WWFrSGlzdldsMzE3b0E1dERMRHNZSk1qR2g3NzhleGxNRGtm?=
 =?utf-8?B?NWxiTEluWEhxVlZGN0RJNkNrSStpYWFjRmdIMWx3cEJGTFdHcnBSVnZmeUl1?=
 =?utf-8?B?T0I1M0hLMXkybEZ1S3BwK3lXVEp6WnZPdDhzUGFKQlN0ckZKOUtkT2podEw2?=
 =?utf-8?B?SFBjdFRPWm95aXU2ZVQvY1FEdG5WbFRQeEprc01XYlBMODdJZjlwL1c1UHZY?=
 =?utf-8?B?VVplblNLNHd5VzRxMm83SWN3YWRpdmZ4eTIvU3ByNDI0QzNrSlMwUjVqV3JM?=
 =?utf-8?B?Zjd3cGlSQlcwSXQ3TmpuRDhkbVBaNTdyOUsxRndYSmZDQzZZcG10Z0Qzd09F?=
 =?utf-8?B?Nzk2QjFtNWNwVHhVb3VhS0tBVjFJMjFrSUJ3WEhGb0hydE5OMXlYc29jdzMz?=
 =?utf-8?B?Nmt5S3Rtbno4aktuTkIxaGNkSlJZb0c2WVVoaTRudUh1T1BkSWxHb0E3KzRX?=
 =?utf-8?B?TWdubE1DTFBKQnBQNWw4M1pHM2toTUVxMklmODVUdmpiTm1OTlBPV2wxaWEr?=
 =?utf-8?B?NGcxSHl5K3RqVHcxU244T0ttSWhwamtTYXlIVEl6MHZNbmRSNmFPWlNMSXBU?=
 =?utf-8?B?bU0rNG9JWnYwM3dhbDljdXlOY0dWTEVrRm9zTnc2ckl2bXMwcFBmVTU4TTRE?=
 =?utf-8?B?RFdFRUhhNVFyS2JJUHZWMlJVbjFwdDNCMnlCaEZ2K3VPeE9URUdlM1VadzJO?=
 =?utf-8?B?NHg3OEQrSFNtcFpnRTY3NlVBakVRRWE1KzArTDV4SWZjcXA0SDBZRWlqemhQ?=
 =?utf-8?B?SG5MZjV6TGJmS1l0dk9XYUNxYVdEWDlEUFlHY3dqOUo5TXhaNVBmb0ZpM2RB?=
 =?utf-8?B?RXJOSlBXaVh6WXFtNWE0ditUajU5NWU1Z0ZDMFpFL0lkUUgrY3Z4OVBmWlBK?=
 =?utf-8?B?NGUxdFJoSkVTbU1jdjFNa204RC91dy80UGxFR3NhM2F6RDcwMFlLMWxVcUYv?=
 =?utf-8?B?MFdvNlRNMDlLVG5heENkanh4TTZaQWxQQ0M3Y05yU2lVN2h3a2JiQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0189dcac-7164-453b-9394-08de54723a7e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7630.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 20:11:11.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wWUhcBWUAVs8DCbLY6naJT2kYMsxaRCVW7t4FZ7YHTWu0Vjk8aib5Tf3w1m7Enka7nH1aKCjKuLp3eQXuzgrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

On 1/14/26 09:28, Bjorn Helgaas wrote:

> What sort of crash happens?  It's useful if we can include a bread > crumb that will help people identify the crash and find a fix.
We observed retraining to lower PCIe lane count and config read timeout.
So yes crash is not the best way to describe it.

> I'm confused about what the topology is.  I first assumed GB10 was > a PCIe Endpoint, since Secondary Bus Reset only applies to devices > below a bridge, so SBR would be applied to a device by a config > write to that bridge.
gb10 is an SoC designed by NVIDIA and Mediatek in collaboration. It's
not an endpoint, but has its own PCIe controller for connecting PCIe
peripherals like NVMe drives, NIC, etc.

> If this is actually a GB10 issue, it sounds like a hardware erratum > that lots of users would see and Nvidia would likely be aware of.
We're aware. We've maintained a quirk in a kernel tree for DGX Spark 
and other gb10 powered products until this gets upstreamed.

Terje

