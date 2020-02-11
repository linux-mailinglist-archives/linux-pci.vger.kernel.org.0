Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1500159233
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2020 15:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgBKOsn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 09:48:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41231 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgBKOsn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2020 09:48:43 -0500
Received: by mail-io1-f67.google.com with SMTP id m25so11997570ioo.8
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2020 06:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+pLeKHNc80Td51F5FW28IMFZU66wu+UJlU6jTA+b20=;
        b=y7YXlnma2BOJT3nhEPn9Qsz9bwFH4bvsgNaF09IFU6kIx/USIOMBqguQnWUcHKv3Vr
         iIMR4qekXeCU1c6vj5OUBoEwuBOU7fA/lPUXfD4NhkhKu26TcJegQZp3BQYIKSsHbCyD
         UFfbq9JnIieNNsfJTVOq2vQHuDY74ZU3t0PHrseD+5PH5yIk0BHS5lrGMNBiuWrnOpby
         v9/imyprT0WSefrIF1Ezi9+Mern+xeMocTygoKQhw2cWL46fgqetyoLoGBLKqgSpeVpk
         tyJ4sOfny8gP1MX71ywMIqCCF1toCDoesXqxm9fmEgeL+Nyn3UsodDpwR2p23aW+tqkL
         GOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+pLeKHNc80Td51F5FW28IMFZU66wu+UJlU6jTA+b20=;
        b=i76RHXb1zmQhztpVjewNUxekqRwMfWlbzpQtgv2r5muV5efjl4wauWsGBUsscQHOMn
         wy9ntx193bHufDkYc2N4kIhx/zh6YmsCeXtLb0bVS+6Xs3U0atRrS2PmjrQwVGxAlUfJ
         P+dYRiQ6dSzagKPIKbZahj3/N24s7NbvS3Fo8QFY1y5jb2vfoYP4wnEmf+AsdGPxbKFy
         junv3eLAxM5sVEps1wH5V0LvYjgZnIsdgQh3kM+0OqfiY+Qd/IVGeggDmuCzmRMf2zp/
         oDi1NEu/HGvaT8fwRQ1vkZtGCkVA6Y6l5JxrO7ACkjREJpXPnjmnYkFXAKqBdmW1Fb9m
         QrUQ==
X-Gm-Message-State: APjAAAU6kaF0yFN3v6toLQeK8PEWNiLN/CnPTpFiCvVmLPiXUkqYZbB5
        RC+MW2tUmTt7hQogbxGg7q1f4uxyuiAkRGgL4E3+2g==
X-Google-Smtp-Source: APXvYqzQkHpxNUNbT8iGzEE6+mY56WpbAPOnMfEmck2hBCbgU6rudH4lqadMsXsNnIp/kJnlKbr6zxgOaHMU22bpgQo=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr15038510jac.126.1581432522140;
 Tue, 11 Feb 2020 06:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com> <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com> <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk> <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
 <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
 <da4dcdc7-c022-db67-cda2-f90f086b729e@nxp.com> <aec47903-50e4-c61b-6aec-63e3e9bc9332@arm.com>
In-Reply-To: <aec47903-50e4-c61b-6aec-63e3e9bc9332@arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 11 Feb 2020 06:48:30 -0800
Message-ID: <CAOesGMhVA9NSbAi-BtcgQBBK90jeT+NcQ6j_FDgjuR7efE65Vg@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 5:04 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-02-11 12:13 pm, Laurentiu Tudor wrote:
> [...]
> >> This is a known issue about DPAA2 MC bus not working well with SMMU
> >> based IO mapping.  Adding Laurentiu to the chain who has been looking
> >> into this issue.
> >
> > Yes, I'm closely following the issue. I actually have a workaround
> > (attached) but haven't submitted as it will probably raise a lot of
> > eyebrows. In the mean time I'm following some discussions [1][2][3] on
> > the iommu list which seem to try to tackle what appears to be a similar
> > issue but with framebuffers. My hope is that we will be able to leverage
> > whatever turns out.
>
> Indeed it's more general than framebuffers - in fact there was a
> specific requirement from the IORT side to accommodate network/storage
> controllers with in-memory firmware/configuration data/whatever set up
> by the bootloader that want to be handed off 'live' to Linux because the
> overhead of stopping and restarting them is impractical. Thus this DPAA2
> setup is very much within scope of the desired solution, so please feel
> free to join in (particularly on the DT parts) :)

That's a real problem that nees a solution, but that's not what's
happening here, since cold boots works fine.

Isn't it a whole lot more likely that something isn't
reset/reinitialized properly in u-boot, such that there is lingering
state in the setup, causing this?

> As for right now, note that your patch would only be a partial
> mitigation to slightly reduce the fault window but not remove it
> entirely. To be robust the SMMU driver *has* to know about live streams
> before the first arm_smmu_reset() - hence the need for generic firmware
> bindings - so doing anything from the MC driver is already too late (and
> indeed the current iommu_request_dm_for_dev() mechanism is itself a
> microcosm of the same problem).

This is more likely a live stream that's left behind from the previous
kernel (there are some error messages about being unable to detach
domains, but the errors make it hard to tell what driver didn't unbind
enough).

*BUT*, even with that bug, the system should reboot reliably and come
up clean. So, something isn't clearing up the state *on boot*.

> > In the mean time, can you try the workaround Leo suggested?
>
> Agreed, I'd imagine the command-line option is probably the best choice
> for these platforms, since it's likely to be easier to set that by
> default in the bootloader than faff with rebuilding generic kernel configs.

For the generic user, definitely. I'll give it a go later this week
when I have a bit more spare time with the device physically present.


-Olof
