Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2817488D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Feb 2020 19:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgB2SEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Feb 2020 13:04:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45042 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727209AbgB2SD7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Feb 2020 13:03:59 -0500
Received: from callcc.thunk.org (75-104-88-164.mobility.exede.net [75.104.88.164] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TI3N6m018652
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 13:03:30 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2E9B042045B; Sat, 29 Feb 2020 13:03:23 -0500 (EST)
Date:   Sat, 29 Feb 2020 13:03:23 -0500
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
Message-ID: <20200229180323.GC7378@mit.edu>
References: <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <20200110153347.GA29372@e121166-lin.cambridge.arm.com>
 <CAOesGMj9X1c7eJ4gX2QWXSNszPkRn68E4pkrSCxKMYJG7JHwsg@mail.gmail.com>
 <DB8PR04MB67473114B315FBCC97D0C6F9841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
 <CAOesGMieMXHWBO_p9YJXWWneC47g+TGDt9SVfvnp5tShj5gbPw@mail.gmail.com>
 <20200210152257.GD25745@shell.armlinux.org.uk>
 <20200229095550.GX25745@shell.armlinux.org.uk>
 <20200229110456.GY25745@shell.armlinux.org.uk>
 <20200229151907.GA7378@mit.edu>
 <20200229170328.GD25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229170328.GD25745@shell.armlinux.org.uk>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Feb 29, 2020 at 05:03:28PM +0000, Russell King - ARM Linux admin wrote:
> > There's a test-appliance designed to be run on ARM64 here[1].
> > 
> > [1] https://kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests/xfstests-amd64.tar.xz
> 
> The filename seems to say "amd64" not "arm64" ?

Sorry, I cut and pasted the wrong link: s/amd64/arm64/

If there are arm64-specific locking issues, we can probably flush them
out if we could figure out some way of running some of the stress
tests in xfstests.  I don't know a whole lot about arm-64
architectures; would running xfstests on, say, an Amazon AWS arm-based
VM be representative of your new architecture?  Or are there a lot of
sub-architecture differences in the arm-64 world?

						- Ted
