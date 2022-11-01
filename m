Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4111E614A61
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 13:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKAMMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 08:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiKAMMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 08:12:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7FA13F8C;
        Tue,  1 Nov 2022 05:12:52 -0700 (PDT)
X-UUID: ab9f9acc35794225a53edaf0c836c3e8-20221101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZSLnD8oOTTTBQrSuD2Y7NQZp0Kyd7aPeKMtmW06eXmA=;
        b=tPjpeFhghl2fITmgK+zLZFTPv+6zOoGB9SsjiBicSYgvvIjjlek3GOHqJgisyizH6f8vaat3NWQODhg+Di2E8zE/d1YHdRF6rHeWNtBrNrYCmbNMkSUoJXLnuYa2x7b5fX3MQwLppasiDGy/1Os1E/z6tsn0qMruTxuKpFBbVJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:e145453c-7439-4dbf-bc22-f6318d43c19b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:78024090-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ab9f9acc35794225a53edaf0c836c3e8-20221101
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 887371255; Tue, 01 Nov 2022 20:12:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 1 Nov 2022 20:12:46 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 1 Nov 2022 20:12:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csvh1D+l0uGVARUYAdywixbm0QiQW1JtrRvBQMgNkTFdJvJ0tMUAKGCCpIPph51Q7VeKm3SMpKKsB/6IKlnClxgdVhlo0XiIr2IRmKH2jetfM+86qoowxu4hoXYuk4c+lg7Rvbocx5GDl8hu4G2Dx3h1Qh1JuCsNxhkWR/LEYSUblXVsVqfaMrH7sFJSvXpNQbu6get4HR4SCsMzXX5Zf7KM4WUnqhoXIu+N2Ba7GS0Zzjskw00+qAyOjc83rCWzvgWjrLKdX8uHDN8CHS1zozhjWjJB79WqaBg1MoN7NHqv8CuxrHbM2FgzwxFsEWTodUIKLeG9v+c2xfMcEj1VKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSLnD8oOTTTBQrSuD2Y7NQZp0Kyd7aPeKMtmW06eXmA=;
 b=WUu9ntQsHkNDQR/MoLooWPv/ReXtxZ3N1GB4xixKKsGjGF9A3VoBpklcgoj0SpT59tBoyLBk9bePvfi5etEsI9iwGOtcLPkg/KM0y0lc2xhj4rK8Js3W1DSdX4sJuBsDD4v1RbyogMugduiBm42CtxqKEEGFcLwsrDQP0CgtCUiMb3UfoT49dU7oQv2UlZCO5t/vupUzQBEdTav5DEN2YEK11Q64yStPo0xq3mDhAG48mYAIdAp51k0s0yEWUMbEpdIda41hj9/OlLmBf8GtHJeDzynQsixH5mteml61T0xgPTjkfSkKZMlBFAoYD4PDxqBV0tTxOs9ljxt31E5ymQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSLnD8oOTTTBQrSuD2Y7NQZp0Kyd7aPeKMtmW06eXmA=;
 b=nZJMA8IxC+Fxj7joo5vXJk8PaREnz9foT5WD78ZL3iT6s0AjY/P7XYoBfDlzZNTAdAFhnz7cUn/qNBSuQ/Xe/6SmagG5suOmOT9Y0ckUYbaCjV4gqct/WnYjk5bqdK0JyjqP8+5xm0ZP8HRQRt3gTzN18wHBCPGmYE3bryCUx2c=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYUPR03MB7178.apcprd03.prod.outlook.com (2603:1096:400:344::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.15; Tue, 1 Nov
 2022 12:12:43 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::5bc6:5d32:688c:2f60]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::5bc6:5d32:688c:2f60%2]) with mapi id 15.20.5791.019; Tue, 1 Nov 2022
 12:12:43 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
Thread-Topic: [PATCH v3 1/2] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
Thread-Index: AQHY68AN1c3rDo372E2BtBH+0cRs2q4olqaAgAFnTwA=
Date:   Tue, 1 Nov 2022 12:12:43 +0000
Message-ID: <033a852b31aa8ce3598e968f61e4a75251f1234e.camel@mediatek.com>
References: <20221029175806.14899-1-frank-w@public-files.de>
         <20221029175806.14899-2-frank-w@public-files.de>
         <20221031144301.GA2856406-robh@kernel.org>
