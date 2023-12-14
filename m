Return-Path: <linux-pci+bounces-1021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0553A813CE3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 22:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC7BB21FE3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 21:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B412C68F;
	Thu, 14 Dec 2023 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EY2UGqpB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D32C69E;
	Thu, 14 Dec 2023 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmUSGwrxTc4Lp3sHx4QuAjBduvC2y9r4HOIEpKebVJbQOKSS1/NPHHmgIm/aLSc+W1+nd0k0Iz5ff5kIU1K3NC3rYI/miz1JGAExx36OJ9499OSme9LMgglVVO18ewWQ8XK7Us4me+wg2Py0bSRI/7ieaYLA0KGAKOw9LV4wbaeX1qWCL637PaV16vzxES2kto7taDWJYLBraNkhqyv4GlAND5AVmccPn1BNI23pysK4PNQqePfkeiwxCBnEd3ccNhD7fq1Ue8DJDseg/Qu7pF3Jb+ViMkKq6FhPFCM/pd8d7IxFa+pp939grP3o71B4ax3sxMRN/EsXlFxNKcmavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl6J37M2GU1nHR7OKczWQxB/bhoMGYMEWnH9iBUQJ6M=;
 b=Qh0/o6OgPQy5LBNXtRbGgEMVLkk9EPDw2+O29DRxau0UvPimo6mpMkeUodmNQD9BwnnoVUOIl9sftP+0pSVb1CVmQfvdgTFEE4FccUgbgq25xRvTyb4mPBXNpaoZCtIVyN0qSbb4Hjga7hiM8PQ7Le+K6izVdaF9AjsffaY5Fx+e9y6M96pp1CDJoObPPNBzybCnejcbNVxVCObBzRiuaAX9mKnVFJAgAs5j5qrQignxsV5Th5ldf4j1Rijs6fsMBptAA9HwjyyfTkH3pT6RVJWpVl94FW9OkEhnaAZ0PVVfXw/b/Le6jtKnsWqMfOM4LvjchganxBxDAYc49jVw9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl6J37M2GU1nHR7OKczWQxB/bhoMGYMEWnH9iBUQJ6M=;
 b=EY2UGqpBPfTXKgwdJ5ZfaOZDISCVNphEKQShDfMDZGqAtXwMUQDo4nedifOAeoATk2utA6xVmtebRjpNru2Z4NcNMjJSjOB6/rINxmtY9RyXf2YzBA12d6dBH6QmDcj/9Qeqk6HaG0LbtCQ5gPOS8holcK/XwHOBufrcRUXG0Pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 21:45:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 21:45:46 +0000
