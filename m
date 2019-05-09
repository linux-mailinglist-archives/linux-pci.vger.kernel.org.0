Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5A19329
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 22:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfEIUDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 16:03:22 -0400
Received: from mail-eopbgr730044.outbound.protection.outlook.com ([40.107.73.44]:1280
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfEIUDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 16:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNJt8DVER3T54e4x7lJTuhnpM93D4pJ1uA/vT5503Dg=;
 b=0qjDmwCOA5aZN2ZWK7VmYrV9p8pTVIPGoTyLhMdFX5896XWJUY/pkuh48EgdzSJ4ulw81yUI4lv2DhQD56PZ7wKxbQWMOfm2NuuWPoYEDf4/cqEHpq8/illV/Uvlm4efpJNfkKS+AwLq3/8OZZkdQIHn01dZ7eMQ3Mv7mEUp+6k=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.40.14) by
 DM5PR12MB2534.namprd12.prod.outlook.com (52.132.141.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Thu, 9 May 2019 20:03:18 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::11db:1b41:d1e6:c6dc%11]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 20:03:18 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Eric Pilmore <epilmore@gigaio.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>
CC:     S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Thread-Topic: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Thread-Index: AQHU91hjNQoHErsWzEi/5FKxmzbafaZJlASAgAJQjoCAF3E2gA==
Date:   Thu, 9 May 2019 20:03:17 +0000
Message-ID: <8e4ccf44-9e4f-8007-ddcc-431440f9d533@amd.com>
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com>
 <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
 <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
