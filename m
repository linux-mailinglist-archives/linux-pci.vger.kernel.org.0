Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67E300CFA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jan 2021 20:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbhAVTyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 14:54:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:26669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729705AbhAVTVm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 14:21:42 -0500
IronPort-SDR: tWVqVpZFQsrBMEv8jX3eV5wAGH068/WPYiILMNakOf/hTn/G2Oq0MGkvXGVC1ljBFv2SIzoLZk
 x3Ek37TCg1+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="243570142"
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="243570142"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 11:20:54 -0800
IronPort-SDR: /UCp8tnUPcVYW1FsAnyyEOfDWMtePt0PvNnSnVuWcSH9h2qnt3dp3kgO5YknO1flBM4ySzIHW1
 ma9lylZFE8PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,367,1602572400"; 
   d="scan'208";a="503144093"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2021 11:20:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Jan 2021 11:20:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Jan 2021 11:20:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 22 Jan 2021 11:20:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBSwrDWUAgYLSOhxDBzYREyx63S7XgJXD/b4fGqVhmJ7CXK43Z/Yup2Z4gd1egRlzDxv4EYSfgF53eMF8fANz8ddXGSWjb7FGn+Log8oGOMHKZl7XatuZj58dUVawINXH/ugaHusETUiVLk3RZlKviIdu4jPBVABLtPTpxFdFNayN4U/p0zPqWmS10bti1D56m8ViWfHEus1HnhVa0boL8dZxfEcPGAhpdp4/02Orm2ltYN5TRn97HoxPQcccYtc44RiQmUmFP+VlJBZ37iqMoU1c5INhp/u/sLkIUrs1N33YVKtAyFefPdUYGKdApc7qHUxMIh+s7lPShcdQ/Xt2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BBX4ZAuydHsvDl/esE3i4r0DA/S6aYflZU2u9FSkJ0=;
 b=O96yVakl2m35gc3QYZWEOpLRGOPDQK2JtT7Bok8USJog9P7/vBLq395v/fTazLszJgtqG94BgKzmxvs38IVfoGKfLFb0NFDxnLQZ9Nq/aL48DRKSIZIl1oOnkagCirTkc3orVnuG/H1WKVO0ARY6I008aqxWP11wwQV40WpPBMo27DAKkwBV0vIjIYbQFr+x7lsLtVHn860bL6J8SbfgEWi0dd+djunaqQnhPYK7ZxqKi7KJfOaqQqZcGAfM0xa4qRYwn7G7HA9YG5MltFVfXafdr2ggqnSiTQv3KhFgenxNZQyxcwrh7eH5KcDg9Lp41JwHj+kUuDAAF4dI4P/Y8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BBX4ZAuydHsvDl/esE3i4r0DA/S6aYflZU2u9FSkJ0=;
 b=t8viYCEh6iw4KTZigvpr8GezDqMcQeJy/pR80ey/YF+eb3URO2QE8Mnv4FwBrfyObfyoQfyWO6Cb453KQiTp/cqB9nLgsNvIFPOxM0/aAkgyqlGJriwTVWgJTj7yRh1+ZD94sW6cvkTT0b8lTnMBxjq3FgX3NW6gA9+czj/wxQY=
Received: from MWHPR11MB1406.namprd11.prod.outlook.com (2603:10b6:300:23::18)
 by MWHPR11MB2061.namprd11.prod.outlook.com (2603:10b6:300:28::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 19:20:52 +0000
Received: from MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::2835:4cc2:edf6:3c0d]) by MWHPR11MB1406.namprd11.prod.outlook.com
 ([fe80::2835:4cc2:edf6:3c0d%9]) with mapi id 15.20.3763.017; Fri, 22 Jan 2021
 19:20:52 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: RE: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHW8CxEYqglrlTf6UWr0PjVJmm9saoyfXIAgAGG52A=
Date:   Fri, 22 Jan 2021 19:20:52 +0000
Message-ID: <MWHPR11MB140635AB9C29EDC932E7DBA185A00@MWHPR11MB1406.namprd11.prod.outlook.com>
References: <20210122032610.4958-3-srikanth.thokala@intel.com>
 <20210121195206.GA2678455@bjorn-Precision-5520>
