Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47114AD707
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359473AbiBHLbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 06:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356096AbiBHKJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 05:09:53 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13CC03FEC0;
        Tue,  8 Feb 2022 02:09:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u18so36010057edt.6;
        Tue, 08 Feb 2022 02:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6I/rjvse3Om/FLStiyJ4zPHHDV5qURCXK6IN/dDjA2Y=;
        b=OYMgQRtALhGTq0ZaHfcxxyRrbOb5s3iySIWCA/41PPc2smh+40ANGf02xr7BdvKXXb
         9AeaYlj9rC7eC/amw02RLD0FBYilOZDTW6C18E6/HzUinOMBfe5bN+nkveyL1CyKG+lR
         NUXzjEMWQU3+xBDw7ApVQ2V+jpdW+uibiTerLaLHSXEz/MwhCA7pkdwKgLUmOAIk2bpU
         J2BEWUPXCp0C6n/FMqvrh2JTkWJWyN2xL8Si+TBcYXmPTcUv1RUpGnFKL1zzSx2n5SS8
         /JyKLnHvesc0AZ2Ndx4q6HyoWlKoWWL/TswFPEyglorBm/5ZomuMIiWZVBDDFCpHb1An
         C2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I/rjvse3Om/FLStiyJ4zPHHDV5qURCXK6IN/dDjA2Y=;
        b=7Po3QKdtE0Buafj58pXdPXoyV4yNCicYTCUZrFwQSga8QYljD+QQ1KeqJ75u/PkKtE
         NjQpL/RDOafpMBIhhHQXRawesCpGh2yHxLZe8FsuuscdaxKSE9ReaH6K9eIvJwLmxOIr
         c3EBH5t9oBYMili1iyiRuocR3MmJQS8Nya78tEnLVGgqsxqHvffmn3LKM08foBsSCCHK
         gtFcuua8+A02iKJK59wdbHvrGBEpekk+NVAMwPS49fK0U5z77l+66w1VxXDwtdtAcjHJ
         iO5O9r9iVJhqgAfjY2bXBFKbe3ogZgPRvk1Gu/Q+J8Xukgypd8itKLzBI85CpCV2iqc/
         oZoQ==
X-Gm-Message-State: AOAM530o3YBbouKKDvb+BS3JGwwhM62AjPjrJ1pqWn+D3BYU1EChUMg2
        amIzJ7G3+L1/fwLgENNanrAE8u/uEhypBklmtHE=
X-Google-Smtp-Source: ABdhPJxPKmtRUfGotwhepo8jmbA/Aggq6CASzSYHu7p78ImQqYjC93TuyPlPIPb3l6JBNgwAmzA4p2tLFIf9PS34qIg=
X-Received: by 2002:aa7:dd0b:: with SMTP id i11mr3621700edv.81.1644314990255;
 Tue, 08 Feb 2022 02:09:50 -0800 (PST)
MIME-Version: 1.0
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com> <1644290735-3797-8-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1644290735-3797-8-git-send-email-hongxing.zhu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 8 Feb 2022 07:09:40 -0300
Message-ID: <CAOMZO5ALthc7zZEYZX2YHam2f3C1RmOr4CHLRjHSip7-44tL6Q@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Richard,

On Tue, Feb 8, 2022 at 12:57 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Since i.MX PCIe doesn't support the hot-plug, and to save power
> consumption as much as possible. Return error and disable the enabled
> clocks and regulators when link is down,.

It is OK to disable clocks and regulators, but I don't think we should
return an error on dw_pcie_wait_for_link() failure.

Please check:

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/imx6&id=f81f095e87715e198471f4653952fe5e3f824874

and

https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?h=pci/imx6&id=886a9c134755

as to why all the dwc PCI drivers should treat dw_pcie_wait_for_link()
uniformly.






>
> Add a new host_exit() callback for i.MX PCIe driver to disable the
> enabled clocks, regulators and so on in the error handling after
> host_init is finished.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 30 ++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e165ad00989c..7a7d9204c6bc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -848,7 +848,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>         /* Start LTSSM. */
>         imx6_pcie_ltssm_enable(dev);
>
> -       dw_pcie_wait_for_link(pci);
> +       ret = dw_pcie_wait_for_link(pci);
> +       if (ret)
> +               goto err_reset_phy;
>
>         if (pci->link_gen == 2) {
>                 /* Allow Gen2 mode after the link is up. */
> @@ -884,7 +886,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>                 }
>
>                 /* Make sure link training is finished as well! */
> -               dw_pcie_wait_for_link(pci);
> +               ret = dw_pcie_wait_for_link(pci);
> +               if (ret)
> +                       goto err_reset_phy;
>         } else {
>                 dev_info(dev, "Link: Gen2 disabled\n");
>         }
> @@ -897,7 +901,6 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
>         dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
>                 dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
>                 dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
> -       imx6_pcie_reset_phy(imx6_pcie);
>         return ret;
>  }
>
> @@ -921,8 +924,29 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
>         return 0;
>  }
>
> +static void imx6_pcie_host_exit(struct pcie_port *pp)
> +{
> +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +       struct device *dev = pci->dev;
> +       struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
> +
> +       imx6_pcie_reset_phy(imx6_pcie);
> +       imx6_pcie_clk_disable(imx6_pcie);
> +       switch (imx6_pcie->drvdata->variant) {
> +       case IMX8MM:
> +               if (phy_power_off(imx6_pcie->phy))
> +                       dev_err(dev, "unable to power off phy\n");
> +               break;
> +       default:
> +               break;
> +       }
> +       if (imx6_pcie->vpcie)
> +               regulator_disable(imx6_pcie->vpcie);
> +}
> +
>  static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
>         .host_init = imx6_pcie_host_init,
> +       .host_exit = imx6_pcie_host_exit,
>  };
>
>  static const struct dw_pcie_ops dw_pcie_ops = {
> --
> 2.25.1
>
