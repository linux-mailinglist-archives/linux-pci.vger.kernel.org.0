Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26265E303
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 03:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjAECuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 21:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjAECuI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 21:50:08 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA5143A22
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 18:50:06 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id vm8so80231601ejc.2
        for <linux-pci@vger.kernel.org>; Wed, 04 Jan 2023 18:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4SrsnuB2o4Pj9gPfY4Sket6FOQNNpO/Q6/Ml24N/9kM=;
        b=MB2PsvLwLk6/nfvF9ArZDJIukojcF7br8j9571LDAzbzu6ZGuS4Mgme6vAgHDGOKwq
         gP6UrAwrDh14xcbKVNrQ0FSaKXbzMjKlqurCfH1U7rslaPjlhmMrZyqRnj4lpOUT6zcC
         lE3JH322uD39EGAO8MXTipaKXHOwQL8M1NQ7EOnDS1rjqIPS6xHydoaVv2224OSHpeTv
         nCGaVyGjRsMtyF9lDNZ1WBu7ubq8DuiwPDDmoqDm8uDVY//KFZhz771bXaPC/KU5iFbl
         cfd6/qtK+DEMWEqfy7wPJupeD7ObSoODkwntkmPJrSKG3+O27W4F25b55Ueb3iChZBn3
         Qi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SrsnuB2o4Pj9gPfY4Sket6FOQNNpO/Q6/Ml24N/9kM=;
        b=BxiCUE+ZQeXqSUQ3YzVRoJq6Pf8DtN3mcRfusNiG2ljn1aSEnLPD7uORklas2GAdv2
         tiTgb6xYU7HqQVKsms3Ok3eubZNMlKwdGeItpfqNNtSxvYOjGRJab9HboK5l8gikd8kb
         Ctd4EW8Q7iHGflk4tboErUoXVvWPTcTEhBx/fKLM8xc0SM0E2IcdV922vXlQX6izo7rG
         OO4j5Fnb+wmW5EVbYJ+3nU0gC93EzKiSb45BdoS/MV7stavOtGb+kotFD7WVcuL4YxNf
         qja3YXouuQifxr45Q9hgWL+gumtGlzYZ7NyvNc5qlfzOXyodSXvqrsaVN67QaEeMFFPl
         zX8Q==
X-Gm-Message-State: AFqh2krBNKQE0ZNScmEdTiNKMq04gDtjigpuWt9sewer7SZMUX4pRDUZ
        nXITIskZvBlgmA4WY0zxLva+ByQnn7g85mlM3Qk=
X-Google-Smtp-Source: AMrXdXv+K6P/aLMxKtt3ZZUWLrCsqF69VlYhOWcGKqvdu9eUTIpd0sHfM5AG3WO26z3b4b5IXkXnnCu9aP011abja5A=
X-Received: by 2002:a17:906:228f:b0:7c0:e4b6:132e with SMTP id
 p15-20020a170906228f00b007c0e4b6132emr4267613eja.224.1672887004731; Wed, 04
 Jan 2023 18:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20230103073401.1256736-3-chenhuacai@loongson.cn> <20230104183712.GA1082132@bhelgaas>
In-Reply-To: <20230104183712.GA1082132@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 5 Jan 2023 10:49:53 +0800
Message-ID: <CAAhV-H5muGHQ=awDckP2Fv6kg_-Mrcpre2ng52yKrTnhpqrVOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: Add quirk for LS7A to avoid reboot failure
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

Hi, Bjorn,

On Thu, Jan 5, 2023 at 2:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Jan 03, 2023 at 03:34:01PM +0800, Huacai Chen wrote:
> > cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe services during shutdown")
> > causes poweroff/reboot failure on systems with LS7A chipset. We found
> > that if we remove "pci_command &= ~PCI_COMMAND_MASTER" in do_pci_disable
> > _device(), it can work well. The hardware engineer says that the root
> > cause is that CPU is still accessing PCIe devices while poweroff/reboot,
>
> Did you ever figure out what these CPU accesses are?  If we call the
> Root Port .shutdown() method, and later access a downstream device,
> that seems like a problem in itself.  At least, we should understand
> exactly *why* we access that downstream device.
Maybe I failed to get the key point, but from my point of view, the
root cause is clear in previous discussions:
https://lore.kernel.org/linux-pci/CAAhV-H5uT+wDRkVbW_o1hG2u0rtv6FFABTymL1VdjMMD_UEN+Q@mail.gmail.com/
https://lore.kernel.org/linux-pci/20220617113708.GA1177054@bhelgaas/
https://lore.kernel.org/linux-pci/CAAhV-H6raQnXZ4ZZRq19cugew26wXYONctcFO0392gZ00LC6bw@mail.gmail.com/

>
> To be clear, cc27b735ad3a does not cause the failure.  IIUC, the cause
> is:
cc27b735ad3a is not a bug, we refer to it just because we observe
problems after it.

