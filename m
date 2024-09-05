Return-Path: <linux-pci+bounces-12842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6F96DEB6
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961371F2198D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B7D42AAA;
	Thu,  5 Sep 2024 15:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKgfBofr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A82101DE;
	Thu,  5 Sep 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551168; cv=fail; b=jxZMSlF8TukbfHyI0keyCcQSZzjuz+Jde6bi1NsAw+zxHHhbfyWdWEe3TinCTReTfJy1jYmw/dKRxx+4V1jOwFQaXpWyU62P2JzXrHNrMb4wmgq+urc8F3qb/kMsdfEk1OMv/f+nD1Lg0sLvqnbvly/fTdEZcRgfyK2xCX8FsR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551168; c=relaxed/simple;
	bh=ZtTErXn8h05DA5ubKZvPremnQXnt5EqG5ZmX45YbrQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVjiqxFkCwfq2D5bz59d3hAIehqbhRzH3DJCz2PdAAnW6+UoWRCtRNSSvPqNViqbWSNf752eQBDzQY5eGwemFVIlao2owdqszPMmkpQHp9kvEB+cdpTC67DMID2N1aExTsXIA+O5FbiKadultW25iUGC0YL7OdrzhoCHT1eFwsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKgfBofr; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRo4fI77HG5Cnt09NGK9BrCxPK19BmCKLGKPwFy0HCwWO1BzYOXWJt5YiwVsA6uQfO4TOYjplH+UuE/dVZwq01ie2fN/vIZQK04S7SvH2crWMSy9SUZP685kZwvjbbDELjjTlA7+tzzplwAt5F223lOzMrzCZ6cTDCXSGN1+hSTBWlcVrtKPPxdiP6qc9EMP/qElLo6s2RrkIjuvAOKEIS4ASL2i2D+jBI4qZPf2iYZUVi9rvS9BopVHvvFo/5S3LpXTP/5dNqAxm03S5kldXBopLBZ86IH5JB5r9Csr9gR+Ye8REG1pwyZ1Ekv+f70IjqWWTGVSADXo9+WZ57Ew5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEkcp16AvS6i+jsy4dXAA75MQESSN1YxDhs4KwgBBLc=;
 b=ANS21G0UbF4jgSzxGsNNvHaRtcgRipp1SpNM8b0Q9xBYvriZNpPtmewiUhsPg8F33K9OiqWS5XPbrv5M1vNVj3dXg6wJ+CjLJlQ5QVOH1f+M9mPlfqxJSZEi0fOOz2nRuhI1EJEtLC2Ipb4E11v/fMdqwBE65nb9N3EQDO+Gjxk1AQ5pd1kuu6ZEC4f5lI0NB8YDOYX49J+g2KIaoFRYTNd1beQ4MWI106bm3TXLy4oFqI05nPM8i0o9/NzHEMIhjdIYeTZD4f2t2JriUjkQhePpE/IdVAZcHTqYERBQSBahVjhFMEnBmfYdXskXOkX8VJCQGmHOHBuD5VIrdzDImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEkcp16AvS6i+jsy4dXAA75MQESSN1YxDhs4KwgBBLc=;
 b=uKgfBofrfluaoDH77NH+SRO9hQSak0SJi6IbS7PqPmaK5roZpN14BW+fM5UhcCyZyJbaZWgeBMDVlOg6HqbfQ+y9850pSYDwJptDAlHsxzOvaFTjLLgmVa6PppLn/uo0ZCZBlpGI87SIjmh1hWpW6HHxjkR3KgJp23jJyUqc/qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 15:46:00 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:45:59 +0000
