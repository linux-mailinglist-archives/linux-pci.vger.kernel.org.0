Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81DEF851D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 01:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKLAWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 19:22:00 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:40566 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKLAWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 19:22:00 -0500
Received: by mail-qv1-f42.google.com with SMTP id i3so5483041qvv.7
        for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2019 16:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dnImrLwCfDWFxJwmcsvAa0fiZbE181aSgupMV2nY24=;
        b=C5Q1KEMKkzb4HcEXkTOJPf9NP+zVv32HQER+gqIaBPUy8TrBqvYgXA4a6ZJxQhJF0T
         V4W454ocgcQ+nRrClf/Rf0/EuAubuNVwGKPXuetbp5vMgyyTVzYikZTe9JDznvMQpnKC
         nFHPt13F7NQxnZtO5MGOvDrAk3C8XFKeRUhd4L5U/e5lOFyrjlVzxFl09pMv9gU+4AO3
         nrVP6Pilcs3UHBDHrWQwpbujd8o+kjXjENOdrftvsooEUn7HtsbMWRUGMAIC3cRN8wzP
         XSZH9EgE4zV7uwn2W/UmtV3YEUxXArBS6hD9ySZHrovwN9DWKn6vTrE8HiQCFvzUgEE6
         S/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dnImrLwCfDWFxJwmcsvAa0fiZbE181aSgupMV2nY24=;
        b=HYNSmAndaPHerXH42EV8mFm2S1eTs0IAZNmD42JVXqix5bhnhoIntwPjM93rxk9AbH
         zlOrRHjbf5yCqcSwzNipEPKmUikH7iPoHm58F2l6wqcUPybSeDnzT3cEbY7mOWXS6Cej
         3SMPX5fMnqKV2J78jvSl0Bkf0p9smUU4Jb3t8aB1fnHoyCj39PkNrG/uTojT5eHjquuB
         LA6LykBAiGB/mUtrI+YWGYfB9BdClpCGtrkJjfNowuRv3GBXPN2LYbQzV/JcXQL/+Xa8
         5EIWoTMC3UbopF9LfGMx9Z735iobcfQYKTeOTj65kd9vrESahyDKel/gAyoWl+eU46Ai
         0RgA==
X-Gm-Message-State: APjAAAUyHJvFOex7qfQegbmmy3QcrR6PkwJiyz1bsoK/7fy011hO9ZQT
        /9n1zVHWpbgSEHIu9Q7DZdj3I/6hTyLiTJiDelGOcZoFw5Y=
X-Google-Smtp-Source: APXvYqxYFiFSOqxTBYlU02T1WV3knqhZ26kuIrarnHYZNBxAn0VJSMNUVwyv0SKLBPxQak8zMSascx6jZ9zB4Wv2z7A=
X-Received: by 2002:a0c:f603:: with SMTP id r3mr11792769qvm.19.1573518119164;
 Mon, 11 Nov 2019 16:21:59 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYo6mKSMXoDR7St1ynUJ9f3sh=0rgNAbbVvFAfJn82VvVQ@mail.gmail.com>
 <20191112000334.GA69183@google.com>
In-Reply-To: <20191112000334.GA69183@google.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 11 Nov 2019 19:21:48 -0500
Message-ID: <CAMdYzYqQdd5Es3DtWT3M4bBhMrTeZfz--eVGjGzin6jbH3ZwcA@mail.gmail.com>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 11, 2019 at 7:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sun, Nov 10, 2019 at 10:43:48AM -0500, Peter Geis wrote:
>
> > I plugged in an i350 two port nic and examined the assigned address spaces.
> > I've attached it below.
> > Judging by the usage, I think this controller has enough address space
> > for another two port NIC, and that's about it.
> > I'm pretty sure now that the rk3399 controller just doesn't have the
> > address space to map larger devices.
> > I'm pretty sure the IOMMU would allow us to address system memory as
> > pcie address space and overcome this limitation, but I don't know how
> > to do that.
>
> I don't think you're out of MMIO space, at least in this instance.  It
> looks like you have 32MB available and the two-port NIC on bus 01 only
> takes 5MB.
>
> The IOMMU is used for DMA (e.g., reads/writes initiated by the NIC),
> while the MMIO space is used for CPU programmed I/O (reads/writes done
> by the driver running on the CPU).
>
> > The address space for the nic is below:
> > f8000000-f8ffffff : axi-base
> > fa000000-fbdfffff : MEM
>
> 32MB.
>
> >   fa000000-fa4fffff : PCI Bus 0000:01
>
> 5MB.
Just a note, this is not the device that triggered the bug.
This is a i350 NIC, i posted it as a comparison to my original email.
>
> >     fa000000-fa07ffff : 0000:01:00.0
> >       fa000000-fa07ffff : igb
> >     fa080000-fa0fffff : 0000:01:00.0
> >     fa100000-fa17ffff : 0000:01:00.1
> >       fa100000-fa17ffff : igb
> >     fa180000-fa1fffff : 0000:01:00.1
> >     fa200000-fa27ffff : 0000:01:00.0
> >     fa280000-fa2fffff : 0000:01:00.0
> >     fa300000-fa37ffff : 0000:01:00.1
> >     fa380000-fa3fffff : 0000:01:00.1
> >     fa400000-fa403fff : 0000:01:00.0
> >       fa400000-fa403fff : igb
> >     fa404000-fa407fff : 0000:01:00.1
> >       fa404000-fa407fff : igb
> > fd000000-fdffffff : f8000000.pcie
