Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF05C452F12
	for <lists+linux-pci@lfdr.de>; Tue, 16 Nov 2021 11:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbhKPKbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Nov 2021 05:31:21 -0500
Received: from foss.arm.com ([217.140.110.172]:43256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234136AbhKPKbJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Nov 2021 05:31:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC0D81FB;
        Tue, 16 Nov 2021 02:28:12 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EEBD3F766;
        Tue, 16 Nov 2021 02:28:11 -0800 (PST)
Message-ID: <ba499fa1-c5f7-2e69-2bd5-14677f385d5b@arm.com>
Date:   Tue, 16 Nov 2021 10:28:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [Question] rk3399 vfio-pci/sr-iov support
Content-Language: en-GB
To:     Adam Joseph <adam@westernsemico.com>
Cc:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-pci@vger.kernel.org
References: <CAMdYzYoPXWbv4zXet6c9JQEMbqcJi6ZEOui_n82NVmrqNLy_pw@mail.gmail.com>
 <b597b9a6-870a-8fbd-6490-59734c04367f@arm.com>
 <20211115115004.7d043c5b@snowden>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211115115004.7d043c5b@snowden>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-11-15 19:50, Adam Joseph wrote:
> On Mon, 9 Dec 2019 14:07:02 +0000
> Robin Murphy <robin.murphy@arm.com> wrote:
>> On 09/12/2019 1:28 pm, Peter Geis wrote:
>>> I'm back with more pcie fun on the rk3399.
>>> I'm trying to get pcie passthrough working for a vm on the rk3399,
>>> and have encountered some roadblocks.
>>
>> That much I can help with somewhat: the major impediment is that
>> RK3399 doesn't have an IOMMU in front of PCIe.
> 
> For the more limited case of defending against attacks from
> hostile/buggy firmware on PCIe devices: is it possible to use the
> RK3399 PCIe "inbound address translation" support instead of an IOMMU?

I guess it might be possible to reserve some memory with the new 
"restricted-dma-pool" semantics then tweak the PCIe setup to match that. 
It will mostly depend on what the RC does with transactions that don't 
match any ATU entry. These kinds of registers typically only decode a 
small number of naturally-aligned power-of-two-sized address ranges so 
would not be able to support the kind of arbitrary translation/page 
protection you'd need for something like VFIO.

> The RK3399 TRM, v1.3 "Part 2", section 17.5.5.2.1 explains how to
> configure address translation (including a base/bounds check) for
> inbound-to-SoC memory writes, but details are quite sparse.
> 
> Linux appears to not use this functionality; from
> drivers/pci/controller/pcie-rockchip-host.c we can see that it
> disables the base/bounds (sets them to the entire 32-bit space, which
> is all RAM on RK3399 since it supports only 4GB) and passes all 32
> bits of incoming memory writes:
> 
> static int rockchip_pcie_prog_ib_atu(struct rockchip_pcie *rockchip,
>                                       int region_no, u8 num_pass_bits,
> 	                             u32 lower_addr, u32 upper_addr)
> ...
> 
> static int rockchip_pcie_cfg_atu(struct rockchip_pcie *rockchip)
> {
> ...
> 	err = rockchip_pcie_prog_ib_atu(rockchip, 2, 32 - 1, 0x0, 0);
> 
> Is this a dead end?  If not I might pursue it, if I can get the
> necessary documentation.  I couldn't find any mention of ATS in the
> RK3399 manual; if the PCIe RC allows that then all bets are off anyways.

Knowing this RC, if it ever did see an ATS translated transaction header 
it would probably SError the system, like it does for such outlandish 
things as trying to probe config space behind bridges :)

Robin.
