Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BC543DB88
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 08:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1Gx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 02:53:27 -0400
Received: from mail-eopbgr40066.outbound.protection.outlook.com ([40.107.4.66]:11030
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229784AbhJ1Gx1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 02:53:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILknCp8ityMvDHlWx2lg8igBernJzwOY1jLY0atpE9hTpaHiDKHT7JbNYkK7VBjFeat7ODdqZHSjqgo0QBfKln01d7/Y+cYU6rgraLA0mhThu4lHChER0w/ZV0JL+BfOv0xTjnwQdbEtH1mdK6DAYDZenAryBwrwKg9QSuVyJby1EW67DRgodJyJqr7AbRkqMtOSOPpYUHxTcnp8jcvKxKKalJ98R8SsUjZ3xalQz3DxlACikQ1RoePRUxT4Xmplwr/ldkynGuD/ipX6LmJ38XhgJf01cSOBtPaiKflKsBY/KGqExFZ4ShnrJ5QIjdLjFbugDxJ90yzl7BwqBUFeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6fmau527/f3PG9X6FHgB0VpvmZKnPz6FODMSf+4KXg=;
 b=IX92Kvn2plU2/J2qK4WDcVXSkIhTnddH52I/JKCNbELI3dGjAsCIv/aGfQJRi4QxNeyiMRvh3izT1ywF7biJYD+GLoPVmLBNP5OX+wFEbmwy+5byO61pBSKilkKd+0ouB0Fd8Bxg9T/xYBeZXe6ANk4x5KELYFmvdu8/z+u0gQ6w1nP0mhL6Ar+ury32Mw+5qHTwlfAt4NHs7m0PNzChBMOJiwZxwciAjcAKlI2bElZb0CXgLFNKw6fJmemCZdz3tmwsgVasMbhV/g+1q5AsIGIbNlToRwtjYRBGKhkxK2lQkaWWIlZEiaxhOMdELwGc1dRFDtI8HT5rPup6ZtB6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6fmau527/f3PG9X6FHgB0VpvmZKnPz6FODMSf+4KXg=;
 b=UB6WQAOTCQRCijaZHGxN41Wu2EWZb5IOMRL1hMo+LzZvp9C2AUp20Ho/W0Noeu80nEyytiocgEnTSlfi5HnsLY3++7r3434Qb06pIN7HUhOPacBQSyltIPB4K+2+ukHf0YG993MjgavjKexg/JX6BgynkN25Pe522F8cLYPCHqE=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8641.eurprd04.prod.outlook.com (2603:10a6:20b:428::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 28 Oct
 2021 06:50:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.015; Thu, 28 Oct 2021
 06:50:58 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
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
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAIAAlv4AgAFuIxA=
Date:   Thu, 28 Oct 2021 06:50:58 +0000
Message-ID: <AS8PR04MB8676AF8685A951E19B1CE0688C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXffRmvPYwetsg3L@sirena.org.uk>
In-Reply-To: <YXffRmvPYwetsg3L@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd4e38b1-cf87-4313-bc18-08d999df4c21
x-ms-traffictypediagnostic: AS8PR04MB8641:
x-microsoft-antispam-prvs: <AS8PR04MB864167DA0B9BF8AB96013F778C869@AS8PR04MB8641.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ACvWo3uQbw4B+X2uoWpry7i+lyjU8CLSVX2BlyltWyJNX2a+ppnS3xVDsdxfYEBR8pRsttCQjgTp3NFQ5fIFC5YMF7vGK/67CdsGqsE/cmaihl2WC8crmMgYtFZpVk57L0PFQZu8YfFut/+0FwZ0v31DSsI9c9c9iTPNrSOiX6+Qzanop6eNOmaql38k5gP3TVV9l+G9TW9f1bnZl9BbS1zCtFm1HIiNyHlhv3tImWx/7QssXwVfcjtFMHQ0OsyMGBZdliUHgNMX7NUVemjeiOd4Cao4Yx2kHsCv0HoJztNDeHRHWKeFnYm5iWjoLCf2E1zn806eQmq9t+GGD+Um7QTBljMEZwnZ5TcEPsXzD1nOANL34pa6ULZJqle2emi43ocoVzhGZyj/u0DbnO4YQQCVQCecRG91lYBifnDT0IatQd5/9VPz2jCCWULNOOYQqHdy19R/KcWHHSEBOiJQS3DRyvWEsd3f/u8F9Jl1lb2Z74Sv5GSBYC/DJSXYLUpXDus9NpJB/8SXnHWoyt7wm9lD2g8R1Rf3pw3bsZIdAxT87Oq5CSWI03OM2WcXXf+QWYKkJbXFCifpmS5oz4wL7B4rvEOW1tS2Z57yg3raR5Dkh6h1pck9HGp3S5rkD0thMc5SX/gBEWxoLUsc1SkhdjaBtTKTa3RDlhYfSauz9XD/tEwbgEi5pu4bPJbJTUW7PfNgTszrCC/UDhOPpaTnog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(7696005)(26005)(186003)(83380400001)(122000001)(38070700005)(54906003)(71200400001)(38100700002)(8676002)(8936002)(4326008)(86362001)(52536014)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(7416002)(6916009)(6506007)(508600001)(9686003)(33656002)(55016002)(2906002)(5660300002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?npiNq2QDpHjij4XOCd/bd8erAW7ZSANCB4kkFa5m32Dtl/+ayOMNmrCs9gRR?=
 =?us-ascii?Q?gvb7JmIvNmSJeSA+iV4iXCrslqRmMph0gcvuWNBQGkDxYy/JvWbdbnSOkfPu?=
 =?us-ascii?Q?RV7fqFwCnv/pnOXWVtI3eabClWU6IWMeVVk/tHNC0LecTm4fb54PxdVK6eGz?=
 =?us-ascii?Q?lFPxgX4OhSaZVJVUTDqdO3PL9BGRM1wvFSZB/+7ZBSiWuIg+rpV3YpwTQa/T?=
 =?us-ascii?Q?e/jMDrGJJxMPSceCyZ/U60Iy70sMGVVV0ip3fJsodvXPsBKTWqWSzA6QCmc8?=
 =?us-ascii?Q?ONnslFbiTDHZTB+Nxe7J3H1Qb4WnqGaG1ctJPXRHJtm38/uMaJ+UeBKZymQq?=
 =?us-ascii?Q?tg37VYORGO6/4uOJnQ6bW/2gDPz1cOL5pGtnLrE4a9AkltMb26ekM+9EY5sC?=
 =?us-ascii?Q?iVNrA8byJgphAX5gVvgZ3Yr+d7DGGDkaigeQXsiOWdmGHLHJbZxi4wyWk4Ti?=
 =?us-ascii?Q?C/kx2wmaHNJgVKnzPQmmmoxp5OqazolirvveV4WPwEI0iudNZIgd6p2VijOk?=
 =?us-ascii?Q?Bv0yw04l8soiD5SUiLclw/sU7lxqHF9a5Rt1Q26zPPIFam7Qc/RohlFJZoK2?=
 =?us-ascii?Q?red+28P1FEcW+oVfvhIi1zSlSk2ok9EOEA2bGT+C6bqCnFLEws5JY8RrWrmG?=
 =?us-ascii?Q?GCp11ZNqWbFnqHD1KT8CmGOt9qaxce0tmE0yFhRn8t91Iva9aSrL/RQGOyQf?=
 =?us-ascii?Q?kxleP55DYeR6Xt8YaS32Vwo0WA7me+YdK+oAjGatEgZINwkac+a6nXI1UHx2?=
 =?us-ascii?Q?NRmaGzW+n+7ToXtE21loiLTqKsQ6ROmsvOi+112Ze/LjRUN+PFBhi9h5s4Wm?=
 =?us-ascii?Q?1Eve2iulPj+obI6+n+0mPUxz7XT+n1XkeU9kQIuDs6wTt+ATMel+Qyb0UDdm?=
 =?us-ascii?Q?8wP14qcsb7DQpq7UkrrLIrzjpS3B77mcwwC34uUdgi8qxxRmGuy7Dp07Db3u?=
 =?us-ascii?Q?hHKOmoVoePaggfrBUddkwanyzjiJmwyHATqH/vW/PclrEKpCdwFTpOaRJllE?=
 =?us-ascii?Q?NMgk4wp2HHJHbglDrKg+TBpkDhneujsWgkNzCyJnWrfxojrnAcwvB2iN32i9?=
 =?us-ascii?Q?gpFo/GwxDUymOtt3c7M4mmivD5ua7yV9UGkyv22mUF8xex6zwW6Yf4TP45DU?=
 =?us-ascii?Q?/Ug5MqbqwomSWAzoUJ+0aGb78mVZVstC958f3kvpiLqLm17WLrl67OUCx7DV?=
 =?us-ascii?Q?ye3Uy3dEW84eYqBWnEvBTE9oRbcOuy7BI0gbzSHmLgsI8jge7+RvfO0tAzJo?=
 =?us-ascii?Q?THJcyGtMu78Vw+cp3pLCLaL/PtikQ4LK4yeBN2TI5N/W1120py2q1dwsosys?=
 =?us-ascii?Q?KcnLuo1r5RfGWyYqKS5/ideBkICXzt6XDb1C0dXwLTrHGM9zciYx1ULkZguX?=
 =?us-ascii?Q?8HBdYZ+/WQRU3yn5IFuSF75JzlKIHCV2UeUJRLUa9S6Ac7S0+WAeHJsvLKq8?=
 =?us-ascii?Q?tWSZG2gTl1+Te7+YLOPYILCZ36F2bIROibGQ5qGYlYHJI5RKhQY9PYPxVunq?=
 =?us-ascii?Q?DCsCgUiW9Q3NkB8VQflacWUs6FiG894CSuU+IBh+qrmrrxI4Bq1XZEOg1Xrq?=
 =?us-ascii?Q?dnn02Qyiy1v9cE/GeFY8wGhot7ooTzEhrCW3lGUpwV4YOhP6GFg/dZl26Xll?=
 =?us-ascii?Q?/w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4e38b1-cf87-4313-bc18-08d999df4c21
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 06:50:58.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGegPMtWGx5Ge5whacxlJKvYk2RU+h45iBvSu7KFSPjNR2dxdpaVDHXNdayfRmJze78PZJ2Y8f7paEbp5Mh5nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8641
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Tuesday, October 26, 2021 6:58 PM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>;
> l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; jingoohan1@gmail.com;
> linux-pci@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de
> Subject: Re: [PATCH v3 3/7] PCI: imx6: Fix the regulator dump when link
> never came up
>=20
> On Tue, Oct 26, 2021 at 02:18:18AM +0000, Richard Zhu wrote:
>=20
> > > I should probably also say that the check for the regulator looks
> > > buggy as well, regulators should only be optional if they can be
> > > physically absent which does not seem likely for PCI devices.  If
> > > the driver is not doing something to reconfigure the hardware to
> > > account for a missing supply this is generally a big warning sign.
> > >
> > > I really don't understand why regulator support is so frequently
> > > problematic for PCI controllers.  :(
>=20
> > [Richard Zhu] Hi Mark:
> > The _enabled check is used because that this regulator is optional in t=
he
> HW design.
> > To make the codes clean and aligned on different HW boards, the
> _enabled check is added.
>=20
> I would be really surprised to see PCI hardware that was able to support =
a
> supply being physically absent, and this use of _is_enabled() is quite
> simply not how any of this is supposed to work in the regulator API even
> for regulators that can be optional.
[Richard Zhu] Actually, this regulator is one GPIO fixed regulator.
Controlled by SW to turn on (GPIO high) or turn off (GPIO low) the supply.
In some boards designs, this supply might be always on(GPIO high).
So, in point of SW driver view, this regulator is optional.

>=20
> > The root cause is that the error return is not handled properly by the
> controller driver.
> > I.MX PCIe controller doesn't support the Hot-Plug, and it would return
> > -110 error when PCIe link never came up. Thus, the _probe would be
> failed in the end.
> > The clocks/regulator usage balance should be considered by i.MX PCIe
> controller, that's all.
> > It's not a general case, and the problem is not caused by the regulator
> support.
>=20
> Perhaps it's not causing problems in this design but if the supply is eve=
r
> shared with anything else then the software will run into trouble.
> There will also be problems with the error handling on a system where
> the regulator needs to be controlled.
[Richard Zhu] This GPIO fixed regulator is only used by controller driver.
It makes sense to disable the enabled regulator when driver probe is failed=
.

>=20
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages
> much easier to read and reply to.
[Richard] Sorry about that.
BR
Richard
