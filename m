Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A449F63F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 10:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347539AbiA1J0O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 04:26:14 -0500
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:13895
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237840AbiA1J0O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jan 2022 04:26:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atPA9AuMDH+k5EjkYZ1dYc+15YW9+Zfj5FgZRfgEQaj4mN12dIDilR/LPi13GP304LjoJJn2zVVZO7TyxHHu7o87tIUNsO/QHIgoH44Ke8RyjzECbGWL/A2R5USQCMKPecIl2NzhMwEjzHSQ1qL4BZLdQdRjFLV9OrRQuu3TCyQ4PFBVh55yfocGnkNT7nwjE8e+XrsciJSoS1xOpZOdC3Ezp0GhksNiCcdi5Fh3m3jCWKglxQ8XbZ4Yu6+UaXWQ/mmSunKuXmjhLrg0lhnXWwqZx2gFbYGGt+Xdlt9lWP2kEj0bOBByyUF8bgRRBaEnS+GnGzZLrSrT6HvVMmevSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JlfdSaneO6hssk3VOpdGY8Tt/qemVxWkuTFp4/yKEQ=;
 b=LVa6Q9hvZk/JJ0ev2xj/uqA9J0UyMVnsHZ+bkWu14MjWZgZi7FMZbnRneOpd4uAmVilwg2zgVuO3fV+c/CxAhfoj2cwONkmzOlqecXTMcqJKzUVIpYkxOv/2eEmCbxtUsv8CD5q+eR9p7TliaC7e79s113/ekttaB2ikFhUi3FAl1xBwuKXicPgbc83kWPsuRqJ7/DVQ0eFrAhf9Opn+GRnqPl/k6Mh8lYrBjOIdxcZH1k8eoHa74z/PK9r+P4ILL+/huVkgieXO5s0E0HtD7Z64AiJSvXV7tlZoPtanZxKHcPhyZixTfaGjr+JgGbcGACmUZ9/Tepy8Yzmk5Yh4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JlfdSaneO6hssk3VOpdGY8Tt/qemVxWkuTFp4/yKEQ=;
 b=p+DMg6+09mOraWRaaC8JwgOVv5/okPN9fw9BFoSdxzz4o3J4Rng8QjvBNNqP7mzVaflMhKc0fy0Ah2+ChVFHj0zlmXJZPugNTv6i7yxCMzvqhLLCygZjrgGBH2JVIkbbrTDA15gVS7UKr5UfFY8nMtv0v+YiMnaEEmBvOzHcB2hB/xQERgcACjanH3L90BaQLsPmhiQ17LVfxPaC0mvu6gtndzhB8K9kG7NMZrNesqj8+wIac81TfNwxIJk8bDRjHlU/w4bffHp28IDgkXogx+N1a8bH3UWEGe+5CMVZUjbaEsjHvqPi7P4F+hRoG2o35P3gfvGLK0Z/FeBCyKBkaA==
