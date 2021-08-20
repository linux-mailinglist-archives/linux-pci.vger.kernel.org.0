Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30843F2ABF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbhHTLLb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 07:11:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:55709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237651AbhHTLLa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 07:11:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="302344636"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="302344636"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 04:10:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="523551456"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2021 04:10:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 04:10:49 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 20 Aug 2021 04:10:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 20 Aug 2021 04:10:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 20 Aug 2021 04:10:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as7FM+r8E/Qr6HtIze/7yN0iq1sdNXhSYECPJ+aahNY8neX1qkugb6r8/+81jDYzU5hUuIf2lsMt8KSrgO/vf3gg0CSZBPgnQusPARFoWII3oCZBiKy/dx1tlGIvYOtnUaKfVvXlLCD6ZAJvAvpFZtwSOdzpCDZkZVPrRh7HRjFo1QDRy6Ng9L/EcXIw7LW829tA5pdWbUpkT0iI9qgM5lPM48wohnNA3bXMDiAV12iTcI1X2lvz8FiSSW/XnYlNPIm+F2Fh8qx9yWWD34/XwJTfJZGbmn9XaViFNbJ+PnXqLF33U/AFZAlZE1E5GNLgqgF8KVu+gikNCzQ6xQwWxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxmP85FRNWIDKBCxLX3C9vKmWE/XfZUqvadPmg+hEG8=;
 b=lHBi8DI/Os0509wEh5eu7d6SMdP/uVvYFEcxwbT7pxhIX2QZtoTsExyIryJV52AGTS85XWqRkyjv3+898aQ9WjlJaYcafIQkOVnq6RNNGByFH/tnP1APzjj1d9gqKL2FwSXLD9bZ4NACu3MzY7Ijr0v1UR9Ph4lC2NuqBrg1VexRUGldZJWPJYuw10Vf9ul3GSp67tcgMb9gmuJy37wU7kTNOaIOTt1XPmxNwU+wp84twFBTtK+pKCwz0mkxwsp2dsL3eOzHRgwgvnLozIXd8LkQbyyqhK6nI+Tuow5a2VWVpzKsb/Tj7xIJ8gAp6CjCF0GhmeSjH/fbf/krsR00xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxmP85FRNWIDKBCxLX3C9vKmWE/XfZUqvadPmg+hEG8=;
 b=IzNOlWCEgjwx/SCuA7MYRS63FfONcZ+b5z2ZYrAFykT43vaPlAiArBX8+MerdaTVn5yprdqw/RjLtebKZ+iapy26lqv136NCuWG8/cAe9JYOl5zZp1PpaHnAPf2Je7ss82iWEZN4PeFTfceZlYVGjZikuvm6xx64qTvRuLvAaDI=
