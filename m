Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FFA473762
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 23:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbhLMWVf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 17:21:35 -0500
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:5600
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241189AbhLMWVe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 17:21:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZgf54Ic+IWZ2nqPkRfUWxidQIW9JC9ESBqVqSu4H8pj1tMp87EKeaZNmJCNiAMhICHnK+39w2imjLywYGmrN4KhOOwd2Hj8tMhpsTj66NqUqvKLLNswkQ8f9QBFoSbJKYczl2rs9HTYaL0p1QcLBmVMdGDOT0wLqAsdASlWyQgUCzQi8QVPy5z42u0BsIDILwxJljbAhiAaDUtQeXTfarRRkJXMtViD6GDozgkl+yunGQCpOA0Ye/BQBq6HXl6K8LMLW0ueRDMsIg8h3B05viZmCzJmUpbxDl0/nqmQoSiFJylqQAQUAM/mr/V9TmaT65MX4ayz64WrPWNmFNUjcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGrIFpl42zpUFQbBq1rGrlKLz46gk57U+xI2yyoToPY=;
 b=aHahNzi6b6yjRTKSnxA3xg96PrAAun4WNiJDv994UPCYHeslujiGEDGYNqxMkVdmN91ZPgfdanvkoOLNWKuuKl+am52AMg/Dkv9wFAHIW5GmUZvExy6sutV+/5pr0+zcPsRJVnyDd6i7o2ptJyW8D1YPJPI0Hpv5D6SS02hLTw/XvuT7/RnqpIyQvJKeRztTeek1qinnpMcOL1tE5BZyBjA007C1ZddhcvpUv/VRXcjZ/s0jQVNXIaf1IRUZFT73lGbQErCyLW15Y49/I+ou/KlO0G56WYM+n05Zg/pwa0RuBqChyiT6YonqkiC2eXoNABTxFswDzc6prm+ku+4l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGrIFpl42zpUFQbBq1rGrlKLz46gk57U+xI2yyoToPY=;
 b=IhKIMFPTOQl1s32GaZXVKwK8r0/I+/jF4Tssfa3UCfOXjHjfGD+nv4AE1iNMbsKBT1aSKyiE3gSinKrqs2RIXwz34Up85wkSLFfuGyprjcUJ6QzcbQxXv2KMa30fFa31PN3bBs7XcCedXpQaIAsYomWGRShGDj58jgc2bopPtQXxUO0M/bysv93JAP2uaLksz/FEE65TqXxgRwtwPhFu21MkdvcGSjEOTiDaKR8522b6igf6NIRV4nd4Pl+pjeyIcHDYEwwu2DNfMO2277UU9xFE+CMmibk0wJTBMeEoT5YqECjp1iGaAjWPTqJzaiee7hxtGNVRw7e9QtQVTeVKcA==
