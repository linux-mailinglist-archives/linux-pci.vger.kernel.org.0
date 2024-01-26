Return-Path: <linux-pci+bounces-2597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0283E198
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 19:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56CE92828E9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819B1EB49;
	Fri, 26 Jan 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UCkc6bnw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505BA1E882;
	Fri, 26 Jan 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706293964; cv=fail; b=CwGMQu1OaJR0GvbcjfFQlYEk6icnLR4OiiL/sX9HIHFLRNZJ98RYN3wqJEAH725X5A2Qin1jZHY9V6SwolH5SI37NUE4Sn+IM1tsVX0SbkbGJeoAcRzPts+94gxsk18751WubEQIoJGPv6V2tYmosjdLT982tddZzFufAeA85ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706293964; c=relaxed/simple;
	bh=wKHK14+9hQXJtKIdRes0kRjYeS5YPJ9eDA9ACmEr8is=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HRWPDkomImrNi9jzYseaVRqDSVX93H8z8pQeMh5e+qnvYlx4YxtT1348hCJmWisqKsKbXldpZonulO27sk4dr2YeLcassMgEEirAWeDViG+evq8xdoQdz6XlI9g4LOA8PCKqw8A6/CVqXj0IAD+w8adxmZjWiCTW6gpG9HVDIiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UCkc6bnw; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pljm1lP4Oqy0q9PL8+ouZlvFijWzRelulyCqng0IXk1MByd1OqBJkhJajkVTpKqxhfb77nMG0hazYBXt8yJxgJ/q8KopXJ3WPaia/T8rKG4EXpDcTuhCF/CyPUCKJsf9Ixn9J8hp9ZSZEdoNCaHADFF1z4jhOUjtUTMDPLJNZX2mmYkPnvCDiXqWAi5tQacNSeSIBrsfcsCg81Xcw0ABW7gW9AFPP/4FlpwYYfSwU/hV1IfNbukSKUq93NxuDagVitfFBCRfrgmdPDvsufTFjhcsqN5oeb9f0l4yWBN9Knuk2KWlEtPudrAhA8N02PM2TUjRAqEPob/Of+QRovzsaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8n7qNlDTH7NXluTQ5ud3U00K5g7Oh31p/kk1WjgJ14=;
 b=hru96cUtmgMB/i7Ac2HJ/U6Zrw4obeXLBHBrWscLNTaxUxv54ANmBDYrVXvCnYgE48+6uy4MjnpG2Dzcxq/la3jbEXZc2EUT6u3rVvoRJ8ccMvPL2+pLWdqzfBYD4wYa0ShZlW5SvT8V62C3PHC2lv5s6f0cpCmZKEMUaUK2bUR72LdBk1Tmo70iAKnijIEbcEgF1toZSr66cMFmTnHBZILoPlWvIK47ZhFvYQ/02bE1wW2qmK9FchSFv9ZfpeHJRNoLcCzCbwtSnLffAzUmFN6lpllXjkvSxRZ7EmMUUEFAX2DDFn6I0rUz2hkCx8dMD/cW0wuAIrYGROSL4iRlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8n7qNlDTH7NXluTQ5ud3U00K5g7Oh31p/kk1WjgJ14=;
 b=UCkc6bnwhSmfaspbnCynrzBKamhUyU/bCsuZe5LfTywqToBLVuu8Jcqr0FqaB+dseHBr9zaPJDW3Q5XCEe2rSOHFkZJM4Nvj01rRmSlh5zwmpkeI0BwLSKr/Q7hy3+kyYJWgKMrUU8fTvadfpKiLTiDEYzC29G7/0WHFClIRJUw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 18:32:38 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::c30:614f:1cbd:3c64%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 18:32:38 +0000
