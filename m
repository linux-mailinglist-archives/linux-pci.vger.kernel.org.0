Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5FB7984A2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 11:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbjIHJPW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 05:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIHJPV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 05:15:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3B71BFB;
        Fri,  8 Sep 2023 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694164514; x=1725700514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TagmebyclPfIvAkBv92GeJ+Ep8J6Yqfd3QA9a7z/TLM=;
  b=RHzWqZzHQbbVDPL1BpZewTL8eHYTbt4eNOawGx8D90kHv2QlThGA0dGw
   26c1fUkH7qQX2fcXYgIe0BxGizQFPlAKU7pSjwyEyM4eLgUYuEmm+W8dv
   I+QL4YE8xCqKhKwr1fcE4ayo+gxBHxaQSrrxqZLewshApS0qRPEgcsj9A
   t278W/vk7zhF01oN8AT9LoIbzMWx0nr0OU5ggrA9WSldJm9lUfSWRdCd1
   yHBTi94x4AC8HFfYEl0Z7HLFfj/zO5EnLLq0GG0mpy21dvPoLWexu3602
   IQBsT0zhvjm+Ordr5hbEUrnae3AV0HO0WmAJEvAZcBK+Jr3GJZL+3gj/r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="380344160"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="380344160"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 02:15:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="866045016"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="866045016"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 02:15:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 02:15:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 02:15:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 02:15:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 02:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1cvpViuAiqFQbtCd8G1GZndvAzej3KMcUliCkC6KGYsl6+4Dwm3q/VS3A+Hm1evNisKQdgvFsYzN703EnxYmpJQUnsaq/rYim2HpwaTtmh0NyxFuGOrfjXYp8hNjNnTkDhn8A6YWMbBR1Yyu3Kl4HyZMmab8HYrf9gBnumOdgoyHojFs3gfKZfD+sCjHSnCQP3tXipim3B6nFqKhgW7zEcrPJT4ZmWSmBOuy7j2XZ1eJ3TSbKUnb8eSLtMFATjrg7VKTpnPoNccvAWTG6WvnmSv1/04NiWJsZEBwROG+gL4xqFux4/dmKvq3Wey8licorhzJghO1TfSe4hh15NdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeQ9Cqn/QggM9/FrwZykiQBntun57i2MpI6w/2l89Do=;
 b=MSbHU0GWl71R/1EjBdQFF4CCistW3d1cxD6N6fCSAShzw/f6J2QHUxP58YdYahzEbPJROwYmz5vX7r321HD3mPX/W1BNOE/kD6YoDW5us1fRm3XLuQfWse0+QhM++mXjlYEXuHFwmSkVrP4oz5tWNMgof3nVO7eMx6JnYcHfadfiu8s6Czoyq7SnOVqs1Dn/6uJa+ADaSmNzBU3OoFa/X+NQ8Pt8X4XCdOK+JdmCCT0GAmZfH/Bk6Wc+Rkmk/m9p3guaGZVPdVsrnywfE1n6Byqm6wn2SP1Pq1o8kDppB4CeQMh6LwTaieeYGSfjMQv/mB2rVmmW7g+1zT0vrDz9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 09:15:09 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 09:15:09 +0000
From:   "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Thread-Topic: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPGA
Thread-Index: AQHZ4LKiIDprQWqup0eKm2uSyqkaFrAOCSaAgAKepjA=
Date:   Fri, 8 Sep 2023 09:15:09 +0000
Message-ID: <BY5PR11MB43060919B690263A0B1EA291FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
References: <20230906110918.1501376-3-sharath.kumar.d.m@intel.com>
 <20230906171211.GA230112@bhelgaas>
