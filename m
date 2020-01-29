Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3214C962
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 12:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2LQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 06:16:52 -0500
Received: from mail-bn8nam12on2075.outbound.protection.outlook.com ([40.107.237.75]:8512
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgA2LQw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 06:16:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfe1utxli/vQ2k9soeiHslL+/9/r96fjBDJp3sCfDfnfwEFl4i/QiugkYiPXDnM5kp7Cyy8WYAuRteOSAPD5A1LHDjeEFATLaTUQgDCimUYa3Ru36WRVo5QjRvshYdhMJQc8MoG2JGgWMQ7Mu3RfFsPZFCm/OkS8e/0T27fCG4iNkTjj+Xw3keBs6d6GsCFPbZOCi/I61Ne0QW9qlcPxyjysdpzABYQEi/SxYs4I8kf1ahFGDoL1CC6617oBjSh6jp2XJSSJq1S8ORzNsgIco36EuvDjLzEkJjPagfUt0NHFe6YCOa78/ucbLWgYe4AM/8imDwoImwyWdmM14+hZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BMtmUEcY/aO77XI2uwMPmUkpSyleNtAtcz8jRajn78=;
 b=oXbFDxZfR7AtxshAQI+mwqXJvp2Id6KXC58rBFStLKsy0XaOSko33ZsppyOx8+luPIbpfy1ryS05+j7+nNYlVLvzPnd80+0KewoKZnFO1lAtBjM+ChoYGOqrRunr+uY+fNMNusrVu0HrqpJOFDrVfRNH1N1XTmqwBk2eXQgQmD9awm8Sfxx/ZHGhQXK5SgFL2MbC2J6fHvQDRLZuLkyeFfwJMZr+ZBvriqlJ54Dh7C34p/vnCtmWXO0dwwl2KyWK+1gS+9xRmFaGnE3APVhKpogldhiOaxrWV2Ap5nKjt6UKtgbADgNnnEq2JHEqJ+2jU2OhdaXV6qIW+gLCWDjroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BMtmUEcY/aO77XI2uwMPmUkpSyleNtAtcz8jRajn78=;
 b=d3cr9Udwetl+4elMNOW2fOaugXNdmlpBbVZ1/eJmRGii7jeZQ29qU15FwBWHME8dS4kUWy2ObFyoJm2OvpfU5MxWKT/JEopmoVgabv9il88qsJeZNSPMAq9csxSGscv9lmkKEtmFs3H+D4az1Q1Lf4zp+cB3A5JmehxLNpM0Lvw=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB7085.namprd02.prod.outlook.com (20.180.26.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Wed, 29 Jan 2020 11:16:47 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::a181:b33f:2097:82d5]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::a181:b33f:2097:82d5%6]) with mapi id 15.20.2665.026; Wed, 29 Jan 2020
 11:16:47 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV1djPdcy89P+RjEyUcJUFKy6DOKgAG/4AgAFMXfA=