Message-ID: <a4b2a119-ed12-4be8-ba75-4a046770efa7@amd.com>
Date: Fri, 26 Jan 2024 12:32:34 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820,
 ACPI or EFI
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240126003514.GA407167@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240126003514.GA407167@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:a03:80::48) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 45779e96-9a5b-46cf-9665-08dc1e9d2c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	flmbVpsGX1MIS/u9gBShmvVi3zFvRbul98D6JUcEJxnthpnN5xxRaekL4A26Hn/5VVzVvRy1RZJHy5dLLZRlkFWHRgdzDSf45GNSs19Qv2lxI8YpQBZ/a2rT9Q7JhAG+3pI07JcyA4sT7rD+aaWE/lKByMP2qy17FF4hkNuBhjmU5HRc2fLayerouLFYWD36I5vUt5nvhB/TS1TTzz8LK++/hGG5A6eAsyImyRhrQcH8fsFk/i4bMY6KjEQi2OmpMgdENmOuzhvRhwR8dT7acudv7X3M7fScBHTz+ct9HBxBa/Pt/Is2xrO/JmJs8LiBglWKel1TWq/g19axiJ/xirhhEV1/OBKGDgywuXbFHURwQ6xzYXIiJ/oV9i6x0HhFkD1FCPt+TIaFa8GuxT5XJCETb8WHi/4ATX0sn4pkQa1KgalXjAkYuRwTvWtxGlnOFXHjVg5wGYljZCwhKU33MAGM5+mQMB8XckRhcyu+szBWHEAf6c7efick0pbhCMXE8komSJAVRVccIKghVtK7uFrdjcOLIZYmUx4/WF1uXJMSz/5b4v+hEjd3EVI9mfem1Jn6zfXF4LpWuEL07e2oLuz2/R5X2HvSrLYZixuAQ81Erz8DzOmvPWwR7wyh9qt7aL2wONRTlMNK5PrHbHVg5kdtWYSeRKGKSbIFiFwrqIIMwnReHLu5VRU49crQfMrj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(2616005)(6506007)(6666004)(6512007)(83380400001)(53546011)(8936002)(8676002)(4326008)(5660300002)(44832011)(6486002)(966005)(478600001)(66556008)(54906003)(66476007)(66946007)(6916009)(31696002)(86362001)(316002)(38100700002)(31686004)(41300700001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzFhVVpxS3IvTHZnSnZYWm9HUjRBRU4xdFd6empvYmtvK3ZDOVVPMlJ5UU9a?=
 =?utf-8?B?RXIvTWk5RFc0dGFGTXdIVW41UVNpYlF6d1JSckoyWnlMNC8yQjNKL2wwNXp2?=
 =?utf-8?B?OTVyY2ZXOWZmdmRNTUorMFFKazY5NlRjUmJIemlUaGd6c3BrNXlOZXpJd1VW?=
 =?utf-8?B?aUdEKzFRVVpXeW9TOWpsazF2aGdIVEpXckI4V1JQOURvejI5ckhCWUdSN01z?=
 =?utf-8?B?MGd4QjNYMTZwWVFZbHMzZjRXdm5Ob3M1TzVNN3B6NVU0cGFtYmpnb1czaEJJ?=
 =?utf-8?B?bzF5dmtxcHFHeW9pWENCbysxSSszckdWanNhbE4ySTNIeHhSTVNFcjYwQWVH?=
 =?utf-8?B?SVBaV0w5blVIKzVLL0twOUhZQTMwWTNwYklnTXNTL2NFWjMwc3AzNWZyMjNX?=
 =?utf-8?B?YllVRXVIRW9IK0NMZFVMYXlsbFc5bzZhRkczK2VqOTFudzNpQVRGb2xJU0lL?=
 =?utf-8?B?NVVXNlhEMkNDMW5pVHQranhuUDZaeHl0N0xJR2NwV2k2eXVGMGZMRTdydjNr?=
 =?utf-8?B?QVg3T2lzTytlT0g4SVdvRTJFUmN4N1NqY1FIS3J2b1B3bEZURXhJSXlCajZC?=
 =?utf-8?B?YnJOaUpBOUYzMFNUU1VwMTFIZzNTWnhyN0VLaHcxR3VCREVkTGFSd2l0QjJh?=
 =?utf-8?B?dEUxNVI3SUhKUnhxK0RaMHluUWpOTGVRNGhIQlBkWW1IVWh6dHdydVlGbkhF?=
 =?utf-8?B?aHlHWmZjc0tXVnhYTmlJK2JsWmM3aVZ1cmFaRzhjcjg4UEtYR21MY0tNWHQ1?=
 =?utf-8?B?ZWR2VWN4Z1Z3SXIrNnlybVRMbFpCMVhpb3lVdWVjNXVOYlgvMVk3djFDNS9B?=
 =?utf-8?B?c0RVaU9DakxpUlV2SnhUczJKdkpNb1hPU3JWTzhzY2JQYTM1MVg0RTJBUytI?=
 =?utf-8?B?eElPcUVqMW8vVlhFYm5LdGx5b1gxZE9CV0RzK3RUM2l3NXlRMTVUcnJMa1c4?=
 =?utf-8?B?MVRZSlg1RkRWeno3K0RMbzBUbVBWdFh2TzZuUFd1T0JCeTZ3UTByT0VtRzZ5?=
 =?utf-8?B?SXdSOHpieTFHelVUTDFVbmtYQm5OUTZmSFlnbTFaWTd5OXhwb0xIYWtvZzgz?=
 =?utf-8?B?ZFkxaUJHaVo4UFc2dWN1NjFvSUI4RUQ5RlRDa0R4dnQ5ZDZRNFpGc08xem5o?=
 =?utf-8?B?QlFTTC9rNEdIYTl2UkJ0aWk4K2tXRUFNOERIWmFTdjJ2LzM5ODc0ejdJUFVo?=
 =?utf-8?B?V1pKaWlUaktIN3FYczlPdVJGY3Fjdjl6SEhtdk1kTHpZeXQvdnlFOVdiTG5B?=
 =?utf-8?B?OWhrcnh0Y3UveVhwaERsWG5DWGdoUHQxMzl3dzJFV0dyVUZzemtweXNDK2Rz?=
 =?utf-8?B?bnhGRU8xbHBhQUlwYUxPdlhESnRrWU5jbGV5R2ZkNldnMjVGZFdBUm5XYUxp?=
 =?utf-8?B?emxvdm1KQjM4SXNYNnJ3T0ZxclUzV2IyN1JBS2tXSEs4RlREaUlrNUJ0d2tv?=
 =?utf-8?B?Q3F2Y0hMTURiN0U4WnNjUkN4L2FyMUl2b2wrZ3htdzI5U21wamZ1TjlOOXpO?=
 =?utf-8?B?V1FzYmw5SUZjdFg5SkIySWxPczBTMGRrVVlmbGVibUxnRTRtZHlKbnQ2UW5F?=
 =?utf-8?B?NFlvdzJxMEpEOTdEOW0vUzdTaDRyZjlkSGtUSDJqV2d2UEJkYlBOTTRDQ2dT?=
 =?utf-8?B?UnA4dk9TVlp0ZytEZkdMR0FpeWRobURKQXpzdHRyUVVuTlJNTlN3ZEliSnBS?=
 =?utf-8?B?VE9hU2xuSjRzTEVDMjNqRmRmZ3lNbkVvVm5IZmYwZitvMUQ0WjNqYXNBQUdH?=
 =?utf-8?B?aUwwVmRtWDVvRnBTUkoyeUNGbWh2cjBvM0FIcVdaUGUwTGdGNDNQekswMjZT?=
 =?utf-8?B?V0VlOElTYXJ2aG9UWVVsZWkzbC9iZHY5QndqckZrU2NJRFp0MTZmaVFReUla?=
 =?utf-8?B?aWpyMkxLWEZHRHAzcFkzSzlTWTMxeERUMWl2VXpOdDdYODRRNFJlaG50c0tV?=
 =?utf-8?B?Z0J2VWlxV0lOSjdYRVduNlJmcXhPSVpsS0pLUHN5bFRraXpkVzk1V1V3ZlZI?=
 =?utf-8?B?aG9FRU1ETlZNUWhCL1NxdU9uOXhGell6YVZtRjJPNWw0QWtxaytIc1dnTEJy?=
 =?utf-8?B?NlBwYkdmMW1LdnVuMzcxdS9PcjI5d0kzZHluRTFqcUlMY1hodko2eXU1VDVL?=
 =?utf-8?Q?cUG9lsjy/Du+muNWkKWl42TIV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45779e96-9a5b-46cf-9665-08dc1e9d2c5b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:32:38.4674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oLDQ95Qm8ApZRaJanfkdSQFD3qCvzPm35BqQ/KnosXFa4HyliJbGJFTmiiEuuqVPEQd1uhJMaXRpNK/kP/29lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172

On 1/25/2024 18:35, Bjorn Helgaas wrote:
> On Wed, Jan 17, 2024 at 11:53:50AM -0600, Mario Limonciello wrote:
>> On 12/15/2023 16:03, Mario Limonciello wrote:
>>> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
>>> introduced checks for ensuring that MCFG table also has memory region
>>> reservations to ensure no conflicts were introduced from a buggy BIOS.
>>>
>>> This has proceeded over time to add other types of reservation checks
>>> for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
>>> does say that these checks are only required when the operating system
>>> doesn't comprehend the firmware region:
>>>
>>> ```
>>> If the operating system does not natively comprehend reserving the MMCFG
>>> region, the MMCFG region must be reserved by firmware. The address range
>>> reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
>>> reserved by declaring a motherboard resource. For most systems, the
>>> motherboard resource would appear at the root of the ACPI namespace
>>> (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
>>> in this case should not be claimed in the root PCI bus’s _CRS. The
>>> resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
>>> as reserved memory but must always be reported through ACPI as a
>>> motherboard resource.
>>> ```
>>>
>>> Running this check causes problems with accessing extended PCI
>>> configuration space on OEM laptops that don't specify the region in PNP
>>> resources or in the EFI memory map. That later manifests as problems with
>>> dGPU and accessing resizable BAR. Similar problems don't exist in Windows
>>> 11 with exact same laptop/firmware stack.
>>>
>>> Due to the stability of the Windows ecosystem that x86 machines participate
>>> it is unlikely that using the region specified in the MCFG table as
>>> a reservation will cause a problem. The possible worst circumstance could
>>> be that a buggy BIOS causes a larger hole in the memory map that is
>>> unusable for devices than intended.
>>>
>>> Change the default behavior to keep the region specified in MCFG even if
>>> it's not specified in another source. This is expected to improve
>>> machines that otherwise couldn't access PCI extended configuration space.
>>>
>>> In case this change causes problems, add a kernel command line parameter
>>> that can restore the previous behavior.
>>>
>>> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>>>         PCI Firmware Specification 3.3
>>>         Section 4.1.2 MCFG Table Description Note 2
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>
>> Bjorn,
>>
>> Any thoughts on this version since our last conversation on V1?
> 
> Just to let you know that I'm not ignoring this, and I'm trying to
> formulate a useful response.  

Thanks, I had been wondering.

FYI - we've also added another place to make noise about this ECAM issue 
in AMDGPU.  This warning should go into 6.9:

https://lore.kernel.org/amd-gfx/20240110101319.695169-1-Jun.Ma2@amd.com/

It will at least be interesting to see how many people come out of the 
woodwork to report that new warning.

> mmconfig-shared.c has grown into an
> extremely complicated mess and is a continual source of problems, so
> I'd really like to untangle it a tiny bit if we can.
> 
> One thing is that per spec, ACPI motherboard resources are the ONLY
> way to reserve ECAM space.  I'd like to reclaim a little clarity about
> that and separate out the E820 and EFI stuff as secondary hacks.  But
> there's an insane amount of history that got us here.

I guess you know better than anyone here.  But if my idea is actually 
viable then the E820 and EFI stuff turn into "information only".

> 
> The problem we have to avoid is assigning a BAR that overlaps ECAM.
> We assign BARs for lots of reasons.  dGPU and resizable BARs are
> examples but there are others, like hotplug and SR-IOV.  The fact that
> Windows works is a red herring because it allocates BARs differently.

Have we actually observed a case that assigning the BAR overlaps ECAM 
region thus far or it's hypothetical?

I would think that if the reservation is made by ECAM first, then any 
conflict for any reason that tries to assign it will just get a smaller 
BAR, but not necessarily a functional problem.

But that's also part of why I was thinking kernel command line for us to 
have the escape hatch.
> 
> It's also little bit of a burr under my saddle to add things for a
> problem on unspecified machines, where I don't even know whether the
> machines are already in the field or the firmware could still be
> fixed.

Of the two machines I know of:

* One of them has been fixed by a BIOS change before it's final 
production stage.
* The other is still affected.

Here is the info for the still affected one.  It's been shipping already.

Alienware Alienware m18 R1 AMD/0RU01H, BIOS 1.2.2 04/21/2023

> 
> And of course, if there's any way to solve this safely without adding
> yet another kernel parameter, that would be vastly preferable.

The kernel isn't static though; something we could do is keep the 
parameter around a year or two to get the bug feedback loop of people 
testing it and then rip it out if nothing comes up.

> 
> Sorry, nothing actionable here but wanted to let you know that it's
> keeping me awake at night ;)

