Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFECC1C6C5E
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 11:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgEFJCo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 05:02:44 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39647 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgEFJCo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2020 05:02:44 -0400
Received: by mail-oi1-f193.google.com with SMTP id b18so1093578oic.6;
        Wed, 06 May 2020 02:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hXvdVV2b8Ec+Z/RgfIVwQGBuPvYBgP98066eKjJaQQ=;
        b=uQAvfsklv4m4bM0XLl3vqOmLveDKIlBT+XgMEVBnDrKgH/riFQbT1DkJ0wufWp/60t
         TXi+U+ploSkbItzaDCN3dDVUciSHoD+WDKhi/cBKeogbEUEyB5ikWs087iKdA85lf/Hd
         zwV8NhfqzIeXcUhFQYpyLMdLemtY8lRtLRG/EmrYQN+GrcUzrOZKh8gfnJ0H/x9HKjX0
         v9GVljYLNbCOlRJ2KlWMVt3e5dcZhpS/+NujDShU/5cu+vvV7hoYdaAU3EacqTa8UuOQ
         Z3FM/EpNJuwuMwsQDD3idmBPbP/8tpPUffc0FyssHROFHLdd5KVMwwpxprhQsgqCCQDy
         pZgg==
X-Gm-Message-State: AGi0PubYW6BDjZRqWog7ByBOhRMFCUXuParrmm9EupYcvt1eaSv+s7oK
        AVYf/Oss3ou/slAmljEkTxETJwcJQNvLlU+M+iw=
X-Google-Smtp-Source: APiQypKbiZow1wfnuT/PjvDHDz91oGm6ojVJDwZeiq89p0ktO5JUAbGnh9dB9AOvSJd08YXW0Zc3l9/lF3Jr/Waz0HI=
X-Received: by 2002:aca:f541:: with SMTP id t62mr1921427oih.148.1588755763074;
 Wed, 06 May 2020 02:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200426123148.56051-1-marek.vasut@gmail.com> <20200428083231.GC12459@e121166-lin.cambridge.arm.com>
 <717765f1-b5be-a436-20d6-d0a95f58cbdc@gmail.com> <20200505180214.GA18468@e121166-lin.cambridge.arm.com>
 <a7971547-869a-b3ca-5934-4ce5028aacf1@gmail.com> <20200506085736.GA30251@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200506085736.GA30251@e121166-lin.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 May 2020 11:02:31 +0200
Message-ID: <CAMuHMdUB2JySwcw0PCEFKNrvmOhF5q=CG265wm1a=Pivn-fWLQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: pcie-rcar: Cache PHY init function pointer
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Wed, May 6, 2020 at 10:57 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, May 05, 2020 at 08:35:04PM +0200, Marek Vasut wrote:
> > On 5/5/20 8:02 PM, Lorenzo Pieralisi wrote:
> > > On Fri, May 01, 2020 at 10:42:06PM +0200, Marek Vasut wrote:
> > >> On 4/28/20 10:32 AM, Lorenzo Pieralisi wrote:
> > >>> On Sun, Apr 26, 2020 at 02:31:47PM +0200, marek.vasut@gmail.com wrote:
> > >>>> From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >>>>
> > >>>> The PHY initialization function pointer does not change during the
> > >>>> lifetime of the driver instance, it is therefore sufficient to get
> > >>>> the pointer in .probe(), cache it in driver private data, and just
> > >>>> call the function through the cached pointer in .resume().
> > >>>>
> > >>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
> > >>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > >>>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > >>>> Cc: Wolfram Sang <wsa@the-dreams.de>
> > >>>> Cc: linux-renesas-soc@vger.kernel.org
> > >>>> ---
> > >>>> NOTE: Based on git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> > >>>>       branch pci/rcar
> > >>>> NOTE: The driver tag is now 'pcie-rcar' to distinguish it from pci-rcar-gen2.c
> > >>>> ---
> > >>>>  drivers/pci/controller/pcie-rcar.c | 10 ++++------
> > >>>>  1 file changed, 4 insertions(+), 6 deletions(-)
> > >>>
> > >>> Squashed in https://patchwork.kernel.org/patch/11438665
> > >>
> > >> Thanks
> > >>
> > >>> Do you want me to rename the $SUBJECT (and the branch name while at it)
> > >>> in the patches in my pci/rcar branch ("PCI: pcie-rcar: ...") to start
> > >>> the commit subject tag renaming from this cycle (and in the interim you
> > >>> send a rename for the drivers files ?)
> > >>
> > >> I don't really have a particular preference either way. I can keep
> > >> marking the drivers with pcie-rcar and pci-rcar tags if that helps
> > >> discern them.
> > >
> > > So:
> > >
> > > - "rcar" for the PCIe driver
> >
> > Wouldn't it be better to mark this rcar-pcie , so it's clear it's the
> > PCIe driver ?
>
> All other drivers in drivers/pci/controller are PCIe but don't require
> an extra tag to clarify it - that's the rationale behind "rcar".
>
> How does that sound ?

Are there any other platforms that have two different drivers for the same
platform, one for PCI, and one for PCIe?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
