Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA1419E30
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 20:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhI0S1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 14:27:18 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:37367 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbhI0S1Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 14:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632767138; x=1664303138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gLLVnfvMMZYApUoBSfN9P3ikVi53dOCzEnWmAJPq9bQ=;
  b=NmY+BKlqV9llbQNc+GbiSSY84nIxwF5+uJblMjKqjijFSvPzpKtsFfa7
   PD24/VmtuLQJ+Lz7GobHV+zg3YjmgEdbfkgUsk3gCNd/rO7I+ibyiMVXf
   gMYISbaMPiLt9N5AAHgntaZR2IsBC5/n0+5tvhV+BkPIUe/kArr4Ypnx1
   iU1KmmN+Qn7sKMoF69iYxhNKaWzI7QdKJNRwEF75QJ6AuTEZOorTXTPo8
   fZLy/t/ZeOHiT0k2ceVRZhnsh+oFlL/R277KoAGOdA5dW6fHvaVUs21BD
   f1ZSj15e9Q2aegOcNtP1lukGNlp9zsJ/uOFvEeFWLmgsQnxd9TrD+gyVL
   Q==;
IronPort-SDR: 4jbURtLb069EabC1zfSpAJAl34Dmc7cme8AhuzYc3sZy9/Y3ybU3nzww6GQzTcRAdfSdGPDSLF
 7KHZe9sDemEp/Av9fQgS6/6NqfrtHYtGzo8r4Bg+/jUtIkxC64GbG46dfjd1+TbamxXBMFuiyw
 Tt0d3o5As9OI5e0Al7rirY/cyhYhkOs6zwOGTO7XNc6mK9bFPnBlfhC6Qh5XksXn/dUc0bwkI6
 9Jl5COvMKHbkKVkwVAFhtKItUuNJCfjyXxaxLXq2GvpZn1FeCQ1OcXT384CCIum3P4E5lXC1LS
 ZzBr6r6R/3MpT4qspjyJpiEl
X-IronPort-AV: E=Sophos;i="5.85,327,1624345200"; 
   d="scan'208";a="70810219"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2021 11:25:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Sep 2021 11:25:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Mon, 27 Sep 2021 11:25:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqwLsPaEVOFjQKK1exlk8s5OwKU2SRSBxWgcZM/lksHsBSbSQzhrUaZ9Q8AVxQCRsBrjuZwZZ4VqfbvWLAWXIPVIhKvnqM4Zu+8XJdieIrhUR0U1m9cVTBWueInn8p99MsSXpbJddfgBltFMuyN5AhZG11L0VFnTwounPnCinkzFFATM/WauCaRaR62Whg0c5k76M7NWcXujU8Bi8FNV9rTy5FkvnVIOmZ6W9ikfDRrXjslX1HATwqT90Uavj3qUhwut2ea2vfZbGBGISgMcWGGNKxjwQw366B0/oC75l8GRuV0a+0rRfMGWfXFeJOmQaQ71nplGNABTKvrSJ+6HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gLLVnfvMMZYApUoBSfN9P3ikVi53dOCzEnWmAJPq9bQ=;
 b=ePliXhNurItX7pYUlT5AfUs7+JIVRh8AYGUMAZyUu7BbkFfZQ8ThBQFdsJmhEVu8Gg9KEb6Z8icZC/KTKXxyY1WudZ0DkKgSOpYfNmm1wgmaMu01UoyZtHtCASPQIpoBv7IEyKrv5aMlIYf83YKNK5VPKeHsB913QbL+raHGKECuvL9Ur8ZINYwtwgeD1NW9KXJTa1sv07vk5abrlS5OHjg8Wq/jNPph3EoP6twutNBIltFQrunMHiqZbLiepYzez6admCGdAef5CZkx5k/c3ejOb2HZceSnmBAwDzp3KZhCXYdJcFaO7dmZf+ahdk30KuNzwovoLGPkKlUNx7zZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLLVnfvMMZYApUoBSfN9P3ikVi53dOCzEnWmAJPq9bQ=;
 b=DO4IB9pFTIUqEPFYM7N5rTVgC1xoOiTy/WHt3VUyZ6guBmQnGINnReSiV7qZJ71UvdAT1b1yaTc8VWe128efg0sbi7QsvKwiBkyeWzXC8j0QvYp3z3Oo7gqlX3zunnYQWJSx3hRP2L79GfDRoz4zyOhmVhxmXCsLsCU8Q7J1hNE=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5668.namprd11.prod.outlook.com (2603:10b6:5:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 18:25:33 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::652e:8046:89c3:1ecf]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::652e:8046:89c3:1ecf%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 18:25:33 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <kelvincao@outlook.com>, <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
