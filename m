Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE05737DA1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjFUIRK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 04:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjFUIRB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 04:17:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E961731;
        Wed, 21 Jun 2023 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687335417; x=1718871417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sVKox1aOY6tNf5MDrhdLwD9ctQwEUahKH0icXmVJo7g=;
  b=UIqJ40H+s8L2xOUxcyuIxyWhKhQoU2/03qvoUX0AVzjKmGPhIxT2qxqt
   QPfL9FBZJd75phl5nimIynyBowlwkPS1BJfRiFfz0wRIo4UMTLTE3Zj3C
   K/xdvDtVF65pY9hHXp7dYvH0SlGUN7M3az6Bdeg5kcRuu6Huz9GRKaEfv
   +ATAczKFgNIKyB+zYbeSKwCn5snDezz5J89IrZsQjLp/wgUy6x/PT5TfT
   8FkF39JvghC9zKkb9enx/VzCqh1I8VXNXRb1vlvFmXlquqKUurwVCOPz8
   kHu00ASK2MmTlwm1ZZPSvQMARs99vdzdev/k2o0CDO0JIZV+HdyP8azJj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344843867"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="344843867"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 01:16:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804282987"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; 
   d="scan'208";a="804282987"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2023 01:16:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 01:16:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 01:16:55 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 01:16:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0WG8xqGPZzmYQa0GrJbkp1XOlxqpNhkdSDmXllD4qq78vyziIhhwaVtNi9J9Tj76IAismyVEWW6gkHF0zWN5Sm+Sj7y8JwP+JLMdc7YiCZSc7XxPQcucRzBi4DJSctONrLY7cXW4cV6vb2r2dRiEk0DioPAngTva5B97Z1B9HBa3NYpZ/a01UyerhbOzIQId4i2UeGdx7K/DBw9M8C6/N3oN5afhKJjGyFx0V7QE6ArMouHO6hp1++Q4mVPd72WClIfAMfuRdUmK5mKdwzD6uKJnqzVQbUV9bB/u+mGcscxh/2yRz/eoVvFkpOxBEjt9rmc1HRATlwbvGlfMULAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHTnvGdH+KDbD8vuPqbJM0WCxhcx1Vh8ZAc/U+WqfRc=;
 b=C3Et+w9N7ZIH8t7r/j6GX3KtBv/XMIsgTOI9boTycnTIyYr7VI0/Ds8DLYXsHagBQvTF5py6oaBagpGBrNIeK9XBkCwFu/2QAdZ6uVe8HfnKOa634dNXQSo8p3cDq/lKIX29qLE4QsCvTUOvirMkVHPdqNbtW7kly+iAA3p6oU0x2sggNEGGGhM7OG13DJVxul8iwRbM9nYEOnhPeChrQlvo1p2czw9mciTWCb5XUXUG+Y5fRGdqJ+IH9DtdvUGp7kG0JWtz5SpD04RQuZi1JS9ddVCDSFOpJ1NpzL67vZduBSfKIvTyPC3VKbg7jYIu6MjdAJ478D1ZIcNURIDz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB6989.namprd11.prod.outlook.com (2603:10b6:806:2be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Wed, 21 Jun
 2023 08:16:52 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4f05:6b0b:dbc8:abbb%7]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 08:16:52 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Alexander Duyck" <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Question about reserved_regions w/ Intel IOMMU
