Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C608B62EEB9
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 08:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbiKRH5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 02:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbiKRH5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 02:57:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2918C093;
        Thu, 17 Nov 2022 23:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668758225; x=1700294225;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XlHQ8RKdVwvnay2vkhZRysBN3z6GoTUK7XpKFbf9RDo=;
  b=XzRB5liiGGUu16gTTGOdFJBqs2qAQLIc3wvzMc2RIHPoqCeg8+dtQnyv
   2iNwzwA02e22dtlXlaRvPnm0z+pQX1ZRrB8RxXJqqBP3cq/PwWas5IA52
   0gc+Z01zhMdlJ5E/giW1uP7nGZAXDE7YBddwZBcMXCgofEv13s3xjgkZR
   9kjENvBx7jS4+MHYPsnVmzIcFhjxz/0ni5Qge6I6aIWqauNTcDTkB15yA
   vdMGppRFOAfKdibjLfB8A76co88KydrBfmfm88TG6nCLAFGxVQfi3FjWH
   0WEoTyBdxkiL0OuHVaVwMaMeN92WOPJuLAo64DuE7jBoOQumbWwSC67fp
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="339917786"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="339917786"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 23:57:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642420578"
X-IronPort-AV: E=Sophos;i="5.96,173,1665471600"; 
   d="scan'208";a="642420578"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 17 Nov 2022 23:57:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 17 Nov 2022 23:57:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 17 Nov 2022 23:57:04 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 17 Nov 2022 23:57:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqW1mZRXgN34dgDloOnVHXLrltarnadYo83VZdzxVDscP++fO/lnkEJx5nL+pNcDEzoh1xrvc52DVKKvLC7zjpqaSihZ0DcotccPQN8vDvU9lFRT90z50evSNgX+swb93OtdMqBwlvPlBU1QTKUz6FrnWLWxgh7GqGchHB+ShUKNFgzOkhzkZwEiwEpqCeBtE9I59x7MqjWrZXrlEx9iJ318UaaHw8H0xoVz6L927iInSqNBw2AIjTYJiNvgHtrWux3xC5ewt9L+I005Ib5uolcF4afDPKC5+230BxEuub63qgnyPFx2YWjrmGUxR7KIHvuYFmnUDwB55lKtHP2grA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlHQ8RKdVwvnay2vkhZRysBN3z6GoTUK7XpKFbf9RDo=;
 b=jShSacQn6Y9OFCVK2J7tzLFXgbEzkzQxlyz9E/TJDoyxlU4ClwGVCLIzr9L8FVDV7nssEU/kjBXY5IbhWD6gDbnmNhhaGw7L7S6meypIsWf1xVD3KMXjeDj/QX1QKtCgJAij2yRWSZh2d9Hphq1pXfkq3fm6qIapThClHAdV56595T1kXD5K5JzEUGJ/laQJ92hT4yal9hWAFSROcbjxqiGco++dDZSo91ZvhfVGZcWyoyHI5lADaqVh53QIiGa+f0FdM6R4FxKnLFQwowZngQG0Kxa1M4Sdqdh328eBPtMHnZx8pCG0ceXpk8fqQLVO7KHVnAovb5qzLofd+asu7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7359.namprd11.prod.outlook.com (2603:10b6:8:134::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 07:57:02 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::9929:858c:3d20:9489%4]) with mapi id 15.20.5813.019; Fri, 18 Nov 2022
 07:57:02 +0000
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
Subject: RE: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
Thread-Topic: [patch 08/20] genirq/msi: Make MSI descriptor iterators device
 domain aware
