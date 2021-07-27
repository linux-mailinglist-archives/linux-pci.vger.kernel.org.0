Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0113D7AE8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhG0Q1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 12:27:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:33597 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0Q1a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jul 2021 12:27:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="210593702"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="210593702"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="665496173"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2021 09:26:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 09:26:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 09:26:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 09:26:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9Au3rTDMJBTomK70EgvBDQk94kPp7Dy4AI6gGnz3Oc21e8MswsokCbLvMtOFOJep8zfWLD6RF9Sg1CWibvnR/Ewg9X7xsp+O5y3ap56ZUmMmjtPQMHkAkvjrJEVlL3Ulj9ywCRbkGyuGuxgWHqrxo7Jbpn3aW9PDScdZW1Z5lXntS/MTraTsvQePUBAbM+YsiaUHbzb3Ib316BQ+OTx2ffueDQ//06jJX2UHS5SYcZ5rV37cbqGlgKOKyGeJn9OTdJoLIndB1rHsS9tJRDfJhhcBm8Lnh3ceCfBNUyUGQa4Nzt+zPAwy1+gZOmmpmYbrSgIYXGyNJC/vYgY93r5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MJR3oPYwtoyXJVZRkdF9NHbQdB8LBpDGcvx0DzKkJg=;
 b=H16NFqiAvNVg/e/s+vm2Z+hLD2/QGa/SByqfUe62EPvU1NAszAFWJbo+CyITrb8bTTG4oir/GFTETgpAx92Ju2xMgfCY7b6uyMnNn3RfC0yYe0rgvcAK+3iJls0uaLeT2wdFg/hHm27LY862VHBGD1iv7I7gfAMGWC60LQ4RZcDBMS/yjSR/D++GpUKIiEp3FHXzXLGR9ZY6Jq/d1m+Pmjiq3Z396vDos52pNjHTZFfztFi4kzs43D8t7nzOzuh3/sqPrmhOqwt48/ENw9gMS+UeFqbH63YN5Cjf1HvLYONQvAfoOgER8QCZfkevJyYoUMG/Z78xRwPuF6b400LHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MJR3oPYwtoyXJVZRkdF9NHbQdB8LBpDGcvx0DzKkJg=;
 b=m/L0Gu/KiWz6dBB3ztFdCW1uZ+wqjIEUcOG/S6MUhQcXfT5u0Yi+n4Z2cnK7JLc7ZNyZrHruAi1PhEA7N68y9JZdBLZsGjFkiR2RYK5B85Qp0D3/4DT93WL3pe39g7+6XSy6ZmKT2np3Hsx0gIE20o2+MiTeIRs4Vd3QjeK/UFk=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5659.namprd11.prod.outlook.com (2603:10b6:510:ea::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 16:26:49 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::947f:429f:312b:c530]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::947f:429f:312b:c530%4]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:26:49 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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
        "kw@linux.com" <kw@linux.com>
Subject: RE: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXW3FV4CKL56K+SEOKbFusTp+FKasexPQAgASQnFCAMdwdgIABsktQ
Date:   Tue, 27 Jul 2021 16:26:48 +0000
Message-ID: <PH0PR11MB55951E4C4F85E37D35201BD785E99@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
 <20210621162506.GA31511@lpieralisi>
 <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
 <2e4554241c532f03cce30beaf7b9921f@kernel.org>
