Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28C186466
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 06:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgCPFYs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 01:24:48 -0400
Received: from mail-dm6nam12on2086.outbound.protection.outlook.com ([40.107.243.86]:8053
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgCPFYs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 01:24:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9K/ByjRupICp3WgUTck7TMiZJ6lk7QfpfbLICZ4g0Eqo30bCHrhuIwYN8CmvGqo1qy/taXP6epr1FEiHezlV8RMun6FFaaY8V7TiCY2yfR+48zYln8hwECN5hpL3y1xD7vTgQApf++uvH2puG2Yc2sNtt0wFZBKTtflNzDPdKc5AEsM6cqiv3qaNcAOcxJrOTyQ+9/KncqBP8tvF8kxVtSf2PaCSLQYg03Kgn3Gp/Mg0v/1uOM6bESfb5c0HfBGNDSiLZNG5mjpkhF1SCdlFx7o9Opj6SD6+67IkXRRpPYd831hTDOG4RujPlYdRSalvQVlFQtv2SIrP+Pa4o9uOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI6rKPESsqzO6vxXO1x90pvDeevKtrfjpaCwNfHEZI4=;
 b=iCDSlfbaixFiQ1c3OjV/Coxe0lVHsSDqW8HpWb9A2x7XfwXMjg7WzWFk5FtCf7elKJThe9d1FPMA4wR7FKRlr9vLYgHun2MWgl/i9y2DK55LYr22PsZygomJ51tmHT3jWZN1DQPzAN2P3gcf+wPSB2jn4FwB1O5BUxYAfl7BfW5qn7/9sGFwm3rXx+gMFBuEjAKNu1Y2XnDU+wZHja4YpTI2qM25oiJJmpybTObsAmGuOM4Fklz60XUJ2vHklp88HJqYxCK5QgNL1+8uBd0LdnirC+L0pehDFWFiozfmaPr658GPv5sJrkXzkhSO5EDozP6WGs44Wt3xgx38IJ0Zcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI6rKPESsqzO6vxXO1x90pvDeevKtrfjpaCwNfHEZI4=;
 b=LRwuu0wiAcpsi2B7+O+TDNz5kEwBcq5oXvFS0vxef16HN8uWhlLFNBUD6b7NNDP3hwcmPhlFdEbwy5sZdYcPI05pgbdOL4c/aoGoYmES+FlwzSvrtreU/Bwg4M74NU+I+uGEzeb1zdRmUbhXGyDpgi3X8cwwLy4TYuk7exuWUYM=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (2603:10b6:208:1b8::30)
 by MN2PR02MB7086.namprd02.prod.outlook.com (2603:10b6:208:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 05:24:41 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::b51f:8bc4:7e18:f227]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::b51f:8bc4:7e18:f227%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 05:24:40 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kgr8Z6AgAAlV5CABIIlAIAaXfLg
Date:   Mon, 16 Mar 2020 05:24:40 +0000
Message-ID: <MN2PR02MB633672DD246A5351DA2D0CEAA5F90@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
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
x-ms-office365-filtering-correlation-id: 56e5d6cd-8a68-4d32-26c4-08d7c96a53fd
x-ms-traffictypediagnostic: MN2PR02MB7086:|MN2PR02MB7086:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB708676170A7E92D5B072DDC8A5F90@MN2PR02MB7086.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(346002)(366004)(376002)(136003)(199004)(8676002)(4326008)(86362001)(81156014)(81166006)(6916009)(54906003)(7696005)(9686003)(8936002)(55016002)(5660300002)(52536014)(478600001)(66556008)(186003)(64756008)(66446008)(2906002)(6506007)(26005)(76116006)(66946007)(71200400001)(33656002)(66476007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7086;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ye2SazfC8pjJR7NrO9TIA/PjDTAdq1qjQTbV7xkbEJw5U8Fb8I1c3EvYJBYnqCtuzirlk9aDiDmvZ4yHpqguezh3ILixxLc//mRUQqMys8/XvNsBD2wgCNdHD7EA/8q4ZXYhOyWTllVcZRFnjPhNM65wgC8Mv4u/tExz2AFxvgRuBKsW5irf98SEmFCLgDEufQfPEt1LjrE/30ogwFZ947ht3Kq1o9VVA9j0+K418nYM1YhWJuu2vQntVk9N8LZyBAezwnhrW90fKqh+v+0i3OmdocXPprwIdVenVdjf5ovDfhXEOkokEfGFjxe06c9shHf/bjCQTh9EG1pL0IjCaS/5V1sg+0wtGEX3mwKsZx2+l4drjW5kjXldeGmFhIAXH2J1ga/cUkzJ7q4dVimtIQgRqF4b77RHl3dFd64KkZF3CZ4a02BM83x7QWhHBwiM
x-ms-exchange-antispam-messagedata: dS9fM+1HZyYLI3B2WY7GW8wFPR2EZys3e5Ud9P8N3Wl7ezX7y3YROt+wjtJ3GNelDK7kD51Gsa1tSZzXrsP+WfduYiGL++XuNKABk2EvQf5h6oTitEJeluFCZn1thBKA/ippvqj5JmVj5OjkVymjlQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e5d6cd-8a68-4d32-26c4-08d7c96a53fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 05:24:40.7521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JhPxUg7QCMOOhXROkYgEZ4hu41jKHao70aJWNe/4NxZWoLPVUUav4CVX80O0u386Cjd00rEX0dLoPXss2uR96A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7086
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> [+MarcZ, FHI]
>=20
> On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:
>=20
> [...]
>=20
> > > > +/* ECAM definitions */
> > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > +#define ECAM_DEV_NUM_SHIFT		12
> > >
> > > You don't need these ECAM_* defines, you can use pci_generic_ecam_ops=
.
> > Does this need separate ranges region for ECAM space ?
> > We have ECAM and controller space in same region.
>=20
> You can create an ECAM window with pci_ecam_create where *cfgres
> represent the ECAM area, I don't get what you mean by "same region".
>=20
> Do you mean "contiguous" ? Or something else ?
>=20
> > > > +
> > > > +/**
> > > > + * struct xilinx_cpm_pcie_port - PCIe port information
> > > > + * @reg_base: Bridge Register Base
> > > > + * @cpm_base: CPM System Level Control and Status Register(SLCR)
> > > > +Base
> > > > + * @irq: Interrupt number
> > > > + * @root_busno: Root Bus number
> > > > + * @dev: Device pointer
> > > > + * @leg_domain: Legacy IRQ domain pointer
> > > > + * @irq_misc: Legacy and error interrupt number  */ struct
> > > > +xilinx_cpm_pcie_port {
> > > > +	void __iomem *reg_base;
> > > > +	void __iomem *cpm_base;
> > > > +	u32 irq;
> > > > +	u8 root_busno;
> > > > +	struct device *dev;
> > > > +	struct irq_domain *leg_domain;
> > > > +	int irq_misc;
> > > > +};
> > > > +
> > > > +static inline u32 pcie_read(struct xilinx_cpm_pcie_port *port,
> > > > +u32
> > > > +reg) {
> > > > +	return readl(port->reg_base + reg); }
> > > > +
> > > > +static inline void pcie_write(struct xilinx_cpm_pcie_port *port,
> > > > +			      u32 val, u32 reg)
> > > > +{
> > > > +	writel(val, port->reg_base + reg); }
> > > > +
> > > > +static inline bool cpm_pcie_link_up(struct xilinx_cpm_pcie_port
> > > > +*port) {
> > > > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > > > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> > >
> > > 	u32 val =3D pcie_read(port, XILINX_CPM_PCIE_REG_PSCR);
> > >
> > > 	return val & XILINX_CPM_PCIE_REG_PSCR_LNKUP;
> > >
> > > And this function call is not that informative anyway - it is used
> > > just to print a log whose usefulness is questionable.
> > We need this logging information customers are using this info in case
> > of link down failure.
>=20
> Out of curiosity, to do what ?
>=20
> [...]
>=20
> > > > +/**
> > > > + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx and
> > > > +mark IRQ as valid
> > > > + * @domain: IRQ domain
> > > > + * @irq: Virtual IRQ number
> > > > + * @hwirq: HW interrupt number
> > > > + *
> > > > + * Return: Always returns 0.
> > > > + */
> > > > +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> > > > +				    unsigned int irq, irq_hw_number_t hwirq) {
> > > > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > > > +handle_simple_irq);
> > >
> > > INTX are level IRQs, the flow handler must be handle_level_irq.
> > Accepted will change.
> > >
> > > > +	irq_set_chip_data(irq, domain->host_data);
> > > > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > >
> > > The way INTX are handled in this patch is wrong. You must set-up a
> > > chained IRQ with the appropriate flow handler, current code uses an
> > > IRQ action and that's an IRQ layer violation and it goes without sayi=
ng that it
> is almost certainly broken.
> > In our controller we use same irq line for controller errors and
> > legacy errors.  we have two cases here where error interrupts are
> > self-consumed by controller, and legacy interrupts are flow handled.
> > Its not INTX handling alone for this IRQ line .  So chained IRQ can be
> > used for self consumed interrupts too ?
>=20
> No. In this specific case both solutions are not satisfying, we need to g=
ive it
> some thought, I will talk to Marc (CC'ed) to find the best option here go=
ing
> forward.
>=20
Hi Marc,

Can you please provide yours inputs for this case.

Regards,
Bharat
