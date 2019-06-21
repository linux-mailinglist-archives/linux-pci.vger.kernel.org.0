Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09774EC6B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 17:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFUPpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 11:45:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40795 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfFUPpE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 11:45:04 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so89356ioc.7
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxm7GOcU7qUFuWy1WhLbGliMHK4qz3vxLGVpx4HgQB0=;
        b=moZqDRZ2BR+wvMG5nlpY0ZdMbc4FBaH9Oatm9ufFW1xWv4o//FJ6SY5IXFB1Na8ESB
         R5WPHrWvdAzZyibh/L9Xm3NFcL33L0sAC/XY+EFM6rN+q+bFT2VcCyNCSKedQNXI/44/
         ssbWKLOfTr9BOlWxnbVy5U6MsNf1HuBl2PU8mCKOOFveZQtjW31frkb3+44ocuxTS5Nu
         VOIggl8fh1dcZZSnE3q/kb82ZU68iaWtdBliNWXZsVWgcvG1DALSnyW9CacDD21HTACl
         oNvvnz+1HillIZjWciMPJr55EMvJ0Vi4C6MgPDUjbhcQ4dWZVqWhN1xrQ6lalyK8UDeo
         JHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxm7GOcU7qUFuWy1WhLbGliMHK4qz3vxLGVpx4HgQB0=;
        b=hWEoIXmEH/B2Kf0+zNmHixKiP+uIwnuzrwA0PTMXAtKpPBCk6YMO9pXvoycdK9U+Qe
         7VyYra4z+e2OIul2H6JG+3ykaDE3RAzAfZLtArELC1/GGi7qnypmqR565ZxQzSpQO095
         12by/NFEuaeTJj9hvwETBGJ5smjYT/TV3RWAAbfOm005QFWOwPAH9vadNeWXVaS4nLlS
         gO9fP4jvSkNHPjoPvwJT+7mus9FRM9c6v+CDw2fquO1yb8REZeL7AvwOs0VJupw2PI5K
         da18jWaXLGr9lWaYlwsDrVnojnxkQIqG5HOrbP307aJelXUu/vSvNPVCOZaLy9KqL/Wr
         B5sg==
X-Gm-Message-State: APjAAAWuCzlt3S2u4s7XvPhgG9EpCkhxm3w4F4NvZ0LLNgi0PUJf/2lX
        1YWUf8VeLFwNUBMli3LYBtdxddE73xCTrnCBFLbPRg==
X-Google-Smtp-Source: APXvYqzZY+gOixQjMUl856N0sHPx+HD44kd2sZoHmHXE1d0Rv7jbWWsubnhodFuDC99TqRUIdNNTbX9lAyGC6TFDJNs=
X-Received: by 2002:a5d:8794:: with SMTP id f20mr37337499ion.128.1561131903453;
 Fri, 21 Jun 2019 08:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190615002359.29577-1-benh@kernel.crashing.org> <20190615002359.29577-4-benh@kernel.crashing.org>
In-Reply-To: <20190615002359.29577-4-benh@kernel.crashing.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 21 Jun 2019 17:44:52 +0200
Message-ID: <CAKv+Gu95mmsSzzAUTp5Cw3vN-Ge=OZ6danTSeb3xs7dj9Vs6ow@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: pci: acpi: Preserve PCI resources
 configuration when asked by ACPI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sinan Kaya <okaya@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
        Zeev Zilberman <zeev@amazon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 15 Jun 2019 at 02:30, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> When _DSM #5 returns 0 for a host bridge, we need to claim the existing
> resources rather than reassign everything.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/kernel/pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1419b1b4e9b9..a2c608a3fc41 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>         struct acpi_pci_generic_root_info *ri;
>         struct pci_bus *bus, *child;
>         struct acpi_pci_root_ops *root_ops;
> +       struct pci_host_bridge *hb;
>
>         ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>         if (!ri)
> @@ -193,6 +194,16 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>         if (!bus)
>                 return NULL;
>
> +       hb = pci_find_host_bridge(bus);
> +
> +       /* If ACPI tells us to preserve the resource configuration, claim now */
> +       if (hb->preserve_config)
> +               pci_bus_claim_resources(bus);
> +
> +       /*
> +        * Assign whatever was left unassigned. If we didn't claim above, this will
> +        * reassign everything.
> +        */
>         pci_assign_unassigned_root_bus_resources(bus);
>
>         list_for_each_entry(child, &bus->children, node)
> --
> 2.17.1
>
