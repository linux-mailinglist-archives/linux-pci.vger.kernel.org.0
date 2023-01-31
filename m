Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7DC682C1D
	for <lists+linux-pci@lfdr.de>; Tue, 31 Jan 2023 13:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjAaMCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 07:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjAaMCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 07:02:33 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24B23DA6;
        Tue, 31 Jan 2023 04:02:32 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k4so35415739eje.1;
        Tue, 31 Jan 2023 04:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zOE3n5tsny49BAFSOM6oUGpa40l5XLfmNc4uIHyRbK0=;
        b=LqUk6plf71gaYP3cnCZB5zn66wJBzJgufctGOQ6DFYdxXd7VSn5ZZQgbKkaRwVFxAb
         bF5AVIbVfgZoWYXPG0k3uS3uohmLho28fIkgD71XynCXxa4wBq9lUhkpeK0T0adCaZdA
         WnBMwnHuxwAqEeakuJZRVm9+0yCk2P06W0h5UBkPgFLaHwzeq4kXNlKhE8ucm/b0ogv8
         ab1h6RxAP7+sQ17vnrnBdZDWevqjuQWlnzwGJmtgqo86UZXPN0kaVWgJb4IX8ouqp+7w
         F/SJFsrFw4QGZtMKOWpchgmkcAyD0NSG2nGH6pgGJAXJuecmPX4gpZCElIWup7oxX1VX
         rtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOE3n5tsny49BAFSOM6oUGpa40l5XLfmNc4uIHyRbK0=;
        b=Y/MhdVrwXqcf1nOUflZxSeLNqkBSaYw3LIGYjzju0Ijc28EoMpbAZTcqoevOewSjz3
         tcQiCiSOOE09pWFHt2lnItBa+pd7AnkvPRdpXhF6hJ58B0/hfORlYrUFeFr9vO+UfkkV
         lzfxHxOi57rrMvf8qoIN2CamuSotwPAwZuBhVJPRPfATTzviayLNn7JOTGvHl+NnbC10
         Q3ZbupMngvXCJ2KQTWd2RLR0cqGJfIsp6PihRCyo/BAhX67A6UWI7ekef1rZ8yfIFLDC
         EqgPGmQsxbnyAXGRyqkL/bzpB1h9NuEGvTW7ai+F3FUBC8+0TSvdgZhLbS6UNUdAraWY
         HgfA==
X-Gm-Message-State: AFqh2konmX7ED3+XPXZAY+jKkhoVaKe1S45fVN9nWXNnk+2BhkoYRBOY
        Nb9hZ/BxH0ZIwNNjhb9Zl9HnELOfwgorlZ9hNpw=
X-Google-Smtp-Source: AMrXdXvIx+WBALpgzllpK+ENbefAAtcbcpLJHE5LT3dTy+HiOTLDYQlkjkEU/bp8dpnO01qSHD8v48brxWXg0Vd0YOM=
X-Received: by 2002:a17:906:c206:b0:78d:b819:e0e7 with SMTP id
 d6-20020a170906c20600b0078db819e0e7mr8345866ejz.83.1675166550658; Tue, 31 Jan
 2023 04:02:30 -0800 (PST)
MIME-Version: 1.0
References: <CAAhV-H4LDn4YmM6Cwse-yjEeooeyqQ4Gy0gPxN0WS=H6KmuSJw@mail.gmail.com>
 <20230131000118.GA1322972@bhelgaas>
