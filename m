Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4125646FBE0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 08:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhLJHll (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 02:41:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:11201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233882AbhLJHlf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 02:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639121880; x=1670657880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BNQlx0w+RtnTGzK2cGVXlDGep0QRJAwj8io0a3TpCks=;
  b=j4UoZd/miTwvZzCrP/8LGIV0rTfhYMcKGcwP2PzKR99Ig2uNBwoIhlB7
   vr+a4JEas/Df5mCGxrtnCW4lKpa53kUngXVCK0W2hYTG7Wz2QGXVBM86I
   iiAoSDqV1CinyUdX15buLBmzKfkBaCauyDA5BP0Gum44JdpplqojuEPXR
   XvLl1VEjnL2khDw6mH80I80LHd8nWALVz7ob9Bo332HjAYkk6Qzy8jjv9
   WUddHEg5X27FHlfioIwSdFC9kYbxS8ELRdMoW0hSWE8Be98NCIkpkaRbz
   UNZwFptWh+p/xYxkD2OJElPshhgq/DNQ/h1gpPYsx7eOLqz8SECXklirB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225569301"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="225569301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:38:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="659476102"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2021 23:37:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 23:37:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 9 Dec 2021 23:37:59 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 9 Dec 2021 23:37:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+dI9ujepQ3DphCZKogwdcvCQ60acchNFpCAjaoIdl6pOkltLKLLcC94++C8tpc6Nsmo3Li9pw7er7Yve/dXb1I7Jp938wjTzrJE3/XpRtGewNgJolBi3YtGGmnR1gEwwtooB4JL+pdWLA+WVPRdKhmDJp7hAvsExFC3UQcgjSuJRHun3MC6A94rycokr5q8q69GMByzxIXUtEl8PZHGUBKzR1LC8nQbsGc/+gq9YMR7Z+eG1q7VvZx2sOZajCoQc8dnHtVsqTRXoJKlqY0ywo7821zcBnum8x+nWQ5a7wEKAAIMVN4J5ZyEid9YkLjyUFehNm8DRgCu4J2L+7+rtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNQlx0w+RtnTGzK2cGVXlDGep0QRJAwj8io0a3TpCks=;
 b=h7aEon1ZHv+zCGFt+aaFJ0unTyslEwyeVxO1X5v65uItxZGvElKHY9PkEwlnTYt4wMR9R/Tq9/ai53nclHd1NKv7I1hQKa0mcFdy/n2djE7wuN6Dx3JWGc7DDXPzn/YWkui42VXifzAD/z5mB5UyAoLwfhT1OyhTlzlVGrJWV24qeitxqRHsuEcwoiYF2RJI0uPd3Zbow0rxs3673L1Uahd0CA0n34aWmeKTgzGaL4FfLRRBL/Abn6Wzef41CiFFU6mh5dE9SjV+E/cNjTI0Y6xXPS/2pirUNltmEhoVzdOfRE5G2qmEWCwxGDzhWWo2NCr1CDwUuKMFJTBUVbBKiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNQlx0w+RtnTGzK2cGVXlDGep0QRJAwj8io0a3TpCks=;
 b=WNOJGeNxajnETHlTMXTMZGSGGNBR98YT64Q2uGlnejSJr9snbFixeuDXrDsMS0jM/rxV5NR9NQ7MxoVHD2GDfnnal/xo4u4bqXCbcCTaaFFo5Efzwli137G63G0oKb2Xh3qj1U8B2jGTPszP0ZPQklpgqQaBzOy1QG9zeoGtp5k=
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN8PR11MB3652.namprd11.prod.outlook.com (2603:10b6:408:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 07:37:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::5c8a:9266:d416:3e04%2]) with mapi id 15.20.4755.016; Fri, 10 Dec 2021
 07:37:42 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Marc Zygnier" <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgAAttoCAAEzjgIAACsMAgAAjl4CAAD2IAIAA6NQAgABcawCAAAmigIAAKimAgAAjYoCAAPMeAIAAGgMAgAis5HCAAEEdAIAANO7AgAA+74CAAQZAYA==