In-Reply-To: <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR2101CA0004.namprd21.prod.outlook.com
 (2603:10b6:805:106::14) To DM5PR12MB1449.namprd12.prod.outlook.com
 (2603:10b6:4:10::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c88d6cf-8b25-4d71-65d8-08d6d4b96098
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB2534;
x-ms-traffictypediagnostic: DM5PR12MB2534:
x-microsoft-antispam-prvs: <DM5PR12MB253426787FF9848D0CD86340FD330@DM5PR12MB2534.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(110136005)(54906003)(446003)(6636002)(31686004)(73956011)(66946007)(186003)(478600001)(26005)(2906002)(256004)(229853002)(305945005)(71190400001)(66066001)(3846002)(99286004)(5660300002)(6116002)(66476007)(66556008)(64756008)(71200400001)(66446008)(52116002)(6512007)(36756003)(31696002)(486006)(81156014)(76176011)(2616005)(476003)(68736007)(6486002)(11346002)(81166006)(14454004)(8676002)(25786009)(6246003)(7736002)(316002)(53936002)(6506007)(102836004)(386003)(53546011)(72206003)(6436002)(4326008)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2534;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7PhfNKb+DqXlPYa05v4cK/UNuw/bTJRHI+7vKXOwFNPr2iQV/IXZih9AFezGugpA2VCmNPZQbEc74vnkZzaoBnKcZeZQkyzzNBQ7e49/35ZCXcW4lXRTINt274nTyp6c/efBSBijBeh2g8nU1igBJNVlHcAyl78IyXHi1gsGj0XTM83tHNDia+FEDD/P79V3BNaCanfuRm1FqW4I9zFUeB0J47G//gJzEmNGni+V7dAQuZ+/h893DzA+X6MVd1L7ojoRGRZWd/q4ZH2ceraJbJ8b3yy3t4Jn2XgeWTGQvi2eYVg9xa40GuIhDoB0n7Y+/8dOtnVZPlNJqEG/p/iiau9MLQ4aDB+itjG8ctLgG0bLqSXfoU1lj1LRev9lpUwLS8Q3zFQRFvHabGvrq9rBAddXIaeguS4yUnN3nGPuCVE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB3AB0C78BEA1A4DA8BDB947B84C94B1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c88d6cf-8b25-4d71-65d8-08d6d4b96098
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 20:03:18.0037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gNC8yNC8xOSA1OjA0IFBNLCBFcmljIFBpbG1vcmUgd3JvdGU6DQo+IE9uIFR1ZSwgQXByIDIz
LCAyMDE5IGF0IDQ6MDAgQU0gU2FuamF5IFIgTWVodGEgPHNhbm1laHRhQGFtZC5jb20+IHdyb3Rl
Og0KPj4NCj4+DQo+Pj4gQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgZGV2aWNl
PTIzOjAxLjIgZG9tYWluPTB4MDAwMA0KPj4+IGFkZHJlc3M9MHgwMDAwMDAwMGZkZTFjMThjIGZs
YWdzPTB4MDA3MF0NCj4+DQo+PiB0aGUgYWRkcmVzcyBpbiB0aGUgYWJvdmUgbG9nIGxvb2tzIHRv
IGJlIHBoeXNpY2FsIGFkZHJlc3Mgb2YgbWVtb3J5IHdpbmRvdy4gQW0gSSBSaWdodD8NCj4+DQo+
PiBJZiB5ZXMgdGhlbiwgdGhlIGZpcnN0IHBhcmFtZXRlciBvZiBkbWFfYWxsb2NfY29oZXJlbnQo
KSB0byBiZSBwYXNzZWQgYXMgYmVsb3csDQo+Pg0KPj4gZG1hX2FsbG9jX2NvaGVyZW50KCZudGIt
PnBkZXYtPmRldiwgLi4uKWluc3RlYWQgb2YgZG1hX2FsbG9jX2NvaGVyZW50KCZudGItPmRldiwg
Li4uKS4NCj4+DQo+PiBIb3BlIHRoaXMgc2hvdWxkIHNvbHZlIHlvdXIgcHJvYmxlbS4NCj4gDQo+
IEhpIFNhbmpheSwNCj4gDQo+IFRoYW5rcyB0aGUgZm9yIHRoZSByZXNwb25zZS4gIFdlIGFyZSB1
c2luZyB0aGUgY29ycmVjdCBkZXZpY2UgZm9yIHRoZQ0KPiBkbWFfYWxsb2NfY29oZXJlbnQoKS4g
VXBvbiBmdXJ0aGVyIGludmVzdGlnYXRpb24gd2hhdCB3ZSBhcmUgZmluZGluZw0KPiBpcyB0aGF0
IGFwcGFyZW50bHkgdGhlIEFNRCBJT01NVSBzdXBwb3J0IGNhbiBvbmx5IG1hbmFnZSBvbmUgYWxp
YXMsIGFzDQo+IG9wcG9zZWQgdG8gSW50ZWwgSU9NTVUgc3VwcG9ydCB3aGljaCBjYW4gc3VwcG9y
dCBtdWx0aXBsZS4gTm90IGNsZWFyDQo+IGF0IHRoaXMgdGltZSBpZiBpdCdzIGEgc29mdHdhcmUg
bGltaXRhdGlvbiBpbiB0aGUgQU1EIElPTU1VIGtlcm5lbA0KPiBzdXBwb3J0IG9yIGFuIGltcG9z
ZWQgbGltaXRhdGlvbiBvZiB0aGUgaGFyZHdhcmUuIFN0aWxsIGludmVzdGlnYXRpbmcuDQoNClBs
ZWFzZSBkZWZpbmUgJ2FsaWFzJz8NCg0KVGhlIElPX1BBR0VfRkFVTFQgZXJyb3IgaXMgZGVzY3Jp
YmVkIG9uIHBhZ2UgMTQyIG9mIHRoZSBBTUQgSU9NTVUgc3BlYywgDQpkb2N1bWVudCAjNDg4ODIu
IEVhc2lseSBmb3VuZCB2aWEgYSBzZWFyY2guDQoNClRoZSBmbGFncyB2YWx1ZSBvZiAweDAwNzAg
dHJhbnNsYXRlcyB0byBQRSwgUlcsIFBSLiBUaGUgcGFnZSB3YXMgDQpwcmVzZW50LCB0aGUgdHJh
bnNhY3Rpb24gd2FzIGEgd3JpdGUsIGFuZCB0aGUgcGVyaXBoZXJhbCBkaWRuJ3QgaGF2ZSANCnBl
cm1pc3Npb24uIFRoYXQgaW1wbGllcyB0aGF0IG1hcHBpbmcgaGFkbid0IGJlZW4gZG9uZS4NCg0K
Tm90IGJlaW5nIHN1cmUgaG93IHRoYXQgZGV2aWNlIHByZXNlbnRzLCBvciB3aGF0IHlvdSdyZSBk
b2luZyB3aXRoIElWSEQgDQppbmZvLCBJIGNhbid0IGNvbW1lbnQgZnVydGhlci4gSSBjYW4gc2F5
IHRoYXQgdGhlIEFNRCBJT01NVSBwcm92aWRlcyBmb3IgDQphIHNpbmdsZSBleGNsdXNpb24gcmFu
Z2UsIGJ1dCBhcyBtYW55IHVuaXR5IHJhbmdlcyBhcyB5b3Ugd2lzaC4NCg0KSFRIDQoNCmdyaA0K
