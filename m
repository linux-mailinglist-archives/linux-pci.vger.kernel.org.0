Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8152E71F8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 16:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgL2Pwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Dec 2020 10:52:44 -0500
Received: from magic.merlins.org ([209.81.13.136]:41106 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgL2Pwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Dec 2020 10:52:44 -0500
Received: from aaubervilliers-653-1-146-240.w86-218.abo.wanadoo.fr ([86.218.37.240]:44390 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1kuHI0-0000jm-Un by authid <merlins.org> with srv_auth_plain; Tue, 29 Dec 2020 07:52:00 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc_nouveau@merlins.org>)
        id 1kuHHz-0005Ee-LP; Tue, 29 Dec 2020 07:51:59 -0800
Date:   Tue, 29 Dec 2020 07:51:59 -0800
From:   Marc MERLIN <marc_nouveau@merlins.org>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: 5.9.11 still hanging 2mn at each boot and looping on nvidia-gpu
 0000:01:00.3: PME# enabled (Quadro RTX 4000 Mobile)
Message-ID: <20201229155159.GG23389@merlins.org>
References: <20200908002935.GD20064@merlins.org>
 <20200529180315.GA18804@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 86.218.37.240
X-SA-Exim-Mail-From: marc_nouveau@merlins.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 26, 2020 at 03:12:09AM -0800, Ilia Mirkin wrote:
> > after boot, when it gets the right trigger (not sure which ones), it
> > loops on this evern 2 seconds, mostly forever.
> 
> The gpu suspends with runtime pm. And then gets woken up for some
> reason (could be something quite silly, like lspci, or could be
> something explicitly checking connectors, etc). Repeat.

Ah, fair point.  Could it be powertop even?
How would I go towards tracing that?
Sounds like this would be a problem with all chips if userspace is able
to wake them up every second or two with a probe. Now I wonder what
broken userspace I have that could be doing this.
 
> Display offload usually requires acceleration -- the copies are done
> using the DMA engine. Please make sure that you have firmware
> available (and a new enough mesa). The errors suggest that you don't
> have firmware available at the time that nouveau loads. Depending on
> your setup, that might mean the firmware has to be built into the
> kernel, or available in initramfs. (Or just regular filesystem if you
> don't use a complicated boot sequence. But many people go with distro
> defaults, which do have this complexity.)

Hi Ilia, thanks for your answer.

Do you think that could be a reason why the boot would hang for 2 full minutes at every
boot ever since I upgraded to 5.5?

Also, without wanting to sound like a full newbie, where is that
firmware you're talking about? In my kernel source?

Here's what I do have:
sauron:/usr/local/bin# dpkggrep nouveau
libdrm-nouveau2:amd64				install
xserver-xorg-video-nouveau			install

no nouveau-firmware package in debian:
sauron:/usr/local/bin# apt-cache search nouveau
bumblebee - NVIDIA Optimus support for Linux
libdrm-nouveau2 - Userspace interface to nouveau-specific kernel DRM services -- runtime
xfonts-jmk - Jim Knoble's character-cell fonts for X
xserver-xorg-video-nouveau - X.Org X server -- Nouveau display driver

No firmware file on my disk:
sauron:/usr/local/bin# find /lib/modules/5.9.11-amd64-preempt-sysrq-20190817/ /lib/firmware/ |grep nouveau
/lib/modules/5.9.11-amd64-preempt-sysrq-20190817/kernel/drivers/gpu/drm/nouveau
/lib/modules/5.9.11-amd64-preempt-sysrq-20190817/kernel/drivers/gpu/drm/nouveau/nouveau.ko
sauron:/usr/local/bin# 

The kernel module is in my initrd:
sauron:/usr/local/bin# dd if=/boot/initrd.img-5.9.11-amd64-preempt-sysrq-20190817 bs=2966528  skip=1 | gunzip | cpio -tdv | grep nouveau
drwxr-xr-x   1 root     root            0 Nov 30 15:40 usr/lib/modules/5.9.11-amd64-preempt-sysrq-20190817/kernel/drivers/gpu/drm/nouveau
-rw-r--r--   1 root     root      3691385 Nov 30 15:35 usr/lib/modules/5.9.11-amd64-preempt-sysrq-20190817/kernel/drivers/gpu/drm/nouveau/nouveau.ko
17+1 records in
17+1 records out
52566778 bytes (53 MB, 50 MiB) copied, 1.69708 s, 31.0 MB/s

What am I supposed to do/check next?

Note that ultimately I only need nouveau not to hang my boot 2mn and do
PM so that the nvidia chip goes to sleep since I don't use it.

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