Message-ID: <8d91910d-2676-477a-be62-5365afd199bb@amd.com>
Date: Thu, 14 Dec 2023 15:45:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
References: <20231214204341.GA835486@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231214204341.GA835486@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0190.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: b1785778-8938-4c6a-3873-08dbfcee0780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pBXXby4XjR8fFNcqTGFpaTJ5NvBIvJpe2HDPYOwrYpkR8am45t7K8/dbRrQjxfuxX9B0N7DrR52mTb350qETB/P1MIIBu9l0H2KwhrcNFzRDrxUrpX5bYUfViP9CNdbFRhOC2IsGEe+Zz7cvpmTjqvKrpQn+RScZhrqAXYQ++Lmg+OQTWl9u/t1jDvCA+LWvgv80VBhQy6b+a96okzADDDVPkiSq/bT3w4aiCRSIx9KcWQfYyHL7fo12Pt8E4XissBG1UvTb2NjC5k1bNe8Zma0etW2hYXlB+cNHI423+GtJFrPtoeOfnVHEFpMU+89EFOhOQ6g3w1gPid0FfNBeYO30V4wAsoTfb1+Ih7eONmKxEuCkBTuRm9Oe9TWm6nvQR60lg2VDC1uIIL0itX61+QtKQU/bLLbMssvevh3ArphbGNCK/kDjE3RgjUyFwMuDvPX7PMWqR2Di9T78F4xvsslMS7Xk7B6ZNjP7A0NVgp44qUd4bp+0ZE/4XmjBfbrAxJtAjRYEX1LwtUgfEP3nIdEL0gpuffgsAi1OWDv5MP43ChTI8JsubYQBibYkKykxBAvMjbEYLkQ+ec/8dCrgV4WKFCHbd9P/eEv6or5ibeE2Kimrv+9dTwNnwkZdesA0+2jIkMQUNQqZnsKWDBK2VA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(966005)(6486002)(66574015)(6512007)(8936002)(6666004)(4326008)(8676002)(83380400001)(478600001)(31686004)(2616005)(44832011)(26005)(54906003)(6916009)(66556008)(66476007)(66946007)(316002)(53546011)(6506007)(5660300002)(2906002)(41300700001)(86362001)(31696002)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStBZVYxeVlwNFlpbXZ5NldndmRQdTJpb3BEUmFWVStDalZNQ1NkS2tVL3Nz?=
 =?utf-8?B?SGR4V1FMczlmZ0lLVVpsRGpiNnVBa1VBUTNML3ladFgxUGNXd3Y3OTU5cEhF?=
 =?utf-8?B?Q1V3dmJsRmZXV2N5bVJIdVEwSEMwT1NTN1BJQTJBQURuUEdIcWZSQ1RWY3ZB?=
 =?utf-8?B?dENwd0c0dmtWZlF4ZDdSQVdSdFZyM2tSVklGdzlRNGlDTk1EMTFpTk54ZFF1?=
 =?utf-8?B?TGozZ3RnbEQ0N04yMmJqSnA1aGxVNytXbEV4S1NIaUN0LzI0WUhzZDYvdUpj?=
 =?utf-8?B?aEEzaThsUFhiVU1CQUI2bFZ0d2dkNUJ1Vjh2a3gyd3hIRit0b3JQeWl6cXYy?=
 =?utf-8?B?V0Y4K2gvNXRHa1pmTk1ueVhwVEJ6RVA0MzNXRys0eGt5cE5FR3NEYWlQaS95?=
 =?utf-8?B?R1Yrb0t0dnlSWkN3UjRna3diQTRIM2VyOUJrTDRaYTZySHNpZVNTMXNvSVdo?=
 =?utf-8?B?dTdNSUpvTSszOXhjTGVaQ3ZoSDhONldiM3FKTVVKK2s0VFdVUzVUZTNPVnhi?=
 =?utf-8?B?YUlVa2N6VUdXNVAyTlVHK3BydWxRZjR5a1NjZXFrMS9YQnZacmJuc2IvTXFy?=
 =?utf-8?B?V3BhU2J6QnF4MWllVTVXRUNEczFPK1VacEZ2SEg3dVVNdjAvT0xzdTljOHF0?=
 =?utf-8?B?V1QrTFNMeTkzYlVITEVwaFBTQ1h4eFF4QkxFczl4UXNiKzNzNWxyWFgyaGU1?=
 =?utf-8?B?UFlJcDkxM2JpL0M2RE41b0cwSzB1a3BVemdqbGhlb0cxQmlJU0thVDRhaTRl?=
 =?utf-8?B?dU14OHdwbXZ0ZkxVVmt5bU02UTR0UTRGQlRGMm5tWHoxdTdpUkFrQUlGcFlZ?=
 =?utf-8?B?OUxRY2U2VTBvWDhtZ3RGUE1SQmFoNWp3R0p4a0hoQ1dVSVBqcVYwcVVuR3ly?=
 =?utf-8?B?bVA1M3d5Q3lkdGhSVUdzbjdPSEs1ODljeWs0LytGNDIxazFZVDF2UE1yNHJ2?=
 =?utf-8?B?d3VGMVdYNW0wdUlWa2VCdmxaTmJRcEd3SjJnTW9lRnE1a1VRT0tveEE4Mk1r?=
 =?utf-8?B?V0tEV2wzeWpFMEhBRjVmREhiaXYrcjR5QjZWNktYdWZKOUIwaXNLTFk2cXJx?=
 =?utf-8?B?emJLeXZyNElaRXBXalRLdnRuWk83TzNvc05XelVVRENrR3FmVW0rT0htYXpG?=
 =?utf-8?B?MStRNjRWZGtuT21Hd3lVREJaakV4ZTFoYXhiNlVGK1BYSFlpSDNETjJNY2py?=
 =?utf-8?B?aGcxdGRYWWt6bEdIcHU5VE5Jd2F4VmFTRGhheGFKcVcvT3dlTTRIQXRpK1d2?=
 =?utf-8?B?TWNqNnM2d2hpcjMvMllUU3dxaGw3QWpSbno0SmlHUHhRMk5ROTZjUlFPZU5F?=
 =?utf-8?B?WHE0bi9wUlUxamlzaFVqS25LY1JQOVk4N1VydW1QRFhpUTNPRmVrd2NxYjND?=
 =?utf-8?B?bzhoVUZIay8rQXJtWkVzT0FZVXhTWDVQdExRdWlqTnk0a3NTT3piLzlnQ3o5?=
 =?utf-8?B?YmdacVczbzNvUGl4RGRwNlZEYkxXdkdNRW5uWndSRVBSOFp6YmhvMHE5RW1N?=
 =?utf-8?B?ZTlHWWVqNjJVdVRJbDR5eDNiQjdoNC9mbzVzUzI4cVBWVktiZE5sb0pQTVpT?=
 =?utf-8?B?UnBZTzNLSWVjRU94T0doajNvTENPRmNlZTFONFpDMlBOYzAzREFOZVNHc0Rv?=
 =?utf-8?B?ZGZtVlpibWNnMUtSNUxFMXZSOWlSd0E1Y0VuSnRmTnhac0xvaFErZy9RejR6?=
 =?utf-8?B?RDRDZGxZdEl3QmlNc0pZdnNsZkVSamFTZUdySHVibXQ1VVIrYjZrdHYwVHZI?=
 =?utf-8?B?U2tZM3pVd29FemNtZ0Z3WnJ0akZzZXZpY1cwZUhvTGtZSUZ3d2RWUW05UXp6?=
 =?utf-8?B?UHcwRHFqNFNva3lpd04rWXlkZ3ZjdllXM2VZVG1LQXBVTTY3ZFJwSm9aMVg5?=
 =?utf-8?B?UEtCN2VqWWFRV3JDSlZtTnhUY0dXODhYMHVlbUppUUZLNXhhTXMrMTVJcTBF?=
 =?utf-8?B?V3BHMXZJd2orQnluSktlcjVXVXJDTFpCSHJybXpTeDAybDduZzhvNmRoZkF4?=
 =?utf-8?B?eWNNb3F5a0psYmVtRmdXampMaGc1YUk3Q1l5cEhlbW1CNDhMdUdXdEdKTjZo?=
 =?utf-8?B?SVpYK21pVFBYOU13dFgyRHBjOUJqdUl6S3RWMmUxZjdKUyt5YmhDVFFabTN0?=
 =?utf-8?Q?ht0XTyqA5KEaFbkTBELw+E57P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1785778-8938-4c6a-3873-08dbfcee0780
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 21:45:46.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKEvE3CRUdAliEESpvM492CJop1eo/F0XRyUQQhsDKJXUoEVMdbH7Rc1WMB/VlrJQo5PwB/R4uuj2dXd5T7XEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931

