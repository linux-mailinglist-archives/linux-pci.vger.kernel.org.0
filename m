Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4486FC65F
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 14:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbjEIMaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 08:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEIMaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 08:30:21 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350B1BD4
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 05:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=O7ltxVMMcMInBof4d0OnDbKkJnZu
        QoKhhWJSzl0H97U=; b=Kmeo0nFdRVC8jbGCGJOi5s5nX67DVq31zHV1bQtwOLkg
        3PEsLemIQd6u1ARAKt+g3MH1VSGZEvX5V1lOlQsGCiOantjk+rYPpzfx9ZlbMib3
        Xm4C+SbD4ZN2vgb7dLJTBTidFxoe7m6ZdPJeBjCNbNKdD9iN+w30deWzWz2R+8U=
Received: (qmail 2075146 invoked from network); 9 May 2023 14:30:15 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 May 2023 14:30:15 +0200
X-UD-Smtp-Session: l3s3148p1@JFLc6kH72q0ujnsI
Date:   Tue, 9 May 2023 14:30:15 +0200
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
Message-ID: <ZFo817TZtIn0Ry+d@ninjato>
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
 <ZFlD7x99++k3yfE1@kunai>
 <CAMuHMdUS56xQbOcRx7kVhL_irQQR2cnDr0Y6p6q8tCjZ2U_dwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XejAdsIjL01QPq9Q"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUS56xQbOcRx7kVhL_irQQR2cnDr0Y6p6q8tCjZ2U_dwg@mail.gmail.com>
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


--XejAdsIjL01QPq9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I couldn't find one and took what I think is the most used pattern. But
> > I wasn't entirely sure, this is why the series is still RFC.
>=20
> Upon second thought, shouldn't these supplies be part of a PCIe
> connector subnode, as they are not properties of the PCIe host
> controller itself?

Beats me. Current practice is to put it in the host controller.


--XejAdsIjL01QPq9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRaPNIACgkQFA3kzBSg
KbYcnA/+Mf7e2Kx1VZ9YMEhvAsnupmI/+OELVuUOwKhEBKroO1ssgozVcim8Bs6X
HJGf9d2Xgoq2CrKrs3s6V7Bdl/lxQcITIpstFNZ66EcJTlBy6Llqw7eNPPkfIQCq
OZEyhxKactnfiD1ClQ6LBUqymbclqn2y54yGvnFL5ZUMlOZD1PA561IOgf6f4WOT
5fVZ3yHi56dDwLzB0trIvCG0Uz55J+BpUhH6VJz5uAEsc3XHmG9EU8T66dGjqorp
MEGpRDNxh+Xxgl+XociCHks6dOfsuWwIIk0hxto56uZbd+R3zI3IdTvpd3siUy50
vSV3fY96S3PpUpyY/GpnvA9epf4NskvyATc2IDhUboQjhx/E5F6I4KRFOprP7kDq
MIJfr2SEk5EFUcVcUdYed6/dUxvJXsnXrzK0HIGvkLvIxQi7ZUEimrvbAnVK9+gT
Ve1o6LFmRJphDAjH1/JT5dchQQQqTwk2YKV4Fgd3fTJAwMpprmrH2LIaeWSVIQgw
SwnRcGBc3rGVBhRUuua19JyieEtEUz14ClynDg2uvKc67iqlFwEcH/Tx4lbCAP0+
uMgAWHfIeONCveBwa6GbDCj6n/cqpDVW+FCos3jSlhuQk+m2P3TTLNUyYsFv4OnA
lu7E34zT0iSt+FrgmawchAz9qdEUnwgavurNkc2gNUtDWFs1t0Q=
=d+5H
-----END PGP SIGNATURE-----

--XejAdsIjL01QPq9Q--
