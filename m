Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3070462B2B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 04:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237899AbhK3DjQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 22:39:16 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:19950
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229783AbhK3DjM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Nov 2021 22:39:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3Or1MxEU5aq4u5ivGA1ivwLOA7Zt9BtgsKqmwFb9NNrYx6bMZBpqqTSQePXKFM1NpUzPv//TX2nBe25XEqtlCMccrOa0PTmFQCdQoJD5W05eyWw/5AXsPc6OFmxGNS/iq3Jcw2C1itL1wfKlh8IfzIUfP+peWZCL/+cVeHRlmrPKrAfkm+nRs8JmUU/OSaWgQlkSerePB3bdV22wm7jLtyOhV3r8TbPuQhzH06cFpG54lWbinh28iLwbOirH6e1l6FXENpxMjBg6YkPFEbWe/TDFHlWEVLSaAzX9CdHkI3gyNMV0kGo5OcxHCWztbx3cbdFH07tdfH5tlpK8bNBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O52ftbnN92JU/mEoVmn056E0lcC2bNCMLmwAS5g8Sz8=;
 b=EO561r4wm5onQAC267d0tImTylzeADIvqVhQMhsbWMF18eWROsbiRUi6vEr+NzRlOa7cn/FHHM6aL6Biciwj1y2H+GC3Ecz/mlW3PV+4hyf514+6ewC26NBpQAGp+wGUE/rUecE2CAwuhSNSb+B+izUrm8zRUPLLXtt4ueydEEv2xEZL+YXpqLx9nN0XAT8cHNVFSK8U5XGLHSlxZ57HQjBWtW8cngCGuDTC/szVn9PXFolWqBW+o90QcTiFIrj1Q14hs5k/1H7C3s+0cTj3ZkkAJy5kf9ieVMUIXTU7bAl6Pfl2D41yCJMw5iCUngOUzYS3oHMGbFrLHgpCOfIBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O52ftbnN92JU/mEoVmn056E0lcC2bNCMLmwAS5g8Sz8=;
 b=qy12jVh/P28bjrbEmrEr/UdZ6iUWUNoJShUMCHl7KiF21ilohvriL2/YPg3nbhYw8gHJ9BXZf2vze+uHwHVkq0xZ5Wy1dkeuNvOQXlBa2LCA7byDBc/95go8u+l9dZFP/mbCERbtBWkEyuKzT6ujtaj3D/JPcgBQOobyYAH+hnQ=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21; Tue, 30 Nov
 2021 03:35:51 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::60be:d568:a436:894b%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 03:35:51 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Subject: RE: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
 interrupts
Thread-Topic: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
 interrupts
Thread-Index: AQHX3aPddDH3ddPt8EuZqS4SQ5nFIKwbYVKAgAAXieA=
Date:   Tue, 30 Nov 2021 03:35:51 +0000
Message-ID: <AS8PR04MB89467DDB9BC3217431716D358F679@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20211120001621.21246-1-leoyang.li@nxp.com>
 <20211120001621.21246-5-leoyang.li@nxp.com>
 <YaWGKaBvTpx1pA/x@robh.at.kernel.org>
