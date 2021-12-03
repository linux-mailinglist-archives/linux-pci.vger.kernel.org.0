Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591E5467D89
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 19:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382735AbhLCS4R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 13:56:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52218 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhLCS4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 13:56:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B743962C7B
        for <linux-pci@vger.kernel.org>; Fri,  3 Dec 2021 18:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC56C53FCD;
        Fri,  3 Dec 2021 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638557570;
        bh=ISmLQUgnQ1l2PjckgWPYe0SB4pkcsqEjgQ/CIWtr/Ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cc8c2f0tDToOi97zLj0M6HxrA4avRg4bgyAV4l8j03gTuIgVpsCxGZGhFMYv2FHEt
         VNjAJftTLoRQTZTO8X7PIUjhL1D5pD87EbARzLTuNVYT6p8mlBd2k9U+00tNlhin11
         Vlvje6PIQ0C8j58rps+P8blVMow4mBICnB0r+LLiv5mw/lWQ++8SIEDVYw4TCkq2/s
         Bi5ylnkMAvj6+YNHSifMfph+Dz0cunzYJh+wuFUa53rGaT19UtDK2sI6zk1gF7qHGr
         5bckm5540V2JV71W6/oWc+rXo3gPAqy5PWAmzpBoLQDv+4cZae4HwsY3mJgfqLpUe1
         aMLSKZjTVfIMQ==
Date:   Fri, 3 Dec 2021 19:52:44 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 01/11] PCI: pci-bridge-emul: Add description for
 class_revision field
Message-ID: <20211203195244.11ca183f@thinkpad>
In-Reply-To: <20211203163649.GA3004204@bhelgaas>
References: <20211130172913.9727-2-kabel@kernel.org>
        <20211203163649.GA3004204@bhelgaas>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Dec 2021 10:36:49 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Nov 30, 2021 at 06:29:03PM +0100, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > The current assignment to the class_revision member
> >=20
> >   class_revision |=3D cpu_to_le32(PCI_CLASS_BRIDGE_PCI << 16);
> >=20
> > can make the reader think that class is at high 16 bits of the member a=
nd
> > revision at low 16 bits.
> >=20
> > In reality, class is at high 24 bits, but the class for PCI Bridge Norm=
al
> > Decode is PCI_CLASS_BRIDGE_PCI << 8.
> >=20
> > Change the assignment and add a comment to make this clearer.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> >  drivers/pci/pci-bridge-emul.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emu=
l.c
> > index db97cddfc85e..a4af1a533d71 100644
> > --- a/drivers/pci/pci-bridge-emul.c
> > +++ b/drivers/pci/pci-bridge-emul.c
> > @@ -265,7 +265,11 @@ int pci_bridge_emul_init(struct pci_bridge_emul *b=
ridge,
> >  {
> >  	BUILD_BUG_ON(sizeof(bridge->conf) !=3D PCI_BRIDGE_CONF_END);
> > =20
> > -	bridge->conf.class_revision |=3D cpu_to_le32(PCI_CLASS_BRIDGE_PCI << =
16);
> > +	/*
> > +	 * class_revision: Class is high 24 bits and revision is low 8 bit of=
 this member,
> > +	 * while class for PCI Bridge Normal Decode has the 24-bit value: PCI=
_CLASS_BRIDGE_PCI << 8
> > +	 */ =20
>=20
> Can you please re-wrap this comment so it fits in 80 columns like the
> rest of the file?

Bjorn, Lorenzo already applied this patches to his branch. Should I
send him a fixup, or try to persuade him to rebase? :)

> I'd do something with the assignment, too.  It's hard to read when it
> wraps, especially since at 80 columns it splits the "<<" in half.
>=20
> I assume from the commit log that this is purely a readability change,
> not a fix, right?

Yes, you are right. No functional change.
