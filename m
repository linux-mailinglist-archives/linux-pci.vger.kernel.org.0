Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE815BF860
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiIUH5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Sep 2022 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUH5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Sep 2022 03:57:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0A80EA1;
        Wed, 21 Sep 2022 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663747034; x=1695283034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=p96RpKE/fQwHi2+7oLpCorwPul/+7um6geOGVQ186Eo=;
  b=Zjdpx+cS4Sxv9GAlIku/JiJs02O6g4ModcsYkx+elSZU2a0CctuYX2kr
   rCBAJfrgYd7yg7Iq+umK0f+qxy6r+psI/eqocMJe4sXAMS4Ljr5xkgqEE
   vu2nzQ1MnqidbcW8odrHRDpTzbMFEcfQPeXcXNPOk/blsaKXWKHE/s+eQ
   WedgrzHycQM61NuCPKb+hXYQku8HotGeMI6YRIIxUvAsIOXT/JNMVn+Su
   t+uNZV72VcJuG+nu+2MYf8K3En5ht6PLA11ghnm1aO/whgJdM0SH+MQMX
   NtCbu+0NhvVA7nC8YluAtJ1joXYZbb9Aak1QitXY8i0hTud049MDRWt+f
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="326244687"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="326244687"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 00:57:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="652432278"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 21 Sep 2022 00:57:07 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 00:57:07 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 00:57:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 00:57:06 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 00:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLoJIJp/vCK7cBczRKFuX5R75ECj9RYZY94QO005vlc3yRmSpXButRe8ei+otQWbIuz1KY4mB4WoE12ZP2WyblyQQXJqCYCDpPvAsgtfEJzuni729owo/qAoH+XGx2qs3JGyy4q8/XbdTRzMGfhui0nqj8oim5kkbNur16bF1Wz/6H9a87pL8NAePZzrzrWfdKwDJ0mx4Oxr+PxbgbMk+F/N+xNyen9vHxOc9I5VkTUGmDOBVntVK/rr9CrToK969jePOnBexa95OtSbBL2G8CL6BTQG6dWQtPtKPcf2b4MHeVwg4XVzaYkH8jceFo/YSsf3yjA0aoTwOdrCN1HR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p96RpKE/fQwHi2+7oLpCorwPul/+7um6geOGVQ186Eo=;
 b=DUqMjaR2GKEJGgNuq62KYmqwY7G/R1x3PjriFZn621fmd1LXtUEpi2sSiOGUAZdnEmI94vPlQ6PyTc8GPmGljR9LYm/2VoVAJnsH1vF8yuELZBsru3j1pXWo855p751ZRnWpelSzedsSmgGKRkwdj8UpMk9TC2I3b1ysEyRNrqmowKAtx+3crPlSwzrwrjSFhQxi/kfXRZ9pD7JzvGEn96VPj5xUW0qcF7bhq519RsR58NBOZZA/dTJAawBC0Z1nE5CUJPnAB1YkBx2t7J8Vgh/8r+NmBKYPIq9PE89oLXYZy9nTQT1oqB0uD41qsFMbE9o6kltrhFnxe8xZRYr5vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 07:57:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 07:57:00 +0000
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
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAem8AgABqWwCAANPscIAAWxoAgADV7aCAAT/pAIGycJswgAhPdQCAASQawA==
Date:   Wed, 21 Sep 2022 07:57:00 +0000
Message-ID: <BN9PR11MB5276CAB439EE27557FC17B1A8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx>
 <BN9PR11MB5276961D838169BF237928E18C499@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YynJqID/E5dFCakg@nvidia.com>
