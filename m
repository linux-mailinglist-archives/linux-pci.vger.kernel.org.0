Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14BA62EF19
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiKRIU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiKRIU4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:20:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901912A714;
        Fri, 18 Nov 2022 00:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668759655; x=1700295655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JwoXQOlfavQdEGs2qKwWYfrHKamJqWd/2NmZIRe55Xo=;
  b=hhfOGplB0yrJ8d6/YUUblod07ziqKW02vOM06c9xeDpNsFrWaVlyORO/
   9g2oewT2Oj+T8GP2JYDiUm+i1Z162JXk1ugClZ3lvM+zGtK6S+1c9xp6s
   A3OOR8qt/AlJcKQC5ErPubxPog72Te7HcWlHhMTYbUIYSdd8JIEpegWLF
   VQz1YB09gdqajgzlt6jNVA6CbmpIWf4raGwJuFcRqnb4NOrPvzLGl4f0Y
   4ruQcBKzekRiH3iWGkmiZrKLR9r+o4cO7gBRpxlaQBb9nWs6tU4SsiJHc
   Kl6s8yKisnqldq2R4XIMBamXOb7LRovgQv/YL63ualwqqLak7+t3FcrHc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377354122"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="377354122"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:20:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="634355099"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="634355099"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2022 00:20:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:20:53 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:20:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 00:20:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 00:20:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANR1Rw2yvyWVsfN1pNyFKKGctHcgChWarzsl0ThnPNPfLOsmuaqfJCp2phT6GFC0bWi1z4zsUUbLLQ18G8OgBJgb4f69JE3BsBN0p8ttpt1EDhpjl6AXBOVOgeT0SOiqi1gNOrC9ZQhyPQpHorBsKfMk8KHfnkTFcu8wnv3rBJrMnBF6xJSXfAm2mH6RvybTXs3Kozb5g+zTzkVOxq6ltem0xsWf9sZqOwLqfbtyIBOFAcMVXuAPdBSBA0JkSfcHe82LnCGBeuo9NQXS3p2cI8sqb/P+1m+Ei48/RrN4XxnlzvANoc6lYkLU4En/SSjiXsxUAT1+FRYtEuTNuumn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwoXQOlfavQdEGs2qKwWYfrHKamJqWd/2NmZIRe55Xo=;
 b=Lkbd90DJ4seSOTAE8TmDaXA5+goFxP15SY3yUB1CpIJmybZWmN3wiLe6lWHfYLKgTHayua3Zv+LQghwscVgVUZhcl3mT6Il8Did+gk6xL0eiSAsa51EoSsHWlk6PTKiLWZpbqdenAWHuxl4Kd2E1KKJTg6p4q34gAglCGCpWVT9A+h/rcrZZWNOVM1WKNwDy27fUr4EymD83qGDJ89tsh48BbhP/m3ejmpUSaqSA0T73DQmyxbi9rQGAgFQVIAWlB6QywNyUq+WIyQi72VPsARF9RcVvS1ClXJB3UVSTeY06NMeJ+/HGR8YnCGYXIhQhh1rzpJx+fisGlXtAS6RC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ1PR11MB6154.namprd11.prod.outlook.com (2603:10b6:a03:45f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 08:20:46 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:20:46 +0000
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
Subject: RE: [patch 13/20] genirq/msi: Make msi_add_simple_msi_descs() device
 domain aware
Thread-Topic: [patch 13/20] genirq/msi: Make msi_add_simple_msi_descs() device
 domain aware
Thread-Index: AQHY9dV/LpnCnY60wEeqGpGXng5Apa5EYXFw
Date:   Fri, 18 Nov 2022 08:20:46 +0000
Message-ID: <BN9PR11MB5276877AF18FE5AD4037FF8F8C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.782035109@linutronix.de>
In-Reply-To: <20221111132706.782035109@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ1PR11MB6154:EE_
x-ms-office365-filtering-correlation-id: fbd154a7-b7a9-4202-9d47-08dac93dcb49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qMnRz90mFvyyz6ygPVMvSJDSUXXcInBxJ0D9lm9g8V4HQ6kebySiA+TISzs1YhGfOMMF8qV7S5QmhF04hbx+sGHhxABlCgn/kFtNkDbo+E/28JTSHzAfrfLR/qatF2Eh6nI0C35yC+AQWYi6t3Ynq6TuHQhFLveyLf85NI9EZzKEHUOyA8xpWNbaLWf/WVpL+JFP3iaRbVx83ADyR7evbl4YtEaVwYAL5L1zNZcBnwP8WDchvk7k0cDfig4giDgQ6cZjq1R1JDhG2xYbAD9ILOzgxoyAhpU0kLlwKYyXB/syIBUeOvIWm7GvO2I8kazJ0cYgVNq2cn+eJVWUCcyxW5d3RARqj3dY1VfeL9gPHYPvXHiEkdSAK1f7E6mxxMrFQBWxu8UVMLh3MOimY3cI5r31Z1j0EqmiUPVYJRZyJXGk6Wx3UoAwK1J1SWyzVbQBRnrM/7O6YJA95LB12HuTZCvY6Kk1SP7bcyvvxIOHRtfkY0TykMQYLNn6Wg5VhAUCQIEDjAhF+CZnv6r0EJFVhgjZUeWSsdqMuXCWR+dG808pY7/7kJcJFryLH4PV+UA8bXZA7ahzE/Bc6fjoI+DW08oyZEc6Hwr4WYGvQePr8/+2fJpP4EW+PPFifKdGTge0/952yQXrYColn3Eid1VpR2UhWYqGGsn6QjR8GmkoQHDF3soIi/ZpkbATabI/GYfQYAZCw5qBg0HmZuxx7nZ8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(316002)(107886003)(6506007)(2906002)(41300700001)(54906003)(9686003)(71200400001)(7696005)(110136005)(66446008)(64756008)(76116006)(66556008)(66476007)(66946007)(186003)(4326008)(52536014)(8936002)(5660300002)(8676002)(26005)(478600001)(7416002)(86362001)(55016003)(38070700005)(33656002)(558084003)(82960400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlQrVHFGUEJDbC9KMy9YZ2VSQWtuak50aUJtRGN5R082R2EwdXVYaDg0ZTYr?=
 =?utf-8?B?MEovRE1UbTlFUVdRT085LzlUdDg0ZVVwcVRGb1NmTUZYNDJjRW1oQUF1cTE4?=
 =?utf-8?B?VExBSFBPZ3FCN25GVHdScm1CRVVIcEFpQytVWTd0bTdmUGFnL3RZWE11RlI5?=
 =?utf-8?B?T0hXcEhXVmRwbjc0VW5CZVBNSnVPRVFTQ1RMMnVsdDdrZ3RyWUlISVM2cEZw?=
 =?utf-8?B?OFBYdEVrL0RLbzRXVmxxWmRHcStRNHhaWkFRYy9DOU1mNjcxcmNLZFREV0FR?=
 =?utf-8?B?bmg1UzJOY2RpN0NxVnpiajJPNUJFcnRjK0lnQTFzWmZBS1lBWTVNUFR3bklk?=
 =?utf-8?B?OXdzL1BmbUFXQjViL2FyREp0R2VSSGhqNGJNTHJYQ2RRa0I0WWdocnlMN1I1?=
 =?utf-8?B?QWpVcnVOOHBYcFpFeXJYQzhpZFQwKy9aNEx3N2FMZXRUbmtrNkswblIrWHVY?=
 =?utf-8?B?MmdScHJJdVgyNFlST1UycHJ1b2VVcmYvdG16S2YrT1I2dGwwR3FyZ1lzKzVP?=
 =?utf-8?B?M0lGVWtFMDRrTnJPYmtYanJsQmRDWklIMitEYUQxZllZdkRrVjdQalo1QUNk?=
 =?utf-8?B?K0lWd3EzSDhEY1hVQUVEemdBY0RTQ1EyZGpvUEszaEl6YXkyK3FPSU12SGRh?=
 =?utf-8?B?REYwZHQ1cG5LMG9ESU1oT1pMS1greHhaZis0ZEpBcW93RnpoSUxwbm1sSzk3?=
 =?utf-8?B?c0JpN0tlWmtwZGgya3VXVGpZQXVlMWZvM1ErTE5xRVl4NytGa0NjQXJGZTZD?=
 =?utf-8?B?WFo0VUJrY3hQN3l1cU92UGNnaFNRMHpLLzdKNm12dS9mVTlvdEkzR1A3ampZ?=
 =?utf-8?B?WnhLSDRCZ0RQSkFCT2Y2M3JFQzg0aVQ1NTBMWVR3SEsxUlpCTTZZWHlhVnZl?=
 =?utf-8?B?VlV0M2VqUExwVnpYdnArbHdtNklFYnJQbkl4UUhKbXRrOTliK0xXQkZNK2l2?=
 =?utf-8?B?Q3ZLRGs5ODZUcUgxYlRCUlNUbWlEZi9wS2tkNzVUM2ZmanFvSGRUYWM3VUdU?=
 =?utf-8?B?akxqem85TU0zaWQyY3lzcEVQOEFYdHVuTHR3bEZnTkFIcDhxQWF3aTY2VmtW?=
 =?utf-8?B?bDIxQXNJUm1OWlJtdjZXTnd4TUFhb1o3cXpFVngvT1ljWEFQTDFNYnlINHhN?=
 =?utf-8?B?cXJXMmhuaTFNWFBWMXg5Nnk0UytHaDBYcUpXMzFBSlF5czdTRDZCUXJ4UnBu?=
 =?utf-8?B?a0srQkpoY2diWnNXaHZ5L2tQUmxkcTlOaWY4R2l6SERac3paMWt0cHBpTlQ1?=
 =?utf-8?B?cDU2TldpQ0lScFpJQ1Vhd3ZLZkN5aTFGRysybmU4NkpDL2psTVdTdkRZVyt6?=
 =?utf-8?B?eUgyd1paTVVRUjN0VTdJZlI3eE9Yc2FiSDR0MFdaL2hUSkFMb09adDRXWXlN?=
 =?utf-8?B?cGxIRS9yTHhtemxlVG14N3hhc01qQjlxZkYvVXBpM3VMd1pHU01aMEZDR1BL?=
 =?utf-8?B?SUQyQVdRRlpzd1pCTVdwSVI2RnJZMzJ1bHZ3RmtsdnpnQ1ovOFRTUkV4ajVo?=
 =?utf-8?B?a1VQQXY2SndaUWJJUVBNaDBET1ZUQ2lMQVZ6ZmVsdEFqaUJlOUhhMm1obGRV?=
 =?utf-8?B?TDlEUVQrSlJHNUo3NXJyMDlLZFpoN1liQ0VlVURGOTgyamRNL3NRODVlNWJC?=
 =?utf-8?B?c3o1cHFIcUFZTkZDTS9oRW9jZjlmeUdiT1NNbklrcE5FcVNRQnl5aW8zOVQ0?=
 =?utf-8?B?bWthaCs5aHAyRktTMVc2dkZsWUNjUFhVMm93UU9wL1lTU3B6ZVNFUks1eDhM?=
 =?utf-8?B?d0JyR1A2OFc4aWROYk1NK3c4dk1rZUpkWjd2M3hmTmNKU3FlUEkxZ1VxUnBm?=
 =?utf-8?B?YWI1ZC9zd2xYMWtjdWZhSktPVFVCZXphaWlVSFl1OS92MTBZWnZPL05aUEZ4?=
 =?utf-8?B?OGFyQ3JOaWNYOUErNVVwUVpZanFVWHlXc3F5WmVMaThpVTNWVVJ5enREMVVn?=
 =?utf-8?B?SHJ2bDEyQ1ptNEFKR0o3eG44Q1hKaHllMEFxS1pMU2xiMHozYmUvNmZaMXJu?=
 =?utf-8?B?N3VIMjF0dXBvTW0yWDllUTFWQlhaZE5YazF4SUt4L2Y2eUZpY3NwYmFiWHlZ?=
 =?utf-8?B?OVVkR0NRQlZCeEVzNWJJS0M3UlVXekdqbWZUMmYyQUFqaGRkREJYM2xEbG5B?=
 =?utf-8?Q?9TwXdnqiPJYbtZ1p6I6rMUkYV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd154a7-b7a9-4202-9d47-08dac93dcb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:20:46.6821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PysDXIb3v/PFzsV2FtfdJWbCvXuHyMiP0N/jx0oZeiD6UO2Z6LQMtbA/CcGaHI2LTt5+J6NJJxpMiubz+mApVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6154
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiBBbGxvY2F0aW5nIHNpbXBsZSBp
bnRlcnJ1cHQgZGVzY3JpcHRvcnMgaW4gdGhlIGNvcmUgY29kZSBoYXMgdG8gYmUgbXVsdGkNCj4g
ZGV2aWNlIGF3YXJlIGZvciB0aGUgdXBjb21pbmcgUENJL0lNUyBzdXBwb3J0Lg0KPiANCg0KIm11
bHRpIGRldmljZSBpcnFkb21haW5zIg0K
