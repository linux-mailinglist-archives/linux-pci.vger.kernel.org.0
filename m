Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906046C3A45
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 20:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCUTUU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 15:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUTUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 15:20:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843802A990;
        Tue, 21 Mar 2023 12:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1EA8B8197B;
        Tue, 21 Mar 2023 19:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E8AC433D2;
        Tue, 21 Mar 2023 19:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679426378;
        bh=fokQFCcGEjTKHVOnKS2r59adxdabwlzu7buQyS9QEQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r6C4wN8aX/5/D6NqATJe5i//siaLxPW3jM1aoRCV4BDZGOzrzdxarM/C+A4HHXWhF
         KgtvDlERJ+rAXCin4zXs0+xqx+6yiTh+94AasKOrdpIBobFF1BnRTgnc9oU6HTgGQX
         FB4Q60SfYYq/pkS202AnteZ8kSaoMU9ZG7+6cCROcIQNQWlVNJ/qP3I4wPrBiZPuqO
         x9x2BA1AoFBXThSUekIcEyZXOzORo8YtXbQub551FqB3NRqiOQD3IXj9oR2aMuzuLF
         lqzrWAgQ0Gp/jNHRFjoB6+Aul2G32OvT+9IOipulNuqaVm3uOMMdOVjv73DmYm3azP
         HDfdOVrT0QUJw==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5416698e889so298175657b3.2;
        Tue, 21 Mar 2023 12:19:38 -0700 (PDT)
X-Gm-Message-State: AAQBX9e70aDZH1gKrulkLChm0o6CaBMyeJlTl5/rO53Bd04EYlU9Qi24
        T2qNF+iJrLRyp65KvB9x5rI1d0Via4uwzfU3lw==
X-Google-Smtp-Source: AKy350auLbvsTaEY90S+/uSdhiF4Pr/+ML10MRVWJ/g6N+SK2M2eI1KXes7bz5zQnfSPVM8Ou6Ko5vxhCt1Hnh/93eQ=
X-Received: by 2002:a81:7e4a:0:b0:533:99bb:c296 with SMTP id
 p10-20020a817e4a000000b0053399bbc296mr1720735ywn.5.1679426377094; Tue, 21 Mar
 2023 12:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230321160220.2785909-1-Frank.Li@nxp.com>
In-Reply-To: <20230321160220.2785909-1-Frank.Li@nxp.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 21 Mar 2023 14:19:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLVSWuoexY+pE5K5bKPz7j1GZugcc5cD73sJW5cEipphQ@mail.gmail.com>
Message-ID: <CAL_JsqLVSWuoexY+pE5K5bKPz7j1GZugcc5cD73sJW5cEipphQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: layerscape: Add power management support
To:     Frank Li <Frank.Li@nxp.com>
Cc:     bhelgaas@google.com, leoyang.li@nxp.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, gustavo.pimentel@synopsys.com,
        helgaas@kernel.org, kw@linux.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 21, 2023 at 11:02=E2=80=AFAM Frank Li <Frank.Li@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add PME_Turn_Off/PME_TO_Ack handshake sequence to PCIe devices, such as
> NVME or wifi module, and finally put the PCIe controller into D3 state
> after the L2/L3 ready state transition process completion.
>
> However, it's important to note that not all devices may be able to
> tolerate the PME_Turn_Off command. In general, fixed PCIe devices
> connected to Layerscape, such as NXP wifi devices, are able to handle
> this command.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - fixed Bjorn Helgaas's comments
> - remove ls1043 and ls1021, which PME is not self cleaned. After check
> spec, there are PME interrupt to indicate PEM_TO_ACK command. but I
> have not these platform to debug it.  I just can test ls1028 platform
> now.
>
>  drivers/pci/controller/dwc/pci-layerscape.c  | 219 ++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h |   1 +
>  2 files changed, 211 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/co=
ntroller/dwc/pci-layerscape.c
> index ed5fb492fe08..5fbc9151ff82 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -8,9 +8,11 @@
>   * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
>   */
>
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
> +#include <linux/iopoll.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> @@ -29,10 +31,40 @@
>
>  #define PCIE_IATU_NUM          6
>
> +/* PF Message Command Register */
> +#define LS_PCIE_PF_MCR         0x2c
> +#define PF_MCR_PTOMR           BIT(0)
> +#define PF_MCR_EXL2S           BIT(1)
> +
> +#define LS_PCIE_IS_L2(v)       \
> +       (((v) & PORT_LOGIC_LTSSM_STATE_MASK) =3D=3D PORT_LOGIC_LTSSM_STAT=
E_L2)
> +
> +struct ls_pcie;
> +
> +struct ls_pcie_host_pm_ops {
> +       int (*pm_init)(struct ls_pcie *pcie);
> +       void (*send_turn_off_message)(struct ls_pcie *pcie);
> +       void (*exit_from_l2)(struct ls_pcie *pcie);
> +};

