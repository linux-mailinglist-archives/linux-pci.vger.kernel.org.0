Return-Path: <linux-pci+bounces-9195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B7915221
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23430B22A5E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA113DDD3;
	Mon, 24 Jun 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aBAAH+9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848541DFEA;
	Mon, 24 Jun 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242577; cv=fail; b=tYEaWsosyO2NtBSmsaxd29E4yVSR/oubAJLczGvMj8mj8L/bfR2cr35vzr3cH7F/Zo3n3b7auwQtKSorxHzos6W6ybuslSwf/WWqBbONxL7virr/KTood95Bg+wGxn9KbwoZwKeMspGflwJfeI09A7OwCvI1hn8DK1PPbDGJISI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242577; c=relaxed/simple;
	bh=BTNlOLJkw9YgeD9z/5u1sPt8SexFBx3Sxh7kVEFuIHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gFFommu8VxcK576MksMKBWqtHh0rAaZ621EgwCaCGsqJm36qt3ZYD9qFO0YcwpKq6FH/LAH/o4QBbFRbCf9WVKYLonxBt75JW0ElsuFI/Uoz3m2RMwQ/CkDwECQPu7sQD8T4eO2zr8junZvS86lvYFYy0J52mzMz11kSiIbHMpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aBAAH+9I; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APiMACboyJWXmZZSosMrzsmVbLhbcSWzVEzAQZS6suhOZg2WZ3PcRQGoXpb5uBc38qHpDvoIYSbKnAS8pttUcRejd0chSACZu6QY9B3W6TU378JPwFZkDmN4x7RrZ1vUK9aeRoCKQKmfMCrsJA/kLJ0KgDalrvWzZ5S59iN87vbitqhP2Umj8xvuFEHB5DmzeGdB0LDNGIP3I0VbIoR65XTcdQK3TIfeUxdQ6InfmEoa33GuILdxkwzeHUc2VNKzn7dBKEjMW578kDohb74Fy4rfTMsbilwVJuNBHHGG3id6gLJUdGb5oSNTKXLQMwjJLgqK4/n3qANrZZ8F+t+2fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6E1T8Brlrb973radwGIqgDogrOQPYO4IuAf/TvnIO0=;
 b=IBH1hYAedHk43yJNuHOFx/vuMgnb6JmQhEDL+568IVsstpr2hjfQwSQdJj6WfMsASE0FfmmKe+FmKEboDPa/KtX+bLEdP/Es+OPFRyldf37Koe31w9AOoU/vOz2X/LXikqmNuzzgIL3RJJU6T4wWBgYSkk3waqvrynVxUttpTCz25ODDaH8CHfvHiUhhSM9lj/U82xZeayBguJGIyPsLCEV23mritxJQogWdwaxM4spxyFBGM3EQ/CnxWIxpELP/yNitzjF4k/N/viuwmyqlhpTThhRp2R6fYE76S2c41khy6/8GyLhcqxEguqemsxiM2w7N79oiFaiep3/W2tPalQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6E1T8Brlrb973radwGIqgDogrOQPYO4IuAf/TvnIO0=;
 b=aBAAH+9Iuo7xpO7XKvJ/90UShHgxqF2dMkAtQ3dnpwh6WaECMIzWS923jM10Ah+U8jzR9i17JqlgAJxcDljhDgfe5nxQUKWV9GW1y3c2niy8c//m2DqJ3o8cIcKtIE+JH7OZ9A1XP/62JXRMrPhqIh6Fcg3wpHoOvunbXhF4pCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 15:22:50 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:22:49 +0000
