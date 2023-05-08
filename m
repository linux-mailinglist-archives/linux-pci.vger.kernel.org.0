Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822456FA293
	for <lists+linux-pci@lfdr.de>; Mon,  8 May 2023 10:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjEHItm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 04:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjEHItl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 04:49:41 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2125.outbound.protection.outlook.com [40.107.113.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22FA13C16;
        Mon,  8 May 2023 01:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAcOnC+dccxLZOD/J7Zsg3v3C/lB9Rhg2YxT/MkTag6vxVjOBrSNZ110xRidVMLStJIMq21aKdUjRW83URFu6QdTmyBZI6oxwe+H2u6lB/dI9I48rh6s5B6ZfcX1DHAv8ZeguMGhik4DkgG/kntsTedQaYlyIt3e9526VHebZUEJdp5w+L1CR+GTtZjxg6ZZ3mHTTLpVkjszLHU/FwND7VrllhHcc0VhoVw6rQt20ERd7tWObZWQFzVqtSNquqcB+/qBQVHoJfZ5sRgZhd8WDA/hYpSWEO4p6L7gvPomHkLRug8O4YPhXuU36wIXOuERXzyljtK4UKP7lmPimiomPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcoUMZVmh/zHnFbWKFYi/DzI0S1D5iNHd2tthvaRKXU=;
 b=ViMmuelX/orNYwQp/G7yIc5j6N2yvBN77kmtrTtRFK+9xIXoyDwGW2RI+Kj/+X9MXBldOHpuWwogrB3snuvUBMR7GG7BjfkYr7XkE0rWNiY2g2xA0y9UjNaA5eBGhdDtj5Oif/bVnZdv3XiiiMC0A58Pw+1jgXCBIJIuNonj4z9Xw0y1j/R9/gGsTO9sEmmv4+PKpz1JWbfo4dFNauw1kWa3BD06j4fY41wuzzw3Mv7HpM6iTBIpj62Y/dQhDEYSOivAwA8wYLYRIz99TUvXY8OmTa1ExnzM+lUampu0o6d2jECE3Wxx+xz3Q6KE97OnrVA4TjMI5KuFPW3ORK8FJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcoUMZVmh/zHnFbWKFYi/DzI0S1D5iNHd2tthvaRKXU=;
 b=gFnTotidFZ80353KcyV7QfJOFrgHAbUgz7ewATYaDIiFvVPruEs3vlH86A/m3MrY8hN4ikFbd0jktWPEYeftprsjQXyu79oNULOwLj3SslYRpkMu7d6W2V9PzpHxlvy70WJSQQ6ThL/F+PS+8Wte7muaDulgddYT5MVzVyqJWMg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 08:49:36 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 08:49:35 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v14 10/21] PCI: dwc: Add dw_pcie_link_set_max_width()
Thread-Topic: [PATCH v14 10/21] PCI: dwc: Add dw_pcie_link_set_max_width()
Thread-Index: AQHZd/tr2BLpbVRjSUCcr62lJ7uIEK9F27qAgApF3ZA=
Date:   Mon, 8 May 2023 08:49:35 +0000
Message-ID: <TYBPR01MB53415A2FB9C17D88DC5FFCFDD8719@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
 <20230426045557.3613826-11-yoshihiro.shimoda.uh@renesas.com>
 <20230501194805.542ohktc5sexcxnb@mobilestation>
