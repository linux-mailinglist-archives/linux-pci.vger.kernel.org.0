Return-Path: <linux-pci+bounces-10177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5426692EF3F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A874283E5F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE81616E895;
	Thu, 11 Jul 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aAveHYsW"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFD161939;
	Thu, 11 Jul 2024 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724317; cv=fail; b=mLZx+WibyW23t9fWjgI3xNogaJwKx7SKla2iuG7YZ889TOAt0P4IAV8LgMJVx6UqsHrD5A2D2+EjC7EolQ2ugxegzqIOD+lX5MNwNI7+cYS3XKB/5SRBj+wKd9W/ITVILDU+bXsMyXbIQ64adNnVAnxg+muU8xWELCxf3XHfz+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724317; c=relaxed/simple;
	bh=vKfLMQ5f1nWper2uwr8Mczd6tzjCRR8F7lUxowV8OJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K57AK1VBDvZk5Kf1XHHgDbC/ie6gNWkjpuXO3IrErBgN+ZDCeQCljTNa2YvLvnJiHt+k+1Lbs3IZU2KCOq8wXR8OsgE+lLHy8FsjCHJqOC1MQ44kMFfd5paBApL1vBkj6bdXaaAyIKRgUu7u4Jw7PWKpg2BqZxBaP7DYQ1cSewU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aAveHYsW; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLYvJH1KsoQ+T3FEVlBd8O5PiEwy379HgoRUd03piFbeWyDyOZecBfztTpHwl0HJOUhybuqeulJOKEKbRt0hqfautJQF8zwnRB7CKei7WZgyj84paFLYVokpclzmyg/LxH2JHHdotZbMgmzLlkxaMfG7fBSR7obVKhW9MCBkZXWGw4kWmFOKMZGNfo0hEWdrSZjWQ4x2LKPxjUKA2Byt1lQWcGOODlD3zAsqwT//B3PnbLYb9sWd+J2kYzDyKjLOATNyVGRTNLjuup/1q2AemWcpcBzMkEpvCcT234RYHt9mm29ZZXZmnN9mSb7gMRIG7Tw10ORdfQ0EHjGDdswcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYW4qCJlRg0iiKuYN3BbOdlCivjGeJarApHFPyYOrJ8=;
 b=cRWVAT8xe3o9uYDQdFk5NHWVOWmo0vBDoN+hXtPQZ6q7LdIwMrFWm1pQz61K2/GRuN2RYb7ZSGOE5ruBuzxEx5UePBDydhiyrxysAo4gNOKYomXK9jDA7VcynpZd1ns0buT0yTZ0XB9HgFj/qieLVDEpbNjGUszgAaHBLvcKiOlR7z1EAgLt1ij6BHKH1V3I9qG4j8XTf2dzdhlIISLiLQe9WxNTc4w5Wb/5X+/+xMd4K/QyVmWl7dPVfQRut8WDoK8vEwFP5AADpnywOGwiMpj8IK14sfpCT3Acrziy0IFXgXMKi/BxY6ec+C3fVfzK+ikPeXAYUdgBrKQYaJLuUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYW4qCJlRg0iiKuYN3BbOdlCivjGeJarApHFPyYOrJ8=;
 b=aAveHYsW6CMlGOZfBrPK4yCpAEy4Q8G8IugnoVE6eLdJ0qkAd47h9kURw1F0ICQ1+Yk6rhDmW7nvhcsTcedtB5WWPEUlDzcjG4Y+4CGWl8XhTkrUWVB2Hc8j4R6BlLsFO+A9gMP+E8RcL0uWiBLE9REawqJeRfSjuLVK4SL9tgE=
