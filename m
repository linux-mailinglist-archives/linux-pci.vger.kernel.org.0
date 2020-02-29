Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08D61747A2
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgB2PTp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 10:19:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60393 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727085AbgB2PTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Feb 2020 10:19:45 -0500
Received: from callcc.thunk.org ([156.39.10.47])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TFJ95N008890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 10:19:11 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B8D2742045B; Sat, 29 Feb 2020 10:19:07 -0500 (EST)
Date:   Sat, 29 Feb 2020 10:19:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Olof Johansson <olof@lixom.net>, Jon Nettleton <jon@solid-run.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
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
Message-ID: <20200229151907.GA7378@mit.edu>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
 <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <20200229095550.GX25745@shell.armlinux.org.uk>
 <20200229110456.GY25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229110456.GY25745@shell.armlinux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 29, 2020 at 11:04:56AM +0000, Russell King - ARM Linux admin wrote:
> 
> Could it be a race condition, or some problem that's specific to the
> ARM64 kernel that's provoking this corruption?

Since I got brought in mid-way through this discussion, can someone
summarize the vital details of the bughunt?  What kernel version is
involved, and is this a regression?  If so, what's the last version of
the kernel where you didn't have a problem on this hardware?

Can you trigger this failure reliably?

Unfortunately, while I'm regularly running xfstests on x86_64 on a
Google Compute Engine VM, I'm not doing any runs on arm64.  I can
certainly build an arm-64.

There's a test-appliance designed to be run on ARM64 here[1].

[1] https://kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/xfstests-amd64.tar.xz

which is a Debian chroot, designed to be run via android-xfstests[2], but
if you unpack it, it should be possible to enter the chroot and
trigger the xfstests run manually on any arm64 system.

[2] https://thunk.org/android-xfstests

Does anyone know if kernel CI is running xfstests regularly?

Cheers,

							- Ted