In-Reply-To: <20230501194805.542ohktc5sexcxnb@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_
x-ms-office365-filtering-correlation-id: 0a26e8f8-2236-4723-cbbd-08db4fa126a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVkW2+89S1ut0pZpvf0X7/nuZsGNEDc/EP9xS3B1WzykaLi8sWJp87VBGgzKPBrLY9VeSyh2IqZCP+khIUuyNTgdiL3EvHdImlxLgS1p0yv2OIhBULsEo7ss9urP4NhyKZXqvvBZ2NgtTDVXBR0AdETqNppBKj0D+RA50ibEOg07P13tQNhIRUafMA9qklAx+kY76u/wBpo3OZEsXQUe1QMVIMxFW0H8N/v2YvhEnGAmcd/0tchNAV9QcBi8W+2DEB+mPYJj8H4TNJps4FZTHBO+gotxVpF33KTOSZKwMOvctbQ/DVNVCwliQbuafk+coJO9fCQJv9/nPP3q1RDiWZIEQ6ekHjOtPW/ZX1FHV+wHakVDfCPb1ZmID8eevju2XKLc16vsv/gUj0+FzwOLdA/J6NOeirDejKOcTcEF1tixRcdbsAT0C4oGSiwCFnempdR08xv/Sn1xQXPWSl4dGCiq/+h2Vs4qyFEYqnk3QIx9PIj+ycyLJp76K7EXh4jo0c4Ch5hP/Jg/zDf2cCfwUEGwXM8wO4vwRLL6kHIRBjOGn+IcCBJvbH8Nziyhv+p3cI4OvJFcohcvI4MgcUEUGyVnmmugLEW9LJInWX+n9Vg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(83380400001)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(7696005)(966005)(478600001)(71200400001)(55016003)(186003)(54906003)(2906002)(6506007)(52536014)(5660300002)(86362001)(9686003)(7416002)(8676002)(8936002)(33656002)(38100700002)(6916009)(122000001)(4326008)(38070700005)(41300700001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+yGpTsyaXdKtDEnLds6/P8vb67jZhgzuGnqf5JPBp8WnfE6EG+RXCjEn7mcu?=
 =?us-ascii?Q?LdBG3qEoYMjN/a7GwVV6HIXOcdc/Ojd/OoXKBzYqfx+pU6HN6tjwf0G0SsIu?=
 =?us-ascii?Q?2U0Za+bU8qtF+stuAR4Uvae9pPo9yZz+aa5chUWcShUGrlw1JCYU64lKDrAy?=
 =?us-ascii?Q?3RK7Q+pPpRG/sCJ1jSxTfgTXfXXIMLEYFTeAFv1yxP733rB4KKW7oGJHjfJL?=
 =?us-ascii?Q?T61Tw5AoVXL/Lbq4wBA4pPC5HeFAeeGottCcNx+hDmU1BEkgBIS9q+CubSqU?=
 =?us-ascii?Q?O8SptkcBYW45HQrM8r274qywEBtGWKTHjqt2/aG+iFedVwI+DBdKem4l7T+L?=
 =?us-ascii?Q?kFtWUSOtSM7C3nZQY9kB3PsCdd5dZsM7jHrcC1PZ7SHRYKQIFs373lPKYvNO?=
 =?us-ascii?Q?h3GqPJt50ZONTtRf0ErGqLbUj9vZL8dKXZqGkHT/yqjMq6sGjTNwgyUa8QWD?=
 =?us-ascii?Q?lM3+9kKr30uDVu5bQXYKVc4HlLHYTZZJVZU5L/KB0Pitk7mlk36wi9CdYS8F?=
 =?us-ascii?Q?tHOIx1rMQnCf52vnon/5cFdzdcHAkXlufOcpxYNsxD1LX85JrxsOotQ9qXm2?=
 =?us-ascii?Q?TCnNW7sU4cfk2VYntBALF2sQPseNxjxPusHUajArHZF97xwv4duerRaXi0ek?=
 =?us-ascii?Q?/eNHQ+DI021D5SMSvXP4tpL1sZdY8ZFzQqMbo3FCKvSTFaD6InU3MVjVHkx2?=
 =?us-ascii?Q?Zk5WydZi1CgaZLUFPvLvcQzfkARxbNTManVV3jxvNoJPmq7NGTcC53ZqDg+X?=
 =?us-ascii?Q?C5+UTG4YBjsnmL4S/hQkOsiL2EQ+wF8O0NtAPJ84auTYN89gqq74TM0M/K6r?=
 =?us-ascii?Q?wuR6T3qBHk1aKnsEsPyhMpqf0tTFzTHLC3yZhbVDtgmzQEhDELAArTSXHJcn?=
 =?us-ascii?Q?BXIiquo//KZarPLMQVl+wcqgnYG4ONDFkwjTLvOzbSVoQQ19ZCGQbijpPBP/?=
 =?us-ascii?Q?ehrpLjggSYNRymM2dOupHyPuamXkMln1S1or/Q0I1kOtbZGdivOjYBYjvM/D?=
 =?us-ascii?Q?LC2w/rsi+05pHy23trr9P2121EtlrprcZ2uwiODB46rQKxw5XY9GaaY713gP?=
 =?us-ascii?Q?RS/7+4p2WZbi27yBQMAILUxNrEF4r2uFVPjitXNXq3u5eEoqqfjixEOZdzEY?=
 =?us-ascii?Q?LEtBn12aqcr+0W/ZTd++i3j6T9hjHgIXCznrT5i5GUgYeyx7DEhqRY6fW17g?=
 =?us-ascii?Q?8jr5vt0BuERcDoVwvkFF/9ZSTXWkciVAArm1unw7PBU5i7PbAzcV7N++gAS1?=
 =?us-ascii?Q?LxB/6z9rSegjImbosmUVyLFa42polpZXWY/eK6ERi0fNKNkXiGRzZi4poN74?=
 =?us-ascii?Q?A5yorh/VgJrUTFqjSDm2KwPi5JRSDH5VutPEBJRuY/qB1ndPYMws19v1iHac?=
 =?us-ascii?Q?zhc42+07sbtoUF8ero97rlcgODA9s6+m/ne+Cljgb7CCVqtUhdnt7P5+T4LS?=
 =?us-ascii?Q?OjiEKe99NSBL7OThvhEMFjrZjxorGR5gIdvQ6MxSOvYs09UkEPW1TmGf6v/O?=
 =?us-ascii?Q?DfhD0n1KKig3pfpxrru08pjAxFtHkTLaP2RywXRm4sxJQfSebl09V3qcicwM?=
 =?us-ascii?Q?I8tj6wwF9HB4Uycd1m7NMAYHt++5gqd3755STuNHmFb+zKV7DADaAQGjMs9w?=
 =?us-ascii?Q?vWPuEpfw9yYEGsDDXmbkSOvIqv63r6p7xXZ2acz04m2avQu69Uh8CHKZ3AlI?=
 =?us-ascii?Q?QrklRQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a26e8f8-2236-4723-cbbd-08db4fa126a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 08:49:35.9020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYHIjEgJyjefLyow7exwEfZ9/64PPGwmw8k62vbUUPdIW12Tkd1U8Ko8YEXzHL+F9HKk1dNRq+5lIpTZAlr4eLQt0ZEdMyWmkiPWKK8gedE1T412BIazANn9wBqFbhtV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5341
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Serge,

> From: Serge Semin, Sent: Tuesday, May 2, 2023 4:48 AM
>=20
> On Wed, Apr 26, 2023 at 01:55:46PM +0900, Yoshihiro Shimoda wrote:
> > To improve code readability, add dw_pcie_link_set_max_width().
> > The original code writes the PCIE_PORT_LINK_CONTROL register twice
> > if the pci->num_lanes is not zero. But, it should avoid to write
> > the register twice. So, refactor it.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 66 +++++++++++---------
> >  1 file changed, 35 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci=
/controller/dwc/pcie-designware.c
> > index 69358dc202f0..f8926d5ec422 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -737,6 +737,40 @@ static void dw_pcie_link_set_max_speed(struct dw_p=
cie *pci, u32 link_gen)
> >  	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, cap | link_speed);
> >  }
> >
>=20
> > +static void dw_pcie_link_set_max_width(struct dw_pcie *pci, u32 num_la=
nes)
>=20
> Why defining a separate method?

