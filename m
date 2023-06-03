Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6F9720CC6
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jun 2023 02:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbjFCA65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 20:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjFCA64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 20:58:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC0A1A8;
        Fri,  2 Jun 2023 17:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgA8rZdK/T0bxMJzVcLq82klnBAZ/1tgX77OvD3OGM+Qt56pvmbVmpoOTFXJ8M/OP+THcOpeuTSU2frcBjWpt1HfbzzXvZ/VokB6xAN5arIkay21Gu6jkzJgInANnatJESKVj3kHQ3hMhNYs3yvIILCVnTyY4EEg5VW4jQ160sEOZ6kAa1WQodFjTptXUjuIYn12tP84m4jsp6KJJNnXVu7LH167S6erUVDh2NXNa1L6ZGjT2TrtZ9yza1mPg5V30lHREFJUHUtamOKM3cjI5WBUyORJ8DBLuFnwUcgyuwT/So9aLK31VsvxsLyffNGf+Fa9B1NG+H5s2+HHbFdanQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2Uoq/kqGd8hJhaanSlQP/5ASQbuzgN2lUKsaQybgy8=;
 b=DQzKXaFmikOrU3OW2p2nxsLUGYEEICenRsQnWCLbyjgNVpSIFyqx0LX/OpdfWAghIGVc84BAzrRlBL95e4ciA2MglFR24mqQKQpye9MtMKGZH/Z6Sbfsg4Iyfw78DWCyQYDaSLsDcjGvJsuBTy6juA/NPB8t8tQyiY7Iwv4NyBSx9CG2A+Rrzs8x8aNjMEhp8EuSQY5RywhVSbjp9wXpRq2GzFr9viZsosPoWXJfb/ItknBus2OEv3M/8Pi8S8PLkZ5O+1cNs/ev/mwTFl2JffNuF50IXM7VbHVDw5HDvJbC7uqKDQ72rd4by16hwa73YnH7F7V7NSQjNL+yU+ZOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Uoq/kqGd8hJhaanSlQP/5ASQbuzgN2lUKsaQybgy8=;
 b=ck8HNnaylcoWKzxNsmHKy4aqd5rt08odjGt6ZseXlnkg9mI0kZTV+w6u88UMxdATI7mg65xxzV9pegoSj1RrGWozqKHYopiIYRUFCd8TQ5Ak91OSmSw1IE0OADw39uOK2/Q9iZMwXD21TnxGIirn4s5wJfK1HztMTf35e6wSvq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 DS0PR12MB6392.namprd12.prod.outlook.com (2603:10b6:8:cc::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.26; Sat, 3 Jun 2023 00:58:50 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::9843:8963:3ffe:88fb]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::9843:8963:3ffe:88fb%4]) with mapi id 15.20.6455.027; Sat, 3 Jun 2023
 00:58:50 +0000
