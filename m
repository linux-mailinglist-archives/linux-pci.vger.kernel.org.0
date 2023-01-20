Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB56755D4
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 14:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjATNcB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 08:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjATNcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 08:32:00 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B369239;
        Fri, 20 Jan 2023 05:31:58 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vw16so13917386ejc.12;
        Fri, 20 Jan 2023 05:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nde/dPGS0FPJ8JpZGh+6kUxIl42whIPsCxNpIsxQpOE=;
        b=fKUGfsM/IcryNQY1pkBufsnQMaKrIPw9kLRmsxS3CUKb0VqPZ77g5LGDZOvqU4ziHJ
         d3iPwDmqCoge8BQkBffuQWiGpS7P7jaRC7jFdsYO3R15BInDfJlJ2bG24DxG22BSO+iO
         SGNwYJ8Nc1BO6ntTJ8p89/JHO0JW3U3LtfwqmOJ2MX5AC6/Sa0sr/Gpm/BL8iUPR8TbI
         WNR9WcDnwc9jq739yr8omyYiSlZW9vaF7YF9FetiOLT4lCtCAv7VTRZXaVw7fFcWHN0c
         LAwBom9u6Z0chlu4SFHomwToLyCNXRepzBqQcdbxK4q3WzCZcvu0FbIPGvbkG7bUZnv9
         kXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nde/dPGS0FPJ8JpZGh+6kUxIl42whIPsCxNpIsxQpOE=;
        b=18ZbmHC9NTbfDmfPWOg7ll+QLd3x34eDS2Gay+eRCMuss+MjhS56McPVNHSNp6XYVA
         h1ZiGBop0pEpLZEe4xIspngo7C3zhXG4pwmgDaMbhOA9WtpnNtUxOrAkdVfMUibbVTS/
         jKhU0Xv/J3oD6Onu927GGtHk6NYHf1oV6E0jeqXqwBlovXaw4vGbUo2UibERf6C1PkxW
         eTHn9rYigME3W+Ak8nr6RmPtPoHVNmJhK9rH+amiMTATuw9LRg/9TlZuL+9JJ2wReJyP
         TKsLK6XVCnDLgcxI3PBVB26I6UoCEPFapYi9iiNqIkUjKXEthuEmEeakFQ3zIWsgC959
         YFUw==
X-Gm-Message-State: AFqh2kpi+u3a7Jk6wsxL6BegJ5m/OBZCDgZ5mWp0reJ8bpMf9T/NYZUk
        GtR5jz++O+FTDnCrUYdpEdgRVm05YYS/spKnrZxYGhsk
X-Google-Smtp-Source: AMrXdXs1SYEJpHm89HMW8rjlMG5VatElbSbLrz6GJhPVENxfYgLTIR1O82GwZeAkkUNVgG6A6u7jGvTOlwiKrWrSAY0=
X-Received: by 2002:a17:906:a09:b0:7a3:fc74:7fb4 with SMTP id
 w9-20020a1709060a0900b007a3fc747fb4mr1994624ejf.17.1674221517317; Fri, 20 Jan
 2023 05:31:57 -0800 (PST)
MIME-Version: 1.0
References: <CAAhV-H5PTMSWNF36MAkZv+xk=dqhF8Et5YynYZPAqyAxMQRcaw@mail.gmail.com>
 <20230119125000.GA315545@bhelgaas>
In-Reply-To: <20230119125000.GA315545@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 20 Jan 2023 21:31:43 +0800
Message-ID: <CAAhV-H59FLAFGD8oDZGjXWgL2ei_L=rYAaFWWp1skUT9nUPVYg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] PCI: Add quirk for LS7A to avoid reboot failure
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Thu, Jan 19, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Jan 19, 2023 at 08:25:20PM +0800, Huacai Chen wrote:
> > Ping?
>
> I suggested another possible way to do this that wasn't so much of a
> special case.  Did you explore that at all?
That is a little difficult for me, but what is worse is that the root
cause doesn't come from gpu or console drivers, but from the root
port. That means: even if we can workaround the gpu issue in another
way, there are still problems on other devices. Besides the graphics
card, the most frequent problematic device is the sata controller
connected on LS7A chipset, there are incomplete I/O accesses after the
root port disabled and also cause reboot failure.

