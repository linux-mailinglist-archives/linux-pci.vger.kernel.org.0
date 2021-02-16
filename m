Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32731C704
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 08:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhBPHx0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 02:53:26 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:9460
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229942AbhBPHxH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Feb 2021 02:53:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpCh2dSuM16p/QNIXSnQJkaTP92R/W1QcRO/ejNHn53p8yEEuFhzpPCNdMbn2CToFt2oDeBNgPG7YBqYE8HeMsS0yWdZMDQwQkVLom6NVg2G+azdaOOfdBd7v0/sv2rMvI6QCzbbtRshAxxVsytVu3eGyuTZElT6YLWjB7ncxT0byDm94UvoYvrmJLvipAAHngOb2d8tzWd+D+8mHnNSZgELmcTNTR9EwhyTLAGXb6WHAqz2ASu6RrS1P0hIBRwWtuozFpQP1mb83A/WFNwiyGDSmDPDL1m4LUUJne9rn29gYaGCjUef/zbqZzNdwsQNN8mxmkY3fV8V1xDEsrw8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RO0gm8t8G3qMkM/i8W1wSajynRkoEX89+dMyFAi81A=;
 b=M9omY7FLWcYGi1Y5vS4c2d+uaHyihLTb16wSusxKrTMCOdQ0RBsHbyi6LkDz9w5CXLvA9Ph9FxssrUCBE12ZuGS4YbxSs1N4bSGczzW1WTn0qeM47igwcJJfhh/93UVL2kOaAgJuJ6Cbfv3F67H0MWb8oEvZauvHTICOQ99StCJJ8coTIsJr+hYhx9Jvx2RQAlH30+3J2xKFWOjbnlSH/jTm/Gh6QA0o0JIDhB/5hD3aDZwFx5l0xpIL6taMxnCWo1Io6ZWre1AGTHkh7Rk77a6Rp93ydmK/pmc+VKJQwZREEZ1IQyDDmqM6LNgEzIZYjvN7ufV0SQ+Fnji176lkgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RO0gm8t8G3qMkM/i8W1wSajynRkoEX89+dMyFAi81A=;
 b=E3OcPekLKp/x3/9NZbEnAiGnClrAJ6znXbsaUIsxhXi4tyKBzjg6HhI9G90WJRxPArcEnUnWPF3ljUI/n+B80bIqT0WN9BsuF/a9F1dV7Z9rLcT0qdoxZcA5E2R1Dq526N8vjmECDA4P+ZMBtzlQrA9TvRvKlk1rD7sL9X83L7Y=
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com (2603:10a6:803:123::13)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.36; Tue, 16 Feb
 2021 07:52:09 +0000
