Return-Path: <linux-pci+bounces-35296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219CBB3F174
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 02:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55182010AE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 00:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1982F2BEC4E;
	Tue,  2 Sep 2025 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FfVTbUNP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FB33E7
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 00:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756771947; cv=fail; b=X4HzBdsX6hEe+pmjVOOdidb3JLyaLXaDHNCegBQKOIn7pEaQxRA8yhHoRaIdGFJ5aqwdfqgIVRskf3L68vB2/Ocl2vRFoSemDh3zYq3Bd/mO1Yo1TkEFBtWlTwDBNCOWm8eXW/ePSThk+Tw65nZT05KHK7TRe7USpVSNTxLO6Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756771947; c=relaxed/simple;
	bh=P2/JFis463//OonSq5KjTEg7VjiLPM0sUmtgjAcgPvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JykfmxDRb43Jl5cTTM5wiKKtQ21R7BO/WpbyI/dmU8vTmjdDxza9cVYNlTsAR129OCve6XDRUa9IDhCwSn7L7xa4W5IJurWA36X6+EHhge+Z7uXam3Xv3wwZVJXtolEOpE/qJjiq0T1pR/rvgyTfbWvaZ1GEObUIMA1W9+Q6OqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FfVTbUNP; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gcd0xyGtfmZY2EZElD0LrAPKGFCg+eLzqlp+0NPKq7PzrI+KWhestRs4qY/m3/RlEvccEhsHzw0Zy9+M2SJGIzCv8yi+rQut8WkmWo8k7ILBW8Oklr7Uz45PuWl3MemG4jkvTACGQWQ7/RLUaiGztSA3oBjq4Gi1zSozqUsyGAQgNDAD4KvNbHZ6xco6dd+u2Ol9i7R4oyiZPFs/g9Z0QL05uCzwZSLA1ZsGfkBk9UnAATovqEFbJyHcGGRS8o25RGhDCVkQhmj3BvI65naXovtv+haHbA+sruTyvketzn7Qulewe1H8Cm21jXNeIxKOGimBM0PWmFT4lJZD8m0P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9xDY+xxUzFI1u0gUqwVMoRVLcJEmmwtUgXsgsE6ZPc=;
 b=ndmpNaAfWcYKur9fvwGIcXyQIaYz5/qyB3CFBanCw6d+Kh0bIPs92SpLGmEfzrGBMH4e4BzYi5zkkgOYsBOJDb2BgcYSsIBsC++hDO70d5nEqj114R68UMhhOHgsManBDVTtr5OppHBPvFAGfSutGWnBkssDqDZc6bzkD9HYS0k2NT1zg6DRd0Yl8XkGFtZFrDkZHTswhivi6UT8vO1B1EzbDUsC7Ni895b+IOFr/eJY+1Vs6mWykUCs3QLFuoQ0AFTv/CVH0ABPYgNipYoRUcviTi0AwjqOz1hfQMKMjTmoeo42T5v+Oyzpb6ezxyC4yGCoA8tN5406Dh0d2DNB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xDY+xxUzFI1u0gUqwVMoRVLcJEmmwtUgXsgsE6ZPc=;
 b=FfVTbUNPs0sndssd+ERqL/wunchUqopgBa/LCBGSlE/QAb/+xCw9rylydlnwnvPApDD8MyAKRNuaiAkChX4QmmxjTcYiZCHjqcvtKvRyxJrq2Htxgm1kDFzll53FzypnYxop/NMbl52Sm2o2icmL3NQZWEvF+9WP14a+v1YOWrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 00:12:22 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 00:12:21 +0000
