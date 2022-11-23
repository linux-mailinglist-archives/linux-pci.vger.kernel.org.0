Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F96351CD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 09:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiKWIC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 03:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiKWICz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 03:02:55 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9CC12D28;
        Wed, 23 Nov 2022 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669190573; x=1700726573;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gBdTeiKL3PEzzdku2WGtzKesQT4ZHOB3bPVgx12Dsro=;
  b=hPsIkLucEO69WcTPuq0CWRsxa1KHQAAgsXZP+ANyTnm1LinrEN72nyt6
   PrHIx1VS0EdJ0bmOJUKVKFrNWQiYbl8c54ZK7vbZIoqdSgn6QC68FuBLB
   fR6oH68RYDbqtTtOeEv2yAkvhug26fSf/KenrjVXKKT2TH9O5XCYRgNBR
   ALLFvqT59B3Sx9NddHG9VkJKLB9tLiG2CmcbATRAIk4cztbL6puoc7CLi
   trcUEbZWBJQ0mGCw6YmOe661XyakYxKzGarextbAW+vV+/7PVtwvicaY9
   vXMf/NOWWMg7V7MloYf+9ELLBh1CP7I3Y3tgbF0EcwjtrySUax9ceff37
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293716966"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="293716966"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747683755"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="747683755"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Nov 2022 00:02:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 23 Nov 2022 00:02:49 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 00:02:49 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 00:02:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaBhavJtNaZQYGMdClrTyrD7fHTQJ7iWiI46Oau7wo1HdiQxGs1P3mKagQOE9R9A8HE+YpkesBTGtIeIaBFNApIyyXgVXreEQRO8P2ZCX46IkvTiOcsl0upOSszlB7LFsZDMNfpenbNdH5DfrgqQ6G4lGkNJHpZB77/EHdCuHDqN0Yb+Jp21yxmhFqQrAtAW0aRHV4Ab48J5gGL1WCjgddikdnpXTI4csNXiNj1W5klR0JGqyzVRaex4+T8eBfj8Dq9immBj5+vxZH8oqMSAWaNK1gOfUeMcG6D3un6kt+II881dDm54V1kh5Nd4/AF+3/rKJ1bQioDFC7S0EUsCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBdTeiKL3PEzzdku2WGtzKesQT4ZHOB3bPVgx12Dsro=;
 b=U+XlhKcwpgM42bfiKYjcCZG9FoEoZQlosWGME3Kah3SSsvcNrK7v1mxr7pUOiyi2ROJXB2v6/jpiw6H0BB2RRLWijzjKVYovkyLQ6i0YXMui+3JzA9h0jT4SOjNRYptwL94HoF2XmdCeBeQOMHIx2E6TKGyFN9RPfGkBWFMx/6Cw4UQ/TgmxEegNzEHK+Bb+53kZ9GLwjBPBcFsbJiLXNxTqD95xrRcMaF3LAy4QRqR0fCpQTf3B8zFlTQYRaMX+YggcTLx8hQsibY52flUxGNMCV8nZy4U7LskF+9I+0GUpzi7/gwQVdsfHn3wZb0D36ozmIdGr7VNJH3UDgcpybQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 08:02:47 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:02:46 +0000
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
Subject: RE: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
Thread-Topic: [patch V2 07/33] genirq/msi: Provide
 msi_create/free_device_irq_domain()