In-Reply-To: <YaWGKaBvTpx1pA/x@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66ae4344-e66c-4ade-2de5-08d9b3b28209
x-ms-traffictypediagnostic: AS8PR04MB8466:
x-microsoft-antispam-prvs: <AS8PR04MB8466CCAB1B8DD97463882AE98F679@AS8PR04MB8466.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7tlfIZ5vLdbJKZjIFgUjk8epKW9mtbTykMQHMdkFL3LERBZP1xOMsExoEa/wC2nSfweqnClOcSFkjzWjd7cw5td0GEsmXcBGMIO2GwVigm64ZcTzeDY2S5gdI5X/l8mTI7cQF6G2t2tAH3wEaPBc0AMy9NuHhqzNlOhUTAJ0p4SI4UJy6OxRCpyqW+gZgduoUjgeF7UL9F7/WmVeLCTDO9Vt3TdKiI7DhZTBhElOW9zfe3QJs434mUsCJ2miKS92w1ybfgzR6O+JgBjZxRVY24s/WDgyy2xYznow1G6ua0OGlKmL5Uu+9M7wTm7KeJuoQu+XMT1sULDeA2W2p32j+758AzqtENaGxwko5xPdwvLclt2bOP4N3lGNZ4Tc6GqgULvXImVzv7orsqVZPU564PhZnPyfKZAx97HeZYblVEb3shkZ/e+duqooSWitJfUD/Wr0vzAjkik1rQGKp0pa1dcplkA5uIfzNR7KROyczAiWQbbhWM6NHZ3K20VvOB8noMrkCfHz7+gO5U0yh6M4d1VXyFE16ZbFSmzvmkfhLF8riqFNWXsHymcgo5c7AFvvi1BCIcD5uIee/9X/fEGuNIutoJRFGi/w8qFXqvFwKjWKDgq1/ib5NeAxb5AZN9IpWvX2hlwfHQns3jWRLEp2UE5HIucfB3Pb8MUcb8lZXpSdm5n69mm/Iy84c0jiazvwTSsjw3n/vb/aVJCMYm44Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(38100700002)(66476007)(26005)(2906002)(66446008)(33656002)(4326008)(64756008)(122000001)(8936002)(66556008)(9686003)(53546011)(6506007)(7696005)(38070700005)(186003)(54906003)(76116006)(6916009)(86362001)(55016003)(5660300002)(83380400001)(71200400001)(316002)(66946007)(8676002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jzLfUyyayXQDjHqk/EGvbfODVPJisyJ7b8aJbbAMiDQgH80JnU9z4E/ThWPl?=
 =?us-ascii?Q?cngoXVxqC96jzGCyApie8jnxwzW2Wr/6lQvWu5Tzvef5nJK9OXLEa4pCNnyt?=
 =?us-ascii?Q?6RBi3vvdZlSnzi587FUNpSdH49CdcUbHojpmXUKNYPDY4B1mBBUWvlSNvO0f?=
 =?us-ascii?Q?kJOrUA0nQIheWaX7pzQLl7NUp8GCzL1C6iF/9O3Is8W5RIpgXxTluovVxYWv?=
 =?us-ascii?Q?CDmJMQbE+bOVwvsBv+96DNc5EriMJzFdfbLhd/fspa46/7AYkd6WjB1xoriK?=
 =?us-ascii?Q?S9Qdp4UEYns7gNTsDpqWQKr+XUP8xsZN4ZAeInb8l36cP25+4okuF6TBOJkc?=
 =?us-ascii?Q?fZu3uPBO1plBEnUmdmtvVRV+F0fGONkkULGZaBGG+KuoxP5YaDMa6mZVPYU9?=
 =?us-ascii?Q?lq0s9g7ppzfyXxtgMC7b7J65nd/X95z3dJac0tRJ/AOKQmhQSqPyNIn7toN4?=
 =?us-ascii?Q?F7kAknSf5cmMvSONmiSLa57dui6pOGeE7miswl6kybl2z+9zXajcXXx56qSP?=
 =?us-ascii?Q?g5sXJ5YOk2nFTHGhHMujMc3/+q0Qa7WsH+dFbqWNozGAzg3xUK06mEKcYqnI?=
 =?us-ascii?Q?god8PAxVlmk+sIfAQRv6+ajhzY2QlLbqeLugAqkVBfJ+TFM0uUE37BI2W8nk?=
 =?us-ascii?Q?NBE1vv+0YwESE7Pjzrgu2zbDJv+rjV5LHSOvqk+H6nzddaJxUnXwerXge7D1?=
 =?us-ascii?Q?wHAwghV+Z1n+icfjYRIWCd+SGX6uyftOYA7bXww5CnOC6sL0ARzA1FONHAbs?=
 =?us-ascii?Q?y0k2cJ1icBTBRHUmSRw8bz5peOY3QBNe9kE/utfy4BRiaSIJrZGljSGSn9Cb?=
 =?us-ascii?Q?fcNaQluUzre2RQ2rmJ29kQdGUqR9KBx2/Se3Sa//Eij1mHa5raxgNwxPFR7S?=
 =?us-ascii?Q?DxLK0N21XJWFvUZFLYLer9ehBvO+YsihKqAUi1fTSsAnaAXEcUDq/NSyEyvW?=
 =?us-ascii?Q?ph4q2rzfau82n0UkZ0YFiJ47PScLop9KOEV15cdK3aK1DXoZC5hxkMFjAvXQ?=
 =?us-ascii?Q?etwqRAAKREo3Ow5ykj/6w1oYaGXRbTn45Rbv8LP1e9+Pi4ABMnPX/paFXZsX?=
 =?us-ascii?Q?ypVsEEKJn5d3SLwEsBFD2rxKMTMe1BkNxrw7OHatopBuikmSwAEnlTaRCqfJ?=
 =?us-ascii?Q?NnRzGmL7WSNsyc77975HGjKwk6Mm7xmeSNiQmyC0kP6EcuLJdWBqHgEj/2HH?=
 =?us-ascii?Q?5WxvtkMKj2YN8wOJ5zrQBKRbROi/EnVrtKULy2XMi6AwNWj22VboGt5otaUP?=
 =?us-ascii?Q?TD+QcmA40A7MQk/MipLXwN7d/IpS9JOTlkcyl3UlvR8/pNSov2LFIJ5GW2qP?=
 =?us-ascii?Q?pi+c8aKRWydrZRc3FyOZT0gyz4I7qc3TLGBbazFmmmQyrR3y8A7JtUwoB7Mm?=
 =?us-ascii?Q?jWSuTo0m4cGDs2AJEmvP54PqS1DzDkN3xLSLy3joNVpI1hRWScUxOQpieYXq?=
 =?us-ascii?Q?qOb2IRLWVeB6YYhopzLl+BfaaHhlujhcirduTFQV4303pWQcx8wzwewW4K1C?=
 =?us-ascii?Q?RzWwucjgzhVKDdSS05z/W8IcoHj/kE1gvQ1YtLXrayYNeZgrpksflfxSe9bU?=
 =?us-ascii?Q?kFm/nIj7Z8nmj7g1DR79mPyL641jzLkuUfxtUQC/JsqIQDRseNVS/nxA0qO8?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ae4344-e66c-4ade-2de5-08d9b3b28209
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 03:35:51.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jQbCn8KdqMw9QNKaPEnqw+s+oUF/zdHgO6UXB3xVBOrxAPzhYrCs9ycVgsL+11jOlr+ehuMbouSo5HBrvFoVgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, November 29, 2021 8:02 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Z.Q. Hou
> <zhiqiang.hou@nxp.com>
> Subject: Re: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme
> interrupts
>=20
> On Fri, Nov 19, 2021 at 06:16:21PM -0600, Li Yang wrote:
> > Some platforms using this controller have separated interrupt lines
> > for aer or pme events instead of having a single interrupt line for
> > miscellaneous events.  Define interrupts in the binding for these
> > interrupt lines.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > ---
> >  .../devicetree/bindings/pci/layerscape-pci.txt     | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index 8fd6039a826b..bcf11bfc4bab 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -31,8 +31,13 @@ Required properties:
> >  - reg: base addresses and lengths of the PCIe controller register bloc=
ks.
> >  - interrupts: A list of interrupt outputs of the controller. Must cont=
ain an
> >    entry for each entry in the interrupt-names property.
> > -- interrupt-names: Must include the following entries:
> > -  "intr": The interrupt that is asserted for controller interrupts
> > +- interrupt-names: It could include the following entries:
> > +  "aer": For interrupt line reporting aer events when non MSI/MSI-X/IN=
Tx
> mode
> > +		is used
> > +  "pme": For interrupt line reporting pme events when non MSI/MSI-
> X/INTx mode
> > +		is used
> > +  "intr": For interrupt line reporting miscellaneous controller
> > +events
> > +  ......
> >  - fsl,pcie-scfg: Must include two entries.
> >    The first entry must be a link to the SCFG device node
> >    The second entry is the physical PCIe controller index starting from=
 '0'.
> > @@ -52,8 +57,9 @@ Example:
> >  		reg =3D <0x00 0x03400000 0x0 0x00010000   /* controller
> registers */
> >  		       0x40 0x00000000 0x0 0x00002000>; /* configuration space
> */
> >  		reg-names =3D "regs", "config";
> > -		interrupts =3D <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> > -		interrupt-names =3D "intr";
> > +		interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer
> interrupt */
> > +			<GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme
> interrupt */
> > +		interrupt-names =3D "aer", "pme";
>=20
> This isn't a compatible change. The h/w suddenly has no 'intr'
> interrupt?

The original 'intr' was just a place holder for a HW interrupt signal witho=
ut a clear definition of events associated.  Some later SoC has more interr=
upt signals to associate with more specific events.

If needed, we can keep the "intr" interrupt-name there just for backward co=
mpatibility although it was never used in Linux.

>=20
> >  		fsl,pcie-scfg =3D <&scfg 0>;
> >  		#address-cells =3D <3>;
> >  		#size-cells =3D <2>;
> > --
> > 2.25.1
> >
> >
