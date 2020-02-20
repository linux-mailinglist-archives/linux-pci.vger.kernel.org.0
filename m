Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C94FB16634F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 17:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBTQkH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 11:40:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36236 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgBTQkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2020 11:40:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so2791635wma.1;
        Thu, 20 Feb 2020 08:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T8wvKjlefqfXFqJVlV8HQ9fed6fOUrFPLYsYuyXQJsc=;
        b=KD4LUyGZ/1BVloNtPKSarAXfsISTN4xbWaVgWNfdncTz/qaUX7KgNrisc3m+qPHasq
         majehoINj2pN2ZjotnmBIc6qKQBT1zAlcubRL6XzzC2JV9WfEhbS55FXQMjAyyEpK3ws
         kocGdv5IBgiQNZ7C7Y8lokT4ylrl90UjwP9+PKzvi6ftyxeLTu5IcEcPeBphtdeyx5i2
         OsahYJsAu4J84u1LShmSseucLBtGEUVcy+f2iPFiBx0WnqBNaIp9M2SknwADSXzjuOm0
         jj/3tVodyJrQGbGEHdjxaqhUKwBH+iT30cl0fDl098/5mKG1Pv5qLIG4ixGLc/cd6xe1
         TN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T8wvKjlefqfXFqJVlV8HQ9fed6fOUrFPLYsYuyXQJsc=;
        b=SO2d5hgt+vDKUo9URKJopPiApsB/AKbHWgwkHdj6P7D/rn0Bj+fcHxMxF0tRY9iOTb
         gfHJMdDN14cMW+RhW+drFqiBnLxmXeDIy00MZ1/K9J11kI6/qzpUO43Pla9V1w8mR0HG
         3R7vVDOvDRTHe3Pn5tdhDNSVQMYshxmu0rTzaeh1LBcgLqqDtI6/+0lA2lcu3Ojvcf2A
         XVO5s2U5Vo+McYJ7d6ZV7Lal9yzyplO4Jy5kEniDwG4THHs2f28xhaUirf7JSdPj1hQW
         AQ17I7nkPQYcEISPQhnVCJ1SYLg1wtiRL/vcQRYn2MJrkFQEMvzBFZCh6Az7FCuHHMzU
         yM8w==
X-Gm-Message-State: APjAAAUt9sspWZxsmvOe+1UV6gbe2a8LSlEpQMgunC1nJ7c3dHOV1JNH
        l30KZHMXC5K4VjTSYYTR4schVIjigqiuRI/LxhSrXcLZ
X-Google-Smtp-Source: APXvYqwkf835f50UsguvjN0cQ7ua7prvHuBgeEK5CQM0QeHyuBi4EBfRDg+VxNRdJlYg3S55ARTKcRM1btGen1oBtTk=
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr5645941wmo.13.1582216805562;
 Thu, 20 Feb 2020 08:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20200114170231.16421-1-andrew.smirnov@gmail.com>
In-Reply-To: <20200114170231.16421-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Thu, 20 Feb 2020 08:39:54 -0800
Message-ID: <CAHQ1cqGYkJA6a6KZ8fbyM=x-Uo7fJ23u-Ywv___0zHWx8swa2w@mail.gmail.com>
Subject: Re: [PATCH] PCI: imx6: Add L1SS support for i.MX8MQ
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 14, 2020 at 9:02 AM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Add code to configure PCI IP block to utilize supported ASPM features.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 72 ++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index acfbd34032a8..3cc94ab7d22b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -40,6 +40,9 @@
>  #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE    GENMASK(11, 8)
>  #define IMX8MQ_PCIE2_BASE_ADDR                 0x33c00000
>
> +#define IMX8MQ_PCIE_LINK_CAP_L1EL_64US         (0x6 << 15)
> +#define IMX8MQ_PCIE_CTRL_APPS_CLK_REQ          BIT(4)
> +
>  #define to_imx6_pcie(x)        dev_get_drvdata((x)->dev)
>
>  enum imx6_pcie_variants {
> @@ -64,12 +67,14 @@ struct imx6_pcie {
>         struct dw_pcie          *pci;
>         int                     reset_gpio;
>         bool                    gpio_active_high;
> +       bool                    supports_clkreq;
>         struct clk              *pcie_bus;
>         struct clk              *pcie_phy;
>         struct clk              *pcie_inbound_axi;
>         struct clk              *pcie;
>         struct clk              *pcie_aux;
>         struct regmap           *iomuxc_gpr;
> +       struct regmap           *src;
>         u32                     controller_id;
>         struct reset_control    *pciephy_reset;
>         struct reset_control    *apps_reset;
> @@ -421,11 +426,17 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
>         return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
>
> +static unsigned int
> +imx6_pcie_pciphy_rcr_offset(const struct imx6_pcie *imx6_pcie)
> +{
> +       WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ);
> +       return imx6_pcie->controller_id == 1 ? 0x48 : 0x2C;
> +}
> +
>  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>  {
>         struct dw_pcie *pci = imx6_pcie->pci;
>         struct device *dev = pci->dev;
> -       unsigned int offset;
>         int ret = 0;
>
>         switch (imx6_pcie->drvdata->variant) {
> @@ -463,17 +474,19 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
>                         break;
>                 }
>
> -               offset = imx6_pcie_grp_offset(imx6_pcie);
> -               /*
> -                * Set the over ride low and enabled
> -                * make sure that REF_CLK is turned on.
> -                */
> -               regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> -                                  IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> -                                  0);
> -               regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> -                                  IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> -                                  IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> +               if (!imx6_pcie->supports_clkreq) {
> +                       unsigned int offset = imx6_pcie_grp_offset(imx6_pcie);
> +                       /*
> +                        * Set the over ride low and enabled
> +                        * make sure that REF_CLK is turned on.
> +                        */
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +                                          IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> +                                          0);
> +                       regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
> +                                        IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +                                        IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> +               }

