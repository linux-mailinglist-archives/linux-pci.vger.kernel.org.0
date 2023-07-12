Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56631750D95
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGLQJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jul 2023 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGLQJY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jul 2023 12:09:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1F134;
        Wed, 12 Jul 2023 09:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baCqhCE40dd5UT8qFM70SpnkkHMVBxgf0IJmk9glcH030xgOeX7Ou5iwApnTJW6mZN7VigBttNWMsJqcNFd2oSa16jKfmGwoDMJNMMX20VVWRywAyAjdrVnE2RUz8GqdZzZMhal3yDdMxch3WD54dykizSdtLVZ7SzosuQrYvZxSJyhXMyXAT6WGDGsofU+g868nlyMvHU68JxV+HBZUKzVOHMcK9TImS9KeLps557Gn1CBE1VZ+XRkZVz2bTWVF4ew1ovtJCEu8vfFkvymEWxuLAQUnOBn1yv51mWo4BLEEHTYtmPV3ICwrS5/KahMTDN/DsKkqR/h/ppWLZDUT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kUpXtAaaScJs3ySZQCRkXEo6zIDB6XmpVqY2dgRW+4=;
 b=azkAP8j0jRarT8sDF8KD88ossVcpKKJkfLXv8R9x+ZUfXojzprHtvL2JSa0HNRsv32jJ1WCJ5YtFghjNEZKIgNh3zuydRgnvYUTpflmr9eSNeLe+1c6IFW2zLaIzJh4fUp5+JAdknCeFk76Ww+srf5UbimUYBIQM22jT9O8WcWsf9X+zvHyquqyxXXRHVCwZvOwQyetUuA/BK3pWonMAcAnPZIibTLYbvbyoxvarORhsp+vbmKBXdw9bxoUOfErunLvhce95dOMsTqv3cVDvJuQVMci3V35kdlu/J82q9ESAEEQz1Nz6ZStlYOQ1oSm7U2YZRVOFUWVaEFjRjp0nTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kUpXtAaaScJs3ySZQCRkXEo6zIDB6XmpVqY2dgRW+4=;
 b=t8fi5mm4HctZwGDRgnKVNVLONWpnpqiUMIXM1q07Kdcz8MBtaH77GVy1xVGcf33ufrvU0aO18yFas4xyiVOJns+B0F2IYWj6QXUV2Jj4Yh5JSUJ4lIe3Vkz7thzJFIUhGmOFnzyaeDltZOIIYa2zcK30noecisJCwZd5IDHZtfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Wed, 12 Jul
 2023 16:09:19 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 16:09:17 +0000
