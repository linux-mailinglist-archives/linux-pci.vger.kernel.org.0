Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F420A61021E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiJ0T4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 15:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236745AbiJ0T40 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 15:56:26 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3B87695;
        Thu, 27 Oct 2022 12:56:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQ2y4C7IKlhVe87CD9/0B8IvVBtO+dkaUGW1HIV16aSZPcSskSZQ0NYcfK56bxdAnZS+bqBreTJvP1VFtS2xZhMbE8uKiJBvjS9dYiQ42WFlkKPEvW4nZAouncqZsZDYJaixUrq+o6z/lENEFNEVb02r+zusZeedt4rRTfDDaBdht531cmyPSg8nTlYxuPE6NXSnZ9ucydRsxSvOUUrV0+e5M2QYMriLA8Hs/LrDKkKFVDZE6RN80EDGWwzQ0OnC8XIJti5yylXiRk8DvQLY8QzJ80Ugeru7mG/GqMIlyMgtgU56vkocRN33Qkc7gjB94yI5w7BLsSeLTFlmm5HBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1lHx2fYAu793OXjheD+si5csuKu5vAlC0sg2ui0gTw=;
 b=R3+euQNeIDQ4jI3JUmmyMY2NMfvUIpa8vUHjIew1pjE5IehlmHRX6t4Ybd79zKyfLMhjB/lPk3p9MQ4FU05DgAksmEqbootXx0TR7whaf6MgZxYsGLljiox48iWJh7ePSL5bkw86rBGvWHGAehY/A2yEGkLPKATst+fiXgIsO7fN4QCoSaz0e2XhDk8XwVb2L5ODXrKsD+Ao93ZyCuTqOyl7GHtDhyHIAS1fhTgkBAgYNcRZxm95HbXQg67IyiPhFHiPJ2PtgDVZO6hnNZAvfbBC98hnPYa9jvRIorItJlXJGLaQl8pVzrj4pISozl+PjZUlIrCpV/quZSHLmuudsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1lHx2fYAu793OXjheD+si5csuKu5vAlC0sg2ui0gTw=;
 b=y+JN8YiM60drPkbGLIF3kv4KoFg+6PKifT7ZmSi2gFE02i/UbCSUbfvIY/oox6+qiKjRsF3MAAmY7/9fydZvxxEA4YP3ZM8lUubyQqZnpWVuZdb9ASiSbgk917DHphlTsygDTdyS9Z9q2KqRbCstWq3LArleIvmMyDH8QoBn8Uc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 19:56:22 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 19:56:21 +0000