Message-ID: <ccc6dc78-4338-41e6-b8d6-fedbaff4cc8e@amd.com>
Date: Tue, 2 Sep 2025 10:12:16 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com,
 yilun.xu@linux.intel.com, aneesh.kumar@kernel.org
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20250827035259.1356758-2-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY6PR01CA0146.ausprd01.prod.outlook.com
 (2603:10c6:10:1ba::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 713cb510-7758-4c75-ec76-08dde9b562fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjFuMDNOVUxaVWhKa0FBZ0JQNEJIQ29HZ3p4bFkySHNCblhDb3BibFptVFJC?=
 =?utf-8?B?QjY1d0lmbTFBSFJURkVjemNSbnJrT0JYRkVqV3Fid0dUR1VXSllnWStDdDVj?=
 =?utf-8?B?NU5zYmxuZ2JQNmZncDJleW0ySXVKUk9iUFZTZFRkZ3dmUDlkNHQ5Vnl4dTZC?=
 =?utf-8?B?bGI1aEozQ3JkNVBYMjhmWGlHaG1Za2JTUmRVbUJJTTBwZXFvbzZPNzFWbzlx?=
 =?utf-8?B?NlFYN1V2MEk4aU5jRnd5YWo3UGNhVUU4QnVWUjlzOUVPSTAwRTRFZFJXeUFo?=
 =?utf-8?B?ME5SYzBXUFlxUDRLZHZlR2J5RHpDN2dJSWkraDZIOTJWTS9rc2EwUjluTkJh?=
 =?utf-8?B?QUdnWlZPQXN0L1VOOStmQ1hvM2FERlJrcXJJT0dqZll1Rzhmd3NJYWthSHhH?=
 =?utf-8?B?NUIyUTBWeVlPbnBiSy9zYW0zcVEwalZ3ZzBuUWw4S0thek5EQ3NFRzhtYWN5?=
 =?utf-8?B?RzdRWUx0OHdQRzRIYzNFdXpqQ08xc0VIN1c5aWlzeXlqUGRTM3J2bitYWCtM?=
 =?utf-8?B?SFRyeVFrcFJwYmZQVnhNNjBNOGlXUjlETUFwR2NFdDNWZ2RGOUEvZWlDbGZ2?=
 =?utf-8?B?T0h6SnNOQ2N3dGwwQWpkb2JIOUphZTBsZHRHQ0pNODNVS0kzdjVpUkZXdmRa?=
 =?utf-8?B?N0RVcHQzTlYrM1pLdkdZNWtZU0ZMMVNUc0lORVVBSVQxSTMvK3dBbHlNb1VV?=
 =?utf-8?B?UE8yNysxV0hTdFc5U0Q3RVVWU0JBRC90eTRtaDVLS1c0NlZneXhUcVlyZ3JW?=
 =?utf-8?B?a1pMM3Yvd0pydFlJQWY1bmtqMWFRSDRyMmRUVGtNRC9sRUFhZTg4YTV2OXhD?=
 =?utf-8?B?WFhVb3d5RTFlT3V5bExMTGkwanE2aHlxUWtzMUJ1Y2FCcGh5T1VPbmxNMVo5?=
 =?utf-8?B?R3BybmlRTm4veVZOVlUrSnNLWDVDaEdQd1FHNlAyOVdtbC9MemJvSnNTeUc0?=
 =?utf-8?B?bm1ZdFpuVTdTUXppNzRSblczNElBdnE3OXplbkVDTi9SYnhrUHhSY2ZqdWlj?=
 =?utf-8?B?Tit3WVVKRkY2KzFaQ2dNY2xhUEVuQkNzL2g4dDNUeUNzYkthekt1bFJjY0dj?=
 =?utf-8?B?a1hhYTlwWnJncmRMNC9GMzJyRFViMmFIWjRaMzB5UGFraUNXd213TG5lYktU?=
 =?utf-8?B?VkJHOFRHN3c5MFJxQ2lvQmlqNU5TTExnUHRIbVFVNHlvYUVQTWZCdXdiT2E3?=
 =?utf-8?B?NC91K2lwUlZIcVFtMmgyUUJId3dRVWIzeXlZMXJva0dMVmdSNndia1dkcW5S?=
 =?utf-8?B?MmwxaHl5UXFuNkEwZ1loMkQybnl4NzJ2V0dkSmFvckwxbWpCaXJRd3BTN1No?=
 =?utf-8?B?WFovaDJjWm52QzZrZ1F4Qmxrc2pzeXpaMkJvbHUvZm5SWXFkZWVVOVVNaHhn?=
 =?utf-8?B?Ukt1UzliYnRPRWV2MmJwdWRXd2VmUjRGVTFPVlNZZDY5b2ExNk9Hc1RxQ1Rq?=
 =?utf-8?B?bnNQaVVib0JpZWRac1dGeFZGVENwbWVVOUo3ekl4alFXaFNYYWk4ZEdyR0Jw?=
 =?utf-8?B?dTdpRFpXUHRvYmJPdk4zMnQ5dEFJNkY5RWdGS0ZBTExBVk5DWUF4V3dPNlNK?=
 =?utf-8?B?bW9WZzgzVFltQ3pSSDVzMkU0TGZZV1A2K1VvR0tsSmQzMHlhazk4TVgrQmZo?=
 =?utf-8?B?NU5vWm1MQ1RqUWdhdjJxY0pOQVBiUER4WWZKSUdscmhROHo3UDBDVDYvYWd5?=
 =?utf-8?B?eTBwbnU3MUJpZ0sxaDZDeEZQOGZJSnJCemw4Vm95dk9hd3FicUhnL096TFhu?=
 =?utf-8?B?ckxQamdCMW1Qb0xLWjRwTmt6OVNoa2pjS25pWEFNdk1STm9ML1ExMG5xbnVK?=
 =?utf-8?B?MHExSzZ0eGdqb2VkUzZUbGpqcWFzaDBJNnpNRGFzUDMvRVNQL2FHVDB0NHJx?=
 =?utf-8?B?TkM2WFcyVyszaTVyM25KM0FSb2wyTFBaUnhWSGFQMk8weEMwV05xZzZQQ1F2?=
 =?utf-8?Q?9qfaGXF1efg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YThhVzMrYmNodjhPMFJLSW5VVkJqWWFmTGhXdmt2OFdIai9MVG8vOHNDSGVY?=
 =?utf-8?B?M2ZGdHg0TWpaUmtBTU5WVEJkNDl2U2JqMWpHVFFXRXpJcEU3SFFTakpUeUFy?=
 =?utf-8?B?cERrSUxEeDAxQjJESnpGMzlqRkxrOXlFclJZSENpOVBrc0xPN3RlblMrdjh1?=
 =?utf-8?B?Q1RIb1J2KzJYMVltU2tVa21iQ0hpcE1zWFpUdG1yTXpyL2N0ZDllaGlZb2U4?=
 =?utf-8?B?SFo0eDJKM3NQRFJqVzhrKzVGanoxYzY4NGtTYXhucCtLd2ZXa2J2M3A0ZG9z?=
 =?utf-8?B?OHF3ekZKbHhPL05jM2pvY2ZKaXdZeGJMMFdrVXdERGlweVlGbTREZHMwcjhQ?=
 =?utf-8?B?TnY2NERTWU1oUmFLd091THNMekV2NExtM1NFOWVkOWhHM3V3cXBIYzFLT2Ri?=
 =?utf-8?B?Qi9NWmloaGRrL29kQUtxUVNNTXd5bHVZYms1ZW5FM3RadThMU21QWG05b3Nl?=
 =?utf-8?B?MWd1ZHFpZEVhSDBEWEdKY3lMM3Y0Tm1uNHpvRHFkWDdmU3BuQjBaNWJBMFBj?=
 =?utf-8?B?RVhac0phUWtqc2QrN0NRcHVIYXlrZDYwRm5acW84RG13anJ0Nld0M0ljclJI?=
 =?utf-8?B?bjlqOXVCM2lnK0Z3cSt6WnRsbE91dGJpcXVzRENYd2N4RnNieUxYeVdvbENN?=
 =?utf-8?B?OHBiZzBzYmU4aTgzZGMzaDlvNHA2SThhYzhWTWpaUlh4ZlhURWhzUlJHOW5K?=
 =?utf-8?B?QmpWd0hhdnZTRHZ3OTdGN3lrb3pTTkFYTEUyWGN1SUFRYVcrSlFQeHVXa3dT?=
 =?utf-8?B?Ujh3R0hQUklZYVlrbWJNbGR3WXRUcmgwbzh0Mi9LSlNDVm8wNTlmL2xOdlVm?=
 =?utf-8?B?SlNQb2R3b2k0WFFHTjRmY3E4dkdEMVprWnVlWjBrNkMyUGxmOFE4L3RlRFZB?=
 =?utf-8?B?SDM5Sm1qVCtSeW50QVJNbEhKTzV4Y0lVL0U2TEMzdi83RE5mcTVTL2FqSHdK?=
 =?utf-8?B?SzI4U1Zlc3ZDUUhBWldSZDFlckw1dEg3VjBOWk1Hc2x0MXliR1Q5UDNaN2Q2?=
 =?utf-8?B?a2FFWVF6UzR4M2taUmllU2FQTVI4SmNFZXhYUURIb0pQRUNwZFNzaGE5QnVz?=
 =?utf-8?B?aTFoRDAvQk1aaDhkQk1FR05OLy9YSTJwVjRsSktET3pPWHZrU0xXY3pYMkhT?=
 =?utf-8?B?N0ZiK21RMHpSTmRpb0lveVZNUGFpVVFEVWR6U2RLdGxEWmlsUXJJL05CelBq?=
 =?utf-8?B?dEZ0LzV4UU5SR2NxUEFUbjhiZ1k3MnZZeFFEYTRaMFIrNDJqWmVtUnFtUFdH?=
 =?utf-8?B?ejBTYXZBb1hyN3c0WlNBbU5RZGh1YVRURDBHME1FcnV4b1Nja0o4Qld1a2Iw?=
 =?utf-8?B?YVJxRlBpTE9yZ3V0UUY1cFlPcmlISlYwcUNzZXJTV3BHMXdjM1pKQlRHcDU3?=
 =?utf-8?B?Tm5CV1d0SlhWUU5nQ2xTSnhYY3I3V2hVeW1aMTBwQ290R2p5K2lBTkozRDkw?=
 =?utf-8?B?VXFna3djU1RQQnp0WUhPbU45UDR5bGtLUFd4ZkZRZWNGSWxPTmhFQVRhQVV3?=
 =?utf-8?B?R1BrUXhyUmd1bWFWLzFVT0lqZTRRYUkvdWo1KzNDcmtJMmJlZjFSUzhxMk5X?=
 =?utf-8?B?dm9xQlVtSzBwZU9HQ3JTNjdvenp3TDA1aWhyanErZ3cxSWd5U2xvOEc4MkJy?=
 =?utf-8?B?VEtLTCtzNVNFR1ZPbHc4N29uRXVtTUx3ZlBXTjBNZlN1UkJCR1VWUHlZdlMw?=
 =?utf-8?B?dlhXKzFNeDhtRE9aRmlGY3lqRXUyMjRMSzAyb3I2dUcvSEg1dVNsdlBSOS9j?=
 =?utf-8?B?RzNhNlBoYmQ0NVoxazZ0dFpNV29mRGkwMi9yd2g2Rkd4ZUJFTC92YlBEbjZk?=
 =?utf-8?B?WWdyUjg2LzFKT0pTUEdqOUFxZ2pVMG5RNUx2Qm9RWUpCUjJvT3ZlNjVsTmd3?=
 =?utf-8?B?WWY2NkV3bC9qZmV0TW1mQUhETktaWWE5UUlnTG0wU2dCMFhGd3FsQVJzaS9q?=
 =?utf-8?B?UThqdkxuMTk1TmJWcEM4VlJvZ2E0M04yNktQb3RCKzZtUGVscjRVdDd3eWxP?=
 =?utf-8?B?eEUxb255OXBMQWpBczl6K3FCVzUzNHNFSXh3eE1kWXJVWVZTYTFDUWswaElI?=
 =?utf-8?B?NHh0c3hhRzVKRk5GcUZOaldLdXZZQ3RUY2U4QlJIaUc2Smk3WHl2dzNGZVgz?=
 =?utf-8?Q?ghCWNuSZHgBdWcKn2tVa2N1VX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713cb510-7758-4c75-ec76-08dde9b562fc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 00:12:21.7313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rxM8kDQoU1bVAPCJHzEvaRLvZuRo/g8RpU13UnEPP5rULabhWAL9VaVLvHqPGQuwADG3j7ttlgiGhzaR9R4ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856



On 27/8/25 13:52, Dan Williams wrote:


I suggest changing "pci_tsm_{bind,unbind}()" to "pci_tsm_bind/pci_tsm_unbind" or "pci_tsm_bind/_unbind" as otherwise cannot grep for pci_tsm_bind in git log.


> After a PCIe device has established a secure link and session between a TEE
> Security Manager (TSM) and its local Device Security Manager (DSM), the
> device or its subfunctions are candidates to be bound to a private memory
> context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> Device Interface (TDI).
> 
> The pci_tsm_bind() requests the low-level TSM driver to associate the
> device with private MMIO and private IOMMU context resources of a given TVM
> represented by a @kvm argument. A device in the bound state corresponds to
> the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> it involves host side resource establishment and context setup on behalf of
> the guest. It is also expected to be performed lazily to allow for
> operation of the device in non-confidential "shared" context for pre-lock
> configuration.
> 



> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/tsm.c       | 95 +++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-tsm.h | 30 +++++++++++++
>   2 files changed, 125 insertions(+)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 092e81c5208c..302a974f3632 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -251,6 +251,99 @@ static int remove_fn(struct pci_dev *pdev, void *data)
>   	return 0;
>   }
>   
> +/*
> + * Note, this helper only returns an error code and takes an argument for
> + * compatibility with the pci_walk_bus() callback prototype. pci_tsm_unbind()
> + * always succeeds.
> + */
> +static int __pci_tsm_unbind(struct pci_dev *pdev, void *data)
> +{
> +	struct pci_tdi *tdi;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return 0;
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);

