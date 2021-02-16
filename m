Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3325731C872
	for <lists+linux-pci@lfdr.de>; Tue, 16 Feb 2021 10:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhBPJ4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Feb 2021 04:56:08 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:59779 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhBPJ4G (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Feb 2021 04:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1613469364; x=1645005364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HmDPm7pzJO19fixMime83NTfEeh9kVDeeadNwKWRIKU=;
  b=IEuH8B5tBRm2qGOKro7Y6KUEukvPq/OFA0Ts9bIuDxGIurwJnOQCr/RB
   rbofJPTlWoTmiGKPBykXyjCH759O2IEag+CZMd3y6BvDUb4DQTWfjFo0p
   2slfZHBPzO0xoX5vVi6jTzFGWcRoWM2N+1Jp/6AigfQNaVewLdJYuO04E
   kcNyuEIqlEk4uXBa1xALaDzad4WpbWrvu35nR+BSBpa2zbbp7KlzVvLhj
   YzhsVrcWyuZ2zAA7j1GU92NuZ6gDUsEWliOSARGSMlaYrPdvhdWW5IYQP
   LODwX+w4UGnSlNJk+CybUyZekoV92oZd2yfovys37JAtMbNrYgJoKJ1gC
   g==;
IronPort-SDR: Ii8rEEFHE53TzooeTAlpDIjUJUoAYf7wD77JbfD9wuhJf+BydxppPv40DQAiWqZhxsGJZEBY5P
 LwnILukfnO09mEkxuhFbwuOYOvGJob4JzmAUiod1URPmjCsL6XDhlQJh4Kmf25Z3A/KRzw/eZT
 5NnCvlzNyU0V6KJzE6IPrW1Ylv3wdh/oC0lt1efSz3gbYoTQF6WHjfV/N+jbk0e3Yty70reCvN
 n0vosGLNnYNMJUcekVaUXbQ+jxBxzapZDC3FJV02GarUqVtfrBYir//sk7MrWaQ9GPV2L49rBc
 Qo8=
X-IronPort-AV: E=Sophos;i="5.81,183,1610434800"; 
   d="scan'208";a="109340810"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2021 02:54:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 16 Feb 2021 02:54:48 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 16 Feb 2021 02:54:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfMPPv4sD+AkQFK6fdNRTfZqPhBtn9RIUMYO4NNiJnnNr0eoFGkz60DiTA5FVC2c8BYvH7Gs2eRK0XHlPy4mlMwZjoHG6q0qSQ2psAn0/d1/r753AyunOC8rfjIX7Ob9Fxvnxy+kM+oa2Q2TGgSYUpgr1GorhExBSdC62Dt1w/USWp7h+3pz7wdJ/mm475jetWoOsrnLxVZpVXuMAh1TzeFmh1lA4InFLxSI0KQgnbaUivhttKbbH8gT3ZMnF5BD5HfrxJzk4FX9KAPT9pDhmDSkksM/jYCQM/7T9UaDwYxZ/QiQJJ6Qm3ynkZ0VUtjIVtvVaqVZC8TNozCOjBVHIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmDPm7pzJO19fixMime83NTfEeh9kVDeeadNwKWRIKU=;
 b=kDmf5AuqroM/8RTawb/SA7coBYDUag/x6gjU7BvO33TSOC/w3ZsqjWdXSV74EF/sqqIqPWEIfLcVFg2gZFb9wAnHPeerIAMnQ0/Amr5jijbpSaiD9xv1wdNao7L2JT3tk7xHtHqN7F7RAO4efuZhPn/Or9dVGsvsjgUYhQNabhait/TL7tJKUEF0TWFa5tLYNKw8SHthN7VNmtzeXpci9wOqyYfszeyKMixK5jTk90tmVVeEmxMzvb/wPbl/RcEY/LNjogdcDrQKDMV2pxixb4qgV7X7Qv05kOojLj2d0dOJRDMhUD/bbmOg9z3KN1SQJBKdCxjEJS6diJoNifxGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmDPm7pzJO19fixMime83NTfEeh9kVDeeadNwKWRIKU=;
 b=iqONjpW+A244wtM4rnHksoW8XVB2pd3iRxbmzmA+FgEPvdKn38bNoGZlnAW5sS5HuOJQRbVgD/gi6hEiC08UP4txlk/mzVE+mXZOqPl5wFQ1qQ17LFkwY9MRFfpWQSPdd9m/A3KkGJrXNg41cKt9n4ZR17P71ANPPj2w2UNmzEg=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4352.namprd11.prod.outlook.com (2603:10b6:208:18e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Tue, 16 Feb
 2021 09:54:46 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::ad57:eff0:cbff:883a]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::ad57:eff0:cbff:883a%7]) with mapi id 15.20.3846.043; Tue, 16 Feb 2021
 09:54:46 +0000
