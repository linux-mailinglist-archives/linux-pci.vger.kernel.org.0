Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C53752F31
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 04:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjGNCLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 22:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGNCLi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 22:11:38 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2026AE;
        Thu, 13 Jul 2023 19:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIV1XWezOw5bqgDdykXRS48mrKeymMNNTXVHtYZajhd14kfV9Us4Eiz9SLXt5VtR4+oS8lrQpbG01kX6bmVTCMOx7GL5337i9Og90rC4h1kjtZjhNwvneLtZu5V6rH9/KkXXztKiLzk1KnglZn6aJH6fg26ZR04DweEAyRKRXnkizhmvvPgzX2lgie5qtBmWz+guYI5sknMkdwy4vs2W1qKitXzL8Dl2shezM6ol8nXXIQCvJPZCdjZf+r05GIF9qpOMDoTLY82kGM6N3hBrROSXq2L11Xj2lh6YYgOsujYAQ4H4KNa2SXbCs1INiNVpeaz2FDpBChy0YTMee1gxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjC2JxKhUIHC7Va0UE1oKI7w9wOSIhnDkAPAX0Yd83s=;
 b=KYG2gDFkhLam8r6Yrifu2LT+8KkXOH+jx/QCnLXJNj6HRHn4TgTTcBFNsDukl/uMlKG7IhTwF1biEbBKRuPFt3lUD1cSZC3spEb1bet0MEtfJ5fhomUT9AOe2HA9gcoAbyCyx1F2SWkPtQiLiViYtw7rNx7BJhxGJ9SS+CnC4OwWSRXxxCVLeiwa/J/etIdU0KYaBGJY6y1Szyu89FCjviUPJgihFmCqSz4U7zGkI6atkOooOf+bCwsHeU3su8rlO5ZWuuRsdGwcyvzGp2rpsryUVjksvUxWExpfTvbvjc/uLaCjbV37Jtb9JV3tjSU8Cohw3N9gr6fwmWCYrfGj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjC2JxKhUIHC7Va0UE1oKI7w9wOSIhnDkAPAX0Yd83s=;
 b=NXHJ6j3WlpXzLCvoajnYzFTm3FJdusBP/05iO2CCqm3muJB3p/oX+DsSEEI510SDgGYGICKA1kcoHY5UWOgQ4QFwH3yBPfkcI/03QGc4+1BdFM4d6F83NTVHSSoiwEm83MBLbW74LhbPZDXdAlWOr/YXtk0qzUeD5LMiP0gaa38=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYTPR01MB10952.jpnprd01.prod.outlook.com
 (2603:1096:400:39c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26; Fri, 14 Jul
 2023 02:11:34 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::4aa4:531b:e63:3d61%2]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 02:11:33 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
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
        <linux-renesas-soc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: RE: [PATCH v17 08/20] PCI: dwc: Add dw_pcie_link_set_max_link_width()
Thread-Topic: [PATCH v17 08/20] PCI: dwc: Add
 dw_pcie_link_set_max_link_width()
Thread-Index: AQHZrzZNNvRuVNBye0S2xYxme6H6Qq+1Er0AgAN9GMA=
Date:   Fri, 14 Jul 2023 02:11:33 +0000
Message-ID: <TYBPR01MB5341BE7E22A0721672A0FFAFD834A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com>
 <20230705114206.3585188-9-yoshihiro.shimoda.uh@renesas.com>
 <3nldn3s27gwdsfyybgg2ady4tkgpxcvsntbpxp4vdbr4myncnc@clivb7gcds3e>
