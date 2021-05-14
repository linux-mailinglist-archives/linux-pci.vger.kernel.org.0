Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ADB380553
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 10:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhENIhE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 04:37:04 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:26849
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230288AbhENIhD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 04:37:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtXh1J6yIh0or3KLkq1T0NpGYkePdWv7NG+VAGmOa/vmkwLTSnft3eiXJaABvW5OrnbdaLD29sfIkyoLnTrLWbp86apFLK1yQBBfs8tvNZzDcbnr6dfeiJ0ooDXRK6Pb2oG8T+sWsWF34JZWX2Camnj+/ELTLI5AVyDX9mSOuGGkXL4B/TxfvTLf9IhalfAGAgr5DgqnpX/qIqZqy3s2F8U11DHKxEzHJq1lasXUdWe/7y0IonLChEcJF2nRRfLT+oZExh+O2D/0axBi2sCJtOxHYIfVuDy1NYhWYOGzc5NUdql5q3b2iJmJbksZUk1GjLR68tjeiUUuzSDUFffa7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dRZ5hJW3c1t1Yw/F5t7bqPHg/7HCoqSCyHcIOW1J+c=;
 b=JxuZGcnXTEdZ2IRQw1HF+22rdjp29YVZhiKtbZFq6QzIrA0KpxxjEIT5w/9X1GGE935g91wG9r+zi6B/Vh/7Vg8cWcmCMaYHWb/zuvCCSvXhpS2Tt9431yb63VnPbM6Zr4q6caxVLZZ56IP5NYQ0xtSE35F7LCjlC6b1WtQW8nDZzTJQ6KxREYw1Gb6858v2RxW3Y+G/veD65XvHwRf5FmyXSOYsnxLwjk3ty9v+l9BAHhQcy3FYr1w3q626KYK4ELOpsn0js1BZJo3pO//iJ01nsYO+X8BJOWVRyuEDqlXAINlSeSQ6sBG0Qb8dncvZHa2ob5HxwLig6Dauiuu0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dRZ5hJW3c1t1Yw/F5t7bqPHg/7HCoqSCyHcIOW1J+c=;
 b=JlIU9jLEPf3G9bzYfPdae6ELhE1vJ8ypfqr8UkrHC3eHfdUz0r/1gwXbav16st2FY/gOvB4Vpy3s4Y64sbXN7/0vKRAQuTDxz54Y258PxNNQLlIj1tX5JI+0VCEGAlbXMgOTVFOeEvsIV2IPCN1J0OYxSxwl0PDlGRqsODNCSV4=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2685.eurprd04.prod.outlook.com (2603:10a6:800:58::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Fri, 14 May
 2021 08:35:50 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::c830:a7cb:c125:2fb7%6]) with mapi id 15.20.4129.028; Fri, 14 May 2021
 08:35:50 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>
Subject: RE: [EXT] Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one
 regulator used to power up pcie phy
Thread-Topic: [EXT] Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one
 regulator used to power up pcie phy
Thread-Index: AQHXJT3SaYTnBMAtO0G0B7LwXuLfkarW2ZkAgABR1YCAC8H58A==
Date:   Fri, 14 May 2021 08:35:49 +0000
Message-ID: <VI1PR04MB5853B9B5575BF133B3BCEE158C509@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <7900502879b346e18727f956965ace34a146c0f1.camel@pengutronix.de>
 <20210506210117.GA1433800@bjorn-Precision-5520>
