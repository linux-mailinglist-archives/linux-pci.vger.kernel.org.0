Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B1428694
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 08:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhJKGFU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 02:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhJKGFT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 02:05:19 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F12C061570;
        Sun, 10 Oct 2021 23:03:20 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id u5-20020a4ab5c5000000b002b6a2a05065so3931032ooo.0;
        Sun, 10 Oct 2021 23:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PZM1hNtTNgTiVXZJjPyf7I/cecC85BHeNIOw8b6D+0=;
        b=hPoilStWhYupNi0Jk5ag0ZoidC0AZeYyBBjRE4RWmLeYMsjQV/x8x/3Y+XV8+49dHL
         L2TgcAPYK1RKunKzbGYOaPMfKsrhGsa2mKnIKqbLO5oF+tF5dy6Gq9be/AKLz8n+3Zrk
         9QmyFcF2Ml08FSpr3agHBO+kF7P1yZxcANIFWQA0xJoIJ5rCG1qap9Dxp5QOtTgNDs8y
         h3YUJ3OnroOmebD+6K6Wxm9Z0+0Yku4P+3Kd1ESFit2j9pzVFGDvrFuAKCP4WhHk73uB
         cYsiY4p0q0OVZvt9onlzAzyxY1Q1ELX0UABhKaAKRoc+H542LJIVanBUtnpHa+Ud6P7E
         YUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PZM1hNtTNgTiVXZJjPyf7I/cecC85BHeNIOw8b6D+0=;
        b=xMKYsMwvx5wS5LivRcczzpKk2hRCl2OnGdDZ/QyRSzw4YpLiXAAdJ/+Pdof0VBBDy5
         hqTGHh8fX4ZeIPXUxaYu9phx1XxBmw3At4rDhaFKzwfA/45XSDs9I5Ru5VLrP3C/Mc1L
         GEQ5igByL6XcA3pGcpC3jnjrvrnPgqxDKzVOXlEr3HDBF0uPZUZcLiQ1EJX4UgbLSDTJ
         90loqrWW44Kr5+6JdkRER4o25BvFvmhyat7j1W9ERK4t39oh/Jv2uLeAEapa4CRvWIG7
         4AtCpmqWh+Z+shIIMj0OXpg5pYnoyOgeEV6P66LN9FvtK2zOnVkYrAswncRVCsMSeOtu
         lkOg==
X-Gm-Message-State: AOAM530wbKu7WxwZQNaMIh1QIZbD7emVLFJYcjLCWS5Nlhk60WqFBeKA
        w73g8EHo+IHJoYf+s3CPQfCU84cJuMLvywYfJSs=
X-Google-Smtp-Source: ABdhPJw3Ki/Rdg3m1GUT4ACvtQ6xD/+ZLXf8N4oybhmLLJZ32J2p/WyZJNOH2ttIJmi0gSsbn1YS+pZ8y8l3VJwA/ss=
X-Received: by 2002:a05:6820:3c9:: with SMTP id s9mr17751156ooj.81.1633932199616;
 Sun, 10 Oct 2021 23:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210929004315.22558-5-refactormyself@gmail.com> <20210930230047.GA921465@bhelgaas>
