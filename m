Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CB43FE764
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 04:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhIBCIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 22:08:50 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:51394 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229871AbhIBCIs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 22:08:48 -0400
X-UUID: e8559baf59a24602a2fe04415c5369d0-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vlceq4ZSRrI3NsqXyY4IeOxTjhqftckEq9WQnY9jq08=;
        b=i+2nV3L7zqcDqF8aRC//gisZAgG9tBWRdpk/EFIZThHFfhCg2M4BzCdK8qMbHtL+kZ5ePSPH+rV9MZh0XPoD1VygDHHa5/CsFbDuC0p83yVqoBJDslEegt42shuNFMCSTO+ZPd/7WpoeZ5I/zaa/pthtzbXp4tKSfAmbsw24Ll4=;
X-UUID: e8559baf59a24602a2fe04415c5369d0-20210902
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 44523773; Thu, 02 Sep 2021 10:07:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 10:07:47 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 2 Sep 2021 10:07:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGMepEREq8+CkCCdKRbetJWpJVQd5K0s/VDDNaWiIx8cnI23SHDORQiLjWc0AqIwVKOu2fLPN2CXRRPl4Tuc3Mp7D2KjdGWkFv1v0fwIRArcE0x1+hyHxnWVDPANj+lSrPsSnyDmamMEng1p5LZUAqU1yLGOyYM7GZ5Drm5bYA7dGh+7LrSIbJa4mGCx76YKcAeXaAOklvrSiFJoZBl7GETU3ZZZYAtbk++tlNhSClxUYlX/TDy6e10nVGegUAhF2BRT8McGA2mTL6X4T4kB/k587LOe7aDaUT2j3MH5hUIPR9V4qgiuEfdkuLHuk+jqjxICDj2sldyNMt1xUH1zVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vlceq4ZSRrI3NsqXyY4IeOxTjhqftckEq9WQnY9jq08=;
 b=YtgeYNi84HFRalGBFh8I5NHlniUOkmnY6lUbue6YZ9pdDCAz9DRX+0ymcDOnzELaJxPa8i4iiL6GvSC36xFJO08AKMccES4HubCT/0+C5zqtLI4Z025fYZXueGYEVmL85ya5yJXStGMie+HQm4gH8InlYNNq4Hred0GgqHK8FlFlJUrqR6maPUolftm7tHWUUKh0ckUqXy5vXMhFczg7OEgYcnkQifum0+YJpTFWm9dTFvjkE2kg/hxRqO+tEAiPM2sUyPoWB2Uh4JKE+/AC2mqV4+dBBs4d5kAqd+zgZBiRqdn0SPr3b7lGwcXs8UfQoR7UBzJrKLmAxsWUMR/iGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlceq4ZSRrI3NsqXyY4IeOxTjhqftckEq9WQnY9jq08=;
 b=nOf7SRjW8ZYL0pLbXsdpVKC+2BJmiLkHqKIe1F38vu5s3HLfp6Eq7ie1YUsOUEzZ/UWMxO07gVQt7GxU8hHEhksw1lhjU/KupGAVFe5Q7+M4wzJWXqSDJfolgNlQW7t5B8Xeu2OJrqFmChl4zdJOJQEe39Jb2bFv5KhJUwFMZ1I=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by PU1PR03MB2762.apcprd03.prod.outlook.com (2603:1096:803:17::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Thu, 2 Sep
 2021 02:07:35 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::3d11:979f:9b79:dcbb%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 02:07:34 +0000
From:   =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= 
        <Jianjun.Wang@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        =?utf-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <Ryder.Lee@mediatek.com>,
        =?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8195
Thread-Topic: [PATCH v2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8195
Thread-Index: AQHXmusBSJDNQKcBAkqOkyDyEySVGKuMOwYAgAPLvYA=
Date:   Thu, 2 Sep 2021 02:07:34 +0000
Message-ID: <36c66b737afa96563be128d822f862eea5839dcb.camel@mediatek.com>
References: <20210827022638.3573-1-jianjun.wang@mediatek.com>
         <CAL_JsqJTW=ot=BBWQfOj9rJ82dnVV21TpHGf3vieUQ_Jd8i9Rg@mail.gmail.com>
In-Reply-To: <CAL_JsqJTW=ot=BBWQfOj9rJ82dnVV21TpHGf3vieUQ_Jd8i9Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa596e5-5766-492d-01a8-08d96db66de2
x-ms-traffictypediagnostic: PU1PR03MB2762:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PU1PR03MB27629F8EA0054DDD07E5A81FE7CE9@PU1PR03MB2762.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9m2HNaC/7GkDs6G+RBaThZv4LpL7Yw6hdyhrWBL+N85ibpKcmNcOvGOMqIPwAKpbaPuZExdGVCWy5C+lcUm3JWCdUdK5ZE3EKIf1Zzv4NQbQq0qpEiyN7F7HP2B9PADoAsWIHby1hU+G2hE/2S7yn5z4evlY7OFMnvsBABB9eVfBLJ0cPG7BdskNhi5rnWLEzBSfyJKjd24E0YhX9xJpDWrplnIO3B0E8kmGU8PQY5cL0LUHaJZlwlRGz5RJf8baEq/ZGfGk4CEoyuo3qfdv5b1Hh65XTMJzeOb0RGQIf3O5mHzA6q0RXyNLlGPsAI9KQ1NaEDWSQ7KsFUN2MFBqmP/XI9WSC0D/PMTl1rMblIGx48b4+rG7iERDZXQAE0fjyQwqv6lWZPmX9JM/4P2AXHFeSMLE1uPFKKZhwiSbMGUesRdlMKAstVeRlHgyqyExh8ue7IbJ6waVyWF49TF2C0aqngpPnBzeVUC96nB16vLsu/Pj3Ygf+bS96nT25zfMRLa6NUwZnnw07gEuQ8AKGbIDh9eazcI5DdrGUnjaefpebnOjmyGpw/JjG7eEoA50hltDA9ZvtwpwpejGOJOk2e5g9KjNPrPkj1K4GV8Wk6ngyhioOoOLL06r9Sr7xL8xmxvOGg0mkeCpDTv7d/qv8xJowD8KcLC9AnZQSZPly6Sren8FHRxRg6U0zKuDsw+XIsIu4sRecR50uy3I/mi7DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(64756008)(26005)(36756003)(2906002)(54906003)(85182001)(4326008)(66446008)(83380400001)(8936002)(122000001)(186003)(6486002)(5660300002)(66556008)(316002)(76116006)(38070700005)(66476007)(2616005)(53546011)(6506007)(38100700002)(71200400001)(478600001)(91956017)(6512007)(107886003)(66946007)(86362001)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1ZkWnFZMDZENjdQYlRrUlo5MEM4MVFRNng4UGVPUkJrVTMzQW5Ic2xRcDFR?=
 =?utf-8?B?WFVROEw3c1ZlVDRHZ2Q5a1Q2MmtVcjY4RWdwQ2VWR3JLUE5UaUhWekRZM2Nw?=
 =?utf-8?B?emczL0lRSHFCZ2RPcXAxdjdnTElxQXRZOVlBcUFQUUhSZzFIVTZ1S2xFS3Z6?=
 =?utf-8?B?RlRPeWdqSldBeTRJSTl2WmJhWVNXR0hBMmRVdGp2QWpvbkFDemxiRkJsc2ta?=
 =?utf-8?B?THB6SjhZR04vYmJ2TUl2cXdWTnFRdnBDWW1TSEZHdy9FMW1jUENjZmh0Wmxu?=
 =?utf-8?B?S2JMb2VkS2lmQnMvd2pOZlFxRmh2OHFpdWNrOURLeTZwbXdiWjVMcVgxU290?=
 =?utf-8?B?eUtFMi93SWdnczVvN01JclF5QTBJRFpUdWM2REI3aStjeCtwVXBWRDdjOGNs?=
 =?utf-8?B?S2pCOXRSNG8xNmNsRWlRMHJsYnRTM0VxaTJYN3JhYS9QWTg0MmlmY0NTSnJt?=
 =?utf-8?B?dUI1ZTFSSjhGY1NJeVN4U09ZSUlRZWNIYTBQdDBXT0g0RTdVM3NjUmlCZEJT?=
 =?utf-8?B?ejJSOXM2am9PM016V1AzU2xGOURwTDVycWJYU2hDQlZyRjFTbzZQbnZtaVlk?=
 =?utf-8?B?YmlTV09taXpXUnc2bE1KcDhRcDVCRnFyWGlrbHZEajFzcmtMMXBDK0RCd3pv?=
 =?utf-8?B?cm56MkNVNzlpSytacm5nOEFIUnR0bWs0c1dwRnVsSWhjaXZlbUJWbVFTbGxy?=
 =?utf-8?B?K2RTbERpcDRFcGNNWm95dFZDQkZRM0RkNnZwV2tEUCtORjNPQ3dRT1RjMys1?=
 =?utf-8?B?RVNZdU1NNyt3LzlJNnF4bllHUXpxNkhqdmFoVlVaWkF6Z1pSWTY2VkZpSzdY?=
 =?utf-8?B?VVRJOVJVRzE4MFE1aWVJaGlnMkdXUDU2eDcza3dTdXhBTVp2QzkvajU1RzVZ?=
 =?utf-8?B?R3djR0JOR1pDdEFqNUNUUGs4S1VsdjlPTDRvNmg5Zkh5M0I5MHA4OGF5eWRv?=
 =?utf-8?B?ZDRGNEplbVhickZuMS85QzJTTk5lbXJqbktDOXZRb245Vmw0S1MzUzltMmMz?=
 =?utf-8?B?WE10WGhqdi85c04vWldYN0NlUmUyeWE1allITCs0aktRSXN0TVI3bnRwVUV6?=
 =?utf-8?B?U3JFNzU1cG5LZnl2cUxDM0NoQUVwazNKQkpHVzJaa3NwdHF1S09ZeHcxa0Yr?=
 =?utf-8?B?a1FFdm9BVnlQaEhCdFJ3SVAza1ZLQWgvZ3F2d2VUYnRuZVRIbDAxNkdpUnF6?=
 =?utf-8?B?UXYwcnFoSUc1S2F6TnpTd3FjRUtrYTROK2tNQy9adkZicjNuV0x2anEwTnVh?=
 =?utf-8?B?OGhtbS84am5nU0I5eUtYeENLMVZ0NkxObkU2TFRSWkZxell3czlBWEdxazNt?=
 =?utf-8?B?L3dQUHlra3cxNng0MkhnRVZMakRlRnl4RmVEWVB0czJSSy8xakd6bEVjRngr?=
 =?utf-8?B?bzVkajRLUXh6VlBMQzVNNWtubGRuclVQbFZEN0RPMDdtaElraXl6SEtEbVdS?=
 =?utf-8?B?SUpxcEFpWXJtRXFyQnh0aTV3Mkw4RmRHbGRhR3FxNVNWcStNOXFjTnpuS2tw?=
 =?utf-8?B?cUx3K1c1V3gzMFBPZUhyOWFLV29UL3l0cDEvbUNrR29EYnVNcWt1enZuQ1VB?=
 =?utf-8?B?YnJFZld6b09FZ1U0RG9pclluTkZ0NGJudGo2eno1VGg1WHlvZjNxa2FPdXR1?=
 =?utf-8?B?cWlNVFJNVnl3bk92eFlmS0J1MzBMcElXWExIVHdFWmNTYXZHQTZndGs5TjFW?=
 =?utf-8?B?RVo4Q1RCclJ5eU5mQk05Y2lEbUR3L1Z3NW55TFhUKzZWUVMyK3NMUXl2bnh1?=
 =?utf-8?Q?I9+vEp1SGAc7nRnNQNJfotS2Plw+LZaYfXPNxfx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC18FF469CC0FB4782AACA8E6CC5B104@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa596e5-5766-492d-01a8-08d96db66de2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2021 02:07:34.3116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yvveNF3UXyJjX3KDCUjTZskCHCSPL1+8oPOVmEhHXJ0Yn+OTNxCbeTitW6PC8KEDAz0ADAM05XcTBk+q4s3zzyD5rn4+wSBxltZNR1P187c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR03MB2762
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTMwIGF0IDExOjAyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCBBdWcgMjYsIDIwMjEgYXQgOToyNiBQTSBKaWFuanVuIFdhbmcgPA0KPiBqaWFuanVu
LndhbmdAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBNVDgxOTUgaXMgYW4gQVJNIHBs
YXRmb3JtIFNvQyB3aGljaCBoYXMgdGhlIHNhbWUgUENJZSBJUCB3aXRoDQo+ID4gTVQ4MTkyLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbCB8IDQNCj4gPiArKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2ll
LQ0KPiA+IGdlbjMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
bWVkaWF0ZWstcGNpZS0NCj4gPiBnZW4zLnlhbWwNCj4gPiBpbmRleCA3NDIyMDZkYmQ5NjUuLjkz
ZTA5YzMwMjliNyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL21lZGlhdGVrLXBjaWUtZ2VuMy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9tZWRpYXRlay1wY2llLWdlbjMueWFtbA0KPiA+IEBA
IC00OCw3ICs0OCw5IEBAIGFsbE9mOg0KPiA+IA0KPiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNv
bXBhdGlibGU6DQo+ID4gLSAgICBjb25zdDogbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiArICAg
IGVudW06DQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXBjaWUNCj4gPiArICAgICAgLSBt
ZWRpYXRlayxtdDgxOTUtcGNpZQ0KPiANCj4gSSB0aG91Z2h0IHlvdSB3YW50ZWQgdG8gc3VwcG9y
dCA4MTkyIGFzIHRoZSBmYWxsYmFjazoNCj4gDQo+IGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LXBjaWUiLCAibWVkaWF0ZWssbXQ4MTkyLXBjaWUiOw0KPiANCj4gVGhlIGFib3ZlIHNjaGVt
YSBkb2Vzbid0IGFsbG93IHRoaXMuDQo+IA0KPiBSb2INCg0KSGkgUm9iLA0KDQpZZXMsIEkgd2Fu
dCB0aGlzIGZhbGxiYWNrIHRvIHN1cHBvcnQgTVQ4MTk1LCBidXQgdGhlcmUgYXJlIHNvbWUgdW4t
DQpkb2N1bWVudGVkIHdhcm5pbmdzIGlmIEkgZG9uJ3QgYWRkIGl0cyBjb21wYXRpYmxlIHN0cmlu
ZyB0byB0aGUgeWFtbA0KZmlsZS4NCg0KRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIGluIHRo
aXMgY2FzZT8NCg0KVGhhbmtzLg0K