In-Reply-To: <2e4554241c532f03cce30beaf7b9921f@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e03ace1-8c2a-4a1f-4653-08d9511b5589
x-ms-traffictypediagnostic: PH0PR11MB5659:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5659B73C33542CE1A41F7EC885E99@PH0PR11MB5659.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxezruNsWNB/KXhLB7ybU37nMwQh1mSDHOx99knGrWQc4+BM5U1rSjp3hDajdhUhhOrMjcY16wEVKP/uPu2z6CoJ3WWypTS8ydtnVDcaL6mWv5LbpdE5NLaHsTHrbnCNLLswkBUHmnK6Gf23bi8DucykVPsYbHxzAiHP9FkSpnCil8UPmnXqJyeR5NJ8BoTmNf2p/SaNwZ3x8i/ki4yVH3do6gzyDIf8IAXnTvqJivzpnh53YoVLrsc1y0uUib0FTj2Z/wNKGZetdCswkReMMNlBt8jS0wDic3Uv5iOs7ncnOnu5lGphVBDUbpAOxNtyLD6x1gd3MLarF1k0k1DlZUIpC44G3jeUC5RndNFL9eHNX5XsRZQTKoYT/3hR11AI2EiAcHD/m2bwz8KoXvNCrFhnM48bHHcb6rNMVsg2l9/Yn6/5B+I2jtR8X3V0JVbV6joFpsRk61n82dK0GK+xMqUBm5MphHqGqRXCLG4laC4eLKSB/xp/lUPb5mcCqy+sbgRGgRMfpyUyWZSDtx7FIPMpLyhmE+uu2Hw6BupY2QBF7V/BzN8PV3lWeRuBOV9CsZDFccSe/+/cdz1sEeM88n6gUJj1OKp5J6uw0AvkwN4cQhw87jxd1AH5+I8SA5n/Iua8gfzm0oTzOOWozuy4QfMrxXXNGtphJS0Dxyyl9XYdJSPbcOjdFmUMvggyihSxabT290WLIoFIT2/QpxpAZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(8676002)(7696005)(66946007)(66556008)(66446008)(2906002)(71200400001)(26005)(122000001)(38100700002)(52536014)(186003)(33656002)(4326008)(6916009)(66476007)(508600001)(316002)(9686003)(8936002)(54906003)(5660300002)(55016002)(83380400001)(64756008)(6506007)(86362001)(53546011)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+1TlyUnxgMqcDINiE/HsPC3NEMDUR2LjvM+GQAyT66nyARSDSLdUnx0Pqesb?=
 =?us-ascii?Q?eKomb8S8GEasWaytmPRvRPqlV8e2bTSq5516lrSkl5xU0uXKUfu70V76NKXo?=
 =?us-ascii?Q?EwU9l9QutB/GDERn/hBy0ZlMsL9bQpYB4SEi8AbUaQxGLXIqzUPCvzF1v2pM?=
 =?us-ascii?Q?LTSStdSQbz8wWOQNfKSLRZHtmFzPzDBKTuAXNNCjKIlKnhNWLKy5IRKO5hST?=
 =?us-ascii?Q?81ZjWkYQ0q6eoPI7dX0jeDkwXEolslvt8u5vhu/m4wA6THbuDqDp+JuCGpQQ?=
 =?us-ascii?Q?tazg/l+W2oXLghJkWnLly9jLHnBnYixXfcwEFweI1okN6igzw4cYRzsJzQzc?=
 =?us-ascii?Q?f7YfJFwR7njMr9Nsx2vhR3yXzYt+5eGLRyz+/iKM6ZsZCX0uCnQlfB38BRzP?=
 =?us-ascii?Q?l0Mb/NivFXXPnUWHGVpBycQ46eo73+SMhmX1s6jG69LK4gcP2nNxwqQVu+X+?=
 =?us-ascii?Q?5MW+BFR3v8EyRf+hyhhRTo5l2OAN4GhartcciwOcNrv2VmJ4xJOCfQ19RHiv?=
 =?us-ascii?Q?h44XtG9RMHEtFbrCqIuS1uG9mLg/mzAzD3GQBUmKyF1RaqKQYwAeOuH7GT7w?=
 =?us-ascii?Q?nsfOFfhttp4uJuMSz4S8gFGi2yGQjPVRWXJkKNct5a+3PU61ea+m8o2nMqAA?=
 =?us-ascii?Q?nX7kVgQoG4yslVDNgGZXcOrPi1T167ZBURyc/uDY4auJKBcsD7Roe2i0s2Uf?=
 =?us-ascii?Q?k8iNR4pByswSZ7f2B00NZw4OHX4I97/his/gErK6s5szFRri5byOUfpUlQU2?=
 =?us-ascii?Q?bIAzHsY7v+Ml+JTRJEmxBSa5/EMm2r6v+qW8BoMyTsKagl1mlvnffpUAo3M8?=
 =?us-ascii?Q?+SHlCG/WNnV3EktO1mqQ9H2vBQNhCzJ/IhA0FE9qHo5FnbSJNweLid9ospNY?=
 =?us-ascii?Q?DBRCdET9Om4bBaIs2scOE0kPQWonLJRQEV3O9VxRN8UG/EZCJ6lwKjK9YrdE?=
 =?us-ascii?Q?xq0so6B9XwObu+qWvZ22hDnSALOdXtY1vULACaBoxPhHncmZlnDXPROJU58l?=
 =?us-ascii?Q?gUiX9uOFas4YdF2/HdZCT+87P2qIitTR87n3sWVXBLFCXCNnALwU+f+FA3j9?=
 =?us-ascii?Q?miiFB/hY9DE3waAB8ujQ5JrLbX92yN1VwVdzgTHC18KqCGz5dpNAAcmrcE6q?=
 =?us-ascii?Q?QVvM5dItRcVkVQp5aN1bq3Li/U616yHd3KtaSIa5/99PN0hxCOVWYdipQ/V0?=
 =?us-ascii?Q?RqMLvy9x4PZ5D6Unz+cmBpQ/2phfBrif9DLF/vh3oR29UixgMDfW7ba+bv3n?=
 =?us-ascii?Q?tzj09PgRkA/dMg/pmv+Gtcoy4NIs1mXmj6Kyuwmkqkau8WM2pVWN0bnv5hhc?=
 =?us-ascii?Q?OaBgOO+8eOTjTm+ZVLq7uux9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e03ace1-8c2a-4a1f-4653-08d9511b5589
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:26:48.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ld/Zc+uYkN1MLbL64f5w6ifUaI8ZAWqNjcjKvbZH1WoWIH34cfOQx6AslcAkxKxTvSX0Lm4FktMSDULWrjW3oo+w7FZT1mjRsUL0Iwf5ZT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5659
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Monday, July 26, 2021 1:30 PM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; robh+dt@kernel.org;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>;
> kw@linux.com
> Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem
> Bay
>=20
> On 2021-06-25 04:23, Thokala, Srikanth wrote:
> > Hi Lorenzo,
> >
> >> -----Original Message-----
> >> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >> Sent: Monday, June 21, 2021 10:23 PM
> >> To: Thokala, Srikanth <srikanth.thokala@intel.com>; maz@kernel.org
> >> Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> >> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> >> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> >> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> Mallikarjunappa
> >> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> >> Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel
> Keem
> >> Bay
> >>
> >> [+Marc]
> >>
> >> On Mon, Jun 07, 2021 at 09:10:44PM +0530, srikanth.thokala@intel.com
> >> wrote:
> >> [...]
> >>
> >> > +static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
> >> > +{
> >> > +	struct keembay_pcie *pcie =3D
> irq_desc_get_handler_data(desc);
> >> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> >> > +	u32 val, mask, status;
> >> > +	struct pcie_port *pp;
> >> > +
> >> > +	chained_irq_enter(chip, desc);
> >> > +
> >> > +	pp =3D &pcie->pci.pp;
> >> > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> >> > +	mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> >> > +
> >> > +	status =3D val & mask;
> >> > +
> >> > +	if (status & MSI_CTRL_INT) {
> >> > +		dw_handle_msi_irq(pp);
> >> > +		writel(status, pcie->apb_base +
> PCIE_REGS_INTERRUPT_STATUS);
> >> > +	}
> >> > +
> >> > +	chained_irq_exit(chip, desc);
> >> > +}
> >> > +
> >> > +static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
> >> > +{
> >> > +	struct dw_pcie *pci =3D &pcie->pci;
> >> > +	struct device *dev =3D pci->dev;
> >> > +	struct platform_device *pdev =3D to_platform_device(dev);
> >> > +	int irq;
> >> > +
> >> > +	irq =3D platform_get_irq_byname(pdev, "pcie");
> >> > +	if (irq < 0)
> >> > +		return irq;
> >> > +
> >> > +	irq_set_chained_handler_and_data(irq,
> keembay_pcie_msi_irq_handler,
> >> > +					 pcie);
> >> > +
> >>
> >> Ok this is yet another DWC MSI incantation and given that Marc
> worked
> >> hard consolidating them let's have a look before we merge it.
> >>
> >> IIUC - this IP relies on the DWC logic to handle MSIs + custom
> >> registers to detect a pending MSI IRQ because the logic in
> >> dw_chained_msi_irq() is *not* enough so you have to register
> >> a driver specific chained handler. This looks similar to the dra7xx
> >> driver MSI handling but I am not entirely convinced it is needed.
> >>
> >> I assume this code in keembay_pcie_msi_irq_handler() is required
> >> owing to additional IP logic on top of the standard DWC IP, in
> >> particular the PCIE_REGS_INTERRUPT_STATUS write to "clear" the
> >> IRQ.
> >>
> >> We need more insights before merging it so please provide them.
> >>
> >> pp =3D &pcie->pci.pp;
> >> val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> >> mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> >>
> >> status =3D val & mask;
> >>
> >> if (status & MSI_CTRL_INT) {
> >> 	dw_handle_msi_irq(pp);
> >> 	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> >> }
> >
> > Yes, your understanding is correct.
> >
> > Additional registers PCIE_REGS_INTERRUPT_ENABLE/_STATUS are provided
> > by IP to control the interrupts.
> >
> > To receive MSI interrupts, SW must enable bit '8' of _ENABLE
> register.
> > And once a MSI is raised by the End point, bit '8' of _STATUS
> register
> > will be set and it needs to be cleared after servicing the interrupt.
>=20
> What isn't clear here is whether the other bits that are written back
> are significant and have a side effect. If only bit 8 is required,
> shouldn't you *only* write this bit back?
>=20
> Only you can know the answer to this, but it would be good if you
> could actually document this deviation from the already wonky
> DWC infrastructure.

SW will only unmask MSI Interrupt i.e. bit '8' in the 'INTERRUPT_ENABLE'
register during the Root Port initialization, other bits of this register
are not significant in this mode.

Thanks!
Srikanth

>=20
> Thanks,
>=20
>          M.
> --
> Jazz is not dead. It just smells funny...
