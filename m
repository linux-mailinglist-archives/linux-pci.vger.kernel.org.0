Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF31977EF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Mar 2020 11:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgC3Jht (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Mar 2020 05:37:49 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:18734
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727714AbgC3Jhs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Mar 2020 05:37:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tucrpqa7j6sIM2i7mzQHGJbYEBNugYxoPbW+7qiyIKKAIIFPWfISiqrVNAkMHofX8BXt6QN/NAtKCRgNzPOqAsOvYkmu3Pc/3zsR14UkNE2Sh+5I1OzWqVy2dIyaduXsq2Yfw1rVYfUuaOFz0dkMwMwuJzhKgtwbEZEM1b6PFSJFLutG2iRFPj5xPpTwbd0piWrtu592pS/GBUzG1X56v3YonUOYrfZ5vU013Z2vOw+6N0LrtRWeRjVAKzNADWBoTPYtb1PZaewvzQN+zdPu/QSyXuMAECsUZrKoHXdUGmyhxhTUKufo8WqZlRu2FCGoB2jvZxzRUnVtK5i80cNYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEh+/9VG1M4fv3WVs0zaCmiNeBDywC5hVysuQWuuJhY=;
 b=nFu/nowHQoFRCZUU2YfoFsZFWf6KJzCilFXXTyxXCzlbNh2SsybkVySIz/+1pqM7VonXQjU5kZF+wiMn6b8NT4nE2uHAHEDUD1HL+c9Ijh3s7fh7OAg6SQyA3bFZIuJNkeoFXApQdcjo42Sc8GdhgVjHAPnBMOkGSBRFozoCh4LOWHskw3zE7EafhJz6syDWiQVacx0J4htNJoF6BSkeEW8GrJsL0fvxUdXDOQcItK8mMf1OFC7f6j/4G3FSCh7b5fkJRIv+HVAquP5cNjDxIo59BTY61GskOmJzQcFCFOPDesdAwUHIcIECyOYG5ye3aZN2nYdIa0Rgf8u4kbqx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEh+/9VG1M4fv3WVs0zaCmiNeBDywC5hVysuQWuuJhY=;
 b=SSFg7jtAgJ2Pr85Q6E/tWoPOsRSMuEYxyOO9ZMScNInBuMcJsNXPOUj/DowrMYjXXoGuU9PivjS7AWLNNWRG0wcCeiNUokD5eg9nExl7Dx6bPnMy1OXfS1HJZJ+3Hy6Z/Le+yhjzmUsJRCzN4cyKbFLwgZD/ScrIAsWxwq4gy6Y=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB5045.namprd02.prod.outlook.com (2603:10b6:a03:6f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Mon, 30 Mar
 2020 09:37:42 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::45a0:6b24:a9ce:1a63]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::45a0:6b24:a9ce:1a63%4]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 09:37:42 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kgr8Z6AgAAlV5CABIIlAIAaXfLggBZHSCA=
Date:   Mon, 30 Mar 2020 09:37:42 +0000
Message-ID: <BYAPR02MB5559D6EBD0393D820276B883A5CB0@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
 <MN2PR02MB633672DD246A5351DA2D0CEAA5F90@MN2PR02MB6336.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB633672DD246A5351DA2D0CEAA5F90@MN2PR02MB6336.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: adeb3adf-fa9c-4cba-f946-08d7d48dfecb
