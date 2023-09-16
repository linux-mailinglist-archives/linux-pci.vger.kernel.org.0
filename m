Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC2A7A2B31
	for <lists+linux-pci@lfdr.de>; Sat, 16 Sep 2023 02:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjIPAKE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 20:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjIPAJr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 20:09:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E343298;
        Fri, 15 Sep 2023 17:09:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33CAC433C7;
        Sat, 16 Sep 2023 00:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694822982;
        bh=ZoBnjs9K4t4sU4nW2jM9PguihlFyIuTEMrrHlL6xBtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hd4xkszN0ncBWhPDIpdiCbg7cwGlpAbnnO38MkwjYvJNh8njdZFfhVqIZ3MHWV9ps
         aeLJIenGm5ALpHps7UHEE/IRLd0AUN8vH9FA6YPtW9RcA2t/6IstNGonupkyOJiDFh
         Dud7rTH82mbaepl4hqsIivECBYQyxwDxgZoqgEe1I8vJw+SdYoH2SDOjfRIZWPPMB9
         9RnNFGRB/sCkiWCfcP7C7W7X5IZIApqV10DnMCIy4pMNpDfwayiafeyQItGtu3/WmF
         3G24RPecrOhcoevOAGYaFw+6NkVCLrvjKkjcixTlbK/0kwlpQR9pD67uMAOaF3/GkQ
         iNHKIBHXwidag==
Date:   Sat, 16 Sep 2023 01:09:36 +0100
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v6 02/19] PCI: microchip: Move pcie-microchip-host.c to
 plda directory
Message-ID: <20230916-outcome-obedient-fda7043bcca7@spud>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
 <20230915102243.59775-3-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+qLWHmCvTp7PqhnE"
Content-Disposition: inline
In-Reply-To: <20230915102243.59775-3-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+qLWHmCvTp7PqhnE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 06:22:26PM +0800, Minda Chen wrote:
> For Microchip Polarfire PCIe host is PLDA XpressRich IP,
> move to plda directory. Prepare for refactor the codes.
>=20
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  MAINTAINERS                                        |  2 +-
>  drivers/pci/controller/Kconfig                     |  9 +--------
>  drivers/pci/controller/Makefile                    |  2 +-
>  drivers/pci/controller/plda/Kconfig                | 14 ++++++++++++++
>  drivers/pci/controller/plda/Makefile               |  2 ++
>  .../controller/{ =3D> plda}/pcie-microchip-host.c    |  2 +-
>  6 files changed, 20 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/pci/controller/plda/Kconfig
>  create mode 100644 drivers/pci/controller/plda/Makefile
>  rename drivers/pci/controller/{ =3D> plda}/pcie-microchip-host.c (99%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..b1050804e6d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16647,7 +16647,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/microchip*
> -F:	drivers/pci/controller/*microchip*
> +F:	drivers/pci/controller/plda/*microchip*

The riscv patchwork automation is complaining that you have added
maintainers pattern errors with this patch. If you run
=2E/scripts/get_maintainer.pl --self-test=3Dpatterns
it'll tell you what the bad pattern is. Not sure why I never actually
dumped the output of that test into the failure report, so I can't
immediately tell you what is wrong.

--+qLWHmCvTp7PqhnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQTyQAAKCRB4tDGHoIJi
0lw1AQDzd1Qn+mtJ1Bjy/O6gztN51A8g7jbDXInA6DY6wknZcgEAq7WU6P4FmYOm
0Q5J/MB4RAOAgpV7Ji9Qd9wkqGV22g0=
=cAFa
-----END PGP SIGNATURE-----

--+qLWHmCvTp7PqhnE--