In-Reply-To: <20221031144301.GA2856406-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYUPR03MB7178:EE_
x-ms-office365-filtering-correlation-id: a62e0e0b-9178-4e15-ad28-08dabc02617d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f5S5aOfQ0u8VgkfWaqivLR4lukrAT3H2wOu4XwcAIvnT8PAIrYuGV4o+3jTb6Bb9IqONNWLUUh2r8UUeOvWNNLQ6zM5CjH0a8QNWJfPEvkAU/cXQjDs1p+yerfI6465LcTxa94fxqGjTj0iu4IvmJOa/4Qc3mQDr0Q8KSDrb5OrZJibIsdIB2f6iXzTlUUCXOrr05lT2enK8KbiDodiX2FMeqh05BBAXPR3Ta5Z9vGtkew+JsTvP9Wuyk0zGu42U951jVWIN7oQd0rXOo1Pj9lwkjqNHzPEx5YYOKXHVCbwwaq2uvBbtXmv9b4VHb5f5mv5L6y909mruV0ikHsNUUSMpZ0B3d4ELcYY41fZDGEPqcmQTZJ2W5JVD7NqJg16BDsL/DGsCsXNvv73I9SnmqxyvjTeiD2a5miEzoUjleYeb2dYQEw4g/OhBqhx6gRMkCRJpbsJxWJdcfm2JUmbUZXLH1hKCW4WzZwc0oRGlxlU2g9cKUvPX6en/wmxgehGkBUyHTZkdD0M0X4shF9SHTBgQjnhmVfDKfvCrW9x1R+zUab4zL2PZ7UskcKNbH3GqvA6ogStnpvi8/cuKvpxdM1qN0gWwv4GeztepbDmyl23pHG3k97guZhLh41NXwU0ZVUC/nZKocIo8RT0wD+Q5pbzIJugf7F5x77Ju/L8rKqAFOYLN2U3m4Knbqyono8/+3FDLDuvDc9h6Qr9BOuj51mJdq20m9wgJWlOWd/PEUWyyt/CRYCOmXogVByDU/DYkyhrs2fdS83Z7JmTGVQjHsChlfZYH6vxaGqk4G6adrmqjacnUXXgFrI3nGy5aDoCU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(86362001)(71200400001)(6486002)(2906002)(478600001)(8676002)(4326008)(316002)(91956017)(66476007)(6506007)(66556008)(66446008)(66946007)(64756008)(54906003)(110136005)(76116006)(5660300002)(38100700002)(7416002)(4744005)(26005)(8936002)(41300700001)(122000001)(36756003)(6512007)(4001150100001)(85182001)(83380400001)(186003)(2616005)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWcwanZheTNsNzVmaHJnTUdqaFNGVm9DZ0FIaUhPdUNNUVpvQ3pGL2JhdjZ5?=
 =?utf-8?B?ZkV1cjdTY3pPZkJWNFlXNnU2Y1RWeXZJSlFxakU1VG1nSXhEUGxLSStGclJF?=
 =?utf-8?B?WmNzNDJ0MmZuQ0J5aFowbDZCN09haFYzMFZZbmVsc2JpZEY1MTdpMStXdThM?=
 =?utf-8?B?Vm8veWRldWJmTnRZbFZma3BqZllpQVJqQTc2a2pselFUY3pYa2FZbXYrTW5a?=
 =?utf-8?B?ckx4RkFsZjVqeUk3cHB2d1VndHg0dW5FMXZtemg0UEU1Y0ExRFBlU1NDdCtM?=
 =?utf-8?B?cXZ6c2xMckQ2UFVPdzkrempkWlAzTDJIVmFiaEp0K2ZSQk11TFhnOGMvREYr?=
 =?utf-8?B?QWljTFB3RjVUMWRZTU5nMzdhMTIzZHpiQ3dnQ2ZDYWM5NTB6UEZ2K1MwWmNr?=
 =?utf-8?B?amxTS0ZMd0NLZnRmU1hUSFVrQ3hVSmRFU2YwVHlReVA5NEp4TVBMWStnTVdw?=
 =?utf-8?B?TjFxTnNwVFFkM3lDR1RxaFNseDZmZ2s4VC9ld042RUJIWmtvY0g1eWNaSDBK?=
 =?utf-8?B?cjFPNmlwQTBzcHowdS9rQU9zMmhBQ1AzQnZuL0RUdy9CcjBiTXIxVGgrcURX?=
 =?utf-8?B?QUFvVzI0NnA1ZG4wTE9ZdUxwTjUxZzV5bndMUUdwQksxVFJsekNBbkZmc3Jk?=
 =?utf-8?B?K1pqRm0zemNUbDNnY0QvQWlFN3Z4QmplbWwxMkJnQ1J1NUREbXpKU1VyR3Y4?=
 =?utf-8?B?bldQTk1RREpVanp3bUc4TUREbi9Da2tURXNiUFZOR2pqYW10S2M0cEJoQm4x?=
 =?utf-8?B?U3RlczZucCt5d0t6NU1FQTdlSzR1V3ZaNGhwTTkyUWNVSlcxRTFqUTlJOWd0?=
 =?utf-8?B?eGJPaGRQcVZYemVWaW1DQm1meUp6WUFtbnYyUnprVEUvQmovdS9UR3dBRGFL?=
 =?utf-8?B?cjRPNjN4QTVUZU1LNzZHRFoyS2tkeGhEUTBOcWNjNkl4dlp2NXNtMkxMSk56?=
 =?utf-8?B?RzAxUnVnZG1EbytLODRDMzFObm03dlJOS3VJcjRJZ2lscEI0TnhOTlY0WTZi?=
 =?utf-8?B?SkJPVkg5OTVuVGpVbzJpUlVkcVM2Smh5MzNPNUJWTXFnaXVZaUc4WXRnWEZz?=
 =?utf-8?B?NWVDNEpRVVZvQUJ3TG9oam9TelR1OVllKzVNN1RiSXV2Q1pETkF6NVlCL2s4?=
 =?utf-8?B?ZDQrWnhNL2RFcGQ4U3hhWTBVeHRsbEpGMFRRRkdnMWRtRkpqT2hDN2ZYNkNM?=
 =?utf-8?B?WU1hME8vRG1tTFVKdWtsb0dCMnJESmRDV0pia1htMUVZenpzUzFSTWNBb0o0?=
 =?utf-8?B?ak13a3hIYmpneDdiT0hVdW4xZlZoNWRLK3JzQlIwblE3eDdYdlk1dlozYm1N?=
 =?utf-8?B?ODB2S2dHSHp0NkQyQStUWE1QNjdZSm1jTk1lcW5Ec0xxcElHc3lLbWdjcUJT?=
 =?utf-8?B?dlF4Y0h1Y0RPaWtFblFmTWVybVdHUGhadlZtTElENkxQT0lZQ3hRWlNBdmgv?=
 =?utf-8?B?bndha1pTbE1NZU9jeFpKb0VmeTMrNkNVQkVsZjE0YWdjSm1HV1ExYStYSkw1?=
 =?utf-8?B?QkIrS3VsM09rWFBOb0lMMEJRSVlaaURVUFRLckU4RkRmQ3hQSDFSRGFac0Zo?=
 =?utf-8?B?UTE2ZFNhUUlKNml5TENFK3JFSmFhK0ludHN3V2JZZlZObVIraCtqTVpJSHdv?=
 =?utf-8?B?cFFZRUlHRlZzNVFIOFBUUUJuWW1uR1VmWTlraThJNHlKM2dhWHRHR2dsSFFq?=
 =?utf-8?B?Y3kwNHo5MEM3elNLQVdkd0JxcHpUV1AvQXQrZVV6cDl1NFkrRHBOTVFxNUgx?=
 =?utf-8?B?TnNPbXhmZTRVNmpkK1dHK2tUcE1uc0F6M28zS3dkZWdrN1E5NnpWUmQvTi9G?=
 =?utf-8?B?SU1SQm9lTzVDZnkrTzBySTJVSmozUDhURktTNHRLWmxUbjZickJCTkFLejVF?=
 =?utf-8?B?dUpJNnUxL29MejlsWC8vNXpkTlR5WnFsSjJDUTJoT0J4TXFoOFlrV0U3dGE1?=
 =?utf-8?B?aUFKVkQ0S1lnREpNVGJncTc3TUlXTkdOcW1xNVhST2o2SWhBN0JaWnFQRjlF?=
 =?utf-8?B?ZXNOUlNoZHQyRVR4SklocXI2RTRBbDVXS0x0UTIzZE9qeWJhTjNpK2xTeHlZ?=
 =?utf-8?B?dEUwSGUzSTlTL1hhdHV3SjQyRHZvaXZGUk8zYjl3YzY1bVlFOEMxSktYajhp?=
 =?utf-8?B?STB6M1VZajZ5bzY2cjRtUzVBdUdMSUNqSERhdmFSbzdRVVdSSDdrMWR3VkNi?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <615E4C9BF5FF6C478918ED8D26463808@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62e0e0b-9178-4e15-ad28-08dabc02617d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 12:12:43.7616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOu4phAl3UZwA59dRswAgo1wUyWEsZjv5k8YtFo/qfDOPc7ONj0+XXnxeJG5wLCyf+5aMPod1CCStHBG5AJaAZWcIjkoa+OjI+7fDTzVP6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDA5OjQzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU2F0LCBPY3QgMjksIDIwMjIgYXQgMDc6NTg6MDVQTSArMDIwMCwgRnJhbmsgV3VuZGVybGlj
