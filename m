Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC713D5326
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 08:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhGZFuc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 01:50:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:33155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhGZFua (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 01:50:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="199410019"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="199410019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 23:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="579264304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2021 23:30:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 25 Jul 2021 23:30:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 25 Jul 2021 23:30:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 25 Jul 2021 23:30:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 25 Jul 2021 23:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxyN/llkWTJsWaC8w2R5b66A0Xl5fuvaAxKbclvsVtqUI0a/iSy7qDTIL/lnnfIVR1XR103A6jzQsuwPVI/x+CGDdiL2bYctXveH73MIBwrykTWsmoyMkDMKaE/JuDSi3Qcr2Qesni6Cx/ilxhuMVwa+No/Qp7vNvIC9A3rWDGW+HqNQILyRZZOyWQfdX+IbYrDzxyfja1mu1RZ02SY/LfBncbpN8mQxIIVErWfkHDLElJalphSnVjqv9S4kugiSIwJY7X9OlRpS6x2I9aPnHePenlqRDRj7UMsJd3S2oLRY7nQvxhh1GV5J+yIWYRxlAg3s5wAWO6tJr7glSLrAuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbMfe+Y8Jxcu0T7Ge7xiVpVb/Kj9sJTu3M6yF7HFOSE=;
 b=h57FZj0QiZgeA96kOKvvdph2yk9Pg44nqkr2lbzAjAux92nRwCr6GEVXo2dtFMWVe0nnz/z6Uba/lNP/1tguhOfFXNiJz0P78WTOnIL5sJ70XFhz6Hr8IUvLb9jPcOBEuiRn+dVfFuSDtesV5PqTs5j5IlNIiceL2PIuJqg+iVhYYYPyJAw8PxtH+KHyhxrijuWZtsoai1s+8EsDjyOo9duG1qwSG0rIoo/MRqF3MamdTBCEN5w6fe3RCfeaiMiV8AgFPSvLM0GDqt+bY8JdFdr7GyVUEUdaMs3FqJjqCGuF5rAgK2QqopdHm21WlA7PkquGWjm92mUdoVwJ8DTJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbMfe+Y8Jxcu0T7Ge7xiVpVb/Kj9sJTu3M6yF7HFOSE=;
 b=lLBa7K8EbwkqMnC9xieAzlq31ndNh+llVUU35Aw/u+kW85gPggyuj8nnDVxF9N9D4l/6zZFbaHxq/SGap3933gN+A3qc+AjDN3ERBZMSfbXoHaElweEV9tX2YgL5IeR1J/ROxd/w7WH9IcecvAq6MSzs4EFzcMAvtaTyJdsrJ0k=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5628.namprd11.prod.outlook.com (2603:10b6:510:d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 06:30:55 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::947f:429f:312b:c530]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::947f:429f:312b:c530%4]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 06:30:55 +0000
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
Thread-Index: AQHXW3FV4CKL56K+SEOKbFusTp+FKasexPQAgASQnFCAEpouoIAfKJyA
Date:   Mon, 26 Jul 2021 06:30:55 +0000
Message-ID: <PH0PR11MB5595DD61534273C151718D0E85E89@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210607154044.26074-1-srikanth.thokala@intel.com>
 <20210607154044.26074-3-srikanth.thokala@intel.com>
 <20210621162506.GA31511@lpieralisi>
 <PH0PR11MB559558D60263F29C168E6C5185069@PH0PR11MB5595.namprd11.prod.outlook.com>
 <PH0PR11MB55950B723B19DDE38E408380851A9@PH0PR11MB5595.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB55950B723B19DDE38E408380851A9@PH0PR11MB5595.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 074c32b9-8929-4d71-5b16-08d94ffeec8f
