Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2689D639F14
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 02:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiK1By4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 20:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1Byz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 20:54:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BD7B85D;
        Sun, 27 Nov 2022 17:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669600493; x=1701136493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xtrUqZRbxtLbtKlgKrIwet8HpNuWRq4y6m86M7lqpII=;
  b=Rys31SBVocpQf6+JzHp3OT4Qi8ZYs5W6zIjRDZf8PKD0DyseCq3u7TTI
   a79QZdXU12IrbnydAg+8pZ7TUCb+Ltkr5FWCh7wcioHOS6fPzEKDUa6d7
   nqsXX0uR5AIH3Gl8B/IuTIX5CS9ei+MZTsRlag8GYJ/vPGfU0FS7vC+HV
   W+O7QsRWCQy09dTwNTd1fdhytl6WgHsVOXOpgbOW2W7cii5bObQho+fpT
   l7N9deOkuBLy3OZXzbBwyswB0sl+r60fI/nkGgiGmHoTz8wn+0Zjxpb0r
   2YxkULuq9CHhxJljHb7Oz2MW4loQlahvr0pMBE6EZKt9RchRejnoMmyPI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="294429238"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="294429238"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2022 17:54:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749190585"
X-IronPort-AV: E=Sophos;i="5.96,199,1665471600"; 
   d="scan'208";a="749190585"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2022 17:54:53 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 17:54:52 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 27 Nov 2022 17:54:52 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 27 Nov 2022 17:54:52 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 27 Nov 2022 17:54:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOPMRtYX+hp4Wuozr0H1FFQVqQAkGdxoig7dV39Hbjka8RSrESBsSRfe8fO6UvN3e9wvwtVxg2zwTY4U0oE/HCMKDOCXGmOYlDYeI2utYg4aT7aFhaIj81ll9qvH5VheU5XUNaMN9q9+PWROtP2THF7jBHzfBRQhXrWpi+sgc95DmwiDuV9+NFXC1UWlocdy7sd4HzYVFnVOMVJS0aHeZXwuTsZ9WNkzptQrT6mY31l89GyWb2oZm7ym0yJlGGsr2kbnKclST1aelJ0oLvWG+H6Y0xhHUdlebuKaCr/kf2Cd+VHMY+W1ILBLRYq1wDC10EoT5Aaae7PoxdX7rk97Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9nEdI96vxi4fov+uSl2u0jUweU+1Tmb0nH11IqYW1U=;
 b=l+CzEZk8KKqLsOiJAmCetGiyXrj+2V40pBgYYf3a8BUfB2DP0N7L5PL2rwhci++gMR+q/E2RnlJcw61vekKXrHL4lPMQ8rsLqVxvel714dCntjL3RBrM6MSkoTOFjSTM5AIHdkWrapfQ4Y9W92kJ5PnYjqGCRflKoVjdKuAguYJwqeFivWtaqIU4akjsCJC1b0derQHgz++XBAw6MYWbn/S/8b79VHOkMX3431pASkUU/+LG4pqPKB2adVJ4rUXdg77qOclRG8ocEryhA7IwcTYNQfzn7Sou0AkBalPw1ECc9QeR9Xf2M4xpeeZ+gZmIqeJKUgfZeIP7YEl2CihdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7457.namprd11.prod.outlook.com (2603:10b6:8:140::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 01:54:50 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 01:54:44 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Marc Zyngier" <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: RE: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
Thread-Topic: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
Thread-Index: AQHY/bbwPG3EDS6e702OjDPxfqJk365NXjKQgAB3OYCAADxjgIAAAfkAgAWI4BA=
Date:   Mon, 28 Nov 2022 01:54:43 +0000
Message-ID: <BN9PR11MB527624C8FE1F5CF21CF724C58C139@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.184455059@linutronix.de>
 <BN9PR11MB527650A018BE7BF422BDA2F58C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87ilj4d766.ffs@tglx> <Y39uGVLrH3MvOoZ4@nvidia.com> <878rk0cwu7.ffs@tglx>
In-Reply-To: <878rk0cwu7.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7457:EE_
x-ms-office365-filtering-correlation-id: 07c64786-349f-40ea-c738-08dad0e38554
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VrYXjRoLRF+wRKhq/o5ELg/ES17JDqz9BKpBnEmWZXAuLvm5iE7+3D+Caw/rKE4JcN7Uv1udYZ4zxLWlziVDE8ai1Qm0j9SY/7PJ46qgrUPjBeodXLiuiOqJNGUJAFvEwOvmpjBdE+LwwbpQmgEVuCZzhhqHUdboxDNiu4CS9M7FceweAcALashz1sbJ31x2YY4HeCZmONL/E2wZizhK9NOJFHIlhiSSPF9wzEDFCVSdyAnaLV25t+Ch/riVNmnhFcj6Rjg2BEvDauULAUdbM/mKzIung7sR4oRBXLC+iroo8qL9nG/h/Y4V/04jauhbxg+0oQD+orDfCndYinsNgxg8iZBwuaWmf7TKm4mL+3Z7P9eqJsY9+xJi5tCOEg+X9dkJxwjBnFF0w5SpbHeYNrl8S4svfVc5Tt4m7LQloWwLUBxNSqXxz7iHgjQlH5HIkbF5CBqAuwcguuhMwkQeOZ1fBTOUkhZUrtptKtHb12pkIjeG0Hl9lc3kpS4E0dMwyaf5TZcSTr9Snit0KwDpDoQBLdeS3l97odqMlIUqMhwIu5TGlMuLHTfQYg7SSMgtXxC0gpnoaNs52O35hDzM+xOcZZ1sDLc1pWejdITpvdoIkO1eWnCdKiiRxcUxZiTVxY4eR3kN8RYlPXwWHunkCmfynEnAuEjRUKOG42SFLFYBo+OIPgUPHsyu4SrOfcIgX3Ospw5pI7FwIXVuw8IQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(316002)(478600001)(2906002)(76116006)(33656002)(110136005)(54906003)(66946007)(71200400001)(83380400001)(122000001)(82960400001)(38100700002)(55016003)(26005)(6506007)(7696005)(86362001)(9686003)(186003)(38070700005)(5660300002)(7416002)(52536014)(8936002)(41300700001)(8676002)(66476007)(66446008)(66556008)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ftqkgItudlqOYDxMCBbu1ZFim609jerkuzSjWCyEtiOGC0Guc8aRj8DNJ3e3?=
 =?us-ascii?Q?FlKuWsJENxArg+nxfN/Z994Hfc8gdyVGczxZecwK0XeCGcF/lbJ19kdxraqg?=
 =?us-ascii?Q?aAbGVdyJRNen4F2jcJXMk6skEMswvZC/1ZBUEgErK73Bfzk2C8zzed735c8c?=
 =?us-ascii?Q?5/daBNyzmQS9cVaHRJu6cxePqY+Td1oqr9ZKZQFKjjv3qaVOytznhm+TB9uz?=
 =?us-ascii?Q?quItHDgSRPLLQgVLjAoNq14e+2aORXMcVH6DJSyrz0OkmMyA9eO0TMMBkuAE?=
 =?us-ascii?Q?p1lMsTfWs3JJWv2gzurgCd/DW9ujpJ3MjHeNEKzDJn9Nxhg1N3M78wR7MDOb?=
 =?us-ascii?Q?SQ+c1yXtzlTYMFOXREfhFlBYhxkImjrkMQ7/MI3SsRNhR7PX9j7/EIaHer6Q?=
 =?us-ascii?Q?jdRbPAucklgLhzYpwYbLXERM5dWoIt6+7bTMGR8E2RU/hFMS6Al6pPpel7Uo?=
 =?us-ascii?Q?IgJi9Od8joPLca7nQ7LepskbGA0z+n2MTvZPc0IB5CTF0NMX8BYyJIfhXGyd?=
 =?us-ascii?Q?nO9HD0UnZOZr5kylpfXj26QEd8iVwSOn0scq5NGx9mdZ/QudLJ0HXNnLPUMw?=
 =?us-ascii?Q?n0gre60uETB8rcOSHBSIdqftcfy18WTNZ+Ag1LfF+1zZNwWc1GMUmwQLZIQF?=
 =?us-ascii?Q?jU3V56zHfjKlKkebzIQHCILf0nPArNYtCisIeRqIVZ5Rp0sHIDk2xk8Wj+nz?=
 =?us-ascii?Q?5JF3fk/EMlx2R+K2nMjaORZZsg2vYY5MiSs9m2k2U+Tl2Qzc5tG0Zi8Tknrx?=
 =?us-ascii?Q?7WNXCaD1ff2zIfZqfbsjmfwmNYwd+DezWj0b/Go/hKRu4F9KIN58kVuLB/9z?=
 =?us-ascii?Q?3TISL+Q2onZwANNgApd5Jd0ghhho+7YbIF5mHrE7gZhLXj1Qdd0Y+2PgMa5D?=
 =?us-ascii?Q?Ded+0Yv7nhIQFUr9HPMlOIpYJiPH3dc1D1rqUAP2G5O0ak7ImInBJ9QcxuZf?=
 =?us-ascii?Q?LKZOlL6+PDy6a5iq5thxaXtwSvNO1kk3PjA51oPjrGPdXy3Zo+TZT2nZOSmY?=
 =?us-ascii?Q?S1CJ23g+aEuYouD4qpUMeN95XJx8IrVKYFmf1VYHJFMsvItFeXQvanpV6yWO?=
 =?us-ascii?Q?9pgH4mTESlaTx62DWdYncSUsB+4zEiPUoJGmZb3CQBjYVmrfX6oaeCPzA5R3?=
 =?us-ascii?Q?BcXW9ZR5GeM9lTgz3K+HobhTV7kau931OrrJV14TlDdUVvxKcuCKj3Htu5K7?=
 =?us-ascii?Q?vjGs7hbwBvC8K/LZ8EokKw9/16yP+VV4bnGdRPyMNxs6pGUIrn59E9bLRtcl?=
 =?us-ascii?Q?W46wLX+RRO1ZysBnwmhq5jYJyAQuFQjSBKPqv1MrkzSkgnga3NM1Od/dO1zI?=
 =?us-ascii?Q?iKU+dogPpc0fJ8vSYNvZKwD4dI90Ifyw61Qdt3J6rdm280NgjOdK9BAjwuSi?=
 =?us-ascii?Q?D22f3W3JuAA0mTSepizCGIBDF0blF3R5qlDqBnCoUx8pZIljVElpkRx2LuSI?=
 =?us-ascii?Q?4A26nQX4wLjAvNB4h+ttOmKrzDkwJGgTY+Uo76xILPmG1SolRC+CemO+ZxuT?=
 =?us-ascii?Q?l1fk5eA0C7FfmjAU/bu4B36dStLlC/ubfadk1u5uPohfyisVkY++KwETJgyp?=
 =?us-ascii?Q?Q32WsWA9isAK2GN3io1fGGKPKR39qn4oQMwFgcti?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c64786-349f-40ea-c738-08dad0e38554
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 01:54:43.8957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36fKlQCx4cCF6Aevk2XYW1PqeZ2/dte6Spy9KOcu34Z+gbDptw972kMWKNrX4lPhO1Y4g1PAiP0OoRU4uw7UTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7457
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Thursday, November 24, 2022 9:21 PM
>=20
> On Thu, Nov 24 2022 at 09:14, Jason Gunthorpe wrote:
> > On Thu, Nov 24, 2022 at 10:37:53AM +0100, Thomas Gleixner wrote:
> >> Jason said, that the envisioned Mellanox use case does not depend on t=
he
> >> IOMMU because the card itself has one which takes care of the
> >> protections.
> >
> > Right, but that doesn't mean we need the physical iommu turned
> > off. Setting the mlx pci device to identity mode is usually enough to
> > get back to full performance.
>=20
> Ok.

yes. IR can be enabled orthogonal to DMA mapping mode in IOMMU.

>=20
> >> How are we going to resolve that dilemma?
> >
> > The outcome is we don't have a strategy right now to make IMS work in
> > VMs. This series is all about making it work on physical machines,
> > that has to be a good first step.

yes, that is the point. As long as IMS is disabled in the guest it's alread=
y
a good first step for the moment.

> >
> > I'm hoping the OCP work stream on SIOV will tackle how to fix the
> > interrupt problems. Some of the ideas I've seen could be formed into
> > something that would work in a VM.
>=20
> Fair enough.
>=20
> Let me put the limitation into effect then.
>=20
> Thanks,
>=20
>         tglx
