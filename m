Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189CC2D63F9
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 18:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392763AbgLJRru (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 12:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387836AbgLJRrr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 12:47:47 -0500
X-Gm-Message-State: AOAM531pnpgy2uvZkn1NAz5umi0HkwXy6S5KsAJ7fe58NINkGQ2HulNq
        3AkKtkHjpcdmMQTeEG+Bw2/nlOaWg9OYR0ktyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607622426;
        bh=Pat6PRh+dwRywkKsNXWK62l5b4kJVX0bFiyGi7EimG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pIrjzr6DB9EHkGYQooMHi5S8wcIUxxiRZjNYS22D9bY6SxuQ+174YNsra8LM8dOuv
         taglDRe8U4Xe1Wi80rJk4btCqarzAyxZ8cGe86gPNPFm/mU8tJJouIZfTNI55zHa3w
         M2eJ21sNyEiNxHljsIef1JEtppjJb8iXIqOPFcPaTeuL0xhIZ1vGWxbRPR0sJhmiJf
         CX6DWc8AQhMTx/RE/4FmIPAPNakLlvYeI6sl8Tvm3i/BCzn1VuLaNL1UJkg+Ne6udh
         TqxF8WlJkkrI55tGTyO622xK6oEHYYqUIeuEyXykpjvaPLpYxcxHft+nZNZmxAfkez
         FpU92eGUD64Kg==
X-Google-Smtp-Source: ABdhPJyoC806uyQTMX8flHzurevo7QjpXk2mghbu0LOtVbWGcxPBT5pSjkUuIgCMw6GMH3KnJNskInymF8tmDd4BC6o=
X-Received: by 2002:a05:6214:c23:: with SMTP id a3mr10252530qvd.4.1607622420671;
 Thu, 10 Dec 2020 09:47:00 -0800 (PST)
MIME-Version: 1.0
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201209181350.GB660537@robh.at.kernel.org> <20201209184214.GV4077@smile.fi.intel.com>
In-Reply-To: <20201209184214.GV4077@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Dec 2020 11:46:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com>
Message-ID: <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Mark Gross <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 9, 2020 at 12:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Dec 09, 2020 at 12:13:50PM -0600, Rob Herring wrote:
> > On Wed, Dec 02, 2020 at 03:31:56PM +0800, Wan Ahmad Zainie wrote:
>
> ...
>
> > > +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie, bool enable)
> > > +{
> > > +   u32 val;
> > > +
> > > +   val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_APP_CNTRL);
> > > +   if (enable)
> > > +           val |= APP_LTSSM_ENABLE;
> > > +   else
> > > +           val &= ~APP_LTSSM_ENABLE;
> > > +   keembay_pcie_writel(pcie, PCIE_REGS_PCIE_APP_CNTRL, val);
> >
> > If this is the only bit in this register, do you really need RMW?
>
> I think it's safer than do direct write and have something wrong on next
> generations of hardware.

We have 2 Intel SoCs with 2 separate PCI drivers so far, is that
really going to be a concern? :( (This bit in particular is Synopsys'
fault. This is what happens when IP vendors just give you signals to
hook up.)

There's 2 other reasons why to not do a RMW. The firmware or
bootloader could also change how the register is initialized which you
may or may not want changed in Linux.  Second, for maintaining this
code when anyone familiar with this h/w disappears, I'd like to know
if there's other bits in this register I might want to care about.

> > > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > +                                enum pci_epc_irq_type type,
> > > +                                u16 interrupt_num)
> > > +{
> > > +   struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +
> > > +   switch (type) {
> > > +   case PCI_EPC_IRQ_LEGACY:
> > > +           /* Legacy interrupts are not supported in Keem Bay */
> > > +           dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > > +           return -EINVAL;
> > > +   case PCI_EPC_IRQ_MSI:
> > > +           return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > > +   case PCI_EPC_IRQ_MSIX:
> > > +           return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > > +   default:
> > > +           dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > > +           return -EINVAL;
> > > +   }
> >
> > Doesn't the lack of a 'return' give a warning?
>
> Where? I don't see any lack of return.

Is the compiler smart enough to recognize that with a return in every
'case' that we don't need a return after the switch? I wouldn't have
thought so, but I haven't checked.

Rob
