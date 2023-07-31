Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABB8768987
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jul 2023 03:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGaBSz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Jul 2023 21:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGaBSj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Jul 2023 21:18:39 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C017610E5;
        Sun, 30 Jul 2023 18:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AerBmYEQXyJwQpxitWcPib0bpOs+BjrczbA2GA4vOschK5eH3zr8Oi/3ntzCYCAUZPlWvCtg7j+jMtQ2XcdMI+l8Wqt/EPRSND7PXrL2IFHQ6VFXpNK+TulzLWVTWyuZLd9gE06Fi9BWWjAAvEUDEfEgGchYvZ9Ztu4sDyJtryQLsVmr4mAXBTQHrEcxGWcEkuM+OIdtemY/5rPPce353hYEkg9Ze9xKCPGkJogdxBQl7i1ZJV9/1Zj8S4W3QJNXZKGnwfkmDZwBjHw3LYNEP5hJOVrNw5hzsxaO3nK+JaYan2yf1bf8sF84xW/bpuUfv1N7JyK6moB3nNLs/L+QJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F3Z3a7DnoPk/bAlrXnYDShkqiyUsJhSrEDblS+cdo7E=;
 b=G6axSghPE+FAlHmkaiFwRJwpRTbQ92hfpvV944k96cu+lWhhtr9IUbRu6DZG6W2PCXuTovH0FYr5zwrrwU+YLKRFaLf3B1Anb70Om5s6L580hwG4BGl8YcPDKMNl09Rp1k6MctQxYjBf20C3ZIl/q4A3TFfnjrhCjNHGQ6aAAnYu4fXmIG0toeNm8Sl57+7YmmyXlxFuxJioZxT6XJNZ+V9QNjR5IaPdw49HWiRQCAaS4rXNjXTPCxYyIM/WHR3+Rcaw1jZirPp356uVN8YRCUXludgQzlPhvj7yxNKLofDXDWlX+m6TGAh3RUO9SewboNH8QACU5caeI7hl2ThhiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3Z3a7DnoPk/bAlrXnYDShkqiyUsJhSrEDblS+cdo7E=;
 b=o5YNHAI63R+BduuO/UgK/WEPHg/nz5w3mnmzt5rLKUvKOzAZmxwL2vumeTs/bp/4b7+4qSQlWHMHCZ9BkeyOM9A0wiqWwrtHMZBETJ1FEro9jECl0Iiz76CuFKdEqx8shCYK3H4lPKfinKx6BeCLcesd06YQq6V1yfuevAU82Ic=
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com (2603:1096:604:8a::15)
 by TYWPR01MB11049.jpnprd01.prod.outlook.com (2603:1096:400:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 01:18:30 +0000
Received: from OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075]) by OSYPR01MB5334.jpnprd01.prod.outlook.com
 ([fe80::fe8:f613:9823:4075%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 01:18:30 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Thread-Topic: [PATCH v18 05/20] PCI: dwc: Add outbound MSG TLPs support
Thread-Index: AQHZu6dC88y+jhK0xEGeyF85x0cdRa/IlfcAgAduIgCAAx3zsA==
Date:   Mon, 31 Jul 2023 01:18:30 +0000
Message-ID: <OSYPR01MB5334600364096E6FDE573394D805A@OSYPR01MB5334.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-6-yoshihiro.shimoda.uh@renesas.com>
 <20230724081250.GD6291@thinkpad>
 <qckzwhgcx7eux7qi6a27hww7wbva6r4nylxo437gnohpsxuja3@6dj2ld7qlvix>
In-Reply-To: <qckzwhgcx7eux7qi6a27hww7wbva6r4nylxo437gnohpsxuja3@6dj2ld7qlvix>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYPR01MB5334:EE_|TYWPR01MB11049:EE_
x-ms-office365-filtering-correlation-id: 18230e08-01ae-437d-4641-08db91640d3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2gbbYB3ue8jI1+x5+DoXNeLS+43/YiCiRVHLSLBB90uoBxyUcXoucTo/SmFKs3c3pUF9uHJUk3juCz0y+KpHnLe3qRPOEEsVRBRHJzsTZVVIFs3mtm2Ph/86T2ZmpxhmEgKlvqEgAKN7DyaKg+CaSqXx+0zk5+OwMdeTRrKJihLlmDYt+Gnf3+K2ugm9RlLBSGqVuK9l6UF8ZyTfQmM3vY9Ng0uV33t+1nqJZuLeH7Wix2ZA01ghh/iG6aPxCAMsdmlYklWwrtvKJJGsBK+pK7WZ6F2q5sjCBYiCt8srOBdUNG5pNOWQc92ignhXwSnLouvqpUXZbSh6TGpQulcvZ0I+g6l3lFkFITE4y1o4hVzIUD+YjThinUyFD7CjU6yveSiAFfQkd0imaUunvonYmcxiaNnfW+ZdeaQN4pe4g22p0wGVwZ3AAQiH4jyVUmZbGdUQNynpO3OX+96VAibnowCK4gC/9PqujHo6Yx76qhAFtZGQpTmF5WtFqEUvQD8rF1EFaPgdCmfzsVUVF99g/Bye3xWin+yE0KMdCRXWfcx5mgMM+gdgJlNzntQ1fahomB2a3RT/1IZpuYUAju0R17LK3XzHQXnXUystCF24BZ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5334.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(41300700001)(5660300002)(66946007)(76116006)(8936002)(8676002)(55016003)(52536014)(110136005)(54906003)(478600001)(4326008)(316002)(7416002)(64756008)(66556008)(66476007)(66446008)(2906002)(45080400002)(7696005)(9686003)(966005)(71200400001)(38100700002)(6506007)(186003)(83380400001)(33656002)(38070700005)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnQ2aXgwMU9vUTRZeVF5cHpzVFUyam5aUlNzb2JjL1A4WG0vS2lyM010bUFo?=
 =?utf-8?B?M1p5MFFFUnZiYUFhZnY4Mm1OV2g3RXB0M3lKNDU3a05hUzM2SW5JV29lN0d1?=
 =?utf-8?B?djRVM2tzWGhxd21vK2RaSzM4SFVXWXNpdUlmZFl0cEpIa01MeDJseTcvTnN5?=
 =?utf-8?B?cTNLWVBWejJ4STRpU3YyQ2VDYk9SQ3llc1NBUmdEMTVxSE1RbDNuWlJ5NDNZ?=
 =?utf-8?B?MWMxcDN6ckM1c1FaVjZaWjBCcWJmWldKbEFJRmF3MC9UYWZzSDhHd1VNb3Jm?=
 =?utf-8?B?WW5zWWUvYUdOVlliVFlaUHZwRC9BdmY2M1BnZlRRYW5wQWVGdXp6WmliSDJ4?=
 =?utf-8?B?Z1BSbzlSM0RKbFpsTGtFbUxTOUVCY3NJZGZEa2dhRjVKMm5qejN2anhaWkgx?=
 =?utf-8?B?bkFtS2pZalBZM1pnclBicVZvWUZJR0c2eGtLQjAvNnQvNWJSQnpZQmVqZ3ZR?=
 =?utf-8?B?ZW1aeEpOZEJKMlNCTFRSMlE1QVhYUit3V0lqRGFJM3ZBWC9GdmFYMkQwek1m?=
 =?utf-8?B?NzFWNGJRZ0RKbkRqelQ4SzFjQ0diV3dpOHVRSlVsUUx1bTFpTVcrRkkySGlq?=
 =?utf-8?B?SC8veDI1aXFmVlFhUlJheE9seERLMFMvaXhHZ1EvRnR1WW4yNGZmdWNLc055?=
 =?utf-8?B?cmIzcEtib1Vuc1VMcEFWWHp1TkFOZS92bmkveUErYXl5endUNUk2QU1LYS9l?=
 =?utf-8?B?SkRLRWlVbzZCajduRzlFSm5RVHBINDVNZndHQjFFUmxnQkxtbjBVRVRLWWth?=
 =?utf-8?B?enQ2SzFLLzMyelRzUU5LcGVsMHQ0WEpGTGtrS29NV1gvUTZ0UnhIVnRRYmQv?=
 =?utf-8?B?ZGRtMkZGT2tIZGZ3YnFzYnMwM0hHSjNTMU9BNlBKRkJPMXdvUGI5a2toNG93?=
 =?utf-8?B?V0Nnb210ZUlrU3hLb3NwYXpreTFtQVhycURNRXprdUQ5L3lEVUVWalRKZGNw?=
 =?utf-8?B?UjhUeWk2RjJhYWRoUmlmTStpdHBYanhGSzBjcEdqVGl3RU92WTJmVXNnaGhw?=
 =?utf-8?B?Q2FSUFlhb2lXWmRzS3JsUGZ5T0JPdEc4SjUwVFBWMWUyZHhwUEtzNGxwY3Ex?=
 =?utf-8?B?QTBCSW51V1MxTzZCSlFadmNYSWVPd0M2QjVYemVQelJqUWtoempyNDZEVG1I?=
 =?utf-8?B?NmdVVnQ4RHgycmZsQ0VwbW1TaWNVZnlNdnFYMnl3UHVnNlpJTU5RRG5KV2RG?=
 =?utf-8?B?RTJaMUpMQ2VkdWt4bjZ4MkM0R3N0R3Z1d280c1JDaWgyQktONmJIeDR2TFA1?=
 =?utf-8?B?YzEydjBLSkhhemxnMXBWRDQrcGtUMnl5VlYxTVd3dXIwVHlPdVpwbTA3ZWZK?=
 =?utf-8?B?L1Z1bjhuRjhWdUZVT0UxdlE4ckx3dUIxT0NDSXFuRXAwa01sdzE4b1RibWFU?=
 =?utf-8?B?a2xuVnNOQ1BXakozQTZPbW9yYy9tekp3S1Y1Rm5vVEMrakV3Y1JRbDhhbUk0?=
 =?utf-8?B?Tyt3aGtZVTVGSWovclZ6NlpkeGxROGw3WEZSOEt0N1ZUeVNYZE1kV2xtQTdC?=
 =?utf-8?B?eE0wV1NDUXdnR2FRcktIZEVBNjhyNFowRmNSTzRkL1pNdjRzRzZLSTlCRjNY?=
 =?utf-8?B?WXRPNzJUb3lXTis1N1NwVHJIbXBvZ0ROVFFqd3MrNHc3S2t6RHN6Y0w2QnlN?=
 =?utf-8?B?amxpTUVTck1TNjFoY01jbkJjOUR6S28yaEhNellpVzBtbkRtL2Q1enFDNmFq?=
 =?utf-8?B?aVlJSU1KYy9VU1k4Wk9VWDN3dVFxRzZxNjhwYXQ1WWJyM0FrVkY0NHQ2eGRC?=
 =?utf-8?B?WGF0alVHc1NMQ0Y3b200M1psQ0ZralJZQTZ6bnFvQVFzckNtMkdYNkJyanVP?=
 =?utf-8?B?Z25CNHJzT3MzU2E5bGttemFvNUZ5V29lZlo1N1NZZk10aDNHajVSR25JQ0JZ?=
 =?utf-8?B?QW5HMXY1RTIrS0F1Qmpyb08zODRUVS94M25ycFRqcnNtNTJ2THBncldtOTdl?=
 =?utf-8?B?UnlJOUFyQnhYenJxV0ovQzQ0UTdPL0J6RUZGMnU2SnY0RitsR3dwS2FVRVZ3?=
 =?utf-8?B?bXd4eGJmN0FrOFBuWGgxM2VaR0tXdThhUE5Rdi9ueksxbWdldU1JaUdyaG1W?=
 =?utf-8?B?TzJheW9CRG5hWjZLR0s1NEpOS2dPRklXTk5ZUXgwZVZvWmxYRXU4aXdkRU11?=
 =?utf-8?B?d05FT3JxdGFZVXpGdmlYd1Vob1NjYU5OaHc0dG5LTjZKc2JaM3NNVk4vN2M1?=
 =?utf-8?B?WFdXK1kvQVB5Y25zV0JSQUVMM2NjeHdBTUh5eEVva213WjFUQjhlY045cU1S?=
 =?utf-8?B?bUdtdWtDS2h0d1NHUmdpTHdqME9BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5334.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18230e08-01ae-437d-4641-08db91640d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 01:18:30.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8N9EjKCDxG7xIFzJ9mHU6WPnjrp4Nq0o1G3z4jlGDQw5OTLXgHEK/gzF721l0sjBfvvBwh4SlK+/aUrjZq0bY2qVb5osZyB90FL4j+QMGFCuHR1e0HkSbsmbMgE7QfHJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDI5
LCAyMDIzIDEwOjQxIEFNDQo+IA0KPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAwMTo0Mjo1MFBN
ICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0gd3JvdGU6DQo+ID4gT24gRnJpLCBKdWwgMjEs
IDIwMjMgYXQgMDQ6NDQ6MzdQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4g
PiBBZGQgImNvZGUiIGFuZCAicm91dGluZyIgaW50byBzdHJ1Y3QgZHdfcGNpZV9vYl9hdHVfY2Zn
IGZvciBzZW5kaW5nDQo+ID4gPiBNU0cgYnkgaUFUVSBpbiB0aGUgUENJZSBlbmRwb2ludCBtb2Rl
IGluIG5lYXIgdGhlIGZ1dHVyZS4NCj4gPg0KPiA+IEl0J3MgYmV0dGVyIHRvIHNwZWNpZnkgdGhl
IGV4YWN0IHJlcXVpcmVtZW50IGhlcmUgInRyaWdnZXJpbmcgSU5UeCBJUlFzIg0KPiA+IGluc3Rl
YWQgb2YgaW1wbHlpbmcuDQo+ID4NCj4gPiA+IFBDSUVfQVRVX0lOSElCSVRfUEFZTE9BRCBpcyBz
ZXQgdG8gaXNzdWUgVExQIHR5cGUgb2YgTXNnIGluc3RlYWQgb2YNCj4gPiA+IE1zZ0QuIFNvLCB0
aGlzIGltcGxlbWVudGF0aW9uIHN1cHBvcnRzIHRoZSBkYXRhLWxlc3MgbWVzc2FnZXMgb25seQ0K
PiA+ID4gZm9yIG5vdy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hp
bW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4NCj4gDQo+ID4gU2Ft
ZSBjb21tZW50IGZvciBwYXRjaCA0LzIwIGFwcGxpZXMgaGVyZSBhbHNvLiBXaXRoIHRoYXQgZml4
ZWQsDQo+IA0KPiBZb3NoaWhpcm8sIGFzIHdlIGdyZWVkIHdpdGggTWFuaSBpbiB0aGUgUEFUQ0gg
NC8yMCBkaXNjdXNzaW9uIHBsZWFzZQ0KPiBpZ25vcmUgdGhpcyByZXF1ZXN0Lg0KDQpCeSB0aGUg
d2F5LCBkbyB5b3UgaGF2ZSBhbnkgY29tbWVudCBhYm91dCBteSBzdWdnZXN0aW9uPyBbMV0NCg0K
WzFdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvVFlCUFIwMU1CNTM0MTQwN0RD
NTA4RjBCMzkwQjg0MDkwRDgwMUFAVFlCUFIwMU1CNTM0MS5qcG5wcmQwMS5wcm9kLm91dGxvb2su
Y29tLw0KDQpJZiB5b3UgZG9uJ3QgYWdyZWUgbXkgc3VnZ2VzdGlvbiwgSSdsbCBpZ25vcmUgdGhp
cyByZXF1ZXN0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC1TZXJn
ZSh5KQ0KPiANCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1h
bml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiA+DQo+ID4gLSBNYW5pDQo+ID4NCj4g
PiA+IFJldmlld2VkLWJ5OiBTZXJnZSBTZW1pbiA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUuYyB8IDkgKysrKysrKy0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmggfCA0ICsrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiA+IGluZGV4IDQ5Yjc4NTUwOTU3Ni4u
MmQwZjgxNmZhMGFiIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiBAQCAtNDk4LDcgKzQ5OCw3IEBAIGludCBkd19w
Y2llX3Byb2dfb3V0Ym91bmRfYXR1KHN0cnVjdCBkd19wY2llICpwY2ksDQo+ID4gPiAgCWR3X3Bj
aWVfd3JpdGVsX2F0dV9vYihwY2ksIGF0dS0+aW5kZXgsIFBDSUVfQVRVX1VQUEVSX1RBUkdFVCwN
Cj4gPiA+ICAJCQkgICAgICB1cHBlcl8zMl9iaXRzKGF0dS0+cGNpX2FkZHIpKTsNCj4gPiA+DQo+
ID4gPiAtCXZhbCA9IGF0dS0+dHlwZSB8IFBDSUVfQVRVX0ZVTkNfTlVNKGF0dS0+ZnVuY19ubyk7
DQo+ID4gPiArCXZhbCA9IGF0dS0+dHlwZSB8IGF0dS0+cm91dGluZyB8IFBDSUVfQVRVX0ZVTkNf
TlVNKGF0dS0+ZnVuY19ubyk7DQo+ID4gPiAgCWlmICh1cHBlcl8zMl9iaXRzKGxpbWl0X2FkZHIp
ID4gdXBwZXJfMzJfYml0cyhjcHVfYWRkcikgJiYNCj4gPiA+ICAJICAgIGR3X3BjaWVfdmVyX2lz
X2dlKHBjaSwgNDYwQSkpDQo+ID4gPiAgCQl2YWwgfD0gUENJRV9BVFVfSU5DUkVBU0VfUkVHSU9O
X1NJWkU7DQo+ID4gPiBAQCAtNTA2LDcgKzUwNiwxMiBAQCBpbnQgZHdfcGNpZV9wcm9nX291dGJv
dW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0KPiA+ID4gIAkJdmFsID0gZHdfcGNpZV9lbmFi
bGVfZWNyYyh2YWwpOw0KPiA+ID4gIAlkd19wY2llX3dyaXRlbF9hdHVfb2IocGNpLCBhdHUtPmlu
ZGV4LCBQQ0lFX0FUVV9SRUdJT05fQ1RSTDEsIHZhbCk7DQo+ID4gPg0KPiA+ID4gLQlkd19wY2ll
X3dyaXRlbF9hdHVfb2IocGNpLCBhdHUtPmluZGV4LCBQQ0lFX0FUVV9SRUdJT05fQ1RSTDIsIFBD
SUVfQVRVX0VOQUJMRSk7DQo+ID4gPiArCXZhbCA9IFBDSUVfQVRVX0VOQUJMRTsNCj4gPiA+ICsJ
aWYgKGF0dS0+dHlwZSA9PSBQQ0lFX0FUVV9UWVBFX01TRykgew0KPiA+ID4gKwkJLyogVGhlIGRh
dGEtbGVzcyBtZXNzYWdlcyBvbmx5IGZvciBub3cgKi8NCj4gPiA+ICsJCXZhbCB8PSBQQ0lFX0FU
VV9JTkhJQklUX1BBWUxPQUQgfCBhdHUtPmNvZGU7DQo+ID4gPiArCX0NCj4gPiA+ICsJZHdfcGNp
ZV93cml0ZWxfYXR1X29iKHBjaSwgYXR1LT5pbmRleCwgUENJRV9BVFVfUkVHSU9OX0NUUkwyLCB2
YWwpOw0KPiA+ID4NCj4gPiA+ICAJLyoNCj4gPiA+ICAJICogTWFrZSBzdXJlIEFUVSBlbmFibGUg
dGFrZXMgZWZmZWN0IGJlZm9yZSBhbnkgc3Vic2VxdWVudCBjb25maWcNCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gPiBpbmRleCA4NWRl
MGQ4MzQ2ZmEuLmM2MjZkMjEyNDNiMCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuaA0KPiA+ID4gQEAgLTE0NywxMSArMTQ3LDEz
IEBADQo+ID4gPiAgI2RlZmluZSBQQ0lFX0FUVV9UWVBFX0lPCQkweDINCj4gPiA+ICAjZGVmaW5l
IFBDSUVfQVRVX1RZUEVfQ0ZHMAkJMHg0DQo+ID4gPiAgI2RlZmluZSBQQ0lFX0FUVV9UWVBFX0NG
RzEJCTB4NQ0KPiA+ID4gKyNkZWZpbmUgUENJRV9BVFVfVFlQRV9NU0cJCTB4MTANCj4gPiA+ICAj
ZGVmaW5lIFBDSUVfQVRVX1RECQkJQklUKDgpDQo+ID4gPiAgI2RlZmluZSBQQ0lFX0FUVV9GVU5D
X05VTShwZikgICAgICAgICAgICgocGYpIDw8IDIwKQ0KPiA+ID4gICNkZWZpbmUgUENJRV9BVFVf
UkVHSU9OX0NUUkwyCQkweDAwNA0KPiA+ID4gICNkZWZpbmUgUENJRV9BVFVfRU5BQkxFCQkJQklU
KDMxKQ0KPiA+ID4gICNkZWZpbmUgUENJRV9BVFVfQkFSX01PREVfRU5BQkxFCUJJVCgzMCkNCj4g
PiA+ICsjZGVmaW5lIFBDSUVfQVRVX0lOSElCSVRfUEFZTE9BRAlCSVQoMjIpDQo+ID4gPiAgI2Rl
ZmluZSBQQ0lFX0FUVV9GVU5DX05VTV9NQVRDSF9FTiAgICAgIEJJVCgxOSkNCj4gPiA+ICAjZGVm
aW5lIFBDSUVfQVRVX0xPV0VSX0JBU0UJCTB4MDA4DQo+ID4gPiAgI2RlZmluZSBQQ0lFX0FUVV9V
UFBFUl9CQVNFCQkweDAwQw0KPiA+ID4gQEAgLTI5Miw2ICsyOTQsOCBAQCBzdHJ1Y3QgZHdfcGNp
ZV9vYl9hdHVfY2ZnIHsNCj4gPiA+ICAJaW50IGluZGV4Ow0KPiA+ID4gIAlpbnQgdHlwZTsNCj4g
PiA+ICAJdTggZnVuY19ubzsNCj4gPiA+ICsJdTggY29kZTsNCj4gPiA+ICsJdTggcm91dGluZzsN
Cj4gPiA+ICAJdTY0IGNwdV9hZGRyOw0KPiA+ID4gIAl1NjQgcGNpX2FkZHI7DQo+ID4gPiAgCXU2
NCBzaXplOw0KPiA+ID4gLS0NCj4gPiA+IDIuMjUuMQ0KPiA+ID4NCj4gPg0KPiA+IC0tDQo+ID4g
4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K
