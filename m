Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCBB60C11D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJYBhs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiJYBg3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:36:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4893D148FCD;
        Mon, 24 Oct 2022 18:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3VpiWO4qMikx0OvKgsEda/0p3VtPMYX+xUj20l84kVRYgWEh20ZQlXEMeA5M17o7PyUoG8OPAQ5syveu9HELh3akVQ+DbaIOvN9hmAR2WWBSEUOl0J7NrOCzA7oMGWzsKT8Slrhk6nz25JFA0zw3sNxNy9WBF0nidyrA9YXZM+fzdqbHhvxg6neoe6eB6TMZJrLdXzvoJ7Zm3YTEf8iw/BNfHkAcHIdqTYf9pyGHA2mkjBZHw9l1LjMYrcolDuGnL/NSVSnM8ATHWdJBN8P5rtdwMloC5FJw0h868Ir+fdeRBG6XPkKayls+WxFN6nS9uenz0S2ZHo8ceD8CBOv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l81gJNE+Sff5CtWx1DvhgJt2TlcOEigcP7uk9UlKATs=;
 b=WlI7s4aLtzgIyrhAI8VsSCkhRQU/3NJUmb6knhtMnohaIpFrimRZX20400bMBiBoOSLbZVjQaYwpL+DZwyrYJ2O0GvRGw3Wc6bV+F6Dg6J5ZvYQABAbSiBdugPu+YRCmGwnRbND/ppsBx6Smab+cu9G9C8m3lX5HRiihOcbi99yT8OtjkXIqkzzsO/MWWqbGf5Q2Zhi8s1hL/uUnAUZtsVkhlIB9zCr0K8MRD1W/lERLs2sYYml2EZGShoU6phNHVl0p3LU0V5RMDBqWIkj5nWYpdKvFMsgnksqY7V6S/B1ERqzXdHp9QHu1Y+gkIqVQPxnjxryTBEGh+KTl2RlgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l81gJNE+Sff5CtWx1DvhgJt2TlcOEigcP7uk9UlKATs=;
 b=dfdwLCRKmUwtNyXg/4i9SGHUZIXA1xdeixyqtMrslZ6BWSx65qVJ6L8h4c39Xyn2mv7rOv87c3+ijdVJSnKUupTEiF7kg0g68UAXhCPRF9J/nw3sCyVA/smKKk/uOBGn01A1rt/PlS1F0ugMVz5/mbi143pwfz2zyNOkja8w9Hz2ZsD+TnhLOT0PjaBg0E0/++8+w3W/jqy2zpmRQM0h5dmEXJyeUyyOxHy/YQK++IKlhN2eNY62bLTGlEh+OlCkD1N8+XPJd10t/BQi30LQNdPcdqfSe+VNaqIZw6Hk99p0Wk1tELSEmvVJoeVmUrOfbAbkWxEsSNc7wJFRnM5uFg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.23; Tue, 25 Oct 2022 01:14:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:14:08 +0000
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
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
Thread-Topic: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
Thread-Index: AQHY5XRe8TtJa6WtAUuYJ5RZS4jbVa4eUz+A
Date:   Tue, 25 Oct 2022 01:14:08 +0000
Message-ID: <929ac68b-cf07-8df6-e589-49b0576a50c5@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-4-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-4-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB6584:EE_
x-ms-office365-filtering-correlation-id: fb81984b-67aa-430b-cbfe-08dab626376d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Id+Ztb/xOZTisOBDrDPA4OypXVF+0vs7xLKpHj3vC511T0f0b/oOc1qSzyGVj3VSvmPEz+82gYLh90Gh/m68WcUAOy8HHWyYT/6i7ptkaPjpoJGEwvXJQQFnNPsAjYQwUEZd74hQytynSkrTR3jqo7i2mWteWIksBFYoNAFvQJM4PS8fNsGfjFy9oFgXMdIv+phDGBUF1fApxLXwT+whuJjFci03lPSld31gOHWCB8vhLKgS4h2ryehR9WZ5rzElKwA/qODgOprinGiibsupdCZP6ieXSepsL870nI3CqkXWW0zVedV+78tl4Oo6dO6jFlnIX1f/5njPDJhCrZM4vu7Wm+mVJp3Oj10yERb3fefY2qV0vxV4OBspIVjPgiFI8O2kG2mTOVagYTaFo61NdHIgiyT1z3eSil3efVDKpGPZWbDH85H1qC+l+cXjUxXuNkCSVpi5WXH7dc+4niTomqysv50yQeMPwigPeimTPEqHPjEXJxrWklxz6XKu7SJ3VUkr15o9WmZvmRHmuwNgDc9N1RrY41wIDW/Wv/+ne8RpRfkntGr/w2N+AWV/pEyZoNWhr45uoGytouAcphNKFyp7VX9V/5NFFFZPL65/pMyDiLaMuFWSpkdpyJ1/cj3GPIUg/1IZaEaKbeSKw/+vOWNgcIQcAyy2bdKtRENS1degq+rbz0yGkm+08mhf2CckkHtjjT4q7iYCo+ns7FRiKqu6gC2hWbFBCZLepYvVGeJ9NpkktuKBARSvs5/j9eAfWgJsfathWtbGYQTitxs0Z5W+HOxXh2ObYud1lyipqhhXvjY52e0qv9tvLaASXh/j0V4Dt6u1g7EYTnF8MdE/4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199015)(8676002)(71200400001)(83380400001)(2906002)(76116006)(4326008)(36756003)(478600001)(91956017)(6486002)(110136005)(316002)(6512007)(54906003)(38070700005)(41300700001)(86362001)(8936002)(122000001)(38100700002)(31696002)(31686004)(2616005)(7416002)(5660300002)(53546011)(6506007)(186003)(66476007)(64756008)(66446008)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1NicHAvdHJINDdvWUI1SEpNaitISk1rdTF2aVg5T1FtbU0vUGRzS1U5Qi9l?=
 =?utf-8?B?a3k0YW9GUWpJOUZTb1RySlorakltc2NDdGFYSW8zN1B3VEpXT0NaM0VDQWVT?=
 =?utf-8?B?aFAwQ1Vya2RIWU90UUd6ZGJ0aFRlaDhGS21obDVOdkRyUGRrNUxHZ3Y5bTBF?=
 =?utf-8?B?R0pNYlh0RHJDYi9sMWFyM0lpZkxuYjkwRDBnY2haS1pQbU9XSjZiVEFmaWkr?=
 =?utf-8?B?czdGdVBTMWlZRGpnaDRxNkorc3hOOEQ5SnZXcUt4YU9XbWgzVVJsdllYUlIz?=
 =?utf-8?B?TVQxcEc1c1hpSXNRdjdkQTc0MGdjOENVRnlHc2dEZnYybjRCdnpTaDMrYkhL?=
 =?utf-8?B?ZDMxaGZRSk40bUtmek1xWktpNjBvdmVpenZXSDBTZ3FpUVZGd0ZvWlV0bk9L?=
 =?utf-8?B?T3NIb0Qvb2M5T1FvYzRvNHRLMHlkMW8yN0dYVXkycEQvWm81Y2Q3K3NncGw3?=
 =?utf-8?B?Q3NWYVFQOHI4QmMxd1dTT0NPYjFVQ0s3cVd4MEJDYzBhMWhDbWZ6cFdvNUg1?=
 =?utf-8?B?eTFXbFQvZ1pWQkk5VTJZdGFENDBrU3BXQTdIdWQ4K05ucHdQcWd0eDRhQUFS?=
 =?utf-8?B?NlZtY3dNZFRITHlIVXIzMldDeDZTZ3pQbENZUjExUzJqZWFYU296WTl0VEIy?=
 =?utf-8?B?Nnh6VzdOSVBqU3pPTHNZU0V3RWpuS2JJbXJKdkcxRERxZXdpK28zbnVCVFFQ?=
 =?utf-8?B?Q0U0RFoxY1krSDNlb2hTNFlPcVppWndpWUgwcVEzeEl6d0Qya2Fvd1pqYjFm?=
 =?utf-8?B?d3JGSWFzRUNCV2NOS2RJQWEzSzJZK3Y5bDJnU2plaGZtdGN4eFJvQlVrRmMx?=
 =?utf-8?B?Y0g5SnQrTTFrcVp6WUt1MzNiMy9rRWNaeEd1MFc4TTBFYVdidDVmQXhQMFNC?=
 =?utf-8?B?ZzQwbnlsQytJVXlLUXhSbVZKZ2RDSE5qUmM2TXhpdG0xZS9KTHpNZG16a3NF?=
 =?utf-8?B?NTJ1ZW56ZEZtSlNlV3dZcHZCZ3o4MDk5eG9XYmQzUlVZUlRpL3Fjci8rRkVl?=
 =?utf-8?B?dTFWVlNTL1ZxVEhKWXVybElQUjU1OVJKdFAyMVMyY1ZZQVVISjRKRzRpNjE4?=
 =?utf-8?B?enVSakJXa0Q4MVpmcmVSSHp6Z2dhZ3lJNDRFWDZMWWc2TysvREs0Snl5RDN2?=
 =?utf-8?B?Z1hDNmNOdExoZmRIZlRGSTZNS3pOYm53TEVkaDFZYVlDVTd0ZDNBb3hKUEVr?=
 =?utf-8?B?VCtkOXZaNTNxZEdMaGIzc29FZXFlVVBWR0JKeTV1U2hPcFNSOGFZWmJUbnE1?=
 =?utf-8?B?dmdXbW1mMHI4ejdkZVhmK2xWU2ZyTWNDbnlqQjExN2NVOGN5UjlidG5nZnBJ?=
 =?utf-8?B?VlRUdTNQRTd2blVRcXNzQ1RJWG02NVlMeXJTOGJpVFRVYmc0Q2FOTkUyTU9N?=
 =?utf-8?B?TjdaY3R4QzYyb3IvRk9JdHhnZXEyZ0tPRUoxZlpHSGJCd1FPTmltS2RjQWVa?=
 =?utf-8?B?VWxlbU1LUnJkbHZhdnozVXVYOUUzZDNxM1pxMUNIS3IwZ0doUVMzeDlmY1dF?=
 =?utf-8?B?VGRiRnRjb0w2Y25MYkZwVnBFd3RlMGt6Nm9kUG5rTE9VYnYwMEFKUENDdXZh?=
 =?utf-8?B?SGphc2xtWDVDRUdEc25RdkhsK1BVSjlLQ3RVSEFiTFRKZnNGNTVDTmZqbE96?=
 =?utf-8?B?encyN1JlL2VyTDJFc2JWaldiWFNVYXZHeG9raWRjaU5EZTJtY3BMZEJrSnN1?=
 =?utf-8?B?RXNRemMrcUhsZDJQK0FzZ3hWNW8yWUYyaXlQV2ZWOGxzVWlJMDlXUCtsSmY3?=
 =?utf-8?B?R084QnNBdFptZnJya2Y1Q2IwQWVLempVeHRDM0VtZkJMeGZ4RW50TlJrRndt?=
 =?utf-8?B?VThJcTI0SUhEamEzbVI2MVZhR210cEFDbjhtSVBxVUJPSEJtRSt4VVpqM1B1?=
 =?utf-8?B?ajVRNk5xUUx5WmJLbTJrVHhSRm8wYUhkTkx1VUZ0Qkx6WUpuSDd1N20rQUlR?=
 =?utf-8?B?QnlFRmpJZ1ZvbzArM0VQZmRYcFJlQkxWY3FwTThXeDJML0ZPNFVKaGxDUmVR?=
 =?utf-8?B?SkVIZkdoTmlJbVNPNDd4WURuaWdEN01mUEVzczZHNDc2Q2hpejFBSlBEMDdw?=
 =?utf-8?B?MW1NNWhpbzZsaE0ycEt1eEtKVGdhNGZQL1FOeHkwSG1LaC9FT1VsdDNzTFda?=
 =?utf-8?B?Z05GMTFpL25HZlNlRkJqTXcveDRKUER6WUJtdmFld1ZBK1dKelVEUGhyRXRZ?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D3E6BA4ADE1684CA1781D1D18A2AD5D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb81984b-67aa-430b-cbfe-08dab626376d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:14:08.1145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q4DSXBnOgMfXm7r7hIHxX/glqCEhSQpNjNWFTMDK+VbfGqZATfCLe2Tca8gPXkEsTawMI6ZIJUxTyfVhbWvYsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gQWRkIGlvdl9pdGVy
