Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE8157EC7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 16:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBJPcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 10:32:02 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42582 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgBJPcC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 10:32:02 -0500
Received: by mail-io1-f66.google.com with SMTP id s6so7987032iol.9
        for <linux-pci@vger.kernel.org>; Mon, 10 Feb 2020 07:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LdEJdz9cYAFMM3xmZL3mL+mWUhXjJFl3/Kjb/Eqp6cg=;
        b=FwMfJhw5hP+TWC8TkHbaY+QVMva1bPQD2RXzWOHNbRk/ltjnQKooGotR642QQZegux
         LtTnD/EoDqNrPAKTb950uwPQmPoczofSTDZ0KT2BHbt+BBP2ifgewg2noyUY1jmHwUaC
         Iu4Q5JKxxCP0ApaoL6Ct700dJsRBcl1BqhY7z4Zaz6kwazwbw09gOFTGnTl+ku+6r4v8
         yFUun5fErsfjU/hPb8X/YxW4/1XfIb23RWVpOg78+XUTjtzgo6RsliUP1yxThxO0vNqc
         8+wXrQYCKyJvMQhtNf7bBo6bXxztQf0N2bXzUXNzegpJK6uA6Qxo3OpgylcMeYF9Ze5v
         NToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LdEJdz9cYAFMM3xmZL3mL+mWUhXjJFl3/Kjb/Eqp6cg=;
        b=MK0egIbBbCKSCqUnzh0H9zM6Rd3b/5BCC/QKEqI75M7iKsWkwAuYhKpJXS996lBiF7
         LkO9jgq5fFtzSQtFVyQw2hC4IhZvhf+yMqDB1sJVFam/VGj/RLdibtl39wO1SPhnEtdG
         0p1obsoOpKI/GEPlri6QnuRJ23onwdwzwihPRG3+dIErjsjneau6kwXXtQiqkmlspw7H
         N8g7qaS7D6hzeHljT8VOtNX54KWvupQ7B8BIKy7d4kZ8CYLLD18h4JSMxB//pvriM84E
         mKyA6tjjuvdmZBt5LSg+KvDCkdJ6MQ2syPyV7CItv68cswaYQVh3cr4a03EJHfEOq2Ct
         mDRg==
X-Gm-Message-State: APjAAAWkRbBb7GJ3xsHGKgz7pmjxqKuhZn+utJiQiD8hO4y1EEa1zIFP
        sF1yqG4METKvzy0EAdzo7O0dlSm0RNOV2iZSQbGAJw==
X-Google-Smtp-Source: APXvYqwwKXw7rUltstfUNaCgnSa2+ZLVL9g0K7DC8phkevVIrmBu3DWox6Vttq+2GHlKgAixGBmoZTHtI3T5XFIWwH0=
X-Received: by 2002:a02:ca10:: with SMTP id i16mr10887277jak.10.1581348721801;
 Mon, 10 Feb 2020 07:32:01 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com> <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com> <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com> <20200210152257.GD25745@shell.armlinux.org.uk>
In-Reply-To: <20200210152257.GD25745@shell.armlinux.org.uk>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 10 Feb 2020 16:28:23 +0100
Message-ID: <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 10, 2020 at 4:23 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
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

Hmm, using btrfs on mine, not sure if the exposure is similar or not.

Do you know if the SErr was due to a known issue and/or if it's
something that's fixed in production silicon?

(I still can't enable SMMU since across a warm reboot it fails
*completely*, with nothing coming up and working. NXP folks, you
listening? :)


-Olof