In-Reply-To: <20210930230047.GA921465@bhelgaas>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Date:   Mon, 11 Oct 2021 08:03:08 +0200
Message-ID: <CABGxfO780sZjzAvNTtHoPwpdW5SuSm83M8-m9yQepSaYT93SGw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] PCI/ASPM: Remove unncessary linked list from aspm.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 1, 2021 at 1:00 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 29, 2021 at 02:43:15AM +0200, Saheed O. Bolarinwa wrote:
> > From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> >
> > aspm.c defines a linked list - `link_list` and stores each of
> > its node in struct pcie_link_state.sibling. This linked list
> > tracks devices for which the struct pcie_link_state object
> > was successfully created. It is used to loop through the list
> > for instance to set ASPM policy or update changes. However, it
> > is possible to access these devices via existing lists defined
> > inside pci.h
> >
> > This patch:
> > - removes link_list and struct pcie_link_state.sibling
> > - accesses child devices via struct pci_dev.bust_list
> > - accesses all PCI buses via pci_root_buses on struct pci_bus.node
>
> Again, I LOVE the way this is going.  I depise this extra linked list.
>
> > Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> > ---
> >  drivers/pci/pcie/aspm.c | 39 +++++++++++++++++++++------------------
> >  1 file changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 56d4fe7d50b5..4bef652dc63c 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -48,7 +48,6 @@ struct aspm_latency {
> >
> >  struct pcie_link_state {
> >       struct pci_dev *pdev;           /* Upstream component of the Link */
> > -     struct list_head sibling;       /* node in link_list */
> >
> >       /* ASPM state */
> >       u32 aspm_support:7;             /* Supported ASPM state */
> > @@ -76,7 +75,6 @@ struct pcie_link_state {
> >  static int aspm_disabled, aspm_force;
> >  static bool aspm_support_enabled = true;
> >  static DEFINE_MUTEX(aspm_lock);
> > -static LIST_HEAD(link_list);
> >
> >  #define POLICY_DEFAULT 0     /* BIOS default setting */
> >  #define POLICY_PERFORMANCE 1 /* high performance */
> > @@ -880,10 +878,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
> >       if (!link)
> >               return NULL;
> >
> > -     INIT_LIST_HEAD(&link->sibling);
> >       link->pdev = pdev;
> > -
> > -     list_add(&link->sibling, &link_list);
> >       pdev->link_state = link;
> >       return link;
> >  }
> > @@ -970,24 +965,22 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
> >  {
> >       struct pcie_link_state *link;
> >       struct pci_dev *dev, *root_dev;
> > +     struct pci_bus *rootbus = root->pdev->bus;
> >
> >       /* Ensure it is the root device */
> >       root_dev = pcie_get_root(root->pdev);
> >       root = root_dev ? root_dev->link_state : NULL;
> >
> > -     list_for_each_entry(link, &link_list, sibling) {
> > -             dev = pcie_get_root(link->pdev);
> > -             if (dev->link_state != root)
> > +     list_for_each_entry(dev, &rootbus->devices, bus_list) {
> > +             if (!dev->link_state)
> >                       continue;
> >
> > -             link->aspm_capable = link->aspm_support;
> > +             dev->link_state->aspm_capable = link->aspm_support;
> >       }
> > -     list_for_each_entry(link, &link_list, sibling) {
> > +
> > +     list_for_each_entry(dev, &rootbus->devices, bus_list) {
> >               struct pci_dev *child;
> > -             struct pci_bus *linkbus = link->pdev->subordinate;
> > -             dev = pcie_get_root(link->pdev);
> > -             if (dev->link_state != root)
> > -                     continue;
> > +             struct pci_bus *linkbus = dev->subordinate;
> >
> >               list_for_each_entry(child, &linkbus->devices, bus_list) {
> >                       if ((pci_pcie_type(child) != PCI_EXP_TYPE_ENDPOINT) &&
> > @@ -1024,7 +1017,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
> >
> >       /* All functions are removed, so just disable ASPM for the link */
> >       pcie_config_aspm_link(link, 0);
> > -     list_del(&link->sibling);
> >       /* Clock PM is for endpoint device */
> >       free_link_state(link);
> >
> > @@ -1164,6 +1156,8 @@ static int pcie_aspm_set_policy(const char *val,
> >  {
> >       int i;
> >       struct pcie_link_state *link;
> > +     struct pci_bus *bus;
> > +     struct pci_dev *pdev;
> >
> >       if (aspm_disabled)
> >               return -EPERM;
> > @@ -1176,9 +1170,18 @@ static int pcie_aspm_set_policy(const char *val,
> >       down_read(&pci_bus_sem);
> >       mutex_lock(&aspm_lock);
> >       aspm_policy = i;
> > -     list_for_each_entry(link, &link_list, sibling) {
> > -             pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > -             pcie_set_clkpm(link, policy_to_clkpm_state(link));
> > +     list_for_each_entry(bus, &pci_root_buses, node) {
> > +             list_for_each_entry(pdev, &bus->devices, bus_list) {
> > +                     if (!pci_is_pcie(pdev))
> > +                             break;
> > +
> > +                     link = pdev->link_state;
> > +                     if (!link)
> > +                             continue;
> > +
> > +                     pcie_config_aspm_link(link, policy_to_aspm_state(link));
> > +                     pcie_set_clkpm(link, policy_to_clkpm_state(link));
> > +             }
>
> IIUC, in the existing code, link_list contains *every* pcie_link_state
> in the system, so we update the configuration of all of them.
>
> Here, iterating through pci_root_buses gives us all the root buses (in
> the case of multiple host bridges), and on each root bus we look at
> every device that has a link_state, so those would typically be Root
> Ports.  But I don't think we descend the hierarchy, so in the case of
> deeper hierarchies, I don't think we update the lower levels.
>
> Example from my laptop:
>
>   00:1d.6 Root Port                     to [bus 06-3e]
>   06:00.0 Upstream Port   (switch A)    to [bus 07-3e]
>   07:01.0 Downstream Port (switch A)    to [bus 09-3d]
>   09:00.0 Upstream Port   (switch B)    to [bus 0a-3d]
>   0a:04.0 Downstream Port (switch B)    to [bus 0c-3d]
>   0c:00.0 Upstream Port   (switch C)    to [bus 0d-3d]
>   0d:01.0 Downstream Port (switch C)    to [bus 0e]
>   0e:00.0 Upstream Port   (Endpoint)    USB controller
>
> Here there are four links:
>
>   00:1d.6 --- 06:00.0
>   07:01.0 --- 09:00.0
>   0a:04.0 --- 0c:00.0
>   0d:01.0 --- 0e:00.0
>
> But I think this patch only looks at the 00:1d.6 --- 06:00.0 link,
> doesn't it?
Thank you, that is correct.
I should have used pdev->subordinate to traverse the hierarchy via the bridges.
>
> >       }
> >       mutex_unlock(&aspm_lock);
> >       up_read(&pci_bus_sem);
> > --
> > 2.20.1
> >