>
>   - CPU issues MMIO read to device below Root Port
>
>   - LS7A Root Port fails to forward transaction to secondary bus
>     because of LS7A Bus Master defect
>
>   - CPU hangs waiting for response to MMIO read
>
> > and if we disable the Bus Master Bit at this time, the PCIe controller
> > doesn't forward requests to downstream devices, and also does not send
> > TIMEOUT to CPU, which causes CPU wait forever (hardware deadlock). This
> > behavior is a PCIe protocol violation (Bus Master should not be involved
> > in CPU MMIO transactions), and it will be fixed in new revisions of
> > hardware (add timeout mechanism for CPU read request, whether or not Bus
> > Master bit is cleared).
> >
> > On some x86 platforms, radeon/amdgpu devices can cause similar problems
> > [1][2]. Once before I wanted to make a single patch to solve "all of
> > these problems" together, but it seems unreasonable because maybe they
> > are not exactly the same problem.
>
> I don't know what any of these problems are.  Neither one of these bug
> reports has a root cause analysis, and it's not obvious how they're
> connected to this patch.
radeon/amdgpu devices cause problems and this patch can solve it.
But..., it is very hard to distinguish "whether they are exactly the
same problem".

>
> > So, this patch add a new function
> > pcie_portdrv_shutdown(), a slight modified copy of pcie_portdrv_remove()
> > dedicated for the shutdown path, and then add a quirk just for LS7A to
> > avoid clearing Bus Master bit in pcie_portdrv_shutdown(). Leave other
> > platforms behave as before.
>
> Nit: don't break function names across lines ("do_pci_disable_device()").
OK, I will improve it.

>
> > [1] https://bugs.freedesktop.org/show_bug.cgi?id=97980
> > [2] https://bugs.freedesktop.org/show_bug.cgi?id=98638
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/pci/controller/pci-loongson.c | 17 +++++++++++++++++
> >  drivers/pci/pcie/portdrv.c            | 21 +++++++++++++++++++--
> >  include/linux/pci.h                   |  1 +
> >  3 files changed, 37 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
> > index 759ec211c17b..641308ba4126 100644
> > --- a/drivers/pci/controller/pci-loongson.c
> > +++ b/drivers/pci/controller/pci-loongson.c
> > @@ -93,6 +93,23 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> >                       DEV_PCIE_PORT_2, loongson_mrrs_quirk);
> >
> > +static void loongson_bmaster_quirk(struct pci_dev *pdev)
> > +{
> > +     /*
> > +      * Some Loongson PCIe ports will cause CPU deadlock if disable
> > +      * the Bus Master bit during poweroff/reboot.
>
> This is not actually true, as far as I can see.
>
> It's not turning off Bus Master that causes the problem; it's the MMIO
> read to a downstream device when the Root Port has bus mastering
> disabled that causes the problem.
OK, I will improve the comments.

Huacai
>
> > +      */
> > +     struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
> > +
> > +     bridge->no_dis_bmaster = 1;
> > +}
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_0, loongson_bmaster_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_1, loongson_bmaster_quirk);
> > +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
> > +                     DEV_PCIE_PORT_2, loongson_bmaster_quirk);
> > +
> >  static void loongson_pci_pin_quirk(struct pci_dev *pdev)
> >  {
> >       pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index 2cc2e60bcb39..96f45c444422 100644
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
> > @@ -727,6 +726,24 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
> >       }
> >
> >       pcie_port_device_remove(dev);
> > +
> > +     pci_disable_device(dev);
> > +}
> > +
> > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > +{
> > +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > +
> > +     if (pci_bridge_d3_possible(dev)) {
> > +             pm_runtime_forbid(&dev->dev);
> > +             pm_runtime_get_noresume(&dev->dev);
> > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > +     }
> > +
> > +     pcie_port_device_remove(dev);
> > +
> > +     if (!bridge->no_dis_bmaster)
> > +             pci_disable_device(dev);
> >  }
> >
> >  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> > @@ -777,7 +794,7 @@ static struct pci_driver pcie_portdriver = {
> >
> >       .probe          = pcie_portdrv_probe,
> >       .remove         = pcie_portdrv_remove,
> > -     .shutdown       = pcie_portdrv_remove,
> > +     .shutdown       = pcie_portdrv_shutdown,
> >
> >       .err_handler    = &pcie_portdrv_err_handler,
> >
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 3df2049ec4a8..a64dbcb89231 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -573,6 +573,7 @@ struct pci_host_bridge {
> >       unsigned int    ignore_reset_delay:1;   /* For entire hierarchy */
> >       unsigned int    no_ext_tags:1;          /* No Extended Tags */
> >       unsigned int    no_inc_mrrs:1;          /* No Increase MRRS */
> > +     unsigned int    no_dis_bmaster:1;       /* No Disable Bus Master */
> >       unsigned int    native_aer:1;           /* OS may use PCIe AER */
> >       unsigned int    native_pcie_hotplug:1;  /* OS may use PCIe hotplug */
> >       unsigned int    native_shpc_hotplug:1;  /* OS may use SHPC hotplug */
> > --
> > 2.31.1
> >
