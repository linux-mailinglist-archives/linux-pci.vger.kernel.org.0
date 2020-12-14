Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76BA2D9A82
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgLNPBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 10:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408301AbgLNPBA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 10:01:00 -0500
X-Gm-Message-State: AOAM531kwXxyHzgt9w7AB1sHE87Ws5OMsD/a3kDcnPuu/Vnij6DJdEAx
        ZPoX7NIddS2486jmxTddeWLchzmj61pUe+ltCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607958019;
        bh=LXVWpWfZE9VvVE2IgYvFn3+KkZDKCw4SzwfnfyyjuF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6AQrEBe6X43OuRaxoixaKEQo4Gt9qk/ZUs5sVAka4MoAaic2LEUM9IUoHogltURd
         tYiqVzKbWuyY6QMLFA3Yvu4knNzoZwjUfgRvVyHmZcIgBGOK18yuFgindMQG9BD8E4
         1a21fk1UGIGoqXGincPmI+pAQ6eUalQ/StRxfgScIQbAZpQ29hbsnEIRi28HVDTPIQ
         vLYdDODL1cRRlllAt7uxuT7wNDkCq1FFmo5pHrx+9Ed/i3eVeo8R9toNx5GRfdJSyA
         Art4I82hIwJVkMBopS3iPywCEOe6WJQtRdCWZNV6wEEjDNKCFyXF0LvIT8sfpU/JC2
         w2GmyQNbxPj0A==
X-Google-Smtp-Source: ABdhPJzGYer0XzfXO4MA/pGGs+v15vjyAYDBxFskQaROpeSLXHq+/dH47HhfCiVClPzxWTZQB+Bqm9jKWxSOUrU5pio=
X-Received: by 2002:a17:906:6713:: with SMTP id a19mr23482925ejp.468.1607958017728;
 Mon, 14 Dec 2020 07:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201209181350.GB660537@robh.at.kernel.org> <20201209184214.GV4077@smile.fi.intel.com>
 <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com> <DM6PR11MB3721054B20FE1853651B5E86DDC70@DM6PR11MB3721.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3721054B20FE1853651B5E86DDC70@DM6PR11MB3721.namprd11.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 14 Dec 2020 09:00:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL6smfyR6NvsW4BLdN02LtcMS1-==MsP3dS+xAbj6ZFfw@mail.gmail.com>
Message-ID: <CAL_JsqL6smfyR6NvsW4BLdN02LtcMS1-==MsP3dS+xAbj6ZFfw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
To:     "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 14, 2020 at 7:03 AM Wan Mohamad, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Hi Rob and Andy.
>
> Thanks for the reviews and feedback. And sorry for late reply.
> I will answer the earlier review here and add my reply
> on the two matters below.
>
> In v4, I will
> - remove the keembay_pcie_{readl,writel} wrappers,
> - remove the dead code related to unused irqs, and
> - initialize enabled interrupts to a known state.
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Friday, December 11, 2020 1:47 AM
> > To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Wan Mohamad, Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; PCI
> > <linux-pci@vger.kernel.org>; devicetree@vger.kernel.org; Mark Gross
> > <mgross@linux.intel.com>; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>
> > Subject: Re: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
> >
> > On Wed, Dec 9, 2020 at 12:41 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Wed, Dec 09, 2020 at 12:13:50PM -0600, Rob Herring wrote:
> > > > On Wed, Dec 02, 2020 at 03:31:56PM +0800, Wan Ahmad Zainie wrote:
> > >
> > > ...
> > >
> > > > > +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie,
> > > > > +bool enable) {
> > > > > +   u32 val;
> > > > > +
> > > > > +   val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_APP_CNTRL);
> > > > > +   if (enable)
> > > > > +           val |= APP_LTSSM_ENABLE;
> > > > > +   else
> > > > > +           val &= ~APP_LTSSM_ENABLE;
> > > > > +   keembay_pcie_writel(pcie, PCIE_REGS_PCIE_APP_CNTRL, val);
> > > >
> > > > If this is the only bit in this register, do you really need RMW?
> > >
> > > I think it's safer than do direct write and have something wrong on
> > > next generations of hardware.
> >
> > We have 2 Intel SoCs with 2 separate PCI drivers so far, is that really going to
> > be a concern? :( (This bit in particular is Synopsys'
> > fault. This is what happens when IP vendors just give you signals to hook up.)
> >
> > There's 2 other reasons why to not do a RMW. The firmware or bootloader
> > could also change how the register is initialized which you may or may not
> > want changed in Linux.  Second, for maintaining this code when anyone
> > familiar with this h/w disappears, I'd like to know if there's other bits in this
> > register I might want to care about.
>
> Lightning Mountain and Keem Bay belongs to two different product lines i.e.
> Atom-based family and ARM-based family, targeted for different
> market/purpose. Unfortunately, I am unable to reuse or adapt LGM PCIe driver
> code for KMB.
>
> On the first concern, firmware will also change BIT(9) of this register in EP
> mode only during its initialization. RC mode is fully initialize and controlled by
> Linux. This function is being used only in keembay_pcie_start_link(), and I have
> added an if condition to return 0 if the mode is EP mode.
>
> On the second concern, this driver will touch BIT(0) only, in RC mode.
> This driver does not change this register in EP mode.
>
> Hope my explanation clears this matter.
> And I believe we can keep this piece of code as it is.
>
> >
> > > > > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8
> > func_no,
> > > > > +                                enum pci_epc_irq_type type,
> > > > > +                                u16 interrupt_num) {
> > > > > +   struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > > > +
> > > > > +   switch (type) {
> > > > > +   case PCI_EPC_IRQ_LEGACY:
> > > > > +           /* Legacy interrupts are not supported in Keem Bay */
> > > > > +           dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > > > > +           return -EINVAL;
> > > > > +   case PCI_EPC_IRQ_MSI:
> > > > > +           return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > > > > +   case PCI_EPC_IRQ_MSIX:
> > > > > +           return dw_pcie_ep_raise_msix_irq(ep, func_no,
> > interrupt_num);
> > > > > +   default:
> > > > > +           dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > > > > +           return -EINVAL;
> > > > > +   }
> > > >
> > > > Doesn't the lack of a 'return' give a warning?
> > >
> > > Where? I don't see any lack of return.
> >
> > Is the compiler smart enough to recognize that with a return in every 'case'
> > that we don't need a return after the switch? I wouldn't have thought so, but
> > I haven't checked.
>
> I have rebuild the code with W=1 and W=3, and do not see compiler throw
> warning with regards to this piece of code. I am using gcc v9.2.
>
> Should I keep the code as it is or make the change i.e. move the last return
> outside of switch?

No, it's fine. It was just a question.

Rob
