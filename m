Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E805473701
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbhLMVzJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 16:55:09 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:60257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243362AbhLMVzH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 16:55:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqH8JXpztHIYXeSKaFHbBDdsC/cl0u2iYCcUNiy50RzmT/GE9yo9jITxfhIHFz7t4vyC4PJOd7pMQDFPl5zJ9M4aa+/N4+Y2opr5k1us77NxCzoYBf7TR8/TwThElWwgaaqmVCVg+UNoCOQJeS+dH22MqDGtd2Y9Jat56h6+4cnJJ8NF6CEo6Fe9on/2eodVLlj8/Qe9fjlRthRDrVB49L3YIb+K/L+plGSpOW4kxqw2IucBuS7wGECy7XYzkHSgS1EQhv02fNGTvlrOGpPB0aNLD3SJNil2IEIwwC2L3iopcOs3E+LGM6Yh8wmLvr21DaJzDEGsOQDK8lhuXjBcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yODjFrmxoanzoIruGJFvCJq0S+Suec08HdaUKD+qNWA=;
 b=Gh6T0LmI1XMJCB5/0Q6miMrJH0jMrr/abR1h2FdQyTNp8dGxb2SXflaiQHrUil/Hr9ONll7wTkx5mfWPC9bObc6rcf+p8xLm5jK131cVyYM8jlIQGAdf9wu+o8ZQWhShLmAJRQIDEN6ihW9iMsclr5Q/BFt4Wu91FJa+8PGvfgraUnegPds9KK+DJ1HHn7h7+zsrqD1Bvxbkw3yQeRQ29zJfLxceI4K67+qIHnZlK8KhPri3EFycRhnuzZ1H2PSTLS2y2ja1tvaoZ0MN3fH1/qwX1yZvLhc8DVzSaY8KmpDNAN2YzW4u3I6o/LFoOG9bVLGINbBXtkqZ5cVOitNceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yODjFrmxoanzoIruGJFvCJq0S+Suec08HdaUKD+qNWA=;
 b=HDzzyh7JOkQHhMueNLaS0fXCpfr2D0My5akkzB0bTkCqPVjuM52+Bmscb0QeaZduyhG7Y7ZT3dGLsuFLI9N+l65QLiHpF6mCV3UFpQm3rBO7nMLmm4Wa1OWlc6mkTsFQnv/G2ygr+YHBOmXC/jwXHcEIF8+iNM+c6jTW3lIDTPaWLQGbXRVGjHmEgAjjHj9xySC8TkTEb18YdPM1N36FEi0VAGJfHH8bywLV2Htt1zypW7jMEYIBsBw3B5Y6oHWFq9Un65G3+PiTUx4ust4mSUR24ETVbYIbmwPoq8Fw4SzyLyTnfx9Jr+T8EZ0mwu2PYaSurSsQ8OarWQh6EOK0TQ==
