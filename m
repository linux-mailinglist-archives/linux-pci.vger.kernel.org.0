Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEEE356CFC
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 15:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbhDGNMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 09:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233153AbhDGNMF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 09:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEDDF61394;
        Wed,  7 Apr 2021 13:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617801112;
        bh=eeopD4HuNWjJ1ys1W14ZKAy3+7M0vO3sMwIst/bVzEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gAL8/wYBTmNHf1JDpM1xLSelNUqoT12/o3dYm+4Rotz3rSyTeyTVOm3F+Ihbs8BUa
         4yFSSyKHPBjwG/bc6+WipZ5mPsFGKPmkkcS/9A5Aw79/5XXxv7ujeiCmxA3SUxLaN4
         4Zyy2HM2BBS7GG6sq/T+9I5pwJI8TciC2kKybRFAPcJIb4AEeczTjNbkQk4GWjwkyj
         tSrqevNaAC04wnq7lg+nF31YSAGOxeMcNC43296VYszAzbnh6TJZN9twwhhzF2ZsRv
         rS302TP2iNU6dRKFTON1Ec+EzfzEYgPW5TYMldE0LQb+RvFjbTr5ZkO398JEDIVxS4
         2FZs/rDPaUx1g==
Received: by mail-ej1-f41.google.com with SMTP id b7so27623059ejv.1;
        Wed, 07 Apr 2021 06:11:51 -0700 (PDT)
X-Gm-Message-State: AOAM532gAx6c/yG9gF2Gnzo0M1UHXlkFJwqpIlhzK6wjJ+FkoI+APWxo
        zZP6iJ4hUzL6jnZuDC6xzj3Q6c2psriHeFalgA==
X-Google-Smtp-Source: ABdhPJzrdSeOkw1OZanx3JvG8ZVkzpr5V2EM7ddV32iGHwYMKmtfZt7YdCiCrqX3uiUINZPHVMITXfiEJHlJRGd+UY4=
X-Received: by 2002:a17:906:7806:: with SMTP id u6mr3450858ejm.130.1617801110063;
 Wed, 07 Apr 2021 06:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210129094003.18102-1-Zhiqiang.Hou@nxp.com> <CAL_JsqLk7Gr1cMTZU+jASvx=sLK0UihYhEbnEw=Ok5vj8F7YTQ@mail.gmail.com>
 <HE1PR0402MB3371180444018B74FB1C340784759@HE1PR0402MB3371.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0402MB3371180444018B74FB1C340784759@HE1PR0402MB3371.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 7 Apr 2021 08:11:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+BGCDyNLNVYSKPc_CqkyAm2_z22RmhEfPaboYuHMAh3g@mail.gmail.com>
Message-ID: <CAL_Jsq+BGCDyNLNVYSKPc_CqkyAm2_z22RmhEfPaboYuHMAh3g@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Change the inheritance between the abstracted structures
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jason Yan <yanaijie@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 7, 2021 at 4:04 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> Hi Rob,
>
> Thanks a lot for the comments!
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2021=E5=B9=B44=E6=9C=887=E6=97=A5 6:00
> > To: Z.q. Hou <zhiqiang.hou@nxp.com>
> > Cc: PCI <linux-pci@vger.kernel.org>; linux-kernel@vger.kernel.org; Lore=
nzo
> > Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Kishon Vijay Abraham I <kishon@ti.com>; Jingoo
> > Han <jingoohan1@gmail.com>; Richard Zhu <hongxing.zhu@nxp.com>;
> > Lucas Stach <l.stach@pengutronix.de>; Murali Karicheri
> > <m-karicheri2@ti.com>; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu
> > <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; Yue Wang
> > <yue.wang@amlogic.com>; Jonathan Chocron <jonnyc@amazon.com>;
> > Thomas Petazzoni <thomas.petazzoni@bootlin.com>; Jesper Nilsson
> > <jesper.nilsson@axis.com>; Gustavo Pimentel
> > <gustavo.pimentel@synopsys.com>; Xiaowei Song
> > <songxiaowei@hisilicon.com>; Binghui Wang <wangbinghui@hisilicon.com>;
> > Stanimir Varbanov <svarbanov@mm-sol.com>; Pratyush Anand
> > <pratyush.anand@gmail.com>; Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com>; Jason Yan <yanaijie@huawei.com>;
> > Thierry Reding <thierry.reding@gmail.com>
> > Subject: Re: [PATCH] PCI: dwc: Change the inheritance between the
> > abstracted structures
> >
> > On Fri, Jan 29, 2021 at 3:32 AM Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
> > wrote:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > Currently the core struct dw_pcie includes both struct pcie_port
> > > and dw_pcie_ep and the RC and EP platform drivers directly
> > > includes the dw_pcie. So it results in a RC or EP platform driver
> > > has 2 indirect parents pcie_port and dw_pcie_ep, but it doesn't
> > > make sense let RC platform driver includes the dw_pcie_ep and
> > > so does the EP platform driver.
> >
> > A less invasive change would be just doing a union:
> >
> >    union {
> >        struct pcie_port        pp;
> >        struct dw_pcie_ep       ep;
> >    };
> >
> > Though I agree reversing how the structs are embedded is more logical.
> [Z.q. Hou]
> Yes, this change involved all the platform drivers, but I think it's wort=
h,
> this change makes the drivers more easy to understand and maintain.
>
> >
> > Ideally, I'd like to see all drivers move to a single alloc using
> > devm_pci_alloc_host_bridge() which takes extra size for a private
> > struct. Currently, every driver has either 2 or 3 allocs. The first
> > step I think is getting rid of the 3rd alloc by embedding the DWC
> > struct into the platform specific struct rather than having a pointer
> > to the DWC struct.
>
> Yes, agree it's the direction we are stepping to and it doesn't conflict
> with this change.

