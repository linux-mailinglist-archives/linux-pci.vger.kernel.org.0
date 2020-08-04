Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC26E23BE5F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgHDQst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 12:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgHDQsq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 12:48:46 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3540322B42;
        Tue,  4 Aug 2020 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596559726;
        bh=XtTYH2CBM+FfyYHxxzZ/HqJhy5od5481V87r3BsfF1g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cTYyYczrP2Fza0nJZl/33bicYLldzN3ycfuQiiZoGY7cIGCJZkmDJROuhIGkeneyD
         aQhbyWQlDi9p33/rrob1WQynWVsYWvmPWYpwnhLIpgq6vWAxCqH7tfL6r1YansBg+1
         G4xka8sQI+C1eDG15xLn4+TcEphbvVGqdFZwrFLE=
Received: by mail-ot1-f53.google.com with SMTP id z18so10593951otk.6;
        Tue, 04 Aug 2020 09:48:46 -0700 (PDT)
X-Gm-Message-State: AOAM530+VfLZ55G+99Vzf2Y9o8YLz4NkcAfWq57tpDwk6SuoC77YbQSy
        1vZdH2e5kNBdEFxOvyW5u0aHboQ2HWj3OgbWNg==
X-Google-Smtp-Source: ABdhPJzPV8uvXqh6O/JUBpj5TnwgwzExJk0S9hLiInnICudH7jyw70A8FQVV0CT8jJVusYUZQSRCTMACd9K2r0hD+EA=
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr10321004otp.192.1596559725452;
 Tue, 04 Aug 2020 09:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200804161325.GA11104@e121166-lin.cambridge.arm.com> <20200804162223.GA420993@bjorn-Precision-5520>
In-Reply-To: <20200804162223.GA420993@bjorn-Precision-5520>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Aug 2020 10:48:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZTu0=MhFDOgPC92i48mGjtq9aSJAc84i+wq2YT3O31g@mail.gmail.com>
Message-ID: <CAL_JsqKZTu0=MhFDOgPC92i48mGjtq9aSJAc84i+wq2YT3O31g@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar-gen2: Fix crash in resource_list_first_type()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - FCP" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 4, 2020 at 10:22 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Aug 04, 2020 at 05:13:25PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Aug 04, 2020 at 02:04:30PM +0200, Geert Uytterhoeven wrote:
> > > The conversion to modern host bridge probing made the driver allocate
> > > its private data using devm_pci_alloc_host_bridge(), but forgot to
> > > remove the old allocation.  Hence part of the driver initialization is
> > > done using the new instance, while another part is done using the old
> > > instance, leading to a crash due to uninitialized bridge DMA ranges:
> > >
> > >     Unable to handle kernel NULL pointer dereference at virtual address 00000008
> > >     pgd = (ptrval)
> > >     [00000008] *pgd=00000000
> > >     Internal error: Oops: 5 [#1] SMP ARM
> > >     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.8.0-rc1-shmobile-00035-g92d69cc6275845a7 #645
> > >     Hardware name: Generic R-Car Gen2 (Flattened Device Tree)
> > >     PC is at rcar_pci_probe+0x154/0x340
> > >     LR is at _raw_spin_unlock_irqrestore+0x18/0x20
> > >
> > > Fix this by dropping the old allocation.
> > >
> > > Fixes: 92d69cc6275845a7 ("PCI: rcar-gen2: Convert to use modern host bridge probe functions")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  drivers/pci/controller/pci-rcar-gen2.c | 4 ----
> > >  1 file changed, 4 deletions(-)
> >
> > Squashed in the initial commit, pushed out on pci/misc.
>
> I updated my 'next' branch with this.
>
> Rob, are there any similar issues in other drivers that we should fix
> before asking Linus to pull this?

I'd expect only different issues. :)

This commit is unique as it was using the old arm32 PCI functions and
the most complicated change of the lot.

Rob
