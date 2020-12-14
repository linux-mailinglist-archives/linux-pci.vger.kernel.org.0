Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29122D987F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 14:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgLNNEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 08:04:05 -0500
Received: from mga12.intel.com ([192.55.52.136]:62975 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgLNNEE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Dec 2020 08:04:04 -0500
IronPort-SDR: ap4LWfMRPC7TqCgqFamfUeDmnbJ5fJafejmSplK+NOS/ESnVpvuiVpxAPsHa/7LoBPxd30+nTM
 1F9HvxkjIEWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="153931334"
X-IronPort-AV: E=Sophos;i="5.78,418,1599548400"; 
   d="scan'208";a="153931334"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 05:03:23 -0800
IronPort-SDR: 4UKxgAqfLOCsXgVwI8CeHnK9v1X9BK9ah/OXFUG3j6HDZlGwVNrpvdMe3aHrdrxZAJNaDYSrb7
 OfUopXwId5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,418,1599548400"; 
   d="scan'208";a="381650429"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 14 Dec 2020 05:03:23 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 05:03:23 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 05:03:23 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Dec 2020 05:03:23 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Dec 2020 05:03:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFgbnuxf7fxERv6wJzhcpaiwn00ABgHXfLqfTAyEkQz9XfqDxLu4OU7PRyo6lg7kCMuBu7eRfGj4FrTnqfMdhf0E19UfmpzLrFnjkgKW7gouP9Fzmpyglj6CpAL3fSjgpPruLTj2tE7cGwoTLT9C7nCX5c0rinhC/9NVPq07UybkyaLYs3itBID4FNZ1Evww593Hi9E6D4Wey+MZlwO+ll3rWr/CPPIKr8p2zoe2scX9T3+X4P6PRqOx7BqZQI/qHF2cqJ4Vj49iBtNrxqoaVcZ3rPj2cEBewHggxcknB5zfRPCPojAVAIwGlKu6VANPiRAh1fTIT+p3rnG1VWz7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Az+mzzMoh16rol2343Gv9Chqo48HXA11YkJQ+qBXM=;
 b=bC/o2vmhzzuskPg5SGHdXtdDoNM1lP+gM+3c9HCspGXXDRoLmObGsZwfmFXKnCoXg03FAly8zIkPR8+xUcLndJP0XMeyy3a/NbnkJNBei5sLpjVE48EWYwLMee5V8lkUpwt6nLGz5EaUGSb8ms0cPwVZ3vXLbxlLc9UkC7k9IOuYIpe6nXO8NQM3MH8JOOxV4/GjfJoyFfZvHrjjIQZVT9NlLuzFtxRCfEsiVn1NSeNsRmX60sINdDIY1L3XCIQjZrjfCsOV11R6R71MUt7brm53O1NbMWNA2WKdc6pb4rsWD4SEdbplQHdCaqDXRVWEumhLEd/AN+I2+bnAjWq7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6Az+mzzMoh16rol2343Gv9Chqo48HXA11YkJQ+qBXM=;
 b=k1+rUicIN+/ZVHWGwGN2AfNHRqUgETYxlbPDyqBA4iDiob+NteBWjCNp4YVcoaguNFY0YcnCIGKlg0KOqb0SK8XNnYMcbc3OX1BHiLtbH1J1q7ljHFMUr9T4xobNoBXapuSgdVcitKMXsYn70LC7P/5GZZ5kWhb/cOx3baU0a9Q=
Received: from DM6PR11MB3721.namprd11.prod.outlook.com (2603:10b6:5:142::10)
 by DM6PR11MB4674.namprd11.prod.outlook.com (2603:10b6:5:2a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 14 Dec
 2020 13:03:21 +0000
Received: from DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::51e0:f848:dadc:bc01]) by DM6PR11MB3721.namprd11.prod.outlook.com
 ([fe80::51e0:f848:dadc:bc01%4]) with mapi id 15.20.3654.025; Mon, 14 Dec 2020
 13:03:21 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Topic: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
