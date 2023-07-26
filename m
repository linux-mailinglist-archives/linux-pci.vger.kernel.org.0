Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D424C7628F7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 04:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjGZC6e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 22:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjGZC6d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 22:58:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED92DD;
        Tue, 25 Jul 2023 19:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0Wo32YvR4ep1Ymw0xMi2kIFMpw+2hpissfqtt1hI4Y5+AYrVA/ik/2pDnSWzybb4/mFbaf2848QlbJQvBJtuA6RlwZDJd5BqlVdZlcEkEdH4jMTdNxCpyJtyERfF3BwIIjGEZlFp9errg9fMExXJhKViJbFTyOXSP7ONZwJlJetZGUzParzbPsGwBygTzB0+1ju+u/6xacA5tBvYTarbHIQVdKvzH42PxbYJ/vlyQoiiv6WUjbM4zx7h6eexUkxio/qK09L30I7ISwnkVE6SjSFVehd2WLXaJdBNG8iHJfQ3qY7MCxR9O9OduZUKjhDas8AbsuXt8l1p5bVDOw6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJUOaKNsaZvcmFro1cJgs+j4Aqnm8aUsOkC5591fHQ4=;
 b=cLddkkGCvCREuxtbzntE88JnkUwGPI4Dxn8WiSwM/hZfN81Nke0SaZxTLT48lIobD/c3MZm1F5iJl7XRwG/ipZqHrhd9ngDpYgi8ehjvLkXDhD/WiLHBy+AVaTYfC4flo71HB83zQykkICKZan6QNShTA0OVEOF9H8M8tQYlxkKRVOloowbm+cQOaCO3HTxyHEYsj7HI/lScPpdmFLh4PqtSepYmsixjNhkbAMWD4Qz2zS93EBy9PbBt34OWwbkcWY+WBK7Y6UrtluJthDA5svKgtDN5dhUfWnpweZlwtIie7omfKIq6Js5Pw42tF9950+niXTcYnVKqzMS0KltCAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJUOaKNsaZvcmFro1cJgs+j4Aqnm8aUsOkC5591fHQ4=;
 b=QjltvlKg7J/hB/5rIBE2WUwsUQFdik2O3xnpVvOh+kM1UjeCwGDgyiECtVcaNS3nIKLdYRsx/0Cs+vORci2ycu5kkA3E9YEPfMMVvLRa2Vwzga/1YmOzMdZVM6/9GJfFFtB6jqoeR8/k/9EFLjzc1hmutx3N/KOYddkckP5Mk9Q=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB11815.jpnprd01.prod.outlook.com
 (2603:1096:400:403::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25; Wed, 26 Jul
 2023 02:58:26 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 02:58:26 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v18 11/20] PCI: dwc: Add EDMA_UNROLL capability flag
Thread-Topic: [PATCH v18 11/20] PCI: dwc: Add EDMA_UNROLL capability flag
Thread-Index: AQHZu6dD3TthdB+bl0G1pRfnlxy89q/IzoyAgAKUGFA=
Date:   Wed, 26 Jul 2023 02:58:26 +0000
Message-ID: <TYBPR01MB53415AAED98A25EA48B28CC2D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-12-yoshihiro.shimoda.uh@renesas.com>
 <20230724113521.GJ6291@thinkpad>
