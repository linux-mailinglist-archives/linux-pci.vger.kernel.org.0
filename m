Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ACD396B7E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 04:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhFACpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 22:45:42 -0400
Received: from mail-mw2nam12on2055.outbound.protection.outlook.com ([40.107.244.55]:39457
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232268AbhFACpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 May 2021 22:45:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UK78gCtkcnlP0Zfy7TVhJGSSIzrM8M+Brvu+ullbHHcnycU6N2nzeQ9fCS5D5Bk6/qhHiCEN1ECZM4kgN0+FTMLP5OUkpDQw731G7jSl87V19no1eCg2OS5b0LvMOOQNSG3YQMM+EkDuA5pUbeEVo2DCJRegu4FkzyX42Yu/jhy495owcw8qeYPJCc2ijFFwwK0DTLpFLwX1AHzu6tepV/o11oOfbtRnu56igvnFEzHW65l00vndaoekpvZQbkLG1wdAZOKXKJYbF8udBoQeg1JguZmr4GEZ2eUbOWlAy5lrKPoiyL34m7BGbakV3a6Sbvl2cNQoXCoCuHYXaPqM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ady3VqnFEuoelQ7LgekfQODjYOWKl2gQ4C/eB7IXH6o=;
 b=OVbuFdGWAANhfTGc3cH8J0Km4QvFw33BY23nX/Nx6c442zARGKbveat23ziPJZLteH94YGvgwNqEni3Bd4g+uZQ0P8ef52+8+hkmFg4h6H+Be7gritqQUjtgU1aKQzGWlzpu9npwBzERXm5nh+eYKKhA7vfIwoedLQzaICiSSLpcnrBFApypdvFECjqdr7K/VsmzXrTAIiOkkzqIxi7CmLuv2ZU3lMYK0HzeJ6E/svTyUfzEkW2slhtQoERpV24uHASzRPBNlHfnf0F/++MaWze4QSIgX5ivqZzXtbbAUFH0m0kd845V1863xhgLJtt3iTMWzQGKXL49bDkdVtvsew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ady3VqnFEuoelQ7LgekfQODjYOWKl2gQ4C/eB7IXH6o=;
 b=dVqQhhv6n3X1kP8staXS/pOzq981r9GyrNAEYa0//bW64Af/JRUym+MVU64eGtD5oQ/GeBu/N/e6TereoOjJjfZmdmYBETB7+rhw1yYaWWLTYkE3s+ay7Q19vjS56n831p47sAfylaaxHcSUAfq17XTPsuGqhVAUTMBGFjc0nHM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Tue, 1 Jun 2021 02:43:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 02:43:58 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] PCI: Mark AMD Navi14 GPU 0x7341 rev 0x00 ATS as broken
Thread-Topic: [PATCH] PCI: Mark AMD Navi14 GPU 0x7341 rev 0x00 ATS as broken
Thread-Index: AQHXVfR3ThRP43EJlUmRVsJcFN7hhar9qfKAgADIQaA=
Date:   Tue, 1 Jun 2021 02:43:58 +0000
Message-ID: <DM6PR12MB2619C84F1168BD1B30AF4DBCE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210531081031.919611-1-evan.quan@amd.com>
 <20210531144041.GB157228@rocinante.localdomain>
In-Reply-To: <20210531144041.GB157228@rocinante.localdomain>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-01T02:43:54Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1358aa23-6112-4b9a-b5ea-06bf7254516d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7952997d-88cb-42d4-1b3d-08d924a71b85
x-ms-traffictypediagnostic: DM6PR12MB4926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4926969634F3C45E5CDA2EDCE43E9@DM6PR12MB4926.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7uk+hqc50TzrP/1L+aHWg7V1i8IbWSUngtuw3gLkik8Yi1yO+zEQK7qbhGHxhhnWq0ro1aaFMR6BAPtEO/9jgRuAGXftH1+kdFzlsJkZbUnDRQ7pq24BR8CCoR7N4Meyp0quMQtLHRw1Ljwmz0tUq5KAB3OM1nua0g8xPgLnHz3uwiM3hOzTqy6YoVwEiJ9KZ9YXeTE7aNelJgPCxAMhQziTviRibatKOudkN9SFOx6Y22Gv5PPQj/CjG2jvGXdkKbbEVSprTEMgg9yCVajyCiFnL7j0FwZijLv6x4tLAjFRRWTxj/KbOZ6WlqEc2mKrt3L7qV0t+py1gxDMjCNhngSScHIGf3yCBrvIWpsj5uzBst9yDh3s2aiHg6rCCs9/LlnJRuFavD766PwdFHVwiBZqTQSVEJCAWr1ZqO7f1n/vIf5N7lcQwqWs18SZMBswioqMIlGFh/7JtrXuitI4h6ij1wPSQXpOis3itl3zGYkV+iP5i9tzVeFs5MzTHotrZUfQHq8rvXp2f7AXA6JwqXRCCF7PkIgeLDyAzGuMHmL+Xab+49tMq2l80U1kv4ekuFsNO1RE+j2qyaxQ7jCydi9p+vvk3GYWZBMfhNUe6/M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(8936002)(33656002)(52536014)(8676002)(122000001)(9686003)(66476007)(66446008)(186003)(66556008)(478600001)(316002)(54906003)(71200400001)(86362001)(5660300002)(26005)(76116006)(66574015)(53546011)(6506007)(66946007)(7696005)(55016002)(2906002)(64756008)(6916009)(4326008)(83380400001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WmhrM2M5VmJmalk4VUtDeVY0M0xxUVArd3lyWkI0MXg1YlR3aFdWVS9DSzNL?=
 =?utf-8?B?THFhYmcxZXJweGw4RHNxK2lBMEVpNzlYOHo5Nk9qREJrMEh4ZGNxRnFpMHJD?=
 =?utf-8?B?cG9GTzlGZmNEdkkydlpmUE9WNFdVRDN5UGozRFpKczJVd3ZXeG52dGp3WkFS?=
 =?utf-8?B?VTZEZjQ1L05VK0srYzM5YmU4VTROd2IvYTg4M2c1VnFYUHlsbkdiODdMSkkx?=
 =?utf-8?B?RDJhV3kzcGlzNVRWc1p2dXo5N1JjTmd1U3N6d2xEQlpJaGJqbXQ4My83dEZr?=
 =?utf-8?B?TTZ6T1VqQWVWN055TEJ3aG9YYS85Uk80SlRBUnZzKzc0bFZNQkRxUU5sMEFj?=
 =?utf-8?B?aEw5cDhlTjNvNGtLWCtjbDFHK1h3eUE2b2JET3FWclZxTkFtMFppTDRYVE0v?=
 =?utf-8?B?N0dYTGVZaUNEVDRkaHFCYk1DNHJWT3VmVGIxam5ZUHhQSEVVNzJONzdzNU9O?=
 =?utf-8?B?clFWcm1wWEEzNkFwQnBPVTMva2N1ZzJjQndWWlorRU1DL3JINCtqV0FLMUdT?=
 =?utf-8?B?Snd3cWdiRnUzMVd6T0xvVVNoS2U3S3FJMmRVQ0RkaFlsUjhTUndUNlJQWnRY?=
 =?utf-8?B?WVFDQUR1NStmRDA0anlyVTlvQVNJSEhTYXRzekNnOGNQUERXUTZ5U2MrV2Zz?=
 =?utf-8?B?MEV5ODV0WFlHRVIzbDNQMkh6bzFVN1pvc0QyV3dybDdrRWpkUnVocXFaQ2NW?=
 =?utf-8?B?dG8rOG1Tb1dkK25zRnlNTGliSXd0QzRRT1JOMndza0Z2OXBmY2VDMWVKTHVo?=
 =?utf-8?B?UU0yWEVjY2JhazRMZ3Fsc0trajlCSTlrNzJvRjR0YS92TzJjYnpnQ2wvaTF2?=
 =?utf-8?B?TWo3cit6eVNtZVRrN01qWVI2eTd1WWg2eDNnZHVjaHpOejBRQ0gzMGI2Ymgr?=
 =?utf-8?B?UmRIY0NINDJucVNnTS9NWWc3WWZpdWs4MzRQRjkxa2tFQkhBeDRmTTJLTU9I?=
 =?utf-8?B?UDhydUtpb0dQdlNCQVhETi9jRmo3aVhqUy85bUYrenJLTXA0QjNPY0ZiTkFD?=
 =?utf-8?B?aDRVTjVSamFNK0c2ZDVjK0FHRU53ekh6eG10aGxFMHlURmJGY3lKZE0wM2ov?=
 =?utf-8?B?MFBQci9iWmFwdmM2NlREanNQeEtlb0JWVGVvWEVJQ1VCRW8zT214MjJvSVhk?=
 =?utf-8?B?Q2lPV3lSdDJoeWJ1bGxxazdGSjQzdnhqcnRLRnFEYzNzdm9leDdKKzFkWjJV?=
 =?utf-8?B?Z01Ld3JYbGlOaCs2T3pDb3FiSnlEb284N0EvY2owbDdyU3Y4ak5MYzN4UzdK?=
 =?utf-8?B?QTZzSkEyQVhOVVhHdWhoRnQxNTFrVWdkdTUxd3JBSEFJSVJzZURBK2QyTEs2?=
 =?utf-8?B?anVTenhhVkhoc3luVEpYZloxSUx6Q0wrcmNjQS9FbzZUdFFLMmtDZ0IvdHY3?=
 =?utf-8?B?VnNRVHZoSllyU1kyT2FVc2dkd3FiK3hpdGxrdXJPa3VZV0xQTHhKNU8xSXZo?=
 =?utf-8?B?M09SRFlFb2EzWElUT1lhSWY5N3dGUlViQjdRNmorQ2Vha3FXUHN3Nk55TzVp?=
 =?utf-8?B?V242N3FBb2RpZHhucVg3bGdxUlVGNWFWZDF6NTA2WEEzemZ0YVAvQlorOU5R?=
 =?utf-8?B?ejlmYmF0VUFuZlR4TEJ6ajZrc0tZMGx3eElCY1lwWTZRNldMcEE2UVJSdFMz?=
 =?utf-8?B?cWNILzdnYkc0ZlZBbU1PdlRsajl0Yk84Rk5wVUVxbTlNWXo5U3ovOEJqN01C?=
 =?utf-8?B?NGZZdCs1aHZDeTcwZkpRWFRTN0Rtc0tXSW1sVUdkelNYc1FkR1d3WE1IdzBl?=
 =?utf-8?Q?jgkhcTfHg74L6Z9eI5j3U5zpPlZDqlDfDvPGzAv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7952997d-88cb-42d4-1b3d-08d924a71b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 02:43:58.7913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a094D/CA5/Bzzp+IG3CM1PFoXKVoDDNx6HzoWLKYj0sB+O2cS3G3B7r+nrVooHQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4926
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzIEtyenlzenRvZi4gQ29tbWVudCBpbmxp
bmUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2ls
Y3p5xYRza2kgPGt3QGxpbnV4LmNvbT4NCj4gU2VudDogTW9uZGF5LCBNYXkgMzEsIDIwMjEgMTA6
NDEgUE0NCj4gVG86IFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQuY29tPg0KPiBDYzogbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IE1hcmsgQU1EIE5hdmkx
NCBHUFUgMHg3MzQxIHJldiAweDAwIEFUUyBhcw0KPiBicm9rZW4NCj4gDQo+IEhpIEV2YW4sDQo+
IA0KPiBUaGFuayB5b3UgZm9yIHNlbmRpbmcgdGhlIHBhdGNoIG92ZXIhDQo+IA0KPiBBIHNtYWxs
IG5pdHBpY2s6IHRoZSBzdWJqZWN0IGxpbmUgY291bGQganVzdCBzYXk6DQo+IA0KPiAgIEFkZCBx
dWlyayBmb3IgQU1EIE5hdmkgMTQgdG8gZGlzYWJsZSBBVFMgc3VwcG9ydA0KPiANCj4gT3Igc29t
ZXRoaW5nIGFsb25nIHRoZXNlIGxpbmVzLCBhcyBJIGFtIG5vdCBzdXJlIGhvdyB1c2VmdWwgdGhl
IElEIGFuZA0KPiByZXZpc2lvbiBhcmUgaW4gdGhlIHN1YmplY3QsIGVzcGVjaWFsbHkgc2luY2Ug
dGhlIGNvbW1pdCBtZXNzYWdlIGV4cGxhaW5zIGluDQo+IGRldGFpbHMgd2hhdCBoYXJkd2FyZSBp
cyBhZmZlY3RlZCwgZXRjLg0KPiANCltRdWFuLCBFdmFuXSBXaWxsIHVwZGF0ZSBpdCBpbiBWMi4N
Cj4gPiBVbmV4cGVjdGVkIEdQVSBoYW5nIHdhcyBvYnNlcnZlZCBkdXJpbmcgcnVucG0gc3RyZXNz
IHRlc3Qgb24gMHg3MzQxDQo+ID4gcmV2IDB4MDAuIEZ1cnRoZXIgZGVidWdnaW5nIHNob3dzIGJy
b2tlbiBBVFMgaXMgcmVsYXRlZC4gVGh1cyBhcyBhDQo+ID4gZm9sbG93dXAgb2YgY29tbWl0IDVl
ODljZDMwM2UzYSAoIlBDSToNCj4gPiBNYXJrIEFNRCBOYXZpMTQgR1BVIHJldiAweGM1IEFUUyBh
cyBicm9rZW4iKSwgd2UgZGlzYWJsZSB0aGUgQVRTIGZvcg0KPiA+IHRoZSBzcGVjaWZpYyBTS1Ug
YWxzby4NCj4gDQo+IEFzIHRoaXMgbWlnaHQgYmUgYSBjYW5kaWRhdGUgZm9yIGEgYmFjay1wb3J0
IHRvIGN1cnJlbnQgc3RhYmxlIGFuZCBsb25nLXRlcm0NCj4ga2VybmVscywgZG9lcyBpdCBoYXZl
IGFueSAiRml4ZXMiIHRhZyB3ZSBjb3VsZCBpbmNsdWRlIGhlcmUgZm9yIHJlZmVyZW5jZT8gIElm
DQo+IG5vdCwgdGhlbiBpdCdzIE9LLg0KW1F1YW4sIEV2YW5dIFdlIGhhdmUgYW4gaW50ZXJuYWwg
dGlja2V0L2xpbmsgZm9yIHRoaXMuIEJ1dCB0aGF0IGlzIG5vdCBhY2Nlc3NpYmxlIG91dHNpZGUg
QU1ELg0KU28sIEkgd291bGQgc2F5IHRoZXJlIGlzIG5vICJGaXhlcyIgdGFnIGF2YWlsYWJsZSBm
b3IgdGhpcy4NCj4gDQo+ID4gQ2hhbmdlLUlkOiBJM2Q5ZDU3MGJkNDczNzYyZTNiZmJiMjUxY2Y4
YWJhZjVhZjM4Y2VkOQ0KPiANCj4gSSBhc3N1bWUgdGhpcyBpcyBmcm9tIHNvbWUgY29kZSByZXZp
ZXcgc2VydmljZSBsaWtlIEdlcnJpdD8gIFdlIHVzdWFsbHkgYXMNCj4gcGVvcGxlIHRvIGRyb3Ag
dGhlc2Ugd2hlbiBzZW5kaW5nIHBhdGNoZXMgdG8gYmUgaW5jbHVkZWQgaW4gdGhlIGtlcm5lbCAo
c28NCj4gd2hlbiBzZW5kaW5nIHBhdGNoZXMgdXBzdHJlYW0pLg0KPiANCj4gCUtyenlzenRvZg0K
W1F1YW4sIEV2YW5dIFRoYW5rcyEgV2lsbCBkcm9wIGl0IGluIFYyLg0KDQpCUg0KRXZhbg0K
