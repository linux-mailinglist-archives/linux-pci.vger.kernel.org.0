Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDBD2EB5E1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 00:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbhAEXIH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jan 2021 18:08:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:38760 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbhAEXIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Jan 2021 18:08:06 -0500
IronPort-SDR: 5VZrpBxWrzPiOCVQmVCwT6lnU4CDf1crBj9g0qx5j0pmfLHoBskW4/Nyd9B2EOK3pcSPTIpMvz
 JR0uHUDyjmDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="173685756"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="173685756"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 15:07:25 -0800
IronPort-SDR: eeZE9hGWKgwtL20N1EH7EbUTrCXvpvURmYhid190XqfndS+k+De97VFyyMbZHwbwxNM1cSfP80
 8Uu04YLJWMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="343318179"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jan 2021 15:07:25 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Jan 2021 15:07:25 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Jan 2021 15:07:25 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 5 Jan 2021 15:07:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6KCBi3nrc3WebOjJ79G7Z77wDPuO4T8SFQKjqp0HeMi3l2Yp1ZzdnBOuv6Z/Qjw+Y4ZJ6dfaPffukAJbrNa4LzQcI2Vd9A0fa/ERvA/xYZHonHUb4AJcs7a2FAKikdE69kWzweV/F03umvmg1PGoo8wHk2z7mBQDzaYa4DfNbrdDaZGUd/esmgWrC1Uoj03E6DgmQLQWc0o/v+SswWLNGQkFykeOVmRhAU+Z4/EcGXL7FhOcGZ4IqNG9/hpz+EFL/5skqfwG9V3a8gYDizsMuMzsqjvXF2xgXBdZ+IOeCIip4G1ekSdHql4ye91zOIxkcMmAEsZ34Ap6duglaSaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtTV0Das4zuklDUOAHDozj5VLeRXnhu/gSJjgvDbdyM=;
 b=dPUWrcMe2wDQvITaH8Cj/Z8Z+FfDgGW3zwtKvah678qUD1+++zedNLhqq3zv1bSehbiXqqCjvo+DtESdYTn0M/j7bxomMMOXIVOiTNorrECLtkIYasNaAxImjHZSgPok3kcgbVnBvg3ZJgDlDIiseuo8/fHouJohuC6ZNQly914e8pcesgUGgXcdWqp5ZY/sSr28RFaPHDN/pyA3mH5uYkcsPL6bGjJGDCuPOpZXO92l8JnYPze9MPdTV4k1R0I43urkTgyqtJ1kOtoET8nNy+SM+jTap2L2aHdDkyIeRP741BmkzSSDbvxAlRWRIhrW7Nfv1DRQs1ENlThgu1GGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtTV0Das4zuklDUOAHDozj5VLeRXnhu/gSJjgvDbdyM=;
 b=gih3xLWMT6Vb47BOeKN0dhhyjkogWBTDB2+Z939Kijfo2HbxgbMNgcQIl5E018rygH5GvGFj/cubBB7zED43VfJVYXhNzYbzfzP+r76d8bTDGWXgeTeRSfuNCr8dxb5+2XFMQbOT+JgSbPaMI4wnIDLOL9pIn9N3Q3nm+FVBwi0=