Received: from MWHPR1201MB0093.namprd12.prod.outlook.com
 (2603:10b6:301:54::20) by MWHPR1201MB2559.namprd12.prod.outlook.com
 (2603:10b6:300:e0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 22:21:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 22:21:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 22:21:31 +0000
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
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v4 11/23] nvme-pci: convert to using dma_map_sgtable()
Thread-Topic: [PATCH v4 11/23] nvme-pci: convert to using dma_map_sgtable()
Thread-Index: AQHX3AEihbojl1hvr0Su2kiqAEoqUawxJ4yA
Date:   Mon, 13 Dec 2021 22:21:31 +0000
Message-ID: <e4fda995-6b50-0f74-0af7-4d790ab66ba9@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-12-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-12-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cb113db-670f-426f-9352-08d9be86ea78
x-ms-traffictypediagnostic: MWHPR1201MB0093:EE_|MWHPR1201MB2559:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB00937C17E9F17FEEAB0B5A00A3749@MWHPR1201MB0093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbyB0MBg55XzGOE3ccgnKK1mf2XKkaavKjSL4GMxCAN6bsa8BfFt2B78IqpwJK4Mw+ZIrzi4Rj/8wBrc+4WFRtJ0guTgkD5TWVe968xkeCdjvNcIp4oBstfbGlSPlkYKYvN8QiCOh0tZs8hmvnXcv8TpL6OhNpiqWJTgjHxP/uEkn/JQ4Ikq1U0nHiQVvNwUl23RuND4xcGFNenGGseeTfe/lsriaDNhGaRplyI06EmV17/aC0KSXgocsB7Q7lUgQrv9/gniGqhpyd49No7cV91hjk8pL5or/zLk6GI93lEizOWmuhMgcQnForCBHLFryinE7XXvvsdKSdaii28Y8UEhWsCklFwKCo4/AbuVuiKg0UiTN2g22Se25pJ4XY3/UsPWf86leD0b2DHkdGvaoLWv++1G9nOp35yYP8lTXD/QM0tT2spGSsAp65rPcop66NkxDzHfgnGd/0x9Zb/Q7igdkdeXxtoIXBjOMTv8wjdc9haReD+iG2RToTPDfEyALNXC4J0X54iF3e5s0ecPDlcoXveUZROOUeJLdD29wWHWwvSFW4Svpqnni4wfOdHDesgwMgWO50Hwu2laYYjwnj0eMZC1WUAhpiCBaJUugfBAmrrnKOAh25ZxW7NGtHqzXrkiOuE5yMomb+kv9HePKwPXZq+cw63qK5jsBMt3MWu9cT42KGlGufaHSQM17BLduTURSY9VgmXij8lcmhb2q/BwlWqZ0OHMvJUI0ARWyrsVGBYSAsbAe99s3lEuiRnb67tIa5cqeM99xU71vx6h3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0093.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(6506007)(110136005)(122000001)(2906002)(316002)(38100700002)(66556008)(31696002)(6512007)(83380400001)(2616005)(4326008)(7416002)(86362001)(107886003)(71200400001)(36756003)(66446008)(31686004)(64756008)(91956017)(8936002)(4744005)(66476007)(186003)(76116006)(5660300002)(38070700005)(6486002)(508600001)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzU2MWcxRFpvL0tjanp2eGRIeHl3a3RLazQ2eVk2MURMYjhXWDl5SnJHdEJH?=
 =?utf-8?B?ZXhyelVYVVV1aENEcjYzN3RDKzFQS3RMZXBaS1JNWjVlOVF1YVE4QVEvSG9q?=
 =?utf-8?B?YTkyN3B3bzNhc1hPUUtaV1haVkFycHBvMkxGRWJ4bjJQL3BvSUl3SzdqWVhH?=
 =?utf-8?B?Ujc5SDdXL0NjUlJnTlhDck8xNi9mc25tT0loTWpkeWl3NlVIQjJkM2RZVk5F?=
 =?utf-8?B?bGpFRlJ2VTN0ckxGcTBnVS94TkVlOHBOUW52T0dJRXJ3SEFBbWtseStTVk1C?=
 =?utf-8?B?aHdkWUt3bzIrNUlaN0VPQWFvVUxlOFNreEJtZWJJTFNtbkNVTVl3T3lzbXIz?=
 =?utf-8?B?bnVuSzVlV0RpQjdLYUJmZC83M0YwOWFTYVJDRm05UXl6KzhUSTFSR1lPQ0Jt?=
 =?utf-8?B?U2V4YVlDR2JJckpEaW1lVForRFgwdTBZZVpJK3pJMk9QOVkrU1BheXBJeHBi?=
 =?utf-8?B?bENqc3dOdEEwOGNPOS82MWorYkJTcHVQemNrM0pTQUR0WFI0Ly9KeTBiQjJX?=
 =?utf-8?B?TWJjK3Y3TDZVVGc4dDBaUlpHQ3hVWjNuVnZYOGZOalM3K2pxemVhNUNablQv?=
 =?utf-8?B?bWk3UWo4MTFMNktFQTBOZFp4Q0U5K05aSjBSa2IwTmRxNlNnUzIzN0cxZFBV?=
 =?utf-8?B?YVBoQ2M0MEloZXBkZWxLRkt5eHBWQ3lsbUswZEd3L1o2cGxrQThEQStteHh6?=
 =?utf-8?B?ZWRQQ3JDVWxLVFhDWHIvK2F6d2x5NjhpV2QwQUh5K1ZodU5RRytkRVp4MGJV?=
 =?utf-8?B?WWJwanRGRysxdmlNNGxqdEZON2FPVGpaYWNlNnh5SWlRaENpb1JTWTBuQ1Jj?=
 =?utf-8?B?UDZWVWVNdDdVRldnNXVWWldhNnlrdGVVQlYwRWdZZXR2S0NJUFFFZjFqK3Q3?=
 =?utf-8?B?MEJtbGxjaENBNzBDNm56eERZTnlSbHZsSThFWSs1elZCV1NIUlp2bWJ2eTZI?=
 =?utf-8?B?V2VnZ3RpZ1BpcWljMm9iQWxOdlptNkZZSktreHkxMWZMR3pjc082V0dGTEtj?=
 =?utf-8?B?V1Q2YlI2K21rcFRkbnptUVE4dFFpMnFyckNSd25nMTQ4R1ZlZ093YmNweEJE?=
 =?utf-8?B?RGJKNVpJdUJxVGY5azVQVEV3RVJRQnNnclpZczdqdmdtZk84OG9vZHJZZnNY?=
 =?utf-8?B?Rmhvam91SmorQnlYQ0ZvRUcySWRjZFBDcFZYYkFUS08xOU82YmVKZVNld3Rn?=
 =?utf-8?B?K0Q3Z0pkSEZqMWFLVHJRZmNTTVZIWkZxRE16WWxEeXE3NzFRK1dnYWNGNEw2?=
 =?utf-8?B?OG5oeENBNS9RajNkaHZiRy9scC91cUVucElkYzlid2xadlBSTVltOTVYSjBh?=
 =?utf-8?B?allITG03a1NwWmMrQzRETFFucDY0ZTdWVlArQ29yQ1FrZEV6RFkvdHJLbmk3?=
 =?utf-8?B?WUJDSTZXOTJpWTBZUHpBelRzSjVwOEVVUlBnalNUZEJENjlFYm9xOHFJKy94?=
 =?utf-8?B?T0hyQVZNVkU5aUM4RjhEcUtzeFN0VE9hdHZuQUJZbTBkR0tRNHVHdXVmOUNE?=
 =?utf-8?B?cm8xVGVVWnBwNlNPbTZtRFU3cmczeXBkUlpEc2RRbWZuaG8xa1RaMHpDaWJm?=
 =?utf-8?B?ZzJ6dWRhOW01T3NXU3dlam81R0tZaEd5dzZ6NHZ3T1pmSW1WbXpReHI0bHJK?=
 =?utf-8?B?b3BoYkk2NFpybFYvV3A0NjVYQStOK3BlMnBXL2FGME5LbUJ3citDQnR4MWQ3?=
 =?utf-8?B?L1dSNDBXQ2k5L3F6YWRCWjR6dE9EdkNmNUhaMWFRalVPQTEvMVlFSEt2dFZM?=
 =?utf-8?B?M2pOZndtSGlPbVQ3WUg1S0VoeHNKcFpZbTZaeUorSEQzcEFYcUJhdlkvZXM2?=
 =?utf-8?B?OHR3cGVpZzgvT3kzVm0rTW9jbXROZlNOZHkwMyt2SG55M2RqR2RwbDd6elY1?=
 =?utf-8?B?by9BaXc4VUJEQVpSWG1CV0J2eTB1d3NVdzR5azNmL0Jucm01MWFjVnRsajdX?=
 =?utf-8?B?dHdWZWs5ZGpiY0JCWjdZcURoZUxiUU9wRTNDN056QjlSZ0VzSFdxcGt5L1JV?=
 =?utf-8?B?S3JUbGwxSmdUeE1uWkFCc2ZQaElJOENRbHhCWUlwTHJjazZWaTdtWHphVEQx?=
 =?utf-8?B?YjlVR01pRi8wSTZyZkhKdGRlcXNHdy9NT0U3ZUc1eVFodVhhUnlMM3VWeU5I?=
 =?utf-8?B?bFRCY1hwR2w5SEJLbFNNb3A2Y2djUFVNK2laQWVpb3JxcGRIbVVhcXRRZ1Q1?=
 =?utf-8?Q?5KoJ/fJ9MkeUpS8DGBvjh6S9Q86YZ9lkX7Ebx5cK7dTA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88874093B8A34349AE6F9AAD8A801BFE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb113db-670f-426f-9352-08d9be86ea78
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 22:21:31.6042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVEEEjIz5S6PWX3qbdDIjydKL3t0i8DMa5odqYduxokTzaEnPaSJaQ3hriGs+xD7d78AJUHbPPo2rGDbAZQxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2559
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+ICAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX3BjaV9zZXR1cF9zZ2xzKHN0cnVjdCBudm1l
X2RldiAqZGV2LA0KPiAtCQlzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3QgbnZtZV9yd19jb21t
YW5kICpjbWQsIGludCBlbnRyaWVzKQ0KPiArCQlzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3Qg
bnZtZV9yd19jb21tYW5kICpjbWQpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgbnZtZV9pb2QgKmlvZCA9
IGJsa19tcV9ycV90b19wZHUocmVxKTsNCj4gICAJc3RydWN0IGRtYV9wb29sICpwb29sOw0KPiAg
IAlzdHJ1Y3QgbnZtZV9zZ2xfZGVzYyAqc2dfbGlzdDsNCj4gLQlzdHJ1Y3Qgc2NhdHRlcmxpc3Qg
KnNnID0gaW9kLT5zZzsNCj4gKwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnID0gaW9kLT5zZ3Quc2ds
Ow0KPiArCWludCBlbnRyaWVzID0gaW9kLT5zZ3QubmVudHM7DQoNCkkgZG9uJ3Qgc2VlIHVzZSBv
ZiBuZXdseSBhZGRlZCBlbnRyaWVzIHZhcmlhYmxlIGFueXdoZXJlIGluDQpudm1lX3BjaV9zZXR1
cF9zZ2xzKCksIHdoYXQgYW0gSSBtaXNzaW5nID8NCg0KQWxzbywgdHlwZSBvZiBlbnRyaWVzIHZh
cmlhYmxlIHNob3VsZCBiZSB1bnNpZ25lZCBpbnQgdG8gbWF0Y2gNCnRoZSBpb2QtPnNndC5uZW50
cy4NCg0KPiAgIAlkbWFfYWRkcl90IHNnbF9kbWE7DQo+ICAgCWludCBpID0gMDsNCj4gICANCj4g
QEAgLTg0OCw3ICs4MzgsNyBAQCBzdGF0aWMgYmxrX3N0YXR1c190IG52bWVfbWFwX2RhdGEoc3Ry
dWN0IG52bWVfZGV2ICpkZXYsIHN0cnVjdCByZXF1ZXN0ICpyZXEsDQo+ICAgew0KPiAgIAlzdHJ1
Y3QgbnZtZV9pb2QgKmlvZCA9IGJsa19tcV9ycV90b19wZHUocmVxKTsNCj4gICAJYmxrX3N0YXR1
c190IHJldCA9IEJMS19TVFNfUkVTT1VSQ0U7DQo+IC0JaW50IG5yX21hcHBlZDsNCj4gKwlpbnQg
cmM7DQo+ICAgDQo+ICAgCWlmIChibGtfcnFfbnJfcGh5c19zZWdtZW50cyhyZXEpID09IDEpIHsN
Cj4gICAJCXN0cnVjdCBiaW9fdmVjIGJ2ID0gcmVxX2J2ZWMocmVxKTsNCg==
