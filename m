Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5840834F845
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 07:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhCaF3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Mar 2021 01:29:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:26864 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229959AbhCaF2v (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Mar 2021 01:28:51 -0400
IronPort-SDR: V42xR+J39wOBSpMV+fqiAVfeqJkqbJNBfrOx6adpR9dhPEYpprrCNH+W19DUAyxXIrnVFmvWe/
 eUOuGp8Wp03A==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="179050553"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="179050553"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 22:28:49 -0700
IronPort-SDR: SENJv2amtFIwHZ2SVc2MGOmQrDxtlEfm2FfABy9Emznc5iVs12lXgS5g29UDuK3sEtK2axD5ZF
 Fr1gfWZEKOyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="610357158"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 30 Mar 2021 22:28:49 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 30 Mar 2021 22:28:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 30 Mar 2021 22:28:48 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.51) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 30 Mar 2021 22:28:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQrbaLq2Y13wq8fQtA4PHXloUS/J8iIFqrvjNRDbvkAliACoAH8gW4KQ6tOPJujp26OoewBMrXFpLjn11ogMRlvEqesvuwfrgEzg/nWexTWwc77lpkzdMWvdZkc/RV+LT7z5nPk0p73SdDxEjwr2sY+p0q1ucuZUlSDi23GRlhOFpSkJDGzuQ5wTeSlEqT5DTaNBGZGjPK6ZsHD+rPEpt4H4s3V2LtmGlZ2kZFPVMTBmjIQlPq64q17h5jNrlsSMm5cJE8LG+9ZEw/nPyOpqHJqeeBYl36v32QZfR+GTE2Z+FbQKxhBSAJP7DYGsHPAqtURx5j4IoT05j9hZeLWaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+VRyxK+NqFXCMEA6+Ttc/3f2OPws+g+vMCZfKihPmw=;
 b=luHsNlemY2Q53LydrJmL6Ic4etD3jDXFOaxtWUt4CZBZqwRpliBPWWrYvUs7JC/suamSbSR/ly/ROntapySYnXcs2xThrflOSrECk+TRO0bX10R3M5h2ngjVnfps2kzI0mC+HdWMbHs25FWoTGVnsWcsPj1Sh/VrZEdB7V+FiLoQJnnZKc8jrOb9b7tEE10/OFfI51K1seYUkxurcvgEKv/upu6tu48d14HWpIsyd2upy9ArB780tnsUTJ7w/ZJ9b6Y64BQ1A3LBi2f1stV0Yx4dGKzS1wW72+jkGfSKfxNKkcWG66IizwXO0IlugqvYoj+WybVWlCDrepTsFJ7rXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+VRyxK+NqFXCMEA6+Ttc/3f2OPws+g+vMCZfKihPmw=;
 b=zc9bocFtA74zCGXRgif3l5100Pkd7eHyAPnbNAu0s/nue0SvxSqSMKMIlMKN79qF+7rToFiBWTkUW/AxCjoLp9bGaWRKenGh0/41xufROzVKqgpaf8OLmPH4xc5yNxfApXeCDBF80AWDS7QWf46WWf9OBXakYuxLFrSxRrznWSs=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 31 Mar
 2021 05:28:47 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::15a:5c37:4662:d163]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::15a:5c37:4662:d163%5]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 05:28:47 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "kw@linux.com" <kw@linux.com>, "maz@kernel.org" <maz@kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
