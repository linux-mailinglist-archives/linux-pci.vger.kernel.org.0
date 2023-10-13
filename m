Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959097C8044
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 10:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjJMIbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 04:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMIbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 04:31:36 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87570A9;
        Fri, 13 Oct 2023 01:31:28 -0700 (PDT)
X-UUID: e48c0aa669a211eea33bb35ae8d461a2-20231013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NU9/QiMH288e/WezTjMGR7zn7MRyFMUPPu5o8ejgFkc=;
        b=A/BICU42kclo7j0GsE83npBWncvj9KmkNoe0K80ssgM077m1Dh/pnz3fWvJ0D6OBjcg2JIHTXJEe/FH50tyeu63dkHuGnvtoWr6bzN74+JJTCwYqGChtwDesHhUhgFIuSy/XT7YpAqinwdz2JKx83ZD7aDmUswfa+G3KD3cHb18=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:ba9107b4-7a37-402d-b91d-f8b25d1e73e3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:7aaefe14-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: e48c0aa669a211eea33bb35ae8d461a2-20231013
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 170564016; Fri, 13 Oct 2023 16:31:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Oct 2023 16:31:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Oct 2023 16:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T72Xr8QgIlKAmuEFmd8YPP70y6toViIGWLm1gpKOMGFRVFdXhuYTgelAiatJMDZpJJv48MqLmYeXXxTfw1cukmDn2UHRpfSpfhoXbvGVZ2HysEmbB+vQaIrka80HeEyae4h4jEXIqOwSuBHYiiWZSUpBsi/v30w6b6deCl0MwJKOIv41CFjyCZYF0YnpzcI3aEn3rtY8avBEBLCtOPbGRbxPZBEM33GXhIf2uL0kdRrimJa0CqrSXVJfWmf6FfuwVfp5jLiiZzxuQuXkL7Yk7tkTy2dXScEo9vzId8ptvKwrB/pYZOupO2zzh+n0S1YrPwMFmMsR9LQNO/PN7qMcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU9/QiMH288e/WezTjMGR7zn7MRyFMUPPu5o8ejgFkc=;
 b=eVy6ir/xP+KPnEv7xgMcqxQn7OEjUcUF4Ki/SqzFM/174Gj+rWfTrxxjEfw8Zv1G46NOwwE2sV4EJfVlcmz8Dk8qKwP6Neuk+JTjtuaJZTDgTSqqA7H1kIbmqKK9q9nIZQ/DBmcIUsMms2OVMdVVraq5grcAgH9C0JjyeyFivALKNMxQyHzo+KbFlFu9Vp+ysr7+fbKZlIfsgMBmAcGGCZIQHVAusEhWS75UFyb1YdNmL8+vAf0o89WASUftG0iG4Lg5PC4Gtv9OUJbXQOvgeCd2QqgO4V0jmDy2DEs3et0VQ18n1n8NkKtMZcBmas7+WnhRmh4eyKvSOZVTzlUBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU9/QiMH288e/WezTjMGR7zn7MRyFMUPPu5o8ejgFkc=;
 b=Fy7vjvZmD7DynyjdbhaY3k0EYmzZ9yHu9+7hXYSaUPqVwceb5JZTen00eZyYZzO3+5nOZpGvgn1+5AT5c/ASRILN9OZUu7LdEFAmmlNyrIRoL1iLYLlKaByqSTKAumTzGORRkTfoWri9/+uG/qRMn4w+VveYTEvUlQGKqbpqrMA=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB6889.apcprd03.prod.outlook.com (2603:1096:101:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 08:31:19 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::8416:8e7a:af7f:7ed0%5]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 08:31:19 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "daniel@makrotopia.org" <daniel@makrotopia.org>,
        "linux@fw-web.de" <linux@fw-web.de>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "john@phrozen.org" <john@phrozen.org>,
        "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH] PCI: mediatek-gen3: fix PCIe #PERST being de-asserted too
 early
Thread-Topic: [PATCH] PCI: mediatek-gen3: fix PCIe #PERST being de-asserted
 too early
