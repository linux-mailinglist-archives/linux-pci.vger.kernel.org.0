Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E2E2EE657
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 20:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbhAGTqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 14:46:36 -0500
Received: from foss.arm.com ([217.140.110.172]:38496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbhAGTqg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 14:46:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66D62D6E;
        Thu,  7 Jan 2021 11:45:50 -0800 (PST)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 101603F66E;
        Thu,  7 Jan 2021 11:45:50 -0800 (PST)
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <CAL_JsqL2ZXrTg9VFwGK4CawvyBbnHehF9W=cgVEJPzCRoM5G9g@mail.gmail.com>
 <bdd563a9-c8d4-307b-617c-139dda3e4984@arm.com>
 <CAL_Jsq+OUX2ctFwiqcQtM=oswyz8s-iq94eHW247sabYYF5B-A@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <5d4f85a4-248b-b62e-f976-63c6214bf588@arm.com>
Date:   Thu, 7 Jan 2021 13:45:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+OUX2ctFwiqcQtM=oswyz8s-iq94eHW247sabYYF5B-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 1/7/21 11:36 AM, Rob Herring wrote:
> On Thu, Jan 7, 2021 at 9:24 AM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> Hi,
>>
>>
>> On 1/7/21 9:28 AM, Rob Herring wrote:
>>> On Mon, Jan 4, 2021 at 9:57 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>>>
>>>> Given that most arm64 platform's PCI implementations needs quirks
>>>> to deal with problematic config accesses, this is a good place to
>>>> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
>>>> standard SMC conduit designed to provide a simple PCI config
>>>> accessor. This specification enhances the existing ACPI/PCI
>>>> abstraction and expects power, config, etc functionality is handled

(trimming)

>>>>
>>>> +static int smccc_pcie_check_conduit(u16 seg)
>>>
>>> check what? Based on how you use this, perhaps _has_conduit() instead.
>>
>> Sure.
>>
>>>
>>>> +{
>>>> +       struct arm_smccc_res res;
>>>> +
>>>> +       if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
>>>> +               return -EOPNOTSUPP;
>>>> +
>>>> +       arm_smccc_smc(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>>> +       if ((int)res.a0 < 0)
>>>> +               return -EOPNOTSUPP;
>>>> +
>>>> +       arm_smccc_smc(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res);
>>>> +       if ((int)res.a0 < 0)
>>>> +               return -EOPNOTSUPP;
>>>
>>> Don't you need to check that read and write functions are supported?
>>
>> In theory no, the first version of the specification makes them
>> mandatory for all implementations. There isn't a partial access method,
>> so nothing works if only read or write were implemented.
> 
> Then the spec should change:
> 
> 2.3.3 Caller responsibilities
> The caller has the following responsibilities:
> • The caller must ensure that this function is implemented before
> issuing a call. This function is discoverable
> by calling PCI_FEATURES with pci_func_id set to 0x8400_0132.
> 
> 
> I guess knowing the version is ensuring, but the 2nd sentence makes it
> seem that is how one should ensure.

Ok, yes i understand, I will add the check.

> 
> Related, are there any sort of tests for the interface? I generally
> don't think the kernel's job is validating firmware (a frequent topic
> for DT), but we should have something. Maybe an SMC unittest module?
> If nothing else, seems like we should have at least one PCI_FEATURES
> call to make sure it works. We don't want to add it later only to find
> that it breaks on some firmware implementations. Though we can just
> add firmware quirks. ;)

I'm not aware of any unit tests at the moment. My testing so far has 
been against these patches: 
https://review.trustedfirmware.org/q/topic:"Arm_PCI_Config_Space_Interface"

But given the next version does the PCI_FEATURES calls, that will 
satisfy your concern, right?
