Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57408415282
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 23:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbhIVVQc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 17:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237820AbhIVVQc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 17:16:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02B97611CA;
        Wed, 22 Sep 2021 21:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632345302;
        bh=p2kf8f9SneDcF5cbddfOin1pAOfAoaUXJFS9kC9C3RY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bwUiztR0HsputfFsZxeMu/pQezk4drxXmTvr/3WfsPockfj60nlyScjJ9nWdo5z1I
         Rs+ykRZIXW9MoO/wTLJuREfe7sf/57xjJBXRYUM7GjGF2dS4pXH6hAMkSG/IkTDHt9
         61QGdTTnMkyhP6XAAKkdxKmAInAkQN1LQjiTNZZsQqYIgY9WcHl5UtzE+de1Z8p+dU
         lmYlvXp7oFXZlHU40/jmzV1S+gfW8Oz/AUahWoCsB0g3nVyakT061ujLlZzCRRyKY/
         zrxcIB7fhsQdmSYAG66gt/AeiRp44y0ARk08r5j+3ykpqQoHZojKdPhYNW1RnXZQt2
         FgCQpgZQm4Z5g==
Received: by mail-ed1-f53.google.com with SMTP id eg28so15351880edb.1;
        Wed, 22 Sep 2021 14:15:01 -0700 (PDT)
X-Gm-Message-State: AOAM532hE1AqSrRPwTMmAMKfjpdHH4hagCmjk1I8fMl2o1sk1ej5/9PC
        Xt4SxV3eFJhB84B7tMJngDUjrhPzz50/j5yFQw==
X-Google-Smtp-Source: ABdhPJxrpLWQHpAgZoTQC8bgND1fLrIs/KgZqALZ/fVCHcWTBnba7fvpklnQazlOWx41I7YqFT9oJqTjd14BRcus5GY=
X-Received: by 2002:a17:906:7145:: with SMTP id z5mr1367273ejj.363.1632345300554;
 Wed, 22 Sep 2021 14:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210922205458.358517-1-maz@kernel.org> <20210922205458.358517-5-maz@kernel.org>
 <86507f22-d824-4f7c-ba94-d3105c5206c2@www.fastmail.com>
In-Reply-To: <86507f22-d824-4f7c-ba94-d3105c5206c2@www.fastmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 22 Sep 2021 16:14:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKL2fb+PObe_Soopf2JDFbaQZyu-k_CQrQTGU4tONQvUA@mail.gmail.com>
Message-ID: <CAL_JsqKL2fb+PObe_Soopf2JDFbaQZyu-k_CQrQTGU4tONQvUA@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] PCI: apple: Add initial hardware bring-up
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 22, 2021 at 4:08 PM Sven Peter <sven@svenpeter.dev> wrote:
>
> Hi,
>
>
> On Wed, Sep 22, 2021, at 22:54, Marc Zyngier wrote:
> > From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> >
> [...]
> > +
> > +     /* Use the first reg entry to work out the port index */
> > +     port->idx = idx >> 11;
> > +     port->pcie = pcie;
> > +     port->np = np;
> > +
> > +     port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
> > +     if (IS_ERR(port->base))
> > +             return -ENODEV;

Don't change error codes.

> > +
> > +     rmw_set(PORT_APPCLK_EN, port + PORT_APPCLK);
>
> I think this should be
>
>     rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);

Or just removed if this was tested and worked.

Rob
