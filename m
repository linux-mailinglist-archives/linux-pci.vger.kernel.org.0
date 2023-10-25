Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15AB7D6874
	for <lists+linux-pci@lfdr.de>; Wed, 25 Oct 2023 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjJYK2X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Oct 2023 06:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJYK2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Oct 2023 06:28:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAB512D;
        Wed, 25 Oct 2023 03:28:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4434C433C8;
        Wed, 25 Oct 2023 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698229697;
        bh=eDN3u4TDJcYx+DdQgle7gIiWglsOEno7mki/bA7iChI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HYi3dilYvxvpeucgQcFZt/105T7co3wqObnpSfk+MdkG6n1Ax+Nglw0FpL/EzTLXr
         fwkO3jO8d8RXPVQed3WVMNI2+ACOa/JE7PFkG7W19F6wiQrPJ9D6V2LpkUsvPGlrep
         lUii0yUazUY8F0nyRZ/c2WQwv2DMrfRoGxw7rMst956WIV8CvPko4YwOQLKcH3YqXu
         hMdZcIi+sFMwQq/sScjpwVX29E0DEuiJzLo2hB5YOcfWKY6VM0ZuLkg5TpXut5ncbo
         uqRHOomTnr8dg9wWfUSrrkX829PueOgyJk6g4jhanNNVG8x2VifYJebgi7URD7czWP
         XReaJl1ihzO8Q==
Date:   Wed, 25 Oct 2023 11:28:11 +0100
From:   Conor Dooley <conor@kernel.org>
To:     John Clark <inindev@gmail.com>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v9 01/20] dt-bindings: PCI: Add PLDA XpressRICH PCIe host
 common properties
Message-ID: <20231025-dotted-almighty-ae489e9eb764@spud>
References: <20231020104341.63157-1-minda.chen@starfivetech.com>
 <20231020104341.63157-2-minda.chen@starfivetech.com>
 <8ced1915-7b94-4abc-bd8b-cb4bf027fa01@linaro.org>
 <bd441e1d-73ae-4abc-8eb2-877419acb2df@starfivetech.com>
 <97e2decd-f6a3-91cb-6ca7-539f53b686f3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hpByJWRUAD7N1Kah"
Content-Disposition: inline
In-Reply-To: <97e2decd-f6a3-91cb-6ca7-539f53b686f3@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--hpByJWRUAD7N1Kah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi John,

On Mon, Oct 23, 2023 at 11:09:50PM -0400, John Clark wrote:
> > On 2023/10/20 19:04, Krzysztof Kozlowski wrote:
> > > On 20/10/2023 12:43, Minda Chen wrote:
> > > > Add PLDA XpressRICH PCIe host common properties dt-binding doc.
> > > > Microchip PolarFire PCIe host using PLDA IP.
> > > > Move common properties from Microchip PolarFire PCIe host
> > > > to PLDA files.
> > > >=20
> > > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > > Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >   .../bindings/pci/microchip,pcie-host.yaml     | 55 +-------------
> > > >   .../pci/plda,xpressrich3-axi-common.yaml      | 75 ++++++++++++++=
+++++
> > > Where was this patch reviewed?
> > >=20
> > > Best regards,
> > > Krzysztof
> > >=20
> > This Conor's review tag. v2 : https://patchwork.kernel.org/project/linu=
x-pci/patch/20230727103949.26149-2-minda.chen@starfivetech.com/
> > This is Rob's review tag v3: https://patchwork.kernel.org/project/linux=
-pci/patch/20230814082016.104181-2-minda.chen@starfivetech.com/
>=20
> Tested-by: John Clark <inindev@gmail.com>:
> https://github.com/inindev/visionfive2/tree/main/kernel/patches

I suspect you don't mean that you tested this individual dt-binding, but
rather that you tested the whole series. If so, you should probably
provide this tested-by against the cover-letter instead of this bindings
patch.

Cheers,
Conor.

--hpByJWRUAD7N1Kah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTjtuwAKCRB4tDGHoIJi
0iNaAQDXojC88wOu7QjVVmLnYZL8zENhy8Oi2Di4/qv5YX44awEA94984Ym3RynW
Zg7JNxtoafH9S4GD3WxSvjcUuQVxQwk=
=pa28
-----END PGP SIGNATURE-----

--hpByJWRUAD7N1Kah--