Thread-Index: AQHY/bblStmeh1OioEClNZ/eww2WyK5MCblg
Date:   Wed, 23 Nov 2022 08:02:46 +0000
Message-ID: <BN9PR11MB527604DE2A881FF615B7D0748C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091326.879869866@linutronix.de>
In-Reply-To: <20221121091326.879869866@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL1PR11MB6004:EE_
x-ms-office365-filtering-correlation-id: d696c838-9b0b-4a61-4daf-08dacd291b7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukBpVxPdxPos8f7naT4KUJbEUSAn8Zl/VoAzBDAV6fnBprZUmI/hPGnx/W7x1KOKq+if0FAe1h8fRevKjgaRMj0RsQm7pApyZkCRFEj70Bw3yjFmPp/3gGNbJ30Qv7yvmaR1Kead1l0QBKVkLlo4FgqE1Jagbf9Z4DCo065J7Rrfo5P4EXh3vkvto75EL9ka2ukK+jPjU0ppNcOuRB+3oTw0ea1Fw4UJcB5L7PVZq8xgXSj/rNwkMhq7/XsFFyRMWyGQsjhhs+3wWIYZiDngpDoD+XX7QnvkjP7vYvE5oM3jSjrLe+n0zqhMGDAqgIcS3NL3yla93vUIrg6uABb7lvi+JgkFzX3MUeKt6RRJYzNzLCT1C08IRmgJEmBziKMoBnRCJMU84gAZ9yjil/Ahn91lAY1ucAlm4CHcO3LqVlxF/XVeXTYvQ+sruLMHpANVoqj/G7wsqLa/HXCQJP8bU4x6Y0XVvvTQK4amihsfW2dZUDk+xeW6w600KAwysbh4is1MMCpXiVyjzCKiRxH6MiO8PoY4nyssNLlKTFd7HBCsD57+kQWe3bLVvZ/gPYTnfzfl+YkjYf9NxhNSxKEQbgLxS1Hu2BlkDDqmJHfEAKHNhUenTHDzPUPd+7X1lB6EeK4jbkplLuoFPSpcYcQ6UdEspVDPtLno5ErQ4eNfL9uKYfF3QqnpzO3Hiqqlt0tKKYMfuT/+JO+MYJ/SgSM/XA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(9686003)(66446008)(64756008)(8676002)(8936002)(6506007)(66946007)(26005)(66476007)(7696005)(4326008)(76116006)(66556008)(33656002)(478600001)(5660300002)(316002)(38100700002)(82960400001)(86362001)(71200400001)(110136005)(54906003)(83380400001)(7416002)(41300700001)(122000001)(52536014)(55016003)(186003)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3RZdm0rVGNIaEpjTjV1MU9LbTQ5WWJDelZVbElzNE45OVhGa1ZZdHZuVm0x?=
 =?utf-8?B?MXoxMGhiT1N5aFAwNy9nK2hVblRxUmVjVktrRHo5YURhOWRXOFFIN1RkN2xS?=
 =?utf-8?B?Q0hUR1UrSkdKeEcrZWlUNW9HVEdCWnhvRXp1RStId25udGthSm9zVU04cWc2?=
 =?utf-8?B?UVh5Z3lBbXFCNldsMzdiSi9zN2tpa1lsM3JJRWtWUnlwYlRvWStyNU5SY0lr?=
 =?utf-8?B?Y2M2L2pSbHVFR3o2OFlUSTZja05lOXl3bGpKdUFEbnEwYTYzSlA3VlZKdmo2?=
 =?utf-8?B?UEduWkNOWGREMmU2bFgwZ3pzY3ZucjFKT1dCN2I3WUtKTDZyMTVUY1h2SGNw?=
 =?utf-8?B?NzY1SENIMnhTRENmU00wS3Flc3h3cjZyd1ZDaGlobllMUWs4MHg0a1RYRS8v?=
 =?utf-8?B?bko1OGRWWUVCZ0toV3BvTXo4Nnl3MGg0U0NRTlg1R3JGZ0ZzUHJiWXRjNm0z?=
 =?utf-8?B?V1lOWW1CbTVXVy9CY2cxakEvWGl1ayszS0pBcTFObTJ0dHBwek8wbmt3TXRw?=
 =?utf-8?B?dTM0WC83eUxMNjlMNHgxSGE2SHFwNzBLYkgySEVNYXFDYVJ6aGI5aGF3aHZp?=
 =?utf-8?B?WjNVeU9DbFNXWSt5WGxDeHBZUzNrYnZhcWtjajIrdUxQeTlzUzAvU0ExWU5O?=
 =?utf-8?B?Q2M0KzNHRXZXVUQxYWJ1U1ZOZGs5MXJsZ0V2VjVITUljTVhQZ1hybVAyM0E0?=
 =?utf-8?B?RW5EZXdWY2NrYzZZOHpjK3NiVGR5YldWeU51akZZalEyVSs1UmZNTU5rK0lX?=
 =?utf-8?B?ZkQ2S05BSERBRFFMd1ZEaGpML0FCQlRaWXB1dGQ1RDk1UG51WDVnaUw0c0pX?=
 =?utf-8?B?RU15cE4wOGI5R2J5NlBkeU0xTU9HL1VuemY2VzZUVmQyUFIvNEpEckI4QW02?=
 =?utf-8?B?STdBc2xMenNsMW5lNlRRR0JweS8xL2M4ZisxRHFoNG9QK2I0K0FtT0Y1REVO?=
 =?utf-8?B?VzFPU0RUTTU4cU1ZekRucHVuOWxNOTlDOWc3Vyt5d2NsQ0NnaE1wWHNNc0ly?=
 =?utf-8?B?NW05dXUveDVVcGlCbjRwUG9hZTFad3dCa245SGV4MWpadjJ4RDBVSjRudWw0?=
 =?utf-8?B?V0hIRXUwd1h6UVBXdjJuSGxBa1FlQXF3SzZKQW5tQmFvRnlrdkxPeXY0amov?=
 =?utf-8?B?cDJYOUlUOGJPTW1hRG52ZFB1NGVJVkUvK0d6TFpTZzExNDU3NjAvU1dGVVpQ?=
 =?utf-8?B?UmJ0Q2g2YkdacjhEaitMQW51OHFmZllmYWtqK25JNlljT0owVTRESDFvelhK?=
 =?utf-8?B?b2FqVDVVc0d2M0tZQXpGcEJNek1iTm8wVlQvWjNTbk8yR3ZKdnU0ZWRwUmlY?=
 =?utf-8?B?Ky84YmlicjkyY08zUnVnN05ralBuUUJUcENOK0dqUG1hcGlMd2NiYm1HREFY?=
 =?utf-8?B?ZHJUR0V5RnRwK3ZCdDJXeUFpZUxwbWsvY2FyL2JhOFJjdDRhb2J3V1JiMWky?=
 =?utf-8?B?WG5pMmxzcXBxUmdmYXM2UVcyb25wcVB6Y3JhaUdZVlIyVDRyT2srM3JoUFlw?=
 =?utf-8?B?TEtUbzBUVGtpZmFESXRNQnBBVUFURjJIYlo5ZjR2VEhHejg1SEdscU95U050?=
 =?utf-8?B?cXJFcldSQldFSis5a0dHZWxGQTFBWXp2eXBySXFwdFFXdFZQVUlORHd5S09Q?=
 =?utf-8?B?VWRBMVl1WkhLQkdxdStOUlZIanF2RVVyZjA5WVVrNHdtejVkVWJ3cTlacXFK?=
 =?utf-8?B?K0RORWZ6U0hsRkdicXNGS2wzNlBmcFBHTzVEeXcrWWtRUk5VT0ZjNXVPR2ZJ?=
 =?utf-8?B?MVRxdFhKUFJxbFdwcHkzS3hmaUpzZjdHK0MycHArZktXYWtMdE15NngvbmZI?=
 =?utf-8?B?eGVlVDYyaXliZ25RTFJlM0dHMjVsQUVDakp0MVJoRytZckpFZUVRK0xBcVVj?=
 =?utf-8?B?OHlGczR5U251ZTZnMEFoZlkxZ0NHbnpmZXFsM043SGRiVHhrOVhIMmpDOE5i?=
 =?utf-8?B?aS9KV0VaUW1iN1NIbnU0UDdGUzk0dWJPajMwRFg2bGRnMzI0cVU2Zk80U2Ni?=
 =?utf-8?B?ZDZtU2dJM0NYYzFnaVJEOWErU0dLN1RGQXlCVVlpQmtYSkN1NlJTdkxIQWE1?=
 =?utf-8?B?VC9xSytYYXAwZExGUlBPZ3laNmNIL0hMNHMvSmFQYlJiTlNyVjJaaURjOXRN?=
 =?utf-8?Q?EKVf73h6TjaopqzV9h2XQubq+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d696c838-9b0b-4a61-4daf-08dacd291b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 08:02:46.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UaSW2WxNWSFBmnpv8SoyvmmKU5uO+ausTNmlMih1Q4OpEaaoqnuUIYP+HqjDZq7IctbU0EAfl0swmgr89GHwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBGcm9tOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gDQo+ICtzdGF0aWMgaW5saW5l
