Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5368A6F229C
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 05:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjD2DQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Apr 2023 23:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjD2DQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Apr 2023 23:16:15 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8411C30D2;
        Fri, 28 Apr 2023 20:16:06 -0700 (PDT)
X-UUID: 29903f0ee63c11ed9cb5633481061a41-20230429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3q7yYXF8JIbhMAqYk6ZQHngYDkP3iJQTlehc68zOJ1M=;
        b=gB2KGyhWm3IlShnwsT0qczmCpRc/LUhxqT6VkicRnDEFn29znXHhrNuD9HpeJqfRXzw/e29ilzSaflVtuYuCP9Wdk2oC6tRTSH/xLHZfzTiplwd8pM8j72MK+e+4idRkZVZyxqypJjl0k8ixYVBlYwiAL56UyRAs9AFe+ltbKEQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:39c3f78c-6b5f-45d4-a073-80598f999387,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.22,REQID:39c3f78c-6b5f-45d4-a073-80598f999387,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:120426c,CLOUDID:bf7c4cbf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:2304271631157N1NB920,BulkQuantity:16,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 29903f0ee63c11ed9cb5633481061a41-20230429
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1970040432; Sat, 29 Apr 2023 11:15:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sat, 29 Apr 2023 11:15:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 29 Apr 2023 11:15:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCfzqnDaugwuMqwFfxY5xP+phWsE5L7KNKInBqOtzfv2HwKCdRAUrk6Wc069ym5zKWOtPjLNURS4P2FCQ3Vy4EHQ3Y+/dN5ABJc1FyE3QNLDSaIzeDdLQGilvfKQJySz2jtay5sQDdQwyLf7AiBx4fci3Vrsdi9wphcX7e7pgVYI4QIqWjDTjTgVC0xoRvAkYmyK5ZXLUDvIfY+UFFJwFq0bdqHH2ucrjnAKBc+wd6H+/T8FbdXcglB5oOmOpja4OzdabBrFJ4c+/6xgVoFZRkUHWUb5HpsvWCxUBvrvD3Kkrxo0QGKYUAbnzzhZL1naaBMYhy6sCu0xai+bawc0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q7yYXF8JIbhMAqYk6ZQHngYDkP3iJQTlehc68zOJ1M=;
 b=ShtDof7TtarWovIriOgyCYmAR4iUOa9EbNyvkRwXW4EYEKV/SiVMBy1OkySN4Ah3ZsHLLuR6FcGwzBDMJ4ZJYYwOCKjFpChESu4lRiGyh6b1FgzD8u7ObN1x8WmzThqsckOwganO4VDP3mgZXzgWDKHZR91JgykaeUHlz3gd1lVgvpZzyhmm11T2IQZEDAXWCpGPfC/MJOszmeaUalM+I0Xphu6EBHPdholgX5jjb5qZLNntCHIrYPbc+WAdcoiSlT4EkfBLIhnU668m0+OzpjvW9yxLU3XLNGFGtPgcOYWCpEw51MIaNeodkYWBs+y0i6myFwWjIvz0J5vicLFCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q7yYXF8JIbhMAqYk6ZQHngYDkP3iJQTlehc68zOJ1M=;
 b=WvQx4WHjZXKOKn8m70wjoF57rylXBgHPkT3I8bRh2eve7QpdEESsLTBHnPXJs7qB/v4dHDP5HkQgEUKEuKSaa/dXdDPeQ+lIn84wg6QJCrA1+spM1E3pKo+O7VmN2ZizmlUryaMYJ8oqwFCtYrnA0Ye76/0reyvJ7/opbklE1dU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB6787.apcprd03.prod.outlook.com (2603:1096:101:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Sat, 29 Apr
 2023 03:15:53 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::6eca:1bb6:7d2c:a4e0]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::6eca:1bb6:7d2c:a4e0%6]) with mapi id 15.20.6340.024; Sat, 29 Apr 2023
 03:15:51 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "linux@fw-web.de" <linux@fw-web.de>,
        "frank-w@public-files.de" <frank-w@public-files.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?SmlleXkgWWFuZyAo5p2o5rSBKQ==?= <Jieyy.Yang@mediatek.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: Aw: [PATCH] PCI: mediatek-gen3: handle PERST after reset
