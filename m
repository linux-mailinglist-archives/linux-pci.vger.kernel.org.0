Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D8277E206
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 14:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbjHPM6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 08:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbjHPM6F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 08:58:05 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97351FF3;
        Wed, 16 Aug 2023 05:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIoc0PSvokuXE6EgScDI+lyKZ4+OFWgSLV3aznnQkQwiK/BcGKBDeKqdHYBlZdRNUmwQR66EUt8oYhREN0yoRz2HsaGsW+pQE2b1hSpdwZicMg+9FmPV0cVO3t88mIxKGmhITBFcx8U2v4GgBwkiBUG/hSl2egqDN8+aehUSKPZxiCnNyIc8ri3gwaunk+z0otStyc+1pcnYD423ZuFaiwV1bOErTwSGOrZK1dHSZBPvs14TStcuIgANV41ktD4ZnlOd0VRCdqtJxzKVBkhy+6CiUc2Ru2DLq48QIJlySaHyCjhKLlQO1HqNO2fOsRtQIZPqkA4sxSovo18trA8ZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJP7VGp45PJWxcukbyrXseSFCXizjzXowRmBtOMosCI=;
 b=TRmHuHZQ4an/zTHliF8Xp+ks6uLca1QuCbkAx/2Rz/Oi1n5jW8DhwJHTWq7sbZvMkYGJxT45sLRNJeaBq4MdixcRd1Whl/bw4V5OCGXWTbRhUL+9qAkc53PQksBoAyhDOeInvrctEKsWcoSuCctMpv1lbLWoFwfVQe8gnwhNXTDhH6K72XmsPHCTPkIOdh1te/mgLKemxNgQPotLhOWmm7DF/lFDkvGIV7bqHpEgIlYr3AxT5OvJ9ISLL5wV5PC1H0Nijp8zCmI+/c8fmnIxYbMt7fb9G3qloj4/iMPFDcvHwU9dZRdHbhhX3FUYumOV9CgOTCVsVEoGKkXXRtV21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJP7VGp45PJWxcukbyrXseSFCXizjzXowRmBtOMosCI=;
 b=2yCjI7HnKetKuuuKrTuaSTsEAb/SZguGWSiVYDoKVSwAFPIVYF57efRIz0T+btldMABodRjbW/4b/TWC39PlQyT4j1kRoiIWZWDvKDpvZugd1DVnGkWiXjqZjRpCZGckDgRvVd3F4d/3K2SjACUoD1Vkc0xjTtZJ8EhUBOsfj0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 12:57:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 12:57:55 +0000
