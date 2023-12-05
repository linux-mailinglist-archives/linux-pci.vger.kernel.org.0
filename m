Return-Path: <linux-pci+bounces-515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B98DB805A9C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA6E1F21722
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771163DE1;
	Tue,  5 Dec 2023 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LzPqGy5P"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B082188;
	Tue,  5 Dec 2023 09:00:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxRo3b1ARmbH1ty5d7s2TJxcJUxUqwxIYY/4VGONousrNatZBc460yxcxUrxXdwL8hCh8n8kDHFgprQArH9TANhlEmhhZKloJtlZiLgkhCaPqUDdHZjerJ1PJwm0OsQgAu/chavGpTuXiOoFhVryvp0Yi3gNhljxlodrHcLRMcEvL8R5bE/7E0GLWvgJ9y20E1GeC5eAsM0eQdGlO5vPOlS6weDRcA/VvNFGAQSZHwaZzGlIK6Peb04h2tC6N9Z43qP1o3hBR/ESIVDMNp1PhpJB06HZfDqWOpRRfcHRwcUaej7rLpCghQHuGlNOM3a7CyoacIFZ64v4r8MFCR6NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKinrC7AuSgokzwvT73kVDTrojSsKGTIzPMr29xncwc=;
 b=mJwwwUH7zZHho3eeFk/lcD1yEqHwEqawILWV5oKQ+5UYZlzBOOaRzcLGJzzZ5NZTssbplT3fMg3O+Mloh8jmHViG2vNBlFlpuJzW9RwLjvCCNQorCkedS1uzhk3Gou4cOhfLWmG3qfBPztBczTlMwRVrAJGqUI5ViP00LkiwQjoApEeFhT3GrDycITXNBbmnEoJ/LTOAdeyVvVfFy+FhW6YJKS6iIkCADNwRT9LL3j3PhYQMCCi8LbABb3Gv1Nbo3RJyarfT2Tqmcjn+tUmX/hl2tZFavCkvyaSDTShfQ0QQ1QR7QKo7lfTvaPib5yqcPLaJEIbtT6Y2tfOlzuyICQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKinrC7AuSgokzwvT73kVDTrojSsKGTIzPMr29xncwc=;
 b=LzPqGy5PwlkabwkTX/uUzfPeeNTjyNzzvEQ00/gc+wmwfmynvZ7NxndL0ZsQp4hBcoBOb7oZZUSIGohmmFRXWpkfOhEH/y1oMHILQAtJyXEqfF+42yVeh5U7eZh0eowy3Tfm3FhxSQzA6IdN7Y6Dw6hMcMpT8YymMgaZiaFQBIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 17:00:33 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 17:00:33 +0000
