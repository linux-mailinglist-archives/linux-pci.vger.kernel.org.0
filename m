Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0104FBBBE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 14:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiDKMNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 08:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346046AbiDKMMr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 08:12:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77E6429;
        Mon, 11 Apr 2022 05:10:32 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1ndssI-0005vc-NE; Mon, 11 Apr 2022 14:10:30 +0200
Message-ID: <2d6981fd-c75a-ccb0-9299-65625963a9e3@leemhuis.info>
Date:   Mon, 11 Apr 2022 14:10:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] PCI: PM: Quirk bridge D3 on Elo i2
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Stefan Gottwald <gottwald@igel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAJZ5v0g9cg=nJ0yr5-a_phNnJLiU74KrfsULsAEsWBKeRr7HCQ@mail.gmail.com>
 <20220408195342.GA339430@bhelgaas>
 <CAJZ5v0g6ahvQrCKPXTgQANiUYJNByDUvJZ8Zsp7anqeM7EBAXw@mail.gmail.com>
 <b24daa29-ae7c-6e24-ebdc-2fe8e0576a9d@leemhuis.info>
 <CAJZ5v0j=WVOAZQ=nR32OQLtMd4gpWhX0T2M-su+dNdOJ0KgbZw@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAJZ5v0j=WVOAZQ=nR32OQLtMd4gpWhX0T2M-su+dNdOJ0KgbZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1649679032;092a9564;
