Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4C0466F9E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 03:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378023AbhLCCQH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 21:16:07 -0500
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:57254
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236338AbhLCCQF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 21:16:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DlZYi3jvISk7dsCY2BlmRrPH04ZUqy3DM4VsCZ0uXkvC2/TYAEyvPF8PmLxYw7CkmgKp7LacX/0wvlDI2cQOOXjcIFOsJzqM6Rwqvrg5bfP0f51Dp9TvaKEysfcXpnrA7xPaZ9HJz/DBFK6sQnbafGHfg8F+TcCj65YsivorPWzwT2+2Loy5h+EozYIx8fvr8YIe9sFZ0y5Lptr8YMi5vBxXKqcOyTXp6cfGPghOhr1ojgeZ+hcu5BvsXkwCaDZr2xMHveLVamAVxxrj2OpwpUiDs5zRyCNdTq8NwxdXx5FBZ6N6h16jkCI6v4RbNUcwEgw1n69IMscHwYkKiu042A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4At0NVmXCqyWH+9NLmtPjXuurnk2r3K8+mWWHXDZ3tA=;
 b=aDqR9Pg7kX88OAIIMh4QQ3TZGTagXxsDk883eGm1w3gJ6faLAAe7itpJ01jKiQOCh9YFgDfs3AYKWYB4piqxETF/8Om5UygIg7f+BcKoxeHu1hifKp2VRUeQ1DV73MX16M7FOKE57SwPghw1Bo+5Uztj1Ik5LnYzM9agnTn0pQQr3/yiqiId2cUp2hI/2qEp6jx3/3Dgo7f7v7gCtX1zRle9a3xQnYLSt3aEVl3o0DgMQ5P2dokz8vVBQRnKHGWPzJdxkYrr+Iv4BXMzMe4MOtpi6pR0xebEiNNJJK2GgcnjHvLcQl9d5YSUuyOocnwFdNTUI8qyx9ZC0BhTYYrVsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4At0NVmXCqyWH+9NLmtPjXuurnk2r3K8+mWWHXDZ3tA=;
 b=njaMDBdUrrcLs4IXhCzKN3k7M4vAO7by8dWKeqgxbzEvHrPx0+jHc0TH0TheQpR+FdtaSCU4+4Am+lFhm4sRBAEIRi4PvWQUqLfCrNq+c+4sVvyrWTookuNIobODHlfgvQPGbUnGNvxVslgNkmiaxdkctUKSnF4LBAV7nsNw4sY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 02:12:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 02:12:37 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "kishon@ti.com" <kishon@ti.com>,
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
Subject: RE: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Topic: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm pcie
 support
Thread-Index: AQHX3CMFKmekc+YLiESKUzSHx70p1awdqgqAgAEThyCAAA69gIABTGIg
Date:   Fri, 3 Dec 2021 02:12:37 +0000
Message-ID: <AS8PR04MB8676BB733117614CFDB334798C6A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1637200489-11855-1-git-send-email-hongxing.zhu@nxp.com>
 <20211201124419.GA13080@lpieralisi>
 <AS8PR04MB8676FE0B835E52FDD40816138C699@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <YahhobQWe9ndJR/j@matsya>
