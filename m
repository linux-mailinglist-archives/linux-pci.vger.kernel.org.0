Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7499379848C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 11:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbjIHJJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjIHJJo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 05:09:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E321BEA;
        Fri,  8 Sep 2023 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694164180; x=1725700180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Kq8IgXZJQGpfNSwuMSYf3UYTjfop2cM+b3s7YW2sbyk=;
  b=lPDZLkIt3fXUrmVdL85Wq3afie2OGYbxBvs27V2bAvTX4KW23cr1RvJ2
   KBKChxCS7oFMsEZtVO74BWyd6VJgBcVjpUMk4p/qRVjK4xnnOCnUm1C/Q
   mWxQ2UpndG1i805B1RFVXipLG0muHeSre+SfSDlnN1H5c8lz4mbppVxMg
   rNCpMrb35wBcCERMl1HEo28m76WjiXsE8MicJAoAQ1DhGSVovDJoCGw1T
   ZCEhvONw8Hb75/tFtG5BKyzcdhPTHMAezlcOdd6hj4LO4yl0xdGkGy2+V
   ez2A7XnHgIRlfCxQ1OM+/yvJiydyT+M9V9O7Nmw9zsMfR0T/xhWR5GHhb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="357908018"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="357908018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 02:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="1073257668"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="1073257668"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 02:09:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 02:09:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 02:09:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 02:09:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 02:09:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LULd5b88SnXUDe29+Nb8kj2EzkHU2IXYSgA9vM+HtwN/OPofXOsxcUSr9zaDyJZ5zFIVDx8A5Qvn3DuM3kUannWjJNilV16sQMbXTWMUc9Q40ytXFNkoWW+oaf8Z6N8MGGc3b6qDY2R9WBOJG6kiwW/L2xgyELCOemtDGAnSwugqR2o1ZErhrYt3VMMCOnLPZyIs1eY+232qHprni6f3C5VWT9Ir5myWNbs7D/dW47V95rwfeOG1GATuVS7ReX54z044wn8q90TDm1Da7yebOhXcgkcc+89aVehO66LDwt7PcbxYkmK/nG6bQzPSn6Vc+N8alIZoVYL821TovNCxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oULcXMGiBxvM9cR6XHIdbepSeAC21uwPyfFir4xBpU4=;
 b=Tk1boalNEN8rgdskWxxBCmymJnNM+fgS0kVV1aS1VulMX1oRMlSyRz4qcYPBeVGRK3mzywWNAqZBQoLrV81wHIXEZoUcHTPhwElr7a6HbUyYB1XzyRCY42ri3aSKOHKfaJRijGswJq4ZwULbj9aW3xHVj/CaqfrwrWTRt961FuSzccX9efRB6A6iSql4rEEFu8RI9tSEkNnoPW9LHkrQKQ1PTX+i1xttEnQ4Eh4QAwROvs4yRtgInulrkHtg00aShu4VBeprl6yRtKZRxtQq/h0Y01C80uOdSc6e40HTE4rXVqdXGJ2NDlYeP9E3IMtywQ5I9g/PNZsNLCKND4az8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by MW4PR11MB5890.namprd11.prod.outlook.com (2603:10b6:303:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 09:09:35 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1%6]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 09:09:34 +0000
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
Thread-Index: AQHZ4LKfP35QHhRaeU6oLkLTKU8nJ7AOCAkAgAKeUdA=
Date:   Fri, 8 Sep 2023 09:09:34 +0000
Message-ID: <BY5PR11MB43066214534FA7D1604E0F78FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
References: <20230906110918.1501376-2-sharath.kumar.d.m@intel.com>
 <20230906170812.GA230066@bhelgaas>