In-Reply-To: <3nldn3s27gwdsfyybgg2ady4tkgpxcvsntbpxp4vdbr4myncnc@clivb7gcds3e>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYTPR01MB10952:EE_
x-ms-office365-filtering-correlation-id: 25af6a82-b514-4f22-e040-08db840fa588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W7crE8B/DxwT1RhM3Qd/Bja3bHTyGsvGJNP3PvOd2hprzxara3aP9f0T8hmRjiBp+L6lSHAD7xl2hW6tpXoKhwnLdu8U8VUcVQtmChSTSmDfQ3IOV8LL16BsfKMytRYgpcc8sUigMs6kKwDNFHeNo81uZMOGjJHN67QLkhEzfpbMD6LxdKYkyzR2RUdPyURNLznuU62iqeZ2NgrCPwNgF8Bmi7nZgvh7tgd/no+Je6RR9vJXcdxEmSlWUGdOzAoTDORsDDxr4+rWRROR+MHxRZ9eBblPIsssN94p3fFuKfnsU7hD84bHXP069UGQfQPbS4wZq4/aDakqUcbAOVOK4ERkEWMFJM7yIBf7IZCCOLzwb56217MiU1N3EqySZAfgJggvRzkVSgCW5vphtXIU5SoRVRih+fncoaW7/LVwyXtaQcU+MZsA7kbml0AxoAuRMRJSOTFzBg8adYXQbowLf92KZfISmwKwalvfGusPwDJWq4R97mkDgWtO+b/OdCd/YQJ3I+pUfaie3xtMCvpN8gwqnIE2qOTKG7REXEkamOmCuQXwH6QTGAVrFINi7zZ5F/a5T7aMtxt73IBmW9mWVXCUCyie34mVKdL9Wg6KM59ODroE0qZCxdnOLFmpkAr3PTdkf18L8tVhfxF6jCPs+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(966005)(7696005)(71200400001)(33656002)(83380400001)(186003)(122000001)(38100700002)(38070700005)(86362001)(9686003)(6506007)(55016003)(66476007)(66446008)(7416002)(64756008)(76116006)(66946007)(66556008)(4326008)(110136005)(41300700001)(54906003)(52536014)(5660300002)(316002)(8676002)(8936002)(2906002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?9acxF/XnxWCgDxspY1YPtm1vLdAa8hoTxWru7Jw5/TqJhnkI/ejGfXd4fl?=
 =?iso-8859-2?Q?fwMvxRmplfMgmm6DszqXJw575yL8idHJ9H6c3ECjsScPsmEiMGNG36J9g4?=
 =?iso-8859-2?Q?QcZLxuRfAgjXM/V+hX3QPZldalhoTtOa676cvSVxjzIN8Tj2sbWV82C2uF?=
 =?iso-8859-2?Q?mJgEGWZAAVvGk36zjcsUf479Sk2laewb09wLb3ijvlKiZ6CFKTceWMStUX?=
 =?iso-8859-2?Q?tZfmF1gUn/3s1qHqYSmQn5dXA733RFSb7lb8JxouIOERO6eDVv97jGYVip?=
 =?iso-8859-2?Q?gLerf5r7WOo2y3+4n1ZC/JmAmopplVFW1LYPQ/V3SO/Sex4ZpxEYUAOEd/?=
 =?iso-8859-2?Q?npPkIKIsVOiLzPYCaeMb9Q3BAsIxlWFmrlt/9Vp++t+ewVXr3Jc7mXpDah?=
 =?iso-8859-2?Q?Fndh95QnreKQaatJpTjyXgUFw9+2fEyNP0JMy47oUoX8YGvQEJTA1U6vVf?=
 =?iso-8859-2?Q?NRR/2EainF+s4I6X09ksnmdXNU/S/OSWA6h7gbLkTTdFMEoXw4krKUJL28?=
 =?iso-8859-2?Q?QwTLpC6Y7J84h28dM7nlXARO1tsIIiBlL+I0fH1+weq/YD1N/5060eGOso?=
 =?iso-8859-2?Q?VyNDfDoXmHBtG9CYZMc2+Xak++3cJWSNSdBjWpLq7dQrti+cOF3TkY11L0?=
 =?iso-8859-2?Q?3c8YKLdzCg0ldco9j3bteFuaZeL+qEwJ2Artf/SqP25hCJdRnUa7qpIwZo?=
 =?iso-8859-2?Q?Srrw7TDs3MNispwpr8KHCKF8UVpAiPoIFHf9yKxGjW32+kb66NKwFvtEGI?=
 =?iso-8859-2?Q?SS1W+Z+nPdrtUzCIyOKYtyTcUJUevy/VIZL8C5XW3mV8Ccwqk8hvTiBbc4?=
 =?iso-8859-2?Q?zqdc5kbvZdIWYS7n9eZSFccFxklI7uG/AwpeE+tzF6mlNIgxy0MnqMdlDi?=
 =?iso-8859-2?Q?zGKJsIdn6YE3LuNZD57jASsPup+rOdOe3UyGXRvBL7NJse5F5BfYZ5m+i1?=
 =?iso-8859-2?Q?IOa+bGEIF83Ts9BYv5gOkcy0QENzmRYo+UQ2mXCQQBZcy9pEV+W8lIsv1X?=
 =?iso-8859-2?Q?9VWLSFYfYfF/zAz/YGAINn1yQNpOOQAueO1oO7EGuuryEpAES2hi6q1+9V?=
 =?iso-8859-2?Q?wyHl1xZ7DTBoFnQh85C1QdxIR3QLh9S8hSy+mPshZpmAQ8rMv88vPgeV0M?=
 =?iso-8859-2?Q?ms9BoQ/zKiYtCg1LBYtjibN3AGrMRrPvDR1bamFbZHXgg+lBSh13gx9+VY?=
 =?iso-8859-2?Q?pn0MkuVT4i7oxkOxkIJC7GE8ykQISTD/tU2jdneHVcwSjbVe59RDtJSLDu?=
 =?iso-8859-2?Q?m8dmwvChGF4QsM9Q+SCiVmn+2aRmGxAptyq59ZYmfP3+KZGkBHeSs1xAAI?=
 =?iso-8859-2?Q?eDPNLuYDq9zjn+/Wk0DEW7ilGOLIdPzYjy556rsCXM82K5KH1Q/lMQkqMs?=
 =?iso-8859-2?Q?uejp+faDXvDy1YW00HCDYWpLgIJFV99EFQTrzjoFyOgAxXGqz65T1QeWw/?=
 =?iso-8859-2?Q?cGqdVOPN2ON1diyQbQy9MZmALx8HQuOHAnVeOQFGM2aTSn7ZBoG9yYQuzz?=
 =?iso-8859-2?Q?tH+ncka88o1LqmxcsPGxGCqGzB2PjytCQxYo4RmT8x5DpHjgg9mvcgnY68?=
 =?iso-8859-2?Q?ORZrKmkOCu5JVfhH9C3cxtWQaPACzTc09bt2WooqjKB2G638Y/puuwoVWt?=
 =?iso-8859-2?Q?dqvQrXAbyliMvgVg04z3FotwvLNSViTCyYKBkBS2mSYG7zLxbEsXlB6747?=
 =?iso-8859-2?Q?duPubVslzCXZx/L8FzaS7gHraSYdPxTn6Eb6X4ShqlVcq4YxYv807XSXkJ?=
 =?iso-8859-2?Q?vXkg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25af6a82-b514-4f22-e040-08db840fa588
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 02:11:33.9475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZm0ONDNN7ZBGWBDfC63X9yh6E5sakWV1nx3Cb1kjdQmDAQ3bkHGz8K22jw7urRiS5vdknHcjGYvJStBCl1yzpcfUeZUKh56Xc8zIyKKky3jChKO9dedHtv8KEw27KFT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10952
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

He Serge,

> From: Serge Semin, Sent: Wednesday, July 12, 2023 5:45 AM
>=20
> On Wed, Jul 05, 2023 at 08:41:54PM +0900, Yoshihiro Shimoda wrote:
> > To improve code readability, add dw_pcie_link_set_max_link_width().
>=20
> This is a preparation

Yes, this is a preparation. So, I'll add such information.

> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 86 ++++++++++----------
> >  1 file changed, 41 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index a531dc50abea..7b720bad7656 100644
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
> This is redundant and unrelated to the link width setup. See my next
> comment for solution.
>=20
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
> Please pick up my patch dropping the line above
> https://patchwork.kernel.org/project/linux-pci/patch/20230611192005.25636=
-6-Sergey.Semin@baikalelectronics.ru/
> and add it to your series before this one.

I'm afraid but, I cannot pick up your patch into my series because I have a=
 concern
about the following comment from the PCI maintainer..:

https://lore.kernel.org/linux-pci/20230612154127.GA1335023@bhelgaas/

Best regards,
Yoshihiro Shimoda

> * unless Krzysztof decide to merge it and some another patches from my
> * series in...
>=20
> -Serge(y)
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
