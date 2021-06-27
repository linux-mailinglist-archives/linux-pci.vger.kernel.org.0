Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA23B5099
	for <lists+linux-pci@lfdr.de>; Sun, 27 Jun 2021 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhF0ADR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Jun 2021 20:03:17 -0400
Received: from mo-csw1116.securemx.jp ([210.130.202.158]:35002 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhF0ADQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Jun 2021 20:03:16 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 15R00SVB011057; Sun, 27 Jun 2021 09:00:28 +0900
X-Iguazu-Qid: 2wGr6xj2Av23yqJIaQ
X-Iguazu-QSIG: v=2; s=0; t=1624752027; q=2wGr6xj2Av23yqJIaQ; m=JWDH5ldToPndZdG/ZCv/gnc4JZgTuIDCsOg5hq5hK6c=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1111) id 15R00PaA021429
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 27 Jun 2021 09:00:26 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 5A8211000C4;
        Sun, 27 Jun 2021 09:00:25 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 15R00OM0007276;
        Sun, 27 Jun 2021 09:00:24 +0900
Date:   Sun, 27 Jun 2021 09:00:23 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 2/3] PCI: Visconti: Add Toshiba Visconti PCIe host
 controller driver
X-TSB-HOP: ON
Message-ID: <20210627000023.54t4vz5wvva525ng@toshiba.co.jp>
References: <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210524185839.GA1102116@bjorn-Precision-5520>
 <CAL_JsqLMdxA_yVdz6_s7XP8SsCDhwctUxG+3+jAnJs5fwyk=MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLMdxA_yVdz6_s7XP8SsCDhwctUxG+3+jAnJs5fwyk=MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


Thanks for your comment.

On Wed, Jun 16, 2021 at 10:32:05AM -0600, Rob Herring wrote:
> On Mon, May 24, 2021 at 12:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Kishon for cpu_addr_fixup() question]
> >
> > Please make the subject "PCI: visconti: Add ..." since the driver
> > names are usually lower-case.  When referring to the hardware itself,
> > use "Visconti", of course.
> >
> > On Mon, May 24, 2021 at 03:30:03PM +0900, Nobuhiro Iwamatsu wrote:
> > > Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> > > controller is based of Synopsys DesignWare PCIe core.
> > >
> > > This patch does not yet use the clock framework to control the clock.
> > > This will be replaced in the future.
> > >
> > > v2 -> v3:
> > >   - Update subject.
> > >   - Wrap description in 75 columns.
> > >   - Change config name to PCIE_VISCONTI_HOST.
> > >   - Update Kconfig text.
> > >   - Drop blank lines.
> > >   - Adjusted to 80 columns.
> > >   - Drop inline from functions for register access.
> > >   - Changed function name from visconti_pcie_check_link_status to
> > >     visconti_pcie_link_up.
> > >   - Update to using dw_pcie_host_init().
> > >   - Reorder these in the order of use in visconti_pcie_establish_link.
> > >   - Rewrite visconti_pcie_host_init() without dw_pcie_setup_rc().
> > >   - Change function name from  visconti_device_turnon() to
> > >     visconti_pcie_power_on().
> > >   - Unify formats such as dev_err().
> > >   - Drop error label in visconti_add_pcie_port().
> > >
> > > v1 -> v2:
> > >   - Fix typo in commit message.
> > >   - Drop "depends on OF && HAS_IOMEM" from Kconfig.
> > >   - Stop using the pointer of struct dw_pcie.
> > >   - Use _relaxed variant.
> > >   - Drop dw_pcie_wait_for_link.
> > >   - Drop dbi resource processing.
> > >   - Drop MSI IRQ initialization processing.
> >
> > Thanks for the changelog.  Please move it after the "---" line for
> > future versions.  That way it won't appear in the commit log when this
> > is merged.  The notes about v1->v2, v2->v3, etc are useful during
> > review, but not after this is merged.
> >
> > > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > ---
> > >  drivers/pci/controller/dwc/Kconfig         |   9 +
> > >  drivers/pci/controller/dwc/Makefile        |   1 +
> > >  drivers/pci/controller/dwc/pcie-visconti.c | 369 +++++++++++++++++++++
> > >  3 files changed, 379 insertions(+)
> > >  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> 
> 
> > > +static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
> > > +{
> > > +     return pci_addr - PCIE_BUS_OFFSET;
> >
> > This is called from __dw_pcie_prog_outbound_atu() as:
> >
> >   cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
> >
> > so I think the parameter here should be *cpu_addr*, not pci_addr.
> >
> > dra7xx and artpec6 also call it "pci_addr", which is at best
> > confusing.
> >
> > I'm also confused about exactly what .cpu_addr_fixup() does.  Is it
> > applying an offset that cannot be deduced from the DT description?  If
> > so, *should* this offset be described in DT?
> 
> It could be perhaps, but it would be a custom property, not something
> we can handle in 'ranges'. I'd rather it be implicit from the
> compatible than a custom property.
> 
> AIUI, the issue is the cpu address gets masked (high bits discarded).
> This can happen when the internal bus address decoding throws away
> upper address bits.
> 
> For example:
> 
> 0xa0000000 -> 0x20000000    -> 0x00000000
> cpu addr   -> DW local addr -> PCI bus addr
> 
> DT has the first and last addresses, but iATU needs the middle and last address.
> 
> This could be just a data value rather than an ops function. While a
> subtract works here, that's fragile (the DT needs to match the
> #define) and I think a mask would be more appropriate.a

In this SoC specification, the CPU bus outputs the offset value from
0x40000000 to the PCIE bus, so 0x40000000 is subtracted from the CPU
bus address. This 0x40000000 is also based on io_base from DT.
Therefore, how about the following processing?

return cpu_addr - pp->io_base;

If I use a mask, it will be as follows.

return cpu_addr & ~pp->io_base;

Best regards,
  Nobuhiro
