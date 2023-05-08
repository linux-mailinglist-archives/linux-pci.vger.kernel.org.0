Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DD26FB66D
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEHSsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjEHSsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 14:48:40 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE506189
        for <linux-pci@vger.kernel.org>; Mon,  8 May 2023 11:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=N+T32Wk+pTxV7VttkAsFfeLVtXOl
        C1wQc3Js9qgFHIs=; b=k1EI27YZ6keuEuQZhmV6y6l1YK8bq72u9c/ZM3QTc01X
        mbB5pzlDR4NuPOjJiEB6nPmy8xtvGQujFwzaSLdDrxaEYnm5iiH5CWEpyPx55Het
        1vQTdFmaRQ7glfsm0eA7ueW5B/Os121z4Osm9DPyub8UG3hAX/o6nqfVOng1QTg=
Received: (qmail 1815449 invoked from network); 8 May 2023 20:48:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 May 2023 20:48:20 +0200
X-UD-Smtp-Session: l3s3148p1@jVHgFDP7nJcgAQnoAEUJAEwBl665NaHx
Date:   Mon, 8 May 2023 20:48:15 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: PCI: rcar-pci-host: add optional
 regulators
Message-ID: <ZFlD7x99++k3yfE1@kunai>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
 <20230508104557.47889-2-wsa+renesas@sang-engineering.com>
 <CAMuHMdWGaDT_XGpeVm-915hbxa8-w5303QWg0a0iCjqk998unQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BGbwmdAC02nFZp+w"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWGaDT_XGpeVm-915hbxa8-w5303QWg0a0iCjqk998unQ@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--BGbwmdAC02nFZp+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> > +  vpcie1v5-supply:
> > +    description: The 1.5v regulator to use for PCIe.
>=20
> +1.5V is only present on mini-PCIe slots...

Since mini-PCIe is a subset of PCIe, I'd think we can leave the
description as-is.

> > +
> > +  vpcie3v3-supply:
> > +    description: The 3.3v regulator to use for PCIe.
>=20
> ... while +3.3V is present on PCIe, mini-PCIe, and M2 PCIe slots.
>=20
> In addition, normal PCIe slots also have +12V.
> So I think it would be prudent to add a vpcie12v0-supply property, too.

I agree. I can't test it but it is trivial enough to add 12v support as
well.

> W.r.t. to the actual naming, I don't know if there's already a (de facto)
> standard for that?

I couldn't find one and took what I think is the most used pattern. But
I wasn't entirely sure, this is why the series is still RFC.

Thanks for the review!

   Wolfram


--BGbwmdAC02nFZp+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRZQ+sACgkQFA3kzBSg
KbaM9A//cputKYRhfFFBX1a5ZApHFl2oojm50b9gnX3G1GrmXtlnuSgs6q6mR2fT
gWixcAS/SxrAk7wEzJQthV6h135buKTcD6sXQg7bz+IZpPdG9ZRQ5JicE8O9C7Mv
B4v4pxe9QCfClfrZU1ipNTWWPVAnRWoj+WGyD5ueu58c+EdFF4OEl0PYgVb44bhi
/6vxqQwFNu5kS8gJSNouVbxHn9cK4OCYWbz4+hvXs/7XrRZG+lcaGidl0UQvjfO3
3Fjoty3eWfom6vMqFrsXaAFtg4WevHdzV4Z6MdCld8qREuc2hH8rFF7X2h5gGcLa
H/bJqnBxDQ12xIwDaTJB9wCwWFeQXViUCVpwDSWnjhoLDg7tFAsrOvwKWeWIEJca
So6Cxj/kQqFWb3GoxVtzNHU+ECC5xh/q+g5yFMsSCoI0tV3Nfdjh+06kuIpcx7V5
/02QYv7sLvjbTKu09etmEyAH9Zjv4baXKl2v9sRPWANIulxKIA7UWpb+T8L7Zkly
ALc/iLiZARhjvrfsHAkSR+4Slfb6KSGig9s4VYyaiWMA+Atg9mwbqc7fPaZv6Zjk
rZF9SgwwuFh9CdolxtOZFixhsjC44mYuBwP5a/anbHGiJbSiFp0hDSDZrgBEEeQD
JymX0Yp7IJJvx4ztS2BOXaWD4sn+11U93xN0IaV3syVsO1W0M94=
=51YL
-----END PGP SIGNATURE-----

--BGbwmdAC02nFZp+w--