In-Reply-To: <20210506210117.GA1433800@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb1b7997-917e-44b0-846b-08d916b34748
x-ms-traffictypediagnostic: VI1PR0401MB2685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB268571B0520D0504BE894ED98C509@VI1PR0401MB2685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tgy5wweJ6jlDycPMYYFENTmFD9jcypDfbKlZBw/Vf/4aQ44+UjUu/WFrrDprka7yrZNegMypwa47nnkj52FRw9tTbN5E6k/YHjY8XYD2A2i7jJREFl+O5hP72TYipqCal+k4Yj+dmBHHNxlfde+mLmo+WIOiA16n6bbMasqAVwQ/UyVRbY3iDaxdyRm1aBTID5UzhwZlbStS3VCwsSlPBTHi/YHHiZqHu565dIpIpLWS0lufIHHfPCcv3/0EXDC3ZnX4bKgDZrnUAQFmRRU8dcJ6jUgaUUgMb99eVIjynLRad3s936xQNoWbodYnVKtrSLvDsPRAQwmGb/o3FlGi5hare4I5CCCgq/+48YWGvprcgpOWN++UsPJd7eGM5jPjGxDZzT9IfjY9yTpsNwSEe9rFTt9jiivAw2e6NEtYVRSdWF4KEehPIEH5+fuYjf+fVKze0GFsF0ENWOgOB8308w3kMTGtghNL+206EF79dnnWeQWndBUD0kJi/uPSqoqO/7iwb660PSaLqW2zeLkGvnJKfnxv8/aFYez3HDeQsuOF8yT27oCtyjmaLYKZyw9m89keckTP5D2CP8d/YeNiFWR3gGaKm25u+2kfPOBF7xOluWwYLz75sPqzPy8z8nOvK/XEWVByyQ0MZCDyG2qvgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(6506007)(2906002)(66446008)(8676002)(5660300002)(64756008)(110136005)(66476007)(76116006)(66946007)(7696005)(122000001)(8936002)(71200400001)(54906003)(186003)(4326008)(26005)(83380400001)(478600001)(52536014)(53546011)(316002)(7416002)(33656002)(9686003)(86362001)(66556008)(38100700002)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MCDDCMSdmad+67i2Zsc3xH36gUX8IHW2KPe/nLxSNrMY/30+Iju19hBaaTzN?=
 =?us-ascii?Q?+mZttpskMw1CtY8HSnFnQ705cumudaV4H/uyiLo4qzl0hrUKS6C70NBYGqFv?=
 =?us-ascii?Q?AmnAFN06KMaxVE/hf+KX7twbt+a7zepvhe+7i9wVH0oxhg0eCJRZuE2is0nD?=
 =?us-ascii?Q?j9VnfCgtrsCmN2jI5rLHAu3LnqY3hBFk1nUDxoyEDEirqPOJsozPucfRAJp3?=
 =?us-ascii?Q?3d+hIIApNSJUKTUf57lm5Vb1qiALs7xiXeqYi9yYOveoYlWWZoBDaNHB9xNK?=
 =?us-ascii?Q?Xune6L+vatcLAfDamCUDp2ECzepY3uL0uC7rKrbT12IHTqu8ZIH0/L+C1itn?=
 =?us-ascii?Q?QT9tBZ/yAe9YZsH9tGEhT2ZqYzQ77c6mzksW4ZFzh6Q2UWfcpOzFzb5o+z+M?=
 =?us-ascii?Q?S/KomXxHjGSfeJItI+sl3swy4bmVuqk2WVr/ezzqZCswBv8kvyXsDBm3UXTZ?=
 =?us-ascii?Q?KfeCIMFA/5+I14RIV7UnWbGFS1GUT8/vQq/5vxJvh5cMjO2HA6672IN3e+p8?=
 =?us-ascii?Q?MheshDSkQqvJ3lmwzft1ZZkouxGbXNZFkiyKMlswHsXsSzzXguIVm4A1QRKr?=
 =?us-ascii?Q?fA0JISvbiHtwfplN5/mt9rOTh3bzdwATr58KizOkRkdN5SsJmFxuEPJbrswn?=
 =?us-ascii?Q?peaWhFJtZtJgqLssNr3mXtVtjC92BhEiWXi+vXH+1BygbaVoOBWkGB38AdKE?=
 =?us-ascii?Q?qet+1f0k+//+cOiQoCf5AygZbiOy6rh+mWOW0RpEJ6lLrMo4e6R8OTmtdbdd?=
 =?us-ascii?Q?kWUa+tQbmNQYg5fiRE3wN4z77pFkCj7acZF96bNKZQNItomJNNgs5uyxxgjK?=
 =?us-ascii?Q?4kPs/veyWpvsnURejOqetgmIrxI/fcOU883NbNYwkFOKS1FvVleQVgd0gzZK?=
 =?us-ascii?Q?EvwgBYoINbLlYjuWc8KzzYhlUGCJ8RlkOqxfWnrtXUz6XEF2qbCWWMsZyg1F?=
 =?us-ascii?Q?tYZOZZ2XCycBCIPowor4cvq+YijpV1qUZRKHJgh6HXAukhHNL2PTM/dUh/2F?=
 =?us-ascii?Q?yIOmCBLzqHcQjWnd7ybwZYLQb4/V5JvLjVl+fk/SgFBonkTpF/hOI1pQw14O?=
 =?us-ascii?Q?zzWV8pHj8q9shMEsfXesaCjKn69AKygOdTLK7zoShggcDrS4h0YK6dSKaGrr?=
 =?us-ascii?Q?zMkG5XPj290uwQiMu/ukXegZngAKu2z95ikZcUdN+y45peX/Q4qhHZNup4Ja?=
 =?us-ascii?Q?uK7Zi6KJZfivzC2ysZDzs0bOEvbwzOc8/g63OE4V7Qe296RkENUpAOE+ttNG?=
 =?us-ascii?Q?RDhYUn5VZZXZ3sNtPzLmqYU213f09zAsR532sIemcriqjjB+ozsdsPB2iU/z?=
 =?us-ascii?Q?RM0l9r5mBtxcQJOsvCJ6+YgP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1b7997-917e-44b0-846b-08d916b34748
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 08:35:49.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++YmtddL/tdyd89k75XefHHnSP/7jWy67BGlejb+C8RJTB4JtQkKkDZsrctmqK7qg63nTKCJgdnnXzI2fduCCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2685
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn:
It seems that the email I replied on May07, is missing.
Re-send it again.

