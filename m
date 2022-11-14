Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518DE6275BE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 07:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiKNGGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 01:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiKNGGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 01:06:11 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B4A646F;
        Sun, 13 Nov 2022 22:06:05 -0800 (PST)
X-UUID: eeacaccedf174530ae6b31c9e58da49e-20221114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DUgRwl/6uNZ9dYS784fImzN572OVVwlmVIDL0bmDxFk=;
        b=GGDQTAWtX4JgD0SbBK36Y4JtzIHTbVu6fG56CcgubpBgxR5wUH/NufundVI1vjGXO4C6825gnllij5iTm2KjRQPIO9K2wsIP9rAni5rxEDwKiq07Bikm7KEO+V0nXxjFKj6xt6+1qxBKFA+F1wfW80DO3C4NhYVCLYualYa1rGA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:1fb2d9cc-cef2-4c0e-a2b5-0c3cc08c1b1b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.12,REQID:1fb2d9cc-cef2-4c0e-a2b5-0c3cc08c1b1b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:4376a7dd-c087-4fa8-aefb-7a0acf417f59,B
        ulkID:2211141405599C6R7XNJ,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: eeacaccedf174530ae6b31c9e58da49e-20221114
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 547834706; Mon, 14 Nov 2022 14:05:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 14 Nov 2022 14:05:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 14 Nov 2022 14:05:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLrTYysBq2Rro5TE433uSASYZCDyvS3/KQ6cpnWhSoSGvdW+8x9STJee1SKTeT0Bg9zT3/qjVxGR6Jgjw4s9zDj0T9Slg0fx7tDEgbWmowvxevtSPwh3dP3HD7SpwRG7sMAZbeWjXfYKVdLOjiaI6Q4YVsQJPyA61ZJQVCzGCUNMbmW2E9Duay8xPs5tndQfWv650UiQ86GMYPAf1x9JRxr8G1S32BDzIzFmMk/M5x1lcIrAliwi3YS58W7wMnYBQdy5raozrcr3aaOhxI/8pyONnVPoVwAx2jV5jlskoBA3UGDAXLxfoTuzOm6m1V6PA8W2qPSQ2AMjtuL7LvU1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUgRwl/6uNZ9dYS784fImzN572OVVwlmVIDL0bmDxFk=;
 b=Vsmt+AJG5pgTRieYeqweJ3j6zDpZcrttkLQ6euDMs0ON/ARj3Lin8dXO/pqdOxu3K5WQQRv3ZgS14tT+pXBtpjtCtL+xmxemJx32Jc4NFHWK3p0t2Wxd/jG2ZSA4pymgP+KOgrNIzSV0sRYu9wZ+Egkh38XMdpFmnlw5OiYqjVuyZB+8BAqSlOPv5vshWxL6LpUBbyuItzy90PTn27iw4qYOO7MpALpZfZwHiGuEJJhzwdCwlLIqX5/GKctOzTxqYlm1diH/hulPtYR1FRZ/XsIH/sZKDFioNdjV1H7vrWsE1laae1WsnqcopG5Z5dvxzl02IXrVDoPm1bmNgd9lLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUgRwl/6uNZ9dYS784fImzN572OVVwlmVIDL0bmDxFk=;
 b=pfAF26oGtCkRdHMb+bG5zDBFEE0S0UERFap7au+KO95qL4Yb5pFcq29fVP670WUFkN8VBNAlxZOe8+OSbSvL4PZsVRYfdqm92jOgQakrfGDLQABf8vZvXrmHf76aPGxZ6OafiWuZBC9rcPg6dbmx3zOeUWqVyyEBLQ8sOOUQzgQ=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by SI2PR03MB5514.apcprd03.prod.outlook.com (2603:1096:4:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 06:05:55 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::9585:3a04:b796:b696%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 06:05:55 +0000
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
Subject: Re: [PATCH v4 02/11] dt-bindings: phy: mediatek,tphy: add support for
 mt7986
Thread-Topic: [PATCH v4 02/11] dt-bindings: phy: mediatek,tphy: add support
 for mt7986
Thread-Index: AQHY9neYBLZ6Uy7w80CKBDSRe1NgGa498V8A
Date:   Mon, 14 Nov 2022 06:05:55 +0000
Message-ID: <80201824d322ce4f7bf782e63c10beb1d88df5da.camel@mediatek.com>
References: <20221112091518.7846-1-linux@fw-web.de>
         <20221112091518.7846-3-linux@fw-web.de>
In-Reply-To: <20221112091518.7846-3-linux@fw-web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|SI2PR03MB5514:EE_
x-ms-office365-filtering-correlation-id: e240f4b8-f56e-4e55-ba8f-08dac6064aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PX09kGP2hmVi5J0HcBIqmIVwAD21Grdluu3imnF8TG2/UgBs2f2k4qQpXwj118rCXD9tn5cs1a5cWxi+9lb3z1zCnCSjQKmWHvQuFhVBy3ZkeXjh4aSLj4eZ31W7mPAj2hlnya4AoyHt1tAHh86Olsm62KQAAJcR7ZN6ye45GT9H8R7S0WU/HKCOWrHWv8YakdNPN3xxX5RcJKaLvdVy5vmzLv6Qr34m/J2911YHsA4hxwtaTIG8sxjKVL/Nih72/WvSvLa2FlxIyjIyIs3vpPEiWWAror5D5nLLDANYk0rDsvQARwzvzy6VZ3JblQyCl2VP811Jc4U1Dmlbm9iglTtOc0UYrCtwqonx6OMyxWOthCmnlsGVFMVEMmprJ2lXLo507tOGo1MaTFDnEUhvBAGD+dH3PQsPEhLhUU7E73m6XYRPE+Z3usiLQEyxDu4WEOdXGJAVygDVxkLCNawZwFxaDWorTCdmZwYp2u+Qks03czNJIqO5yDVYVD1rNWet8oogYB4LStEOPw0q8IWNGmg4kBBc7+EYA35H02rN/Y7BDAis6JCoYEKm2gfhgcx2ayOdl8QOn2GitNzxTBKiA5uqpHU1VvWfmroiGv/2p1wdQ3kHOUUV1hmjgk3GkLuzXlduCQDUDpI94DAEYDF4xYXJDEkeQKwLr27lkyg0Sv3KJ80Wux70ngfKF6UmTA6PjTTfSqwRAL1CMEvTeNebeWmA0mW4rOd4oH43iA/MPxz265ABGS64NOax17UFblOIMRK/Xpn58ythkcIod1Dqf6Krlt78gy6PcmX6nP2+RCNzemrt2nhJqaxaJb33AvTgF5EbsH8FproA7cyXjA5/2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199015)(2616005)(8936002)(4744005)(38070700005)(478600001)(6486002)(5660300002)(110136005)(54906003)(2906002)(122000001)(316002)(85182001)(71200400001)(36756003)(7416002)(86362001)(66446008)(186003)(76116006)(66476007)(66946007)(66556008)(41300700001)(4326008)(8676002)(91956017)(64756008)(26005)(6512007)(38100700002)(4001150100001)(6506007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUpXWTlZdHdlbHd4c3dhcjQrQXE3a0pkR2REdC9uc2swNDVpdUdTK2Y3OXRr?=
 =?utf-8?B?dVdpS3VQY3pnZEJuUmZTRG1VaVZrOGdvTUxQb2pLN2UrWWVLa1VYMWxweTVT?=
 =?utf-8?B?MXdaOUhtQWxEM0dUZ0lwQVl2U0JkN1JuT3lWNjRwaU5PRG15Zm54TjI3ZGJN?=
 =?utf-8?B?QkJoR28wTERoOE02bDJhNVcvWEtOQWRJTS91eWJTZmxQeDQ1L080YmtMK3NG?=
 =?utf-8?B?cmFpRXlmaVFCdExtU0wxUFJnbHB5ZG40ejgyQytRUmplM2RiRVhvUGQxR3o2?=
 =?utf-8?B?emgrZTkrejJqbUMwaytHR1B6dkJtcms0STdmRDZuM2xoczcyWkxpdXVNNTFI?=
 =?utf-8?B?VHh3VmtLMEZ6MENvbHE5OUFFaEtIM0xhVmJsK1Rhc2Y5bUllVHMrZnJCOFpQ?=
 =?utf-8?B?TG5rNkpvQWpPemNUOVZBUlVIbU5mcUpFdUhzQkZGNTl6SitWTGhSdVFLaXdD?=
 =?utf-8?B?SVZwWHNQTWpKcUxZWUVJQTRraFl0YUttUVBtRzRLSGxYcUw1amFYOGd1OC9T?=
 =?utf-8?B?ZlVYZ1lldFZHdE91a1hwbG1wV3pTMGJLL3hvRmYwWFVtZ2hJZkJ6STY1bTVj?=
 =?utf-8?B?Tk1mVUhFOFBCZHFNNUtmMlFzZ2c2aGE2MGxIR3RPNUdOOURTUGhhQ2tzMzZG?=
 =?utf-8?B?cnNpZFJiSlJ4bGpCZkpYdDh4M0pQSXNDYXlocDZhZTJsTk9DeHBEditzTkN5?=
 =?utf-8?B?UDhGSVRjbjI2cmYxcFJSdnRmaksrTU9DcEFqUG9yNE0zQXJ5T1V3Yy9PNFd4?=
 =?utf-8?B?SGVzRGxrNGR1dCtvTGxaUG1DakJGbitzTW51NkNCdnNyaU9WUmx4cFdKeDlS?=
 =?utf-8?B?OFJVYms4K2RDUm5UVDJLWmpFekZXdTRsZjFJVkpySTM3Z0xYUVJ0NEtDSjJV?=
 =?utf-8?B?V2Y4ekhSdG5pc1ZBZ2wzWU5UOW1HUXEzUE5JbDZ0SHJrWGlCaTdpWE1tdTFI?=
 =?utf-8?B?aW9XRytJL2QyWWZWUEh1TGR0YlZlT00rb1FXOExzRnZ3dnlvQzY3d0hodlhU?=
 =?utf-8?B?MlpPdVVQZTNxYUEvWGhxMVE3RDRBUjlRWTNnQy9xRzBwYnN4WXJpN242Q0xH?=
 =?utf-8?B?eXU1UFBJOVdCVXlWT2E5cFZJY1k4U28zYk9qYXZTczh3RFFRMXEyOWd6ZzlR?=
 =?utf-8?B?bUR1NE9aUmF1QzRxaVpRdUg2ZGw3S2pGRVIzNERyUFdzSUJSOUN6OTREL091?=
 =?utf-8?B?TXcwc0NUUFVhS2QyTGN6RmZFSE9YVGh6THZZcW41TTBsUU9mcmJkeDZ6ZDBJ?=
 =?utf-8?B?VDVXZkg3ZDFCM1dndmVEaU5iTmRZREMzQ1FwM2Y2MzlJWjFGcllVM3JDY2lm?=
 =?utf-8?B?M25rU05vRGMxMklVVkdWT0loRk9aaEFlVDdvN1pmL0s1STZKTW9YTlljM1JR?=
 =?utf-8?B?K0hzdjJIRnMvcURGckEyMnB1b2E5K3V3Z1Y3dW9wNThsZU5oMXpXQnNRTGp1?=
 =?utf-8?B?S1VvRVNMTUpwWUQxQTVhZmhNRVhFKzZQamdLOVlzZ3dWZS9LVUN1bjFUTC9k?=
 =?utf-8?B?RWhESytGVEIyTkJDZXN4SGxJWktEMzFjOVF5WU1IMDFRRndRZTlSRmVYTEtQ?=
 =?utf-8?B?SnBaRGFMazhyclBLWWxNV1VvMnFoVFdNSXRRUzNXSktyb2NpMFR3RTRTOW1H?=
 =?utf-8?B?N0VhRVpDQVBkYWNBRG1JL1V3OVVoTUVuaWdrQjdGK3lKRWs4cHArKzBFQndy?=
 =?utf-8?B?NHBRa2R3S2hQcjhJbkU4SHd0bVpOaGg3V3Z6YmU2QVpCZmdJQVpNdWZwUWhC?=
 =?utf-8?B?alJabTNWNkdRWmRDcmg4TSttTEp2cDZqeG11UTZPZXUwbThiSy9NTHNHSDRq?=
 =?utf-8?B?WXlDM2JhN2tyUFVTOG9wK0hQenVqRytpQlFqT0l0RngrRXNrR24xTit4TzFF?=
 =?utf-8?B?S1crSlNCWENJZDVlQTRiT2VIOUdrek1BUjIxaW9ZemZNWkQrampPMndUUERh?=
 =?utf-8?B?YTFhREY5MkVNc1FNL3R6YnVQRGE1dS9nU2hRdHZ5ZjFFWUIvdlYwK011UWx1?=
 =?utf-8?B?bEozdkFSVzJvelJUTEpKWTBpaVR3L1ZhZnJOV1RDbTlUZmMzT3E1U3B0dXQ3?=
 =?utf-8?B?cnlYUmRZdGV4eVRWbFJnZFEvSVlLb0Q5SEl0UE9icXJGRStxWFkvalpESXQw?=
 =?utf-8?B?ckZTajB1Q2VQVFowWTF4aE4xNXNiY09FZWx1bFljcTF3aHNKVG04cGt1UGRF?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC19A79857FEC74EBDA7CFA5BD8F8531@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e240f4b8-f56e-4e55-ba8f-08dac6064aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 06:05:55.1102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGUUmOUr4ykDwH1XZ5an6DxQPtnw6adwJKW/TFieGjuarSS7A2f9xOfEMhXzHj6CYm3kfpRi0bd4Vzzhjb7Na8761ww+A2570Qag2vIY6gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5514
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDIyLTExLTEyIGF0IDEwOjE1ICswMTAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBGcm9tOiBGcmFuayBXdW5kZXJsaWNoIDxmcmFuay13QHB1YmxpYy1maWxlcy5kZT4NCj4g
DQo+IEFkZCBjb21wYXRpYmxlIHN0cmluZyBmb3IgbXQ3OTg2Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRnJhbmsgV3VuZGVybGljaCA8ZnJhbmstd0BwdWJsaWMtZmlsZXMuZGU+DQo+IC0tLQ0KPiAg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5LnlhbWwg
fCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55
YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0
cGh5LnlhbWwNCj4gaW5kZXggNTYxM2NjNTEwNmUzLi4yMzBhMTdmMjQ5NjYgMTAwNjQ0DQo+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55
YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0
ZWssdHBoeS55YW1sDQo+IEBAIC03OSw2ICs3OSw3IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAg
ICAgLSBlbnVtOg0KPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10MjcxMi10cGh5DQo+ICAg
ICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3NjI5LXRwaHkNCj4gKyAgICAgICAgICAgICAgLSBt
ZWRpYXRlayxtdDc5ODYtdHBoeQ0KPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My10
cGh5DQo+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg2LXRwaHkNCj4gICAgICAgICAg
ICAgICAgLSBtZWRpYXRlayxtdDgxOTItdHBoeQ0KDQpSZXZpZXdlZC1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MNCg==
