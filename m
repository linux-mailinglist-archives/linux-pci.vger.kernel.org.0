Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF536DA025
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240003AbjDFSpd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDFSpd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5B7A83;
        Thu,  6 Apr 2023 11:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E0E64B0D;
        Thu,  6 Apr 2023 18:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D8C433D2;
        Thu,  6 Apr 2023 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806731;
        bh=I5+cukk26vnLknbH5Toe4jO9okYIGo7RP4YmHcNkaVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9p3nfCRGWjjafHcbkGxdjjfrJ/XwY5BSS1v2JPwbZTBExPM6Ym+NfoUZNCk+mDH1
         16RHTeUK9Szul8wUxrg+NrTUI0WvC+68BBY3yQr1Ohqy9hEYNtv4dYHkZeBKYvMNjf
         a97PBeMkS57Li+WuERNAC7RW8wwYqjGaiIKij3APDrmEDhFHqmDjkOVAPAIo6bkixi
         J6L557T5ieTmTczrqofZisYF4s2Imz4WlS+YzJkVFs9QsSH6vZsliA9E8BH4i6b5kk
         +gSjAP3R8oR/Kiu4S58wmjqvnoK2wYgm+JY271OU+IzRmhdo4Ph4sob0JRaQDNOQ4o
         SYnCmyHm1OTvQ==
Date:   Thu, 6 Apr 2023 19:45:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding
 documents.
Message-ID: <20230406-cinema-profile-1bfed00e4a5f@spud>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406111142.74410-2-minda.chen@starfivetech.com>
 <38bc48bf-7d8c-8ddd-861f-3b7f3d2edce6@linaro.org>
 <20230406-revisit-patchy-a0063d964070@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FH4TbyZ5TRJ4YHod"
Content-Disposition: inline
In-Reply-To: <20230406-revisit-patchy-a0063d964070@spud>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--FH4TbyZ5TRJ4YHod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2023 at 07:35:09PM +0100, Conor Dooley wrote:
> On Thu, Apr 06, 2023 at 08:24:55PM +0200, Krzysztof Kozlowski wrote:
> > On 06/04/2023 13:11, Minda Chen wrote:
> > > +
> > > +  interrupt-controller:
> > > +    type: object
> > > +    properties:
> > > +      '#address-cells':
> > > +        const: 0
> > > +
> > > +      '#interrupt-cells':
> > > +        const: 1
> > > +
> > > +      interrupt-controller: true
> > > +
> > > +    required:
> > > +      - '#address-cells'
> > > +      - '#interrupt-cells'
> > > +      - interrupt-controller
> > > +
> > > +    additionalProperties: false
> > > +
> > > +required:
> > > +  - reg
> > > +  - reg-names
> > > +  - "#interrupt-cells"
> >=20
> > Keep consistent quotes - either ' or "
> >=20
> > Are you sure this is correct? You have interrupt controller as child no=
de.
>=20
> I know existing stuff in-tree is far from a guarantee that it'll be
> right, but this does at least follow what we've got for PolarFire SoC:
> Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
>=20
> Both PLDA and both RISC-V w/ a PLIC as the interrupt controller, so in
> similar waters.
> This note existed in the original text form binding of the Microchip
> PCI controller:
> | +NOTE:
> | +The core provides a single interrupt for both INTx/MSI messages. So,
> | +create an interrupt controller node to support 'interrupt-map' DT
> | +functionality.  The driver will create an IRQ domain for this map, dec=
ode
> | +the four INTx interrupts in ISR and route them to this domain.
>=20
> Given the similarities, I figure the same requirement applies here too.
> Minda?

Further, if, as I currently suspect, there's a lot of commonality here,
should the binding as well as the driver be split into common pdla bits
and microchip/starfive specific ones?

Suppose that's more one for you Krzysztof.

Cheers,
Conor.

--FH4TbyZ5TRJ4YHod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZC8TRAAKCRB4tDGHoIJi
0o4HAP9oLXQVzVevvdCu75mB7hfMBZwV2TEh1L+UnBh9GRsElQD+MKt9L6Sie3wm
Dso18O653hpA0FUvjJEZeW9HslxzfQI=
=o1Sq
-----END PGP SIGNATURE-----

--FH4TbyZ5TRJ4YHod--
