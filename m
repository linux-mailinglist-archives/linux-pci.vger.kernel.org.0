Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4842016A
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhJCMLe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 08:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhJCMLe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 08:11:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB6C5611C0;
        Sun,  3 Oct 2021 12:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633262987;
        bh=i8N31sQ41LOUcHyNYXJzbpCEw7/SNf6vGBlhvaSAozM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fO/NtbKS/3hU2a+5U8swcoPi6vQXHtWuxMGjmDxIZu8GfLn76WXOgwBWJYikA1tiG
         w7ExxWI0un5TOp4gVKKAFuloSyqpLAl5V/uXJnJ0JAwwF8Owz4q3SH+ej0qEGThJ1o
         dT6xH8Zei9OPq+VDu3bcpnS2STYLO8IE/7DT8uUsIv1PgtE77rcsW0xMIWn2hGuPnQ
         ctFPeApa6k0/g44i3lUjMTnPLvSVJCamyHKAQq0OWRAF/iDscCDDTJYbmS8rXEQYNc
         EynQacKGeLXy43BIANY4JbDZl4FCBgSVDv1xLnRpadDsDs1WKnvdvKhdU6XEpQaPJR
         yTswolpWflgVA==
Received: by pali.im (Postfix)
        id 2D7A9EF5; Sun,  3 Oct 2021 14:09:44 +0200 (CEST)
Date:   Sun, 3 Oct 2021 14:09:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Stefan Chulski <stefanc@marvell.com>, linux-pci@vger.kernel.org
Subject: Re: pci mvebu issue (memory controller)
Message-ID: <20211003120944.3lmwxylnhlp2kfj7@pali>
References: <20210209141759.6960fccb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210209141759.6960fccb@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello! See explanation below.

On Tuesday 09 February 2021 14:17:59 Marek Behún wrote:
> Hello Thomas,
> 
> (sending this e-mail again because previously I sent it to Thomas' old
> e-mail address at free-electrons)
> 
> we have enountered an issue with pci-mvebu driver and would like your
> opinion, since you are the author of commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4ac99011e542d06ea2bda10063502583c6d7991
> 
> After upgrading to new version of U-Boot on a Armada XP / 38x device,
> some WiFi cards stopped working in kernel. Ath10k driver, for example,
> could not load firmware into the card.
> 
> We discovered that the issue is caused by U-Boot:
> - when U-Boot's pci_mvebu driver was converted to driver model API,
>   U-Boot started to configure PCIe registers not only for the newtork
>   adapter, but also for the Marvell Memory Controller (that you are
>   mentioning in your commit).
> - Since pci-mvebu driver in Linux is ignoring the Marvell Memory
>   Controller device, and U-Boot configures its registers (BARs and what
>   not), after kernel boots, the registers of this device are
>   incompatible with kernel, or something, and this causes problems for
>   the real PCIe device.
> - Stefan Roese has temporarily solved this issue with U-Boot commit
>   https://gitlab.denx.de/u-boot/custodians/u-boot-marvell/-/commit/6a2fa284aee2981be2c7661b3757ce112de8d528
>   which basically just masks the Memory Controller's existence.
> 
> - in Linux commit f4ac99011e54 ("pci: mvebu: no longer fake the slot
>   location of downstream devices") you mention that:
> 
>    * On slot 0, a "Marvell Memory controller", identical on all PCIe
>      interfaces, and which isn't useful when the Marvell SoC is the PCIe
>      root complex (i.e, the normal case when we run Linux on the Marvell
>      SoC).
> 
> What we are wondering is:
> - what does the Marvell Memory controller really do? Can it be used to
>   configure something? It clearly does something, because if it is
>   configured in U-Boot somehow but not in kernel, problems can occur.
> - is the best solution really just to ignore this device?
> - should U-Boot also start doing what commit f4ac99011e54 does? I.e.
>   to make sure that the real device is in slot 0, and Marvell Memory
>   Controller in slot 1.
> - why is Linux ignoring this device? It isn't even listed in lspci
>   output.
> 
> Thanks,
> 
> Marek

tl;dr

- Mysterious Marvell Memory Controller is PCIe Root Port (it can be
  verified by e.g. doing config space dump from U-Boot and then parse
  it via lspci)
- Config space of this PCIe device is mapped directly to the address
  space of PCIe controller (to offset zero)
- It has config space with Header Type 0 and Class Code 0x5080
- BARs configure PCIe controller itself, BAR0 must point to beginning of
  the SoC registers, other BARs to DDR memory address space
- Both U-Boot and Kernel pci mvebu drivers set Secondary Bus num to zero
- Patch which was fixing this issue disappeared from kernel

I think this explains all mentioned issues in previous email. Controller
driver configures registers for SoC and DDR and then PCI core/pnp
reconfigured them via config space to different values = no PCIe device
is working as PCIe controller it not able to access SoC registers and
DDR memory correctly anymore.

Bjorn, it is normal that PCIe Root Port device has Type 0 config space
and Class Code 0x5080 (Memory controller)? Because I thought that PCIe
Root Port device must have Class Code 0x6004 (PCI Bridge) with Type 1
config space.

And what should happen according to PCIe standards when both primary and
secondary bus numbers are configured to zeros? Or to other same numbers?

On primary bus is that Memory Controller == Root Port and on secondary
bus is endpoint card. Marvell has additional register for specifying
device number at which Root Port appears. And it looks like that if
primary and secondary bus numbers are same, then on this bus at Root
Port device address appears Root Port and on all other device addresses
appears endpoint card (which looks crazy if endpoint card is at all
possible BDF addresses where B=primary=secondary and D!=root_port).
But I have no idea what happens for other buses.

Seems that due to these issues pci-mvebu.c kernel driver filters access
to this PCIe Root Port device and uses pci-bridge-emul.c for providing
emulated PCIe Root Port device. It sets Root Port device address to 1
and allow access only to device address 0 (at which is endpoint card).

This issues appears in all Marvell SoCs. Here are just few lspci output
sent by different people in past. And All have one common thing: device
with "Root Port" and "Memory controller: Marvell" marking:

https://lore.kernel.org/linux-arm-kernel/alpine.DEB.2.02.1210261857100.20029@mirri/
https://lore.kernel.org/linux-arm-kernel/ad9478410910120746g2ce82af1t71a84ea02e9eecb7@mail.gmail.com/
https://lore.kernel.org/ath9k-devel/4FF0EBCE.3020308@allnet.de/

And that is not all. It looks like that this issue with Root Port /
Memory Controller was known also for kernel developers. In past, about
10 years ago, into kernel was merged following commit which explained it
and fixed class code from Memory Controller to PCI Bridge:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1dc831bf53fddcc6443f74a39e72db5bcea4f15d

Apparently this patch completely disappeared as I'm not able find any
code with this comment or fixup in mainline kernel anymore.
Bjorn, Lorenzo, do you have any idea what happened?