Date:   Wed, 29 Jan 2020 11:16:47 +0000
Message-ID: <MN2PR02MB6336D2BDBDF1B372AB5440BEA5050@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1580215483-8835-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200128140424.GA150109@google.com>
In-Reply-To: <20200128140424.GA150109@google.com>
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
x-ms-office365-filtering-correlation-id: e3d9e331-878a-44bc-7e59-08d7a4acbafa
x-ms-traffictypediagnostic: MN2PR02MB7085:|MN2PR02MB7085:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB708508A61F76F6C06BBD58DDA5050@MN2PR02MB7085.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(189003)(199004)(86362001)(186003)(316002)(26005)(7696005)(6506007)(66446008)(64756008)(66556008)(66476007)(54906003)(9686003)(5660300002)(55016002)(33656002)(6916009)(52536014)(4326008)(107886003)(66946007)(81156014)(71200400001)(478600001)(2906002)(8936002)(76116006)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7085;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SSD2Cfk/09IU3hpWkRLv8nwaOrcYrDXOvxw8sR0jtXEd1AX5xs7Jn8GiG3OePSUu8pns/HoVapE9iJPn2ok5MM6z0xn3r/Hk96uvrrY/q+zE9CkFQmpxMVMRQ1d+zAxnM709P/ju1x2dXFVIu+Vxo9xRGXwWrl8XliGRYhVPBkm4muPIhcVZutnPJn//ryG54fzUNVvmBvfTTW83rwUMhNFpsd6QIbS53hH1HXAFqMUTmNOjpf815xD2gYAq9hex2bNsHdnXKoSf08Y+iwoH+JWub1YCuKplB5UHTvx2D6H0RC1ARLCrom4VsEuXkTMkaNLxk8aL9hIYTLUev33WsWVwmD5uDWrSXMD16R3NMTAi65A1PoRzv+2DuA2GrkTKYHBIkOHqkBvqcyYw08HMygb17zCHX9EN0G8euKkzlEbAn94ZA9wwYU3RMJoECtsI
x-ms-exchange-antispam-messagedata: vQ+vNv3le0Q9ybNMWj1ZkodSlveQc89GF685/pHv7qbSi2UjympCFDXgq9hvQqX5TFdK2fZtnRgVn37o47F1iJFoAsuliO6TQ6sHFvPbobqgwukEHCpMhXNf4+riNR8H9e2NmTmqPdItNdmNW2k12Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d9e331-878a-44bc-7e59-08d7a4acbafa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 11:16:47.2444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGC8bh8clMSTzNqWCYQJTd2NIWDDG0U9/BP9/5MWUXSAQPSl1/U/+X3wbD5lnBqt0CmNAPKA6cg1SvYoOovpig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7085
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Tue, Jan 28, 2020 at 06:14:43PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrate=
d
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
> >   vectors and handling MSI/MSI-X interrupts.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific MISC interrupt line.
> >
> > Changes v4:
> > - change commit subject.
> > - Remove unnecessary comments and type cast.
> > - Added comments for CPM block register access using readl/writel.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ...
>=20
> > +static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
> > +					 unsigned int devfn)
> > +{
> > +	struct xilinx_cpm_pcie_port *port =3D bus->sysdata;
> > +
> > +	/* Only one device down on each root port */
> > +	if (bus->number =3D=3D port->root_busno && devfn > 0)
> > +		return false;
>=20
> This whole *_valid_device() thing is a mess.  We shouldn't need it at all=
.  But if
> we *do* need it, I don't think you should check the entire devfn because =
that
> means you can't attach a multifunction device.
>=20
> Several other drivers with similar *_valid_device() implementations check=
 only
> PCI_SLOT():
>=20
>   dw_pcie_valid_device()
>   advk_pcie_valid_device()
>   pci_dw_valid_device()
>   altera_pcie_valid_device()
>   mobiveil_pcie_valid_device()
>   rockchip_pcie_valid_device()
>=20
> Even checking just PCI_SLOT() is problematic because I think an ARI devic=
e with
> more than 8 functions will not work correctly.
>=20
> What exactly happens if you omit this function, i.e., if we just go ahead=
 and
> attempt config accesses when the device is not present?  We
> *should* get something like an Unsupported Request completion, and that
> *should* be a recoverable error.  Most hardware turns this error into rea=
d data
> of 0xffffffff.  The OS should be able to figure out that there's no devic=
e there
> and continue with no ill effects.
>=20
Thanks Bjorn. I did test and I do not see any issue without this.=20
Will resend patch with this change.
> > +	return true;
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_map_bus - Get configuration base
> > + * @bus: PCI Bus structure
> > + * @devfn: Device/function
> > + * @where: Offset from base
> > + *
> > + * Return: Base address of the configuration space needed to be
> > + *	   accessed.
> > + */
> > +static void __iomem *xilinx_cpm_pcie_map_bus(struct pci_bus *bus,
> > +					     unsigned int devfn, int where) {
> > +	struct xilinx_cpm_pcie_port *port =3D bus->sysdata;
> > +	int relbus;
> > +
> > +	if (!xilinx_cpm_pcie_valid_device(bus, devfn))
> > +		return NULL;
> > +
> > +	relbus =3D (bus->number << ECAM_BUS_NUM_SHIFT) |
> > +		 (devfn << ECAM_DEV_NUM_SHIFT);
> > +
> > +	return port->reg_base + relbus + where; }
> > +
> > +/* PCIe operations */
> > +static struct pci_ops xilinx_cpm_pcie_ops =3D {
> > +	.map_bus =3D xilinx_cpm_pcie_map_bus,
> > +	.read	=3D pci_generic_config_read,
> > +	.write	=3D pci_generic_config_write,
> > +};

Regards,
bharat
