Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40EF4FF049
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiDMHFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 03:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiDMHF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 03:05:29 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6C2DAA7
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 00:03:08 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id o14so420344vkf.13
        for <linux-pci@vger.kernel.org>; Wed, 13 Apr 2022 00:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHWxs4+FkL4U36vmbJ4hsJqcs6mcA0G++wV/NoGaumE=;
        b=GtrgtsLKn3UYes2HyU+WQrjNsfiLQR7vatuxTGQUhfgaeSjmN7WMcl7XcjogPa+6N4
         HbKcE7F244WQHa9C4eUdvMmHj7FYPfDn4tNnFqBxSvXZ3cg8xw0iaGrO5ICDISAczi8o
         HqVHX29L5d5yao9009M2rmI1v9+xdr5L27xVI976oEs75lGSF2biDRTMsFHvabm+LQ1L
         bg5uBMo4pDd/xw89FmKtH09XNPAEpPladqpCeqyNj9MWA+Eb8qVep900sJjK7Tq+RD+6
         yjSDo+BMIHDaRp+xMdKwDaXTSvfBA991ecZcsXKFUfRiV+ngaQKV+TJAjD7oMt/bpRpQ
         s9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHWxs4+FkL4U36vmbJ4hsJqcs6mcA0G++wV/NoGaumE=;
        b=NmGOgllEUb0E8sU3Zxg+SBNaa9gnWd0cIMtLqZgtfK0ADTnLySKq6ricBXCg8Z1n1C
         jLWOeZ+XxIDdG1qumy3Khpjsw/+a9rmCg+w/TQkCoyidA7EKB87Au88gee8Phxp+se8J
         wEVohLooSBiiS8ZdTMl3CmsZ37qa5KMHA5V28UD2V1jtK5h8t91dJxz3/L/982cjM1/I
         bU/AiODGljHHYNdaxrv7lxwxvIrj33A+WO6BtKrfePDcQYTNs4lHe+R2REoVGk3fp8BE
         1BNcVIAlcDLnhvjqib0BsKBHUMPW6cUbuuZ3NkCb/WeClKa5weyHL2rLesZgp+mla0Df
         lfXw==
X-Gm-Message-State: AOAM530/sYgh1dhAinU8cnaepEjt4al8pQYaLOc50WtsULxoJvZTp1FB
        v0mpyOoQgB5/rs9YGheL69msbpFJ7oyOXkf3iNpPO+nAmzD9tA==
X-Google-Smtp-Source: ABdhPJy8VWrWIJzWp4KWfd0EJ5+KE6g6v6e+AF3yiI6VZ9//br2PoPaDUjekKH2KfOMbRQOi18A5X92MAkW4m8yVofk=
X-Received: by 2002:a05:6122:169a:b0:345:6ed2:93ad with SMTP id
 26-20020a056122169a00b003456ed293admr5601992vkl.30.1649833387952; Wed, 13 Apr
 2022 00:03:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220226104731.76776-1-chenhuacai@loongson.cn>
 <20220226104731.76776-2-chenhuacai@loongson.cn> <YlWPZ3J408ncOujh@robh.at.kernel.org>
In-Reply-To: <YlWPZ3J408ncOujh@robh.at.kernel.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 13 Apr 2022 15:02:56 +0800
Message-ID: <CAAhV-H5B0cMBrgY5PfAZRvVmoEW5+m0cbw1t7m2igLuuoond4w@mail.gmail.com>
Subject: Re: [PATCH V12 1/6] PCI: loongson: Use generic 8/16/32-bit config ops
 on LS2K/LS7A
To:     Rob Herring <robh@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Rob,

On Tue, Apr 12, 2022 at 10:40 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Feb 26, 2022 at 06:47:26PM +0800, Huacai Chen wrote:
> > LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
> > we can disable CFG0 for them and safely use pci_generic_config_read()/
> > pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> > generic_config_write32().
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 65 +++++++++++++++++++--------
> >  1 file changed, 46 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 48169b1e3817..433261c5f34c 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -25,11 +25,16 @@
> >  #define FLAG_CFG1    BIT(1)
> >  #define FLAG_DEV_FIX BIT(2)
> >
> > +struct pci_controller_data {
>
> struct loongson_pci_data
OK, thanks.

>
> > +     u32 flags;
> > +     struct pci_ops *ops;
>
> const struct
Must we do this? This cause a build warning in the later bridge->ops =
priv->data->ops;

>
> > +};
> > +
> >  struct loongson_pci {
> >       void __iomem *cfg0_base;
> >       void __iomem *cfg1_base;
> >       struct platform_device *pdev;
> > -     u32 flags;
> > +     struct pci_controller_data *data;
> >  };
> >
> >  /* Fixup wrong class code in PCIe bridges */
> > @@ -126,8 +131,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
> >        * Do not read more than one device on the bus other than
> >        * the host bus. For our hardware the root bus is always bus 0.
> >        */
> > -     if (priv->flags & FLAG_DEV_FIX && busnum != 0 &&
> > -             PCI_SLOT(devfn) > 0)
> > +     if (priv->data->flags & FLAG_DEV_FIX &&
> > +                     busnum != 0 && PCI_SLOT(devfn) > 0)
>
> Are you sure you need all this? The default for PCIe (not PCI) is to
> only scan device 0 on child buses.
Yes, current LS7A has a hardware flaw, we may enumerate duplicated
devices under pcie-to-pcie bridges.

