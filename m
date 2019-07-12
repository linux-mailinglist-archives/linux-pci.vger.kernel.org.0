Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D97672F4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2019 18:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfGLQEU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jul 2019 12:04:20 -0400
Received: from mail-eopbgr820099.outbound.protection.outlook.com ([40.107.82.99]:11408
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbfGLQEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jul 2019 12:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft2EL07oMoAyBwO5HWqn/a/zE+yyT7CQB1aPLfnGW/+WNPwlS3KlFxrArfHjOIp4oHP590O9p0g5rH/fsjk2ZOgBbUKZNWz06eKAcl6EAFZ4kCTJdS+fxkHMf0TS0DskD1NRnpsuD1OboBRqN5I1zEUkqX4udwbkHpic6o28cVXt8wfBgKUrVFUa/8RNR7P0U0nypobCjOTwoLE67t2GH9TdkTLUSBFVZE5NfmBHnfkIe6UsOrQjJddYd/dZ2yAvA07p39vrHb3se/3qq37gqAcdXwLEGLzwzXlfyCEMHuFYt25bZvuYIfmv/P75i/dHu+ewKY8VNuS0UWTrO0efrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Y7FYwYaMHxVkF16FeA84w/WwHIJmjJ1ipHHu4zqzA=;
 b=BQUwm48rB6omxRBru1ZbYl+Z1tXVLE5r181PYwAhxURchqnFAMB7f2IIQ1Sooe9/K6lmTi3yE4PrmfRvnIbACI9wH8FoKTS8Vxh/sfFWTDcHSAtTKSnktu7BgTArjMlTSCEPYFMHoamj5Vux52xljTQ0nFeLA3b+pS4UMyjxEd5wWsEM7/PIWgUHoGHv5n1pZpNesL55hJn194QCfufgx8OYpp+WmoSIkKp7vqM+ZCVjeiB7m9m7w9c5lL1IGlb0SdrJLJIIbTVeqDlkgHonij4p5t+FaeHwkn8CJ0TgU+MXXyVrEw1yP8HVZ0HzlSsa5Px5EpY8FpD/z0oBuN/UfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7Y7FYwYaMHxVkF16FeA84w/WwHIJmjJ1ipHHu4zqzA=;
 b=JDhtoVsPsJKlQouF7SYaRYvaQP3s8tXAKE0LNhdVYW3yl03UGY1X6sgqq19NL007GVgsiWIVCUxu7v6DUKT2TFgwCNNLQd6q6QOGU5yiKiv6eE9BEgxJoZUd9QKe31FyfbOOkefAw++lcw96Xyyd69esrLSJ7NcejWhXDEJzCeA=
Received: from DM6PR21MB1337.namprd21.prod.outlook.com (20.179.53.80) by
 DM6PR21MB1177.namprd21.prod.outlook.com (20.179.48.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.0; Fri, 12 Jul 2019 16:04:17 +0000
Received: from DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::5067:7dee:544e:6c08]) by DM6PR21MB1337.namprd21.prod.outlook.com
 ([fe80::5067:7dee:544e:6c08%9]) with mapi id 15.20.2094.007; Fri, 12 Jul 2019
 16:04:17 +0000
