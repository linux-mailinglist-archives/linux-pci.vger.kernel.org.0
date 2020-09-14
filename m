Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3726879D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgINIxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 04:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgINIxG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 04:53:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46699C06174A;
        Mon, 14 Sep 2020 01:53:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a8so16013243ilk.1;
        Mon, 14 Sep 2020 01:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T5blx8lW5RBmUkqia/MfWKUSWxCaOKkHJt1n0OFhjb8=;
        b=pwI5R544nBDLeZrf6ZYom+3nqKZgTTUGq8yhfwTuop2RItzV7BCkgpCPzFmX8awAT+
         +0EHNdBtbADpmqOGDynxt7TCygd8ZhfzYCr4NF938i/Xzv0ImsSrkQm3G3MKjyBBZ+3b
         5uAAvG6GgMq4GOXKmD1M3ezGpGjDeVIyPjABU04YL+kmsKoNp1hPtUBxs3cZAoyeN/hp
         pv9fe3jfXYiFLYYvQVy8ZiAnFtnIL+IeD8mcYVRMU0P3mEw8FOddf1YE4Gg6UbUlL8tp
         6vyr4qCNQSmsErj9nQUuv1FrPKlvTXf/bguL//rktufNqeJUUehMSaIPHCTAvK5GolNe
         Jjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T5blx8lW5RBmUkqia/MfWKUSWxCaOKkHJt1n0OFhjb8=;
        b=czmvVaT1BC8o3rRwSO33FNY0b2/XU3itFfmMfWjbZJw8WR5aanVPxwwe9eWHwx1Z8F
         3M6+/4iy7PdKVGv5/j7S94vtHPtlnCTu4o29glzCYAxaFj+2K4f4UhlRGeDNyzoaTgSL
         eP/hR4iw9+lf+QfLLaLThEqHR1JIv56QqDE6jGgg1A5Pi588nfFKx7YwK92pgtbOZvSk
         Ryr7GDrEbhGpqbFlx+GVu8z/R20DJ+tF3mh9fO7kijS7VnB33VjIQ6F1fuUjO+Mvcv1G
         bTBw6vjLuLC6t8gBcG44Q7GHV7oFEmt0CTy3ckLLIsebyISLj4v6b8t+yZkHeCrjz2H4
         o7Kg==
X-Gm-Message-State: AOAM532Kub4birqnkB87EfaNLW1zmznsvAlrogkwdMcFm7ODK/441j3t
        PrtnvXBM5HhHrByuMXJVfUZQWAfSOaUnOZ5VanigmZbB6gzNBQ==
X-Google-Smtp-Source: ABdhPJw+T5Ark5LxMUndS6SNu7VCFUXc/F2RHXVoAHsK1bYmraQeU5sa2ysv043ZtuHZwITikGt33SyhopnruDg1xz0=
X-Received: by 2002:a05:6e02:13ae:: with SMTP id h14mr1587717ilo.208.1600073582860;
 Mon, 14 Sep 2020 01:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn> <tencent_13F0F91E196BCF3F0E458509@qq.com>
In-Reply-To: <tencent_13F0F91E196BCF3F0E458509@qq.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 14 Sep 2020 16:52:51 +0800
Message-ID: <CAAhV-H4ogJYcK9E9hQ663dGcJn4GjWZUSp47xgzTtjAZ-nrybA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        zhouyanjie <zhouyanjie@wanyeetech.com>, git <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Tiezhu,

How do you test kexec? kexec -e or systemctl kexec? Or both?
P.S., Please also CC my gmail (chenhuacai@gmail.com) since lemote.com
has some communication problems.

Huacai

>
> =E9=99=88=E5=8D=8E=E6=89=8D=E6=B1=9F=E8=8B=8F=E8=88=AA=E5=A4=A9=E9=BE=99=
=E6=A2=A6=E4=BF=A1=E6=81=AF=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=
=8F=B8/=E7=A0=94=E5=8F=91=E4=B8=AD=E5=BF=83/=E8=BD=AF=E4=BB=B6=E9=83=A8   -=
----------------- Original ------------------From:  "Tiezhu Yang"<yangtiezh=
u@loongson.cn>;Date:  Mon, Sep 14, 2020 03:57 PMTo:  "Bjorn Helgaas"<bhelga=
as@google.com>; Cc:  "linux-pci"<linux-pci@vger.kernel.org>; "linux-kernel"=
<linux-kernel@vger.kernel.org>; "Rafael J. Wysocki"<rafael.j.wysocki@intel.=
com>; "Konstantin Khlebnikov"<khlebnikov@openvz.org>; "Khalid Aziz"<khalid.=
aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; "Lukas Wunner"<lukas@wu=
nner.de>; "Oliver O'Halloran"<oohall@gmail.com>; "Huacai Chen"<chenhc@lemot=
e.com>; "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "Xuefeng Li"<lixuefeng@loon=
gson.cn>; Subject:  [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on =
kexec reboot and connected PCI devices After commit 745be2e700cd ("PCIe: po=
rtdrv: call pci_disable_device
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
> When remove "pci_command &=3D ~PCI_COMMAND_MASTER;", it can work well whe=
n
> shutdown or reboot.
>
> As Oliver O'Halloran said, no need to call pci_disable_device() when
> actually shutting down, but we should call pci_disable_device() before
> handing over to the new kernel on kexec reboot, so we can do some
> condition checks which are already executed afterwards by the function
> pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: Disable
> Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: Don't tr=
y
> to disable Bus Master on disconnected PCI devices").
>
> drivers/pci/pci-driver.c
> static void pci_device_shutdown(struct device *dev)
> {
>  ...
>         if (drv && drv->shutdown)
>                 drv->shutdown(pci_dev);
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
>
> [   36.159446] Call Trace:
> [   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
> [   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
> [   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
> [   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
> [   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
> [   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
> [   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
> [   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/pci/pcie/portdrv_core.c |  1 -
>  drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
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
> index 3a3ce40..cab37a8 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
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
>  }
>
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver =3D {
>
>         .probe          =3D pcie_portdrv_probe,
>         .remove         =3D pcie_portdrv_remove,
> -       .shutdown       =3D pcie_portdrv_remove,
> +       .shutdown       =3D pcie_portdrv_shutdown,
>
>         .err_handler    =3D &pcie_portdrv_err_handler,
>
> --
> 2.1.0