Received: from DM6PR10CA0019.namprd10.prod.outlook.com (2603:10b6:5:60::32) by
 SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Thu, 11 Jul 2024 18:58:29 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::9c) by DM6PR10CA0019.outlook.office365.com
 (2603:10b6:5:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 18:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 18:58:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 13:58:27 -0500
Received: from [172.25.198.154] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 11 Jul 2024 13:58:24 -0500
Message-ID: <eda06f77-14b3-4503-9a86-c55092ccf5b7@amd.com>
Date: Thu, 11 Jul 2024 14:58:24 -0400
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
References: <20240711184035.GA287904@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240711184035.GA287904@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c71255-17c0-49aa-9068-08dca1db7404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG5yd1RZTDBieWlyNXlMWGVBRUx1akxUZy9HeC91cEo3cEM5S29JNGc2MTVV?=
 =?utf-8?B?dFFsRGlvU3VnSDRNWmFLeXBKTEFWZzRlamM0Y3NIdEN4enVCc2tKSXhBalhQ?=
 =?utf-8?B?V1RRK1pTK3BIK1g2djErNlBmM2NBUjhSUjhNVldLQk1abTRpeXVuU1k2N2lZ?=
 =?utf-8?B?Y215VWI2NVFoWlJMa0t2ZlR4V3FBQXcrYU1hNFZvL1VIaldEM082UkdlRklW?=
 =?utf-8?B?cUV2Q2NyVlM4cUI5aUxlME1tS0hpN2JIaEFqM0VIVk9nRTRwTlcycHQrNk5Q?=
 =?utf-8?B?d213MXc1TkM1QTJheWJmMEY5MWNGODhXbzBxSHZVZlVSY21hVGU2blpiLy84?=
 =?utf-8?B?cGhSOVo2KzJ3SktVLzk2d0FHNVRwM0R4RjhpYWhPWFZpUGlYUkpYMHcvNUpJ?=
 =?utf-8?B?RXBuSDg4ZUZlT0VrcWVDbVkrdldxdUVzRTF5T0R5VjZsbVAvWHltc0NIYjhj?=
 =?utf-8?B?eUxKNlRqL3NHd3JQNVBjNTZsZDgzTHFLWWE3Rk5rMkI2Z1owaE00QVl3M3Jw?=
 =?utf-8?B?Lzl5QTgzeW1BM2Y4bk5uRHZpaktqcEhiQWhzMW1RMFZYWVphbVdlcytTZTNx?=
 =?utf-8?B?ZGxwZnprRTZ3ZnZxWDFOVnFWYStYanQydW12U2hzQTRyTzczSHJna0xiWUhv?=
 =?utf-8?B?d0dkOTVWd2pqR3YzeDlUdTQxQmVzU1MxYjFVVjVJOTJmd2o4cy96ekdOSkUv?=
 =?utf-8?B?OW04L3RYUVpzc2dCdUw2Wko5RHMyV0h2d2NESlBtTFo2K2Ric1VZcWo5WnhI?=
 =?utf-8?B?QWxOS055TGRlVWZoVUFuY2RmODcxVGFoWkpqUVhjcyt2d3ZwbXhpMU45dHZU?=
 =?utf-8?B?QXpvMjFmMkNZdWxhM0x0MlJYdmIxNGd0Q09XRS91c1lUejFwcjdhenJEcnFt?=
 =?utf-8?B?QVgwYzZTQVBSSitYVUxhaVJaaGJKbEZOVm1lN1BLV1c1VUlTNTdZdFFoajJ2?=
 =?utf-8?B?SFNLdUh4SEp3UkYyUG4yK0JXTmZpV01iSTB6VGFoVlN0eUR6azk2QUcraVV4?=
 =?utf-8?B?ZFVPeHZrVVd0SjhsWFNLdUxJdDk4THh2eVlWbDYzUlFzMmdsK1RrYU5OL2RR?=
 =?utf-8?B?SS9WeXA5dlhYV2IwRndFcVFzeFBLVEd6TEVGb3AyTExiSm9nY1Z5RmpHbFRJ?=
 =?utf-8?B?ZDVsQjdyb0FnZGZ0cy9RQUx5UjlXNFlzVG50cUlWR1FGTDQ0czRMRURiSTB6?=
 =?utf-8?B?RVJRbmdrT0tVcURDbStheklodFFqeVpOdG91N2dkMk5BU1VHRzZSNzZ1N0dD?=
 =?utf-8?B?SmF3U2VaWmpaeUZDSFNEdmJrZDNGU3RXbHNrTlFhT0hRWHBTMWNTMFdiV1Ay?=
 =?utf-8?B?TUZRQjFLSW0ycmdVUTVxbVo4Mmd4eXRZNHBtV2JTZmh5cG5XT1RoKys4dGtM?=
 =?utf-8?B?b1d6ZVZJWk85ZDdLamhiSWE5Vng3TS9lRzV3Mm9FWlVFNEw0U2szODRPNWxT?=
 =?utf-8?B?ZVlnSlByK1hYT0g4eW12ZktRZnhoYk81WW5TUDFJOVNDNVpVR2UzdjZobW1V?=
 =?utf-8?B?Nithcmp5RmUwVjZDc1IrbVY4K1dKRm9pUlNOaE80ZlJITW1MbTZJZm1JaU04?=
 =?utf-8?B?TERzVXJmTlk4RGNyQ25YN2JGMzVhWkpvVDF2Ris2U1RQeGhrRWp6MGQ2Yzli?=
 =?utf-8?B?U2NvelNnZy96Zyt6eGd1UjdZaGlRMVZ1WEhPL3A4NWxWeTZMa1llL0s0ZHlo?=
 =?utf-8?B?QStYTTUxMUNtaTZVb1pWWnlabEFBWUl5YUJERUFHa3ZGSkhaaS9YWU5zdDRQ?=
 =?utf-8?B?eEMyWjErYVQzeGpMY1ozRSt4cjk5VTNrYm9EZmR0SGdBLzNCbWNSeGtHZktD?=
 =?utf-8?B?NllkZncyUWlsMVdweW9tZkkwREJDTkE5VXNINzJDMUg5Z044M0ZXRTRsbHlT?=
 =?utf-8?B?R3kvSEZ0M0FtMzRBUDJkZVhMVkdVWFF2L2d6Mmsvd3hoc2ZpN25TcUNxU2VJ?=
 =?utf-8?Q?WkvydgxVhpH8ojahgVL18j4uMUKkCamp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:58:29.3164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c71255-17c0-49aa-9068-08dca1db7404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924

On 7/11/24 14:40, Bjorn Helgaas wrote:
> On Wed, Jul 10, 2024 at 06:49:42PM -0400, Stewart Hildebrand wrote:
>> On 7/10/24 17:24, Bjorn Helgaas wrote:
>>> On Wed, Jul 10, 2024 at 12:16:24PM -0400, Stewart Hildebrand wrote:
>>>> On 7/9/24 12:19, Bjorn Helgaas wrote:
>>>>> On Tue, Jul 09, 2024 at 09:36:01AM -0400, Stewart Hildebrand wrote:
>>>>>> Currently, it's not possible to use the IORESOURCE_STARTALIGN flag on
>>>>>> x86 due to the alignment being overwritten in
>>>>>> pcibios_allocate_dev_resources(). Make one small change in arch/x86 to
>>>>>> make it work on x86.
>>>>>
>>>>> Is this a regression?  I didn't look up when IORESOURCE_STARTALIGN was
>>>>> added, but likely it was for some situation on x86, so presumably it
>>>>> worked at one time.  If something broke it in the meantime, it would
>>>>> be nice to identify the commit that broke it.
>>>>
>>>> No, I don't have reason to believe it's a regression.
>>>>
>>>> IORESOURCE_STARTALIGN was introduced in commit 884525655d07 ("PCI: clean
>>>> up resource alignment management").
>>>
>>> Ah, OK.  IORESOURCE_STARTALIGN is used for bridge windows, which don't
>>> need to be aligned on their size as BARs do.  It would be terrible if
>>> that usage was broken, which is why I was alarmed by the idea of it
>>> not working on x86> 
>>> But this patch is only relevant for BARs.  I was a little confused
>>> about IORESOURCE_STARTALIGN for a BAR, but I guess the point is to
>>> force alignment on *more* than the BAR's size, e.g., to prevent
>>> multiple BARs from being put in the same page.
>>>
>>> Bottom line, this would need to be a little more specific so it
>>> doesn't suggest that IORESOURCE_STARTALIGN for windows is broken.
>>
>> I'll make the commit message clearer.
>>
>>> IIUC, the main purpose of the series is to align all BARs to at least
>>> 4K.  I don't think the series relies on IORESOURCE_STARTALIGN to do
>>> that.
>>
>> Yes, it does rely on IORESOURCE_STARTALIGN for BARs.
> 
> Oh, I missed that, sorry.  The only places I see that set
> IORESOURCE_STARTALIGN are pci_request_resource_alignment(), which is
> where I got the "pci=resource_alignment=..." connection, and
> pbus_size_io(), pbus_size_mem(), and pci_bus_size_cardbus(), which are
> for bridge windows, AFAICS.
> 
> Doesn't the >= 4K alignment in this series hinge on the
> pcibios_default_alignment() change?

Yep

> It looks like that would force at
> least 4K alignment independent of IORESOURCE_STARTALIGN.

Changing pcibios_default_alignment() (without pci=resource_alignment=
specified) results in IORESOURCE_STARTALIGN.

>>> But there's an issue with "pci=resource_alignment=..." that you
>>> noticed sort of incidentally, and this patch fixes that?
>>
>> No, pci=resource_alignment= results in IORESOURCE_SIZEALIGN, which
>> breaks pcitest. And we'd like pcitest to work properly for PCI
>> passthrough validation with Xen, hence the need for
>> IORESOURCE_STARTALIGN.


