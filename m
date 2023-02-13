Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC5693DA6
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 05:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjBMEzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Feb 2023 23:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjBMEzY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Feb 2023 23:55:24 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2071c.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::71c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D82113CE;
        Sun, 12 Feb 2023 20:54:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jifmEz4bfYyJMInFcOrTSpuaxqp91JiEfr7Zhqve2HMqWz8NTaPyYFLhS3UWtguQ89E31/QWMOTKTWo3QWsSYxHG3d6cEc1GEMYE2DD7tnt8NS32J0IbfYwBcNzJJ4Pm5hs1ztbqTW/dE0yrPPE6z2Eh4CRcTq7FSpUon+Us4RhdXNGs3yKMM6xxKIOrVWvEzX8ElqxmriEf1yA9euA6bcCd8VdeHSE9db3Y0LUzY2EXHGUG4ekkIr1gaYguKqyZdeMNV41CW74mtLUGgMXZGIeV79RujDmAtWigjCHoPfKkHsXx8/lAk7iQ/q0DYOKRgVbnFwumgF3XBGm3+/JNxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfcjSCSRraldDOb/uClX4rF7oTrJIli0pNcHgDYWg4I=;
 b=V2OLNv0A8T7orf/TaViydaqgGMY9hH1bhWrBQADaEjitw3BU9YjKlOeSLNk4woTtL3EcfkhX/l+xeT8neXrGtkPb+X9jqjV/HP3eT7c3if4g2873rsMuhAXLt8hzhXE5Ztk7lAMQCpG/q+eFE2WLO+/5l4q1R8E/hf2Vdd9mnVLGqZPXFXyVpvi4PL62ZoKCBjjvBJHIsrLwdywiZ3CZNPGGs4tdpBKXDXdFBoXOub0hIFnvQNecLXrGCckUTD6iSsYui8SdMNf460+aP/MMwXcibUfNX5+DxxhY0/8xK+2lZuHqzztYDkGqnycDoBxW+zaU4BVUmxw6CDB1cZ67oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfcjSCSRraldDOb/uClX4rF7oTrJIli0pNcHgDYWg4I=;
 b=Oolb3xoamnu7JEPFcD+uPxko3TWgmu4G81alCmZzP48ELBaN5yxG4jA4tY+2JCy4AwvUh9pO5+kIxtGdgiVd5CldNjkW0wxRTjVJV0BOYQdysSi4vw4ahlBZcfSVVQB8Z1/2FnUN+WGGIwIxHnut/EYYDqTjJ6Lm9wVVFQGd0oQ=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS0PR01MB6164.jpnprd01.prod.outlook.com
 (2603:1096:604:c8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 04:54:41 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5f2:5ff1:7301:3ff1%4]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 04:54:40 +0000
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
Subject: RE: [PATCH v9 2/8] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Topic: [PATCH v9 2/8] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Index: AQHZPVZ93ndppJ2KrkyhoqFLN5HBBq7L0mCAgAB/rGA=
Date:   Mon, 13 Feb 2023 04:54:40 +0000
Message-ID: <TYBPR01MB5341EDA293115F5DB2B836DBD8DD9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com>
 <20230210134917.2909314-3-yoshihiro.shimoda.uh@renesas.com>
 <20230212211109.jsegwlqjru56ypq4@mobilestation>
