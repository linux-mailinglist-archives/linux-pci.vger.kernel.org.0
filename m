Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39EE3054F8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316631AbhAZX16 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:27:58 -0500
Received: from foss.arm.com ([217.140.110.172]:48540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbhAZRDv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 12:03:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CAC5D6E;
        Tue, 26 Jan 2021 08:46:09 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C56053F66E;
        Tue, 26 Jan 2021 08:46:08 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jon Masters <jcm@jonmasters.org>, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <4c2db08d-ccc4-05eb-6b7b-5fd7d07dd11e@arm.com>
Date:   Tue, 26 Jan 2021 10:46:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210122194829.GE25471@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/22/21 1:48 PM, Will Deacon wrote:
> Hi Lorenzo,
> 
> On Fri, Jan 08, 2021 at 10:32:16AM +0000, Lorenzo Pieralisi wrote:
>> On Thu, Jan 07, 2021 at 04:05:48PM -0500, Jon Masters wrote:
>>> On 1/7/21 1:14 PM, Will Deacon wrote:
>>>
>>>> On Mon, Jan 04, 2021 at 10:57:35PM -0600, Jeremy Linton wrote:
>>>>> Given that most arm64 platform's PCI implementations needs quirks
>>>>> to deal with problematic config accesses, this is a good place to
>>>>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
>>>>> standard SMC conduit designed to provide a simple PCI config
>>>>> accessor. This specification enhances the existing ACPI/PCI
>>>>> abstraction and expects power, config, etc functionality is handled
>>>>> by the platform. It also is very explicit that the resulting config
>>>>> space registers must behave as is specified by the pci specification.
>>>>>
>>>>> Lets hook the normal ACPI/PCI config path, and when we detect
>>>>> missing MADT data, attempt to probe the SMC conduit. If the conduit
>>>>> exists and responds for the requested segment number (provided by the
>>>>> ACPI namespace) attach a custom pci_ecam_ops which redirects
>>>>> all config read/write requests to the firmware.
>>>>>
>>>>> This patch is based on the Arm PCI Config space access document @
>>>>> https://developer.arm.com/documentation/den0115/latest
>>>>
>>>> Why does firmware need to be involved with this at all? Can't we just
>>>> quirk Linux when these broken designs show up in production? We'll need
>>>> to modify Linux _anyway_ when the firmware interface isn't implemented
>>>> correctly...
>>>
>>> I agree with Will on this. I think we want to find a way to address some
>>> of the non-compliance concerns through quirks in Linux. However...
>>
>> I understand the concern and if you are asking me if this can be fixed
>> in Linux it obviously can. The point is, at what cost for SW and
>> maintenance - in Linux and other OSes, I think Jeremy summed it up
>> pretty well:
>>
>> https://lore.kernel.org/linux-pci/61558f73-9ac8-69fe-34c1-2074dec5f18a@arm.com
>>
>> The issue here is that what we are asked to support on ARM64 ACPI is a
>> moving target and the target carries PCI with it.
>>
>> This potentially means that all drivers in:
>>
>> drivers/pci/controller
>>
>> may require an MCFG quirk and to implement it we may have to:
>>
>> - Define new ACPI bindings (that may need AML and that's already a
>>    showstopper for some OSes)
>> - Require to manage clocks in the kernel (see link-up checks)
>> - Handle PCI config space faults in the kernel
>>
>> Do we really want to do that ? I don't think so. Therefore we need
>> to have a policy to define what constitutes a "reasonable" quirk and
>> that's not objective I am afraid, however we slice it (there is no
>> such a thing as eg 90% ECAM).
> 
> Without a doubt, I would much prefer to see these quirks and workarounds
> in Linux than hidden behind a firmware interface. Every single time.
> 
> This isn't like the usual fragmentation problems, where firmware swoops in
> to save the day; CPU onlining, spectre mitigations, early entropy etc. All
> of these problems exist because there isn't a standard method to implement
> them outside of firmware, and so adding a layer of abstraction there makes
> sense.

There are a lot of parallels with PSCI here because there were existing 
standards for cpu online.

> 
> But PCIe is already a standard!

And it says that ECAM is optional, particularly if there are 
firmware/platform standardized ways of accessing the config space.

> 
> We shouldn't paper over hardware designers' inability to follow a ~20 year
> old standard by hiding it behind another standard that is hot off the press.
> Seriously.

No disagreement, but its been more than half a decade and there are some 
high (millions!) volume parts, that still don't have kernel support.

> 
> There is not a scrap of evidence to suggest that the firmware
> implementations will be any better, but they will certainly be harder to
> debug and maintain.  I have significant reservations about Arm's interest in
> maintaining the spec as both more errata appear and the PCIe spec evolves
> (after all, this is outside of SBSA, no?). The whole thing stinks of "if all
> you have is a hammer, then everything looks like a nail". But this isn't the
> sort of problem that is solved with yet another spec -- instead, how about
> encouraging vendors to read the specs that already exist?

PSCI, isn't a good example of a firmware interface that works?

> 
>> The SMC is an olive branch and just to make sure it is crystal clear
>> there won't be room for adding quirks if the implementation turns out
>> to be broken, if a line in the sand is what we want here it is.
> 
> I appreciate the sentiment, but you're not solving the problem here. You're
> moving it somewhere else. Somewhere where you don't have to deal with it
> (and I honestly can't blame you for that), but also somewhere where you
> _can't_ necessarily deal with it. The inevitable outcome is an endless
> succession of crappy, non-compliant machines which only appear to operate
> correctly with particularly kernel/firmware combinations. Imagine trying to
> use something like that?
> 
> The approach championed here actively discourages vendors from building
> spec-compliant hardware and reduces our ability to work around problems
> on such hardware at the same time.
> 
> So I won't be applying these patches, sorry.

Does that mean its open season for ECAM quirks, and we can expect them 
to start being merged now?

Thanks.

