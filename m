Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DC57050BB
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 16:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbjEPO34 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbjEPO3t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 10:29:49 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8659136;
        Tue, 16 May 2023 07:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRdl6NSp8RhTvxJj5IFUNBCHASrwMdRiKaF2b6ItqCq4XreGG2AU2ImwFsKpXRI6nSWuBgZ/0qt2B3WP59dstN8l0tvvB4FacWkccWFMVT3VvSfLmzWk2X2Dhymm9bQvcandsTk7SwR8owl41LpBV7pFtvezmipqt7fqeJkeZaCTMVoYbnCn63d7CzOht92BhrWFSU+QI99HENkrJUQsIvE/xt+mTRZJTf0KQREfXs7xkEQxdJSmSpq/msBQCj6apAqpoGa4pwCU7snMK4sjAsODnbymz+svrm2qB6pkIZOtFwJTQrCM0R1MH2fO3h1MITcSZtK9QturU9a4+w5ifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVkofsC11qNzShDSX9U2vzfme5LGPMwkV69LJTaR2ik=;
 b=nSLwausrQ3l3LdFweTcoPJeqdyYMzXexkPBlmCDk8CE5WCAyLUYlMX6lFGilApnJiF2P/9E0twTa3Sx0P9gO+Oa7vmP84RZimpGLUjpRDrYUuU8/vMj9ejB5/Y5rmpXXsVcul6Fpc43C1vmcRUx0ce3rJGKWYA0Skc9Vw3qE6JgSrMM+CGCNghbRAH98j9aOIPA42RYDOPyaTaBCMRH1898pVa6oA50MePu3w3pf9VE3OYMRt4JGzsH6tJYkoVSXsVDywgSLBkMrsvTFYrZgoYPeEnDxnR7+BGu7vLeBm74vkBHRx8Uqp63wuoQ+sSoE2NeSkyEULbVYtrStckO8qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVkofsC11qNzShDSX9U2vzfme5LGPMwkV69LJTaR2ik=;
 b=HIYOo1YTF1P3k+77SiUjk277NmaVTkkCR5LNgTyxfUXqw3kDLb1xSfArERtxngaeXekVgqMqwyIR14svmu5FAbVaH3mmXAGWiulNPF3nvF+NbqnvybdV/iRIO3zNn4liGYp4BYX3iTg80lKoYi+EP9oCC4oBkZGH0rBipGVSPFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 14:29:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3f45:358e:abba:24f5%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 14:29:43 +0000
Message-ID: <f0417d28-0c1a-f46e-9cbd-f20f2ac1e9f9@amd.com>
Date:   Tue, 16 May 2023 09:29:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Content-Language: en-US
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
 <20230516055918.GS66750@black.fi.intel.com>
