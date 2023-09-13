Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CC279EE5D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Sep 2023 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjIMQfT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Sep 2023 12:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjIMQfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Sep 2023 12:35:19 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF21719B1;
        Wed, 13 Sep 2023 09:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBfG+jKz5qHL8z493GGnaK15NQS52g7aeoYz+Dn2wrHCh7ZUCRjJTHNeyIfzY1WT+mkQGkfcskr6y6lCh08C0BVgh2x8RmTyuwfeUry9HbBYd6h9yx29SXR+V8ZMUzhqxY0nWg2QNBpjJ08jk1AMC+26W0j+z9KCw3vDVn/659QdOkFpkfQ+PgAanj8okkGiBw0ZzsCyWh9oy4NirEELWu5DL0rKLH/PSeuglwP86XcWJNNd7l5O+T4rzhJtOzSbZuDXtl36OfrcUMcOnMf+UV1ZltgnyVXBM8k7ahuBjyibxK+DDhbXmcuT58/C18JMYU+UbaTuhtDytBuwt3FacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwZ5Y23ITEEaVbD/G+U6QUHkJcibchuOJ1bCjXCRS0k=;
 b=BNdZGRLiqrZ6CG/cSaMI87j7FeuMMGOkXYYueU7tm6DT6e2A+c8XkxdlGNJk+wemxuWEApJiuY7Xcgjyfaefv3urHhWad6SZVF0yN6cMlTOicRXlommzMb4jQggHfQMuER/aYU5NohZ6MiQlyPzDdytexDIv3ljlaM7YS7s5tnsz0jQaa+2Xws1kcHc+eckYtJff2OC3S/Vkl5nK2I0kBzgZuKh8P+47mQhv/0W64axmxd52lRyIR/KNJEZjbeULjHanm0b3q+7cBmqeX4KKXGRyCUDfS4mMr1yAI4P7Vkm0YG3jpM6Sc/4KKRx6L2mFh6Ow3nK8yhfoT33qtdeAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwZ5Y23ITEEaVbD/G+U6QUHkJcibchuOJ1bCjXCRS0k=;
 b=wv4VrE0yuQsAoJfG+P4e4pVvOrqL6sFZVIKe5TwBuN8WAXVFzFPIhGYE4fCnx4tAibhfgDvuzY0DTk6UEJWYguNgsiLQIzN/sIjN+MkUctOF0KB/Ovgq0A2cITJklz8lxpsHCnNfbxDgSWDL5/KaxjfWMDaWux/V9ol/ohsI0PQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5239.namprd12.prod.outlook.com (2603:10b6:208:315::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Wed, 13 Sep
 2023 16:35:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 16:35:09 +0000
Message-ID: <8cd30700-d084-4a55-ab46-6e8db6706aa4@amd.com>
Date:   Wed, 13 Sep 2023 11:35:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 2/2] PCI: Add a quirk for AMD PCIe root ports w/ USB4
 controllers
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        iain@orangesquash.org.uk
References: <20230913154036.GA433234@bhelgaas>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230913154036.GA433234@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5239:EE_
X-MS-Office365-Filtering-Correlation-Id: e1dc2f08-3dd2-4135-d35d-08dbb47764f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4rQh610RXTehMZurY2fuPq8nQ1leRQaHk79QNfeOvsUbaRTweYeBNAlazgzU5waYZ/CKKCQkWNyAVWyWAUdCioFWnSD0EXA2SE25v8/ARaBQXwoZ2gI+xblql4rclz734Zf4odkLds4b/vIon1yZR+Awiys9rhjiCGPsQJih5KT86HczjW4GT/k6RbxuRXPvocyH6j+WfTWuq9fPFRNnhOjE1d0/BJSG1yR8dS/a4/BOqi+0kJV1pruL/pkUAiyETd0k9Cp/gdmn9Mrtk6OXL0RdFnSX3WGTtf6UzY3VsioimK/9k30RDmfssDVODVRzVrdEas2ru771k24nNHem2AIPiHtqeM7x0FnwK71045bQp8KT7ejJodC9C0quIpCJS63n7HhYxbKhGEFBhf0hCPX+D6aDvwGKFva+5vOGWfZAGc9wz+tPs4keQUViuKdgBHGO9QmNazke93jwAxAdArrFlg8rB+K5qVBruV3y2Q/dG6Qbrkdw2WzsncYPcr1InO2tr/lPKeQdyjSeJzFGlJKarOkbU4yLmWSHxm3UmRDxzpS3sjShbpP7Pu6o0gBfiuc05BB+yabtEt0IwCvx9ZQ18wGp35IekPKd99GFxc+dqPmiES461U0XprhqIQ/FpTjTCfG/99d7zdu5MtGAjwFgPt55MQVxvN+erfLW8rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199024)(1800799009)(186009)(31696002)(8936002)(8676002)(4326008)(5660300002)(44832011)(2906002)(86362001)(7416002)(36756003)(38100700002)(83380400001)(6486002)(6506007)(6512007)(53546011)(6666004)(26005)(2616005)(66946007)(966005)(110136005)(54906003)(66476007)(66556008)(316002)(478600001)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1BSLzJSakpReHFML0gvYmExcDZlclpBaE84TFFaekk4M1d6bzlMdElNM0pE?=
 =?utf-8?B?TVNvVGQ1M1p3ZW5mSmd4cFVBWDNpSXUvU2F3N1JBbm9VSUdCeUM4K1J6T3Ra?=
 =?utf-8?B?amlNeCtLdE5uNm5vQzFka0szMkllUy81cmU2QkV6V2RqamhwTkVJREd6cjZi?=
 =?utf-8?B?MEUzN2JDUk9tRExaVUh3WlY4NHU4Y2dsR2xlUFg0K2JOc0hFUFRGcEk2aGMw?=
 =?utf-8?B?d0N0c3VQV05WbmFMRHcwdmx0VXpwWGFZeVU5QktTOC9uTlE5bzkwZlpJeU9l?=
 =?utf-8?B?OE9qdU0wN0ViL3RjRWIzM0FHT2xNWERYczhrZ2hTeTA0dUM4NGhzUGg5b2ta?=
 =?utf-8?B?aElCWmkyY216Zk82TFpyeGRsZWlNTDNTWmY5Rml0MzhudEpBR25vM1FSelhv?=
 =?utf-8?B?Q2E0c3JpbmxRQ3BEVXhQbXdmMmtUQ0lma1hXRmFNVG96SThTR0NrM1pnWmZB?=
 =?utf-8?B?TDZ1Wm9ISHQ4eFBva2FWUlBOMWtWWGRIeTQxZERsdTA2OXlqMllYdjhTbnhx?=
 =?utf-8?B?OUJoNTlrQUtLZzVWN1B2OU95Q1liQzU5TEhmM1RGc21vSS9kNHBmYng5eWtn?=
 =?utf-8?B?cUZnZHYwSWlnRXN4M2xGQ0xxbERtcGt6NzBPTmxNcGplM21UeW1FR21LeVF6?=
 =?utf-8?B?UGR5VDBhTUJqRXBPSjUzT2JCbFJGc0RaekR2M01tNjU0V3F3K0FnTzR5WG9B?=
 =?utf-8?B?STh0OEdPVVdEYWFXcFZpU2lMWk5zblpDYzZmazlaYVRyZFNXZ0JxbldIYm96?=
 =?utf-8?B?bm1OYkFzVzJOQTR1TXF6VTQyN0RMeDBrdHNGMTNsdWlHZWhEREtMTm9HUGhV?=
 =?utf-8?B?V1ZyWmszbDhVTFRNWmdnMFNXS2VpcmtwdU5VbUkzMk4zd3liYzA3TThsdldJ?=
 =?utf-8?B?eGVnT1o0QTc0K0hoZVJmUGZTdjlCWXlUUDFUY2RwMEdmUFlrMlZMbEYwY2RN?=
 =?utf-8?B?YUdhMEVKZE9ROHA1YzlDdG55NGpUbUlvOStheHo1STBDRVl0aU5tdzBGc21q?=
 =?utf-8?B?UStiUXc0TC84eHBHYVdGeW9wT1pFSWNYRkloMk4xckRZZGRsU3hQdUZMQ3Zo?=
 =?utf-8?B?WHlGaktTbC96Zk05amd3YWZEbzNUSHEwWm5wT2MrdWFGaDFxcllHTERZZ2hS?=
 =?utf-8?B?YzFWOGhKcUhoL1J4MFpEMk12bGhDQVJiVnlkclEyWFkrRXpFbDlQTStVeXRS?=
 =?utf-8?B?U3o2MmNBbEd3TUJoUlZ1Y0JxWm1yaHMrMnlxZEM2Uyt4QkZHV2F0OW5rZytr?=
 =?utf-8?B?NVhidWltODBORVV3VG5mMjR1cG9tUllGMkdHNEVzeDFZYzFhcjZkS0J1OXg5?=
 =?utf-8?B?bkpjdVowcWVpZXRieDRxVUFQYUdTTmg5UGdzeGdLWU96bmNtMnB3ci8wWXVT?=
 =?utf-8?B?d000SjJTeFR1aGk0bk1seFl2UFNSZmp1d0lsMmxvK01FQTBVWGlNMlB1VjRw?=
 =?utf-8?B?cXBNNzNEQ1Y2ZDVhcWNJTVJzcklGbFJ0U0I3WUJYR0hMalRhR0daaFhDcTlN?=
 =?utf-8?B?M3EyaXpMTFQ1bm9rR05yd3FDMXVXdTZsajBxVWxxZTVScFBxMkU3S3hVL2Iv?=
 =?utf-8?B?ajZhZXBTK01MeFJSVjJTUFdSMVh2dnFiL3lMSXJjcWZKQTBuMStRRmFHaW4y?=
 =?utf-8?B?YWJUM0JQZm9pVXVCMFBpU216NVA4Y1llSFJxWXZIbG8reExraXdyWDR4TkVC?=
 =?utf-8?B?MldLdGZTLzVac0pObjNpcFh4Y1VCRlhNZkJ5M29Ja0x2QkRucDdEY2FjZExM?=
 =?utf-8?B?VG1aUE1OOTJ1Y09pVFVlMGx3bisxMVFZaHQ5c2RFMi9BQUx6dXQ4MXZSRHJ1?=
 =?utf-8?B?N0VsZTVCR0VSWGpzYk91aVgvZ2d4ek5PUktBOGRKV0JrcWxkeVV4WDlVZzFB?=
 =?utf-8?B?OVIyTkF0UHR4cG5VN0ZjT0dQMEFjYnhkc2dmWjRHNHNTSTJTaTh4SWhyWVBG?=
 =?utf-8?B?ZGZnRzMzRU05ZVZ3S09hRHlSdlF0RXJJdWtnRFplUW1yeTVLbGVWa1BvSDRQ?=
 =?utf-8?B?TytqZi85Y0xRbGlwVEMvbkgyaWdYVUJBQ2VzM0ZnZnBFVjNtL2ROeUVUWGh6?=
 =?utf-8?B?WVZZR2l3Y2xoTy9Tc1ZBUFVxVENWZi9WLzlpR0REYzhveXF6NEoyMHh3U20w?=
 =?utf-8?Q?We6DVzzckG3CZyxp0mtbMqQKO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1dc2f08-3dd2-4135-d35d-08dbb47764f5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:35:09.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vl9tkoOuCxt/viz9L22M7tjRcz9MrFWMPToFhPKxUDz0cdV2wxIT6eL2VpWIh6I2LQwndqI6nCxDOeiMVwK1Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5239
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/2023 10:40, Bjorn Helgaas wrote:
> On Wed, Sep 13, 2023 at 12:20:14PM +0200, Rafael J. Wysocki wrote:
>> On Wed, Sep 13, 2023 at 6:11 AM Mario Limonciello
>> <mario.limonciello@amd.com> wrote:
>>>
>>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>>> from suspend. This is because the PCIe root port has been put
>>> into D3hot and AMD's platform can't handle USB devices waking the
>>> platform from a hardware sleep state in this case.
>>
>> It would be good to mention the PMC involvement, because it is
>> necessary to trigger the issue IIUC.
>>
>> Apparently, if a Root Port is in D3hot at the time the PMC is called
>> to reduce the platform power, the PMC takes that as a license to do
>> something that prevents wakeup signaling from working.
> 
> This absolutely needs to be part of the commit log and the patch.
> 
> If the device advertises PME_Support for D3hot or D3cold, but we don't
> actually get those PMEs after putting it in D3hot or D3cold, that's a
> bug in the device.  "AMD's platform can't handle devices waking from
> hardware sleep" isn't specific enough to help future PCI maintenance
> because "hardware sleep state" is not a PCI concept.

