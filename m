Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911121D2CA7
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgENK11 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 06:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENK10 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2020 06:27:26 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49428C061A0C
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2020 03:27:26 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id b26so2168378lfa.5
        for <linux-pci@vger.kernel.org>; Thu, 14 May 2020 03:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yoDABZlx9V5CE/ekHA9uMu2jgzupVO3DdmfwZ45PPEg=;
        b=jSad+apKGAS2jTQDSXLhw9E820Efh8ha9OknhxXt3Oi6cIAgaCibG5TRVLNA35X1zS
         NfGSirRn/tIPfPhQtj7Y/PcQDURxQY/oQ0pgHt5RX9rv0Wv5onSfvjmm/qM2lNwjcQ9+
         4smgIy4QTb1vCBdLqr2q8Ua4hudsHpaJ/2UZ3UnTeMBmsiGVgdqeLqpzuTGjSUv1Dman
         yhbLiSAqVG4o5XCuIj3VnwOAJJQB960oq3zw6jGVDpfyVdOqJwQDWzW6L7iTK7TVVVnV
         ffUKZzZSIML7f80pE4tpl+9XhNRrE4bNIDvvnB8skdYnQ6m11SMqcPUk1LxZSrYpkJwu
         PJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoDABZlx9V5CE/ekHA9uMu2jgzupVO3DdmfwZ45PPEg=;
        b=QSN69nGE4MPc6mTF423vlRWwTSqAde37PCav0kTIK8q/pHxjeXlVwVGL8TtNmgLsUw
         G7yyGPzNrPcQ9hT6+ub0kd0vMhtqWuhNJ2R3/n4E/R2Xf3R2tDZ3osAj0VJnmie5yaM0
         nrRpS3Ra6ERCIlr24BDi+aSlmQZ9aWxjDI//FPOwZyz2Q+bAX6Nx7lwAtLB4eqtk0PAA
         5GejsPOCMPleCdtqPOq6+qQtQBs8J/lPufUGh63OJvUPbDVADCmqM4fxxR4wuZ6BtAbU
         FZ6dC1E5NBRynAGGl7RnbwYBx9+nnxaKnp36jfCSyw9FNxtjocwT22wj8YLW9D7ATg67
         CFGQ==
X-Gm-Message-State: AOAM533zZTL4EQBOLAvszb+sJWRYSbPkznOOCvYERfSh6fgVStJJduI4
        w7RzFSTqlUvPmeNxgL5FibdMu4Cn61iwqY3yOzL8/w==
X-Google-Smtp-Source: ABdhPJxeKRdZLhvqaHQr5/qeIvmoKmDWGo+uBEXqDSez3/H29UbS5//OxVE5wL79OvKWmxp2mpiyPaCdMl6OkWvC1wU=
X-Received: by 2002:ac2:4436:: with SMTP id w22mr2839796lfl.55.1589452044593;
 Thu, 14 May 2020 03:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200513223859.11295-1-robh@kernel.org> <20200513223859.11295-2-robh@kernel.org>
