Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F215A41D28F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 06:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239357AbhI3E7Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 00:59:25 -0400
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:65504
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230413AbhI3E7Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 00:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igos/tC54CqudHvXn980kVwKbZwKq5K+RoogtG8Fxwwt7C1hqcvHDAo/aAzBdNu54XCvEMhj2ejhBtdv0INqQ4iwvDJvE9smI1LHlE5xNAK/lyV+K2uxE2dWqxX1sw+13oqy4DnUYxkNDLrVpW4IXfDMGmv5flZzqIVnZ1saVUBLbBo/+pH3HD1C9Hz40Y2gDd+LpvyCePuqt9tvLG7b18OrLp5iGPhX7XSMHrV2Xwj107k052CtAzLqEw2VmjjvoZF05fr7PGjWvm62mbICynu8ofsNWhNz2GfDz0J6Ee9hUgF32uNreSDDjGjnT0TCouIOZUpCvhfZGoLP6+pJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=O8hgmQdOWfIbikNPK4C5DdhYL5vMyjRbyGFzp0kKHdc=;
 b=iNJ8kfVn+ABC1iDOBWVHAY/l79Fw/x5Y+znaTuIrGugkF4zA8FxdMUOrHQTL8kOA+Eh/Q5iO2XMQRzLUSONSuCOCqoeyDnrOlI9pAxEVYNkdfH93HjUCz63+BMP5I4mE9byv1xWkRNpz6OsZZtOcW2yV6lJ+qM6jzwF8MmmJUvtKdn+KxP4hdWXsrYb2WCx7DQ+XGlMZytlHBWDOk257OZYfdA7mbv0DxSjjGvdiUgNmZ/TRa4ECCWCOtOMXjVQkHlRukFenwE1ky+vXg3Pe5kydg331htCrKry4wStJkxVo7R3lcVsE+Rrm1uHu30uWUZZU8nJAthByRFyz/sw5xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8hgmQdOWfIbikNPK4C5DdhYL5vMyjRbyGFzp0kKHdc=;
 b=WhTq0T8VAxsqk7/tcnYd++aGaBCIQRmUAtxM8BKAjy/k6KVsE4nZd9GHB8bWCLhc6MA8BPRWmaSKDPemdC105/DpT/vL0kDkG9KXZhFw3elf+9sXwQMriYYd0xcXI2UkR3/HgvZzjRNVoPU5J66Bpc5K6eyGdJZwh+WfZ1Ez4AkSvMZmMlCKRLJFjf1ftKJWgEHhbepGS+mhWD6YDQEHAQqRpljrtzqKm1pm75UnxQBtOVBtIpvtmb2fBRf5rhgr0HlbBBiWeUDo/tCG4H+lFw4lRPU95woA2Mdg2lg5FYBpk9jy/zwdRnrKA+nlFueMfRxLpuvXMTZwDj0/rs1X6w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Thu, 30 Sep
 2021 04:57:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 04:57:40 +0000
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
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Topic: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
Thread-Index: AQHXq1RaC0AUk7ABDUmYF9Nk+3cp+Ku8GLqA
Date:   Thu, 30 Sep 2021 04:57:39 +0000
Message-ID: <7c168a79-67c5-15d2-e95a-97ce0d4b5e6c@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
In-Reply-To: <20210916234100.122368-2-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d97a4090-df2a-48a8-e9fc-08d983ced47c
x-ms-traffictypediagnostic: MWHPR12MB1469:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1469509A75EF39962A6E1DBCA3AA9@MWHPR12MB1469.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vyZLaZ5Q3GmK6HTTTu2BuLhBESHVydBWc1nqr8uvS46s/xipW7CbSzGD2sDQkSUEdxIENOOdrn5efFvO9a7ew9E+wCsK2ix4svPBHsePNmLNppK88Yzckxwzxddz1QLv4gFYCNej79OtJ/F3KCxnnhxrbPIu67Kbfw6BSTBRuQfqmR28BJVB/J9B8WA+l/T9fq4FVlJaCh36qBsTJx+V7Eb7kGlXVn8L8RrZYP768EE3qqSgtNhNWniHV7Zr0SLEane6M15J5R97zOLbWX/tebeiOcydwGLB+XaZB5QcyNDXUsh7dxb8GmJAwzV+xjUW0nCr2gIH+3LNjnxN/HuEMMdP9XyhLPDbSvyfWTDNPVbu2E4WZV4BnCDb2mByxa6dz1bf7e4vRDiTqY/CjzYQ+D4FephHjfGQKZSa6ZymyMI9UGFK5yye9CfrDmLOSLnKOq3nsdFiWnERfewfRg4ovymoR9Jbl3WdPKf1cPRXwMmE3SH8Bj0bmhPxRPfduPCsSoop2iu197Bu1maQ6OtIH7d2lhgMeCeoLwhkxNE0hqk+UijLr5EJZbesiLLzFLeobYcJXf5DC6AqpFBX7Ohg6pGqgIU5SzhdU+a/M5BWNdIqKu585BT1mOtwL1/97z1fwfzerybJZDKGMRs8xM7Zk0g4pT+hXbYq8OBqYcvSZjD0SbNudQT1SplJfx/n03CCWPLAhykXEvRzEzM5ix33IekJaXQwHW231QaxF2OwKXIiVnFTR6ysWYYJhuDRmR+mLCo2iCT57Kx12jKkQNjqOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(4326008)(38070700005)(2616005)(31686004)(4744005)(186003)(6486002)(122000001)(86362001)(36756003)(7416002)(26005)(71200400001)(38100700002)(316002)(508600001)(2906002)(8936002)(5660300002)(54906003)(110136005)(31696002)(6512007)(8676002)(66556008)(64756008)(66476007)(66946007)(76116006)(66446008)(91956017)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXlMTkhaL04ySFhpVGd4UU5nZjNveEpjMGQvVDQ5MCt1VGRUeXJkVUJpUm8r?=
 =?utf-8?B?SjlKMmZ1TmRtMDN3M3E2VU95MXFNSUNJdDZvVTJ5NmhCMTluWTljNGwxZFdx?=
 =?utf-8?B?Z3dFVlhlTE51ZjVlcFh1R0VyeE40SjhnOWF4ZFVSbzZEV1kvK0ErOXBMdXFN?=
 =?utf-8?B?N1U5bFZ0ZTA0K3ZDMmtjUkdVcXAvaHBVWmZFUG1QSzYraThtZnF6bkQyU1pt?=
 =?utf-8?B?MTBod2xSTUZ3cm0zbXp4bmd1Q2JpZDE0VGl2RENwRDV0YW5GQTZ6LzNIM1VI?=
 =?utf-8?B?S2YyczFKNUlTZHlTYVlySTE5WVJpTW1ZcHBRWlBRcmUwZ1AwSzNyQ2R2Q2h2?=
 =?utf-8?B?aTVvRk16dEs2cU55cURpYVhhMVordTViRkExVGhGNkpmWlNONG01cW5ySWFE?=
 =?utf-8?B?UXZabDhCbXE5RzRFYmpFb21XUzYrS2ZGSXBqWWFUeTF2b1U5VUZhSEk1VlNT?=
 =?utf-8?B?YzBlR2pMYlBpVGFoaVZaa0hhYzdKUlFwcVdSNktjUjBPczVvVlIzcS80Sy95?=
 =?utf-8?B?MnZmWGIyZ25nOEhsbXdVUmg4Y041enlGUEowVFhlNGVBYVFmL0ZscWUzWW9z?=
 =?utf-8?B?UjVrRG9ORk9sZFFNdVRCVDVXZEU0OWNoMzVCZzlSMWE1MmQ4enpUVEF5ZDg5?=
 =?utf-8?B?MHdLNmVRYlZGVlZJdjBBaGZKRUgzMmlTSTFOVVlGWFNxQmtOVXoxRnJvcjBN?=
 =?utf-8?B?SmowbE04ekkwZjhlWWJ2aWF6WHVTeGZndlBVVExKRW9lZlJBSmtjeXRGeCtM?=
 =?utf-8?B?bklwcW80L0xZRElpaXJBWXBjdTlkMDV4S0tLa05KT0xyTjNLeWg1V2doYjRn?=
 =?utf-8?B?VFpPVy9qTlN2SkU3SEF3MGxLcW1jdm0yc2RaYlAyZm5XR0grb0QyT1BsMXds?=
 =?utf-8?B?bElBNytCNFVVYXRtMGZZN0tVbDVFMUJIb1V4UXViaDVjZ0R0TkZwTlFqUzNP?=
 =?utf-8?B?bUM4eUZIaUs2ZUdPck9TKys0UUViTi9pSFJmMGs3S0RGZ3A1WGo2cGU3eGRD?=
 =?utf-8?B?OFk0eDNIQXkyWFI3WXh3SUNqOHN0elJqYWQyMjJiZVczUU1rTVJsekl6OHZy?=
 =?utf-8?B?ZlNpUUU3Nk5zU1lhQzY4OWl6dUhjRzUvQXVGSmF2aVU0eEtyamxNbGtydmxr?=
 =?utf-8?B?RkJOQTNPb0d6NFFONFlLWHFkekVXMDZ6VVdtVVlhTmtGSzk0VCs0RTl6a0s5?=
 =?utf-8?B?WjVGNE1tZy8wemM2WXV0QjZzbitrdG5sSkdEdzYvQnZWbEJUZ2ZzYzRJT053?=
 =?utf-8?B?UXBvajduckx2ZXJ6N0FQb1RvK2x3dWtXaTRVdm10ZFBWTDVKcUtpVXZrd1FV?=
 =?utf-8?B?aVpUaWVNQ2Uwb2VZNjVUSlpNSlZJMVBPdzBFYm1CdUpWSmNuUDI5RnU5OUZu?=
 =?utf-8?B?bmFVdmt6M091Y0taQXFQa1B2N0pWVXYwQUtCVGFjK1VhRitZYVdjOW1WdDhl?=
 =?utf-8?B?c2NEMEFMZmx5RVR4bkkvak96c01SMUFVNEtsVjBYV3VOSmp6THFEaHRQSlg0?=
 =?utf-8?B?bkVBU1NKVGxIaStvSmJsSEl0dGdFRm1LV2NvRVp6NURnMEx6RWRqQmFOMnJx?=
 =?utf-8?B?N2JxUlVQNkNXcVh4SngxTGdISk9SYlV1amt6aEdaalFPcWFjcGhMcnJmVTFT?=
 =?utf-8?B?VlJKd1AwUUxCS2VZZXpjZ0lEdE5rVVBhNDR2WWV5RVU0RnJaYlRvS2xQVE54?=
 =?utf-8?B?Z2NIMVAwK2RxVThvUXZOS05uZEhLUkcwL1JPNExJNTY5V2FqK25mRFk2Wnlj?=
 =?utf-8?Q?2LWDXlcpeX6UxkPtS0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC2EA3CE3A26AA4490D69D7C686AD838@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97a4090-df2a-48a8-e9fc-08d983ced47c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 04:57:39.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXEU6uN5x9Jmx3oSrHhpDhSuJcUyqjYNckmAO3IO+jVTYXITI4Xqg8Vcn0kbPTSPX3iMrsRQAFanVHbDgfS3rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiArLyoqDQo+ICsgKiBzZ191bm1hcmtfcGNpX3AycGRtYSAtIFVubWFyayB0aGUgc2NhdHRlcmxp
