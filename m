Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC64B312740
	for <lists+linux-pci@lfdr.de>; Sun,  7 Feb 2021 20:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGTor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Feb 2021 14:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGTor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Feb 2021 14:44:47 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE6C06174A;
        Sun,  7 Feb 2021 11:44:06 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DYfjW6BGkz9sVv;
        Mon,  8 Feb 2021 06:43:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1612727043;
        bh=ltYiGt6TK6vuybpo1dLZBhXtXG3N1/IDk2y8vCNNrNg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OdsSPBrR5hSgqYTpRuQMpKb3f2js+RSyh4nmFUAt7LiRVAC0i3QS3LIoyxOaHTp1V
         LKIzOka8qvU1BgDTjGStfoH+XuR7IDQa97RDMXp1SRs8tkUbgVv57nZtYSA1F71zrY
         fmULOihQhnCQMf8Atc02eLO6w/cIZhgg42gZ1MASduzoRUPLtA6d9lzT+0y9LejnFa
         4OV+XEvRj9rl8VoCtl7TCMyv4TiZrFGlTpUqig0Ndy8tt8mXd7GeheZSOrksovoco6
         x4k7i2QwFO1Ya+RwCPAdo552llREoVir+txgmzrpvNLM/yEpUldGzuQfWe8iDYAnp+
         65klvrKV+iROg==
Date:   Mon, 8 Feb 2021 06:43:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/2] pci sysfs file iomem revoke support
Message-ID: <20210208064357.29b3df55@canb.auug.org.au>
In-Reply-To: <20210204165831.2703772-1-daniel.vetter@ffwll.ch>
References: <20210204165831.2703772-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HZXOMZy1qKTf=dgNtb2Lic5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Sig_/HZXOMZy1qKTf=dgNtb2Lic5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu,  4 Feb 2021 17:58:29 +0100 Daniel Vetter <daniel.vetter@ffwll.ch> w=
rote:
>
> Hi all,
>=20
> This is a revised version of patch 12 from my series to lock down some
> follow_pfn vs VM_SPECIAL races:
>=20
> https://lore.kernel.org/dri-devel/CAKwvOdnSrsnTgPEuQJyaOTSkTP2dR9208Y66HQ=
G_h1e2LKfqtw@mail.gmail.com/
>=20
> Stephen reported an issue on HAVE_PCI_LEGACY platforms which this patch
> set tries to address. Previous patches are all still in linux-next.
>=20
> Stephen, would be awesome if you can give this a spin.

OK, I applied the 2 patches on top of next-20210205 and it no longer
panics for my simple boot test (PowerPC pseries_le_defconfig under
qemu).

--=20
Cheers,
Stephen Rothwell

--Sig_/HZXOMZy1qKTf=dgNtb2Lic5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmAgQv0ACgkQAVBC80lX
0Gyo1gf/SH1pSdhNbE2Vt94tyktGdYja0lGsoy/TOEl6OehIzW4kK0pdTbMpnvVY
bZ4/Me/eSj1UHkLGtXs/MHsIE98xJQVWxRYU4xYcOAuklIS6ePVtxu0cm6wGQrbx
Iieo/JSqtCtf2U03bfjfVc+wn3o/4pK8tx6mUqsYfZ1RL8txxXeCEgHPRHqkphF6
whFQKsvUIx0KUb+Vo86YhO7V5/EAtG22De7pSyE+ssE9FTDjMBeBNwNcTy3xIzOg
8ucfuK7YES+QCflvMtnEOynP5ZDTMZY/OVs0DDrWwL4/klrS4kZ/p63qJasVazcg
m7Vno/Hve3fT0kdlrxLU7ratx/u7fw==
=Zm2+
-----END PGP SIGNATURE-----

--Sig_/HZXOMZy1qKTf=dgNtb2Lic5--
