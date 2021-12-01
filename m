Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC4464AEC
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbhLAJy2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 04:54:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45588 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbhLAJyO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 04:54:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B253FB81E0B
        for <linux-pci@vger.kernel.org>; Wed,  1 Dec 2021 09:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164C5C53FD4;
        Wed,  1 Dec 2021 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638352250;
        bh=ax3GoV0NHtKcbnURuzRgjVefaUgRY+HpnCKxXrAFqMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J25seWw+tGaOtByFu5nuQpmVYT78rAgjeLD0/+pBil5b1PmJaOhp6YcKcBTWnoUaZ
         uQU6Qr8D6objSrAMtlriNKP3PUdpG9Pnc6avqkLoJ4bh/WKjC16kWG5y+8c3Dv/cLe
         7nlqBCCg00ecusr3x9YEWy/0UE+EI9P9gJYQq4O0TTaIP9HoAKYlBS1Z+qrAeD8DhC
         uvinntKF+oPOJh6W6P20BAKHcqNyJLkJ4y3phvwvAspmgMZkPlw2/sffVnKaQa4Wer
         EFcO2azpgP+uas4tQJs47Ccio4MvC2IvhkA74KyXkEE/mo1VFTXiJB0cs8LXB0IA5t
         Hf8Q8T26oX3gg==
Date:   Wed, 1 Dec 2021 10:50:45 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH pci-fixes 2/2] Revert "PCI: aardvark: Fix support for
 PCI_ROM_ADDRESS1 on emulated bridge"
Message-ID: <20211201105045.41228d82@thinkpad>
In-Reply-To: <20211201015308.GA2791148@bhelgaas>
References: <20211130112937.GA3130@lpieralisi>
        <20211201015308.GA2791148@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Nov 2021 19:53:08 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Nov 30, 2021 at 11:29:37AM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Nov 25, 2021 at 05:01:48PM +0100, Marek Beh=C3=BAn wrote: =20
> > > This reverts commit 239edf686c14a9ff926dec2f350289ed7adfefe2.
> > >=20
> > > PCI Bridge which represents aardvark's PCIe Root Port has Expansion R=
OM
> > > Base Address register at offset 0x30, but its meaning is different th=
an
> > > PCI's Expansion ROM BAR register, although the layout is the same.
> > > (This is why we thought it does the same thing.)
> > >=20
> > > First: there is no ROM (or part of BootROM) in the A3720 SOC dedicated
> > > for PCIe Root Port (or controller in RC mode) containing executable c=
ode
> > > that would initialize the Root Port, suitable for execution in
> > > bootloader (this is how Expansion ROM BAR is used on x86).
> > >=20
> > > Second: in A3720 spec the register (address D0070030) is not document=
ed
> > > at all for Root Complex mode, but similar to other BAR registers, it =
has
> > > an "entangled partner" in register D0075920, which does address
> > > translation for the BAR in D0070030:
> > > - the BAR register sets the address from the view of PCIe bus
> > > - the translation register sets the address from the view of the CPU
> > >=20
> > > The other BAR registers also have this entangled partner, and they
> > > can be used to:
> > > - in RC mode: address-checking on the receive side of the RC (they
> > >   can define address ranges for memory accesses from remote Endpoints
> > >   to the RC)
> > > - in Endpoint mode: allow the remote CPU to access memory on A3720
> > >=20
> > > The Expansion ROM BAR has only the Endpoint part documented, but from
> > > the similarities we think that it can also be used in RC mode in that
> > > way.
> > >=20
> > > So either Expansion ROM BAR has different meaning (if the hypothesis
> > > above is true), or we don't know it's meaning (since it is not
> > > documented for RC mode).
> > >=20
> > > Remove the register from the emulated bridge accessing functions.
> > >=20
> > > Fixes: 239edf686c14 ("PCI: aardvark: Fix support for PCI_ROM_ADDRESS1=
 on emulated bridge")
> > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-aardvark.c | 9 ---------
> > >  1 file changed, 9 deletions(-) =20
> >=20
> > Bjorn,
> >=20
> > this reverts a commit we merged the last merge window so it is
> > a candidate for one of the upcoming -rcX. =20
>=20
> Sure, happy to apply the revert.
>=20
> What problem does the revert fix?  I assume 239edf686c14 ("PCI:
> aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge") broke
> something, but the commit log for the revert doesn't say *what*.  How
> would one notice that something broke?

Hello Bjorn,

It doesn't break any real functionality that I know of, although it
might, since the register is read pci/probe.c pci_setup_device()
(pci_read_bases()).

But allowing the access to the register when it has different meaning
is wrong in a similar sense that a memory leak is wrong (a memory leak
also does not necessarily cause real problems, if it is small, but
still we should fix it).

Marek
