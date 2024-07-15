Return-Path: <linux-pci+bounces-10275-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB4D931938
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 19:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6DC2822E1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F812E71;
	Mon, 15 Jul 2024 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o6QlVWkT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664654D8CF;
	Mon, 15 Jul 2024 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064382; cv=fail; b=uBxoQcNgjyX4NJwreh61zorQuRaJVqrdPHFXqjBFLdedjUNdofgF2AwixfyF5jX56LWeZFwF4N7PGFGf7P9fjs4Va0jB4c91BjvigvqHDWqyexDrZseUoUxUqCcowm8hPPjT/8/9J7WvloPfZT4JA3FxkcMqtAlweouFEr7N4gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064382; c=relaxed/simple;
	bh=hKGJRSLgv/YzlD8/CjWDOrjZWXGh9ziGX9poKy2vFCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5jRX3Q//1cR5BTEZK/4ZRXIUjB8p44Kf2KDxATqdpC7URkmy9AzfKU13hDxmUoNT+Xp5Xkv46DY4sbFyCK2jLTGj7lDZlpSs8uMsOhF8hdD7+hR01KWwKmebeGMnnHOW+yDztxmnEthZYb0yzQEzSlm+EFdeRiZYuzLAne1jEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o6QlVWkT; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBL3MxQK3gMLrRfpR9CAMaEXsG22wKiR/klic5o4eeRBs9AJdiP4j4q33ShJ+8SUZRFysOBZA9xLhefWNiwtvdNj9sIlORx7xAhXLiYlDrsF1IfhtqG+aDy7sxHKT1uxzzLwMBX7C9SzcoYtOAGzIzwDD25UYZURzYR+oepE5xkmCW7ddESVA1PtH7c4nOZTJE7f5rwlVyNoKZ6ekem14GrTcRVa4TifowG+93+JjsB11LX/vVUJ/I8Pu7fRlNAHTdmeRov94DAKC2FSWwps8XGbz0FAF5F6g3lc6hpC+OdfHUlYekjnycLyO+GoPSSBIeTSkBEtR5MSI9whTugmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNmuXPA0kTz3UPN1WAVVNXtDykwxfUUoFqjQxus8Fiw=;
 b=SIJKYhhjSW2ApYDAKiTPRnbhvKcNMkAuwesmyC/d6Ks23hv+8D5lzry6a65Cm1KXG/uHHDLKrGTpj4RV8DxqIv5ueo8nWI0E5/PKB0MUS1AbAfuipne1UOHhyeu0IpSCR8O7QWH3Y644Z62cXqxWiOxkLnVUdd0F+DW3fqHhOA7uTQXz+EI+VRWPTQSzSLJegboAPX+DB7PiNkJccpRNXhnIovPf5JKmZyCv1IsET9v/t0vAJyY/BzLdhfpGXmXAbGugJ6ZLACoA0YF8/8yJkH7b0+jnF+nA00KFZlvXPQV+e8rzPWw6ILKMcghGuAgwZMnexxGh2D+B471gjs6l6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNmuXPA0kTz3UPN1WAVVNXtDykwxfUUoFqjQxus8Fiw=;
 b=o6QlVWkTmYpoNW7Qi87QDfXaHGz82jv0ui8bYi3Eo3ihEMFLqjhGg8o5wa9qtgfx0vQpb0fuC94h5N8ZWnHXntAAOIxO8t5gepr9Oy/b5B7Etuoac3YM5b6t7mdcBcBk5Fx1zzKEX0DckaiyojWMzaEGekmHxHFaglFCqJhPDHE=
