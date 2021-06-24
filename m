Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D373B39E0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 01:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFXXxp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 19:53:45 -0400
Received: from foss.arm.com ([217.140.110.172]:41988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXXxm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 19:53:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ED1EED1;
        Thu, 24 Jun 2021 16:51:22 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D55473F718;
        Thu, 24 Jun 2021 16:51:20 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
References: <20210624232841.GA3579021@bjorn-Precision-5520>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5356a01c-5aab-fbff-b0a9-157b961c66ee@arm.com>
Date:   Fri, 25 Jun 2021 00:51:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210624232841.GA3579021@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-25 00:28, Bjorn Helgaas wrote:
> On Fri, Jun 25, 2021 at 12:18:48AM +0100, Robin Murphy wrote:
>> On 2021-06-24 22:57, Bjorn Helgaas wrote:
>>> On Tue, Jun 08, 2021 at 10:04:09AM +0200, Javier Martinez Canillas wrote:
>>>> IRQ handlers that are registered for shared interrupts can be called at
>>>> any time after have been registered using the request_irq() function.
>>>>
>>>> It's up to drivers to ensure that's always safe for these to be called.
>>>>
>>>> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
>>>> their handlers are registered very early in the probe function, an error
>>>> later can lead to these handlers being executed before all the required
>>>> resources have been properly setup.
>>>>
>>>> For example, the rockchip_pcie_read() function used by these IRQ handlers
>>>> expects that some PCIe clocks will already be enabled, otherwise trying
>>>> to access the PCIe registers causes the read to hang and never return.
>>>
>>> The read *never* completes?  That might be a bit problematic because
>>> it implies that we may not be able to recover from PCIe errors.  Most
>>> controllers will timeout eventually, log an error, and either
>>> fabricate some data (typically ~0) to complete the CPU's read or cause
>>> some kind of abort or machine check.
>>>
>>> Just asking in case there's some controller configuration that should
>>> be tweaked.
>>
>> If I'm following correctly, that'll be a read transaction to the native side
>> of the controller itself; it can't complete that read, or do anything else
>> either, because it's clock-gated, and thus completely oblivious (it might be
>> that if another CPU was able to enable the clocks then everything would
>> carry on as normal, or it might end up totally deadlocking the SoC
>> interconnect). I think it's safe to assume that in that state nothing of
>> importance would be happening on the PCIe side, and even if it was we'd
>> never get to know about it.
> 
> Oh, right, that makes sense.  I was thinking about the PCIe side, but
> if the controller itself isn't working, of course we wouldn't get that
> far.
> 
> I would expect that the CPU itself would have some kind of timeout for
> the read, but that's far outside of the PCI world.

Nah, in AMBA I'm not sure if it's even legal to abandon a transaction 
without waiting for the handshake to complete. If you're lucky the 
interconnect might have a clock/power domain bridge which can reply with 
an error when it knows its other side isn't running, otherwise the 
initiator will just happily sit there waiting for a response to come 
back "in a timely manner" :)

Robin.