I'm not convinced of that. If anything we're changing the same code twice.

> > > This patch makes the struct pcie_port and dw_pcie_ep includes
> > > the core struct dw_pcie and the RC and EP platform drivers
> > > include struct pcie_port and dw_pcie_ep respectively.
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: Jingoo Han <jingoohan1@gmail.com>
> > > Cc: Richard Zhu <hongxing.zhu@nxp.com>
> > > Cc: Lucas Stach <l.stach@pengutronix.de>
> > > Cc: Murali Karicheri <m-karicheri2@ti.com>
> > > Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> > > Cc: Mingkai Hu <mingkai.hu@nxp.com>
> > > Cc: Roy Zang <roy.zang@nxp.com>
> > > Cc: Yue Wang <yue.wang@Amlogic.com>
> > > Cc: Jonathan Chocron <jonnyc@amazon.com>
> > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> > > Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > > Cc: Xiaowei Song <songxiaowei@hisilicon.com>
> > > Cc: Binghui Wang <wangbinghui@hisilicon.com>
> > > Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> > > Cc: Pratyush Anand <pratyush.anand@gmail.com>
> > > Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > Cc: Jason Yan <yanaijie@huawei.com>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>
> > > ---
> > >  drivers/pci/controller/dwc/pci-dra7xx.c       |  74 +++++---
> > >  drivers/pci/controller/dwc/pci-exynos.c       |  26 +--
> > >  drivers/pci/controller/dwc/pci-imx6.c         |  46 +++--
> > >  drivers/pci/controller/dwc/pci-keystone.c     |  79 +++++---
> > >  .../pci/controller/dwc/pci-layerscape-ep.c    |  18 +-
> > >  drivers/pci/controller/dwc/pci-layerscape.c   |  51 +++---
> > >  drivers/pci/controller/dwc/pci-meson.c        |  25 +--
> > >  drivers/pci/controller/dwc/pcie-al.c          |  21 ++-
> > >  drivers/pci/controller/dwc/pcie-armada8k.c    |  17 +-
> > >  drivers/pci/controller/dwc/pcie-artpec6.c     |  74 +++++---
> > >  .../pci/controller/dwc/pcie-designware-host.c |   2 +-
> > >  .../pci/controller/dwc/pcie-designware-plat.c |  38 ++--
> > >  drivers/pci/controller/dwc/pcie-designware.h  |  72 ++++----
> > >  drivers/pci/controller/dwc/pcie-histb.c       |  27 +--
> > >  drivers/pci/controller/dwc/pcie-intel-gw.c    |  42 +++--
> > >  drivers/pci/controller/dwc/pcie-kirin.c       |  42 +++--
> > >  drivers/pci/controller/dwc/pcie-qcom.c        |  40 ++---
> > >  drivers/pci/controller/dwc/pcie-spear13xx.c   |  16 +-
> > >  drivers/pci/controller/dwc/pcie-tegra194.c    | 169
> > +++++++++++-------
> > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |  14 +-
> > >  drivers/pci/controller/dwc/pcie-uniphier.c    |  17 +-
> > >  21 files changed, 557 insertions(+), 353 deletions(-)
> >
> > What exactly have we improved with 200 more lines?
>
> No performance improvement, but corrected the cluttered inheritance logic=
.

