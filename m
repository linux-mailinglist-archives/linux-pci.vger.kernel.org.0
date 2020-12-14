Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263482D9334
	for <lists+linux-pci@lfdr.de>; Mon, 14 Dec 2020 07:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438698AbgLNGD6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Dec 2020 01:03:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16005 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393079AbgLNGD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Dec 2020 01:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607926130; x=1639462130;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wUzZGxSgUM/USgib7f2oAeFHdh3XSpnSQvTKjOx9fAg=;
  b=Xh1VXe7JkwICo26TUG4pJ0s/949Ye4nS/S+/BnbUYYDshcvcWJLe5iRz
   fqQpUr6lLjpG9Z6o4hjjKglQ7gCkDsMgyyFbB6nRsCo/GeucOjTNYy/3I
   pvkiQHGMbmnjnEXELPTYZ8pbKxcoVfWsNBlCj71LgKUzzUM/HhUs0SQbR
   0u0uKj1QaaqyG3jtYH/1WC5jLIUGxNMti0o9ewLO0CwAPbwGJompiRrJk
   h0espQCtZfXlJ97c0+S6WwcyEIH2mBdSJwCFvWi3n47YAq034IRtK2tCp
   1FGD8a05znqfMv8jyt8UrwScJNJZPQiU/343XWdEXBcUZ/i72GgTQD0W3
   w==;
IronPort-SDR: 5RdREdsH6A0B9RKf4v0PoiaarJKPuK43DpCeSxgQgqGij5H81fASDZ9YnqPZJ5pB9wTLiDNL1O
 nnzCa4bYZJ3WX+nD2CiAxSy1KyQMbBxKiSVUQAsu/Og95Bb2iYri3NiiO/6PPK9Tl9EbQk2sxl
 BVQkGlT19OtbrqfI7FIzZaZspcfY3MzrOoZomXDxLkhylhIu2ewMfbhHD5GZHJm8AgF9Lk1L60
 zRLwNCNgAJboyumQG3l049JhCXon/y/uZ64pTl9zWYHxMeUShRZNNjdZGBYJIvaKrQnADXKOn4
 Y4I=
X-IronPort-AV: E=Sophos;i="5.78,417,1599494400"; 
   d="scan'208";a="258824443"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2020 14:07:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ9Kx2zanPymga8nH1sy6uSfn9Hvh9gIvFa1jsnC3ZXtM1Vv9D1RiJDRg6hb6b+/cd8kg4veIHNLWqtCnwy8mUwqR3BZjTzrj7/jNClbusQsQpB/vv9QfLG10sFrdHj+B7767HmIFQFGnRHWBOH7uPIaSzLXFL0ZMXluNtKvJea6eTQQsZp9mUJT45oBRs7q+0MG7B5JyLqEk03dgKHqQjiCQ2pIZgg0K8BHnt4zEgx1SL/fzOPgcDt8C0MqULCHjl6Vd4iLZAFguXhbSYRPnpKSF5QMpzk/uAFiEuF5ILf7P2H7/iisVgXGFIR/1UPTGui5w012zg4c8XlxILdfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUzZGxSgUM/USgib7f2oAeFHdh3XSpnSQvTKjOx9fAg=;
 b=WpQi5+1ji/QBJkioL7QRSdUN9oP5uTKIO+UEdIuJXvmDIGZihHNWSsPEv3YAZqcz+LjzjLsT6KwdGYjVZ0AJkx8zAV7x9i+fZPKbt13xnVPF6AoN8aS5qQx8zWGQVcqjIOaasw3ZgyOykCbT+wU1lkwqDlmWlKYQ/J6SuCPlgw9Ikh5EaCPYTISRmCAHrHzsDP16Ql9xPLN3VoUiSSFaG5KGbNVQ8r6PwjAPkGRT3hnpOjn7eNm+paRwjkZtjG/e7bbwNyxzUqpdFyLdVUqUUkqWdEQdTlIHFuiY62txKPfAkdbeLTJ+oNle2A0c6ADnOMlb6j/qXJ0scAmKatAu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUzZGxSgUM/USgib7f2oAeFHdh3XSpnSQvTKjOx9fAg=;
 b=pdOO8LmTm9hXPZpPa9KZKRKi0inGPiwULjw2SrjB55pKHTNP9HCLuwQckfAjcuFEW0pLgMlHENv34jLN/MfHu6uO8qB6JKhwqOpRMz3s+tov5AFc9eoIOjJij6z55hjtDe7z0IR4F2ayL+AyDq5xxmsj/6/hLb/0FTXJJhtvt+E=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.18; Mon, 14 Dec
 2020 06:02:46 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3632.023; Mon, 14 Dec 2020
 06:02:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: block: skd: remove skd_pci_info()
