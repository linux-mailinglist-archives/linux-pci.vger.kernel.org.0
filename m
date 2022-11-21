Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F066318FE
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 04:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKUDmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 22:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUDmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 22:42:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31DB34;
        Sun, 20 Nov 2022 19:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669002148; x=1700538148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JLPnxHTQ9Z2xjwc8hN5LFveWSy9N80QBEtr/lGq9/fU=;
  b=R132KIwlev6Z9nqdaKmEJHVggn1VQG7ZM/UzsNDY3T6HDRym8zyZCmRI
   AU9ULertTSO64W01aOQImQ/uVWccFi4waE+Y9wCStT4wWhmNsm0x+GGy4
   9fEUE1UySjxnYMkHHhK0lIKv4Gom2MjVNAC18zlJaFQ2c2tfRt9Vb8bx0
   MnDRIucJ+dCQ6fitbj9q0Ib4ThxFYdT2SWAurRge3sdIC8JJGlr7nED8p
   he08HUv4af96uRKKko93WJ8/JmE/w6K9yfX4A+QRgiDPcYSPqW6pLswu1
   Xrl/rEEaEgGQZHIgH46jNUU/zbj/BKap9BENDR82dvFD79w4B5syTWCfE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="399753168"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="399753168"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 19:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="969916960"
