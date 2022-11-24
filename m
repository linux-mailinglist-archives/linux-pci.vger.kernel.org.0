Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2927D6370D1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiKXDL5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 22:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXDL4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 22:11:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD34B9B8;
        Wed, 23 Nov 2022 19:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669259516; x=1700795516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YV8Dxf1foCI+nOc4WftgAmUqcHDt+Uh7ht9+wE2SDqE=;
  b=esMaIRNl5lY/C4G9i+PzsSA1igCqNh+LLxAug2XldQUv1FWgrFtdEsEk
   kwTCglqFlff9XPZQUgGOXJMRgkhibJnj7CCO2hOvvJOMJMmWb6+JyD0Iu
   Oz3xjN74tzDtUCMQFhn7ghvCY4c4/5x6qIM2fifiFbFiynRwqrDxDETu1
   7hj1X4DK0cMH8Dl3+mbav7o1EFJLULk3QnK4LNFKl5D6LiJHsw2IRIpHe
   PEWPiaoM2/RVUPn+rGWGu/ndBpooT7TVmw4XGz2k+V9o6A4TzemekvF8B
   /jdEWJT4xV6BliVYjzHTcJiSDeaQecr8lKLFeULEfuJvI0XWwHCVlLk+d
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="312905197"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="312905197"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644330652"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="644330652"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 19:11:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:11:53 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:11:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 19:11:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 19:11:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPtWHJiCSvtvCx77TvW7ZHl6N8FmZr5gsEFBbclckhBi3v/kAzVqsjDUa20uwxrvcICRR08GWYE6FtxaJwVaZwSiV4DAXNF3ow/G5RAOZhKM0JgJrA03Rgyao8exoCAl3Mvg7Ql8BgoZcDsD5q2YCyQI7/DCmIvuMiyyPd7TBHbk8yN7JtwJhZGQfWPbE3beLg0hSvs0Xjqm+soLiOluXZMM7qLAuhzVZm40Kb3AZSuGo0NiD68aYsoSuPegcos+B2DfPq6ySKe6eCqigr3BudMTFYTBZhY547aNonSGw3eP1yIAPBtv29U8dxQ6lor3tnfxL73hCGX0pg3dnTn3LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV8Dxf1foCI+nOc4WftgAmUqcHDt+Uh7ht9+wE2SDqE=;
 b=l9XUU++jIxl+cBmn1zod4UBjaWK8Gt0/AT7BqaLFGCYCCKB8zrU3CRj4j24l1whCh4E9ExJcXoWatFEg3WTKUFV0VJ+1jsTDJadiVxb1fz5ZwKnYAIw8/lm+LZz9nuSwIZ/NGnTngfnT4PduuvUWvUJiSoi3kNbTlrw3EvH6mLU0W3AFkJp/0RiJPWHvTNsZqG5yKQO3qqNePF/CihxjR7W+FRvLT3EQKikh4SEfowsA3ZDkFySUm6H4KGkc5483eHM/seudWvkHnHXBz9SvgIgs0HEfu866KUawj9GciF8aSAIbF8nDU+gbqBr4IAOvbsRgtdbTPXyjg/DtEHbCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 03:11:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 03:11:49 +0000
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
Subject: RE: [patch V2 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
Thread-Topic: [patch V2 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
Thread-Index: AQHY/bbvRyZDA6upqEO/1aLBObewCa5NWbww
Date:   Thu, 24 Nov 2022 03:11:49 +0000
Message-ID: <BN9PR11MB527665EA1BE0427B33E2CC1F8C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.078449899@linutronix.de>
In-Reply-To: <20221121091328.078449899@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: f31c864e-6fa4-4a1f-c657-08dacdc9a087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k7OG0vf2TOQ4j9NRYmp0bn/fD3ARfEL3HKe6MHPKaTMfEQ0lyBK12KDGZaqPxHnIbtNQ7CsOAoqvnjkWS3rUVL7kYDXO/IuEZbqm0FksjphiqQTDBNHkwKlVuqW4pFN4DuS6jgBT/4Kka2i/hcgSvw1DWooJj61QxPaNKymRpCMbvF/7rzImM4Qx2AN8YOMivhVURG+UZAReiFo/6Y3yWZJgjSaVtbRNYuw8n/qkTfwv5NuDog5zYx0qN+zD9JnZoCOPDzThnwGc1Srg+Es5lpO/nQhxGGrYSix3IMVcwjdh3Itk9XTXHcgbqMX+1pJK/b37ieMFE0fy8mAEVlNaWGqQ0POuJeu1HZWJok+93re/yRo+21CtrbISIMA02HhJCppbxlCxay3VMF4BRtwhBI7HM2WBZAw+5WsD6yRiDZS/beR3DVnZ9RIroxs5v317ntuD4AIq97hkjf6lcEDJwGAV6B1mPlq9HtDVkgvWxOmyHuPkQ44JKI6eXhgqEFXOhwXJHLxS3IG3duvezxwbC/BcpM3LSweUDsla/4FUanzh770mnPurVBk/hnQjghpL1Zo++5QxuIKEcWiboJhCWF6GyzcJf7s583hXZp/Ju7RLBqXD7+rrkGBs2DTrux5J3YyePrqiVVxuBstckYHysKT9w7UqZ/ijdKYYin/VrAunj3ll+cpkVHACv/ouaF4iMf8Ljcqrp0i6KRVwKt8c2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(76116006)(38100700002)(26005)(122000001)(4326008)(64756008)(8676002)(66946007)(41300700001)(66476007)(66556008)(66446008)(82960400001)(2906002)(86362001)(54906003)(83380400001)(55016003)(52536014)(33656002)(7416002)(9686003)(8936002)(5660300002)(4744005)(186003)(316002)(478600001)(38070700005)(71200400001)(110136005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2FTbUVKM1QwWVN5QjBuVmg5aG55MW90TUloZHRFaGF0a3BrQmltcGo2UDUz?=
 =?utf-8?B?MmlYWDRkekZNcDd4d1lTNGlYTS9xMW1ET3BxUGdMZG8yamhMcXRhV3MwUlA1?=
 =?utf-8?B?VU42S3hXWnpEY3JvV2g5TjBqcjZ2WDU4MTZFb3B4YWZjc2NPbSszTSt4VG5T?=
 =?utf-8?B?WG9wQUlVT0RBcEJya2lFUmdHMnVPa01QZkd3Sjl6bE9kVFlXOG5jV2o2Tk03?=
 =?utf-8?B?OGZKL3k1K2hZVjkyV3pJOElPZ2QrZmd2RS95R2RxOXFaUEhWa2w5QjlKaWl1?=
 =?utf-8?B?RzNOSE40TE5vVGsrM3RrZUttVm45WEtVcFk1RkJyMVh5aTVQWGlLelRXS25G?=
 =?utf-8?B?M0dRUUNkY3hML0Fac21EbGZsdE1LZUhxSmtyYXdwbklYM0lFdVlPaXJUKzhx?=
 =?utf-8?B?aE5nR0Zoa2ZqZFZ4U292SFUvQlVDNVVXVVBSWEk0SWFYZExaS2tWY2xjeHVF?=
 =?utf-8?B?dXNNYlpkQUpyV0JjSUFhNERiRG5lQXZzSU9jelFOUWF3eHJBTnBleXlwU1Rs?=
 =?utf-8?B?dHM2amZxYWFxSUdYZklOVmZ6WjRvQVVzaTNmSytWdXBiNEtrL0x0QWpuKzNm?=
 =?utf-8?B?Q2VrZ0FoMFRTU3h2bi81QlFQNFhzYU5iSnJvMjZnRWF6RE05QytnRUZNYlAz?=
 =?utf-8?B?TjlzR0FPV3FMMG50eWZtVTNFTmlWVlFXVjRnMXBsQTYwc0phbkRkN0Q1QWlT?=
 =?utf-8?B?RCt2V0ZSa284RmN0TzZBOVZuVEhKTkFRbW9DSk1XdlQvM3YzQlFLK2xOaitB?=
 =?utf-8?B?cG50NnN2TVlzS2lkL3d3cGhmdFZ3TGJ5cmJ3TkRsRklENWN1QkZ3cUdENjZn?=
 =?utf-8?B?V1dSWFpRZStBcVZhc1lwT0kwYnB0Y0JSRzIxd1p1dHBBWkZRbEpTK3JIbEtt?=
 =?utf-8?B?SS9YSWZ6aWNYbm9FUXhCSlZQVXBOSFpJSm1BdjIzMGl1NU1vZVBldGZXSUdr?=
 =?utf-8?B?QW8zd2pyUllUeFd3T3VCVlgzZFhWaktiMUl4MXVhbmxtcUxJelJVc2pUZyt3?=
 =?utf-8?B?VnFoWUp5ZzdiRlY2WWNUWElDREt2OUM3K0IwckZ6WHk0MU9ZelJvb2w2VEMx?=
 =?utf-8?B?Lytkbno5dkhRN0liQnFHUWFkOUNycnZ4TFlkOURvS1hpMEYwWHVJODRIeGVr?=
 =?utf-8?B?MmppRGt1MmY1cnRxcG5JVzkwaGJPZkJUQ1BRQmQxdStqUkh5R1dUdi9OVGJo?=
 =?utf-8?B?OVNYaWliMHR6SkU5WVpoc29GVitPamtyRktaU3k1NVZsNmVBNkhKN2hBeWJL?=
 =?utf-8?B?cXJzWmcvMkVNNkNlUmUzdlZQQ0xhT09oUWc2WFZxVkM3MnB1UURvYlpwMWNV?=
 =?utf-8?B?TmVuZFpTWmNudXd5aHJXOGg5Y2hzK1kxQ2FOaHdaWWYwcHdTSllZemk0WnIx?=
 =?utf-8?B?czl1WmxJQnRHZndSeXhxMmVyTXlYajZwOXEwcXlQdHpwbWRteUJNL2ljdEND?=
 =?utf-8?B?NFo3b3NSU3R1N0orVG4rNEFocFYrYU9qdGxWN2wvS2NLSmtlRHBvZzZPVTBK?=
 =?utf-8?B?b1kxMmFSMXpTUmU4L3A4R2xRRVFFVWRDR3ArL1JWcWFmMG9leWtzRzhXVTZ6?=
 =?utf-8?B?a1F3cUxGOTdmQXRTQVhiTFQyK04xRWFybjVaRC8rRER6WGpKbEJlczRMb2Fp?=
 =?utf-8?B?a3JBR3lHZEMyZFh4RHdMdzFtUEtVelYrK0NjdG1aV2tTekJ3U3BPQy9nQUdv?=
 =?utf-8?B?L0dYT0YxUk5DNkRZSVFSVitldURqQ2xGcnV1d0dGM0VYcmVPOUJNOEZwN3Rs?=
 =?utf-8?B?dTNEUUc2RFB3elpmaVhiK0Z2Zms5d3B5RmxSM1BBWUg0b2JvYjI1b2RIbXZX?=
 =?utf-8?B?TUNocW9vS25hMkhvUkZBenlIQ1pMS0hOaytxcUU2bUNSNm9ZSFVzcEFRay84?=
 =?utf-8?B?RE5zbkhDTlpDYXJ3Wk9ROHNqTlc5NTF0b0trY3B6Sk54QVlFQ1JFblRrMEpJ?=
 =?utf-8?B?ZDdFTzhLS2prV0tYVElvV253akhJMlNuTmtoRTRCRjM2dUI4LzVMVWRHdmx1?=
 =?utf-8?B?amhua29FL0NmbkNmeUlFZDVnSXI4V09ma0tMZnZlUC9sWnlkVHR2RmlNY0Vh?=
 =?utf-8?B?RkQ2eE1mbjhxL2hCK3U5RmdsUUNuVEw0VXkrTnV1Q2ZhaEJPT01YUzJKZmxX?=
 =?utf-8?Q?Kt6G5u4whfbVoJ9/KsUiZo46D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c864e-6fa4-4a1f-c657-08dacdc9a087
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 03:11:49.1406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nhqj/bqNL3aZMp6eaLwnbanOvK2aRBg9wbAReiA0nukU0rRg2wiBC51o9U4+6C+nCh5iNhORjNbRimJvbxh7fQ==
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gKyAqIFRoZXJlIGlzIG5vIGlu
ZGV4IGZvciBJTVMgYWxsb2NhdGlvbnMgYXMgSU1TIGlzIGFuIGltcGxlbWVudGF0aW9uDQo+ICsg
KiBzcGVjaWZpYyBzdG9yYWdlIGFuZCBkb2VzIG5vdCBoYXZlIGFueSBkaXJlY3QgYXNzb2NpYXRp
b25zIGJldHdlZW4NCj4gKyAqIGluZGV4LCB3aGljaCBtaWdodCBiZSBhIHB1cmUgc29mdHdhcmUg
Y29uc3RydWN0LCBhbmQgZGV2aWNlDQo+ICsgKiBmdW5jdGlvbmFsaXR5LiBUaGlzIGFzc29jaWF0
aW9uIGlzIGVzdGFibGlzaGVkIGJ5IHRoZSBkcml2ZXIgZWl0aGVyIHZpYQ0KPiArICogdGhlIGlu
ZGV4IC0gaWYgdGhlcmUgaXMgYSBoYXJkd2FyZSB0YWJsZSAtIG9yIGluIGNhc2Ugb2YgcHVyZWx5
IHNvZnR3YXJlDQo+ICsgKiBtYW5hZ2VkIElNUyBpbXBsZW1lbnRhdGlvbiB0aGUgYXNzb2NpYXRp
b24gaGFwcGVucyB2aWEgdGhlDQo+ICsgKiBpcnFfd3JpdGVfbXNpX21zZygpIGNhbGxiYWNrIG9m
IHRoZSBpbXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBpbnRlcnJ1cHQNCj4gKyAqIGNoaXAsIHdoaWNo
IHV0aWxpemVzIHRoZSBwcm92aWRlZCBAY29va2llIHRvIHN0b3JlIHRoZSBNU0kgbWVzc2FnZSBp
bg0KDQpAaWNvb2tpZQ0KDQo=
