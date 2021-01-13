Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9412F5188
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 18:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbhAMRzy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 12:55:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:30282 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbhAMRzx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jan 2021 12:55:53 -0500
IronPort-SDR: P41kfzI+SBXM5X3xSQE6pF3VHNDe9cX68pbFn6T3RRQP7lamD/JXnhlPxybCgPTk3CtlDKuE7p
 /Kzemrb7rMuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="165334333"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="165334333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:55:12 -0800
IronPort-SDR: cSAIO5cpbERvXSskfeYtztqwIw4DPMDxdhIspDfc6YtxIy2L2pMO/LG9Il48StG095ko7YiT9v
 hZxIZdQRgYWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="381946284"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2021 09:55:11 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 09:55:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Jan 2021 09:55:11 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 13 Jan 2021 09:55:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iO3j0y2F02rXA7gDD2LZR4NH0rN5n4TQmHF32UwoowsC4pz0QCQ7BcjKmdzce2V+vZeRMRzLxjrkjq/vGwnne2k2nFRop2GYmShGBrQor00HlJCD1oStcq7VOh6udOX2QFx9yaqigy3USl/bfNG5nmiNAX4X/O7ioZYbqGU6UlYLpkdSWME4+z82BXTXXDqIzCSvqDs0+kYiqhLtncl1zksUtBAZrgW9OmkSriCk6TZ69Iqty4ad7Wa/xGbiZUwv8pr/T+Xad4kL8vXsrZXgXxQzBWJNYgDoh4jLs/LzTCDt25WyO69u9Lf5xFHQNe3/GAyF70qO88mXXDTtbF6HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxuF5sxHspB+sR1Sn9f9sCh7knWKj+xbjDcXZrcU64k=;
 b=HRF0fcj7mWgfOfSvZ4Xzre2SZ/x0GssjcCOHR/R/SSWci+MTwjdgfKArMPFBkktEBYURhueo9T+9OKkZlUhB6zwrRZeL9ZPY76oJL4B/LoQVhrRdMhROcy9zWnq9pBQ1EMHawk0b9cL9VL70rYBGm0UqgBAp3Ms+cCpBJv32ct2yYQ1hmpvE+tE2yZ3b84MYCfPYZc4FCvMPx6uG9NPEFAlVOuRFrQQERFwbXL1gSYRji+9VSzMdovFS/Wa9BL7RgRM2qrOusIiN9OFatE+0ACV653FA0yCCxeJIsiwDjXO3rVdfSKOmh7NHrbnomDc14VHAbq/qG6eHleeuvCBy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxuF5sxHspB+sR1Sn9f9sCh7knWKj+xbjDcXZrcU64k=;
 b=eJ0UM5yRfigLpLBW8gF/o1xFwrzba9+vKNC9vU2MxUTJ2m/LR1o6BUFIn2Cachc9pNYahzKnI3eIvesAuY2bnqXF6a7eYaKv5k2C+PyofiePDB9AVQfq6d6/hQqzUTMerdetCDo8UY6/NHsHYPX9ERiiyGRJiLOA4Y+te5JW/uc=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 17:55:04 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::4878:159c:ca1e:f430%10]) with mapi id 15.20.3742.012; Wed, 13 Jan
 2021 17:55:04 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "daniel.lll@alibaba-inc.com" <daniel.lll@alibaba-inc.com>,
        "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Thread-Topic: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the
 CXL interconnect
Thread-Index: AQHW6HoQdrgpYppa0UO4O3KwKR0KaKokZZSOgAFt+WA=
Date:   Wed, 13 Jan 2021 17:55:04 +0000
Message-ID: <MWHPR11MB1599E92A457AF6D103EECB06F0A90@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-3-ben.widawsky@intel.com>
 <20210112184355.00007632@Huawei.com>
 <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com>