Message-ID: <9f748365-06f5-44f9-865a-d076b110bb33@amd.com>
Date: Mon, 24 Jun 2024 10:22:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/9] PCI/portdrv: Update portdrv with an atomic
 notifier for reporting AER internal errors
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-4-terry.bowman@amd.com>
 <20240620133027.000047e1@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620133027.000047e1@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::25) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ccd1ae-2851-4652-8013-08dc946181cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TDNZMVJwczNOdjlOMnhVRmZ0MWMzRHp4bVYwMjBrMW1uOUpwZFh6WWVkKzFu?=
 =?utf-8?B?eVFLaHNaYmVSRTE4MWJ0TGtZLzlTMExwZlhkbkN4bjQ1VFJTUVQ3eFVYQjhj?=
 =?utf-8?B?U3RrSno2MjQ5TWdHQ095YXNmVmUxV0JmbGlsZ0Q0cUtNcW9aSmpQaTBwY2R1?=
 =?utf-8?B?a20wOVFMN2VEeGFockZRd0UrZ3pVM2hSTVcxV2pTSEpqY0YyOVFPekMrNnEz?=
 =?utf-8?B?VkNyVHNwYnFCenNjZjhPaUdEWHFOV2Y2bHpDVDZFUWh0OGRhdkVteHNIM0JD?=
 =?utf-8?B?aUQ0Qlo4bCs0RHdOczFQb0pxMUljODBHKzQrUDNxdjdOeEUyQ28xdVVFZFpx?=
 =?utf-8?B?WkFGN3k3STljMXpVY0xKb1BSL2RNRGpKRk1ldFVIQUNpN3MrVG9KYnBWK2FU?=
 =?utf-8?B?ejh0bm42enM2cGxHMmVqYURZL2JkSkVTZzM0eExhY3NXUit4NVJYNTYvbkNt?=
 =?utf-8?B?VWpWRHpYakREVERPazZOelg4RW5Ec04rVGIxcWN3K2Z4WWgxeWFqcjYrczB3?=
 =?utf-8?B?UCtiTkZaazdDbkJmTG92bzJXeFJZTjQ4cUUzK2JNdTVrTkdYSnVnS3BoUDM5?=
 =?utf-8?B?T0d2RVJiU1llMWpVREFYYUpCS1NPaHc2Um83Z0Fla05kU3lZMFJwUG85S2p4?=
 =?utf-8?B?OURsNWhrVE1UVGVpUDF2K2hTV2Q1NkxiMHZCMHdKSXJyUUFQenRScm9mSHhC?=
 =?utf-8?B?ZkUrNnlDdmQ5Zkt6MFRyNlg2Zk1KTllYNUpHSzZPTlNLYTQzdlVLSUJlOGhv?=
 =?utf-8?B?RCsrcXZORnJtSzNtS3Y3Y1huMU1ETXNTTmtzaDFZSkZHeEhITGw2UVE5bWtT?=
 =?utf-8?B?Rk9EaDZZSnBOYXU4WUo1ai8ybVd1eVMzaVM3UUN3VHlZRjBlNTRKUVZBS0VC?=
 =?utf-8?B?YVk4YklHMkxpVTc4OFFvZzY2bFp0aVA2S0NyOVVHbDJFT3RSQWN0TjZsSG1n?=
 =?utf-8?B?cXJNeXVMTmo3b1hkSXF1L0pIcXJkSHpEeml0ZGJzcWVjZkRhT0UxenhpOGZz?=
 =?utf-8?B?UFVyWWdCTzdrVzl6Y08xeGhlRGQ3cFBWSXFxSzZYY09takdWWUhYM2NvS3BR?=
 =?utf-8?B?VkxIWXZhcFlUSjRpVUFIOXF5RGRENTQwdTNmRTZzU3RUOHQvOWUzM0NiRFRw?=
 =?utf-8?B?Q1A1THFrcVE0WEJvS0hIbnkvS0pOU1U4MVJWTmtIN2NEMVRadm5HZG5XSlpv?=
 =?utf-8?B?THdJcjhuZFV6eW1ZWGtoM0E4RlBUWXduQlN2amMyWjRzMyswRjNKL3preWw4?=
 =?utf-8?B?eHY1R09rV2lWMmNzN2tlKytDL0c5RjR6OEVKeDVzRDk1eEFkdG15aVJsc0ox?=
 =?utf-8?B?bWdXNDVKaDhVVnBhREpzRDNUM3hHRzRjbFIxY21LZ2x6c2ZjNG9JZ0NoSExV?=
 =?utf-8?B?SzhobXZkSWM3c1lHNlpsQml5WWE1YVZYUzErcjQ2MVVlVzY4N3Z1N1BlbnNL?=
 =?utf-8?B?R2NjUllUMW4zWXFNcGlvL21ZTXkwZU1Rd3M1SDlNQU54QUN1LzFGNWhBSUgw?=
 =?utf-8?B?aTY2Q3NETVF1b0Q5cUJoMGV2b2VmRDFKQXNJbFRwSlJWYXZxZ2VjK3JyYWhq?=
 =?utf-8?B?UW9ja2p2K2wwNm10VlQycTR6R29wR05xd0czZ0lqdFl1LzlOMk16ZDFYZmRD?=
 =?utf-8?B?VXl1VTJIbGxkTFlMb3pORE5tNEFKSnplR1k3ek9MK1Z2NTBCTXpJZUxLeE51?=
 =?utf-8?B?cHFOeVBNa2hZSWlJQW04WjZxS0ZuSWg3aHI3WG5KNndPVUFDa3BISkNxdTE4?=
 =?utf-8?Q?G5GrmTHn3PXD4TZbXAXTZay8FEMJXHHIc5iytPK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WC9QbVQ3TFM2Q1d1dFlmN2djM214ZTdlNG9JYTY4MEpDRUc1UWdmYVp3RjhC?=
 =?utf-8?B?Q29HdEF5VVNEVnFnZmVFaE5Ka0ppSTdRVjZGT1NLeHdhZ1ZMcUllek1BUHlr?=
 =?utf-8?B?WUNLR3V3YXRQYjkwM1MzTk12bXhWNitZdHRkaHdubURiK1M2UjB5cmVrUGRl?=
 =?utf-8?B?MU5KTXlzdk80UlN5anZPTzY1SnNrUmpoOVpLbGFaQlRZN3U1STZCNHdVaDYy?=
 =?utf-8?B?ZXY0dFhjNlVaUDNmT25RMnBIN3VUT1htL1ZOS3RwVEpWT2dQMEpCbGpQY2k2?=
 =?utf-8?B?OWNzZjA3RjQxdkI4clUzc2dQSytONHhkaHpuTUZIdGFqYVhJQ21sbm9MUnRU?=
 =?utf-8?B?dXVvS0NDYUhPNDBCSURJeEpjeUV5cm5WNUh4SEFLM1laZGJpRjJhck85Y3ZE?=
 =?utf-8?B?d2RjdmtNc2lyeDBOL01tMmQ5TVJqd1hvYWxnaFFnTWEyaHI2U0hKcjVsNnJj?=
 =?utf-8?B?bkx4RXVMWDBycUhLOC9UdEpFaG9YMFA2R2RqVnBxUHNTM2JIY1pwNWZ0ZHps?=
 =?utf-8?B?WWE5WS9yTlJrMXI4VTRwR2c0a1hxTmdid3dYTW9HNTY4NzVQdlhmUGI3TDZz?=
 =?utf-8?B?YytVSHlXclZLYTdCSm5FS1BvYXg4VnR3ME9yY3Y2NDJJWTRzU2JWYjFqT2Jh?=
 =?utf-8?B?Y1FGS2VNRExUc0xkbW51Sk9UeVF6QnV4U1JlL1RLNjVwbTdyN0s2UXdvU0ZP?=
 =?utf-8?B?eEJUSVdpNGhUR0lHUHFadFJCOUxNN0JEUTc4QXluRkU2dExRejQwd0FjODdC?=
 =?utf-8?B?elViaCtOYTZmWGhnR1Y5NENDd2JaOWo0QittR2lob3FjVGw1a3ZEdERnZFdM?=
 =?utf-8?B?cDJKZWFwQWtDdjBoZjg4OGwwVFp6MlhqcTZCRWFYVi9ONDJhNXJpaExYRGQx?=
 =?utf-8?B?L0JXSkJjYTloaE5QM1g0OWd4MEJWWXNVN1NUT1RaTW53dkY3R2JsdXNPeEFJ?=
 =?utf-8?B?dEN4ZGJQU3hmamhIZVFaUlQrdFhqOFlXdTN0bDRIR1JsRGl5MVpEZkw3MGNQ?=
 =?utf-8?B?MnRHTEZDckxCcDBHbnhUZTM4M3dLaGdHbzE2cmt2b1hwNkVLVG5RUnREZ0Zv?=
 =?utf-8?B?c1pDMEFMUEozK3FmMzhjcGFOenJiVG1OK1o2dVVYNUZ3aGZSaGYvL0plUjMv?=
 =?utf-8?B?eHNHTGE1VUtubTdHKytyS2x4dndFUVE5MXc0VGZ0MlcvMDRDd290a3d4TldO?=
 =?utf-8?B?WS9KQmMzWmlXcEtSTytFc1BTTkVXUEJNNFF6OE5nVzBydkdadFVueUo2NTdY?=
 =?utf-8?B?R3J2cDhkL04yNWdIZVBaSEtIYU5jd3F5eWt1UDVmYTNxTTN1QUIzc0NyMFpL?=
 =?utf-8?B?VnA3T3ZLb3ZvNmVGQ0RGOXZRejlGTjZOYldCVHJFZUFqMEZQRnhoaTI5bFlY?=
 =?utf-8?B?UG9OTmpRY2hwejhhT0RyWGNVd2lKazVtOTB0V3gvRDFRKzhjRCtrVExyZWR4?=
 =?utf-8?B?TFZ4dVlVNlc3RGxncHBwT3pYWWt2MCt6TTU2aDlqclh6eFZsVkd2cUtKREd2?=
 =?utf-8?B?YXAzejhBRzRIaVk3cjhBdWx0ditLa2NNa3Y2VW9UMFBDNEl6cC91ZVhzUXF5?=
 =?utf-8?B?dFpzTVVGYUtnN2MxbHh5T0wwRW9hR2tabTAvWjRiMWhmekplaUlOcFM3TC9t?=
 =?utf-8?B?dmZjeWNQM1NhRi9lNE1wUzFxY2UwVVR1V1ZWOS9aL0tIRXF6ZDNjN3JoWjMr?=
 =?utf-8?B?TE9maFpaVEFPZE9EUGZxNkNUeHRwU2ZaeEVGSURraDU5Z21Eam53NkVpT2Fx?=
 =?utf-8?B?V1lRcE1Xd1k1OXZWc2RQdTVqVWU0KzZjbUl3RFdKemlZYmhNUWV0aFVETDdV?=
 =?utf-8?B?d1RMSXF2endGWDlVbnBJa1IrRkFSelpISnNRcW15N0pRKzVhOCtvcERleEdV?=
 =?utf-8?B?emZpZEF1QnNUdzdkVE8zcFNEL0ZzMEdoNlFPNzZvc0tORUlQdTB0MHQyblZH?=
 =?utf-8?B?Z1AzZlBmenhzZEJJS2Z5aWJYMk5yT2dvL3BBeFlmbEpTdGhNYU40R1FqcW1p?=
 =?utf-8?B?SkIyKzJ5UHZpSUtxQjdGSDZyUTNYRmRmNmM4SjJvQk0za2RtcGsvdDNmemFP?=
 =?utf-8?B?VE9CSndEZjlzLzVjMnFxUFVrVUp5QkkxQzY0YlRySU8raXp2KzYyY0dsZ1ZF?=
 =?utf-8?Q?KmgzucY801X3mrfbSutnlXnXe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ccd1ae-2851-4652-8013-08dc946181cf
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:22:49.1902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjuFg6PCybshVUVUyt7mL6Imea07EkNAnrzVFCfgGK0W+IrRFstZUAQDvNCNj+9Wr79tzx4KIaDgqcRXiqktmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033