>
> In any case, use pci_is_root_bus() rather than checking bus number
> is/isn't 0.
OK, thanks.

>
>
> >               return NULL;
> >
> >       /* CFG0 can only access standard space */
> > @@ -159,20 +164,42 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >       return val;
> >  }
> >
> > -/* H/w only accept 32-bit PCI operations */
> > +/* LS2K/LS7A accept 8/16/32-bit PCI config operations */
> >  static struct pci_ops loongson_pci_ops = {
> > +     .map_bus = pci_loongson_map_bus,
> > +     .read   = pci_generic_config_read,
> > +     .write  = pci_generic_config_write,
> > +};
> > +
> > +/* RS780/SR5690 only accept 32-bit PCI config operations */
> > +static struct pci_ops loongson_pci_ops32 = {
> >       .map_bus = pci_loongson_map_bus,
> >       .read   = pci_generic_config_read32,
> >       .write  = pci_generic_config_write32,
> >  };
> >
> > +static const struct pci_controller_data ls2k_pci_data = {
> > +     .flags = FLAG_CFG1 | FLAG_DEV_FIX,
> > +     .ops = &loongson_pci_ops,
> > +};
> > +
> > +static const struct pci_controller_data ls7a_pci_data = {
> > +     .flags = FLAG_CFG1 | FLAG_DEV_FIX,
> > +     .ops = &loongson_pci_ops,
> > +};
> > +
> > +static const struct pci_controller_data rs780e_pci_data = {
> > +     .flags = FLAG_CFG0,
> > +     .ops = &loongson_pci_ops32,
> > +};
> > +
> >  static const struct of_device_id loongson_pci_of_match[] = {
> >       { .compatible = "loongson,ls2k-pci",
> > -             .data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> > +             .data = (void *)&ls2k_pci_data, },
>
> Don't need the cast IIRC.
OK, thanks.

Huacai
>
> >       { .compatible = "loongson,ls7a-pci",
> > -             .data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> > +             .data = (void *)&ls7a_pci_data, },
> >       { .compatible = "loongson,rs780e-pci",
> > -             .data = (void *)(FLAG_CFG0), },
> > +             .data = (void *)&rs780e_pci_data, },
> >       {}
> >  };
> >
> > @@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
> >
> >       priv = pci_host_bridge_priv(bridge);
> >       priv->pdev = pdev;
> > -     priv->flags = (unsigned long)of_device_get_match_data(dev);
> > +     priv->data = (struct pci_controller_data *)of_device_get_match_data(dev);
> >
> > -     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (!regs) {
> > -             dev_err(dev, "missing mem resources for cfg0\n");
> > -             return -EINVAL;
> > +     if (priv->data->flags & FLAG_CFG0) {
> > +             regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +             if (!regs)
> > +                     dev_err(dev, "missing mem resources for cfg0\n");
> > +             else {
> > +                     priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
> > +                     if (IS_ERR(priv->cfg0_base))
> > +                             return PTR_ERR(priv->cfg0_base);
> > +             }
> >       }
> >
> > -     priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
> > -     if (IS_ERR(priv->cfg0_base))
> > -             return PTR_ERR(priv->cfg0_base);
> > -
> > -     /* CFG1 is optional */
> > -     if (priv->flags & FLAG_CFG1) {
> > +     if (priv->data->flags & FLAG_CFG1) {
> >               regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >               if (!regs)
> >                       dev_info(dev, "missing mem resource for cfg1\n");
> > @@ -218,7 +245,7 @@ static int loongson_pci_probe(struct platform_device *pdev)
> >       }
> >
> >       bridge->sysdata = priv;
> > -     bridge->ops = &loongson_pci_ops;
> > +     bridge->ops = priv->data->ops;
> >       bridge->map_irq = loongson_map_irq;
> >
> >       return pci_host_probe(bridge);
> > --
> > 2.27.0
> >
