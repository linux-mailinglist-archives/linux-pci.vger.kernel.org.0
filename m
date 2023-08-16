Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0DA77DDE1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbjHPJv7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbjHPJvv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 05:51:51 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F82724
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=pjnA
        d2IvOCH765Y6OcYlBsPrnBHU+4w4cKdan2DbybU=; b=Xhhdf8ZjHtgq+MdOxieJ
        WaCHz4HSOhFXUaU/1owOoy3az1S9NZ8SDkSYFIImzZZCBwy/E5BAQLveLdOUq60Y
        whd6UTJtBbfaTIjk+NYXcEP8YzCS6a2JeVvh2xViHN1/sSChflB46iuWIcDh6Acu
        JfALuaHYsLUIx9rQrcnlvkqs8oezWdU/p48gsHtWpP86zRgDq+j+hDEoTPl8bULE
        iPtlT30Qr21PqTsvtgH2QIdX/WyWlLEXp5F7czy/PTSdGYOoxkQx19FkxK2PQDvQ
        FFwFKdAmH7n2qc6OaQTBaYjR3LkVnozlXbAKFIIouMaHWoxaK/u7y9oUakQzOYU0
        Qw==
Received: (qmail 87517 invoked from network); 16 Aug 2023 11:51:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 11:51:17 +0200
X-UD-Smtp-Session: l3s3148p1@nPd0PAcDELwgAwDPXy5qAJ1huuy56R1W
Date:   Wed, 16 Aug 2023 11:51:13 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 RESEND 2/2] PCI: rcar-host: add support for optional
 regulators
Message-ID: <ZNycEWhT7a7llUSZ@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712103916.1631-3-wsa+renesas@sang-engineering.com>
 <20230713153401.GA317502@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z+q6h2c7HBqfnx+w"
Content-Disposition: inline
In-Reply-To: <20230713153401.GA317502@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--Z+q6h2c7HBqfnx+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2023 at 10:34:01AM -0500, Bjorn Helgaas wrote:
> On Wed, Jul 12, 2023 at 12:39:16PM +0200, Wolfram Sang wrote:
> > The KingFisher board has regulators. They just need to be en-/disabled,
> > so we can leave the handling to devm. Order variables in reverse-xmas
> > while we are here.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Krzysztof or Lorenzo may fix this up for you, but:
> s/add support/Add support/ in subject to match history
> and recast commit log to say what the patch *does* ("enable optional
> regulators using devm, so devm will automatically disable them when
> the driver releases the device"), not *what needs to be done*.

I will fix the commit messages and resend. But frankly, except the
latter is a tad more explicit, they both qualify for "what needs to be
done" for me *shrug* Still, thanks for the review, I appreciate it!


--Z+q6h2c7HBqfnx+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTcnAsACgkQFA3kzBSg
KbZriw/+I09tLqG4hjE4xb6HV6gZWEB8x6u5l7Y9HEkqwcyECM/IWZT2iULs1Jf8
l0MK5fOJB61p+VhicbfwXmcTaVgeOL22o1I0QfrW3bk8a79nueFH87x46jziYu3V
aAtelZIvxpxYnI50UIM8Vkh1So674QWdfZ9mw70smbj9jF3uGnNdlIENqj0ufo+G
Viogt7/KlncssCj5GRT1HKqjG5GLZXHPXk9FADMRLJGBJIryqK4hnsjfHymi+PYr
tW1BtPN5jJDWUMT7wFNpewqO4lqtywJC36hIxdOtaGJlE+W4uHtm0YT4XkW29hlw
JU0lij5nD/BwpfhW8DJjdhJn9Hggyh/pucizMGfAkpqpK75qnxiUMECFtXtLtiVl
5Ra2snfJjqj9pse2A/jNs90cN6UkGLqeWp338Rt4dJKbPl9s01j7HdPqCkbKCeSx
Yhoqjk1iCyXod4WyE6uRvvQ5v+LKw6uwjQVTSCSNICwZJuaUCpltgyc8Zgw0lROo
TMpoVGKUXMGP5zSejs5bYTWet+JS4kGN/jhy8YHGCKidf/EOY+dRqeLuBSRcvlwD
SDqfS4lz1CULEywwESn+xQDVAg6JYbzu/eQoaG8pdHXxuQP4N8ZXularhO+7wFlR
lpnnke2tlPHgyb50k9Ccpzu8pszblXyBRDOogF4yPZ+elhQn5EQ=
=VFZt
-----END PGP SIGNATURE-----

--Z+q6h2c7HBqfnx+w--
