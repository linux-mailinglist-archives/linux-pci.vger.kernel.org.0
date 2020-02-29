Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684E8174657
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 12:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgB2LF3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 06:05:29 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41630 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgB2LF3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Feb 2020 06:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wuUpV5SHCRJYUop9hRbOcq6qSohuXXb7u+JkS37PiYg=; b=q9p5W+6pavIOD//8IHWCpzjOr
        Y1ZEJ6TqSVwIynLiC+KJHBAHMaeqDY/LgdnHCNHWMrgtdgESsKNSQ3EpwHAXRVP7rcde5/+qjZ9W8
        Wx2O1L2n9Db9cVyUP2wNsKltIux+pwQt87Ik7WK8+Aij8lC2Lui5Ps2lt6gA3NWMVunL3G0T2VdcH
        xYagoaVexzJ73H91KgiMTXRVFTVcmY6xNd7j5vp02lxnhOz/85PNJ8/7AYa0Nye+1ZVMK9YIfUyqW
        PtmfW8M4N/5xaCKCttbAWsYLQdwwyTW3Sg/tUcGPpq1qidsjw4IrrU6QizNZssXLYmE08eHQDHEdo
        +PKLeQkdA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58468)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j7zvh-00015K-76; Sat, 29 Feb 2020 11:05:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j7zvU-0002uI-JD; Sat, 29 Feb 2020 11:04:56 +0000
Date:   Sat, 29 Feb 2020 11:04:56 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Olof Johansson <olof@lixom.net>, Jon Nettleton <jon@solid-run.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
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
Message-ID: <20200229110456.GY25745@shell.armlinux.org.uk>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <20200229095550.GX25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229095550.GX25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 29, 2020 at 09:55:50AM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 10, 2020 at 03:22:57PM +0000, Russell King - ARM Linux admin wrote:
> > On Mon, Feb 10, 2020 at 04:12:30PM +0100, Olof Johansson wrote:
> > > On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > > >
> > > > Hi Olof,
> > > >
> > > > Thanks a lot for your comments!
> > > > And sorry for my delay respond!
> > > 
> > > Actually, they apply with only minor conflicts on top of current -next.
> > > 
> > > Bjorn, any chance we can get you to pick these up pretty soon? They
> > > enable full use of a promising ARM developer system, the SolidRun
> > > HoneyComb, and would be quite valuable for me and others to be able to
> > > use with mainline or -next without any additional patches applied --
> > > which this patchset achieves.
> > > 
> > > I know there are pending revisions based on feedback. I'll leave it up
> > > to you and others to determine if that can be done with incremental
> > > patches on top, or if it should be fixed before the initial patchset
> > > is applied. But all in all, it's holding up adaption by me and surely
> > > others of a very interesting platform -- I'm looking to replace my
> > > aging MacchiatoBin with one of these and would need PCIe/NVMe to work
> > > before I do.
> > 
> > If you're going to be using NVMe, make sure you use a power-fail safe
> > version; I've already had one instance where ext4 failed to mount
> > because of a corrupted journal using an XPG SX8200 after the Honeycomb
> > Serror'd, and then I powered it down after a few hours before later
> > booting it back up.
> > 
> > EXT4-fs (nvme0n1p2): INFO: recovery required on readonly filesystem
> > EXT4-fs (nvme0n1p2): write access will be enabled during recovery
> > JBD2: journal transaction 80849 on nvme0n1p2-8 is corrupt.
> > EXT4-fs (nvme0n1p2): error loading journal
> 
> ... and last night, I just got more ext4fs errors on the NVMe, without
> any unclean power cycles:
> 
> [73729.556544] EXT4-fs error (device nvme0n1p2): ext4_lookup:1700: inode #917524: comm rm: iget: checksum invalid
> [73729.565354] Aborting journal on device nvme0n1p2-8.
> [73729.568995] EXT4-fs (nvme0n1p2): Remounting filesystem read-only
> [73729.569077] EXT4-fs error (device nvme0n1p2): ext4_journal_check_start:61: Detected aborted journal
> [73729.573741] EXT4-fs error (device nvme0n1p2): ext4_lookup:1700: inode #917524: comm rm: iget: checksum invalid
> [73729.593330] EXT4-fs error (device nvme0n1p2): ext4_lookup:1700: inode #917524: comm mv: iget: checksum invalid
> 
> The affected file is /var/backups/dpkg.status.6.gz
> 
> It was cleanly shut down and powered off on the 22nd February, booted
> yesterday morning followed by another reboot a few minutes later.
> 
> What worries me is the fact that corruption has happened - and if that
> happens to a file rather than an inode, it will likely go unnoticed
> for a considerably longer time.
> 
> I think I'm getting to the point of deciding NVMe or the LX2160A to be
> just too unreliable for serious use.  I hadn't noticed any issues when
> using the rootfs on the eMMC, so it suggests either the NVMe is
> unreliable, or there's a problem with PCIe on this platform (which we
> kind of know about with Jon's GPU rendering issues.)

Adding Ted and Andreas...

Here's the debugfs -n "id" output for dpkg.status.5.gz (which is fine,
and probably a similar size):

debugfs:  id <917527>
0000  a481 0000 30ff 0300 bd8e 475e bd77 4f5e  ....0.....G^.wO^
0020  29ca 345e 0000 0000 0000 0100 0002 0000  ).4^............
0040  0000 0800 0100 0000 0af3 0100 0400 0000  ................
0060  0000 0000 0000 0000 4000 0000 8087 3800  ........@.....8.
0100  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
0140  0000 0000 c40b 4c0a 0000 0000 0000 0000  ......L.........
0160  0000 0000 0000 0000 0000 0000 3884 0000  ............8...
0200  2000 95f2 44b8 bdc9 a4d2 9883 c861 dc92   ...D........a..
0220  bd31 4a5e ecc5 260c 0000 0000 0000 0000  .1J^..&.........
0240  0000 0000 0000 0000 0000 0000 0000 0000  ................
*

