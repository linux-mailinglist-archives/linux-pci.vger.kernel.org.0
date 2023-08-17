Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F0A77EEB4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347507AbjHQB0p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347505AbjHQB0P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 21:26:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADD0271E;
        Wed, 16 Aug 2023 18:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSav+nyKmALliI+z3a87QQKsusIeEVrpTfd3QNvcFJI5OXhCyjyaIQsQiRvC/z5n2CK8KEKajxf8J+yfflVlM1fbaJRgHl9q/mUWOio6QopMEjpZrWKQwWf6hU7l/BsKHJr+wB4QCOS5ltnaoigUIcykXuBGkRfQKNtYf+4WYClvjt8q6aKuka6ItRHopbbVaRL7mVxvFW5fTnyUTO6DAUBWAnyh0hzrExz3F5vWU5ZWN9/kvPcj8HST3tNff9d4Dnn6aaPHyShh1kEhB+QR7+M1YuyymDa1imRoQqI6hDu7cQu0w5mxsIeJEGdZFvEv4wt42q2IIImVvK8L2j9vuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nY0L1rmaH93qvyBsrziW8lVE5+806CsCjxkP5buJPKE=;
 b=PAqCBAgk1ZyoU7ShYl84Dqt3FVLbrQQTacyONzLSq1gc6MhUFTIGiTi+AxDVDoeqE/p2g/u9k5BdiEpbIsK0AkP2HNPF4kXnO6sKFBSjXRRrEJaAxzYg9wXFgmazd/wxUu1esgCUvP/umonbUK9Gd5ub/+jUM9WxEf1OVOF1NhGuyE1r15vA69MghUbjFEA/Zt8fIOWklttw6gVOJ8SmCnle6O3pN1sY8yTaTzJ2I6/fSEnHh4i7bNoQBvNtLmDti7nJt7TGjEoZkwHWJMPGGwtOrRzX6Cos1FHeaafrmJwxqorKyupv0UxTv1T/QiJh4FrAab9ZTPc8UPN+HCmmIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nY0L1rmaH93qvyBsrziW8lVE5+806CsCjxkP5buJPKE=;
 b=h4REi2P51eGvRo54L32GU1WZGwpRySWyHIdO/ydA+K1jOaX5DDRD2ncbLs6M0A2SZQRGmuw39xLsc6ekMr3pCdjXwGAkpcJExmgFQJFe/QvNNtyUA8lb6rShxbVlMw/S8FSkXH6B1y2Hije/YtgqsHxZFYFdnoC/t8J0WdSzl5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8927.namprd12.prod.outlook.com (2603:10b6:a03:547::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 01:26:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 01:26:09 +0000
Message-ID: <6a91a3e1-61a2-4f33-ae01-ea4b5ad24ec6@amd.com>
Date:   Wed, 16 Aug 2023 20:26:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 9/9] PCI: ACPI: Use device constraints to decide PCI
 target state fallback policy
