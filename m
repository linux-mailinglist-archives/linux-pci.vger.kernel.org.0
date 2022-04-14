Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E95501C68
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbiDNUNS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiDNUNR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:13:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B0BE7F56;
        Thu, 14 Apr 2022 13:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyIVMUdqJn4FGOofMi3n3OIJaiYjm1rYaP+DhqEaqslqBy4mwHo6TuoS6c2xgmnt6JEiV1y69XjjSV4QefXcoOIRT85K4N1yeWJjht+A2C+6Qol8MwOPpSDiYwlSjt2857JJGFXfzLYaeBGJ31SGcqNh3uzLCCRfkal3IupNex1oedBLn2L3mCUYvF7RBEY1VhL+C6LPXZyqOIgVo7itN1mipj/U6L26DMtwIAbynVUWvKgwr0BF/dBAHLuxTRbsSAYskQee8qvBAxrs7GBuLho6GiZ3oaDtLmcMXfFes+yTl4g10aiXlv8wI9haaj+xKDmTFqoH8Zm4Qg5MGq8rxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcnO2Vame9bKyuRnRk+X+L+R0qy0Z8efumgfsNnrHIs=;
 b=T4E98MLz8hGHanvXO5YSGmjofdN4asj21IqByb66ZjYrbecpsJV+TQzoyk7oyFKzhGgaNK7GnB5qY0qQPjh2OhxtOM+T5R0rhUuvWMMEGY6y7iOYIv5/9of0OeTn/0YIQHSWfkjme6rtSw23f6RmdLOEvw24fhrwiEegfkrvwAemyr0yTbCjAqiUEu+E/4L4ph1yQno9BPzN8nvj7DspUBSlHKSWKIrggARza+dDMiF27797FLVtWlB9+NfUAsHb9JZHA4taIigxW49Ml2HObGWjQhJuBgfa8vj32DfgF7shH1qOU2akbbJE4nay3ELH2Lonku+uyI9mksBE3xvrDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcnO2Vame9bKyuRnRk+X+L+R0qy0Z8efumgfsNnrHIs=;
 b=GxzWlpuNQIuMi0F8kAm+q+i+6g4F3DErOA3z5fXO0QXs9VDC+sIR+3tTjbrZ7XpvM0Ft6ZZ5WuIlsXQ9umGBk5FP22XotX34Ton2u6LUduLVfcphFwKSxfz3VrMv4EpRhcbH5kvR5oVXcRsOCMNajA2gUWeJwJyzk9oKIiIpCEk=
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com (2603:10a6:20b:42d::18)
 by GV1PR04MB9199.eurprd04.prod.outlook.com (2603:10a6:150:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 14 Apr
 2022 20:10:48 +0000
Received: from AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::7481:f0a2:5c7d:3484]) by AS8PR04MB8946.eurprd04.prod.outlook.com
 ([fe80::7481:f0a2:5c7d:3484%7]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 20:10:48 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Rob Herring <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] dt-bindings: pci: layerscape-pci: define AER/PME
 interrupts
Thread-Topic: [PATCH v3 4/4] dt-bindings: pci: layerscape-pci: define AER/PME
 interrupts
Thread-Index: AQHYNaKytD7MFGggPUWuFHPu/1tB+azwA6gAgAAHUfA=
Date:   Thu, 14 Apr 2022 20:10:48 +0000
Message-ID: <AS8PR04MB89466301D1FCD45BE972C47B8FEF9@AS8PR04MB8946.eurprd04.prod.outlook.com>
References: <20220311234938.8706-5-leoyang.li@nxp.com>
 <20220414194016.GA764042@bhelgaas>
