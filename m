Return-Path: <linux-pci+bounces-33468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4240B1CB87
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF0B94E2CD5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46D29ACE5;
	Wed,  6 Aug 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JPQ+FTNb"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED83229E110;
	Wed,  6 Aug 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503113; cv=fail; b=U1UQIol0P9NS8CNb81LLSYEhL7rR+oEc+EawMhUjfLOKG0u9m44LWUXtB93iNXN1s/bKmN8jyHivJu+/Yd6lH9kF38Ss6ETO9mFHZgZRrjt+DQkoSYYciYUvWCsGA+DaR4DFkWAH/hHR6rbaozmOyiUNAvYPrV2Vg6Ldr7zJ1Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503113; c=relaxed/simple;
	bh=d8pRkLkDRH3DmeHFpfnRo4p0RiyWNnIv+8mgIl4ssZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p3XXyaR0AUHPquFQnLgZFA2gDaiF6gPMKLK0d5Rc+h5eFxbiWgaAA/GzlHl9rVNXxl6usGlnFrJOOxCYe9p5DLPJsFZ5gboHuSFTOCvqpibNvVx+0o9cbmjwOzshdJDcetanpVzf37d8qVQRZZ+edrevxKeBPZlVBYtmypjY6E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JPQ+FTNb; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PA+er3B5eDAhpaPWEqit5Kll7Xet6wQE4Bd1xLhwlJ9FErxO7GqR3r7T04WcTBZdkXXYoPou5nn8dITZM3mKK37TRelm1knpN6NBlzowLdN4wnqJ/k4Z0efDvKRRrHkExKz1FRC6hLc/1yX4HotYq3wV8zzBSjE9UuikwrFXxX/8WOc1i/Z6LvenSIV6NeSNIA/OOxW2Cy+SGTisDZI96fnDzGURx+KvE3hMI3f6VoW5KaSiaLky9VU+mw1QDeLUZxDPyWToATqpkA8Lw7GjDHdpww/vBtw76bDP4KR0dYM9j0MLvIGXNy/P2ROcrXdZYJ4ScwP+zbx/6vpuawO1WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DugIHpuLO3kgxWmqrHK79PCH2tM779W0Z4SNt+GIEus=;
 b=XnShz0junQBiNoQGgIwchMd8JigyZxkX7/XvwChFwoEr9jj7Lj/BmykO5ep45G6Cxj1EP6zfPeu8A0nB8AERnDqCP1Hf6Utlssd7GSRnANM9mhSC6HhS5PGEWNcBJKxlDGqtufn5KDZZwrBrGsISVrXLIT0EjfdygWm49I2+ZErdLOOgXW/jbt2gB3jnJz7pEb4fwed3MqQtgvWl6WTTfMyq+2YMvtSDHXsHdErgI2CJ9G9myDpAUwIh/hShzwfU4KJyhmakMVhVSJZ06pVABzL4Kr3uxfo26VPLl/kgGTDXfiVgF5ni0lRn5TsNtS4FYJoPz7Rmo/vt2YItXOWTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DugIHpuLO3kgxWmqrHK79PCH2tM779W0Z4SNt+GIEus=;
 b=JPQ+FTNbW7p0aJCPOL/I5ACHL38eZof6db+zl+kolYXrz7wcfS1W+9nXTt0nByiS9pQzLNjkyHilgIvQJi/XXde+MoPGQewDUWccaEhJC9f57hxw56VZIzoLoNMEkPA1TAC3SCE8vhVV8CObX7nZHH+ITgt+0izwd+1L+Sd6T6Q=
