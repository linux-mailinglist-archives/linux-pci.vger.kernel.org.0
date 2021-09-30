Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D5341E0C5
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353330AbhI3SRu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 14:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353324AbhI3SRt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 14:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B57EA61A02;
        Thu, 30 Sep 2021 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633025766;
        bh=imSE4BVzuaU5GQAHEWNZDou02owSeD9rScj3NMKL5tQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UOprfN2x/NY+/h0DEp5g2ccaRzifbUjlraQmYYDWZ40OLXVXOySoiqGezxTAiSdF8
         xa6YqtAFwmqCyi/Yg/l6FnNy/TeE9yweMpiAdRPzKAsPjORYAFNSblbfxAr6aWv2kC
         tZBZMukdusiuqJD1gZyaC8okNHI088GSFlgUB3O2K7aVB9BPtxwTqUQE4SCgNiMqyL
         f/ojoSWywBMGBmHUR4E9gHJUg7oDijgesNdrDaIuZJ2SR3MP4oQmSMYFMd22D5loWz
         Kon13qHTv90UckRAYx5zT7eQCwXYfkXm/Ry4FZfiz+TsNlC94HCyz3qPAyiv3Hej62
         7F5loyAP2D/mg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAMuHMdV8Xu-Pgda9ZrgaXFqXdzBrSRWwiSQFLjzxqRGNWkO3wQ@mail.gmail.com>
References: <20210907144512.5238-1-marek.vasut@gmail.com> <163297980091.358640.10064724088378840378@swboyd.mtv.corp.google.com> <CAMuHMdV8Xu-Pgda9ZrgaXFqXdzBrSRWwiSQFLjzxqRGNWkO3wQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add missing COMMON_CLK dependency
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Sep 2021 11:16:05 -0700
Message-ID: <163302576552.358640.2337603190171807403@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Geert Uytterhoeven (2021-09-30 01:01:24)
> Hi Stephen,
>=20
> On Thu, Sep 30, 2021 at 7:30 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > +linux-clk as I don't regularly read my inbox :/
> >
> > Quoting marek.vasut@gmail.com (2021-09-07 07:45:12)
> > > From: Marek Vasut <marek.vasut+renesas@gmail.com>
> > >
> > > Add COMMON_CLK dependency, otherwise the following build error occurs:
> > >   arm-linux-gnueabi-ld: drivers/pci/controller/pcie-rcar-host.o: in f=
unction `rcar_pcie_aarch32_abort_handler':
> > >   pcie-rcar-host.c:(.text+0xdd0): undefined reference to `__clk_is_en=
abled'
> > > This should be OK, since all platforms shipping this controller also
> > > need COMMON_CLK enabled for their clock driver.
> > >
> > > Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abor=
t hook")
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: Wolfram Sang <wsa@the-dreams.de>
> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Cc: linux-renesas-soc@vger.kernel.org
> > > ---
> > > +CC Stephen, please double-check whether this is the right approach or
> > >     whether there is some better option
> >
> > Stop using __clk_is_enabled()? I don't quite understand what's going on=
 in
> > the code but __clk_is_enabled() should really go away. I thought we were
> > close to doing that but now I see a handful of calls have come up. The
> > API should be replaced by clk_hw_is_enabled() and then removed. We move
> > it to clk_hw API so that only clk providers can look at it.
>=20
> But this is not a clk provider...
>=20
> > Sigh!
>=20
> ;-)

Exactly!

>=20
> > Anyway, fixing the dependency is "ok" but really the long term fix would
> > be to not use a "is this clk enabled" sort of API. If I'm reading the
> > code correctly, this is some sort of fault handler that's trying to
> > avoid hanging the bus while handling the fault so it tries to make sure
> > the clk is enabled first? Is it a problem if the clk is not actually
> > enabled here? Would runtime PM enable state of the device work just as
> > well?
>=20
> Thanks, checking Runtime PM state is a good suggestion. Doing so
> would require caching a pointer to the PCIe struct device instead of
> the struct clk.
> However, pcie_bus_clk is not the module clock, which is managed by
> Runtime PM, but the PCIe bus clock, which is managed explicitly by
> the driver.
> However, I believe that we are checking the wrong clock, as register
> access needs the module clock to be enabled, not the PCIe bus clock?
> As the driver just calls pm_runtime_get_sync() and clk_prepare_enable()
> in .probe(), and never touches Runtime PM status or the PCIe bus clock
> during the further lifetime of the driver (it cannot be unloaded), both
> the module clock and the PCIe bus clock should always[*] be enabled
> when the static copy of the remapped PCIe controller address is valid.
> [*] Modulo system-wide power transitions like s2ram. Does
>     pm_runtime_suspended() reflect that state, too?
>=20

Great! If that's all correct then simply removing the call to
__clk_is_enabled() should work. Can we do that?
