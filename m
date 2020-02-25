Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB3B16C2C9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 14:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgBYNxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 08:53:44 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:7257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbgBYNxo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Feb 2020 08:53:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0EOgh4w5cj9Anx+rpU2R/knvqGIgnOlJYfR26xHR1f4WDzA6+iuOJikunj0y7pYOMDnLCsMsOKeFPU2c0dt379l8XiIEFl+HluSE08OtEPUwE/gpSYZDGgQUUd0Bdm5IlheUedCH/H4ITgEAtLrECeKaABlusgm4OPwM/Txc+Nog6WNOTjTp9Z6Y+pI+uqPjszdGJxEyixupQvFfVhjABu+3e/g83LlUUH+G03qiE8QHjjIYoKdzTaS2YPuRPYTuOGUgCdFSCcZzn7xruBr5sHns2iBgOaRnCXsrZY+qYoI2gn3WGRuGR33o782gfB037UCsZZskoVFp0ktjvVT7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/tRXFh5cywy7PlV5Q88yHHPDOWdqiruyWu5By+svX0=;
 b=i/fM6Jv3B1Ksib90CuZ1bRmYv+2N9XUXP+83cVYWPuhgrP47ViHSR/AOG1/9DBNJoLlIaBOO7+mHosk9BODHqKDIsa4RQFmEzqsJ/hcaabXSABeG1NbMAZOnYlSO+M5FwypPurgN/nyD4MBT0gioo47dZnz2qwRmZSgB9vv36A7MeFWGFI1kE++GQOIxEtmJ1KHWAzSjPF49pgrziX0/eQEGzLGtL/WZzZSBubwrzb72N2FihPE0DGYMpcl3EMnCJUjgldpKQvwHi/2Ai8yJodDYJGqxiHjQKfhIb5jtyp6NLOWvw/XzC36laMn7kmsk+3ybdilE+3If08C22UHGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/tRXFh5cywy7PlV5Q88yHHPDOWdqiruyWu5By+svX0=;
 b=mC54EQb8nWDoaxQ0pwVlN4idoCQXsvwAvfL6aR9mBAWNg3mcjCRggQv6ZHBvMTxksKGmO2gKmNIlZMgmy3HnByX+911JdpLgyIecjBpuhJhKaS3q2pIlGFn654ddBzqn0Jkwz+nDTN9CoJ5j5nHc9qS0DHoWRo62SJ+Muw6d4Is=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (2603:10b6:208:1b8::30)
 by MN2PR02MB6975.namprd02.prod.outlook.com (2603:10b6:208:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 13:53:39 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f452:65fb:14c7:dd6b]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f452:65fb:14c7:dd6b%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 13:53:39 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 1/2] PCI: Versal CPM: Add device tree binding forversal
 CPM host controller
Thread-Topic: [PATCH 1/2] PCI: Versal CPM: Add device tree binding forversal
 CPM host controller
