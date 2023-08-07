Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F1B771BC0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 09:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjHGHqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 03:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGHqA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 03:46:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8AFB5;
        Mon,  7 Aug 2023 00:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE3B615E2;
        Mon,  7 Aug 2023 07:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC3FC433C7;
        Mon,  7 Aug 2023 07:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691394358;
        bh=qsp1Oxg2WXRgJ943p0ma6lIVdbOsynz/TYJEUIi8Ti4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUvf0/T8ZE27GCIGnr/nt2VVPv+T0SeS6ntnxRwc5Z0CkvrBWv3yMwd4oyaVV42Cd
         R32nDU4qRUq0Oven3FraG47pCP5GeHhXMTOzTDUFpf+/eIGUFuDUlT86Qwyjh8hp77
         Jng143a2lG5FOuvRiuDZfLqtKgqCWUiMLwc3QIPbdwPAByYifBwsSBsEhi/yBS5lZB
         y02iEkWgVr/7xC2YQaCfLj6Nx/01dYRzcfsYthbYak9vBgLoLm0BKGaqBJvosHBr1U
         SptHRszWD+UFyV6NIBksU43Mq8gNqzl0lwuUydHQUKMgEEuDEbbjTllvAuL+D2kTqs
         M97hWJbvdo7WA==
Date:   Mon, 7 Aug 2023 08:45:52 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add StarFive JH7110 PCIe
 controller
Message-ID: <20230807-financial-strategic-e691db948011@spud>
References: <20230727103949.26149-1-minda.chen@starfivetech.com>
 <20230727103949.26149-4-minda.chen@starfivetech.com>
 <20230804-irregular-distrust-c5d46afe3d9c@wendy>
 <6c1a4b77-996e-9274-bece-84fe42d6099a@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3RDzNovR7DNXD9yQ"
Content-Disposition: inline
In-Reply-To: <6c1a4b77-996e-9274-bece-84fe42d6099a@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--3RDzNovR7DNXD9yQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 02:54:50PM +0800, Minda Chen wrote:
> On 2023/8/4 15:10, Conor Dooley wrote:
> > On Thu, Jul 27, 2023 at 06:39:48PM +0800, Minda Chen wrote:
> >> +  starfive,stg-syscon:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    items:
> >> +      - items:
> >> +          - description: phandle to System Register Controller stg_sy=
scon node.
> >> +          - description: register0 offset of STG_SYSCONSAIF__SYSCFG r=
egister for PCIe.
> >> +          - description: register1 offset of STG_SYSCONSAIF__SYSCFG r=
egister for PCIe.
> >> +          - description: register2 offset of STG_SYSCONSAIF__SYSCFG r=
egister for PCIe.
> >> +          - description: register3 offset of STG_SYSCONSAIF__SYSCFG r=
egister for PCIe.
> >> +    description:
> >> +      The phandle to System Register Controller syscon node and the o=
ffset
> >> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters=
 offset
> >> +      for PCIe.
> >=20
> > These property names tie them closely with naming on the jh7110, but
> > there's little value in specifying all of these offsets when you have
> > one implementation where they are all fixed.
> Yes, the offset value is tied to SoC.=20
> > Do you know what the jh81xx stuff is going to do yet w.r.t. PCI and if
> > so, how could you reuse this property?
> I do not participate in jh8100. But I heard sys-syscon is exist in 81xx.
> But I think stg-syscon and sys-syscon  can be move to a common dt-binding=
 doc.
> Bot 71x0 and 81x0 driver can use this.=20
> > Particularly, saying "register 0" seems unlikely to transfer well
> > between SoCs.
> > I'd be inclined to drop the offsets entirely & rely on match data to
> > provide them if needed in the future.
> That's ok. The dts can change to starfive,stg-syscon =3D <&stg_syscon>;
> I will try to move the offset to driver match data.

To be clear, you don't need match data now, only when the jh8100 stuff
shows up. Until then the values can be hard coded in the driver as there
is only one device it works for.

Thanks,
Conor.

--3RDzNovR7DNXD9yQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNChKQAKCRB4tDGHoIJi
0oJtAP9DsbfNbx9S7vnxHBnWs4BuGLy0YOzbgKrrD5l+muVWFAD+K9R7IhMsVt3X
8KNtKqBBMWQC8ARlBYqLpGpGbSgBPA4=
=REYK
-----END PGP SIGNATURE-----

--3RDzNovR7DNXD9yQ--
