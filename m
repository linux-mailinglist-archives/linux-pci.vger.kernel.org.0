Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE401C1E7
	for <lists+linux-pci@lfdr.de>; Tue, 14 May 2019 07:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfENFfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 01:35:32 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55164 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfENFfc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 May 2019 01:35:32 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so2931935ite.4;
        Mon, 13 May 2019 22:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROnZBNUjavEPATCp1Opo+Fi0jSzmWi2jvW4E1gcmmR8=;
        b=NSzdQDwpBBa362njSlwhNhs7vhCUxNwQXNRTOlCPRAPNS9KafxL6jwlRy2Is17dycj
         hX4TGdEniOVVubcDUedCX9kkhYYY69ejq00y7sGbZQnABZ9N7sYOxyXN1VOo+oISiH7R
         FU24vSJxTGTcXC9C42x3CKoUhfNM9LNCx2qAUiYuP4WSrEAlLT/+uLVv8VEKepsti7z/
         Ls90/YuQNDHnAkP/I2CT4E5vR4g5DNPQ6ZOrNlXOFRwZg0bc74UCajaYqZ7sb1Wxjgsa
         3JkLtl+o8teimJehJScWHcU6MCqKae0gSGz0wO70ydEFOEf7DfR1pOXzrc5OhGkqTYfw
         tJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROnZBNUjavEPATCp1Opo+Fi0jSzmWi2jvW4E1gcmmR8=;
        b=aIjcd2nj0mTsTqjW//fwo1IwW0QSvj/qtv9RSpHBKhS60Bqgp2CtHgym7nAfzOBSIX
         dzOtmt1x7VmZ1z0fgRI1N8J+A7fOt2ROSxEUap+TCdW9fSPN5tByN2Mmq1gUMVyTvqeV
         0F2SwV5P8s3w5LyFF+oFiYos8TOY2hbP+hzAfj9ka6x4YCDxvvzqVB1IO5aYsI4QyTMl
         KOABjaWnyKN3yCze/GJCvyrw46WL8Jufu7Y+Zm5GrnwWoeUtyrnxOZXWANSfsHDv19n8
         TBSz9/Xpx0M0u1gFQMgzJhnIDgxY11Tny90S824pfMnq6m7US8AsppL83V8E+kEc7vCM
         f5rw==
X-Gm-Message-State: APjAAAWCe1/M63t7AkYTJiLd1Xa+OWfu0uGAhnQiyxvNACRdduo790QZ
        Rn3YDoZWCkgxwmEb//VHyJRxxz9DcfaBxXVylsw=
X-Google-Smtp-Source: APXvYqxnsVMo5UM99fUX1eUTegiPxPCSWcQI/OUdYd83fAERf0SMkvw1yLaPmTNFqHa//Hxs45go0UzItmWlHF32tbU=
X-Received: by 2002:a02:741c:: with SMTP id o28mr21283892jac.144.1557812131236;
 Mon, 13 May 2019 22:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com> <1556081835-12921-2-git-send-email-ley.foon.tan@intel.com>
In-Reply-To: <1556081835-12921-2-git-send-email-ley.foon.tan@intel.com>
From:   Ley Foon Tan <lftan.linux@gmail.com>
Date:   Tue, 14 May 2019 13:35:20 +0800
Message-ID: <CAFiDJ59Pi6fxyE=0ifNJRoGc4QBX3XKJ=L7FXjJ_a6Vyh8otMg@mail.gmail.com>
Subject: Re: [PATCH] PCI: altera-msi: Allow building as module
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 24, 2019 at 12:57 PM Ley Foon Tan <ley.foon.tan@intel.com> wrote:
>
> Altera MSI IP is a soft IP and is only available after
> FPGA image is programmed.
>
> Make driver modulable to support use case FPGA image is programmed
> after kernel is booted. User proram FPGA image in kernel then only load
> MSI driver module.
>
> Signed-off-by: Ley Foon Tan <ley.foon.tan@intel.com>
> ---
>  drivers/pci/controller/Kconfig           |  2 +-
>  drivers/pci/controller/pcie-altera-msi.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 4b550f9cdd56..920546cb84e2 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -181,7 +181,7 @@ config PCIE_ALTERA
>           FPGA.
>
>  config PCIE_ALTERA_MSI
> -       bool "Altera PCIe MSI feature"
> +       tristate "Altera PCIe MSI feature"
>         depends on PCIE_ALTERA
>         depends on PCI_MSI_IRQ_DOMAIN
>         help
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index 025ef7d9a046..16d938920ca5 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -10,6 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> @@ -288,4 +289,13 @@ static int __init altera_msi_init(void)
>  {
>         return platform_driver_register(&altera_msi_driver);
>  }
> +
> +static void __exit altera_msi_exit(void)
> +{
> +       platform_driver_unregister(&altera_msi_driver);
> +}
> +
>  subsys_initcall(altera_msi_init);
> +MODULE_DEVICE_TABLE(of, altera_msi_of_match);
> +module_exit(altera_msi_exit);
> +MODULE_LICENSE("GPL v2");
> --
> 2.19.0
>
Hi

Any comment for this patch?

Regards
Ley Foon
