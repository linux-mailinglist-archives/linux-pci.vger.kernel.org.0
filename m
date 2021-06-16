Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478533AA158
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhFPQeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 12:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhFPQeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 12:34:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E64461375;
        Wed, 16 Jun 2021 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861138;
        bh=HnQ8O75YA6igOLb0Of/jo3UVORF2qdfDgqTXkgouYkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WO/FaVs2gYQb9kwpCc++rVs0vsOyI0YQAsbAnsaVLlBTv2mDPwaSi5Msurlo2hZra
         rSwRuj/cXTqxBiKcMP6gsRYOrGmbk8TfRauEKsB9OnG+sEbpK6PtgfAtSyk14VDWje
         qshqKehekV94Lxmzxu8r9YxJAsP/3Z44hQvvTQWqf3CDD4XrNwzTr3m0YphnkuuIGm
         cAfg4wpG5iC8eeLA6Qpe+79beTOkQgUVfKqa17VRbNQAQQCFcOlO6I3LZL0UjUC85q
         +65YZB8U2udbdIXsU6kd8XW+hBZsaEQh9ehHtxUZ9OYqB1xumR+A3L84tXYgg2rIJk
         gxwkEciYWh9EQ==
Received: by mail-ed1-f47.google.com with SMTP id r7so3506600edv.12;
        Wed, 16 Jun 2021 09:32:18 -0700 (PDT)
X-Gm-Message-State: AOAM530BdrDXzEbG2BPkaPAdXx0chJHx86PyqYettzSTbMv2mA+ow0It
        YExWpGsPaqed8XwbBXI5Xj99JKucryGTeGsnjg==
X-Google-Smtp-Source: ABdhPJyJAoNTK4444ak3NJ1fSE0yzSt78BpFwOIM1hlvk4VKtgNeZttdovslS69pvyAlyRMaqsFXdZqp83fBezdg9f8=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr667990edt.194.1623861136799;
 Wed, 16 Jun 2021 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp> <20210524185839.GA1102116@bjorn-Precision-5520>
In-Reply-To: <20210524185839.GA1102116@bjorn-Precision-5520>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 10:32:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMdxA_yVdz6_s7XP8SsCDhwctUxG+3+jAnJs5fwyk=MA@mail.gmail.com>
Message-ID: <CAL_JsqLMdxA_yVdz6_s7XP8SsCDhwctUxG+3+jAnJs5fwyk=MA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] PCI: Visconti: Add Toshiba Visconti PCIe host
 controller driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 24, 2021 at 12:58 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kishon for cpu_addr_fixup() question]
>
> Please make the subject "PCI: visconti: Add ..." since the driver
> names are usually lower-case.  When referring to the hardware itself,
> use "Visconti", of course.
>
> On Mon, May 24, 2021 at 03:30:03PM +0900, Nobuhiro Iwamatsu wrote:
> > Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> > controller is based of Synopsys DesignWare PCIe core.
> >
> > This patch does not yet use the clock framework to control the clock.
> > This will be replaced in the future.
> >
> > v2 -> v3:
> >   - Update subject.
> >   - Wrap description in 75 columns.
> >   - Change config name to PCIE_VISCONTI_HOST.
> >   - Update Kconfig text.
> >   - Drop blank lines.
> >   - Adjusted to 80 columns.
> >   - Drop inline from functions for register access.
> >   - Changed function name from visconti_pcie_check_link_status to
> >     visconti_pcie_link_up.
> >   - Update to using dw_pcie_host_init().
> >   - Reorder these in the order of use in visconti_pcie_establish_link.
> >   - Rewrite visconti_pcie_host_init() without dw_pcie_setup_rc().
> >   - Change function name from  visconti_device_turnon() to
> >     visconti_pcie_power_on().
> >   - Unify formats such as dev_err().
> >   - Drop error label in visconti_add_pcie_port().
> >
> > v1 -> v2:
> >   - Fix typo in commit message.
> >   - Drop "depends on OF && HAS_IOMEM" from Kconfig.
> >   - Stop using the pointer of struct dw_pcie.
> >   - Use _relaxed variant.
> >   - Drop dw_pcie_wait_for_link.
> >   - Drop dbi resource processing.
> >   - Drop MSI IRQ initialization processing.
>
> Thanks for the changelog.  Please move it after the "---" line for
> future versions.  That way it won't appear in the commit log when this
> is merged.  The notes about v1->v2, v2->v3, etc are useful during
> review, but not after this is merged.
>
> > Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  drivers/pci/controller/dwc/Kconfig         |   9 +
> >  drivers/pci/controller/dwc/Makefile        |   1 +
> >  drivers/pci/controller/dwc/pcie-visconti.c | 369 +++++++++++++++++++++
> >  3 files changed, 379 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c


> > +static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
> > +{
> > +     return pci_addr - PCIE_BUS_OFFSET;
>
> This is called from __dw_pcie_prog_outbound_atu() as:
>
>   cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
>
> so I think the parameter here should be *cpu_addr*, not pci_addr.
>
> dra7xx and artpec6 also call it "pci_addr", which is at best
> confusing.
>
> I'm also confused about exactly what .cpu_addr_fixup() does.  Is it
> applying an offset that cannot be deduced from the DT description?  If
> so, *should* this offset be described in DT?

It could be perhaps, but it would be a custom property, not something
we can handle in 'ranges'. I'd rather it be implicit from the
compatible than a custom property.

AIUI, the issue is the cpu address gets masked (high bits discarded).
This can happen when the internal bus address decoding throws away
upper address bits.

For example:

0xa0000000 -> 0x20000000    -> 0x00000000
cpu addr   -> DW local addr -> PCI bus addr

DT has the first and last addresses, but iATU needs the middle and last address.

This could be just a data value rather than an ops function. While a
subtract works here, that's fragile (the DT needs to match the
#define) and I think a mask would be more appropriate.

Rob