In-Reply-To: <20210121195206.GA2678455@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.167.96.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4df0983-4645-46ce-95c9-08d8bf0ad56c
x-ms-traffictypediagnostic: MWHPR11MB2061:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB20619FF57B0BA1EB25B7A7E385A09@MWHPR11MB2061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VV7Laxq6JUb3HHQF9Q+MFYhOB5ZAQy0UxBDx/NU3xykJhucTZxpMItvb1O4rHYGj7bcobZQixK5F7luvi6rP99dzeKila8wxHIajXggvf0BA03nBQMh+NVHHcqgLOVWQtm5/VwGh8cJBZhaIUZBDt+XUlMygIf4p3diV45tbzkWsPzUn+UOWXlrZ3viIZVc0KBhtTCdU7vXOGh4sJ5CnvoquXmBZoBPdZcWdgVAlss82A1JLsHX4ZQHibR9uq5EfieB3+/asjyozlbBI4mrWr45h1vHO1vJpezUnFiWdx/xCvVh6mDSwPJF3DSudIIXY3CiNirJoF1oJ7NYm+46hFDQslmed1H0l35nYJjCzvpfwzm407lLGAcPlG8z6CZq5ozPO9LL66H2SCHi8uW74JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1406.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(53546011)(33656002)(66476007)(26005)(66946007)(64756008)(66446008)(6506007)(186003)(7696005)(86362001)(2906002)(66556008)(8676002)(83380400001)(6916009)(478600001)(5660300002)(76116006)(316002)(71200400001)(54906003)(52536014)(4326008)(55016002)(8936002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1+cdZrJCiklR81uYQFIziQ9xgKuq2Ylh+dzL0EmX4BMsNG+xkaaBr2XbJ2jr?=
 =?us-ascii?Q?Ub0mHZLMcvBOVdp/Sy2YSIKBWD1QZBSnCq7bc+EIUEl3UJHhTIEE9txt6eAZ?=
 =?us-ascii?Q?h2Wgw8clUAbpgUVICtmfI+wUhm6kl7uOve7dj+Pu4D8Xc2cU14GPhQNIXq0G?=
 =?us-ascii?Q?RhjZcGAsIRYQ9Yjc+PPrkJ+ec4TfpjDhnAm6joBtxI7Udc9zmNOMTdjQ3uqo?=
 =?us-ascii?Q?Rmtwiidz0ES0/2ToM+v+23VRLepyZwuDKlJi0yqkiXxSk2YjBxWOEqYX6MmL?=
 =?us-ascii?Q?7fkPsiz/NFM0yw32rpSetNUU0AsPRmBQ2Zvv8ARra2hjKR0s8c3mFu//sNzJ?=
 =?us-ascii?Q?ySaRPFjtj5oXTb1nz3pSG15tnsFidoTTxH4aNZw62Ty2TTHSoLDrpUjT45SI?=
 =?us-ascii?Q?MCQXmiDGxg5yoBbHthrXV9OobVFs24L2sI2w+CLhE5SFSKzt75LaNPWh63rM?=
 =?us-ascii?Q?FFB74CnaEiIhPGZpmNXjkXyC+peYmb1wBlbFrxKbHyjfz5lBJu3gHO6nSBXX?=
 =?us-ascii?Q?SG7+/pZMciMkXP727Epk+jhh+y+v9jjdkC5DStMS/yCsWo9TGOyK4fdzMplR?=
 =?us-ascii?Q?Q9xSVmQsPX320TdrrgEUoEYJgWDGcVqPX4ccwVoF98jxkN+UTmms3AYt6kUZ?=
 =?us-ascii?Q?fldPmtxotIkj/bVph12ZWnc9UaZZHP7S11Sm5rY3xI1IyIfiDEaiB/s00xW/?=
 =?us-ascii?Q?EAb8f+KSoldz0T1Zw8n4bEfg/lSegn4qayyd9ZMsFU8ZIdDEnfXkD8Vg1v7Y?=
 =?us-ascii?Q?C1GVvwr2pxY+jxznHDHoV08xsIO3MHFeDTVUu0uFRTr1bwB0dWHdHEeQ+QrU?=
 =?us-ascii?Q?3tCPdSJD+nxT4Tz7i8hbVaFC1y9PLTUZ2bl36/jbeSCJ8mMPoPZirvMZbDay?=
 =?us-ascii?Q?h/wIWocVvjYrI957/POYGWIKe1PYnIC+4n79i5EUWxXoqlKJURZPlejochCA?=
 =?us-ascii?Q?0l4Jgly5kHXKp3PrgYFf13fzitdf+BOJZH0gy4TJFI8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1406.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4df0983-4645-46ce-95c9-08d8bf0ad56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 19:20:52.3336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w8XGtULkm5/tQrdNknFJbb8yjh2UIQuFLFp254ytjtRUose2AzKmpwg0DqDK9TgaMSvjMOyERt5KA4pyeV4+ODW13JeQGIlAdZsEJezMq2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2061
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the review.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, January 22, 2021 1:22 AM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>
> Cc: bhelgaas@google.com; robh+dt@kernel.org; lorenzo.pieralisi@arm.com;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>;
> Sangannavar, Mallikarjunappa <mallikarjunappa.sangannavar@intel.com>
> Subject: Re: [PATCH v6 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> On Fri, Jan 22, 2021 at 08:56:10AM +0530, srikanth.thokala@intel.com
> wrote:
> > From: Srikanth Thokala <srikanth.thokala@intel.com>
> >
> > Add driver for Intel Keem Bay SoC PCIe controller. This controller
> > is based on DesignWare PCIe core.
> >
> > In root complex mode, only internal reference clock is possible for
> > Keem Bay A0. For Keem Bay B0, external reference clock can be used
> > and will be the default configuration. Currently, keembay_pcie_of_data
> > structure has one member. It will be expanded later to handle this
> > difference.
> >
> > Endpoint mode link initialization is handled by the boot firmware.
> >
> > Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com=
>
> > Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  MAINTAINERS                               |   7 +
> >  drivers/pci/controller/dwc/Kconfig        |  28 ++
> >  drivers/pci/controller/dwc/Makefile       |   1 +
> >  drivers/pci/controller/dwc/pcie-keembay.c | 446 ++++++++++++++++++++++
> >  4 files changed, 482 insertions(+)
> >  create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 00836f6452f0..2fc0fb03c430 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13852,6 +13852,13 @@ L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/pci/controller/dwc/*spear*
> >
> > +PCI DRIVER FOR INTEL KEEM BAY
> > +M:	Srikanth Thokala <srikanth.thokala@intel.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
> > +F:	drivers/pci/controller/dwc/pcie-keembay.c
>=20
> <checks MAINTAINERS> ... yep, all previous entries are in alphabetical
> order.  This new one just got dropped at the end.
>=20
> I feel like a broken record, but please, please, take a look at the
> surrounding code/text/whatever, and MAKE YOUR NEW STUFF MATCH THE
> EXISTING STYLE.  We want the whole thing to be reasonably consistent
> so readers can make sense of it without being confused by the
> idiosyncrasies of every contributor.
>=20
> Also, probably s/PCI DRIVER/PCIE DRIVER/.  We have both (an existing
> inconsistency), but pick one, put it in the section that matches, and
> alphabetize.

Sorry I missed; I will fix it in my next version.

>=20
> > +
> >  PCMCIA SUBSYSTEM
> >  M:	Dominik Brodowski <linux@dominikbrodowski.net>
> >  S:	Odd Fixes
>=20
> > +static void keembay_ep_reset_deassert(struct keembay_pcie *pcie)
> > +{
> > +	msleep(100);
>=20
> Please note the spec section that requires this sleep.  Otherwise it's
> just an unmaintainable magic number.

Sure, I will do that.

Thanks!
Srikanth

>=20
> > +	gpiod_set_value_cansleep(pcie->reset, 0);
> > +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> > +}
