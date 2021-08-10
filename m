Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8603E7BC9
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 17:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbhHJPKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 11:10:54 -0400
Received: from foss.arm.com ([217.140.110.172]:57658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242538AbhHJPKx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 11:10:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 803A01FB;
        Tue, 10 Aug 2021 08:10:31 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1016E3F718;
        Tue, 10 Aug 2021 08:10:31 -0700 (PDT)
Subject: Re: [PATCH 1/3] PCI: brcmstb: Break register definitions into
 separate header
To:     Florian Fainelli <f.fainelli@gmail.com>, linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        bcm-kernel-feedback-list@broadcom.com, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210805211200.491275-1-jeremy.linton@arm.com>
 <20210805211200.491275-2-jeremy.linton@arm.com>
 <f82761b1-fb7e-08b2-8bc3-c84d258e26d3@gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <ab2aa9e3-cdc7-1bc7-d493-8f3c991c3285@arm.com>
Date:   Tue, 10 Aug 2021 10:10:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f82761b1-fb7e-08b2-8bc3-c84d258e26d3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Thanks for taking a look at this!


On 8/10/21 5:07 AM, Florian Fainelli wrote:
> 
> 
> On 8/5/2021 2:11 PM, Jeremy Linton wrote:
>> We are about to create a standalone ACPI quirk module for the
>> bcmstb controller. Lets move the register definitions into a separate
>> file so they can be shared between the APCI quirk and the normal
>> host bridge driver.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/pci/controller/pcie-brcmstb.c | 179 +------------------------
>>   drivers/pci/controller/pcie-brcmstb.h | 182 ++++++++++++++++++++++++++
>>   2 files changed, 183 insertions(+), 178 deletions(-)
>>   create mode 100644 drivers/pci/controller/pcie-brcmstb.h
> 
> You moved more than just register definitions into pcie-brcmstb.h you 
> also moved internal structure definitions, enumerations, etc. which are 
> not required since pcie-brcmstb-acpi.c does not access the brcm_pcie 
> structure but open codes accesses to the MISC_STATUS register instead.
> 
> There are no include guards added to this file (it is debatable whether 
> we should add them), and it is also not covered by the existing BROADCOM 
> BCM2711/BCM2835 ARM ARCHITECTURE MAINTAINERS file entry.

Sure, I will reduce the .h to just the register definitions, guard it, 
and tweak maintainers to cover pcie-brcmstb*.


> 
> Given that there can be new platforms supported by this PCIe controller 
> in the future possibly with the same limitations as the 2711, but with a 
> seemingly different MISC_STATUS layout, you will have to think about a 
> solution that scales, maybe we cross that bridge when we get there.

Yes, given I don't know what those changes are I can't predict how they 
would have to be handled, or even if the platform would be a target of 
the community maintaining the UEFI/ACPI port on the RPi. So punting on 
that topic seems a reasonable solution at the moment. Better yet, more 
of the linux community will see the advantage of the firmware interface 
and this platform can utilize that method.
