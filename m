Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D3423374
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 00:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbhJEW10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 18:27:26 -0400
Received: from foss.arm.com ([217.140.110.172]:34334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236697AbhJEW10 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 18:27:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D02B56D;
        Tue,  5 Oct 2021 15:25:34 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B2B3F66F;
        Tue,  5 Oct 2021 15:25:33 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] PCI: brcmstb: Add ACPI config space quirk
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211005153209.GA1083986@bhelgaas>
 <d4b34193-31e5-2f95-6365-b58239c0dabb@arm.com>
 <20211005194301.enb5jddzdgczcolx@pali>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <694bb355-3b5e-9801-3772-ff784b49a603@arm.com>
Date:   Tue, 5 Oct 2021 17:25:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211005194301.enb5jddzdgczcolx@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 10/5/21 2:43 PM, Pali Rohár wrote:
> Hello!
> 
> On Tuesday 05 October 2021 10:57:18 Jeremy Linton wrote:
>> Hi,
>>
>> On 10/5/21 10:32 AM, Bjorn Helgaas wrote:
>>> On Thu, Aug 26, 2021 at 02:15:55AM -0500, Jeremy Linton wrote:
>>>> Additionally, some basic bus/device filtering exist to avoid sending
>>>> config transactions to invalid devices on the RP's primary or
>>>> secondary bus. A basic link check is also made to assure that
>>>> something is operational on the secondary side before probing the
>>>> remainder of the config space. If either of these constraints are
>>>> violated and a config operation is lost in the ether because an EP
>>>> doesn't respond an unrecoverable SERROR is raised.
>>>
>>> It's not "lost"; I assume the root port raises an error because it
>>> can't send a transaction over a link that is down.
>>
>> The problem is AFAIK because the root port doesn't do that.
> 
> Interesting! Does it mean that PCIe Root Complex / Host Bridge (which I
> guess contains also logic for Root Port) does not signal transaction
> failure for config requests? Or it is just your opinion? Because I'm
> dealing with similar issues and I'm trying to find a way how to detect
> if some PCIe IP signal transaction error via AXI SLVERR response OR it
> just does not send any response back. So if you know some way how to
> check which one it is, I would like to know it too.

This is my _opinion_ based on what I've heard of some other IP 
integration issues, and what i've seen poking at this one from the 
perspective of a SW guy rather than a HW guy. So, basically worthless. 
But, you should consider that most of these cores/interconnects aren't 
aware of PCIe completion semantics so its the root ports responsibility 
to say, gracefully translate a non-posted write that doesn't have a 
completion for the interconnects its attached to, rather than tripping 
something generic like a SLVERR.

Anyway, for this I would poke around the pile of exception registers, 
with your specific processors manual handy because a lot of them are 
implementation defined.
>>>
>>> Is "SERROR" an ARM64 thing?  My guess is the root port would raise an
>>> Unsupported Request error or similar, and the root complex turns that
>>> into a system-specific SERROR?
> 
> Yes, SError is arm64 specific. It is asynchronous CPU interrupt and
> syndrome code then contains what happened.
> 
>> AFAIK, what is happening here the CPU core has an outstanding R/W request
>> for which it never receives a response from the root port. So basically its
>> an interconnect protocol violation that the CPU is complaining about rather
>> than something PCIe specific.
> 
> Could you describe (ideally in commit message) which SError is
> triggered? Normally if kernel receive SError interrupt it also puts into
> dmesg or oops message also syndrome code which describe what kind of
> error / event occurred. It could help also to other understand what is
> happening there.
> 

