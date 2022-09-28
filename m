Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3CE5EDEF9
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 16:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiI1OkI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 10:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiI1OkH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 10:40:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B91D7EFE3;
        Wed, 28 Sep 2022 07:40:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id f20so17553489edf.6;
        Wed, 28 Sep 2022 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ekAiCWadc/IugK61bJnxOBEoHGO6pu7qU5yyBGglVPw=;
        b=qztkwIZeUr/hMW0RJ8T8bJa59u90ryviXcpQ9B0eNQxLR6oTFMGKQJZHXcj+75B0wm
         77eS+OT9GPp8p2RqDQ6njgDanILrIMSdpe0uTpMDu1kt6+5A6JjitsaxL+veq/Vil8w4
         CCaA0CvaRREf4g5b2XOeLX5SbZQP2npJjeUj+EchwO+TqG8RasOT+rVq/MORLSldbcys
         y3eTY9iXW/316RrWLgB5iuJt/V2eFeAb629LnsXHNDFZTo/S5QUGDcbDpy/Ln5xpLeH2
         WBaSplTtcp8Yxc7DhbRvWeP3w6+lDrlR1a+cnfVqW62b9vd05M92u7adhWsQMjlF3Hyi
         08oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ekAiCWadc/IugK61bJnxOBEoHGO6pu7qU5yyBGglVPw=;
        b=nYAj6K1/bfPT95XV8YNh/3AS9fJhDIT3Cq4Og58c9BWsZoYg5AfyuIZ+Ea/54yXz/N
         D0vBjCwI2q4ktMkfmFcOJoDr1HrcVxc8viDqxoRAup192XXy46xn7ev/LarbY5ccbACq
         +PKcK9WApB2U1N6YxmNtmVpGBU7MT58OPD6Cr/5R8sYY3idYl4W/izWKyYqIvGdkFHNt
         NPSP5CdJEvt4hylE/yDpR1jcR7q0nJmjM6A7+/ValyOBXpT9D/mQtDMr2qUT0pgS0R4K
         ml0fh+kIo+KIcXAshd7lzW4mmMv67y7/rRfLI6e49ERB7ZxBpiVy2nERzhaY4mGkWYig
         QRiQ==
X-Gm-Message-State: ACrzQf1WeTMGCkaBIOt/w8G2sQtcq8lV0hK8/KXp7YljG5Q/grxDWUQH
        Jopss7PmNZGFzvRxEw2Zh9M=
X-Google-Smtp-Source: AMsMyM4/7EmUrkDhnWZzIhFJPBiO+4ND47aBSIcUwmtg4gwIrr5TOW1iT6P15q3htkn7C6rkJXHhjA==
X-Received: by 2002:a05:6402:270d:b0:452:4285:87b7 with SMTP id y13-20020a056402270d00b00452428587b7mr33095304edd.135.1664376005010;
        Wed, 28 Sep 2022 07:40:05 -0700 (PDT)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906329200b0077f5e96129fsm2474478ejw.158.2022.09.28.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:40:04 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:40:02 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Message-ID: <YzRcwkAqoiqr0VhB@orome>
References: <20220928121911.14994-1-pali@kernel.org>
 <YzRbnjb6UVwrj/li@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wgdOBF4sKJ52vuXE"
Content-Disposition: inline
In-Reply-To: <YzRbnjb6UVwrj/li@orome>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--wgdOBF4sKJ52vuXE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 28, 2022 at 04:35:10PM +0200, Thierry Reding wrote:
> On Wed, Sep 28, 2022 at 02:19:11PM +0200, Pali Roh=C3=A1r wrote:
> > Simplify pci-tegra.c driver code and use new PCI_CONF1_EXT_ADDRESS() ma=
cro
> > for accessing PCI config space.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > ---
> > Please look also at this related patch:
> > https://patchwork.kernel.org/project/linux-pci/patch/20220911113216.148=
92-1-pali@kernel.org/
> > ---
> >  drivers/pci/controller/pci-tegra.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
>=20
> I had to go chase down the patch that introduces PCI_CONF1_EXT_ADDRESS.
> It would've been easier if this had been part of the series that
> introduced that, or if you had provided a link to that patch here.
>=20
> Anyway, looks like this is equivalent to the existing inline function,
> so:
>=20
> Acked-by: Thierry Reding <treding@nvidia.com>

After looking at the linked patch, perhaps revise this one more time and
remove the comment above the removed helper since it's now just a
duplication of what the PCI_CONF1_EXT_ADDRESS comments say.

Thierry

--wgdOBF4sKJ52vuXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmM0XMIACgkQ3SOs138+
s6E4vg//aq29as5dOoYD/iQAcoZLxojhmIhteyPO4CN2K78Xar4DLaMbECiCLAIU
ZX+hyODe6/XkzWHm8m5WKD+ewDgmwxUMWoTYN7UI7FM0WPqt3vtEXV0tUAvGIzUn
a2Y5u3ohXIm3j1hHwVMsXi7HMeVGrvsDoiULfNOApoaXooDHWP3fd3VGS9BZuMEb
GOJ9WeFIaCWuN8gk0gjWUbf4ZV7Jk7N7XmD/Kef7AjKWbkAeAJWsNTfM0Fj8oPFq
p7S6xMbRfO7/S/QUGlbwxKmSX6iP7jtlhRGfDvDP6XMo/UPB7T0jCVpIhOjShb2t
BDVQg85fx6dMFECM+DLvlxPMmFvReICDqeLPj4K+RW0y0DWEBLHZ89WiugtxrRWV
EcJYu3X5DKW1AdW3csYTmuOd8YLPSnHn453Aa5wNIhoqLGUQ4i1jTJWxER3fHSrO
zul5uHhgsJMRPSDgntpi0ivKSBtaOmnyJ9QTs7diagWzwOGmDfyiofOgzzsTMnlK
2jmYOx30AUT5zKNdycYNH7kqinOssJ5N4f6AfOdXec9S4/5EYNvtXiGjFaQrXRaM
2ZJuGOrSs2cvqDSdJzZhE/YDBX0GR5jdx+R+Z9qjpKhYbyROzr3g27PUPESY1lB9
yJOep9O4OJn1SavBg4KONqUCYQOZUvekFGnNzbG4JycCsipd50M=
=q/hC
-----END PGP SIGNATURE-----

--wgdOBF4sKJ52vuXE--
