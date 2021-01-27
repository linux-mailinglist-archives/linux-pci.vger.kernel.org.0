Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F7305299
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 06:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhA0F4h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 00:56:37 -0500
Received: from mail-bn8nam08on2061.outbound.protection.outlook.com ([40.107.100.61]:57153
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238330AbhA0FEL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 00:04:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzl9RJE5PpXMH81WsW0M21vDvln5GfJWjeYg8dSeO0YsfmGlCzFzpBjbyqtbVMcpeHpr2X4+8OAGKpXElJY/1UVGFiK8ZHea9LkiWiS6Swj0VINvDNAK7E75AES+y0t2ULPCexjaHjzTdBuAIsmRPtbR43QxN8IuLfyv8VfrL0yoI5KHHTdc6xUjtbJGzGKwaWyZWPeOryP1mk/nb8vcn113r5lJEy0vhnIXjuBSsjghKWYB7O6AceAftOpS+tOqR1dFkO4/kNzsi4VeqAdRceLk7OVf5i2wT/HFi6FI3IaBViOn67uKniHgRAPl74WvQwuQO/bv1aceJiBPVTexAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVF7YbhggRvHBjH9x2MWaBg0DpT81QSZHL6d2O/e0sA=;
 b=MlSuLEwKW7bv33OuBrtFLzkqJTt5qdGvALIP5lk5Dkw/cdJ1f/Zq8uzjQUfDg/unKbUfrN5prawBoks8PRiSeM9Hbei6HaRLwU7GNsAFBrD2H+A7LXbdqUGBiEYVrqgKtispUHEn5kJod17HLgVKHmvXExCNf0bK+zh4wPgXNDTHws9+x2YPorjpAEgQtrqZiZ7amGsNb4V+NqZzmqfChOTz8T/OV9pbcD1bfMqDNxLfjTQXUrR4or8rpHEnqOz5BVX0jswDQDJ5Q5Lwu2pOQx26SGypSovW49KSAvqQZ17gWJBia2h+oTca3YQQj+zBQoNGX6YZNmY4Ia/N9LFFPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVF7YbhggRvHBjH9x2MWaBg0DpT81QSZHL6d2O/e0sA=;
 b=qZ+8FO1Dww4C3RiC66tutL1QvIQ5e3vaujXhbE+l69VBa7B1Y0xFArtm3qOKuezguEFReWoh2+0MxfZ0DG59iYB2Mhb5aTV5PpT5LokxMUTEU7oa58tWc84NQwTIxhe73j2zqgExJ1V6QyZG9tNMByFOL2sk8DqqwVujVfWINQM=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5125.namprd02.prod.outlook.com (2603:10b6:a03:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 27 Jan
 2021 05:03:12 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ccbe:b88d:35e5:352e]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ccbe:b88d:35e5:352e%6]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 05:03:12 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH] PCI: xilinx-nwl: Enable coherenct PCIe traffic using CCI
