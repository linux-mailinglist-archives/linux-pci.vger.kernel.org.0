Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F310A36E97C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Apr 2021 13:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhD2LWb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 07:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2LW3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Apr 2021 07:22:29 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20486C06138B;
        Thu, 29 Apr 2021 04:21:42 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id y2so75909182ybq.13;
        Thu, 29 Apr 2021 04:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8X+3n6kW6TegoVH/aVlbTzmTaEvd5xOqc0zaNyOM6Nc=;
        b=MoQLU0g0B8Wv/VmUJsXNBoeDKpbTwll8bAeAXiF+Q8+FX7aOzTsgJKeUdyVI9fHq00
         AyTpwGmfuqzIX+gP6nNzVu3uFcj8rrRXZuCHGp5ftx7ezCL/xZYIckFkc6XRvFfWCiZg
         ljXbfSeMOggOxpgHc8B1jvLQvNVmRe9efzcZYGk2V8BLUWBbqNSjmhSuGYdxZfN+37YN
         f55DWkb5ZOzZr9RLjszwYyrkIN1oR8R8PWr/Z1q6vcjElksOH25vM0RTeDIQ31xeybs3
         FRQzajE6hpB1V+8ggAW1fDM3f+3b/TdtZalVvMBFfh9j/rv3ALJ84lznyC+fyZRsE4nc
         W2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8X+3n6kW6TegoVH/aVlbTzmTaEvd5xOqc0zaNyOM6Nc=;
        b=US9vqLrZidZl9zKXimtxm+TPQVvtsGubJ53UrfINz86tT5B0c61/QtR+Jqu3zTl8an
         1csi1/tzAQJwlIdoIsPJTDWoPl5Hl1NjtGOEgnN48od2GXEA+ndPRkpomKVYWT37za1Q
         I0dP7M6d/TmnZbD2w19Q0ZwhfOlj4Np8IyRbheuzi3XFNoeDuqUyNgIPadxkFXDQf7/h
         RuEq73ZF0F2WXTai2v081YEEUewEmD5/ZCSWaKu089+EEjGIar8gEDFJKpyjPfEALJRL
         pbFqr2dmvsJeeWvhlDTHIPd0QrFxNTcKw05S9Ll4aaPBoG2KMbu+4ImbofWN5jw15oLd
         NvOw==
X-Gm-Message-State: AOAM532Qq+QBK30cSB7l+yEWcFpknGuMjoZsHL+MS8CXbvfQU6AL6WKF
        tL8FQj5ooklOpFOyYJ+weLmXdUtuCxFcKh284WhR3x8XLKK4YY6y
X-Google-Smtp-Source: ABdhPJzANA4wLpBtfZDRzTOJj+jKjiO46wnSDYgiqnsERHldb30ieCwxHoC1jPFh2ActgL5aR6TuyT5viXDugzrVnW0=
X-Received: by 2002:a25:c6d2:: with SMTP id k201mr42278308ybf.39.1619695301204;
 Thu, 29 Apr 2021 04:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210414070325.924789-1-xxm@rock-chips.com> <CAMdYzYqf3FhYrFR1DGrP=_CbNpq5uB+J-m42Mv=c6Pu71Jcxww@mail.gmail.com>
 <5af0f6f8-bc29-f50e-ca14-94049b7d17ed@rock-chips.com> <CAMdYzYr=i7X22-38VyY-GQLWs+aV+ZcWwO_uDymFxmaNO8SpmA@mail.gmail.com>
 <3bf6f7ba-d5cb-4857-5fa8-bc4fa0b7e5f6@rock-chips.com>