Message-ID: <a012ce3d-90f3-48fb-caa5-476f6c9f7fe3@amd.com>
Date:   Fri, 2 Jun 2023 19:58:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v5 2/2] PCI: Don't assume root ports are power manageable
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <ZHp45fNGuPUWPnO7@bhelgaas>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <ZHp45fNGuPUWPnO7@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0053.namprd11.prod.outlook.com
 (2603:10b6:806:d0::28) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|DS0PR12MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 607a1341-4160-426a-a438-08db63cdb168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uKr/oq9nS/ctQH8KITFDRZb7vZnhy6KPsg6+n/Wg128XGfkF4ED2BQUfhLE27gacrT3PyEbpEwQpdgmo196rVScTtsZriIbHoMM2Synl2LibX7aJUMFZULJ2/qAOUNP6Bpcikhs9BdB8rU3/JguacHh7HfOBRZSuhrNbx9p6bpLZYno9ttqULK3Z+r9fJMF6pB4u8pyIg9RQTTxyoYorppciKqjBbuIMUIHcg7XVv59BuMvI+gHiV9z8Aj0rYAOWNFLKBwAAtUtZemiMx5Ckop1tDwTR2UYYVeDIL5Qpn7vMi+oGGVCgLkgke298hVAeAAaET4PG3FazoOCHdp4DQB2ZrZrgdE7xb922r+SUNbRGqp6mybn9N74XfToKX3+TCQXGUdUuMDo86mLua1DYxkUfrYgwE4RoKBtkINsK2M6d0LZbJ98kTCO+yjNkwXYkgovy2RIolNepEHhtnikxX4vsE7xH2VP941jxFuQGOHK9i0ZVtVZUW/OkluJt+YN/kc6n/dbe/YOYZ9SPUiv63wU2lvYvBCMM+8hN9UQtZDlaYtr0thsBLfSFewW9E5dS3JBvQVzY4jZ2B7l+Gf/mcXlMYAVdPTwONlBenjYCqVAymOYeN4en2CR1LmrkWgxHCe8q8YfjpBVcmVkg1HI0AA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(31686004)(86362001)(966005)(6486002)(478600001)(6666004)(316002)(66556008)(66946007)(41300700001)(31696002)(4326008)(66476007)(6916009)(36756003)(54906003)(66574015)(186003)(7416002)(2616005)(5660300002)(8936002)(2906002)(83380400001)(6506007)(6512007)(53546011)(8676002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy8rOUNDLy9lblhhY3h4ZEZ5ZGtuR25jQUpCaXE1RWN0cDVFUlIwSG4vSjFt?=
 =?utf-8?B?NTk1WmxXcGoraDA5dUY5VVVKb1NuNjFxUXdkYVdBRElPWGNVL2gzTnNsMzYw?=
 =?utf-8?B?enpQdlZUbHNXK2NzZS9JT1Zzdnk2Z2t4SjBFNDRNS1ZOWmZnYkQwc0w5WlRp?=
 =?utf-8?B?MllKQURhK2s5OTVnUzdsY3A0ZGVzaDZnYVlyS2UvbytBOE1EcWFLSzZhb0Ur?=
 =?utf-8?B?VUVWMk1xc3dXaEJ3OEl2aGVuUG9aWEVRcmVFcUFoVlFxVkc4dFczOFNNNTlz?=
 =?utf-8?B?OWRUVWE2WTFFRTlhT0dWaTcveWc4VTZBY1pOWnZsK01GaW8xNEpoeWZTcW9z?=
 =?utf-8?B?cnRDYzN1c3ZYS2FTUjdiZC9yZlVGWnpuTnQxMHQ1alNqOEdWdCtzZE4yYVQ1?=
 =?utf-8?B?eklXQWliQlFGUU4ybUtsL2FjblFpTkttL1oxSDVSOERldTE2MTZOZlFRdEp6?=
 =?utf-8?B?VWhnT05QLzZBREdiV3VHU2FkajNnNUhPSU5DR3V6U2UzU25TczN6cFoxTFBB?=
 =?utf-8?B?c0s4N0dLckkvYzA1NVlXN1dFUk5XejVCODFUNTFXMXQ5QXljWERvcUlOSmV2?=
 =?utf-8?B?c080bVlFcFo3d3F0Tkl3Y0FLS2greS9VUzdjaDU4aXRLRm5VRTRFSG5nTVd1?=
 =?utf-8?B?U2M3NDhPb3ZudXBjdWtYcXRtOFF1dWZiU1BtUW5ycVl0VUgvbEJ2RU9TdXI0?=
 =?utf-8?B?eEViejV1N3Y3K2hPa3hWTWFQM2FxN296WWg5R0ZMWEpxTEs1dG1FU2lnU1lr?=
 =?utf-8?B?S2twN1lURjJwcmcwb3ppeWh5WnpHZVpueUJNMDRvTExqclJEQUtRU2NVYjI3?=
 =?utf-8?B?ZnIvMENZdnc1MHpZQk92TnUxMG5GcHlPTC9VVnQwRS9taHM2a2lVQlYrc2I4?=
 =?utf-8?B?eWdoZ3lBakh5VU13bVNmV2FTMXJMY0tRbmJ2UlRIcXpJQlIxc0dUWEZ0aDFE?=
 =?utf-8?B?dklrLzdpaGpRWktEM3BvcWJSYTZYUlNyYWUvZC96NFlYbVJyR3owVWFRV01X?=
 =?utf-8?B?SGEyamRxZWJBSmhSVE5sVFNETnpTNWh2TGJnWUlmNE8zdDQwZnVST1drMzN4?=
 =?utf-8?B?WmZIWnJPOGJvUDkyYjczZCszOUFRSk45YzVZNVpzUEhadkM0enh5Vk0zeURu?=
 =?utf-8?B?NDMvdFBsdWlXZWVxazVySXpOR2g0emtoSVVnejJCeGRXL0N1SzBacVV6YWd1?=
 =?utf-8?B?ZHVyL1VIcEkvRVJRTXRTWTNhaTlTYi9raUkycnJIWXJsL0VCRllic01OdjZ1?=
 =?utf-8?B?VmNBYWJ2VnBJL1lGaXRRaGdROGhEUnRwL2lLaUgvNDRGZFE4WGI0aFZ4bGhm?=
 =?utf-8?B?TkRDNEhLbmNMVmg3MmFFZXRiL21NMEJQbU9DSithbjRscWJCZUQ1S2tDajkv?=
 =?utf-8?B?c0Q3Q1BSSEMwdFVYRGUyeUxMRzRvWVVibmIyYWRJcllZQXc0WldjaCswL3da?=
 =?utf-8?B?NHRJdFZNTXNKcVBuTnM0WStMZmc1SSt0T2s0UDlLdldrbUVwd0dPT0VQMmFO?=
 =?utf-8?B?YTExVTZqZEk5VDVkTjFubTQ4dHFFNEFYZUo3bUZDZlpyOWtqRjZSTFc4QVlv?=
 =?utf-8?B?RllMN1RRREQ0Qjc3TndHd2VmSEsyMm4yczJWRWwzbUZLSHVnRTB6V0xtTjdW?=
 =?utf-8?B?enZTaGozYjJFcFE4VkZYQTd2ZkZEek0vcG5UY3RoVVYySVlxeWV1eGpMUGN5?=
 =?utf-8?B?V2psOC9IT000aDdmck9ZYVZzakZKSTJNY0JSbXU1bVNRNUVxMThOV0NXL3Bk?=
 =?utf-8?B?L3cxcTEwZ0NCU0xJcUUvRy9wL2NodDlaZEVUdmhPZ0lZVlkyVGZpMzVMYkto?=
 =?utf-8?B?Q2VRV3lwbGMzV1Q2Smg4ay8xMTBudkNpWmdQOHF2UGI4VEIzaG1DOGFLSjU0?=
 =?utf-8?B?NE51RmxMOURZNFZoZUJhNWRaMjRQdUJ1VWpkTUNVVGFUVmd3WjdpVkRJQ3Fs?=
 =?utf-8?B?djdwRE5zWGIxUVdpSGd6c0J1Q3lvaTVtc2ZGMUg4ZmtoNFU3c1ZRSGJ0ZE4y?=
 =?utf-8?B?cS96cmZYdGdzeTRrWDN0RkFWSm5FZG8zQlZISDR5eDBtd1JHUjVJUGoxWk9x?=
 =?utf-8?B?Wnk0a2VmZE9yZDdIZkcvOWhQS000cGxyaDcvNlQvejM3ckF0d2dOK3VKS1Ev?=
 =?utf-8?B?VHkyRHlwdkJ2OTdsNWFZdCtUaU9QM0xkV2dRckVmb3BObnlCaFlGN0M0UHJi?=
 =?utf-8?Q?yp93d4BwEPWE3CgOqEbpNpRMi8/TkbG5dpXJbfe+Auxd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607a1341-4160-426a-a438-08db63cdb168
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 00:58:50.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZaB3XC2efdFIIJ8vXNGRXOD2v7pfP3MCLWpSOcivFlUZY6N1pPz7nbCvVffk/AadufNRNN6DU+TJVpCa8v+Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6392
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 6/2/2023 6:19 PM, Bjorn Helgaas wrote:
> On Fri, Jun 02, 2023 at 05:38:37PM -0500, Limonciello, Mario wrote:
>> On 6/2/2023 5:20 PM, Bjorn Helgaas wrote:
>>> On Tue, May 30, 2023 at 11:39:47AM -0500, Mario Limonciello wrote:
>>>> Using a USB keyboard or mouse to wakeup the system from s2idle fails when
>>>> that xHCI device is connected to a USB-C port for an AMD USB4 router.
>>> It sounds like the real issue is that "Root Ports in D3hot/D3cold may
>>> not support wakeup", and the USB, xHCI, USB-C, AMD USB4 router bits
>>> are probably not really relevant.  And hopefully even the "AMD
>>> platforms" mentioned below is not relevant.
>> Yeah.  It comes down to how much you want in the commit
>> about how we got to this conclusion versus a generic
>> fix.  I generally like to be verbose about a specific case
>> something fixes so that when distros decide what to pull
>> in to their older maintenance kernels they can understand
>> what's important.
> That's actually my point.  I think this problem probably affects
> non-USB devices, non-xHCI devices, non-USB4 routers, etc.
>
> If we can say "Any device below a Root Port in D3hot/D3cold may not
> support wakeup if X, Y, Z.  Root Ports may be put in D3hot/D3cold for
> sleep/hibernate/s2idle/...",  that's much more actionable.
Completely agree.
>
>>>> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> all PCIe ports go into D3 during s2idle.
>>>>
>>>> When specific root ports are put into D3 over s2idle on some AMD platforms
>>>> it is not possible for the platform to properly identify wakeup sources.
>>>> This happens whether the root port goes into D3hot or D3cold.
>>> Can we connect this to a spec so it's not just the empirical "some AMD
>>> platforms work like X" observation?
>>>
>>> "s2idle" is meaningful on the power management side of the house, but
>>> it doesn't appear in PCI or ACPI specs, so I don't know what it means
>>> here.  I assume the D3hot/D3cold state of the Root Port is the
>>> critical factor, regardless of how it got there.
>> Unfortunately (?) for this particular issue it's only a
>> critical factor when the system is in s2idle.
>>
>> PME works fine to wake up the device if the root port is
>> in either D3hot or D3cold when the system isn't in s2idle.
> So that must mean something other than the Root Port has to be in some
> specific state.  "System in s2idle" is not actionable in terms of PCI
> maintenance.  It sounds like we just haven't really gotten to the root
> cause yet.
The root cause of this behavior is deep in the platform
firmware.  This is why the platform firmware doesn't
advertise power management support for the root port.
>
>>>> Linux shouldn't assume root ports support D3 just because they're on a
>>>> machine newer than 2015, the ports should also be deemed power manageable.
>>>> Add an extra check explicitly for root ports to ensure D3 isn't selected
>>>> for them if they are not power-manageable through platform firmware.
>>> But I *would* like to know specifically what "power manageable" means
>>> here.  I might naively assume that a device with the PCI Power
>>> Management Capability is "power manageable", and that if PME_Support
>>> includes D3hot and D3cold, we're good to go.  But obviously it's more
>>> complicated than that, and I'd like to cite the spec that mentions the
>>> actual things we need here.
>> Power manageable through platform firmware means the device
>> has ACPI methods like like _PR0, _PS0.
> What's the connection to wakeup?
There is also no _PRW (power resources for wake) for this
root port.
>
>>>> +	 * It's not safe to put root ports that don't support power
>>>> +	 * management into D3.
>>> I assume "it's not safe" really means "Root Ports in D3hot/D3cold may
>>> not be able to signal PME interrupts unless ... <mumble> platform
>>> firmware <mumble> e.g., ACPI method <mumble> ..."
>>>
>>> Can we include some of those hints here?
>> I'm cautious about hardcoding logic used by
>> acpi_bus_get_power_flags() in a comment in case it changes.
>>
>> How about:
>>
>> "Root ports in D3 may not be able to reliably signal wakeup
>> events unless platform firmware signals power management
>> capabilities".
> I'm really looking hard for that spec citation :)  Without that, this
> just devolves into "this seems to work on these systems."
I mean that's exactly what the broken logic below this
fix is....

But I think I can get you what you're looking for.

 From this failing system the problematic root port is GP19.

The DSDT has:

Device (GP19) {
     Method (_DSM,..)
     Method (_PRT,..)
     Device (NHI0)
     Device (NHI1)
}

The SSDT has:

Scope (\_SB.PCI0.GP19) {
Method (YS0W,..)
Method (YPRW,..)
Method (RPRM,..)
Method (WPRM,..)
Method (SPDP,..)
Method (SPCH,..)
Method (_STA,..)
Method (_INI,..)
Method (_REG,..)
}

Section 7.3 from the ACPI spec [1] says

"For a device that is power-managed using ACPI, a Definition Block 
contains one or more of the objects found in the table below. Power 
management of a device is done using Power Resource control"

The GP19 device has NONE of the objects mentioned in the table.

Outside of this change, I do think this means acpi_bus_get_power_flags() 
may want to also look for some of the other objects besides _PS0 and 
_PR0 to resolve that a device is power manageable though.

[1] 
https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=pr0#device-power-management-objects

>>>> +	 */
>>>> +	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>>>> +	    !platform_pci_power_manageable(bridge))
>>>> +		return false;
>>>> +
>>>>    	/*
>>>>    	 * It should be safe to put PCIe ports from 2015 or newer
>>>>    	 * to D3.
>>>> -- 
>>>> 2.34.1
>>>>