Message-ID: <519ebaea-60ae-413f-8746-0f75574b8cb9@amd.com>
Date: Tue, 5 Dec 2023 11:00:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231205161713.GA674824@bhelgaas>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231205161713.GA674824@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:806:a7::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 539ded62-c04d-4576-ddee-08dbf5b3b1dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+0yxfsN0SUG9FqW1HOJ+dyeF/SWVO4d0ykVGXCNMlec5GLyJ1KPjKrHNBE2R4gJ3w82evxx2HUb7F49nRttmKZ+nmO1lWaM+bV4Dji77+y2XSecr/A3SQ362ucmyk0Llt7m3zvf94b7zCyazMwhwki95155SQDNpI1d3YHN+OoMw5XlUsVIXIrvDLOW4qXbTkrjM5+MIDxvcs7k3PXnx8fqTcwbLEw3LFYhjJcNqcORN1zMCgP8C1FB/rkvlusr0LrIo4VbYxeMWi6a6owiURUNmHFJP2Q2TRFyc9CGFCjSOMTfBixdFfEilbExkZjRa4+ovEzJlCdjgX/jmSfIb61xurg4XHUNX5xAdMp+aNRjSi7JsHrSvlKvYwZKUcqrg0HUlzsWfI9L9WyDmk7LNo0DKmTHyWXNgWMxMTWkgDUdN0IMH17duZXZMzE1RJP5/OV5qD06OaU2dumf+XvlwylSZVOTbMJjby25eUqGFl5oOpMbYztHgO9nnRRXXZfonIGTwbroOlETxqpY3AtrthQF3uimiqa0krZngZY3kFYFbv0Nc8pG93q7Rg5xKrnZc+v7R86E24bcCPMho3S8A/q15mDKVCfD0YFe+J5FxR7hODdLs020F6257NsjcFcQRmmDI84L7I6jDvlsKbWh9iYss0zFlQVfwh4hqcLyqLkwXHMI2dYEQxngWA6419kH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(83380400001)(53546011)(966005)(478600001)(6486002)(6506007)(31686004)(8936002)(4326008)(6916009)(54906003)(66476007)(66556008)(316002)(8676002)(6512007)(2616005)(26005)(66946007)(38100700002)(44832011)(86362001)(31696002)(5660300002)(2906002)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzRWWkpPUmZFRzh6T1NpTVFldlRkR1p4UUFoWGRHSWFLNDN1cW1DUDN0MkNC?=
 =?utf-8?B?T0IzMFhFb3p1R1pkNkNHYlBtVkNMNytLVGdvc0hpLy82d3hRYm12SjRzbU5T?=
 =?utf-8?B?eHFmekdKclRjY01FNmlQR2RuNG9WdTVCYjh6Q0pSMXZPc0creDNGS0lUVnBK?=
 =?utf-8?B?a2MwRHJZemgvdFF3eTMzL2U0OGI5dXdUQU5MZXVhV3VkVUNKQVRrSnNVVVVz?=
 =?utf-8?B?SFpJWW9sRFhHOFN6dngrRlZNQVhxYWRqb20wam9FN3FqQWZMQnY0N1YzM3dK?=
 =?utf-8?B?cmxrOHh4SHVDYW9sWmJCTk9tRmlVZld3YWxFQVdlcno1VVkvS0wzSUNCVHlQ?=
 =?utf-8?B?K05Ybys5SjQzalY5TVhpMzRmdW50WnJmUGNtSTJMRXFrd1RGMFpGMjA3d3dj?=
 =?utf-8?B?YzdTUzVhSGEyQ1BISjJVaWt1TFIyWlM3RFczbHJPUTIrUmJQb3JsT1lIZVNq?=
 =?utf-8?B?TnpVSUQwKzlJMjU4VnlyazI5THB3QUc4bEVyRVN5SWZXTjhNZ2E5c1UxMUlO?=
 =?utf-8?B?Mk9KQ0E2aGhPY3haU1ZwU21ZdTVDdXNsWFRuOWZXM0kyN2R1V1FsL3FMTFBK?=
 =?utf-8?B?WG45a2lWa04wd0RUTHBzK2xqKzJ0eTBDZFVTaGNaTUNNZDI2am9XbENhS0gz?=
 =?utf-8?B?WHdkZzc1S0lpUTVxcy9qeVdzVTVwVUovV0F2eTc1eWh4YndMUlVjSEh1dWgy?=
 =?utf-8?B?alN2US9WMnlHQ1dyY3RzN3F5Z3BCRTJQWnBDTGFDbVBINnd5MXloUmFKQnBs?=
 =?utf-8?B?dno2bEdQdHppQ1RYZUdta1ZkVE5xeW0xbXpadjY1cFBzTzVUVFdDOXNnRG9F?=
 =?utf-8?B?b1Y4bVRHTG82bWJlNlBjWFRBQXBwRW9Qd3E3cDdyamtzcFloTmtKMDBxczhD?=
 =?utf-8?B?Nm4wNHlGWlpSSFRxcnZqZmF2ZUNMWFJDV3FhRGR6QU5sRlNmZE1FM3pFMGZL?=
 =?utf-8?B?clJNWm1oa1ZrWEZ6My9nalNhcm9iYVAzZ2NaeUt0SExENXRzTkFDV2ZiaGhL?=
 =?utf-8?B?K1hjdkxaSnVNRnlUQTZuYVB5ZjJ6VzlQMVFySjZreGZ6eUd2VDBsU2NZcGVp?=
 =?utf-8?B?M2VIWUZ5aHZGQ01LdVA2Y1NLRTdkS0pVNWdVV3YyT2IxNDRGZUE4MS9YQzAv?=
 =?utf-8?B?UlBMUFBQSjRSREVXY3VsOWhxc3IyU2VyTy83WWhjSHFKQnd4ZzJEOTFLZUU1?=
 =?utf-8?B?Z1NFc1FrYWtnd1M4VGhKOW9BU05oV25QUldWVXFHemMzTVhWWkFjOVltRW1F?=
 =?utf-8?B?YlNyVytUK1pkM3JkWmFJZDJ4dGg3L1pnMVg4MjIrazNKTHcrM3pMZFlUdjI1?=
 =?utf-8?B?bXk4VjB6TGs0Q2tLZ1p2cmN1UDBHOGtUWHVoTWVtSVZYeXd6bjdyWFA1Z0hv?=
 =?utf-8?B?UGxMUzFpV3lCNjM0Nm9DYm5QZjR5QlQ1and0TVg5TDYrTFkrSTBLaDRlbFBN?=
 =?utf-8?B?ZnNYNGRGbkNCeUxoTUR2NVNiT0VMZVljOTBpdjJhMGprUlpnUFhnZEMvTGhU?=
 =?utf-8?B?T0N6dFgzUkxIbXltT1hGQ0RuQXZyV000TjR4Q1pTQytJZU9ZL2l4WkdNUXI0?=
 =?utf-8?B?WVN0dnJVN01IYmpkdlBua3RpcW5sV0lsSG91RStqbVRZNVFOL1FCTzFWc25j?=
 =?utf-8?B?RUppdVVDbHdiVWdxZ0xJckluUFczaHJoUXg1cWphVEE5Tm02SXg2Ty9hR2FU?=
 =?utf-8?B?QlRNVnZVQkQ0UDFyRWxiUlFqQUZaUGMzY2t3YUZrNXVoS2ROc2srMEd4dVpN?=
 =?utf-8?B?TG9mWU5Gc3FSeXQyVmYzbk5BWEo0d0h6dmpEdEFkamYxeGFQZCtxWVIzd1JI?=
 =?utf-8?B?NDIxSTk1ZE56ZUdkU2VYUXRTeXBES09QNmNTR3N0dGxGTWxneVI1clFuK29y?=
 =?utf-8?B?eUNQRmtTSDBBT0FJbFVZdWN6QVppMkRjUnRhN2huS0U2b3pISUJ1OFNnNkJZ?=
 =?utf-8?B?cWkwVkVLMU5RSnFrL3FZRmZTWjByN2M5Si9GV2VOT3hHYTlaTU0wMU5iaTRC?=
 =?utf-8?B?YkZsbitvckxlL1FIUTJJZHI2ZnowMlVmS0M0d1JqZ25DMTZ6ME5rOGRMcEdB?=
 =?utf-8?B?VVY1d2xPbnBaR2pTSEw3WEpYU0xDL3pPc28vYzlWLzNudWMzVEpvcGU2WGo3?=
 =?utf-8?Q?hJS0sb7AFkV51vCTrlIUY8ZJs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539ded62-c04d-4576-ddee-08dbf5b3b1dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 17:00:33.6762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmfboL+II3oXdCvRtMofzOp1cNspT7Hpq4g4g9TZWjvCLkiRwkH686WGhl81XIuBi/0aAYfbmbFycql/A/EGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