Hi Jonathan,

I added responses inline below.

On 6/20/24 07:30, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:05 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> PCIe port devices are bound to portdrv, the PCIe port bus driver. portdrv
>> does not implement an AER correctable handler (CE) but does implement the
>> AER uncorrectable error (UCE). The UCE handler is fairly straightforward
>> in that it only checks for frozen error state and returns the next step
>> for recovery accordingly.
>>
>> As a result, port devices relying on AER correctable internal errors (CIE)
>> and AER uncorrectable internal errors (UIE) will not be handled. Note,
>> the PCIe spec indicates AER CIE/UIE can be used to report implementation
>> specific errors.[1]
>>
>> CXL root ports, CXL downstream switch ports, and CXL upstream switch ports
>> are examples of devices using the AER CIE/UIE for implementation specific
>> purposes. These CXL ports use the AER interrupt and AER CIE/UIE status to
>> report CXL RAS errors.[2]
>>
>> Add an atomic notifier to portdrv's CE/UCE handlers. Use the atomic
>> notifier to report CIE/UIE errors to the registered functions. This will
>> require adding a CE handler and updating the existing UCE handler.
>>
>> For the UCE handler, the CXL spec states UIE errors should return need
>> reset: "The only method of recovering from an Uncorrectable Internal Error
>> is reset or hardware replacement."[1]
>>
>> [1] PCI6.0 - 6.2.10 Internal Errors
>> [2] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and
>>              Upstream Switch Ports
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: linux-pci@vger.kernel.org
>> ---
>>  drivers/pci/pcie/portdrv.c | 32 ++++++++++++++++++++++++++++++++
>>  drivers/pci/pcie/portdrv.h |  2 ++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>> index 14a4b89a3b83..86d80e0e9606 100644
>> --- a/drivers/pci/pcie/portdrv.c
>> +++ b/drivers/pci/pcie/portdrv.c
>> @@ -37,6 +37,9 @@ struct portdrv_service_data {
>>  	u32 service;
>>  };
>>  
>> +ATOMIC_NOTIFIER_HEAD(portdrv_aer_internal_err_chain);
>> +EXPORT_SYMBOL_GPL(portdrv_aer_internal_err_chain);
> 
> Perhaps these should be per instance of the portdrv?
> I'd imagine we only want to register CXL ones on CXL ports etc
> and it's annoying to have to check at runtime for relevance
> of a particular notifier.
> 

