Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4091F157EB0
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 16:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBJPXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 10:23:15 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34756 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgBJPXP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 10:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TqhAwvp9Xtx6LAPRC4IX+EMRgvLwL2jEspybEz0eFTI=; b=PoAKQbef9Q2ksbDk5+9S6DxWG
        f2XOs68EWJC+TjjDsjkKAJS4BZEbZDUOnpCOAhLURTS76uTFrLKCHlYOluyib9xFBPj9VZXjqN+PN
        OKnTN6FI7CzYC2csewp2xzJPRcwBaO+ThaKZ1RZISKj2GyenSsmW3t9cHN/namxUaAw8RzkGXeUwQ
        uQYUFbICs8CfKaOGbYMJX9wYhJhhBynyuovQf8d0pAhUu1TEVZJQ/s9+DiYKk+ktXRlvgbuUaOXp3
        9lHrntt1/93QZU76PtT7RajTmE1A1IkBUjlM5Dx88EYsaLDNDFoCW6EswZ3z9pZjoKwSn8SxFMzdj
        IBD6Jmr4g==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46026)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j1Atr-0007Ud-9u; Mon, 10 Feb 2020 15:23:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j1Atl-0007zI-QL; Mon, 10 Feb 2020 15:22:57 +0000
Date:   Mon, 10 Feb 2020 15:22:57 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Olof Johansson <olof@lixom.net>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Message-ID: <20200210152257.GD25745@shell.armlinux.org.uk>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 04:12:30PM +0100, Olof Johansson wrote:
> On Thu, Feb 6, 2020 at 11:57 AM Z.q. Hou <zhiqiang.hou@nxp.com> wrote:
> >
> > Hi Olof,
> >
> > Thanks a lot for your comments!
> > And sorry for my delay respond!
> 
> Actually, they apply with only minor conflicts on top of current -next.
> 
> Bjorn, any chance we can get you to pick these up pretty soon? They
> enable full use of a promising ARM developer system, the SolidRun
> HoneyComb, and would be quite valuable for me and others to be able to
> use with mainline or -next without any additional patches applied --
> which this patchset achieves.
> 
> I know there are pending revisions based on feedback. I'll leave it up
> to you and others to determine if that can be done with incremental
> patches on top, or if it should be fixed before the initial patchset
> is applied. But all in all, it's holding up adaption by me and surely
> others of a very interesting platform -- I'm looking to replace my
> aging MacchiatoBin with one of these and would need PCIe/NVMe to work
> before I do.

If you're going to be using NVMe, make sure you use a power-fail safe
version; I've already had one instance where ext4 failed to mount
because of a corrupted journal using an XPG SX8200 after the Honeycomb
Serror'd, and then I powered it down after a few hours before later
booting it back up.

EXT4-fs (nvme0n1p2): INFO: recovery required on readonly filesystem
EXT4-fs (nvme0n1p2): write access will be enabled during recovery
JBD2: journal transaction 80849 on nvme0n1p2-8 is corrupt.
EXT4-fs (nvme0n1p2): error loading journal

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
