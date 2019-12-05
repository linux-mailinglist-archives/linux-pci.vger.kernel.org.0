Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B66B114657
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 18:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfLER4O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 12:56:14 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39483 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfLER4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2019 12:56:14 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so1612383qvk.6;
        Thu, 05 Dec 2019 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uBdc6tAdaDbdHfwIgPMwkMeOlhCvhzqvHxjkUnPKKyc=;
        b=P8s90vb58VmKhLYpki6zTr+33BWbPiCP+lB303nru6CX5sd5JurxgkyzGkwXIrECVv
         18KHZASPN0B1R22YsTE4pKB3VlqFDVUBpLyphe3c6t478HNAzYxUVk35aqVneHwbYUdZ
         ZGPdtmSDiewN/w7fKwkVv6K1N1t7boYmhG1a9zPu045gs8U+9cHCclpimX92uG7/Hhyb
         OCzTLoQhDr59Ju1lPAnbnX0uyht2DiwZE5VK6epFCoVQH0xMGqVOxYhgrvncVTU3itOy
         0NEBOgP7arVX/1DaUxPOz326J2ych72bsv10nsOQ/PMEJD2FuyJyf1x5h4veZvzyw4Zi
         8xrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uBdc6tAdaDbdHfwIgPMwkMeOlhCvhzqvHxjkUnPKKyc=;
        b=Lr56DzOPXsc+WimHYppmzcAcpocq7u194Z8XIh5k7YKf3z4TsYi0wV/Kgm3guUbh5K
         lPodKzwgDGxlc/91hG9u2dSC34MbB497gy6JpqmOUiq7GLAbdA2hN3sriA81Cf7SPQk0
         8glg4kra36sSTq/bdGP65hT5XZY2DpF/RKSYbOvHG48QqzOONs0fzDR2FMek69q2w+jg
         YT/lhN3VgZEm7xuMEkNF2LGXlUJzsqfTEpNfyADcl3LMm41j4EPLqN8u+9NRmxzUyRxw
         p94KQ50n6t2vxWMzUuaak0WpJFtuon6m6WizV0MQSQXuicfYTgH78gGtfQEKIbmh/8PT
         D4uQ==
X-Gm-Message-State: APjAAAWUzq1a+SCuSm12O8nffCLG6VK6gu2Bd4UCuQ2dB34wFxeSNo4S
        0kzHcY7egU7sa+PxdDLXtjFYzdLuC0DzBXHLbtA=
X-Google-Smtp-Source: APXvYqxsfjMbJimky0Slu9Gm3PSpPimUV4lVFsuPZgK0g7ak4i7DrFu1uUqJtDVrwoypiJmR+0thY9zswvWPt9f96zk=
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr8781528qvm.237.1575568572639;
 Thu, 05 Dec 2019 09:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20191028163256.8004-1-robh@kernel.org> <20191028163256.8004-11-robh@kernel.org>
In-Reply-To: <20191028163256.8004-11-robh@kernel.org>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 5 Dec 2019 18:56:01 +0100
Message-ID: <CAFqH_51-BMWSGGBpoKxA3UK+yPHSpPgok5i=daSC0KS5oc5ueA@mail.gmail.com>
Subject: Re: [PATCH v3 10/25] PCI: rockchip: Use pci_parse_request_of_pci_ranges()
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Will Deacon <will@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Christoph Hellwig <hch@infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Simon Horman <horms@verge.net.au>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        Jingoo Han <jingoohan1@gmail.com>, rfi@lists.rocketboards.org,
        linux-renesas-soc@vger.kernel.org,
        Tom Joseph <tjoseph@cadence.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Missatge de Rob Herring <robh@kernel.org> del dia dl., 28 d=E2=80=99oct. 20=
19
a les 17:38:
>
> Convert the Rockchip host bridge to use the common
> pci_parse_request_of_pci_ranges().
>
> There's no need to assign the resources to a temporary list first. Just
> use bridge->windows directly and remove all the temporary list handling.
>
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

I just tested mainline on my Samsung Chromebook Plus, and since
yesterday I'm getting a "synchronous external abort" [1]. After a
bisection, I found that this patch triggers the issue (this patch was
merged yesterday)

I didn't look in detail yet, but if you have any idea of what could be
the problem, that would be great.

Thanks,
 Enric

[1] https://hastebin.com/adasegihiw.rb

