Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD53E3EC41E
	for <lists+linux-pci@lfdr.de>; Sat, 14 Aug 2021 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhHNRdi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Aug 2021 13:33:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhHNRdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Aug 2021 13:33:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13D4160F21
        for <linux-pci@vger.kernel.org>; Sat, 14 Aug 2021 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628962389;
        bh=mBEEHT+hIVkkcZH9uGB7wZ/WuHcpCDIZUgiA2jaIYj8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tZAuHOaU+ahj3ncngTLNGqeOMSw3z15MXOCN+FPaXCc/cpNDdqcLko+JCLkD4Ac19
         Er9wzyDAdVYv4W2smap37uuKeooki9yniLu2c+2/eXNUD2ENqb/9se++DnDngVCXE7
         xW/XyeSvGjiQJtMyX4JEAb64jHFxt6R8/gRWCrObjKSwnoOoxkiJL2p9UeKN3cbkYw
         Cbqq8j6kSAWJskksBsZekH47a1RUy7kfbn7EaZPK4pwcsVnyjdfad8HoQKNzp4wClh
         wSJaShpwGMjzQyD0b1CZjbeS5TsvFDxf/cdXx9barSWdiBaUn7+EKfdB/HKGMYeeaU
         5QgK9DmToaV1w==
Received: by mail-ed1-f44.google.com with SMTP id i6so20131028edu.1
        for <linux-pci@vger.kernel.org>; Sat, 14 Aug 2021 10:33:08 -0700 (PDT)
X-Gm-Message-State: AOAM532vBu5EexKWJoRi4fGFUvgqUazTO4uWtLFfFawnHYYoa49dbl9X
        AqughUAhoHCMMSkyvwhsagciOrMHTdo3yuUm5A==
X-Google-Smtp-Source: ABdhPJz1FSDNG8/YWxOKLuSL6gXg+48pnVsOskViyNb60PmtuhbiBA7Iraoqye0OGuRnJ9/FQMDWD0IKQxM/bYkw2go=
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr10180126edu.62.1628962387654;
 Sat, 14 Aug 2021 10:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210813160257.3570515-1-robh@kernel.org> <20210813191938.6a8a4ee4@coco.lan>
In-Reply-To: <20210813191938.6a8a4ee4@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 14 Aug 2021 12:32:56 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+aPRh9CJ0iKbzGCyE3wDR6QMEKAEC8p=1ZVRDSb6JDA@mail.gmail.com>
Message-ID: <CAL_JsqL+aPRh9CJ0iKbzGCyE3wDR6QMEKAEC8p=1ZVRDSb6JDA@mail.gmail.com>
Subject: Re: [PATCH] PCI: of: Fix MSI domain lookup with child bus nodes
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 12:19 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Fri, 13 Aug 2021 11:02:57 -0500
> Rob Herring <robh@kernel.org> escreveu:
>
> > When a DT contains PCI child bus nodes, lookup of the MSI domain on PCI
> > buses fails resulting in the following warnings:
> >
> > WARNING: CPU: 4 PID: 7 at include/linux/msi.h:256 __pci_enable_msi_range+0x398/0x59c
> >
> > The issue is that pci_host_bridge_of_msi_domain() will check the DT node of
> > the passed in bus even if it's not the host bridge's bus. Based on the
> > name of the function, that's clearly not what we want. Fix this by
> > walking the bus parents to the root bus.
> >
> > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > Compile tested only. Mauro, Can you see if this fixes your issue.
> >
> >  drivers/pci/of.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index a143b02b2dcd..ea70aede054c 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -84,6 +84,10 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
> >       if (!bus->dev.of_node)
> >               return NULL;
> >
> > +     /* Find the host bridge bus */
> > +     while (!pci_is_root_bus(bus))
> > +             bus = bus->parent;
> > +
> >       /* Start looking for a phandle to an MSI controller. */
> >       d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
> >       if (d)
>
> Nope, it didn't solve the issue.

Can you try adding some prints of the domain, pci dev, and DT node to
pci_set_bus_msi_domain(). Comparing those when having child nodes or
not would be helpful.

Rob