In-Reply-To: <20230212211109.jsegwlqjru56ypq4@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS0PR01MB6164:EE_
x-ms-office365-filtering-correlation-id: 3962308a-5d26-48da-55d5-08db0d7e6aa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yeA+kqEQXOX5CyKXr0NsQ0+Rz8s0Is5ERTK9PVflNxU4EmSVqqhlO9Xe8gAaaMXVIrRZCaaKklm3T9b3w1LHX0Djo2Ys4ICik3Snki9Vi1eoYJ9LMNpeZpyHRr2gIKErRs5saGBYpJTp1IU/jCbj/TQH03yTz5Ua2qn7Wq0YxSHcIW5h7X4MB4BxxL69O48sCSdCxd/Gi22xpyzTMWLavB/e+Vx4rMnPNNf76tN5XNZaLUHADTb/NEIfUHNfM75VQlz2OiSMl41wpdfGPDzC1cEZvAN8eHGIJIZtssqlyDNqpeqa0ACJJhZDdRgWK48eE6YpqkqAeETc+ZEPmjKaLSDBSGmsu0oqpnTsJkZRPR8LpK0Tytp9iqlTbo+cyEipa7T4SUPzAv0YgiitVFKbs072//63C/3zxq+LgmFGzvvlqUOy2fe4ZD0k9A7eJzQgMnP30g3GypTjq3ngD86ma3V7jNoPPFY0Ll7DYwY1TqGkC5um9yVr5LMIO9EjlTvL+f87Zjmbj6g1+6akUkHB72Ivk6ZtxySeO6lDiN2/gxhlRUybg0h3cqXGxK6T2iot9CDFtu7iqp0H5pkN+SWarFKey5jh9A76WB/B3A6rHM0/Ah+kWWGlF4ObKzmAajRtJD6Z3C0k6sebZI/O//hT6/1b/d4DWVJGtQ6VQ4x7wk3qQuvCTaCvyMM9WUjrRBd7JHyzsNaFCGAlby8kamKabw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(7416002)(83380400001)(5660300002)(41300700001)(8936002)(52536014)(38100700002)(122000001)(38070700005)(33656002)(86362001)(55016003)(2906002)(7696005)(316002)(6506007)(54906003)(186003)(9686003)(71200400001)(6916009)(4326008)(478600001)(66446008)(8676002)(66476007)(64756008)(66556008)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2/XxWgLNMURgkzOO9VdCo6iGD9bXqlvlDmTNm3SJsTDS+tlHNPnePSwN6BqL?=
 =?us-ascii?Q?uA63JULQza2EVWYAdmulty52sEjuO1rBpJWMPSFA15LcvTUxbkvYAARc24Rc?=
 =?us-ascii?Q?+NEMyKCcN20/Gop7fj5oFFGim8ErLu8pMseNOe267uaoRAsIDHzgDr+C2o58?=
 =?us-ascii?Q?18upyzYzC6pbWQxmeHndFO8Z0mpR8PdSk0NcOwTBcAjcXbfeSdZHbRlooG5i?=
 =?us-ascii?Q?aOit2ddHr7Ya+HHr0qp/TWnEAy3GNEnOL2DEaFDJko/rNJkngNPriUqtoEYB?=
 =?us-ascii?Q?e6errWPZkHqbJgTC2pO8hJPy6PGuR3v5K9iNGD3/Ff3yhABceOMGBNz0MD+g?=
 =?us-ascii?Q?pW1hCPq1BVLfGJjj9iYh8WedWabxqKeZPcK1qTaZHR0rnNarSvdXmp40NbYG?=
 =?us-ascii?Q?qcTg6IABXI4RFqAzZr9Iy5PxUj9La50WwP7Wc80sNHPsw3mSpI1uNhC916u6?=
 =?us-ascii?Q?vzrzUspSMrAuV4S/kdMquZbTiWI30989D5YJAReYyH0lr+Nl3ibSJvYcJiF+?=
 =?us-ascii?Q?RvkyROX8yWXAiOn9C1m07zMuJ8eq6WAGHv4v/1+nXSzo4ZYeJR6LiZgFunxY?=
 =?us-ascii?Q?JZuV050lmSE2dnu1mUMiHLRRYRs8HoomaOlEZCmkxVg6RFy2uv7SQjADLZ44?=
 =?us-ascii?Q?/KvjtXPLwJ9CIK8WR3HW56NfBD5vE4MOD1rPT/CqKYfi/DG2oKm7+xzkmxbO?=
 =?us-ascii?Q?X+Mv9W3a4A6ubxqfbAqT/yH2vFQ+UKFE+sTfB4mX46wBkmrZlTKeLaKiALbK?=
 =?us-ascii?Q?Hrnv9r3+C0oxHMVk+LA5PupWi8pSuHCCbSDNiQ4BRZz5LLBymace0DRxcHiB?=
 =?us-ascii?Q?Qe4e9uR0jrnQpY2PcJC/RqaxT+5QiIN2+YlvFcwzRNyrqfyZos2PGduSyW5H?=
 =?us-ascii?Q?DGvW56LF+NlQtnTuPut015GUZh7JEAHGA4uVhcJni59vaOVSsjGqaUFRAC6A?=
 =?us-ascii?Q?AQIydK8vZQWBahIU9q+li2XXFrpIVep/QneybMEIw8biHzwzrVOUSygVcBUJ?=
 =?us-ascii?Q?H5SgZo4jzWOtyYkm4qkkddMa7dI0NxGxt3dfwKlNeTCLHhdpWko9bHJv1soz?=
 =?us-ascii?Q?qZF+kD68KkKYvt4f+ds5tUZc5lNmW52IIQvlYxbHIsVIf9zJMrA2Q217KXgN?=
 =?us-ascii?Q?WQsT9clZnLN3dQHVy5c49qL7chzxf2F3OoMQCL+nkn7pW8WnpVzUuT9O44w8?=
 =?us-ascii?Q?N8ydNreh0EDEBVmenhMlk7Vreri+Hf7ueepWTLXhLs2i2H2cx98k6Zt+TwYr?=
 =?us-ascii?Q?Jx3M82n5O9oCnYY1kqa1rlUSRWjUKsklexE3szq0FsLTaZWKFkr+eOZtdbZH?=
 =?us-ascii?Q?O0VL1Fjn41uOcLFVSsDqp6+0BHzPSf+dSMLElCCmEkaUOlQchPpQk8a51m1D?=
 =?us-ascii?Q?IGF3bWTVJbHrPkgQoRUyYMonMvLZd9Ut7syaj+GPbcVdMbFvPfEmrQMRMUI4?=
 =?us-ascii?Q?Sz3g/pd8i1drMsDT9tiIx1yIn7Ja6mojB57KDoYYnc2Oe4JEy8EFRAxMg/+O?=
 =?us-ascii?Q?dR52kpqEfXhLCoxSKDop0rHVkPWZkEqFWRux6IAsHJIQikxqkYLsC7LJi6Md?=
 =?us-ascii?Q?0Afy6Oe8JEYF03/QK6cO1y5hT2LWtBNoHvEMxATEepQ3m5SobCfX+2qhOGl1?=
 =?us-ascii?Q?MFDKFZuZGqwEqn1dH6ID8eQXS9E29mR2szN2uaDocS4vt1v/guViRU84GRhs?=
 =?us-ascii?Q?o3wOgA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3962308a-5d26-48da-55d5-08db0d7e6aa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 04:54:40.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbjSY0mzRfzxPbbMckh5oPhFoG2QeYbciqXhbLNvM5ZFEx1zMwpnJj6jbUjwKAOaODRAdHdVAKQwNQQ32Zkn2wl/TNQzBTgGrS10KGrncR3XCdPnKVpZOOhvTmYUXCFG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Monday, February 13, 2023 6:11 AM
