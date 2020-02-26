Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 290AB170C8E
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 00:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgBZX1Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 18:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgBZX1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 18:27:16 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 798F920658;
        Wed, 26 Feb 2020 23:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582759634;
        bh=sRKFXIOdMt3uKwrueRgdk4RpTv6iY5xBSrnyJV5ot80=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wHc72kbgn4rQ84i+w9kYe4ishVjAv196COq/bzb6sBIlV/oVJD95iJfDKF9UMY8uq
         JklwyX/EVfC8vbzXYnhAbEKlizG22rOzXaWCuYyAocjWndGja5tUn8bpETfZY4UxDD
         /KSnICnecF0p6mgn7deljGzUVr+eWbVW7vaRGo2I=
Date:   Wed, 26 Feb 2020 17:27:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: Help needed in understanding weird PCIe issue on imx6q (PCIe
 just goes bad)
Message-ID: <20200226232713.GA191903@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226232550.GA191068@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Richard, Lucas]

On Wed, Feb 26, 2020 at 05:25:52PM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 22, 2020 at 04:25:41PM +0100, Fawad Lateef wrote:
> > Hello,
> > 
> > I am trying to figure-out an issue on our i.MX6Q platform based design
> > where PCIe interface goes bad.
> > 
> > We have a Phytec i.MX6Q eMMC SOM, attached to our custom designed
> > board. PCIe root-complex from i.MX6Q is attached to PLX switch
> > (PEX8605).
> > 
> > Linux kernel version is 4.19.9x and also 4.14.134 (from phytec's
> > linux-mainline repo). Kernel do not have PCIe hot-plug and PNP enabled
> > in config.
> > 
> > PLX switch #PERST is attached to a GPIO pin and stays in disable state
> > until Linux is booted. So at boot time only PCIe root-complex is
> > initialized by kernel.
> > 
> > After boot if I do "lspci -v"  and see everything good from PCIe
> > root-complex (below):
> > 
> > ~ # lspci -v
> > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > [Normal decode])
> > Flags: bus master, fast devsel, latency 0, IRQ 295
> > Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> > Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > I/O behind bridge: None
> > Memory behind bridge: None
> > Prefetchable memory behind bridge: None
> > [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> > Capabilities: [40] Power Management version 3
> > Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> > Capabilities: [70] Express Root Port (Slot-), MSI 00
> > Capabilities: [100] Advanced Error Reporting
> > Capabilities: [140] Virtual Channel
> > Kernel driver in use: pcieport
> > 
> > 
> > Then I enable the #PERST pin of PLX switch, everything is still good
> > (no rescan on Linux is done yet)
> > 
> > ~ # echo 139 > /sys/class/gpio/export
> > ~ # echo out > /sys/class/gpio/gpio139/direction
> > ~ # echo 1 > /sys/class/gpio/gpio139/value
> > ~ # lspci -v
> > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > [Normal decode])
> > Flags: bus master, fast devsel, latency 0, IRQ 295
> > Memory at 01000000 (32-bit, non-prefetchable) [size=1M]
> > Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
> > I/O behind bridge: None
> > Memory behind bridge: None
> > Prefetchable memory behind bridge: None
> > [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> > Capabilities: [40] Power Management version 3
> > Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
> > Capabilities: [70] Express Root Port (Slot-), MSI 00
> > Capabilities: [100] Advanced Error Reporting
> > Capabilities: [140] Virtual Channel
> > Kernel driver in use: pcieport
> > 
> > 
> > Now just disable/put-in-reset the PLX switch (Linux don't see the
> > switch yet, as no rescan on PCIe was done). Now "lspci -v" and
> > root-complex goes bad.
> > 
> > ~ # echo 0 > /sys/class/gpio/gpio139/value
> > ~ # lspci -v
> > 00:00.0 PCI bridge: Synopsys, Inc. Device abcd (rev 01) (prog-if 00
> > [Normal decode])
> > Flags: fast devsel, IRQ 295
> > Memory at 01000000 (64-bit, prefetchable) [disabled] [size=1M]
> > Bus: primary=00, secondary=00, subordinate=00, sec-latency=0
> > I/O behind bridge: 00000000-00000fff [size=4K]
> > Memory behind bridge: 00000000-000fffff [size=1M]
> > Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
> > [virtual] Expansion ROM at 01100000 [disabled] [size=64K]
> > Capabilities: [40] Power Management version 3
> > Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
> > Capabilities: [70] Express Root Port (Slot-), MSI 00
> > Capabilities: [100] Advanced Error Reporting
> > Capabilities: [140] Virtual Channel
> > Kernel driver in use: pcieport
> > 
> > ~ # uname -a
> > Linux buildroot-2019.08-imx6 4.14.134-phy2 #1 SMP Thu Feb 20 12:13:33
> > UTC 2020 armv7l GNU/Linux
> > ~ #
> > 
> > 
> > I am really not sure what is going wrong here. Did I am missing
> > something basic?
> 
> I agree, it looks like something's wrong, but I really don't have any
> ideas.
> 
> I would start by using "lspci -xxxx" to see the actual values we get
> from config space.  It looks like we're reading zeros from at least
> the bus and window registers.
> 
> You could also instrument the i.MX config accessors in case there's
> something strange going on there.  Maybe try to reproduce this on a
> current upstream kernel?
> 
> Bjorn
