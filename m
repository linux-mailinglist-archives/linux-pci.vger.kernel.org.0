Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508004784B9
	for <lists+linux-pci@lfdr.de>; Fri, 17 Dec 2021 06:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhLQFyY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Dec 2021 00:54:24 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:24135
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230405AbhLQFyY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Dec 2021 00:54:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPgEYe62tuS0u54rnX8NNQHNIzaF6RbSYD1vZlt4ZUMCrkENPWownzlrcgi9aAnSSrlFZ4BxpE9l9U8Jogw/8t/Z+MwlzaVlCz12OJppuwxGzvHPNMwguNIUDzRTc415uNjivhXkqwSGQ159ab0rLMx10TzRbTDn+JI7y1DlCsN9ztU08V63mLZ/K/ZND2hEQ5Yu3h3ry3zGWqcwPksBu2mrM59zT7mYArApj7qyoznw0Br1gFgKxT2vr+jhEvS+5A/rNti21YCFwD/Hfb7SQoa25SjX5Arsk2a26yEVMIl/Zqsfh5VyG595a0wKk7TDblC2sUaCB1SiFCH40VrX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kTMT0M79QFwAjHPjoVz5t+u5DO4KBxr4/N84mnh5DI=;
 b=h+puP8nMns/IR4sHV/hkIL5ifHthB8+VqntcG2oQ4HeLQzSfOAcJ9Bz3ELygvQnbEsFT5SUghqv667RFqnSCZl7umL6+pQ1MkMwkA4PkMBuZa2tJoivm5l6nDUk8X5hmFT43uC4GVpYswdgFASa7aDhOfnvYewrmLslJsH/dQlzee+HxGqy6+/bh75TdFdJSr6HdvutE2s2q5k4yHh21dL/a37zewc+W6TQR1ItWGfGhwx0mPVvrB4z9brDvJd+mhBkKIZsBDKiYwb2Yaabq72ghcn+YsBzJtTt9VemvZA0+GnnDhl3BhFG8HQ8Z5mzAQv9KIY9xeqkvhQ0eGfxGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kTMT0M79QFwAjHPjoVz5t+u5DO4KBxr4/N84mnh5DI=;
 b=OUb5TAt+rwalrNglWfA9pd4nWFsT66yxiQgsry7KI39zc0z6HCVXfCbGkdn+FIzMwp0H9RpJYcppW11a/3/MiDyZuiZ8oC93usoZ/Wfqdvkw7xypVzhBX5Pk6HEOo7xYgTTvuVbP/Fiy0G1ZoKez29NnPzXkSqom7xkJCo3Chmk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8993.eurprd04.prod.outlook.com (2603:10a6:20b:42c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 05:54:21 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4801.014; Fri, 17 Dec 2021
 05:54:21 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
Thread-Topic: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
Thread-Index: AQHX51bdQrJfUAGahEmIU+86q0TYAKw1a7+AgACkc9A=
Date:   Fri, 17 Dec 2021 05:54:21 +0000
Message-ID: <AS8PR04MB8676F7F8BBE79E36D3EAFB6B8C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-9-git-send-email-hongxing.zhu@nxp.com>
 <Ybtuo0CzfUhoJwsT@rocinante>
In-Reply-To: <Ybtuo0CzfUhoJwsT@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1001495b-1fb3-4c43-97f3-08d9c121ac3c
x-ms-traffictypediagnostic: AS8PR04MB8993:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8993EE0093C5AB2ADC54AC608C789@AS8PR04MB8993.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: woQzpbf67nKAbZtsAMz1aFaauk4xiC2LnYoRNuxKT9vL8T2sdwLhPYK0yG5DKJvPFYCa1L97q2lRGAoBhEXiKnpEMoVEdLEM50Wz1GwcDtoPO6Svl0kG8U/Z1tWkfETJ6wXmzbzmNjrIkZUC92nHxtmcTGs0N6ZHA87WAXkiH070FtmB/qnLlW2+Jhgf4wr3TpiZRSUPWm5XJ6Y1Zff3tJb3U0k1B6ThJIdFOm0wIX/8tww2zujS0pjKLLAMvMwx4LKm7x/yEu1V2n2mkQ5GJGUGDShGnZDbAUOc3IMPF9LHY6rOMbgeirO/RUwNLm/Frwn+6Zm/AKpVlYxQ/o2P3ouwym2Cwc2ffzuQN9I6s2PIGOvvuxABC4Cy317GruLq4v7CqUyIgvLsVSGjvbc5GPIZ+yhxEfLQS/g0up8EGXoridR/NaVtgbilOAOnXf8WvVMAkkZsUsiFhKq7r9CzXYqZLQIwM1oQIg2NADj81v6i3IfbYQoIOOArXu04tmvWi9Jni2bwTWUlRLysq+bBkSacoA7/eUXOzXjwUyvrI7Cff/DhwG+FTpKV/hQ3QqdsqV5uGc4HuHXIy57nr+e7JhNn/GdIHASaHkHAsJjh3qdYJ81Pe8KMy0AM48C8JFI2Px5tTpOb/rKU3yBgL8NJ0JwvaJiVOmFWji/ZFPtC21zq/XGINMEuoOlUnoo5X2q8PvZeFHGpk9rmpmH3O/VHXNw3aoqQX286fvjl4Tjypy39m4W2HFoOVd+z1eniUxkkuPANRel3HAS9blURGc27Z4PVkp12HL3U2SrJ02FAMTERfHPZEIN5OWBLEDeHxMmEsGypaOD30hXzuxtCemcH/jpLGZJZFaqqaaEWfFH6VuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(26005)(66556008)(6916009)(66446008)(66476007)(186003)(53546011)(54906003)(6506007)(2906002)(86362001)(5660300002)(7416002)(38100700002)(83380400001)(122000001)(76116006)(66946007)(45080400002)(9686003)(38070700005)(4326008)(71200400001)(33656002)(52536014)(8936002)(7696005)(966005)(8676002)(508600001)(44832011)(316002)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?pYMGge7FnV5HH9WxlTrxCDZMMAiW/e0b1PjM7B5Au/DRKZe9OADcvlA21g?=
 =?iso-8859-2?Q?MAFzmRAcljwVtx1pnFtbjpa+lM321DJ1MzKClM7SUvfXkZQIiPcMHrvcrF?=
 =?iso-8859-2?Q?64mdt4H9dyppe3ccf69WqACGu0L+ocXL5xBx3VX+aMW9FUZBEpKl746ltT?=
 =?iso-8859-2?Q?44AA2j0JpcW8XHdy1IKdetjcp2JsT7fAwTR1lT9SmNVlmMNKc6Yv0SsS0/?=
 =?iso-8859-2?Q?n3yNX15Sc6BasgxuODqNfKbsEYzZYmM1zlP2uh3QICU9ZsBraS1H6VWHNE?=
 =?iso-8859-2?Q?hH9XWlKDN8d3W6EBw2rzRk4HZeihrIEjJUqNylqKzQjMVkJszLvlScWWaw?=
 =?iso-8859-2?Q?05CjMhacdGmtNfLhW/SYz2VzbMl5mAMg5Zx5VZKcK/Jdnqad0JDb+TGOCE?=
 =?iso-8859-2?Q?++r/ADXqC0XnA5dSfjPbGMOPJV5nHHh7ibeshIEW+VGuAQKde6nVERmMpM?=
 =?iso-8859-2?Q?YeemcetCMHyqu/DRnonuHpjDBfmsvYtt0VmjIrVlPCFlK+CLzsyG+b/nhZ?=
 =?iso-8859-2?Q?uPAJxbAcNtkce7CtNkJWZNiKQWbT7sMjokkrNW4iP5J+ribEeD00vVR7Pd?=
 =?iso-8859-2?Q?67Wyjq5caU5qcsIZnJNHbIf7D3OOstknVZIhXl1m3CZZ/XjsDsF+rR9tUf?=
 =?iso-8859-2?Q?c5YrK8/3hxBZbqQKGG2skblP668jYMyUEo0vT3ENyRucIHsic4bv95K5za?=
 =?iso-8859-2?Q?JEfm9EMQYTLf9Ssz7sMc4vunmxS/T2Q32IUXKesTarIlELacjGUAlDmMC2?=
 =?iso-8859-2?Q?lKf4rau7Zxd72jsRhVoG1EC6x75ccUi+t4xnheWPszt3msVOy7IgXimGCY?=
 =?iso-8859-2?Q?YFYPSe37+r0vAhCl5Xd5F04N17bQooCsn0aWviasS6mMimIJPzw+lVSIrl?=
 =?iso-8859-2?Q?C/gyQpLMn49OL0gJjjdTA9CWr3UjIAZt/C/ZcGzrthyU98AP1+tcjK0GjK?=
 =?iso-8859-2?Q?FKULsMhhiJLWmIewGaXQDFa/8/w9+mhsBnhjpYENaq2fQBHr2Rxm4G17To?=
 =?iso-8859-2?Q?FHHgH0MyFctaZ5YZZEjB+B/mY4SMuOv9UvDbgJ3I10DOtYz1zled33gVqu?=
 =?iso-8859-2?Q?ZVCdf8pFPXTBiX2dfN60TvYKJ0Qx5VtRG0B8dYuu8BQ8D7TGvWgSR++bYR?=
 =?iso-8859-2?Q?a4IzcuDiEsTg0LQPn4Ixj8tjjtZRUOntm1kcxUfQtzuSXC7PBTa0/UBi3u?=
 =?iso-8859-2?Q?6Fpi52rRNhzc2djBs1DOFVOuMB63OBAhh7448LcgB2ApVO14ntpoKCrFSn?=
 =?iso-8859-2?Q?AJBXseykD7QNEYp+DkvWWujPwPJFyaAZ2jIH4ftO3YI7jGOHGTLHS+zb/o?=
 =?iso-8859-2?Q?GzWeSi0Wo2EuVksSYHl0uZ+DTV8wTg4LzkKhb3Yu2dHtrw7a6sr8t5NzAz?=
 =?iso-8859-2?Q?7dHopkfcEt92QYm0qx54ZiumiVdW2xNleGYJBmrXecfkUhxe6kTVLaCSyq?=
 =?iso-8859-2?Q?pDUvXBG+ur+/TZh2KvQA+NGwnoQC24Dc9oD3TJ/KX97ySnSdNkBO1q5vwQ?=
 =?iso-8859-2?Q?9wwY+6e4UBPb2vh9rn1US2KS+5QV4pQLsxItp8JrCIbhVYD5xkO07IA2/e?=
 =?iso-8859-2?Q?TzKeB8NdB4G3fo2Qmva4SI4it9jgLRPUZguG3FOoQEKTZLWnVjZcqK5u0y?=
 =?iso-8859-2?Q?+wnorftvxxo6Zl8TR9IgHjYINl8apV7bf6vPU6JllEAkdVH7koLDReVQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1001495b-1fb3-4c43-97f3-08d9c121ac3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 05:54:21.5756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHUDb5Igp9ZWHkr+Qid0IYBCYdfcx2YlIZ+lHUukRK4WKjd9BX+xAbgMf8ZW2SXV+AA3yjvVjHUEm7NVIQ1UTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8993
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Krzysztof Wilczy=F1ski <kw@linux.com>
> Sent: Friday, December 17, 2021 12:52 AM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> kishon@ti.com; vkoul@kernel.org; robh@kernel.org;
> galak@kernel.crashing.org; shawnguo@kernel.org;
> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
>=20
> Hi Richard,
>=20
> Apologies for a very late review!  Especially since Lorenzo already took
> patches as per:
>=20
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor
> e.kernel.org%2Flinux-pci%2F163965080404.20006.52416095516435017
> 49.b4-ty%40arm.com%2F&amp;data=3D04%7C01%7Chongxing.zhu%40nxp
> .com%7C8afb673348214261883608d9c0b45b1d%7C686ea1d3bc2b4c6fa
> 92cd99c5c301635%7C0%7C0%7C637752703124166805%7CUnknown%7
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DrfmN1Xojubap2vi3J4Jol3ozy
> N1Q2q7YiBM5bqMm22s%3D&amp;reserved=3D0
>=20
> However, perhaps it's not too late.
[Richard Zhu] Hi Krzysztof:=20
Thanks for your review.
But I don't know how to handle this situation.
How about that I add this refine patch into the following bug fix and
 refine patch-set later?
PCI: imx6: refine codes and add compliance tests mode support
" https://patchwork.kernel.org/project/linux-arm-kernel/cover/1635747478-25=
562-1-git-send-email-hongxing.zhu@nxp.com/"

>=20
> [...]
> > @@ -446,6 +452,13 @@ static int imx6_pcie_enable_ref_clk(struct
> imx6_pcie *imx6_pcie)
> >  		break;
> >  	case IMX7D:
> >  		break;
> > +	case IMX8MM:
> > +		ret =3D clk_prepare_enable(imx6_pcie->pcie_aux);
> > +		if (ret) {
> > +			dev_err(dev, "unable to enable pcie_aux clock\n");
> > +			break;
> > +		}
> > +		break;
>=20
> You can drop the inner break, it wouldn't do much here, unless this was
> intended to be a return?
[Richard Zhu] Yes, it is. The inner break can be dropped. The error return
would be handled in the end.

>=20
> > @@ -538,6 +559,10 @@ static void
> imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> >  	case IMX8MQ:
> >  		reset_control_deassert(imx6_pcie->pciephy_reset);
> >  		break;
> > +	case IMX8MM:
> > +		if (phy_init(imx6_pcie->phy) !=3D 0)
> > +			dev_err(dev, "Waiting for PHY ready timeout!\n");
> > +		break;
>=20
> If the above, you can keep the same style as used throughout the file
> already, so it would just simply be:
>=20
>   if (phy_init(imx6_pcie->phy))
>=20
> Also, a nitpick: to be consistent with other such messages here, the erro=
r
> message would be all lower-case letters.
[Richard Zhu] Yes, it is.
>=20
> [...]
> > @@ -614,6 +639,8 @@ static void imx6_pcie_configure_type(struct
> > imx6_pcie *imx6_pcie)  static void imx6_pcie_init_phy(struct
> imx6_pcie
> > *imx6_pcie)  {
> >  	switch (imx6_pcie->drvdata->variant) {
> > +	case IMX8MM:
> > +		break;
> >  	case IMX8MQ:
>=20
> Would it warrant a comment that adds a note there to this single bare
> break?  Perhaps this version is not support, lack this particular
> functionality, etc.
[Richard Zhu] Yes, it's easier to understand after add one comment.
>=20
> [...]
> > @@ -1089,10 +1122,39 @@ static int imx6_pcie_probe(struct
> platform_device *pdev)
> >  			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> >  			return PTR_ERR(imx6_pcie->apps_reset);
> >  		}
> > +		break;
> > +	case IMX8MM:
> > +		imx6_pcie->pcie_aux =3D devm_clk_get(dev, "pcie_aux");
> > +		if (IS_ERR(imx6_pcie->pcie_aux))
> > +			return dev_err_probe(dev,
> PTR_ERR(imx6_pcie->pcie_aux),
> > +					     "pcie_aux clock source missing or
> invalid\n");
> > +		imx6_pcie->apps_reset =3D
> devm_reset_control_get_exclusive(dev,
> > +									 "apps");
> > +		if (IS_ERR(imx6_pcie->apps_reset)) {
> > +			dev_err(dev, "Failed to get PCIE APPS reset control\n");
> > +			return PTR_ERR(imx6_pcie->apps_reset);
> > +		}
> > +
> > +		imx6_pcie->phy =3D devm_phy_get(dev, "pcie-phy");
> > +		if (IS_ERR(imx6_pcie->phy)) {
> > +			if (PTR_ERR(imx6_pcie->phy) =3D=3D -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			dev_err(dev, "Failed to get PCIE PHY\n");
> > +			return PTR_ERR(imx6_pcie->phy);
> > +		}
>=20
> A question about handling of the -EPROBE_DEFER above: why not to use
> the
> dev_err_probe() helper similarly to the code above and below?  Would
> there be something different preventing the use of dev_err_probe() here
> too?
[Richard Zhu] To be aligned, the above one can be replaced totally.
I didn't want to dump the error message when -EPROBE_DEFFER occurs.
Anyway, I can make them aligned later.

Best Regards
Richard

>=20
> >  		break;
> >  	default:
> >  		break;
> >  	}
> > +	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
> > +	if (imx6_pcie->phy =3D=3D NULL) {
> > +		imx6_pcie->pcie_phy =3D devm_clk_get(dev, "pcie_phy");
> > +		if (IS_ERR(imx6_pcie->pcie_phy))
> > +			return dev_err_probe(dev,
> PTR_ERR(imx6_pcie->pcie_phy),
> > +					     "pcie_phy clock source missing or
> invalid\n");
> > +	}
>=20
> Thank you for another amazing patch!
>=20
> 	Krzysztof
