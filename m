Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E67F734C89
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 09:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjFSHm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFSHmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 03:42:45 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE8DE76
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=p616TOQ+HzOPu0YrIkat+11cC5Ga
        Tl1I3cp6P8kXlT4=; b=V0TnQuVi/XA2zRhILOg90KNJNNFAL10T1tLYvLiOTk4s
        vTKogDiyFJjEaCHfOHpovb5Fg/JwDIxxO+T3vxNdj0+t9F5D7urHF8I+NVLYFN3o
        YccnAfYf7zfIpt6cR34L3UVWw48zh9ANrJwZDxndNn+1rvysikRmiXtB59R+pVU=
Received: (qmail 149438 invoked from network); 19 Jun 2023 09:42:29 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 19 Jun 2023 09:42:29 +0200
X-UD-Smtp-Session: l3s3148p1@YxQ5rXb+/Ktehh9k
Date:   Mon, 19 Jun 2023 09:42:29 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v3 0/2] KingFisher: support regulators for PCIe
Message-ID: <ZJAG5aN1vtAJHqHz@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20230512075241.2770-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zGCe0u+Tq+fUjznm"
Content-Disposition: inline
In-Reply-To: <20230512075241.2770-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--zGCe0u+Tq+fUjznm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hiya,

On Fri, May 12, 2023 at 09:52:39AM +0200, Wolfram Sang wrote:
> Here are the patches to make PCIe cards work in the slot CN15 on a
> KingFisher board. Look at the patches for a changelog, please.
>=20
>=20
> Wolfram Sang (2):
>   dt-bindings: PCI: rcar-pci-host: add optional regulators
>   PCI: rcar-host: add support for optional regulators

Is it possible to have this in 6.5? I don't see it in -next as of today.

Happy hacking,

   Wolfram


--zGCe0u+Tq+fUjznm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmSQBuEACgkQFA3kzBSg
KbaFcg//ci7a7SLs/O+xsnTBL+uszAiaHyBQSmx5WW8eIebPlnX81CMvTwOZZ/QN
DLF0AFqtJa+umqltP5KsZbldItK7FF4pkHm5tW0ctA5W+zpBPs+oXm68Z87Kanpj
uBdGpAbPq/Jslhw+7vG9IG8BIHa3z2zglxNsf0m2kXm9mQHLxhxpwBC8EVJcTQaB
vtP+e3VVc1iGpjqIYlpsXkgarD5J+JiLNM1/EkBxLa1Nqb6ObUvWj9C/rwNh06mf
sA3NPVNFZihwzW7B8XtstC1QIObpbvP+YyjzCf9Ovk5QiEZuths+4uKiMYSbqCfd
Pfbahh7WNS7WT3RTYyz92w8Ng3UIR7EMdYQXm5VkdoxWa6guk6obJj44eVeVuAjV
qQ4TzqswbUBKIVxyUDoxxMPK816wXyJC2Xv+FCu0nWptJXU9edsZi//JDOIs5iyr
Fsz0VrIyzLnw8c9Ms6kBCx9yxXTP+MZZABix9XWJUgh8vkhDoNBSN8PB69yAdWTa
bwA4wcxoxipkeL1wil6cdRPMUjtXjTvrDsTz51DuqZw6g6dD4j5RmlBPNI28lXGJ
tXdKaGEWFI+qpdowagyeDbbAmik9mG6flsdkst/+AGWzOTgi8TAZormviky6HVVk
fXxKyA4lY/L8khVb1LoTJ6+FtogBsP/dBapwBrzLLOi3xnLtf9A=
=lYsb
-----END PGP SIGNATURE-----

--zGCe0u+Tq+fUjznm--