Received: from BYAPR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:40::43)
 by SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Mon, 15 Jul
 2024 17:26:17 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:40:cafe::12) by BYAPR04CA0030.outlook.office365.com
 (2603:10b6:a03:40::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 15 Jul 2024 17:26:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:26:15 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 15 Jul 2024 12:26:14 -0500
Message-ID: <534ef932-a9f7-4d90-88b9-8d9a751cb2f2@amd.com>
Date: Mon, 15 Jul 2024 13:26:14 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/6] x86: PCI: preserve IORESOURCE_STARTALIGN
 alignment
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	<x86@kernel.org>, <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710212406.GA257375@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240710212406.GA257375@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 515e030f-16cf-41d2-c411-08dca4f33c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWd4NkFuMGw2bnJKN25vNUVPUVpPNkxNaGxsZ09OelBXTXZrbGdRb01oMXJD?=
 =?utf-8?B?Z3F4c255dG9kdWNPdkNwNmVXS3lrdEI2MzRmODZPb05GRDJxSUUzczZZei9M?=
 =?utf-8?B?S2xkK0FrcE5aZEkrVTMra01hOVhHcHpFTWxobWs3V3pBSllJL2JaeS9Ed2Mw?=
 =?utf-8?B?RlBVSCttdGFoY0RzZ1VtM1cvVUFhWXZlVXR3dWJHYXRmVzFlZUNXRE5wb2dz?=
 =?utf-8?B?YVEwUy9wcEZ2dmVYR3hla1pTbFFCUUhYWG5yWWlpZGdrWHZ3dkZCWG1TYXlS?=
 =?utf-8?B?TmdyQVBsczdMZ3k0Q1JRdE1sVTVqcGJEMGlLeEpwTmdzQjFhVktTQWhXYjNU?=
 =?utf-8?B?MnRKM1N3aTgra2J0NjFqaWJ5UnpTQmZ3aTNldVFiWFptK3RPRWRjZ1RtUmVy?=
 =?utf-8?B?TmhPdXVPcGs4TWloaHFaQTZSNGtmTnh0TTkyTUYzSk5XQ0FQNGVZTWlMQW02?=
 =?utf-8?B?ay94bFJaTENYNlVyRURLcTRaVzhOOFZMbjRJMVc1cHJCQ3czdVh1ZmxMWVBR?=
 =?utf-8?B?RXp0QkNZZUFjVEpHQzZtcGdLUUdDZTBjRU44WWxrZjgrNU5mZ0tHdEo4Mm1h?=
 =?utf-8?B?M1k1YTdvaFFvTmovTUNFK2xHQ01GS0RKM0p6bjFZcUVCMWY5S0tvd1o0TldS?=
 =?utf-8?B?eE5iUEFWT3F3RWN1UVRVL0RHZUJvUlVoSkJSdWZsQWRoS1hjejJDakY1Q2ow?=
 =?utf-8?B?cUlhOHBEQ0hmMGcybndOcTh3ZFJJN1c4UHA2Q2d6VWRlK0V5Z01FS3dvTzJO?=
 =?utf-8?B?YUZCU0NGTGw2QVA0R1VOZ2s5UWxDUFJKaWNXbFJOSGRtcjNzbWY4NkprRFBt?=
 =?utf-8?B?ODB1TTlSSFlKTm8veU9PSjlyaUNtdGU1ZVdtaTJLUk1wZXBoUUlhVzVGblpm?=
 =?utf-8?B?aFF5VGNSOHNlbUt6Nld0TlV5YUxlYXAxOG1qUWdmcjY3K2QzN1JTWEQ2M0Vl?=
 =?utf-8?B?NUJrS1ZLYjZTTUVMQTk2VmU2Rm9FaVptUERIRHpjaHJMbXdPTHNLbEdsWHZa?=
 =?utf-8?B?WUJXektqTlhRSzl4R1E2aHY5NTNxRGxTTHJXVlduY2piaUljMm5TS2lwS2Js?=
 =?utf-8?B?bm50TGlNTWgzbU9vTVlrMnJmV3VEVldySTcrU3drU3I1WHNPOTcvc2lzS0lD?=
 =?utf-8?B?YUxCNUlQQkt0WlRzM3lVcUpDd2FVblRKNGI1bmk3WlU0QmF0Wm1JQjJzM21B?=
 =?utf-8?B?aVlzdzZiMjNSSkw3SzdEZEFHSFlkMnQ0ZGJwU0dFM1AxakNPbC9iS2dWdmNH?=
 =?utf-8?B?a0tGM2VOK3hrSUZHdUJ6WjFxQ2JHY0thWm1KR1crdzNUYTFNeDhkblVFVlp2?=
 =?utf-8?B?eWI2ZjJldHFpMnIwS2VpR0tNWTI3NlYvM1ZvYks5THJJUkN6K0NOcXVUR0M3?=
 =?utf-8?B?RFQ5dkpaeTM3ME9SS3NmbmNocnRlQmpkem1yRVhTM0RhcUVEaEtQWmMvc3R0?=
 =?utf-8?B?WDlSU3JRUkhXQkk2NHByZktlRjVTZWhQWmo0RlQvRmpQelpjUEJrd0p0TklW?=
 =?utf-8?B?Y0FxS0d5Z1orQmNTZjVWbTBjTDVKSHdQNEg2RTlZWEhuZ0NtcWRXeDBLQWti?=
 =?utf-8?B?WTdodEZ1SnpHUmdTb01xcm0rUG9LMURVRE5yYVNxTG9XT0N5cEdFMzdqQzRk?=
 =?utf-8?B?WnZGV2RNaFByYUZiVm9DWDBTZG0rNnB4NW11NG8zS1Izb2RTT2duQ0MrN1Zw?=
 =?utf-8?B?TkRIMjNLdWZjMEFNcmJBWWdmeXhnWmhUaSt0YUNFWlpHSnFseGx4QUZzaHA0?=
 =?utf-8?B?dnlRVElEOTkrOFVwK1dRL1paUEJHMGRFVVBadlhBV1F1dkNORlVONU93RGM2?=
 =?utf-8?B?ckZaYWVCbmdueXRZdUdScFkzR3RJSmFWNm03azYxN00xU2Ira3lZVkJlRlB0?=
 =?utf-8?B?WEJWc1VRZ3V1UHIyZ3dka0djZVhRSnorMnBwbFFFdVh0NW5Mbk1sZ2lobHdM?=
 =?utf-8?Q?bxued89hk1IqqUps//9n4fraisoU345j?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:26:16.9305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 515e030f-16cf-41d2-c411-08dca4f33c0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438

