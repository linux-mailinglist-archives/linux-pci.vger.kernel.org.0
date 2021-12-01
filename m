Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5A4653D9
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 18:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351857AbhLAR0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 12:26:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49080 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240694AbhLAR0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 12:26:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C24A2B82060
        for <linux-pci@vger.kernel.org>; Wed,  1 Dec 2021 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D111C53FCC;
        Wed,  1 Dec 2021 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638379409;
        bh=mATazRZ8ck9UTb3opy+/JacKm2aBsyWXzBoQ6Obe8Kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bo8clrgPG8NaugQYY93dXZvT1ip3ErOI5x9GQuNW3IeCsJ3B9fBnczWF9cxeTdCZ/
         0q3QiMgKS3M0by2FpfABG/d7kHpE5hwbcizvf0QaFIjTmdsIc0nGiHsxyqY4ZTcoOA
         JMjeBdK84mwASBncGCBVnYZM0CUCtBKWpIIfXPB0LtVYrcq28m17V3sKlhvvkPczDQ
         otjDYEIGUJ0VER/drplEEOmaaTo9N5to3RRO4/sLqjfxWLAdW9K6nFx0zHARC+exCd
         fAuwre+4A3Tm+SjzkmWlFIHQ+v4WtxFSLhzlxEPGjzKQf0h9FKLat3NbnYQL+rt0mY
         iZXqvzETVGsUQ==
Date:   Wed, 1 Dec 2021 18:23:24 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org
Subject: Re: [PATCH pci-fixes 2/2] Revert "PCI: aardvark: Fix support for
 PCI_ROM_ADDRESS1 on emulated bridge"
Message-ID: <20211201182324.28df466c@thinkpad>
In-Reply-To: <20211201123518.GA2808813@bhelgaas>
References: <20211201105045.41228d82@thinkpad>
 <20211201123518.GA2808813@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 1 Dec 2021 06:35:18 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Dec 01, 2021 at 10:50:45AM +0100, Marek Beh=C3=BAn wrote:
> > On Tue, 30 Nov 2021 19:53:08 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >  =20
> > > On Tue, Nov 30, 2021 at 11:29:37AM +0000, Lorenzo Pieralisi wrote: =20
> > > > On Thu, Nov 25, 2021 at 05:01:48PM +0100, Marek Beh=C3=BAn wrote:  =
 =20
> > > > > This reverts commit 239edf686c14a9ff926dec2f350289ed7adfefe2.
> > > > >=20
> > > > > PCI Bridge which represents aardvark's PCIe Root Port has Expansi=
on ROM
> > > > > Base Address register at offset 0x30, but its meaning is differen=
t than
> > > > > PCI's Expansion ROM BAR register, although the layout is the same.
> > > > > (This is why we thought it does the same thing.)
> > > > >=20
> > > > > First: there is no ROM (or part of BootROM) in the A3720 SOC dedi=
cated
> > > > > for PCIe Root Port (or controller in RC mode) containing executab=
le code
> > > > > that would initialize the Root Port, suitable for execution in
> > > > > bootloader (this is how Expansion ROM BAR is used on x86).
> > > > >=20
> > > > > Second: in A3720 spec the register (address D0070030) is not docu=
mented
> > > > > at all for Root Complex mode, but similar to other BAR registers,=
 it has
> > > > > an "entangled partner" in register D0075920, which does address
> > > > > translation for the BAR in D0070030:
> > > > > - the BAR register sets the address from the view of PCIe bus
> > > > > - the translation register sets the address from the view of the =
CPU
> > > > >=20
> > > > > The other BAR registers also have this entangled partner, and they
> > > > > can be used to:
> > > > > - in RC mode: address-checking on the receive side of the RC (they
> > > > >   can define address ranges for memory accesses from remote Endpo=
ints
> > > > >   to the RC)
> > > > > - in Endpoint mode: allow the remote CPU to access memory on A3720
> > > > >=20
> > > > > The Expansion ROM BAR has only the Endpoint part documented, but =
from
> > > > > the similarities we think that it can also be used in RC mode in =
that
> > > > > way.
> > > > >=20
> > > > > So either Expansion ROM BAR has different meaning (if the hypothe=
sis
> > > > > above is true), or we don't know it's meaning (since it is not
> > > > > documented for RC mode).
> > > > >=20
> > > > > Remove the register from the emulated bridge accessing functions.
> > > > >=20
> > > > > Fixes: 239edf686c14 ("PCI: aardvark: Fix support for PCI_ROM_ADDR=
ESS1 on emulated bridge")
> > > > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > > > ---
> > > > >  drivers/pci/controller/pci-aardvark.c | 9 ---------
> > > > >  1 file changed, 9 deletions(-)   =20
> > > >=20
> > > > Bjorn,
> > > >=20
> > > > this reverts a commit we merged the last merge window so it is
> > > > a candidate for one of the upcoming -rcX.   =20
> > >=20
> > > Sure, happy to apply the revert.
> > >=20
> > > What problem does the revert fix?  I assume 239edf686c14 ("PCI:
> > > aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge") broke
> > > something, but the commit log for the revert doesn't say *what*.  How
> > > would one notice that something broke? =20
> >=20
> > Hello Bjorn,
> >=20
> > It doesn't break any real functionality that I know of, although it
> > might, since the register is read pci/probe.c pci_setup_device()
> > (pci_read_bases()).
> >=20
> > But allowing the access to the register when it has different meaning
> > is wrong in a similar sense that a memory leak is wrong (a memory leak
> > also does not necessarily cause real problems, if it is small, but
> > still we should fix it). =20
>=20
> What is the new information that led you to conclude that 239edf686c14
> is wrong?  Apparently you originally thought the bridge had a ROM BAR,
> but later decided it didn't, based on *something*?  New observation?
> New understanding of the spec?

Hi Bjorn,

The new observation is that although the register is defined in
register list (together with it's layour), it is not documented in RC
mode, although other BAR registers are (and their meaning is something
different from standard BAR registers in RC mode). Combined with the
fact that there is no ROM containing executable code in the SOC (which
we knew even before, but thought that maybe it could be somehow also
implemented), we concluded that this register has different meaning from
standard Expansion ROM BAR.

Marek

> I need to be able to explain why we should merge this after the merge
> window, and I'm having a hard time extracting that from the commit
> log.
>=20
> Bjorn