In-Reply-To: <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [174.25.99.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14376f23-aa17-4094-6470-08d8b7ec5b39
x-ms-traffictypediagnostic: MW3PR11MB4523:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4523567642464FFA4C9C34B1F0A90@MW3PR11MB4523.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3t8aJwhs0SfAhZrEKnv9TsanFBSWq25doBjaWD6VNvcuYmIzSukjL8ckuTyXqTJZy85ipsnF8EnzZquew5ULy6e/TuyUGHWZUEfSsiirUZCCic8ADzGjB8qu8o9il5Uf4ia9m21IUEO/0ChInFhpKEnwmi5/9Ajz/ymOjK6GIxJQ/fhwCZjTHfFQ4bMgtJAu3GAzzvwamtc6lz/u/r59Ku4kxGXB9xSdwX7qUVOXr0RSwLjW4TNmAgHoHepL5IaLDILb/PSbbcb9VUBhSFdRghrX6v4/HBTPBjqzKAv4SCdJfBKzDp5PDJyX/iaQzha2+aYFZxBN+FRyzkBAH+HecDnMulYyVRukY27prr6PmiCuHYkjLz4zIRvBbmo5/6Y99Fe9uZ/Ww17Ktw98pKWuNF4zCqmmEH6t0dV5msz/TQh6aC+WiXcgxW2CDX6zuBYy+15Iy63Qi+BOQpzqiN8n0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(33656002)(66476007)(8676002)(76116006)(64756008)(66446008)(52536014)(83380400001)(66946007)(110136005)(7696005)(55016002)(7416002)(4326008)(8936002)(54906003)(66556008)(53546011)(966005)(86362001)(6636002)(316002)(6506007)(5660300002)(71200400001)(26005)(186003)(478600001)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkdORkZDc1RQSVhLOVJIVFdPTTdlT1FtWEZxWnNFQ0laK0dQOVVTajFQUXBw?=
 =?utf-8?B?SWYycy83UXU2V2hCVmhXRWtwWXB5clowSEhHcys0T0tVaWh0dWU1b3lIandp?=
 =?utf-8?B?N1dqdTkzUXU1cCt4VFczQUJKK21BQjlRRnJNWUxkTmpTYWs4SXJpRkpvS3ZG?=
 =?utf-8?B?a2hFK3Y1TStDbFJvOG1TZ25pWWNlemphdmhzRkZQMHNCRWJteUp6YjhzMURv?=
 =?utf-8?B?VklySFFRM0RvVVpqSmNtcUxGekZ1cUh4N2tiblo0dHJXYk85V21oV01haEg5?=
 =?utf-8?B?eTRaN2U4alRjczc0aElSUWE2V2RXclAyK1k0MUh0Y09LVXd0M29vSldkd3JU?=
 =?utf-8?B?QjZHSS80OXZzek5iMXZLWDgzaGFKY3hxdU1FYnN5V1ExRmpHT3dpcHNTUTNT?=
 =?utf-8?B?dVoxL0plaFlMTm52YmY3RHQyVG5raG8yRHJZNHArejYyZC9Gcys0MWxUVjlr?=
 =?utf-8?B?cUN4WFFGN3JpMzdQOWdjSmYzdHhKeEhsSU1nWGg5dUNSY2xwNG4weTZtYjNN?=
 =?utf-8?B?bXp5UnBxMmFMcXdyVERsdEkzUmdhditCM2dZalhxMENpR3g1KzVhM1dsVlF1?=
 =?utf-8?B?enRLYWptWUlHMFppZ08wMVI2NjZDaEdwOCtXZ2VnbC9pVDhrbHZlYlFWeElN?=
 =?utf-8?B?RFJxZ0dKVzBHLzg4TG0rekYrV2o4dTZlWVZHdEFnSDVpSzM0ZDR5a1B2SStu?=
 =?utf-8?B?aUg3UWljWHRFbVdScFR5R2ZUTUJ3elZ5NDVhVVczZjN5QjZ5d3BvdzZVUm0y?=
 =?utf-8?B?MVZGczNYT1E4dWNJMVFrYVhlU0taMVhhSkIyTWVMaUN1TUIvekFPbjNHK0pK?=
 =?utf-8?B?UHRoRkF6NXQvaEVzRVhrQXlhZ0N1VjBxS2hyTGk1UlErZmdtVHEzbklRR3Rp?=
 =?utf-8?B?OGxsMlVaOGtZUDdjSEYwRTFQN2ZmdlZwZGx4Umx2MGRhN3FwSmM5RjRrdVhV?=
 =?utf-8?B?V0JsRE1mNytndzU4SmZJYWt1TmdPSGM3cCsraU5VUkE3eXF4MHJvUUNoa2Nz?=
 =?utf-8?B?dVRXWDBUQ2dRcGxvdFozNzd2SENGUmo5MkNwVCsvZ01acm9laE1VWVQrd1M2?=
 =?utf-8?B?bjRVWU9LWHBVQXlUQmpGb3d0NWs1d3RBZmpHVkRrYW5hVS91OTc4QkZSdjNl?=
 =?utf-8?B?SjA0c1hCYUx2OURiWTAzZ28vN2NGeS9WL3UreGh0R2VMbVE2WGZRV0JrWnZH?=
 =?utf-8?B?ZnJZcGJMeEpIL05laThLSFJrZWQzVXhZVDZIWmxZM1pGQnplZ3U2VndERlh5?=
 =?utf-8?B?Zno4aEdtRWtBaE5rbnFJVXhpdXg1c3h0R3ZVTkJ6Q3BMemRwWEpvWkYzcE9y?=
 =?utf-8?Q?bq7sK3hyZZ/VQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14376f23-aa17-4094-6470-08d8b7ec5b39
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 17:55:04.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8AQvN5S86EYmK4FoebTQGWKf1GlhQJ4JU2ug/YzxHFjiAoyTGo+0Y492ZnhBirgOn6IgcVuYGZxTIc6ZTijEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuIFdpbGxpYW1zIDxk
YW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTIsIDIw
MjEgMTE6NDQgQU0NCj4gVG86IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVh
d2VpLmNvbT4NCj4gQ2M6IFdpZGF3c2t5LCBCZW4gPGJlbi53aWRhd3NreUBpbnRlbC5jb20+OyBs
aW51eC1jeGxAdmdlci5rZXJuZWwub3JnOw0KPiBWZXJtYSwgVmlzaGFsIEwgPHZpc2hhbC5sLnZl
cm1hQGludGVsLmNvbT47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgTGludXggUENJIDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
PjsgV2VpbnksIElyYQ0KPiA8aXJhLndlaW55QGludGVsLmNvbT47IEtlbGxleSwgU2VhbiBWIDxz
ZWFuLnYua2VsbGV5QGludGVsLmNvbT47IFd5c29ja2ksDQo+IFJhZmFlbCBKIDxyYWZhZWwuai53
eXNvY2tpQGludGVsLmNvbT47IEJqb3JuIEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz47DQo+
IEpvbiBNYXN0ZXJzIDxqY21Aam9ubWFzdGVycy5vcmc+OyBDaHJpcyBCcm93eSA8Y2Jyb3d5QGF2
ZXJ5LQ0KPiBkZXNpZ24uY29tPjsgUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+
OyBDaHJpc3RvcGggSGVsbHdpZw0KPiA8aGNoQGluZnJhZGVhZC5vcmc+OyBkYW5pZWwubGxsQGFs
aWJhYmEtaW5jLmNvbTsgTW9vcmUsIFJvYmVydA0KPiA8cm9iZXJ0Lm1vb3JlQGludGVsLmNvbT47
IEthbmVkYSwgRXJpayA8ZXJpay5rYW5lZGFAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1JG
QyBQQVRDSCB2MyAwMi8xNl0gY3hsL2FjcGk6IEFkZCBhbiBhY3BpX2N4bCBtb2R1bGUgZm9yIHRo
ZQ0KPiBDWEwgaW50ZXJjb25uZWN0DQo+IA0KPiBPbiBUdWUsIEphbiAxMiwgMjAyMSBhdCAxMDo0
NCBBTSBKb25hdGhhbiBDYW1lcm9uDQo+IDxKb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gT24gTW9uLCAxMSBKYW4gMjAyMSAxNDo1MTowNiAtMDgwMA0KPiA+IEJl
biBXaWRhd3NreSA8YmVuLndpZGF3c2t5QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IEZy
b206IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KPiA+ID4NCj4gPiA+
IEFkZCBhbiBhY3BpX2N4bCBtb2R1bGUgdG8gY29vcmRpbmF0ZSB0aGUgQUNQSSBwb3J0aW9ucyBv
ZiB0aGUgQ1hMDQo+ID4gPiAoQ29tcHV0ZSBlWHByZXNzIExpbmspIGludGVyY29ubmVjdC4gVGhp
cyBkcml2ZXIgYmluZHMgdG8gQUNQSTAwMTcNCj4gPiA+IG9iamVjdHMgaW4gdGhlIEFDUEkgdHJl
ZSwgYW5kIGNvb3JkaW5hdGVzIGFjY2VzcyB0byB0aGUgcmVzb3VyY2VzDQo+ID4gPiBwcm92aWRl
ZCBieSB0aGUgQUNQSSBDRURUIChDWEwgRWFybHkgRGlzY292ZXJ5IFRhYmxlKS4NCj4gPiA+DQo+
ID4gPiBJdCBhbHNvIGNvb3JkaW5hdGVzIG9wZXJhdGlvbnMgb2YgdGhlIHJvb3QgcG9ydCBfT1ND
IG9iamVjdCB0byBub3RpZnkNCj4gPiA+IHBsYXRmb3JtIGZpcm13YXJlIHRoYXQgdGhlIE9TIGhh
cyBuYXRpdmUgc3VwcG9ydCBmb3IgdGhlIENYTA0KPiA+ID4gY2FwYWJpbGl0aWVzIG9mIGVuZHBv
aW50cy4NCj4gPiA+DQo+ID4gPiBOb3RlOiB0aGUgYWN0YmwxLmggY2hhbmdlcyBhcmUgc3BlY3Vs
YXRpdmUuIFRoZSBleHBlY3RhdGlvbiBpcyB0aGF0IHRoZXkNCj4gPiA+IHdpbGwgYXJyaXZlIHRo
cm91Z2ggdGhlIEFDUElDQSB0cmVlIGluIGR1ZSB0aW1lLg0KPiA+DQo+ID4gSSB3b3VsZCBwdWxs
IHRoZSBBQ1BJQ0EgY2hhbmdlcyBvdXQgaW50byBhIHByZWN1cnNvciBwYXRjaC4NCj4gDQo+IA0K
PiA+DQo+ID4gPg0KPiA+ID4gQ2M6IEJlbiBXaWRhd3NreSA8YmVuLndpZGF3c2t5QGludGVsLmNv
bT4NCj4gPiA+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29t
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQmVuIFdpZGF3c2t5IDxiZW4ud2lkYXdza3lAaW50ZWwu
Y29tPg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBJIHRoaW5rIGl0IHdvdWxkIGJlIGdvb2QgdG8g
YWxzbyBhZGQgQ0VEVCB0byB0aGUgbGlzdCBpbiBkcml2ZXJzL2FjcGkvdGFibGVzLmMNCj4gPiBz
byB0aGF0IHdlIGNhbiBkdW1wIGl0IGZyb20gL3N5cy9maXJtd2FyZS9hY3BpL3RhYmxlcy8gYW5k
IHBvdGVudGlhbGx5DQo+ID4gb3ZlcnJpZGUgaXQgZnJvbSBhbiBpbml0cmQuDQo+IA0KPiBBQ1BJ
Q0EgY2hhbmdlcyB3aWxsIGV2ZW50dWFsbHkgY29tZSB0aHJvdWdoIHRoZSBBQ1BJIHRyZWUgbm90
IHRoaXMgcGF0Y2gNCj4gc2V0Lg0KPiANCj4gDQo+ID4NCj4gPiBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92NS4xMS0NCj4gcmMzL3NvdXJjZS9kcml2ZXJzL2FjcGkvdGFibGVzLmMj
TDQ4Mg0KPiA+IENhbiBiZSB2ZXJ5IGhlbHBmdWwgd2hpbHN0IGRlYnVnZ2luZy4gIFJlbGF0ZWQg
dG8gdGhhdCwgYW55b25lIGtub3cgaWYNCj4gYW55b25lDQo+ID4gaGFzIGFjcGljYSBwYXRjaGVz
IHNvIHdlIGNhbiBoYXZlIGlhc2wgLWQgd29yayBvbiB0aGUgdGFibGU/ICBXb3VsZA0KPiBwcm9i
YWJseQ0KPiA+IGJlIHVzZWZ1bCBidXQgSSdkIHJhdGhlciBub3QgZHVwbGljYXRlIHdvcmsgaWYg
aXQncyBhbHJlYWR5IGRvbmUuDQo+ID4NCj4gDQo+IFRoZSBzdXBwbGVtZW50YWwgdGFibGVzIGRl
c2NyaWJlZCBoZXJlOg0KPiANCj4gaHR0cHM6Ly93d3cudWVmaS5vcmcvYWNwaQ0KPiANCj4gLi4u
ZG8gZXZlbnR1YWxseSBtYWtlIHRoZXJlIHdheSBpbnRvIEFDUElDQS4gQWRkZWQgQm9iIGFuZCBF
cmlrIGluDQo+IGNhc2UgdGhleSBjYW4gY29tbWVudCBvbiB3aGVuIENFRFQgYW5kIENEQVQgc3Vw
cG9ydCB3aWxsIGJlIHBpY2tlZCB1cC4NCg0KV2Ugd291bGQgYmUgaGFwcHkgdG8gYWRkIHN1cHBv
cnQuIEkgdGhpbmsgQmVuIGhhcyByZWFjaGVkIG91dCB0byBtZSBlYXJsaWVyIGFib3V0IHNvbWV0
aGluZyBsaWtlIHRoaXMgYnV0IEkgaGF2ZW7igJl0IGhhZCBhIGNoYW5jZSB0byBpbXBsZW1lbnQu
Li4gU29ycnkgYWJvdXQgdGhlIGRlbGF5Li4gSG93IHNvb24gaXMgdGhlIGlBU0wvQUNQSUNBIHN1
cHBvcnQgbmVlZGVkIGZvciBDREFUIGFuZCBDREVUPw0KDQpFcmlrDQogDQoNCg==
