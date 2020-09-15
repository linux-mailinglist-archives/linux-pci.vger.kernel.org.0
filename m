Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9BD269B42
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 03:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgIOBg2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 21:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOBg1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 21:36:27 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332CC06174A;
        Mon, 14 Sep 2020 18:36:26 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id u18so1422600iln.13;
        Mon, 14 Sep 2020 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1rBPwHwU2FkVKjAeAJcaXFgeOnP2PmSEpXOhpG8dYA8=;
        b=lG2JqnYY2TwYs7ftKsQ7Hj7XI/MeSctq2Gda3b7kK1Ln96SAzjPxmsLHJIy3s0NXWp
         QiBhExv43OxLhhMhbK73QDmHQnxtubR+YGPok+DyRX0RTH3CSQbMLSjKltyugzlhH7Rw
         Y6WJIO6QaDpWFVg/HuGPsqVttFMKb9UQNs/RUjerL4q4efKZ1LYLjMMsaHNuyTYFCmQf
         1GzD4cEyjs8LuXRQSzp45yjaBlp+w5DvNrn7mhAqRi9rBdMYZ81f+BlcBkE3t9yUckmX
         jSKI1tYcIs4ljJKSRAkGNYFAdffhvPpvKGX5RmEVfmtIoGWUP2LSM+QBuPi2ZJb8JUyY
         Z6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1rBPwHwU2FkVKjAeAJcaXFgeOnP2PmSEpXOhpG8dYA8=;
        b=WhKbEAPyfSpSFuc71rw6cbDI9theL6UWUDEqAAHp6k3W/U94yLlyTWqjyTlygDHRf6
         vOGT1UNqhYLdAHy+yeFBy5mtosyEX539WL35OvexeZb9ULoSG73qnr6mZS4QsJYULck9
         AzMscW5KXlX9ijPWrp0BBLLZmjxr/5oS1Fd1au8m+3CmVgfG6L5oJ4F+RXTaQScHt5pU
         l8cEqv2FW4tIfjnafO9e5RoclOdTcWRdDEnVFxSQAT9fji+Q21RiCEPEmQWZ+KlTRG4L
         vPFbQDPFdQsk1zI18Ltcq/08AXeYDw18BtyMGekMU/DFdq8BcfRjNEqPxqSbGgkbjMfu
         wtLA==
X-Gm-Message-State: AOAM531pqZnTIg0drXDZDdudk7cr2p/K/QCBdJKfBxWLOujvcGLwjygk
        fB5wRSKbK4ucj/jOT+rlCcZxJlzjGf8Aryqg82U=
X-Google-Smtp-Source: ABdhPJxtPrlM7Cw/cVdSUBwfIV+ugJcy/PfYbfSAsEaCdsTIT0DXPECiraeh9Oedh7CWgIoriAz5X6e0EOwIptU1OSI=
X-Received: by 2002:a92:d1d0:: with SMTP id u16mr9570660ilg.171.1600133785312;
 Mon, 14 Sep 2020 18:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <1600070215-3901-1-git-send-email-yangtiezhu@loongson.cn>
 <tencent_13F0F91E196BCF3F0E458509@qq.com> <CAAhV-H4ogJYcK9E9hQ663dGcJn4GjWZUSp47xgzTtjAZ-nrybA@mail.gmail.com>
 <45a3e3a0-3dc6-e60e-9381-b436a7d6889a@loongson.cn> <CAAhV-H5t1gCgBHtx=+Lu-9Fb7syJr0TsqdHc0qYQOfhXs-fJcQ@mail.gmail.com>
 <db559a40-a36e-a97b-703e-86ae1f0254a1@loongson.cn>
In-Reply-To: <db559a40-a36e-a97b-703e-86ae1f0254a1@loongson.cn>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 15 Sep 2020 09:36:13 +0800
Message-ID: <CAAhV-H7+jMPab9oM_E1J8cfzq0NYCd3w==1WNV3_Hkt0NL7ZCA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] PCI/portdrv: Only disable Bus Master on kexec
 reboot and connected PCI devices
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
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