In-Reply-To: <20230906170812.GA230066@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4306:EE_|MW4PR11MB5890:EE_
x-ms-office365-filtering-correlation-id: 74c5a590-5ccd-4a74-1436-08dbb04b520c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iswqEYtRD1kx+cHnhVK0OTus2FLPEPB2wVCJuA9kSsvBQzCsKh2HUymdmtDx9g/fHNzR2dAjz1/Uy+YZUX3pIi6wfRv8wdXxS7+8We15nDGUebkQ99Ld9tc9+OP5FT/0axmPa4GMVgVSQeIFw1/kHM02lrXiLyxEQKaviyVYJXPrMuOXjj5ltWbOqszLOxkVIDpbTJxBgrzweZOxWVyePDYZYDzjHcv7tXMX/Sh3ZkosQJtp5bCp5fPDRwQdwqMTOn/uJ+DqdyET7P4Z3w9pgEARMc5aYZyt0WQHB/57PCuxU+746SrgSeD4A4m85Z4qWuoSFG8a0QH3wQbE9APjdNRFTLF0kB6nKLkOzcAS2GCSZe+XvUNNq4ohzS+LrcR6vKrXCoRTSJwL5kee/fKJ1x8t7HoNyLtJGCc8DA5vS/ZF9AqEGZb1z6k7X0xehua3DzXJ5j9w4DHmYxeLBTrX1Jd/tN3R9a01JpWSOgz1H5nh0xL9DOfvcqdFKkp9QX/SoDErW6++UgDKPU51LpLoTuLkd/35xASG0VXwb2oU7Lqphy6JtBusNxWxCeB9q/L7ASFVloGE043++/E1iesgRGuhzC/eqmDFKCJMYHrffHCDCbf9EJtHG1VJ0S4cU2NW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(1800799009)(451199024)(186009)(122000001)(66899024)(71200400001)(53546011)(7696005)(6506007)(82960400001)(9686003)(86362001)(33656002)(55016003)(38100700002)(38070700005)(26005)(2906002)(83380400001)(52536014)(478600001)(41300700001)(4326008)(316002)(76116006)(8936002)(5660300002)(8676002)(66476007)(54906003)(6916009)(66556008)(66446008)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7cNwcrWMY8VbhYOf+r1U+AUQHvG7dWiGOgoBR+OWvWncr7jfMqPVYnbUxryu?=
 =?us-ascii?Q?mEYf6GUwipAwQEwpwYRBUKYoy0UumtXn62IDX1rDlIW01lysjfdeHPF2Z0p4?=
 =?us-ascii?Q?uUhRuWpT26iO0OQW+2BcZq10QD8VPbK65q022CQLfvILHoZDncYp0eSvwPa/?=
 =?us-ascii?Q?eBK46lW38y+uz2ES2hSHjIb+QB5TpMedQtK7PcfW4pcT3wr8W8LxPdBq5ED2?=
 =?us-ascii?Q?aK7m9UtpG0R0fdZbt0N9N2TkZYhXn+BrkLIJerdRdHyWYTluqs3YDgzDE5gT?=
 =?us-ascii?Q?/TM/Yn73C8QgCgZ9lyycyDXH5uJMp77PPVsRNZfsxnOiosVxnEI284BGE7qF?=
 =?us-ascii?Q?95vnQEShRt6b5rDqbAfP41xgvS4fP/u6wl3V6s8hW7aFEOdlikcRWRv9l9PH?=
 =?us-ascii?Q?bPdeyOJKCZcIBJQkS5qJsNSjjBHA6APIsEok0xY84dTSR/8zpwNFuxnHmkba?=
 =?us-ascii?Q?JqkOaC19FgzC0+OVgUDW1vRRhQuLD1AwJwYIeJn0xMV2GNldiitzBxnk+Aav?=
 =?us-ascii?Q?nTeW9q2V9E+hO64W12w45+IqFPMslLbWaM/ZDun7VCjgizrTRAj2SopMH7rV?=
 =?us-ascii?Q?xfZaZblntVQ2PNjxl3qSGlaGDXgb2xAyfshSOsdgDsw5Q0AFvGfjd9Mt/GEZ?=
 =?us-ascii?Q?iEDZMTZB8goIAVWoAFF77V3kKkMMe5mBZVtxVjV/4CRQ0ZpZo1hA5oUqntG0?=
 =?us-ascii?Q?/dVy5D4y63Us16JjHwkAXfCsxRW9NNtTMkx+vGjaN2Qa30N5PEUyYfG2uWZZ?=
 =?us-ascii?Q?FcEn4P1hDVgE5Q3FLsqLKupd2dB8hMq132+rezlJaRjEDGY83wQXncFC2bFl?=
 =?us-ascii?Q?srLCT7SICulMfECWc5ENrRuJ1pqU/UvtywJCdGEFN+/8Kht2S4E2bQqhbvQv?=
 =?us-ascii?Q?Bw0MQFARiaCKC4/6lB0toufjlDBwcaG0bfdHSBUGQ7awMYhDwItB6YEBPKFH?=
 =?us-ascii?Q?NGV1hfccChgxDQsOHES99C/AMuXFkkGGlFHbWwffnMfGqyOter4d8XvtTBji?=
 =?us-ascii?Q?GWOomij0ipmfTbLwdoM/zr4/Cz8/KHpHFqOfWyVqHkHwJ6/yS9m79wb0a4R2?=
 =?us-ascii?Q?J+XUWGOsIrXhh86ZWpHWINoTh38ud8sBVfRG0qAjT02KmJIaEOs8K6yFIYaH?=
 =?us-ascii?Q?35c/t/622eXJDHewEr3T5KRfZRmrFOEOBurzMBXX5SgOJM24qrS1STFMQFNa?=
 =?us-ascii?Q?+IQTdwlyQu9u/fXGN6QJ73MnPG2v9/3QDjfClT58SIu/fMhUalraOGXBqjUk?=
 =?us-ascii?Q?N+Fhq1MVThi3041Ul/sD/tRKuNF82b8lQP/8whyPmBS0c6amBaTCEB6owVCq?=
 =?us-ascii?Q?houSuxNu75vwmjgLg9MgzRMhK1LR4UKptZYFzjF/ncKnBc0S6AMdMhnEyCj6?=
 =?us-ascii?Q?NxR241/yqbpv3Ml5Uw3R8G+nPhkG6tB6drAqZRQ2yXj9nSoZ/fOosztjJfOC?=
 =?us-ascii?Q?7taQreKCOmAN9qQnU7W+YesO5O0i1IEaSEqnPZiO/PgZ+UMGbFOHV1RDwG7g?=
 =?us-ascii?Q?l/sAxWZ7H2gKhqoG3IDrSVBX986pxvI693NF0T36Vga6AEsbvW26/JOzXhle?=
 =?us-ascii?Q?Vqkn1Ie0W9Ft7aR0ttyrjZXwlnfMO+UoG4wqc1HdSoiy2D13pxDgee9ahFg0?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c5a590-5ccd-4a74-1436-08dbb04b520c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 09:09:34.8232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cs0gJ3crT1iu441m6oCNbJP7NbSOpo2b34WCuHaezkK8VP7dt2qlvoy6u28GhrJxWaHissMu02HIZ41iDCwwjvBq0p6qn85Uvu3v0fH7Lfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5890
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, September 6, 2023 10:38 PM
> To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] PCI: altera: refactor driver for supporting n=
ew
> platform
>=20
> Capitalize subject line to match history:
>=20
>   PCI: altera: Refactor driver for supporting new platform
>=20
> On Wed, Sep 06, 2023 at 04:39:17PM +0530, sharath.kumar.d.m@intel.com
> wrote:
> > From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>
>=20
> Needs a commit log.  It's OK to repeat the subject line.  Also helpful if=
 you can
