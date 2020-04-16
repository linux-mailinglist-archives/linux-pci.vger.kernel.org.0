Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B981AB95D
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437802AbgDPHHf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 03:07:35 -0400
Received: from mail-eopbgr690085.outbound.protection.outlook.com ([40.107.69.85]:36738
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437060AbgDPHHb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Apr 2020 03:07:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAvnOSPSYufAjmWaDG4gAY3jPqiBYqWCTbJ+UfXQbNLfONC70D8XbJvcMCDvT7nP5uczodQiSm3HNmQXdch6U2+S6eCurBq9t7EPaN648+oNpJeRnYdAblpPpd6UCX+wGfZJskiW7pdn/jCYWgOUfj7OvRxJMq8PmEimiXr32WKbyl65JOGn6ug1x9uK11sguVKDL+ipCUiXqUciRnJp0OoBrgVv8J+HG3wg9CUT+YnggoKm7UYWYLggxoLWiEzF3juGox8/9gn0abjH1zZ8AcScwzgpJqxUM5aXf92ls4OKVmE0/x4PX3W+jyyBn8txxm4gw8krllmu1gDoi2w/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUo0ZYDq98bbd+iohMd3wjR06hNlEcEX0ldPjYCFilI=;
 b=ZzCpYkyWzUwboPucdN6QbYjd+WEfKmOo38kumG6RUz7Fjnz3saBtAJUne+FPQTa0ndQAyvm+2qvRx5Rimn0/IJg3wDsjzHHHjqF8+IBUhCpfGVCaXfpoCur7AhYDA8bXajRL/SzAXVjm1tLp4ekhcuq0FkBfzDHoeqlOWumMzsvooJn1aydjhDy0D37SNaoHBj5GPmkLIFr6To2pOUw5SZzxE+wkRqxQd81yHeiuUmHSaR/8Et11S7zUN4yAn3KPGlxvNmY/Niq2NeS4/SG3cNPKAWZO6yRt51k7Dnp1CxyZVXEa2sDCy2XPPv3rNdFj0iqyAczsVF6qoZr3nnXw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUo0ZYDq98bbd+iohMd3wjR06hNlEcEX0ldPjYCFilI=;
 b=dakHpQs7lLqBcXvPznEDwW8hwL9rctrzNzyJgbF+YJN3ctEGsJ+/j5Qj9f8JRrxN2hT9ARZ/K39ZwI4Br/tK57Qi2o7a3WKKfxvbbqtVmT8u39jgC+r16ZpiBfUMNlvLN5Phi0VONRdq3W/e+MH4QokV9YVtxlOGT1voPEUKGX4=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4680.namprd02.prod.outlook.com (2603:10b6:a03:50::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Thu, 16 Apr
 2020 07:07:29 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::a1bc:4672:d6ab:d98b]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::a1bc:4672:d6ab:d98b%6]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 07:07:28 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Topic: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Thread-Index: AQHV14gyqXPkldKNt0SLTelX37u03Kgr8Z6AgAAlV5CABIIlAIAaXfLggBZHSCCAGo2JUA==
Date:   Thu, 16 Apr 2020 07:07:28 +0000
Message-ID: <BYAPR02MB5559496A131BB88E98D9C3C3A5D80@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <1580400771-12382-1-git-send-email-bharat.kumar.gogada@xilinx.com>
 <1580400771-12382-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200225114013.GB6913@e121166-lin.cambridge.arm.com>
 <MN2PR02MB63365B50058B35AA37341BC9A5ED0@MN2PR02MB6336.namprd02.prod.outlook.com>
 <20200228104442.GA2874@e121166-lin.cambridge.arm.com>
 <MN2PR02MB633672DD246A5351DA2D0CEAA5F90@MN2PR02MB6336.namprd02.prod.outlook.com>
 <BYAPR02MB5559D6EBD0393D820276B883A5CB0@BYAPR02MB5559.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB5559D6EBD0393D820276B883A5CB0@BYAPR02MB5559.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2900b86f-0abd-4130-ac08-08d7e1d4d325
