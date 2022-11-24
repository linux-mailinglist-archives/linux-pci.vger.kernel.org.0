Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11666370E1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 04:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiKXDRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 22:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXDRH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 22:17:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301277202;
        Wed, 23 Nov 2022 19:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669259826; x=1700795826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YzgfaqRWc4YOOUVYvfWRZYaN+jZu3l0MA0CqKRte53k=;
  b=eSts419JCS+IF6jLdjQEfgiAreYXrnCSnq5n6d2ZlrMlcRYJ/CkcpGhH
   9LXgns47ubc5m6mkvLepmtAZRjqXBp8wATjfkkxp601xx0bgT4aokcoXh
   m34veS834LBEISNz/1SgJIxIB+Bv5E25c7nBtMWefw6h16QgTSlAMU4Oo
   wbEiXiQyZfbf9OZPGSgTlsUT9+MzRkinjX8vRTy2n2cQhMJt57i3eaCaH
   pIO2ZK7dxx2SzwYknNUeRtu6++slYk+Jh60Gb07HjATLOh2JZ7nqxKyrw
   J2Tvi3EplraBsSiqcNnez1V1Jq0m+BYBrpmJyGgHlx2izFXQ/+mfyRdRv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="316026220"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="316026220"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="705591279"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="705591279"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2022 19:17:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:17:05 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:17:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 19:17:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 19:17:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVM3foc1NAojbygYxQ0jMSVxhtX8kOM9MiYSimlvAhmXpjpsUiGtA6J7zHHWAW75dJlRQjwcEk83ulubgEI3PWS97hZ1v1kVwu3tBlDNNF4ZwFIUZ/L8ijZt8LWyHlO4czkjZfEn1MR9n14ELDcjS7rhRD+GL4DK2dRdq/RLsAkedcaBjw7JIYDnpTiPKKLEVtxcwP4N9wjQFKAvhSK92pmwgJz3xBCb5vSPbuxjXIVmzVQqHCtSXxmblY3OY3SxXa/tfbePKYAquYbapIrggupYXnxCQ1zhc4g/8aoiVUs30AkCrOH2J+0jWC1jTgx67pRzjCZXl8YYfMuGLiqohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzgfaqRWc4YOOUVYvfWRZYaN+jZu3l0MA0CqKRte53k=;
 b=kjRCDZbxoMCkNG+BvErAcJ27XV8HDA6a03o34n4KpuFL6JRQgCi8wXJVOnU0TmUvupfpE92cG4oAfWm0CAHVEhoaUzOco6yIqK/SdFy212GS4JtWm1L4Vk8y3FBS1Var5mMz6c3+/Ho6Bdut1wScQRRQqLXRsUYyzw0tvHMmq4oO3u2VqDkK6CkhfGAaYbYm6moLdFba7pNjggF+/ufZ1yLQkd3sQLCE4kn/suf2Fq7MpLT5LuZJVhqWAdVdOvTWEtJU7ulqPR4kHciw6yANx0Er2P+2cXrGjBgS0vQs+Rn8erRQMpeopQpj4jsBPTcyGtaCCHOyUHzpVUHIliYWVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 03:17:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 03:17:02 +0000
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
Subject: RE: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
Thread-Topic: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
Thread-Index: AQHY/bbwPG3EDS6e702OjDPxfqJk365NXjKQ
Date:   Thu, 24 Nov 2022 03:17:02 +0000
Message-ID: <BN9PR11MB527650A018BE7BF422BDA2F58C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.184455059@linutronix.de>
In-Reply-To: <20221121091328.184455059@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: 07eec75e-c7a2-4d23-ce78-08dacdca5b40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ao1PzvzFNekoQu0whNAj4i72EKb+1w8MzOnaX4JuyIDizgmDBv9MP55S2+UHsNW2dJElxyXeSBGKNO+l8ObTZ//zJZHBJCti4M5GBjIB0uZ7wHjkylSOwokR0LCvlmApEj5XptzD1fM5fp9KD240Cbd9Gbb/C61KLeLaJ8FMxUwDdSJ1a6bL717PTSmwEJQrWEk0c2ZB6BeHRgtdisbUv6TvRRar9qzFI+vm+ndH0BcKC+2E6SKYQKmamMST2zHV3M6EJ0OUHHWbwkVujBzg2FEHQh8xnwWNEmudWlzSrtK2sEg+Kt+3N+LXJVFf7H3PdI6DfMBMGU5riF4uCeJG/ilOJGW0RP5hlz0NeSf1j+MaT9+sAYYg+q6esNZV8PR/5d1kAmdRcFXv5pSDrL66V4LvzxCWVqbzLJJBVdsER+afry2uohHOk7eFE9BNELX0Frz58HjPnOYe1fZxJ1oqY/rvbgwRnmnCFp2dn9xp0BFuaJsuhRMyJz554rS21dovODrSjyl77TlYXHynTryXzW6r9HOZ70i5vxeViwZkskFXHk/QA26sX0EKUIYpucbBLg8yK3gk3yKDT79yPro42bnbzFiINuemIGWetCqfs+BprKaerhtSUAp9o6zs50eBGX+jE3vaU4yYQPOyTPRkNTiTRnac5ih2OvgaNY2de/FkwNfNo1yYlgB56PS0rkGVXeZ6mOiqadbZUoAUiugH2EMbDVHB4PGcAcqOdYyjdqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(76116006)(38100700002)(26005)(122000001)(4326008)(64756008)(8676002)(66946007)(41300700001)(66476007)(66556008)(66446008)(82960400001)(2906002)(86362001)(54906003)(83380400001)(55016003)(52536014)(33656002)(7416002)(9686003)(8936002)(5660300002)(186003)(316002)(478600001)(38070700005)(71200400001)(966005)(110136005)(6506007)(45080400002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTk3SUtGdDlQaVVoVlYyaEFDZk1PR29zVkliUzljMUY5WlQ0OTRUS29hN0lT?=
 =?utf-8?B?QnZMZ054bEZwMTNQYnFnZ0Z3cENVWnk5c2tVeGZvRThqK2FyMmpmRk85RU5Y?=
 =?utf-8?B?SitIWUt0MnNlWW1mYnBwdGhDdzRTWkZvazVIazU0enBoUXJaV0c2RlFNZVda?=
 =?utf-8?B?czA5alNZNlRmT01WMGEzd3NycmFLYUU0MFRCaG9sa0Z4TDdURTFGT1BrckVa?=
 =?utf-8?B?ODZqdFlwQktkMUR3YW5GZFdqemdYd3FLNDJMVXp3UzZXQmgxb1RLMHJyWXFM?=
 =?utf-8?B?RHcxVFBpRGNXOEZ4Z2ZLWnh1RmNUbzZhQ054d0NwanhhMmoxL1JBL01wOHZW?=
 =?utf-8?B?WlFTWENVaTN6WGg1WUVucWVuSXZuVkZVUnAwS21jL0NoN0hTWDkwTkF3TW51?=
 =?utf-8?B?UVUxTno2ZmlpY1NRTS9OOFpNWHUxYlliNU11YTBCaWxZRkJ3YnVXTVFaVG5I?=
 =?utf-8?B?UDBtcEM4YkQxQTcyZVExRlBBc1JkN2NXbE93YS9weWlITnZFRFgxQ3grTXQ5?=
 =?utf-8?B?ZTJENXRTejNpTzBpUlBHSVk5dTNJdzJyU21mSU5xNUVJcDJOcXo5RnFTd2ti?=
 =?utf-8?B?cVhNQzQybUZkZFBWRW4zUnd6cUhxWGgva05TUE1ta2VRdUlHQ1QyRXpNSE5O?=
 =?utf-8?B?U0p3WkFPN0dSbm5qNTRmQXZpYUF3VnJwMGl2KzBJMFZwQ3hnMG1vdzZ0UDR1?=
 =?utf-8?B?NmxtcFhtQjA3STgrTmhDMkVBYnMzWk1td3NIQkZpTVRZS1FKelR6N3orSElq?=
 =?utf-8?B?Ry9nR3NLOEsvYURRV1BadXFYTUhlMHJTaUVkMGN0MTlZNWczMkYrZ28xV1RM?=
 =?utf-8?B?bUhMVFNEdm1jUW01aG9vRnFmSFNsK1lnTHFUVmRsUm56S1NjRFZuc1N1a0hO?=
 =?utf-8?B?R2lxcVVSdjdmRHpHOHh5SGxSL05FczFtZWJJNHVoT2N1WWxNcWVyTCtOQWNW?=
 =?utf-8?B?TW1ZMXc0cVU2MWtFaFJGYW9YcEd5dFVjeEN5K3VPWVFmSG5oczZBQXRlaE5x?=
 =?utf-8?B?Q0swcWUzSXQ2NW5VNHZwc205ZURTNW0wRUpWaXBja0ZRNEd0MjNFTHBTdDNO?=
 =?utf-8?B?Sm9CWVBTc3U4b3BsbFF2dVo3VnYxTEdqN1lKNmsxQ1Z4NFJaZHQwT1hkekIw?=
 =?utf-8?B?eHVmUkdRTEVZQ3g0UC9lWDZqaUZhZTJVMWNLR0FqcUw3dE1wWkR6SFQ1dVZE?=
 =?utf-8?B?ck9oOUlYK01kaHpjMHJqY21PeTNpdkNuZ0VOSmdGN1k4enBrTFJWUlFJbmZ0?=
 =?utf-8?B?SEl4aGNHa0VBYjA3SDN4TUlkVnBOWDRVZnhrSjJKWmZzd0tHNEZPL2lPT2M0?=
 =?utf-8?B?TjJ1ZmpNYjJSbzhNOUpVNnRaQmZZK0JIYkVLSENlUVBrMlVvZGJFN1BYT203?=
 =?utf-8?B?Q1NnU2lEQ1dBb1EveC9lTUp3SzdvM2NrZnZ5eEVHNWtoRlA4d1hlUHdMdmJT?=
 =?utf-8?B?Zk00bmhnZWp5WU1sb2tQY3BGTjlWTE1BVU9ONXVucWplQVQ1RnR2U3JYc3RW?=
 =?utf-8?B?MXlDQWxycU1nN2FnY01ERytsZUZBZ3BmZzQwa1QvUE81eVd0RVcwbHVpOE56?=
 =?utf-8?B?YXI3Z3RWZDhOaTlBUm1vRnE4S29QZWZ5dERScjV5TVgxeWt3bVhLNXhWeTQ1?=
 =?utf-8?B?emlKVXJzTXhNdVNSNlNtK0FpWXJBeERSWklxMTEwUzhlbzJ6MCtOTXFTcDJU?=
 =?utf-8?B?SDVPQVErKzIzY3hUc25lSTZLSTN6UEV5dks2V0ora0h0eWREZWhjUDlDOWdq?=
 =?utf-8?B?MWorU0JsdjBRcFJ6WUpQQ0o1MlBLTGRqV0dPZW1EaDhqZjN6WHdNOVdDZzJy?=
 =?utf-8?B?RmpxYVU1dGlZWE0vSVdud3B6b2hZOThvSjFyZ1NwRk1OQm9iakREdHVRd1hK?=
 =?utf-8?B?ZXQxSjBvc3Y1VUZHNjlSVjVMR1pJMEZFVnh4YS9VeW50WWpGWEcyZERvQ0xo?=
 =?utf-8?B?Y1N2Q2I4K2d6TnlDS3lrYzZEQVNNU0hLQW45R09kbXpqSkk2OFAzWVFXdFJt?=
 =?utf-8?B?NWlyVnlzUjRndU1TVWZTMWRYcXE4S0o5THpLamsydjhWYi8zZElrSHpzemZk?=
 =?utf-8?B?M1I2RGR6QjF0Z1JaTzhoZjlIWjJacHdncjZWRnlWbkhXUW9wMEtoTUJwK3RL?=
 =?utf-8?Q?2ZS0CFp4MmqwGvHxhwTtrYsH4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07eec75e-c7a2-4d23-ce78-08dacdca5b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 03:17:02.3783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whct2fTTOt6kYAXVfiA3wZ7gtN5/ZvryJwy3TCJ0W8gZQl98Gp25OXfB9lrmpgR/wBjmuVvh4459LQgobDCHxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gUENJL0lNUyB3b3JrcyBsaWtl