Content-Language: en-US
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
References: <20230816223831.GA291481@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230816223831.GA291481@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0094.namprd07.prod.outlook.com
 (2603:10b6:5:337::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8927:EE_
X-MS-Office365-Filtering-Correlation-Id: a20c7d5b-6c64-4c1b-3b68-08db9ec0efbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dH6cjOTUwF0qyYWRBBBRpYuRk/s9tBuq0GPTy0la9KS+22hhl2DLHdVZW1YKqx9VmQtHbxWngrNIwVZGQgGF2/FSqyrNUTLXDRnJ3ijL5oEhMxBX9CLBoRq3D16Zqfq0mJogfT9MhyzPC3zTn2WyYKN+17+TqvHkxYn3zr/94v4Jic1JnGV9Zs95N/+UNN1t5crLtKFYrjWf+WXJ0+0kCe/969Wwnd2elWFW+dyDaPyrpUOFYwKcyttkc2IckfgiAcW95AMpEVJATxF/wFiwuPL4/nHimDWb77in80eav3T+6LlvuBK1wMtcR7McXgXHD+TZq7bbwD9kVSWoWTKU/OXi2zkw/aIxH5ukS41fcHRK1eGEJE9amGm20ipV24MQqOc0v2VSNiChaXg5jm9LMHIjIYtCVCqDa9bhYdQZ7uYdAn2tbzw5B7ivmCzeVpGAUdHeFmwF1Sgq/9qOZYmET/RiyR8sydIxadzzsMyXYVAh7CrMLujGFd4oTz9F2nv6XtWxvePYW1vkb36WAx3Z7ruXOq2RFioVpw7q13nMbceede7aUNzf3WBvaNyWSlpnNsmwK62ntWcVRye9ejd2bhc2VRzpjEk8139R7SrWxPW6dZpolDagGmFZIvOY3HU8GNG/Z9ltLpiiP1fJdVefp+HphvgR7oK3F4AhG/EV0Ts=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199024)(1800799009)(186009)(316002)(54906003)(6916009)(66556008)(66946007)(66476007)(31686004)(966005)(5660300002)(41300700001)(38100700002)(4326008)(8936002)(8676002)(26005)(30864003)(2906002)(83380400001)(478600001)(45080400002)(86362001)(53546011)(6512007)(31696002)(36756003)(6506007)(6666004)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVGUHVmVkZ6UFRaRXcrWW1WZWovMGZLdkYrS1huc1krMUtVVFBLUWEvbk9q?=
 =?utf-8?B?K3NnSkJPclBjUFRtakxva09lVUNLa3hLWWI0UUxZWURxYmhOcG1hYXJWdmVx?=
 =?utf-8?B?N1ljcmpJM21ZS2dISFA1MnorZ0gvZmRsQnJlZmUzVzdQTlVrWlFRSHpIN2hT?=
 =?utf-8?B?bGNEL2xZclBrSnR1U1dGSXB4V29ENlRvOUJWV0hlS1BMS2hUOFcrSG1DNmNj?=
 =?utf-8?B?KzN5bXJvNTVtNTBENGtOVmpnaWJYR0JkazZuU3FzTkJPeHlJcmVsWkhPd1ZE?=
 =?utf-8?B?c0k3Z2VpRDVDdENsNndYaFJOWFlhWUtIUEZNQk5DcW1xQmZlSlNFVW8rcEFo?=
 =?utf-8?B?TCtXRFhuVnpTdzJzV0hWZ2xHaWFhOHRVUXhzb1lSSFlTb1VGZng1NUY1RUdL?=
 =?utf-8?B?NHpaSjRhUUZSZXBmcDF2VDZhLzEwOTlRTGZoZkN0WGpwS2pzaUJsYjNkcWZE?=
 =?utf-8?B?b2pxeUdtZUdXM3N1MGFQeDBxMkFLZmRjREdDeG5sZXUzdzEvRFJwWmRHUFdw?=
 =?utf-8?B?RDh5WkJuMjZlUStwWXBXa1lvUTVZc1pybUdQaXh1eHRwcDRuUTV1ckUrcWEr?=
 =?utf-8?B?bFM0bVBmcWZFM1dVNXRIaXk4eFlkOE5BV2c1V2JVWmJwbldpOFNUV09TYW13?=
 =?utf-8?B?bkU2NFYrSjdxSnBiSDFLMnNuMmVtMGdJL3RFQnJZaXMrOFZPWjc3UXZyZ3pu?=
 =?utf-8?B?N0h3bTJtdW5uU0YwZ1JJdENCak04VXhCbU9GSVE1SEhkUzVJaXdabGpJblZR?=
 =?utf-8?B?b2g5b1pFbnVoSWYxanhIUFVHdmRVclVnMUxHWldqbTNVaXFDTHlseDR4dzN4?=
 =?utf-8?B?ckJyYVZVN20zR08xdWdYbFI3N3FUeUcwT280Nm5lZm05QkpGVFdFTTZnQ3FU?=
 =?utf-8?B?R3BERURXTDNoM21ad2I1eEtZSkRsYzlYbENXY090dXV2UW9DM0hpZnk3WjBB?=
 =?utf-8?B?WHRnU0FLa2tkUDIzbnZIMTJQZ1pWS0dnSWZ2UDBHL1ZRZlU1VTJqUXY5ZS9G?=
 =?utf-8?B?cDRWRmhucXZ3Y1ZPYnNrWnJsc2tWM1ArckVXZnlwbjZZOFp0OEEyZEc2eVVO?=
 =?utf-8?B?L3E5cGhlM29CbDdpMkd3Vjc4RVJwTlE5VjRiNGx2SDFLWEI1ZnQ1Z3Fzc21U?=
 =?utf-8?B?NkgzTFJhaFRUMmQvMDhqWDdCZ2lFNVYwQ0RmRXdQTFgyb0xqWVpFY3UzcDhG?=
 =?utf-8?B?dVRhQ0hPZ3BSYVVxNlFBdFlWSFJvZWRlaE4yR0c1RXBSbGd1YTJsQVZuQ0k0?=
 =?utf-8?B?QVZyQnQxOUhLaG9sbno0elVIQzljZC93eEhBSGtpQmJZbmVFcHZpK0J2UFNZ?=
 =?utf-8?B?dXhJaXJON2EwUHUrdUZza2J2SG91NjUyVjN6VHNoMlBXbGpHM1hJcFhEWWc3?=
 =?utf-8?B?TE1DakJtZ0pHeUtETDlxVXBYN0pWWEZNRkdvc25LeFBTdWxPWDAzMTNtM1kx?=
 =?utf-8?B?MTAwM2x4Qi80ampad2JKdk5wOC9XT2lWTWc4aGtXcEJYREpyOVVDNlNwSEc2?=
 =?utf-8?B?SmFCWi9TRTBqKzN4cHNNWW1oSFJjcWg2N21Kdm5RODBVZFk1NERXSTFTbXY0?=
 =?utf-8?B?bDN2UCt0MlM2UitmMVhRMUQ4YVlEYVdZQmVUVmhabXFGMVVLWGFHK3RmMGpx?=
 =?utf-8?B?VGVTTVNRbXlCMVozSFdnRG5WbVB6WWIzRmVLMWtCd1FtMXNueXZLbGlvYysy?=
 =?utf-8?B?TDlLT3dST09EY1VmYVdGRXl6emZRZmtDNXo0TUEyTWJHRCtnOEc2WDJyRVpa?=
 =?utf-8?B?UTlCVGNKckU0U3JoaUsxQWJWdjRxUndHaWFEVkp0SnZybTdxV1ZIV3JpdHFk?=
 =?utf-8?B?Vm5ad0lQSWJZM0xUR2pWRzBMODhvaUNJOXU2YTBjRTl0TlZnWnVRN01zd0ZF?=
 =?utf-8?B?Z0xkM2xRZFVhVEJnVlhBOWtkM1RMekpJWHdub1JxODltWnZvbXVlR2FtQW9B?=
 =?utf-8?B?L3I1ZURZOGVVMnNNSksrQlMrc2o1ZUR5UTdsTUp0enpYMENZbkRvU2xaZFJq?=
 =?utf-8?B?NHcySm5YL2RDeE4wTVFxbWx5dXlXeGlLSisvUnh4Wi9uU0R2UjdNL2RSMXN2?=
 =?utf-8?B?L0puTlhUTTkwWC9BaHUydEltY3grT1hEd2tSRSt2c0xJSTdQUHNPMGtSd2Ri?=
 =?utf-8?Q?V/8Bl1j+5IlzHB0rfKdESZmJ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a20c7d5b-6c64-4c1b-3b68-08db9ec0efbf
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 01:26:09.8069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEwPEb9sfgrxE94cEr0YiF80axJxAwJILkKEDEZWPqi7RfJt84gFO8rVO+uV22+Kaqx5ALxyoqGxUnC8thSnsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8927
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/16/2023 5:38 PM, Bjorn Helgaas wrote:
> [I see that you just posted a v12 that doesn't touch drivers/pci at
> all.  I haven't looked at it yet, so maybe my questions/comments below
> are no longer relevant.]

