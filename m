Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E069504B6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 10:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfFXIma (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 04:42:30 -0400
Received: from mail-eopbgr710074.outbound.protection.outlook.com ([40.107.71.74]:19774
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbfFXIma (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 04:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UoAv2URrL1mFm/pb/fjjpx59JTD5tgu/SxhhtZGb33Q=;
 b=kCr5TlSkRMxPZqIOPtcUl/WuQDsAq0B4x9R+DnRlQWBsFDgOXUTx900OIGySSyPw46xn29eJwmDBxE7NNdN1c5sft/Eknvgp6SOEtwSXTULXQubSMAfAiFRPEacPj6G2HqoI4tKTNwMGGa/+MeMUgYNlmSElgmLEfswViwFt1JA=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1691.namprd12.prod.outlook.com (10.172.36.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Mon, 24 Jun 2019 08:42:27 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 08:42:27 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Topic: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Index: AQHVKkUW/DbjAREBykOqVpf3qUW28qaqfO+A
Date:   Mon, 24 Jun 2019 08:42:27 +0000
Message-ID: <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
In-Reply-To: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR0P264CA0151.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1b::19) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef662354-0da3-4108-e6c1-08d6f87fe2e9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1691;
x-ms-traffictypediagnostic: DM5PR12MB1691:
x-microsoft-antispam-prvs: <DM5PR12MB16919E31208644FF238EF64283E00@DM5PR12MB1691.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(476003)(186003)(8676002)(53936002)(64756008)(66556008)(478600001)(46003)(446003)(6246003)(68736007)(6116002)(58126008)(71200400001)(14454004)(2616005)(486006)(71190400001)(256004)(11346002)(316002)(64126003)(65956001)(65806001)(52116002)(99286004)(73956011)(6512007)(66446008)(386003)(76176011)(36756003)(66946007)(66476007)(7736002)(6506007)(31686004)(81166006)(81156014)(72206003)(305945005)(8936002)(65826007)(86362001)(31696002)(4326008)(6486002)(5660300002)(2906002)(229853002)(54906003)(6436002)(25786009)(6916009)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1691;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: J/xhVQCGpOYMv+5BLU0KDNPDkMcDb2e2kqP0XpXpbh/8tstC9vRtjMz/7atNohqU2iETd/t1rEkCmmFQ3lKLNem3rRI41L2rK1KLweM9rIOQwjbGPj0L9h+VWnofMkeYZFsdwEwanzKvLwAzOaxBVIeM79BWDdKoeZVadOZRT+PVs15YAbKlzZS6Aul4kE9BxLQSMUlpdOmh96unJ3EuilzQUPK5dKFJjc+XGpjB8VL20YXK2bN0bNonzu/1fHzICKowIyBl0dhs0R4epxYIRKP0hlXkUOSiTEe++IeL8AoiTymhItARF8Wu5QJWk6810gv6rQAc22tTBNLiVOCnUxJxybDX8Nwema0u97BnR2xPEFFuU7va8PSN1tCIidUuWmsTlddZQACAs6Uuh7B6oAxOeJ2htyq0wDcIHxk1V+o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06AD4B88C930B14FB94BDBAAD6E075CA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef662354-0da3-4108-e6c1-08d6f87fe2e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 08:42:27.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1691
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmVuLA0KDQpBbSAyNC4wNi4xOSB1bSAwNjoyNyBzY2hyaWViIEJlbmphbWluIEhlcnJlbnNj
aG1pZHQ6DQo+IEhpIENocmlzdGlhbiAhDQo+DQo+IFdoaWxlIGNsZWFuaW5nIHVwICYgY29uc29s
aWRhdGluZyByZXNvdXJjZSBtYW5hZ2VtZW50IGNvZGUgYWNjcm9zcw0KPiBhcmNocyBJIHN0dW1i
bGVkIHVwb24gdGhpcyBjYWxsIHRvIHBjaV9hc3NpZ25fdW5hc3NpZ25lZF9idXNfcmVzb3VyY2Vz
DQo+IGluIGFtZGdwdTphbWRncHVfZGV2aWNlX3Jlc2l6ZV9mYl9iYXIoKQ0KPg0KPiBXaHkgZG8g
eW91IG5lZWQgdGhpcyA/IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBwY2lfcmVzaXplX3Jlc291
cmNlKCkNCj4gd2lsbCBhbHJlYWR5IGJlIGNhbGxpbmcgcGNpX3JlYXNzaWduX2JyaWRnZV9yZXNv
dXJjZXMoKSBvbiB0aGUgcGFyZW50DQo+IGJyaWRnZSB3aGljaCBzaG91bGQgaGF2ZSB0aGUgc2Ft
ZSBlZmZlY3QuIE9yIGFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KPg0KPiBJJ2QgbGlrZSB0byBy
ZW1vdmUgdGhhdCBjYWxsIGlmIHBvc3NpYmxlLi4uDQoNCkJqb3JuIHN1Z2dlc3RlZCB0byBkbyBp
dCB0aGlzIHdheSBhbmQgaXQgaW5kZWVkIHByb3ZlZCB0byBiZSBsZXNzIGVycm9yIA0KcHJvbmUu
DQoNCkJhc2ljYWxseSBhbWRncHVfZGV2aWNlX3Jlc2l6ZV9mYl9iYXIoKSBmcmVlcyB0aGUgcmVz
b3VyY2VzIGZvciBvdXIgVlJBTSANCmFuZCBkb29yYmVsbCBCQVI6DQo+IMKgwqDCoMKgwqDCoMKg
IC8qIEZyZWUgdGhlIFZSQU0gYW5kIGRvb3JiZWxsIEJBUiwgd2UgbW9zdCBsaWtlbHkgbmVlZCB0
byBtb3ZlIA0KPiBib3RoLiAqLw0KPiDCoMKgwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX2Rvb3Ji
ZWxsX2ZpbmkoYWRldik7DQo+IMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT5hc2ljX3R5cGUgPj0g
Q0hJUF9CT05BSVJFKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3JlbGVh
c2VfcmVzb3VyY2UoYWRldi0+cGRldiwgMik7DQo+DQo+IMKgwqDCoMKgwqDCoMKgIHBjaV9yZWxl
YXNlX3Jlc291cmNlKGFkZXYtPnBkZXYsIDApOw0KDQpUaGVuIHdlIHJlc2l6ZSB0aGUgVlJBTSBC
QVIgYnkgY2FsbGluZyBwY2lfcmVzaXplX3Jlc291cmNlKCkuIFRoYXQgaW4gDQp0dXJuIHRyaWVz
IHRvIHJlc2l6ZSBhbmQgc2h1ZmZsZSBhcm91bmQgdGhlIHBhcmVudCBicmlkZ2UgcmVzb3VyY2Vz
IA0KdXNpbmcgcGNpX3JlYXNzaWduX2JyaWRnZV9yZXNvdXJjZXMoKS4NCg0KQnV0IHBjaV9yZWFz
c2lnbl9icmlkZ2VfcmVzb3VyY2VzKCkgZG9lcyBub3QgYXNzaWduIGFueSBkZXZpY2UgDQpyZXNv
dXJjZXMsIGl0IGp1c3QgdHJpZXMgdG8gbWFrZSBzdXJlIHRoZSB1cHN0cmVhbSBicmlkZ2VzIGhh
dmUgZW5vdWdoIA0Kc3BhY2UgdG8gZml0IGV2ZXJ5dGhpbmcgaW4uDQoNCkluZGVwZW5kZW50IGlm
IHdlIHN1Y2NlZWRlZCBvciBmYWlsZWQgd2l0aCBoYW5kbGluZyB0aGUgYnJpZGdlKHMpIHdlIA0K
Y2FsbCBwY2lfYXNzaWduX3VuYXNzaWduZWRfYnVzX3Jlc291cmNlcygpIHRvIHJlLWFzc2lnbiB0
aGUgcHJldmlvdXNseSANCmZyZWVkIHVwIFZSQU0gYW5kIGRvb3JiZWxsIEJBUnMuDQoNClNvIHll
YWgsIHRoaXMgZGVmaW5pdGVseSBuZWNlc3NhcnksIG9yIG90aGVyd2lzZSB0aGUgZHJpdmVyIHdv
dWxkIGNyYXNoIA0Kc29vbiBhZnRlciBiZWNhdXNlIHRoZSByZXNvdXJjZXMgYXJlIG5vdCBhc3Np
Z25lZCBhZ2Fpbi4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBDaGVlcnMsDQo+IEJl
bi4NCj4NCj4NCg0K