This could be made per-instance by moving to the PCI/device drvdata. This 
would likely need a portdrv setup-init helper function to enable for a 
particular PCI device.

>> +
>>  /**
>>   * release_pcie_device - free PCI Express port service device structure
>>   * @dev: Port service device to release
>> @@ -745,11 +748,39 @@ static void pcie_portdrv_shutdown(struct pci_dev *dev)
>>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
>>  					pci_channel_state_t error)
>>  {
>> +	if (dev->aer_cap) {
>> +		u32 status;
>> +
>> +		pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_STATUS,
>> +				      &status);
>> +
>> +		if (status & PCI_ERR_UNC_INTN) {
>> +			atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
>> +						   AER_FATAL, (void *)dev);
> 
> Don't think the cast is needed as always fine to implicitly cast to and from
> void * in C.
> 

Ok.

>> +			return PCI_ERS_RESULT_NEED_RESET;
>> +		}
>> +	}
>> +
>>  	if (error == pci_channel_io_frozen)
>>  		return PCI_ERS_RESULT_NEED_RESET;
>>  	return PCI_ERS_RESULT_CAN_RECOVER;
>>  }
>>  
>> +static void pcie_portdrv_cor_error_detected(struct pci_dev *dev)
>> +{
>> +	u32 status;
>> +
>> +	if (!dev->aer_cap)
>> +		return;
>> +
>> +	pci_read_config_dword(dev, dev->aer_cap + PCI_ERR_COR_STATUS,
>> +			      &status);
>> +
>> +	if (status & PCI_ERR_COR_INTERNAL)
>> +		atomic_notifier_call_chain(&portdrv_aer_internal_err_chain,
>> +					   AER_CORRECTABLE, (void *)dev);
> 
> No need for the cast.
> 

Ok

Regards,
Terry

>> +}
>> +
>>  static pci_ers_result_t pcie_portdrv_slot_reset(struct pci_dev *dev)
>>  {
>>  	size_t off = offsetof(struct pcie_port_service_driver, slot_reset);
>> @@ -780,6 +811,7 @@ static const struct pci_device_id port_pci_ids[] = {
>>  
>>  static const struct pci_error_handlers pcie_portdrv_err_handler = {
>>  	.error_detected = pcie_portdrv_error_detected,
>> +	.cor_error_detected = pcie_portdrv_cor_error_detected,
>>  	.slot_reset = pcie_portdrv_slot_reset,
>>  	.mmio_enabled = pcie_portdrv_mmio_enabled,
>>  };
>> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
>> index 12c89ea0313b..8a39197f0203 100644
>> --- a/drivers/pci/pcie/portdrv.h
>> +++ b/drivers/pci/pcie/portdrv.h
>> @@ -121,4 +121,6 @@ static inline void pcie_pme_interrupt_enable(struct pci_dev *dev, bool en) {}
>>  #endif /* !CONFIG_PCIE_PME */
>>  
>>  struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
>> +
>> +extern struct atomic_notifier_head portdrv_aer_internal_err_chain;
>>  #endif /* _PORTDRV_H_ */
> 

