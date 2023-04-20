Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984326E8B23
	for <lists+linux-pci@lfdr.de>; Thu, 20 Apr 2023 09:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjDTHOx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Apr 2023 03:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjDTHOv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Apr 2023 03:14:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BDA2D64;
        Thu, 20 Apr 2023 00:14:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-244a5ccf13eso434720a91.2;
        Thu, 20 Apr 2023 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681974890; x=1684566890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WF5f/qiCq+I4QIB3+B0PWVUJeva+vS+YZGKI21h5n8k=;
        b=CRJ77JW6KbBe8kyJ2xIA/OdIJCX3BWF9TdsDwiy7SfDkY6SC22GM9tjX9kSFCUf2PG
         Cm7QQN3OvXy46uCogoH3DQ9IYUj9Z6Gp8FEXseIOhPUZZEHN8YPMQt38+szLvUrMf/zv
         4v0baj1sUEMk4zvH6q+0RSl34iL34kaiR3o+wPXBlEAWw7CS4Msgf8p2VstQDj6oTBEf
         vanha6XFl4XoY8P7s+9OOUhZn+wFtJfaoPZXJIUSWaNXAt9HrF8tu5iFZsDT/wE+Nz+c
         yVG0IOSUhaZfoodkmL2g8iDZjDf7/ZihyJOBIKTYgZ3opePv0gQDwjm/VsdzuxVHrOFj
         m1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681974890; x=1684566890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WF5f/qiCq+I4QIB3+B0PWVUJeva+vS+YZGKI21h5n8k=;
        b=YIr13AcRP3TOu1U8aNVgDOI8DQdY4tcKbWFlGSRRzazpSSwiylZ+Q+xxVH6WGiuJ5X
         7jQY9OwU7KMy4/E3GMfZbYY++VrEAjIRuFUs9J6tpU11nLLdz1GQjXnUqWDLAEwkySuq
         6YIj8NJ/rNZTIQ19ojMHOacF0B9Gtq3lBbjSR9mLpP6j/yd3xf/+DDhErgQnildw6Oav
         Wh2KiIIzkpv9d9iY4cca0Ls2gU3oFJ9wAmR4j5yJZots4GH7/O8I1EKZ5HXENS1VJp5o
         Sog8RhCHIVCnU5pyok7t41Wg++WzOtNzYFAmBgEfDwLcPAz2EzFk+K8frQAtl7BRP5dZ
         AeWg==
X-Gm-Message-State: AAQBX9fBSM16mHBunuSEXkMTa93XBVG6OXplEtpIO/do3YovXzXNjKju
        4injfwM8UeM6nvdPPqHRj6hWI6WbeWZORegPrQjmK2+LHSCl8xfN
X-Google-Smtp-Source: AKy350bhhUfp7hBdz0g9NOIEyHF2MBw8P3pv/mgubG1I6uYlBfOdm5OAmrextNvzJbyRepJsONzc0j0oiGXG2HrwJG4=
X-Received: by 2002:a17:90b:388f:b0:23d:1143:c664 with SMTP id
 mu15-20020a17090b388f00b0023d1143c664mr743277pjb.31.1681974889887; Thu, 20
 Apr 2023 00:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230419193513.708818-1-robh@kernel.org>
In-Reply-To: <20230419193513.708818-1-robh@kernel.org>
From:   Donald Hunter <donald.hunter@gmail.com>
Date:   Thu, 20 Apr 2023 08:14:38 +0100
Message-ID: <CAD4GDZziEXfeietHOwutUOj4h9-zgV_EfCZj+0x5KCOO23ZS9A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Restrict device disabled status check to DT
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 19 Apr 2023 at 20:45, Rob Herring <robh@kernel.org> wrote:
>
> Commit 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
> checked the firmware device status for both DT and ACPI devices. That
> caused a regression in some ACPI systems. The exact reason isn't clear.
> It's possibly a firmware bug. For now, at least, refactor the check to
> be for DT based systems only.
>
> Note that the original implementation leaked a refcount which is now
> correctly handled.
>
> Fixes: 6fffbc7ae137 ("PCI: Honor firmware's device disabled status")
> Link: https://lore.kernel.org/all/m2fs9lgndw.fsf@gmail.com/
> Reported-by: Donald Hunter <donald.hunter@gmail.com>
> Cc: Binbin Zhou <zhoubinbin@loongson.cn>
> Cc: Liu Peibao <liupeibao@loongson.cn>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Rob Herring <robh@kernel.org>

