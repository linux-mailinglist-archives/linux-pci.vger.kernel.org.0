Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072B30EE4D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 09:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhBDI1H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 03:27:07 -0500
Received: from halon2.esss.lu.se ([194.47.240.53]:59568 "EHLO
        halon2.esss.lu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhBDI1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 03:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ess.eu; s=dec2019;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=M3xA3MKQI77Tpn1AhziTieD2ac1sWPb3AagIv7pbwOA=;
        b=Ee0P+KgslzTh2ZkQRk503WjBQYBaRTYy9t0Lz/f0ELnBpN4NQ0XFtANb3FCFqEBcL63A+u/Pa904c
         G/ucc+OpyeYzeHC4jiPpTAiqcuemvfbSkFcihqYSbcdHc6sXKyMlMG9WUg1j6+qT5AU74/LSBdVZxK
         4uCg6CLCEUPxsDA7iAwdkrXfp7Y1eVHv7K9up9zzeIi9QUyFPdT/1XYH+wLtsZxbVdICEUGkd5DOPj
         bBQJ2+hEZ4d9OgrqqjrwwgXwMLqu2o+WBdUzgVKEVtPZecZnVCFZNffsfzBvRTdUPsPTEMWQ0XTLUI
         A5ssI1zMkzf5l7G9H8XtIZHmPBCWBsw==
Received: from mail.esss.lu.se (it-exch16-4.esss.lu.se [10.0.42.134])
        by halon2.esss.lu.se (Halon) with ESMTPS
        id a7bc3bab-66c2-11eb-8373-005056a642a7;
        Thu, 04 Feb 2021 08:26:18 +0000 (UTC)
Received: from [192.168.0.6] (194.47.241.248) by it-exch16-4.esss.lu.se
 (10.0.42.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 4 Feb 2021
 09:26:19 +0100
Subject: Re: [PATCH v9 00/26] PCI: Allow BAR movement during boot and hotplug
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>,
        "rajatja@google.com" <rajatja@google.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sr@denx.de" <sr@denx.de>, "lukas@wunner.de" <lukas@wunner.de>,
        "linux@yadro.com" <linux@yadro.com>
References: <20210128145316.GA3052488@bjorn-Precision-5520>
 <de82694ed11f2c8a996d3701da04a8ee87fe6be5.camel@yadro.com>
From:   Hinko Kocevar <hinko.kocevar@ess.eu>
Message-ID: <9fa281a7-a81b-a6e7-8e90-21e4ac058e33@ess.eu>
Date:   Thu, 4 Feb 2021 09:26:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <de82694ed11f2c8a996d3701da04a8ee87fe6be5.camel@yadro.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.47.241.248]
X-ClientProxiedBy: it-exch16-3.esss.lu.se (10.0.42.133) To
 it-exch16-4.esss.lu.se (10.0.42.134)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear,

On 2/3/21 8:59 PM, Sergei Miroshnichenko wrote:
> Hi Bjorn,
> 
> On Thu, 2021-01-28 at 08:53 -0600, Bjorn Helgaas wrote:
>> I can certainly see scenarios where this functionality will be
>> useful,
>> but the series currently doesn't mention bug reports that it
>> fixes.  I
>> suspect there *are* some related bug reports, e.g., for Thunderbolt
>> hotplug.  We should dig them up, include pointers to them, and get
>> the
>> reporters to test the series and provide feedback.
> 
> It never occurred to me to actually search for reports, thanks.
> 
>> We had some review traffic on earlier versions, but as far as I can
>> see, nobody has stepped up with any actual signs of approval, e.g.,
>> Tested-by, Reviewed-by, or Acked-by tags.  That's a problem because
>> this touches a lot of sensitive code and I don't want to be stuck
>> fixing issues all by myself.  When issues crop up, I look to the
>> author and reviewers to help out.
> 
> Indeed, I had only a few informal personal responses [from outside of
> our company]:
>   - some machines have no regressions with the kernel built with Clang-
> 12+LTO+IAS;
>   - NVMe hotplug started working for AMD Epyc with a PEX switch;
>   - Another system with several PEX switches is under ongoing
> experiments.
> 


I reached out to Sergei a while ago about these patches on systems I 
work with. They involve a PEX switch on a separate card (MCH).

FWIW, I find this patchset really interesting and useful in the modular 
systems such as microTCA [1]. In those, up to 12 PCIe hotswappable 
mezzanine cards (AMCs) can be added/removed at anytime. Each can be a 
PCIe endpoint. The infrastructure usually involves a CPU card with a 
PCIe root complex. In addition, PCIe switch is located on the carrier 
hub (MCH) card which handles the PCIe links for AMCs.

At this time, if the system is booted without a certain slot being 
populated at CPU/Linux startup adding a card requires system power 
cycle. Today there are already (minor?) issues with the hotplug/hotswap 
of the cards that are present at Linux bootup hence folks that use these 
systems usually do not rely on any these features; as a result boxes are 
power cycled. I'm not saying it is all Linux;s fault, as the microTCA is 
inherently complex due to modularity and versatility of configurations 
one can have, even without hotplugging. It is also a matter of 
understanding how to configure and use the hotplugging that can be a 
challenge on its own.

Some preliminary tests of this patchset, I managed to run so far, 
suggest that newly added cards are nicely being recognized by the Linux 
and are ready for use without CPU reboot. I currently do not have access 
to the microTCA boxes I use. I hope to be in a better place in couple of 
weeks and look into these patches again!

Thanks!
//hinko

[1] 
https://www.picmg.org/wp-content/uploads/MicroTCA_Short_Form_Sept_2006.pdf

> Providing an ability to quickly return to the old BARs allocating is
> the reason why I keep wrapping the most intrusive code with "if
> (pci_can_move_bars)". Originally I wanted it to be disabled by default,
> available for those truly desperate. But there was an objection that
> the code will not be ever tested this way.
> 
>> Along that line, I'm a little concerned about how we will be able to
>> reproduce and debug problems.  Issues will likely depend on the
>> topology, the resources of the specific devices involved, and a
>> specific sequence of hotplug operations.  Those may be hard to
>> reproduce even for the reporter.  Maybe this is nothing more than a
>> grep pattern to extract relevant events from dmesg.  Ideal, but maybe
>> impractical, would be a way to reproduce things in a VM using qemu
>> and
>> a script to simulate hotplugs.
> 
> I haven't yet tried the qemu for PCI debugging, definitely need to take
> a look. To help with that, the patchset is supplied with additional
> prints, but CONFIG_PCI_DEBUG=y is still preferred. A simulation will
> reveal if additional debug messages are needed.
> 
>>> The feature is usable not only for hotplug, but also for booting
>>> with a
>>> complete set of BARs assigned, and for Resizable BARs.
>>
>> I'm interested in more details about both of these.  What does "a
>> complete set of BARs assigned" mean?  On x86, the BIOS usually
>> assigns
>> all the BARs ahead of time, but I know that's not the case for all
>> arches.
> 
> Usually yes, but we have at least one x86 PC that skips some BARs (need
> to check out again its particular model and version, IIRC that was
> Z370-F) -- not the crucial ones like BAR0, though. That really got me
> by surprise, so now it is one more case covered.
> 
>> For Resizable BARs, is the point that this allows more flexibility in
>> resizing BARs because we can now move things out of the way?
> 
> Not only things out of the way, but most importantly the bridge windows
> are now floating as well. So it's more freedom for a new BAR to
> "choose" a place.
> 
> An awfully synthetic example:
> 
> |                       RC Address Space                       |
> | orig GPU BAR | fixed BAR |                                   |
> |              | fixed BAR |     Resized GPU BAR        |      |
> 
>>> Tested on a number of x86_64 machines without any special kernel
>>> command
>>> line arguments (some of them -- with older v8 revision of this
>>> patchset):
>>>   - PC: i7-5930K + ASUS X99-A;
>>>   - PC: i5-8500 + ASUS Z370-F;
>>>   - PC: AMD Ryzen 7 3700X + ASRock X570 + AMD 5700 XT (Resizable
>>> BARs);
>>>   - Supermicro Super Server/H11SSL-i: AMD EPYC 7251;
>>>   - HP ProLiant DL380 G5: Xeon X5460;
>>>   - Dell Inspiron N5010: i5 M 480;
>>>   - Dell Precision M6600: i7-2920XM.
>>
>> Does this testing show no change in behavior and no regressions, or
>> does it show that this series fixes cases that previously did not
>> work?  If the latter, some bugzilla reports with before/after dmesg
>> logs would give some insight into how this works and also some good
>> justification.
> 
> Both, actually, but the dmesg logs were never published, so they will
> be the next step -- combined with qemu scripts, if it works.
> 
>>> This patchset is a part of our work on adding support for hot-
>>> adding
>>> chains of chassis full of other bridges, NVME drives, SAS HBAs,
>>> GPUs, etc.
>>> without special requirements such as Hot-Plug Controller,
>>> reservation of
>>> bus numbers or memory regions by firmware, etc.
>>
>> This is a little bit of a chicken and egg situation.  I suspect many
>> people would like this functionality, but currently we either avoid
>> it
>> because it's "known not to work" or we hack around it with the
>> firmware reservations you mention.
> 
> The current (v9) patchset became more symbiotic with other hotplug
> facilities: it started to respect pci=hpmemsize etc, and only drops it
> if such allocation is impossible.
> 
> Attention Button for Assisted Hotplug (pciehp driver) was always
> supported. It is also fully compatible with DPC.
> 
> The goal is to squeeze as much as possible even without special
> hw+fw+sw support, when the only available tool is a manual rescan via
> sysfs.
> 
> Serge
> 
