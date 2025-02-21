Return-Path: <linux-pci+bounces-21982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EBFA3F49F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 13:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35BDB188FE8D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A1820B202;
	Fri, 21 Feb 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F2Cwkj0G"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8421EB1B9;
	Fri, 21 Feb 2025 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141808; cv=fail; b=HWL/ZIL4qIKT0eE/7k0u6N2GaG4celO5hlebiUKrxRGhkrhiBBSdo/6zozn/fnjinSUCLq40xlrKcTTziXTOAOjEGsr2A/mC9I1PYzWw4Sx0ZFyuej6FKGFVGkGbhDXGJNCX69CKKb00cPOU4rooWOsfxlcgufnb2f32Y4VEdB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141808; c=relaxed/simple;
	bh=rQICHf5cFcJIYQwt3IRBjb6sooJCHUffzzZ3n62AGtk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=INnO4VymwUKQHwydkQIiERLr5aulqGFaTO1WdjJ/jdMNsxJp4cMIwhZdi2yTLHamRk4TUOJirLXeZ2IwwJVM5hgnajTyf8Vq9LIVTK15qMgDQc1cVaXrxNioZMGrxpCw4db+Bif+02yai2HNaokRWYfJgEBGVmFWYwKHZdM8WL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F2Cwkj0G; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1NvjK87x5l3mcnAX6ycmLryg/0277z2ouqgcZeOToI02mRWRe8LWU9zJH1DOr4GGUAkieyekLBYTTI10aemQSy2EovDMy3+zhLEfQtFCnfs+cnlsZ30fBnG7f54d3QHJE33dAl4HgJ5RMxGyVlaMQsbOTNmZy1CTYf8QEl/BAb4yS4RJi3XS6GP39IM0jdQyQ2xXTRzg6zUr90eWgRxhyekooPAL++jxYkdcMDvPMAoJLCeyqt0kaDsJ/gDqjreNMGEw2wcOWPJKbbqZtjB8tNGVDoT6+mcJ1u4Fwb1HbrsVCXk4G0U2LXpb87kpDK1ty5Ar/BDiA6PtmGW2BiK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyKOynNY6tg/7urKsVZfZuoTzWIvlKBcUONHFUrM5xs=;
 b=hl3lwhTa+vwenCLvC7fjfQUVL6KJMYWwBxZInza1uTJwBhY5FL4H6l20csGnca788xICiyx4PDDVb+6F82NA8EqYJ0fFYBdFJRzKZBtvguPGudbGbzdyD9VhcDwizGoHkl1P8wvexNH536LJtjAGgMyJB8MyACCcZnfJSXebFCbM2zCkOdn4mNr5CwWYODg8qV/yRnh1J2yKk5hV+ltqiEqAOJOoeoLT6aL2GLzUqHqq0B2WMPKUqWj+43LWkUJ0ancUCQheVKbWpUoTosQEt344NQDpOixHHSqqBuIrT/FBtLumwmfr3qfKs+jS1AmWjV8zE0TjsXqcbU11KNqV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyKOynNY6tg/7urKsVZfZuoTzWIvlKBcUONHFUrM5xs=;
 b=F2Cwkj0GcGAv8nIBusC5TTDNni/1dDMX6YyxZ4f960IKmEh4cAMiE/ox7b7G8DtljOW6D12TUGw/Om57kv+p6AbSZQyEGLQHbS9GmJptUJe3q9EnullHyI8ZeL5yp7Xgvn0IOK9owstegtf+W+xBVgym8S1HPoCZvQDiJK6S2Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7797.namprd12.prod.outlook.com (2603:10b6:a03:4c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 12:43:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 12:43:23 +0000
Message-ID: <0e88f930-ac33-4455-88f9-c1b4039d2dd0@amd.com>
Date: Fri, 21 Feb 2025 12:43:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cxl: add support for cxl reset
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, linux-cxl@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20250221043906.1593189-1-smadhavan@nvidia.com>
 <20250221043906.1593189-3-smadhavan@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250221043906.1593189-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7797:EE_
X-MS-Office365-Filtering-Correlation-Id: f7c58f97-97d3-4b16-ba38-08dd52755419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TVBzZlNxR2lKbkNXNGx2N3J0ejhLZUtIeDZkUXhGTjBCeFpKLzVjL3VzaUpS?=
 =?utf-8?B?ZzdFLzZoTXM0ZFF6NW9rVktNZmdnT2JNK3JBRDNPMzNIRmc2bStadW9vamRX?=
 =?utf-8?B?Zjh2Ni9Tako1R1NaZnRLZk9KdWFINEJManNucFZpS2lwbDVRL3UwY2RuOUdF?=
 =?utf-8?B?eUp0UWZDeUo0R1BDb0doR2ZuSkQvMDU5VENVa1hHb3NKOXdlT2x2S2VZUzd6?=
 =?utf-8?B?R3lVeTFuSWowTXNvT3h6Mk1IemJxYVl2bk8rRlhybG1YTXg2dXpkTmF5dzVW?=
 =?utf-8?B?MnY5THo0M1ZTNkV2ZmM0bzdtcDNXV2hncDJwaGxYcjNsQ0M2d3Q1a3B3Q1M1?=
 =?utf-8?B?N1hOZHVvMXdKKzNnMUFLMy9hSHloTzM3MXAvOHJjS0htUUc3WUlMZm1qMzBh?=
 =?utf-8?B?aXIxNFJGQVRYLy8yc0NBV3RtcmhtbXM2RXkvakxnLzVSMmp5T0NuSUNrVWZ3?=
 =?utf-8?B?Y0xxYnNoR2hiMUV1T3c0UU5aZnh3Ums4N1RRMDRSNndwTDlxQXhsSU5SQmp5?=
 =?utf-8?B?ODJoMktPc0J0VTVTZEJnYVAxUWsrNmhweHN5ZG9LWnc2WStjaklwaVNuclVL?=
 =?utf-8?B?Tm54a2ZpZzF6MXlmM0V0bHZad21RNjBId2IwdktTOWZ0azZWRFlDQ3BlcWRu?=
 =?utf-8?B?NVVPSElISVVkK2oxanVGY2ZkQWwvNmFrenUzZHpaT1J6bm1xbnpwNTJZTzk4?=
 =?utf-8?B?Q0YvS2h2cUx0RU11WVlxdktNZnk0VkxpbTdXSTVuV3RmbWplZmUyRGFIRkcw?=
 =?utf-8?B?TjdEck13QzE5UDdaRDlOQkNZZk5RT3lJQVdTY0QvVUZLNTNYRUVYdjdBanpF?=
 =?utf-8?B?ODdPWS9FWlNlakVaZjdyRUdvZ3NiTkhWcHFJV1kvMXQzcnZmTmVVWW9sQWUv?=
 =?utf-8?B?UW81KzlWVTRZMk52a3VqOHE0dkpnazJ5V2gvQm85WStPWWZPc1JneW9ITG5W?=
 =?utf-8?B?MS9NNzNhTkVGb2NDTGNhSkpod1pORTcwOXoxbDRiTTdKVVhHblBJVUhZN1B2?=
 =?utf-8?B?NUNvbHNEV0ttVC9NUFBUcVZma2VZTzQ0TUlDMjQ4R1djaDdrQ29jdlJxaVUv?=
 =?utf-8?B?M1RnZXpXM1JsY0gzYVNEbkFNSnZRa1hBVFNvMFlReUpYZDg3YVNLZ0VRMy9p?=
 =?utf-8?B?NklSVFVsZ1RpbUdSVHVac2l0NCtraGFvTysyZUlKWUFWTGg3N1BoTG9hMzA3?=
 =?utf-8?B?MGNTL2E5TTVzMGtkQ3B5dzJOYzdpQldScHo2RytkUlExR0lVa3doT0N0VkQ3?=
 =?utf-8?B?UHo5Y2VWZnhRdERZNUMvampPeWFQNmw2UFZKdG03TEo1Yk9Zem4yc0xNMGlP?=
 =?utf-8?B?eTJEdEFvKzJqRm9xSWpPY2hGNXU1M0pPNFhMOHorb0xqNk5lUTlBUmViaXh3?=
 =?utf-8?B?eW1yVEFvRmFJOEw3WExQT2pnZzhTSlkzMllOclJoZnNCcU8yUWRLWVhxY09W?=
 =?utf-8?B?anVhVGdMdTJpcnoyTVZjc3pEbnZaZUhaeHNLMDE1cE1JdFNOS0VLZWJacmFa?=
 =?utf-8?B?M3ZPcHFwRDZlL1NSbVA4bDJhRkk5ZTBoazhBaDFCcElIeVkxZUNQb1BmSkIv?=
 =?utf-8?B?NDh4UWV3dnY2eDAwbG1ybnlxZTlvT08ydDQzZUU0QkNybHNncUUrMWtqVXdP?=
 =?utf-8?B?M2xBODVHN0N3c3hkcnl6L213UUlNVlRMWURLbzY2dWdhdzU5WDFOc2Y0NWVy?=
 =?utf-8?B?OHUwZUhkcUpwVVBOQzQzVGMwUFpWNmhxc2pyS2VIb2lNZFNpUi9kYU1aVmYy?=
 =?utf-8?B?UThnaHZlV3dmSzFwZk9DSjVXTGdqL1N6NFNVQ1lNOHhWQ1R3cDBrczB1bFZJ?=
 =?utf-8?B?VlNrejVFdUY0VVFuS2RTbEFoeHl4RnNIajhra08xZXUvM1VyVCtBUzBsY3lF?=
 =?utf-8?Q?8FyIcpNKQ6d+C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmI0cXYreW5lZG8waDY0andxR00zQmVicFYyYkhNQS9ZM3ozT0tqaldSVnJS?=
 =?utf-8?B?c0FKbkRaczZ5RjdYUDE5RXRGZGR4ODhtWVBWRVY0MEc1aFV4by9TUU1nYzBT?=
 =?utf-8?B?R2xXc3RFR1N1bi85L0hqMkkvWUhVMFd0S212NkIvWUpGa3Q3TmtPbDhWSXF3?=
 =?utf-8?B?NThVUnRTU1VtbTE1UTFETFg1N2c3bjBzc1dWTy95MUUvWFBYRHgwZEpGR2Fo?=
 =?utf-8?B?TDNQdEQvNlBZY1NpeGpQeE80T2RVYVFNeU55RUFTYVVkVTFKaHFRWXh3UG9B?=
 =?utf-8?B?eFcvenlXS05ZbmJaS0lZWW9IeDNPR3RQVHZaWXNTT216aWtMNDZRQVNkaHJD?=
 =?utf-8?B?UlVtSzNnY21qMmNQNmh3c2tEMHkrazNuekxWQ2QyOFc2TTZmMi85QkJYNXUz?=
 =?utf-8?B?WHdWS05Kb2JYTWJYVTFuRjdyUEpSQ2FSSHB6a1VnUFRIQ3BFcEhPQlVRNVRs?=
 =?utf-8?B?TDd5dkcxSlRMWVozUUVOVk9FV2VDK1h1dnN0K0dydDA2MnFxVkxXRS95TFZw?=
 =?utf-8?B?ZzlvRzdLZVM1bDFkN3o5V3M2WmxLRmZUWkQrS1RHdTBNRDIzTmxWTEV2d0s0?=
 =?utf-8?B?RnViK2EyNGVjYXJmSTJzZFFnenpkcFlpelpGazY4aHQxSm5jUExTWkJxWDV2?=
 =?utf-8?B?RXFIUGhQSjRSRGtiNWxuckJDL28vQml1MittSW1ncVI1NWpUalgxUGlQckFV?=
 =?utf-8?B?MFhqM2FLL3I5VVhPcm94T3FMWTdpWTN4bEVGQzhvVUsyRG9Fc2hSSTY5VEFw?=
 =?utf-8?B?NXJtaGxFOXFnY0J2ZW1veUpRL3g3SWZKZmIwbWVYcnlKRFpmOVgzQmdwQWdj?=
 =?utf-8?B?eXZjOWFUZDdYM2tTSS8yL2E1THVEQytTZmxyaE1acG1XMUhIRlB5TUFTdmRn?=
 =?utf-8?B?UWVwNTNCbGxZdkxuQjJZMHg2eUxVMitmSEdXY3k2UjdkdFBQSmdZVHU2cWpU?=
 =?utf-8?B?Y3RSWjV6T2F2VTJDYWc2RWsrQk93bjRqRy9tRzlpemk3MHBYK2tML3IwN0dW?=
 =?utf-8?B?SjlwclZhWWJPcWdTaGlONUZjRDN0NkIvT04yN2hYcFBzYVgrSnoySU8zWEhu?=
 =?utf-8?B?RXphdUdoZVEvaXZ2YTdLSDVpUVA2S0xtS0gzRk11NkZzVHY5QTJEQzBBYjdN?=
 =?utf-8?B?OTl2OWhNSkxRcEhya3pIZFRuU3ZuNDRqcXE0dklEeGV5R3NJQVJYWGtoRENa?=
 =?utf-8?B?R1ozY2dyUUZObmJNS0E5K0huN21vdHEyK1FZWUFCaXR4UnNwNkZ5QUtZcEhO?=
 =?utf-8?B?VW5oUSt4aU5mVFN5dFFIaDZiRng1T050eUV6VDRrcUdRQUZacWVjaDNCL3gr?=
 =?utf-8?B?TkxHTW5VeDN5dndiM0lxbzJ4OXBCS2VIeWI3ZHhKbmR3YytOclRvL1RxeGtn?=
 =?utf-8?B?NEFoZC8rMWVmN0dBeElGUmRYeitMeTVpWTNBbktDREN6dFgvSXd5UkgxUnl5?=
 =?utf-8?B?ckdEQlo1U0tLNW55MmpsR0ROUlpRSXB0VHVoeEhoTVdraE4yUXJMQnBvZTNF?=
 =?utf-8?B?S1dWMjRlZVJkeHNVbVBkSlE5Szh4ak5uK2g5emJqbWJ1RHlYZGhMcjczMlQx?=
 =?utf-8?B?UnhSU3ZXOEFUYjZSMEhnNUxWOUhlSnpmeG9WcXdhQW85U2M5bWtEZm5GUFR1?=
 =?utf-8?B?N3JrekpGN2RLU3d5dWsvNHdaUW9aSkNwR3ZJelpkWnRzd2h0UHFIMDVZaHFS?=
 =?utf-8?B?QW5kNlpaUE8reEROYnZ1ZDhuVUpyT052c2dVV3VPZ29LSyt0K25kOGt2emtp?=
 =?utf-8?B?STM5SUpPZEJGV3RUNGVMdHdzaFZhOGRmUUhkQmFaT2hZYWpaN1Q5UEpyL2xW?=
 =?utf-8?B?ek53TVVVUVExSTR4RGhId1JNZkZrbHY0NkJOdkRUcnJwYk44RTgvOXJKM01i?=
 =?utf-8?B?MmVneUtwd0VydTMxR2pTRklta05VeTJya3hSMnh5K0hCSUlvcWgxOGFmeVp3?=
 =?utf-8?B?Y1pRL1ZYVnJVL2ZRcjNnTEN0S2c5NG5hMy9QSmNVTjNaSnRicmNsTStlWGhu?=
 =?utf-8?B?QUdXMytwSmowRFR5ZDdUZldtTTVMcXNkY2JNLzdFbkFjaHNQMCs0S2hya2NE?=
 =?utf-8?B?cTNXaFd0ZERkMDNXUUtyRE5yc3ZPWFV0cXdHdDAyWVNJMTRoRmp3a0Vaclph?=
 =?utf-8?Q?0x0XNuOeTQWxxVRprrtG0Jm46?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c58f97-97d3-4b16-ba38-08dd52755419
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:43:23.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrM6qBrxvVlhVNOM30gQzJMlw5kR3/suuYEK6bDAQZar0ccKDm5IeKKdTjwjLmud9aCn02iAaEP5NDtXIu9h2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7797


On 2/21/25 04:39, Srirangan Madhavan wrote:
> Type 2 devices are being introduced and will require finer-grained
> reset mechanisms beyond bus-wide reset methods.
>
> Add support for CXL reset per CXL v3.2 Section 9.6/9.7


Hi,


This seems too early as there is no plans for supporting CXL.cache yet. 
It is the second part of the current ongoing type2 support though.


I guess starting the discussion about how to proceed is not a problem, 
so my comments below, but my first comment is if the decisions about 
what to do should be generic. I think having some helpers for accel 
drivers will be good, but the invocation should be in the hands of the 
accel driver.


> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
> ---
>   drivers/pci/pci.c   | 146 ++++++++++++++++++++++++++++++++++++++++++++
>   include/cxl/pci.h   |  40 ++++++++----
>   include/linux/pci.h |   2 +-
>   3 files changed, 174 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 3ab1871ecf8a..9108daae252b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5117,6 +5117,151 @@ static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
>   	return rc;
>   }
>   
> +static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)
> +{
> +	u32 timeout_us = 100, timeout_tot_us = 10000;
> +	u16 reg, cap;
> +	int rc;
> +
> +	if (!pci_wait_for_pending_transaction(dev))
> +		pci_err(dev, "timed out waiting for pending transaction; performing cxl reset anyway\n");
> +
> +	/* Check if the device is cache capable. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (!(cap & CXL_DVSEC_CACHE_CAPABLE))
> +		return 0;
> +
> +	/* Disable cache. WB and invalidate cache if capability is advertised */


I do not know how safe is this. IMO, this needs to be synchronized by 
the accel driver which could imply to tell user space first. In our case 
it would imply to stop rx queues in the netdev for CXL.cache, and tx 
queues for CXL.mem. Doing it unconditionally could make current CXL 
transactions to stall ... although it could be argued the reset event 
implies something is broken, but let's try to do it properly if there is 
a chance of the system not unreliable.


> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	reg |= CXL_DVSEC_DISABLE_CACHING;
> +	/*
> +	 * DEVCTL2 bits are written only once. So check WB+I capability while
> +	 * keeping disable caching set.
> +	 */
> +	if (cap & CXL_DVSEC_CACHE_WBI_CAPABLE)
> +		reg |= CXL_DVSEC_INIT_CACHE_WBI;
> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	/*
> +	 * From Section 9.6: "Software may leverage the cache size reported in
> +	 * the DVSEC CXL Capability2 register to compute a suitable timeout
> +	 * value".
> +	 * Given there is no conversion factor for cache size -> timeout,
> +	 * setting timer for default 10ms.
> +	 */
> +	do {
> +		if (timeout_tot_us == 0)
> +			return -ETIMEDOUT;
> +		usleep_range(timeout_us, timeout_us + 1);
> +		timeout_tot_us -= timeout_us;
> +		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +	} while (!(reg & CXL_DVSEC_CACHE_INVALID));
> +
> +	return 0;
> +}
> +
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)


