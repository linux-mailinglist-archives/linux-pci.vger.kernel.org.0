Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F4A43DB80
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 08:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhJ1GvH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 02:51:07 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:44165
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229762AbhJ1GvG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 02:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms7Wr7ZLMaOUU5UEVinO2ffvnN7p4tmlv67XzoiL6VKqSHBzMs10DqJpOKTWDJLWC3NyRGhVrmZv2yKZwZ43WVy3EhoZcGU4ku/mm3dvqzSOcUEkt752JfbiRdbJ3kR8OgeBbFEsGDBhbH60JsNzM2rug4zvWdNQQ9xWq81hYfWNBKOWpcfV6BAvN2awICyhysZ4QK3Qs+KIYbIa5CVX3cRSjbzoVNpXlQe3tTdYqM8v7m4nK/ktPNgxZkPqMCqQHAXlFLB26SQEoN4L9QqILRQXkZwGJ6DjRrAqvNz1JWwNv6qz51n+jKbmZR0rUKuyUULtZVqhhByCuRFIkNKu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkHfXwTaC2DPtnJI9rqN0zDytAo6z+4qabsAJug266k=;
 b=hRuygoqET9cE86lZfMOC/RKh2lBSZJfr4DcRtaUPqhCg94O8wY+C6MZDW6JYyRaOp+ZFVKFEvEgBMhaJyE5RLcWaJYWcP/rGg+40Ob8uKrBzqKT27Ncb0eNhdM2Ol7S5oxsHwqIw5O973JExxJjtAurgoGgecQ53d/cY7OmekrXG96Ng6/23nu0NauEw+Df30dFtWT1DslVCfimhtc0bModWv1lsWef72aZc/21EA+W4sQac1CC8A4khSnRoRx3YGuAuTUpOfTg5CBCeXey3giXFOHkQPyfQxnIsQHj6kUiNVYo7JWMY2UOgNhEY0iFxHUPfbTiPtEpjXMPj9TCQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkHfXwTaC2DPtnJI9rqN0zDytAo6z+4qabsAJug266k=;
 b=TP0Cd6GwzAvyL4y5vCgUKbhQHGMWhgVlllsF+D2/jsQnnGDt9JwzY7l2EN9Ym6pstBEpdBdGhfar6nzgFqj5mZxBJN2b3/RFM7x1Vs54pV7y2S8EU4roHezeJmHYlMbf8b7E1TPgIt4MVVbUUyRlSPBrVBCSVFLoxPQWgWMqG8c=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8594.eurprd04.prod.outlook.com (2603:10a6:20b:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Thu, 28 Oct
 2021 06:48:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 06:48:38 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     Mark Brown <broonie@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAIAAc9KAgAABivCAAAPIgIAAANdAgAAJmYCAAYEAIA==
Date:   Thu, 28 Oct 2021 06:48:37 +0000
Message-ID: <AS8PR04MB867600CAD244395B2AF2E8A08C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026085221.GA87230@francesco-nb.int.toradex.com>
 <AS8PR04MB867692D946818A84575F71AA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026091123.GB87230@francesco-nb.int.toradex.com>
 <AS8PR04MB8676A2D17A859730230CFBAA8C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20211026094845.GC87230@francesco-nb.int.toradex.com>
In-Reply-To: <20211026094845.GC87230@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624b78f2-0814-41b8-ec49-08d999def87b
x-ms-traffictypediagnostic: AS8PR04MB8594:
x-microsoft-antispam-prvs: <AS8PR04MB85947DEC1A51E651D269CE4A8C869@AS8PR04MB8594.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BztBeBNIlk0E3oV6Y9ewreyXQPrBfkgkGecH+BlyZyj7bmySAcQWfGol4dZ2TtOtCL/W1Oe/fBANyGg0V5l4hvi+sEZeIcahB9jxFjMajdUW6+x3c5PtkOL2nUTpJ6y8dFvsiVj04wBTy9x+3W124qwcUT769MX6nEw+kr6UwQs7aI9XQSsC7PQ/w9TyCYzBZ1lNBmFNwS4XVjzjk3BtABsWfxls65lD7Kj36TqDegANe0wDhSajoYMizyIUxaDgCnmkdS6CPhlS437y+//9gej83zPWKSKda2K28xlIvJioYM6Wd0A8TsMBhzZ89L38Pt93Jkt2TkxpcICoAVYZDlCtR9pDwZCbrQfjYIynAvGE7rGPckkE8+LQR6Emkchm3C9kEpzXyexY3T2FjBFfN/GKGDIqaAnUvG02BNuGog2S0Sx5MtziLFwFfzTsDc92N/kWKckyjlawNdbUokqW2dMG9oH9t/OuSVhq0+1eV9XqtfugTWuqmH7kaYkPsDmwjiJlQBdK1xKh02llH4B0wRTYv+ddJDdYNMPQzKdioupG2/61xv3j1+PvInUzXPLr7VbTcKFo3xlKjvTPDWfkxoUk66ABuXB41zL3cNxxoOekhfIHawuv5Ao5K0MoYL8/VMtcrK+09xpW9SY9n8/ewPRNuVRVrJzjUL1OYGsAs5K0B3flkdUiJObtzG0biLFHhRO4ia8SD+rx1TDSBKdMkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(54906003)(26005)(9686003)(66446008)(7696005)(186003)(66946007)(66556008)(6916009)(64756008)(83380400001)(66476007)(76116006)(6506007)(53546011)(55016002)(8676002)(4326008)(122000001)(52536014)(7416002)(316002)(5660300002)(86362001)(8936002)(38100700002)(33656002)(38070700005)(71200400001)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LPM6925RYEl/B66oo3sYI9PeJSvvgaLYr7kp37ulWa4VWcvureGcYza1OI+G?=
 =?us-ascii?Q?vdcDIEryykknrfjAFRIFowZjWs0VR4JnZal3O3fK4YJskeuDCCWzMGRqORJQ?=
 =?us-ascii?Q?Siv6LXwroK7BKy0BKCLnPRpAC0Lh+1hF8DeIVqdKRxa8C/DBK8LTIQPgS1pS?=
 =?us-ascii?Q?i53Y60SXexWj+5bV1uQxfpZ9SPb5SRgWDtoCq1bigydclvi4duS+c39D0erW?=
 =?us-ascii?Q?cNAgksdANsg6hpwldbZpBY5Xfvh7hOTq5HfJXVWABdVplOBYZPlLGzUdnzO0?=
 =?us-ascii?Q?6kKXY7drT/j6o8Q9yZhHhkOKpWXyDe+v8OL+gqXq0n4jSYQDWeLfJiKjlf6r?=
 =?us-ascii?Q?Oq5rFxGFU9agPqX0cEP00IAopmuy1j8LVzOiey4u0rQ0CL33t5quW3cbJb8w?=
 =?us-ascii?Q?RWj4lllDrsDYtFmekPymxpDW9s+G0EkaNNHPSq3nDkqk37/xjSX5HE0cVRau?=
 =?us-ascii?Q?LjQbaM2OqMsoF1VBDrcbeXyV3xP4W+Xx1MqYGZtB2JLYvLuOhrCvEjucfq+u?=
 =?us-ascii?Q?TV/LQpKjgvAbvTgWzRbMCizClKeXiobDAhj/gXdeuMQB+G7ZziNjlu62kne8?=
 =?us-ascii?Q?pj+bo5lVCdQolyVH2QBbeoIFEm6iR8+gG6/IFB0b1pKjuHgAjdmoTr1UYZ8e?=
 =?us-ascii?Q?hEzD9HLv917YWY53A6i7DJkHW2Uz6WHwtFQ3QJAUGUDSXMqokswM0rEtt/4t?=
 =?us-ascii?Q?tzVfo0bO8ELq+7gF6iSJDE62N08K6Z92MRsZdOh1vH/XxLkBvkKjGhohShX+?=
 =?us-ascii?Q?C9dx+z7TcOnj2spx5Lm6IpyW9j2cOsjBHl47d3WYbDIdSvbhqOKPApS4YGM0?=
 =?us-ascii?Q?4GfL1xvbpjf+f7GfUIhhHxrTiDXlOC3dB0byft/vaoZZbnqlnF8a5rAbvqxc?=
 =?us-ascii?Q?05YbzsGvk9Ug5D0rD1Ex6bqMrkUV4Sg4zoT2MNQjDq+sWA0+d8E2SBGNGzgT?=
 =?us-ascii?Q?CephzgTTowpS//NFKAG2CfgEJR9da8t6/wqk0GN9Qi0IgUi8xcEt4AzAhaes?=
 =?us-ascii?Q?QgUGsgEDy6DVGA/lNlf5SQ0VxmyeJuglvWE/vBiIfz00ZdQRT8QExXYBZAhA?=
 =?us-ascii?Q?/a58oLjwnGH01kWgzbJwRMH675Tk9WAqUEhUujUV0BYhCf2LZ4sTcJTOEjHS?=
 =?us-ascii?Q?qEJBszsF8DlS6AmY+R+Y1HlrTk76BAJU+WgMSIiujzGw/trTo4a01tsiHHjW?=
 =?us-ascii?Q?T7J0KJf+VMUmYs5+ag8RwD2GkEQ4M18NazvSHvqkBkWzUOFESsi4hTCpzZQe?=
 =?us-ascii?Q?lWHG4TNZBh69Yc5F2d2YtAmceu0GwZwL2QEpnvmw9gcnQUawMzfMZkI17SNc?=
 =?us-ascii?Q?R/w8iMYx5waykc7uCqOu8PXKuT/uG9s6G91Ixj/V9KQAAQDa7vo7zVICu5a+?=
 =?us-ascii?Q?TY2/LH7ERZa4Xe6XUJN8uZE/a41iQMkuCthM/QbNYhKFgVmh9cw8bafO1lfB?=
 =?us-ascii?Q?b/IE/93nVaMSpyRdJP15VGy+3RD9Bw8xsZm3qu9oixCioxfjOIZNgPxNUYGk?=
 =?us-ascii?Q?5zBAIOnySBtqB82E9ovvVPHMQJNil+I5n2qY8wslAoA+YfgkLcF1GtsdMr1N?=
 =?us-ascii?Q?i3oSbqMh6BwpTL2/pXZeTfRPDDemXoUietLDZddcs4d6RbwLimozPWBnL3o5?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b78f2-0814-41b8-ec49-08d999def87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 06:48:37.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvGD23FTAv76OVKgux7TamYYT32I2/QTyuDTxdqypdDapQkCRAq408vGPEZm8k+bHSVRJu5fGu8vRWGR0F4aCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8594
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> Sent: Tuesday, October 26, 2021 5:49 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>; Mark Brown
> <broonie@kernel.org>; l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link
> never came up
>=20
> On Tue, Oct 26, 2021 at 09:18:39AM +0000, Richard Zhu wrote:
> > > Isn't this something that depend on the actual board design? From
> > > the driver point of view you should not silently enforce such design
> > > requirement on the board.
> > > Am I missing something here? Would be glad to you if you can clarify
> in case.
> > >
> > [Richard Zhu] Yes, it is relied on the actual HW board design.
> > This regulator is one optional, not mandatory required for all the boar=
d
> designs.
> > So, there is one _enabled or not check before manipulate this regulator=
.
> I think I was not clear in my question.
>=20
> I'm asking what's is going to happen if the vpci-e supply is used in the
> actual board design AND the same regulator is shared with another
> device (to my understanding this should be just fine from the regulator A=
PI
> point of view, correct me if I'm wrong).
[Richard Zhu] Yes, agree with you.=20
It should be fine from the regulator API point of view.
BR
Richard

>=20
> I'm not talking about board designed by NXP in which such use case might
> not exist.
>=20
> Francesco

