Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84713286E45
	for <lists+linux-pci@lfdr.de>; Thu,  8 Oct 2020 07:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgJHFoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 01:44:13 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13872 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728403AbgJHFoM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 01:44:12 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ea6f10002>; Wed, 07 Oct 2020 22:43:13 -0700
Received: from [10.25.74.27] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 05:43:50 +0000
Subject: Re: [PATCH v2 5/5] PCI: dwc: Move dw_pcie_msi_init() from each users
 to designware host
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Yue Wang" <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Neil Armstrong" <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
CC:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20200924190421.549cb8fc@xhacker.debian>
 <20200924190742.76939458@xhacker.debian>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <2972e253-1d4f-1475-594b-024103959415@nvidia.com>
Date:   Thu, 8 Oct 2020 11:13:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200924190742.76939458@xhacker.debian>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602135793; bh=iZvy76pdbc5FJCBH+eg53TT5F3QDakC6nEIqBGQ5ke8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=ofe9x4DPu8JLtZyOBkrJptBE1YLWfDKJp/FT2TrySrEETKgd0we+ph0bHRQvhl1iJ
         QjbQmuCCngb/xcuFOPjnj2HXcQWNwHasWeKb+89PYHo/Kb0h/F8Xb+c2snOORSS8el
         M6zZhwJjr2PreNU8bEJo0EhOLIqtGVw0godmsv/gQu4rhg8CuHj3NmpUvUM0oIMpgP
         mLqjHeotbcZ184hurTiRD3t6z7Br8JEBJ9RuXc8xfMA5WyYUjUJx+zEBNobM7+QT/w
         atquyuI7LiuX19EJ6iWr+71VjsIVMJDNuPAcGIbuh7lo33vo1spfgWKBSFuBV3sKaE
         K/wVQXs9EmBbw==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/24/2020 4:37 PM, Jisheng Zhang wrote:
