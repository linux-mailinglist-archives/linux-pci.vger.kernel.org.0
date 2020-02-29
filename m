Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE11745FE
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 10:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB2J4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 04:56:22 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40850 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgB2J4V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Feb 2020 04:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Bgd/Ex9MLUvyZiExmCnJEyU/7vztbejGeqEg5TFqh8=; b=or5rmSfnQoBLi4ZUm9sV7IGaq
        fXtowNUD1ROK28QH75LK8pee+utRnbt/qpjsuUlicfPUkFDx4SPbrL4xqWmHCnLTMKZkVDleaYlnn
        M4KJCeWpYJTNeWFvPL/+4uUHuCLY2TQyDmH4x7VlmjQxnplO4dKR+vwxRATvPKacCBLeMn3EnpEAR
        xXbd1nWxhMmwyI+9Kkt1NCdUcOtRVL5EpITunjxFKAppzDCgg3BiWVguid0uFHrQeIAJTofAWwMtL
        7WSUX5N1GN667FPBPpO3ocv46AkQmuagRTTqbiopoiihMBk/eEVOhNk2T3IWIcyUhNxO2Y5pEKsql
        hU9KKp73A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:46796)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j7yqr-0000nL-NH; Sat, 29 Feb 2020 09:56:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j7yqc-0002s4-P3; Sat, 29 Feb 2020 09:55:50 +0000
Date:   Sat, 29 Feb 2020 09:55:50 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Olof Johansson <olof@lixom.net>, Jon Nettleton <jon@solid-run.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20200229095550.GX25745@shell.armlinux.org.uk>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210152257.GD25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 03:22:57PM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 10, 2020 at 04:12:30PM +0100, Olof Johansson wrote:
> > On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > >
> > > Hi Olof,
> > >
> > > Thanks a lot for your comments!
> > > And sorry for my delay respond!
> > 
> > Actually, they apply with only minor conflicts on top of current -next.
> > 
> > Bjorn, any chance we can get you to pick these up pretty soon? They
> > enable full use of a promising ARM developer system, the SolidRun
> > HoneyComb, and would be quite valuable for me and others to be able to
> > use with mainline or -next without any additional patches applied --
> > which this patchset achieves.
> > 
> > I know there are pending revisions based on feedback. I'll leave it up
> > to you and others to determine if that can be done with incremental
> > patches on top, or if it should be fixed before the initial patchset
> > is applied. But all in all, it's holding up adaption by me and surely
> > others of a very interesting platform -- I'm looking to replace my
> > aging MacchiatoBin with one of these and would need PCIe/NVMe to work
> > before I do.
> 
> If you're going to be using NVMe, make sure you use a power-fail safe
> version; I've already had one instance where ext4 failed to mount
> because of a corrupted journal using an XPG SX8200 after the Honeycomb
> Serror'd, and then I powered it down after a few hours before later
> booting it back up.
> 
> EXT4-fs (nvme0n1p2): INFO: recovery required on readonly filesystem
> EXT4-fs (nvme0n1p2): write access will be enabled during recovery
> JBD2: journal transaction 80849 on nvme0n1p2-8 is corrupt.
> EXT4-fs (nvme0n1p2): error loading journal

... and last night, I just got more ext4fs errors on the NVMe, without
any unclean power cycles:

[73729.556544] EXT4-fs error (device nvme0n1p2): ext4_lookup:1700: inode #917524: comm rm: iget: checksum invalid
[73729.565354] Aborting journal on device nvme0n1p2-8.
[73729.568995] EXT4-fs (nvme0n1p2): Remounting filesystem read-only
[73729.569077] EXT4-fs error (device nvme0n1p2): ext4_journal_check_start:61: Detected aborted journal
[73729.573741] EXT4-fs error (device nvme0n1p2): ext4_lookup:1700: inode #917524: comm rm: iget: checksum invalid
[73729.593330] EXT4-fs error (device nvme0n1p2): ext4_lookup:1700: inode #917524: comm mv: iget: checksum invalid

The affected file is /var/backups/dpkg.status.6.gz

It was cleanly shut down and powered off on the 22nd February, booted
yesterday morning followed by another reboot a few minutes later.

What worries me is the fact that corruption has happened - and if that
happens to a file rather than an inode, it will likely go unnoticed
for a considerably longer time.

I think I'm getting to the point of deciding NVMe or the LX2160A to be
just too unreliable for serious use.  I hadn't noticed any issues when
using the rootfs on the eMMC, so it suggests either the NVMe is
unreliable, or there's a problem with PCIe on this platform (which we
kind of know about with Jon's GPU rendering issues.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