Message-ID: <af8e6892-7b05-459b-8c32-858deaa923f0@amd.com>
Date:   Wed, 16 Aug 2023 07:57:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI
 target state fallback policy
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>
References: <20230815234803.GA272829@bhelgaas>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230815234803.GA272829@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0081.namprd03.prod.outlook.com
 (2603:10b6:5:333::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CO6PR12MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: f9927cec-1b5b-4866-ade2-08db9e586889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /FyCYsBKfAUQZe0a6r0ZptrnH+nQsxSk/obuI5YvWmdWImNQDeXq11BlIL055Q3hxdfQFReu8ze0nW/lOYTsx3bO3S7RZS5HOCJZBmmnR1XFv8yCCOYmn4WXDuvJNxk2vLogctpJJUYVF0OHemJg3zp6cGdNrdYo3ZBvu6GYd1iATFyw+ScFmq7HWER/63TKwEiUXYCFdU/KGYWiuDapPzcI3/3kTPNuaZAs2KNU1DMiqtZ/woYEUGXjiLdpxxifhPSaxnWY8zSW/xSxHEm1/hPJLF86Q4aQxyn0fWfgrU9gDSHJPPW67K9R3vqfJ9kw4MvxJxxj1MW9ACRRr//zBPR6gudTxlA6STPOzyZ4rBdMeSTk9yzmXqGhGBceEHP0SZ8aj5la43l8YFSOmrchksdrnV258EjL7sXC2ypbsFJZDjKaT2EIjh9bQl6sWS/UjxCrDndRrOD1UfYCv9MElMWCBh1oGKSxcrtBWuxB/1e7P9qWlBgvjhWFGNvgkI1vICe4Nh9RB2b7y7Lda849LFC6R7PpEVlGYYjO2F+EUvyvF6WZtDNhw0NqWP/c9BNDhFwlnbtqc57y7JGAT3q8R+BFrcKT/TM5KgfNco1m1NH6clPCShRRdzDSkQybaaJ6h3tnBtYyOhpqHakUIg8ift0Jq1/rONUdLk6v3LGFrPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(6916009)(66946007)(66476007)(66556008)(966005)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(45080400002)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWV1WE1vc3dSSit4MXhiZFZndGxDNHczTkZhNXNRVGl5dXlYenlVU2hKbjQv?=
 =?utf-8?B?MHdSU2krSWtJditjdVZnMGhJeXBZZ0RBR1dpVktzeFpRMk1BY1h2SzJKWGhB?=
 =?utf-8?B?NlcwZUR2MVJVeGRvQVRYZ01ndWtZbG9idXM2YzIwdVJ6aWtmc2YrUkJ4OGQ0?=
 =?utf-8?B?R2tYbjduYlVpUmJMY2RzS0c1cWRQZjAzUWNONHFRcTBmODZhTGp4Z0RWclY3?=
 =?utf-8?B?cU1KTzRrZDZZYktFclFtamQ3ZEFjcmsvOGFVUlQ0TjBZVGY3dm9ucFJQZm9w?=
 =?utf-8?B?a0pJL1QyWXpUaDJCOG4wUUM0YTg0bjYwOFhHQXdHbTdrcldKZ0pHTTI2aDAx?=
 =?utf-8?B?Q2hiZHNoWHowSWp0SmNhbFpYM0tiVE9tUmVML0pWZVh0eGtYWjNCQXpPdmFh?=
 =?utf-8?B?WTlPZSs0R3Via0l0YXZxY0k1enZPV2o2NTFvdExSVFhnSVRWSjBicXdWa3dH?=
 =?utf-8?B?VFFWd011SFE3eGlIS3dwSU9xZGt1aHdSUmZvaUY1d0RibTdzbi9QcnF6NGdY?=
 =?utf-8?B?U0xNS3FaYi9iK1lzZWpyS3R0RlVIektld3FsV0RFU0hSUnV4K2JycnFWTFhq?=
 =?utf-8?B?Rit0dWN2R1JMd0R3dE1wSkxNOFdCK3ptSnNsUDludzZvcyt2dDNWTWR6UElh?=
 =?utf-8?B?emlRb1lZaU9VTXJmR3JtRGNkaHBXek0zTU9hbnZualJZTm9iaGR6RGdhMnI4?=
 =?utf-8?B?amlXWE1VSVVDU3BRNTFqbzFCakJjaWxFTm13dXEySGFRZ0pvMFZxV2I5ZXFa?=
 =?utf-8?B?NEJJNlBJOGhUNVN6SHh6RnpOYXlyVmlWaGd1MjF6c01RenM5SVhyN0YwVkRJ?=
 =?utf-8?B?N2tuQzNRVHNwUWRwei82MDFzWndFVTVvc1N6VElPK1AvdWx2Z3ROQytHU1VV?=
 =?utf-8?B?RDhjTmowSm9QK2tGM0txT3p0NGdXVFVCbCtpVUNrckxCVjZOemtNZmtLb2Y2?=
 =?utf-8?B?N1Z6aVQxM2NadmFjTFZGblZ1MFJUaEN6NXhlK0s0YU0rSm4vaHE1bkxYVzRa?=
 =?utf-8?B?OG5RenNad0pKdlVWVG9BcG91U3Zpc09zZFpKS21MOC9VU1kveWMvdHdPOS9Z?=
 =?utf-8?B?SnRITTFyWUl2NFlQeVJUL0d4eVFiMkl3NDFlSEJGbmloRkQ0andjNWNhdVY5?=
 =?utf-8?B?WktrQkJLSmR2b2pUdUIydUtTRm1EZDhtZ0VPYU4rcVhNSmRJdU1TRDcxc0do?=
 =?utf-8?B?K2NwYlR6MHUwYm13b0xpMFRRVDg2OXkxbUFtaWp3RC8ycS9yeHVhSWduTkhn?=
 =?utf-8?B?Y0JKaWp0N2M1amJZeldMRTB6ZkpNcCt2bHNibHQrcXBoVzJoanFkRWFna21j?=
 =?utf-8?B?L09NNTNTd2FjeHlBK1JFSmtvN2w1WHpwY0Z6b2YvdHJwTXJHSGM0ZzZoK0Yr?=
 =?utf-8?B?a1loeTVjZm1Qcm1reTllTStneUVrbTdFZk9tNnZPR2pCcUVLdU9GVmlTSFg4?=
 =?utf-8?B?eG9CUTdQTTBJaXhOSW1xNjdSYzh2c1F4UlVyWUtwQTNRM3JyK2ZVa2d2QnBx?=
 =?utf-8?B?aEpPNytPaGt2c2F4K05YUitmL3pXcnZUTjhFOXNiN0FqdWlSVklkZjNmNzlx?=
 =?utf-8?B?ZFFVMjEwcnhaUXNHOVZIa3dSS1hlTWVQMUpZUzA3cnZRYTFxbURPWlVid1VJ?=
 =?utf-8?B?US9FMnlBNWZubk1BZzQxUGdaclk0TG1CMTl0NUt5RlFtRDFlSnB3eUswRUJq?=
 =?utf-8?B?ZitJc2RRYzRaQTVaUGMrQlN6ODhnZ05oZTFLcWRmUWpXRXVCdVJqK0RYTDBS?=
 =?utf-8?B?STljZW1TRzczenVVTTNna2N3Q1VSTEZvMDFpVWhQS093c1hldC9BR2dTS1Q2?=
 =?utf-8?B?OUdibWRLdCtjV3RNL09ZeG1FQXZqVThoSGpZOWZjclQ4c2owNG16am0xekx1?=
 =?utf-8?B?YkRVcEx6OEdMcWhUaGxXbERhSURscXhnSnQ4dzgvRFhkQ2ZKeFJjakY4YTI1?=
 =?utf-8?B?RkhmWXdHMlM2SExlSUFmN08zNmR6VjUwUjRRbzhYS05RdE12WU1mMWtpb2cz?=
 =?utf-8?B?Rzl0VGljaHcvUUhTT010N0wrdXFocVpqN3dReW9senhYSVFSWTFkb09IVi8z?=
 =?utf-8?B?cTV6TUNBOW1ROVlQUU9sZmZoMFpST0hlc3NkMXhCdFZBcTBiWDA4S1FicTlH?=
 =?utf-8?Q?RL+ibkEDQcIFTGuShHOhqgbv9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9927cec-1b5b-4866-ade2-08db9e586889
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:57:55.3110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: So1dgOsgtXsquNxU7fvgxsByYBu1ljorlfL1hEyoxmKB4RQPx+szA2+0EolxvpfbJKxNyjkvBOGSG20MWjaW/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/15/2023 6:48 PM, Bjorn Helgaas wrote:
> On Wed, Aug 09, 2023 at 01:54:53PM -0500, Mario Limonciello wrote:
>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
>> storing a value to the `bridge_d3` variable in the `struct pci_dev`
>> structure.
>>
>> pci_power_manageable() uses this variable to indicate a PCIe port can
>> enter D3.
>> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
>> decide whether to try to put a device into its target state for a sleep
>> cycle via pci_prepare_to_sleep().
>>
>> For devices that support D3, the target state is selected by this policy:
>> 1. If platform_pci_power_manageable():
>>     Use platform_pci_choose_state()
>> 2. If the device is armed for wakeup:
>>     Select the deepest D-state that supports a PME.
>> 3. Else:
>>     Use D3hot.
>>
>> Devices are considered power manageable by the platform when they have
>> one or more objects described in the table in section 7.3 of the ACPI 6.5
>> specification.
>>
>> When devices are not considered power manageable; specs are ambiguous as
>> to what should happen.  In this situation Windows 11 leaves PCIe
>> ports in D0 while Linux puts them into D3 due to the above mentioned
>> commit.
> 
> Why would we not use the same policy as Windows 11?

That's what I'm aiming to do with my patch series.

> 
>> In Windows systems that support Modern Standby specify hardware
>> pre-conditions for the SoC to achieve the lowest power state by device
>> constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
>> They can be marked as disabled or enabled and when enabled can specify
>> the minimum power state required for an ACPI device.
>>
>> When it is ambiguous what should happen, adjust the logic for
>> pci_target_state() to check whether a device constraint is present
>> and enabled.
>> * If power manageable by ACPI use this to get to select target state
>> * If a device constraint is present but disabled then choose D0
>> * If a device constraint is present and enabled then use it
>> * If a device constraint is not present, then continue to existing
>> logic (if marked for wakeup use deepest state that PME works)
>> * If not marked for wakeup choose D3hot
> 
> Apparently this is based on constraints from the _DSM method of a
> PNP0D80 device (and Intel x86 and AMD have different _DSM methods)?
> 
> Isn't this something that needs to be part of the ACPI spec?  
 > I don't
 > see PNP0D80 mentioned there.

So PNP0D80 is a "Windows-compatible system power management controller"
See 
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-management-namespace-objects#compatible-id-_cid

> Obviously we also have ARM64 and other
> arches now using ACPI

Let me quote a few select sections of [4] that I want to draw attention to:

"Devices that are integrated into the SoC can be power-managed through 
the Windows Power Framework (PoFx). These framework-integrated devices 
are power-managed by PoFx through a SoC-specific power engine plug-in 
(microPEP) that knows the specifics of the SoC's power and clock controls.
...
For peripheral devices that aren't integrated into the SoC, Windows uses 
ACPI Device Power Management.
...
It is possible to, and some device stacks do, use ACPI Device Power 
Management alone, or in combination with the microPEP for on-SoC device 
power management.
"

[4] 
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-power-management#device-power-management-in-windows

In Linux we call the device that supports PNP0D80 the "LPS0 device", but 
in Windows they call it uPEP.  In Windows the SOC vendor provides this 
driver and it supports the _DSM calls for the vendor.

As part of going into Modern Standby on Windows that uPEP driver 
orchestrates the state of the devices mentioned by constraints.

I'd like to think that's exactly what this patch is doing; it's giving 
the ability to select the target state for SOC specified constraints to 
the LPS0 driver.

Looking at the intertwined function calls again, I wonder if maybe it's 
better to move the constraint checking into pci_prepare_to_sleep().

That makes it explicitly clear that LPS0 constraints shouldn't be used 
for anything other than suspend rather than also having implications 
into runtime PM.

As for your comment for ARM64, I think if they use Windows uPEP 
constraints we can add an PNP0D80 compatible LPS0 driver for them too 
just the same.

 > so I'm not really comfortable with these bits
 > scrounged from Microsoft and Intel white papers.  That seems hard to
 > maintain in the future, and this is hard enough now.

Remember this all comes back to a PCI root port in the SOC being put 
into an unexpected D-state over suspend.  The device is not ACPI power 
manageable so *that behavior* is up to the OSPM and is not grounded in 
any ACPI or PCI spec.

TBH I think the Microsoft documentation is the best we're going to get 
here for this case.  To be compatible with UEFI firmware designed for 
Windows machines you need to adopt some Windows-isms.

If this was coreboot, I would tell the coreboot developers to mark this
root port as ACPI power manageable and adjust the _SxD and _SxW objects 
so that this root port couldn't get into D3.

>> Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
>> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v10->v11:
>>   * Fix kernel kernel build robot errors and various sparse warnings
>>     related to new handling of pci_power_t.
>>   * Use the new helpers introduced in previous patches
>> ---
>>   drivers/pci/pci-acpi.c | 12 ++++++++++++
>>   drivers/pci/pci.c      | 17 ++++++++++++++++-
>>   drivers/pci/pci.h      |  5 +++++
>>   3 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index b5b65cdfa3b8b..9f418ec87b6a5 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -1081,6 +1081,18 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   	return false;
>>   }
>>   
>> +/**
>> + * acpi_pci_device_constraint - return any PCI power state constraints
>> + * @dev: PCI device to check
>> + *
>> + * Returns: Any valid constraint specified by platform for a device.
>> + * Otherwise PCI_POWER_ERROR.
>> + */
>> +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
>> +{
>> +	return map_acpi_to_pci(acpi_get_lps0_constraint(&dev->dev));
>> +}
>> +
>>   static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>>   {
>>   	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 693f4ca90452b..567443726974b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>   	return acpi_pci_bridge_d3(dev);
>>   }
>>   
>> +static inline pci_power_t platform_get_constraint(struct pci_dev *dev)
>> +{
>> +	if (pci_use_mid_pm())
>> +		return PCI_POWER_ERROR;
>> +
>> +	return acpi_pci_device_constraint(dev);
>> +}
>> +
>>   /**
>>    * pci_update_current_state - Read power state of given device and cache it
>>    * @dev: PCI device to handle.
>> @@ -2685,11 +2693,13 @@ static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
>>    */
>>   static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>>   {
>> +	pci_power_t state;
>> +
>>   	if (platform_pci_power_manageable(dev)) {
>>   		/*
>>   		 * Call the platform to find the target state for the device.
>>   		 */
>> -		pci_power_t state = platform_pci_choose_state(dev);
>> +		state = platform_pci_choose_state(dev);
>>   
>>   		switch (state) {
>>   		case PCI_POWER_ERROR:
>> @@ -2715,6 +2725,11 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>>   	else if (!dev->pm_cap)
>>   		return PCI_D0;
>>   
>> +	/* if platform indicates preferred state device constraint, use it */
>> +	state = platform_get_constraint(dev);
>> +	if (state != PCI_POWER_ERROR)
>> +		return state;
>> +
>>   	if (wakeup && dev->pme_support)
>>   		return pci_get_wake_pme_state(dev);
>>   
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a4c3974340576..410fca4b88837 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
>>   int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
>>   bool acpi_pci_power_manageable(struct pci_dev *dev);
>>   bool acpi_pci_bridge_d3(struct pci_dev *dev);
>> +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev);
>>   int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
>>   pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
>>   void acpi_pci_refresh_power_state(struct pci_dev *dev);
>> @@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>   {
>>   	return false;
>>   }
>> +static inline pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
>> +{
>> +	return PCI_POWER_ERROR;
>> +}
>>   static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>   {
>>   	return -ENODEV;
>> -- 
>> 2.34.1
>>