On 7/10/24 17:24, Bjorn Helgaas wrote:
> On Wed, Jul 10, 2024 at 12:16:24PM -0400, Stewart Hildebrand wrote:
>> On 7/9/24 12:19, Bjorn Helgaas wrote:
>>> On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
>>>> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
>>>> index f2f4a5d50b27..ff6e61389ec7 100644
>>>> --- a/arch/x86/pci/i386.c
>>>> +++ b/arch/x86/pci/i386.c
>>>> @@ -283,8 +283,11 @@ static void pcibios_allocate_dev_resources(struct pci_dev *dev, int pass)
>>>>  						/* We'll assign a new address later */
>>>>  						pcibios_save_fw_addr(dev,
>>>>  								idx, r->start);
>>>> -						r->end -= r->start;
>>>> -						r->start = 0;
>>>> +						if (!(r->flags &
>>>> +						      IORESOURCE_STARTALIGN)) {
>>>> +							r->end -= r->start;
>>>> +							r->start = 0;
>>>> +						}
> 
> I wondered why this only touched x86 and whether other arches need a
> similar change.  This is used in two paths:
> 
>   1) pcibios_resource_survey_bus(), which is only implemented by x86
> 
>   2) pcibios_resource_survey(), which is implemented by x86 and
>   powerpc.  The powerpc pcibios_allocate_resources() is similar to the
>   x86 pcibios_allocate_dev_resources(), but powerpc doesn't have the
>   r->end and r->start updates you're making conditional.

Actually it does. It's in a separate function, alloc_resource(). I'll
make the change over there too.

> So it looks like x86 is indeed the only place that needs this change.
> None of this stuff is arch-specific, so it's a shame that we don't
> have generic code for it all.  Sigh, oh well.
> 
>>>>  					}
>>>>  				}
>>>>  			}
>>>> -- 
>>>> 2.45.2
>>>>
>>


