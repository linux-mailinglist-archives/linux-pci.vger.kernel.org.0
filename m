Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3CE158144
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 18:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgBJRVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 12:21:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36382 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727558AbgBJRVN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 12:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t4A9u108s+DCwr0hGx+ywc3WqZp5mzjjdaDdM2W1OTs=; b=ETOiw+xWo+C4mRGn2DxV0FyMe
        TGLW+Asu6JZwJdVglJs8GzXtNJPSegQar+XUcaEGwpLs933FgQxTA+y/pX2vydhQa3PB9yhakX+dY
        C+1aBwFFhQu0NiZaHJWhX/Vk/xtwj+6J84FnaI7VZKKUpBpRamX1l4olBpmrfl4C7BAyW/SH8GZHj
        YZHyEzqHVP5hGlc68UG7aokC+Pza0voQ8r1Juuk19HUrPPg9l1mMcxiUlkRVUOhowpC8fyPXR7W8Q
        Tro48k3DARyt1YGlY++WKHOGkz3o1/ZAmOxMTkjgTQJyoeUF1CqQgv5Y7vs0ztsdbgx/fYyNNTrzR
        AApfoxzjA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:38544)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j1Ck3-00083Y-PP; Mon, 10 Feb 2020 17:21:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j1Cjz-000845-Kx; Mon, 10 Feb 2020 17:20:59 +0000
Date:   Mon, 10 Feb 2020 17:20:59 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Olof Johansson <olof@lixom.net>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Message-ID: <20200210172059.GH25745@shell.armlinux.org.uk>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <20200210161553.GE25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210161553.GE25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 04:15:53PM +0000, Russell King - ARM Linux admin wrote:
> On Mon, Feb 10, 2020 at 04:28:23PM +0100, Olof Johansson wrote:
> > On Mon, Feb 10, 2020 at 4:23 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Mon, Feb 10, 2020 at 04:12:30PM +0100, Olof Johansson wrote:
> > > > On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> > > > >
> > > > > Hi Olof,
> > > > >
> > > > > Thanks a lot for your comments!
> > > > > And sorry for my delay respond!
> > > >
> > > > Actually, they apply with only minor conflicts on top of current -next.
> > > >
> > > > Bjorn, any chance we can get you to pick these up pretty soon? They
> > > > enable full use of a promising ARM developer system, the SolidRun
> > > > HoneyComb, and would be quite valuable for me and others to be able to
> > > > use with mainline or -next without any additional patches applied --
> > > > which this patchset achieves.
> > > >
> > > > I know there are pending revisions based on feedback. I'll leave it up
> > > > to you and others to determine if that can be done with incremental
> > > > patches on top, or if it should be fixed before the initial patchset
> > > > is applied. But all in all, it's holding up adaption by me and surely
> > > > others of a very interesting platform -- I'm looking to replace my
> > > > aging MacchiatoBin with one of these and would need PCIe/NVMe to work
> > > > before I do.
> > >
> > > If you're going to be using NVMe, make sure you use a power-fail safe
> > > version; I've already had one instance where ext4 failed to mount
> > > because of a corrupted journal using an XPG SX8200 after the Honeycomb
> > > Serror'd, and then I powered it down after a few hours before later
> > > booting it back up.
> > >
> > > EXT4-fs (nvme0n1p2): INFO: recovery required on readonly filesystem
> > > EXT4-fs (nvme0n1p2): write access will be enabled during recovery
> > > JBD2: journal transaction 80849 on nvme0n1p2-8 is corrupt.
> > > EXT4-fs (nvme0n1p2): error loading journal
> > 
> > Hmm, using btrfs on mine, not sure if the exposure is similar or not.
> 
> As I understand the problem, it isn't a filesystem issue.  It's a data
> integrity issue with the NVMe over power fail, how they cache the data,
> and ultimately write it to the nand flash.
> 
> Have a read of:
> 
> https://www.kingston.com/en/solutions/servers-data-centers/ssd-power-loss-protection

This was the link I was actually looking for:

http://industrial.adata.com/en/technology/92

but there's also:

http://industrial.adata.com/en/technology/26

ADATA make the XPG SX8200:

NVME Identify Controller:
vid       : 0x1cc1
ssvid     : 0x1cc1
mn        : ADATA SX8200PNP
fr        : R0906I

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
