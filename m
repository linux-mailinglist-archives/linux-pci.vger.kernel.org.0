Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A30B2994C7
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788985AbgJZSC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788984AbgJZSC7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:02:59 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA722224E
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 18:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603735378;
        bh=SsxBK2jR6BD7vuGXjoGsjiBEVFbdMafNwUGiysWPddE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ky4ZVYIZrhJgWp6HiG9WeUK4qRO30lkhUKBuJOYMgd84iqDxJFZnYufQs2X+0JzFz
         PpNx2bnEIw6Y+jTQJ053l//iIKhotbLvcXb6OzREvn6fYMppSaq3pVtgFOMkQHU+i4
         PewqGrysVapv3Sc3B5IEKwHVMDMbP6VnBUNn2+WU=
Received: by mail-oi1-f176.google.com with SMTP id z23so6121778oic.1
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 11:02:58 -0700 (PDT)
X-Gm-Message-State: AOAM530V8GQSgly60unIV5ydjVvHRPct/WGLVCO8CqK1k+CABGNIaB9g
        JbEiZa23IJpMoKcDG8lRpyNk4BOaUJV2QeOLFg==
X-Google-Smtp-Source: ABdhPJwP/nm8bFK0O6EGVOfK4f64e+ncgHvTlYR0eSUohGqLmzI4/AkBjf8DvjV4pg0pKHcK/xLJWTwlu0fqq1KHIHQ=
X-Received: by 2002:aca:ccc7:: with SMTP id c190mr2090529oig.152.1603735378200;
 Mon, 26 Oct 2020 11:02:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201026154852.221483-1-robh@kernel.org> <b68c285e-3991-2577-30d5-a5b0bef80752@nvidia.com>
In-Reply-To: <b68c285e-3991-2577-30d5-a5b0bef80752@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Oct 2020 13:02:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+XpcawbxLv2gZLCfDZczkv8LSukUHQFMFwtPg=Pe07ig@mail.gmail.com>
Message-ID: <CAL_Jsq+XpcawbxLv2gZLCfDZczkv8LSukUHQFMFwtPg=Pe07ig@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Restore ATU memory resource setup to use last entry
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     PCI <linux-pci@vger.kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 11:49 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 10/26/2020 9:18 PM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > Prior to commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI
> > resources"), the DWC driver was setting up the last memory resource
> > rather than the first memory resource. This doesn't matter for most
> > platforms which only have 1 memory resource, but it broke Tegra194 which
> > has a 2nd (prefetchable) memory region which requires an ATU entry. The
> > first region on Tegra194 relies on the default 1:1 pass-thru of outbound
> > transactions which doesn't need an ATU entry.
> >
> > Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> > Reported-by: Vidya Sagar <vidyas@nvidia.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 674f32db85ca..44c2a6572199 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -586,8 +586,12 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >           * ATU, so we should not program the ATU here.
> >           */
> >          if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> > -               struct resource_entry *entry =
> > -                       resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> > +               struct resource_entry *tmp, *entry = NULL;
> > +
> > +               /* Get last memory resource entry */
> > +               resource_list_for_each_entry(tmp, &pp->bridge->windows)
> > +                       if (resource_type(tmp->res) == IORESOURCE_MEM)
> > +                               entry = tmp;
> This patch works for Tegra194 with its 'ranges' property in its current
> shape. But, this still doesn't work if ATU mapping needs to be set for
> both prefetchable and non-prefetchable regions.

Supporting both is not a current feature and therefore not 5.10
material. This patch is intended for 5.10. Adding support for multiple
memory regions would be 5.11 material.

> The series I pushed at
> http://patchwork.ozlabs.org/project/linux-pci/list/?series=209764 works
> for this condition as well.

I have an alternative implementation that I'll send out shortly.

> When it comes to configuring the ATU to handle multiple memory apertures
> (which is the ultimate goal), I think we need to understand the side
> effects of removing I/O mapping in platforms where the number of view
> ports available are not enough to have I/O mapping.

We don't have that case upstream AFAICT. Tegra is the only platform
with more than 1 memory region which could cause a change in behavior.
In any case, I'm not removing the sharing of ATU for config and i/o
(though I think we should). I am adding a warning though.

Rob
