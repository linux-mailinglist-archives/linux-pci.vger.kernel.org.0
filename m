Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338E553BC87
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiFBQ3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiFBQ3j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:29:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216A2632B4
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 09:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C984615B3
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 16:29:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BC2C385A5;
        Thu,  2 Jun 2022 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654187377;
        bh=J1PrWlIrY2xAUApKjn8//ZkQZSRmjNdlWOBUQAicRYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S2jYOGVgG+5o/KQq6U8NkEUrAFg26Zu253xA5LppV+bJBenq9WGCZ4D7Fk7LM5rtU
         O2hXFpiU2yisNZjhTzKBVG7BitT2AhvwWEAF56Ik5rqT/oCKro6qZWojN6gsEGOBE6
         EBPxligc70vdJTn3njryv0JRiq4nsY0dm8+7Cf04r6o1J/pV4Wy8CfAaAu6yaMde42
         sx1IsMVH3KqXCdFxIP+oIm/XDOP1AN6+s7/w5GlV23JYBU5R/tpaxtbBMpGflnDBY6
         hvUZehcWCwtAOu2IumKBKv9xgdq3MonbkjCIde6i2xoCs/Mv/27GYh0Q87hYVJuznW
         TEz+dbqEPVjzg==
Date:   Thu, 2 Jun 2022 11:29:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V13 5/6] PCI: Add quirk for LS7A to avoid reboot failure
Message-ID: <20220602162935.GA21834@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H49bwGf8=qs3GSLv-7wZHv_mW05kY4OktgvDviuscgVrg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 08:48:20PM +0800, Huacai Chen wrote:
> Hi, Bjorn,
> 
> On Wed, Jun 1, 2022 at 7:35 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Sat, Apr 30, 2022 at 04:48:45PM +0800, Huacai Chen wrote:
> > > Commit cc27b735ad3a75574a ("PCI/portdrv: Turn off PCIe services
> > > during shutdown") causes poweroff/reboot failure on systems with
> > > LS7A chipset.  We found that if we remove "pci_command &=
> > > ~PCI_COMMAND_MASTER;" in do_pci_disable_device(), it can work
> > > well. The hardware engineer says that the root cause is that CPU
> > > is still accessing PCIe devices while poweroff/reboot, and if we
> > > disable the Bus Master Bit at this time, the PCIe controller
> > > doesn't forward requests to downstream devices, and also doesn't
> > > send TIMEOUT to CPU, which causes CPU wait forever (hardware
> > > deadlock). This behavior is a PCIe protocol violation (Bus
> > > Master should not be involved in CPU MMIO transactions), and it
> > > will be fixed in new revisions of hardware (add timeout
> > > mechanism for CPU read request, whether or not Bus Master bit is
> > > cleared).
> >
> > LS7A might have bugs in that clearing Bus Master Enable prevents the
> > root port from forwarding Memory or I/O requests in the downstream
> > direction.
> >
> > But this feels like a bit of a band-aid because we don't know exactly
> > what those requests are.  If we're removing the Root Port, I assume we
> > think we no longer need any devices *below* the Root Port.
> >
> > If that's not the case, e.g., if we still need to produce console
> > output or save state to a device, we probably should not be removing
> > the Root Port at all.
>
> Do you mean it is better to skip the whole pcie_port_device_remove()
> instead of just removing the "clear bus master" operation for the
> buggy hardware?

No, that's not what I want at all.  That's just another band-aid to
avoid a problem without understanding what the problem is.

My point is that apparently we remove a Root Port (which means we've
already removed any devices under it), and then we try to use a device
below the Root Port.  That seems broken.  I want to understand why we
try to use a device after we've removed it.

If the scenario ends up being legitimate and unavoidable, fine -- we
can figure out a quirk to work around the fact the LS7A doesn't allow
that access after we clear Bus Master Enable.  But right now the
scenario smells like a latent bug, and leaving bus mastering enabled 
just avoids it without fixing it.

Bjorn
