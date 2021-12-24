Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A5347EA74
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 03:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350909AbhLXCJZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Dec 2021 21:09:25 -0500
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:47790
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230044AbhLXCJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Dec 2021 21:09:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8T+O/9ri9cCRAdQWxVZV10yFHp8l11DSyXM6X9Lr5XewUw+3P1YpN0jdm0ltOeo6JeKXFg0eBtgDj/ywsEmGH2WH9IvoPBgVyJ2bA/VnySLck+UeJy/r3+1G55/CXmbWX232d6T7h+weJnTgNf44pnJpWpphcNBoTcnMXh9paCfLMklKAfy5okCsjIovk98R5lui++sMVdZlIbCHdbE3D7EGb/BkfGWZI9clWF9SpxGujeNHP+OvOh5mXa6cicYQUSX8eVUfa6OAn3lNWp1iyydiRGZvR1sE/x2kRGc/WeXccHn5hMhgUaY2qRgyDy2zHMpf5ycpOQfhcpTU0wJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDOJ+vjEOjpOcqEd4lL5eeAeAQFK5TuUtYcLN+ZrQSc=;
 b=aCNxcCqed7AL9GaHFYtwNIZi0wkSWtsYODwX6R8X9t9qByVPtfec3DR1OD0zdrUqZuiV1AhOa+Cgt4seL23mO1AZxGHCtyZZwJ7e82b2DkUwsEoUNKSP+dpW2fRQr4tnUmKWUfC32ysc/0dqLFL5qGIg0ABOXWTE+ftAtRmJCG20it7RFIsQMBsC8KJ2pg3JQ6PwL7iRBp5hghRDrFbOMq1kN5JWujMfkANygKcAJ4HvyUAB/i+0HYLNcb9GTiiN5Rop322cTfS5Hgt/YWl409WyDr+NmGrMURKU7GClu8ij8uPeaAlLFvezMHxR8YCdCiQ5HRMpvY1dM4iBOGpp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDOJ+vjEOjpOcqEd4lL5eeAeAQFK5TuUtYcLN+ZrQSc=;
 b=kVtnrtHH7TB57C9mFAGh7DmJQ3grmtzjgmBXrrtQRIXvtoVTehTUsNbwpHopDxwmSvKqz1WwBkyee7102dkxqssKds1/96Y7yz4ApUNtej4qCbTL5D1hB++KzgiyCzZXXKvJDURw4mhnQJ9b+cLUsKU/kRa++2E+WT9umFZjP9Y=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8914.eurprd04.prod.outlook.com (2603:10a6:20b:42d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Fri, 24 Dec
 2021 02:09:21 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::d15e:c0be:cc2d:77f9]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::d15e:c0be:cc2d:77f9%6]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 02:09:21 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
Thread-Index: AQHX51bdQrJfUAGahEmIU+86q0TYAKw1a7+AgACkc9CACgeLAIAA78yg
Date:   Fri, 24 Dec 2021 02:09:21 +0000
Message-ID: <AS8PR04MB8676DC6855B91B34E441E4648C7F9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1638432158-4119-1-git-send-email-hongxing.zhu@nxp.com>
 <1638432158-4119-9-git-send-email-hongxing.zhu@nxp.com>
 <Ybtuo0CzfUhoJwsT@rocinante>
 <AS8PR04MB8676F7F8BBE79E36D3EAFB6B8C789@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211223114958.GA30243@lpieralisi>
