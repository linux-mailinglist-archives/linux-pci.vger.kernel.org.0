Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D2F1BB8E4
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 10:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgD1Idh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 04:33:37 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:40546 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgD1Idh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 04:33:37 -0400
Received: by mail-oo1-f67.google.com with SMTP id r1so4498838oog.7;
        Tue, 28 Apr 2020 01:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qz7w+rAEifl7nDRQdRl3Sv+cAgyuV33lDCQmc/oPEkQ=;
        b=HD8O4U+kjJioEey2SdKZsF7FFfgtVFfail4u5tiYbICK/U5XOpE7LECzm3tRVg4nBA
         sMd+8Rz9zq95yPEE1Ebtf22YbVnD7wT1r8L3TGShywuDTY34n2Px4/x2Jn1aYEjZy/uA
         etyt6qvGjTIhZm7YMd54LS2WFP67LGdBuZ2SVIGhCWJ1m9ey/tlrA6AkEtRp3Sy0f5wk
         dcOPaRzE4INw4aOafzBpL63EyShhtHuSlISKpYsPhD30VfsRXdgM3s112ibsZNodlDZR
         YalzR/07PlG1FwdWjG/lfNkR/zHS0gXzFtPqsH3UzjKAHSczhXgI3zqim6sGRPpCJqYt
         XMsg==
X-Gm-Message-State: AGi0PubcF+DEnXy7U6POkoDOxh7t+l/igxgxOaRHQLcdIBXwP8CO9nIP
        SweR27+yjfVIeVdEQnjSOQD9nKuWcXrwqUfNsdM=
X-Google-Smtp-Source: APiQypL2Olwk2mLZNQDcCMvhJnqOqIDDHOlZWS91nni3WwNRu7rqOg0OOONaMbuyU8jc1z/SaMSMxhpspKSJComcvxk=
X-Received: by 2002:a4a:d44a:: with SMTP id p10mr16164090oos.11.1588062816252;
 Tue, 28 Apr 2020 01:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdVGkM_-5q+pSOtQ5nBPGzMeOpRTJUqekYnvjiPMFepqLw@mail.gmail.com>
 <20200427174138.GA207841@google.com> <CAMuHMdXbpynd6N2-GF+j3ie3HG0CohebpPOaj=oiZhF_Pt9gAg@mail.gmail.com>
 <20200428082617.GA12459@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200428082617.GA12459@e121166-lin.cambridge.arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Apr 2020 10:33:24 +0200
Message-ID: <CAMuHMdUAuCM55CwMEeycCjyMy0i=USUyQFyPKDsQgHiR-cRcJA@mail.gmail.com>
Subject: Re: [PATCH V3] PCI: rcar: Add the suspend/resume for pcie-rcar driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On Tue, Apr 28, 2020 at 10:26 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Mon, Apr 27, 2020 at 10:08:52PM +0200, Geert Uytterhoeven wrote:
> > On Mon, Apr 27, 2020 at 7:41 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Sat, Apr 25, 2020 at 10:55:21AM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, Apr 24, 2020 at 9:57 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > [+cc Vaibhav]
> > > > >
> > > > > Alternate less redundant subject:
> > > > >
> > > > >   PCI: rcar: Add suspend/resume support
> > > >
> > > > Note that there's both pcie-rcar.c (this driver, for R-Car Gen2 and Gen3
> > > > PCIe) and pci-rcar-gen2.c (for R-Car Gen2 PCI).
> > > > People tend to use the prefix "PCI: rcar: " for both :-(
> > >
> > > Yeah, that's pretty broken, thanks for pointing this out!
> > >
> > > For most drivers we use a chipset name ("keystone", "imx6", "tegra",
> > > etc) as the changlog tag.  That's nice because it gives space for
> > > multiple drivers from the same vendor, but I don't know anything
> > > similarly specific for the R-Car drivers.
> > >
> > > pci-rcar-gen2.c seems to be for some sort of internal Conventional PCI
> >
> > AFAIUI it's some internal PCI glue to the *HCI USB controller.
> >
> > > bus?  The "gen2" is confusing because "Gen 2" is more commonly used
> > > for PCIe than for Conventional PCI.
> >
> > The "Gen2" applies to "R-Car", not to "PCI".
>
> Wicked :) !

pcie-rcar.c supports R-Car Gen1, Gen2, and Gen3.

> > > I would propose keeping "rcar" for the PCIe driver and using
> > > "rcar-pci" for the Conventional PCI one, but the Conventional PCI one
> >
> > (/me resists against bike-shedding)
>
> I'd agree with Bjorn - I don't know, internal vs external seems
> artificial. Certainly gen2 is misleading, it does not take much
> to improve it.

We have lots of drivers in other subsystems with "rcar-gen2" or
"rcar-gen3" as part of their names.

> > > (pci-rcar-gen2.c) seems pretty inactive.  The most recent commits are
> > > from 2018, and they're trivial cleanups.  So I'm doubtful that anybody
> > > will remember when the next change comes in.
> >
> > I guess pci-rcar-gen2.c is simpler and more mature ;-)
> > R-Car Gen2 SoCs have both (internal) PCI and PCIe, so the two drivers
> > can be used together on the same hardware.
>
> I'd remove gen2 to start with, you are better placed to know the
> internals to come up with something significant.

So we're back at "PCI: rcar: ...", for both ;-)

I'd say the main difference between the two drivers is PCI vs. PCIe.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
