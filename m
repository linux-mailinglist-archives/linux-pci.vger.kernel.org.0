Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3947615826E
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 19:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgBJSdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 13:33:33 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:34280 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJSdd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 13:33:33 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so8730901iof.1
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2020 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B+jHtAnJKkOCwyeMPvS5vGcxcEKKBJbfgvWPh9lpFCs=;
        b=PdwRXeWHiFH8yrpQPYpR0uye2yAyLKDZSAPha/h4Mbr5H5Oj09gWLIhL2M7t7QAK5s
         OgkWH4mTDX6zzUNkwCryxEGrAR1iwW8YBoVj2bJjKWPhnJLL9DpeT/b8HPXDGoBsv97s
         FVfQYfUH1eWx+xXVRLylK51uI380jwjqt2trAny+zTRTP0QXjC8e0mGrVinkItDsiHv6
         4sz0lz5WCBoQsWHYoAWzIYKcpH4dRoeeM3KJR54Srcl/ci30YYHbj6BwghIvJdgflaBd
         N3jOvp46mkeMNlm70JAWogJwSOWt9p2KwrdVabQd8z7247nhhvXPAB6U9PDqElw4WH6C
         xKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B+jHtAnJKkOCwyeMPvS5vGcxcEKKBJbfgvWPh9lpFCs=;
        b=OagrfGLErcAWgfUp9LlPh05Waw7EmLKV48GxNDtcU7hFd5hBHaJuHah1E2L5lw3PYJ
         +NVXnWbRzS5K1Nhjj/vqm+oUWtk8sTWvFo68HsdlFAydj+fXnY5fgkuc1pbYP+VIbFCh
         C8h3tneFr5Pj9jWVviierA6sZEcei7wMH5MNic4mWlmOzxt5UY/3fEXvHxY+3JEy++DY
         SEAM9rQEXd5/U+t46jidk945ZfbiZiGBdJY9ss5tw4jNXFb8E/Bc3m9liDhiQCDndELW
         bc+yNsHyP+KBILZON9vpJ9zLZjGT7r33Meaqded/Te0pRoo/3raM50W+/ThE0Ch3nCv3
         wisg==
X-Gm-Message-State: APjAAAXMiJ03CNfNqHcoro3uk9pO6oi0S6rVyynOcGnvkCvh+VsoaZAe
        c7Rlp8lMgH5ITY2jsGAtuZaLu2CZaus9VB/TVx3oWg==
X-Google-Smtp-Source: APXvYqyoFf5sGjg09a7wIuIWH9xR+u53nYPNlmA8qKwgvkkGi0OrCh08SZa//aX1Vvd7AaJvFvK08wvjN6inWFOQMwI=
X-Received: by 2002:a02:9581:: with SMTP id b1mr10894223jai.11.1581359612398;
 Mon, 10 Feb 2020 10:33:32 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com> <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com> <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk> <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <20200210161553.GE25745@shell.armlinux.org.uk>
In-Reply-To: <20200210161553.GE25745@shell.armlinux.org.uk>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 10 Feb 2020 19:33:19 +0100
Message-ID: <CAOesGMjJS0SfNwQoBqL8Y1G4Uj0YDBf+EWP4MHCnVWnZF2DyyA@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
        <linux-arm-kernel@lists.infradead.org>,
        honeycomb-users@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc:ing honeycomb-users, didn't think of that earlier]

On Mon, Feb 10, 2020 at 5:16 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
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
>
> As NVMe and SSD are basically the same underlying technology (the host
> interface is different) and the issues I've heard, and now experienced
> with my NVMe, I think the above is a good pointer to the problems of
> flash mass storage.
>
> As I understand it, the problem occurs when the mapping table has not
> been written back to flash, power is lost without the Standby Immediate
> command being sent, and there is no way for the firmware to quickly
> save the table.  On subsequent power up, the firmware has to
> reconstruct the mapping table, and depending on how that is done,
> incorrect (old?) data may be returned for some blocks.
>
> That can happen to any blocks on the drive, which means any data can
> be at risk from a power loss event, whether that is a power failure
> or after a crash.

Makes me suspect if there's some board-level power/reset sequencing
issue, or if there's a problem with one card going down disabling
others. I haven't read the specs enough to know what's expected
behavior but I've seen similar issues on other platforms so take it
with a grain of salt.

> > Do you know if the SErr was due to a known issue and/or if it's
> > something that's fixed in production silicon?
>
> The SError is triggered by something on the PCIe side of things; if I
> leave the Mellanox PCIe card out, then I don't get them.  The errata
> patches I have merged into my tree help a bit, turning the code from
> being unable to boot without a SError with the card plugged in, to
> being able to boot and last a while - but the SErrors still eventually
> come, maybe taking a few days... and that's without the Mellanox
> ethernet interface being up.
>
> > (I still can't enable SMMU since across a warm reboot it fails
> > *completely*, with nothing coming up and working. NXP folks, you
> > listening? :)
>
> Is it just a warm reboot?  I thought I saw SMMU activity on a cold
> boot as well, implying that there were devices active that Linux
> did not know about.

Yeah, 100% reproducible on warm reboot -- every single time. Not on
cold boot though (100% success rate as far as I remember). I boot with
kernel on NVMe on PCIe, native 1GbE for networking. u-boot from SD
card.

This is with the SolidRun u-boot from GitHub.


-Olof
