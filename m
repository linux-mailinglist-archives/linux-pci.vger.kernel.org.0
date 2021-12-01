Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8246566C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 20:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbhLAT3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 14:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352998AbhLAT27 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 14:28:59 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADCEC0613FC;
        Wed,  1 Dec 2021 11:25:38 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id j14so51136378uan.10;
        Wed, 01 Dec 2021 11:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R/lFdTalLpoR7XoJO19/rmrZrA2nWCTKKIFYKXP72ZM=;
        b=LQ7ozUqtFdB/n4fy/WWECNPTTBxEOevWyhOi8j/Ck1CrkuTjNI2pYz1Vr8y+nChALP
         n7HJkWd+x+bfNJmsx0Nz7wEUYfh6kbY8MDoALIUXlTwsDvSF0sjG8xeBxcqzsbL0Nugf
         3FinNpNTBCqXUy21wjI3dGl2HRwlOQkpTOK5HZ5UxpwiSmz6khToEm6NW0zALGH/zsbJ
         AK7j4rvUe8bsk+aSBqhMKX1sitEA+hkLb9tDVA/hOEtve3xSHn4D+m9aAIkkgRMzcPX6
         wo+SUq1Plq70bCvM7rcPBBEOuiROxG7sMkT5ycUXaP+vg3/W+CkVagDTmTN+IMmMhgLE
         GIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R/lFdTalLpoR7XoJO19/rmrZrA2nWCTKKIFYKXP72ZM=;
        b=04YwbVhcybXn2zVdvTbLHD+wFI+8TBF3RQj38FeQfki2c/iIZl4T/tV8V9DJA68dWA
         X19BRU2wlnh8HA6So85BVUBuwKd5tiqN/AuoCXRPc9LxTjJOVovmIT3ZiC4gqQ38es/V
         OCAo/D5iHFmvaGslAfxtfL7AKFeEJRzGR7orHan4CrSd/0UWUPW/N2eB+v8f+95/AY9q
         NJ+8Sdw2UoQBWy20nUwHo33EdT5aP7t1mdjfz4creMDJ0S3CkB4PQxDOgNk75R43DpAg
         91xWmTzFQ7Rb6Y0zLZMmLdzPwjbbdjPBE1+OI9xdRaGEo3vFGF8khE4Iyoh3BWPsGMJu
         DeWQ==
X-Gm-Message-State: AOAM532fl73nBf0+w58elgYADKeEDIodIQPxB7sNqacB/8PrZ0RPth+y
        wlmcg+UOQptekJ7sN1Apwu/PzR/XfVwkFrWhBN8=
X-Google-Smtp-Source: ABdhPJzYrWwPfyPmACGXWaVxXxzo/lgx5ssxK3IhAvPACkQJpZ3pMnDUdybQ0GFwW99Gc8xLnVGi4u3ELgfMP3xafA0=
X-Received: by 2002:a67:de12:: with SMTP id q18mr5992904vsk.17.1638386737304;
 Wed, 01 Dec 2021 11:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20211115070809.15529-4-sergio.paracuellos@gmail.com> <20211201181609.GA2831753@bhelgaas>
In-Reply-To: <20211201181609.GA2831753@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 1 Dec 2021 20:25:26 +0100
Message-ID: <CAMhs-H_68tW9jua+QCMO=7zVKCxAe862zKGp5JMrWmcVtbT7iA@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: mt7621: avoid custom MIPS code in driver code
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Dec 1, 2021 at 7:16 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> s/avoid custom/Avoid custom/ in subject.

Ok, I will change this and send v2 of this series after the PATCH 1
change in the series is clear and validated that it is an accepted way
to go.

>
> On Mon, Nov 15, 2021 at 08:08:07AM +0100, Sergio Paracuellos wrote:
> > Driver code is setting up MIPS specific I/O coherency units addresses config.
> > This MIPS specific thing has been moved to be done when PCI code call the
> > 'pcibios_root_bridge_prepare()' function which has been implemented for MIPS
> > ralink mt7621 platform. Hence, remove MIPS specific code from driver code.
> > After this changes there is also no need to add any MIPS specific includes
> > to avoid some errors reported by Kernet Tets Robot with W=1 builds.
>
> s/this changes/this change/
> s/Tets/Test/

Ups, true. Thanks :).

>
> The patch doesn't touch any #include lines, so I'm not sure what the
> last sentence is telling us.

Kernel test robot reported implicit declarations because of the use of
MIPS specific functions without explicit include added in driver code
[0].

After this change, this issue also disappears and that is why
'Reported-by' tag is added and this sentence included in the commit
message. Let me know the way you prefer me to write the commit message
to take into account this fact.

Thanks,
    Sergio Paracuellos

[0]: https://lore.kernel.org/lkml/CAMhs-H_yugWd4v1OnBR8iqTVQS_T-S3pdrJbZq=MC646QSyb4Q@mail.gmail.com/T/

>
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/controller/pcie-mt7621.c | 37 ----------------------------
> >  1 file changed, 37 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> > index b60dfb45ef7b..9cf541f5de9c 100644
> > --- a/drivers/pci/controller/pcie-mt7621.c
> > +++ b/drivers/pci/controller/pcie-mt7621.c
> > @@ -208,37 +208,6 @@ static inline void mt7621_control_deassert(struct mt7621_pcie_port *port)
> >               reset_control_assert(port->pcie_rst);
> >  }
> >
> > -static int setup_cm_memory_region(struct pci_host_bridge *host)
> > -{
> > -     struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
> > -     struct device *dev = pcie->dev;
> > -     struct resource_entry *entry;
> > -     resource_size_t mask;
> > -
> > -     entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
> > -     if (!entry) {
> > -             dev_err(dev, "cannot get memory resource\n");
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (mips_cps_numiocu(0)) {
> > -             /*
> > -              * FIXME: hardware doesn't accept mask values with 1s after
> > -              * 0s (e.g. 0xffef), so it would be great to warn if that's
> > -              * about to happen
> > -              */
> > -             mask = ~(entry->res->end - entry->res->start);
> > -
> > -             write_gcr_reg1_base(entry->res->start);
> > -             write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
> > -             dev_info(dev, "PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
> > -                      (unsigned long long)read_gcr_reg1_base(),
> > -                      (unsigned long long)read_gcr_reg1_mask());
> > -     }
> > -
> > -     return 0;
> > -}
> > -
> >  static int mt7621_pcie_parse_port(struct mt7621_pcie *pcie,
> >                                 struct device_node *node,
> >                                 int slot)
> > @@ -557,12 +526,6 @@ static int mt7621_pci_probe(struct platform_device *pdev)
> >               goto remove_resets;
> >       }
> >
> > -     err = setup_cm_memory_region(bridge);
> > -     if (err) {
> > -             dev_err(dev, "error setting up iocu mem regions\n");
> > -             goto remove_resets;
> > -     }
> > -
> >       return mt7621_pcie_register_host(bridge);
> >
> >  remove_resets:
> > --
> > 2.33.0
> >
