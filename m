Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1408F3B3B2A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 05:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhFYD0U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 23:26:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:53025 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232917AbhFYD0T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 23:26:19 -0400
IronPort-SDR: 9Cv9lPlPfOwH1nEfaxuWBbVOEuoAemjz+8+mgSukQ6NRPDYzqW1uY4OidrSxZWVIOsjhG5M9jO
 0vG99IVSe6uw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268732331"
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="268732331"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 20:23:59 -0700
IronPort-SDR: LenHBVWarhe67S6H4IwPis9R53h+JzaZe1l9DyGbO6Nj90VhcZDkAsATg5yncjxN7Rt4SjISc/
 Zl/Om/isA3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,298,1616482800"; 
   d="scan'208";a="445522244"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2021 20:23:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 24 Jun 2021 20:23:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 24 Jun 2021 20:23:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 24 Jun 2021 20:23:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFforE5U9gYjwjfBm/zF/aV5L9OhpkdqcJftHkIzKZSOCv2KvfC8CVZZJYl2gAxckklpX0IOc+7K7mz2Z8GVZPXNnlxe4fnvp81T7E6j0DA4cKRQTEZA4M/aWvaKI8yKjpFagKUt2mjPCbboS6sPjZ3UwlOAA5XDoML7hpgAdYLFtHD7Z98i/FnK1huHk5g9PACCJvM+G3GNrPBBigL15AucqGjw6U6JTkbXPUbT7/KzxOlI7BPWqy9ErIF3Po2Y8VMscQYiUZfNZqris6z4YpBDIKT75/NjeG5YYlW0Ku+9Mbmb9fEfj/Wcudj05g5CPLWH0u+X/sd1eq8qYsWfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCNOkQw1QMxah6NtTXkGCTYChGuu+5nCNoELZu2VvDQ=;
 b=CRdSNPfdr/7TIB+XL0HgDxrPjdbVxF8eUUvXuC6u2xfHE4NVfynyYdZSStYj5xn1Zs1tUt19APp8CWOlv49TjRAQFvAnIDTJWLwd5xAaR13jNWaPvrZ50RIHQfDm5ExfWpoVhVEUSGphqfVovY8GFTfmYQW9evqN4H0ITqKhnKviHfngmv4ujR5a1lN735Huoy2G7y6cR30dtkOh7Oh8DqIXU/C0AUhHg7sMhxvPQ09C+Vpj9yr6Ubs+4JG/FnJTED5GPFWzmFvcARmUcq9X74LC+Nh4ds3EB3cS7RweKpS1eeuE3TdnORA2nnH1ddDnblgbKmxpim19ZmfDDk/BUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCNOkQw1QMxah6NtTXkGCTYChGuu+5nCNoELZu2VvDQ=;
 b=xnXpR4MMd8pbt8zYbOVirxFMip+DcSF8c0jRE3jVfbNVb8DGcudWPHCyRhkitVfJwCUNRBL6ObRpulwTutL1sCUm5O8AwD09hamINZBQZnqOdz/KrLtDrt4AmeaDuQ1n1Qa0VfBiL2e2mUGBeVDFjTyoEmWtJNWpWMCCrsR/R7o=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5676.namprd11.prod.outlook.com (2603:10b6:510:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 25 Jun
 2021 03:23:47 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::201a:d1e0:b3b1:fb8f]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::201a:d1e0:b3b1:fb8f%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 03:23:47 +0000
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
Thread-Index: AQHXW3FV4CKL56K+SEOKbFusTp+FKasexPQAgASQnFA=
Date:   Fri, 25 Jun 2021 03:23:47 +0000
Message-ID: <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
 <20210621162506.GA31511@lpieralisi>
