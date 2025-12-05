Return-Path: <linux-pci+bounces-42680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F657CA6267
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 06:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B76230CE574
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 05:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7AB2DCF6C;
	Fri,  5 Dec 2025 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VqrXJgDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012027.outbound.protection.outlook.com [40.93.195.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4A62DEA79;
	Fri,  5 Dec 2025 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764912526; cv=fail; b=Kp2lhE47rM9SVGdI4GVqrQcDkgZV4HBqA8U3u/eOkOW2ayMzlOTcz5YuMDXunAElRh5AMBGJ1neyL8HRSljFITnNCAXQUpNocqHF2vGuEWNCuBZSA61KA+TK4OeYix8HDeHd9smtT7oSPUlAW0Sp695HfIk2t/kwhBx3cUV2M3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764912526; c=relaxed/simple;
	bh=25oq0/7T/oC7aOsISCMBFoWmeCpiiulm/nU0qXP26KQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YWHd1smqbp2fHg5ljhcg8RobxJoxsjFUId179n7rL3m48COVqwIgIXk2Pve9K4VkpoNfV5HnJgkWFC2UHDwYEB7YPWqmQFE6qnD/BPoSZut0/MNvm3IP1zmuBa736De8PSulwLG6nbjwOUI5oaOO7kz5fCgJeX/yvXyR74RpFYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VqrXJgDW; arc=fail smtp.client-ip=40.93.195.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jphs7jR8X6YVISxGDEGyXuP4hl8J4amebAwKUU07aChCzxRQJSLQhtOg3n4Qm7/NGjMiK2t9KDGMN4MfYC1BH+0SmzcFfGk1VbCU5tw35a3n9AY1Xm717vIjR9ePXUzwbVvQ93ZAB/dSk/neNCWAy8ZZXovREuXowH1Xcl35Wfn/vnGtvJa+qToaHx9PNAFQFYaj8OZ+k2JNXqjdciosxUSg+UafhzVhPIrm4fZBBVxsjY8UPa/wHEc4I/8N8mjgQKfxlZVXMgcNl6UsKyJbM3zP1EKjwGiXQjrdvCicI+UjUQQfnrtph+be/hIdk5/ZXdnxc+UE8+vpv9V8ZpwETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tS1pv0HTAMtC6Mtkm/yXi1LOVmdoA6/RTom9V3xhMUc=;
 b=XRqEFtjoRnXe9ly7LnIw1vc1wzIZdsgTPEHIa85nQCvtqvfkj2S+C9c/tLIWsJuE1dProlRtupY3QsDCOvVRJvgYasxR/BrLvksxm3Dm4V90sSgzkT1qoEfHaQ/Emv9qk/Gr8hxu3kBXd7AF6mQgRX95tvfphGpLgfC7TT4MMCZim/KagbEaCL4j7swn8mPSCq8yFS95OYMEaFCUjlSmCChf8gMFJFJYMtaRAiisYWG2wCB7v/J9f3LuJCBULM9m6OBjzqJwRpWeIi8K1lL9518A2gYTU0OnFI7b3wM3wK/oE9vcA6a3gBvZPkh7nY6R2LT9felNTK+xWSmXJ1ixQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tS1pv0HTAMtC6Mtkm/yXi1LOVmdoA6/RTom9V3xhMUc=;
 b=VqrXJgDWhFABUgi3AO0Rc6K9K6mVsXSPwchO6T+hOuapZjluUQe/APmKDLG3krmHTyN1xpdQS7RgNxoCqCTO0yeo6ynOJIWDyZh/WUh/LiNr/g5j4n4Fhbl5pAqKOmiPIcAcCRkYLNcsr/Uq05ghqPcg2Rv0KrgY06wVo993Qyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 05:28:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9366.012; Fri, 5 Dec 2025
 05:28:41 +0000
Message-ID: <2f0d1cc9-d93d-4d24-bb4a-edec89e7bbde@amd.com>
Date: Thu, 4 Dec 2025 23:28:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PROBLEM] c5.metal on AWS fails to kexec after "PCI: Explicitly
 put devices into D0 when initializing"