Thread-Topic: [PATCH] drivers: block: skd: remove skd_pci_info()
Thread-Index: AQHWz9yGd2E3C3FU9k6e1R+lgZ5X4qn2HcCA
Date:   Mon, 14 Dec 2020 06:02:46 +0000
Message-ID: <8a04f06fdd8b8723f2f035f51ade56d8826b5618.camel@wdc.com>
References: <20201211164137.8605-1-puranjay12@gmail.com>
In-Reply-To: <20201211164137.8605-1-puranjay12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 (3.38.2-1.fc33) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7974c77b-f588-4338-b9fc-08d89ff5e0f0
x-ms-traffictypediagnostic: CH2PR04MB7078:
x-microsoft-antispam-prvs: <CH2PR04MB7078F2AB2DB4898F2616F389E7C70@CH2PR04MB7078.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 57e+VrBAkLTu+54CuRyW2gVDfTJtO4WlqvrfucxE25+2iyfQh2gKROEYbphkSFVboQmeNVGp2FtmoHu+AGP+bU2tjvDzywi6fP8hzcirlvH9ciqq65zCOBajgIVSrrbiRiM4vuG8HZQw0dbueswQilRh38ctlowhjWgpxhXSAywuW6KcOOZQq6beZhdaVBEXAw+cTchnGD/mWzjAkzBCnTj7oSv/aXpDpQuyDOQ+Uv7UfUSGQgNQPkuc5mE84Ng0HPS5ynAvKMLzYqbkvKZBKPVFHnEX2g5bDb/UMdpj9WqFWdKEsoNsxv2rRM/EmXtfWwTkdSAE7/YQKLcFUCa3/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(346002)(66946007)(66556008)(6486002)(66446008)(64756008)(66476007)(26005)(91956017)(2616005)(508600001)(76116006)(8936002)(71200400001)(86362001)(2906002)(6506007)(83380400001)(5660300002)(6512007)(110136005)(186003)(8676002)(36756003)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEFYZU9zYVhINWozNmRIU3pnM0YxZ01Iem4xWi9ZOVY1SGFRYWUvR251WWd0?=
 =?utf-8?B?am1WcTdva2RzSjBnQU04RTRnRWJtbXNMTGZDc0pyUUlsdWNRcVg2VzBxdS9W?=
 =?utf-8?B?MmpwS2hnaDJ1SkZ2blJXQk5BaXZjM2Vlc0tUZWR4TUxyVXNUOWl2T0ZCSEs3?=
 =?utf-8?B?ZzR3cmFvdUtLVWpsd04reVp1ZnJ2a3hsUDRLVmx6T3QxeHNvaXoybjVNUGRr?=
 =?utf-8?B?Tzl2S2ZJTWRGYnMrckpXaWlTTUFvYWkyRTdaMGx0anR4UXFzTkpmanBUYVJj?=
 =?utf-8?B?cFM1MnZtNXZsTHpmcjBON05SNVpvL2NpWkRsZEhheW9vR3NBcjlnNjNqZjlv?=
 =?utf-8?B?QjdKa3l5eXlnUEw5bUVKcUdrMExMdnh0elNzYXZMVUp2UmFDOUpTQVlnK2FR?=
 =?utf-8?B?cVgxOVYraXljL0lyZXJGQmJveFEwRGNmbEpiM2lJWGRCc2dxeU1qb0hzanc2?=
 =?utf-8?B?K25rQ3VYK2pPNVpSeVNvVkdmNXIwcmx2endob1hodGFxaGszZmRTTVBRTG9x?=
 =?utf-8?B?K0VGUVI1K1YxNnNFcFpuRUxQR0ZTUEU1MjduVjhJU0lkK3pNRElVMGI1VmRZ?=
 =?utf-8?B?VUxYOE00bHJjU2R5U2t1b090SURKWEhYZi8ydnAxRytBTTgvTndzNVA5N3pz?=
 =?utf-8?B?UzkxSnp6ejV0cHdrWklXVlBjS1UxZnZpa2FETG5wQk12WkpvQnhZaFdjQVNM?=
 =?utf-8?B?U0NldWFnWUYzbmt5TlQ5SGJ1WHF6Z0dtcERhOXBPeVp1Wm14T0hJYlY2b1BN?=
 =?utf-8?B?cEtkanVSVjY4OVV6anFOdFFYR0lya1l5bVlLaDRQV3cyTTcyQ2tEd285azRx?=
 =?utf-8?B?YkVuWUl2T3NqWEFvZEF4Z1Z6UXZsanIxaUJJNmhxN3E0WEtTOUd1K3JQRHRn?=
 =?utf-8?B?YTRkczQrbzVqUW1KZ3VRN3J3NHpFeDRHS1pkSzg0UTcxcUZmZ0RNdThBR1dJ?=
 =?utf-8?B?UURkbzNtWjFHUEFRN1R2eHRQaWFSV1ZBd2F0V1pBdWRFOGM5MGtadGV2Mnlv?=
 =?utf-8?B?Y1Z3bGFJQ3Axc25HeHB0UFZGN2ZHSlFBOHNGakNSTFFjMjRXTjNTNDRPazUr?=
 =?utf-8?B?NzByQU9JWnlVdDR3bjFWSEcxemFrSE9ndytESU8vaW9aOXVyb1Z2NDU1emFu?=
 =?utf-8?B?ZjdOVUFEdTVwakVoUVhNVnhDVFlBZlZIRXNvdUYvUno1QUdsTE9GL0xmMThy?=
 =?utf-8?B?dXdmMjdNZkFsSHVCSGFEMU9nWXV5bzBESktBenZMeEczVGNBYVM2L3lrQmlo?=
 =?utf-8?B?bDFtNDdGWjBjaTZoeEJLVSs5SG1jQjRFU2NsNm00TGVoUHorTkJsMUlQbFln?=
 =?utf-8?Q?bBaW5Wa8pSTUJh0Wx/72oKXAKyn7Qn2mKg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <99D88E88F9E3264A9ED3FD7E77A2CE58@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7974c77b-f588-4338-b9fc-08d89ff5e0f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2020 06:02:46.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gm1tDqEDAHxAT2cf6k4CsNwH3VQVCVHbyv9YfVNkT1k7JBoF4WU+HMkd6tcfgJ6AWRM4SC3X0wiaYrdpUmkywA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7078
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTExIGF0IDIyOjExICswNTMwLCBQdXJhbmpheSBNb2hhbiB3cm90ZToN
Cj4gUENJIGNvcmUgY2FsbHMgX19wY2llX3ByaW50X2xpbmtfc3RhdHVzKCkgZm9yIGV2ZXJ5IGRl
dmljZSwgaXQgcHJpbnRzDQo+IGJvdGggdGhlIGxpbmsgd2lkdGggYW5kIHRoZSBsaW5rIHNwZWVk
LiBza2RfcGNpX2luZm8oKSBkb2VzIHRoZSBzYW1lDQo+IHRoaW5nIGFnYWluLCBoZW5jZSBpdCBj
YW4gYmUgcmVtb3ZlZC4NCg0KSG1tbS4uLiBPbiBteSBib3gsIEkgc2VlIHRoaXMgZm9yIHRoZSBz
a2QgY2FyZDoNCg0KWyAgICA4LjUwOTI0M10gcGNpIDAwMDA6ZDg6MDAuMDogWzFiMzk6MDAwMV0g
dHlwZSAwMCBjbGFzcyAweDAxODAwMA0KWyAgICA4LjUxNTkzM10gcGNpIDAwMDA6ZDg6MDAuMDog
cmVnIDB4MTA6IFttZW0gMHhmYmUwMDAwMC0weGZiZTBmZmZmXQ0KWyAgICA4LjUyMTkyNF0gcGNp
IDAwMDA6ZDg6MDAuMDogcmVnIDB4MTQ6IFttZW0gMHhmYmUxMDAwMC0weGZiZTEwZmZmXQ0KWyAg
ICA4LjUyNzk1N10gcGNpIDAwMDA6ZDg6MDAuMDogcmVnIDB4MzA6IFttZW0gMHhmYmQwMDAwMC0w
eGZiZGZmZmZmDQpwcmVmXQ0KWyAgICA4LjUzNDk5OV0gcGNpIDAwMDA6ZDg6MDAuMDogc3VwcG9y
dHMgRDEgRDINCg0KTm8gbGluayBzcGVlZC4gQ2hlY2tpbmcgdGhlIGNvZGUsIEkgdGhpbmsgeW91
IG5lZWQgdG8gYWN0dWFsbHkgY2FsbA0KcGNpZV9wcmludF9saW5rX3N0YXR1cygpICh3aGljaCBj
YWxscyBfX3BjaWVfcHJpbnRfbGlua19zdGF0dXMoKSB3aXRoDQp2ZXJib3NlID0gdHJ1ZSkgZnJv
bSB0aGUgZHJpdmVyIHRvIHNlZSBhbnl0aGluZy4gT3RoZXJ3aXNlLCB0aGUgUENJZQ0KY29yZSB3
aWxsIG5vdCBwcmludCBhbnl0aGluZyBpZiB0aGUgZHJpdmVyIGlzIGp1c3QgcHJvYmluZyBhbmQg
Z2V0dGluZw0KcmVzb3VyY2VzIGZvciB0aGUgY2FyZC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
UHVyYW5qYXkgTW9oYW4gPHB1cmFuamF5MTJAZ21haWwuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJz
L2Jsb2NrL3NrZF9tYWluLmMgfCAzMSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDMxIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYmxvY2svc2tkX21haW4uYyBiL2RyaXZlcnMvYmxvY2svc2tkX21haW4uYw0KPiBpbmRl
eCBhOTYyYjQ1NTFiZWQuLmRhN2FhYzUzMzVkOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibG9j
ay9za2RfbWFpbi5jDQo+ICsrKyBiL2RyaXZlcnMvYmxvY2svc2tkX21haW4uYw0KDQpbLi4uXQ0K
PiDCoHN0YXRpYyBpbnQgc2tkX3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qg
c3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkNCj4gwqB7DQo+IMKgCWludCBpOw0KPiDCoAlpbnQg
cmMgPSAwOw0KPiAtCWNoYXIgcGNpX3N0clszMl07DQo+IMKgCXN0cnVjdCBza2RfZGV2aWNlICpz
a2RldjsNCj4gDQo+IMKgCWRldl9kYmcoJnBkZXYtPmRldiwgInZlbmRvcj0lMDRYIGRldmljZT0l
MDR4XG4iLCBwZGV2LT52ZW5kb3IsDQo+IEBAIC0zMjAxLDggKzMxNzIsNiBAQCBzdGF0aWMgaW50
IHNrZF9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2
aWNlX2lkICplbnQpDQo+IMKgCQlnb3RvIGVycl9vdXRfcmVnaW9uczsNCj4gwqAJfQ0KPiANCj4g
LQlza2RfcGNpX2luZm8oc2tkZXYsIHBjaV9zdHIpOw0KPiAtCWRldl9pbmZvKCZwZGV2LT5kZXYs
ICIlcyA2NGJpdFxuIiwgcGNpX3N0cik7DQoNClJlcGxhY2UgdGhlc2UgMiBsaW5lcyB3aXRoOg0K
DQoJcGNpZV9wcmludF9saW5rX3N0YXR1cyhwZGV2KTsNCg0KQW5kIHRoZSBsaW5rIHNwZWVkIGlu
Zm9ybWF0aW9uIHdpbGwgYmUgcHJpbnRlZC4NCg0KDQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldl
c3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0K