x-ms-traffictypediagnostic: PH0PR11MB5628:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB56286B6D0AC9EF48B5A13D0285E89@PH0PR11MB5628.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WFWE/n9pBgDQvg3GbdMYIMzfl8i/nBFOumNwDVFIza1xG12vCUS8lKA+35dQx0uYAbeoEWq+kqbyUGrGWfL32MkJNtN8t7C7vZl/R6tWuwHBLRjIhdgSXCF2sYZ9AIGcr0FtJ11VhIIHat1dAWgRhX4lsNk6951xAp4tEHQLMA4G6EHwulAS8TcSJ4ZI1pg6B6did/pRQnUQ3yObmwJo1yJSl4UEXSTxZwvzb7R9ywQC3eG0/FKIKJ+y+VW6adHgdVFI8TV+aEB3TfDV/aN62bLnVriFYV2ARhOxDV25aM33kmpTZ3JadIpgrljSipiBoTYMEeiQ8GSpZkHxR9AYmZp75MvgP9ROlYXMWVBJTIRG1EuYyURp/c4QGwvyW+HJBfsHTlcH//qNUmZT/fTTApa7Mw8LLKKFhjXW6papsoC7SzsitCHNehczYPXNSR+fOHkNHnKUrHtNZETjSsJhVpAeox98GZNMleT4bjJeXVxe46ChnIXJ1N4jvftDNwJ90J0eGasBZ7y39rklhwcf0aEYlY5pjOWh5e9WugljKtMysi/EA9fwjk9KyLWqyH/VaCVYvgVLGi+Uu8zVvXJjEhKpJg1+OXayxxvmc877VDONEUiFPoPtgC/kLSGIDKZO/rZf4TaY02WKpcBUi7Mq2V4o/FsVnJtcUTJiO7Y+ti0VvJqAR7p/WRLOB/0AuAplIwp7YnOe1kcU/71ZTr/P+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(7696005)(478600001)(30864003)(6506007)(53546011)(66946007)(122000001)(38100700002)(186003)(9686003)(8936002)(2906002)(76116006)(26005)(8676002)(86362001)(110136005)(54906003)(71200400001)(5660300002)(4326008)(64756008)(66556008)(66446008)(66476007)(55016002)(33656002)(52536014)(83380400001)(316002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OfrTlGW0XPDiAyZqoqMK8CnVvtjbJ9Ik55gU3g7evXu8JzrDgor2weYLBtBm?=
 =?us-ascii?Q?EVsTNBAWbwFiz0+bPOWwx1ZSZvtTYi9GhsA5Ont+ZFn171NAanzcYKBtF00R?=
 =?us-ascii?Q?CqF5aZ/+CC1WlTlmVsa8CqYzJrHklQXgCyKrLlTW3B0UhvFmntvAammcjmwz?=
 =?us-ascii?Q?kx9tYSSFjbFzvbEY+KEE4Q3hadvipdFbBUbAWrW+3nEwMT5NBRD21ZMKtVMi?=
 =?us-ascii?Q?gEdPY4Z/SYVnp55a4wlEeS5GTUE361adTqGqs03PqmKd2d98h1A8j7iQNAkU?=
 =?us-ascii?Q?8zQhHiXAtmxjC2q6/YZ0wMuRdcUc4gkoHRIVNNpi5oaDsT4rp5UdLALt2WSK?=
 =?us-ascii?Q?TLVjD24oxnR94SUfcN1h0QQg9ysTUS5v+w/eG79G929kV21u9PrI8IM6u9LS?=
 =?us-ascii?Q?tRQta8e/2osL5KTkCGd5Inv9jAU1j+6rZoADFun1Q/SyXKoCoggqcZe3nmY1?=
 =?us-ascii?Q?8+bKe1o0FAGEGqOlbiAV6Q7RWbHcTobTvMIb92W3yhoy8DiNFQ/x1kfA5iaw?=
 =?us-ascii?Q?b00j/3Pqt7KHMHS50SDmtN+muuZi+yzeWt1yQIbp52x1ZjlbREBazS5mv95x?=
 =?us-ascii?Q?F+G3SkRIVSFUyZHXpnbouCx2xjFGW/LepHLxaVdjS9cY0CkNuiSijZ7IyT9x?=
 =?us-ascii?Q?sSVD38W7F9LrHd+3cXTmppVrWvLHIwuDSLZMtw4gvKK+J5CVwnHZMcSBd60n?=
 =?us-ascii?Q?65oy3uTGnb5dIbXqOOzaHDrmbxNZJO3uVbyimZnvU9j1W/ln+IuAFHg2VZhV?=
 =?us-ascii?Q?j3rO14bMdAoJTcl9r1iVa0SMlj7WvdG8P3xacvmIvZjJtggz5Jx/StymiPKW?=
 =?us-ascii?Q?YoB3ABwrcFm8UFvkOMZn527OqwmaH5+o0wGyLZdvq9bJzPw2WpSMp3ZCSHGF?=
 =?us-ascii?Q?TN4CM8bpOCavnQ5XayLeK5FuKGWF+fSnGl+QNw+95f1zK2GulzT+wawDLmDz?=
 =?us-ascii?Q?DxKrNIjvYA5PgWf3ypl6oT3CT7f3yUo9SVqSfph3xHlc+2S0bjD6v8CV/4VW?=
 =?us-ascii?Q?pC1z/SQa50/fiNoW5VU1f6hqf+KEP1C6BoUpsPHiuwt4O8lNEuJ35Z6vr1xe?=
 =?us-ascii?Q?XFx7F3KcADlesyMURouMQDoBoQDaqtO9fi3TfV+Aqs/F7WK9HT9iEdrHdYsJ?=
 =?us-ascii?Q?JPg+lVJPlLXIZNuO8lRiucHYXhK/UAd4XlSKC3dTMoubqvWHVU54j23IQksp?=
 =?us-ascii?Q?Qjp8SRa5D58ErJAGKwRCEZOrG0rwm1siO/lrsi4tCTeWlt59XDpTrHN6HCvR?=
 =?us-ascii?Q?0bBt7xgS0AosyYpa3j9hLu3lD9KiQiy7krfrtGce5oYQ/QemkaDpV4X1YtR5?=
 =?us-ascii?Q?jiF6yOKsMRVTX9WkjAvQ6pB3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074c32b9-8929-4d71-5b16-08d94ffeec8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 06:30:55.7217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: el+S7oAdwn1HwobFefUmzWgZsht1YZJ6LP1+qqpvHlyzz+QjhrqGZDXX8QTW9CtyEAj/NP6nAi+DPIw9lr1sKgq/Po5WFeYPsz7erzbP128=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5628
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo and Marc,

