Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3E764499A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Dec 2022 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiLFQo5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Dec 2022 11:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiLFQo4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Dec 2022 11:44:56 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ED8BB0;
        Tue,  6 Dec 2022 08:44:55 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d14so16159505edj.11;
        Tue, 06 Dec 2022 08:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6yIH7MQsLl6LEDg45qMcCaM1O7Ac9+38QvTCM2uDf8=;
        b=L74YGzYG9EA12cBG2uOSAnIn2gta3+EYRxNkg7R+CzBtJREqTJ/6Awi8Lo4rx3t5Pp
         FUXsta1vcPSBAvBK/kbKa+hOumJEd6n/L4xKzr1nl/RQLiO5rydYyKvMxRH3KlJqOprF
         9gK0sViZiNHfhwbGezlrz7CPLSSzrtu3X+xGDL1tgKUpPCfOPONpPvCvXnH14VRmXQkk
         44xeG3Endhoemy76dTqgm8iVCvCavdmf95ccOjeu9qjStHg8UIRTb1TUuI8/9rIDt9rJ
         Sq6bJx2gLuR6cgyCA5vsw4B2Rsxhgfw8l+zeXHdvAR3cB410lblGzFPIANFGXV6wRwIt
         Umug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6yIH7MQsLl6LEDg45qMcCaM1O7Ac9+38QvTCM2uDf8=;
        b=fzIjg8+YIAxvfllVNchHmdHaMR7h1hPidA7NZDhjXeJT+LUfltRzKBPiMNN4diREcg
         LoNUs12YD6ZF3dYtNj0CUdk7g5FKgrEwHTcd6i8NwCSOcpxxfh8zzTXEv/oK9Mr4E297
         uaZgYXGf0AiA5nb8kcKL4iwt3/e8lp2QQ3DV83g5+Eq/WPCMYninEmlJlXGtO/zryc/T
         hUXw+5TJq9liufoqY+WZ3qDbRY/J59pS5wRvjd6KmoXwZWAaQxz96dj97NEejr+gmrQR
         xLUcP5ykQ4VtX/dF2swXK8QY406w6baxfVtf/zk0pfhtVBpkl9T2ChadAddGuq5iOBlO
         zGpQ==
X-Gm-Message-State: ANoB5pkqBwPjFW9UBd7qymF/+ZVBM179mp1u4dR90Ot4GbtuHNGM9XgN
        XDRm5N2sl6xeRuRFy2uHrQw=
X-Google-Smtp-Source: AA0mqf4d5IQSOBJ9Ni0MEoRNMSWD+64Rc76CRZsIYhnAvwhxPMDlcM2aP0chtpUg5uAQlMVvSiY1gg==
X-Received: by 2002:a05:6402:4497:b0:46c:cff8:207d with SMTP id er23-20020a056402449700b0046ccff8207dmr6948354edb.370.1670345093607;
        Tue, 06 Dec 2022 08:44:53 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7cdc9000000b0046b471596e6sm1175775edw.57.2022.12.06.08.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:44:53 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:44:51 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
        Jon Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vidyas@nvidia.com,
        mmaddireddy@nvidia.com
Subject: Re: [PATCH V3 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Message-ID: <Y49xg7wptRweHd4I@orome>
References: <20221114155333.234496-1-jonathanh@nvidia.com>
 <20221114155333.234496-2-jonathanh@nvidia.com>
 <Y3ap1o2SbNvFw8Vd@orome>
 <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="goj6zW39Iopsic0N"
Content-Disposition: inline
In-Reply-To: <CAL_JsqKpyn=mWXv4tuS4U8AahNPkL6hpNQCfyRdf9bDY1EqSJg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--goj6zW39Iopsic0N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 05:41:55PM -0600, Rob Herring wrote:
> On Thu, Nov 17, 2022 at 3:38 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Mon, Nov 14, 2022 at 03:53:32PM +0000, Jon Hunter wrote:
> > > From: Vidya Sagar <vidyas@nvidia.com>
> > >
> > > Add support for ECAM aperture that is only supported for Tegra234
> > > devices.
> > >
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > Co-developed-by: Jon Hunter <jonathanh@nvidia.com>
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > > Changes since V2:
> > > - Avoid duplication of reg items and reg-names
> > > Changes since V1:
> > > - Restricted the ECAM aperture to only Tegra234 devices that support =
it.
> > >
> > >  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 34 +++++++++++++++++=
--
> > >  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
> > >  2 files changed, 33 insertions(+), 3 deletions(-)
> >
> > Both patches applied now.
>=20
> linux-next now fails with this. I suspect it is due to Sergey's
> changes to the DWC schema.
>=20
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,=
tegra194-pcie.example.dtb:
> pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> fixed:
>         'dbi' was expected
>         'dbi2' was expected
>         'ecam' is not one of ['elbi', 'app']
>         'atu' was expected
>         'dma' was expected
>         'phy' was expected
>         'config' was expected
>         /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci=
/nvidia,tegra194-pcie.example.dtb:
> pcie@14160000: reg-names:4: 'oneOf' conditional failed, one must be
> fixed:
>                 'ecam' is not one of ['apb', 'mgmt', 'link', 'ulreg', 'ap=
pl']
>                 'ecam' is not one of ['atu_dma']
>                 'ecam' is not one of ['smu', 'mpu']
>         From schema:
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/pci/nvidia,=
tegra194-pcie.yaml

Stephen reported the other day that he wasn't able to resolve this
conflict in linux-next, so he dropped the ECAM bits. The ECAM patch has
now propagated to ARM SoC so it can't be easily backed out, but I guess
we could revert on that tree and instead apply the patch to the DT tree
and resolve the conflict there.

I guess the better alternative would be to try and resolve the merge
properly and let Stephen (and Linus) know.

Thierry

--goj6zW39Iopsic0N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOPcYMACgkQ3SOs138+
s6GSZxAAqiSCEN4r5z2mlNa1HQ5oRefamRktZeZ/5G/9jm+QEkzo0EGf25gDuDpK
wZtdV9hIVozGV9NIFUGo8STYFvxRmLRqKqP3kDwQHSU1IIalE2eXUFabG1x/l53/
8KKeT+/YbQt+mU2+7/Pzb64TmQfgjeKUmgU7kTKiv9qj71BXqXf2ol4cV5nZeDob
EcZEc87/s26bMjLnCZXAgig6F1glrP1JQaiE22ZUMZ252LZlRCJ+yViawBefOPCs
OPx/n1RIHyUCQrgTtANMCWnbMmAwp87mJEd4W58b/0si979zqBPjHhpDZpjA/3TB
WWcYeRQyh+THN1+joqZNRXCn5RkQxteyR9KOKkGmHbYCKe1z06WVd9IUJjErvlEL
u8rlb8ytz3gsiit7eRbOm6+3aqntU6APwlT1nWVnT+X7US898sFf5fox8vSfGXao
dBwQyN0tpCUVezvQjYv057XkfVCYLj5d2qrJoB+V4PTxWvH/OsZgSQ3AXeXN3c1i
xViWc7DiUNOBUzhyK4aOY6/IexiMW6E0Qn+vch2YNPFByjPsEikDyiXoN2o1BLmZ
r05xl+8Yb4mG91y1k7MpXoBZoc9Cgy0kEnct0nMo8QUU+Byp8Kv9Rlhbontw8iJL
y78KEbQYkfbKJHlvr6hPKU3l2LgKb8Ebohi/J9Pe1B3JYsSD+DY=
=81y3
-----END PGP SIGNATURE-----

--goj6zW39Iopsic0N--