>  drivers/pci/controller/pcie-rockchip-host.c | 36 ++++-----------------
>  1 file changed, 7 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index ef8e677ce9d1..8d2e6f2e141e 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -950,14 +950,10 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
>         struct device *dev =3D &pdev->dev;
>         struct pci_bus *bus, *child;
>         struct pci_host_bridge *bridge;
> +       struct resource *bus_res;
>         struct resource_entry *win;
> -       resource_size_t io_base;
> -       struct resource *mem;
> -       struct resource *io;
>         int err;
>
> -       LIST_HEAD(res);
> -
>         if (!dev->of_node)
>                 return -ENODEV;
>
> @@ -995,29 +991,20 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
>         if (err < 0)
>                 goto err_deinit_port;
>
> -       err =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
> -                                                   &res, &io_base);
> +       err =3D pci_parse_request_of_pci_ranges(dev, &bridge->windows, &b=
us_res);
>         if (err)
>                 goto err_remove_irq_domain;
>
> -       err =3D devm_request_pci_bus_resources(dev, &res);
> -       if (err)
> -               goto err_free_res;
> +       rockchip->root_bus_nr =3D bus_res->start;
>
>         /* Get the I/O and memory ranges from DT */
> -       resource_list_for_each_entry(win, &res) {
> +       resource_list_for_each_entry(win, &bridge->windows) {
>                 switch (resource_type(win->res)) {
>                 case IORESOURCE_IO:
>                         io =3D win->res;
>                         io->name =3D "I/O";
>                         rockchip->io_size =3D resource_size(io);
>                         rockchip->io_bus_addr =3D io->start - win->offset=
;
> -                       err =3D pci_remap_iospace(io, io_base);
> -                       if (err) {
> -                               dev_warn(dev, "error %d: failed to map re=
source %pR\n",
> -                                        err, io);
> -                               continue;
> -                       }
>                         rockchip->io =3D io;
>                         break;
>                 case IORESOURCE_MEM:
> @@ -1026,9 +1013,6 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
>                         rockchip->mem_size =3D resource_size(mem);
>                         rockchip->mem_bus_addr =3D mem->start - win->offs=
et;
>                         break;
> -               case IORESOURCE_BUS:
> -                       rockchip->root_bus_nr =3D win->res->start;
> -                       break;
>                 default:
>                         continue;
>                 }
> @@ -1036,15 +1020,14 @@ static int rockchip_pcie_probe(struct platform_de=
vice *pdev)
>
>         err =3D rockchip_pcie_cfg_atu(rockchip);
>         if (err)
> -               goto err_unmap_iospace;
> +               goto err_remove_irq_domain;
>
>         rockchip->msg_region =3D devm_ioremap(dev, rockchip->msg_bus_addr=
, SZ_1M);
>         if (!rockchip->msg_region) {
>                 err =3D -ENOMEM;
> -               goto err_unmap_iospace;
> +               goto err_remove_irq_domain;
>         }
>
> -       list_splice_init(&res, &bridge->windows);
>         bridge->dev.parent =3D dev;
>         bridge->sysdata =3D rockchip;
>         bridge->busnr =3D 0;
> @@ -1054,7 +1037,7 @@ static int rockchip_pcie_probe(struct platform_devi=
ce *pdev)
>
>         err =3D pci_scan_root_bus_bridge(bridge);
>         if (err < 0)
> -               goto err_unmap_iospace;
> +               goto err_remove_irq_domain;
>
>         bus =3D bridge->bus;
>
> @@ -1068,10 +1051,6 @@ static int rockchip_pcie_probe(struct platform_dev=
ice *pdev)
>         pci_bus_add_devices(bus);
>         return 0;
>
> -err_unmap_iospace:
> -       pci_unmap_iospace(rockchip->io);
> -err_free_res:
> -       pci_free_resource_list(&res);
>  err_remove_irq_domain:
>         irq_domain_remove(rockchip->irq_domain);
>  err_deinit_port:
> @@ -1097,7 +1076,6 @@ static int rockchip_pcie_remove(struct platform_dev=
ice *pdev)
>
>         pci_stop_root_bus(rockchip->root_bus);
>         pci_remove_root_bus(rockchip->root_bus);
> -       pci_unmap_iospace(rockchip->io);
>         irq_domain_remove(rockchip->irq_domain);
>
>         rockchip_pcie_deinit_phys(rockchip);
> --
> 2.20.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
