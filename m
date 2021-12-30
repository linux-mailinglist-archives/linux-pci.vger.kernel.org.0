Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914804817E4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Dec 2021 01:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhL3AVV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Dec 2021 19:21:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52470 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhL3AVV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Dec 2021 19:21:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A91D615B1;
        Thu, 30 Dec 2021 00:21:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24313C36AEA;
        Thu, 30 Dec 2021 00:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640823680;
        bh=OM8FADTZVaGNNxsuvbX2jzyT1YNPuBV7MwXBf2jO49w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qX+X0xYm8PbaX17wb/R1gATM3gDotmaQQ2Em7IuBUdRpKt7BcuHfaR6KhaFamhWiS
         fTs9tu4L5uO1Aq/qyhDcxrcWJYzgsDE7cH14YvN4P1LKMHzzJNoWvYAqvQmbY19dMW
         dNCLXMoDEEIucjeUq/5Wrs+Kzw6TH6YxQpBD6YCoj/IJv9rVMCmfubCYlAJwsr1deo
         cKeZIUehmX7EHZ8m4NBgDJ9C4HmHWlflp1Q6M4sZN2Es3ru2OkX0DPC3rcHqHcFhGQ
         mQgRwwa81QAOwMYNjKqONUCy/bbhBFiEW/pYv0ho4C2o99nZLHtPbEkC7O659miwEa
         xj/lqG7ABd4zg==
Date:   Wed, 29 Dec 2021 18:21:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     =?iso-8859-1?B?zfFpZ28=?= Huguet <ihuguet@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        objelf@gmail.com, lorenzo@kernel.org, Soul.Huang@mediatek.com,
        Felix Fietkau <nbd@nbd.name>, linux-pci@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [Bug] Driver mt7921e cause computer reboot.
Message-ID: <20211230002118.GA1717394@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsOX72u3yDcGNF64zbm5mC+Z=_8rxKM0cu7m4i1D8iWvbA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lorenzo, Ryder (the rest of the mt7921 maintainers)]

Thread: https://lore.kernel.org/all/CABXGCsODP8ze_mvzfJKcRYxuS-esVgHXAvDXS5KN3xFUN6bWgA@mail.gmail.com/T/#u

On Mon, Dec 27, 2021 at 04:30:11PM +0500, Mikhail Gavrilov wrote:
> On Mon, 27 Dec 2021 at 15:11, Íñigo Huguet <ihuguet@redhat.com> wrote:
> > I've been experiencing similar problems, but they're solved at v5.15
> > version, at least for me.
> >
> > How are you installing the kernel? Custom build? Have you updated the
> > firmware to latest versions, as well?
> 
> I use Fedora Rawhide with default kernel and firmware packages.
> 
> $ uname -r
> 5.16.0-0.rc6.20211223gitbc491fb12513.44.fc36.x86_64
> $ rpm -q linux-firmware
> linux-firmware-20211027-126.fc36.noarch
> 
> >
> > For me, these differences seem to be the normal effect of the driver
> > not recognizing the device.
> 
> By the kernel logs, it looks like this:
> After reboot:
> $ dmesg | grep mt7921e
> [    8.629358] mt7921e 0000:05:00.0: enabling device (0000 -> 0002)
> [    8.630229] mt7921e 0000:05:00.0: ASIC revision: 79610010
> [    9.687652] mt7921e: probe of 0000:05:00.0 failed with error -110
> 
> # rmmod mt7921e
> # modprobe mt7921e
> 
> [  215.514503] mt7921e 0000:05:00.0: ASIC revision: feed0000
> [  216.604741] mt7921e: probe of 0000:05:00.0 failed with error -110
> 
> After cold boot after shutdown:
> $ dmesg | grep mt7921e
> [    8.545171] mt7921e 0000:05:00.0: enabling device (0000 -> 0002)
> [    8.545757] mt7921e 0000:05:00.0: ASIC revision: 79610010
> [    8.631156] mt7921e 0000:05:00.0: HW/SW Version: 0x8a108a10, Build
> Time: 20211014150838a
> [    8.912687] mt7921e 0000:05:00.0: WM Firmware Version: ____010000,
> Build Time: 20211014150922
> [    8.938756] mt7921e 0000:05:00.0: Firmware init done
> [    9.753257] mt7921e 0000:05:00.0 wlp5s0: renamed from wlan0
> 
> It looks like something is not re-initialized after a reboot.
> Laptop BIOS is latest: Version 316
> https://dlcdnets.asus.com/pub/ASUS/GamingNB/G513QY/G513QYAS316.zip
> 
> Maybe anyone from the pci mailing list can lid some light why pci
> device not re-initialized after a reboot?

Sorry for the inconvenience and thank you very much for the report!

If I understand correctly, when you do a cold boot, the mt7921e device
works properly.

But when you simply reboot, without a power off, the device does not
work, and the dmesg log contains:

  pci 0000:05:00.0: [14c3:7961] type 00 class 0x028000
  pci 0000:05:00.0: reg 0x10: [mem 0xfc30300000-0xfc303fffff 64bit pref]
  pci 0000:05:00.0: reg 0x18: [mem 0xfc30400000-0xfc30403fff 64bit pref]
  pci 0000:05:00.0: reg 0x20: [mem 0xfc30404000-0xfc30404fff 64bit pref]
  ...
  mt7921e 0000:05:00.0: enabling device (0000 -> 0002)
  mt7921e 0000:05:00.0: ASIC revision: 79610010
  mt7921e: probe of 0000:05:00.0 failed with error -110

That means the device responds to PCI config reads and writes, but the
probe failed with -ETIMEDOUT after printing the ASIC revision [1].

devm_request_irq() should not return -ETIMEDOUT, but it looks like
mt7921_dma_init() can (via mt7921_dma_disable()).  Maybe the mt7921e
driver can't tolerate some state the device was left in by reboot?

I don't see anything obviously wrong from a PCI core perspective.  The
PCI core does not reset devices either when going down for a reboot or
when coming up at boot-time.

Bjorn

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/mediatek/mt76/mt7921/pci.c?id=v5.16-rc6#n187


