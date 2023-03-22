Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF676C3F22
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 01:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCVAfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 20:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCVAfY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 20:35:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE48B57D0F;
        Tue, 21 Mar 2023 17:35:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEtg5oi5xkcMuj6iKpZqcB/reriQeEMl3z7VaQHyXNge1stbV36pR8Y2f8zOOEQos3KpcqAzdz1O5n1bjIqsVBgKYJcxbTLTApn9sAYzLbISA0i/pbc8ViSwMoVJADa6BHRHwviaJbVR+5IvnUZMbBlPQTP3OKsu6uqAzrgMVjnpDqouNIpX95u0z68RuVqPQzO3CgxnQEoeh1DL+5qRGM1T1aourBUFPMg9p+tpvp6og0VApmoSGcXXjAI04pczaO13YqY1+jl7V3tCd6kgoSdUwRFoWdsM+V7g6NrSWTx/nNmJKXjdbPhY5U/PApA3WfO3Hbt0go9Fz3/9MIJFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZf/rqjcVAHsvjVEmnOsZ5bGBAX7hHbOCmMqMjhF/zA=;
 b=OlCezVgfcxY9Ryr2tjDlx0zGWcWxRjjQ5/xqHWRMNo9FWeWcZo3KT423sW6E0zIZ9A4LjaX9h5vthyDpfqa0a1APgVoIagCzNLen4grBhVeccGxuJpyfYtTWOUNMHQ7pmdT+8jnuwHe6M2RdqxehRyob9YvuHV4LDHS3rws6Cv1GZcAnAx24+TnGaCysUbeqmh5RPH+Ijb6Hnmccu8d33RE+VvpELtextdpFROvuOTCtWK9W1yIAAILz2uYVMIyfsnghAOs/luIiHKxuvz7KnYMLtcyl+hKvdtuv91YZQBY1MV0rXo69M+mKElBzovhY4lczHfmA9kkTWZKdOiECRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZf/rqjcVAHsvjVEmnOsZ5bGBAX7hHbOCmMqMjhF/zA=;
 b=cLSb21XtMv7NiEo7ILnsuVTP/yKkzRpJIJ8OELru3G4Jge4MWbutmHOeh+eykCoSP3L4aIDPH4ZcSGvVkXIWtO5JPbDYxB+Bz3fMVEpiTxzadhwar2uOlln1gAJr/9tEiPdVMQ/gOmIv9vVvmAhvzzZCxfUXehzCOH6rbwwClnU=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB8891.jpnprd01.prod.outlook.com
 (2603:1096:604:151::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 00:35:19 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%5]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 00:35:19 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v11 03/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Topic: [PATCH v11 03/13] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Index: AQHZU0zDGkqYXH3Wl0+zQ7aTc485xK8FLAiAgADYm8A=
Date:   Wed, 22 Mar 2023 00:35:19 +0000
Message-ID: <TYBPR01MB5341EBFA25F9D3D53AEE72F3D8869@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com>
 <20230310123510.675685-4-yoshihiro.shimoda.uh@renesas.com>
 <20230321113603.xxdiekhqpv4h777f@mobilestation>
