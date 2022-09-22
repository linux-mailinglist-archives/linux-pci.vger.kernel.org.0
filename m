Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624415E5A75
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 07:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIVFLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 01:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVFLR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 01:11:17 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5649CCC3;
        Wed, 21 Sep 2022 22:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663823474; x=1695359474;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bP/yKl3QQ16+bc5saBUoaK9rgVirOypGU4uevGNPi24=;
  b=gfqbaIp/5vq4cF1dYtEVH1SWF2oQvGntXYro07dyW4jhTi6XWb3GTXtE
   o4VCYv5QAAoCW+WJ6y9hV3+LP2ftl6LyHvHD47w/6dezFJLPpvsJ3ZlpV
   TdTOevOKZR9wdmnm7xNRPaB5nGuOcEFVJsbT8SJwucf+7dVoWWr31Ba9g
   GoVXS0M86hUk3x/ji76ZwjgbSnCxEbQMCtrO4Hp74Sx/itcjeZpLe47C6
   mCK1IYEyTyVe/YArqPj0AjSGwE06+HkEfErSKPloPq/gIoDpZZKfcLBS0
   LbU8SvAS1+ac1wxE7aZ1ChusY6ag5To1TM6d6cpXBBmD5krN9FLpZ4J7z
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10477"; a="361963679"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="361963679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2022 22:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="723508014"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2022 22:11:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 22:11:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 22:11:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 21 Sep 2022 22:11:06 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 21 Sep 2022 22:11:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fgnc98QjDGRx2Zo/0PZzQSabFCkHrF2yvhnk6f/GEUneEXHLLZFWPLu4NZ0lxL3jze9KNyuqavBPziyALWqgSQNhPjUIthdVCAk5A9XECSm8XDuS3BNU57UnfCjF/ftqRU/v28PMv6b2zmgyeJJcSUuKPEsEb1MaBDnUHWNBENRyabDVJAWHPmBtoFdrVIBO9EgfKAl1q7Ds7CGivo6hWJ0BJ4IQcIBceAgoBKWWq33FvsaCJF1wOUoBf+aHZYG96yGzyQfveMo705OdtF/XLcE6mGm8LyaRi3wMik/Eqhor66dVBLotIqE36EYv74//71Doy0cxGiCIuk2sSpDVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP/yKl3QQ16+bc5saBUoaK9rgVirOypGU4uevGNPi24=;
 b=mw2FyCGdKWs6VoJfqt6r8HrSl20jRYVZjJCZKI0HON81mFmwolKAP7jB8FKrcOzGmN8YHxC+okZSw8u0fTo8BW9srqNnoBlqOZTswTS3PZm0PCZwHqYynHXA0JW/vRl0fu/MXB/oaZRTYdDVw8glpY8S7J+42meBXWYNBmEorREcoCsWW+uEAdFKZr8BfcmF2DFNdDig0GHNrhn0XBcEEBtR44nNubNoRoQiynnYS6e9vmmMnyHNqiL+kFa3CdlVIgJTNo67xiY0yK+uY66LHg8Jlf1aIEesw3o0uuZAvQkAcQ2EyTCZPBMgC81xd5+GH5pQHYlgvI/uYkC1Xpbm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB5681.namprd11.prod.outlook.com (2603:10b6:208:33c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 05:11:01 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 05:11:00 +0000
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
Thread-Index: AQHX4y1VNaiO68omHEet2J9DWrVARKwa1YEAgAAp0QCAABreAIAAIi2AgAE8MoCAAAd1gIAACyoAgAAPcQCAADDDAIAAp1uAgABn9QCAACTxgIAAAdGAgAAbd4CAAA94gIAABpSAgAt9SoCAADlJAIAAgb+AgABGMACAAAc8gIAAE+oAgAAmHACAAFJ4oIAAem8AgABqWwCAANPscIAAWxoAgADV7aCAAT/pAIGycJswgAhPdQCAASQawIAAV3mAgAERgAA=
Date:   Thu, 22 Sep 2022 05:11:00 +0000
Message-ID: <BN9PR11MB52768936DF8C7F19D5997A0C8C4E9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx>
 <BN9PR11MB5276961D838169BF237928E18C499@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YynJqID/E5dFCakg@nvidia.com>
 <BN9PR11MB5276CAB439EE27557FC17B1A8C4F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YysIEUbxjS328TAX@nvidia.com>
In-Reply-To: <YysIEUbxjS328TAX@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB5681:EE_
x-ms-office365-filtering-correlation-id: 377e4db2-a7ea-4404-e378-08da9c58d73d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/k1nptmKZtqUNIltFhGUpAbL95txhjEJiDdW982s/yjEf78wlvUvboELrRoCVspCgnUT+1SULnyNcLtZrdT6KUK6schYE7XWcI4n6U1D4bsPXH9ZGL+qpcataQ/b9zcfnYyZ2K084xtCMfMWos+ugMtCcFUhi706XRqhIzvyGQVzzzvjF0l6ubbv+/O9Duvai+hHG6ONYoEMvxlRc4GbNntybbZoDIm0V0b7mQXkiAFTtQZCI+FyEObKf7i1wLKzhUSH+jerC5CuNyiyVRndIqWDMakzXndlm74LG9HlvDGk5VRVdZyl8vo+l3MMi66TRCA97vusavbyqyMB03qPugtMvZ9mKKjs944yYpBJ87GUKQ25jeWR9wuLv5/ECXM+XF9/zgMgZc9WU4DzAjHRJEziR35qTsT42jOCSi2sSA+nL9VNMQrGa+HoiaHetHGrCdWbIg9xkuAMLVPujUOFvG4Rcgy4+uVWdujVMMq2ivcDFZkn6qPM3is6sbW+ouXadyEq/zX1uzv1PjtfEjwTELBB4GRtWPf4SJ42vHfSIGDQr/YD5am8fK2ahKwMzCy/KAjgFZvmsgQ6k/+cEGNdif2WvH+U+l8YSnERdzzAmnpfKJ9sG2MuBmA1Yx2TGVVGllNuY2E1vwss1iHrLK+6oGTs8T3CMJMZGbePiJpcwZ9uSo1r4lLVEKMyEjhxcUP7T5CjI+1HY81KsZmW8ZrMqcTDFMHXhdJjVdu+VwYgRzReAAXtb66iHkx6cQjQW+l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(478600001)(71200400001)(4326008)(41300700001)(7416002)(5660300002)(66946007)(52536014)(8676002)(316002)(54906003)(8936002)(66556008)(33656002)(76116006)(6916009)(66476007)(64756008)(66446008)(55016003)(122000001)(82960400001)(9686003)(38100700002)(26005)(186003)(7696005)(38070700005)(6506007)(83380400001)(86362001)(2906002)(66899012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oppc6bG9BZCk7df7t5tVu4efzBfEClWnHeC6r4s7ee1bBaTE+1pnOzEwvmy8?=
 =?us-ascii?Q?Ze2Js2KJyPSQGCDzgWc517n4trGQFZPWmHOfI7GemOnCM2Oi34FpxJactXar?=
 =?us-ascii?Q?7rgIjyHzVgBONXtjRjB9DjBWdBk3UnAX0xL+jNvRaUguZFaMVP9RTtnSP6hx?=
 =?us-ascii?Q?NOuQhDYTcnOcrTLAc6Jkvru4gRv+8k9mODhtghTZfd+ZSnQ0pdUKsx83rRgE?=
 =?us-ascii?Q?GmsRgZGWcoetA86zh4EfJgXIG1caV8aTsodevhZALHIui0gcCnnKgKPvL5Cs?=
 =?us-ascii?Q?EQ8w2IxgArS/rT03VvibOrgZpZChLVMlWr5KCc7zQAU8k+hHhaDSnxyLtBAW?=
 =?us-ascii?Q?Yx99ahwHfgWQFbc4nId8KCH1d/CClUgSy/Rem/LiDvcAAWni6HGF24cZMoAf?=
 =?us-ascii?Q?sTShq5g3Nu4aWstW9XKbZhokxd0qQ1kKUIgAQ5qa6UfRMmyAoRIVkZQs2kg5?=
 =?us-ascii?Q?GLGSKX0t6KGg1yJwihLnEW9xym5gt51jHX7UYdNkxuv4GnWMar/hkvcKW24k?=
 =?us-ascii?Q?AmUeCr/NSjdtYtD8q83jelNRQqJPzI8eBJkuABXyatviALr7BXihQvFYc89/?=
 =?us-ascii?Q?HFCaXTlqdLntU77bKNLuYGwLNHcra2YKoZwhpTHt6fIgobdtQZOPO9IKJKHx?=
 =?us-ascii?Q?KFB6KVlXjtYt+lLUyY/MxV4QxxCN1XhyOJhB6wleFj3Emxx/1a0lPdT8GAs9?=
 =?us-ascii?Q?7c73Fj7RqikdE4D2WY3Zs6X+FAkcL6opF5PKIew4mihnUhLccdjNSm7Y0AzX?=
 =?us-ascii?Q?/JmFNCHaNirj6zoZv/8McSETdFJ0VtFTqudtos8qsW8yH3EidjesY5X/6CsN?=
 =?us-ascii?Q?IBfSDTuQzCw1I54EhW9EZBpLAXZEE64NsTT0L/rud5Qn6pOPPmDxKJJG25U7?=
 =?us-ascii?Q?h0AsyB+7aHtZlcBoZIVQ0Qf8z7mxL5zvNnpfQCiQfk6UJR7AwxHF6855nD8f?=
 =?us-ascii?Q?UttnfNp+QJ11ZaP/S6AEx8BuulJ3wvWuKAzgrtOz6ElWQrVASr44U9nOxk05?=
 =?us-ascii?Q?bCb5XzMyxzEBlQFssuwmEsBP97MzAfLKyBjcaqP21IjjFLvyxkgeB+4XkZpk?=
 =?us-ascii?Q?LegLM8vAKcSulV/Gb9YFvyFrrKGSuqhqWVGEa8/oVOq+tleLPRY3QVqGCLXN?=
 =?us-ascii?Q?dot0JdqtYu7+/mF4AFhhWNHwXgEbBNhUn26r4k+ZNE/wHmYY/2hAl1crZ8ts?=
 =?us-ascii?Q?EO1yBN9hX9ZSwBOLz6QbhCX2grFKrABp1DDXwRcE0NwJDI5NM4uoIvDESXBY?=
 =?us-ascii?Q?o2x2p4kwKeoF1fHtApO7VIg0P+MqwYM+6XAE8812y2CuwLVO2HpOop8+GNi/?=
 =?us-ascii?Q?lHUmfgsvsbY4RV1SyuG35sgL4evcsOcE0bMlQO1uXxLLzY6jYlykxdnhG0bT?=
 =?us-ascii?Q?vGmh2ZfFr1oN8R70aUL2zDvEf9zBeCmSVVxJvXYD7VHCBjzx+pvUWQ/khmDX?=
 =?us-ascii?Q?Snb5wKkTLnCgf584qfX1nxi2KqiHvF295CSiHIj6fD9XoSaAg2sR17UXMNaK?=
 =?us-ascii?Q?x648xNLE7etH9yKu0GqbHypBf682HF/vL5Zi+2mvWCyG3QW0nav+gB05mGom?=
 =?us-ascii?Q?VHrDiyP2IYbQerSYUnTV5RLCQxgpseNiRW7PmvLy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377e4db2-a7ea-4404-e378-08da9c58d73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 05:11:00.8402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DLFRdFxsXUDujSqTTZXWw0WNucLAVWfwkj7Vw/Ga1qThU51DFlUrxZx3PsQFvxuDBCoAfrsgjtk71Bby98ODog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, September 21, 2022 8:48 PM
>=20
> On Wed, Sep 21, 2022 at 07:57:00AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, September 20, 2022 10:10 PM
> > >
> > > On Thu, Sep 15, 2022 at 09:24:07AM +0000, Tian, Kevin wrote:
> > >
> > > > After migration the IRTE index could change hence the addr/data pai=
r
> > > > acquired before migration becomes stale and must be fixed.
> > >
> > > The migration has to keep this stuff stable somehow, it seems
> > > infeasible to fix it after the fact.
> > >
> >
> > This is not how live migration typically works, i.e. we don't try to
> > freeze the same host resource cross migration. It's pretty fragile
> > and the chance of failure is high.
>=20
> Thinking of the interrupt routing as a host resource is the problem -
> it is a device resource and just like PASID the ideal design would
> have each RID have its own stable numberspace scoped within it. The
> entire RID and all its stable numberspace would be copied over.
>=20

Unfortunately it is not the case at least on Intel VT-d. The interrupt
remapping table is per VT-d instead of per RID.
