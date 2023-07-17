Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E65756995
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 18:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGQQvl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 12:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQQvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 12:51:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1422D1;
        Mon, 17 Jul 2023 09:51:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFg3VWq8aMtS3hzVnG4eL39oAASGHqQ50qgqctNWa9D9NKO5jcEdIDB4KCFaoneprHoH2W+OVZBCKBv1fICMsrvWpCLNiWIF6INB+ACUVGYTynIPuI0SmeIYK8dcYCRgZyDywUTvTbaF50t2FUxRMQIpqF3faf3KXkYMhb0D8LCw3fHzKebr4eKlEZmzaMKjTN6DTmX6JK/awrf8p4iUXu+WEt2spKqkOSPC/gKVDozq5r+6bVLWYRMWnCAuPmWUtGKobiVNSqt81ldFY1sCYI4QbFP6EaYX5Drmr/YaSoDzjYdLicAyc1g1pEzG41L5lkdqfaFH6fScTHerIfouYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgfErk+9KAkb4ooO7HiJBpbK3jt5ddPbDs7QbnjBJe8=;
 b=Rk4X7VYsV3o41QsE66sbTbLkugEyNmVpXZW1D5U6SBwxgEcEzQuDza3gleP1mwIEOwNHtk90t7CJlbzz4U47xgTQ1ipE/Ox3+l5ngcw7vGT1Y7m+vKiQFSVnNzb/vHdRwFQ5YxNLvwn5PWxkWATIxKuErxE4Yl+IpdIZ6oEBQRlxjAS1FDFs0RiquCXtK/wdFR/q0s9H57ovLMOuy+fz5CMWa/70ffbETpxI0UHAg9eSfcRdvtPKT7+nIiEpqQZGjgJ3SP+csHlz1Y5moR6M4gQZhslEIc4p+An6vBkZ+T5NThrfVPmzVEJmRg4K1ROiRim+Kb5rdi8xQfQ5k4dANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgfErk+9KAkb4ooO7HiJBpbK3jt5ddPbDs7QbnjBJe8=;
 b=fH6MpAhltexfXJaQkxqdv6dtIewEhcdOvgp8GgDGvmp8rYFVNPF3L0HB1tCCV21uHffApSEYb8PR2hSHb+DrBGEm8WBVuVQrxtBW96XCXv80MXjODPEwH99ndI4ej7GNSvIHXH2T6Zh7jFaU/+66GjC9QYi79WrcP4lGaT+HpSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:51:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:51:35 +0000
