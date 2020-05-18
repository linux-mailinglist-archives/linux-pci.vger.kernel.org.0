Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8BE1D7A68
	for <lists+linux-pci@lfdr.de>; Mon, 18 May 2020 15:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgERNup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 May 2020 09:50:45 -0400
Received: from lists.nic.cz ([217.31.204.67]:49056 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgERNup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 May 2020 09:50:45 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 3A5A913FB34;
        Mon, 18 May 2020 15:50:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1589809842; bh=mKx8Rnn8Z17iw+8AFlxVTaPbT4P6vQPBfVaylXnXQEI=;
        h=Date:From:To;
        b=fIXqnEYFg6lCSyAhSNCZwFLbz1jywVQpQlh6h9L1S2ju9VaJol4woUgK4UmYZ7Mv7
         cOga8n5NBLXHC7Wdb1LB0FVjxF2o3S5DivQXGj3iHOE8IGjs/VnIqPKaWfED5LCVTU
         9LooSz6AHYRItjZGXC/Ry51vkD58ZaId2JnKvTtc=
Date:   Mon, 18 May 2020 15:50:41 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 00/12] PCI: aardvark: Fix support for Turris MOX and
 Compex wifi cards
Message-ID: <20200518155041.655050b1@nic.cz>
In-Reply-To: <20200518134614.GA31554@e121166-lin.cambridge.arm.com>
References: <20200430080625.26070-1-pali@kernel.org>
        <20200513135643.478ffbda@windsurf.home>
        <87pnb2h7w1.fsf@FE-laptop>
        <20200518103004.6tydnad3apkfn77y@pali>
        <20200518134614.GA31554@e121166-lin.cambridge.arm.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-100.0 required=5.9 tests=SHORTCIRCUIT,
        USER_IN_WHITELIST shortcircuit=ham autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 18 May 2020 14:46:14 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Mon, May 18, 2020 at 12:30:04PM +0200, Pali Roh=C3=A1r wrote:
> > On Sunday 17 May 2020 17:57:02 Gregory CLEMENT wrote: =20
> > > Hello,
> > >  =20
> > > > Hello,
> > > >
> > > > On Thu, 30 Apr 2020 10:06:13 +0200
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > =20
> > > >> Marek Beh=C3=BAn (5):
> > > >>   PCI: aardvark: Improve link training
> > > >>   PCI: aardvark: Add PHY support
> > > >>   dt-bindings: PCI: aardvark: Describe new properties
> > > >>   arm64: dts: marvell: armada-37xx: Set pcie_reset_pin to gpio fun=
ction
> > > >>   arm64: dts: marvell: armada-37xx: Move PCIe comphy handle proper=
ty
> > > >>=20
> > > >> Pali Roh=C3=A1r (7):
> > > >>   PCI: aardvark: Train link immediately after enabling training
> > > >>   PCI: aardvark: Don't blindly enable ASPM L0s and don't write to
> > > >>     read-only register
> > > >>   PCI: of: Zero max-link-speed value is invalid
> > > >>   PCI: aardvark: Issue PERST via GPIO
> > > >>   PCI: aardvark: Add FIXME comment for PCIE_CORE_CMD_STATUS_REG ac=
cess
> > > >>   PCI: aardvark: Replace custom macros by standard linux/pci_regs.h
> > > >>     macros
> > > >>   arm64: dts: marvell: armada-37xx: Move PCIe max-link-speed prope=
rty =20
> > > >
> > > > Thanks a lot for this work. For a number of reasons, I'm less invol=
ved
> > > > in Marvell platform support in Linux, but I reviewed your series and
> > > > followed the discussions around it, and I'm happy to give my:
> > > >
> > > > Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com> =20
> > >=20
> > > With this acked-by for the series, the reviewed-by from Rob on the
> > > binding and the tested-by, I am pretty confident so I applied the
> > > patches 10, 11 and 12 on mvebu/dt64.
> > >=20
> > > Thanks,
> > >=20
> > > Gregory =20
> >=20
> > Thank you!
> >=20
> > Lorenzo, would you now take remaining patches? =20
>=20
> Yes - even though I have reservations about patch (5) and the
> problem is related to a complete lack of programming model for
> these host controllers and a clear separation between what's
> done in the OS vs bootloader, PERST handling in this host
> bridge is *really* a mess.
>=20
> I applied 1-9 to pci/aardvark.
>=20
> Lorenzo

Hooray, thanks, Lorenzo (and everyone else).
