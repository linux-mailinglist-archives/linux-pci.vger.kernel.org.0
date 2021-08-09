Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591F43E4845
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbhHIPDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 11:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233910AbhHIPC7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Aug 2021 11:02:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D2D61076;
        Mon,  9 Aug 2021 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628521358;
        bh=pfjcDfHytZByOLCnRC45esWeBCKweXCcCxBaUgCy7QA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IPXWzxQlZRe+At7z1ru23QFRFfPiSAv55/yZ8TgyQcgUUtyUIMrdXwhbo860OElc5
         Ok/d9xCDFeWiaL8XU6GY4uYjOIxIKHUmEDlXu6LqTr682tAzObKfwUBknaS1BY68+I
         eBJBCXBvsdVU6awmrz+i4Mb7uKpOfdn9icGGfqfBTZ5Grq486oA5Nr+pvlITSZ5xRk
         TegaARyCBjzKmDCziFFhUGHM/5CsLGht7leKhw7/Y1PB/nGyLfGDPY9rfTQxf2BJFv
         anU/XZiHRwxIYBXPuTElmYDYs5aq59sm96U8Y976SBcDOrRz6v8X4kcHitLtNJKunw
         rKtnwDPhD/puA==
Received: by mail-ed1-f43.google.com with SMTP id k9so7791900edr.10;
        Mon, 09 Aug 2021 08:02:38 -0700 (PDT)
X-Gm-Message-State: AOAM530fS3YIlCqFUU8Yj3hZih/ZiwdTzNJour0/UaX2AjxpTxAjp9g0
        As3RFo2ABb/crq/SLomCS8LsNuLg093FHQFMaA==
X-Google-Smtp-Source: ABdhPJzz/fNsZEmnTjGSH+qCz/71Qb2qPNXw5kmiZBCj/bvfBq5zSJOVPr0Lh97VLh2/gf0EMJIAll0PAP2cvH3I8FE=
X-Received: by 2002:a05:6402:104b:: with SMTP id e11mr13966903edu.62.1628521357363;
 Mon, 09 Aug 2021 08:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200821035420.380495-1-robh@kernel.org> <20200821035420.380495-40-robh@kernel.org>
 <d7146c20-6992-44a0-c390-f801d352cf15@nvidia.com>