Received: from CO1PR11MB4929.namprd11.prod.outlook.com (2603:10b6:303:6d::19)
 by CO1PR11MB4994.namprd11.prod.outlook.com (2603:10b6:303:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 23:07:24 +0000
Received: from CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf]) by CO1PR11MB4929.namprd11.prod.outlook.com
 ([fe80::edc6:bb79:1d26:53cf%3]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 23:07:24 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Hinko Kocevar <hinko.kocevar@ess.eu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Thread-Topic: [PATCHv2 0/5] aer handling fixups
Thread-Index: AQHW4u4CGInaUSTiCUecz7z7L8vHL6oZFlKAgAAMn4CAADmZAIAATKUA
Date:   Tue, 5 Jan 2021 23:07:23 +0000
Message-ID: <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
References: <20210104230300.1277180-1-kbusch@kernel.org>
 <bcc440b0-0ab9-c25f-e7d5-f7ce65db5019@ess.eu>
 <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4379e783-70c1-41e7-a593-08d8b1cea9a3
x-ms-traffictypediagnostic: CO1PR11MB4994:
x-microsoft-antispam-prvs: <CO1PR11MB4994EE82E0C02F75725AB6D6B2D10@CO1PR11MB4994.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0R6uu8ocDYVVeER+O9K50lZul053BQp1nAolXlivZKuPlHDAOlOY100ATX90XBD1zbQC1eOd+ENpL0J1ZeWExhwCK4r7BHVb9oPf8IVpt+xOQDnYOW8gjUYCPHwnyKf3IraqbVKIPPF6lEWi0bE3bXU6lFMViXONO/1KFZ+1mZGIXsiLhO9v7aAAwM/NuPZvg5qJIhqxqm4E7XuSjlxg9p40nimodtRAbWlQRTD8vMIVsiU2obLlSo7Kak5QhBIE0+IsR+HGw+i+AzYZOR4jRvwfKWCixzfO+/bQjI2JwWn9ejWSq17Qk+EkkAFV19ZUJnNEQbdZnMKvyl2bDdhZW+4XatlRaqFy6/Bye07aRT3DMBZQJ5XvP3/zJ6GmmBJx7quU0yFRvUscXLUt9cp18kZ1XUTvneIfgJO5sb3fvlsIN3TC6fEPPRSPcAvJVDyD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4929.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(2616005)(316002)(6512007)(26005)(6916009)(54906003)(53546011)(83380400001)(76116006)(6486002)(36756003)(71200400001)(5660300002)(478600001)(8936002)(4326008)(6506007)(66476007)(91956017)(186003)(66946007)(64756008)(66446008)(66556008)(8676002)(86362001)(2906002)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V0ljR0dhR2tTNWtLaFhvVWU0Wmw4bTJFMmVsRnBuWkRaNHNyVi9qNytIYU83?=
 =?utf-8?B?NDBSR1c3RDdEYVlFaDJDVEprUTdud2dPakM1YzZVK0s1TGRHYkwxVFlWczlW?=
 =?utf-8?B?OEdUL0c2Z04rQzJDbnZHeVJlT215ZEtQNXY4dmx3d0M3Y0srOTN5ajdvTkdO?=
 =?utf-8?B?c09wVGQ4MFMvL2JUZ2NySHM3S1IwVGFRQ0s2b01lNStoRFRiejdsakVkT0xX?=
 =?utf-8?B?UjZIZ2RaZU50ZzF3b2QzWHFtUFd1MjkzSE53VFpPWW5uaHpSUUxEQUJkM1VW?=
 =?utf-8?B?L0tOWEZiYWdHamNhY2RhK0pMZHIyWjU4UGhzTmk1Qk10TVBEd1BGRHhzMmwy?=
 =?utf-8?B?R2YyTkxTWElmZVB0bGthWEcyNFRHRkFPVzZBaHJUVjhTKzd1OExzVVdvRjJK?=
 =?utf-8?B?YUF2OHpxakV4VU51aEY4QVRyYi9ab0ZTNnozV2tBYjJGMHhJb09oSUhzcXBs?=
 =?utf-8?B?c1IycnJROFZPUm5pQ1hDUHZ4dUhDbDdqd2pNWWNsZmpaTEZzbkxZOCs5R2Jr?=
 =?utf-8?B?djBIMVhWRnhzckIvZC9heWk0UXVtZmlvUEZLZmdQTjNSZGJCSUkyNG1sVzAz?=
 =?utf-8?B?K1ZQaTFzM2JjMWJnS1VjdFFWRVpYYWhFSmRFNnY5M3hwaWN0b1ZhWjNtamhV?=
 =?utf-8?B?ZS9kMXY3Q2YyTXRQRGZ2ZW1kWjZ1VnI4cklWd2w4dWdkRFZIbE1QSzNJNCtN?=
 =?utf-8?B?ajk2bzEvdVJhazRrZzk0TGl6TkZoYXJPeHZGeTFUd09vZDhIdXdxeWU0RU9k?=
 =?utf-8?B?TWJHSWVsZGdhMmtFNHhBSkVOMTBsaDd1bDVxWk5QakJpNTlhZ3d6NkcxaVA5?=
 =?utf-8?B?ZGdmWHpISTk5NDVZQ2dNK25kZmFHbjh6bXZGNjNHNjExZ2pvbEdPMVJKYzJj?=
 =?utf-8?B?dndEanQ0UFVwRXhsSFp4S1gyOC9FRlNLZ25tYlVUcWs4R2ZMUHlCbFlsa21u?=
 =?utf-8?B?UWVRNVBkSmYzeUtxL1ZER3oxOHpDTWthaUpCKzBKcjNyeUJqYjZMZkZWMnc3?=
 =?utf-8?B?aExIa1R6Vk9NMU4welRKbVMwUXZ0QXkzc0x5ZUY3OTBMelN0MGd1L1ZIR0Ir?=
 =?utf-8?B?WCtOTEVibWs0ODZxVkUzUXhTSld1b0h3VWhvd0dHQ0tVb3UvVzFnN0Z4WHFL?=
 =?utf-8?B?dm1HN1gxdk5FRlgrdkk0STkzY3hhd3hhYWxZck9sZHM4YnpEdnNFM3QwNTRj?=
 =?utf-8?B?M3VMOE5JaTZNSk9lTmdsaWNEMEUybHJNQWwzM2hSbW41aU9xdGp5dllzUURQ?=
 =?utf-8?B?Sk5paktBTmdIcmJoRDVJcGhGYzFMcXpqSnBnRVBRZXdiNXhHMEpsQnFZdVo4?=
 =?utf-8?Q?fv8jNXG5DuusFJrEAxi5jsz3JynN5k3sjp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B860931B6CD28344B36B99ED3771A8AF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4929.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4379e783-70c1-41e7-a593-08d8b1cea9a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 23:07:23.9452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oXqt5ieVyBOwqfwpfu3TneTJa2Fapejf8vGUNlGe9xiKZdFJZqJSi3RglvC6GgJoCf7WceU3n54cKOICHCmisw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4994
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gT24gSmFuIDUsIDIwMjEsIGF0IDEwOjMzIEFNLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMDQ6MDY6NTNQ
TSArMDEwMCwgSGlua28gS29jZXZhciB3cm90ZToNCj4+IE9uIDEvNS8yMSAzOjIxIFBNLCBIaW5r
byBLb2NldmFyIHdyb3RlOg0KPj4+IE9uIDEvNS8yMSAxMjowMiBBTSwgS2VpdGggQnVzY2ggd3Jv
dGU6DQo+Pj4+IENoYW5nZXMgZnJvbSB2MToNCj4+Pj4gDQo+Pj4+ICAgIEFkZGVkIHJlY2VpdmVk
IEFja3MNCj4+Pj4gDQo+Pj4+ICAgIFNwbGl0IHRoZSBrZXJuZWwgcHJpbnQgaWRlbnRpZnlpbmcg
dGhlIHBvcnQgdHlwZSBiZWluZyByZXNldC4NCj4+Pj4gDQo+Pj4+ICAgIEFkZGVkIGEgcGF0Y2gg
Zm9yIHRoZSBwb3J0ZHJ2IHRvIGVuc3VyZSB0aGUgc2xvdF9yZXNldCBoYXBwZW5zIHdpdGhvdXQN
Cj4+Pj4gICAgcmVseWluZyBvbiBhIGRvd25zdHJlYW0gZGV2aWNlIGRyaXZlci4uDQo+Pj4+IA0K
Pj4+PiBLZWl0aCBCdXNjaCAoNSk6DQo+Pj4+ICAgIFBDSS9FUlI6IENsZWFyIHN0YXR1cyBvZiB0
aGUgcmVwb3J0aW5nIGRldmljZQ0KPj4+PiAgICBQQ0kvQUVSOiBBY3R1YWxseSBnZXQgdGhlIHJv
b3QgcG9ydA0KPj4+PiAgICBQQ0kvRVJSOiBSZXRhaW4gc3RhdHVzIGZyb20gZXJyb3Igbm90aWZp
Y2F0aW9uDQo+Pj4+ICAgIFBDSS9BRVI6IFNwZWNpZnkgdGhlIHR5cGUgb2YgcG9ydCB0aGF0IHdh
cyByZXNldA0KPj4+PiAgICBQQ0kvcG9ydGRydjogUmVwb3J0IHJlc2V0IGZvciBmcm96ZW4gY2hh
bm5lbA0KPj4gDQo+PiBJIHJlbW92ZWQgdGhlIHBhdGNoIDUvNSBmcm9tIHRoaXMgcGF0Y2ggc2Vy
aWVzLCBhbmQgYWZ0ZXIgdGVzdGluZyBhZ2FpbiwgaXQNCj4+IG1ha2VzIG15IHNldHVwIHJlY292
ZXIgZnJvbSB0aGUgaW5qZWN0ZWQgZXJyb3I7IHNhbWUgYXMgb2JzZXJ2ZWQgd2l0aCB2MQ0KPj4g
c2VyaWVzLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgbm90aWNlLiBVbmZvcnR1bmF0ZWx5IHRoYXQg
c2VlbXMgZXZlbiBtb3JlIGNvbmZ1c2luZyB0bw0KPiBtZSByaWdodCBub3cuIFRoYXQgcGF0Y2gg
c2hvdWxkbid0IGRvIGFueXRoaW5nIHRvIHRoZSBkZXZpY2VzIG9yIHRoZQ0KPiBkcml2ZXIncyBz
dGF0ZTsgaXQganVzdCBlbnN1cmVzIGEgcmVjb3ZlcnkgcGF0aCB0aGF0IHdhcyBzdXBwb3NlZCB0
bw0KPiBoYXBwZW4gYW55d2F5LiBUaGUgc3RhY2sgdHJhY2Ugc2F5cyByZXN0b3JpbmcgdGhlIGNv
bmZpZyBzcGFjZSBjb21wbGV0ZWQNCj4gcGFydGlhbGx5IGJlZm9yZSBnZXR0aW5nIHN0dWNrIGF0
IHRoZSB2aXJ0dWFsIGNoYW5uZWwgY2FwYWJpbGl0eSwgYXQNCj4gd2hpY2ggcG9pbnQgaXQgYXBw
ZWFycyB0byBiZSBpbiBhbiBpbmZpbml0ZSBsb29wLiBJJ2xsIHRyeSB0byBsb29rIGludG8NCj4g
aXQuIFRoZSBlbXVsYXRlZCBkZXZpY2VzIEkgdGVzdCB3aXRoIGRvbid0IGhhdmUgdGhlIFZDIGNh
cCBidXQgSSBtaWdodA0KPiBoYXZlIHJlYWwgZGV2aWNlcyB0aGF0IGRvLg0KDQpJ4oCZbSBub3Qg
c2VlaW5nIHRoZSBlcnJvciBlaXRoZXIgd2l0aCBWMiB3aGVuIHRlc3Rpbmcgd2l0aCBhcmUtaW5q
ZWN0IHVzaW5nIFJDRUNzIGFuZCBhbiBhc3NvY2lhdGVkIFJDaUVQLg0KDQpTZWFu
