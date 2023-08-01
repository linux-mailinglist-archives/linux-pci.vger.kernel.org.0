Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270B76A694
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 03:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjHABvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jul 2023 21:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHABvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jul 2023 21:51:06 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E35A8;
        Mon, 31 Jul 2023 18:51:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L03JPr4ar4DfUQB7TGvyVg19myMh0QMsBV7m0JGyazkppebQmC6anlFC4biEv3uU7NRp9phdiT54sznp6jnDRwGkTx+K+hoqwDHMAXG0OjKIr8GLd60JOFJxvjm3ErgrymKJ1MopYm1ZAJjRtLFfcekS37U0CaTgAd89OFt2CjTIfqFIxGdjirkQKoeX2zBmfaT/z2S8UoOHK346b/gT6fMBOobnJfW1zsJ0Ci9eJxgozBNS6O6OvsM/M8QYK6YF/S93S9nOhEqJgu6EecYdzBpRelp4Xzah0HewU+NP3bqpQagP9vjPklK9+HFzieylIFaWie5x2T51uNwpmJ2Tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iyw55ntZwVtmLWQUrLb0AZIU6iWIFWgHQTQPokNaYM=;
 b=OUsI9pPiJ0TQQ99GTdbNl8ibG4EafvouvUNewYZ8ZEmq0+HnaMGebi8UZkJNywaKrAf/nu56dHmKBEwzJMYmJaokEo2N2+fN2a5jvqpqCC/Pp3kWsurvoBg9VXZmO9UlqdY5u+tG0xjvgVygiPUplMeCuKWa+lDv6h4GKhoxzLtDvNyD2gQesM4EsJVNZx8AoRflOMfVeJ5uOpmiQDibhoLMYINkdE3DcukFGKRIQSK3iSSDvmanROOvno6Z25lPKjn67JmU9FlkhBUGJSM5waTpRut31IiJ7g/mI7XihOtToBFbJA/EDdL5joanwPWQDqeFPWUNtaAu6MuO+YLbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iyw55ntZwVtmLWQUrLb0AZIU6iWIFWgHQTQPokNaYM=;
 b=FJamI6Xhz+moDMuT1YCcsfyA0T8mLEf1OUnVbU77qrTAwb3dl69r/EOKvy0my0SJ5+I/u5oqmsVfCO9XRpb7TTzfiT5jmOEC6SQRNilr51p/xQJV3cqmvGTNJc6r3y+pQJYOQKe+pawhRlll1yh4Dx2PIUyrtGAaj5F/nca/tWY=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB6103.jpnprd01.prod.outlook.com
 (2603:1096:604:d9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 01:50:59 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 01:50:59 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: RE: [PATCH v18 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Thread-Topic: [PATCH v18 08/20] PCI: dwc: Add
 dw_pcie_link_set_max_link_width()
Thread-Index: AQHZu6dDvdiMk+aD10qOgOqJVjte5q/UnR0AgAAbgmA=
Date:   Tue, 1 Aug 2023 01:50:59 +0000
Message-ID: <TYBPR01MB5341D7A8BF3CDFFE27E261C2D80AA@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-9-yoshihiro.shimoda.uh@renesas.com>
 <4ojfda5tlfu5wnljydzg7jncaa2zmhzgaqn723sst5rp44tfbl@j6ndm27ejinb>
In-Reply-To: <4ojfda5tlfu5wnljydzg7jncaa2zmhzgaqn723sst5rp44tfbl@j6ndm27ejinb>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB6103:EE_
x-ms-office365-filtering-correlation-id: 1edded67-8bae-4e98-0cd3-08db9231c12c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lsrkjkDQL5OBxg/uCDbu3kLJevz4Vo04hi9ikCuXf9pnCSj4BFZdisSk1AOugRkzPSoNbn4oiSaEMyNqcTWhf6pm1Zmp4qZPqWh99VYnst/KrMT8gf+y3gDBdpO5gNjhGWJMWLp7i2QbDSqS/IIWS9amjQVZazokNUmE2OiBM331hjn2yUJxXpZiMrWvhDigAs7+8okKShyX/KPNfcNESyyFydne1YqJT4C2Ne7HusJJAMunQLdErmzw/zqpsqga2AiTLSxVcDCxm/fYK/EkJafAV/KmxcK9/v4AWinar1u1nJY9PLloo6GX6PnCa3fVXlOF1rezKOYCi2ev/YYxB/6X0gQegMqcP/Ge0gFY39dbVgfmxTmG06qOdmdWw7AO2CjNdcHqFXVdri7ZcjBcKM+XRUNdOZEcZv9RCcqCNTKHZG/cTtRd1QCo1ME/ak+eN1Gfa8l6SElogSGBHWs+uYd+8M4T4UynFs84MVsMfLbgUqsVtbM4//RuMaK3/hLQBd9bI1bK0FYT45GgCWt7aIsi0YgTOAfTWSo6zBh22MbsRZmaa1P9BtVbyMlHoYMgsNniIZRonkgNRiPqEc+/RJ3kSLpYxPeb/CiGKvYTQVQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199021)(5660300002)(52536014)(66476007)(66946007)(76116006)(66556008)(7416002)(4326008)(316002)(41300700001)(110136005)(54906003)(66446008)(2906002)(64756008)(71200400001)(478600001)(45080400002)(7696005)(8936002)(8676002)(6506007)(186003)(83380400001)(38100700002)(122000001)(38070700005)(9686003)(966005)(33656002)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H1iC4/HCVw6113cFxeekdoRT895hN1BcoS9TJmmXvkEysEBOCxy6bFOdJoO9?=
 =?us-ascii?Q?GvE0HCMRu82eXaEcNwxKJiTlJx78wveFDVcuw9Xo+vxsjnzdwwgBiCJtX9br?=
 =?us-ascii?Q?e9fV25MUOagjs/5ZvHMZ/U/v0x8o+6F/bQ7XYiL8ptNGL0j+cSEea4g8eGt6?=
 =?us-ascii?Q?DBR1PS83K+5W+aioY4blczAnfPUU3VifLZxKd1I+qE8Uja1fpZYlTT6KtBP8?=
 =?us-ascii?Q?vhRug8lr+H5eT1UIp3S/Ip9RC4kATb61uHCTI4H2Tw+TumtiL87vLsyX5LN/?=
 =?us-ascii?Q?Ytdf2UCevezuIniuurWF79QqXMTd4biixgRe6wocAGGcd3T4W9D2yCtktKui?=
 =?us-ascii?Q?KnRM9RX3Fk7QJTu8HEmi/xFDEWek1UTrGd16SODRmqnKHIaQ61OPaQ6S59kO?=
 =?us-ascii?Q?6L3eHRwfLuGY3p3CY84gD0DbbPOXTQ4gq8r7er/dXUVh96u/zCR3vvFTyPZe?=
 =?us-ascii?Q?Wf0y5kLzQ6s3B+QTlM0AQsXcCgiUIsfgtoz8tONf6/SFVNwJo/9K9DK7aBHR?=
 =?us-ascii?Q?KHUjFK8C+pnx0QXbTnnTWC5JUGBhC+BhZeJZTK4qBM5432zNzQpAfWKJHj2d?=
 =?us-ascii?Q?wN7OX2HWsBLPq1QTzhbZLOLUIf9IzLSxc6ph0uto6sIGKicQxDYybsEakP0H?=
 =?us-ascii?Q?vZMD2M+vRE14UcJ1YRqAcQE4gCPb3jMVdOBu8k7dX1skdB+5iRceJyDuJtyF?=
 =?us-ascii?Q?Q/tWjZkj5dIQjJ4ty3oeMMYFvgc4E2FUF3B9gQHxWw4ZOm4ScV6E0b60N+bF?=
 =?us-ascii?Q?fC9J4Fjsj+vywv0k/ZktqBUmanhrbAFodn/VtsVJSwbHb5PBQmVTJKQjTFW6?=
 =?us-ascii?Q?EZoGA3blILNZbTEDLbzZhZb0YTc4ZpuT+Xra0dfRo1ak5friYOPgLpMCnfM2?=
 =?us-ascii?Q?265Tvg0jdZDOkMDFipn5VE6hRy5GB4gqAOE80V9ydAt7E2OWD2LDbGyQK6DI?=
 =?us-ascii?Q?OZtvCi8RoRR7+5NeB45b7iuphXG86TKsqos+aJIkfA26o8n3rW5wsNRz5N/m?=
 =?us-ascii?Q?/mLe8MwecSscmGwAlscbQLKKc5FoCfCFli/HzfG554v1sMghsarEb/jV0HTR?=
 =?us-ascii?Q?Y3DKz1nx6SV7COuiQ0B88RpKHq+MFM/ETjEpzfxOALoc+B0DAVa7MXszFSL9?=
 =?us-ascii?Q?qNqMUlVewkvZC4fDA4XTsy50EzHYxMoTydZQNcf3w9sZWgv+3b7GtQGBMg90?=
 =?us-ascii?Q?4k4LkN6sZ7L4jltG7PWd+S9B+h+yrArLeq6xiDSKmsBUWnRp25/2VhS9UEKD?=
 =?us-ascii?Q?seA0wQEfZ3l4H+C2/0M/S8fyduuXOhqqPTmM0oJ193JLdO78hIn1/xyrC2Ks?=
 =?us-ascii?Q?lR8zz9UXS5DhEFNtkawutGjVwmfIMoV/TxMemBjZjg0Ophd2UfWS5ygHVD7P?=
 =?us-ascii?Q?/UTdiflWjyOYy4OfQ1ZbE5SByVdtmQjx5RCq+IAWCUDHW6YwEK6qfBifTj0m?=
 =?us-ascii?Q?GSxb4irJPAYTWgSJx6fGsIipiL4rLlBOZCCE2Tek14Y+12F4FAhKwHVfJlXD?=
 =?us-ascii?Q?1LQbpMi2f1aMrmQVmQTvcDozVmxTwHNeXyP4LD48iLq4hgwqNuPC1nHr34Sh?=
 =?us-ascii?Q?QVtEoBb1YPrJnuGLyg6l7C7lD6CeXj+QUnFEw/4/++XJ+IZQfpDd3IS6gD2X?=
 =?us-ascii?Q?vXbyiFtBRimSBQw9tbGjilSWtFAH1EGdtHvzH6SCfbpuoowLJ33OchESRGsb?=
 =?us-ascii?Q?pAlnyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edded67-8bae-4e98-0cd3-08db9231c12c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 01:50:59.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUNfZSdxbFOQVj3/s7Lz1ydEOeORAkjKZGIGSroF7qZ3BwoLy62+2+j5sfYNntU4cb2QkVLHOZgSAXoFJPLuVVG0+mO27fYGsshKIyV21GwuRlrneaBG059jmvJ/2OcV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, August 1, 2023 8:54 AM
>=20
> On Fri, Jul 21, 2023 at 04:44:40PM +0900, Yoshihiro Shimoda wrote:
> > To improve code readability, add dw_pcie_link_set_max_link_width().
>=20
> You completely ignored all my comments regarding this patch again.
> It's getting to be annoying really.

I'm sorry for that. I completely forgot to add description even though
I said so on the v17 [1].

[1] https://lore.kernel.org/linux-pci/TYBPR01MB5341BE7E22A0721672A0FFAFD834=
A@TYBPR01MB5341.jpnprd01.prod.outlook.com/

> Once again: "This patch is a preparation before adding the
> Max-Link-width capability setup which would in its turn complete the
> max-link-width setup procedure defined by Synopsys in the HW-manual.
> Seeing there is a max-link-speed setup method defined in the DW PCIe
> core driver it would be good to have a similar function for the link
> width setup. That's why we need to define a dedicated function first
> from already implemented but incomplete link-width setting up
> code." This is what should have been described in the commit log.
> If you were a side-reader of the patch could you guess that from your
> commit log and the patch content? I bet you couldn't. That's why a
> very thorough description is important.

Thank you for your suggestion. I have never read the description before.
About the [1] above, you said just "This patch is a preparation".
So, perhaps, some trouble happened when I sent an email?
Anyway, I will replace the commit description to your suggestion and
add your Suggested-by tag.

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
> >  1 file changed, 41 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 2d0f816fa0ab..5cca34140d2a 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -728,6 +728,46 @@ static void dw_pcie_link_set_max_speed(struct dw_p=
cie *pci, u32 link_gen)
> >
> >  }
> >
> > +static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 n=
um_lanes)
> > +{
> > +	u32 lwsc, plc;
> > +
> > +	if (!num_lanes)
> > +		return;
> > +
> > +	/* Set the number of lanes */
> > +	plc =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
>=20
> > +	plc &=3D ~PORT_LINK_FAST_LINK_MODE;
>=20
> Once again: this masking is unrelated to the link width setup.
> Moreover it's completely redundant in here and in the original code.
> See further for details.

I got it.

> > +	plc &=3D ~PORT_LINK_MODE_MASK;
> > +
> > +	/* Set link width speed control register */
> > +	lwsc =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > +	lwsc &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
> > +	switch (num_lanes) {
> > +	case 1:
> > +		plc |=3D PORT_LINK_MODE_1_LANES;
> > +		lwsc |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
> > +		break;
> > +	case 2:
> > +		plc |=3D PORT_LINK_MODE_2_LANES;
> > +		lwsc |=3D PORT_LOGIC_LINK_WIDTH_2_LANES;
> > +		break;
> > +	case 4:
> > +		plc |=3D PORT_LINK_MODE_4_LANES;
> > +		lwsc |=3D PORT_LOGIC_LINK_WIDTH_4_LANES;
> > +		break;
> > +	case 8:
> > +		plc |=3D PORT_LINK_MODE_8_LANES;
> > +		lwsc |=3D PORT_LOGIC_LINK_WIDTH_8_LANES;
> > +		break;
> > +	default:
> > +		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
> > +		return;
> > +	}
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
> > +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
> > +}
> > +
> >  void dw_pcie_iatu_detect(struct dw_pcie *pci)
> >  {
> >  	int max_region, ob, ib;
> > @@ -1009,49 +1049,5 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  	val |=3D PORT_LINK_DLL_LINK_EN;
> >  	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> >
> > -	if (!pci->num_lanes) {
> > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > -		return;
> > -	}
> > -
> > -	/* Set the number of lanes */
>=20
> > -	val &=3D ~PORT_LINK_FAST_LINK_MODE;
>=20
> My series contains the patch which drops this line:
<snip URL>
> So either pick my patch up and add it to your series or still pick it up
> but with changing the authorship and adding me under the Suggested-by
> tag with the email-address I am using to review your series. Bjorn,
> what approach would you prefer? Perhaps alternative?

I'll wait for Bjorn's opinion.

Best regards,
Yoshihiro Shimoda

> Note the patch I am talking about doesn't contain anything what
> couldn't be merged in. The problem with my series is in completely
> another dimension.
>=20
> Bjorn
>=20
> > -	val &=3D ~PORT_LINK_MODE_MASK;
> > -	switch (pci->num_lanes) {
> > -	case 1:
> > -		val |=3D PORT_LINK_MODE_1_LANES;
> > -		break;
> > -	case 2:
> > -		val |=3D PORT_LINK_MODE_2_LANES;
> > -		break;
> > -	case 4:
> > -		val |=3D PORT_LINK_MODE_4_LANES;
> > -		break;
> > -	case 8:
> > -		val |=3D PORT_LINK_MODE_8_LANES;
> > -		break;
> > -	default:
> > -		dev_err(pci->dev, "num-lanes %u: invalid value\n", pci->num_lanes);
> > -		return;
> > -	}
> > -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > -
> > -	/* Set link width speed control register */
> > -	val =3D dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> > -	val &=3D ~PORT_LOGIC_LINK_WIDTH_MASK;
> > -	switch (pci->num_lanes) {
> > -	case 1:
> > -		val |=3D PORT_LOGIC_LINK_WIDTH_1_LANES;
> > -		break;
> > -	case 2:
> > -		val |=3D PORT_LOGIC_LINK_WIDTH_2_LANES;
> > -		break;
> > -	case 4:
> > -		val |=3D PORT_LOGIC_LINK_WIDTH_4_LANES;
> > -		break;
> > -	case 8:
> > -		val |=3D PORT_LOGIC_LINK_WIDTH_8_LANES;
> > -		break;
> > -	}
> > -	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> > +	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> >  }
> > --
> > 2.25.1
> >
