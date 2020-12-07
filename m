Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DCF2D177E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGRYa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 12:24:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:49495 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgLGRYa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 12:24:30 -0500
IronPort-SDR: x6FBeS1QBTwbvXPW/RPFZ75VBmv98wb/d85WVXrU65WeVBXjUAetIfIWj/IfPwKiNkoVQfEhtb
 cDzFCC79sVrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="171166191"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="171166191"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 09:23:47 -0800
IronPort-SDR: QCphqcbZ3x70CLm8Wr3tXHEdLjfOOnzmk286HWy8AhG+A19cEoR8Z8UlycxYyC6bBBniErbaL5
 tLBuVdmPPhNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="541568462"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 07 Dec 2020 09:23:47 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 09:23:47 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 7 Dec 2020 09:23:46 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 7 Dec 2020 09:23:46 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 7 Dec 2020 09:23:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ug2buQ7kydgV5kty59/VqOAhwFgvkkbTLWT3Vu0aCUvHlwWBXTdtcHDyMfx3GbKT8xgeBAWuiXVOk2PF1qLwK/bsNDZBoVXdYVlilhnhcp4pnX0uRnZQ0Q76fk3Anz0rEHERb4y1LtEIeNtu92n9bumZKqnd9JpJ7Xty9/8PsGXDGEAhsk9lHJ3Pm6myreeKtS2jLf5ecXLO9m9nPZZ4AWrKPx99OUDKTNSKyRgT4RxMTGiX8dad5nAKnmRGTDDE17eK9WySGDHgwTc3x6i3i0mQK29TjdW10wnQ/Nx2sxEKsOrcfkSAbPxqNpTAZDa/ydBoZtXiVgW0MECpC8o8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4DJ5FFVqGldMVBTgUy57KsvuijgY70MMU0TZyQuwGs=;
 b=lJubn7VNgZloVXxqIfM5ARFirqEvKAe71drV03EsvDN2JgY51Sc4bxib/DoVa34wwZiFnmh7iQp1AQy9BYDXPEzsAVlzSkihiE4jvxF1zOKpzaLdRy1d1exDk6UGP0sIgmwdF4qVn147TOsgc4dlSvuEs5a6vMkuBuLvzisFCRrcT36/Zm/7rhzXWD1MDyTL3bnAMpmLfp+fAtcCDgGHkYLSBtUxTYPRnhwKCHhn+dASTQemokmJaz17QGvH1HZUKOtrgMO20VBjfSyqHGi6wUSi51v8mORk2NGxD4Y0BjWKp45wGFmoKmAIALxXgtAe2sKVIgA3+xF3Yj8CldNgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4DJ5FFVqGldMVBTgUy57KsvuijgY70MMU0TZyQuwGs=;
 b=pFqDtJe1Q0gTifvW3B5ScDAskG1B4pdWIerf9FKmqZuXYhQ9jMVIf7kGNAOsFBJ8xWQ4WNE+VoVxyhtEwW+2uA/0BpxPzvkzCVLBdYxnTsu2WryEQluvrU6rQjlPUfu7IzsnNhniS8iJeFbVKBfh4gOWUB/KZ1zrJOVM8P3YK18=
