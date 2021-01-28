Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EB9307E8D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 20:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhA1S4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 13:56:11 -0500
Received: from foss.arm.com ([217.140.110.172]:37674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232481AbhA1SvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 13:51:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0529F13A1;
        Thu, 28 Jan 2021 10:50:21 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 77BB83F719;
        Thu, 28 Jan 2021 10:50:20 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Will Deacon <will@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jon Masters <jcm@jonmasters.org>, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <4c2db08d-ccc4-05eb-6b7b-5fd7d07dd11e@arm.com>
 <20210126225454.GB30941@willie-the-truck>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <bde7b13e-e395-0f12-d0dc-62383ee80dd8@arm.com>
Date:   Thu, 28 Jan 2021 12:50:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126225454.GB30941@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/26/21 4:54 PM, Will Deacon wrote:
> On Tue, Jan 26, 2021 at 10:46:04AM -0600, Jeremy Linton wrote:
>> On 1/22/21 1:48 PM, Will Deacon wrote:
>>> This isn't like the usual fragmentation problems, where firmware swoops in
>>> to save the day; CPU onlining, spectre mitigations, early entropy etc. All
>>> of these problems exist because there isn't a standard method to implement
>>> them outside of firmware, and so adding a layer of abstraction there makes
>>> sense.
>>
>> There are a lot of parallels with PSCI here because there were existing
>> standards for cpu online.
> 
> I don't recall anything that I would consider a standard at the time.
> 
>>> But PCIe is already a standard!
>>
>> And it says that ECAM is optional, particularly if there are
>> firmware/platform standardized ways of accessing the config space.
> 
> Nice loophole; I haven't checked.
> 
>>> We shouldn't paper over hardware designers' inability to follow a ~20 year
>>> old standard by hiding it behind another standard that is hot off the press.
>>> Seriously.
>>
>> No disagreement, but its been more than half a decade and there are some
>> high (millions!) volume parts, that still don't have kernel support.
> 
> Ok.
> 
>>> There is not a scrap of evidence to suggest that the firmware
>>> implementations will be any better, but they will certainly be harder to
>>> debug and maintain.  I have significant reservations about Arm's interest in
>>> maintaining the spec as both more errata appear and the PCIe spec evolves
>>> (after all, this is outside of SBSA, no?). The whole thing stinks of "if all
>>> you have is a hammer, then everything looks like a nail". But this isn't the
>>> sort of problem that is solved with yet another spec -- instead, how about
>>> encouraging vendors to read the specs that already exist?
>>
>> PSCI, isn't a good example of a firmware interface that works?
> 
> Not sure what you're getting at here.

Simply, that PSCI is working fairly well today, and that hopefully this
specification will similarly mature.

Right now, there are at least three prongs for assuring compliance. The 
TF-A core service is being written to assure parameter validation and 
error checking is common across all the platforms. That code is 
attempting to cover every case called out by the SMC/PCI spec. The 
kernel is now utilizing the entire API service and cross validating the 
ACPI/SMC bus values and function existence. Lastly, but most important, 
there is the ACS PCI compliance suite*. That suite attempts to validate, 
among other things, config space behavior. When run on top of the SMC 
conduit, it provides assurance that root port registers/etc behave as 
the PCIe standard dictates.

* https://github.com/ARM-software/sbsa-acs/tree/master/test_pool/pcie

Thanks,
> 
>>>> The SMC is an olive branch and just to make sure it is crystal clear
>>>> there won't be room for adding quirks if the implementation turns out
>>>> to be broken, if a line in the sand is what we want here it is.
>>>
>>> I appreciate the sentiment, but you're not solving the problem here. You're
>>> moving it somewhere else. Somewhere where you don't have to deal with it
>>> (and I honestly can't blame you for that), but also somewhere where you
>>> _can't_ necessarily deal with it. The inevitable outcome is an endless
>>> succession of crappy, non-compliant machines which only appear to operate
>>> correctly with particularly kernel/firmware combinations. Imagine trying to
>>> use something like that?
>>>
>>> The approach championed here actively discourages vendors from building
>>> spec-compliant hardware and reduces our ability to work around problems
>>> on such hardware at the same time.
>>>
>>> So I won't be applying these patches, sorry.
>>
>> Does that mean its open season for ECAM quirks, and we can expect them to
>> start being merged now?
> 
> That's not for me to say.
> 
> Will
> 