Received: from BLAPR03CA0117.namprd03.prod.outlook.com (2603:10b6:208:32a::32)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 17:58:28 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::33) by BLAPR03CA0117.outlook.office365.com
 (2603:10b6:208:32a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 17:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 17:58:28 +0000
Received: from [172.31.129.107] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Aug
 2025 12:58:27 -0500
Message-ID: <6d4b6d6f-1601-46c9-90a6-8493141705a3@amd.com>
Date: Wed, 6 Aug 2025 12:58:27 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] cxl/core, PCI: PCIe portdrv: Add CXL timeout range
 programming
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
References: <20250804213928.GA3643006@bhelgaas>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250804213928.GA3643006@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2d7612-4f43-40c7-d0c8-08ddd512d91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHQvcjkvRUMzK0d2dlJkaThzYlBPWWdpaGsvQmlZZldRMkIyWjlPenV1bVkx?=
 =?utf-8?B?cFpkeUZndFZPVmhZd1Y1eXZ2YUtpcUc1NGFQeUFmcUI3K0dlMm96cUVIVzVN?=
 =?utf-8?B?ZFV0Q05CU3NaSDlDd2JrZzhJa0FaeVBGY0NYbGdKN21hSTE2THlvOVpZK09l?=
 =?utf-8?B?eURDanFSZDlPSXRrV0hvdk9ySDN4VzVCUllYVjFmYU1lclpLYVN6RTBVSUFY?=
 =?utf-8?B?Ui9tc3NmcjNIV3hUd2hqVEl6ZFhOeXFLWlkreGhrT1NDMnpmbnhmcHhLb1Ix?=
 =?utf-8?B?SGZuUHdkL1BpSzFiSkpQYU5qUFlWbDJLTS9WODFxQktrUkdNRlRDbitTU2Np?=
 =?utf-8?B?NSt1UFQ1YWhzLzdlK3RMK0pvaXRQN0lYQ09hOE80MGhvdDJBbzNFeHk4dlNu?=
 =?utf-8?B?dVNxTWx1dzZSTVozZnpWdXVnN2F0T3dHeEVXOVZHTUxVSXhlMlRBY050VDJr?=
 =?utf-8?B?RjNScStZSWdwc3R4WGJQZzNqS0RoYTdqUTZ3UzJIYnNKTzZEc1JIVlpYaGhJ?=
 =?utf-8?B?WGRnQjBvRUhvMmFHdDhKeWdZK0FIc0VYVkxmUUJEaGdYU0trMWhmUnhHMGtU?=
 =?utf-8?B?TXRkWHo1N2d3NForY0hwVW5mczVuQjV6QTlyUzdqQTdGQ2hhM1g4SXRTR052?=
 =?utf-8?B?NTk5MUllUXQzSUZXd29xaW04bSthNGNPUHg0UFZSTXlVdHZLSVk5SklISE9G?=
 =?utf-8?B?akNRaVJQeWxzQ2FsN0JGcG5LUVFqaTVZZjNTTjVxUmlXNW5Qdks0bXN2S0wv?=
 =?utf-8?B?Mzg0bzgwelhidDAzamNlQldpNjZHTk9Ja3ZRQ2FKT3pyc0xCd1RFRmpmakZS?=
 =?utf-8?B?ZkdLSmhnWElIZk4xSWhxNE81TkQ2eTJFbDBvRDU1VmFhRXJlSTlUU3JNUnlp?=
 =?utf-8?B?Yk1jeTJGZEV3cFp4OXowNWx6ZFNrSTJBSlBncGhCNVpuUy9DY3ZubUROQzFl?=
 =?utf-8?B?MGp1djIyaVZPNW84Ull6b0pyeUJjRG5aemZZYWFnRnh3TTY1SXB3SHZNODhk?=
 =?utf-8?B?cVM1cTd5N3dkTEorRXQ2UTFOajNNYklVY2p3d1VOR1hSV1NsTlpVeVY0STJO?=
 =?utf-8?B?ZEVjekQ3ekRvWkFCY3lVSWM2K0pMQ0Y1NW5wN0Era1hLa25BcHp5SWhHZHVu?=
 =?utf-8?B?QlJHZDFRK2IvL0NXRWw2ODh3ZDQzdjlqOFJGMHNFVDR5dkxJdWNNSDNkN1JP?=
 =?utf-8?B?Z3dIWVRXREZGbUpZbGxMSmxXdE1BRHlWOHBROTMvNUt4SHdvcjhjM25PTG43?=
 =?utf-8?B?WmluUVZLUGYyRXJ1cmxxdmpMdi8rNFBZdGNiT3BHQXJiNDM5dm1KYWt4cUdU?=
 =?utf-8?B?aVBhT3h0T3BMSHdFbmdTUU4yeS8vY28vcTBQRTN1MUhFZG1TN0lQbW5WMG5y?=
 =?utf-8?B?RGVYMnUyVTlzdXFSNGcvaGJtSG1Rd001YkdqSGtzZUdRUlRXYWF6Z1Z5dmla?=
 =?utf-8?B?WVZuVWo3cWo4L043b0tXRFVsMkpqRmx5MEoxZUhzMTFiRUJBL2pFdjdqeVp0?=
 =?utf-8?B?Vndib0R1VkkreUpON1ZZK0ZwSU03emJuVUZ5L3BUYVdFenNncmcyekpROG5G?=
 =?utf-8?B?OWllRlFOV1R3ZHU0YXZsc3FDY09BdVQ2dzZ0OU1haHc0UW5mS0RObE9zckFS?=
 =?utf-8?B?a1R1SlRZYndmZklCaFpPN2FCTVluVncwRllaQVVRV0dtam16YTRtK0dqaGJi?=
 =?utf-8?B?d05pKzJRc3NhS0N5Z3dDRmlvQS9YcTQ0MHdlWVJ3U003V3E4eDNmQkVWMmwv?=
 =?utf-8?B?REk0Ty9scFg3a2tjSjNzc0loUERIc2VXZklHMWM2MFE2TERPZXlGb0tHRC81?=
 =?utf-8?B?ZEhuMjJXR2owQkFtQnk4WXpidi9sU05GeXVUUjdHNUk0SHBzUkZOcEQ3M2Fk?=
 =?utf-8?B?OVNLK05WQ3o3WXVScHZxdnh4UXBjc0lUbzdTSHIyME1keC9DcWxKZTdqTUdP?=
 =?utf-8?B?ZklDZjdRbXRpSG5idHU4WW1OSGgyZzBVaHQyMzdTTGFmblJiblhWVmt5VUtR?=
 =?utf-8?B?UEJCV1hQNHNoNzJ2TDJjdVhmMU5tU01udWJzRWlnenpwU0hVRW4xeEVQSFIv?=
 =?utf-8?Q?QPor5X?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 17:58:28.4719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2d7612-4f43-40c7-d0c8-08ddd512d91c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844