In-Reply-To: <20230724113521.GJ6291@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYWPR01MB11815:EE_
x-ms-office365-filtering-correlation-id: 8760733c-4c95-43a7-7f44-08db8d842ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2aVfCzOutAuHn2ozSyIhX7ux6bhFEU+H1pjhiwDhDDFoVAhspMpZbmLa9vNgxxWzWztTCXy4buIAQyE+z0CW8cVQeaiRtATv+WojPwPpvUGiCi0BTbSnMV5SiXBA2f7MstCE/iuSa/sFp0qqgGxvRvSBvZPnnFOKQX4so32+AB4z1iRiZTDHrD/XWrNIEsruxqOjReeUu75Z9sfg33EFTY0Uf/mUekMQtaIRTnKmafcPmkioTAgQ4a2RWa+g4vgtnfRGWzZ2HCvGTyNUbJBQ78IuvryudTtXq9wMIuRyYKbepFNsu1mvoxYdDxZCE/v1K2UkNy8Slj9RkcWoCUwU0io631iT3HWj5DSjgO2/Q8zc4Ij32E92rUZrh2kld0TbA2+IQ2MW0thSnv4oaVtnEPpG0iyy66K/HXp1CLSKJYeJlFxXOdeETbAHAf+UmIiOaZv2ugDuSF450D0xk41EUOc/nlwrIlAmD1s9YHxSOFYEwvSrdRMdLAI3TTwMBfBEepmrr7nOuBeB1Gnec2QUEHzuwfV/aJ3x8230wHH/Wd5iJuVIOcBEx9IlyP6HqvV4vupC+JdjQ9rZ4WDQn+mjIF1XwZ5Q6rUdyST51efk62s+cUeRAayKzPrxz3tMi4um
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(6506007)(71200400001)(9686003)(478600001)(7696005)(54906003)(186003)(2906002)(41300700001)(5660300002)(66476007)(6916009)(66556008)(4326008)(66946007)(76116006)(64756008)(7416002)(8936002)(8676002)(66446008)(316002)(52536014)(122000001)(38100700002)(33656002)(86362001)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFl2c2ZZYUNHZGVtd3JhcGFrYThLM2tLc3RqdHd1SFA2azQyNVZ2UEdNc0hS?=
 =?utf-8?B?T3hDdlI0Uld6d2IveGYyU3BnSnVRY0ZZejB1ek5UVWpXWXJ2K2oyWTVQaERk?=
 =?utf-8?B?bnZuZ3pzeFlZdDZTRUdROWNhRnpnY2ZuUTdjNlMxVnFidzJkRWpPZFc5ZFVK?=
 =?utf-8?B?Wm5PMjN5c2Y1VzUySmZpeDY2dFBzY3ZaY2xJR2VhM1VKcG5Ja3RsU0l3V25V?=
 =?utf-8?B?Yk1vNlJjV3czUmlhRlhIa3RiU3hRN2pjNXp4ekNBN3YyNjlvR1pGZERWODl4?=
 =?utf-8?B?TGl1VjFnZmJ1TkszMS8rMFZHK2NUMVIxZlpHVlowUWMwQ2ZyQnBYTXYrTWc3?=
 =?utf-8?B?bTlNdjdUWHpEMERFN1k5akdDbEdqWVNlRFJVeDJiUTk3OTMxN0FGaGNza2hk?=
 =?utf-8?B?cCtnRjd5eGFsZGNqUkhiVUhVbWpRNVZaYnpDdG1xbE5mcTNrN21vTzVzb3Rn?=
 =?utf-8?B?NHUwWmRQT3d4OWNGQ3I5MGtkekpKWWhYZWhCcU1IL2FBb0srNW1Iek5UVFE3?=
 =?utf-8?B?aWxHMnRKNUNmcDErRE9RZUIzOC9tK1RTLy9MLzhaR1lCTWRBR3dlK1ZFdWZj?=
 =?utf-8?B?dmtmK1p6ZWx3SE9QbjJqcmhpV1dKNjk3Rlc4MDJRRzllRlY3OHRoSHlKNXZq?=
 =?utf-8?B?OGM2ako1ZWo1aWVjbHlrYlJWQUZRK2JOeTg5aGJvMjkwSXM3d3NOU3prMUR1?=
 =?utf-8?B?M2hNMnREVVh0YVM5RXRFYlQ0Z2NxaC9BM210WVZUNTdjemxBK051QWdPaUU4?=
 =?utf-8?B?OUEyalMyWWJQck5iTzNPMGtzalg2QitvWWlIdHJya3BIeEFQY3dmZE9WOHBG?=
 =?utf-8?B?b2Z3RXl0dzgwSEh2cEtlYkVxM215MEp2K2RkVFlEQm53d3pMeGI0UHlSeUJR?=
 =?utf-8?B?RkJRYlN5cCtYUzNtNDlkSXF6Z1oyRnlFYmVCRys2T2I1TmpLcHBtcXdUS2J6?=
 =?utf-8?B?bFlUY3FZRHBLazVBNVFHL2ZQY0VLS00wMHdqMFBRcCtNNjZldEdtUHdVZGZQ?=
 =?utf-8?B?WW1NV1d2Q090Qk9qY0xrUHAzZ3B4azRkcWpUd2hNZWsyYmlBejZZN3c1YkZE?=
 =?utf-8?B?MHVvNkQrT01VV3MycFBMbERhbFZ1N1dDUjhFblJ4TUR2OXdjU1hoWGxGVzUy?=
 =?utf-8?B?VWxMRE9IOE0zU3MzQXpTUU5pRTRzRlhhRWZwTGRLQlYyTzBvczVUMkdtZkhJ?=
 =?utf-8?B?TjVYZjNlSW40MUt5MVg0ckpQQmlNNk9jZWc0b3hOUVQ4V3JQOTN2OVRyMmhq?=
 =?utf-8?B?cmdEeGNLR3I2UGFaSGY3NlMxbklqZkJ3Sll4MnZWSEtUalRHOU9aMTFzeEp0?=
 =?utf-8?B?SEtWWmhsWGNHc0IrdGdHUm5ISkpueWVVbVZKbDdjNHhHNDVjU2x5TXo4Q3d6?=
 =?utf-8?B?UWxMRmk0YTAvVEQrSzVzYUt0KzU2YTZ6SlZCY2lFRzYzL01ha0dIMVgyQ3VW?=
 =?utf-8?B?WVpOZGQraEh6MWNidS9kaktiUERmRHpKcmI2QWRZM2ltcnEzSXB5MWtVNVlz?=
 =?utf-8?B?a0s1TUlEM1FBRCtURll5Mlp6cFA5RTQxVVc4T0JTZGUvZCtRaG5yKzAwSThR?=
 =?utf-8?B?blRDeGdpTk00c2JCVUltQWJuTEpHYzM5YVd2dDl0NWdtMHAxMEltdlI1MTJ6?=
 =?utf-8?B?b0dvYVlZbStmdTFWUmVXdk13Mkk5cWpvTFJGVENLN01kcEU2NngxNkdHZFIr?=
 =?utf-8?B?Z1Fva3RsMEdnb0NiS3R4eHVCOWlJQkprU1ZMYThyQ2JGeENJajBXcW9VUGw0?=
 =?utf-8?B?RWhJbjJrSWthOUx0VHYvQ3I5MCtWYU1jZExPWTlVcDNFL0daV0NqSU0xeEQy?=
 =?utf-8?B?MVZmdk1mRkk5Rk5mK01wZHZHNmNTb2p6b0VaUldNMTkzbmtPQS9lQ09TZTly?=
 =?utf-8?B?WEVlQy9yUU1qMDMwR2hkeW0yL0t1dm5mL00waUtkb2RQeHdrOFJzTDBlR29q?=
 =?utf-8?B?TnJ3eVlLb2RJTnFvNllVNVdCdGFKajFKSHUwNmU2bXRxbWJ2SnJUWEMzbEIr?=
 =?utf-8?B?Tkpmd090TXJ4MjJQVkNZdm9OR0xPSEp3UnZoNWFoTXA5VUEwaWNCQlBaaGFT?=
 =?utf-8?B?RVdhVndaOTFYbHVabklWWThZMm9MdjN5bjNuNExodXpDZTMyT2RNdG1ZOUc2?=
 =?utf-8?B?dFM2bzVaYVhZQlJ0ZW9EOWtGTS9KU05UREx2WHZNd3lQbTBvamF0TlBHTENT?=
 =?utf-8?B?REx3cVhlZFdHT0pleVZlZUNmUXdSM08yQTRsOThlVXNtaTNaTmIyWHpIOTg5?=
 =?utf-8?B?R05tdmpuQ2dmdjYyU2NVL29uYVlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8760733c-4c95-43a7-7f44-08db8d842ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:58:26.5906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vKbAYzBnPsTHqgl1sUrwl9RRt5kSCLocfeLjWu3lsMHwhVTt1wRSlv4+FZlxu+M6Q8Nao5Kn/NUbIv/5M+PROrvq1AOU81kWBbXA80LErrbfj8EaMDY/itkpaR0/tPYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IE1v