and for the affected inode:
debugfs:  id <917524>
0000  a481 0000 30ff 0300 3d3d 465e bd77 4f5e  ....0...==F^.wO^
0020  29ca 345e 0000 0000 0000 0100 0002 0000  ).4^............
0040  0000 0800 0100 0000 0af3 0100 0400 0000  ................
0060  0000 0000 0000 0000 4000 0000 c088 3800  ........@.....8.
0100  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
0140  0000 0000 5fc4 cfb4 0000 0000 0000 0000  ...._...........
0160  0000 0000 0000 0000 0000 0000 af23 0000  .............#..
0200  2000 1cc3 ac95 c9c8 a4d2 9883 583e addf   ...........X>..
0220  3de0 485e b04d 7151 0000 0000 0000 0000  =.H^.MqQ........
0240  0000 0000 0000 0000 0000 0000 0000 0000  ................
*

and "stat" output:
debugfs:  stat <917527>
Inode: 917527   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 172755908    Version: 0x00000000:00000001
User:     0   Group:     0   Project:     0   Size: 261936
File ACL: 0
Links: 1   Blockcount: 512
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x5e4f77bd:c9bdb844 -- Fri Feb 21 06:25:01 2020
 atime: 0x5e478ebd:92dc61c8 -- Sat Feb 15 06:25:01 2020
 mtime: 0x5e34ca29:8398d2a4 -- Sat Feb  1 00:45:29 2020
crtime: 0x5e4a31bd:0c26c5ec -- Mon Feb 17 06:25:01 2020
Size of extra inode fields: 32
Inode checksum: 0xf2958438
EXTENTS:
(0-63):3704704-3704767
debugfs:  stat <917524>
Inode: 917524   Type: regular    Mode:  0644   Flags: 0x80000
Generation: 3033515103    Version: 0x00000000:00000001
User:     0   Group:     0   Project:     0   Size: 261936
File ACL: 0
Links: 1   Blockcount: 512
Fragment:  Address: 0    Number: 0    Size: 0
 ctime: 0x5e4f77bd:c8c995ac -- Fri Feb 21 06:25:01 2020
 atime: 0x5e463d3d:dfad3e58 -- Fri Feb 14 06:25:01 2020
 mtime: 0x5e34ca29:8398d2a4 -- Sat Feb  1 00:45:29 2020
crtime: 0x5e48e03d:51714db0 -- Sun Feb 16 06:25:01 2020
Size of extra inode fields: 32
Inode checksum: 0xc31c23af
EXTENTS:
(0-63):3705024-3705087

When using sif (set_inode_info) to re-set the UID to 0 on this (so
provoke the checksum to be updated):

debugfs:  id <917524>
0000  a481 0000 30ff 0300 3d3d 465e bd77 4f5e  ....0...==F^.wO^
0020  29ca 345e 0000 0000 0000 0100 0002 0000  ).4^............
0040  0000 0800 0100 0000 0af3 0100 0400 0000  ................
0060  0000 0000 0000 0000 4000 0000 c088 3800  ........@.....8.
0100  0000 0000 0000 0000 0000 0000 0000 0000  ................
*
0140  0000 0000 5fc4 cfb4 0000 0000 0000 0000  ...._...........
0160  0000 0000 0000 0000 0000 0000 b61f 0000  ................
                                    ^^^^
0200  2000 aa15 ac95 c9c8 a4d2 9883 583e addf   ...........X>..
           ^^^^
0220  3de0 485e b04d 7151 0000 0000 0000 0000  =.H^.MqQ........
0240  0000 0000 0000 0000 0000 0000 0000 0000  ................
*

The values with "^^^^" are the checksum, which are the only values
that have changed here - the checksum is now 0x15aa1fb6 rather than
0xc31c23af.

With that changed, running e2fsck -n on the filesystem results in a
pass:

root@cex7:~# e2fsck -n /dev/nvme0n1p2
e2fsck 1.44.5 (15-Dec-2018)
Warning: skipping journal recovery because doing a read-only filesystem check.
/dev/nvme0n1p2 contains a file system with errors, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/nvme0n1p2: 121163/2097152 files (0.1% non-contiguous), 1349227/8388608 blocks

and the file now appears to be intact (being a gzip file, gzip verifies
that the contents are now as it expects.)

So, it looks like the _only_ issue is that the checksum on the inode
became invalid, which seems to suggest that it *isn't* a NVMe nor PCIe
issue.

I wonder whether the journal would contain anything useful, but I don't
know how to use debugfs to find that out - while I can dump the journal,
I'd need to know which block contains the inode, and then work out where
in the journal that block was going to be written.  If that would help,
let me know ASAP as I'll hold off rebooting the platform for a while
(which means the filesystem will remain as-is - and yes, I have the
debugfs file for e2undo to put stuff back.)  Maybe it's possible to pull
the block number out of the e2undo file?

tune2fs says:

Checksum type:            crc32c
Checksum:                 0x682f91b9

I guess this is what is used to checksum the inodes?  If so, it's using
the kernel's crc32c-generic driver (according to /proc/crypto).

Could it be a race condition, or some problem that's specific to the
ARM64 kernel that's provoking this corruption?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
