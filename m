Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E85844E1
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiG1RVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jul 2022 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiG1RU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jul 2022 13:20:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBB775F111;
        Thu, 28 Jul 2022 10:20:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 061AE106F;
        Thu, 28 Jul 2022 10:20:57 -0700 (PDT)
Received: from [192.168.122.164] (U203867.austin.arm.com [10.118.30.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2852A3F73B;
        Thu, 28 Jul 2022 10:20:56 -0700 (PDT)
Message-ID: <7e4a0b4a-ac2f-5454-9778-e83f651b84a3@arm.com>
Date:   Thu, 28 Jul 2022 12:20:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/4] PCI SMC conduit, now with DT support
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, jonmasters@google.com
References: <20220725163905.2024437-1-jeremy.linton@arm.com>
 <20220726114000.GA21450@willie-the-truck>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220726114000.GA21450@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 7/26/22 06:40, Will Deacon wrote:
> On Mon, Jul 25, 2022 at 11:39:01AM -0500, Jeremy Linton wrote:
>> This is a rebase of the later revisions of [1], but refactored
>> slightly to add a DT method as well. It has all the same advantages of
>> the ACPI method (putting HW quirks in the firmware rather than the
>> kernel) but now applied to a 'pci-host-smc-generic' compatible
>> property which extends the pci-host-generic logic to handle cases
>> where the PCI Config region isn't ECAM compliant. With this in place,
>> and firmware managed clock/phy/etc its possible to run the generic
>> driver on hardware that isn't what one would consider standards
>> compliant PCI root ports.
> 
> I still think that hiding the code in firmware because the hardware is
> broken is absolutely the wrong way to tackle this problem and I thought
> the general idea from last time was that we were going to teach Linux
> about the broken hardware instead [1]. I'd rather have the junk where we
> can see it, reason about it and modify it.

Well, the CM4/ACPI/PCIe quirk still hasn't landed, but that's not the point.

I would like to understand why you think this patch is any different 
than the dozens of other firmware traps, quite a number merged in the 
last year, for "broken" hardware or simply as generic platform interfaces?

Without rehashing, the entire discussion in the previous thread, I'm 
going to repeat that this is an official Arm standard the same as the 
firmware traps to handle speculative execution mitigations or to 
standardize platform functionality, ex: PSCI or the recent TRNG code. It 
also has uses beyond fixing broken hardware.

But similar to those examples, I think everyone here understands the 
kernel is both a poor place for this kind of logic, while at the same 
time may not be technically feasible without supplying EL3, management 
processor code, or traps to said code.

Is it the official position of the Linux kernel maintainers that they 
will refuse to support future Arm standards in order to gate keep 
specific hardware platforms?

> 
> What's changed?

Well, the code to support this interface is upstream in both TFA, edk2, 
and various other OS's. So now Linux is trailing.

> 
> In my mind, the main thing that's happened since we last discussed this
> is that Apple shipped arm64 client hardware with working ECAM. *Apple*
> for goodness sake: a company with basically no incentive to follow
> standards for their vertically integrated devices! Perhaps others need
> to raise their game instead of wasting everybody's time on firmware
> hacks; getting the hardware right obviously isn't as difficult as folks
> would lead us to believe.

I find it interesting that you hold up the M1 as an example of good 
hardware. That hardware is one of the worse violators of both platform 
standards, as well has having a lot of "broken" hardware requiring 
changes to the kernel that previously were rejected as too far out of 
line. Never mind, as you point out it has basically zero vendor support 
and exists only due to a large reverse engineering effort.


Thanks for looking at this,
