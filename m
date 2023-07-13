Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597F752902
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 18:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbjGMQsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 12:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjGMQr7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 12:47:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7711FC0;
        Thu, 13 Jul 2023 09:47:57 -0700 (PDT)
Received: from mercury (dyndsl-091-248-214-236.ewe-ip-backbone.de [91.248.214.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAA2B660704D;
        Thu, 13 Jul 2023 17:47:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689266876;
        bh=T1DldDxd/VYxvNs+hY6v3IUSYY7RN3OeiFnGaaIDCok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4xh9h4iGsYttQS2WeFxbjoeCeRuiiWQdSCXByHuZnRKKfsC7UG+3BdleFigjfthD
         QDLXnAQ900Zc05YlEkmKJ9hkf+4Sbzlx+cqrKxb8MA+G6PewQPNd3Vp2M1lGKkWWiL
         lwl+jNTEH0T4EDjWnrpZBO8s2kcF16FKAP8p63ygp2BaC/bdbZSr93kF8syWRBqflt
         ZfR38Kkkw/am4Aog833x5f3bqfxpAwQaNsaqPeAZpgq5eBo/7efEhFLg4X4nLtYLK9
         E2ru+brQcOtInpwuO/safLEMU93zy/vjS4QwcK0PXhHq8VdyBejgjgVMPHbEPiXeC/
         CPfrpdsq3bLag==
Received: by mercury (Postfix, from userid 1000)
        id 4724B10676F1; Thu, 13 Jul 2023 18:47:53 +0200 (CEST)
Date:   Thu, 13 Jul 2023 18:47:53 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <20230713164753.3dmxxejcr7litocl@mercury.elektranox.org>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-2-sebastian.reichel@collabora.com>
 <n5vgfnqicq3ndgqtcp3yjurbdn76vucj6zyjhlpjbdwoquv2la@5g5kv5gceyd7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7h2ag4owtu6nzfbp"
Content-Disposition: inline
In-Reply-To: <n5vgfnqicq3ndgqtcp3yjurbdn76vucj6zyjhlpjbdwoquv2la@5g5kv5gceyd7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--7h2ag4owtu6nzfbp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Sorry for the delayed response.

On Tue, Jun 27, 2023 at 03:27:33PM +0300, Serge Semin wrote:
> On Fri, Jun 16, 2023 at 07:00:19PM +0200, Sebastian Reichel wrote:
> > The RK356x (and RK3588) have 5 ganged interrupts. For example the
> > "legacy" interrupt combines "inta/intb/intc/intd" with a register
> > providing the details.
> >=20
> > Currently the binding is not specifying these interrupts resulting
> > in a bunch of errors for all rk356x boards using PCIe.
> >=20
> > Fix this by specifying the interrupts and add them to the example
> > to prevent regressions.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml  | 15 ++++++++++++++-
> >  2 files changed, 32 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yam=
l b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index 24c88942e59e..98e45d2d8dfe 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -56,6 +56,17 @@ properties:
> >        - const: pclk
> >        - const: aux
> > =20
> > +  interrupts:
> > +    maxItems: 5
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: sys
> > +      - const: pmc
> > +      - const: msg
> > +      - const: legacy
> > +      - const: err
> > +
> >    msi-map: true
> > =20
> >    num-lanes: true
> > @@ -98,6 +109,7 @@ unevaluatedProperties: false
> > =20
> >  examples:
> >    - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > =20
> >      bus {
> >          #address-cells =3D <2>;
> > @@ -117,6 +129,12 @@ examples:
> >                            "aclk_dbi", "pclk",
> >                            "aux";
> >              device_type =3D "pci";
> > +            interrupts =3D <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "sys", "pmc", "msg", "legacy", "err";
> >              linux,pci-domain =3D <2>;
> >              max-link-speed =3D <2>;
> >              msi-map =3D <0x2000 &its 0x2000 0x1000>;
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/=
Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > index 1a83f0f65f19..9f605eb297f5 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -193,9 +193,22 @@ properties:
> >            oneOf:
> >              - description: See native "app" IRQ for details
> >                enum: [ intr ]
>=20
> The IRQs below are either combined version of the already defined IRQs
> or just the generic DW PCIe IRQs but named differently. Moreover I
> don't see kernel using any of them except the "legacy" interrupt. What
> about converting the dts files to using the already defined names instead
> of extending the already over-diverged DT-bindings?
> Rob, Krzysztof?
>
> In anyway in order to prevent from defining the new DW PCIe bindings
> compatible with your vendor-specific names please move the aliases to
> being under the last entry of the "interrupt-names" items property.
> (See the "intr" IRQ name for example or the way the vendor-specific
> names are defined in the reg-names property.)

All of these are combined interrupts and not simple aliases.
Otherwise I would just have changed the name for RK3588. Rockchip
has a two level interrupt system. I re-checked carefully and as far
as I can tell all interrupts currently defined in the binding have a
specific meaning. This is not the case for the interrupts from
RK3588. I will send a new version in a jiffy, which describes all
the sub-IRQs available beneath the newly described ones. I don't have
the Synopsys datasheet, so I will stick to the names used by Rockchip.

> > +        - description: Combined Legacy A/B/C/D interrupt signal.
> > +          const: legacy
>=20
> This is a combined signal of "^int(a|b|c|d)$". So the entry
> is supposed to look:
> +              - description: See native "int*" IRQ for details
> +                const: legacy

In case my explanation from above was not clear: All the other
interrupts follow the same style as this one.

> > +        - description: Combined System interrupt signal.
> > +          const: sys
>=20
> This seems like the "app" interrupt. So please either convert the dts
> file to using the "app" name or move this to being defined in the same
> entry as the "intr" name.

I suppose "sys", "pmc", "msg" and "err" all fit for "app", since
they are vendor specific with the extra layer? But obviously I
cannot specify "app" more than once.

> > +        - description: Combined Power Management interrupt signal.
> > +          const: pmc
>=20
> This is an alias to the already defined "pme" name. So either convert
> the dts file to using "pme" or move this to being in the
> vendor-specific list of the "interrupt-names" property:
> +              - description: See native "pme" IRQ for details
> +                const: pmc

pme should be 'msg -> pm_pme_int':

Interrupt indicates that the controller received a PM_PME message.

> > +        - description: Combined Message Received interrupt signal.
> > +          const: msg
>=20
> ditto but with respect to the "msi" name.

MSI is handled via GIC-ITS using this DT property:

msi-map =3D <0x3000 &its0 0x3000 0x1000>;

> > +        - description: Combined Error interrupt signal.
> > +          const: err
>=20
> ditto but with respect to the "sft_*" name.

I really meant it, when I wrote "Combined". Appart from
(un)correctable errors this also reports e.g. timeouts.

> > +
> >      allOf:
> >        - contains:
> > -          const: msi
> > +          enum:
> > +            - msi
> > +            - msg
>=20
> * Please see my suggestion about converting the DTS file instead.

My understanding is, that "msi" and "msg" are not the same. MSI is
an interrupt message from a peripheral device, but "msg" is a
combined interrupt for all kind of messages.

-- Sebastian

--7h2ag4owtu6nzfbp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSwKq0ACgkQ2O7X88g7
+prrnQ/9F90iKRKByTa4g2Sy8b2eIKup95CsYZPapKiXewEdCzTvM+WMgYS6ns1j
ZihjJpWsvXhxv7gqefTjNJZmQ4zqb8iPGGoGMbAnNawjkawExkXiu7vgKw7ehNgL
PxuFXPRcq8pfbZuBIpCEEEp76suq3oNKbJT/cG8sC2plp5iTuqNT+PweB6hL5Moh
/3Htze/iJcEeWO1dyNKjzK6vC3zAtbixFJs5vkPsTcRUoHbXoOk9UdRlyUCpJM/g
90UkX4KapCTenmAoXBbUW7L4uBvKhIDc/0PbuyKHMmVOjhUHbciKHT3b8DM/dmAk
dqE7lXgO0C+x/Yl4Ca3RV4nNeVuhxTFWAgk69vm1DTUQkdVdyzyeQcqYkZluwMGT
QeD/rlncgncTKdBoWilFajRwmy5GHrrHWxAKldSxKU/QQORRK/ICyRy/F+bo1dKG
/whLMYZg5/SVQetOaS43cRjZvedSytUCl4m6GhClFydmue8w/NJoHsA9Z7zmGAhA
HyHRXxnuwHDvCqagVpJLQ6BCYpkZ6aRgZj2pbrrxCQd05uk6cXtp6r89zIHHv2HF
Z0LjOu2VGWcBRfyp2qpaIujALehowXvqPw41+fI5BW2kvWR+DP2NS2e/MKlnWXVs
9IOmKB0Cxa2QWxz9TUBfybL8fDRK93nbgPhi8R7Dh/+hs7grRes=
=eQPk
-----END PGP SIGNATURE-----

--7h2ag4owtu6nzfbp--
