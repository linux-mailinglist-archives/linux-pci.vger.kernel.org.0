Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4D83198A4E
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 05:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgCaDBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 23:01:10 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33903 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgCaDBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2020 23:01:10 -0400
Received: by mail-il1-f196.google.com with SMTP id t11so18045148ils.1;
        Mon, 30 Mar 2020 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=cnHGhaVmF2sZ2zdyMkAgybYPXWimI0xp+Owp3zivaQI=;
        b=Kh8bl44hOUrGrVDvAEQwboGhE8JT4Lq45vBR91/9ebcXk415gUb63f7QzHacwzKxXA
         NZvpRYm0/zAZOUogKxv1bHGANo2lzr51qC/d15pVYWM5EbSAM4fIEVYTEf1pAFA1s0Qp
         SEx0j3JrVkOqoqNHnwpnOPm6ediSY0d2mt1WnKjYKyDJFSqeCaMc6siPCPj/0jcSC3BR
         DCL12V+XP7heHLbCUrsICt/NaNuac84ai9S36vjw0zGQBASd93jaNWBCXvxRiRlHZtLn
         ZK/dN7If6SwjNaV+GAFDcAybagpOH0JNc/ArpN2qUZIx+fhqlMQMGTOuMJ1px+rauEOw
         pHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=cnHGhaVmF2sZ2zdyMkAgybYPXWimI0xp+Owp3zivaQI=;
        b=FSbHOWdAkpDFXmOgitXcDqMo1HpVdgtnc63lF/u1T0vu54laVbbcO/gLg6On50+psb
         0S+NQ91TzXkDTuPKE07hjWFqAtNj2q6NyFi6frQCNkkQ8mWssPPrXHH6zXdBELk1Xsx0
         AJB91g2Eep9xUZ3t/7wxS82BYbPaC8NQoKqS3gqTsNvaA+e5nukh37Os431lyrx0EnzS
         sCkEhd3LAC1UIPu9zF9ofrvIx+M9pzap8kubNnAKB9cEos9t0FwImKblXhywBp/8eUkx
         bfM8IPXD7k4LTCI3gXsasERAY4CznGpUnkA4SuTR/u16hTjSZ5vUGyOL+IDdEkNSl66E
         zaPA==
X-Gm-Message-State: ANhLgQ1YNYjhnuVzTVdTI980WV6pnOLG4TDCMJ2157rBlAp3JOFsA3/k
        oLMlMCTAEOs+VIw52Qn6kXeQLKYBA/Yp5leOuc4=
X-Google-Smtp-Source: ADFU+vuGuZE7rZTqrboHL4BoLb0D+bPlHXVLsiF86m6TGldaTLI2ztokC5N2VOTQYpOgA2Q7/5qpT9b+kZdqELV4Hcg=
X-Received: by 2002:a92:49da:: with SMTP id k87mr11067344ilg.149.1585623669293;
 Mon, 30 Mar 2020 20:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200330214721.GA128269@google.com> <bba72560-85cc-b59b-b0e8-bfc7c7408736@nvidia.com>
In-Reply-To: <bba72560-85cc-b59b-b0e8-bfc7c7408736@nvidia.com>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Mon, 30 Mar 2020 22:00:57 -0500
Message-ID: <CABhMZUXub++CLTJ_E88Jwar5RvVfL+3aWOHqZf5XSVeyS8X=wA@mail.gmail.com>
Subject: Re: [PATCH V5 5/5] PCI: tegra: Add support for PCIe endpoint mode in Tegra194
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        Andrew Murray <andrew.murray@arm.com>, kishon@ti.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ARM <linux-arm-kernel@lists.infradead.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 30, 2020 at 9:55 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 3/31/2020 3:17 AM, Bjorn Helgaas wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Mar 03, 2020 at 11:40:52PM +0530, Vidya Sagar wrote:
> >> Add support for the endpoint mode of Synopsys DesignWare core based
> >> dual mode PCIe controllers present in Tegra194 SoC.
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> Acked-by: Thierry Reding <treding@nvidia.com>
> >> ---
> >> V5:
> >> * Added Acked-by: Thierry Reding <treding@nvidia.com>
> >> * Removed unwanted header file inclusion
> >>
> >> V4:
> >> * Addressed Lorenzo's review comments
> >> * Started using threaded irqs instead of kthreads
> >>
> >> V3:
> >> * Addressed Thierry's review comments
> >>
> >> V2:
> >> * Addressed Bjorn's review comments
> >> * Made changes as part of addressing review comments for other patches
> >>
> >>   drivers/pci/controller/dwc/Kconfig         |  30 +-
> >>   drivers/pci/controller/dwc/pcie-tegra194.c | 679 ++++++++++++++++++++-
> >>   2 files changed, 691 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> >> index 0830dfcfa43a..169cde58dd92 100644
> >> --- a/drivers/pci/controller/dwc/Kconfig
> >> +++ b/drivers/pci/controller/dwc/Kconfig
> >> @@ -248,14 +248,38 @@ config PCI_MESON
> >>          implement the driver.
> >>
> >>   config PCIE_TEGRA194
> >> -     tristate "NVIDIA Tegra194 (and later) PCIe controller"
> >> +     tristate
> >> +
> >> +config PCIE_TEGRA194_HOST
> >> +     tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
> >>        depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> >>        depends on PCI_MSI_IRQ_DOMAIN
> >>        select PCIE_DW_HOST
> >>        select PHY_TEGRA194_P2U
> >> +     select PCIE_TEGRA194
> >> +     default y
> >
> > Sorry I missed this before, but why is this "default y"?  From
> > Documentation/kbuild/kconfig-language.rst:
> >
> >    The default value deliberately defaults to 'n' in order to avoid
> >    bloating the build. With few exceptions, new config options should
> >    not change this. The intent is for "make oldconfig" to add as little
> >    as possible to the config from release to release.
> >
> > I do see that several other things in other drivers/pci/ Kconfig files
> > are also "default y", and we should probably change some of them.  But
> > I don't want to add even more unless there's a good reason.
> >
> > I'm not looking for more reactions like these:
> >
> > https://lore.kernel.org/r/CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com
> > https://lore.kernel.org/r/CA+55aFzPpuHU1Nqd595SEQS=F+kXMzPs0Rba9FUgTodGxmXsgg@mail.gmail.com
> >
> > Can you please update this patch to either remove the "default y" or
> > add the rationale for keeping it?
> I'm fine with removing 'default y' line.
> Should I send a patch only with this change?

I think it's probably just as easy for Lorenzo to delete that line on
his branch.  If not, I'll cherry-pick the patches on that branch and
do it locally.

Bjorn
