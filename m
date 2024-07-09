Return-Path: <linux-pci+bounces-9973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801CF92AE6D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 05:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B9CB2139C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031E41C6D;
	Tue,  9 Jul 2024 03:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IKZ00wcD"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8638382;
	Tue,  9 Jul 2024 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494432; cv=fail; b=UI5IVasUhFijiBCItx9EuKfCGbZrv8JXc/j1GzuksFYR3C+dwrQZR4X4mfVr2Hc91lqt7m4LvMzwubAtHuX4bQoS9i7WzFO71QtcZPgurywzxBumC4gc//wrPTjtn/Rr2KJg07sgZyhL67fXDnph2UwAN36+ytd1Debr/lhZ3SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494432; c=relaxed/simple;
	bh=pPkaxvcq8Vm3it9b6lAGD1dS6EOUAcMOCI3a6hcjjyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PqzlX7r/yQ8VIRG6l3aQsou06vNxyzbZH+AvxBREYr6NML9WkwJrkFor/5P949uw2GD3tVGY/Z7W1WNOHfF42p7D5/DfzRsDBO9CFI7YivT0No0ZreG4onOVlLq3o/zXx79wva1w0f0MdI8mTZXF6SQekitOD60Z34tPew6d3VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IKZ00wcD; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWfYn0ggsNy0SvaUWi7NvR6I9hPkU4O8o5tWzHVOgNaP924znN4Y/LRR3u6sH45EcqaOc9RWuT6HBl1jTMvvU831v11wEavJ/bktQgBPUjpYgxv9ymyfBhDrYskIAxwh0eEE5XuQMYXBns797Yyal1TwAHxxI1Z2iGpp9VKEKfEji/q2cLNq4KSP0pw6MjBzrfKW23jZ8Cyvv72GZAcHJMQ4M97YVoZE3KBkafve5nHYGRWEX/Elqh+0E5+yU5R/Jygq3qZ1+0LRGI3mizaJ80eSqV38YqUovQTPIFpezSWKp3bnIst4FbSAicE0B5zFi6S2wnOzk9VFlk6zcYcWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpeUZ9/DFSjLtO4kVjZy7Hxof7e6nPCDNl4ZVCm4P1k=;
 b=IWtPEKuBxY/p/LaWluC2Q0IdaiIR71wyB0lRYki1Nea7wE1vbHEGi7N0EzqwOXYRs5Xnso05i6smCmjLEgKPrOnwDnWHeaGjeGv8bHYSz0M5dDgTXO3ZNVxE1193RgnHAhKbWjGkbYI70tzDOOVorhF+StmjZU4ncZ4ghIcqvELFOlklk5OnEzF9fEgXQh5xvrBIl8Mx1uvo3IRSt6G1piju23YUdRUqsQp6DnbkvUCNgt/jzG8ZMTiOV6yoKLxM5T7c0nPb5jj2fk3dL8onaX3Ptb51iFYjS/mZsMKK//ZKReZkbboAQZrZBCWi7xigCTjy5LbNW6Kx14zxqSthdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpeUZ9/DFSjLtO4kVjZy7Hxof7e6nPCDNl4ZVCm4P1k=;
 b=IKZ00wcDvtlXnij5ludVRIzavftzDIl4LlRqDqev7MZdWZwQLBBLrdejptuJjZo+OwuP+CWMOKL+CcW3zhgfKfpcMbuB4uCbjcIhydmU87F/0JvUW8/FmfhY+rGtxcJdz4q1ng6tZvtKkGnZ8w+DYMcDaO8l00mgt60Zw741HAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 03:07:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 03:07:05 +0000