I'm not married to either approach but I think that you'll like the v12 
approach better.

Let me try to answer your questions anyway though because I think 
they're still applicable for understanding of this issue.

> 
> On Wed, Aug 16, 2023 at 07:57:52AM -0500, Limonciello, Mario wrote:
>> On 8/15/2023 6:48 PM, Bjorn Helgaas wrote:
>>> On Wed, Aug 09, 2023 at 01:54:53PM -0500, Mario Limonciello wrote:
>>>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> PCIe ports from modern machines (>=2015) are allowed to be put into D3 by
>>>> storing a value to the `bridge_d3` variable in the `struct pci_dev`
>>>> structure.
>>>>
>>>> pci_power_manageable() uses this variable to indicate a PCIe port can
>>>> enter D3.
>>>> pci_pm_suspend_noirq() uses the return from pci_power_manageable() to
>>>> decide whether to try to put a device into its target state for a sleep
>>>> cycle via pci_prepare_to_sleep().
>>>>
>>>> For devices that support D3, the target state is selected by this policy:
>>>> 1. If platform_pci_power_manageable():
>>>>      Use platform_pci_choose_state()
>>>> 2. If the device is armed for wakeup:
>>>>      Select the deepest D-state that supports a PME.
>>>> 3. Else:
>>>>      Use D3hot.
>>>>
>>>> Devices are considered power manageable by the platform when they have
>>>> one or more objects described in the table in section 7.3 of the ACPI 6.5
>>>> specification.
>>>>
>>>> When devices are not considered power manageable; specs are ambiguous as
>>>> to what should happen.  In this situation Windows 11 leaves PCIe
>>>> ports in D0 while Linux puts them into D3 due to the above mentioned
>>>> commit.
>>>
>>> Why would we not use the same policy as Windows 11?
>>
>> That's what I'm aiming to do with my patch series.
> 
> OK, help me out because I think I have a hint of how this works, but
> I'm still really confused.  Here's the sort of commit log I envision
> (but I know it's all wrong, so help me out):

I was intentionally trying to leave the actual problem out of the commit 
from your earlier feedback and just put it in the cover letter.

But if it's better to keep in the commit message I'll return those details.

> 
>    Iain reported that the Lenovo Thinkpad Z13 suspends but activity on
>    plugged-in USB devices will not cause a resume.  The resume failed
>    because the Root Port leading to the USB adapter was in D3hot, and
>    ... maybe firmware can't identify the wakeup source?  I dunno?
> 

I would just say due to the platform behavior.

>    The Z13 supplies an ACPI PNP0D80 System Power Management Controller
>    with a "Get Device Constraints" _DSM method that says the Root Port
>    should not be put into a lower power state than D0 ??
> 
> [This is one thing that seems completely wrong.  The _DSM spec says
> the device must be in the specified or DEEPER D-state to achieve the
> lowest power platform idle state.  That seems backwards.]
> 

Yeah I see the confusion here and this is why it all ties back the 
policy that Linux uses for deciding if something can use D3hot or not.

The constraint is "not enabled" which means the OS shouldn't be putting 
the device it into a low power state.

Windows without ACPI and without the uPEP constraints saying what to do 
just leaves the device alone at suspend.  I believe that's why we get D0 
in Windows.

But Linux decides that anything >=2015 it should support D3hot, and 
anything that isn't ACPI power manageable should use D3hot.

We can't just rip that out because there are a number of Intel platforms 
that don't ship with Windows and rely upon this specific behavior to get 
the SoC into a low power state.


So what I do instead is look at the constraint not being enabled and use 
that to decide to return it to D0 at suspend.


>    For power-manageable devices (those with _PS0 or _PR0, per ACPI
>    r6.5, sec 7.3), platform_pci_choose_state() selects the low-power
>    state based on the device's _SxW, _SxD, and _PRW methods.
> 
>    For non-power manageable devices (those without _PS0 or _PR0), ACPI
>    doesn't help decide the low-power state.
> 
> [This confuses me too.  Even here pci_set_power_state() uses
> pci_platform_power_transition(), i.e., ACPI, but I guess this only
> uses _OFF/_ON and doesn't count as "power managed"?
> 
> Maybe that makes sense since _OFF/_ON are part of sec 7.2 ("Declaring
> a Power Resource Object", which is separate from *7.3* ("Device Power
> Management Objects") where _PR0, _PS0, _PRW, _SxD, _SxW, etc are.]
> 
>    However, extensions like the ACPI PNP0D80 System Power Management
>    Controller device can provide constraints on the allowable low-power
>    states.
> 
>    Add platform_get_constraint() so pci_target_state() can discover
>    constraints from these extensions and avoid choosing a deeper
>    low-power state than the platform allows.
> 
> [Again, this *seems* backwards to how that _DSM is documented.]
> 
>>>> In Windows systems that support Modern Standby specify hardware
>>>> pre-conditions for the SoC to achieve the lowest power state by device
>>>> constraints in a SOC specific "Power Engine Plugin" (PEP) [2] [3].
>>>> They can be marked as disabled or enabled and when enabled can specify
>>>> the minimum power state required for an ACPI device.
>>>>
>>>> When it is ambiguous what should happen, adjust the logic for
>>>> pci_target_state() to check whether a device constraint is present
>>>> and enabled.
>>>> * If power manageable by ACPI use this to get to select target state
>>>> * If a device constraint is present but disabled then choose D0
>>>> * If a device constraint is present and enabled then use it
>>>> * If a device constraint is not present, then continue to existing
>>>> logic (if marked for wakeup use deepest state that PME works)
>>>> * If not marked for wakeup choose D3hot
>>>
>>> Apparently this is based on constraints from the _DSM method of a
>>> PNP0D80 device (and Intel x86 and AMD have different _DSM methods)?
>>>
>>> Isn't this something that needs to be part of the ACPI spec?  I
>>> don't see PNP0D80 mentioned there.
>>
>> So PNP0D80 is a "Windows-compatible system power management controller"
>> See https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-management-namespace-objects#compatible-id-_cid
>>
>>> Obviously we also have ARM64 and other arches now using ACPI
>>
>> Let me quote a few select sections of [4] that I want to draw attention to:
>>
>> "Devices that are integrated into the SoC can be power-managed through the
>> Windows Power Framework (PoFx). These framework-integrated devices are
>> power-managed by PoFx through a SoC-specific power engine plug-in (microPEP)
>> that knows the specifics of the SoC's power and clock controls.
>> ...
>> For peripheral devices that aren't integrated into the SoC, Windows uses
>> ACPI Device Power Management.
>> ...
>> It is possible to, and some device stacks do, use ACPI Device Power
>> Management alone, or in combination with the microPEP for on-SoC device
>> power management.
>> "
>>
>> [4] https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/device-power-management#device-power-management-in-windows
>>
>> In Linux we call the device that supports PNP0D80 the "LPS0 device", but in
>> Windows they call it uPEP.  In Windows the SOC vendor provides this driver
>> and it supports the _DSM calls for the vendor.
>>
>> As part of going into Modern Standby on Windows that uPEP driver
>> orchestrates the state of the devices mentioned by constraints.
>>
>> I'd like to think that's exactly what this patch is doing; it's giving the
>> ability to select the target state for SOC specified constraints to the LPS0
>> driver.
>>
>> Looking at the intertwined function calls again, I wonder if maybe it's
>> better to move the constraint checking into pci_prepare_to_sleep().
>>
>> That makes it explicitly clear that LPS0 constraints shouldn't be used for
>> anything other than suspend rather than also having implications into
>> runtime PM.
>>
>> As for your comment for ARM64, I think if they use Windows uPEP constraints
>> we can add an PNP0D80 compatible LPS0 driver for them too just the same.
>>
>>> so I'm not really comfortable with these bits scrounged from
>>> Microsoft and Intel white papers.  That seems hard to maintain in
>>> the future, and this is hard enough now.
>>
>> Remember this all comes back to a PCI root port in the SOC being put
>> into an unexpected D-state over suspend.  The device is not ACPI
>> power manageable so *that behavior* is up to the OSPM and is not
>> grounded in any ACPI or PCI spec.
>>
>> TBH I think the Microsoft documentation is the best we're going to
>> get here for this case.  To be compatible with UEFI firmware
>> designed for Windows machines you need to adopt some Windows-isms.
>>
>> If this was coreboot, I would tell the coreboot developers to mark
>> this root port as ACPI power manageable and adjust the _SxD and _SxW
>> objects so that this root port couldn't get into D3.
>>
>>>> Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [1]
>>>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [2]
>>>> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [3]
> 
> This covers the Intel PNP0D80 _DSM.  But
> lpi_device_get_constraints_amd() implies that there's a similar but
> different AMD version?  Is there a published spec for the AMD _DSM?

AMD's _DSM doesn't have a public facing document today.

I'll try to get that solved, but for now referencing the Intel and 
Microsoft ones conveys the necessary message about how this stuff works.

> 
>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v10->v11:
>>>>    * Fix kernel kernel build robot errors and various sparse warnings
>>>>      related to new handling of pci_power_t.
>>>>    * Use the new helpers introduced in previous patches
>>>> ---
>>>>    drivers/pci/pci-acpi.c | 12 ++++++++++++
>>>>    drivers/pci/pci.c      | 17 ++++++++++++++++-
>>>>    drivers/pci/pci.h      |  5 +++++
>>>>    3 files changed, 33 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>>>> index b5b65cdfa3b8b..9f418ec87b6a5 100644
>>>> --- a/drivers/pci/pci-acpi.c
>>>> +++ b/drivers/pci/pci-acpi.c
>>>> @@ -1081,6 +1081,18 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>>    	return false;
>>>>    }
>>>> +/**
>>>> + * acpi_pci_device_constraint - return any PCI power state constraints
>>>> + * @dev: PCI device to check
>>>> + *
>>>> + * Returns: Any valid constraint specified by platform for a device.
>>>> + * Otherwise PCI_POWER_ERROR.
>>>> + */
>>>> +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
>>>> +{
>>>> +	return map_acpi_to_pci(acpi_get_lps0_constraint(&dev->dev));
> 
> The non-x86 acpi_get_lps0_constraint() stub returns -ENODEV, which
> doesn't seem quite right because map_acpi_to_pci() assumes it gets
> ACPI_STATE_D0, etc.
> 
> I think it happens to work out fine because if it gets something
> that's not ACPI_STATE_*, map_acpi_to_pci() returns PCI_POWER_ERROR,
> but that's unholy knowledge of the ACPI_STATE_* values.

If the consensus is to back to patching pci.c/pci-acpi.c in a future 
revision I'll change this a bit.

Yes I was relying upon PCI_POWER_ERROR for non-x86/non-s2idle cases.

> 
>>>> +}
>>>> +
>>>>    static void acpi_pci_config_space_access(struct pci_dev *dev, bool enable)
>>>>    {
>>>>    	int val = enable ? ACPI_REG_CONNECT : ACPI_REG_DISCONNECT;
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 693f4ca90452b..567443726974b 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -1082,6 +1082,14 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
>>>>    	return acpi_pci_bridge_d3(dev);
>>>>    }
>>>> +static inline pci_power_t platform_get_constraint(struct pci_dev *dev)
>>>> +{
>>>> +	if (pci_use_mid_pm())
>>>> +		return PCI_POWER_ERROR;
>>>> +
>>>> +	return acpi_pci_device_constraint(dev);
>>>> +}
>>>> +
>>>>    /**
>>>>     * pci_update_current_state - Read power state of given device and cache it
>>>>     * @dev: PCI device to handle.
>>>> @@ -2685,11 +2693,13 @@ static inline pci_power_t pci_get_wake_pme_state(struct pci_dev *dev)
>>>>     */
>>>>    static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>>>>    {
>>>> +	pci_power_t state;
>>>> +
>>>>    	if (platform_pci_power_manageable(dev)) {
>>>>    		/*
>>>>    		 * Call the platform to find the target state for the device.
>>>>    		 */
>>>> -		pci_power_t state = platform_pci_choose_state(dev);
>>>> +		state = platform_pci_choose_state(dev);
>>>>    		switch (state) {
>>>>    		case PCI_POWER_ERROR:
>>>> @@ -2715,6 +2725,11 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
>>>>    	else if (!dev->pm_cap)
>>>>    		return PCI_D0;
>>>> +	/* if platform indicates preferred state device constraint, use it */
>>>> +	state = platform_get_constraint(dev);
>>>> +	if (state != PCI_POWER_ERROR)
>>>> +		return state;
>>>> +
>>>>    	if (wakeup && dev->pme_support)
>>>>    		return pci_get_wake_pme_state(dev);
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index a4c3974340576..410fca4b88837 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -707,6 +707,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev);
>>>>    int pci_dev_acpi_reset(struct pci_dev *dev, bool probe);
>>>>    bool acpi_pci_power_manageable(struct pci_dev *dev);
>>>>    bool acpi_pci_bridge_d3(struct pci_dev *dev);
>>>> +pci_power_t acpi_pci_device_constraint(struct pci_dev *dev);
>>>>    int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state);
>>>>    pci_power_t acpi_pci_get_power_state(struct pci_dev *dev);
>>>>    void acpi_pci_refresh_power_state(struct pci_dev *dev);
>>>> @@ -731,6 +732,10 @@ static inline bool acpi_pci_bridge_d3(struct pci_dev *dev)
>>>>    {
>>>>    	return false;
>>>>    }
>>>> +static inline pci_power_t acpi_pci_device_constraint(struct pci_dev *dev)
>>>> +{
>>>> +	return PCI_POWER_ERROR;
>>>> +}
>>>>    static inline int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
>>>>    {
>>>>    	return -ENODEV;
>>>> -- 
>>>> 2.34.1
>>>>
