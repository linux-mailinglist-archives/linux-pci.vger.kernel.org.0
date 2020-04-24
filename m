Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE981B7C5B
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgDXRFo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 13:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgDXRFn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 13:05:43 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE54F21D7D
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 17:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587747943;
        bh=/aS+zJMM5XSmtqLYLKraQNtn00dJhBSjtW1eezqx6D8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QCsaQRBuPKoTWCOFbc25tBDaTioY5QpUNl2zf8tAZ5IOcT9/VUqW0wk2c4r8ILHdE
         eFXeEiHdNg3RlKbj8xH00ULgoLlkMwUI6nY3VNmrtxNjpliQeDMge4DuDOHWVFy2R2
         FDadix2kp5+awlw3354ykV7dLFQ6FBM762V/ErFw=
Received: by mail-yb1-f175.google.com with SMTP id l84so5415699ybb.1
        for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2020 10:05:42 -0700 (PDT)
X-Gm-Message-State: AGi0PubxzNr3tX8j1MpBbme1dXc4EdUtLV0NuuB9egIBiJF9G2Yfw+hn
        z1SZWZjUsIWvzheayR4+QOPFXViOMsQkB3g1zw==
X-Google-Smtp-Source: APiQypLFe20s2mv/jXpLHVnczjdUgQFK+RMQ9ssqapeEU5qL3rQtDm+nZkABS7Q+f4bS+0FAVG9DQYujNcen63hu/IM=
X-Received: by 2002:a25:e203:: with SMTP id h3mr17436160ybe.0.1587747941930;
 Fri, 24 Apr 2020 10:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200424153858.29744-1-pali@kernel.org> <20200424153858.29744-6-pali@kernel.org>
In-Reply-To: <20200424153858.29744-6-pali@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 Apr 2020 12:05:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+nmYMZQOUDQVO4FSU_3qg9hSJ8dOPQBymR8b-NMiAyuQ@mail.gmail.com>
Message-ID: <CAL_Jsq+nmYMZQOUDQVO4FSU_3qg9hSJ8dOPQBymR8b-NMiAyuQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] PCI: aardvark: Issue PERST via GPIO
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
> Add support for issuing PERST via GPIO specified in 'reset-gpios'
> property (as described in PCI device tree bindings).
>
> Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
> after reboot when PERST is not issued during driver initialization.
>
> If bootloader already enabled link training then issuing PERST has no
> effect for some buggy cards (e.g. Compex WLE900VX) and these cards are
> not detected. We therefore clear the LINK_TRAINING_EN register before.
>
> It was observed that Compex WLE900VX card needs to be in PERST reset
> for at least 10ms if bootloader enabled link training.
>
> Tested on Turris MOX.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 43 ++++++++++++++++++++++++++-
>  1 file changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controll=
er/pci-aardvark.c
> index a6c4d4d52631..9e2f44213b5e 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
> @@ -18,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>
>  #include "../pci.h"
> @@ -204,6 +206,7 @@ struct advk_pcie {
>         int root_bus_nr;
>         int link_gen;
>         struct pci_bridge_emul bridge;
> +       struct gpio_desc *reset_gpio;
>  };
>
>  static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
> @@ -330,10 +333,31 @@ static void advk_pcie_train_link(struct advk_pcie *=
pcie)
>         dev_err(dev, "link never came up\n");
>  }
>
> +static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> +{
> +       u32 reg;
> +
> +       if (!pcie->reset_gpio)
> +               return;
> +
> +       /* PERST does not work for some cards when link training is enabl=
ed */
> +       reg =3D advk_readl(pcie, PCIE_CORE_CTRL0_REG);
> +       reg &=3D ~LINK_TRAINING_EN;
> +       advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
> +
> +       /* 10ms delay is needed for some cards */
> +       dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms=
\n");
> +       gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +       usleep_range(10000, 11000);
> +       gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +}
> +
>  static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>  {
>         u32 reg;
>
> +       advk_pcie_issue_perst(pcie);
> +
>         /* Set to Direct mode */
>         reg =3D advk_readl(pcie, CTRL_CONFIG_REG);
>         reg &=3D ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
> @@ -406,7 +430,8 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie=
)
>
>         /*
>          * PERST# signal could have been asserted by pinctrl subsystem be=
fore
> -        * probe() callback has been called, making the endpoint going in=
to
> +        * probe() callback has been called or issued explicitly by reset=
 gpio
> +        * function advk_pcie_issue_perst(), making the endpoint going in=
to
>          * fundamental reset. As required by PCI Express spec a delay for=
 at
>          * least 100ms after such a reset before link training is needed.
>          */
> @@ -1046,6 +1071,22 @@ static int advk_pcie_probe(struct platform_device =
*pdev)
>         }
>         pcie->root_bus_nr =3D bus->start;
>
> +       pcie->reset_gpio =3D devm_gpiod_get_from_of_node(dev, dev->of_nod=
e,
> +                                                      "reset-gpios", 0,
> +                                                      GPIOD_OUT_LOW,
> +                                                      "pcie1-reset");
> +       ret =3D PTR_ERR_OR_ZERO(pcie->reset_gpio);
> +       if (ret) {
> +               if (ret =3D=3D -ENOENT) {
> +                       pcie->reset_gpio =3D NULL;
> +               } else {
> +                       if (ret !=3D -EPROBE_DEFER)
> +                               dev_err(dev, "Failed to get reset-gpio: %=
i\n",
> +                                       ret);
> +                       return ret;
> +               }
> +       }

I believe all this can be replaced with devm_gpiod_get_optional.

Rob