In-Reply-To: <20230321113603.xxdiekhqpv4h777f@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB8891:EE_
x-ms-office365-filtering-correlation-id: 9566f35c-4d69-4ca3-6658-08db2a6d5064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hpdIHJ2l0LG9oqFdIA6ze/QPUtPp8skcpwUVR8jooHMBsMaX0q8hAtEXeypLDiOeoeGRHZh3QB3eF4e+kXtGsgNTrPaGmqrSHMuQUJXTOsRebYb77bo2j8+FjSdlXJiN07tnwaMMrGwmAxenlZvxyoqfBvMEHAokcDt7NrbBeKweCtLNZOkG4fZPA+pJnuUtwgY4MmUrY9qsqasPAa0jdX/95GlgEZ1yYL2u4QGzUCAWRJWz7E2H2ftooyB6q/wIEiIeIdfWxAYP45SPYi5coxwJOLkjxmRA0HltY2COuCOsbxhQ3LGf8efpa2+B6RrweQQ4o/VxAuqnTwUhlmYfjhfZQ3LzD1Z6moLnqYhSNTvfRjUoJfYXL24AXHGC2r2gmSl5VVcEY51ta/X/lD2ZRUF9J0bHhHauRhe99uZyVlbDcJgbchTa9btoy/9i66OcaJ1IizinjbBr+/Dpy7QIV0Yh46o4oTrSns49JSs+5AJaFCwjHPsKejkI+OcfMRV6SYMo0ipJmzrY5QzuZK4Be92jQWleX09+6sSGbteIJanSQanFs0fbG6DFj715E4bSRxVZjcoyJmzeZeED96QVnWvvn1HtTuLwSRoKipfL4VMYjO1e2ixvepztuOitg4RgBEH31Lwzzm66ly50J40GzF6h18qxNvEIg2hcGqLBzzaJ2EICPRyI5+/aTk3mErBUSFi7WPeP5YBJwrhryrBSDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(5660300002)(8936002)(52536014)(7416002)(41300700001)(86362001)(55016003)(38070700005)(33656002)(38100700002)(2906002)(122000001)(4326008)(83380400001)(478600001)(71200400001)(7696005)(186003)(6506007)(9686003)(54906003)(66476007)(316002)(8676002)(66946007)(66556008)(6916009)(76116006)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4t2ZDLiN59np+woahsc1eggJ2b3KaQbXIdYH4PT4WqKvBxZM9D0ttGVS55Y?=
 =?us-ascii?Q?b57JFOyjlxDkI+vZmz3Ga/mI75kengFyDkcx+Xeqxg7Q5f1Ho0MSihA9hFhO?=
 =?us-ascii?Q?O57eCvLOLEKldyXOtZYDAxRmOcrGMCmGd8SH4OrDka1fyNkUKeuc12msA+Pi?=
 =?us-ascii?Q?ThCygzLSM+Fq1JZ2hK/ZW6M2OLJbQOsWrpTLoaW2TJm7SbDjWiaGgEYmIm1g?=
 =?us-ascii?Q?InLefqbbHk/hqZCRfweZR3RyTT5UT7ZtLL8n6V1VRVhOas6fgHNfLL4zIUPj?=
 =?us-ascii?Q?Wo/TYf0X26JsQb7IsoSTiqQUVT+KtCTV1g0TMVbtDKVxAUq+Qd27LNkwMxcW?=
 =?us-ascii?Q?OCKRt/0y2rCAIews/BL/f1Y4OGr3JMe9ECjcO/Rf5qQSHQ73hdMWVL95qq45?=
 =?us-ascii?Q?8CkGmOnKRcT2Xr4Z0lDtcIy+g4tUCz5ukXsSeliFZ65OTVfpvyB8FTNvXn9H?=
 =?us-ascii?Q?TT/jWD9X9Vwh8vVeAMWeEeakVBF4CO+b18NEUyMJORNAWQz+2XJqmVfMu+V0?=
 =?us-ascii?Q?mGvD5BIKnwW4E+JZM8aYL9CRerUCRXpRtQ4cMEMSvfAd4nmAifm5RKRZIAiU?=
 =?us-ascii?Q?AXYSG90e14vmJ7E+32ArYLimOSR6S0Opr8QevcP+7+OxZzgSuXpbUmDnEM6Q?=
 =?us-ascii?Q?yaXAFgBJQSd7ub6sirjfKCBcLb0kr5GC+JuuolZGz+P1LWSLGcuNeghSobjo?=
 =?us-ascii?Q?3MxA0DndWeWBaBYYNPBRJ9bOo7XX+Rl9baVX1BZIpXlVblFmct75z5ATsau7?=
 =?us-ascii?Q?bCzO/0hAl0MO+/+doXqlrwVnR51xr4IPtSVJvxpp947UoijW1r+5YZHpcqp+?=
 =?us-ascii?Q?7n80kCsyNJvrjMmvE0bNUbXaiUjYHRp6J5UHvSPb4NPjZ/d2DWedwaJeEVpg?=
 =?us-ascii?Q?zePvYMcbl89dpPckz49NlwmjalyNY/MEfHhWxllHlN4Tif/wkHrEDQKtjjsk?=
 =?us-ascii?Q?HMJNMLB/JFvF7PbqAOKMHAF3wQNR0nFmmmoHMDhaIVly/aAsDD8NwFi1ASdA?=
 =?us-ascii?Q?CrU3b4ghmbMOmluS1BIsl4Le2+R0SaXf9xCnTYYDWHcqgds3V6J+mdeeJJV5?=
 =?us-ascii?Q?ICv3PCMbNwtR2jrBp6keVaooB+EzBymqiUC8cjzp95NBCMKkm8bfjOZU6YIb?=
 =?us-ascii?Q?9RzOQj1CCtOwxmp7uQFnCRjppo6hwyGIVADkD29gP3amCCcOrmroZr8P0YVD?=
 =?us-ascii?Q?ROMwBobIeJdlh4u14i/QAWeld0R9E/IqJYq7d5oPa53W7AsT+c8xcAF7HxxC?=
 =?us-ascii?Q?sw2CSzLsMidbbdXFIbiFo7xpqymouF/BVS6dTSPI3PDK5bBY4Bjqf61Wpkl/?=
 =?us-ascii?Q?7qC61ILEAQfavTqAkXkWbZO2fEvuoQJ8kCwlnESHfYay/asSLHWVOVbG3EcL?=
 =?us-ascii?Q?nx9KHATXB1WCu8YFX/age0MFe85QLSXnp+jLBblTzOQN0c8BWhbrVbPWHqPK?=
 =?us-ascii?Q?ZSC7ukNe14UZw0RPM+bd+mMAZJwgzngxNUbAMeTU28YSQLMtmiHBx6rYRFoi?=
 =?us-ascii?Q?oLXVTudwbRuIjhty/yxJ7/J1kPraAOo84TckNpzDKLjUCaiZvx8Yxuajx6Gk?=
 =?us-ascii?Q?fLh2lgZiopmvwk2/LymW7gtJpYVEBB/gMdB0VCAnKcY0f2YM8y1NKDFZTgF9?=
 =?us-ascii?Q?BP6B0YSERgncEKKdaSAa+Z8EKjvdhyljFXTLwGgOrf06AOtPLVSN8q+1vVGD?=
 =?us-ascii?Q?H3LMUQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9566f35c-4d69-4ca3-6658-08db2a6d5064
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 00:35:19.1290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9f5eYo62Ie5pOxqGLnU7I3ztsBY+BXS/+LAfJMcmN20cg7lOJJX7dylreRxFC0IXiKq+tC0yqZhjTsVJo2J3fA2ciuf5XJR/2Wzvy2jwN+1ByNuDOZZihBUHgMEVBwum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8891
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, March 21, 2023 8:36 PM
>=20
> On Fri, Mar 10, 2023 at 09:35:00PM +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe host module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> Looks good.
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Thank you for your review!

