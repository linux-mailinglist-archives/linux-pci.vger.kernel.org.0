Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6FE316198
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 09:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhBJI5M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 10 Feb 2021 03:57:12 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40595 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhBJIyz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 03:54:55 -0500
X-Originating-IP: 90.2.82.147
Received: from windsurf.home (aputeaux-654-1-223-147.w90-2.abo.wanadoo.fr [90.2.82.147])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4056F20002;
        Wed, 10 Feb 2021 08:54:09 +0000 (UTC)
Date:   Wed, 10 Feb 2021 09:54:08 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Stefan Roese <sr@denx.de>, Phil Sutter <phil@nwl.cc>,
        Mario Six <mario.six@gdsys.cc>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Stefan Chulski <stefanc@marvell.com>
Subject: Re: pci mvebu issue (memory controller)
Message-ID: <20210210095408.75839806@windsurf.home>
In-Reply-To: <20210209141759.6960fccb@kernel.org>
References: <20210209141759.6960fccb@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Marek,

On Tue, 9 Feb 2021 14:17:59 +0100
Marek Behún <kabel@kernel.org> wrote:

> (sending this e-mail again because previously I sent it to Thomas' old
> e-mail address at free-electrons)

Thanks. Turns out I still receive e-mail sent to @free-electrons.com,
so I had seen your previous e-mail but didn't had the chance to reply.

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

To be honest, I don't have much details about what this device does,
and my memory is unclear on whether I really ever had any details. I
vaguely remember that this is a device that made sense when the Marvell
PCIe controller is used as an endpoint, and in such a situation this
device also the root complex to "see" the physical memory of the
Marvell SoC. And therefore in a situation where the Marvell PCIe
controller is the root complex, seeing this device didn't make sense.

In addition, I /think/ it was causing problems with the MBus windows
allocation. Indeed, if this device is visible, then we will try to
allocate MBus windows for its different BARs, and those windows are in
limited number.

I know this isn't a very helpful answer, but the documentation on this
is pretty much nonexistent, and I don't remember ever having very
solid and convincing answers.

I've added in Cc Stefan Chulski, from Marvell, who has recently posted
patches on the PPv2 driver. I don't know if he will have details about
PCIe, but perhaps he will be able to ask internally at Marvell.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