Message-ID: <7ba39e79-7fe5-a644-83da-c8fc05a1ca84@amd.com>
Date:   Thu, 27 Oct 2022 14:56:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4] PCI/ACPI: PCI/ACPI: Validate devices with power
 resources support D3
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mehta Sanju <Sanju.Mehta@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026215237.18556-1-mario.limonciello@amd.com>
 <20221027052407.GA18319@wunner.de>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221027052407.GA18319@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0327.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::32) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: c53d49ec-31b1-4aca-a221-08dab855522c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgwvzsKIjhqIlpzuoNludewPruvg8nlUzvDSpOBPztyzetJUHWio+XM4YThN6yoPvVd2yZUPHrrlKiPwTdQyTYt7CXObeh8nEC2L6hvxIZVJopYWYgJbRKfwUpDC31eF4bOgOBSmR2edKHFgwIEr7LTgzLmGgpVHZH9v75q2ij6vkrgR9WWaVMK3USmXro+r18SoNivH1Itg1yZMFPH8X55x78blHJCsaHWBgdicPf4kC3o+TQjZKExvQdaZXWclRyVZlSqMnumdZTFls3eHC/aRWw4fSeqbgm4qexDIgXR6wbR5jmI0oVJYXRiKOO2zvldtX7m6uVjY8Pe+em3FCIKOIbRWY4Pn+bD5qW7HG0NchxZKK7T1RiVG9h1yy61di4xVsDniTytAwSTN9cQlK1kQiQSKeRh8zA6/0hvv1mv+yy2edrB9pQupzz1fx21YBBOj23rAzd6JG8VkXECQ/atFZcWJE2hSsUBZKOX9zBf1LfoLqcSoKGwvvUFKi/Bs+w3SKkwb02enhmxZbmRNwQbuHY9/+FAHhtyFyaVlThQznZLbr+odMyDlDytxi0xY8JLjWz2ER//G4Ly3Jz6K5u5Z7rzLmwl0nEBDJT9AsxHdifv40SiAcqAu5WoFYctU6sOIKK7miXyI8gfIqRaynH8WPKyIB50+QdK8ep5l6oBG6xL6XP03hsd6YL0OO3IoX9j1P8DxvjWMRe4ZoI3P/mlOeXMBoWvhvlUVrP3QaLz+TgtPzsvioj8MjYzJE3BPddMOd+OFW4WvQBpeEYoU7RUgYkK4gHyI1230AKsjgSxwFQtOST/4+gljE/5nSNfbAsoibTDVO98BecLTY97PonL9NQThmL+5sp3RFIYPexs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(5660300002)(19627235002)(6486002)(478600001)(8936002)(4326008)(2906002)(15650500001)(316002)(966005)(86362001)(31686004)(38100700002)(31696002)(8676002)(6506007)(186003)(2616005)(53546011)(6512007)(41300700001)(26005)(6916009)(54906003)(66476007)(66556008)(45080400002)(66946007)(66574015)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXg0NmpaYjEzQ1ZvaHlIMWpqVURjR0pMTElZaFhod3AvbGxMQWk1dXUxVC8r?=
 =?utf-8?B?SXFteVlKMVJIdWhFekJDVXE5eWsyRlJ3QXo0aFRVdkVQWlRwdVJYdUhtZHJY?=
 =?utf-8?B?SS9KeDc5ZWVwbHRVeTkxVDhJU3N3alJQRDRBc3NnV1MvblNKRGo2d2xodVhR?=
 =?utf-8?B?N1F0Y0RWWW9tQmpodGJXUlVJcjlnRWNhUTRHQlhMZDVRUlljNFVFQTAwMEhB?=
 =?utf-8?B?bTRCUWwvbmNQd0NxZ0J5UDhHRjdUKzY0eHJLM3YzbUp2YzBvSW5nUzdoVjB6?=
 =?utf-8?B?S05FSWtDdmI2ODljUXVZMG1ydTlEL0JzS1NEUXRqK1ROZU5kUEpXMTZlTGhu?=
 =?utf-8?B?dEcwdWtKNHEyUTZXcER6VUlhbGhwTi84NFIwWERnTGVXbXF5N1BuMlhtUGJm?=
 =?utf-8?B?c3Z2clZidHNtaFpWS1RZY1lrTExNMTZsOEQzamtVclBuaWQ4cDNINURWNW9z?=
 =?utf-8?B?YlNCbjhtYU43RGlQcEpyaEM2dFl4M2R2RExTTS96RFpwL0lER1NGMVhSZC9G?=
 =?utf-8?B?Zkl6aVNkYmFCWGE3cFpzSzBxYXl4aW9qckY4bWJDSWYzd1g0dFhlMGJ4ODc5?=
 =?utf-8?B?dGVqNnF5M0NZaHBvZy9ZU2RTeGJGekd1a2VkMWx4c213bmJkbVVtc2dlSXVC?=
 =?utf-8?B?M1pSaThYaG83TkVnK29heU9NOVJIVTcxbWxFR3RBQ05XRFVIWmpPd0p2cTc0?=
 =?utf-8?B?SGhOSEtTbU1ibVQrdEhOQWNSdFljVGtSNGorTEU4VzJNOVd1OVhtc3FFUC9v?=
 =?utf-8?B?VlY5UFpBZ1ZGVHg1cVh2UmhaWHdHSlZ6WTZrWXNGZ0lqVjVlZ1FiZlZTc0cw?=
 =?utf-8?B?dExiWjhLWVlWUFpCWVZLRW9DdXJyQm0zdVBUSklUM0RBdG8wVzJ0b3U4MXZS?=
 =?utf-8?B?cDVIbnd4YjNVejFxRGZ2cDlKeGJUQ1BLUUJqSU9qOUFXQjI0ZzhjNllQbjNW?=
 =?utf-8?B?WkdDUGxTVmFlL3dLeE9FMDcrZW40N2tGZ1U0Um1IOVVqL2hvUngzT1g1T2Jy?=
 =?utf-8?B?U3c5Rk45TmcwQ1VsYmg1Q1lwTVBzT3dvOS9QZEUwc2J3cmpJZnlBbXNlcjkr?=
 =?utf-8?B?TU5WNVF5OUZVb3BNeGRyWGNFcFVFWkg0SE9laVpndklBTDZmMEJJSVFsbSsv?=
 =?utf-8?B?VjJkSVJPYmsrckk3OGpCWXNLN0NBRDdUdjFwOHRxWlRuK0h2UWFHanNwajhL?=
 =?utf-8?B?WGoxT3lzSG13QXY5TzFzMVNRa01uTFdidHh6bUJRVmdsQ1VyL2lTZmd6SjE0?=
 =?utf-8?B?RVArenMvbVB3M2xiUzhoK0t6Z1V6MkdwR3JvMlpZWkZ5TDRFUGZ3Y1d6Y0Rs?=
 =?utf-8?B?N2RYSFF1YzdkejVJcG9uQVdjbjZVZ09YcEZaTnVsYUtBOE16elBxbkxuVERY?=
 =?utf-8?B?MTlucFEvUlE3K3kyTUFUL01IdldsUysvN0x0YWYwUVYvT1RKT0lCUXcxaWFH?=
 =?utf-8?B?YmV3S2o0QkNFbzIyM0xMOEw0YXZBV0trV1djNzZ3Vm8waXVYM0RHZ3YzWTVJ?=
 =?utf-8?B?bXlNMHVFZ2RWRUtMRXFJR1VKeVBLTGw3eU52RnJiWDRlUmw5Z0RaM3hxenhT?=
 =?utf-8?B?ekYvQzNEbk9keDdHdm9IdllRUFhUL0NOV0xDRFl2THl2Yk8rYWdNTitQRUtY?=
 =?utf-8?B?UHBDTG1aek93TUkrdGN4WjF2ZUxLT2taOWFCRklNWjVzR0lQTndqUC9ieUQ3?=
 =?utf-8?B?UXE5dVNOdFd2Ni95MjdtSE1GdXVHT2JhbEpkYVcvK01VajJGaENPK1JrRGlO?=
 =?utf-8?B?Q2FmWjhYSkI3ZVVCZi94UitMNVBLYmJFL05RT1pTVWwwZG5qRW5rRC8wMFFQ?=
 =?utf-8?B?amVsaGJYZWNWamtXV0dIUEFCVjVnSmVwaERLL0ExMGhWWHdCa3RKa0pBMkRw?=
 =?utf-8?B?V2RTS3pLQU5hQ2lRS1dxR1MwcUpuR0RzTFF3bFlBTDNuSkxRaGVSVWlDUzEy?=
 =?utf-8?B?YzMreURra0F5TGFuekM0Wm00V0szK2xyRURqbjF6aEpwMVlORFBlNFNwa0pT?=
 =?utf-8?B?YkthQyt5SkNJa3dUYnJ4V09lT0pHdmdHd1RzMGVOdjBYTitZNk5DekNYOWtV?=
 =?utf-8?B?R3RUSkgxL2xWdDNONGhQd1J1azBuVjZwVGZhUjNJMEhlekpRZ3lCKzlLNVNJ?=
 =?utf-8?Q?35R5NvmkdxC7naFEdHA7OFgRq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d49ec-31b1-4aca-a221-08dab855522c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:56:21.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuMolnMIYkMeRuKxi79fXRLaWQ0ZwbNXsn4rSmpp58dGdAThsbcF+Ny21CPeCMuu5ktvx1BAXWqpwepqgIaIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/27/2022 00:24, Lukas Wunner wrote:
> On Wed, Oct 26, 2022 at 04:52:37PM -0500, Mario Limonciello wrote:
>> Firmware typically advertises that ACPI devices that represent PCIe
>> devices can support D3 by a combination of the value returned by
>> _S0W as well as the HotPlugSupportInD3 _DSD [1].
>>
>> `acpi_pci_bridge_d3` looks for this combination but also contains
>> an assumption that if an ACPI device contains power resources the PCIe
>> device it's associated with can support D3.  This was introduced
>> from commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for
>> D3 if power managed by ACPI").
>>
>> Some firmware configurations for "AMD Pink Sardine" do not support
>> wake from D3 in _S0W for the ACPI device representing the PCIe root
>> port used for tunneling. The PCIe device will still be opted into
>> runtime PM in the kernel [2] because of the logic within
>> `acpi_pci_bridge_d3`. This currently happens because the ACPI
>> device contains power resources.
> 
> So put briefly, in acpi_pci_bridge_d3() we fail to take wake capabilities
> into account and blindly assume that a bridge can be runtime suspended
> to D3 if it is power-manageable by ACPI.
> 
> By moving the acpi_pci_power_manageable() below the wake capabilities
> checks, we avoid runtime suspending a bridge that is not wakeup capable.
> 

Yes, spot on.