I think cxl_reset_start after the *_prepare call makes more sense here.


> +{
> +	/*
> +	 * Timeout values ref CXL Spec v3.2 Ch 8 Control and Status Registers,
> +	 * under section 8.1.3.1 DVSEC CXL Capability.
> +	 */
> +	u32 reset_timeouts_ms[] = { 10, 100, 1000, 10000, 100000 };
> +	u16 reg;
> +	u32 timeout_ms;
> +	int rc, ind;
> +
> +	/* Check if CXL Reset MEM CLR is supported. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +
> +	if (reg & CXL_DVSEC_CXL_RST_MEM_CLR_CAPABLE) {
> +		rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET,
> +					  &reg);
> +		if (rc)
> +			return rc;
> +
> +		reg |= CXL_DVSEC_CXL_RST_MEM_CLR_ENABLE;
> +		pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +	}
> +
> +	/* Read timeout value. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	ind = FIELD_GET(CXL_DVSEC_CXL_RST_TIMEOUT_MASK, reg);
> +	timeout_ms = reset_timeouts_ms[ind];
> +
> +	/* Write reset config. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +
> +	reg |= CXL_DVSEC_INIT_CXL_RESET;
> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	/* Wait till timeout and then check reset status is complete. */
> +	msleep(timeout_ms);
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_STATUS2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	if (reg & CXL_DVSEC_CXL_RESET_ERR ||
> +	    ~reg & CXL_DVSEC_CXL_RST_COMPLETE)
> +		return -ETIMEDOUT;
> +
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, &reg);
> +	if (rc)
> +		return rc;
> +	reg &= (~CXL_DVSEC_DISABLE_CACHING);
> +	pci_write_config_word(dev, dvsec + CXL_DVSEC_CTRL2_OFFSET, reg);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_reset - initiate a cxl reset
> + * @dev: device to reset
> + * @probe: if true, return 0 if device can be reset this way
> + *
> + * Initiate a cxl reset on @dev.
> + */
> +static int cxl_reset(struct pci_dev *dev, bool probe)
> +{
> +	u16 dvsec, reg;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					  CXL_DVSEC_PCIE_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	/* Check if CXL Reset is supported. */
> +	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_CAP_OFFSET, &reg);
> +	if (rc)
> +		return -ENOTTY;
> +
> +	if (reg & CXL_DVSEC_CXL_RST_CAPABLE == 0)
> +		return -ENOTTY;
> +
> +	if (probe)
> +		return 0;
> +
> +	rc = cxl_reset_prepare(dev, dvsec);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_reset_init(dev, dvsec);


One thing this does not cover, and I do not know if it should, is the 
fact that the device CXL regs will be reset, so the question is if the 
old values should be restored or the device/driver should go through the 
same initialization, if a hotplug device, or do it specifically if 
already present at boot time and the BIOS doing that first 
initialization. In one case the restoration needs to happen, in the 
other the old values/objects need to be removed. I think the second case 
is more problematic because this is likely involving CXL root complex 
configuration performed by the BIOS ... Not trivial at all IMO.


This is the main concern I expressed some time ago when looking at how 
type2 should support resets.


Anyway, thank you for sending this series which will foster further 
discussions about all this.


