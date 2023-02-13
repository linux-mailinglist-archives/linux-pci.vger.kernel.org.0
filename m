Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DE694D53
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 17:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjBMQvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 11:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjBMQvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 11:51:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7A11B55E;
        Mon, 13 Feb 2023 08:51:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4649D611D8;
        Mon, 13 Feb 2023 16:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2830EC433EF;
        Mon, 13 Feb 2023 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307081;
        bh=hdUq2Luq23RINKGxSUxGVQp79jBS8lzD3Eqz+8CvlJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFPrK+l+mxRsLqUL3UYvZzzKPo4Wz8ryZ+xeBLj7AAAr5EN9qRlmeVBvaZpzEbV9P
         lGjk5l3QX87Ohzys03sxCmCWFT+iVdI5kigcxT+jgrCLLm+vWEO6j+/tGCfwKPUabe
         K4BFzHfX8i0Ci90c+ns2TfxfdKnpwr7n2ChxeIBky3v6TPBvPkzVqADjsz83R9UfOS
         sKvi9ZhEOgGxf4Rfrq5acluN4PKb/9NnKln//FOkKW7JcLvvoCHMiv294hwiYJF7Yo
         vKLlTRspkuQfHy11I/chhwiSNSG9nYZIFZ+g5RRQnz3HvTGGWc4H24UkVw+oVorBeR
         5llOSEvxfYzLw==
Date:   Mon, 13 Feb 2023 16:51:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 8/8] kbuild, PCI: microchip: comment out MODULE_LICENSE
 in non-modules
Message-ID: <Y+pqhTmuCRFUa/Vi@spud>
References: <20230210164749.368998-1-nick.alcock@oracle.com>
 <20230210164749.368998-9-nick.alcock@oracle.com>
 <Y+aMh5e9bWaTphiZ@spud>
 <871qmx1fv5.fsf@esperi.org.uk>
 <Y+akw9VBjg9oZ7QV@spud>
 <Y+kx3fb2Lzlg+u5+@unreal>
 <87k00ly25v.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V8wF6pIbk/VN+PxO"
