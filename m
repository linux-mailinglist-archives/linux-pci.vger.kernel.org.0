Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93154276149
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgIWTqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 15:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgIWTqa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 15:46:30 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3872206B2;
        Wed, 23 Sep 2020 19:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600890389;
        bh=lpxoD5mCpoUdNQFJ4V0R7t4U1NB9Y1DoHhTBkhnahaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rTGr4LvNkco1FzUzFdCFQBY+kp7fnxnb+BT8QzE1u0Iwf4q2N3TopKWt9hX8H50An
         Y6awtFa/m1me1W4YKpgWds/DtotI4cp/8+6xljnDMtBX9u+7AFiqzvNC5w1lm+xEl0
         j041pzDDFLBuORWcEnIEzeVj3roJJXs5vrPA8/Fg=
Received: by mail-oi1-f177.google.com with SMTP id v20so1119672oiv.3;
        Wed, 23 Sep 2020 12:46:29 -0700 (PDT)
X-Gm-Message-State: AOAM5303fqGQ+Tcjy27FIWT/NpxqrmT7cBvBjee0xYMtKBu2ISX9d4Rg
        GrNIWJqFTdOYUKkhlb5X0Jvj9kDS6gRLl19v2Q==
X-Google-Smtp-Source: ABdhPJy4WNw1Y7iocXuEKIUXeliaNXDm+44vCu4iKNMjEVWblg9mCzqOJyZroSJfu2GIm7IKOtNmap6NX6rNpIxsBKo=
X-Received: by 2002:aca:1711:: with SMTP id j17mr646620oii.152.1600890388844;
 Wed, 23 Sep 2020 12:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200923183427.9258-1-nadeem@cadence.com>
In-Reply-To: <20200923183427.9258-1-nadeem@cadence.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Sep 2020 13:46:17 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+2Q+7H_DMqYSWSBV2y3==ABXxhL6NVxTHTujWR6iTsJg@mail.gmail.com>
Message-ID: <CAL_Jsq+2Q+7H_DMqYSWSBV2y3==ABXxhL6NVxTHTujWR6iTsJg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 12:34 PM Nadeem Athani <nadeem@cadence.com> wrote:
>
> Cadence controller will not initiate autonomous speed change if
> strapped as Gen2. The Retrain bit is set as a quirk to trigger
> this speed change.
>
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 14 ++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      | 15 +++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 4550e0d469ca..a2317614268d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -83,6 +83,9 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>         struct cdns_pcie *pcie = &rc->pcie;
>         u32 value, ctrl;
>         u32 id;
> +       u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;
> +       u8 sls;
> +       u16 lnk_ctl;
>
>         /*
>          * Set the root complex BAR configuration register:
> @@ -111,6 +114,17 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>         if (rc->device_id != 0xffff)
>                 cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>
> +       /* Quirk to enable autonomous speed change for GEN2 controller */
> +       /* Reading Supported Link Speed value */
> +       sls = PCI_EXP_LNKCAP_SLS &
> +               cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);

A 32-bit register, right?

> +       if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
> +               /* Since this a Gen2 controller, set Retrain Link(RL) bit */
> +               lnk_ctl = cdns_pcie_rp_readw(pcie, link_cap + PCI_EXP_LNKCTL);
> +               lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +               cdns_pcie_rp_writew(pcie, link_cap + PCI_EXP_LNKCTL, lnk_ctl);
> +       }
> +
>         cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
>         cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>         cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index feed1e3038f4..fe560480c573 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -120,6 +120,7 @@
>   */
>  #define CDNS_PCIE_RP_BASE      0x00200000
>
> +#define CDNS_PCIE_LINK_CAP_OFFSET 0xC0
>
>  /*
>   * Address Translation Registers
> @@ -413,6 +414,20 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>         cdns_pcie_write_sz(addr, 0x2, value);
>  }
>
> +static inline u8 cdns_pcie_rp_readb(struct cdns_pcie *pcie, u32 reg)
> +{
> +       void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +       return cdns_pcie_read_sz(addr, 0x1);
> +}
> +
> +static inline u16 cdns_pcie_rp_readw(struct cdns_pcie *pcie, u32 reg)
> +{
> +       void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +       return cdns_pcie_read_sz(addr, 0x2);
> +}
> +
>  /* Endpoint Function register access */
>  static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
>                                           u32 reg, u8 value)
> --
> 2.15.0
>
