Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F32D2E8C40
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbfJ2P6m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 11:58:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53890 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390172AbfJ2P6l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 11:58:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id n7so3171771wmc.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2019 08:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ogyg03BfT8gaHZbuV4/3535qjZlsTqwkzaB+k+qmJSk=;
        b=auxvEGz+98ZDBi/3qT4estTcr/B0w8IzvpYRBlJghVDt+kEZTN1DrBp6hsX/szCm0S
         Ntg3b9Z1+ejknx7Ccrkleqkzjl8Ky11vHSpEAGmlWVbc6JJnMtLuoVbGHlLb8LrKT3cn
         uKPaHB3q+wCzJC2R81txkKTpwzgO4YZ3vvsV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ogyg03BfT8gaHZbuV4/3535qjZlsTqwkzaB+k+qmJSk=;
        b=hTa8TRrrVyMrC7GB5/fIgcfDKjE/ciz33KTgURu23iOv1KUxHWNqfNU1Y46UTIIzG6
         zCwnSkqhcccwIXqnvSsuw3iasHwe9ODv8DQWwGHteOOYnfGXm/rYRlq+MtTR8e+7/DWw
         kbqD2VZK+eH0B9MgHMAHynHNi+h+u6e6B8+AU5w3K5xDuTB4nTzV9KW3IlOsF/8mGmYX
         bBFNrpGxKxDZ6XckVSgvvy02HHIcxYKqwlqXruGoaYViPs/pQuli0R1Ybt9J782gh/9W
         IkHMI0Vz7LzpbwnFuQyqvEVIjOUV2RnNY8yrg8Edy6US6llTcqLSGc+FKwlB7IjtZyhW
         TiIg==
X-Gm-Message-State: APjAAAXgvv9ee8HN+05Yrj8h3ahRpgE8gtSaMBnMcyVPLumCFUgtAmI+
        LkXWyUmD464l9lUCzfkxCOTAlG/GL0WqpDKdi00zAw==
X-Google-Smtp-Source: APXvYqxXBunHeyxtZsAWTCPejceTiGMbnnAGC4cBuQxzLelWDxFoP9zriSI9AupBxaoECqcivUoGxX1DNc3YZFr8rtQ=
X-Received: by 2002:a1c:6282:: with SMTP id w124mr4723287wmb.172.1572364718992;
 Tue, 29 Oct 2019 08:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <20191028163256.8004-1-robh@kernel.org> <20191028163256.8004-8-robh@kernel.org>
In-Reply-To: <20191028163256.8004-8-robh@kernel.org>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Tue, 29 Oct 2019 21:28:27 +0530
Message-ID: <CABe79T4uF0vnxAbbR-ckr4uBpni3KmD2RYqSS_jUh-KRDFLvzQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/25] PCI: iproc: Use pci_parse_request_of_pci_ranges()
To:     Rob Herring <robh@kernel.org>
Cc:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

I reviewed and verified this change.. It is working fine.

Regards,
Srinath.

On Mon, Oct 28, 2019 at 10:03 PM Rob Herring <robh@kernel.org> wrote:
>
> Convert the iProc host bridge to use the common
> pci_parse_request_of_pci_ranges().
>
> There's no need to assign the resources to a temporary list, so just use
> bridge->windows directly.
>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pcie-iproc-platform.c | 8 ++------
>  drivers/pci/controller/pcie-iproc.c          | 5 -----
>  2 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index 9ee6200a66f4..375d815f7301 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -43,8 +43,6 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>         struct iproc_pcie *pcie;
>         struct device_node *np = dev->of_node;
>         struct resource reg;
> -       resource_size_t iobase = 0;
> -       LIST_HEAD(resources);
>         struct pci_host_bridge *bridge;
>         int ret;
>
> @@ -97,8 +95,7 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>         if (IS_ERR(pcie->phy))
>                 return PTR_ERR(pcie->phy);
>
> -       ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &resources,
> -                                                   &iobase);
> +       ret = pci_parse_request_of_pci_ranges(dev, &bridge->windows, NULL);
>         if (ret) {
>                 dev_err(dev, "unable to get PCI host bridge resources\n");
>                 return ret;
> @@ -113,10 +110,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>                 pcie->map_irq = of_irq_parse_and_map_pci;
>         }
>
> -       ret = iproc_pcie_setup(pcie, &resources);
> +       ret = iproc_pcie_setup(pcie, &bridge->windows);
>         if (ret) {
>                 dev_err(dev, "PCIe controller setup failed\n");
> -               pci_free_resource_list(&resources);
>                 return ret;
>         }
>
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 2d457bfdaf66..223335ee791a 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -1498,10 +1498,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>                 return ret;
>         }
>
> -       ret = devm_request_pci_bus_resources(dev, res);
> -       if (ret)
> -               return ret;
> -
>         ret = phy_init(pcie->phy);
>         if (ret) {
>                 dev_err(dev, "unable to initialize PCIe PHY\n");
> @@ -1543,7 +1539,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
>                 if (iproc_pcie_msi_enable(pcie))
>                         dev_info(dev, "not using iProc MSI\n");
>
> -       list_splice_init(res, &host->windows);
>         host->busnr = 0;
>         host->dev.parent = dev;
>         host->ops = &iproc_pcie_ops;
> --
> 2.20.1
>
