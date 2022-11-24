Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E8636F7C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 01:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiKXAyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 19:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiKXAyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 19:54:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A6CD32B8;
        Wed, 23 Nov 2022 16:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669251251; x=1700787251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s7cGAyOPGtdv8GMXyOMpgeobL8sQ2pHnknCF2QXSRIk=;
  b=QCv8JKJMdl9pQuy6AeoyMr+kG2CcpGyX0HoYXKJ/zjTYlQ5JL4sObh5P
   LxfqkYGm2T7JyxHJbtVOJCrjAz8wNFvXqggGpRRNr2cncYS6yDWCvQ8Dx
   c2NJQJ9CZFV2SgTKQN5saUtPJN6CU4nHp5XSIglx5GMqxGwcDHC4YIEVm
   vkygUM+7WZYDNYRj4dMx99BaA7oAARI8c37CCQ/twlVmq7d5vTGtkBM2l
   jp+0kcvTCW20XOibZfDqLJxt5C1e+V9jdcidlkDP8Mxyq3zAChvLObkEE
   ugQZdhws0CQj3SEqjqdkyGceo1KK4BXOQ5S268MIEXnXSxGdFlA5ezi/o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="315339416"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="315339416"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 16:54:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="592715310"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="592715310"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 23 Nov 2022 16:53:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:53:48 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:53:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 16:53:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 16:53:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+Zqod0NEoEMCjXulniW9c6sDlCRYcHh7VXgkyJ3zQsNtwf8q7yCS90zTaks1joAnCLpPsn3Lp4jtD6gfQ/fykycLw8hqOmv5L6yOPq99oF5lV+eKzqwoN5o7FDg/IjmD9E87RT5EAGqfRsLOOYCNqT/HpkNfmKpTS4gr54QtOK8SpxabzmtqsO50EeX6XCTdabhcR/gJzFj0YJdb6bllNZiSY2SMRnf6PCEwotvlAUg9ZNWDrtTAucxG4rS4mSamjVyiwDKjrntG46bd1wcT+am8kBXxcfWABQZ3sVGfmD6CDO8HF/IFfAlUoPr61RHtgqU/2OkOmxDfJtORVQ8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/t+xKrHgrcFb0iVpY7/s2VrwBCa06JstTHJ9+XNqbMc=;
 b=aSm8FZ968EmJ75HE7uKw3C37rzXa+W8hkEymbCupftwVoyWs1ps8w0BBTaB2HWLBaEsHXsJhwfQBgK80PBzdlJELq2T/op5DxFGOokFpTf/P8Uv/OZUrDLtMLOSSzsyr6s8jF+Xhb8re+4xrBrG+Kuwt9dtKSn3GehwMKW02E0rX4aW23E5TVDUV51M4vNFwH46jyWyWtq+OKnI5ydqCrhXUVghoAksr4GD6kytWZ0w+BAP9QvdAf+EEUb5ItwzjO6GOibJW2nZlYi6sO23A34wikWbOWVnBBstpqnjb0FWn8cYKrPgmNC4pJMrEMy4ZVUaod1unVFQ8MdUBrL9PRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6777.namprd11.prod.outlook.com (2603:10b6:510:1c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 00:53:36 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 00:53:30 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 02/33] genirq/msi: Provide struct msi_parent_ops
Thread-Topic: [patch V2 02/33] genirq/msi: Provide struct msi_parent_ops
Thread-Index: AQHY/bbfZgnIzHqDcU+i9IUI1W3Xhq5MB7NAgABaboCAAOBlEA==
Date:   Thu, 24 Nov 2022 00:53:29 +0000
Message-ID: <BN9PR11MB52763BEF1A4C88368B8A9E448C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.604272160@linutronix.de>
 <BN9PR11MB52768F0E5B9A4D8E2CF9C5578C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <878rk1gb9g.ffs@tglx>
