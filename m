Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3C5E6FDF
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 00:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiIVWnB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 18:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIVWnA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 18:43:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB21E2B630;
        Thu, 22 Sep 2022 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663886579; x=1695422579;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ujOyjAbwgusik+05RbPipqW/Tv9rDb9xGVmgu0SLgDQ=;
  b=dppwaagnTU+sFDeJRCi54ToLftRvzZ0irOu+k7eHkVgmkxoHgRn4w768
   Ob6R/LgPJViRVZrxa3xoHgNsdiHUG/k28a4efWvAylNCbydt7mj7DtFy7
   WIyse+tGkges1Ge1RK8ff6Fq3U5rkJldQB1B/PVsIixm6sNdpwjr7D5UQ
   7SLWvHjvF4lN+KSIwaNCKuV6b2VvFX2U8RdseOA9xQOOincqqqphQK+Mb
   3Vc5xDO6l9CiYhUwozKS1U7SyleOb42mc4deu99Gjn0DUQUg/ms5+dAA5
   6aH6WlQ/14vVs8VgZKgcNcXy9SuOrKM/YMva6al+FAjAjr3LZ5EoO0Y86
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="298051344"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="298051344"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 15:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="948798613"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 22 Sep 2022 15:42:58 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 15:42:50 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 15:42:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 15:42:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 15:42:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBtZ+rQajHwSMYdUkZsi0dbp+SP0swpXUIW5PGLC3yU95gxK5yQIagwDIo4FoMQT4TC8meEhv6oBstdnsmmBrSsVpjvtzUIwurefQ2cYAlTbCvzcsuDigPabkULumTeWYj4ZSe4u/eV7+DLUgvDq51kD27ReYi3mpAKzWi3zHzt+mD2NksbdwYcTv0Duepe6rFKdhT5DipvVottf2YY+uRm/SYr//dlTTeZheKKBbPmkKGYdH5Px6JvNXw3JkItOY1y6S5q6ptiqF3JerNmF6XEj9mGRcaOR7kzkEqYja1ZI1YTYFwpQhD3mt6Nr8bS7wlwCpQNV0fPbp5gs9hblpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujOyjAbwgusik+05RbPipqW/Tv9rDb9xGVmgu0SLgDQ=;
 b=BZYS6OapWDYrdh40SuhaYXlg8XpJn0JDGo3C+BX1mxs3C5fXJCFrmTA8J+qKJb65qddCReUKcDwvFWBkT90aBMV5NpYoHQQgNz3MfRO3DTb4f+MIgQYgFmNqSp/DwP6oYd6GBsvEwjYzpTaqnHKs2tWVIzTo0Of+XdXjLE3SXmfBt4z6d3kjncnVSRkHQz0B3z2RH21x7bC5jPukVl1pmCbJi4CgC1FLz0Y6YGDLDzmmRUUzQVx7EUUjeX6tIckdvEYy9fkTyBKOX6LuNSX3PTdJ35MqxadeRvgiHHo3BQ5JrR1QXvedOQplfSQ5xVC7eWTF1Y7f3GEF7r5TtERrpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4941.namprd11.prod.outlook.com (2603:10b6:a03:2d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 22:42:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 22:42:46 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Logan Gunthorpe" <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bjorn Helgaas" <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Topic: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAem8AgABqWwCAANPscIAAWxoAgADV7aCAAT/pAIGycJswgAhPdQCAASQawIAAV3mAgAERgACAAHc2gIAAq/pA
Date:   Thu, 22 Sep 2022 22:42:46 +0000
Message-ID: <BN9PR11MB5276D6337528F356B44F18498C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx>
 <BN9PR11MB5276961D838169BF237928E18C499@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YynJqID/E5dFCakg@nvidia.com>
 <BN9PR11MB5276CAB439EE27557FC17B1A8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YysIEUbxjS328TAX@nvidia.com>
 <BN9PR11MB52768936DF8C7F19D5997A0C8C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YyxRf0UEEyT79oE5@nvidia.com>
In-Reply-To: <YyxRf0UEEyT79oE5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4941:EE_
x-ms-office365-filtering-correlation-id: 8e1a1122-f4b8-44c9-1eb7-08da9cebc4e1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3FNZGZhXe8+tKH/+TS9nfnrRP3KJ95goGi+UKo9K3TYu1lHmMU9stnGZnbQVLpdW91Im56uMkeHSjNzovTgLYmH73KNhFqGWV/nCrxadMHkb00xpEDFn2PnFmpfjRJWgkgtzn6f2M6poChsXuD2smm3nPTc1Xdd2Ll2KUO2A2meBw+tv0xNHMZdCKWN7k5ZfJSbg29rHEWRN8KEKD0J1UAPBBzCennptvWuM4WN/RmGxFop1R76OVStNJ6EgZJ7gu7sPxH5R1ZW2VcuOvKnJNtShgbtbGtOyRF6MQtX/OqZp6qNTfMxdQtoBwJsk0zDcZVTWXG4RY0SRuUq927wVIsx4+ppad1WHPnO/DWQ253l9f+ZcNrayOXrxkNlYl7oeaVBwZqtO/w6PjEF4N3ia46S55eptQ3T6GsJXM9HXW/C6Jj8YmdaOP7SaO1aTCrML1HF5Qz/nJqQ1bzo2Gwa2pfhNE3a8zO2GJ+Oroq8vEZiz3yzF98IFGwY/cs6MZZn/Zx7lZcR74ez3MDpnmhTlkV6L5TBpm8dRnjdcgcCRXmc0sHxu+S5qw+vSyCC9VkcIT0xGFBlouhsreXKixS0aWEcuZ/jBGcUxOYzlwXOV1r1G11B4ZftGvEnch9P+r7GZ1HHiyHx6Owb/3AnR+fzVf1QXODyFCR/u3nM7lQ3+0FmvpbOcfJl5X0G1i6oaVU0f9dHDonUH19OB+34l1cE0ot+nPHWeWimROGThvp8sVt7CCANPS/CXm5/jFQKssw3O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(33656002)(82960400001)(71200400001)(83380400001)(66899012)(478600001)(7696005)(6506007)(38070700005)(41300700001)(186003)(86362001)(4326008)(66946007)(26005)(55016003)(54906003)(6916009)(5660300002)(76116006)(8936002)(4744005)(38100700002)(7416002)(66556008)(2906002)(316002)(8676002)(66446008)(9686003)(64756008)(66476007)(122000001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rCOztX62mBk9EbTUucYFwYkIeoFATrOJ0dNh9lDB2e4R/CIYAmDBN+bjJijh?=
 =?us-ascii?Q?TAd3tN6kIv7PuIvqhtgZ58+GZ4dHe/ifMOY3S+qD38aWREbJgUUYoICJpjt4?=
 =?us-ascii?Q?XtwpMelQWQxv7JiygzjzqHIPfHJOof/Qya8b527Fdb0s5X/1GwEWuThwQEOk?=
 =?us-ascii?Q?nWnKh/v3by1GmIz/J3QR+fCvHkwNNbf9C/OSmiGg0Y8lLaqbIoXb6UtlpcHk?=
 =?us-ascii?Q?15YDiCu3Hhkqk2tKKx9uRVZS4YBBYTv3Dhfl5qE0TKfYlLIekqvdD12rpUjy?=
 =?us-ascii?Q?M6pJ3HyAKaGEsFWUPQ2dnTi03TTsVaGNenxcF+wJ2DbRF1/O0DgqxRLYB8Uw?=
 =?us-ascii?Q?0pj4Jfv1m8mnDZzYL9uc+qNIRtO/S/qm3tmBkq4ORW26eq7imosrqBrGIeoF?=
 =?us-ascii?Q?C1mTxN2LHV/oopQaA6KRTvKfjmsxjXvDDrUVM04TpG5FQqdep26x65gUc4Fs?=
 =?us-ascii?Q?wZkr9PIcA7faLa3i1pIVTEyHGE7qGNQCtAWdHBSaL2OdkJsKmLPqSNJjl6Bd?=
 =?us-ascii?Q?2koAbJWUijyU5R75xpdngevVDP6BSJDk2eAWTZ370S4PV6rIy3ba+0HNM8eJ?=
 =?us-ascii?Q?k1KytfODKXGqCpW91zzkcbTZ2eMMO+/Dyu72OJP84TykzPftL9DCmFrYyiw6?=
 =?us-ascii?Q?0g57ewGRiilfxQC+TLEamWgADj0YQ+Lhp0/PYW5CEISkY4gkEeRp6EdLWPO3?=
 =?us-ascii?Q?AXHpiIsbXCpt2upTGN6fc40wy0hFMl+lsm5dZgK1Y9+r7nTnUR/fxj/9Ae1c?=
 =?us-ascii?Q?/zDlUG5fRnaIRwhG4NIWJMsdHd8+hXnXgR9twTwFQF04LGbeNxe1CgTqXUqH?=
 =?us-ascii?Q?FE3+4TT6eYzk+lmDVUbSiCD/CQjqWPnjwsAQwl91w9cSHz5lvp6xbAEQzzEw?=
 =?us-ascii?Q?/6Z6cgA1ntRq1fO1oyWFpcX1tAFATC92/J4j1zgYkEU0ehmGOf9+xa6hrub3?=
 =?us-ascii?Q?Sf16+i4VpTy605EiMRRTXIbJ7pX/wryr2dNYIdkn47bKvHRPguJnsjxwAhvH?=
 =?us-ascii?Q?2cTusgTujjEBuees+lqJ2ccMpVUSjK9xMAJ8HkS4E4BgKKdplNgBiOtQmbVY?=
 =?us-ascii?Q?3qR2IHLRLmuNAY1de/cL7ei4mXD1+U6TXAJDZ64rS97HKbdcAiI75+TGU+Ng?=
 =?us-ascii?Q?wvfLL/Sf/qXkjWjvv2v5udaOoxGSp1AUAYJZDWWx7NXrRQUVbklw6mRMaTRL?=
 =?us-ascii?Q?buqA8tIS5Tj1VoeoR0X1IADyqjBMi/SAfksIQUuHt+M6ysm6L3zRSMwfBSv0?=
 =?us-ascii?Q?lt8l7L+J1Zmb0EaxxwUhiFsnbJest59BIZGG7SxtHCxf9M7s0f/izzr4n+UG?=
 =?us-ascii?Q?LIvJn+b3Xv1f8dsAFQGCJnZveAV8EBbPKvoZXqmbyMgIV/aHm4kAH5ujfojK?=
 =?us-ascii?Q?SpmwT0jSWbx0EpZtxlrcoAZvmLguIjg1nzG48LBMTGeimilpHOY+Uz8srWEa?=
 =?us-ascii?Q?YWyB03AqwPFkLddvPW2r8u1I5MJnTCDgdlIVUEKS0Clc/7Eozf+OfH5/PSti?=
 =?us-ascii?Q?Jd2nMAml7y20DUNJfWKC+4dPqaMbjFAuUeS48OLUK48DshiUGF/WLLDh+IQI?=
 =?us-ascii?Q?OVS3NVxbSGe4wo/F/50lHQwdu7uwq6JE7eUOccNz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1a1122-f4b8-44c9-1eb7-08da9cebc4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 22:42:46.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lH6d9dJwSORAIhUv54Q2slC2PG2e9JFGTG0G81Pi5FWzAwsfuaUV/fFnV/mgT3zvq3JYatHEwVo6UdcptlSpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4941
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, September 22, 2022 8:14 PM
>=20
> On Thu, Sep 22, 2022 at 05:11:00AM +0000, Tian, Kevin wrote:
>=20
> > > Thinking of the interrupt routing as a host resource is the problem -
> > > it is a device resource and just like PASID the ideal design would
> > > have each RID have its own stable numberspace scoped within it. The
> > > entire RID and all its stable numberspace would be copied over.
> > >
> >
> > Unfortunately it is not the case at least on Intel VT-d. The interrupt
> > remapping table is per VT-d instead of per RID.
>=20
> Doesn't that just turn it into a SW problem how it manages it?
>=20

When IRTEs are shared cross RID's I'm not sure how to make the
allocation stable between the src and the dest. They are allocated
dynamically and hierarchically in request_irq().

I'm not sure what SW mechanism can cleanly ensure a stable
allocation scheme between two machines.

Can you elaborate?
