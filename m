Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A641409F1B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 23:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhIMVbk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 17:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhIMVbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 17:31:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01E18610FB;
        Mon, 13 Sep 2021 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631568621;
        bh=kDnxC/ku/qO2YWO25lHgWh/UEfoJ7cygr+a1l7tUC3M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VG7wvsOWUJeXM+FMs0FH3+zOqmH2owxzqpPcu3YDANFOnCP0VbRPqEIP7hbPmgxR2
         gXA88kVtMvEDQp2Wq3i53HT5FPfYY0sQxDMbbLweb/XOQOdW7pON2ZaSKLyoOWRwe3
         2NcGOGQaiTH6ttTuSViiC0aRsCsprYdlNXjV4mF22b8xslz9/7njo0TnbHF3GrN5f3
         Z5ftw0XCnBbCOEuQejvNVTreFcRoNgu7TY+xy+Cm550RFXxezpoUo4uwy8jOl+umX8
         B3wLfVX/6tDhfGgNYy0i/9QrUg+GwvUpyu1cjXivP3o1TyWIt94PKB4YWJkDFm58C3
         yaXWj4r5QVavQ==
Received: by mail-ej1-f44.google.com with SMTP id t19so24005287ejr.8;
        Mon, 13 Sep 2021 14:30:20 -0700 (PDT)
X-Gm-Message-State: AOAM533mzDRtI93FSs6flVEIws9fhBU3AP9bGrx7k2Pf0W47anuGHX88
        HB3px84FUdTeqjs4q0lhjzi9FpbQDhGcaMtJAw==
X-Google-Smtp-Source: ABdhPJwdYd6a5ti400oMtW47AX0MdBsmzprmsa0Cq36bJ4SwNp/qbAWDuiT9TlqObJ7jFtSCUgGwBouL6RRe3fuMhM8=
X-Received: by 2002:a17:907:33ce:: with SMTP id zk14mr1304192ejb.84.1631568619636;
 Mon, 13 Sep 2021 14:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210913182550.264165-1-maz@kernel.org> <20210913182550.264165-4-maz@kernel.org>
In-Reply-To: <20210913182550.264165-4-maz@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 13 Sep 2021 16:30:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtypMS8xquP_QjZcgQSOjWjOT82H9KNkE-gyqMJSgEUA@mail.gmail.com>
Message-ID: <CAL_JsqLtypMS8xquP_QjZcgQSOjWjOT82H9KNkE-gyqMJSgEUA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] PCI: of: Allow matching of an interrupt-map
 local to a pci device
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
> Just as we now allow an interrupt map to be parsed when part
> of an interrupt controller, there is no reason to ignore an
> interrupt map that would be part of a pci device node such as
> a root port since we already allow interrupt specifiers.
>
> This allows the device itself to use the interrupt map for
> for its own purpose.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/of.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index d84381ce82b5..443cebb0622e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -423,7 +423,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>   */
>  static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *out_irq)
>  {
> -       struct device_node *dn, *ppnode;
> +       struct device_node *dn, *ppnode = NULL;
>         struct pci_dev *ppdev;
>         __be32 laddr[3];
>         u8 pin;
> @@ -452,8 +452,14 @@ static int of_irq_parse_pci(const struct pci_dev *pdev, struct of_phandle_args *
>         if (pin == 0)
>                 return -ENODEV;
>
> +       /* Local interrupt-map in the device node? Use it! */
> +       if (dn && of_get_property(dn, "interrupt-map", NULL)) {

No need to check 'dn' is not NULL.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +               pin = pci_swizzle_interrupt_pin(pdev, pin);
> +               ppnode = dn;
> +       }
> +
>         /* Now we walk up the PCI tree */
> -       for (;;) {
> +       while (!ppnode) {
>                 /* Get the pci_dev of our parent */
>                 ppdev = pdev->bus->self;
>
> --
> 2.30.2
>