In-Reply-To: <3bf6f7ba-d5cb-4857-5fa8-bc4fa0b7e5f6@rock-chips.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 29 Apr 2021 07:21:29 -0400
Message-ID: <CAMdYzYogHPdqKxKUrNYnubEr5FjFFePGTroEvftnjEL+SMWv3g@mail.gmail.com>
Subject: Re: [PATCH v7] PCI: rockchip: Add Rockchip RK356X host controller driver
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 29, 2021 at 2:32 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> On 2021/4/29 9:42, Peter Geis wrote:
> > On Wed, Apr 28, 2021 at 8:46 PM Shawn Lin <shawn.lin@rock-chips.com> wr=
ote:
> >>
> >> On 2021/4/29 0:20, Peter Geis wrote:
> >>> On Wed, Apr 14, 2021 at 3:05 AM Simon Xue <xxm@rock-chips.com> wrote:
> >>>>
> >>>> Add a driver for the DesignWare-based PCIe controller found on
> >>>> RK356X. The existing pcie-rockchip-host driver is only used for
> >>>> the Rockchip-designed IP found on RK3399.
> >>>
> >>> Good Afternoon,
> >>>
> >>> I've encountered a bit of an issue with this driver.
> >>
> >> I'm sure your issue is GIC ITS support on RK356x platforms, nothing
> >> really related to this driver itself. You can also sort out arm-gic
> >> workaround patch from downstream vendor tree, if you want MSI support.
> >
> > I have functional MSI support, some devices do not support MSIs
> > however and need legacy INTx.
> > I'd like to point out that the downstream patch does not actually work
> > on downstream.
> > The GFP_DMA32 flag is discarded by the slab allocator, this breaks MSI
> > allocation when the PCIe driver probes.
> > I hacked together my own version which works but would definitely not
> > be accepted for submission.
> >
> >>
> >>> Unfortunately it does not support legacy interrupts, meaning any PCIe
> >>> device that doesn't support MSIs will fail to enumerate:
> >>> [   14.932078] pcieport 0000:00:00.0: of_irq_parse_pci: failed with r=
c=3D-22
> >>> [   14.932708] snd_hda_intel 0000:01:00.1: assign IRQ: got 0
> >>> [   14.933687] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0=
002)
> >>> [   14.934317] snd_hda_intel 0000:01:00.1: Disabling MSI
> >>> [   14.934783] snd_hda_intel 0000:01:00.1: Force to snoop mode by mod=
ule option
> >>> [   14.935534] snd_hda_intel 0000:01:00.1: enabling bus mastering
> >>> [   14.939764] snd_hda_intel 0000:01:00.1: unable to grab IRQ 0,
> >>> disabling device
> >>>
> >>> Are there plans to support legacy interrupts with the rk3568 controll=
ers?
> >>
> >> Yes, we did=EF=BC=8Cbut not now.
> >
> > This will significantly limit the devices that can work with the contro=
ller.
> > Is there any functional reason preventing legacy interrupts from workin=
g?
>
> Just because this $subject patch is still in-flight and we are going to
> add it later. Still some features are developed but not ready yet.

I now have partial INTx functionality, but it seems there is no way to
acknowledge the interrupt only mask and unmask them.
Is there a register to acknowledge the legacy interrupts?

>
>
> > I've so far not been successful plugging in support.
> >
> >>
> >> I really don't understand what is blocking this driver from landing
> >> mainline?  I didn't find any comments from maintainers yet since v1. A=
nd
> >> now the driver has been iterating for a long time.I believe Simon has
> >> addressed all the review feedback during v1 to v7. Can we please land
> >> this basic support first. If you can test it with arm-gic workaround,
> >> a tested-by tag would be appreciated.
> >
> > Do you have the DT bindings for this patch available?
>
> Yes we have, and you can also find it from vendor tree.

New drivers should include .yaml documentation files.
Downstream does not have one, and one was not included with this patch.
The designware-pcie.txt doesn't cover vendor specific implementations.

See Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml for example.
>
> >
> > Yes, at this stage what is implemented appears to function correctly, s=
o:
> > Tested-by: Peter Geis <pgwipeout@gmail.com>
> > on the rk3566-quartz64 prototype development board.
>
> Thanks for testing.
>
> >
> > Dependent on the following patches:
> > GICv3-ITS official errata for 32bit limitation and shareability limitat=
ion.
> > Combo-phy support, no patches have been released to mainline yet >
> >>
> >>>
> >>> Thanks,
> >>> Peter Geis
> >>>
> >>>>
> >>>> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> >>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> >>>> ---
> >>>>    drivers/pci/controller/dwc/Kconfig            |  10 +
> >>>>    drivers/pci/controller/dwc/Makefile           |   1 +
> >>>>    drivers/pci/controller/dwc/pcie-dw-rockchip.c | 277 +++++++++++++=
+++++
> >>>>    3 files changed, 288 insertions(+)
> >>>>    create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> >>>>
> >>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/contro=
ller/dwc/Kconfig
> >>>> index 423d35872ce4..8ab027ba8c04 100644
> >>>> --- a/drivers/pci/controller/dwc/Kconfig
> >>>> +++ b/drivers/pci/controller/dwc/Kconfig
> >>>> @@ -214,6 +214,16 @@ config PCIE_ARTPEC6_EP
> >>>>             Enables support for the PCIe controller in the ARTPEC-6 =
SoC to work in
> >>>>             endpoint mode. This uses the DesignWare core.
> >>>>
> >>>> +config PCIE_ROCKCHIP_DW_HOST
> >>>> +       bool "Rockchip DesignWare PCIe controller"
> >>>> +       select PCIE_DW
> >>>> +       select PCIE_DW_HOST
> >>>> +       depends on ARCH_ROCKCHIP || COMPILE_TEST
> >>>> +       depends on OF
> >>>> +       help
> >>>> +         Enables support for the DesignWare PCIe controller in the
> >>>> +         Rockchip SoC except RK3399.
> >>>> +
> >>>>    config PCIE_INTEL_GW
> >>>>           bool "Intel Gateway PCIe host controller support"
> >>>>           depends on OF && (X86 || COMPILE_TEST)
> >>>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/contr=
oller/dwc/Makefile
> >>>> index 952d01941f23..0104659dfe88 100644
> >>>> --- a/drivers/pci/controller/dwc/Makefile
> >>>> +++ b/drivers/pci/controller/dwc/Makefile
> >>>> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) +=3D pci-layerscap=
e-ep.o
> >>>>    obj-$(CONFIG_PCIE_QCOM) +=3D pcie-qcom.o
> >>>>    obj-$(CONFIG_PCIE_ARMADA_8K) +=3D pcie-armada8k.o
> >>>>    obj-$(CONFIG_PCIE_ARTPEC6) +=3D pcie-artpec6.o
> >>>> +obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) +=3D pcie-dw-rockchip.o
> >>>>    obj-$(CONFIG_PCIE_INTEL_GW) +=3D pcie-intel-gw.o
> >>>>    obj-$(CONFIG_PCIE_KIRIN) +=3D pcie-kirin.o
> >>>>    obj-$(CONFIG_PCIE_HISI_STB) +=3D pcie-histb.o
> >>>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers=
/pci/controller/dwc/pcie-dw-rockchip.c
> >>>> new file mode 100644
> >>>> index 000000000000..3f060144eeab
> >>>> --- /dev/null
> >>>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> >>>> @@ -0,0 +1,277 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * PCIe host controller driver for Rockchip SoCs.
> >>>> + *
> >>>> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> >>>> + *             http://www.rock-chips.com
> >>>> + *
> >>>> + * Author: Simon Xue <xxm@rock-chips.com>
> >>>> + */
> >>>> +
> >>>> +#include <linux/clk.h>
> >>>> +#include <linux/gpio/consumer.h>
> >>>> +#include <linux/mfd/syscon.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/of_device.h>
> >>>> +#include <linux/phy/phy.h>
> >>>> +#include <linux/platform_device.h>
> >>>> +#include <linux/regmap.h>
> >>>> +#include <linux/reset.h>
> >>>> +
> >>>> +#include "pcie-designware.h"
> >>>> +
> >>>> +/*
> >>>> + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> >>>> + * mask for the lower 16 bits.
> >>>> + */
> >>>> +#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
> >>>> +#define HIWORD_UPDATE_BIT(val) HIWORD_UPDATE(val, val)
> >>>> +
> >>>> +#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
> >>>> +
> >>>> +#define PCIE_CLIENT_RC_MODE            HIWORD_UPDATE_BIT(0x40)
> >>>> +#define PCIE_CLIENT_ENABLE_LTSSM       HIWORD_UPDATE_BIT(0xc)
> >>>> +#define PCIE_SMLH_LINKUP               BIT(16)
> >>>> +#define PCIE_RDLH_LINKUP               BIT(17)
> >>>> +#define PCIE_LINKUP                    (PCIE_SMLH_LINKUP | PCIE_RDL=
H_LINKUP)
> >>>> +#define PCIE_L0S_ENTRY                 0x11
> >>>> +#define PCIE_CLIENT_GENERAL_CONTROL    0x0
> >>>> +#define PCIE_CLIENT_GENERAL_DEBUG      0x104
> >>>> +#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> >>>> +#define PCIE_CLIENT_LTSSM_STATUS       0x300
> >>>> +#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> >>>> +
> >>>> +struct rockchip_pcie {
> >>>> +       struct dw_pcie                  pci;
> >>>> +       void __iomem                    *apb_base;
> >>>> +       struct phy                      *phy;
> >>>> +       struct clk_bulk_data            *clks;
> >>>> +       unsigned int                    clk_cnt;
> >>>> +       struct reset_control            *rst;
> >>>> +       struct gpio_desc                *rst_gpio;
> >>>> +       struct regulator                *vpcie3v3;
> >>>> +};
> >>>> +
> >>>> +static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> >>>> +                                            u32 reg)
> >>>> +{
> >>>> +       return readl(rockchip->apb_base + reg);
> >>>> +}
> >>>> +
> >>>> +static void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip=
,
> >>>> +                                               u32 val, u32 reg)
> >>>> +{
> >>>> +       writel(val, rockchip->apb_base + reg);
> >>>> +}
> >>>> +
> >>>> +static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockch=
ip)
> >>>> +{
> >>>> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> >>>> +                                PCIE_CLIENT_GENERAL_CONTROL);
> >>>> +}
> >>>> +
> >>>> +static int rockchip_pcie_link_up(struct dw_pcie *pci)
> >>>> +{
> >>>> +       struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> >>>> +       u32 val =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LT=
SSM_STATUS);
> >>>> +
> >>>> +       if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) =3D=3D PCI=
E_LINKUP &&
> >>>> +           (val & GENMASK(5, 0)) =3D=3D PCIE_L0S_ENTRY)
> >>>> +               return 1;
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
> >>>> +{
> >>>> +       struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> >>>> +
> >>>> +       /* Reset device */
> >>>> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> >>>> +
> >>>> +       rockchip_pcie_enable_ltssm(rockchip);
> >>>> +
> >>>> +       /*
> >>>> +        * PCIe requires the refclk to be stable for 100=C2=B5s prio=
r to releasing
> >>>> +        * PERST. See table 2-4 in section 2.6.2 AC Specifications o=
f the PCI
> >>>> +        * Express Card Electromechanical Specification, 1.1. Howeve=
r, we don't
> >>>> +        * know if the refclk is coming from RC's PHY or external OS=
C. If it's
> >>>> +        * from RC, so enabling LTSSM is the just right place to rel=
ease #PERST.
> >>>> +        * We need more extra time as before, rather than setting ju=
st
> >>>> +        * 100us as we don't know how long should the device need to=
 reset.
> >>>> +        */
> >>>> +       msleep(100);
> >>>> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int rockchip_pcie_host_init(struct pcie_port *pp)
> >>>> +{
> >>>> +       struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> >>>> +       struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
> >>>> +       u32 val;
> >>>> +
> >>>> +       /* LTSSM enable control mode */
> >>>> +       val =3D rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RE=
SET_CTRL);
> >>>> +       val |=3D PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHA=
NCE << 16);
> >>>> +       rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESE=
T_CTRL);
> >>>> +
> >>>> +       rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> >>>> +                                PCIE_CLIENT_GENERAL_CONTROL);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops =3D {
> >>>> +       .host_init =3D rockchip_pcie_host_init,
> >>>> +};
> >>>> +
> >>>> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> >>>> +{
> >>>> +       struct device *dev =3D rockchip->pci.dev;
> >>>> +       int ret;
> >>>> +
> >>>> +       ret =3D devm_clk_bulk_get_all(dev, &rockchip->clks);
> >>>> +       if (ret < 0)
> >>>> +               return ret;
> >>>> +
> >>>> +       rockchip->clk_cnt =3D ret;
> >>>> +
> >>>> +       return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->=
clks);
> >>>> +}
> >>>> +
> >>>> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
> >>>> +                                     struct rockchip_pcie *rockchip=
)
> >>>> +{
> >>>> +       rockchip->apb_base =3D devm_platform_ioremap_resource_byname=
(pdev, "apb");
> >>>> +       if (IS_ERR(rockchip->apb_base))
> >>>> +               return PTR_ERR(rockchip->apb_base);
> >>>> +
> >>>> +       rockchip->rst_gpio =3D devm_gpiod_get_optional(&pdev->dev, "=
reset",
> >>>> +                                                    GPIOD_OUT_HIGH)=
;
> >>>> +       if (IS_ERR(rockchip->rst_gpio))
> >>>> +               return PTR_ERR(rockchip->rst_gpio);
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> >>>> +{
> >>>> +       struct device *dev =3D rockchip->pci.dev;
> >>>> +       int ret;
> >>>> +
> >>>> +       rockchip->phy =3D devm_phy_get(dev, "pcie-phy");
> >>>> +       if (IS_ERR(rockchip->phy))
> >>>> +               return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> >>>> +                                    "missing PHY\n");
> >>>> +
> >>>> +       ret =3D phy_init(rockchip->phy);
> >>>> +       if (ret < 0)
> >>>> +               return ret;
> >>>> +
> >>>> +       ret =3D phy_power_on(rockchip->phy);
> >>>> +       if (ret)
> >>>> +               phy_exit(rockchip->phy);
> >>>> +
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip=
)
> >>>> +{
> >>>> +       phy_exit(rockchip->phy);
> >>>> +       phy_power_off(rockchip->phy);
> >>>> +}
> >>>> +
> >>>> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie=
 *rockchip)