From:   "Limonciello, Mario" <mlimonci@amd.com>
In-Reply-To: <20230516055918.GS66750@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d14be0-c7a3-46dc-4665-08db5619fd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9c0M5S0QFVWo3Ad7Slk20QqjvJVvDC0PhLnyr0xaAUk0lYQseVLBuDaowIZ4sg8S2sn54NOG/tQ17yW1+b5+hx6fAL12x2A5ku8BEUZZm0jzJpx3ktlHdG88c1uFTPdcdtVQMc+PKONk06Imo7KPjCzCrY9KAhBzwSKdR2dtAtDnT/y9aDA8jrrzx37OP77qjgyP8wdZQIxA0FfllLGA/r3oOZ4y847ps8V2GXu1B+gPSTn90s9gLLKWTB6XBjcyINUtrfN8hk9g1DB2yWye5I68ylc9QNpYmjmgnDELbyrqn3N3529M2Y/XyvLdBsfZUZIYNTWzSbGJJJTspTt18P5b7VlNkoNkgMh/uK+MSVb395ov2l8h679uNakGd1NjOtLXFj5Gx1SbKCfnqCJq0FkU6FJKp5yM3UnA4LynGm31l2T//C/1JQQ/EcU/Jf/jOliwVe6djcrENq/dOpKM4MVSPvk+u6wr1TXe2fo/TtZu9Yi5n4tTCGsno6CNmUghPBTQMS68R3TR+/Fzg3m9U0wGR7nQCAfrOQLjQ3DzRljp12+Ai64LZfKuWTW688GizrBK8uYX8TRq4GK10SSzYY0+k4x6pTpXFSOQjZTP/8nFloKjLyJNIB0sClCo8bN6mTezGk73sHXQC6uyeIUqOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(478600001)(110136005)(54906003)(8936002)(8676002)(5660300002)(2906002)(36756003)(31696002)(66556008)(66946007)(66476007)(4326008)(6636002)(316002)(38100700002)(41300700001)(6506007)(6512007)(26005)(53546011)(186003)(31686004)(66574015)(966005)(2616005)(83380400001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGp3eWZKcVlhYnF2ZFZqYWV4Y0p3OCtNaWNERk5tTktKNEliWTNBdUtIeUx2?=
 =?utf-8?B?UVNzbU1KcEdwWm81SjRvaUVQNW1TaG4zb0Z6RXR1ZGpMOGtQQVVoamxzUnN4?=
 =?utf-8?B?NU9HdW9JazdnYm1qL3JURndudTJLOGptTGptSFdhY0xXVCtWRG16QWhlT09t?=
 =?utf-8?B?UG9YQWUrUSsxbnpxMjJvZ2lGUkM5QXNGb0xuTXhHU0lQRWZoVjZIMEJJSDRL?=
 =?utf-8?B?ZzlSdUN6VjI1VjUxOGF1cmxoSUdtMW9MeEN0S2x1d01KTjQ3Z1JMNnZSMkMz?=
 =?utf-8?B?NzdwSGd0T2wxa09zVW1jWW1FbmVYK2s5LzVldzdZNGFYUU9aWGZ6eTNpbUkw?=
 =?utf-8?B?bGxiMTZ1bkR2Qm5HYXJHT0p6eXNuK0RoUDZ0bXgxcFVFa2tLaFdKK0tEVzZI?=
 =?utf-8?B?cGJSZ0F6Y0crOCtEaHpGTkJwT1JtaUlYT3kwdFk5TXlEVUtWUHZ1R0pXcnp5?=
 =?utf-8?B?RjNsd0dkREQzSWh4QmE2Vk9sQXZmV3JhcS9MZWsvUjZoeWVHOTNxUDN2Y0dZ?=
 =?utf-8?B?enVDZkY3aWpOVFMxSG1QaEcwS3M0QS81WUFKdEw2NENubU1CRkNUUTdBZHg1?=
 =?utf-8?B?b1BrRGZ6OE1uN2UyL2w0RXdtY3NxTVVIRklRQlZqQjlGN2FVWlJoNXkxSnNp?=
 =?utf-8?B?MUFmcllRR0tZTmFobnhqYTA0WGd3RmY1RlNwYjNITTZOMVR1VkkwNWx1MDds?=
 =?utf-8?B?SjcvbitMU2FLYWxNNE45cjRuc0ZwQlRYNkExQXI1TkloanRCdXBCUEN1aVpn?=
 =?utf-8?B?WFJYY0M4Qmw1WkZjSDRFNUxHcDl5WGlpdC91R0F1Sm1ra1RPYnh4VUdzRzgv?=
 =?utf-8?B?TmFEQ1VvbXU0aXgreDFDY25GM1hneWRMdFdWdUV3L1NETCtuWW9yWXFSdUZv?=
 =?utf-8?B?dzB6V1pkVEVuZ3IwbGRrb1RDMStrbk5sOUtpV0RrS21oYVJHYk5ja3NCcWVp?=
 =?utf-8?B?aW1jREdDRXBuWEUxRTQzS3lCQlg5cXRrbTVKVkZpOTlHYytEM1NNSVlaa0lZ?=
 =?utf-8?B?Q1M5L1VrRUVuQ0dPcXhrYXpkd1JJSmJ3RzJKd0xjUEY0UTJtRmxZQXo0YnhM?=
 =?utf-8?B?RDBIeERLQlMyZUxrMlY1RVo0K3kxcDVRUC81Q3I4ZnpuOE5oTnhTTWI1WnJv?=
 =?utf-8?B?OG9FN1Ywb0tCSFhnQmRmUEF6Y2EzYkhTeGUzSThwd3M2c0ZrTUdiNlFicjR4?=
 =?utf-8?B?WnNDbURsQkgvTTZLaXdjWWh6TW5acFVsUlJsdS9yd1BoMVM5eEpJU2RXaXl2?=
 =?utf-8?B?VC91S1BMR2FvVWErcU1SSmtXSlMzZjFBRzM4YnVDbllLODlhTUNaTStvM0dP?=
 =?utf-8?B?WTVRQUdVbEhZOFcrcjM2cHhHOWFlNDNpRUo1Nm1WdlNVWGNSMUFQajRXbVpJ?=
 =?utf-8?B?RFYzSXk4S012S1gyQzVnMTZkV2xNQTNIeCtLNkxqVXZLY1QrZmc2TFo0S1ZV?=
 =?utf-8?B?MjdyeWl6cHAzV0NDWndrd2huUVV3N3psMHdDUVpsbVZXdWZmakQ5bTRBQ0dZ?=
 =?utf-8?B?aGEweDBNMkUrWjFEV2VDVEdkR21Sa21TYUVEVk5HL3hnMXpHTkJRTXlXRUJC?=
 =?utf-8?B?bEZHWU5pZVdWVFJxMERKQ3BYcXA4em1FOUpkNm84SnltWmRnQUI1c2Y5RDVL?=
 =?utf-8?B?MDZjV1BIc1NkM210cC9lN3RTK1NlN01rVi9FZlF6NHZUeWczYURWRDlnR3VZ?=
 =?utf-8?B?SUdncTFQRHdsdkJiV2sremphTkdZVm03SE0rYVUxWVVGL210Q3RPbUxMR2Ex?=
 =?utf-8?B?am8wQ0tXRWhidnFWRm5kUWMrbTh5MDZyM3dtNDh2Z0NaUG1jOXg4bTVPUTBp?=
 =?utf-8?B?dS82dmowZzdQZEt2Q0JablVKSUpwS1JId1l5bGlMcGZkZi9GWXdBMi9zRE01?=
 =?utf-8?B?Uy9CbTJxTnRjZERJbWxrUXhteDdKZm9wUXNrcnZ5QUJpVUpJZkxmMk4zbFg2?=
 =?utf-8?B?TVp5ZTluTjFXSmsrUWNwKy9IeUtiK0pLUU5zUGRVMVJYb1BzTUc2KzVXaHhW?=
 =?utf-8?B?RWd5UGsrZ21RTmtweGdyTEVuVnh1VTBaZnc2amMxSFpUdUsyamYvdVJESy9D?=
 =?utf-8?B?emNsUkdIMG90ZUJwUnFTZjVJcnk1c2ZVUzhXYWpKakQvTG01SWN6bUdSN2sw?=
 =?utf-8?Q?zcWAHwRpRhxuAyV5p4Jk/n2Hm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d14be0-c7a3-46dc-4665-08db5619fd7c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 14:29:43.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1UnaKsBZ3dcekcHQXG181vjN9aLFRHvCrAfr3lOm4+04uHC0/Y4g1e0wgc6d/9dzQPy2+tUZxCI9MKwGyHbRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/16/2023 12:59 AM, Mika Westerberg wrote:

> +Rafael
>
> Hi Mario,
>
> On Mon, May 15, 2023 at 06:15:15PM -0500, Mario Limonciello wrote:
>> Using an XHCI device to wakeup the system from s2idle fails when
>> that XHCI device is connected to a USB-C port for an AMD USB4
>> router.
>>
>> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
>> suspend") all root port go into D3 during s2idle.
>> When the root ports are in D3 over s2idle it's not possible for the
>> platform firmware to properly identify the wakeup source.
>>
>> As a user presses a key on a keyboard the APU will exit
>> hardware sleep, but no wake source will be active so the kernel will
>> let the APU enter back into a hardware sleep state.
>>
>> Here is an example of that sequence of events.  The USB keyboard was
>> pressed after 11.9 seconds, and then a GPIO was triggered after
>> another 12 seconds.
>> ```
>> PM: suspend-to-idle
>> ACPI: EC: ACPI EC GPE status set
>> ACPI: PM: Rearming ACPI SCI for wakeup
>> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
>> Timekeeping suspended for 11.985 seconds
>> PM: Triggering wakeup from IRQ 9
>> ACPI: EC: ACPI EC GPE status set
>> ACPI: EC: ACPI EC GPE dispatched
>> ACPI: EC: ACPI EC work flushed
>> ACPI: EC: ACPI EC work flushed
>> ACPI: PM: Rearming ACPI SCI for wakeup
>> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
>> PM: Triggering wakeup from IRQ 9
>> ACPI: EC: ACPI EC GPE status set
>> ACPI: PM: Rearming ACPI SCI for wakeup
>> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
>> Timekeeping suspended for 12.916 seconds
>> PM: Triggering wakeup from IRQ 9
>> PM: Triggering wakeup from IRQ 7
>> ACPI: EC: ACPI EC GPE status set
>> ACPI: EC: ACPI EC GPE dispatched
>> ACPI: EC: ACPI EC work flushed
>> ACPI: PM: Wakeup after ACPI Notify sync
>> PM: resume from suspend-to-idle
>> ```
>>
>> If the root ports are in D0 during s2idle, then the wake source is
>> properly identified and an IRQ is active for the root port, waking
>> the system up.
>>
>> Here is the same sequence with root ports in D0.  The USB keyboard
>> was pressed after 11 seconds.
>> ```
>> PM: suspend-to-idle
>> ACPI: EC: ACPI EC GPE status set
>> ACPI: PM: Rearming ACPI SCI for wakeup
>> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
>> Timekeeping suspended for 11.138 seconds
>> PM: Triggering wakeup from IRQ 9
>> ACPI: PM: ACPI non-EC GPE wakeup
>> PM: resume from suspend-to-idle
>> PM: Triggering wakeup from IRQ 40
>> ```
>>
>> Comparing registers between Linux and Windows 11 this behavior to put root
>> ports into D3 at suspend is unique to Linux. Windows does not put the
>> root ports into D3 over Modern Standby.
> Are you sure this is the case? Leaving the root port in D0 would mean
> its power resource is left on and that would leave the whole USB4 domain
> on consuming quite a lot of power.

