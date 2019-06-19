Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0094B511
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfFSJjk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 05:39:40 -0400
Received: from mail-eopbgr720041.outbound.protection.outlook.com ([40.107.72.41]:9318
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbfFSJjk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 05:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Wm8o/dL8uvZt+qoMeZ3s/C2awA0Np3Jup6fO/APmd8=;
 b=JdV7tF3TaP5T5Pkn//Hr05ayaW1EP6cXQqHL8TX6jDXfBOkEYazMi1Pjdr7eO4GppYFwGb5A9Np33T6Mw94sjfzgvVtzLJK1ZsfQSu2TVLCwz2KPvvV0jme+YYK52G/rN58efmr6Br8b4PfgYrLLFMQ8KVeq70jMtZbB2ex4lk4=
Received: from DM5PR12MB1546.namprd12.prod.outlook.com (10.172.36.23) by
 DM5PR12MB1756.namprd12.prod.outlook.com (10.175.86.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Wed, 19 Jun 2019 09:39:34 +0000
Received: from DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935]) by DM5PR12MB1546.namprd12.prod.outlook.com
 ([fe80::7d27:3c4d:aed6:2935%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 09:39:34 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Topic: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Thread-Index: AQHVENrAIbhQsiyOFUOZb1bo56N8nKaiClGAgAADNICAADIUgIAAoOGAgAAAuACAAALfAA==
Date:   Wed, 19 Jun 2019 09:39:34 +0000
Message-ID: <3d84c3e0-08ab-6bd4-6058-b49435a08ba8@amd.com>
References: <20190522201252.2997-1-logang@deltatee.com>
 <20190618204007.GB110859@google.com>
 <69724119-5037-000c-a711-856703c60429@deltatee.com>
 <71daf07c-f1a4-806c-a24d-80e97aef19d0@deltatee.com>
 <49c98e2d-1daf-426c-5ccb-0ee3ab3f89c6@amd.com>
 <20190619092912.GA14578@infradead.org>
In-Reply-To: <20190619092912.GA14578@infradead.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR0P264CA0231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::27) To DM5PR12MB1546.namprd12.prod.outlook.com
 (2603:10b6:4:8::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f29e29f7-9bec-4d5f-6f4a-08d6f49a0950
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR12MB1756;
x-ms-traffictypediagnostic: DM5PR12MB1756:
x-microsoft-antispam-prvs: <DM5PR12MB1756A02B303FE9AB21FE337983E50@DM5PR12MB1756.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(39860400002)(376002)(136003)(52314003)(189003)(199004)(316002)(4744005)(81156014)(66946007)(81166006)(36756003)(6116002)(71190400001)(71200400001)(2906002)(8676002)(478600001)(65826007)(6436002)(8936002)(229853002)(4326008)(31696002)(6916009)(25786009)(86362001)(52116002)(64756008)(66556008)(2616005)(6506007)(99286004)(305945005)(7736002)(6486002)(31686004)(68736007)(102836004)(66476007)(66446008)(386003)(14454004)(72206003)(58126008)(256004)(65806001)(446003)(186003)(6246003)(5660300002)(65956001)(476003)(54906003)(486006)(64126003)(53936002)(46003)(73956011)(76176011)(6512007)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1756;H:DM5PR12MB1546.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0pVN68miSXSoJ9g5qD4Dnaulyc3AAKXw3mB8fR/HFdsXd/DnH8bY/4dv95c0hUJKr/xLtKXPfv6mwC2dtIS2EGYgFxpvTGwCzFjsl1uaNAytS2Vma2hTZTyjfptZm6PAX2HpB+xlom8J3Y7tEBTWs66lQEjxszRDSITo5epMSPcImionjBpvro69OsxnSZBNbJcxuo5j/WTVB9X0nwEfqqKk9fkNYnhMIX2qpSKPhFNFEmLLpBDxbzd+0SdW6MbHn4/YWQdfZoXEWU7cavCjM0nYa+A5kWvXKFtXMSU3d2qbVguFFDIwiccnyN0VlRJZ0vrcN2mMdCIaxqkbGoFw6/rCWQZcfP8CLuT5mLxPjtkmP4p5+yaRJd5K6fGWlq79zG9YWA3IfFa4HQhl/eloTWGLQOU2TMTcwp4idsgjfX0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D78A857D5A278479EAF06DC8EBEB37E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29e29f7-9bec-4d5f-6f4a-08d6f49a0950
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 09:39:34.1644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckoenig@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QW0gMTkuMDYuMTkgdW0gMTE6Mjkgc2NocmllYiBDaHJpc3RvcGggSGVsbHdpZzoNCj4gT24gV2Vk
LCBKdW4gMTksIDIwMTkgYXQgMDk6MjY6NDJBTSArMDAwMCwgS29lbmlnLCBDaHJpc3RpYW4gd3Jv
dGU6DQo+PiBJIHdhcyBob3BpbmcgdG8gZ2V0IG15IHVzZSBjYXNlIGludG8gNS40IG9yIDUuNSwg
YnV0IHdlIGFyZSBzdGlsbCBzdHVjaw0KPj4gd2l0aCBzb21lIG9mIHRoZSBETUEtYnVmIHJlbGF0
ZWQgcGllY2VzLg0KPiBDYW4geW91IG1ha2Ugc3VyZSB5b3UgaGF2ZSBMb2dhbmQgYW5kIG1lLCBh
bmQgbWF5YmUgdGhlIGlvbW11IGxpc3QNCj4gQ2NlZCB3aGVuIHlvdSBwb3N0ZWQgaXQ/ICBJJ2Qg
bGlrZSB0byBtYWtlIHN1cmUgd2UgYWxsIGhhdmUgYSBjb21tb24NCj4gdW5kZXJzdGFuZGluZyB3
aGVyZSB3ZSBhcmUgbW92aW5nIHdpdGggdGhlIEFQSXMgYW5kIHVzZSBjYXNlcy4NCg0KWWVhaCwg
c3VyZS4gSSdtIHN0aWxsIG5vdCBzZXR0bGVkIG9uIEFQSXMgYW55d2F5LCBzbyBmZWVkYmFjayBv
biB0aGlzIGlzIA0KaGlnaGx5IHdlbGNvbWUuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4uDQo=
