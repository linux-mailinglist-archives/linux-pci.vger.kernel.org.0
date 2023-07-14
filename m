Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8551752F24
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 04:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjGNCBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 22:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjGNCBY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 22:01:24 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C4626B6;
        Thu, 13 Jul 2023 19:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0qgapEN5dQ1iqLVOovYjF/4/GAL1OcLrUKw/mbWWkfF4QPlx7IpHeZv17PNx4JnOdaH+vvGA0IzZ8cJUeEPjpixDYqIq3oQ2F3OIoa1X2BT0qJ2Qox+XTye4cMooM440zmOU+IseJQ6lSLCKdYFMZRO/KZKlg4yyo5WN6fg0acovpPIPBB3sHcIWkmbM/09dRsCRadofFtJmczzx3KCgzsBjx+I96KsY2Ap2DshAeKesihW0CvX0tRqlX/Eqn121pjdTmtt8SXP2fJMNUZDV8m9sDYwbfC06VYdudT8/akkVHC7fnkxxuJcXkjpx9m5MxjEYaHxQnvqWbZFGCbxdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sB5pwsko/Pk3wIrEiT4JFeeeZfkrtkOO5JKL3fKdHEw=;
 b=NKKgTRFcJF4Nn3TSCgxdEVOekbT0UA92E3oL48uqNRDVYe++Z6oYct26hg0VlcmQ2GaVY3iOdwPIurC2VBpgXnwKUvb0JKfHBhtaLRcEQJgDiCq400TMzfwFmOhAXRpjwSlIhfncm5e1ymorje5YDPvG3/F2crQroyaXVpBRRIzCi9HydPc/k1FSKMrt5r+iVnaEYMQPkQpy62e96MkcJUxNcGOVBpP9rCyYG3g5kmrHuFgzHR+0v5zQjn7rMbX1pg8qgU8I6jr94loeX1MFE/B6mC+ldDXh9Z0hiVUzcIqUu6uShODKdfSnnXhO7/QuTGWWgHSLa3nNNjQNSiV4MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sB5pwsko/Pk3wIrEiT4JFeeeZfkrtkOO5JKL3fKdHEw=;
 b=ILqpI5goPCZrlKMJgm5NT/3G5C3+3UG8HUR41n2ApfspGBLRNiUUAXx6pcsKDpj+wrCjrtb2ny9n0SKXDBChft25SP3kmJmAcn24ZZZCZ15ThVRA5eAzpMGvaQS4kFW0EOSB8REYb3SMFv2VvEqDA7lgArICIg9IhtFDUh/MSi8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSYPR01MB5447.jpnprd01.prod.outlook.com
 (2603:1096:604:8f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 02:01:17 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 02:01:17 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v17 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Topic: [PATCH v17 07/20] PCI: dwc: endpoint: Add multiple PFs support
 for dbi2
Thread-Index: AQHZrzZNt84IwuKQM0mLGW21t+tZZ6+1DwYAgAN/NFA=
Date:   Fri, 14 Jul 2023 02:01:16 +0000
Message-ID: <TYBPR01MB5341E825A7FFE163CE2364D4D834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-8-yoshihiro.shimoda.uh@renesas.com>
 <j4g4ijnxd7qyacszlwyi3tdztkw2nmnjwyhdqf2l2yj3h2mvje@iqsrqiodqbhq>
In-Reply-To: <j4g4ijnxd7qyacszlwyi3tdztkw2nmnjwyhdqf2l2yj3h2mvje@iqsrqiodqbhq>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSYPR01MB5447:EE_
x-ms-office365-filtering-correlation-id: 5cd44a47-83a6-4074-13f6-08db840e35c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TSFh19tDaqn5oIE4aCJEa0uYE0tpwPIsuLqJz22OZIFkryESc8TmWZwQyxWkV6zHUaEQv4NcNCu/9U6/mLYNRzdi63XKO1oEXQ6wOD1AY8kizI+lDvO5sRlzFtDXdtWP4pzMk5Hu3HSxftYKa3Wzpq5SBtJ5yp+Hjr/6lrT31UvgydOyhe1znNB2oZqAnKMvk0eYeVi3UNFkpV9kDQb/sSReYp91dEokAINeGIQHzayIwMwHdxALuvDuTh2vM1gCQoI/XQb+rgV6L5Q7//v6QxD6IRTj8wE3+GFdK6frkgST0z8EFswsqlAZj/As0sYZyWDeBwfcpKEsZQBREnz2WQ9sRE+vahui6cA09BDFAGc9M0kzgbACQPHksi913RGQhCoUgwzbzYM7iKOYxGlikJmESPd4SjSl4b3FkRmNp8cDS1xzuTr9FtCZsIO7sZY+Y58zKVMYZGEWwFXO4JR6l6hRmRlzRlzD5U79zAOiwSLolW2+2DjcnsTVewsdmwzH1JjD2Ulese15Pg0QhArxN33CschCvCwljWEpkchSjTPAu646pnGQJFGE7ksyA7qwHvjFcn3XKoYCLCYwOGRqZgsptAXvFFvN5ZrJnY4h7639AkoQnwqE6e+Hd4UlBL83
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(54906003)(110136005)(41300700001)(55016003)(66476007)(66446008)(64756008)(4326008)(76116006)(66946007)(66556008)(7416002)(478600001)(5660300002)(52536014)(2906002)(8936002)(8676002)(316002)(71200400001)(7696005)(86362001)(9686003)(6506007)(186003)(33656002)(83380400001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?PiS4U2lfvwvrWEJylg5m5Max5hVIvB7aptzPBcd9XEvvSTZfY5aa/6rN6+?=
 =?iso-8859-2?Q?HxKwtF67TAf9GV0SwQ76477X5/v7478XKnzS/JXJqy4b6m2NTx2mJ8haYp?=
 =?iso-8859-2?Q?x6TLhCpx0p5L1F1aHjt4xH6LqyKFtZMTBEf5mKk6LMPQW5GiL0sVWKsD0O?=
 =?iso-8859-2?Q?gKK01Ubi+BBltKzihT9Q707JTn3yTpumeCaUubY01+941ZhCza9Iwqjhrb?=
 =?iso-8859-2?Q?O0EEqdLPuHf5ckxWvtEp1CgFqDLUoIC57NzMpBYp244cQEBra2yeCVVctM?=
 =?iso-8859-2?Q?OO6MR5bO7x+pPgIecheoO5tm4QdRA3vqfD8MN0IloYTmodksXAfh7twiYF?=
 =?iso-8859-2?Q?jMp0Ju6NiVKLdsrL6e1v3A2pRHqEIJ2cl12xZInbgrj75aEecnpeaaR/HH?=
 =?iso-8859-2?Q?kLNjTot/udLotow7oehrREpj/lv3fBbIvHeiPeJpSb3GjsQlbZBjgyZ3+/?=
 =?iso-8859-2?Q?ZzbjaigGQ3WFvn3agqTWlRcsi3leCmdXFo0yL4gEKN5b9YVxlFXsIsE2Dy?=
 =?iso-8859-2?Q?1JNritrmvCHa2/xlOHu0KhCIlPi3C9gig+HyCpjdaNQEmUK2d3Va6W54Q/?=
 =?iso-8859-2?Q?msLUaPq2or2sI48KfsIACn0wOMWIylymxQYIf5ME4CcqNn507PXXTLwqld?=
 =?iso-8859-2?Q?fUxRCqpVcuGAWPzAbhrpVvmW1/8o4+ErFZRFfs6DjJ8ocD1rAxSAyjYRlF?=
 =?iso-8859-2?Q?xaiOZtTAFZ/e4vgYPZyYwwWSNeHEZv+VneEEkpK+5soI/6cHdDU3xCyfC2?=
 =?iso-8859-2?Q?cLTbNV85gacbea/sLVZ3NfvswS6fqT7hpufgJlda8iKg1MqfPbAOElzOu2?=
 =?iso-8859-2?Q?rIA6zNLym5JBjD0QqaylqxuoXXL1TJtRELo6mXzdVfvcyUXobJIjZ5ogPt?=
 =?iso-8859-2?Q?1zPeAVa+5tT3VYbw1i9APBewR86af9N00G7wSC1t7uDy+TZWDuuz6VK8Rd?=
 =?iso-8859-2?Q?8iQ+TdV2UnMvUVAwjmWiWJSzPzov4H8sqPM4DI5ZSscah7Cq4WZM/qG+as?=
 =?iso-8859-2?Q?4U8a3T5DR2ZpciUibEMg4mmD9t2MG1nTjAUzaqnt2INggj9SMBS9jhkV7T?=
 =?iso-8859-2?Q?2d6X8+JUU6Xap+BWh4YAavYHW79OPdVZmyvRiT/kZiCGz0dD8z5Bpm9R7B?=
 =?iso-8859-2?Q?H1hgVVM/PduNnuYPkfmeRopWIJlazIyKfqLahLUgCCT0l6G6/rBrUXrihS?=
 =?iso-8859-2?Q?lR1JXRQZCPggKm7TcCXJqsTa2AcAT084FJfLW/RWucbxF90r0ziPl8yqZm?=
 =?iso-8859-2?Q?0cQunLLywUZzhIZnl7YO0M7uG8LN2wqEmi3D0XNE9v3sqpTtkHJuGfVj0b?=
 =?iso-8859-2?Q?wbhBWFVON8xjk6W4KCzPXg4Bt/LOuH3zzmU9LIecpgoQDSk/nM937o/H99?=
 =?iso-8859-2?Q?KwG4koCREEoWQcO4qaATYsX6qxmtO9DIn+IqpQAtNPtjhkufb/c/osi32s?=
 =?iso-8859-2?Q?qrM5gVLDFzZ/BeZgKJoS2LAwtvGOGGKP8Tg9BRa4tqB+1mCcpAeeAdwmOf?=
 =?iso-8859-2?Q?p3wluoal68exJOiZN24Z6IQ0pLrgGGbnX/bL23Hmsoub+6vPyZmIssYV0+?=
 =?iso-8859-2?Q?79ZnO7EqM0YDi6Uw/tWhU77DykfQPgzxwvGCzw9/srcrC/s8xrWUn+ZaLT?=
 =?iso-8859-2?Q?v5GjhdwbzzVtL3a5xvTmRCmslU34zrrzefsI/8RkJXJWoU0KMxQ201OFTx?=
 =?iso-8859-2?Q?lY+tiVPqHiiGKOZ46NVTCZyheH0/Y4WTpZsIYYVr50npkkR6XkcsKN0vHS?=
 =?iso-8859-2?Q?ty0Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd44a47-83a6-4074-13f6-08db840e35c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 02:01:16.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIJfq3xTXZ6vYJ4zgC6/Rlf0eYUcscLvSNYIFoSLdatDvg1Z9MWGlRn9/6zEg3AdCq03fbDXY1jomuJ1nU16O0gCHF079A47d5Z8LqOypdmujf3RR07xb3h0hcRLh8hr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> From: Serge Semin, Sent: Wednesday, July 12, 2023 5:32 AM
>=20
> On Wed, Jul 05, 2023 at 08:41:53PM +0900, Yoshihiro Shimoda wrote:
> > The commit 24ede430fa49 ("PCI: designware-ep: Add multiple PFs support
> > for DWC") added .func_conf_select() to get the configuration space of
> > different PFs and assumed that the offsets between dbi and dbi would
> > be the same. However, Renesas R-Car Gen4 PCIe controllers have differen=
t
> > offsets of function 1: dbi (+0x1000) and dbi2 (+0x800). To get
> > the offset for dbi2, add .func_conf_select2() and
> > dw_pcie_ep_func_select2().
> >
> > Notes that dw_pcie_ep_func_select2() will call .func_conf_select()
> > if .func_conf_select2() doesn't exist for backward compatibility.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 32 ++++++++++++++-----
> >  drivers/pci/controller/dwc/pcie-designware.h  |  3 +-
> >  2 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/=
pci/controller/dwc/pcie-designware-ep.c
> > index 1d24ebf9686f..bd57516d5313 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -54,21 +54,35 @@ static unsigned int dw_pcie_ep_func_select(struct d=
w_pcie_ep *ep, u8 func_no)
> >  	return func_offset;
> >  }
> >
> > +static unsigned int dw_pcie_ep_func_select2(struct dw_pcie_ep *ep, u8 =
func_no)
> > +{
> > +	unsigned int func_offset =3D 0;
> > +
> > +	if (ep->ops->func_conf_select2)
> > +		func_offset =3D ep->ops->func_conf_select2(ep, func_no);
> > +	else if (ep->ops->func_conf_select)	/* for backward compatibility */
> > +		func_offset =3D ep->ops->func_conf_select(ep, func_no);
> > +
> > +	return func_offset;
> > +}
> > +
> >  static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
> >  				   enum pci_barno bar, int flags)
> >  {
> > -	u32 reg;
> > -	unsigned int func_offset =3D 0;
> > +	u32 reg, reg_dbi2;
> > +	unsigned int func_offset, func_offset_dbi2;
> >  	struct dw_pcie_ep *ep =3D &pci->ep;
> >
> >  	func_offset =3D dw_pcie_ep_func_select(ep, func_no);
> > +	func_offset_dbi2 =3D dw_pcie_ep_func_select2(ep, func_no);
>=20
> IMO this will make the code even more complicated than it's already
> with the offsets calculated and added here and there. What about
> implementing a set of methods like this:
>=20
> +static void dw_pcie_ep_writeX_dbi(struct dw_pcie_ep *ep, u8 func_no, u32=
 reg, uYZ val)
> +{
> +	unsigned int ofs =3D dw_pcie_ep_func_select(ep, func_no);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +
> +	dw_pcie_writeX_dbi(pci, reg + ofs, val);
> +}
> +
> +static uYZ dw_pcie_ep_readX_dbi(struct dw_pcie_ep *ep, u8 func_no, u32 r=
eg)
> +{
> +	unsigned int ofs =3D dw_pcie_ep_func_select(ep, func_no);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +
> +	return dw_pcie_readX_dbi(pci, reg + ofs);
> +}
>=20
> and converting the entire DW PCIe EP core driver to using them instead
> of always separately calculating the func_offset? Then in a subsequent
> patch you can add a new method like this:
>=20
> +static void dw_pcie_ep_writel_dbi2(struct dw_pcie_ep *ep, u8 func_no, u3=
2 reg, u32 val)
> +{
> +	unsigned int ofs =3D dw_pcie_ep_func_select2(ep, func_no);
> +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> +
> +	dw_pcie_writel_dbi2(pci, reg + ofs, val);
> +}
>=20
> and have it utilized in the shadow registers update parts as you
> originally intended. This will make the code much better readable with
> no much harm to the performance since the most of setups are performed
> once during the initial end-point configuration.
>=20
> Note my suggestion is quite heavy to implement and implies the code
> cleanup. So I'd wait for the maintainers comment about this (Mani is
> now responsible for the driver maintaining).
> Mani, Krzysztof, Lorenzo, Rob, what do you think about that?

To be honest, if possible, I would like to implement such clean up code
after this patch series are applied (because this patch set had been
developed for a year and more...).

Best regards,
Yoshihiro Shimoda

> -Serge(y)
>=20
> >
> >  	reg =3D func_offset + PCI_BASE_ADDRESS_0 + (4 * bar);
> > +	reg_dbi2 =3D func_offset_dbi2 + PCI_BASE_ADDRESS_0 + (4 * bar);
> >  	dw_pcie_dbi_ro_wr_en(pci);
> > -	dw_pcie_writel_dbi2(pci, reg, 0x0);
> > +	dw_pcie_writel_dbi2(pci, reg_dbi2, 0x0);
> >  	dw_pcie_writel_dbi(pci, reg, 0x0);
> >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > -		dw_pcie_writel_dbi2(pci, reg + 4, 0x0);
> > +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, 0x0);
> >  		dw_pcie_writel_dbi(pci, reg + 4, 0x0);
> >  	}
> >  	dw_pcie_dbi_ro_wr_dis(pci);
> > @@ -232,13 +246,15 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >  	enum pci_barno bar =3D epf_bar->barno;
> >  	size_t size =3D epf_bar->size;
> >  	int flags =3D epf_bar->flags;
> > -	unsigned int func_offset =3D 0;
> > +	unsigned int func_offset, func_offset_dbi2;
> >  	int ret, type;
> > -	u32 reg;
> > +	u32 reg, reg_dbi2;
> >
> >  	func_offset =3D dw_pcie_ep_func_select(ep, func_no);
> > +	func_offset_dbi2 =3D dw_pcie_ep_func_select2(ep, func_no);
> >
> >  	reg =3D PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset;
> > +	reg_dbi2 =3D PCI_BASE_ADDRESS_0 + (4 * bar) + func_offset_dbi2;
> >
> >  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> >  		type =3D PCIE_ATU_TYPE_MEM;
> > @@ -254,11 +270,11 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc=
, u8 func_no, u8 vfunc_no,
> >
> >  	dw_pcie_dbi_ro_wr_en(pci);
> >
> > -	dw_pcie_writel_dbi2(pci, reg, lower_32_bits(size - 1));
> > +	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> >  	dw_pcie_writel_dbi(pci, reg, flags);
> >
> >  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> > -		dw_pcie_writel_dbi2(pci, reg + 4, upper_32_bits(size - 1));
> > +		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> >  		dw_pcie_writel_dbi(pci, reg + 4, 0);
> >  	}
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci=
/controller/dwc/pcie-designware.h
> > index 812c221b3f7c..94bc20f5f600 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -340,9 +340,10 @@ struct dw_pcie_ep_ops {
> >  	 * access for different platform, if different func have different
> >  	 * offset, return the offset of func. if use write a register way
> >  	 * return a 0, and implement code in callback function of platform
> > -	 * driver.
> > +	 * driver. The func_conf_select2 is for dbi2.
> >  	 */
> >  	unsigned int (*func_conf_select)(struct dw_pcie_ep *ep, u8 func_no);
> > +	unsigned int (*func_conf_select2)(struct dw_pcie_ep *ep, u8 func_no);
> >  };
> >
> >  struct dw_pcie_ep_func {
> > --
> > 2.25.1
> >
