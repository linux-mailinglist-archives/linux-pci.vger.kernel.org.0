Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB61304DFC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 01:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbhAZX3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:29:10 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12095 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389142AbhAZRNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 12:13:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60104cae0000>; Tue, 26 Jan 2021 09:09:02 -0800
Received: from [10.20.22.136] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Jan
 2021 17:08:55 +0000
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>, <treding@nvidia.com>
CC:     Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>, <mark.rutland@arm.com>,
        <linux-pci@vger.kernel.org>, <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <bhelgaas@google.com>, <linux-arm-kernel@lists.infradead.org>,
        <vsethi@nvidia.com>, <ebrower@nvidia.com>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
From:   Vikram Sethi <vsethi@nvidia.com>
Message-ID: <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
Date:   Tue, 26 Jan 2021 11:08:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210122194829.GE25471@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611680942; bh=H++VrdvOkAVVDuj3cU5vm9XtoR3IWMwYGD9h93FM+Hs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=UI3rkXlv8tNTgrEgTZ8ErLDn7YW/KXbBnQO24sP4Al/6bsjdp7h2YoRwrdTY8oDdc
         mp/cGN3NtJ972f75nkdPPtpy/KGEIpk0vQmpd3XuD096tnkj+klvo5rEKQfJTXBL02
         CLCZhVBKlPG8mBCLQ4+cFqa1RkdtLs4pNCSE41XPiDd4eSKFaswMMi4ZMMJfBovx28
         IFgcAFs4fTuubgCEk4iWY0TmxHPFxRCyFakTWeHBPFp/cgS1cfptOQ+ZAcdixo13Sf
         feaJvrPifPm7zOgp9Qj3LcTCh9nKHl5vEmNg76aFn5dNFrE0KKeG1iYSawnqz2m5hT
         ZY9lNYCK6nBnA==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Will, Lorenzo, Bjorn,

On 1/22/2021 1:48 PM, Will Deacon wrote:
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
>>>> Why does firmware need to be involved with this at all? Can't we just
>>>> quirk Linux when these broken designs show up in production? We'll need
>>>> to modify Linux _anyway_ when the firmware interface isn't implemented
>>>> correctly...
>>> I agree with Will on this. I think we want to find a way to address some
>>> of the non-compliance concerns through quirks in Linux. However...
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
>>   showstopper for some OSes)
>> - Require to manage clocks in the kernel (see link-up checks)
>> - Handle PCI config space faults in the kernel
>>
>> Do we really want to do that ? I don't think so. Therefore we need
>> to have a policy to define what constitutes a "reasonable" quirk and
>> that's not objective I am afraid, however we slice it (there is no
>> such a thing as eg 90% ECAM).
> Without a doubt, I would much prefer to see these quirks and workarounds
> in Linux than hidden behind a firmware interface. Every single time.

In that case, can you please comment on/apply Tegra194 ECAM quirk that was rejected

a year ago, and was the reason we worked with Samer/ARM to define this common

mechanism?

https://lkml.org/lkml/2020/1/3/395

The T194 ECAM is from widely used Root Port IP from a IP vendor. That is one reason so many

*existing* SOCs have ECAM quirks. ARM is only now working with the Root port IP vendors

to test ECAM, MSI etc, but the reality is there were deficiencies in industry IP that is widely

used. If this common quirk is not the way to go, then please apply the T194 specific quirk which was

NAK'd a year ago, or suggest how to improve that quirk.

The ECAM issue has been fixed on future Tegra chips and is validated preSilicon with BSA

tests, so it is not going to be a recurrent issue for us.

>
> This isn't like the usual fragmentation problems, where firmware swoops in
> to save the day; CPU onlining, spectre mitigations, early entropy etc. All
> of these problems exist because there isn't a standard method to implement
> them outside of firmware, and so adding a layer of abstraction there makes
> sense.
>
> But PCIe is already a standard!
>
> We shouldn't paper over hardware designers' inability to follow a ~20 year
> old standard by hiding it behind another standard that is hot off the press.
> Seriously.
>
> There is not a scrap of evidence to suggest that the firmware
> implementations will be any better, but they will certainly be harder to
> debug and maintain.  I have significant reservations about Arm's interest in
> maintaining the spec as both more errata appear and the PCIe spec evolves
> (after all, this is outside of SBSA, no?). The whole thing stinks of "if all
> you have is a hammer, then everything looks like a nail". But this isn't the
> sort of problem that is solved with yet another spec -- instead, how about
> encouraging vendors to read the specs that already exist?
>
>> The SMC is an olive branch and just to make sure it is crystal clear
>> there won't be room for adding quirks if the implementation turns out
>> to be broken, if a line in the sand is what we want here it is.
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
>
> Will
>