In-Reply-To: <20230906171211.GA230112@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4306:EE_|MW4PR11MB5890:EE_
x-ms-office365-filtering-correlation-id: 57777499-08f0-4660-0d04-08dbb04c199b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1O+78fTZnTXOZv2cpY6MYe8evjcLk2zjm9YlB37EAlwh/+FA6VQn2k+izr4nZOSo422CU2votvNJb6hSjXX9KtBlJvK9m3hmiZdmE1voKqtUhgt4UQpXn72N6342KQJmxIR1DO510Pvlct/QYBaIoQuAgmsf8pYo2sOPfbaGSD41iePOzDL0kQ8yFp0uwN9PHt4jkXU3n9z4ehx5IqEWSMurE813qOORLgCslcWCkNQwYA0Rn2unsz/J7iXM8Ob9ppc0y3z4tB/eHYe4d5nkLUAaJeHercwPgUmqM2p4I15NoSk7/mT80tWMfdARuzc/2nsX2pHo20tzOlf5rF7+mvN1paAL5crBC1LkGOaupYJb5SX8GnHAlbirFBHcyq1GIB2+5UcHPKUutvZnJKvI3a6TRr5LMPcTABt+LQ2avbJ5ZgIIrytKmLNkuCKn/7hDtOn0jWlrhdJS5u4nKxfv/ycq4qsgw2kkmxzLnOqwnE4BONXfbm4VlpqsxAYV9tat4gQAyVHDEdLE6x2dblXMVefDt2HD/NlF+eJLs1+oz+RCS0FKNnq9LvZIwp970ET9YQEAUyjaJFg3IoH0XUiUFYdyok+A850aN7fn1/oEG4ODAWlDgG691jal5vVb/SoP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(1800799009)(451199024)(186009)(122000001)(71200400001)(53546011)(7696005)(6506007)(82960400001)(9686003)(86362001)(33656002)(55016003)(38100700002)(38070700005)(26005)(2906002)(83380400001)(52536014)(478600001)(41300700001)(4326008)(316002)(76116006)(8936002)(5660300002)(8676002)(66476007)(54906003)(6916009)(66556008)(66446008)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v2F6GdK4j7MZ2XgWDj8Sju+WGI3uQF1+SRutBU9sTqmqsGhBEZsxM2sTe81v?=
 =?us-ascii?Q?8RGN6I+4NBafaDWkAZfoOiEEr19fm8jqPjrJ8E98EKHA2dPMNWDCA4cpHY4Y?=
 =?us-ascii?Q?L7l/fNPf+A8kbORPfUCv9fkw4gFjvGBV4O9cT/wG3VJL2cRsUc2djq9UzVvI?=
 =?us-ascii?Q?8bxVsCwehk/ZpMytimO/q3sT0nQ2APO2jHCx8Tlxaj27/L+ntEw2vuojyypS?=
 =?us-ascii?Q?fW3hqJdvA7TO+M8DOoCwp5vfBBcISDSTZphThP0h/6cp5wLSSA8MVf6bioG1?=
 =?us-ascii?Q?wv9VvqzlZkM+SvsIYKDlPAJ7YbdWM9qP5o+JumSpF4gohT19QhchPe6E8k0d?=
 =?us-ascii?Q?7Hrks1pL3dkU7DC3ORz8OBHKHgIAonlvs1eMR3kwhaZtDDoNL0HKYF/Pk0LB?=
 =?us-ascii?Q?jJcCY9TYb/xDLjc4jH/ST2uG+EnjOdCVdspfzTfBS8+zpEGrQrb3ncVA5r7b?=
 =?us-ascii?Q?kA3tQtzXvneymYK//bibfPGTUCScUFQKnq2mGZQWfr824tvDYnXCivawOk5k?=
 =?us-ascii?Q?5RG8js58G97EoxUltL1v4gG0yr8BPoZ1BV6RBw6uM0Ft2HXwcVNzeqjrSSCs?=
 =?us-ascii?Q?Wj69cULgbiY4imZAM8mn3rsXBUQEFVXctHlgQrp4WdBHVfnya8WIgUiivA90?=
 =?us-ascii?Q?nKbUetJi3n99Qy5rE1PhUvsBbVj0oFJT09mWX9h3/Ybt8P23I9OxqVycpb2h?=
 =?us-ascii?Q?ZaiCOB5meOPb/Rk7r4rVz7YaalUyFwsoOOfk84/SaFn/VR7oB/cwurfLMhze?=
 =?us-ascii?Q?vLEPA7zuc6RgLOF/BQs468Vl1RgR+C0W5stEgJ/9F2InO4IgyDun/3E0nOKk?=
 =?us-ascii?Q?b3FDnXQUb+L/xwN0LsGL1IIuQWXin9na2Px4Dwj5JWusUb5+NT46xjHkv9eX?=
 =?us-ascii?Q?Fj1wT8AAD7/KWbSBJnabjMHjNPavhxEYZJh0qnPh3UrkojOmwJU0ybf14H2L?=
 =?us-ascii?Q?ByBNMrQNIiAqk9KfMhzGvq8z2idx18qX7s87U/Fr0yZs1t1g/AhE+Qr1TyBh?=
 =?us-ascii?Q?xGAFUik4eLO2f4/wOSa/IwglfreW/Oy6YBdaG25zMzQC22QpiD7fhpxmWbhG?=
 =?us-ascii?Q?PO/0UbAYQCotslKRub61l+G6JsQbDxWcqT9NbUsKsNnyeVbN4FyfezgphT0I?=
 =?us-ascii?Q?DsO3QoFFsqD7JdFsvQlv8NyyQv5/6jkMKw3ahzUBwwLjx+J+oPiwmj5qTVzw?=
 =?us-ascii?Q?MXG3EE2EVdDYJYau1HS8rmbgRn/olBdGzqq87nTOksnbFEolc0iGe2FhV22w?=
 =?us-ascii?Q?m2PZuprVT5xGdr3FsxvCYcZGoGA8vkkStAVYdFeqhfPN8fpmBRQJ0ii4dSQi?=
 =?us-ascii?Q?kmeW8gRlIQdF4dTdJ4LNcKGUCvHm3Kl+TjYkbakM0JQqym3v1RsoMm2ZPz05?=
 =?us-ascii?Q?KbKjgMpQAh4EEAjPgI2x0RIqJZrpDhOjwE0MpVpctvJDSaWVvesJCSoDaHcS?=
 =?us-ascii?Q?G/bDXbi+mIu8Q7unU0Pztdw7rvnT9CyEu1dv9B3y1PTnlE8zI0i9QY8pJ+wl?=
 =?us-ascii?Q?45oEAwWwTHHPgeE/1F/eyo23a1A0LrQpjYKwxTYt5+8rOmkSeUmgfitCvy/i?=
 =?us-ascii?Q?9qkZ5XOY+bxxBjwlEqfjpJFwWoDwVFL2veAZusXUgjwSGub0sgJi8+mCssKO?=
 =?us-ascii?Q?2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57777499-08f0-4660-0d04-08dbb04c199b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 09:15:09.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tUmsgO6Dd0rYFlGt9km6yD2CkYgjfyLvkY5wwj4IAgIDDz3Wg1DR4pFckolVr+kgaQKCuORPgK7zNWlvXO0cxhEjp4OBMURF8miWePjItrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, September 6, 2023 10:42 PM