In-Reply-To: <20220414194016.GA764042@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89cc5caa-c6d4-4fcb-3084-08da1e52ddd7
x-ms-traffictypediagnostic: GV1PR04MB9199:EE_
x-microsoft-antispam-prvs: <GV1PR04MB9199796C1E2D2189B786DE798FEF9@GV1PR04MB9199.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3m5Mr+CBnFz9UucqBPnwv9nRicD57faTUQaaBmrY9hXqLObsjQiNwq5Ldvb90pWPY5WVkRnbftAWD2Ohylg9SFxiu+YHaqC1zveNqHkuQwU7THbY8/DwTjcKUVZjKkVA5pc6bE36MzD925ET1z7XZa+841o5ffhCHsHc4O5w/NF9JF6nZji20/8axMRYxuKznH98YD1hzrn8JbjnaPqgRkbzJ3F1Jy0MUw8GPIK9ZhA6IpSK/2JapwXbuMFnZ7HTWYZdwB4Pn/X+gtFbtwuVb5t53Wd4uGS/fEX4NPXK0SOktZ4Cazd3vy4SzwXuNi/fJdsCL4bXTxK9iRtgfmF4qAM0NOe5egNXEwXVACVmm9SxTlHQTXa/HTwpRXZ/FVscZ2clvNzL86oJv/OTmVzIfiHsRYVPzcj3GuWKSVOPb2H3tNnjgtUMKMLTFWQ+EiuQgSC+c6kWbXGOgQSetb+zsF7BXnL6uCwN+Usomgv4xm1qWT8yRm/4zGbWECJp7EnHOY9hx6b2nHoOkUQ+UAVogzSTNY9E2PJQIsajX0s1DDpKpnHuspzPoLlqijy1+IT8LR7zT2GlcXWcSvfGxFtEvEgA+57G0wF0FlBqsGMpqBDkw0FDYeqsbPHVUkW4MW74odiEl+6D6Jgw8LsMvErsBt+c8AmctiUGcX7uwcpY0/X8MSt8gm5yqkpkL0I/VOiujEg6I/EA+gmc/c8Gre8VDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8946.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(38100700002)(508600001)(71200400001)(5660300002)(2906002)(54906003)(6916009)(66476007)(66556008)(33656002)(66446008)(316002)(86362001)(66946007)(76116006)(8936002)(52536014)(4326008)(64756008)(8676002)(83380400001)(122000001)(26005)(9686003)(6506007)(186003)(53546011)(55236004)(7696005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?55mXoolSbh2q6kDCDF57Bweq1TbogI418CIpO93zy9UA0Iie6wrej+ui4+qc?=
 =?us-ascii?Q?fbzthF613ST1XdNrn+d/9jO0c6Zecv8WcZw4ajHRfzhr/o4FHwUBGjvFPnKh?=
 =?us-ascii?Q?kQNl4E4XDXuy1Q3prBbTgabHuBhooBM2xmEyHWYduL4QeCY8WliH3DTOQJlI?=
 =?us-ascii?Q?vuMzPmUkgSPuDomA8fSwBIhmm7CAqFGr4nAvbVB/Nzd029jVBcO7GZ6GlKJM?=
 =?us-ascii?Q?5LWyuCWQFA+vvloQ8M5RGX2ylXFooXxXjD1S8A5T6MDx3xfRsrKOSRD2vYQA?=
 =?us-ascii?Q?kYRaEkGCW2hLNRs3axzx2yPHKpGjwY9NY5hujJvWTtM6Tc/UDM6aYHcGq9EC?=
 =?us-ascii?Q?oZ5OGCpfXvUVNAR+Z1mAXXVo5PbUCl/sJtFBMe8jIabXyWI8LvXBDkSV+MgD?=
 =?us-ascii?Q?SExDRWxtltNNQvZn08zSzEV3WsUhpZ9v1OT2gjBDUf9WpB+zW3nLQ/ucFzaH?=
 =?us-ascii?Q?X/EAd/cvkApwCav9e6JxilQW16aW5KIaPAcvQMNqn1U5Er7EeVdi2Ct3+bZB?=
 =?us-ascii?Q?3NRixiPGrINCIF9wM3jeD2YMIU6411SMD5Pq01Lv+49EIPMUcKaHo+PEB8Qu?=
 =?us-ascii?Q?8fxn+ZXeJvJDzm+aeXAo69fyV1nSdF5jt6XtHZWKEYM2s7sRtPQCIn+7+QRy?=
 =?us-ascii?Q?mFiuALzJUlL/Q4OuhYVJqOUfk/XO4boVtyE3Za0tVvOBMt4dqiy4AUm+KNPK?=
 =?us-ascii?Q?6x+nxeHixYx1yC3QCTwW/YdN5+Z++TeUVlgIQ7gY1K9KvRVEtjSNCs8stPg5?=
 =?us-ascii?Q?stE42rK6vGg0uGSxIFUYxZLICEgqxYFXeMzUpAhwastyCUxwMt1FOOf3umSK?=
 =?us-ascii?Q?aVhODXEmNMWHh/u9Zb0uiRP17uh7mofJ/LX3WFyiajLyyUCdbjmE0FFkAcx/?=
 =?us-ascii?Q?VCT40DzQ0T9LOgfajfIAzp5yKOaJF+5EuZTEGS83BISfL5RdCm/dmljDPS0i?=
 =?us-ascii?Q?SKG7X3xkPZubaZ5TM0hKOhMJk7cx19Gwc4mYiho2xIS8elR8wx0AwX/mDe93?=
 =?us-ascii?Q?wERw5vtrC8RE8Q6J+2uApWQ4FHjZAU42aoY7WFSksau7AhUqnBClUGE+uaP+?=
 =?us-ascii?Q?hSaTkjeZ1U7NDHT0PEgwt8ga9f7yzYYBhkz8emEC8v7F4k9mCN0/Ac/OvIdB?=
 =?us-ascii?Q?juNt3FSmSTJhyB4ZyhFsZR/ejw2YgNhJAvxS439iE9y+229ZaVNGpQSVgw4H?=
 =?us-ascii?Q?u+BUXvq0BkC7BLT/NLWXLu5W/tn5RemS4q6x5IX7JhXv3xGRj3sOBPEF+L1v?=
 =?us-ascii?Q?+wA7NubQBM8p6icflzNdtoRBat7DxVlZp12scxjgspHVXgAhhM4Z9sGV6hfV?=
 =?us-ascii?Q?C+1RdSr/YDzYA0HzlOMc+99Btq21uP5LnfQrbE6psWMCRQ74Moag4uKrWePq?=
 =?us-ascii?Q?YUbUG4BB3P0+uCDCNmp+A6tiS5umnXD9lOOZo0sqNthiWVBwQqXA1xsyR6nV?=
 =?us-ascii?Q?PAP0KaUwDuwTgYK7r2fx+6h+PBug7Xyf4eJrGIwqk2Q5Hc51NGbfsxQkHARu?=
 =?us-ascii?Q?Wda0cicClRs0aK6fLHuGoPLUSN1AQ0hqlv55iIBQdgZOQkps8/6/ugqpPtxu?=
 =?us-ascii?Q?QuB6HTv/0znfi618I4eirrQasBX94rxfuvTWBtosBrKabIeu1F5LmIMYRGA7?=
 =?us-ascii?Q?mcvS4Bp39/Sv02lEA1E27h2UG/CtYHYNUsU3DD5t1BJThQsFWZSnEDpslcFu?=
 =?us-ascii?Q?m3EFXweoPrnENBmPxOFPiAGlTcBamNfRkS2WtDNaLh1kxV9xYefS0CDBaTi/?=
 =?us-ascii?Q?apkUmvGpeQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8946.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cc5caa-c6d4-4fcb-3084-08da1e52ddd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 20:10:48.3740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D4w0d+t54Gm3QzAXjJLxQDVxfbZtmwzhyjazd1GhBjOQM7Afr+t4pZOpB5mBO4N03YsrHfDZExZQ3CQGK3l2hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Thursday, April 14, 2022 2:40 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>; Z.Q. Hou
> <zhiqiang.hou@nxp.com>; Rob Herring <robh@kernel.org>; linux-
> pci@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3 4/4] dt-bindings: pci: layerscape-pci: define AER/=
PME
> interrupts
>=20
> On Fri, Mar 11, 2022 at 05:49:38PM -0600, Li Yang wrote:
> > Different platforms using this controller are using different numbers
> > of interrupt lines and the routing of events to these interrupt lines
> > are different too.  So instead of trying to define names for these
> > interrupt lines, we define the more specific AER/PME events that are
> > routed to these interrupt lines.
> >
> > For platforms which only has a single interrupt line for miscellaneous
> > controller events, we can keep using the original "intr" name for
> > backward compatibility.
> >
> > Also change the example from ls1021a to ls1088a for better representati=
on.
> >
> > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>=20
> 1) Please pay attention to your subject lines and make them match.
> In this series you have:
>=20
>   dt-bindings: pci: layerscape-pci: Add a optional property big-endian
>   dt-bindings: pci: layerscape-pci: Update the description of SCFG proper=
ty
>   dt-bindings: pci: layerscape-pci: Add EP mode compatible strings for ls=
1028a
>   dt-bindings: pci: layerscape-pci: define AER/PME interrupt
>=20
> Note that all are capitalized except "define AER/PME interrupt".
>=20
> 2) Also capitalize "AER" in the comment below so it matches usage in the
> commit log and the property descriptions.