X2dldF9wYWdlc19mbGFncygpIGFuZCBpb3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2NfZmxhZ3MoKQ0K
PiB3aGljaCB0YWtlIGEgZmxhZ3MgYXJndW1lbnQgdGhhdCBpcyBwYXNzZWQgdG8gZ2V0X3VzZXJf
cGFnZXNfZmFzdCgpLg0KPiANCj4gVGhpcyBpcyBzbyB0aGF0IEZPTExfUENJX1AyUERNQSBjYW4g
YmUgcGFzc2VkIHdoZW4gYXBwcm9wcmlhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBH
dW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5jb20+DQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC91aW8uaCB8ICA2
ICsrKysrKw0KPiAgIGxpYi9pb3ZfaXRlci5jICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Vpby5oIGIvaW5j
bHVkZS9saW51eC91aW8uaA0KPiBpbmRleCAyZTMxMzRiMTRmZmQuLjllZGU1MzNjZTY0YyAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC91aW8uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3Vp
by5oDQo+IEBAIC0yNDcsOCArMjQ3LDE0IEBAIHZvaWQgaW92X2l0ZXJfcGlwZShzdHJ1Y3QgaW92
X2l0ZXIgKmksIHVuc2lnbmVkIGludCBkaXJlY3Rpb24sIHN0cnVjdCBwaXBlX2lub2RlDQo+ICAg
dm9pZCBpb3ZfaXRlcl9kaXNjYXJkKHN0cnVjdCBpb3ZfaXRlciAqaSwgdW5zaWduZWQgaW50IGRp
cmVjdGlvbiwgc2l6ZV90IGNvdW50KTsNCj4gICB2b2lkIGlvdl9pdGVyX3hhcnJheShzdHJ1Y3Qg
aW92X2l0ZXIgKmksIHVuc2lnbmVkIGludCBkaXJlY3Rpb24sIHN0cnVjdCB4YXJyYXkgKnhhcnJh
eSwNCj4gICAJCSAgICAgbG9mZl90IHN0YXJ0LCBzaXplX3QgY291bnQpOw0KPiArc3NpemVfdCBp
b3ZfaXRlcl9nZXRfcGFnZXMoc3RydWN0IGlvdl9pdGVyICppLCBzdHJ1Y3QgcGFnZSAqKnBhZ2Vz
LA0KPiArCQlzaXplX3QgbWF4c2l6ZSwgdW5zaWduZWQgbWF4cGFnZXMsIHNpemVfdCAqc3RhcnQs
DQo+ICsJCXVuc2lnbmVkIGd1cF9mbGFncyk7DQo+ICAgc3NpemVfdCBpb3ZfaXRlcl9nZXRfcGFn
ZXMyKHN0cnVjdCBpb3ZfaXRlciAqaSwgc3RydWN0IHBhZ2UgKipwYWdlcywNCj4gICAJCQlzaXpl
X3QgbWF4c2l6ZSwgdW5zaWduZWQgbWF4cGFnZXMsIHNpemVfdCAqc3RhcnQpOw0KPiArc3NpemVf
dCBpb3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2Moc3RydWN0IGlvdl9pdGVyICppLA0KPiArCQlzdHJ1
Y3QgcGFnZSAqKipwYWdlcywgc2l6ZV90IG1heHNpemUsIHNpemVfdCAqc3RhcnQsDQo+ICsJCXVu
c2lnbmVkIGd1cF9mbGFncyk7DQo+ICAgc3NpemVfdCBpb3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2My
KHN0cnVjdCBpb3ZfaXRlciAqaSwgc3RydWN0IHBhZ2UgKioqcGFnZXMsDQo+ICAgCQkJc2l6ZV90
IG1heHNpemUsIHNpemVfdCAqc3RhcnQpOw0KPiAgIGludCBpb3ZfaXRlcl9ucGFnZXMoY29uc3Qg
c3RydWN0IGlvdl9pdGVyICppLCBpbnQgbWF4cGFnZXMpOw0KPiBkaWZmIC0tZ2l0IGEvbGliL2lv
dl9pdGVyLmMgYi9saWIvaW92X2l0ZXIuYw0KPiBpbmRleCBjM2NhMjhjYTY4YTYuLjUzZWZhZDAx
N2YzYyAxMDA2NDQNCj4gLS0tIGEvbGliL2lvdl9pdGVyLmMNCj4gKysrIGIvbGliL2lvdl9pdGVy
LmMNCj4gQEAgLTE0MzAsNyArMTQzMCw4IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqZmlyc3RfYnZl
Y19zZWdtZW50KGNvbnN0IHN0cnVjdCBpb3ZfaXRlciAqaSwNCj4gICANCj4gICBzdGF0aWMgc3Np
emVfdCBfX2lvdl9pdGVyX2dldF9wYWdlc19hbGxvYyhzdHJ1Y3QgaW92X2l0ZXIgKmksDQo+ICAg
CQkgICBzdHJ1Y3QgcGFnZSAqKipwYWdlcywgc2l6ZV90IG1heHNpemUsDQo+IC0JCSAgIHVuc2ln
bmVkIGludCBtYXhwYWdlcywgc2l6ZV90ICpzdGFydCkNCj4gKwkJICAgdW5zaWduZWQgaW50IG1h
eHBhZ2VzLCBzaXplX3QgKnN0YXJ0LA0KPiArCQkgICB1bnNpZ25lZCBpbnQgZ3VwX2ZsYWdzKQ0K
PiAgIHsNCj4gICAJdW5zaWduZWQgaW50IG47DQo+ICAgDQo+IEBAIC0xNDQyLDcgKzE0NDMsNiBA
QCBzdGF0aWMgc3NpemVfdCBfX2lvdl9pdGVyX2dldF9wYWdlc19hbGxvYyhzdHJ1Y3QgaW92X2l0
ZXIgKmksDQo+ICAgCQltYXhzaXplID0gTUFYX1JXX0NPVU5UOw0KPiAgIA0KPiAgIAlpZiAobGlr
ZWx5KHVzZXJfYmFja2VkX2l0ZXIoaSkpKSB7DQo+IC0JCXVuc2lnbmVkIGludCBndXBfZmxhZ3Mg
PSAwOw0KPiAgIAkJdW5zaWduZWQgbG9uZyBhZGRyOw0KPiAgIAkJaW50IHJlczsNCj4gICANCj4g
QEAgLTE0OTIsMzMgKzE0OTIsNDkgQEAgc3RhdGljIHNzaXplX3QgX19pb3ZfaXRlcl9nZXRfcGFn
ZXNfYWxsb2Moc3RydWN0IGlvdl9pdGVyICppLA0KPiAgIAlyZXR1cm4gLUVGQVVMVDsNCj4gICB9
DQo+ICAgDQo+IC1zc2l6ZV90IGlvdl9pdGVyX2dldF9wYWdlczIoc3RydWN0IGlvdl9pdGVyICpp
LA0KPiArc3NpemVfdCBpb3ZfaXRlcl9nZXRfcGFnZXMoc3RydWN0IGlvdl9pdGVyICppLA0KPiAg
IAkJICAgc3RydWN0IHBhZ2UgKipwYWdlcywgc2l6ZV90IG1heHNpemUsIHVuc2lnbmVkIG1heHBh
Z2VzLA0KPiAtCQkgICBzaXplX3QgKnN0YXJ0KQ0KPiArCQkgICBzaXplX3QgKnN0YXJ0LCB1bnNp
Z25lZCBndXBfZmxhZ3MpDQo+ICAgew0KPiAgIAlpZiAoIW1heHBhZ2VzKQ0KPiAgIAkJcmV0dXJu
IDA7DQo+ICAgCUJVR19PTighcGFnZXMpOw0KPiAgIA0KPiAtCXJldHVybiBfX2lvdl9pdGVyX2dl
dF9wYWdlc19hbGxvYyhpLCAmcGFnZXMsIG1heHNpemUsIG1heHBhZ2VzLCBzdGFydCk7DQo+ICsJ
cmV0dXJuIF9faW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jKGksICZwYWdlcywgbWF4c2l6ZSwgbWF4
cGFnZXMsDQo+ICsJCQkJCSAgc3RhcnQsIGd1cF9mbGFncyk7DQo+ICt9DQo+ICtFWFBPUlRfU1lN
Qk9MX0dQTChpb3ZfaXRlcl9nZXRfcGFnZXMpOw0KPiArDQo+ICtzc2l6ZV90IGlvdl9pdGVyX2dl
dF9wYWdlczIoc3RydWN0IGlvdl9pdGVyICppLCBzdHJ1Y3QgcGFnZSAqKnBhZ2VzLA0KPiArCQlz
aXplX3QgbWF4c2l6ZSwgdW5zaWduZWQgbWF4cGFnZXMsIHNpemVfdCAqc3RhcnQpDQo+ICt7DQo+
ICsJcmV0dXJuIGlvdl9pdGVyX2dldF9wYWdlcyhpLCBwYWdlcywgbWF4c2l6ZSwgbWF4cGFnZXMs
IHN0YXJ0LCAwKTsNCj4gICB9DQo+ICAgRVhQT1JUX1NZTUJPTChpb3ZfaXRlcl9nZXRfcGFnZXMy
KTsNCj4gICANCj4gLXNzaXplX3QgaW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jMihzdHJ1Y3QgaW92
X2l0ZXIgKmksDQo+ICtzc2l6ZV90IGlvdl9pdGVyX2dldF9wYWdlc19hbGxvYyhzdHJ1Y3QgaW92
X2l0ZXIgKmksDQo+ICAgCQkgICBzdHJ1Y3QgcGFnZSAqKipwYWdlcywgc2l6ZV90IG1heHNpemUs
DQo+IC0JCSAgIHNpemVfdCAqc3RhcnQpDQo+ICsJCSAgIHNpemVfdCAqc3RhcnQsIHVuc2lnbmVk
IGd1cF9mbGFncykNCj4gICB7DQo+ICAgCXNzaXplX3QgbGVuOw0KPiAgIA0KPiAgIAkqcGFnZXMg
PSBOVUxMOw0KPiAgIA0KPiAtCWxlbiA9IF9faW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jKGksIHBh
Z2VzLCBtYXhzaXplLCB+MFUsIHN0YXJ0KTsNCj4gKwlsZW4gPSBfX2lvdl9pdGVyX2dldF9wYWdl
c19hbGxvYyhpLCBwYWdlcywgbWF4c2l6ZSwgfjBVLCBzdGFydCwNCj4gKwkJCQkJIGd1cF9mbGFn
cyk7DQo+ICAgCWlmIChsZW4gPD0gMCkgew0KPiAgIAkJa3ZmcmVlKCpwYWdlcyk7DQo+ICAgCQkq
cGFnZXMgPSBOVUxMOw0KPiAgIAl9DQo+ICAgCXJldHVybiBsZW47DQo+ICAgfQ0KPiArRVhQT1JU
X1NZTUJPTF9HUEwoaW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jKTsNCj4gKw0KPiArc3NpemVfdCBp
b3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2MyKHN0cnVjdCBpb3ZfaXRlciAqaSwNCj4gKwkJc3RydWN0
IHBhZ2UgKioqcGFnZXMsIHNpemVfdCBtYXhzaXplLCBzaXplX3QgKnN0YXJ0KQ0KPiArew0KPiAr
CXJldHVybiBpb3ZfaXRlcl9nZXRfcGFnZXNfYWxsb2MoaSwgcGFnZXMsIG1heHNpemUsIHN0YXJ0
LCAwKTsNCj4gK30NCj4gICBFWFBPUlRfU1lNQk9MKGlvdl9pdGVyX2dldF9wYWdlc19hbGxvYzIp
Ow0KSnVzdCBvbmUgbWlub3IgcXVlc3Rpb24gd2h5IG5vdCBtYWtlIGZvbGxvd2luZyBmdW5jdGlv
bnMNCkVYUE9SVF9TWU1CT0xfR1BMKCkgPw0KDQoxLiBpb3ZfaXRlcl9nZXRfcGFnZXMyKCkNCjIu
IGlvdl9pdGVyX2dldF9wYWdlc19hbGxvYzIoKQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
a2thcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
