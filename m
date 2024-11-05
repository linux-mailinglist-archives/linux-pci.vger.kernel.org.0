Return-Path: <linux-pci+bounces-16080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDED9BD742
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 21:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C761F23F07
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 20:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5F21443C;
	Tue,  5 Nov 2024 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="crD3Lp57"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06E3D81;
	Tue,  5 Nov 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839994; cv=fail; b=pnx3G6Uu6LDPzAYK4LaxEuQJEup/ucenNJ6S35lxL+VYlSD8f7+5oUv2ICduMDSR84BFC8Rb1JUt6LpgD8DxH+nAwxN7WxTL5N6G1guSGxObUNHHLPOi9v+w+05PXjw9dxI3+TgPzYLiRIT7RTLJTZASIL4vZfkhspJUtLhp5dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839994; c=relaxed/simple;
	bh=Fa/AN6M6UHolkMpyJF/9mPYh78gDnBfiO73TYKR2xlI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IOqq/xS2fnU05CEqaPY0dSK+pCq31fm8d4pJtN0eGNCnz/rBrrQkRkWt3tpfnJgrj7KEcGdzCn5U41FPcTnoNlOuXq4KeprRBQvyUAYO+bxxr6Eh60NP/+XMHV93ZiiZ2ZIDReBE4JfcKBHMhteJH+33ok4KLLHQuCMf4hdfNac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=crD3Lp57; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IASpMHGXrndF1UZWz6MIK+Ej3nU8H7yqIkDo9k6lfj24P8FfiirIPBFj1Q3pB1NKKBzq9I6T0M6AOXbSwlRzwz8aSjHbAYcjWITfiItsGKbWiewOzU8HFljM1jv6vLqPsyWzejfxEr//TPXkr+0ZFHSUK9vIRlJZ4sQ5OhKEH1bK25Cok1/mgfQMZyDfKUNFeD3T/b4eCCLvceJZuSmWML2VK4DSTeWXr8jaiLd6Zci0r7m3QM2LKHdZKmYL80yMYa5a2LgXC6wJjGaiKAQ688FJhc7lux/pV6j0jXyXvW6+omUnN+a+XDpUrrgZfd5pRqtJGV5aVsnMX2AuQRVkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9VFV0CtZXtV5PZBl3IfVb2WIg7Bduy1vY8woHmjbMY=;
 b=qGe1hDswQ+CCZ3T1H94lPlLl5IBkW6us56IoRovwzRvQ9mqDdRrt8wxXDFh7smNAF4SzjT8ua8r5cGXuU/0AWo420lG1mDTUkGMQmteBjZPRtv4zwrIkzM5OxNCJxryA9qkVk1Hmx+hS83/VVcfmOKpDL6qjVpRRSL2acYHZxavthw21s9rviAqWzY162UgRcWsB3n9dlYM7gbY8dwEMrrnzFSiB3hZOdgP5d27h2YZ8rBs+cctxieGa/+77ufBTjrIdemP2yd9TAuzb+fBG+cC9VDvBmuinAd9R6lbB9mxsU+1EB/NwEAgP8INRWjHgFFeOelzCeGY0oSPRjBOIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9VFV0CtZXtV5PZBl3IfVb2WIg7Bduy1vY8woHmjbMY=;
 b=crD3Lp57sgFMX5XZpx4ho5Z3sGy8slVCRa1UwfYDBys1caGGdtYBN1ahtqhU8591Tus0xyxnRbY3u8JlFVgH8zpPc8RDXA36xVcdPBsYsYv7RdbA9+nQm4m3iuVy4Gy2wTfVn3uOyMEsHQO/qbAWXdKCLiuonLIX3SXAE0EF1Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Tue, 5 Nov
 2024 20:53:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 20:53:10 +0000
Message-ID: <f4b2c3b7-187c-4339-a82b-c6126edbd3ee@amd.com>
Date: Tue, 5 Nov 2024 14:53:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] x86/amd_smn: Add support for debugfs access to SMN
 registers