In-Reply-To: <20200513223859.11295-2-robh@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 14 May 2020 12:27:13 +0200
Message-ID: <CADYN=9LYnNwGA1RAaWKRKP6CsC4dtHApFPJ9UmhHjP3_+UUF8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Fix pci_host_bridge struct device release/free handling
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 May 2020 at 00:39, Rob Herring <robh@kernel.org> wrote:
>
> The PCI code has several paths where the struct pci_host_bridge is freed
> directly. This is wrong because it contains a struct device which is
> refcounted and should be freed using put_device(). This can result in
> use-after-free errors. I think this problem has existed since 2012 with
> commit 7b5436635800 ("PCI: add generic device into pci_host_bridge
> struct"). It generally hasn't mattered as most host bridge drivers are
> still built-in and can't unbind.
>
> The problem is a struct device should never be freed directly once
> device_initialize() is called and a ref is held, but that doesn't happen
> until pci_register_host_bridge(). There's then a window between
> allocating the host bridge and pci_register_host_bridge() where kfree
> should be used. This is fragile and requires callers to do the right
> thing. To fix this, we need to split device_register() into
> device_initialize() and device_add() calls, so that the host bridge
> struct is always freed by using a put_device().
>
> devm_pci_alloc_host_bridge() is using devm_kzalloc() to allocate struct
> pci_host_bridge which will be freed directly. Instead, we can use a
> custom devres action to call put_device().
>
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thank you Rob for fixing this so quickly!

I applied both patches and I couldn't see the use-after-free anymore.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  drivers/pci/probe.c  | 36 +++++++++++++++++++-----------------
>  drivers/pci/remove.c |  2 +-
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index e21dc71b1907..e064ded6fbec 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -565,7 +565,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
>         return b;
>  }
>
> -static void devm_pci_release_host_bridge_dev(struct device *dev)
> +static void pci_release_host_bridge_dev(struct device *dev)
>  {
>         struct pci_host_bridge *bridge = to_pci_host_bridge(dev);
>
> @@ -574,12 +574,7 @@ static void devm_pci_release_host_bridge_dev(struct device *dev)
>
>         pci_free_resource_list(&bridge->windows);
>         pci_free_resource_list(&bridge->dma_ranges);
> -}
> -
> -static void pci_release_host_bridge_dev(struct device *dev)
> -{
> -       devm_pci_release_host_bridge_dev(dev);
> -       kfree(to_pci_host_bridge(dev));
> +       kfree(bridge);
>  }
>
>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
> @@ -599,6 +594,8 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>         bridge->native_pme = 1;
>         bridge->native_ltr = 1;
>         bridge->native_dpc = 1;
> +
> +       device_initialize(&bridge->dev);
>  }
>
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> @@ -616,17 +613,25 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  }
>  EXPORT_SYMBOL(pci_alloc_host_bridge);
>
> +static void devm_pci_alloc_host_bridge_release(void *data)
> +{
> +       pci_free_host_bridge(data);
> +}
> +
>  struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>                                                    size_t priv)
>  {
> +       int ret;
>         struct pci_host_bridge *bridge;
>
> -       bridge = devm_kzalloc(dev, sizeof(*bridge) + priv, GFP_KERNEL);
> +       bridge = pci_alloc_host_bridge(priv);
>         if (!bridge)
>                 return NULL;
>
> -       pci_init_host_bridge(bridge);
> -       bridge->dev.release = devm_pci_release_host_bridge_dev;
> +       ret = devm_add_action_or_reset(dev, devm_pci_alloc_host_bridge_release,
> +                                      bridge);
> +       if (ret)
> +               return NULL;
>
>         return bridge;
>  }
> @@ -634,10 +639,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
>
>  void pci_free_host_bridge(struct pci_host_bridge *bridge)
>  {
> -       pci_free_resource_list(&bridge->windows);
> -       pci_free_resource_list(&bridge->dma_ranges);
> -
> -       kfree(bridge);
> +       put_device(&bridge->dev);
>  }
>  EXPORT_SYMBOL(pci_free_host_bridge);
>
> @@ -908,7 +910,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>         if (err)
>                 goto free;
>
> -       err = device_register(&bridge->dev);
> +       err = device_add(&bridge->dev);
>         if (err) {
>                 put_device(&bridge->dev);
>                 goto free;
> @@ -978,7 +980,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>
>  unregister:
>         put_device(&bridge->dev);
> -       device_unregister(&bridge->dev);
> +       device_del(&bridge->dev);
>
>  free:
>         kfree(bus);
> @@ -2953,7 +2955,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>         return bridge->bus;
>
>  err_out:
> -       kfree(bridge);
> +       put_device(&bridge->dev);
>         return NULL;
>  }
>  EXPORT_SYMBOL_GPL(pci_create_root_bus);
> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
> index e9c6b120cf45..95dec03d9f2a 100644
> --- a/drivers/pci/remove.c
> +++ b/drivers/pci/remove.c
> @@ -160,6 +160,6 @@ void pci_remove_root_bus(struct pci_bus *bus)
>         host_bridge->bus = NULL;
>
>         /* remove the host bridge */
> -       device_unregister(&host_bridge->dev);
> +       device_del(&host_bridge->dev);
>  }
>  EXPORT_SYMBOL_GPL(pci_remove_root_bus);
> --
> 2.20.1
>
