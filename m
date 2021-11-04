Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D83C44561B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhKDPRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 11:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhKDPRA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 11:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D4B3611C4;
        Thu,  4 Nov 2021 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636038862;
        bh=wBYUrtYV5bOgblNDQG58SO6AQxqQAhSDZOqasZVk15g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FaAMhU0/dmkOrfbeLxUhIfBlzP77dzp8qkC6h4Xc05qxukyZPEwTdsl2D+GH5ZGRE
         4aqzjXBdBsqBlDupu2L9/qhVMH9hheMYNy8a10fhQ4vWoJcCox1/YEioqthzI3W7xi
         z02NrKj/hQ26ykA3txAx2PXS6lTAAIIzYfj5DrMYYH51tVWwZPZVI4eScZiJXORlcV
         AqoiuYNLkatCdlXJBxsT0ZmLO8MJfF6Yx/R6ugIG4ptO9GUtLDaAAVdobS3Kqvrj6+
         vjN1P02n251/Ibk8iVBxUsOM4aw5YxeqSz5No5yw37EUPP20beILIuylqSRQCmAZ6X
         E6Sa6yaSfktAQ==
Received: by mail-ed1-f45.google.com with SMTP id g14so22298574edz.2;
        Thu, 04 Nov 2021 08:14:21 -0700 (PDT)
X-Gm-Message-State: AOAM533+dZY0b4juTE7HHvzdGCK/P3t0pslzsBz1qSKT/FqD/C/qQbqB
        TM02GI5Q8z7I/Ok24EO1aONfmjb1AwRU7+bwjA==
X-Google-Smtp-Source: ABdhPJw1woIBsI1rZWVLnEUod2eEP+ocn5gKgZzN1QZgNcVK9JMnr2075i6IDSFGt6gQX1Q9uYWB0c4fSHEIdZZCWuc=
X-Received: by 2002:a17:906:66d2:: with SMTP id k18mr13050120ejp.320.1636038852570;
 Thu, 04 Nov 2021 08:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211103184939.45263-1-jim2101024@gmail.com> <20211103184939.45263-6-jim2101024@gmail.com>
In-Reply-To: <20211103184939.45263-6-jim2101024@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 4 Nov 2021 10:13:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+7vER_VkHJZt3vzz6qaqGvF3ts0NQQ4KCR4fi95+ZVZg@mail.gmail.com>
Message-ID: <CAL_Jsq+7vER_VkHJZt3vzz6qaqGvF3ts0NQQ4KCR4fi95+ZVZg@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
To:     Jim Quinlan <jim2101024@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 3, 2021 at 1:49 PM Jim Quinlan <jim2101024@gmail.com> wrote:
>
> This Broadcom STB PCIe RC driver has one port and connects directly to one
> device, be it a switch or an endpoint.  We want to be able to turn on/off
> any regulators for that device.  Control of regulators is needed because of
> the chicken-and-egg situation: although the regulator is "owned" by the
> device and would be best handled by its driver, the device cannot be
> discovered and probed unless its regulator is already turned on.
>
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 156 +++++++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index ba4d6daf312c..aaf6a4cbeb78 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -24,6 +24,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/printk.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/reset.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -191,6 +192,15 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
>  static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
>  static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
> +static int brcm_pcie_add_bus(struct pci_bus *bus);
> +static void brcm_pcie_remove_bus(struct pci_bus *bus);
> +static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
> +
> +static const char * const supplies[] = {
> +       "vpcie3v3",
> +       "vpcie3v3aux",
> +       "vpcie12v",

Common DT properties, so they should be in common DT code.

> +};
>
>  enum {
>         RGR1_SW_INIT_1,
> @@ -295,8 +305,38 @@ struct brcm_pcie {
>         u32                     hw_rev;
>         void                    (*perst_set)(struct brcm_pcie *pcie, u32 val);
>         void                    (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> +       struct regulator_bulk_data supplies[ARRAY_SIZE(supplies)];
> +       unsigned int            num_supplies;

Humm, this will need to be stored somewhere, but the host bridge is
not the right place. That doesn't scale to more than 1 bridge/bus. I'm
not exactly sure where though. pci_bus.self->sys_data,
pci_bus.self->dev.driver_data, pci_bus->sysdata,
pci_bus->dev.driver_data are possible options. Bjorn?

However, given suspend/resume hooks are also needed, maybe
portdrv_pci.c driver is the better spot for all this? The host bridge
wouldn't be in control of opting in, but presence of a DT node ptr for
the port device may be sufficient.

Rob