OK.

> 
>>> This problem only occurs on Linux, when waking from a platform hardware
>>> sleep state. Comparing the behavior on Windows and Linux, Windows
>>> doesn't put the root ports into D3.
>>>
>>> In Windows systems that support Modern Standby specify hardware
>>> pre-conditions for the SoC to achieve the lowest power state by device
>>> constraints in a SOC specific "Power Engine Plugin" (PEP) [1] [2].
>>> They can be marked as disabled or enabled and when enabled can specify
>>> the minimum power state required for an ACPI device.
>>>
>>> The policy on Linux does not take constraints into account to decide what
>>> state to put the device into at suspend like Windows does.
>>
>> I'm not sure whether or not it is really clear what happens in Windows
>> nor whether it is relevant for this patch.
>>
>> The relevant information is that Windows keeps these ports in D0 and
>> that demonstrably prevents the PMC from using a platform state in
>> which PCIe wakeup doesn't work.  Therefore Linux needs to do the same
>> thing, but only if system wakeup is enabled for them (or the devices
>> underneath).
> 
> So it sounds like either of these scenarios would work:
> 
>    A) Root Port stays in D0, PMC selects platform state X, wakeups still
>       work
> 
>    B) Root Port in D3hot, PMC selects platform state Y that doesn't
>       break wakeups, so wakeups still work
> 
> PCI isn't in a position to pick one over the other because it has no
> idea what the tradeoffs are.
> 

