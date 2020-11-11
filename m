Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE962AEA2E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 08:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgKKHam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 02:30:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:51152 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgKKHai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 02:30:38 -0500
IronPort-SDR: 4KKLWYtkMOfbfqfAqC6fU6CeXrmP0Lnk93II3Gj2wQKSrpctPHIQujV/sa0rtca3UnJJ5MdJkb
 AiI+xaxUTDcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="234275075"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="234275075"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 23:30:38 -0800
IronPort-SDR: oD3LTDIOJ7KQhkC+0v66qCq5kn4+9jf/vj3+0JHksKJAUsQl2DjQCtTUopwNajhVKSl54XMKc1
 bZozxvbv9q7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="323183072"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 10 Nov 2020 23:30:38 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Nov 2020 23:30:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Nov 2020 23:30:37 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 10 Nov 2020 23:30:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eWiuzZ9JBebki0Wocvlq84CR88Q3Qn98jdJd9SoFE6jtmIaCtgBm6khQ9Y0DX27G4X0/xctf+gpgzOQN786zmrMclfFFu3Sx2XtCLxmY+x/6uyFnPUmrspt3zXBfZVvleQtiQk+EwFTLKfuC5l7SYL+3/rBJ1wY9z7PERWHpFAOSEXDc+w1yEIeNgIlU5Ut8x+M/4PwwJXVuIFwamIKyFMmBwrD/ZxFNGqhVXVLSxItMIehGXMI53+Phjp4yjEVouP3+YgfmurpA2XsLQ2jeMORL5wrN3ZZNvq2iWv2EgIBdw4PV5bqbWw7usKdZgc0fmRsgJwljp+Nkzet60BuQsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IhR5ViETpxIZCnpFVpe/yFG9WUKOi1ItinHgr/zpLo=;
 b=e+ku9UTOSvji6jWxSs6smDrfnjkYjKjsVg5cXJtUIKqQ2XWhoKJh3e1+5xIRniarGX0IOoQ7pq5nmk5RPAMlsU37D9lEBWcj2RYZ6BLc+B1vfTrcoWihLe+Xhyp7uwYitbpzg1rBiwBnpuXesfvhDoZqRCLFjByRVNtX7NNGPEUM44foGHxjNJN6CDimGl7kboOL+WMS6K1OJyi1lqn+ZBQCpFAUn9jFPceAEeLNJAczoXqeHR1igXGDBoyn3E+4k2tDyqlmknK39GWd+uPj+cQKsiwapeZZiur2skH3+NVj1Jw8MhGCQBWRW6RrazyK7fCjRswTP1jywJpuXJPV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IhR5ViETpxIZCnpFVpe/yFG9WUKOi1ItinHgr/zpLo=;
 b=a0/0/CrNjXTdjbA1nq9qvihLmE1v1NnLvWHteNor53TiMBRCzeXD1JfUTPDMUpIp3j4E+IUNQHiopWUAiEBnQTW0X2kL1iaYY0npi91W2VkBg4eaZmGXPFCib4zD0ERKZnHNnKJsMPALRmvwyPta+Z0+D3ubkLVcRaXakTlRizA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4976.namprd11.prod.outlook.com (2603:10b6:a03:2d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 07:30:34 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::14fe:76f0:df82:d27f%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 07:30:34 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Topic: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Index: AQHWt+2uigGgJYIEAkacA1Kck/o98anCg4IAgAAFtoA=
Date:   Wed, 11 Nov 2020 07:30:34 +0000
Message-ID: <efe7500400db058e1460937fa2e90ded9c54ebe8.camel@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
         <20201111054356.793390-2-ben.widawsky@intel.com>
         <20201111071006.GB7829@infradead.org>
In-Reply-To: <20201111071006.GB7829@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.75]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7a04cea-26be-495c-8d96-08d88613ad8e
x-ms-traffictypediagnostic: SJ0PR11MB4976:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB49765F5B566BBE03F8CA0C40C7E80@SJ0PR11MB4976.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kgttTzoy54hVfhzPl80cxKjkkUEXMredpWYmqiWq8CqGd6tf5SgTlF/SnQ1xzwK74WL8sissaoK7+7EdkO9NLpl+M6XW2Ix1vsk1EyDA06LhWjLJ4RNe5/KAJ1dih+Gczky29ums48DpiY8AwO57yb0iEwcPxSdLZAlkWdrIoi8VtHbatLQWdwtRHegWEqWH2Z/fRSr0h6D6QOEw9ci8/EfeMp0/+NR0t3cUMY1P1Eiqew5iej+2KK0IHnp0WIDosjH7jRo4cPkeFQhvMbm+ptCnS2P0WBd5RD4pSBDgU/1+5RnQEwa/6yjJdFXweNcF0d3XgS7Tj2KS2q96+7MYZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(186003)(76116006)(5660300002)(64756008)(66446008)(66946007)(66556008)(66476007)(6512007)(2616005)(86362001)(316002)(91956017)(8936002)(54906003)(4326008)(8676002)(26005)(2906002)(478600001)(6486002)(6506007)(4001150100001)(110136005)(71200400001)(36756003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oDBhD13Lg2PWhP8Xb3J7jusZ+5UOZoUZknYh5BzCeAl0tN7vsGbwIWCKvUF1yNlJRlFT/iQ2q71zXxDAh7CxglWwm4OLRPnbI+6D+LFISvjiVla2FUKHLYE8V7MuGsFjHEPyAUZDlrDjJIaDLhW9zBc+Juhv3r5crDBiK51BI59c50HRo/75nMEEZF9XzugY2IBAgL6zC9UduSCIuBS3L7fOPkDCLarqvpnaLesltnCjiIG4JVXVH+Ur3qJnMiA1a6H47bAF2akKbYfy5KxmoxrszTBelOqxcbenl/QuDK7BU8ajBrOSYIm5Ed+a+P+Z/LmBImuWXqJqlGI6EJ+p3N522bHz4wDcANIP7nnEyJ8HWg/SwU2zvf1skKLTm8lvDSDPRbfiKxcYLTLBWIG/w2tQeWlabm18gQKMudzDpGqoYCcdpPYuhzGwg/aQokHdZwG76gZiV1WlRhEaesKy5pTvTFyij42caN2o2RUkKNEJqMN69DyOnT7Es7jvxi2nNIJRdZTfjMmVDcrtkdBWvU/nxzMlncq04x4vTW4vWeYhU/p53HUbNq8cSa2zAv2o/GJhp/wVL9KDqMYZqr9qFDpzFGBCO5ySyCbZk67gmCCadqGFeiZue5jIRW5Agqnf6Jo9goPTvDbWy997EcWiy3cBlD/ldBw5Ynz44BLhwjD/xSgIMxXd0/joySB3EjbtzwnJfQ+ooalGEkw7elrg9/SLsLv1hE6iyfCR948DDpktVgIsLyQUa44rfvVoluzUV7mQ7U92VFGUsevTHvvvdU+7ZmjEW0PcXKqq9bj9FzSbG/sxvq1pCazVbQEdVUfkVaoFxjwrc98GIsT241LS9J0FZsifvEdQ4j6e6FGbvzyXNZzEsbiHBZPbut4iGphPLU9etrecc0N4sJMZGkf7Uw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <993D43F3972A5844BF5B73A231369203@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a04cea-26be-495c-8d96-08d88613ad8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 07:30:34.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDr2RmMaKpPRHy4mt0emIL1dg9m2idzBCFswXzzfdyuiQBvcBuDq1EeQcNJ5ma8JmaMbHWxa/MiwO1bVjnqn/OnyWsIgiYsd2qHSVol2yDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4976
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTExIGF0IDA3OjEwICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBOb3YgMTAsIDIwMjAgYXQgMDk6NDM6NDhQTSAtMDgwMCwgQmVuIFdpZGF3
c2t5IHdyb3RlOg0KPiA+ICttZW51Y29uZmlnIENYTF9CVVMNCj4gPiArCXRyaXN0YXRlICJDWEwg
KENvbXB1dGUgRXhwcmVzcyBMaW5rKSBEZXZpY2VzIFN1cHBvcnQiDQo+ID4gKwloZWxwDQo+ID4g
KwkgIENYTCBpcyBhIGJ1cyB0aGF0IGlzIGVsZWN0cmljYWxseSBjb21wYXRpYmxlIHdpdGggUENJ
LUUsIGJ1dCBsYXllcnMNCj4gPiArCSAgdGhyZWUgcHJvdG9jb2xzIG9uIHRoYXQgc2lnbmFsbGlu
ZyAoQ1hMLmlvLCBDWEwuY2FjaGUsIGFuZCBDWEwubWVtKS4gVGhlDQo+ID4gKwkgIENYTC5jYWNo
ZSBwcm90b2NvbCBhbGxvd3MgZGV2aWNlcyB0byBob2xkIGNhY2hlbGluZXMgbG9jYWxseSwgdGhl
DQo+ID4gKwkgIENYTC5tZW0gcHJvdG9jb2wgYWxsb3dzIGRldmljZXMgdG8gYmUgZnVsbHkgY29o
ZXJlbnQgbWVtb3J5IHRhcmdldHMsIHRoZQ0KPiA+ICsJICBDWEwuaW8gcHJvdG9jb2wgaXMgZXF1
aXZhbGVudCB0byBQQ0ktRS4gU2F5ICd5JyB0byBlbmFibGUgc3VwcG9ydCBmb3INCj4gPiArCSAg
dGhlIGNvbmZpZ3VyYXRpb24gYW5kIG1hbmFnZW1lbnQgb2YgZGV2aWNlcyBzdXBwb3J0aW5nIHRo
ZXNlIHByb3RvY29scy4NCj4gPiArDQo+IA0KPiBQbGVhc2UgZml4IHRoZSBvdmVybHkgbG9uZyBs
aW5lcy4NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIGFjcGlfY3hsX2Rlc2NfaW5pdChzdHJ1Y3QgYWNw
aV9jeGxfZGVzYyAqYWNwaV9kZXNjLCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+IA0KPiBBbm90aGVy
IG92ZXJseSBsb25nIGxpbmUuDQoNCkhpIENocmlzdHBwaCwNCg0KSSB0aG91Z2h0IDEwMCBjb2wu
IGxpbmVzIHdlcmUgYWNjZXB0YWJsZSBub3cuDQoNCj4gDQo+ID4gK3sNCj4gPiArCWRldl9zZXRf
ZHJ2ZGF0YShkZXYsIGFjcGlfZGVzYyk7DQo+ID4gKwlhY3BpX2Rlc2MtPmRldiA9IGRldjsNCj4g
PiArfQ0KPiANCj4gQnV0IHRoaXMgaGVscGVyIHNlZW1zIHByZXR0eSBwb2ludGxlc3MgdG8gc3Rh
cnQgd2l0aC4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgYWNwaV9jeGxfcmVtb3ZlKHN0cnVjdCBhY3Bp
X2RldmljZSAqYWRldikNCj4gPiArew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gDQo+IFRo
ZSBlbXB0cnkgcmVtb3ZlIGNhbGxiYWNrIGlzIG5vdCBuZWVkZWQuDQoNCkFncmVlZCBvbiBib3Ro
IG9mIHRoZSBhYm92ZSBjb21tZW50cyAtIHRoZXNlIGFyZSBqdXN0IGJvaWxlcnBsYXRlIGZvcg0K
bm93LCBJIGV4cGVjdCB0aGV5IHdpbGwgZ2V0IGZpbGxlZCBpbiBpbiB0aGUgbmV4dCByZXZpc2lv
biBhcyBtb3JlDQpmdW5jdGlvbmFsaXR5IGdldHMgZmxlc2hlZCBvdXQuIElmIHRoZXkgYXJlIHN0
aWxsIGVtcHR5L25vLW9wIGJ5IHRoZW4gSQ0Kd2lsbCByZW1vdmUgdGhlbS4NCg0KPiANCj4gPiAr
LyoNCj4gPiArICogSWYvd2hlbiBDWEwgc3VwcG9ydCBpcyBkZWZpbmVkIGJ5IG90aGVyIHBsYXRm
b3JtIGZpcm13YXJlIHRoZSBrZXJuZWwNCj4gPiArICogd2lsbCBuZWVkIGEgbWVjaGFuaXNtIHRv
IHNlbGVjdCBiZXR3ZWVuIHRoZSBwbGF0Zm9ybSBzcGVjaWZpYyB2ZXJzaW9uDQo+ID4gKyAqIG9m
IHRoaXMgcm91dGluZSwgdW50aWwgdGhlbiwgaGFyZC1jb2RlIEFDUEkgYXNzdW1wdGlvbnMNCj4g
PiArICovDQo+ID4gK2ludCBjeGxfYnVzX3ByZXBhcmVkKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0K
PiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFkZXY7DQo+ID4gKwlzdHJ1Y3QgcGNp
X2RldiAqcm9vdF9wb3J0Ow0KPiA+ICsJc3RydWN0IGRldmljZSAqcm9vdDsNCj4gPiArDQo+ID4g
Kwlyb290X3BvcnQgPSBwY2llX2ZpbmRfcm9vdF9wb3J0KHBkZXYpOw0KPiA+ICsJaWYgKCFyb290
X3BvcnQpDQo+ID4gKwkJcmV0dXJuIC1FTlhJTzsNCj4gPiArDQo+ID4gKwlyb290ID0gcm9vdF9w
b3J0LT5kZXYucGFyZW50Ow0KPiA+ICsJaWYgKCFyb290KQ0KPiA+ICsJCXJldHVybiAtRU5YSU87
DQo+ID4gKw0KPiA+ICsJYWRldiA9IEFDUElfQ09NUEFOSU9OKHJvb3QpOw0KPiA+ICsJaWYgKCFh
ZGV2KQ0KPiA+ICsJCXJldHVybiAtRU5YSU87DQo+ID4gKw0KPiA+ICsJLyogVE9ETzogT1NDIGVu
YWJsaW5nICovDQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZ
TUJPTF9HUEwoY3hsX2J1c19wcmVwYXJlZCk7DQo+IA0KPiBXaGF0IGlzIHRoZSBwb2ludCBvZiB0
aGlzIGZ1bmN0aW9uPyAgSSBkb2Vzbid0IHJlYWx5IGRvIGFueXRoaW5nLA0KPiBub3QgZXZlbiBh
IENYTCBzcGVjaWZpYyBjaGVjay4gIA0KDQpUaGlzIGdldHMgYSBiaXQgbW9yZSBmbGVzaGVkIG91
dCBpbiBwYXRjaCAyLiBJIGtlcHQgdGhhdCBzZXBhcmF0ZSBzbw0KdGhhdCBpdCBpcyBlYXNpZXIg
dG8gcmV2aWV3IHRoZSBidWxrIG9mIHRoZSBfT1NDIHdvcmsgaW4gdGhhdCBwYXRjaA0Kd2l0aG91
dCB0aGlzIGRyaXZlciBib2lsZXJwbGF0ZSBnZXR0aW5nIGluIHRoZSB3YXkuDQoNCj4gDQo+ID4g
IA0KPiA+ICsvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiA+ICsgKg0KPiA+ICsgKiBDRURUIC0g
Q1hMIEVhcmx5IERpc2NvdmVyeSBUYWJsZSAoQUNQSSA2LjQpDQo+ID4gKyAqICAgICAgICBWZXJz
aW9uIDENCj4gPiArICoNCj4gPiArICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8NCj4gPiArDQo+IA0K
PiBQbGVhZSB1c2UgdGhlIG5vcm1hbCBMaW51eCBjb21tZW50IHN0eWxlLg0KPiANCj4gDQo+ID4g
KyNkZWZpbmUgQUNQSV9DRURUX0NIQlNfVkVSU0lPTl9DWEwxMSAgICAoMCkNCj4gPiArI2RlZmlu
ZSBBQ1BJX0NFRFRfQ0hCU19WRVJTSU9OX0NYTDIwICAgICgxKQ0KPiA+ICsNCj4gPiArLyogVmFs
dWVzIGZvciBsZW5ndGggZmllbGQgYWJvdmUgKi8NCj4gPiArDQo+ID4gKyNkZWZpbmUgQUNQSV9D
RURUX0NIQlNfTEVOR1RIX0NYTDExICAgICAoMHgyMDAwKQ0KPiA+ICsjZGVmaW5lIEFDUElfQ0VE
VF9DSEJTX0xFTkdUSF9DWEwyMCAgICAgKDB4MTAwMDApDQo+IA0KPiBObyBuZWVkIGZvciB0aGUg
YnJhY2VzLg0KDQpGb3IgYm90aCBvZiB0aGVzZSAtIHNlZSB0aGUgbm90ZSBpbiB0aGUgY29tbWl0
IG1lc3NhZ2UuIEkganVzdCBmb2xsb3dlZA0KdGhlIEFDUEkgaGVhZGVyJ3Mgc3R5bGUsIGFuZCB0
aGVzZSBodW5rcyBhcmUgb25seSBpbiB0aGlzIHNlcmllcyB0byBtYWtlDQppdCB1c2FibGUuIEkg
ZXhwZWN0IHRoZSAnYWN0dWFsJyBzdHJ1Y3QgZGVmaW5pdGlvbnMsIG5hbWluZyBldGMgd2lsbA0K
Y29tZSB0aHJvdWdoIEFDUElDQS4NCg0K
