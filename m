Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F1F6351AE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 08:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbiKWH6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 02:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbiKWH5g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 02:57:36 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF2B11;
        Tue, 22 Nov 2022 23:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669190253; x=1700726253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pvxZ+il5Rq1d2cTL1iNCsdns32mVgo0EpGXi2Zorafs=;
  b=FNshW/c+uCKdMXF2KNxJF46dlVXRN7cdmiMRbipqRZ11ltCHKLadkELh
   lXxkprOwUK2edttGoUBQ0cF7AeORKC3gtbeZQzz/2PtioHMf2fwqsbncN
   /ZlLIpOs9jfde2wstkmWTx+J1dRrIu5h6NQHP48Pc0cUg/vGjBhb4GuLP
   v+ZpajwqfYn26/r3/CMIUGkzudFuBnCiGGVLF8tPpuZESLZgXrcNY5Wfc
   Oj/ndtuGGZRQB10V8PvkCnuheS82MktUsJVAM0QuJtmHk8B078lbYUHDW
   C6ub1TrD8IlXISwp7cDvUVTL7jliZ5f/99Vm4dDPdjZnJsaEChTe9JDSq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="315828608"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="315828608"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 23:57:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="592426850"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="592426850"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2022 23:57:33 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 23:57:32 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 23:57:32 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 23:57:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 23:57:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo17HIiPpSJzX33PNnhJZezJZF1cFyjgLvWDMJzLcFM+Tc7+/l7n9Zcl+SraRLtL0PqQsj8S3yT52+a8YR1mKzF8QmJAbJDsYl8MoUWTUioKALa8ymUBt92iyUH6A+DPGxjz0MH/bw8JNRQBukYeg0L/XzBcubWcXq5eGO0oyjmBWqnRrIE/kdfT01FE4u3C6gpUis5ODi+RjqzzQYMzuWJfvknMmUjeL4AEs5Y2omhCC46Y3C9x4I+8ISiwfTkQIV5OX2pKwhInxF+iyIBktEJxouR5tIyO8ZE/XhvQ8wBTmonVotaNddzC+TWLWXhLPn74bWqKO+wpYNrbFncl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvxZ+il5Rq1d2cTL1iNCsdns32mVgo0EpGXi2Zorafs=;
 b=mPmrWPvwsrda+6aq4zII/vbjHXFCc+2wbu/XJ+g5KPxXfbWSLI1ZwIH93KuenVkkbMSu2Or0rTwkZ2AawAD99nlC15iG02u301hxidu/Cr/cI/pyrqO2qY0T2bOpv8WyxaJ+X++XUKWNMVDqKsiXuC8U4NtBrdsnSV8PgyxGrG4gx3KCgKMbNyF13L/JqMMnLYV6zHJFcRsNoT5q1yIpc5Pvl1Fs6ChkoEyuTJ9jpZUav8RCY/+5IOd0aiEMKxGLe6YTFHvMiRQD6XUUPRMGhNMILr+mZ97WS0Cn06CXjr4vIj6BsF4y3jeCsr4O77x4n4efYu0u/6CixcwXjgpHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB4963.namprd11.prod.outlook.com (2603:10b6:303:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 07:57:25 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 07:57:25 +0000
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
Thread-Index: AQHY/bbfZgnIzHqDcU+i9IUI1W3Xhq5MB7NA
Date:   Wed, 23 Nov 2022 07:57:25 +0000
Message-ID: <BN9PR11MB52768F0E5B9A4D8E2CF9C5578C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.604272160@linutronix.de>
In-Reply-To: <20221121091326.604272160@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB4963:EE_
x-ms-office365-filtering-correlation-id: 9e44a63d-3299-4463-4494-08dacd285c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ibN5o0y7NJrKCuqmBiUEAw/9Db9sAymvy93cIEmOcu3N4iA6pq2fPgBYtDcHeu1yQm7p8QvnH6WOczC5kYgPjs1V/pWqU9C3GdSRtotY/Bbtb5QT0hKaQDbxMTSy07Z1ZLKSRHM2oabzJYV3bhykGKdu9SYUlU1a2MGyCc2H6AOvuWmvczkLCZECZ1vSU3PUUKrM25a7Ap4bbUtpz1de1Dy6LWjUhdEGLXXxLiKXRnQiC7T8UMneVyvXPakbCafBcy2GrZW7v+ezfcjmD64cjXmgEMT/I/VCw6cslhm2VUkB97HuCuun7cRDrlZqSiZXwmkGdJUIj551ukc14b0VLJc9OrSKHRhZC7PhP7x5benXlzIs+0SXGbhxhhdk1+QSr7dhBqXwrjfsrbguNFwlo49erQZkHfoPZmtLFMZa8ZePFAuFs4sZrvX+hShf9vBKnI4QuR37QEtgKfFoXM1vgcFbMjcEMtAVCY5yI7LE838aCXdMIBPb/sPhubvch6KTQf5iU8Outn6HFKRyDdBnwqlwNgCKNbZIdmQJ8Okj36E3gKjIaNUsZFjh9P6v7N9lnrGwixhxzi6TPo5NYlM98vLZYBLcBROUo9dm8PpJFggcO+FvMhQtI0Do+SVs45lxU7SEEyVrkV4P0cwGB857SOLSReJsPConGIYn3vaYrOKQobHS/xYGBrzQXW4OW8q6ZBk7QX5wkImAX2v8nJWXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(52536014)(54906003)(110136005)(7416002)(38070700005)(316002)(5660300002)(8936002)(186003)(76116006)(64756008)(86362001)(66446008)(66476007)(66556008)(8676002)(66946007)(478600001)(4326008)(71200400001)(9686003)(26005)(7696005)(6506007)(82960400001)(41300700001)(38100700002)(55016003)(83380400001)(122000001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTVtcWsvcnJQaVltS3hxTjVTeHRmc1FvbjFJbEprU0xIb2JwVVdkZy9NRi8z?=
 =?utf-8?B?ZW5ma3gzUEFtUHlNTTNISytKRTlaZEx6YS9WdEl3L0UrK1FRdkZPZ3c1MXg1?=
 =?utf-8?B?Y1pmWDVqSkdpVFVob0dHL1pKbk4rbGJ5b2VwdHFFL095MUIyNGdVd3pLV2N4?=
 =?utf-8?B?cDAzSFM3T2FPdXBSU005N2xPSnduTTR5dHNRaTJEUzk1dTFDSXpzYzJMQXcw?=
 =?utf-8?B?L3UvZVE0dlVQVHUrRVNHSzE0eHZLcEk3czYxNk01SUpKa3JaUnhnWlNpWmd6?=
 =?utf-8?B?bDZDOUlTMmh4QUlNcG54Smw1a2hOM2pyTDVhYVhCMm1ZTFNBeWpoWllCSURz?=
 =?utf-8?B?SHFpSzRoaWwrVHFvVzVVVGk3bW1QTkxsblhWRVJJdFEvZndxVDIwVktHejVx?=
 =?utf-8?B?bW1mVjk4YVJmU2FaU3U4VElGQVpmcG85bGZmTDZYYVArWlJSN1RMWTk5Vzcr?=
 =?utf-8?B?Rlh1ajhiTjdXTVhzd1ZLNVV2VFNyVVBsME00Vk1yVUVKU2RSYVA3ZGs2WkVk?=
 =?utf-8?B?UVNpNFNWRi9hUFBvZ2lVMmZXbDZRRzNnVm5QemhHZksxSUw2UCt4Z0xmMEhS?=
 =?utf-8?B?RXg3bzJXeGVqcHBFb0RjMFNFTVBoRzFPK3RWenNBZEFhOUhEMjJtZ0pqbjBT?=
 =?utf-8?B?eGIwemU2bk9VMUlWY3FWR2UrTlZCL3Z3VVJRZXpvSWNJUkhtb2RjWUNYNktR?=
 =?utf-8?B?d3BCdVdVSEM5dzNEUlBRbmN2ODFRRXZhb1V1ODF5Mm9FYlQxNGllelU2U3hs?=
 =?utf-8?B?STZlQVpnMmhzVkZydEgzUi80T3UwNkZVblpkK0dQcVlVVlV3ZGR0dmJ4YzFD?=
 =?utf-8?B?UE9PK05ncDBqWHptb1d6bU0vZXJaOFNMSGZZM2NRQ01mUjl3eUNra1pNSWt3?=
 =?utf-8?B?b2d4NEJ6aytQWXptWUJFN2RaNE9ZcEM2Z3ZLSDZrVVVrWkl3aGpoZmxYVnAr?=
 =?utf-8?B?RCtaV2xBVHFWNlVuTE9kU09ZZXJ6VVlXdGUzV3o0RmcxRElJS3FUWmo2b0c1?=
 =?utf-8?B?ZnE2QWVYb0NHTFoyelJzSUcrblZFSS9qVXB3ZVlNVGFGSFk5em5mc3VjM0ZH?=
 =?utf-8?B?aStUejc4cUJVcXVHdnNGM2doWGlrUlpZdjNWcHRWc0RuVEd5K2EzWUR1ZWlk?=
 =?utf-8?B?UmdGNmFVOTJYL2tHYnIyRkVKM1d5SnU4bHI2dldwQkNRNzFJNUU0MDlicVdX?=
 =?utf-8?B?aTZxV2lKcUJtc3JOUjRrdU1nMGN3UWc0a2picElLWEVqSHpFc3ErMUtZZU5K?=
 =?utf-8?B?eGJYSzRHODgrUXNJcXU0TGtrZ2xqNTdGcUc5RCs2Ylp5RThzZE03SjFtdEJt?=
 =?utf-8?B?L3FuTkx3N0xvZ0VyVFlndUViZVUxMm56S1RTaW1ocHZ6Z2lxMjB5MGZTaE5u?=
 =?utf-8?B?cDVXa0k1bE1Rb1lRT2htSTZNWlZVYlk0bDI2ODhYK3NacHZIdmVKYUREUTU5?=
 =?utf-8?B?UThQOXFTUEc5Y0RNZ0t2bVhNTkNVKzBSOG9iQllmOVpFSzNVRjBpK1Bmd2lk?=
 =?utf-8?B?eEpLcklCNTBaOU9HY0F2aDVOdjAxclo3RVhlRHVreFVuRDJaRTRvM3dIc296?=
 =?utf-8?B?NjAwemlYb1MyWjBEYUFkd3FRb1NWZ3BOVlVIVG5PWndydjZ1V3ZQSDZFOU1t?=
 =?utf-8?B?MUtRUURwMzJXSDVOUHhVaFVDeGNicjIzSC8rTmFFTW4yaktRNEJkRFdlNnlQ?=
 =?utf-8?B?QkYzWXlTK0c5b0l4b2xxdWJSVHZsTE5vcURFS205OHRNVFZnWkh1VVdMNE9V?=
 =?utf-8?B?dWY4dG1DRFNtU2kwRG5oSzRaVmV1dERYWDRLelRiWGRuUWd4dTdDQis0Qy9C?=
 =?utf-8?B?aTJNZy8xSS84STJIMWNBSFdJYU1FVWhhb0dwVXdpZVcweU5MdmtDRVpMN09Y?=
 =?utf-8?B?cDNXWWwrN2dEZjRmZ2E4MUMrTnNnS2s3ZWdidS84dGNWT01YcW9OaitOZk10?=
 =?utf-8?B?MFZxRGlBSCtldnVUR09UdGsvNGdwWmp3K1lPZEo0cS94R1B5OWpDaGJIOVho?=
 =?utf-8?B?cVJmbzV6UVVxY3VtdHJEMmlJcGoxSzZXaE9LSE01T1hXSDZTSkd1b0JFUXZT?=
 =?utf-8?B?bzhWMjZ1anpWMW9RS2wrWGRsczNXMTdKS3pBSUFDYTlLSVlaVzZzWmJxdmlY?=
 =?utf-8?Q?wJ3guKNsYOJXcLgcgt6zxDStC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e44a63d-3299-4463-4494-08dacd285c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 07:57:25.2400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmvdxiM2cfy5av3Utcm8fwYBJ2ZWa/1GQzUi65BPyPQS6cIGd56phUmVzYS9QlBgekSMBb8bLQiDiMAQ/jldQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4963
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gKy8qKg0KPiArICogbXNpX3Bh
cmVudF9pbml0X2Rldl9tc2lfaW5mbyAtIERlbGVnYXRlIGluaXRpYWxpemF0aW9uIG9mIGRldmlj
ZSBNU0kgaW5mbw0KPiBkb3duDQo+ICsgKgkJCQkgIGluIHRoZSBkb21haW4gaGllcmFyY2h5DQo+
ICsgKiBAZGV2OgkJVGhlIGRldmljZSBmb3Igd2hpY2ggdGhlIGRvbWFpbiBzaG91bGQgYmUgY3Jl
YXRlZA0KPiArICogQGRvbWFpbjoJCVRoZSBkb21haW4gaW4gdGhlIGhpZXJhcmNoeSB0aGlzIG9w
IGlzIGJlaW5nIGNhbGxlZCBvbg0KPiArICogQG1zaV9wYXJlbnRfZG9tYWluOglUaGUgSVJRX0RP
TUFJTl9GTEFHX01TSV9QQVJFTlQNCj4gZG9tYWluIGZvciB0aGUgY2hpbGQgdG8NCj4gKyAqCQkJ
YmUgY3JlYXRlZA0KPiArICogQG1zaV9jaGlsZF9pbmZvOglUaGUgTVNJIGRvbWFpbiBpbmZvIG9m
IHRoZQ0KPiBJUlFfRE9NQUlOX0ZMQUdfTVNJX0RFVklDRQ0KPiArICoJCQlkb21haW4gdG8gYmUg
Y3JlYXRlZA0KPiArICoNCj4gKyAqIFJldHVybjogdHJ1ZSBvbiBzdWNjZXNzLCBmYWxzZSBvdGhl
cndpc2UNCj4gKyAqDQo+ICsgKiBUaGlzIGlzIHRoZSBtb3N0IGNvbXBsZXggcHJvYmxlbSBvZiBw
ZXIgZGV2aWNlIE1TSSBkb21haW5zIGFuZCB0aGUNCj4gKyAqIHVuZGVybHlpbmcgaW50ZXJydXB0
IGRvbWFpbiBoaWVyYXJjaHk6DQo+ICsgKg0KPiArICogVGhlIGRldmljZSBkb21haW4gdG8gYmUg
aW5pdGlhbGl6ZWQgcmVxdWVzdHMgdGhlIGJyb2FkZXN0IGZlYXR1cmUgc2V0DQo+ICsgKiBwb3Nz
aWJsZSBhbmQgdGhlIHVuZGVybHlpbmcgZG9tYWluIGhpZXJhcmNoeSBwdXRzIHJlc3RyaWN0aW9u
cyBvbiBpdC4NCj4gKyAqDQo+ICsgKiBUaGF0J3MgdHJpdmlhbCBmb3IgYSBzaW1wbGUgcGFyZW50
LT5jaGlsZCByZWxhdGlvbnNoaXAsIGJ1dCBpdCBnZXRzDQo+ICsgKiBpbnRlcmVzdGluZyB3aXRo
IGFuIGludGVybWVkaWF0ZSBkb21haW46IHJvb3QtPnBhcmVudC0+Y2hpbGQuICBUaGUNCj4gKyAq
IGludGVybWVkaWF0ZSAncGFyZW50JyBjYW4gZXhwYW5kIHRoZSBjYXBhYmlsaXRpZXMgd2hpY2gg
dGhlICdyb290Jw0KPiArICogZG9tYWluIGlzIHByb3ZpZGluZy4gU28gdGhhdCBjcmVhdGVzIGEg
Y2xhc3NpYyBoZW4gYW5kIGVnZyBwcm9ibGVtOg0KPiArICogV2hpY2ggZW50aXR5IGlzIGRvaW5n
IHRoZSByZXN0cmljdGlvbnMvZXhwYW5zaW9ucz8NCj4gKyAqDQo+ICsgKiBPbmUgc29sdXRpb24g
aXMgdG8gbGV0IHRoZSByb290IGRvbWFpbiBoYW5kbGUgdGhlIGluaXRpYWxpemF0aW9uIHRoYXQn
cw0KPiArICogd2h5IHRoZXJlIGlzIHRoZSBAZG9tYWluIGFuZCB0aGUgQG1zaV9wYXJlbnRfZG9t
YWluIHBvaW50ZXIuDQogDQpUaGlzIGlzIHRoZSBwYXJ0IHdoaWNoIEkgZG9uJ3QgcXVpdGUgdW5k
ZXJzdGFuZCAoc29ycnkgd2l0aCBsaW1pdGVkIGtub3dsZWRnZQ0KaW4gdGhpcyBhcmVhKS4NCg0K
SW4gY29uY2VwdCBhIGhpZXJhcmNoaWNhbCBtb2RlbCBoYXMgcmVzdHJpY3Rpb25zIGFkZGVkIHVw
IHdoZW4gbW92aW5nDQpkb3duIHRvIGxvd2VyIGxheWVycyBpLmUuIHByZXN1bWFibHkgdGhlIHJv
b3QgZG9tYWluIGRlY2lkZXMgdGhlIG1pbmltYWwNCnN1cHBvcnRlZCBjYXBhYmlsaXRpZXMuIElu
IHRoaXMgY2FzZSB0aGVyZSBpcyBubyBuZWVkIG9mIGEgcmVhbCBwYXJlbnQgcG9pbnRlcg0KYXMg
bG9uZyBhcyBldmVyeSBkb21haW4gaW4gdGhlIHN0YWNrIGluY3JlbWVudGFsbHkgYWRkcyBpdHMg
cmVzdHJpY3Rpb25zIHRvDQppbmZvLT5mbGFncy4NCg0KSSBjYW4gc2VlIHdoeSB0aGlzIGlzIHJl
cXVpcmVkIGZvciB4ODYgZ2l2ZW4gdGhhdCBNVUxUSV9NU0kgaXMgc3VwcG9ydGVkDQpvbmx5IHdp
dGggSVIuIGFuZCB3ZSBjYW5ub3QgbWFrZSB2ZWN0b3IgZG9tYWluIGluY2x1c2l2ZWx5IGNsYWlt
aW5nDQpNVUxUSV9NU0kgc2luY2UgaXQncyBjb21wbGV0ZWx5IGJyb2tlbiB3aGVuIHRoZSB2ZWN0
b3IgZG9tYWluIGJlY29tZXMNCnRoZSBwYXJlbnQgaXRzZWxmLCBpbiBhYnNlbmNlIG9mIElSLg0K
DQpKdXN0IGJlIGN1cmlvdXMgd2hldGhlciB0aGlzIGludGVybWVkaWF0ZS1wYXJlbnQtZGVjaWRp
bmctcmVzdHJpY3Rpb25zDQppcyBnZW5lcmljIGluc3RlYWQgb2YgeDg2IHNwZWNpZmljLCBlLmcu
IGlzIGl0IHBvc3NpYmxlIHRvIGhhdmUgYSA0LWxheWVycw0KaGllcmFyY2h5IHdoZXJlIHRoZSBy
b290IHBhcmVudCB3YW50cyB0byBjaGVjayBib3RoIHR3byBpbnRlcm1lZGlhdGUNCnBhcmVudHM/
DQoNClRoYW5rcw0KS2V2aW4NCg==