Right.

> IIUC, this quirk basically forces scenario A (although a naive reading
> would suggest that we could still put the Root Port in D1 or D2, since
> the quirk only mentions D3).
> 

I haven't done any testing with D1 or D2 as Linux doesn't select these 
states.

>>> Rather for
>>> devices that support D3, the target state is selected by this policy:
>>> 1. If platform_pci_power_manageable():
>>>     Use platform_pci_choose_state()
>>> 2. If the device is armed for wakeup:
>>>     Select the deepest D-state that supports a PME.
>>> 3. Else:
>>>     Use D3hot.
>>>
>>> Devices are considered power manageable by the platform when they have
>>> one or more objects described in the table in section 7.3 of the ACPI 6.5
>>> specification [3].
>>>
>>> If devices are not considered power manageable; specs are ambiguous as
>>> to what should happen.  In this situation Windows 11 leaves PCIe
>>> ports in D0 while Linux puts them into D3 due to the policy introduced by
>>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend").
>>>
>>> As the Windows PEP driver uses constraints to express the desired state
>>> that should be selected for suspend  but Linux doesn't introduce a quirk
>>> for the problematic root ports.
>>
>> I would say "but Linux doesn't do that, so ...", because it currently
>> reads like the quirk was not present which is slightly confusing.
>>
>>> When selecting a target state specifically for sleep in
>>> `pci_prepare_to_sleep` this quirk will prevent the root ports from
>>> selecting D3hot or D3cold if they have been configured as a wakeup source.
>>>
>>> Cc: stable@vger.kernel.org
>>> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/platform-design-for-modern-standby#low-power-core-silicon-cpu-soc-dram [1]
>>> Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf [2]
>>> Link: https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects [3]
>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> The same PCI ID is used for multiple different root ports.  This problem
>>> only affects the root port that the USB4 controller is connected to.
> 
> If true, this seems important, not something to discard because it's
> after "---".

