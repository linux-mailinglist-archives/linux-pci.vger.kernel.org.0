Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C4105B9A
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 22:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfKUVHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 16:07:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40441 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKUVHe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 16:07:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so4842714ljg.7;
        Thu, 21 Nov 2019 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IUXpjC49KEQJCzAEEvmy5mqN3iAhTQoOXVRArUIlNIk=;
        b=cJ3ypQjlm9KEg1GvcCTXeIgrnqWfHAqlxmfaizpmQ+EY4vTakqFsv09Ghl9+303Fl8
         D/VZvGusI+pYmRvTYqeqwdJmlu/Qc9837OHW4z+TR0M9u1UO57xWuiEp/L/HeSeLnjqk
         XEKAYB8JIIMJnWp1LZjYr6sMBUJWYfRtGtipdz0GKfHCo3WvQ9SpnsnzdfQT+k0yJUH3
         peFC1NHWg7CNYgnM10mLYE2thP1p2X3sA2N4fF6O0hgIXtt35odAQF4sJmZWxmOrguL2
         +yksKQ+CYDpfc9P3s361EL66ShX8XsOX17CZL4pQgIoCONB0/rrR7x1opA3+dbIgsCxQ
         RH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUXpjC49KEQJCzAEEvmy5mqN3iAhTQoOXVRArUIlNIk=;
        b=m5kzE81896m4ZV4nAVTuMB6hW+xgm8hlYM2EnjPU+eHa10I5VObUXOIuIpjpU3qA4K
         DAOgpxmUEkRStLa7E4wpB/NQkLhZikJAXj4fldkE9+1SZLdbXgwbAtKq027PWRm+Z57g
         LZbGt2chyhX9QEl2C4zx/tAcraDvEENwKWaPV7aHZqQ7gUNXpUwzcTDgdjZuQznFGHfk
         hIw4deac7RL/O8Rh0YIkMLoWjkt6gSxTJ31rvg17F0KpMvLFudMZU67/6Okj/wUgqXkJ
         VXaUIFc7TLPVkI8uQdKt8yLkESwUizUhMqOiXobjXzSHZHKiP2On2nU1/pwdq6sTbYIt
         5iwA==
X-Gm-Message-State: APjAAAXaH4bP1nmrrI4yMVo6pJyF1D8kydwlVmAzeEnM8+W1xKc0uKSv
        FKVoWNqKKbPL5OEZeFmZECxU7U5eIFx2p1Fihz0=
X-Google-Smtp-Source: APXvYqzYZpQ7ubdab4N/uQhFs+5HchNGRhYsSCkC6BqvLwMIUwarlG0cxyJehUDaVg1/zDiRVjrD6m2WTsoLu8G3vwM=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr8700877ljg.249.1574370450479;
 Thu, 21 Nov 2019 13:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20191112155926.16476-1-nsaenzjulienne@suse.de>
 <20191112155926.16476-5-nsaenzjulienne@suse.de> <20191119162502.GS43905@e119886-lin.cambridge.arm.com>
 <7e1be0bdcf303224a3fe225654a3c2391207f9eb.camel@suse.de> <20191121120319.GW43905@e119886-lin.cambridge.arm.com>
 <276d4160bbe6a4e8225bbd836f43d40da41d25f1.camel@suse.de>
In-Reply-To: <276d4160bbe6a4e8225bbd836f43d40da41d25f1.camel@suse.de>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Thu, 21 Nov 2019 16:07:19 -0500
Message-ID: <CANCKTBuoSkmAiY4yUuNpT-GwhS7LJv79L910UvcrPgPpMz=YGg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] PCI: brcmstb: add Broadcom STB PCIe host
 controller driver
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>, mbrugger@suse.com,
        maz@kernel.org, Phil Elwell <phil@raspberrypi.org>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Eric Anholt <eric@anholt.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 8:02 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Andrew,
