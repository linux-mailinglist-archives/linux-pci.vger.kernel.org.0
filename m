Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D4B3B8041
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 11:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhF3JrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 05:47:22 -0400
Received: from foss.arm.com ([217.140.110.172]:34676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233541AbhF3JrW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Jun 2021 05:47:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A5D1042;
        Wed, 30 Jun 2021 02:44:53 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 500E33F718;
        Wed, 30 Jun 2021 02:44:49 -0700 (PDT)
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
        linux-rockchip@lists.infradead.org,
        Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        rfi@lists.rocketboards.org, Jingoo Han <jingoohan1@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20210629231410.GA4097899@bjorn-Precision-5520>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe0e75ba-6008-6dc0-e21e-4ea992bb6cdd@arm.com>
Date:   Wed, 30 Jun 2021 10:44:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629231410.GA4097899@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-06-30 00:14, Bjorn Helgaas wrote:
> On Tue, Jun 29, 2021 at 11:52:44AM +0100, Robin Murphy wrote:
>> On 2021-06-29 07:17, Javier Martinez Canillas wrote:
>>> On 6/29/21 2:38 AM, Bjorn Helgaas wrote:
>>>> On Thu, Jun 24, 2021 at 05:40:40PM -0500, Bjorn Helgaas wrote:
>>>
>>> [snip]
>>>
>>>>>>
>>>>>> So let's just move all the IRQ init before the pci_host_probe() call, that
>>>>>> will prevent issues like this and seems to be the correct thing to do too.
>>>>>
>>>>> Previously we registered rockchip_pcie_subsys_irq_handler() and
>>>>> rockchip_pcie_client_irq_handler() before the PCIe clocks were
>>>>> enabled.  That's a problem because they depend on those clocks being
>>>>> enabled, and your patch fixes that.
>>>>>
>>>>> rockchip_pcie_legacy_int_handler() depends on rockchip->irq_domain,
>>>>> which isn't initialized until rockchip_pcie_init_irq_domain().
>>>>> Previously we registered rockchip_pcie_legacy_int_handler() as the
>>>>> handler for the "legacy" IRQ before rockchip_pcie_init_irq_domain().
>>>>>
>>>>> I think your patch *also* fixes that problem, right?
>>>>
>>>> The lack of consistency in how we use
>>>> irq_set_chained_handler_and_data() really bugs me.
>>>>
>>>> Your patch fixes the ordering issue where we installed
>>>> rockchip_pcie_legacy_int_handler() before initializing data
>>>> (rockchip->irq_domain) that it depends on.
>>>>
>>>> But AFAICT, rockchip still has the problem that we don't *unregister*
>>>> rockchip_pcie_legacy_int_handler() when the rockchip-pcie module is
>>>> removed.  Doesn't this mean that if we unload the module, then receive
>>>> an interrupt from the device, we'll try to call a function that is no
>>>> longer present?
>>>
>>> Good question, I don't to be honest. I'll have to dig deeper on this but
>>> my experience is that the module removal (and device unbind) is not that
>>> well tested on ARM device drivers in general.
>>
>> Well, it does use devm_request_irq() so the handler should be unregistered
>> by devres *after* ->remove has finished, however that does still leave a
>> potential race window in which a pending IRQ could be taken during the later
>> part of rockchip_pcie_remove() after it has started turning off critical
>> things. Unless the clocks and regulators can also be delegated to devres, it
>> might be more robust to explicitly manage the IRQs as well. Mixing the two
>> schemes can be problematic when the exact order of both setup and teardown
>> matters.
> 
> I don't understand the devm_request_irq() connection.  I'm looking at
> this irq_set_chained_handler_and_data() call [1]:
> 
>    static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
>    {
>      ...
>      irq = platform_get_irq_byname(pdev, "legacy");
>      irq_set_chained_handler_and_data(irq,
> 				     rockchip_pcie_legacy_int_handler,
> 				     rockchip);
> 
>      irq = platform_get_irq_byname(pdev, "client");
>      ...
> 
> We look up "irq", pass it to irq_set_chained_handler_and_data(), and
> throw it away without saving it anywhere.  How would anything know how
> to unregister rockchip_pcie_legacy_int_handler()?
> 
> I could imagine irq_set_chained_handler_and_data() saving what's
> needed for unregistration, but I would think that would require a
> device pointer, which we don't give it.
> 
> I'm IRQ-illiterate, so please educate me!

Oh, my mistake, I was looking at the "sys" and "client" IRQs and spoke 
too soon; the "legacy" IRQ does appear to be completely leaked as you 
say, so there are two degrees of issue here.

Robin.

> 
> Bjorn
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-rockchip-host.c?id=v5.13#n562
> 