Thread-Index: AQHWyH2DVYHOoTyqMkq+8UZvdgyABKnvHRsAgAAH7wCAAYLYAIAF8eLA
Date:   Mon, 14 Dec 2020 13:03:21 +0000
Message-ID: <DM6PR11MB3721054B20FE1853651B5E86DDC70@DM6PR11MB3721.namprd11.prod.outlook.com>
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201209181350.GB660537@robh.at.kernel.org>
 <20201209184214.GV4077@smile.fi.intel.com>
 <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com>
In-Reply-To: <CAL_JsqJA4Sx93rF_o+V-gPSHwuyAyf-aT96XpN-UCc3ayjDH+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [14.1.220.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6c80e15-0c3f-41e2-cbe2-08d8a030a227
x-ms-traffictypediagnostic: DM6PR11MB4674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB46747963A1495B8DCB7C8B81DDC70@DM6PR11MB4674.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: THVZeCyHDZqgT+S8KJYVLg7ubRWJoLNjIsCnamxvpD+CuAB6lEBgarepEOXPX0RvkPK++f9optbXHhr94EG7uRrXl/v+UcfrXnD4Iyi9w15pu3ECNk1ade6K3h6FbQTF59PN0XcB70HZ4BPiQ8WfnMbHFveB86FhgRnw80s+2ceuGOjH24j5r6nZsz7PwUZtoCbEs1fvhvF+bgxjz/oqXMamD1vsP+N/VbHs/0V/jse3By7sVQzhuuW/JdKoeP0Fb7Ihr0Giiuv+tESkRCwn37ZcuPzuuIEyxePeONcXVAocWnboEk80LraWUzp4F28lUX3k7iHRdG6c1o0BMQrV9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3721.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(508600001)(54906003)(55016002)(53546011)(7696005)(5660300002)(9686003)(26005)(83380400001)(52536014)(186003)(6506007)(110136005)(71200400001)(66446008)(64756008)(66556008)(66476007)(76116006)(8676002)(66946007)(8936002)(4326008)(33656002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MlhyVHZRTkw2TFpoZC96R0pXTmVaVDdsYXVlZTM5RVhaOHdoU2dFcTd6RW41?=
 =?utf-8?B?Y0E5dkNwR1h1YWszaCsyRG1Cd3lmeFp2VTR5d08rSDVMd1RVMTZUN0l1TEtN?=
 =?utf-8?B?STdEWUNkMkFpclFFTUdZRWsyWDBtTnJ4ck1oZSt0SEJ6WnQ2cU5PdS84akNW?=
 =?utf-8?B?KzFORlY2K2pDSnhWVnc5OGpsSitPNTE3QXJrNGFCV0pRYzFmRzJEcVFoSmhw?=
 =?utf-8?B?NzNMOVY0RnVvUHZZcGtEazJxVGFQRnF0WHRzYk9JYWFUdkw4RXp3V01NOS9h?=
 =?utf-8?B?QzFzZFkvb3RxdmxtbUFmWkVkRlNzZlUwL2ZxUVRjUVlnMG15UGlPVjdTSzZS?=
 =?utf-8?B?VjF2VkxTeTFJTFJVazB6MUkycy9kNlYrV2pnS05UT3ZCRGVmSnMxUWtHZC9T?=
 =?utf-8?B?SjIrRmZOejNYYkxMSHhWanhmcGVEcEp2bUZRNmllMUs2aWlGSWdzYTI0b1hE?=
 =?utf-8?B?TjNJdUpUVVJGVG91QkgvamxXU0t1TE9SOFk2WkxDTk1lbmNTNVNrSk9NSG1T?=
 =?utf-8?B?MDI5VStLMFBya2d0M0ZsUGJPb0VnMytDMk1ySWlqakorL0tvT1R6N25td1h5?=
 =?utf-8?B?R3RJV2xrSkh0ZXFybHpDOFpVMjBWSGRFbklBY1RudCs4N3VZclo2K29mT1Q5?=
 =?utf-8?B?RTFFdVY5a2JRbXNXdDdjUlVJUnhOZDY5ZlZEOXRJYTE3L25EMXl5NjBXZ1Rj?=
 =?utf-8?B?aW84ZTVoNU1xL3Y5SmVHdzVQam40akx3UVBZZklVZ2hoYUU3M25IUVROYm1H?=
 =?utf-8?B?Yjl5bG9GUmQwaGZXWkVXR3BhRUVzSXlaUTFTTkh5VVI4VEsxUUFvSnRCamdB?=
 =?utf-8?B?K0R3U2s1Y0QzS3RlWHZYWXdjcHpkejlrdkZmUE9kZE5aTVcwYU1wbjRXVTl3?=
 =?utf-8?B?cExhT2pJdHNna0d0SnBpd1BzQXVkczdvMFNOSS9wRjl4eHdzQlJnQXA4bkpr?=
 =?utf-8?B?VU9CWGFzNXp6TnpEOGZVUVJLK3JkUksvaE5hWFZzRW1zdzNPYWJJd0xwL0Z5?=
 =?utf-8?B?azJRVm0wdnJlVFhxRDZwY0MyMmFUQU1URnNhWjFwNm5URlJFMVdLRWIxWXJB?=
 =?utf-8?B?UTk1OUJPWjRCbmJLcDkwdzZjbjVhZ25Za0U5d0JFVzFUSXFzSnBiRjAycDBv?=
 =?utf-8?B?UjdYaGt2M1o2M3pZT1BRUWh6bFhldDNpM3lqYzNYaGtHbUs5WTl1TXY0dmEz?=
 =?utf-8?B?RU1RZE5VRXBIakNBcm5LU0tWQzJQeUxOQm5HMHpwOHhDbEp2OFJGbkJmSUMx?=
 =?utf-8?B?cFA1WENsVkUrWWtYakVkdkMyQ3ZTVjgrSjFLYy9pT2g2SnlwK01adHp2MmRS?=
 =?utf-8?Q?7tCMerdlUUnSw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3721.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c80e15-0c3f-41e2-cbe2-08d8a030a227
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 13:03:21.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEgZg86TPJhY0s5aCoWgGdtbXyNyrsnvSzf/hMCBPuzXBMjeNoCnESX+BcniLePwUoCQ2jNN05May0nhhlSwcYqygRIxvoG46WJGvohXC/uwq0dRkxQNRrp/uImnx+eE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4674
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iIGFuZCBBbmR5Lg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzIGFuZCBmZWVkYmFjay4g
QW5kIHNvcnJ5IGZvciBsYXRlIHJlcGx5Lg0KSSB3aWxsIGFuc3dlciB0aGUgZWFybGllciByZXZp
ZXcgaGVyZSBhbmQgYWRkIG15IHJlcGx5DQpvbiB0aGUgdHdvIG1hdHRlcnMgYmVsb3cuDQoNCklu
IHY0LCBJIHdpbGwNCi0gcmVtb3ZlIHRoZSBrZWVtYmF5X3BjaWVfe3JlYWRsLHdyaXRlbH0gd3Jh
cHBlcnMsDQotIHJlbW92ZSB0aGUgZGVhZCBjb2RlIHJlbGF0ZWQgdG8gdW51c2VkIGlycXMsIGFu
ZA0KLSBpbml0aWFsaXplIGVuYWJsZWQgaW50ZXJydXB0cyB0byBhIGtub3duIHN0YXRlLg0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtl
cm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTEsIDIwMjAgMTo0NyBBTQ0KPiBU
bzogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+
IENjOiBXYW4gTW9oYW1hZCwgV2FuIEFobWFkIFphaW5pZQ0KPiA8d2FuLmFobWFkLnphaW5pZS53
YW4ubW9oYW1hZEBpbnRlbC5jb20+OyBCam9ybiBIZWxnYWFzDQo+IDxiaGVsZ2Fhc0Bnb29nbGUu
Y29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBQQ0kN
Cj4gPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgTWFyayBHcm9zcw0KPiA8bWdyb3NzQGxpbnV4LmludGVsLmNvbT47IFJhamEgU3VicmFtYW5p
YW4sIExha3NobWkgQmFpDQo+IDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzJdIFBDSToga2VlbWJheTogQWRkIHN1cHBv
cnQgZm9yIEludGVsIEtlZW0gQmF5DQo+IA0KPiBPbiBXZWQsIERlYyA5LCAyMDIwIGF0IDEyOjQx
IFBNIEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29t
PiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgRGVjIDA5LCAyMDIwIGF0IDEyOjEzOjUwUE0gLTA2
MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBEZWMgMDIsIDIwMjAgYXQgMDM6
MzE6NTZQTSArMDgwMCwgV2FuIEFobWFkIFphaW5pZSB3cm90ZToNCj4gPg0KPiA+IC4uLg0KPiA+
DQo+ID4gPiA+ICtzdGF0aWMgdm9pZCBrZWVtYmF5X3BjaWVfbHRzc21fZW5hYmxlKHN0cnVjdCBr
ZWVtYmF5X3BjaWUgKnBjaWUsDQo+ID4gPiA+ICtib29sIGVuYWJsZSkgew0KPiA+ID4gPiArICAg
dTMyIHZhbDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgdmFsID0ga2VlbWJheV9wY2llX3JlYWRs
KHBjaWUsIFBDSUVfUkVHU19QQ0lFX0FQUF9DTlRSTCk7DQo+ID4gPiA+ICsgICBpZiAoZW5hYmxl
KQ0KPiA+ID4gPiArICAgICAgICAgICB2YWwgfD0gQVBQX0xUU1NNX0VOQUJMRTsNCj4gPiA+ID4g
KyAgIGVsc2UNCj4gPiA+ID4gKyAgICAgICAgICAgdmFsICY9IH5BUFBfTFRTU01fRU5BQkxFOw0K
PiA+ID4gPiArICAga2VlbWJheV9wY2llX3dyaXRlbChwY2llLCBQQ0lFX1JFR1NfUENJRV9BUFBf
Q05UUkwsIHZhbCk7DQo+ID4gPg0KPiA+ID4gSWYgdGhpcyBpcyB0aGUgb25seSBiaXQgaW4gdGhp
cyByZWdpc3RlciwgZG8geW91IHJlYWxseSBuZWVkIFJNVz8NCj4gPg0KPiA+IEkgdGhpbmsgaXQn
cyBzYWZlciB0aGFuIGRvIGRpcmVjdCB3cml0ZSBhbmQgaGF2ZSBzb21ldGhpbmcgd3Jvbmcgb24N
Cj4gPiBuZXh0IGdlbmVyYXRpb25zIG9mIGhhcmR3YXJlLg0KPiANCj4gV2UgaGF2ZSAyIEludGVs
IFNvQ3Mgd2l0aCAyIHNlcGFyYXRlIFBDSSBkcml2ZXJzIHNvIGZhciwgaXMgdGhhdCByZWFsbHkg
Z29pbmcgdG8NCj4gYmUgYSBjb25jZXJuPyA6KCAoVGhpcyBiaXQgaW4gcGFydGljdWxhciBpcyBT
eW5vcHN5cycNCj4gZmF1bHQuIFRoaXMgaXMgd2hhdCBoYXBwZW5zIHdoZW4gSVAgdmVuZG9ycyBq
dXN0IGdpdmUgeW91IHNpZ25hbHMgdG8gaG9vayB1cC4pDQo+IA0KPiBUaGVyZSdzIDIgb3RoZXIg
cmVhc29ucyB3aHkgdG8gbm90IGRvIGEgUk1XLiBUaGUgZmlybXdhcmUgb3IgYm9vdGxvYWRlcg0K
PiBjb3VsZCBhbHNvIGNoYW5nZSBob3cgdGhlIHJlZ2lzdGVyIGlzIGluaXRpYWxpemVkIHdoaWNo
IHlvdSBtYXkgb3IgbWF5IG5vdA0KPiB3YW50IGNoYW5nZWQgaW4gTGludXguICBTZWNvbmQsIGZv
ciBtYWludGFpbmluZyB0aGlzIGNvZGUgd2hlbiBhbnlvbmUNCj4gZmFtaWxpYXIgd2l0aCB0aGlz
IGgvdyBkaXNhcHBlYXJzLCBJJ2QgbGlrZSB0byBrbm93IGlmIHRoZXJlJ3Mgb3RoZXIgYml0cyBp
biB0aGlzDQo+IHJlZ2lzdGVyIEkgbWlnaHQgd2FudCB0byBjYXJlIGFib3V0Lg0KDQpMaWdodG5p
bmcgTW91bnRhaW4gYW5kIEtlZW0gQmF5IGJlbG9uZ3MgdG8gdHdvIGRpZmZlcmVudCBwcm9kdWN0
IGxpbmVzIGkuZS4NCkF0b20tYmFzZWQgZmFtaWx5IGFuZCBBUk0tYmFzZWQgZmFtaWx5LCB0YXJn
ZXRlZCBmb3IgZGlmZmVyZW50DQptYXJrZXQvcHVycG9zZS4gVW5mb3J0dW5hdGVseSwgSSBhbSB1
bmFibGUgdG8gcmV1c2Ugb3IgYWRhcHQgTEdNIFBDSWUgZHJpdmVyDQpjb2RlIGZvciBLTUIuDQoN
Ck9uIHRoZSBmaXJzdCBjb25jZXJuLCBmaXJtd2FyZSB3aWxsIGFsc28gY2hhbmdlIEJJVCg5KSBv
ZiB0aGlzIHJlZ2lzdGVyIGluIEVQDQptb2RlIG9ubHkgZHVyaW5nIGl0cyBpbml0aWFsaXphdGlv
bi4gUkMgbW9kZSBpcyBmdWxseSBpbml0aWFsaXplIGFuZCBjb250cm9sbGVkIGJ5DQpMaW51eC4g
VGhpcyBmdW5jdGlvbiBpcyBiZWluZyB1c2VkIG9ubHkgaW4ga2VlbWJheV9wY2llX3N0YXJ0X2xp
bmsoKSwgYW5kIEkgaGF2ZQ0KYWRkZWQgYW4gaWYgY29uZGl0aW9uIHRvIHJldHVybiAwIGlmIHRo
ZSBtb2RlIGlzIEVQIG1vZGUuDQoNCk9uIHRoZSBzZWNvbmQgY29uY2VybiwgdGhpcyBkcml2ZXIg
d2lsbCB0b3VjaCBCSVQoMCkgb25seSwgaW4gUkMgbW9kZS4NClRoaXMgZHJpdmVyIGRvZXMgbm90
IGNoYW5nZSB0aGlzIHJlZ2lzdGVyIGluIEVQIG1vZGUuDQoNCkhvcGUgbXkgZXhwbGFuYXRpb24g
Y2xlYXJzIHRoaXMgbWF0dGVyLg0KQW5kIEkgYmVsaWV2ZSB3ZSBjYW4ga2VlcCB0aGlzIHBpZWNl
IG9mIGNvZGUgYXMgaXQgaXMuDQoNCj4gDQo+ID4gPiA+ICtzdGF0aWMgaW50IGtlZW1iYXlfcGNp
ZV9lcF9yYWlzZV9pcnEoc3RydWN0IGR3X3BjaWVfZXAgKmVwLCB1OA0KPiBmdW5jX25vLA0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIHBjaV9lcGNfaXJxX3R5
cGUgdHlwZSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTE2IGlu
dGVycnVwdF9udW0pIHsNCj4gPiA+ID4gKyAgIHN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19w
Y2llX2Zyb21fZXAoZXApOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICBzd2l0Y2ggKHR5cGUpIHsN
Cj4gPiA+ID4gKyAgIGNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOg0KPiA+ID4gPiArICAgICAgICAg
ICAvKiBMZWdhY3kgaW50ZXJydXB0cyBhcmUgbm90IHN1cHBvcnRlZCBpbiBLZWVtIEJheSAqLw0K
PiA+ID4gPiArICAgICAgICAgICBkZXZfZXJyKHBjaS0+ZGV2LCAiTGVnYWN5IElSUSBpcyBub3Qg
c3VwcG9ydGVkXG4iKTsNCj4gPiA+ID4gKyAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
PiA+ICsgICBjYXNlIFBDSV9FUENfSVJRX01TSToNCj4gPiA+ID4gKyAgICAgICAgICAgcmV0dXJu
IGR3X3BjaWVfZXBfcmFpc2VfbXNpX2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0X251bSk7DQo+
ID4gPiA+ICsgICBjYXNlIFBDSV9FUENfSVJRX01TSVg6DQo+ID4gPiA+ICsgICAgICAgICAgIHJl
dHVybiBkd19wY2llX2VwX3JhaXNlX21zaXhfaXJxKGVwLCBmdW5jX25vLA0KPiBpbnRlcnJ1cHRf
bnVtKTsNCj4gPiA+ID4gKyAgIGRlZmF1bHQ6DQo+ID4gPiA+ICsgICAgICAgICAgIGRldl9lcnIo
cGNpLT5kZXYsICJVbmtub3duIElSUSB0eXBlICVkXG4iLCB0eXBlKTsNCj4gPiA+ID4gKyAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ICsgICB9DQo+ID4gPg0KPiA+ID4gRG9lc24n
dCB0aGUgbGFjayBvZiBhICdyZXR1cm4nIGdpdmUgYSB3YXJuaW5nPw0KPiA+DQo+ID4gV2hlcmU/
IEkgZG9uJ3Qgc2VlIGFueSBsYWNrIG9mIHJldHVybi4NCj4gDQo+IElzIHRoZSBjb21waWxlciBz
bWFydCBlbm91Z2ggdG8gcmVjb2duaXplIHRoYXQgd2l0aCBhIHJldHVybiBpbiBldmVyeSAnY2Fz
ZScNCj4gdGhhdCB3ZSBkb24ndCBuZWVkIGEgcmV0dXJuIGFmdGVyIHRoZSBzd2l0Y2g/IEkgd291
bGRuJ3QgaGF2ZSB0aG91Z2h0IHNvLCBidXQNCj4gSSBoYXZlbid0IGNoZWNrZWQuDQoNCkkgaGF2
ZSByZWJ1aWxkIHRoZSBjb2RlIHdpdGggVz0xIGFuZCBXPTMsIGFuZCBkbyBub3Qgc2VlIGNvbXBp
bGVyIHRocm93DQp3YXJuaW5nIHdpdGggcmVnYXJkcyB0byB0aGlzIHBpZWNlIG9mIGNvZGUuIEkg
YW0gdXNpbmcgZ2NjIHY5LjIuDQoNClNob3VsZCBJIGtlZXAgdGhlIGNvZGUgYXMgaXQgaXMgb3Ig
bWFrZSB0aGUgY2hhbmdlIGkuZS4gbW92ZSB0aGUgbGFzdCByZXR1cm4NCm91dHNpZGUgb2Ygc3dp
dGNoPw0KDQo+IA0KPiBSb2INCg0KQmVzdCByZWdhcmRzLA0KWmFpbmllDQo=