> hint about why it needs to be refactored.  In this case, it looks like yo=
u'll need
> to have a different ISR for Agilex, and also something different about ro=
ot
> bus vs downstream config accesses.
>=20
ok
> > @@ -100,10 +101,15 @@ struct altera_pcie_ops {
> >  	void (*tlp_write_pkt)(struct altera_pcie *pcie, u32 *headers,
> >  			      u32 data, bool align);
> >  	bool (*get_link_status)(struct altera_pcie *pcie);
> > -	int (*rp_read_cfg)(struct altera_pcie *pcie, int where,
> > -			   int size, u32 *value);
> > +	int (*rp_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > +			unsigned int devfn, int where, int size, u32 *value);
> >  	int (*rp_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > -			    int where, int size, u32 value);
> > +			unsigned int devfn, int where, int size, u32 value);
> > +	int (*ep_read_cfg)(struct altera_pcie *pcie, u8 busno,
> > +			unsigned int devfn, int where, int size, u32 *value);
> > +	int (*ep_write_cfg)(struct altera_pcie *pcie, u8 busno,
> > +			unsigned int devfn, int where, int size, u32 value);
>=20
> "ep_read_cfg" isn't the ideal name because it suggests "endpoint", but it=
 may
> be either an endpoint or a switch upstream port.  The rockchip driver use=
s
> "other", which isn't super descriptive either but might be better.
>=20
Ok will change to "nonrp_read_cfg" ?
> > +	void (*rp_isr)(struct irq_desc *desc);
> >  };
>=20
> > +static int _altera_pcie_cfg_read(struct altera_pcie *pcie, u8 busno,
> > +				 unsigned int devfn, int where, int size,
> > +				 u32 *value)
> > +{
> > +	if (busno =3D=3D pcie->root_bus_nr && pcie->pcie_data->ops-
> >rp_read_cfg)
> > +		return pcie->pcie_data->ops->rp_read_cfg(pcie, busno,
> devfn,
> > +							where, size, value);
>=20
> Several other drivers use pci_is_root_bus() instead of keeping track of
> root_bus_nr and watching for changes to it.  Maybe simpler and more
> reliable?  That would be best as a separate patch all by itself if you go=
 that
> direction.
>=20
Will not take up as part of this commit
> > +
> > +	if (pcie->pcie_data->ops->ep_read_cfg)
> > +		return pcie->pcie_data->ops->ep_read_cfg(pcie, busno,
> devfn,
> > +							where, size, value);
> > +	return PCIBIOS_FUNC_NOT_SUPPORTED;
> > +}
