Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7B47DEED
	for <lists+linux-pci@lfdr.de>; Thu, 23 Dec 2021 07:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbhLWGKf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 01:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346546AbhLWGKf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Dec 2021 01:10:35 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8881C061401;
        Wed, 22 Dec 2021 22:10:34 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id u6so970936uaq.0;
        Wed, 22 Dec 2021 22:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mbHNzp0204AmGb5gPBzrhCaSQYS/qpv5OEmWLv004RY=;
        b=nmQzvwN31vfL6pLvMdPSyGBKc0/BjhCPChI0XF/UNmsxfyCq3noCj+jkkNrOSiBJ36
         n1Gf+iv9aqSOSU2Ji9nOt63ud5W88rSKrphUFbnk58wgWVMdQVr02G1uHiDSGbbKZv/u
         7X6oVkRrvi7rDZBwdishmTglfL4Om0uH9K2gTpjevxI5zeJYOO8merwJVWKQ8qcY4AgY
         Ikxt7b5+Xegk3CimZi5E8bNjWH5CFf/JWvHqLEZoieNx2x+pshuebOqjMikH9W/0wZPf
         94LQJ6r6i2V9HoLfMKH8Nkvueghodi58kfP32lARiLLvfmKVv1x5mG8ZMVQcKch+k3/U
         bioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbHNzp0204AmGb5gPBzrhCaSQYS/qpv5OEmWLv004RY=;
        b=MF8okNVfNYCxGwE37FnmGd4EUa8n0Aua0MeY72cGOLXHYFb7u6R4C8mA/7iVDgSOgJ
         284WptuRHggKAu6+MVNKci9YpsGhcre/l710rbse2bas6vVAFjNOIl/0E3ZQfwHVUdVf
         4EtIQ4AVAMs+3HLR9KcQWx/X0eu7zGBI9EhaMbFRUYykvELiwvm7tEgPVTCRKU7umqGP
         N3JgNR/G7wH6zjhaXgyyAd/L00tTfOpL5P8LdMNpx+uLO3sgPKdK0XB3AULFIqIiihjE
         GiEVkp7psyL61BtC176hHbs/W+9SsS6Zfa+qQhb55MNAUb0c2yGpHHwrcGJayo+JLu0q
         vF1A==
X-Gm-Message-State: AOAM532+cXCPuuh9x5d/GCdPz6xRybsk80i05px09Rf4iFpM66qVNyOa
        +2V+fLaAVN5vtY1Tr92Vq66O4RrTInuepid03tviCV/j
X-Google-Smtp-Source: ABdhPJxX4ofazdWru2duop3h2wcaB6hEw3qBHoxMUWn6OqVNFWPGiu3x2H6Mq80mQcMyVr2Kx3X5B3k7gd0i1DLMZMY=
X-Received: by 2002:a9f:25b6:: with SMTP id 51mr257897uaf.0.1640239833796;
 Wed, 22 Dec 2021 22:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20211223011054.1227810-1-helgaas@kernel.org> <20211223011054.1227810-18-helgaas@kernel.org>
