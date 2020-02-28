Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07A16173789
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 13:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgB1Msz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 07:48:55 -0500
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:6048
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbgB1Msz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Feb 2020 07:48:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDBp6NY9US5w3ZSDdqP3jKBU8B6UwAEP0cGfNkW+nTGGl2N3gH/gCbJO1b8JYns/th4NDHxsfUvgbdQrFjaBwpDW1cx+pZLA2AbKcHgfDMfMAEfUw5YimpCP1hCFruXDAxcfmiSMKwrx7EGlGWixqKAMeJF3Mvera2o02IRWayfdNFU4VaWVMYOg7AuYuqLPQOTbBNpNqlLdhT+dSAqqzU+aDlmoglSd9+lp8PaL8XMFKbyMWXNkkaI+im2WD+X8HKO/lxU5oXR7xncvJTRv7q3H/CZXOAuEGpSZ9dhzLh+9RpkdLeouIzxIUNv8XQN4sna6T4NOc5cpEIAgXjXvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeVnHWRIJpqsTSPxuPZoK8E4R4fhwl/QTvxPcTOH1QI=;
 b=oN7pTvWqPC4utc3Xcef6rW5Mpk5sOxgfOAqbxggFjjZdES+TKuYSefd6HD3NfbTwD2uVCNx3GONjP7DqqUzOFDHjXiTgN6iLmZI1LCtEiztZodGuLsoZX4Az700pShdHVT5j1wZRAB9jAcWRN51LhadrXBXHjtV1775K6ElQM6SJPt6LNZVAqw8hZoeFosEWIGBnuK5REgRsQo6ZzY13rqDdKcm6I3U3Unadi0hQlnOv096he63nDHKl3cgU8uBI4J2cwx3UDHzQY+WB1Cqz0YEFc+w8i5udFj+O1fWE0Pcc+venDvGhUpDLHe+V81LYPvwfdzWtYV/vM8xFfFX0+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeVnHWRIJpqsTSPxuPZoK8E4R4fhwl/QTvxPcTOH1QI=;
 b=Iko0zZMw9WSETZTzLzT8voY8IDMAqLxorYnJlkOeLvF1UxpHrhDWE7rtXt+7pltgCHrnuNIEtg4nnKPMX+xAbbKLXc0A1UTtIonBXY+rS7DTJY6YbvKujr8FYBrt/x5J+SYhoQiRdFxFWWZZXMBG5qL0vijXIExEx0+gvGqZ17I=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (2603:10b6:208:1b8::30)
 by MN2PR02MB6686.namprd02.prod.outlook.com (2603:10b6:208:1d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Fri, 28 Feb
 2020 12:48:49 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f452:65fb:14c7:dd6b]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::f452:65fb:14c7:dd6b%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 12:48:49 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>,
        "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kgr8Z6AgAAlV5CABIIlAIAAIZtQ
Date:   Fri, 28 Feb 2020 12:48:48 +0000
Message-ID: <MN2PR02MB6336569F378683B05B262D4AA5E80@MN2PR02MB6336.namprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: bdabd4a8-da17-4866-860b-08d7bc4c8e95
x-ms-traffictypediagnostic: MN2PR02MB6686:|MN2PR02MB6686:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB6686A6B67ABBCEB72C86C13BA5E80@MN2PR02MB6686.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(478600001)(316002)(26005)(5660300002)(6506007)(64756008)(66476007)(66556008)(186003)(66446008)(54906003)(52536014)(7696005)(86362001)(76116006)(66946007)(81156014)(4326008)(8936002)(9686003)(2906002)(8676002)(55016002)(6916009)(33656002)(71200400001)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB6686;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pETMEZGT5F4qugC4wTEl0icgEyfS9an3R4a42NnbfvByu9lXPyzMZiSvdWtaDJiYCXFLuNQydWoU2Okhxcz7J5lsyOjTaNoVqBQbN+iUjyLzqQv78ZiS/0RMFeKlJ3hV5B1dR4uH5DOBc9A6BgivHnzJ38qmELYq5MYFwlxgc63RA2lIkWkQ+/n9bKOK2OhGZu5DithR1bPp95F5ME2fzj9aoqv8NOaDEndLcjfk7p08DfikMcyz7NpcxK46IfsU2RYCx6fFANcZ2sCRcF6zBuQn4Z0DeU735zsyktdIbXpaWMWz03ax/eVOj2raFm3VCHLZbxhGBqcN0bE6FiW4UFbBFrHWQcvbxWVSVLdGoNGYpED6AwXopAskFgVN+0msJMEiriQc6HeLDtXsL/9Fq+VVbpRRv8Kcs0XlT7e1ED0qAhz9cmH4+HELs+OlQieH
x-ms-exchange-antispam-messagedata: 8pK0sYdMjb9g8IzHdTrOwh7ePJNRgkF7VyQOqkdiMHE9+CuFw3UyLZWPn6tU4prtnlbL8o3Zzgz5v/EnZq6u8+MgKj9BPAUyu3OJqWSOLlTFddMdi06Iuq4fuT9rG+fAlN4S5hS58AexJwnNdLdlcw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdabd4a8-da17-4866-860b-08d7bc4c8e95
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 12:48:49.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nbOD6oead0RAqSJWKDSRQFIVOPNvAX98qdogBDrCqWa/WR0Op/y15y8B6CNGsJGo7S6Z45VDnT0plX6bRMsYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6686
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
Yes, contiguous; within ECAM region some space is for controller registers.
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
They use this information as first level debug and initiate a query to xili=
nx support team.=20
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
Ok, will wait for Marc to provide inputs.

Regards,
Bharat