> > ---
> >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 108 ++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-host.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.y=
aml
> b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > new file mode 100644
> > index 000000000000..d838d7c50410
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
> > @@ -0,0 +1,108 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id:
<snip>
> > +$schema:
<snip>
> > +
> > +title: Renesas R-Car Gen4 PCIe Host
> > +
> > +maintainers:
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > +
> > +allOf:
> > +  - $ref: snps,dw-pcie.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: renesas,r8a779f0-pcie   # R-Car S4-8
> > +      - const: renesas,rcar-gen4-pcie  # R-Car Gen4
> > +
> > +  reg:
> > +    maxItems: 5
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: atu
> > +      - const: dma
> > +      - const: app
> > +      - const: config
> > +
> > +  interrupts:
> > +    maxItems: 4
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: msi
> > +      - const: dma
> > +      - const: sft_ce
>=20
> > +      - const: app
>=20
> Just curious what is this IRQ used for?

The pcie-rcar-gen4 drivers (host and endpoint) doesn't use this IRQ,
But the hardware issues the IRQ when it receives a vendor defined message
from remote device.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  max-link-speed:
> > +    maximum: 4
> > +
> > +  num-lanes:
> > +    maximum: 4
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - power-domains
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/power/r8a779f0-sysc.h>
> > +
> > +    soc {
> > +        #address-cells =3D <2>;
> > +        #size-cells =3D <2>;
> > +
> > +        pcie: pcie@e65d0000 {
> > +            compatible =3D "renesas,r8a779f0-pcie", "renesas,rcar-gen4=
-pcie";
> > +            reg =3D <0 0xe65d0000 0 0x3000>, <0 0xe65d3000 0 0x2000>,
> > +                  <0 0xe65d5000 0 0x1200>, <0 0xe65d6200 0 0x0e00>,
> > +                  <0 0xfe000000 0 0x400000>;
> > +            reg-names =3D "dbi", "atu", "dma", "app", "config";
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +            bus-range =3D <0x00 0xff>;
> > +            device_type =3D "pci";
> > +            ranges =3D <0x81000000 0 0x00000000 0 0xfe000000 0 0x00400=
000
> > +                      0x82000000 0 0x30000000 0 0x30000000 0 0x1000000=
0>;
> > +            dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 0 0x8=
0000000>;
> > +            interrupts =3D <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "msi", "dma", "sft_ce", "app";
> > +            #interrupt-cells =3D <1>;
> > +            interrupt-map-mask =3D <0 0 0 7>;
> > +            interrupt-map =3D <0 0 0 1 &gic GIC_SPI 416 IRQ_TYPE_LEVEL=
_HIGH
> > +                             0 0 0 2 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_H=
IGH
> > +                             0 0 0 3 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_H=
IGH
> > +                             0 0 0 4 &gic GIC_SPI 416 IRQ_TYPE_LEVEL_H=
IGH>;
> > +            clocks =3D <&cpg CPG_MOD 624>;
> > +            power-domains =3D <&sysc R8A779F0_PD_ALWAYS_ON>;
> > +            resets =3D <&cpg 624>;
> > +            num-lanes =3D <2>;
> > +            snps,enable-cdm-check;
> > +            max-link-speed =3D <2>;
> > +        };
> > +    };
> > --
> > 2.25.1
> >
> >