Subject: RE: [PATCH v8 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v8 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXBVou+XdwLl2NikywEE1XCJLSHqqbLjiAgAKWgZA=
Date:   Wed, 31 Mar 2021 05:28:47 +0000
Message-ID: <PH0PR11MB559554BEE78B87C4381A456B857C9@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210218021757.21931-1-srikanth.thokala@intel.com>
 <20210218021757.21931-3-srikanth.thokala@intel.com>
 <20210329130725.GA4983@e121166-lin.cambridge.arm.com>
In-Reply-To: <20210329130725.GA4983@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.172.49.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2de28f9b-060c-4a32-351e-08d8f405dbe3
x-ms-traffictypediagnostic: PH0PR11MB5611:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB561142995A04B5653ED447AC857C9@PH0PR11MB5611.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVS5sme8jZClpiLNDyaz3A3FvsPLAolXB2CuSijHpFkRv7Q9FWHqQUrK9dgFIjfkWPxjRL4sUwTX6AeJQ2oGsjKivuJ5yc5/onpactR4fT6DTFbh1KiJ6iTGoK2QkZKyYsdbcEomOV5SRwBfi1eGMtI6jvTbhdcXq7bicmPPyQcsVCXDLQ2lDH0tlH61ZF/u5+2DKibomU48Xw1aAJMZyH/Wc/W6txhxxH2tjuMBM41zX2gFUZyHGmc5lae6l5FYQ3VhbceYaeMlHlXvxONdZ6ruKDeiwXnsO7GT7aW7IzADBvNa1R1FVR10rRIzGVXpWU587J3EsIs9KsM/1eqjOjFJ4WcGnqURGjWDs/q2Xsr89qKI7bg8Q7p0byQ0+paVBCJtP7IBxXAfyI9Ln6L1o9Z/+NHelxujCS7Dtj/Ds4Gn1MCGPL5fW+dMfDn+fy7zsnfXhsxcBTbapWuAJAYtkl69+jGfzLvGUMXW4iFhmWqoQT9RxnrMSuwTLXDl6loPBPZJyMjCxHJKlKwn4TaMUkz37yiJtWsqdIO7ZN5rtEMnjgt61fvHMWDN0ft+tdTeCa3aiyuqA3BETV6aIeYoU49vwLt3pu9nZeWWPU+wHNPF/pYb8Wxrywy0nLjAae1p9RCCGnyhpW8cM7AyvKHTew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(71200400001)(64756008)(7696005)(38100700001)(66446008)(5660300002)(6506007)(76116006)(66946007)(54906003)(66556008)(4326008)(53546011)(316002)(26005)(186003)(83380400001)(8676002)(52536014)(86362001)(478600001)(55016002)(9686003)(33656002)(2906002)(6916009)(66476007)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+swNLGvpxs9P98h3XnW5N0yejrmLZ6mtgQhxfMRfI+ayR2+jZZSl6VV6Maon?=
 =?us-ascii?Q?6TaCACR9eV5vh8HRgrdmoG5aKwJdx2yBAWtphXv75cUKXE7UHgUfbEiwKOgp?=
 =?us-ascii?Q?UGU5QHRE/vK+aGLjIR1ORF1qRh2qs8h6+KO6DO3Nst05GNLGeNA2Tp5TCvA1?=
 =?us-ascii?Q?z286WBhbHvEv3IXNmJW1WZjLF6XKKieCUVwcsHink2LJ8N2fVtJ9oe6RsDiy?=
 =?us-ascii?Q?W5d/oYvAA3HLmO8VV6wWCOM/vuTMvnzLQniWvfXQikUU1fnc3UDrzPbBqBT5?=
 =?us-ascii?Q?PzQlInelV3wygIY9Ibdm0tLTsuE6a4s2IgqjJS8ZQKJDjmF/yZfyhNFiafvZ?=
 =?us-ascii?Q?yXpYrJWdc2Ib6XpLiDOoDx6gSgUe+LNzWIf8aEOfk3Ec34F+s9PvPSJlY4tr?=
 =?us-ascii?Q?Ai8G06gibLwfAPZ0T0sqGUj5LwuJKQZKWG4hkpIRROirlkDAPfwHaI9xhAxQ?=
 =?us-ascii?Q?SecdMVgFhjlK6ILDNd1TR1y19GW4Fet8Jj0g8EvCEB/rSblRMrRPyHGp2Y7i?=
 =?us-ascii?Q?PKmGUAWUNclq+J3y5fmOC+Z80BMhrYhe2YZkiKYeGHsFC0n7lS0G6mtgGtrq?=
 =?us-ascii?Q?CQnJTn9HIj5lsPYBFS6A5u9PMYKPN2RTJDD2/qBCSJOTSAJWoMJi76ofdoPg?=
 =?us-ascii?Q?GRLy6F49+PKJ+IVIVZ3IbOYmUb9X476A20Igtu6/yJamnAo1LWQfC712lu/5?=
 =?us-ascii?Q?fXjTBYu516Pr07/hxflZU/VjWOwQzxDOF496eB7er3U2r1KmlLiKk85+zBKt?=
 =?us-ascii?Q?Prtxa5U8YhEhjJgoRtrQDMWrKtmT55nnNFEx8Yuw7o+QufepfPTowMHzBuxm?=
 =?us-ascii?Q?XJX9Y+tKsXftzRv7MYRbfZnRLTsBnAQ28/Ou9QhpnGixxvXlcYCzdXiS9db6?=
 =?us-ascii?Q?Gta+42vNlQbimoVkh2lH9WCdgv0psCZGnJ6jxeO6plF6unwIJxFU96BqXmUR?=
 =?us-ascii?Q?KUE3Kddhdnkmw6BOj2vIDL3KbOxEKOJyOmVVDnmgLcUBa5OAIYqw8iqsd2cc?=
 =?us-ascii?Q?/AZWoc6qNaaUkC3MROYLjAFct7dX2neTMigRlfBAeeuO4Vwoy9WRCsg6uWb6?=
 =?us-ascii?Q?pe5I5+z1uwU7cCtAyCbjey1rm6nM7MZN42aTQe0TwCR3Ls/bojV1OsqXhGNV?=
 =?us-ascii?Q?z9Dh/ClMHjoFtJm7Lb7TVUb1QyYmsTtn4neA8IHUhBvtOaFu9Mu9+TQ0NlKc?=
 =?us-ascii?Q?ee+/1QOg28Wkd9YH06ZXq/9884L71zHoHP2OOg/oklvBVpw4Rjv1+ZxGZmgI?=
 =?us-ascii?Q?jHamteZxX5ldBocOIj+yr6aFOg/Xcs44V+xQZpUkpwJKN/ojgK/jXwhSEExy?=
 =?us-ascii?Q?PCD4Uob+so7b9aRkxNjQXIZg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de28f9b-060c-4a32-351e-08d8f405dbe3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 05:28:47.0684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7Z8GnCFbEsQPyXdoy9T/lUf6wgY0aoZOUOUdnp5L877vzMzGdjFeNuRechi65kZM0Re2MP7juitRwYkJDLXAY4PYIVAjdMpntb8315evsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5611
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Thank you for your time in reviewing the patch.

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Monday, March 29, 2021 6:37 PM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>
> Cc: bhelgaas@google.com; robh+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com; maz@kernel.org;
> gustavo.pimentel@synopsys.com
> Subject: Re: [PATCH v8 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> [+ Marc, Gustavo]
>=20
> On Thu, Feb 18, 2021 at 07:47:57AM +0530, srikanth.thokala@intel.com
> wrote:
> > +static irqreturn_t keembay_pcie_irq_handler(int irq, void *arg)
> > +{
> > +	struct keembay_pcie *pcie =3D arg;
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct pcie_port *pp =3D &pci->pp;
> > +	u32 val, mask, status;
> > +
> > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > +	mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > +
> > +	status =3D val & mask;
> > +	if (!status)
> > +		return IRQ_NONE;
> > +
> > +	if (status & MSI_CTRL_INT)
> > +		dw_handle_msi_irq(pp);
> > +
> > +	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int keembay_pcie_setup_irq(struct keembay_pcie *pcie)
> > +{
> > +	struct dw_pcie *pci =3D &pcie->pci;
> > +	struct device *dev =3D pci->dev;
> > +	struct platform_device *pdev =3D to_platform_device(dev);
> > +	int irq, ret;
> > +
> > +	irq =3D platform_get_irq_byname(pdev, "pcie");
> > +	if (irq < 0)
> > +		return irq;
> > +
> > +	ret =3D devm_request_irq(dev, irq, keembay_pcie_irq_handler,
> > +			       IRQF_SHARED | IRQF_NO_THREAD, "pcie", pcie);
> Mmm. What's this "pcie" line is actually signaling ? It looks like
> MSIs are reported through it and for that AFAIK the dwc core should
> set-up a chained IRQ in the core code unless the pcie_port->msi_irq is
> set (which is what this driver does).

Yes, your understanding is correct.  This ISR will handle MSI interrupts.

>=20
> If DWC core code can't handle this host controller MSI logic, the
> MSI handling should be setup as a chained IRQ, not an IRQ action,
> this is an IRQ layering issue/abuse that came up in the past,
> I don't want to add more core that relies on it.

Ok, I see your point.
I will make necessary changes for the next version of the patch.

Thanks!
Srikanth

>=20
> Lorenzo
>=20
> > +	if (ret)
> > +		dev_err(dev, "Failed to request IRQ: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
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
> > +	int ret;
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
> > +	ret =3D keembay_pcie_setup_irq(pcie);
> > +	if (ret)
> > +		return ret;
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
