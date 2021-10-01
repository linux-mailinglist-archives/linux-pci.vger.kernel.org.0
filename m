Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9F341F858
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbhJAXvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 19:51:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:25245 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhJAXvF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 19:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633132161; x=1664668161;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oDFddffowd28TTVJPcQs4DAlnX2c5s8+6mmV4d863pU=;
  b=ReFNyU6BFwXZWdJWa8/I42rZJBV6w9HcIPHFigTcSb7Y6PQfeRWB0LP2
   6wEdomTFHSQ5DUmZGNaqmjydYFdG+fYJufUrxiMxbeapTKSi9BnHf8jnk
   leXuqkG7f9gDiQEPa+gVcicalL2a14Jx4YBeVLjEms52rgJUdN2FINSiV
   e3W9+AUtdSf4zPB91EOH44M/tMvAZ2RyoEmw54JiU0AQzuc5TCVoGx+HC
   qMHZEJj60KblhHDX6vdEJFPjYMW4HDzpgm9JmnDtdfFVoP0x+ZLXJuX4q
   WCVNMiC3uUqw6rhbcuFCJHARw6levzjyRcaqzpfpOduhoKR/8QvtcB0Cm
   Q==;
IronPort-SDR: eMrJ1KLxPHJSqMTQh0howrEuhuZivUKJ+p2ow1926XigXgKMzt9jHTDrI6M1kORpoD5Z7s16CJ
 xFjhehAH5GzCOdvCNlDABv+KebZh+tACv87mY86X8WpeYGRSAdFq4g/4kjIwe0MuqcBuqNXEfC
 kzRM5/4dqlS+Hebj5tCLnG3Za7OJfymORcUl8Ee9FLvOAXmiR95oqxglSs6sNBdBBFVwBQiYyg
 ReycXPORUahZEqrgjHDIqy7WOCHqVShKm0OiGBl0lF0z58ibwteXH6P9aUk83jjbTatNc/1MeL
 I2ueCE/bg+gMpe5b1MhihSSY
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="134003032"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2021 16:49:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 1 Oct 2021 16:49:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Fri, 1 Oct 2021 16:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOW4MuZo7iE9VncWoP+ltoGdjGGM7blHyTMX8LP4keMmVFE84chIsRHJBjxc4JtMDUtmOxoPnUaUZRMY0BgFfUnyVveqSixqnUNFggxNqbrKSARXhDkwS5mGIYn6cKwOjXon1g7uROaYx+owLVy5YhAdT1n8GMfWYL9t7mIjcMj7tCQLHsVVZMXhE+C1Svh8SfHlICbkQrfcGMVezQ+fjYJG9rJ5H7TWFa7Y3h1tBD6WttuHv/btnrUDuRY5MLnphO52VQ+wqMC6+NeLD53ndFHiP/2Vf3gKjd5kXvO9isn7Ww+MyiYMZCAjwprBVk8ms+DZVsGr7r1SjeU8zMhKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDFddffowd28TTVJPcQs4DAlnX2c5s8+6mmV4d863pU=;
 b=jIaR3SFyxZr+uVJJOcRlljjAeW2afp/Mfd8LimnRTpFmoCNMKwDWWWtySJuIv0iFUcSiNQJ6QFn2VMZO0mZ26ZgKvFz1rMz97n0qKIp/lZ5ufWWtpi6hSMcA0dy7MJlDpSD3x+L7sff4gYHypPN6hzIRVkrMBhZ7oFgUyNgw3sfB9z8kTY2DaSkZyDDCLdC1v+el1hCxg9fFCgZH2SRsZmeyYtj1IuCpnl71O8TObLuCOscD6cbee7U/VgI6EqKDPWiyr4yZsLy4qmyGIR2NMoNH9JffhUgtTRGo6SvERYEsVF88l2ZpJZ+9insw07HmRJi7RjgB2etfocUZR2RL5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDFddffowd28TTVJPcQs4DAlnX2c5s8+6mmV4d863pU=;
 b=A5H6SgNgxHy21kZGOQ5w7lnfHYGA3bw5z6wmOS5NwST1gN3TSRBjajsZyChEsuI6aJaBewhwxoDft7a+rKR6W3F2EYNDThV1yRjdo49obRe6YYFG8UUrA+OmYK2juytfkUhdhNX5tRvwqqn/waFNhQNpx9VCk/hypMavPQgMjsg=
