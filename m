Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669A068B1B0
	for <lists+linux-pci@lfdr.de>; Sun,  5 Feb 2023 21:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBEUxq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Feb 2023 15:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Feb 2023 15:53:46 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8037A1A4A0;
        Sun,  5 Feb 2023 12:53:44 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P91nv19zMz4xP9;
        Mon,  6 Feb 2023 07:53:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675630419;
        bh=WNtafT6Eqdqn9I8Tn/3HQdhCkFl2ZAcSZMuhO2qyoiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XpUN6KPsb96bUfMdw2Rd4V19mkexIW/isN+KNg8jYQPmfvKeQxuo/53zTraA0dDA5
         DVE04L1+ju8p0EoKfqTYgf1N4dB5Jg86fYjFmqgSCUe4vU+oKQW6uQ3W5MSGXOJ/0w
         c2hOxvR9e40ja4EoMVV3uFGZyyS/OZ5ncjKn2oH3X3Ipu6Yd+ClzfdITXIHL6rt0Tt
         IBAg/jiSIOVv7w4vlWHrjZf5ojmH3iVOl25HMjG4jEa7gAJC9SE+eCXryqLJUJEQ6e
         H0sEuDwJY9tdGzGM16bI+RBrmfbukdqAb7rf5uzhNvRw4bMu737ZFQAY9BQB4Qy/YJ
         aTh5H7neimWjw==
Date:   Mon, 6 Feb 2023 07:53:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-next@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Update PCI git tree location for linux-next
Message-ID: <20230206075337.43b3e4da@canb.auug.org.au>
In-Reply-To: <20230203222705.GA2054108@bhelgaas>
References: <20230203222705.GA2054108@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/W36l+Qb0OaNZY+dF3rhgxuG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

--Sig_/W36l+Qb0OaNZY+dF3rhgxuG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Fri, 3 Feb 2023 16:27:05 -0600 Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Hi Stephen,
>=20
> Can you please replace this PCI tree:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>=20
> with this new shared one:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>=20
> The branch names intended for linux-next ("for-linus" and "next") are
> staying the same.

All done.  Do you want any contacts for this tree added to my list?
--=20
Cheers,
Stephen Rothwell

--Sig_/W36l+Qb0OaNZY+dF3rhgxuG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPgF1IACgkQAVBC80lX
0GxIrAf/ZpmyvpuESO+/u2qbLOHRdV+56ZRGRSuUBJXNRdKKhLHlyVACx2e2yxwP
WPpAZhroiCx9jS24dPVxrRUVPmFllUnkYQG09P3blC3DhGL1P2mYgFDodc5OAVwf
HTDuORPalrfjlMUXdWgvR8OZk5UEEWOI0DSb1Wtatj+I8NG+yvJodgLtmXOWBPCD
NxKEPxrue3s1TnLrtlHmS8UBK2+MMPaPI526XWnD0X3B7XU9cFzIQfaIBpMhfwFQ
/dTrm7j51leLC8xs1XPs277zxZACln794V4cRfBgRhXOeDT6j2/Ir5aCY5fJ/BxP
QLjHhGtln+g+0cOlMNI7pKc7tzEWNw==
=a6kj
-----END PGP SIGNATURE-----

--Sig_/W36l+Qb0OaNZY+dF3rhgxuG--
