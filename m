Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B426EC64A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDXG2Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 02:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXG2X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 02:28:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2138.outbound.protection.outlook.com [40.107.114.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F4210C;
        Sun, 23 Apr 2023 23:28:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtQGjN8UimopswADbYQ4L8vhUebqk6bKDWz2H64vJ0AMSAM1ElpDvvP/pO3IehHuVYcTBXMMXukKvE757+RjaVA+69kjgULGlVjDZ2V0jqhvrmwoa/ZtkkyNcwLH+UQL0cbeI314+lu9OcyLE/1VB6p1aCMEgyjgfQcCJEwLowxfeV/vLBcqa0tXWSgzzFBdDFYisNQ64AO5OqgGnWrTA2FAOd4+VfvfUqpkSFpP70wasngkusol27gtlM/OGdBVGlBYiEPjl+gluYW+nYRyVmgC9/rZEO4VEffHShHFWSNtEn1C0ZDas+39p1UEXdM7TcZRhxjrxXQ3fHJgZ1HV6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5E6hQU7BQakZGG5FKREpcG4G81uR15VzaS4OMJ9Lmg=;
 b=gBIopqGPUB54SbHsLitTz3tuXFvXYYaQhS4EtzKS+/VlKAu7U4fPEPPcy1ZVsjD6sQYhHo+rVHpNuzyrj7scs2FodSjMKS4TP3qzZ/tSze/qumgD2B73kETmqkXoFLA443NWUDqIv3Go/UCdz4ZxuASuxEBBEuWcdbWyssPYVfaUXtojB5TiP9ZmIwKO8w1clEJl/hC1CCORyyp0+An79RB5AixkydwOb/bWGfjg0XZllT+hcpUDp9keOf6RS9ZDWB70jH33amKVMiLYsrmz85bRFAseEOhvRC+ypc4XElMwCVNLattyoyiqsZvznilu3pHgBzzgVEunRu56sZwQOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5E6hQU7BQakZGG5FKREpcG4G81uR15VzaS4OMJ9Lmg=;
 b=Ig7stbhdwrcKjHQNfhn3v0y9DNhphx5pgcTRXgORQN7p5PMtc9mhiUgdauCDPKCFJ6yYoY/Zwzuu0GXo2Wrhtmfa1FxT+e8EWEbUgXPDFHPtq34nszzY69ItrJYbZJEIUUlfau+WKa9bD5WyNdDTWlooRpVXKyLdElR+01zP1W8=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB10193.jpnprd01.prod.outlook.com
 (2603:1096:400:1e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 06:28:16 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 06:28:16 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 16/22] dt-bindings: PCI: dwc: Update maxItems of reg
 and reg-names
Thread-Topic: [PATCH v13 16/22] dt-bindings: PCI: dwc: Update maxItems of reg
 and reg-names
Thread-Index: AQHZcfCxr90EVigAQkOjyVyQ1td66683YkYAgAKlfrA=
Date:   Mon, 24 Apr 2023 06:28:16 +0000
Message-ID: <TYBPR01MB53417A965C5C66D620AD2658D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-17-yoshihiro.shimoda.uh@renesas.com>
 <20230422140230.GM4769@thinkpad>
In-Reply-To: <20230422140230.GM4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB10193:EE_
x-ms-office365-filtering-correlation-id: e24abad3-a8f8-46f3-3a94-08db448d168f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KflOokXjyETyaqoCx9Tmy6OTK/3GiYmfimCQdDE1n0M1/6mQrXV2N/WVQpi4M0hH66movjTOY+uahJ3hWX8cvLRzeIEUlJqHzqEcHHvgaiWyXIFmMX3F7/EKZ+s/IPGUZUPkJ0Ei+wri2yEIqEQLsSCJ0TcecPlqrkBDugAjHsvNNTMs5nUDm1DiMvk4UNwZDrinpkQj4KjMRhCZmWyN9JY+Z8rA5+STcSTByR0BjJxNfkf9DshyJQ8681koLz5nJwOK8h3jfIjWZvFkhnEmePWFghyk4tqxOwBBPpHMbhlHwkQxT7PaIkllV7C0pCmpR96ou06lsaZBnb7JVU4FuUMiJ02qNo64IEFJOKk7qgYy1QWN4ARmeWuNtPt336DQ7djqCrCCPDbiTCl9dOVlanc7tQLoWOs6Dyo9TiuJVLhPw2Gnki7yUP5dn5spmWaA/qGVG65LintD6YXtVHhvIdQ66FHjQdJ3lW9Y4scVTH6chqaSo0UYT4L0x0PYS5ID2XPSese6BRGcR49rtLXlHI5Sf0/QQ2o+1Q6oPfpGiOkFI49sXnox6pT4bxKHXn9T9tKRMFyYQfdHwQhf/O3PrEg0zM1aexHV6pSNdPhknOLHt7VogsCPCBG5y5XxUP2L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(54906003)(86362001)(186003)(7696005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(6916009)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(15650500001)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFdwT2tLUE9KclcyRExEeCttdVNSVGtUaTdudEVyeDRsMWlhY2ZNamIwS2U0?=
 =?utf-8?B?MWZDTi9nbkJ4a1Z0em1rOG1RalY3OE5Lbyt0U1hxMTl3aytlUjJFc1NKdEhj?=
 =?utf-8?B?bzJ0M253MmRtWVBOZW1wSmkyMC9mY1RKdWtSMExLajBtNTRjSFdXL0x3amxw?=
 =?utf-8?B?R0NEWkllTjZ3c1ZQanEzOENWVk4vUW1YQkRBMzNMdWF0bGNHaUxLL2tpcXEr?=
 =?utf-8?B?MkhuNXdIUHVvUTRURWdtNWRTNS8wUFl0VFhYRkR5TmRaN2RkV2lpRnQ5ckhD?=
 =?utf-8?B?bEROa0QxUVUxQks0SWhJQVp5OWpiVk5aZEpEWnRFUEVjSWRTa0xZc1JBeWpQ?=
 =?utf-8?B?aEVSMFFNdTFPVVRQcHpUUmdtZHlrZE9WVlY2aGVDUW10Yy91eisvTDYvcnUv?=
 =?utf-8?B?RkoxUW5DNnJuc3hLci9FaW5HeHpGbklvUUlkbTY1cUVBdGdHRm92N2dHT0xW?=
 =?utf-8?B?b2E0UEZwM28zZEZLckhJQW9TRFRKN3hTVzBvZkRLUWtRWTc1dHd2dVFCY1RT?=
 =?utf-8?B?TVBtWWNBRVhrbEp0dmpSM1hPUkxERTVzQUQyVUMwMDU1blNiOTdVblROQUk5?=
 =?utf-8?B?OCtGdjNEcTJxaE9iRERDYzRuWmhnK2VEWWVhUXRJN3RCWGdJaFk3R3JyNUFI?=
 =?utf-8?B?RGUxR2N0akM4SmxCSGVqMEUxbG0vQTE1MU56NkxLREVSaTVWZW1vbGV2RXBM?=
 =?utf-8?B?Y1RVTmhpcEFIazB5aHRyeE9vU1RJT3JEejZsQlNCbXlJTm1qUHE4b2NqUWh4?=
 =?utf-8?B?cllqcVBkT1dpTGFjVm9KQXJwVVJNNjdOWDRId3Z5amNnOTg1cmtIZ3BSZzRj?=
 =?utf-8?B?d1BtOW1iZVdsaldac0VVNVl5eWZhcmVvckRjTDRIQ2RvR1VlR0Q5SEltRDBn?=
 =?utf-8?B?WUhXcHpEVmlCK2o2c1pEV29XUGU4blg2eEg2QVJHbEdGUnM3ODdhOXlxb1pl?=
 =?utf-8?B?Unk4eEQ3KzhBdE1IMWNWWXpGWHZwejNyWHc4eUlmeExLNHkwQ2I4QzlXUDVZ?=
 =?utf-8?B?c0xNaUFnQWlWQmd5L2xjZ1RRMHFBdm9TS1M3Tkt4ZkcvWVp5MHh6TGUvd3Rq?=
 =?utf-8?B?SGNoVmJQN2tKdXNjQURsT2t5a0FUZjZKK1RUZWxDaFllZUhuNEl4Q2xOM1Vh?=
 =?utf-8?B?dTZCRDhXSjZDUGpMclFRVkhSNnZTdU9LVG1hZW5NV1JjenhCK05lT0RUOHc0?=
 =?utf-8?B?S1lUdktoUDkxRGZQZzhOM0VCaHlyOVRUc2JrQ2g0emQveEg0YitLN1djYkVn?=
 =?utf-8?B?bWh3SmtYUE1lUFAzam5zRmd3azdDZWVXOHUyQW1EVEtJYkdITlBjY0Q4d1Fx?=
 =?utf-8?B?RXJSUVhSaXBhSVNNazR6NGZBOHBwazliakhKRWtSWkU1VWtLT09IU01nK2RZ?=
 =?utf-8?B?Rm5QNDFqVW9IVFhrckxqWTdxTHRYcXdOcllrSzhRYlc4WlNKK0N2Vjh0ejIw?=
 =?utf-8?B?aHZobVJJeEpSRVNSUytQNjZGWXZWL09Ta1k4ZEFBNDRCaDhxdTErQ0FINmxZ?=
 =?utf-8?B?Rm52K0lGK1Q0RzdOd3FKdmVGZHd1Rzl4WmRSS3lKbE9hb1BFaEd2U3M5WU5l?=
 =?utf-8?B?a1AydlF5ZFhRQXp3VVB5MFQraUpPSTJZd1BUZzhyZ2g1RDIzc3FXVGxvelY0?=
 =?utf-8?B?WjhmR282WjNZaDVsZUwxUGtiS0hhR0RtQU8vYjhyYjhmdEJZNk03THNRYURt?=
 =?utf-8?B?VDRPdEVaTy9yalNnS3ZBank5alJsMVZ2MGp6eU5PeHVObHV5N3BrTkpjZUpW?=
 =?utf-8?B?NFdINUx6RHZ1VXl5cHhZUEZPaitXMGIzcXV6S1hudnRIeWV5elZXQjhNY0dP?=
 =?utf-8?B?a29CVWkyNVRmem04Qm90YVFkZ25mNlk5bS8wUnQ1VXF5dzlJUmFycE5tSVJV?=
 =?utf-8?B?eDgzMUJHRDd5dTNXS3QvcWorUk1hdGFvU1I2cmJjbytzcGRXR1FzMFh3QWhq?=
 =?utf-8?B?bGdOcFhDMERRRk9OeVpPUWpzQTJ0SHQ4QVVsTjBSVGFySXljRGQreEhmZzB3?=
 =?utf-8?B?YnNSRFVkU1hQaGVxamdFTk1HS21IMGl1YndTbnhmWEZ6MjdoaGNHSUhmbEJm?=
 =?utf-8?B?aTdCajhwZUpnQmRjM2M4NHd3bmxuWGRCamU5U2dhM2xkWEtsdGV0aFA4ZXY0?=
 =?utf-8?B?YlBEbjZRUmNOaDgwczF1VldpWlhITlU3K291VVdXcGhQUHhvY3JpY21Ob3BC?=
 =?utf-8?B?TFRXbkxhRlQ1WUpZdU1BZVZwVEVBdTJ3R2ZnRmFQTE8ybFlOUWt0Q3pEL0w2?=
 =?utf-8?B?cWRRQmJYenBPblFyN09OMnY5b013PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24abad3-a8f8-46f3-3a94-08db448d168f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 06:28:16.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QC3zG5VhA54axKL8FvbGABeo3BD0a1gOs23DOUX7NncoUpAnFVo8jblllTC86XNdvwCjgWiuVitua68BAvV9gGdotkfjNuMk0C+C/Ui96ax38S9CfAL5wlwG3bKFh63R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMTowMyBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjM6NTdQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gVXBk
YXRlIG1heEl0ZW1zIG9mIHJlZyBhbmQgcmVnLW5hbWVzIG9uIGJvdGggaG9zdCBhbmQgZW5kcG9p
bnQNCj4gPiBmb3Igc3VwcG9ydGluZyBhIG5ldyBTb0MgbGF0ZXIuDQo+ID4NCj4gDQo+IFdoaWNo
IFNvQz8NCg0KUmVuZXNhcyBSLUNhciBTNC04LiBTbywgSSdsbCByZXZpc2UgdGhlIGRlc2NyaXB0
aW9uLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5z
aGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gV2l0aCB0aGUgYWJvdmUgZml4ZWQsDQo+IA0K
PiBBY2tlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pQGtlcm5lbC5vcmc+DQoNClRo
YW5rIHlvdSBmb3IgeW91ciBBY2tlZC1ieSENCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNo
aW1vZGENCg0KPiAtIE1hbmkNCj4gDQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLWVwLnlhbWwgfCA0ICsrLS0NCj4gPiAgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9zbnBzLGR3LXBjaWUueWFtbCAgICB8
IDQgKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL3NucHMsZHctcGNpZS1lcC55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9zbnBzLGR3LXBjaWUtZXAueWFtbA0KPiA+IGluZGV4IDhmYzIxNTE2
OTFhNC4uY2I3MjdmNjBiZTBiIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLWVwLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3NucHMsZHctcGNpZS1lcC55YW1sDQo+ID4g
QEAgLTMzLDExICszMywxMSBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICBub3JtYWwgY29udHJv
bGxlciBmdW5jdGlvbmluZy4gaUFUVSBtZW1vcnkgSU8gcmVnaW9uIGlzIGFsc28gcmVxdWlyZWQN
Cj4gPiAgICAgICAgaWYgdGhlIHNwYWNlIGlzIHVucm9sbGVkIChJUC1jb3JlIHZlcnNpb24gPj0g
NC44MGEpLg0KPiA+ICAgICAgbWluSXRlbXM6IDINCj4gPiAtICAgIG1heEl0ZW1zOiA1DQo+ID4g
KyAgICBtYXhJdGVtczogNg0KPiA+DQo+ID4gICAgcmVnLW5hbWVzOg0KPiA+ICAgICAgbWluSXRl
bXM6IDINCj4gPiAtICAgIG1heEl0ZW1zOiA1DQo+ID4gKyAgICBtYXhJdGVtczogNg0KPiA+ICAg
ICAgaXRlbXM6DQo+ID4gICAgICAgIG9uZU9mOg0KPiA+ICAgICAgICAgIC0gZGVzY3JpcHRpb246
DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
c25wcyxkdy1wY2llLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL3NucHMsZHctcGNpZS55YW1sDQo+ID4gaW5kZXggMWE4M2YwZjY1ZjE5Li4wYmZjZmQ2Y2Ni
NWYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9zbnBzLGR3LXBjaWUueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kvc25wcyxkdy1wY2llLnlhbWwNCj4gPiBAQCAtMzMsMTEgKzMzLDExIEBAIHBy
b3BlcnRpZXM6DQo+ID4gICAgICAgIGFyZSByZXF1aXJlZCBmb3IgdGhlIG5vcm1hbCBjb250cm9s
bGVyIHdvcmsuIGlBVFUgbWVtb3J5IElPIHJlZ2lvbiBpcw0KPiA+ICAgICAgICBhbHNvIHJlcXVp
cmVkIGlmIHRoZSBzcGFjZSBpcyB1bnJvbGxlZCAoSVAtY29yZSB2ZXJzaW9uID49IDQuODBhKS4N
Cj4gPiAgICAgIG1pbkl0ZW1zOiAyDQo+ID4gLSAgICBtYXhJdGVtczogNQ0KPiA+ICsgICAgbWF4
SXRlbXM6IDYNCj4gPg0KPiA+ICAgIHJlZy1uYW1lczoNCj4gPiAgICAgIG1pbkl0ZW1zOiAyDQo+
ID4gLSAgICBtYXhJdGVtczogNQ0KPiA+ICsgICAgbWF4SXRlbXM6IDYNCj4gPiAgICAgIGl0ZW1z
Og0KPiA+ICAgICAgICBvbmVPZjoNCj4gPiAgICAgICAgICAtIGRlc2NyaXB0aW9uOg0KPiA+IC0t
DQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCv
jSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