On 12/14/2023 14:43, Bjorn Helgaas wrote:
> [+cc Len, Robert in case I'm missing something about static tables
> reserving address space]
> 
> On Tue, Dec 05, 2023 at 12:28:44PM -0600, Mario Limonciello wrote:
>> On 12/5/2023 11:31, Bjorn Helgaas wrote:
>>> On Tue, Dec 05, 2023 at 11:00:31AM -0600, Mario Limonciello wrote:
>>>> On 12/5/2023 10:17, Bjorn Helgaas wrote:
>>>>> On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
>>>>>> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard
>>>>>> resources") introduced checks for ensuring that MCFG table
>>>>>> also has memory region reservations to ensure no conflicts
>>>>>> were introduced from a buggy BIOS.
>>>>>>
>>>>>> This has proceeded over time to add other types of
>>>>>> reservation checks for ACPI PNP resources and EFI MMIO
>>>>>> memory type.  The PCI firmware spec however says that these
>>>>>> checks are only required when the operating system doesn't
>>>>>> comprehend the firmware region:
>>>>>>
>>>>>> ``` If the operating system does not natively comprehend
>>>>>> reserving the MMCFG region, the MMCFG region must be
>>>>>> reserved by firmware. The address range reported in the MCFG
>>>>>> table or by _CBA method (see Section 4.1.3) must be reserved
>>>>>> by declaring a motherboard resource. For most systems, the
>>>>>> motherboard resource would appear at the root of the ACPI
>>>>>> namespace (under \_SB) in a node with a _HID of EISAID
>>>>>> (PNP0C02), and the resources in this case should not be
>>>>>> claimed in the root PCI bus’s _CRS. The resources can
>>>>>> optionally be returned in Int15 E820h or EFIGetMemoryMap as
>>>>>> reserved memory but must always be reported through ACPI as
>>>>>> a motherboard resource.  ```
>>>>>
>>>>> My understanding is that native comprehension would mean Linux
>>>>> knows how to discover and/or configure the MMCFG base address
>>>>> and size in the hardware and that Linux would then reserve
>>>>> that region so it's not used for anything else.
>>>>>
>>>>> Linux doesn't have that, at least for x86.  It relies on the
>>>>> MCFG table to discover the MMCFG region, and it relies on
>>>>> PNP0C02 _CRS to reserve it.
>>>>
>>>> MCFG to discover it matches the PCI firmware spec, but as I
>>>> point out above the decision to reserve this region doesn't
>>>> require PNP0C01/PNP0C02 _CRS.
>>>
>>> Can you explain this reasoning a little more?  I claim Linux does
>>> not natively comprehend reserving the MMCFG region, but it sounds
>>> like you don't agree?  I think "native" comprehension would mean
>>> Linux would not need the MCFG table.
>>
>> After our thread and the spec again I think you're right Linux
>> doesn't natively comprehend (reserve this region;) particularly
>> because of the stance you have on "static table" vs _CRS.
> 
> ["My stance" refers to this:
> 
>    Static tables like MCFG, HPET, ECDT, etc., are *not* mechanisms for
>    reserving address space.  The static tables are for things the OS
>    needs to know early in boot, before it can parse the ACPI namespace.
>    If a new table is defined, an old OS needs to operate correctly even
>    though it ignores the table.  _CRS allows that because it is generic
>    and understood by the old OS; a static table does not.
> 
> from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.6#n32]
> 
> I don't think this is just my stance.  The ACPI spec could be clearer
> in terms of requiring PNP0C02 devices, not static tables, to reserve
> address space, but I think that requirement is a logical consequence
> of the ACPI design.
> 
> It's a goal of ACPI that an OS we release today should run on a
> platform released tomorrow.  If the new platform uses a static table
> to reserve address space used by some new hardware, today's OS doesn't
> know about it and could place another device on top of it.
> 
> Using _CRS of an ACPI device to reserve the new hardware address space
> is different because it works even with today's OS.  Today's OS can't
> *operate* tomorrow's hardware, but at least it won't create address
> conflicts with it.
> 
>> I just don't want to throw the vendor under the bus as it could have
>> been caught "sooner" and fixed by BIOS adding _CRS.
> 
> The MCFG requirement for PNP0C02 _CRS has been in the PCI Firmware
> spec since r3.0 in 2005.  I'm surprised that vendors still get this
> wrong.

Probably worth mentioning with the clairvoyance of the root cause of the 
issue that prompted this conversation I've now discovered another system 
with the exact same problem.  It's a different OEM, different generation 
of hardware and a different IBV that they use for their firmware.

I've also looked through the BIOS for a variety of reference designs and 
I don't see a _CRS entry in any of them.

I'm fairly certain we're just getting lucky in Linux on a lot of devices 
that the region is often overlapping with a region for EFI runtime services.

> Vendors definitely have an interest in making shipping OSes
> boot unchanged on new hardware.

At least the OEMs that I talk to use FWTS.  FWTS catches this issue, but 
it's marked as LOW.  Everyone fixates on the HIGH or CRITICAL.

Given the severity of what I've seen it can do to a system I'm proposing 
FWTS to move it to HIGH:

https://lists.ubuntu.com/archives/fwts-devel/2023-December/013772.html

> 
>>>> Knowing Windows works without it I feel this is still something that we
>>>> should be looking at fixing from an upstream perspective though which is
>>>> what prompted my patch and discussion.
> 
> The fact that Windows works doesn't mean the firmware is correct.

Of course.  But it also means it's worth looking at the semantics of why 
Windows works.

> Linux assigns PCI BARs from the bottom up, and ECAM is often at the
> bottom of a host bridge aperture.
> 
> Windows assigns PCI BARs from the top down, so even without a _CRS
> reservation for the ECAM space, Windows is much less likely to put
> something on top of it.
> 
> Bjorn


I guess I'm naïve in that I don't know how exactly to check what Windows
*really* does (gets lucky from top down or actually reserves from MCFG).

But I do feel the OS doing it from top down vs bottom up is tangential 
to the decision of whether or not make a reservation in Linux for 
something you know about without a _CRS entry.

I can push AMD's reference designs to improve, I can push OEMs I talk to 
improve and I can try to influence FWTS but I have to ask:

What is the actual *harm* in just using this MCFG table to make a 
reservation when there isn't a PNP0C02 _CRS region declared?

At worst (a buggy BIOS) you would end up with hole in the memory map 
that isn't usable for devices.  At best you end up with more working 
devices without changing the firmware.

