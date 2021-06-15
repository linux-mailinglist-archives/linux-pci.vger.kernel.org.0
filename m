Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A23A8C1D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 00:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhFOXAe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 19:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOXAe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 19:00:34 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7189C061574
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 15:58:28 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id k21-20020a4a2a150000b029024955603642so194556oof.8
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qlTKAUDpgW/aVWFcl6ZYQV6zmV889oxnPc1k40CzH84=;
        b=Y6j48dWS8Zjp45eyuaVvc0GXsT4HSvTzjnwjt2i2u6VxfEW89ci8iej3A0gCIHnJWT
         FCsZOhR/ES6yKJf5EMZJsf2KTVi4Iq+nXutr8yjIvmB6WcfmM6ySC5eVLBvvSVVuGsXo
         ttNdErqUXVU5XjNR5m/d7Qx0y23KmQ0sup2dOe1pDcSMoOUVLdJMCHXoH38wl7QHiP8q
         aD8ntmJVizuLBlzapNXiuv6WNamAClcJSop5/H5p6vL4YtOFuO+CrVAl627kglXjUT7d
         o6q+sw/pG1gF78eT2INat9qTwBIU4GXNDMbykJOOOf1a0/yDzsbCzYZGNQMyaRZrYJcs
         QbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qlTKAUDpgW/aVWFcl6ZYQV6zmV889oxnPc1k40CzH84=;
        b=oQwMIwN9SBBjsC7KLFcB9oihJzEKb9ojTN2myGfnsC2pvsBetNE2vYLSwzZqzfSzoB
         B4+6/jENC/MBv6IMz6VOzzXyGK00z0lZf5HZgwHj9JuAaBGJx4YbzvyI0urz+pChMC3E
         wMM8HtUIPR0URQutcQ1CkuroDKubzRfKCrBjVF6Uv30x5DCCyGLxzdJEexqkVdlELBCv
         oyeeo+tzNZh5C8utejU13swHK91lcmAoqzy9i0gDWQVww9ZOHjmoxVTOUdOMApzTk0+7
         Gb5lYxYSPUYwDJnib8Mu3fbX5f+br1V5oPiQUWnuSwV5Z8E58E7/mJgRTY23E/EpwMg0
         pOjw==
X-Gm-Message-State: AOAM5304xIOv+BBo+XXba++e5WYtn+8EG45ICzpqyxfuw8rh7qrRdBTR
        2dE0LVIfLAkJhKhOYniniNoU1Q==
X-Google-Smtp-Source: ABdhPJzsASLVvopE8vOr0VonM+OooP+sHNYzO7esb5ydXavQ1wdSoOLNsUUfn4SN2ly84/e86IuQBw==
X-Received: by 2002:a4a:b1c2:: with SMTP id j2mr1249731ooo.78.1623797908009;
        Tue, 15 Jun 2021 15:58:28 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id f63sm95341otb.36.2021.06.15.15.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 15:58:27 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:58:25 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 2/3] PCI: dwc: Add Qualcomm PCIe Endpoint controller
 driver
Message-ID: <YMkwkTBa7y1jEeG5@yoga>
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
 <20210603103814.95177-3-manivannan.sadhasivam@linaro.org>
 <YLw744UeM6fj/xoS@builder.lan>
 <CAL_Jsq++bSPiKcgWUr6AJbJfidPNpUSFCtarRGEV4GP7fb8yPw@mail.gmail.com>
 <YMkiSDxOhD7jun3x@builder.lan>
 <CAL_Jsq+jbOkQ0png89XsJEg7HNmkefPFOG1fypmsH=tvs=B_3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+jbOkQ0png89XsJEg7HNmkefPFOG1fypmsH=tvs=B_3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 15 Jun 17:20 CDT 2021, Rob Herring wrote:

>  On Tue, Jun 15, 2021 at 3:57 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Tue 15 Jun 16:40 CDT 2021, Rob Herring wrote:
> >
> > > On Sat, Jun 5, 2021 at 9:07 PM Bjorn Andersson
> > > <bjorn.andersson@linaro.org> wrote:
> > > >
> > > > On Thu 03 Jun 05:38 CDT 2021, Manivannan Sadhasivam wrote:
> > > >
> > > > > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > > > > the Designware core with added Qualcomm specific wrapper around the
> > > > > core. The driver support is very basic such that it supports only
> > > > > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > > > > for now but these will be added later.
> > > > >
> > > > > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > > > > operation and written on top of the DWC PCI framework.
> > > > >
> > > > > Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > > > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > > > [mani: restructured the driver and fixed several bugs for upstream]
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >
> > > > Really nice to see this working!
> > >
> > > [...]
> > >
> > > > > +static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
> > > > > +{
> > > > > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PCIE_PERST_EN);
> > > >
> > > > Please avoid _relaxed accessor unless there's a strong reason, and if so
> > > > document it.
> > >
> > > Uhhh, what!? That's the wrong way around from what I've ever seen
> > > anyone say. Have you ever looked at the resulting code on arm32 with
> > > OMAP enabled? It's just a memory barrier and an indirect function call
> > > on every access.
> > >
> > > Use readl/writel if you have an ordering requirement WRT DMA,
> > > otherwise use relaxed variants.
> > >
> >
> > That does make sense. Unfortunately I don't know where this started, but
> > I would guess it might have been a reaction to the fact that people
> > where just sprinkling wmb() all over the place to be on the safe side...
> 
> I think you could write a book on it. In the beginning, there was x86
> and it was strongly ordered...
> 

I guess it would allow me to ask people to RTFM (RTFB) instead then :)

Jokes aside, I think we came to the conclusion that writel() was better
than incorrect use of writel_relaxed() followed by wmb(). And in this
particular case it's definitely not happening in a hot code path...

> >
> > > > > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PERST_SEPARATION_ENABLE);
> > > > > +}
> > > > > +
> > >
> > > [...]
> > >
> > > > > +static struct platform_driver qcom_pcie_ep_driver = {
> > > > > +     .probe  = qcom_pcie_ep_probe,
> > > > > +     .driver = {
> > > > > +             .name           = "qcom-pcie-ep",
> > > >
> > > > Skip the indentation of the '='.
> > > >
> > > > > +             .suppress_bind_attrs = true,
> > > >
> > > > Why do we suppress_bind_attrs?
> > >
> > > Because remove is not handled.
> > >
> >
> > Not handled in Mani's driver, or is this a PCI thing?
> 
> Only a PCI thing in the sense all the drivers happen to copy-n-paste
> it and are mostly built-in. The Android modules thing doesn't seem to
> have quite hit PCI yet. On the flipside, I'm sure there's lots of
> drivers we can unbind and fun will ensue.
> 
> There is some work needed as the remove() implementations that we do
> have are all unique (such as do we need a lock or not). I keep nudging
> people to look into it.
> 

Thanks, that confirms that my expectation. I would prefer to see this
tackled in a separate step then :)

Regards,
Bjorn