Message-ID: <a309e3fe-b1f9-e269-cb97-8af87c8d483b@amd.com>
Date:   Wed, 12 Jul 2023 11:09:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/2] PCI: Don't put non-power manageable PCIe root
 ports into D3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Iain Lane <iain@orangesquash.org.uk>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230711221427.GA250962@bhelgaas>
 <b82a50eb-8182-84ca-5b24-dbe8870fa871@amd.com>
 <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0i6PviqW7u3i8hmvSCvR_VHqP-mWRy3Da8Ev_1vi9qBQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::6) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4522:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ea24e5-f743-41d0-471f-08db82f25812
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: df32jW7HYjuaW0peKR14RDb/H/Q40nc4aYe4nrAVYCsCsgoJX6yWwqlAZnbZEBDvmgJQ/eg3z5xp8IVBIuWQnctkRgBhAb2wCLloEtUu1bhpzNLhoAK+DEOiGgJHJ4kq8PIACxrcaS15dvUASVAlEH2x9+6WlKnwTb6dEz+sVHsNH+ABDMSzh/bO7azHCyIE4PuXJKKbpm8u3V0/c2/FQnhqZJV8F+n+iX/Vt03qNiC1AIvp4XNvPueJBNbFaoEgdbycRxdKH/Iwst8COdoFNldxFT9NRzHTjtCOFWyz4NjGx+aAptUCnuyVRc5DWox3vCQhTGl0qW9ZyafOHo7COA/+P6uyWVkRpdBl0auW3eaqQg6SyJEmnoQPO6a/6Q2RRxp4cd5CKWqSuTQH5uef4rHBHpeA7JHFR7D1Qf+FQ8dyFo6B2Ay3wJ7Mft5PltmxRM4hqKwgP84HfiX2lUt6bBIZ5ISeFpZoGfhGcM426whPdIJzwkwnfpm9jyRkQit+gW4Wj36r5iXgW2Bsian7OQYBdVmpS2ine6T1GnjJSmcRn3auhhmcKttMe8Agdc0mz1xR+sNwqPJ+6ZiY+BC/QIf77m5kDoRY3lbT1LbxVH8Ps/yRXuZW14l0RTYH8bP2TLw3XdqC/ILQ0Vvxn7LlVJG18gVsRd2LPZh+qp57iqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(6486002)(478600001)(83380400001)(86362001)(966005)(6512007)(6916009)(66946007)(66556008)(54906003)(26005)(4326008)(38100700002)(66476007)(53546011)(186003)(66574015)(6506007)(31686004)(2616005)(5660300002)(7416002)(2906002)(41300700001)(8676002)(8936002)(316002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2JUUC92VnlzdUlBd2owQ2FrdGx3VkFNM1NrOURJdW5QWmliQVc5RmY4OW1K?=
 =?utf-8?B?MVpZTlpzOFJNTWRFaVJMbzF5QmtsOGNZN2trd0JPVnZDUG51OFVXOFovRyti?=
 =?utf-8?B?NEhwSkdleVViWTVrbFJ5a2FVeGlrNlhjckl6VjNTaUVGb2xzVXExVnZoNmxy?=
 =?utf-8?B?cms0UjZUNTAyZ1JscTVUa1dvOHFOS3ZmS1ZEbkttc3lmYkFMeUtlVk9nemR3?=
 =?utf-8?B?aW8wbElhT2VRUmxzekhTMVV5NjB0UjhYcUdFb0g4WTJwNUM4MUFDck55dG5p?=
 =?utf-8?B?SEtldGZCWTJXUlk3RDJJQ3Z0ZFFvVnd4UzVPWlhHcEVTYkdPZWxmczJubjBH?=
 =?utf-8?B?R1lCRWZ5clcyMGdEY3Zkekt3Q3dDbHpoYldXQmNxb3BueWx2VjRpU2liRW52?=
 =?utf-8?B?ZTU0NFEzYnU4cWVVRnZtR2VFYWF1eDlvVTBaUW1iWGFyZTNLdy9JdW5jby81?=
 =?utf-8?B?eFhYL0IxRzY2eEFEWExrNURHK3ExR2lBVnRkZDFlQ0duck54NEJYcmRlbzFB?=
 =?utf-8?B?Zm9vNTQwWkMrOWRDeHlrYWkzVDE4SVlVYkM0MFJ6cVAzT0ZuM081ZUl1bEZs?=
 =?utf-8?B?ck1aanl4cXo2L0YrR1JXVFc5djFMczJNRDUyL09VQTYzNkNQQW5VWU1vTFVJ?=
 =?utf-8?B?ejNraysxUHMxamcrNHhqOFQ5T3JYRzkvQzJCR05FRjJJVVBiY2pCMTZ2NzZa?=
 =?utf-8?B?NnBDOW4rNG4zeUtCamJUNlE3NHB2cldJcmVlT3lWTzJVZWJkRmlKS1FqNVFZ?=
 =?utf-8?B?bGJrZ283MnRTbG1ka3hwYndXQk1qTUxOK0FKbWFzK2R4WGtjUXlzZ3p2NnVN?=
 =?utf-8?B?RFliNVJUWXhObU1lcUZTVmNWMnQ3MTA0a3pjMVVMM3FyTUpRNllzWEdVbzVr?=
 =?utf-8?B?M3grekJtVWJxUFJTZERiQmlDemdYU1hoU2VocFlaRFpFd1BBU1o1d281aUxR?=
 =?utf-8?B?Wkc1M3dqV2RGaVR3R3MxTjN6RVhUWEtPdHozV3pybWljUjNDbW55NXhNaUtB?=
 =?utf-8?B?S2JxNm9Ca09oT1VmUjZoaERRTmwxZC9KRzI5cStRVmRzb2lPMWIrOGhIMWJQ?=
 =?utf-8?B?ek5nR3BWMjdRMXUybmpkVTA1d1FPOUNRMm5iRStDR3RRak9ieXp1QUhhK20w?=
 =?utf-8?B?TEppM3krVWZTQkR3MUJyUzJvUW5QVllyWGd4YmJ4UDRmeTRPYkJQd0UyaW9H?=
 =?utf-8?B?TTZJZEhIVGNCWlkxYWJCb0FrQS9oNDllM3lNcDNNZzM5RldZVU9yMFhTTFB5?=
 =?utf-8?B?azdYcHcvRmJqQ0I5UlVoYnNtb1A4bzNPUFNybndFTERvc2txd2NzUEVtcnE3?=
 =?utf-8?B?YytaVDBGbDFyYXFDRkxQQkE2cVB5RXdCSkVsdkRueXJ2OGtNMkZjYWZtcjFX?=
 =?utf-8?B?dnpBUzhPZHpKTTZyeHlyRjVVcEVWVmVLLytYem4rdUpQbk9uWlpZUnZhVnZy?=
 =?utf-8?B?VGxUM0ZSYTE1dGRQZkNWQ0RHZGtmakV0RTZGZU0rU01NTEk4MXcrZ3BVNXds?=
 =?utf-8?B?azNBd0FTZFpibEx0MWJibURwM09FMHZkallyeHNtZFdEZkpNUXZlUFhBT2JU?=
 =?utf-8?B?bFplbytHaUNORzZWRmg1TkJtK3NYbTJhSEVIT0c0aEx2Mms0dEh3cU5UNEN6?=
 =?utf-8?B?STF2ZzVHM2p1bFlJa1JvemZlZ3pQeTRVQ2dlRlhYa2Fsb2tnUk1mMjlZakJw?=
 =?utf-8?B?OHZ5aC9pL0k2MTMyT2YxcHhhQXZoU2VEeWtxUmlHN3dzcEpoaDcyRzlkTDFi?=
 =?utf-8?B?S1N1bHBNT25xWW95WU04MW92ZFdMOU5EbjZKT0dOL3AydmRmY3lBTEF5aUhn?=
 =?utf-8?B?NlNPemRNa2ZMNXhaaWhOR3BZbGRnZ2lTS2VyK2RFczVuTWFKVng5cGZXMlRI?=
 =?utf-8?B?Yzl6d3B2S2JObE01NWp3TzJRSWtHRjFpT2luYnhvU1R4R1hRVHUyYXBUcHhF?=
 =?utf-8?B?bHpDMWtzOTZvY0xucDhuaVpESlR1UktDNmpIYjFDWW9POXo2TndCamR2N2lF?=
 =?utf-8?B?cktNdkFCeU5BZmZodWZIckJuZWFFd0l5TDkySStGbWZhcUhabmFmWFBhalp4?=
 =?utf-8?B?dE0vMjNtcWZkQUc5K0N5ZFZmVWh1QUQ1dUtvSUpvR2lra3g2M1BYVHI2UGRR?=
 =?utf-8?Q?glB9dpj8hraA4ZEWtCawGktns?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ea24e5-f743-41d0-471f-08db82f25812
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 16:09:17.8965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mciU7qSMuYf4D0NScXhR1Ni7G7khEIlP4pu8YR+kdt7th5xu8eWXG7IjEHwY6fF0Knve+6GX20jjqL8N+kwyhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/12/2023 07:13, Rafael J. Wysocki wrote:
> On Wed, Jul 12, 2023 at 12:54 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 7/11/23 17:14, Bjorn Helgaas wrote:
>>> [+cc Andy, Intel MID stuff]
>>>
>>> On Mon, Jul 10, 2023 at 07:53:25PM -0500, Mario Limonciello wrote:
>>>> Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> PCIe ports from modern machines (>2015) are allowed to be put into D3 by
>>>> storing a flag in the `struct pci_dev` structure.
>>>
>>> It looks like >= 2015 (not >2015).  I think "a flag" refers to
>>> "bridge_d3".
>>
>> Yeah.
>>
>>>
>>>> pci_power_manageable() uses this flag to indicate a PCIe port can enter D3.
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
>>>> one or more objects described in the table in section 7.3 of the ACPI 6.4
>>>> specification.
>>>
>>> No point in citing an old version, so please cite ACPI r6.5, sec 7.3.
>>>
>>> The spec claims we only need one object from the table for a device to
>>> be "power-managed", but in reality, it looks like the only things that
>>> actually *control* power are _PRx (the _ON/_OFF methods of Power
>>> Resources) and _PSx (ironically only mentioned parenthically).
>>>
>>
>> Your point has me actually wondering if I've got this entirely wrong.
>>
>> Should we perhaps be looking specifically for the presence of _SxW to
>> decide if a given PCIe port can go below D0?
> 
> There are two things, _SxW and _SxD, and they shouldn't be confused.
> 
> _SxW tells you what the deepest power state from which wakeup can be
> signaled by the device (in the given Sx state of the system) is.
> 
> _SxD tells you what the deepest power state supported by the device
> (in the given Sx state of the system) is.
> 
> And note that _SxW is applicable to the device itself, not the
> subordinate devices, so I'm not sure how meaningful it is for ports.
> 
> pci_target_state() uses both _SxW and _SxD to determine the deepest
> state the device can go into and so long as it is used properly, it
> shouldn't return a power state that is too deep, so I'm not really
> sure why you want this special "should the bridge be allowed to go
> into D3hot/cold" routine to double check this.

Because pci_target_state only looks at _SxW and _SxD "if" the PCI device 
is power manageable by ACPI.  That's why this change is injecting that 
extra check in.

> 
>> IE very similar to what 8133844a8f24 did but for ports that are not
>> hotplug bridges.
>>
>>> This matches up well with acpi_pci_power_manageable(), which returns
>>> true if a device has either _PR0 or _PS0.
>>>
>>>     Per ACPI r6.5, sec 7.3, ACPI control of device power states uses
>>>     Power Resources (i.e., the _ON/_OFF methods of _PRx) or _PSx
>>>     methods.  Hence acpi_pci_power_manageable() checks for the presence
>>>     of _PR0 or _PS0.
>>>
>>> Tangent unrelated to *this* patch: I don't know how to think about the
>>> pci_use_mid_pm() in platform_pci_power_manageable() because I haven't
>>> seen a MID spec.  pci_use_mid_pm() isn't dependent on "dev", so we
>>> claim *all* PCI devices, even external ones, are power manageable by
>>> the platform, which doesn't seem right.
>>>
>>>> At suspend Linux puts PCIe root ports that are not power manageable by
>>>> the platform into D3hot. Windows only puts PCIe root ports into D3 when
>>>> they are power manageable by the platform.
>>>>
>>>> The policy selected for Linux to put non-power manageable PCIe root ports
>>>> into D3hot at system suspend doesn't match anything in the PCIe or ACPI
>>>> specs.
>>>>
>>>> Linux shouldn't assume PCIe root ports support D3 just because
>>>> they're on a machine newer than 2015, the ports should also be considered
>>>> power manageable by the platform.
>>>>
>>>> Add an extra check for PCIe root ports to ensure D3 isn't selected for
>>>> them if they are not power-manageable through platform firmware.
>>>> This will avoid pci_pm_suspend_noirq() changing the power state
>>>> via pci_prepare_to_sleep().
>>>>
>>>> The check is focused on PCIe root ports because they are part of
>>>> the platform.  Other PCIe bridges may be connected externally and thus
>>>> cannot impose platform specific limitations.
>>>>
>>>> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html [1]
>>
>> At least for myself when I respin this, here is the 6.5 link.
>> https://uefi.org/specs/ACPI/6.5/07_Power_and_Performance_Mgmt.html#device-power-management-objects
>>
>>>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>>>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>>>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>>>> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
>>>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v6->v7:
>>>> * revert back to v5 code, rewrite commit message to specific examples
>>>>     and be more generic
>>>> ---
>>>>    drivers/pci/pci.c | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index f916fd76eba79..4be8c6f8f4ebe 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3041,6 +3041,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>>>>       if (dmi_check_system(bridge_d3_blacklist))
>>>>               return false;
>>>>
>>>> +    /*
>>>> +     * It's not safe to put root ports that aren't power manageable
>>>> +     * by the platform into D3.
>>>
>>> Does this refer specifically to D3cold?
>>>
>>
>> No, it's intentionally not saying D3hot or D3cold because it's stored to
>> "bridge_d3" which is used for both D3hot and D3cold.
>>
>>> I assume that if we were talking about D3hot, we wouldn't need to
>>> check for ACPI support because D3hot behavior should be fully covered
>>> by the PCIe spec.
>>
>> Right; the PCIe spec indicates that D3hot should be supported by all
>> devices and has rules about when you can go into D3hot like not allowing
>> it unless child devices are already in D3.
>>
>> Naïvely you would think that means pci_bridge_d3_possible() shouldn't
>> have any of these checks, but they've all obviously all been grown for a
>> reason.
>>
>> The value from pci_bridge_d3_possible() is used both "at suspend" and
>> "runtime", but what we're really talking with this issue is is the
>> behavior "at suspend".
> 
> Which is suspend-to-idle AFAICS, so from the ACPI perspective it is
> all S0 anyway.
> 
>>>
>>> Let's be specific about D3hot vs D3cold whenever possible.
>>>
>>>> +    if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
>>>> +        !platform_pci_power_manageable(bridge))
>>>> +            return false;
>>>
>>> If ACPI says a device is not power-manageable, i.e., ACPI doesn't know
>>> how to put it in D0, it makes sense to return "false" here so we don't
>>> try to put it in D3cold.
>>>
>>> But I don't understand the ROOT_PORT check.  We may have a Switch
>>> described via ACPI, and the ROOT_PORT check means we can return "true"
>>> (it's OK to use D3cold) even if the Switch Port is not power-manageable
>>> via ACPI.
>>
>> This feels a lot more of a potential to cause regressions.
>>
>> Something we could do is include the value for bridge->untrusted in the
>> decision, but I'm not convinced that's correct.
>>
>> Another option can be to merge a series of changes like this:
>>
>> 1) My v5 patch that adds the quirks for the two known broken machines
>> 2) Patch 1/2 from v7
>> 3) Patch 2/2 from v7
>> 4) Another patch to drop the root port check here
>>
>> #1 could go to 6.5-rcX as it's riskless.  #2-4 could go to linux-next
>> and if they work out not to cause any problems we could revert #1.
>>
>> If they cause problems we come back to the drawing table to find the
>> right balance.
> 
> Generally speaking, pci_bridge_d3_possible() is there to prevent
> bridges (and PCIe ports in particular) from being put into D3hot/cold
> if there are reasons to believe that it may not work.
> acpi_pci_bridge_d3() is part of that.
> 
> Even if it returns 'true', the _SxD/_SxW check should still be applied
> via pci_target_state() to determine whether or not the firmware allows
> this particular bridge to go into D3hot/cold.  So arguably, the _SxW
> check in acpi_pci_bridge_d3() should not be necessary and if it makes
> any functional difference, there is a bug somewhere else.

But only if it was power manageable would the _SxD/_SxW check be 
applied.  This issue is around the branch of pci_target_state() where
it's not power manageable and so it uses PME or it falls back to D3hot.