Thread-Index: AQHVtypssK4lIAAUvEC8dXg0z5iyHagsJpcAgAAw40A=
Date:   Tue, 25 Feb 2020 13:53:38 +0000
Message-ID: <MN2PR02MB6336EE21A8BBBD36788D2108A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1576842072-32027-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1576842072-32027-2-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225105808.GA5089@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200225105808.GA5089@e121166-lin.cambridge.arm.com>
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
x-ms-office365-filtering-correlation-id: 739b0ecd-ddae-46ce-db24-08d7b9fa1e05
x-ms-traffictypediagnostic: MN2PR02MB6975:|MN2PR02MB6975:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB69753E5A57B1683D3906F02EA5ED0@MN2PR02MB6975.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2906002)(81156014)(81166006)(8676002)(6506007)(66946007)(316002)(71200400001)(54906003)(5660300002)(55016002)(52536014)(9686003)(66446008)(64756008)(66556008)(66476007)(4326008)(8936002)(107886003)(33656002)(6916009)(7696005)(86362001)(26005)(76116006)(478600001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6975;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5tBqFWZzBis9RO3HSqaFLHTCGIhzQ4yfNtLYQhVFciy5iWjvegWUprW+axBBZWmCEUIxtG9uYqq0SgClO6Z/bcNlHlkSjX/0HTh8YWbUh3Gk4wsMPQ8hsslXAl2z6HbWwM7jvJmy/2/qKpXvE+rS3crNB5xFyXPtXGQlXzdp1qKrsQGUDxexk3J5B1R/dw0ZZV5VIPmvDv1W/pTQWr4qwJnLD0KnmCqZfvf2YEdedYsHwbrrTwLSe2zxH7tZMMPeacTkE0w/Wx/D5FO73+K1TnElSCaLQj12dpobG5DEFcVg/sG8NHM2+Xml0lD0GoL0Mgv5osy/tcqR2aPIATUuQtwDNtBZTPktgM0FWMixMzz4w/qwqDKdWY4nY70fvY9ln5lesH8l+b3hAoupz0DHTDW7J8VRa6LsWR8b6WKgkkYqb0+O3Q/4FxZ3nk82bCFH
x-ms-exchange-antispam-messagedata: ZI2TgfKw3bHMKg3Fbl8naL6X1VdxP6GQWFzG8lvXbx9ZTY6u7aK9IN8Q8nvAjvDEorEI8/AenpDzUVA5G38R6vARcT8ySglK/LOeb2z2//5ZV8MTZ/VJY7e3K5h3qY4T1jTLahgEojMG91B9H0+6Bg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739b0ecd-ddae-46ce-db24-08d7b9fa1e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 13:53:39.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yb3LO5H5Quoili6h5CCV6vV05SDrwnl4LH53WvIIzdRau4YRBsH/89UO/HbwwyH0krhs5y+T7xjAGccATziNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6975
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>=20
> On Fri, Dec 20, 2019 at 05:11:11PM +0530, Bharat Kumar Gogada wrote:
> > Adding device tree binding documentation for versal CPM Root Port drive=
r.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  .../devicetree/bindings/pci/xilinx-versal-cpm.txt  | 66
> > ++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> > b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> > new file mode 100644
> > index 0000000..35f8556
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.txt
> > @@ -0,0 +1,66 @@
> > +* Xilinx Versal CPM DMA Root Port Bridge DT description
> > +
> > +Required properties:
> > +- #address-cells: Address representation for root ports, set to <3>
> > +- #size-cells: Size representation for root ports, set to <2>
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +	interrupt source. The value must be 1.
> > +- compatible: Should contain "xlnx,versal-cpm-host-1.00"
> > +- reg: Should contain configuration space (includes bridge registers) =
and
> > +	CPM system level control and status registers, and length
> > +- reg-names: Must include the following entries:
> > +	"cfg": configuration space region and bridge registers
> > +	"cpm_slcr": CPM system level control and status registers
> > +- interrupts: Should contain AXI PCIe interrupt
> > +- interrupt-map-mask,
> > +  interrupt-map: standard PCI properties to define the mapping of the
> > +	PCI interface to interrupt numbers.
> > +- ranges: ranges for the PCI memory regions (I/O space region is not
> > +	supported by hardware)
> > +	Please refer to the standard PCI bus binding document for a more
> > +	detailed explanation
> > +- msi-map: Maps a Requester ID to an MSI controller and associated MSI
> > +	sideband data
> > +- interrupt-names: Must include the following entries:
> > +	"misc": interrupt asserted when legacy or error interrupt is
> > +received
> > +
> > +Interrupt controller child node
> > ++++++++++++++++++++++++++++++++
> > +Required properties:
> > +- interrupt-controller: identifies the node as an interrupt
> > +controller
> > +- #address-cells: specifies the number of cells needed to encode an
> > +	address. The value must be 0.
> > +- #interrupt-cells: specifies the number of cells needed to encode an
> > +	interrupt source. The value must be 1.
> > +
> > +
> > +Refer to the following binding document for more detailed description
> > +on the use of 'msi-map':
> > +	 Documentation/devicetree/bindings/pci/pci-msi.txt
> > +
> > +Example:
> > +	pci@fca10000 {
> > +		#address-cells =3D <3>;
> > +		#interrupt-cells =3D <1>;
> > +		#size-cells =3D <2>;
> > +		compatible =3D "xlnx,versal-cpm-host-1.00";
> > +		interrupt-map =3D <0 0 0 1 &pcie_intc_0 1>,
> > +				<0 0 0 2 &pcie_intc_0 2>,
> > +				<0 0 0 3 &pcie_intc_0 3>,
> > +				<0 0 0 4 &pcie_intc_0 4>;
>=20
> This is wrong, interrupts map to pin 0,1,2,3 of pcie_intc.
>=20
> That's what's forcing you to use the pci_irqd_intx_xlate() function and t=
hat's
> completely wrong.
>=20
> I should find a way to write a common binding for all the host bridges in=
terrupt-
> map since this comes up over and over again.
>=20
> Please have a look at:
>=20
> Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
Thanks Lorenzo, will fix this in next patch.
>=20
>=20
> > +		interrupt-map-mask =3D <0 0 0 7>;
> > +		interrupt-parent =3D <&gic>;
> > +		interrupt-names =3D "misc";
> > +		interrupts =3D <0 72 4>;
> > +		ranges =3D <0x02000000 0x00000000 0xE0000000 0x0
> 0xE0000000 0x00000000 0x10000000>,
> > +			 <0x43000000 0x00000080 0x00000000 0x00000080
> 0x00000000 0x00000000 0x80000000>;
> > +		msi-map =3D <0x0 &its_gic 0x0 0x10000>;
> > +		reg =3D <0x6 0x00000000 0x0 0x1000000>,
> > +		      <0x0 0xFCA10000 0x0 0x1000>;
> > +		reg-names =3D "cfg", "cpm_slcr";
> > +		pcie_intc_0: pci-interrupt-controller {
> > +			#address-cells =3D <0>;
> > +			#interrupt-cells =3D <1>;
> > +			interrupt-controller ;
> > +		};
> > +	};
> > --
> > 2.7.4
> >