To: Matthew Ruffell <matthew.ruffell@canonical.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <CAKAwkKvmdKxRRA4cR=jJEdyadon6uKXe+aFXaGSe=PNSgwDf9g@mail.gmail.com>
 <cecdf440-ec7b-4d7f-9121-cf44332702d4@amd.com>
 <CAKAwkKvmZUGi+gEhr1nw5MV+rfyVP=Exu4AW1_WOPHDH6tSYug@mail.gmail.com>
 <222da706-19c5-485c-be90-2ebda20c1142@amd.com>
 <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAKAwkKu4bePg_NJ9SORcvwgkKyrr7yhGVjFyDQR+d18MtrbyDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:805:66::38) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 921304ed-1f57-406e-4567-08de33bf26e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MU5oWG5haXNhSDhlaWg4MTNhWWphTithOXBYS2lZYWxZMEYrNjZZRG1CaXNT?=
 =?utf-8?B?clRIelBFM29jMUtDV1RodE14RDNyRHNpMTIrdFVOeUhDdG53dnNWcjdPa1Vk?=
 =?utf-8?B?dFFJcGhaR1R3ay9kQ1lGTHVNVENiWnFZSEV0YkU3QUdNM0ZLMUNZK3lWS1ph?=
 =?utf-8?B?NUhuZitmUndIbDErdjFoZ0J5cG5RcEl3ajFUWkRENEkrQkxVcktOL0dHcXI2?=
 =?utf-8?B?TDlQOHRRL0tQLzQ3K21ydFExZUU1MHRqWDhHOEgvbUNBRzZjcERFcjFmY2o3?=
 =?utf-8?B?cTJRRlc4MlQreVE3dlExRTNKZ1g3dm0vbENFTm1BVGhjclFWUUpoZk1MR1dZ?=
 =?utf-8?B?bUdZbDVGdG9MQU5FMG5mcWdvRDNTSjBaMHJMcG1FWlc5c3FncUVWUlduVitU?=
 =?utf-8?B?Nlp6U1dtS005U1pUK2c0bENQb2VDUHByUVVuNGd1U2VmRjVkWGJrNyt3Vnpy?=
 =?utf-8?B?UXhBWHVMVDdWcW9iZy9oY2h1NGhyc1duMnYycGdMZjZwck5ZVE5oS1J3d3VO?=
 =?utf-8?B?MkUzRk1SZkdENkhYM0d6ZG01dXUyZG5LVHliWGJGUmhUQmZJbU1BWkxWL3lx?=
 =?utf-8?B?VFpMa3d4MUY1T1J4VDZkV3pjSGU0SHJnaUZkSGhPajJTNjJucGFEbHBkcWJQ?=
 =?utf-8?B?bXBKR2VWaXpmWUJXVWltTUJoSjVHQ0RNd1ByeTFIaGdpUkhHd01ZYUVPT0tq?=
 =?utf-8?B?K1diazJvVUh4NzcwWENRU093Wk5sbk40Tkd3WWY2cTJzMWI3UGdib2p3eHgr?=
 =?utf-8?B?MktPRnBSK1BuQzQ1MmV2eVZiRWRUYjI3bmRxWDA5UzBQbklPL3lYRjd2VUJZ?=
 =?utf-8?B?bXUxQjNUSCtCSDJjc0RFWWptZ2pTbmF0S1BOM1pDcjhJcFBqRk41NkUySU9Y?=
 =?utf-8?B?WGl5SjhPYTFjS2dreEFaWkY0SVJabzNxbEVFVTJDN3FzbkdJNCtNbW5OSlMw?=
 =?utf-8?B?YUNwU0VmNGtHOHNjMy9DVWxTeWJDZVg0K0xSRE05MFM2WWNQVWNZMEVZaU4z?=
 =?utf-8?B?RmNmTlh4ZmhyeEJ5YWRTNVhZSkllSTJsSFRzbkJyZmNOZzBzQkhBeThGUWUr?=
 =?utf-8?B?cWc1OXFlSU1ZSWJiUUlwNlZqZy93clMySTVkdnllTXJ3enB5b3p3L1JhQlIx?=
 =?utf-8?B?VWg4dzZiMUI5cmFKeC9uYmVjYUM0ekVkeUpQMkhpbVcvTXhmVk5kSlZCVTlY?=
 =?utf-8?B?UzkvdFh4aXprN3Q5M2c5Zy9DeFQzcS8xcXNVOU5aQ2JSOFY4T0ZVY0Q4Tkx4?=
 =?utf-8?B?ajU2MEJscnNnemRQMzhYcmE2b1ErNHdVb2pwaVIxMFNxYVBMSDdGSWt1SVZZ?=
 =?utf-8?B?MGFLdnpGWjBST05SbWtDNS9KUHhZbmpVR3ZwZVJpVEtxSkx4aHczK0lIQ1Ju?=
 =?utf-8?B?b3d0dEJxci9MVE1OMUFvWmZrL1pHVmxUMS93MlNNNzl1NUErcGRnWnVmejZw?=
 =?utf-8?B?RnEwWU0zZzRDTmlVM0tFYmtTbW5XZWJrNGp2cytMNDVnVVlhSC9jMVV1dU1L?=
 =?utf-8?B?UjlHelZ4bVRvMSs5cm1VSmJoK0ZMSTkwWDFtQU92Yjl0eWZIREV4NWY3T21I?=
 =?utf-8?B?ZnF3bFo2ZWJrTUhSbSs2ZVh6RWlKdmxqb3Rxbys5eDJrb3laUkx1VVJ4OTMv?=
 =?utf-8?B?UE0rTU1UeXZpTktDL1FVVUZIK0QxL21YN2Y1M2x3SThXK0dTclpSTVpySGFl?=
 =?utf-8?B?K2tNMWRjZzFUVU9nRjBkRVVrY3BOb2FYNG8xQmZjREdyeUE3WDdzRUJMR1Q1?=
 =?utf-8?B?aHVEbGl0bXBoSVdONUdEYXlVZTR5YS8rZCt4VHAvbFpuZ2JmNnpqRzVQTVVu?=
 =?utf-8?B?Z296ZUF1UC95dzEvZVJ0dUhNWkphWHp1anNvNFJ2czE1UllQMmplNFRaWDdY?=
 =?utf-8?B?M2FXZFhaRTJwcTZkOTNvOHFiakFJaXdVblhSNkRsNGwxNFVjc1FPbGx5b2Fh?=
 =?utf-8?Q?Lw1nxyTA7Osp8oN2jXKD5yLa5mmBAtLF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFZWMXZra1J2aktqRmNHRUwrRnhZcWVXV0JxM1g0RG5SRmdISzVITVowZklU?=
 =?utf-8?B?K3Rjb0x3NGtNZ0dTRlM2bjlyeDdyVzVHbGpFdC9ybVhPcHlwRFR1TEdldXZZ?=
 =?utf-8?B?SE9ocTMvdGgzK3QzYnBKYnhMVHhWdU5GaTVIcktEcDRzMFYzQkpmUU43UjNS?=
 =?utf-8?B?V3RnYlNnbEZnbk5CVGVSc0RKbzIwOVRBUkZUdVk4VVBFWGZsc1FMVWl6MUNT?=
 =?utf-8?B?L0h4U0YzaC9na08wZWNHZFdaS3pJNkFvaDR2Z3VJYTc5VDQyN0hpS3dsQTN4?=
 =?utf-8?B?TTA2dDk4Y1YxM3RnTGpkSlRSV1dHV1ZESmQwckpveDFhekpWa3poN250cldm?=
 =?utf-8?B?aW5tZ0VSNjVycW0xbTdxK3A0dXo4U3J5L29IM3hrZEEwWHZVZWk5U3dFODhl?=
 =?utf-8?B?NTZJTTNmVGxDRmlvTTUyZDZrN1lCMkEzblc4VGdsSm12S3JISU9WYStxdFFp?=
 =?utf-8?B?MzFhRFp1dFF5WDJ4Z1pSeUZBSWV0YVNVTWcxdzBXR3lLS3ZOSnp3K1dnR3VF?=
 =?utf-8?B?MDZXWTIvS29pMWZyNW5mWXo1akU5bGhnTVdheTQzUkw4dWdsWnJOZ2kxL1I3?=
 =?utf-8?B?V2ptdXFPMDNHTWY2Z0F6THpNbG9NaFd4cVNKU3dobEpwWXM1OUNRVWdMWEtJ?=
 =?utf-8?B?eTBtU09iMS9manJYQVNFV29Qc01VYVRVdWVWTXRrSzRRRCtLa2ZQdEJjMlUy?=
 =?utf-8?B?NFZDWUFCRWVPTEVkK2JlU3FidnRFWE5aN3NzMFN2bmxWUGxDQTRJekU2Qjk5?=
 =?utf-8?B?U0ozK2pzZHliS2RiUVM5K203NFVpakIzU0lWT3ZyU3YzNTlWMm5kbm5WV004?=
 =?utf-8?B?RWlkS2JuWnBmLy9qYWtTQ3krN3IvVnBMSG1RL1l3Zkg1ekRwT3g4eGdOdWlW?=
 =?utf-8?B?YzhIYzF5LzJjSHQrNjFZTTdOa0hxcXh1ekJiMWlZbU5wQUprbUZjUEg2T1VX?=
 =?utf-8?B?bzhyY1JTVkgzd3orelBFd1o4NzFLSHczaWN6UGZ2enVGeVQzWHd4VjlzbTRX?=
 =?utf-8?B?d1JqYnV3c1lPTzNabFMvUHB4Y2dwSUVwRG5GYVRQWThUeTFuTWY5U0NyczVs?=
 =?utf-8?B?K3R5Z2RBN2RZejZQNkY4NUVjVjgvd2ErMkVtdUxmYnVXWUppNlZiY2pMK3U1?=
 =?utf-8?B?bkJzdkhHTE1iNTM1TEZweUhEOXhvUEVacExWRWNDQ3h3U1U5Y1ljdEl0RjZZ?=
 =?utf-8?B?cTdZQUJKQ1RmNk02L1JqSjczWlpHUFFBQXEzOENqTGg1d0s2MjRHV2h1eGJZ?=
 =?utf-8?B?N2JKVERWQU5kUStObkN0dFJNQ2RWR2taeFVpN29kSVVhc2pleEdKMnNZeUhB?=
 =?utf-8?B?RStzK09nSStVRVVNb0N3T210bnBGS1RJNnRqUjdTMGZBRG9hbXprS3BQZXhN?=
 =?utf-8?B?c1MyTmlmemkvbHhpUzJqcnFsS3QrWmMyK0Y5UmdlMFVPMVhEQVJKYWFZNndS?=
 =?utf-8?B?cHpwUWlTdWhUQ1ppYXJaYzZMNEZ1R1pzOWRiQllNMFBnb2c1WnY0Q0NhY01x?=
 =?utf-8?B?NGdIT1dyanhhSlZEaE5ZSnJ1a3MzUXZwa3BRclk5OEo3dlZhRDZUS0wwUFh5?=
 =?utf-8?B?S21lbnRZUmJyZWpHRXJpYXM5UXZjMGNBbHhzaGIzMWE1L25FbnBLcFF5N2J0?=
 =?utf-8?B?bHJnRElFWkdpcnBWN3NPc2NFNFN5NTNtc1hlTDNOekNvK3ZEVWpXVVNUbXpU?=
 =?utf-8?B?NUxQNlFKeXhaMEk0M0w1aHJWQlA2RUxVUU1uaENSd0VIUUl5VHRqSHVzb1BO?=
 =?utf-8?B?emlFV25IRmwrdXV3Z2tsQUxxUVkrclVYMkNiakhLNjZENkYvZUpjakhMV3lR?=
 =?utf-8?B?TVFPVkhZWEFsMDJYb3RlajhHTVVETy96dHgzUXBNTENNNzNQNCtxUjdvVWh6?=
 =?utf-8?B?UDJnL0xjbzZ1dnZuQUpFdGcyRnEydG1HU1pSMTZZVTQwRWpFcjgzOExadzN4?=
 =?utf-8?B?YjdxL3ArajA2N0FsdkpNbXpZbnJZZ1Q2ZERnRWNHYnZXSUNOVnhHMFZhZnVH?=
 =?utf-8?B?MklVRVJnQW4rOWNDZ0xON01uN1JSdG5QbDNsZVlSWGJjQVJPOEl4SjVlaUVz?=
 =?utf-8?B?U3hTaUp6REtBYy9EMTRrSVgxZ1N0b0hWampoemN0Qno1WXVjUUV3NUZ5cnhy?=
 =?utf-8?Q?kefkqQrGB5vdfow4OYfkixOfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921304ed-1f57-406e-4567-08de33bf26e3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 05:28:41.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1NWKY+gbbrS4Pl/UCefTsVLVNbGZZ0k1clCdu3+Bmjfks7BlH6b1SvPtXLtrti10K1e0Y9NNLhe9TlqV/SNCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622