>=20
> On Fri, Feb 10, 2023 at 10:49:11PM +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe endpoint module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 90 +++++++++++++++++++
> >  1 file changed, 90 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-ep.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yam=
l
> b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > new file mode 100644
> > index 000000000000..4b10d67e4336
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > @@ -0,0 +1,90 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id:
<snip URL>
> > +$schema:
<snip URL>
> > +
> > +title: Renesas R-Car Gen4 PCIe Endpoint
> > +
> > +maintainers:
> > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > +
> > +allOf:
> > +  - $ref: snps,dw-pcie-ep.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: renesas,r8a779f0-pcie-ep   # R-Car S4-8
> > +      - const: renesas,rcar-gen4-pcie-ep  # R-Car Gen4
> > +
> > +  reg:
> > +    maxItems: 4
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: atu
>=20
> > +      - const: appl
>=20
> Please, use "elbi" or "app" instead. No need in using the
> vendor-specific names if there is the generic ones.
> (* @Rob, that's why I was insisting in failing the DT-bindings
> evaluation for such cases...)
> See Documentation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml:98

I got it. I'll fix it.

> > +      - const: addr_space
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    items:
>=20
> > +      - const: dma
>=20
> Are you sure there is a single IRQ line for all eDMA channels?

Yes.

> Judging by the DW PCIe HW manual the eDMA events are signaled by the
> wires: edma_int[((CC_NUM_DMA_RD_CHAN+CC_NUM_DMA_WR_CHAN)-1):0]. If you
> have a single signal then they must have been combined on the way to
> the GIC though...

I think so.
The drivers/dma/dw-edma/dw-edma-core.c seems to support nr_irqs =3D=3D 1.

> > +      - const: sft_ce
> > +      - const: app
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
>=20
> > +  max-link-speed: true
>=20
> This prop is determined by the CX_MAX_PCIE_SPEED IP-core synthesize
> parameter.
>=20
> > +
> > +  num-lanes: true
>=20
> This is determined by the CX_NL IP-core synthesize parameter.
>=20
> Thus you can provide at least the 'maximum' constraint for
> the properties above.

I'll add 'maximum' to each property.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - resets
> > +  - power-domains
> > +  - clocks
> > +
> > +additionalProperties: false
>=20
> Are you sure that none of the next properties will be ever used in
> the R-Car PCIe End-point DT-nodes?
> max-functions
> max-virtual-functions
> phys
> phy-names
> reset-gpios
> snps,enable-cdm-check
> dma-coherent
> * etc
>=20
> I am pretty much sure that the reset-gpios (platform-specific),
> max-{virtual-}functions (determined by the CX_NFUNC IP-core synthesize
> parameter), phys/phy-names (you had a PHYs CSR space in the
> DT-bindings example) and dma-coherent properties are relevant for your
> device. At the very least the 'max-functions' prop constraint could be
> explicitly added to your DT-bindings file. You must be aware of how
> many functions the R-Car PCIe EP support, right?

The R-Car PCIe EP supports two functions. So, I'll add 'max-functions'
property with 'maximum: 2'.

> The rest of the
> properties could be implicitly evaluated by replacing the
> "additionalProperties: false" flag with the "unevaluatedProperties:
> false" statement.

I got it. I'll change "additionalProperties: false" to=20
"unevaluatedProperties: false".

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
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
> > +        pcie0_ep: pcie-ep@e65d0000 {
> > +            compatible =3D "renesas,r8a779f0-pcie-ep", "renesas,rcar-g=
en4-pcie-ep";
> > +            reg =3D <0 0xe65d0000 0 0x1000>, <0 0xe65d1000 0 0x1000>,
> > +                  <0 0xe65d3000 0 0x2000>, <0 0xfe000000 0 0x400000>;
> > +            reg-names =3D "dbi", "atu", "appl", "addr_space";
> > +            interrupts =3D <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "dma", "sft_ce", "app";
> > +            clocks =3D <&cpg CPG_MOD 624>;
> > +            power-domains =3D <&sysc R8A779F0_PD_ALWAYS_ON>;
> > +            resets =3D <&cpg 624>;
> > +            num-lanes =3D <2>;
> > +            max-link-speed =3D <2>;
> > +        };
> > +    };
> > --
> > 2.25.1
> >
> >
