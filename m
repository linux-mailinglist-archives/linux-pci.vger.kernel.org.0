Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E697837F8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 04:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjHVCcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 22:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjHVCcx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 22:32:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C0DB;
        Mon, 21 Aug 2023 19:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUhIu/QHJ7hGSpNR/MldPBCSjeXsUyOWzH6RCKyo9ahtJW3imq0bstJpZ5kwK2R88h1FZlCWN2C/rQQ5z2Izavr9bdDlxnBqMasXvqqJozfKoMiV8kgcVvxJodats8uUjU5ur/nd70NQyn7oClu2e9wIuPVHuuZi2JegQRk3wneWvUb6h+sRBGGF/6QUQlbw6WGQWROcG2sN6j9+DdTOQqtIz5phrc/6YrVzRNzxXP8zm9x/BXclf68Zef8mbhyH3uSg/pn62OW3mU9uxKcVZhhpxAG0everzK//mPUmPHjvjOZKeroaD56te/kQbdj/oeO7zYMUlWb2yiR2jcVeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbSUviRNAB0voKPsYcG66fGJerrolRy/54KPYtasvkw=;
 b=HqUuyw8+ZeoAOBxjalVRB+1GrUuiUOCAw/XyBXokguAZDZl/L2R+gfwF1gopezc7dYwfdmMOvLyzQlr2P4FeigOPYnnz80i3aJ4reqQJpzHB/KYp5y+I7tl5aVNFL8Bjg56KD5Hs9yQPFsp+sjl7TosHsk6A9oBs+FoD6HXRzjZTXWbcDohaB2iPDzu+Cghi1xzGxcrNfmTzOVWcrju2a/6a7j127OR+QjwM6Xwn3M2sdi0joFhRq8ZuJZKVK+eDqL3mcgZOxlINFQVjPpnw4QVxC/yUKQz7cqGX5DtR4nlVxQVYbaFJE4Bd8HXHMk0mtSGnNkfZDAg6n53/q4gtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbSUviRNAB0voKPsYcG66fGJerrolRy/54KPYtasvkw=;
 b=jucnZ3PovQrjL/r/R6DYOiJ1bXLww5TdzMpEeGqkZBdLb1EKuR3X97fN7wDsIzsW8z+n3AC4VtXjSHWXHh4gamcn5x2ki69ejOEhsAwuGGBIcCLhsvQUSg+ucMATWpMj3DQHWeUdK+BJXRMHAjPUSoPHANy+vVwzXjsVqguODWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 02:32:47 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 02:32:47 +0000