I prefer the 200 fewer lines and the current structure. So you had
better make the diffstat more appealing.

> > > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c
> > b/drivers/pci/controller/dwc/pci-dra7xx.c
> > > index 12726c63366f..0e914df6eaba 100644
> > > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > > @@ -85,7 +85,8 @@
> > >  #define PCIE_B0_B1_TSYNCEN                             BIT(0)
> > >
> > >  struct dra7xx_pcie {
> > > -       struct dw_pcie          *pci;
> > > +       struct pcie_port        *pp;
> > > +       struct dw_pcie_ep       *ep;
> >
> > It's better to keep struct dw_pcie ptr here because we can easily get
> > pp or ep from it.
>
> With this patch, I want to change all the RC and EP platform drivers use =
the 'struct pcie_port'
> and 'struct dw_pcie_ep' respectively instead of embedded the core 'struct=
 dw_pcie'.
> As this driver is for both RC and EP mode, and they are using the same pr=
ivate
> 'struct dra7xx_pcie', so the 'struct pcie_port *pp' and 'struct dw_pcie_e=
p *ep' are both
> put into the private struct and they are used by the corresponding driver=
.
>
>
> >
> > >         void __iomem            *base;          /* DT ti_conf */
> > >         int                     phy_count;      /* DT phy-names
> > count */
> > >         struct phy              **phy;
> > > @@ -290,11 +291,19 @@ static void dra7xx_pcie_msi_irq_handler(struct
> > irq_desc *desc)
> > >  static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
> > >  {
> > >         struct dra7xx_pcie *dra7xx =3D arg;
> > > -       struct dw_pcie *pci =3D dra7xx->pci;
> > > -       struct device *dev =3D pci->dev;
> > > -       struct dw_pcie_ep *ep =3D &pci->ep;
> > > +       struct dw_pcie_ep *ep;
> > > +       struct dw_pcie *pci;
> > > +       struct device *dev;
> > >         u32 reg;
> > >
> > > +       if (dra7xx->mode =3D=3D DW_PCIE_RC_TYPE) {
> > > +               pci =3D to_dw_pcie_from_pp(dra7xx->pp);
> > > +       } else {
> > > +               ep =3D dra7xx->ep;
> > > +               pci =3D to_dw_pcie_from_ep(ep);
> > > +       }
> >
> > This is not a good pattern...
>
> Will change to the 'switch (mode) {...}' in next version.

No! Even worse. Given the function needs struct dw_pcie, it should be
able to get it without having to check the mode. We could before, so
this is a step backwards.

Also, dra7xx->mode is something I plan to move into struct dw_pcie
because it's duplicated across drivers. And this change just makes
doing that harder.


> > > @@ -105,11 +105,12 @@ static void histb_pcie_dbi_r_mode(struct
> > pcie_port *pp, bool enable)
> > >  static u32 histb_pcie_read_dbi(struct dw_pcie *pci, void __iomem *ba=
se,
> > >                                u32 reg, size_t size)
> > >  {
> > > +       struct histb_pcie *hipcie =3D to_histb_pcie(pci);
> > >         u32 val;
> > >
> > > -       histb_pcie_dbi_r_mode(&pci->pp, true);
> > > +       histb_pcie_dbi_r_mode(hipcie->pp, true);
> >
> > DBI access really has nothing to do with RC or EP mode, so this
> > function should probably take a struct dw_pcie *.
>
> Agree, it can be improved but this patch is not intend to change the plat=
form driver
> internal operations.

IMO, you should before doing this change. That's how you'll make the
diffstat more appealing.

> > >         dw_pcie_read(base + reg, size, &val);
> > > -       histb_pcie_dbi_r_mode(&pci->pp, false);
> > > +       histb_pcie_dbi_r_mode(hipcie->pp, false);
> > >
> > >         return val;
> > >  }
