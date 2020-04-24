Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2DA1B7D3A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgDXRrj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 13:47:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgDXRrj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 13:47:39 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82FDA20781;
        Fri, 24 Apr 2020 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587750458;
        bh=zIFV/KlcUwJeD/xf7nacfJWLfnf6jNQCQvPPdzxxsGM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UMOT3Ojapa1dBHxAktqyUitNXqvf4pMLzuGtSJiSN6v074xjidUnl+RoJpSR1jB7j
         30FRuTDX58zsQrXxCVA/CM51a2Dn8MTVngDUVwYH+7aufNr5KsleVf+OnsaSt+rXA2
         a4u34bK0Zs/RxHQshxL8dpxa6EI6uvohAGirVYtg=
Received: by mail-qt1-f174.google.com with SMTP id x12so8080813qts.9;
        Fri, 24 Apr 2020 10:47:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuYi8vqPCml4Sf1YvcFFTFmOu0RxjIKBnhnzympEAPGzFo2K2Gaq
        J2D/neePDZ+rQMoJFIPnkqkLowAySbkB2eBAcQ==
X-Google-Smtp-Source: APiQypKxRSyCnlYfhvX/bo/LFS6GoXJnWAMceyI9nEXpPmbsqGYUxw6bD4/7gyBUsMVwHnEnu+10GIJcorDTq1dtFi4=
X-Received: by 2002:aed:3ac8:: with SMTP id o66mr10738923qte.110.1587750457652;
 Fri, 24 Apr 2020 10:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com> <20200424130847.328584-2-jiaxun.yang@flygoat.com>
In-Reply-To: <20200424130847.328584-2-jiaxun.yang@flygoat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 24 Apr 2020 12:47:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKsZrsnn92XHL4QdFkAgFKqVTBZXDz9wVv-_7oywOOsBQ@mail.gmail.com>
Message-ID: <CAL_JsqKsZrsnn92XHL4QdFkAgFKqVTBZXDz9wVv-_7oywOOsBQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] PCI: OF: Don't remap iospace on unsupported platform
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 8:09 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> There are some platforms that don't support I/O space remapping
> like MIPS. However, our PCI code will try to remap iospace
> unconditionally and reject io resources on these platforms.
>
> So we should remove I/O space remapping check and use a range
> check instead on these platforms.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> --
> v4: Fix a typo in commit message.
> v5: Commit message massage
> ---
>  drivers/pci/of.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 81ceeaa6f1d5..36e8761b66c6 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -547,12 +547,21 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
>
>                 switch (resource_type(res)) {
>                 case IORESOURCE_IO:
> +#if defined(PCI_IOBASE) && defined(CONFIG_MMU)

We already have the same condition in pci_remap_iospace(). All this
does is suppress a WARN. If a WARN is not desired, then change it.
Perhaps just a single line rather than backtrace would be okay.
Whether to WARN or not shouldn't be a decision for firmware code.

Though really, if I/O space can never be supported, then it's an error
in your DT to describe it.

>                         err = devm_pci_remap_iospace(dev, res, iobase);
>                         if (err) {
>                                 dev_warn(dev, "error %d: failed to map resource %pR\n",
>                                          err, res);
>                                 resource_list_destroy_entry(win);
>                         }
> +#else
> +                       /* Simply check if IO is inside the range */

Why do you care if it's never used?

> +                       if (res->end > IO_SPACE_LIMIT) {
> +                               dev_warn(dev, "resource %pR out of the I/O range\n",
> +                                       res);
> +                               resource_list_destroy_entry(win);
> +                       }
> +#endif
>                         break;
>                 case IORESOURCE_MEM:
>                         res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> --
> 2.26.0.rc2
>