Thanks for the suggestion.

>=20
> 3) This diff is HUGE because you replace a bunch of tabs with spaces.
> That seems like a pointless change, but if you want to do it, at least do=
 it in a
> separate patch all by itself that *only* changes tabs to spaces.  Then we=
'll be
> able to see what actually happened in the patch that adds the properties.

Right.  I changed to use space because the examples in yaml bindings do req=
uire space instead of tab.  But it is not really necessary now as this bind=
ing has not been converted to yaml yet.

>=20
> This has already been merged, so unless you need to update this series fo=
r
> some other reason, these are just tips for the future.
>=20
> > ---
> >  .../bindings/pci/layerscape-pci.txt           | 58 ++++++++++---------
> >  1 file changed, 32 insertions(+), 26 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > index 8fd6039a826b..ee8a4791a78b 100644
> > --- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
> > @@ -31,8 +31,14 @@ Required properties:
> >  - reg: base addresses and lengths of the PCIe controller register bloc=
ks.
> >  - interrupts: A list of interrupt outputs of the controller. Must cont=
ain an
> >    entry for each entry in the interrupt-names property.
> > -- interrupt-names: Must include the following entries:
> > -  "intr": The interrupt that is asserted for controller interrupts
> > +- interrupt-names: It could include the following entries:
> > +  "aer": Used for interrupt line which reports AER events when
> > +	 non MSI/MSI-X/INTx mode is used
> > +  "pme": Used for interrupt line which reports PME events when
> > +	 non MSI/MSI-X/INTx mode is used
> > +  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls108=
8a)
> > +	  which has a single interrupt line for miscellaneous controller
> > +	  events(could include AER and PME events).
> >  - fsl,pcie-scfg: Must include two entries.
> >    The first entry must be a link to the SCFG device node
> >    The second entry is the physical PCIe controller index starting from=
 '0'.