X-IronPort-AV: E=Sophos;i="5.96,180,1665471600"; 
   d="scan'208";a="969916960"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2022 19:42:27 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 20 Nov 2022 19:42:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sun, 20 Nov 2022 19:42:27 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sun, 20 Nov 2022 19:42:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PprOpyPdH2lf3VgnnYdC2IJr7nvQfRMyNRAhE49bSXdV4Neh+a3Hs//3hzVHluiNSTf6t154eLLqqJFpK6J4Hi2gfFHlgYS1NUflkhaLcLD7xBGzOeYj3zQfiti0Lzoxm1tHTIl/dHm4z9XkTBYgceMNbXIn1p4jTWuRhZEApaXCdWylN+KUGmytObOdb7vUoq6O0VtqgyoLSFgM/w/bwpL5kRKmXKj0OGb8w7P014FPwv++vTYS47dlUpaH7VC6Ct9x5yvk799qDLnQvxPLatG8m7YF80wSqFbxhROSTuqEF1KAGEhVej1LlLkfaINw9hmywB5BDT1+8msSErG1tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pijxo8vGYUV1YY8w3/WnzngF0HbL4d1uRCYaoKP67WI=;
 b=RyAqfW+w9/S5LFNupov9ud7HU2yKQk3OvHGmQ5izmOMWFumKT8QAYPhQ/RG6M2am2wgf8dhWlvADp25uRZib8t8PnNmXsSKcPxRF7LtpoNH6bK12Aq03HDphElou1AzMH/G9TEpDPMVmwV6cV3NQwtwOrga/rc5BDh6NomlpkJMC6eCKm7YMHbcVrMwS9NMLPmHmjKsOlGBnIfLESoEVyb+pOsPtBHWMecK4pkoLjgan4bO9Jn0YAL7c8AAk42ZPHpZqR/c+sOnxEIRBMIGGRYpskaelJIdt1APXf363kgsUPb9rV7NdDC5ZK6s0BptAyQjc48WNPChzllgr92fTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6393.namprd11.prod.outlook.com (2603:10b6:208:3ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 03:42:20 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 03:42:20 +0000
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: RE: [patch 17/20] platform-msi: Switch to the domain id aware MSI
 interfaces
Thread-Topic: [patch 17/20] platform-msi: Switch to the domain id aware MSI
 interfaces
Thread-Index: AQHY9dWDKC7bX1kJYkW+2YkiV/i4l65EaQ8QgAA9XQCABCAEoA==
Date:   Mon, 21 Nov 2022 03:42:20 +0000
Message-ID: <BN9PR11MB5276EB567D822DA9148BEB3A8C0A9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132707.005001510@linutronix.de>
 <BN9PR11MB5276453E63A0C02A4BB386F58C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87fsegjvn3.ffs@tglx>
In-Reply-To: <87fsegjvn3.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6393:EE_
x-ms-office365-filtering-correlation-id: afb1d144-2303-4b9f-b256-08dacb7264a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1nSQsQKaHGFHt6xa34wB2bSTrC34pcLN8mZhJQSjVY2UQMoff83onjxKkm2fos6CT1Vf50UI2Bld8sB070f3HC/dIXBUTUgScD3ssHfWXP6u4A7BmVspMelDRswiuiiVcEJNXBv9ZbCggRzUiza/b0eTDTeoA7IbECYgdOpvbqCJnfrfJ9e4r6dqXUV0bQDuzbuLcfpwVrZm8fXmPackTrvMhpxXRxVXODIKq74WkSkHi80U6RfVpQlXuiPi+fbEym6axRLi/hIKDU/VDn5lzrfhUZElC05jXcR2Ii7N2DhZYDqVqFWNeD3y8CEEUa9XqlahCJMuKIg4Y6jkId5f5pF96IHHqlYOtj+EZElQqcKQIJXYbaebpkeb7Ir0ebFfUYszW/CwFL0x3RgHBv1mAsIAQ3bOT59YDvrWMoFgn8qnekodBrRNYNcFkeFbs/rIOU3QaiJgzuydilmGIuMcGxRJ4GkjXCrYKYmQoKmcvy0lYHChoyA0G0KwotGe8iaqttVhV5x+BZNyMHkjA1yUsgob8IlnaOLMWWx1LeoootU18udova79CLx/DmaXjdxE6bhocFH7hV5XnbaOpuCWx/Z+fv+l3n/kYOJhubQHFCSHREv7Fpgh/DxiL6bC9+KNiVLeeOa6LpY0dygzozP9+gdLAksB4fSRDulV/XIzrHo3uUD+UM5DjAv5dmCmXabwUEYbKHal7eV4dO9xNZIxsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(136003)(346002)(366004)(451199015)(6506007)(7696005)(9686003)(107886003)(26005)(110136005)(186003)(2906002)(71200400001)(478600001)(122000001)(38070700005)(33656002)(38100700002)(82960400001)(86362001)(55016003)(83380400001)(8936002)(7416002)(4744005)(41300700001)(66556008)(76116006)(66946007)(66476007)(66446008)(64756008)(52536014)(8676002)(5660300002)(4326008)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fPMUCQDIYv5kpd36jtkp6FGSh18d9UkFKgXfyz3v9e4l168/vjhHuM7+NkrU?=
 =?us-ascii?Q?hkZTH5ihAQi/F96B+WyWr1j6+OkXmwXOPXi32KJ0Abn9hV0hcia7FzEoly47?=
 =?us-ascii?Q?mRV+aD89cqFJLWS7hBfN1Z0bvyN9vxq6SFBo/xf9vCw/mUrqxunp13dnHrnh?=
 =?us-ascii?Q?OQ/y5uAtswDzXGafZvxvae+De+mZfcqCieJPXz9/qAC3ij/mxS1ZNY8pvAHc?=
 =?us-ascii?Q?Bg5Q9rCJIixYkqomEzAa20WwXuTP6pzRDao1qGIvn79iDheedSuygHX0Jljd?=
 =?us-ascii?Q?+mGblmL+6bgS5G4qbKYPV1Xr8DbR5FjuzxlwOFPsOqjZYN9HI9sv2IEOhqAm?=
 =?us-ascii?Q?WuhL1w38E9arui7iNuJqW5I9JcCDTH+1ipectx3qliRA/DMJiarLBm6IUYW7?=
 =?us-ascii?Q?zNq/TGkRsVnLx0q6KyBsIFJC4ey7lQD9HSG2HqZXsJZwZmlpJONchEK8FaQo?=
 =?us-ascii?Q?Gr58q68Rss3Woudv9sQ/XA2JYST5iWsh5f9HfKgidQqFAUJtHVu66ovt0x3t?=
 =?us-ascii?Q?wVhe3xOzWKtDPBnyqjYcRShDTgEwcvBNeFWcQijOiLplc3vWCqPpGQhWdr6D?=
 =?us-ascii?Q?/CTQVHKsGQME8Yih5d1Lo8++qa4LgUbPs0VJ5ITeujQkk6IVRnznf0Jq6uXq?=
 =?us-ascii?Q?wroHxasqRIWPB7Muxvm52vg0uUKPPbct5J3eCbeeKDCHq6sD0LziUG6u2G7C?=
 =?us-ascii?Q?dxdRA1+pe+Vhh7rl7JBI8Hr+vI/8U+PgvzvaHMxYb6j3sMITj/0AEL/2OT47?=
 =?us-ascii?Q?bHx3qbwaRjgY9ljWYXuXxw1vTiTDjCK5Fm4cJkzhgAWNHhaMWosuJgmraD90?=
 =?us-ascii?Q?DaweVzZ+mhMnFKAwN4eKLR7r9qI1qmJ5GmhWFdluvEwVZ54CdEYcfaMb1kJp?=
 =?us-ascii?Q?+eXmyUsTs9v31dKF7zwqmcra8xertevc2CaU5+VrgrYSH4rwEc9THIUC55fh?=
 =?us-ascii?Q?6imr0B+lpL9VdngTpsItvP7iKLj0klJH6kovHmiS4JJlsJ5p2fwnaO3hjPL1?=
 =?us-ascii?Q?QP5X2OQYECwqbEkH8HN9No33NVeqfz2vjiCp8h1CEoaCdAcgbx7QAMdI7CQf?=
 =?us-ascii?Q?oIi43uP1K1qtQCikOZ52M53OslL2P0o0QcOFcaqCdrzEliwBXBRE4rRYeKl3?=
 =?us-ascii?Q?2CgTXGq1eiDis6mcmzokyKqzSxRjIs5JHTULWllJQJaH/6yeS0AB4Vw+yknv?=
 =?us-ascii?Q?7EXsxNZRSNWx+akkVJRzc86/94vtRFz5QKmpMgIXZ5wv7SctBAX+lWEQj4oT?=
 =?us-ascii?Q?AjQTLyK8DBhfRCHIVMM7mn8zZjx02asGArOWq2uCi1Qkb8k0PmHK0cotsgj+?=
 =?us-ascii?Q?NzpwGjfxs8b4+fiL568KUsipSJQ6YXa9B5gSX95dIEpFGMZ2NszD4iMhm8mK?=
 =?us-ascii?Q?n4SD08D2YjyGhajT3nOANxbwVMEdOESf9ZpHcqcmlvWbpN/rCqRkBA1duLrH?=
 =?us-ascii?Q?m3lHiB3ub68DQjqDvkIEic2bXn0ykXtNpu3aRWLKgSFMAX1GvvB/VLdWVm+2?=
 =?us-ascii?Q?4tdf/mBaOqnBQmAeHGJ6DDwkn8uc6WTzzPLiNWJwmspGeZfGEPBFVsAjfytg?=
 =?us-ascii?Q?82mvu5x1LY31AUNhtUHMtPf5bLIKPXmI9RkACWxV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb1d144-2303-4b9f-b256-08dacb7264a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 03:42:20.0790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g8mQ9Ku8H/WM62Q4YSjSFqMb+IOY0YuHEHB2EojjxBfz43nXvTJum31ShQqjYY2Q1G89gsH3nIKJWfpgYccNeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6393
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, November 18, 2022 8:27 PM
>=20
> On Fri, Nov 18 2022 at 08:53, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >>
> >> -	err =3D msi_domain_alloc_irqs(dev->msi.domain, dev, nvec);
> >> +	err =3D msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0,
> >> nvec - 1);
> >>  	if (err)
> >>  		platform_msi_free_priv_data(dev);
> >>
> >
> > Out of curiosity. Why don't we provide an unlocked version of
> > msi_domain_alloc_irqs_all()?
>=20
> -ENOUSER

msi_domain_alloc_irqs() and msi_domain_alloc_irqs_descs_locked()
are a pair.

What I didn't get was why the unlocked invocation in this patch
is replaced by a range-based helper while the locked invocation
in previous patch16 was replaced by an all-based helper:

	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
+		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, n=
vec);

The reason could probably be marked out in the commit msg.