IFBDSS9NU0ktWCBpbiB0aGUgcmVtYXBwaW5nLiBKdXN0IGFkZCB0aGUgZmVhdHVyZSBmbGFnLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
DQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9pbnRlbC9pcnFfcmVtYXBwaW5nLmMgfCAgICA0ICsr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jDQo+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaXJxX3JlbWFwcGluZy5jDQo+IEBAIC0xNDI5LDcgKzE0MjksOSBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IGlycV9kb21haW5fb3BzIGludGVsDQo+ICB9Ow0KPiANCj4g
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXNpX3BhcmVudF9vcHMgZG1hcl9tc2lfcGFyZW50X29wcyA9
IHsNCj4gLQkuc3VwcG9ydGVkX2ZsYWdzCT0gWDg2X1ZFQ1RPUl9NU0lfRkxBR1NfU1VQUE9SVEVE
IHwNCj4gTVNJX0ZMQUdfTVVMVElfUENJX01TSSwNCj4gKwkuc3VwcG9ydGVkX2ZsYWdzCT0gWDg2
X1ZFQ1RPUl9NU0lfRkxBR1NfU1VQUE9SVEVEIHwNCj4gKwkJCQkgIE1TSV9GTEFHX01VTFRJX1BD
SV9NU0kgfA0KPiArCQkJCSAgTVNJX0ZMQUdfUENJX0lNUywNCj4gIAkucHJlZml4CQkJPSAiSVIt
IiwNCj4gIAkuaW5pdF9kZXZfbXNpX2luZm8JPSBtc2lfcGFyZW50X2luaXRfZGV2X21zaV9pbmZv
LA0KPiAgfTsNCg0KdklSIGlzIGFscmVhZHkgYXZhaWxhYmxlIG9uIHZJT01NVSB0b2RheSBbMV0u
DQoNCkZvcnR1bmF0ZWx5IGJvdGggaW50ZWwvYW1kIElPTU1VIGhhcyBhIHdheSB0byBkZXRlY3Qg
d2hldGhlciBpdCdzIGEgdklPTU1VLg0KDQpGb3IgaW50ZWwgaXQncyBjYXBfY2FjaGluZ19tb2Rl
KCkuDQoNCkZvciBBTUQgaXQncyBhbWRfaW9tbXVfbnBfY2FjaGUuDQoNClRoZW4gTVNJX0ZMQUdf
UENJX0lNUyBzaG91bGQgYmUgc2V0IG9ubHkgb24gcGh5c2ljYWwgSU9NTVUuDQoNCkluIHRoZSBm
dXR1cmUgb25jZSB3ZSBoYXZlIGh5cGVyY2FsbCB0aGVuIGl0IGNhbiBiZSBzZXQgb24gdklPTU1V
IHRvby4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9CTDFQUjExTUI1MjcxMzI2
RDM5REFCNjkyRjA3NTg3NzY4QzczOUBCTDFQUjExTUI1MjcxLm5hbXByZDExLnByb2Qub3V0bG9v
ay5jb20vDQoNCg0K
