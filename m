Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B2409EEB
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 23:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243648AbhIMVOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 17:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242414AbhIMVOz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 17:14:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F77F61106;
        Mon, 13 Sep 2021 21:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631567619;
        bh=6bBOSpmFHVH8Qs5P5gI5GuYG8hzXlKUcmyfIz3ggF4M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cQTLUA+kYUvv9TQe+NNR/OOuVCFwTEaAwdXuY6aHKIsxLZEjtAmWrO/wdanYs7TXq
         nlY9tjv01obSerK+moN8oELVwwhz3AUnkgdK7TsHqesHWrKMtlQKCww8bjNeWDrQ6I
         IzX7J5d2sqGrrT/fHRMCdKWzg4RXj5M0TOfBktNzRP2CDvJniZUgwz4Rn7dVxW7UVT
         eM7qRcqg78u5Dnf5D2iu1zFuP+/jFsmBo22jD15I10E3wUluR8efhL2iYiZyZKCxE8
         bZG+0SlZwNo2QFfqV2Ga6CtR6JJc992YefucB8I2c/QmjNIqCvxzjVxEZGF+74V0IN
         OT/c04qQYnhIw==
Received: by mail-ed1-f41.google.com with SMTP id g21so16417897edw.4;
        Mon, 13 Sep 2021 14:13:39 -0700 (PDT)
X-Gm-Message-State: AOAM530iMoq6p8YS19eizFVteQ+G8P8Vjcqvbm8EiCNIHbK2LHvHbDF0
        NLsDf2WsW4Ufi6JnOGJTZvdaLlqyty3eRvRN5A==
X-Google-Smtp-Source: ABdhPJxExeUYnleL/+IK4R/5Pn8HabNWrlLTO7fUPwuPP9b8R3AcBQdO/+rIVlFnLtyg4UBqHHrY9cYhA6v3htBeiHQ=
X-Received: by 2002:aa7:ca45:: with SMTP id j5mr4084233edt.6.1631567617603;
 Mon, 13 Sep 2021 14:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210913182550.264165-1-maz@kernel.org> <20210913182550.264165-3-maz@kernel.org>
In-Reply-To: <20210913182550.264165-3-maz@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Sep 2021 16:13:26 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+OuYfuNM4pNL7aZ4tTHGTXzYcH1W-8xi=eEe2zOoq6nw@mail.gmail.com>
Message-ID: <CAL_Jsq+OuYfuNM4pNL7aZ4tTHGTXzYcH1W-8xi=eEe2zOoq6nw@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] of/irq: Allow matching of an interrupt-map local
 to an interrupt controller
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 13, 2021 at 1:26 PM Marc Zyngier <maz@kernel.org> wrote:
>
> of_irq_parse_raw() has a baked assumption that if a node has an
> interrupt-controller property, it cannot possibly also have an
> interrupt-map property (the latter being ignored).
>
> This seems to be an odd behaviour, and there are no reason why

s/are/is/

> we should avoid supporting this use case. This is specially
> useful when a PCI root port acts as an interrupt controller for
> PCI endpoints, such as this:
>
> pcie0: pcie@690000000 {
>         [...]
>         port00: pci@0,0 {
>                 device_type = "pci";
>                 [...]
>                 #address-cells = <3>;
>
>                 interrupt-controller;
>                 #interrupt-cells = <1>;
>
>                 interrupt-map-mask = <0 0 0 7>;
>                 interrupt-map = <0 0 0 1 &port00 0 0 0 0>,
>                                 <0 0 0 2 &port00 0 0 0 1>,
>                                 <0 0 0 3 &port00 0 0 0 2>,
>                                 <0 0 0 4 &port00 0 0 0 3>;
>         };
> };
>
> Handle it by detecting that we have an interrupt-map early in the
> parsing, and special case the situation where the phandle in the
> interrupt map refers to the current node (which is the interesting
> case here).
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/of/irq.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