From:   <Daire.McNamara@microchip.com>
To:     <geert@linux-m68k.org>, <ben.dooks@codethink.co.uk>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <david.abdurachmanov@gmail.com>, <Cyril.Jean@microchip.com>
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Topic: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHW8zdYii//LrnuhEOopWmFCOR1K6pRdPuAgAGRIwCAAAEigIAHpdOA
Date:   Tue, 16 Feb 2021 09:54:46 +0000
Message-ID: <1237c05e-bb6e-5d05-eef0-dd145bd8c366@microchip.com>
References: <20210125162934.5335-1-daire.mcnamara@microchip.com>
 <20210125162934.5335-4-daire.mcnamara@microchip.com>
 <CAMuHMdXJQF3c1b6SXyHnuyA_huO7ZiKJ-_xm1r1h7VcGsv=n9A@mail.gmail.com>
 <d47ee0a2-7d9c-5c53-2977-09fa054e856b@codethink.co.uk>
 <CAMuHMdWZj5=vjno05F4hX6TGx0bvugBu53dhJ5L5wge2ezZuPQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWZj5=vjno05F4hX6TGx0bvugBu53dhJ5L5wge2ezZuPQ@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b607ec2-7e53-4afe-1a9f-08d8d260e46c
x-ms-traffictypediagnostic: MN2PR11MB4352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB43527ECD57ED2EA9C17ECC7496879@MN2PR11MB4352.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iAggUQKQrWcSOI+TrBjlz3ZNFhx8Ni3yzHgRccHsKE0ye+fDw5BusX8y1RsthbR+IvJXAYrIcY0zvUdG0IZEPFt/X6/9IWvj9X4VrzSyDrLKEhDrVesM+syMZxH37vldvG9jhTmFpuEj598tjxq24Q3KJCjDAPPvI+SyRjbrTeF1hh4kE29nROxf8vI45KwhuvQoeO1/MDtV+a9F61jsay2agj6x3iGpfstNPKb7CNFferIgSm63+gyjV6k6/tB0wqGvq8Kf5BZF9MqCOa5RWr1WjMr9a498TI/XlFmUrDUH4S3w365CKC1AEZyuU3VyJtvOqDXTvLXkLWiuJaZ8fso7e0vRJ444b/MuZiM7f+KWs2niKm6KPJubxFj1KC1rnN40Slh1LDn8kYZJHBVdJdOrElkT1PvaCP0bKFavKxan/VT4fb/UiclpV2bgJKWSnEYX2nk7NRlLWJrFHkdplfyQYFtwbC9rsNRpmZjdzWtDgH6S6C3Dh/sbQtS93Rxr4qn7W0OPnGsYhlUxqMDA8d1i2ckfS6b5jafk53ZjlbxFXNMtLoAYFR52+fy2BfSDqMvf5nr4SHx1I2jDq5MSXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(376002)(346002)(136003)(107886003)(5660300002)(4326008)(8936002)(31696002)(83380400001)(86362001)(6512007)(8676002)(66556008)(91956017)(66946007)(54906003)(66446008)(64756008)(66476007)(6506007)(478600001)(2616005)(31686004)(26005)(186003)(71200400001)(53546011)(316002)(36756003)(76116006)(2906002)(6486002)(110136005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?K2ZTUXpTNFV1eUtWcFY3MlBmMHVqa2RGRFF5Z1JtN0dTOVZ2REptWlR5SzVq?=
 =?utf-8?B?b04zS2Z2cExJOUNMaUhGMWFNVERJSEdlcE1DMHdSU0NXWERIRVZUSEdpZWxh?=
 =?utf-8?B?NmFXRGltMlVFWlN0NHZDTGVJQ1lqZm9MT1dQNnFobFZmTFJGQlU2QW1XeEpV?=
 =?utf-8?B?bU9Pdzdoa25BN3ZNaG53Wk11NG9SNlNXdnduTnhTRmovVGNaUnUwSDdOVERN?=
 =?utf-8?B?QTVGd0RWRWt1alhvMFlPMUUxbHVJa3NJeFU5Sk52U1RUeE9PcjFMaTBxQzVF?=
 =?utf-8?B?cC9pMVhJQVJzYmVLNWkrUWhINmxzMUszaWtxREhiTGU3dmJUVmFaajFZbThP?=
 =?utf-8?B?amtlWDRnakYvaWVSMVYyUWdCRWZDT0FQc0Q3TS9nWGJwc3dnVkdjL3lQdzlZ?=
 =?utf-8?B?Z1V0bHdRbmtQc3pLR21RTjlyL1JrMGREanlEbWJBQ3ROUXFzZk1KSHROaGxT?=
 =?utf-8?B?V20yaUJUbFdqTXFKYkF5R2c4a1FkRExNSkNWSURmV2FWemNDV2tFVTJBSUt6?=
 =?utf-8?B?bytSOXIxa09nZW5GOGJjUk9Fa0ZtSDFtRUpFYTZxZ2ZzZ2hHaFhlcnJxMGFL?=
 =?utf-8?B?a3pwWkp2THpCOFlOdE9WVDhLTVRtK1hRY3JPSXQ0VkM2THVINUV2YS9uaU5O?=
 =?utf-8?B?TnhRVllRakFWMWoxVDY4U2NRMmVQRVJTRnJ3ZnVyUm1xbGEvRzFIWjg0R3ZG?=
 =?utf-8?B?amVDTW1MVDRGdzJFUFNFTzh6cjJEc2YwMHdlVWdLVUNhbldLZmZEa0R5WmlE?=
 =?utf-8?B?cC9mUFZyZ2pWM2d4c3B3RjJ0c0p1UWx0VnpoaTRzbk5BU1ZBQVE1Uk5BcTBD?=
 =?utf-8?B?cXpzWWRyeTRYTlM4Ump3UFE2dU1UMVYvUUFHdGdOS0ZSRm01S2hwcFIvZlVx?=
 =?utf-8?B?RDdjVTBTQ2JvN0VaWW9WOFgrQWRrM2E3ZWlDQ2x2bEZIZ1dLUzZJWjZLRzVN?=
 =?utf-8?B?TnRWLyt4eVNVTnNmNjZzbnVFUVlyc2J0N2dpMlRNUk95cGZhNUxHOUEwU214?=
 =?utf-8?B?eEZSZFhTZ28yaldZVlB6WXYrbHJSZ2NhZUdMZ2UzenlDWGxuTVVTMlpDeUZP?=
 =?utf-8?B?SEQ0RC85WnRJQjAvVVE1bFFHL2t4NXM4QzNDZm1hTlNxZ04rcjdmWDd5YjF6?=
 =?utf-8?B?KzNHdjNWR3J6QllkUGN0OURPdncrVFBMTncrRE5EN2o2VmNjeEx2LzZxQUVZ?=
 =?utf-8?B?R2tZN21wQlFXZGNNLzNlcm5wQU1hczRmTVFpaTh4SC9zd1IzTE1tN1dnTXJW?=
 =?utf-8?B?KzNQckFwOVVNTmhtbmhsU21xbnA4ZWZLdCtsZUUyNEtYeDZmNURBZzNYY0pJ?=
 =?utf-8?B?TUUybU1KakxRYjduenZzeXFya0lnRW1ueDZQN0dpeVMvVXIrV3JtMm1CenpP?=
 =?utf-8?B?YTlPRm1Fd3VMVXZDcU9KM21DWHZkb1NwZTFJWWc0Q3lYZUxaRXdTM1BQNnky?=
 =?utf-8?B?RmI4OFFORnJwc2I2c1NiVHUxQjU4UjIvQVplYkVQSEF1NUdmVnU1SEluMDRX?=
 =?utf-8?B?V3BsWUpDRTc1ckVWVWRtMllvNkM5YXR2U3BXZWx1MHVoRGl5ejhNbjlNSE9r?=
 =?utf-8?B?d1VOMmt0LzF2VGUva1BJNjljUUdZL1NQc1RyUnN4cWJkbkR4RXpRbUtMc2tF?=
 =?utf-8?B?RTBvLzh6bkhVV29SU2xjN21MSkkwNFgrekMvS3NLWDVWb2R6Unc2YkNQWk5S?=
 =?utf-8?B?U0lnSmdXbm5lMDVDc25KTlp4UFlnUHUycDE4aGtpcGFQMWZTa0VFbHF2VVBR?=
 =?utf-8?Q?oVf75x9m98YCQ9Dc+kx+Xcdt2KAv1dxjRPNy87M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F387976AC5D3DA4BB5EB60794A7D67A8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b607ec2-7e53-4afe-1a9f-08d8d260e46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 09:54:46.2899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSx/8coM8uPeCxO9Orj/V6FPlNy2Go3Z4l9iry4sQSb41tEo6S1oqR95CuPzcRPKZ2lGj0vNGJqPTCdUZhpdpMRNt4pREDEoj2nVTqH1dUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4352
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCk9uIDExLzAyLzIwMjEgMTM6MDcsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBCZW4sDQo+IA0KPiBPbiBU
aHUsIEZlYiAxMSwgMjAyMSBhdCAyOjAzIFBNIEJlbiBEb29rcyA8YmVuLmRvb2tzQGNvZGV0aGlu
ay5jby51az4gd3JvdGU6DQo+PiBPbiAxMC8wMi8yMDIxIDEzOjA3LCBHZWVydCBVeXR0ZXJob2V2
ZW4gd3JvdGU6DQo+Pj4gT24gTW9uLCBKYW4gMjUsIDIwMjEgYXQgNTozMyBQTSA8ZGFpcmUubWNu
YW1hcmFAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+Pj4+IEZyb206IERhaXJlIE1jTmFtYXJhIDxk
YWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPj4+Pg0KPj4+PiBBZGQgc3VwcG9ydCBmb3Ig
dGhlIE1pY3JvY2hpcCBQb2xhckZpcmUgUENJZSBjb250cm9sbGVyIHdoZW4NCj4+Pj4gY29uZmln
dXJlZCBpbiBob3N0IChSb290IENvbXBsZXgpIG1vZGUuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPj4+PiBS
ZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4+Pg0KPj4+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCENCj4+Pg0KPj4+PiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L0tjb25maWcNCj4+Pj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnDQo+Pj4+
IEBAIC0yOTgsNiArMjk4LDE2IEBAIGNvbmZpZyBQQ0lfTE9PTkdTT04NCj4+Pj4gICAgICAgICAg
ICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHRvIGVuYWJsZSBQQ0kgY29udHJvbGxlciBzdXBwb3J0
IG9uDQo+Pj4+ICAgICAgICAgICAgTG9vbmdzb24gc3lzdGVtcy4NCj4+Pj4NCj4+Pj4gK2NvbmZp
ZyBQQ0lFX01JQ1JPQ0hJUF9IT1NUDQo+Pj4+ICsgICAgICAgYm9vbCAiTWljcm9jaGlwIEFYSSBQ
Q0llIGhvc3QgYnJpZGdlIHN1cHBvcnQiDQo+Pj4+ICsgICAgICAgZGVwZW5kcyBvbiBQQ0lfTVNJ
ICYmIE9GDQo+Pj4+ICsgICAgICAgc2VsZWN0IFBDSV9NU0lfSVJRX0RPTUFJTg0KPj4+PiArICAg
ICAgIHNlbGVjdCBHRU5FUklDX01TSV9JUlFfRE9NQUlODQo+Pj4+ICsgICAgICAgc2VsZWN0IFBD
SV9IT1NUX0NPTU1PTg0KPj4+PiArICAgICAgIGhlbHANCj4+Pj4gKyAgICAgICAgIFNheSBZIGhl
cmUgaWYgeW91IHdhbnQga2VybmVsIHRvIHN1cHBvcnQgdGhlIE1pY3JvY2hpcCBBWEkgUENJZQ0K
Pj4+PiArICAgICAgICAgSG9zdCBCcmlkZ2UgZHJpdmVyLg0KPj4+DQo+Pj4gSXMgdGhpcyBQQ0ll
IGhvc3QgYnJpZGdlIGFjY2Vzc2libGUgb25seSBmcm9tIHRoZSBQb2xhckZpcmUgUklTQy1WDQo+
Pj4gQ1BVIGNvcmVzLCBvciBhbHNvIGZyb20gc29mdGNvcmVzIGltcGxlbWVudGVkIGluIHRoZSBQ
b2xhckZpcmUgRlBHQT8NCj4+Pg0KPj4+IEluIGNhc2Ugb2YgdGhlIGZvcm1lciwgd2Ugd2FudCB0
byBhZGQgYQ0KPj4+DQo+Pj4gICAgICBkZXBlbmRzIG9uIENPTkZJR19TT0NfTUlDUk9DSElQX1BP
TEFSRklSRSB8fCBDT01QSUxFX1RFU1QNCj4+DQo+Pg0KPj4gSSdkIHNheSBoYXZpbmcgaXQgb24g
Q09NUElMRV9URVNUIGlmIHRoZXJlJ3Mgbm8gcG9sYXJmaXJlIGluY2x1ZGVzDQo+PiB3b3VsZCBi
ZSB1c2VmdWwgdG8gYWxsb3cgY29tcGlsZSB0ZXN0aW5nIG9mIHRoZSBkcml2ZXIgYnkgdGhlIGJ1
aWxkDQo+PiByb2JvdHMuDQo+IA0KPiBBcyBjdXJyZW50bHkgdGhlcmUgaXMgbm8gcGxhdGZvcm0g
ZGVwZW5kZW5jeSBhdCBhbGwsIGl0IHdpbGwgYmUNCj4gY29tcGlsZS10ZXN0ZWQgYnkgYWxsbW9k
Y29uZmlnIG9uIGV2ZXJ5IGNvbmZpZyB0aGF0IGhhcyBQQ0lfTVNJICYmIE9GLg0KPiANCj4gR3J7
b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KVGhp
cyBQQ0llIGhvc3QgYnJpZGdlIGlzIGFjY2Vzc2libGUgZnJvbSBzb2Z0Y29yZXMgaW1wbGVtZW50
ZWQgaW4gdGhlIFBvbGFyRmlyZSBTb0MgRlBHQS4gIEJ1dCwgSSBzdGlsbCB0aGluZyBpdHMgcmVh
c29uYWJsZSB0byBhZGQgYSAnZGVwZW5kcyBvbiBDT05GSUdfU09DX01JQ1JPQ0hJUF9QT0xBUkZJ
UkUgfHwgQ09NUElMRV9URVNUJyBsaW5lLg0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVu
IC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhr
Lm9yZw0KPiANCj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9w
bGUsIEkgY2FsbCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpv
dXJuYWxpc3RzIEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQu
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCj4g
DQo=