Right - I had the same thought, but at least for AMD after the hardware 
enters into s2idle
the platform does some internal management of power domains.

> The root ports involved are supposed
> to support PME from the D3hot/cold (this is what they advertise in their
> config spaces) which should allow the OS to move the port into low power
> states. Of course the PME from D3cold in general needs some ACPI support
> (typically a GPE) in the BIOS.

AFAICT the actual issue is entirely a wakeup platform firmware 
sequencing issue
while in a hardware sleep state and not PMEs.

It's only exposed by putting the root ports into D3 over s2idle.

As an experiment on an unpatched kernel if I avoid letting amd-pmc bind 
then the
hardware will never enter a hardware sleep state over Linux s2idle and 
this issue
doesn't occur.

That shows that PMEs *do* work from D3cold.

With all of this I have to wonder if the Windows behavior of what to do 
with the root
ports is tied to the uPEP requirements specified in the firmware.

Linux doesn't do any enforcement or adjustments from what uPEP indicates.

The uPEP constraints for the root port in question in an affected AMD 
system has:

                     Package (0x04)
                     {
                         Zero,
                         "\\_SB.PCI0.GP19",
                         Zero,
                         Zero
                     },

AMD's parsing is through 'lpi_device_get_constraints_amd' so that 
structure shows
as not enabled and doesn't specify any D-state requirements.

What do they specify for Intel on a matching root port?

>> As this policy change to put root ports into D3 if they're manufactured
>> after 2015 was originally introduced for Intel systems narrow it down to
>> only apply there.
>>
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pci/pci.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 5ede93222bc1..7d1b078b8d40 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3010,12 +3010,17 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>   		if (dmi_check_system(bridge_d3_blacklist))
>>   			return false;
>>   
>> +#ifdef CONFIG_X86
>>   		/*
>> -		 * It should be safe to put PCIe ports from 2015 or newer
>> -		 * to D3.
>> +		 * It should be safe to put PCIe ports from Intel systems
>> +		 * from 2015 or newer to D3.
>> +		 * Windows 11 does not do this over Modern Standby and this is
>> +		 * known to cause problems with s2idle on some AMD systems.
>>   		 */
>> -		if (dmi_get_bios_year() >= 2015)
>> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
> Can't we then check here AMD case instead? Then generic case would be to
> support according what the port announces.
Right; that was my original patch, but given the Windows behavior I 
figured it was better

to discuss if the original patch was actually correct or not.

