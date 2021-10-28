Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A19343E57B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbhJ1PyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 11:54:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229565AbhJ1PyW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 11:54:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F380E60F56;
        Thu, 28 Oct 2021 15:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635436315;
        bh=RQCFu2bzuvPr4JUWn0qTIZR5mpfWaOO3X14IYifWvn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sC7qClxFYhK47iMi9WkAbGDJ3RCz0GuemIOFh4wX4S4ZB3sP6LwPATPJaX78wPl8f
         3wHLb4hB4v2p5U3UfF5pODsxqKt032wjEpElNl8cKof6lwcHseCXnHzVVbhUgGnIzy
         QhmoXYIe68pCbqoLScNzKdfZke4QshK9FC3LGZx7qo6EZ/IFqU1L2prE2dci0uKtYF
         UdrlkHZjGqeO9Y8tq8NewnkO5VQ2tTqg/UTYLM8FaPCRr250Xd0TqLT+f1b+JKAnO5
         ysdRvF8UUguZic+5uKFbt/r+GbSR4hCY8w/lwC/hImqKrCXjC7/JG53r7vEXpdz22f
         hQTJpBXk8ey+A==
Date:   Thu, 28 Oct 2021 17:51:50 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 10/14] PCI: aardvark: Enable MSI-X support
Message-ID: <20211028175150.7faa6481@thinkpad>
In-Reply-To: <87r1c59nqf.wl-maz@kernel.org>
References: <20211012164145.14126-1-kabel@kernel.org>
        <20211012164145.14126-11-kabel@kernel.org>
        <20211027141246.GA27543@lpieralisi>
        <20211027142307.lrrix5yfvroxl747@pali>
        <20211028110835.GA1846@lpieralisi>
        <20211028111302.gfd73ifoyudttpee@pali>
        <20211028113030.GA2026@lpieralisi>
        <20211028113724.gm6zhqt7qcyxtgkq@pali>
        <87r1c59nqf.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 28 Oct 2021 16:24:08 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Thu, 28 Oct 2021 12:37:24 +0100,
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >=20
> > On Thursday 28 October 2021 12:30:30 Lorenzo Pieralisi wrote: =20
> > > On Thu, Oct 28, 2021 at 01:13:02PM +0200, Pali Roh=C3=A1r wrote:
> > >=20
> > > [...]
> > >  =20
> > > > > > In commit message I originally tried to explain it that after a=
pplying
> > > > > > all previous patches which are fixing MSI and Multi-MSI support=
 (part of
> > > > > > them is enforcement to use only MSI numbers 0..31), it makes dr=
iver
> > > > > > compatible with also MSI-X interrupts.
> > > > > >=20
> > > > > > If you want to rewrite commit message, let us know, there is no=
 problem. =20
> > > > >=20
> > > > > I think we should.
> > > > >  =20
> > > > > > > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > > > > Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org> =20
> > > > >=20
> > > > > By the way, this tag should be removed. Marek signed it off, that
> > > > > applies to other patches in this series as well. =20
> > > >=20
> > > > Ok! Is this the only issue with this patch series? Or something oth=
er
> > > > needs to be fixed? =20
> > >=20
> > > The series looks fine to me - only thing for patch[4-10] I'd like
> > > to have evidence MarcZ is happy with the approach =20
> >=20
> > Marc, could you look at patches 4-10 if you are happy with them? Link:
> > https://lore.kernel.org/linux-pci/20211012164145.14126-5-kabel@kernel.o=
rg/ =20
>=20
> Started with patch #4, and saw that you are still using
> irq_find_mapping + generic_handle_irq which I objected to every time I
> looked at this patch ([1], [2]).
>=20
> My NAK still stands, and I haven't looked any further, because you
> obviously don't really care about review comments.
>=20
> 	M.
>=20
> [1] https://lore.kernel.org/r/8735r0qfab.wl-maz@kernel.org
> [2] https://lore.kernel.org/r/871r6kqf2d.wl-maz@kernel.org
>=20

Marc, we have ~70 patches ready for the aardvark controller driver.

It is patch 53 [1] that converts the old irq_find_mapping() +
generic_handle_irq() API to the new API, so it isn't that Pali did
not address your comments, it is that, due to convenience, he addressed
them in a later patch.

The last time Pali sent a larger number of paches (in a previous
version, which was 42 patches [1]), it was requested that we split the
series into smaller sets, so that it is easier to merge.

Since then some more changes accumulated, resulting in the current ~70
patches, which I have been sending in smaller batches.

I could rebase the entire thing so that the patch changing the usage of
the old irq_find_mapping() + generic_handle_irq() API is first. But
that would require rebasing and testing all the patches one by one,
since the patches in-between touch everything almost everything else.

If it is really that problematic to review the changes while they use
the old API, please let me know and I will rebase it. But if you could
find it in yourself to review the patches with old API usage, it would
really save a lot of time and the result will be the same, to your
satisfaction.

Marek

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/commit/?h=3D=
pci-aardvark&id=3Dc77d04754fbe85ed37fd7517cee253022f8428fe

[2]
https://patchwork.kernel.org/project/linux-pci/cover/20210506153153.30454-1=
-pali@kernel.org/
