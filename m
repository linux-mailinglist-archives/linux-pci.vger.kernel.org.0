Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C7266353
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgIKQON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 12:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgIKQOE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 12:14:04 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA83F22206;
        Fri, 11 Sep 2020 16:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599840841;
        bh=sXRzPln0BMLE/7nS5D7QhnT7C4au3MJsFA391AW4wbo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v7DC9Bip64OBV/WMAr4pP3NuV6b4zeYDPdKyB539mVBiSsXMvuB3QHVzIc6OcOnXP
         cp0zQ2TDe15HODk5Qnf4vnMzYRICCRhNIMvxixTovIIQn/2emwTSx9uNOvoapsQpus
         CptHXPcGFpARr0zFUUEZBsXszbl6ID53vznTC1eo=
Received: by mail-oi1-f174.google.com with SMTP id x69so9928244oia.8;
        Fri, 11 Sep 2020 09:14:01 -0700 (PDT)
X-Gm-Message-State: AOAM531mV8EvUBCQubhK7bPakw5/o37P66jCfIB1AxRKUcKBxi4FdpGg
        MJDIoeJNLsrJ9J1jsUHIiIeMdwdqTGFNkhP+iw==
X-Google-Smtp-Source: ABdhPJwHC3T4JK9v762uzFVSzav/olYzYMUs3vTXsKGdnh0N8gBkZJOAEmUxtmSbbW2tXVBlQio/reghd8R6hSx8txI=
X-Received: by 2002:aca:4cc7:: with SMTP id z190mr1707432oia.147.1599840840985;
 Fri, 11 Sep 2020 09:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-9-james.quinlan@broadcom.com> <20200910161710.GA456155@bogus>
 <CA+-6iNwSua4tHvkw-PyGs34f7oRpsdJ38kT9pJ_Sicno=z8u1Q@mail.gmail.com>
