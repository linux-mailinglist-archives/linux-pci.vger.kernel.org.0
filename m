Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70B4200A5
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJCIGS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 04:06:18 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:44786 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhJCIGR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 3 Oct 2021 04:06:17 -0400
Received: by mail-vs1-f46.google.com with SMTP id 66so16061409vsd.11;
        Sun, 03 Oct 2021 01:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gziZUXg+ufVsN4o4S4hYKnfox38YULzXFqWZ6ylXnaQ=;
        b=FRGWOq4cBB0GB48OLUwMmGlY13X9wNMf8w8z2NY7T3jbaA8UJhNtO9wcfrfTN3wEKJ
         v9v3EsyraexQswxh38s61tIhNsX2Yrpc7i2MHGjSZPGOJjUjgrbVm6SkciX5GYkLNzA8
         vUPnDTJW+mzW/uwRDwWb5K3FhQFvsxrz/rsjv3T1yfDz+zmQDFcfmufBBONU2HA26AVJ
         /zopYJWw720y3GmJ2+i0/kA4a+fyztVYlhlMeKh9qmZw9W12sG66LZ503oco0dAln0EQ
         CYnTHMM2G9xSi9fHoQ188N1ZY2oA9KgucYAlhHpn2DSZ0jlg4SkdJWaQlt50tHKrz5ZY
         CwKg==
X-Gm-Message-State: AOAM531e1G8KPp9uDh8YV1bfnPxCnwxBrQcNrsDHJfa2AmMIzDRX5HOM
        6zOfc0ZXb9hQ4/kf9SsJrRzDOb7KpY405F5NzKApXEew
X-Google-Smtp-Source: ABdhPJzqJ4OKCjNFdwCF+QHct5t+ZbK40CVWquqWE4Qns1xFmvQHEpqzmhsAI7rL6ikS3zrZriATRNe9Pg5H44kNsuk=
X-Received: by 2002:a67:f147:: with SMTP id t7mr9431233vsm.41.1633248270183;
 Sun, 03 Oct 2021 01:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdVRqW=v+AKsXKJkm7d_DUubF_zn3tRq560S9m5996PrHw@mail.gmail.com>
 <20211002190114.GA976888@bhelgaas>
In-Reply-To: <20211002190114.GA976888@bhelgaas>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 3 Oct 2021 10:04:19 +0200
Message-ID: <CAMuHMdWLQvO4TL7VdeJ47k+NGojqON6pLw5aaTm+qhBrNzWhdg@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: pcie-rcar-host: Remove unneeded includes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Sat, Oct 2, 2021 at 9:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Oct 02, 2021 at 08:22:13PM +0200, Geert Uytterhoeven wrote:
> > On Sat, Oct 2, 2021 at 6:00 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > Seems overkill to mention "rcar" and "pci" twice in the subject.  We
> > > have so far not distinguished pcie-rcar-host.c and pcie-rcar-ep.c in
> > > subject lines.
> > >
> > > If we want to start doing that consistently, maybe we could use "PCI:
> > > rcar-host:" and "PCI: rcar-ep:" as we have done for cadence-ep and
> > > designware-ep.
> >
> > I know.  But this is for PCIe, and there's also pci-rcar-gen2 for traditional
> > PCI.
>
> We do have a precedent of "rcar-gen2" for that driver:

Feel free to change the prefix while applying.
Or ask for a resend, and risk me not changing it to your liking again ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