Ugh, I just realized all of my testing was implicitly relying on
bootloader configuring those CLKREQ overrides bits, so all of the code
related to in in this patch is bogus and broken. Glad it didn't get
applied. Will submit corrected v2 once I work out the right way to do
this.

>                 break;
>         }
>
> @@ -547,6 +560,27 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
>         switch (imx6_pcie->drvdata->variant) {
>         case IMX8MQ:
>                 reset_control_deassert(imx6_pcie->pciephy_reset);
> +               if (imx6_pcie->supports_clkreq) {
> +                       u32 lcr;
> +
> +                       regmap_update_bits(imx6_pcie->src,
> +                               imx6_pcie_pciphy_rcr_offset(imx6_pcie),
> +                               IMX8MQ_PCIE_CTRL_APPS_CLK_REQ,
> +                               IMX8MQ_PCIE_CTRL_APPS_CLK_REQ);
> +                       /*
> +                        * Configure the L1 latency of rc to less than
> +                        * 64us Otherwise, the L1/L1SUB wouldn't be
> +                        * enable by ASPM.
> +                        */
> +                       dw_pcie_dbi_ro_wr_en(pci);
> +
> +                       lcr  = dw_pcie_readl_dbi2(pci, PCIE_RC_LCR);
> +                       lcr &= ~PCI_EXP_LNKCAP_L1EL;
> +                       lcr |= IMX8MQ_PCIE_LINK_CAP_L1EL_64US;
> +                       dw_pcie_writel_dbi2(pci, PCIE_RC_LCR, lcr);
> +
> +                       dw_pcie_dbi_ro_wr_dis(pci);
> +               }
>                 break;
>         case IMX7D:
>                 reset_control_deassert(imx6_pcie->pciephy_reset);
> @@ -1054,6 +1088,11 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>         pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
>         if (IS_ERR(pci->dbi_base))
>                 return PTR_ERR(pci->dbi_base);
> +       /*
> +        * Configure dbi_base2 to access DBI space with CS2
> +        * asserted
> +        */
> +       pci->dbi_base2 = pci->dbi_base + SZ_1M;
>
>         /* Fetch GPIOs */
>         imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
> @@ -1107,6 +1146,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>                         dev_err(dev, "pcie_aux clock source missing or invalid\n");
>                         return PTR_ERR(imx6_pcie->pcie_aux);
>                 }
> +               imx6_pcie->src =
> +                       syscon_regmap_lookup_by_compatible("fsl,imx8mq-src");
> +               if (IS_ERR(imx6_pcie->src)) {
> +                       dev_err(dev, "SRC regmap is missing or invalid\n");
> +                       return PTR_ERR(imx6_pcie->src);
> +               }
> +
>                 /* fall through */
>         case IMX7D:
>                 if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
> @@ -1179,6 +1225,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
>                 imx6_pcie->vpcie = NULL;
>         }
>
> +       imx6_pcie->supports_clkreq = of_property_read_bool(node,
> +                                                          "supports-clkreq");
>         platform_set_drvdata(pdev, imx6_pcie);
>
>         ret = imx6_pcie_attach_pd(dev);
> --
> 2.21.0
