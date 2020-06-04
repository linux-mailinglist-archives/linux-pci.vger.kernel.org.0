Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA11EE3B7
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 13:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgFDLye (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgFDLye (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Jun 2020 07:54:34 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8C5C03E96D
        for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2020 04:54:33 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ec10so2730436qvb.5
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2020 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L3BzriFCsJxcBPxSGuF+DveOldYzs1fbxU9kBMVBzh4=;
        b=rye3aE4y5RGxMYnaLaKQval6OfnyjZ3NrDwWFmO/5g+0pz0+UKiIOLYT/aA3yTChjk
         6B4znGlJni1ke4/DXHs5i0LgnxS//wJProt6riAtOPfnM10F6zXFdo1k7phHv/7ox+xk
         KuNi3bxF5MEQByMMQJM3mqHts/m9LKOjVrUvjo0OlH3Bfv+ES5B82EkZdJn2USm0UjIB
         KkbNIGStrhIAPUS5BCyss+b6TTHtY6vA9P/Zkdf6JKPdhcCCSp7Lci2UkvjemqSJh0qN
         M7RYpX0KeBTzyim2Islegf+/qeXynWpMPy6CKa2EVfXg5nPGrcwA8DNcgRfWXQ+/FKbk
         zq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L3BzriFCsJxcBPxSGuF+DveOldYzs1fbxU9kBMVBzh4=;
        b=XpXs6tqEs8K2Qg6ihccHbO7nHMwKyL5UbuggapXPlLenMogrkYDK89P2+W6kv36UnS
         qAdzYSS8x32sg6ktou8AeJGNzpTTWHCR7VnYMvHKNMJbVXsWRbfRdyOhCtO5Xg8uzjby
         kV4SEL7eBklFsA8bt0MQwCGtQqZp1ygAQw43X7s53jl4NJnNMOo8bUl4DmLpwAqCx3vd
         kwCf96i3CMmEvfWB3rDqVphq9AUJo8oJuHs5nSEGIjmgwwevQFDIyMHzaOZD8DweJ+yZ
         FA1OngUl8jmF1sz2XdnpuXjO+sWk4HBRgmRafYDHbA9Stng7F7FOvHPBRCrSBP5dYszh
         2vAQ==
X-Gm-Message-State: AOAM530QnLbP8DI/OwZpIqliwaRd/eTZ+USwVivUGfsxxmHNlEWsUKjL
        cNbRYXvHAgko6M1je1za9WFh2PWp59I0yAyfFx6ssg==
X-Google-Smtp-Source: ABdhPJz0eANCHfzyjLFWfgnUMEfOwCCI9lsBYhHIalCBVLT3spvvGHakpUb1zImbtdSx/MTx3lsHbqdYYls7tgsWQk8=
X-Received: by 2002:a0c:e5cc:: with SMTP id u12mr4242836qvm.134.1591271672926;
 Thu, 04 Jun 2020 04:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200604073243.19280-1-saraon640529@gmail.com>
In-Reply-To: <20200604073243.19280-1-saraon640529@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 4 Jun 2020 13:54:21 +0200
Message-ID: <CAMpxmJX8U-uNYJPQxmkox=YTSvXVPrWss2y5MS81_bg43Co8Lg@mail.gmail.com>
Subject: Re: [PATCH] gpio:asm28xx-18xx: new driver
To:     Richard Hsu <saraon640529@gmail.com>
Cc:     Richard_Hsu@asmedia.com.tw, Yd_Tseng@asmedia.com.tw,
        Jesse1_Chang@asmedia.com.tw,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

czw., 4 cze 2020 o 09:33 Richard Hsu <saraon640529@gmail.com> napisa=C5=82(=
a):
>
> Hi Linus Walleij,Bartosz Golaszewski and kbuild test robot,
>    I have fixed the warnings(make W=3D1 ARCH=3Di386) by replace two funct=
ions
> with static type,and resend the patch.
> line 69:
> <<void pci_config_pm_runtime_get(struct pci_dev *pdev)
> >>static void pci_config_pm_runtime_get(struct pci_dev *pdev)
> line 91:
> <<void pci_config_pm_runtime_put(struct pci_dev *pdev)
> >>static void pci_config_pm_runtime_put(struct pci_dev *pdev)
>
> Thanks
>
> BR,
>   Richard
> Signed-off-by: Richard Hsu <saraon640529@gmail.com>

Richar: please add a proper commit message to your patch and fix your
subject line: there should be a space after "gpio:". Use numbering for
subsequent patch versions ("[PATCH v2]" etc.).

> ---

Any additional comments as well as changes between versions should go here.

>  drivers/gpio/gpio-asm28xx-18xx.c | 278 +++++++++++++++++++++++++++++++
>  1 file changed, 278 insertions(+)
>  create mode 100644 drivers/gpio/gpio-asm28xx-18xx.c
>
> diff --git a/drivers/gpio/gpio-asm28xx-18xx.c b/drivers/gpio/gpio-asm28xx=
-18xx.c
> index 000000000000..0cf8d0df5407
> --- /dev/null
> +++ b/drivers/gpio/gpio-asm28xx-18xx.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Asmedia 28xx/18xx GPIO driver
> + *
> + * Copyright (C) 2020 ASMedia Technology Inc.
> + * Author: Richard Hsu <Richard_Hsu@asmedia.com.tw>
> + */
> +

Please remove all stray newlines from the driver.

> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/bits.h>
> +
> +
> +/* GPIO registers offsets */
> +#define ASM_GPIO_CTRL          0x920
> +#define ASM_GPIO_OUTPUT                0x928
> +#define ASM_GPIO_INPUT         0x930
> +#define ASM_REG_SWITCH         0xFFF
> +
> +#define ASM_REG_SWITCH_CTL     0x01
> +
> +#define ASM_GPIO_PIN5          5
> +#define ASM_GPIO_DEFAULT       0
> +
> +
> +#define PCI_DEVICE_ID_ASM_28XX_PID1    0x2824
> +#define PCI_DEVICE_ID_ASM_28XX_PID2    0x2812
> +#define PCI_DEVICE_ID_ASM_28XX_PID3    0x2806
> +#define PCI_DEVICE_ID_ASM_18XX_PID1    0x1824
> +#define PCI_DEVICE_ID_ASM_18XX_PID2    0x1812
> +#define PCI_DEVICE_ID_ASM_18XX_PID3    0x1806
> +#define PCI_DEVICE_ID_ASM_81XX_PID1    0x812a
> +#define PCI_DEVICE_ID_ASM_81XX_PID2    0x812b
> +#define PCI_DEVICE_ID_ASM_80XX_PID1    0x8061
> +
> +/*
> + * Data for PCI driver interface
> + *
> + * This data only exists for exporting the supported
> + * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
> + * register a pci_driver, because someone else might one day
> + * want to register another driver on the same PCI id.
> + */
> +static const struct pci_device_id pci_tbl[] =3D {
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_28XX_PID1),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_28XX_PID2),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_28XX_PID3),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_18XX_PID1),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_18XX_PID2),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_18XX_PID3),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_81XX_PID1),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_81XX_PID2),=
 0 },