In-Reply-To: <20211223011054.1227810-18-helgaas@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 23 Dec 2021 07:10:22 +0100
Message-ID: <CAMhs-H_dTkp6_1Loq973JqotW26GtRYQv-vdQ2i6Heo7oGCL3w@mail.gmail.com>
Subject: Re: [PATCH v2 17/23] PCI: mt7621: Rename mt7621_pci_ to mt7621_pcie_
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Fan Fei <ffclaire1224@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Dec 23, 2021 at 2:11 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Rename mt7621_pci_* structs and functions to mt7621_pcie_* for consistency
> with the rest of the file.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> ---
>  drivers/pci/controller/pcie-mt7621.c | 36 ++++++++++++++--------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 4138c0e83513..b8fea7afdb1b 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -93,8 +93,8 @@ struct mt7621_pcie_port {
>   * reset lines are inverted.
>   */
>  struct mt7621_pcie {
> -       void __iomem *base;
>         struct device *dev;
> +       void __iomem *base;

This change is unrelated to the commit message and the rest of the
changes of this patch.

>         struct list_head ports;
>         bool resets_inverted;
>  };
> @@ -129,7 +129,7 @@ static inline void pcie_port_write(struct mt7621_pcie_port *port,
>         writel_relaxed(val, port->base + reg);
>  }
>
> -static inline u32 mt7621_pci_get_cfgaddr(unsigned int bus, unsigned int slot,
> +static inline u32 mt7621_pcie_get_cfgaddr(unsigned int bus, unsigned int slot,
>                                          unsigned int func, unsigned int where)
>  {
>         return (((where & 0xf00) >> 8) << 24) | (bus << 16) | (slot << 11) |
> @@ -140,7 +140,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
>                                          unsigned int devfn, int where)
>  {
>         struct mt7621_pcie *pcie = bus->sysdata;
> -       u32 address = mt7621_pci_get_cfgaddr(bus->number, PCI_SLOT(devfn),
> +       u32 address = mt7621_pcie_get_cfgaddr(bus->number, PCI_SLOT(devfn),
>                                              PCI_FUNC(devfn), where);
>
>         writel_relaxed(address, pcie->base + RALINK_PCI_CONFIG_ADDR);
> @@ -148,7 +148,7 @@ static void __iomem *mt7621_pcie_map_bus(struct pci_bus *bus,
>         return pcie->base + RALINK_PCI_CONFIG_DATA + (where & 3);
>  }
>
> -static struct pci_ops mt7621_pci_ops = {
> +static struct pci_ops mt7621_pcie_ops = {
>         .map_bus        = mt7621_pcie_map_bus,
>         .read           = pci_generic_config_read,
>         .write          = pci_generic_config_write,
> @@ -156,7 +156,7 @@ static struct pci_ops mt7621_pci_ops = {
>
>  static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
>  {
> -       u32 address = mt7621_pci_get_cfgaddr(0, dev, 0, reg);
> +       u32 address = mt7621_pcie_get_cfgaddr(0, dev, 0, reg);
>
>         pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
>         return pcie_read(pcie, RALINK_PCI_CONFIG_DATA);
> @@ -165,7 +165,7 @@ static u32 read_config(struct mt7621_pcie *pcie, unsigned int dev, u32 reg)
>  static void write_config(struct mt7621_pcie *pcie, unsigned int dev,
>                          u32 reg, u32 val)
>  {
> -       u32 address = mt7621_pci_get_cfgaddr(0, dev, 0, reg);
> +       u32 address = mt7621_pcie_get_cfgaddr(0, dev, 0, reg);
>
>         pcie_write(pcie, address, RALINK_PCI_CONFIG_ADDR);
>         pcie_write(pcie, val, RALINK_PCI_CONFIG_DATA);
> @@ -505,16 +505,16 @@ static int mt7621_pcie_register_host(struct pci_host_bridge *host)
>  {
>         struct mt7621_pcie *pcie = pci_host_bridge_priv(host);
>
> -       host->ops = &mt7621_pci_ops;
> +       host->ops = &mt7621_pcie_ops;
>         host->sysdata = pcie;
>         return pci_host_probe(host);
>  }
>
> -static const struct soc_device_attribute mt7621_pci_quirks_match[] = {
> +static const struct soc_device_attribute mt7621_pcie_quirks_match[] = {
>         { .soc_id = "mt7621", .revision = "E2" }
>  };
>
> -static int mt7621_pci_probe(struct platform_device *pdev)
> +static int mt7621_pcie_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         const struct soc_device_attribute *attr;
> @@ -535,7 +535,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, pcie);
>         INIT_LIST_HEAD(&pcie->ports);
>
> -       attr = soc_device_match(mt7621_pci_quirks_match);
> +       attr = soc_device_match(mt7621_pcie_quirks_match);
>         if (attr)
>                 pcie->resets_inverted = true;
>
> @@ -572,7 +572,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
>         return err;
>  }
>
> -static int mt7621_pci_remove(struct platform_device *pdev)
> +static int mt7621_pcie_remove(struct platform_device *pdev)
>  {
>         struct mt7621_pcie *pcie = platform_get_drvdata(pdev);
>         struct mt7621_pcie_port *port;
> @@ -583,18 +583,18 @@ static int mt7621_pci_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -static const struct of_device_id mt7621_pci_ids[] = {
> +static const struct of_device_id mt7621_pcie_ids[] = {
>         { .compatible = "mediatek,mt7621-pci" },
>         {},
>  };
> -MODULE_DEVICE_TABLE(of, mt7621_pci_ids);
> +MODULE_DEVICE_TABLE(of, mt7621_pcie_ids);
>
> -static struct platform_driver mt7621_pci_driver = {
> -       .probe = mt7621_pci_probe,
> -       .remove = mt7621_pci_remove,
> +static struct platform_driver mt7621_pcie_driver = {
> +       .probe = mt7621_pcie_probe,
> +       .remove = mt7621_pcie_remove,
>         .driver = {
>                 .name = "mt7621-pci",
> -               .of_match_table = of_match_ptr(mt7621_pci_ids),
> +               .of_match_table = of_match_ptr(mt7621_pcie_ids),
>         },
>  };
> -builtin_platform_driver(mt7621_pci_driver);
> +builtin_platform_driver(mt7621_pcie_driver);
> --
> 2.25.1
>

Other than that minor unrelated change, this looks good to me:

Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Best regards,
    Sergio Paracuellos
