Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB41A2D7CAA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgLKRTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 12:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394651AbgLKRSs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 12:18:48 -0500
X-Gm-Message-State: AOAM532lxIMXKSeKJ/OdQd7Qx3sTzkZ8lSeQnCXFNB95eFpuV1AT2XQQ
        0etz+7HIl1tgIhxvaL1+c5KzjTkSaNaA8G173g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607707086;
        bh=MXoc7X7tkOfaRyYAZbOQBQCpFZXp3rgD9mZAujYdpKE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mGPC2bD1+im3+DgiviNp3qyCqD78YAqmnB1Bou0u2wO2FF+suO1bx0FW7MxmATv2d
         g1iiWRfJRjxI/33z4TtAWrletToN1tdDEhXxhTEjKNk8rPy8aYL0clvBpEq2VI1oNA
         iUUgwoEm4Je9vtCQ2ripjBxvYla2y3GMUJqw6XpZUEDKiGvmT8qFmm/MDsQRInY7zk
         SR5Dfls/7MLLCwkcgZIuZDpN4vaEgg9zeMotJs3lyjTGiCChedc3q/liCKfZqQji98
         JizQypDYcadSyzx8dNc5zvVNxjADop+vzoQAUWkyE+HbzMWLcn4Nb2QsDA+e7cnr6z
         oQPR7yb3BCyug==
X-Google-Smtp-Source: ABdhPJxL7+IFzGM7eyss+J4Ez1RQzcdPy0CElkd/J858q3bNaxU/Wfzh5MF6ogqtxy84FLINebXFMvS4r3dQh7B3ors=
X-Received: by 2002:a17:906:ae43:: with SMTP id lf3mr11049935ejb.130.1607707085155;
 Fri, 11 Dec 2020 09:18:05 -0800 (PST)
MIME-Version: 1.0
References: <CAL_JsqK7EtRhGhd20P2raj1C4GLOoBQ55ngY+BvygRE-61E+9A@mail.gmail.com>
 <20201211165440.GA80431@bjorn-Precision-5520>
In-Reply-To: <20201211165440.GA80431@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 11 Dec 2020 11:17:53 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+W9sgwAveYso=50UqdLevO=E=5ihi+7kAEjYMtq=Y7kQ@mail.gmail.com>
Message-ID: <CAL_Jsq+W9sgwAveYso=50UqdLevO=E=5ihi+7kAEjYMtq=Y7kQ@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Add support to configure for ECRC
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 11, 2020 at 10:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Dec 11, 2020 at 08:49:16AM -0600, Rob Herring wrote:
> > On Fri, Dec 11, 2020 at 7:58 AM Vidya Sagar <vidyas@nvidia.com> wrote:
> > >
> > > Hi Lorenzo,
> > > Apologies to bug you, but wondering if you have any further comments on
> > > this patch that I need to take care of?
> >
> > You can check the status of your patches in Patchwork:
> >
> > https://patchwork.kernel.org/project/linux-pci/patch/20201111121145.7015-1-vidyas@nvidia.com/
> >
> > If it's in 'New' state and delegated to Lorenzo or Bjorn, it's in
> > their queue. You can shorten the queue by reviewing stuff in front of
> > you. :)
>
> Thanks for pointing this out, this is exactly right.  I *love* it when
> people help review things.  Obviously it saves me time, and often it
> raises questions I would have missed.

I can't take credit, this was actually someone's strategy for getting
their patches reviewed I heard about one time.

> Even "trivial" things like spelling, grammar, whitespace, subject line
> formats, etc. help because they are distractions to me and I will
> comment on them or spend time fixing them myself.  That doesn't mean
> "repost immediately after somebody points out a typo"; it means
> "collect feedback for a week or so, fix everything, *then* repost."
>
> This is an old but still relevant list of some of my OCD tendencies
> that take no special expertise to review for:
> https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/

It's been on my wish list for checkpatch.pl do something like: "Commit
subject should begin $(git log --oneline $files | cut -d':' -f-3 |
sort | uniq -c | sort -nr | head -1)". Or maybe a git commit template
to fill in subject prefix and Cc list. The hard part is of course all
the corner cases such as touching multiple directories/files.

Rob
