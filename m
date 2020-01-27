Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D4414A487
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2020 14:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgA0NG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jan 2020 08:06:57 -0500
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:12993
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbgA0NG5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Jan 2020 08:06:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S67M+VAl25SRgexUdSy74KtRNQguYsFe0lPPCaK4mE/Vy8wndpUCg92h1tjdA+ArxogPDWa5qwlMSAaEfp3HSaFkuEZrLeM8MH8Xi0BQLpJp+h2D/Rrh9QY2cNSmC4ZYeV0Eql+tQqfjx7m3Q6L42nMRQ0Wq8ESrLP/bHmY/ogQg62AXj+J2cEMgb1MsLkl/OnwWt8uHCY95FeWWLGjkmLdSIn1tjpw9evBlgOVVy/Q33RNFkF8nKlYAVqmAmwkRd+wPiIEevHID4oWuIbhy4AQg3JJ5uLwfKQfgN0XiF9TN6MjhxChnwcvgvh3Wj4TALA6B7inFbnE14NeaxxCfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i2T9wcL7OdNfyKayF3jFjPODLYRsmX0nuTos4TqKGE=;
 b=jNYyTje9t6aWx0zn3o/apFFTZnU/Zs4mhzcBhz8eHLE1d2Bx6/HObkhcL+rtpgZQGHWkV/jiZC+Oq37eA62rMSeFijz1VjwtDupklauhXSNEq9x25Fj8U7cGYAHdI4ApnzVxjdC9r8DExBXDDDVrfMxUfn+fQ75BiZRyJBdHbz9yDYdATwKRaqVl5fyd1zF0Ds8lEfs0F6vxyGoOZJIgPDKUPfXCJQcAGnQcG+Y3/NWylfMRtdNNjWq7qWOnN4vM+cE/vdNNSXuz2RxffY90lSGY82XbizVQ64ysg2CxlTlg22cK8Bz0Svmc8sKkhwsJVkA7UNzk3ajQe3ZyT4TVeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i2T9wcL7OdNfyKayF3jFjPODLYRsmX0nuTos4TqKGE=;
 b=Rl3dDNhmW8KnNSLiirLhv7eiDEX38/ohnYfSSvBZJIAOIR/T663kcwoY3cMYO30D3OtBDUSMow9V3wK0ip1V3rEH/Vk2FwwyCK7Pl+SRJNTAN+QjkM9WD9LcdZpwreTj1Q0zhE5rtukCxGCqZRxutyVLaGb2WVsmqBJDz8eIFtI=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB6671.namprd02.prod.outlook.com (52.135.49.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 13:06:54 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::a181:b33f:2097:82d5]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::a181:b33f:2097:82d5%6]) with mapi id 15.20.2644.028; Mon, 27 Jan 2020
 13:06:54 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v3 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Thread-Topic: [PATCH v3 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Thread-Index: AQHVyfjOYP1OKhHeMUCSmomtiUQ5I6fpL1IAgBVd0IA=
Date:   Mon, 27 Jan 2020 13:06:54 +0000
Message-ID: <MN2PR02MB633624087571F37F95F1D915A50B0@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1578909821-10604-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200113223436.GA128724@google.com>
In-Reply-To: <20200113223436.GA128724@google.com>
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
x-ms-office365-filtering-correlation-id: 51931b81-d1d9-40a9-2342-08d7a329c838
x-ms-traffictypediagnostic: MN2PR02MB6671:|MN2PR02MB6671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB66718B8F686B46531BA177BEA50B0@MN2PR02MB6671.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:854;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(107886003)(5660300002)(2906002)(54906003)(52536014)(478600001)(86362001)(4326008)(7696005)(33656002)(9686003)(55016002)(81156014)(8676002)(81166006)(8936002)(6506007)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(186003)(26005)(6916009)(64756008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6671;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+fqPf6biE19yUZzPpemlS+4x0tkF6Z4BwUT1WgvnN3klMi4hkPyi/81VgdSK4EkvwkM5Ss45jmsxvYZ8ENCoiiXil2iSzHRka/mJ2+dV5DeL7zCsdUlCdyBPMwm0Cv5US25JMzrgRfFf0yk7n++0A65CQ8Ou0xlDnXRyq7lDALenU5D2boTTkStr1CQTiFdJkCk+mz29iNoD4tMwagjB0ZgOlNoxorez6JXtf0wCv4ts+Cyiat9dnzijcCwHYuRF/RTTVbkNsOtzaAqIhgkcZVPg1eHi7eHGoMabLb1NNn/u+vAvCoRWQaJSL2P0VMj+2CTBLjxzN+LL91+VzabbVFXJsk4UO7xD4uFx7tCcG5pfTX1QrJ6OBaTAbXmHZLU+UyyimhmiTdPhMeiZuHZIWCUYycIu6m3P89fngfUPjQttoQR7QLtNUbK+Z8nI8a6
x-ms-exchange-antispam-messagedata: IQh0CiFRBMVccy3C37RC0FbJ60sPu+wFMBac9KhldjvsjgVx0suDVcCw9dVNLEItcTXwv+dAxaM1ekdcWFOMoEhfQlXmgvrm21YUP7GW8Y5LTcGLW7CaMFNUeYsiD2SaEWsHyB8taBoJrdE0ffJUOQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51931b81-d1d9-40a9-2342-08d7a329c838
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 13:06:54.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9sOwI/DU18iHzcwNWf2IFpymFEmhf6d8r27dab6QyPkXxAh8GQsr+gDZNvhIep9eCq4U3g1cw2+QgqOGoUwgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6671
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v3 2/2] PCI: Versal CPM: Add support for Versal CPM R=
oot
> Port driver
>=20
> s/PCI: Versal CPM: .../PCI: xilinx-cpm: Add Versal CPM Root Port driver/
>=20
Thanks Bjorn, sorry for late response.=20
> Format is "PCI: <driver-name>: Subject"
Accepted will change the subject.
>=20
> On Mon, Jan 13, 2020 at 03:33:41PM +0530, Bharat Kumar Gogada wrote:
> > - Adding support for Versal CPM as Root Port.
>=20
> s/- Adding/Add/
>=20
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - CPM Versal uses GICv3 ITS feature for acheiving assigning MSI/MSI-X
> >   vectors and handling MSI/MSI-X interrupts.
>=20
> s/acheiving//
>=20
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific MISC interrupt line.
> >
> > Changes v3:
> > Fix warnings reported.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> "Reported-by" is for bug reports.  This makes it look like the lack of th=
e driver is
> the bug, but it's not.  Personally, I'd thank Dan and the kbuild robot, b=
ut not add
> "Reported-by" here.  It's like patch reviews; I don't expect you to menti=
on my
> feedback in the commit log.
Accepted above comments will fix these in next patch.
>=20
> > +config PCIE_XILINX_CPM
> > +	bool "Xilinx Versal CPM host bridge support"
> > +	depends on ARCH_ZYNQMP || COMPILE_TEST
> > +	help
> > +	  Say 'Y' here if you want kernel to enable support the
> > +	  Xilinx Versal CPM host Bridge driver.The driver supports
> > +	  MSI/MSI-X interrupts using GICv3 ITS feature.
>=20
> s/kernel to enable support the/kernel support for the/ s/host Bridge driv=
er./host
> bridge. /  (note space after period)
Accepted , will fix these in next patch.
>=20
> > + * xilinx_cpm_pcie_valid_device - Check if a valid device is present
> > + on bus
>=20
> Technically this does not check if the device is present on the bus.
> It checks whether it's *possible* for a device to be at this address.
> For non-root bus devices in particular, it always returns true, and you h=
ave to do
> a config read to see whether a device responds.
Accepted, will change the comments.
>=20
> > + * @bus: PCI Bus structure
> > + * @devfn: device/function
> > + *
> > + * Return: 'true' on success and 'false' if invalid device is found
> > +*/ static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
> > +					 unsigned int devfn)
> > +{
> > +	struct xilinx_cpm_pcie_port *port =3D bus->sysdata;
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
> No cast needed.
Accepted, will fix these in next patch.
>=20
> > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port
> > +*port) {
> > +	if (cpm_pcie_link_up(port))
> > +		dev_info(port->dev, "PCIe Link is UP\n");
> > +	else
> > +		dev_info(port->dev, "PCIe Link is DOWN\n");
> > +
> > +	/* Disable all interrupts */
> > +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IMR);
> > +
> > +	/* Clear pending interrupts */
> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> > +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IDR);
> > +
> > +	/* Enable all interrupts */
> > +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IMR);
> > +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> > +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
> > +
> > +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> > +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
>=20
> This lonely writel() in the middle of all the pcie_write() and
> pcie_read() calls *looks* like a mistake.
>=20
> I see that the writel() uses port->cpm_base, while pcie_write() uses
> port->reg_base, so I don't think it *is* a mistake, but it's sure not
> obvious.  A blank line after it and a comment at the _MISC_IR definitions=
 about
> them being in a different register set would be nice hints.
Accepted, will add comments.
>=20
> > +	/* Enable the Bridge enable bit */
> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> > +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> > +		   XILINX_CPM_PCIE_REG_RPSC);
> > +}
>=20
> > +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port
> > +*port) {
> > +	struct device *dev =3D port->dev;
> > +	struct resource *res;
> > +	int err;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
>=20
> The "struct platform_device ..." line really should be first in the list.=
  Not because
> of "reverse Christmas tree", but because "pdev" is the first variable use=
d in the
> code below.
Accepted, will fix these in next patch.
>=20
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > +	port->reg_base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(port->reg_base))
> > +		return PTR_ERR(port->reg_base);
> > +
> > +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> > +					   "cpm_slcr");
> > +	port->cpm_base =3D devm_ioremap_resource(dev, res);
> > +	if (IS_ERR(port->cpm_base))
> > +		return PTR_ERR(port->cpm_base);
>=20
Regards,
Bharat
