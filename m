Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A085B3A8BB3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 00:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhFOWWp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 18:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhFOWWp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 18:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A70461076;
        Tue, 15 Jun 2021 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623795640;
        bh=tMEd1NbcJGOdaQ85D/yQ37g3DFb4a50ffAc8sMH8T98=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tlZiw2AzSAcSlzDNmIvYW9MjiOA3goOMmexq8x4Tgy7SppvWzRY7ctMjQCzSwn3z1
         0znn2DqLO88DhqXUkPQFamiwUpnDuwcYxte9i8IX1U8Decu1lkmWSJ43+i+8ak8PS7
         LBlbKzqWD8zAtryapqS6tHmI7Rlpqg6z8KQj7aA6cTH447Y2XiP5e2yChVhlHAr1D+
         1zc76r08/wfNyuNg7PLhLj8kyG+5ijGMCsdtvTdD8yvSAl1UBWTS6Acju63hNWbl6F
         /1ZBft1FYK1qQLq3oXITUhfxYsvjadrMCmx/ooRhYhACsUnYh3t3NfST7MGmbGAHJv
         OKRNmS+KdV4uw==
Received: by mail-ej1-f45.google.com with SMTP id og14so307638ejc.5;
        Tue, 15 Jun 2021 15:20:39 -0700 (PDT)
X-Gm-Message-State: AOAM532WyZZ0v365hf3Zy471YSQ3FqWwK/d5e7FOStvnaokOGlZYGJZ9
        YHBemMdgFeJTCfK6BrPDfFUMOnEe9ywxcGxAKQ==
X-Google-Smtp-Source: ABdhPJyzY5zUYaRnw2eOaG+VjIQysg+UrrvPJad03HOZ79jf5Wm5l0HZgqf8nb7U9ewkq6fPWhQdAuJpw6WqQrFpzFI=
X-Received: by 2002:a17:907:2059:: with SMTP id pg25mr1754060ejb.130.1623795638647;
 Tue, 15 Jun 2021 15:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
 <20210603103814.95177-3-manivannan.sadhasivam@linaro.org> <YLw744UeM6fj/xoS@builder.lan>
 <CAL_Jsq++bSPiKcgWUr6AJbJfidPNpUSFCtarRGEV4GP7fb8yPw@mail.gmail.com> <YMkiSDxOhD7jun3x@builder.lan>
In-Reply-To: <YMkiSDxOhD7jun3x@builder.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Jun 2021 16:20:26 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jbOkQ0png89XsJEg7HNmkefPFOG1fypmsH=tvs=B_3A@mail.gmail.com>
Message-ID: <CAL_Jsq+jbOkQ0png89XsJEg7HNmkefPFOG1fypmsH=tvs=B_3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PCI: dwc: Add Qualcomm PCIe Endpoint controller driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 On Tue, Jun 15, 2021 at 3:57 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 15 Jun 16:40 CDT 2021, Rob Herring wrote:
>
> > On Sat, Jun 5, 2021 at 9:07 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Thu 03 Jun 05:38 CDT 2021, Manivannan Sadhasivam wrote:
> > >
> > > > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > > > the Designware core with added Qualcomm specific wrapper around the
> > > > core. The driver support is very basic such that it supports only
> > > > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > > > for now but these will be added later.
> > > >
> > > > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > > > operation and written on top of the DWC PCI framework.
> > > >
> > > > Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > > [mani: restructured the driver and fixed several bugs for upstream]
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >
> > > Really nice to see this working!
> >
> > [...]
> >
> > > > +static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
> > > > +{
> > > > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PCIE_PERST_EN);
> > >
> > > Please avoid _relaxed accessor unless there's a strong reason, and if so
> > > document it.
> >
> > Uhhh, what!? That's the wrong way around from what I've ever seen
> > anyone say. Have you ever looked at the resulting code on arm32 with
> > OMAP enabled? It's just a memory barrier and an indirect function call
> > on every access.
> >
> > Use readl/writel if you have an ordering requirement WRT DMA,
> > otherwise use relaxed variants.
> >
>
> That does make sense. Unfortunately I don't know where this started, but
> I would guess it might have been a reaction to the fact that people
> where just sprinkling wmb() all over the place to be on the safe side...

I think you could write a book on it. In the beginning, there was x86
and it was strongly ordered...

>
> > > > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PERST_SEPARATION_ENABLE);
> > > > +}
> > > > +
> >
> > [...]
> >
> > > > +static struct platform_driver qcom_pcie_ep_driver = {
> > > > +     .probe  = qcom_pcie_ep_probe,
> > > > +     .driver = {
> > > > +             .name           = "qcom-pcie-ep",
> > >
> > > Skip the indentation of the '='.
> > >
> > > > +             .suppress_bind_attrs = true,
> > >
> > > Why do we suppress_bind_attrs?
> >
> > Because remove is not handled.
> >
>
> Not handled in Mani's driver, or is this a PCI thing?

Only a PCI thing in the sense all the drivers happen to copy-n-paste
it and are mostly built-in. The Android modules thing doesn't seem to
have quite hit PCI yet. On the flipside, I'm sure there's lots of
drivers we can unbind and fun will ensue.

There is some work needed as the remove() implementations that we do
have are all unique (such as do we need a lock or not). I keep nudging
people to look into it.

Rob