Received: from PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16)
 by PH0PR11MB5628.namprd11.prod.outlook.com (2603:10b6:510:d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 11:10:47 +0000
Received: from PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::892f:de9c:2fce:ddf3]) by PH0PR11MB5595.namprd11.prod.outlook.com
 ([fe80::892f:de9c:2fce:ddf3%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 11:10:47 +0000
From:   "Thokala, Srikanth" <srikanth.thokala@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
        "kw@linux.com" <kw@linux.com>, "maz@kernel.org" <maz@kernel.org>
Subject: RE: [PATCH v11 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v11 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHXifwPgu7VmBqv/EulPKH93eM5C6txrTCAgAqUEEA=
Date:   Fri, 20 Aug 2021 11:10:47 +0000
Message-ID: <PH0PR11MB5595721AEF1A7D5A80F4A46A85C19@PH0PR11MB5595.namprd11.prod.outlook.com>
References: <20210805211010.29484-1-srikanth.thokala@intel.com>
 <20210805211010.29484-3-srikanth.thokala@intel.com>
 <20210813163051.GD15515@lpieralisi>
In-Reply-To: <20210813163051.GD15515@lpieralisi>
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
x-ms-office365-filtering-correlation-id: 3e7a9a18-986a-4e03-844b-08d963cb2960
x-ms-traffictypediagnostic: PH0PR11MB5628:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5628C99DD2A063D8665FE97A85C19@PH0PR11MB5628.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDuOejpM9jXDCtpevBi0zu+j6zEiW2YE8Xx8Gdy45WovY7AKOk6RHAmsOHG9K3exaW6R1t+wn0Vf/uwcr+p9pLVxL2Sapn8jJY7hVfFcj8ant4RYAgzcXS9HekbT1H4x9Fh2N9D4EFVnc+uCLbtSrmDBCGgOw9iWZXsVbo1Vi3ciPYy5Jn9HT9lYqA2RJdbMtPH6oTB2J49PoGh7LhZgZ4Fwxp1OEDcJ3gtNK1tC1BiNZGYfMAyA3MAqZcoTYtJp3jBD2tqkeHumdji2toaCu5w3r/7Ya5XDIr7YhpZ+QsVnoc0kk9nVe47NZo5FI3wbss7dnFaQZSueiw2pvZJt2XDUlk6YoaIDoRm2TnKplOSm4ZU/pKxGgyYWxsAf7AM4QgOFbcMeZyL9myJ0vlmOpr9BsrPJFS+iSpFaviWe3L0F0erF/H5WkYLm6nXkl6pxNOfIEPx6OdYyQl0zcZFUvUAAoqNCpLcl7KIQYeuaQ20+xHiWqkLmHUM920dYg/Zg3z4DKD6B4yFcqLHdwy9P44GP5kEuAfx4dYmoOxZHBjb/OEyeFOb/syUFFBHkru+QL5C9TNisFyoSUGaHVZvj/coacDpv3IBgJ/lkvRrla0qGvnIDO7ZWjTFQ3+atbyMORjDc+QPs6YfnWiaOjdDgGDlE0BXdCco1mOCJz9ulTNtOABoHQjtPHm+iwpQ142qGZAVt9VJbNgbD4Z7bKDx6Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5595.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(71200400001)(64756008)(66476007)(66556008)(66446008)(38070700005)(122000001)(33656002)(38100700002)(5660300002)(316002)(8936002)(186003)(9686003)(4326008)(66946007)(2906002)(26005)(83380400001)(55016002)(54906003)(86362001)(6506007)(53546011)(76116006)(8676002)(7696005)(478600001)(52536014)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3MpEfiBitDRl5bJ2En+ESGv5EcEFKFkMpmgnaXFJVBA2a89DC/ddW9w9eLBr?=
 =?us-ascii?Q?lxOJyPKxTNpNFHYqh4zC9Upzd9v0ohocVbidBaaJVVF3f8b2X6iOeY1N8aRg?=
 =?us-ascii?Q?SRmsAmc1UE9GP4EQfY+hIpRtojAIKqh+Y5iFvQhLtUcrg7+KKMEjxYg7nnCD?=
 =?us-ascii?Q?DRnb5m6vIfcFqFDiW5hPP7YZzQbo9bjS+Vkd26iHdwVKfMv37tvY0ycPowuG?=
 =?us-ascii?Q?q7m3eNeXedyrjxXkhx0kpP0KQQMVdIuu23ZrckSuaDD31AnB8mKkmfkrk8/i?=
 =?us-ascii?Q?pduM9nnbjqo8InCkhkkUlwwgPdeebe2geT/noS+vBCkV1u8tx6t6m1O2lFcB?=
 =?us-ascii?Q?RcCRXAtkkEzNyFM9m1yZTZFFk/YgVGGH9hixYD0GR/tBp4SECDgE4ELvGb/i?=
 =?us-ascii?Q?YcJAqER9pIfP0e1Qkipjd9ADo9g7lWtIA+o5lqONaY0ZikO5bHZPScVzajDZ?=
 =?us-ascii?Q?7iLTeJwOV12FSmGUci4DLrEEo8fOy1eYAiQOc03HnU3eeU2cCwxOu6PDU/JL?=
 =?us-ascii?Q?hz07YJD1kBbmS0dDzrOW+9K10IiT5I0lDqWxsyuFPlAhEEUq9Eedfm3+bMhu?=
 =?us-ascii?Q?942z/CHxPxoVqfJXxZMXoZDlg5d3ZFvlThsRYotC5Wto/g1/pdhr53iR09VN?=
 =?us-ascii?Q?MTEi3WQQuZMXnvisOBAiHqrgd8Tupv1ScjA68doycv7zFDDZcI3VYHWX7gx3?=
 =?us-ascii?Q?NUZ6T0g3IZ7XMfZzjfj3jADMB/G6NLkWkpR9ht/lOCqjzUsOFJnLBjoYLJVD?=
 =?us-ascii?Q?+q29rXQC2dnW1jualQFbZ/HRteSnAaybarpNSu0pa97H4+TCbfxWHy2REFnw?=
 =?us-ascii?Q?A9WgMY2X6M4LR2A110s2sE2T5uliD2/fVAxBLb5Vr5MASqJqOConurzdcdGN?=
 =?us-ascii?Q?afBkj1RxgDu//8TjJg1meyx/Vc1B5W7cfsXxWId//jekibngS2eAU5GSpvJP?=
 =?us-ascii?Q?2ZmmJoqwgNbuUiG+4Zz/EzW/gjFzCOy91AjV/CD9wcq17jRYDCM6Mjl2O1IX?=
 =?us-ascii?Q?+o/V0Qg9DxovBMu8RRlIpKJvmtWRii12/zB5Y1UNZ2FRHCYLYYN4blBerrbN?=
 =?us-ascii?Q?nZTRtSnzi4YxHt0+krJQV1MNHZhICD89erOz57lE2RNe1EUmIxOBbGD6+yqL?=
 =?us-ascii?Q?TiUBXWfq6vLgcZUUNji+0hv501mNKPX++zq2/znNL+OiU/bYo/r4HtZ7fXHt?=
 =?us-ascii?Q?Xpe8eoz7Ua0cfKBv61Rew83/5pcpAT1GB1a2zjXH9PtlKTzKvnCLdEvSxNOO?=
 =?us-ascii?Q?7U/3nIpxLFWHzu6irmdLbmadhUr6Ryn9RBy/iMoyOrLbIcqElDrY0ALlJ/ru?=
 =?us-ascii?Q?maSuCHb1Qu8MKhSNaB2khZow?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5595.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7a9a18-986a-4e03-844b-08d963cb2960
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 11:10:47.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i13PrHlt+eJoe47PVwSkbiZgGF1pUFV32VMANEnQD9oZDFd7JhJhw9Zsok5w0W2UR9hPTQWia6IvXCvYS1qfe+4vsNaYaoz0LfQHNFK+i38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5628
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Friday, August 13, 2021 10:01 PM
> To: Thokala, Srikanth <srikanth.thokala@intel.com>
> Cc: robh+dt@kernel.org; linux-pci@vger.kernel.org;
> devicetree@vger.kernel.org; andriy.shevchenko@linux.intel.com;
> mgross@linux.intel.com; Raja Subramanian, Lakshmi Bai
> <lakshmi.bai.raja.subramanian@intel.com>; Sangannavar, Mallikarjunappa
> <mallikarjunappa.sangannavar@intel.com>; kw@linux.com; maz@kernel.org
> Subject: Re: [PATCH v11 2/2] PCI: keembay: Add support for Intel Keem
> Bay
>=20
> On Fri, Aug 06, 2021 at 02:40:10AM +0530, srikanth.thokala@intel.com
> wrote:
>=20
> [...]
>=20
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
>=20
> May I ask you (and DWC maintainers) please why we need to resort to
> setting
>=20
> pp->msi_irq =3D -ENODEV;
>=20
> while we *could* (?) just use pp->ops->msi_host_init() (ie which I
> believe can be keembay_pcie_setup_msi_irq() revisited ?)
>=20
> I would like to understand how this choice can be made by a DWC
> developer that has to add an incantation specific MSI logic handling
> glue.

'pp->msi_irq =3D -ENODEV' is set to
1) Re-use DWC logic (as part of dw_pcie_host_init()) to create MSI domain a=
nd map MSI page
2) Register Keem Bay platform-specific MSI handler as IP has given addition=
al registers to
control MSI interrupts.

Thanks!
Srikanth

>=20
> Other than that we can merge this code but I would like to understand
> the rationale behind the question above - it is not obvious to me.
>=20
> Thanks,
> Lorenzo
>=20
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
> > +	pcie->apb_base =3D devm_platform_ioremap_resource_byname(pdev,
> "apb");
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
