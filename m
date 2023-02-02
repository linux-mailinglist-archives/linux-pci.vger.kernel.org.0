Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE23E687EAA
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 14:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjBBN1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 08:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjBBN1l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 08:27:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F408F511
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 05:27:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cw4so1948390edb.13
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TAhdOMY2IpEKV3j772Aug0m4nuz6kVmkHSKpv8d76Ao=;
        b=LxQLTs5yFxpd0Xcoa5P0wER4MW04r7FuXkDM6EmbeLmHH9pxRBdYySmWn8GAlLj6rb
         rY+zgEbG9tmW1P2Yj1Jg0wsaRiGeLlTnryXXxFyUcrnbzvul/C8Xzc86LoJmU+rdK3Fh
         eAkQ90MpP4IiBJSJmmvDXuVQ6UMDUK9Po9ygQkTsFL0VWV/iWGmIMVzE/HvTZgBWV9J3
         ZwFb2oSstkMBoRstQ+1VutEuB6NnyHIgcDWX5KBN6SaclouPI9cpdAz+39GNwek+aCYa
         cdMopjwGPz9Poyu/Y3UfZODgRyZFew5hxKZz9SFiC1O/VvEAjPT3rNJP6le9rpZ75eJT
         i6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAhdOMY2IpEKV3j772Aug0m4nuz6kVmkHSKpv8d76Ao=;
        b=DlQm/8vWBtK6T92yfLwdZWiHsC8JuHgqqMLz0NjZIf/Toj3qPUF9cN7UkcShsiQ95A
         dL8JA4lvSMHxscPE4JoQLAhCWZIYVvp5YKOeayXUiOO4JvP+UK0+o4ERSM8KLshFdQON
         zs6NLPNSRYFtyhkrbr5VNU9kI+do4l7mHMyBqyCyNH1E3184NEgKyQVTysrHDJ6O1tuy
         qLDDFd2zowXh4CKL/YykFKSNYTxyl25+oxQcPBY3qhDt1chYB9AUGUUT+KFFSlXHsrk2
         EmAD/c5ZJHgai6rE739AJuK60blxRv+kAusR0QTIA967PdqXaRKTJRj5Gd5z/8Dryz4L
         WPPw==
X-Gm-Message-State: AO0yUKUuzr59KO92hkRQfVtA56nY4jeouQ79YjRgWu1gd2rWyUDX9116
        MdSV3XN7sneQ9T3grVz/2uqw0JxhHSQFWzYWm7Yt4CQSJYR+d55w
X-Google-Smtp-Source: AK7set82/93yQm+LxXHW06uWazNGka6PfcMui9aGUTgFXuhRhCOHvZGA/9ZdkM94uYILvosXpJ116Ihmpsp9Fy6VMBM=
X-Received: by 2002:aa7:d791:0:b0:4a0:906e:18b8 with SMTP id
 s17-20020aa7d791000000b004a0906e18b8mr1866023edq.71.1675344433535; Thu, 02
 Feb 2023 05:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20230201043018.778499-2-chenhuacai@loongson.cn> <20230201181736.GA1879841@bhelgaas>
In-Reply-To: <20230201181736.GA1879841@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Feb 2023 21:27:03 +0800
Message-ID: <CAAhV-H5fgG5uV5Zy6BsmwPpuhuog_L11TjWr4A82nbAcmHSj2w@mail.gmail.com>
Subject: Re: [PATCH V4 1/2] PCI: Omit pci_disable_device() in .shutdown()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Thu, Feb 2, 2023 at 2:17 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Feb 01, 2023 at 12:30:17PM +0800, Huacai Chen wrote:
> > This patch has a long story.
> >
> > After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during
> > shutdown") we observe poweroff/reboot failures on systems with LS7A
> > chipset.
> >
> > We found that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in
> > do_pci_disable_device(), it can work well. The hardware engineer says
> > that the root cause is that CPU is still accessing PCIe devices while
> > poweroff/reboot, and if we disable the Bus Master Bit at this time, the
> > PCIe controller doesn't forward requests to downstream devices, and also
> > does not send TIMEOUT to CPU, which causes CPU wait forever (hardware
> > deadlock).
> >
> > To be clear, the sequence is like this:
> >
> >   - CPU issues MMIO read to device below Root Port
> >
> >   - LS7A Root Port fails to forward transaction to secondary bus
> >     because of LS7A Bus Master defect
> >
> >   - CPU hangs waiting for response to MMIO read
> >
> > Then how is userspace able to use a device after the device is removed?
> >
> > To give more details, let's take the graphics driver (e.g. amdgpu) as
> > an example. The userspace programs call printf() to display "shutting
> > down xxx service" during shutdown/reboot, or the kernel calls printk()
> > to display something during shutdown/reboot. These can happen at any
> > time, even after we call pcie_port_device_remove() to disable the pcie
> > port on the graphic card.
> >
> > The call stack is: printk() --> call_console_drivers() --> con->write()
> > --> vt_console_print() --> fbcon_putcs()
> >
> > This scenario happens because userspace programs (or the kernel itself)
> > don't know whether a device is 'usable', they just use it, at any time.
> >
> > This hardware behavior is a PCIe protocol violation (Bus Master should
> > not be involved in CPU MMIO transactions), and it will be fixed in new
> > revisions of hardware (add timeout mechanism for CPU read request,
> > whether or not Bus Master bit is cleared).
> >
> > On some x86 platforms, radeon/amdgpu devices can cause similar problems
> > [1][2].
> >
> > Once before I add a quirk to solve the LS7A problem but looks ugly.
> > After long time discussions, Bjorn Helgaas suggest simply remove the
> > pci_disable_device() in pcie_portdrv_shutdown() and this patch do it
> > exactly.
> >
> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> > [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/pcie/portdrv.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 2cc2e60bcb39..46fad0d813b2 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -501,7 +501,6 @@ static void pcie_port_device_remove(struct pci_dev *dev)
> >  {
> >       device_for_each_child(&dev->dev, NULL, remove_iter);
> >       pci_free_irq_vectors(dev);
> > -     pci_disable_device(dev);
> >  }
> >
> >  /**
> > @@ -727,6 +726,19 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
> >       }
> >
> >       pcie_port_device_remove(dev);
> > +
> > +     pci_disable_device(dev);
> > +}
> > +
> > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > +{
> > +     if (pci_bridge_d3_possible(dev)) {
> > +             pm_runtime_forbid(&dev->dev);
> > +             pm_runtime_get_noresume(&dev->dev);
> > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > +     }
> > +
> > +     pcie_port_device_remove(dev);
>
> Thanks!  I guess you verified that this actually *does* call all the
> port service .remove() methods, right?  aer_remove(), dpc_remove(),
> etc?
I have tested, but aer_probe(), dpc_probe() doesn't get called at
boot, so does aer_remove(), dpc_remove() when poweroff. I haven't got
the root cause but I will continue to investigate.

Huacai
>
> I *assume* that happens via the device_unregister() done in
> remove_iter(), but there's a LOT of code in the middle.
>
> >  }
> >
> >  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> > @@ -777,7 +789,7 @@ static struct pci_driver pcie_portdriver = {
> >
> >       .probe          = pcie_portdrv_probe,
> >       .remove         = pcie_portdrv_remove,
> > -     .shutdown       = pcie_portdrv_remove,
> > +     .shutdown       = pcie_portdrv_shutdown,
> >
> >       .err_handler    = &pcie_portdrv_err_handler,
> >
> > --
> > 2.39.0
> >
