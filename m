Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9FE636F9C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKXBIt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 20:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKXBIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 20:08:47 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92D1055B2;
        Wed, 23 Nov 2022 17:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669252122; x=1700788122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y49UEMY7OdngQyJD/ODycCCdjd70iUdkXUXYl6DKPFk=;
  b=WSJBTa7WYlgGA95Rdmm5Goa0llTUxoB6YH2pe/6GVp7yzgOmwve8RGGJ
   oPDZ55+y2j4gGF0QGuFMqZjkBzshquOkPlU3sp6RUObr9VketNn4frQYh
   CRR5kWdUArrvblg+FNJaGqM0szhSwW6DzSox31WfI2OSNABgAucZ9IzP5
   1OdzJ3Cd3woQqwEmmfU5C5IvUwaW/qEOcrPgPFhzmRDyEjGsMxpCV7/Sn
   WD+bejMbl1p0OKWkOwELM969ruZLRqjue2FFFC15q6i/8p7QZghymkDpb
   wOT4qqusByxciM7i2mc+6M276U220tL6w7KYkR5X5swmwh7qm8NpKmPah
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="294575923"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="294575923"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 17:08:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="636101891"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="636101891"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2022 17:08:41 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 17:08:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 17:08:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 17:08:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0tIwoVuDQCCSVMonHYLe9TRtyHO63Ikgg2wrUxDmZ2+LDZzTBW8xjEqJCSPNxsPQrcgvx7w7EB1bvQ8TluDonQuD/TUEFHnlfLv0fuO7nMtDLI/5Ww22ft09udS8V0xukKL6R7ajLKm9Yeqp5KUc5cO8f11rVoL3D0OZXLdETIl8ny0fH7vj5p5i4u52iKnJfATuuN+Gt49BGMG9PoY76KCJyk99+uAWi5z1XNdnmTGkWgumO541yg3jl3nN2NiieL3Svn2Jymi1S/A1HhEaH3kmN2Ueydk1Vm7WpTyqejkX7QSW5U4rDrqQQflFaWvExGlgzprw449EJrKctyzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y49UEMY7OdngQyJD/ODycCCdjd70iUdkXUXYl6DKPFk=;
 b=ftQf0ZW+mveOl28kaWlwYJdlBqP7Bky3PwKoqNSmkDh5hfd93WtqQpkRO+8g6YGQ3Nrnv2TUjHANpeMZjSnrhsw98shha53/ro4/njg0O+mI2LuKEPbWht8htPxKG7Q+4KjW4verZB0OsoUdjL+xXew+RjzoQKh8K+zvBd6QtDdm5xi7CwZAmA20x2r/LnR3v6qoxWkvj5SlYzJl3/ENFn0HaBOZQ2pq0mYkEQUgJlp4vCLlfUIraq9oyHxM7TUc+FitigcE+hRUyIg7G39drzidc8Ys1Pe06XD7LR+kel3yJxQmg4hAtTZHaYhQyUrZxRvbpG7R8ssXjGS4PJcyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 01:08:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 01:08:33 +0000
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
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: RE: [patch V2 12/33] PCI/MSI: Add support for per device MSI[X]
 domains
Thread-Topic: [patch V2 12/33] PCI/MSI: Add support for per device MSI[X]
 domains
Thread-Index: AQHY/bbibHqIjpCS0EGXLo0J/f6SVK5MFjUwgABPTYCAAKovgIAANyYA
Date:   Thu, 24 Nov 2022 01:08:33 +0000
Message-ID: <BN9PR11MB527640B28F8350DDEC2D26F48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.163146917@linutronix.de>
 <BN9PR11MB5276E9AD0F86A27A23ED8CFB8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87zgchew4u.ffs@tglx> <8735a9e3xo.ffs@tglx>