In-Reply-To: <20230131000118.GA1322972@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 31 Jan 2023 20:02:20 +0800
Message-ID: <CAAhV-H5L=ikYPtoG8RxXo8ZMSk4vwhmfNdOoUA3js=iVQK+H9Q@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 8:01 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Jan 21, 2023 at 11:10:09PM +0800, Huacai Chen wrote:
> > On Fri, Jan 20, 2023 at 11:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Fri, Jan 20, 2023 at 09:31:43PM +0800, Huacai Chen wrote:
> > > > On Thu, Jan 19, 2023 at 8:50 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Thu, Jan 19, 2023 at 08:25:20PM +0800, Huacai Chen wrote:
> > > > > > Ping?
> > > > >
> > > > > I suggested another possible way to do this that wasn't so much of a
> > > > > special case.  Did you explore that at all?
> > > >
> > > > That is a little difficult for me, but what is worse is that the root
> > > > cause doesn't come from gpu or console drivers, but from the root
> > > > port. That means: even if we can workaround the gpu issue in another
> > > > way, there are still problems on other devices. Besides the graphics
> > > > card, the most frequent problematic device is the sata controller
> > > > connected on LS7A chipset, there are incomplete I/O accesses after the
> > > > root port disabled and also cause reboot failure.
> > >
> > > Yes, SATA sounds like another case where we want to use the device
> > > after we call the driver's remove/shutdown method.  That's not
> > > *worse*, it's just another case where we might have to mark devices
> > > for special handling.
> >
> > That needs too much effort because we need to modify nearly every pci
> > driver, and it exceeds my ability. :)
>
> We would only modify drivers that need this special handling, so it's
> only console/graphics/disks/network/..., well, OK, I see your point,
> it probably *would* be nearly every driver!
>
> > > If we remove/shutdown *any* Root Port, not just LS7A, I think the idea
> > > of assuming downstream devices can continue to work as usual is a
> > > little suspect.  They might continue to work by accident today, but it
> > > doesn't seem like a robust design.
> >
> > The existing design works for so many years, so it is mostly
> > reasonable. For the LS7A case, the root cause comes from the root
> > port, so a workaround on the root port seems somewhat reasonable.
>
> Yeah, I think you're right.  A few more notes below.
>
> > > > > > On Sat, Jan 7, 2023 at 10:25 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > > > > On Fri, Jan 6, 2023 at 11:38 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Fri, Jan 06, 2023 at 05:51:43PM +0800, Huacai Chen wrote:
> > > > > > > > > After cc27b735ad3a7557 ("PCI/portdrv: Turn off PCIe
> > > > > > > > > services during shutdown") we observe poweroff/reboot
> > > > > > > > > failures on systems with LS7A chipset.
> > > > > > > > >
> > > > > > > > > We found that if we remove "pci_command &=
> > > > > > > > > ~PCI_COMMAND_MASTER" in do_pci_disable_device(), it can
> > > > > > > > > work well. The hardware engineer says that the root cause
> > > > > > > > > is that CPU is still accessing PCIe devices while
> > > > > > > > > poweroff/reboot, and if we disable the Bus Master Bit at
> > > > > > > > > this time, the PCIe controller doesn't forward requests to
> > > > > > > > > downstream devices, and also does not send TIMEOUT to CPU,
> > > > > > > > > which causes CPU wait forever (hardware deadlock).
> > > > > > > > >
> > > > > > > > > To be clear, the sequence is like this:
> > > > > > > > >
> > > > > > > > >   - CPU issues MMIO read to device below Root Port
> > > > > > > > >
> > > > > > > > >   - LS7A Root Port fails to forward transaction to secondary bus
> > > > > > > > >     because of LS7A Bus Master defect
> > > > > > > > >
> > > > > > > > >   - CPU hangs waiting for response to MMIO read
> > ...
>
> > > > > > > > > +
> > > > > > > > > +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> > > > > > > > > +{
> > > > > > > > > +     struct pci_host_bridge *bridge = pci_find_host_bridge(dev->bus);
> > > > > > > > > +
> > > > > > > > > +     if (pci_bridge_d3_possible(dev)) {
> > > > > > > > > +             pm_runtime_forbid(&dev->dev);
> > > > > > > > > +             pm_runtime_get_noresume(&dev->dev);
> > > > > > > > > +             pm_runtime_dont_use_autosuspend(&dev->dev);
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     pcie_port_device_remove(dev);
> > > > > > > > > +
> > > > > > > > > +     if (!bridge->no_dis_bmaster)
> > > > > > > > > +             pci_disable_device(dev);
>
> I think there's an argument that pcie_portdrv_shutdown() doesn't
> actually need to clear bus mastering on *any* platform.
>
> For reboot and poweroff, we only use .shutdown(), and .shutdown() only
> needs to stop DMA and interrupts.  Clearing bus master enable stops
> MSI/MSI-X since that's a DMA, but doesn't do anything to stop INTx,
> which portdrv does use in some cases.
>
> But those .remove() methods *do* clear the interrupt enables for each
> service (PCI_ERR_ROOT_COMMAND, PCI_EXP_DPC_CTL, PCI_EXP_SLTCTL, and
> PCI_EXP_RTCTL), so all the interrupts should be disabled regardless of
> whether they are MSI/MSI-X or INTx, even without disabling bus
> mastering.
>
> So I would argue that omitting the pci_disable_device() here might be
> enough, and we wouldn't need the quirk at all.
Emm, this seems much simpler and cleaner, I will send a new version
these days, thank you.

Huacai
>
> Bjorn
