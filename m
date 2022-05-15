Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE60527757
	for <lists+linux-pci@lfdr.de>; Sun, 15 May 2022 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236569AbiEOLuZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 May 2022 07:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEOLuY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 May 2022 07:50:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3515FD5;
        Sun, 15 May 2022 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652615387;
        bh=B54b8i/DJeeMKAG6eeLRs8Eg71xNxoV1yns596upSxo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KZU3p+Wx1KBt/Lqv9OJbTi7Ehf3YdK1vP//M3q2xGBD0rekA1/r7t0037nVPPzgqg
         OpkXodRp8QArExZJmHXpP23WW0wvJ5GXzn3lyWvJpZxQyvdjj+3LRFsCL9Q+D7O3Kb
         bdSOJCr/Z0EaBW8OrHyet4TzApAZHrjf9oG9M6go=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.155.220] ([217.61.155.220]) by web-mail.gmx.net
 (3c-app-gmx-bap15.server.lan [172.19.172.85]) (via HTTP); Sun, 15 May 2022
 13:49:47 +0200
MIME-Version: 1.0
Message-ID: <trinity-02ad648c-f6f8-4383-b389-a0578d5a02d2-1652615387162@3c-app-gmx-bap15>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Vinod Koul <vkoul@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Subject: Aw: Re: [RFC v3 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 15 May 2022 13:49:47 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
References: <20220514115946.8858-1-linux@fw-web.de>
 <20220514115946.8858-2-linux@fw-web.de>
 <1652570081.002742.3276245.nullmailer@robh.at.kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:vyz+cZ1FBTfjDhfQEhv1JzESF6L56qiBrPOQZS9cHKD6f4k7h++sUqzAQ7FmgPedf81JC
 U48uvEu/vudC4ZpfT/fIWI9vVoLc8tNndbfZsqX0t7UFqMM00+4CSKXxw2aARFB+ZM2nBFucDWCt
 jm125jW3y59zpsu1G3UIRZWmMwTOzvONPEjvyTvOwLuHceoIsVsOxzZZEXsq1BgNyzcvRhugBlZt
 AJJ87wLTUxaLMgyFoRqkwSdJUddjxr3JGhC2Sh1cgKGXyS918z8pOFI8yYFaIr48XVG7rG67/uDg
 Uc=
X-UI-Out-Filterresults: notjunk:1;V03:K0:S/t/BYr4iXI=:8wqNb/mB9PaXLXn1njkTeV
 hOHvGGfN3VE+cgjjRhr1zCt4qjbvjx1NmiPGQQYA28B5Z9ftYVAmN7zvzVa9t2M18+t8SIkRc
 EIvVnlSitX6gs5p443xj8JynkKVYTYFAKKO2zv9J70EkEiGQIkXIpMjrlNtRt4jm7xsDprNEV
 diKQwQrcGed0x09qWJ8Mlvc2zPk9ECCCdBtT+8EPE0eHu7GO2OdALNoe+YrpSP2Nt0e/rpkwD
 77lapCoazyx4Ee5jjTQ9HZCQBq8/hah+QiDNd6y/ShkOS+cl/DAbQNr0G8liqWE/TKEwY1PWL
 7TTQjRViOUHYkpXhHAQFZd73CCAslqZ6dyGssEI5ERtsmEjsLGkmh2P8zDBNWunETwUN28M/j
 HvirtANDkBFM3Ybm6HImIb7CU6CQ/fZ2TKHYrDMPqqPqA7SqTMWmXArtq1uYo9GE4jBGPU3DW
 Cl3ijgnJujsGqc+hfsesetmrCcM6T13jON1scUX1uMNNAciZL5n7kzcOLSw0fm/50eWlE2rf1
 P+rf/7Z2FQ1prZduh0N1rM1rDFKeRGbjlDTpBpniEktom7Jd+qEtNQroC48NkzPktKa5M+vsy
 OSMwYEqBocV/w8MSxZBSCsT5Vbu16h1mHYE0AlIscgWyd89cWtgef3aoJvYz1hITdNYeF0R7X
 AuQgnB729Uw0tVZr04bsAGh7pnUfq0Gi6rtUA++edXIVVlnLte49gpShgrJ5mQWFHGWpvg/7u
 7V38Z4bgTTRHQCFZB38ikUMslJO/bM4BJzgjD6gK4io2xLPml/828389C0YEWkLUoCmotR89J
 ZnC15/y
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

> Gesendet: Sonntag, 15. Mai 2022 um 01:14 Uhr
> Von: "Rob Herring" <robh@kernel.org>

> On Sat, 14 May 2022 13:59:42 +0200, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > Add a new binding file for Rockchip PCIe v3 phy driver.
> >
> > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >
> > ---
> > v3:
> > - drop quotes
> > - drop rk3588
> > - make clockcount fixed to 3
> > - full path for binding header file
> > - drop phy-mode and its header and add lane-map
> >
> > v2:
> > dt-bindings: rename yaml for PCIe v3
> > rockchip-pcie3-phy.yaml =3D> rockchip,pcie3-phy.yaml
> >
> > changes in pcie3 phy yaml
> > - change clock names to ordered const list
> > - extend pcie30-phymode description
> > - add phy-cells to required properties
> > - drop unevaluatedProperties
> > - example with 1 clock each line
> > - use default property instead of text describing it
> > - update license
> > ---
> >  .../bindings/phy/rockchip,pcie3-phy.yaml      | 82 ++++++++++++++++++=
+
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/rockchip,pci=
e3-phy.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check=
'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy=
/rockchip,pcie3-phy.yaml: properties:clock-names: 'oneOf' conditional fail=
ed, one must be fixed:
> 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}] is to=
o long
> 	[{'const': 'refclk_m'}, {'const': 'refclk_n'}, {'const': 'pclk'}] is to=
o short
> 	False schema does not allow 3
> 	1 was expected
> 	3 is greater than the maximum of 2
> 	hint: "minItems" is only needed if less than the "items" list length
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy=
/rockchip,pcie3-phy.yaml: ignoring, error in schema: properties: clock-nam=
es
> Documentation/devicetree/bindings/phy/rockchip,pcie3-phy.example.dtb:0:0=
: /example-0/phy@fe8c0000: failed to match any schema with compatible: ['r=
ockchip,rk3568-pcie3-phy']

seems this is fixed when i remove the "minItems: 3" from clock names (whic=
h is already fixed length because of the list).

needed to change type of lane-map to this:

$ref: /schemas/types.yaml#/definitions/uint8-array

then it looks clean for it....

-m causes many errors unrelated to this schema-file even if i pass
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/phy/rockchip,pcie3-phy=
.yaml

will wait a bit for other comments (for driver) till i send another versio=
n. maybe you can confirm my changes are the right way to fix.

regards Frank