In-Reply-To: <20211223114958.GA30243@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65fad9b0-dbc9-4050-d469-08d9c6826660
x-ms-traffictypediagnostic: AS8PR04MB8914:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB891469ACDA3DB48BEA492C008C7F9@AS8PR04MB8914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6/TAU/qG8AENQ1o4Qo5bFf1fu8a+zFaCc0B+9So6FwpfPOcrq9XHTL0dsHK1T7YwUz9MCHR5C0HvFDOJto1/3Qqu2V48EDxrbBvBy3z1QOO5pE43rg850+PgO79LU8pYnCjrc4HLU7rkZ3gTjnAMKmeSFnvpBfHobH32oBd3PUAsG2iwj5AfiYtlZalAP7eiFezJKKPeV0AAtnCjxAlSQdmeCbRaxtVow2Upqv5irVWJYVvVujFrjnhB+/AYaXSfZMf3rU5I5kL/Dh8q7CXAR2mxf3zcOdbcZVphd6geQT+UmUpR3ty4sp0ZGh9PIZ6L7fY6UolhiLeC+U3KwrpFrz58S1zurU64JCgIJKJ9ZnRFjUX8sCnMd5R5GS82cNq9RRmJc9k6A4ErZmSqRdBoT9ZcsrBKCQ8KbCHqTPwGWYW2CmcnBWmasKKn9KKSGV2D3uKlRz1WaI9QRjHI9fjLbtLVA280lRPddhM8jDYvNb/OX1IDDtzrz5FymuvifVn/mozIacYiKmZBqKBZ9c99JNMIV3sts2fD9Q0ezfzJ6l4Ljw5mw3P0lxWc7hU7J/+OBcwo7D1cdP1ehkzIPjjrySdCksutRAi07QBb5aF8HRI8Edni1OfjgJfhE/SOsFu9B4tFv3R8V4P1iGpEEPwEKuwxE9bRqUsUB97KOE+3zp3iSfmErvlhy861ILTtMe1ZmsMyx6oypIS4p0pk1jop6Mj0oQMzKiZq+REBT3aLx1APKrADGfEgn7iKYh0QJrowBA5kHLQVVd+qBpDgzK+HiSs4bnp3EHuhy5+AefEbTQCJdhvwiZZqZjfUU22zpKYa/z0Dj+Ua2HitfEC+tJ10io1zosVpWrDGNkF4CUQGC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(508600001)(45080400002)(7696005)(9686003)(8936002)(7416002)(2906002)(83380400001)(316002)(54906003)(8676002)(66574015)(6916009)(122000001)(66946007)(76116006)(38100700002)(33656002)(66556008)(5660300002)(66476007)(53546011)(6506007)(66446008)(64756008)(186003)(26005)(71200400001)(44832011)(4326008)(86362001)(38070700005)(52536014)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?aWEqXjLO1RaUJ1v1hzgiKCaqg3/Olz3tt0dRs3055YaFRvYesprZt0V0C3?=
 =?iso-8859-2?Q?DiOCf+qdMOGKkYAJBZmZwU6fpolo4YXgO1ruoouvhUPwh/6RhGnWnGnBqT?=
 =?iso-8859-2?Q?RoqI53th13k05kjQT0zmJZRBMWwUkLvk0IoBgRGrIFjkekNM914rkExfQW?=
 =?iso-8859-2?Q?CPTKfUFqi4n5IInovBDOJQXDC3//0sHSWDztp56vL4ctg6VfCQA3Okb1Qz?=
 =?iso-8859-2?Q?CHpZzBxIIcCFp9plaEFT2c6Xmi1zHPdZt/UUIm/xeoKtN4Cl7smU3u9rKg?=
 =?iso-8859-2?Q?2bA8kLmWlWQPcpmGViA8fEtmn39Q9/da097CCfcRz9jo7LJmzp778sjFjA?=
 =?iso-8859-2?Q?c6WJzg0iGiBrRKKlNNjJO0t6ide0oHxrVjKoAfCWncHE71GpLWDX/mL77g?=
 =?iso-8859-2?Q?p/8F9JXL5vDpA0YAeaF+54f2Qfl7DKFCXfpChkxiyJLn9z/6oYjFEZbxzo?=
 =?iso-8859-2?Q?euG0aDKgrNBffn4H4TsSXkt0czA5uYw8YwdRrZJ/yqRlX2Q/sVtG2oKz6P?=
 =?iso-8859-2?Q?s+rJbYLfUpCYbWP3c6Ak6y92mgk2ClAZtRBn6GSBqOFZUZVmmE2FnJhT8r?=
 =?iso-8859-2?Q?8//eay/2ZBeY7IyEm0SQ+V6kjwHkVe7FnLL/bjCkl25DIHIzYi8LdctHE7?=
 =?iso-8859-2?Q?Mxw5axbJDCwEpuZUaxgT0xlZgCy+DHSKt8KU/W3TmElzC6Lew1rKFwbRER?=
 =?iso-8859-2?Q?fTD1ASZIGw+1f7xWHu8zR5ma3oqtmMkUkrx6spkvHPx36T7qSeVUZ1GIzS?=
 =?iso-8859-2?Q?OhTjAydWAaxycfXHWUXo+FCCVUbbrvSEyF1H60l0Wknx5/6aD6ggfK5ke4?=
 =?iso-8859-2?Q?meT++RrLNqWiRZZ1TGMyTvHd/dgPqAvPaV8MhCZqowCTZ4k3aZqc+GUARV?=
 =?iso-8859-2?Q?V1LjdaDf07699Bql96fQ9KvFlaEg4uuDhat7ssqUCKfFx5u5poud83JY7P?=
 =?iso-8859-2?Q?qfVPrR3RveFayN5gv+yh9V7cZSPbCXPtbDsGK5tSH55uTpMb4jcgAjRwBf?=
 =?iso-8859-2?Q?5GENvwhCX8etCqUuBkFWhk11nqoJC0A3YkFEEzDfX78Ucih7a9QRqomjLI?=
 =?iso-8859-2?Q?lmTDy5cXutrQRN5fh/Qum6XqREr7+7slDSRYK6fvkVT2sfL4pO52lLF14c?=
 =?iso-8859-2?Q?waepWffx/6aRTCekYtAQsAW6jb+VwFzzAfF8Y3Y1OOn3I/shWdMJXgUEgm?=
 =?iso-8859-2?Q?5YOvXmwjGXfnLl+iL69kvbIG7wrM0nOrAQWz82zOnCatckhK7A9Nzm8+jf?=
 =?iso-8859-2?Q?bv/paxgKRSlDoP+Nnn9Jn81TAUgewXC+BVwss3wtDOBakQuItLYahi3xs/?=
 =?iso-8859-2?Q?Rf1RTk5+Z6a8O3y9DqoYAON3B2rCuoJD4Okv0trQv3U6DKmBc79BSztHIG?=
 =?iso-8859-2?Q?mk2ywypP2KiDiKpdtOqQ7slYaTTkvt6eBaUOQwD/RbbkAxsd1H7ybx+iad?=
 =?iso-8859-2?Q?vm2hJsAsLp4U6uJ87A7tYkLPSJr9ngojGO1rNb02VnqHS+cYeiayoCsXVx?=
 =?iso-8859-2?Q?X5gZCSbqUgwHjKTDtB/RgT0di+5ZwWleXQ/EWAURyM2zg0qhqt7oJJA2l9?=
 =?iso-8859-2?Q?NPc2wlpjHmC2r9M/ca7r+nj98hPqQ0naAxLbJLYzknDGbl8N1uizj0LjUi?=
 =?iso-8859-2?Q?vyKJDG+8F2x07mijr5ZJV4NI9KvL7f7jbaOwxrfdQdOznnw3W0+Kx80A?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fad9b0-dbc9-4050-d469-08d9c6826660
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 02:09:21.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8yBGBSv3bjlex9GBvqPp5+pZZfhaT/IYXFNhfz4KAP5TXqyATvVKkwf5Usg5+153mtGO0tvUoN3QIz5OROwUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8914
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, December 23, 2021 7:50 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Krzysztof Wilczy=F1ski <kw@linux.com>; l.stach@pengutronix.de;
> bhelgaas@google.com; Marcel Ziswiler <marcel.ziswiler@toradex.com>;
> tharvey@gateworks.com; kishon@ti.com; vkoul@kernel.org;
> robh@kernel.org; galak@kernel.crashing.org; shawnguo@kernel.org;
> linux-phy@lists.infradead.org; devicetree@vger.kernel.org;
> linux-pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> <linux-imx@nxp.com>
> Subject: Re: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
>=20
> On Fri, Dec 17, 2021 at 05:54:21AM +0000, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Krzysztof Wilczy=F1ski <kw@linux.com>
> > > Sent: Friday, December 17, 2021 12:52 AM
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> > > lorenzo.pieralisi@arm.com; Marcel Ziswiler
> > > <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> kishon@ti.com;
> > > vkoul@kernel.org; robh@kernel.org; galak@kernel.crashing.org;
> > > shawnguo@kernel.org; linux-phy@lists.infradead.org;
> > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v7 8/8] PCI: imx: Add the imx8mm pcie support
> > >
> > > Hi Richard,
> > >
> > > Apologies for a very late review!  Especially since Lorenzo already
> > > took patches as per:
> > >
> > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo
> > > r
> > >
> e.kernel.org%2Flinux-pci%2F163965080404.20006.52416095516435017
> > >
> 49.b4-ty%40arm.com%2F&amp;data=3D04%7C01%7Chongxing.zhu%40nxp
> > > .com%7C8afb673348214261883608d9c0b45b1d%7C686ea1d3bc2b4
> c6fa
> > >
> 92cd99c5c301635%7C0%7C0%7C637752703124166805%7CUnknown%7
> > >
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha
> > >
> WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DrfmN1Xojubap2vi3J4Jol3ozy
> > > N1Q2q7YiBM5bqMm22s%3D&amp;reserved=3D0
> > >
> > > However, perhaps it's not too late.
> > [Richard Zhu] Hi Krzysztof:
> > Thanks for your review.
> > But I don't know how to handle this situation.
> > How about that I add this refine patch into the following bug fix and
> > refine patch-set later?
> > PCI: imx6: refine codes and add compliance tests mode support "
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> tchwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F1635747
> 478-25562-1-git-send-email-hongxing.zhu%40nxp.com%2F&amp;data=3D0
> 4%7C01%7Chongxing.zhu%40nxp.com%7Ce04c6cda020b4f3849bf08d9c
> 60a5da0%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C6377
> 58570100053598%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwM
> DAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;
> sdata=3DjoTJZcYJhmYlzSTWY%2BhGCFV5ch12HPR4mbbOwZ5vcO0%3D&a
> mp;reserved=3D0"
> >
> > >
> > > [...]
> > > > @@ -446,6 +452,13 @@ static int imx6_pcie_enable_ref_clk(struct
> > > imx6_pcie *imx6_pcie)
> > > >  		break;
> > > >  	case IMX7D:
> > > >  		break;
> > > > +	case IMX8MM:
> > > > +		ret =3D clk_prepare_enable(imx6_pcie->pcie_aux);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "unable to enable pcie_aux clock\n");
> > > > +			break;
> > > > +		}
> > > > +		break;
> > >
> > > You can drop the inner break, it wouldn't do much here, unless this
> > > was intended to be a return?
> > [Richard Zhu] Yes, it is. The inner break can be dropped. The error
> > return would be handled in the end.
> >
> > >
> > > > @@ -538,6 +559,10 @@ static void
> > > imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
> > > >  	case IMX8MQ:
> > > >  		reset_control_deassert(imx6_pcie->pciephy_reset);
> > > >  		break;
> > > > +	case IMX8MM:
> > > > +		if (phy_init(imx6_pcie->phy) !=3D 0)
> > > > +			dev_err(dev, "Waiting for PHY ready timeout!\n");
> > > > +		break;
> > >
> > > If the above, you can keep the same style as used throughout the
> > > file already, so it would just simply be:
> > >
> > >   if (phy_init(imx6_pcie->phy))
> > >
> > > Also, a nitpick: to be consistent with other such messages here, the
> > > error message would be all lower-case letters.
> > [Richard Zhu] Yes, it is.
> > >
> > > [...]
> > > > @@ -614,6 +639,8 @@ static void imx6_pcie_configure_type(struct
> > > > imx6_pcie *imx6_pcie)  static void imx6_pcie_init_phy(struct
> > > imx6_pcie
> > > > *imx6_pcie)  {
> > > >  	switch (imx6_pcie->drvdata->variant) {
> > > > +	case IMX8MM:
> > > > +		break;
> > > >  	case IMX8MQ:
> > >
> > > Would it warrant a comment that adds a note there to this single
> > > bare break?  Perhaps this version is not support, lack this
> > > particular functionality, etc.
> > [Richard Zhu] Yes, it's easier to understand after add one comment.
> > >
> > > [...]
> > > > @@ -1089,10 +1122,39 @@ static int imx6_pcie_probe(struct
> > > platform_device *pdev)
> > > >  			dev_err(dev, "Failed to get PCIE APPS reset
> control\n");
> > > >  			return PTR_ERR(imx6_pcie->apps_reset);
> > > >  		}
> > > > +		break;
> > > > +	case IMX8MM:
> > > > +		imx6_pcie->pcie_aux =3D devm_clk_get(dev, "pcie_aux");
> > > > +		if (IS_ERR(imx6_pcie->pcie_aux))
> > > > +			return dev_err_probe(dev,
> > > PTR_ERR(imx6_pcie->pcie_aux),
> > > > +					     "pcie_aux clock source missing or
> > > invalid\n");
> > > > +		imx6_pcie->apps_reset =3D
> > > devm_reset_control_get_exclusive(dev,
> > > > +									 "apps");
> > > > +		if (IS_ERR(imx6_pcie->apps_reset)) {
> > > > +			dev_err(dev, "Failed to get PCIE APPS reset
> control\n");
> > > > +			return PTR_ERR(imx6_pcie->apps_reset);
> > > > +		}
> > > > +
> > > > +		imx6_pcie->phy =3D devm_phy_get(dev, "pcie-phy");
> > > > +		if (IS_ERR(imx6_pcie->phy)) {
> > > > +			if (PTR_ERR(imx6_pcie->phy) =3D=3D -EPROBE_DEFER)
> > > > +				return -EPROBE_DEFER;
> > > > +			dev_err(dev, "Failed to get PCIE PHY\n");
> > > > +			return PTR_ERR(imx6_pcie->phy);
> > > > +		}
> > >
> > > A question about handling of the -EPROBE_DEFER above: why not to
> use
> > > the
> > > dev_err_probe() helper similarly to the code above and below?
> Would
> > > there be something different preventing the use of dev_err_probe()
> > > here too?
> > [Richard Zhu] To be aligned, the above one can be replaced totally.
> > I didn't want to dump the error message when -EPROBE_DEFFER
> occurs.
> > Anyway, I can make them aligned later.
>=20
> Can you send me an update for this patch only so that I can update the
> corresponding commit according to this review please ?
[Richard Zhu] Sure, thanks a lot for your kindly help.

Best Regards
Richard Zhu

>=20
> Thanks,
> Lorenzo
>=20
> > Best Regards
> > Richard
> >
> > >
> > > >  		break;
> > > >  	default:
> > > >  		break;
> > > >  	}
> > > > +	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver =
*/
> > > > +	if (imx6_pcie->phy =3D=3D NULL) {
> > > > +		imx6_pcie->pcie_phy =3D devm_clk_get(dev, "pcie_phy");
> > > > +		if (IS_ERR(imx6_pcie->pcie_phy))
> > > > +			return dev_err_probe(dev,
> > > PTR_ERR(imx6_pcie->pcie_phy),
> > > > +					     "pcie_phy clock source missing or
> > > invalid\n");
> > > > +	}
> > >
> > > Thank you for another amazing patch!
> > >
> > > 	Krzysztof
