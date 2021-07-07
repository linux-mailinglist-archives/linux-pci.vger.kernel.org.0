Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC4F3BE772
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jul 2021 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGGL5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jul 2021 07:57:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:62665 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231358AbhGGL5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Jul 2021 07:57:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="207464726"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="207464726"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 04:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="497802901"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jul 2021 04:54:59 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 7 Jul 2021 04:54:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 7 Jul 2021 04:54:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 7 Jul 2021 04:54:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwZt4pQlk99H4ikMcdXwDFu9+oL/TLvallAUMkxZ3EJM0fK9xdw4ROTKq1SdzOPkOnDJf34fvRZFS3AP9GKxCp+EkX+CoosmnAHK14vTNcNTvrhtRxGsHvRq/+nfu76ZLC6NjExjO+2yCcbjejv9WF1ao0jJfuHy8Qj1xFZBln1XJVN6VZEmTNXQ44XM8MGaoa2Y2RxQPRNXgqha7DSzhx+xDOweiFJ7jqYTx4nBw/dAZ04xcz6nyWcucAoYXyBNWxcUZXniJata7BL54m9GDtaLapzeYEgze5VlEhkrxk25geVgEqzWuPimiRIEhDEvHW255Eqvd0iQRgG847mEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMs8UO7Xvol032t+4aDhKjT78PC6/oT+ocH9T05Ktbw=;
 b=ASLYfATSmVal7e62Itrt1v8z/ieS8m/c09t9IF6iOtKuRXzXbxLeumaRHRPCBE0ckeK+EaH0IUNt3ZziIMg7+INMxfW53TubhFBUbd7iIuFLzhU3DWxnNzcj0+sFJgnXMJ1FtpS+D0nTk8qZBWRvdUorltz0yIm2fYTJIPzyXcaYmzl8DSPcTKl1m45ttkaVIkmlKCA+qT3Cx1nn/ovk+e0mQVwauuRvt2MEssvOSEV1osJX2juCgfn2DZqS+BKoxz+ByKlylS3eJc/UXne0uqfIgSt0OV82fXfKmzCSbJKy5LYCKkcG2QsZ39YSVpwWJq/am5wWPFbQhfd1DJJdMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMs8UO7Xvol032t+4aDhKjT78PC6/oT+ocH9T05Ktbw=;
 b=MlxwQBEpiO4CIo24i9o/jN04smLE7Gq1vOpi6mTQn8Wj5WSZPbqMvIahnfIv/8Sp46vIBP1V2Vn81/JHSBge+Q/I+/gIxb0+gxhrvcGvrpnwMV7yMADrh+K9NrwcD1ScnqJIa+f29hfA2nrhjhIlQG/orYjoTLpeaG9mCfoNXe8=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5577.namprd11.prod.outlook.com (2603:10b6:510:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 11:54:57 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::947f:429f:312b:c530]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::947f:429f:312b:c530%4]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 11:54:57 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXW3FV4CKL56K+SEOKbFusTp+FKasexPQAgASQnFCAEpouoA==
Date:   Wed, 7 Jul 2021 11:54:57 +0000
Message-ID: <PH0PR11MB55950B723B19DDE38E408380851A9@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
 <20210621162506.GA31511@lpieralisi>
 <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 842bcef7-2511-4f34-d569-08d9413e0afd