Please don't create your own private layer of ops. Especially since
there is only 1 implementation.

Almost every driver has some function to set LTSSM states. Usually
that's in .start_link(). We probably need some more general DWC op
function control this.

> +
> +struct ls_pcie_drvdata {
> +       const u32 pf_off;
> +       const u32 lut_off;
> +       const struct ls_pcie_host_pm_ops *pm_ops;
> +};
> +
>  struct ls_pcie {
>         struct dw_pcie *pci;
> +       const struct ls_pcie_drvdata *drvdata;
> +       void __iomem *pf_base;
> +       void __iomem *lut_base;
> +       bool big_endian;
> +       bool pm_support;
> +       struct regmap *scfg;
> +       int index;
>  };
>
> +#define ls_pcie_pf_readl_addr(addr)    ls_pcie_pf_readl(pcie, addr)
>  #define to_ls_pcie(x)  dev_get_drvdata((x)->dev)
>
>  static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
> @@ -73,6 +105,69 @@ static void ls_pcie_fix_error_response(struct ls_pcie=
 *pcie)
>         iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
>  }
>
> +static u32 ls_pcie_pf_readl(struct ls_pcie *pcie, u32 off)
> +{
> +       if (pcie->big_endian)

You set 'big-endian' for the node, but it's only these PF registers
that are big endian?

> +               return ioread32be(pcie->pf_base + off);
> +
> +       return ioread32(pcie->pf_base + off);
> +}
> +
> +static void ls_pcie_pf_writel(struct ls_pcie *pcie, u32 off, u32 val)
> +{
> +       if (pcie->big_endian)
> +               return iowrite32be(val, pcie->pf_base + off);
> +
> +       return iowrite32(val, pcie->pf_base + off);
> +}
> +
> +static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
> +{
> +       u32 val;
> +       int ret;
> +
> +       val =3D ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +       val |=3D PF_MCR_PTOMR;
> +       ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +
> +       ret =3D readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +                                val, !(val & PF_MCR_PTOMR), 100, 10000);
> +       if (ret)
> +               dev_warn(pcie->pci->dev, "poll turn off message timeout\n=
");
> +}
> +
> +static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
> +{
> +       u32 val;
> +       int ret;
> +
> +       val =3D ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
> +       val |=3D PF_MCR_EXL2S;
> +       ls_pcie_pf_writel(pcie, LS_PCIE_PF_MCR, val);
> +
> +       ret =3D readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
> +                                val, !(val & PF_MCR_EXL2S), 100, 10000);
> +       if (ret)
> +               dev_warn(pcie->pci->dev, "poll exit L2 state timeout\n");
> +}
> +
> +static int ls_pcie_pm_init(struct ls_pcie *pcie)
> +{
> +       return 0;
> +}
> +
> +static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
> +{
> +       struct dw_pcie *pci =3D pcie->pci;
> +       u8 offset =3D dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
> +       u32 val;
> +
> +       val =3D dw_pcie_readw_dbi(pci, offset + PCI_PM_CTRL);
> +       val &=3D ~PCI_PM_CTRL_STATE_MASK;
> +       val |=3D dstate;
> +       dw_pcie_writew_dbi(pci, offset + PCI_PM_CTRL, val);
> +}
> +
>  static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>         struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> @@ -86,23 +181,46 @@ static int ls_pcie_host_init(struct dw_pcie_rp *pp)
>
>         ls_pcie_drop_msg_tlp(pcie);
>
> +       if (pcie->drvdata->pm_ops && pcie->drvdata->pm_ops->pm_init &&
> +           !pcie->drvdata->pm_ops->pm_init(pcie))
> +               pcie->pm_support =3D true;