> +       { PCI_DEVICE(PCI_VENDOR_ID_ASMEDIA, PCI_DEVICE_ID_ASM_80XX_PID1),=
 0 },
> +       { 0, }, /* terminate list */
> +};
> +MODULE_DEVICE_TABLE(pci, pci_tbl);
> +
> +struct asm28xx_gpio {
> +       struct gpio_chip        chip;
> +       struct pci_dev          *pdev;
> +       spinlock_t              lock;
> +};
> +
> +static void pci_config_pm_runtime_get(struct pci_dev *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device *parent =3D dev->parent;
> +
> +       if (parent)
> +               pm_runtime_get_sync(parent);
> +       pm_runtime_get_noresume(dev);
> +       /*
> +        * pdev->current_state is set to PCI_D3cold during suspending,
> +        * so wait until suspending completes
> +        */
> +       pm_runtime_barrier(dev);
> +       /*
> +        * Only need to resume devices in D3cold, because config
> +        * registers are still accessible for devices suspended but
> +        * not in D3cold.
> +        */
> +       if (pdev->current_state =3D=3D PCI_D3cold)
> +               pm_runtime_resume(dev);
> +}
> +
> +static void pci_config_pm_runtime_put(struct pci_dev *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct device *parent =3D dev->parent;
> +
> +       pm_runtime_put(dev);
> +       if (parent)
> +               pm_runtime_put_sync(parent);
> +}
> +
> +static int asm28xx_gpio_request(struct gpio_chip *chip, unsigned offset)
> +{
> +       if (offset =3D=3D ASM_GPIO_PIN5)
> +               return -ENODEV;
> +
> +       return 0;
> +}
> +
> +static void asm28xx_gpio_set(struct gpio_chip *chip, unsigned offset, in=
t value)
> +{
> +       struct asm28xx_gpio *agp =3D gpiochip_get_data(chip);
> +       u8 temp;
> +       unsigned long flags;
> +
> +       pci_config_pm_runtime_get(agp->pdev);
> +       spin_lock_irqsave(&agp->lock, flags);
> +       pci_read_config_byte(agp->pdev, ASM_GPIO_OUTPUT, &temp);
> +       if (value)
> +               temp |=3D BIT(offset);
> +       else
> +               temp &=3D ~BIT(offset);
> +
> +       pci_write_config_byte(agp->pdev, ASM_GPIO_OUTPUT, temp);
> +       spin_unlock_irqrestore(&agp->lock, flags);
> +       pci_config_pm_runtime_put(agp->pdev);
> +       dev_dbg(chip->parent, "ASMEDIA-28xx/18xx gpio %d set %d reg=3D%02=
x\n", offset, value, temp);
> +}
> +
> +static int asm28xx_gpio_get(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct asm28xx_gpio *agp =3D gpiochip_get_data(chip);
> +       u8 temp;
> +       unsigned long flags;
> +
> +       pci_config_pm_runtime_get(agp->pdev);
> +       spin_lock_irqsave(&agp->lock, flags);
> +       pci_read_config_byte(agp->pdev, ASM_GPIO_INPUT, &temp);
> +       spin_unlock_irqrestore(&agp->lock, flags);
> +       pci_config_pm_runtime_put(agp->pdev);
> +
> +       dev_dbg(chip->parent, "ASMEDIA-28xx/18xx GPIO Pin %d get reg=3D%0=
2x\n", offset, temp);
> +       return (temp & BIT(offset)) ? 1 : 0;
> +}
> +
> +static int asm28xx_gpio_dirout(struct gpio_chip *chip, unsigned offset, =
int value)
> +{
> +       struct asm28xx_gpio *agp =3D gpiochip_get_data(chip);
> +       u8 temp;
> +       unsigned long flags;
> +
> +       pci_config_pm_runtime_get(agp->pdev);
> +       spin_lock_irqsave(&agp->lock, flags);
> +       pci_read_config_byte(agp->pdev, ASM_GPIO_CTRL, &temp);
> +       temp |=3D BIT(offset);
> +       pci_write_config_byte(agp->pdev, ASM_GPIO_CTRL, temp);
> +       spin_unlock_irqrestore(&agp->lock, flags);
> +       pci_config_pm_runtime_put(agp->pdev);
> +       dev_dbg(chip->parent, "ASMEDIA-28xx/18xx dirout gpio %d  reg=3D%0=
2x\n", offset, temp);
> +
> +       return 0;
> +}
> +
> +static int asm28xx_gpio_dirin(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct asm28xx_gpio *agp =3D gpiochip_get_data(chip);
> +       u8 temp;
> +       unsigned long flags;
> +
> +       pci_config_pm_runtime_get(agp->pdev);
> +       spin_lock_irqsave(&agp->lock, flags);
> +       pci_read_config_byte(agp->pdev, ASM_GPIO_CTRL, &temp);
> +       temp &=3D ~BIT(offset);
> +       pci_write_config_byte(agp->pdev, ASM_GPIO_CTRL, temp);
> +       spin_unlock_irqrestore(&agp->lock, flags);
> +       pci_config_pm_runtime_put(agp->pdev);
> +       dev_dbg(chip->parent, "ASMEDIA-28xx/18xx dirin gpio %d  reg=3D%02=
x\n", offset, temp);
> +
> +       return 0;
> +}
> +
> +static struct asm28xx_gpio gp =3D {
> +       .chip =3D {
> +               .label          =3D "ASM28XX-18XX GPIO",
> +               .owner          =3D THIS_MODULE,
> +               .ngpio          =3D 8,
> +               .request        =3D asm28xx_gpio_request,
> +               .set            =3D asm28xx_gpio_set,
> +               .get            =3D asm28xx_gpio_get,
> +               .direction_output =3D asm28xx_gpio_dirout,
> +               .direction_input =3D asm28xx_gpio_dirin,
> +       },
> +};
> +
> +static int __init asm28xx_gpio_init(void)
> +{
> +       int err =3D -ENODEV;
> +       struct pci_dev *pdev =3D NULL;
> +       const struct pci_device_id *ent;
> +       u8 temp;
> +       unsigned long flags;
> +       int type;
> +
> +       /* We look for our device - Asmedia 28XX and 18XX Bridge
> +        * I don't know about a system with two such bridges,
> +        * so we can assume that there is max. one device.
> +        *
> +        * We can't use plain pci_driver mechanism,
> +        * as the device is really a multiple function device,
> +        * main driver that binds to the pci_device is an bus
> +        * driver and have to find & bind to the device this way.
> +        */
> +
> +       for_each_pci_dev(pdev) {
> +               ent =3D pci_match_id(pci_tbl, pdev);
> +               if (ent) {
> +                       /* Because GPIO Registers only work on Upstream p=
ort. */
> +                       type =3D pci_pcie_type(pdev);
> +                       if (type =3D=3D PCI_EXP_TYPE_UPSTREAM) {
> +                               dev_info(&pdev->dev, "ASMEDIA-28xx/18xx I=
nit Upstream detected\n");
> +                               goto found;
> +                       }
> +               }
> +       }
> +       goto out;
> +

Bjorn: is this approach really correct? It looks very strange to me
and even if we were to do this kind of lookup I'd expect there to be a
real pci device registered as child of pdev here so that we can have a
proper driver in place with probe() et al.

Bart

> +found:
> +       gp.pdev =3D pdev;
> +       gp.chip.parent =3D &pdev->dev;
> +
> +       spin_lock_init(&gp.lock);
> +
> +       err =3D gpiochip_add_data(&gp.chip, &gp);
> +       if (err) {
> +               dev_err(&pdev->dev, "GPIO registering failed (%d)\n", err=
);
> +               goto out;
> +       }
> +
> +       pci_config_pm_runtime_get(pdev);
> +
> +       /* Set PCI_CFG_Switch bit =3D 1,then we can access GPIO Registers=
. */
> +       spin_lock_irqsave(&gp.lock, flags);
> +       pci_read_config_byte(pdev, ASM_REG_SWITCH, &temp);
> +       temp |=3D ASM_REG_SWITCH_CTL;
> +       pci_write_config_byte(pdev, ASM_REG_SWITCH, temp);
> +       pci_read_config_byte(pdev, ASM_REG_SWITCH, &temp);
> +       spin_unlock_irqrestore(&gp.lock, flags);
> +
> +       pci_config_pm_runtime_put(pdev);
> +       dev_err(&pdev->dev, "ASMEDIA-28xx/18xx Init SWITCH =3D 0x%x\n", t=
emp);
> +out:
> +       return err;
> +}
> +
> +static void __exit asm28xx_gpio_exit(void)
> +{
> +       unsigned long flags;
> +
> +       pci_config_pm_runtime_get(gp.pdev);
> +
> +       spin_lock_irqsave(&gp.lock, flags);
> +       /* Set GPIO Registers to default value. */
> +       pci_write_config_byte(gp.pdev, ASM_GPIO_OUTPUT, ASM_GPIO_DEFAULT)=
;
> +       pci_write_config_byte(gp.pdev, ASM_GPIO_INPUT, ASM_GPIO_DEFAULT);
> +       pci_write_config_byte(gp.pdev, ASM_GPIO_CTRL, ASM_GPIO_DEFAULT);
> +       /* Clear PCI_CFG_Switch bit =3D 0,then we can't access GPIO Regis=
ters. */
> +       pci_write_config_byte(gp.pdev, ASM_REG_SWITCH, ASM_GPIO_DEFAULT);
> +       spin_unlock_irqrestore(&gp.lock, flags);
> +       pci_config_pm_runtime_put(gp.pdev);
> +
> +       gpiochip_remove(&gp.chip);
> +}
> +
> +module_init(asm28xx_gpio_init);
> +module_exit(asm28xx_gpio_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Richard Hsu <Richard_Hsu@asmedia.com.tw>");
> +MODULE_DESCRIPTION("ASMedia 28xx 18xx GPIO Driver");
> --
> 2.17.1
>
