Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 496206370CE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 04:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKXDLL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 22:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXDLK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 22:11:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830D4A04D;
        Wed, 23 Nov 2022 19:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669259469; x=1700795469;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=prQQ8hAMVDC0VHDocFF99G7hvQggqCxSa+B/UhNAQ9Q=;
  b=V4JeKhkRTDunqWsUysgEexaew2DsAMEVGpr8G1VoRQ5ChI5+1XmkjcHH
   TmQ1QB9ni11/a7wXx9RlBhfzLIGlupzWPqAW3AGtCe9xcXX6pgvGUTQRZ
   V8PXrfLP0WATcZ7y+DOKwwDVlbNHGfxJjghnj9mscm+nlnhyfonvGhS/4
   8dWOw1NfYFBbI7wPXiWlghdW3spa315GC8Pj9QTrVIXbDRX794MhAT2E8
   7QDi1FsSO/+pn3NKQJ8d7Z2zfFE2s/t7KCcv4NftCzughZD0ikHYJprdJ
   JLzFmv6w+fOrP2vUku4ANnk/BN1s+FqnIalAC+/NGX+6vaC8un22sfBai
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="400497601"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="400497601"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 19:10:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="644330377"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="644330377"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 23 Nov 2022 19:10:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:10:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 19:10:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 19:10:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 19:10:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhRQFVPhVBnjLfqBGMlRNKF70hUfkwxNqof2DFH1p8QutsPMgmDs32X7EH7138q1yBiFKZ0drRIpvslUsGo8jRBKsplqYRETjSihfNdpEIbBKnIrp3QEpETjkLqpv7XhZbL808PqA5tJamh9AYugJHYKs3hePQmXhCtCo0jkvyQLEmiIWxlO9RM9AvkHrKhjQxgO14Qk5oC2JQF7lg2KUAm8tLsMgFV9elsiiJdpEcZq7mqK7cARhkvQImh2djoU8YIPcqTUUtJPP55o+x0qduL/9eD+s2Kqt7T3Onn5/wTQhwjP5TyqFW8GTcfrhbnZKewAGerH76I8hzaew4sFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prQQ8hAMVDC0VHDocFF99G7hvQggqCxSa+B/UhNAQ9Q=;
 b=hKnPdY804kTcrt9CGgp+cUXXd023Js6NB39+L0Jviqj5vpcIrCXZHXcUhlRn3sbkQ4+jElNIVUdHThP0Cezlktb/XFwSUHUv5ppk7xw9A5H04/lLsJ0pisfRn11ozPWWNJ/lDBLVUzzPpj9xoZL3Tmzt0VFIREkcXOnAM0abuM0xcQLD5tkzJ1VvsW5hZu9WhjDH0D1JRHjW55XXEuHPTHihXXF04yYkA7TjAA1rcCG3Y5yBpiH1VgmAO8w5IYOKUwZ1qm90AK1ywnHg2F7INE46cv1Mc+UnHsD0CpRpihLfA0jCDcjSQzwK5okda6J3w/HNCfYy4dujYTURVxoGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 03:10:51 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::d30c:c435:9b26:7dde%8]) with mapi id 15.20.5857.018; Thu, 24 Nov 2022
 03:10:51 +0000
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
Subject: RE: [patch V2 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
Thread-Topic: [patch V2 28/33] PCI/MSI: Provide IMS (Interrupt Message Store)
 support
Thread-Index: AQHY/bbufY3L6DKSu0qLqIIzJQCWAq5NWFZg
Date:   Thu, 24 Nov 2022 03:10:50 +0000
Message-ID: <BN9PR11MB5276549A90576254ACCCBED48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.026206487@linutronix.de>
In-Reply-To: <20221121091328.026206487@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: 4f5b5eba-a284-4b82-345e-08dacdc97de1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ShZ6tGprZN7Dyc+26bP7q4RA3QmwQwLAGNEjQw0tUYWHa9gfBEg0CaAowFIydQykQ4hs9+d2gWzLgapUkgY5ZxXm16vkvzRPONziiK4v3ZcJz8t3K36NLDp1DBRzosMhnJZtE+vtJWT+ILCeAFAZRqQH3IjqwCoweL1/um9MCVTcyzGELNvdwUMRqxLK/T4XnRNVjgDbar8MnJmCnn2OxJa41TBRXHQXcUIuuXyusg0N4CqevP3Ucq0HgR/EtzX6n71msRyXfxWqZb4LlrFDe77PD3MOZRmnATkxs5Wu2Gzdt7VhSSsIzznIhaOoF/8t6E5eXveANAYo1U4S2U/1b2DksbNlLM2QezNF6oLhgqn8cdeLsePxeWjM2d2qU/Ub/03sSrqeT7ubyloVYLj2JM+jQLncvXwW+bxwtbC2ZYzc4GLM/rQQwB35S8plS6Agvhpj85yGHHrZkbTxttEarOLTiSTKVLg0QZLUssoQS5LaULOhEQ8dhmPQPIDVPLqoecP2WF+QX8vtWdFo9nqGYFEaJFABx4ZWD+iyzJIWufyOKNQENOMHIAwBtZT95vRGLqoh9w1xf0B/OoxvLFLGuRsZwYohKd5fdq22W/f51tBetdcryv/CDO7J+DNMBZMU29+kDbLVYjbNBZ5F4VlcwQxq1G7UPo10vd0BwW7R581+35NwbR9bxmS+ZaMRnj/GGNKpXqk3yZAhOiseUQfLIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(76116006)(38100700002)(26005)(122000001)(4326008)(64756008)(8676002)(66946007)(41300700001)(66476007)(66556008)(66446008)(82960400001)(2906002)(86362001)(54906003)(55016003)(52536014)(33656002)(7416002)(9686003)(8936002)(5660300002)(4744005)(186003)(316002)(478600001)(38070700005)(71200400001)(110136005)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhjaGZHQWRlcittOHU5N29ReHQwcUFkTmU1OEZvUWR6RUkxQ3pYdXBJYkVL?=
 =?utf-8?B?RlhsN3VDRDZHTE1pMG9sU0RTbllreWsvdDFkQlIzYWVwRmFNQzg4MzFvcjZm?=
 =?utf-8?B?MDBPTnJoMUVicVVCNG5zdnVJell2YklOT1ViYjhNRmtuaERzNDNwWEFRaVli?=
 =?utf-8?B?allXOHhlSnRES2I0TkZndytSU2pEdWIxMDBTd04wQU1aOUhoVTFjbFBGUnUy?=
 =?utf-8?B?K0Z4L0VTTDdmS2dNK09lNWczV2RMcVV6cFk2aXUyQW9ES0dTdHhTay84ZTQx?=
 =?utf-8?B?c243cmg5R09DZG9QQ2QrR1FHbHBMWmtTTllpeUcxNW1XNUJ2Uzc1Z3pHWEVQ?=
 =?utf-8?B?L2RqZ0h5bjRFeUwxcjJXV2xZS2xnS2Q2ZUkyZGlOdjQ2aXVtekUwdDVFQzVK?=
 =?utf-8?B?RGNIL2FkUStXclJzeGl6YnNtY0dzSWNPN0h6VWlRN0ZvNTJ0UkhLUTBma3cr?=
 =?utf-8?B?bEZWbWlTajNhOW5PandnYmF4MGpwVWRqeWhsYVVqZHhyVXUxbE1oQ1hqeVRI?=
 =?utf-8?B?UjhtZEkwRkJ1MTZveDdoS2VjK3BxU3RqNWZCbVh0SHlqcS8vRmpzVEtzeDhj?=
 =?utf-8?B?c0IyY0Y4WDF0czBiTEJxQTlMclplS3A0bHQya0luVkRIU2VielhGK1hEczF6?=
 =?utf-8?B?THVYYTJwcVBuK3pkV01UcGFraDJSa2ErU0VBTzN0MjlZZzRSQUZ5MkVVUEpM?=
 =?utf-8?B?eHFVY1hISGN3eVBWaUFPYlB0dXF5RXNWUjJrbG1pOHpoOC9BbU9MVU9MbVlQ?=
 =?utf-8?B?bjNSMHc3b25uN0haYk9hRFh4M0xkeWJpVDZwY2FhVEtVYzF1QWFmUU1KS0xr?=
 =?utf-8?B?Nll6NXBDaVY0TjFrUFdyY1QzWW53QjYxdC9kWkdPZWhwdC8zQy9lNE9ZakRU?=
 =?utf-8?B?ZHQ0MUxxVWpEYlNvQkNEbCtYbUdLaEdUMmNWemQ2ZXl0NkZDa2R1eVUrbjJ0?=
 =?utf-8?B?SmJyTUtsQXFhOU8xQnAxQnA5R3lLSE9YWUJIYjIvZ2dwSERpYjRFaVpVT1hW?=
 =?utf-8?B?Qm93VnJMVkR3U0JsMHFUTEJFSW05NVZML0QzMnM5U05KK211cTh1UEUxVzhJ?=
 =?utf-8?B?bWJ0MFYrTDFSY1lOR1VWcE1veHFLenQ3SzNReGtSTVo2MjIxWHpoMnlXN0N2?=
 =?utf-8?B?WWZQelQ1YUkySzg0TnpkdUxCeGxZQ0dBcVRXNkovcUlYZUlScjdrNEgxbk9L?=
 =?utf-8?B?Y3daZzR5OHN0VEIxRDBoZThkRHZIOUgrNWlhMGhaVkV0L3ordUk0UzF5UHl3?=
 =?utf-8?B?cWo1Q1YvVmFKYTM4SDl5dGw4Rld5VEs4OTBNZk5QL0E1dzNEVDgybTlsREdr?=
 =?utf-8?B?NVZ2dzlzeTlSTDRHTUNLMUduSTFLazZjdThVdE5HU0Qwa0oxSk9RR1ZJazlx?=
 =?utf-8?B?RW1OYklqZ3BPeW1RdFZjb0llYTNXcmhZc2pka1gvMEExM3hXRnZEWE1OU0VO?=
 =?utf-8?B?RDF2V0loNE1zL25CMmtWY0tOOE1zOU50bms4QzREUWwwM0lvY0dSSGdCamVO?=
 =?utf-8?B?RE50aE8zdDgyKzFGTElKSnc0Y3RkY0RJYVJoNTBXMVY5SklKSHhnMzVBK3Jr?=
 =?utf-8?B?SThyOElIQjJNY0lybldzL1hkM091QW0rY2RhNm02Y3lHeFlXdnd1U1RFUzVB?=
 =?utf-8?B?NEl5SElnQVV6ekVnc2Zzb0I1K0pBaGFyYzQ2MEpXL215RzlsSkFEQkovYTVw?=
 =?utf-8?B?eXk0emhRMWNFMmEvMklCbVVIUU44SG9FS21KOHRwbnFiNDRseS9HbzYzQ2pC?=
 =?utf-8?B?Y3ZzRGI4ZUx6Y0lmMGg3TEZmdFdTeGd5RmwzamllQmxQbnJYcTNHZTJIMjRN?=
 =?utf-8?B?a0JmclVDT1NUdUdLZVNHTlhnWk14NzIxS2hNVmUwcXk3V0h2MFJzMDdna2RZ?=
 =?utf-8?B?NHFpTVRzejZrRHRyVCtDVVFuMGRZZjJuemNjcWNVYUU0SmpET1ZudjduUXFF?=
 =?utf-8?B?dFZJSFd6MXRjbGlHa1R0Ujh4Z0F6dmc5bUJ2bU51WFVMbm5URGpyMmlldFVy?=
 =?utf-8?B?RUZJbENmVkxKQUFMRGtQczhveHNFMVFPeVoxR2hzRTBEMEV1RVRhUjMvSGFQ?=
 =?utf-8?B?Z2NWZXQ4NUZ1RXNza1FSODZjdVF4M3ZZandqMVo5ZFJQa2dwckh6bVd0MG1r?=
 =?utf-8?Q?8kdGQeE2RQ9w9+l3wz/y5hdUj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5b5eba-a284-4b82-345e-08dacdc97de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 03:10:50.9753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apgcptKfszdyVVtl2UgarRHeuOqWVHDmiaULoYU/CL4a3pv8WepAzjoL0PXd1jMzjOKvz6cx+xKwC4UxQ0vjjQ==
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
ZGF5LCBOb3ZlbWJlciAyMSwgMjAyMiAxMDozOCBQTQ0KPiANCj4gVGhlIElNUyBkb21haW5zIGhh
dmUgYSBmZXcgY29uc3RyYWludHM6DQo+IA0KPiAgIC0gVGhlIGluZGV4IHNwYWNlIGlzIG1hbmFn
ZWQgYnkgdGhlIGNvcmUgY29kZS4NCj4gDQo+ICAgICBEZXZpY2UgbWVtb3J5IGJhc2VkIElNUyBw
cm92aWRlcyBhIHN0b3JhZ2UgYXJyYXkgd2l0aCBhIGZpeGVkIHNpemUNCj4gICAgIHdoaWNoIG9i
dmlvdXNseSByZXF1aXJlcyBhbiBpbmRleC4gQnV0IHRoZXJlIGlzIG5vIGFzc29jaWF0aW9uIGJl
dHdlZW4NCj4gICAgIGluZGV4IGFuZCBmdW5jdGlvbmFsaXR5IHNvIHRoZSBjb3JlIGNhbiByYW5k
b21seSBhbGxvY2F0ZSBhbiBpbmRleCBpbg0KPiAgICAgdGhlIGFycmF5Lg0KPiANCj4gICAgIFF1
ZXVlIG1lbW9yeSBiYXNlZCBJTVMgZG9lcyBub3QgaGF2ZSB0aGUgY29uY2VwdCBvZiBhbiBpbmRl
eCBhcyB0aGUNCj4gICAgIHN0b3JhZ2UgaXMgc29tZXdoZXJlIGluIG1lbW9yeS4gSW4gdGhhdCBj
YXNlIHRoZSBpbmRleCBpcyBwdXJlbHkNCj4gICAgIHNvZnR3YXJlIGJhc2VkIHRvIGtlZXAgdHJh
Y2sgb2YgdGhlIGFsbG9jYXRpb25zLg0KDQonUXVldWUnIGNvdWxkIGJlIGEgSFcgcXVldWUgb3Ig
U1cgcXVldWUuIElzIGl0IGNsZWFyZXIgdG8ganVzdCB1c2UNCidzeXN0ZW0gbWVtb3J5IGJhc2Vk
IElNUyIgaGVyZT8NCg0KYW5kIGZvciBhIEdQVSBpdCBpcyBwcm9iYWJseSBqdXN0IGEgZ2Z4IGNv
bnRleHQgdG8gc3RvcmUgSU1TIGNvbnRlbnQsIHcvbw0KYSBxdWV1ZSBjb25jZXB0Lg0K
