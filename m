Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F141CC59
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 21:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346444AbhI2TKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 15:10:42 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:33572 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346427AbhI2TKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 15:10:42 -0400
Received: by mail-vs1-f50.google.com with SMTP id 188so4373518vsv.0;
        Wed, 29 Sep 2021 12:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DvMiED0Nj39LGv5hIz7wQKjAf2wRBS1r0Gep2K3eNY=;
        b=T/6aSzM/sThrenFcJ8J3m+WyG6NJKY6GKzMrFrsLlIindJF7Kjs1WMFGoIcTfOl1+V
         GbIdKST93z2nq+bAbpfxQPDY+O3fkMc0/8EpYRt7Igsg7580+4S+De89jMPfqqKQbigh
         Nr6KsqmPjziPT9ZsiwCI0Pm1XzAg1hpzDSsO8WANrWW/NS1P/zDb2Jq6dLUC+fkPfL+M
         cJMEEwobSoU/K4mhH7Ol05MXyKW8Xu6oLXobzNT4Nxc3hHM8xV8i0XxQz/5voFV8XQsO
         8a0zQ8XNN1/NQjIFUCCt31IoBcdlHWjOraCsZfLna9OVdpLdIIISD0ZOalzbygU4eZMo
         dxXw==
X-Gm-Message-State: AOAM530hv7NoG4Y0wIsyOYnr5Cs4EDLsaP5k0B3Sk+eltYFVWqihzV1p
        WylaI1R63KvUBgyNqO/B0dSMKMG2n0/yL3iZegk=
X-Google-Smtp-Source: ABdhPJyR8wRtUtrr+ge+bIY4WdnNfeReGufJe0RoPvCyYUYR3QnwFXof4Jpl1sLXvSek+FPZxcbKMyh9N7zKMoVC/Kw=
X-Received: by 2002:a67:f147:: with SMTP id t7mr2113331vsm.41.1632942540439;
 Wed, 29 Sep 2021 12:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210929145509.GA20495@lpieralisi> <20210929163250.GA773921@bhelgaas>
 <CAK8P3a0Z=w6CK3EKG5LjMan3R04bO9BshLxqU1J_gm8+OLuU+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0Z=w6CK3EKG5LjMan3R04bO9BshLxqU1J_gm8+OLuU+Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 29 Sep 2021 21:08:42 +0200
Message-ID: <CAMuHMdVNRdD8nD7w6+UsySC+8J_r5TeH1NVwgiKqKaOLBEfhcA@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 8:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Sep 29, 2021 at 6:32 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Sep 29, 2021 at 03:55:09PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Sep 22, 2021 at 01:13:11AM +0200, Marek Vasut wrote:
> > > > On 9/21/21 6:08 PM, Geert Uytterhoeven wrote:
> > > >
> > > > [...]
> > > >
> > > > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > > > index 326f7d13024f..ee6f5e525d3a 100644
> > > > > > --- a/drivers/pci/controller/Kconfig
> > > > > > +++ b/drivers/pci/controller/Kconfig
> > > > > > @@ -66,6 +66,7 @@ config PCI_RCAR_GEN2
> > > > > >   config PCIE_RCAR_HOST
> > > > > >          bool "Renesas R-Car PCIe host controller"
> > > > > >          depends on ARCH_RENESAS || COMPILE_TEST
> > > > > > +       depends on COMMON_CLK
> > > > >
> > >
> > > Bjorn, shall we pick Arnd's patch up then ? We should be fixing this in
> > > one of the upcoming -rcs since we introduced it in the last merge
> > > window.
> >
> > IIUC, a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort
> > hook") appeared in v5.15-rc1 and added a use of __clk_is_enabled(),
> > which is only available when COMMON_CLK=y.
> >
> > PCIE_RCAR_HOST depends on ARCH_RENESAS || COMPILE_TEST.  ARCH_RENESAS
> > is an ARM64 platform, so when COMPILE_TEST is not set, I think we get
> > COMMON_CLK=y via this:
> >
> >   config ARM64
> >     select COMMON_CLK
> >
> > But when ARCH_RENESAS is not set and COMPILE_TEST=y, there's nothing
> > that enforces the dependency on COMMON_CLK.  Personally I like the
> > first hunk of Marek's patch at [1] because the dependency on
> > COMMON_CLK is explicit:
> >
> >   config PCIE_RCAR_HOST
> >     depends on ARCH_RENESAS || COMPILE_TEST
> >     depends on COMMON_CLK
>
> Agreed, Marek's version is clearer than mine, please use that.

But PCIE_RCAR_EP does not need the dependency.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
