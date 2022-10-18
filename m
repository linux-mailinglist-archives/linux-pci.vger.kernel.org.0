Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFBD602096
	for <lists+linux-pci@lfdr.de>; Tue, 18 Oct 2022 03:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJRBtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 21:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJRBte (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 21:49:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62DE62F3;
        Mon, 17 Oct 2022 18:49:27 -0700 (PDT)
X-UUID: c084f9cdf8a9495db5d0cb0937034a43-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MG9yW67vTTDiGW8hX6LnSHD4KKS6REJxm0J9VnolwsA=;
        b=N6XiFAF1FJIFBHtF693bV2dIiMBewUZrJ2c/3FqJn4UyvgBFoso344v8WtXb87YIv0rlOuGCUsCXvjarPIRqKPo8HNT90nuA8/V7l0YYEFTa7JFju0IRogzjZc0MnWqwdw4l7mLYzHjO7p7FoY/oFD9n9yie0yBUKkltWnVJZ/0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:ec9f472e-c334-4d07-bca6-ee9dd06c7bd9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:41b665b6-a023-44ff-92b1-76c504f71c7a,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c084f9cdf8a9495db5d0cb0937034a43-20221018
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1463342596; Tue, 18 Oct 2022 09:49:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 18 Oct 2022 09:49:17 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 18 Oct 2022 09:49:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/NU50QCjM4DdAC1BGutBfAZU5QACQu8Kpi8I7Tl+f16Gy1NHC7pRRmBFvPX75NQa5xrqdNKxvjheYezmz/P4FmZn8AIk/fOpDmpKws56hkQKM2U5hk57742dRQ4FxN/zhRYLHQpxfUYGpSOIAPwnvLksCQz6W1pSG4bDFE2isx48ttj2cDxB6npf8CPApZYUUdr6aK7XziDV/ImQ3ifCNvaVv0pYEjaX52CB8OPyAITPHiIHEtXPzkTgeq84qmLEfRd8ATcCAw0TQ5LHrKpMVRXPHKPUIb3DfTro3ZzfHsDqeZ2HV1wjZe+PZI9BP4nGdeh8lRrZOJyOydrMSA3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG9yW67vTTDiGW8hX6LnSHD4KKS6REJxm0J9VnolwsA=;
 b=TuE/NJIX3Awc8y0DGF4LhJg69eaFu0TxMFbPQpklAw7i3QOxAQzqJiQUKEqmhVsCAh6x7fVnaeBGU5onxGiL0UVo1YUCdR434wntKpWS2Jg3uNgGsM/Q3qqFrxt1SuH2cVBGiiLBMm8OJOZ7Z0v0RjT+ebPCc8Nj4iNgVyc7IRiHHxiWltF+DOVwPYuBeSG8uhhl9isCEDUNqwAQsdEfZvmkyZ5FxJxXirU7GmIT/GhUCRuzZVkMb8J/uT+5yKUAwlGzFYnrALRT0u4Knsd7b+kvBuzF1LKIrwQL3McMHglvcdRECwoaGp0AJo50Do18GZut8/2VDZ3LBHS5km1YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG9yW67vTTDiGW8hX6LnSHD4KKS6REJxm0J9VnolwsA=;
 b=i4SSFq6Fbwa1ei5+9LVLQLZHI0ByEK0DxYmCyZ4XS9Uv0pTThwoqqSE7IGWN9LHL26oaWP8hTSnnj+eo02twtcRvmofdODlWIJRcmwJRAD55pCHePkDFsy+FWrAfewgk4EQpRGcO+Ro1sMlJj9VfcP+tPhN88VJaUMRU5yLPeKI=
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com (2603:1096:100:53::15)
 by KL1PR03MB7222.apcprd03.prod.outlook.com (2603:1096:820:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.8; Tue, 18 Oct
 2022 01:49:15 +0000
Received: from SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382]) by SL2PR03MB4204.apcprd03.prod.outlook.com
 ([fe80::fd9e:be5e:18eb:3382%5]) with mapi id 15.20.5746.016; Tue, 18 Oct 2022
 01:49:15 +0000
