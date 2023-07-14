Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9238D754512
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jul 2023 00:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGNWov (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGNWou (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 18:44:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F0330FC;
        Fri, 14 Jul 2023 15:44:48 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 070B06607052;
        Fri, 14 Jul 2023 23:44:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689374687;
        bh=7ghw3wFdwG9ZS0uRP5o+4t4YQEMF/+LyfEhcYyHexLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UghWBSS4AghhCAkrizBIGkCQ82l+4pzrBtIGCgqN/RddjPYQ2y95L1NPCYUD3SbI/
         R96nfWBDARm136wOnATFQt3dQn7DbXC9voWHVDeuy8gXGNJM2XgyFJBoInkHGncFzd
         gazA/cZIB5+wq9z5oTk8lYLVDeXSUcf/I0LM4xVIWaK5zisslCXuKBOxuaG3KLHXPi
         A1RHOQ/XtlhCi1nBG4js3+p/qZdpTITDr+2PKVCj+HRFDqi8zoB+B66TUGbnIrza1/
         EYmYu0gfyVcD7A9PGj0LfYf7WwVfa+G3CEX8vydwQO9pM1SYoJhBuNOS83Mpk33u9k
         /ceLSVgw70v6w==
Received: by mercury (Postfix, from userid 1000)
        id 5B093106764F; Sat, 15 Jul 2023 00:44:44 +0200 (CEST)
Date:   Sat, 15 Jul 2023 00:44:44 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <20230714224444.oymtxdzugkxrgu2q@mercury.elektranox.org>
References: <20230713171851.73052-1-sebastian.reichel@collabora.com>
 <20230713171851.73052-2-sebastian.reichel@collabora.com>
 <mikpjlkg65ubb75jrcrbiomzq6npte5iheuoexgrtu4kqej5do@qbwcbcgorg3k>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lyhrqazzzueipbqx"
Content-Disposition: inline
In-Reply-To: <mikpjlkg65ubb75jrcrbiomzq6npte5iheuoexgrtu4kqej5do@qbwcbcgorg3k>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--lyhrqazzzueipbqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Serge,

On Fri, Jul 14, 2023 at 08:25:52PM +0300, Serge Semin wrote:
> On Thu, Jul 13, 2023 at 07:18:49PM +0200, Sebastian Reichel wrote:
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
> >  .../bindings/pci/rockchip-dw-pcie.yaml        | 18 +++++
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 76 ++++++++++++++++++-
> >  2 files changed, 93 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yam=
l b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > index a4f61ced5e88..aad53c7d8485 100644
> > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > @@ -60,6 +60,17 @@ properties:
> >        - const: aux
> >        - const: pipe
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
> > @@ -108,6 +119,7 @@ unevaluatedProperties: false
> > =20
> >  examples:
> >    - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > =20
> >      bus {
> >          #address-cells =3D <2>;
> > @@ -127,6 +139,12 @@ examples:
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
> > index 1a83f0f65f19..973bf8f2730d 100644
> > --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > @@ -193,9 +193,83 @@ properties:
> >            oneOf:
> >              - description: See native "app" IRQ for details
> >                enum: [ intr ]
> > +        - description:
> > +            Combined legacy interrupt, which is used to signal the fol=
lowing
> > +            interrupts
> > +              * inta
> > +              * intb
> > +              * intc
> > +              * intd
> > +          const: legacy
> > +        - description:
> > +            Combined system interrupt, which is used to signal the fol=
lowing
> > +            interrupts
> > +              * phy_link_up
> > +              * dll_link_up
> > +              * link_req_rst_not
> > +              * hp_pme
> > +              * hp
> > +              * hp_msi
> > +              * link_auto_bw
> > +              * link_auto_bw_msi
> > +              * bw_mgt
> > +              * bw_mgt_msi
> > +              * edma_wr
> > +              * edma_rd
> > +              * dpa_sub_upd
> > +              * rbar_update
> > +              * link_eq_req
> > +              * ep_elbi_app
> > +          const: sys
> > +        - description:
> > +            Combined PM interrupt, which is used to signal the followi=
ng
> > +            interrupts
> > +              * linkst_in_l1sub
> > +              * linkst_in_l1
> > +              * linkst_in_l2
> > +              * linkst_in_l0s
> > +              * linkst_out_l1sub
> > +              * linkst_out_l1
> > +              * linkst_out_l2
> > +              * linkst_out_l0s
> > +              * pm_dstate_update
> > +          const: pmc
> > +        - description:
> > +            Combined message interrupt, which is used to signal the fo=
llowing
> > +            interrupts
> > +              * ven_msg
> > +              * unlock_msg
> > +              * ltr_msg
> > +              * cfg_pme
> > +              * cfg_pme_msi
> > +              * pm_pme
> > +              * pm_to_ack
> > +              * pm_turnoff
>=20
> > +              * obff_idle
> > +              * obff_obff
> > +              * obff_cpu_active
>=20
> These are marked is "inputs" (from the DW PCIe controller point of
> view) in the HW manual. Are you sure they are supposed to generate any
> IRQ? Based on the DW PCIe HW-manual they are supposed to be set by the
> _application_ (a.k.a your driver or vendor-specific RTL block) as a
> request to the DW PCIe controller to emit an OBFF message. There is a
> signal marked as "output" and named as "app_obff_msg_grant" which most
> likely is relevant here.

I do not have the Synopsys HW manual, but RK3588 TRM has these:

obff_idle_int - controller received an 'IDLE' OBFF message.
obff_obff_int - controller received an 'OBFF' OBFF message.
obff_cpu_active_int - controller received an 'CPU Active' OBFF message.

> > +          const: msg
> > +        - description:
> > +            Combined error interrupt, which is used to signal the foll=
owing
> > +            interrupts
> > +              * aer_rc_err
> > +              * aer_rc_err_msi
> > +              * rx_cpl_timeout
> > +              * tx_cpl_timeout
> > +              * cor_err_sent
> > +              * nf_err_sent
> > +              * f_err_sent
> > +              * cor_err_rx
> > +              * nf_err_rx
> > +              * f_err_rx
> > +              * radm_qoverflow
> > +          const: err
>=20
> The most of the signals you cited in the description properties are a
> part of the so called "System Information Interface" defined in the DW
> PCIe databook. Here is what the doc says regarding these signals:
>=20
> "The SII exchanges various system-related information between the
> controller and your application. Most of the SII signals are provided
> for flexibility. Your application is not required to use all of the
> SII signals. Your application logic is expected to drive and monitor
> the signals that it needs to function correctly. SII inputs that your
> application does not require, must be driven to 0."
>=20
> Amongst tons of various informational signals available in the
> framework of SII, there is "SII: Interrupt Signals" which are normally
> utilized by the vendor-specific controller implementations and which
> are defined as generic in this DT-bindings. (MSI IRQ signal is defined
> separately from SII as "MSI Interface Signals".)
>=20
> What is normally expected is that all the generic SII IRQs are
> supplied as the separate signals meanwhile the rest of the SII signals
> are combined in an additional line named like "app".
>=20
> In your case we find an intermix of the SII generic IRQs and some SII
> signals (though some of the names listed in your descriptions don't
> match to what is defined in the DW PCIe HW manual). So what you said
> in v1:
>=20
> On Thu, Jul 13, 2023 at 7:47PM +0200, Sebastian Reichel wrote:
> > I suppose "sys", "pmc", "msg" and "err" all fit for "app", since
> > they are vendor specific with the extra layer? But obviously I
> > cannot specify "app" more than once."
>=20
> is mainly correct. For instance, the most of the generic SII interrupt
> signals are combined in your "sys" IRQ, like "hp", "bw_au", "bw_mg",
> "dma", "l_eq"; your "pmc" and "msg" IRQs are a set of the SII signals
> not listed in the "SII Interrupt Signals" list; the "err" IRQ has the
> "aer" generic SII Interrupt, but the rest of the signals are common SII
> signals.
>=20
> I am not fully certain of what to do in this case. Some possible options:
>=20
> 1. Keep the names defined as is, add them to the list of generic IRQ
> names, describe them as "Combined IRQ signals" but with no specific
> signals listed and with some generic meaningful description.
> Alternatively create a separate sub-schema in the generic
> "interrupt-names" property constraints in the same way as it's done
> for the "vendor-specific IRQ names" and do the same with the names
> descriptions. In anyway move your detailed descriptions to the
> Rockchip DW PCIe DT-schema. In this case we imply that your names
> could be re-used for some other device bindings.
>=20
> 2. Keep the names defined as is, add them to the list of
> "vendor-specific IRQ names" sub-schema in the "interrupt-names"
> property, describe each of them as "Combined IRQ signals" but with no
> specific signals listed and with some generic meaningful description.
> Move your detailed descriptions to the Rockchip DW PCIe DT-schema.
>=20
> 3. Add "app_" prefix to all your IRQs (except "legacy") and convert
> the generic "app" IRQ name constraint to accepting a pattern like
> '^app(_.*)?$' or similar. Move your detailed descriptions to the
> Rockchip DW PCIe DT-schema.
>=20
> 4. Add Rockchip-specific prefix to the names (except "legacy"), add
> all of them (for instance as a pattern-like schema) to the
> vendor-specific IRQ names part of the "interrupt-names" items list
> with a description referring to the Rockchip DT-bindings. Move your
> detailed descriptions to the Rockchip DW PCIe DT-schema.
>=20
> Doubtfully the categorization chosen by the Rockchip HW designers is
> fully universal so the names could be utilized for other devices. Thus
> IMO the options 2-4 might be more preferable over 1.
>=20
> In anyway the detailed descriptions with the listed lines should be
> in the Rockchip DW PCIe DT-bindings since they are definitely
> vendor-specific.
>=20
> Regarding the "legacy" name used as a combined "int(a|b|c|d)" IRQ.
> Alas we can't change it. So it's either option 1 or 2.=20
>=20
> What do you think? Rob, Krzysztof, any better idea?

Adding extra description to the interrupt-names list in the Rockchip
specific binding file does not work:

Additional properties are not allowed ('description' was unexpected)

But I suppose we are fine without them. People working on Rockchip
will easily find them in the TRM.

After looking at it again, my suggestion is to do the following
replacement in the Rockchip specific binding:

allOf:
  - $ref: /schemas/pci/snps,dw-pcie.yaml#

with

allOf:
  - $ref: /schemas/pci/pci-bus.yaml#
  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#

Then the generic binding can stay as is. The Rockchip binding does
not use the "snps,dw-pcie" fallback compatible.

> >      allOf:
> >        - contains:
> > -          const: msi
> > +          enum:
> > +            - msi
> > +            - msg
>=20
> Based on the above the "msg" interrupt doesn't get to be required.
> Rob, is it possible to have a constraint which would require either
> the "msi" IRQ name or the "msi-map" DT-property or both?

I played around a little bit and found this solution: Remove the
above allOf and instead add this to the allOf at the root level:

allOf:
  - if:
      not:
        required:
          - msi-map
    then:
      properties:
        interrupt-names:
         contains:
            const: msi

That might be sensible to do in the generic binding even when
Rockchip is no longer using it. The Rockchip binding has msi-map
in its required list, so it's fine without this.

Greetings,

-- Sebastian

>=20
> -Serge(y)
>=20
> > =20
> >  additionalProperties: true
> > =20
> > --=20
> > 2.40.1
> >=20
>=20
> --=20
> To unsubscribe, send mail to kernel-unsubscribe@lists.collabora.co.uk.

--lyhrqazzzueipbqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSxz9kACgkQ2O7X88g7
+poTaQ//W0gov8odVkl4fzOCkFxHM+XEp1UzFNeDJHwMv6rpDr5kYLG69pDKW6jQ
3DtnKJ5JOSHuvjvQxFaR3Vj0SWzwFPnijwD/o6TNuAW2K4W5VwRyjmq2VlIlLZff
Nfb8lmPQnQ/Seom6QmUQbuSjk4vxBHu897nDH0zQ18IW2RJXdU2O+FKw/IrcBdn8
QFyJfpg/i60R/nOkZO+P/YU57I1XlZyB2pjqT7F+HjOcdmlqOyRDkG8rEAOTnbFV
wqH/gNHl5+gHL6Diyjez1ybq7Kq0zFJ1qJ33PiQsQA0bSNPxGgVGphDj6a8Q05z2
hRevwsFCeIMGJ6KAeJa8gSeK7/JogyXSfNTiXFLXWiEAYqMWeDUxHBf1G577z3en
7kMCC0eOTw4aWM/MTG8ps9enZnfRznvtUGYKPaY/Evz7yEw2wG8U1TfGypC07+no
/oevODbiOkhFieWHEkBqo2q/6aq68vs/GU0OoM9BZ6GCbMGzK5RVBXIlEURQ0Xiu
LCbMjz/6P0nZoUlKndUIno/P5QgyJKv16zeXWWXOh7mECfdomKcjS9z5vTRErHU/
IVIgMinDxyDR1X3aXKyipQv62CJZzWEKVx12f3P4ZVJ0t9DBz6M3aAZK8hHjpWkp
OIvVSEh3dfDKD+zCAdyYlFOrAvgU1tjclMpOkx1huoPLRK6xzgw=
=mfeu
-----END PGP SIGNATURE-----

--lyhrqazzzueipbqx--