>
> On Thu, 2019-11-21 at 12:03 +0000, Andrew Murray wrote:
> > > > > +static void brcm_pcie_set_outbound_win(struct brcm_pcie *pcie,
> > > > > +                                      unsigned int win, phys_addr_t
> > > > > cpu_addr,
> > > > > +                                      dma_addr_t  pcie_addr, dma_addr_t
> > > > > size)
> > > > > +{
> > > > > +       phys_addr_t cpu_addr_mb, limit_addr_mb;
> > > > > +       void __iomem *base = pcie->base;
> > > > > +       u32 tmp;
> > > > > +
> > > > > +       /* Set the base of the pcie_addr window */
> > > > > +       bcm_writel(lower_32_bits(pcie_addr) + MMIO_ENDIAN,
> > > > > +                  base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + (win * 8));
> > > > > +       bcm_writel(upper_32_bits(pcie_addr),
> > > > > +                  base + PCIE_MISC_CPU_2_PCIE_MEM_WIN0_HI + (win * 8));
> > > > > +
> > > > > +       cpu_addr_mb = cpu_addr >> 20;
> > > > > +       limit_addr_mb = (cpu_addr + size - 1) >> 20;
> > > > > +
> > > > > +       /* Write the addr base low register */
> > > > > +       WR_FLD_WITH_OFFSET(base, (win * 4),
> > > > > +                          PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
> > > > > +                          BASE, cpu_addr_mb);
> > > > > +       /* Write the addr limit low register */
> > > > > +       WR_FLD_WITH_OFFSET(base, (win * 4),
> > > > > +                          PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT,
> > > > > +                          LIMIT, limit_addr_mb);
> > > > > +
> > > > > +       /* Write the cpu addr high register */
> > > > > +       tmp = (u32)(cpu_addr_mb >>
> > > > > +               PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS);
> > > >
> > > > Despite the name _MASK_BITS, this isn't being used as a mask. Is this
> > > > making
> > > > some assumption about the value of cpu_addr from the DT?
> > >
> > > It should be read _NUM_MASK_BITS. It contains the number of set bits on that
> > > specific mask. I agree it's not ideal. I think I'll be able to do away with
> > > it
> > > using the bitfield.h macros.
> >
> > Also why do you have a define for
> > PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_NUM_MASK_BITS but not the '20' shift
> > used for the low registers?
>
> Good point, I'm changing it to something more explicit:
>
>         cpu_addr_mb = cpu_addr / SZ_1M;
>
> As for [...]_NUM_MASK_BITS I'm looking for a smart/generic way to calculate it
> from the actual mask. No luck so far. If not, I think I'll simply leave it as
> is for now.
>
> > > FYI, What's happening here is that we have to save the CPU address range
> > > (which
> > > is already shifted right 20 positions) in two parts, the lower 12 bits go
> > > into
> > > PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT while the higher 8 bits go into
> > > PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_HI or
> > > PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI.
> >
> > The hardware spec require bits 31:20 of the address, and the high registers
> > require 39:32 right?
>
> Yes, that's it.
>
> > (Apologies, the indirection by the WR_FLD_** macros easily confuses me. These
> > type of macros are helpful, or rather would be if the whole kernel used them.
> > I think they can add confusion when each driver has its own set of similar
> > macros. This is why its *really* helpful to use any existing macros in the
> > kernel - and only invent new ones if needed).
>
> I agree it's pretty confusing, I think v3, using bitfield.h as much as
> possible, looks substantially more welcoming.

The reason we use custom macros is because we'd like to keep the
register names the same as the HW declares and our internal tools
support.  As you may have noticed, our register names are unusually
long and it is hard to fit a simple read or write field assignment
within 80 columns w/o using custom macros tailored to our register
names' format.

Perhaps Nicolas can pull a rabbit out of a hat and use Linux macros
while keeping our long register names, but if he has to use his own
shorter register names it will become harder for Broadcom developers
to debug this driver.

Thanks,
Jim

>
> > > [...]
> > >
> > > > > +static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct
> > > > > brcm_pcie
> > > > > *pcie,
> > > > > +                                                       u64
> > > > > *rc_bar2_size,
> > > > > +                                                       u64
> > > > > *rc_bar2_offset)
> > > > > +{
> > > > > +       struct pci_host_bridge *bridge =
> > > > > pci_host_bridge_from_priv(pcie);
> > > > > +       struct device *dev = pcie->dev;
> > > > > +       struct resource_entry *entry;
> > > > > +       u64 total_mem_size = 0;
> > > > > +
> > > > > +       *rc_bar2_offset = -1;
> > > > > +
> > > > > +       resource_list_for_each_entry(entry, &bridge->dma_ranges) {
> > > > > +               /*
> > > > > +                * We're promised the RC will provide a contiguous view
> > > > > of
> > > > > +                * memory to downstream devices. We can then infer the
> > > > > +                * rc_bar2_offset from the lower available dma-range
> > > > > offset.
> > > > > +                */
> > > > > +               if (entry->offset < *rc_bar2_offset)
> > > > > +                       *rc_bar2_offset = entry->offset;
> > > > > +
> > > > > +               total_mem_size += entry->res->end - entry->res->start +
> > > > > 1;
> > > >
> > > > This requires that if there are multiple dma-ranges, then there are no
> > > > gaps
> > > > between them right?
> > >
> > > Yes, the PCI view of inbound memory will always be gapless. See an example
> > > here: https://patchwork.kernel.org/patch/10605957/
> >
> > Thanks for the reference.
> >
> >
> > > That said, iterating over the dma-ranges is not strictly necessary for now
> > > as
> > > RPi4 is assured to only need one. If that's bothering you I can always
> > > remove
> > > it for now.
> >
> > One purpose of this function is to validate that the information given in the
> > device tree is valid - I've seen other feedback on these lists where the view
> > is taken that 'it's not the job of the kernel to validate the DT'. Subscribing
> > to this view would be a justification for removing this validation -
> > especially
> > given that the bindings you include have only one dma-range (in any case if
> > there are constraints you ought to include them in the binding document).
> >
> > Though the problem with this point of view is that if the DT is wrong, it may
> > be possible for the driver to work well enough to do some function but with
> > some horrible side effects that are difficult to track down to a bad DT.
> >
> > If you assume the DT will only have one range (at least for the Pi) then this
> > code will never be used and so can probably be removed.
>
> Ok, less is more, I'll simplify it.
>
> [...]
>
> > > > > +                       continue;
> > > > > +
> > > > > +               if (num_out_wins >= BRCM_NUM_PCIE_OUT_WINS) {
> > > > > +                       dev_err(pcie->dev, "too many outbound wins\n");
> > > > > +                       return -EINVAL;
> > > > > +               }
> > > > > +
> > > > > +               brcm_pcie_set_outbound_win(pcie, num_out_wins, res-
> > > > > >start,
> > > > > +                                          res->start - entry->offset,
> > > > > +                                          res->end - res->start + 1);
> > > > > +               num_out_wins++;
> > > > > +       }
> > > > > +
> > > > > +       /*
> > > > > +        * For config space accesses on the RC, show the right class for
> > > > > +        * a PCIe-PCIe bridge (the default setting is to be EP mode).
> > > > > +        */
> > > > > +       WR_FLD_RB(base, PCIE_RC_CFG_PRIV1_ID_VAL3, CLASS_CODE,
> > > > > 0x060400);
> > > >
> > > > Why does this need to be _RB ? I haven't looked at all of the uses of _RB
> > > > though I think there are others that may not be necessary.
> > >
> > > We're reviewing the _RB usage with Jim, I'll come back to you on that topic
> > > later.
> >
> > Thanks.
>
> Jim and Florian went over all the _RB usages and found out none of them applied
> to the Pi. Apparently they where introduced as a form of barrier needed on some
> MIPS SoCs. Sorry for that, I'll remove them.
>
> > > [...]
> > >
> > > > > +       __brcm_pcie_remove(pcie);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct of_device_id brcm_pcie_match[] = {
> > > > > +       { .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
> > > >
> > > > I'd rather see use of the pcie_cfg_data structure removed from this
> > > > series.
> > > >
> > > > I've seen the comments in the previous thread [1], and I understand that
> > > > the intention is that this driver will eventually be used for other SOCs.
> > > >
> > > > However this indirection isn't needed *now* and it makes reviewing this
> > > > patch more difficult. If and when a later series is made to cover other
> > > > SOCs - then I'd expect that series to find a way to apply this
> > > > indirection.
> > > >
> > > > And if that later series is more difficult to review because of the newly
> > > > added indirection, then I'd expect an early patch of that series to apply
> > > > the indirection in a single patch - which would be easy to review.
> > > >
> > > > The other risk of such premature changes like this is that when you come
> > > > to adding other SOCs, you may then discover that there were shortcomings
> > > > in the way you've approached it here.
> > > >
> > >
> > > I was about to make a point similar to Florian's. I'll wait for your reply
> > > and
> > > change this accordingly.
> >
> > No problem.
>
> Following your reply, I'll remove it.
>
> Regards,
> Nicolas
>
