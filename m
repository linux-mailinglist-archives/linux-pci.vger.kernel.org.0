Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E8B63528A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiKWI1k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 03:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbiKWI1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 03:27:37 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA70B1161;
        Wed, 23 Nov 2022 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669192051; x=1700728051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v5Md/MvfhCO7eLVVF2EgMKeusN+Ca690kcjw5rRWK1w=;
  b=lS8kLjjedp4hOLhlfnhdeX/NnXY9ppZqghexfvpUrDWArYqUs0m6MD4+
   g/YzNNgOa8pmFWVfU7D924MhFnAu1f0KPczAtEh2h4nsuhmtHCGfwyydk
   N8YBp5RyP39EzqH4GpnyovFnccCbdUUZtWPbMNJFUTxCvP8on7Y+VFL6h
   1+QD92KBcY5DlXhefvex+ikGS2NnWU6kMrkQ3czyWkqWzG7exS0fJfLfC
   hXDiHrUxfwH0CEZGhyhc+D5nV3C10gExXU01E6D9rm1i5zxwyf/u8C/dS
   cdySbsxyY86cY0JLOVCwXLCA60tqgDwfbKa0LCJPCxSEpU1JcG+ufKgQ9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293721004"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="293721004"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816398050"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="816398050"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 23 Nov 2022 00:27:21 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:27:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 00:27:21 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 00:27:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ows6dPwp2yspEAxuWP9+5M3zrkdtNmYtQ+/ngNuaVd5d4FVUQJuA1/efEFfTzLEcF47C53fYVR7F5yauG99qIOOHZ45q3b+H4khuVYms8GohXx9sd5YyKmQpp7Z+YPJCxSaZxmOa9AGRsWooghbqGpYerChtLV89XgGlJIsWW93uA0vTlPsTtfN7CHu/w03YeSulOZvhsou7hWQcNaMH9+HrzoilojVqqdwtBrEh7MkpfA7hALx9IqLZ/2fbhxZOCK9ZkJ2xijugzPFXW9KYZT4NJ4MM1qjKSE39khCpfQ2aapkxOwCiwCdQLXCh88SVbjmFFfaB4RMQ1xm7WjGgTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5Md/MvfhCO7eLVVF2EgMKeusN+Ca690kcjw5rRWK1w=;
 b=mYRwNQl8SX7qP+wR+czgcqfJhD+0b84wGf5qB215TBs/bhhGaQuPuAIM8ZpJJqxvIcwUM+Q9kAfuUiG3VjICKu/IAnh+XLi5AzGkUFJKD1YOsqTxVIF7rV362B8yc4K092V8IAenHrI3zj5DEIj5ch912P974zZEIrfr8V1TEziYbAyz+08mkAjIT0uY6fWlu5CdWz1Jyerlb2L5njg0CJFPJ6duG6PUD66GncLJfvTKnKXFnSDD5YaaprpFD/V5TZFR7pSOkxhU/tdkfIw3b1hPwoAJ9UPb3DVJX4BAt4feZLqHKiIne0ey8vPab3HwUZHeWpL9Bl3f96+pbexAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 08:27:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:27:19 +0000
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
Subject: RE: [patch V2 19/33] genirq/msi: Provide msi_desc::msi_data
Thread-Topic: [patch V2 19/33] genirq/msi: Provide msi_desc::msi_data
Thread-Index: AQHY/bbnSgAh/r3zZ0WIl0yOrh2Qr65MLy2g
Date:   Wed, 23 Nov 2022 08:27:19 +0000
Message-ID: <BN9PR11MB5276C788BFDBC254CE5912278C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.546352933@linutronix.de>
In-Reply-To: <20221121091327.546352933@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6916:EE_
x-ms-office365-filtering-correlation-id: cecd2810-449b-4448-417a-08dacd2c8998
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oM6UXdJCeI8Maapky38ksc9iKFh6gvUj8EkZrvCWxgYNqzZ+FoZsK5jVjO9h6pRV6SU8lNtCv0zzaamUZkrcptTC1dBgTzIm/E657vL4lmOY2JItK2lI0UiyZ3aqo2oOnFApylUUzCvlPqww4hsXiefY/7iiwfXfHfM5xfkposh9344FU/eeLB7eUf9RItz1o7yc+FPrccBu/dIVzF2M2KMV+U3k19RlarWQbQ5UDjGdTmEqKJ/5fz3Chf7VhuyHv0m0fmJqKntjYq8V3o6cBidTQ6cc8tkEz50pMdAcJ2Ow8ls4pF88nBIWdhMcPAGB24/GEXC7zJjb6R59OBM9R0gzddQCJ9TZOZdOn7nBQeaOYqy71ZLc3IHKuHcUAKRXsr8Wu7Ly3mFE/TFMFYWQRgcngGW+cs7McGzIRR+yGrr+R0RPSm5tOe+onwIZfPbjvLoaMf+y4rqpD3Z4LTQZZHGev/dKTRoSyUEGyt7b2h7KbfDTgz8HZA7d2xsXphUr4UavQBXTFP3WmAFIoPfdK4WD0VNDSxbRvHxBzboYhU2j7pxBVf04JPz9nASR7L2feCMkTqGEAMgdirnyM9jKqiSGk187n1RdeAOpFWjk6jKFv8gOdnQ0Pm28ii6ZMjcgyVjjlYTU+cQaltEoK3NeE5fVtHy2onGk/TK18MsWSoQOYw3fjD7WtfQ6lbxKQ/yT2vLsMC0b+ZNl9xK5YDgz5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199015)(33656002)(52536014)(38070700005)(41300700001)(82960400001)(4744005)(38100700002)(2906002)(86362001)(66476007)(83380400001)(122000001)(9686003)(66556008)(8676002)(66946007)(316002)(66446008)(4326008)(76116006)(186003)(71200400001)(110136005)(64756008)(54906003)(26005)(8936002)(55016003)(478600001)(7416002)(5660300002)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlVXRTg0MTNlTjhXRzVUT0dQcCtXSFRvUm54SXVNQkhEZmFnM2RlQlJqV1hx?=
 =?utf-8?B?d2J3aDIwSHlwcE1nMG1JekozeEVHZFZ0eGJrSzhjaHY4Tjdma1lUNjdEczN5?=
 =?utf-8?B?eGE4Ym5zVXB2ZFlQeVdPUlJ3ZXcxR1MwUEd3MmZJSjZpNCtkd3lUOVhQZ09j?=
 =?utf-8?B?cFdlYWJSMXpMNEFYdG5UV0JNZVhRb0ZjQmprWkEyakdRNW9WdWdaeWs1Qmcy?=
 =?utf-8?B?NEtBU1h3UVVtZVpGTjZGdy9jazI2bmRZckFGRVNTYlI5elB2TXh4aFNJdjNs?=
 =?utf-8?B?MnZOR1NmOENZWEt3d0Y5T1ZWL3NVTkRyZCtFY0dqdkdlb1ZnWXM1V1JWeVVv?=
 =?utf-8?B?aTlWcUl3alVWOTByTHVhaDdkSm02UzZGd01rRlpKaFFnaTRkOW5UTTFjai95?=
 =?utf-8?B?MnRqbjZIV0FwbEMvMHBvY3pOcEVnV0Q2TkhMc3FzSHFyMWNvNFlUcTF0N3FX?=
 =?utf-8?B?bkNtNjEvcDJrcVN5VDhHZVRCQytreHEzRTRDRjNURTdwbWliKzRxRUZwT2hQ?=
 =?utf-8?B?Sk5JeWJoNmJlaVZxRWI3YXNna2pFYnJUTGtZcm1PdTRnOVgvSS8zSzVTRHBX?=
 =?utf-8?B?dTliYnIvSmQ1dkxjdHdCOVJFK3VJUTV4bzdlaFgrS2IzU2UrSHJxYmllaSsv?=
 =?utf-8?B?OHR6N3BsK0V0dlJpR2kvTXRsSmpvb0JQNTFkQlorQWJDOEIyUFplaEZPK2Nj?=
 =?utf-8?B?c0c0NVNSMHhTTHh2dTJkMzFIbHBmeXdRUng0WkdENjdRNXU4OFRzWHBkRFNX?=
 =?utf-8?B?YlMzVTh6SkZxQWxUNVAxNFhhWGh1S1RHakhHdlYyMy95TWt0eStoWmgxTWJI?=
 =?utf-8?B?ZXVzSldGV3lXakVlTGo3Y1pnYVlWczdMU1dvcHdVWWFETWJ4MjRkTVFDTUxl?=
 =?utf-8?B?bkhkQldOaVRNQ2RIbThMNWMvOU56NVRWOWRmU2ZUT0I5c2tvNjRGWUtaN1hB?=
 =?utf-8?B?Mk45K1lZbG0xMjNtRXBVWjJ6dGJUTVF2anUvWGsxang2QWxTN2c2U1JYRHFS?=
 =?utf-8?B?YUt2QTEwOXBZTldSK2FOV1pqa1hWbTZLWUVwVTRxcGZnL2Z2TXJFakNGMVgw?=
 =?utf-8?B?Mmg2am53dk5pZ1pScFo0Z095WEp5MDAyeWp2Wnh4cnl0ejBteVNlWndmaHJr?=
 =?utf-8?B?K1NFbllMZ3hjQThqUVlrTThORHRZK2h3ODFDeHlTOHZxS3VuR3ZocXNGaVk1?=
 =?utf-8?B?YitJWjhsWWtaRVdBZzIyMk1UckJMSXUwdlFZaHVDZVRtaWZqWnMrbDdtY3Jl?=
 =?utf-8?B?R1FKZ2kza2t3RmVXV2Ntd3VDY0REOG1tblZvT0I0dWlWMTNMQnBuWE5yam9L?=
 =?utf-8?B?VlRnTXZOZHNteHp6RUNXcUd1WnEvQVJlNDYzcjJhL01Gc1ZkYUFvMjY4bXNS?=
 =?utf-8?B?RFdsZ3d2cCtsNU1hUnpSdWMzTWo2K2pyTnVZYjZrTUJOSzlXT0cySnVtSzVu?=
 =?utf-8?B?R1RVZzZXd0wzcXJXYTFFUXhXbTl3UzE1OW5aZWRjQjBDTWF6NE9WaThlNHRz?=
 =?utf-8?B?ejI3YkhJY1lad3plUFB5UmxnREowREVzYVJGdFdRdkozZGcvZVVkMXlSdzZC?=
 =?utf-8?B?d0xHV3FCR21VdHVzWnE5alduKzFJUy9lNnhlM282eTJhVDEvc0d2ZlBUaEpB?=
 =?utf-8?B?MHZNQWo2bWloRTFJK3ArN2pPajdNbkVZOU0yVUdya2ZRTS80cm02ejN2Ym5p?=
 =?utf-8?B?Mm85cjdUSGpZTEorTThqSjUxTXQ3RnI5MWcwWU9UaDROSW14TkJSZlJUNHZU?=
 =?utf-8?B?YzN2Q2FxbGNlZkZvcFZsU1lRRVhMSHFDV3pjTnc1ZzVmOUYxYXFzN05pYkor?=
 =?utf-8?B?dFFYTzM0NUxXdStMdjVlV3pBc2FaTkk3Ukl1eEVRdmhQTWpsejRUL2NTK1hm?=
 =?utf-8?B?NnpVYXQ0Nit5bHNidXd3SWNwWWdoSllmUmhFTlRiQkVQTWRvcmdLZ201Y0lS?=
 =?utf-8?B?dDJSQUxzWGszQ0pVMXM0REhKWlZ4NUY5NzFKOTVNU05qZGdHZnVwb2VyL2sx?=
 =?utf-8?B?STk5WmIreDBSTmRyNUZ5SHJkTC9vU3NyU3dBaGZzZVU2a0ZDS2t1VXBrbHZk?=
 =?utf-8?B?SVhuYUVjc2FMZFErUEFqcVRsc25nTDFObWdtdVZrREdzRnZoV0swZnVkNTFH?=
 =?utf-8?Q?FLKiNj0Robem/7JjXNtTQ1bot?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cecd2810-449b-4448-417a-08dacd2c8998
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2022 08:27:19.6589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tK1dFyDiXWP7kWPP3Pt/VXyVBALAV9LuP18gZ/Mw1OxWLgcvhWh5U/6/dEByqxCQWw6BlRSuX/fudd2RX9q1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gVGhlIHVwY29taW5nIHN1cHBv
cnQgZm9yIFBDSS9JTVMgcmVxdWlyZXMgdG8gc3RvcmUgc29tZSBpbmZvcm1hdGlvbg0KPiByZWxh
dGVkDQo+IHRvIHRoZSBtZXNzYWdlIGhhbmRsaW5nIGluIHRoZSBNU0kgZGVzY3JpcHRvciwgZS5n
LiBQQVNJRCBvciBhIHBvaW50ZXIgdG8gYQ0KPiBxdWV1ZS4NCj4gDQo+IFByb3ZpZGUgYSBnZW5l
cmljIHN0b3JhZ2Ugc3RydWN0IHdoaWNoIG1hcHMgb3ZlciB0aGUgZXhpc3RpbmcgUENJIHNwZWNp
ZmljDQo+IHN0b3JhZ2Ugd2hpY2ggbWVhbnMgdGhlIHNpemUgb2Ygc3RydWN0IG1zaV9kZXNjIGlz
IG5vdCBnZXR0aW5nIGJpZ2dlci4NCj4gDQo+IEl0IGNvbnRhaW5zIGEgaW9tZW0gcG9pbnRlciBm
b3IgZGV2aWNlIG1lbW9yeSBiYXNlZCBJTVMgYW5kIGEgdW5pb24gb2YgYQ0KPiB1NjQgYW5kIGEg
dm9pZCBwb2ludGVyIHdoaWNoIGFsbG93cyB0aGUgZGV2aWNlIHNwZWNpZmljIElNUyBpbXBsZW1l
bnRhdGlvbnMNCj4gdG8gc3RvcmUgdGhlIG5lY2Vzc2FyeSBpbmZvcm1hdGlvbi4NCg0Kc3RhbGUg
Y29tbWVudC4NCg0KPiANCj4gVGhlIGlvbWVtIHBvaW50ZXIgaXMgc2V0IHVwIGJ5IHRoZSBkb21h
aW4gYWxsb2NhdGlvbiBmdW5jdGlvbnMuDQo+IA0KPiBUaGUgZGF0YSB1bmlvbiBtc2lfZGV2X2Nv
b2tpZSBpcyBnb2luZyB0byBiZSBoYW5kZWQgaW4gd2hlbiBhbGxvY2F0aW5nIGFuDQoNCm5vIG1z
aV9kZXZfY29va2llIG5vdy4NCg==
