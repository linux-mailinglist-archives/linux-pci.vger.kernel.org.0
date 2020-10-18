Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08C29172E
	for <lists+linux-pci@lfdr.de>; Sun, 18 Oct 2020 13:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgJRLfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Oct 2020 07:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgJRLfl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Oct 2020 07:35:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1968C061755
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2020 04:35:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x20so5764891qkn.1
        for <linux-pci@vger.kernel.org>; Sun, 18 Oct 2020 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LRsXpjulKclQsZReY9ZC9kN9qaflaz0NAuODSgAB6oE=;
        b=pljsNfh9k2iEWOtXc/HybsW3lv8Nmz55NBLu29d9RYU0wIrCby18xXBO4LDkNHOPJ7
         AXGOaoN/8Xk+JPuz1HYNyjuPfGwCscGKtLXBZsHw6tOkEeiqmrGo1UcMmqzckL6cW6s+
         a0fU/wZoob2A3ruilBEcWG4EdDldnLFVoIp7wtPtFjJ7zloX8x+zNMcg5zsVPEAH5xgN
         7R3bOFnSSjLCnwSyVCMh29H+LAxszdKaDJEWidXwLhVkrzzNfelAYCNLtFnb+HWg7h5F
         zqWHolF58Tlr5e1D/YNhkXnUqqGIW0/YkJZoROhbMv40m2ra7khuk9yxYEK2FPL0fCI2
         C3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LRsXpjulKclQsZReY9ZC9kN9qaflaz0NAuODSgAB6oE=;
        b=rvKpho9juZ4U37DIo2yC67wI2girLbGc0yMHrQ86H96n3OjLoAvwd1SqsnjykhNsws
         T1lSovZKTvyQaZURyCOCVjkoaBDC44u5KNST4ItjUJWxLDs1ngQlvZJQTyY4wOMpKwJA
         AY56/PtESxMTfbD48QNNLJ3LopXjmEwwoEbfQ+nkrTbN27ghUhVJIiqKu0awzFuU071b
         1Jqj0i7RSmxrZmwibBCLwy+7Ue46JlA3avrgJ/OxPK/gGfl7KU6IE97M9bLVoMBoh9uG
         +JwEFf/NifbasfVqSk17yoJNUEIooEweTk6EJon7WkVZtOganiGS6FuYJysYyLj5xzPe
         2erQ==
X-Gm-Message-State: AOAM530y7C2MgboYNI0NDeL9EVNxhhPwvJslpD2k13/BuSOgPF0M/bFX
        kRZmwv2H8b7t9w7pU/iKsjKfUOqCSvGos+mh9GM=
X-Google-Smtp-Source: ABdhPJyYcXNYVhcMfT9j9KLHhMVrOcg4OkfUvd5RTY0uiFauCr3DGk+ngb1IrEtT5qfOgiWvn4IxLuF5YsvEljDPdnU=
X-Received: by 2002:a37:a187:: with SMTP id k129mr12135401qke.435.1603020938477;
 Sun, 18 Oct 2020 04:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZsnMd3SdnH2bchxfkR7_Ka1wDvu9Z592uaK3FFm4rszTw@mail.gmail.com>
 <20201016212846.GA109479@bjorn-Precision-5520> <CAA85sZuOh8ZtnWj8svxK_9er7hLskTjc0ASUVkvAkv9Rc=Bh_g@mail.gmail.com>
In-Reply-To: <CAA85sZuOh8ZtnWj8svxK_9er7hLskTjc0ASUVkvAkv9Rc=Bh_g@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Sun, 18 Oct 2020 13:35:27 +0200
Message-ID: <CAA85sZufMEAieVgzxdPrbCzaPV0eM_NYX7idWkLVxQaJrYjC+A@mail.gmail.com>
Subject: Re: [PATCH] Use maximum latency when determining L1 ASPM
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 17, 2020 at 12:41 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Fri, Oct 16, 2020 at 11:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Oct 14, 2020 at 03:33:17PM +0200, Ian Kumlien wrote:
> > > On Wed, Oct 14, 2020 at 10:34 AM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > > > On Oct 12, 2020, at 18:20, Ian Kumlien <ian.kumlien@gmail.com> wrote:
> > > > > On Thu, Oct 8, 2020 at 6:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > > > >> OK, now we're getting close.  We just need to flesh out the
> > > > >> justification.  We need:
> > > > >>
> > > > >>  - Tidy subject line.  Use "git log --oneline drivers/pci/pcie/aspm.c"
> > > > >>    and follow the example.
> > > > >
> > > > > Will do
> > > > >
> > > > >>  - Description of the problem.  I think it's poor bandwidth on your
> > > > >>    Intel I211 device, but we don't have the complete picture because
> > > > >>    that NIC is 03:00.0, which doesn't appear above at all.
> > > > >
> > > > > I think we'll use Kai-Hengs issue, since it's actually more related to
> > > > > the change itself...
> > > > >
> > > > > Mine is a side effect while Kai-Heng is actually hitting an issue
> > > > > caused by the bug.
> > > >
> > > > I filed a bug here:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=209671
> > >
> > > Thanks!
> >
> > Sigh.  I feel like I'm just not getting anywhere here.  I still do not
> > have a "before" and "after" set of lspci output.
> >
> > Kai-Heng's bugzilla has two sets of output, but one is a working
> > config with CONFIG_PCIEASPM_DEFAULT=y and the other is a working
> > config with Ian's patch applied and CONFIG_PCIEASPM_POWERSAVE=y.
> >
> > Comparing them doesn't show the effect of Ian's patch; it shows the
> > combined effect of Ian's patch and the CONFIG_PCIEASPM_POWERSAVE=y
> > change.  I'm not really interested in spending a few hours trying to
> > reverse-engineer the important changes.
> >
> > Can you please, please, collect these on your system, Ian?  I assume
> > that you can easily collect it once without your patch, when you see
> > poor I211 NIC performance but the system is otherwise working.  And
> > you can collect it again *with* your patch.  Same Kconfig, same
> > *everything* except adding your patch.
>
> Yeah I can do that, but I would like the changes output from the
> latest patch suggestion
> running on Kai-Heng's system so we can actually see what it does...

Is:
https://bugzilla.kernel.org/show_bug.cgi?id=209725

More to your liking?

> > Bjorn