In-Reply-To: <d7146c20-6992-44a0-c390-f801d352cf15@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Aug 2021 09:02:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+=AyqU-GPvt_cfDPpe0Grs2ez9BH7HvqyiPNgB6QTkYw@mail.gmail.com>
Message-ID: <CAL_Jsq+=AyqU-GPvt_cfDPpe0Grs2ez9BH7HvqyiPNgB6QTkYw@mail.gmail.com>
Subject: Re: [PATCH v2 39/40] PCI: dwc: Move N_FTS setup to common setup
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@amlogic.com>, Marc Zyngier <maz@kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel@axis.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 8, 2021 at 9:01 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 8/21/2020 9:24 AM, Rob Herring wrote:
> > The Designware controller has common registers to set number of fast
> > training sequence ordered sets. The Artpec6, Intel, and Tegra driver
> > initialize these register fields. Let's move the initialization to the
> > common setup code and drivers just have to provide the value.
> >
> > There's a slight change in that the common clock mode N_FTS field is
> > now initialized. Previously only the Intel driver set this. It's not
> > clear from the code if common clock mode is used in the Artpec6 or Tegra
> > driver. It depends on the DWC configuration. Given the field is not
> > initialized while the others are, it seems unlikely common clock mode
> > is used.
> >
> > Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > Cc: Thierry Reding <thierry.reding@gmail.com>
> > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > Cc: linux-tegra@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-artpec6.c    | 37 +++-----------------
> >   drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++++------
> >   drivers/pci/controller/dwc/pcie-designware.h |  3 +-
> >   drivers/pci/controller/dwc/pcie-intel-gw.c   | 27 +++++---------
> >   drivers/pci/controller/dwc/pcie-tegra194.c   | 25 ++-----------
> >   5 files changed, 35 insertions(+), 85 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> > index 86f4d66d8587..929448e9e0bc 100644
> > --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> > +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> > @@ -44,13 +44,6 @@ struct artpec_pcie_of_data {
> >
> >   static const struct of_device_id artpec6_pcie_of_match[];
> >
> > -/* PCIe Port Logic registers (memory-mapped) */
> > -#define PL_OFFSET                    0x700
> > -
> > -#define ACK_F_ASPM_CTRL_OFF          (PL_OFFSET + 0xc)
> > -#define ACK_N_FTS_MASK                       GENMASK(15, 8)
> > -#define ACK_N_FTS(x)                 (((x) << 8) & ACK_N_FTS_MASK)
> > -
> >   /* ARTPEC-6 specific registers */
> >   #define PCIECFG                             0x18
> >   #define  PCIECFG_DBG_OEN            BIT(24)
> > @@ -289,30 +282,6 @@ static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
> >       }
> >   }
> >
> > -static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
> > -{
> > -     struct dw_pcie *pci = artpec6_pcie->pci;
> > -     u32 val;
> > -
> > -     if (artpec6_pcie->variant != ARTPEC7)
> > -             return;
> > -
> > -     /*
> > -      * Increase the N_FTS (Number of Fast Training Sequences)
> > -      * to be transmitted when transitioning from L0s to L0.
> > -      */
> > -     val = dw_pcie_readl_dbi(pci, ACK_F_ASPM_CTRL_OFF);
> > -     val &= ~ACK_N_FTS_MASK;
> > -     val |= ACK_N_FTS(180);
> > -     dw_pcie_writel_dbi(pci, ACK_F_ASPM_CTRL_OFF, val);
> > -
> > -     /*
> > -      * Set the Number of Fast Training Sequences that the core
> > -      * advertises as its N_FTS during Gen2 or Gen3 link training.
> > -      */
> > -     dw_pcie_link_set_n_fts(pci, 180);
> > -}
> > -
> >   static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
> >   {
> >       u32 val;
> > @@ -351,11 +320,14 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
> >       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >       struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
> >
> > +     if (artpec6_pcie->variant == ARTPEC7) {
> > +             pci->n_fts[0] = 180;
> > +             pci->n_fts[1] = 180;
> > +     }
> >       artpec6_pcie_assert_core_reset(artpec6_pcie);
> >       artpec6_pcie_init_phy(artpec6_pcie);
> >       artpec6_pcie_deassert_core_reset(artpec6_pcie);
> >       artpec6_pcie_wait_for_phy(artpec6_pcie);
> > -     artpec6_pcie_set_nfts(artpec6_pcie);
> >       dw_pcie_setup_rc(pp);
> >       artpec6_pcie_establish_link(pci);
> >       dw_pcie_wait_for_link(pci);
> > @@ -403,7 +375,6 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
> >       artpec6_pcie_init_phy(artpec6_pcie);
> >       artpec6_pcie_deassert_core_reset(artpec6_pcie);
> >       artpec6_pcie_wait_for_phy(artpec6_pcie);
> > -     artpec6_pcie_set_nfts(artpec6_pcie);
> >
> >       for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> >               dw_pcie_ep_reset_bar(pci, bar);
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 61e1faba15bf..3cb21247619c 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -510,17 +510,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
> >   }
> >   EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
> >
> > -void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
> > -{
> > -     u32 val;
> > -
> > -     val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > -     val &= ~PORT_LOGIC_N_FTS_MASK;
> > -     val |= n_fts & PORT_LOGIC_N_FTS_MASK;
> > -     dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > -}
> > -EXPORT_SYMBOL_GPL(dw_pcie_link_set_n_fts);
> > -
> >   static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> >   {
> >       u32 val;
> > @@ -551,6 +540,23 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >       if (pci->link_gen > 0)
> >               dw_pcie_link_set_max_speed(pci, pci->link_gen);
> >
> > +     /* Configure Gen1 N_FTS */
> > +     if (pci->n_fts[0]) {
> > +             val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
> > +             val &= ~(PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK);
> > +             val |= PORT_AFR_N_FTS(pci->n_fts[0]);
> > +             val |= PORT_AFR_CC_N_FTS(pci->n_fts[0]);
> > +             dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
> > +     }
> > +
> > +     /* Configure Gen2+ N_FTS */
> > +     if (pci->n_fts[1]) {
> > +             val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +             val &= ~PORT_LOGIC_N_FTS_MASK;
> > +             val |= pci->n_fts[pci->link_gen - 1];
> Apologies for getting late to this change given that the change has
> already been merged.
> I'm wondering why is it that link_gen has to be used in deriving the
> index instead of directly using '1' as the index?
> Infact the for link speed greater than 2, accesses go beyond n_fts[]
> array boundaries.
> Since the if() check is done based on a non-zero value of pci->n_fts[1],
> shouldn't the same be used for programming also?

Yes, I think you are right.

Rob
