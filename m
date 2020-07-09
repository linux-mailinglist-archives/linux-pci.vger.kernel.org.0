Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F021A5A6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 19:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGIRSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 13:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgGIRSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jul 2020 13:18:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B135C08C5CE
        for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2020 10:18:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so3264739ljn.8
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2020 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMelQbu4GNOUTiQUXyQhTQeNmU8YQghg+buL41uO1A0=;
        b=zJCx96qlIkvDubrEZxfXGqWuevrvHwUjdZMs6qlAA9VKg47tSMcZVF1STIFqSLKFYC
         V3SuWoU2GS8m0jSjEDdHBjqQh2XrNelXA0gdTGcs/BlEl4ctO8zz+FTFW2BChI11Dpin
         SO9Xb3/Nfcgz3YCV/wbV/R2OdjlkioABvEKdvhu6F9j2loo1UcHJsJILy6cNPhfu+vWz
         NI0QrroNviR7NLP0kGXD5Qgu2kk1OLpVo4F1WuPfy5wii2kc0/1LTftx0D6SDIbvJtgZ
         JQlGkWOjAGsMMEX4sYiCIFsh+9i9KotYZ+gX006iIMklSVQ4d9vdSF74i/xBROTcX7L/
         rCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMelQbu4GNOUTiQUXyQhTQeNmU8YQghg+buL41uO1A0=;
        b=CBB8LHQa+QGVMbc67eHYAhusq8dNhoxJu4w3Ra+e64wOTujhz38MdCaY9G646eh2BZ
         Rwp+XFXpp1Nma806sdB7V4zZ0Gh9DolejBaBB9irZ0NaTwTPoFptvBYB9jUKEFGbRIj2
         KT01ezaxv43q4hBxjofT+59GTqZdOVvKGzwfPIXuK/6xb4xGNGFE8UAtV4mx9i0gBha5
         yXGt89ZpK0tvpNiJXsXvwBXY8xXFNlS/vzeL2sj3fGR3rutgmC63k0Gbf4T5tRTyGGJG
         3GVVsvd3X9SV2+mAG33YdsEekK63i3ZHRJcqjgUMzHQ+vUV7ELAmWq0wndsZHKf2i1kW
         Vczw==
X-Gm-Message-State: AOAM533NYBVAJ6/eIWQMQYPZDTmEyvBBiSPw9WTc0HQBgn5bJYsgEj89
        Pl0Fr/NOEL7UmYNCswDWTk0k2895Pz2pydTTnDHSdA==
X-Google-Smtp-Source: ABdhPJy59F6ZCQSaD8uKjrbhhjFhb3xdx9OFqKmFc+CpDGYLj4EoIzWcXj907rbez1Xl3IWHWX3VNntw2kaVSl5E2p8=
X-Received: by 2002:a2e:8e8d:: with SMTP id z13mr35603314ljk.215.1594315083579;
 Thu, 09 Jul 2020 10:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200709161002.439699-1-robh@kernel.org>
In-Reply-To: <20200709161002.439699-1-robh@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 9 Jul 2020 19:17:52 +0200
Message-ID: <CADYN=9JhwHYPOVanqwOER71G__M1UPVDbE_32eChOKWVYb+fZQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: host-common: Fix driver remove NULL bridge->bus dereference
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 9 Jul 2020 at 18:10, Rob Herring <robh@kernel.org> wrote:
>
> Commit 2d716c37b5ce ("PCI: host-common: Use struct
> pci_host_bridge.windows list directly") moved platform_set_drvdata()
> before pci_host_probe() which results in the bridge->bus pointer being
> NULL. Let's change the drvdata to the bridge struct instead to fix this.
>
> Fixes: 2d716c37b5ce ("PCI: host-common: Use struct pci_host_bridge.windows list directly")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

Thank you for the quick fix.

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

> ---
>  drivers/pci/controller/pci-host-common.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index f8f71d99e427..b76e55f495e4 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -83,7 +83,7 @@ int pci_host_common_probe(struct platform_device *pdev)
>         bridge->map_irq = of_irq_parse_and_map_pci;
>         bridge->swizzle_irq = pci_common_swizzle;
>
> -       platform_set_drvdata(pdev, bridge->bus);
> +       platform_set_drvdata(pdev, bridge);
>
>         return pci_host_probe(bridge);
>  }
> @@ -91,11 +91,11 @@ EXPORT_SYMBOL_GPL(pci_host_common_probe);
>
>  int pci_host_common_remove(struct platform_device *pdev)
>  {
> -       struct pci_bus *bus = platform_get_drvdata(pdev);
> +       struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>
>         pci_lock_rescan_remove();
> -       pci_stop_root_bus(bus);
> -       pci_remove_root_bus(bus);
> +       pci_stop_root_bus(bridge->bus);
> +       pci_remove_root_bus(bridge->bus);
>         pci_unlock_rescan_remove();
>
>         return 0;
> --
> 2.25.1
>
