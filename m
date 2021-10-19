Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7240433044
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhJSH7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 03:59:12 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:34019
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230207AbhJSH7L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 03:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICPLOP1Ae3mtCz5iingCH6i7JQGbASUS2o9xKdupbS8dFD7lVXfh086y++gusXLWNNq/qjIHWFIXKVUETmSh/YxWRBYWV9tthLdGXo/NRHA9PdPqOgxSUWtwgMHL0/6cYIDm46uyvw9j2tRHecUBUwlrffF1UzlkSVidB7k/JsHq/7pJRwGbMdcngQqo2AOxj+Ky5g72lrMC5eFp359SV9E/Au9eE5b9/sJGJfHmxi2BwRMEyN9ffrRofwPjmtjEUbugsj1pjd3gjStuKrJ86asw4SnjhX2mxmFBcz9P8wu8YyRHcFy+gOYEGfufBeWlnObIpeMzSQEthUclj+0doA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EPi5+N+4CoC6uGMNB9Hh5w1qKfuk1SO+vyxbNxFmvU=;
 b=n1W5us85Zd+cM6zqX7X6Yz6lt5GAJR7KkhtFkwW2OMVI2t5jO9G26B9aC5T8CuOzWYTZK+fKjbtlqNJtKx0WNxQvm102PleR8h0Bweaidfsg6kOyCOnqu6ZG7deORSa7GupeTFjr4J+RUAVBGATI2bm5pAVYmcbTrnMxKF9BQ5MEG1ox+GRKA8omDHwoteG9G97w5lbUYO+fu0w6+/+XnooHcSncza6OuoucK0hN0e2E6n066YfszQ4PIvVEfZx38AqQj5WjBDEzlCo8skeAGMYV/zl0NLwKfQfJXORxeIG5sSpX4F3RAS5ep14r0eu9Tuhzs1GFbj8sIj4xs6JZvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EPi5+N+4CoC6uGMNB9Hh5w1qKfuk1SO+vyxbNxFmvU=;
 b=jXrqG6JHfo9xEg9QmVD+UhSKNlQcAe6TNmqE03FZ2gRgQIMsv50QTM0RPsWbpvYRui/nJotMF7FZCyk1Qjpg2aaIz7CrBtXTovUQLomG9FpvG1dedBY1u6aVf28yLyskS3Z4RcW1v9BmZdUoKAyedUQlb4IxsLYdEUdTZMNYdjI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8785.eurprd04.prod.outlook.com (2603:10a6:20b:42c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:56:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:56:55 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Topic: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
 unbalance when link never came up
Thread-Index: AQHXwY4ue+QOjCGA8ESB+dHo+5+VOqvUZ7iAgAAAjYCABY9dgA==
Date:   Tue, 19 Oct 2021 07:56:55 +0000
Message-ID: <AS8PR04MB86767ADAB5021E1C320094148CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20211015184943.GA2139079@bhelgaas>
 <20211015185141.GA2139462@bhelgaas>
In-Reply-To: <20211015185141.GA2139462@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e4f2953-8ac5-4b50-878c-08d992d60556
x-ms-traffictypediagnostic: AS8PR04MB8785:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB87856CD866DB98617B39E4BD8CBD9@AS8PR04MB8785.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5fggfcDSwdt/5PPw7nMKAF+2mULYtAibuHLNeySFElSCb9Ua0ds0sPrAO5ZH/m+AMBSoYZm/nsB24J2gDBIGyfB97dYnsnl08Mj5EGcra9FYYWOspHifnR4qWNynU7EsD9AExFfzyewhUUPBLWUhM3VUDQ4suUsgzDwalyxTmiBS6lZM9qZZ0IiyEpDcjHm6qZjubnXq47AicsdKPlf7wpm4C3W/bD9fNXG4rzmxvKTcVWIZ2mx9B1sIVDvFwNPWCShQuGYkW+LdYXHheW7yw0VsGc2yWh3GRuO85BNd5LZY4KdtpMZhJ8Stsse8U4AnAF5rN2vUWGzFB2kqDXOGbQYgjfF9+JnWO9zOq69Lo+vXHjPbKd9pEKeJ8Nb9x51cdSjqVLgTlJoaA6WZkqpp06htyKZe7y0AqMyUAFK9XH5xABOJdnt4tepl2gGDkmeAXYwihAxohM5M3as0ceBt74lXl2VNHWrWsdmn1ZBpGBvr9tWSeqkqBD73XgnBQVtnD4weZyd5LdQ/VnuplkX6bQXXZFXb1PLNl+80W5gw4b4PXZGTWBY+mcqu6/AtpkTdXJZcIS+Yrs21Y5psVOuOFSI1LdB7gtvAikQ2Y4a9K1W6f4EHDfJ2zxoYjEvP+WqnzUYLxjhs9/ORqRv+SpF/cZiq11VMfzvkeDKujZwqPbi31ryovRaTVOnigDPIbckWxecROTiOAu+1EGxRK39WIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(64756008)(52536014)(86362001)(9686003)(66446008)(71200400001)(4326008)(316002)(5660300002)(7696005)(38070700005)(6916009)(66476007)(83380400001)(2906002)(53546011)(55016002)(6506007)(186003)(508600001)(26005)(66556008)(76116006)(54906003)(38100700002)(33656002)(66946007)(122000001)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ou4M6REq+tUDvxLTrPmoU74NOhLQEWgiFAXCCC5bRhyYwoIyR3jHimUU5N2g?=
 =?us-ascii?Q?UvJIRg4MLp8N1ARd3a3MKUPJ4sD1malttbwHTHAjP9RRJk0Q0QblNJaB9XLh?=
 =?us-ascii?Q?tTnKF3IIRavfn685kukmvC8/dNhIElLuzYlZQijVbQI4txvMDGL6EyTn2huJ?=
 =?us-ascii?Q?fFJPXQFgTRXqrjUf8dWD4YxOsQS5El6BZ924ouBAqZiEYDdj4IU+6akSWeFj?=
 =?us-ascii?Q?BHraFJpHcsLMS49/7w6rWiF559VDsPlv+aGPxghMFBOfFpHqJpSA8Fijeic7?=
 =?us-ascii?Q?B/AxkS2JNsGbERP6CC/evjzrSyihbRmA6n+6BrQtrhIWkDys3Ag75enqyeaq?=
 =?us-ascii?Q?eXheDSh5vvzOos/0uKTTu+PRuepCSh1BF4JBgaOkkUZfkJ44B5HT4mqB9D0V?=
 =?us-ascii?Q?qs3oExaR20+E1hCuER+E39P6CTcctFA65WOWHP7hWhyOLucrYPGt9Q3oOmvl?=
 =?us-ascii?Q?+/DZJlYMNQyKV4+GVBei9NZZ9B1MFZJicrGU9dZh07cRhT6n22W0uu06djzG?=
 =?us-ascii?Q?7tn8zY6/Z4CN2rWwQHZwyxfQj6BPAUxWvWIl/JWH7Am8C544n/zjIYM7Wltt?=
 =?us-ascii?Q?W4OaQVdZSGPhl1zKSh4nzD+YQCYHviK2AylsDCSWVRss/wLV1a2Yn4ExySn5?=
 =?us-ascii?Q?bQI90kX/KnLgdqXLMfcqGvprIhM4I21Yz/2ncH8fuvl+GAGeNQJZNKE2vYTT?=
 =?us-ascii?Q?DJe1xcIM3tT16esH78FwEsYd23bg3VS+VFLWi5flJ6ZR8q9WVZTdlqL4WbHv?=
 =?us-ascii?Q?6Gl0uUgQtI7fmH6vFccsdvElpvWedhIS6XvyDJ78YKz1LAfDHSPz5V8r642u?=
 =?us-ascii?Q?RB2eWKXVAn4DAfeZuBfAfUvOEdnvnL7tW+hwxmAE9JV9vzBpZlQXE/zYXfnC?=
 =?us-ascii?Q?nFOqFM+x3/J5kuasU7cRGqq5yvubLnnXpJBmt2cL1FmGgivCgjHOhxiPaBMz?=
 =?us-ascii?Q?sWh8hEorxdM+Q6C1F09EHV6mQfehbXF9XN886NHQqSBDMk0cWTEIZEHFVWcO?=
 =?us-ascii?Q?JTwqPohPVXkk0CyjF+3DUYKbxWCWGV6aN+G4SrJu8v+qm0qormoAad7r8Vp5?=
 =?us-ascii?Q?W7teG7+OBo7HP7hkMk2mepG9MQ7zhTOgQkdVSuR/UtGvcrs+z43XSoywbcLY?=
 =?us-ascii?Q?hXrZo6lEvUDmEbAGpoxEHq+oHdg+mcupItdrylDjGZ0UqBAOYOAA92C8npiI?=
 =?us-ascii?Q?BTo9W3HkFDrJ3zz7Y8U1xyAsHBeqssP8xdqSgkAjkRPgC9FUPZruE0eK6ChO?=
 =?us-ascii?Q?8bmWqsVZUSW2bQ92HYIJkMztTmH1h24UrHDD51JaRtmoEMqSMCrwwhTjOjSu?=
 =?us-ascii?Q?PtmfYS+tcj3Te0U/54lRgiV6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4f2953-8ac5-4b50-878c-08d992d60556
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 07:56:55.8953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6V7LbWUdGMtVgqfTSQXxrge32b/L3wXAHjQNbF30Z3p79BwLAbSyNY+Zypl5gU11PLXGtzCcatEqxAbpwWhnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8785
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, October 16, 2021 2:52 AM
> To: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: l.stach@pengutronix.de; bhelgaas@google.com;
> lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [RESEND v2 4/5] PCI: imx6: Fix the clock reference handling
> unbalance when link never came up
>=20
> On Fri, Oct 15, 2021 at 01:49:45PM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 15, 2021 at 02:05:40PM +0800, Richard Zhu wrote:
> > > When link never came up, driver probe would be failed with error -110=
.
> > > To keep usage counter balance of the clocks, disable the previous
> > > enabled clocks when link is down.
> > > Move definitions of the imx6_pcie_clk_disable() function to the
> > > proper place. Because it wouldn't be used in imx6_pcie_suspend_noirq(=
)
> only.
>=20
> > > -static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie) -{
> > > -	clk_disable_unprepare(imx6_pcie->pcie);
> > > -	clk_disable_unprepare(imx6_pcie->pcie_phy);
> > > -	clk_disable_unprepare(imx6_pcie->pcie_bus);
> > > -
> > > -	switch (imx6_pcie->drvdata->variant) {
> > > -	case IMX6SX:
> > > -		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
> > > -		break;
> > > -	case IMX7D:
> > > -		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
> > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> > > -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> > > -		break;
> > > -	case IMX8MQ:
> > > -		clk_disable_unprepare(imx6_pcie->pcie_aux);
> > > -		break;
> > > -	default:
> > > -		break;
>=20
> While you're at it, this "default: break;" thing is pointless.
> Normally it's better to just *move* something without changing it at all,=
 but
> this is such a simple thing I think you could drop this at the same time =
as the
> move.
>=20
[Richard Zhu] Okay, got that. Would remove the "default:break" later. Thank=
s.

Best Regards
Richard Zhu

> > > -	}
> > > -}