> -----Original Message-----
> From: Thokala, Srikanth
> Sent: Wednesday, July 7, 2021 5:25 PM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; maz@kernel.org
> Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> Subject: RE: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem
> Bay
>=20
> Hi Lorenzo and Marc,
>=20
> > -----Original Message-----
> > From: Thokala, Srikanth
> > Sent: Friday, June 25, 2021 8:54 AM
> > To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; maz@kernel.org
> > Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> > devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> > mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> > <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> > Subject: RE: [PATCH v10 2/2] PCI: keembay: Add support for Intel Keem
> > Bay
> >
> > Hi Lorenzo,
> >
> > > -----Original Message-----
> > > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Sent: Monday, June 21, 2021 10:23 PM
> > > To: Thokala, Srikanth <srikanth.thokala@intel.com>; maz@kernel.org
> > > Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> > > devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> > > mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> > > <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar,
> > Mallikarjunappa
> > > <mallikarjunappa.sangannavar@intel.com>; kw@linux.com
> > > Subject: Re: [PATCH v10 2/2] PCI: keembay: Add support for Intel
> Keem
> > Bay
> > >
> > > [+Marc]
> > >
> > > On Mon, Jun 07, 2021 at 09:10:44PM +0530,
> srikanth.thokala@intel.com
> > > wrote:
> > > [...]
> > >
> > > > +static void keembay_pcie_msi_irq_handler(struct irq_desc *desc)
> > > > +{
> > > > +	struct keembay_pcie *pcie =3D
> irq_desc_get_handler_data(desc);
> > > > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > > > +	u32 val, mask, status;
> > > > +	struct pcie_port *pp;
> > > > +
> > > > +	chained_irq_enter(chip, desc);
> > > > +
> > > > +	pp =3D &pcie->pci.pp;
> > > > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > > > +	mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > > +
> > > > +	status =3D val & mask;
> > > > +
> > > > +	if (status & MSI_CTRL_INT) {
> > > > +		dw_handle_msi_irq(pp);
> > > > +		writel(status, pcie->apb_base +
> > PCIE_REGS_INTERRUPT_STATUS);
> > > > +	}
> > > > +
> > > > +	chained_irq_exit(chip, desc);
> > > > +}
> > > > +
> > > > +static int keembay_pcie_setup_msi_irq(struct keembay_pcie *pcie)
> > > > +{
> > > > +	struct dw_pcie *pci =3D &pcie->pci;
> > > > +	struct device *dev =3D pci->dev;
> > > > +	struct platform_device *pdev =3D to_platform_device(dev);
> > > > +	int irq;
> > > > +
> > > > +	irq =3D platform_get_irq_byname(pdev, "pcie");
> > > > +	if (irq < 0)
> > > > +		return irq;
> > > > +
> > > > +	irq_set_chained_handler_and_data(irq,
> > keembay_pcie_msi_irq_handler,
> > > > +					 pcie);
> > > > +
> > >
> > > Ok this is yet another DWC MSI incantation and given that Marc
> worked
> > > hard consolidating them let's have a look before we merge it.
> > >
> > > IIUC - this IP relies on the DWC logic to handle MSIs + custom
> > > registers to detect a pending MSI IRQ because the logic in
> > > dw_chained_msi_irq() is *not* enough so you have to register
> > > a driver specific chained handler. This looks similar to the dra7xx
> > > driver MSI handling but I am not entirely convinced it is needed.
> > >
> > > I assume this code in keembay_pcie_msi_irq_handler() is required
> > > owing to additional IP logic on top of the standard DWC IP, in
> > > particular the PCIE_REGS_INTERRUPT_STATUS write to "clear" the
> > > IRQ.
> > >
> > > We need more insights before merging it so please provide them.
> > >
> > > pp =3D &pcie->pci.pp;
> > > val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > > mask =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > >
> > > status =3D val & mask;
> > >
> > > if (status & MSI_CTRL_INT) {
> > > 	dw_handle_msi_irq(pp);
> > > 	writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS);
> > > }
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
> Hope I have provided all the necessary information.
> Kindly feedback.

