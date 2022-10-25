Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C68160C153
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiJYBqU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiJYBqC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:46:02 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34735220C8;
        Mon, 24 Oct 2022 18:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANwwGnPYc41u63tgYuuKfawNwqQGMCDUtEdKzz2DpOFUXscE5Fapp+lzcfvEq54l7aOw/VIrDTKDtoIm98nzwf7RsBa0dtNz1UyHTpgZptz4wgN+4egI7ZJv8D7RcqlNjsXHfYNcOAsaqyVu9mWHd7gvO3qKXrhmcaeKSR/8x3W5VUX3uhpSmhRddrFd6as46am7z9ORgGHqODU4mPeQkF7VUBxL0xlcBQQcmbgH2e9m4Us9K3zXoAqIlg1Qugv1Eu8AB3w6wqixWwgBtcel650+miXX+47+0y4TYMWDKf2ZjLKu4+c3tZv5VdWh06L80j+Z1Sk+O0805klSy2yD4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOQQY7nmHimdCSRMvWga3do3yJsAacIpvW9fGKD7LmI=;
 b=Ropl7rOXc0fW+imCbzUTI+t/S+01CBwhKvZCN4fm2Dlcr614ipTB+UqDP26cdna/hwmOkF3bHPHR/KeReSZ/UyMddc+1RMossknj8yybOCVlchcauR1weZgUUXGJR8Ajp2/C5iL0C0l3q0imwR32h6Pjo4+Osdsoi9n7to98recF7oe8MS4otZ9vHJgzbcMRbpHi3Jlr1ZR7kzIl7qInnguGeUcxRwnyksWm9BQvScaXuAMtwqtvtm2ekN2LTvgkNl/qowy0H7l5X36+ksXgDVsAuUb553ExDrGe1TN/0WScPMlEdzQCnImPI0TtK7q4AoFXfwcCbycgFvGCe+cUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOQQY7nmHimdCSRMvWga3do3yJsAacIpvW9fGKD7LmI=;
 b=mYVSGJlAkMhMnebDI79xfm/IHzfrrVOPANQnKU3JKw6s/qUtMFEvJraEu2ceUURiaqZKVHH1C4oxoPM0fPgdcSQ1boIWBX8eehgBUNXB6Cn+dv+boZwzfE6kDdYQszWiWIrBUIiPQFm4X49zdsBWVhb02eKaHhtzi54cPGaKVyDeMzNMDuL/DIWsF6yuQirn7G2P2/sluzjBY4c9tT5kko7SclOwOk1GlCI4HQIfNN1UPByceNbrbHRH7l/aIIpCWJdPXW0tE1m5jBdxsVBHUqJI1B3GhnC3UfaVgvTG9TfdQy15Yzr18R1GNpqpR38MdwreYZP/p/IzdQFr3eItWg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 01:34:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:34:16 +0000
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
Thread-Index: AQHY5XRhmtIfJYcZP0KNtjagxXHMP64eWN+A
Date:   Tue, 25 Oct 2022 01:34:15 +0000
Message-ID: <b94f0533-7009-5415-4ed4-f7443fbf7a2f@nvidia.com>
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
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SJ0PR12MB6925:EE_
x-ms-office365-filtering-correlation-id: 2c77998f-779f-452e-912c-08dab629075a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Z7ndZBGBovwnRmtH4htFcTmDReMzkoD4ABgP0iyHrM455VMRz6VcBPITe+0iQ7VovQsfHx3gQC6dT4rbWKtLfUF63mTaxSGtv8xzJJaKCUzkzgedFO3PufKFu0Q8ATkmbQPm4XrTx/gqUhvrDKOq+NlufrlQ/spIGYIn2PPM3fq8Wmjc0aM9MBvoJk2fYp6ldBZk4KGpugKnhl0mle+7GE5H9lX9GC6bO8k4u4iO4+XAdI9BIA0pdxEUOm+pKseJv7sOFdUIN0KMmEnVonDe3aVIz7DaDVsPznO6arCtdKzrvpUZ/16uBFMox0aUlhNqpYZ4AgvChOubyA7So8S7Nnf0pdhLA0gBg7MiWVycrIMD0Q2ZbN01iXeahwtidPPWkIOdCDYoxHvHZzv+k7O75HTKTQ0eNAxEBUGno6SXe7u4N4t6PEM+5xBKcXQjtTOzy7uhqCLzTFqO5GNgmmgxCijahS3qlO/KAQqyIIYNHo9QNK/NgCSVENRcrpGSneoCa4C7/QYgKmB3g0rualN/rJbbeqpHF6Apu80LjrMbtda8viD+LAxwqklJl33emTBy0KYGkAc3lAv0FmtcPGCha0uLF115pIO4KV6X5iJTpKCXHEGMcsOmhcPt9rRbUHra0QyIXM6EZ9mQ0wpTFj1WqIhBdKX8xj65WWljVcGJGEnUpwTSB1nRt3iYQiX0RzksSkXgvdC87uFpnRY/9wdUsezFa35jWCoB/WdSvpl4Yol8gc5Ob0rHVTsGlsZo+BmDCCMSvo+NpT4W08dLbjIv7LUAY++Uh0W39PrFzmU5NSr/BSGAa9kIiPYCr1SK25D+UkPOE0NtNxs/u6otsyWUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(316002)(86362001)(38100700002)(31686004)(6486002)(71200400001)(110136005)(54906003)(66446008)(66556008)(83380400001)(2616005)(2906002)(91956017)(66476007)(66946007)(53546011)(6506007)(76116006)(4326008)(8676002)(64756008)(186003)(122000001)(7416002)(5660300002)(8936002)(478600001)(31696002)(38070700005)(36756003)(41300700001)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkczY0h0QnR1cXFsRFMzY2ZLbGM4UURBdmZJallxVTkySVZlOTNoRWRyM21r?=
 =?utf-8?B?T1ppNFgrOVVpdjJ4SmxJRGpNR2pTUjVzRTlnRExOTjdJOUFwa25TRVJDNzFH?=
 =?utf-8?B?YWFhYWs2NmMxNWdYWnhwa2lmczBxVUxBZlNsbUhNQ003MFhLRHhhc3poeEh5?=
 =?utf-8?B?azZkeGNhbllUZWVSQWcwNTdMbXZxZnM1YzdVcWo0RjA4YzYwUStqMHNablBv?=
 =?utf-8?B?K1prOXJNTXJEK0QzVUpvWFdYY1RMcTlxYTU2WWhpVHhwUUtqYllKTEkyY0dM?=
 =?utf-8?B?aUU1NEtGWDBQQng0RU5GbEhjMzd4QVdETVVJWWZYMURDNnlZbnU0N3V0dUlq?=
 =?utf-8?B?RzF4TXJuazU2azh2anlXZEw4Y1JuYmFaZVNxVWtJenlrUVZYR09BNHg3Nnhq?=
 =?utf-8?B?U01MOTFKN2hOamtnUTlPVkhrNHR0RmNLbDdtVXhsVXFpSG9FSlFJN2p2b0c2?=
 =?utf-8?B?TUppMTFHbmZaWUI2ZWNjckdZWEZEM3lXZlpEWWNwbC9zUW9UUWVTZVRiaXI5?=
 =?utf-8?B?c2ttVERwVkwvVktKd0tISlVxSmJxTyttMklhME1GSXZxZlhZeW5zbTJ6dVlU?=
 =?utf-8?B?M3phd0VsZWliNVllMWN4U0U1NEZYS3QxM3pyWWtId0pCb0MyZ09xdkhxV0tw?=
 =?utf-8?B?dHppYTZpYVBPUnkyYWRKSnhYM3ZvRWNFdHNFMGhKNHRwWmlQQmlZdE5BeGZN?=
 =?utf-8?B?ZjVIOEdvdU9TQjZOVUlTcDRCejMwMVJRQ0JpdW8xSkNxZTFFUmZDdC9Eekd6?=
 =?utf-8?B?aVBvVUxpSFBSQVIvSzNSVHUwS2dmTG40TkNNSjViWEt4L1NDTmNNOGg1SXZK?=
 =?utf-8?B?MXhBdmtyNUI2T2NKeDFpUFRkcW50eHYrdHYwMjRUaThRNTg2cTlsUSsxTnJr?=
 =?utf-8?B?U2RZL1BrR2NOaWVyajJ0ZHFDcFowMUk3TkpRRzB0OWM1SmxpS0RzeVZHeEJr?=
 =?utf-8?B?TXA3SS9FNGUrVHYwcFV5U3Q2Q0FISnM1T1ppSkNiaXpudDc3ZVRYQm5TcE0z?=
 =?utf-8?B?dzdDZUkyNnRjSEIyQlNHOTBjYWN5QzFPbGU3RnVGSjVnb0t6bzBWMktxMTRY?=
 =?utf-8?B?TFBGcFpOdmU5Y2pLcUd2azZKTlB2L3VFUG5YbWhpZDhQaVgxdDdkb1crcGo3?=
 =?utf-8?B?ZlVFbDdBN1hRVS91bmpqTkJZR1F4WEZ6NnAvdklKNWEzbkR4Z3ZkelorVGd1?=
 =?utf-8?B?K1BwUm1ETXFCNEN3Zit5Z08rb1Y3SGxIWnkrNjY1Q2p5WUptV0pEUTJ2NVJk?=
 =?utf-8?B?aUNmRFBlR0k5NVRiK3FSaUpmSHNoeHZ0OEFDZ1FBb0VNUVhhSjBPQnhPZkNJ?=
 =?utf-8?B?dVE4VDRwcEdCVDBQdVJra0ZLZi8xbjBDRndVaFZBbzJISFMzUDVicCtFaVlK?=
 =?utf-8?B?SHJ2QUtUajAwKzNPMlUxbGlnN0I2dGlKNFFxaVAwdnJQWmo4azBPUzJDWTh5?=
 =?utf-8?B?bGpxNWhlZDVoeER6eW5KV0dvZ281Q0JVbVNyUjhEVkl5MEtzNzhVNjZycnNk?=
 =?utf-8?B?RTBBNkt2ek1aUWZ6MDFBN21oUnB5bVp4aXo0MWZkaGlBNE1qVDZCTjVNc1p5?=
 =?utf-8?B?UExZeXlKNWNGYVljbmVnM1VUOHNtb3Y3aU0yOVNSV3F2cit4S3BhQmNxS0U1?=
 =?utf-8?B?K2pReDNFWkZianVDdlVlR25LOEI4WHl5bzBMaTFIQ2x0amQ1WjA3Mm8vK21F?=
 =?utf-8?B?ZU45QmxLSEZ0cm4rSHdDSk9VY3IwR1IrTWVNOXpoZVdzV3lHclk0dUZwNys3?=
 =?utf-8?B?bUdkZVZLS3FEb28wZHpKTEhnQUNYSXk0SHNXSll3Rk1HV0ptUkc0eWhhdUcz?=
 =?utf-8?B?UHBrLzg2d3pmNHl5aWtIdjlXbVo2ekZGb01MTi9uQWcraHZHMDA5emFLS3Mv?=
 =?utf-8?B?bURvMlVjOFBoNUw3S1FYK2lVVDJmV3lrTkErWERKbHRiSXhHUGswaVg2OXcv?=
 =?utf-8?B?TFUrTFo4cUo2aXMrTzBaOWNnK2JIejFHdWNnZ0tGYzFFcng2ZmdTZm9BdHlS?=
 =?utf-8?B?T3c3aXJaZk9nY0Z4VEJwNXZMRC93cFhHeXJQWVhCa0ZQTU1YdzlBUVpwbFlx?=
 =?utf-8?B?M0N3K1JlUCtSdjdFRHBwdnhiaWtDZVBmZ0wyY0tiVDBQTitLb2lFUzR5OVYr?=
 =?utf-8?B?cmJUY0hFYUJPbUx1Yi9xQ25GdUZjeFZJM01tZ2NFNkNOOGVvMGN4MFphTW1X?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EDB08C4BF71814D9C26786C1CD14830@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c77998f-779f-452e-912c-08dab629075a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:34:15.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIS8br+ZDcOOvanTVV4cEF0Sf0Bd20eA7mnXkEXrYi6vnQReUlEN2DjNXyuTP+7+EaLDcLYra4qpIO2/BaBsyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
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
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9w
Y2kvcDJwZG1hLmMgfCAxMjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMjQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL3AycGRtYS5jIGIvZHJpdmVycy9wY2kvcDJwZG1hLmMNCj4gaW5k
ZXggODhkYzY2ZWUxYzQ2Li4yNzUzOTc3MGE2MTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNp
L3AycGRtYS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jDQo+IEBAIC04OSw2ICs4OSw5
MCBAQCBzdGF0aWMgc3NpemVfdCBwdWJsaXNoZWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0
cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLA0KPiAgIH0NCj4gICBzdGF0aWMgREVWSUNFX0FU
VFJfUk8ocHVibGlzaGVkKTsNCj4gICANCj4gK3N0YXRpYyBpbnQgcDJwbWVtX2FsbG9jX21tYXAo
c3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCBrb2JqZWN0ICprb2JqLA0KPiArCQlzdHJ1Y3QgYmlu
X2F0dHJpYnV0ZSAqYXR0ciwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpDQo+ICt7DQo+ICsJ
c3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2KGtvYmpfdG9fZGV2KGtvYmopKTsNCj4g
KwlzaXplX3QgbGVuID0gdm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0YXJ0Ow0KPiArCXN0cnVjdCBw
Y2lfcDJwZG1hICpwMnBkbWE7DQo+ICsJc3RydWN0IHBlcmNwdV9yZWYgKnJlZjsNCj4gKwl1bnNp
Z25lZCBsb25nIHZhZGRyOw0KPiArCXZvaWQgKmthZGRyOw0KPiArCWludCByZXQ7DQo+ICsNCj4g
KwkvKiBwcmV2ZW50IHByaXZhdGUgbWFwcGluZ3MgZnJvbSBiZWluZyBlc3RhYmxpc2hlZCAqLw0K
PiArCWlmICgodm1hLT52bV9mbGFncyAmIFZNX01BWVNIQVJFKSAhPSBWTV9NQVlTSEFSRSkgew0K
PiArCQlwY2lfaW5mb19yYXRlbGltaXRlZChwZGV2LA0KPiArCQkJCSAgICAgIiVzOiBmYWlsLCBh
dHRlbXB0ZWQgcHJpdmF0ZSBtYXBwaW5nXG4iLA0KPiArCQkJCSAgICAgY3VycmVudC0+Y29tbSk7
DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiArCWlmICh2bWEtPnZtX3Bnb2Zm
KSB7DQo+ICsJCXBjaV9pbmZvX3JhdGVsaW1pdGVkKHBkZXYsDQo+ICsJCQkJICAgICAiJXM6IGZh
aWwsIGF0dGVtcHRlZCBtYXBwaW5nIHdpdGggbm9uLXplcm8gb2Zmc2V0XG4iLA0KPiArCQkJCSAg
ICAgY3VycmVudC0+Y29tbSk7DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArCX0NCj4gKw0KPiAr
CXJjdV9yZWFkX2xvY2soKTsNCj4gKwlwMnBkbWEgPSByY3VfZGVyZWZlcmVuY2UocGRldi0+cDJw
ZG1hKTsNCj4gKwlpZiAoIXAycGRtYSkgew0KPiArCQlyZXQgPSAtRU5PREVWOw0KPiArCQlnb3Rv
IG91dDsNCj4gKwl9DQo+ICsNCj4gKwlrYWRkciA9ICh2b2lkICopZ2VuX3Bvb2xfYWxsb2Nfb3du
ZXIocDJwZG1hLT5wb29sLCBsZW4sICh2b2lkICoqKSZyZWYpOw0KPiArCWlmICgha2FkZHIpIHsN
Cj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gKwkJZ290byBvdXQ7DQo+ICsJfQ0KPiArDQo+ICsJLyoN
Cj4gKwkgKiB2bV9pbnNlcnRfcGFnZSgpIGNhbiBzbGVlcCwgc28gYSByZWZlcmVuY2UgaXMgdGFr
ZW4gdG8gbWFwcGluZw0KPiArCSAqIHN1Y2ggdGhhdCByY3VfcmVhZF91bmxvY2soKSBjYW4gYmUg
ZG9uZSBiZWZvcmUgaW5zZXJ0aW5nIHRoZQ0KPiArCSAqIHBhZ2VzDQo+ICsJICovDQo+ICsJaWYg
KHVubGlrZWx5KCFwZXJjcHVfcmVmX3RyeWdldF9saXZlX3JjdShyZWYpKSkgew0KPiArCQlyZXQg
PSAtRU5PREVWOw0KPiArCQlnb3RvIG91dF9mcmVlX21lbTsNCj4gKwl9DQo+ICsJcmN1X3JlYWRf
dW5sb2NrKCk7DQo+ICsNCj4gKwlmb3IgKHZhZGRyID0gdm1hLT52bV9zdGFydDsgdmFkZHIgPCB2
bWEtPnZtX2VuZDsgdmFkZHIgKz0gUEFHRV9TSVpFKSB7DQo+ICsJCXJldCA9IHZtX2luc2VydF9w
YWdlKHZtYSwgdmFkZHIsIHZpcnRfdG9fcGFnZShrYWRkcikpOw0KPiArCQlpZiAocmV0KSB7DQo+
ICsJCQlnZW5fcG9vbF9mcmVlKHAycGRtYS0+cG9vbCwgKHVpbnRwdHJfdClrYWRkciwgbGVuKTsN
Cj4gKwkJCXJldHVybiByZXQ7DQo+ICsJCX0NCj4gKwkJcGVyY3B1X3JlZl9nZXQocmVmKTsNCj4g
KwkJcHV0X3BhZ2UodmlydF90b19wYWdlKGthZGRyKSk7DQo+ICsJCWthZGRyICs9IFBBR0VfU0la
RTsNCj4gKwkJbGVuIC09IFBBR0VfU0laRTsNCj4gKwl9DQo+ICsNCj4gKwlwZXJjcHVfcmVmX3B1
dChyZWYpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICtvdXRfZnJlZV9tZW06DQo+ICsJZ2VuX3Bv
b2xfZnJlZShwMnBkbWEtPnBvb2wsICh1aW50cHRyX3Qpa2FkZHIsIGxlbik7DQo+ICtvdXQ6DQo+
ICsJcmN1X3JlYWRfdW5sb2NrKCk7DQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiArc3Rh
dGljIHN0cnVjdCBiaW5fYXR0cmlidXRlIHAycG1lbV9hbGxvY19hdHRyID0gew0KPiArCS5hdHRy
ID0geyAubmFtZSA9ICJhbGxvY2F0ZSIsIC5tb2RlID0gMDY2MCB9LA0KPiArCS5tbWFwID0gcDJw
bWVtX2FsbG9jX21tYXAsDQo+ICsJLyoNCj4gKwkgKiBTb21lIHBsYWNlcyB3aGVyZSB3ZSB3YW50
IHRvIGNhbGwgbW1hcCAoaWUuIHB5dGhvbikgd2lsbCBjaGVjaw0KPiArCSAqIHRoYXQgdGhlIGZp
bGUgc2l6ZSBpcyBncmVhdGVyIHRoYW4gdGhlIG1tYXAgc2l6ZSBiZWZvcmUgYWxsb3dpbmcNCj4g
KwkgKiB0aGUgbW1hcCB0byBjb250aW51ZS4gVG8gd29yayBhcm91bmQgdGhpcywganVzdCBzZXQg
dGhlIHNpemUNCj4gKwkgKiB0byBiZSB2ZXJ5IGxhcmdlLg0KPiArCSAqLw0KPiArCS5zaXplID0g
U1pfMVQsDQo+ICt9Ow0KPiArDQo+ICAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKnAycG1lbV9h
dHRyc1tdID0gew0KPiAgIAkmZGV2X2F0dHJfc2l6ZS5hdHRyLA0KPiAgIAkmZGV2X2F0dHJfYXZh
aWxhYmxlLmF0dHIsDQo+IEBAIC05NiwxMSArMTgwLDMyIEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmli
dXRlICpwMnBtZW1fYXR0cnNbXSA9IHsNCj4gICAJTlVMTCwNCj4gICB9Ow0KPiAgIA0KPiArc3Rh
dGljIHN0cnVjdCBiaW5fYXR0cmlidXRlICpwMnBtZW1fYmluX2F0dHJzW10gPSB7DQo+ICsJJnAy
cG1lbV9hbGxvY19hdHRyLA0KPiArCU5VTEwsDQo+ICt9Ow0KPiArDQo+ICAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgcDJwbWVtX2dyb3VwID0gew0KPiAgIAkuYXR0cnMgPSBw
MnBtZW1fYXR0cnMsDQo+ICsJLmJpbl9hdHRycyA9IHAycG1lbV9iaW5fYXR0cnMsDQo+ICAgCS5u
YW1lID0gInAycG1lbSIsDQo+ICAgfTsNCj4gICANCj4gK3N0YXRpYyB2b2lkIHAycGRtYV9wYWdl
X2ZyZWUoc3RydWN0IHBhZ2UgKnBhZ2UpDQo+ICt7DQo+ICsJc3RydWN0IHBjaV9wMnBkbWFfcGFn
ZW1hcCAqcGdtYXAgPSB0b19wMnBfcGdtYXAocGFnZS0+cGdtYXApOw0KPiArCXN0cnVjdCBwZXJj
cHVfcmVmICpyZWY7DQo+ICsNCj4gKwlnZW5fcG9vbF9mcmVlX293bmVyKHBnbWFwLT5wcm92aWRl
ci0+cDJwZG1hLT5wb29sLA0KPiArCQkJICAgICh1aW50cHRyX3QpcGFnZV90b192aXJ0KHBhZ2Up
LCBQQUdFX1NJWkUsDQo+ICsJCQkgICAgKHZvaWQgKiopJnJlZik7DQo+ICsJcGVyY3B1X3JlZl9w
dXQocmVmKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcGFnZW1hcF9v
cHMgcDJwZG1hX3BnbWFwX29wcyA9IHsNCj4gKwkucGFnZV9mcmVlID0gcDJwZG1hX3BhZ2VfZnJl
ZSwNCj4gK307DQo+ICsNCj4gICBzdGF0aWMgdm9pZCBwY2lfcDJwZG1hX3JlbGVhc2Uodm9pZCAq
ZGF0YSkNCj4gICB7DQo+ICAgCXN0cnVjdCBwY2lfZGV2ICpwZGV2ID0gZGF0YTsNCj4gQEAgLTE1
Miw2ICsyNTcsMTkgQEAgc3RhdGljIGludCBwY2lfcDJwZG1hX3NldHVwKHN0cnVjdCBwY2lfZGV2
ICpwZGV2KQ0KPiAgIAlyZXR1cm4gZXJyb3I7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQg
cGNpX3AycGRtYV91bm1hcF9tYXBwaW5ncyh2b2lkICpkYXRhKQ0KPiArew0KPiArCXN0cnVjdCBw
Y2lfZGV2ICpwZGV2ID0gZGF0YTsNCj4gKw0KPiArCS8qDQo+ICsJICogUmVtb3ZpbmcgdGhlIGFs
bG9jIGF0dHJpYnV0ZSBmcm9tIHN5c2ZzIHdpbGwgY2FsbA0KPiArCSAqIHVubWFwX21hcHBpbmdf
cmFuZ2UoKSBvbiB0aGUgaW5vZGUsIHRlYXJkb3duIGFueSBleGlzdGluZyB1c2Vyc3BhY2UNCj4g
KwkgKiBtYXBwaW5ncyBhbmQgcHJldmVudCBuZXcgb25lcyBmcm9tIGJlaW5nIGNyZWF0ZWQuDQo+
ICsJICovDQo+ICsJc3lzZnNfcmVtb3ZlX2ZpbGVfZnJvbV9ncm91cCgmcGRldi0+ZGV2LmtvYmos
ICZwMnBtZW1fYWxsb2NfYXR0ci5hdHRyLA0KPiArCQkJCSAgICAgcDJwbWVtX2dyb3VwLm5hbWUp
Ow0KPiArfQ0KPiArDQo+ICAgLyoqDQo+ICAgICogcGNpX3AycGRtYV9hZGRfcmVzb3VyY2UgLSBh
ZGQgbWVtb3J5IGZvciB1c2UgYXMgcDJwIG1lbW9yeQ0KPiAgICAqIEBwZGV2OiB0aGUgZGV2aWNl
IHRvIGFkZCB0aGUgbWVtb3J5IHRvDQo+IEBAIC0xOTgsNiArMzE2LDcgQEAgaW50IHBjaV9wMnBk
bWFfYWRkX3Jlc291cmNlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBpbnQgYmFyLCBzaXplX3Qgc2l6
ZSwNCj4gICAJcGdtYXAtPnJhbmdlLmVuZCA9IHBnbWFwLT5yYW5nZS5zdGFydCArIHNpemUgLSAx
Ow0KPiAgIAlwZ21hcC0+bnJfcmFuZ2UgPSAxOw0KPiAgIAlwZ21hcC0+dHlwZSA9IE1FTU9SWV9E
RVZJQ0VfUENJX1AyUERNQTsNCj4gKwlwZ21hcC0+b3BzID0gJnAycGRtYV9wZ21hcF9vcHM7DQo+
ICAgDQo+ICAgCXAycF9wZ21hcC0+cHJvdmlkZXIgPSBwZGV2Ow0KPiAgIAlwMnBfcGdtYXAtPmJ1
c19vZmZzZXQgPSBwY2lfYnVzX2FkZHJlc3MocGRldiwgYmFyKSAtDQo+IEBAIC0yMDksNiArMzI4
LDExIEBAIGludCBwY2lfcDJwZG1hX2FkZF9yZXNvdXJjZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwg
aW50IGJhciwgc2l6ZV90IHNpemUsDQo+ICAgCQlnb3RvIHBnbWFwX2ZyZWU7DQo+ICAgCX0NCj4g
ICANCj4gKwllcnJvciA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgmcGRldi0+ZGV2LCBwY2lf
cDJwZG1hX3VubWFwX21hcHBpbmdzLA0KPiArCQkJCQkgcGRldik7DQo+ICsJaWYgKGVycm9yKQ0K
PiArCQlnb3RvIHBhZ2VzX2ZyZWU7DQo+ICsNCj4gICAJcDJwZG1hID0gcmN1X2RlcmVmZXJlbmNl
X3Byb3RlY3RlZChwZGV2LT5wMnBkbWEsIDEpOw0KPiAgIAllcnJvciA9IGdlbl9wb29sX2FkZF9v
d25lcihwMnBkbWEtPnBvb2wsICh1bnNpZ25lZCBsb25nKWFkZHIsDQo+ICAgCQkJcGNpX2J1c19h
ZGRyZXNzKHBkZXYsIGJhcikgKyBvZmZzZXQsDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
