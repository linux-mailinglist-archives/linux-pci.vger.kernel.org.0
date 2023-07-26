Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824D07628B7
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 04:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGZC0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 22:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGZC0w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 22:26:52 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4592688;
        Tue, 25 Jul 2023 19:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHR3vGykJvAGkohXPapLUagKUgNl4uAb6q3Nzpg2WZWtyixxT2MCPBUT2StHlB38tlMKVXppH0qvHeUj/0aVzqrWMeivK/FFjkskCkvCFusWQyUU0XSoBRqPFYbZK3OwkotTxWrSU0Kjw70HutKK0TMiBEhtECVx3b3IGjlaTfySX+8e3+ahxrYaIlgvn04HSfnXPr0rpUGgnT9NVzPgCz1GfJ86k0SM50LG2Fs13kVH01bor752SbjXhvBKIXXscdgoRRml6A/8bN8GOrQABLwu1l+p+rCPH0QDuxSLRxeepAGS1V1BYUypic5hyC9JciKmS9laQ3GeveFQG+z66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77Lpus4UwRGw0RzcplU8cuHyLylBlbBJt98jpPEVJjo=;
 b=StAVhGSEEm5rOCs4XTUNDdggfYkCcvQjTRYgMPg9CCh9eFpdpwwCPoOvSpZMlIqfKyDZ68dxtzVdxoPqDsaPc4ff2tiFYgvbxNsOKeoOrX0YCaeo6v0+4QYTdeKDNfX1BA3BpCtCu2IyBufD/PF/buJXXsid3r5g4y0f2nj4/x7pzEMnPZHnSIeKr5AxoPcNZqJ4S60/FnSekh1Wqdezba5CRK49f32AytRUMP8YmMSmmsooduBoo69nDI2DVzpuGVP3Yww/8pP0MU8bTnhZrsZ4+nmL0aoDtaKFtAS9MT9n7eJ137qYU1xV83/JEAHUGpLjHBV+imKIRu0xSq2TCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77Lpus4UwRGw0RzcplU8cuHyLylBlbBJt98jpPEVJjo=;
 b=haPrKaiCsXwoNI737RsUAN1X1HVqHn8RQ0L2xoYL/e+14qZYTUdKyL1BgeYLNc3DCKSLzNeS2IQ1yqmRqgjEPVV2SMxk+TF5vFc1lrFxxulHGVlSDv5ghWjN/G7HIhcZe9a5nScLV7p/eWGTMqJE4uOHcRitAIqgxFip5ChW82c=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYVPR01MB10718.jpnprd01.prod.outlook.com
 (2603:1096:400:2af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 02:26:45 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::e5cd:66a0:248f:1d30%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 02:26:45 +0000
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
        <linux-renesas-soc@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: RE: [PATCH v18 10/20] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting.
Thread-Topic: [PATCH v18 10/20] PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW
 setting.
Thread-Index: AQHZu6dDL83V3co9qkmrD0bHQkCC+K/IzN2AgAKMQfA=
Date:   Wed, 26 Jul 2023 02:26:45 +0000
Message-ID: <TYBPR01MB53410A07DD639D8861A328E8D800A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com>
 <20230721074452.65545-11-yoshihiro.shimoda.uh@renesas.com>
 <20230724112919.GI6291@thinkpad>
In-Reply-To: <20230724112919.GI6291@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYVPR01MB10718:EE_
x-ms-office365-filtering-correlation-id: ad64ee01-e9f8-45c3-e8ad-08db8d7fc1b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mgirn1yP9CMHRmfbL576Ug+H4EiOYgxtEwT4z/qfpZVRQb+q26UJk/NWJvmMpIVB6/FwSGvGrnNwDTj6M8QVR0b+VW/02kqIae4BJDjT21mtHJjD+KtUlSdlZoL7Qm8k5Mg2dVRNZdk6PJaGmNKBDaqPLqhxNYIx9bo5bmtR+lNpqTGO36qFK5xzWHSBYgu8bnyUxelndz2fVziw5SBDNOKped9w0JMpSU2kE1/6d5u3OXhbYgQTeOveTE7OfDlD/qP0oPeSdf9Zn5dFzeILpKSDX9WRAHwg5vEC9O1h9FxNK/VrR8a6/tbRmWZGRXnVvI7pBEPrRllOZCzAuJODv04PMIP3vosw0fzUom36xzAtc05PYX3zUg76lz8IJod+eJ+VGkLthb9ZuupL41eN95/flLPX3lP+sWRENBgdd6a4DqPNfF69mbgA9LQha6QPLX+SsjBnmLc8Oqt9wg2IrVv1fXnu/wVFNw1a80mrwTlphW0n4UL6lbI6DLMhTOYNJMoH2t5ItTaHPqcLqdpsBBqote6saAQMZt2yObxZ0x27tDOCMyBxOf3p7lZXt1hSG3Pw2hINcXvpWA+bZmbxwgUPE3Ksu1J+p1rJ1wl1GHxpW3Tc3ynJGY/s34pmoFH0FNIZouGb09ftz99yhba5nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(52536014)(38070700005)(33656002)(41300700001)(55016003)(86362001)(7696005)(71200400001)(122000001)(54906003)(83380400001)(478600001)(6506007)(186003)(9686003)(76116006)(38100700002)(64756008)(66556008)(6916009)(66946007)(66476007)(66446008)(4326008)(333604002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHRqQm1JOW5LT3lIS0EyT055NWVBRG1XcHBVTnBxNG9PM0xMc0pWTVV2dXdC?=
 =?utf-8?B?a0xPSmJ4cmdkR2RubWZ5VmRRWlZBd1dhekVxVzg0bWwvN0hsaFlaOGNtNjhP?=
 =?utf-8?B?WHlYR1U5M083QjE3eE9MOGNLS2N1MDBEUytoSVhCM2dKRUt0dXBkTWNrTXk2?=
 =?utf-8?B?bC92UDZXNEcwblpURHhVNzUxVFNUR1I4OFhPUjZFUCtiaW1SQXhEbkxQRXBv?=
 =?utf-8?B?R0s5d2ZIK1l3dVhnQTBFaDFQTlVURmtaRHpOcW1JVzVXWVZhRlMwYTVjV1hw?=
 =?utf-8?B?emZweEVESWgvcTJ4YmU0R1RHWUFvM2xRdVptOURYVC9abHh5Y21CSFpkSXhV?=
 =?utf-8?B?NkxLeVBKYzdVdzRoUDgxQkVqZWtVSVloa0NGdXhSd016YzgyekU0MlN2SjZ1?=
 =?utf-8?B?dzhYMExNS3p4QnA4dWlaWFBaT2tqdW5EdUJMa0xuWGtaZ1VsdSsvbXkyUUU4?=
 =?utf-8?B?TjI2YXFma25RQjcwbUNhU1FFSHgwYmF6NnVUZGY2SFp2OFYvUWs5Ynh3ZXNv?=
 =?utf-8?B?Sm9DbjkwSVdVNFJlallQWWorQnNPWGZ0VTd3VWN1eXB1dnVMQXVXanNWYmlP?=
 =?utf-8?B?aDZFekc0YlV2NXhXcGFIcm11VVp0MWt6ZklTdGtxdUx0L2lJTUNZd09nS0NW?=
 =?utf-8?B?U1ZzKzlwblhZVGlFMERoa085M0oybmxxcFUzdXhoUHlmNDNRdGlzRFBhY3Rm?=
 =?utf-8?B?UkZEaW51bkN4aXl2NGo5U3NSL2JieGhCTWdLeUh6VXZIaEFpdlhSVHF0Z2ho?=
 =?utf-8?B?NndVeGZ0NVZnU2EySWlNcWxNWjZtNFRFS0xiN0tuRUJDYnhPNE9JemJlSUVP?=
 =?utf-8?B?TWtDVWhzODRJcUNSNmZBbHNaRzQ3aUMzSWxEZG5SN1ZqTldpa2RhdXpzN055?=
 =?utf-8?B?MFp6SXJMYzRhUmJ6VjhHWENlWTBROGNJeDdnNWJFU3BCRjMxR1phMHBZaStP?=
 =?utf-8?B?RWtYMWE5dEtUanYrNUw4Uktib29iN1V3WXNIQUdRdVZnN1FMa2QrVUtsYklP?=
 =?utf-8?B?RnJROUs4bGtDcGIvSU5uSnh6U0k1OENOQ1g4U1M0eE9DdnFiMmVENU9ZOUls?=
 =?utf-8?B?VGV6VzluQXJ6NlBlOG9STjNMT25ZZVZrbmM5MTdhUngyeWpxQVYySk5zMnJF?=
 =?utf-8?B?MEZ1Z0YwemppYm1TelFUZVJhVGV6TVdEdXg0WlhLNndkYkJzMEtZanowNy9H?=
 =?utf-8?B?aWxGVjhKRGdtT08wZVNkT2dJWW5sdnFBcDZWRUF3SmZmcUVPZFFTUWtiOUR4?=
 =?utf-8?B?Q0VOQ09kdEhjWmpWK0xDczZjV3ZWWUI0Tkw0OTd0MitlR09DalN2Y2JYVGla?=
 =?utf-8?B?SVdzdDNLTVowaXp5NHQ3NmxFdDJhOThSVjh2SHNoWXpSN21XUGdSQVJ3TEVk?=
 =?utf-8?B?Nm1uTnRVYWllNUdLb2k0dUkxZXQ3RkRsNTFkQUZLUTljSXU5NE5hUkV2OW5S?=
 =?utf-8?B?TEVDOThUS1NjTXh0aXBpNStFZUsxY3VxbDlMbldkbVhiS2NvNm81V3pVV0Zp?=
 =?utf-8?B?RmIxYkdidk5keGdWaEkwMTdmWkpwR1kyZTVIalBLS3R3eXJtNkNPOWRNdmk5?=
 =?utf-8?B?TXZobG9GS2VJNlJicUhYTmRueWdhcmNvVFlqUjMyQk10MTJrY1pwR0F0UFJ2?=
 =?utf-8?B?V0luRE5QSGZiWExmMGtJcXRaUzMyQXRXUFVsZzlyYmRRdCs4Z1dpWG5kVzdO?=
 =?utf-8?B?NlBldms5WG4zU0dySkFlUTEvZlFvUldhb3BwTG56dTREQkJyRXo3cmZUcEJu?=
 =?utf-8?B?bE95SmdrNHJoZmo3aEVyMDlLU0ZRMnJ2R0x6V1NleHA0SU9DSXZmMzcyak5C?=
 =?utf-8?B?SEIzUGFzTi9zSWZJZzZmZVc4R3JCMGNBT2dIVHNZSDREdXpqOUxqMTd2Sm13?=
 =?utf-8?B?RWJ0V3pzSmx1ZFh0UWI3SGJrcnJnS3JUaVhhZ3JuSkhLY1AvM0psczM3N3U4?=
 =?utf-8?B?bEZ5SEVjOEp3YzJuYytjWUlpcS9YcGMxMGIrdkZ2dmZxZlg0eEJHSjMwRzY4?=
 =?utf-8?B?QUsyRHlhc0NFT2kreWZCUll2Y1BhRnBDUHc0WExrYWFrRHRCdUNPbmxIMlF6?=
 =?utf-8?B?MTVEeWFxazJPSnZyREFhN3dHQnp6SzAwSEUwblJ4SzFCTU82ekR2Nm1UM1h2?=
 =?utf-8?B?elR3aUhGZHd6V0thelArZG1iZmN4TmdOMFhHN2ZHN01BOVdLSTBtbFNlaWZs?=
 =?utf-8?B?eEVWZ0s2cjVtaHhlUWpQQ1kyRU1LamZRd3lnT0JSdUdvQy9HMnp5VktiWHJG?=
 =?utf-8?B?b2hFVmxhWEFMMFRtSEN0bkxiOFp3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad64ee01-e9f8-45c3-e8ad-08db8d7fc1b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:26:45.2452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9z79xdro6adBHFiKqQrg4Tu6OlVOv5t8P6P3hMAAOpgTprjh/jSBqqJKCMkk4rlHIeHwU20H5XRvruqJTiFqTzNtx6fx3ZvwSswNcaV+u4/C6v/+xwm6DnikK4s8UBJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IE1v
bmRheSwgSnVseSAyNCwgMjAyMyA4OjI5IFBNDQo+IA0KPiBSZW1vdmUgZnVsbCBzdG9wIGZyb20g
c3ViamVjdC4NCg0KSSB3aWxsIHJlbW92ZSAiLiIgZnJvbSB0aGUgc3ViamVjdC4NCg0KPiBPbiBG
cmksIEp1bCAyMSwgMjAyMyBhdCAwNDo0NDo0MlBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3
cm90ZToNCj4gPiBkd19wY2llX3NldHVwKCkgd2lsbCBzZXQgUENJX0VYUF9MTktTVEFfTkxXIHRv
IFBDSV9FWFBfTE5LQ0FQIHJlZ2lzdGVyDQo+ID4gc28gdGhhdCBkcm9wIHN1Y2ggc2V0dGluZyBm
cm9tIHRlZ3JhX3BjaWVfZHdfaG9zdF9pbml0KCkuDQo+ID4NCj4gDQo+IEhvdyBhYm91dCwNCj4g
DQo+IGR3X3BjaWVfc2V0dXAoKSBpcyBhbHJlYWR5IHNldHRpbmcgUENJX0VYUF9MTktDQVBfTUxX
IHRvIHBjaWUtPm51bV9sYW5lcyBpbiB0aGUNCj4gUENJX0VYUF9MTktDQVAgcmVnaXN0ZXIgZm9y
IHByb2dyYW1taW5nIG1heGltdW0gbGluayB3aWR0aC4gSGVuY2UsIHJlbW92ZSB0aGUNCj4gcmVk
dW5kYW50IHNldHRpbmcgaGVyZS4NCg0KVGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4gSSds
bCBmaXggdGhlIGRlc2NyaXB0aW9uLg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNo
aW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gV2l0aCB0aGF0
LA0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5z
YWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXZpZXchDQoNCkJl
c3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+IENjOiBU
aGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiA+IENjOiBKb25hdGhh
biBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTZXJnZSBT
ZW1pbiA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyB8IDYgLS0tLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtdGVncmExOTQuYw0KPiA+IGluZGV4IDg1Y2M2NDMyNGVmZC4uM2JiYTE3NGIxNzAx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmEx
OTQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtdGVncmExOTQu
Yw0KPiA+IEBAIC05MjIsMTIgKzkyMiw2IEBAIHN0YXRpYyBpbnQgdGVncmFfcGNpZV9kd19ob3N0
X2luaXQoc3RydWN0IGR3X3BjaWVfcnAgKnBwKQ0KPiA+ICAJCUFNQkFfRVJST1JfUkVTUE9OU0Vf
Q1JTX1NISUZUKTsNCj4gPiAgCWR3X3BjaWVfd3JpdGVsX2RiaShwY2ksIFBPUlRfTE9HSUNfQU1C
QV9FUlJPUl9SRVNQT05TRV9ERUZBVUxULCB2YWwpOw0KPiA+DQo+ID4gLQkvKiBDb25maWd1cmUg
TWF4IGxhbmUgd2lkdGggZnJvbSBEVCAqLw0KPiA+IC0JdmFsID0gZHdfcGNpZV9yZWFkbF9kYmko
cGNpLCBwY2llLT5wY2llX2NhcF9iYXNlICsgUENJX0VYUF9MTktDQVApOw0KPiA+IC0JdmFsICY9
IH5QQ0lfRVhQX0xOS0NBUF9NTFc7DQo+ID4gLQl2YWwgfD0gKHBjaWUtPm51bV9sYW5lcyA8PCBQ
Q0lfRVhQX0xOS1NUQV9OTFdfU0hJRlQpOw0KPiA+IC0JZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwg
cGNpZS0+cGNpZV9jYXBfYmFzZSArIFBDSV9FWFBfTE5LQ0FQLCB2YWwpOw0KPiA+IC0NCj4gPiAg
CS8qIENsZWFyIFNsb3QgQ2xvY2sgQ29uZmlndXJhdGlvbiBiaXQgaWYgU1JOUyBjb25maWd1cmF0
aW9uICovDQo+ID4gIAlpZiAocGNpZS0+ZW5hYmxlX3NybnMpIHsNCj4gPiAgCQl2YWxfMTYgPSBk
d19wY2llX3JlYWR3X2RiaShwY2ksIHBjaWUtPnBjaWVfY2FwX2Jhc2UgKw0KPiA+IC0tDQo+ID4g
Mi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprg
rqTgrr7grprgrr/grrXgrq7gr40NCg==
