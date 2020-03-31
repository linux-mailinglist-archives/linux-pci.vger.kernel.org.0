Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B643E1994B3
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbgCaLGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 07:06:12 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53500 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbgCaLGM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 07:06:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02VB5qYv100142;
        Tue, 31 Mar 2020 06:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585652752;
        bh=gTlsFfcX1cCpP3lms+um1KkOhd52ds1+XWAAEc/+KFY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FLkMoYKSr64undYQN6KTQkdzRvwodzTuyO3t1cSggdjq/MoRSuoJk+AXTHJkDUfJW
         njMfRnxsF1xEbewT52hfVl3kKiiHf3s/211r/JSs5rdJ2/f++Lmr17XwNexb1aqvoU
         3dzDHTb6DmdpaFkdid8KZAKt52JYlYOxKo55EPYI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02VB5qLi081646;
        Tue, 31 Mar 2020 06:05:52 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Mar 2020 06:05:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Mar 2020 06:05:51 -0500
Received: from [10.250.133.69] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02VB5lj8013976;
        Tue, 31 Mar 2020 06:05:48 -0500
Subject: Re: [PATCH v4] PCI: dwc: pci-dra7xx: Fix MSI IRQ handling
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200330163703.GA60578@google.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <b7e7d888-9311-f71b-ef57-d036196a387d@ti.com>
Date:   Tue, 31 Mar 2020 16:35:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200330163703.GA60578@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 30/03/20 10:07 pm, Bjorn Helgaas wrote:
> On Mon, Mar 30, 2020 at 11:29:52AM -0500, Bjorn Helgaas wrote:
>> [+cc Marc, Thomas]
>>
>> On Fri, Mar 27, 2020 at 03:24:34PM +0530, Vignesh Raghavendra wrote:
>>> Due an issue with PCIe wrapper around DWC PCIe IP on dra7xx, driver
>>> needs to ensure that there are no pending MSI IRQ vector set (i.e
>>> PCIE_MSI_INTR0_STATUS reads 0 at least once) before exiting IRQ handler.
>>> Else, the dra7xx PCIe wrapper will not register new MSI IRQs even though
>>> PCIE_MSI_INTR0_STATUS shows IRQs are pending.
>>
>> I'm not an IRQ guy (real IRQ guys CC'd), but I'm wondering if this is
>> really a symptom of a problem in the generic DWC IRQ handling, not a
>> problem in dra7xx itself.
>>
>> I thought it was sort of standard behavior that a device would not
>> send a new MSI unless there was a transition from "no status bits set"
>> to "at least one status bit set".  I'm looking at this text from the
>> PCIe r5.0 spec, sec 6.7.3.4:


This patch is addressing an issue wrt how DWC PCIe MSI IRQ status is
aggregated at TI wrapper level:

There is a single MSI status bit which is supposed to be logical OR of
all the MSI IRQ status bits inside the DWC wrapper.  So if any of the
MSI IRQ status bits are set then this bit should read 1 and raise an
interrupt to CPU.
IRQ handler would then go through each MSI bit (inside DWC) and call
corresponding handler and then clear individual bits.
So the expectation was that wrapper level MSI status bit would auto
clear once all the DWC level MSI bits are cleared or wrapper will keep
the interrupt line asserted if there are still some outstanding ones.

But unfortunately that does not seem to be the case, MSI status bit in
the wrapper needs to be cleared manually. And moreover, once wrapper
level bit is cleared, the observation is that all the IRQ status bit
inside the DWC should be handled completely (i.e all the registers
should read 0 at least once) and only then is a new MSI IRQ guaranteed
to be recognized by the wrapper.

During debug without this commit, I often saw that DWC level MSI bit was
set (and IRQ status in endpoint's register was also set) but wrapper
level MSI bit was not set and host CPU never received an interrupt
therefore causing endpoint drivers to timeout waiting for certain events.

Regards
Vignesh

>>
>>   If the Port is enabled for edge-triggered interrupt signaling using
>>   MSI or MSI-X, an interrupt message must be sent every time the
>>   logical AND of the following conditions transitions from FALSE to
>>   TRUE:
>>
>>     - The associated vector is unmasked (not applicable if MSI does
>>       not support PVM).
>>
>>     - The Hot-Plug Interrupt Enable bit in the Slot Control register
>>       is set to 1b.
>>
>>     - At least one hot-plug event status bit in the Slot Status
>>       register and its associated enable bit in the Slot Control
>>       register are both set to 1b.
>>
>> and this related commit: https://git.kernel.org/linus/fad214b0aa72
> 
> and this one: https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=87d94ad41bd2
> 

I am not sure how these fixes can be relevant to my problem.
