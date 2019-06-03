Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6817A33B68
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 00:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFCWcq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 18:32:46 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52012 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfFCWcp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jun 2019 18:32:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53LVJA4001819;
        Mon, 3 Jun 2019 14:31:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=lQsGdy/BvG5BoOv67juD7MT2P/UTEXI8nnmVOKePQLU=;
 b=jTx5egSH0FwhtDk5uROP1SCOs60om43G2GuD1wc3U5BqZt0SopdevlQIBH239NoYTwcS
 PgQhpdR2EQvRayd7QYZIO6YMN4h/+TlJbOGSsCQUESVyYgMs5cMDDiW3AtCHBlTes1cU
 jBrAPSd0TSqz294h7OhfCyz8KN1p6dbrA9LExpCu83RXCac/0osmDCZFEoczOCUn7dLE
 xGoIhU0c46kpvc0DYXyxjbW4IchqmzlShXHrub13hqI4n1jSQwFHKJwRku3mGnBmIFv3
 4nxrMPPvkfxfX08VeNsFWsuwayz111p3G3MhLXeWgLbNprCvfkTmS1evPwsjS0H2bYTF +g== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2sw79ps1a7-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 03 Jun 2019 14:31:20 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Mon, 3 Jun
 2019 14:30:55 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.52) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 3 Jun 2019 14:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQsGdy/BvG5BoOv67juD7MT2P/UTEXI8nnmVOKePQLU=;
 b=bb+nssQUqqe1Czn9ngHHcHXSC8Y1KTT27XZsuCv1EbP9oDOAGIaE2nbv83Oc+vEFg/eDNM7A6GAMDMYB+mnLVUMDbKarjPkoVpZPWkPHFlTKIvDoHKx59xXg0/a7NehHryK9FcwoNULBBUnRJZ0T20RBOAgnUuESLL+ZjjCg6rw=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2944.namprd18.prod.outlook.com (20.179.22.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 21:30:50 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 21:30:50 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Andrew Vasquez <andrewv@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Myron Stowe <mstowe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@qlogic.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [EXT] VPD access Blocked by commit
 0d5370d1d85251e5893ab7c90a429464de2e140b
Thread-Topic: [EXT] VPD access Blocked by commit
 0d5370d1d85251e5893ab7c90a429464de2e140b
Thread-Index: AQHVFx5+bJqdlvMLuEaUREG4NUyQAKaEJpmAgAZSY4A=
Date:   Mon, 3 Jun 2019 21:30:50 +0000
Message-ID: <DFF05429-6C84-4DBD-B3D0-14A0BD209E38@marvell.com>
References: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com>
 <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
 <CAErSpo45bCV7geSPAwBjy5fdQqzDcX61Ybksk65c=intfTWFZQ@mail.gmail.com>
 <D8764654-E2A0-43B8-97D9-6644F2BC8D0E@marvell.com>
 <20190530205823.GA45696@google.com>
In-Reply-To: <20190530205823.GA45696@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [198.186.1.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd61acaa-1b69-47d5-f77e-08d6e86ac022
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2944;
x-ms-traffictypediagnostic: MN2PR18MB2944:
x-microsoft-antispam-prvs: <MN2PR18MB2944A9964340A40678BD8165D6140@MN2PR18MB2944.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(396003)(366004)(39860400002)(199004)(189003)(102836004)(6512007)(15650500001)(36756003)(6916009)(26005)(54906003)(486006)(256004)(14444005)(186003)(446003)(99286004)(6506007)(6246003)(82746002)(11346002)(66446008)(76116006)(53936002)(66946007)(64756008)(66476007)(91956017)(68736007)(4326008)(2616005)(476003)(53546011)(66556008)(73956011)(76176011)(71200400001)(86362001)(478600001)(229853002)(25786009)(14454004)(5660300002)(50226002)(2906002)(33656002)(8936002)(316002)(81156014)(81166006)(66066001)(8676002)(7736002)(6436002)(6486002)(6116002)(83716004)(71190400001)(57306001)(3846002)(5024004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2944;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: I/H6BpCDf1+rsiWQFVqwR6T2iKUQLjpOuKg99BbvNd9j8TzbSCfG7dTkXwxXwbaXhnGXhDyEeIUPZm+qxop4qenwvFePnLjKurnc3dettPerA1K6pH7C2brqtncioDPZ7F/gCGFxgo1/OfoxOxKEWSgmvzVicAyE5puIPEdf9NFiZpeklCrXZU7JKmvJpB6MKIAjuqnbPuMOGQpP6dqmFX3282lej+mEbr9kced6wUW3Kga0DGjQv+24M08r/rZ0H79xvZ0ool3YSXw7/u1OcgVA40hveL0f3zKeWsizn5buTQM9APKHj1U6rJZRLqI6OAOQGw/eNc81qMt48zPVbO2PDPNBuXr2hXWepVkGix4FMXdD8jhInwEc3kloWD3996rqk2POU7rqBpCBDLEzMORcP7HHep2zIt4hVEboQOg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BCD98764AA87146BB5FAA87E6955DCA@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fd61acaa-1b69-47d5-f77e-08d6e86ac022
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 21:30:50.5629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2944
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_17:,,
 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sIA0KDQo+IE9uIE1heSAzMCwgMjAxOSwgYXQgMTo1OCBQTSwgQmpvcm4gSGVsZ2Fh
cyA8aGVsZ2Fhc0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFRodSwgTWF5IDMwLCAyMDE5
IGF0IDA3OjMzOjAxUE0gKzAwMDAsIEhpbWFuc2h1IE1hZGhhbmkgd3JvdGU6DQo+IA0KPj4gV2Ug
YXJlIGFibGUgdG8gc3VjY2Vzc2Z1bGx5IHJlYWQgVlBEIGNvbmZpZyBkYXRhIHVzaW5nIGxzcGNp
IGFuZCBjYXQNCj4+IGNvbW1hbmQNCj4gDQo+IFllcywgeW91IG1lbnRpb25lZCB0aGF0IGluIHRo
ZSB2ZXJ5IGZpcnN0IGVtYWlsLiAgSSB3YXMgaG9waW5nIHlvdQ0KPiB3b3VsZCBpbmNsdWRlIHRo
ZSBhY3R1YWwgZGF0YSwgZS5nLiwgImNhdCB2cGQgfCB4eGQiLiAgVGhhdCB3b3VsZCBoZWxwDQo+
IHVzIGZpZ3VyZSBvdXQgd2h5IHlvdSBkb24ndCBzZWUgdGhlIHBhbmljIGFueSBtb3JlLiAgSSBz
dXNwZWN0IGVpdGhlcjoNCj4gDQoNCk1pc3NlZCB0aGUgcmVxdWVzdCBmb3IgeHhkIG91dHB1dC4g
SSBnb3QgYWNjZXNzIGJhY2sgdG9kYXkgZm9yIHRoZSBzeXN0ZW0gDQphbmQgY2FwdHVyZWQgaXQg
Zm9yIHlvdQ0KDQojIGNhdCAvc3lzL2NsYXNzL3BjaV9idXMvMDAwMFw6MTMvZGV2aWNlLzAwMDBc
OjEzXDowMC4wL3ZwZCAgfCB4eGQNCjAwMDAwMDAwOiA4MjJkIDAwNTEgNGM2ZiA2NzY5IDYzMjAg
MzMzMiA0NzYyIDIwMzIgIC4tLlFMb2dpYyAzMkdiIDINCjAwMDAwMDEwOiAyZDcwIDZmNzIgNzQy
MCA0NjQzIDIwNzQgNmYyMCA1MDQzIDQ5NjUgIC1wb3J0IEZDIHRvIFBDSWUNCjAwMDAwMDIwOiAy
MDQ3IDY1NmUgMzMyMCA3ODM4IDIwNDEgNjQ2MSA3MDc0IDY1NzIgICBHZW4zIHg4IEFkYXB0ZXIN
CjAwMDAwMDMwOiA5MDM5IDAwNTAgNGUwNyA1MTRjIDQ1MzIgMzczNCAzMjUzIDRlMGQgIC45LlBO
LlFMRTI3NDJTTi4NCjAwMDAwMDQwOiA0MTQ2IDQ0MzEgMzUzMyAzMzU5IDMwMzIgMzkzOSAzOTQ1
IDQzMGYgIEFGRDE1MzNZMDI5OTlFQy4NCjAwMDAwMDUwOiA0MjRiIDMzMzIgMzEzMCAzNDMwIDM3
MmQgMzAzNSAyMDMwIDMzNTYgIEJLMzIxMDQwNy0wNSAwM1YNCjAwMDAwMDYwOiAzOTA2IDMwMzEg
MzAzMSAzODM5IDUyNTYgMDFhMCA3OCAgICAgICAgIDkuMDEwMTg5UlYuLngNCg0KDQpQQ0llIHRy
YWNlIGFsc28gY29uZmlybWVkIHRoZXJlIGFyZSBubyBSRUFEIGVycm9ycy4gDQooaWYgeW91IG5l
ZWQgaSBjYW4gYXR0YWNoIC5wZXggZmlsZSBmb3IgcmV2aWV3KQ0KDQoNCj4gIC0gbmV3IFFMb2dp
YyBmaXJtd2FyZSBmaXhlZCB0aGUgc3RydWN0dXJlIG9mIHRoZSBWUEQgZGF0YSBzbyBMaW51eA0K
PiAgICBubyBsb25nZXIgYXR0ZW1wdHMgdG8gcmVhZCBwYXN0IHRoZSBlbmQgb2YgdGhlIGltcGxl
bWVudGVkIHJlZ2lvbiwNCj4gICAgb3IsDQo+IA0KPiAgLSB3ZSBzdGlsbCByZWFkIHBhc3QgdGhl
IGVuZCBvZiB0aGUgaW1wbGVtZW50ZWQgVlBEIHJlZ2lvbiwgYnV0IHRoZQ0KPiAgICBkZXZpY2Ug
ZG9lc24ndCByZXBvcnQgYW4gZXJyb3Igb3IgdGhlIHBsYXRmb3JtIGRlYWxzIHdpdGggdGhlDQo+
ICAgIGVycm9yIHdpdGhvdXQgY2F1c2luZyBhIHBhbmljLg0KPiANCj4+IFdlIGFsc28gdmVyaWZp
ZWQgdGhpcyBzYW1lIGNvbmZpZ3VyYXRpb24gb24gYSBTdXBlck1pY3JvIFgxMFNSQS1GDQo+PiBz
ZXJ2ZXIgKHdoaWNoIGkgaGFkIHNlbnQgaW4gZWFybGllciBlbWFpbCnigJkgYW5kIHdlcmUgYWJs
ZSB0byB2ZXJpZnkNCj4+IHRoYXQgdGhlIFZQRCByZWFkIHdhcyBnb29kIGFuZCB0aGVyZSB3ZXJl
IG5vIGVycm9ycyBvbiBQQ0llIHRyYWNlLg0KPiANCj4gU2luY2UgeW91IHNhdyBubyBQQ0llIGVy
cm9ycyBoZXJlLCB0aGlzIHN1Z2dlc3RzIHRoYXQgbmV3IGZpcm13YXJlIGhhcw0KPiBjaGFuZ2Vk
IHRoZSBmb3JtYXQgb2YgdGhlIFZQRCBkYXRhLg0KPiANCj4+IEdpdmVuIHRoaXMgaW5mb3JtYXRp
b24sIFBsZWFzZSBjb25zaWRlciByZXZlcnRpbmcgdGhlIHBhdGNoIHVudGlsIHdlDQo+PiBmdXJ0
aGVyIGRlYnVnIHRoZSBpc3N1ZSBhbmQgcmVzb2x2ZSBhcyBpdCBpcyBhZmZlY3RpbmcgZ2VuZXJh
bA0KPj4gYXZhaWxhYmlsaXR5IG9mIG91ciBhZGFwdGVyLg0KPiANCj4gMSkgVGhlIHdheSBMaW51
eCB3b3JrcyBpcyB0aGF0IHlvdSB3b3VsZCBwb3N0IGEgcGF0Y2ggdGhhdCBkb2VzIHRoZQ0KPiBy
ZXZlcnQgeW91J2QgbGlrZSB0byBzZWUgZG9uZS4NCj4gDQoNCkNvcnJlY3QuIEkgd2FzIHRyeWlu
ZyBnZXQgeW91ciBidXktaW4gYmVmb3JlIGkgc2VuZCBvdXQgcGF0Y2guDQoNCj4gMikgSXQncyB1
bmxpa2VseSB0aGF0IGEgc2ltcGxlIHJldmVydCBvZiAwZDUzNzBkMWQ4NTIgKCJQQ0k6IFByZXZl
bnQNCj4gVlBEIGFjY2VzcyBmb3IgUUxvZ2ljIElTUDI3MjIiKSBpcyB0aGUgcmlnaHQgYW5zd2Vy
IGJlY2F1c2UgdGhhdCB3b3VsZA0KPiBtYWtlIEV0aGFuJ3MgbWFjaGluZSBwYW5pYyBhZ2Fpbi4g
IEl0J3MgcG9zc2libGUgdGhhdCBhIFFMb2dpYw0KPiBmaXJtd2FyZSB1cGRhdGUgd291bGQgYXZv
aWQgdGhlIHBhbmljLCBidXQgd2UgY2FuJ3Qgc2ltcGx5IHJldmVydCB0aGUNCj4gcGF0Y2ggYW5k
IGZvcmNlIHVzZXJzIHRvIGRvIHRoYXQgdXBkYXRlLg0KPiANCg0KSSBkaWQgcmVhY2hlZCBvdXQg
dG8gT3JhY2xlIHRvIGhlbHAgbG9jYXRlIG9yaWdpbmFsIGNhcmQgd2hlcmUgRXRoYW4gaGFkDQpp
c3N1ZSBhbmQgaSBsZWFybmVkIHRoYXQgaGUgaXMgbm8gbG9uZ2VyIHdpdGggT3JhY2xlLiANCg0K
PiBJZiBhIFFMb2dpYyBmaXJtd2FyZSB1cGRhdGUgaW5kZWVkIGZpeGVkIHRoZSBWUEQgZm9ybWF0
LCBJIHN1Z2dlc3QNCj4gdGhhdCB5b3UgYXNrIHRoZSBmb2xrcyByZXNwb25zaWJsZSBmb3IgdGhl
IGZpcm13YXJlIHRvIGlkZW50aWZ5IHRoZQ0KPiBzcGVjaWZpYyB2ZXJzaW9uIHdoZXJlIHRoYXQg
d2FzIGZpeGVkIGFuZCBob3cgdGhlIE9TIGNhbiBmaWd1cmUgdGhhdA0KPiBvdXQuDQo+IA0KDQpT
dGlsbCB3YWl0aW5nIG9uIHRoaXMgZGF0YS4gDQoNCj4gVGhlbiB5b3UgY291bGQgbWFrZSBhIG5l
dyBxdWlyayBzcGVjaWZpYyB0byB0aGlzIGRldmljZSB0aGF0IGFsbG93cw0KPiBWUEQgcmVhZHMg
aWYgdGhlIGFkYXB0ZXIgaGFzIG5ldyBlbm91Z2ggZmlybXdhcmUuICBJZiBpdCBmaW5kcyBvbGRl
cg0KPiBmaXJtd2FyZSwgaXQgY291bGQgZXZlbiBwcmludCBhIG1lc3NhZ2Ugc3VnZ2VzdGluZyB0
aGF0IHVzZXJzIGNvdWxkDQo+IHVwZGF0ZSB0aGUgZmlybXdhcmUgaWYgdGhleSBuZWVkIHRvIHJl
YWQgVlBEIGRhdGEuDQo+IA0KPiBCam9ybg0KDQpTaW5jZSBtYWpvciBPRU1zIGFyZSBoYXZpbmcg
aXNzdWVzIHVzaW5nIGFkYXB0ZXIgdG8gZXh0cmFjdCBWUEQgZGF0YSwgV2UgDQp3b3VsZCBsaWtl
IHRvIGdldCB0aGVtIHJlbGllZiBmaXJzdCBhbmQgdGhlbiBhcHByb2FjaCB0aGlzIGlzc3VlIHdp
dGggbW9yZQ0KZGV0YWlsZWQgZml4IGlmIG5lZWRlZC4gDQoNClRoYW5rcywNCkhpbWFuc2h1
