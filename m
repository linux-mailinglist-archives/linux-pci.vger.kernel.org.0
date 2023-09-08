Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BB798809
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbjIHNkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjIHNkV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 09:40:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E364119BC;
        Fri,  8 Sep 2023 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694180417; x=1725716417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AjZcyxBLVT/zxj8syABTUTVpYJ9nS5qKwCZOGPiKGgY=;
  b=h8MiIv/4+vPbQnPkmY+0r+6EKx+z32XDZSa9STC3RDwfVQ6VKYReLKYK
   kA+BRpbuobSrfaV32/nYX3moM28SUrbWYc1SY8SWsmHr9jNw+ax/UMiEZ
   D86SPAZoRyDcmemnTxcRW3C1wIIM9yIeZCT6x0u17JXUNZ/oh62WMP2q3
   SKk8MFYqNjdvILwotOLXWbKqCoMSXl2sLj0nWGUJv91H8nNiRVhBCSZhz
   ekAnDi0bShwPjoRhe+oymOXBljzywWTb44a/L5M7Hq5QwFrNzmLAq2Ue4
   nNn8bH0AO2SanSkqs1O5LBv7aUZHxnmdq3mptuFXCwI0QlxUYKgwCvetE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="377555746"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="377555746"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 06:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="745612486"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="745612486"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 06:40:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 06:40:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 06:40:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 8 Sep 2023 06:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1vyQ8BI2SkOQx5vjf2VQamwqJ4ZEieKXUBdkQrdRsq9KlKp2gstP7b2uuxDjoNqDR3Dq9L6Znu4YKl3kSH3jzsrfPva5oIyLiW/fv1olD1nIuqfLB14MB9gjs+GZ7by+bK0fEJwRH06TDCvTZOS+z8WhHfxjbw0rteXtG9TdoQFJJPUQSvxKKi7W8z3/xYzSFaZKhysNfG3OA4dmlo1Q7m2XXEj6dy+UlXu/EQSh2lXyRwGQiLIzy7Ochffb0EJj0N7bfChppcvVQt1bw7HmNI49DeBU06RAthfSExYPRG42+4t/n9mH8tzQsgWz8ciFFlwuTd9XI5GhTsCDYQWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uo5fgf12r0H/9hWMETTdKOPbSLgJX203JAdSkLO6SZk=;
 b=Tlq9G/OKWdCs34lgkXRdTrWfhj7LDytPfRb+A0z4DSmMAIAbIxuA3LTjvygNTIN3VIVZJRAUCPTSQlc9QMORrBBaM3ujfY+kuoGgdOVpYQKAriMaE1yBkJLI9kYQnbat5DhFQMQbiNvC/Y4eBcZqQhG0J+9hZbC/CBkClRLmhEqedf4sdz41SzaVqz2ETZAh4wdY9v0epRgvsDo2HQEGxMfCML4mHW7w7xDGfXYBbTnq8HK03VkL9H2XlUaj4e6KKeZWFsQUxKcvLfzd+ZZIhkwsg7TxfiNrbg78aNFzEy9Iru/VSABqlruS4765xB1prfH+QuqmAfXDdDBQv49FHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by DM4PR11MB5360.namprd11.prod.outlook.com (2603:10b6:5:397::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 13:40:14 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 13:40:14 +0000
From:   "D M, Sharath Kumar" <sharath.kumar.d.m@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Thread-Topic: [PATCH v2 1/2] PCI: altera: refactor driver for supporting new
 platform
Thread-Index: AQHZ4LKfP35QHhRaeU6oLkLTKU8nJ7AOCAkAgAKeUdCAADyNAIAADpbA
Date:   Fri, 8 Sep 2023 13:40:13 +0000
Message-ID: <BY5PR11MB4306A066509DC8CB2ECEC164FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
References: <BY5PR11MB43066214534FA7D1604E0F78FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
 <20230908124404.GA292360@bhelgaas>
In-Reply-To: <20230908124404.GA292360@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4306:EE_|DM4PR11MB5360:EE_
x-ms-office365-filtering-correlation-id: 2084ced3-1013-4c26-f1fd-08dbb0712178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YnmCDZT5d5bDBcBaLDCJJiAIsmuzjauE0QS+svAbFYZPOsb3EguK7+qlQ4iWEi8cZ5fVtJktMbglJ0EnOWkye2BW3NyPGJiyXtKRg5RPM3j+BkZ+WhvWWz7Pes+Q9kuGtybUnR5p885cpc33QLo2faMjViIvFezFUxxq+gdTvABCioZiimVsZJsxFjAOfZ/SKsqHCOtl/Jknp4I8ocxrsUmolrzl7ecMXdSuqz8xjd0oJii0rFpcXv2sqXnSD6jQucafOYwYvojkHFgQrn3hmVmG/8A6KE3uYZiSnyG6sJ1G/ztvAU5ryhtvM9ZQB4oXycgiOlaynWsIuEGeE4oKtaDHScrkX0xvbwLraahrptNJ3ydhs2HI9zpZRdHXOjfw26NqUMtOce8ugYLuQlBUlMuiLGnjbzv06nMdTWsVN23jFGSsq9UMh0k60mnZOGwIDc5jjoK68nwC1tOEk6m6LwH8g70DkMEmZ9Ox8tE8ByoAjhEYQ+IHXmNzOUFzqrx4Tw0mv0yHF6phEVWpwOhgtFDTij0Qk0AlqsaNqirAsMRpIS6+eklcoMelR2ed16Ha4m/ypM9wwCaAZ8iud5/vucf6ZvWfhltZ5k7CgoIeije0ggKrBx2gBrl3wgpfmR8Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(186009)(451199024)(1800799009)(122000001)(82960400001)(66899024)(38100700002)(55016003)(86362001)(33656002)(478600001)(2906002)(9686003)(71200400001)(53546011)(4326008)(7696005)(6506007)(8936002)(8676002)(52536014)(38070700005)(5660300002)(66556008)(66476007)(6916009)(54906003)(66446008)(66946007)(316002)(41300700001)(64756008)(83380400001)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3jJZIv21YfcoHFmiQQoEotrICzra+oEyqZSJlvoD8FH4B9HyiFX2blRj8C7D?=
 =?us-ascii?Q?BYGVyDhCmd+4A6E4bBw16C1r5OH8Jg5lwVN49jg5PO5D5daRZuKH9qX7lMlX?=
 =?us-ascii?Q?eFac7sYHATB1agd+FYY7tmJ5ndaTjjs3HXBAbF6uqveV2zy4HIIT9ek7otRY?=
 =?us-ascii?Q?0CA9wTnhJEre8/BeHvxgL842khwyRs4p37dwkee/W6xc/wZ84f/OgrTNgClO?=
 =?us-ascii?Q?1Bzl9dWarMR9TII8n3cd2qlpW8ApT7q3stIibWMEsqxeHybVcdR0Vqksyd21?=
 =?us-ascii?Q?W/8/Qe5JkdXTCZT04Tfsy08NfPN7U7/fdUdyIgaEiHiwH4JbnxmI7kN2Aem9?=
 =?us-ascii?Q?NCbzgIkz5X/uH3D88lq6NYO5osOetw9bO2JvnI2VyFJPaiQ42MpzoV/yubRm?=
 =?us-ascii?Q?7RxVdE9ygHKsWpc8y5bIHsdbojnjfp+LDPsPljNovcK5LlyX1HEBlBSF9og3?=
 =?us-ascii?Q?q01HcuceR4HjTxgbg9ERJr81eqNxknCjjgf5C6fGpZxkIXbUeguOr9/ifmER?=
 =?us-ascii?Q?9bBTugBR5j+4JIGSaTMsCxUJdwdAkHHI8Ntkr+fG7Oz663fRQqiufLc2/wt7?=
 =?us-ascii?Q?6Gs5f7ba0R9+WMus5oXh6NmBd5HIyAQ1uQAtIFEB3/pbE/Hnsj8lz9WCpY/l?=
 =?us-ascii?Q?jguay2p5BYHRv7EybCD1v2G38V+QtPkF/zuMR3wQy3HjscoHIOZsD5LqQKYF?=
 =?us-ascii?Q?UFGP9baoRqOp/tXRpR3mBicLCwbW+uEbhCEJFJd3q2T53+AxyysTBj3/HDnj?=
 =?us-ascii?Q?K4EnVPxcNFwBZtnmcPGgw5v3j14hAPqYQwmeMwff4bxkCDGjaFLI0vGcZbfZ?=
 =?us-ascii?Q?SRBrsJCly6DPOifdF03udq4KneZZnW8KN8ERvMZfK0cx22+517m2x20EkzU6?=
 =?us-ascii?Q?Z/o2bSa7ljDSqmxV5/bMt1oE71ivxeWWsZnrbmnGVvc19mUk8KGp7vBnEaAo?=
 =?us-ascii?Q?wh7I6LVi0bw2VJVV/jDrwbj9hJFcfM76ObzxhivhQjCdtZKR177zahMQhZem?=
 =?us-ascii?Q?gTbfQTaiV5c0XPlrIQoSPbReTLjAdY+rS8NW5eyA82rzYNfgK+7zA0sJi0sA?=
 =?us-ascii?Q?8Xl+hNU67p/iXh9SS6IplwN1TvJ1auXb6n/F0WYkuEzD/lHhBHD/adeGp3u8?=
 =?us-ascii?Q?EOE4Yv8EG4goXr63Rpe9ZnfZ3LT6R2pB4mI0naRxMgpGEiWXeaOTRLcExXVC?=
 =?us-ascii?Q?1yve7B8Ur5sNflSkia+gV9PUIuFz3gcsSU9pc4gODUApxTaV8VyNrefgh69Z?=
 =?us-ascii?Q?gcQRNjZbW9zLuCknKkwZkJgVxPxM0U+urvzZ5nLWRnzfxzWIh5pasFnAcTiV?=
 =?us-ascii?Q?uh4Elds8Xb+4/8kOEBKMMCPfkpDGhXBIm2QZvhDitO362n6BHQZ516VhS0Eh?=
 =?us-ascii?Q?hehgL/mHzfJ9mFmSH4ikL7jNdLfogLWkQ4OPJF6SHxHUdj2sGGq7oiQQwg1R?=
 =?us-ascii?Q?SYIR8DPx9rqusyfUQznqD2knkqPnf7gyHcwj9VEbvhIvaCu2Yi5yJOHfXxrR?=
 =?us-ascii?Q?PdqgBc022h3VT+OsfJBLAumGJK++b6+v4VqWcvag32Y7gHph8lXVrrARY4Uj?=
 =?us-ascii?Q?Agpzv5C70BiZ3J2Ahb0Ri8mYwSRwkNLLW9reHyFV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2084ced3-1013-4c26-f1fd-08dbb0712178
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 13:40:14.1866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfN66AN7jLEyUpTlcmmJMKJZFL/lcmYEwqSd6r4lafWxVywE0zhMhpDhyPIbOKIMuZfdUBqNlQ4vOYNjslTIOHFpuJXSP5dFUWPn0lw3Q9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5360
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Friday, September 8, 2023 6:14 PM
> To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting n=
ew
> platform
>=20
> On Fri, Sep 08, 2023 at 09:09:34AM +0000, D M, Sharath Kumar wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org> ...
>=20
> > > > +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > +			unsigned int devfn, int where, int size, u32 *value);
> > > > +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > > > +			unsigned int devfn, int where, int size, u32 value);
> > >
> > > "ep_read_cfg" isn't the ideal name because it suggests "endpoint",
> > > but it may be either an endpoint or a switch upstream port.  The
> > > rockchip driver uses "other", which isn't super descriptive either bu=
t
> might be better.
> > >
> > Ok will change to "nonrp_read_cfg" ?
>=20
> I think the important point is not whether it's a Root Port or not, but w=
hether
> it's on the root *bus* or not.  In other words, I think the driver has to
> determine whether to generate a Type 0 (targeting something on the root
> bus) or a Type 1 (targeting something below a
> bridge) config transaction (see PCI-to-PCI Bridge spec r1.2, sec 3.1.2.1)=
.
>=20
> There can be non-Root Ports on the root bus, so "nonrp" doesn't seem quit=
e
> right.  "Other" would be OK, since that's already used by other drivers.
> Maybe "type0" and "type1" would be better and would fit well with the
> root_bus_nr check you use to distinguish them?
>=20
Situation is
Root port configuration space  - memory mapped
Non root port configuration space - indirect access/proprietary access
    Type 0 for devices directly connected to root port
    Type 1 for others
> > > > +static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busn=
o,
> > > > +				 unsigned int devfn, int where, int size,
> > > > +				 u32 *value)
> > > > +{
> > > > +	if (busno =3D=3D pcie->root_bus_nr && pcie->pcie_data->ops-
> > > >rp_read_cfg)
> > > > +		return pcie->pcie_data->ops->rp_read_cfg(pcie, busno,
> > > devfn,
> > > > +							where, size, value);
> > > > +
> > > > +	if (pcie->pcie_data->ops->ep_read_cfg)
> > > > +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno,
> > > devfn,
> > > > +							where, size, value);
> > > > +	return PCIBIOS_FUNC_NOT_SUPPORTED; }
