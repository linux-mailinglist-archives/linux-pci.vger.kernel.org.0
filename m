Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4CF31E99C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Feb 2021 13:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBRMMr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Feb 2021 07:12:47 -0500
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:34977
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230174AbhBRJ7b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Feb 2021 04:59:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqDSQIiESJN9MHbGZHUW7H+yQ+aTeAB35B21IuecU+xPWxiLIUmr1my4BKHJnAsixuJhirtqTLd18XkIJKQPHaTyBx0qE3uZePe582/f5ZdxZjb5QV6UFTdRJeuux7Lm4vM+N7/w7POS69c3OQpBIIqn01yKbueWIowJxwShE27oKwYL5qfUbHy/aGA+eKMRZc+o0CgIQyvM3GLl9gTsTLVPuKijRDhNQuer+fZRDfIE6TtHJ2sX19NoPSNP9CZmpTAnuVOtxwXctKIn8FGP/4pp4gFmia5TcPLTaKAjwZuorbDb49lT1O7CLEcB4gdnSXNdHyRhffuuE0ewEiVoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOlGz/0VWUxzyJuDlyAS3z8ZZSt5yCcfYdUxIbmt6EU=;
 b=O0XlnfHw8gb1M+jeKIeNpc8YfU5/XgmaE+o5uARKVjTQa7xWwrT9RwGR5Lk5lbwysis14uuI1CX3+LZEo9hr9Pny9Nq+1bpcCZ+rDAHwNh1+fyDrVbjMluJTWVekHORq/VFLXUKcYjKZgz8Ke2BYcKTBVD20Y3Z09g5+95PzrTY2oDrvUPcoU1uenr81Yeal2e0r/LfvmZNRxJf41XAoMcFXCHIahtwrzpq8SKoAeaGW0mQbrtLuFKf8HOqllnkcxgL84DJrp6nKYr8vZMEfb5mS3Ts57nimtycL1II7vE+YKIE3qoHXKxHInnsztMS4Kbkiod9cCxBF/sTZ+u1UOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOlGz/0VWUxzyJuDlyAS3z8ZZSt5yCcfYdUxIbmt6EU=;
 b=oPZOVGK4PD+mRlft+LTmdDNqSmaeXVULigXKZn0hommAJyPLlKvyWIrWHvIW2yKKcXB0H4PqkINtyJdV4YsGYKp2l0cvlUhshlRIXdAAJXqp3tkMNA1jG/7hWrpYA/kBdw262VEMeaxpBEoPs96M3C3q6+gK3AWn3P3CYj03XCI=
