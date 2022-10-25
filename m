Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1923B60C14C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbiJYBoi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJYBoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:44:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413AF6CD29;
        Mon, 24 Oct 2022 18:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anAtuTTRPpJB8MuMogRleLzZ9fkf0nr3Ag/sdslRwg9mPNZMcc2Mg1UNCcYmnDdotvqnFj0Va0WMseexu5gDOj44/YUBmTwLivyCdzy8aA7csOR34P9Vq6yU4Pq1ofH22F4IziI4I6cxjBNbp7+9FKML8jFmio/PDl+1F1uiP3zpDz8Z0y+Bffq4n3bYuu+7jFloPjGShKHhp3Ww8dz4rMrCrhtlt6r3EWkhg7V479u9LaWl2RscgR4MwShwOBLQVBT2BKLOPDrgOH7lDtDJPwsn0udF48x3tjo+2hciBnN93cctWjxzby967eSFMUB5fiDTdX2YzOnGkDkSavSu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+SNtnvtZUI/gJ7gDXBPyzt+YjWfL+n7DpUhfpAiwsU=;
 b=abxtfw0JIOfLKwSwis/a3TXpYiMlEftoi6ahrgYQSNMDdO9mm/lxRMFqzZQ3rcBmAw8e/xhhOX6VRFMSa+jPUDHh7rg59id4nmi9eLIl3kcYhBSbqUttyF+F+nlN9K0cRIURCwsO4zoJL0r5ZQExviJl21JoBd7AF/o2N9sgZn82g3OcisFEUMXmuxROt7hWT1aCsTBJ4RUt+GlQZN6HtKZLOFPLFsli7dREyw65wbxG5NDi4kZ1O6dv4QvpEGkXtRcbFWoh5QG12BV6SewPj88SLGsCiVa6CsIcPSabGDL7DFIl+SpmcJvuSE5GTHUmedVORQSWL5XYesq5XTJluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+SNtnvtZUI/gJ7gDXBPyzt+YjWfL+n7DpUhfpAiwsU=;
 b=nthl9OnRrLfuJ50TS/lpAtM1EHNyg4qWW0XfLNQF7vd/lDS+6+DqY76iQEw35d9bFOSNHbv/4meTJbUflksQ85dMqQS9kBH5/C2xGmTx+zCvR+7CM6DqzMjVA6bnqYLz44jmSA5+hQo8uttR1E10cNDVBn58apldY6cCdMqZSgzqu7/hnIWqh1WVfWP8HI6z9wA5PZmN9MT/bDNv/DJLeKy5Q2cl7ookDWhSaJ2gbmb3savdVfCsF9N4e/bKqgnd2RFS0KRe8OIzaU53PNj+ubET14UMbPkepdUn/b1DhSMFtbSXzc/NEuc/qBCXj0n5+4fQ9Bd2dtPN7cJm5W2N8Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 01:29:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:29:40 +0000
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
Subject: Re: [PATCH v11 9/9] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
Thread-Topic: [PATCH v11 9/9] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
Thread-Index: AQHY5XRdRVQzE+a2SkmFRyxtgLC80a4eV5gA
Date:   Tue, 25 Oct 2022 01:29:40 +0000
Message-ID: <31579a4d-fcb8-c4c8-dc2c-47cb6b4984f5@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-10-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-10-logang@deltatee.com>
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
x-ms-office365-filtering-correlation-id: c20c6372-5725-4566-c0f5-08dab6286324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+vhgOdTTac70J+/QP4Pfc+0bkjxeeXlWIHKjvqBOlIMpMWtyBM+dKQQ26yK1nvNJdFgwx1OcAvuPdOPgaL+lzXrsTA1aNSPC/EGg4g6abAwo/SCzIS5cQDxd+yilqRvasRA9Lk7uahlpuSA7WAqYiUfLkw4c6aHqJ32UbiyLHYL4Hqo9xrYnu3v77pnrD+eYj/d2DGF9yETQpGQAUQhzK5kKQ28In6XtuxNxilEEHAi0AsBWPGXzuQKFmFSnTJpHSOMod0h7n3wwDj96KkOkjY6an51StjsZb4tXHh+b3rvRwnK1lXc1/Dr/915RX1+uFUYN2y9AiXpqoEhCSKoTeiOeI+OI3iE+6hmCsSFj4eORAfND80hzD6UtyKPv6lIrcrXVvs1vF8tqzkPexC/t1EZHVjDznSmjSef0xgSoOUXQjNbl030pl8SMH6Z8ayG+MP21AUpU71EhNy77gOgL/TwJRBv0UKCMTUp4Ljk6AyOiluKAIohPw6pY1gG5JjhfPvmHSl8f+rxx64u41Urr5ToQYeEeUZ5KUVf6jQlUfFexOCObL/p4SPifMUdQ5NflYfXrQtRI+JOYvTMae0jNRcKoTMIwtHXWs1T7LgnnNPN/7ebqMgmBwJ91ZxihmWQhFXVqmJX5+E9guEkinVjuz5hxXi+Xi5zTfBi0hd6LZ7YA2r6/9j18BCwiBtzu662x7x3IMO1XhLKspSxQljzRllD3AopVw9JvogSDYPq1grNQGRt0f067j2ZwX75R3lonv8Qoega1ImRjOWiysxqO3abX4yTyaSiUtI5Cy23G/WUFtVZN5iZprI9i+KATf6tAfxo/Jse+W4THMk3wl4Hsw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(66556008)(38100700002)(122000001)(54906003)(110136005)(2906002)(6512007)(8936002)(91956017)(36756003)(8676002)(76116006)(66946007)(38070700005)(66446008)(66476007)(4326008)(41300700001)(316002)(64756008)(4744005)(6506007)(5660300002)(53546011)(86362001)(31696002)(7416002)(31686004)(186003)(478600001)(2616005)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjhOWlpDZHZYaUZ5UmxUK1gzaThGemZqWVFxK004SERGWHd0ckdKdlBHbHhG?=
 =?utf-8?B?OVcrL3JBazRTT1QvbU5Gbm9yUUhFR3cwbUE2WGJnQ1pFU01wK01OazVINUV0?=
 =?utf-8?B?YldQU1ozanhoOUMxOW9wUFdCbEZLSHdzM3J0MENXUUZibWRsWnNvWndKcFdY?=
 =?utf-8?B?bEFsWDRvZk90dlExM2wxWVk4eEtaeFRkTWJmWDNDbGp4VU4wdm1paUl3Vkhq?=
 =?utf-8?B?ajdYOGY3TDYrVFE3WDl3ZVlOak1yaDAwY1hMMW5Db0Q0bzBOdkg5Vjl3Mjli?=
 =?utf-8?B?T2JlSUF4NDZQU3VrMnhWK3BxUVM0WXFtTEhvZFpDOHBvRmdpUHhFdGczTkdh?=
 =?utf-8?B?R0ZqUkt1cDhjV3hLVEpQdGpSVW5RQ1BkZlJnNWpXTVhia0E1aDlZKzFCbHhL?=
 =?utf-8?B?dnI4V3JUdXRLWmhKYVV6NjlrVkFRSnAyaDRaZjVzNkhwRTBPRXV4KzM4WmNL?=
 =?utf-8?B?M3RTQXkrVHArUWFQS2tCOWQ4azBOQmE3ZlRJZTY2b3dPWXN3R1hBRkN4OFNv?=
 =?utf-8?B?cHppN0FDWmtNQUZiZzREajlJNytrRW5YbGJzVGRVZ2grbHphVGwwQ1FMdG9T?=
 =?utf-8?B?OEpTL1FvQ1JTVk5KSFE5RHlYT2NTTTFJREVZbkxNOHRJTHRNM2E3MEFsRW5O?=
 =?utf-8?B?NDZTLytGOVVwUEViN0VmTHl0Tmd4WU5COFY5VEFEaDR6UHk5MGhYUlIwbWFS?=
 =?utf-8?B?VUNYWW1aZ0dlVnpNdWpaajdRNHVQN092TGNqZXNNeTdGdllKSG54Um8rWTRm?=
 =?utf-8?B?YVZ3SkduOEpQZThvUW1tUVNaOTllQVhZWGdFWXk0a3lUOGNwMytQd3BaNTY0?=
 =?utf-8?B?ek8rN3hFQ1NLSzV3bUFQdHUvdEFDc01yNWE5N3N1MVhCZXF5WS9KZnVBVUoz?=
 =?utf-8?B?RzNIblNxZC9hQmNjaEJJUWpHSTJHdkxaTVpFZHJySnhKRXM3WW1jTUs1RzAr?=
 =?utf-8?B?b1NnOTJFMm1kRXgzcm8xR0xKQk9rWGV3RjcrUVl3Ym9wQUx4a1ljSDdFMFV4?=
 =?utf-8?B?WTJEQXowa0JMNndsaDVZYmhhQUkwZWcwZW03VlB1QldwQkg1NUZyU3RBVTcx?=
 =?utf-8?B?bWtJUlgyOGVrZWRVOUVETUtXMjcwQVI5UmFCVVlScmw2dUcrZmV3d0J4dXdn?=
 =?utf-8?B?OVV5UW9kcC9KZVhBVis0RmhxYTRFd1Z2UFJ5dTdxdDYwM3JTZjlvaE1BWHpP?=
 =?utf-8?B?MW1Kek0vbTFpb0wydGQzaGF6MG50ODB4WXZYL1Y0aWtUNEpPSks1WDh2T29I?=
 =?utf-8?B?ZVJ1QjVYU3VGOEVoNTlNeld6TGxDa1pOZXB3U1loRS85R3Z4dk8zRWJMcXVS?=
 =?utf-8?B?WDlOU29ldFZVc0YwS2R0MURVYUxCNXhmR25hUFEwd3l3NEFLYzNQNzFhYStH?=
 =?utf-8?B?ZGZOeVI0ajNUbExobCthTzVEZU1pUlFvdmk1aG40N1Jyb2ptZzhZeHlRL2Fn?=
 =?utf-8?B?ODUzNkNTYlNNWWhneDQvbEQxbEg2TFp3d3dYa1M3RlQyclVIczgyQzVSTjRX?=
 =?utf-8?B?WCt2c3VGb1FKZ203T3BKNjNvSm1yaEVCRFU3enVJdGV0MkRyN0Z0M0pHbzBS?=
 =?utf-8?B?QWxFTmtiMm8yMUFZV0dEUUltU2RWYy83dWczMTZRZ2xXUUExLzAvNERpZTY2?=
 =?utf-8?B?d1haMFo2U0doekp6T1NWVkd3SjZxeW03RTJRY0JIUTBGMHpHcFNwbWgvcjlJ?=
 =?utf-8?B?TzZVMjg1c2dLOXBlNkErdnNMU1JjRHZzZ01oR3JQeGlDNkp2MW90akVZR0dX?=
 =?utf-8?B?dys3VENBTGF5K2xXUEV4WktQalNsWFJsTnlqemJHajlKYUNOMC9JREhjWFBJ?=
 =?utf-8?B?MWpwVVYvcTk5K3pMbXZyaE0wWEdFUzJDaWFzNGE1QkpCc2ZYVjB4Nmt3SU9G?=
 =?utf-8?B?czJLalMzSkVSQ1JocUcvbzRidzA5SXZuWW1zOVpEWlJaTlBmdEh1UmJlb2lX?=
 =?utf-8?B?aGIybkxxbnJacjUvUVYyeFFuRVJnSHlZOG8wcUZZZnY5WFVnL0N0SXo3T2J3?=
 =?utf-8?B?Z3ZOb0RBcTBTc21KRVYwc2RDeHQ5Ry82SW80eGE5Z2RETk5rVVo5aEVTZlIz?=
 =?utf-8?B?ZU0wUE0wa1hjam5haDRnb0dBYkw1Z3c1RUhKcERackpFRVJMSnhWa25hQUVQ?=
 =?utf-8?B?YWpHdEIxWEdMMTNieStleVpUV1dwRUZ0R2djRkJ2WWIraExEbWZyL0Exc3Vw?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED9AB7DBF675F04AACA35727AD5CAB41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20c6372-5725-4566-c0f5-08dab6286324
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:29:40.4177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l5cR4c5bDTrN7VBJHc1f0LYFFjIZd1BScpw0Wy+CAOIC61LZe1XhY78Tu7gc6ve4Bs8QXTn3klvnP+XqJZSKEw==
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

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gQWRkIGRvY3VtZW50
YXRpb24gZm9yIHRoZSBwMnBtZW0vYWxsb2NhdGUgYmluYXJ5IGZpbGUgd2hpY2ggYWxsb3dzDQo+
IGZvciBhbGxvY2F0aW5nIHAycG1lbSBidWZmZXJzIGluIHVzZXJzcGFjZSBmb3IgcGFzc2luZyB0
byBkcml2ZXJzDQo+IHRoYXQgc3VwcG9ydCB0aGVtLiAoQ3VycmVudGx5IG9ubHkgT19ESVJFQ1Qg
dG8gTlZNZSBkZXZpY2VzLikNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExvZ2FuIEd1bnRob3JwZSA8
bG9nYW5nQGRlbHRhdGVlLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEpvaG4gSHViYmFyZCA8amh1YmJh
cmRAbnZpZGlhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