x-ms-traffictypediagnostic: PH0PR11MB5577:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5577906BDDA42735A7A2AAE0851A9@PH0PR11MB5577.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OUeg5YYr3Q+VS/oJutYZlasyRaKsGGtST/6Uv+1tr8fc6GI/XUGFOzTFMx/l/Hl0P9KgZ2av6VDGTaj1lJLg+NDJNVKLZKfyyIAzu4c0+izh8oywNhH/37NKsVelYQINLS3L2JrwO0d+01q1OWG+5shv7UNRQY1hC6OD1WCA5RtVwRIW2WdTyJoJafSMhA9RiikM5CGQxzvqXAiuqiwBzWPkm1wq7suiqtqSQ/x5V2mz7S/xy/ISw6XSAtvNkPMkkBayjsimEr5MdGNUhAYuSAFxtw/VC3xzZEPixHqYEQA/SSc7ilGGeH2dIijt8WknDaRXrw5+F5YWyGoRJbft6zEzVt4F9uNzjCtZpsLitdGX4pT6V33AEzJxA55gYxaPZWy8GYotA8stoHFqlHH7PohRYXBoBVnf0thh6lnQl2HNugWB9nsC83ojPG9Jhl3Q2KVe4A5k6knw6y3PhH3JaEN9CovXmo/UtOy9t+QIkBDhO70YUcmSRhCR/VjVtvA/xpqxnDy1MqjFSqgsgl5WOoX+3mfE3t1RW/UmjZDEZZYC7bX8zcKlGBxVP+r429zsAq/RIpTvAWL/jB+YzJylZOa1uz1HaDebXeucPA+yO2cZIG/7lA+OxWeELQxHvGVW1vyvxIGgOL2mkyJH32cZdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(76116006)(66446008)(38100700002)(66556008)(66946007)(9686003)(186003)(2906002)(66476007)(64756008)(26005)(8676002)(8936002)(52536014)(71200400001)(5660300002)(7696005)(55016002)(6506007)(53546011)(478600001)(54906003)(4326008)(122000001)(83380400001)(316002)(86362001)(33656002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AlgsRRUGkGn6iDOim2gVSdZwnofiQj3M/NmLNRDnuCADJFooo5di7oeW+5ju?=
 =?us-ascii?Q?RY1ozFGN6D51qRPyN16Fbfj52uvVA7dTea5w3TJU6NVXwt1oQ8QTLL49vSEx?=
 =?us-ascii?Q?BGrkgtGjIN3hpfxq5teWjtUw8CA6igMqWtE9edx6FcQSubn1N0Z5oMlVZej1?=
 =?us-ascii?Q?VAdDHZZtx5RY3EfqobO7g0OjRcZXU4A3voUsiUS7Mdm6sNezlDRM9jxJ/t3W?=
 =?us-ascii?Q?5cEbio/iBdki2kuIpsmBketWXnaTwZdSbcgoNb7IU2dH5dSzJoyYRHLZ3F0g?=
 =?us-ascii?Q?PaCl7sn6zVvshl9PEM8rhGd4VGnC5bnHDTgh/INQDOFBrwax+7oEWQEzn4TT?=
 =?us-ascii?Q?Sj+yTqF+zaAkp0xAdOn0aAiYIms/fxZEo/7kVswEwAR7jRnD6UoFOnxOZRUN?=
 =?us-ascii?Q?ZHW49mYSDR3EE/S7kE/pE8NNuLL71Lcw7irbq/SsXl3KkTyQyupMiEecPXxk?=
 =?us-ascii?Q?liAy8nyI20n+E4O8wJ9LtRydn/TYHe4+lyTafNP920yzp8sGmPxwPls8dL08?=
 =?us-ascii?Q?r+Wz1RkKjQK6JV+udVQw0LXLb/WopAIz7dFhB8VeSKMN0IxRD7LwSOTqyDj0?=
 =?us-ascii?Q?dTZO8z28KMNcLbjBGYefJdurrEf/wf/N/nya4VPCljbtb0a7aPAtD5hE/e9X?=
 =?us-ascii?Q?ZunJSb7EtK6f2zVPhjtmSx18A5a1YOJzvcNMY89fOXvl/blPc7KEa6DaCX6p?=
 =?us-ascii?Q?wEirOGawE7aDsf1oUK/ZhyTNkSn6CZVhjb3rRfXP6UJJjkP8Tps+bWEtPzCH?=
 =?us-ascii?Q?aqMZtnLCMh1JjRlIrWVM0uiuyJPllgFGwR4SjqB5+2Owcoz6knMe9TM33Sqj?=
 =?us-ascii?Q?SfkEztcML/wuv268ESU6EhtXqzKs8/cEe2f9eNaLxriZwP+CybWJnmPnBIIP?=
 =?us-ascii?Q?pbvCQd2WBaOo1qnxH+rjxznD6PKNjbubn+0aMiujvG3qVUJ2RVeyGgqldXt/?=
 =?us-ascii?Q?Ox9IY3bObGJ1g0OUHJaj6nkSaBBzzwR0N41cl80RbHAiju1x7FfSAFbli9qm?=
 =?us-ascii?Q?J3lbVpQjiHsNnis9IVj/FDZlJpEwFgfU5JZPH6aR+axACrE/3CBLsVZQRLmr?=
 =?us-ascii?Q?ukkuRSe8E1/5kBpVPffaj0b2uFTctFeDM8niqwKd5iWwrB0VzrGohYD2KQ9S?=
 =?us-ascii?Q?ZKRdqxdjQP4KYco8bveT9cZ0byG1E5SaEwxYpPP36GIKtRt/Eiqvy//vjeGF?=
 =?us-ascii?Q?f59xf5+UMzJv6LPKRxVqio7/LV8Rl52UwrH1C8Nf0RsgdQRGgS6kbQyr9fmJ?=
 =?us-ascii?Q?FB779HJcsy/ZytvMWlInSdvEQAN+cG5D94SjMilUFs/jZuEiwtIrskkejLdX?=
 =?us-ascii?Q?NGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 842bcef7-2511-4f34-d569-08d9413e0afd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 11:54:57.6656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vgxVy8dy4enUKkZdDvQibke6duehQjr40XYO5aeDK+BEuj2QY7ahpD6zYpys0wixMa+FeVR+NIrCll48A98VI/DhZG+DM1Dey62LiRFT+LU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5577
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo and Marc,

> -----Original Message-----
> From: Thokala, Srikanth
> Sent: Friday, June 25, 2021 8:54 AM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; maz@kernel.org
> Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> Subject: RE: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem
> Bay
>=20
> Hi Lorenzo,
>=20
> > -----Original Message-----
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Sent: Monday, June 21, 2021 10:23 PM
> > To: Thokala, Srikanth <srikanth.thokala@intel.com>; maz@kernel.org
> > Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> > mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> > Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem
> Bay
> >
> > [+Marc]
> >
> > On Mon, Jun 07, 2021 at 09:10:44PM +0530, srikanth.thokala@intel.com
> > wrote:
> > [...]
> >
> > > +static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
> > > +{
> > > +	struct keembay_pcie *pcie =3D irq_desc_get_handler_data(desc);
> > > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > > +	u32 val, mask, status;
> > > +	struct pcie_port *pp;
> > > +
> > > +	chained_irq_enter(chip, desc);
> > > +
> > > +	pp =3D &pcie->pci.pp;
> > > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > > +	mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > +
> > > +	status =3D val & mask;
> > > +
> > > +	if (status & MSI_CTRL_INT) {
> > > +		dw_handle_msi_irq(pp);
> > > +		writel(status, pcie->apb_base +
> PCIE_REGS_INTERRUPT_STATUS);
> > > +	}
> > > +
> > > +	chained_irq_exit(chip, desc);
> > > +}
> > > +
> > > +static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
> > > +{
> > > +	struct dw_pcie *pci =3D &pcie->pci;
> > > +	struct device *dev =3D pci->dev;
> > > +	struct platform_device *pdev =3D to_platform_device(dev);
> > > +	int irq;
> > > +
> > > +	irq =3D platform_get_irq_byname(pdev, "pcie");
> > > +	if (irq < 0)
> > > +		return irq;
> > > +
> > > +	irq_set_chained_handler_and_data(irq,
> keembay_pcie_msi_irq_handler,
> > > +					 pcie);
> > > +
> >
> > Ok this is yet another DWC MSI incantation and given that Marc worked
> > hard consolidating them let's have a look before we merge it.
> >
> > IIUC - this IP relies on the DWC logic to handle MSIs + custom
> > registers to detect a pending MSI IRQ because the logic in
> > dw_chained_msi_irq() is *not* enough so you have to register
> > a driver specific chained handler. This looks similar to the dra7xx
> > driver MSI handling but I am not entirely convinced it is needed.
> >
> > I assume this code in keembay_pcie_msi_irq_handler() is required
> > owing to additional IP logic on top of the standard DWC IP, in
> > particular the PCIE_REGS_INTERRUPT_STATUS write to "clear" the
> > IRQ.
> >
> > We need more insights before merging it so please provide them.
> >
> > pp =3D &pcie->pci.pp;
> > val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> >
> > status =3D val & mask;
> >
> > if (status & MSI_CTRL_INT) {
> > 	dw_handle_msi_irq(pp);
> > 	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > }
>=20
> Yes, your understanding is correct.
>=20
> Additional registers PCIE_REGS_INTERRUPT_ENABLE/_STATUS are provided
> by IP to control the interrupts.
>=20
> To receive MSI interrupts, SW must enable bit '8' of _ENABLE register.
> And once a MSI is raised by the End point, bit '8' of _STATUS register
> will be set and it needs to be cleared after servicing the interrupt.

Hope I have provided all the necessary information.
Kindly feedback.

Thanks!
Srikanth

>=20
> Thanks!
> Srikanth
>=20
> >
> > Thanks,
> > Lorenzo
> >
> > > +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> > > +{
> > > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > > +
> > > +	writel(EDMA_INT_EN, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > +}
> > > +
> > > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8
> func_no,
> > > +				     enum pci_epc_irq_type type,
> > > +				     u16 interrupt_num)
> > > +{
> > > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > +
> > > +	switch (type) {
> > > +	case PCI_EPC_IRQ_LEGACY:
> > > +		/* Legacy interrupts are not supported in Keem Bay */
> > > +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > > +		return -EINVAL;
> > > +	case PCI_EPC_IRQ_MSI:
> > > +		return dw_pcie_ep_raise_msi_irq(ep, func_no,
> interrupt_num);
> > > +	case PCI_EPC_IRQ_MSIX:
> > > +		return dw_pcie_ep_raise_msix_irq(ep, func_no,
> interrupt_num);
> > > +	default:
> > > +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> > > +static const struct pci_epc_features keembay_pcie_epc_features =3D {
> > > +	.linkup_notifier	=3D false,
> > > +	.msi_capable		=3D true,
> > > +	.msix_capable		=3D true,
> > > +	.reserved_bar		=3D BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> > > +	.bar_fixed_64bit	=3D BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> > > +	.align			=3D SZ_16K,
> > > +};
> > > +
> > > +static const struct pci_epc_features *
> > > +keembay_pcie_get_features(struct dw_pcie_ep *ep)
> > > +{
> > > +	return &keembay_pcie_epc_features;
> > > +}
> > > +
> > > +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops =3D {
> > > +	.ep_init	=3D keembay_pcie_ep_init,
> > > +	.raise_irq	=3D keembay_pcie_ep_raise_irq,
> > > +	.get_features	=3D keembay_pcie_get_features,
> > > +};
> > > +
> > > +static const struct dw_pcie_host_ops keembay_pcie_host_ops =3D {
> > > +};
> > > +
> > > +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> > > +				      struct platform_device *pdev)
> > > +{
> > > +	struct dw_pcie *pci =3D &pcie->pci;
> > > +	struct pcie_port *pp =3D &pci->pp;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	u32 val;
> > > +	int ret;
> > > +
> > > +	pp->ops =3D &keembay_pcie_host_ops;
> > > +	pp->msi_irq =3D -ENODEV;
> > > +
> > > +	ret =3D keembay_pcie_setup_msi_irq(pcie);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	pcie->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(pcie->reset))
> > > +		return PTR_ERR(pcie->reset);
> > > +
> > > +	ret =3D keembay_pcie_probe_clocks(pcie);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> > > +	val |=3D PHY0_SRAM_BYPASS;
> > > +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> > > +
> > > +	writel(PCIE_DEVICE_TYPE, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > > +
> > > +	ret =3D keembay_pcie_pll_init(pcie);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > > +	writel(val | PCIE_RSTN, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > > +	keembay_ep_reset_deassert(pcie);
> > > +
> > > +	ret =3D dw_pcie_host_init(pp);
> > > +	if (ret) {
> > > +		keembay_ep_reset_assert(pcie);
> > > +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > > +		val |=3D MSI_CTRL_INT_EN;
> > > +	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int keembay_pcie_probe(struct platform_device *pdev)
> > > +{
> > > +	const struct keembay_pcie_of_data *data;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct keembay_pcie *pcie;
> > > +	struct dw_pcie *pci;
> > > +	enum dw_pcie_device_mode mode;
> > > +
> > > +	data =3D device_get_match_data(dev);
> > > +	if (!data)
> > > +		return -ENODEV;
> > > +
> > > +	mode =3D (enum dw_pcie_device_mode)data->mode;
> > > +
> > > +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > +	if (!pcie)
> > > +		return -ENOMEM;
> > > +
> > > +	pci =3D &pcie->pci;
> > > +	pci->dev =3D dev;
> > > +	pci->ops =3D &keembay_pcie_ops;
> > > +
> > > +	pcie->mode =3D mode;
> > > +
> > > +	pcie->apb_base =3D devm_platform_ioremap_resource_byname(pdev,
> "apb");
> > > +	if (IS_ERR(pcie->apb_base))
> > > +		return PTR_ERR(pcie->apb_base);
> > > +
> > > +	platform_set_drvdata(pdev, pcie);
> > > +
> > > +	switch (pcie->mode) {
> > > +	case DW_PCIE_RC_TYPE:
> > > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> > > +			return -ENODEV;
> > > +
> > > +		return keembay_pcie_add_pcie_port(pcie, pdev);
> > > +	case DW_PCIE_EP_TYPE:
> > > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> > > +			return -ENODEV;
> > > +
> > > +		pci->ep.ops =3D &keembay_pcie_ep_ops;
> > > +		return dw_pcie_ep_init(&pci->ep);
> > > +	default:
> > > +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> > > +		return -ENODEV;
> > > +	}
> > > +}
> > > +
> > > +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data =3D
> {
> > > +	.mode =3D DW_PCIE_RC_TYPE,
> > > +};
> > > +
> > > +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data =3D
> {
> > > +	.mode =3D DW_PCIE_EP_TYPE,
> > > +};
> > > +
> > > +static const struct of_device_id keembay_pcie_of_match[] =3D {
> > > +	{
> > > +		.compatible =3D "intel,keembay-pcie",
> > > +		.data =3D &keembay_pcie_rc_of_data,
> > > +	},
> > > +	{
> > > +		.compatible =3D "intel,keembay-pcie-ep",
> > > +		.data =3D &keembay_pcie_ep_of_data,
> > > +	},
> > > +	{}
> > > +};
> > > +
> > > +static struct platform_driver keembay_pcie_driver =3D {
> > > +	.driver =3D {
> > > +		.name =3D "keembay-pcie",
> > > +		.of_match_table =3D keembay_pcie_of_match,
> > > +		.suppress_bind_attrs =3D true,
> > > +	},
> > > +	.probe  =3D keembay_pcie_probe,
> > > +};
> > > +builtin_platform_driver(keembay_pcie_driver);
> > > --
> > > 2.17.1
> > >
