Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D11050533
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 11:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfFXJKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 05:10:15 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:31201
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727883AbfFXJKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jun 2019 05:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QickCkac+QAT6X0tF1lwXaBRiyyG3ctYd8M3Qcq+fF0=;
 b=HJgtohUmJNWl1czzhrYOWufZVQX3dXZaKkgckhHswJOJY7TXoRfV+DLTc6Sxbyu0EB7URhWLHsWHbezSc59GdrmF9K7WR13+LA2zsaXGw5qyPdP0g9lCol0woYpWo/Jmltz7BxqfhJ0prtz279zc5fMOXk6HhjnVlZsAz1enmS0=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1420.namprd12.prod.outlook.com (10.168.239.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 09:10:12 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:10:12 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Topic: Question about call to pci_assign_unassigned_bus_resources in
 amdgpu
Thread-Index: AQHVKkUW/DbjAREBykOqVpf3qUW28qaqfO+AgAABiACAAAJ6AIAAA76A
Date:   Mon, 24 Jun 2019 09:10:12 +0000
Message-ID: <cecc6a61-b481-02c3-d4e4-165de882cbfd@amd.com>
References: <ed3d3e4e87b54fa4d0d8e68abeebb7be6711b82a.camel@kernel.crashing.org>
 <71904c98-be86-2807-d5c9-4b90c7387f6f@amd.com>
 <ea9f770c373ad9c6a998edbd603972014e4b7fea.camel@kernel.crashing.org>
 <5a259297eeca3484565faf3166b2e4019047b478.camel@kernel.crashing.org>
In-Reply-To: <5a259297eeca3484565faf3166b2e4019047b478.camel@kernel.crashing.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR2P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:101:1::18) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ea1b826-e694-4f95-6cdb-08d6f883c354
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1420;
x-ms-traffictypediagnostic: DM5PR12MB1420:
x-microsoft-antispam-prvs: <DM5PR12MB14207870EE5A9319AD5390D583E00@DM5PR12MB1420.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(366004)(199004)(189003)(4326008)(256004)(66946007)(53936002)(186003)(76176011)(6512007)(73956011)(54906003)(229853002)(31696002)(316002)(64126003)(81156014)(72206003)(8936002)(25786009)(6116002)(14444005)(66556008)(71190400001)(6436002)(6486002)(36756003)(5660300002)(58126008)(64756008)(71200400001)(66476007)(66446008)(11346002)(446003)(476003)(2616005)(65806001)(65956001)(65826007)(102836004)(46003)(6916009)(478600001)(6506007)(386003)(68736007)(6246003)(81166006)(8676002)(52116002)(86362001)(305945005)(99286004)(7736002)(31686004)(2906002)(486006)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1420;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zCbdsYFQh4h/m77THa/rJfhe0l8ZEQd7MBvAAfG2wPCPt2xwwAPPuvxquIIjJi2d3SoQILc0Ao5Bp91RexMc5W5OOOMnZx2jJKQA4J6EFyRSksHYqWUQGPlMetKVDikUapKSt9Qp/fSZbmjWH2cBu+6UllvwmyeBZBzRBqMRx0o0SVz+8UcMEbmKOnYhU+kSmeENLapUi/NIW/GxQiOyeJvwPR1ghIPGuKG+wVRPnwGd5220rW5TEo3CIpBplLemUrfvlnqlg3/46OraK6ggG90KVMp5po2SNKnbTlhDTrg1U9k9gfEiMIElywnTOn9RHmrLdkx2hh6IJYLO73wGNBGqpBcVcBn6ipfgaygM03CV8uJuSPCvNtp/FmB7EhB++w1MEUwkZ+5Wu/Wp3FAZj5PMBvdJpBlki8seFqP4qCs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89CD84763129A249954BFEB8E1EEC834@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea1b826-e694-4f95-6cdb-08d6f883c354
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:10:12.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1420
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjQuMDYuMTkgdW0gMTA6NTYgc2NocmllYiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0Og0KPiBP
biBNb24sIDIwMTktMDYtMjQgYXQgMTg6NDcgKzEwMDAsIEJlbmphbWluIEhlcnJlbnNjaG1pZHQg
d3JvdGU6DQo+PiBPbiBNb24sIDIwMTktMDYtMjQgYXQgMDg6NDIgKzAwMDAsIEtvZW5pZywgQ2hy
aXN0aWFuIHdyb3RlOg0KPj4+IFRoZW4gd2UgcmVzaXplIHRoZSBWUkFNIEJBUiBieSBjYWxsaW5n
IHBjaV9yZXNpemVfcmVzb3VyY2UoKS4gVGhhdCBpbg0KPj4+IHR1cm4gdHJpZXMgdG8gcmVzaXpl
IGFuZCBzaHVmZmxlIGFyb3VuZCB0aGUgcGFyZW50IGJyaWRnZSByZXNvdXJjZXMNCj4+PiB1c2lu
ZyBwY2lfcmVhc3NpZ25fYnJpZGdlX3Jlc291cmNlcygpLg0KPj4+DQo+Pj4gQnV0IHBjaV9yZWFz
c2lnbl9icmlkZ2VfcmVzb3VyY2VzKCkgZG9lcyBub3QgYXNzaWduIGFueSBkZXZpY2UNCj4+PiBy
ZXNvdXJjZXMsIGl0IGp1c3QgdHJpZXMgdG8gbWFrZSBzdXJlIHRoZSB1cHN0cmVhbSBicmlkZ2Vz
IGhhdmUgZW5vdWdoDQo+Pj4gc3BhY2UgdG8gZml0IGV2ZXJ5dGhpbmcgaW4uDQo+IEhybS4uLiBh
cmUgeW91IHN1cmUgb2YgdGhpcyA/IE1heWJlIGl0IGhhcyBjaGFuZ2VkLi4uIG9yIEknbSBtaXNz
aW5nDQo+IHNvbWV0aGluZy4gQmVjYXVzZSByaWdodCBpbiB0aGUgbWlkZGxlIG9mIGl0IEkgc2Vl
Og0KPg0KPg0KPiAgIAlfX3BjaV9idXNfc2l6ZV9icmlkZ2VzKGJyaWRnZS0+c3Vib3JkaW5hdGUs
ICZhZGRlZCk7DQo+IAlfX3BjaV9icmlkZ2VfYXNzaWduX3Jlc291cmNlcyhicmlkZ2UsICZhZGRl
ZCwgJmZhaWxlZCk7DQo+DQo+IE5vdyB0aGUgc2Vjb25kIG9mIHRoZXNlIHdpbGwgY2FsbCBfX3Bj
aV9idXNfYXNzaWduX3Jlc291cmNlcygpIG9uIHRoZQ0KPiBicmlkZ2UtPnN1Ym9yZGluYXRlLCB3
aGljaCB3aWxsIHJlY3Vyc2l2ZWx5IGFzc2lnbiBhbGwgZGV2aWNlcyBiZWxvdw0KPiB0aGUgYnJp
ZGdlLg0KPg0KPiBPciBhbSBJIG92ZXJsb29raW5nIHNvbWV0aGluZyA/DQoNCkl0IGlzIHBlcmZl
Y3RseSBwb3NzaWJsZSB0aGF0IHRoaXMgY2hhbmdlZCBsYXRlciBpbiB0aGUgcGF0Y2ggc2V0LiBX
ZSANCmhhZCBzb21ldGhpbmcgbGlrZSA0IG9yIDUgaXRlcmF0aW9ucyB1bnRpbCBldmVyeXRoaW5n
IHNldHRsZWQuDQoNCj4gSXQgY291bGQgYmUgdGhhdCBpZiBpdCBmYWlscywgdGhlbiB5b3UgbmVl
ZCB0byByZXN0b3JlIHlvdXIgZGV2aWNlDQo+IHJlc291cmNlcyBpbmRlZWQuLi4gYnV0IHRoZSBu
b3JtYWwgY2FzZSBzaG91bGQgd29yayBmcm9tIG15IHJlYWRpbmcgb2YNCj4gdGhlIGNvZGUuDQoN
ClllYWgsIGl0IGlzIGRlZmluaXRlbHkgc3RpbGwgbmVjZXNzYXJ5IGZvciBlcnJvciBoYW5kbGlu
Zy4NCg0KUmVnYXJkcywNCkNocmlzdGlhbi4NCg0KPg0KPiBDaGVlcnMsDQo+IEJlbi4NCj4NCg0K
