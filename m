Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8E3ACE58
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhFRPM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 11:12:26 -0400
Received: from foss.arm.com ([217.140.110.172]:42578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhFRPM0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 11:12:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B71D313A1;
        Fri, 18 Jun 2021 08:10:16 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28ED33F694;
        Fri, 18 Jun 2021 08:10:16 -0700 (PDT)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Vikram Sethi <vsethi@nvidia.com>, vidyas@nvidia.com,
        treding@nvidia.com, Jon Masters <jcm@jonmasters.org>,
        mark.rutland@arm.com, linux-pci@vger.kernel.org,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, bhelgaas@google.com,
        linux-arm-kernel@lists.infradead.org, ebrower@nvidia.com,
        jcm@redhat.com, Jason Gunthorpe <jgg@nvidia.com>,
        Marcin Wojtas <mw@semihalf.com>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
 <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <4372c1a8-fa4b-aa5c-a0db-d3843d4a3ec5@arm.com>
Date:   Fri, 18 Jun 2021 10:10:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/25/21 8:12 AM, Lorenzo Pieralisi wrote:
> On Tue, Jan 26, 2021 at 10:53:51PM +0000, Will Deacon wrote:
>> On Tue, Jan 26, 2021 at 11:08:31AM -0600, Vikram Sethi wrote:
>>> On 1/22/2021 1:48 PM, Will Deacon wrote:
>>>> On Fri, Jan 08, 2021 at 10:32:16AM +0000, Lorenzo Pieralisi wrote:
>>>>> On Thu, Jan 07, 2021 at 04:05:48PM -0500, Jon Masters wrote:
>>>>>> On 1/7/21 1:14 PM, Will Deacon wrote:
>>>>>>> On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
>>>>>>>> Given that most arm64 platform's PCI implementations needs quirks
>>>>>>>> to deal with problematic config accesses, this is a good place to
>>>>>>>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
>>>>>>>> standard SMC conduit designed to provide a simple PCI config
>>>>>>>> accessor. This specification enhances the existing ACPI/PCI
>>>>>>>> abstraction and expects power, config, etc functionality is handled
>>>>>>>> by the platform. It also is very explicit that the resulting config
>>>>>>>> space registers must behave as is specified by the pci specification.
>>>>>>>>
>>>>>>>> Lets hook the normal ACPI/PCI config path, and when we detect
>>>>>>>> missing MADT data, attempt to probe the SMC conduit. If the conduit
>>>>>>>> exists and responds for the requested segment number (provided by the
>>>>>>>> ACPI namespace) attach a custom pci_ecam_ops which redirects
>>>>>>>> all config read/write requests to the firmware.
>>>>>>>>
>>>>>>>> This patch is based on the Arm PCI Config space access document @
>>>>>>>> https://developer.arm.com/documentation/den0115/latest
>>>>>>> Why does firmware need to be involved with this at all? Can't we just
>>>>>>> quirk Linux when these broken designs show up in production? We'll need
>>>>>>> to modify Linux _anyway_ when the firmware interface isn't implemented
>>>>>>> correctly...
>>>>>> I agree with Will on this. I think we want to find a way to address some
>>>>>> of the non-compliance concerns through quirks in Linux. However...
>>>>> I understand the concern and if you are asking me if this can be fixed
>>>>> in Linux it obviously can. The point is, at what cost for SW and
>>>>> maintenance - in Linux and other OSes, I think Jeremy summed it up
>>>>> pretty well:
>>>>>
>>>>> https://lore.kernel.org/linux-pci/61558f73-9ac8-69fe-34c1-2074dec5f18a@arm.com
>>>>>
>>>>> The issue here is that what we are asked to support on ARM64 ACPI is a
>>>>> moving target and the target carries PCI with it.
>>>>>
>>>>> This potentially means that all drivers in:
>>>>>
>>>>> drivers/pci/controller
>>>>>
>>>>> may require an MCFG quirk and to implement it we may have to:
>>>>>
>>>>> - Define new ACPI bindings (that may need AML and that's already a
>>>>>    showstopper for some OSes)
>>>>> - Require to manage clocks in the kernel (see link-up checks)
>>>>> - Handle PCI config space faults in the kernel
>>>>>
>>>>> Do we really want to do that ? I don't think so. Therefore we need
>>>>> to have a policy to define what constitutes a "reasonable" quirk and
>>>>> that's not objective I am afraid, however we slice it (there is no
>>>>> such a thing as eg 90% ECAM).
>>>> Without a doubt, I would much prefer to see these quirks and workarounds
>>>> in Linux than hidden behind a firmware interface. Every single time.
>>>
>>> In that case, can you please comment on/apply Tegra194 ECAM quirk that was rejected
>>>
>>> a year ago, and was the reason we worked with Samer/ARM to define this common
>>>
>>> mechanism?
>>>
>>> https://lkml.org/lkml/2020/1/3/395
>>>
>>> The T194 ECAM is from widely used Root Port IP from a IP vendor. That is one reason so many
>>>
>>> *existing* SOCs have ECAM quirks. ARM is only now working with the Root port IP vendors
>>>
>>> to test ECAM, MSI etc, but the reality is there were deficiencies in industry IP that is widely
>>>
>>> used. If this common quirk is not the way to go, then please apply the T194 specific quirk which was
>>>
>>> NAK'd a year ago, or suggest how to improve that quirk.
>>>
>>> The ECAM issue has been fixed on future Tegra chips and is validated preSilicon with BSA
>>>
>>> tests, so it is not going to be a recurrent issue for us.
>>
>> (aside: please fix your mail client not to add all these blank lines)
>>
>> Personally, if a hundred lines of self-contained quirk code is all
>> that is needed to get your legacy IP running, then I would say we
>> should merge it.  But I don't maintain the PCI subsystem, and I trust
>> Bjorn and Lorenzo's judgement as to what is the right thing to do when
>> it concerns that code.  After all, they're the ones who end up having
>> to look after this stuff long after the hardware companies have
>> stopped caring.
> 
> A discussion was held between me, Will Deacon, Bjorn Helgaas and Jon
> Masters to agree on a proposed solution for this matter, a summary of the
> outcome below:
> 
> - The PCI SMC conduit and related specifications are seen as firmware
>    kludge to a long-standing HW compliance issue. The SMC interface does
>    not encourage Arm partners to fix their IPs and its only purpose
>    consists in papering over HW issues that should have been fixed by
>    now; were the PCI SMC conduit introduced at arm64 ACPI inception as
>    part of the standardization effort the matter would have been different
>    but introducing it now brings about more shortcomings than benefits on
>    balance, especially if MCFG quirks can be controlled and monitored (and
>    they will).
> 
>    The end-goal is that hardware must be ECAM compliant. An SMC-based
>    solution runs counter to that desire by removing the incentive for ECAM
>    compliance.
> 
>    In sum, the SMC conduit solution was deemed to be deficient in these
>    respects:
> 
> 	* Removes incentive to build hardware with compliant ECAM
> 	* Moves quirk code into firmware where it can't sensibly
> 	  be maintained or updated
> 	* Future of the SMC conduit is unclear and has no enforceable
> 	  phase-out plan

