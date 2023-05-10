Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F56FD878
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 09:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjEJHqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 May 2023 03:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjEJHqq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 May 2023 03:46:46 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A22715
        for <linux-pci@vger.kernel.org>; Wed, 10 May 2023 00:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=beOTgP5pTxuU9Al6EmJaU25rPQmT
        OWXAWKym5+KhSog=; b=HW02khGQQC7ffopx2iwBQx7qt9pQEFml4dbKXLVlMvb9
        2R0qL/OcjAG/SIt5gO2o/kupKKJceWwhsdB8wjRj0/lF6q31rwcoY7POjCB99Nj9
        UoUgmjlG6fFvV/Zmu7RFDrZkJnTHySB5wGFJ/RBC0aeEfXUx8j6LGBe+v9PHliM=
Received: (qmail 2345022 invoked from network); 10 May 2023 09:46:42 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 May 2023 09:46:42 +0200
X-UD-Smtp-Session: l3s3148p1@ULieElL7npgujnsI
Date:   Wed, 10 May 2023 09:46:41 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: rcar-host: add support for optional regulators
Message-ID: <ZFtL4TV//8l7ok3I@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230510065819.3987-1-wsa+renesas@sang-engineering.com>
 <20230510065819.3987-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdVHydQUBD6+zyLneuczd-3ixFbcF5z0toxZmhePT+ShSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NKI+c0u8aVow7vWC"
Content-Disposition: inline
In-Reply-To: <CAMuHMdVHydQUBD6+zyLneuczd-3ixFbcF5z0toxZmhePT+ShSw@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--NKI+c0u8aVow7vWC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +       int i, err;
>=20
> unsigned int i?

OK.

>=20
> >         struct pci_host_bridge *bridge;
>=20
> The (lack of) reverse-Xmas-tree ordering is hurting my OCD, but that's
> not your fault...

Ack :) I can change it, though.

> > +                       dev_err_probe(dev, err, "error enabling regulat=
or %s\n",
> > +                                     rcar_pcie_supplies[i]);
>=20
> Shouldn't this return, and propagate the error code upstream?

Ouch, brown paper bag, please.


--NKI+c0u8aVow7vWC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRbS+EACgkQFA3kzBSg
KbapOA//TU6Ry3GjQsQWLy0uRuCkIqtNogCxLgUxcbeCmbdtgpGIPGocm5XubxIy
l0QvnNXIYNtF/jfRRq/aJbr8os0xfXe34XuGLDDGN9VAh2fPFKne/CIiImrQOuGu
4ibAEqrNgDw77i7qH6hhylMZndxMJepSFkBDdI+JsYe5wkCGFCPGJgybQDhbtFq2
YWCGcLgRgx9CgQ30ToJsb/15GeUCK8N+I24iL13sQIjpkjWjgD6wphfRCwWdzrfq
wN+JuTgWunqRpvOW7itDBI2pFVoWo+kiXisvV7G9v7zfsy4VIg1d8IxxpEgGMDSA
0JgYxuPQpuqAI+awOOm8bMIHh/7RYqyxpUY6HPd3tNq8oT8FW3JIlbdRUWuCJbHI
Oe/Vz6qXaDIHyjMxYRu56dtPpLahIperk2jzdAKpDddRdKj/W6GvNKDSVmsSFbbt
2nza1Gqa7eS9mppcjqV1D+11Gy0TGjdeSuFb+sZz8mioIb797sGhnWqT78jPCo3R
xRzD+D+IhJ/es2kHE0y+EOnWMjGsOChgYFqaxA4ZGOalTMDkgRF10nzkC9wVMw+4
St/KZh3bMXqsPjIgYwAaceky/JuQc1rojm76wsDMOaU+vs7rfwJHOBUB7NQ0Zbzr
lDqxsGT8tlQtfUGIciE8SD7vNcLpElBXVpLtuuGW1j1LSuOzqn0=
=9ena
-----END PGP SIGNATURE-----

--NKI+c0u8aVow7vWC--