On 12/5/2023 10:17, Bjorn Helgaas wrote:
> On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
>> commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
>> introduced checks for ensuring that MCFG table also has memory region
>> reservations to ensure no conflicts were introduced from a buggy BIOS.
>>
>> This has proceeded over time to add other types of reservation checks
>> for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
>> however says that these checks are only required when the operating system
>> doesn't comprehend the firmware region:
>>
>> ```
>> If the operating system does not natively comprehend reserving the MMCFG
>> region, the MMCFG region must be reserved by firmware. The address range
>> reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
>> reserved by declaring a motherboard resource. For most systems, the
>> motherboard resource would appear at the root of the ACPI namespace
>> (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
>> in this case should not be claimed in the root PCI bus’s _CRS. The
>> resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
>> as reserved memory but must always be reported through ACPI as a
>> motherboard resource.
>> ```
> 
> My understanding is that native comprehension would mean Linux knows
> how to discover and/or configure the MMCFG base address and size in
> the hardware and that Linux would then reserve that region so it's not
> used for anything else.
> 
> Linux doesn't have that, at least for x86.  It relies on the MCFG
> table to discover the MMCFG region, and it relies on PNP0C02 _CRS to
> reserve it.

MCFG to discover it matches the PCI firmware spec, but as I point out 
above the decision to reserve this region doesn't require 
PNP0C01/PNP0C02 _CRS.

