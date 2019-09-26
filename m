Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47CFBF438
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfIZNiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 09:38:54 -0400
Received: from foss.arm.com ([217.140.110.172]:50006 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbfIZNiw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 09:38:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27CAB15AD;
        Thu, 26 Sep 2019 06:38:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 93A343F534;
        Thu, 26 Sep 2019 06:38:51 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:38:49 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mans Rullgard <mans@mansr.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 00/11] PCI dma-ranges parsing consolidation
Message-ID: <20190926133849.GF9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190926084859.GB9720@e119886-lin.cambridge.arm.com>
 <036f298c-c65c-7da2-92dc-fc80892672c1@free.fr>
 <CAL_JsqLtYYXCgGN6_t8SuPqPmQwhhRJXaf8+kxnKxLHbRQRaDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLtYYXCgGN6_t8SuPqPmQwhhRJXaf8+kxnKxLHbRQRaDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 08:11:16AM -0500, Rob Herring wrote:
> On Thu, Sep 26, 2019 at 6:20 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> >
> > [ Tweaking recipients list ]
> >
> > On 26/09/2019 10:49, Andrew Murray wrote:
> >
> > > On Tue, Sep 24, 2019 at 04:46:19PM -0500, Rob Herring wrote:
> > >
> > >> pci-rcar-gen2 is the only remaining driver doing its own dma-ranges
> > >> handling as it is still using the old ARM PCI functions. Looks like it
> > >> is the last one (in drivers/pci/).
> > >
> > > It also seems that pcie-tango is using of_pci_dma_range_parser_init
> > > and so parsing dma-ranges. Though it's using the dma_ranges for a
> > > slightly different purpose.
> 
> Seems I missed that as I only grep'ed for for_each_of_pci_range...
> 
> >
> > The rationale for that code can be found here:
> >
> >         https://patchwork.kernel.org/patch/9915469/
> >
> > NB: 1) The PCIE_TANGO_SMP8759 Kconfig symbol is marked "depends on BROKEN",
> > and 2) The driver adds TAINT_CRAP,
> > and 3) The maker of the tango platform is dead.
> 

Thanks for the context Marc, much appreciated.

Is there a path to make this driver not BROKEN? Or is this likely to bit rot?

> Given that and that I'd have to rework the probe to do the MSI range
> setup after pci_host_common_probe, I'm just going to leave this one
> alone.

I don't see any harm with that.

Thanks,

Andrew Murray

> 
> Rob
