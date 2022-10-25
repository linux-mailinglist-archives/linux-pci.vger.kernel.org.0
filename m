Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E496760C112
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbiJYBcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 21:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiJYBbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 21:31:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DC4D15F;
        Mon, 24 Oct 2022 18:09:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLUmpzQuDSoBLjYtIODOndvRNPCeQtutiIsP99XHrdiTDtnLqD+vAr1yiINeiDf3Br/YMxqYjfLjy5r3jbebg33kLHCRuuFndKKe6Bb8B2WOcYOhA9YTA2DElmLlYsmMj9Z61mG6moQMsgM9ia7ry1oQPoOQW6SkXPRY1vpRWZOlnoAbrQMAfzQtSGcU43mlnNuOvTjjuGdrdz4J5HNUupIytiuFXeOOk9UQFy/GbkjWFUjKeZ4zB0QMjk2iX+odlNXuEzdbioQATL8kU9fwb6YHzz1E7pondKS/pTmnGgVY/wA9RdOJvJvei2+licynStg77BQRq0Sa9EFrD1VW1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnM2noRk1VmX10dqSK0nEXPArugJ7+owIN/tz4mc9uE=;
 b=YB0fCBn1eBe4Fu4e9VwQzJvH/eO+qWoQskv+pCcD4rslfuXQBH5sISILPgfXbHZwu1bb4mSn/8BmIOyaJVowC8PmM8v3ohaVD9RJsDGWIq0h2tCAf9rSbLdk7k3+t2W0nRWezHBxsbK/HOyaDx2KKVi/UaKjYR/DY6HTHDTd5mNbyp/eeS/5VgKQHW/zTv/pBGGTRNbgB8CkfSNDwQf/A6CDFcPlcbkRKhvKE9Iue+17qn38sSEBGUcjt3n7J1eEs3vQxlWQl5PwK+QwczGllEd7gLygEOp7tTBslZr6GdDtLXJdZRjbCyDLO0ADZLfHUXRpraBVvao+JfvDub03Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnM2noRk1VmX10dqSK0nEXPArugJ7+owIN/tz4mc9uE=;
 b=ZwFl6RWJ7VDbUAKmMBe58c1SiIrtUbHkkH5FxIUEF/3mTCjO5l6We5I6SYFg6XvzJfPcigX0ZmCFX+o0C8S70DF1+vvnEMyx0xUE7EEoVabIA+8G4FHRNXCagFWSkY0D0X7g8lnmTedSouCwHAMAh6vvh45OKhjuQQAu2QUFu8BVBeCXZSzXml8hR+VGngSIBNj6F2fw4RBDMYpkwJV+w/FoaRSkb7jQlv8rFKyCxPX4AYA5mXeP1/Bb4YPIoGILxcypKyOHELC20TPXdalO4OwteQF7JpxbZ2cDOkSOXYmE+HTAiH1J/XNQ9arfGN336/2LyYrK741yRMQm3sn/iw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5947.namprd12.prod.outlook.com (2603:10b6:208:39a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 25 Oct
 2022 01:09:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 01:09:15 +0000
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
Subject: Re: [PATCH v11 2/9] mm: introduce FOLL_PCI_P2PDMA to gate getting PCI
 P2PDMA pages
Thread-Topic: [PATCH v11 2/9] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Thread-Index: AQHY5XReK41VrZi1Rk2mCnW4QEZAD64eUeIA
Date:   Tue, 25 Oct 2022 01:09:15 +0000
Message-ID: <42903f08-ee07-8d72-dd35-ada320695e20@nvidia.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-3-logang@deltatee.com>
In-Reply-To: <20221021174116.7200-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5947:EE_
x-ms-office365-filtering-correlation-id: b255a824-c04d-400a-a002-08dab62588ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ly8q+tPPlxHX3dvHKROvAOWzB7hzUpI7e4iaMGE3zgTAChb6CMlOAzR/QHW+sZSW3h7Vqpu/mdmgM6Uklq0ZhAaqvnNTyrOlph63E4Z7zCftVVIpt3/x3GAE2IeVL2lawo8vHqjZi60lww+UAqzRQT46/WQmeBrkkEv1Ab6Vz6F3eiz1I+oCeWkNCpdvYbu3Vo9V0sISumkBwf9sU0d7kAWuukZwHUzsJJav9QxtCHkKEVpaRyWlLmzd+6U8+absZMPezXNWauAszF8noy8WF8Wwfnx8DCQPvRnqPqL+kB/d/JoCLXPNP6zvy62WR8fVTenioQlL4dGK9zCuzrzsgTG8lOxy9Jkn8AqjgCXcwQGcN4YMuXSpFC+nP8Zj/6zioanOLNf86Q8WtUlFtqLjsKojDook4HevwJ6jFOILZkH3TAXe9TmdUoKkFBsDK6mY74vG4++I8yv1nGan02kShn0lxSbX2GI4PlL7zK9WsP4Fk75pIghw/10UUSe15KM2stzP8wmhHuuXhMUXfk72lPL+ExXGCkG2A1mjq2DTRfDQ23X33lEsgrC/MKP8j/WmI1FmEa3YT0ONdFLJL024qt4hT45oWDWURReioG8WkOuXdBJUJ255bPqtOioYappzkAAOcN/7/4lr33JFCTy+7B1aib30zavaLJV1oLkJq+PpUSRIeto2ROZA4k9g+QhR7VqJLD5Qkn9xpR8eMxZAoh/qJ99+krkCsmrAUq1PC4Md8l0VB93eQi3S0+xzlrMNks2+DRkjndFcK7Ibku1buKYavayP1wZjvid/7523oD0WrNCoydm+cMZPBUxiq0/P44O6jQDbbt5BEGk0rbg2h+MPku4sWPJHaJffy9xhwayXCNIY7ufKm18D2LsDIkRGWjP/pw/3M3hi2qUtS853ck/YXxxM198BjzPFjwLAqyM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(41300700001)(7416002)(91956017)(31696002)(66556008)(8676002)(6506007)(66476007)(66446008)(36756003)(86362001)(38100700002)(5660300002)(76116006)(66946007)(2906002)(4326008)(6486002)(83380400001)(966005)(8936002)(64756008)(6512007)(38070700005)(122000001)(186003)(2616005)(54906003)(71200400001)(316002)(478600001)(110136005)(53546011)(66899015)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXM0VG1OaFlaQkZrc05sL0VhYmRhL2FrajY3SEtIU3BUemFkcExXUkpWR3hq?=
 =?utf-8?B?dEpEdUdDVHJyb2xMakVLWTMvK2JUMGt5ZGRUN1FONWtCRkxmblhMZE1FMWF6?=
 =?utf-8?B?WkJqWWhnY21pNnFKNVMxN09md2FiYjl2eXE3NVhQbzNGZWsydXJrcVJZeG5v?=
 =?utf-8?B?MUtyb2dHa2NEQ3hySC9XaFJLRzkxbmlKU0FhN0FBRDMwUEZIaFVxcnRBOGhE?=
 =?utf-8?B?TzJhTnRma1RSZlB6VWw2NjJYRXVmTmRPVE9OdW1LRFRNU2MycnRPVkM5SGRL?=
 =?utf-8?B?aFBhSUEwdldQQWt0TTFmdHN5T2NQb1lMVXpLZzdjZVBxZlRvK0Q4eVVIa3lt?=
 =?utf-8?B?ZkY4TklSbXRyeDFQUms1MDFUU1V4MDJGaW96UlI1TFdCd0kxSTFSSlFmRHFV?=
 =?utf-8?B?SG1PTnF3S1VJaWk2b1VzemlWalhCSjB4bktmVndFU2tjUHpWTVRsY0RoTE05?=
 =?utf-8?B?c3M0a3lQQ3VJUloybGc2T0psN3U2YWoxeEM3WkV3eHhhZ2RIRXRLRFB3OTNn?=
 =?utf-8?B?WU55alk1RWw0R25GV3ErYW5BOW8xbDZEc2p0OG5XZ29jTzJSY2NZZy92ZktH?=
 =?utf-8?B?SWhkZENseEsyZnN3Mk1ERXZEUGhlQm1QdW0wQ0NmaWJsWiszS1F4WjZRVUdE?=
 =?utf-8?B?bW9ZVk1tMDcrNUtORDVqVmM3NWNHMmZQb2FPSU1yOW5mL0ZtOVZ6MVBsaXhU?=
 =?utf-8?B?NkZSWmx0dGhiUzRvdk5jS2dWbldJdUFuU1Z0YUxpTlR2WGxLbU5uZ0VOdnhs?=
 =?utf-8?B?OFR5T1BLY1BaL2RJRlhMNU1VeUxMS29KZUlyQ0RyU0dXY2FuK3V0ODJjSCtL?=
 =?utf-8?B?N0orM2ZPUm82enZEMmtqeVc1dWI5QjAvWWVOblBlUzhEL0hQd2J4OE5NUWNS?=
 =?utf-8?B?NEkzTERETVFQQWp4NWhUS294eWo1M3JnbXZGb3pWOEZLRG5zb3NFUWk0UU5O?=
 =?utf-8?B?UUg4Yi9hTDJzeG9zdE05ZkROOVVrWE05OWlhUFhPN2J0YXlwd0RYU1lSblpN?=
 =?utf-8?B?MXN5dEQwVDBGTnhJTytYaFQ5Q2lLZHI1QkN1V3dnQnNVTHEwS0VIbG8zekRP?=
 =?utf-8?B?NHRSdTRaRWN4V1NlVFZtUmwwbXhNRE9XRS9PS00xNmpYOXU2WWlhSU82RE5S?=
 =?utf-8?B?anRIYlZibTJGYXNJdTNzMXRCVG5rM0dkMHVBWVE4aGZ4TFg5MUtpK2c3eEZL?=
 =?utf-8?B?M2V3ZFBJcjZsTjYxUXVtVk5VeExtclZqNE9abFlYNkJ4R0wvOHhmcHhTM2No?=
 =?utf-8?B?dEltQXNGQnExUnJWaHg4WlZFVjltRUlTSXg2K0FQQ2pSbWpqQ3BycjBnWGVK?=
 =?utf-8?B?cHAyc3dJOUlLcXJVa0pwM1VtU3NmVElqU01KcEY4RnVQT2UxTEJVbVRQbWdt?=
 =?utf-8?B?ME94MGpVT1VpeHNQMktyM2h4eHdqNGN0SUV4NVZGcGM5a29MeFBqcjlIZWpo?=
 =?utf-8?B?UTU1SlZKaGNHbkEyQk45VVRkMDhKenRWTXdidGJSM0hpbUdqVU0vWWNQOVUv?=
 =?utf-8?B?STMyWHp5WmlZRWhXWE9Xd2daM2pYaDBLd2Rtb3M2ODRES1EvM0ZKV3V3dXht?=
 =?utf-8?B?aW9UZnJJdWNjUjZPZjMvU2kzTE1mZWY4THcweGdhODduZFRLaTF6eGxGZWFE?=
 =?utf-8?B?MnhiVEVHcFpTbGl0dTJlWE14SkhxTDBmTk9OTTdLSm5aQ3ZJQndTbjRYWWVS?=
 =?utf-8?B?TTN1T1V2c2Q3MzA1NHovZy9WcUZ1cVJSRmFsNkNpdUdkQWJqaWJKTHQ3MHY2?=
 =?utf-8?B?WHh6QnZEU2p4NjdkVlVGdXhZdjRCdGZhcUFZWmdDc01Rd1VRdTJuR0dycm51?=
 =?utf-8?B?ai9kME43L1lSb0pXRjRVTkhnVWlyRWpmMkNLeXJZV2o2cFc0M2ExUVdrRjdj?=
 =?utf-8?B?Zmt0ZHFRUGpMbk9nOTV5SUxwNEltYzRDajh3T3BzTTdObmJ0V3RwYmVtK3l2?=
 =?utf-8?B?dHFIVkFkWjVQbTlldGxieGxJRkhVNXVCNFUrQWRCUmhQUFVXN1JCYTRRaTlQ?=
 =?utf-8?B?UURvNmE0aGdzcHlCNCtBaFJncEhiWG5kZUF1K1JVNDJIUC9GYTA4RkF6R25x?=
 =?utf-8?B?L3publZlTWd4bktxRmo0c1FzN2VpeHh2Ynl6clBjbXRWVWp0UmR6TFovbjZL?=
 =?utf-8?B?Mk5VY3BySUpzbjRPMHpyYlY5dWVMc0ZKdVltYkQ5dHN2TFpQaEhkTFdsb09i?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71ABE54E1E374648A3A3711B5C5BF805@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b255a824-c04d-400a-a002-08dab62588ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 01:09:15.1165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdBWPYiOJmzTjR2gTo2ZIaOvhytbAh2qHkLyWvrez531/wQTqgE5GPbUYC2SM82dmFQA0LS8L5d2EHSDQhaa1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5947
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gMTAvMjEvMjIgMTA6NDEsIExvZ2FuIEd1bnRob3JwZSB3cm90ZToNCj4gR1VQIENhbGxlcnMg
dGhhdCBleHBlY3QgUENJIFAyUERNQSBwYWdlcyBjYW4gbm93IHNldCBGT0xMX1BDSV9QMlBETUEg
dG8NCj4gYWxsb3cgb2J0YWluaW5nIFAyUERNQSBwYWdlcy4gSWYgR1VQIGlzIGNhbGxlZCB3aXRo
b3V0IHRoZSBmbGFnIGFuZCBhDQo+IFAyUERNQSBwYWdlIGlzIGZvdW5kLCBpdCB3aWxsIHJldHVy
biBhbiBlcnJvciBpbiB0cnlfZ3JhYl9wYWdlKCkgb3INCj4gdHJ5X2dyYWJfZm9saW8oKS4NCj4g
DQo+IFRoZSBjaGVjayBpcyBzYWZlIHRvIGRvIGJlZm9yZSB0YWtpbmcgdGhlIHJlZmVyZW5jZSB0
byB0aGUgcGFnZSBpbiBib3RoDQo+IGNhc2VzIHNlZWluZyB0aGUgcGFnZSBzaG91bGQgYmUgcHJv
dGVjdGVkIGJ5IGVpdGhlciB0aGUgYXBwcm9wcmlhdGUNCj4gcHRsIG9yIG1tYXBfbG9jazsgb3Ig
dGhlIGd1cCBmYXN0IGd1YXJhbnRlZXMgcHJldmVudGluZyBUTEIgZmx1c2hlcy4NCj4gDQo+IHRy
eV9ncmFiX2ZvbGlvKCkgaGFzIG9uZSBjYWxsIHNpdGUgdGhhdCBXQVJOcyBvbiBmYWlsdXJlIGFu
ZCBjYW5ub3QNCj4gYWN0dWFsbHkgZGVhbCB3aXRoIHRoZSBmYWlsdXJlIG9mIHRoaXMgZnVuY3Rp
b24gKGl0IHNlZW1zIGl0IHdpbGwNCj4gZ2V0IGludG8gYW4gaW5maW5pdGUgbG9vcCkuIEV4cGFu
ZCB0aGUgY29tbWVudCB0aGVyZSB0byBkb2N1bWVudCBhDQo+IGNvdXBsZSBtb3JlIGNvbmRpdGlv
bnMgb24gd2h5IGl0IHdpbGwgbm90IGZhaWwuDQo+IA0KPiBGT0xMX1BDSV9QMlBETUEgY2Fubm90
IGJlIHNldCBpZiBGT0xMX0xPTkdURVJNIGlzIHNldC4gVGhpcyBpcyB0byBjb3B5DQo+IGZzZGF4
IHVudGlsIHBnbWFwIHJlZmNvdW50cyBhcmUgZml4ZWQgKHNlZSB0aGUgbGluayBiZWxvdyBmb3Ig
bW9yZQ0KPiBpbmZvcm1hdGlvbikuDQo+IA0KPiBMaW5rOiBodHRwczovL2xrbWwua2VybmVsLm9y
Zy9yL1l5NE90NU1vT2hzZ1lMVFFAemllcGUuY2ENCj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3Vu
dGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQo=