Huacai
>
> I know there's no *existing* way to mark devices that we need to use
> all the way through shutdown or reboot, but if it makes sense, there's
> no reason we couldn't add one.  That has the potential of being more
> generic, e.g., we could do it for all console devices, as opposed to
> quirking a Root Port that just happens to be in the path to the
> console.
>
> > On Sat, Jan 7, 2023 at 10:25 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > >
> > > On Fri, Jan 6, 2023 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Rafael, linux-pm, linux-kernel in case you have comments on
> > > > whether devices should still be usable after .remove()/.shutdown()]
> > > >
> > > > On Fri, Jan 06, 2023 at 05:51:43PM +0800, Huacai Chen wrote:
> > > > > After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during
> > > > > shutdown") we observe poweroff/reboot failures on systems with LS7A
> > > > > chipset.
> > > > >
> > > > > We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in
> > > > > do_pci_disable_device(), it can work well. The hardware engineer says
> > > > > that the root cause is that CPU is still accessing PCIe devices while
> > > > > poweroff/reboot, and if we disable the Bus Master Bit at this time, the
> > > > > PCIe controller doesn't forward requests to downstream devices, and also
> > > > > does not send TIMEOUT to CPU, which causes CPU wait forever (hardware
> > > > > deadlock).
> > > > >
> > > > > To be clear, the sequence is like this:
> > > > >
> > > > >   - CPU issues MMIO read to device below Root Port
> > > > >
> > > > >   - LS7A Root Port fails to forward transaction to secondary bus
> > > > >     because of LS7A Bus Master defect
> > > > >
> > > > >   - CPU hangs waiting for response to MMIO read
> > > > >
> > > > > Then how is userspace able to use a device after the device is removed?
> > > > >
> > > > > To give more details, let's take the graphics driver (e.g. amdgpu) as
> > > > > an example. The userspace programs call printf() to display "shutting
> > > > > down xxx service" during shutdown/reboot, or the kernel calls printk()
> > > > > to display something during shutdown/reboot. These can happen at any
> > > > > time, even after we call pcie_port_device_remove() to disable the pcie
> > > > > port on the graphic card.
> > > > >
> > > > > The call stack is: printk() --> call_console_drivers() --> con->write()
> > > > > --> vt_console_print() --> fbcon_putcs()
> > > > >
> > > > > This scenario happens because userspace programs (or the kernel itself)
> > > > > don't know whether a device is 'usable', they just use it, at any time.
> > > >
> > > > Thanks for this background.  So basically we want to call .remove() on
> > > > a console device (or a bridge leading to it), but we expect it to keep
> > > > working as usual afterwards?
> > > >
> > > > That seems a little weird.  Is that the design we want?  Maybe we
> > > > should have a way to mark devices so we don't remove them during
> > > > shutdown or reboot?
> > > Sounds reasonable, but it seems no existing way can mark this.
> > >
> > > Huacai
> > > >
> > > > > This hardware behavior is a PCIe protocol violation (Bus Master should
> > > > > not be involved in CPU MMIO transactions), and it will be fixed in new
> > > > > revisions of hardware (add timeout mechanism for CPU read request,
> > > > > whether or not Bus Master bit is cleared).
> > > > >
> > > > > On some x86 platforms, radeon/amdgpu devices can cause similar problems
> > > > > [1][2]. Once before I wanted to make a single patch to solve "all of
> > > > > these problems" together, but it seems unreasonable because maybe they
> > > > > are not exactly the same problem. So, this patch add a new function
> > > > > pcie_portdrv_shutdown(), a slight modified copy of pcie_portdrv_remove()
> > > > > dedicated for the shutdown path, and then add a quirk just for LS7A to
> > > > > avoid clearing Bus Master bit in pcie_portdrv_shutdown(). Leave other
> > > > > platforms behave as before.
> > > > >
> > > > > [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> > > > > [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> > > > >
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > ---
> > > > >  drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
> > > > >  drivers/pci/pcie/portdrv.c            | 21 +++++++++++++++++++--
> > > > >  include/linux/pci.h                   |  1 +
> > > > >  3 files changed, 37 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > > > > index 759ec211c17b..641308ba4126 100644
> > > > > --- a/drivers/pci/controller/pci-loongson.c
> > > > > +++ b/drivers/pci/controller/pci-loongson.c
> > > > > @@ -93,6 +93,24 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > > >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > > >                       DEV_PCIE_PORT_2, loongson_mrrs_quirk);
> > > > >
> > > > > +static void loongson_bmaster_quirk(struct pci_dev *pdev)
> > > > > +{
> > > > > +     /*
> > > > > +      * Some Loongson PCIe ports will cause CPU deadlock if there is
> > > > > +      * MMIO access to a downstream device when the root port disable
> > > > > +      * the Bus Master bit during poweroff/reboot.
> > > > > +      */
> > > > > +     struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > > > > +
> > > > > +     bridge->no_dis_bmaster = 1;
> > > > > +}
> > > > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > > > +                     DEV_PCIE_PORT_0, loongson_bmaster_quirk);
> > > > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > > > +                     DEV_PCIE_PORT_1, loongson_bmaster_quirk);
> > > > > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > > > > +                     DEV_PCIE_PORT_2, loongson_bmaster_quirk);
> > > > > +
> > > > >  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
> > > > >  {
> > > > >       pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> > > > > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > > > > index 2cc2e60bcb39..96f45c444422 100644
> > > > > --- a/drivers/pci/pcie/portdrv.c
> > > > > +++ b/drivers/pci/pcie/portdrv.c
> > > > > @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
> > > > >  {
> > > > >       device_for_each_child(&dev->dev, NULL, remove_iter);
> > > > >       pci_free_irq_vectors(dev);
> > > > > -     pci_disable_device(dev);
> > > > >  }
> > > > >
> > > > >  /**
> > > > > @@ -727,6 +726,24 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
> > > > >       }
> > > > >
> > > > >       pcie_port_device_remove(dev);
> > > > > +
> > > > > +     pci_disable_device(dev);
> > > > > +}
> > > > > +
> > > > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > > > +{
> > > > > +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > > > > +
> > > > > +     if (pci_bridge_d3_possible(dev)) {
> > > > > +             pm_runtime_forbid(&dev->dev);
> > > > > +             pm_runtime_get_noresume(&dev->dev);
> > > > > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > > > > +     }
> > > > > +
> > > > > +     pcie_port_device_remove(dev);
> > > > > +
> > > > > +     if (!bridge->no_dis_bmaster)
> > > > > +             pci_disable_device(dev);
> > > > >  }
> > > > >
> > > > >  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> > > > > @@ -777,7 +794,7 @@ static struct pci_driver pcie_portdriver = {
> > > > >
> > > > >       .probe          = pcie_portdrv_probe,
> > > > >       .remove         = pcie_portdrv_remove,
> > > > > -     .shutdown       = pcie_portdrv_remove,
> > > > > +     .shutdown       = pcie_portdrv_shutdown,
> > > > >
> > > > >       .err_handler    = &pcie_portdrv_err_handler,
> > > > >
> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > index 3df2049ec4a8..a64dbcb89231 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -573,6 +573,7 @@ struct pci_host_bridge {
> > > > >       unsigned int    ignore_reset_delay:1;   /* For entire hierarchy */
> > > > >       unsigned int    no_ext_tags:1;          /* No Extended Tags */
> > > > >       unsigned int    no_inc_mrrs:1;          /* No Increase MRRS */
> > > > > +     unsigned int    no_dis_bmaster:1;       /* No Disable Bus Master */
> > > > >       unsigned int    native_aer:1;           /* OS may use PCIe AER */
> > > > >       unsigned int    native_pcie_hotplug:1;  /* OS may use PCIe hotplug */
> > > > >       unsigned int    native_shpc_hotplug:1;  /* OS may use SHPC hotplug */
> > > > > --
> > > > > 2.31.1
> > > > >