Received: from DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24)
 by BN6PR1201MB2547.namprd12.prod.outlook.com (2603:10b6:404:aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:26:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB3658.namprd12.prod.outlook.com (2603:10b6:5:1c8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 09:26:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.018; Fri, 28 Jan 2022
 09:26:11 +0000
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v5 01/24] ext4/xfs: add page refcount helper
Thread-Topic: [PATCH v5 01/24] ext4/xfs: add page refcount helper
Thread-Index: AQHYE925fJOazwCvB0GJn7o4XchvT6x4KnGA
Date:   Fri, 28 Jan 2022 09:26:11 +0000
Message-ID: <d23dce00-48ec-c319-c326-cb5a8e9410b2@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-2-logang@deltatee.com>
In-Reply-To: <20220128002614.6136-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39eb6ce5-2b2b-46c0-afbf-08d9e2403953
x-ms-traffictypediagnostic: DM6PR12MB3658:EE_|BN6PR1201MB2547:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3658AFD9B047F8E3236BB57EA3229@DM6PR12MB3658.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x3i4JSE99S/gIev/eRz536qtP5Uyin74fU6/5jO4vCdqHAN4O0RfRHNak4LNCp/UD5PN7AxncuGasoyVfGf/oAuPn92eIcV4rLo7V0/UWLoZVaNhX42MhxWR295J0m1iul8c0R/X0XEAQTkgjF3rLzzfV5PBt6DdpRN7HQrjjCCOJisgLSzCuB0nUvsI4IfLrpI97fCtvIralEMzVcXi8+gMWGR/1WumP61ZZKJBPjLPcSnYEZRKPNtDtJpnL+Sqcsg/6WTu8zj56W2h0MKxdvnhp1s2M9tyMy2wyhAQHI8GaN+WxRuE7WtNajyt+IWfi4Nqn9w63Ib4QHtSNLT2rVG/YJFekwE+yBAYqYs58SwGuEyA7N/vPe5Lgy+xJrKGbjVOpXyMfeOlKXCj/5gBGw2Tyr3zgnDmrvmNpxf4/pPmtJSTyXnhk0lIdb+eE52Q4JcM+lufZGnSkr8kthFMsCxdQvBNfz+dnnkFn2yrQqH2FvjPgHEbf0wIesKqATh+i1lfXdzqm2Swc7C686H/llrB2v5s1eKjppxSWDK/ofcRe4t4jKtyexzr4pnV9MLEf7C/IotYqAudwr3PqPpwtUywHXPlIiBuLhqPC8qUVwvAdNGC11Ikma9YxVYpu5sGTrmzwfypsPAJ+6OMCIIXgDUYs+E1WVQJXjH1pCteCAR2GB8+O7zc/3Wf86iGRtOm4s5DqR8BbBcJo9h3xn7bFGkyVgaqOBbXuIo1wh4pHYrAroEzJ244qeOTFiM/sN+iAIIesXIMDXKB0/Z5HlxVBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(7416002)(31696002)(2906002)(38100700002)(110136005)(2616005)(122000001)(508600001)(31686004)(6486002)(36756003)(38070700005)(53546011)(66446008)(8936002)(8676002)(4326008)(71200400001)(66556008)(54906003)(6512007)(186003)(86362001)(76116006)(64756008)(91956017)(26005)(316002)(6506007)(66476007)(66946007)(5660300002)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmdyN1NURE1xdkJmMms5Sm51VGlOOXZHOS9mNmNIWUZwZWRJTk9ZNzlPNXBk?=
 =?utf-8?B?ZllpOE9DK1laS3hLL1VMVGVvUktiemxJTHAxZG13ZndFQlVVeXYxQWJCU3Js?=
 =?utf-8?B?TzNPR2tRMmliMEdndi9OenlKR2YvZWxtNXJ2cENEN05GamJ3VzZsUjg0U2xl?=
 =?utf-8?B?YndLTFBFMmtDdURzYk5JbTJKc0xOOVBieTZ4WW8rc25UOS95bkRDQjVmdlIz?=
 =?utf-8?B?ZHE3VUdMQURHMEtJZXpVazBDNGJGMjVDSXVXek52eVNhNXR0MU9Nd1FCajJw?=
 =?utf-8?B?OWczTmZyRG9YZlV5dWVEQis4QmMxRThwTTlCZ203c2JHa0tOT0greXVpUk9l?=
 =?utf-8?B?NFBGNStVTXQ1T3VhVU81NXo5N21NNjFoVFZHaWRVaHBFd3dxRHc5dzJDL09Q?=
 =?utf-8?B?b0ZlQVQ0aXQ0OVZINXZIUkRhOVRBQ0dNOXBXN25oMk5xZXEwY0ltamtJdGRP?=
 =?utf-8?B?UzQxYUIydnRtaEVQNG9lNVVzeEN3eURmUHVoY3lHa0NlKzVSRVF1aHlWYTU2?=
 =?utf-8?B?eWFKcXFqQjNWdnFWdjlwSmFYVlBIVUo0VVppYkh6OE9SUGwrdGx0MzBHRWVr?=
 =?utf-8?B?YjJ1Sk8wbUV2a0gzMlN4eU84T1EvMllTbzhWaEJoM2NBTE05eHp2NWZMbFo0?=
 =?utf-8?B?ZmwrQmpSTlZFdXdCMlVRaDArbUsrVVZJaHhnNm1SNnNEakdMVXVzNnV5WTF0?=
 =?utf-8?B?L2QyY1drQUZpeWtScm9WNDR4VDVLRUNRSEFhRk1oTTV4cGw0QjRZK1F3dXFw?=
 =?utf-8?B?V0hTZEg3OWpLMUJKS0R2NnVEK1Y4ZDBQalkxRm42U0grdi9xMUpoRUtxN2ov?=
 =?utf-8?B?c3JFUFp1MTZyS2hEZkZpamU1S0c5WlRSbExKenFrOURGWitIOUV2R2JoMGx4?=
 =?utf-8?B?NHRWcEx3RE1QZkRHbVZYa1Bqd3Z2bHBKTEY0aXVFUklmUnVGOXJqUytNNkw4?=
 =?utf-8?B?c1NUYlBGMUVHZFRnb3RyYkV5TTZsOW82T2xzTEJHY3htUUYzc0RVMmE4cnpk?=
 =?utf-8?B?MUl1VG9OKzhJdTJFRi9JZW1vVzZtVDl2OVJDMTlqWVF3TndTQUxEdFg4S0wv?=
 =?utf-8?B?bnp1dXJUQjJVZlM1VGRwaU5tdUl0UnUzVGpUaTFmWWc4emgrMlFEblBORnlL?=
 =?utf-8?B?NDJ2VWp1NXJZQWNKTXRkY2YrQVFvZDVNZlVxVUcwbTM1Nmd1YXcybkFNOFdn?=
 =?utf-8?B?enNjTlBEUWxsR1drbUQ1NFNBdXNtTVh5SEdnVFFzUDJwWUVtSmUxSWtRYkhz?=
 =?utf-8?B?eXNYOWVJRjJWNk95Q3p6Znp3Qy9DOWxtUmtaZ0Zscmx3aXYwWlFhVnZqclZV?=
 =?utf-8?B?RmRUSTFwcjdmWUU1RVo0MTU5YUk0ZUppUklvQ0xxZUcyeVZDKy83YjdmUmRS?=
 =?utf-8?B?M3F4d3ZVais1RHp3S3hKWDFkakJkZjNyYk03WXlNa1NTaE9OTWhyUXhsZ1lQ?=
 =?utf-8?B?ZlNWb2R0dW5pM1A5QjRVVkxTdWdQWG1XZjgyRFJyYks1cUhXOHd4ZEs3TjAr?=
 =?utf-8?B?VFBXRkhJM013WDhHQ1R5YzdhN0x3RWJQUEdSeU5MOThzT3dOay9OVTI5V1V5?=
 =?utf-8?B?NGFJdzYxWXRZc3FKRkczZ1hpUC9MNDVGMTRrQm9UVkpCa1laUlIvaWZmZWYv?=
 =?utf-8?B?RGpEcHR1L1FyWHdZeTdZVk15WDRKR2RuVFA2WGpXUDRWajgrRHJuOGt1N01i?=
 =?utf-8?B?WFVTeUU0WUVWU2k1aTlDUktEUU84bUJsNUJSeDlJVGpnYlVTcUZRMk90bFNt?=
 =?utf-8?B?U1ZJR3JNVFl5V3hLMVZuT2ZpaDcvYzVkN01mUDl6VDV6dm9DQXRpU3p3RUVD?=
 =?utf-8?B?eGlsYzVWZ1NTNGdqMWtrYkQ4R0srZUF0R29lL1Z2bUJsalhIWSthQk9wYnlJ?=
 =?utf-8?B?eGhmVGJyVkp5ZHZpdlJhK0FwRWROZlY4RmdVUFhoNFJQSFlwWHJmc1NrUkdF?=
 =?utf-8?B?dkgwMkdheGlYdzZKMytyejFLRG1xOThycUdTdG9rZFpVOS96d2kzRk5YWkVH?=
 =?utf-8?B?YzdEdDU0amQySFlJV0NvMlk1ZWdWbHNHWXIwU3UwK2hBMU5WZzN5RWJPbU0w?=
 =?utf-8?B?N3RXdUVMRXJIdmMxUitsRkVsNGJRZnd2anpiSzJWbForNU1JS3ZQU0pYNzFN?=
 =?utf-8?B?cVhHS2ROeWRFWHVRT2xQbHdHbDc0c2g1WGhUUFdveDhPd0x0NSs4bnN1MlZF?=
 =?utf-8?Q?yC/aAVy5XlaA8XFQ/ka4LJI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B48BA247C7B844DA670FDC5D63738DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eb6ce5-2b2b-46c0-afbf-08d9e2403953
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2022 09:26:11.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6Lq5YFtPWM0QAiIwyiY6dM42EgnRe8qlUdpIh5UC+c2bLDNTxCB5RddPx07yaigg8lxHx3+yP9rm5cruyrjEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2547
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMS8yNy8yMiA0OjI1IFBNLCBMb2dhbiBHdW50aG9ycGUgd3JvdGU6DQo+IEV4dGVybmFsIGVt
YWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4g
RnJvbTogUmFscGggQ2FtcGJlbGwgPHJjYW1wYmVsbEBudmlkaWEuY29tPg0KPiANCj4gVGhlcmUg
YXJlIHNldmVyYWwgcGxhY2VzIHdoZXJlIFpPTkVfREVWSUNFIHN0cnVjdCBwYWdlcyBhc3N1bWUg
YSByZWZlcmVuY2UNCj4gY291bnQgPT0gMSBtZWFucyB0aGUgcGFnZSBpcyBpZGxlIGFuZCBmcmVl
LiBJbnN0ZWFkIG9mIG9wZW4gY29kaW5nIHRoaXMsDQo+IGFkZCBhIGhlbHBlciBmdW5jdGlvbiB0
byBoaWRlIHRoaXMgZGV0YWlsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFscGggQ2FtcGJlbGwg
PHJjYW1wYmVsbEBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IFNpZXJyYSA8YWxl
eC5zaWVycmFAYW1kLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hA
bHN0LmRlPg0KPiBBY2tlZC1ieTogVGhlb2RvcmUgVHMnbyA8dHl0c29AbWl0LmVkdT4NCj4gQWNr
ZWQtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+DQo+IC0tLQ0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0K