X-HE-SMSGID: 1ndssI-0005vc-NE
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11.04.22 13:35, Rafael J. Wysocki wrote:
> On Sun, Apr 10, 2022 at 11:16 AM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>>
>> On 09.04.22 15:35, Rafael J. Wysocki wrote:
>>> On Fri, Apr 8, 2022 at 9:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>
>>>> On Mon, Apr 04, 2022 at 04:46:14PM +0200, Rafael J. Wysocki wrote:
>>>>> On Fri, Apr 1, 2022 at 1:34 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>>> On Thu, Mar 31, 2022 at 11:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>>>>> On Thu, Mar 31, 2022 at 07:38:51PM +0200, Rafael J. Wysocki wrote:
>>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>>
>>>>>>>> If one of the PCIe root ports on Elo i2 is put into D3cold and then
>>>>>>>> back into D0, the downstream device becomes permanently inaccessible,
>>>>>>>> so add a bridge D3 DMI quirk for that system.
>>>>>>>>
>>>>>>>> This was exposed by commit 14858dcc3b35 ("PCI: Use
>>>>>>>> pci_update_current_state() in pci_enable_device_flags()"), but before
>>>>>>>> that commit the root port in question had never been put into D3cold
>>>>>>>> for real due to a mismatch between its power state retrieved from the
>>>>>>>> PCI_PM_CTRL register (which was accessible even though the platform
>>>>>>>> firmware indicated that the port was in D3cold) and the state of an
>>>>>>>> ACPI power resource involved in its power management.
>>>>>>>
>>>>>>> In the bug report you suspect a firmware issue.  Any idea what that
>>>>>>> might be?  It looks like a Gemini Lake Root Port, so I wouldn't think
>>>>>>> it would be a hardware issue.
>>>>>>
>>>>>> The _ON method of the ACPI power resource associated with the root
>>>>>> port doesn't work correctly.
>>>>>>
>>>>>>> Weird how things come in clumps.  Was just looking at Mario's patch,
>>>>>>> which also has to do with bridges and D3.
>>>>>>>
>>>>>>> Do we need a Fixes line?  E.g.,
>>>>>>>
>>>>>>>   Fixes: 14858dcc3b35 ("PCI: Use pci_update_current_state() in pci_enable_device_flags()")
>>>>>>
>>>>>> Strictly speaking, it is not a fix for the above commit.
>>>>>>
>>>>>> It is a workaround for a firmware issue uncovered by it which wasn't
>>>>>> visible, because power management was not used correctly on the
>>>>>> affected system because of another firmware problem addressed by
>>>>>> 14858dcc3b35.  It wouldn't have worked anyway had it been attempted
>>>>>> AFAICS.
>>>>>>
>>>>>> I was thinking about CCing this change to -stable instead.
>>>>
>>>> Makes sense, thanks.
>>>>
>>>>>>>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215715
>>>>>>>> Reported-by: Stefan Gottwald <gottwald@igel.com>
>>>>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>> ---
>>>>>>>>  drivers/pci/pci.c |   10 ++++++++++
>>>>>>>>  1 file changed, 10 insertions(+)
>>>>>>>>
>>>>>>>> Index: linux-pm/drivers/pci/pci.c
>>>>>>>> ===================================================================
>>>>>>>> --- linux-pm.orig/drivers/pci/pci.c
>>>>>>>> +++ linux-pm/drivers/pci/pci.c
>>>>>>>> @@ -2920,6 +2920,16 @@ static const struct dmi_system_id bridge
>>>>>>>>                       DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
>>>>>>>>                       DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
>>>>>>>>               },
>>>>>>>> +             /*
>>>>>>>> +              * Downstream device is not accessible after putting a root port
>>>>>>>> +              * into D3cold and back into D0 on Elo i2.
>>>>>>>> +              */
>>>>>>>> +             .ident = "Elo i2",
>>>>>>>> +             .matches = {
>>>>>>>> +                     DMI_MATCH(DMI_SYS_VENDOR, "Elo Touch Solutions"),
>>>>>>>> +                     DMI_MATCH(DMI_PRODUCT_NAME, "Elo i2"),
>>>>>>>> +                     DMI_MATCH(DMI_PRODUCT_VERSION, "RevB"),
>>>>>>>> +             },
>>>>>>>
>>>>>>> Is this bridge_d3_blacklist[] similar to the PCI_DEV_FLAGS_NO_D3 bit?
>>>>>>
>>>>>> Not really.  The former applies to the entire platform and not to an
>>>>>> individual device.
>>>>>>
>>>>>>> Could they be folded together?  We have a lot of bits that seem
>>>>>>> similar but maybe not exactly the same (dev->bridge_d3,
>>>>>>> dev->no_d3cold, dev->d3cold_allowed, dev->runtime_d3cold,
>>>>>>> PCI_DEV_FLAGS_NO_D3, pci_bridge_d3_force, etc.)  Ugh.
>>>>>>
>>>>>> Yes, I agree that this needs to be cleaned up.
>>>>>>
>>>>>>> bridge_d3_blacklist[] itself was added by 85b0cae89d52 ("PCI:
>>>>>>> Blacklist power management of Gigabyte X299 DESIGNARE EX PCIe ports"),
>>>>>>> which honestly looks kind of random, i.e., it doesn't seem to be
>>>>>>> working around a hardware or even a firmware defect.
>>>>>>>
>>>>>>> Apparently the X299 issue is that 00:1c.4 is connected to a
>>>>>>> Thunderbolt controller, and the BIOS keeps the Thunderbolt controller
>>>>>>> powered off unless something is attached to it?  At least, 00:1c.4
>>>>>>> leads to bus 05, and in the dmesg log attached to [1] shows no devices
>>>>>>> on bus 05.
>>>>>>>
>>>>>>> It also says the platform doesn't support PCIe native hotplug, which
>>>>>>> matches what Mika said about it using ACPI hotplug.  If a system is
>>>>>>> using ACPI hotplug, it seems like maybe *that* should prevent us from
>>>>>>> putting things in D3cold?  How can we know whether ACPI hotplug
>>>>>>> depends on a certain power state?
>>>>>>
>>>>>> We have this check in pci_bridge_d3_possible():
>>>>>>
>>>>>> if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
>>>>>>             return false;
>>>>>>
>>>>>> but this only applies to the case when the particular bridge itself is
>>>>>> a hotplug one using ACPI hotplug.
>>>>>>
>>>>>> If ACPI hotplug is used, it generally is unsafe to put PCIe ports into
>>>>>> D3cold, because in that case it is unclear what the platform
>>>>>> firmware's assumptions regarding control of the config space are.
>>>>>>
>>>>>> However, I'm not sure how this is related to the patch at hand.
>>>>>
>>>>> So I'm not sure how you want to proceed here.
>>>>>
>>>>> The platform is quirky, so the quirk for it will need to be added this
>>>>> way or another.  The $subject patch adds it using the existing
>>>>> mechanism, which is the least intrusive way.
>>>>>
>>>>> You seem to be thinking that the existing mechanism may not be
>>>>> adequate, but I'm not sure for what reason and anyway I think that it
>>>>> can be adjusted after adding the quirk.
>>>>>
>>>>> Please let me know what you think.
>>>>
>>>> I don't understand all that's going on here, but I applied it to
>>>> pci/pm for v5.19, thanks!
>>> Thank you!
>>
>> Sorry, but this made me wonder: why v5.19? It's a regression exposed in
>> v5.15, so it afaics would be good to get this in this cycle -- and also
>> backported to v5.15.y, but it seem a tag to take care of that is
>> missing. :-/
> 
> Well, the patch is out there for everyone needing it.

IOW: only those that are able to debug the issue, find the patch, and
capable & willing to patch & compile a kernel.

>  The question is
> how urgent it is to get it into the mainline and -stable, which boils
> down to the question how many systems out there can be affected by it.

If it was a risky patch I'd agree, but for such a simple quirk? What's
the benefit of waiting? Sure, every change bears risks, but waiting can
makes life harder for people.

Thing is: I noticed a lot of maintainer wait way to long with applying
regression fixes (even for regressions that affect multiple users),
which contributes to the huge pile of changes that go into early stable
kernel (like 5.17.2 recently with 1000+ changes). That's why the new
document on handling regressions (disclaimer: written by yours truly)
has a section encouraging maintainer to merge things more quickly:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/handling-regressions.rst#n131

> Since it is a firmware defect exposed, hopefully not too many.
I guess so, but it's always hard to tell.

Ciao, Thorsten
