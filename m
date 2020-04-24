Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1A71B7C4D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 19:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgDXRBI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 13:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgDXRBI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 13:01:08 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929A92071E
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587747666;
        bh=STMgLMla4fK5o3HI/mkE8CRivPMAFeHSFd+gHEdauhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dKkeQSZ9n5AgBSx1bFArf8HrVEWaO76qKknuuKWjuby97X60/TBhgbaaJUllwCAxw
         bVxQq24ft1NqQRnjXRrP+o7aRQBt56A4ZISAl/qQR7IOmYBrhlyMs3sX7hGG3f8+WA
         3tSdEIDLnmsuVxyN0YxvlX3lUNWDknP6KqsrtPEM=
Received: by mail-yb1-f171.google.com with SMTP id p7so3245024ybo.12
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 10:01:06 -0700 (PDT)
X-Gm-Message-State: AGi0PuZH9aX41ptWASuA4+nYvy1m1/uCFu1VcJOgss+fiVF5R6PyOA8Q
        HUKCl3PDqMCkzJ5kpX65npg+HRqDWNHyVtLLgg==
X-Google-Smtp-Source: APiQypJwQIkvXqLSELp1sOEpgpq18RyGBTuFo5Ya4ELLMhnRbYQqeT2lcFQaeMdCeSRAWo/gc/Nmn9r/5dDZGo34KMs=
X-Received: by 2002:a25:6150:: with SMTP id v77mr17444573ybb.414.1587747665835;
 Fri, 24 Apr 2020 10:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153858.29744-1-pali@kernel.org> <20200424153858.29744-5-pali@kernel.org>
In-Reply-To: <20200424153858.29744-5-pali@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Apr 2020 12:00:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLTXGE4SAmbzkPJ-omusMiSoBwgF0j8HhAq7F+9w7g1wg@mail.gmail.com>
Message-ID: <CAL_JsqLTXGE4SAmbzkPJ-omusMiSoBwgF0j8HhAq7F+9w7g1wg@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] PCI: aardvark: Improve link training
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>,
        Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 10:39 AM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> From: Marek Beh=C3=BAn <marek.behun@nic.cz>
