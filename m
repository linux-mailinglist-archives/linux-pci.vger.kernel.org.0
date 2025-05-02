Return-Path: <linux-pci+bounces-27098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C2BAA76AB
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDDA3AFA26
	for <lists+linux-pci@lfdr.de>; Fri,  2 May 2025 16:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514AE25D1E7;
	Fri,  2 May 2025 16:04:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023105.outbound.protection.outlook.com [52.101.127.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5C146A68;
	Fri,  2 May 2025 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201894; cv=fail; b=iwJ032swpseElgdoEJDy/v3fti+IL3mol9gp2CuMvtaukn2AYrtrnYWMELJCEpdyRxFOSi6tLO+Xmqd5G8JKDND+i3mnn2Hla6HolJW78sFF8y8J4/xc3BHop6zlSiqiKRPjfa7nLxNNFJnmbc5822NamA4F47JY7nl0FTMGwAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201894; c=relaxed/simple;
	bh=d8SmpxsOY9AbQyF+IjkG5LOZRslocnj6goryQAEDm58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYz9ZrgyvnOWZ9UCwoxa/fDsYytioAxt3mA7Pb2runNqRfoI83z3K0SBHTypo/LGCaGw7sMHOzoWKdoCoEFI2/0ohiNAetcas0IwnD6rEjPJ/RfRFSMVb3VVkIJfzkalD91mALZjLPvSoQK7KrS9qssOGr8dbhTl3cpO+h1gkbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.127.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKOUErx+RfJPsjaTgBCTdMzlkd/VJ7gPGiRl1nl8A4JgP5nAM2dnMD0TXwGngkTAiuAP3EpsES5xv0eZKDH84hTHx6EbFahAZ2/7BQ0qekd4QRxjP7KSkKzBULYMDFTGFKuYESDekyYmSjKgbHXgeIpQTgCRySik092KTdBwlK15W1a7WZcPDRixC5DPMiX/XmVGzBIv4aGO1QzIb/YUzimrsFBf856/5shbNR/5tc6/Y+uuhZi8szboEtby/cMMVW6nHYwYLu4khNDrCoLED9Md6PXdZLEpR0uofMzmNznrLrcyi/frgJkWEFK8j6uj0Yz9QW5x9TIBWc8jGUh32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVd/Wmr9f709MYLpm+vtOoBhQg0rDtu6lXhVFlb+QTY=;
 b=Gui3jkaMwJo7ZvySeUap0UavS/yLUTBBmzb3B781fwKscnkKTy7QvqlkljARNS4MNIcNiS2CoHdYpF2pNG4lJvCTMltMdl+uQADQeYm51PzTTcFQwAylu/KcfoyqXdpaCEds2JhE0MSR8i/1Ib/ErUM7e9uXWw8cE8BMGyFLwEHPcqmUn+0rZB8M4iypeg9HCrG+mNsyVJC7vOHbDgS+/K/fdr10IaBs5kcxWn1Xn09Jiau0fVTdIy1/0s9Hblq1nQ979W8EDOy2CPTnHZtXVSbOyk+yVVf3TT7StZtj/1WuCU2cC6h+btJcPu6cOzB/zagdCyE34p+trutZ4y1jNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=grimberg.me smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from TYAPR01CA0205.jpnprd01.prod.outlook.com (2603:1096:404:29::25)
 by KL1PR06MB6649.apcprd06.prod.outlook.com (2603:1096:820:fc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Fri, 2 May
 2025 16:04:48 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:404:29:cafe::99) by TYAPR01CA0205.outlook.office365.com
 (2603:1096:404:29::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 16:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 16:04:47 +0000
Received: from [172.16.64.208] (unknown [172.16.64.208])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 1324240A5A01;
	Sat,  3 May 2025 00:04:46 +0800 (CST)
Message-ID: <87820fb9-cfd4-4b7c-b015-9626d5253a5f@cixtech.com>
Date: Sat, 3 May 2025 00:04:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Fix system hang when ASPM L1 is enabled during
 suspend
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250502032051.920990-1-hans.zhang@cixtech.com>
 <zbjd6ee22eqdu2caajq5gcwfqmq3vzz4down5jhxx7tsryu2at@ywng3qn5bbas>
Content-Language: en-US
From: Hans Zhang <hans.zhang@cixtech.com>
In-Reply-To: <zbjd6ee22eqdu2caajq5gcwfqmq3vzz4down5jhxx7tsryu2at@ywng3qn5bbas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|KL1PR06MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: f45371ba-8cee-4c25-1f47-08dd89930fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aURHTFNpM3ZYT09PS0J4WHBRRFRibGwrL1hRMTVKMG9oTHpaT21rTnYzTFgz?=
 =?utf-8?B?cWVUejJqd2svZ0NPYjMzaFhTQmxqR0gyUmRyTnUvazNuNVZyc0hYRjgxNmwx?=
 =?utf-8?B?NjZJRVpyUFJ1UXdwcHhmVGFmaUVRdWlvUllQMVQyTHNpTXlyNTVxWDdVVmF3?=
 =?utf-8?B?ZUxTU29FVnErZEJpeUgxbDhQNm5icVRUdkswR1RVWDRDbG1SMmdmbTlDbkhJ?=
 =?utf-8?B?YloxTXN2di9WaS9hUERsVGJ0VkwzV00zMXIrMlROM09IVDVXbU51MjIvbVhr?=
 =?utf-8?B?d3dYYlV3SUhqOGNtNmd0NVN0K0p0UTF4NzdESURTUnVsUGFvVEhTRHVsa0dI?=
 =?utf-8?B?UDRQVEN2aXpkSVpoR0RCNXNKVWpRZDJEcklYdzY5RWJoTXF2dHhIaElsY2FC?=
 =?utf-8?B?cFZCQzE0ZWRrcWtyUVpHNkZPRHc4Si85MnFxcjFncXNOOFBBVkVGYzgwWEgr?=
 =?utf-8?B?UkUvdFRxVThVTkFaTnNoTGR2MTdzd2hoTS84WFJyNEprSS9GNm5CZUdTT1kw?=
 =?utf-8?B?UkxReWNvdkdueTZ5REtsTTVBdnBSOGVIVXhybzFnSk56TEFzYS9jQ3FHeTRp?=
 =?utf-8?B?RmFaK3dIRTJ0VHpIS2NsSWZFL0VGQUVGT0dRcGpCTG5iOUxHNnVGWk1LbEFH?=
 =?utf-8?B?QXl1emdNbVByWi9tRE5qY1RBaHNCeUNnbENGWUhPanlwZHBWS2FNNnl5NDhJ?=
 =?utf-8?B?amNqNEhybEhEU21ONmYzYlF4Y1JHS3BodkNEbHAwQlZUTUtnbkRmaHBNTHVG?=
 =?utf-8?B?MUFjL1hTanhYcS80azFVTHRKWm9GVWZvbXNSZmlwVDlDNkMxMktxamlHU3cy?=
 =?utf-8?B?ZlgxYkhpOHhJSnNhUUswV2NyZ293OTlwVUdPdmh4dzhQQjdWdm01Rmp5MlRu?=
 =?utf-8?B?LzFnbmZHZWhpeSsrNHVOVldEMDR6cFNad1ZSbTVnY3ROMTlldDJNaXBnV21Y?=
 =?utf-8?B?bUdOMEpqd0EzYlFNRkdZcDhFejZXNStyRFZFNDhUbjRtODRDcWJuOWZJUFhq?=
 =?utf-8?B?Mi9rNENRQXAxUmNjVmc4MEI5Si9rZHowNytMR3lqUFFvK0M4K2tWK2liQ3Zz?=
 =?utf-8?B?VjkvVVBmeUV5ejdVVUlLcDk5UkN2TTJ2b1B3SVFGQnFGYVZyMGlweXJQVU1P?=
 =?utf-8?B?M2ZpK1ZOZ1NIM2lSLy9QanpTbXNEQXVkbkFCd0RvOUtnTEUxaGxrWCs0K21s?=
 =?utf-8?B?bUxYVEZWaDBmckgwNVQ2SXdMUW8xTEVyMTUrOXNkdVdYVHVHb2RQWm9VRVgx?=
 =?utf-8?B?a2Uvd1psTzhET0UrczVNVTIwMEZPdGhkS3RtWFZWZlIzNmRzSitaZDlFYjE0?=
 =?utf-8?B?RFplZDArdWlYazFQVDB2bnRMNzlyV093S3d6cFRkc24zV2xKMmM2MVAwbDVP?=
 =?utf-8?B?VmtaMEZmWGVKakt2TE1BV2JOTGtlUWlJNU5FYTNmTkYwNzlNL1lkdnk4dEo2?=
 =?utf-8?B?bkQ2bTVCV25uTHNGakU5TG93WC9EaExCQmllbnhOTXBFMm1mcTQ3clRtc1Fa?=
 =?utf-8?B?Q2JaZGpyNnBWYU9DeEdQRHowL3VwZkFSZjVXeUpiZnZESnFrSE5xQWxOR1dq?=
 =?utf-8?B?MmhDRjZaNGJQQlNlU25SdzdndEc0QXNNdWxNbDd6eEZFdGJlRGtySWVGbFlz?=
 =?utf-8?B?ZGx2eGltMXBHY3RjTmwxdk85TjZmckhXNWpHOTJNM0tpSFdBbGpaNTZKZ0hR?=
 =?utf-8?B?b0hOOTRxZ3N3OTd0b0xsc1cyaUdxd1NlTTc4YWdVL0Y5SU9aaUkyU1gzVlhW?=
 =?utf-8?B?UWh0S1c5d1h1N3RLNkgraDhqY2dKNWg1V1lJdzdhK2pwUlRMdGZ4eENveWp0?=
 =?utf-8?B?Z0gwT0JzOGNBL3U1Tm9GVmZhTmFIYzNtMlBiR3V1RGhMNnF5MU9JeGFIbmh3?=
 =?utf-8?B?RUNpY013SklaaU5NQUFvYUcwQzIrNlJVZ2ROb1Z2SlQ4N3grQ3JORlFpTTdx?=
 =?utf-8?B?ZVJnNzg4WW1jWlR3b3VsdzlvdlhiTWVoTmloK3E2K1dWOE9xblQxT3pqdkVZ?=
 =?utf-8?B?RkVyMnZWZDBwbVo0Y0pESUI1SW4vNzdEZ1kweFA3M2J5LzkyNnJ0T2lBbVVE?=
 =?utf-8?Q?WgRuUj?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 16:04:47.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f45371ba-8cee-4c25-1f47-08dd89930fcf
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6649



On 2025/5/2 23:45, Manivannan Sadhasivam wrote:
> On Fri, May 02, 2025 at 11:20:51AM +0800,hans.zhang@cixtech.com  wrote:
>> From: Hans Zhang<hans.zhang@cixtech.com>
>>
>> When PCIe ASPM L1 is enabled (CONFIG_PCIEASPM_POWERSAVE=y), certain
>> NVMe controllers fail to release LPI MSI-X interrupts during system
>> suspend, leading to a system hang. This occurs because the driver's
>> existing power management path does not fully disable the device
>> when ASPM is active.
>>
> Why can't you add quirks for those NVMe devices instead?
> 

Dear Mani,

static int nvme_init_identify(struct nvme_ctrl *ctrl)
   if (!ctrl->identified) {
     for (i = 0; i < ARRAY_SIZE(core_quirks); i++) {
	if (quirk_matches(id, &core_quirks[i]))
	  ctrl->quirks |= core_quirks[i].quirks;
	}


quirk_matches needs to match the vid of each NVMe SSD. At present, I 
have added all the vid available on the market to the quirks table, 
which seems very unreasonable.

Best regards,
Hans

