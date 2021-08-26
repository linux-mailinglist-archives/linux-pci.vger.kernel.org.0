Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B623F86E1
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 14:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242389AbhHZMBh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242147AbhHZMBf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Aug 2021 08:01:35 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141F5C061757
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 05:00:48 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id g18so766072vkq.8
        for <linux-pci@vger.kernel.org>; Thu, 26 Aug 2021 05:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MCzbtFGjcNdQFu0G0IokklMMMk9HKRq16HxxWgd+zUk=;
        b=lFqaj2dpsbSWJ3PvJeUXgVnP+HreHbCd5LdTU6tpzhbjS7qqGQr8Y9KJp+SIHdjAV6
         Psw2Y3GxOofNDXDCLtvpC2C4+3iXJjC53olp9VkdTOvaHGTHh1RtPiLb/tz+Igqmt6K0
         bV7K620pF0xKlke2Gx1Ac2E8Lb4Znurl1C/BJsvg59s5Z+lTeUJap2/aLKAGOzFgP4UG
         pSV+fDJa7+Zqfag2M3HFuhYEOgkzFV24dqXvS53eoYuSrCJOvw02fmsfM+wTcua15+Pn
         5fk7Qh8yT8H1rw+OGmIXYOnhqXC8XJgg2HMDJl/99RJb8p0ALq9moLVf2MitvXMpunY/
         3i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MCzbtFGjcNdQFu0G0IokklMMMk9HKRq16HxxWgd+zUk=;
        b=HeHJo13WvEkRq9tKtsM7dj9qnSDu4FKqKvbLsnUzbikE6GuSGD6N/LDoqgH/k5/rzE
         oFr4SPFZN11Lx61LGVkIMgeYf8z4wUsZQaM9WPsHiW8otOnsmKnSWQ7xfe8s+w1XdNBP
         3CXKOoSsjbprKRCYGlVZwbVFoHiv/7Y4TSNtYhvl2L+SSOQfLEaKv/hSIfiWmfzVmTCP
         T509XDXj97KoQLXG9Ebxa1VCn/S037XVf90GRhYA6pDwRwxFiN96rZ1dN4H8PnEWJosg
         H8e5+mM4i0usVTc2fLRJhLHEqjpD90FmqwuftRxB5Zi43r+51WZZVj0yWUaQy3cUDCS7
         Wnug==
X-Gm-Message-State: AOAM531L2Kw6dQYfDJwVjz4VXc8zjRcs/+BFZMnJEiHjhzrbcxQeFb+X
        BxGShRgO2huV4z6In3/xx90ED8bqNbbTjGg0Yq4=
X-Google-Smtp-Source: ABdhPJwAt6zXU/gTNrXWfKOe7HmySqRyn6tUB/UX6Yq3MmoWc4t9l5Jjs3yumlI8Am1G/gkS+COVL7bbHodDfvPbigM=
X-Received: by 2002:a05:6122:b6b:: with SMTP id h11mr1657286vkf.21.1629979246071;
 Thu, 26 Aug 2021 05:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210825060724.3385929-2-chenhuacai@loongson.cn> <20210825173209.GA3585627@bjorn-Precision-5520>
In-Reply-To: <20210825173209.GA3585627@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 26 Aug 2021 20:00:34 +0800
Message-ID: <CAAhV-H5ES+u_os-mZ1qG2zZ_p-G-5NA8J7RhFzE_=nGNjSff8w@mail.gmail.com>
Subject: Re: [PATCH V8 1/5] PCI: loongson: Use correct pci config access operations
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Thu, Aug 26, 2021 at 1:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Things like "Use correct ..." in subject lines are useless.  *Every*
> patch should do the "proper" or "correct" thing, so it should go
> without saying.  Repeating it doesn't make it more true.
>
> This doesn't apply to *all* loongson devices, so it would be useful to
> hint at the devices it *does* apply to.
>
> Maybe something like:
>
>   PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A
>
> On Wed, Aug 25, 2021 at 02:07:20PM +0800, Huacai Chen wrote:
> > LS2K/LS7A support 8/16/32-bits pci config access operations via CFG1, so
> > we can disable CFG0 for them and safely use pci_generic_config_read()/
> > pci_generic_config_write() instead of pci_generic_config_read32()/pci_
> > generic_config_write32().
>
> s/pci/PCI/
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++----------
> >  1 file changed, 23 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 48169b1e3817..b2c81c762599 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -159,8 +159,15 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> >       return val;
> >  }
> >
> > -/* H/w only accept 32-bit PCI operations */
> > +/* LS2K/LS7A accept 8/16/32-bit PCI operations */
>
> *config* operations
>
> >  static struct pci_ops loongson_pci_ops = {
> > +     .map_bus = pci_loongson_map_bus,
> > +     .read   = pci_generic_config_read,
> > +     .write  = pci_generic_config_write,
> > +};
> > +
> > +/* RS780/SR5690 only accept 32-bit PCI operations */
> > +static struct pci_ops loongson_pci_ops32 = {
> >       .map_bus = pci_loongson_map_bus,
> >       .read   = pci_generic_config_read32,
> >       .write  = pci_generic_config_write32,
> > @@ -168,9 +175,9 @@ static struct pci_ops loongson_pci_ops = {
> >
> >  static const struct of_device_id loongson_pci_of_match[] = {
> >       { .compatible = "loongson,ls2k-pci",
> > -             .data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> > +             .data = (void *)(FLAG_CFG1 | FLAG_DEV_FIX), },
> >       { .compatible = "loongson,ls7a-pci",
> > -             .data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
> > +             .data = (void *)(FLAG_CFG1 | FLAG_DEV_FIX), },
> >       { .compatible = "loongson,rs780e-pci",
> >               .data = (void *)(FLAG_CFG0), },
>
> It'd be nice if you used the same strategy as most other drivers,
> e.g., ".data = &loongson_ls2k_data" or similar.
>
> >       {}
> > @@ -195,17 +202,17 @@ static int loongson_pci_probe(struct platform_device *pdev)
> >       priv->pdev = pdev;
> >       priv->flags = (unsigned long)of_device_get_match_data(dev);
> >
> > -     regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -     if (!regs) {
> > -             dev_err(dev, "missing mem resources for cfg0\n");
> > -             return -EINVAL;
> > +     if (priv->flags & FLAG_CFG0) {
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
> >       if (priv->flags & FLAG_CFG1) {
> >               regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >               if (!regs)
> > @@ -218,8 +225,11 @@ static int loongson_pci_probe(struct platform_device *pdev)
> >       }
> >
> >       bridge->sysdata = priv;
> > -     bridge->ops = &loongson_pci_ops;
> >       bridge->map_irq = loongson_map_irq;
> > +     if (!of_device_is_compatible(node, "loongson,rs780e-pci"))
>
> You already called of_device_get_match_data() above, which does
> essentially the same work as of_device_is_compatible().
OK, thanks, I will update this patch.

Huacai
>
> > +             bridge->ops = &loongson_pci_ops;
> > +     else
> > +             bridge->ops = &loongson_pci_ops32;
> >
> >       return pci_host_probe(bridge);
> >  }
> > --
> > 2.27.0
> >