OK.

> 
>>>   drivers/pci/pci.c    |  5 +++++
>>>   drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++++
>>>   include/linux/pci.h  |  2 ++
>>>   3 files changed, 35 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 59c01d68c6d5..a113b8941d09 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -2752,6 +2752,11 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
>>>          if (target_state == PCI_POWER_ERROR)
>>>                  return -EIO;
>>>
>>> +       /* quirk to avoid setting D3 */
>>> +       if (wakeup && dev->dev_flags & PCI_DEV_FLAGS_NO_WAKE_D3 &&
> 
> Why did you pick dev_flags?  If there's not a reason to prefer that,
> I'd just add a 1-bit bitfield because that doesn't require a new
> #define.
> 

There was no strong reason for it.  A 1-bit bitfield struct pci_dev will 
actually make it easier for this quirk to live in a more proper home for 
the situation (drivers/platform/x86/amd/pmc/pmc.c).

>>> +          (target_state == PCI_D3hot || target_state == PCI_D3cold))
>>> +               target_state = PCI_D0;
>>> +
>>>          pci_enable_wake(dev, target_state, wakeup);
>>>
>>>          error = pci_set_power_state(dev, target_state);
> 
>>> + * Putting PCIe root ports on Ryzen SoCs with USB4 controllers into D3 power
>>> + * states may cause problems when the system attempts wake up from s2idle.
>>> + *
>>> + * This manifests as a missing wakeup interrupt on the following systems:
>>> + * Family 19h model 44h (PCI 0x14b9)
>>> + * Family 19h model 74h (PCI 0x14eb)
>>> + * Family 19h model 78h (PCI 0x14eb)
>>> + *
>>> + * Add a quirk to the root port if a USB4 controller is connected to it
>>> + * to avoid D3 power states.
> 
> I want to know whether this is D3hot, D3cold, or both.  Also in the
> pci_info() below.

