Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C13403171
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 01:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347665AbhIGXTJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 19:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbhIGXTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Sep 2021 19:19:08 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C90C061575;
        Tue,  7 Sep 2021 16:18:01 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w9so153524qvs.12;
        Tue, 07 Sep 2021 16:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6C+UtyiW8etyIzvp1bSQYtwL6nt/zyAE4orGv5NIebE=;
        b=puMEaI8X9kp7QcnZkvnzMXidvJ8oGSkYKvYc/UV/g8KQlI424kmo1dJSCv3lm39c35
         bn0OJMX3hL9Bg3gE/eOKrQWXmwT6E72nTOXHBSqrvdABa/K5y2a2GkIAtOehmWMHx7BH
         vldMocWf05mpZDnaDFKWCta5scmeM3rnytdbepdKd8641BxiQxDwYOa4TaaVQO5AZ40x
         9/rnQ6KZZTM/Ug393WL0U1xznAkrnQchQixFgqYXF4TByQayfO5k9ytxozaf7V5qfUHq
         +I/s2as/yQah+8zBfwT2bsdhxbTNS3GQ7CCZ0mWkBWrxktvwjyPgZaEVVxkNYq73Ak95
         bwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6C+UtyiW8etyIzvp1bSQYtwL6nt/zyAE4orGv5NIebE=;
        b=h1MZNJh4MrtkMu/muLHNy246G2XFlr9GIrf7vIWw7qzJp9tu9Z43QvD0o9bSJ8TeBL
         CNfkiBJljImB1bwAjlSJexyYjKdJVVNooalByGGqW5JSaIbo7V19YHGymomtrV6mRUJh
         Eo8WNNrYL2pM4DwzCfWM7CvKNtZZnMoJYRyWNFf3DTu9Q9wcnIDtPfQP1SikMTvINmNO
         8lsaGgqUPdXk+LVwhvcrU2+TOAaVUweZPLs9ncgkfGpZH18NJCN8H0fNAkOSDSp0fhrL
         AwrcwFKpbrqcv3fbJ5o+P5MWmVABow6fDc4ZvnMf0KBnoiVsotNYUM+EUElqbmiEJ+E1
         kcpg==
X-Gm-Message-State: AOAM530ocegckYRTjVOMAtmHoKwvUmiuIWicuawtRkPXPPtZ5iwJJQim
        B8c2hGyotawGXHUKKBrbgrqmWDtOiXxN4mVD3s8=
X-Google-Smtp-Source: ABdhPJyzdMj0I5Gsf1Kc4FI/9QXRITr/yhY0akNaeNEEODZjb8ejyKvGmVHwxFTs6qaL9e5qzsXJfiEMJgISbB+nHd0=
X-Received: by 2002:a0c:e04a:: with SMTP id y10mr737242qvk.14.1631056680456;
 Tue, 07 Sep 2021 16:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210907085946.21694-1-vulab@iscas.ac.cn> <0fa7ddfa-cd65-583e-a83f-4cbcd4e7337f@linux.ibm.com>
In-Reply-To: <0fa7ddfa-cd65-583e-a83f-4cbcd4e7337f@linux.ibm.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 8 Sep 2021 09:17:49 +1000
Message-ID: <CAOSf1CGEAhXzqEU_-F39um8ri98r1Ww+AtsXJqZu4U7a_ODi9w@mail.gmail.com>
Subject: Re: [PATCH] pci/hotplug/pnv-php: Remove probable double put
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     Xu Wang <vulab@iscas.ac.cn>, Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 8, 2021 at 8:02 AM Tyrel Datwyler <tyreld@linux.ibm.com> wrote:
>
> On 9/7/21 1:59 AM, Xu Wang wrote:
> > Device node iterators put the previous value of the index variable,
> > so an explicit put causes a double put.
> >
> > Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> > ---
> >  drivers/pci/hotplug/pnv_php.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> > index 04565162a449..ed4d1a2c3f22 100644
> > --- a/drivers/pci/hotplug/pnv_php.c
> > +++ b/drivers/pci/hotplug/pnv_php.c
> > @@ -158,7 +158,6 @@ static void pnv_php_detach_device_nodes(struct device_node *parent)
> >       for_each_child_of_node(parent, dn) {
> >               pnv_php_detach_device_nodes(dn);
> >
> > -             of_node_put(dn);
> >               of_detach_node(dn);
>
> Are you sure this is a double put? This looks to me like its meant to drive tear
> down of the device by putting a long term reference and not the short term get
> that is part of the iterator.

Yeah, the put is there is to drop the initial ref so the node can be
released. It might be worth adding a comment.