In-Reply-To: <YynJqID/E5dFCakg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4630:EE_
x-ms-office365-filtering-correlation-id: 714d42a3-fb50-4e88-a562-08da9ba6dd6e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FO7T63Xig+AKNjd3U2qP+N+E1OXnAVERIESWiZbdgbwmKJlgbv4XrRhP9x+u1lRHLmitYbHCk0tlKlmjgjbriW8KulAdKUh9Ox6UF+z36VQHaKzb+x3CnQ3eq5QoYqvAKQXxoxLEqPwEInucIvuQXeZesorQcv3BwPNnUh3FmO7houE4apELzsNm5RfGd7u6ffvmk8FEC5Pw8vWwnvmdLfVeqFwNCc+j57OPHUDv7s/fACVi5Lafrp7/w5gDGhCliSIqffTr1tVHNaoZhm532NafnfPbtBzBCN+IWVEBri9XdUFbJdoPMz1moiBt7l50PDq6/vlapEe2hn8snoG/804gvh5g2jEyp43BnjAM+IlkTFVniZm/HmoHHRAPJctIA8u6q0Yy3vFlI/hNsTvqkNfl40D2lmJ6pXGaRvLSa4rpLXtDj/kw7FhluMzcdgONeGaPis5/Pe9LpHrrgDNLIPz4l4RokkuxvDWfJzFp0EKEl8tP/1mpnTI3kz1/Y1HV1QPTaQRryE2KtUakP5Xk/JfA2B8o5mhXxm74rKVh1iCh9y6cANxtPPSW5v8pfwXBa5E/0WhJcxHz7WCdNTUVfbJ+TJOWRYZjdim02eszSZof17komlMkSc7Pk1e8SMYeo77lg0R3qaidVSf0e/U/GZCAUrgFsgs0hJaZv34MrRtrxDXC4uV22tf+nClFa57tNFPIuoPG+V2ve9Nj10oQccCEPuuXXkQ8oUrsgmjKyMjcPeOpubUWmEpWpzKZcgFM2kXBqlSW0IhV1qdvWKSKMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(38100700002)(122000001)(38070700005)(33656002)(2906002)(478600001)(71200400001)(6916009)(8676002)(8936002)(66946007)(66476007)(66556008)(64756008)(66446008)(4326008)(76116006)(4744005)(54906003)(316002)(52536014)(7416002)(5660300002)(86362001)(82960400001)(9686003)(26005)(55016003)(41300700001)(6506007)(7696005)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D4asN3dN3UmVvMo5Rc96pJWQenKM0u26QPWb4weiQgmAYUoU0NGC0goizzQJ?=
 =?us-ascii?Q?KPo9XfcZ6HKvTy3qPO6vXacxCgAuM6Xs4X6RK87OBDkrt/5/dzCQ6mDrpcmw?=
 =?us-ascii?Q?RLguTz7l/3Xh9wU9C76AporlqwWyLJkMp1jpvcmD9dLA73+8PlyfA8jMegHl?=
 =?us-ascii?Q?tkVrZ9Tu4k5pvk6+jdAU6DtWbaV4T42uRrssQNpQWbOJPayZVH9RD0INlbd0?=
 =?us-ascii?Q?Qjuog+r0Xp9ZxxzXJZp1riC2Y1+gecr4Y8VhhJXJyVrZOW1PsDtz87TOjPxn?=
 =?us-ascii?Q?gv2pWTXFEvjgrzBm+1qbGlnISeRrdJjRt+GnxWupNiimKxnBqU0jWjoRf8ws?=
 =?us-ascii?Q?oXG9EfYtVljV2BdazS4/mFU32lsdD3ZqLwZAe27L3BUgriOvyZ02DEBHVTLv?=
 =?us-ascii?Q?OJoi6yC81Bl9a73TuvdOgCgpcjZB1eHcE3gGGoqRUkBmOwp+nMV4VpQs4l8w?=
 =?us-ascii?Q?XtRCkQjgyFMZ8OJrV8w7WUfrEePIe46cNiBVY8UonNCCBa/bEFAXnx4DM0vr?=
 =?us-ascii?Q?YvC+sItlEyKNJ8/KpcE9j1KkBhbpK5SQOulHMO8nWjOyozGz+OJf0PnoWFpi?=
 =?us-ascii?Q?Fv3JjfSg32b+LT6X10SLtLKKDR1aWLs/5WuymS9lI5naOAU73fSOh+CqRFIZ?=
 =?us-ascii?Q?F86dU8mdPmo4tJnFkqQEj3D4KU/IBqHpZmcdpO7Yshr6k+KkQGiu7aE+Yzu1?=
 =?us-ascii?Q?JizCPfHCUTbeQbl6KCyv1TdQVn3mT16yshagt9MY4C6ooeiZjAhvGfye5VSk?=
 =?us-ascii?Q?1QA3FWLIeWgpCsQmrAjmqzhC5JVMT08o1JN5oIQ1zTd87lHg7Ixn873ItiLI?=
 =?us-ascii?Q?cvtVNdqK9i9yKD5eHdV9NJNzoOmRX0vDwC4aA3VFhg5k5jnSl5EPTxeqKTOy?=
 =?us-ascii?Q?ZVpHQYplG4GF15uFu+sljhGk6vEcp9i6eERqXp2ZlquJJNDZfKVA2rR2XInx?=
 =?us-ascii?Q?OQRSr4jRBsuefJO0cojGQ9v7pOH82+PKRefo2UoXdnfA8yLDICNwYqKKPFkd?=
 =?us-ascii?Q?P2EKEeS1vt9Ch27L0omtwS2jfKvu67/Fa+xdSDcRqkM5FvBp0gH/JEcPgoBz?=
 =?us-ascii?Q?CilXm5+ZhucgYFUSeCSrMlHMoacLi1VcE1r9afnyOlCC7kWzcANIM1X/HhhU?=
 =?us-ascii?Q?lGiSY4Jsd1k6zzI3X6Y+vyDThF3n+7Lg98vKRoaGoGOpz7VEukOpycgds08i?=
 =?us-ascii?Q?J1dgLfNPlO88XgZpZMeYfRrRbAUc9zOFr1U0okKxJ68xRlHDzDTn2daXQCyW?=
 =?us-ascii?Q?biXuX4B2uO1X9fCUp/0ZCqNytzEVvUiJbUJ1jXmlRjn4mMTdb7sDbE4TJ4lt?=
 =?us-ascii?Q?rhMR3qzL/So5EflCdEgrgiBOOVpYoGSj6UwR+Y6/YjFW0Z+cJl7ZKyZItAMh?=
 =?us-ascii?Q?FpvZwZkK4DbWuy8PI7E6gFcYhjk1z8EaWdIjtLvLPz+I/MWp4YGmhX1Oopi6?=
 =?us-ascii?Q?0kbAwijxVhmZo4Npqxkd8x46YK3wYzLAoUhs9i3Qd2kt/v13zvyMett9Qr0y?=
 =?us-ascii?Q?LpsD+lQpWk7gac5JWk4McsblHCFCBGCJBBP2B9KUqXAt2DlBiEFQCFvBH+SC?=
 =?us-ascii?Q?RakHVhcPGjDddQcRW/SHTqVM8mzjrnc+ACiY6q5d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714d42a3-fb50-4e88-a562-08da9ba6dd6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2022 07:57:00.8082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGQ2+wpbyK8gRqbK7rMWlTD2rFeY6piiItC/mrjTtt+dec98m5EN7s4uVFp/qO4VsmkDwY/JMq41MALfgc5JtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, September 20, 2022 10:10 PM
>=20
> On Thu, Sep 15, 2022 at 09:24:07AM +0000, Tian, Kevin wrote:
>=20
> > After migration the IRTE index could change hence the addr/data pair
> > acquired before migration becomes stale and must be fixed.
>=20
> The migration has to keep this stuff stable somehow, it seems
> infeasible to fix it after the fact.
>=20

This is not how live migration typically works, i.e. we don't try to
freeze the same host resource cross migration. It's pretty fragile
and the chance of failure is high.

btw isn't it the same reason why we don't want to expose host
PASID into guest in iommufd discussion?

My overall impression is that any such exposure of host resource
requires certain guest cooperation to do after-the-fact fix to
enable migration (though it's obviously difficult for this interrupt
case), otherwise the actual usage would be very limited...=20
=20
