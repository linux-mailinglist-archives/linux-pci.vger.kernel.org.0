Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93EB60C121
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiJYBiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiJYBhy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:37:54 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80560A3F56;
        Mon, 24 Oct 2022 18:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2baUQAdgFkSZZvvnbt7lW/oFx4dI2KmIXHGu7TG/uz15CYU+sz6/FzgDkcwjFnb0j4k9a9lTYw7Le/yaKs4DWJcEO1MtmsJpw3Md5akmbGfgjxRslvnLp/XMp7UP+RQJ2l2OsVc5jp7Tgtirw+GmOnVGu53swoa19TxoU4sbnbERvhjJ/R846Vf+ECtvIikHEzT+NredUZR1TM0TKDT93c6mgHXakb8xDrIEPg2K9oZrYSLpfZpOK0YgBCExsKMZn6x1icDBD6MD+FqEKQkNX5VE+MkX7RXChcG9P3lL6T76YxGBr2BznrHEPFLFdeveG/mhuH8froydUo9OdHSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bVFHpYs7+JXKx19BSQmqsWKJIBnHtrspI+ww9riGmQ=;
 b=MyxGORs1zo4wKcRSkyBgKYEuTSC4kww07QyO6+svoGtcOnL+5rcAxwlFvisHiQhNJe2I+9uwxmzN0EqWZPON4SoTjexxbdqjtjkWb06ezhB0fJGpTJw+wkR4kHjd+BnmKkdSnqOVclC1+1v6Fwtkr5+EdV3iUD4zULhSC1AnR6TxQoayzvgkOppmTQfqDZ/Y1Ow6sBn3Ko66XaIU7gJSVUnvGJwJsi3bQadbxRfiAFE683i7e8O1fMCRWFrCBH8Ifx1ykvF2HWUZCQhRWwfsPvOyip5Nxr7gphMsIcdhqWFSTO1s52WyEDfwOs+G5LkLgi/RqxkyCjo8yKouQu5DTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bVFHpYs7+JXKx19BSQmqsWKJIBnHtrspI+ww9riGmQ=;
 b=L8yea6a7iimR+U3bYtjUmJW10uwJ2sFGdyahT8P3kXdvrtZhNgBqkMUOHMXykxZPxOYek1pr7k3erQiDJETDpzp5JCTCAHcE9AKVV2omfB3Ak0L8oIbUAMaA2i8BJIPFbvNxwXa2hHrRlUH/Ycu/AvDusB2K9yofI1JUmK1413R/2DysdZQaZXL4ZiK3nSot7OVNy5qiqaOQXp6SDyaSgB398gJBvyMrmQQNK2ba0iYAuDeRKUic6/nuVfOMcK5xOPZCVkAcxBFCgF17FvCkJyOleY6ToSwF7FuxIFAKEQQ8pQIj0MspA/KwQXivn1FPvV2U6Zf2J1rfwHr9LHZwrQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Tue, 25 Oct
 2022 01:16:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:16:25 +0000
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
Subject: Re: [PATCH v11 4/9] block: add check when merging zone device pages
Thread-Topic: [PATCH v11 4/9] block: add check when merging zone device pages
Thread-Index: AQHY5XRfofKha0HG1Uuo+XGYihs/T64eU+SA
Date:   Tue, 25 Oct 2022 01:16:25 +0000
Message-ID: <9d774603-1802-639d-3cf4-885037cf4640@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-5-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-5-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB6090:EE_
x-ms-office365-filtering-correlation-id: 8b403581-2ee7-4a63-6feb-08dab6268974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJyk+8SSPfQUmsZRcI7U9XqcB/1tEqIdL2y2XDFrg0jEP64m/n+K4x+q/nce9eowUoEMuSnblJv3kSXcAOzVNBEIFds/j9hruq1xv00uwJ0/CLJLYisEhOU2/3vZAdujmYPFrCB+ze9qkYUZEZ4JeMGGvnzLtyod+bPtxo0QbzWyzM5RhF1wh7IbBoquSdiQcrXjAixr4y3t+cTwDsFoZ+yb66CppG9vegsEoW8jnfCEvQ2+2XrBaDzYe+WAeo+Ev+jOd6GSxqCH1UbwWP0uaZIUpYJse7UF+pVkWiMd/vCx+DGzETIvk/2el3ZI9d3ndn7R91mXEa/YTQRiHN3B7lKOjcZvWOa6w/qxLVmh+DPqIaLFS7dC+bMAjX/38y7iObHu3WpyEN7jtKfBu+R6rvwOKRMGbifZY8m0e+1GIVuE8R3xWIT7N+CskdSGvbVbcf49M3di3TwoI3yE/xs3HLK9xvNOPfnmvmhjwYPMB15uStBG2gB+2h7Nbeoj1xwuKDBQ8tBjtgzUIx3No1MhTzLAyz5XFq6UdhfTXcFUCssM4gOQ7OL7nJvq22fVE8nUAyCo+LgwSzFt/S95miqCHSLO4QRP9vQOEATsWFqIVXRNDVLaxNhNWJkW/Mdaoypil9ZOI0OfWy9Fyx5IiIcGFXXIAqEDx+JOYgGb1jlaGCGyiAgNMc1Jfq8U1E4Wi6UiLCQYD7qB4Ybz2cHsp0E1S9+WfaHhtWDLpHHmVwPsn5misafX+pLgBcMh6PtF2ERiS2oTEW1oi3cvHrOhd9eoQOTxbT24VoIdcbndeJ0trGHufMxm3WWE6U0GE6VygWTdzgvVRN3uzjJL2pHkAlvxIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(31686004)(36756003)(38070700005)(8936002)(5660300002)(2906002)(4744005)(38100700002)(122000001)(86362001)(31696002)(83380400001)(7416002)(186003)(6512007)(316002)(110136005)(6486002)(53546011)(2616005)(41300700001)(66946007)(478600001)(91956017)(66476007)(71200400001)(54906003)(76116006)(4326008)(66556008)(66446008)(64756008)(8676002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRnVkplOXVFbGMyVVhPTmtFK21KWnVxcnVoaGdEOCtOWkpsd2Q3M3k1RDBV?=
 =?utf-8?B?M0ZyZjBqYkNSNzN2clZOZGV3MmJib1JDQ2VmRjM0QUxET1Q0NCtQOEo2Q2FS?=
 =?utf-8?B?TXZVZ3VjYlpkcnl3YVZ0U0p1VThIVXVFU2toMmxPMHo3bklIcW5ld2F6b04r?=
 =?utf-8?B?Z3I3ZXFINE9KUUNUYkJOaFJMWkw0U25ORTJMekgyR0pmcWZIUUxUMXlheTQ4?=
 =?utf-8?B?eG92V0owRmtESFdsZ21oYVpQYkhuY29yZm1hcElSRm5jSUZiT0Z5b095OHBt?=
 =?utf-8?B?djNDN0RSN016NS9SQ3JxeDNmWGVjMFJUNFZEUnBIckN3eCs4OXR6SU1YbWFB?=
 =?utf-8?B?SHlSeWVwc2hzVFY2UjVHbnNZNzZiTExuOFFIREp0Y3pEaktZUHlNeTI1QnR3?=
 =?utf-8?B?WitESitzbisySFJoOE94Q0FoNUJNT0Y5bDJrb1AySzBpODZRRzJlUCtYSnFi?=
 =?utf-8?B?TVpQZjkrZ1Z3UU0zWkdQVlR4WTVEMTBkc3FXUHRjK2h1QndGMW53Z3dJLy9x?=
 =?utf-8?B?UFpwbHFMZXE4YnBwMXhYcEw3ZFBGTnNVY3hoQVhaWEtpT1I0L2lsSkhjMGI2?=
 =?utf-8?B?WFY5NnpFZEJYdDhqTlhscDNaTHJFcnZGaGg2ODM5SjFna3hKQzBSbHYwYVMz?=
 =?utf-8?B?QzVXT1J6QWRvenQzSjZ1MjJwd0lQcWpEZGsvRDU3SzZrcmt4clJoZ1pUOTY4?=
 =?utf-8?B?MWU4T3ZtZCtKR3ZveitYTDA5eVJVb25oa0lONTFlWkdXWW4rYjdlQ3RoSzR6?=
 =?utf-8?B?NVRIZ0VnYjNFb3RwWVdaWHRkUlB0VjNFM1pSMjQzZHdJOTRYUTloR0lVN1FJ?=
 =?utf-8?B?TzJmV1Y4dmh2QWc2RjRaVUhqa1JRRTExQ25rMWRYZVlycmRVYmNuMzYwYlVX?=
 =?utf-8?B?QVNrZTNoc0d2V05xeDNDdVZ0WkZBeXE5cUlYL29BL1k3bmQxSlpTQnpjTm14?=
 =?utf-8?B?SFJpdW9TQmZXYm11Tmw3M2tIRFM4ODR0dVQwSFhnTUNUWm02OUc2L1NLVjRE?=
 =?utf-8?B?MXRaS1RoOWFqenBpWnllZ0xyWHRoSzVrUUVpOEFVZDJpeG5kYU15bk14Zk1k?=
 =?utf-8?B?K2F2dWxzODBkVnFmZmpUMHJ0Q2syNm1QSTRUZEVBTWZneGE0cUYwc2RCRmlv?=
 =?utf-8?B?K3VlYjE3cTE3aVE5NVRsRlpuSGowMFd1RVhaYnhORGowWFR4UUZWeDZCVXNU?=
 =?utf-8?B?Y0NtdFlhSy84MlowS000SnRKYmF2b0d6ME8rdDhkbUNLRGpwM3ZqNTFobUhT?=
 =?utf-8?B?aVM3MXppQXp0MFpoK2JBVGtpQVJkOHNlTTlmazI4OEQzQWtIWlFhVEJFVUxT?=
 =?utf-8?B?NFBZVk85SzVaQ1ZhTDh3SDhUYVlQZktlWGdkWDQ2YWxrM1I0L1Arb0U3b0dH?=
 =?utf-8?B?SDltdUtHSGlKSG9GcjhhTG0welFtQTM3NXUwRk5TOXpaU05wZlFDT1dWZTB4?=
 =?utf-8?B?NFpPKzRkMGRFbytuMGhwRGZ3SlRIeWVqWnNidkdMYW9PTG84c0ltaU9WVWZp?=
 =?utf-8?B?YjVDRStUNVRVTE5Hb3dXaGRvc1AzSTdVYjR4dzdnclRaWkl2NWdCOVIyWXQr?=
 =?utf-8?B?NzN3R0ZBN2FhZ1p5akdYaE5uT1g4QmdxTG5ZazVURjF0cDRaaWtCYkZwTUN0?=
 =?utf-8?B?WlZFaHJYUnExQ01LU1VJNWMzVHl4Qm44RTBXVG1pVGlNbTVoTWdSVXh4U3FI?=
 =?utf-8?B?SmRZSUp5YVdMbldWM3RXcmxSQmdQWUs1azF3REkxRlhyU2t2VnVpSHNaU1A4?=
 =?utf-8?B?S0ozMWhvZGQ5WDhZa0I2a1VpdTlyZnIrVkI0V1lLM1BxeHdKVXEyNlVFSVBz?=
 =?utf-8?B?bmsvV0xZVXMxQjhRK01FcWRtVDBWQ2F5TGlLK291aW92RHhZTVNGZW8zblpB?=
 =?utf-8?B?MTBxM1NGK2RuU2ZvVC9BNUxsVFcxbVdxZzlTem9FODNnamhkNUdST2d6L1Bl?=
 =?utf-8?B?RThPQ2xLd1owT2lVTHZxV2c5R293eGE4TEwzS25tSTRpcVF4Qm5jQW92dHBG?=
 =?utf-8?B?emdBQUU3Z3hseGs2K25sTHhqemdZTnkzYjhNYXRDNVNTVkZQSXNRZ2cwa20v?=
 =?utf-8?B?UllwVkp4UVJlQ2d1aC9YaDFaSXZmTnJuSzFIb25UUkdiSFhLbEQyVW84MFdB?=
 =?utf-8?B?aVBjaURiY3ZCU3lCS2o4cStRSHhWa3RMNDNXWTRqR0J6dmFyNW5tMTNRRjRu?=
 =?utf-8?B?aWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D02C1A8CAE5E7F4BBD0147049C2CC7F5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b403581-2ee7-4a63-6feb-08dab6268974
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:16:25.6999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BYYWRqo6B36TsO2sGSTqEZGHwhZUgY/LkJMofObrLuJphmES9qjaSL0qGM2/secyjStSK/HTG/9rPRgHjTJWqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gQ29uc2VjdXRpdmUg
em9uZSBkZXZpY2UgcGFnZXMgc2hvdWxkIG5vdCBiZSBtZXJnZWQgaW50byB0aGUgc2FtZSBzZ2wN
Cj4gb3IgYnZlYyBzZWdtZW50IHdpdGggb3RoZXIgdHlwZXMgb2YgcGFnZXMgb3IgaWYgdGhleSBi
ZWxvbmcgdG8gZGlmZmVyZW50DQo+IHBnbWFwcy4gT3RoZXJ3aXNlIGdldHRpbmcgdGhlIHBnbWFw
IG9mIGEgZ2l2ZW4gc2VnbWVudCBpcyBub3QgcG9zc2libGUNCj4gd2l0aG91dCBzY2FubmluZyB0
aGUgZW50aXJlIHNlZ21lbnQuIFRoaXMgaGVscGVyIHJldHVybnMgdHJ1ZSBlaXRoZXIgaWYNCj4g
Ym90aCBwYWdlcyBhcmUgbm90IHpvbmUgZGV2aWNlIHBhZ2VzIG9yIGJvdGggcGFnZXMgYXJlIHpv
bmUgZGV2aWNlDQo+IHBhZ2VzIHdpdGggdGhlIHNhbWUgcGdtYXAuDQo+IA0KPiBBZGQgYSBoZWxw
ZXIgdG8gZGV0ZXJtaW5lIGlmIHpvbmUgZGV2aWNlIHBhZ2VzIGFyZSBtZXJnZWFibGUgYW5kIHVz
ZQ0KPiB0aGlzIGhlbHBlciBpbiBwYWdlX2lzX21lcmdlYWJsZSgpLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiBSZXZpZXdlZC1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBKb2huIEh1
YmJhcmQgPGpodWJiYXJkQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL2Jpby5jICAgICAg
ICAgICAgfCAgMiArKw0KPiAgIGluY2x1ZGUvbGludXgvbW16b25lLmggfCAyNCArKysrKysrKysr
KysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKykNCj4g
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0K
