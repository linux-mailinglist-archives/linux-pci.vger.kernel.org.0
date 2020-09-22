Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA80274794
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgIVRiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 13:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIVRiF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 13:38:05 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B15B22206;
        Tue, 22 Sep 2020 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600796284;
        bh=8KJSUWQ23WNDIuEAXrq8uOmC1A6VoeXegOzbLw8mHrE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o1lsm5dOfOmgTpb7Ua+B3eFSm/rxPAXz+mpsYMilZSjyQntBLuUwPjpcKIwwM96ne
         UfJagjMbQWIZqO+J7UW36XNNP20NnY4LeVQNzS5lbxx8Dzpwx6KPINavgfVgjCmmyZ
         H0Xvph2RyUk22143V30helsBMNwG1KlscINTDX5w=
Received: by mail-oi1-f182.google.com with SMTP id 185so21905436oie.11;
        Tue, 22 Sep 2020 10:38:04 -0700 (PDT)
X-Gm-Message-State: AOAM5329cLwWo0PkhiI/4LlXoZMycOxM2PD3x3t4Ig/Df7C7tGSy0ULW
        5XMpRoUOuKr+WnsIfp0A28TI1rPH4QprxzIdnA==
X-Google-Smtp-Source: ABdhPJyOpI4lih1uwLxz5TQ/FgdTIG0T0C/BbyJzcHEc4sdhT+cy/DdsdZAXNI8DpX0wHe/8B1ZJyGRP3VyEHusuL3s=
X-Received: by 2002:aca:1711:: with SMTP id j17mr3449230oii.152.1600796283991;
 Tue, 22 Sep 2020 10:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200918103429.4769-1-nadeem@cadence.com>
In-Reply-To: <20200918103429.4769-1-nadeem@cadence.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 11:37:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
Message-ID: <CAL_JsqJhpPCpkfrENtbc7zfgiEqPB7ssEt1H5BpjiPPPWSPEwA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Cadence: Add quirk for Gen2 controller to do
 autonomous speed change.
To:     Nadeem Athani <nadeem@cadence.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 4:34 AM Nadeem Athani <nadeem@cadence.com> wrote:
>
> Cadence controller will not initiate autonomous speed change if
> strapped as Gen2. The Retrain bit is set as a quirk to trigger
> this speed change.
>
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c |   13 +++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h      |    6 ++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 4550e0d..4cb7f29 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -83,6 +83,8 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>         struct cdns_pcie *pcie = &rc->pcie;
>         u32 value, ctrl;
>         u32 id;
> +       u32 link_cap = CDNS_PCIE_LINK_CAP_OFFSET;
> +       u8 sls, lnk_ctl;
>
>         /*
>          * Set the root complex BAR configuration register:
> @@ -111,6 +113,17 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>         if (rc->device_id != 0xffff)
>                 cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>
> +       /* Quirk to enable autonomous speed change for GEN2 controller */
> +       /* Reading Supported Link Speed value */
> +       sls = PCI_EXP_LNKCAP_SLS &
> +               cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCAP);
> +       if (sls == PCI_EXP_LNKCAP_SLS_5_0GB) {
> +               /* Since this a Gen2 controller, set Retrain Link(RL) bit */
> +               lnk_ctl = cdns_pcie_rp_readb(pcie, link_cap + PCI_EXP_LNKCTL);
> +               lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +               cdns_pcie_rp_writeb(pcie, link_cap + PCI_EXP_LNKCTL, lnk_ctl);

Why the byte accesses? This is a 16-bit register.

> +       }
> +
>         cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
>         cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>         cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index feed1e3..075c263 100644
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
> @@ -413,6 +414,11 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>         cdns_pcie_write_sz(addr, 0x2, value);
>  }
>
> +static inline u8 cdns_pcie_rp_readb(struct cdns_pcie *pcie, u32 reg)
> +{
> +       return readb(pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +}
> +
>  /* Endpoint Function register access */
>  static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
>                                           u32 reg, u8 value)
> --
> 1.7.1
>