Tested-by: Donald Hunter <donald.hunter@gmail.com>

Thanks!

> ---
>  drivers/pci/of.c    | 30 ++++++++++++++++++++++++------
>  drivers/pci/pci.h   |  4 ++--
>  drivers/pci/probe.c |  8 ++++----
>  3 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 196834ed44fe..4c2ef2e28fb5 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -16,14 +16,32 @@
>  #include "pci.h"
>
>  #ifdef CONFIG_PCI
> -void pci_set_of_node(struct pci_dev *dev)
> +/**
> + * pci_set_of_node - Find and set device's DT device_node
> + * @dev: the PCI device structure to fill
> + *
> + * Returns 0 on success with of_node set or when no device is described in the
> + * DT. Returns -ENODEV if the device is present, but disabled in the DT.
> + */
> +int pci_set_of_node(struct pci_dev *dev)
>  {
> +       struct device_node *node;
> +
>         if (!dev->bus->dev.of_node)
> -               return;
> -       dev->dev.of_node = of_pci_find_child_device(dev->bus->dev.of_node,
> -                                                   dev->devfn);
> -       if (dev->dev.of_node)
> -               dev->dev.fwnode = &dev->dev.of_node->fwnode;
> +               return 0;
> +
> +       node = of_pci_find_child_device(dev->bus->dev.of_node, dev->devfn);
> +       if (!node)
> +               return 0;
> +
> +       if (!of_device_is_available(node)) {
> +               of_node_put(node);
> +               return -ENODEV;
> +       }
> +
> +       dev->dev.of_node = node;
> +       dev->dev.fwnode = &node->fwnode;
> +       return 0;
>  }
>
>  void pci_release_of_node(struct pci_dev *dev)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d2c08670a20e..2b48a0aa8008 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -624,7 +624,7 @@ int of_pci_get_max_link_speed(struct device_node *node);
>  u32 of_pci_get_slot_power_limit(struct device_node *node,
>                                 u8 *slot_power_limit_value,
>                                 u8 *slot_power_limit_scale);
> -void pci_set_of_node(struct pci_dev *dev);
> +int pci_set_of_node(struct pci_dev *dev);
>  void pci_release_of_node(struct pci_dev *dev);
>  void pci_set_bus_of_node(struct pci_bus *bus);
>  void pci_release_bus_of_node(struct pci_bus *bus);
> @@ -662,7 +662,7 @@ of_pci_get_slot_power_limit(struct device_node *node,
>         return 0;
>  }
>
> -static inline void pci_set_of_node(struct pci_dev *dev) { }
> +static inline int pci_set_of_node(struct pci_dev *dev) { return 0; }
>  static inline void pci_release_of_node(struct pci_dev *dev) { }
>  static inline void pci_set_bus_of_node(struct pci_bus *bus) { }
>  static inline void pci_release_bus_of_node(struct pci_bus *bus) { }
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3f68b6ba6ac..f96fa83f2627 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1826,7 +1826,7 @@ int pci_setup_device(struct pci_dev *dev)
>         u32 class;
>         u16 cmd;
>         u8 hdr_type;
> -       int pos = 0;
> +       int err, pos = 0;
>         struct pci_bus_region region;
>         struct resource *res;
>
> @@ -1840,10 +1840,10 @@ int pci_setup_device(struct pci_dev *dev)
>         dev->error_state = pci_channel_io_normal;
>         set_pcie_port_type(dev);
>
> -       pci_set_of_node(dev);
> +       err = pci_set_of_node(dev);
> +       if (err)
> +               return err;
>         pci_set_acpi_fwnode(dev);
> -       if (dev->dev.fwnode && !fwnode_device_is_available(dev->dev.fwnode))
> -               return -ENODEV;
>
>         pci_dev_assign_slot(dev);
>
> --
> 2.39.2
>
