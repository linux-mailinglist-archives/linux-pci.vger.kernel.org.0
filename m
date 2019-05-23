Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2627A02
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEWKGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 06:06:31 -0400
Received: from mail-eopbgr790047.outbound.protection.outlook.com ([40.107.79.47]:42739
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbfEWKGb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 May 2019 06:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ppmt9J03VJa6vOetcYJ+L4QpMar+xCRDz0B57aZCgWI=;
 b=vks9guQPICpH8yFThFQaunUdz4uXup9roG5pBB6eomXySkXtaatq4K8xSDMINTxlFXjQx8/7bK2oKxDwI3SGsj+5idcKZ/AOhk2oPweYnFpvWRqZNuiRsqHRMJmZczKklgG4qpLzuOkY3BrF7kZtnDNJT6F+0HdvZoD3f6WkZDQ=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1481.namprd12.prod.outlook.com (10.172.39.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 23 May 2019 10:06:28 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::e1b1:5b6f:b2df:afa5%7]) with mapi id 15.20.1922.018; Thu, 23 May 2019
 10:06:28 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Topic: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Index: AQHVEN0qInr5CdI4G0a9LdC26elwGqZ3m6wAgADBDACAABl5AIAAAXQAgAAAqoCAAARMAA==
Date:   Thu, 23 May 2019 10:06:28 +0000
Message-ID: <b09d61f0-cc6d-5043-1cb3-6891e589a872@amd.com>
References: <a98bff67-a76e-4ddc-a317-96f2bdc9af72@email.android.com>
 <97aa52fc-f062-acf1-0e0c-5a4d1d505777@deltatee.com>
 <b9e94126-8686-4306-77c3-bd0b96680775@amd.com>
 <20190523094322.GA14986@lst.de>
 <fa941625-ef65-74fa-e232-705ea5acefa3@amd.com>
 <20190523095057.GA15185@lst.de>
In-Reply-To: <20190523095057.GA15185@lst.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM7PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:20b:100::20) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb38638b-1ff6-49a9-392f-08d6df66524a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1481;
x-ms-traffictypediagnostic: DM5PR12MB1481:
x-microsoft-antispam-prvs: <DM5PR12MB14811D546E10757A366772F583010@DM5PR12MB1481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(39860400002)(346002)(396003)(199004)(189003)(8676002)(71200400001)(71190400001)(8936002)(81166006)(81156014)(73956011)(66476007)(478600001)(72206003)(66556008)(31686004)(14454004)(64756008)(66446008)(66946007)(68736007)(4326008)(102836004)(6506007)(186003)(52116002)(7736002)(305945005)(316002)(76176011)(6916009)(25786009)(386003)(36756003)(229853002)(31696002)(58126008)(64126003)(4744005)(6436002)(65826007)(6486002)(65806001)(65956001)(14444005)(256004)(6246003)(46003)(86362001)(6512007)(6116002)(5660300002)(11346002)(486006)(446003)(476003)(99286004)(53936002)(2616005)(54906003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1481;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N5kuNHKyjsnp3BRm+th6Vv/pMj0IWh8z/EBRIoqJxpn+5aihJ3F9PGrVT+TIJH4cWsz4r0D9Wz5o1ESjvlM+8gC0tQWMNUnHDATtbAI+ZdRLfPCYvzENw6K+9YGaNG5HpI5mQNtpthfjPidiXEAQTTD6pYfAg75hB7zK/HlzruXtg2pqUJcGsmFCtqSvmZMMs0gIvI4FV+f5m/3Wmxt3xxv43iVuVxoYxz7CrPVIw0jSkp3s70vBLIf0i7fIIfNfiU0YaxYStgy2L+e43Mhymy+WhNwH0enau0KquctLRIKJ2wj1hgBVzHEVo5V0HtE+Z+1cp84jUvtPDyVk56UKHsvarZdB+2HYPG6mxOdwixOumh1Gs67/dwOGyWq4+uWnSVU74HzmPH05U5LT+Faj5p39vGqogvQ2qPh+EjpVuVM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EA4579462F38343B009DC08B4A609FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb38638b-1ff6-49a9-392f-08d6df66524a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 10:06:28.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1481
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMjMuMDUuMTkgdW0gMTE6NTAgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gW0NBVVRJ
T046IEV4dGVybmFsIEVtYWlsXQ0KPg0KPiBPbiBUaHUsIE1heSAyMywgMjAxOSBhdCAwOTo0ODo0
MEFNICswMDAwLCBLb2VuaWcsIENocmlzdGlhbiB3cm90ZToNCj4+IEkgZG9uJ3QgYWRqdXN0IHRo
ZSBhZGRyZXNzIG1hbnVhbGx5IGFueXdoZXJlLiBJIGp1c3QgY2FsbA0KPj4gZG1hX21hcF9yZXNv
dXJjZSgpIGFuZCB1c2UgdGhlIHJlc3VsdGluZyBETUEgYWRkcmVzcyB0byBhY2Nlc3MgdGhlIG90
aGVyDQo+PiBkZXZpY2VzIFBDSSBCQVIuDQo+Pg0KPj4gQXQgbGVhc3Qgb24gbXkgdGVzdCBzeXN0
ZW0gKEFNRCBDUFUgKyBBTUQgR1BVcykgdGhpcyBzZWVtcyB0byB3b3JrDQo+PiB0b3RhbGx5IGZp
bmUuIEN1cnJlbnRseSB0cnlpbmcgdG8gZmluZCB0aW1lIGFuZCBhbiBJbnRlbCBib3ggdG8gdGVz
dCBpdA0KPj4gdGhlcmUgYXMgd2VsbC4NCj4gVGhlIHByb2JsZW0gc2hvd3MgdXAgaWYgcGNpX2J1
c19hZGRyZXNzKCkgcmV0dXJucyBhIGRpZmZlcmVudCBhZGRyZXNzDQo+IHRoYW4gcGNpX3Jlc291
cmNlX3N0YXJ0KCksIHNob3VsZCBiZSBlYXN5IHRvIGNoZWNrIGlmIHRoYXQgaGFwcGVucy4NCj4g
SUlSQyBpdCBpcyBzb21ldGhpbmcgbW9zdGx5IHNlZW4gb24gZW1iZWRkZWQgU09Dcy4NCg0KT2ss
IHdlIGNlcnRhaW5seSBkb24ndCBoYXZlIGEgc3lzdGVtIHdoaWNoIGV4ZXJjaXNlIHRoaXMgdXNl
ciBjYXNlLiANCkNvdWxkIGFzayBhcm91bmQgaWYgd2UgaGF2ZSBhbiBBUk0gU09DIHdpdGggdGhh
dCBwcm9wZXJ0aWVzIHNvbWV3aGVyZS4NCg0KQnV0IGFza2luZyB0aGUgb3RoZXIgd2F5IGFyb3Vu
ZDogV2hlcmUgaXMgdGhlIHJpZ2h0IHBsYWNlIHRvIHN0YXJ0IA0KZml4aW5nIGFsbCB0aGlzPyBk
bWFfbWFwX3Jlc291cmNlKCk/DQoNCkNocmlzdGlhbi4NCg==