In-Reply-To: <878rk1gb9g.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6777:EE_
x-ms-office365-filtering-correlation-id: 3d0f62a0-a2f4-4185-b0d7-08dacdb64dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RwYca+s6dKVs8jQDc7F6jFn00+cECSWwFBZbi3PtNtoZOnCF03y9Fy2ECYaMGqc3yFDE6JepUyM9rxBSJh/njZ4VKM4Wu8+ilmUXpsBOrnwIWknC3YOovCAtM2emef3R7HD4avGpoXGQN0+OcwsDrcCBa/z+gE2gQopljt2l6ebVLylA9qRj9riVyk7HjX3ztkjounrGGTashcP3CjPlrTAWgtpUfDTz6y6vBsoiLAEtGpvnx4+MR781pwqSfkr2jXxxFRMj7mR18C2uaXzqMIpWNORB3URBcxdrDKA8+3VtkkWyvoGA5uUD57aED9AGZ2S+F1mvENWQAkhTFbLOZF5ZvPjRk511J9Ldw1atA067+xTariL6jUtJN7a5xQnUJL5Yh1ZzTe8e1Xzx7D4dBADMdyrhAYeQcscSx+q+KkhqST0BbvOSCovyhhvY3zXjLVXblUvvSFK92nN2f/5w933hD+6lMZbnTDT9A9lgo1GyFOkGPEZidXOojpHfNyk1XzCG9maf5aOdmlhMXxxHzB422G/hcAa+BTERNonI0kkzU9ACke6j7T74lLUInlZrYjfzd4G2VvQhBkLm693RRlJv4Fx2DX6Rg4+zC0g/RJMezp8Q+01S9HP2PMIosR+Hkg5+N5i0kQEya5KAo4H18+0ypzEePHz36D7OPNgi6IX5D/SLCTG7b3RD+a1yuIW9W7fiYSQfohTLaqSwJ49tUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(396003)(376002)(136003)(451199015)(478600001)(71200400001)(66556008)(41300700001)(64756008)(8676002)(66446008)(66476007)(9686003)(7416002)(66946007)(4326008)(52536014)(186003)(26005)(8936002)(54906003)(316002)(33656002)(7696005)(6506007)(5660300002)(110136005)(55016003)(2906002)(83380400001)(76116006)(82960400001)(86362001)(38070700005)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pR9gdYzBOpxtNbvTM/KaSQxmxfr6rkGetBFG2nkbDen8k2m82X8KzPRzI7FE?=
 =?us-ascii?Q?3xZ9oI1GGyTuup70S4JTUpUeisxaEcSyNGxtQN2+H1ATr4YtKKgTyg/DsSy6?=
 =?us-ascii?Q?wIw5aNGpgKxOZ7O2Bw3TOFDfy1AhQZqYZBxGAJUUhPMNtnbL+frIECkMMfcC?=
 =?us-ascii?Q?a7QYeW8ktO/uoIFO+TNJurWcwOTv8inrB2k/yAG5QJ5YftzEtYU4P6DBnNqT?=
 =?us-ascii?Q?QEW4Ai+lyF3JiThTja2sBSaaCwTjpVRD8zeJ5LIO9hAnY/Mn+KP41fO7GZHu?=
 =?us-ascii?Q?aFVyImcfzj41Bm84JJeCFEJJ5dTePZkpLO6QPTPl8ZGcl5Z8CLZQkWdNUkf2?=
 =?us-ascii?Q?Xda3tCeCMh5Y7FURPv8mnIToGV97Mm20P4Zu2erhfulXJ0BUMqXrrI+02IDE?=
 =?us-ascii?Q?6NVzbiP+JaQrGb+TZKGdGVWtLLrergh6/1YPd33J7WqjCUnX/jHEyCwfRQpx?=
 =?us-ascii?Q?q6z1/UfjGbZvxtV1LP36+12iNrOZccw1L/tr0y58ozvPE1VBlHnRUCSpr0jh?=
 =?us-ascii?Q?fD5N/JEU1PjrF+OgIsfWOGeHcT5ep/3rGvr9NzGMducJdKWDLQOMuQdH2xW/?=
 =?us-ascii?Q?qcxtcfwKLi/+WmeYKkJYzfYKkD2z+SL7CynOS17tG2NYIybVd3jbmCO5c62E?=
 =?us-ascii?Q?tM1PKbL1e9l8gaF42xfXk22b9DMHwJxk37uhqnHMTRzbSe/2o0j2eaArk4Pj?=
 =?us-ascii?Q?FeXnnCn/TxqiOV6QcWhg6+ofpipvIX1EKZ7CWxLh2pttScUVL7zXGhCyu+s0?=
 =?us-ascii?Q?Kk7Th4UMIJGS5PPcRSSrf0BOKZBOaca69ht0wKu1D6UjPe/psGgm8a5ugBnj?=
 =?us-ascii?Q?Gs9dmNA9NznD3gWZavbDg4qJyO45KabRcpbF0em/BGkRPMLkqqxwA/1YE7xc?=
 =?us-ascii?Q?IwRJ2tYRWZSfUJ341mVuby8yHt7RAoesGqKYTLP9UWNItx3gC94SfN3vXr70?=
 =?us-ascii?Q?1XYidYVFGmxcCZeixLR8AL0ixaUlCgZFT0aiAUuTsdP9SC1JDJoRiLvnK/5L?=
 =?us-ascii?Q?HX1WhIizR11iaWF5zW/NGoBgAF1NHjozxr9tLLFdEFyx4mNJK/JZjR5Z0c3D?=
 =?us-ascii?Q?OuzYjmsLSEjVr+Zl8k+qp4F7+jPEBVnq5rd1lUlkOYImb7C5PRT3QiLCNue3?=
 =?us-ascii?Q?xkv01U3nJSNWFhakSw++p/ShnZ9QzPDW8AoPNjMd2KtCC3OQ9AhoYR7At4ve?=
 =?us-ascii?Q?cywyLJqYsOwTgwr1+srzceUP/hYtiTgAZzhvyRUQiZwnOdDTJ1W04P4fqefr?=
 =?us-ascii?Q?4EwWkw74UQfQ98l66MXDxIfVl8sIYx2H2o9NFBVq1PixtUYHCJgNjw90t2M1?=
 =?us-ascii?Q?OVlSB2BZ7V19ugrEuhE1AAA3CG1F4P1isd7J+aX7l588G2bE9J0rCglxt19t?=
 =?us-ascii?Q?JJPtqGsqZieUt0Wm2AJLmvLsfzQWqwot5qf88Xc/gh/jBC6mP0EDwk4PfEEv?=
 =?us-ascii?Q?DzvgFxYPrAqgaQbm98xSVV+wxD+mRkLOZ8h4s0Dj/fXww/Q3nLBxIqH0aFic?=
 =?us-ascii?Q?tc4IacG7vcnsb0lYOcShv4KdmxiO1lF991T4cPonRXvAChUFymDds3NLZo6N?=
 =?us-ascii?Q?DbVV2avogw9d/ToCHN6ElSnZAezp8WNPkj6uTu/F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0f62a0-a2f4-4185-b0d7-08dacdb64dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 00:53:29.8995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfxvB3aVSshmDKxK+7+WAjOBOPT94MWxgh5QODjEP61pw0A5ak8wse3kvGgik2a/Bka39URhHft70e8+Rxm7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6777
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, November 23, 2022 7:29 PM
>=20
> On Wed, Nov 23 2022 at 07:57, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> + * One solution is to let the root domain handle the initialization t=
hat's
> >> + * why there is the @domain and the @msi_parent_domain pointer.
> >
> > This is the part which I don't quite understand (sorry with limited
> knowledge
> > in this area).
> >
> > In concept a hierarchical model has restrictions added up when moving
> > down to lower layers i.e. presumably the root domain decides the minima=
l
> > supported capabilities. In this case there is no need of a real parent =
pointer
> > as long as every domain in the stack incrementally adds its restriction=
s to
> > info->flags.
> >
> > I can see why this is required for x86 given that MULTI_MSI is supporte=
d
> > only with IR. and we cannot make vector domain inclusively claiming
> > MULTI_MSI since it's completely broken when the vector domain becomes
> > the parent itself, in absence of IR.
> >
> > Just be curious whether this intermediate-parent-deciding-restrictions
> > is generic instead of x86 specific, e.g. is it possible to have a 4-lay=
ers
> > hierarchy where the root parent wants to check both two intermediate
> > parents?
>=20
> Sure. Nothing prevents you from doing so:
>=20
> dom4:
>     .init... =3D dom4_init
>=20
> dom4_init()
>     do_stuff()
>     invoke parent init
>=20
> dom3:
>     .init... =3D parent_init
>=20
> dom2:
>     .init... =3D dom2_init
>=20
> dom2_init()
>     do_stuff()
>     invoke parent init
>=20
> ....
>=20
> See?
>=20

yes. with the hierarchy being arch specific those dependencies
can be easily figured out.