Message-ID: <dc44cb41-b306-f18a-c9fc-3d956777f722@amd.com>
Date:   Mon, 17 Jul 2023 11:51:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] PCI/ASPM: Enable ASPM on external PCIe
 devices
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Vidya Sagar <vidyas@nvidia.com>,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        intel-wired-lan@osuosl.org, bhelgaas@google.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20230705200617.GA72825@bhelgaas>
 <9d1095ab-23e5-3df3-58d6-b2974f87ee72@amd.com>
 <CAAd53p7L27dkzwb_Q9vhENhBye-JTcx2AuCG_YXAgb0F6MG-9w@mail.gmail.com>
 <60b2f5fb-8294-d104-16d8-0acfc70426c1@amd.com>
 <CAAd53p42jiTCOsRZwEY0jtBejMDs1FbTOBNEknijnVNk3ENxuA@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAAd53p42jiTCOsRZwEY0jtBejMDs1FbTOBNEknijnVNk3ENxuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:806:6e::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 53026471-7475-4e40-94cc-08db86e6148a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DB2NZsW6P1iOJ0es5T1n+E8MDWI2XyeR9Z8RjMD3w2axA5l9HIu9PPcSKbXBEyd1ID0JAM3oX8LO/2TobKO0pBnQICltBiQ3lDg3qH+xUT8y0QCXpQ5e5oYday2HyUuMrjCdSOneBbuAUOKLUmILQUN6SiHagyiavgDlR8c7cglpmk9/jOAoeFBP6TeRP6NlUSnINrGs8if/s19ubtvbkl97nwHPkw0w3xPhmWt74z0K4Sa3h9XQ3keD9it7zm/TR2NRYF3sRJYKrdS6f1MZIWMwcZMIF39ob3xKEQPd18a/r+h/mHsfB7cxNoioPBTFI1OCmPmD0C0JhAC8h0Hm8paB/cSgfs4amPQefvVkgRo8wTKNRom1J/Mg9RdCex2wXUIebg9TJe1th995w9UYVJUhO+Nr1YPBa92t1EwbG/OVxxxZ0GQ0MWmIS08xmx0T3uMm4HdFGhBegdWj+ahzqVZNodiGbAz/AFNOjz0vLJVmq0qStfimdSkGVa15b6oj68+b6QjuaNwhhS8VUpXSHTqhHycg2ZtMqnhhfGMhL/TpcH2XQMeXc8CEl9a9sEbIX7u+2gdmjU2lovZ82aDn9POHfQhfYZCsnxOpApYKMa6JWm3dZoLMKzcF6GVCvqCdC7uxW3GvQpz1wE+wTzj+rQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(31686004)(478600001)(6486002)(6666004)(45080400002)(110136005)(54906003)(83380400001)(31696002)(86362001)(2906002)(53546011)(186003)(36756003)(6506007)(6512007)(966005)(2616005)(316002)(26005)(66556008)(38100700002)(66476007)(66946007)(41300700001)(4326008)(8676002)(8936002)(5660300002)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MENiVTZNNTY5UDUvUC9Eb3ZoWGJaQVJxbG43SlkxTG4rVzg5d2tGQUQ0djNm?=
 =?utf-8?B?b0F2bXljYlVabHdkSGJNMGNnMENSQXBGU0JpaG9HdkFqZU9DK1gwNDM1UWZI?=
 =?utf-8?B?alQ1L1IwZ0NsTlJ0ditRVlRJNURVYm1PcXFCT2Y5anZ1eGhSS3NYR01WcVYy?=
 =?utf-8?B?MjVCeklIMXkzbG5walVueUQxNXlQRURJS1JuSzRiUkpwMmJCWWZybWpJWmhV?=
 =?utf-8?B?UGExVnVqOC9yNCttNXloMUxNcmlUOWJyUnBUMVBHMlUxcUMvNDFKR1JPOWMz?=
 =?utf-8?B?ek5oa0NpcllUS0N4Y000Rm9sV29HbVFYMFJyN0NWVFZBd3E0bE5mSXVMWksz?=
 =?utf-8?B?eTBUTndnK3M5WFRjZ1ZJVWNpcGZOSVJzZ05tb2tVMFFOZmxkZ1NNS0N6dVhw?=
 =?utf-8?B?eG5CVFJPWmxpS0kyRFI2WUhSbFBHTnJGbXBOMXVNcndkc1ZZMml2WUdsam5Y?=
 =?utf-8?B?eUtRN24zMUJUanhzWmJPdUxMVUJHWWxpRDFsb2dVSk9TdEQwVVFQZzNKbXRk?=
 =?utf-8?B?NHlmcCs1Zmk5SEJRTWVNUklyRWlpMmRlYSs5YkV0ZTVZUXpsYUNtZGZSUHQx?=
 =?utf-8?B?QVFmMHJ4bVNSMWxlM0tBQmt1SVF0Q2RRNEVKNFQrVS9hcmZiU05FUVJFYXd1?=
 =?utf-8?B?bktoeXVaM2dndVVraHozY3J1dkp1ZzlkbkRXMUh4ZDhzREVZZnhQT1VMeDJU?=
 =?utf-8?B?Yk1WVnd6WEZxbFZWanFmUWFtVmk0enorMmJyd1FPckt3aVhPMUFSbWIrQnU2?=
 =?utf-8?B?aDFLOSswcTZ1OGluVjM0Q2ZDd2x0TzgyQ2JtMlhxbkI1aUcxZHJTVXZDVndE?=
 =?utf-8?B?Z25kSTdCQzBzL2FLcGVPdi9GeVNtTUJSZDBwaXpqa1JMSjFNb0lkK0ZMZ3M4?=
 =?utf-8?B?RHB3azZGeW5xcDAydENiL3p3K2V6SGVaSW5ER3BZc09VZGN6cU5CS3IrUXp1?=
 =?utf-8?B?dmxoZkIxRXVqU0dzaVpNbzBMVk9DOG91YllJM3JwdWpVQmNBWXZaYlNueGFo?=
 =?utf-8?B?M0hWZ1dhUDlyd0h1NjdLcGc4a3AxRjlSNUNxZFA3MHZZSUJXc0IxSzdZRmVO?=
 =?utf-8?B?V3ZSMEpiUmhNTWVNNE9PMGhhZjc5MjVYUStlVHRIUXhqMGwvNEV2VTVpMWhW?=
 =?utf-8?B?THM1Nk1YN3JlSzhvRUFDdFNuNWIyNE1BU28raGZ3UlFVaCtDVTViNjl1aW9U?=
 =?utf-8?B?WC81TnN6Q2U4ek9ZUGlGZGtMNWxzYllqRVUya0tuMmZESWVZTmJLQ3NUZWEv?=
 =?utf-8?B?NGVtc2V3ekw1bkFqVWJqT3RMcERqSkVpQndsWVhwTjM3MzFUTk9ySXpwQ3Zn?=
 =?utf-8?B?TVJRem9wRmV3dXBObGt3RFNhUVVaaGtkb1p4aVFUcGhhU1FHRVhwSXljVjNT?=
 =?utf-8?B?d0RNUk8reGFhbEFMKytLdkZXSENDZUNZYUtFVFVsbFlBYm02VVdmbGN1Wndt?=
 =?utf-8?B?THNzamdHbnliWXJtQU5tNDFmTzRtdWJ1ZmRuRCtCOEIzdnZGZ2g4S2ZMOWgw?=
 =?utf-8?B?WSs3MXlJVk16R3FuejgwODRTcUZSYzJOdkVpSEVpUmxtdVE3WXZyOVVueWNh?=
 =?utf-8?B?YUd3R3VRRjE3clY3QTFsOFZZSkNoSGdRY3VnRkxaL1RWcXdVSXFlYUdtV2Jl?=
 =?utf-8?B?NU50V0h4WG1Kb2pZMGM2d241NEIzdGFPUjE5Tk0wWXdVcFZPaHhOeEJ3Y1ky?=
 =?utf-8?B?MnhRcHV3OERER01jNHRsOUIwWlV3bkNZS3ExVzA4Vzk2WENNbzl6SHhUQTVa?=
 =?utf-8?B?Q0xDUG52V0VsM01rNnhlaGowdVVhOGhyamJUK0FqTW9TMnAxSHdPMXdQemJK?=
 =?utf-8?B?QVNrNFVGbGJMY1VCY0puWjlOU3Zvb3VhQVMrVHJ2M1hHUzRXLzZhOXJvSndr?=
 =?utf-8?B?UXlqK2NwQ0FHT085M2JTc25XZERHcFo2YmVsVUFsUmtuWGNwNE9FL09HdUpr?=
 =?utf-8?B?TXphQU9rZnZNSGVBMUpoSUhUNEhpT3V4Y0FJU1dSZTEzMmtaMk56YzQ4c1hp?=
 =?utf-8?B?M0hlSXFlKys0YVJzQ2EvNzVMTmlhL2pJbVVnQXdLaUpxVEZYMWR1VXc4c1VS?=
 =?utf-8?B?dnRXQ0UzRWpLcTZlUGZRUGt5c1BvYi9MNFQzTFo3WENkTzBQV3NqVU1YOGVX?=
 =?utf-8?Q?jttqk0ibLLhd2894nFHeORSw6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53026471-7475-4e40-94cc-08db86e6148a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:51:35.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1ZQkg4PjP+88hbwaoyXLuEk5zOVtFUTAt4jefRTjPrxuDAL9g7S/dEeX/qgJRUqiMuuze8gN81ttQvsVkgCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/16/2023 10:34 PM, Kai-Heng Feng wrote:
> On Sat, Jul 15, 2023 at 12:37 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 7/14/23 03:17, Kai-Heng Feng wrote:
>>> On Thu, Jul 6, 2023 at 12:07 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> On 7/5/23 15:06, Bjorn Helgaas wrote:
>>>>> On Wed, Jun 28, 2023 at 01:09:49PM +0800, Kai-Heng Feng wrote:
>>>>>> On Wed, Jun 28, 2023 at 4:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Tue, Jun 27, 2023 at 04:35:25PM +0800, Kai-Heng Feng wrote:
>>>>>>>> On Fri, Jun 23, 2023 at 7:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>>>> On Tue, Jun 20, 2023 at 01:36:59PM -0500, Limonciello, Mario wrote:
>>>>>
>>>>>>> It's perfectly fine for the IP to support PCI features that are not
>>>>>>> and can not be enabled in a system design.  But I expect that
>>>>>>> strapping or firmware would disable those features so they are not
>>>>>>> advertised in config space.
>>>>>>>
>>>>>>> If BIOS leaves features disabled because they cannot work, but at the
>>>>>>> same time leaves them advertised in config space, I'd say that's a
>>>>>>> BIOS defect.  In that case, we should have a DMI quirk or something to
>>>>>>> work around the defect.
>>>>>>
>>>>>> That means most if not all BIOS are defected.
>>>>>> BIOS vendors and ODM never bothered (and probably will not) to change
>>>>>> the capabilities advertised by config space because "it already works
>>>>>> under Windows".
>>>>>
>>>>> This is what seems strange to me.  Are you saying that Windows never
>>>>> enables these power-saving features?  Or that Windows includes quirks
>>>>> for all these broken BIOSes?  Neither idea seems very convincing.
>>>>>
>>>>
>>>> I see your point.  I was looking through Microsoft documentation for
>>>> hints and came across this:
>>>>
>>>> https://learn.microsoft.com/en-us/windows-hardware/customize/power-settings/pci-express-settings-link-state-power-management
>>>>
>>>> They have a policy knob to globally set L0 or L1 for PCIe links.
>>>>
>>>> They don't explicitly say it, but surely it's based on what the devices
>>>> advertise in the capabilities registers.
>>>
>>> So essentially it can be achieved via boot time kernel parameter
>>> and/or sysfs knob.
>>>
>>> The main point is OS should stick to the BIOS default, which is the
>>> only ASPM setting tested before putting hardware to the market.
>>
>> Unfortunately; I don't think you can jump to this conclusion.
>>
>> A big difference in the Windows world to Linux world is that OEMs ship
>> with a factory Windows image that may set policies like this.  OEM
>> "platform" drivers can set registry keys too.
> 
> Thanks. This is new to me.
> 
>>
>> I think the next ASPM issue that comes up what we (collectively) need to
>> do is compare ASPM policy and PCI registers for:
>> 1) A "clean" Windows install from Microsoft media before all the OEM
>> drivers are installed.
>> 2) A Windows install that the drivers have been installed.
>> 3) A up to date mainline Linux kernel.
>>
>> Actually as this thread started for determining policy for external PCIe
>> devices, maybe that would be good to check with those.
> 
> Did that before submitting the patch.
>  From very limited devices I tested, ASPM is enabled for external
> connected PCIe device via TBT ports.
> 
> I wonder if there's any particular modification should be improved for
> this patch?
> 

Knowing this information I personally think the original patch that 
started this thread makes a lot of sense.

Bjorn, what are your thoughts?

> Kai-Heng
> 
>>
>>>
>>> Kai-Heng
>>>
>>>>
>>>>>>>> So the logic is to ignore the capability and trust the default set
>>>>>>>> by BIOS.
>>>>>>>
>>>>>>> I think limiting ASPM support to whatever BIOS configured at boot-time
>>>>>>> is problematic.  I don't think we can assume that all platforms have
>>>>>>> firmware that configures ASPM as aggressively as possible, and
>>>>>>> obviously firmware won't configure hot-added devices at all (in
>>>>>>> general; I know ACPI _HPX can do some of that).
>>>>>>
>>>>>> Totally agree. I was not suggesting to limiting the setting at all.
>>>>>> A boot-time parameter to flip ASPM setting is very useful. If none has
>>>>>> been set, default to BIOS setting.
>>>>>
>>>>> A boot-time parameter for debugging and workarounds is fine.  IMO,
>>>>> needing a boot-time parameter in the course of normal operation is
>>>>> not OK.
>>>>>
>>>>> Bjorn
>>>>
>>
