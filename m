Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB023FF45
	for <lists+linux-pci@lfdr.de>; Sun,  9 Aug 2020 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgHIQcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Aug 2020 12:32:43 -0400
Received: from magic.merlins.org ([209.81.13.136]:34540 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgHIQcj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Aug 2020 12:32:39 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1k4oEj-0006Wu-M3 by authid <merlin>; Sun, 09 Aug 2020 09:31:53 -0700
Date:   Sun, 9 Aug 2020 09:31:53 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Introduce pcie_wait_for_link_delay()
Message-ID: <20200809163152.GA8863@merlins.org>
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <20191004123947.11087-2-mika.westerberg@linux.intel.com>
 <20200808202202.GA12007@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808202202.GA12007@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 08, 2020 at 01:22:02PM -0700, Marc MERLIN wrote:
> Basically, I'm getting the same thing than this person with a P53 (which
> is a mostly identical lenovo thinkpad, to mine)
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> https://bbs.archlinux.org/viewtopic.php?id=250658
 
I had to reboot today and tried my 5.7.11 kernel 6 times.
It never booted and each time got stuck on 
pcieport 0000:00:01.0: PME: Spurious native interrupt!

This is the nvidia driver and claimed by nouveau (I don't use nvidia graphics
but I'm forced to use nouveau to turn the nvidia chip down so that it
doesn't drain my batteries).

I ended up being able to boot the 7th time after removing the yubikey in my USB-C 
port, which is also thunderbolt.
PME messages shown below. Let me know if you'd like further data.

Thanks,
Marc

[    4.142484] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability LTR DPC]
[    4.151715] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    4.151727] pci 0000:00:01.0: PME# disabled
[    4.165979] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    4.166000] pci 0000:00:14.0: PME# disabled
[    4.177746] pci 0000:00:16.0: PME# supported from D3hot
[    4.177767] pci 0000:00:16.0: PME# disabled
[    4.180850] pci 0000:00:17.0: PME# supported from D3hot
[    4.180862] pci 0000:00:17.0: PME# disabled
[    4.183830] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    4.183847] pci 0000:00:1b.0: PME# disabled
[    4.189643] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    4.189660] pci 0000:00:1c.0: PME# disabled
[    4.193085] pci 0000:00:1c.5: PME# supported from D0 D3hot D3cold
[    4.193101] pci 0000:00:1c.5: PME# disabled
[    4.196462] pci 0000:00:1c.7: PME# supported from D0 D3hot D3cold
[    4.196478] pci 0000:00:1c.7: PME# disabled
[    4.206057] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    4.206079] pci 0000:00:1f.3: PME# disabled
[    4.214993] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    4.215015] pci 0000:00:1f.6: PME# disabled
[    4.217978] pci 0000:01:00.0: PME# supported from D0 D3hot
[    4.217991] pci 0000:01:00.0: PME# disabled
[    4.219129] pci 0000:01:00.2: PME# supported from D0 D3hot
[    4.219142] pci 0000:01:00.2: PME# disabled
[    4.219578] pci 0000:01:00.3: PME# supported from D0 D3hot
[    4.219591] pci 0000:01:00.3: PME# disabled
[    4.221398] pci 0000:04:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.221433] pci 0000:04:00.0: PME# disabled
[    4.222282] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.222297] pci 0000:05:00.0: PME# disabled
[    4.222792] pci 0000:05:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.222806] pci 0000:05:01.0: PME# disabled
[    4.223289] pci 0000:05:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.223304] pci 0000:05:02.0: PME# disabled
[    4.223839] pci 0000:05:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.223854] pci 0000:05:04.0: PME# disabled
[    4.224645] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.224661] pci 0000:06:00.0: PME# disabled
[    4.225644] pci 0000:2c:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.225661] pci 0000:2c:00.0: PME# disabled
[    4.227557] pci 0000:52:00.0: PME# supported from D0 D3hot D3cold
[    4.227708] pci 0000:52:00.0: PME# disabled
[    4.229139] pci 0000:54:00.0: PME# supported from D1 D2 D3hot D3cold
[    4.229155] pci 0000:54:00.0: PME# disabled
[    7.238126] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    7.239208] pcieport 0000:00:1b.0: PME: Signaling with IRQ 123
[    7.239861] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    7.241522] pcieport 0000:00:1c.5: PME: Signaling with IRQ 125
[    7.242499] pcieport 0000:00:1c.7: PME: Signaling with IRQ 126
[    7.401422] pcieport 0000:05:01.0: PME# enabled
[    7.401868] pcieport 0000:05:04.0: PME# enabled
[    8.985668] xhci_hcd 0000:01:00.2: PME# enabled
[    8.988738] xhci_hcd 0000:2c:00.0: PME# enabled
[    9.008649] pcieport 0000:05:02.0: PME# enabled
[   12.378450] nvidia-gpu 0000:01:00.3: PME# enabled
[   25.610848] thunderbolt 0000:06:00.0: PME# enabled
[   25.628766] pcieport 0000:05:00.0: PME# enabled
[   25.648762] pcieport 0000:04:00.0: PME# enabled
[   25.668889] pcieport 0000:00:1c.0: PME# enabled
[  179.608847] nvidia-gpu 0000:01:00.3: PME# disabled
[  179.608873] pcieport 0000:00:01.0: PME: Spurious native interrupt!
[  183.359454] nvidia-gpu 0000:01:00.3: PME# enabled
[  183.396832] nvidia-gpu 0000:01:00.3: PME# disabled
[  183.396859] pcieport 0000:00:01.0: PME: Spurious native interrupt!
[  187.147398] nvidia-gpu 0000:01:00.3: PME# enabled
[  187.184826] nvidia-gpu 0000:01:00.3: PME# disabled
[  187.184852] pcieport 0000:00:01.0: PME: Spurious native interrupt!
[  190.932329] nvidia-gpu 0000:01:00.3: PME# enabled
[  190.972359] nvidia-gpu 0000:01:00.3: PME# disabled
[  190.972366] pcieport 0000:00:01.0: PME: Spurious native interrupt!
[  192.351330] snd_hda_intel 0000:00:1f.3: PME# enabled
[  192.468365] snd_hda_intel 0000:00:1f.3: PME# disabled
[  192.736342] xhci_hcd 0000:01:00.2: PME# disabled
[  194.296431] pcieport 0000:00:1c.0: PME# disabled
[  194.432427] pcieport 0000:04:00.0: PME# disabled
[  194.432591] pcieport 0000:05:01.0: PME# disabled
[  194.432771] pcieport 0000:05:00.0: PME# disabled
[  194.432943] pcieport 0000:05:02.0: PME# disabled
[  194.433102] pcieport 0000:05:04.0: PME# disabled
[  194.556299] pcieport 0000:05:01.0: PME# enabled
[  194.556417] pcieport 0000:05:04.0: PME# enabled
[  195.560440] thunderbolt 0000:06:00.0: PME# disabled


-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