In-Reply-To: <YahhobQWe9ndJR/j@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73f6ece8-4c5c-4ae5-af81-08d9b60260c7
x-ms-traffictypediagnostic: AS8PR04MB8707:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AS8PR04MB8707C503A8CCFD70F35D6D618C6A9@AS8PR04MB8707.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K0zdkwkjEurDHAoskQ+5fumQtC9po37TZEKntPGDdnrpBPNKBVX7JJmGy7TY7MMZ83WBWxBkNGov6R+Hf1EdjxdL//N3r4btf66DOKXR8SA0Uh9l+HUkWBTwUVORZYz7lk5GF7pgqmo4YVuYx3NMCfcShtp47R3SYw2VloXGpQ6HbZthkwCqTjGY4ue7HOELGFq4uGPvc9cT9Rjl6l66Pfh87aktyK5oZCvkmwCWneqkKqOJg6BoHAdhWux0yC/C8VH6ph8xrce4scv4bGQUr5d3eBn7uYRPKJcoN2d9oe1lFTliKiAxVy95bpd7Bsm4ZLu7/4otxsjkvcMv8QeeFkknGfDgoywvA9sbPSZKF7Vri4yqF018RSum/JIuY7YNCE7B8LTObzIUaLWN1EHxiShwJzfNGaAGgijIazAvtJtVO5nhq+YxLjKKHIq5nfLA7MFT8YKob+NwKx/dWHa6BQus6QucaVQbCA+4315HrKFPoeJZ3ROfaAlozczQnmvoyCboIifRv5u6gZ71B/fmAYijp+Kmn9yIq89HRI4eodBKXQfhCZxPt6/dYcgQxJMq3+XC0xVA7HTKiDBxayqh7G3QSw5ZSXpUTumSjtGFHOI6DA6llrfllqNaWhIaBwSrTQ2mCzJoEgJa/UA714OB/mEBmDhG5JxJ9cXoyauJ7pKF3PbCRpsCCrR/1TXEzuOgP9wxglaQ46PpZQ/+xkVwKJXqCFthD1k7edwM/gkx70SASXRpdpVksNo/0wwuwAzZwC6hoO3o4MHo9BnYoxR5H2wkND0wg7foLvuyvz4Fq92hmeE8DYrqJ+Ic9v9x4uvU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(38070700005)(66946007)(316002)(64756008)(6506007)(44832011)(4326008)(966005)(76116006)(9686003)(66556008)(5660300002)(66446008)(508600001)(7696005)(53546011)(66476007)(2906002)(45080400002)(71200400001)(83380400001)(52536014)(33656002)(186003)(55016003)(122000001)(38100700002)(54906003)(8676002)(8936002)(86362001)(7416002)(26005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0w0kfdjpYzptkuHfoH2UaH7+giF6Xk1epP1qYRpT2mdtrjl+MVB+NueXOFxY?=
 =?us-ascii?Q?1kB6OXNKxOnz3cJEA9m2UazfyIS6Qw5eJfvQDr+nrxenCQPqsVJqxDcptr6L?=
 =?us-ascii?Q?Vs9yb0RsxKd8sek+qjlGRFYKslYT03VvXSoC3rXhRwb0XEfum2cwt2rXngYu?=
 =?us-ascii?Q?JZ6y2fHE7+mTTGUL/+b84AdbWi8F0s/KjTte8tXsTsH0rKY3GexV92WYav1k?=
 =?us-ascii?Q?y6AMwAv47bHcAsk3kxyIS+5rhsM3Q5FuFLZ4qr2HpaI3rFCGh4J3i/uecNBx?=
 =?us-ascii?Q?Th0+I3yt8uDQx2uYwgH6SYIzSNixqTbSwQZviEIMRnZ1ncmqkM7HdzDwIj1w?=
 =?us-ascii?Q?OBwCI72Gjpr6EgwvEmNek3Us5HsaceCIOj8CTfefOnSTh5G64RjNitwBISxX?=
 =?us-ascii?Q?GqxTWazhNdI60fQNgvj449E4BULbzK+grOLWCX2eJtRYppdDvvCGqjrisbAU?=
 =?us-ascii?Q?Ox3dg33PQO4FKfcuL5ka/+0zq9PdDxWHJX/4iH6At6u+xmu8yGcodJrtfnHT?=
 =?us-ascii?Q?Rir9wtQysznM3LSqgRg+ouyIJDLvhXEXTifAzZizJAzp4+nyHp1EzRXxKsmn?=
 =?us-ascii?Q?OLHIcy0Cef2++c1u1Jv8FwPbs6L200F4VFCMU93XxPazFwVSCjjbFB1QgoWi?=
 =?us-ascii?Q?NlbK+5b6jjnoLeg0dYYs6rycXAx1uGRpkcxI0MeKS+zNJ+6tpjGWbO2JIAHK?=
 =?us-ascii?Q?2XPEUJO0Kmjootf9O+O5Pc+0f1cDlnjDlZuWKrTNASrSqp1p1WfKfzXocHOg?=
 =?us-ascii?Q?7h3F/8KZtc0w0TiTuxr7g+1Z+oiUt18Fjq58lQI2Iq8Ihe3+3xT2DhWJfx8G?=
 =?us-ascii?Q?p687n2uJlFeTaNwao5MXmuI9DbhANO2mWG28XnDtupXQZlwa0k/405JErAJu?=
 =?us-ascii?Q?L/oRNpI1gfHDUqM3jraR5C7jmf0u6xMnHnpRYd5w18ITNE30QaMx5NSwkc5S?=
 =?us-ascii?Q?eRmpKkmFXO/RO3rng+BFbO8We60clGQJvfJfTlAZFgTFx1zS2mqm1+1sP3wW?=
 =?us-ascii?Q?8c6RhgZ2RDojptxzqMMale1eG13cCSoj5D5SrkDQtr8vXaxiyGWhNL8rSTR/?=
 =?us-ascii?Q?NS7pwD+7dI6B30brtgp2pK7mB9RaoIEH84whGIuIFKmCfvQV+i8yVQ8n3+7c?=
 =?us-ascii?Q?pxmzIpxhL4iAdVgOCYwUh3awHvcfNex+PQENb95OiXRTaB2xg8xekkLa7Qob?=
 =?us-ascii?Q?Ok+U/bdMhhhHcnUlHHcWaOxfuXvOyMuVVKWXOtJ/CXiETvHx+Bdcpz7hIZK8?=
 =?us-ascii?Q?iwY17MXSAy/StOePSfPT7SHDFqQ7gBQndP/c+Lexkqhh+/8hXkrOCZiJXSFF?=
 =?us-ascii?Q?SN1/4DrDvQfUQ2AMjlDLHFIZbLyNO6NwSYrsPhckW/bMVvgR7d8rYefNdesH?=
 =?us-ascii?Q?Y8BhW73uJv+xt2no9Oi3TLIg2Up3ETngA90JtqB4Nf3iH/Or3l9CkqhZd/Y5?=
 =?us-ascii?Q?2V0c4DdXqGxFfTY8CEAeFTy176I7Kl3t9v2dZuxeaxfJHVpblO6ePT4mvda7?=
 =?us-ascii?Q?pchZTCs1eQseBQch3TruYbdK2MPy2oLTuT+ymHqsfZJPYvH/8TZu4BHhTeBa?=
 =?us-ascii?Q?Kr5f5C1R48cQFVO2aiYTAkU6DFXxnjMnh0qzw/kelHMPbm0lkbAQTiF9QnrW?=
 =?us-ascii?Q?yA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f6ece8-4c5c-4ae5-af81-08d9b60260c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 02:12:37.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KucthsnSy8jGHl9qkjL2cHBrRYnIDQbjxpeQG4sDFHsXcGYpk6vy9CDNYVqJ+BwbQx+TBj0H5hTDKdzsY/ohXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Thursday, December 2, 2021 2:03 PM