x-ms-traffictypediagnostic: BYAPR02MB5045:|BYAPR02MB5045:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB504569029EEA0ED169074773A5CB0@BYAPR02MB5045.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0358535363
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(110136005)(76116006)(8936002)(6506007)(54906003)(66476007)(66946007)(66446008)(316002)(7696005)(64756008)(66556008)(4326008)(478600001)(86362001)(81166006)(8676002)(5660300002)(2906002)(9686003)(186003)(107886003)(33656002)(55016002)(52536014)(26005)(71200400001)(81156014);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BVqCzvDqxqs+CVt/10vifvDwysaNhmpqXl/zmWog58jwdx7PVTQS8h6Uz8jbaqb/Lr2lnuCq/9xRJGGnpARFXQsWDvIfG/jjJHq7DeOAoGvWZ+bPgtKU1iBjNilX/xhrNwLXADFXRqfWW7mk3qn94bijVpK3++8wBNptr3QithDb0J20HlJL8YSo+y2eYEjccSQSWcnCQ7khvyu9qd/2Wj1E/oMVlZe0iSmfChnZqRxvWbtNfD3o6JyMXIg/Q6j/mKk/pT0qPicIGjVK/CRaABYxehXT6viJ06GFa8HcAeJdyp9ePPB1IDpV/udr3BYN8RcETdFEu/nlyK+sHgVj8lIqhhxAPe++6iANcymNfssU3Wv4w7aEy6hEHeIzsMUAbyT4mIO50+vw3Nan4mG+afif8B4egnOyqdibbLxyhlG47b0DOGSF8tCFRHn3yTpU
x-ms-exchange-antispam-messagedata: LxrTKiL+Sy/Abfx/ZIAfzOJjIi9p2xWFZdcrRSFLucrCqEptUm1czZOQ4ri1jY46j0hei0VavF1SjCWHUGygsZhNd6MdTWgYK1hq9rN19OlwvhYSPjOKocuwrR8yQjS1s2aX1sqPe98ixtaVmdrbhg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adeb3adf-fa9c-4cba-f946-08d7d48dfecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2020 09:37:42.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytrt4Xu+VG3vkSoXbx5VZQ5YZsPOIwzS0LiEfJIepCfgfiU9SfBFJue+Pl9ohLVJ90zOq4KyUMVKUyp8s3ZhZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5045
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port
> > driver
> >
> > [+MarcZ, FHI]
> >
> > On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:
> >
> > [...]
> >
> > > > > +/* ECAM definitions */
> > > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > > +#define ECAM_DEV_NUM_SHIFT		12
> > > >
> > > > You don't need these ECAM_* defines, you can use pci_generic_ecam_o=
ps.
> > > Does this need separate ranges region for ECAM space ?
> > > We have ECAM and controller space in same region.
> >
> > You can create an ECAM window with pci_ecam_create where *cfgres
> > represent the ECAM area, I don't get what you mean by "same region".
> >
> > Do you mean "contiguous" ? Or something else ?
> >
> > > > > +
> > > > > +/**
> > > > > + * struct xilinx_cpm_pcie_port - PCIe port information
> > > > > + * @reg_base: Bridge Register Base
> > > > > + * @cpm_base: CPM System Level Control and Status
> > > > > +Register(SLCR) Base
> > > > > + * @irq: Interrupt number
> > > > > + * @root_busno: Root Bus number
> > > > > + * @dev: Device pointer
> > > > > + * @leg_domain: Legacy IRQ domain pointer
> > > > > + * @irq_misc: Legacy and error interrupt number  */ struct
> > > > > +xilinx_cpm_pcie_port {
> > > > > +	void __iomem *reg_base;
> > > > > +	void __iomem *cpm_base;
> > > > > +	u32 irq;
> > > > > +	u8 root_busno;
> > > > > +	struct device *dev;
> > > > > +	struct irq_domain *leg_domain;
> > > > > +	int irq_misc;
> > > > > +};
> > > > > +
> > > > > +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port,
> > > > > +u32
> > > > > +reg) {
> > > > > +	return readl(port->reg_base + reg); }
> > > > > +
> > > > > +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> > > > > +			      u32 val, u32 reg)
> > > > > +{
> > > > > +	writel(val, port->reg_base + reg); }
> > > > > +
> > > > > +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port
> > > > > +*port) {
> > > > > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > > > > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> > > >
> > > > 	u32 val =3D pcie_read(port, XILINX_CPM_PCIE_REG_PSCR);
> > > >
> > > > 	return val & XILINX_CPM_PCIE_REG_PSCR_LNKUP;
> > > >
> > > > And this function call is not that informative anyway - it is used
> > > > just to print a log whose usefulness is questionable.
> > > We need this logging information customers are using this info in
> > > case of link down failure.
> >
> > Out of curiosity, to do what ?
> >
> > [...]
> >
> > > > > +/**
> > > > > + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and
> > > > > +mark IRQ as valid
> > > > > + * @domain: IRQ domain
> > > > > + * @irq: Virtual IRQ number
> > > > > + * @hwirq: HW interrupt number
> > > > > + *
> > > > > + * Return: Always returns 0.
> > > > > + */
> > > > > +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> > > > > +				    unsigned int irq, irq_hw_number_t
> hwirq) {
> > > > > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > > > > +handle_simple_irq);
> > > >
> > > > INTX are level IRQs, the flow handler must be handle_level_irq.
> > > Accepted will change.
> > > >
> > > > > +	irq_set_chip_data(irq, domain->host_data);
> > > > > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > > >
> > > > The way INTX are handled in this patch is wrong. You must set-up a
> > > > chained IRQ with the appropriate flow handler, current code uses
> > > > an IRQ action and that's an IRQ layer violation and it goes
> > > > without saying that it
> > is almost certainly broken.
> > > In our controller we use same irq line for controller errors and
> > > legacy errors.  we have two cases here where error interrupts are
> > > self-consumed by controller, and legacy interrupts are flow handled.
> > > Its not INTX handling alone for this IRQ line .  So chained IRQ can
> > > be used for self consumed interrupts too ?
> >
> > No. In this specific case both solutions are not satisfying, we need
> > to give it some thought, I will talk to Marc (CC'ed) to find the best
> > option here going forward.
> >
> Hi Marc,
>=20
> Can you please provide yours inputs for this case.
>=20
Hi Marc,

Can you please provide required inputs on this.

Regards,
Bharat
