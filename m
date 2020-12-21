Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6854D2DFDE6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 17:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbgLUQH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Dec 2020 11:07:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLUQH3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Dec 2020 11:07:29 -0500
X-Gm-Message-State: AOAM532JhukNF2wFfQjyw2lIFW8Edpju8iI2N9UH47mmSMZi4rNhBrHO
        LVVPTzjZKwM5Bi0B8EG3bhfJYgEDFeUJGHfkVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608566808;
        bh=bt012kUB8DBMRxTaaQcKv/3tMYUHD4Nw6aawgMmHUko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TnxfTS8U0vqfogcSANriPHtm51UD673sYV6CkOKq4hcl3Ksevxgp0ygieebJY4/If
         pNzt10zLjAXXOEEUCjupemId2CTpCEoJSYKAg6MdwO8v0Znu4CRgcEtZ9cF29aMkuD
         CoUBU5n63wd2whhukNyY6zp4/TyCRGhgE/Y069+ayHHbIBNqSOyB9mlMGebdIsci05
         VPa3oaZ79xskWusXM6tK4JUBqZ+DNuMd1u2QamJKqBKaCqIB6NTqih1OQjkMAppYDp
         AEWGiNSXxVYpVulFgbrlzJL6OLqJHcCrQb55LsJFkD1HmvHvIXZxD4BuyPMbdUDc5W
         9uwKEx/9nsZeA==
X-Google-Smtp-Source: ABdhPJxnNNNtEFi3KK3l8ixLB/cEKyNoL8+FsKA7VfV5dCYFytLwMhwqHe1WNExSWS+FKn5YOdQBT5XJ8ckRGB6IDYg=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr16788882edy.194.1608566806574;
 Mon, 21 Dec 2020 08:06:46 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012@epcas5p1.samsung.com>
 <1608305434-31685-1-git-send-email-shradha.t@samsung.com>
In-Reply-To: <1608305434-31685-1-git-send-email-shradha.t@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Dec 2020 09:06:33 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKdzu8EgY-pqxH+ZyDh3ALJGccqgPuj=cc==SGbMvYZJw@mail.gmail.com>
Message-ID: <CAL_JsqKdzu8EgY-pqxH+ZyDh3ALJGccqgPuj=cc==SGbMvYZJw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Add upper limit address for outbound iATU
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 20, 2020 at 6:56 PM Shradha Todi <shradha.t@samsung.com> wrote:
>
> The size parameter is unsigned long type which can accept
> size > 4GB. In that case, the upper limit address must be
> programmed. Add support to program the upper limit
> address and set INCREASE_REGION_SIZE in case size > 4GB.

Not all DWC h/w versions have the upper register and bit. Is it safe
to write to the non-existent register?

>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 28c56a1..7eba3b2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -290,12 +290,16 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>                            upper_32_bits(cpu_addr));
>         dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
>                            lower_32_bits(cpu_addr + size - 1));
> +       dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
> +                          upper_32_bits(cpu_addr + size - 1));

If not safe, perhaps only write if non-zero.

>         dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
>                            lower_32_bits(pci_addr));
>         dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
>                            upper_32_bits(pci_addr));
> -       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
> -                          PCIE_ATU_FUNC_NUM(func_no));
> +       val = type | PCIE_ATU_FUNC_NUM(func_no);
> +       val = upper_32_bits(size - 1) ?
> +               val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +       dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
>         dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
>
>         /*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index b09329b..28b72fb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -106,6 +106,7 @@
>  #define PCIE_ATU_DEV(x)                        FIELD_PREP(GENMASK(23, 19), x)
>  #define PCIE_ATU_FUNC(x)               FIELD_PREP(GENMASK(18, 16), x)
>  #define PCIE_ATU_UPPER_TARGET          0x91C
> +#define PCIE_ATU_UPPER_LIMIT           0x924
>
>  #define PCIE_MISC_CONTROL_1_OFF                0x8BC
>  #define PCIE_DBI_RO_WR_EN              BIT(0)
> --
> 2.7.4
>