Kindly feedback.

Thanks!
Srikanth

>=20
> Thanks!
> Srikanth
>=20
> >
> > Thanks!
> > Srikanth
> >
> > >
> > > Thanks,
> > > Lorenzo
> > >
> > > > +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> > > > +{
> > > > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > > > +
> > > > +	writel(EDMA_INT_EN, pcie->apb_base +
> PCIE_REGS_INTERRUPT_ENABLE);
> > > > +}
> > > > +
> > > > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8
> > func_no,
> > > > +				     enum pci_epc_irq_type type,
> > > > +				     u16 interrupt_num)
> > > > +{
> > > > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > > > +
> > > > +	switch (type) {
> > > > +	case PCI_EPC_IRQ_LEGACY:
> > > > +		/* Legacy interrupts are not supported in Keem Bay */
> > > > +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> > > > +		return -EINVAL;
> > > > +	case PCI_EPC_IRQ_MSI:
> > > > +		return dw_pcie_ep_raise_msi_irq(ep, func_no,
> > interrupt_num);
> > > > +	case PCI_EPC_IRQ_MSIX:
> > > > +		return dw_pcie_ep_raise_msix_irq(ep, func_no,
> > interrupt_num);
> > > > +	default:
> > > > +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> > > > +		return -EINVAL;
> > > > +	}
> > > > +}
> > > > +
> > > > +static const struct pci_epc_features keembay_pcie_epc_features =3D
> {
> > > > +	.linkup_notifier	=3D false,
> > > > +	.msi_capable		=3D true,
> > > > +	.msix_capable		=3D true,
> > > > +	.reserved_bar		=3D BIT(BAR_1) | BIT(BAR_3) |
> BIT(BAR_5),
> > > > +	.bar_fixed_64bit	=3D BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> > > > +	.align			=3D SZ_16K,
> > > > +};
> > > > +
> > > > +static const struct pci_epc_features *
> > > > +keembay_pcie_get_features(struct dw_pcie_ep *ep)
> > > > +{
> > > > +	return &keembay_pcie_epc_features;
> > > > +}
> > > > +
> > > > +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops =3D {
> > > > +	.ep_init	=3D keembay_pcie_ep_init,
> > > > +	.raise_irq	=3D keembay_pcie_ep_raise_irq,
> > > > +	.get_features	=3D keembay_pcie_get_features,
> > > > +};
> > > > +
> > > > +static const struct dw_pcie_host_ops keembay_pcie_host_ops =3D {
> > > > +};
> > > > +
> > > > +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> > > > +				      struct platform_device *pdev)
> > > > +{
> > > > +	struct dw_pcie *pci =3D &pcie->pci;
> > > > +	struct pcie_port *pp =3D &pci->pp;
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	u32 val;
> > > > +	int ret;
> > > > +
> > > > +	pp->ops =3D &keembay_pcie_host_ops;
> > > > +	pp->msi_irq =3D -ENODEV;
> > > > +
> > > > +	ret =3D keembay_pcie_setup_msi_irq(pcie);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	pcie->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> > > > +	if (IS_ERR(pcie->reset))
> > > > +		return PTR_ERR(pcie->reset);
> > > > +
> > > > +	ret =3D keembay_pcie_probe_clocks(pcie);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> > > > +	val |=3D PHY0_SRAM_BYPASS;
> > > > +	writel(val, pcie->apb_base + PCIE_REGS_PCIE_PHY_CNTL);
> > > > +
> > > > +	writel(PCIE_DEVICE_TYPE, pcie->apb_base +
> PCIE_REGS_PCIE_CFG);
> > > > +
> > > > +	ret =3D keembay_pcie_pll_init(pcie);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	val =3D readl(pcie->apb_base + PCIE_REGS_PCIE_CFG);
> > > > +	writel(val | PCIE_RSTN, pcie->apb_base +
> PCIE_REGS_PCIE_CFG);
> > > > +	keembay_ep_reset_deassert(pcie);
> > > > +
> > > > +	ret =3D dw_pcie_host_init(pp);
> > > > +	if (ret) {
> > > > +		keembay_ep_reset_assert(pcie);
> > > > +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	val =3D readl(pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > > +	if (IS_ENABLED(CONFIG_PCI_MSI))
> > > > +		val |=3D MSI_CTRL_INT_EN;
> > > > +	writel(val, pcie->apb_base + PCIE_REGS_INTERRUPT_ENABLE);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int keembay_pcie_probe(struct platform_device *pdev)
> > > > +{
> > > > +	const struct keembay_pcie_of_data *data;
> > > > +	struct device *dev =3D &pdev->dev;
> > > > +	struct keembay_pcie *pcie;
> > > > +	struct dw_pcie *pci;
> > > > +	enum dw_pcie_device_mode mode;
> > > > +
> > > > +	data =3D device_get_match_data(dev);
> > > > +	if (!data)
> > > > +		return -ENODEV;
> > > > +
> > > > +	mode =3D (enum dw_pcie_device_mode)data->mode;
> > > > +
> > > > +	pcie =3D devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > > > +	if (!pcie)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pci =3D &pcie->pci;
> > > > +	pci->dev =3D dev;
> > > > +	pci->ops =3D &keembay_pcie_ops;
> > > > +
> > > > +	pcie->mode =3D mode;
> > > > +
> > > > +	pcie->apb_base =3D
> devm_platform_ioremap_resource_byname(pdev,
> > "apb");
> > > > +	if (IS_ERR(pcie->apb_base))
> > > > +		return PTR_ERR(pcie->apb_base);
> > > > +
> > > > +	platform_set_drvdata(pdev, pcie);
> > > > +
> > > > +	switch (pcie->mode) {
> > > > +	case DW_PCIE_RC_TYPE:
> > > > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> > > > +			return -ENODEV;
> > > > +
> > > > +		return keembay_pcie_add_pcie_port(pcie, pdev);
> > > > +	case DW_PCIE_EP_TYPE:
> > > > +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> > > > +			return -ENODEV;
> > > > +
> > > > +		pci->ep.ops =3D &keembay_pcie_ep_ops;
> > > > +		return dw_pcie_ep_init(&pci->ep);
> > > > +	default:
> > > > +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> > > > +		return -ENODEV;
> > > > +	}
> > > > +}
> > > > +
> > > > +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data
> =3D
> > {
> > > > +	.mode =3D DW_PCIE_RC_TYPE,
> > > > +};
> > > > +
> > > > +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data
> =3D
> > {
> > > > +	.mode =3D DW_PCIE_EP_TYPE,
> > > > +};
> > > > +
> > > > +static const struct of_device_id keembay_pcie_of_match[] =3D {
> > > > +	{
> > > > +		.compatible =3D "intel,keembay-pcie",
> > > > +		.data =3D &keembay_pcie_rc_of_data,
> > > > +	},
> > > > +	{
> > > > +		.compatible =3D "intel,keembay-pcie-ep",
> > > > +		.data =3D &keembay_pcie_ep_of_data,
> > > > +	},
> > > > +	{}
> > > > +};
> > > > +
> > > > +static struct platform_driver keembay_pcie_driver =3D {
> > > > +	.driver =3D {
> > > > +		.name =3D "keembay-pcie",
> > > > +		.of_match_table =3D keembay_pcie_of_match,
> > > > +		.suppress_bind_attrs =3D true,
> > > > +	},
> > > > +	.probe  =3D keembay_pcie_probe,
> > > > +};
> > > > +builtin_platform_driver(keembay_pcie_driver);
> > > > --
> > > > 2.17.1
> > > >