IHZvaWQgbXNpX3JlbW92ZV9kZXZpY2VfaXJxZG9tYWlucyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdA0KPiBtc2lfZGV2aWNlX2RhdGEgKm1kKQ0KPiArew0KDQonbWQnIGlzIHVudXNlZA0KDQo+
IA0KPiArLyoqDQo+ICsgKiBtc2lfY3JlYXRlX2RldmljZV9pcnFfZG9tYWluIC0gQ3JlYXRlIGEg
ZGV2aWNlIE1TSSBpbnRlcnJ1cHQgZG9tYWluDQo+ICsgKiBAZGV2OgkJUG9pbnRlciB0byB0aGUg
ZGV2aWNlDQo+ICsgKiBAZG9taWQ6CQlEb21haW4gaWQNCj4gKyAqIEB0ZW1wbGF0ZToJCU1TSSBk
b21haW4gaW5mbyBidW5kbGUgdXNlZCBhcyB0ZW1wbGF0ZQ0KPiArICogQGh3c2l6ZToJCU1heGlt
dW0gbnVtYmVyIG9mIE1TSSB0YWJsZSBlbnRyaWVzICgwIGlmIHVua25vd24NCj4gb3IgdW5saW1p
dGVkKQ0KPiArICogQGRvbWFpbl9kYXRhOglPcHRpb25hbCBwb2ludGVyIHRvIGRvbWFpbiBzcGVj
aWZpYyBkYXRhIHdoaWNoIGlzIHNldA0KPiBpbg0KPiArICoJCQltc2lfZG9tYWluX2luZm86OmRh
dGENCj4gKyAqIEBjaGlwX2RhdGE6CQlPcHRpb25hbCBwb2ludGVyIHRvIGNoaXAgc3BlY2lmaWMg
ZGF0YSB3aGljaCBpcw0KPiBzZXQgaW4NCj4gKyAqCQkJbXNpX2RvbWFpbl9pbmZvOjpjaGlwX2Rh
dGENCj4gKyAqDQo+ICsgKiBSZXR1cm46IFRydWUgb24gc3VjY2VzcywgZmFsc2Ugb3RoZXJ3aXNl
DQoNCkNhbiB5b3UgZWxhYm9yYXRlIHdoeSBib29sZWFuIHR5cGUgaXMgc2VsZWN0ZWQgaW5zdGVh
ZCBvZiByZXR1cm5pbmcgdGhlDQphY3R1YWwgZXJyb3IgY29kZXM/IHRoZSBvdXRtb3N0IGNhbGxl
cnMgYXJlIGFsbCBuZXcgZnVuY3Rpb25zOg0KDQoJcGNpX3NldHVwX21zaVt4XV9kZXZpY2VfZG9t
YWluKCkNCglwY2lfY3JlYXRlX2ltc19kb21haW4oKQ0KDQpJIGRpZG4ndCBmaW5kIG91dCBhbnkg
bGVnYWN5IGNvbnZlbnRpb24gZm9yY2luZyB0aGlzIHdheS4uLg0KDQo+ICsJYnVuZGxlID0ga21l
bWR1cCh0ZW1wbGF0ZSwgc2l6ZW9mKCpidW5kbGUpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIWJ1
bmRsZSkNCj4gKwkJcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsJYnVuZGxlLT5pbmZvLmh3c2l6ZSA9
IGh3c2l6ZSA/IGh3c2l6ZSA6IE1TSV9NQVhfSU5ERVg7DQoNCnBhdGNoMDQgbWFya3MgdGhhdCBo
d3NpemUgYmVpbmcgMCBtZWFucyB1bmtub3duIG9yIHVubGltaXRlZCBpbiB0aGUNCmhlYWRlciBm
aWxlLg0KDQpidXQgaGVyZSBpbmZvLmh3c2l6ZSBhbHdheXMgZ2V0cyBhIHZhbHVlIGkuZS4gdGhl
IG1lYW5pbmcgb2YgMCBvbmx5IGV4aXN0cw0KaW4gdGhpcyBmdW5jdGlvbi4gV2hhdCBhYm91dCBy
ZW1vdmluZyB0aGUgdHJhaWxpbmcgd29yZHMgYWJvdXQgMCBpbg0KcGF0Y2gwND8NCg0KLSArICog
QGh3c2l6ZToJCVRoZSBoYXJkd2FyZSB0YWJsZSBzaXplICgwIGlmIHVua25vd24vdW5saW1pdGVk
KQ0KKyArICogQGh3c2l6ZToJCVRoZSBoYXJkd2FyZSB0YWJsZSBzaXplDQo=