Received: from MW2PR12MB4666.namprd12.prod.outlook.com (2603:10b6:302:13::22)
 by MWHPR12MB1888.namprd12.prod.outlook.com (2603:10b6:300:112::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 21:55:05 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB4666.namprd12.prod.outlook.com (2603:10b6:302:13::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15; Mon, 13 Dec
 2021 21:55:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 21:55:04 +0000
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v4 02/23] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Topic: [PATCH v4 02/23] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Index: AQHX2/4HhhXnoaESEkiImBNJsNrdDqwxIC8A
Date:   Mon, 13 Dec 2021 21:55:04 +0000
Message-ID: <50654705-f0df-db35-629c-60fa488e6215@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-3-logang@deltatee.com>
In-Reply-To: <20211117215410.3695-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d73ec594-33dd-4653-2632-08d9be833874
x-ms-traffictypediagnostic: MW2PR12MB4666:EE_|MWHPR12MB1888:EE_
x-microsoft-antispam-prvs: <MW2PR12MB4666E071017F6F17FD114D1BA3749@MW2PR12MB4666.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZR0nG2To3AqK1mBoRvu0YNWsCJvetq2OMTu4JLl8xTREzU/i2zwyHPyzqCPgA3jHABwEqhI+pTrV/Ta+neV8mCELsIWmvo3brpvBQMLA8x3YSqFyIjglQCER32LzKySEvazhjaJAMQEiY2NtHe1oE3/kkXEyqRxKjbjSg481eSOl3+kPQHIpHSnOoVcitGJSVwbs7r+XNH05AYDBn/S5jrHPbTMmDAY5WwI8egzT/3qD9E7jiJ50CBouut4iO1rCioMtj1Uj3gzEawzND+S8yjFQWYZP4ZBsfAQgDqS5CxL93Vfu5w5gsgdH2GXTCH1TY8serT76KbB04/KVEaNloQurGqf5i8oXKsP1LJCM4CkreIhAznY1/zPa0lwWGA9u0EDfiInJIofFKkysODSqDAg1nx/Md2ZpDbNlpUP9MOL9ohStzYW6x/kocMnt6LEE51C5tuqEoQdpEctLs2zgKM6b7r6dpxJb7VMSLIyJjgYcIF19lZG3wKMiHDF8fCotePIPRM4bnTAVYwpEFc46uxhe3+zwrjrD+bAodlcu++D9aP+ChveRn8F7j9vD2wnhi902EEdvAeo+M+rxb2Ucj9MSZCTH/FKXolJ7Yvkd9rNmB7Y1BufO+stbN3qE8+TR3fS9eQsLC3t3HGFY55rrF3ogZko2A1IOpjos7lrQzKJzvSlfXECgdCthBXX73z5whfxkl/i5UR7LP7jkZzP4kzYE5ljJbbCwC22HTEVJhmd/gsjPu3gNiAdanOmWWhUDFIlFTxGjaBn+d4uinC+GQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4666.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(508600001)(316002)(5660300002)(110136005)(54906003)(38070700005)(7416002)(8936002)(6486002)(64756008)(122000001)(31696002)(4326008)(38100700002)(8676002)(66476007)(71200400001)(186003)(53546011)(36756003)(31686004)(66556008)(76116006)(91956017)(6506007)(4744005)(66946007)(6512007)(66446008)(86362001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blRjWnlHNVdaRUpqamt3M1ZLaUdjaWF0ZHFOTGZ4SzhQVzVxK3J6ZjlFaTA5?=
 =?utf-8?B?UzRKejkzc1NXSkhPbUtoRlp1MWtpemhUd3pUVjZ2MFM0Tkk4c2FmZlZYcWlM?=
 =?utf-8?B?V0J2aXhwSmRHSGhDRWZRMnRHM3VEOU1EQ2w5eWpOd2poY2IvNERmQjl4SGJD?=
 =?utf-8?B?YmN5b3dDYU45YXg4akF6bUdnZDI0ZkltWk9qUHptekQ3ZFBLeXBRWlZHWjYv?=
 =?utf-8?B?TVd3eitEK0J5cXZ6WmlrbFZURkVqVjhBT09uaVVtYWhrNGRnVXhSLzFaZ1FV?=
 =?utf-8?B?SzJGZGNuV1pSRnZDNXAxVnJUK0x3bGw4VXdaa3p4aVIzbXNRdFdoTThweStm?=
 =?utf-8?B?QUhIS01XUG16QWtQT3Q1NjdLRWhqWFRpejZaelJsWFcxa0JsUStDSjFIaG93?=
 =?utf-8?B?dGFPcFV6VVpxRzhEYXlBWiswd3B3NTZoUzdEeXRjY1gybThiRCtxMzBBVC9q?=
 =?utf-8?B?cWJKUk5oenJ0SFgrWERjNEtVd005Tk9aQVRkY2JobHdTTk45ZU5Hc1Q1UEJq?=
 =?utf-8?B?bHgvTlppaVYraGk5RHVUaXZGMXh0OGdWOEx6aVdzbmUzUG92dXBQTDEwTjhm?=
 =?utf-8?B?RkhIU2grYXBZUGkzcnNSR3IvSGZOUzRXMXhuWENyZmNma01PTHZWbGIxbFZy?=
 =?utf-8?B?UjRzVjBhbkR1RjhDaFk4WDVtUEdkcm5SVjlNUnA1SDBDRjFvcXBKM3RiQ29r?=
 =?utf-8?B?SDBlbmpLNGIreEloMndxT3EyWjUyVXFxdG5QYWN5UTVFQU5UYkc1WkdjZ2FE?=
 =?utf-8?B?TjB4UXlYdnhXYlYxc0VxY2tZM296VTljbmh5dnJZUkEwcldIY21oSzRJUDAz?=
 =?utf-8?B?c2VTYzVsblo5RTJ1Qkp1enhyK3pjVlZtS25SL3dJQWFwbytZVmQwdXl5V2Rx?=
 =?utf-8?B?S0g0eGlrR1VXVlF0ZGdwd1ZxbVl6QVhDb20yTS91bkoyVHRkUmUxTmNGVmw2?=
 =?utf-8?B?N1U5Z0oreUxuU0VHM2h5cnAxbWY5UUdOTEx3RHMxOTJyaDJiaGx3S0VLWGJS?=
 =?utf-8?B?eU9kVGViZm9EdnpLTjlyY3l1MUdMalJrZTdyWURPTHVsMjVlVzNhNmhSS2dq?=
 =?utf-8?B?WFREM0pxNStUYTBjWWtqVjhva21ETnJ2WVNuS2NUTWdXSzFTNCtSRXFNSzVa?=
 =?utf-8?B?dy9rNno4N3dxZWRlQ2l3REdTRVdiY1V3OXptU0hOK0E3a0FRUGlXazdQQy9n?=
 =?utf-8?B?U3M5dk9wMmNIUFVxcjI5S0lSRHVBVUJEcjdsSmlWZFNVU05xNGVrV0Q5QXRN?=
 =?utf-8?B?L3o5UmNmazd3Q2xSNzE5bTNob0lzVHI2N2w5bURNc0hvQkpNcjBuT2daR1JF?=
 =?utf-8?B?YXFoQ0srWTBRcG0rU05ROCtIak5nczVvUlRCd2NQc0dEemFKMTljL0sweTRQ?=
 =?utf-8?B?QjkxK1o1V1V1czlYOVhUODkzdlBXTFN1Ylc2UWFMSUxydyt6dXBTNURURERy?=
 =?utf-8?B?c055a2NKQUNPbGhpNUhTSVlZOFpUSFRMUzg0VFY3TVc0ZUYyckptZmsvcTNZ?=
 =?utf-8?B?OUh0ZXNQTFpEZytEaW8rWjNpdDZOL3JnRjFOY2xsRkhqdnkyZ3BvMGFHdGg0?=
 =?utf-8?B?YmtyQklGNG9IWjVRZTJmV2VEd2xsa2dITGNteEcyRmQyaDFIekMvRExEaWV5?=
 =?utf-8?B?cnEwSWhpV09wSGluYWMxUGtxVzR3Ylg1a2cxT1NmV1JxVm5SYTBZMmpJcGxl?=
 =?utf-8?B?Qytyb3FHUkw2dGpKQ05qQk9zcVNMWHRVdXJiRnBsNDIxVlZGd3JLQU51b1ZM?=
 =?utf-8?B?SnhTM1lFMVVaMjJMczZuNkQvcm1mRk1BNjVnZVYzVElRT1NuVk1BekplcXVJ?=
 =?utf-8?B?WHR1OTd0K0JvbW4yOG1YdkxJOXAwZStleG9ZaXBzeEZ6ckY1Wld5WHZuV05R?=
 =?utf-8?B?aWlwQkdjRkF4a3Q0N3l6SXdsUmhaUEN6emk5ZC8wSVRHVGlBRmkzTG9TTVpT?=
 =?utf-8?B?d21qZm9HWk9jdDE2aG4vM2ZaYkxlVjZHNitURTJsZ01lbmtxMG01SUc3WEto?=
 =?utf-8?B?S2NtTlE0VlZGSWNrQTZ4ZXJKN1hmd1BCbFZOZTB0OHRUU1N6V0xRMnpXZkEz?=
 =?utf-8?B?QkZES09GekpWNTAwck9hcFd2dmh4Vzl0RU5aa2xjMjJ0N2FWSE5uSTczZkIw?=
 =?utf-8?B?eEtNNFdDTFZSSDNNUWNvSUh3VlRVQ2s0ZGdVaDZaVElqOXVLSWlZbUh6dE13?=
 =?utf-8?Q?7FHT+FHH/94Zf1zqkGPX4495P3E6omNwgoRZ61ALlJp3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02CDCA82C500FC47AEBE9199F465CCD6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ec594-33dd-4653-2632-08d9be833874
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 21:55:04.4516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNK/x03CWX7nGurTnZ8MR+ZbH+D/E2crA08JWR0V6eLNYWLLLVhxFi/sfcoIKc8NIOAY7dfBQVEGCFMZQcfHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1888
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTEvMTcvMjEgMTo1MyBQTSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOg0KPiBNYWtlIHVzZSBv
ZiB0aGUgdGhpcmQgZnJlZSBMU0IgaW4gc2NhdHRlcmxpc3QncyBwYWdlX2xpbmsgb24gNjRiaXQg
c3lzdGVtcy4NCj4gDQo+IFRoZSBleHRyYSBiaXQgd2lsbCBiZSB1c2VkIGJ5IGRtYV9bdW5dbWFw
X3NnX3AycGRtYSgpIHRvIGRldGVybWluZSB3aGVuIGENCj4gZ2l2ZW4gU0dMIHNlZ21lbnRzIGRt
YV9hZGRyZXNzIHBvaW50cyB0byBhIFBDSSBidXMgYWRkcmVzcy4NCj4gZG1hX3VubWFwX3NnX3Ay
cGRtYSgpIHdpbGwgbmVlZCB0byBwZXJmb3JtIGRpZmZlcmVudCBjbGVhbnVwIHdoZW4gYQ0KPiBz
ZWdtZW50IGlzIG1hcmtlZCBhcyBhIGJ1cyBhZGRyZXNzLg0KPiANCj4gQ3JlYXRlIGEgQ09ORklH
X05FRURfU0dfRE1BX0JVU19BRERSX0ZMQUcgYm9vbCB3aGljaCBkZXBlbmRzIG9uDQo+IENPTkZJ
R182NEJJVCAoc28gdGhlcmUgaXMgc3BhY2UgaW4gdGhlIHBhZ2UgbGluayBmb3IgdGhlIG5ldyBm
bGFnKS4NCj4gQ09ORklHX1BDSV9QMlBETUEgd2lsbCB0aGVuIGRlcGVuZCBvbiB0aGlzIHNvIHRo
aXMgbWVhbnMgUENJIFAyUERNQSB3aWxsDQo+IHJlcXVpcmUgQ09ORklHXzY0QklULiBUaGlzIHNo
b3VsZCBiZSBhY2NlcHRhYmxlIGFzIHRoZSBtYWpvcml0eSBvZiBQMlBETUENCj4gdXNlIGNhc2Vz
IGFyZSByZXN0cmljdGVkIHRvIG5ld2VyIHJvb3QgY29tcGxleGVzIGFuZCByb3VnaGx5IHJlcXVp
cmUgdGhlDQo+IGV4dHJhIGFkZHJlc3Mgc3BhY2UgZm9yIG1lbW9yeSBCQVJzIHVzZWQgaW4gdGhl
IHRyYW5zYWN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8bG9n
YW5nQGRlbHRhdGVlLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg==