aCB3cm90ZToNCj4gPiBUaGUgUENJZSBkcml2ZXIgY292ZXJzIGRpZmZlcmVudCBTT0Mgd2hpY2gg
bmVlZGluZyBkaWZmZXJlbnQgY2xvY2sNCj4gPiBjb25maWdzLiBEZWZpbmUgdGhlbSBiYXNlZCBv
biBjb21wYXRpYmxlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIFd1bmRlcmxpY2gg
PGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPg0KPiA+IC0tLQ0KPiA+IHYyOg0KPiA+IC0gZml4IHR5
cG8gaW4gbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiB2MzoNCj4gPiAtIHJlbW92ZSBjb250YWlu
cyB0byBtYXRjaCBvbmx5IGlmIGNvbXBhdGlibGUgaXMgbm8gZmFsbGJhY2sNCj4gPiAgIHRlc3Rl
ZCB3aXRoIHNlcmllcyAiQWRkIGRyaXZlciBub2RlcyBmb3IgTVQ4MTk1IFNvQyIgYW5kIG10Nzk4
Ng0KPiA+ICAgcGNpZS1ub2RlcywgZHRic19jaGVjayBpcyBub3cgY2xlYW4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCAgICAgIHwgNDcgKysr
KysrKysrKysrKystDQo+ID4gLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCg0KQWNrZWQtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1l
ZGlhdGVrLmNvbT4NCg==