> To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPG=
A
>=20
> Capitalize subject line similarly.
ok
>=20
> s/suport/support/
ok
>=20
> On Wed, Sep 06, 2023 at 04:39:18PM +0530, sharath.kumar.d.m@intel.com
> wrote:
> > From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
>=20
> Needs a commit log.  It's ok to repeat the subject line.
ok
>=20
> > +#define AGLX_BDF_REG 0x00002004
> > +#define AGLX_ROOT_PORT_IRQ_STATUS 0x14c #define
> > +AGLX_ROOT_PORT_IRQ_ENABLE 0x150
> > +#define CFG_AER                   (1<<4)
>=20
> This seems to be AGLX-specific so maybe should have a prefix?
Will change to AGLX_CFG_AER
>=20
> > +static u32 port_conf_off;
>=20
> port_conf_off looks like something that should be per-controller.
Specific to agilex, will rename to "aglx_port_conf_off"
>=20
> > +static int aglx_rp_read_cfg(struct altera_pcie *pcie, u8 busno, u32 de=
vfn,
> > +			int where, int size, u32 *value)
> > +{
> > +	void __iomem *addr =3D AGLX_RP_CFG_ADDR(pcie, where);
> > +
> > +	switch (size) {
> > +	case 1:
> > +		*value =3D readb(addr);
> > +		break;
> > +	case 2:
> > +		*value =3D readw(addr);
> > +		break;
> > +	default:
> > +		*value =3D readl(addr);
> > +		break;
> > +	}
> > +
> > +	/* interrupt pin not programmed in hardware
> > +	 */
>=20
> Use single-line comment style:
ok
>=20
>   /* interrupt pin not programmed in hardware */
>=20
> > +	if (where =3D=3D 0x3d)
> > +		*value =3D 0x01;
> > +	if (where =3D=3D 0x3c)
> > +		*value |=3D 0x0100;
>=20
> Use PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
ok
>=20
> > +	return PCIBIOS_SUCCESSFUL;
> > +}
>=20
> > +static void aglx_isr(struct irq_desc *desc) {
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +	struct altera_pcie *pcie;
> > +	struct device *dev;
> > +	u32 status;
> > +	int ret;
> > +
> > +	chained_irq_enter(chip, desc);
> > +	pcie =3D irq_desc_get_handler_data(desc);
> > +	dev =3D &pcie->pdev->dev;
> > +
> > +	status =3D readl((pcie->hip_base + port_conf_off
> > +		+ AGLX_ROOT_PORT_IRQ_STATUS));
> > +	if (status & CFG_AER) {
> > +		ret =3D generic_handle_domain_irq(pcie->irq_domain, 0);
> > +		if (ret)
> > +			dev_err_ratelimited(dev, "unexpected IRQ,\n");
>=20
> Remove the comma at end (or maybe you meant to add something else?)
> Looks like the place it was copied from had "unexpected IRQ, INT%d".
ok
>=20
> > +	if (pcie->pcie_data->version =3D=3D ALTERA_PCIE_V3) {
> > +		pcie->cs_base =3D
> > +			devm_platform_ioremap_resource_byname(pdev,
> "Cs");
> > +		if (IS_ERR(pcie->cs_base))
> > +			return PTR_ERR(pcie->cs_base);
> > +		of_property_read_u32(pcie->pdev->dev.of_node,
> "port_conf_stat",
> > +			&port_conf_off);
> > +		dev_info(&pcie->pdev->dev, "port_conf_stat_off =3D%x\n",
> > +port_conf_off);
>=20
> Is this a debug message?  Doesn't look like something we need all the tim=
e.  If
> you want it all the time, use %#x so it's clear that it's hex.
ok
>=20
> > +static const struct altera_pcie_data altera_pcie_3_0_data =3D {
> > +	.ops =3D &altera_pcie_ops_3_0,
> > +	.version =3D ALTERA_PCIE_V3,
> > +	.cap_offset =3D 0x70,
>=20
> > +	.cfgrd0 =3D 0,
> > +	.cfgrd1 =3D 0,
> > +	.cfgwr0 =3D 0,
> > +	.cfgwr1 =3D 0,
>=20
> cfgrd0, ..., cfgwr1 aren't used here, so no need to initialize them.
ok
