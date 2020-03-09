Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8A117DEAF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 12:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgCIL1X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 07:27:23 -0400
Received: from mail-eopbgr690067.outbound.protection.outlook.com ([40.107.69.67]:19919
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbgCIL1X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 07:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHZCQ8Rl1EHFI6OuFeyyjTONuixCSYVPI2sYyIwYUYdPNOl0UNYgmt6rSwwkibbt2S5up3DUffc/8gL2BfxLWgL0Ta/Loid6+xds98n98tWSouxHS2LyQqHPFZMRO6niwE7ZH0qepJH2WBkRfobGtNzq0RMKqGn7rdGA/lXF+jM8Vj2OZ9iQ6F9tEA8u3K/r2rs4n5V6oF+nP5xsIcCnPUgslsV2W8a4ewBmGpAzUi8QpZka7khzVqsLSGQDpgZ0JeAdMfS/XWI2V6RNM7jerFG1aT8IQM67mfMgV1RcrS270nOJhoyUSqQkbk3DEdT7rKrSbs0If77bG7ZB+GCZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n7Rs97IfLs3SKdWR14x4fOM5C25zPmTcFwlv79I8Wc=;
 b=e49RutTGyH9IV3xLvCR7SgfYkV185JyLjNTJznTevV16wfTlmCtGFvMasPyp0VfX/SD29tB7T9G8YtP047opu8B/B5LLBfh7i0+7w1HF7jl5W1gWDuNoX7ykwGafNqRoe+QiCXCbV+Qt1RA3d8S6naQbUNKcaLoCU2v0kp5ewVxL0FGa6DtGRXzCImWY2Wg3agh+NezNSAO4HuaUQCzrLppAj94e6BRV9EM9hnT+6VYmO1PMKb8uD0opr5pOKv6xuh7WKUzpPPC6ll2AmG2B9mFzEyIAv2SXLKvb+Mp7xYjpuZs8OOVmOy2lBLQJ2Wc8vsvmchsuRgLH+Yy1JVOUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3n7Rs97IfLs3SKdWR14x4fOM5C25zPmTcFwlv79I8Wc=;
 b=PS/dZXZjTrWUclVgmJn4f5ag2ugZr7oiGdfjVPViTjN3yFAlYtih5LM9zJ3YPHCBslc97/1csl1RggYOTXTE5pdzB7N4vQbXdF5o/YS24xjGvaLcASK8euZckORXtvnWD9YcmbQaMHX5kalFmg/odCZCwtIQ5Zr/FKwbn3zBZ+s=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (2603:10b6:208:1b8::30)
 by MN2PR02MB6704.namprd02.prod.outlook.com (2603:10b6:208:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Mon, 9 Mar
 2020 11:27:19 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::b51f:8bc4:7e18:f227]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::b51f:8bc4:7e18:f227%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 11:27:19 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kgr8Z6AgAAlV5CABIIlAIAAIZtQgArnjQCAAAJtIIAAP3cAgAR3LmA=
Date:   Mon, 9 Mar 2020 11:27:18 +0000
Message-ID: <MN2PR02MB6336BC1C755CC4F2F616C6CDA5FE0@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
 <MN2PR02MB6336569F378683B05B262D4AA5E80@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200306111620.GA10297@e121166-lin.cambridge.arm.com>
 <MN2PR02MB6336BBFDCB07F424C36742B0A5E30@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200306151210.GB10297@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200306151210.GB10297@e121166-lin.cambridge.arm.com>
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
x-ms-office365-filtering-correlation-id: b26ea53d-32c3-4486-89a2-08d7c41cd400
x-ms-traffictypediagnostic: MN2PR02MB6704:|MN2PR02MB6704:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB67046B10A35E3A996481BF4AA5FE0@MN2PR02MB6704.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0337AFFE9A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(86362001)(6506007)(7696005)(53546011)(9686003)(5660300002)(66946007)(76116006)(55016002)(66476007)(64756008)(66446008)(316002)(66556008)(478600001)(52536014)(8936002)(2906002)(8676002)(54906003)(81166006)(186003)(81156014)(26005)(33656002)(6916009)(4326008)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6704;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LDY9fSHvR9JXc8K3pvcZ7DtVJJE2H+c4wyL37Do2KnBNAITlVE8kUNQRm1CIPfjpfSuYgkKLqZhDw20uRXgEtDjXYb7q3//wUDA6YfJ4yMVU72EbHNIwu2X9+4ddRQ3pW2VmE6bPYMMm99fFHJeXM7l5AQwv8Bja2JuxY3xvOCsbXQPnbrEuSN/qDUqyiPhLGPXK4iRLp7MV+bfhRnGOnj8dpOf2Np5lB03OMVrVQsF9veWPkbRZrp5DXLhcZqByeHkwvXxPibzdCO2R+Mp639UWJxsLiL/3b+0NJqDbjK1BDSoMoQ1Y6vsdtWzpuydk0XgrhVxyb2EHwrCYg/gbUkSNKkpdTsfLAaGu/giRnaVPf+G7V/aKQswfBcLdb/nwAB+mVHVnS9+hHntXNeyqlOvHxJGZhnEmpWWBYYiQwSZ+sPMBN+WFE74cLbh3q7QU
x-ms-exchange-antispam-messagedata: Sl9ykdBXg4OsL3aD+JINbAAfLeEglFIST/o2v4fpnToq7FilwlH5GqE5obHE3NgpQIVkI1OgsIZC8uq7VXXzC6Aq8WxnY1CElmuFDMG+k969g2ZwNb+wJ6KQimTXom8U3yA/LRGA+Gi2Mjfn+ikFEg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26ea53d-32c3-4486-89a2-08d7c41cd400
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2020 11:27:19.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0JWr3CqX6qNGolteTGaAJqnUeG/YgGDaRjAJkiJTe+50xwIzkHiwFZUFnOukZqsBCigPE2wB6jmrNS5I+Tsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6704
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> On Fri, Mar 06, 2020 at 11:45:47AM +0000, Bharat Kumar Gogada wrote:
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: Friday, March 6, 2020 4:46 PM
> > > To: Bharat Kumar Gogada <bharatku@xilinx.com>
> > > Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > bhelgaas@google.com; Ravikiran Gummaluri <rgummal@xilinx.com>;
> > > maz@kernel.org
> > > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root
> > > Port driver
> > >
> > > On Fri, Feb 28, 2020 at 12:48:48PM +0000, Bharat Kumar Gogada wrote:
> > > > > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root
> > > > > Port driver
> > > > >
> > > > > [+MarcZ, FHI]
> > > > >
> > > > > On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada
> wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > > > +/* ECAM definitions */
> > > > > > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > > > > > +#define ECAM_DEV_NUM_SHIFT		12
> > > > > > >
> > > > > > > You don't need these ECAM_* defines, you can use
> > > pci_generic_ecam_ops.
> > > > > > Does this need separate ranges region for ECAM space ?
> > > > > > We have ECAM and controller space in same region.
> > > > >
> > > > > You can create an ECAM window with pci_ecam_create where *cfgres
> > > > > represent the ECAM area, I don't get what you mean by "same regio=
n".
> > > > >
> > > > > Do you mean "contiguous" ? Or something else ?
> > > > Yes, contiguous; within ECAM region some space is for controller re=
gisters.
> > >
> > > What does that mean ? I don't get it. Can you explain to me how this
> > > address space works please ?
> > >
> > Hi Lorenzo,
> > 		reg =3D <0x6 0x00000000 0x0 0x1000000>,
>=20
> This supports up to 16 busses (it is 16MB in size rather than full ECAM 2=
56MB),
> right ? Please make sure that the bus-range property reflects that.
>=20
> > 		      <0x0 0xFCA10000 0x0 0x1000>;
> > 		reg-names =3D "cfg", "cpm_slcr";
> >
> > In the above cfg region some region of it reserved for bridge
> > registers and rest for ECAM address space transactions. The bridge
> > registers are mapped at an unused offset in config space of root port, =
when
> the offset hit it will access controller register space.
> >
> > This region is already being mapped
> > res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > port->reg_base =3D devm_ioremap_resource(dev, res);
> >
> > Does pci_ecam_create will work along with above API simultaneously ?
>=20
> Basically the bridge registers are accessible through the PCI config acce=
ssors
> (after enumeration), since they are in the bridge device specific config =
space
> (device specific area).
>=20
> IIUC the answer is yes and you can access the bridge registers through PC=
I
> config space accessors (after enumeration).
>=20
Hi Lorenzo,

The bridge register access  are not using config space accessors, we have l=
ocal pcie_read/write
api for accessing bridge registers.
The hardware logic have details of offsets to which it will not send config=
 accesses it will do local
AXI read and write accesses when the bridge registers are accessed.

Regards,
Bharat