> > @@ -47,27 +53,27 @@ Optional properties:
> >
> >  Example:
> >
> > -	pcie@3400000 {
> > -		compatible =3D "fsl,ls1021a-pcie";
> > -		reg =3D <0x00 0x03400000 0x0 0x00010000   /* controller
> registers */
> > -		       0x40 0x00000000 0x0 0x00002000>; /* configuration space
> */
> > -		reg-names =3D "regs", "config";
> > -		interrupts =3D <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /*
> controller interrupt */
> > -		interrupt-names =3D "intr";
> > -		fsl,pcie-scfg =3D <&scfg 0>;
> > -		#address-cells =3D <3>;
> > -		#size-cells =3D <2>;
> > -		device_type =3D "pci";
> > -		dma-coherent;
> > -		num-lanes =3D <4>;
> > -		bus-range =3D <0x0 0xff>;
> > -		ranges =3D <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0
> 0x00010000   /* downstream I/O */
> > -			  0xc2000000 0x0 0x20000000 0x40 0x20000000 0x0
> 0x20000000   /* prefetchable memory */
> > -			  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0
> 0x40000000>; /* non-prefetchable memory */
> > -		#interrupt-cells =3D <1>;
> > -		interrupt-map-mask =3D <0 0 0 7>;
> > -		interrupt-map =3D <0000 0 0 1 &gic GIC_SPI 91
> IRQ_TYPE_LEVEL_HIGH>,
> > -				<0000 0 0 2 &gic GIC_SPI 188
> IRQ_TYPE_LEVEL_HIGH>,
> > -				<0000 0 0 3 &gic GIC_SPI 190
> IRQ_TYPE_LEVEL_HIGH>,
> > -				<0000 0 0 4 &gic GIC_SPI 192
> IRQ_TYPE_LEVEL_HIGH>;
> > -	};
> > +        pcie@3400000 {
> > +                compatible =3D "fsl,ls1088a-pcie";
> > +                reg =3D <0x00 0x03400000 0x0 0x00100000>, /* controlle=
r registers
> */
> > +                      <0x20 0x00000000 0x0 0x00002000>; /* configurati=
on space */
> > +                reg-names =3D "regs", "config";
> > +                interrupts =3D <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer int=
errupt */
> > +                interrupt-names =3D "aer";
> > +                #address-cells =3D <3>;
> > +                #size-cells =3D <2>;
> > +                device_type =3D "pci";
> > +                dma-coherent;
> > +                num-viewport =3D <256>;
> > +                bus-range =3D <0x0 0xff>;
> > +                ranges =3D <0x81000000 0x0 0x00000000 0x20 0x00010000 =
0x0
> 0x00010000   /* downstream I/O */
> > +                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x=
0
> 0x40000000>; /* non-prefetchable memory */
> > +                msi-parent =3D <&its>;
> > +                #interrupt-cells =3D <1>;
> > +                interrupt-map-mask =3D <0 0 0 7>;
> > +                interrupt-map =3D <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_=
LEVEL_HIGH>,
> > +                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LE=
VEL_HIGH>,
> > +                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LE=
VEL_HIGH>,
> > +                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LE=
VEL_HIGH>;
> > +                iommu-map =3D <0 &smmu 0 1>; /* Fixed-up by bootloader=
 */
> > +        };
> > --
> > 2.25.1
> >