On Mon, Sep 14, 2020 at 7:25 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> On 09/14/2020 05:46 PM, Huacai Chen wrote:
> > Hi, Tiezhu,
> >
> > On Mon, Sep 14, 2020 at 5:30 PM Tiezhu Yang <yangtiezhu@loongson.cn> wr=
ote:
> >> On 09/14/2020 04:52 PM, Huacai Chen wrote:
> >>> Hi, Tiezhu,
> >>>
> >>> How do you test kexec? kexec -e or systemctl kexec? Or both?
> >> kexec -l vmlinux --append=3D"root=3D/dev/sda2 console=3DttyS0,115200"
> >> kexec -e
> > So you haven't tested "systemctl kexec"?
>
> Yes, the distro I used is Loongnix which has not kexec service now.
> Is there any problem when use systemctl kexec? If you have more details,
> please let me know.
If you use systemctl kexec, the first part of kexec is the same as a
normal reboot/poweroff. So, there is no reason that reboot/poweroff is
bad but kexec is good.
Then, Bjorn, what is the best solution now? It seems like my first
version is OK (commit messages should be improved, of course).

Huacai
>
> >
> > Huacai
> >>> P.S., Please also CC my gmail (chenhuacai@gmail.com) since lemote.com
> >>> has some communication problems.
> >> OK, no problem.
> >>
> >>> Huacai
> >>>
> >>>> =E9=99=88=E5=8D=8E=E6=89=8D=E6=B1=9F=E8=8B=8F=E8=88=AA=E5=A4=A9=E9=
=BE=99=E6=A2=A6=E4=BF=A1=E6=81=AF=E6=8A=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=
=AC=E5=8F=B8/=E7=A0=94=E5=8F=91=E4=B8=AD=E5=BF=83/=E8=BD=AF=E4=BB=B6=E9=83=
=A8   ------------------ Original ------------------From:  "Tiezhu Yang"<ya=
ngtiezhu@loongson.cn>;Date:  Mon, Sep 14, 2020 03:57 PMTo:  "Bjorn Helgaas"=
<bhelgaas@google.com>; Cc:  "linux-pci"<linux-pci@vger.kernel.org>; "linux-=
kernel"<linux-kernel@vger.kernel.org>; "Rafael J. Wysocki"<rafael.j.wysocki=
@intel.com>; "Konstantin Khlebnikov"<khlebnikov@openvz.org>; "Khalid Aziz"<=
khalid.aziz@oracle.com>; "Vivek Goyal"<vgoyal@redhat.com>; "Lukas Wunner"<l=
ukas@wunner.de>; "Oliver O'Halloran"<oohall@gmail.com>; "Huacai Chen"<chenh=
c@lemote.com>; "Jiaxun Yang"<jiaxun.yang@flygoat.com>; "Xuefeng Li"<lixuefe=
ng@loongson.cn>; Subject:  [RFC PATCH v3] PCI/portdrv: Only disable Bus Mas=
ter on kexec reboot and connected PCI devices After commit 745be2e700cd ("P=
CIe: portdrv: call pci_disable_device
> >>>> during remove") and commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe
> >>>> services during shutdown"), it also calls pci_disable_device() durin=
g
> >>>> shutdown, this leads to shutdown or reboot failure occasionally due =
to
> >>>> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().
> >>>>
> >>>> drivers/pci/pci.c
> >>>> static void do_pci_disable_device(struct pci_dev *dev)
> >>>> {
> >>>>           u16 pci_command;
> >>>>
> >>>>           pci_read_config_word(dev, PCI_COMMAND, &pci_command);
> >>>>           if (pci_command & PCI_COMMAND_MASTER) {
> >>>>                   pci_command &=3D ~PCI_COMMAND_MASTER;
> >>>>                   pci_write_config_word(dev, PCI_COMMAND, pci_comman=
d);
> >>>>           }
> >>>>
> >>>>           pcibios_disable_device(dev);
> >>>> }
> >>>>
> >>>> When remove "pci_command &=3D ~PCI_COMMAND_MASTER;", it can work wel=
l when
> >>>> shutdown or reboot.
> >>>>
> >>>> As Oliver O'Halloran said, no need to call pci_disable_device() when
> >>>> actually shutting down, but we should call pci_disable_device() befo=
re
> >>>> handing over to the new kernel on kexec reboot, so we can do some
> >>>> condition checks which are already executed afterwards by the functi=
on
> >>>> pci_device_shutdown(), this is done by commit 4fc9bbf98fd6 ("PCI: Di=
sable
> >>>> Bus Master only on kexec reboot") and commit 6e0eda3c3898 ("PCI: Don=
't try
> >>>> to disable Bus Master on disconnected PCI devices").
> >>>>
> >>>> drivers/pci/pci-driver.c
> >>>> static void pci_device_shutdown(struct device *dev)
> >>>> {
> >>>>    ...
> >>>>           if (drv && drv->shutdown)
> >>>>                   drv->shutdown(pci_dev);
> >>>>
> >>>>           /*
> >>>>            * If this is a kexec reboot, turn off Bus Master bit on t=
he
> >>>>            * device to tell it to not continue to do DMA. Don't touc=
h
> >>>>            * devices in D3cold or unknown states.
> >>>>            * If it is not a kexec reboot, firmware will hit the PCI
> >>>>            * devices with big hammer and stop their DMA any way.
> >>>>            */
> >>>>           if (kexec_in_progress && (pci_dev->current_state <=3D PCI_=
D3hot))
> >>>>                   pci_clear_master(pci_dev);
> >>>> }
> >>>>
> >>>> [   36.159446] Call Trace:
> >>>> [   36.241688] [<ffffffff80211434>] show_stack+0x9c/0x130
> >>>> [   36.326619] [<ffffffff80661b70>] dump_stack+0xb0/0xf0
> >>>> [   36.410403] [<ffffffff806a8240>] pcie_portdrv_shutdown+0x18/0x78
> >>>> [   36.495302] [<ffffffff8069c6b4>] pci_device_shutdown+0x44/0x90
> >>>> [   36.580027] [<ffffffff807aac90>] device_shutdown+0x130/0x290
> >>>> [   36.664486] [<ffffffff80265448>] kernel_power_off+0x38/0x80
> >>>> [   36.748272] [<ffffffff80265634>] __do_sys_reboot+0x1a4/0x258
> >>>> [   36.831985] [<ffffffff80218b90>] syscall_common+0x34/0x58
> >>>>
> >>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>> ---
> >>>>    drivers/pci/pcie/portdrv_core.c |  1 -
> >>>>    drivers/pci/pcie/portdrv_pci.c  | 14 +++++++++++++-
> >>>>    2 files changed, 13 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/port=
drv_core.c
> >>>> index 50a9522..1991aca 100644
> >>>> --- a/drivers/pci/pcie/portdrv_core.c
> >>>> +++ b/drivers/pci/pcie/portdrv_core.c
> >>>> @@ -491,7 +491,6 @@ void pcie_port_device_remove(struct pci_dev *dev=
)
> >>>>    {
> >>>>           device_for_each_child(&dev->dev, NULL, remove_iter);
> >>>>           pci_free_irq_vectors(dev);
> >>>> -       pci_disable_device(dev);
> >>>>    }
> >>>>
> >>>>    /**
> >>>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portd=
rv_pci.c
> >>>> index 3a3ce40..cab37a8 100644
> >>>> --- a/drivers/pci/pcie/portdrv_pci.c
> >>>> +++ b/drivers/pci/pcie/portdrv_pci.c
> >>>> @@ -143,6 +143,18 @@ static void pcie_portdrv_remove(struct pci_dev =
*dev)
> >>>>           }
> >>>>
> >>>>           pcie_port_device_remove(dev);
> >>>> +       pci_disable_device(dev);
> >>>> +}
> >>>> +
> >>>> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> >>>> +{
> >>>> +       if (pci_bridge_d3_possible(dev)) {
> >>>> +               pm_runtime_forbid(&dev->dev);
> >>>> +               pm_runtime_get_noresume(&dev->dev);
> >>>> +               pm_runtime_dont_use_autosuspend(&dev->dev);
> >>>> +       }
> >>>> +
> >>>> +       pcie_port_device_remove(dev);
> >>>>    }
> >>>>
> >>>>    static pci_ers_result_t pcie_portdrv_error_detected(struct pci_de=
v *dev,
> >>>> @@ -211,7 +223,7 @@ static struct pci_driver pcie_portdriver =3D {
> >>>>
> >>>>           .probe          =3D pcie_portdrv_probe,
> >>>>           .remove         =3D pcie_portdrv_remove,
> >>>> -       .shutdown       =3D pcie_portdrv_remove,
> >>>> +       .shutdown       =3D pcie_portdrv_shutdown,
> >>>>
> >>>>           .err_handler    =3D &pcie_portdrv_err_handler,
> >>>>
> >>>> --
> >>>> 2.1.0
>