Thread-Topic: Question about reserved_regions w/ Intel IOMMU
Thread-Index: AQHZmZR0JpzuQIuRD0G85gaP7++jm6+AOJSAgADP/QCAB+LmgIAEOrcwgABAlgCAB47s0A==
Date:   Wed, 21 Jun 2023 08:16:52 +0000
Message-ID: <BN9PR11MB5276B96470F3BF1E7077CC018C5DA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com> <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
In-Reply-To: <ZIxTmGU4a5dniEY3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB6989:EE_
x-ms-office365-filtering-correlation-id: aa90ffe9-5472-4c74-d5ee-08db722fdea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 070bKmazggvGV/TlOqjkQbkkN7rFwP5qI6qMSJ9PDbVrM47PlLwVoNSHgaVhMgbJVFgphbICrq9eA4v/PGRNCt6ygojMMsSHKSEsECx99Q2R7+BasClWzmprDbUPpXrpbByW4PclmiTLDdfe/zY6OueZdkB/u3PrFYLxXO0T5DgimpTO6OYk3y0+quSL4ej76tZXspllhfRg0DD3lc+fQPi5nkX9hmEGfasqUmVbYNuMN1KH1fulcD8MpQFcYXmc/iGlnfcJ7Wi67Jh1ul+hiZ5YkVQ/I7Tor3m59MBZFx9UvfW2hmbA9zkSADdw+0l9KH+Dg4dOw/ZPkEE2kxbHfa8YRG1AFljjLASxfui0shPXo35YopojcRQTK8P+Vz+rWDIryuqGLBUWSPwrN+Ikfbee6cmB/5UwItiGWNSq2J3ungjDvr7snBC4UzS0Fl+AJnh+M6a+AYy64+wJNTgUFNzqpeBCBvNzsZ58l9behQRDVefIuMZwSxuCUDKB5WLmZmYiUvsLPBjXzniHEKTtaT2LiVC/Z4gT8IoeL+QLhcC8JD76rKsnbL3WIIdjNC86j2sZvpbP1B/Xn7e731pzqQWy5Ra5RiaLTRdfku6xnq9NgzM/OeDzE2RomDfcJEtmzEYXa3Q+VDxjdPj+7w9nRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199021)(82960400001)(52536014)(2906002)(122000001)(83380400001)(38070700005)(86362001)(5660300002)(66899021)(4326008)(54906003)(186003)(66556008)(8936002)(8676002)(66476007)(66446008)(64756008)(66946007)(26005)(478600001)(41300700001)(6916009)(76116006)(55016003)(9686003)(38100700002)(6506007)(7696005)(316002)(33656002)(71200400001)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hYGCP6zE19s/RQD8oT/gWJYkSES1hoJmAoOwaDlCBJ2+7sDCXOswILrZzzRW?=
 =?us-ascii?Q?AFKBtlyr00LsnIUo7HemXyW1uRaGeGB9qqmolWrbXu8THRKrzABl+NLJXd8p?=
 =?us-ascii?Q?acbrVvk4d+qoSrLm6LNt5x8sbUHQutqplbhUaWjWYfVYHyyHAJhnNo6CTeQ7?=
 =?us-ascii?Q?tlkKsZXwYOIoD53vDPoQ/RP0nVTCPb6fEQkQJXpuLASchakNrc5qHzNZYOuJ?=
 =?us-ascii?Q?mLtnxnXU6NIMwftKjM/0qmdO6vm3eTHBXjcMSsOrkdosbBf2kigyyKSm+N4I?=
 =?us-ascii?Q?t6IQzTRs/oOy5yC8WYuZpJMsvPUypsZcxOzUS5qzMvyAlhs/4Ko/i5HvMJ0b?=
 =?us-ascii?Q?CiZ0u52swTOPQShHLPcK0kdGDeBvnNlfiYNG9tiO2Nj7X7JPoUIjojOQwhZM?=
 =?us-ascii?Q?MLaLfwcmWKonbOeFQv9t1/z4768psxOTQCFR5oirzss7QFyA0g+Z5k4n2TAh?=
 =?us-ascii?Q?RvG3VXXBeJZTNY5pDtRmQ9HI8WBgFHZ4X31d6JJEJH2R4OEyOr1llOgPJaLU?=
 =?us-ascii?Q?K6/G/J8zuwWs7zogPRtnfezwBBqfFjpcn09c4P1kUX4rfl+xhaXuYcxSasUU?=
 =?us-ascii?Q?8032mDXJZc3aOe64eOU75SOOio88EsHiGXZNFVZAFqjX/94qHGIBy9OXLHto?=
 =?us-ascii?Q?hBZTWMLy7B1s9SAh/aIDYYAnLXf2yof/9qa/xHMSFaTPdrDZCYRVp+3G4e4v?=
 =?us-ascii?Q?BIaoy/Pu5Zg+oBzh/6W1/74GDQe49GeLRbRujKDJkL42RqJuikQf8MCTm3eX?=
 =?us-ascii?Q?BJU5BjvilDNompDxnXNl6Bua/WRDnD8+XslLc1JYkEUrb0ghb9SD7nv20T7c?=
 =?us-ascii?Q?yZuNEjF+jy1XmRbZsjomclXyOfus2TOD031BCweS4Ws1o7TRypsumjb93356?=
 =?us-ascii?Q?sB9eMiqpJFpmkSpcxkjz3iUtQYtzlwi0D+EJ39gjjK3IbC2VYsMve3kWBI++?=
 =?us-ascii?Q?Fnw9bbJRRfqcVmOxF9or3eduDzk4UuypX7BHvpkt5KUr+UOf3aA4z17/0gTd?=
 =?us-ascii?Q?+aXFohX/fqLQe7Yo/KPM7YcteVcAbiGndXb+9QyoYKC1oJKmL27XX2WWMUCD?=
 =?us-ascii?Q?ZNSDVrJFdWwpLsDrJW7JAjowYYD6AM6Hfy9cfzWbAQPXdNTc/88YlDzcMSKz?=
 =?us-ascii?Q?SVW/ux7aQusqC7j4aWVSmxcue2PrVIVrw1APWQoKIH0PM7AtnglpWqpWTJsz?=
 =?us-ascii?Q?F5O4YoiME9oG+beIBOLQ1FFDlCOJUBBd0eK8mdxec7GCMcwKaODUeTHaN3iS?=
 =?us-ascii?Q?zTWgQg3CdzaigTKTUOkhGIC8m1yfUc6PesMjlKdNn2f2uhzRnyejBxKsPcpD?=
 =?us-ascii?Q?XE+i+8nNTjWT3LlrGOjn9bOuUdVBvzOvu1rTVQS19x0wDcZzY1BFttluiNC0?=
 =?us-ascii?Q?P5ApWUYxxZv4+HOJhEhTpYUz5U2pF8GaKJ7H+Nm6zdaDOiuIVw+zmpQSQ3Oh?=
 =?us-ascii?Q?XHJQx0CbiiO5kdnHj2R0KN9fZ/haE+PYVlTAJp6IQbHmsY/4lUaQ+BMzO30M?=
 =?us-ascii?Q?D9idvP+HVC2ql7GRID7TwmGvcJYfMJSWy9pKUCzwop33bEG0rRwDGLB+el5W?=
 =?us-ascii?Q?hohroEbeHdg2E7Gw/YMOgxe5ISZeiTUAQnAVxb6E?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa90ffe9-5472-4c74-d5ee-08db722fdea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 08:16:52.7533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A04PTd7hjzzHc4979Y9xZTb5XCq76nFFEYndB2/jJx4JqcWeiIz7X5sbdqgtDa02LtOkw7jABa0fsFZlT45NsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, June 16, 2023 8:21 PM
