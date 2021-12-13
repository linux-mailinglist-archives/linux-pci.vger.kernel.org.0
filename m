Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14FD473725
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbhLMWAd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 17:00:33 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:5408
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238754AbhLMWAc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 17:00:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+epXGhl6VEZrGUT1+92iRUL1/H0yDUAsk9o8gjmQueBhC/A+y6GGT+o5rm82rlj6tCYLRf6aD7u7fT01lZ6gIvctrwf/BG7apbXcD9k3wRsCYXsI7FE6pKOIDBmcWqtkDDmOx4UPgVE9bw1uLuQrFO+xUP4rKej4T5QaGORjLMrEdnbbHoYcDESgX+2OKdcG6LgKChAubG5nsAw6AOYr/dyqUYlx6LXjcpirEcZwv9tOimcPu12LPm9dAlCsPpDwOy0nEjoBUwigha4TS2dYEV7pVwGNfpsoLVbR9ILsITPubmnIt71zCqSBd7D47ITg2AA+j9CTEdv+S3cIapeCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcQ24mTImXA0x3TYhCaAlrVAA9ie4cD2E+7PXPMehW8=;
 b=cO9hgM4BP0QNHFLLDyvp67MlQTYsMQuxc4Cg/6xmef4SwYK56Q2y5tYcVL9K5GJOGYkAJjNRc7nCBFCIE/RvvZoO/GiiM+Tmtodr+Zo4W8q8sFhg11Ha63E8IEfUVnB7tWz1xF4OYuakVDU3lYbDpzanzl/5lIwG6kkLMgr8qNFXN9w9yqa68Ly9D/JraMqnSqrTl+cxownZLoZmbXOsWXXp/ux/9GZDS5JNMmKWngC6uknOmQz4e7GYU2USplxnfeyfpiE8wotqktbWZhy0ezmQy0IYL6YUkqDgpfMu+3AunewbxEn52pVUcDrnugusWJbEUXLobS3vRJQOBRcVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcQ24mTImXA0x3TYhCaAlrVAA9ie4cD2E+7PXPMehW8=;
 b=kima35WoJgJFV56xtBTIkqbJsMsK3nzY7wiBe3h5Hk7b7zS99GTaaSL7qQXGPCqCm6v256rCd26rEPjshQk+Tyf5jEno9Dr6GinXTu+gGeq648PpXX4MfSxaYCiF5a4wTVNGw23KULPvM6HUBNrPxH0Ual8Vrqhh2lahuCnfzPYtD/FDa3LOGdtj1hXcKWXR0A8Goiq8TKXXQi0Edo2e2z6cCeY7zz+UqUAK398YV8vSERJM86fma7sAFXFgvA6AlZKk2vq4Q7zUEvPzKZOTbis1EvqdCY8487GjXPgXc/LZ+g037d1LWk/9aXWTMXKf42V9RRRZraiwj6bu48NaMQ==