Message-ID: <50eac465-606f-4a5a-8366-c45be1af8728@amd.com>
Date: Mon, 8 Jul 2024 22:07:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Verify devices transition from D3cold to D0
To: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613054204.5850-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240613054204.5850-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:a03:333::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 998519ae-f9f9-4ed1-ac87-08dc9fc43613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkJPTFR6aUczQWVFRVRVbG4xOXZsOGRXb2RSRmRpY1JITjVzOElUMzVKcy9X?=
 =?utf-8?B?OHcyMTB3Qnp3bXRnSDhjMmVUeWJyUlZ1S0QxUFkzb3BOcjNQVTF1UDcvV1hh?=
 =?utf-8?B?Nld1RmdSODlQc0FiSHlVS05BYTJqSTRGSTBDQzZqc0daM3cwREljcStybGxZ?=
 =?utf-8?B?RnZhbTV6b21MaXovK0JKSjgzdEVmYlh6MVAvSENNbW5DZ1BhMVhGKy9EL2J5?=
 =?utf-8?B?ZFlBeVFUNm5RNFRxdVpmelRSei9XcjVDbyswTnhSZlNKejEwYkVTZTJ2STFm?=
 =?utf-8?B?eU5iUW1kNzd5SERGTHlpMjZPM1lFcnVkWlZGQUFQTEpaZUxrRVpYaDZ0L0xQ?=
 =?utf-8?B?YUF3anRaanh1OUxxeGlMUjR6bEdKTUxLd2p5RE1MditEckN3aGVvZjVkcVVS?=
 =?utf-8?B?TDFaOW5IbWtWUnA2blM4YkVaaDFLOFA5ZUlROFZJWWpYdjZTNlY3UU92WTVB?=
 =?utf-8?B?WkdGNXljb1VOdm83a0N2R3dmcFZUNGN6UW92ZXJLbnJwQXpnbEQrRjhLVmJJ?=
 =?utf-8?B?OXZHR2JVcGRwdmkyMTdRaXBmelY3NHFBYUFMWGg1M1ZFU0R2L3dmMllyUWtZ?=
 =?utf-8?B?T2lPcXdBcFg3MThwNjFQbkVKd0FZSnpoclQveWc3dytIV3ZlTXdsNmxTVWNm?=
 =?utf-8?B?Y1RyZ2h1RHQ1MWlPWFdhb0FFM3cvaFZMd0VEQXZiN3QzTlhRSEtWaE01d2dO?=
 =?utf-8?B?Z1BhY2JxcUdZWGRSWFB0QjNHOWErRkhvYlJEVGg5MXlSMjJYeGduUFFmQWRl?=
 =?utf-8?B?dlI1Y1dHV3EwRmRVbitGMWcvdkxDVzdxNHNhcCtMbTl4eW9aa3dFV3dRYWdJ?=
 =?utf-8?B?UEhDK25YRGpmaTVUblBGL2NMMUlDNGhJM2hUSk5jcW9pVWlOWTJiaU82eHQy?=
 =?utf-8?B?ZDRuTjZXVjB0Z2dhZDNzazlBcXJOYUxTZjB2Wm9rbGoza1E5Qkk0bkRjTU9C?=
 =?utf-8?B?VlVqOTRDWjdaRmFFWUhVSDZpazVMb3VIUE5YdVNGZVppOTV3OE9XSzdzSEFu?=
 =?utf-8?B?bkQycXB0WUpnK0Z2czZaNXpFcXd0N2xRRTkwbmI0bnhvMk10d2pJNGNNYVR5?=
 =?utf-8?B?aVkwVS9ETjZ5Q3VrU2JyWTlSTVUrLzNJMGxWWUU3SW42UktoVUVCRThyTFJy?=
 =?utf-8?B?Tm9uVjUzY1Q3QWpqQ0ZIK1VlUkdhWmQrbjA1ekprOGNhT2svV3ZWVG1meXZB?=
 =?utf-8?B?UmdvL1cvZnhxS0R4K01jUkJPSlF5VG15OWJ6TWVFTFd3WkJBQ1k5a25oeDh5?=
 =?utf-8?B?ZmpHcE5ZVFNKSjBrNHN0aEJlcWthRkhFcUx0SDdMQnRVUUlnMHZDUjYvYnYx?=
 =?utf-8?B?YWNZL01hc2Q4cks0UklpajFmc1QxNWhoWnB6N3Y3V2w5c0xTMzBYOERmRU1J?=
 =?utf-8?B?ditYUHJiV1ZXcXVlRnZoUGZNUGNxanZOM2VweHRidThmRzVKaTZINm05a2tK?=
 =?utf-8?B?S1UvZDVVMHJVdkhDVU9BSUcxRE1Eb1I2YW5jMk9vbVVPcDhEKzdmMjZWMndU?=
 =?utf-8?B?ZFRMK081SEVxQ1IyQ2o1SEdLamdCcGJVSXVOdmwvUlNYWko1V1Btb1JqM05P?=
 =?utf-8?B?cUdJTVVUK09ldVl4L2VzOVg2NHVZemp6VU5DdHkrejVKRWlmZS9kcU8wUHM3?=
 =?utf-8?B?L21zSjN4NGRpTFFDT3ozWG5TT3FvWHUzdDFCZTdNVzhUUFlDNVNjaUVqdS8w?=
 =?utf-8?B?RTdBRm11ekVVcDU3Ny9HMSthc0Y4TXFueEQrMDUzalBvZ0RtUFJnT3dRelkz?=
 =?utf-8?B?UHM3djJFb2FNcm9mK1N4dThaSkNMNEpIL01UaElNdjZaaGRYSDF6RHJsbWVC?=
 =?utf-8?B?OEtBWE1aWlNhN2hPUUl4UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzAzaW1hdUlYc3pUSXBsVUd5aWdjOHdaOVhJUnQxdHRsK1p6UUkrY1MxcTJG?=
 =?utf-8?B?ck1tRGpKck4yY1VNeUYwYVpFdkMxN2VOcUM5M2tCRlZjS2xGbTNkcTgxRTZ6?=
 =?utf-8?B?Y2VGMDR6ckZMR3dhMXNHU0dvYUp3Qm5iNW14TE45UER3dXN5dEY0d3JvM3pa?=
 =?utf-8?B?ZzVyNWZCZ0x6VlBSeG1LRk9qUittUU05TjIyN2RmYlh6MXBma1VwR0IxY01Q?=
 =?utf-8?B?Qkx1c2tCT3ZFcTh1S1JCQit5NkhyZVllVnlKUHNjR2ZFcjRoZlpDZDczUzhD?=
 =?utf-8?B?NXNZV1pMeXBZUmFIellXR0pSTkpwSnFQTEJDdU52cHVnQTJvN0gxYmdEU3Ay?=
 =?utf-8?B?aWtUb1ROZmNYakVTNU00dDk5U091UXZ4MmVKdGhaa2RiQldEZGpjWVhib3BL?=
 =?utf-8?B?azFYcG1MVy9EMmIvdGk3V1k3Ums4SjZpdzhGT3NkcldkSmhkUWZ4V28xamdv?=
 =?utf-8?B?c216V28rNHN6MXVzUTdDU010VnJFV0h0ZFNuYlI2SEtBcUdUeW1pVHpaV1h2?=
 =?utf-8?B?RHlYM2swV0YyYUp4QTJkYmR4Wk9GK1VRRTJFa0FkdVJjcHNEK1BZY2JSOTJq?=
 =?utf-8?B?SUlxd0NILzdVcFlEeVVYNmNlSE9OM2pjVHlXNGxvbmhnOVhUVHR4cVZuMStO?=
 =?utf-8?B?Y3B6L2RjMU5pWFNlcmJSYjdWU3RGbTdaYnQzWmZqc2F1TS9MZkFvazN0VXpK?=
 =?utf-8?B?REJjOUY4NWtTbmJoQUM4bGFzcks2VjJ6Mk1BNS9IKzcrQzFHbnp1aktHdnAy?=
 =?utf-8?B?Tis3cy9KajVORmlZdUh5Q2lvSVlhWkIyS0hFakZFaTZRWkp1elZJSkw0UC9W?=
 =?utf-8?B?RzNBeTdEd1d1d3hOdmJLaE9HNnl4U3o3ZXkrS1NMQ2J5L2lpNnhvS1hQSTBJ?=
 =?utf-8?B?VUE0dlF4elNlK25KZDU3MWhrRlRvMEdaRjVvbk9kam5acWlkQ1dRRk9zUHlH?=
 =?utf-8?B?UjVBNWZzQ2dzOHA4L1RDVWtOaFl4VjdxdXdJclVhcHJESS9sL0wwWDhqRy8z?=
 =?utf-8?B?bEZ1U1VqbEtPM3IwS1JaTkhKMXlZTWRnTFprNjF2MFdqNVlJRE9XZTNUeFZm?=
 =?utf-8?B?VWhOSGZRZHJoZ2JteHdqZTlFZHRTc2toRkhjN2d2dVZESmQ0QWE2RjQ1bFdN?=
 =?utf-8?B?aEhyK3hlN0x2RHZyd1lKOVZyT0t6N0ZhTmhKTm93MHp1SXRPdVdvZ3M5Qlht?=
 =?utf-8?B?Y05qNFduTjhWQVBDL2lGWEZBdTBLV1pINnhBVFdUNlhGK2RPZVc3cklMMFZJ?=
 =?utf-8?B?MHgwYnBRN3hsT1FNaXBETllDYW9DYnM2dlFGMW9LZW9LSXlwR2p5MFowMUxa?=
 =?utf-8?B?TDNiZWpTZkZwVlpZTi9reWJHSXpoVC9OZ1JHV2RaUXVRVExDSlpiWEJUTzBI?=
 =?utf-8?B?SUthZkQrZER6YzhGUW1ibGZtamt0U0haWmg5RE9lTXpyVzFmam0zV3lsVUt5?=
 =?utf-8?B?UWZzVGM4N2doeDhpU0V4ZDRHSzluNnhJak9HNDAySUFvQVRPVmdhbUUybk43?=
 =?utf-8?B?aEkvYXMvQlU4N1RudEVwOGtZR0RsTDF1TTNEZStZL0ZjNVFzS1BxYXJCRGYv?=
 =?utf-8?B?MzdLZW1kUHRzMkZuYXdQUW5jcWhPblp4bHlqaldYdTJUUDdyT0d3ZmhwQy9y?=
 =?utf-8?B?SEVHVmdPZktQaUUvM2hxOTFpZFJXNzNXS1YycGNXaEw2NWh5SVZzZkdxbkNl?=
 =?utf-8?B?enRtdWtKVjNCc3RESktzVVFWVDg1Z0pDTTJaTytwT3FsZ2RtREpKSkV1b25V?=
 =?utf-8?B?SElRbytuRjIxT21ZbjYyNWlKYzVQeDBOU0ZBYS8xUEhkdHNqTm00VzgvS1kz?=
 =?utf-8?B?SHdBR3loQ2J6TVFEZ0VaajBEbHQrMEd1cHErYmFTMXozMEwweWNqY0ZUNXBH?=
 =?utf-8?B?bEFOdWQ0VHptQUd0N0JjRWx2b0NZVE84ZXd3YVpIWFMvRUF6TGZaeVVHSmhj?=
 =?utf-8?B?Sk9JUmxCY3lYU2hObjNBSTZYOE5iN0t5cyt1QTBhRHBabWZwelhDaXZCcmIx?=
 =?utf-8?B?NDZRUHVHc1dxQ1p6YXAxSWVNNTdtUmFXT3JiV0dCMjBra3lzMGxOYUUrVXh6?=
 =?utf-8?B?ekJQRnJlaTZkUHo3cnNtL2syMWtpaDNuVXNMQ3BZazJZNENFVjIyTFY1RlQy?=
 =?utf-8?Q?E/hI1vje9tmvJBM0QdqscMmTA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998519ae-f9f9-4ed1-ac87-08dc9fc43613
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 03:07:05.1249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trQmGpDvcyzKG8PIFsnfvKHIEIRM03iBa19R+XQMSg2nh2AK74gtLOE+vWhl6g/bCYNChu1TrfAwIcIX6ZLoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