> >>>> +{
> >>>> +       struct device *dev =3D rockchip->pci.dev;
> >>>> +
> >>>> +       rockchip->rst =3D devm_reset_control_array_get_exclusive(dev=
);
> >>>> +       if (IS_ERR(rockchip->rst))
> >>>> +               return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> >>>> +                                    "failed to get reset lines\n");
> >>>> +
> >>>> +       return reset_control_deassert(rockchip->rst);
> >>>> +}
> >>>> +
> >>>> +static const struct dw_pcie_ops dw_pcie_ops =3D {
> >>>> +       .link_up =3D rockchip_pcie_link_up,
> >>>> +       .start_link =3D rockchip_pcie_start_link,
> >>>> +};
> >>>> +
> >>>> +static int rockchip_pcie_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +       struct device *dev =3D &pdev->dev;
> >>>> +       struct rockchip_pcie *rockchip;
> >>>> +       struct pcie_port *pp;
> >>>> +       int ret;
> >>>> +
> >>>> +       rockchip =3D devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL=
);
> >>>> +       if (!rockchip)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       platform_set_drvdata(pdev, rockchip);
> >>>> +
> >>>> +       rockchip->pci.dev =3D dev;
> >>>> +       rockchip->pci.ops =3D &dw_pcie_ops;
> >>>> +
> >>>> +       pp =3D &rockchip->pci.pp;
> >>>> +       pp->ops =3D &rockchip_pcie_host_ops;
> >>>> +
> >>>> +       ret =3D rockchip_pcie_resource_get(pdev, rockchip);
> >>>> +       if (ret)
> >>>> +               return ret;
> >>>> +
> >>>> +       /* DON'T MOVE ME: must be enable before PHY init */
> >>>> +       rockchip->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpc=
ie3v3");
> >>>> +       if (IS_ERR(rockchip->vpcie3v3))
> >>>> +               if (PTR_ERR(rockchip->vpcie3v3) !=3D -ENODEV)
> >>>> +                       return dev_err_probe(dev, PTR_ERR(rockchip->=
vpcie3v3),
> >>>> +                                       "failed to get vpcie3v3 regu=
lator\n");
> >>>> +
> >>>> +       ret =3D regulator_enable(rockchip->vpcie3v3);
> >>>> +       if (ret) {
> >>>> +               dev_err(dev, "failed to enable vpcie3v3 regulator\n"=
);
> >>>> +               return ret;
> >>>> +       }
> >>>> +
> >>>> +       ret =3D rockchip_pcie_phy_init(rockchip);
> >>>> +       if (ret)
> >>>> +               goto disable_regulator;
> >>>> +
> >>>> +       ret =3D rockchip_pcie_reset_control_release(rockchip);
> >>>> +       if (ret)
> >>>> +               goto deinit_phy;
> >>>> +
> >>>> +       ret =3D rockchip_pcie_clk_init(rockchip);
> >>>> +       if (ret)
> >>>> +               goto deinit_phy;
> >>>> +
> >>>> +       ret =3D dw_pcie_host_init(pp);
> >>>> +       if (!ret)
> >>>> +               return 0;
> >>>> +
> >>>> +       clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks=
);
> >>>> +deinit_phy:
> >>>> +       rockchip_pcie_phy_deinit(rockchip);
> >>>> +disable_regulator:
> >>>> +       regulator_disable(rockchip->vpcie3v3);
> >>>> +
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static const struct of_device_id rockchip_pcie_of_match[] =3D {
> >>>> +       { .compatible =3D "rockchip,rk3568-pcie", },
> >>>> +       {},
> >>>> +};
> >>>> +
> >>>> +static struct platform_driver rockchip_pcie_driver =3D {
> >>>> +       .driver =3D {
> >>>> +               .name   =3D "rockchip-dw-pcie",
> >>>> +               .of_match_table =3D rockchip_pcie_of_match,
> >>>> +               .suppress_bind_attrs =3D true,
> >>>> +       },
> >>>> +       .probe =3D rockchip_pcie_probe,
> >>>> +};
> >>>> +builtin_platform_driver(rockchip_pcie_driver);
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> Linux-rockchip mailing list
> >>>> Linux-rockchip@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >>>
> >>>
> >>>
> >>
> >>
> >
> >
> >
>
>
