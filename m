Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1184529FCE6
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 06:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgJ3FFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 01:05:10 -0400
Received: from mail-eopbgr1410101.outbound.protection.outlook.com ([40.107.141.101]:6109
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725771AbgJ3FFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 01:05:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB1Esa/ag4viLWFyNFWbwwt6GUQHcu8TyDoDWk7kPgDPY44L5oHK8xkvZKwg/MGZmxaI5m5glhlO0N18Z5/ra+1zKIo8/fZ4R2WeFbt4CTu125a4W69uuORrSH3FlYgChTg8Y44Mwn0ohLhY8zBp4bf7fxxzGp2EAx3ENIAl7mzO0vjXHw+Y0SkzdiUFDDISE3vDQ5a2TCgtGi20iZY77kib+G5u6zbvqbOZo69iMabFgtHnKV4TZtPYHO4X31KfO6i5vp91s6rU05TBRxGgy0Ghlgx+Qns6vYGmjg6P9Wc5u3AcGGhvwVm7LbbvbjBncD37SJpYdpf7/4OGs/Pc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0xGTX/83Uj/Uq/QfFuDC4lxmDsvEQj4jknz2eKw/W0=;
 b=DIkwhtf9WdKHg7oBKa2PP2bUKCf14WsLul2C2AYh6hXGzAOuaOIlTunuYr7U/kas9raQg+PcU6V7xeRn9cH/ZrGJR31gOD0IN7ZJ2Wk4Ti/xDGzx01qibwf+QJza0vU4kBtzA5ETL8fW3CePyt9WW83/6RBcQmRnALGZRVwWONHrl7vFwT1fTf0Zvvi3JWJq0CdycX6Y4yn4igv0EtAghJYu9XdOW3u9nNZgYwRwlHEiue7llyOg1YharR/ctkAM5ZdT1A/Xxprqg0bgR2jwjEdOE8sSb6gU7UhPPQSwWfRrQFDLM7d+h3iOyzFzhOznecRnZwF0Gf8F6J54RDYz5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0xGTX/83Uj/Uq/QfFuDC4lxmDsvEQj4jknz2eKw/W0=;
 b=AJLc846+4S8nDjFg/APkw4bag2/E+SNxLjmVlUGt8wmuZgk1kcJk5oRlKVfijDlQuOc6n63AUJ3/RtcQIoI3LBfz/tp78OsjtZbBrg33jLRJQjfwR1D+3BXkU1ivaiLji4/Jnfbb725wks/HCK2BAJGoDAbhBymMzBvITrdr3QU=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TYAPR01MB4080.jpnprd01.prod.outlook.com (2603:1096:404:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Fri, 30 Oct
 2020 05:04:28 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::bcba:dccf:7d4c:c883%4]) with mapi id 15.20.3477.028; Fri, 30 Oct 2020
 05:04:28 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to
 json-schema
Thread-Topic: [PATCH 1/3] dt-bindings: pci: rcar-pci-host: convert bindings to
 json-schema
Thread-Index: AQHWrM7jGTlGJy1Xq0qXxgEFYj7a+6mtGVAAgAKAjLA=
Date:   Fri, 30 Oct 2020 05:04:28 +0000
Message-ID: <TY2PR01MB369244A920BD58906682CC03D8150@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1603850751-32762-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1603850751-32762-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20201028144858.GB3994930@bogus>
In-Reply-To: <20201028144858.GB3994930@bogus>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:1d1:f583:fc3b:d64f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1308c99-c073-4800-d82f-08d87c914777
x-ms-traffictypediagnostic: TYAPR01MB4080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB4080FE03FD1F221776D724DAD8150@TYAPR01MB4080.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0eoWPmlS0MPuzzv9TumD2v9h++aniATyqbsEYRrXORG7nutoQ1TDt3KUUQUTLzKQuhXBE1gCRPdbvnxPm5XiOL0VCJqNzYLIVaqnHktLdvkWlcfxPoY9rVzL0upoAeYGO7SMbAG2I59K/4G4M6+wEX8iCda62KPMPV5ZIM8F4CWr+HJgo9u2ajEC2BnNzPayRcvbYAeWxnthyG9GEJfsQyN7wVPB9uns2TKqwBbtjXCxlQoVumPwVG05UN0PUtWfE5G2drMUQ+h6vGou6ktvbbhlzqD3lTlqXWxpMHc8goK6U4GXyufaZ09PC+rPTfO/KZ2wJzD0mM/15tIT5goq5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(4326008)(86362001)(316002)(7696005)(66446008)(478600001)(71200400001)(55016002)(9686003)(33656002)(5660300002)(8676002)(54906003)(66946007)(66556008)(64756008)(52536014)(76116006)(2906002)(6506007)(8936002)(186003)(6916009)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KRdJcwiJO9uHa+BqEl5tqR2dHw/Fh6eJAmxbYCwB0JolmJ6okZ52JgHRdz3SMbPC9MJ+WJ0d0VsXYFvyuOOIdInE1VmYx4HIwEG0+P5cngipDlrjwP+bwft+Q2QHks0UzLbI7SWQT+fPv4Og0QQ+7FX64s7rC3/IyrXn9CIkYoTTEUv4gNYt8K/+95ZnlXlmqgEE/l9veu5l3VeXP/pl756KOHjx/zx51o43PzINW588lNEwII6fMyMUrgI89yVImfAkVfnOe+ITZsJ83HpPOQZ/LywtRQH3463Vdd6W/Eu5eIszPxWWAoe6H3ZE6hWIO7YpnNgs6Z2ursSID88cN4qm6D/7mCOZFjQUYmN4A71+IaRsZqybBcCiwvtcn39ljjWW6HX/rjdchey6pwyfB6RYiuS/j5u7wrzEiAHGbhRzE/Hl7cWpoIZBeh6vPgtqmYAO6RsoTIycV7o4CmF60iLwhbEYGjUL5YsHnhJgVYR0O2y679KBIhkpDZxfjcaj/4NbkB90sqEsHmv9GAg1eFgLmZ0ZB9S+FqrTPa+6xE9ozRxvMxN4iSgNCQuKTSdclVI+vFGaTX6AUGz1Ln6+1MU5tLfYsOEUaTAFFMCujBtSs5AmY1M0+hMLr+6LO/snPP9mnbjqg9LFY7rE8bxDanXpmWOJZiFr34gh6yVx4WND/6LBivCYmTY7FtVzbr5RZ4YxHblN1hQynjzZdQbnHA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1308c99-c073-4800-d82f-08d87c914777
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 05:04:28.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2SnKo2qw+ZurJebH1knSC/mRK/861v/2RxyATErnG1JkMb9K04dyNAbnuW5NMW6BlvUcyFdH9+eeDzOHKBOV9baobDLQLWuoqO9OcoOyE82XcCzpJX+ZXTdicJ4TsTMU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4080
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thank you for your review!