> To: Hongxing Zhu <hongxing.zhu@nxp.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>;
> l.stach@pengutronix.de; bhelgaas@google.com; Marcel Ziswiler
> <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> kishon@ti.com; robh@kernel.org; galak@kernel.crashing.org;
> shawnguo@kernel.org; linux-phy@lists.infradead.org;
> devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH v6 0/8] Add the imx8m pcie phy driver and imx8mm
> pcie support
>=20
> On 02-12-21, 05:43, Hongxing Zhu wrote:
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: Wednesday, December 1, 2021 8:44 PM
> > > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > > Cc: l.stach@pengutronix.de; bhelgaas@google.com; Marcel Ziswiler
> > > <marcel.ziswiler@toradex.com>; tharvey@gateworks.com;
> kishon@ti.com;
> > > vkoul@kernel.org; robh@kernel.org; galak@kernel.crashing.org;
> > > shawnguo@kernel.org; linux-phy@lists.infradead.org;
> > > devicetree@vger.kernel.org; linux-pci@vger.kernel.org;
> > > linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; kernel@pengutronix.de; dl-linux-imx
> > > <linux-imx@nxp.com>
> > > Subject: Re: [PATCH v6 0/8] Add the imx8m pcie phy driver and
> imx8mm
> > > pcie support
> > >
> > > On Thu, Nov 18, 2021 at 09:54:41AM +0800, Richard Zhu wrote:
> > > > Refer to the discussion [1] when try to enable i.MX8MM PCIe
> > > > support, one standalone PCIe PHY driver should be seperated from
> > > > i.MX PCIe driver when enable i.MX8MM PCIe support.
> > > >
> > > > This patch-set adds the standalone PCIe PHY driver suport[1-5],
> > > > and i.MX8MM PCIe support[6-8] to have whole view to review this
> > > patch-set.
> > > >
> > > > The PCIe works on i.MX8MM EVK board based the the blkctrl power
> > > driver
> > > > [2] and this patch-set. And tested by Tim and Marcel on the
> > > > different reference clock modes boards.
> > > >
> > > > [1]
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > >
> > >
> hwork.ozlabs.org%2Fproject%2Flinux-pci%2Fpatch%2F20210510141509.
> > > 929120
> > > >
> > >
> -3-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7Chongxing.zhu
> > > %40nxp.c
> > > >
> > >
> om%7C3edb11e040e6412cf91108d9b4c85052%7C686ea1d3bc2b4c6fa9
> > > 2cd99c5c3016
> > > >
> > >
> 35%7C0%7C1%7C637739594698843569%7CUnknown%7CTWFpbGZsb3d
> > > 8eyJWIjoiMC4wLj
> > > >
> > >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> > > amp;sdata=3D
> > > >
> > >
> 5xlZSnBYs1SIIbMnmlQwi0qtfLDgKbueLNjPWIPD1pw%3D&amp;reserved=3D
> > > 0
> > > > [2]
> > > >
> > >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> > > tc
> > > >
> > >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fcover%2F20210910
> > > 202640
> > > > .980366-1-l.stach%40pengutronix.de%2F&amp;data=3D04%7C01%7C
> hon
> > > gxing.zhu%
> > > >
> > >
> 40nxp.com%7C3edb11e040e6412cf91108d9b4c85052%7C686ea1d3bc2
> > > b4c6fa92cd99
> > > >
> > >
> c5c301635%7C0%7C1%7C637739594698843569%7CUnknown%7CTWFp
> > > bGZsb3d8eyJWIjo
> > > >
> > >
> iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > > 7C3000&amp
> > > > ;sdata=3D1388J8dLuKUc6KEUnWj5pLpkaPDC4kTIZFF%2BPTspHZY%3D
> &a
> > > mp;reserved=3D0
> > > >
> > > > Main changes v5 --> v6:
> > > > - Add "Reviewed-by: Rob Herring <robh@kernel.org>" into #1 and
> #3
> > > patches.
> > > > - Merge Rob's review comments to the #2 patch.
> > > >
> > > > Main changes v4 --> v5:
> > > > - Set the AUX_EN always 1b'1, thus it can fix the regression
> > > > introduced
> > > in v4
> > > >   series on Marcel's board.
> > > > - Use the lower-case letter in the devicetreee refer to Marcel's
> > > comments.
> > > > _ Since the default value of the deemphasis parameters are zero,
> > > > only
> > > set
> > > >   the deemphasis registers when the input paramters are none
> zero.
> > > >
> > > > Main changes v3 --> v4:
> > > > - Update the yaml to fix syntax error, add maxitems and drop
> > > > description of phy
> > > > - Correct the clock name in PHY DT node.
> > > > - Squash the EVK board relalted dts changes into one patch, and
> > > > drop
> > > the
> > > >   useless dummy clock and gpio suffix in DT nodes.
> > > > - Add board specific de-emphasis parameters as DT properties. Thus
> > > each board
> > > >   can specify its actual de-emphasis values.
> > > > - Update the commit log of PHY driver.
> > > > - Remove the useless codes from PCIe driver, since they are moved
> > > > to PHY driver
> > > > - After the discussion and verification of the CLKREQ#
> > > > configurations
> > > with Tim,
> > > >   agree to add an optional boolean property
> > > > "fsl,clkreq-unsupported",
> > > indicates
> > > >   the CLKREQ# signal is hooked or not in HW designs.
> > > > - Add "Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>"
> > > > tag,
> > > since
> > > >   Marcel help to test the v3 patch-set.
> > > >
> > > > Main changes v2 --> v3:
> > > > - Regarding Lucas' comments.
> > > >  - to have a whole view to review the patches, send out the
> > > > i.MX8MM
> > > PCIe support too.
> > > >  - move the PHY related bits manipulations of the GPR/SRC to
> > > standalone PHY driver.
> > > >  - split the dts changes to SOC and board DT, and use the enum
> > > > instead
> > > of raw value.
> > > >  - update the license of the dt-binding header file.
> > > >
> > > > Changes v1 --> v2:
> > > > - Update the license of the dt-binding header file to make the
> license
> > > >   compatible with dts files.
> > > > - Fix the dt_binding_check errors.
> > > >
> > > > Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |
> 6
> > > +++
> > > > Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |
> 92
> > > +++++++++++++++++++++++++++++++
> > > > arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> |
> > > 55 +++++++++++++++++++
> > > > arch/arm64/boot/dts/freescale/imx8mm.dtsi
> |
> > > 46 +++++++++++++++-
> > > > drivers/pci/controller/dwc/pci-imx6.c
> |
> > > 73 ++++++++++++++++++++++---
> > > > drivers/phy/freescale/Kconfig
> |
> > > 9 ++++
> > > > drivers/phy/freescale/Makefile
> |
> > > 1 +
> > > > drivers/phy/freescale/phy-fsl-imx8m-pcie.c                   |
> > > 237
> > >
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > +++++++++++++++++++++
> > > > include/dt-bindings/phy/phy-imx8-pcie.h
> |
> > > 14 +++++
> > > > 9 files changed, 525 insertions(+), 8 deletions(-)
> > >
> > > Hi Richard,
> > >
> > > I can pull this series into the PCI tree (but not the dts changes
> > > that should be routed elsewhere) or give an ACK for patch 8, please
> > > let me know what's the best option.
> > [Richard Zhu] Hi Lorenzo:
> > First of all, thanks a lot for your kindly help.
> > To my original understand, #1-3 patch had been reviewed by Rob, might
> > be  merged into Rob's dt-binding git repos.
> > Shawn takes dts changes ( #4, #6 and #7). And PHY driver merged by
> > vkoul  or Kishon.
> > In the end, the PCIe changes(#8) are merged into PCIe git repos.
> >
> > I'm appreciated if you pull this whole series although I'm not sure
> > that  you can do it or not.
> > Today, I'm glad to receive vkoul's comments about the PHY driver part.
> > Let me continue refine the PHY driver, send anther version of this
> patch-set.
> > Then, let's figure out what's the best option to merge this series.
>=20
> I think phy binding and driver changes should go thru phy tree and pcie
> binding and driver changes thru pcie tree, dt should be picked by
> respective arch tree
[Richard Zhu] Hi Vinod: I'm fine with this option.
Please help to take the phy binding and driver after the review cycle.
Thanks in advanced.

Best regards
Richard
>=20
> --
> ~Vinod