bmRheSwgSnVseSAyNCwgMjAyMyA4OjM1IFBNDQo+IA0KPiBPbiBGcmksIEp1bCAyMSwgMjAyMyBh
dCAwNDo0NDo0M1BNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBSZW5lc2Fz
IFItQ2FyIEdlbjQgUENJZSBjb250cm9sbGVycyBoYXZlIGFuIHVuZXhwZWN0ZWQgcmVnaXN0ZXIg
dmFsdWUgb24NCj4gPiB0aGUgZGJpKzB4OTdiIHJlZ2lzdGVyLiBTbywgYWRkIGEgbmV3IGNhcGFi
aWxpdHkgZmxhZyAiRURNQV9VTlJPTEwiDQo+IA0KPiBzL2luIHRoZSBkYmkrMHg5N2IvaW4gdGhl
IGVETUEgQ1RSTA0KDQpJJ2xsIGZpeCBpdC4NCg0KPiA+IHdoaWNoIHdvdWxkIGZvcmNlIHRoZSB1
bnJvbGxlZCBlRE1BIG1hcHBpbmcgZm9yIHRoZSBwcm9ibGVtYXRpYyBkZXZpY2UuDQo+ID4NCj4g
PiBTdWdnZXN0ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhA
cmVuZXNhcy5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxt
YW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJl
dmlldyENCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiAtIE1hbmkNCj4g
DQo+ID4gUmV2aWV3ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LmMgfCA4ICsrKysrKystDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS5oIHwgNSArKystLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IGluZGV4IGM0OTk4MTk0ZmU3NC4uNDgxMmNlMDQwZjFl
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmMNCj4gPiBAQCAtODgzLDggKzg4MywxNCBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZWRtYV9m
aW5kX2NoaXAoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgCSAqIEluZGlyZWN0IGVETUEgQ1NS
cyBhY2Nlc3MgaGFzIGJlZW4gY29tcGxldGVseSByZW1vdmVkIHNpbmNlIHY1LjQwYQ0KPiA+ICAJ
ICogdGh1cyBubyBzcGFjZSBpcyBub3cgcmVzZXJ2ZWQgZm9yIHRoZSBlRE1BIGNoYW5uZWxzIHZp
ZXdwb3J0IGFuZA0KPiA+ICAJICogZm9ybWVyIERNQSBDVFJMIHJlZ2lzdGVyIGlzIG5vIGxvbmdl
ciBmaXhlZCB0byBGRnMuDQo+ID4gKwkgKg0KPiA+ICsJICogTm90ZSB0aGF0IFJlbmVzYXMgUi1D
YXIgUzQtOCdzIFBDSWUgY29udHJvbGxlcnMgZm9yIHVua25vd24gcmVhc29uDQo+ID4gKwkgKiBo
YXZlIHplcm9zIGluIHRoZSBlRE1BIENUUkwgcmVnaXN0ZXIgZXZlbiB0aG91Z2ggdGhlIEhXLW1h
bnVhbA0KPiA+ICsJICogZXhwbGljaXRseSBzdGF0ZXMgdGhlcmUgbXVzdCBGRnMgaWYgdGhlIHVu
cm9sbGVkIG1hcHBpbmcgaXMgZW5hYmxlZC4NCj4gPiArCSAqIEZvciBzdWNoIGNhc2VzIHRoZSBs
b3ctbGV2ZWwgZHJpdmVycyBhcmUgc3VwcG9zZWQgdG8gbWFudWFsbHkNCj4gPiArCSAqIGFjdGl2
YXRlIHRoZSB1bnJvbGxlZCBtYXBwaW5nIHRvIGJ5cGFzcyB0aGUgYXV0by1kZXRlY3Rpb24gcHJv
Y2VkdXJlLg0KPiA+ICAJICovDQo+ID4gLQlpZiAoZHdfcGNpZV92ZXJfaXNfZ2UocGNpLCA1NDBB
KSkNCj4gPiArCWlmIChkd19wY2llX3Zlcl9pc19nZShwY2ksIDU0MEEpIHx8IGR3X3BjaWVfY2Fw
X2lzKHBjaSwgRURNQV9VTlJPTEwpKQ0KPiA+ICAJCXZhbCA9IDB4RkZGRkZGRkY7DQo+ID4gIAll
bHNlDQo+ID4gIAkJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX0RNQV9WSUVXUE9S
VF9CQVNFICsgUENJRV9ETUFfQ1RSTCk7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gPiBpbmRleCA5NGJjMjBmNWY2MDAuLjY4MjE0NDZkN2M2
NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuaA0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdu
d2FyZS5oDQo+ID4gQEAgLTUxLDggKzUxLDkgQEANCj4gPg0KPiA+ICAvKiBEV0MgUENJZSBjb250
cm9sbGVyIGNhcGFiaWxpdGllcyAqLw0KPiA+ICAjZGVmaW5lIERXX1BDSUVfQ0FQX1JFUV9SRVMJ
CTANCj4gPiAtI2RlZmluZSBEV19QQ0lFX0NBUF9JQVRVX1VOUk9MTAkJMQ0KPiA+IC0jZGVmaW5l
IERXX1BDSUVfQ0FQX0NETV9DSEVDSwkJMg0KPiA+ICsjZGVmaW5lIERXX1BDSUVfQ0FQX0VETUFf
VU5ST0xMCQkxDQo+ID4gKyNkZWZpbmUgRFdfUENJRV9DQVBfSUFUVV9VTlJPTEwJCTINCj4gPiAr
I2RlZmluZSBEV19QQ0lFX0NBUF9DRE1fQ0hFQ0sJCTMNCj4gPg0KPiA+ICAjZGVmaW5lIGR3X3Bj
aWVfY2FwX2lzKF9wY2ksIF9jYXApIFwNCj4gPiAgCXRlc3RfYml0KERXX1BDSUVfQ0FQXyAjIyBf
Y2FwLCAmKF9wY2kpLT5jYXBzKQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
