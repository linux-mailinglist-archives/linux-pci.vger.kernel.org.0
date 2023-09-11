Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CF279BB00
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350441AbjIKVia (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbjIKJzs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 05:55:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460D7E67;
        Mon, 11 Sep 2023 02:55:44 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1C8201C001B; Mon, 11 Sep 2023 11:55:43 +0200 (CEST)
Date:   Mon, 11 Sep 2023 11:55:42 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 3/5] PCI: Make quirk using inw() depend on
 HAS_IOPORT
Message-ID: <ZP7kHtc6B9rJmpcj@duo.ucw.cz>
References: <20230909002442.3578957-1-sashal@kernel.org>
 <20230909002442.3578957-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kadCGDsuwcAnPrga"
Content-Disposition: inline
In-Reply-To: <20230909002442.3578957-3-sashal@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NEUTRAL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--kadCGDsuwcAnPrga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Niklas Schnelle <schnelle@linux.ibm.com>
>=20
> [ Upstream commit f768c75d61582b011962f9dcb9ff8eafb8da0383 ]
>=20
> In the future inw() and friends will not be compiled on architectures
> without I/O port support.

Yeah, in future. Not in stable. Please drop.

BR,
								Pavel

> +++ b/drivers/pci/quirks.c
> @@ -102,6 +102,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE=
_ID_NEC_CBUS_1,	quirk_isa_d
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_2,	qui=
rk_isa_dma_hangs);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NEC,	PCI_DEVICE_ID_NEC_CBUS_3,	qui=
rk_isa_dma_hangs);
> =20
> +#ifdef CONFIG_HAS_IOPORT
>  /*
>   * Intel NM10 "TigerPoint" LPC PM1a_STS.BM_STS must be clear
>   * for some HT machines to use C4 w/o hanging.
> @@ -121,6 +122,7 @@ static void quirk_tigerpoint_bm_sts(struct pci_dev *d=
ev)
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGP_LP=
C, quirk_tigerpoint_bm_sts);
> +#endif
> =20
>  /*
>   *	Chipsets where PCI->PCI transfers vanish or hang

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--kadCGDsuwcAnPrga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZP7kHgAKCRAw5/Bqldv6
8ms7AJ48t8cYE1MY8h+khQb8aiJvfPjq8gCeMpcbzMAr9GnvxLinMUJMcqqgcwA=
=L1U8
-----END PGP SIGNATURE-----

--kadCGDsuwcAnPrga--
