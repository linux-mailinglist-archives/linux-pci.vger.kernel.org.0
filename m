Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A99A6DC2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 18:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfICQQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 12:16:19 -0400
Received: from foss.arm.com ([217.140.110.172]:39972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbfICQQT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 12:16:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC9B360;
        Tue,  3 Sep 2019 09:16:18 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A960A3F246;
        Tue,  3 Sep 2019 09:16:17 -0700 (PDT)
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     John Garry <john.garry@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
Date:   Tue, 3 Sep 2019 17:16:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi John,

On 03/09/2019 15:09, John Garry wrote:
> Hi Marc, Bjorn, Thomas,
> 
> We've come across a conflict with the kernel/pci msi code and GIC ITS 
> driver on our arm64 system, whereby we can't unbind and re-bind a PCI 
> device driver under special conditions. I'll explain...
> 
> Our PCI device support 32 MSIs. The driver attempts to allocate msi 
> vectors with min msi=17, max msi = 32, and affd.pre vectors = 16. For 
> our test we make nr_cpus = 1 (just anything less than 16).

Just to confirm: this PCI device is requiring Multi-MSI, right? As
opposed to MSI-X?

> We find that the pci/kernel msi code gives us 17 vectors, but the GIC 
> ITS code reserves 32 lpi maps in its_irq_domain_alloc(). The problem 
> then occurs when unbinding the driver in its_irq_domain_free() call, 
> where we only clear bits for 17 vectors. So if we unbind the driver and 
> then attempt to bind again, it fails.

Is this device, by any chance, sharing its requested-id with another
device? By being behind a bridge of some sort? There is some code to
deal with it, but I'm not sure it has ever been verified in anger...

> Where the fault lies, I can't say. Maybe the kernel msi code should 
> always give power of 2 vectors - as I understand, the PCI spec mandates 
> this. Or maybe the GIC ITS driver has a problem in the free path, as 
> above. Or maybe the PCI driver should not be allowed to request !power 
> of 2 min/max vectors.
> 
> Opinion?

My hunch is that it is an ITS driver bug: the PCI layer is allowed to
give any number of MSIs to an endpoint driver, as long as they match the
requirements of the allocation for Multi-MSI. That's the responsibility
of the ITS driver. If unbind/bind fails, it means that somehow we've
missed the freeing of the LPIs, which isn't good.

Is the device common enough that I can try and reproduce the issue? If
there's a Linux driver somewhere, I can always hack something in
emulation and find out...

Thanks,

	M.
-- 
Jazz is not dead, it just smells funny...
