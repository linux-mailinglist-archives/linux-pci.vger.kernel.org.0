Return-Path: <linux-pci+bounces-27664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E938AAB5D6A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 21:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED914A760A
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3352BF990;
	Tue, 13 May 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="elCkUnpI"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814512BE10F
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747165885; cv=fail; b=nigbO7Ddphl91RGf/qlGDXq9TevhKuCkGtd/gZK1Nk0xPYvd9KuABgPWPKkKhrSh5lC1osCYJArINpn3WHILyYKXY3dzofQRopIOgZ9IjA9gjSsXiVjLBPtf5VonXJKOr+j4qiQ43qTFFkNX1iA7XvO5cPZuMYY4HNTvo21p1I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747165885; c=relaxed/simple;
	bh=jMdqR3ZFMvjhzyHBRGaffnqT52VEGhg6K762Sh1FmK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JUn17L1nLJBpb3+m6OaDGjdeyVj8WlYFIUmMiWcrA8cvwwzltaIygzR7EDPTwc6Y9C/wO/beKEqliMBzf+weFaAHuSGffLDgT2Jp0jsQboL7qup5PymmKqPd2By5IW+sqg41GO68roKTLImzE6DDfjnsth0UDh2hSxYdMwgE7BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=elCkUnpI; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlmjQeMMZauz3COyqCZ/kNIy20EI9SdJc1RPfjcsN2RMLwHXFhYiP52JckCDEeWrs5CoqLCcgBVzhgKEociLJTtOtpGn9vY+O7hgw7Zg+PoJkJ0QtY7nOEJl2vbiUE4U5gJNZJRNNSlKHTN2NitCnUy/wGeNzmRNTjk4KylZylgkK5oBLkOnrtZbS/yrxJEYMO4NtHhHlvzxR8d4Aiayj74oTsMmABlVcGQw/LmDnf/zeF+q/KBy3tgzawqQ8lysB0esgLKmnsWvJ4wszRwFaK1fwLyiO7N9/29ZbBszBSiVf6GtOJuo2/pOjXH79ic5aFKk9FC/LqT98DVzZfi7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLfjZKBNNiKW9dYex6UYdXbE4WLs07eqiXrm7YU4ToQ=;
 b=NJRSD6QVnEP+QVncneUWuc6P4Wb4uS9/Rtw1jEQmZlrX7PyWKebTxQHkV1nZXfH0PM6ZQ4nwjFijq23fPcoOrUqWnjF/y+47jWXVcosrkqf4PvjMKnM6Hi4Z56diWuW4gw3ci79wexrhoHpI4tv5pXHH4oaKxyKbapxy7tV2bSKhGoFH6tZFMEI16+QZcIB62gXnBIB7lbmi06Dq2yR5iseAjj9IT3K9uA9I7jJFhdt/w4EUaNrJVGQZ1kDMiSN/HPQj1eDW4nxPnTVrALqp5og/qQ24VhWZJMyIZwhOpw5unPYsHNKeFx7il889nKkrJtkIo8Z5a2J0Bdz7AZohqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLfjZKBNNiKW9dYex6UYdXbE4WLs07eqiXrm7YU4ToQ=;
 b=elCkUnpILdF3YbVUFqpse/5FDrm+CN877NfzSfMT8Zr3WYqQIngDxQVkOjR1o6GUsIkm2qfKUoY7LKjdCqU8KL25NkUolAtVdu/GNZR9KnGcABy+A89BBL252W4n5JfzqEy5qK72ir4GNwAqjsq55koW8S5hqfoG3YWAvxWplAM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 19:51:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 19:51:18 +0000
