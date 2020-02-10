Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E821582D7
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 19:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBJSmD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 13:42:03 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:42521 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgBJSmC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Feb 2020 13:42:02 -0500
Received: by mail-ot1-f49.google.com with SMTP id 66so7374491otd.9;
        Mon, 10 Feb 2020 10:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W1ciCgvuqEnDoMA1edbjKiXo9M8YGhJpnNcRvscMaLU=;
        b=PcmSuOkMmbExl3F+r4HQqNhWT8Y14mRQ0X4V9tX5IHB2F8+Ok+8X8UdWFETWVcKNVi
         abE1ZLhubasaF2iPbJxhNLCweZTwGWYvw9sQ67CcE9nFRDSHb6cKgx8BU00CKXKj8+qE
         l1SAzIxNXlrOuuxWfxYyxt+4wJLhmENTVobCwxuV3meP4wqmUaaPLGqhdhbyYejcvRZe
         FdVvuv1ofVCNp0o52cGWrvzK1lNmMsLdpluYOwS2kDvA0kXZp0CNed2we/brry+LR4vT
         3KZNkkzB2SRymtqnvJ2g53KrzNC3xOxISxPwNfUboISHYnHD3jwjFwp48LNRQOFQdvC9
         p2yA==
X-Gm-Message-State: APjAAAXJ2jFR8+6mHDsjjbFHL1kW8XhbRB1JgOQ9FuJlO5R/qOBtJ5kT
        daclSMrOZbEJLTth08d73IDsr9wlIbs=
X-Google-Smtp-Source: APXvYqwKNisCdkOSR/XlF15KXhaatwymHt8MAUo0YxW+V4/RdjmQzLcaua4DoS7M6RRTSRyjggVhag==
X-Received: by 2002:a9d:7:: with SMTP id 7mr2031823ota.26.1581360121296;
        Mon, 10 Feb 2020 10:42:01 -0800 (PST)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id q5sm312248oia.21.2020.02.10.10.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 10:42:00 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id j132so10161980oih.9;
        Mon, 10 Feb 2020 10:42:00 -0800 (PST)
X-Received: by 2002:aca:3f8b:: with SMTP id m133mr269681oia.51.1581360120170;
 Mon, 10 Feb 2020 10:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com> <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com> <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk> <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
In-Reply-To: <CAOesGMj6B-X1s8-mYqS0N6GJXdKka1MxaNV=33D1H++h7bmXrA@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 10 Feb 2020 12:41:49 -0600
X-Gmail-Original-Message-ID: <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
Message-ID: <CADRPPNSXPCVQEWXfYOpmGBCXMg2MvSPqDEMeeH_8VhkPHDuR5w@mail.gmail.com>
Subject: Re: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
To:     Olof Johansson <olof@lixom.net>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
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

On Mon, Feb 10, 2020 at 9:32 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Mon, Feb 10, 2020 at 4:23 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
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
> Hmm, using btrfs on mine, not sure if the exposure is similar or not.
>
> Do you know if the SErr was due to a known issue and/or if it's
> something that's fixed in production silicon?
>
> (I still can't enable SMMU since across a warm reboot it fails
> *completely*, with nothing coming up and working. NXP folks, you
> listening? :)

This is a known issue about DPAA2 MC bus not working well with SMMU
based IO mapping.  Adding Laurentiu to the chain who has been looking
into this issue.

Regards,
Leo