c3QgZW50cnkgZm9yIFBDSSBwMnBkbWENCj4gKyAqIEBzZzogICAgICAgICAgICAgICAgIFNHIGVu
dHJ5U2NhdHRlcmxpc3QNCj4gKyAqDQo+ICsgKiBEZXNjcmlwdGlvbjoNCj4gKyAqICAgQ2xlYXJz
IHRoZSBQQ0kgUDJQRE1BIG1hcmsNCj4gKyAqKi8NCm5pdDotIFByb2JhYmx5IHdhbnQgdG8gYWRk
ICcuJyBhYm92ZS4NCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBzZ19kbWFfdW5tYXJrX3BjaV9wMnBk
bWEoc3RydWN0IHNjYXR0ZXJsaXN0ICpzZykNCj4gK3sNCj4gKyAgICAgICBzZy0+cGFnZV9saW5r
ICY9IH5TR19ETUFfUENJX1AyUERNQTsNCj4gK30NCj4gKw0KPiAgIC8qKg0KPiAgICAqIHNnX3Bo
eXMgLSBSZXR1cm4gcGh5c2ljYWwgYWRkcmVzcyBvZiBhbiBzZyBlbnRyeQ0KPiAgICAqIEBzZzog
ICAgICAgICAgICAgU0cgZW50cnkNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQplaXRoZXIgd2F5cyB3
aXRoIG9yIHdpdGhvdXQgc3BsaXQsIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQo=
