Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4979BD46
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbjIKVhc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238986AbjIKOJD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 10:09:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CECCF0;
        Mon, 11 Sep 2023 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694441338; x=1725977338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vx3owzXgL9FREI/juGRe0rg79ubJ1bCM5pErr2PKYv4=;
  b=imrIWnrmxghcpZSICGEYuLRhs16CEbdMFaXyND3qaK6qWNCnbxw85bTr
   XYZGX/ASjbc3k7ZxK017vcJ3H0aiPO851amem+58926zM/LRX/J5QZimU
   0tbOXxwzo4KUckZi0wHcE2nDqRO7Dm+5ikUpLyIVa6v9qygZJHe7DroPf
   07AUNBNZkx0PqBg4/NRaMEaDXbWlAtkHHVA+LO7d3e+0KjatqZf4P7Pjm
   glbT6Vor5GxzX8x2C2EehrBTlO73kQj3smdrJfGCTv1sbeHqbCTS4wEuw
   EpWAnTLLXfCKrpDWGsgl0nIphI6alPFSFyOM9iPs4BPCWha4irZs+ZaZ2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409059772"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409059772"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 07:08:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778393922"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="778393922"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 07:08:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 07:08:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 07:08:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 07:08:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 07:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIrc7MjQj/GUPA2Co5MHkkOlAF5fGnax6VQkeoDzGziuyoYWxvT873Ne1gyNwBTLPazQO1zUpbe4lQPujv3Jmnb6nVCq2kkVPdUERxAqgkHgEEJNfLFT4C++kbZG7o1hxBAODBrkrr2KvWZGb82yTYMqAkVtHe8IjtkTm/zNvZLcDC9VoKk8FZklnT8SXb9HojtCoJnCrZVdbcrTi2u1G/Kiwr9SV8PRJLSaiQUdhbPi/Q1+hVTvEWs1kAc4/59m3tNDRuaAkGN4KYq+qPyMFdlHWQgfhLmQLBLSPoxc5Ivk1pkM5FPgqznJFIZx1Kh3dg8z1LqCRT5n8oeywBZA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwRj/60A6R4VvnM+3fQXezouw5s00/5nXy+mh6u6w5A=;
 b=KB3QYHmNUhg2PhiuyG99wWwOlosc2ejLrA6lqojOe4gJRteAtAyIpw7P1dPIUTekcsxOMiu8ojk9Z8TX07GCNeEQvyZ1vAukCR+jzCbv9aTLTeFLHTBAUXAbnGRHdu3clcb/TF9mTen3mwil6k+3O1rTwcAB0sgmhGKUZQhACNZurLOpZYevuQLfjA3zcmUygQu64QD/7ybD6N5riTaTvk6HpFyJo6sApix0s0WgGpgHWpdC+c5C+YQzx/espVHIxdwCH/rV+VBkvaJ9u7cqV22tbisv6Nnw59B8sMNtkh8qsfiqsIEdAoc3vYi1W6IfQKxQ/wzPfftzWZpsQTEVpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB4306.namprd11.prod.outlook.com (2603:10b6:a03:1bb::17)
 by CH0PR11MB5426.namprd11.prod.outlook.com (2603:10b6:610:d1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 14:08:55 +0000
Received: from BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1]) by BY5PR11MB4306.namprd11.prod.outlook.com
 ([fe80::e233:fa3b:bac7:9ce1%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 14:08:54 +0000
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
Thread-Index: AQHZ4LKiIDprQWqup0eKm2uSyqkaFrAOCSaAgAKepjCAADvsAIAAHRTggABYvwCABFgB8A==
Date:   Mon, 11 Sep 2023 14:08:54 +0000
Message-ID: <BY5PR11MB4306C166272CE86B65AD5566FDF2A@BY5PR11MB4306.namprd11.prod.outlook.com>
References: <BY5PR11MB4306D2438CF3A387403CF9E0FDEDA@BY5PR11MB4306.namprd11.prod.outlook.com>
 <20230908194842.GA304176@bhelgaas>
In-Reply-To: <20230908194842.GA304176@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4306:EE_|CH0PR11MB5426:EE_
x-ms-office365-filtering-correlation-id: 172bd0f5-bcf4-4914-87ad-08dbb2d0a254
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6XSXfdwOhzJIsH80+4pD8CbHQJXiPXAogHzhxmQbLHc3I+HWDGHhn0bWeJV49DPwB/EnvsPSvY7VB4KF1bVSqiif4IeD9Hq0ovpBvBmu3KCWNE5sPPFrbn8siJ0i9VRXbHplRfxjHA3pbTMWnQpNvXA4HYVVN7FYHhDMZr/ImJRS5bqWbVRDPllHCOMIPSJqgh1vOqiH92hmdekOg+VIOCupPemWpl4RvI7ExnxI28DmrfABTsP7PKBc52B9V3OQA+bJ34mHCJ2ldDYUxuPcpgWqR/BsTEIEA9Lj0yCgZ0+59zaZxVJe6FzZAdqfAgoyu3ty3TuaLfxdtz0A+j50knNkHIWfuwE+Urrj75g2CJgRc311Un9BEey/dBRRG8K/3I3fdlKvpJMDGFZ968mJMinz4c8B/CX0xkhhOuB+DAYjW+eomFRZXjCUwmkmKmVvb3ikFPDA5/Ax8wsKhnuIG2GTmkcRTgxsaStgvPBGJhLVmHcC7AWG+d4swxvDt8UrhncyNKZISCDUVU2K8svTiR8FXbB8i2xYVSvs0EVxqQ7e939f+DSA9dA7laWUlegdypptw/YBxDHBb5aRJUZ3tcuHkELd10iybc6MvGSigaA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4306.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(1800799009)(186009)(451199024)(76116006)(26005)(86362001)(2906002)(83380400001)(7696005)(53546011)(55016003)(71200400001)(6506007)(33656002)(9686003)(82960400001)(38100700002)(122000001)(478600001)(38070700005)(52536014)(5660300002)(4326008)(8936002)(8676002)(66476007)(66556008)(316002)(54906003)(6916009)(66446008)(64756008)(66946007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j1axkJGEx1CSTLqJ++mWa7SnAl+28sq11bjhhii7koAQZ4N3bj3TfoWLxgwx?=
 =?us-ascii?Q?3eZc2x1zqpuHieX1Jw8QMgsmMy7mAIlZfspnEd0lw+ZEf9Jn62bWowRows7W?=
 =?us-ascii?Q?+nz7nuanSOTjAqEhMlHwzAUL7UxknUGV/9ECjLfjhzE3opY8URMg9piYqEYg?=
 =?us-ascii?Q?ZSx31AK/ww/YHF0OOp09hofShacLfbrT9FN2xSGGFB74sgGN961Ro2N5bAyS?=
 =?us-ascii?Q?1m2dn6iO8pnZO1862h5kQQCZjeaSPSDLIzirMEfoRd3C0NvHIsxwu9UAxUVV?=
 =?us-ascii?Q?OybNlo4WbNbG/kPH9U9hNYNiXtdCreLdr6p3yFfu/jvdaGab4G+UouiPEJeS?=
 =?us-ascii?Q?aBAs1JVhSpK/OaE9tSd2mQIk+Z20UaxnifVNVzOMiu9vI3Tyz4bJ5U8mThlk?=
 =?us-ascii?Q?wKeiHh1rln98WyD31n/EYYU/Ges2JspkwtSFSsp6O1sUe/MTKJ5TRBz6Z1iD?=
 =?us-ascii?Q?rfmdo0WUDvMrLdHWZ00vXe2E9X5ZXY3Jk3LuiALADDSRqNwHTTI2igFm0aC1?=
 =?us-ascii?Q?babB+dG+fngnJ29z2OJq2DA4UZryH8pXaIJ8A7IMtbmdl+Yx5PBqcB2KVWDU?=
 =?us-ascii?Q?FMXVTsCM6vV0+svOh2KG/pPFr/NmEAdS8qRfB+MjhGlG8apbBDlJzUmYrhDI?=
 =?us-ascii?Q?WEqLjH3YLiHkKBF6f1o086gre3J+YQZWpIEKLmIqQl+tqZTSM62bpt6RQEHR?=
 =?us-ascii?Q?6GvXZWYUfcO7u93M2hYzNGJ7yR7YEUF1Lf6j8GcJecEtL8orvI0zyRLL/W+a?=
 =?us-ascii?Q?yNHKT9ScVU/pT2rugJ2VPWfmAsntLGVodwiowMX9ayCB8Gm6NORJkkw7dirv?=
 =?us-ascii?Q?cNsMyfQR4TV2kRqvZrJzOmznrcK/UlP6XlgFtLFlwmaSimD/D1J2GG5er1I3?=
 =?us-ascii?Q?YSWtkuAeDGVcto7sseOvrA0DZcrqJVvJVlJzsj6VtP1Sb1ELls+odpQUle9l?=
 =?us-ascii?Q?WsvYxZ8QAtnTTsPZ9fDtSKfsPA0psdBkzol6t0itBEY+U6ZhMkf5d8fw+GuF?=
 =?us-ascii?Q?i5urPr60iM2pwwRyCpDWco3NZHsVDOabtD4Cx8YLk9NE9fiGD/Qo26S0BLF1?=
 =?us-ascii?Q?FNrBCZNfwbOB+iorL17tXkTxY6ReiGQcJNvx/WuGH809e3LuY8VTLMsUz4w5?=
 =?us-ascii?Q?4LuI1hX2VtErVGraSCLjy+sdTQQdggsW1Y/h969CwG/8DIZtV8+83iuGTzoR?=
 =?us-ascii?Q?r8O029WgtAIkbKed+iewIYZ+ErLI7kZT4IrU90Yoo2YdhNphYkEJlQBKtmLn?=
 =?us-ascii?Q?LzsoPukxtQFB/Iqdc34MCuuw7sjMu/n2TY25cdh+N4r1Ab/zfdh5w8zqZ/MU?=
 =?us-ascii?Q?WjYpafkbOzCetF4BP3eXf1CU6eEsMYldd7nitAS77yjXsOnjCa7A4qk8iopL?=
 =?us-ascii?Q?YnwPa6Blvn5k2G1UmNfPSLXaXALgKEOuyrC0Q/bKc3jMw5hNjKwq0YIrtbwl?=
 =?us-ascii?Q?jnLbSzR6q7YVEk8c4fFwnVnLV98g01GCuN0BbXGx0BHCPnq6u4gqbAq+DaIV?=
 =?us-ascii?Q?4e5W2aI9L2obIiW8yty3BWPO1y7ZiRnJWjjPZGmmz+oDmHFyWtl8BpXEeiFi?=
 =?us-ascii?Q?qrn1pW4CedSO8abVAwLUuzXU11RVQ9YTuxyAqh97?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4306.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172bd0f5-bcf4-4914-87ad-08dbb2d0a254
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 14:08:54.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFpswaS7H5CKGeMOgERXbSwYkoqrgM0r1+tH6IjvryIAo6u/ArOWcXKy9gCzN3/gEs2a3Ink08xXjzo34O24KqQpizx6V3ARMSPZ3NbePlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5426
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
> Sent: Saturday, September 9, 2023 1:19 AM
> To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex Family FPG=
A
>=20
> On Fri, Sep 08, 2023 at 02:35:29PM +0000, D M, Sharath Kumar wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Friday, September 8, 2023 6:17 PM
> > > To: D M, Sharath Kumar <sharath.kumar.d.m@intel.com>
> > > Cc: lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> > > bhelgaas@google.com; linux-pci@vger.kernel.org; dinguyen@kernel.org;
> > > linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2 2/2] PCI: altera: add suport for Agilex
> > > Family FPGA
> > >
> > > On Fri, Sep 08, 2023 at 09:15:09AM +0000, D M, Sharath Kumar wrote:
> > > > > -----Original Message-----
> > > > > From: Bjorn Helgaas <helgaas@kernel.org>
> > >
> > > > > > +static u32 port_conf_off;
> > > > >
> > > > > port_conf_off looks like something that should be per-controller.
> > > > Specific to agilex, will rename to "aglx_port_conf_off"
> > >
> > > This comment was not about the *name*, it was about the fact that
> > > it's a single instance that applies to *all* controllers.  It might
> > > be the case that current hardware only supports a single controller,
> > > or that if you have multiple controllers they all use the same
> > > port_conf_off value, but for generality, values like this would norma=
lly be
> in the per-controller structure.
> >
> > This driver supports 3 controllers/family ( arria, startix, agilex )
> > This variable is only for agilex What is ur suggestion ?
> > To add in controller data structure (struct altera_pcie_data) ?
>=20
> That seems like a logical place.
ok