Received: from MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16)
 by MWHPR1201MB2558.namprd12.prod.outlook.com (2603:10b6:300:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:00:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1726.namprd12.prod.outlook.com (2603:10b6:300:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Mon, 13 Dec
 2021 22:00:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:00:28 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v4 03/23] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Thread-Topic: [PATCH v4 03/23] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Thread-Index: AQHX3AdpaBbhnfL/1kKrOJvpVJUMZ6wxIZ2A
Date:   Mon, 13 Dec 2021 22:00:27 +0000
Message-ID: <8665d69d-7cf3-2c6f-1899-7f436954e55b@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-4-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93f8a0c3-f7c0-43b5-eaf9-08d9be83f92f
x-ms-traffictypediagnostic: MWHPR12MB1726:EE_|MWHPR1201MB2558:EE_
x-microsoft-antispam-prvs: <MWHPR12MB172629FE92339EFF3B06DFCBA3749@MWHPR12MB1726.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evzYVwPA9YsljV6Rm/uT2OoKhlwEkc0UrOlJ/WyWOqEj4E/Zh+Pvcwu4LQS7ZmbNHJqia6j+ZEFRTgKC7VQYdjvVu1xzqGbeBegHPNCDw1Mhm5gSufXeeU1XZX1E5+maQSqB/Y/kCPLrShlWfVzaKLAx+OXRwkfGsmNppSlnhONd8CBA2cOtRbKqufHYjWcm9BjgzB1sL7G3kctiCuOn61pTj9CLEJLsf6aArhyz4TsAu47qszLE5H1yW5rXr6Nnu95MSdOG+C+dC8yWsHEXHv1b+qpEp7WoUItCm3PpgFEdDj/tEEGFv3KSA2tSv81pLdrXHgaGW1G4EpTOsGcO4rG/yArSJiofRM0o2J6eUjT6+gmhAxlkjsXhHTcOHokyQt7tZXDFLO8FflJC1slKmXGG6UUuOPixkp83hUNXri5w1HzPMMaQFtfgvvLUFLMOdQeyIr8pQjCgQIF5SyU1o7vW4id2RajjL52pBPcOr8JFqFsicIGYdN5t2UCndjX7hoIxykmk4w3BqkKNMi3U6c/xvD2IY6MosjIKa1OiMlTxRf7Q5OyWgwYirQAp9d/5eYQOIvb2BrD6FvQkVU1aba/Lyx3xLnmEvms0lnt3XJlEinbnhQgtzy5QQbMXBWkF754v1RXodxSXsTnw9s5o2Y6wTa7ThN/KZ1sM4uiBK6Q6g9qBXmGLXtHE3Aqdl3ZHiQwH1ewyJTehQNa4149+eBozXuBbQCxBUnJrTxVVhgwcMA2B1+JR20g9zS9E4KrRIlaCPYObDchcDKaMQTgnqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(71200400001)(64756008)(66446008)(91956017)(53546011)(66946007)(86362001)(6506007)(66476007)(4326008)(76116006)(36756003)(38070700005)(7416002)(508600001)(186003)(2616005)(316002)(110136005)(54906003)(38100700002)(31696002)(6486002)(31686004)(2906002)(83380400001)(122000001)(5660300002)(8936002)(8676002)(6512007)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm5maEJtTzRTMUYwOHE5VVFCdW85Um5PQTA4Uk1ManpNZk16TXp6N2VGd1pF?=
 =?utf-8?B?OCtvUWp1MWRLci93Sm1xbEdMMUtEV3VKcENUcW0rdytrS3Y4WE15TWwrTWFY?=
 =?utf-8?B?ZWczZjROSnNLTE5nSkRPMTB0U0VYNzNna2J6amxHRlB2UVRYaWRNZTlJdE5p?=
 =?utf-8?B?NEZ6cGwxS0t5eGxQQlNVV0EvcFZDZ2NiTHMxZUYya3JvSWcrTExsK1d3SnJn?=
 =?utf-8?B?RlBkaWxDb1RMdGdJbC95SE1LY0o4ZHhSZHhmc1I0c3RzcnRWQWdrUW5MOXUw?=
 =?utf-8?B?Ykh3RDdiUmkzRGNobGw2Y1JxclFhL0R3VHAwTTJUZ1RrMWpJZWVRY1hndkd0?=
 =?utf-8?B?bkFsOHZOVjROMnI4YU4yeHpORlRqek1JcU5aMjlOVUZkZkp2M2dJVDBGS3Y3?=
 =?utf-8?B?Tk13OHNXcjVTVEhWVllVUHZiMW1YdFlDRk9VWEtMd0IxOFdxVGFIdktBQjJw?=
 =?utf-8?B?a2hveVNQZWF5ZHdGUkNHVWM2cjdTVXMwd2ZRaFFDNmpJVlY0NGx1VGxibjlk?=
 =?utf-8?B?R2VBamV2cFAzVGZHOUlubjJnNTFZbDFqR0ptYkVCQ3VrLzB3eFAxT0NZUFli?=
 =?utf-8?B?SWc3QjIvdExCdEtTYmR2KzNhejg5ODhwVGE0N3ZGamZQSm5GMVQ0d1FyRjMz?=
 =?utf-8?B?M2FzUDFjbFpPa2pDZVVwN1N4cnREbWVUaFYyU04wUzVrcmZmVmRHcWVZS1Ja?=
 =?utf-8?B?WitoODh2ODB0aTN1d2prNkE2cXdmUlZ3V3ZFS2lXZlhZK1BEeHFtR3NkV1R2?=
 =?utf-8?B?RThicEU0YXIwMWVhdUVUMGU1a1FZa0dON1NhTy9iSW1lMlhTRHUyYWRzanUr?=
 =?utf-8?B?MVZNUGgrZGd6SWc5cmNxYUVhVSs4ck5rMk14Qlg3R3ZNRjB4YnF5TWFMS0xW?=
 =?utf-8?B?NEJNc0V3cWpObnFoU2pSajJMQkRQa25CTFdydHdPRkNPU2tad1R0RHBJb2Uv?=
 =?utf-8?B?U25OdkRaK0d4TUQ2ejJjaVNlb09tWklDdUhHYWprdU0rcW00RWJrcGpEd3Iz?=
 =?utf-8?B?U3g5NlhTNVhCM20zVWFFWTVYTjdJR3hJNDlBRXJzR2NnMkFScHlNRVFjdGY0?=
 =?utf-8?B?RWJta1E5dE00d2hGeE41U3BPc0FVUTlDRUNVRlIvWEx0WkFuWGxXWUExRlRa?=
 =?utf-8?B?cWtqdTIrcnVzUldWd2tvVmMvcmZOVi84MjJSMmRjbmNmNFltT25OSmp4R3pF?=
 =?utf-8?B?OEFOZlN2UDB0eERUc2k0Q2pDQSsvdnFiQW9pbHhtdGdkV2pLOHJPVE9rQlJB?=
 =?utf-8?B?QXhrVHNQblU0aEx6K1hRb0grRmVSSkNJYzduaHFhZnYraUJ4NlhxSkdETDZ1?=
 =?utf-8?B?VUJlZU1PZUlnUFlNcjNqNG5pRGJVQTloaC8ySHRGeXRPcDFRdDdpZ0t2MXRp?=
 =?utf-8?B?KzB4WVNYZXJLckdpUHdwZzhDMTlFVzlnU2E2TFQyMmt2b0d3aWNaM1NIdGJa?=
 =?utf-8?B?TGo5TGY5VEJscjZaVFBodmc1L3Z1d2pOSlp0Mm54QmkzelIyaUZrM01aeG9R?=
 =?utf-8?B?RTRHcGNzM29UTEVkY3hxWk1ndVhzRndGVGtyTU03THFMWTFQS0FXTWFyQVFU?=
 =?utf-8?B?RVB2RTlLL2pBZmROTFU4L0poc1hTZTlIeWtJdHhva1dnbnB2V0JMcGw0MnpD?=
 =?utf-8?B?UkdLeGVQajZ2RDE1ZWttb1RWcXVtM2VNQjBYeHp2ZWtTM0RKU1N0ZEV2ajRT?=
 =?utf-8?B?anZlSmtnN3AwblhFRmIwV0RHb3ZZOW1EZ3VsT0NsMEd3OGNyb2pTM3FoZGVz?=
 =?utf-8?B?YWFWRXRRMFY2aWhoZ25OM05xVC9WTmJtTldKUUMrV3VhR0tIWW05YjFqbWVJ?=
 =?utf-8?B?dkhRcHQxMVhVTUdHK1dtUWExdzY3ekpNSVB0eTlJRTZvTGNDWlJ4QTFTVWVJ?=
 =?utf-8?B?a2tEeHdEd3liOERQVzhobzQvQ3FneStZcHk4YW5ZYXAxZGhuRnFob2hpUnJr?=
 =?utf-8?B?aEEyMlhpQlMzWkd2R3NpaGs4ODN3ejl5NWw4NEFLTDZTQ25wN2VUcDN4RXI0?=
 =?utf-8?B?T0ZWcVVDWGliRklsR2drWEthSG95dnVGOHo5Yzh0TytvcVJxb0pQUU5EOU1R?=
 =?utf-8?B?dnZjM1RFNTVVR01QT2gveWFFWVF6bE53NW54Q0ZYaVA2MnFqM2Q2bURiZlBJ?=
 =?utf-8?B?YWNCdWRjNXZPKzh0ZitGdHNQc21FV2NzSHV1em8wVUkySTNoT2dUeG1EQ0wr?=
 =?utf-8?Q?KK8PGI6MgQ9TuVNefkvq0h57YKzjm4HTQL/asYNrPGSL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <443FF690B8AAC7449B892A6AA021BEF2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f8a0c3-f7c0-43b5-eaf9-08d9be83f92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:00:27.7957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ozLz52JoSyQgD6gNAP9UHhjnxYT0VODw4vjhPbNCDZvniTJtxtoK4Y40Et4oubs6ywhjcYszu20nmMOwrTltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2558
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTEvMTcvMjEgMTo1MyBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOg0KPiBBdHRlbXB0IHRv
IGZpbmQgdGhlIG1hcHBpbmcgdHlwZSBmb3IgUDJQRE1BIHBhZ2VzIG9uIHRoZSBmaXJzdA0KPiBE
TUEgbWFwIGF0dGVtcHQgaWYgaXQgaGFzIG5vdCBiZWVuIGRvbmUgYWhlYWQgb2YgdGltZS4NCj4g
DQo+IFByZXZpb3VzbHksIHRoZSBtYXBwaW5nIHR5cGUgd2FzIGV4cGVjdGVkIHRvIGJlIGNhbGN1
bGF0ZWQgYWhlYWQgb2YNCj4gdGltZSwgYnV0IGlmIHBhZ2VzIGFyZSB0byBjb21lIGZyb20gdXNl
cnNwYWNlIHRoZW4gdGhlcmUncyBubw0KPiB3YXkgdG8gZW5zdXJlIHRoZSBwYXRoIHdhcyBjaGVj
a2VkIGFoZWFkIG9mIHRpbWUuDQo+IA0KPiBUaGlzIGNoYW5nZSB3aWxsIGNhbGN1bGF0ZSB0aGUg
bWFwcGluZyB0eXBlIGlmIGl0IGhhc24ndCBwcmUtY2FsY3VsYXRlZA0KPiBzbyBpdCBpcyBubyBs
b25nZXIgaW52YWxpZCB0byBjYWxsIHBjaV9wMnBkbWFfbWFwX3NnKCkgYmVmb3JlIHRoZSBtYXBw
aW5nDQo+IHR5cGUgaXMgY2FsY3VsYXRlZCwgc28gZHJvcCB0aGUgV0FSTl9PTiB3aGVuIHRoYXQg
aXMgaGUgY2FzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9nYW5n
QGRlbHRhdGVlLmNvbT4NCj4gQWNrZWQtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2ds
ZS5jb20+DQo+IC0tLQ0KDQpQZXJoYXBzIGEgY29tbWVudCB3b3VsZCBiZSBuaWNlIGluIHRoZSBk
ZWZhdWx0IGNhc2UgaW4NCnBjaV9wMnBkbWFfbWFwX3NnX2F0dHJzKCkgd2hlcmUgeW91IGhhdmUg
cmVtb3ZlZCB0aGUgV0FSTl9PTl9PTkNFKCkuDQoNCkVpdGhlciB3YXksIGxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=