Thread-Index: AQHZ+CmNokdPj2qtYky0HrTu34BsUbBDNouAgAAKi4CABC3egA==
Date:   Fri, 13 Oct 2023 08:31:19 +0000
Message-ID: <472ebdbe8575b99ac8191e626a87814b88e21c31.camel@mediatek.com>
References: <20231010160423.GA977719@bhelgaas>
         <1E611A63-AD66-4E61-90F9-F1DB41BD6466@fw-web.de>
In-Reply-To: <1E611A63-AD66-4E61-90F9-F1DB41BD6466@fw-web.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB6889:EE_
x-ms-office365-filtering-correlation-id: 1ff57d07-7c97-4a98-53f6-08dbcbc6c687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JOUHPQXX2NDrNvRUKrAwgE8iqD7lBgeCaUQIuV7DNduxA1TKIHuuBk88GfedqdD8PIZi/8WTeg+AxOyZ8zpeSUKncYyCxRdOFpiDWaxj5ZIXP1BmExjez0y05Ye5i6WARp/12jjkjzYxFf+PDi/s1bHCoQIKNfAdkyXyuzVBY+JncA23zmCh/KNDOrEYUHyP7ZNrkBSzIJ6mHMQKAtxxyK6T9SlTvrjYah9I7/Lv5/MfNig+up84xh/Q7HQy6qPXicq4miVeZFmJXhsWz2fps8STTITnQgJ3j7rBM7zc3yZCqNd7ogRDn1puXWnZMFkRbRj8DROBdcf5MdfD/x0smpduuPOriRPywvSn0T2BVBf+rrHzNti/7OFH/b9xPNJQfq/QA2tusKA/FLzpvX9DphI7xyNPpljERO2/8LMq+0uBrB2G+qJszL0mNw1JBGCLr9gsLlu3NooCr2a8UrxxrshWnT6hacEZfuKVwmxOSBQbQCcXVuYNigDVIkvyHznuFQQ3DeyuQHfCkOy0oMQh8tR+0TR0oc7btGS8ueMCxDJIEbLufitq11ltYWbET9PQtUuMlFXHZ+6wgOpjMqNE8UHWa7krosql+hrrbQ7veeX0GI5uiFTGNw0+CWapzeqvSh+ly+s/C6SHHtvqHWHU6X/xLjtf/uZ6O4XXmg3/nI2dEje3G0/rYFpVw3lgiiqm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6512007)(478600001)(6486002)(86362001)(966005)(85182001)(36756003)(6506007)(38070700005)(8676002)(71200400001)(4326008)(8936002)(7416002)(122000001)(38100700002)(66946007)(5660300002)(66476007)(66446008)(64756008)(54906003)(316002)(41300700001)(66556008)(110136005)(91956017)(4001150100001)(2906002)(76116006)(26005)(2616005)(107886003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0pxTlkyaVRzemJHamprcTdIdXc5TTlTVVFQWHE2aStZdmRGbnM2STN2ZmNH?=
 =?utf-8?B?cDZQVTBCNThUbmhETGhwY1IxaTM3VktEV2QxcmdsREZUSzZGUDdYTXorODl2?=
 =?utf-8?B?V3FuUWU2MFNWblN4bExTbERPZE5qWDEwZTdtT01yc21aMkJidGJobGE1T3No?=
 =?utf-8?B?RndrV2toQkh4ZndtdGJRd3lyL0FWeWQrVmhIN3VjbzRGaVpEcEZtOENtd1lF?=
 =?utf-8?B?MkJCSWRhRWRCQklGckN0VVFDSG1qNTZpeEdzcHRaOFQ2NHpBNE1Mai9TVi9Z?=
 =?utf-8?B?V0ZIV1pXdG9xOWJRNDNqM09rSjgwdUpmcGlIWmwwMFYvVEx2YmtUOVhrd3kx?=
 =?utf-8?B?M3hPZWZoZ1B4eUI4NHl2cmZxRmFsR2VkTmU5VTdUR1NIWmx0RExFdWlxWDAz?=
 =?utf-8?B?WVVkTzlKbUJkZlkwS2pLM2NuS0k5YnhycW9mVkRBd0FsekhFbGE2b3lDT0Jn?=
 =?utf-8?B?bzBuR1dkUjlVb2RheEtZZXNGYjFMN0lEbUJYY1hzeEhZSytBbkNDK0NJZFdz?=
 =?utf-8?B?UzR1b3loSFduc1hUbS9leEl1YVkyMTBQbXpJRGQ2NElnNDhkdUJhbVZrTEpI?=
 =?utf-8?B?VlpPNVdmdjhxTzhIZ2NBcWhvL1RrUzR2eTh5OFh3SXhNWUtRQlQyazdmSnBH?=
 =?utf-8?B?RTNxemJ5UE85S2cwMlpIN3o2VDFhRUZaL2dra0pRb2h1N0ZIcm8xZzhxcURN?=
 =?utf-8?B?dkFoTDNHMDJiSVpPRlo1Sm1adkN1czNNRm42UUNIalpDejJ4TjlNREYrZWFr?=
 =?utf-8?B?a211MG5lZE1neWFJV3BicDdVbHBJa2hjak9NdGdJSmJaenVXdmRPRUtDemo0?=
 =?utf-8?B?alNkOUd3QUFSVEpWZ09XZkVBSWNVcDUzbmtYd01SbUxnVCtWVEdzK2JvNGFl?=
 =?utf-8?B?Z2h6UGJDRVNCRU5JVlE3Q3VzSnFpcG82UTBDamJFYUhRNGJ2eVVNVzEvd29r?=
 =?utf-8?B?RHp3aVdrNEFZTm9FNlUzVUhLMHJpbkQ0U2NiclRvSEpEOUxyekxFK2lEY281?=
 =?utf-8?B?NzNMcUwyVFdjOWVhTHViZEVaamVPYkVRZXlnWkFpUjRjUFg4aEQ0Y3d5YVg5?=
 =?utf-8?B?RGNqOTdURVRwUHJqOGRwSVRoYzlKRkhRdGllaUdjQzR1RVl4dkZJaDdERWV2?=
 =?utf-8?B?TTQ2Q0Y0L1NQYS84eEkzWjF2MHhFS2Fvb3RHV1E0VzU1NUdhR2xxRW0vRjJZ?=
 =?utf-8?B?L0NRYzliOG45R0tZZlluYXFwS1hsMUNuV0U3QXNGbW80Y1RZUmZmU0tDcEJR?=
 =?utf-8?B?U1hHV3BmbUczMnBCYkthWG1FajFwZzI0d2d4czhrYUFJNC91SnArUXlEakcz?=
 =?utf-8?B?UytIYlFnUkgySjgyV1QwOUlmaGtXUHlDanpnVnFGSzZWODY3ZlUrRUVOODBi?=
 =?utf-8?B?clE1TVdVNmxHWmNWakMrbnFzZWljQ1ZBTmJaTUVuQXJtZjY4dEExQi9BSmJj?=
 =?utf-8?B?Z0UvcWRXdFUrRXNLekVmSlZ4K1RWQkNDbnY5TE15ZHlSSzJQV3hab1R4aUtl?=
 =?utf-8?B?Y2tHQ2xSMm91ZkEwTlJ2MDdodW4xVVp1alVreFZXZ2RJL0Q4UlJ4ZzlTZE5X?=
 =?utf-8?B?Yk9lSjJzbzhrYzU1YVZTK253S2RCTWZ6QnlMZEVjM1hFVHNBSmVIRFhUbjJy?=
 =?utf-8?B?Qm8xZkRiczBiM1lOS0ZCVFpROTF0NzNiVW5KM3ZaM3pLWWo2andIRkExZTZW?=
 =?utf-8?B?RVlNWjR3M3g3bS9xSkJzdXdRR3FsSU5IRVdmZklZQUpCT1lYQVZicnVadUpB?=
 =?utf-8?B?Qlk3dkZqNFNwUCtCZm5McDg1Z1NNLzA5cjhHclRBekJvM0V3NUxzVzVkOHNQ?=
 =?utf-8?B?QkJJdEF4T0ZZdk9XL0dManRwZzM2d21BcTF5cU55dmt2S0Q4NHBsa2VuTm9i?=
 =?utf-8?B?alRYTlluUDFTWjczK0RaN1FVWGFJVjVHNGVHRndtYXhTTmsvQ0pIN3doRnNM?=
 =?utf-8?B?Smg5c2NyUy9QTC85WTlFTElRK3lMSVlFSnJsYlZwSE5WVDRsVGhBZ3B2eEVr?=
 =?utf-8?B?U01nZFd6MUdvVmVYd3crVjVOTkpqNTBNN3ppcW1meXRhendZZVIwM1NvMlBW?=
 =?utf-8?B?RHg0eDUwcStVZEQreW5vVEdMT25meUJRSmc2UWVRNnhsWW15dnpaZEZhYy9V?=
 =?utf-8?B?SjU5Yjl4UDRSbnVEZVpNbWo0RlBlaUM2cHJic3FGWU1wZlgra0srbGVmeWlL?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75D311B36D31614190EE559DB0CB1A1C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff57d07-7c97-4a98-53f6-08dbcbc6c687
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:31:19.7725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbpqqJRZ2KzfuEQiU8yrO0L/CYV2/CBLBc4zO9hN8kqnXP266Nnlnl5U2yCcp4E76BI3vOQ1DMnxErPE9aP55EO9aOcuI3POkHgVTQmYoPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDE4OjQyICswMjAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gQW0gMTAuIE9rdG9iZXIgMjAyMyAxODowNDoyMyBNRVNaIHNjaHJp
ZWIgQmpvcm4gSGVsZ2FhcyA8DQo+IGhlbGdhYXNAa2VybmVsLm9yZz46DQo+ID4gT24gRnJpLCBP
Y3QgMDYsIDIwMjMgYXQgMDk6NDU6NThBTSArMDIwMCwgRGFuaWVsIEdvbGxlIHdyb3RlOg0KPiA+
ID4gVGhlIGRyaXZlciBmb3IgTWVkaWFUZWsgZ2VuMyBQQ0llIGhvc3RzIGRlLWFzc2VydHMgYWxs
IHJlc2V0DQo+ID4gPiBzaWduYWxzIGF0IHRoZSBzYW1lIHRpbWUgdXNpbmcgYSBzaW5nbGUgcmVn
aXN0ZXIgd3JpdGUgb3BlcmF0aW9uLg0KPiA+ID4gRGVsYXkgdGhlIGRlLWFzc2VydGlvbiBvZiB0
aGUgI1BFUlNUIHNpZ25hbCBieSAxMDBtcyBhcyByZXF1aXJlZA0KPiA+ID4gYnkNCj4gPiA+IFBD
SWUgQ0VNIGNsYXVzZSAyLjIsIHNvbWUgUENJZSBkZXZpY2VzIGZhaWwgdG8gY29tZSB1cCBvdGhl
cndpc2UuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBHb2xsZSA8ZGFuaWVs
QG1ha3JvdG9waWEub3JnPg0KPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRp
YXRlay1nZW4zLmMgfCA4ICsrKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gPiBpbmRleCBlMGUyNzY0NWZk
ZjQuLmJhOGNmY2UwM2FhZCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiA+IEBAIC0zNTAsNyArMzUwLDEzIEBAIHN0YXRp
YyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVjdA0KPiA+ID4gbXRrX2dlbjNfcGNpZSAq
cGNpZSkNCj4gPiA+IA0KPiA+IA0KPiA+IEkgZmVlbCBsaWtlIEknbSBtaXNzaW5nIHNvbWV0aGlu
ZyBiZWNhdXNlIHRoaXMgcGF0Y2ggc2VlbXMgdG8gYmUNCj4gPiBhZGRpbmcgYSBkZWxheSBmb3Ig
VF9QVlBFUkwsIGJ1dCB0aGUgY29tbWVudCBiZWZvcmUgdGhlIGV4aXN0aW5nDQo+ID4gbXNsZWVw
KCkgY2xhaW1zICppdCogaXMgdGhlIFRfUFZQRVJMIGRlbGF5Og0KPiA+IA0KPiA+ICAgICAgICAg
ICogRGVzY3JpYmVkIGluIFBDSWUgQ0VNIHNwZWNpZmljYXRpb24gc2VjdGlvbnMgMi4yIChQRVJT
VCMNCj4gPiBTaWduYWwpDQo+ID4gICAgICAgICAgKiBhbmQgMi4yLjEgKEluaXRpYWwgUG93ZXIt
VXAgKEczIHRvIFMwKSkuDQo+ID4gICAgICAgICAgKiBUaGUgZGVhc3NlcnRpb24gb2YgUEVSU1Qj
IHNob3VsZCBiZSBkZWxheWVkIDEwMG1zDQo+ID4gKFRQVlBFUkwpDQo+ID4gICAgICAgICAgKiBm
b3IgdGhlIHBvd2VyIGFuZCBjbG9jayB0byBiZWNvbWUgc3RhYmxlLg0KPiA+IA0KPiA+ID4gIAlt
c2xlZXAoMTAwKTsNCj4gPiA+ICANCj4gPiA+ICAJLyogRGUtYXNzZXJ0IHJlc2V0IHNpZ25hbHMg
Ki8NCj4gPiA+IC0JdmFsICY9IH4oUENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfCBQQ0lF
X0JSR19SU1RCIHwNCj4gPiA+IFBDSUVfUEVfUlNUQik7DQo+ID4gPiArCXZhbCAmPSB+KFBDSUVf
TUFDX1JTVEIgfCBQQ0lFX1BIWV9SU1RCIHwgUENJRV9CUkdfUlNUQik7DQo+ID4gPiArCXdyaXRl
bF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gPiA+ICsN
Cj4gPiA+ICsJbXNsZWVwKDEwMCk7DQo+ID4gPiANCj4gPiANCj4gPiBTbyBJJ20gY29uZnVzZWQg
YWJvdXQgdGhlc2UgdHdvIHNsZWVwcy4gIEFyZSB0aGV5IGZvciBkaWZmZXJlbnQNCj4gPiBwYXJh
bWV0ZXJzPw0KPiA+IA0KPiA+IFRfUFZQRVJMIGlzIGRlZmluZWQgZnJvbSAiUG93ZXIgc3RhYmxl
IHRvIFBFUlNUIyBpbmFjdGl2ZSIuICBEbyB3ZQ0KPiA+IGhhdmUgYW55IGFjdHVhbCBpbmRpY2F0
aW9uIG9mIHdoZW4gdG8gc3RhcnQgdGhhdCBkZWxheSwgaS5lLiwgZG8gd2UNCj4gPiBoYXZlIGEg
Y2x1ZSBhYm91dCB3aGVuIHBvd2VyIGJlY2FtZSBzdGFibGU/DQo+ID4gDQo+ID4gPiArCS8qIERl
LWFzc2VydCBQRVJTVCMgc2lnbmFscyAqLw0KPiA+ID4gKwl2YWwgJj0gfihQQ0lFX1BFX1JTVEIp
Ow0KPiA+ID4gIAl3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1JTVF9DVFJM
X1JFRyk7DQo+ID4gPiAgDQo+ID4gPiAgCS8qIENoZWNrIGlmIHRoZSBsaW5rIGlzIHVwIG9yIG5v
dCAqLw0KPiA+ID4gLS0gDQo+ID4gPiAyLjQyLjANCj4gPiA+IGxpbnV4LWFybS1rZXJuZWwgbWFp
bGluZyBsaXN0DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
PiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJt
LWtlcm5lbA0KPiANCj4gSGkNCj4gDQo+IFNlZW1zIGl0IGlzIHNhbWUgYXMgdGhlIHBhdGNoIGkn
dmUgc2VudCBzb21lIHRpbWUgYWdvIGFuZCB3aGljaCB3YXMNCj4gcmVqZWN0ZWQgYmVjYXVzZSBv
ZiB0aGUgYWRkaXRpb25hbCBkZWxheS4uLg0KPiANCj4gDQpodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMzA0MDIxMzEzNDcuOTkyNjgt
MS1saW51eEBmdy13ZWIuZGUvDQo+IA0KPiBPciBhbSBpIHdyb25nPw0KPiByZWdhcmRzIEZyYW5r
DQoNCkhpIERhbmllbCwNCg0KRGlkIHlvdSBmb3VuZCB0aGlzIGlzc3VlIG9uIE1UNzk4NihCUEkt
UjMpIG9yIG90aGVyIHBsYXRmb3Jtcz8NCg0KQ2FuIHlvdSBzaGFyZSB0aGUgUENJZSBkZXZpY2Ug
bW9kZWwgdGhhdCBmYWlsZWQgdG8gbGluayB1cD8NCg0KVGhhbmtzLg0K
