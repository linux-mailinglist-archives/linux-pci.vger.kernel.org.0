Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF27D1BAED8
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 22:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgD0UJF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 16:09:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36745 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD0UJF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 16:09:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id b13so28569999oti.3;
        Mon, 27 Apr 2020 13:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjHXiaCtnGqcs25RoRhH4VXqlbZs8N2rlpvkrTKQk2w=;
        b=WW0KiFfBpZJNKlwF5LOauJyvUDtYZnp/6fPVwmWG1me//1k7PYKezk5PqlR0IM1qVr
         JfBV2/z8V+xyeHXxrABirWFj9h/UVPPHPN68DDgmUpG+9PtQXoj9ixaTaDji79/ACHdn
         T910qHPI5VhO43G3SRYCSMcMQeJsXVHuin8RFdvk0cORlb3CJjcDmej9q5Si9xASboFV
         Q9ViSdvBfLp42rzIuxIHYLDCno1IkrjYntuGfNfzaYukJKTlkoKAUWRw5N1nq7LGrSCP
         CTjMQpwxYVJMwfgsGe4/Uj4X0Vym8eCPaM1POcoazWoYJUPM5d8brcKpwzyS1AobHB2l
         BOLw==
X-Gm-Message-State: AGi0PuY4T1jvZOj2EfRibkVd+fTnp4bqQp3L2tGUjgnJHN7MAUZlKNch
        N5ygTZ8laj43zXsTbxNK3ydikakuuqte8S1HbtE=
X-Google-Smtp-Source: APiQypJo9QxmBf1wyiMhCpee+yBovlv4e8Z6HWC3FcFsNHseTkXZubqgFZ+npGh/pD192LlwekjF7QEtte+5bdAuLYw=
X-Received: by 2002:a9d:7990:: with SMTP id h16mr13612825otm.145.1588018144361;
 Mon, 27 Apr 2020 13:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdVGkM_-5q+pSOtQ5nBPGzMeOpRTJUqekYnvjiPMFepqLw@mail.gmail.com>
 <20200427174138.GA207841@google.com>
In-Reply-To: <20200427174138.GA207841@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Apr 2020 22:08:52 +0200
Message-ID: <CAMuHMdXbpynd6N2-GF+j3ie3HG0CohebpPOaj=oiZhF_Pt9gAg@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Mon, Apr 27, 2020 at 7:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Apr 25, 2020 at 10:55:21AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 24, 2020 at 9:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > [+cc Vaibhav]
> > >
> > > Alternate less redundant subject:
> > >
> > >   PCI: rcar: Add suspend/resume support
> >
> > Note that there's both pcie-rcar.c (this driver, for R-Car Gen2 and Gen3
> > PCIe) and pci-rcar-gen2.c (for R-Car Gen2 PCI).
> > People tend to use the prefix "PCI: rcar: " for both :-(
>
> Yeah, that's pretty broken, thanks for pointing this out!
>
> For most drivers we use a chipset name ("keystone", "imx6", "tegra",
> etc) as the changlog tag.  That's nice because it gives space for
> multiple drivers from the same vendor, but I don't know anything
> similarly specific for the R-Car drivers.
>
> pci-rcar-gen2.c seems to be for some sort of internal Conventional PCI

AFAIUI it's some internal PCI glue to the *HCI USB controller.

> bus?  The "gen2" is confusing because "Gen 2" is more commonly used
> for PCIe than for Conventional PCI.

The "Gen2" applies to "R-Car", not to "PCI".

> I would propose keeping "rcar" for the PCIe driver and using
> "rcar-pci" for the Conventional PCI one, but the Conventional PCI one

(/me resists against bike-shedding)

> (pci-rcar-gen2.c) seems pretty inactive.  The most recent commits are
> from 2018, and they're trivial cleanups.  So I'm doubtful that anybody
> will remember when the next change comes in.

I guess pci-rcar-gen2.c is simpler and more mature ;-)
R-Car Gen2 SoCs have both (internal) PCI and PCIe, so the two drivers
can be used together on the same hardware.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