Thread-Index: AQHY9dV5ADECb6EyFUiooShPAdm6u65EWfKw
Date:   Fri, 18 Nov 2022 07:57:01 +0000
Message-ID: <BN9PR11MB5276F39FAC20C32E273B7FB48C099@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.500733944@linutronix.de>
In-Reply-To: <20221111132706.500733944@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7359:EE_
x-ms-office365-filtering-correlation-id: 97dcb499-0842-4205-3dac-08dac93a7a1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CofZC97LmGxYop0aUbgTCNcsStq6gBvMhCQ7mXHEa38D5c8CN9TyVhdN3CK3ejCrrNKTKlT+uzHa1y7QgUdZ6M1PXQdQejKFoDfxX88DoGr1gmn2p541XQ6y8B9aMUg/IeNWhhpKQrEVyVk1WKDWbBhh9unvsLJvESNldqHu1uEi4e4Ik2MW40493VBKz8F5KSr2jrN+x57YQEVGGCMKB8ddZj9+HBWlhSrqnRY41e2odmXQBQiKkV1mFL3c+Z3xH2ev75rre8IY1Mh69M3mBzagq/qvbikO/R3/G63mAX0nDpWZY9SFxUzRpxpiwEleS+Akw224U3Em9QVq1fQ/Ukcsog//Ni2GTSk0/2q+s1/l1+h0+nzF/fANsE3F/EHyjwpt3wl4AUIwULnHu6UooAI7ntesoOTNpo7IMSWdDA4t+61UMiAcq1CnH7kKP2ezjPudgVC8tqz3NAoczITozIs580oXMoSGGRXFFW63RfOsCv6t4sMylRX3RROWkxX6NO+ROMOZX0s7DGUxfa0Ucq59/AZYZxLUhk+Y4vOVoar2yr3GW7c5b5DmLSTxemYi+iIi99GRUber1Khhf96kEbSs2kbZ44M//rNSNFBg1EIz8he+iusYc3afDX931RVIZp6NYKc1LE9gNBMuBH8VePJCyVPsOMitX5yZ6n5ej8PPS+uWM0U196pLJkpoZTfyRVZgWf4gGEm9OBV3y30oRg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(4744005)(478600001)(71200400001)(107886003)(7696005)(8676002)(4326008)(33656002)(38070700005)(54906003)(66476007)(66946007)(66556008)(64756008)(66446008)(76116006)(6506007)(55016003)(82960400001)(186003)(38100700002)(122000001)(110136005)(86362001)(26005)(9686003)(316002)(52536014)(8936002)(7416002)(5660300002)(2906002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0d6dGIrUkE2SDUvY3E1NEVoNUFCMVR6NXRLK21RNVNkdTVEZXhGZ0VvN1RH?=
 =?utf-8?B?bU00R3lERERXWWM4M0l6STk1ZDhHQ1UvN0swZW1DbkVoVmN1YTZHUHFBY2Vr?=
 =?utf-8?B?YXc4OEplMGRSUGxrY2tLZUNzN2N3RkRVb2M0ODFGaWZ4THFScXllZTVKVHgx?=
 =?utf-8?B?emlBb25kZUEwS3YxM3FlL1lwQktLZHdjZ0ZNbmxJTFBqUmZDTHE5Vjd6ckxa?=
 =?utf-8?B?amFNVVNTMWVNSHBDeC85ZWppL0Q3ZzBxdk9DMU9VMS9OTFFvdDRZb1U2MVc0?=
 =?utf-8?B?aVlHU1V6WVo3S1IwNU5JQzJBVk5WRjhRdjVONkk4M2o3UWhITmMvQy9DZXd1?=
 =?utf-8?B?YVRGc3V1dzZUV1dIcEl0dW43WUVFM1o2WDh3NEUvekNmNVBKQ1hMTm5wWTlt?=
 =?utf-8?B?Q1dBMnh4cHJTbi8zZlhZRHVMOXpseE9DRHd6L0drYkRGNzZ2YjFkMFQzNFI2?=
 =?utf-8?B?bDlkeWJRYUF0VHZDMDhmYmZ1MzhUdlFaQlhJVE1oSTRaTC9WaVBhdmlZMVkw?=
 =?utf-8?B?empaMUk5RVhhL3c4ZnJQVWNoZytZb2lMU0poVUljditYWTNwOTBDbUY2bEt5?=
 =?utf-8?B?MEhqTldpWG4wMzdRc0FIRE1iVS92L2NuTjdvdUxuRE5nNXZGR1h6Q1VmMFA1?=
 =?utf-8?B?eEhmQmxRYm9qR3RwQ1lYZmlFTlJxWVNya1ZZdDkrdzlLY1FWOFRYOFc1cGE2?=
 =?utf-8?B?V0xncDVPajJINjh4bU9PTEwvcVllUkdUaW42N0hYWmJBQmhSckJ2UTJOb3ha?=
 =?utf-8?B?U1EwWnhKUlhlSnIxRFZxZk5tNmtXZzUvNHlaN3VIS1A5b1lNY2lodVhPcGht?=
 =?utf-8?B?SDVhSjhvK01xNE5PNlpoTWVOOUdsR3RIc3hlR2pKU2NnejdDSTRzUUk4N3JY?=
 =?utf-8?B?S0gyVjUzdzV5Y2xrYmsweUtOY3QyMjR2MDlnZ0QxRmFYU3AxRWxIR2FOLy9j?=
 =?utf-8?B?MUl4OWRpSUZ1UnpQbTB6Q3JRZFY5M3NPK002dk5iblNDT2crZTFNYWViYnZQ?=
 =?utf-8?B?eXdRM3pyN3hqMFE4SXc3dWVjcDFwREJjNUsvVnNiSGlSZkczeDR3eHByQ1k2?=
 =?utf-8?B?SDFWZlF3U2xGa3o0YUYrMm9WTnRrYjYrRE92MkkrTGQzS2hOTkxlVGhob1JZ?=
 =?utf-8?B?VlJqM05TYjVkaFBCVGVsT3VwYW5IUFB1Nk5zTzJ4aFNGTE5QWHMrSWVsblJm?=
 =?utf-8?B?VTMzL0c1MStMSWV4aklYUEtTQTdrTDk2a0c3NFZVZFJxODdXSXNwNmRNdjNM?=
 =?utf-8?B?UDcwb2oyV2lKOUtoWlJNZHZkejFLRjVUYVVkS1BCVlhwbkFrSnhMRk15ZVQ1?=
 =?utf-8?B?U2Urclh3bTg3SUwxMGtrdDJ6SC9RMnFhYUdwUWJFcTQvK0JKNlNoYU8zNC9u?=
 =?utf-8?B?UGQ4YkZLRkNoYkZyYXJDVU1kQzFSVDA5QzlFUnVPa0JacXRKeUhDc2VkeFlZ?=
 =?utf-8?B?N1dYRUVpM1NabHloM0hLR0IveWlweXhYVndJRVBsR3MwRkVKSzNmMTZzaDBs?=
 =?utf-8?B?ZlZ2cVVwWDcwaE9NRzZTT1hxTGdnMEtJcEFhOTRuTjY2ci8wWmxzUWxMMW9I?=
 =?utf-8?B?dnVWekg5UGJqSVFuZXJGV0s3Y2R5NW9JVHpIcDIxdEx4WDMzTUpqYmNFTDZq?=
 =?utf-8?B?WlpXMms0bmY1ck1jTHZ4Y2xiWjhyRWhrRVVOK3dzYjJzSCtnLzZBR3IvYVpx?=
 =?utf-8?B?N3ZVSnFnS2ZFV0FYRlZjTFZtNFdBKzkrYjJLN25MckNsMjIrdHNHVkhaOWJ3?=
 =?utf-8?B?bk42NjJVTDVQWStSNmtNUlQ0L25NSTNXZEg3blN6UVJ3cnQ4ajJQcHYrZnl2?=
 =?utf-8?B?eHpUWWxyUVVEYXFFTzZuQVlydEZPYmo3bStJcXpKbFV1RWx3TFYxQkt5UGZl?=
 =?utf-8?B?a2pNcmF3bG1IenI0b0ZnOHJ1V05yWk04bkoyekRxam5INHAwcllZT2N3Tldo?=
 =?utf-8?B?TVBUdDJaQnRiZlUzQ0habUtZZEZJditKS2lZbytreExyb3dZV3AxVjVjaW5L?=
 =?utf-8?B?ZVg0MHlZT3dvZVk4VGZyQ3ZDNkxSY3BLbTBaK2tRcTFkaWNRVDZUTHJrOHdp?=
 =?utf-8?B?MUVLclIydG5adWZFYTBwMFVkdGNlZU8vMFhMaTBDZFcvTjNGalhUZ1k0Q2lC?=
 =?utf-8?Q?uLKOw4afU1bG7+xyrWkkLgEyb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dcb499-0842-4205-3dac-08dac93a7a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 07:57:01.9547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ITjEHd6DSElIuyiuG2t8ukrgbCg93WqIIEjJj9qYkXQNIkVpARbHYqhxoNoJsboAENoZbxxMuac1ixRliNBnsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7359
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
ZGF5LCBOb3ZlbWJlciAxMSwgMjAyMiA5OjU3IFBNDQo+IA0KPiArLyogSW52YWxpZCBYQSBpbmRl
eCB3aGljaCBpcyBvdXRzaWRlIG9mIGFueSBzZWFyY2hhYmxlIHJhbmdlICovDQo+ICsjZGVmaW5l
IE1TSV9YQV9NQVhfSU5ERVgJKFVMT05HX01BWCAtIDEpDQo+ICsjZGVmaW5lIE1TSV9YQV9ET01B
SU5fU0laRQkoTVNJX01BWF9JTkRFWCArIDEpDQo+ICsNCg0KT3V0IG9mIGN1cmlvc2l0eS4gT3Ro
ZXIgcGxhY2VzIHRyZWF0IE1TSV9NQVhfSU5ERVggLSAxIGFzIHRoZSB1cHBlcg0KYm91bmQgb2Yg
YSB2YWxpZCByYW5nZS4gVGhpcyBzaXplIGRlZmluaXRpb24gaGVyZSBpbXBsaWVzIHRoYXQgdGhl
IGxhc3QgSUQNCmlzIHdhc3RlZCBmb3IgZXZlcnkgZG9tYWluLiBJcyBpdCBpbnRlbmRlZD8NCg==