:)
> 
> Bjorn
> 
>>> v1->v2:
>>>    * Rebase on pci/next
>>>    * Add an escape hatch
>>>    * Reword commit message
>>> ---
>>>    .../admin-guide/kernel-parameters.txt         |  6 ++++++
>>>    arch/x86/pci/mmconfig-shared.c                | 19 +++++++++++++++----
>>>    2 files changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 65731b060e3f..eacd0c0521c2 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -1473,6 +1473,12 @@
>>>    			(in particular on some ATI chipsets).
>>>    			The kernel tries to set a reasonable default.
>>> +	enforce_ecam_resv [X86]
>>> +			Enforce requiring an ECAM reservation specified in
>>> +			BIOS for PCI devices.
>>> +			This parameter is only valid if CONFIG_PCI_MMCONFIG
>>> +			is enabled.
>>> +
>>>    	enforcing=	[SELINUX] Set initial enforcing status.
>>>    			Format: {"0" | "1"}
>>>    			See security/selinux/Kconfig help text.
>>> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
>>> index 0cc9520666ef..aee117c6bbf9 100644
>>> --- a/arch/x86/pci/mmconfig-shared.c
>>> +++ b/arch/x86/pci/mmconfig-shared.c
>>> @@ -34,6 +34,15 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
>>>    LIST_HEAD(pci_mmcfg_list);
>>> +static bool enforce_ecam_resv __read_mostly;
>>> +static int __init parse_ecam_options(char *str)
>>> +{
>>> +	enforce_ecam_resv = true;
>>> +
>>> +	return 1;
>>> +}
>>> +__setup("enforce_ecam_resv", parse_ecam_options);
>>> +
>>>    static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
>>>    {
>>>    	if (cfg->res.parent)
>>> @@ -569,10 +578,12 @@ static void __init pci_mmcfg_reject_broken(int early)
>>>    	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>>>    		if (!pci_mmcfg_reserved(NULL, cfg, early)) {
>>> -			pr_info("not using ECAM (%pR not reserved)\n",
>>> -				&cfg->res);
>>> -			free_all_mmcfg();
>>> -			return;
>>> +			pr_info("ECAM %pR not reserved, %s\n", &cfg->res,
>>> +				enforce_ecam_resv ? "ignoring" : "using anyway");
>>> +			if (enforce_ecam_resv) {
>>> +				free_all_mmcfg();
>>> +				return;
>>> +			}
>>>    		}
>>>    	}
>>>    }
>>>
>>> base-commit: 67e04d921cb6902e8c2abdbf748279d43f25213e
>>