This is a decision made by Linux historically.

> 
>> Running this check causes problems with accessing extended PCI
>> configuration space on OEM laptops that don't specify the region in PNP
>> resources or in the EFI memory map. That later manifests as problems with
>> dGPU and accessing resizable BAR.
> 
> Is there a problem report we can reference here?

Nothing public to share. AMD BIOS team is in discussion with the OEM to 
add the reservation in a BIOS upgrade so it works with things like the 
LTS kernels.

Knowing Windows works without it I feel this is still something that we 
should be looking at fixing from an upstream perspective though which is 
what prompted my patch and discussion.

> 
> Does the problem still occur with this series?
> https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org
> 
> This appeared in linux-next 20231130.

Thanks for sharing that.  If I do respin a variation of this patch I'll 
rebase on top of that.

I had a try with that series on top of 6.7-rc4, but it doesn't fix the 
issue (but obviously the patch I sent does).

# journalctl -k | grep ECAM
Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 
0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem 
0xe0000000-0xefffffff] not reserved)
Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 
0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
Dec 05 06:37:46 cl-fw-fedora kernel: PCI: [Firmware Info]: ECAM [mem 
0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem 
0xe0000000-0xefffffff] not reserved)

> 
>> Similar problems don't exist in Windows 11 with exact same
>> laptop/firmware stack, and in discussion with AMD's BIOS team
>> Windows doesn't have similar checks.
> 
> I would love to know AMD BIOS team's take on this.  Does the BIOS
> reserve the MMCFG space in any way?

On the AMD reference platform this OEM system is based on it is reserved 
in the EFI memory map.  So on a 6.7 based kernel the reference system 
you can see this emitted:

PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as EfiMemoryMappedIO

But on the OEM system this is not reserved by EFI memory map or _CRS.

That's why my assumption after reading the firmware spec and seeing the 
behavior is that Windows makes the reservation *based on* what's in MCFG.

> 
>> As this series of checks was first introduced as a mitigation for buggy
>> BIOS before EFI was introduced add a BIOS date range to only enforce the
>> checks on hardware that predates the release of Windows 11.
> 
> Many of the MMCFG checks in Linux are historical artifacts that are
> likely related to Linux defects, not BIOS defects, so I wouldn't
> expect to see them in Windows.  But it's hard to remove them now.

I guess I was hoping that by cutting a line in the sand we could avoid 
breaking anything that was relying upon the older behavior.

> 
>> Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
>>        PCI Firmware Specification 3.3
>>        Section 4.1.2 MCFG Table Description Note 2
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/pci/mmconfig-shared.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
>> index 4b3efaa82ab7..e4594b181ebf 100644
>> --- a/arch/x86/pci/mmconfig-shared.c
>> +++ b/arch/x86/pci/mmconfig-shared.c
>> @@ -570,9 +570,13 @@ static void __init pci_mmcfg_reject_broken(int early)
>>   
>>   	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
>>   		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
>> -			pr_info(PREFIX "not using MMCONFIG\n");
>> -			free_all_mmcfg();
>> -			return;
>> +			if (dmi_get_bios_year() >= 2021) {
>> +				pr_info(PREFIX "MMCONFIG wasn't reserved by ACPI or EFI\n");
> 
> I think this leads to using the MMCONFIG area without reserving it
> anywhere, so we may end up assigning that space to something else,
> which won't work, i.e., the problem described here:
> https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=5cef3014e02d
> 
>> +			} else {
>> +				pr_info(PREFIX "not using MMCONFIG\n");
>> +				free_all_mmcfg();
>> +				return;
>> +			}
>>   		}
>>   	}
>>   }
>> -- 
>> 2.34.1
>>


