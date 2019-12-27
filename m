Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17ADF12B45F
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2019 12:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfL0Lzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Dec 2019 06:55:47 -0500
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:42144
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfL0Lzq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Dec 2019 06:55:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIeW7O0ZaIYrfKXyrZEKi+FtSYYc1ksOrfCe916rY2nGo39tIAtRywCa/wNJBXv/W0cLeB+UHSkRYuz4MI6BQNoWloIwA9qkkQJZcMU3AwUXxV+01dptats/kl5Wipgzufr2dkciuO5Ce84o416DnBD2VpBI7KCWD5e2rTUzsbHGr0B40TXT9caHzbwQVX19O2RB+qIqxDs7D2IEwV08b6JUV0nNB5o5KtJIcVzAljZmgoXIaS2J88CXnF295aoFkGTZGmraVDrftzmCgWiBBnjK9oFOLRPtIYiAI8NAdtyMl38V0rJVU9jqwCrHtBnccg01Ho8OR6ab+IQHqCvB7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMWmVLnuiw1+mlJpvarOSsSKKS+zf/WY/Vyj9VqCqWs=;
 b=bB3zg6ctFIFTJNoYi+DtgNpgKqUWjjFZcB+XUJG9tymEbhp3e+urqlTOASrjlOyztV594xzGzt/S7JT6XW7zxE/mtKKm4eOUggYigFlxCTb+qaxN6SqJe/g0mGBjl5x7PZRBnqsng+wjT+eOQ0P84EyCTXiDG6gb6y8hKm4o8LVWwpUZ5nX1NcT59p5X7cnRDjeDs++vxIPissVJrWETlgCGHOHnEgrdgC1iTmyoCawYGJmrxMruUuZcd2ldfE1Du6BytyU/BbLG1oofdMgM55NBPHJrn5PwqmUJ01KRKlMQk3PXJ5hOs1kC2J6vEaKCij4oEOVY86RCMvZO3Ii1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMWmVLnuiw1+mlJpvarOSsSKKS+zf/WY/Vyj9VqCqWs=;
 b=Zx8dfvelcg7Syv8GP+oHB5gBbyJhN2Ei6T4i+PUfSPEuNnU1YNzvcvUGPVtOHmU+SQgmq99a7TlQt0HAabl4Bp0l7fXc7EFpdoMaEgPrUJripztra9mkGO18whUKcKZaonWnEDHht+aMgC31PrCSf5EK8/SqWBRzcmYyW1KJj1s=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB6383.namprd02.prod.outlook.com (52.132.175.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 27 Dec 2019 11:55:41 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f19a:a426:d2db:49ba]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f19a:a426:d2db:49ba%3]) with mapi id 15.20.2581.007; Fri, 27 Dec 2019
 11:55:41 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: RE: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root Port
 driver
