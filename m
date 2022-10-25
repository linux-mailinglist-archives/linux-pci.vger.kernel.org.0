Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8693360C14A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbiJYBoX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJYBoD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:44:03 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CDB5D8AF;
        Mon, 24 Oct 2022 18:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjBoELixGKxh0PIHWMgMjZ6P3IXept28hmVolT9nfVG/+l2ncxY+LIC1fWYqWLEetLvU6Fbvs5BB1L44RU0/FlnZQ3gdASDuIFgAwnHCK7U/rcAVofHCUDyIC8hsnAXGPhIkWfC8/qptGm25Iig++6tY+UDp8QGkvsK65JHnyk2wx4w7j3HdiUon+4d03k0RnKTAjk+dStAypOwAWBIKdqeKFj/IcOcQAT1FVPESSbqtKq+jhOuFCAN6kQV1rs2I3RBJk5hMzHch3J+n50T2uTkzr3d+jC75U5rL5rTvBPF5aDtVBi49FxmKEt7mqYBvlRXFFOLRMcLw9AQFQJqyfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKB2mj7z1Ka4cCEKxGaFRv1QOUXuX2eoYMm28ItN0m4=;
 b=Kw2YlX7lncXQgS7z5rjLWNPbgGQqSS9W87Vh3NfD0AryIaHhF/gkF8HXK5v4NFVBkzqCE3ADRPh1qyVm33G3ujRJnhWaHHRv1Hp5nmG/kLAiEEqQ3kSaymVxxHNRQYwx0/Aae23XzP/ks4816UzGn3HxUs+iWAHNblLaev/Z4kIFe+B+6xS0Y/Mhb41P1dkDuhR7NQVzKiWq4U6VuI39hQa6RqNiU6xRTokTCRVOxa4fq5aMCD3TM9T6okxi4+EQjxzx8CKWdi2DGr7WChC8dRsRmt+1zZDNPkspRhhMaxqDiptAcvUjBXI49bW/l2ROtQagfDOFJE5DN6380smoKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKB2mj7z1Ka4cCEKxGaFRv1QOUXuX2eoYMm28ItN0m4=;
 b=uH+7CI0K+xT4oxbuJVH8lj3HvBFIR8OC7LLLoFDGSV3uDgg3Q730dRbEEINWCa/JMCZniyzFxcaak0npSUB3l7Y/eVTEhRQDstNVGFUsFkWz8EtI0tXUxwCZi7XDLMGPsjkUoNxULuXOci9assLKg3YE9EDh0xctsArnFQwJcGJFLsS+jzm19RYG0JPqjkmx7Hdxk2FHREDAM96YaXLseYebVke5rqX8AI0+SvR7CuPMbdbKss4YvkuRoDCyjvQ9P+K0puak9UuEZpuedsXJTXzJDxpvqJknt1U5fi3Hi7BQjuPQ3gVJBh1vIsrjLRaXlU7clRFnTOL6ke2ikwj9fw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 01:29:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:29:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v11 8/9] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Thread-Topic: [PATCH v11 8/9] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Thread-Index: AQHY5XRhmtIfJYcZP0KNtjagxXHMP64eV3OA
