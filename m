Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D26E3B49D8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 22:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFYUsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 16:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYUsS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Jun 2021 16:48:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 820B26194F;
        Fri, 25 Jun 2021 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624653957;
        bh=cSimEgZ1scJjFnjSVCXaZf8KtUmZePwk+GXh+Btx16I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Hq98JcfkoHJ4Vwj+e7PyiMECb3pcEARUHqwv4qukIm9+Ry2D+yvvwS+JUOFMh4V7b
         hdracl2JM+2d0QlWKYaGk6h4ASRTMsrEmgKQ3nifSW830A7LoODTbZOEZPSxitLsZi
         lm1WODz/9knVloxW2SuYZ9jkfqqmOXQyBt8PThkXGrZEFXKJ2B/a2tyEc60Q9CuJIB
         8fapMBzFaX2O2ZYGq+opZlUg9FElO48r2maHQkkTGnZOG1XLMHacOrKK/lFM/OrzQ9
         p53sZJYCu5u+Rz2iRv6FWa2BUp0x/kBWqbwJHtHHH6E4Il9UCB4NjBFx+wMsosPLEF
         HdwfteQSeTuVg==
Date:   Fri, 25 Jun 2021 15:45:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Sinan Kaya <okaya@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH V3 1/4] PCI/portdrv: Don't disable device during shutdown
Message-ID: <20210625204556.GA3656680@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625093030.3698570-2-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 25, 2021 at 05:30:27PM +0800, Huacai Chen wrote:
> Use separate remove()/shutdown() callback, and don't disable PCI device
> during shutdown. This can avoid some poweroff/reboot failures.
> 
> The poweroff/reboot failures could easily be reproduced on Loongson
> platforms. I think this is not a Loongson-specific problem, instead, is
> a problem related to some specific PCI hosts. On some x86 platforms,
> radeon/amdgpu devices can cause the same problem [1][2], and commit
> faefba95c9e8ca3a ("drm/amdgpu: just suspend the hw on pci shutdown")
> can resolve it.
> 
> As Tiezhu said, this occasionally shutdown or reboot failure is due to
> clear PCI_COMMAND_MASTER on the device in do_pci_disable_device() [3].
> 
> static void do_pci_disable_device(struct pci_dev *dev)
> {
>         u16 pci_command;
> 
>         pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>         if (pci_command & PCI_COMMAND_MASTER) {
>                 pci_command &= ~PCI_COMMAND_MASTER;
>                 pci_write_config_word(dev, PCI_COMMAND, pci_command);
>         }
> 
>         pcibios_disable_device(dev);
> }
> 
> When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
> shutdown or reboot. The root cause on Loongson platform is that CPU is
> still writing data to framebuffer while poweroff/reboot, and if we clear
> Bus Master Bit at this time, CPU will wait ack from device, but never
> return, so a hardware deadlock happens.

Doesn't make sense yet.  Bus Master enables the *device* to do DMA.  A
CPU can do MMIO to a device, e.g., to write data to a framebuffer,
regardless of the state of Bus Master Enable.  Also, those MMIO writes
done by a CPU are Memory Write transactions on PCIe, which are
"Posted" Requests, which means they do not receive acks.  So this
cannot be the root cause.

Bjorn
