Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F146580F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 21:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbhLAVCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353729AbhLAVA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:00:56 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DEC0613B5;
        Wed,  1 Dec 2021 12:56:35 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id l24so51878633uak.2;
        Wed, 01 Dec 2021 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+I7QnuVm7p2Rr5SIfOSnLdHPA+37g99lS6+DO/zZGeg=;
        b=Xg9sjYTo9h0p98/OArXZ1PNUjcEaY4WFprCpPDi0NOMSfSTEFWedb17UQTF9KvT/oC
         4+ca/ziQSqi23Sq9v0ORIkJQWWQICwtfSzi6WMFtAiHtVwBlANjpKVvyuo3sBZudWDTx
         ZCzLqDFSZ6jUyfswYvx2Tdfn8EzRz/OlC4i9Oza9Vuf8Mj5vHSAKZ2JmuLWgKO3bx46V
         Y2n34h/fuLMboANSJxSLO7IR4x/+kijU2QTGu8+UrZ+ZW9n4+N36XrXwyqt37t1KIaNP
         fY92Efv/U25X65exBSeIhWPA+3/q5ssgQVsKQ6by7sjEiLImKFIw9WX5x0HiYAL+uzw/
         7g7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+I7QnuVm7p2Rr5SIfOSnLdHPA+37g99lS6+DO/zZGeg=;
        b=i1YLgcAbJvVNZMhzlpvizomL7Qe1fXq6bRVOUwG1PCxIqRPYrnIYYLryIb63oAOC+9
         4hl8cNU2sRlD2QRc9+WM5WblR9mMYuWuC4txlxDiUA6ecSofs9yiLDwjQc0gL9YSfzgx
         WeN5DFmz0c7bijmIYitVLLrG+ru/lpu0IHKKkg2s+u+fU3dOBhzJJnKzL4kfhUlcbZcg
         nstxLc8PZ7aLLLqy//Egx0ySM7TSyqbzriylV/3APda5ylRP96KSp2BgTjYjv1VVT/GA
         hG/X6owi50VaUEbP3QO0rdRPWmn7LqK09fGf5D7xRRj8eU84g2bsStXx4sEtHMnqAi0/
         ShpQ==
X-Gm-Message-State: AOAM531ajI5dJB/K1lTHN1cEXmqGFntZGnksXQy9lIQ+2TjVJrlnJY46
        TUnoO8AvGKuxp6KSklvH5vId8N34DCy7gyqi4kU=
X-Google-Smtp-Source: ABdhPJxDw/fLbjjyIOhqr5Oz0xaztbLgEtWAk8CBGnEnW5gXEfgQJz0iJKyc3e+Q4qC1iXlR0hDn29B03YVhBFr5NEs=
X-Received: by 2002:a05:6102:c4d:: with SMTP id y13mr11017081vss.43.1638392194191;
 Wed, 01 Dec 2021 12:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20211119232017.GA1981034@bhelgaas> <20211201202433.GA2837547@bhelgaas>
In-Reply-To: <20211201202433.GA2837547@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 1 Dec 2021 21:56:22 +0100
Message-ID: <CAMhs-H-NkL4=hcVfBvT0ZeBOfg8bmPYv1urJ1JVWtcA2tbtfjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to 'bridge->windows'
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        John Crispin <john@phrozen.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 1, 2021 at 9:24 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 19, 2021 at 05:20:17PM -0600, Bjorn Helgaas wrote:
> > [+cc Thierry]
> >
> > In subject,
> >
> >   PCI: Let pcibios_root_bridge_prepare() access bridge->windows
> >
> > On Mon, Nov 15, 2021 at 08:08:05AM +0100, Sergio Paracuellos wrote:
> > > When function 'pci_register_host_bridge()' is called, 'bridge->windows' are
> > > already available. However this windows are being moved temporarily from
> > > there. To let 'pcibios_root_bridge_prepare()' to have access to this windows
> > > move this windows movement after call this function. This is interesting for
> > > MIPS ralink mt7621 platform to be able to properly set I/O coherence units
> > > with this information and avoid custom MIPs code in generic PCIe controller
> > > drivers.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  drivers/pci/probe.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index 087d3658f75c..372a70efccc6 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -898,8 +898,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> > >
> > >     bridge->bus = bus;
> > >
> > > -   /* Temporarily move resources off the list */
> > > -   list_splice_init(&bridge->windows, &resources);
> >
> > Arnd added this with 37d6a0a6f470 ("PCI: Add
> > pci_register_host_bridge() interface") [1].
> >
> > I can't remember why this was done, but we did go to some trouble to
> > move things around, so there must have been a good reason.
> >
> > Arnd or Thierry, do you remember?
>
> Nobody seems to remember, so I think we should go ahead and make this
> change after the usual due diligence (audit the code between the old
> site and the new site to look for any uses of bridge->windows).

It seems any user of the pcibios_root_bridge_prepare() does nothing
with 'bridge->windows'. But I don't get the point of passing around a
complete bridge pointer if windows are temporarily removed from there.
That is an incomplete bridge and after parsing  windows from dts are
supposed to be there... What do you mean with 'audit the code between
the old and new site'?

>
> I think this would be material for v5.17.

Do you prefer me to parse dts again inside
pcibios_root_bridge_prepare() for ralink mt7621?. Not real sense since
'windows' should be already there, but it would be a way to get this
patchset added for v5.16. Something like (not tested yet but it should
work):

int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 {
         resource_size_t mask;
         struct device_node *np;
         struct of_range range;
         struct of_range_parser parser;
         struct resource res;

        np = of_find_compatible_node(NULL, NULL, "mediatek,mt7621-pci");
        if (!np) {
                 pr_err("Cannot find pci node\n");
                 return -ENODEV;
       }

      if (of_range_parser_init(&parser, np)) {
          pr_err("Error parsing resources\n");
          of_node_put(np);
          return -EINVAL;
      }

      for_each_of_range(&parser, &range) {
             switch (range.flags & IORESOURCE_TYPE_BITS) {
             case IORESOURCE_MEM:
                 res.start = range.cpu_addr;
                 res.end = range.cpu_addr + range.size - 1;
                 break;
             }
     }

      if (mips_cps_numiocu(0)) {
            mask = ~(res.end - res.start);
            write_gcr_reg1_base(res.start);
            write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
            pr_info("PCI coherence region base: 0x%08llx,
mask/settings: 0x%08llx\n",
                         (unsigned long long)read_gcr_reg1_base(),
                         (unsigned long long)read_gcr_reg1_mask());
     }

     return 0;
}

We can change this for v5.17 with the change in PCI core.

I have just seen Arnd's Acked-by for PATCH 1 while I was writing this,
so I am not sure if we can consider now this patchset as it is with
proposed changes for v5.16.

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos



>
> > >     bus->sysdata = bridge->sysdata;
> > >     bus->ops = bridge->ops;
> > >     bus->number = bus->busn_res.start = bridge->busnr;
> > > @@ -925,6 +923,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> > >     if (err)
> > >             goto free;
> > >
> > > +   /* Temporarily move resources off the list */
> > > +   list_splice_init(&bridge->windows, &resources);
> > >     err = device_add(&bridge->dev);
> > >     if (err) {
> > >             put_device(&bridge->dev);
> > > --
> > > 2.33.0
> > >
> >
> > [1] https://git.kernel.org/linus/37d6a0a6f470
