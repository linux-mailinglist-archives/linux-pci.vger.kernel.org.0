Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294722FDA05
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392762AbhATTs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392779AbhATTst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 14:48:49 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272EDC061757
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 11:48:09 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id r32so10867526ybd.5
        for <linux-pci@vger.kernel.org>; Wed, 20 Jan 2021 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+VKdic9vQLplZ5dRDPFBsqTAKEx7zvAEih/IIGE3o4=;
        b=gqXXWU/DUfCRlZqg6VB4WrIPdIGgIy2FpoB64Tw6CtQ1jL1wrLFZqp3MrEbrMBYGiZ
         N4/i+WbY5NkRoGQ0TOQ8gSx1H/xButR/QyThA+B2Gz/O5XBV3DuftVSBSZBLeyg1OLU+
         UOnY3ZnpvA9fS2hSivgKSdxrfkTqrNLOncrFUlwoHemuKABuY67DntKltT3SJx0D9dWo
         /9pBl19rfoJS1N1WX6MM6xVcEDMYzyaqXAJ7Q6wXNhN/hh/u8nnQojbYlYlOdnqtABHz
         lhAfatORzVUNAHTBDkjRB1KD+A8zB99tvQ/Y4CW0lF2FN6Oz8vdPn1HEE/kgKprBbKFe
         sZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+VKdic9vQLplZ5dRDPFBsqTAKEx7zvAEih/IIGE3o4=;
        b=BH4mKPTTo59am32SX0m/Bcgib2m8oi4iMIry0Wo3tNb1oToAR+ASS44XwUhlYgBuGi
         GmdYTiv2CVT+rqOztLgzLI6+ptp50HrDORDohhFGc4urb8RW88YmLjXTWDnh2aTrphRL
         Hwg6VBWzvTT+hW0dwC2e1pkR62wxEji8hvnVrzpWkwb/FWGx0G6LS/xT0pEwYK9/qbp+
         Cdwk24pqxNkOc7QIUKL0RJzyXb7HErsuoksJ1ROo1GoipCS5OTPZ0wb5TZP9xDbngUSF
         hRaierbnz6pd+p23QC+lLjjh/wkDSyOouTqMXv4YSYMrfl/bSoiUZ6t78p++RKOqm+eA
         xW9Q==
X-Gm-Message-State: AOAM5300+j/FWu+RxrcUvNttOwa0D+MqWPE6HbG5a1WzwHPSIA7WQi90
        hv2nwFzG+8+KTB1003x2WZMqN7xqrZUBhoOWhThTxw==
X-Google-Smtp-Source: ABdhPJy6lnzImOgxZ62zFBVY/BNYqrbN/QRRos+AWvRoeObCVMQxkr4MeX9zWJIX5eWD7W+mqvC8d3XxTrbOt6hpwoA=
X-Received: by 2002:a25:77d4:: with SMTP id s203mr17677961ybc.32.1611172088185;
 Wed, 20 Jan 2021 11:48:08 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com> <c3e35b90e173b15870a859fd7001a712@walle.cc>
In-Reply-To: <c3e35b90e173b15870a859fd7001a712@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 20 Jan 2021 11:47:31 -0800
Message-ID: <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc> wrote:
>
> [RESEND, fat-fingered the buttons of my mail client and converted
> all CCs to BCCs :(]
>
> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> >>
> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> >> wrote:
> >> >
> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> >> > deferral. Convert it to builtin_platform_driver().
> >>
> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> >> shouldn't it be fixed or removed?
> >
> > I was actually thinking about this too. The problem with fixing
> > builtin_platform_driver_probe() to behave like
> > builtin_platform_driver() is that these probe functions could be
> > marked with __init. But there are also only 20 instances of
> > builtin_platform_driver_probe() in the kernel:
> > $ git grep ^builtin_platform_driver_probe | wc -l
> > 20
> >
> > So it might be easier to just fix them to not use
> > builtin_platform_driver_probe().
> >
> > Michael,
> >
> > Any chance you'd be willing to help me by converting all these to
> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
>
> If it just moving the probe function to the _driver struct and
> remove the __init annotations. I could look into that.

Yup. That's pretty much it AFAICT.

builtin_platform_driver_probe() also makes sure the driver doesn't ask
for async probe, etc. But I doubt anyone is actually setting async
flags and still using builtin_platform_driver_probe().

-Saravana