Received: from CO6PR11MB5618.namprd11.prod.outlook.com (2603:10b6:303:13f::24)
 by CO6PR11MB5649.namprd11.prod.outlook.com (2603:10b6:5:35b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Fri, 1 Oct
 2021 23:49:18 +0000
Received: from CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14]) by CO6PR11MB5618.namprd11.prod.outlook.com
 ([fe80::9166:4e26:f15:6d14%4]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 23:49:18 +0000
From:   <Kelvin.Cao@microchip.com>
To:     <helgaas@kernel.org>, <logang@deltatee.com>
CC:     <kurt.schwemmer@microsemi.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kelvincao@outlook.com>
Subject: Re: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Topic: [PATCH 1/5] PCI/switchtec: Error out MRPC execution when no GAS
 access
Thread-Index: AQHXsPrc5TKXfpZvzECl3XIr0t7wG6u+oQAAgAADAgCAADeugA==
Date:   Fri, 1 Oct 2021 23:49:18 +0000
Message-ID: <ed856f361ef3ca80e34c4565daffe6e566a8baa3.camel@microchip.com>
References: <20211001201822.GA962472@bhelgaas>
         <21326395-6d4b-07aa-f445-ecc5dc189d17@deltatee.com>
In-Reply-To: <21326395-6d4b-07aa-f445-ecc5dc189d17@deltatee.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0493ec51-7da3-4974-eda4-08d98536157e
x-ms-traffictypediagnostic: CO6PR11MB5649:
x-microsoft-antispam-prvs: <CO6PR11MB5649C65E42F5D9080426B6878DAB9@CO6PR11MB5649.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FFice9XvqJ2Rse4r0Tyf1/uYlqViS5z1HvCylr7AowbQzYEe44V3gZSRLJaX/hM31OxtaTE0tcmswunbEqXU9c0X6Jw47vYVyr0SiwfX5h04xyb1izk8JWO856Cw7bQmydG+HpPcW0ScJ1v0mUp5FmHSZkZ/ujXLLKRgRClqLkwEXUpGwJ2maehAiqQPHjt2gDVGNaMVox+fronvONmS9Ew/Y1h6lAow+pQMRYGq0PagJL1/LMK9c86Cay9U+Bk6E+pE9oKSP6fprxLUUI/N/CVqPLCbBmx4jgE8HIPNPSc6uqvxZDDJg8WlSPsPEllNA0hjZF2FlKJYhojt/OORMfTHT/zIvDVO+/ip/R6hrghA+Ao6Gp1jOGJnDyOfWEPyY9cw05HqnM54/Elqmxf1WW3LLq/dMF2qP4VeX6/c0bwNsFXBSwRa71KxKq179JKmnB0QTPEQa1S+EymsLYQQ9Okl8Ij7SCWKvgqKy4nIstWyU8sheJH9zTxI5Hd0kB58S2Pfq5SyQR2k2mw4AG85R9iT4V14Ge3cS4PIQjqsuypRC9sfzcFbKi0E2ulcQbWAYJi2EvfvLyOf2BsYDgB+8Na08urLUQT5Jyz+clg/F0tFrMcsmv1FALqf/1s+G86GirmG1B0x/358HKWuIXM41562WnZ+P4ysX6/7iuA6E7+thY1Y3oIEcOIIBJjNEDO58mxdvGQOlu2regnXpVS7qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5618.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6512007)(86362001)(2906002)(186003)(122000001)(508600001)(8676002)(38100700002)(110136005)(316002)(71200400001)(6506007)(2616005)(76116006)(66946007)(36756003)(66446008)(4326008)(53546011)(26005)(64756008)(8936002)(83380400001)(66476007)(66556008)(5660300002)(38070700005)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGx1TDFtR3kyaTNsVENFZ29FOXVKMHlDV3NQbXFKa3YvaGpoS3FIQjZrd1lr?=
 =?utf-8?B?UVJhTmMwbnRTUlg0a3EwMzQ3Q3RvWE5BYng4L1VPMVVnbHRGQkFOSUErVTBs?=
 =?utf-8?B?UXErclRSV2VBV09Ga2IwQit5WVNyQnI3TlYyR0REaCtPQVZMOG45d1plcFE3?=
 =?utf-8?B?SkVKKytiTmlhOFVKTEhTdHlBSmJvWmFyNi9jL2Znc3IzdW85SUZ6ZnVDWkZL?=
 =?utf-8?B?OXR0WElJM0RISk9DL0tmWFR4elpSN1ZxS1lSQWFXU2g0UjhBMVJXN3Q1NUFr?=
 =?utf-8?B?NUlGV3dyNEtPa3F5cmwrN0hHK3pDZDQ3dWlXc3pXWldTSWpHY1lwZ043NU5y?=
 =?utf-8?B?LzNzay9ONjJPSDllUEluTnQ1b1FXbk1aaUJBa09jYkFXZkxhM041N0VUbW1Y?=
 =?utf-8?B?SGJWYzJWSGZUKzNBTFRlWTVKVGtVU0pRSVdxU291TGs5TmxVNUlFVEhGRzh3?=
 =?utf-8?B?c2ppOUp0TU5QWHhGZFU5T3BVS1o2WWtrR2FaNEl5ZjVMZk1zZ2d6RExaUzdS?=
 =?utf-8?B?a3RyclZpYklERE5vV1BMcXY5eXhRclQrTWR1eVRBTDJRdnA5UCt1V2hRWkY5?=
 =?utf-8?B?c1RJU0t6T3N3OVZaeW8zMFNWcUJTUzEvY29PZ0tDVDk3ZVlzcXBhbXRCWjB6?=
 =?utf-8?B?azJLcy9CZlBGcytRU1RYSUZ0YWZVdzNmaVZ1REEySXBaVVRBc3p3MHJ1RnJV?=
 =?utf-8?B?aTZXa0ZVS2dVZFNZa2tjaVhEbW5ibUFTTU1lSUZ6SXl6VTBpRWhuRFR6RGgr?=
 =?utf-8?B?SUt6TTdIZk5MUEFyZWVQczBSVmpLdEpSbE9QVUdldURITWdGTGZMK1BZSFFw?=
 =?utf-8?B?c3prOW43bStlTFpGSWtoR0IveHZYV1hlNDkwbGExemh2SzNnTnZlZXdLTkRu?=
 =?utf-8?B?ZWkrbTVqQXZ4ZjMwcGtCOHMwUkxhQUx3Q1JhdWJJeHZEb1g3dkpjUnVBY2Qv?=
 =?utf-8?B?SmxzMkxlU1JkM2VraTQ1VXB4ZmZvbS8wUXRDbGFXelovOHlQcmpqWG1aM3Zk?=
 =?utf-8?B?MjBram5EQ2x3SUVOTEFkRWxjQ1ljaXJYZ1YzcmhWdm4rbkdZb0x6VFdFNDRI?=
 =?utf-8?B?V3VWS0dBUk1kYTBPU090amdRaUU5V1Z3aUVoRmxxTEs0UXMyeGVUWkg4aGlw?=
 =?utf-8?B?Wm9YVGo5NktuSy9XWFpqaHkxZ3JaWS9WNXd3TGpqTG1rZXZmU1duMElBZjFs?=
 =?utf-8?B?cmNmYWgrT29LemJHM3RFWXR4bGZibTVoTDZZaDVWZEluTitHcjN2TUlOdTNh?=
 =?utf-8?B?OGNlTlNMaHhScGxjZzBkOVBPa2ZLOEtyWjN0YjRZZDJKaURnU1dXQzdzSmJ0?=
 =?utf-8?B?dnRnU2YwZzJTcGRRWml1bVUvZDdRSlljWkNkTU1rblEzRFFyTnFJL3B5RjdK?=
 =?utf-8?B?MVhpenh3S3lYOUkwRUFtaW0ySmxuVlN5N0txbFZxbWN5T1c3MFNNMTVBNW1R?=
 =?utf-8?B?TmxWS3Q0b2kxaVFoUzJ5bFJWeEROS3B5bFdUSHh3ay91bk5GL25sVEpiRXUr?=
 =?utf-8?B?a0RpOFIzc09DY0xzcHVFMUl3K045bmIwcHVsNTFSSGJvRVBrVEJEaUdwZ1JW?=
 =?utf-8?B?ZVZsMFk1NVVtTUw1Mm52S0gwcCswbFMwVmo2bTJmK3NUZTFOQUpmUTlaVU1S?=
 =?utf-8?B?SVZGSW4rSjZVY2VMUFFFdE44L1ZmK21SRmtMcGl5MEFJYWpxZTJhSjJzczB6?=
 =?utf-8?B?ZE1hWTI1NVJuL0o2NmY4UStwSTI5dzVMbXI4MU4wQ2svSDY0OXN2cEwxZmti?=
 =?utf-8?B?UmFLVWF4NHRWVGZ0eFhkN2xIbkpXWmxicHlXNmp2ZlFiUzRicVQrUFIyMEhR?=
 =?utf-8?B?WjhCQytscWp3eHhRZlNydz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <57B2B6B4D9F5F245819FB071C60F3721@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5618.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0493ec51-7da3-4974-eda4-08d98536157e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 23:49:18.3918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9eQafnLMZlOBywVRUVWhNORMzICsSNvjP8KIbgik86xSqdQClkAA0XY6Fx5UJ/mRAkZTH490FriN5gLBDnCO+SGLkyig8ZD7WXu9eHkVCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5649
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTAxIGF0IDE0OjI5IC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjAyMS0x
MC0wMSAyOjE4IHAubS4sIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gT24gRnJpLCBTZXAgMjQs
IDIwMjEgYXQgMTE6MDg6MzhBTSArMDAwMCwga2VsdmluLmNhb0BtaWNyb2NoaXAuY29tDQo+ID4g
d3JvdGU6DQo+ID4gPiBGcm9tOiBLZWx2aW4gQ2FvIDxrZWx2aW4uY2FvQG1pY3JvY2hpcC5jb20+
DQo+ID4gPiANCj4gPiA+IEFmdGVyIGEgZmlybXdhcmUgaGFyZCByZXNldCwgTVJQQyBjb21tYW5k
IGV4ZWN1dGlvbnMsIHdoaWNoIGFyZQ0KPiA+ID4gYmFzZWQNCj4gPiA+IG9uIHRoZSBQQ0kgQkFS
ICh3aGljaCBNaWNyb2NoaXAgcmVmZXJzIHRvIGFzIEdBUykgcmVhZC93cml0ZSwNCj4gPiA+IHdp
bGwgaGFuZw0KPiA+ID4gaW5kZWZpbml0ZWx5LiBUaGlzIGlzIGJlY2F1c2UgYWZ0ZXIgYSByZXNl
dCwgdGhlIGhvc3Qgd2lsbCBmYWlsDQo+ID4gPiBhbGwgR0FTDQo+ID4gPiByZWFkcyAoZ2V0IGFs
bCAxcyksIGluIHdoaWNoIGNhc2UgdGhlIGRyaXZlciB3b24ndCBnZXQgYSB2YWxpZA0KPiA+ID4g
TVJQQw0KPiA+ID4gc3RhdHVzLg0KPiA+IA0KPiA+IFRyeWluZyB0byB3cml0ZSBhIG1lcmdlIGNv
bW1pdCBsb2cgZm9yIHRoaXMsIGJ1dCBoYXZpbmcgYSBoYXJkIHRpbWUNCj4gPiBzdW1tYXJpemlu
ZyBpdC4gIEl0IHNvdW5kcyBsaWtlIGl0IGNvdmVycyBib3RoIFN3aXRjaHRlYy1zcGVjaWZpYw0K
PiA+IChmaXJtd2FyZSBhbmQgTVJQQyBjb21tYW5kcykgYW5kIGdlbmVyaWMgUENJZSBiZWhhdmlv
ciAoTU1JTyByZWFkDQo+ID4gZmFpbHVyZXMpLg0KPiA+IA0KPiA+IFRoaXMgaGFzIHNvbWV0aGlu
ZyB0byBkbyB3aXRoIGEgZmlybXdhcmUgaGFyZCByZXNldC4gIFdoYXQgaXMgdGhhdD8NCj4gPiBJ
cyB0aGF0IGxpa2UgYSBmaXJtd2FyZSByZWJvb3Q/ICBBIGRldmljZSByZXNldCwgZS5nLiwgRkxS
IG9yDQo+ID4gc2Vjb25kYXJ5IGJ1cyByZXNldCwgdGhhdCBjYXVzZXMgYSBmaXJtd2FyZSByZWJv
b3Q/ICBBIGRldmljZSByZXNldA0KPiA+IGluaXRpYXRlZCBieSBmaXJtd2FyZT8NCkEgZmlybXdh
cmUgcmVzZXQgY2FuIGJlIHRyaWdnZXJlZCBieSBhIHJlc2V0IGNvbW1hbmQgaXNzdWVkIHRvIHRo
ZQ0KZmlybXdhcmUgdG8gcmVib290IGl0Lg0KPiA+IEFueXdheSwgYXBwYXJlbnRseSB3aGVuIHRo
YXQgaGFwcGVucywgTU1JTyByZWFkcyB0byB0aGUgc3dpdGNoIGZhaWwNCj4gPiAodGltZW91dCBv
ciBlcnJvciBjb21wbGV0aW9uIG9uIFBDSWUpIGZvciBhIHdoaWxlLiAgSWYgYSBkZXZpY2UNCj4g
PiByZXNldA0KPiA+IGlzIGludm9sdmVkLCB0aGF0IG11Y2ggaXMgc3RhbmRhcmQgUENJZSBiZWhh
dmlvci4gIEFuZCB0aGUgZHJpdmVyDQo+ID4gc2Vlcw0KPiA+IH4wIGRhdGEgZnJvbSB0aG9zZSBm
YWlsZWQgcmVhZHMuICBUaGF0J3Mgbm90IHBhcnQgb2YgdGhlIFBDSWUgc3BlYywNCj4gPiBidXQg
aXMgdHlwaWNhbCByb290IGNvbXBsZXggYmVoYXZpb3IuDQo+ID4gDQo+ID4gQnV0IHlvdSBzYWlk
IHRoZSBNUlBDIGNvbW1hbmRzIGhhbmcgaW5kZWZpbml0ZWx5LiAgUHJlc3VtYWJseSBNTUlPDQo+
ID4gcmVhZHMgd291bGQgc3RhcnQgc3VjY2VlZGluZyBldmVudHVhbGx5IHdoZW4gdGhlIGRldmlj
ZSBiZWNvbWVzDQo+ID4gcmVhZHksDQo+ID4gc28gSSBkb24ndCBrbm93IGhvdyB0aGF0IHRyYW5z
bGF0ZXMgdG8gImluZGVmaW5pdGVseS4iDQo+IA0KPiBJIHN1c3BlY3QgS2VsdmluIGNhbiBleHBh
bmQgb24gdGhpcyBhbmQgZml4IHRoZSBpc3N1ZSBiZWxvdy4gQnV0IGluDQo+IG15DQo+IGV4cGVy
aWVuY2UsIHRoZSBNTUlPIHdpbGwgcmVhZCB+MCBmb3JldmVyIGFmdGVyIGEgZmlybXdhcmUgcmVz
ZXQsDQo+IHVudGlsDQo+IHRoZSBzeXN0ZW0gaXMgcmVib290ZWQuIFByZXN1bWFibHkgb24gc3lz
dGVtcyB0aGF0IGhhdmUgZ29vZCBob3QgcGx1Zw0KPiBzdXBwb3J0IHRoZXkgYXJlIHN1cHBvc2Vk
IHRvIHJlY292ZXIuIFRob3VnaCBJJ3ZlIG5ldmVyIHNlZW4gdGhhdC4NCg0KVGhpcyBpcyBhbHNv
IG15IG9ic2VydmF0aW9uLCBhbGwgTU1JTyByZWFkIHdpbGwgZmFpbCAofjAgcmV0dXJuZWQpDQp1
bnRpbCB0aGUgc3lzdGVtIGlzIHJlYm9vdGVkIG9yIGEgUENJIHJlc2NhbiBpcyBwZXJmb3JtZWQu
DQoNCj4gVGhlIE1NSU8gcmVhZCB0aGF0IHNpZ25hbHMgdGhlIE1SUEMgc3RhdHVzIGFsd2F5cyBy
ZXR1cm5zIH4wIGFuZCB0aGUNCj4gdXNlcnNwYWNlIHJlcXVlc3Qgd2lsbCBldmVudHVhbGx5IHRp
bWUgb3V0Lg0KDQpUaGUgcHJvYmxlbSBpbiB0aGlzIGNhc2UgaXMgdGhhdCwgaW4gRE1BIE1SUEMg
bW9kZSwgdGhlIHN0YXR1cyAoaW4gaG9zdA0KbWVtb3J5KSBpcyBhbHdheXMgaW5pdGlhbGl6ZWQg
dG8gJ2luIHByb2dyZXNzJywgYW5kIGl0J3MgdXAgdG8gdGhlDQpmaXJtd2FyZSB0byB1cGRhdGUg
aXQgdG8gJ2RvbmUnIGFmdGVyIHRoZSBjb21tYW5kIGlzIGV4ZWN1dGVkIGluIHRoZQ0KZmlybXdh
cmUuIEFmdGVyIGEgZmlybXdhcmUgcmVzZXQgaXMgcGVyZm9ybWVkLCB0aGUgZmlybXdhcmUgY2Fu
bm90IGJlDQp0cmlnZ2VyZWQgdG8gc3RhcnQgYSBNUlBDIGNvbW1hbmQsIHRoZXJlZm9yZSB0aGUg
c3RhdHVzIGluIGhvc3QgbWVtb3J5DQpyZW1haW5zICdpbiBwcm9ncmVzcycgaW4gdGhlIGRyaXZl
ciwgd2hpY2ggcHJldmVudHMgYSBNUlBDIGZyb20gdGltaW5nDQpvdXQuIEkgc2hvdWxkIGhhdmUg
aW5jbHVkZWQgdGhpcyBpbiB0aGUgbWVzc2FnZS4NCj4gDQo+ID4gV2VpcmQgdG8gcmVmZXIgdG8g
YSBQQ0kgQkFSIGFzICJHQVMiLiAgTWF5YmUgZXhwYW5kaW5nIHRoZSBhY3JvbnltDQo+ID4gd291
bGQgaGVscCBpdCBtYWtlIHNlbnNlLg0KPiBHQVMgaXMgdGhlIHRlcm0gdXNlZCBieSB0aGUgZmly
bXdhcmUgZGV2ZWxvcGVycyBhbmQgaXMgaW4gYWxsIHRoZWlyDQo+IGRvY3VtZW50YXRpb24uIEl0
IHN0YW5kcyBmb3IgR2xvYmFsIEFkZHJlc3MgU3BhY2UuDQo+IA0KPiA+IFdoYXQgZG9lcyAiaG9z
dCIgcmVmZXIgdG8/ICBJIGd1ZXNzIGl0J3MgdGhlIHN3aXRjaCAodGhlDQo+ID4gc3dpdGNodGVj
X2RldiksIHNpbmNlIHlvdSBzYXkgaXQgZmFpbHMgTU1JTyByZWFkcz8NCj4gDQo+IFllcywgYSBi
aXQgY29uZnVzaW5nLiBUaGUgZmlybXdhcmUgaXMgZGVhZCBvciBub3Qgc2V0dXAgcmlnaHQgc28g
TU1JTw0KPiByZWFkcyBhcmUgbm90IHN1Y2NlZWRpbmcgYW5kIHRoZSByb290IGNvbXBsZXggaXMg
cmV0dXJuaW5nIH4wIHRvIHRoZQ0KPiBkcml2ZXIgb24gcmVhZHMuDQpEaXR0by4gV2lsbCB1cGRh
dGUgaW4gdjIuDQo+IA0KPiBMb2dhbg0K