Message-ID: <ef25fbe1-28fe-49d7-a171-4bf2ac95a056@amd.com>
Date:   Mon, 21 Aug 2023 21:32:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14.a 1/1] PCI: Only put Intel PCIe ports >= 2015 into D3
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        stable@vger.kernel.org
References: <20230821224207.GA369432@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230821224207.GA369432@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:806:24::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: c0704689-40e9-4de0-49fb-08dba2b8125a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jdALVq8b/ardWzNLMCUHB0bYIne0xtIzFrpv+W5wR94uLJp1ilvDLX8D4fIwybrE0dsoU4255VZwuGB74RskJeybxmv1ItlpU+pUkDZQ4l0gK4oflAfUog/WxfJ4PbS+YfmqDQrxVpBXbA77XJ50RElA1ixvGkY2ue62Awvcbjbds4FdP510kBEuGBcLU3NxnQlrhZvtRGtWu9Njdf+bEbhfGfaungHNE5SxtTdJIcKt2XzBf5DKH82Xk/UmiwP8uP3TlqwKMEsbIsKGBnQv5vBYk6Fw9vr9eJp1nOWH7VpAvuSQiGHRASrOTFtti4CYkaZ3ZrWexQ4QThDQv3BkyT9OCdE5bIM0VpLv7k2Tqkmy9bNclFHwEgoyhBNDkh87clHgfpQLw9aCBkMoBndzW5D1acTdkZR1ooY3p7qPvvS+oxffWTaSqrGob7L/6cHAoD3AL2d5Jp9ObUas43ncimUtbRW7StIOHAvsToQrBii3a99H5zFQy7DB8AI8JWZkI2zA/SyxCS2gqzvfxXBVvyAqNqjqC7RXEHMDz/zRlz0OYYY+zJK7w9Af/8vU3h+AwQde0qceH5Kdz6tWfTUCAUxqvFRNGv7uW///s4x0NCGIPMgMJPSO3bq/7dqHCtKj91BNRXLn3SbQ8+1QpoihtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(376002)(346002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(966005)(478600001)(6666004)(38100700002)(53546011)(45080400002)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2MweFFSSXJuSjRMemtGSU9jcWg2RUxZSUFvaHI5cnFxMG1sc0toakxRVDd3?=
 =?utf-8?B?ZW05dGVBL1NEb3VoKzRXclVCTXpxdnpHTjU4WjJsaUpPVUY0Q1BzVTN0ZVk1?=
 =?utf-8?B?UmRyZ2RmdVlzRzJ2cHZaUmVQcjE2YlRQaUkrUm5YcnBlanc3MjI0MDcwTmR0?=
 =?utf-8?B?NWVyamFWVm5VcTIybVg5Uk5DVHkrOHZ3czFudDlaQjdaRUFSeU5PZFBWRnIy?=
 =?utf-8?B?YmF5TnByT1NsRGpyalBDM0Y5anJRK01iMEsrcU1oNGw4VWVSY1lKclg0OFB3?=
 =?utf-8?B?d0xaK1ZkblFaWHY3cFVQODRJN0t5MUpCdXEwcFBZUGY0czY0N2xYSlg0SVBj?=
 =?utf-8?B?T3J4UzA5RzFWcU9FOVp1Tk5kWlJ3ckN2Y2VRWSthajNZTTVmV3QxUjNteG1N?=
 =?utf-8?B?TW5BdWJ1NXJIKzJtZ1NtVVZSYXNkN0FzN0t4SytUbUE2K1JEaHZuUHJGM2lM?=
 =?utf-8?B?WWxGVHMyWkJweTV0aysxc1pqeDJJVnk3MHBYdk9BbHBteTJiUmEwRVZ1S2Vx?=
 =?utf-8?B?ZEZnclIxWXM5bjZjdTNiZ2N0NE9pdjdpbXpzbE5Oc0w0Rm1VNk83cVNyV1BQ?=
 =?utf-8?B?YTg0elY1a0MwUTBnUzQ1NEJEd2xTMktYS1NsUFprc1l4Z0FrbEFzbXBoTWF2?=
 =?utf-8?B?UkVlakl0ZGdrR094em9SY01QL2M0R0tiSmZHUTBRWGxKNi9kUVY4K3I0OTJq?=
 =?utf-8?B?cTlJMWJRdmNRa2FqSnRSR3Y4elBDcnpjczk3NlNyaUNVZ1Y3OGJnYUxhWFRq?=
 =?utf-8?B?MU5lWWpmZ0xlb3grd1NkZ0c5ZXBkanBzTld3Nm9vLzQxVytXQnJ5cGtFSThN?=
 =?utf-8?B?WlE1LzFxaTNwOVh1UlduUlpHNGY1OSttaHdQenV5NnpXNXAzODl0bTJqd3Fp?=
 =?utf-8?B?WGxzalhYYXdKNWZoWlh3OUhYTW5NOGVVUUg1Yk52ckdVQlFPYXhodGUrZ3BI?=
 =?utf-8?B?WHNFNzhSNy9NMEQyaWtybEd2d3BCTStRQThJZjVncDUyTUlOQkpoNEM1Vzd5?=
 =?utf-8?B?bXozdHQ3Y0prMG9zS1IrTEc1dUFUNjJ4eW9zSktXVkZSSitLTWNpdG56dno3?=
 =?utf-8?B?Q2lvQWNEdDhkSmJheG9ZV2hYOUdMVHdVemNUZHQ2dDhxWm90cmQ2LzZlTGNC?=
 =?utf-8?B?dGxLZWhHZ3Q5WVVNUEU3Wkk0SmQ4SGpJTFZVZWhaSTN0aGVNKzhyU3ZBbk1o?=
 =?utf-8?B?a3FEREpzT2l5MGpveE9xNFR4WGlDL1lqMGhTVEVVNldZT2dWWGtoTlg0NXFn?=
 =?utf-8?B?WHViVDdBMHFndXVhOXVDZ1hPRk1STm1RZHlpT0l0QVh2bFJGOHFDanErQmxF?=
 =?utf-8?B?SjJkV3pVNm9vYm9KUDlMTzlWQ0Q5c3QyWStFUGUzelpGU3U3S1pTN3lkeHBw?=
 =?utf-8?B?cjFQcXhGRTcvOFovM3NaOTc1MkhqZ0VIZjlHekJLR1JiMFRkN3YxWExRY0NZ?=
 =?utf-8?B?ME5ieGl5N0NOTENYYTE1M3M2L2ZlQUxRMU84NkFnalZDOEVYZkNsOC83cDVV?=
 =?utf-8?B?UkI5L0NGY1ZnYmhpVXdvSElVVXVPWFpTRUgwMyt5ZU9IUTl3ZGpZWnd1R2s5?=
 =?utf-8?B?dEdOR04vb2VzYUkyV2doQXlMZXdkTnhJWkxBMXlhaGVkckVJQnUrMFFXaVNS?=
 =?utf-8?B?d0JQZlRDanNHRkZDekpxaFoweFhNMnJOd1R1bXhRU1hJUkNUODlaelVTYW9w?=
 =?utf-8?B?aDVFTmU4SmJ4c1Yydk9WRVAxL1pvSTVtdDdTSmRRWWFoajl0ZEpxdlpZYlRS?=
 =?utf-8?B?WFkxSXpoRVdqWnVYODI3U0c2VCtMMUoxYXZmR05EaVpLcXNkUUVZSytoT2Jq?=
 =?utf-8?B?ZXQzWTc0UDI5aFA4WElMblJJSEh2VnY0ZzNrMUduV2trTjYzYkV3aVFIU3Nm?=
 =?utf-8?B?VWQ4d2hSZFYwS1pVTFlUK3NuZFpnREVZb2h2cDdnQkdsMnhTQVZwR1RNMWNZ?=
 =?utf-8?B?WVVyck12bmtLeWltUlY3MVV4TEVoRjk4ZTN6dnEyMFhkK2JLdDlnMGF2a3J3?=
 =?utf-8?B?VkVQN3BZRjR0WnJNdjBsUEo0eGRZY2IvNHliV3pDOVMzREs4TG13MkE5T1hN?=
 =?utf-8?B?bnZyRkwrRVB6WGovWXNlMjdyNjNCMVVpN1lZNGh3QVdCZldaYythQ24wRnlw?=
 =?utf-8?Q?oZTgcNvbTmr3OgQmjdQYX+kqG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0704689-40e9-4de0-49fb-08dba2b8125a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 02:32:47.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YapMJN2cSjH1vmku5+QUH4+11IjcQMaDkOhOeZ5IVwmjB4jpREXMt9826N3NhbH6LY88I7p9V8c7ySqB1GhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/21/2023 5:42 PM, Bjorn Helgaas wrote:
> On Fri, Aug 18, 2023 at 02:39:32PM -0500, Mario Limonciello wrote:
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>> from modern machines (>=2015) are allowed to be put into D3.
>>
>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>> from suspend. This is because the PCIe root port has been put
>> into D3 and AMD's platform can't handle USB devices waking in this
>> case.
>>
>> This behavior is only reported on Linux. Comparing the behavior
>> on Windows and Linux, Windows doesn't put the root ports into D3.
>>
>> To fix the issue without regressing existing Intel systems,
>> limit the >=2015 check to only apply to Intel PCIe ports.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> In v14 this series has been split into 3 parts.
>>   part A: Immediate fix for AMD issue.
>>   part B: LPS0 export improvements
>>   part C: Long term solution for all vendors
>> v13->v14:
>>   * Reword the comment
>>   * add tag
>> v12->v13:
>>   * New patch
>> ---
>>   drivers/pci/pci.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 60230da957e0c..bfdad2eb36d13 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3037,10 +3037,15 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   			return false;
>>   
>>   		/*
>> -		 * It should be safe to put PCIe ports from 2015 or newer
>> -		 * to D3.
>> +		 * Allow Intel PCIe ports from 2015 onward to go into D3 to
>> +		 * achieve additional energy conservation on some platforms.
>> +		 *
>> +		 * This is only set for Intel PCIe ports as it causes problems
>> +		 * on both AMD Rembrandt and Phoenix platforms where USB keyboards
>> +		 * can not be used to wake the system from suspend.
>>   		 */
>> -		if (dmi_get_bios_year() >= 2015)
>> +		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
>> +		    dmi_get_bios_year() >= 2015)
>>   			return true;
> 
> Hmm.  I'm really not a fan of checks like this that aren't connected
> to an actual property of the platform.  The Intel Vendor ID tells us
> nothing about what the actual problem is, which makes it really hard
> to maintain in the future.  It's also very AMD- and Intel-centric,
> when this code is ostensibly arch-agnostic, so this potentially
> regresses ARM64, RISC-V, powerpc, etc.
> 
> It's bad enough that we check for 2015.  A BIOS security update to a
> 2014 platform will break things, even though the update has nothing to
> do with D3.  We're stuck with that one, and it's old enough that maybe
> it won't bite us any more, but I hate to add more.

