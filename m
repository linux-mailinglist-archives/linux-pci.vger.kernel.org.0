Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15616351F4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 09:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiKWIJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 03:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiKWIJB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 03:09:01 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF698264;
        Wed, 23 Nov 2022 00:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669190940; x=1700726940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YBtHH/F3FPFXp77VEuPtNwixWaPytGhn1onf9KtwKE4=;
  b=FA2meCTKeYOpPnZgqKnnp/knEGLiGvIQ13klRfp+Q100sdseeD8/bEkF
   nDCbvvruLl9LdJVeMbbl4aVtbG1YXGWt78BjaJhNr5raGH0KPeM/EJoAH
   JC2ErPEF9zRIEF9obk/NFfJR0MvQdCgvZwOnIEMpoFvfCVX5ujurEkSvh
   kGYn6Xqcas/MA5EpzNSEjwMIXfepeGUVPbAn1DYrNPwCdjbslG3p4qKtB
   sBRwYhwc2u8DAkjThrPOf9lEj7bYL+45CYeJXIX/f8VL5GPnNUkWAQI0L
   q67jEmWyn8ek3jJdP+zumFSdKYxeiCJ4DwE1/FNIKsaNANYYDu8hzOlmh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="301567443"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="301567443"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:09:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="672784296"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="672784296"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2022 00:09:00 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:08:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:08:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 00:08:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 00:08:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzjqUv7gdu+aiOiIbCumgE+W6GPMEmSgTOhChLzt1vC0H3tUc1dM/IghfA+PSQq/LiUN2wm1tYFJPl/MiSFwLMbDMBjr8QAEAanvBiVkaT9fDIErX6F6YntKke6iYCe4z6q6i3Jl4Md/b8GKjeY+7CUL0SZcIHOSk+n/HzLvnMP6Cez5a1N+fcsdoC9byjpTTc2UH123tno1d8iQvvfrzxVnn5526/mJVEnirtRVBHrC8w6Nqc6qNj5BvaC6aKmPU2ZGPzhrszQrKKm5TnHR80crrtQg04B7dIo9jVMZ1FTIR8yXCdSk8DZvNuaPOVs55U533K/BVdMMGkere17k2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBtHH/F3FPFXp77VEuPtNwixWaPytGhn1onf9KtwKE4=;
 b=dr9KNOdBqJCmOS5DK+U7pxzqzBqfIWnQxzZAbHuWvkoNgrdn24xNE8vNDIOO2E5wFS77+v2O56j3hB2r2tw0HWnhB1aeA9V1yYm6Rt0U9cc2okhTE2uZggvK/guAU4Y7zyeQkiIa8HSjdz7NpPfluPwbKGXwS2IwokkC5nX5av2eApvhrivYe9aDDc6M+qlnV3MV2BBWC40H/GPKFsF0BWw7ulRRkVjMzCRe9kzzRLdVm82xG73+qHcW1+hXQ4IzCjAz2NitTSqvVXjKOABOHnfgmps4/4uhTcQjJCXyrxs1Lhl4jX+iVbYkLpmSk9qKJM6Z+YxgkxRYN8ye+DJx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 08:08:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:08:57 +0000
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
Thread-Index: AQHY/bbibHqIjpCS0EGXLo0J/f6SVK5MFjUw
Date:   Wed, 23 Nov 2022 08:08:57 +0000
Message-ID: <BN9PR11MB5276E9AD0F86A27A23ED8CFB8C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.163146917@linutronix.de>
In-Reply-To: <20221121091327.163146917@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6325:EE_
x-ms-office365-filtering-correlation-id: 57d054bd-2695-41a4-ae2d-08dacd29f873
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NTnVKg5/Rh9qjl5pGHa8QMoKF7BcsLKVJO5lS4UFWa5l4D7f5zExbEyPkZPw+aATnS2BJ8TR7m7DVO6z1kIFRPzg1m5a5T8BbcKjWXc/SShx1TPjQyxdT74CrOmnHH8WiJVcVkg3gHUabHC79QmN9PpR/wsO90BJg9KidQa1UvJQRoko+sg23EMscK5bGmpaYChcuTD3zKMMlCRVAPOqoQagyEdNqAPMD1CtM66XSWEIqJLqEUd69z+PV2WakUjbJMoRRb0yMCi4a7sedZ8j0PyyXnswJ1Uit42pi55K0vaMoX/ICvK+9oP/I0mF1I+YbWfDO6MNZlus9YAEOl50zBm4vayEM3bg8ZhiHESeiq9BE7iD4SLOQQMg0dWWaJAtCIW2y+S8rgBrGwob8V4DnyQEASwrSA+kiJS2ghFV/HOXMubhp5ObzIaELanMeApuK0lz0H1Z1lBg3hvvesGA+BvtNcSKuX5mSMKROM/m6u1wi6eIScDu0picma2oSe838ud8YQwzJ88PnRW/PVz5Y5bzX49c61KDwXvT+eYQo/zQkHPu2WkVVkzItSwAPAH7+w7FOkO/JwWbJqHLB0wgf74K/SqXMs8MD/pejWmQLF4XRecDIoqI0eEZeC4U7oHfo6TmYNqiGSzGFSLhy5xu+sx9XdjAVDhQtHEB5epUqOJAib8pI4h9LQhBCy73TcSxAI80DLD83AoQveRKLQ1Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(86362001)(76116006)(33656002)(41300700001)(55016003)(66446008)(186003)(66476007)(64756008)(66946007)(66556008)(52536014)(5660300002)(4326008)(8936002)(478600001)(8676002)(7416002)(71200400001)(26005)(110136005)(316002)(7696005)(9686003)(6506007)(54906003)(122000001)(82960400001)(38070700005)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFcwSjgySTRTZ0RHOHlMckpCOUd3b2dyaXlHeW9kS0ZiWDlnWHczTHhWZXVT?=
 =?utf-8?B?WkZNeGVOLzMraVV6ZHZnZVM4SGVtZEpYQ1NlcU8vWGhLVHFDMmgyQ0wrY1Nm?=
 =?utf-8?B?Q3daVHM5SXlUOUY5c1RNbUFDaENyVFNwMHlZRXA2ZzhGdFB5c2V1NUV2U1dB?=
 =?utf-8?B?Nm15R0hPK0lBMC9rbTkyS2VUTlp6MlJpWWVja0xLWW1kQ25kSTRUTUdPWkdT?=
 =?utf-8?B?OEU4alEzSmU2VHV1MDlUT3VIWWFXbUY1clpPTmRqdzI4WStJMFRhTlYzOGdH?=
 =?utf-8?B?MjJCcmo5cFRWaEZkbWVPaTgzOU5ENFpjcktUL3Z0SGF3THVqYUZobCtIVVlB?=
 =?utf-8?B?Q3ltMXYvZGtxTTlIaTVRRVdNTU4zckN3b2p0Y0JQMVh5eE9VS3FoL2FoaDBG?=
 =?utf-8?B?KzlmWE4vNDdabDlRaDJDSE1yOXVrY0tQTTRwS0c5aEkwOGt1RVpJbzhoYUNI?=
 =?utf-8?B?MXY1TWlVYlVRMlZzazFYbzFzSUI4SGREZWJUODZqNnlsU1dXekdVZzRNdlVI?=
 =?utf-8?B?UGNIMW9QSnhRN0t6N3FxTStWVS95UDJwdUJ1RXlTNTA3ZmZUV1lvTG9Nd05p?=
 =?utf-8?B?dGpIbURWQyt1QjdwS2VlVU1YSnN1b21GQ3p4cmdrcFRBNmd2MjZyK0x0TmxO?=
 =?utf-8?B?K2pDL1dBVUJrcEk2N1F6MUR5K2I0NGRHbi9rN2R0eVRxamtQdERML09qM2l2?=
 =?utf-8?B?ZzlacmhtVk5rSC9CTFhjTitCeCs1NjJRbjRhbVVDZ2pOaG5UNSsrMHJHL0lS?=
 =?utf-8?B?S1Zkc2V4K3VYeTlMbEJLaTFKVDNmdTNEZXNEeUsyNXEwMTZGUjgyWFVOWWcw?=
 =?utf-8?B?WG5sNFh0a1NCQTRMbEhnNlJzYzJoVnprS3NwblBsMkJPZGVaTnJVaVRVZ2ZE?=
 =?utf-8?B?aWtZVlBqRTBlRW5MWWcxWGp3cXljMFUxOVZtdFhBYmNlRkFiSUNGTWhkRFVJ?=
 =?utf-8?B?WjJ0QnZkUGJ3TWZ2eGhTQVF3aG9JcWhPdTc3NlVRYWs2VXRNQi8zMUkvcmIx?=
 =?utf-8?B?Um9JMWR2ZFI3NEE2d1NYT3RnYmsxKy9oTHNRU2RZS2JNZTNHRi82Skp5MVdM?=
 =?utf-8?B?K1Nablh3ZEh3dko5QnZxdVl2SzJ3ZllNcWYybmxNbnlXUm9VU1d2RGxOWmFl?=
 =?utf-8?B?bG1zWW5aUGZUTm9tbWFuRkUrZVJ3ZzVRek5QSEdqbzhOMFZGYkwyUmRVejBI?=
 =?utf-8?B?bE1NOWFENHRiOHU1YUJNUzRUa3YyNWNhd1NrbVh6bTVuU2o5a1JyYTZpMHlv?=
 =?utf-8?B?OWNFZjZ6KzBaMllJaUFMdjRpN0hyUmZUVHR3MWFvMk0yUGVjVkxGdmFIU1Av?=
 =?utf-8?B?bzZtZCtLK3FjMXBNVjJVWVdpV1Y1SytmS1ZmODBEY2ZncG96VXdHNjJoaVE3?=
 =?utf-8?B?eW14Sk9OY3cybkcvREFCd2JoaXpSSjBxWmhtYmc1ZFZFVmVtaDA5Uyt4REFY?=
 =?utf-8?B?dEtBaUdML1F4Z3QyVnVINUgrSnFWMkpSMHpYWjBrR3VPaEwxWWpkeVZ4WWtl?=
 =?utf-8?B?MC9SMkswNjJidy9FdE5YajJqOTBOQXRKK3RtWHpmNUl6OEpvR0NuVUhwaGh2?=
 =?utf-8?B?bTFkQ2tjYzNCa0tsa21ZaUU0TWhNekt2MjUrMmxBVjV0eVlHRGk4Vk00SkRh?=
 =?utf-8?B?dHVSZzZMNkJkVno2ZXBuQ24wTXNvQmQ4TStpMlRIVDM2Wm9ZSVR3YkxiUjFR?=
 =?utf-8?B?ekhLVDRXWFdKeEIxd2NkY0tCVHJpUHdNSUdqeURtTTUxd0I2NmY3bm5KMVh4?=
 =?utf-8?B?MkxkajZKdUZFRDFKRzRuWFpia0tneTZlWUE0SEZGMmxqVGMzSFYzanFQRjcv?=
 =?utf-8?B?cytibkFvcm1NNTNOSURYQldDdU1MRUs3bmdoS3dXZSsvV3hnNUM4RFlQUXUz?=
 =?utf-8?B?TG43WGFsQzNkYXZFbTdGQ0ZKU3ZJZ3llM2pOcFREdDBBeGNZekpVWllqTUEx?=
 =?utf-8?B?MFBQSDFCeFFpc2lkL2JFd1BOMFRoQ01PbndzMk1GVmJEU0F3UXNORzFjdGwr?=
 =?utf-8?B?REtjaVdCU1IwQ1FHa2o2cHBiNGRxeFYrQy9KQ0JUTjl2R3hWQUxhaE1ZV2U3?=
 =?utf-8?B?dkpkeWI1bE1GVjFZNnUvMTduYVd4Qk9ReUZLR1c3aGdGSkxFbkM0dmJleHRq?=
 =?utf-8?Q?twZPAQCozZ5DQfuD3Ruw/4v2a?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d054bd-2695-41a4-ae2d-08dacd29f873
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 08:08:57.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyDxIRofMk8/nLF4uWtNJFvG86DiQHR7w9ZJULFf4iMemgab9qe92GDdz+e67BLfHpZ6jy35FIZM6jQX3VBLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
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

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gKw0KPiArc3RhdGljIHZvaWQg
cGNpX21hc2tfbXNpKHN0cnVjdCBpcnFfZGF0YSAqZGF0YSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXNp
X2Rlc2MgKmRlc2MgPSBpcnFfZGF0YV9nZXRfbXNpX2Rlc2MoZGF0YSk7DQo+ICsNCj4gKwlwY2lf
bXNpX21hc2soZGVzYywgQklUKGRhdGEtPmlycSAtIGRlc2MtPmlycSkpOw0KDQpwY2lfbWFza19t
c2koKSBhbmQgcGNpX21zaV9tYXNrKCkgYXJlIGNvbmZ1c2luZy4NCg0KUHJvYmFibHkgcGNpX2ly
cV9tYXNrX21zaSgpIGdpdmVuIHRoZSBwYXJhbWV0ZXIgaXMgaXJxX2RhdGEuDQoNCj4gK2Jvb2wg
cGNpX3NldHVwX21zaV9kZXZpY2VfZG9tYWluKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiArew0K
PiArCWlmIChXQVJOX09OX09OQ0UocGRldi0+bXNpeF9lbmFibGVkKSkNCj4gKwkJcmV0dXJuIGZh
bHNlOw0KDQp0aGUgY2hlY2sgYWxyZWFkeSBleGlzdHMgaW4gX19wY2lfZW5hYmxlX21zaV9yYW5n
ZSgpDQoNCj4gK2Jvb2wgcGNpX3NldHVwX21zaXhfZGV2aWNlX2RvbWFpbihzdHJ1Y3QgcGNpX2Rl
diAqcGRldiwgdW5zaWduZWQgaW50DQo+IGh3c2l6ZSkNCj4gK3sNCj4gKwlpZiAoV0FSTl9PTl9P
TkNFKHBkZXYtPm1zaXhfZW5hYmxlZCkpDQo+ICsJCXJldHVybiBmYWxzZTsNCg0KZGl0dG8uDQoN
CmJ0dyBhY2NvcmRpbmcgdG8gdGhlIGNvbW1lbnQgdGhpcyBzaG91bGQgY2hlY2sgcGRldi0+bXNp
X2VuYWJsZWQuDQoNCj4gQEAgLTE1MiwxMyArMzE2LDMzIEBAIGJvb2wgcGNpX21zaV9kb21haW5f
c3VwcG9ydHMoc3RydWN0IHBjaV8NCj4gIHsNCj4gIAlzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZvICpp
bmZvOw0KPiAgCXN0cnVjdCBpcnFfZG9tYWluICpkb21haW47DQo+ICsJdW5zaWduZWQgaW50IHN1
cHBvcnRlZDsNCj4gDQo+ICAJZG9tYWluID0gZGV2X2dldF9tc2lfZG9tYWluKCZwZGV2LT5kZXYp
Ow0KPiANCj4gIAlpZiAoIWRvbWFpbiB8fCAhaXJxX2RvbWFpbl9pc19oaWVyYXJjaHkoZG9tYWlu
KSkNCj4gIAkJcmV0dXJuIG1vZGUgPT0gQUxMT1dfTEVHQUNZOw0KPiAtCWluZm8gPSBkb21haW4t
Pmhvc3RfZGF0YTsNCj4gLQlyZXR1cm4gKGluZm8tPmZsYWdzICYgZmVhdHVyZV9tYXNrKSA9PSBm
ZWF0dXJlX21hc2s7DQo+ICsNCj4gKwlpZiAoIWlycV9kb21haW5faXNfbXNpX3BhcmVudChkb21h
aW4pKSB7DQo+ICsJCS8qDQo+ICsJCSAqIEZvciAiZ2xvYmFsIiBQQ0kvTVNJIGludGVycnVwdCBk
b21haW5zIHRoZSBhc3NvY2lhdGVkDQo+ICsJCSAqIG1zaV9kb21haW5faW5mbzo6ZmxhZ3MgaXMg
dGhlIGF1dGhvcml0aXZlIHNvdXJjZSBvZg0KPiArCQkgKiBpbmZvcm1hdGlvbi4NCj4gKwkJICov
DQo+ICsJCWluZm8gPSBkb21haW4tPmhvc3RfZGF0YTsNCj4gKwkJc3VwcG9ydGVkID0gaW5mby0+
ZmxhZ3M7DQo+ICsJfSBlbHNlIHsNCj4gKwkJLyoNCj4gKwkJICogRm9yIE1TSSBwYXJlbnQgZG9t
YWlucyB0aGUgc3VwcG9ydGVkIGZlYXR1cmUgc2V0DQo+ICsJCSAqIGlzIGF2YWxpYWJsZSBpbiB0
aGUgcGFyZW50IG9wcy4gVGhpcyBtYWtlcyBjaGVja3MNCj4gKwkJICogcG9zc2libGUgYmVmb3Jl
IGFjdHVhbGx5IGluc3RhbnRpYXRpbmcgdGhlDQo+ICsJCSAqIHBlciBkZXZpY2UgZG9tYWluIGJl
Y2F1c2UgdGhlIHBhcmVudCBpcyBuZXZlcg0KPiArCQkgKiBleHBhbmRpbmcgdGhlIFBDSS9NU0kg
ZnVuY3Rpb25hbGl0eS4NCj4gKwkJICovDQo+ICsJCXN1cHBvcnRlZCA9IGRvbWFpbi0+bXNpX3Bh
cmVudF9vcHMtPnN1cHBvcnRlZF9mbGFnczsNCg0KVGhpcyBpcyBnZW5lcmFsIFBDSSBNU0kgbG9n
aWMuIFNvIGFuIG9wZW4gcmVsYXRlZCB0byBteSByZWx5IHRvIHBhdGNoMDIsDQppcyBpdCBjb3Jy
ZWN0IGZvciBQQ0kgY29yZSB0byBhc3N1bWUgdGhhdCB0aGUgcmVhbCBwYXJlbnQgaW1wb3NlcyBh
bGwgdGhlDQpyZXN0cmljdGlvbnMgYW5kIHRoZXJlIGlzIG5vIG5lZWQgdG8gZnVydGhlciBnbyBk
b3duIHRoZSBoaWVyYXJjaHk/DQo=