> External email: Use caution opening links or attachments
> 
> 
> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> may lose power during suspend-to-RAM, so when we resume, we want to
> redo the latter but not the former. If designware based driver (for
> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> previous msi page will be leaked. From another side, except
> pci-dra7xx.c we can move the dw_pcie_msi_init() from each users to
> designware host, I.E move the msi page allocation and mapping to
> dw_pcie_host_init() and move the PCIE_MSI_ADDR_* programming to
> dw_pcie_setup_rc(). After this moving, we solve the msi page leakage
> as well.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>   drivers/pci/controller/dwc/pci-dra7xx.c       |  1 +
>   drivers/pci/controller/dwc/pci-exynos.c       |  2 --
>   drivers/pci/controller/dwc/pci-imx6.c         |  3 ---
>   drivers/pci/controller/dwc/pci-meson.c        |  8 -------
>   drivers/pci/controller/dwc/pcie-artpec6.c     | 10 --------
>   .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++++-------
>   .../pci/controller/dwc/pcie-designware-plat.c |  3 ---
>   drivers/pci/controller/dwc/pcie-designware.h  |  5 ++++
>   drivers/pci/controller/dwc/pcie-histb.c       |  3 ---
>   drivers/pci/controller/dwc/pcie-kirin.c       |  3 ---
>   drivers/pci/controller/dwc/pcie-qcom.c        |  3 ---
>   drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
>   drivers/pci/controller/dwc/pcie-tegra194.c    |  2 --
>   drivers/pci/controller/dwc/pcie-uniphier.c    |  9 +------
>   14 files changed, 22 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index dc387724cf08..d8b74389e353 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -210,6 +210,7 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
>          dra7xx_pcie_establish_link(pci);
>          dw_pcie_wait_for_link(pci);
>          dw_pcie_msi_init(pp);
> +       dw_pcie_msi_config(pp);
>          dra7xx_pcie_enable_interrupts(dra7xx);
> 
>          return 0;
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index 8d82c43ae299..9cca0ce79777 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -298,8 +298,6 @@ static void exynos_pcie_msi_init(struct exynos_pcie *ep)
>          struct pcie_port *pp = &pci->pp;
>          u32 val;
> 
> -       dw_pcie_msi_init(pp);
> -
>          /* enable MSI interrupt */
>          val = exynos_pcie_readl(ep->mem_res->elbi_base, PCIE_IRQ_EN_LEVEL);
>          val |= IRQ_MSI_ENABLE;
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5fef2613b223..dba6e351e3df 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -848,9 +848,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>          dw_pcie_setup_rc(pp);
>          imx6_pcie_establish_link(imx6_pcie);
> 
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -
>          return 0;
>   }
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 4f183b96afbb..cd0d9dd8dd61 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -377,12 +377,6 @@ static int meson_pcie_establish_link(struct meson_pcie *mp)
>          return dw_pcie_wait_for_link(pci);
>   }
> 
> -static void meson_pcie_enable_interrupts(struct meson_pcie *mp)
> -{
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(&mp->pci.pp);
> -}
> -
>   static int meson_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
>                                    u32 *val)
>   {
> @@ -467,8 +461,6 @@ static int meson_pcie_host_init(struct pcie_port *pp)
>          if (ret)
>                  return ret;
> 
> -       meson_pcie_enable_interrupts(mp);
> -
>          return 0;
>   }
> 
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 97d50bb50f06..af1e6bb28e7a 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -346,15 +346,6 @@ static void artpec6_pcie_deassert_core_reset(struct artpec6_pcie *artpec6_pcie)
>          usleep_range(100, 200);
>   }
> 
> -static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
> -{
> -       struct dw_pcie *pci = artpec6_pcie->pci;
> -       struct pcie_port *pp = &pci->pp;
> -
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -}
> -
>   static int artpec6_pcie_host_init(struct pcie_port *pp)
>   {
>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -368,7 +359,6 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
>          dw_pcie_setup_rc(pp);
>          artpec6_pcie_establish_link(pci);
>          dw_pcie_wait_for_link(pci);
> -       artpec6_pcie_enable_interrupts(artpec6_pcie);
> 
>          return 0;
>   }
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7a8adf597803..6603d7c36f2e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -296,11 +296,23 @@ void dw_pcie_msi_deinit(struct pcie_port *pp)
>          }
>   }
> 
> +void dw_pcie_msi_config(struct pcie_port *pp)
> +{
> +       if (pp->msi_page) {
> +               u64 msi_target = (u64)pp->msi_data;
> +
> +               /* Program the msi_data */
> +               dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> +                                   lower_32_bits(msi_target));
> +               dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> +                                   upper_32_bits(msi_target));
> +       }
> +}
> +
>   void dw_pcie_msi_init(struct pcie_port *pp)
>   {
>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>          struct device *dev = pci->dev;
> -       u64 msi_target;
> 
>          pp->msi_page = alloc_page(GFP_KERNEL);
I'm not sure if it can be addressed in the same patch, but I think it is 
required to call dma_set_coherent_mask() with 32-bit mask before calling 
dma_map_single() as there are endpoint devices which are only 32-bit MSI 
capable and it is required to restrict the MSI target address to always 
be in 32-bit domain so that both kinds of endpoints (only 32-bit capable 
and 64-bit capable) can work with this 32-bit MSI target.

>          if (!pp->msi_page) {
> @@ -314,15 +326,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>                  dev_err(dev, "Failed to map MSI data\n");
>                  __free_page(pp->msi_page);
>                  pp->msi_page = NULL;
> -               return;
>          }
> -       msi_target = (u64)pp->msi_data;
> -
> -       /* Program the msi_data */
> -       dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> -                           lower_32_bits(msi_target));
> -       dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
> -                           upper_32_bits(msi_target));
>   }
>   EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
> 
> @@ -449,6 +453,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                                  irq_set_chained_handler_and_data(pp->msi_irq,
>                                                              dw_chained_msi_isr,
>                                                              pp);
> +                       dw_pcie_msi_init(pp);
>                  } else {
>                          ret = pp->ops->msi_host_init(pp);
>                          if (ret < 0)
> @@ -654,6 +659,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>                                              (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
>                                              4, ~0);
>                  }
> +               dw_pcie_msi_config(pp);
>          }
> 
>          /* Setup RC BARs */
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 712456f6ce36..9ccf69a3dcf4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -40,9 +40,6 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
>          dw_pcie_setup_rc(pp);
>          dw_pcie_wait_for_link(pci);
> 
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -
>          return 0;
>   }
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 43b8061e1bec..40d22fe33afe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -372,6 +372,7 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>   irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
>   void dw_pcie_msi_init(struct pcie_port *pp);
>   void dw_pcie_msi_deinit(struct pcie_port *pp);
> +void dw_pcie_msi_config(struct pcie_port *pp);
>   void dw_pcie_setup_rc(struct pcie_port *pp);
>   int dw_pcie_host_init(struct pcie_port *pp);
>   void dw_pcie_host_deinit(struct pcie_port *pp);
> @@ -390,6 +391,10 @@ static inline void dw_pcie_msi_deinit(struct pcie_port *pp)
>   {
>   }
> 
> +static inline void dw_pcie_msi_config(struct pcie_port *pp)
> +{
> +}
> +
>   static inline void dw_pcie_setup_rc(struct pcie_port *pp)
>   {
>   }
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 2a2835746077..fbf53e897ca7 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -196,9 +196,6 @@ static int histb_pcie_host_init(struct pcie_port *pp)
>   {
>          histb_pcie_establish_link(pp);
> 
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -
>          return 0;
>   }
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index e496f51e0152..d7246995daf0 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -425,9 +425,6 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
>   {
>          kirin_pcie_establish_link(pp);
> 
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -
>          return 0;
>   }
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 3aac77a295ba..2abbb850fb56 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1281,9 +1281,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
> 
>          dw_pcie_setup_rc(pp);
> 
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -
>          qcom_ep_reset_deassert(pcie);
> 
>          ret = qcom_pcie_establish_link(pcie);
> diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
> index 62846562da0b..760e27de0082 100644
> --- a/drivers/pci/controller/dwc/pcie-spear13xx.c
> +++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
> @@ -157,7 +157,6 @@ static void spear13xx_pcie_enable_interrupts(struct spear13xx_pcie *spear13xx_pc
> 
>          /* Enable MSI interrupt */
>          if (IS_ENABLED(CONFIG_PCI_MSI)) {
> -               dw_pcie_msi_init(pp);
>                  writel(readl(&app_reg->int_mask) |
>                                  MSI_CTRL_INT, &app_reg->int_mask);
>          }
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 70498689d0c0..b51fe136d345 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -783,8 +783,6 @@ static void tegra_pcie_enable_msi_interrupts(struct pcie_port *pp)
>          struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
>          u32 val;
> 
> -       dw_pcie_msi_init(pp);
> -
>          /* Enable MSI interrupt generation */
>          val = appl_readl(pcie, APPL_INTR_EN_L0_0);
>          val |= APPL_INTR_EN_L0_0_SYS_MSI_INTR_EN;
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 3a7f403b57b8..d7b465b669f4 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -318,14 +318,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
>          uniphier_pcie_irq_enable(priv);
> 
>          dw_pcie_setup_rc(pp);
> -       ret = uniphier_pcie_establish_link(pci);
> -       if (ret)
> -               return ret;
> -
> -       if (IS_ENABLED(CONFIG_PCI_MSI))
> -               dw_pcie_msi_init(pp);
> -
> -       return 0;
> +       return uniphier_pcie_establish_link(pci);
>   }
> 
>   static const struct dw_pcie_host_ops uniphier_pcie_host_ops = {
> --
> 2.28.0
> 
