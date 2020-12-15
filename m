Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEF02DB099
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbgLOPyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 10:54:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:41718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730421AbgLOPyq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 10:54:46 -0500
X-Gm-Message-State: AOAM530VDE8fRUZKEr/iI6zaiFEJ4Iuhj47PfIqxgiVojRnq+nO36KXR
        7WPvZsmauqe9lCHTCISvGT8q7htrHFirMv8FDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047645;
        bh=gghWFkwWx1IarlLAdXd+Eia1PG+BltXx90Un2XVWq4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TIcbmFpMD+xR7If58M2C/fNWfW0LX1a3C/BUA5MmVPjuw58mZilPwXfPoL7oGSW85
         ndN0478TxxXvIT3Ld+wMnD1iJgLrsvLL636FbV+EZ863xUPsbW8jWYCiAOINCkZCPR
         PRwy2XfhsOIQkGL0xStKcO3Znqo4Re/wVALSdPnDZOx9bLQ/wCY6m0XhCuXEskpYbi
         YFn2xBvsgzS3sAMI7/Bi0gqyhSzcTJ7yOC4WJJFiQSSVm0VphTgESUDbhs0SJmGYun
         HgR1Bztq8AzQetcweYE/rXCPhjnCNIIn3cqjYDS6uH54luLJHGtII/xEjlQ5jx/a6p
         QWkZ3n+BOnFKw==
X-Google-Smtp-Source: ABdhPJzX6gCl3nrP2sdQmU523LZPHAXcWD3mEcWuFkDvD1i73xrUbyefadNidrNVOhxsFsXvANhmSOfiOKFXG/PUUeE=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr30838131edy.194.1608047643433;
 Tue, 15 Dec 2020 07:54:03 -0800 (PST)
