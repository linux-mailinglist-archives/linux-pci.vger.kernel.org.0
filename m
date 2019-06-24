Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A8505F8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfFXJmM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:42:12 -0400
Received: from mail-eopbgr800050.outbound.protection.outlook.com ([40.107.80.50]:39664
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727914AbfFXJmM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 05:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgEb2TlnqMCM4efqksjgZptNnUvT02JMXL4AVU85NLM=;
 b=K7B4MjdoBpkERJQVsq7Hnm82+zAu9WD3QS2wpEdCNl8EfdaAk5o4uHcsIygW7DzWyFWcf512BC54ndh6l12mLAe+UDi5AOAL8Wrj1juUQDttgi6krFnpQIucGgtSnDHLx8Td9uWVQ8wrKklVcScm6El4K2woDiEduln2P9bPoJk=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1450.namprd12.prod.outlook.com (10.172.33.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 09:42:09 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:42:09 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Topic: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Index: AQHVKkUW/DbjAREBykOqVpf3qUW28qaqfO+AgAABiACAAAWqAIAAAhMAgAAHaYA=
Date:   Mon, 24 Jun 2019 09:42:09 +0000
Message-ID: <0680ee65-5960-18b8-d7a2-eb87ec2056ef@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
 <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
 <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
 <f4cb8429-a32d-d3af-dee0-0bae1935cb47@amd.com>
 <b873931988c7e6ccf61010e8ad03cf2d7f3e4b09.camel@kernel.crashing.org>
In-Reply-To: <b873931988c7e6ccf61010e8ad03cf2d7f3e4b09.camel@kernel.crashing.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR2P264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::31) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82bd91a1-9869-4f1c-0bfb-08d6f88839da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1450;
x-ms-traffictypediagnostic: DM5PR12MB1450:
x-microsoft-antispam-prvs: <DM5PR12MB145082CC4830E82D2A5E9A8683E00@DM5PR12MB1450.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(366004)(346002)(189003)(199004)(478600001)(8676002)(446003)(11346002)(6916009)(476003)(2616005)(486006)(52116002)(76176011)(386003)(6506007)(99286004)(66556008)(73956011)(102836004)(36756003)(71190400001)(71200400001)(66476007)(14444005)(66946007)(72206003)(65826007)(64126003)(46003)(2906002)(256004)(186003)(31686004)(14454004)(5660300002)(6436002)(68736007)(64756008)(8936002)(25786009)(6486002)(6246003)(66446008)(4326008)(81166006)(31696002)(81156014)(6512007)(54906003)(229853002)(86362001)(6116002)(65806001)(65956001)(53936002)(305945005)(7736002)(58126008)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1450;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8TUJLdRGGLONGm4MuerjWw6OZRfCX3GEqPiV2ztVoZiZ214AAf1fS89jfaXrVKU1G5SbwbM2Q8pYH/7au/20vxpgeAVMFeY4lQHu++xf4nM8JD8MzF/9W1WLMo65cwvvSujtlac1sbn0J73995nJKMcRRF1+e3+1y4uMmx3Bsa5/D0vLYOpADOdQ1+D+R4ns4BH/JZ2aNDPxodK4UW2F5OuU8+jKbFaUVHCMr63MYl/S0yUYdUpd+ieAX0ZOQrZN5gEZUvz0jyaUpFDaLR32mrpbl0xYV6KuWKPxZ1Kq8dLOS8ZO6wurDG2KQnpsGN+MlvpH81FzhuBVBqw7igZducNPINeqXxSXuovYfxeDaJWuUEAk5L0SCAeD7lyntLf2uCjJ8qxvllnFMn7vBb1PZF2fq4RkVAbEHPzxAnvOpF4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F696CB9320288F47AB4055A10B5BC374@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bd91a1-9869-4f1c-0bfb-08d6f88839da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:42:09.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1450
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjQuMDYuMTkgdW0gMTE6MTUgc2NocmllYiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0Og0KPiBP
biBNb24sIDIwMTktMDYtMjQgYXQgMDk6MDggKzAwMDAsIEtvZW5pZywgQ2hyaXN0aWFuIHdyb3Rl
Og0KPj4gWWVhaCwgY2FuJ3QgYWdyZWUgbW9yZSA6KSBJdCB3YXMgb25lIG9mIHRoZSBtYWluIGNo
YWxsZW5nZXMgaW1wbGVtZW50aW5nDQo+PiB0aGUgcmVzaXppbmcgc3VwcG9ydC4NCj4+DQo+PiBJ
ZiB5b3Ugd2FudCB0byBjbGVhbiB0aGlzIHVwIGZlZWwgZnJlZSB0byBDQyBtZSBhbmQgSSBjYW4g
dGFrZSBhIGxvb2sgYXMNCj4+IHdlbGwuIEJ1dCBob25lc3RseSBJIHdhcyBzY2FyZWQgb2YgdG91
Y2hpbmcgaXQgd2hlbiBJIHdvcmtlZCBvbiB0aGlzLA0KPj4gYmVjYXVzZSBvZiBhbGwgdGhlIGxp
dHRsZSBjb3JuZXIgY2FzZXMgeW91IGhhdmUgaW4gUENJLg0KPj4NCj4+PiBRdWVzdGlvbjogRG8g
eW91IGV2ZXIgbmVlZCB0byBhc3NpZ24gYW55dGhpbmcgb3RoZXIgdGhhbiB0aGF0IG9uZQ0KPj4+
IGRldmljZSB0aG91Z2ggPyBJbiBteSBicmFuY2gsIEkndmUgYWRkZWQgdGhpcyB0eXBpY2FsbHkg
Zm9yIHRoZSBjYXNlDQo+Pj4gd2hlcmUgYSBzaW5nbGUgZGV2aWNlIG5lZWRzIHRvIGJlIHJlYXNz
aWduZWQ6DQo+Pj4NCj4+PiArdm9pZCBwY2lfZGV2X2Fzc2lnbl9yZXNvdXJjZXMoc3RydWN0IHBj
aV9kZXYgKmRldikNCj4+PiArew0KPj4+ICsJTElTVF9IRUFEKGhlYWQpOw0KPj4+ICsNCj4+PiAr
CS8qIEFzc2lnbiBub24tZml4ZWQgcmVzb3VyY2VzICovDQo+Pj4gKwlfX2Rldl9zb3J0X3Jlc291
cmNlcyhkZXYsICZoZWFkKTsNCj4+PiArCV9fYXNzaWduX3Jlc291cmNlc19zb3J0ZWQoJmhlYWQs
IE5VTEwsIE5VTEwpOw0KPj4+ICsNCj4+PiArCS8qIEFzc2lnbiBmaXhlZCBvbmVzIGlmIGFueSAq
Lw0KPj4+ICsJcGRldl9hc3NpZ25fZml4ZWRfcmVzb3VyY2VzKGRldik7DQo+Pj4gK30NCj4+PiAr
RVhQT1JUX1NZTUJPTChwY2lfZGV2X2Fzc2lnbl9yZXNvdXJjZXMpOw0KPj4+DQo+Pj4gV291bGQg
dGhhdCB3b3JrIGZvciB5b3UgPw0KPj4gVGhhdCBzaG91bGQgd29yayBwZXJmZWN0bHkgZmluZS4N
Cj4gT2ssIElsbCBwbHVtYiBpdCB0aGF0IHdheSBpbiBteSBicmFuY2gsIEknbGwgbGV0IHlvdSBr
bm93IHdoZW4gaXQncw0KPiB3b3J0aCB0ZXN0aW5nLiBCVFcuIFdoaWNoIEdQVXMgdHlwaWNhbGx5
IGFyZSBhZmZlY3RlZCA/IEknbSBwcmV0dHkgc3VyZQ0KPiBteSBvbGQgUjkgMjkwIGlzbid0IDot
KSBCdXQgSSB3YXMgdGhpbmtpbmcgb2YgdXBncmFkaW5nIHNvLi4uDQoNCldlbGwgaW4gdGhlb3J5
IHdlIGhhdmUgdGhlIGZ1bmN0aW9uYWxpdHkgMTArIHllYXJzIG5vdywgYnV0IG9ubHkgDQphY3Rp
dmF0ZWQgaXQgaW4gYWxsIGhhcmR3YXJlIHZlcnNpb25zIHJlY2VudGx5Lg0KDQpQb2xhcmlzIGFu
ZCBWZWdhIHNob3VsZCBkZWZpbml0ZWx5IGhhdmUgaXQsIG9sZGVyIGhhcmR3YXJlIG1vc3QgbGlr
ZWx5IG5vdC4NCg0KWW91IGNhbiBjaGVjayB0aGUgUENJIGNhcGFiaWxpdGllcyBhbmQgbG9vayBm
b3IgIzE1LCBpZiBpdCdzIHByZXNlbnQgDQp0aGVuIHRoYXQgc2hvdWxkIGJlIHN1cHBvcnRlZC4N
Cg0KQ2hyaXN0aWFuLg0KDQo+DQo+IENoZWVycywNCj4gQmVuLg0KPg0KPg0KDQo=
