Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F341C3A8B7A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFOV7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 17:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOV7g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 17:59:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8994DC061760
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 14:57:31 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id a26so153965oie.11
        for <linux-pci@vger.kernel.org>; Tue, 15 Jun 2021 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bx8ExFxKkc1Wbpcf/4af9vTqek0n9FUoJHztqzn3TaE=;
        b=gA7rugrr78UH+5KSUJD4e2H9ne0qWTc1fs8mpUQeJyD9O9nSSds20fWlfpDClFtBaG
         1F0qySy4arVUu3ewnRUWE/ZkXZIvLvLsLmB+67+btgie6KTHHxKiHelmfWgbzN/Tftxk
         p8fEPpYDr46WvcLOJ4cg1MEs/756it1Isc1u2Zh4wJnDz9XgsqlD07ct6+IVfPFYsoFo
         l4FVGU7Uim0f+wI60d4J+JWhWurMfJHBbaNXq4OIqLx3FBu9EqHTrRmLb7TMLLNoKIln
         /D/V6ts8FjTHgYTBOVZBwzsTgpl23iFHAVKgvFUfkTdPvsRqxusaO5w+og8HLtSDnY0Y
         yJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bx8ExFxKkc1Wbpcf/4af9vTqek0n9FUoJHztqzn3TaE=;
        b=VJ8AwduWIGd7s8gHLgHi0EXiBCekZpHJ0yvmx+7QHXWQMgipq5UHSxfCgR1buAXKzI
         UJeEyt/7Te4WTmntv9MkYxzNUm8OlYi3C7ZGqdhH91V2czGIBq798lj9K0O97tufdkBt
         ey4IzBwduNO+6WDl+rgy9ELzP20EP8iBfeVkgWVnpRmzUOHtosMeOBV1eGh+yyVLRSou
         sH93dv7VJV/OywNjr7PRIvy6cjd4u1FdUlnHj5a2UxO4ksATD2Bwlt+PPx+XFziZC3IH
         pNyg8LoCqapt4fp6e3SdooBvXWLUwrr0JQdGqEg1KukLM11dSY/r937G7KcCUD2z0SfA
         Y/NA==
X-Gm-Message-State: AOAM531TZfvLYe9mXgZ+p039NLFF/MWyqBIAYcSMTItFs2kTGl8eGmPv
        0f4x+zUzlODhau5GzdvJNsAW0g==
X-Google-Smtp-Source: ABdhPJxGXy+G7pzzyEg+jUXaTjixDiSmKxNPn8In3YdycIcAgjIPhirk4d6JRx9HQsjwZQjY6mdKog==
X-Received: by 2002:a05:6808:692:: with SMTP id k18mr4625645oig.148.1623794250870;
        Tue, 15 Jun 2021 14:57:30 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i15sm63109ots.39.2021.06.15.14.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:57:30 -0700 (PDT)
Date:   Tue, 15 Jun 2021 16:57:28 -0500
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
Message-ID: <YMkiSDxOhD7jun3x@builder.lan>
References: <20210603103814.95177-1-manivannan.sadhasivam@linaro.org>
 <20210603103814.95177-3-manivannan.sadhasivam@linaro.org>
 <YLw744UeM6fj/xoS@builder.lan>
 <CAL_Jsq++bSPiKcgWUr6AJbJfidPNpUSFCtarRGEV4GP7fb8yPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq++bSPiKcgWUr6AJbJfidPNpUSFCtarRGEV4GP7fb8yPw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 15 Jun 16:40 CDT 2021, Rob Herring wrote:

> On Sat, Jun 5, 2021 at 9:07 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > On Thu 03 Jun 05:38 CDT 2021, Manivannan Sadhasivam wrote:
> >
> > > Add driver support for Qualcomm PCIe Endpoint controller driver based on
> > > the Designware core with added Qualcomm specific wrapper around the
> > > core. The driver support is very basic such that it supports only
> > > enumeration, PCIe read/write, and MSI. There is no ASPM and PM support
> > > for now but these will be added later.
> > >
> > > The driver is capable of using the PERST# and WAKE# side-band GPIOs for
> > > operation and written on top of the DWC PCI framework.
> > >
> > > Co-developed-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > > [mani: restructured the driver and fixed several bugs for upstream]
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Really nice to see this working!
> 
> [...]
> 
> > > +static void qcom_pcie_ep_configure_tcsr(struct qcom_pcie_ep *pcie_ep)
> > > +{
> > > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PCIE_PERST_EN);
> >
> > Please avoid _relaxed accessor unless there's a strong reason, and if so
> > document it.
> 
> Uhhh, what!? That's the wrong way around from what I've ever seen
> anyone say. Have you ever looked at the resulting code on arm32 with
> OMAP enabled? It's just a memory barrier and an indirect function call
> on every access.
> 
> Use readl/writel if you have an ordering requirement WRT DMA,
> otherwise use relaxed variants.
> 

That does make sense. Unfortunately I don't know where this started, but
I would guess it might have been a reaction to the fact that people
where just sprinkling wmb() all over the place to be on the safe side...

> > > +     writel_relaxed(0x0, pcie_ep->tcsr + TCSR_PERST_SEPARATION_ENABLE);
> > > +}
> > > +
> 
> [...]
> 
> > > +static struct platform_driver qcom_pcie_ep_driver = {
> > > +     .probe  = qcom_pcie_ep_probe,
> > > +     .driver = {
> > > +             .name           = "qcom-pcie-ep",
> >
> > Skip the indentation of the '='.
> >
> > > +             .suppress_bind_attrs = true,
> >
> > Why do we suppress_bind_attrs?
> 
> Because remove is not handled.
> 

Not handled in Mani's driver, or is this a PCI thing?

Regards,
Bjorn
