Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38737969D3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfHTTyF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 15:54:05 -0400
Received: from foss.arm.com ([217.140.110.172]:47424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbfHTTyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 15:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2557337;
        Tue, 20 Aug 2019 12:54:03 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CBEC3F246;
        Tue, 20 Aug 2019 12:54:03 -0700 (PDT)
Date:   Tue, 20 Aug 2019 20:54:01 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Chocron, Jonathan" <jonnyc@amazon.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 4/8] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Message-ID: <20190820195400.GH23903@e119886-lin.cambridge.arm.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
 <20190723092529.11310-5-jonnyc@amazon.com>
 <20190819182339.GD23903@e119886-lin.cambridge.arm.com>
 <5a079a466f74a866f1b17447eacb15d396478902.camel@amazon.com>
 <20190820152554.GG23903@e119886-lin.cambridge.arm.com>
 <87417da8ccea10b84c1a968700ef2ff783c751be.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87417da8ccea10b84c1a968700ef2ff783c751be.camel@amazon.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 05:06:22PM +0000, Chocron, Jonathan wrote:
> On Tue, 2019-08-20 at 16:25 +0100, Andrew Murray wrote:
> > On Tue, Aug 20, 2019 at 02:52:30PM +0000, Chocron, Jonathan wrote:
> > > On Mon, 2019-08-19 at 19:23 +0100, Andrew Murray wrote:
> > > > On Tue, Jul 23, 2019 at 12:25:29PM +0300, Jonathan Chocron wrote:
> > > > > The Root Port (identified by [1c36:0032]) doesn't support MSI-
> > > > > X. On
> > > > > some
> > > > 
> > > > Shouldn't this read [1c36:0031]?
> > > > 
> > > 
> > > Indeed. Thanks for catching this.
> > > 
> > > > 
> > > > > platforms it is configured to not advertise the capability at
> > > > > all,
> > > > > while
> > > > > on others it (mistakenly) does. This causes a panic during
> > > > > initialization by the pcieport driver, since it tries to
> > > > > configure
> > > > > the
> > > > > MSI-X capability. Specifically, when trying to access the MSI-X
> > > > > table
> > > > > a "non-existing addr" exception occurs.
> > > > > 
> > > > > Example stacktrace snippet:
> > > > > 
> > > > > [    1.632363] SError Interrupt on CPU2, code 0xbf000000 --
> > > > > SError
> > > > > [    1.632364] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-
> > > > > rc1-
> > > > > Jonny-14847-ge76f1d4a1828-dirty #33
> > > > > [    1.632365] Hardware name: Annapurna Labs Alpine V3 EVP (DT)
> > > > > [    1.632365] pstate: 80000005 (Nzcv daif -PAN -UAO)
> > > > > [    1.632366] pc : __pci_enable_msix_range+0x4e4/0x608
> > > > > [    1.632367] lr : __pci_enable_msix_range+0x498/0x608
> > > > > [    1.632367] sp : ffffff80117db700
> > > > > [    1.632368] x29: ffffff80117db700 x28: 0000000000000001
> > > > > [    1.632370] x27: 0000000000000001 x26: 0000000000000000
> > > > > [    1.632372] x25: ffffffd3e9d8c0b0 x24: 0000000000000000
> > > > > [    1.632373] x23: 0000000000000000 x22: 0000000000000000
> > > > > [    1.632375] x21: 0000000000000001 x20: 0000000000000000
> > > > > [    1.632376] x19: ffffffd3e9d8c000 x18: ffffffffffffffff
> > > > > [    1.632378] x17: 0000000000000000 x16: 0000000000000000
> > > > > [    1.632379] x15: ffffff80116496c8 x14: ffffffd3e9844503
> > > > > [    1.632380] x13: ffffffd3e9844502 x12: 0000000000000038
> > > > > [    1.632382] x11: ffffffffffffff00 x10: 0000000000000040
> > > > > [    1.632384] x9 : ffffff801165e270 x8 : ffffff801165e268
> > > > > [    1.632385] x7 : 0000000000000002 x6 : 00000000000000b2
> > > > > [    1.632387] x5 : ffffffd3e9d8c2c0 x4 : 0000000000000000
> > > > > [    1.632388] x3 : 0000000000000000 x2 : 0000000000000000
> > > > > [    1.632390] x1 : 0000000000000000 x0 : ffffffd3e9844680
> > > > > [    1.632392] Kernel panic - not syncing: Asynchronous SError
> > > > > Interrupt
> > > > > [    1.632393] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.2.0-
> > > > > rc1-
> > > > > Jonny-14847-ge76f1d4a1828-dirty #33
> > > > > [    1.632394] Hardware name: Annapurna Labs Alpine V3 EVP (DT)
> > > > > [    1.632394] Call trace:
> > > > > [    1.632395]  dump_backtrace+0x0/0x140
> > > > > [    1.632395]  show_stack+0x14/0x20
> > > > > [    1.632396]  dump_stack+0xa8/0xcc
> > > > > [    1.632396]  panic+0x140/0x334
> > > > > [    1.632397]  nmi_panic+0x6c/0x70
> > > > > [    1.632398]  arm64_serror_panic+0x74/0x88
> > > > > [    1.632398]  __pte_error+0x0/0x28
> > > > > [    1.632399]  el1_error+0x84/0xf8
> > > > > [    1.632400]  __pci_enable_msix_range+0x4e4/0x608
> > > > > [    1.632400]  pci_alloc_irq_vectors_affinity+0xdc/0x150
> > > > > [    1.632401]  pcie_port_device_register+0x2b8/0x4e0
> > > > > [    1.632402]  pcie_portdrv_probe+0x34/0xf0
> > > > > 
> > > > > Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> > > > > Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > > > ---
> > > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > > >  1 file changed, 15 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > > > > index 23672680dba7..11f843aa96b3 100644
> > > > > --- a/drivers/pci/quirks.c
> > > > > +++ b/drivers/pci/quirks.c
> > > > > @@ -2925,6 +2925,21 @@
> > > > > DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0x10a1,
> > > > >  			quirk_msi_intx_disable_qca_bug);
> > > > >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, 0xe091,
> > > > >  			quirk_msi_intx_disable_qca_bug);
> > > > > +
> > > > > +/*
> > > > > + * Amazon's Annapurna Labs 1c36:0031 Root Ports don't support
> > > > > MSI-
> > > > > X, so it
> > > > > + * should be disabled on platforms where the device
> > > > > (mistakenly)
> > > > > advertises it.
> > > > > + *
> > > > > + * The 0031 device id is reused for other non Root Port device
> > > > > types,
> > > > > + * therefore the quirk is registered for the
> > > > > PCI_CLASS_BRIDGE_PCI
> > > > > class.
> > > > > + */
> > > > > +static void quirk_al_msi_disable(struct pci_dev *dev)
> > > > > +{
> > > > > +	dev->no_msi = 1;
> > > > > +	pci_warn(dev, "Disabling MSI-X\n");
> > > > 
> > > > This will disable both MSI and MSI-X support - is this really the
> > > > intention
> > > > here? Do the root ports support MSI and legacy, or just legacy?
> > > > 
> > > 
> > > The HW should support MSI, but we currently don't have a use case
> > > for
> > > it so it hasn't been tested and therefore we are okay with
> > > disabling
> > > it.
> > 
> > OK - then the commit message and comment (for quirk_al_msi_disable)
> > should
> > probably be updated to reflect this. 
> 
> If you mean that we should explicitly state that MSI is possibly
> supported then I don't think it is very relevant here. If we decide to
> test and enable it in the future, then the new quirk (which would only
> disable MSI-x) would reflect the fact that MSI works. Sounds ok?
> 

My thought process is that 1c36:0031 probably advertises an MSI capability
reflecting that the device probably supports MSI - if there is no valid
reason for disabling MSI support then we shouldn't disable it.

It doesn't make sense to me to disable it just because that's the path of
least resistance - a better course of action would be to add support
to disable MSI-X in the kernel.

The kernel panic generated in attempting to enable MSI-X shows that this
device has a user for its MSI/MSI-X interrupts. Thus if you disabled only
MSI-X the PCIe port driver would use MSI interrupts instead - Due to
"no_msi = 1" I guess it will be using legacy.

> > Especially given that the device id
> > may be used on other device types - implying that a use-case for this
> > may later arise.
> > 
> Not sure I understood that last line. This patch is relevant only for
> the BRIDGE class 0x0031 device. The other device types, which (sadly)
> happen to re-use the dev_id, have are totally different and shouldn't
> be mixed in here.
> 

It's probably unlikely, but if 1c36:0031 was the device ID given to a
future incarnation of this hardware in a PCIe switch (which has BRIDGE
class), then using legacy interrupts instead of MSI wouldn't be ideal
and an un-necessary limitation.

This is why adding a comment to indicate that MSI may work but hasn't
been tested may be helpful for others in the future.

> > > 
> > > For future knowledge, how can just MSI-X be disabled?
> > > I see that in pcie_port_enable_irq_vec(), the pcieport driver calls
> > > pci_alloc_irq_vectors() with PCI_IRQ_MSIX | PCI_IRQ_MSI. And
> > > internally, both __pci_enable_msix_range() and
> > > __pci_enable_msi_range()
> > > use pci_msi_supported() which doesn't differentiate between MSI and
> > > MSI-x.
> > 
> > The documentation [1] would suggest that once upon a time
> > pci_disable_msix
> > was used - but now should let pci_alloc_irq_vectors cap the max
> > number
> > of vectors. However in your case it's the PCIe port driver that is
> > attempting
> > to allocate MSI-X's and so the solution isn't an obvious one.
> > 
> > Setting dev->msix_enabled to false (i.e. through pci_disable_msix)
> > would
> > result in an un-necessary WARN_ON_ONCE. 
> 
> Per my understanding, it seems that dev->msix_enabled indicates if the
> MSI-X capability has already been enabled or not, and not as an
> indication if it is supported by the device. If that is the case, then
> not sure pci_disable_msix() would result in the desired effect.

Yes this isn't the right approach.

> 
> > I think you'd need to ensure
> > devi->msix_cap is NULL (which makes sense as your hardware shouldn't
> > be
> > exposing this capability).
> > 
> > I guess the right way of achieving this would be through a quirk,
> > though you'd
> > be the first to do this and you'd have to ensure the quirk runs
> > before
> > anyone tests for msix_cap.
> > 
> > That's my view, though others may have different suggestions.
> > 
> I think that maybe a dev->no_msix field should be added and then a
> corresponding pci_msix_supported() function as well. I'd be glad to
> take it offline or on a dedicated thread, but it shouldn't block this
> patchset.

Thanks,

Andrew Murray

> 
> > [1] Documentation/PCI/msi-howto.rst
> > 
> > Thanks,
> > 
> > Andrew Murray
> > 
> > > 
> > > > Thanks,
> > > > 
> > > > Andrew Murray
> > > > 
> > > > > +}
> > > > > +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMAZON_ANNAPURNA_L
> > > > > ABS,
> > > > > 0x0031,
> > > > > +			      PCI_CLASS_BRIDGE_PCI, 8,
> > > > > quirk_al_msi_disable);
> > > > >  #endif /* CONFIG_PCI_MSI */
> > > > >  
> > > > >  /*
> > > > > -- 
> > > > > 2.17.1
> > > > > 
