Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EBF62EEF0
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbiKRIK0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKRIKZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:10:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469C725CB;
        Fri, 18 Nov 2022 00:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668759024; x=1700295024;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ieB0o6DozAHnoNchQFNBDO0PT1+84h2t/bl7RauuxsY=;
  b=f+AEdyDwzMyvT+pHR7MA6fQJFB+exm1vCKEr/sqvhwmSQvMtUQsk6ysT
   OOisbugQx5J6SBkYEXuQr6BilZBT7cf7Elb1sAFqTSbhO35bL8C5cFy/t
   jOOeSMlnvEOSy/JHOZPE0nehPlzWdoMr66chheeGJhtbTUcAr70v16C0H
   tXKSg3Bn9vbY2cKp62NQbxKpQHbjmFMplWUIHUYq+QCRZOyICPn8/ru2n
   2DXoNs693Qevqm7YFn+BAY/XKbtTCC4yNGoZuPZ3ZVs3OEe+eGuagN6x1
   f3G6yvfHBBODI2iaVdaZcXe0hmkJLEruebtBdVPL5Dz8bhr77Fxev+aTJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="300620287"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="300620287"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="729146406"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="729146406"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2022 00:10:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:10:23 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:10:22 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 00:10:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 00:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLSdJDbjKkQVE8z1M3dGJldhaXdYTY92/eed+C9XHaVZHNZ24jzy1vJ1DiZw3jssvPhfZUKGqEva/otpgCnern+LGU0vY87RCdIBa3H2bU7zGPbHtRpURNyBffxZ+fbc4pn3RtkfVTziYtykgHVfuRC5Dl9OseUASZifBjmvW5BeHTAVCFTEO6EDVegNnPjobX7oqB2GxZzUqSgthok7qCJkasv27RDma3U+8VYu+3f5kso/urY8VxNWglLAVW2jqWA6eUSgMp7Mobirdv/3XbIW/GhybzfwXREBz4GVOmLdtiDnYix9jboMyB/7Go6sVgFQYA7AbHOLZS4dMOtFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieB0o6DozAHnoNchQFNBDO0PT1+84h2t/bl7RauuxsY=;
 b=oYjrSFai+fa8jEw9ZHMZWG9U/2ucHgf6yUO7/hrLkPW/lWL0bXhBTJ/+lyQnEbh7VIcvqjSQxhZCyeAMy9sjiSi8P8D85R26xMDJBOKLRSn6tYsJ6exsrZ/9fbNxqMLUQVJWNlCJK51fD91xiqQ8AseTyZlcE3Gb3oJ0DLC/xZiBcVoOJ+hwzGexK7tylYz8q19LVwsWbsv0qvVeYBUx1pD0KXmqx/xrYwZGsDkHF+d7GPmCmqHxdPcQ5J5bX+TqfJnjgSWJ4tWh94EzvJpbcPWt54mAgRgZKBXaophCX1LjYHRZTnbSIXKhxant1QQ8jm6/vkxr50NVGTESupd9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB7142.namprd11.prod.outlook.com (2603:10b6:510:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 08:10:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:10:21 +0000
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
Subject: RE: [patch 11/20] genirq/msi: Make descriptor allocation device
 domain aware
Thread-Topic: [patch 11/20] genirq/msi: Make descriptor allocation device
 domain aware
Thread-Index: AQHY9dV+Hz44Za4IWUWr8WPPjKmC865EMmZg
Date:   Fri, 18 Nov 2022 08:10:21 +0000
Message-ID: <BN9PR11MB527676BC82A9A1E71AC7F6608C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.670241974@linutronix.de>
In-Reply-To: <20221111132706.670241974@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB7142:EE_
x-ms-office365-filtering-correlation-id: 56792324-ea26-4184-22c0-08dac93c5683
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEPwtPfa/bVa6i4kDqv57GsxLsDqe611IByllS3tF7NP5yPKyzQxu4BwlWAfa008uMnIXbVVqY371UThz6xcS9G4ltdB8rUUvcg93eklHWIsYQd7LTZEGmIk8rbfdg2vneTkuXJ4gXs8cJNrDGPLj7qMsA7qgHFMRzT8DP3cUgLXGI0rFwvd4D7rdEYFQXz2D2iqkAkJzOAEJlJxc/HoD6o7gc9GWQyOfnDHrzzQD/xwKDVyTSWDrB5bK0iOegrd4EjeTx/R0NL61HQuvDNdfm0SF/A4uCuqBW16HpjEw7GtwwZmaugf0E3Kx0BOU1QNEUOXyKKcVx7+y7GuFH+54wlZZKAo6n1OJqJTCv3jPMNvryYRBRu652KX3qCBIdWvzoqZ6CVxZEmH/6fZELdZ0opbYHSB2szkLz/CXKqmsrCWkP8JJ6h7dK3YkGjoF6YiLWBrTy/A8TX1dtHxiDmonZ4sBwToGjfR/RywWNoKxIqwczFAfXndFhlBA59i3G2S3dxtCc3sbrw4me7a6CtIHSUSfXy2eKXbHO1mVH6WtJu2OPB/C/WRuEYTYEEdECEfaEfo3hp3T6Jtgs02HgHmGlGWoSi0Xgf6VqN/CFDJT4/g+BE1KhXMKk/tBd6zxKVJAz6IPyhgwpomqYgrn+6vwUtgewHgga1pvK6oWz2d1n7L6POklYTVdA8xfJ18r/ZTi69deLRMfQfZW2oF3xwBAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(66446008)(38100700002)(8936002)(83380400001)(122000001)(86362001)(316002)(66476007)(7416002)(110136005)(52536014)(2906002)(4744005)(82960400001)(38070700005)(4326008)(55016003)(8676002)(41300700001)(5660300002)(54906003)(107886003)(66946007)(64756008)(71200400001)(9686003)(7696005)(26005)(6506007)(186003)(76116006)(66556008)(478600001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3ArblVDUnEvTlpXcjNyU3ZTTTdadFBqeFZCWHlqRnF1NVNldlk4TlJYNktV?=
 =?utf-8?B?N3VLSjllZkhqR3EzcEtvWjQvOTJGVGNCeGlpZUw5UXk4eWJFN2dDV3V3VDla?=
 =?utf-8?B?dVZSeFl5LzAyZmJmRWVTYUpxc2tNVlFQZEpvYktCN3UwdU9jd2N0My82M2lG?=
 =?utf-8?B?ZElSVUI4eFlQNlI4WnphZGpNVVhLc2VBbXVXZDhxTXhrM0xIQTQ5aVFXVHVi?=
 =?utf-8?B?R0tiQXUzT3ZVakRyTnlyaGVTNW03NVlQaXdaTkpJODBmS0lnSXVWZGNBcmlX?=
 =?utf-8?B?Yk9VWXgzYm1aL01teS9MVnp3RFR3aXNlNm0zWlhocnBNRXppSjFaUnNSdTZG?=
 =?utf-8?B?bEV6NThza2Y0cFoydXFjQy9jV09FNkoxN1VYbTFPeXZTVzhvK3pmRmI1Y09j?=
 =?utf-8?B?UzZWbjNTNlptT0JPRGxTb2RYSTZKL1pUSWJQbDUvL1ErNXFUeEllcXMycHlp?=
 =?utf-8?B?TXZCMm5vYlF3VkJzVUk2ZmlNQklCNmNtVG1nS1pXSGZGRU00bDIvRWltU3E3?=
 =?utf-8?B?RUNGYzRhOGtNQjA2eXZmYWtCaGowZ3FYVFgva0VMS1RISC9wNjFuQlBjMXJV?=
 =?utf-8?B?azhTRVZSVlhGcnZlU05rRW01cmhRMGI3YlgxeVJOY1pPN0tlOUNCZ2lHb2dF?=
 =?utf-8?B?MzFpbFN3MitIMndhMDFiZFVmUjAydElUSHJHK1dOa3I2dDZESFJNVmVqL1JD?=
 =?utf-8?B?Z1R0SXFjTFZkblJ3dXBPRngrczIreWxKSmZPcXlOQVZUN3ppZDFyamhFVnJY?=
 =?utf-8?B?a2YvZUZwYlh5dU51SUU1bzc3NzhMaVJqeFlWZFUxS1kwSkJudFVnRlBZZ244?=
 =?utf-8?B?WDJ3L0NUT1BWTFhSakJjbnFWU2JWZjBOWXZoVDhVSU1NenhKNUtPL29meGlx?=
 =?utf-8?B?VlYvR2h2RlRqcUhXcGJwV0hRMXh6UU5nenZjUFlFc3lhc2JKazVPZjlTQUJo?=
 =?utf-8?B?Qm1pYWo0dW5yb3U5TWY1VWpGVVl2MndiaFRjeFVBR2dXd0Mxek56cngwQzNP?=
 =?utf-8?B?YlZ5WjRONlZjWStTNzRnZFNkUDdRd3FoME9XOVRPQVZuZU1NWlVPZG85bWZm?=
 =?utf-8?B?TkJZREdpeGdiaGpJWFRpN2pEWUJ5NUhYK2F1dmtkQThaRDVWUVE5YnQxeDF1?=
 =?utf-8?B?ZlBJRXdWMzR2T0UvNG8yWnArYW0vcHlEYnd3RVMxVUtVdU0wU292WVFSN0dt?=
 =?utf-8?B?cXNxNGRPaFA4SnBHWk5Xd2RSUU1pRy95cE4wNklNVEI1NlFUeUxrTmFEVDdp?=
 =?utf-8?B?QlAzRjIzSSt5Q0duOFlpbGswMVZqNFR5dU1OTE9SQjJjOFE4TFFGajhwRkdD?=
 =?utf-8?B?RHl6WkVZU2pXR1J6T2ExcUxidVptNlZjMWhtajJRczk5T2MzR0RwakppVlEv?=
 =?utf-8?B?WWhHTG9uQTk0TDdGb01qVHFGei8vc3VFTUdVb1hTWW1NMG5KQklhbndhYVpK?=
 =?utf-8?B?NHltVGsyNm1oeEpmR1BuS0NlWUt3dE5IOVhmSzFRb21WMUJjSzA4N0ordGUw?=
 =?utf-8?B?S0JKK1IxSnVVdU9xYkg0WEQ0dUVYQ0Q2Z3NCQTkwVngyeE1FN1ZaVEdyUWgr?=
 =?utf-8?B?dTlpK1VyQ1lGVHZuaFRCSVFVQlA0bkIzbFdoQ2M0cDNVakR5TUE2Rmo0cVhG?=
 =?utf-8?B?NElxRkNvcVh5VG1hVU9BK0ZhT1B5VDF1WUE4WnJqaGdpRUNXeFlhMzJCWmhW?=
 =?utf-8?B?VXM0VlFpNExxWDlWdEJQb0lla09kTlJrVTFXQzc2N29nYXc4VEVVcllJdXp0?=
 =?utf-8?B?dWpIK2NrdW5hVlhLK05GVVBYWEN0ekd5d1dxa05CUUdHZm9KbUxaT1hJcDF1?=
 =?utf-8?B?ay9JODJtcW0vVlZGTmR4TU5KTm5XZnNJSFhBS2NHanQxUDJ4YTE5U1pKa2FV?=
 =?utf-8?B?cjN3UXo1R0pYT05ULzdLbmNXMDlYYjIrUHE4UXBOQ1N3QTFpN09XVmxJUU5m?=
 =?utf-8?B?VnNWRFVpUVkzNjZDeFltNzVlREJuZjFGNmhDSVpBSzZWUmxHQmxYSjFxQ09i?=
 =?utf-8?B?TVZDaEV6WGtMOHlNZzNZVFRaYnJGUlllc1VUNXRjTkR2RVdQbkhUeTZsMFNJ?=
 =?utf-8?B?eGVFcHRmTWNvTzMxd3N6TFJQSkhvbFhiNlNDUHcwUFVYRUs4MDc2bTFrS3Jy?=
 =?utf-8?Q?eTLstZZ7v7xv2ybj3c+FufR3F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56792324-ea26-4184-22c0-08dac93c5683
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:10:21.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Ue4Pxd+UrrtvtLKPDXgGecMqdVeWcmWOfLTNuT3o2tKqkCwOuIPIR/aXsIpIDaOAv2GYNep7RjK3o0IQSjMnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7142
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiArLyoqDQo+ICsgKiBtc2lfaW5z
ZXJ0X21zaV9kZXNjIC0gQWxsb2NhdGUgYW5kIGluaXRpYWxpemUgYSBNU0kgZGVzY3JpcHRvciBp
biB0aGUNCj4gZGVmYXVsdCBkb21haW4NCg0KYW5kICJpbnNlcnQgaXQgYXQgQGluaXRfZGVzYy0+
bXNpX2luZGV4Iiwgc2FtZSBhcyB0aGUgdGV4dCBmb3INCm1zaV9kb21haW5faW5zZXJ0X21zaV9k
ZXNjKCkuDQoNCj4gQEAgLTE4Myw2ICsyMDIsOSBAQCB2b2lkIG1zaV9mcmVlX21zaV9kZXNjc19y
YW5nZShzdHJ1Y3QgZGV2DQo+ICAJc3RydWN0IG1zaV9kZXNjICpkZXNjOw0KPiAgCXVuc2lnbmVk
IGxvbmcgaWR4Ow0KPiANCj4gKwlpZiAoV0FSTl9PTl9PTkNFKGZpcnN0X2luZGV4ID49IE1TSV9N
QVhfSU5ERVggfHwgbGFzdF9pbmRleCA+PQ0KPiBNU0lfTUFYX0lOREVYKSkNCj4gKwkJcmV0dXJu
Ow0KPiArDQo+ICAJbG9ja2RlcF9hc3NlcnRfaGVsZCgmZGV2LT5tc2kuZGF0YS0+bXV0ZXgpOw0K
PiANCj4gIAl4YV9mb3JfZWFjaF9yYW5nZSh4YSwgaWR4LCBkZXNjLCBmaXJzdF9pbmRleCwgbGFz
dF9pbmRleCkgew0KDQp0aGlzIGRvZXNuJ3QgYmVsb25nIHRvIGFsbG9jYXRpb24uIGFuZCBuZXh0
IHBhdGNoIHdpbGwgY29udmVydCBpdCB0bw0KZG9taWQgYXdhcmUgcGx1cyBhIGZvcm1hbCBjaGVj
ay4gUHJvYmFibHkgY2FuIGp1c3QgcmVtb3ZlIGl0DQpmcm9tIHRoaXMgcGF0Y2guDQo=
