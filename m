Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2819860C13C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJYBnh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbiJYBnX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:43:23 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645DC9588;
        Mon, 24 Oct 2022 18:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFYlFiC71p1kg1Rl1DlibGMZEm1FHc0TTfvsqIJTkOrLy0Tkm4UNT/6IRPM42QKJzk59F9lXIhmuIMZNm0HAPCA3eSuGOs7On4R5z6GSc15NR9JN18x3LrIJacFbImq735wFWkwVnKfuoxdcMMeQ/LjbRr7IDiBVjl0aE+PX3oj9921H+K81i9fpcPVIoQYvXiJtF5ISf6YS/DXunEVjxA/lk0M00z0if5Nf07YjsOPy9zFvSB9QlSMaKjR4FMhdgLNW/KdOXJaFEWNKEJUk7lu+IBN1Dxs3Q9iKC134ia54qOYJNYRYD2/bnz9JRd1slyDdo+ZELCppsq3JWAE4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZ/cDWYIl/00p8Qp4oGLhqOmOJJ0XdecIt8K2JKXfxg=;
 b=eeLbjCRJGm4JDsCAL9wHp14wQKJKfYmilb4w06a1i25c3ZlplEL0L5hH48sNf1cMezgMBDtnzwIjtJkK2Bzq8It/XFDQg39RwdtgaK9xl7hwyOsH1fE092Xos6Ep1TaLnjBBFwlJS4Qkr/gsdh9XU0oaEKw1hQpPgHGzpmSedl8VIgq9Zx2o1AjEUjLvqNGubatSDwA9XRzwu62KWPVvDh2a+FvVe6XVpmY1MXMYHdDwhb6SladPjkkQFBkz0+f5xKmXSj4vbTTwWUjACPiZqJg6sHH3kDQ5X0u8SOwjNHkCrT3SwyyZYPqXtuLhaHcjLTAK5M13jyLpH5CuuPIPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZ/cDWYIl/00p8Qp4oGLhqOmOJJ0XdecIt8K2JKXfxg=;
 b=gHFIVH4E7gpjPpg4ZtvU1PtF8isfJndLwfcaxt7j5mfs8dW6lZPIp+VYLPDUdhC39aA2Tt9LUG67a9qGCKAtbDUXZOAqhj0P+P2zKsXjnnF99K0msz7LLHspXLczXXCVUaiPCufao4GCILGvgYBMGTBBC+tiRCQ6LZPZMa/ee6xjwFX3xGu4Y1KuSa/sRtP2ZqdiYUfSzJPb6HrRTsAsImYrN/YKNLhxDD0TvV/4Xwwl4OPef9uI/NhzVi+zShru9sEDc5mgc955dKaw/71j45NB/3ZpaNbbWofKJ+o/3ZlosI074bCTkH/rWHshCykZVkaF9D1K5w4tE+7cvms93Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 01:26:45 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:26:45 +0000
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
Subject: Re: [PATCH v11 7/9] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
Thread-Topic: [PATCH v11 7/9] block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
Thread-Index: AQHY5XRd3ZgDhJqZp0ODtc6iwuzMGK4eVsYA
Date:   Tue, 25 Oct 2022 01:26:45 +0000
Message-ID: <da7b16f0-dbac-1dc0-3799-45ef05b861f4@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-8-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-8-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW6PR12MB7071:EE_
x-ms-office365-filtering-correlation-id: 909294e2-5c36-4d42-ca2a-08dab627fae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8v4vxm3t5WIkrk//RJwkMwE4XiQkkgaaycCv5adwW3XLIRqqfsce+G+dxsDBer19xlOpuDEeTwuVUqpjfX2myLGhZ7yW8SXawONW2vBA60OLao8A86yuTGKiW+rSfQlzlv5xZpHvBWdWaeokeIlRoNViQlwnS08fuIhEXC/Gav8GsXR/7/DrHWZOp2UZXspz8WENW8LVzlugMvrVeQj71d5AvPNZZOJSBh+VjipsWC4QoKOUa55g6dBFLCVJyZ2EHvPn90mXBg1lZVfLxyC+vyIyLYJrXQteue3ht+iv+AA1FwTt7XsEnuXcWzKsy6NtKp/gVifRHUFY+//ZTfFf3P6MyWCYPSxJPoEatMQ5g5P9vqJ6GFNIIw/esOSnBPf+fqJYOrBfXt5YI5oTnwYCuyC8qaqlBQGNXpoC4OYMIHs8nBoUdIwDKB+Y/EJMCG7WIpoPZ6IETY7pIIiaNxOYzS/IyUOPudn+AefWVCqc0JNaWwEVvzciCIigVAtE5Uf+4rIyv6dMqDmOrM0rP/93zPwPe3LKLuHepMxhBL+b/5tkmPgooIyQTMg0Q9Uzn1r/KJKmHm4tr+rzpjvz1twW4FbFPpUjtldmFcGKBi+PD/OpOeHtOeC4xeVf5DF1HcqFs9oM7ftufhR99gK2GzvKSLu72+XhaX9gXkVv4s0X0WKK40CCf0rVsPDpr5YxIwSr4wnLa61kd/w6Mm0RZ0DfDaxtOjWkZDIkpC7pWTzQ16OnsW4HIaacILNcoTCUhwZST977Gw7vSASKwTvEtYfd1+QEBVrAAndghz/kn5h2Wh++8tvdxeo+zQsB9kKnVX0ml2K/hXvTkNQMnleD4qZwGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(122000001)(5660300002)(186003)(2616005)(83380400001)(38100700002)(38070700005)(86362001)(31696002)(2906002)(8936002)(4744005)(7416002)(478600001)(54906003)(6486002)(41300700001)(91956017)(316002)(4326008)(71200400001)(76116006)(6506007)(66946007)(64756008)(66476007)(66556008)(6512007)(8676002)(110136005)(66446008)(53546011)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEhNOUFLR1F4dUI0L2NnUDhKT0NCbDJtcElDZVlwd1ZNejBQenFhOGxJRCtZ?=
 =?utf-8?B?YlRCc054UzJucG10WkVqdWREQy9sOU5HUmVWR0pYaktxa2ljY2JLRnFmMmNS?=
 =?utf-8?B?WndaYll6WVgxNkxJVXU4ekdYR3RqQ3lBR2Jvano3K1B6bGorbC9aT2hFa3pl?=
 =?utf-8?B?MWQzeXllSzkwNTNWcm5TaXcxTEZqZXhwMGpnUEJoMjhuNUpaVUtwTnN3dFNz?=
 =?utf-8?B?QkVaNnVUb1ppNVk5emhpeTdoUVY0RkpHeVUxd0xYYkJxVGx4TkdpUXp5OENa?=
 =?utf-8?B?RnArZmJZNFUvRVBHc3JHeEhsazRoYTNveThacm92eHlEYXlTaFlkMVdFZ09l?=
 =?utf-8?B?YnFMM1p6czR0TGpRNDVYclh3QVZjb2JJcEN5b2FMdjRSeVpibXphLzRJLzE1?=
 =?utf-8?B?WTBsZUFSRU04WWhyWlZ1UEhPdmxvU2xOYVdoblRJNXNJcGY1UGdXeUZLNnZh?=
 =?utf-8?B?NlZiblZsUFUzenIrMm1oYjlYdUdzd1ppOVlFMit6dExZR1NMVkVrVHluNTRt?=
 =?utf-8?B?WHI4TUJZMGtGblc1T3Nic1VFdWl6NFJpMXRYVHIzVXc5UW5XVVhwL0xOWXhM?=
 =?utf-8?B?cjZMOXJ4VDFHcGpXYWlqdXpZS3RUSjRGK2I2VzV2VUUzbjMrWnYrT2E4ekhG?=
 =?utf-8?B?KzVvWm5zRXdEaGVFOUJzcXFwaFp4MnVheU14eFZWNHNsVHhXOTNUSVl2ci9v?=
 =?utf-8?B?WE8yWGhmb2k1WDRZaVJWdTJVa2Zjdjc1L1FCVW5xZDFWVzB2L1l5bWlvOWhl?=
 =?utf-8?B?cTgrNG1uSnZ6ZWNGU3NIQWhBc3dZaXRkdk83NGtyZG5GTkZQU2xheGFjNHRE?=
 =?utf-8?B?WUhJOXRMcndvRHBpSGRveTM4LzU5QUptUWRaZzBBQXE2T04vTUY4Ym84Q2Vu?=
 =?utf-8?B?YjFGUTcwZkN3YUFNNUwrOEJCaXY0MUg1WHM0bW9EbTJIdFhFVlc4Tm02RElC?=
 =?utf-8?B?bnZ2a3d5T28rZ0Y3R3hyTXdyL0NjVFg2OTRhWE5rNkZVeVFPSjVHY1BMbFVZ?=
 =?utf-8?B?S0dWVXlaZkFBeWpJbG9vcGNzQ09lOFoyaWU3VEJnM3lHZnFCMllRWGNvOHJK?=
 =?utf-8?B?QS9BbS8yTXFRWE9Nb2FoMFMzZTRmVUg1TzVUckFIbkxFajl3K3FOVFo4NCtW?=
 =?utf-8?B?YmhlalhXN0t5NnRpLzZEK3ZSVkM4bXhmdUhCbEwrU3ZwNzRwUElFODBjWlYr?=
 =?utf-8?B?cmVBL2ZiYTZtdzEwcWV1SzB3U0dBM1ltemRXZGFoQXZKMWNOWER1VXdIM09V?=
 =?utf-8?B?VWJFL2M4U2kxaXFBZWRyZEI1cFJ1eExucko3ZVR2UFBaSktvK3BYMnRzVFN1?=
 =?utf-8?B?dURVaUpRMXAvNjB6MGVwR1hwYkhYd3YrSnYwVjdDaytYMi92TW9nT0NOR0NO?=
 =?utf-8?B?VWFrZ0hRNHZ3OVE2QnY2SFpwc0lEcy8wVzl2SmpPSUorSXhYWDdOYmhvUllM?=
 =?utf-8?B?Z24zVWxkY25kTXJtcm92K2xaMUFGTWR6d2loam8vRXg4Qmo3TjZxVnRnUUhF?=
 =?utf-8?B?UkdjYzZvc1g2QnkycjlxU2Y3SzA2QTRjQlF1SHZ0ZUxBWXVJd2hNcU1qQlFu?=
 =?utf-8?B?bURPWXhZNVVTOTRESFVLdkIvYTg1M0Rybm0zZm1UNzFSWlVXWDdkZEYycDVy?=
 =?utf-8?B?eG5QdW5EakdXSzdDK2VYUUoyeW5UTTRsQ3I2b2xBZjdyME15QlBZb016RmNH?=
 =?utf-8?B?NzBja2dJcXB1OXkrdm1IczNTV2ROcEI0RjFtNmZXY05iUm1JZm9UbDhkMU1p?=
 =?utf-8?B?QlNaV3hzRFQ1eEFKb2JqK2pZMFZlbC83MjBraU9iRFBubndrK3RBbW9PQ2g3?=
 =?utf-8?B?THRpQUtvZEpHZHNzYzFrUEZMK21zU1U3Mk1vUjJXK2ZrQ29OSlpLT2NuZGxF?=
 =?utf-8?B?ZTh6M1ZuZnVyWDZKNWJVUXFydDFmdEdSZGlwYzdraVMvL2FLTFhYeWRIampB?=
 =?utf-8?B?c2ZQRlVsUDl0K0l0dDNJeFlJSC9za0luZVEycGxQSFJ5eFZjWjNHUmJURy9D?=
 =?utf-8?B?YjA3OTgxNXpRdGEzU0tWQ0JQZHJEWUlDTDhqaDFQckpPNStCWFNYTnYzL050?=
 =?utf-8?B?aTFKVVdYeDRaZW1VUnpCVWg4SWhFOGtpUWZFQklDS0JIRmNDVG1wNStVaTlI?=
 =?utf-8?B?TTVsNmY5YVhYb09kN3V2VkYrSDFJWU5IOGl4OUF6VDUxbHZUcFR5dmJVYnFF?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C72CE779DA2FD46BD880B8DE7BAB2D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 909294e2-5c36-4d42-ca2a-08dab627fae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:26:45.5533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOHRnX9pgRu0yLWhihxUpn85it+MNqfi8P3DKLVUipRO6nuqLa4JxTF5mvMjNiiX5vBPW/rSb4lPITMZ372uhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gV2hlbiBhIGJpbydz
IHF1ZXVlIHN1cHBvcnRzIFBDSSBQMlBETUEsIHNldCBGT0xMX1BDSV9QMlBETUEgZm9yDQo+IGlv
dl9pdGVyX2dldF9wYWdlc19mbGFncygpLiBUaGlzIGFsbG93cyBQQ0kgUDJQRE1BIHBhZ2VzIHRv
IGJlDQo+IHBhc3NlZCBmcm9tIHVzZXJzcGFjZSBhbmQgZW5hYmxlcyB0aGUgTlZNZSBwYXNzdGhy
dSByZXF1ZXN0cyB0bw0KPiB1c2UgUDJQRE1BIHBhZ2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
TG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KPiBSZXZpZXdlZC1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBKb2huIEh1YmJhcmQg
PGpodWJiYXJkQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL2Jsay1tYXAuYyB8IDEyICsr
KysrKysrLS0tLQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KLWNrDQoNCg0K