MIME-Version: 1.0
References: <20201215070009.27937-1-kishon@ti.com>
In-Reply-To: <20201215070009.27937-1-kishon@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Dec 2020 09:53:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzi7JkMcd4NZewA=w8q6BsCkrhW3JcED63R=EyE3v29Q@mail.gmail.com>
Message-ID: <CAL_JsqJzi7JkMcd4NZewA=w8q6BsCkrhW3JcED63R=EyE3v29Q@mail.gmail.com>
Subject: Re: [PATCH v5] PCI: cadence: Retrain Link to work around Gen2
 training defect.
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nadeem Athani <nadeem@cadence.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 15, 2020 at 1:00 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> From: Nadeem Athani <nadeem@cadence.com>
>
> Cadence controller will not initiate autonomous speed change if strapped as
> Gen2. The Retrain Link bit is set as quirk to enable this speed change.
>
> Signed-off-by: Nadeem Athani <nadeem@cadence.com>
> [kishon@ti.com: Enable the workaround for TI's J721E SoC]
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Hi Lorenzo,
> The previous version of the patch can be found at [1].
> I slightly re-worked the patch from Nadeem
> *) Removed additional Link Up Check
> *) Removed quirk from pcie-cadence-plat.c
> *) Also removed additional compatible
>    "cdns,cdns-pcie-host-quirk-retrain" added in that series
> *) Enabled the quirk for J721E
> [1] -> http://lore.kernel.org/r/20201211144236.3825-1-nadeem@cadence.com
>
>  drivers/pci/controller/cadence/pci-j721e.c    |  3 +
>  .../controller/cadence/pcie-cadence-host.c    | 67 ++++++++++++++-----
>  drivers/pci/controller/cadence/pcie-cadence.h | 11 ++-
>  3 files changed, 62 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index dac1ac8a7615..baf729850cb1 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -64,6 +64,7 @@ enum j721e_pcie_mode {
>
>  struct j721e_pcie_data {
>         enum j721e_pcie_mode    mode;
> +       bool                    quirk_retrain_flag;
>  };
>
>  static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> @@ -280,6 +281,7 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
>
>  static const struct j721e_pcie_data j721e_pcie_rc_data = {
>         .mode = PCI_MODE_RC,
> +       .quirk_retrain_flag = true,
>  };
>
>  static const struct j721e_pcie_data j721e_pcie_ep_data = {
> @@ -388,6 +390,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>
>                 bridge->ops = &cdns_ti_pcie_host_ops;
>                 rc = pci_host_bridge_priv(bridge);
> +               rc->quirk_retrain_flag = data->quirk_retrain_flag;
>
>                 cdns_pcie = &rc->pcie;
>                 cdns_pcie->dev = dev;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 811c1cb2e8de..773c0d1137ed 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -77,6 +77,50 @@ static struct pci_ops cdns_pcie_host_ops = {
>         .write          = pci_generic_config_write,
>  };
>
> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> +{
> +       struct device *dev = pcie->dev;
> +       int retries;
> +
> +       /* Check if the link is up or not */
> +       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +               if (cdns_pcie_link_up(pcie)) {
> +                       dev_info(dev, "Link up\n");
> +                       return 0;
> +               }
> +               usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +       }
> +
> +       return -ETIMEDOUT;
> +}
> +
> +static void cdns_pcie_retrain(struct cdns_pcie *pcie)
> +{
> +       u32 lnk_cap_sls, pcie_cap_off = CDNS_PCIE_RP_CAP_OFFSET;
> +       u16 lnk_stat, lnk_ctl;
> +
> +       /*
> +        * Set retrain bit if current speed is 2.5 GB/s,
> +        * but the PCIe root port support is > 2.5 GB/s.

If you don't have the retrain quirk, wouldn't this condition never
happen and then the function is just a nop? So this could just be
called unconditionally.

> +        */
> +
> +       lnk_cap_sls = cdns_pcie_readl(pcie, (CDNS_PCIE_RP_BASE + pcie_cap_off +
> +                                            PCI_EXP_LNKCAP));
> +       if ((lnk_cap_sls & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +               return;
> +
> +       lnk_stat = cdns_pcie_rp_readw(pcie, pcie_cap_off + PCI_EXP_LNKSTA);
> +       if ((lnk_stat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB) {
> +               lnk_ctl = cdns_pcie_rp_readw(pcie,
> +                                            pcie_cap_off + PCI_EXP_LNKCTL);
> +               lnk_ctl |= PCI_EXP_LNKCTL_RL;
> +               cdns_pcie_rp_writew(pcie, pcie_cap_off + PCI_EXP_LNKCTL,
> +                                   lnk_ctl);
> +
> +               if (cdns_pcie_host_wait_for_link(pcie))
> +                       return;
> +       }
> +}
>
>  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
> @@ -398,23 +442,6 @@ static int cdns_pcie_host_init(struct device *dev,
>         return cdns_pcie_host_init_address_translation(rc);
>  }
>
> -static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> -{
> -       struct device *dev = pcie->dev;
> -       int retries;
> -
> -       /* Check if the link is up or not */
> -       for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -               if (cdns_pcie_link_up(pcie)) {
> -                       dev_info(dev, "Link up\n");
> -                       return 0;
> -               }
> -               usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> -       }
> -
> -       return -ETIMEDOUT;
> -}
> -
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>         struct device *dev = rc->pcie.dev;
> @@ -458,8 +485,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>         }
>
>         ret = cdns_pcie_host_wait_for_link(pcie);
> -       if (ret)
> +       if (ret) {
>                 dev_dbg(dev, "PCIe link never came up\n");
> +       } else {
> +               if (rc->quirk_retrain_flag)
> +                       cdns_pcie_retrain(pcie);
> +       }
>
>         for (bar = RP_BAR0; bar <= RP_NO_BAR; bar++)
>                 rc->avail_ib_bar[bar] = true;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 30eba6cafe2c..0f29128a5d0a 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -119,7 +119,7 @@
>   * Root Port Registers (PCI configuration space for the root port function)
>   */
>  #define CDNS_PCIE_RP_BASE      0x00200000
> -
> +#define CDNS_PCIE_RP_CAP_OFFSET 0xc0
>
>  /*
>   * Address Translation Registers
> @@ -291,6 +291,7 @@ struct cdns_pcie {
>   * @device_id: PCI device ID
>   * @avail_ib_bar: Satus of RP_BAR0, RP_BAR1 and        RP_NO_BAR if it's free or
>   *                available
> + * @quirk_retrain_flag: Retrain link as quirk for PCIe Gen2
>   */
>  struct cdns_pcie_rc {
>         struct cdns_pcie        pcie;
> @@ -299,6 +300,7 @@ struct cdns_pcie_rc {
>         u32                     vendor_id;
>         u32                     device_id;
>         bool                    avail_ib_bar[CDNS_PCIE_RP_MAX_IB];
> +       bool                    quirk_retrain_flag;
>  };
>
>  /**
> @@ -414,6 +416,13 @@ static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>         cdns_pcie_write_sz(addr, 0x2, value);
>  }
>
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
> 2.17.1
>