I don't see this change as adding any more checks.
It's correcting what should have been a more narrow check when that one 
was introduced.

There was no spec backing the 2015 date, it was just "hardware works 
with this and it's needed".

> 
> The list of conditions in pci_bridge_d3_possible() is a pretty good
> clue that we don't really know what we're doing, and all we can do is
> find configurations that happen to work.
> 

I see this function as stemming from three high level desires that 
intersect.

1) Make hardware not originally designated for the PC ecosystem work.
Macs fall in this camp.  They don't always adhere to the same "firmware 
norms" as UEFI PCs do.  They don't run Microsoft's certifications, and 
thus they don't always work the same.

2) Make hardware compatible to the the ACPI and PCI specs where possible.

3) Make hardware compatible with Windows behavior.

In a strict world <2> would be the only one that was followed and 
everything else would be relegated to quirks or sub-drivers that made 
decisions, but we are where we are.

I'm not saying it's a bad thing that all 3 goals overlap.
If not for the changes that were introduced into this function for Mac 
compatibility I don't think we would Thunderbolt/USB4 where it is today.

> I don't have any better suggestions, other than that this should be
> described somehow via ACPI (and not in vendor-specific stuff like
> PNP0D80).
> 
> Bjorn

The problem is the ACPI spec doesn't say what OSPM should do when 
something isn't power manageable by ACPI.  Can you really argue it should?

Even if we DID manage to get something added to the spec how does that 
help everything already on the marketplace that's broken?

If we can't fix the check to be more narrow the only options I see left:

0) Do nothing.

Document somewhere that if you're on AMD and care about wake from 
keyboard that you need pcie_port_pm=off.  I really don't think this is a 
good idea.  Here's why:

Completely separate from this wake from USB issue I know of another 
issue where some PHX BIOS versions HANG the system during resume because 
of root port being in D3.

It's fixed in newer PHX BIOS versions, but if you end up with an OEM 
system that happened to launch with one of these you're in a very bad 
place.  I haven't mentioned it because I've not seen an OEM system with 
this yet.

If we "do nothing" the only way to solve those will be to grow the DMI 
avoid list if any of these come up.

1) Hardcode all the Intel root ports that need D3 into a quirk list.

I don't know how big this list is, but I assume it's massive and doesn't 
scale unless the constraints stuff works for Intel to opt in the newer
things.

2) Hardcode quirks for all the affected AMD PCI root ports to avoid D3.

It's 4 of them for the 2022-2023 platforms.
It will probably be another 2 more for 2024 ones, and then another 2 
more for 2025 ones.
Maybe by 2025 the affected root port can handle D3 and let USB wake it 
up?  I don't know.

3) Move the quirk somewhere that AMD can maintain specifically for this 
case outside of drivers/pci.

I did prototype it being put into drivers/platform/x86/amd/pmc.c or 
drivers/platform/x86/amd/pmc_quirks.c instead as part of the suspend 
callbacks or LPS0 callbacks.

This works and can scale as that driver at a minimum gets new IDs added 
for new platforms.  However it makes all this logic much more convoluted 
and harder for anyone to follow.