Well there is another aspect that wasn't readily apparent. We now need 
one of those "linux mode" switches in the firmware that everyone loves 
to hate. In the case of the uefi/CM4 the only really sane default for 
that switch is "SMC mode" because out of the box the "claim pci 
compliance when we aren't" mode crashes linux kernels without the quirk.

So this decision creates a user interface problem specific to linux 
installs that require quirking. There are strong opinions on both sides, 
but linux refusing to support it doesn't make it go away, it just 
creates additional maint overhead for Linux.



> 
>    It was decided that the PCI SMC conduit enablement patches will not be
>    merged for these specific reasons.
> 
> - It is not clear why ACPI enablement is requested for platforms that are
>    clearly not compliant with Arm SBSA/SBBR guidelines; there is no
>    interest from distros in enabling ACPI bootstrap on non-SBSA compliant
>    HW, devicetree firmware can be used to bootstrap non-compliant platforms.
> - We agreed that Linux will rely on MCFG quirks to enable PCI on ACPI
>    arm64 systems if the relevant HW is not ECAM compliant (and ACPI
>    enablement is requested); non-ECAM compliance must be classified as a HW
>    defect and filed in the Linux kernel as an erratum in (or equivalent
>    mechanism TBD):
> 
>    Documentation/arm64/acpi-ecam-quirks.rst
> 
>    Entries will contain an expected lifetime for the SoC in question and
>    a contact point. When an entry expires, a patch to remove the related
>    MCFG quirk will be proposed and action taken accordingly (either the
>    quirk is removed since support is no longer required or the entry is
>    updated). Details behind the specific mechanism to follow on public
>    mailing lists.
> 
> - MCFG quirks will be reviewed by PCI maintainers and acceptance will be
>    granted or refused on a case by case basis; the aim is supporting HW
>    where quirks are self-contained and don't require FW or specifications
>    updates.
> 
>    In order to request a MCFG quirk acceptance a relevant errata entry
>    should be filed in the related Linux kernel documentation errata file.
>    This will help detect whether non-ECAM HW bugs that were granted an
>    MCFG quirk are actually fixed in subsequent SoCs.
> 
> - As a rule of thumb (that will be drafted in non-ECAM errata guidelines),
>    to be considered for upstream MCFG quirks must not rely on additional
>    ACPI firmware bindings and AML code other than MCFG table and
>    PNP0A08/PNP0A03 ACPI *existing* bindings.
> 
>    MCFG quirks suitability for upstream merge will be determined by
>    PCI maintainers only.
> 