Date:   Tue, 25 Oct 2022 01:29:09 +0000
Message-ID: <565450ff-aa8c-a796-390b-9282e4b7ef17@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-9-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-9-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB6923:EE_
x-ms-office365-filtering-correlation-id: 0e220be5-5041-4c45-6c65-08dab62850c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JuzgKC0J3EL4BhbWB30M4xKtsBY4qi1+wxkHIq5vRZPEL0JSzIgZnYLeU8HGuveaXWOGJX/XQEef90HI/JQdSaXRtOdPMO2JKb+cB4SdrxY8VX/1QTKI/7Lva31e+fP2oBQfG3oMbzeKz2Mbdesg84NCukOIBZMrTBDJKNJoDu6cFN0tiawdZqOxyxl9l0PrRJGplqdU7SUkMhCQCW3OILPL7yqemcDQBcojwjSDSfVrvCF7ZNkAB3a6zuQakeXvjKP3j/mUT9oYLVMDMA0st+SPD/+s5dtIoG0Wzd1unj7LflrnmBv2ie6vqKcVjKThgzUtG2TGy357RIaaPJiIpyw+ooWJLo93fgVA9K3/6VSOXHhwBK+nWw6sm2Uyt8QFzy/KdPRCeQ54RZfFq9UyWL62Rj2gSBnuEplgQBwvTDDoNTlxqId6P+I9Ya8LlpyS+ojsXT/XpagVdQuhUGPCzGwqqVh7L3ddxjJ1MngR9jAqtb0VgF+ErV3XrX6mmdCGUxSxjp5TZ9ivfR5awhn83pLv68r7O7IZ+tKv3hkQpRDaIYHAE6SIdY+yYKZsujl+AC22309ufc1Qqu4Kire3YGsppvzqafgFbwGP0KdpyEAfWyBsSXEucqYW/bL5ZifoGQojOLTCHwIG7SJ02n+CgrGVdeMkSJCu4molZoY2lUDGbhKCiHmHh6VCMsTdFKZNg1q9BNeirNIu1CMrSLPQ9fCEgfhasadmNukJer1c5qfQpElcATrN3njui+cfzed+QA2+LGrZj3wxAYWexHZ4Y5WDl/7H+OelBrtjX8wXxeSVUQy4w6N3dRSqDBTQhdhowjN0l9Vrwp7KWVasgTps7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(66556008)(38100700002)(122000001)(54906003)(110136005)(2906002)(6512007)(8936002)(91956017)(36756003)(8676002)(76116006)(66946007)(38070700005)(66446008)(66476007)(4326008)(41300700001)(316002)(64756008)(4744005)(83380400001)(6506007)(5660300002)(53546011)(86362001)(31696002)(7416002)(31686004)(186003)(478600001)(2616005)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU94bmQ5R2czejAwMzlkbGFhSGVxVVRPdlJwa1N2dnFBMzhKU2s1ZTEzRWdE?=
 =?utf-8?B?UWlFcTk0Vm9UU3N1Y1dOaUxmT2NvbWUzaGpaWGErdkptWHRKRWpNakVkclJN?=
 =?utf-8?B?Zkl1b2wvTElXeGYrelkyaWVwQjBJZ1pMZitacjFraHc1eGJReTczNWlNNkYy?=
 =?utf-8?B?OHdaYnc2Mi9JOENLVElLTnFGQUdmU0l5NDdYblYxKzBzdjRzS0pIdVIxSDZl?=
 =?utf-8?B?N2tyN2EweGFBTG9PUG4yU2hIODh2elJXTVMzZnhFaVA3N0tqdE5INFdmaWU2?=
 =?utf-8?B?ZjdQMDcrUXpkR0h2YU90aTlja3hHdFpsWW1VdUxnQ0RwRjY1NVV2R0xOdFl6?=
 =?utf-8?B?KzRCSVc4YjdEbjVKakw1RFZsTVMzSXpUMkFsSVhoczBUdk9HQ0daTlFLak5O?=
 =?utf-8?B?YnI1QjY0c0loaGZTVnFtUzE5Z2VVeVRudTlNZHdQWEM4dlQySlFLNmlscG5m?=
 =?utf-8?B?VkVRUDVpNEg2bmJ6Y2Q0aVdoQXlPS1FWSFN6a2h4dzBmQ1l0b2NQUWlDYkls?=
 =?utf-8?B?bHQ5dU5rN1ZqL042bjZTQXdvTmFYazlWVVZRalg2U0doMGc4ckJpNkNvTnhT?=
 =?utf-8?B?QlZoUExiR1BDcUs2UXVZSXZzQms1VTF2bEV5QVdjSDhtVE01VFZsQ2hjR0FT?=
 =?utf-8?B?MjREMlBPNkhsSk1iZ1o0ZWZjMlh0allPdUwweGxlMFV4cjdCTjdmV0Y0RmQ4?=
 =?utf-8?B?eEN6VnhVOGZUT29zakRMcGhmLzA2N3Fic1BBL0g5cHYwZ3VvMUlVcDRTOVE2?=
 =?utf-8?B?Wmt4Y0pzZE5aVGlvRHljckxKRHVLTmYyazg5OEZZZXJzbW84UUdrUXlTOTN0?=
 =?utf-8?B?TWJUSGl2M2JxOFp4bmxQNU1vS0NMT21ra04zSVVydEhXK3djMHFNcGRKakVK?=
 =?utf-8?B?NlNvZUE1bDYzdzN3T1pqNHNzL0djcHNyTDBObWhVN2R3Sk1WWERYRjZvOGNQ?=
 =?utf-8?B?OWgyY2tNT05nTHNFTkFPT3Y1eGVLSnppbWhwTkJ6QXNTMXFtYm1XSFJQbEQ3?=
 =?utf-8?B?cFA1TEVMa3d1aCtDVzNGc2JzYUNUalpSL3hqckdPR1Y3ZVcyVFlEYzBkWjAw?=
 =?utf-8?B?b0srMXdYMS96YUhKSmdFU0x2NXNFazRLajVRS09RTmJ0N01qUXFSSjRWK1d4?=
 =?utf-8?B?Y1R4M0QrWE9vcE1pUkRkTVE1ckpoWHRnOXI5dEZBR0t0eE5Ob2M0eTEyY2p0?=
 =?utf-8?B?Y2owREhXWThMSnVMRUF4Rm5URm43MExlU0kvL3NObTdHNUxGdnEzMHdvSEt1?=
 =?utf-8?B?dEgrU1ZBUU5sRDVJN0x5UFQ0ckh2Zmtrc1lYYWZ5VWtxZVUrdXVQczR6aUJz?=
 =?utf-8?B?WmtKb1A1azFXOXdsY3Q2TU93NUd0Q1ZRQlVjbTN5S2dvZ05WUFYxdEIyT09B?=
 =?utf-8?B?UkZCWDAyMkhPTWU2UnV0c1VkOGxvaUNpSzdwQ3FoVmY0aWo2TkdseGJROXdu?=
 =?utf-8?B?L2UxMEV3bjNjbEIyNnFtdmF1TituSjIwaWpNeCtyU2Y0VThuQjZYbG4xTjlG?=
 =?utf-8?B?S0F6RGprR2thRVZMMEkvbnhYemYrclFyejNyYzVHUTlnc3owekQ2dnJhdlBE?=
 =?utf-8?B?RW9XWmVhdU42T3dxT2RYY21rNTdyeXA0MDYzVFpqV2VpbG1FcjZYbUFmY2xo?=
 =?utf-8?B?TjRxSlYvNkpXSnB2NWVBSlBUVU1LMXZHeUZJQW1kVHc0b29iT3JBSm5vZU05?=
 =?utf-8?B?L2liTkUxSEFBUVBhNloxdE9RRWFaak93SDJJUVBxQ0NhR0pjRkZXdjhXTWhL?=
 =?utf-8?B?UEFnMFhWNmdKRjNua2Y5d1dQYmlXRU5sd0FCSlMzeE13Zmsvd1pKYXJRMDAw?=
 =?utf-8?B?azhXSDNCNmZydnJQSXBtVStTTXFwNVg5YkQ2eXBhakJKSFM1VHBlSFdNMkpk?=
 =?utf-8?B?MXVTaXJ1U2RuWG9aZExWdUlJM3pKbHhTbGNheHo2dFgzL2NxQ1NZWjdJK2Zs?=
 =?utf-8?B?MWFhSG5iQTZ3dmJJdUVoQ3h2bFVpWnVxK1o3cmtmRG8vdUs1ZEoySStJUUEv?=
 =?utf-8?B?bTB3WWYxUGZkM0tWbHB6WEo4alR6SngzNDNGc2JTYmppY0hESDc4U0psVzc5?=
 =?utf-8?B?cW1acFRyR1JCS1A5bm9nVkZzbEVhL0NHNFNGTlA0Mk4yZzhOaENEWTk3cmJi?=
 =?utf-8?B?MkVXT2VmSzg3WVRoQjhrdVVwZHIvQ2FNUEZjeUlpMzdsTmdtMWlRUEVpN0VS?=
 =?utf-8?B?eEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE15F976FBDC28448551DE02B2254A31@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e220be5-5041-4c45-6c65-08dab62850c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:29:09.5915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91kwcY7xQgQYQKHbPfskWFxhH/ZH0x789v8eL5OhZP/KiCM5rsqn/zc74pdOZplaVH4ZlUc7LzYauaH8Ry35Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gQ3JlYXRlIGEgc3lz