In-Reply-To: <8735a9e3xo.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: 620ab1a3-349f-4d1d-2dbd-08dacdb86852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UP+bTUF8CwTS5hentr1mDjMv56Nu/Czj/DEetxLYVyEuTjH+vPg8clCBaAo+I+Q8yKQ8iQDanSvvHW8xjiaD/gTYkP2DEW94uY+xVwGJuVVWwAw1VhYCt4Jl872ZnFjhThLwKbaV8NMPRUiSJjfV/1JRWV68L5J/VH4W5UXvwwHtMUrmYxuvPJYvO1yVdluTeJYdElYRInbgmPKG3yU/9TcTJ+ycfAjCJoq3EYdTQrk6s8zM6q8ftYAoyQKAJ6dVGL0AhWl7seLSYY8io4rdWIHvAedTvxk0Q9zrhQffIDIkomk7S4Bb6H/V9i0Lp/GbttS6CARRtdTDcksRlxSTcmMmXbrWI/UgsdTwtK9PQ7tdpjeoKyKPoPast8OB3lfBRjSZSLHuSlkdlNZCdnYZIITCSOvHmKCRdEYsdiRpPYwLWUfIZtH48+4uiUUpHIMsIvEDBfnmSV4oZKguzEUdQqTXJhdXAvYiGLCyRV0vxlPfp8oxusZOnAgGQA7eTZ1TkFPYgwTf6xgQYDsaSxynglrf9o/z+53dJDP00wYmo8HdNlroq99OsNJNG2GxvuCcV91+sQoKOEtAD9HTndx0PuS14rK7flGRcpSVKwv299kHGEoBYFLW/On1KIUZ0rmbgvzxCMHPOMW1VAFzOlx+ZF4XtCi8Fc7ThTu7Qn68Qsn1lgqX0wZIjSqWH2cFksaSZSTOk5XDc4IaR5IZkmKcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(9686003)(478600001)(55016003)(38070700005)(6506007)(71200400001)(83380400001)(186003)(26005)(5660300002)(52536014)(86362001)(8936002)(7696005)(41300700001)(2906002)(82960400001)(38100700002)(122000001)(33656002)(54906003)(7416002)(110136005)(66476007)(76116006)(4326008)(8676002)(66446008)(66556008)(66946007)(64756008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9dTTE77wuDlG5eIQFs9JNYBgzhUNibaYFglI/z6YwkKjJztR+FAAcJW9fUoS?=
 =?us-ascii?Q?hiQt9uZZul//y9fkDl2ox/a69+F8oLLd6deKOz6cOd0hQGNgSvR9+6EGbUix?=
 =?us-ascii?Q?1WGjAWZIwyg68J5Gybc1XijPFUFSEBjJRVHPL4eUeiybnRBIeK2ziLZDyYuY?=
 =?us-ascii?Q?6t376cGqy8qHJVJKqsJmiIfk2IC4S71JXiGB6KKSgL6wH7B/3TmhCbNNlbz6?=
 =?us-ascii?Q?wu4DM9qFXkJoQJCu7j8d+DEdFt6mzKgTSMRFP2co3j9yLwua8D25XZlRGRhJ?=
 =?us-ascii?Q?oXCTZhboyG0BHsWHy6Ntng0+rylk00OtYgakp2QGWSkVJyRSAw5RojXkumWB?=
 =?us-ascii?Q?JUBXhIIUTMr5esuafjbktHEQ+PAEmtbqrxJE4NRO3TvwwacjpbMs9rOjjZrZ?=
 =?us-ascii?Q?eehm7Etn/aNjY+OMpEkJZECZ1X+0JnsE/CFYz5mH/mWhlk86W9kZnnpww7xR?=
 =?us-ascii?Q?eODLqFf+0A6r4ZT8ZEbiwu7oDi5frro6WdBnKbO6xNcx3mnJPXLCU+VPo1DE?=
 =?us-ascii?Q?0nFftA3ozFFU72ZdNBlbP67AsMbHOnIa6RWa9bsrG47+b75UmuyIb44U41lH?=
 =?us-ascii?Q?6luU9woXd/SIJR8/OEbNaPAFjm3qduTQ5SFF1kro9SLq+lvq2Il6XItrm5GO?=
 =?us-ascii?Q?JqDlQ4uvH4iR5zgHaLCIqzJOoeVZKoh1q+2ETkI/p0Biy5iNL86EjQ2g8n09?=
 =?us-ascii?Q?n/Wf76lzqt5cIF/uTp8q2ORjOTk9cS7suR0/9btsOQylQ5yZLF5lb2pqs29P?=
 =?us-ascii?Q?myK4ifAtGphtmwyEQeyDxqA35tEdFlvL3fGAzA/AOETv+hv35uK37wxc91jo?=
 =?us-ascii?Q?iXMlo0rYALkgxj7s1KQbf2CWMl5N0nA1kqoQBlaQhOR1+v8XM0ldC3z8bS/+?=
 =?us-ascii?Q?luBOu9BBcCM9uN/PW2EvJvRa9CJIEdAmx/PVs6tGFWLDimwSp7Sbn4SFun2X?=
 =?us-ascii?Q?UMVfHkKMuXYhRfufN0Qao39ghqQ8f4Hv5nv8bh1bUYpsIticHn12pp/g5Erz?=
 =?us-ascii?Q?LIa07wz6QRQRDILMo7LB9fBmXODg70K9TMkatvo0BbEmFzBI0HEJhiHFP2QF?=
 =?us-ascii?Q?yjLqR0luBt9tcjeT/H9mzH1bIiHqs0s0SIskDyTWGfZrQhSUH8qaAGzrOaLt?=
 =?us-ascii?Q?/R8q8rWsbACLvPnMZfVbv1F+hlFotYvF42XM8FNwrM1cqeiXrLmk8VoQgeus?=
 =?us-ascii?Q?pWK8RbretmOQR9ZeGEzVC8kYGoI///MaA8bWgS/krAP1taoy1mKW5TmnIB/I?=
 =?us-ascii?Q?bZasqq17bTTa5EMkooaMkHAs/BW/NdYIxzdJguyf1KaKXuKybw7pS9+mifeT?=
 =?us-ascii?Q?f9t4DEUFcYyNByWPFxikbqsKHYwPwL0dsxy7DhegkZn+yykPBmi8dtn5nMdf?=
 =?us-ascii?Q?BYejRhPHBNC1C+mFfFgMuZL0SwvpaJL8WOa0XkfgHN7/5VQ0PqpalDWR80LS?=
 =?us-ascii?Q?EKM1Gwnrs3SmWWd6v1B8ICaI9RNClFZV68L+VdZzDSNSp76lY9Vjtz91uSVY?=
 =?us-ascii?Q?B5VgmvW875HoVgs0A29OVbefRC/SLo6vvBETy1iFHHPQJv0i9jrOVolqjmQr?=
 =?us-ascii?Q?EgWcnos29IpAO0pM+ot5iFgbaCrS1wAkKYYuzy1P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620ab1a3-349f-4d1d-2dbd-08dacdb86852
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 01:08:33.4082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEGvnqtN0GmGX7gXwaNeyE9UKU+0Wrr6l+Eqs/9B6gXu8bZ/n/kWKmaiCuTfCCe9Ya3Jfz92OOyw125IhT1MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
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
> Sent: Thursday, November 24, 2022 5:50 AM
>=20
> >> This is general PCI MSI logic. So an open related to my rely to patch0=
2,
> >> is it correct for PCI core to assume that the real parent imposes all =
the
> >> restrictions and there is no need to further go down the hierarchy?
> >
> > That was my working assumption and it turned out to be correct with bot=
h
> > x86 and ARM.
>=20
> As a follow up, I went through some of the other architectures,
> especially the places which have extra limitations and it turns out that
> the restriction comes always from the direct parent.
>=20
> If that ever changes then we need a callback which lets us evaluate the
> resulting capabilities through the hierarchy. That's nothing which can
> be evaluated directly.
>=20
> Just look at the x86 hierarchy with IR. IR allows multi PCI-MSI, but the
> vector domain does not. Who is right? That's a decision which is made in
> the particular hierarchy.

make sense.

>=20
> For now it's valid that the direct MSI parent has the proper set
> available.
>=20

probably above can be marked out in the comment.
