Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9457379FBA9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Sep 2023 08:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjINGKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 02:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjINGKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 02:10:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30925DF;
        Wed, 13 Sep 2023 23:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnYbBZiUqBbzlSKozBhlE6J3Vaf8ylddT2O10lP5jJdFWGOUHU5pioRSJ2MXGymw2ux2AfT+A5ErH0YFEi2ZbPfEnKhbQvBbL9i9mEBvpGXT/YueTrsPtkXvDNB7bPoMuSIK0Ag+L5ZH4bCvXbW6amaNveuJa7MdErLH+M0dyjxpTYiDuQ82l8S2D9tDtalSNjmaQffOvVoyWKAQ/Hvs2wbgQ0aAh/auwpQQqvuaDCmHkUHNeZyCOzzQdKVp4ohHGE3SXDgOgz8ae+n5b4sHtewi/J3v7sky/VLzUPf4AbBnDohb2HjhEqURi3SLnVqJkam4eAIsuiPauED8BXtSMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9i7tQWsPcVTXWrjaKYgs2y0LdE45wq9mDUyAmcRmdc=;
 b=N+lic8E2Rd0Nq+ZWJiqfEsuGjxvYhbw/tAfQ1V+a6xGBdq3Mfk+Qj+4IP2Zb4aJWltm64RJgOuxAy2Upw7ooUX6BQib/dL3l/6Jvk1rrp8V1ihgvI1NGtsmCjdORTTpt/fz/94E3d0a2qNzBoWDVBu2/S597tfxrtAnkmGytd0PWLS+KYQ9mOztrfuW4Ob/9ozE4qHdgtwVg1xQ6qLUCLZvWkNG5U5Gc9fAKtLaC+TWvG5zajg+8rT2ZLf/QMM7k/6yJQ/lkFoRFOfHSKGq5Y1AKPSMRrQfJxKADfubL0EK8toSdELJ0H6G3PjuC20eG87ymS0wxFLWLy1/EnEB59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9i7tQWsPcVTXWrjaKYgs2y0LdE45wq9mDUyAmcRmdc=;
 b=HReJ29n3flG99OmfCgFwJ1M8ORacplpmDU6za8GWOfZqCDuUiOMV4cUr95g6SDHlbTCGGz5cIu0aDQrWGV0msSpEKoejx1CnEez3omotUyjYU/BFBNbjDgtKsvnODdje6+sRw0lelrfWb/ExNcKua4kCghryJVDcVkzo9zcMCXA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6923.eurprd04.prod.outlook.com (2603:10a6:10:114::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 06:10:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 06:10:26 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "pali@kernel.org" <pali@kernel.org>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Topic: [PATCH V2] pci: introduce static_nr to indicate domain_nr from
 which IDA
Thread-Index: AQHZzxhuyRkzZgDao0KEaKWaunEMhbAX8PmAgAAxQqCAAA8+AIAACMAggACakICAAO0HAIAAPtMAgAAEQUA=
Date:   Thu, 14 Sep 2023 06:10:25 +0000
Message-ID: <DU0PR04MB94174CD722E027BB537ED66988F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <DU0PR04MB941790B85BCDD60ACA2601A588F0A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230913115737.GA426735@bhelgaas>
 <DU0PR04MB94175EF2754D45D010F21F1188F7A@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <44a783f5-c4f0-e1d9-8802-7c8aeb444f08@linaro.org>
In-Reply-To: <44a783f5-c4f0-e1d9-8802-7c8aeb444f08@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB6923:EE_
x-ms-office365-filtering-correlation-id: ff6b1930-9f3b-48df-73cf-08dbb4e949b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NRXTz9aifKji2Y0Ihnvs7/98xwQxapxTczQjnONBKSeXZe4qfE9ht6DmkuVGAnPC7F0dnDepsb7OizfOI1M0I3pfLd8pHz/CNoetJp/43AR6zHyhlC7ag+4kYZlOZWml5rUnsYGFQNKYG3lnhmVNX5X+zEgW5AUjN4LttbLQHh7gCfRLiwLy1Hk+Q/zil8AtpUEusOPx26AJo3JQTtCcgdLYsE45mogIvFpzp51w8xsOfs+CCioyfM/A0fRs2y24jxR5b545JgKxGp8gdsu4RngVLHlT/vh4/4KstxKVVM11eU7n8PA3t9pBzQv+T7Hdc5a254eVIe/AUweBo7MNgccMXW2tZhAUded6y1X0KXYvsG6r0sqYjP9bmOGZICCQ7CTg6l7bTMcCR0dfy5KiRltqSDE4r/U9VsJbQhRgVO1rPJWJWiV/OfLin/Cfbo42urr8ff6IQJYC06pB6ehGfT7g/YqARIN/u2nA+31w00juxlgeJyoSe1wDI70hwqFtm3zX3oFukWS6KskvVzeDErzPM61YOI4b5hJeaDDgjqhapwoSHMQrmLlBB4uIV343/JTH4rOkF8dOCfLFYqdfwKgSAnvLKK7+4d8zDFpcoaTA43SiMpEBcJGeiF6jIcv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(83380400001)(122000001)(478600001)(38070700005)(38100700002)(7696005)(6506007)(26005)(9686003)(55016003)(71200400001)(86362001)(66946007)(2906002)(52536014)(8676002)(33656002)(5660300002)(8936002)(44832011)(4326008)(7416002)(64756008)(66446008)(66556008)(66476007)(54906003)(76116006)(41300700001)(110136005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWRTU25pMW94Q1BOdFNRdThDUFBFVVpTVUVPdFJHQ2NBWEl6ZlZmdDBtUDBz?=
 =?utf-8?B?anlPaHNXdGZIenAvWG5EQ0xJUkxaM3Jqd0lURkxwOG5qN3R3L0U1a0hvNXZq?=
 =?utf-8?B?TGFkenpuQTArOWdXN0gxcnluNUFaTUhVSUFIajBUYXRWbW1uMHNJRytMTFFG?=
 =?utf-8?B?a2JQaUdwcjVWOCt6UFBDQmFzWHFsZDROVGRaazJ4Q0d1TkdNSUxzTzNFVXF6?=
 =?utf-8?B?aW85OGJpZm1rdDh0ZWRVSzgzOHpJa2YrYXFrcG9aSVdSQ0JEOVg5QXN2WUpV?=
 =?utf-8?B?bFNkalVzMURDM0J3SXdTRFhrY1RJaWlBK3A4QzhCL0o3ajhzbEMwbllSWkF1?=
 =?utf-8?B?cSsvYytZZExpRHVrNDY4VXVySFM0dnhyVEdLSnN0MEFqdDhTU2xJYm1oV2xV?=
 =?utf-8?B?Sk5mVEwxZHNpYlZwei83U0Z2Q0pJYmZQUmVBQmpTYytVTm5zS2FxSldrVDB3?=
 =?utf-8?B?ZTE4Qi8xRGJ6V1BTUWVrMVY1eTd2YWR4LzBxby9hL2VIb0w4bUZGRTJrMERM?=
 =?utf-8?B?dmpoeGNhRHIzTFBKakk3Zk1ZVUxURG1JeG1idDcrcXVGa3ZiR1BtMUdIY1hF?=
 =?utf-8?B?aXIzRmZoMU5sL3lrZzdNWW1WRWN0OVR2ZEo1d2x5RHpPaTJNR2xmbmMwR1Vn?=
 =?utf-8?B?bFl1WDI2dUIvTGM1RS8zVzRaN3lrSmxiMWNUWHB2RDNGSjNLNzNyK09NenV3?=
 =?utf-8?B?c0kzRDFZb3ZTVHZOOW5TMlkrZXFBZm9lYUNaV0lGdWwzNWxUdk04MVJJVnNM?=
 =?utf-8?B?VWs1ZVZ2VExVbnRKVFF4eERCbVljSS9MbUdOdlovVEljODYrRUlIWVkrQ2h6?=
 =?utf-8?B?aVlJRi9SK2FITWdjbDR5Uzh6ZTIxVXRONG1hb293ZGpNcHk0dXB2ZjUrYnFl?=
 =?utf-8?B?d2p0bmlrb2xuTzYyYUIyOUVuZ0hGd2FiVDBqRm5ZSjZGd1FJWThtZzZzaHIr?=
 =?utf-8?B?L3V2MGc0QnhSZWZieUpXY1pFWEtFamNPZURGVlMzWUlNRWttZVdHVVc3cUJY?=
 =?utf-8?B?bFJrbmV5Mno0cmYvdHZsRk1tVjd6aU5VQ2ZrVS9BVlk2ZW1yaUdnbldqWWJa?=
 =?utf-8?B?ZVRYOGlWN0pIYVQxd0E1TjFJNTY1cnlpQU5seE5iQlZEK1doNndwN3FaM2VE?=
 =?utf-8?B?RVVJbXR3K3FLTEZ5aE5aM3BxZ3EyN1RyZGtHVENEN3R5b3k0aCtUcmZONno0?=
 =?utf-8?B?b08yOTFYUm5XQnI2SnJQOGNoaEMzNkxUczFQSmp2clRXSzd5TERGMFc0ODdZ?=
 =?utf-8?B?R0FJSVpGanNkVDNhK0h6SzBoWGcvVmc3L2srdGhQTjVNdlM0OTkwV1FHL2lS?=
 =?utf-8?B?anFEalE2VWF2UkFUcTN6b0M3QVh6T1lxMjRUZlRUZXQrTHZzOTZkTmovRHpo?=
 =?utf-8?B?ZEpiWCtZMlB1aG1ZdmVpQ3QyeU1qZzdyYkN2YW1ZSHdwRi9qNGRvMU9HTE5L?=
 =?utf-8?B?bnNBRU1OVVNIMTQwalI0ZUE4L3g1RC9HaW4xTVc2LzVFeHJWZU9kNGRwa3hT?=
 =?utf-8?B?S0ttb21GWVlyUlNVa3ZUMklPTU1vemtjK2lQbjFBM1NJQzE2UElmSWNRV0l2?=
 =?utf-8?B?eklWMUprNmZYRjBoNVljSXdHbTNER1BZOGlRbEhQdVZSNnhEOXZYRERsMGdU?=
 =?utf-8?B?V1pBWGVoc0k0UW95aUxDeE5CT2Z2dzZxc1Vac2dJV3RzOUpPbUZGelduR0lG?=
 =?utf-8?B?WElFOS8xbnRnVEtDMDA1RHVLT0FUUDVFZUJnSXdnSHVBQ21pMWxFT21lVk01?=
 =?utf-8?B?UXhJVVY4QkhSNmRwMXJHMUJjWTNmSFhld3RhSXI3OE5vQ1hybTZIdmFvUnAz?=
 =?utf-8?B?ZUhkWGpNY0VxWTlVdzcyWUh4NnJJREhFaEludUhDcjRZTFplN1N0OGErZ3Vr?=
 =?utf-8?B?Z3RrUnZxZ0VuZ3ZjVmNEdGsxUGxKekszS2lJdXozVWxrR1FFa3ZYRGREWTJw?=
 =?utf-8?B?NWVPbTc4anIvUHJsQTF2eEcyL1NyeGFqS0JPMlY1MktzWE14akJETitGRXJE?=
 =?utf-8?B?aG9zZjBqVVBEbjJ4a0RjM2RUejR4NDExaFNOU2tSQjJxUTIrRGdlZG43YzI5?=
 =?utf-8?B?bzd0aVg5bEtwT01sRGNIMEpOWUZvWkdzYVJ4V2ErUzE0UlFmRUdqV1F6N3l0?=
 =?utf-8?Q?55xk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6b1930-9f3b-48df-73cf-08dbb4e949b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2023 06:10:25.9574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO/nfSNrEhtDHqkzK9SNJifJ7Wym/rBgYKe1UIjMt2ucVlYGmEGL95apeMffo5sjzxZnoHzz3cfxetLukweUgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6923
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U29ycnkgZm9yIG5vdCBiZWluZyBjbGVhciB3aGVuIENjaW5nIHlvdS4NCg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFYyXSBwY2k6IGludHJvZHVjZSBzdGF0aWNfbnIgdG8gaW5kaWNhdGUgZG9tYWlu
X25yIGZyb20NCg0KVGhlIE1ham9yIHF1ZXN0aW9uIGlzIEJqb3JuIHNheXMgIg0KSXQgbG9va3Mg
bGlrZSB5b3UncmUgdXNpbmcgYSBub3RpZmllciBjYWxsIGNoYWluIHRvIHJlbW92ZSB0aGUgZGV2
aWNlcyANCndoZW4gdGhlIG9mX2NoYW5nZXNldCBpcyByZW1vdmVkLiAgSSB0aGluayB0aGF0J3Mg
dGhlIHdyb25nIGFwcHJvYWNoLg0KVGhlIG9ubHkgaW4tdHJlZSB1c2VyIG9mIG9mX2NoYW5nZXNl
dF9yZXZlcnQoKSBpcyBpMmMtZGVtdXgtcGluY3RybC5jLCANCndoaWNoIHVzZXMgdGhlIG9yZGVy
aW5nIEkgc3VnZ2VzdGVkOg0KIg0KQW5kIA0KIg0KVGhlIGN1cnJlbnQgb3JkZXJpbmcgaXMgdGhp
cywgd2hlcmUgQSBoYXBwZW5zIGJlZm9yZSBCOg0KICBBIG92ZXJsYXkgaXMgcmVtb3ZlZA0KICBC
IHBjaV9ob3N0X2NvbW1vbl9yZW1vdmUNCiAgICAgIHBjaV9idXNfcmVsZWFzZV9kb21haW5fbnIN
CiAgICAgICAgb2ZfcGNpX2J1c19yZWxlYXNlX2RvbWFpbl9ucg0KICAgICAgICAgIG9mX2dldF9w
Y2lfZG9tYWluX25yICAgICAgIyBmYWlscyBiZWNhdXNlIG92ZXJsYXkgaXMgZ29uZQ0KICAgICAg
ICAgIGlkYV9mcmVlKCZwY2lfZG9tYWluX25yX2R5bmFtaWNfaWRhKQ0KDQpCdXQgaWYgdGhlIGhv
c3QgYnJpZGdlIHdlcmUgcmVtb3ZlZCBmaXJzdCwgdGhlIG9yZGVyaW5nIHdvdWxkIGJlIGFzIGZv
bGxvd3MsDQphbmQgdGhlIHByb2JsZW0gd291bGQgbm90IG9jY3VyOg0KDQogIEIgcGNpX2hvc3Rf
Y29tbW9uX3JlbW92ZQ0KICAgICAgcGNpX2J1c19yZWxlYXNlX2RvbWFpbl9ucg0KICAgICAgICBv
Zl9wY2lfYnVzX3JlbGVhc2VfZG9tYWluX25yDQogICAgICAgICAgb2ZfZ2V0X3BjaV9kb21haW5f
bnIgICAgICAjIHN1Y2NlZWRzIGluIHRoaXMgb3JkZXINCiAgICAgICAgICBpZGFfZnJlZSgmcGNp
X2RvbWFpbl9ucl9zdGF0aWNfaWRhKQ0KICBBIG92ZXJsYXkgaXMgcmVtb3ZlZA0KIg0KDQpJIHdv
bmRlciB3aGV0aGVyIGl0IGlzIGEgbXVzdCB0byBjYWxsIHBjaV9ob3N0X2NvbW1vbl9yZW1vdmUs
IHRoZW4NCnJlbW92ZSBvdmVybGF5LCBvciBvdmVybGF5IHJlbW92ZSBhdXRvbWF0aWNhbGx5IHRy
aWdnZXINCnBjaV9ob3N0X2NvbW1vbl9yZW1vdmUgaXMgY29ycmVjdD8NCg0KVGhhbmtzLA0KUGVu
Zy4NCg0KPiANCj4gVGhpcyBkb2VzIG5vdCB3b3JrIGxpa2UgdGhpcy4gQ2NpbmcgbWUgb24gc29t
ZSBodWdlIGJ1bmNoIG9mIHF1b3RlZCB0ZXh0DQo+IHdpdGhvdXQgYW55IGNvbW1lbnQgaXMgcG9p
bnRsZXNzLiBEbyB5b3UgZXhwZWN0IG1lIHRvIHJlYWQgZXZlcnl0aGluZyBqdXN0DQo+IGJlY2F1
c2UgeW91IHdhbnQ/IEkgY2xlYXJseSBoYXZlIG5vdCBlbm91Z2ggb2Ygd29yayB0byBkbywgcmln
aHQ/DQo+IA0KPiBBc2sgc3BlY2lmaWMgcXVlc3Rpb24gaWYgeW91IG5lZWQgYW55dGhpbmcgZnJv
bSBvdGhlciBwZW9wbGUuIERpcmVjdCBhbmQNCj4gc3BlY2lmaWMgcXVlc3Rpb24sIGJ1dCBub3Qg
IndoYXQgZG8geW91IHRoaW5rPyIgKHRoZSBzYW1lIGFzIHRoaXMgcXVvdGUpLiBJIGFtDQo+IGdv
aW5nIGp1c3QgdG8gaWdub3JlIHRoaXMgZW1haWwuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KDQo=
