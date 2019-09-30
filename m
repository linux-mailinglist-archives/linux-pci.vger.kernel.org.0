Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90250C2865
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfI3VPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 17:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbfI3VPx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 17:15:53 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68948224BF
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569864994;
        bh=zv4Uxz31XKM+MyjvtqcSjJlGgyTtf32vJB/lTpIHbDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cHvJD06PMIzqUbJ1zlwF5MFgINfQZlmbqEnm1VNd3xI6UtbILrXYDEjoSI8dt+1kZ
         w+Bv83P7KaVeJBX2+40Xj6QI0uniL0cbCStECLik8uA4qNOitQ/w73EsvrP8us/hzd
         7jx82UdGVO80vcwpjzgoi5dUMY34PYIJZwUPV8ss=
Received: by mail-qk1-f170.google.com with SMTP id z67so8501470qkb.12
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 10:36:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXTnErIR8d/ilizXEZX+D9b89MRVIeh2qfUqLDZ52hqu5ufiQqi
        ursKr02EHlV4P47iqncUAtpWA8BEd2aIwpeJVQ==
X-Google-Smtp-Source: APXvYqxLrOssw9YrboppxecvjeDTysPUyAiqArm1DBIXe/0oTUVaz6AFg2izbbt7oMclPdk29NzrflIdhzCHlxZ4hB8=
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr1318692qkl.152.1569864993590;
 Mon, 30 Sep 2019 10:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-3-robh@kernel.org>
 <20190925102423.GR9720@e119886-lin.cambridge.arm.com> <CAL_JsqKN709cOLtDLdKXmDzeNLYtGekMT2BiZic4x45UopenwA@mail.gmail.com>
 <20190930151346.GD42880@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190930151346.GD42880@e119886-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Sep 2019 12:36:22 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+3S7+E+a5E122aR7s0a9SxkMyxw2t=OkO4pS5QUR+0CA@mail.gmail.com>
Message-ID: <CAL_Jsq+3S7+E+a5E122aR7s0a9SxkMyxw2t=OkO4pS5QUR+0CA@mail.gmail.com>
Subject: Re: [PATCH 02/11] PCI: altera: Use pci_parse_request_of_pci_ranges()
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 10:13 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Wed, Sep 25, 2019 at 07:33:35AM -0500, Rob Herring wrote:
> > On Wed, Sep 25, 2019 at 5:24 AM Andrew Murray <andrew.murray@arm.com> wrote:
> > >
> > > On Tue, Sep 24, 2019 at 04:46:21PM -0500, Rob Herring wrote:
> > > > Convert altera host bridge to use the common
> > > > pci_parse_request_of_pci_ranges().
> > > >
> > > > Cc: Ley Foon Tan <lftan@altera.com>
> > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > Cc: rfi@lists.rocketboards.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> >
> > > > @@ -833,9 +800,8 @@ static int altera_pcie_probe(struct platform_device *pdev)
> > > >               return ret;
> > > >       }
> > > >
> > > > -     INIT_LIST_HEAD(&pcie->resources);
> > > > -
> > > > -     ret = altera_pcie_parse_request_of_pci_ranges(pcie);
> > > > +     ret = pci_parse_request_of_pci_ranges(dev, &pcie->resources,
> > >
> > > Does it matter that we now map any given IO ranges whereas we didn't
> > > previously?
> > >
> > > As far as I can tell there are no users that pass an IO range, if they
> > > did then with the existing code the probe would fail and they'd get
> > > a "I/O range found for %pOF. Please provide an io_base pointer...".
> > > However with the new code if any IO range was given (which would
> > > probably represent a misconfiguration), then we'd proceed to map the
> > > IO range. When that IO is used, who knows what would happen.
> >
> > Yeah, I'm assuming that the DT doesn't have an IO range if IO is not
> > supported. IMO, it is not the kernel's job to validate the DT.
>
> Sure. Is it worth mentioning in the commit message this subtle change
> in behaviour?

Will do.

> > > I wonder if there is a better way for a host driver to indicate that
> > > it doesn't support IO?
> >
> > We can probably test for this in the schema.
> >
> > ranges:
> >   items:
> >     minItems: 7
> >     items:
> >       - not: { const: 0x01000000 }
> >
> > Or "- enum: [ 0x42000000, 0x02000000 ]"
> >
> > Of course, in theory, the bus, dev, fn fields could be non-zero and we
> > could use minium/maximum to handle those, but in practice I think they
> > are rarely used for FDT.
>
> Many controllers also appear to set the top bit (relocatable), e.g.
> 0x82000000...

That begs the question how many should set the relocatable bit and don't...

Anyways, it's still a smallish set of possible values and worthwhile
to describe which ones a controller supports.

> At present there are no PCI bindings that use the YAML schema, if I've
> understood correctly.

Probably so, there has been at least one under review. Intel LGM IIRC.
We do need a common PCI schema too. Hopefully someone beats me to it.

Rob