Message-ID: <0d9b0e83-9f54-4471-bdef-5bbe84cc7aec@amd.com>
Date: Thu, 5 Sep 2024 10:45:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240904202016.GA345873@bhelgaas>
Content-Language: en-US
From: Wei Huang <wei.huang2@amd.com>
In-Reply-To: <20240904202016.GA345873@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::21) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: a75ecc43-a704-49f7-11dc-08dccdc1d6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OCt3OWhUM211WnZqWnRGcW51dEZYUGd1b2pWeHAraVhMSjZmVXdUN0hObUph?=
 =?utf-8?B?RTUvMUFQYlVySTZ1OGo2NDZrczhHekd6ZHVTYVBQTnVRcE1WN1J1Qy9kZnNr?=
 =?utf-8?B?a0trQk1mY0xVRitnbjdvdS9UamFnYUE2R1JnUEppWHpMV2ZZamNmZGxtQnh2?=
 =?utf-8?B?SEJjS0xjUXI0UTI2TWRuWXFJejYwSmhuZmM1VTcrTExvK3U2aG1ua1l4T2Mz?=
 =?utf-8?B?cmJiVEdQcW5xUFdrSXlnMFZVSHEycVhOZGNnMHRSdHVMbnZERWFHaHZINTJT?=
 =?utf-8?B?QWloeHdHUXZ6akpLQTljamZKbkc0V0JVc1I5S3puKzJhYXRhVVM0VmpORUdN?=
 =?utf-8?B?dmllblh2bVNrS0VEbG1RdGRKVGpJOCtNNkJaQmJCTFdRcHZNcnJXd0I1RVIr?=
 =?utf-8?B?emVHOHR4UHcrMXdET3UzV09mWktaM2hob20wRCswTnFsekl3a0tvU0liVUh2?=
 =?utf-8?B?UEhySkdwMUtoQ2g1ZEhoREdUdE9NQlRVYkpOTlRJbWpyYzRZbmpsdGNJK3FG?=
 =?utf-8?B?Y0IzNjIwTTIzd1BmUDhDeGRjRytqL0xjUkRnYk9DWCsza09XZHgrSVJsRU5S?=
 =?utf-8?B?MkpTcVNkV0owWGV4ZmZLZlZpd3BmdksrWFNXeXlycXMzTHdqektrZFRra2Fl?=
 =?utf-8?B?RUFnREZSK3J2ako1ZDMwQmw3dXU0YXgxYWlIa1VONTV2a3hDUm5qWGF2RldW?=
 =?utf-8?B?UC9Nc3o1QjZsWkN1VlZGdFd6Y2FTWHFqT20xeUVUN2RrZEhnR2kxNlMrcis1?=
 =?utf-8?B?azdROEJsNXlGemxVRUx0UE5iQWp0M2V4UmRHNWJVQTBkOFBNT2ZYWVlPWFBq?=
 =?utf-8?B?ZXFmdlQ4NysrckxtNHNHQnR4c21VUDFyQWkyZUZmTERRa1RTQUkwK3hGM2xJ?=
 =?utf-8?B?bkhHS1dPT1BneDhVbUFjT0dyck96czl3aEZOSmg5bVplaUE2dTAxVGg1TUZy?=
 =?utf-8?B?Y1NTaEVDTXYvVWZ4NTJFNmhYYklhMHBuN204cHp3NDd4Ylgra21xOEZFOG5B?=
 =?utf-8?B?cVVZQTNaOFhyTGdRRjhuSHA2QlRXZVhNOUpSaGNOcjFBc3V4akNBWUN1dG1U?=
 =?utf-8?B?bWZkcnJMWFQ2MXZ3bEtGMFhIR0J2SGFpZEkyM2V4K0g1cjVyZER6aTlNNXMz?=
 =?utf-8?B?ZjN1L0g4VWhqZ01icjZyNVdnZE5QazNZdmRvTDEvUzU1eE9BcXZzdy9KRnNS?=
 =?utf-8?B?bW91ODZCM1YvNVhVQkNKSlkwcGZvVk5UdnpxOWRKaG9NSHpiUDMrSHk1dkJQ?=
 =?utf-8?B?MWgvMWFHUjdOYjJFUy9STGlEU2dQL3A2QUU5VTVKTDJsaGZFL2g3VTVKeExl?=
 =?utf-8?B?N0VveUpha1lVVnA2c0F5L0NzMWVYRXo3SUpvR3A4MHFodlRXdmRFaW9FVmdr?=
 =?utf-8?B?S3lNUGhGK1BqNGxPU25xWjZZNyt3SUZKMnpkMmo2QVBRTi81U3d1YVdaNFow?=
 =?utf-8?B?a2VJTzBneWE3TWdGeDgyc083NHFHa1hzb1Z1cnhQeHovc0lVdzU0MVhId2FT?=
 =?utf-8?B?dkd3UVBpWTczelBjbm5FeWFaRHk3ZW1DQnhWQXFnU2ZiQnpnZnNYUzZ4SThh?=
 =?utf-8?B?MkR0U1FtV1djcHdRdmgxYmlydHpxUmp3SndmVmtUUERLV21kdCttV1FhcG1P?=
 =?utf-8?B?aVFYdUM3b0JTOHNRK0RlNWFYUGZmUVovSGlkZTYxMlQ0Y0YyRGtqZWVFT0hE?=
 =?utf-8?B?Wk1Uckczd1MxaHdsZWdYTFdCemRUakJNV1JwSlRjblppQmN6OTY3eEVlWlp6?=
 =?utf-8?B?QTQyVXM0WkllV3BtbkVjNDI0TTgxZEZxQVhxYllxLzNvSnBBSWdwTmpPU1Ex?=
 =?utf-8?B?UHpMN2tIb2trZU92aWczQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUZXOVZqRkh4ZVZUUkE3Z0JGTGJBdVhlVHhZTjBTSEdVbjh6bUpWYkFmSHBE?=
 =?utf-8?B?TCtJSFZ6ejRZd0RVSUZJS2NQWXROK0hPcm1GeVlHRHcrVllsZUY3RFBZU0h1?=
 =?utf-8?B?U2M3bXpPTk5uVThXUnZ5dktvZitic3dDVDZSd2NQdk1ncVlpbXovajhJMkQv?=
 =?utf-8?B?SEllU1E5dktZNUR5TUUreTQraFphaVNjL3JQRkZqNkZIbDdGS2J5WkFxRDY2?=
 =?utf-8?B?MXpmNmV5c1RwSHY5aGJ5ODdic3dOMjdJdmM4T2RJM1FBTGwxcmN2Z3loUDd3?=
 =?utf-8?B?eTgxbitkSGcrN1dxWnRPK21mSXp0bERxVW5oRWNwem1MUTlycWh1MituYzNt?=
 =?utf-8?B?MkV4RGF5U1BRSEV6VDV0TEswaGR2SWc0clVabUVlRE5BVEVLL2Z5SWNlODN0?=
 =?utf-8?B?dEdFREZ5cndBYktWUE5HSk9mYjRIdmJIRzRtL1pXSkNHcTZ2SElDVTVXV2lr?=
 =?utf-8?B?VUpoUm13M29KZFVhd21SNllLajdNMTIvemorbW9tK1liUzlDaTZTZi9oK05q?=
 =?utf-8?B?LzN5aW9TMGcvTnpyQUM0ZHIzQ3BCL2hzS1ZZeEZDSUNRdzkrVlBHL3VNNzk2?=
 =?utf-8?B?SUVJSkhiTmlRQVBOOGJmTXVIM0RhUVNlenY5R3B5NTUwLzN1VTEwOVYycVEw?=
 =?utf-8?B?LzlBTFk2aW1YQk5JQ1N3YWNoM0J6cTB0K2FHUXNQb2tWMTNjcDByU3Q2a09N?=
 =?utf-8?B?K2JRazlvaTlHSlJqd2p0Qm03N1dsVmZJeURQRXpuKzV4NUFEcFE3UkFQN3hi?=
 =?utf-8?B?WGFPMDU5RXZEVGZ3QzRIWld1OXBJTytqcmJGSWZEZGxUUnBkSEN0eno4U043?=
 =?utf-8?B?OG5Hd1pPZ24zemM3ZVp4cU5MamdwZUtPRjQ5VUNmd3cyWVpIdC9tenVnNUJW?=
 =?utf-8?B?WTYvSG9HRzVWMTJ6emx6cko0TUxEeWdjMnZ3bzQ5aFk5cU50SC93RWdFZU1l?=
 =?utf-8?B?d2FzcUk0TjF5bHVrWDJ1NjN1N0UwYm9hSEJGYTZadzB1K1NqMERheno5WlpX?=
 =?utf-8?B?c3AwZEVaRzVyREl5czgwc084TnoycnNobnEzcEFRLzNPVzR0V1M2OUtBbnhx?=
 =?utf-8?B?VVBHWTVUa09CUWg3WGlGcUljbTlnYWk2SUZjL1puWmk1NmFyV2RXUDE1QWhS?=
 =?utf-8?B?RmFtNFJGdStFRmlJQWc5L3BvV3RVM0JJejY4azg3M1grY3I1bUNkYmdzdE9k?=
 =?utf-8?B?bk1NU1BMVTdpZklFYjhPRWpTNFFYT2FuZUdEbkpMUi83VGJxdVgvOEtaM1VM?=
 =?utf-8?B?UWpxeHpMSGFQQU4rdkxpc0JOMitHK2lrWjZDRnV5NjRadTlmSGVnblkrM1o5?=
 =?utf-8?B?NFhHdzhML2daUzdMbjUrN1RHeTlSNndXWTBJbkh2Ly9idzQzM0g2YSsvRkxB?=
 =?utf-8?B?VGpLNjRwaG5YbGxxdHpmMkxOZHg2bStOZDV2Ny8vYW1TVHZQelRRbW12YU5K?=
 =?utf-8?B?dGIrQk9OclVXSWRHTGt5M01OemRoajNVb0J1Rmg0LysrYk1XNk9JdlVPSTZL?=
 =?utf-8?B?eWZGNGl5MGRZQ3JYb2NYdDA0RDZzVGRjemZWalBpWlJna090Z21yeTkxOFVL?=
 =?utf-8?B?eHVpOUswZXI0cEFqMzRsRkFmcUdBUFBlK1lCNHVvQlZtbmkvQnBMeG1SVEZa?=
 =?utf-8?B?QWw3WG5LeENLWmRYRFUxV1lHMks2eFFpTDZpY2ZLNlpjVytsbVJQZTkzYkFT?=
 =?utf-8?B?MXoybWtqV2ZiTWVIWmp6Z2FycUpkQ3UvTVBUKzdLYWhIMzNVaGN0dTJ6MEpJ?=
 =?utf-8?B?aWtVaE9CYWh3cjN4ZHJDRHNtVmZBbGtMVDRHcnhvYXhsK3dFbUZsSldLWDlR?=
 =?utf-8?B?R2c2TFE3N1NxNkpma1pNWkNjeWhKdWdPWjZlalVKUnZHOG9vV1A2c2JOQ0kr?=
 =?utf-8?B?YVVoLzBQRkk5c1pHck1BdktQRnB4YzFzSUNIaUM3R3YxZ3hqY2V4ZjhjY2l6?=
 =?utf-8?B?a0NVOGdTZG4xZER5dDQwNXVKVVpRV1dkVFM0dDJtWi8wNUpBMWNjL2RpcW5p?=
 =?utf-8?B?aUNMTFM4N01OdktBK2xKRTY2TGtLbjAyZVk2akJib1Q0Vk5pRm0zR0hFOUlP?=
 =?utf-8?B?SVlzUDI0R2NWeXRHQ2VzMzJVVVE4YnNCeE1Scm93MFg4cUd1Nmx4cnRjbXpF?=
 =?utf-8?Q?BcpM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75ecc43-a704-49f7-11dc-08dccdc1d6cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:45:59.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYRs2s1/5m0i1Uj8MxzI+rq3RmIBRxW8uQUX3I1NDxuaEJk5KQLlT0eW8vA60e2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755



