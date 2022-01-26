Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C812649C381
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 07:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiAZGMu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 01:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiAZGMu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 01:12:50 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95AFC06161C;
        Tue, 25 Jan 2022 22:12:49 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id f24so41458864uab.11;
        Tue, 25 Jan 2022 22:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzuXjR8sdgp43ldUXNvyiLO+/H5LgW115FLVANT8VPs=;
        b=Sv/W49M6+sHHCqQzLHnuN7kc79Ck7tBKf6e6qE51yUJZ/HhIsaSRJMvQ9y+HmB7joB
         i2jTYBRHVgRr+xYjvbvv5D73s7LIFFMIQA4rD1xXYBJ/KNCy2vzZUVFjSnfVulWeXRwQ
         hTIdoU8n+AMYTscDagxykIZRrVKwBL6mZXJdf8ZKfIbrvWmHjxu9L4JSK7jH3bJ5v28C
         jOzjCyIk8PfQaq8tCkGV6Pk9ljNmDMI9EbneLRhgY2yaNTG8Ms/1nLFJQN5kvByJwkwq
         DoB7tTPhXxHAnTGnHhLYI9pChpmX6IwH89DyYMCOpUOTg3TqKcMOuLiT10kOiyASaJgl
         M2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzuXjR8sdgp43ldUXNvyiLO+/H5LgW115FLVANT8VPs=;
        b=jpcEwORaqTW2d6ob1CTJ9v8kmmLC8kgDjFptowcCpcoQSQ3TkMOruPN8+j9KvzJu7V
         kswfiPjst1xT5zp5yVo1iLKKBck+cdHKmwV2PZo89dQKeVQafHoDU9PoqU41jh3coBDI
         aSO0j21UFYna681hl5NAR19keylmWlIXDmSPJx561wqgLvacestg/T/762mHHSB+Rdop
         zKJXJi9ksFA8JQ9tmiQvJV/crwv1FnxWFZNbKeS/XV8GBL5W54e28XaRM5mC/LiL+a/0
         bMvbUWO1XSJ4SsLnvZsH5rzipmyLs+xXTP818I0aD9Kb3QD6Es7tdFQWBwpHEpruuj/p
         i16Q==
X-Gm-Message-State: AOAM533+3l+/77EaDArRyca+LcyAAuX3Df/N6uFNIOvdG+o9nw6yeQBg
        Ff8LyGKplkDXVz373aZ1WYJ1nteVxVN3iMBpH1Y=
X-Google-Smtp-Source: ABdhPJydAeD1Fo9q4qNsQ/sP93KdCim2tQXqc4m6XcvTFNSkkmqCpA+vVzvQhhPrKNcTtlRBzyk3UWVpvSg8vR9llLc=
X-Received: by 2002:a67:c98d:: with SMTP id y13mr3176472vsk.43.1643177568967;
 Tue, 25 Jan 2022 22:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20220124113003.406224-1-sergio.paracuellos@gmail.com> <20220126000454.GA1651403@bhelgaas>
In-Reply-To: <20220126000454.GA1651403@bhelgaas>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 26 Jan 2022 07:12:37 +0100
Message-ID: <CAMhs-H9=USBNpNKEfY+G11KofUoAOC2YQzE0N-_FMvVeKsZ_zA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: mt7621: address some kernel test robot reported warnings
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 26, 2022 at 1:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Jan 24, 2022 at 12:30:01PM +0100, Sergio Paracuellos wrote:
> > Kernel test robot complains about two things here[0]:
> > - pcie_rmw() [-Wunused-function]
> > - 'mt7621_pcie_ids' [-Wunused-const-variable]
> >
> > Address this two warnings in this small two patches.
> >
> > Best regards,
> >     Sergio Paracuellos
> >
> > [0]: https://lkml.org/lkml/2022/1/24/264
> >
> > Sergio Paracuellos (2):
> >   PCI: mt7621: drop 'of_match_ptr' to fix -Wunused-const-variable
> >   PCI: mt7621: remove unused function pcie_rmw()
> >
> >  drivers/pci/controller/pcie-mt7621.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
>
> Both applied to for-linus for v5.17, thank you!

Thanks for letting me know, Bjorn.

Best regards,
    Sergio Paracuellos