Received: from SJ0PR11MB4925.namprd11.prod.outlook.com (2603:10b6:a03:2df::13)
 by BY5PR11MB4369.namprd11.prod.outlook.com (2603:10b6:a03:1cb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 17:23:43 +0000
Received: from SJ0PR11MB4925.namprd11.prod.outlook.com
 ([fe80::3861:e47a:4287:e6b6]) by SJ0PR11MB4925.namprd11.prod.outlook.com
 ([fe80::3861:e47a:4287:e6b6%6]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 17:23:43 +0000
From:   "Kelley, Sean V" <sean.v.kelley@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "xerces.zhao@gmail.com" <xerces.zhao@gmail.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Linux List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Thread-Topic: [PATCH v12 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Thread-Index: AQHWv5rN3FuVUIpfDEeVuS6r9tww6ankiuyAgAASyYCAAYQuAIABIbiAgAHY7gCAAt+uAA==
Date:   Mon, 7 Dec 2020 17:23:43 +0000
Message-ID: <CA3EF234-9944-4847-BC24-BA7C9DC1CB94@intel.com>
References: <20201205213038.GA2093063@bjorn-Precision-5520>
In-Reply-To: <20201205213038.GA2093063@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.20.0.2.21)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [24.20.148.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bdabc1f-01b6-40f2-3355-08d89ad4d8ed
x-ms-traffictypediagnostic: BY5PR11MB4369:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4369404201CCD8559923DC18B2CE0@BY5PR11MB4369.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PZg6ssVYbDSFW2siS9OLGCONPDyXm7lOYtryALnyWedShctamvKzuE0Q+ixg2pmSzvhVTzYAaiGH8o4Ua87QgRPIb0FogAdj2GYLpWH1UsgOflTviTDZY7E/RcFdffokJ8CmvvGoBNhcJaglKTRNnQMWGEH77C8IqXT6V9+cudnaTpaGIX7HdFCbP/TnEfK4gfc1AnUmIMxmdgpnbGdXLqZQ7hyoRPsT08zD1ZhysOCrhgJbIb58ed7y8smSvrb8Tg7j8P87Srr0Mco0HfYxzwLXTCgysyu3yHc0P2Vu7+zCDGk10hXvXOHqhlyDrndrMEpqGJv0cHYBEYxmPXirt5W/6FySXSRZX+T5MAW/6m+5CDDb3LWHgO2GW+44wY1vsWIj7uji8aUfDSgcsuEFxNcKSV3JQ81fvbWBgjEJc+tfS23Zns2vktwGOn5/9sTmteDa+yK/Lj1z8NOX9I7xiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(186003)(6916009)(2906002)(66446008)(6512007)(83380400001)(36756003)(478600001)(76116006)(6486002)(66556008)(91956017)(6506007)(966005)(64756008)(8936002)(4326008)(33656002)(54906003)(86362001)(66946007)(26005)(2616005)(8676002)(5660300002)(316002)(53546011)(66476007)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cmNLUDZnaVpQYi94ZFdITkVkaVFjeHhBVUVZWCtBaTdPMVJMVnNTTENFYnRz?=
 =?utf-8?B?R2FORUVhWWtuOHNWaFBIYXhuMDNlaXkyZU5uT3JBd3dFTlBMdXVqT0RKd2p2?=
 =?utf-8?B?dEt3aGo5SU9OT09xa3YzVFJaM0w4YU5HU3hKTnU3RUtMQ0FQUG9vZ2JpRm05?=
 =?utf-8?B?eDRVUXdnbWxGVzhoN2xPeGxvdDZROHVhWjBUOXE4QmdqdTZ2VzdySmp6Wnlv?=
 =?utf-8?B?SkZ0SERHc3RjVldWUHdWQ0RPZHpmRy9kbEFnY1ZWdkl6dkx2MDBnNnozL2li?=
 =?utf-8?B?ZjJhcnhkZUVCVldZakd5QkQyNVlTZGhER0FWdG0xNUIxc0drTy9wKzhaQzM2?=
 =?utf-8?B?TWlEWEVOQmdMWk93a3VlT0ppeFo1MkZFU2ZJMiszZ3BmZ3BGem1PQ01iWWRV?=
 =?utf-8?B?cmZHR1dmRlFvSmdxVElsRUtSMjdRMXpMVVRCM3ZRRVJVdDRWSWJ0eHJrM29F?=
 =?utf-8?B?bTRXdCtQNmI4b1hlUitBR1E5clhmb1FjNENDaFJCSHNXQ1E1ZGFGZVhQaS9y?=
 =?utf-8?B?S3pQSy9SbDRtWG1XK3R3cWRTQWY2bEk4dnhCeStMUTlONm5zTEhlVFYxOWo4?=
 =?utf-8?B?OW5OQmxwYmRXTXlybGJQaVozMGF2VWdKN0Uyb1dCTHB0R2N5bFhkcXFsWXpn?=
 =?utf-8?B?SVczTStmZElveWNWMStJeXlrZ3ZSZDR6MG9wQUJxV0JGdUNLZlptbWttMmdx?=
 =?utf-8?B?WnBVSndQQzdnaEhETFEvdjNwMktERysvNXRwYmRlSGc5MDdkaTRUV29zeUVi?=
 =?utf-8?B?Q01lSE45aWFZL1ZZTDJEaWZMTllaSjkyNTlkZTJKRmdTVG94Z29Tb2Zhb1hi?=
 =?utf-8?B?NEFYWXAwTWFjSjlDNXphQ3NDcStzSXZzWFBDd2E4QjE3WHdnMHg0Vklrd0ly?=
 =?utf-8?B?bEpab3hKaEE1alRKSFBOMTdYaE41QlpvTWxwalhsWU8yUmJuZUx1cUhadFFv?=
 =?utf-8?B?SXJCbDl2NkphUGU1R2RrZDJnMXBOc0NqeHMvRkxRanZ2YWpiU1BQT2k2WFBx?=
 =?utf-8?B?M08zMm15K1duZ2k4aGJadWJJNkpEYjE3cTdhT0srczBUMmtsbW5iSE9RMlI1?=
 =?utf-8?B?WjNUdmJtRStLWGxYZkRHclpXRFFhMEd6bVRhWFlUQUo2WUk4YkJyblZOYXh5?=
 =?utf-8?B?dUEwYi9ZMTNFRFR0MGRqQnQyMldSYURDOGtOWDlYd2pVRjFGWmU0QmNEbm1F?=
 =?utf-8?B?S3BmaVZ1clN3amFUUDlUTlNGWExXOGtqTWUrK2FWcE1DQnhHYXNQWjlBd3Ji?=
 =?utf-8?B?M2pQbG8xUExEWEovaFQwbFZjUkVXTTlSNXY5c2I3bzV6VTNSbWRWa050TVAw?=
 =?utf-8?Q?Ng7xVCxEs0DGeamu5AAeZ536gO+WXX0rmi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <709299CACFF1D7478EB84601C580EC2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdabc1f-01b6-40f2-3355-08d89ad4d8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2020 17:23:43.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yW16duJrjPdSyPxRVn85P6vkltRU6cCaHbQ3GA7HrUaGXc/umFRVh6FBYrEcNfVQwa+6Qax/Zzu38svHTORnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4369
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNCj4gT24gRGVjIDUsIDIwMjAsIGF0IDE6MzAgUE0sIEJqb3JuIEhlbGdhYXMg
PGhlbGdhYXNAa2VybmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIERlYyAwNCwgMjAyMCBh
dCAwNToxNzo1OFBNICswMDAwLCBLZWxsZXksIFNlYW4gViB3cm90ZToNCj4+PiBPbiBEZWMgMywg
MjAyMCwgYXQgNDowMSBQTSwgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90
ZToNCj4+PiBPbiBUaHUsIERlYyAwMywgMjAyMCBhdCAxMjo1MTo0MEFNICswMDAwLCBLZWxsZXks
IFNlYW4gViB3cm90ZToNCj4+Pj4+IE9uIERlYyAyLCAyMDIwLCBhdCAzOjQ0IFBNLCBCam9ybiBI
ZWxnYWFzIDxoZWxnYWFzQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4gT24gRnJpLCBOb3YgMjAs
IDIwMjAgYXQgMDQ6MTA6MzNQTSAtMDgwMCwgU2VhbiBWIEtlbGxleSB3cm90ZToNCj4+Pj4+PiBG
cm9tOiBRaXV4dSBaaHVvIDxxaXV4dS56aHVvQGludGVsLmNvbT4NCj4+Pj4+PiANCj4+Pj4+PiBX
aGVuIGF0dGVtcHRpbmcgZXJyb3IgcmVjb3ZlcnkgZm9yIGFuIFJDaUVQIGFzc29jaWF0ZWQgd2l0
aCBhbiBSQ0VDIGRldmljZSwNCj4+Pj4+PiB0aGVyZSBuZWVkcyB0byBiZSBhIHdheSB0byB1cGRh
dGUgdGhlIFJvb3QgRXJyb3IgU3RhdHVzLCB0aGUgVW5jb3JyZWN0YWJsZQ0KPj4+Pj4+IEVycm9y
IFN0YXR1cyBhbmQgdGhlIFVuY29ycmVjdGFibGUgRXJyb3IgU2V2ZXJpdHkgb2YgdGhlIHBhcmVu
dCBSQ0VDLiAgSW4NCj4+Pj4+PiBzb21lIG5vbi1uYXRpdmUgY2FzZXMgaW4gd2hpY2ggdGhlcmUg
aXMgbm8gT1MtdmlzaWJsZSBkZXZpY2UgYXNzb2NpYXRlZA0KPj4+Pj4+IHdpdGggdGhlIFJDaUVQ
LCB0aGVyZSBpcyBub3RoaW5nIHRvIGFjdCB1cG9uIGFzIHRoZSBmaXJtd2FyZSBpcyBhY3RpbmcN
Cj4+Pj4+PiBiZWZvcmUgdGhlIE9TLg0KPj4+Pj4+IA0KPj4+Pj4+IEFkZCBoYW5kbGluZyBmb3Ig
dGhlIGxpbmtlZCBSQ0VDIGluIEFFUi9FUlIgd2hpbGUgdGFraW5nIGludG8gYWNjb3VudA0KPj4+
Pj4+IG5vbi1uYXRpdmUgY2FzZXMuDQo+Pj4+Pj4gDQo+Pj4+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBT
ZWFuIFYgS2VsbGV5IDxzZWFuLnYua2VsbGV5QGludGVsLmNvbT4NCj4+Pj4+PiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAxMDAyMTg0NzM1LjEyMjkyMjAtMTItc2VhbnZrLmRl
dkBvcmVnb250cmFja3Mub3JnDQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogU2VhbiBWIEtlbGxleSA8
c2Vhbi52LmtlbGxleUBpbnRlbC5jb20+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUWl1eHUgWmh1
byA8cWl1eHUuemh1b0BpbnRlbC5jb20+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4+Pj4+PiBSZXZpZXdlZC1ieTogSm9uYXRoYW4g
Q2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+
IGRyaXZlcnMvcGNpL3BjaWUvYWVyLmMgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4+Pj4+PiBkcml2ZXJzL3BjaS9wY2llL2Vyci5jIHwgMjAgKysrKysr
KysrLS0tLS0tLS0tDQo+Pj4+Pj4gMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAy
MiBkZWxldGlvbnMoLSkNCj4+Pj4+PiANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
cGNpZS9hZXIuYyBiL2RyaXZlcnMvcGNpL3BjaWUvYWVyLmMNCj4+Pj4+PiBpbmRleCAwYmEwYjQ3
YWU3NTEuLjUxMzg5YTZlZTRjYSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9kcml2ZXJzL3BjaS9wY2ll
L2Flci5jDQo+Pj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KPj4+Pj4+IEBAIC0x
MzU4LDI5ICsxMzU4LDUxIEBAIHN0YXRpYyBpbnQgYWVyX3Byb2JlKHN0cnVjdCBwY2llX2Rldmlj
ZSAqZGV2KQ0KPj4+Pj4+ICovDQo+Pj4+Pj4gc3RhdGljIHBjaV9lcnNfcmVzdWx0X3QgYWVyX3Jv
b3RfcmVzZXQoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+Pj4+PiB7DQo+Pj4+Pj4gLQlpbnQgYWVy
ID0gZGV2LT5hZXJfY2FwOw0KPj4+Pj4+ICsJaW50IHR5cGUgPSBwY2lfcGNpZV90eXBlKGRldik7
DQo+Pj4+Pj4gKwlzdHJ1Y3QgcGNpX2RldiAqcm9vdDsNCj4+Pj4+PiArCWludCBhZXIgPSAwOw0K
Pj4+Pj4+ICsJaW50IHJjID0gMDsNCj4+Pj4+PiAJdTMyIHJlZzMyOw0KPj4+Pj4+IC0JaW50IHJj
Ow0KPj4+Pj4+IA0KPj4+Pj4+IC0JaWYgKHBjaWVfYWVyX2lzX25hdGl2ZShkZXYpKSB7DQo+Pj4+
Pj4gKwlpZiAodHlwZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRU5EKQ0KPj4+Pj4+ICsJCS8qDQo+Pj4+
Pj4gKwkJICogVGhlIHJlc2V0IHNob3VsZCBvbmx5IGNsZWFyIHRoZSBSb290IEVycm9yIFN0YXR1
cw0KPj4+Pj4+ICsJCSAqIG9mIHRoZSBSQ0VDLiBPbmx5IHBlcmZvcm0gdGhpcyBmb3IgdGhlDQo+
Pj4+Pj4gKwkJICogbmF0aXZlIGNhc2UsIGkuZS4sIGFuIFJDRUMgaXMgcHJlc2VudC4NCj4+Pj4+
PiArCQkgKi8NCj4+Pj4+PiArCQlyb290ID0gZGV2LT5yY2VjOw0KPj4+Pj4+ICsJZWxzZQ0KPj4+
Pj4+ICsJCXJvb3QgPSBkZXY7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICsJaWYgKHJvb3QpDQo+Pj4+Pj4g
KwkJYWVyID0gZGV2LT5hZXJfY2FwOw0KPj4+Pj4+ICsNCj4+Pj4+PiArCWlmICgoYWVyKSAmJiBw
Y2llX2Flcl9pc19uYXRpdmUoZGV2KSkgew0KPj4+Pj4+IAkJLyogRGlzYWJsZSBSb290J3MgaW50
ZXJydXB0IGluIHJlc3BvbnNlIHRvIGVycm9yIG1lc3NhZ2VzICovDQo+Pj4+Pj4gLQkJcGNpX3Jl
YWRfY29uZmlnX2R3b3JkKGRldiwgYWVyICsgUENJX0VSUl9ST09UX0NPTU1BTkQsICZyZWczMik7
DQo+Pj4+Pj4gKwkJcGNpX3JlYWRfY29uZmlnX2R3b3JkKHJvb3QsIGFlciArIFBDSV9FUlJfUk9P
VF9DT01NQU5ELCAmcmVnMzIpOw0KPj4+Pj4+IAkJcmVnMzIgJj0gflJPT1RfUE9SVF9JTlRSX09O
X01FU0dfTUFTSzsNCj4+Pj4+PiAtCQlwY2lfd3JpdGVfY29uZmlnX2R3b3JkKGRldiwgYWVyICsg
UENJX0VSUl9ST09UX0NPTU1BTkQsIHJlZzMyKTsNCj4+Pj4+PiArCQlwY2lfd3JpdGVfY29uZmln
X2R3b3JkKHJvb3QsIGFlciArIFBDSV9FUlJfUk9PVF9DT01NQU5ELCByZWczMik7DQo+Pj4+Pj4g
CX0NCj4+Pj4+PiANCj4+Pj4+PiAtCXJjID0gcGNpX2J1c19lcnJvcl9yZXNldChkZXYpOw0KPj4+
Pj4+IC0JcGNpX2luZm8oZGV2LCAiUm9vdCBQb3J0IGxpbmsgaGFzIGJlZW4gcmVzZXQgKCVkKVxu
IiwgcmMpOw0KPj4+Pj4+ICsJaWYgKHR5cGUgPT0gUENJX0VYUF9UWVBFX1JDX0VDIHx8IHR5cGUg
PT0gUENJX0VYUF9UWVBFX1JDX0VORCkgew0KPj4+Pj4+ICsJCWlmIChwY2llX2hhc19mbHIoZGV2
KSkgew0KPj4+Pj4+ICsJCQlyYyA9IHBjaWVfZmxyKGRldik7DQo+Pj4+Pj4gKwkJCXBjaV9pbmZv
KGRldiwgImhhcyBiZWVuIHJlc2V0ICglZClcbiIsIHJjKTsNCj4+Pj4+IA0KPj4+Pj4gTWF5YmU6
DQo+Pj4+PiANCj4+Pj4+ICsgICAgICAgICAgICAgfSBlbHNlIHsNCj4+Pj4+ICsgICAgICAgICAg
ICAgICAgICAgICByYyA9IC1FTk9UVFk7DQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgcGNp
X2luZm8oZGV2LCAibm90IHJlc2V0IChubyBGTFIgc3VwcG9ydClcbiIpOw0KPj4+Pj4gDQo+Pj4+
PiBPciBkbyB3ZSB3YW50IHRvIHByZXRlbmQgdGhlIGRldmljZSB3YXMgcmVzZXQgYW5kIHJldHVy
bg0KPj4+Pj4gUENJX0VSU19SRVNVTFRfUkVDT1ZFUkVEPw0KPj4+PiANCj4+Pj4gV2UgYXJlIGN1
cnJlbnRseSBkb2luZyB0aGUgbGF0dGVyIG5vdyB3aXRoIHRoZSBkZWZhdWx0IG9mIHJjID0gMA0K
Pj4+PiBhYm92ZSBhbmQgc28gIEnigJltIG5vdCBzdXJlIHRoZSBleHRyYSBkZXRhaWwgaGVyZSBv
biB0aGUgYWJzZW5jZSBvZg0KPj4+PiBGTFIgc3VwcG9ydCBpcyBvZiB2YWx1ZS4NCj4+PiANCj4+
PiBTbyB0byBtYWtlIHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBwcm9wb3NhbCBoZXJlLCBmb3IgUkNF
Q3MgYW5kIFJDaUVQcw0KPj4+IHRoYXQgZG9uJ3Qgc3VwcG9ydCBGTFIsIHlvdSdyZSBzYXlpbmcg
eW91IHdhbnQgdG8gY29udGludWUgc2lsZW50bHkNCj4+PiBhbmQgcmV0dXJuIFBDSV9FUlNfUkVT
VUxUX1JFQ09WRVJFRCBhbmQgbGV0IHRoZSBkcml2ZXJzIGFzc3VtZSB0aGVpcg0KPj4+IGRldmlj
ZSB3YXMgcmVzZXQgd2hlbiBpdCB3YXMgbm90Pw0KPj4gDQo+PiBUaGUgc2V0dGluZyBvZiB0aGUg
4oCYcmPigJkgb24gdGhlIEZMUiBzdXBwb3J0IGlzIGZpbmUgdG8gYWRkIHRvIHRoZQ0KPj4gZWxz
ZSBjb25kaXRpb24uICBJIGhhZCBzaW1wbHkgcmVjYWxsZWQgaW4gZWFybGllciBkaXNjdXNzaW9u
IHRoYXQNCj4+IHBjaWVfaGFzX2ZscigpIHdhcyBuZWVkZWQgZHVlIHRvIHF1aXJreSBiZWhhdmlv
ciBpbiBzb21lIGhhcmR3YXJlDQo+PiBhbmQgc28gd2FzIG5vdCBzdXJlIHRoYXQgZGV0YWlsIG9m
IGhhdmluZyBvciBub3QgaGF2aW5nIGZsciB3YXMgaW4NCj4+IGZhY3QgY29uc2l0ZW50L2FjY3Vy
YXRlLg0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQgZG8gdGhlIGZvbGxvd2luZywgdW5sZXNzIHlv
dSBvYmplY3Q6DQo+IA0KPiAgICBpZiAodHlwZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRUMgfHwgdHlw
ZSA9PSBQQ0lfRVhQX1RZUEVfUkNfRU5EKSB7DQo+IAkgICAgaWYgKHBjaWVfaGFzX2ZscihkZXYp
KSB7DQo+IAkJICAgIHJjID0gcGNpZV9mbHIoZGV2KTsNCj4gCQkgICAgcGNpX2luZm8oZGV2LCAi
aGFzIGJlZW4gcmVzZXQgKCVkKVxuIiwgcmMpOw0KPiAJICAgIH0gZWxzZSB7DQo+IAkJICAgIHBj
aV9pbmZvKGRldiwgIm5vdCByZXNldCAobm8gRkxSIHN1cHBvcnQpXG4iKTsNCj4gCQkgICAgcmMg
PSAtRU5PVFRZOw0KPiAJICAgIH0NCj4gICAgfSBlbHNlIHsNCj4gCSAgICByYyA9IHBjaV9idXNf
ZXJyb3JfcmVzZXQoZGV2KTsNCj4gCSAgICBwY2lfaW5mbyhkZXYsICJSb290IFBvcnQgbGluayBo
YXMgYmVlbiByZXNldCAoJWQpXG4iLCByYyk7DQo+ICAgIH0NCj4gICAgLi4uDQo+ICAgIHJldHVy
biByYyA/IFBDSV9FUlNfUkVTVUxUX0RJU0NPTk5FQ1QgOiBQQ0lfRVJTX1JFU1VMVF9SRUNPVkVS
RUQ7DQo+IA0KPiBTb3JyeSwgSSBzaG91bGQgaGF2ZSBkb25lIHRoYXQgaW4gdGhlIHByb3Bvc2Vk
IHBhdGNoIGVhcmxpZXI7IGl0J3MNCj4gd2hhdCBJIHdhcyAqdGhpbmtpbmcqIGJ1dCBkaWRuJ3Qg
Z2V0IGl0IHRyYW5zY3JpYmVkIGludG8gdGhlIGNvZGUuDQoNCg0KTG9va3MgZ29vZCB0byBtZS4N
Cg0KVGhhbmtzLA0KDQpTZWFuDQoNCg0KPiANCj4gQmpvcm4NCg0K
