Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381436275D4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiKNGPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKNGPw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:15:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4A4DE9C;
        Sun, 13 Nov 2022 22:15:50 -0800 (PST)
X-UUID: 964ff4fd54dc4c1cb3fc30a9fe14b5e3-20221114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JQ1ol7OTd159O9qOlR+xwWId6J149MRvixyhE0gZA4E=;
        b=gkfvB89YP2ruaItLv9GgidS8FCaMxZWmY96VvLT/MgbC7+2sYL3YQssuu8ns/g3WsiNfOt/I/xNDwHux7eV10t/SC5+uDQfAK6wzWSoVZ63r/InsnKp61VNrlikVT3yxPEHM4LdxPKqbcJC5I7TO9Xpf2+c1csNsZSzvSnO5cjQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:5ebac881-0ccb-4be4-bab4-fb91c81bf637,IP:0,U
        RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:25
X-CID-META: VersionHash:62cd327,CLOUDID:04f6d929-8055-4e28-ab7d-2959ba08645e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 964ff4fd54dc4c1cb3fc30a9fe14b5e3-20221114
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1564705800; Mon, 14 Nov 2022 14:15:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 14 Nov 2022 14:15:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 14 Nov 2022 14:15:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbxEO5sM2Y2Zjr8D9HafqHXbXzLH1hKUNSUT6qAPL6llYK99GVZWpiJZEjiwz4Qda7pCZM8asasxrr2yndX+iar7dhBBd98kWYGcaXGK62hVN7vC9kHWfE3qFzr7vYSb4IXulMQVv/pwEDsVnYtJaA+r3CDijue6mee9rrvaLKmH0aLX18mzQ2Vk1usvJBNgMnMQgvsA4DKemvK7SBMdy/bHRhXpQR3LPRBkPCoYxfe+yeMKSr0Xsx6UhMZHwqH/+S8o3JFQnYXEdcK82W6zb1zRypQO2+4Ym6kp1J0FuJyRHKWrEigvjxcI3hjb6g3sHGy/MbNHxIFn9ilMggKlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQ1ol7OTd159O9qOlR+xwWId6J149MRvixyhE0gZA4E=;
 b=KMkO5rUQsADJD001PYyn4BJAQQ8NmeJp2yZBivATaE+St23Rfzkfp1UpaqKmiBXsiJ1A8VHPgJQA1BQvjFc7wldSofuPVQdYyiktSU+n0XAIdiPs3XC/rGTVOLeJbDiGnBH4AcLQtE7sfXjzn0q9w/7D86Cx9pwPX61YXbGhlP4giucrn9OB7T7k0IoZgDI4vlu83Dersb+FMlcHv0PHIRCZHv380aXHW4BxEeuwa/eGGlAVv5nx1pYBwFzZ8GxNs0JwV6mXo/ahg4E0a16ImWeo2SMagvtABhgqFuHKH0ToQKqerpjVZURV4Ut4MMU1RQRQChzMAhPRq8Wmdllkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ1ol7OTd159O9qOlR+xwWId6J149MRvixyhE0gZA4E=;
 b=QnxBX/MdpKREDs6N8PtzJhNncFWJ/PAyoJ/k+eNnnUls4JX5wcx9wV7mYlLO7USS3/ciAuEqWoSemyRZLqH2el7r8RUNWiYnVpfXe+TiOFz4kdHZ+z8TBYqYPxkSl9R/bNqEwxN5U/yGHqf7UIyacdTg2BvAj4973uxJeXnbxBo=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SEYPR03MB6481.apcprd03.prod.outlook.com (2603:1096:101:51::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 06:15:38 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 06:15:38 +0000
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
Subject: Re: [PATCH v4 07/11] arm64: dts: mt7986: add usb related device nodes
Thread-Topic: [PATCH v4 07/11] arm64: dts: mt7986: add usb related device
 nodes
Thread-Index: AQHY9nefQfrqiyajkUSPNiketoB1hq499BaA
Date:   Mon, 14 Nov 2022 06:15:38 +0000
Message-ID: <9a358e2ef4e6faffa03d227fa947cd30f7e8188a.camel@mediatek.com>
References: <20221112091518.7846-1-linux@fw-web.de>
         <20221112091518.7846-8-linux@fw-web.de>
In-Reply-To: <20221112091518.7846-8-linux@fw-web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SEYPR03MB6481:EE_
x-ms-office365-filtering-correlation-id: 66285b48-3ec0-4f4d-63ec-08dac607a648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+PB1JaxJOcDeMdM5x6QF6m9BTI9YblahzaX2QvhflFbc9OcC7Va/6D7QIGMWdKxBGLOJWKBpQFxBxdma6nrEms0GzWD6wLybZt4t4Uv+lKbWIdOrLrADtrnNASeV+bmCBI63upt7TvUCmHWRu1E410XRsMGMnTNhhGuAv5OCsDEw41GZP3Ksm6hgouSF/zTMt437jLSkVChI/ApjIOGT36ybtNXM3C1RhwF5Xr9Ox6jhEQQ4Aj/hjzSAzay3zLM1xNhxg6OUyxKSt1crLz7YI4z9K5rtqyjCKKol/BOi0n870aSD7rt6jBWlt/Tzh2xYblRimB6zKID7T8K+0o7atqzQePOhV/nDxjEw9iPAp8TL8HzJ5333f+UtpWoEMme72lwhEVUIzyAVkKdhc5iRlkjnRBjaL4kqjIxNy7pPL1NKptNSviSOvqBXJaKpA6oveCkyhMq/m/aS5e2tJsACbD0UROeva3cjIsdSLB9JhmibMJ4+kL1wFyMwt4waAkeaCJtfKgXwKGbm7XwE9Z38UaiTelsH7HDMgEoN/JIkQToqxCGjqsuWaG1h9al9s84hBaLeREzCUXrquEUuQPPN0ZG3PjJXzQNr8xfF/OryVQt6g6/RIsNDj4xZkltQmmnpxS+eP+6IYy4ooDvBYoXi7Eryd++498ybsbxJlfrymnDmgKAgjBEFeu9LQPuqy6bWEFykXi2gLC+hjJzFP/3ArORAL5Ut1ccmNYFz+3m2wStTXEIQJFi7wG6q8VlEUGLOfEdAgX5OdlOZUOVsL62o4fZlPii2xehxtXTZ9deJVrDLpux3CNRBhvbVhwolQKxFqfmRk/gy5dOb0A1KFzgBr8NjS+++MYgV5hNSFx1GcHxY0pM5+A/BGBnpzqyk2Hg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(38070700005)(2906002)(186003)(4001150100001)(122000001)(38100700002)(86362001)(83380400001)(2616005)(110136005)(6512007)(26005)(6486002)(478600001)(71200400001)(4326008)(66476007)(66446008)(66946007)(76116006)(91956017)(966005)(8676002)(64756008)(41300700001)(5660300002)(66556008)(6506007)(8936002)(54906003)(7416002)(316002)(36756003)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHE1RkhSNWNNMDludk5naHh2Y2ptUStRaXcxUU1JVTl2ZFZnYmZpTjBNUTlU?=
 =?utf-8?B?K0xYN0xUd1ptUk9KaUdaRENOYTROUVlnbDZQNE9sc2lRTUZBbndOKzNEV1VJ?=
 =?utf-8?B?RlZoVE5GWlRIYVVPVDdiVVFaUzBEdjNKeWsxYUZvYjFrNHVBb25Nc0pqT2xo?=
 =?utf-8?B?dmEra2J2THJlS1ZSTVlVbGJkeWdXbEREUWtjaGN4a3VhMUxVcUJEdnZFYi80?=
 =?utf-8?B?K3Rpdjh1UkdKaUN4QTV3OGJFaWVzWGFicmRVUlhtNXJ0aEVyWEFsNUNLd0xx?=
 =?utf-8?B?RGxjM2h2UEVXeVdNRmEwenhIeFJPWXNWeXVxNldReDhpTmZTZ09LekJiYXJn?=
 =?utf-8?B?ejFWcDdaRUdScDVTbUVwc2NYWDRCMGk0d2taT0NPOGI0aTY0eW1GS0RaTGpQ?=
 =?utf-8?B?TU1kK0t0TnhSaGozVnd2YXpLR0g2bFZMT1JyTkhvYkFZTHBUUG9KUE1FOHFD?=
 =?utf-8?B?YVJTaWpQS0JXblY2aWpaMVhpanpYa2sxSmZ4VEo0dWJkRWlqaVU2NHNXTEZJ?=
 =?utf-8?B?SzdJTmpRSDJHa25aSEdTSFk5aXVZNlJGdlhjRjFQSHNjY0ZnMklIZUJXbHdG?=
 =?utf-8?B?TWgrSXdhaUxnV09zN2ZnQVZnWjdPazNPbzJxM2VSc01ua0hhMDE3VjRQcG13?=
 =?utf-8?B?UmlTUy9USGxJS2hadGhXYW5ScWgwd1Y5UEdUbWtFQ0d0Zjg1bmRoV2YwQkdF?=
 =?utf-8?B?R2Ewb0FJVlo4Z1pGUFMvUTVKU2pIM0ZobTJhM3pDTEhrNFl1SE1CZmdjL1JT?=
 =?utf-8?B?dFdJamgrVjNtTjNoWjF0QnZLQmU0UGtZWkN5dTBoUlZ5amV6WHMvalJHd08r?=
 =?utf-8?B?NGVYMXI4bEx1MGJoRjZNZ3hQR3lKellHSjQrZy94WlV0aldYcm5NWHByZEVI?=
 =?utf-8?B?NzhNOTA3dFphZ2JUWTV5TElkYzhFeXNnV1Z3QmJ4cjkvVm00QTJJSW5WOWxx?=
 =?utf-8?B?YnBVQ1g1VjNXNGQyeFhyUDEyZURveEF3aVZlQ2dLUHBSMXM1OHdSS21ra0FQ?=
 =?utf-8?B?TUE3cHdPRHYxMXJMQ0lFK2JZYUpIcVhsODZoTGJxVXF2dHErWERzR3J3TTJD?=
 =?utf-8?B?b09uU0xrclRCelU2aThvVnJNeEcxN2RpZDQ1WDJDSkI0bXVwaXlkZ3VDYzY2?=
 =?utf-8?B?Nmo4MjQ3Z0pmUDBXMUtRRFJnd0h5STBjeWhjNnI1V25wWEh2dVoxNWsrT2JL?=
 =?utf-8?B?dDBuYm5GWlJ2S0lLRkl5bC9XODZkNGVrcGhCNkJKT24rR2ZNZDBaV00wazR5?=
 =?utf-8?B?ZXBzbUZROGd4bVFLQ3NpajVNR3ZZUHlYZ1dEMjU3UGp6anJBMTlFWkZkcFFX?=
 =?utf-8?B?STlWT25UQnREeFN3K3Z1ZDBvUkkwOE9sdDRXc0J1MWJYZUR4cWxiUC9zSWto?=
 =?utf-8?B?R3E1T3kxRW9uTUVkNnFqM0xwZEw4QlFXck9TSFRocGI2WTRjUkk4SlVNOGZQ?=
 =?utf-8?B?bE1FQXpidmsrTGJxQ2Foc1E4MXVmVjJoeCtyYWJHSmh1bHcyOVptSExrclBP?=
 =?utf-8?B?VHMvMmJzZWQrRlQ1MEM4RDg0ME9yR3MxY2thV3NLV25aU0NRYXcyN3pKN1Ez?=
 =?utf-8?B?QUU3amZHNW1PNlFGWkVibUxIYlZvUlBHckFTb0w0ZUlOeWd4dWM1ZXovU0Jl?=
 =?utf-8?B?Z1BPdnZGVTZjbENZTXZIdEx5a2o0d3pJMVVMUTN4OC9mSTVBd0hBVlo4RDZI?=
 =?utf-8?B?ejJuS1lLcXJJOE5DOVRqdXI2NFNnekcrcVdGd3hCb2MwZDlsWkFhS0kwOWFX?=
 =?utf-8?B?a1l1cGs2V2pkbXI1OTZPRE1QNk5FQlRXcis3RXZ4Vlo5T2dKeEVmR3RlZ0NF?=
 =?utf-8?B?Qys0WTYrQnVVRkQ2M05STEdTb1NTOGlzM3hrQTJha3A3aWorVC9nR3BRT2U2?=
 =?utf-8?B?QVVwL09Ed1VZUXE2MVlpRUoveWhZbmRkdzUrRlNGSmhCY2cwRU5OZ00ycEZo?=
 =?utf-8?B?TUwwMC8vcGVIVDNGVjh5Q0JybExRU1paTXIvYWV2TG1Dc3lJYzNYUXRsNzFj?=
 =?utf-8?B?MExKYnJBbVdhTW5hb2JDWHhHVXNmVmduTHZTRDg1NVI5SnJnWHpHQU5Semhj?=
 =?utf-8?B?YWRZeExoVVN0YWpxT3E1SWVzNUo5MWlZcDdYSGJqTEhsS0dsNnlkT3U2ajYw?=
 =?utf-8?B?bS9NaUxibHl1RC9NTnZqemRxU3lrcUFweVUwQmFpekhwTFVNb3ZpaUxIZnRL?=
 =?utf-8?B?eVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6915EA7E28723D4E8C4A1A45D9F0FCF8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66285b48-3ec0-4f4d-63ec-08dac607a648
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 06:15:38.3023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8ctebuyLuNp+JKQt2fFkT48Zp+8uU7PDUCttlQBVoaXai2rQu0lpFAkUK0vbh6EHtUIwyE7YDh+c4ZMJ9wa5o2lILp2OtB0LjhG2mgXdmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6481
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDIyLTExLTEyIGF0IDEwOjE1ICswMTAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBGcm9tOiBTYW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KPiANCj4gVGhpcyBw
YXRjaCBhZGRzIFVTQiBzdXBwb3J0IGZvciBNVDc5ODYuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBT
YW0gU2hpaCA8c2FtLnNoaWhAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBX
dW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4gLS0tDQo+IGNoYW5nZXMgY29t
cGFyZWQgdG8gc2FtcyBvcmlnaW5hbCB2ZXJzaW9uOg0KPiAtIHJlb3JkZXIgeGhjaS1jbG9ja3Mg
YmFzZWQgb24geWFtbCBiaW5kaW5nDQo+IC0tLQ0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDc5ODZhLXJmYi5kdHMgfCAyOCArKysrKysrKysrDQo+ICBhcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210Nzk4NmEuZHRzaSAgICB8IDU1DQo+ICsrKysrKysrKysrKysrKysrKysr
DQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmItcmZiLmR0cyB8IDI4ICsr
KysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Nzk4NmEtcmZiLmR0cw0K
PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3OTg2YS1yZmIuZHRzDQo+IGluZGV4
IDAwNjg3OGUzZjJiMi4uMmI1ZDdlYTMxYjRkIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210Nzk4NmEtcmZiLmR0cw0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL21lZGlhdGVrL210Nzk4NmEtcmZiLmR0cw0KPiBAQCAtMjMsNiArMjMsMjQgQEAgbWVtb3J5
QDQwMDAwMDAwIHsNCj4gIAkJZGV2aWNlX3R5cGUgPSAibWVtb3J5IjsNCj4gIAkJcmVnID0gPDAg
MHg0MDAwMDAwMCAwIDB4NDAwMDAwMDA+Ow0KPiAgCX07DQo+ICsNCj4gKwlyZWdfM3AzdjogcmVn
dWxhdG9yLTNwM3Ygew0KPiArCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+ICsJ
CXJlZ3VsYXRvci1uYW1lID0gImZpeGVkLTMuM1YiOw0KPiArCQlyZWd1bGF0b3ItbWluLW1pY3Jv
dm9sdCA9IDwzMzAwMDAwPjsNCj4gKwkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAw
MD47DQo+ICsJCXJlZ3VsYXRvci1ib290LW9uOw0KPiArCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0K
PiArCX07DQo+ICsNCj4gKwlyZWdfNXY6IHJlZ3VsYXRvci01diB7DQo+ICsJCWNvbXBhdGlibGUg
PSAicmVndWxhdG9yLWZpeGVkIjsNCj4gKwkJcmVndWxhdG9yLW5hbWUgPSAiZml4ZWQtNVYiOw0K
PiArCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsNCj4gKwkJcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8NTAwMDAwMD47DQo+ICsJCXJlZ3VsYXRvci1ib290LW9uOw0KPiAr
CQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KPiArCX07DQo+ICB9Ow0KPiAgDQo+ICAmY3J5cHRvIHsN
Cj4gQEAgLTE0MCw2ICsxNTgsMTIgQEAgJnNwaTEgew0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4g
IH07DQo+ICANCj4gKyZzc3VzYiB7DQo+ICsJdnVzYjMzLXN1cHBseSA9IDwmcmVnXzNwM3Y+Ow0K
PiArCXZidXMtc3VwcGx5ID0gPCZyZWdfNXY+Ow0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307
DQo+ICsNCj4gICZzd2l0Y2ggew0KPiAgCXBvcnRzIHsNCj4gIAkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQo+IEBAIC0yMDEsNiArMjI1LDEwIEBAICZ1YXJ0MiB7DQo+ICAJc3RhdHVzID0gIm9rYXki
Ow0KPiAgfTsNCj4gIA0KPiArJnVzYl9waHkgew0KPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gK307
DQo+ICsNCj4gICZ3aWZpIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICAJcGluY3RybC1uYW1l
cyA9ICJkZWZhdWx0IiwgImRiZGMiOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDc5ODZhLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210Nzk4NmEuZHRzaQ0KPiBpbmRleCAyOWRhOWI4ZWQ3NTMuLjJiY2Y0ODg5MGJhOCAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZhLmR0c2kNCj4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZhLmR0c2kNCj4gQEAgLTI4MSw2
ICsyODEsNjEgQEAgc3BpMTogc3BpQDExMDBiMDAwIHsNCj4gIAkJCXN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+ICAJCX07DQo+ICANCj4gKwkJc3N1c2I6IHVzYkAxMTIwMDAwMCB7DQo+ICsJCQljb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10Nzk4Ni14aGNpIiwNCj4gKwkJCQkgICAgICJtZWRpYXRlayxt
dGsteGhjaSI7DQo+ICsJCQlyZWcgPSA8MCAweDExMjAwMDAwIDAgMHgyZTAwPiwNCj4gKwkJCSAg
ICAgIDwwIDB4MTEyMDNlMDAgMCAweDAxMDA+Ow0KPiArCQkJcmVnLW5hbWVzID0gIm1hYyIsICJp
cHBjIjsNCj4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxNzMgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+ICsJCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9JVVNCX1NZU19DSz4sDQo+
ICsJCQkJIDwmaW5mcmFjZmcgQ0xLX0lORlJBX0lVU0JfQ0s+LA0KPiArCQkJCSA8JmluZnJhY2Zn
IENMS19JTkZSQV9JVVNCXzEzM19DSz4sDQo+ICsJCQkJIDwmaW5mcmFjZmcgQ0xLX0lORlJBX0lV
U0JfNjZNX0NLPiwNCj4gKwkJCQkgPCZ0b3Bja2dlbiBDTEtfVE9QX1UyVTNfWEhDSV9TRUw+Ow0K
PiArCQkJY2xvY2stbmFtZXMgPSAic3lzX2NrIiwNCj4gKwkJCQkgICAgICAicmVmX2NrIiwNCj4g
KwkJCQkgICAgICAibWN1X2NrIiwNCj4gKwkJCQkgICAgICAiZG1hX2NrIiwNCj4gKwkJCQkgICAg
ICAieGhjaV9jayI7DQo+ICsJCQlwaHlzID0gPCZ1MnBvcnQwIFBIWV9UWVBFX1VTQjI+LA0KPiAr
CQkJICAgICAgIDwmdTNwb3J0MCBQSFlfVFlQRV9VU0IzPiwNCj4gKwkJCSAgICAgICA8JnUycG9y
dDEgUEhZX1RZUEVfVVNCMj47DQo+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQl9Ow0K
PiArDQo+ICsJCXVzYl9waHk6IHQtcGh5QDExZTEwMDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ3OTg2LXRwaHkiLA0KPiArCQkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBo
eS12MiI7DQo+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gKwkJCSNzaXplLWNlbGxzID0g
PDI+Ow0KPiArCQkJcmFuZ2VzOw0KUGxlYXNlIHVzZSByYW5nZXMgd2l0aCBhIHRyaXBsZXQgdmFs
dWUgKGNoaWxkLCBwYXJlbnQsIGxlbiksIHJlZmVycyB0bzoNCg0KDQpodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQyNzEyZS5kdHNpI0w4OTENCg0KVGhhbmtzIGEgbG90DQoNCj4gKwkJCXN0YXR1cyA9ICJk
aXNhYmxlZCI7DQo+ICsNCj4gKwkJCXUycG9ydDA6IHVzYi1waHlAMTFlMTAwMDAgew0KPiArCQkJ
CXJlZyA9IDwwIDB4MTFlMTAwMDAgMCAweDcwMD47DQo+ICsJCQkJY2xvY2tzID0gPCZ0b3Bja2dl
bg0KPiBDTEtfVE9QX0RBX1UyX1JFRlNFTD4sDQo+ICsJCQkJCSA8JnRvcGNrZ2VuDQo+IENMS19U
T1BfREFfVTJfQ0tfMVBfU0VMPjsNCj4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiLCAiZGFfcmVm
IjsNCj4gKwkJCQkjcGh5LWNlbGxzID0gPDE+Ow0KPiArCQkJfTsNCj4gKw0KPiArCQkJdTNwb3J0
MDogdXNiLXBoeUAxMWUxMDcwMCB7DQo+ICsJCQkJcmVnID0gPDAgMHgxMWUxMDcwMCAwIDB4OTAw
PjsNCj4gKwkJCQljbG9ja3MgPSA8JnRvcGNrZ2VuDQo+IENMS19UT1BfVVNCM19QSFlfU0VMPjsN
Cj4gKwkJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiArCQkJCSNwaHktY2VsbHMgPSA8MT47DQo+
ICsJCQl9Ow0KPiArDQo+ICsJCQl1MnBvcnQxOiB1c2ItcGh5QDExZTExMDAwIHsNCj4gKwkJCQly
ZWcgPSA8MCAweDExZTExMDAwIDAgMHg3MDA+Ow0KPiArCQkJCWNsb2NrcyA9IDwmdG9wY2tnZW4N
Cj4gQ0xLX1RPUF9EQV9VMl9SRUZTRUw+LA0KPiArCQkJCQkgPCZ0b3Bja2dlbg0KPiBDTEtfVE9Q
X0RBX1UyX0NLXzFQX1NFTD47DQo+ICsJCQkJY2xvY2stbmFtZXMgPSAicmVmIiwgImRhX3JlZiI7
DQo+ICsJCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gKwkJCX07DQo+ICsJCX07DQo+ICsNCj4gIAkJ
ZXRoc3lzOiBzeXNjb25AMTUwMDAwMDAgew0KPiAgCQkJICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
PiAgCQkJICNzaXplLWNlbGxzID0gPDE+Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDc5ODZiLXJmYi5kdHMNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210Nzk4NmItcmZiLmR0cw0KPiBpbmRleCAyYzdmMWQ0ZmIzNTIuLmE5ODAyNTExMmI1
YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZiLXJm
Yi5kdHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc5ODZiLXJmYi5k
dHMNCj4gQEAgLTIzLDYgKzIzLDI0IEBAIG1lbW9yeUA0MDAwMDAwMCB7DQo+ICAJCWRldmljZV90
eXBlID0gIm1lbW9yeSI7DQo+ICAJCXJlZyA9IDwwIDB4NDAwMDAwMDAgMCAweDQwMDAwMDAwPjsN
Cj4gIAl9Ow0KPiArDQo+ICsJcmVnXzNwM3Y6IHJlZ3VsYXRvci0zcDN2IHsNCj4gKwkJY29tcGF0
aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJmaXhlZC0z
LjNWIjsNCj4gKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ICsJCXJl
Z3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiArCQlyZWd1bGF0b3ItYm9vdC1v
bjsNCj4gKwkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4gKwl9Ow0KPiArDQo+ICsJcmVnXzV2OiBy
ZWd1bGF0b3ItNXYgew0KPiArCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+ICsJ
CXJlZ3VsYXRvci1uYW1lID0gImZpeGVkLTVWIjsNCj4gKwkJcmVndWxhdG9yLW1pbi1taWNyb3Zv
bHQgPSA8NTAwMDAwMD47DQo+ICsJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+
Ow0KPiArCQlyZWd1bGF0b3ItYm9vdC1vbjsNCj4gKwkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4g
Kwl9Ow0KPiAgfTsNCj4gIA0KPiAgJmNyeXB0byB7DQo+IEBAIC0xNjcsMTAgKzE4NSwyMCBAQCAm
c3BpMSB7DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgfTsNCj4gIA0KPiArJnNzdXNiIHsNCj4g
Kwl2dXNiMzMtc3VwcGx5ID0gPCZyZWdfM3Azdj47DQo+ICsJdmJ1cy1zdXBwbHkgPSA8JnJlZ181
dj47DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArfTsNCj4gKw0KPiAgJnVhcnQwIHsNCj4gIAlz
dGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiAgDQo+ICsmdXNiX3BoeSB7DQo+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiArfTsNCj4gKw0KPiAgJndpZmkgew0KPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4g
IAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiZGJkYyI7DQo=
