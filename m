Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCAF759BA8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 18:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjGSQ6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 12:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGSQ6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 12:58:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC054B6;
        Wed, 19 Jul 2023 09:58:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DFC3617A7;
        Wed, 19 Jul 2023 16:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905FDC433C7;
        Wed, 19 Jul 2023 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689785897;
        bh=xayvFZEqNUxkMixHih/sryn5ylVD/sjcMsn7un1bPYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3n9AoZ0SJlV8lgbjP2eg1EfnS7FHT1VfY3AEiWAgaDry/O2UXfoxJvKZ71IIO5QK
         YfAe2oiJ4tLy+CjALsaOLZ49xbzWRDuvvOWIUWz9YDkb2wqqSuFcXzaiLkxssiAu2I
         bFCv/eLHHk3j5eIkHt1rKTSamKndqwGiDZ2Ivgv6bZ1/Hu1VeStmSN56Gj2KDIglNS
         lwt20OvsGEA8vjd7rpi5hSf+esT5XVBtIdLziDxDf0ZwZhLAkNWZ95/urD1Pmx9cM3
         7ndjk4fnh/ZBpNO4o4+OajYlAexmPFOhKAWSR+yenbpGdv7tAF6aBgj/RUMeHe7eJc
         6n1y7UBz5n3Eg==
Date:   Wed, 19 Jul 2023 17:58:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 0/9] Refactoring Microchip PolarFire PCIe driver
Message-ID: <20230719-rockstar-gangway-467e64ada609@spud>
References: <20230719102057.22329-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ItaO0NWrNgH9c6FC"
Content-Disposition: inline
In-Reply-To: <20230719102057.22329-1-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--ItaO0NWrNgH9c6FC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Minda,

On Wed, Jul 19, 2023 at 06:20:48PM +0800, Minda Chen wrote:
> This patchset final purpose is add PCIe driver for StarFive JH7110 SoC.
> JH7110 using PLDA XpressRICH PCIe IP. Microchip PolarFire Using the
> same IP and have commit their codes, which are mixed with PLDA
> controller codes and Microchip platform codes.
>=20
> For re-use the PLDA controller codes, I request refactoring microchip
> codes, move PLDA common codes to PLDA files.
> Desigware and Cadence is good example for refactoring codes.
>=20
> So first step is extract the PLDA common codes from microchip, and
> refactoring the microchip codes.(patch1 - 4)
> Then add the PLDA platform codes. (patch5, 6)
> At last, add Starfive codes. (patch7 - 9)

Thanks for sending this, I'll try to have a look through it tomorrow, or
if not, early next week. As pointed out off-list, the gist of what you
have here looked good to myself and Daire.

> This patchset is base on v6.5-rc1
>=20
> patch1 is add PLDA XpressRICH PCIe host common properties dt-binding
>        docs, most are extracted from microchip,pcie-host.yaml
> patch2 is add plda,xpressrich-pcie-common.yaml(patch1 file) reference
>        and remove the PLDA common properties.
> patch3 is extracting the PLDA common codes from microchip Polarfire PCIe
>        codes. The change list in the commit message.
> patch4 is move microchip driver to PLDA directory and remove the PLDA
>        common codes.
> patch5 is add PLDA Xpressrich platform driver dt-binding doc.
> patch6 is PLDA Xpressrich platform driver.
> patch7 is add StarFive JH7110 PCIe dt-binding doc.
> patch8 is add StarFive JH7110 Soc PCIe platform codes.
> patch9 is StarFive JH7110 device tree configuration.
>=20
> I have noticed that Daire have changed microchip's codes.
> https://patchwork.kernel.org/project/linux-pci/cover/20230630154859.20495=
21-1-daire.mcnamara@microchip.com/

I'll go and ping this, it's been a few weeks with no movement :)

Thanks,
Conor.

--ItaO0NWrNgH9c6FC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLgWIwAKCRB4tDGHoIJi
0tRJAQCQfXnUkEmh0PtotZgcZuTK2jJ5Pb7zCTWIdxVjSTdhfQD+LoI9+2N9Qein
q+pkZ3wrnXopGLOVdsu5a4hvcELWqQ8=
=fTL5
-----END PGP SIGNATURE-----

--ItaO0NWrNgH9c6FC--