Message-ID: <b2f9c88d-59b5-416f-b8d5-2e0fb1fc74fd@amd.com>
Date: Tue, 13 May 2025 14:51:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 220110] probably thunderbolt or pci leads to pci usage
 counter underflow
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Denis Benato <benato.denis96@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Yijun Shen <Yijun_Shen@dell.com>,
 David Perry <david.perry@amd.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 AceLan Kao <acelan.kao@canonical.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250513194506.GA1155899@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250513194506.GA1155899@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b75d68-9cbe-4ac4-29f9-08dd9257871a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUdHVEFiRDhpaGlXM0hVNDFzZGVLUmNtY2FndldyZUZHM2lmd3hER0ZJb0ZO?=
 =?utf-8?B?YUtSdXdpTVFaRWRzNXFpKzBvR0UrRStqeU0zekRLelErRGl2QWZpdll0aXdV?=
 =?utf-8?B?RHF3QVE5UlRhSE5CaHRXWG5NVUx2djBUR1FlclpnME5QQ3IzOTJJZXVvTjlY?=
 =?utf-8?B?YXZBUmlSdUpRTkdways1VDA0dUFrQThjNEZGTUxUYkNuaWVEa2dZWnBheng4?=
 =?utf-8?B?U0l3N1RJRDYwaFlGcFFHeVlqVDNwa1R1d0ZPSmU3NVNIZUFiL2ZKU3lnS0ls?=
 =?utf-8?B?czEwWGFUMGYrb01GSEJ0R3F2Zm8yOStIcmt2Y3ZmRmxzZ1k3UUdLSFg3YnM5?=
 =?utf-8?B?emFTNXdrV3NMN2Fkd3BicklFQWhSZm5BVTZjNmpsNmpXYzN3QktOczNGSnRp?=
 =?utf-8?B?R0VIZHFhSXBZYjRaT3JndzcrYVprZFB5ZVNOaEdYS1pabW90K0Vtc1BTNm1q?=
 =?utf-8?B?NnVvTCsyOTd6b2grS1N1amgxRElPcDROd2VwOEJpMlZDZUloK0J6akcxR0JC?=
 =?utf-8?B?Tkwvb0NuS3VhaVg2T3l4cXEweC9SeXBLYjEvUFJEemFtRlBEaWRvNW1ubWtD?=
 =?utf-8?B?VnpVdGNYTjhQNXB5RlFqaVlkMFZlSjlPZWYrSVNOL0NKdzRvTEd3eUxCWjl0?=
 =?utf-8?B?dmNKbU1kOHplY2xIaUg5OWx5QzRoUXlWbUkxd1BqT2NvL29qdEhidnUrZGpZ?=
 =?utf-8?B?bUNNY0RXYmxOK25tU3dXVzJpZVV2d1BLMzF1Y2pQb1FDMU1IbHdYdkkxQ0gr?=
 =?utf-8?B?MW90eGM3UHBRL3ZHSlFYOS8rRlZtVStvamwrektZc1FuTmNRT0xDRHVjVFZj?=
 =?utf-8?B?aHRkRGFSZ2drN2w4dG4zaE81aHdsN25FV2J4R3hyc3lxelJGZHhYdUp4SDll?=
 =?utf-8?B?akdxUmg5aGNqMzM5T21jclpZU3FkaXFwWktiaEdrSm5DY1RxUEpwNGl1cUky?=
 =?utf-8?B?ZytPdStaOUxTTXVzcjEvWklGT1ZtM1prNGhTVVAwSHBJWFMza2lGblkvOG5U?=
 =?utf-8?B?WFllWTNKNDZNZ0xoV1NwYUNEQStHN2xLSmJpMXlsYkNhWndGeUF6Zng4Y3hH?=
 =?utf-8?B?NVJjY0hrTU1CYVlSaEJrRkRCK0pEeUljQjNQTXNESXRkUnhtZVQ3L2xHN0dw?=
 =?utf-8?B?bXpKK1RuM3lBVjBuU1pXK0FpRTYxY3RqT0VVRHliUlVnTXRRc2dNdUJNSDBK?=
 =?utf-8?B?RXNYelZkaXp6OFJMSXRwRFBSbmp4Unp6NlFnaDRsbDJ5MzFiR2xrNWh1TWp2?=
 =?utf-8?B?endvUHZrRzFGU24rc2hKelZPYlJmNGtQV0I1NzM4WXVvdlA2NWh5Rk8vZHBp?=
 =?utf-8?B?bGMwUTd1aTNJclRqenovYTRFV0orWVVuVEdUQmNMUTNsZ3draThXeG9Od0VG?=
 =?utf-8?B?TDFZZjR4eG1GOWs0Z2R5NHZpUURpQXNuTTNzN0oxU01jbVV1dHcvZHYrWkxp?=
 =?utf-8?B?dXFhb2lnU3ZvRk1wVHlQbm9qbzNoL3liZVo1MkRuUXNhc1B2czdkUkt1QTRp?=
 =?utf-8?B?WFhTRmJ3TnFZcEE4RlM3U2VIL1F6ZjRoK0J4dFBXSHovNTNIM3F5NnJKZU1I?=
 =?utf-8?B?N0E5ODN0NC9lV25FSzV5L2o3VUhycGdaMUtBQU9qMmFSZkFJajFFSUxRVVNz?=
 =?utf-8?B?US9lRnQvSFNLa1I0ZVhCUnZHWUlNaE9iMk9VbUFLQnlpTXgzdTFkSkZZVEJ2?=
 =?utf-8?B?WFdmYkRvRzNFWG1zUksxTG5IWWsvbUE3YlpHVzRPS0dkaWFqbSs1amlUZzN5?=
 =?utf-8?B?bUdwQjhwdWlzY3BRdDd6YmNzM2kwYUVsb2pObWczR2grcytodEJ6enNlUFJP?=
 =?utf-8?B?K0UyN2NpMytnUzZhTWVpYW1YdkxITG16WlVrWW9GczNIWUpZV3ByQ1lKRlhp?=
 =?utf-8?Q?41xGTiZGCDUuT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE1LUUZWN0lMb05hL1VMRXEyVjdSRzhXdGFNckJzMXFHcFMranJsRnNXLzFM?=
 =?utf-8?B?aTZlV0VOZXJyMkhHMHdNTTJEMWdpSDZEczRwbjhWNjVXaEFSVWhFUytuZi85?=
 =?utf-8?B?MGN1ajJDQVNyQnVBOXRwZEdMZk5EdDNMcEhsNExpeFR2QUtvN3hpTXJJM1ZU?=
 =?utf-8?B?MjNlQUtkK1E0d29kSThFcm5MNmN5MEtKSjMxM25tVGJ2OXhrRHQ1Z3lscXNN?=
 =?utf-8?B?TWxnUTFwUVN0Mm1RODl5S1k2Y3ROb1hhSDllclgyMjBTM25hRHRZcnpvL0dJ?=
 =?utf-8?B?OUphck1vdmJxUU4vcC9la1pEdm9aQW1ONHhXbVcrbXR3bXR4Wmo0czQrTk9L?=
 =?utf-8?B?Zm5rYkJBNDNlMzJwNER2eGVNWjhnbDFYak5vY08ybGFGZHhoV1phOUVQb01Y?=
 =?utf-8?B?V3ZMSWw3dnM3NUM4SElDWVF2NFFzK21sZDBsNGcyRldadFh2MHpoK3E2aXJt?=
 =?utf-8?B?YjdpVFBRRGlieERFLytOengzU2F3cmNXeHQwMzd6WHBsd0M0T3MzREdhcjBX?=
 =?utf-8?B?QjloYmgrdHJ4ZkJHNU5wbXNYOVZNYmF2UTMrRVZFWCtWUTRkZ1dYRldrRHN5?=
 =?utf-8?B?eDg0ZmJiS2lRSFVnYjZuSUM0enBNY21KUHhnUUFhZEw3RXlpcy9TTlk5dWFi?=
 =?utf-8?B?elIvU05xcmNsaGJpSk9naG9oNUlHZmZuZXlNRmRNNThPK0x3RklzNkJ0VmtR?=
 =?utf-8?B?OEUrcUdWQlB5cXlsU2dFWUNtWnhUOTU0dnRoYzVkOTdLTVdKbzBDa0FpaFBT?=
 =?utf-8?B?L0s3VEplMUxyTytzalZTc2J1SGppYXg0bkhBU0VtNTJQQUxPV2NocWlXVEJn?=
 =?utf-8?B?UmtQR3ZkeVY2MFFWNVNVaXhENjlBdlM5Rm9ZcW04Q0NnYmZVV0U0bnYrMGhW?=
 =?utf-8?B?ekhPdUk1dGdBaUZLWmdzOWJoejliYmJTaVovb1RobExDaGJpTjhVS1RjYzU1?=
 =?utf-8?B?MCthdENGM0pkbmp0dWVDam5NeHR4WjB0N2plRHRnOWlFclFuRDJvNFJvRGJZ?=
 =?utf-8?B?aXkrVGk0UXJhY2VSRVRSemt4WnNBZWU2N3I3UlBhUjdGSmU3MWNKMDMxY3gr?=
 =?utf-8?B?QVV2citoQUhwVHBpQXhSbXR5WldweG1kZ2xaZWZJMElScEw2YW9yNEF6SSt3?=
 =?utf-8?B?U0hOTGo1RFEwb0laWUZaMlgwb3JzN0RRUDdyYTlkMCt1WmhzT3k4VkN4UHRH?=
 =?utf-8?B?dy83aitFV1NDMHN6MzNIdzZOdWw2UGdQUVdQMTFDWWQxSnZGdGg4aDVnUFdB?=
 =?utf-8?B?V3U0d2RmS1p0a3ZKM0x4anpLcWk2S3hPTVRiSVAwZ3BSS29yK3lGTFV5NWJu?=
 =?utf-8?B?dHY4MXZFYzU5aFVncmtnQy9pcFpoLytKOFBjTEJ3UTBOakFnQWpsT1VSRmpF?=
 =?utf-8?B?R3hHT3dlbTdPNHRTYXJVZGpsalY3a0hiZW1XSDdXcjdUU3Z5YVMyS09IRXdh?=
 =?utf-8?B?SmhHRDdRdllwd05uR0RlbmNaQ3BETWtEUjZnSGwxZDRBWW01UDdpQmg5ZFlN?=
 =?utf-8?B?cGtoaExDbzZpeFhjRmJVUEc1SVhGcmkzUVNvRjNBYTc1MUcwcVpSdTNZbVQv?=
 =?utf-8?B?cE5BZ1ovamVvZkJIZlBZek5EWnBGNHZPc2hFT2lFM3JmUkZtZXVrMXU0Y3FL?=
 =?utf-8?B?WHNxeEMrbXUyamhlaHQ1SC9qekpTREVnK3gxdU05RHJGUzBlUlpOSlVyQ0tD?=
 =?utf-8?B?NUxOeHZ6cW9CTmMxek1zRnhGODVBeHo1cEdCQmlZbWZrNHc3RnRmcWl4QUw3?=
 =?utf-8?B?aUc4dmJuQzdHLzR2SHo2YjVhV1NpNGtOWXJWdkFERW1UZU1USWF3bE05c0wv?=
 =?utf-8?B?NDQrUmdUWEN4U0VvalhzOTIzODloZ0ZuK1QyRUh5a2lraU9aSXhXSEtjdGlF?=
 =?utf-8?B?aU5maGJadlVoM2l4Rzc0VVRPaGFwR0FlODNUTEdPb1ZWVjViUWhuT0xSeHIz?=
 =?utf-8?B?STc2TFpIdWo4NTBKRHJUNFdnNWEyVk40VlQ0bHdqUkkwUndoeGtqV0R3ODI2?=
 =?utf-8?B?R2txNm10US8xUERZVVZUMGRhQzQ2aGg5cnIydEt2eGh0RFV5NUsyMHhSWlA5?=
 =?utf-8?B?N0VLclNxa0laM0RFZHhUQUkyL0NvaWY4SHNjT3lCYTczTkFRd0o4eHczQ3I0?=
 =?utf-8?Q?ZGPggljhmdW4fmaLgIhVgzB2O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b75d68-9cbe-4ac4-29f9-08dd9257871a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 19:51:18.4641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o+ZTX80nxvLt8rA11ZpMJ1xog6T1uGlZ0jV3/ky/uSv5rOifYa+Ju14qD/HzyR3eox4QgPCXxp6gIL39Gx90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On 5/13/2025 2:45 PM, Bjorn Helgaas wrote:
>  From Denis's report at https://bugzilla.kernel.org/show_bug.cgi?id=220110:
> 
>> I am having problems with my laptop that has a thunderbolt
>> controller to which I connected an AMD 6750XT.
>>
>> The topology of my system is described in this bug:
>> https://gitlab.freedesktop.org/drm/amd/-/issues/4014 yet I don't
>> know if this is related or not.
>>
>> I experienced PC attempting to enter s2idle while playing a YT
>> video; PC has become totally unresponsive to input in any
>> keyboard/mouse and power button after turning off screens attached
>> to the AMD card (the built-in screen was off already).
>>
>>  From a look at the logs it appears one uncorrectible AER pci error
>> triggered a pci root reset, and that comes with a bug where the
>> usage counter assumes a wrong value; this in turn seems to cause all
>> sorts of weird bugs.
>>
>> That however is my interpretation of the attached log, that might be
>> very wrong.
>>
>> This is the first time I experience this bug in a year with this
>> laptop and I don't know how easy it is to reproduce.
>>
>> The kernel has been compiled from sources and it has
>>
>>    [PATCH v2] PCI: Explicitly put devices into D0 when initializing
>>    [PATCH v4] PCI/PM: Put devices to low power state on shutdown
>>
>> as I am helping testing things. I find unlikely any of those might
>> cause these issues especially "PCI: Explicitly put devices into D0
>> when initializing" that has been there for a few weeks now.
>>
>> Thanks in advice to whoever will help me.

 From the logs the system didn't actually enter s2idle, but because of 
the failure to recover after AER he lost the external GPU.

I don't expect that "PCI/PM: Put devices to low power state on shutdown" 
has anything to do with this issue.  This should only affect system 
shutdown.  (Tangentially related comment; we have another version of 
this on the linux-pm list now that is more generic [1]).

How readily can this be reproduced?  Can you try to reproduce once more?
Can this reproduce on an unpatched kernel?

To confirm if "PCI: Explicitly put devices into D0 when initializing" is 
the cause can you compare the PCI state of all devices from sysfs with 
and without the patch in place after bootup?  Basically run this in 
patched kernel and unpatched kernel and let's compare.

$ grep -v foo /sys/bus/pci/devices/*/power_state


[1] 
https://lore.kernel.org/linux-pm/20250512212628.2539193-1-superm1@kernel.org/T/#u

