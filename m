Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897396E3D1E
	for <lists+linux-pci@lfdr.de>; Mon, 17 Apr 2023 03:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDQBKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Apr 2023 21:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDQBKS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 Apr 2023 21:10:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2127.outbound.protection.outlook.com [40.107.114.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB5D1BDF;
        Sun, 16 Apr 2023 18:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq5PA/l26yVOkwBE7BeqK0ZHgyDfRjIovvJEUnAftjicGWU/6l5AZiPyJiDdulehQwJjL1RXqj+Rffe9aaRv34ma5SviDLJALTkBKuiGUqTKkdiKe/eKDu+Qrm+JzAe5HdwvqD/1MU+jCDt5bpZrB1cMPkHb22y0OiW0j1O0ZImzcoy3zKNMj82p55mVjD9H8alQxUjso+2K1LIGB62lRz0AiZTROK8LpzXSKcEYghTnVEFootiVNOeZA5fBEJGGViNHkGSbgTU2M+FtQE1V+NPCM5G2FB+p6rqi7QwidaGcEW9YO6p1IXgOiIvsHHUUG+UcmTmxSQ30nFrd3EmsAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRCmVREDJyfqq6Ywr9h+nXJukrFVLND3kC3MGC3welc=;
 b=Cdd8xs1KJ0FIaNQkK7iJrjrDEQdZwerZDZGxVCEUWI0nif7YT+Ls7ut8FOaquHptD4vsKnZF+Qp+a+9Jrm/QLrXzkeK9Pj5V6h7hSRvi6/TLWqtYRpKRlyQ0Mfg8W8SR1ujArsYXa1DzFdxLpvi9lH56ZUbDBH20UOYX1eqlxpbYZFvaRpVvIHiTM+GoV43wMpJWfYC7jZHDZz+1m8H1nURIS3wog9Wn3Yiw9i16J6YozgcRqWyzOTqdjOIgJBW9ROPhMxR45T+py0lpGkwzBskbWSsmwfsrEUK6iGdy2eJpdPtJYF/Xv4uriPrymoUUT4WRyt/BC3rAo5iGEmLR6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRCmVREDJyfqq6Ywr9h+nXJukrFVLND3kC3MGC3welc=;
 b=Cd+E+m5AIct9oHuwZn2UnX/PbAKTeHtgnBRvKi+ishmAXA6eJ6jtGscHd2kiIhdT8JinMQdE3nzkyitlKbbqeApsL4sjBE4nwJWtalD49kfkbycEZL4F6SZveQ7ulF3bnFUa2vYiIJymbM440ih8AHnt6G6ARsusT+LLdNM59ec=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB10901.jpnprd01.prod.outlook.com
 (2603:1096:400:39b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 01:10:12 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 01:10:12 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     "kishon@kernel.org" <kishon@kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "kw@linux.com" <kw@linux.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>
Subject: RE: [PATCH v12 14/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Topic: [PATCH v12 14/19] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Index: AQHZbpiqkLR44cXcJ02g/329xV1Oma8qvnKAgAP2kPA=
Date:   Mon, 17 Apr 2023 01:10:12 +0000
Message-ID: <TYBPR01MB53412CFDB006959B56A6D623D89C9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com>
 <20230414061622.2930995-15-yoshihiro.shimoda.uh@renesas.com>
 <168147484959.3576429.13497930996151330300.robh@kernel.org>
In-Reply-To: <168147484959.3576429.13497930996151330300.robh@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB10901:EE_
x-ms-office365-filtering-correlation-id: 1a604cc7-09d7-4315-cda7-08db3ee07ede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Z1WYLZpOLxRSdvIq1jgIlkxKF6GQDsIci/a9dFUwndXwGRONA1KCR2Pnuhom8EcbPPUvGYCHb0PV6BbLrMJyiDKNvbQ0BPCELovjBrAvQUSjudUkFiZnAJ6roklY2FEYl9xB9BfdJsNk5MQ0I7+yLgkn/KZIO6TEZjMLZfcKeetO4t+NGtAjloXb0if58Vf4bBXxGfWRdwfhJTkKHJB6JlJOOQ+VocntNJZqm9Sd3RQidWZ4WXoNORHfTabX4kH+Ivne2yeFXujVrMbWrt3o18COMew2wOeo30rQ3pjEg5WACk9MlxLI7PsWvDjCU0pjbeIDttP/MYSi0pjUeR8yZUAKoVE5XQX6zTSbRd496Op5K0gR8T13dpyDn9NvoWHbRHADlc/gSc+PKCbRpQbb018RQWVQ3rhxxhiEB1zGMXusHqtfcn1p7+BfCnKA6v6eQLc9GwcaOprTm6YufPBCWIALCaf+jjsoY/+/sxs1CeS9cAuzIm33fG9STOWrg25+9HJRhBgNMlZFNb67qrU4CaXi5p5ISp5RkrHyT6QX/0q4OMy+0XwbUcDk4iak1rNarjMuyyGDtMhEqP+tL6mIi7Yzjj497R/BqNGNR3yb5tB3mRCKBCiv/2I+co1pAqC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(7416002)(5660300002)(52536014)(8676002)(8936002)(316002)(55016003)(41300700001)(76116006)(478600001)(33656002)(54906003)(71200400001)(7696005)(186003)(86362001)(122000001)(6506007)(9686003)(83380400001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jKoVn0i8cEMzPjzpY0AE3W8kSUdq9iR3931dvWmK0D7x9YEqpg4qy7/vZ7kK?=
 =?us-ascii?Q?RuSnRfeR0WsS1oWyhsO0fjn3tdpqEiJ3xfKlhrAnnPyRsuOgOOhXUqa1Cf+W?=
 =?us-ascii?Q?Uvnt5bbHJAwWfBZRSJHk3UWsyE+VjOAke0L6jeiN8puieugM0BaA3jRJvKLx?=
 =?us-ascii?Q?Nk6DU3DZJ+fR26Q5VWrlz+AcnVVWN8HnI7KfYgqSOoP0+EMTgp8vGHlxMz5r?=
 =?us-ascii?Q?wRi6Y5BWSYDijjwF5+tYhNjmyoMazPAeTUgD1MIKn2F67UfzuYbp+ccj4zep?=
 =?us-ascii?Q?33CAeeCoqJNdEoqLB9lRRLvrrgnx12JKo87PxOymyjyRPaOX9xRoA5zEMl7m?=
 =?us-ascii?Q?F5zoYT+jZuyeH+pGdouaH7ZjsHlOjTng1ILj4Ie3SG7rdj3SrckNZYBOQ35n?=
 =?us-ascii?Q?AFe20t1iwyIveHDJ7ijlIF6+mWbglc6VjRUnR2UiKatWb+e/cbJx8OXAUQ0L?=
 =?us-ascii?Q?eC3AXZaTesgWnX1ddSM1WB5hbaQ9qpDb9pfGKGEp+XZPHW192B47OGyyAsBP?=
 =?us-ascii?Q?yZN8MhMDmXojze0PXyrV6k+Wa+yRECGFhkXzCi27OBC+LSc0+4/ffMixje/U?=
 =?us-ascii?Q?cIz0kXTNy5Sh6bTCoelJ0LwsPszGSEL96vSiBxW8u62PksPclzzGTVAjHFUI?=
 =?us-ascii?Q?RcsqzZRPB9Sfqx1D53ymDVXgbM2VYINZIIyKYhE+Or+3GDHxvkWhQRmfrXHq?=
 =?us-ascii?Q?JH4JisfudQq1jl9Bt7gtyOggeVNqvDT+X+tAby0w6P9opyx8OnpYNkYT920m?=
 =?us-ascii?Q?SE1kIWdnSC0T8v0ygQR7LL+RLOt2KOIcbjOAM3B3qx6cJ21R1aG6ODkgJk6K?=
 =?us-ascii?Q?RMImg4IXhs48tNuvSQZM+9GwcPM7XW9b3jzplBMVs1KljO62wzdRVpGLG0np?=
 =?us-ascii?Q?p8dBX9DP665UINpYFHDTADUvzwg40XKOik8s0gZsw1d/7pnLtzGLQuMDc3kS?=
 =?us-ascii?Q?ZtgAgiRiimbPzbjY+kVkwMguSMlDkrUDVk+jVtfLNLwfuMCHUB6iDFOo2K8z?=
 =?us-ascii?Q?b2rwxja2bZ7EOmWvlsZosCgzAaGUVbr5aQqZh6gMYGy2BUJkTlOFiRtjF5+7?=
 =?us-ascii?Q?M1+m0YswmW32FyfPzkdaMg1k+DVwJMTxj5UjgTqwE7y0WjikDkoqY8cC2O5o?=
 =?us-ascii?Q?TewerBDZMLzbMhI1soeT+T47QTtHWuXGPGQpdIKB+7vz2ymIioLku5wmtoc8?=
 =?us-ascii?Q?+2ukXx1v2BSyJjSrnNdftViJg2qQ3QcaKwT48q6bSfx3nfH7N5CDs3Kkb/oq?=
 =?us-ascii?Q?HjLRHJN2oGYa5xAReczt4bEht6GapIoZX6hFef7rEJFe+ArK/eyxwMKa/Oia?=
 =?us-ascii?Q?AIwjcMp8aTylul0afd7xZb39Z8GDxE0ULziYfQQN8cHksrFf/717vDO0rnnK?=
 =?us-ascii?Q?T0Xs99cswVwcFZFAYkAcQOQ/wCzncL0Vfpef0a7/rXRNMjU+NwxfyB58GrBR?=
 =?us-ascii?Q?/H28zzQhvO/e3kBQaoTRJt7mUFqVSC/z9ZABXfl07f0WQMlNQE1dWEkwtVR2?=
 =?us-ascii?Q?wWF/ohjYw5xHzz7m78PEWwUWVgQGxVAzbiMZdEz1cTdNFbyCA/bLwtQlBLoB?=
 =?us-ascii?Q?WnIhMwWQX5h18g3Sv8Z2Y+wUGNc/1p9FZT8wSP0uNptil3AJSjRAj975Rh8S?=
 =?us-ascii?Q?I4Xcav5bBNbtxCQGO0pPYnJcyixUrzJaxwUA1ojMw6JvHjOdNbHGfgUhgy0s?=
 =?us-ascii?Q?jdynXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a604cc7-09d7-4315-cda7-08db3ee07ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2023 01:10:12.4957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLDYgleDRIg4g28FgD3Af1UHhwEthH9r8tq4gJWlemkSqEQd0TDlpuwRF+DhQlQBBKTeXPlGpylr2tV7ceYL4w93NkzR1ENeUX4csy60h07w5oTo5f664ydygx1BT+dT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> From: Rob Herring, Sent: Friday, April 14, 2023 9:37 PM
>=20
> On Fri, 14 Apr 2023 15:16:17 +0900, Yoshihiro Shimoda wrote:
> > Document bindings for Renesas R-Car Gen4 and R-Car S4-8 (R8A779F0)
> > PCIe host module.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci=
-host.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.example.dtb:
> pcie@e65d0000: reg: [[0, 3864854528, 0, 4096], [0, 3864862720, 0, 2048], =
[0, 3864866816, 0, 8192], [0, 3864875008, 0,
> 4608], [0, 3864879616, 0, 3584], [0, 4261412864, 0, 4194304]] is too long
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.example.dtb:
> pcie@e65d0000: reg-names: ['dbi', 'dbi2', 'atu', 'dma', 'app', 'config'] =
is too long
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.example.dtb:
> pcie@e65d0000: Unevaluated properties are not allowed ('#address-cells', =
'#interrupt-cells', '#size-cells', 'bus-range',
> 'device_type', 'dma-ranges', 'interrupt-map', 'interrupt-map-mask', 'rang=
es', 'snps,enable-cdm-check' were unexpected)
> 	From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
ci/rcar-gen4-pci-host.yaml

I should have revised Documentation/devicetree/bindings/pci/snps,dw-pcie.ya=
ml about maxItems of regs and reg-names.
I'll make such a patch on v13.

Best regards,
Yoshihiro Shimoda

