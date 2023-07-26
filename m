Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC507628A1
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 04:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjGZCMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 22:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZCMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 22:12:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2102.outbound.protection.outlook.com [40.107.114.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164722116;
        Tue, 25 Jul 2023 19:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX4QGstjPhYvOAYmnsxwKmqO4H9d1aMFQRz3c17htaLB58gqfjuWvO0hgQTbPAdvyNDYlLrhC4oEykaHjNXAk4Wcbul38UmfKZtyTSpqI/RCnmNlgcGuALTHkE0zLrgNgLv8Hlw6e2Jlksuc6N2U2j2WA+Pvjwn3qUqcbiONK8jxAmi5U9k3sGEvHXNg2lsJHERJlwJU5Lo3zgmDLRVLXqX7GLG+Qf47Jot8AkodqDqH0gksaMNajo4mx4B27sZXb8Ym39jKk91i8urBh0oXdEaGuIne9A9gX8TU5KPyOiMDtPqeUqwdRCjxx1Xu4s8yXeYB7BfwXAuBTNAVTbdIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JLXLSSrrQvbEzZFBwGDQIGwiaeOcnk3dpStVnsSI5E=;
 b=jVhU8h7W+ldj3waEaYyba+wFnIfGewCIpv31vvjtQbS83fkpvTFso6Rs3UyPcF5nxjmqKC7pUvyBbRtwIL5sZ9lJOkVNaDriZxX6hB1/7XkalCQmG+OzISPdHkj+KPfNpMi+LpTMsr5wILK/svdqh/3BcxW1BqJDMRxvRS1jIJn4qktXnxWWgIB6Sv1rQnpnPcXO8ctVmBTnUcJvDCnEKjFWF0TLoAiydTeJn6ixIOjU9Kq3jtecYrdy6enf5+ktKwDmbvGuDDU+feh3iG4ylZxLOGPMsaAXCp6O8AjCTJZ2j8PFvwtn0akNa4r2LOzpI5g+ZuHceHbm/c4QpcpzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JLXLSSrrQvbEzZFBwGDQIGwiaeOcnk3dpStVnsSI5E=;
 b=SHp3IW/2NHjADo4BvMLSpER3I3XVqRab2U5hVQOycvre5BvuSo7D4ATVd2qRdvGkDVQJZ9kPGUcz6Sw3dR8iIZs9v7u8kMZmfJDmDX7RD7cpbaUmUGl1/VqN0kXzxg4PvGqS1bJuPSsmLUpX97cHKozyQuy/mLenssEC7LokEX0=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TY3PR01MB11281.jpnprd01.prod.outlook.com
 (2603:1096:400:3d6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 02:12:15 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 02:12:15 +0000
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
Subject: RE: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Topic: [PATCH v18 09/20] PCI: dwc: Add PCI_EXP_LNKCAP_MLW handling
Thread-Index: AQHZu6dDGGGQ+OAg50C3BavsZe1ATa/IxbcAgAKD7jA=
Date:   Wed, 26 Jul 2023 02:12:15 +0000
Message-ID: <TYBPR01MB534165847452C8A2398B03D9D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-10-yoshihiro.shimoda.uh@renesas.com>
 <20230724110344.GH6291@thinkpad>
In-Reply-To: <20230724110344.GH6291@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TY3PR01MB11281:EE_
x-ms-office365-filtering-correlation-id: 5af7c459-f9a2-4b7e-93e6-08db8d7dbb4f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XQGtYuQ4KW87LkTLcq0HraXM5aWzk277/P53hM/+YVNFgSgBUFBROkyI5nIuLaQwCzqkBSqo0d52KBjGKTVfKNK4XyBx9k/5vDs2gLWFLY0T3oPaoQeYJgNxf8gA6w+8++aPUPhS7yxNan9ZLXR84VrbWddxqHXUAQsZGbcDPzuak4C5zf7I3tX1eMmflPQ19JrzDmgWk27XIus60Oi09viPe4J82MxW9XH/ZZyfKEUzpPmJWFL823TCclRps9mSV2fzFyboSiu74I4Li+vPmhHeKxrHnGbDeLJf9Zg05haq3LWCPmhk0Vsh2xdyVmoHcmUMpEarsC3h/u5E+BgVng7Zw9GdEZ5xSegZZ7m4VB4jxiAFSK0+4kuQviGFVcMMLrQVGM7LynOEP6ELxIRfHL5l59fX6TGn2IpN/ggHakI4w0/vb71p95MnvZLmO1zvjdiZtmCiV50rUDAKk82xxDhpIqdZ6yyvgGxJbNnFTQC4ZN9vVRwAF/vRIn/UUe1kfZtzmArUpdasVkmy6ligadUPHqEXBrtJCdaph5/Tb6ymQ5b2JeZg13uP0Q98hwD0/bMAJ8wFvI7yUZkTD9X/IelKBylZa/HuwUrunmII9NI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(966005)(54906003)(7696005)(9686003)(478600001)(83380400001)(55016003)(86362001)(38070700005)(33656002)(66556008)(66446008)(64756008)(2906002)(66476007)(186003)(6506007)(71200400001)(122000001)(38100700002)(52536014)(6916009)(4326008)(316002)(76116006)(41300700001)(66946007)(7416002)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlU3eWx1M1NCc3ZJWHREUkFQM1FBTWE2M3pyS0ROaG5weEZDTjJBbTVHTEJR?=
 =?utf-8?B?ZTZTS281b2hXZEE1RDlBVU9wcng1YW52ZGprL0o1cWcyR1dNRW9TY0JaT1lr?=
 =?utf-8?B?UklySTFhd1l1eUlKay80OXFvWmhCSEtzWDlIUG1RMnltbHFINXNlaGQ2Mi9M?=
 =?utf-8?B?SnhXZTVnbEdZci9wM0dWRmNqUDExNnp4NElFQ2xFY0dhQm1OZkY4WWRuYnVY?=
 =?utf-8?B?SmhpQ2VZNHhCeTVYandSQ3N3eFdmUnlmR3RmZ213SlJoN3dBZjZkdVQ0bHZE?=
 =?utf-8?B?VGlLQkZyb1ZUYVV0R0ZsQk05UXpqcmNKc2VScDNhZ2IvdWl2R0MvTGl5SkhE?=
 =?utf-8?B?WVhkL0xyakpSZHFEKzAzcXNPajZvNndlMDNleHB2V2JPeUhwNW5rTkZETE15?=
 =?utf-8?B?RGZWTXJEMGVyT1I3dlFPejNlKzA1NGFrZ1A2bXc0bzdwTzFEbnd4R3FwYXY5?=
 =?utf-8?B?MGVPa09KblcyUXUvRDBhTGorSEMvMnNNYzlkZU4ycmk3RkZQUDVHOXNIV2g2?=
 =?utf-8?B?cVd3Qk5Nb01vM0x6eTR6VWE2TnpRSFF3Rk8rSFExVXNDeU9IN2VEZ1FpcGt5?=
 =?utf-8?B?bjVHMlUzRCtMQkQyZkFKclczZ0FxVm5aQ2RnTHI4cE92eXNBWitMRnAyTm12?=
 =?utf-8?B?dGpIRnpjRHNYcXlkWTBIanBqdkwyRHAzQkFhMStHNnhYUkxtK0VYSktHLzkx?=
 =?utf-8?B?eG1TdC9nV2Z2N3NRQnc4b1FhM3p0WDhOL2RqVWFGeUUzVU5STFNYSE0yS2h4?=
 =?utf-8?B?ZmVKL2hleVB5WHZnOFc2anJHV1Jub3p1Wkcvbk5XV3FFZmdzcTRka3VhU016?=
 =?utf-8?B?aXFqeXNVc05lcHRGY1gwRkRsYVFiWGc2N2xzMVdzN0liRUhjYWhHbW5DSE12?=
 =?utf-8?B?WkFVZHo1bW9IU2pCT1BPN1dsZ1ZTNUZxaFVDWFJ1dWdiZUVtR2huMDhqaXo4?=
 =?utf-8?B?a0xtdUltRkxDTE5WNUNIQWduQVdXZDVkUmpiV3A2aGVLVW1wVVJwMXpoZUh2?=
 =?utf-8?B?OW83ZGxFTHhyWVZEU1pNaE84V0NKNWFNMjRJZU5wQVZLaVgwYVFXMElzMGZN?=
 =?utf-8?B?QXlwZlREZlQ1K1Z3RWs5MVNnNTkzZmpBR24yUFRkREtSM3VGdTZhN0E1TzNo?=
 =?utf-8?B?WjI3SlBiejZleWJ6R0JXV0luYkl3dE5hM1ZjODVkNTZPZUN6eVY3elNGbjlT?=
 =?utf-8?B?bkYxUEp1ZVR0SXFzME8wQ25YTWN2TGszbzdVUnhOTUhNWlFwcjVtcTl3Rmg2?=
 =?utf-8?B?anNVL0JpSTN6TDJPKytuNVFPaitpY0s0c0FtQXUvcm1qTVErdkgwNUZsV2lT?=
 =?utf-8?B?aEFnNzhVWnhHUVZ6Nk5DaVprSUpocmoyQlc2M0pQb09uODJEaEQ5RW9EUUdU?=
 =?utf-8?B?ZzJxaG1tbWRqNms5QUZFWjBCZ2ZXaXdTSmVhRTQ5eFd1dStKSUQ1aFkrN2JO?=
 =?utf-8?B?QWZzOWg1VzBWRElaeTY2VTJ6dkNKd0VBL09TMFpINHVBeHZua3NSajlORUph?=
 =?utf-8?B?UUE3NlJabUhyTlNqTWhXeGhwQTl0R29oMlRxZ21nbmVOR0NkSFIvZUs1cXlR?=
 =?utf-8?B?TWVFWmpLeXh2YU40d0poT1VkcHczWjhtWmJNOXRoUC9RcXRBKy9zbFpEdzVP?=
 =?utf-8?B?dHY2MjliRmlUa24xVHBCODVrYWdMV2tiK2FPMmxOdU5EU1FOR1duY1dVYVlE?=
 =?utf-8?B?V0YrNmlZZHZ3VEZXSkRYTWYrbVdqRWlzbkhwN0dsOThsdTFKUVd2YlNETC9r?=
 =?utf-8?B?ZDdBd1AvcUdVV1hmMDVkRHhrZEtOWUFLTkhzd3FiRzh2OTRFOEVZRFRHNllu?=
 =?utf-8?B?TktCc2liV05ObVVUMmRPa0xDVlJoVmd0SUpOQWt5ZnFUMmZpR2FtTjdRVHN5?=
 =?utf-8?B?U2pxMExJb2FRU1NxYys4ZzA3b1NmYkNGR1ZmZ3NVbGprUVQxeFFtdlhuL2xQ?=
 =?utf-8?B?NlFxVWNhTkFNZFVyY3g5WmdRM241QUJFZTFxbHRyMGJHbVZVTEJHMHNtUkVa?=
 =?utf-8?B?U3ZwOFZJUDlNcFdFeThZUXdMNzRkcEd4UnBjK0Zla0dvejFlVXNrMHJVbklh?=
 =?utf-8?B?Zm5HRUl4VHVkUyt4VVZnem41MURFSmc4K1FjRmcxL284aVVoMVBtblVLQVR6?=
 =?utf-8?B?SmdUK3pNenFjZkgzallHRlMxU2ZURWhoMUxlN3loNUNxZ2NOSlpQNTFiUVda?=
 =?utf-8?B?ak5nbjZPaTExK0FwK2VFZVdmL0R2ejVOZ2VrRkpBTXBNS1Y1NWtHSDh1Y0to?=
 =?utf-8?B?REQyWXdMcmRtaXBBS0RlOXMzM0VBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af7c459-f9a2-4b7e-93e6-08db8d7dbb4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:12:15.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8n1OtN+Jzj0r2vHjOLCCaoe3hvqRbOoJCH9VSSmqNrOPBggZ0VMzrMujrAnSfzEHX3B4RmZe8u/cyhLR9PdziPF/xXbv0nKC1s51NUmPLYUBSW3aumJU+A2140H5tWws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11281
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
bmRheSwgSnVseSAyNCwgMjAyMyA4OjA0IFBNDQo+IA0KPiBTdWJqZWN0IHNob3VsZCBjb250YWlu
IHRoZSB3b3JkICJtaXNzaW5nIi4gTGlrZSwgIkFkZCBtaXNzaW5nIFBDSV9FWFBfTE5LQ0FQX01M
Vw0KPiBoYW5kbGluZyIuDQoNCkkgZ290IGl0Lg0KDQo+IE9uIEZyaSwgSnVsIDIxLCAyMDIzIGF0
IDA0OjQ0OjQxUE0gKzA5MDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IFVwZGF0ZSBk
d19wY2llX2xpbmtfc2V0X21heF9saW5rX3dpZHRoKCkgdG8gc2V0IFBDSV9FWFBfTE5LQ0FQX01M
Vy4NCj4gPiBJbiBhY2NvcmRhbmNlIHdpdGggdGhlIERXIFBDSWUgUkMvRVAgSFcgbWFudWFscyBb
MSwyLDMsLi4uXSBhc2lkZSB3aXRoDQo+ID4gdGhlIFBPUlRfTElOS19DVFJMX09GRi5MSU5LX0NB
UEFCTEUgYW5kIEdFTjJfQ1RSTF9PRkYuTlVNX09GX0xBTkVTWzg6MF0NCj4gPiBmaWVsZCB0aGVy
ZSBpcyBhbm90aGVyIG9uZSB3aGljaCBuZWVkcyB0byBiZSB1cGRhdGVkLiBJdCdzDQo+ID4gTElO
S19DQVBBQklMSVRJRVNfUkVHLlBDSUVfQ0FQX01BWF9MSU5LX1dJRFRILiBJZiBpdCBpc24ndCBk
b25lIGF0DQo+ID4gdGhlIHZlcnkgbGVhc3QgdGhlIG1heGltdW0gbGluay13aWR0aCBjYXBhYmls
aXR5IENTUiB3b24ndCBleHBvc2UNCj4gPiB0aGUgYWN0dWFsIG1heGltdW0gY2FwYWJpbGl0eS4N
Cj4gPg0KPiA+IFsxXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0
YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgIFZlcnNpb24gNC42MGEsIE1hcmNo
IDIwMTUsIHAuMTAzMg0KPiA+IFsyXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRy
b2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgIFZlcnNpb24gNC43
MGEsIE1hcmNoIDIwMTYsIHAuMTA2NQ0KPiA+IFszXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHBy
ZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgIFZl
cnNpb24gNC45MGEsIE1hcmNoIDIwMTYsIHAuMTA1Nw0KPiA+IC4uLg0KPiA+IFtYXSBEZXNpZ25X
YXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBEV0MgUENJZSBFbmRw
b2ludCwNCj4gPiAgICAgICBWZXJzaW9uIDUuNDBhLCBNYXJjaCAyMDE5LCBwLjEzOTYNCj4gPiBb
WCsxXSBEZXNpZ25XYXJlIENvcmVzIFBDSSBFeHByZXNzIENvbnRyb2xsZXIgRGF0YWJvb2sgLSBE
V0MgUENJZSBSb290IFBvcnQsDQo+ID4gICAgICAgVmVyc2lvbiA1LjQwYSwgTWFyY2ggMjAxOSwg
cC4xMjY2DQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2Vy
QGdtYWlsLmNvbT4NCj4gDQo+IEFkZCBSZXBvcnRlZC1ieSBhbHNvPw0KDQpJIGRvbid0IHRoaW5r
IHNvIGJlY2F1c2UgU2VyZ2Ugc3VnZ2VzdGVkIHRoZSBjb21taXQgZGVzY3JpcHRpb24gZnJvbSBt
eSBzdWJtaXR0ZWQgcGF0Y2ggWzFdLg0KDQpbMV0NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXBjaS8yMDIzMDMyMjA2NTcwMS5wbzdvd3l6d2lzbnRhbHl6QG1vYmlsZXN0YXRpb24vDQoN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEu
dWhAcmVuZXNhcy5jb20+DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYSBwb3RlbnRpYWwgYnVnIGZp
eCB0byBtZS4gU28gcGxlYXNlIG1vdmUgdGhpcyBjaGFuZ2UgYmVmb3JlIHRoZQ0KPiBwcmV2aW91
cyBwYXRjaCB0aGF0IGludHJvZHVjZXMgZHdfcGNpZV9saW5rX3NldF9tYXhfbGlua193aWR0aCgp
LCB0YWcgZml4ZXMgYW5kDQo+IENDIHN0YWJsZSBsaXN0IGZvciBiYWNrcG9ydGluZy4NCg0KSSB0
aGluayB0aGF0IHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGEgbmV4dCBicmFuY2ggYmVjYXVzZSB0aGlz
IGlzIHBvc3NpYmxlIHRvDQpjYXVzZSBzaWRlIGVmZmVjdGl2ZS4gQWxtb3N0IGFsbCBkcml2ZXJz
L3BjaWUvY29udHJvbGxlci9kd2MvIGhvc3QgZHJpdmVycyBleGNlcHQNCnBjaWUtdGVncmExOTQu
YyBkb2Vzbid0IGhhdmUgdGhpcyBzZXR0aW5nLCBidXQgSSBhc3N1bWUgdGhhdCB0aGUgZHJpdmVy
cyB3b3JrIGNvcnJlY3RseQ0Kd2l0aG91dCB0aGlzIHNldHRpbmcuDQoNCkFsc28sIHRvIGJlIGhv
bmVzdCwgSSBjb3VsZCBub3QgZmluZCBhIHN1aXRhYmxlIGNvbW1pdCBJRCBmb3IgdGhpcyBwYXRj
aCdzICJGaXhlcyIgdGFnLg0KQWRkaXRpb25hbGx5LCBJIGNvdWxkIG5vdCBkZXRlcm1pbmUgd2hp
Y2ggb2xkIGtlcm5lbCB2ZXJzaW9ucyBzaG91bGQgaGF2ZSB0aGlzIHBhdGNoDQphcHBsaWVkIGFz
IGJhY2twb3J0aW5nLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0g
TWFuaQ0KPiANCj4gPiBSZXZpZXdlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21h
aWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUuYyB8IDkgKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gaW5kZXggNWNjYTM0MTQwZDJhLi5jNDk5ODE5NGZl
NzQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuYw0KPiA+IEBAIC03MzAsNyArNzMwLDggQEAgc3RhdGljIHZvaWQgZHdfcGNpZV9saW5r
X3NldF9tYXhfc3BlZWQoc3RydWN0IGR3X3BjaWUgKnBjaSwgdTMyIGxpbmtfZ2VuKQ0KPiA+DQo+
ID4gIHN0YXRpYyB2b2lkIGR3X3BjaWVfbGlua19zZXRfbWF4X2xpbmtfd2lkdGgoc3RydWN0IGR3
X3BjaWUgKnBjaSwgdTMyIG51bV9sYW5lcykNCj4gPiAgew0KPiA+IC0JdTMyIGx3c2MsIHBsYzsN
Cj4gPiArCXUzMiBsbmtjYXAsIGx3c2MsIHBsYzsNCj4gPiArCXU4IGNhcDsNCj4gPg0KPiA+ICAJ
aWYgKCFudW1fbGFuZXMpDQo+ID4gIAkJcmV0dXJuOw0KPiA+IEBAIC03NjYsNiArNzY3LDEyIEBA
IHN0YXRpYyB2b2lkIGR3X3BjaWVfbGlua19zZXRfbWF4X2xpbmtfd2lkdGgoc3RydWN0IGR3X3Bj
aWUgKnBjaSwgdTMyIG51bV9sYW5lcykNCj4gPiAgCX0NCj4gPiAgCWR3X3BjaWVfd3JpdGVsX2Ri
aShwY2ksIFBDSUVfUE9SVF9MSU5LX0NPTlRST0wsIHBsYyk7DQo+ID4gIAlkd19wY2llX3dyaXRl
bF9kYmkocGNpLCBQQ0lFX0xJTktfV0lEVEhfU1BFRURfQ09OVFJPTCwgbHdzYyk7DQo+ID4gKw0K
PiA+ICsJY2FwID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX0VYUCk7
DQo+ID4gKwlsbmtjYXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIGNhcCArIFBDSV9FWFBfTE5L
Q0FQKTsNCj4gPiArCWxua2NhcCAmPSB+UENJX0VYUF9MTktDQVBfTUxXOw0KPiA+ICsJbG5rY2Fw
IHw9IEZJRUxEX1BSRVAoUENJX0VYUF9MTktDQVBfTUxXLCBudW1fbGFuZXMpOw0KPiA+ICsJZHdf
cGNpZV93cml0ZWxfZGJpKHBjaSwgY2FwICsgUENJX0VYUF9MTktDQVAsIGxua2NhcCk7DQo+ID4g
IH0NCj4gPg0KPiA+ICB2b2lkIGR3X3BjaWVfaWF0dV9kZXRlY3Qoc3RydWN0IGR3X3BjaWUgKnBj
aSkNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPg
r43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=
