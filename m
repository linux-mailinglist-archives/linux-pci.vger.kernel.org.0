Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC19692C50
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 01:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjBKA4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 19:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBKA4J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 19:56:09 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0D7FEE6;
        Fri, 10 Feb 2023 16:56:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PDBxD06zBz4y0y;
        Sat, 11 Feb 2023 11:55:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1676076960;
        bh=vsdWqmk6evpO1CkXGrmt5uybaHZLydlcCuuRMZ0s/Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbnE41+GLyWHvgaYls0iG4zh87ErjZzx9MVwnTadceemuVk8u3zZ2oX3xJrBQKAbs
         VxQlu9S3ev8eLCuvfWN9np4sW1HxXvWITFofO7SVeHAI4bngQgmRgHlWK+hXuPfPrm
         x6CkhKc3Y47Rg1XwzU3SwYvzMJRHBfo9wdb/ONxUQoe0avId44YPxDt2OTDNRaEDKR
         o5Go+Dv8dyrR1Y7LD0UY0hvAqkKPOvl9XfrgIKS9FHdc5Qel7dUcMbDxqb5mNYSAHv
         UDUvgZq8RmPaHxiFOVXFpGfqcFFoOONmrbrk3Kf2Xo2jezynWPUUA3RO6Svj3QKbH8
         7+OIkG0tSElLA==
Date:   Sat, 11 Feb 2023 11:55:58 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Update PCI git tree location for linux-next
Message-ID: <20230211115558.393dfc85@canb.auug.org.au>
In-Reply-To: <20230206162945.GA2214315@bhelgaas>
References: <20230206075337.43b3e4da@canb.auug.org.au>
        <20230206162945.GA2214315@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ifVphnz5tc8oNJctN.zW8Mm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Sig_/ifVphnz5tc8oNJctN.zW8Mm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Mon, 6 Feb 2023 10:29:45 -0600 Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 07:53:37AM +1100, Stephen Rothwell wrote:
> >=20
> > All done.  Do you want any contacts for this tree added to my list? =20
>=20
> Yes, please!  Can you add:
>=20
>   Lorenzo Pieralisi <lpieralisi@kernel.org>
>   Krzysztof Wilczy=C5=84ski <kw@linux.com>

Now added, sorry for the delay.

For Lorenzo's and Krzysztof's benefit:

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/ifVphnz5tc8oNJctN.zW8Mm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPm554ACgkQAVBC80lX
0GyNEwgAnWGJPVcoBkHA26NRagWfMo4i90790EJ7HhhZraE3TuEaNXq/b+m1v/+t
Ym0SNuXcSuMs0QfopJg81vUhGTiFM9dvtCDHrI1PxTzdbDroNn4fuu2gYyDfReoy
ClyUzdkNkaM8T7OcL1dSFGAkE4a+m72RD5J4CrlaVIzFmCFG1T7zfFdXjHT+2LgZ
GgsjqBJkyut76Xiv5hn2EXW7BcUnIE8oPmiufkFEZ552N7DN6CJ727MbCMO2yvCS
+sIPKcd9Ydu2PTf3Yo9xh0nEbzZ5EBrCCsYm7weQPTn19QFp1ID1ciXvOSDv9VWB
FmZtPLPjiOGnd9We6sEGyTUpssDynA==
=XW7Y
-----END PGP SIGNATURE-----

--Sig_/ifVphnz5tc8oNJctN.zW8Mm--