Thread-Topic: [PATCH 0/5] Switchtec Fixes and Improvements
Thread-Index: AQHXsPrd45zTfENXRE24lSDAW63fTKu4Gp+AgAAdTAA=
Date:   Mon, 27 Sep 2021 18:25:33 +0000
Message-ID: <0ddbe6273acb215860fac5c2df83e54b48b0d1a5.camel@microchip.com>
References: <20210927163951.GA655671@bhelgaas>
In-Reply-To: <20210927163951.GA655671@bhelgaas>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2919c766-7087-46ee-d267-08d981e431b7
x-ms-traffictypediagnostic: CO6PR11MB5668:
x-microsoft-antispam-prvs: <CO6PR11MB5668351F67B1C68EB941CEED8DA79@CO6PR11MB5668.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FpfuZuabrW1i3uwV3gqAwSwd5lZk8wT7AlUMx45SjZS0utn8otXMODyRIEGceKhLjIrvBGpeb+e25TQJizm6WmhT9K5ll+uy6ib7AIjoEv45N/cdhDX+TZGnBJqL5Qe//ctTce3SN0ni5qsFuIm1i9YzFiKo+TSIip1rjzeCtuiAl43PMX+p1rcjyP5UA7LLtur7wbN+pT+rQ7qmfNfVbOlogko1VmOXG+Z9xdox85wAQueZ58mz+AA7aTVpVsLfvUINZtR24acc06uvJ6zIypj0E571A/niMwgV6pmQH71APaxAXSqIL59fn5E6hvU7bpBby8l7yAEvMkFcc/YTsOlgV8xTC3sMwV5BSHDgGqJ/LUrXWLKXwALvdg/8dO1Q5/qXQ6VDPolImj4Z/zYXl/rJwclgw53wIgEnOJ7Sf+f53O9HJE51TliQKAfVdUH5JaPWdIHd+f1RnKgqqh0wMPFuQM5RxIEnrf2p0b0QiQ6dy8Uwg6t4snamO56o0rqd0eJDjuKAsk+EmX154mJWTGVerPM5RGcBuWMdtQYtMVjTZpiY1aJGJU20uLNPEaHdMsBzArlm2Lj3OX6tOMQULbK7P8HTsTw6+4IenwMnSNoGksCBBn4W8JUASG+aluWjjUIS98ae9mG/+4XJmtyuKSCX6T/XeH9ApsgHo9ysmsG6RdXo5tGZufFgQF8tlIdpNmfylLrdNzTbcuy8uJe/vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(76116006)(91956017)(66946007)(4326008)(8676002)(6486002)(54906003)(38100700002)(36756003)(5660300002)(316002)(66556008)(64756008)(6916009)(66446008)(66476007)(86362001)(26005)(186003)(2616005)(71200400001)(6506007)(508600001)(122000001)(38070700005)(83380400001)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFQ3R0x1WEczVlp5enNWTVdIRUhQRmh5MCt6Z1dJQVdFTXJBa1lRUUhteFNl?=
 =?utf-8?B?c094MmpBTHcvVmxkeGdBM0NUQjNEVGFhMk4yZTRZRnB2TC9RU20rTk5HVlhS?=
 =?utf-8?B?WXJ5SXNHUnorZisxWXlnVTBTNWtybU1aUnZRb2NFb2JBVXU5aFg1d1Z6NUFN?=
 =?utf-8?B?Tkt2b29aT2dIV3lOUmk1L2FEWk95aFZUVU5lK3lzYmpqUjczRmR0TGhhcEhi?=
 =?utf-8?B?TUxzTDlXVUxsMkp4ZjlUTTBSeDVMUG5KTW9lY3NpUllUQUtqTDNzS1JNaUxK?=
 =?utf-8?B?QlhrQWM0Z293dDloT0p4dWM4R2FoSGFxOFAwU05SSXdiQTEzOG5mUWpFanJT?=
 =?utf-8?B?OE41WEpKS0RTVXhxTjVyZDJFeTVIOGNhbnJPdkVscXpremlzeGhFdHkxazZj?=
 =?utf-8?B?YUVwaHUxQUs0MTFWMUc1amtNZ1VySUJGUUVIMXhzaEg4anJUR2c2bVE4Kzlr?=
 =?utf-8?B?SUtwQnlyQm5kTzgxRGxyN3YyVElrUDhnclZod0RMcE1PcklMdzBuUTRMM0NJ?=
 =?utf-8?B?TS9WS3J4UEpSbHZLOW80OHdKMHJqQjdhWWZRZUl4akxYR25tUE0yWjF6Z05O?=
 =?utf-8?B?TFptMnFUTHJLMHpQcHp0TkpxWFh2N09CNTV6RmlabHQ4Z05BZHFERVJSSk9w?=
 =?utf-8?B?b1VwbnJvcllzbC81aWNWRGtsS2FJY2V2S1FRa1hYSU90ckZYcXRtMFBMcTBT?=
 =?utf-8?B?K3h4MTVqS0xxaVFKQXVBRnF1UDFwbWd5Z2VkOUpCOVRRb1VPWlcxdXBEMjVu?=
 =?utf-8?B?RUdSME1jcFloU3p3M1Zjb2FJSzc5Y21IMm40UUZra2Vxak50Q2RrZ0hXNnF1?=
 =?utf-8?B?N0ExRzhVMjJLYUk5Q1J2blh0RllubkdmTEhUVWh0alhTR0oxeVZYSmoxOHM4?=
 =?utf-8?B?NENyNXdkcittcTArSWhFMXNVV2NFY2pDd3pQQlFzL3UwOHB4UUs4ZlRKVFdo?=
 =?utf-8?B?UnJnZlhsTUtPazlCTEJuck8zQXVkQ29iNlQ1RWYxeVhpeW96dmt3NGJKdG1J?=
 =?utf-8?B?bmhRQTdzeU41VGJ4akhNTEp2VGlZaDkwUXZZSStoUzFhbTcrR2xIcU8wOEF1?=
 =?utf-8?B?VFlXcnFvZjQ3SHVwZ01kQTFRWm5WYjZzcTRmWGxleTV0NjQyN1ZvcENkT1hT?=
 =?utf-8?B?NWp2aE1EWHZaU3BUOFhDcWJrTGdCY0MxWmNHc3FOZExIenZYeHZCd3NnTHI2?=
 =?utf-8?B?ZWFrUU12UnllOGp2MmRCbDlTOHZFV040cFp3NVhHVG9YYkJyWHh1c056bEI0?=
 =?utf-8?B?QW9ES2VZZFRrcmY1YWhVK05jbzNuY01taHlBdENEbnV2QkMwSmE0U2poUCs4?=
 =?utf-8?B?MWtvWlVvY3gyZ1dLTVVkd2ZqUHhtVi8raHlmbnMrWXFyR1M2eEtFLzQvcTkx?=
 =?utf-8?B?OXpXR2w1UUlnNFJ4OEcySFIrVXYyN3p0TkhhN0dUTkFQTDR0WHhDOVhRUy9U?=
 =?utf-8?B?QXJyZnBqNWt4Wkc0WXdoQVRRRFozS1hESjYvRitSam5raGExSXk0a1VyQkty?=
 =?utf-8?B?emhtam55V0dLOHc5T1JSeUNtbllZanNmOGxpemp1YnZvWDJLbjdTVXFpRzA4?=
 =?utf-8?B?ajVhUUN2MnAvK21JSGVxLzNXdi9jQ25mR2pxbllONHI2TTBJN0VYUDFOcW9J?=
 =?utf-8?B?OG5pTDB6MEI2NWdTbFNiai90RVFSWCtzWVJvTWVuNURrcVZiYjFibGNDYjIr?=
 =?utf-8?B?M3lnSE1lTm1wOTI3OUM3R3JSMnhUMU1NYlIvQU5UVEtlalRZSmRmTlh0b1Q1?=
 =?utf-8?Q?P657WnwY9VHjkY23UbvcfAAoIhsOKL/Iwn6FCud?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <211BFEC334185142A6CA8FE2A18177E8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2919c766-7087-46ee-d267-08d981e431b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 18:25:33.4839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MsbhLko8n2Ks0lkn/gzxCkY8H7tNM5lm0M1VU2/sXQQJkBcL038hsA+I/qS9t5ZD5Qz76WPQ0IcYqEefKXRtTwyy3XCy8Z7dWQi6OqY0Wxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5668
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA5LTI3IGF0IDExOjM5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBGcmksIFNlcCAyNCwgMjAyMSBhdCAxMTowODozN0FNICswMDAwLCBrZWx2aW4uY2FvQG1p
Y3JvY2hpcC5jb20NCj4gd3JvdGU6DQo+ID4gRnJvbTogS2VsdmluIENhbyA8a2VsdmluLmNhb0Bt
aWNyb2NoaXAuY29tPg0KPiA+IA0KPiA+IEhpLA0KPiA+IA0KPiA+IFBsZWFzZSBmaW5kIGEgYnVu
Y2ggb2YgcGF0Y2hlcyBmb3IgdGhlIHN3aXRjaHRlYyBkcml2ZXIgY29sbGVjdGVkDQo+ID4gb3Zl
ciB0aGUNCj4gPiBsYXN0IGZldyBtb250aHMuDQo+ID4gDQo+ID4gVGhlIGZpcnN0IDIgcGF0Y2hl
cyBmaXggdHdvIG1pbm9yIGJ1Z3MuIFBhdGNoIDMgdXBkYXRlcyB0aGUgbWV0aG9kDQo+ID4gb2YN
Cj4gPiBnZXR0aW5nIG1hbmFnZW1lbnQgVkVQIGluc3RhbmNlIElEIGJhc2VkIG9uIGEgbmV3IGZp
cm13YXJlIGNoYW5nZS4NCj4gPiBQYXRjaA0KPiA+IDQgcmVwbGFjZXMgRU5PVFNVUFAgd2l0aCBF
T1BOT1RTVVBQIHRvIGZvbGxvdyB0aGUgcHJlZmVyZW5jZSBvZg0KPiA+IGtlcm5lbC4NCj4gPiBB
bmQgdGhlIGxhc3QgcGF0Y2ggYWRkcyBjaGVjayBvZiBldmVudCBzdXBwb3J0IHRvIGFsaWduIHdp
dGggbmV3DQo+ID4gZmlybXdhcmUNCj4gPiBpbXBsZW1lbnRhdGlvbi4NCj4gPiANCj4gPiBUaGlz
IHBhdGNoc2V0IGlzIGJhc2VkIG9uIHY1LjE1LXJjMi4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4g
S2VsdmluDQo+ID4gDQo+ID4gS2VsdmluIENhbyAoNCk6DQo+ID4gICBQQ0kvc3dpdGNodGVjOiBF
cnJvciBvdXQgTVJQQyBleGVjdXRpb24gd2hlbiBubyBHQVMgYWNjZXNzDQo+ID4gICBQQ0kvc3dp
dGNodGVjOiBGaXggYSBNUlBDIGVycm9yIHN0YXR1cyBoYW5kbGluZyBpc3N1ZQ0KPiA+ICAgUENJ
L3N3aXRjaHRlYzogVXBkYXRlIHRoZSB3YXkgb2YgZ2V0dGluZyBtYW5hZ2VtZW50IFZFUCBpbnN0
YW5jZQ0KPiA+IElEDQo+ID4gICBQQ0kvc3dpdGNodGVjOiBSZXBsYWNlIEVOT1RTVVBQIHdpdGgg
RU9QTk9UU1VQUA0KPiA+IA0KPiA+IExvZ2FuIEd1bnRob3JwZSAoMSk6DQo+ID4gICBQQ0kvc3dp
dGNodGVjOiBBZGQgY2hlY2sgb2YgZXZlbnQgc3VwcG9ydA0KPiA+IA0KPiA+ICBkcml2ZXJzL3Bj
aS9zd2l0Y2gvc3dpdGNodGVjLmMgfCA4NyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0N
Cj4gPiAtLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvc3dpdGNodGVjLmggICAgICB8ICAxICsNCj4g
PiAgMiBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4g
DQo+IEFwcGxpZWQgd2l0aCBMb2dhbidzIHJldmlld2VkLWJ5IHRvIHBjaS9zd2l0Y2h0ZWMgZm9y
IHY1LjE2LCB0aGFua3MhDQo+IA0KPiBJIHR3ZWFrZWQgdGhlIGNvbW1lbnQgc3BhY2luZyBpbiAi
UENJL3N3aXRjaHRlYzogRXJyb3Igb3V0IE1SUEMNCj4gZXhlY3V0aW9uIHdoZW4gbm8gR0FTIGFj
Y2VzcyIgc28gaXQgbWF0Y2hlcyB0aGUgZXhpc3Rpbmcgc2ltaWxhcg0KPiBjb21tZW50cy4NCg0K
VGhhbmtzIGZvciB5b3VyIHRpbWUhDQoNCkkgZ3Vlc3MgdGhlIHR3ZWFrIHdhcyBtYWRlIHRvICJQ
Q0kvc3dpdGNodGVjOiBSZXBsYWNlIEVOT1RTVVBQIHdpdGgNCkVPUE5PVFNVUFAiIHdoaWNoIGFs
c28gY29uZmlybWVkIHRoYXQgIkxpbms6IiB0YWcgc2hvdWxkIG5vdCBiZSBwdXQgdG8NCmEgZGlz
Y3Vzc2lvbiByZWZlcmVuY2UgVVJMIGxpbmUgaW4gdGhlIGNvbW1lbnQuDQoNCktlbHZpbg0K
