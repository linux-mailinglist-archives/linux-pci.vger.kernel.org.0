Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D40E390983
	for <lists+linux-pci@lfdr.de>; Tue, 25 May 2021 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhEYTRa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 May 2021 15:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230029AbhEYTR2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 May 2021 15:17:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E605F610A1;
        Tue, 25 May 2021 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621970158;
        bh=Ic/XP5SaZJAGzEAKMh9ZFFeMeUnuVLBZvSWO7z7/HQs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hJ1NmT7JQFhl1mf6po8zwX3S8ONxUyN33ksA+WIB1wbQtc7JUq/4edPHhJjl8QDso
         Qn73DVaV7pQIW/eTgWte9ZdnqT1poUVzGDamaxarF7z+LTZKuqs6vkiDds9b1HVQFq
         jBsnCiiT67t6eJNWEc49tqWY/d6hNhFo+F0KeWbnbDT21nTOLNpcFLUlW3bkL6a1Vw
         bsYfAHhVhzDJrWvUmUrUZJvWSkuoXgVOhKKlTw6oRGhvKcYu8u3hZmHcjNAQDcA4jr
         KBBZzTDv1YaoGHIkIES3em7lIU2qNXbK+B/7wMQTohBppGMd/RKvGmw4uAe7G7/7wO
         OiYZdxyN4tF6Q==
Date:   Tue, 25 May 2021 14:15:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Punit Agrawal <punitagrawal@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Leonardo Bras <leobras.c@gmail.com>,
        Rob Herring <robh@kernel.org>, PCI <linux-pci@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
Message-ID: <20210525191556.GA1220872@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEBePfKDOc6eo9yjZPnVeFimX-zxR+R3As+2pP9XnZkuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 25, 2021 at 05:54:56PM +0200, Ard Biesheuvel wrote:
> On Tue, 25 May 2021 at 17:34, Peter Geis <pgwipeout@gmail.com> wrote:

> > > > >> > On 2021-05-18 10:09, Alexandru Elisei wrote:
> > > > >> >> [..]
> > > > >> >> [    0.305183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
> > > > >> >> [    0.305248] rockchip-pcie f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff -> 0x00fa000000
> > > > >> >> [    0.305285] rockchip-pcie f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
> > > > >> >> [    0.373705] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
> > > > >> >> [    0.373730] pci_bus 0000:00: root bus resource [bus 00-1f]
> > > > >> >> [    0.373751] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
> > > > >> >> [    0.373777] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])

> ... For some reason, lspci translates the BAR values to CPU
> addresses, but the PCI side addresses are within 32-bits.

lspci shows BARs as CPU physical addresses by default.  These are the
same addresses you would see in pdev->resource[n] and the same as BAR
values you would see in dmesg.

A 64-bit CPU physical address can certainly be translated by the host
bridge to a 32-bit PCI address.  But that's not happening here because
this host bridge applies no translation (CPU physical 0xfa000000 maps
to bus address 0xfa000000).

"lspci -b" shows the PCI bus addresses.