Thread-Topic: Aw: [PATCH] PCI: mediatek-gen3: handle PERST after reset
Thread-Index: AQHZZWUN3oyBy4cfO0S7ujfcGrEDja8+AfWAgAD4eACAAWWFAIABZxAA
Date:   Sat, 29 Apr 2023 03:15:51 +0000
Message-ID: <cd7c2672cc7cb97086cdb8d2079ad38c7fd6367f.camel@mediatek.com>
References: <20230402131347.99268-1-linux@fw-web.de>
         <trinity-8c5502f4-34bc-456b-9e4b-37edac37c3ed-1682530907724@3c-app-gmx-bs05>
         <74149a72313c1b944c870a45b55893e1b9331c8e.camel@mediatek.com>
         <EF6EF3CD-5741-449E-B7E0-27DF9A6C297D@fw-web.de>
In-Reply-To: <EF6EF3CD-5741-449E-B7E0-27DF9A6C297D@fw-web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB6787:EE_
x-ms-office365-filtering-correlation-id: 666e7716-0a6a-4545-a92a-08db48600965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Pr8Evs9YZ1LsxI80dQMXLKe+ZHE+bVKBXov+D/fmdRf/TJkGiiICTFamX7abt5XZ6koavYaeCrMuVRYUvUuUcz3Qk6kWahPyOhFE4wftIYAQxmGBtnHdqqWi8qVY7fnSeyh9S4ZitBVZZMbJTRzaIn8BHe/vvoSdzSED+EIY9bGVBE7cDTyvgkYgrbTx3VBn2cTscZobqLIwCEzt3eDPkMX7RJr8CPMqvR325ge67Ky8yX6P49ths/G4GtQyA/KtfNgk8wdVIfW9ZZ/d9BSQsxCBfbYT2EBh2mIQZsn+LIYlmswpf2+CFwIwG+WD9GUZD55KLgVuTFxq1Qw5en3BwkVklSyXzxNNtpll8hyBSFBYRrsA6HShpY1Oy0XgfVEJ3Vbs0dPaRxKNLJxB6erUm9VmRksbUTGYJQn4usNxO6pKB06gGL4RGgvSwG3t4JEQuq8DyDcNC8p2rjiAGYqaP8z3PJha3ntfqvAFUbNz9DfgoT27JYf2WRZGvtjsmRtdzpZbgWGKyEYNW89A12GTzeO70Dpvi67yRcc9GS5/MvmXMYCVAH7OwqHTfMMlUXfyxbbrIwJOWeJruq20+AVZTz+ZLSbXEzrEixgfepOHOX3289egWJdG7oYy63WJH6BLjCzJLhtVzE0qMpR1CAcgeOEd1oFlJrlTIYQJsjtrp8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(84040400005)(451199021)(5930299015)(86362001)(38070700005)(36756003)(85182001)(2906002)(71200400001)(966005)(186003)(83380400001)(2616005)(6506007)(6512007)(26005)(64756008)(66476007)(66556008)(66946007)(66446008)(91956017)(4326008)(110136005)(76116006)(478600001)(6486002)(41300700001)(122000001)(38100700002)(5660300002)(316002)(54906003)(8936002)(7416002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFh5WkdoaVIzeU9pRXZZQjBsL2pMam1XTUtIS1hrSWlJbWVMMFcycWRockIw?=
 =?utf-8?B?NDBXckFoU0wvL0lnVjl3V2xESzRnOVMrc0xlWTJnaTRFNnJWOEE4dmhsVGlp?=
 =?utf-8?B?NFRLS1dKQTJVTCttNUVodzcyT0ZZWUJ6R05UeEZxRCtiME5OSjBIc2NhZVht?=
 =?utf-8?B?dU9RaUpoRllsQnFOZm8wY293OGlGWEdEb3BlbXJLQjBaYzdWRFFmaHJYb01l?=
 =?utf-8?B?MmlRa21IUTNCT3g4THB2WUU3dGNEZ3ZZbFhPMW5wYmZ3OTBhbUlJV2RSMEY3?=
 =?utf-8?B?dzNrNy9DOGdZTUlhZmExa2t1anlNd1dzZEwrYlhhbWJ3VThYVUVWZzNOT3du?=
 =?utf-8?B?b29jMmMvQkJjSkhlSVd6d3JLS2hjWXlvOTVlbGNlalBMcFh6TEVBTU4wdGhi?=
 =?utf-8?B?TDM4MHFJTkxVUUlsZm9PWW11aEVmZExkSjRZMzZmR0hralNUZWFJM2RXNkp6?=
 =?utf-8?B?VjlLWTlCa0o5Njg3WVdIa3k5SFhEOFB3YUtrVDQvRUlNTmNrRFlkMHJHYnBD?=
 =?utf-8?B?UG5ueWlvMkdIZjBkc1c0WERkYWhxYVFiY1Z0SFZ1bkYrVGZ4WmNGOU5ncHlO?=
 =?utf-8?B?Y1hXQUZlejA2Nm9HVDVYTWluMTNXRVNSbXp2clExUnBTUDM2akdsNmJmSG9Z?=
 =?utf-8?B?SW1HamtVS2ZoVGcxcUZxTkw5SDZlMlhkaTVIMFpXU1AxYVgzalhmRlZDZzFD?=
 =?utf-8?B?T2VxanE2ZHZ3SFk4R0hucUVVME5kSjBrR29DTURra2V6aWV4bk1oMUEwR0tt?=
 =?utf-8?B?YnlVNGJXd0NEWnN3ZlduTXpuL2hNYVE2M2NDSFF5c1MzbHIvSW5nK3NkeWlh?=
 =?utf-8?B?VGJiUnp4UDRDcXFQdG9taCt4Nkw1TnhmcDFYSEFHRytnelFxMUhoZkNnbzNq?=
 =?utf-8?B?ZEZOcEp6bWx5OTQwcDdjK2liVGh1RE5yVHJsZmVzV1RGS3I2UkhvMXZLTHRL?=
 =?utf-8?B?OFlRaVo2cmdQeEMzYzl1RVBqZnArcjVGQWVuNGJjbTQ4Q3JaNE14bVdOcjI2?=
 =?utf-8?B?Y0VaSSs5a3RBc2hGZndMbnB5aUNGNmozSXVXaE9aUW0yMElwMDJlT0RDS3NM?=
 =?utf-8?B?RzlyRXduUHBlcHd6c3FSQjBWQm9WdVoyZ2xnM1A2dHViRmtacDkzTWF6M09U?=
 =?utf-8?B?K04vZk9Fd1lYUUVZVUF3RGNEdG84OU1vTlBWWGVDTGVmQW1kMVFHZGZMdHJt?=
 =?utf-8?B?R0ppdVlGaVphdXFHa3g4OUsyOVMwRm5pdEw2amhkWEJ1amtWS3d3aHE2N0ZV?=
 =?utf-8?B?d1c2NVRmMEhXTm1LcC9BOHRPY2pBdXlscUR5RTBmV1ExZk5UQWUrdk9IS2Zo?=
 =?utf-8?B?dkIzdGpreElqdFNRT2tHSEljZG1ZWjZMKzNZemxSVExpMEFEU3FHM0hzTEEz?=
 =?utf-8?B?ZkNpN3BJRXFKWHphUmE4NWI3L3dVeHlPK0JYaHJXcUZ1M05EZ0NOL3QyQkxX?=
 =?utf-8?B?aWdyMXpHSXg0WHJuTUFkK0UySDV1Q0lxM2RMMVBGYlB1VitrNFZraHRwK1Bk?=
 =?utf-8?B?cEZZek1BWk11anAyUjc0MkhtQkJBZEswcDZCbWpWWWVmOEpuaW5mbjBkVWhB?=
 =?utf-8?B?SjlqTjYyKzFuMEtJMFBMcEtjNFhiMWJhVTdGY3d4emhaSlJVYU5MaFpQd0ls?=
 =?utf-8?B?MDZ4R1c3V0pWdTNRQmFTVnl0cDlybG5QdE5PSDE0aHpyS2VTbnZzd3BmeGpi?=
 =?utf-8?B?aWY5RDRwZzdWKzROVVkzVkFtK2tWL0txUC8veGdsUDkvcGY2WSt5VUtEWUt6?=
 =?utf-8?B?bm5XSllJY0syTi9UVWVGYnFBb2RPRVc5N2dNbVpaRHYzUjJpV2hNdjkrUEI0?=
 =?utf-8?B?eFlpaHMyMy9lVjNjK0N0VEJCQUx0bFVuUTFrVS82cWt6TnJCMUlGQmRhakZ6?=
 =?utf-8?B?SkpqdGhtLzRHLzFJVmo5TVNuaDJ1UDVCRVhYK2lkMENUUXI5Wnh0ZlozOHo1?=
 =?utf-8?B?SnJ3dEtjZ3hwTEY1NWNRZFh1UWgrUnJxbWpKRUxIRlNYVnVQbmJKVk9SOWpr?=
 =?utf-8?B?RVoyVFhsdVFEL3llRmE5Y0dFeXhPdzFSZWdsNmZDcXhFdjQ4bnJZVVBoYmpV?=
 =?utf-8?B?L0dPZEJIN3FDT2pTalE3cHRybVI4WjJxN2FLRUZjK0NYYkIvYzZTMnZmYTls?=
 =?utf-8?B?OEo1bm90Y0ltaGsrbENCV3NHYldteUhyb05EVFpEOXlwS1VFSW1WTU5RcjNX?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <509DFD742595AA489C4732245DAB63DF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666e7716-0a6a-4545-a92a-08db48600965
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2023 03:15:51.4718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwM/veijk1y/zoAoSI6la1JjhbVE7dVeHmm0eXOwR+Pvtg35aAX1L5eAx56oInUPpuy/jL40I5Q8I2pMKmUSKcAfq2ll2mE9ztwMQL9lFJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6787
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgRnJhbmssDQoNCk9uIEZyaSwgMjAyMy0wNC0yOCBhdCAwNzo1MCArMDIwMCwgRnJhbmsgV3Vu
ZGVybGljaCB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNl
bmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBbSAyNy4gQXByaWwgMjAyMyAxMDozMTow
NyBNRVNaIHNjaHJpZWIgIkppYW5qdW4gV2FuZyAo546L5bu65YabKSIgPA0KPiBKaWFuanVuLldh
bmdAbWVkaWF0ZWsuY29tPjoNCj4gPiBIaSBGcmFuaywNCj4gPiANCj4gPiBTZWVtcyB0aGlzIHBh
dGNoIGhhcyBodWdlIGltcGFjdCBvbiBib290IHRpbWUsIEknbSBjdXJpb3VzIGFib3V0DQo+ID4g
dGhlDQo+ID4gTlZNZSBkZXRlY3Rpb24gaXNzdWUgb24gbXQ3OTg2LCBjYW4geW91IHNoYXJlIHRo
ZSBTU0QgbW9kZWwgdGhhdA0KPiA+IHlvdQ0KPiA+IGFyZSB1c2luZyBhbmQgdGhlIGJvb3R1cCBs
b2dzIHdpdGggdGhhdCBTU0Q/DQo+IA0KPiBXaGljaCAiaHVnZSIgZGVsYXkgZG8geW91IGdldCBp
biB3aGljaCBzZXR1cD8gSXQgYWRkcyBhIDEwMG1zIGRlbGF5DQo+IHllcyxidXQgdGhpcyBzZWVt
cyBuZWVkZWQgdG8gc29tZSBkZXZpY2VzIHdvcmtpbmcuaSBmb3VuZCBzZXZlcmFsDQo+IHNvdXJj
ZXMgdGFsa2luZyBhYm91dCB0aGUgMTAwbXMgd2FrZS11cCB0aW1lLi4uDQpTb21lIHByb2R1Y3Rz
IGFyZSB2ZXJ5IHNlbnNpdGl2ZSB0byB0aGUgYm9vdHVwIHRpbWUsIGVzcGVjaWFsbHkgdGhlDQpw
bGF0Zm9ybXMgd2l0aCBtYW55IFBDSWUgcG9ydHMsIGFkZGluZyB0aGlzIDEwMG1zIGRlbGF5IGZv
ciBlYWNoIHBvcnQNCndpbGwgY2F1c2UgdGhlIGJvb3R1cCB0aW1lIGJlIGluY3JlYXNlZCBieSBt
dWx0aXBsZSB0aW1lcyhkZXBlbmRpbmcgb24NCnRoZSBudW1iZXIgb2YgUENJZSBwb3J0cyBpdCB1
c2VzKSwgYW5kIGFsc28gdGhlIHdha2UtdXAgdGltZSwgc2luY2UgdGhlDQptdGtfcGNpZV9zdGFy
dXBfcG9ydCgpIGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVkIG9uIHJlc3VtZSBzdGFnZS4NCj4gDQo+
IEkgZG8gbm90IGhhdmUgdGhpcyBpc3N1ZSxidXQgc29tZSB1c2VycyBpbiBicGktZm9ydW0gcmVv
cnRlZCBpdC4NCj4gUGNpZS1jb250cm9sbGVyIG9uIG10Nzk4Ni9icGktcjMgZG9lcyBzaW1wbHkg
bm90IGRldGVjdCB0aGUgbnZtZSBhbmQNCj4gcmV0dXJuZWQgRVRJTUVET1VUICgxMTApLg0KU2lu
Y2Ugd2UncmUgYWxyZWFkeSBjb21wbHkgd2l0aCB0aGUgUENJZSBDRU0gc3BlY2lmaWNhdGlvbiBz
ZWN0aW9ucw0KMi4yKFBFUlNUIyBzaWduYWwpWzFdLCBhbmQgdGhpcyBpc3N1ZSBvbmx5IG9jY3Vy
cyBvbiBhIGZldyBwbGF0Zm9ybXMsDQpJJ2xsIGluY2xpbmVkIHRvIGl0J3MgbWlnaHQgYmUgYSBz
aWduYWwgcXVhbGl0eSBpc3N1ZS4gQWxzbyBJIGNoZWNrZWQNCnRoZSBCUEktUjMgc2NoZW1hdGlj
IGRpYWdyYW1bMl0sIGFuZCBub3RpY2VkIHRoYXQgdGhlcmUgYXJlIG5vIEFDDQpDb3VwbGluZyBj
YXBhY2l0b3JzIG9uIHRoZSB0cmFuc21pdHRlciBzaWRlLCB3aGljaCBkZXNjcmliZWQgaW4gUENJ
ZQ0KQ0VNIFNwZWMgc2VjdGlvbnMgNC43LjEsIGJ1dCB0aGlzIHNjaGVtYXRpYyBkaWFncmFtIG9u
bHkgaGF2ZSBwYXJ0IG9mDQppdCwgY2FuIHlvdSBoZWxwIHRvIGNoZWNrIHRoZSBib2FyZCBkZXNp
Z24gb3Igc2hhcmUgdGhlIGZ1bGwgc2NoZW1hdGljDQpkaWFncmFtIGZvciBmdXJ0aGVyIGFuYWx5
c2lzPyANCg0KWzFdOiANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tZWRpYXRlay1nZW4zLmM/aD12Ni4zI24zNDQNClsyXToNCmh0dHBzOi8vZHJpdmUuZ29vZ2xl
LmNvbS9maWxlL2QvMW14S2I4Q0JibnpmTlNkXzRlc21jWF9Ob3Z4YVhqRWI4L3ZpZXcNCg0KVGhh
bmtzLg0KPiANCj4gIyBkbWVzZyB8IGdyZXAgJ3BjaScNCj4gWyA1LjIzNTU2NF0gbXRrLXBjaWUt
Z2VuMyAxMTI4MDAwMC5wY2llOiBob3N0IGJyaWRnZSANCj4gL3NvYy9wY2llQDExMjgwMDAwIHJh
bmdlczoNCj4gWyA1LjI0MjkzOF0gbXRrLXBjaWUtZ2VuMyAxMTI4MDAwMC5wY2llOiBQYXJzaW5n
IHJhbmdlcyBwcm9wZXJ0eS4uLg0KPiBbIDUuMjQ5MjM1XSBtdGstcGNpZS1nZW4zIDExMjgwMDAw
LnBjaWU6IE1FTQ0KPiAweDAwMjAwMDAwMDAuLjB4MDAyZmZmZmZmZiAtPiAweDAwMjAwMDAwMDAN
Cj4gWyA1LjQ3ODA2Ml0gbXRrLXBjaWUtZ2VuMyAxMTI4MDAwMC5wY2llOiBQQ0llIGxpbmsgZG93
biwgY3VycmVudA0KPiBMVFNTTSBzdGF0ZTogZGV0ZWN0LmFjdGl2ZSAoMHgxMCAwMDAwMSkNCj4g
WyA1LjQ4NzQ5MV0gbXRrLXBjaWUtZ2VuMzogcHJvYmUgb2YgMTEyODAwMDAucGNpZSBmYWlsZWQg
d2l0aCBlcnJvcg0KPiAtMTEwDQo+IA0KPiBPbmUgc3BlY2lmaWMgaGFyZHdhcmUgaXMgcmVwb3J0
ZWQgYXMgZXhhbXBsZToNCj4gDQo+IEFkYXRhIExlZ2VuZDcxMCA1MTJHQiB4Mw0KPiANCj4gPiBU
aGFua3MuDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIzLTA0LTI2IGF0IDE5OjQxICswMjAwLCBGcmFu
ayBXdW5kZXJsaWNoIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiAN
Cj4gPiA+IEhpDQo+ID4gPiANCj4gPiA+ID4gR2VzZW5kZXQ6IFNvbm50YWcsIDAyLiBBcHJpbCAy
MDIzIHVtIDE1OjEzIFVocg0KPiA+ID4gPiBWb246ICJGcmFuayBXdW5kZXJsaWNoIiA8bGludXhA
Znctd2ViLmRlPg0KPiA+ID4gPiBEZS1hc3NlcnQgUEVSU1QgaW4gc2VwYXJhdGUgc3RlcCBhZnRl
ciByZXNldCBzaWduYWxzIHRvIGZ1bGx5DQo+ID4gPiA+IGNvbXBseQ0KPiA+ID4gPiB0aGUgUENJ
ZSBDRU0gY2xhdXNlIDIuMi4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgZml4ZXMgc29tZSBOVk1F
IGRldGVjdGlvbiBpc3N1ZXMgb24gbXQ3OTg2Lg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IGQz
YmY3NWI1NzliOSAoIlBDSTogbWVkaWF0ZWstZ2VuMzogQWRkIE1lZGlhVGVrIEdlbjMNCj4gPiA+
ID4gZHJpdmVyDQo+ID4gPiA+IGZvciBNVDgxOTIiKQ0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBG
cmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+IFBhdGNoIGlzIHRha2VuIGZyb20gdXNlciBSdXNsYW4gYWthIFJSS2g2MSAocGVybWl0
dGVkIG1lIHRvDQo+ID4gPiA+IHNlbmQgaXQNCj4gPiA+ID4gd2l0aCBtZSBhcyBhdXRob3IpLg0K
PiA+ID4gPiANCj4gPiA+ID4gDQo+ID4gDQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3Yz
L19faHR0cHM6Ly9mb3J1bS5iYW5hbmEtcGkub3JnL3QvYnBpLXIzLW52bWUtY29ubmVjdGlvbi1p
c3N1ZS8xNDU2My8xN19fOyEhQ1RSTktBOXdNZzBBUmJ3IW5DWEVNNjg1cGtVcG9pWllHS3B0UFlj
Y05yV01lTjJEM2pJTzVfaXJ3eFpKN2M2WnpFZUFDSXgtVjJXZVpIQVBfMEZLbERESVEwUmJESjg5
MnBydG9Ub0R2MzAkDQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLW1lZGlhdGVrLWdlbjMuYyB8IDggKysrKysrKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+
ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+
ID4gPiBpbmRleCBiODYxMmNlNWY0ZDAuLjE3NmIxYTA0NTY1ZCAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ID4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gPiA+
IEBAIC0zNTAsNyArMzUwLDEzIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0
cnVjdA0KPiA+ID4gPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ID4gPiAgICAgICBtc2xlZXAo
MTAwKTsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAgIC8qIERlLWFzc2VydCByZXNldCBzaWduYWxz
ICovDQo+ID4gPiA+IC0gICAgIHZhbCAmPSB+KFBDSUVfTUFDX1JTVEIgfCBQQ0lFX1BIWV9SU1RC
IHwgUENJRV9CUkdfUlNUQiB8DQo+ID4gPiA+IFBDSUVfUEVfUlNUQik7DQo+ID4gPiA+ICsgICAg
IHZhbCAmPSB+KFBDSUVfTUFDX1JTVEIgfCBQQ0lFX1BIWV9SU1RCIHwgUENJRV9CUkdfUlNUQik7
DQo+ID4gPiA+ICsgICAgIHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfUlNU
X0NUUkxfUkVHKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICBtc2xlZXAoMTAwKTsNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAvKiBEZS1hc3NlcnQgUEVSU1QjIHNpZ25hbHMgKi8NCj4gPiA+
ID4gKyAgICAgdmFsICY9IH4oUENJRV9QRV9SU1RCKTsNCj4gPiA+ID4gICAgICAgd3JpdGVsX3Jl
bGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiA+ID4gPiANCj4g
PiA+ID4gICAgICAgLyogQ2hlY2sgaWYgdGhlIGxpbmsgaXMgdXAgb3Igbm90ICovDQo+ID4gPiAN
Cj4gPiA+IEhpDQo+ID4gPiANCj4gPiA+IGp1c3QgYSBmcmllbmRseSByZW1pbmRlci4uLi5kbyBp
IG1pc3MgYW55IHJlY2lwaWVudD8NCj4gPiA+IA0KPiA+ID4gcmVnYXJkcyBGcmFuaw0KPiA+ID4g
DQo+IA0KPiANCj4gcmVnYXJkcyBGcmFuaw0K