What is expected to be passed to __pci_tsm_unbind/pci_tsm_bind as pdev - PF0 or TEE-IO VF? I guess the latter.

But to_pci_tsm_pf0() casts the pdev's tsm to pci_tsm_pf0 which makes sense for PF0 but not for VFs.

What do I miss and how does this work for you? Thanks,


> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	tdi = pdev->tsm->tdi;
> +	if (!tdi)
> +		return 0;
> +
> +	pdev->tsm->ops->unbind(tdi);
> +	pdev->tsm->tdi = NULL;
> +
> +	return 0;
> +}
> +
> +void pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +	__pci_tsm_unbind(pdev, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unbind);
> +
> +/**
> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
> + * @pdev: PCI device function to bind
> + * @kvm: Private memory attach context
> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
> + *
> + * Returns 0 on success, or a negative error code on failure.
> + *
> + * Context: Caller is responsible for constraining the bind lifetime to the
> + * registered state of the device. For example, pci_tsm_bind() /
> + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
> + */
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
> +{
> +	const struct pci_tsm_ops *ops;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	struct pci_tdi *tdi;
> +
> +	if (!kvm)
> +		return -EINVAL;
> +
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	ops = pdev->tsm->ops;
> +
> +	if (!is_link_tsm(ops->owner))
> +		return -ENXIO;
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	/* Resolve races to bind a TDI */
> +	if (pdev->tsm->tdi) {
> +		if (pdev->tsm->tdi->kvm == kvm)
> +			return 0;
> +		else
> +			return -EBUSY;
> +	}
> +
> +	tdi = ops->bind(pdev, kvm, tdi_id);
> +	if (IS_ERR(tdi))
> +		return PTR_ERR(tdi);
> +
> +	pdev->tsm->tdi = tdi;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
> +
> +static void pci_tsm_unbind_all(struct pci_dev *pdev)
> +{
> +	pci_tsm_walk_fns_reverse(pdev, __pci_tsm_unbind, NULL);
> +	__pci_tsm_unbind(pdev, NULL);
> +}
> +
>   static void __pci_tsm_disconnect(struct pci_dev *pdev)
>   {
>   	struct pci_tsm_pf0 *tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> @@ -259,6 +352,8 @@ static void __pci_tsm_disconnect(struct pci_dev *pdev)
>   	/* disconnect() mutually exclusive with subfunction pci_tsm_init() */
>   	lockdep_assert_held_write(&pci_tsm_rwsem);
>   
> +	pci_tsm_unbind_all(pdev);
> +
>   	/*
>   	 * disconnect() is uninterruptible as it may be called for device
>   	 * teardown
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index e4f9ea4a54a9..337b566adfc5 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -5,6 +5,8 @@
>   #include <linux/pci.h>
>   
>   struct pci_tsm;
> +struct kvm;
> +enum pci_tsm_req_scope;
>   
>   /*
>    * struct pci_tsm_ops - manage confidential links and security state
> @@ -29,18 +31,25 @@ struct pci_tsm_ops {
>   	 * @connect: establish / validate a secure connection (e.g. IDE)
>   	 *	     with the device
>   	 * @disconnect: teardown the secure link
> +	 * @bind: bind a TDI in preparation for it to be accepted by a TVM
> +	 * @unbind: remove a TDI from secure operation with a TVM
>   	 *
>   	 * Context: @probe, @remove, @connect, and @disconnect run under
>   	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
>   	 * mutual exclusion of @connect and @disconnect. @connect and
>   	 * @disconnect additionally run under the DSM lock (struct
>   	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 * @bind and @unbind run under pci_tsm_rwsem held for read and the DSM
> +	 * lock.
>   	 */
>   	struct_group_tagged(pci_tsm_link_ops, link_ops,
>   		struct pci_tsm *(*probe)(struct pci_dev *pdev);
>   		void (*remove)(struct pci_tsm *tsm);
>   		int (*connect)(struct pci_dev *pdev);
>   		void (*disconnect)(struct pci_dev *pdev);
> +		struct pci_tdi *(*bind)(struct pci_dev *pdev,
> +					struct kvm *kvm, u32 tdi_id);
> +		void (*unbind)(struct pci_tdi *tdi);
>   	);
>   
>   	/*
> @@ -58,10 +67,21 @@ struct pci_tsm_ops {
>   	struct tsm_dev *owner;
>   };
>   
> +/**
> + * struct pci_tdi - Core TEE I/O Device Interface (TDI) context
> + * @pdev: host side representation of guest-side TDI
> + * @kvm: TEE VM context of bound TDI
> + */
> +struct pci_tdi {
> +	struct pci_dev *pdev;
> +	struct kvm *kvm;
> +};
> +
>   /**
>    * struct pci_tsm - Core TSM context for a given PCIe endpoint
>    * @pdev: Back ref to device function, distinguishes type of pci_tsm context
>    * @dsm: PCI Device Security Manager for link operations on @pdev
> + * @tdi: TDI context established by the @bind link operation
>    * @ops: Link Confidentiality or Device Function Security operations
>    *
>    * This structure is wrapped by low level TSM driver data and returned by
> @@ -77,6 +97,7 @@ struct pci_tsm_ops {
>   struct pci_tsm {
>   	struct pci_dev *pdev;
>   	struct pci_dev *dsm;
> +	struct pci_tdi *tdi;
>   	const struct pci_tsm_ops *ops;
>   };
>   
> @@ -131,6 +152,8 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
>   int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>   			    const struct pci_tsm_ops *ops);
>   void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
> +void pci_tsm_unbind(struct pci_dev *pdev);
>   #else
>   static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>   {
> @@ -139,5 +162,12 @@ static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>   static inline void pci_tsm_unregister(struct tsm_dev *tsm_dev)
>   {
>   }
> +static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> +{
> +	return -ENXIO;
> +}
> +static inline void pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +}
>   #endif
>   #endif /*__PCI_TSM_H */
> 
> base-commit: 4de43c0eb5d83004edf891b974371572e3815126

-- 
Alexey