In-Reply-To: <20210621162506.GA31511@lpieralisi>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [106.201.44.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2875b193-a4d5-4bf6-2312-08d93788a556
x-ms-traffictypediagnostic: PH0PR11MB5676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB567613BDF818DD284B944FB485069@PH0PR11MB5676.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1T4qgFR+tpPta85rRgOO49yMgbnmOT5AIeEp9+09cji9XOKZ3sOHZQM68qdiISU4KEsenvn8P7MRUSHArzpZo4l9tURGMKlhe9CA+r/9R5dGGJRHfzNXpN+p1tnKK5//yBIfCXU3jUK+xYaCm9JDrQ+irhOyzGBOeBu3pmzWhFrDqYD/IfigV13ODSrpYUuqhpiuWAOSLSM3Otro7F4sHhWsJ6gWwmncBVeQHeidIaGDiZhD7cX9XWbWt95RnRPF5LzG5Gw6srXoY+itp0ti0EThaP/IB6JBXQK+1wTUn5qEvPMaCcKWlsm2LoZrqQOLfxhNlnWvJQqWfNm77n8IVy6t++omiSkGSf0De2yZnWn+123Q0oFIOUtYTQKfJymdg0PnrIqarJB0hi6ciFHV0kt8dSxGKaY3Hpq1LgtrhDGD/5RRtz4xP+Cic/YI8DPQUuzXv4UzRc0c6TulwZfJWvV1vLZ+2c+12CXYr5uKtt7o9qJzq0DaI1msAExvVe3bs4wVXVrJ/ZDO2mDfNFdAotLyT7K2IF5pPKXNsHWV/fb+eZIfkmYDDfybPFIMG1s0fRsbQ7aInHdYJsH7gI8mZ9rEA4dBpP8r8Un02WwTP0O5qT9JmBBromlon0IVVzevz1yomyWRFkLmlw6SDeSHog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(122000001)(86362001)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(71200400001)(5660300002)(76116006)(38100700002)(6506007)(8936002)(54906003)(2906002)(33656002)(55016002)(186003)(110136005)(7696005)(83380400001)(9686003)(4326008)(55236004)(53546011)(8676002)(26005)(478600001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hZ5WwE9RoHAQ2l5HBe2axVkb7dtPe7NjIZLBowZgtSjlfTC3C3TyF2HKv7lw?=
 =?us-ascii?Q?1CaEMvo3B8CJBVm+dlPrZ6yVzs14xy9KRiysHSCEDq0C7jDQYrhrxpwvoEpE?=
 =?us-ascii?Q?AT2feCnXvqjbZ/SuG/xrow8Q5VPW9Rkkhsg5vZSGvPTJU51RnuEAPnrHDdEU?=
 =?us-ascii?Q?KkTV5sQHJU7iRGLasZzV15rSRPZBwTHhh5re5nG1cid5y91dXWG3ASUvDKXY?=
 =?us-ascii?Q?q+CJMaOQvRxLG3m1qTdH4XymOgoS5c6OEY3wve+5yzJGdck2sV8ZnudCMo4+?=
 =?us-ascii?Q?fcXPInwfdOyWIOLuwlnnCMrb1XcXoqtaSeHCZKkLhFNBbPdWEY3o2JE+Npva?=
 =?us-ascii?Q?TvC0dFYwLoOOVhTHjSa6zZQH3gYqtxb8tDUMXWmiAuiama2FNq93q1AaekQ3?=
 =?us-ascii?Q?wuL8r0zkxjbRqR7vUO23XPfoUTD6fMQw8HadldeWpMPThi/cV5pHdfLfTHd1?=
 =?us-ascii?Q?mDHio8IgjCbuTKVFcBwYrfOioVTU8hXBebU2UKdKUXg4Ao55TITPK4y4UfIY?=
 =?us-ascii?Q?8g/xOehZ7sFJugCyNol+4R/JkkZ0w6KjjTydZSHdBVqBE7pxxEAXWFq5t5zu?=
 =?us-ascii?Q?esLVOENE/EntmC1s1A0j6mwmYKoDuFqSUEgP5FIM4INifnIgyKkLG0yNFvOV?=
 =?us-ascii?Q?zWAmGGoAWlT4Hqt7YUu6FaUXTb+RCP5UKhRGFkwh67O64f66CwjPDeygzoh7?=
 =?us-ascii?Q?IuegXYh6KGBXRsKzDgum5O9KnyzHsDvRpUQTmDTg/e8MuSZLFSsqMMunZJk6?=
 =?us-ascii?Q?Yrl0JiXnYfhoURMhIxl1hw3/+8iLj3KAiq94Ew0zQF5YyUqEr0ajT55pIxG9?=
 =?us-ascii?Q?772Uh7jTQxQp+O8h+59RVoJ4BssKgYCEDhQleYeVt92hrMUmHLwi3QI0v57M?=
 =?us-ascii?Q?meF+xpmGVVKa+nZUHD24ysHl/TUbB1jDxGfPRL3ZYxRaCWi2WJXMJzTVGBdc?=
 =?us-ascii?Q?YVz6U7rO9y62t4+FX8Adnb2aThwM0F1fs0zFCZ88LyO9pUo37O7bx+3b6zBJ?=
 =?us-ascii?Q?CkToGCB/LvAPC/+iICMoqZx1pCcjHZNpP9+4m4rizIM4yIBQBw/S1nr3BRoD?=
 =?us-ascii?Q?ujZMUuQF96Pob1QpFgMzNXAgdf0dwstQLM7A7L26EfMcpdEDPfpFqUKeaYeg?=
 =?us-ascii?Q?xF1fxaHODi5tzkJcV0Iozwaa2x1FRPsN7Vw+rTOqzR+jwpwNuYe60K+FYDJi?=
 =?us-ascii?Q?PFrBvyKfC3NTGzKVot5dnsyJ2WcSsUYc6Pl5KMoKFcw/blQXIJhJthCCJsaS?=
 =?us-ascii?Q?wMoqg1+vKxL3c0K47rkPNa/3EOpwcODa/+P10KLejY8cmUUYM3Ny+E0I3yDp?=
 =?us-ascii?Q?4PPCbROLRNNts/a0PPErJXWo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2875b193-a4d5-4bf6-2312-08d93788a556
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2021 03:23:47.7536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o02lKWk4gZ93UinxKAI0xncQaNXJoY+SdYkAKFapAj6GS9LFobrcW0XUYsvGH1wwbWUOnDx8ibr/k+yAXGnFzeHr+KnwiyWaAbhEfVSG9kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5676
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, June 21, 2021 10:23 PM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>; maz@kernel.org
> Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> [+Marc]
>=20
> On Mon, Jun 07, 2021 at 09:10:44PM +0530, srikanth.thokala@intel.com
> wrote:
> [...]
>=20
> > +static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
> > +{
> > +	struct keembay_pcie *pcie =3D irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	u32 val, mask, status;
> > +	struct pcie_port *pp;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	pp =3D &pcie->pci.pp;
> > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > +	mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > +
> > +	status =3D val & mask;
> > +
> > +	if (status & MSI_CTRL_INT) {
> > +		dw_handle_msi_irq(pp);
> > +		writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
> > +{
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int irq;
> > +
> > +	irq =3D platform_get_irq_byname(pdev, "pcie");
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	irq_set_chained_handler_and_data(irq, keembay_pcie_msi_irq_handler,
> > +					 pcie);
> > +
>=20
> Ok this is yet another DWC MSI incantation and given that Marc worked
> hard consolidating them let's have a look before we merge it.
>=20
> IIUC - this IP relies on the DWC logic to handle MSIs + custom
> registers to detect a pending MSI IRQ because the logic in
> dw_chained_msi_irq() is *not* enough so you have to register
> a driver specific chained handler. This looks similar to the dra7xx
> driver MSI handling but I am not entirely convinced it is needed.
>=20
> I assume this code in keembay_pcie_msi_irq_handler() is required
> owing to additional IP logic on top of the standard DWC IP, in
> particular the PCIE_REGS_INTERRUPT_STATUS write to "clear" the
> IRQ.
>=20
> We need more insights before merging it so please provide them.
>=20
> pp =3D &pcie->pci.pp;
> val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
>=20
> status =3D val & mask;
>=20
> if (status & MSI_CTRL_INT) {
> 	dw_handle_msi_irq(pp);
> 	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> }

Yes, your understanding is correct.

Additional registers PCIE_REGS_INTERRUPT_ENABLE/_STATUS are provided
by IP to control the interrupts.

To receive MSI interrupts, SW must enable bit '8' of _ENABLE register.
And once a MSI is raised by the End point, bit '8' of _STATUS register
will be set and it needs to be cleared after servicing the interrupt.

Thanks!
Srikanth

>=20
> Thanks,
> Lorenzo
>=20
> > +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +
> > +	writel(EDMA_INT_EN, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > +}
> > +
> > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no=
,
> > +				     enum pci_epc_irq_type type,
> > +				     u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		/* Legacy interrupts are not supported in Keem Bay */
> > +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > +		return -EINVAL;
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	case PCI_EPC_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static const struct pci_epc_features keembay_pcie_epc_features =3D {
> > +	.linkup_notifier	=3D false,
> > +	.msi_capable		=3D true,
> > +	.msix_capable		=3D true,
> > +	.reserved_bar		=3D BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> > +	.bar_fixed_64bit	=3D BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> > +	.align			=3D SZ_16K,
> > +};
> > +
> > +static const struct pci_epc_features *
> > +keembay_pcie_get_features(struct dw_pcie_ep *ep)
> > +{
> > +	return &keembay_pcie_epc_features;
> > +}
> > +
> > +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops =3D {
> > +	.ep_init	=3D keembay_pcie_ep_init,
> > +	.raise_irq	=3D keembay_pcie_ep_raise_irq,
> > +	.get_features	=3D keembay_pcie_get_features,
> > +};
> > +
> > +static const struct dw_pcie_host_ops keembay_pcie_host_ops =3D {
> > +};
> > +
> > +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> > +				      struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct pcie_port *pp =3D &pci->pp;
> > +	struct device *dev =3D &pdev->dev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	pp->ops =3D &keembay_pcie_host_ops;
> > +	pp->msi_irq =3D -ENODEV;
> > +
> > +	ret =3D keembay_pcie_setup_msi_irq(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pcie->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(pcie->reset))
> > +		return PTR_ERR(pcie->reset);
> > +
> > +	ret =3D keembay_pcie_probe_clocks(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> > +	val |=3D PHY0_SRAM_BYPASS;
> > +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> > +
> > +	writel(PCIE_DEVICE_TYPE, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > +
> > +	ret =3D keembay_pcie_pll_init(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > +	writel(val | PCIE_RSTN, pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > +	keembay_ep_reset_deassert(pcie);
> > +
> > +	ret =3D dw_pcie_host_init(pp);
> > +	if (ret) {
> > +		keembay_ep_reset_assert(pcie);
> > +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > +		val |=3D MSI_CTRL_INT_EN;
> > +	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pcie_probe(struct platform_device *pdev)
> > +{
> > +	const struct keembay_pcie_of_data *data;
> > +	struct device *dev =3D &pdev->dev;
> > +	struct keembay_pcie *pcie;
> > +	struct dw_pcie *pci;
> > +	enum dw_pcie_device_mode mode;
> > +
> > +	data =3D device_get_match_data(dev);
> > +	if (!data)
> > +		return -ENODEV;
> > +
> > +	mode =3D (enum dw_pcie_device_mode)data->mode;
> > +
> > +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pci =3D &pcie->pci;
> > +	pci->dev =3D dev;
> > +	pci->ops =3D &keembay_pcie_ops;
> > +
> > +	pcie->mode =3D mode;
> > +
> > +	pcie->apb_base =3D devm_platform_ioremap_resource_byname(pdev, "apb")=
;
> > +	if (IS_ERR(pcie->apb_base))
> > +		return PTR_ERR(pcie->apb_base);
> > +
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	switch (pcie->mode) {
> > +	case DW_PCIE_RC_TYPE:
> > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> > +			return -ENODEV;
> > +
> > +		return keembay_pcie_add_pcie_port(pcie, pdev);
> > +	case DW_PCIE_EP_TYPE:
> > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> > +			return -ENODEV;
> > +
> > +		pci->ep.ops =3D &keembay_pcie_ep_ops;
> > +		return dw_pcie_ep_init(&pci->ep);
> > +	default:
> > +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> > +		return -ENODEV;
> > +	}
> > +}
> > +
> > +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data =3D {
> > +	.mode =3D DW_PCIE_RC_TYPE,
> > +};
> > +
> > +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data =3D {
> > +	.mode =3D DW_PCIE_EP_TYPE,
> > +};
> > +
> > +static const struct of_device_id keembay_pcie_of_match[] =3D {
> > +	{
> > +		.compatible =3D "intel,keembay-pcie",
> > +		.data =3D &keembay_pcie_rc_of_data,
> > +	},
> > +	{
> > +		.compatible =3D "intel,keembay-pcie-ep",
> > +		.data =3D &keembay_pcie_ep_of_data,
> > +	},
> > +	{}
> > +};
> > +
> > +static struct platform_driver keembay_pcie_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "keembay-pcie",
> > +		.of_match_table =3D keembay_pcie_of_match,
> > +		.suppress_bind_attrs =3D true,
> > +	},
> > +	.probe  =3D keembay_pcie_probe,
> > +};
> > +builtin_platform_driver(keembay_pcie_driver);
> > --
> > 2.17.1
> >
