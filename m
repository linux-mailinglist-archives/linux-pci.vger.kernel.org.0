Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B924943F5DB
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 05:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhJ2EBM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 00:01:12 -0400
Received: from mail-eopbgr00068.outbound.protection.outlook.com ([40.107.0.68]:13188
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229504AbhJ2EBL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 Oct 2021 00:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7bZbPLkau1+s6m/kHoLB8/lKSfKzDrTGQyCfeYdT5YDG02Luq6tEfvic5a8rkFGfOutJlcNcTYMjna2EEBpb5LrXRH3vgaB1+2/rt9fZf334kv/3K99u2dtuq80sBrpn9aoVcjlUuh6VO4i696qQdtl0VswnpMlitTUeLYzEWCI8Y+5xhRrDTlDBjxIIKs81WHnCqRAsupv9bRpdZzwA01/CLNXdjc8CCi6JLtOy0/XfwkxgjsU+cyHcSHZj21Cnwdi9PNtZhKGFNf7L1wA7vUzkbck1U9DqqeHzvgM7e8jO6sYFyb9YuwM/M+k9sEqTzk3iimS6H7cjWCij1hTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlBGQJn23s3hsAqInu45nAjr8rVEzi+xTRsM/rvghcM=;
 b=TnRWnHxfx+uNj6Y8iMRG0+LNNZW7Eh5+83XDAEdsbNkFUKUV3XTez+OpoOFNY+FMm0hz4i35+0L6C9LJ/qiqVvi0sUhQYRKMZCaZu+E0a7JojDIlduK5YEfPV7mh4GmJh1c7SnW2wy8D6abMRF3C3GeoxK4W+qr7IffAkKnbKy70/l3/BoHpgJqjT0Fb38QZrdEgDvjhlMPOnY+BNKoeemaP9ZTrqIYwXY4A/i+XA+ERwxFBY+RIDZ1PKhc6UFPnavpYXTiBZpCNvjKqcKc08gl8r9ulGjWBkQo7IA3h5NbqED6do9dDEHjNtemOiGDM5Jzedgm//K+lK7HKsdQgIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlBGQJn23s3hsAqInu45nAjr8rVEzi+xTRsM/rvghcM=;
 b=sZs1+6bSufI5Xn+fcC+MvsjGXahGqijUSPJC4JUD8D2PRlmmXxK5tPybbxt6EWXk2JLwP7kx6B04zbp25y/tR5VyHCMweMjDQ4MPtTzTyaKBYGSFTZwgsrp8GWqrjAUgA5ZvSlRqj4mnuMMrJqToLaHoirKeD8SV5y/sYCF5rsA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8434.eurprd04.prod.outlook.com (2603:10a6:20b:345::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 03:58:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 03:58:41 +0000
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
Thread-Index: AQHXxxe5hpSrQkcPqkWGr8lEYEKQh6vjlGkAgAAC9gCAAPQyAIAAlv4AgAFuIxCAAcUHAIAA/dUA
Date:   Fri, 29 Oct 2021 03:58:41 +0000
Message-ID: <AS8PR04MB8676CF52F4D8E9E4E6C07F758C879@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
 <1634886750-13861-4-git-send-email-hongxing.zhu@nxp.com>
 <20211025111312.GA31419@francesco-nb.int.toradex.com>
 <YXaTxDJjhpcj5XBV@sirena.org.uk>
 <AS8PR04MB8676A0F3DA3248C6A27801148C849@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXffRmvPYwetsg3L@sirena.org.uk>
 <AS8PR04MB8676AF8685A951E19B1CE0688C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YXqOcAIO2aYkr1sM@sirena.org.uk>
In-Reply-To: <YXqOcAIO2aYkr1sM@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fbd0374-61be-4643-5786-08d99a906568
x-ms-traffictypediagnostic: AS8PR04MB8434:
x-microsoft-antispam-prvs: <AS8PR04MB843442309891D8FB281AE23F8C879@AS8PR04MB8434.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsDk4ynvsmGuzFAOBV/ijoQIi22qQ1iTU9WNUikrWrj+bWeTZ23/y5MRlaem/ScfD96S8CVnxGHJUqDMLyTXzf5EHUEYAdnUkdjp7ly0idmJniTRH9qZq3vhlHNUjOV7ZqFgLUSB1EIu5035ouKcrVJ36GOkfn/91nsgb9peAcF9BTvEKRfNs5cw6o9iidEav7R/2xHDZs1j7U1wPioWkct91/OuxQ5Q1OLGkiR0OHkFecPiGVeYeaLgvNU/wAj1tKqnRedJgYYYYqTHI3klEq785ibmRcRwuldLi8Ml0vwG2Sl/ivuqZp8AWO445rn2Xf35YlXC1ug9z9KbFFbRLjS3bkodS+YNHGZHjYgpPI3WG2qCRx1gvJ1+k8skyk5ROIEFNi69p4cmWiEvd32AAV39TNR4iaWO5emd/ibpd1fLno4rCN18v4GoeG4Hk+OGuIn6k/tarcS6EV94bi8Aq2GnYMoEnn0YBKOa01bLq7Ovmgceovfnc4pjSoqQfnxAjWz/PXV7aQaMfks8JByLxzBRwkY5kBQVWcbQZmoKq4Dwtw2kl9dc/t1ZfzZ6Y04bXPJWhGwKJp/rmJZoI+94NaG2wOadnvKWlX+owsIsjTR94IkP1y4yhuCFlYnFQaAkBHjj2BbeVjqsD4QCAbWGg8PIqfknXY+MAhCJmTOu6y5xOgf/JTCK6VG1A2cKMIg/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(6506007)(66556008)(9686003)(66446008)(66946007)(66476007)(6916009)(316002)(83380400001)(2906002)(186003)(53546011)(33656002)(64756008)(508600001)(4326008)(38100700002)(7416002)(122000001)(71200400001)(55016002)(38070700005)(5660300002)(8936002)(26005)(7696005)(76116006)(52536014)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z8ZnGT8soMB/qgmC+L6XU6O7WfuIjt5ILDXu1KcB2KvqdkhJ4ud5G9Kerm11?=
 =?us-ascii?Q?I72TuPW/JR37G/NavlNY6VsSzdTq9wKIfZop2BHYDMqUVhOpHwlqxrONzRWQ?=
 =?us-ascii?Q?aWw04jw4NP5zVG8or0wVqHi1180wbu/AIplF8rT8wgIkZV+IjJb7ifAeWfgg?=
 =?us-ascii?Q?ZYPnwAR5IW9gKJa8NSUyHpdX9sWtEsHjjQT1shLNcK3eVNJT+7FKKcxHxaiE?=
 =?us-ascii?Q?YvsWJz1apJTe22yZDtRaVItNGXNkRiIt3azh2AsnrI21CYbk5iGEbiHlc7iQ?=
 =?us-ascii?Q?MzIIeJDYf1sfi3GuqHGI02cHtQJ4bnEsTk0EqzHsAJApN18Xi+ZWTLXjmnSO?=
 =?us-ascii?Q?BxplIOxWhT2orQkkpMWZU9P9pBe6tkHuBDJrLtj4WM1QKaapRF9hKpg/bgRz?=
 =?us-ascii?Q?z/xfUpKm/l9XeT7yW0SAF2mFLhGeuoZjki2uvVUO2WHKrRKbiybChFYIVY3R?=
 =?us-ascii?Q?kfW1eaYOwKz4cKOqZqrzT/dpvTCDdk8XSoj3OX/43Vw8u6uNx6vrvX1qpcNk?=
 =?us-ascii?Q?HQkuU6Sd0yBUWnImRmzGY4F0qDnQkS5UN08TXEL+VhHBVwc1WxIHjB43H3GJ?=
 =?us-ascii?Q?1GGSNc5AVZU7WlO5wvZ8glUqjqVXJlUGL8DayaUP7qTGgnj9q9p9x3Sz8nl3?=
 =?us-ascii?Q?iWG7tyapl4/pcuYzPnO+2ho5Sk/Nq0Nh31pqNtc67+QfaD4TcJzEoIN9S+6S?=
 =?us-ascii?Q?pjPvVGkm7B+MMtwwFfK22UIFOIf/gXfiIqZ9lG+uOWEA7N91qGJC4sDdZTZN?=
 =?us-ascii?Q?+b9h2lDt51/ncM91Lu699HCTB7CsiQ6nKg9XGLBwZQdKztftReVYbBdj0R1Z?=
 =?us-ascii?Q?MYxEsYibEDHkrc6wawT59hExoe6q0DiBftkHFX56tJqeygsHHDEyVwTgINJs?=
 =?us-ascii?Q?b6aA1LhFoZRhQY0eZZwX9Kq3Ql/LsvUU0GMg0oklMtMLWdWDUx2e+tEIAUbl?=
 =?us-ascii?Q?KWWAma2aaYdxbVk2WWIpEBNml1RnrXUhnmr8+YH4Zd0VtvhXT1alqF0pCJCo?=
 =?us-ascii?Q?whjGxLK2nrwaxTKWaPJrnULv0ib221ciyLssHWy3u3RuWbg/nSGKVUAuIpm1?=
 =?us-ascii?Q?T7QkLsDuFQa3iuNJ7RbTTe4uu9WNoALubenn6pFLMbCafrS3U5TfRtru7rVj?=
 =?us-ascii?Q?VF8NdGtlZ9H8GYpsp8vXLoTvlT2BmPdBryZBRv+cguCC7pqkESoY94sgJcfi?=
 =?us-ascii?Q?aOSsTU1Kq+YAvWDvSgtYnMWnOxS4C77qeYkZh1y91WKkqhGfx15MtAorZTPJ?=
 =?us-ascii?Q?Rcznp6pP3kovDIMs+9OE0op4wROEattcDLWFztqHUab54cq7Bnn/BB0wGQMx?=
 =?us-ascii?Q?d9NEt86tzAQBlvTAB3kpMtphZZsqVJTV2l7XnDqIREonyE9V8mg0q4Qbs2rh?=
 =?us-ascii?Q?rxL49nEtz94Cw8I85wPXSltTAz1++a4Ve88jJg823xMaJY2/6sqGbXbLSeQD?=
 =?us-ascii?Q?Bwjk4U3CGf1rS4VUFfRp8PHUJDv5/PUlJ3MIzeajwV9k7ZVSMRigWDa+hgcG?=
 =?us-ascii?Q?a9csVWRDvH8+h33jXUaI63BfZijY3nizQTqTR2TftRaIxm7B96kdL0rEdkui?=
 =?us-ascii?Q?wpejBtJwSMG4m2yz4UoQdI6WuKBtlZeuLtoK7SjgQ+yMaNI9hLkC/vcASofR?=
 =?us-ascii?Q?2g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbd0374-61be-4643-5786-08d99a906568
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 03:58:41.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWkbT0nV2+UiXXF07iLcdZpMkEyc6ovk0mJm1OyzYuGWAtVmlTnNsZdz/Q8PETQkknu9WNqGBTbev0HxwM64NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8434
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, October 28, 2021 7:50 PM
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
> On Thu, Oct 28, 2021 at 06:50:58AM +0000, Richard Zhu wrote:
>=20
> > > I would be really surprised to see PCI hardware that was able to
> > > support a supply being physically absent, and this use of
> > > _is_enabled() is quite simply not how any of this is supposed to
> > > work in the regulator API even for regulators that can be optional.
>=20
> > [Richard Zhu] Actually, this regulator is one GPIO fixed regulator.
> > Controlled by SW to turn on (GPIO high) or turn off (GPIO low) the
> supply.
> > In some boards designs, this supply might be always on(GPIO high).
> > So, in point of SW driver view, this regulator is optional.
>=20
> No, it's not.  The regulator API supports the systems where the regualtor
> is always on perfectly well, the client driver should not need to do
> anything to support them.
[Richard Zhu] Hi Mark: Thanks for your explains.
To disable the regulator explicitly, is a part of power save of i.MX PCIe p=
ort
 usage when link is down.
Because that this regulator might not be present at all on some boards
 (e.x: powered directly when board is powered up), so this regulator is
 optional from SW view.
>=20
> > > Perhaps it's not causing problems in this design but if the supply
> > > is ever shared with anything else then the software will run into
> trouble.
> > > There will also be problems with the error handling on a system
> > > where the regulator needs to be controlled.
>=20
> > [Richard Zhu] This GPIO fixed regulator is only used by controller driv=
er.
> > It makes sense to disable the enabled regulator when driver probe is
> failed.
>=20
> The driver should undo any enables it did itself, it should not undo any
> enables that anything else did which means it should never be basing
> decisions on regulator_is_enabled().  While the regulator may not be
> shared in the particular board you're looking at it may be shared in othe=
r
> systems.
[Richard Zhu] Understood. Thanks.
Can I disabled this regulator in PCIe probe failure handler without the
 regulator_is_enabled() check?

BR
Richard
