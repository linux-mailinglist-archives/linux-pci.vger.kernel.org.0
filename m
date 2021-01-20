Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9612FD918
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbhATTGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731714AbhATTDb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 14:03:31 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D650C0613C1
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 11:02:47 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id z1so20470689ybr.4
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 11:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jPdyf7csnEaOrlNIT9kHyquVjGEOb/saDEg+4JUVFI=;
        b=GXWFrxlW7h7Ccmu201AlJ0i3zH1OBGX+7ae3c3xwAWHnytEgwmULkgdT9ivGOV4N3F
         L5Njok/YfcvBy02xWpQNLVptMjt3KQvO8okfsEtEXTMkSMs15F0nYXZmNn9wcec51ji4
         66V/7pr1yu8QvpomFS2ibuYwdDG8sa7Dml2etoWNFBwL8OebfYisV/7V9tFeLjxSfviC
         6I2CXzmWij7eF1JAfdSM6wfZm4/igyKLHyQTmiNBc6X3x7T6A1TolCWg9TKgTZFkIS3/
         2Z6V4pdzyuA4lZ83mPPwb+hNfSssNo0ub+6pk41DMJOuPUc4wUZ8q/9Pv3WnNyEvG6Ef
         2esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jPdyf7csnEaOrlNIT9kHyquVjGEOb/saDEg+4JUVFI=;
        b=pW5r3i2en8unbhMgI9CGciFRblc61d2VQUxCbket4REowJoP1Fw/WzmwlyNDJLeZX7
         LZyqoDBv2r2jw+BxPdgRuDi46mDMH9AGvmjDwU0aaKstGDzx2MhvIp078g10Bhbe0WrV
         IXeFaUOBCtqU9egERjwGngfCJMuztICZPFhkVU13len9TDk1nM595id0RXM/BIYYeLmF
         xjSWLSKa2ZplFJbQsyV/facUdcGUzlXdxRX3FDQ0OU24GaDOxfAN8JlVrA9gkoc2JdQY
         3ZdmQ9PTqr11cI7OyBQQtv4OaZhJlrlSdi1XHz1UoTjqyOUDYTp6zep+w+iN4yuc3yJA
         M9iQ==
X-Gm-Message-State: AOAM5322lFpvJdzhohL3EpoT46flarEnrrTZuxxTE155tErmDp95uK/1
        /kqettyMKjt9zl0ztsPnkRvXVjvx13DCxkx0z9OYOxb8uDLc5w==
X-Google-Smtp-Source: ABdhPJzcly2us+ps4x0SHFbK9AkNe9Kxkb2EVg9MufyFhzozTWNWq2AL/VmZLGwjG1JqDdlEE2kPiCmt4PWNKJ7P4/Y=
X-Received: by 2002:a25:c343:: with SMTP id t64mr15290558ybf.228.1611169365754;
 Wed, 20 Jan 2021 11:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
In-Reply-To: <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 11:02:09 -0800
Message-ID: <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc> wrote:
> >
> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > deferral. Convert it to builtin_platform_driver().
>
> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> shouldn't it be fixed or removed?

I was actually thinking about this too. The problem with fixing
builtin_platform_driver_probe() to behave like
builtin_platform_driver() is that these probe functions could be
marked with __init. But there are also only 20 instances of
builtin_platform_driver_probe() in the kernel:
$ git grep ^builtin_platform_driver_probe | wc -l
20

So it might be easier to just fix them to not use
builtin_platform_driver_probe().

Michael,

Any chance you'd be willing to help me by converting all these to
builtin_platform_driver() and delete builtin_platform_driver_probe()?

-Saravana

> Then we're not fixing drivers later
> when folks start caring about deferred probe and devlink.
>
> I'd really prefer if we convert this to a module instead. (And all the
> other PCI host drivers.)
>
> > Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
>
> This happened!?
>
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> >  drivers/pci/controller/dwc/pci-layerscape.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index 44ad34cdc3bc..5b9c625df7b8 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -232,7 +232,7 @@ static const struct of_device_id ls_pcie_of_match[] = {
> >         { },
> >  };
> >
> > -static int __init ls_pcie_probe(struct platform_device *pdev)
> > +static int ls_pcie_probe(struct platform_device *pdev)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct dw_pcie *pci;
> > @@ -271,10 +271,11 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
> >  }
> >
> >  static struct platform_driver ls_pcie_driver = {
> > +       .probe = ls_pcie_probe,
> >         .driver = {
> >                 .name = "layerscape-pcie",
> >                 .of_match_table = ls_pcie_of_match,
> >                 .suppress_bind_attrs = true,
> >         },
> >  };
> > -builtin_platform_driver_probe(ls_pcie_driver, ls_pcie_probe);
> > +builtin_platform_driver(ls_pcie_driver);
> > --
> > 2.20.1
> >