Received: from BYAPR02MB5559.namprd02.prod.outlook.com (2603:10b6:a03:a1::18)
 by BYAPR02MB4869.namprd02.prod.outlook.com (2603:10b6:a03:45::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 18 Feb
 2021 09:58:37 +0000
Received: from BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ccbe:b88d:35e5:352e]) by BYAPR02MB5559.namprd02.prod.outlook.com
 ([fe80::ccbe:b88d:35e5:352e%7]) with mapi id 15.20.3846.039; Thu, 18 Feb 2021
 09:58:37 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [PATCH 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Topic: [PATCH 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
Thread-Index: AQHW/s0qYtrRH/FFh0ysSjP4qrIUJqpR7muAgAvNIkA=
Date:   Thu, 18 Feb 2021 09:58:37 +0000
Message-ID: <BYAPR02MB555984E91E03D882F92EF4A8A5859@BYAPR02MB5559.namprd02.prod.outlook.com>
References: <20210209101955.8836-1-bharat.kumar.gogada@xilinx.com>
 <YCRT6QVQai3oIvwf@rocinante>
In-Reply-To: <YCRT6QVQai3oIvwf@rocinante>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90076e2e-c3fd-47f6-700b-08d8d3f3c306
x-ms-traffictypediagnostic: BYAPR02MB4869:
x-microsoft-antispam-prvs: <BYAPR02MB4869D87BC4DB8ECBBF703FEAA5859@BYAPR02MB4869.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Odd+3lZ0vNed3l7jNC2kwSXb9vUITfuTm2LVN/EIoYp9rH08XeUKWoSZaKPIvwDb1qRaFyrqUg2sTFaA2VAhetCQpt2CCMMiTqwjKQvWD7Ud3yA6X6a2KymyLWNSXGvDZCfVa6T1Ua+CVJTb5bWJfDuxvfk9/IYqJDliDE3md9CyObvkmC2zKaGCpIbpAOdtXv3LilkuMPvcrlwWAG/0cHSIEY6Nl34SxlgCBUAPqUhio86XER5xqy3MhQTsysOjYt7zBB80kyUA/feglay26+X7ASTMBj9DWHpPZabZ8Z9XTtBP4QjqopRlSxhp/J16VeroEUZw5mlXaSBpmvAASMECDeslqv/5d5XxkCpzfMH4MaNA5IazzELHVN8L1c38oYRaushWdRi2kP+Mxr+7wbmXTaSgJVF4TN2jD/f3RFKhShpoJywa8g4sTc8zSwHwf8WL7ZlY3WTRXChMV36V8l7Wvp/TO6ngnmRi+WX3Yuj96hMmdbdBGfSaR88j/PwFcA8WCV5PES+IrUI4VO+BfSrM5jxAIKseReI0bEvdOnl1BFMK1xrWBVRaqz6QFJP6OI+q/H8r4tyEQat/40AYzR6fET8XAV7R+9bwnSGKocw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5559.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(4744005)(71200400001)(5660300002)(186003)(33656002)(316002)(26005)(966005)(8676002)(9686003)(4326008)(2906002)(7696005)(86362001)(66556008)(52536014)(66946007)(66446008)(76116006)(66476007)(83380400001)(54906003)(8936002)(64756008)(6506007)(478600001)(55016002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZW1PSm10NSs2bFI2WU0ybk9MWlEvMDY3TEoyT2tveFBmc01pUVRvT3d0YU5F?=
 =?utf-8?B?VUVtNjVvK2dkMGtSeWZDSDdjTHZ5d0RCSkprR0xuaTAwTXp0RGdzcGFYdUw5?=
 =?utf-8?B?b1JYdHFBVWJJNDFpUVlnME15S21RWEkrQVAwckgzM2o1RG8zRTliUk82UVh0?=
 =?utf-8?B?dVFIaVJrTlI0elljUnFkTG1VZ0ZaMGJnZk43ZlEwaFp3b3dVV0JwQXVxdkVM?=
 =?utf-8?B?MVVEakRxWVlHL09Wa3NMZVd0Q0hZYkJmc1dVVDhGdXVQaVlXQmhkUjVuYUxM?=
 =?utf-8?B?eVNvWmM2ZlJmbTFvUktTOURNR1l2eFJ0WTVGSTJ0d1lsUEM4NFgxRDNFalBL?=
 =?utf-8?B?ek9tZ0hoZ1dyUHp0ZWU0bGR4TTZ4NVMxb2lrcGk3RjRnblFhdXd0S0JpbG5Z?=
 =?utf-8?B?bGE4OW8rTVQyRUZ0djkwZFIrOFVpZk1qd1RpWWh6WU5Yejg0aGZIUXY2UFBs?=
 =?utf-8?B?NHZML2pvZml0ZFozSzVMOWswNGxSMjZnT0plUXZ4ZlkvRUZkQVlydytzeW82?=
 =?utf-8?B?MFVmWXlSWlJIWkdlZm05YTlzU2VTVHFjUU1NVnRNVGx3VkxESlplTDBJWWRs?=
 =?utf-8?B?RTB4K040djV5S1lkT0ZDdStoTVVrU3I5YkMyOW1tVWc2eUFMRE9aL251cEF2?=
 =?utf-8?B?d2V6MWVxTmJieVlHOHFHekN4ZEo5eFRXNVIwa0VPN0hUenl5L001dzFhcnJG?=
 =?utf-8?B?SlZUQmZ4bHVlckZoR3lhMHdDY2dERDlIVFdpbzlGVlNaKzVuSy9GbXEvMkpZ?=
 =?utf-8?B?bWc4RldRaWVsVDZjWTZjZ0FudFJTSEJISVJFQy8ydWpFalZCak5rTlE1Z0J4?=
 =?utf-8?B?NTNpcG84a1pkUzkzRHNBNGh2L016b1E5Sm9DZk9CRVptVnFsWEg5WHZGdmZQ?=
 =?utf-8?B?eUxzQ1pDZWlZR01maXdPUm1QTlQxaTZzQ04wdUp1QjkyWUFwZkQvcEFjN3BB?=
 =?utf-8?B?d3ZTK0lDeWxyUWtSTXFvak0xdWVEdE16Uk1lUHZ3ME92QktqcXVWSU8xQWZU?=
 =?utf-8?B?eXFzM3VUZWdPZXExV0VUODhTSkpxRWpwc3NxTWpRMHdWMUtIbjlvZjllZTZj?=
 =?utf-8?B?SGNJYkR0bEsvbWJNdUhITWtBdnFnOFZXNnJkbXlQNlZ3MGc2ci9xaS9KbVlX?=
 =?utf-8?B?Um5tbnJobXpPOEFlbFViV3dhZisxbU94alF5TDJIVTFvenVoeWw4a2RZSzdT?=
 =?utf-8?B?MnRzK3lEU2hnMlVtTnMrT3ZCaGtwUWZvdzQ1Tm1JNXBybmI4bmprQUoxUEow?=
 =?utf-8?B?NnNPSGduRjBkVERDSzd6RVdFMDVWMTdvNTgzRWJCeXFWZy9BcDVZSUFKT2E4?=
 =?utf-8?B?UWZod2pXRHZwaGpjeEZPTEJSUUdQbjZQNDZ4VzA3eWRlTkhtb0Z5bnFVVzFr?=
 =?utf-8?B?VEgvWGdSN28vVUhFcEVNdkRvY3d0NEQ0NU9VZndldEJsY1Z0Q0NGWGRZelhj?=
 =?utf-8?B?SzN5eFgzcEQ0bklRL0RNdGJtcmppcFdiTjRtYVZDR2I3TXJYSlpWbGtlMEdo?=
 =?utf-8?B?WEk1bEpjWTh4bFl3SGlPVEliR2ZpTW5ablBoU0FjOWs0cGNZTHFxaDkwL1cv?=
 =?utf-8?B?Mng1K2FJWjF2TGJiNWR0MjZrbkRQVDIzdjlxSjNhVmxIUzR6TGxaR0xnbnBK?=
 =?utf-8?B?M2FMS28rc3pBeFFrR2VNTG81NE43a2hrQlk2RUtzTDdOY25IQmdHdElaY0NZ?=
 =?utf-8?B?UnV2OUlNbDU3ZzVmR3ArRGdjUWZybjh4WWFLYUs2T1ppK0xFcWx5Q1JQWEYx?=
 =?utf-8?Q?JLBzq2dexgC8uB+YhQj/9gcdNVtNXXAzBwj3WuF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5559.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90076e2e-c3fd-47f6-700b-08d8d3f3c306
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 09:58:37.4328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QiYM0B8j3aNZ+fWuFm+2fQOE2qX2gIG9+NkUoZNneA/UvWy3RCTGtZnthsAfKGIETDMVLgP8flXixdar00Zh7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4869
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiBIaSBCaGFyYXQsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHNlbmRpbmcgdGhlIHBhdGNoZXMgb3Zl
ciENCj4gDQo+ID4gQWRkIHN1cHBvcnQgZm9yIHJvdXRpbmcgUENJZSBETUEgdHJhZmZpYyBjb2hl
cmVudGx5IHdoZW4gQ2FjaGUNCj4gPiBDb2hlcmVudCBJbnRlcmNvbm5lY3QgKENDSSkgaXMgZW5h
YmxlZCBpbiB0aGUgc3lzdGVtLg0KPiA+IFRoZSAiZG1hLWNvaGVyZW50IiBwcm9wZXJ0eSBpcyB1
c2VkIHRvIGRldGVybWluZSBpZiBDQ0kgaXMgZW5hYmxlZCBvcg0KPiA+IG5vdC4NCj4gPiBSZWZl
ciBodHRwczovL2RldmVsb3Blci5hcm0uY29tL2RvY3VtZW50YXRpb24vZGRpMDQ3MC9rL3ByZWZh
Y2UNCj4gPiBmb3IgQ0NJIHNwZWNpZmljYXRpb24uDQo+IFsuLi5dDQo+IA0KPiBBIHNtYWxsIG5p
dHBpY2ssIHNvIGZlZWwgZnJlZSB0byBpZ25vcmUsIG9mIGNvdXJzZS4NCj4gDQo+IFBlcmhhcHMg
IlJlZmVyIHRvIiBhbmQgImZvciB0aGUgQ0NJIiwgZXRjLg0KPiANCj4gWy4uLl0NCj4gPiArCS8q
IFRoaXMgcm91dGVzIHRoZSBQQ0llIERNQSB0cmFmZmljIHRvIGdvIHRocm91Z2ggQ0NJIHBhdGgg
Ki8NCj4gPiArCWlmIChvZl9kbWFfaXNfY29oZXJlbnQoZGV2LT5vZl9ub2RlKSkgew0KPiA+ICsJ
CW53bF9icmlkZ2Vfd3JpdGVsKHBjaWUsIG53bF9icmlkZ2VfcmVhZGwocGNpZSwNCj4gQlJDRkdf
UENJRV9SWDEpIHwNCj4gPiArCQkJCSAgQ0ZHX1BDSUVfQ0FDSEUsIEJSQ0ZHX1BDSUVfUlgxKTsN
Cj4gPiArCX0NCj4gWy4uLl0NCj4gDQo+IEEgc3VnZ2VzdGlvbi4NCj4gDQo+IFlvdSBjYW4gZHJv
cCB0aGUgY3VybHkgYnJhY2tldHMgaGVyZSBpZiB5b3Ugd2FudCB0byBrZWVwIHRoZSBzdHlsZSB1
c2VkIGluDQo+IHRoZSBrZXJuZWwsIGVzcGVjaWFsbHkgZm9yIHdoZW4gdGhlcmUgaXMgYSBzaW5n
bGUgc3RhdGVtZW50IGluc2lkZSB0aGUgY29kZQ0KPiBibG9jay4NCj4gDQpUaGFua3MgS3J6eXN6
dG9mLiBXaWxsIHJlbW92ZSBpdC4NCg==