On 6/13/2024 0:42, Mario Limonciello wrote:
> Gary has reported that when a dock is plugged into a system at the same
> time the autosuspend delay has tripped that the USB4 stack malfunctions.
> 
> Messages show up like this:
> 
> ```
> thunderbolt 0000:e5:00.6: ring_interrupt_active: interrupt for TX ring 0 is already enabled
> ```
> 
> Furthermore the USB4 router is non-functional at this point.
> 
> Those messages happen because the device is still in D3cold at the time
> that the PCI core handed control back to the USB4 connection manager
> (thunderbolt).
> 
> The issue is that it takes time for a device to enter D3cold and do a
> conventional reset, and then more time for it to exit D3cold.
> 
> This appears not to be a new problem; previously there were very similar
> reports from Ryzen XHCI controllers.  Quirks were added for those.
> Furthermore; adding extra logging it's apparent that other PCI devices
> in the system can take more than 10ms to recover from D3cold as well.
> 
> This series add a wait into pci_power_up() specifically for D3cold exit and
> then drops the quirks that were previously used for the Ryzen XHCI controllers.
> 
> Mario Limonciello (4):
>    PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in pci_dev_wait()
>    PCI: Verify functions currently in D3cold have entered D0
>    PCI: Allow Ryzen XHCI controllers into D3cold and drop delays
>    PCI: Drop Radeon quirk for Macbook Pro 8.2
> 
>   drivers/pci/pci.c           | 21 ++++++++++++++++-----
>   drivers/pci/quirks.c        | 25 -------------------------
>   drivers/usb/host/xhci-pci.c | 11 -----------
>   3 files changed, 16 insertions(+), 41 deletions(-)
> 

Bjorn, Mathias,

Any feedback for this series?  I did check and it still applies to 
6.10-rc7 as is, but if you want me to rebase on linux-pci happy to do so.

At least Mika and I seem in agreement from other comments in the thread 
on this directionally.

Thanks,

