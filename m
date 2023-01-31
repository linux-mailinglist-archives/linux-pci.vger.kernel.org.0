Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB37682051
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 01:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjAaACH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Jan 2023 19:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjAaABt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2023 19:01:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B1730B25;
        Mon, 30 Jan 2023 16:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE21A6131F;
        Tue, 31 Jan 2023 00:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC897C433EF;
        Tue, 31 Jan 2023 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675123280;
        bh=CHPwyXwrlUp2cym1Ex88j+UZaK/fPmtpJjBJE9f7Mbw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JSo144KCujPACvf6R1aEKxYHAELzz4gRiOGWstaDeRWwgS3o/NKn57oS/lY/XVGkh
         t+ehzsjMmvi4nV/XLEB1mWcvaHNeTOpOLDFydaeQV2feL5dL7Vmp8Yx4C+ytHvVUV/
         raCzEBaGKa81cbLO2ZATXBNQEAr95/HMiN1MzRL9JuxAcsuwzaEMsFGQrUR/SVD37e
         cvS6gLnSr3UnDUiVd0L8X6kJdHDPdC7J4isxjJPi8RW8Hby9WuHsXy8tRi6I3O2r56
         ZHp1ZNNVpeA2l61SBR/fLfngXOZy06MJyQCGCWmqjznr8qRhbKz42i4TMgRkFBbUmt
         2CWjT6Q6REtQw==
Date:   Mon, 30 Jan 2023 18:01:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20230131000118.GA1322972@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H4LDn4YmM6Cwse-yjEeooeyqQ4Gy0gPxN0WS=H6KmuSJw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 21, 2023 at 11:10:09PM +0800, Huacai Chen wrote:
> On Fri, Jan 20, 2023 at 11:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jan 20, 2023 at 09:31:43PM +0800, Huacai Chen wrote:
> > > On Thu, Jan 19, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Jan 19, 2023 at 08:25:20PM +0800, Huacai Chen wrote:
> > > > > Ping?
> > > >
> > > > I suggested another possible way to do this that wasn't so much of a
> > > > special case.  Did you explore that at all?
> > >
> > > That is a little difficult for me, but what is worse is that the root
> > > cause doesn't come from gpu or console drivers, but from the root
> > > port. That means: even if we can workaround the gpu issue in another
> > > way, there are still problems on other devices. Besides the graphics
> > > card, the most frequent problematic device is the sata controller
> > > connected on LS7A chipset, there are incomplete I/O accesses after the
> > > root port disabled and also cause reboot failure.
> >
> > Yes, SATA sounds like another case where we want to use the device
> > after we call the driver's remove/shutdown method.  That's not
> > *worse*, it's just another case where we might have to mark devices
> > for special handling.
>
> That needs too much effort because we need to modify nearly every pci
> driver, and it exceeds my ability. :)

We would only modify drivers that need this special handling, so it's
only console/graphics/disks/network/..., well, OK, I see your point,
it probably *would* be nearly every driver!

> > If we remove/shutdown *any* Root Port, not just LS7A, I think the idea
> > of assuming downstream devices can continue to work as usual is a
> > little suspect.  They might continue to work by accident today, but it
> > doesn't seem like a robust design.
>
> The existing design works for so many years, so it is mostly
> reasonable. For the LS7A case, the root cause comes from the root
> port, so a workaround on the root port seems somewhat reasonable.

Yeah, I think you're right.  A few more notes below.

> > > > > On Sat, Jan 7, 2023 at 10:25 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > > On Fri, Jan 6, 2023 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Fri, Jan 06, 2023 at 05:51:43PM +0800, Huacai Chen wrote:
> > > > > > > > After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe
> > > > > > > > services during shutdown") we observe poweroff/reboot
> > > > > > > > failures on systems with LS7A chipset.
> > > > > > > >
> > > > > > > > We found that if we remove "pci_command &=
> > > > > > > > ~PCI_COMMAND_MASTER" in do_pci_disable_device(), it can
> > > > > > > > work well. The hardware engineer says that the root cause
> > > > > > > > is that CPU is still accessing PCIe devices while
> > > > > > > > poweroff/reboot, and if we disable the Bus Master Bit at
> > > > > > > > this time, the PCIe controller doesn't forward requests to
> > > > > > > > downstream devices, and also does not send TIMEOUT to CPU,
> > > > > > > > which causes CPU wait forever (hardware deadlock).
> > > > > > > >
> > > > > > > > To be clear, the sequence is like this:
> > > > > > > >
> > > > > > > >   - CPU issues MMIO read to device below Root Port
> > > > > > > >
> > > > > > > >   - LS7A Root Port fails to forward transaction to secondary bus
> > > > > > > >     because of LS7A Bus Master defect
> > > > > > > >
> > > > > > > >   - CPU hangs waiting for response to MMIO read
> ...

> > > > > > > > +
> > > > > > > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > > > > > > +{
> > > > > > > > +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > > > > > > > +
> > > > > > > > +     if (pci_bridge_d3_possible(dev)) {
> > > > > > > > +             pm_runtime_forbid(&dev->dev);
> > > > > > > > +             pm_runtime_get_noresume(&dev->dev);
> > > > > > > > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > > > > > > > +     }
> > > > > > > > +
> > > > > > > > +     pcie_port_device_remove(dev);
> > > > > > > > +
> > > > > > > > +     if (!bridge->no_dis_bmaster)
> > > > > > > > +             pci_disable_device(dev);

I think there's an argument that pcie_portdrv_shutdown() doesn't
actually need to clear bus mastering on *any* platform.

For reboot and poweroff, we only use .shutdown(), and .shutdown() only
needs to stop DMA and interrupts.  Clearing bus master enable stops
MSI/MSI-X since that's a DMA, but doesn't do anything to stop INTx,
which portdrv does use in some cases.

But those .remove() methods *do* clear the interrupt enables for each
service (PCI_ERR_ROOT_COMMAND, PCI_EXP_DPC_CTL, PCI_EXP_SLTCTL, and
PCI_EXP_RTCTL), so all the interrupts should be disabled regardless of
whether they are MSI/MSI-X or INTx, even without disabling bus
mastering.

So I would argue that omitting the pci_disable_device() here might be
enough, and we wouldn't need the quirk at all.

Bjorn
