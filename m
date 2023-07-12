Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAA874FC0C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jul 2023 02:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGLAR4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 20:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGLARz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 20:17:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD2BFB;
        Tue, 11 Jul 2023 17:17:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG5VCUEPvWBcvBOYOmSqfN8HjwkzWFDnwkcZLbQ2gtCCc/T2XiSUYQmLM5s6uMgkWOdft7CyxeTmnQpIP3Z1qVwk8/VZZkH/e2q02es4aUqymouEEq2zuOq20ajuIQkcXfkI+k+K03Gj6/iyg1MDmm8nsjpNDI34NtFObPM9Yv7Rz4vqfQdHYk7Jpn66Ag3JZJ5OGMM3OSrpH3YMsgMaQ1SdsupXt/nphmxm9uP0Svhl9pCpIs5rdGCIXmFgvtikZ8dG35yoEPQaU3uMJwji/ZuXMDt21Ky9th7kK12tRmRwhk/XAXHVCvRE+Hc/rSGrV8jU97WsL3Yq8WxnBFg1mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNCXHi2ZsvRvOujY4dKmIpcH4NnJdN+XcFHC5pKsKHc=;
 b=InO+aDLpQebTVkXdVvimG1rulCng6C5nmGzwmLXcaWsMpP3RGROK3MZWDVeFafvdSnOhGb62vY+WS/x7hDUL5EP4kNWqXClveR0wpfnSeCrUi6tWfAT4Oz/Gt/kcPbyIy2d+gi4x+PA6mn4ZXlt67O9iHIru41pM6sDkWgs60ddE+eEMhxB8Me0cOZmJK/6GckErP5tS051OujBA6AgBA4cM3bdH/FYuGTLNZ1K/6fV1dqziS8uZWjgKOisvpZFoQLa/cXRBxsR1b/9sSvAJD2AsjG2JoSMO9MWqoRtHATmky0Gdm17cJa6qiohx2UcJd8QVpWT7v1QN0GF/A3Cgvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNCXHi2ZsvRvOujY4dKmIpcH4NnJdN+XcFHC5pKsKHc=;
 b=lT4hwUkVcRwPd9caQGjRhq96O9Eja1po7TQguFCvRTYHQ6WA0o2AvZTSyA2SF/amyncfTYxpP6W79uAkG0d4wKZcAmf+bzqMgm47Kl8e/i8BoSp3IS5Hd+oGeRVPg7eVSym3qJooHv5es9BKv/Dc8AHPi+O1yEexwCJxf5RZMrg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB9549.jpnprd01.prod.outlook.com
 (2603:1096:604:1d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 00:17:47 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 00:17:47 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: RE: [PATCH v17 16/20] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Topic: [PATCH v17 16/20] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Endpoint
Thread-Index: AQHZrzZOhmZZlqV+G0S5OoAbmbQvqa+1F5aAgAAzlOA=
Date:   Wed, 12 Jul 2023 00:17:47 +0000
Message-ID: <TYBPR01MB534172B437BA8146E05808C7D836A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-17-yoshihiro.shimoda.uh@renesas.com>
 <rk52tz3tmpzg6s7szkh3u44vnr3sncgtb7535fn5alf4fj4dlh@ljmhmtjee3rw>
In-Reply-To: <rk52tz3tmpzg6s7szkh3u44vnr3sncgtb7535fn5alf4fj4dlh@ljmhmtjee3rw>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB9549:EE_
x-ms-office365-filtering-correlation-id: e4e65d33-fb0b-4931-2206-08db826d6c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dVndDJ+InyJffD0us9pAReIIFOYAsPPYG+WQa3ePyUjR/Wni0CybmDpwBP9CQ0eQmGtW6cRW3jcTyxvPPRQDE0omS/frmvZFtcoOREf7oPJopRRWegzva4oAst4wakcMjX41XGk/kqv6Hr6Id04qmd1XrJlAvDQD/CW8H3dbXCwWxhvB3hHDl6bPyKJ8rlD+YtFXYzVAlFZwVn/NbR3yeQTj2yssswFEqnVI8sgTgTD482kAZqnpfWOGSjP349juueiiEjvU2450D6s+T1i+SlNad/3FbRLmzXwZunDQgOFwKmHQPL7xRPqHoZoy2iejJLjp6UKlrwnVYEk8AMsMRpSQSJXR1efs1Lmy0jTwwgc3dYL/Tq5KOm9do4G4aT/u2e59BNm9imt6RXNHoZ96en/tcv1aApq3Ak3U7HhvwRHaSED37JCP+cOZ9QRPBKgtUafi4w46UsLHSeC7ru+gouBNwFoUwngfcVMMgk7CH/Sj5mFUBx3vuE95pXbPzIBs0L3ymQtSvM0BRvmNUlF91I8HctMvSKuIsCfgj10bh4NL0tmrTjR2lrmn8MtVoRc/yv/KpMxEar2Hlvfi9vAeuigN+LKHL6e1byFXnw5z2TKoNtdYnU2lOHxa3fHGGKPS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199021)(38100700002)(38070700005)(86362001)(52536014)(71200400001)(55016003)(7696005)(54906003)(76116006)(122000001)(9686003)(6506007)(33656002)(186003)(5660300002)(2906002)(316002)(66556008)(66946007)(7416002)(66476007)(8676002)(8936002)(83380400001)(4326008)(64756008)(66446008)(478600001)(6916009)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5+aIcXXTZVyRUT5i8isB3/ykU2w0Nie+gBDz3SS6tO9wgQuKemwUjqbX1OH5?=
 =?us-ascii?Q?wyoI+fPKq2l0yYR2d1L4RZvT9lC/t0jSvisXZVFqyPJqRX6Hf4qm332S273B?=
 =?us-ascii?Q?A3ecu/H/OPc9ixBw/NCyxoPHGPcGjlg2jGF+vXl6mMW6qYW7MSKS1iRcMlQb?=
 =?us-ascii?Q?vwZi9ZpnGQNVhVqmyxIusIOosJN43HDAz948530bUwHunxAGc9SuWqIb3bXj?=
 =?us-ascii?Q?fZRx4QPDLr+u6XiU8aem3envT+jGcz9x7yHeJ32PpNj4d2qcyB2wFrs1efkg?=
 =?us-ascii?Q?w4sThIZTVIzG9HeFhvUey/j80OYrXf9R627qgm2G2QhWpYl18tFYzHY0f+fR?=
 =?us-ascii?Q?hztuzAs4W+N9Wm5o5YtT7f+ydlYB78f2z/F29uZdJcA/2KFRy3Kb03341DIe?=
 =?us-ascii?Q?nIG+6W3/TBUuHN5oTXSe9E2Xw77cWuDbvEL7BJ48OXBOGS072HyUgPHGkLqL?=
 =?us-ascii?Q?cmw4fVKd6+PjwErlKlzbKsQYu7rZowUstCUKCoPY3CY6Kd2mxi5n2dTXKymm?=
 =?us-ascii?Q?VQ4PgMH2IQ67/GM2LfTEJrWlmpCtsGaBII51BYt2h58Tf709yddb9dZ2AhAf?=
 =?us-ascii?Q?JTsc4UnUl0vTM/hEXj78zF3iD7h0uzIi9MijUUsdkzIZO0YPIuDRWe0/XIXI?=
 =?us-ascii?Q?3slhQ3hykN3y7NM0Ib5UE8q6XakHDhATnKdWlFRCSxwufMnuFORLCSswSR3f?=
 =?us-ascii?Q?MMNK/cHKggR4LVuMXO9B9VK/gClNmPKQWjmTjhBUPWMs8GLMqxNIigeCa/jN?=
 =?us-ascii?Q?UqDvufDh27XurpjAm9Eovc9xnftDlUG2H+ITAw9e3UrDzrvzxUUGjtI5bnkC?=
 =?us-ascii?Q?c9Dht7sB4tvDkVFsW/BQptBPtLhM69gTvzyqU0GTXnEPCxKZmKuXU4qhjUmW?=
 =?us-ascii?Q?iBrmGFR92+naFGhnyeLHigdhZkJ6pRO7MbpUXm+URC0oXOJecgb9XpZmz3ra?=
 =?us-ascii?Q?up6Xt0P1SoGlQlFUDoFUqkfpBOrUE9CxHEhvrgZPgFnJJ6ICq3gEFbWpkW1V?=
 =?us-ascii?Q?4pSQ10trowp+IEBhJIrBg0h2nu4OXa0tCmtd0kfGZLlQ2WqrWUY1QjzknUtZ?=
 =?us-ascii?Q?km1ke9tXVxTrXjpJrFkoW+RUMvt12A6cD88ti0+3VlIUb19JHcsmQ/8ecQzS?=
 =?us-ascii?Q?CKpRMPUr1q0ppljyKITzfsoDVpvR5Plv6agdyfzd3nSkoq2Zq6QPAUng1yQO?=
 =?us-ascii?Q?qStwmlio6kb7gDAjDWI4xxpPJ7nFGpDPD3xxd3IrxnHERL5Y9UDuktjFsovQ?=
 =?us-ascii?Q?R95bsj8MnHUlCPkjIs9+AQ/Ce+m8AIlMt83+TI9ySknGMZS4/5mFU+4OlEMS?=
 =?us-ascii?Q?v61W6gQgIuhW10a38CEoXUqmAU/eIlEDcIrwM3oPm77wY6qVXdAQadVrGmKL?=
 =?us-ascii?Q?Yprvpi02qBtF+E4ILcgB4crIL+DJbYPG2rANLhu5zcJdgjtfAi0TwdD+9TIg?=
 =?us-ascii?Q?g28xLXwapCmKA9DLtfJRimoVHF+PPLzo1X1zkm/RwN/hjRlHLHPcmJYL+3bc?=
 =?us-ascii?Q?4DGJ/HYL1dndJs1X8ytfTcUC746SAZ4iNAtfZq9udIH9aYzCYbEs3lvyj8UW?=
 =?us-ascii?Q?sBs1jq8gE1V3F+sGRnIEA0vUr1fQnlyphe6iQPKCqgQec9q81XtW5czEhFcm?=
 =?us-ascii?Q?VjINLTLuHe44i9CPPhXAhWN6uxx9yZ1KWKmOy48KldFI/CriUmfY32/Pdx93?=
 =?us-ascii?Q?Ndutig=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e65d33-fb0b-4931-2206-08db826d6c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 00:17:47.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dezigD9VKZ63a8lYk3tjikJUdfrxtbfPT9U381E+7KGIZdlroxAsF6p0Rahr/3U6757Mfx3Piqfpa0TOHOwvsBsf0f4TqvBlWXzWi+G091v1CvwcP01ksDOIdZ9Tvd9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Serge,

