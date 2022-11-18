Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C9862EF76
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 09:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241497AbiKRIbO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 03:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241527AbiKRIaa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 03:30:30 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BED109;
        Fri, 18 Nov 2022 00:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668760226; x=1700296226;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BLk/nqowHorNoes+vg50vYJLfdGC4kLekv3mA1rr3uc=;
  b=knofxVcW4q2Xu5TCz6KVNUs1IDXYpyL5OCV3N5facoJJuEXorYv04Erk
   +qIUFu26bOM/O2eqX6Q2UNMsKVPi++jVxpgKtTst4EwI1GFNlUw2iRAVA
   4OulVlD+DRmxOxvpmC2GCB5oYQvgEQc6kCJ05LQAqkyc0BCtJPbaRtyPL
   UjvKuvoSGrEkIQyjGD0fuX5Mu+CSKhOigDs30fsi6CtNRyYf6pvX6Ncqw
   sXduY3ZrPUxRarSx7j6DiIEC8Obo+KD3KTXLau1a+DE4ef8HThFYaFyrO
   +fFMRsBLwvElL8KHrNfKXIKtCgXfGlbyyJcauTvMcg3l8bOCRHckK/x4E
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="339924287"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="339924287"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 00:30:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="885215135"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="885215135"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2022 00:30:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:30:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 00:30:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 00:30:24 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 00:30:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msj2kjNvCRbgYwiz4O3BCQT3RwrrcyKJkABBSLZDNS6CQJMINPCNQ29oITs55VvY+FjEruQ8rxSWPlMm2z5awLSViiZeKAKiW0vIQL0jflbpvJ8xUin195tzhAbkkRvXYF49pW3CvMlIS8bcHzm5nj0WL11Y0ZTZaPPzkHZDZcs5La4jilvkno3ph0cdsyYu5mEzC5KuHoCWeMT0H4N5IyFIq5YwgPdFMvfTUrF0GAzsBVgT/mnJ4s5fxTjk11SK5vvm+m5pE5SAVK057HOPWFbbL7E56TOkwCmzKYNfgnYWxPjNxNNXz1YcZAeR0KfR9YfD78VIP7czO0qaqyxsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLk/nqowHorNoes+vg50vYJLfdGC4kLekv3mA1rr3uc=;
 b=jIcQlhKQrecCMhkAW/5LHk/rDYpL835HJj7C9lydHRkZ1EKAVyHIQLIk0AOhqF29uDgD4AraZrTPTBbELzGcaXFg0DpYN8i0sEzWtc5KUXzs9JtwGiLb0eYKTzmPX7yA6wkIyX4ON23z2kEwxrE0ZIuVK4MgnZV4kxMMkAmNLDbqqHJNl6R/SzXcuczAFxDnh2GBj/4CvVIKqhpIjYo4JpKzFnI6GlBVQ5D8zV0IzqGpdFNtpUgIot4Y1OY3KzEhPOmvI5NgsRziJAgQLaGjwydpmMRL3d8E36t91M6M/4bCdyEc+ToWqqX3SxRUxdqxemeos2sAfYMYTw5+Jk5p+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Fri, 18 Nov
 2022 08:30:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 08:30:21 +0000
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
Subject: RE: [patch 14/20] genirq/msi: Provide new domain id based interfaces
 for freeing interrupts
Thread-Topic: [patch 14/20] genirq/msi: Provide new domain id based interfaces
 for freeing interrupts