>
> Currently the aardvark driver trains link in PCIe gen2 mode. This may
> cause some buggy gen1 cards (such as Compex WLE900VX) to be unstable or
> even not detected. Moreover when ASPM code tries to retrain link second
> time, these cards may stop responding and link goes down. If gen1 is
> used this does not happen.
>
> Unconditionally forcing gen1 is not a good solution since it may have
> performance impact on gen2 cards.
>
> To overcome this, read 'max-link-speed' property (as defined in PCI
> device tree bindings) and use this as max gen mode. Then iteratively try
> link training at this mode or lower until successful. After successful
> link training choose final controller gen based on Negotiated Link Speed
> from Link Status register, which should match card speed.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Signed-off-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> ---
>  drivers/pci/controller/pci-aardvark.c | 113 ++++++++++++++++++++------
>  1 file changed, 88 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index 74b90940a9d4..a6c4d4d52631 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -40,6 +40,7 @@
>  #define PCIE_CORE_LINK_CTRL_STAT_REG                           0xd0
>  #define     PCIE_CORE_LINK_L0S_ENTRY                           BIT(0)
>  #define     PCIE_CORE_LINK_TRAINING                            BIT(5)
> +#define     PCIE_CORE_LINK_SPEED_SHIFT                         16
>  #define     PCIE_CORE_LINK_WIDTH_SHIFT                         20
>  #define PCIE_CORE_ERR_CAPCTL_REG                               0x118
>  #define     PCIE_CORE_ERR_CAPCTL_ECRC_CHK_TX                   BIT(5)
> @@ -201,6 +202,7 @@ struct advk_pcie {
>         struct mutex msi_used_lock;
>         u16 msi_msg;
>         int root_bus_nr;
> +       int link_gen;
>         struct pci_bridge_emul bridge;
>  };
>
> @@ -225,20 +227,16 @@ static int advk_pcie_link_up(struct advk_pcie *pcie=
)
>
>  static int advk_pcie_wait_for_link(struct advk_pcie *pcie)
>  {
> -       struct device *dev =3D &pcie->pdev->dev;
>         int retries;
>
>         /* check if the link is up or not */
>         for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -               if (advk_pcie_link_up(pcie)) {
> -                       dev_info(dev, "link up\n");
> +               if (advk_pcie_link_up(pcie))
>                         return 0;
> -               }
>
>                 usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
>         }
>
> -       dev_err(dev, "link never came up\n");
>         return -ETIMEDOUT;
>  }
>
> @@ -253,6 +251,85 @@ static void advk_pcie_wait_for_retrain(struct advk_p=
cie *pcie)
>         }
>  }
>
> +static int advk_pcie_train_at_gen(struct advk_pcie *pcie, int gen)
> +{
> +       int ret, neg_gen;
> +       u32 reg;
> +
> +       /* Setup link speed */
> +       reg =3D advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +       reg &=3D ~PCIE_GEN_SEL_MSK;
> +       if (gen =3D=3D 3)
> +               reg |=3D SPEED_GEN_3;
> +       else if (gen =3D=3D 2)
> +               reg |=3D SPEED_GEN_2;
> +       else
> +               reg |=3D SPEED_GEN_1;
> +       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> +
> +       /*
> +        * Enable link training. This is not needed in every call to this
> +        * function, just once suffices, but it does not break anything e=
ither.
> +        */
> +       reg =3D advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +       reg |=3D LINK_TRAINING_EN;
> +       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> +
> +       /*
> +        * Start link training immediately after enabling it.
> +        * This solves problems for some buggy cards.
> +        */
> +       reg =3D advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> +       reg |=3D PCIE_CORE_LINK_TRAINING;
> +       advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> +
> +       ret =3D advk_pcie_wait_for_link(pcie);
> +       if (ret)
> +               return ret;
> +
> +       reg =3D advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> +       neg_gen =3D (reg >> PCIE_CORE_LINK_SPEED_SHIFT) & 0xf;
> +
> +       return neg_gen;
> +}
> +
> +static void advk_pcie_train_link(struct advk_pcie *pcie)
> +{
> +       struct device *dev =3D &pcie->pdev->dev;
> +       int neg_gen =3D -1, gen;
> +
> +       /*
> +        * Try link training at link gen specified by device tree propert=
y
> +        * 'max-link-speed'. If this fails, iteratively train at lower ge=
n.
> +        */
> +       for (gen =3D pcie->link_gen; gen > 0; --gen) {
> +               neg_gen =3D advk_pcie_train_at_gen(pcie, gen);
> +               if (neg_gen > 0)
> +                       break;
> +       }
> +
> +       if (neg_gen < 0)
> +               goto err;
> +
> +       /*
> +        * After successful training if negotiated gen is lower than requ=
ested,
> +        * train again on negotiated gen. This solves some stability issu=
es for
> +        * some buggy gen1 cards.
> +        */
> +       if (neg_gen < gen) {
> +               gen =3D neg_gen;
> +               neg_gen =3D advk_pcie_train_at_gen(pcie, gen);
> +       }
> +
> +       if (neg_gen =3D=3D gen) {
> +               dev_info(dev, "link up at gen %i\n", gen);
> +               return;
> +       }
> +
> +err:
> +       dev_err(dev, "link never came up\n");
> +}
> +
>  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
>         u32 reg;
> @@ -288,12 +365,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pci=
e)
>                 PCIE_CORE_CTRL2_TD_ENABLE;
>         advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
>
> -       /* Set GEN2 */
> -       reg =3D advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> -       reg &=3D ~PCIE_GEN_SEL_MSK;
> -       reg |=3D SPEED_GEN_2;
> -       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> -
>         /* Set lane X1 */
>         reg =3D advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>         reg &=3D ~LANE_CNT_MSK;
> @@ -341,20 +412,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pci=
e)
>          */
>         msleep(PCI_PM_D3COLD_WAIT);
>
> -       /* Enable link training */
> -       reg =3D advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> -       reg |=3D LINK_TRAINING_EN;
> -       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> -
> -       /*
> -        * Start link training immediately after enabling it.
> -        * This solves problems for some buggy cards.
> -        */
> -       reg =3D advk_readl(pcie, PCIE_CORE_LINK_CTRL_STAT_REG);
> -       reg |=3D PCIE_CORE_LINK_TRAINING;
> -       advk_writel(pcie, reg, PCIE_CORE_LINK_CTRL_STAT_REG);
> -
> -       advk_pcie_wait_for_link(pcie);
> +       advk_pcie_train_link(pcie);
>
>         reg =3D advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
>         reg |=3D PCIE_CORE_CMD_MEM_ACCESS_EN |
> @@ -988,6 +1046,11 @@ static int advk_pcie_probe(struct platform_device *=
pdev)
>         }
>         pcie->root_bus_nr =3D bus->start;
>
> +       ret =3D of_pci_get_max_link_speed(dev->of_node);
> +       if (ret < 0)
> +               return ret;

Why just give up simply on DT error? Just start at gen 3 since you now
retry at lower speeds.

> +       pcie->link_gen =3D (ret > 3) ? 3 : ret;
> +
>         advk_pcie_setup_hw(pcie);
>
>         advk_sw_pci_bridge_init(pcie);
> --
> 2.20.1
>
