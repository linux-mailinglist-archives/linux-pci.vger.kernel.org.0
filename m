Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A5F7566B6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGQOpe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 10:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGQOpd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 10:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1CDB2;
        Mon, 17 Jul 2023 07:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789ED610D5;
        Mon, 17 Jul 2023 14:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5985C433CA;
        Mon, 17 Jul 2023 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689605129;
        bh=6Lh/okJ/tlTuqTU1b/j/uErvTDrdoSJQUHuVEAFETts=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DXcRR896EnZnRLJNO/6oE3vS17JskNmeBySR1a8GBnSZMpK8R09u2GHreDf2c0Dzo
         JLenvfB83kOgsDGMpX/l4sKSoMCJTkDOcZ1AMcrisUwBT45Hqkbl+XlzoIQD7J44xp
         BYFUcjgFWWPES+2nt7thJ9TOtx9ok3veYqLmGXwpUvNrkKD9uUi4kuNmjRjO8kvSv/
         Q22oXxhN3DW4SMHsd2yGH263wD6ee7T8xcq/guGZp7OF4Df7SJdXBFCdPf5RkCCV/3
         AAiKiz+alTYz/OnLZ5fgffEXHxAlU+vg0JkRSCtx7kTfPpi4mi5LtNw9VoqrLwYgPv
         lh5ICjbnogAkg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b70bfc8db5so68132651fa.2;
        Mon, 17 Jul 2023 07:45:29 -0700 (PDT)
X-Gm-Message-State: ABy/qLbQxh1H3IGPgKmzeioCvLaadaaCJVxLnXr8a0wh6eB6mMSIZdGn
        pYVMLqKmP76XUPR9BfVt2AaGsNqQw4sflJEr+w==
X-Google-Smtp-Source: APBJJlFFXYcLka0U2O/B1evPE/8dIeXS+VuPwNFdjWy1LSj2t3dI5YnbEtEP8rRsNBtPkvMxm/lDG3mrsq/u8ZWdw1Y=
X-Received: by 2002:a2e:9d84:0:b0:2b6:e76b:1e50 with SMTP id
 c4-20020a2e9d84000000b002b6e76b1e50mr9074981ljj.41.1689605127886; Mon, 17 Jul
 2023 07:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615164113.2270698-1-Frank.Li@nxp.com> <20230615164113.2270698-2-Frank.Li@nxp.com>
In-Reply-To: <20230615164113.2270698-2-Frank.Li@nxp.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 08:45:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL7o5ipaBkNRECkWZPZDTB1kSFrUV3YjKL6xj02f0x2Sw@mail.gmail.com>
Message-ID: <CAL_JsqL7o5ipaBkNRECkWZPZDTB1kSFrUV3YjKL6xj02f0x2Sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: layerscape: Add the workaround for lost link
 capablities during reset
To:     Frank Li <Frank.Li@nxp.com>
Cc:     mani@kernel.org, Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 15, 2023 at 10:41=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Xiaowei Bao <xiaowei.bao@nxp.com>
>
> A workaround for the issue where the PCI Express Endpoint (EP) controller
> loses the values of the Maximum Link Width and Supported Link Speed from
> the Link Capabilities Register, which initially configured by the Reset
> Configuration Word (RCW) during a link-down or hot reset event.

What makes this Layerscape specific? Seems like something internal to DWC.

>
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci=
/controller/dwc/pci-layerscape-ep.c
> index 4e4fdd1dfea7..2ef02d827eeb 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -45,6 +45,7 @@ struct ls_pcie_ep {
>         struct pci_epc_features         *ls_epc;
>         const struct ls_pcie_ep_drvdata *drvdata;
>         int                             irq;
> +       u32                             lnkcap;
>         bool                            big_endian;
>  };
>
> @@ -73,6 +74,7 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, vo=
id *dev_id)
>         struct ls_pcie_ep *pcie =3D dev_id;
>         struct dw_pcie *pci =3D pcie->pci;
>         u32 val, cfg;
> +       u8 offset;
>
>         val =3D ls_lut_readl(pcie, PEX_PF0_PME_MES_DR);
>         ls_lut_writel(pcie, PEX_PF0_PME_MES_DR, val);
> @@ -81,6 +83,13 @@ static irqreturn_t ls_pcie_ep_event_handler(int irq, v=
oid *dev_id)
>                 return IRQ_NONE;
>
>         if (val & PEX_PF0_PME_MES_DR_LUD) {
> +
> +               offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +               dw_pcie_dbi_ro_wr_en(pci);
> +               dw_pcie_writew_dbi(pci, offset + PCI_EXP_LNKCAP, pcie->ln=
kcap);
> +               dw_pcie_dbi_ro_wr_dis(pci);
> +
>                 cfg =3D ls_lut_readl(pcie, PEX_PF0_CONFIG);
>                 cfg |=3D PEX_PF0_CFG_READY;
>                 ls_lut_writel(pcie, PEX_PF0_CONFIG, cfg);
> @@ -216,6 +225,7 @@ static int __init ls_pcie_ep_probe(struct platform_de=
vice *pdev)
>         struct ls_pcie_ep *pcie;
>         struct pci_epc_features *ls_epc;
>         struct resource *dbi_base;
> +       u8 offset;
>         int ret;
>
>         pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> @@ -252,6 +262,9 @@ static int __init ls_pcie_ep_probe(struct platform_de=
vice *pdev)
>
>         platform_set_drvdata(pdev, pcie);
>
> +       offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +       pcie->lnkcap =3D dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
> +
>         ret =3D dw_pcie_ep_init(&pci->ep);
>         if (ret)
>                 return ret;
> --
> 2.34.1
>