Linux doesn't select D3cold for this root port, but it should affect both.

> 
> Also, do we have some indication that this is specific to Ryzen?  If
> not, I assume this is an ongoing issue, and matching on Device IDs
> just means we'll have to debug the same problem again and add more
> IDs.

This is why my earlier attempts (v16 and v17) tried to tie it to 
constraints.  These are what the uPEP driver in Windows uses to make the 
decision of what power state to put integrated devices like the root 
port into.

In Windows if no uPEP driver is installed "Windows internal policy" 
dictates what happens.  If the uPEP driver is installed then it 
influences the policy based upon the constraints.

Rafael had feedback against constraints in v17, which is why I'm back to 
a quirk for v18.

This issue as I've described it is specific to AMD Ryzen.
I expect it to be an ongoing issue.  I also expect unless we use 
constraints or convince the firmware team to add a _S0W object with a 
value of "0" for the sake of Linux that we will be adding IDs every year 
to wherever this lands as we reproduce it on newer SoCs.

> 
>>> +static void quirk_ryzen_rp_d3(struct pci_dev *pdev)
>>> +{
>>> +       struct pci_dev *child = NULL;
>>> +
>>> +       while (child = pci_get_class(PCI_CLASS_SERIAL_USB_USB4, child)) {
>>> +               if (pci_upstream_bridge(child) != pdev)
>>> +                       continue;
>>> +               pdev->dev_flags |= PCI_DEV_FLAGS_NO_WAKE_D3;
>>> +               pci_info(pdev, "quirk: disabling D3 for wakeup\n");
> 
> I don't remember seeing any evidence that this is a USB4-specific
> issue.  My guess is that it affects wakeups from *any* device below
> these Root Ports, since I assume the PMEs are bog standard PCIe
> events, not anything special about USB4.

The hardware team describes the issue to me as specific to how the 
internal interrupt routing works with the USB4 controller connected to 
this root port.

> 
> It sounds like this is only an issue when amd_pmc_s2idle_prepare() is
> involved, right?  The PMEs and wakeups work as expected until we tell
> the PMC to do its magic thing?
> 
> If so, shouldn't this be conditional on something in amd/pmc.c to
> connect these pieces together?  Looks like amd/pmc.c only works if
> the platform provides an AMDI0005, AMDI0006, etc., ACPI device?
> 
> I think it'd be nice if amd_pmc_probe() logged a hint about it being
> activated.  

I personally really thought the constraints approach from v16 and v17 
did this well and would have scaled effectively.

As Rafael has opposition to it what I'm thinking from everyone's 
feedback today is to add code into amd_pmc_probe() that twiddles a new 
bit for the matching device in `struct pci_dev`, maybe called 
`no_d3_for_wakeup`.

Then as we add PMC support for new devices, we can add a new line to a 
switch/case to set that bit if necessary for the platform.

> AFAICS it only logs something on errors.  This has been
> incredibly painful to debug.  It looks like the PMCs do very subtle
> power management things, and it'd be nice to have a hint that there's
> really fancy stuff going on in the background.
> 

Sure I'll add a dev_info or pci_info when it's set.

