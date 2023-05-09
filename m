Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AC36FC3BF
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 12:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEIKUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 06:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjEIKUy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 06:20:54 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA39D2D4
        for <linux-pci@vger.kernel.org>; Tue,  9 May 2023 03:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=P6Olt4QFOU/QFInNW9J3fmj152gv
        eLBp7EYTA0uPfnw=; b=wKVbIUQGfL7aLUupwIJYjPd5j8MZ2Vbvpk4Cm+9raVVZ
        eCKQWmwF/v2R+nl+a6y5ThnCuq4h9d/mbTCiYt0SvAQijvywVFtEtyAUdY3rN+lZ
        uz2XTu8xvyM5j8IgxvuAzpyH7WGzLC2jA92keVlpB03AdUQQMBnVyr+fWGLLCKI=
Received: (qmail 2038819 invoked from network); 9 May 2023 12:20:46 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 May 2023 12:20:46 +0200
X-UD-Smtp-Session: l3s3148p1@IXbPG0D7WL0ujnsI
Date:   Tue, 9 May 2023 12:20:46 +0200
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
Subject: Re: [RFC PATCH 2/3] PCI: rcar-host: add support for optional
 regulators
Message-ID: <ZFoeftCOnSDYFfHb@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508104557.47889-1-wsa+renesas@sang-engineering.com>
 <20230508104557.47889-3-wsa+renesas@sang-engineering.com>
 <CAMuHMdUZUTJmrE==zf2OxaBdQGa-zS2VC7hTtcE9aD+MD7JYDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DvudHUKh+55nlmsU"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUZUTJmrE==zf2OxaBdQGa-zS2VC7hTtcE9aD+MD7JYDQ@mail.gmail.com>
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


--DvudHUKh+55nlmsU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I don't know if PCIe specifies some ordering w.r.t. power supply
> enablement.

I found this which is good enough for me:

"There is no requirement for supply sequencing in either
PCI Express or PCI Express Mini Card; the supplies may
come up or go down in any order." [1]

Thanks, Linear Technology!

[1] https://www.analog.com/media/en/reference-design-documentation/design-notes/dn346f.pdf


--DvudHUKh+55nlmsU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmRaHnoACgkQFA3kzBSg
KbaGsg/+KdqT90l9mzXpWEtpc9NGGpXyONO9E3Y7Xqdipr0RaQRZ2N8THpD90hTR
fmk3yZq6H9KPN6ZaUcLmRYoBUy9zV39I4i+MGB44rZEdpETlmZdOPhMHPKQhnmCz
QSEPEeVzjrG8Ag0oqLpQEtHCXCVmzjoK0he/eJ0f09Dq5HPbZQafDedNJE9fhuOD
uZbN2md+5ZW+Hauc6StzAPKgv1Whm9XOn8lmSVtVPqr3nyvmi28LOWvR2fz4nnkB
nvKFLSNolH4baL2D8GnO5ArCjuHl/MpROYbL0EhGyDWkbsrMdfbvaomUscdtgxpT
BxIZdlCndtz8o6NDBg9/cOYWyMADZfzo2GIgRQFln9eezTmFiHYlHpjvMMd1D7yZ
RIEvmbrD9ldOyZCY3WrkHcy52IfY+KvI8HAzjAtK/Obb1HqH3uf2HCUfl2HNV/oG
/n5/QSOWY0euRuzcesH5Ntfl6MkIEpIQ3CNa4dq5bbb9GcDvJ4uwBjCELtuiPBfh
s3oq9wPc8wyH86NfyhJ25kEhTY2aZ5dLQ33OXqekEQtmoeuymfEWQVAYGi+Q4XPE
sK54gPMZ6XESGL84t5VnaqeBRQXk3lLCqPySJBlNG7Gw9gKMNG7oWJgr3gbnjzBz
KcY77ELwSf4MXXthI8yBlvi58/ZCws49cnLjHh/e/a+Wp3sVjyA=
=XPyg
-----END PGP SIGNATURE-----

--DvudHUKh+55nlmsU--