On 12/4/2025 9:06 PM, Matthew Ruffell wrote:
> Hi Mario,
> 
> Again, thank you for your prompt response.
> 
>> That's at least what it seems like.  And I guess trying to set D0
>> without bus mastering enabling is causing a problem.
>>
>> Could you try adding a pci_set_master() call to pci_power_up()?  This is
>> what I have in mind (only compile tested):
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b14dd064006c..68661e333032 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1323,6 +1323,7 @@ int pci_power_up(struct pci_dev *dev)
>>                   return -EIO;
>>           }
>>
>> +       pci_set_master(dev);
>>           pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>           if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>                   pci_err(dev, "Unable to change power state from %s to
>> D0, device inaccessible\n",
> 
> I built a test kernel, using the very same git hash as yesterday,
> 51ab33fc0a8bef9454849371ef897a1241911b37
> with this pci_set_master(dev) applied, and yes, kexec succeeds and the
> system boots normally.
> 
> Would you do a global pci_set_master(dev) like this, or would you gate
> it behind a check to see if the system is being kexec'd?

Well - the problem is kexec_in_progress() is only set on the way down.
You don't get any indication that you're booting /through/ kexec.

Furthermore as you point out elsewhere in this thread a crash that jumps 
into a crash kernel kdump doesn't ever set kexec_in_progress on the way 
down.

So considering that I /think/ this points at an assumption failure 
during bootup about bus mastering.

Bjorn,

How do you feel about calling pci_set_master() in the startup train 
somewhere?  In addition to Matthew's testing, I tried on a few systems 
of mine and it seems to work fine with calling pci_set_master() at that 
above specific location.  I checked with that on top of 6.18:

* Regular Reboot
* Kexec Reboot
* Shutdown / power up