Thread-Topic: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Thread-Index: AQHVtypsQVCQA4Pdl0W2IKkLYMD11KfDHY8AgArLTXA=
Date:   Fri, 27 Dec 2019 11:55:41 +0000
Message-ID: <MN2PR02MB6336D981AA38923276DAAF43A52A0@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1576842072-32027-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20191220145832.GA93984@google.com>
In-Reply-To: <20191220145832.GA93984@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eadb79e3-3a72-49c4-2d25-08d78ac3b290
x-ms-traffictypediagnostic: MN2PR02MB6383:|MN2PR02MB6383:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6383362EB687924B0FC66F90A52A0@MN2PR02MB6383.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0264FEA5C3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(2906002)(55016002)(478600001)(33656002)(4326008)(5660300002)(9686003)(52536014)(54906003)(316002)(186003)(71200400001)(7696005)(8936002)(81166006)(8676002)(81156014)(66476007)(6506007)(66446008)(66556008)(76116006)(26005)(6916009)(64756008)(66946007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6383;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6TzSihQFoLgagSqvNXuhGLTu4Ikq7dfwpIniMAeyVJv60861otyKN+BRBrkYawJO8DmKlS++Yj2fQ1PlxMSrwTColbzflNfKCVtiDJTsiroRFFIGhS3rtDEfl+eQ1kBYp+FyzZNMZt6VZUuM9q6WL1goVMJ5iIN4tqLQorSXiTz2YVd/VTqYv74lm1JZQ7uoT9XRLJLXpb51dDGlr4CBvrlE0B3Va56jyi4wY6H4pN5rnywQtGHMRlSkbwgodMIX42lSzvwrU0hP982s+zTyLFPz5iM8xS7tTL7nhwWq+nM644EHu+U4VxXfbrJQ3/waDD9Xq62yEmbnuxQBLa0J7W72rSNUFJQQ/MteDlbj7iiJ236Z7t3yTXSDr7aUNNGvO2Kp6s22lTbOitt7A/EAqyB5NOs+DKimNcC+zIi0qRtd8dS7ZrB3f16btSPsH+K
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadb79e3-3a72-49c4-2d25-08d78ac3b290
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2019 11:55:41.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bopY3yQ0JL/oMqMEsdY9bNxHzmyEGIBZlaFeKvZ1wjsNt13saSPLc+6cUmnw72tF1aK4J+ZRtue8wVQJHeukhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6383
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root=
 Port
> driver
>=20
> [+cc other drivers that use the broken "is link up" test in config access=
]
>=20
> On Fri, Dec 20, 2019 at 05:11:12PM +0530, Bharat Kumar Gogada wrote:
> > - Adding support for versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
> >   vectors and handling MSI/MSI-X interrupts.
> > - Bridge error and legacy interrupts in versal CPM are handled using
> >   versal CPM specific MISC interrupt line.
>=20
> "Versal" appears to be a brand name and should be capitalized consistentl=
y.
>=20
> > +#define INTX_NUM                        4
>=20
> Don't we have a generic PCI core definition for this?
Thanks Bjorn, will fix this with core definition.
>=20
> > +static inline bool cpm_pcie_link_is_up(struct xilinx_cpm_pcie_port
> > +*port)
>=20
> Please follow the example of other drivers and name this "cpm_pcie_link_u=
p()".
Agreed, will change the name.
>=20
> > +{
> > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0; }
>=20
> > +/**
> > + * xilinx_cpm_pcie_valid_device - Check if a valid device is present
> > +on bus
> > + * @bus: PCI Bus structure
> > + * @devfn: device/function
> > + *
> > + * Return: 'true' on success and 'false' if invalid device is found
> > +*/ static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
> > +					 unsigned int devfn)
> > +{
> > +	struct xilinx_cpm_pcie_port *port =3D bus->sysdata;
> > +
> > +	/* Check if link is up when trying to access downstream ports */
> > +	if (bus->number !=3D port->root_busno)
> > +		if (!cpm_pcie_link_is_up(port))
> > +			return false;
>=20
> This check for the link being up is racy and should be removed.  The link=
 may go
> down after the check and before the config access.
>=20
> A config access to a device where the link is down is an error, but it's =
an error we
> expect to happen because of enumeration, surprise unplug, or electrical i=
ssue.
> It's impossible to avoid so we must be able to handle and recover from it=
.
>=20
> I know there are other drivers that do this (dwc, altera, xilinix-nwl, xi=
linx), and
> I've pointed this out many times in the past.  This needs to be fixed.
Agreed, will fix this check.
>=20
> > +
> > +	/* Only one device down on each root port */
> > +	if (bus->number =3D=3D port->root_busno && devfn > 0)
> > +		return false;
> > +
> > +	return true;
> > +}
>=20
> > +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data)
> > +{
> > +	struct xilinx_cpm_pcie_port *port =3D
> > +				(struct xilinx_cpm_pcie_port *)data;
>=20
>   struct device *dev =3D port->dev;
>=20
> to reduce repetition of "port->dev" below.
Agreed, will fix this.

> > +	u32 val, mask, status, bit;
> > +	unsigned long intr_val;
> > +
> > +	/* Read interrupt decode and mask registers */
> > +	val =3D pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> > +	mask =3D pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> > +
> > +	status =3D val & mask;
> > +	if (!status)
> > +		return IRQ_NONE;
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
> > +		dev_warn(port->dev, "Link Down\n");
> > +
> > +	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
> > +		dev_info(port->dev, "Hot reset\n");
> > ...

