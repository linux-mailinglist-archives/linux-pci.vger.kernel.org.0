Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15324AE6B4
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 03:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbiBICkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 21:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243955AbiBIB4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 20:56:34 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A42C06157B;
        Tue,  8 Feb 2022 17:56:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8DVFERzAtpMjF/cRkwr7bouTRkyCVC1PbC/qQXmbHbb7z21QFLkL3XxSqkO1xkgJthqEDnPhaIKILyf/s8cWFVkCRAurXIHgLNFv0bSEg5E80m5FeFVm5CDzbhTjAVQy7P2XVIQS2HTPdBFKWVTZS8TC5+KT+X2sn+RwnaY2y+7jx39bGfj1FMamc/ZfvEntz7XD19VOocNlZAgrfjdnt0v/Lq2d0Ey8btxmMOyNQAHtC03kFskTrjFOySSXMLryzBE67rBSN7zeGNj2REsxhccm9ZRYTe3dD7O02HahpaLQg72dHTuz0S0Um6oBCjeAxvIvRfm4G0Gs8AcT/+wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LexkXZ24ie1A+WM/mDJUNTd49KyuQRem7Neb+mlQIgY=;
 b=irbZTeWd1Sjf1LWhMmKuZExvENadQnTR0RN0wspQZrzcVWTUiX4Ito/6iV2vvUxGLXO2c7QfupstWad1FGHTaLfsXCJX0IZWT8m5Y2KhgKsm+KkHteX3iPx+axOhUtal/8KdKcs6W5uEWXk5wsAPAoomjv+3Fle13opP6EZugwNgXhd1y1HdMc2r/hcE1ZcUX4NUil0k9qWVHGK30AuPjPoZrquUl3YOgsjs9yeOHF8zTKhPX1UU5E/SKdGCfLXbfZ8esOJCQSiwG2jp25zwoT+bzaZnrP1oUzrm+QF39TWe1XxQoQtoSWMd5LgnOtfMVcD8lwZzIWK+98z69T1EDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LexkXZ24ie1A+WM/mDJUNTd49KyuQRem7Neb+mlQIgY=;
 b=YApzmtuT0qEzIMpqihmnDnbkxm/zVj7TKS5HR4Oe9opnZRDXLOovVL/4zSgob4C+kqdAD9Kqo+53srXbfuMqlGUdXFRPS0WZmB8fJJxG44fHuFY8pR/4M3UscflIYtljyMoBB2/gAgmXoo5i1k/hfMbUNhS6rYtXvY1TCr3CjZc=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DU2PR04MB8743.eurprd04.prod.outlook.com (2603:10a6:10:2e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Wed, 9 Feb
 2022 01:56:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 01:56:30 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: RE: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Thread-Topic: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Thread-Index: AQHYHJ/wB6FDrGW4OkqWfAdQ8Vl2IayJbrgAgAEFCiA=
Date:   Wed, 9 Feb 2022 01:56:30 +0000
Message-ID: <AS8PR04MB86768828ED6B984C674CE2298C2E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-8-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5ALthc7zZEYZX2YHam2f3C1RmOr4CHLRjHSip7-44tL6Q@mail.gmail.com>
In-Reply-To: <CAOMZO5ALthc7zZEYZX2YHam2f3C1RmOr4CHLRjHSip7-44tL6Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9477628-ded9-42c7-330c-08d9eb6f6418
x-ms-traffictypediagnostic: DU2PR04MB8743:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8743B410454BA654228E0AC08C2E9@DU2PR04MB8743.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lTUTTX3Hf2amrnyPMJnvz3y9amClu6aIz092JXmR8Rec1WmtZBNdsjBQ9vR/JSQNofK1l0mPzj+PHEZysPAZlhqPF117itF2wQrPx2X8vfxriNcFlVIKyIn8oge0cfvlYcpgx9SwymKsI/U93MhHjvlsYBP5raPEikpUCdQjK6ip9Bwv6QEHD9toq42s8uJUzwRfbBKU6Y5RhelImQ4rDaTHPnEX/xqZwAV58dcDCWTFC8MAkg6lLXIxXmCTX7GG1MlMWaAwazTZEZHJzhgFWo+0tTAXm8lShXkQXJgKDeYu2chrcgofNE6nEOlY2Xq/eqwQukJOsoG9x3APB2wPRYH7KgsNWLubm85IPrsrsMxvT63aRAsseoNVpSQTQ7zKO6L84CjG/LvnkvDabMCOcvIrWFPZBGEGaYXmNiFF9QjgjRYVHn7TepI+5sZaXR4r1Xc6QP3Z8Feqx4ZYXP4s3SGBncKQaRdScI/4hLLUb2skWCMFnVvTQd6KOTdwPHJIc5pLgFo6xAK+bRey8CC4DVVsCSekH/QKOuNKKRGXjGa4wq0WNYl51GcvqDRp6A/ywR/7QcXlipxhVjAjBryOjUwSM0vLuuw2uHsyFpwm8FkfA6RCRF2Jls12d52t9m1UDHWYjxpp2R5PYsU0sgGIQV42rmokb+Xsp4BNkhfBe9feXS4d1xuP2dqjZj39Ue4vF4Z+a/ZLrpf6sH/zDhHalxU0fA9nn4imAwcTBM9bQtWr66qSbqhmvcHYx6hhxAPhV8ScJrUAcOlkcMY7FzLtj6otsXnxeZDd0t3sid+pcVk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(83380400001)(38070700005)(66946007)(316002)(186003)(7416002)(2906002)(54906003)(26005)(122000001)(6916009)(52536014)(66476007)(86362001)(33656002)(55016003)(45080400002)(53546011)(9686003)(44832011)(7696005)(966005)(64756008)(66556008)(6506007)(66446008)(8676002)(8936002)(4326008)(76116006)(38100700002)(5660300002)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Tld4dDY5RXVFWU81TExqNjNwN2pwcVduL3gyTzdzbkQ0Yk9vWGlzeUlxUWln?=
 =?gb2312?B?dUxlVDBhSmp6S2FXdHkrdnhxOHVtdlF5Z3pRdzRoaWxXelJwalN2OHhMdklx?=
 =?gb2312?B?dzVwcjl3SFI0dDJURzgyWWV3Wkd2TnNBbC9FQzRiZmFGUmhKVVc5Wmtmb0tB?=
 =?gb2312?B?dkNzdi9jeDczZWp0T1FycXc3eTVXMTU3UUcrV3QzRjloNy9weEx5ZmNXeGxy?=
 =?gb2312?B?aTF0MjQwSUoweTh3WTBEMzExV0twbUlZVDArd2tlNkliQUtWK0RvNzBTV0J1?=
 =?gb2312?B?QUJ3V0pkVVE3d3EvdnUwS29jM0hsbG82dVFjaUdqNHhHd0xrOEx0YWlKeThG?=
 =?gb2312?B?VFE2bHNrSFA1TGpwZFdtc3JtR09ORjhRM0daTlZESGhxNTc3bVowUzJ5dHFs?=
 =?gb2312?B?ZTdQNU5GTlJoL2xFdmNtaHdYUk9RSEtJT0xMMFdldXY0b3ZEaDdVa3EwYm5o?=
 =?gb2312?B?ZEliSjc4aFhuV2hMU2tOb0R5WXBJMWx1NDJZWUJ1bW9OclN3T21ycGVjTkVO?=
 =?gb2312?B?djlMSFJEZTZWSTlla24vQy9lOHVseHhsbHJuN21USTlzOTRrZU9qNnBacmJn?=
 =?gb2312?B?ajcxYzQ0RDlvQ1VWSUU3a0dIVXVTaklubWhDUDNsWDE4OXBwTWFsYi8rbUx2?=
 =?gb2312?B?MmUwMlZSZ1pEN01odFNQM3lnTGFhY3hCajY4SVR0TGtmU2RCUHBrZXptK0lK?=
 =?gb2312?B?UEQyeHhtUTFmLzFYRnZFd3NJNzJjbTVQWGl3ME1VZjROWFo2R29mT2Y1U2NO?=
 =?gb2312?B?aGJ5aXdUejFuT09rS3BLQXExTE51ZjJiZVhPdEorZUhicHR0NDJzbFhuWGVl?=
 =?gb2312?B?WkJSTDJzUisxV2Q4L1EzUjcwNGF1MVBxc0Y1VDhldGZiT24wOGU5UHZJNjJE?=
 =?gb2312?B?Qk55OStjWDQ1WDB0bkR2YzgwMHkwYjlFY0F0Q01pMDlQV3VibWtyZ014WFVL?=
 =?gb2312?B?b3lSenUwNEQ0ZkI4ODNGaFc4NzA4OTBVYW9yaWpTNlVVUHlmUng4TmlKV2Fh?=
 =?gb2312?B?WnFzbTg5MzVzL1Z6OUV1K2RySG03NEVtQys3UitVekd6ZkVsdHExbVp0dXdk?=
 =?gb2312?B?bmhrQXhqcGl1TUM1d0o5TTBPb3dmaG9CQitGZGNWRTlhd3N1eFN2aXJyaGJ5?=
 =?gb2312?B?TGJxbU5TbG4vQTViVVBIbGZlOWN2UGZUb3Jkc3AycmJPeWovdVBZYWJTM2t3?=
 =?gb2312?B?K0I2bXM0cWNxWlAzQStIU0N4dnZqVGVyWXl3ZTRhaHdGT0NkaDRYeTd1eG01?=
 =?gb2312?B?N3lhdFY2STdWcHh6RDlCTEczT2tpK3Y3WHk3UC94TnRTM21OUTRsRzdRUEor?=
 =?gb2312?B?U0RzaldJMW05Yk03T3R5ejRRWUxEdVVxeXpvVjBVV1FzN1hDUUZMditxcHRB?=
 =?gb2312?B?YzI3R1p0MklaZ0dFbWNmVytKRGREWjNFOUg0M1RRYitDam1mcU83M0djTWVY?=
 =?gb2312?B?RlZYMVVPd3ZTV0doY25jYy9rQkR3cHJta21HN2FXU3R3a3NvZDFNMEVuK0F1?=
 =?gb2312?B?RzlCQXc5ZnhxV2dlZU9XNlIzRnVsbWQ0emtHaFdoU2M2K0VlVmR1U0k2d3ZL?=
 =?gb2312?B?VThVRTNRdjhKdzFVSm4zOVFwUFpkd0l2TFJSNGJCNnZSQVBIWm4xU1c4NXFv?=
 =?gb2312?B?NlUzWWVRZUdiWnVLS3hUcktCZ3ZmVHN3ZVJmV0tnalBmeWc2NmNwREVBaXRy?=
 =?gb2312?B?NjhwMUF5YVFHemZHZVlpL1JjWHl1d2Q2WTVYaTFhRE4wQzU4OUlHakJ6aUZE?=
 =?gb2312?B?TSt1MCtQT3VtV3AvNTFad3lQd2pGRlFKckJqeHZIaGlXTjBuWGFJa2RZTTBV?=
 =?gb2312?B?elVMek4yVFpLYU1KNjJNR3BYekE5WnE0TG16aVZxOEJNMm9WVHhiMWlIT1ha?=
 =?gb2312?B?ZTFDeTlnS2gwQy9WUUJ0d201dkl2MC9aQUh4UXFvMWJWOHgzNFFJaEwzZEJL?=
 =?gb2312?B?d3hzUlhNeVJCd2hMUE9pZ2prN213K3U2S2oyNGMzVkZOMHRPTHkrUGlRaVFv?=
 =?gb2312?B?c3hEZFVmbTRNaGM0M2lCdkltRXozQ2xCb1JPaG8wTytjZHlWWEpCTnZjQzJy?=
 =?gb2312?B?aytTSXlaY0NDSStrN3p5Tmplc3BJbmdBa21mZjNNU3pSaHBrajZqWjM5dVNz?=
 =?gb2312?B?dGRnRURsRktkSlQzNkZRTU4xdFJlTHZkUnFJZEE2MldHZEtteU9POWxmTmwy?=
 =?gb2312?B?blE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9477628-ded9-42c7-330c-08d9eb6f6418
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 01:56:30.2215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OpBo8CpVPy7q1S+styi7A7i+i5O4CDN/mfm0/a368YCbVi3t+jD8ZDXy6MhvmD3NqWjUNYqfVFEmzY3DYe7LqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8743
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjLE6jLUwjjI1SAxODoxMA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0YWNo
QHBlbmd1dHJvbml4LmRlPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47
IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpDQo+IDxs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgSmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFpbC5j
b20+Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJN
IEFSQ0hJVEVDVFVSRQ0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsg
bGludXgta2VybmVsDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2FzY2hhIEhh
dWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNy84
XSBQQ0k6IGlteDY6IERpc2FibGUgZW5hYmxlZCBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMNCj4gYWZ0
ZXIgbGluayBpcyBkb3duDQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gT24gVHVlLCBGZWIgOCwg
MjAyMiBhdCAxMjo1NyBBTSBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IHdy
b3RlOg0KPiA+DQo+ID4gU2luY2UgaS5NWCBQQ0llIGRvZXNuJ3Qgc3VwcG9ydCB0aGUgaG90LXBs
dWcsIGFuZCB0byBzYXZlIHBvd2VyDQo+ID4gY29uc3VtcHRpb24gYXMgbXVjaCBhcyBwb3NzaWJs
ZS4gUmV0dXJuIGVycm9yIGFuZCBkaXNhYmxlIHRoZSBlbmFibGVkDQo+ID4gY2xvY2tzIGFuZCBy
ZWd1bGF0b3JzIHdoZW4gbGluayBpcyBkb3duLC4NCj4gDQo+IEl0IGlzIE9LIHRvIGRpc2FibGUg
Y2xvY2tzIGFuZCByZWd1bGF0b3JzLCBidXQgSSBkb24ndCB0aGluayB3ZSBzaG91bGQgcmV0dXJu
IGFuDQo+IGVycm9yIG9uIGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIGZhaWx1cmUuDQpIaSBGYWJp
bzoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpIb3cgZG8gd2Uga25vdyB0aGVyZSBpcyBhIGxp
bmsgZG93biwgaWYgd2UgZG9uJ3QgcmV0dXJuIGFuIGVycm9yIG9uIHRoZQ0KIGR3X3BjaWVfd2Fp
dF9mb3JfbGluaygpIGFmdGVyIGhvc3RfaW5pdCBjYWxsYmFjay4NCg0KRG8geW91IG1lYW4gdGhh
dCB3ZSBzaG91bGQgaWdub3JlIHRoZSByZXR1cm4gb2YgZHdfcGNpZV9ob3N0X2luaXQoKSBhbmQN
CmZpbmlzaCB0aGUgX3Byb2JlIHdpdGhvdXQgYW4gZXJyb3IgcmV0dXJuPw0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkDQo+IA0KPiBQbGVhc2UgY2hlY2s6DQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXQua2Vybg0K
PiBlbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtlcm5lbCUyRmdpdCUyRmxwaWVyYWxpc2kl
MkZwY2kuZ2l0JTJGY28NCj4gbW1pdCUyRiUzRmglM0RwY2klMkZpbXg2JTI2aWQlM0RmODFmMDk1
ZTg3NzE1ZTE5ODQ3MWY0NjUzOTUyZmUNCj4gNWUzZjgyNDg3NCZhbXA7ZGF0YT0wNCU3QzAxJTdD
aG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzM2MzAxODQNCj4gNTgzM2I0MWYxZjcwYTA4ZDllYWVi
MjUxOSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDDQo+IDAlN0MwJTdDNjM3
Nzk5MTE3OTI4MTYwMDg4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pDQo+IE1DNHdM
akF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0Mz
MDANCj4gMCZhbXA7c2RhdGE9VVVGJTJGYlpOVXk3VDRkODlzSktuUHZONmtOeEVCJTJGaG5TVWJJ
emU3aWxVT0ElM0QNCj4gJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBhbmQNCj4gDQo+IGh0dHBzOi8v
ZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RmdpdC5rZXJuDQo+IGVsLm9yZyUyRnB1YiUyRnNjbSUyRmxpbnV4JTJGa2VybmVsJTJGZ2l0JTJG
bHBpZXJhbGlzaSUyRnBjaS5naXQlMkZjbw0KPiBtbWl0JTJGJTNGaCUzRHBjaSUyRmlteDYlMjZp
ZCUzRDg4NmE5YzEzNDc1NSZhbXA7ZGF0YT0wNCU3QzANCj4gMSU3Q2hvbmd4aW5nLnpodSU0MG54
cC5jb20lN0MzNjMwMTg0NTgzM2I0MWYxZjcwYTA4ZDllYWViMjUxOSU3DQo+IEM2ODZlYTFkM2Jj
MmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3Nzk5MTE3OTI4MTYwMDgNCj4gOCU3
Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16
SWlMDQo+IENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCZhbXA7c2RhdGE9Rk8w
d3I0SUUlMkJBNllDdQ0KPiBmMExhbDJhejhGUmtLOFp2SGttTE0lMkY1emxvc1pZJTNEJmFtcDty
ZXNlcnZlZD0wDQo+IA0KPiBhcyB0byB3aHkgYWxsIHRoZSBkd2MgUENJIGRyaXZlcnMgc2hvdWxk
IHRyZWF0IGR3X3BjaWVfd2FpdF9mb3JfbGluaygpDQo+IHVuaWZvcm1seS4NCj4gDQo+IA0KPiAN
Cj4gDQo+IA0KPiANCj4gPg0KPiA+IEFkZCBhIG5ldyBob3N0X2V4aXQoKSBjYWxsYmFjayBmb3Ig
aS5NWCBQQ0llIGRyaXZlciB0byBkaXNhYmxlIHRoZQ0KPiA+IGVuYWJsZWQgY2xvY2tzLCByZWd1
bGF0b3JzIGFuZCBzbyBvbiBpbiB0aGUgZXJyb3IgaGFuZGxpbmcgYWZ0ZXINCj4gPiBob3N0X2lu
aXQgaXMgZmluaXNoZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMgfCAzMA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+
ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggZTE2
NWFkMDA5ODljLi43YTdkOTIwNGM2YmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtODQ4LDcgKzg0OCw5IEBAIHN0YXRpYyBpbnQgaW14Nl9w
Y2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgICAgICAgIC8qIFN0YXJ0
IExUU1NNLiAqLw0KPiA+ICAgICAgICAgaW14Nl9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+
DQo+ID4gLSAgICAgICBkd19wY2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiArICAgICAgIHJl
dCA9IGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiA+ICsgICAgICAgaWYgKHJldCkNCj4g
PiArICAgICAgICAgICAgICAgZ290byBlcnJfcmVzZXRfcGh5Ow0KPiA+DQo+ID4gICAgICAgICBp
ZiAocGNpLT5saW5rX2dlbiA9PSAyKSB7DQo+ID4gICAgICAgICAgICAgICAgIC8qIEFsbG93IEdl
bjIgbW9kZSBhZnRlciB0aGUgbGluayBpcyB1cC4gKi8gQEAgLTg4NCw3DQo+ID4gKzg4Niw5IEBA
IHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4g
PiAgICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIC8qIE1ha2Ugc3Vy
ZSBsaW5rIHRyYWluaW5nIGlzIGZpbmlzaGVkIGFzIHdlbGwhICovDQo+ID4gLSAgICAgICAgICAg
ICAgIGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiA+ICsgICAgICAgICAgICAgICByZXQg
PSBkd19wY2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJl
dCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl9yZXNldF9waHk7DQo+ID4g
ICAgICAgICB9IGVsc2Ugew0KPiA+ICAgICAgICAgICAgICAgICBkZXZfaW5mbyhkZXYsICJMaW5r
OiBHZW4yIGRpc2FibGVkXG4iKTsNCj4gPiAgICAgICAgIH0NCj4gPiBAQCAtODk3LDcgKzkwMSw2
IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkN
Cj4gPiAgICAgICAgIGRldl9kYmcoZGV2LCAiUEhZIERFQlVHX1IwPTB4JTA4eCBERUJVR19SMT0w
eCUwOHhcbiIsDQo+ID4gICAgICAgICAgICAgICAgIGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJ
RV9QT1JUX0RFQlVHMCksDQo+ID4gICAgICAgICAgICAgICAgIGR3X3BjaWVfcmVhZGxfZGJpKHBj
aSwgUENJRV9QT1JUX0RFQlVHMSkpOw0KPiA+IC0gICAgICAgaW14Nl9wY2llX3Jlc2V0X3BoeShp
bXg2X3BjaWUpOw0KPiA+ICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAg
LTkyMSw4ICs5MjQsMjkgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBw
Y2llX3BvcnQgKnBwKQ0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtz
dGF0aWMgdm9pZCBpbXg2X3BjaWVfaG9zdF9leGl0KHN0cnVjdCBwY2llX3BvcnQgKnBwKSB7DQo+
ID4gKyAgICAgICBzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX3BwKHBwKTsN
Cj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiA+ICsgICAgICAg
c3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gdG9faW14Nl9wY2llKHBjaSk7DQo+ID4gKw0K
PiA+ICsgICAgICAgaW14Nl9wY2llX3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+ICsgICAgICAg
aW14Nl9wY2llX2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7DQo+ID4gKyAgICAgICBzd2l0Y2ggKGlt
eDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ICsgICAgICAgY2FzZSBJTVg4TU06DQo+
ID4gKyAgICAgICAgICAgICAgIGlmIChwaHlfcG93ZXJfb2ZmKGlteDZfcGNpZS0+cGh5KSkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwgInVuYWJsZSB0byBwb3dlciBv
ZmYgcGh5XG4iKTsNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICBkZWZh
dWx0Og0KPiA+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgIH0NCj4gPiArICAg
ICAgIGlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ICsgICAgICAgICAgICAgICByZWd1bGF0b3Jf
ZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBkd19wY2llX2hvc3Rfb3BzIGlteDZfcGNpZV9ob3N0X29wcyA9IHsNCj4gPiAg
ICAgICAgIC5ob3N0X2luaXQgPSBpbXg2X3BjaWVfaG9zdF9pbml0LA0KPiA+ICsgICAgICAgLmhv
c3RfZXhpdCA9IGlteDZfcGNpZV9ob3N0X2V4aXQsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBkd19wY2llX29wcyBkd19wY2llX29wcyA9IHsNCj4gPiAtLQ0KPiA+IDIu
MjUuMQ0KPiA+DQo=