ZnMgYmluIGF0dHJpYnV0ZSBjYWxsZWQgImFsbG9jYXRlIiB1bmRlciB0aGUgZXhpc3RpbmcNCj4g
InAycG1lbSIgZ3JvdXAuIFRoZSBvbmx5IGFsbG93YWJsZSBvcGVyYXRpb24gb24gdGhpcyBmaWxl
IGlzIHRoZSBtbWFwKCkNCj4gY2FsbC4NCj4gDQo+IFdoZW4gbW1hcCgpIGlzIGNhbGxlZCBvbiB0
aGlzIGF0dHJpYnV0ZSwgdGhlIGtlcm5lbCBhbGxvY2F0ZXMgYSBjaHVuayBvZg0KPiBtZW1vcnkg
ZnJvbSB0aGUgZ2VuYWxsb2MgYW5kIGluc2VydHMgdGhlIHBhZ2VzIGludG8gdGhlIFZNQS4gVGhl
DQo+IGRldl9wYWdlbWFwIC5wYWdlX2ZyZWUgY2FsbGJhY2sgd2lsbCBpbmRpY2F0ZSB3aGVuIHRo
ZXNlIHBhZ2VzIGFyZSBubw0KPiBsb25nZXIgdXNlZCBhbmQgdGhleSB3aWxsIGJlIHB1dCBiYWNr
IGludG8gdGhlIGdlbmFsbG9jLg0KPiANCj4gT24gZGV2aWNlIHVuYmluZCwgcmVtb3ZlIHRoZSBz
eXNmcyBmaWxlIGJlZm9yZSB0aGUgbWVtcmVtYXBfcGFnZXMgYXJlDQo+IGNsZWFuZWQgdXAuIFRo
aXMgZW5zdXJlcyB1bm1hcF9tYXBwaW5nX3JhbmdlKCkgaXMgY2FsbGVkIG9uIHRoZSBmaWxlcw0K
PiBpbm9kZSBhbmQgbm8gbmV3IG1hcHBpbmdzIGNhbiBiZSBjcmVhdGVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiBBY2tlZC1i
eTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gLS0tDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