Thread-Topic: [PATCH] PCI: xilinx-nwl: Enable coherenct PCIe traffic using CCI
Thread-Index: AQHW79waWBCZJOrJ4Ua2pJ5DbOkqmKoyRSyAgAirLKA=
Date:   Wed, 27 Jan 2021 05:03:12 +0000
Message-ID: <BYAPR02MB555964381D30E72FC79B4F7CA5BB9@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1611223156-8787-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20210121162827.GA2658969@bjorn-Precision-5520>
In-Reply-To: <20210121162827.GA2658969@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [60.243.183.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18234e23-b7e3-4851-552a-08d8c280d8ea
x-ms-traffictypediagnostic: BYAPR02MB5125:
x-microsoft-antispam-prvs: <BYAPR02MB512518294EE58CA6680B79A3A5BB0@BYAPR02MB5125.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bFQvA+TpbbuLBMK1s6c7Mxt3LM9UHE2LJEcE5gSx10NgVOg3FU0gEleU3eXjw3fyCMNwvKtfX6WrS6GYUQuKJ76zkdAHEXftsCc3bNmQuHlxeu7BynIJtVD7Cn4lZ1P0HzPrDIoVbK37dyb6VWZQ4t+arGDqWAgAhsb6AOPG8PDYdIJeiUVxQ49DZbnR5GkLj/0jXdJtz+T5y3UQhspuYMkyU3btYzOws22WXNrekj3EIs3yXMQ6Mta23M7cTCDJA076DowaYeH7RiupXHypSTGaGUtzRx6plLDsQarZFZiV64TqVn8hoRY0KvjKRM18apW6StFbnR0Gl+kOb7/ZfWjMGRB0o8biuU4i81U4Xp5yF1qhx5SPkH10huY9B+YU1NuBDw2lFcrz67fl2WJd+LbjNBO8c5dtpRa6GXYh9KwRYb36z99DN9P1FfBEYOPY2X7ZI2lRyVQ0THE5fDb2d0HLZ7f9U6wNgeMdE5+HBuRC0IgoFpPJG1uP5L17W6scaH88MpPkJRajx6DfXfDrMZwccwXGFrKiWWAgIwGff+EFgRY6QIlKib+rF3O8jTEE8loo+IZzx2ae9NlrQZfuQvruS9QGy47XdTEP/mjUva0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(6916009)(86362001)(478600001)(5660300002)(8936002)(9686003)(64756008)(66476007)(66946007)(8676002)(66556008)(66446008)(76116006)(71200400001)(52536014)(7696005)(26005)(2906002)(4326008)(55016002)(6506007)(316002)(186003)(83380400001)(33656002)(966005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TeUgTb500IxtW4ZI9a38wKyQ6F4BG+fg0GCvbSgojcuRk5X1JNqhkQF+c0QS?=
 =?us-ascii?Q?9TEs+2Y1zhWNWXznQvpPJcIf5nEZogF6fqJbC92lQlSowhC9XVMe3+L58U9+?=
 =?us-ascii?Q?ZDV0zF3N9GxxM1neFyFrEo344+AUjf24MVk3xVJsAUVrZrs6h4yWm94f/k8H?=
 =?us-ascii?Q?0wSHR/eAESroEoIrdDbabhsQgdyl6WYXZyGD6L1jVaWzJhKHiMIZBZ/Z7gIb?=
 =?us-ascii?Q?yvZYnWNbmjwRqy2lq39ITbDVmC80W2YnD5ByUK/ymMOSMV4xOP9AvNa99K2o?=
 =?us-ascii?Q?rLTauFQuBIRF1H9pU8WDrgCHgjeAVtP+cO2dZ4f3nzLKwsbQTWXy1ApAqdCj?=
 =?us-ascii?Q?8DmIi3VuJKfUydlPI9WwwryG/BSGc6dUJJ/9ve8jnDQu9Ej9uz08sLeE414E?=
 =?us-ascii?Q?qgna2sl5C+VeheJl+5qAXgp4r+G1dyAM2SrYOyMTjKy0QqxZzmqgsjD5om35?=
 =?us-ascii?Q?Him7KTdqvcSg11hN3ywcqK3A9RsWaA69gJHsz0WDiQ98d4QMQLFM0y5GUgr8?=
 =?us-ascii?Q?LkgvCiFj6yHpsy8aD9cW2hqKTD5UKINArIAi2LgB51fhEiBUe9hTHpBeUpMc?=
 =?us-ascii?Q?BQcGBQwcThd2g2oJB2QqwTLAH4lqyILYTFJlXHDk31C/xIAW3xvbXOS8di93?=
 =?us-ascii?Q?esZyw22UQRX9v/CGOIG1VT8ARH4YOFvS6GGp/iUFwRwHXO+j8Jnea0scqWwu?=
 =?us-ascii?Q?NkTzcEkRkRxZjzA6ICimGnqXJD27ONyqmaHKZ1pIGguM9tQITRM1PRx516HA?=
 =?us-ascii?Q?gCw8x0HVnx8uPKLQn8BnrXff1MGIWZt0qWDHcrX+BDDbWHLGMu/ob8b1lAav?=
 =?us-ascii?Q?DUISE6ruEqH57yBMqg827j8VR1suzvJ8XhIf4cJsleMr/ycNywBtZWIz0Q6C?=
 =?us-ascii?Q?HKn+01DZ3Z26qAXFb7lj6N4PCJDIxDGLD54wm2uh6kZlZjr9fprZI1+H71Bu?=
 =?us-ascii?Q?U1bciOPH2r3dYu3eGDIv7Jk8VBLwcFMmE8WfUbZm9I5ImMjnyMM/1pe+rrzV?=
 =?us-ascii?Q?6lLWvoBqKBWCZomKFs9M7Svmf4ODlO4GzllqCWvoh+lNkNEfrt7o4ZUudaBw?=
 =?us-ascii?Q?v0dx/6DY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18234e23-b7e3-4851-552a-08d8c280d8ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 05:03:12.2734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf1JA3Fge3HkxCnp3vq4jWDmOycjbYVsvJsGcIjqfZqSnw0yhCfnknC7cYdNxrc8esuUR7thjFAuMD5YLTRNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5125
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> [+cc Rob]
>=20
> s/coherenct/coherent/ in subject
> s/traffic/DMA/ (this applies specifically to DMA, not to MMIO)
>=20
> On Thu, Jan 21, 2021 at 03:29:16PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for routing PCIe traffic coherently when  Cache Coherent
> > Interconnect(CCI) is enabled in the system.
>=20
> s/- Add/Add/
> s/Interconnect(CCI)/Interconnect (CCI)/
>=20
Thanks Bjorn for corrections.
Here is the CCI spec=20
https://developer.arm.com/documentation/ddi0470/k/preface

> Can you include a URL to a CCI spec?  I'm not familiar with it.  I guess =
this is
> something upstream from the host bridge, i.e., between the CPU and the
> host bridge, so it's outside the PCI domain?
>=20
> I'd like to mention the DT "dma-coherent" property in the commit log to
> help connect this with the knob that controls it.
Yes will add it.=20
>=20
> The "dma-coherent" property is mentioned several places in
> Documentation/devicetree/bindings/pci/ (but not anything obviously relate=
d
> to xilinx-nwl).  Should it be moved to something like
> Documentation/devicetree/bindings/pci/pci.txt to make it more generic?
>=20
I will update this property in documentation as optional property.
Rob can confirm if this can be moved to generic.=20
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c
> > b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 07e3666..08e06057 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -26,6 +26,7 @@
> >
> >  /* Bridge core config registers */
> >  #define BRCFG_PCIE_RX0			0x00000000
> > +#define BRCFG_PCIE_RX1			0x00000004
> >  #define BRCFG_INTERRUPT			0x00000010
> >  #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
> >
> > @@ -128,6 +129,7 @@
> >  #define NWL_ECAM_VALUE_DEFAULT		12
> >
> >  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
> > +#define CFG_PCIE_CACHE			GENMASK(7, 0)
> >
> >  #define INT_PCI_MSI_NR			(2 * 32)
> >
> > @@ -675,6 +677,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie
> *pcie)
> >  	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> >  			  BRCFG_PCIE_RX_MSG_FILTER);
> >
> > +	/* This routes the PCIe DMA traffic to go through CCI path */
> > +	if (of_dma_is_coherent(dev->of_node)) {
> > +		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie,
> BRCFG_PCIE_RX1) |
> > +				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> > +	}
> > +
> >  	err =3D nwl_wait_for_link(pcie);
> >  	if (err)
> >  		return err;
> > --
> > 2.7.4
> >
