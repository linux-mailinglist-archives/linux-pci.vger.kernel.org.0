Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747A7302AFD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 20:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbhAYTAQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 14:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbhAYTAB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 14:00:01 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2837C061756
        for <linux-pci@vger.kernel.org>; Mon, 25 Jan 2021 10:59:20 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i141so14375262yba.0
        for <linux-pci@vger.kernel.org>; Mon, 25 Jan 2021 10:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MycbrezgsQZFT8oqiMufe2gK1ooAaS0SUCHVJFVQ9MQ=;
        b=D89ARNqQBSe6Gl9R5DO/KGq6f+XwI019KcTyn5HUgOjPlzNOoKDGLvzncEHAHxv7re
         lb0QJau2yo6HykmQLwhmFTcTH8Sq6QkyRikthUtPyKV308YBxPqBa17hLZ7vVdG82tdr
         1ZYHEmIoWgXZXzZgGJavOcNzowg9rVJTESsTDHUrdAkVRtjVOXki39cVm64f90B/xnUN
         p++bUV3uNwbHulfuik0Rs79fbFZMM9ifY6BNJzC7/LyidIkjYH3n/Y3WfoT8VtT0C7bQ
         vqglJpySbxKD72RPbiNIaXSY6RlQxd1v9SjROcZsCNjlhR4Ys9ezoFcio6JbYI7EjanP
         cYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MycbrezgsQZFT8oqiMufe2gK1ooAaS0SUCHVJFVQ9MQ=;
        b=RrQ1NVupmWhXyi5tvAgrHb6b75UeEdEID/0gXO7kGx6ulO+d4fFLnNEvV9XEqRnJnl
         quhpjbEiaOQGighFPU2ofZrEPvwjNggMZ1EHfadV88DcZNYvS6sks7L35RFGHov1kWe6
         e7dkvnRrgCw9KivmIDNuPr00PjCtAZ+R3/4yBWm73TROhu9mf4+4mwwuuCVp01/IbDj3
         JksRlJAZYafIbcp6clqZxYMzVdGE/naL8zyCVlAf3TcMzgbJsm8jlBwP3M0rGfHXA06D
         M9bkwth4iL84v3iIh8m7HBZTaBYc8TVoxxe+YsYvRmOD0+woy6qaZ4GJF2fYNDApCgqv
         ycqw==
X-Gm-Message-State: AOAM531tf0De+QbqwHUAJ1UvvU6SQTqZ9nxP8Vpqgceg5/oQ7HkjlKB8
        GsL42P9yHyULp1FTigLsDC3Lj3Y6DLq1cVtt0M5qZg==
X-Google-Smtp-Source: ABdhPJwgOyKDm0nJVp7CDR5p+pD9pfx6JsaeKrbh2AWLDPYbm1qy57jLH9fVrTDF4d9HZfHyOf/YQTtTZFeWAQ46qnY=
X-Received: by 2002:a25:2f46:: with SMTP id v67mr3110432ybv.20.1611601159888;
 Mon, 25 Jan 2021 10:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <20210125165041.GA5979@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210125165041.GA5979@e121166-lin.cambridge.arm.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 25 Jan 2021 10:58:43 -0800
Message-ID: <CAGETcx-P-MxM+49XdUGBmg5YgnHS=fmz8uewywXvLSFKj=MqRQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 8:50 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Jan 20, 2021 at 08:28:36PM +0100, Michael Walle wrote:
> > [RESEND, fat-fingered the buttons of my mail client and converted
> > all CCs to BCCs :(]
> >
> > Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > > > wrote:
> > > > >
> > > > > fw_devlink will defer the probe until all suppliers are ready. We can't
> > > > > use builtin_platform_driver_probe() because it doesn't retry after probe
> > > > > deferral. Convert it to builtin_platform_driver().
> > > >
> > > > If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > > > shouldn't it be fixed or removed?
> > >
> > > I was actually thinking about this too. The problem with fixing
> > > builtin_platform_driver_probe() to behave like
> > > builtin_platform_driver() is that these probe functions could be
> > > marked with __init. But there are also only 20 instances of
> > > builtin_platform_driver_probe() in the kernel:
> > > $ git grep ^builtin_platform_driver_probe | wc -l
> > > 20
> > >
> > > So it might be easier to just fix them to not use
> > > builtin_platform_driver_probe().
> > >
> > > Michael,
> > >
> > > Any chance you'd be willing to help me by converting all these to
> > > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> >
> > If it just moving the probe function to the _driver struct and
> > remove the __init annotations. I could look into that.
>
> Can I drop this patch then ?

No, please pick it up. Michael and I were talking about doing similar
changes for other drivers.

-Saravana