From:   Haiyang Zhang <haiyangz@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Sasha Levin <sashal@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Thread-Topic: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Thread-Index: AQHVOMnwQQwdVculfkKes1/VgrnBiqbHJRrw
Date:   Fri, 12 Jul 2019 16:04:17 +0000
Message-ID: <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
In-Reply-To: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=haiyangz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-12T16:04:14.8648345Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=52e98205-6335-4f10-b6e0-640a0ae863ab;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com; 
x-originating-ip: [96.61.92.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f70f794-bbed-4e5d-7603-08d706e297e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM6PR21MB1177;
x-ms-traffictypediagnostic: DM6PR21MB1177:|DM6PR21MB1177:
x-microsoft-antispam-prvs: <DM6PR21MB1177C8F1E97C6844E4E4628FCAF20@DM6PR21MB1177.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(199004)(189003)(13464003)(40224003)(8676002)(81166006)(81156014)(55016002)(7736002)(107886003)(476003)(6246003)(486006)(14444005)(256004)(446003)(11346002)(8936002)(53936002)(5660300002)(4326008)(66476007)(66446008)(64756008)(66556008)(229853002)(66946007)(10090500001)(71200400001)(76116006)(71190400001)(52536014)(6436002)(25786009)(86362001)(66066001)(76176011)(478600001)(53546011)(6506007)(102836004)(316002)(110136005)(8990500004)(54906003)(68736007)(10290500003)(2906002)(74316002)(6116002)(3846002)(305945005)(9686003)(186003)(99286004)(7696005)(26005)(14454004)(22452003)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR21MB1177;H:DM6PR21MB1337.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lM4j5T/SkLQfKTdQ0yyPTtxSf+DlDeVgsS+jA9hQ71T8miWtwgf8+Iqrm+fFgUCE249zRPvV6iQSfpXHgDJ+6Snls8wqUElj1ZeyMoaYlgN+aUEPFEFgF3D3UWgh5jh7MWx4x319dErqB9sbN+k9pFDhv7PBD2qQXCgF5FIaB6ceQNMXKReUS95XcqE3GTmfPY0sy+LEAxhsNm5QFH9Y8RYUQDz9yMBO5NYHb2aDouggtLz8lROaiUilQrc9/zNdnaYq7T481Xk5FTM1EB1QcO1QWVNFrJyyxUsXguiwn5zw+ODR1Ek1whT6706M9Ph1iV+Dg7br1rFWLLphdURysRzpLFfoaTw/IF0cuAypCu/rojBwOXW6OvQhzJaPGCumQItkjP6z2Xhz1yuJfyuEOCn+dgmY0gRnfkcAC+/aEoI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f70f794-bbed-4e5d-7603-08d706e297e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 16:04:17.5012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: haiyangz@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1177
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIDxy
ZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxMiwgMjAxOSAxMTo1
MyBBTQ0KPiBUbzogbGludXgtcGNpIDxsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnPjsgTEtNTCA8
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENjOiBNYXR0aGV3IFdpbGNveCA8
d2lsbHlAaW5mcmFkZWFkLm9yZz47IEpha2UgT3NoaW5zDQo+IDxqYWtlb0BtaWNyb3NvZnQuY29t
PjsgS1kgU3Jpbml2YXNhbiA8a3lzQG1pY3Jvc29mdC5jb20+OyBIYWl5YW5nDQo+IFpoYW5nIDxo
YWl5YW5nekBtaWNyb3NvZnQuY29tPjsgU3RlcGhlbiBIZW1taW5nZXINCj4gPHN0aGVtbWluQG1p
Y3Jvc29mdC5jb20+OyBTdGVwaGVuIEhlbW1pbmdlcg0KPiA8c3RlcGhlbkBuZXR3b3JrcGx1bWJl
ci5vcmc+OyBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+OyBCam9ybg0KPiBIZWxnYWFz
IDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsgRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIXSBQQ0k6IHBjaS1oeXBlcnY6IGZpeCBidWlsZCBlcnJvcnMgb24g
bm9uLVNZU0ZTIGNvbmZpZw0KPiANCj4gRnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJh
ZGVhZC5vcmc+DQo+IA0KPiBGaXggYnVpbGQgZXJyb3JzIHdoZW4gYnVpbGRpbmcgYWxtb3N0LWFs
bG1vZGNvbmZpZyBidXQgd2l0aCBTWVNGUw0KPiBub3Qgc2V0IChub3QgZW5hYmxlZCkuICBGaXhl
cyB0aGVzZSBidWlsZCBlcnJvcnM6DQo+IA0KPiBFUlJPUjogInBjaV9kZXN0cm95X3Nsb3QiIFtk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYua29dIHVuZGVmaW5lZCENCj4gRVJST1I6
ICJwY2lfY3JlYXRlX3Nsb3QiIFtkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYua29d
IHVuZGVmaW5lZCENCj4gDQo+IGRyaXZlcnMvcGNpL3Nsb3QubyBpcyBvbmx5IGJ1aWx0IHdoZW4g
U1lTRlMgaXMgZW5hYmxlZCwgc28NCj4gcGNpLWh5cGVydi5vIGhhcyBhbiBpbXBsaWNpdCBkZXBl
bmRlbmN5IG9uIFNZU0ZTLg0KPiBNYWtlIHRoYXQgZXhwbGljaXQuDQo+IA0KPiBBbHNvLCBkZXBl
bmRpbmcgb24gWDg2ICYmIFg4Nl82NCBpcyBub3QgbmVlZGVkLCBzbyBqdXN0IGNoYW5nZSB0aGF0
DQo+IHRvIGRlcGVuZCBvbiBYODZfNjQuDQo+IA0KPiBGaXhlczogYTE1ZjJjMDhjNzA4ICgiUENJ
OiBodjogc3VwcG9ydCByZXBvcnRpbmcgc2VyaWFsIG51bWJlciBhcyBzbG90DQo+IGluZm9ybWF0
aW9uIikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRl
YWQub3JnPg0KPiBDYzogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+IENj
OiBKYWtlIE9zaGlucyA8amFrZW9AbWljcm9zb2Z0LmNvbT4NCj4gQ2M6ICJLLiBZLiBTcmluaXZh
c2FuIiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+IENjOiBIYWl5YW5nIFpoYW5nIDxoYWl5YW5nekBt
aWNyb3NvZnQuY29tPg0KPiBDYzogU3RlcGhlbiBIZW1taW5nZXIgPHN0aGVtbWluQG1pY3Jvc29m
dC5jb20+DQo+IENjOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RlcGhlbkBuZXR3b3JrcGx1bWJlci5v
cmc+DQo+IENjOiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+DQo+IENjOiBCam9ybiBI
ZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogbGludXgtaHlwZXJ2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogRGV4dWFuIEN1
aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT4NCj4gLS0tDQo+IHYzOiBjb3JyZWN0ZWQgRml4ZXM6IHRh
ZyBbRGV4dWFuIEN1aSA8ZGVjdWlAbWljcm9zb2Z0LmNvbT5dDQo+ICAgICBUaGlzIGlzIHRoZSBN
aWNyb3NvZnQtcHJlZmVycmVkIHZlcnNpb24gb2YgdGhlIHBhdGNoLg0KPiANCj4gIGRyaXZlcnMv
cGNpL0tjb25maWcgfCAgICAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IC0tLSBsbngtNTIub3JpZy9kcml2ZXJzL3BjaS9LY29uZmln
DQo+ICsrKyBsbngtNTIvZHJpdmVycy9wY2kvS2NvbmZpZw0KPiBAQCAtMTgxLDcgKzE4MSw3IEBA
IGNvbmZpZyBQQ0lfTEFCRUwNCj4gDQo+ICBjb25maWcgUENJX0hZUEVSVg0KPiAgICAgICAgICB0
cmlzdGF0ZSAiSHlwZXItViBQQ0kgRnJvbnRlbmQiDQo+IC0gICAgICAgIGRlcGVuZHMgb24gWDg2
ICYmIEhZUEVSViAmJiBQQ0lfTVNJICYmIFBDSV9NU0lfSVJRX0RPTUFJTg0KPiAmJiBYODZfNjQN
Cj4gKyAgICAgICAgZGVwZW5kcyBvbiBYODZfNjQgJiYgSFlQRVJWICYmIFBDSV9NU0kgJiYNCj4g
UENJX01TSV9JUlFfRE9NQUlOICYmIFNZU0ZTDQo+ICAgICAgICAgIGhlbHANCj4gICAgICAgICAg
ICBUaGUgUENJIGRldmljZSBmcm9udGVuZCBkcml2ZXIgYWxsb3dzIHRoZSBrZXJuZWwgdG8gaW1w
b3J0IGFyYml0cmFyeQ0KPiAgICAgICAgICAgIFBDSSBkZXZpY2VzIGZyb20gYSBQQ0kgYmFja2Vu
ZCB0byBzdXBwb3J0IFBDSSBkcml2ZXIgZG9tYWlucy4NCj4gDQoNClJldmlld2VkLWJ5OiBIYWl5
YW5nIFpoYW5nIDxoYWl5YW5nekBtaWNyb3NvZnQuY29tPg0KDQo=
