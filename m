Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50D56927AA
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 21:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjBJUKw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 15:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjBJUKv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 15:10:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE8749AD;
        Fri, 10 Feb 2023 12:10:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 594A461E98;
        Fri, 10 Feb 2023 20:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F635C433EF;
        Fri, 10 Feb 2023 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676059847;
        bh=/PnsRdKZG9z1C31QNUYbUwY5HvpH894HR8JQeW84zbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i9nqpb0t5S6HkGqJoB5RnNgTfS0iO8BW7c/VxDDEtvavrIJxJGhCjxVjRMNPT92sK
         iam77oJIFeD0akFXYwJBCQUsXhl6G/nsnWwQaoN0hnM/o+yByNpZTSRSH7c+hd4ggV
         Y+gWg2JBrXxbgH/BEDQs/UDKq1IMLlk5ju0IzbA971quhy7iM1B2cE8UXOCAHuWRPP
         TvVFRgtGSuSMKc1rJRHAvRHS0M9l46gSq0g5N5uT1w9XrX4/gTrAGi0TTdfTkfhRc4
         Ar/iCEGpKiOhvh6gkJr+x4R7+KdyFYSwlHKutw9YogQA0r0m6LBufb0+gYxf9zFUKe
         yYtgRhdoBJkqw==
Date:   Fri, 10 Feb 2023 20:10:43 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
Message-ID: <Y+akw9VBjg9oZ7QV@spud>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
 <20230210164749.368998-9-nick.alcock@oracle.com>
 <Y+aMh5e9bWaTphiZ@spud>
 <871qmx1fv5.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z/HHnJsPkKXU4oK+"
Content-Disposition: inline
In-Reply-To: <871qmx1fv5.fsf@esperi.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--z/HHnJsPkKXU4oK+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2023 at 07:26:38PM +0000, Nick Alcock wrote:
> On 10 Feb 2023, Conor Dooley said:
> > FYI $subject seems wrong, this is a PCI patch AFAICT.
>=20
> I'm deriving the prefixes automatically because there are so many of
> them, picking that prefix which is most commonly used across all files I
> touch in a given subsystem and which is present in all of them. So
> the PCI: microchip part seems right to me.

Ye, not disagreeing with that part.

> kbuild is present in every patch in the series because this is a
> kbuild-driven change (the thing it disturbs is part of the build system,
> the construction of modules.builtin*). This seems to be common practice
> for kbuild-related treewide changes.

Okay, I'll take your word for it. It just looked/looks odd to me!

> > On Fri, Feb 10, 2023 at 04:47:49PM +0000, Nick Alcock wrote:
> >> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> >> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> >> are used to identify modules. As a consequence, uses of the macro
> >> in non-modules will cause modprobe to misidentify their containing
> >> object file as a module when it is not (false positives), and modprobe
> >> might succeed rather than failing with a suitable error message.
> >>=20
> >> So comment out all uses of MODULE_LICENSE that are not in real modules
> >
> > This patch should not been needed, there's an existing patch to make
> > this a module:
> > https://lore.kernel.org/linux-riscv/20230111125323.1911373-4-daire.mcna=
mara@microchip.com/
>=20
> Excellent: if that's likely to go in I can take this one out.

Hopefully! It's the removable modules that are seemingly a no-go for
PCI.
I'll prod Daire on Monday about responding to the comments and perhaps
the start of the series could get picked up. I'm not too sure if that's
something that the PCI folk do though.

> >> (the license declaration is left in as documentation).
> >
> > I don't really get this one though, why leave it there as
> > "documentation" when the file has an SPDX entry anyway?
>=20
> I was asked to. (The first version of this series just deleted it, but
> people were unhappy about the outright deletion of what looked like
> license info and the loss of MODULE_LICENSE while other MODULE_* was
> retained.)

I saw Luis' name on the suggestion which is why I asked rather than
dismiss it offhand. I think that's kinda silly, but I guess license
stuff invites paranoia.
I'd been kinda keeping an eye on the series as I know I've got a
non-module clk driver that has MODULE_CRAP() in it & been debating
whether I should just go & delete it all.
Still undecided.

> >> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> >> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: Luis Chamberlain <mcgrof@kernel.org>
> >> Cc: linux-modules@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-pci@vger.kernel.org
> >> Cc: linux-riscv@lists.infradead.org
> >
> > One for the future:
> > How about also CCing those listed in MAINTAINERS for the file you're
> > changing?
>=20
> That... was supposed to happen. I'm invoking
>=20
> scripts/get_maintainer.pl --email --m --n --l --subsystem -f $files
>=20
> and then parsing the result for maintainer:, open list: and moderated
> list: lines. I thought that would catch everything, but now I see
> this is more complex.  You are there as an M: line, so I thought you'd
> be reported as a maintainer:, but nooo:
>=20
> Conor Dooley <conor.dooley@microchip.com> (supporter:RISC-V MICROCHIP FPG=
A SUPPORT)
>=20
> I didn't realise that 'supporter' was a thing and thought
> get_maintainer.pl always reported maintainers as maintainer:. I'll
> resplit the series with supporters Cc:ed just like maintainers are.
> Looks like those are the only two I need to pick up.

Supporter is a weird one I suppose, without reading the header* it's a
little confusing. There was a thread recently with an attempt to
disambiguate in the submitting patches docs, and I /think/ one of what
they wanted to do was make get_maintainer return maintainer for both
maintainer and supporter to align better with the docs.

*Because who reads the intro/header explanation of the file, right? Just
run the script and/or jump straight to the relevant section

> Sorry about that.

Dw about it, sorry if I came across a little brisk.

>
> (This sort of systemic scripting bug is why I did a small tranche first.
> So thank you very much!)

--z/HHnJsPkKXU4oK+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+akwwAKCRB4tDGHoIJi
0m5oAP45+z9WbSWOZT2hY9iJ63R/NG9MYcoNpTa78o9XnYcS9gEA29oPccSYwDKh
ErMJgFGLb17K7AfhokcGeJVVAlC1KgI=
=Bo37
-----END PGP SIGNATURE-----

--z/HHnJsPkKXU4oK+--