>=20
> On Fri, Jun 16, 2023 at 08:39:46AM +0000, Tian, Kevin wrote:
> > +Alex
> >
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, June 13, 2023 11:54 PM
> > >
> > > On Thu, Jun 08, 2023 at 04:28:24PM +0100, Robin Murphy wrote:
> > >
> > > > > The iova_reserve_pci_windows() you've seen is for kernel DMA
> interfaces
> > > > > which is not related to peer-to-peer accesses.
> > > >
> > > > Right, in general the IOMMU driver cannot be held responsible for
> > > whatever
> > > > might happen upstream of the IOMMU input.
> > >
> > > The driver yes, but..
> > >
> > > > The DMA layer carves PCI windows out of its IOVA space
> > > > unconditionally because we know that they *might* be problematic,
> > > > and we don't have any specific constraints on our IOVA layout so
> > > > it's no big deal to just sacrifice some space for simplicity.
> > >
> > > This is a problem for everything using UNMANAGED domains. If the
> iommu
> > > API user picks an IOVA it should be able to expect it to work. If the
> > > intereconnect fails to allow it to work then this has to be discovere=
d
> > > otherwise UNAMANGED domains are not usable at all.
> > >
> > > Eg vfio and iommufd are also in trouble on these configurations.
> > >
> >
> > If those PCI windows are problematic e.g. due to ACS they belong to
> > a single iommu group. If a vfio user opens all the devices in that grou=
p
> > then it can discover and reserve those windows in its IOVA space.
>=20
> How? We don't even exclude the single device's BAR if there is no ACS?

I thought the initial vbar value in vfio is copied from physical BAR so
the user may check this value to skip. But it's informal and looks
today Qemu doesn't compose the GPA layout with any information
from there.

>=20
> > The problem is that the user may not open all the devices then
> > currently there is no way for it to know the windows on those
> > unopened devices.
> >
> > Curious why nobody complains about this gap before this thread...
>=20
> Probably because it only matters if you have a real PCIe switch in the
> system, which is pretty rare.
>=20

multi-devices group might not be rare given vfio has spent so many
effort to manage it.

More likely the virtual bios may reserve a big enough hole between
[3GB, 4GB] which happens to cover the physical BARs (if not 64bit)
in the group to avoid conflict, e.g.:

c0000000-febfffff : PCI Bus 0000:00
  fd000000-fdffffff : 0000:00:01.0
    fd000000-fdffffff : bochs-drm
  fe000000-fe01ffff : 0000:00:02.0
  fe020000-fe02ffff : 0000:00:02.0
  fe030000-fe033fff : 0000:00:03.0
    fe030000-fe033fff : virtio-pci-modern
  feb80000-febbffff : 0000:00:03.0
  febd0000-febd0fff : 0000:00:01.0
    febd0000-febd0fff : bochs-drm
  febd1000-febd1fff : 0000:00:03.0
  febd2000-febd2fff : 0000:00:1f.2
    febd2000-febd2fff : ahci
fec00000-fec003ff : IOAPIC 0
fed00000-fed003ff : HPET 0
  fed00000-fed003ff : PNP0103:00
fed1c000-fed1ffff : Reserved
  fed1f410-fed1f414 : iTCO_wdt.0.auto
fed90000-fed90fff : dmar0
fee00000-fee00fff : Local APIC
feffc000-feffffff : Reserved
fffc0000-ffffffff : Reserved
