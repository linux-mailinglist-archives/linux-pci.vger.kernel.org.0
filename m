Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944E943E84C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1S0o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230505AbhJ1S0m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:26:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6526610D2;
        Thu, 28 Oct 2021 18:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635445454;
        bh=lPDoziXSHyqP2WCwTu91lzKQZX9C3QlIxwdROw7juSA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q1ESfL7qIKkC5yOyaZLBggVqFqX4RVWSyF7kVV6jUGodhvPjuYNZ+EQBOm0EuC4lh
         coOrzC3trIlmM9E7k7j3s6OxbKbGehYewBiHPgcVtpxqaCOKcJ9OU7e9MhrH6Ss/N3
         ydqZucW2L6+yIX02M37gs5/RAx/VVCDbn9g/OBdXZ77OGZAsK7plMRm38K4GD89RE7
         cjww5SnP1lbXTVURT/55tSoL1MxCwlztcM73XxEzT0c2BXM1zdvrvavLtRtt1SSJld
         0nYkWI3GxKbNvufsu0TZVf6LmdwqasvjZdxDDUnyA+yTsmJlXDfDSYdb8LpoGxXb5c
         J6PYnHRuPKOnw==
Date:   Thu, 28 Oct 2021 20:24:09 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028202409.5b42f66e@thinkpad>
In-Reply-To: <20211028174710.GA4484@lpieralisi>
References: <20211027141246.GA27543@lpieralisi>
        <20211027142307.lrrix5yfvroxl747@pali>
        <20211028110835.GA1846@lpieralisi>
        <20211028111302.gfd73ifoyudttpee@pali>
        <20211028113030.GA2026@lpieralisi>
        <20211028113724.gm6zhqt7qcyxtgkq@pali>
        <87r1c59nqf.wl-maz@kernel.org>
        <20211028175150.7faa6481@thinkpad>
        <20211028182514.65a94c8e@thinkpad>
        <87o8799j9c.wl-maz@kernel.org>
        <20211028174710.GA4484@lpieralisi>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Oct 2021 18:47:18 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Thu, Oct 28, 2021 at 06:00:47PM +0100, Marc Zyngier wrote:
> > On Thu, 28 Oct 2021 17:25:14 +0100,
> > Marek Beh=C3=BAn <kabel@kernel.org> wrote: =20
> > >=20
> > > On Thu, 28 Oct 2021 17:51:50 +0200
> > > Marek Beh=C3=BAn <kabel@kernel.org> wrote:
> > >  =20
> > > > Marc, we have ~70 patches ready for the aardvark controller driver.
> > > >=20
> > > > It is patch 53 [1] that converts the old irq_find_mapping() +
> > > > generic_handle_irq() API to the new API, so it isn't that Pali did
> > > > not address your comments, it is that, due to convenience, he addre=
ssed
> > > > them in a later patch.
> > > >=20
> > > > The last time Pali sent a larger number of paches (in a previous
> > > > version, which was 42 patches [1]), it was requested that we split =
the
> > > > series into smaller sets, so that it is easier to merge.
> > > >=20
> > > > Since then some more changes accumulated, resulting in the current =
~70
> > > > patches, which I have been sending in smaller batches.
> > > >=20
> > > > I could rebase the entire thing so that the patch changing the usag=
e of
> > > > the old irq_find_mapping() + generic_handle_irq() API is first. But
> > > > that would require rebasing and testing all the patches one by one,
> > > > since the patches in-between touch everything almost everything els=
e.
> > > >=20
> > > > If it is really that problematic to review the changes while they u=
se
> > > > the old API, please let me know and I will rebase it. But if you co=
uld
> > > > find it in yourself to review the patches with old API usage, it wo=
uld
> > > > really save a lot of time and the result will be the same, to your
> > > > satisfaction. =20
> > >=20
> > > Lorenzo, Marc, Bjorn,
> > >=20
> > > I have one more question.
> > >=20
> > > Pali prepared the ~70 patches so that fixes come first, and
> > > new features / changes to new API later.
> > >=20
> > > He did it in this way so that the patches could be then conventiently
> > > backported to stable versions - were we to first change the API usage
> > > to the new API, and then fix the ~20 IRQ related things, we would
> > > afterwards have to backport the fixes by rewriting them one by one.
> > >=20
> > > Is this really how we should do this? Should we ignore stable while
> > > developing for master, regardless of how much other work would need to
> > > be spent by backporting to master, even if it could be much simpler by
> > > applying the patches in master in another order? =20
> >=20
> > I already replied to that in August. Upstream is the primary
> > development target. If you want to backport patches, do them and make
> > the changes required so that they are correct for whatever kernel you
> > target. Stable doesn't matter to upstream at all. =20
>=20
> +1
>=20
> Please don't write patch series with stable backports in mind, don't.
>=20
> Let's focus on mailine with one series at a time, I understand it is
> hard but that's the only way we can work and I can keep track of what
> you are doing, if we keep splitting patch series I can't track reviews
> and then we end up in this situation. I asked if you received Marc's
> feedback exactly because I can't track the original discussion and if I
> merged the series (the MSI bits) I would have ignored what Marc
> requested you to do and that's not OK.
>=20
> So, given the timing, I will try to merge patches [1-3] and [11-14]
> if I can rebase the series cleanly; maybe I can include patch 9 if
> it does not depend on previous patches.

Very well. Ignore patch 9, since it touches IRQ. In the next batch I
shall send IRQ changes, with the first or second patch converting to
this new API.

Marek