I thought that a separated patch could improve code/patch readability.

> Just move it's content to the already
> defined dw_pcie_link_set_max_link_width(). This could have been done in
> the framework of the previous patch.

I got it.

> > +{
> > +	u32 val;
> > +
> > +	/* Set the number of lanes */
> > +	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > +	val &=3D ~PORT_LINK_FAST_LINK_MODE;
> > +	val |=3D PORT_LINK_DLL_LINK_EN;
> > +
> > +	/* Mask LINK_MODE if num_lanes is not zero */
>=20
> > +	if (num_lanes)
> > +		val &=3D ~PORT_LINK_MODE_MASK;
>=20
> this and...
>=20
> > +
> > +	switch (num_lanes) {
> > +	case 1:
> > +		val |=3D PORT_LINK_MODE_1_LANES;
> > +		break;
> > +	case 2:
> > +		val |=3D PORT_LINK_MODE_2_LANES;
> > +		break;
> > +	case 4:
> > +		val |=3D PORT_LINK_MODE_4_LANES;
> > +		break;
> > +	case 8:
> > +		val |=3D PORT_LINK_MODE_8_LANES;
> > +		break;
>=20
> > +	default:
> > +		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
>=20
> ...this change the link-width setup semantic in case if the
> invalid number of lanes is specified. Your method now causes the
> PORT_LINK_MODE_MASK field clearance in case if a not permitted link
> width is passed.

Thank you for pointed it out. I'll fix it.

> > +		break;
> > +	}
> > +
> > +	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
> > +}
> > +
> >  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 n=
um_lanes)
> >  {
> >  	u32 val;
> > @@ -1040,36 +1074,6 @@ void dw_pcie_setup(struct dw_pcie *pci)
> >  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> >  	}
> >
>=20
> > -	val =3D dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
> > -	val &=3D ~PORT_LINK_FAST_LINK_MODE;
> > -	val |=3D PORT_LINK_DLL_LINK_EN;
> > -	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
>=20
> Please leave the setups above here. Link-training mode has nothing to
> do with the max link width.

I completely overlooked Bjorn's comment [1]. I'll keep the code on v15.

[1]
https://lore.kernel.org/linux-pci/20230217112101.GA3387033@bhelgaas/

> -Serge(y)
>=20
> > -
> > -	if (!pci->num_lanes) {
> > -		dev_dbg(pci->dev, "Using h/w default number of lanes\n");
> > -		return;
> > -	}
> > -
> > -	/* Set the number of lanes */
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
> > +	dw_pcie_link_set_max_width(pci, pci->num_lanes);
> >  	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
> >  }
> > --
> > 2.25.1
> >
