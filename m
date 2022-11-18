Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2E62EDD7
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 07:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiKRGos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 01:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241268AbiKRGod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 01:44:33 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB76410FF3;
        Thu, 17 Nov 2022 22:43:31 -0800 (PST)
X-UUID: b6452aecd77647f08ee115b8e00b5fa7-20221118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o1tUzC6b3uBh1EFVoarYZGxxMceghZGfo6AQhoIsBWk=;
        b=uoIsMrL5gLfAn/fH0VJOg7f6Ej8jxNhKGv2moml4tUIeGIEXsNp2+T4N82y3/2C7H2yPtnFjWl2c0TfxzX0wsLxNNl9sTsrSIUClP0T50U9m5ja6NKFKci8rHxHiJFUPYqY7lyzNBbFoWtHLU89qIc1yeKIt1ATG5MeXKNdEmn0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.13,REQID:be2e1bc1-2745-410d-a941-0474082f0468,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d12e911,CLOUDID:0ae9a0f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b6452aecd77647f08ee115b8e00b5fa7-20221118
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 102629716; Fri, 18 Nov 2022 14:43:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 18 Nov 2022 14:43:26 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 18 Nov 2022 14:43:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERJbeAOdHij7y0w1aVbl57dbv1QwfhM0gEFL2kGrgl9Ko4weeCeEzl5tksbUbWhz79hmDr1zDa5c9CsdwUPCaWHMv6eooZBdIPyv8dMUux54OZfExCnYQFmnUQPwxllegonF7p7jpO9eFPBVnLaOaxQ9JCuorAA9Qk4Y6FDRVkbyKcNkhtAbUUwcZP4HfHCu3K2JDmlHHdfLssmXnibhkhTT+ckH/uTVeJm7etysTJ1Q1ieg8SazO+9XkjWyxQaGL6Wi/Ug1IiY+EYe0UTVFkjswBV+S+ixXO7DS8Tx2KA7nfUXFUF8wMArP3yI7pPeaYj/ZizBz5kbw/aFu/v9iMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1tUzC6b3uBh1EFVoarYZGxxMceghZGfo6AQhoIsBWk=;
 b=Ir+eHx9BX8D+sH3xoB4JLffPA7bS8k+3ClBakDrIdBnrAeAeyUxLdl6Htb6wog6v8FO0uo72K4R6kYDJmhl/zzqMNKNLgAmoUuxaiNV2pdchy17CFf78LP7D34r1Qlnu9biuWoOeoiK43rKp5pbPmBG6OKKbBXvuBrDaJsPPCENNeth/tUyogOrnAWSGfAt7FPLV5gbzrocnoCc8RYCGrdwF2NMFBY0rqajzNFc7YBEi3dj2fLfZge5aI8iZs1aaD9RltpeSNHKC8Iw86gfZYCX2I/a97YpPuHdx1P81DRSovCvc77Sl7QSS5N+sm+tb4ax88tMmQfWqdjncCtn2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1tUzC6b3uBh1EFVoarYZGxxMceghZGfo6AQhoIsBWk=;
 b=nB7IzICOo5dpWyF5nc4KUbeBrV1BsRJYBkgyXG85TQCyoh3FcFUBhY2YLE/KeEeUjqLPVeODVBe3RbKOuH7/YPLDMyvOHDEAPHW6GSyevrJwLtdWf54aXh8Tj3fHrdWWg9pBiAcFAwTSJoPjsKFDgD1x6jxcSsLwdMpoyeV96LA=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5569.apcprd03.prod.outlook.com (2603:1096:820:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 06:43:24 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 06:43:24 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux@fw-web.de" <linux@fw-web.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "frank-w@public-files.de" <frank-w@public-files.de>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        =?utf-8?B?Qm8gSmlhbyAo54Sm5rOiKQ==?= <Bo.Jiao@mediatek.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 07/11] arm64: dts: mt7986: add usb related device nodes
Thread-Topic: [PATCH v5 07/11] arm64: dts: mt7986: add usb related device
 nodes
Thread-Index: AQHY+qGy4EUX0DezVkKc1Cw9AG4bE65EPNYA
Date:   Fri, 18 Nov 2022 06:43:23 +0000
Message-ID: <6417076e019640b23fff85e27798b277c74eeb74.camel@mediatek.com>
References: <20221117162728.20608-1-linux@fw-web.de>
         <20221117162728.20608-8-linux@fw-web.de>
In-Reply-To: <20221117162728.20608-8-linux@fw-web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR03MB5569:EE_
x-ms-office365-filtering-correlation-id: ad276280-6497-47c1-fb0d-08dac93030a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LsBRVvTIkrAjBYU12p7O8Z9nOfYdIjUuOHLOe1zdrEgpy4jIww7o9Fjl3kFn8dfIie3fx8AoTqgyRhIiou/467QkmRodCG02V+UvGSoWxZkzb2Va5AV9yADFtO8ZM50MByipHiPAz8vgmbZ3IikNTLHeYBWeqvvfv4plfdI2fLKK8abmcdaBPIh9hOaqwvxlS2/Ig+gzshycT4MkrmT4171Ew7LWE2j9mNYfR+lASTqEC4gaGTMx2h/DAgEnaqhf7seiCnVSdrD7MxDTdh44nMKNnwPElSRnnu6AI+82nsSXnafrvKXZh3qXinJYuBGMX6fuZ9QLK6MKbFgdZ6TyspEAa9KtwhV5fakA+imeoiBsjjyvVhJJOal6xMls1GuyMlV3YCv/MJ4HOML/Rz3u3jWxbDbRcLMyRxO0CO1G9ovBBBExgclamGzwTJDet6my9LLsxLCKcPTo4abZ+XZT2A57vHHiKMZyk1+PflKh0PCQVFXuKveIcPYOBzbUasZVhGg+vu+w49dxqO9fbaNalReDC5be0/WEIgqBrDoE+5zp4hHjM/kGKR09bjNkHKIdmp/naC31b6ZqwUwS/4G/1nn1RNOzIHgh5uuaz7pDWCM48cOp/gQqIZraYCyU2Tkp1Vn/Z2ouyfQdG1byiO5BcxHYMq6rJTrzhTkcCFPlNLcuMXoT7AUc/t9jB89uqGmkAUksjNSz/IsluOik5D7axe6iof+5p9aj0HKPyOu0TU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(186003)(316002)(6506007)(54906003)(110136005)(41300700001)(7416002)(66556008)(76116006)(36756003)(4326008)(8936002)(2616005)(26005)(5660300002)(66946007)(66446008)(64756008)(6512007)(8676002)(66476007)(85182001)(122000001)(38070700005)(38100700002)(2906002)(83380400001)(4001150100001)(86362001)(6486002)(478600001)(71200400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVU4U1dXR1ZrdVA2SXV2UUlZZmU5Vk1UYVdnMXZEQU9vbEFvODdsZTBoTk80?=
 =?utf-8?B?RlljSkd3cUV6d3lUaVZ5aVpoT09MR1o3QmlnSktWM0FIQXpES1U2ZmIzOVd5?=
 =?utf-8?B?VWpxT01EK0VQSGdRcENCZXNjbDRUZ280NVhSN2luNFZyNnpCRS8zclpJdDJj?=
 =?utf-8?B?OW9yczl3aWNQOFFmVlh4cFdMbjVuNUNJRHQyMVZGd0ZsdGVTcklYTzBGS0NQ?=
 =?utf-8?B?dTk2ZmhHcDFqaW5WaFJNbnArU2ZvM2RsZ0dZbzBna1FsTVVFLzJmbGgvUVZz?=
 =?utf-8?B?czFRNVBPTFpiTnFPeURYUG5wUENJZ0thc1NkYk1ka0d5UC9UcENuL2M0M1dv?=
 =?utf-8?B?U29CWG9aYXZzaHBKRkYxV1JIZE81UTFpRGRTaWMwZmVKQjJVS3VKNnpCc2cx?=
 =?utf-8?B?WlkrdzI1eTFma1U3WDdnWXVNeW9IUEVlVkUvMERGV3oxd2J3K3hKR0FldkVw?=
 =?utf-8?B?N0J2R3NZd1V1amhMQlVDRXQ4NXRiZW13N1VxWmRKUkZsU2s4M2RzaEdpUDd3?=
 =?utf-8?B?SEFrVy9qbXRxclFEN3FvcWRXaVBoWjgwaG5uNmprVEdEQXBza1JZY0RXLzQw?=
 =?utf-8?B?UmlxNC9iUkw4ZmJ1UHFka3dQdGxRWEtQc2FCY1lHeGZ6RDZKbUVoMlVHd0Yv?=
 =?utf-8?B?NDFxejZFOGxhcHZhZ3hKQzA4Z25lN2RsL2xqektxWU9kK3ZnUU82cjFnLzlZ?=
 =?utf-8?B?MW13eTBwYWRLVU9hcW9SbG5NSmM4UThPUXZudndmdzRWd0dWbG11TTFFMnVT?=
 =?utf-8?B?WStEbUpQRmJuOUcxRjJFaUI5SjNhWGx6YzJ1Zmw3d04vZXhQaFZWQUxrL0lh?=
 =?utf-8?B?Y0ZPY3JyeHJWa0UrTTlQMVRFMFhXdGdSc0Z2MW9TblRwNlYyd2RsaUFYczBP?=
 =?utf-8?B?NzVEK1gxTWxGbnM1Y3JKYzU2SnBoMzJTS3k5RC9GOXN4QjIwemxxZSs1ZEZ1?=
 =?utf-8?B?Ukg5alVsQ2RNdHpROW42ZjdGa3Q3U1FHNzR6R0E2TkFRNzVUdVkwNXBWa1hZ?=
 =?utf-8?B?MHRPMmJHM1JZdmhmOGhTdFQySmYrTWRMSnBESVpQa3YvcmVvL2JTU3JpSWRV?=
 =?utf-8?B?djdBbzFFUUozcURsNkRFSmQxaTNKdVpTQ0k5WnhGSjJhdThQWWVpRWhtd20w?=
 =?utf-8?B?WHJOUnZSenZxZUFzRk1vdmZxdk1IQzhDeWh1RU5WVHc0RVd6V3UwNlpHYXFm?=
 =?utf-8?B?eERXS2J4R1ZrWWc1RVV4NWE3SjZ0MkMweEtha3o1Z1pIdUgyTUY4RHZJSTJO?=
 =?utf-8?B?TFJyUlZMUDh1RHYzTlloOU5WTjVYdE5ObStObTFZZkJLQm5pckxERmpJUENK?=
 =?utf-8?B?QXdGQjhBS285MEJkaU5Nd2NmL3laVHdwWk5HVm1wSEk4amN4b3pFMXU5a2xs?=
 =?utf-8?B?YWpmeVhub3VTeGluVEFlb2NyVWVnVFI4bmluWW45QTRiNG9iMDF2RzlRODEr?=
 =?utf-8?B?RXFXenlYK3V2TVZjbWppVmJwUUl1dVQ1QnNlZks0UUl1VUtJeXpCTnhrRFZl?=
 =?utf-8?B?SUtGRDJsT245Z3RMV1puZkR2NEM2dGRxNzNuTmJyZUlmbkwrUVBrNHJZVXNS?=
 =?utf-8?B?ZmRFZmZUV25uOW4vcStHSncyZlI1UThCamFKaG1aeUhlakVseW5pL3pBU1Nm?=
 =?utf-8?B?Nkh1SW5JRC82bXRNcEl2OUJBOXJOQ3JWN1hWUlpDOGJ2T2tYc01xTVVRNGVr?=
 =?utf-8?B?aVhUVmlMMzBIaHBIaFgrYWw1RWZHQXZqa3QwWjd3OHV6KzU1MjR5cXNJMnpF?=
 =?utf-8?B?Rkh3TnpqV3htRnlWRlUyeDR6aFdITGZESmRmYWtxRGNpcGdHenlwYStFSTln?=
 =?utf-8?B?S3g2VHNZdFdGWCtHTW1Ga25lMU1qcE9DbmhhODV0L2VKeEpXcGNWMHY2ZnZh?=
 =?utf-8?B?c3oyaWJvQ3o5Y0dUK1I3R3pqd0pLMU5xWEkzOVJmbzdSeCt4UXhDc3VWTGNW?=
 =?utf-8?B?b1RLT3IyYVZqUnlTKzROT0FzTWZmSXQzL0pBMmRTOHliaTg1SEtxOTF4dkpr?=
 =?utf-8?B?c1VmMUtoTHhibHJQbGVxVnBnei9ad0s1SndQZ2V1NXVNcHhGTHo5OE5yaWd6?=
 =?utf-8?B?UDI0dTI5K1JicnVxZnhVQm5YdE1jZGV2MXlKOXV3QTkrVGJOcnlZd09RcFFw?=
 =?utf-8?B?ZEJQcVBPNFNLYzY3TFJNUkFaZ243UTZ2QVpkZXBtYVM0YjV4VXh1bU5SQ0dv?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E667854FA6693249A80F8BF981A9EACE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad276280-6497-47c1-fb0d-08dac93030a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2022 06:43:23.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jj1Q71ADDYdBg2b5Mgzie7RRq3IcgjRKca1R9dTw9QsJiz7meekxO3YtextzCVx5uu1mx/q/ibnPeHWivgzM5DrQlrIIf4uMQKEGC9gl6Ac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5569
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTE3IGF0IDE3OjI3ICswMTAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBGcm9tOiBTYW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhpcyBw
YXRjaCBhZGRzIFVTQiBzdXBwb3J0IGZvciBNVDc5ODYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
YW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBX
dW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4gLS0tDQo+IGNoYW5nZXMgY29t
cGFyZWQgdG8gc2FtcyBvcmlnaW5hbCB2ZXJzaW9uOg0KPiAtIHJlb3JkZXIgeGhjaS1jbG9ja3Mg
YmFzZWQgb24geWFtbCBiaW5kaW5nDQo+IA0KPiB2NToNCj4gIC0gdXBkYXRlIHJhbmdlcy9yZWcg
b2YgdXNiLXBoeQ0KPiAgLSBub3QgYWRkZWQgUkIgZnJvbSBBbmdlbG9HaW9hY2NoaW5vIGZvciB2
NCBiZWNhdXNlIG9mIHRoZXNlIGNoYW5nZXMNCj4gLS0tDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210Nzk4NmEtcmZiLmR0cyB8IDI4ICsrKysrKysrKysNCj4gIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS5kdHNpICAgIHwgNTUNCj4gKysrKysrKysrKysrKysr
KysrKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2Yi1yZmIuZHRzIHwg
MjggKysrKysrKysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMTEgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS1yZmIu
ZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZhLXJmYi5kdHMNCj4g
aW5kZXggMDA2ODc4ZTNmMmIyLi4yYjVkN2VhMzFiNGQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS1yZmIuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS1yZmIuZHRzDQo+IEBAIC0yMyw2ICsyMywyNCBAQCBt
ZW1vcnlANDAwMDAwMDAgew0KPiAgCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiAgCQlyZWcg
PSA8MCAweDQwMDAwMDAwIDAgMHg0MDAwMDAwMD47DQo+ICAJfTsNCj4gKw0KPiArCXJlZ18zcDN2
OiByZWd1bGF0b3ItM3AzdiB7DQo+ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsN
Cj4gKwkJcmVndWxhdG9yLW5hbWUgPSAiZml4ZWQtMy4zViI7DQo+ICsJCXJlZ3VsYXRvci1taW4t
bWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwz
MzAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLWJvb3Qtb247DQo+ICsJCXJlZ3VsYXRvci1hbHdheXMt
b247DQo+ICsJfTsNCj4gKw0KPiArCXJlZ181djogcmVndWxhdG9yLTV2IHsNCj4gKwkJY29tcGF0
aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJmaXhlZC01
ViI7DQo+ICsJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+Ow0KPiArCQlyZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLWJvb3Qtb247
DQo+ICsJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ICsJfTsNCj4gIH07DQpVc3VhbGx5IGlmIHdl
IHVzZSBhIGdwaW8gdG8gY29udHJvbCBhIHN3aXRjaCB0byB0dXJuIG9uL29mZiBwb3dlciwgd2UN
Cm1vZGVsIGl0IGFzIGEgZml4ZWQgcmVndWxhdG9yLCBidXQgaGVyZSBubyBncGlvIHByb3ZpZGVk
IGluIHJlZ18zcDN2DQphbmQgcmVnXzV2LCBpZiBubyBncGlvIHVzZWQsIG5vIG5lZWQgdGhlc2Ug
dHdvIGZpeGVkIHJlZ3VsYXRvcnMgdG9vLg0KDQo+ICANCj4gICZjcnlwdG8gew0KPiBAQCAtMTQw
LDYgKzE1OCwxMiBAQCAmc3BpMSB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gIA0K
PiArJnNzdXNiIHsNCj4gKwl2dXNiMzMtc3VwcGx5ID0gPCZyZWdfM3Azdj47DQo+ICsJdmJ1cy1z
dXBwbHkgPSA8JnJlZ181dj47DQpUaGVzZSB0d28gc3VwcGx5IGNhbiBiZSByZW1vdmVkIGlmIG5v
IHN3aXRoIHRvIGNvbnRyb2wgdGhlbSwgdGhleSBhcmUNCm9wdGlvbmFsLg0KDQo+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiAgJnN3aXRjaCB7DQo+ICAJcG9ydHMgew0KPiAgCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gQEAgLTIwMSw2ICsyMjUsMTAgQEAgJnVhcnQyIHsNCj4g
IAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiAgDQo+ICsmdXNiX3BoeSB7DQo+ICsJc3RhdHVz
ID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiAgJndpZmkgew0KPiAgCXN0YXR1cyA9ICJva2F5IjsN
Cj4gIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZGJkYyI7DQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmEuZHRzaQ0KPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS5kdHNpDQo+IGluZGV4IDI5ZGE5YjhlZDc1My4uYzY5
YjhiZmY3ZjRhIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
Nzk4NmEuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmEu
ZHRzaQ0KPiBAQCAtMjgxLDYgKzI4MSw2MSBAQCBzcGkxOiBzcGlAMTEwMGIwMDAgew0KPiAgCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAkJfTsNCj4gIA0KPiArCQlzc3VzYjogdXNiQDExMjAw
MDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3OTg2LXhoY2kiLA0KPiArCQkJ
CSAgICAgIm1lZGlhdGVrLG10ay14aGNpIjsNCj4gKwkJCXJlZyA9IDwwIDB4MTEyMDAwMDAgMCAw
eDJlMDA+LA0KPiArCQkJICAgICAgPDAgMHgxMTIwM2UwMCAwIDB4MDEwMD47DQo+ICsJCQlyZWct
bmFtZXMgPSAibWFjIiwgImlwcGMiOw0KPiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE3MyBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gKwkJCWNsb2NrcyA9IDwmaW5mcmFjZmcgQ0xLX0lORlJB
X0lVU0JfU1lTX0NLPiwNCj4gKwkJCQkgPCZpbmZyYWNmZyBDTEtfSU5GUkFfSVVTQl9DSz4sDQo+
ICsJCQkJIDwmaW5mcmFjZmcgQ0xLX0lORlJBX0lVU0JfMTMzX0NLPiwNCj4gKwkJCQkgPCZpbmZy
YWNmZyBDTEtfSU5GUkFfSVVTQl82Nk1fQ0s+LA0KPiArCQkJCSA8JnRvcGNrZ2VuIENMS19UT1Bf
VTJVM19YSENJX1NFTD47DQo+ICsJCQljbG9jay1uYW1lcyA9ICJzeXNfY2siLA0KPiArCQkJCSAg
ICAgICJyZWZfY2siLA0KPiArCQkJCSAgICAgICJtY3VfY2siLA0KPiArCQkJCSAgICAgICJkbWFf
Y2siLA0KPiArCQkJCSAgICAgICJ4aGNpX2NrIjsNCj4gKwkJCXBoeXMgPSA8JnUycG9ydDAgUEhZ
X1RZUEVfVVNCMj4sDQo+ICsJCQkgICAgICAgPCZ1M3BvcnQwIFBIWV9UWVBFX1VTQjM+LA0KPiAr
CQkJICAgICAgIDwmdTJwb3J0MSBQSFlfVFlQRV9VU0IyPjsNCj4gKwkJCXN0YXR1cyA9ICJkaXNh
YmxlZCI7DQo+ICsJCX07DQo+ICsNCj4gKwkJdXNiX3BoeTogdC1waHlAMTFlMTAwMDAgew0KPiAr
CQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDc5ODYtdHBoeSIsDQo+ICsJCQkJICAgICAibWVk
aWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAr
CQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXMgPSA8MCAwIDB4MTFlMTAwMDAgMHgx
NzAwPjsNCj4gKwkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCXUycG9ydDA6IHVz
Yi1waHlAMCB7DQo+ICsJCQkJcmVnID0gPDB4MCAweDcwMD47DQo+ICsJCQkJY2xvY2tzID0gPCZ0
b3Bja2dlbg0KPiBDTEtfVE9QX0RBX1UyX1JFRlNFTD4sDQo+ICsJCQkJCSA8JnRvcGNrZ2VuDQo+
IENMS19UT1BfREFfVTJfQ0tfMVBfU0VMPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiLCAi
ZGFfcmVmIjsNCj4gKwkJCQkjcGh5LWNlbGxzID0gPDE+Ow0KPiArCQkJfTsNCj4gKw0KPiArCQkJ
dTNwb3J0MDogdXNiLXBoeUA3MDAgew0KPiArCQkJCXJlZyA9IDwweDcwMCAweDkwMD47DQo+ICsJ
CQkJY2xvY2tzID0gPCZ0b3Bja2dlbg0KPiBDTEtfVE9QX1VTQjNfUEhZX1NFTD47DQo+ICsJCQkJ
Y2xvY2stbmFtZXMgPSAicmVmIjsNCj4gKwkJCQkjcGh5LWNlbGxzID0gPDE+Ow0KPiArCQkJfTsN
Cj4gKw0KPiArCQkJdTJwb3J0MTogdXNiLXBoeUAxMDAwIHsNCj4gKwkJCQlyZWcgPSA8MHgxMDAw
IDB4NzAwPjsNCj4gKwkJCQljbG9ja3MgPSA8JnRvcGNrZ2VuDQo+IENMS19UT1BfREFfVTJfUkVG
U0VMPiwNCj4gKwkJCQkJIDwmdG9wY2tnZW4NCj4gQ0xLX1RPUF9EQV9VMl9DS18xUF9TRUw+Ow0K
PiArCQkJCWNsb2NrLW5hbWVzID0gInJlZiIsICJkYV9yZWYiOw0KPiArCQkJCSNwaHktY2VsbHMg
PSA8MT47DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArDQo+ICAJCWV0aHN5czogc3lzY29uQDE1MDAw
MDAwIHsNCj4gIAkJCSAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJCSAjc2l6ZS1jZWxscyA9
IDwxPjsNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2
Yi1yZmIuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZiLXJmYi5k
dHMNCj4gaW5kZXggMmM3ZjFkNGZiMzUyLi5hOTgwMjUxMTJiNWEgMTAwNjQ0DQo+IC0tLSBhL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2Yi1yZmIuZHRzDQo+ICsrKyBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2Yi1yZmIuZHRzDQo+IEBAIC0yMyw2ICsyMywy
NCBAQCBtZW1vcnlANDAwMDAwMDAgew0KPiAgCQlkZXZpY2VfdHlwZSA9ICJtZW1vcnkiOw0KPiAg
CQlyZWcgPSA8MCAweDQwMDAwMDAwIDAgMHg0MDAwMDAwMD47DQo+ICAJfTsNCj4gKw0KPiArCXJl
Z18zcDN2OiByZWd1bGF0b3ItM3AzdiB7DQo+ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZp
eGVkIjsNCj4gKwkJcmVndWxhdG9yLW5hbWUgPSAiZml4ZWQtMy4zViI7DQo+ICsJCXJlZ3VsYXRv
ci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9s
dCA9IDwzMzAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLWJvb3Qtb247DQo+ICsJCXJlZ3VsYXRvci1h
bHdheXMtb247DQo+ICsJfTsNCj4gKw0KPiArCXJlZ181djogcmVndWxhdG9yLTV2IHsNCj4gKwkJ
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJm
aXhlZC01ViI7DQo+ICsJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDUwMDAwMDA+Ow0KPiAr
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLWJv
b3Qtb247DQo+ICsJCXJlZ3VsYXRvci1hbHdheXMtb247DQpkaXR0bw0KPiArCX07DQo+ICB9Ow0K
PiAgDQo+ICAmY3J5cHRvIHsNCj4gQEAgLTE2NywxMCArMTg1LDIwIEBAICZzcGkxIHsNCj4gIAlz
dGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiAgDQo+ICsmc3N1c2Igew0KPiArCXZ1c2IzMy1zdXBw
bHkgPSA8JnJlZ18zcDN2PjsNCj4gKwl2YnVzLXN1cHBseSA9IDwmcmVnXzV2PjsNCmRpdHRvDQoN
Cj4gKwlzdGF0dXMgPSAib2theSI7DQo+ICt9Ow0KPiArDQo+ICAmdWFydDAgew0KPiAgCXN0YXR1
cyA9ICJva2F5IjsNCj4gIH07DQo+ICANCj4gKyZ1c2JfcGh5IHsNCj4gKwlzdGF0dXMgPSAib2th
eSI7DQo+ICt9Ow0KPiArDQo+ICAmd2lmaSB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJkYmRjIjsNCg==