From:   =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: PCI: mediatek-gen3: Add iommu and
 power-domain support
Thread-Topic: [PATCH v1 1/3] dt-bindings: PCI: mediatek-gen3: Add iommu and
 power-domain support
Thread-Index: AQHY4feRF0FjtAlaPECN7PR+TyRyI64S7ICAgAB3NwA=
Date:   Tue, 18 Oct 2022 01:49:15 +0000
Message-ID: <19c9988a5cfc94c5774c3729671cf20ee61a0971.camel@mediatek.com>
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
         <20221017070858.13902-2-tinghan.shen@mediatek.com>
         <20221017184233.GA2260080-robh@kernel.org>
In-Reply-To: <20221017184233.GA2260080-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4204:EE_|KL1PR03MB7222:EE_
x-ms-office365-filtering-correlation-id: c66b276c-f1fc-4ef5-eeae-08dab0aaf660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ts6eVnxl9EdUNv2RpsThJb/hR4MwLNjp6tQtuHzwwP4a77pPG19eaZ2XOJSLd+hg5CMsK/s0QKEwqd5HN44rhWgQfw84hw5Wfk2Yu+F+2fE7Tn2WYZpxeZX0Nlyji0eowC+Pc04HTJF1R9phkgUgv/NPip8lw3S5C1/q7JeFR3gG38QBkbY8F5+ALyX1LeXr8oUmQuRjKWc+64KY6y2FmCma8jj5YGXY5aBJZjKUzaldhjroqW8YlDa3Cuny4xgtGQlK7SB+lQ7BOk6gHak7cULoqw5RoDN9PEsDtXPUgcvLKdb1wkEWYomgdCLs/oXUw7rHe69DcxnhRtmRN7bVMqwrGky6DYPlluwSKvhri9+vQ/hMHy/UWk8kBp+JAxFNuljsnJFD8+bUSKDGyjKmAU65VVsIkBDjIEE65EsprlOalbwCekm2mVEl+YezqiETVug2vlZiKDdCndEP6UpNpGSadG1yQ7pCkz2S+6LWEHQdiAbX/8N39ivahDRI98WN2EggQCHaA4PrlGyKDshLCiXakH7/AA7+k4iAvQDtLm00i3T+2OR37WDRC1qKSL9GcVufM0s11AcvIooVy7HO9V7QfLlIAKfxL5tPZn3Muj4fQAKujivJR75xXc2ix5WQzxVjziv2Ce4VecQ2XsS7Rq4Wj6aWJgWNNwybEIFkqpz7IX/RiNWuTGXq0ktJdvCLyLz90Z0/L/MiSVniFTzE/jbg3oCRyAVSIX6Pt4sTfkrFMgTyDq4gztFRBhCDcSw+Ozu3b8IKk8AmVpthk/YE7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4204.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199015)(6512007)(26005)(2616005)(86362001)(6486002)(6916009)(54906003)(66946007)(64756008)(91956017)(316002)(8676002)(4326008)(478600001)(66556008)(76116006)(66476007)(66446008)(71200400001)(38100700002)(38070700005)(122000001)(186003)(6506007)(83380400001)(41300700001)(5660300002)(4001150100001)(2906002)(8936002)(36756003)(4744005)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUJTbE16QktqOTNTQnQwYXNsdkpvMzVlckUvSC90ZUUvZEhSdzZ1U2ZxaTBj?=
 =?utf-8?B?RUlQOWkvRytmQ3M4aWJDWUNQODFFQ3Yya3g3OUtET0VhOHB1QlljOVYreGdt?=
 =?utf-8?B?R3NuTkRuVjJkUnQ1bStTTzFzK0wzd2cxWHZHTHhESGlrOW5UenVwQUFzends?=
 =?utf-8?B?M0xUK3hQT09ldjRCODVlZmZoeVJwWDRtaXl4b0ZBc0pSTG9ycE1hNEZzcDha?=
 =?utf-8?B?NmlzS2ttS2k0YlRRQ3B0Y1B6NDFoaHk1cG9vRFNWMFZxclA4Mi9yS0NYSS91?=
 =?utf-8?B?ZVFNN2dHeVVQQ1ZIOTdpMCtyRWZuQm96MlpjZWtTUnNKMDMrTC96aXV0WmdC?=
 =?utf-8?B?NmhHeUdNOGpkN2FFYmY5YWl6L05XaE1XS0lrSDhqNDdnMW00NE9XaVU2MHho?=
 =?utf-8?B?KzJjZUlObGFxdENYMks5WU85VldPa2VYS3MxbHhqKzV0ZVFIZk0xTmxtbVJB?=
 =?utf-8?B?OGg5ZmtMRXQxZEZUNVl0Mjc2YU96THJSRFpqVHZTalZQSzBXNjZmYk0rN21q?=
 =?utf-8?B?c2M1bDY2R2pBRVJyWWJlc1RpUkhxUGVIRXVPL25HQWF4c0tKWFNSZlpFQzNO?=
 =?utf-8?B?THM0WmpGRjRXeCtWQUI5UGhaSVpJN25heGFLdjAvdGZwYWRRR3FuM1F4VzVu?=
 =?utf-8?B?RkJjYUJnYTFrTmJ0cHlPK2FGNnMzbkhsc2gwOHZvckg0VlBubWh0dTFmc2hH?=
 =?utf-8?B?QUhybWhaR0VqdnhORFY3azVlay92YnhZMWJ1K3NWa0x5bXhHYUkyR1pPUUE0?=
 =?utf-8?B?a21OQ1NwUktKbXdoWjFpZzdwc0VQb1RYNWxrdkhDRTdMenhKZmRhbEpMSE1u?=
 =?utf-8?B?cnd4MmlZYXlKYTlIalk4K2xaUTJabDhJSk9jWWxVUEJyMWlpampBSDJyOGNH?=
 =?utf-8?B?U1o3VmpLUEY1cGFuVHFNMEZPV3hSNnJBbWtBTmN4bHpMcko3Wnk4VDRzdlBD?=
 =?utf-8?B?c2RrV2hCOGw4Y010dVduQXdBWmVMcjQ5Uy9odDR4c0VheU4vbzIzMXhEdE8y?=
 =?utf-8?B?cUFXa2R6ZFZ6c2VoZDZvK2pXYWpQTzlaVzZDWEF2SnVaVzg3dnZvNk5ick9q?=
 =?utf-8?B?QVFQc2ptaVJxSk1BT0VQTjgxcURLbW0zRmc1QjM4aEMzYkJoMXFScytiRG11?=
 =?utf-8?B?R3JkYmN3SUxDbUlsbG94R0cvZXkrN0FhcmJOcmJEeUR3VlV3TTlwWURsV0JW?=
 =?utf-8?B?bkVJb2o4ekxGdTBvd3hyb25QMkswZTlwTWNYbjhwMlRnL09WZkxqdlNDQjFL?=
 =?utf-8?B?NUxCWUZDaVdqa0t4ZjExeTlpOG9RTWRWRS9kOG1XQlZYM2NCZUFoNVJxWmdN?=
 =?utf-8?B?OXAxazdYbk1YanhnVCtjcmowSkxxZGtid2ZwbGk0RU45ZEFMeTNOM1cycHZy?=
 =?utf-8?B?QVlSemE4b2UxeGNUOVhueDBFc040Unl3RU1VVVpraU51eDNiZkhHNHA2bGxs?=
 =?utf-8?B?VWxNUHhvTERmQW9TeC8zMTMwMzgvNTZKNjVLamxWRTZrVTAwS0ZvVk1HZGVU?=
 =?utf-8?B?TDFDVVgxcVltRTZLUGJXNXZZOHZZZnlkb2w3K3FuOS9zaVFjMjY4djIvaktU?=
 =?utf-8?B?SnN2UXFnQUVkWEZTS1hQdmpEYzN3dEpFZVlLaTVkbThrdkJLcWgvT29iMXhO?=
 =?utf-8?B?YmVYOGVjL2dSNXRVQ0VLYkkxS1V0UDVJeFE2VGhZd1MydmxFRk1zNTlEeVhO?=
 =?utf-8?B?ZnltSHhOYVlhdy9qeVJhNHFZeVQ0NVMzS2E3UkN2TmxqSGg5STJsdi8xeVNR?=
 =?utf-8?B?V3FORVFnWU9abE5DeGgzMVMxMytTakViUmEvMUtnN2JHVXBuRndNbm1PUUxN?=
 =?utf-8?B?NkdabXNEOEJoSFR1TmR5b1FFK1BVbUZuUFBseGZOZkl2UTJQU1ZTb1g0Y1hw?=
 =?utf-8?B?aTdBU2tLQWl3T2xqeDZxY25mUTF1RTZ5cVlORE9pTUZReUFDMSs4ODMzZ2RQ?=
 =?utf-8?B?M1lWaDNVQWhta1hJWHZ6WFF3TjArcFdjV3E0TDNSTjk0eG15cWRxUllaL2d4?=
 =?utf-8?B?V2dPSDdjUnpRdGk5VEpGY3lGWVZiakNmZys4TGE4N2VTWWtCWit0ZlpYaUNK?=
 =?utf-8?B?YUQ5SkZ0bm4yNGQwaW5FSXR1bGhrOEpJN1RRdkZXNFB3ck0vMHc4Z0J6Vm5p?=
 =?utf-8?B?UVE3cXZGa1Y0MWxYRzhRK0c0QUttY3FOTnVyZStzQW83RG1sVjNnQ1pIWnhv?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A0743ED0F519747A8097D9F409C1307@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4204.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c66b276c-f1fc-4ef5-eeae-08dab0aaf660
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 01:49:15.0198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxX4534vmFKTfszjmFWtKNTGNfn+NViWLujYfmsmFj/gC1TUz96oLEkA3RigBUxlEXtYTvKjoLBNX6oejCPph4Uwe6LLVy6bmG+CzoA643A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpPbiBNb24sIDIwMjItMTAtMTcgYXQgMTM6NDIgLTA1MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxNywgMjAyMiBhdCAwMzowODo1NlBNICswODAwLCBUaW5n
aGFuIFNoZW4gd3JvdGU6DQo+ID4gRnJvbTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVk
aWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBpb21tdSBhbmQgcG93ZXItZG9tYWluIHN1cHBvcnQs
IGFuZCBhZGQgZXhhbXBsZXMgZm9yIE1UODE5NSwgd2hpY2gNCj4gPiBoYXMgdHdvIFBDSWUgcG9y
dHMgd2l0aCBkaWZmZXJlbnQgY2xvY2tzIGFuZCBwaHlzLg0KPiANCj4gSXMgdGhhdCByZWFsbHkg
YSBiaWcgZW5vdWdoIGRpZmZlcmVuY2UgdG8gYWRkIGEgd2hvbGUgb3RoZXIgZXhhbXBsZSANCj4g
d2hlbiB3ZSBoYXZlIGEgZHRzIGZpbGUgd2l0aCBpdCB0b28/IEkgZG9uJ3QgdGhpbmsgc28sIGFu
ZCB3ZSBjZXJ0YWlubHkgDQo+IGRvbid0IG5lZWQgdG8gc2hvdyBhbGwgaW5zdGFuY2VzIGVpdGhl
ci4NCj4gDQo+IFJvYg0KDQpPaywgSSdsbCByZW1vdmUgdGhlIGV4YW1wbGUgYXQgbmV4dCB2ZXJz
aW9uLg0KVGhhbmsgeW91Lg0KDQoNCkJlc3QgcmVnYXJkcywNClRpbmdIYW4NCg0K