On 9/4/24 15:20, Bjorn Helgaas wrote:
> To me, this series would make more sense if we squashed these
> together:
> 
>   PCI: Introduce PCIe TPH support framework
>   PCI: Add TPH related register definition
>   PCI/TPH: Add pcie_enable_tph() to enable TPH
>   PCI/TPH: Add pcie_disable_tph() to disable TPH
>   PCI/TPH: Add save/restore support for TPH
> 
> These would add the "minimum viable functionality", e.g., enable TPH
> just for Processing Hints, with no Steering Tag support at all.  Would
> also include "pci=notph".

Will do

> 
>   PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
>   PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
> 
> And squash these also to add Steering Tag support in a single commit,
> including enhancing the save/restore.

Can you elaborate on save/restore enhancement? Assuming that the first
combined patch will have save/restore support as suggested. Are you
talking about the ST entries save/restore as the enhancements (see
below), because the second combined patch deals with ST?

        st_entry = (u16 *)cap;
        offset = PCI_TPH_BASE_SIZEOF;
	num_entries = get_st_table_size(pdev);
        for (i = 0; i < num_entries; i++) {
                pci_write_config_word(pdev, pdev->tph_cap + offset,
 	                              *st_entry++);
                offset += sizeof(u16);
	}

> 
>   PCI/TPH: Add pcie_tph_modes() to query TPH modes
>   PCI/TPH: Add pcie_tph_enabled() to check TPH state
> 
> And maybe we can get away without these altogether.  I mentioned
> pcie_tph_modes() elsewhere; seems possibly unnecessary since drivers
> can just request the mode they want and we'll fail if it's not
> supported.
> 
> Drivers should also be able to remember whether they enabled TPH
> successfully without us having to remind them.

