Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59D677DF01
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjHPKlT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Aug 2023 06:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbjHPKlF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Aug 2023 06:41:05 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6662D51
        for <linux-pci@vger.kernel.org>; Wed, 16 Aug 2023 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=6vQ0
        h/xc972mfLMgmRimyYP9Efjx5aTcx+wTym0+fZI=; b=OoaWl8UQSpOI4529d1zq
        sD6Bcoo5HLh4ulXLey7Zr63mPO8H9D2m/l0AZfqKMsT1jStB/rkHkOkbF+LCnTEE
        srvgCgyo3GRmO/Y3jyby6MHx59FxpLt5KheELnBx8K9OSd0pmpeIjQED/YuqI5M5
        OnfbaYDnIWNf5t5PAUXAUIGGHY+dYH9/PqVwvzV3UGyBQ3SocRs8nX1le9kTdfHp
        Uv8vpQkNCFLwAXBiqf4exhiCxmR8TdJdyEvc9SGi3gck6Vn/1o+QCoVRuoyTYa73
        TpRaGVGzf0SYOWL3bAJjeyZ/dNeCuAGhwI3xzOskhYNtJA0M+JCuMIEfZ3MoJdsa
        4w==
Received: (qmail 101160 invoked from network); 16 Aug 2023 12:40:20 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 16 Aug 2023 12:40:20 +0200
X-UD-Smtp-Session: l3s3148p1@w/v36wcDuNcgAwDPXy5qAJ1huuy56R1W
Date:   Wed, 16 Aug 2023 12:40:18 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar: use proper naming for R-Car
Message-ID: <ZNynkgf0Kv79naXo@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230607204750.27837-1-wsa+renesas@sang-engineering.com>
 <20230624132228.GA2636347@rocinante>
 <20230626154537.GA2019715@rocinante>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NboSrFz4vGSFDTYU"
Content-Disposition: inline
In-Reply-To: <20230626154537.GA2019715@rocinante>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--NboSrFz4vGSFDTYU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 12:45:37AM +0900, Krzysztof Wilczy=C5=84ski wrote:
> Hello,
>=20
> > > Neither RCar, nor Rcar, but R-Car.
>=20
> There might be one more variance left to correct:

You are right, thank you, I will fix it, too.


--NboSrFz4vGSFDTYU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmTcp44ACgkQFA3kzBSg
KbZP2w//e129CkOJTuZz2apjTakOcqhsVAg7K31+oM1dia5iTYG/+q37yafXVQhe
lhS0Xd/7h4q/+AP8aGqc1pC/kqrCEKKXTVihowsNgtamvM7U7h+FhivadaTJoLF5
2Duz+Ds5fS8Y+wGeEGUN3SvvpUmAnIGdGvhoxOAjcbhJ0Z6xq4rcpmrqsbrhQhYT
m3lqKsZbaJWpII5VFXSzocoHIuzjUCQLbP3up3UFd1w4cONG8siyQVYjLUJw/r+7
DT/UHzZ+FMwKJpfQ6eOHZqT5AVFqvjR1B4Dzi/t34vLi581wyD62Z/QS2598LaS6
W8Mda414c14ZY8ZS2dsqIDtH+GVGiKs5Dp0D2gKNU/Q5UqT3sMEAsuzI2msF7aj+
QRq9zyehS4v5y3UwzSdLgHEEccZK8ogajzrVQ2wQa5cqBQdvIk1eB/cWtc2pnGvC
v0WLOrRHKHI7AdvTaobh1yZQDJfj1l9lG0/hSAd67jzrjGXt8xxy8l7qzHoZZZod
59dJluMYH0jcE7zNmu5Ijh/U2XDZHg/jZHaFAPBl014wGL+EKDUtABgcYFNBg3uX
N6I1Vvnx01PPaSOR7VtYmbjbeW3xvSrpJtvC1XNjf/wErlvXVtspjH9/Bl6uSRDQ
+JudV/1fKUJ3X6OJuiJyHrHPLKrzLFCZ19nAWS55CU1y2WhU4d0=
=iaay
-----END PGP SIGNATURE-----

--NboSrFz4vGSFDTYU--
