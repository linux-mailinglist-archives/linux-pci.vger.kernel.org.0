Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E16F2FD959
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 20:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392253AbhATTTA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 14:19:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:6650 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392171AbhATTSx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Jan 2021 14:18:53 -0500
IronPort-SDR: 52vEyCIC4UQIk2h4temuO5kVOdFhTAJCZVGix2xA0Z77a497stFj8SOThXwpQulP13y7FM/WIJ
 2FapSEl23N4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="179315151"
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="179315151"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 11:18:08 -0800
IronPort-SDR: U5SnnSvxYuAX+mjgmfwYWGROruGXPaPj58a4fXUk7mN9V+wY5u+Stfpkb0YhczAl4yPn+FTubS
 yr8mbTBZwtCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="347655420"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jan 2021 11:18:07 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 11:18:06 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 Jan 2021 11:18:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 20 Jan 2021 11:18:06 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 20 Jan 2021 11:18:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5fT2rk7L+uV3MiDzvUDpbLEPeyLZwm2OlBVhnRVDo6vVj9ftqB03QIObubQn7c877CNMuFSjP3uAJJxOU+aY9cUNt4in7VMlHr53Hj1ocbpuyyEX3RKWFEMl/TXYmbjszXWt4RVH6zinO1/IcVF3g5qaGmsvxYn+G0dzsWyiTgV/CyHonF76bOcU02i4UJycJJn5eFIo3SiS4XIAmfVG/F90pqlttMN0NAXn9FmRT6oKZ6QFTqOincekMVsqpArL+LA2tll82LfBSbcjHE5VqjdZqPgqHMCuAfammSwFQNy4up48MSVdmqYuGsgpKuFMRrsGM0KhtgTfsDtVl9Ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1FSUDcnVlqT92H1ag1/+suzQ0UbsGaVnSEDGrcjh38=;
 b=NR8nM9dMkHG3ekrJppGSVg3YV8UsINW44GdzF4G9K0D/EOOhA+63Xu8atP/VQUnoHydTFmqdAs3iGiQWMPjnratpiGI+kbatQVVXqWUail6eNB3ZbynFtqf/rg2rlHYa56uE1L0xjJ6Uv5peaDHb/cnIy43XmOK8kTIl/udfjaWPubMg1CA6Bx/XiV/oxkQwwXm3iYMEbxganToecddrKu5guwhJVZ282umgVjsaBYG0FHaj4mjZpr96zxDnaggKRpakHEGc8xcSAfiM++y5zB8UXayc6edR38NA1Qa0jCCaLxK61t7L8iYvr7OlPmBe7PpgXbPS8wYpZWDEMmEJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1FSUDcnVlqT92H1ag1/+suzQ0UbsGaVnSEDGrcjh38=;
 b=q5ilajHbh3q5qQklhUFU/SnBiPvkUK24b/ZCxfol1Cn3rZxYuJJMhydFEy2SRIeQaXganXQFWtHbMtL38K1K1JV2e7aq2JslRQtgSdrcfmPfQZR4PJOf6Xz73WZemr5iNl6OiGNBvzOBFZTBrFaZLzBIH3UYtVSu7GmPrZ10sdA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2838.namprd11.prod.outlook.com (2603:10b6:a02:cc::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 19:18:02 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::8004:3bed:cc13:e8ae%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 19:18:02 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "jcm@jonmasters.org" <jcm@jonmasters.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Topic: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the
 CXL interconnect
Thread-Index: AQHW6GxRPbm+jgT4lkCUw1EQEEK1kqokVOmAgAycLoA=
Date:   Wed, 20 Jan 2021 19:18:02 +0000
Message-ID: <8d276868a0516f77864d1a1f41eeb0b091aced98.camel@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
         <20210111225121.820014-3-ben.widawsky@intel.com>
         <20210112184355.00007632@Huawei.com>
In-Reply-To: <20210112184355.00007632@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 (3.38.2-1.fc33) 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4eabce27-f988-45bc-fe7a-08d8bd781b78
x-ms-traffictypediagnostic: BYAPR11MB2838:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2838EAD39D98B99882C885B1C7A29@BYAPR11MB2838.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oKHEUn1rtmSQO5urcUBiuXfkxAe3/+lSUm5Tu18c+CIsnwJ83VvUUHyXm5/iWYWk6FEPacrkZ88t94uL4ruk+O7ECt8Fy69bjsYZ6BUUUOuE6N404uy8K54ddNnKBjHwyEL0N71K3msaXOOUYLavW/IsqqckUjEk35DAElNpwsgVusyz8puUEzLQINbgAnBGRnz98NbSacoMCBiM7a0EbcnewfhFO71GbPGo4uY7EXAGFUg4MraJSDA5O31a/QcjWjqG9H1LL78i8M6QxXuxkwRFO+Ne9+cc3IwXrho4EGXbuOH7VtCD5x93jBtpwZjN8YOEjqEWQ7wrVSIzT4+BjZXVJSnADSHatCSYwzr4VP5GdazTrdotLdzduo1x7FmUhu9ib68SSt8NkzXXvi2wYyQKwwEiB+xRI7fHtmJJA0rDC+2O3dZzTXD0DxtnCuE/qARf0fP/URuAdrmRxeAgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3448.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(8676002)(966005)(6486002)(54906003)(8936002)(4326008)(6506007)(66476007)(86362001)(478600001)(76116006)(7416002)(71200400001)(66946007)(110136005)(2906002)(66556008)(66446008)(64756008)(316002)(36756003)(6512007)(26005)(186003)(83380400001)(5660300002)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U0Q3WEpGdXJhU1JWWHVnaHpGczljME4rVWtINTFkVlN6MGh6SFpZdVdKeHkw?=
 =?utf-8?B?QW1QVFlSUkNBN01abkQyUGl6UE0ySmlibnNrNUpOQ3JmQWRuM2VDN2ZPb2JR?=
 =?utf-8?B?dXgydm83Z0FaelhjeEc1ZkN3ZEZOL2IrVnZBQTRNTm93eGdEL2t1RUJiRVpz?=
 =?utf-8?B?Q0YzdXJyblc5TUdVRGljekl1dmxLZVRsNXo1UVhYcWM0eVR4emZ1VmlqZXF5?=
 =?utf-8?B?MlhCdWVzbFpwOGlKb2pGM0h5U3B6TjBpWkR4L25JaFArUjFtNitjSm9nbEE2?=
 =?utf-8?B?YTE5bXgxcjVvSVVQbENNYi9zWHZzSVlyVG5HeWJlTmhGVUZEM3dpSkFOd1N4?=
 =?utf-8?B?TERDTHNnTTZ2ODJYUUJ3UkpMSmh1MlhOMTBVaUZvTnZqN0ZYSDNKRzE2WGVR?=
 =?utf-8?B?N25Qd24rdHBCcGJoLy9QaW9IQWR6eG9pTlhNZy80dlZsL0JHS2g1eG5SVEs5?=
 =?utf-8?B?QVdqblVvbDVHWklxbmh1djEya1hQT0dIYUtFOUwzdENzR0l5QVV2eFZOS005?=
 =?utf-8?B?Y09uRmVKU05iaGttMUVzSEV5aHZOSVNicW9EUFNhZ0tkR2JRc240SVpNcENJ?=
 =?utf-8?B?a21na0V2N1VWU0V2VFhLMWVhSlVEVmpiVmY3WFYzRTJ1b0k3MzJsaGp5LzFX?=
 =?utf-8?B?WmtGVkt6MUt6d1Y2TjY4OTV0MHlJdXQzbEFMZWFOb0preGo5ZXV2bzBIRk9a?=
 =?utf-8?B?UDlyRTFpZ3Nuek8wZTVXYTRsT1haQVFPTlBVR04vaU8wSHN5WmovTGNqSytQ?=
 =?utf-8?B?OVdtbVlTZ0RYMWpTNStiWkR3dXlSTnFJak1aak1jV1dDN3BwUlkxUHJqbG5Z?=
 =?utf-8?B?UmlKRWxzVit0WDB1dVMzYllMMDk0U3RrQmFBY0dhazdtOVdEc0VVQ3dNTTdK?=
 =?utf-8?B?K0pnbWJNTDFOWmpuK2F6THp5M1hvZytyc1l2cVpJS1JncjQyVG5YRlY4ZEM0?=
 =?utf-8?B?bFZaeTBWRE5Ibk9iUzBFRDIrOWhpWUdoWE1maXJBemRXVFo0eWhuQkU0MFY3?=
 =?utf-8?B?enpaOTgrZXlic3krWlFHWFV0VFhJcEtQNmxBZTNXcWtXZTBQYVFvUUkxdDJI?=
 =?utf-8?B?NjYvQ1VLcXF4YmRZcG9KV0QxaXV4cDhES2JETVVtSCtjYm9TQm5pdFBZdkRQ?=
 =?utf-8?B?c1RmTnFWUjdZQUh3eW5SWm1iL3BLaTFmV0hnS01ZUC92WjJmSFVsOUxQMlJZ?=
 =?utf-8?B?ME5JRnZ6TUlEWStUb2NleU1YUXZJR2l5UVFmVDVzMloyWjkvK0ZXTmtrRUlN?=
 =?utf-8?B?cGxESVlBR2xIdzMvRXl0QXJCTXpZTksvSjh2TUEveEUxcjFzbkw0UXhkUjlo?=
 =?utf-8?B?d002NkFsSXg3aFQ0N0Q0MkVDSEdQYld4V24wRVRMckFLMDkrK0V3RmNvRzM0?=
 =?utf-8?B?cGlsU3NwaW84VkFOTmxkN1VSekM5TTF0S2pHSE45QVMrL0N3N0Nwb0Q1NGY2?=
 =?utf-8?Q?Xtuh3VKc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D4D17CA3017424B80EC2A06620E261E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eabce27-f988-45bc-fe7a-08d8bd781b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 19:18:02.5865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EToJ5sVOZrU4tnBf1/glAHnnDiGJo7nSe7y6GvWFIqU/2NuU6JhBooWBLlsvjE6xR4EXFLK28BSolXr7mTR0HU/Ww0DmCtNWCu/8C4NQ+H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2838
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTEyIGF0IDE4OjQzICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiBNb24sIDExIEphbiAyMDIxIDE0OjUxOjA2IC0wODAwDQo+IEJlbiBXaWRhd3NreSA8
YmVuLndpZGF3c2t5QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFZpc2hhbCBWZXJt
YSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+IA0KPiA+IEFkZCBhbiBhY3BpX2N4bCBt
b2R1bGUgdG8gY29vcmRpbmF0ZSB0aGUgQUNQSSBwb3J0aW9ucyBvZiB0aGUgQ1hMDQo+ID4gKENv
bXB1dGUgZVhwcmVzcyBMaW5rKSBpbnRlcmNvbm5lY3QuIFRoaXMgZHJpdmVyIGJpbmRzIHRvIEFD
UEkwMDE3DQo+ID4gb2JqZWN0cyBpbiB0aGUgQUNQSSB0cmVlLCBhbmQgY29vcmRpbmF0ZXMgYWNj
ZXNzIHRvIHRoZSByZXNvdXJjZXMNCj4gPiBwcm92aWRlZCBieSB0aGUgQUNQSSBDRURUIChDWEwg
RWFybHkgRGlzY292ZXJ5IFRhYmxlKS4NCj4gPiANCj4gPiBJdCBhbHNvIGNvb3JkaW5hdGVzIG9w
ZXJhdGlvbnMgb2YgdGhlIHJvb3QgcG9ydCBfT1NDIG9iamVjdCB0byBub3RpZnkNCj4gPiBwbGF0
Zm9ybSBmaXJtd2FyZSB0aGF0IHRoZSBPUyBoYXMgbmF0aXZlIHN1cHBvcnQgZm9yIHRoZSBDWEwN
Cj4gPiBjYXBhYmlsaXRpZXMgb2YgZW5kcG9pbnRzLg0KPiA+IA0KPiA+IE5vdGU6IHRoZSBhY3Ri
bDEuaCBjaGFuZ2VzIGFyZSBzcGVjdWxhdGl2ZS4gVGhlIGV4cGVjdGF0aW9uIGlzIHRoYXQgdGhl
eQ0KPiA+IHdpbGwgYXJyaXZlIHRocm91Z2ggdGhlIEFDUElDQSB0cmVlIGluIGR1ZSB0aW1lLg0K
PiANCj4gSSB3b3VsZCBwdWxsIHRoZSBBQ1BJQ0EgY2hhbmdlcyBvdXQgaW50byBhIHByZWN1cnNv
ciBwYXRjaC4NCg0KRG9uZS4NCg0KPiANCj4gPiANCj4gPiBDYzogQmVuIFdpZGF3c2t5IDxiZW4u
d2lkYXdza3lAaW50ZWwuY29tPg0KPiA+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1z
QGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZl
cm1hQGludGVsLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCZW4gV2lkYXdza3kgPGJlbi53aWRh
d3NreUBpbnRlbC5jb20+DQo+IA0KPiBIaSwNCj4gDQo+IEkgdGhpbmsgaXQgd291bGQgYmUgZ29v
ZCB0byBhbHNvIGFkZCBDRURUIHRvIHRoZSBsaXN0IGluIGRyaXZlcnMvYWNwaS90YWJsZXMuYw0K
PiBzbyB0aGF0IHdlIGNhbiBkdW1wIGl0IGZyb20gL3N5cy9maXJtd2FyZS9hY3BpL3RhYmxlcy8g
YW5kIHBvdGVudGlhbGx5DQo+IG92ZXJyaWRlIGl0IGZyb20gYW4gaW5pdHJkLg0KDQpEdW1waW5n
IGl0IGZyb20gL3N5cy9maXJtd2FyZS9hY3BpL3RhYmxlcyBhbHJlYWR5IHdvcmtzLCBidXQgSSBk
aWQgYWRkDQppdCB0byB0YWJsZXMuYyBzbyBpdCBjYW4gYWxzbyBiZSBvdmVycmlkZGVuLiBJIGRp
ZCB0aGlzIGluIGEgc2VwYXJhdGUNCnBhdGNoLCBpbiBjYXNlIEFDUEkgZm9sa3Mgd2FudCB0byBk
byB0aGlzIGRpZmZlcmVudGx5Lg0KDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9s
aW51eC92NS4xMS1yYzMvc291cmNlL2RyaXZlcnMvYWNwaS90YWJsZXMuYyNMNDgyDQo+IENhbiBi
ZSB2ZXJ5IGhlbHBmdWwgd2hpbHN0IGRlYnVnZ2luZy4gIFJlbGF0ZWQgdG8gdGhhdCwgYW55b25l
IGtub3cgaWYgYW55b25lDQo+IGhhcyBhY3BpY2EgcGF0Y2hlcyBzbyB3ZSBjYW4gaGF2ZSBpYXNs
IC1kIHdvcmsgb24gdGhlIHRhYmxlPyAgV291bGQgcHJvYmFibHkNCj4gYmUgdXNlZnVsIGJ1dCBJ
J2QgcmF0aGVyIG5vdCBkdXBsaWNhdGUgd29yayBpZiBpdCdzIGFscmVhZHkgZG9uZS4NCj4gDQo+
IEEgZmV3IG1pbm9yIHRoaW5ncyBpbmxpbmUNCg0KQWdyZWVkIHdpdGggYWxsIG9mIHlvdXIgb3Ro
ZXIgY29tbWVudHMgYmVsb3csIGFuZCBJJ3ZlIGFkZHJlc2VkIHRoZW0gZm9yDQp0aGUgbmV4dCBy
ZXZpc2lvbi4gVGhhbmtzIGZvciB0aGUgcmV2aWV3IEpvbmF0aGFuIQ0KDQo+IA0KPiBKb25hdGhh
bg0KPiANCj4gDQoNCg==