Received: from VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::8da8:ad8f:e241:457b]) by VE1PR04MB6702.eurprd04.prod.outlook.com
 ([fe80::8da8:ad8f:e241:457b%3]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 07:52:09 +0000
From:   Wasim Khan <wasim.khan@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Wasim Khan (OSS)" <wasim.khan@oss.nxp.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI : check if type 0 devices have all BARs of size zero
Thread-Topic: [PATCH] PCI : check if type 0 devices have all BARs of size zero
Thread-Index: AQHXAScblKz5CllRi0OQmPzb1ns9ZqpZvF8AgACyYbA=
Date:   Tue, 16 Feb 2021 07:52:08 +0000
Message-ID: <VE1PR04MB6702EE8C0FBAFDFD3B35199090879@VE1PR04MB6702.eurprd04.prod.outlook.com>
References: <20210212100856.473415-1-wasim.khan@oss.nxp.com>
 <20210215211300.GA748236@bjorn-Precision-5520>
In-Reply-To: <20210215211300.GA748236@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [223.189.177.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3962e682-bdde-4cf6-b477-08d8d24fc321
x-ms-traffictypediagnostic: VE1PR04MB7325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB732579BE3A0CE55AC1BA4CA890879@VE1PR04MB7325.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DYJfT+hFOV3SiIRGrtiK3NZR1FKijkjHiUWm1RKfqkfepLYxm6pSZC220+bcsgUQ57+55S52+1b4G5NHpGM5zwbxeeh1mlVMqZXIhZV/JHOZ+UwhI89m/8UUoSb0TARfBzKYG1DPha7U4Dwoq/2PfhJXW9qxfOueIR2NaTaC8K+dcwwuavl2zVvdbbsNY7r8I+tTUWovRUgYHeOG61BrLAtGd92S0GmHUQe937wdJLyxQ8ADRjU9PGHckRHFHwAQngpaE2pJKaKJ016GFgZDMum6MO2QMH8r4HpYuMpdRK6l67atQXWO+bxBQ4Ui5YU63DW6dwbWai9OmAAxEGXAMLcTWMxrBXZG0CdfCS4giWwSI6lZeVqbqBWmO39gJ2Ka2FP5drOV1L+8OUcAc/KOz0emeXQTu2XrdiEX6AJXgq5YIhhqSuA351YjWMPyKik+crMl00fpbOQgOAgK1/D24vOEsFA+O/KzpOVxR96LAkhnFP+ii+0eINcofl9LBYObUwvKeTtdohG2bOIoo6HyhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6702.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39850400004)(346002)(136003)(55016002)(5660300002)(316002)(110136005)(52536014)(83380400001)(8936002)(478600001)(54906003)(66476007)(9686003)(4326008)(2906002)(8676002)(7696005)(33656002)(71200400001)(26005)(6506007)(53546011)(186003)(66946007)(66556008)(64756008)(66446008)(76116006)(86362001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S+NQiGbrgm53wqXKnr98vjQNuI6Ot5LvzC4Jq7sb023+MLyeaa2Vafnv+JrW?=
 =?us-ascii?Q?GQtrS5PwbiECGK/T6tqg0nNXbTQcLd05qcuZz5kIHLpAvkpFZ0RBw/kMnTob?=
 =?us-ascii?Q?s83eyGFkAkVBVhOcGoMDE/tBhyE+p5G71yGPel+l2h+xdx4fZlunM7l1fIbZ?=
 =?us-ascii?Q?pKhdH9pRKyl1szWycUul6057LLmyVbyga1joUm2YY+SX84MTHNqCKbKIUuCK?=
 =?us-ascii?Q?Mu+wvmnVoA3gWRlaX6SGErRfAtFTiLxYlX0S/vej0KST6BvqTnhlpm6Gfs/+?=
 =?us-ascii?Q?FsHaikJrYOf8uK/VhwXm6Tp3oibhpfl1HgnQoJ4Bq9mVGjgVK3VFLxufBTI0?=
 =?us-ascii?Q?dn7jLFxYU6FpMeyHGaBbrpWm72FN+25WnhLLaWN+u6tUWRhBnR5F6uMbztuu?=
 =?us-ascii?Q?wVD2CITwdIfOYqdfiQMUoqGov6oOL7jKlTuV4y4QXwL1WhiKV3Y3fD07UjYE?=
 =?us-ascii?Q?PP454mB9FFw3cgdx+nYmfD3RanImE0KshNkg5D26HBlO4J1qBCCa3jdiYEbP?=
 =?us-ascii?Q?wewx8DRW8Oyaf8roFXPTd++X0PVW5Js61WXteXHikB9E104l03YVtFSvHSIX?=
 =?us-ascii?Q?PoFc/Tdov3krKKGKVHhLwER0rCh0mblSjaOznfjwTJ+jsWjXGywoVvrRd6Dp?=
 =?us-ascii?Q?xxNawTNQuft0yvqddgM00F439vlAEWcz+zZd7ZZLVybrTdE9VzV1N5jxqDK+?=
 =?us-ascii?Q?qN6W1PP40LwDoV7neaXUCHGjh1N62mEM7gFB4HZkqOka3N/kYfgoAn6D/ajP?=
 =?us-ascii?Q?WL7QpsCoO0ah+l6yndgqvKh7zbv7um0ozWGWCn5q7MddJSMTYmPeE0A6DCsx?=
 =?us-ascii?Q?I9YmhkEMxFVqUyxO6Rw69rI8KlF9oP3zOhRc7nfOtO+rvhI44XMaVz6falhE?=
 =?us-ascii?Q?Q2iAWJV/+u+DJWaWEqBZeCwheMmXCLgiwMXKnjqm5mOvy/6DeLmweS/llExx?=
 =?us-ascii?Q?TRjpu/i9QpsG4SuGl+7sfCPSDgw0oq2XcKsWzfuiJ7hv1lGHf6UVyjQblZ3L?=
 =?us-ascii?Q?tD2A1kTSzvs4nWVXVkazrL3lnsCjQYeT21Jaj8sp0s0Qj6PIXqeeDVvYpZjp?=
 =?us-ascii?Q?EyBPTWk0hLovRVOzJ2kgctcLHyhB8XqdzJIAwhaNUG2AjRe+hAsKLflLc7QY?=
 =?us-ascii?Q?yDkP4dBzIiVhf3w/TibvShfAwcXf5g2YDt2SzAlq/0jhRAiQD73Z8Kf/ZqYM?=
 =?us-ascii?Q?IbTmlX6xaoLxNCzEKdipUBmQshFIoIStaSsNpReZS9FC6a5gR+Y8/mllN5kN?=
 =?us-ascii?Q?TCCktKIABkZa9I4EJhwTbL+zoVcEcmvaV65Xt5mZ7Dh32dhZPscqKXPp13gr?=
 =?us-ascii?Q?I/Ewc5aIpFRL5DK2N7ly55n9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6702.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3962e682-bdde-4cf6-b477-08d8d24fc321
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 07:52:08.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EakGL63COnK1NewKeXhbtEwPIDKno2EoTMSoOI0gQO7cagSGsdZaikBigDy6nZgaiKOuoN4Et5PSpUGdEsV+3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,


> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Tuesday, February 16, 2021 2:43 AM
> To: Wasim Khan (OSS) <wasim.khan@oss.nxp.com>
> Cc: bhelgaas@google.com; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Wasim Khan <wasim.khan@nxp.com>
> Subject: Re: [PATCH] PCI : check if type 0 devices have all BARs of size =
zero
>=20
> On Fri, Feb 12, 2021 at 11:08:56AM +0100, Wasim Khan wrote:
> > From: Wasim Khan <wasim.khan@nxp.com>
> >
> > Log a message if all BARs of type 0 devices are of size zero. This can
> > help detecting type 0 devices not reporting BAR size correctly.
>=20
> I could be missing something, but I don't think we can do this.  I would =
think the
> simplest possible presilicon testing would find errors like this, and the=
 first
> attempt to have a driver claim the device would fail if required BARs wer=
e
> missing, so I'm not sure what this would add.
>=20

Thank you for the review.
I observed this issue with an under development EP. Due to some logic probl=
em in EP's firmware, the BAR sizes were reported zero and crash was observe=
d sometime later in PCIe code.=20
I agree with you that such issues should have been caught in pre-silicon te=
sting, but not sure of pre-si testing details and if the issue was specific=
ally observed with real OS. Also, because the EP is in early stage of devel=
opment, device driver of EP is not available as of now.=20
So, I though it will be a good idea to print an information message only fo=
r *type 0* devices to give a quick hint if the zero BAR size is expected fo=
r the given EP or not. So that SW can contribute to identify HW problem.

> While the subject line says "type 0 devices," this code path is also used=
 for type
> 1 devices (bridges), and it's quite common for bridges to have no BARs, w=
hich
> means they would all be hardwired to zero.
>=20

Yes, for type 1 devices, it is common to have zero BAR size, so I added log=
 msg for type 0 devices only , which are in-general expected to have valid =
BARs.


> It is also legal for even type 0 devices to implement no BARs.  They may =
be
> operated entirely via config space or via device-specific BARs that are u=
nknown
> to the PCI core.

OK, I did not know this . Thank you for sharing this.

>=20
> > Signed-off-by: Wasim Khan <wasim.khan@nxp.com>
> > ---
> >  drivers/pci/probe.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c index
> > 953f15abc850..6438d6d56777 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -321,6 +321,7 @@ int __pci_read_base(struct pci_dev *dev, enum
> > pci_bar_type type,  static void pci_read_bases(struct pci_dev *dev,
> > unsigned int howmany, int rom)  {
> >  	unsigned int pos, reg;
> > +	bool found =3D false;
> >
> >  	if (dev->non_compliant_bars)
> >  		return;
> > @@ -333,8 +334,12 @@ static void pci_read_bases(struct pci_dev *dev,
> unsigned int howmany, int rom)
> >  		struct resource *res =3D &dev->resource[pos];
> >  		reg =3D PCI_BASE_ADDRESS_0 + (pos << 2);
> >  		pos +=3D __pci_read_base(dev, pci_bar_unknown, res, reg);
> > +		found |=3D res->flags ? 1 : 0;
> >  	}
> >
> > +	if (!dev->hdr_type && !found)
> > +		pci_info(dev, "BAR size is 0 for BAR[0..%d]\n", howmany - 1);
> > +
> >  	if (rom) {
> >  		struct resource *res =3D &dev->resource[PCI_ROM_RESOURCE];
> >  		dev->rom_base_reg =3D rom;
> > --
> > 2.25.1
> >