Best Regards
Richard Zhu

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, May 7, 2021 5:01 AM
> To: Lucas Stach <l.stach@pengutronix.de>
> Cc: lorenzo.pieralisi@arm.com; linux-pci@vger.kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; kernel@pengutronix.de; Richard Zhu
> <hongxing.zhu@nxp.com>; andrew.smirnov@gmail.com;
> shawnguo@kernel.org; kw@linux.com; bhelgaas@google.com;
> stefan@agner.ch
> Subject: [EXT] Re: [RESEND v4 1/2] dt-bindings: imx6q-pcie: add one
> regulator used to power up pcie phy
> On Thu, May 06, 2021 at 06:08:24PM +0200, Lucas Stach wrote:
> > Hi Lorenzo,
> >
> > have those two patches fallen through some crack? AFAICS they are gone
> > from patchwork, but I also can't find them in any branch in the usual
> > git repos.
>=20
> They were marked "accepted" in patchwork but must have fallen through the
> cracks.  I reset them to "new" and assigned to Lorenzo.
>=20
> Neither one follows the subject line capitalization conventions.
>=20
> The subject line of this patch (1/2) doesn't really make sense.  I
> *think* this adds a property ("vph-supply") to indicate which regulator s=
upplys
> power to the PHY.
>=20
> > Am Dienstag, dem 30.03.2021 um 16:08 +0800 schrieb Richard Zhu:
> > > Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
> > > In default, the PCIE_VPH voltage is suggested to be 1.8v refer to
> > > data sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic
> > > design, the VREG_BYPASS bits of GPR registers should be cleared from
> > > default value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator
> > > would be turned on.
>=20
> This commit log doesn't describe the patch, either.  Maybe something like
> this:
>=20
>   dt-bindings: imx6q-pcie: Add "vph-supply" for PHY supply voltage
>=20
>   The i.MX8MQ PCIe PHY can use either a 1.8V or a 3.3V power supply.
>   Add a "vph-supply" property to indicate which regulator supplies
>   power for the PHY.
>=20
[Richard Zhu] I'm fine with this one.

> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > index de4b2baf91e8..d8971ab99274 100644
> > > --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
> > > @@ -38,6 +38,9 @@ Optional properties:
> > >    The regulator will be enabled when initializing the PCIe host and
> > >    disabled either as part of the init process or when shutting down =
the
> > >    host.
> > > +- vph-supply: Should specify the regulator in charge of VPH one of
> > > +the three
> > > +  PCIe PHY powers. This regulator can be supplied by both 1.8v and
> > > +3.3v voltage
> > > +  supplies.
>=20
> Just going by examples for other drivers, I think this should say somethi=
ng like
> this:
>=20
>   - vph-supply: Regulator for i.MX8MQ PCIe PHY.  May supply either
>     1.8V or 3.3V.
>=20
> You mentioned "one of the three PCIe PHY powers"; I don't know what that
> means, so I don't know whether it's important to include.
>=20
> I also don't know what "vph" means; if the "ph" is part of "phy", it'd be=
 nicer
> to include the "y", so it would be "vphy-supply".
>=20
[Richard Zhu] There are three power supplies in total required by the PHY.
- vp: PHY analog and digital supply
- vptxN: PHY transmit supply
-vph: High-voltage power supply.
Only vph is handled by SW here.

BR
Richard
> > >  Additional required properties for imx6sx-pcie:
> > >  - clock names: Must include the following additional entries:
