Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E392683AF
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 06:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgINEbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 00:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgINEbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 00:31:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB5BC06174A;
        Sun, 13 Sep 2020 21:31:19 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r25so18620692ioj.0;
        Sun, 13 Sep 2020 21:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DsZ3lIX5gUOeOkzUQTxhWkAmsPOYNnnOW1gG/K3R+V8=;
        b=mF7Fd5B/3mpOxdJjmfoNJUK/K22MJ090gLMjEthMfdykhBuVHEU18C0B0F1gWP3lAd
         925DZjFFHEvr6MFwjW/V8ur2f0pa8w5ElPtg5Ow9F+se1YEQenEttI+8SK++lGjgUDc9
         8YWL5PLHXqoU+ocKChI/rs8Hq9EpSh0Wi8G1A+DrIceHokKJJI+7s5bRTFRu/rLy5GWm
         j+SopgnGiQgrtBKINA6LaRE2EtOV6X0JKgF6LIalu/6rI5cRGsvjEjOVttktHyfmdWpw
         3yVKX+58AYGi9p3SMzxMZSjXzvQHAOBQ3b5QG8HUBR/Hz8GGTeX7wQ4wYcwxE2Ffumn4
         ghew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DsZ3lIX5gUOeOkzUQTxhWkAmsPOYNnnOW1gG/K3R+V8=;
        b=dmkKRWJkEDVIj6KfDHjEFcZw5vP7zdXEiIbsGGuCitjUKTgTcA0Avj3ljVKTXT6kTj
         K+0mphDL+z36XNLohQ+96sasU9Vgzq/eCYpUTkBTdjjTJMi2IT4kdVOsy2hzr45bfF/s
         UFxU3Vf4wVhYyo/7nWykQ2O4/JFAZlXRRZJt+UeFmnSlrsd49sLvmdg5Fv6N+KY3VPZw
         Z4FeFwgYv7Ubz4z2ZicqjZ+eGe1X4lkxJqDPz8pQsWnDW2PJI6RrLtrWo2fL02ho49YA
         R0u/n+fcDtR3wA2A/whJ/I7NwdDxXjdtqkLE0S0anHQKn3IgLy09GJojJ8w57gOn7Upy
         2o6g==
X-Gm-Message-State: AOAM531PsOVEHe5QsWVzEvTfnld+XWh+H7sAVheoXXYAVTP8Adyga8eP
        yJ8wEmzQ+w6UvvK/hhNCiJkjPL/12bUTyZg9f8I=
X-Google-Smtp-Source: ABdhPJyc/K58LLbl09KQIaVix4ILpCnjQsbupppbIRjarJBAcenkAAUClCCW5KkB5yqaySHyBt7agDekXVbJHzd3iTU=
X-Received: by 2002:a5d:8604:: with SMTP id f4mr10017634iol.196.1600057876290;
 Sun, 13 Sep 2020 21:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <1600028950-10644-1-git-send-email-yangtiezhu@loongson.cn> <tencent_44F0201A70619BA613F16BA4@qq.com>
In-Reply-To: <tencent_44F0201A70619BA613F16BA4@qq.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 14 Sep 2020 12:31:04 +0800
Message-ID: <CAAhV-H5-X9OcBe3iRxF8PnKW-0j_10FVqm8cbiqW2-Lv4mTTdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>, oohall <oohall@gmail.com>,
        "rafael.j.wysocki" <rafael.j.wysocki@intel.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        zhouyanjie <zhouyanjie@wanyeetech.com>, git <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tiezhu

> ------------------ Original ------------------
> From:  "Tiezhu Yang"<yangtiezhu@loongson.cn>;
> Date:  Mon, Sep 14, 2020 04:29 AM
> To:  "Bjorn Helgaas"<bhelgaas@google.com>;
> Cc:  "Konstantin Khlebnikov"<khlebnikov@openvz.org>; "Khalid Aziz"<khalid=
.aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; "Lukas Wunner"<lukas@w=
unner.de>; "oohall"<oohall@gmail.com>; "rafael.j.wysocki"<rafael.j.wysocki@=
intel.com>; "Xuefeng Li"<lixuefeng@loongson.cn>; "Huacai Chen"<chenhc@lemot=
e.com>; "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "linux-pci"<linux-pci@vger.=
kernel.org>; "linux-kernel"<linux-kernel@vger.kernel.org>;
> Subject:  [RFC PATCH v2] PCI/portdrv: Only disable Bus Master on kexec re=
boot and connected PCI devices
>
>
>
> After commit 745be2e700cd ("PCIe: portdrv: call pci_disable_device
> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
> services during shutdown"), it also calls pci_disable_device() during
> shutdown, this leads to shutdown or reboot failure occasionally due to
> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
>
> drivers/pci/pci.c
> static void do_pci_disable_device(struct pci_dev *dev)
> {
>         u16 pci_command;
>
>         pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>         if (pci_command & PCI_COMMAND_MASTER) {
>                 pci_command &=3D ~PCI_COMMAND_MASTER;
>                 pci_write_config_word(dev, PCI_COMMAND, pci_command);
>         }
>
>         pcibios_disable_device(dev);
> }
>
> When remove "pci_command &=3D ~PCI_COMMAND_MASTER;", it can work well.
>
> As Oliver O'Halloran said, no need to call pci_disable_device() when
> actually shutting down, but we should call pci_disable_device() before
> handing over to the new kernel on kexec reboot, so we can do some
> condition checks which are similar with pci_device_shutdown(), this is
> done by commit 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec
> reboot") and commit 6e0eda3c3898 ("PCI: Don't try to disable Bus Master
> on disconnected PCI devices").
>
> drivers/pci/pci-driver.c
> static void pci_device_shutdown(struct device *dev)
> {
> ...
>
>         /*
>          * If this is a kexec reboot, turn off Bus Master bit on the
>          * device to tell it to not continue to do DMA. Don't touch
>          * devices in D3cold or unknown states.
>          * If it is not a kexec reboot, firmware will hit the PCI
>          * devices with big hammer and stop their DMA any way.
>          */
>         if (kexec_in_progress && (pci_dev->current_state <=3D PCI_D3hot))
>                 pci_clear_master(pci_dev);
> }
Have you really tried kexec? Why do you think kexec can disable pci
device successfully while normal reboot/poweroff cannot?

Huacai
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/pci/pcie/portdrv_core.c |  1 -
>  drivers/pci/pcie/portdrv_pci.c  | 25 ++++++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_c=
ore.c
> index 50a9522..1991aca 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev)
>  {
>         device_for_each_child(&dev->dev, NULL, remove_iter);
>         pci_free_irq_vectors(dev);
> -       pci_disable_device(dev);
>  }
>
>  /**
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pc=
i.c
> index 3a3ce40..ce89a9e8 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -15,6 +15,7 @@
>  #include <linux/init.h>
>  #include <linux/aer.h>
>  #include <linux/dmi.h>
> +#include <linux/kexec.h>
>
>  #include "../pci.h"
>  #include "portdrv.h"
> @@ -143,6 +144,28 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>         }
>
>         pcie_port_device_remove(dev);
> +       pci_disable_device(dev);
> +}
> +
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> +{
> +       if (pci_bridge_d3_possible(dev)) {
> +               pm_runtime_forbid(&dev->dev);
> +               pm_runtime_get_noresume(&dev->dev);
> +               pm_runtime_dont_use_autosuspend(&dev->dev);
> +       }
> +
> +       pcie_port_device_remove(dev);
> +
> +       /*
> +        * If this is a kexec reboot, turn off Bus Master bit on the
> +        * device to tell it to not continue to do DMA. Don't touch
> +        * devices in D3cold or unknown states.
> +        * If it is not a kexec reboot, firmware will hit the PCI
> +        * devices with big hammer and stop their DMA any way.
> +        */
> +       if (kexec_in_progress && (dev->current_state <=3D PCI_D3hot))
> +               pci_disable_device(dev);
>  }
>
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -211,7 +234,7 @@ static void pcie_portdrv_err_resume(struct pci_dev *d=
ev)
>
>         .probe          =3D pcie_portdrv_probe,
>         .remove         =3D pcie_portdrv_remove,
> -       .shutdown       =3D pcie_portdrv_remove,
> +       .shutdown       =3D pcie_portdrv_shutdown,
>
>         .err_handler    =3D &pcie_portdrv_err_handler,
>
> --
> 1.8.3.1
