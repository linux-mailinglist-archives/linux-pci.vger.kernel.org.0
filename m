Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17038EE464
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfKDQHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 11:07:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfKDQHr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 11:07:47 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B9820B7C;
        Mon,  4 Nov 2019 16:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572883665;
        bh=XckIs6gWAVHNO4ExQCJnSZy6JpVcL185bNfTIIEoQG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=foePwsymnPBma2kUDvHPzLN6oLRIyouw2h1SUo2g3C2x9f978xLg+ielzAHNi1CmN
         A416QwUIQJ24YS8QIO2ZG6EHBON+nNIveOH4d7ueklXx2YS2Lw2tL0XELyclnh6IuE
         dQwSicPfQbh9Cq6F0htq3bH2otTLdCaSZbaUAgRY=
Date:   Mon, 4 Nov 2019 10:07:43 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Carlo Pisani <carlojpisani@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
Message-ID: <20191104160743.GA113643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+QBN9B4qfxpEa69TB=+MngG9bN0puwByAeGCMxk_Y7fgaKhpQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc linux-pci]

On Mon, Nov 04, 2019 at 03:18:46PM +0100, Carlo Pisani wrote:
> hi
> with this setup changes, it seems stable after 3 days of burn-in testing
> 
> VIA_RHINE st to PCI_IO
> Wifi Atheros9: unset
> 
> --- .config  2019-10-28 20:02:02.000000000 +0100
> +++ .config  2019-03-22 10:08:26.000000000 +0100
> @@ -1105,7 +1105,7 @@
>  # CONFIG_NET_VENDOR_TOSHIBA is not set
>  CONFIG_NET_VENDOR_VIA=y
>  CONFIG_VIA_RHINE=y
> -CONFIG_VIA_RHINE_MMIO=y
> +# CONFIG_VIA_RHINE_MMIO is not set
> 
> it seems there is a bug in the PCI and the bug manifests when
> "VIA_RHINE_MMIO" is enabled

In v5.4-rc1 (it's possible v4.4 is different), CONFIG_VIA_RHINE_MMIO
is only used here:

  static int rhine_init_one_pci(struct pci_dev *pdev, ...)
  {
    ...
    /* This driver was written to use PCI memory space. Some early versions
     * of the Rhine may only work correctly with I/O space accesses.
     * TODO: determine for which revisions this is true and assign the flag
     *       in code as opposed to this Kconfig option (???)
     */
  #ifdef CONFIG_VIA_RHINE_MMIO
          u32 quirks = rqNeedEnMMIO;
  #else
          u32 quirks = 0;
  #endif
  ...
          ioaddr = pci_iomap(pdev, (quirks & rqNeedEnMMIO ? 1 : 0), io_size);

So the only effect is that if CONFIG_VIA_RHINE_MMIO=y, the driver uses
BAR 1 (PCI MMIO space) instead of BAR 0 (PCI I/O port space).

That comment is pretty interesting -- perhaps the rb532 has those
early Rhine devices that don't work correctly with PCI MMIO space?

My guess is that either you have those early broken Rhine devices, or
there's some similar problem in the via-rhine driver.

If the device works at all, the problem is probably in the driver
rather than in the PCI core.  After the driver probes the device, the
PCI core is pretty much out of the picture.

> Il giorno mar 29 ott 2019 alle ore 00:31 Bjorn Helgaas
> <bjorn.helgaas@gmail.com> ha scritto:
> >
> > Unset CONFIG_VIA_RHINE and CONFIG_ATH9K.
> >
> > On Mon, Oct 28, 2019 at 6:05 PM Carlo Pisani <carlojpisani@gmail.com> wrote:
> > >
> > > what have I to remove in the config file?
> > >
> > > Il giorno lun 28 ott 2019 alle ore 22:09 Bjorn Helgaas
> > > <bjorn.helgaas@gmail.com> ha scritto:
> > > >
> > > > That config option doesn't affect whether the device uses DMA.
> > > >
> > > > On Mon, Oct 28, 2019 at 4:02 PM Carlo Pisani <carlojpisani@gmail.com> wrote:
> > > > >
> > > > > I have just removed this
> > > > >
> > > > > CONFIG_VIA_RHINE_MMIO:
> > > > > This instructs the driver to use PCI shared memory (MMIO) instead of
> > > > > programmed I/O ports (PIO). Enabling this gives an improvement in
> > > > > processing time in parts of the driver.
> > > > >
> > > > > and I am going to recompile the kernel
> > > > >
> > > > >
> > > > > Il giorno lun 28 ott 2019 alle ore 20:57 Bjorn Helgaas
> > > > > <bjorn.helgaas@gmail.com> ha scritto:
> > > > > >
> > > > > > On Mon, Oct 28, 2019 at 2:52 PM Carlo Pisani <carlojpisani@gmail.com> wrote:
> > > > > > >
> > > > > > > > The UARTs do not have DMA enabled (BusMaster-) in the lspci output, so
> > > > > > > > they shouldn't be able to corrupt memory.  The NICs *do* have DMA
> > > > > > > > enabled.  Does the problem still happen if you turn off the NIC
> > > > > > > > drivers (via-rhine and ath9k, it looks like)?
> > > > > > >
> > > > > > > how did you understand that uart do not have DMA enabled?
> > > > > > > what did you look at in the lspci output?
> > > > > >
> > > > > > The "Bus Master" bit determines whether the device can issue memory
> > > > > > read/write requests, i.e., DMA.  In your lspci output, it showed
> > > > > > "BusMaster-" for the UARTs, which means the bit is cleared.  The NICs
> > > > > > have "BusMaster+", which means they *can* issue DMA requests.
