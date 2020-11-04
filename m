Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5180C2A63D8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 13:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgKDMEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 07:04:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:2667 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgKDMEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 07:04:01 -0500
IronPort-SDR: oJqRPJlf7p4XzHB/i4flQkq2ga5LySWN4+8rT3GKUXmkLaZxuPpOz/1SUK33T+yV8vCSrnw5BS
 smpD4aUup9bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="165698704"
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="165698704"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 04:03:44 -0800
IronPort-SDR: EncAUA+djlPzGfvppR3+adEi4rDQZ4ghraSlkWCMbyugJs89GWNBJqQKW+ZVrQaQpRG4i7uLLW
 jzOWT2m/2Fow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,450,1596524400"; 
   d="scan'208";a="471205045"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 04 Nov 2020 04:03:44 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Nov 2020 04:03:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Nov 2020 04:03:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Nov 2020 04:03:42 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 4 Nov 2020 04:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG5NYQgKvaDBIuHmv9eBjJNcnDPjsVx+bcw8gvftHuju0iBcM8v/6/Yh8ss3uTdfc9IY8hPe3ZZ7oDxTqHy4JU1RPuIo+FPJ0sB2J/SYrKHboj5N9Zz1vmLQwvs7JkKcPOeIuJeu32NCeLmBNkii4TF2WZQpEIwPeWdDcADNpLp0+eeJeWrTbGUoMyeKOmx9G3h0aqGXV9EkgHneGM1fxhaiZ6mg0Aqv0q6ZFrsGZzAOKp2mB6kJxjwLmufN+4HwTkko3LLDfQDYtzK/IQfNs8jP1a01DHoOKBDwEFicSRtQ37WFYskMgbHn2RSNk8Xq6gKumlyElycTH5Viybljew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8pZYvXH9OnrB8P9QVMUywwRaRJvU8ilF1OFkUu8XjU=;
 b=A6aKsWl0vHTX7CJPhunlcoa0i/nhm7yr92FJiFTUKA9ZNIjLyH+tuSwqOhKNcXTYgNLs97a1t8KKheOfcGQhY1Xw874Yj0489tUWpCyBxj9Ykqw2V3n7o9FxCxM4W282gNJkcB3uO7nlVVpyNWhU8S3eaUO94qAT7igoa8H810OYSG8on7ouqqMUHWh5gZPThpqcR4AIlLuTv3oZ6nyQPnHiYJQn39mSTAijkkPo3jVbtGgvnvNgBdVepGDev+DI2m9qsuD6f8WVuq0H0zcQHxfYakgpjeljAGIb9+jGykXltwXgxBu+xpcKEepf3DAw42Mm7NiQp3sI+Z4T281h7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8pZYvXH9OnrB8P9QVMUywwRaRJvU8ilF1OFkUu8XjU=;
 b=TtYdxFS/AjFZZv2nEcLPiOFai0eJXkvX4/Fm6P3XpSeS/o4N2VENhfVYcuYfyusXN5spApjNOTu+vZgkyfuyKmrkt7WJZo6FFCX1B0Of0twMkAIGxT4Xc47Cf4ZUq9kaRQ59/BMz1LLnNR/s66T8opx7SRtASayZ24M4HjeYenc=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4042.namprd11.prod.outlook.com (2603:10b6:5:197::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 12:03:39 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::5017:4139:6553:ded4%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 12:03:39 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
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
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHWrCa/7JSqkgie50uK+30dhAeVBKm3B0yAgADdDoA=
Date:   Wed, 4 Nov 2020 12:03:39 +0000
Message-ID: <DM6PR11MB3721DE5452FA6C4CA3E23FC8DDEF0@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201027060011.25893-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201103222223.GA269610@bjorn-Precision-5520>
In-Reply-To: <20201103222223.GA269610@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.225.240]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c23c41e2-3075-4995-ab4b-08d880b9aaf4
x-ms-traffictypediagnostic: DM6PR11MB4042:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4042FC28788147CB1D3EA541DDEF0@DM6PR11MB4042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+T2wURgJ/OV3cEERejVHWW01umCC6dq0OIjzXTLOJyfZVu4dbSbNE6WdkPQQqDQMQ+CZMnFMc/JEoyFBp3jFvG+bROifmLuqIlpN7nRIY/VNZkr9jZQr3wiwPxSXrPlCAnfrjoHH2Uh+ADkn47iYG/Un8h2FWoDClEFMm3gvnqeHK4j7GHpbArdw9UcYr6fY24/6dlzi/nMwyojvlQvrcJ1/Jer2XhviHDVGsDOtvo7O00oN0FyBzerUaayquJmF/uV/BbmxYRnLpgs0G577waUUCGHF0oTKJJTWXMfpv5wxZT/GcQNsP3k2I+UbUP9J+hgn/V9ecDssZuGpAdPeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(33656002)(478600001)(8936002)(4326008)(2906002)(186003)(7696005)(86362001)(71200400001)(9686003)(66446008)(64756008)(5660300002)(66946007)(26005)(66476007)(66556008)(8676002)(52536014)(316002)(83380400001)(6916009)(53546011)(6506007)(54906003)(76116006)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KTVUeAxS/5e+ZJh9Mv2DbhKQ6b1GRvQv1GA4XatkTopgePsWx8i/9pnjSBPX6eYkINcxxb9aDTU9z7K/DL4k3JWQG+8GT3bnGZsKSiK5DmgNmtZ3aKezSITPAi97h1dPeXmzNz4nDDiBFNbrWjSTLuz/btFQ5DVXuM03PNvWPMKQGjyVZOsYdHQdKCD+O+zy3zJ0nQEb9tnDidWGShlbuT4Z0LSu/0eCzwW6TQ2tsXIcxMEr3U8KPqEAQpKW5NUGiAF1t4tZOVtGl9fAqLTlkuGGSgFZ0FO1EjJun5fm47wzKWe7PDNQPKtG9+7ZW5ciTVnu1Cw7s8aXdBNrlG5Lsk/mZ/jcad1XnX1Ait8bz7TNDYU2HUsZ1TBdw7c6Ekg5OxCL4ruXm4k7yUDJAsP7nLUxcYMCbyNq81m48PM9OFEVrJvzGK5QonIQKHQSwq7wihB3OUITqOioeMqTptmfOxP1bovPs8StgtvXsTvwfdoikC57wlET56BGzON8YSj/VFReAa5STZHWU0CASw73wKrpSF5oOaGgoC3p990RgVq0EKZI/aMcsELkI70qEBDdrKpKOHP/F2suSCRef65YvvAXCi3RMAE1F23ocPreUBeldwl0cOhwt0MONUFcqTnBi4KuCoYE+XJBMQWYwzTncg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23c41e2-3075-4995-ab4b-08d880b9aaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 12:03:39.6982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnFi+z1zgyXYyNf2nCJPo21fP/La9sNdnjbhvkK8atqDOmav1sN7gm1HFV1sHS3IFdLUM/b5UDXmOs4YbtGzJiGb46lZ5H2EbwbqddVajBycLmPeluGc4mJUywUPWAEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4042
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, November 4, 2020 6:22 AM
> To: Wan Mohamad, Wan Ahmad Zainie
> <wan.ahmad.zainie.wan.mohamad@intel.com>
> Cc: bhelgaas@google.com; robh+dt@kernel.org; lorenzo.pieralisi@arm.com;
> linux-pci@vger.kernel.org; devicetree@vger.kernel.org;
> andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>
> Subject: Re: [PATCH 2/2] PCI: keembay: Add support for Intel Keem Bay
>=20
> On Tue, Oct 27, 2020 at 02:00:11PM +0800, Wan Ahmad Zainie wrote:
>=20
> > +static int keembay_pcie_link_up(struct dw_pcie *pci) {
> > +	struct keembay_pcie *pcie =3D dev_get_drvdata(pci->dev);
> > +	u32 val, mask;
> > +
> > +	val =3D keembay_pcie_readl(pcie, PCIE_REGS_PCIE_SII_PM_STATE);
> > +	mask =3D SMLH_LINK_UP | RDLH_LINK_UP;
> > +
> > +	return !!((val & mask) =3D=3D mask);
>=20
> I think the "!!" is redundant since you're applying it to a value that's =
a boolean
> already.  So you should be able to do:
>=20
>   return (val & mask) =3D=3D mask;
>=20
> But it seems like "mask" just obfuscates a little bit, too.
> Personally I think it'd be easier to add something like:
>=20
>   #define PCIE_REGS_PCIE_SII_LINK_UP  (SMLH_LINK_UP | RDLH_LINK_UP)
>=20
> and then:
>=20
>   if ((val & PCIE_REGS_PCIE_SII_LINK_UP) =3D=3D PCIE_REGS_PCIE_SII_LINK_U=
P)
>     return 1;
>   return 0;

I will fix in v2, using the above as agreed by Andy.

>=20
> or even:
>=20
>   return (val & PCIE_REGS_PCIE_SII_LINK_UP) =3D=3D
> PCIE_REGS_PCIE_SII_LINK_UP;
>=20
> > +static int keembay_pcie_establish_link(struct dw_pcie *pci) {
> > +	return 0;
> > +}
>=20
> Are you sure you need this?  I see other cases where the .start_link poin=
ter is
> left NULL, e.g., pci-exynos.c, pci-imx6.c, dw_ls1021_pcie_ops, etc.

Yes, as in endpoint mode, link initialization is done in boot firmware.
Leaving it NULL will cause pcie-designware-ep.c::dw_pcie_ep_start()
to return -EINVAL.

Rob is refactoring DWC code and looks like .start_link is used in root comp=
lex
mode too. I will make changes to above function in v2, by renaming to
keembay_pci2_start_link and add link initialization code for root complex
mode.

>=20
> > +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8
> func_no,
> > +				     enum pci_epc_irq_type type,
> > +				     u16 interrupt_num)
> > +{
> > +	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		/* Legacy interrupts are not supported in Keem Bay */
> > +		dev_err(pci->dev, "Unsupported IRQ type\n");
>=20
> Might be nice to mention "legacy" here.

I will fix in v2, using string "Legacy IRQ is not supported".

>=20
> > +		return -EINVAL;
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no,
> interrupt_num);
> > +	case PCI_EPC_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no,
> interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "Unknown IRQ type\n");
>=20
> And maybe include the %d of "type"?

I will fix in v2, to show the value of "type".

Best regards,
Zainie