In-Reply-To: <CA+-6iNwSua4tHvkw-PyGs34f7oRpsdJ38kT9pJ_Sicno=z8u1Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Sep 2020 10:13:49 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJJCgheSAfFRRWvDeG2uRBucJEOMvC-RLS9Wh1HfOy_YQ@mail.gmail.com>
Message-ID: <CAL_JsqJJCgheSAfFRRWvDeG2uRBucJEOMvC-RLS9Wh1HfOy_YQ@mail.gmail.com>
Subject: Re: [PATCH v11 08/11] PCI: brcmstb: Set additional internal memory
 DMA viewport sizes
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 9:28 AM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Thu, Sep 10, 2020 at 12:17 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Aug 24, 2020 at 03:30:21PM -0400, Jim Quinlan wrote:
> > > The Raspberry Pi (RPI) is currently the only chip using this driver
> > > (pcie-brcmstb.c).  There, only one memory controller is used, without an
> > > extension region, and the SCB0 viewport size is set to the size of the
> > > first and only dma-range region.  Other BrcmSTB SOCs have more complicated
> > > memory configurations that require setting additional viewport sizes.
> > >
> > > BrcmSTB PCIe controllers are intimately connected to the memory
> > > controller(s) on the SOC.  The SOC may have one to three memory
> > > controllers; they are indicated by the term SCBi.  Each controller has a
> > > base region and an optional extension region.  In physical memory, the base
> > > and extension regions of a controller are not adjacent, but in PCIe-space
> > > they are.
> > >
> > > There is a "viewport" for each memory controller that allows DMA from
> > > endpoint devices.  Each viewport's size must be set to a power of two, and
> > > that size must be equal to or larger than the amount of memory each
> > > controller supports which is the sum of base region and its optional
> > > extension.  Further, the 1-3 viewports are also adjacent in PCIe-space.
> > >
> > > Unfortunately the viewport sizes cannot be ascertained from the
> > > "dma-ranges" property so they have their own property, "brcm,scb-sizes".
> > > This is because dma-range information does not indicate what memory
> > > controller it is associated.  For example, consider the following case
> > > where the size of one dma-range is 2GB and the second dma-range is 1GB:
> > >
> > >     /* Case 1: SCB0 size set to 4GB */
> > >     dma-range0: 2GB (from memc0-base)
> > >     dma-range1: 1GB (from memc0-extension)
> > >
> > >     /* Case 2: SCB0 size set to 2GB, SCB1 size set to 1GB */
> > >     dma-range0: 2GB (from memc0-base)
> > >     dma-range1: 1GB (from memc0-extension)
> > >
> > > By just looking at the dma-ranges information, one cannot tell which
> > > situation applies. That is why an additional property is needed.  Its
> > > length indicates the number of memory controllers being used and each value
> > > indicates the viewport size.
> > >
> > > Note that the RPI DT does not have a "brcm,scb-sizes" property value,
> > > as it is assumed that it only requires one memory controller and no
> > > extension.  So the optional use of "brcm,scb-sizes" will be backwards
> > > compatible.
> > >
> > > One last layer of complexity exists: all of the viewports sizes must be
> > > added and rounded up to a power of two to determine what the "BAR" size is.
> > > Further, an offset must be given that indicates the base PCIe address of
> > > this "BAR".  The use of the term BAR is typically associated with endpoint
> > > devices, and the term is used here because the PCIe HW may be used as an RC
> > > or an EP.  In the former case, all of the system memory appears in a single
> > > "BAR" region in PCIe memory.  As it turns out, BrcmSTB PCIe HW is rarely
> > > used in the EP role and its system of mapping memory is an artifact that
> > > requires multiple dma-ranges regions.
> > >
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > > ---
> > >  drivers/pci/controller/pcie-brcmstb.c | 68 ++++++++++++++++++++-------
> > >  1 file changed, 50 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> > > index 041b8d109563..7150eaa803c2 100644
> > > --- a/drivers/pci/controller/pcie-brcmstb.c
> > > +++ b/drivers/pci/controller/pcie-brcmstb.c
> > > @@ -57,6 +57,8 @@
> > >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK     0x300000
> > >  #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_128              0x0
> > >  #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK          0xf8000000
> > > +#define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK          0x07c00000
> > > +#define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK          0x0000001f
> >
> > Perhaps make 0-2 an arg and then you can just do:
> >
> > u32p_replace_bits(&tmp, scb_size_val, PCIE_MISC_MISC_CTRL_SCB_SIZE_MASK(memc))
>
> I cannot get this to work.  In this case u32p_replace_bits requires
> that the mask is a compile-time constant; when "memc" is a variable I
> don't see how to do this.
> >
> > >
> > >  #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO             0x400c
> > >  #define PCIE_MEM_WIN0_LO(win)        \
> > > @@ -154,6 +156,7 @@
> > >  #define SSC_STATUS_OFFSET            0x1
> > >  #define SSC_STATUS_SSC_MASK          0x400
> > >  #define SSC_STATUS_PLL_LOCK_MASK     0x800
> > > +#define PCIE_BRCM_MAX_MEMC           3
> > >
> > >  #define IDX_ADDR(pcie)                       (pcie->reg_offsets[EXT_CFG_INDEX])
> > >  #define DATA_ADDR(pcie)                      (pcie->reg_offsets[EXT_CFG_DATA])
> > > @@ -259,6 +262,8 @@ struct brcm_pcie {
> > >       const int               *reg_field_info;
> > >       enum pcie_type          type;
> > >       struct reset_control    *rescal;
> > > +     int                     num_memc;
> > > +     u64                     memc_size[PCIE_BRCM_MAX_MEMC];
> > >  };
> > >
> > >  /*
> > > @@ -714,22 +719,44 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> > >                                                       u64 *rc_bar2_offset)
> > >  {
> > >       struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > -     struct device *dev = pcie->dev;
> > >       struct resource_entry *entry;
> > > +     struct device *dev = pcie->dev;
> > > +     u64 lowest_pcie_addr = ~(u64)0;
> > > +     int ret, i = 0;
> > > +     u64 size = 0;
> > >
> > > -     entry = resource_list_first_type(&bridge->dma_ranges, IORESOURCE_MEM);
> > > -     if (!entry)
> > > -             return -ENODEV;
> > > +     resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > > +             u64 pcie_beg = entry->res->start - entry->offset;
> > >
> > > +             size += entry->res->end - entry->res->start + 1;
> > > +             if (pcie_beg < lowest_pcie_addr)
> > > +                     lowest_pcie_addr = pcie_beg;
> > > +     }
> > >
> > > -     /*
> > > -      * The controller expects the inbound window offset to be calculated as
> > > -      * the difference between PCIe's address space and CPU's. The offset
> > > -      * provided by the firmware is calculated the opposite way, so we
> > > -      * negate it.
> > > -      */
> > > -     *rc_bar2_offset = -entry->offset;
> > > -     *rc_bar2_size = 1ULL << fls64(entry->res->end - entry->res->start);
> > > +     if (lowest_pcie_addr == ~(u64)0) {
> > > +             dev_err(dev, "DT node has no dma-ranges\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     ret = of_property_read_variable_u64_array(pcie->np, "brcm,scb-sizes", pcie->memc_size, 1,
> > > +                                               PCIE_BRCM_MAX_MEMC);
> > > +
> > > +     if (ret <= 0) {
> > > +             /* Make an educated guess */
> > > +             pcie->num_memc = 1;
> > > +             pcie->memc_size[0] = 1ULL << fls64(size - 1);
> >
> > Use roundup_pow_of_two()
> The reason I didn't use roundup_pow_of_two() is that it returns a
> ulong which on ARM is 32bits and cannot represent  4GB.

Guess time for a roundup_pow_of_two_64... Anyways, save that for another day.

Reviewed-by: Rob Herring <robh@kernel.org>
