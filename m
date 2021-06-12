Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD73A5114
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jun 2021 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFLWFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 12 Jun 2021 18:05:18 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42948 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLWFS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 12 Jun 2021 18:05:18 -0400
Received: by mail-ed1-f46.google.com with SMTP id i13so41391355edb.9;
        Sat, 12 Jun 2021 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEDs96ONr8FmGsjH+zhg8paw9S/VwLylFUAj5qFQW1M=;
        b=kbtIThhn6Eq2Qje5WRWnpASrFaPEFA67EEv9cJxwlGv91wx+pUx0y8AHAeUIMO6l4K
         oMw3YzHzQ4kusadFsvCIuipG5Q0QgqHY+uSCOXxV+5UDjHXE03JmYxGttBTFLQyZeS4D
         BJqkedJlohPXsuZedFQJAHohyT5KO+UoKs4mf+CpoI+ov7OEG9afV3P1CF8SoYqHnrrX
         0oSBfEWjuM7u2qKWVDK+AvPI2/GZyFDK7rTjwzM2oJ1v2w/veskIa+HvpTEOrdle1ELy
         qRaOx818HzONzHcJ9P1uj1F+KNFKfMg6H1kf0uBK/5LX0pIxLKdfk437EdY+y2Zl6bTo
         Mgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEDs96ONr8FmGsjH+zhg8paw9S/VwLylFUAj5qFQW1M=;
        b=bLBKUD5Bp4oS7sJGFnUj5VolrzBWoZ+28i+YNuGMq0Ncit+DmwZ2pADSLGDHb6FabI
         rQWyRdxehlhymKsJQUOCfUmq+dXe333Ke4AUp8LQBoN8aMJ8YIV2lfwycrKka6CSq/eh
         aDQYoOOMp8CNPKrjrMV07wOHvCIbhvDmibOhK3NXpCwM6lJE1zvatq5i56jaBqquD1VS
         1CmLcLXSKq4Wo5rrdqNAaJhX5KYasHKxEugSWP2XrAkKob7mkU7YxCGGr82+Qs01O7g1
         On9uRKDpW8Vl9RGGqizXmNIqyHIiB7S04E1F3WA19f5+XEb7NKdXjOVtmJyN9lUvI4Pw
         XJKw==
X-Gm-Message-State: AOAM531c4dIb43xKEE4Ly6hBHEFIlf/GhWHww3v9aoQCVTTAu6wTEZ2O
        wf4Ij1k3IeLvZcvlU82UE3fhoNTcEXaTL2TyUKA=
X-Google-Smtp-Source: ABdhPJwocf+UkwLvI13sMGMlwzWKxuqsxhrp6exew0/a0z/JV3U5Vu/lylFpX54PhzLJx6f/DRjA7ja7BWxLykoGJrc=
X-Received: by 2002:a05:6402:3082:: with SMTP id de2mr9827627edb.214.1623535337350;
 Sat, 12 Jun 2021 15:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210608080409.1729276-1-javierm@redhat.com>
In-Reply-To: <20210608080409.1729276-1-javierm@redhat.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 12 Jun 2021 23:02:06 +0100
Message-ID: <CALeDE9PAEArn6zTNkWe+eNomx4f1A2sK=jB+7GzE8MRJo=epAw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: rockchip: Avoid accessing PCIe registers with
 clocks gated
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 8, 2021 at 9:04 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> IRQ handlers that are registered for shared interrupts can be called at
> any time after have been registered using the request_irq() function.
>
> It's up to drivers to ensure that's always safe for these to be called.
>
> Both the "pcie-sys" and "pcie-client" interrupts are shared, but since
> their handlers are registered very early in the probe function, an error
> later can lead to these handlers being executed before all the required
> resources have been properly setup.
>
> For example, the rockchip_pcie_read() function used by these IRQ handlers
> expects that some PCIe clocks will already be enabled, otherwise trying
> to access the PCIe registers causes the read to hang and never return.
>
> The CONFIG_DEBUG_SHIRQ option tests if drivers are able to cope with their
> shared interrupt handlers being called, by generating a spurious interrupt
> just before a shared interrupt handler is unregistered.
>
> But this means that if the option is enabled, any error in the probe path
> of this driver could lead to one of the IRQ handlers to be executed.
>
> In a rockpro64 board, the following sequence of events happens:
>
>   1) "pcie-sys" IRQ is requested and its handler registered.
>   2) "pcie-client" IRQ is requested and its handler registered.
>   3) probe later fails due readl_poll_timeout() returning a timeout.
>   4) the "pcie-sys" IRQ is unregistered.
>   5) CONFIG_DEBUG_SHIRQ triggers a spurious interrupt.
>   6) "pcie-client" IRQ handler is called for this spurious interrupt.
>   7) IRQ handler tries to read PCIE_CLIENT_INT_STATUS with clocks gated.
>   8) the machine hangs because rockchip_pcie_read() call never returns.
>
> To avoid cases like this, the handlers don't have to be registered until
> very late in the probe function, once all the resources have been setup.
>
> So let's just move all the IRQ init before the pci_host_probe() call, that
> will prevent issues like this and seems to be the correct thing to do too.
>
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>

Tested on a Rock960, Firefly3399 and a Pinebook Pro

> ---
>
> Changes in v2:
> - Add missing word in the commit message.
> - Include Shawn Lin's Acked-by tag.
>
>  drivers/pci/controller/pcie-rockchip-host.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f1d08a1b159..78d04ac29cd 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -592,10 +592,6 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>         if (err)
>                 return err;
>
> -       err = rockchip_pcie_setup_irq(rockchip);
> -       if (err)
> -               return err;
> -
>         rockchip->vpcie12v = devm_regulator_get_optional(dev, "vpcie12v");
>         if (IS_ERR(rockchip->vpcie12v)) {
>                 if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> @@ -973,8 +969,6 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>         if (err)
>                 goto err_vpcie;
>
> -       rockchip_pcie_enable_interrupts(rockchip);
> -
>         err = rockchip_pcie_init_irq_domain(rockchip);
>         if (err < 0)
>                 goto err_deinit_port;
> @@ -992,6 +986,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>         bridge->sysdata = rockchip;
>         bridge->ops = &rockchip_pcie_ops;
>
> +       err = rockchip_pcie_setup_irq(rockchip);
> +       if (err)
> +               goto err_remove_irq_domain;
> +
> +       rockchip_pcie_enable_interrupts(rockchip);
> +
>         err = pci_host_probe(bridge);
>         if (err < 0)
>                 goto err_remove_irq_domain;
> --
> 2.31.1
>