Date:   Fri, 10 Dec 2021 07:37:41 +0000
Message-ID: <BN9PR11MB5276B9A8D0C4D824999F81508C719@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com> <87o85y63m8.ffs@tglx>
 <20211203003749.GT4670@nvidia.com> <877dcl681d.ffs@tglx>
 <20211203164104.GX4670@nvidia.com>
 <BN9PR11MB52766CC46D3D4865308F61D98C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87pmq6ywu3.ffs@tglx>
 <BN9PR11MB5276BDE2AC58ADA7A66CAFBA8C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87mtl9zs7e.ffs@tglx>
In-Reply-To: <87mtl9zs7e.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c4dff50-9b29-4e5a-026b-08d9bbaff302
x-ms-traffictypediagnostic: BN8PR11MB3652:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN8PR11MB36525B62261B546958717F438C719@BN8PR11MB3652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goExaWsUUmqLVeDkmWRV6YxpdPVQm7QpMYaE7y4GjrEePd0EtLC9FrLcAplcdhW3IZTRC9EbcBuS0nuYeJ3KhLRyBwskhIb7Nn8Iev0ZiJt9DgKtxLQuxub2CCFFpmGr54AMwhvBuKy8yEQmQ6XZHmLZcsYAuglFNHPbYrpHgsoso8K1qcv5D6wKz2co3LYrOQcLyz7jIULOhZ1rt83+MmcgK87w6x5hFEosLu3Odwg/sZ0kx6lOVtgoCGJu9TJ0O/gUsiM6xQCTKzmkjigb4jc+qsNwxXnZ0/7LdV63wMFRIlcJsj1CgIiNI/O1oIL+xfaBaG/N5uDHeiLMy5jRK2a65zmH7lFVS8SG83wgYy256ndvtJgV80iHRJfJJFsk1P7eOM5jPT7DXMLzjAfI3wx41xGkRtbEGJWtaDuqxRrRZGTcyiDdbPlSwDZlRlrAmwlxlanpj2ZuRSBTwsCfVX1vaqOjvushI0M8ln+35vLYUEjWCC+ImsgY6+xEolpdmqUECwaPxQC8+z3lTdZSAzFG5xQCd9H7WFX4x61KutIlhe0aveu4fQQgLJ5KOedVi6FRcfaezKfW+rRUXhmz70TCTvJXaNrFqYzBTSneqbd7UO8G2FG7BUFzpneXNs7Y8CV/WRQj34D03S6ACwJF3Sz7jWixWfGc2fm00hMm1b6RysyObZBVK+/AP3z8tWOVINRoAQXoubkoJ5m/Zladgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(2906002)(55016003)(38070700005)(7696005)(7416002)(5660300002)(508600001)(6506007)(86362001)(71200400001)(122000001)(26005)(9686003)(76116006)(82960400001)(4326008)(66946007)(66556008)(66446008)(38100700002)(64756008)(110136005)(52536014)(33656002)(316002)(66476007)(8936002)(54906003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmkwQnF3N2ZSYVl1UE1laFEvR3BJR01TSEF1Tnc3Z3V3L3dvWTV3MkZrcUg4?=
 =?utf-8?B?Vy84QUJLdHRQRmxidmF2MkhYR2NTUWtjeW92cTRIVVJOSlE1VHVrQmlDekxR?=
 =?utf-8?B?OFo3Uk9lTDd3dHVQcHhzcHdnRVFhKy9oTFdaUmNQdTVWOHNUQjBieFZybDRD?=
 =?utf-8?B?b1ZiZ3ZWZFNYODhVVGpKODU4djNWRm94VGNpbE00QXpocWw0dVFMdTJmZGhk?=
 =?utf-8?B?ZVBUbnRHa2RobUNUb2cxbVBIVGlmaUNJMUpMa0JIazNuVytxSmFxTnY0bDNT?=
 =?utf-8?B?Z2htRDBjM1JZc3FEdkVrOHdjZ3FqYXdiVlBPM2krMU9taWZFTHV4RjJuRW5x?=
 =?utf-8?B?NzBoRFowdzlUbmxPWnhoNEpYVmd0RjJacnJ4UXpQSGJEeldYMVdQNHVBbWp6?=
 =?utf-8?B?OHYvUjRUdWRUdHhreFNlVjFhMzdydW1tWWRmYTJmcmlIdjZINzladjVIdnF6?=
 =?utf-8?B?Zkc0cTdRelR6bkZWb25mWWcrNFNuVU45RXE3anp5bUR0aWMyclhpa0NZZFQ1?=
 =?utf-8?B?eXVveTZsbU5INGVwN2pFbk5na2JYS0tvc01uLzJpYjdZUng0TXAzRVAzczJ5?=
 =?utf-8?B?U1Y2a0ppZFVIcldHT080R3VibzF6NXQ1UWQ5YU5SQ2NLT3VleWt4NG5UUTJq?=
 =?utf-8?B?Q2RGOWp1cDArQ0NsMnJ2UWdacjZSai9vU3dOck1NMDlqMjRFVm00NGxTSGE4?=
 =?utf-8?B?bWJiSWZBaExycUtsRkd0dy83ckNVay95L21URTNQblczVWFFWkZPRG1IS0pj?=
 =?utf-8?B?bGY2aHZseS8razBPaXhxTVJqSkRXS0lteUhVRDZpNnMvWkNsWEpYZ2lCc2ps?=
 =?utf-8?B?OEdST2VoSmhCNGJuZVVHV21qZjUyb3liYzFlcVgxWkdRV0lYQVVld1BtQ2Fm?=
 =?utf-8?B?M0tPaDV2K1EyS0FXcXBqV1N5Vm5QL3N4WFhGSFBFK3drajhvb2hNbzFzc3dG?=
 =?utf-8?B?NVl0YlVWeUFhVWIyYkpyTU1pVFNoT1hJTE1IU3Q5RmN4eDRKdG1zN0dtWjFE?=
 =?utf-8?B?REQzOWRYRDBYNmhaZ1c5aU9TU0hvKzBGR2tjQ0xIc0RpamJOc3RkSFR6cHJN?=
 =?utf-8?B?Q2R2VklTbGNaWW1YK3Y1Y3MrN3BWM0FQU0dBYS9OWGVHQ3FlMVZnL01ReVF1?=
 =?utf-8?B?NFE0cmkwRm5LdUUrcFdRamhMV2ZxRFh5VFYrNERvNWQvMS8rdjJUMnlRRENx?=
 =?utf-8?B?NDVKQmx0SCtNKytGaCtINXVTL1dwQnpXYmtEQnJ3RFhMYUN0N05UWXRkMW03?=
 =?utf-8?B?NVRPTjVpS1BOTTBxTUtFOXVWSFJ1SzA3bzU0bXM0SGYvUENJQjk1bFAzY0Zr?=
 =?utf-8?B?L3M4Mi8zZW1vMWRwQnJRaEhjazdBbVNncCsySEx6ekE5eStiNWtyQjV0cG5F?=
 =?utf-8?B?ejNLUEFBYUtUUGpKMUJEelR0OWNFUTJXV3NDZERyUUtTWGRFVUhTYzBHcy92?=
 =?utf-8?B?ZGJVTmtQbTBjNXZObStJcjhVS2F1SlFWdG94RFJQejlsY0d6N2l2dWpNdkN6?=
 =?utf-8?B?MGxiZHpzUzlpbzREcWdqVUsxYW5iWkFDbDViQkx3RUNDZlhQOFAyTVdjKzRo?=
 =?utf-8?B?dDVvNEZNNkZLbEFFMFA3N3BMSjVPclNxTFE2OUlyMXRQeFlaZXVqQzJ0dGJK?=
 =?utf-8?B?V1pJVm1PbElDZWtwZ251Q3Q4UFF6UDZFSlpFL1pHRno2MlFiSzJhT01ld2VS?=
 =?utf-8?B?cVczY1BpUGIvV3F5azIxZWNYTjg3RUh1dkhOb2srN3ZiKzJ2b2xvWUpJdnNj?=
 =?utf-8?B?L0dmZEdmeGtiZXB1dXhQbWJqYjV5WCt6QWM4bXV1Z05wZEFXSVN1Vitvb1FG?=
 =?utf-8?B?SmtQK1AxUzBTWXVWZ3NURTZzaTVjVTVLOUV3SnczaDZ4dnNOMnFZU3pOUExI?=
 =?utf-8?B?SW51S0JtYjZvbnlsUmZPb0hWbzBGN3orU0JQUUlFWUszdnducEc0MVBRZFkw?=
 =?utf-8?B?Y1E2d3F2UmVZZlJKaVhSa3VhVGdEM0RQL1cyd1paM1pUZEV0TjhTdzNNaUdZ?=
 =?utf-8?B?OUk0TElCcUhycjRtRWNna05vUmNOaTdYK1JyeUlaNE82ZmtCVjRQV1RIa0JD?=
 =?utf-8?B?bW93MWRTNFl6c21zTktZcXFWZ3pyRjc2bEpvQmJmbWV0RUNNVlk4TzlidHdm?=
 =?utf-8?B?bHFKZE0yQ2pyN015aDRHK2ZaM3U4NUR6S2FYMTNoZS93b2tDRmpQQ3hXKzRY?=
 =?utf-8?Q?J2+wbxh4KkEV0tVbMPXcPZQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4dff50-9b29-4e5a-026b-08d9bbaff302
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 07:37:41.9007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MElgu4qeVfYtk4HOYNmN2LGMWVj+aLsN9RojoTS9+PFGWIPLKiNYL6ge9VfqXiXJjGWakalphOeoHXEt1UKg7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3652
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogVGh1
cnNkYXksIERlY2VtYmVyIDksIDIwMjEgMTE6NTggUE0NCj4gDQo+IE9uIFRodSwgRGVjIDA5IDIw
MjEgYXQgMTI6MTcsIEtldmluIFRpYW4gd3JvdGU6DQo+ID4+IEZyb206IFRob21hcyBHbGVpeG5l
ciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+PiBJIHRoaW5rIHlvdSBhcmUgbG9va2luZyBhdCB0
aGF0IGZyb20gdGhlIGludGVybmFsIGltcGxlbWVudGF0aW9uIGRldGFpbHMNCj4gPj4gb2YgSURY
RC4gQnV0IHlvdSBjYW4ganVzdCBtb2RlbCBpdCBpbiBhbiBJRFhEIGltcGxlbWVudGF0aW9uIGFn
bm9zdGljDQo+ID4+IHdheToNCj4gPj4NCj4gPj4gICAgICBFTlFDTUQoUEFTSUQsIElNUy1FTlRS
WSwuLi4uLikNCj4gPg0KPiA+IE5vdCBleGFjdGx5IElNUy1FTlRSWS4gTVNJLUVOVFJZIGFsc28g
d29ya3MuDQo+IA0KPiBTdXJlLg0KPiANCj4gPj4NCj4gPj4gaW1wbGllcyBhbiBvbiBkZW1hbmQg
YWxsb2NhdGlvbiBvZiBhIHZpcnR1YWwgcXVldWUsIHdoaWNoIGlzIGRlYWxsb2NhdGVkDQo+ID4+
IHdoZW4gdGhlIGNvbW1hbmQgY29tcGxldGVzLiBUaGUgUEFTSUQgYW5kIElNUy1FTlRSWSBhY3Qg
YXMgdGhlDQo+ICdxdWV1ZScNCj4gPj4gaWRlbnRpZmllci4NCj4gPj4NCj4gPj4gVGhlIGltcGxl
bWVudGF0aW9uIGRldGFpbCBvZiBJRFhEIHRoYXQgaXQgZXhlY3V0ZXMgdGhlc2UgY29tcHV0YXRp
b25zIG9uDQo+ID4+IGFuIGludGVybmFsIHNoYXJlZCB3b3JrcXVldWUgZG9lcyBub3QgY2hhbmdl
IHRoYXQuDQo+ID4+DQo+ID4+IFN1Y2ggYSB3b3JrcXVldWUgY2FuIG9ubHkgZXhlY3V0ZSBvbmUg
ZW5xdWV1ZWQgY29tbWFuZCBhdCBhIHRpbWUsDQo+ID4+IHdoaWNoDQo+ID4+IG1lYW5zIHRoYXQg
ZHVyaW5nIHRoZSBleGVjdXRpb24gb2YgYSBwYXJ0aWN1bGFyIGNvbW1hbmQgdGhhdCBJRFhEDQo+
ID4+IGludGVybmFsIHdvcmtxdWV1ZSByZXByZXNlbnRzIHRoZSAndmlydHVhbCBxdWV1ZScgd2hp
Y2ggaXMgaWRlbnRpZmllZCBieQ0KPiA+PiB0aGUgdW5pcXVlIFBBU0lEL0lNUy1FTlRSWSBwYWly
Lg0KPiA+DQo+ID4gV2hpbGUgaXQncyBvbmUgd2F5IG9mIGxvb2tpbmcgYXQgdGhpcyBtb2RlbCBk
byB3ZSB3YW50IHRvIGFjdHVhbGx5DQo+ID4gY3JlYXRlIHNvbWUgb2JqZWN0cyB0byByZXByZXNl
bnQgdGhpcyAndmlydHVhbCBxdWV1ZScgY29uY2VwdD8gdGhhdA0KPiA+IGltcGxpZXMgZWFjaCBF
TlFDTUQgbXVzdCBiZSBtb2RlcmF0ZWQgdG8gY3JlYXRlIHN1Y2ggc2hvcnQtbGlmZXNwYW4NCj4g
PiBvYmplY3RzIGFuZCBJJ20gbm90IHN1cmUgdGhlIGJlbmVmaXQgb2YgZG9pbmcgc28uDQo+IA0K
PiBZb3UgZG9uJ3QgaGF2ZSB0byBjcmVhdGUgYW55dGhpbmcuIFRoZSBQQVNJRC9FTlRSWSBwYWly
IHJlcHJlc2VudHMgdGhhdA0KPiAndmlydHVhbCBxdWV1ZScsIHJpZ2h0Pw0KDQpZZXMNCg0KPiAN
Cj4gPiBJZiBub3QgdGhlbiBmcm9tIGRyaXZlciBwLm8udiBpdCdzIHN0aWxsIG9uZSBxdWV1ZSBy
ZXNvdXJjZSBhbmQgZHJpdmVyDQo+ID4gbmVlZHMgdG8gbWFuYWdlIGl0cyBhc3NvY2lhdGlvbiB3
aXRoIG11bHRpcGxlIGludGVycnVwdCBlbnRyaWVzIGFuZA0KPiA+IFBBU0lEcyB3aGVuIGl0J3Mg
Y29ubmVjdGVkIHRvIG11bHRpcGxlIGNsaWVudHMuDQo+IA0KPiBUaGF0J3MgY29ycmVjdCwgYnV0
IHRoZXJlIGlzIG5vdGhpbmcgcHJvYmxlbWF0aWMgd2l0aCBpdC4gSXQncyBsaWtlDQo+IGFsbG9j
YXRpbmcgbXVsdGlwbGUgaW50ZXJydXB0cyBmb3IgYW55IG90aGVyIGhhcmR3YXJlIGRldmljZSBv
cg0KPiBzdWJkZXZpY2UsIHJpZ2h0Pw0KDQpObyBxdWVzdGlvbiBvbiB0aGlzLiBKdXN0IHdhbnQg
dG8gcG9pbnQgb3V0IHN1Y2ggdXNhZ2UgZXhhbXBsZSANCnNpbmNlIEphc29uIG1lbnRpb25lZCBp
dC4g8J+Yig0KDQo+IA0KPiBXaGF0J3MgcHJvYmFibHkgbW9yZSBpbnRlcnJlc3RpbmcgaXMgaG93
IHRoZSBQQVNJRC9pbnRlcnJ1cHQvUklEDQo+IHJlbGF0aW9ucyBhcmUgbWFuYWdlZC4NCj4gDQoN
CnllcywgdGhhdCdzIHNvbWV0aGluZyB3ZSBuZWVkIGZ1cnRoZXIgdGhpbmsgb2YuDQoNClRoYW5r
cw0KS2V2aW4NCg==