x-ms-traffictypediagnostic: BYAPR02MB4680:|BYAPR02MB4680:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4680578E8182D962ADF3636FA5D80@BYAPR02MB4680.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(9686003)(55016002)(66446008)(8936002)(66556008)(26005)(66946007)(66476007)(5660300002)(186003)(81156014)(76116006)(110136005)(33656002)(64756008)(7696005)(478600001)(316002)(86362001)(52536014)(71200400001)(8676002)(4326008)(6506007)(107886003)(54906003)(2906002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjfTfAa+JftwLatmkC8i15EmAPiO6tYdykfTx5bhMbwZUhahdOCt7LKyxLvMaOSAQn7sLER6Xpvm6Ml31gvyLZix7/COsjJ+/2Du19pxB2eLqMvJujjd0wConSkUXkPOvQsvm8VuLNaVHJc8KgyWksjPxnSsJjid75kA2TavR6KvZG9eQ1ejYe/yinMbSH7ZkcYxpRFmqQsxl+GlTDIZ8aPCMKxJCw8fntXXkRX9vSKtq+TSvymzo6ZV9Z3qYg8sbvh1vgoGK83YW+0OUQWhd1P0JPiiZ5Yzu/s+mfklJ7Of0pMjQ03Ls0bIgm3fBEm5i+MT6mJWJG3cZedK/nWktlVf4qVLI7oBWD5I/+HKM1wHZnn5go/rt9hqge2OCvCznnyoBUeQjHB0r63nVvl6HmcbtRxtgv+EfNF+laFTkECt0sJR1QR4rabsdSkVzV64
x-ms-exchange-antispam-messagedata: 5d1qLQ88xUMClPCWVVLXEnPH696g4PpYNneKePARt8w8kUtkqXhvqSDa+UxNJ2sDSX3WgsPQXgqa6QeswCeKDF6Bhf1Fd3fme80QC+jav4IsKrsqHEjTh7nDobVoyb6CRkCYS+I1qXtGNdk718xkKw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2900b86f-0abd-4130-ac08-08d7e1d4d325
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 07:07:28.5943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TeY3tKHm0+ZswQXM03qb/K/LEra7a4rXbq63Hdl68euOo6kGJZHtG02gbgZMSeUC8DT24BkfiVNNUHloZN9xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4680
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port dri=
ver
>=20
> > Subject: RE: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port
> > driver
> >
> > > Subject: Re: [PATCH v5 2/2] PCI: xilinx-cpm: Add Versal CPM Root
> > > Port driver
> > >
> > > [+MarcZ, FHI]
> > >
> > > On Tue, Feb 25, 2020 at 02:39:56PM +0000, Bharat Kumar Gogada wrote:
> > >
> > > [...]
> > >
> > > > > > +/* ECAM definitions */
> > > > > > +#define ECAM_BUS_NUM_SHIFT		20
> > > > > > +#define ECAM_DEV_NUM_SHIFT		12
> > > > >
> > > > > You don't need these ECAM_* defines, you can use
> pci_generic_ecam_ops.
> > > > Does this need separate ranges region for ECAM space ?
> > > > We have ECAM and controller space in same region.
> > >
> > > You can create an ECAM window with pci_ecam_create where *cfgres
> > > represent the ECAM area, I don't get what you mean by "same region".
> > >
> > > Do you mean "contiguous" ? Or something else ?
> > >
> > > > > > +
> > > > > > +/**
> > > > > > + * struct xilinx_cpm_pcie_port - PCIe port information
> > > > > > + * @reg_base: Bridge Register Base
> > > > > > + * @cpm_base: CPM System Level Control and Status
> > > > > > +Register(SLCR) Base
> > > > > > + * @irq: Interrupt number
> > > > > > + * @root_busno: Root Bus number
> > > > > > + * @dev: Device pointer
> > > > > > + * @leg_domain: Legacy IRQ domain pointer
> > > > > > + * @irq_misc: Legacy and error interrupt number  */ struct
> > > > > > +xilinx_cpm_pcie_port {
> > > > > > +	void __iomem *reg_base;
> > > > > > +	void __iomem *cpm_base;
> > > > > > +	u32 irq;
> > > > > > +	u8 root_busno;
> > > > > > +	struct device *dev;
> > > > > > +	struct irq_domain *leg_domain;
> > > > > > +	int irq_misc;
> > > > > > +};
> > > > > > +
> > > > > > +static inline u32 pcie_read(struct xilinx_cpm_pcie_port
> > > > > > +*port,
> > > > > > +u32
> > > > > > +reg) {
> > > > > > +	return readl(port->reg_base + reg); }
> > > > > > +
> > > > > > +static inline void pcie_write(struct xilinx_cpm_pcie_port *por=
t,
> > > > > > +			      u32 val, u32 reg)
> > > > > > +{
> > > > > > +	writel(val, port->reg_base + reg); }
> > > > > > +
> > > > > > +static inline bool cpm_pcie_link_up(struct
> > > > > > +xilinx_cpm_pcie_port
> > > > > > +*port) {
> > > > > > +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> > > > > > +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> > > > >
> > > > > 	u32 val =3D pcie_read(port, XILINX_CPM_PCIE_REG_PSCR);
> > > > >
> > > > > 	return val & XILINX_CPM_PCIE_REG_PSCR_LNKUP;
> > > > >
> > > > > And this function call is not that informative anyway - it is
> > > > > used just to print a log whose usefulness is questionable.
> > > > We need this logging information customers are using this info in
> > > > case of link down failure.
> > >
> > > Out of curiosity, to do what ?
> > >
> > > [...]
> > >
> > > > > > +/**
> > > > > > + * xilinx_cpm_pcie_intx_map - Set the handler for the INTx
> > > > > > +and mark IRQ as valid
> > > > > > + * @domain: IRQ domain
> > > > > > + * @irq: Virtual IRQ number
> > > > > > + * @hwirq: HW interrupt number
> > > > > > + *
> > > > > > + * Return: Always returns 0.
> > > > > > + */
> > > > > > +static int xilinx_cpm_pcie_intx_map(struct irq_domain *domain,
> > > > > > +				    unsigned int irq, irq_hw_number_t
> > hwirq) {
> > > > > > +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> > > > > > +handle_simple_irq);
> > > > >
> > > > > INTX are level IRQs, the flow handler must be handle_level_irq.
> > > > Accepted will change.
> > > > >
> > > > > > +	irq_set_chip_data(irq, domain->host_data);
> > > > > > +	irq_set_status_flags(irq, IRQ_LEVEL);
> > > > >
> > > > > The way INTX are handled in this patch is wrong. You must set-up
> > > > > a chained IRQ with the appropriate flow handler, current code
> > > > > uses an IRQ action and that's an IRQ layer violation and it goes
> > > > > without saying that it
> > > is almost certainly broken.
> > > > In our controller we use same irq line for controller errors and
> > > > legacy errors.  we have two cases here where error interrupts are
> > > > self-consumed by controller, and legacy interrupts are flow handled=
.
> > > > Its not INTX handling alone for this IRQ line .  So chained IRQ
> > > > can be used for self consumed interrupts too ?
> > >
> > > No. In this specific case both solutions are not satisfying, we need
> > > to give it some thought, I will talk to Marc (CC'ed) to find the
> > > best option here going forward.
> > >
> > Hi Marc,
> >
> > Can you please provide yours inputs for this case.
> >
> Hi Marc,
>=20
> Can you please provide required inputs on this.
>=20
HI Lorenzo,

Since Marc hasn't responded, do you have any inputs on this ?
Shall I proceed with other comments of yours ?

Regards,
Bharat