> From: Rob Herring, Sent: Wednesday, October 28, 2020 11:49 PM
>=20
> On Wed, Oct 28, 2020 at 11:05:49AM +0900, Yoshihiro Shimoda wrote:
> > Convert Renesas PCIe Host controller bindings documentation to
> > json-schema. Note that some compatible doesn't contain on
> > the original documantation so that incremental patches are required
> > for it.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../devicetree/bindings/pci/rcar-pci-host.yaml     | 146 +++++++++++++=
++++++++
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt |  72 ----------
> >  2 files changed, 146 insertions(+), 72 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-host=
.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> > new file mode 100644
> > index 0000000..d286454
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
> > @@ -0,0 +1,146 @@
<snip>
> > +maintainers:
> > +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>=20
> allOf:
>   - $ref: pci-bus.yaml#

I got it.

<snip>
> > +  '#address-cells':
> > +    const: 3
> > +
> > +  '#size-cells':
> > +    const: 2
>=20
> No need to define these here as pci-bus.yaml does.

I'll remove these.

> > +
> > +  bus-range: true
> > +
> > +  device_type:
> > +    const: pci
>=20
> Same here.

I got it.

> > +
> > +  ranges:
> > +    minItems: 4
> > +    maxItems: 4
> > +
> > +  dma-ranges:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    minItems: 3
> > +    maxItems: 3
> > +
> > +  '#interrupt-cells':
> > +    const: 1
>=20
> And this.

I got it. I'll remove it.

> > +
> > +  interrupt-map-mask: true
> > +
> > +  interrupt-map: true
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pcie
> > +      - const: pcie_bus
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: pcie
> > +
> > +required:
> > +  - compatible
> > +  - reg
>=20
> > +  - '#address-cells'
> > +  - '#size-cells'
>=20
> Already required by pci-bus.yaml

I'll remove it.

> > +  - bus-range
>=20
> This generally shouldn't be required if 0-255 is supported.

I got it.

> > +  - device_type
> > +  - ranges
>=20
> Both already required by pci-bus.yaml

I'll remove it.

> > +  - dma-ranges
> > +  - interrupts
>=20
> > +  - '#interrupt-cells'
> > +  - interrupt-map-mask
> > +  - interrupt-map
>=20
> And these.

I got it.

> > +  - clocks
> > +  - clock-names
> > +  - power-domains
> > +  - resets
> > +
> > +additionalProperties: false
>=20
> Use unevaluatedProperties instead.

I'll fix it.

> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/power/r8a7791-sysc.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        pcie: pcie@fe000000 {
> > +            compatible =3D "renesas,pcie-r8a7791", "renesas,pcie-rcar-=
gen2";
> > +            reg =3D <0 0xfe000000 0 0x80000>;
> > +             #address-cells =3D <3>;
> > +             #size-cells =3D <2>;
> > +             bus-range =3D <0x00 0xff>;
> > +             device_type =3D "pci";
> > +             ranges =3D <0x01000000 0 0x00000000 0 0xfe100000 0 0x0010=
0000>,
> > +                      <0x02000000 0 0xfe200000 0 0xfe200000 0 0x002000=
00>,
> > +                      <0x02000000 0 0x30000000 0 0x30000000 0 0x080000=
00>,
> > +                      <0x42000000 0 0x38000000 0 0x38000000 0 0x080000=
00>;
> > +             dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x=
40000000>,
> > +                          <0x42000000 2 0x00000000 2 0x00000000 0 0x40=
000000>;
> > +             interrupts =3D <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> > +                          <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
> > +             #interrupt-cells =3D <1>;
> > +             interrupt-map-mask =3D <0 0 0 0>;
> > +             interrupt-map =3D <0 0 0 0 &gic GIC_SPI 116 IRQ_TYPE_LEVE=
L_HIGH>;
> > +             clocks =3D <&cpg CPG_MOD 319>, <&pcie_bus_clk>;
> > +             clock-names =3D "pcie", "pcie_bus";
> > +             power-domains =3D <&sysc R8A7791_PD_ALWAYS_ON>;
> > +             resets =3D <&cpg 319>;
> > +             status =3D "disabled";
>=20
> Don't show status in examples.

Oops. I'll remove it.

Best regards,
Yoshihiro Shimoda

