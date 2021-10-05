Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF48421D9A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 06:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhJEEnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 00:43:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:57664 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhJEEnv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 00:43:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="224423098"
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="224423098"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 21:42:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,347,1624345200"; 
   d="scan'208";a="438544852"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 04 Oct 2021 21:42:01 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 4 Oct 2021 21:42:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 4 Oct 2021 21:42:01 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 4 Oct 2021 21:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fo3AZW8XCMS1dJ/2txdon5ECeuXU8OqTdQ9ysmItJwC/rBDFS3wF0z8dX8uHd/qENCkcaUAQlY0ArXTUfl1MZ5kWptVMCPzSg1vVWEoZVSdb9pLQSkXMQMnF+VLRSQ0lWyfCBuGA7svGQZl+kjfH5MYRTJLtJf1lR5bIJjyWd7k1B5uh9TLoHDaEXsPgheMovhXt7VTuTZ6Een03ljGRTiQaL0kdBZ1kvirnhsGOEqPg8oyom+Y6pCybYO95wQmdk1dQZpNBEizQEC5Z5St3qRAEMiIDFGGKb8CGVh61JW9FVkY6us9MwDeJH0BVPcTQNgWvLyXa7BA9h8Fflv+stw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuqXV0cQ8oSZGvGVEw4BPpNS2NwmI6cQJS9Cs4Xghk8=;
 b=RTHxsCL+VzUiT67Djv1WuQBxeex6DNcNcuqxQfe5PqPFKM6sGKS/WcuYRVDDj/k416KnNhb+fAXUTLMmpdypd7yrvR90lirZ0M5DGIUv4UWKyaPQKuIgQXAaO7fkgNVgoMssAAJPCDaprUnJkKE3NkMCzWYB4tR/Sc/2RkPrtFYiWwhPI4ANGXnNUpPTy1951BhuCcErOywBfZj3egng5KM04LUvdwbbKz9J4ZxpWvfXL3gudvweu7HhFkbv0DVYyDUCUc5dxo7DapOD6icmOV00kbnbnJECJqQMeYM0/q1aIKkPw+Iy0yICXYElwlLXxWh4wwNL6m8+MFro5RJs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuqXV0cQ8oSZGvGVEw4BPpNS2NwmI6cQJS9Cs4Xghk8=;
 b=myYQwGZFojq9ioGLU1HqbrBbGzqMc1vJIqpyIBsGlFhnKJJFphSjGqYuyQTlExbSje8iRPYEKpP00zA2/SPZl8STJI+ZJxrJNstWQ+q3LGBGR+3016tMvn+gJClbIs6NR/GiJwI0WPMHyA4ohI2zRv/DwdnzLpXcN/FAhqNJTD8=
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com (2603:10b6:a03:2d4::18)
 by BYAPR11MB2887.namprd11.prod.outlook.com (2603:10b6:a03:89::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 04:41:59 +0000
Received: from SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::1c99:cc97:391:1406]) by SJ0PR11MB5150.namprd11.prod.outlook.com
 ([fe80::1c99:cc97:391:1406%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 04:41:59 +0000
From:   "Williams, Dan J" <dan.j.williams@intel.com>
To:     "lukas@wunner.de" <lukas@wunner.de>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>
Subject: Re: [PATCH v3] Add support for PCIe SSD status LED management
Thread-Topic: [PATCH v3] Add support for PCIe SSD status LED management
Thread-Index: AQHXuaNVnPh3AZCSEEGy0Pu5cvFEbg==
Date:   Tue, 5 Oct 2021 04:41:59 +0000
Message-ID: <296643c42a14ff7789cd2892382de0d643bf7939.camel@intel.com>
References: <20210813213653.3760-1-stuart.w.hayes@gmail.com>
         <20210814062328.GA25723@wunner.de>
         <aa253bad-5de0-7a25-7cc0-56ebfc0b6828@gmail.com>
In-Reply-To: <aa253bad-5de0-7a25-7cc0-56ebfc0b6828@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.4 (3.40.4-1.fc34) 
authentication-results: wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 446b3d36-2b7f-40bb-457d-08d987ba780c
x-ms-traffictypediagnostic: BYAPR11MB2887:
x-microsoft-antispam-prvs: <BYAPR11MB2887FC16DFE7275C63B70B9FC6AF9@BYAPR11MB2887.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Su4HtDD1nkvWNSgc8a095owKIbOGUcgpvuPfRgb4qRpoYvzQ2h0fv4RG9+zRXy8NljP5uXumJwh90c6o9kR2kxa7ejyMzQayY8XL/hYXAZwDpdt33p3KzPxhob4k8vbHLjccyp2H4nRr2rUli3WWWWHAuRTvLF64/8jPNYqdw2RH8+tzTyxxRaSWqmy1pD1wNVymSKfmZpARgdtdSm6RtOq/7RLUj83LnIAMDKKpRfQDUA3OiVHQV+QkhmL6KhCc/erIkyyRF/4LzHlXWeKwAGZtnwaJKGDDwEbHCvAbtci9bgyIoBRzk0Rpd5JcUNOy5iW6IyNA6lfNy874WKBok5AiRhyNsjN4Vz6hVG7F/cdZto3MYIlJZIj47jQief6RiKQ/sLhsc2/f2BFx2pEWtsoyPmVKP97S+kmB61+1v6Xu1DVYTgmZYUjRUliOxsa/Ri9d3nAEwW3FOYklA/aPVb2A5HLHsn58kn/5oUiY0FJJZp90Bm697P2Ng+97EqK3EHMUogr3atvGQ/Aa4DHp04gnOZYdWvtFG0me4zb4Bu2g0aLy/CQq8lNV7Js0Tbe75nYGrx4l4OpsbTIU8qfwOT8oiDaZZcrzag3XXz9VTSJENskBzfAypGLiak9bFl8kk5LSqYOk6w9cIkbau1siLd8y7ubg9a+b0CZweqip6M9h59ASyXSBKkikAI7cDfAhKD0qkBoOw/quvrRfGFSGDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5150.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(8676002)(8936002)(86362001)(6506007)(91956017)(6512007)(66476007)(64756008)(26005)(66946007)(76116006)(66556008)(508600001)(38070700005)(2906002)(6486002)(38100700002)(316002)(71200400001)(110136005)(5660300002)(2616005)(36756003)(4326008)(122000001)(66446008)(54906003)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTlLTXp5M1hWRndCQ0tldFA5S1ZrbEZiQU8zTmNkWE02ZG1mOStZbDczcG52?=
 =?utf-8?B?d2lhYVk0NjRMaFRUWGNJbWtEZWtkMVN0ZGFVeUpHZ2U4OVNIbWkrK3MwMytx?=
 =?utf-8?B?OWxuaElGSHc4V09hc1FIS2lBUlhqVWNOT3k2SjJWby9CM0NTdGZJM2hCUHdk?=
 =?utf-8?B?VUZuaWNWMVE1VHExL0hNYndSSWdTMmNvTXpCSkY1RGFoQVpHREJ6QWhIZUlX?=
 =?utf-8?B?UklCR0J3dkh5Tks3L3dMWVRodHRmSGYydEptL2RKdkJtM21oNzhTYUQvS3Zx?=
 =?utf-8?B?aldLcHkreldDN2ZUYjBab2NyN0pKOW0zU1pubjkwVThJRE54djY3UUpaZkpH?=
 =?utf-8?B?VlpxYlNQQUwwOHp2VFZ4aFlTVjVydkFZWmJvVzZidUdYRloxVE8vNmpiMklp?=
 =?utf-8?B?SmViZHVFaVFpTEZhQ2VmZUdySUNQcXZHN0xWN0VZYTg2bXVGaDhQeFNBOEZs?=
 =?utf-8?B?V2RwT3pja2huUVJMVW1JVERHTXd4VmNjMWhoUGprbXVhY0xkbDY4eDVQSlp2?=
 =?utf-8?B?RGpFK1VEOERFNzVRMURLS1hidGlEeUFpWlZ1dXpWMktlNGxncUE2M1g4UUN2?=
 =?utf-8?B?MGJXcUNFOUZmWksxa2lWOTdid01rZzh5MVpPS1VCTE1ReENCTkp1TEUvUTFj?=
 =?utf-8?B?Wmp4cWRxUmF2VklpN3R4WFRBN0d5WVlqTWlGMytyNHhRSGR1b3J3SHhIUGxa?=
 =?utf-8?B?UGlMY083c05wcWxtaVdPV2NmQ0h4ZWRvK0NWMXhTdUE2RzN2dWlWMXM4OStB?=
 =?utf-8?B?REY3VkNlSWthNFZ6Ry8wK1lCL0RjblN6N3JxbXZ2TEJGSkpJZkVmN0VHTVJI?=
 =?utf-8?B?cWdJMENzaWRldVZObHQrakw4VHM1UFlsRnI5dXB1YjU4UUxzM1hNWjFnQXU1?=
 =?utf-8?B?cXZYU0FMU0tHMWNMRFVFdUlPUzZkYnBOZ0sxWEdULytYSHhMSERhbVRza0ZM?=
 =?utf-8?B?YU5pTWdoUW16b2VwTG1SUG5wRktnd1E4RXpFWTNqcnRzcjN4VXZVeUQyODh4?=
 =?utf-8?B?RnZjdXNwcHVuZzZOS1IyYXZWUVZHb210Z2FNZ1kwSllaWFY2NkhOcHNSSXBT?=
 =?utf-8?B?bkJkRG9rdDVRbXlVTDNlaGxTOE5ONjdqSVZkc21KWjVlS3AwSU5QRTZOWDNW?=
 =?utf-8?B?TEN4dkw3YXNKM1d3Qnd6aThhUzVtbWtSMzdIT0l1Z1pIRytqd2UyaEpDOTRY?=
 =?utf-8?B?T3hIVUNHUDZJOElJemt3OUJSeSs2WHVYV0lodFdxUHlsZzlDSVlwYm83QXNn?=
 =?utf-8?B?Yi9KV0lESFdUQlc1STFoMHNKZURCZXlrTW5qbHRwU1lQTzhHMGZxVjdoeXlE?=
 =?utf-8?B?eS9yUnZYMTdDME9VVy80L25ndkMzTFdwMlg2RHRQV1RaWmN6bUhUTWp5Uko0?=
 =?utf-8?B?Ukx2S05IcDBwaVd5UU80eEpGUnkwNGJhV3phKzVtT3ZIVnQvZXVXdnNqNkhR?=
 =?utf-8?B?VkkyeUdxVmZjK1J2UjlZNnlZTHZWQzFkbVdhSGxBRWdacUZ3c3V4TzYyRFZN?=
 =?utf-8?B?TkdmTnBjNE04TXNvazlueEExeHpzUGI4emprOXpQbkltYjEvS0RKd0c2R0dh?=
 =?utf-8?B?RlVPTDlKNlIrUTRUUDI4MldtQmJvbXE0bmFVSG54aE9yMlM3MjhaR0pPYjBF?=
 =?utf-8?B?K1JhNHRYZmY1YkdmbFBkVkx2akc5VWFGZkpveFcwSGt3d0hVcUlxK2Y0dGZC?=
 =?utf-8?B?cnRsT2tld0VnTko4NVAzWWV0SVBWZm1CbEVUZ0Q0b0pONEIvZEhsWjVra1pX?=
 =?utf-8?B?Tm9PNEpwNnF0R2kzNEN3NVJzZkxHRHNPWEVtTEtjL1k2TjBYZG8xRXJiWkpv?=
 =?utf-8?B?VHNvV1FsVEg5dTRMQkg1Zz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FCC8E635BE5713489F2348BE4754538A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5150.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446b3d36-2b7f-40bb-457d-08d987ba780c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 04:41:59.6267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfFaye5hJSyCkUdG2unuOatlkBVfGX1P5rOWe8bKy2B7bvwAfPGGKmZejhNnrgghViBJvWu1AkjhZPHMxUo6VHni+X/RfO/qE3PPrrzMwQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2887
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTEwLTA0IGF0IDEyOjQxIC0wNTAwLCBzdHVhcnQgaGF5ZXMgd3JvdGU6DQo+
IA0KPiANCj4gT24gOC8xNC8yMDIxIDE6MjMgQU0sIEx1a2FzIFd1bm5lciB3cm90ZToNCj4gPiBP
biBGcmksIEF1ZyAxMywgMjAyMSBhdCAwNTozNjo1M1BNIC0wNDAwLCBTdHVhcnQgSGF5ZXMgd3Jv
dGU6DQo+ID4gPiArc3RydWN0IG11dGV4IGRyaXZlX3N0YXR1c19kZXZfbGlzdF9sb2NrOw0KPiA+
ID4gK3N0cnVjdCBsaXN0X2hlYWQgZHJpdmVfc3RhdHVzX2Rldl9saXN0Ow0KPiA+IA0KPiA+IFNo
b3VsZCBiZSBkZWNsYXJlZCBzdGF0aWMuDQo+ID4gDQo+ID4gPiArY29uc3QgZ3VpZF90IHBjaWVf
c3NkX2xlZHNfZHNtX2d1aWQgPQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgR1VJRF9JTklUKDB4NWQ1
MjRkOWQsIDB4ZmZmOSwgMHg0ZDRiLA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDB4OGMsIDB4YjcsIDB4NzQsIDB4N2UsIDB4ZDUsIDB4MWUsIDB4MTksIDB4NGQpOw0K
PiA+IA0KPiA+IFNhbWUuDQo+ID4gDQo+ID4gPiArc3RydWN0IGRyaXZlX3N0YXR1c19sZWRfb3Bz
IGRzbV9kcml2ZV9zdGF0dXNfbGVkX29wcyA9IHsNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC5nZXRf
c3VwcG9ydGVkX3N0YXRlcyA9IGdldF9zdXBwb3J0ZWRfc3RhdGVzX2RzbSwNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoC5nZXRfY3VycmVudF9zdGF0ZXMgPSBnZXRfY3VycmVudF9zdGF0ZXNfZHNtLA0K
PiA+ID4gK8KgwqDCoMKgwqDCoMKgLnNldF9jdXJyZW50X3N0YXRlcyA9IHNldF9jdXJyZW50X3N0
YXRlc19kc20sDQo+ID4gPiArfTsNCj4gPiANCj4gPiBTYW1lLg0KPiA+IA0KPiANCj4gVGhhbmsg
eW91IQ0KPiANCj4gPiA+ICtzdGF0aWMgdm9pZCBwcm9iZV9wZGV2KHN0cnVjdCBwY2lfZGV2ICpw
ZGV2KQ0KPiA+ID4gK3sNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoC8qDQo+ID4gPiArwqDCoMKgwqDC
oMKgwqAgKiBUaGlzIGlzIG9ubHkgc3VwcG9ydGVkIG9uIFBDSWUgc3RvcmFnZSBkZXZpY2VzIGFu
ZCBQQ0llIHBvcnRzDQo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChwZGV2LT5jbGFzcyAhPSBQQ0lfQ0xBU1NfU1RPUkFHRV9FWFBSRVNTICYmDQo+ID4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGRldi0+Y2xhc3MgIT0gUENJX0NMQVNTX0JSSURHRV9Q
Q0kpDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuOw0KPiA+ID4g
K8KgwqDCoMKgwqDCoMKgaWYgKHBkZXZfaGFzX2RzbShwZGV2KSkNCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBhZGRfZHJpdmVfc3RhdHVzX2RldihwZGV2LCAmZHNtX2RyaXZl
X3N0YXR1c19sZWRfb3BzKTsNCj4gPiA+ICt9DQo+ID4gDQo+ID4gV2h5IGlzICZkc21fZHJpdmVf
c3RhdHVzX2xlZF9vcHMgcGFzc2VkIHRvIGFkZF9kcml2ZV9zdGF0dXNfZGV2KCk/DQo+ID4gSXQn
cyBhbHdheXMgdGhlIHNhbWUgYXJndW1lbnQuDQo+ID4gDQo+IA0KPiBCZWNhdXNlIEkgaG9wZSB0
aGlzIHdpbGwgYWxzbyBzdXBwb3J0IE5QRU0gYXMgd2VsbCwgc2luY2UgaXQgaXMgc28gDQo+IHNp
bWlsYXIgZXhjZXB0IGZvciB1c2luZyBhIFBDSWUgZXh0ZW5kZWQgY2FwYWJpbGl0eSBpbnN0ZWFk
IG9mIGEgX0RTTQ0KPiBtZXRob2QuIFRoaXMgd2lsbCBtYWtlIGl0IHZlcnkgZWFzeSB0byBhZGQg
dGhlIHN1cHBvcnQuLi4gSSBqdXN0IGRvbid0IA0KPiBoYXZlIGFueSBOUEVNIGhhcmR3YXJlIHll
dC4NCg0KSSdtIGludGVyZXN0ZWQgaW4gaGVscGluZyB0aGUgaW5mcmFzdHJ1Y3R1cmUgYWxvbmcg
c28gaXQgY2FuIGJlIHJldXNlZA0Kd2l0aCB0aGUgQ1hMIG1lbW9yeSBleHBhbmRlciBkcml2ZXIu
IEkgZXhwZWN0IHRoYXQgbGlrZSBtb3N0IHN1YnN5c3RlbXMNClBDSSBkb2VzIG5vdCBhY2NlcHQg
ZW5hYmxpbmcgd2l0aG91dCBhIHVzZXIuIEkuZS4gdGhlIE5QRU0gb3BlcmF0aW9ucw0KbmVlZCB0
byBiZSBpbmNsdWRlZCB0byBwcm92ZSBvdXQgdGhlIGluZnJhc3RydWN0dXJlIGlzIHN1aXRhYmxl
IHRvDQpzdXBwb3J0IGJvdGggTEVEIG1lY2hhbmlzbXMuDQoNCg0K
