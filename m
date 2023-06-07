Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0977269C1
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jun 2023 21:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjFGT1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 15:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjFGT1G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 15:27:06 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0F1BA;
        Wed,  7 Jun 2023 12:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJF2nlqdq6NRko8fA0Ea7m1+1om+mS1TD273ItpIn2Q2yZmS+LcUSJiyxzF90r8S0ydMnzQdlGHx9mzP/1VqXHGtdxmjjWyJNp/LhMLFTYBJSuJuSnUOuYheCLv/My8d3Dx7fidzmZYGitIC5bTtBj3P7+n13brIToUAfyMhfoICRub4LftdLWPcXKvWL6KEuZGfk9/phSQGdOiErPYQpsuXdF6vVkJnLCibdiG4ETN4+X/zQ5XaodgChGhhWmx8Trf879/FbDvN+j7o3LLzNYFgNCJYyz90fFM+k+2p3DGJtG3S4VD1jOYXoo9/4Lt9ilBYvP3p6WHAkG6GdnYiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuLJKCRlRw6CbrDj9Fbp0gaHjGT8nLgvQsqkJrlgW+g=;
 b=MxFxsOBgc3MenGgvoxwjDpb3UmFCVUro9hf6lXjtvrUPbLgthclXv0A8XIhBRMU9JyB/nXVJ+cUaMlqKHSNl8SuocpG68Z5aJTljWdUgPKoXCpzQXFkqcwNaIxAcxdxkg1Q0mp/kzniuKA6E+kWMy7ngLd5yxO2aG3ZyIvDTngc/NI8Z2RHGFELX0irxZrG1kyLI8IUkiZHmnFeTQLLsBbUM2wSARE3tEMz2A6racgy1uL1L9rXLtwliSpy/HkPv8W9HcBNeesgalgUwrbDkmEPJLPs4F/vyZoWn4N9ul08igGDuKyRYu8sTTa3VV4vvCWx7Wud8NlwMxM/OL3kc3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuLJKCRlRw6CbrDj9Fbp0gaHjGT8nLgvQsqkJrlgW+g=;
 b=nQKS4YBeH+00GCi32keRmDFPChl42jm9byiw+xfuquX6olh+lQKSLOO8vw398IYBGRKkPwi5t2y0WQ6mNLVzKalRae49uInrv2ORz9ogNNi8pOgML0545RiDwOT0Pe3WeMOQV1nZUDsNpkXQm2KYdmZnHnO1KOHMFy0jHU8O87I=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB11136.jpnprd01.prod.outlook.com (2603:1096:400:3f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 7 Jun
 2023 19:27:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.039; Wed, 7 Jun 2023
 19:27:03 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: rcar: user proper naming for R-Car
Thread-Topic: [PATCH] PCI: rcar: user proper naming for R-Car
Thread-Index: AQHZmXVcTjURB6egr0Gdn6RHD9qKca9/uDqQ
Date:   Wed, 7 Jun 2023 19:27:03 +0000
Message-ID: <OS0PR01MB5922792E5FAD151BB18D1EE28653A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230607192144.27190-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230607192144.27190-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB11136:EE_
x-ms-office365-filtering-correlation-id: fd03d7cf-16de-47ba-adf5-08db678d2c8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BKfyy+AzHye8PQmW5YnBVZr4aedlMfo/y2H7CmG+juOSO9hObw7aPgnGvxpIjnNsPOF4pkg6vzxiaFg4NQ30wpxAEzAiUupNi0DSTlHX+HHU6JmJeKcIwgxXS6hUlSohJavgqxl0S8RNvQDoC8cL4XVMDd18j5Qr7mvN3vQyp0Z7cMK6jjjIBWVsUY0O0fvep6MoOue3fFnkvd+KCMG8RwIvL7UZhr+97PDKRNJNAd0uvLn0DLPbdFb0PS0tcRGL6a4u3q2x2bZcypn8SnK7EHO3MnVil2mmwSJCJQIJSNWCRRat0dNs7xbqVLLn2YeOVKbDulRFtaZFXeKg2bf9kHhpzdWnE/wq0m+jcPVu5lf0elKJrTDHNQRrqRNowEQjuFoLOQpvGEu+6BbfFw7zV4aZ+dmlWQOAcfS0lzgj+T+gN4+bvhXQlakEMkGmPhYWJDFQf6B50EljxVGG4KM8jDeQHNgitXVaO/4d7s/6CDpnRXP8SNdLTZf1HBUVBcvxBFVJgz8Ht/lhfq2txTrpAXvjcWPlilxweGAZpU6SDtXEvf/awb0rCdoE2AJzWIHAfmIKxsdMSTjGJK8J56eurHLKLjqKRU8qmt6rQFLe6xcNsONrwEWdNcAR2wwyKSRL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(26005)(9686003)(6506007)(83380400001)(186003)(2906002)(66446008)(64756008)(122000001)(76116006)(66946007)(66476007)(66556008)(7696005)(71200400001)(38100700002)(52536014)(5660300002)(8936002)(86362001)(8676002)(38070700005)(54906003)(110136005)(55016003)(478600001)(33656002)(41300700001)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?17wXAwbFRmUNOgeWSd3LcXclnmZW4TgscIRYXjYGAr3jwKgWjaWC+7LFiQ?=
 =?iso-8859-2?Q?+gZHu0BbS22XgyGZJ6A9ME0qHgqV8Fg3lVn2sL2cYkI0P3IQ7O77Rt624j?=
 =?iso-8859-2?Q?3le/zoPIDkzL5zifW8QSNbRAgE7Q6B9EtVFLQy/ts90XbVQVBIh+H8+Taq?=
 =?iso-8859-2?Q?SxbZKZPbq8FqYKj4BsXGzjl4sHTYXG5jZIt++m8S0c7Ql4F1s27vVHW9OO?=
 =?iso-8859-2?Q?rY9a7vnl0bd7Ea5fogeYQYHrzyXXI6EGQDfNRG2nXCMq/nPp21oy6uq1C3?=
 =?iso-8859-2?Q?UYWOeJV41kL9rJSm2YUfnA+LS+2zReunSc/wWg1MxbypbB9jd9XRVtFW0i?=
 =?iso-8859-2?Q?C8V0DQLY243Moj+AcxDip8URB6HDBYnoyG8wT6V/Fh89gnzF5egyb0Fyd1?=
 =?iso-8859-2?Q?xIT/vc+oxqFs9UO2KJMJC0roOzV1ESXSRwRxAkIKT7UsYDPqgo8z0gJCK6?=
 =?iso-8859-2?Q?kpyp3PHKr26qFsP/cZwW38s+S5qVP4eW9Eokk5rNZWf0votewJFJAJRchj?=
 =?iso-8859-2?Q?KZuBthivdSe6S5AF+qifGAfitA+RJOTHNxdMrtDBst5JSSSbcONhOh6LNr?=
 =?iso-8859-2?Q?7kxF7QbMb3Vp9tAnkV/sCvWzyDRHbGGc+37cuhGq+Sn5v2evSa0/mYivNO?=
 =?iso-8859-2?Q?VzdQRHD4L9zdQuRupxErgpWLPdoyce/OFuHnviAfvLVFnmBkTSzAKqT1b6?=
 =?iso-8859-2?Q?Djxh5HgaXvmb3Xa+4094A7e45KOBWdBC1Ay8vQ/DOXIVB1gNxaLci0YqSc?=
 =?iso-8859-2?Q?kFi3q0chyN7v4g0Z1eVvmiyR424Pmfuih1WdKoutehubrOGdpmA24nzrbI?=
 =?iso-8859-2?Q?6/NtQkIYaNqbWCYtdsKgp6JfaRcCRAjp34PFJd8xmuDOLxsmuxVrAnuI3V?=
 =?iso-8859-2?Q?R7zGtb1Y6jgW7+dVoiJTab+8b0IrPhrJ7rnfjO0Vo7mHFzpPrfzTirrpwx?=
 =?iso-8859-2?Q?rAceuPgfzZ5769Y1eNfHaq6aa4/R/wt8YaxKEnE6y9m9CjLIy/ScRNoa0H?=
 =?iso-8859-2?Q?TxZnGW9NNCj+UmHZa2alO6bZp73/1BkiPQwp2j/BviqsY153BXKMzQXKOB?=
 =?iso-8859-2?Q?MCiGfrvUkXGIG5x4c9hOY5dlMlRAL9nswL2P72F/N3WT6GXlwg/az84Ig8?=
 =?iso-8859-2?Q?Q3PlSCWoHHuBPQP2gYuipDOymw3X1MHht3P+Y1yuCQ8vz/1XQeMcTdZHVW?=
 =?iso-8859-2?Q?ng7KYGRwuEx30vzpNIml1j1NLiVL/OS3WhTa9JTFkjysgOWVoLIFqa1bui?=
 =?iso-8859-2?Q?jFv9pX6TiSljp3aGK0xRreIHE67irgmjH+YJSWKEcfdlEJBeFyjgg2mglw?=
 =?iso-8859-2?Q?d2CzFQTsRVAph1y1RgzSYDFgij0HLuonl+TVWkJzJazWunW3PL2Yo90aZf?=
 =?iso-8859-2?Q?cHDyc/pxzBBaNpJsbKHCdX8lVMpl4NADYPzSOKIthOeyAEXCyAoCXf0/ly?=
 =?iso-8859-2?Q?eTljp/lUvqtFX2ri+xm1x56mXGWYHrF3zGUEzEJcC1iccIxJLVMa3vnhR3?=
 =?iso-8859-2?Q?H1KqnI4PBAFD+wFTit18rCMlMy1CWItZXRQLhBt8vy0m/VPFGUXwKqDJ0m?=
 =?iso-8859-2?Q?DpdgbJkjwW0W2OzbthDSG5J1o5T3uP8BnJthKd2kSax9RyOHchhTqlDDdV?=
 =?iso-8859-2?Q?nxHF6LVVXaStsMNbzDxfvMq9tAad7atnWx?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd03d7cf-16de-47ba-adf5-08db678d2c8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 19:27:03.8005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Tr3xuScYuZoxWYKch66Rm4EXyW4Yq/nRtAA68DNv8TJqyT+BoiiyApLN9Y/oCrOleIj4b+AJjGZAWAccFNxq1EP6gBIX9PoF276Sm3ajD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Wolfram,

> Subject: [PATCH] PCI: rcar: user proper naming for R-Car

Typo %s/user/use/ on patch subject??

Cheers,
Biju

>=20
> Neither RCar, nor Rcar, but R-Car.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rcar-host.c
> b/drivers/pci/controller/pcie-rcar-host.c
> index e80e56b2a842..f4dac8ff97cb 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -684,7 +684,7 @@ static void rcar_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)  }
>=20
>  static struct irq_chip rcar_msi_bottom_chip =3D {
> -	.name			=3D "Rcar MSI",
> +	.name			=3D "R-Car MSI",
>  	.irq_ack		=3D rcar_msi_irq_ack,
>  	.irq_mask		=3D rcar_msi_irq_mask,
>  	.irq_unmask		=3D rcar_msi_irq_unmask,
> @@ -813,7 +813,7 @@ static int rcar_pcie_enable_msi(struct rcar_pcie_host
> *host)
>=20
>  	/*
>  	 * Setup MSI data target using RC base address address, which
> -	 * is guaranteed to be in the low 32bit range on any RCar HW.
> +	 * is guaranteed to be in the low 32bit range on any R-Car HW.
>  	 */
>  	rcar_pci_write_reg(pcie, lower_32_bits(res.start) | MSIFE,
> PCIEMSIALR);
>  	rcar_pci_write_reg(pcie, upper_32_bits(res.start), PCIEMSIAUR);
> --
> 2.35.1