Just define 'pm_support' in the match data.

> +
>         return 0;
>  }
>
> +static struct ls_pcie_host_pm_ops ls_pcie_host_pm_ops =3D {
> +       .pm_init =3D &ls_pcie_pm_init,
> +       .send_turn_off_message =3D &ls_pcie_send_turnoff_msg,
> +       .exit_from_l2 =3D &ls_pcie_exit_from_l2,
> +};
> +
>  static const struct dw_pcie_host_ops ls_pcie_host_ops =3D {
>         .host_init =3D ls_pcie_host_init,
>  };
>
> +static const struct ls_pcie_drvdata ls1021a_drvdata =3D {
> +};
> +
> +static const struct ls_pcie_drvdata ls1043a_drvdata =3D {
> +       .lut_off =3D 0x10000,
> +};
> +
> +static const struct ls_pcie_drvdata layerscape_drvdata =3D {
> +       .lut_off =3D 0x80000,
> +       .pf_off =3D 0xc0000,
> +       .pm_ops =3D &ls_pcie_host_pm_ops,
> +};
> +
>  static const struct of_device_id ls_pcie_of_match[] =3D {
> -       { .compatible =3D "fsl,ls1012a-pcie", },
> -       { .compatible =3D "fsl,ls1021a-pcie", },
> -       { .compatible =3D "fsl,ls1028a-pcie", },
> -       { .compatible =3D "fsl,ls1043a-pcie", },
> -       { .compatible =3D "fsl,ls1046a-pcie", },
> -       { .compatible =3D "fsl,ls2080a-pcie", },
> -       { .compatible =3D "fsl,ls2085a-pcie", },
> -       { .compatible =3D "fsl,ls2088a-pcie", },
> -       { .compatible =3D "fsl,ls1088a-pcie", },
> +       { .compatible =3D "fsl,ls1012a-pcie", .data =3D &layerscape_drvda=
ta },
> +       { .compatible =3D "fsl,ls1021a-pcie", .data =3D &ls1021a_drvdata =
},
> +       { .compatible =3D "fsl,ls1028a-pcie", .data =3D &layerscape_drvda=
ta },
> +       { .compatible =3D "fsl,ls1043a-pcie", .data =3D &ls1043a_drvdata =
},
> +       { .compatible =3D "fsl,ls1046a-pcie", .data =3D &layerscape_drvda=
ta },
> +       { .compatible =3D "fsl,ls2080a-pcie", .data =3D &layerscape_drvda=
ta },
> +       { .compatible =3D "fsl,ls2085a-pcie", .data =3D &layerscape_drvda=
ta },
> +       { .compatible =3D "fsl,ls2088a-pcie", .data =3D &layerscape_drvda=
ta },
> +       { .compatible =3D "fsl,ls1088a-pcie", .data =3D &layerscape_drvda=
ta },
>         { },
>  };
>
> @@ -121,6 +239,8 @@ static int ls_pcie_probe(struct platform_device *pdev=
)
>         if (!pci)
>                 return -ENOMEM;
>
> +       pcie->drvdata =3D of_device_get_match_data(dev);
> +
>         pci->dev =3D dev;
>         pci->pp.ops =3D &ls_pcie_host_ops;
>
> @@ -131,6 +251,14 @@ static int ls_pcie_probe(struct platform_device *pde=
v)
>         if (IS_ERR(pci->dbi_base))
>                 return PTR_ERR(pci->dbi_base);
>
> +       pcie->big_endian =3D of_property_read_bool(dev->of_node, "big-end=
ian");
> +
> +       if (pcie->drvdata->lut_off)
> +               pcie->lut_base =3D pci->dbi_base + pcie->drvdata->lut_off=
;
> +
> +       if (pcie->drvdata->pf_off)
> +               pcie->pf_base =3D pci->dbi_base + pcie->drvdata->pf_off;
> +
>         if (!ls_pcie_is_bridge(pcie))
>                 return -ENODEV;
>
> @@ -139,12 +267,85 @@ static int ls_pcie_probe(struct platform_device *pd=
ev)
>         return dw_pcie_host_init(&pci->pp);
>  }
>
> +static bool ls_pcie_pm_supported(struct ls_pcie *pcie)
> +{
> +       if (!dw_pcie_link_up(pcie->pci)) {
> +               dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
> +               return false;
> +       }
> +
> +       return pcie->pm_support;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ls_pcie_suspend_noirq(struct device *dev)
> +{
> +       struct ls_pcie *pcie =3D dev_get_drvdata(dev);
> +       struct dw_pcie *pci =3D pcie->pci;
> +       u32 val;
> +       int ret;
> +
> +       if (!ls_pcie_pm_supported(pcie))
> +               return 0;
> +
> +       pcie->drvdata->pm_ops->send_turn_off_message(pcie);
> +
> +       /* 10ms timeout to check L2 ready */
> +       ret =3D readl_poll_timeout(pci->dbi_base + PCIE_PORT_DEBUG0,
> +                                val, LS_PCIE_IS_L2(val), 100, 10000);
> +       if (ret) {
> +               dev_err(dev, "PCIe link enter L2 timeout! ltssm =3D 0x%x\=
n", val);
> +               return ret;
> +       }
> +
> +       ls_pcie_set_dstate(pcie, 0x3);
> +
> +       return 0;
> +}
> +
> +static int ls_pcie_resume_noirq(struct device *dev)
> +{
> +       struct ls_pcie *pcie =3D dev_get_drvdata(dev);
> +       struct dw_pcie *pci =3D pcie->pci;
> +       int ret;
> +
> +       if (!ls_pcie_pm_supported(pcie))
> +               return 0;
> +
> +       ls_pcie_set_dstate(pcie, 0x0);
> +
> +       pcie->drvdata->pm_ops->exit_from_l2(pcie);
> +
> +       ret =3D ls_pcie_host_init(&pci->pp);
> +       if (ret) {
> +               dev_err(dev, "PCIe host init failed! ret =3D 0x%x\n", ret=
);
> +               return ret;
> +       }
> +
> +       dw_pcie_setup_rc(&pci->pp);
> +
> +       ret =3D dw_pcie_wait_for_link(pci);
> +       if (ret) {
> +               dev_err(dev, "Wait link up timeout! ret =3D 0x%x\n", ret)=
;
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops ls_pcie_pm_ops =3D {
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq,
> +                                     ls_pcie_resume_noirq)
> +};
> +
>  static struct platform_driver ls_pcie_driver =3D {
>         .probe =3D ls_pcie_probe,
>         .driver =3D {
>                 .name =3D "layerscape-pcie",
>                 .of_match_table =3D ls_pcie_of_match,
>                 .suppress_bind_attrs =3D true,
> +               .pm =3D &ls_pcie_pm_ops,
>         },
>  };
>  builtin_platform_driver(ls_pcie_driver);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/c=
ontroller/dwc/pcie-designware.h
> index 79713ce075cc..7de8409e2433 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -94,6 +94,7 @@
>  #define PCIE_PORT_DEBUG0               0x728
>  #define PORT_LOGIC_LTSSM_STATE_MASK    0x1f
>  #define PORT_LOGIC_LTSSM_STATE_L0      0x11
> +#define PORT_LOGIC_LTSSM_STATE_L2      0x15
>  #define PCIE_PORT_DEBUG1               0x72C
>  #define PCIE_PORT_DEBUG1_LINK_UP               BIT(4)
>  #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING      BIT(29)
> --
> 2.34.1
>