On 8/4/2025 4:39 PM, Bjorn Helgaas wrote:
> Drop a few of the subject line prefixes and mention something about
> sysfs.  This has nothing to do with portdrv.  Following sibling "port
> service drivers," I guess the prefix would be something like
> "PCI/CXL:" or "PCI/CXL_ISO:"

Will do.

> 
> On Wed, Jul 30, 2025 at 04:47:15PM -0500, Ben Cheatham wrote:
>> Add functions to enable programming the CXL.mem transaction timeout
>> range, if supported. Add a sysfs attribute to the "cxl_isolation" group
>> to allow programming the timeout from userspace.
> 
> Include a sample path with at least the last 2-3 components.  Maybe
> even an example, e.g.,
> 
>   # echo B2 > /sys/.../cxl_isolation/timeout_range
> 
> Probably also some doc in Documentation/ABI/testing/?

I'll add it to the commit message and make an entry under Documentation.

> 
>> The attribute can take either the CXL spec-defined hex value for the
>> associated timeout range (CXL 3.2 8.2.4.24.2 field 3:0) or a
>> string with the range. The range string is formatted as the range letter
>> in uppercase or lowercase, with an optional "2" to specify the second
>> range in the aforementioned spec ref.
>>
>> For example, to program the port with a timeout of 65ms to 210ms (range B)
>> the following strings could be specified: "b2"/"B2". Picking the first
>> portion of range B (16ms to 55ms) would be: "b"/"B".
> 
> What's the value of accepting either upper- or lower-case?  It doubles
> the size of ranges[], and I think timeout_range_show() always shows
> the lower-case one.  The spec uses upper-case.
> 

Just ease of use. I'll restrict it to uppercase to match the spec (unless anyone has
a strong opinion otherwise).

Thanks,
Ben

