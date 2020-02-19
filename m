Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3577163FF7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 10:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgBSJHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 04:07:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44358 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgBSJHN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 04:07:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so22384661otj.11;
        Wed, 19 Feb 2020 01:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hl9R42S7bTmTIImSyFBNArkLnawsxqytbv3I5jer4iE=;
        b=XwnW4WNhvn8JGvbdWoY7h4s3J9zIhVUWIk9heioPvbq/FxrffWd1t6dLCIQSjYfwps
         SBSwawhTSiUw5UEU0m4jchppkrSpXXRgSDXT84Brg5JQg0XZbUWhvnLkAidZSr+beN7D
         Dv1TjI6UmRs1GjZE2LaBCmoWAZVdPHTrEwoKM0k9vyRI1Avn+zIO+EF3ulIvlpqHw479
         F2m/agZ1clfz1bpokaCGjmvVI+Tih4XM+li1o/gG0o/WiDoMBarpoP9Vm7EICL9mVaGg
         +fmatW0lJPsQPnyHwIwyoGswfjj3TxNOV4c1OPY1PC36OyMuSDDGzdhoJt1n+ije6i7h
         ilew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl9R42S7bTmTIImSyFBNArkLnawsxqytbv3I5jer4iE=;
        b=UUnRQMKMVzKVE1+6nAtS+Atl9SPTjdBBWGkGlLWYZZITry6iWqdYFuyfvAp1EqqBF3
         P+Op8mFhArK9TgkLR6zQ12hNystynDxEtpjM9pZI+wHnHbpmGf/s51hUZ+Ism8q932IX
         cX6SoNwlokjogPxr/MeYkYBUZtR9JfmMg6qCqylVPL0iwmmi+Ia7PNirhrQS92szviUY
         BY3SctepMmvqpf0rnJt0htx4pk0mXKINUGollX9JcofLGCgjCPX9Zv6nFydH8iGhErEZ
         6IXxCyVveSk53k9Rkkb1Lwuy1t6w964h5ehdd+GXzVQwLDguMCbycuHpQwPRH+9CjCs9
         Jv8g==
X-Gm-Message-State: APjAAAXK1Ln6o8IAdvShk2WlDYEFdM55wQKADJNCL5AA3qWKzNmQ7o9D
        yjyFP0dMKlsB8BOA9dyS4yipc1/Fn2HYkyBACkk=
X-Google-Smtp-Source: APXvYqxHKoYOKLSVj2I0oZVyHx/701r0aK9W1LUqkpwYs0YWVF09ezzLoeZkXL7bRk/YGzWf/TnmQEwIspJzwjO/ZWo=
X-Received: by 2002:a9d:d06:: with SMTP id 6mr19535224oti.176.1582103232048;
 Wed, 19 Feb 2020 01:07:12 -0800 (PST)
MIME-Version: 1.0
References: <20200208183641.6674-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200212140127.GA127398@google.com>
In-Reply-To: <20200212140127.GA127398@google.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 19 Feb 2020 09:06:45 +0000
Message-ID: <CA+V-a8sBPT-RLvzRFFFwbNghD9X26P5qPntoUvgNHQ6_eUzQBg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] PCI: rcar: Preparation for adding endpoint support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thank you for the review.

On Wed, Feb 12, 2020 at 2:01 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> To make the changelog from "git log --oneline" read nicely, the
> subject should begin with a verb, e.g.,
>
>   PCI: rcar: Move shareable code to a common file
>
> On Sat, Feb 08, 2020 at 06:36:36PM +0000, Lad Prabhakar wrote:
> > Prepare for adding endpoint support to rcar controller, there are no
> > functional changes with this patch, a common file is created so that
> > it can be shared with endpoint driver.
>
> This commit log doesn't tell us what this patch does.  "Prepare"
> conveys no real information.  It's a giant patch and it's difficult
> to verify that there's no functional change.
>
> I *think* what you did was move most of the #defines from pcie-rcar.c
> to pcie-rcar.h and most of the code from pcie-rcar.c to
> pcie-rcar-host.c.  And in both case, these were strict *moves* without
> any changes.  If that's the case, please say that explicitly in the
> commit log.
>
> That's good; thanks for making this a separate patch so it's not
> mingled with real changes.
>
Agreed I shall split this patch further more, first patch just
renaming the file from
pcie-rcar.c to pcie-rcar-host.c along with Makefile/Kconfig/defconfig
changes and
the second patch pulling out common code that shall be share between
two drivers.
This shall make it more easier to review.

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  arch/arm64/configs/defconfig            |    2 +-
> >  drivers/pci/controller/Kconfig          |    4 +-
> >  drivers/pci/controller/Makefile         |    2 +-
> >  drivers/pci/controller/pcie-rcar-host.c | 1044 ++++++++++++++++++++++++++
> >  drivers/pci/controller/pcie-rcar.c      | 1229 ++-----------------------------
> >  drivers/pci/controller/pcie-rcar.h      |  126 ++++
> >  6 files changed, 1227 insertions(+), 1180 deletions(-)
> >  create mode 100644 drivers/pci/controller/pcie-rcar-host.c
> >  create mode 100644 drivers/pci/controller/pcie-rcar.h
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index b2f6673..8a1f51d 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -182,7 +182,7 @@ CONFIG_HOTPLUG_PCI=y
> >  CONFIG_HOTPLUG_PCI_ACPI=y
> >  CONFIG_PCI_AARDVARK=y
> >  CONFIG_PCI_TEGRA=y
> > -CONFIG_PCIE_RCAR=y
> > +CONFIG_PCIE_RCAR_HOST=y
> >  CONFIG_PCI_HOST_GENERIC=y
> >  CONFIG_PCI_XGENE=y
> >  CONFIG_PCIE_ALTERA=y
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index f84e5ff..94bb5e9 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -54,12 +54,12 @@ config PCI_RCAR_GEN2
> >         There are 3 internal PCI controllers available with a single
> >         built-in EHCI/OHCI host controller present on each one.
> >
> > -config PCIE_RCAR
> > +config PCIE_RCAR_HOST
>
> The config symbol change should be mentioned in the commit log.  In
> general we try to avoid changing config symbols because it's likely to
> confuse people who keep their .config and update their kernel.  But I
> guess your audience is probably pretty small.
>
I shall mention it in my commit message.

> >       bool "Renesas R-Car PCIe controller"
>
> The description needs to be updated, too.  This is what people will
> see in menuconfig.
>
I shall update it accordingly.

> >       depends on ARCH_RENESAS || COMPILE_TEST
> >       depends on PCI_MSI_IRQ_DOMAIN
> >       help
> > -       Say Y here if you want PCIe controller support on R-Car SoCs.
> > +       Say Y here if you want PCIe controller support on R-Car SoCs in host mode.
>
> Wrap this so it fits in 80 columns like the rest of the file.
>
Will fix that.

Cheers,
--Prabhakar Lad

> Bjorn