Thread-Index: AQHY9dWAoq7JL8HNP0SXCON9W17SUK5EONdQ
Date:   Fri, 18 Nov 2022 08:30:21 +0000
Message-ID: <BN9PR11MB5276D82D1F75B82998A476058C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.837228984@linutronix.de>
In-Reply-To: <20221111132706.837228984@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB6522:EE_
x-ms-office365-filtering-correlation-id: 0ead35c9-1f14-437a-7f2c-08dac93f21f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2nox6nm7F4qHHKO8aJVspSTO2DcDe5I0TjDzLE8TK2IAMcwRibTjqMBMSwFGUTGBkcO9tr0UVzd24/8jILYfcfJM07GnIGCAUSJKkse1wDNzxFefd8quNTR8+OxUKUtodR401hKSd/FmN1doVVxG+5Ez9PnyI2dSWgWwt1eX+CxW8+DBBrIf4fH6nMhhWVhxeRlue6AccgBW3wjopsB4P/4+pGwDYMHeV7meS55k756IFcwPmROpDZDdP3ckt9O4YNkaqQeV13v1fukMBUm3cysiK+pZjYjahSqzdIGVFT0a6kIErV+jb4e7iELPEfrylHOoTcpPpNlE/6EPkvHMupNvhWoQliMNBPqEXWlVfoJ/ub/cbTaBksU3BKKAsjB/DSAbW4djd90Zsr6qC1x7NYtxi684f6loR7Qa/eK+HgIntBlp/fWLMo7udpCP3EwxU3nneoIPOUax02ps2r6skSHmCPrRzghKKe8P1NY7UridVs92E6WhnvargJfmaf1MvTZd7xl+i1G2QZffbUlGem65Pmw4DctkRtbJusIWbkNTji+mu0SfI/Y5gerNF7Ttj6A1yLnvaIC9lM0YXLSC430zi94gR0aNGoLqVc6q3CBiBL8noygvJ7hO3L0JkZEQPWWO38hyuteghYxMQcCYYsY7DZEAqzUxbhRII1mfjbdsi6/AG1RFnwKU6E2ECyyPX6Pzb1A7V0/JZkHrRYuWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199015)(2906002)(83380400001)(122000001)(41300700001)(186003)(478600001)(38100700002)(107886003)(6506007)(76116006)(4744005)(7696005)(9686003)(66556008)(5660300002)(66446008)(8676002)(66946007)(64756008)(7416002)(4326008)(52536014)(66476007)(26005)(8936002)(55016003)(71200400001)(54906003)(82960400001)(38070700005)(86362001)(316002)(110136005)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2R1OVpxVUx2WnNzTkhTTGl6alIrWDc5SDVOZTZ2TGJZN1dTUGV3OENCMkE3?=
 =?utf-8?B?WklxUlJpdGdHSzF3UFhQS2dEWjc1bmJPd1kwVDc0WDVNblBUMjQ4cHI4VTk4?=
 =?utf-8?B?N1FyNWNYdEpERGVJY28rM3F0dTZwVDJCRlM5NmJxQitpMWtyWlBCb1N5UHlq?=
 =?utf-8?B?b2hya1lZQ1YzQUoydGtPTmlsbEdrZjBUaFQ2S3FFQ0JxbnpHd3F6RS9kaWJF?=
 =?utf-8?B?ek9QdlFNdmwyOUhKd21sWVN1eUNOUTdZNWFhQ1hlQWFWS0dkTVoyMkhDSDFu?=
 =?utf-8?B?R0ttelB3OUJxcFFjaEhDUTQ0ekhzOWZqSUV2T3dtRThOVUtXRDh2NlNMbmZW?=
 =?utf-8?B?WXRkUklHSDNyMnQrL045bUtROFFnRHNDeTRuVWFYNEttQXl6L09DRHJ5VnA1?=
 =?utf-8?B?a0NqU0VkZkRJRXRtYzhkK2tDbmxwaTlQdkxuc3hvamVzalUyZlRzSnl0alZO?=
 =?utf-8?B?bTJlWi85TkxuQUV2dVBBb1c4Z3BMVW1GWStNN05sMitNa0ZGRklqK0RsaXNu?=
 =?utf-8?B?VEdWbDFnUUJHYU5INDZmQXFMT3BTVjBxN2RvajRoMzdLN3JPaU9GeVdqajNk?=
 =?utf-8?B?blM4eVV4MFViSk1DZmVHRHlJYlNxb2o3a1dvV2NzYzJmdGxlYnNlUVJwZG0z?=
 =?utf-8?B?YWFQdkthb0wxdHZqSzZ5MXVLa1BEWnN6Rlp0TU9oUU1qNDZlc0YzM052NGgv?=
 =?utf-8?B?WFlmQlozT3JHdlNXNlFZYzI2NDQzdWw2cnRwTDhwOVlYaG9JemdYSE5tQitS?=
 =?utf-8?B?YmVLOGIyajVFNURpVi9NSWFCZ1lZU01XTXU5MEpFbkw5UGhJTmdrekE2N1Bv?=
 =?utf-8?B?Y0l0NjJ4WHkyK1ZZUk9Kb1hpVHgxUzhqS0JpM2IrZGt1YWwvbEhMTHhMbWUz?=
 =?utf-8?B?VGJGRk9WL24wcDhYOFlTT0duNk5RdVliWVE5cHNOSUVQM1lTVzZOMkgyeGw2?=
 =?utf-8?B?dm9icmF4ZkZDdlZIU0FVeGwrRlJSaEI5YU9DUHZFZnJJQitGUkQwVGhiK2FN?=
 =?utf-8?B?Wjd6eWE1UXlsb09TOWJRUzZvWjhBR1Y2cUxFSEtkdXg5Q1dTdzBZdk5XU0J3?=
 =?utf-8?B?cXdQNmV3OVRKUXZMSDZtdnRJV3J6MnJmb0c0VXN1WEJ2N1EvRnlSNGQ3ei9O?=
 =?utf-8?B?blNNeW5QTS9lSmJ2UDZKQStNaHBmTGxHVnozdHFSL2lxSmdhSHBFejdsd1gy?=
 =?utf-8?B?WVo2dWcvcW16K2ltZExONzNKM05CdmhyUEMzUC9xcE1OV3I3eVd2WSt2UTJ2?=
 =?utf-8?B?NW5SNlg2cGkzdlZFUkE4REdTSFRWbUgyWmxzK0s1SGVtdEl6cVZoOWVCVXJz?=
 =?utf-8?B?cnVqOWFLemFVWTZZaHE5eVBzL1lSYVBrU1o3a1BkL2tCRW80ZE04K1hLVytN?=
 =?utf-8?B?TmZMdDlCSFZEM1R6VmQ4cGUzdjRiZXpjeDhxK0lscW1LZFdxSkpjbXo0TC9m?=
 =?utf-8?B?N1dKbHZmYmFQZGNyQ0Zhdk95dnpDc0NGMG56TERzQjBVZi9KU0VLOEo4N0Mv?=
 =?utf-8?B?TnMyQWx1dHhtL2hJeWh3MTVkcVlFa2V5c2JoVVBOamtGeVV0ZlRsK0NydEFG?=
 =?utf-8?B?b2FmYjhXcWRCazVqMEhzMm52bkxrS2xYcjVMakRFWWViRFJ0ZVRwUC9ueGo0?=
 =?utf-8?B?dWJtOEtpVVpLT3c1bVA5NkMzY01tbXRZZWdlcCtKVUJYc3R4VVR3NExOaWQy?=
 =?utf-8?B?MmNONzR6b2swaCtqeXVpZFE5d21zTldkcXBKQWR1NkRNdUY2Y295N0lzcjlt?=
 =?utf-8?B?ZEdieENFUlJMeFJpTnlSU0UyNjZxSlRLTllialp2SUdhK2dDUUZ5dm5ET1ph?=
 =?utf-8?B?SWZyb21na3V1QWJET3VYLzJsaHJhanF6NEFMVlVOL3greHlGTkFZTGNEZWd5?=
 =?utf-8?B?K0dzeGVucUFaOUtyN0dtSUpzdTBkVlFBTFlqYUYzdjJ2TDNDTXNwTEZJV1U2?=
 =?utf-8?B?Q2xKM0NQbGllWUNDdi9KbGZ6YzQxUWkrR1VTQ0tRWHYvODI4UlpnWm5oVzNk?=
 =?utf-8?B?Vy80Q3JiMjZiWjd4S293aDRQRnJlMTVNcWR3NWIxSUo5NEtjck1jYkxoWEV0?=
 =?utf-8?B?UWZPanZFSjc3S1hGTEJ3VnFTUUZ1SkRUR0R2TWdjTGVBeWY3WUtRMWtIVldB?=
 =?utf-8?Q?k/gqykYHrviRQehSwvADFGSKC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ead35c9-1f14-437a-7f2c-08dac93f21f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 08:30:21.5853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwfrWDDObocpSPfjLWqJsJ/aXw3onjHhCKm3/TpipezPldN4+MxE2wJnuWcHKIZKXf13+E4UgW6cYQuTl8t14w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
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

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogRnJp
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+ICsvKioNCj4gKyAqIG1zaV9kb21haW5f
ZnJlZV9pcnFzX2FsbF9sb2NrZWQgLSBGcmVlIGFsbCBpbnRlcnJ1cHRzIGZyb20gYSBNU0kNCj4g
aW50ZXJydXB0DQoNCmZyb20gYSBNU0kgaW50ZXJydXB0ICJkb21haW4iDQoNCj4gKw0KPiArLyoq
DQo+ICsgKiBtc2lfZG9tYWluX2ZyZWVfaXJxc19hbGwgLSBGcmVlIGFsbCBpbnRlcnJ1cHRzIGZy
b20gYSBNU0kgaW50ZXJydXB0DQo+ICsgKgkJCSAgICAgIGFzc29jaWF0ZWQgdG8gYSBkZXZpY2UN
Cg0KZGl0dG8NCg0KPiAtCW9wcy0+ZG9tYWluX2ZyZWVfaXJxcyhkb21haW4sIGRldik7DQo+IC0J
aWYgKG9wcy0+bXNpX3Bvc3RfZnJlZSkNCj4gLQkJb3BzLT5tc2lfcG9zdF9mcmVlKGRvbWFpbiwg
ZGV2KTsNCj4gLQltc2lfZG9tYWluX2ZyZWVfbXNpX2Rlc2NzKGluZm8sIGRldik7DQo+ICsJbXNp
X2RvbWFpbl9mcmVlX2lycXNfcmFuZ2VfbG9ja2VkKGRldiwgTVNJX0RFRkFVTFRfRE9NQUlOLCAw
LA0KPiBNU0lfTUFYX0lOREVYKTsNCg0KbXNpX2RvbWFpbl9mcmVlX2lycXNfYWxsX2xvY2tlZChk
ZXYsIE1TSV9ERUZBVUxUX0RPTUFJTik7DQo=