Content-Disposition: inline
In-Reply-To: <87k00ly25v.fsf@esperi.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--V8wF6pIbk/VN+PxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2023 at 04:13:00PM +0000, Nick Alcock wrote:
> [Modified resend: my MTA claimed not to send it but then sent it to some
>  recipients anyway, and then I was asked not to do some of the things
>  I'd offered after I sent it.]
>=20
> On 12 Feb 2023, Leon Romanovsky told this:
>=20
> > On Fri, Feb 10, 2023 at 08:10:43PM +0000, Conor Dooley wrote:
> >> On Fri, Feb 10, 2023 at 07:26:38PM +0000, Nick Alcock wrote:
> >> > On 10 Feb 2023, Conor Dooley said:
> >> > > FYI $subject seems wrong, this is a PCI patch AFAICT.
> >
> > <...>
> >
> >> > kbuild is present in every patch in the series because this is a
> >> > kbuild-driven change (the thing it disturbs is part of the build sys=
tem,
> >> > the construction of modules.builtin*). This seems to be common pract=
ice
> >> > for kbuild-related treewide changes.
> >>=20
> >> Okay, I'll take your word for it. It just looked/looks odd to me!
> >
> > It looks odd to me too. Please add SPDX tag in modules which don't have
> > it already, instead of commenting code.
>=20
> Alas... nearly all of them *do* have it already, and in most cases it is
> different. Usually not *very* different, but different. In most cases it
> is more specific, e.g. drivers/soc/fujitsu/a64fx-diag.c, where we have
> MODULE_LICENSE("GPL") but SPDX says it's GPL-2.0-only, but then there
> are things like lib/packing.c, which throughout its history in the tree
> has combined // SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
> and MODULE_LICENSE("GPL v2"); which are just not the same thing.
>=20
> I commented the MODULE_LICENSEs out specifically because I wanted to
> avoid getting into hundreds of simultaneous license flamewars while
> trying to get *a different thing entirely* into the kernel (kallmodsyms,
> which depends on modules.builtin.objs being correct).
>=20
> I still don't want to get into hundreds of simultaneous license
> flamewars or get my employer into legal hot water, so I think I'll leave
> things commented out and let individual maintainers decide whether they
> want to reconcile any contradictory info that may exist or not (and as
> noted *most* of these are conflicting.)
>=20
>=20
> This email is the closest thing I have to indicating what Luis would
> prefer (and the only reason I'm doing this is because I need it before
> Luis's modules.builtin.objs change can work):
>=20
> <https://lore.kernel.org/linux-modules/Y5AgMuMu75gne6Ka@bombadil.infradea=
d.org/>
>=20
> Yes, Luis thinks we can just use SPDX, but given that they are usually
> different, making such a change seems well beyond my pay grade. Even in
> the PCI domain, we see (second column, MODULE_LICENSE: third: SPDX,
> sorry about the line lengths).
>=20
> drivers/pci/controller/dwc/pcie-histb.c:		GPL v2		// SPDX-License-Identif=
ier: GPL-2.0
> drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c:	GPL v2		// SPDX-Lic=
ense-Identifier: GPL-2.0
> drivers/pci/controller/pci-tegra.c: 			GPL		// SPDX-License-Identifier: G=
PL-2.0+
> drivers/pci/controller/pci-versatile.c:			GPL v2		// SPDX-License-Identif=
ier: GPL-2.0
> drivers/pci/controller/pcie-hisi-error.c:		GPL v2		// SPDX-License-Identi=
fier: GPL-2.0
> drivers/pci/controller/pcie-microchip-host.c:		GPL		// SPDX-License-Ident=
ifier: GPL-2.0
> drivers/pci/endpoint/pci-ep-cfs.c:			GPL v2		// SPDX-License-Identifier: =
GPL-2.0
> drivers/pci/endpoint/pci-epc-core.c:			GPL v2		// SPDX-License-Identifier=
: GPL-2.0
> drivers/pci/endpoint/pci-epc-mem.c:			GPL v2		// SPDX-License-Identifier:=
 GPL-2.0
> drivers/pci/endpoint/pci-epf-core.c:			GPL v2		// SPDX-License-Identifier=
: GPL-2.0
> drivers/pci/hotplug/acpiphp_core.c:			GPL		// SPDX-License-Identifier: GP=
L-2.0+
> drivers/pci/hotplug/shpchp_core.c:			GPL		// SPDX-License-Identifier: GPL=
-2.0+
>=20
> Not much in the way of consistency here: GPL sometimes means 2.0+ but
> sometimes it means 2.0. GPL v2 appears to consistently mean GPL-2.0, but
> if you look at other affected modules you soon see inconsistency:
>=20
> drivers/powercap/powercap_sys.c: GPL v2		// SPDX-License-Identifier: GPL-=
2.0-only
> drivers/firmware/imx/imx-scu.c: GPL v2		// SPDX-License-Identifier: GPL-2=
=2E0+
> arch/x86/crypto/blake2s-glue.c: GPL v2		// SPDX-License-Identifier: GPL-2=
=2E0 OR MIT
> drivers/iommu/sun50i-iommu.c: Dual BSD/GPL	// SPDX-License-Identifier: (G=
PL-2.0-only OR BSD-2-Clause)

See bf7fbeeae6db ("module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
bogosity") for more information on the contents of MODULE_LICENSE.

I don't really have a comment on the rest of this, other than thinking
that, for the microchip one, you should leave it as is & the driver be
changed to be module capable.

>=20
> We even have
>=20
> drivers/gpu/drm/drm_mipi_dsi.c: "GPL and additional rights" (header is
> non-SPDX -- a BSD license header with advertising clause!)
>=20
> So SPDX is usually more precise than the MODULE_LICENSE, but is it more
> *accurate*? I have no idea, and I don't see how I could possibly know:
> going by the presence of advertising clauses that obviously nobody is
> obeying it doesn't seem like we can trust header comments to be any more
> accurate than MODULE_LICENSE. Best to just leave both in (and comment it
> out so it has no side-effects on the build any more, which is all I'm
> after).
>=20
> --=20
> NULL && (void)

--V8wF6pIbk/VN+PxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY+pqdAAKCRB4tDGHoIJi
0pNmAQDabF/bd4lGSJqLIeDKr2MotZr5XyVPWaLlf4T25b/JbgD/QrKOrtI1pcij
CkmQGgWoQRFzWsh6sCn2D5YbVpYi9AI=
=vCVM
-----END PGP SIGNATURE-----

--V8wF6pIbk/VN+PxO--
