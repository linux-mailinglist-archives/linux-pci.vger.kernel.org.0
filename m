Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EF02B9039
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgKSKh1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 05:37:27 -0500
Received: from foss.arm.com ([217.140.110.172]:52546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgKSKh1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Nov 2020 05:37:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95D6A1396;
        Thu, 19 Nov 2020 02:37:26 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E8243F718;
        Thu, 19 Nov 2020 02:37:25 -0800 (PST)
Date:   Thu, 19 Nov 2020 10:37:20 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Chen Baozi <chenbaozi@phytium.com.cn>
Cc:     Marc Zyngier <maz@kernel.org>, Guohanjun <guohanjun@huawei.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH V2] acpi/irq: Add stacked IRQ domain support to PCI
 interrupt link
Message-ID: <20201119103720.GA19138@e121166-lin.cambridge.arm.com>
References: <20201117134214.970-1-chenbaozi@phytium.com.cn>
 <20201118095129.GA20571@e121166-lin.cambridge.arm.com>
 <17EDC3AB-FF11-4624-912E-95832DB20804@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17EDC3AB-FF11-4624-912E-95832DB20804@phytium.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 10:05:29PM +0800, Chen Baozi wrote:
> Hi Lorenzo,
> 
> > On Nov 18, 2020, at 5:51 PM, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > 
> > On Tue, Nov 17, 2020 at 09:42:14PM +0800, Chen Baozi wrote:
> >> Some PCIe designs require software to do extra acknowledgements for
> >> legacy INTx interrupts. If the driver is written only for device tree,
> >> things are simple. In that case, a new driver can be written under
> >> driver/pci/controller/ with a DT node of PCIe host written like:
> >> 
> >>  pcie {
> >>    ...
> >>    interrupt-map = <0 0 0  1  &pcie_intc 0>,
> >>                    <0 0 0  2  &pcie_intc 1>,
> >>                    <0 0 0  3  &pcie_intc 2>,
> >>                    <0 0 0  4  &pcie_intc 3>;
> >> 
> >>    pcie_intc: legacy-interrupt-controller {
> >>      interrupt-controller;
> >>      #interrupt-cells = <1>;
> >>      interrupt-parent = <&gic>;
> >>      interrupts = <0 226 4>;
> >>    };
> >>  };
> >> 
> >> Similar designs can be found on Aardvark, MediaTek Gen2 and Socionext
> >> UniPhier PCIe controller at the moment. Essentially, those designs are
> >> supported by inserting an extra interrupt controller between PCIe host
> >> and GIC and parse the topology in a DT-based PCI controller driver.
> >> As we turn to ACPI, All the PCIe hosts are described the same ID of
> >> "PNP0A03" and share driver/acpi/pci_root.c. It comes to be a problem
> >> to make this kind of PCI INTx work under ACPI.
> > 
> > In this respect this patch is a minor detail. The major detail is how
> > those host controllers are going to probe and initialize with ACPI and I
> > am against merging this patch stand alone with no user before
> > understanding what you really want to do with those host controller
> > drivers in the ACPI world.
> > 
> > Side note, there is ongoing work for a generic interrupt MUX:
> > 
> > https://bugzilla.tianocore.org/show_bug.cgi?id=2995
> > 
> > If we ever come to support those MUXes with ACPI that must be a
> > starting point, the binding above can be your first "user".
> > 
> > I still have reservations about bootstrapping the host controllers
> > you mentioned in platforms with no firmware support whatsoever for
> > PCI initialization (eg address decoders, link bring-up, etc. - the
> > ACPI host bridge model relies on FW to carry out that initialization)
> > with ACPI - I would like to see the whole picture first.
> 
> Frankly, I’m also waiting for my first “user” to be announced at the
> moment, so that I can make the whole picture clearer. And it is why I
> mark this patch as an RFC. 

AFAIK none of the host controllers requiring this IRQ muxing is shipped
with a firmware stack that can bootstrap them with ACPI.

That's why I think this patch is a thought exercise, there is not much
to talk about.

> Yes. I admit it is a little weird to add another interrupt controller
> between the GIC and INTx device. But if it is not only about
> initialization but also about hooking into the INTx processing (e.g.,
> introduce an extra ack operation...), it seems we cannot only rely
> on FW. I have looked for a FW solution without introducing a new
> driver later but failed... I’m happy to be fixed if there is a pure
> FW solution.

I did not say that to solve the INTX muxing we can use FW. I said that
to probe the host controllers that require this muxing there must be
firmware in place (to allow probing them with ACPI) before we look at
solving the PCI INTX muxing issue.

We should not solve issues that don't exist ;-)

Thanks,
Lorenzo