To: Borislav Petkov <bp@alien8.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yazen Ghannam
 <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 avadhut.naik@amd.com, john.allen@amd.com, Shyam-sundar.S-k@amd.com,
 richard.gong@amd.com, jdelvare@suse.com, linux@roeck-us.net,
 clemens@ladisch.de, hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, naveenkrishna.chatradhi@amd.com,
 carlos.bilbao.osdev@gmail.com
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-17-yazen.ghannam@amd.com>
 <20241105192124.GXZypwNJ26qqahcpOZ@fat_crate.local>
 <2b539169-8acd-40c6-9261-47c0252df91a@amd.com>
 <20241105195329.GHZyp3uVMKHAF3BEmV@fat_crate.local>
 <9137b724-d342-4f35-b554-0e56ef37b2d9@amd.com>
 <20241105195924.GIZyp5HLel7Pi2oAo3@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241105195924.GIZyp5HLel7Pi2oAo3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:20::24) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 104d420a-c7d1-452d-1840-08dcfddbdb59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUg1RTk5N1F5YXVFN3g0NGpER3lVSDYzbEFXcG5GRVdwUlJTeUNyc3VaNjBJ?=
 =?utf-8?B?TXZiYWd1TTlYa1BqdGhlTTdzV0wwTEliNFlaWVF6dkZRMnR4dG1TS3hscEpM?=
 =?utf-8?B?ZFFSeFp6dVBVK0pNS0o0SXFDZDBYaVVJVDQ3UzhDME9HdDdFeHFRNVZKajRS?=
 =?utf-8?B?dTFCL25zTm93emJkU0o3dWN5a2NnZEtMTzNLNTJZcndXQURvRXB5YitZa2Nn?=
 =?utf-8?B?OEtTRHRYUVBxRll6dzVOUzBWNjZ6TDRsVW94RXpmc3gzUGJjWi8wcG5MKzV6?=
 =?utf-8?B?ZlBuRGhjSGg2c2YxNVY4TlhNNkFITEsrc2JZVHN4eGFHaW8reHVYS0l6S3Zo?=
 =?utf-8?B?TXpEL0FML0w0Y0lySldYVWE1RjI3bGpnZFZXb0Z0YkZIRXZTa2l6SERsbmtz?=
 =?utf-8?B?eE8rZXJoRUdXM3JMVzA1T3F3V0RVSXh0U0pnSzM2eVB1akZjV0JLbnJKMGlo?=
 =?utf-8?B?Z0liTjN6Q0lkZ1lOaUt3M0RUR3M3L0xTbjhZWmpBY1JxdGNhVE5BNFBVQWNH?=
 =?utf-8?B?T2VNSVdDOUlWTE9ZU0J4QmVhTjhiRGhlblFTeVNiL1JrekJjOThVbE5zUnNZ?=
 =?utf-8?B?aGxUT2V0dE5TcEdqZ1VrRlQxcEdCNDRzUGFSNVlaTnBZNVhiZUxDc1RFUlZR?=
 =?utf-8?B?S2NwL1oxVkVpb1hGNW5tT1BmbkhaZnZraWpXSDI1Y29uODdkeERybEZ5L2l5?=
 =?utf-8?B?RU56MEJmY3NPOVIvR0FCclBDbDl1eXFpcnBITk9HNjUyS2xvVlBubFZXcEJr?=
 =?utf-8?B?emxQbE5pcHRkcUJOZnJOLzJLNzBZMEZDZFZRN1RmeWxXNDlzcUpVTThFOTRp?=
 =?utf-8?B?YzJuNEpFZHpnRm5MeHVlNTlqWjdsOGVtTU1FaUlsZVpTZkV5RXZUbkIyczF5?=
 =?utf-8?B?SG03RXFHbHRvRTMwZ1crVDhCRStIWE1WK1FhODN6a3hiWkk3c2RMZ0Y1SXhT?=
 =?utf-8?B?eWRHaDZGZ015Ri91R3FnVmNmSzdWS0lYbC9IUHpNUGkySEhGUmcyUVl5MXE0?=
 =?utf-8?B?MUZYdDBUa1JuVnVoWCt1UGdWRVY2emJGUVYwWUNQaSs4QjRmRUpZRWVTL2NW?=
 =?utf-8?B?RzR3MktkUUVLR041cUM5alhqdUdFc2FRVjdHQ2lTN0E2VEw4WVpRWVNkU0tP?=
 =?utf-8?B?blh3U21UMStDeVFhK2hTVWVTSVJEbUZ0YXYzcWVjTjZKbkFsSHZ5dTduRG1z?=
 =?utf-8?B?ZzZ2eVdXZnBhQWtpTUR5RzQ1aTNSL1NkbFNhaFVWNlJxWGdKbG52UnBGWWlC?=
 =?utf-8?B?SUlNVkdPNVdkS0ptWU04TmxyVnFEWjJPdWtndnlMTkpqRWl2ZlhhWHJVRFMw?=
 =?utf-8?B?NDJnSWlQZ0dDd0dYcXlJRldUUWFUYm1aL3hHZUxHWEszUE9ucytkUSt2WGJ4?=
 =?utf-8?B?Vi90UDdVVjFvRTJyOWRWQ3hHZEpXSXNDenJRTmNQTTZmb2ZPckFXR25EeTFu?=
 =?utf-8?B?VjdqYXdENGV2eGt0aXo1bXVFZWNHcjJBV21oQktpWU5Yb0tLejR2Ty9EVDEz?=
 =?utf-8?B?TmozZDd5NWc5Ykw2c2JsYzk3WCt2ZWlVYjc1djNFVCs0MjlDS29PTHFQMWNQ?=
 =?utf-8?B?NmwzaEVmZnUrUzlxYnpZcWIvd3lLZ2JsWENLb3lIL0dxWjZJUk0yOWJnMzBH?=
 =?utf-8?B?aXBqTmV0YlVoYzNnSXhka2tmMlR0K24xdUUyaVdmTkJyMVZIbGFQcWRyVEYy?=
 =?utf-8?B?b1ZoMnZmUU1TUms4VnBQYnVpOVc1UGJNaGxZQ2VQZHJRNEdGQzlCN1Y2b0ZX?=
 =?utf-8?Q?/JMu7VlBOyVy6cklFzCoSL0UOc2LekKm4LKpkPZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1RBOU9UMXh4cDlnOUEzdlRlYXd2U3ovSXhEd2RTZVFyQno0RHRrWmRVYkNZ?=
 =?utf-8?B?QnA2NzRKc1RXRFM1OE9hV0svQmFGTU9BbndjUjI3UVRLQlB0SmRLajdVeTRp?=
 =?utf-8?B?NnQ3cDJDMlhjdHZIQWdjeEJ4WTZTZk5naUZKaHd2S3k0QlplbGF5c1hObS9p?=
 =?utf-8?B?ZTdMOTF0Tk8wSVJGUnE5cVlzV1FtWmFrNExFd3ozaG93OHh4TTJ6UU9IQm9m?=
 =?utf-8?B?b0s3ZjFsa0VRWk52U3NWY25tNklnN1R4anp0Y201bmNoTng1S0JCRFhPOE1a?=
 =?utf-8?B?blJWQ1JRTTlma0xCMFZWY1lRR3VHcXVlbFcwYWttNVRjZmUxaE91WnZjZXBt?=
 =?utf-8?B?cnQ0QVBOQU43RGpmKzNKSmdkU25TaTFrZWxYSndHenh6Y3k5dEhsWk9kR2xH?=
 =?utf-8?B?SDVYbTRXSkhjZVV0K2VxRTcxZW1aYVFYd0xpUDhGRlNQWnhJQ3l5SmFuRzBN?=
 =?utf-8?B?TjNFZVRTTnZ4VXBGQzlJNk9aWkFOTi9qdEZycktHNm5yS0dlOXJiRzBuSkcz?=
 =?utf-8?B?cndhMVF0bUF5R21EWXBmS3pPOHNlUlpJUnlORzBiMktub3l5WW96VDRPZnRU?=
 =?utf-8?B?djdEcXRKaGNsTURlOVNibmN6SHM2WWw4Skd6K0tHamJxaytoUUtOQXhPSndz?=
 =?utf-8?B?alFzRjRxd1M0cFNERXN1VGJVOXBjUGtYN2tnYnlNd2x4WkwvZjk5WW93cWdp?=
 =?utf-8?B?SkFSSkNCSFNhZ1Z0SU9RRzdtZ3VrS0NjTEZ3dkEzbDVPUmpKS3QzUG92b0o5?=
 =?utf-8?B?RUJuTUM2c0N5UXFZWnQvckxiQ1hoMTZXcTVRZlg4U2FiK2ZBZEhHRi9QVmVu?=
 =?utf-8?B?MVRnaFFsdFZVcFhEZHE3Ukt6MGJmNkljMllQNWl6czJWMHQwUGsxNG11YlJa?=
 =?utf-8?B?Zi9mTjQrTUROaEJvNVJtTEtpQUZRMGpqakd2TStyeVR5SGpWa1lEdlhESVZI?=
 =?utf-8?B?YU9qTS9kSjl4aUdpL0ZEREZzWWRReksveEtaOXpuWXcveE9PRW5SejIzd1Q2?=
 =?utf-8?B?YW9lWlJQd1JUV1dlbjBOdklYR2FXNEYyeVdGeVhxOEoydGZKazFoVmVkTk5a?=
 =?utf-8?B?bVNWNXVQSHZFQnh1TVNuSzdXbEd6V0pTNGQ4OVRYMG1jZW9YNFFSNGdraWkz?=
 =?utf-8?B?MXhJcXUrWjNGL0VnVDdaMExJT2YzbHFUcjMrVXY1bmdxUU5YTTdUSnRHK1Qy?=
 =?utf-8?B?c00wR3VmSUNwSFBYQWgzUDVQVVdMV1ZZQktNOW1KdjlqUHhKT3Z4RUJtdVpy?=
 =?utf-8?B?S3BSRzFQS0dIM09TV2tYSGkxM1FIM1g3cVo3cXQxS0dpWFN1a1pzOVRFVVVY?=
 =?utf-8?B?Q01YVExTRmM5MXBEdFJWYTMyQzBtWTVscnBPUFpnejNkbVVOcDRLSjFOQWxP?=
 =?utf-8?B?VFZKSDBUSWZtM0lGR3hDVU5hUVpLbkVBSmE4UDVadWNTSXowY1BZTG9RNC8v?=
 =?utf-8?B?WXRwZnMwVUprR2xTbUNXRWIzNG1WMFFDVUIyYTdJelg4WmtGYmdMbEJrN0Q5?=
 =?utf-8?B?OE40RndkMmpOSlBhc1dPei82MUxjcnJpcmhWbWcwTGQzYVpMZmlDblpYWFJW?=
 =?utf-8?B?WGhmSnJRS2wzREx5Um9ZUU90bTFGblRFc2dhWTZqK01NRVlmU1RvL3k2akxh?=
 =?utf-8?B?Sm9ZeTF0QXZUa0dUNDNZRmZVUDhsUFBjMlJYM2lvTndUZXY1bFd1WlBxQWFT?=
 =?utf-8?B?R1MwcGpNbXNtR1JYQnV5dGV6WUQ1Vmh6ZTBBZE1FYXkrY1c3UHp5eEkzV01G?=
 =?utf-8?B?YW9HRXZDVW1NN05saFBRVlJWVXZaaFU2WllFSm1XcVY5Wjd0eit6enl5WTBJ?=
 =?utf-8?B?cVh1NHY5M1dtSnI4MUZRdmtBcElpaHZiZ3Nmb1hUdWhHemdwYjdUTlBXdWYr?=
 =?utf-8?B?czZDREFsU2xzZmRhRDEwUzgyY2x4ZGU2YXdSS1JKeDNoeGhhSW1ETGxVS3ox?=
 =?utf-8?B?eGVYQ2pkR3l3MnZYVnMrczVhcTBUQkhRRDI2Mk9qYkdoSjdRMmQ4TVg1bFYz?=
 =?utf-8?B?aERwZkpWV1pSSGs2MHE3NU1laDZqRFY0NWNyRi9iV2VvcG53OEszb21RR0VB?=
 =?utf-8?B?TlJ0SUVIY3BlVkppcUlhR1J0ZzVrdnJMdDR1eFN0dDNtVk0zb0xXbjRTVDlR?=
 =?utf-8?Q?OB6U2mg4KZnTYan8hlxUYuct6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104d420a-c7d1-452d-1840-08dcfddbdb59
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:53:10.2071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mAcqDRWkV/vQZgEMLCwnp9Qj5YKNSrmHDZlqcQTsnsrI7h/opEaM5XWk/5k3vqbbVIkjqTqnKJF4MWttqQihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685

On 11/5/2024 13:59, Borislav Petkov wrote:
> On Tue, Nov 05, 2024 at 01:56:23PM -0600, Mario Limonciello wrote:
>> OK got it.  Considering that I think after this series lands we need to
>> re-open the conversation about PCI config space access to userspace;
>> particularly on regions that have been marked as exclusions.
> 
> I could imagine a patch that goes and requests those regions exclusively if
> luserspace has no business poking there.
> 

Take look at what pci_write_config() does today.  It basically shows a 
warning and taints but lets userspace proceed.

commit 278294798ac91 ("PCI: Allow drivers to request exclusive config 
regions") and the matching mailing list thread linked from the commit 
message have some history from it.

I'd personally like to see that taint turned into an "return -EACCES" 
instead. But given the discussion linked in that commit, I think it 
should be a follow up rather than part of this series.