> The more verbose explanation in the commit message is useful to
> understand how the issue was exposed, but it somewhat obscures
> the issue itself.

Within this lengthy commit message I attempted to follow the model of:

"Status quo"
"Background"
"Problem Statement"
"Impact"
"Solution"

> 
> 
>> When the thunderbolt driver is loaded two device links are created:
>> * USB4 router <-> PCIe root port for tunneling
>> * USB4 router <-> XHCI PCIe device
> 
> Those double arrows are a little misleading, a device link is
> unidirectional, so it's really <-- and not <->.

Yes, that's correct.  Thanks.

> 
> 
>> Currently runtime PM is allowed for all of these devices.  This means that
>> when all consumers are idle long enough, they will enter their deepest allowed
>> sleep state. Once all consumers are in their deepest allowed sleep state the
>> suppliers will enter the deepest sleep state as well.
>>
>> * The PCIe root port for tunneling doesn't support waking from D3hot or
>>    D3cold so it stays in D0.
> 
> Huh?  I thought it's runtime suspended to D3hot even though it should stay
> runtime resumed in D0 because it's not wakeup capable in D3hot?

This is why I included the power state information in my topology diagram.

It's runtime suspended, but as it can't wake from D3hot it is 
"suspended" to D0.

$ cat /sys/bus/pci/devices/0000\:00\:03.1/power/control
auto
$ cat /sys/bus/pci/devices/0000\:00\:03.1/power/runtime_enabled
enabled
$ cat /sys/bus/pci/devices/0000\:00\:03.1/power/runtime_status
suspended
$ cat /sys/bus/pci/devices/0000\:00\:03.1/power_state
D0

> 
> 
>> * The XHCI PCIe device supports wakeup from D3cold so it goes to D3cold.
>> * Both consumers are in their deepest state and the USB4 router supports
>>    wakeup from D3cold, so it goes into this state.
>>
>> The expectation is the USB4 router should have also remained in D0 since
>> the PCIe root port for tunneling remained in D0 and a device link exists
>> between the two devices.
>  > This paragraph sounds like the problem is the router runtime suspended.
> IIUC the router could only runtime suspend because its consumer, the
> Root Port, runtime suspended.  By preventing the Root Port from runtime
> suspending, you're implicitly preventing it's supplier (the router)
> from suspending.

Yes, but I think it's a matter of perspective.  Both of these PCIe 
devices are exposing interfaces to different parts of the same SoC.
This issue was identified because this sequence of events in the kernel 
leads to unexpected power sequencing within the USB4 IP.

 From the perspective of the silicon designer the USB4 router shouldn't 
have "been able" to go into D3 until the PCIe root port for tunneling 
went into D3.  When the firmware prohibited the PCIe root port for 
tunneling to go into D3 this should implicitly prohibit the USB4 router 
as well.

I'll attempt to adjust my wording accordingly.

> 
> 
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-for-pcie-root-ports%23identifying-pcie-root-ports-supporting-hot-plug-in-d3&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cd7450aa3d87e43996a5c08dab7db79dd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638024450531138458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=1GCD4G5n79pldE3zOD7%2F3CCjdHY4qgzIRT5YHajbLEY%3D&amp;reserved=0 [1]
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2Fv6.1-rc1%2Fdrivers%2Fpci%2Fpcie%2Fportdrv_pci.c%23L126&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cd7450aa3d87e43996a5c08dab7db79dd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638024450531138458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Wr%2FDRQNQrl6EE2dJRWG2SVJ4QQkIsjSejM84nJE4R4g%3D&amp;reserved=0 [2]
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Ftorvalds%2Flinux%2Fblob%2Fv6.1-rc1%2Fdrivers%2Fthunderbolt%2Facpi.c%23L29&amp;data=05%7C01%7Cmario.limonciello%40amd.com%7Cd7450aa3d87e43996a5c08dab7db79dd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638024450531138458%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=ghZJRgT2xWjYFYOWoC77y%2B5Jn8ZlCErOgswjeQQbfCM%3D&amp;reserved=0 [3]
> 
> I think git.kernel.org links are preferred to 3rd party hosting services.

I wasn't aware of any such policy.  Within the last release it seemed to 
me Github was perfectly acceptable to use for links.

$ git log v6.0..v6.1-rc1 | grep "Link: https://github" | wc -l
107
$ git log v6.0..v6.1-rc1 | grep "Link: https://git.kernel.org" | wc -l
2

> 
> Thanks,
> 
> Lukas