> From: Serge Semin, Sent: Wednesday, July 12, 2023 6:03 AM
>=20
> On Wed, Jul 05, 2023 at 08:42:02PM +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe endpoint module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  .../bindings/pci/rcar-gen4-pci-ep.yaml        | 106 ++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-ep.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yam=
l
> b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > new file mode 100644
> > index 000000000000..4e6be856104c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2022-2023 Renesas Electronics Corp.
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
> > +    maxItems: 6
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: dbi2
> > +      - const: atu
> > +      - const: dma
> > +      - const: app
> > +      - const: addr_space
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: dma
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
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: core
> > +      - const: ref
> > +
> > +  max-functions:
> > +    maximum: 2
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
> > +  - reg-names
> > +  - interrupts
> > +  - resets
> > +  - power-domains
> > +  - clocks
> > +  - clock-names
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
> > +        pcie0_ep: pcie-ep@e65d0000 {
> > +            compatible =3D "renesas,r8a779f0-pcie-ep", "renesas,rcar-g=
en4-pcie-ep";
>=20
> > +            reg =3D <0 0xe65d0000 0 0x2000>, <0 0xe65d2800 0 0x0800>,
> > +                  <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x1200>,
> > +                  <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x400000>;
> > +            reg-names =3D "dbi", "dbi2", "atu", "dma", "app", "addr_sp=
ace";
>=20
> I'll ask it once again since you didn't address my comment in v16 and
> haven't fixed the example node in the bindings:

Thank you for your review! I'm sorry, I completely forgot about this...

> I see you defining the dbi2 space as <0 _0xe65d2800_ 0 0x0800>. But
> sometime before you mentioned that your device has the next CSRs
> layout:
> ! +0x0000 : Function 0 (common address in Root port and Endpoint mode)
>   +0x1000 : Function 1 (Endpoint mode only)
>   +0x2000 : Shadow register for Function 0
> ! +0x2800 : Shadow register for Function 1
> it means the DT-bindings example node has the dbi space defined for
> both functions meanwhile the dbi2 space defined for _function #1_ only
> (it's 0xe65d0000 + 0x2800). So AFAICS either you have wrong space
> defined in the example node or the node is wrong in your platform DTS
> too and you have a malfunction end-point mode. Am I missing something?
> In any case based on your End-point driver implementation dbi2 is
> supposed to be defined at the 0xe65d2000 base address.
>=20
> Am I wrong? Could you clarify this?

You're correct. So, I had investigated this topic, and then the current
actual dtsi file has the following about the reg property:

+                       reg =3D <0 0xe65d0000 0 0x2000>, <0 0xe65d2000 0 0x=
1000>,
+                             <0 0xe65d3000 0 0x2000>, <0 0xe65d5000 0 0x12=
00>,
+                             <0 0xe65d6200 0 0x0e00>, <0 0xfe000000 0 0x40=
0000>;

After that, the driver could not work correctly on v16 patch series.
So, I had investigated why, and then I found this was related to
the dbi2 offset. That's why I added a new patch [1] on v17 patch series.

[1] "[PATCH v17 07/20] PCI: dwc: endpoint: Add multiple PFs support for dbi=
2"

Anyway, I'll revise this dt-bindings doc too on v18 patch series.

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> > +            interrupts =3D <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "dma", "sft_ce", "app";
> > +            clocks =3D <&cpg CPG_MOD 624>, <&pcie0_clkref>;
> > +            clock-names =3D "core", "ref";
> > +            power-domains =3D <&sysc R8A779F0_PD_ALWAYS_ON>;
> > +            resets =3D <&cpg 624>;
> > +            num-lanes =3D <2>;
> > +            max-link-speed =3D <4>;
> > +            max-functions =3D /bits/ 8 <2>;
> > +        };
> > +    };
> > --
> > 2.25.1
> >
