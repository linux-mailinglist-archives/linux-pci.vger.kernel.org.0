Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B156506C2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Dec 2022 04:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiLSDZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Dec 2022 22:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLSDZi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Dec 2022 22:25:38 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7115295A6;
        Sun, 18 Dec 2022 19:25:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEcuAcjaMUHYa6WfLx8VStQ9tGRAO9po/97WAdgq+ur4tXSZH8MM/QowO7ezbgI28/2R9/pPYvlKvnyZw8QlyaN2Gdc6mYHp989UG74l39wyodme07Gq2E9zNt5AdGzpmi9s9Y6hRB8pvcfVw2+JWM4rSwoJloRhcS1RiwBnkMQ3JKhOz+piOaG75EHr/xSgB5K4UOkMDgvXqK4KDQjfHJR1N4w9cq2qFclAtbM/ZHe+1MUQUDodJwSS4XFqBc6DVTVcVxoTHjnHGV5VKtSxFa89OYwUTLuC11wybRkuCMd+j420tGR9c8KIVH5ogQOUQknZNImqXxrrjFGg3cbo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjNCnFqdWkmxI1ZZrNOPOlTLM523Y00x3euZK9Ay3CA=;
 b=W/6ykmttvSyGT4C1TVutkydYRcK90KOaOLOJv/ma3HxNqxijxENeet0dq90F8goQvBsrGlHF3vfeBWV0hmwSYi3UCKT+zuAjjEK9pRg6xp331WMUaGbG+8pWU5j65ASQYSDZR0u0cvfzXjpljn/YD+v/oh8qe/6TkcG1E72fCEtlOySQFTq8LAnQmOjheH7vNan8JwFfT/79F79rm29MTSbFGVVKCCyAd7NZHPc8rlLgANf2SVqwOoSZCimouwWqqad72nkHYfY1F9brmKprfkJYIj5QsBzyIaV20xPXinxF2enlx8eQ8P5ZEPxoMyN8Y9xJhao4ozCYH69Ci0/hXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjNCnFqdWkmxI1ZZrNOPOlTLM523Y00x3euZK9Ay3CA=;
 b=R7lkwHXZCA1Yf6KoJG/Z0UoSxmy+JD+kOzoyWS0QBcrImXzOyNaUoXUBEeaAXNZgFISLOOJANb0R8QCE51WpyaHpk0svrZj+GGqfHSOztO5IQrcsBOMkl7efKzF0v4E6owd4dpig/gApmDCSkds89aDeaoPoGZoxma6vLCkPEyQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 03:25:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::49b8:a7b4:676b:2f8d]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::49b8:a7b4:676b:2f8d%3]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 03:25:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Marek Vasut <marex@denx.de>, "vkoul@kernel.org" <vkoul@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RESEND v12 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe PHY
 support
Thread-Topic: [RESEND v12 4/4] phy: freescale: imx8m-pcie: Add i.MX8MP PCIe
 PHY support
Thread-Index: AQHY3qh5YEg7IUZheEu5FwT15m9Ff65y4zSAgAH91uA=
Date:   Mon, 19 Dec 2022 03:25:33 +0000
Message-ID: <AS8PR04MB86767EFD1DE8CC1FBA574D708CE59@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1665625622-20551-1-git-send-email-hongxing.zhu@nxp.com>
 <1665625622-20551-5-git-send-email-hongxing.zhu@nxp.com>
 <c21996f3-0f1d-8b77-95fb-ab98f3a28913@denx.de>
In-Reply-To: <c21996f3-0f1d-8b77-95fb-ab98f3a28913@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: vkoul@kernel.org
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8610:EE_
x-ms-office365-filtering-correlation-id: a09bc5df-edb2-4130-898a-08dae170b050
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JPh3BRX5DuPGhW+vcGykLDGUeuwJD1wd+rNWUbsc0YVKdSGNV28zAmzwF3IcKm9oDflcIiy59zIMEifBJ4I4wjoQ+nfHntDa+dxNtsb+HGpopA6t6KuH4qL5HhXoiAGxclyPomOU2gRmY1ftPl1pcDyoOiUDmvg3aL3eKpHfIE63w9j8jPNhJGZvLsVpDe1rm7Vf/BKlQqLuAhFHHIsjCdF9Jbc152Q01E6hajPlN99G1Ti3XBJK20Muwnh4eT76+j2gv7QyxWA28MjQkcUw0QMbxYu0kQyCRGzN2khmwRPMVqjmuJNp/8ny/L+NCakyHgH10wKuu5yrjrNwULGtLsC+Vj3C9ITj1nzIhBOzJgO42ZKAKV8E4wtP6dsjGw2pK0cwmq/zXdYywql/fH6jTwrZlhiiPmVpnle+kyUiy0p9Uk2K54HcW/xe/qbcSgAikGL5bnwmm605PEXM/Tzmdb1SJRLyzKp8eD/wXiDBi3nXBiAumjlhEOtXddsM01oA+3ZrFI+3q5f+YtOeWSvEvVUxexYxKwKIfmG2fvFD9yVWc09rJX6yoNFC9dvaGDfA6koDU18TGqalOFd8EoU2tbhLaclMV074rW4M9k6KCDhHD1/yHLA+LbLSLF2KFQr9gzaZ/FWyxCurd2Mw0E5xtB4gRUwPHVFnf3l7ZqsJv1lU0YGXaDvrFlcLyDb3J+fFdb60ECps6uxVUMtm75BBvqKFqqm4zkiHWoyU0apA3aQMtD3PzNWZ1u/syli5/ej
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(83380400001)(38070700005)(55016003)(86362001)(921005)(71200400001)(122000001)(33656002)(38100700002)(478600001)(7696005)(6506007)(53546011)(26005)(186003)(9686003)(66556008)(66946007)(76116006)(8676002)(66476007)(4326008)(5660300002)(64756008)(66446008)(7416002)(52536014)(8936002)(316002)(41300700001)(54906003)(110136005)(2906002)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnZRVFdDdHNwS01ZNCs0RmZnRVltTzcrK0xiaGk4RnI4blZQRzEweWh4NXVu?=
 =?utf-8?B?R3RiMkdEMVRLYWVhNE1ydW5laS9JcTNJTFQrWDlUcksveVptZkNTQUhqU3RR?=
 =?utf-8?B?M0IybUs1QVhvVEd0TlhlcFBLRHkxbVRmZXk5cHFTdFpEQVRXVXFkTDRSMDB5?=
 =?utf-8?B?cXBSazdzNCtVTFVpbGJoc29UeTJzMFl2cE1aZFhxcnB0bno4bFVwdHFmcTVZ?=
 =?utf-8?B?dEFKRGlWWGRBR3JST3hhVW8vZUdEazJuc2ZLaVZ4czQrcFRYNm5Ga3Y4bkxM?=
 =?utf-8?B?TXd0NTg0K3BGMzFtNUF2clFNY0NCWTg3Z2oycHhQN280QjFoMUFCNCtITDZx?=
 =?utf-8?B?S3lsV1ZMVklQVUdES0pSOEpxb0R4K2lTOEw5c3RlY2R5eStqZ2RCRytGVW9x?=
 =?utf-8?B?NTRZU3JRc3B4QWVNeVF4aW9PbjRDbVpOSWFVUlFyK0R2NnQ5czFWNStNNUdW?=
 =?utf-8?B?UlNyRFdPZmRJb1hNU3RnNC9YOGdsOVJYak1LSDR0d2lzUDRoZlNJM1V6eUVm?=
 =?utf-8?B?T0xWL2p1Rmtib0hETDc5RUpweUhvVldMVFNRUm5HYndjVVRwSUxJeTMrM0Ex?=
 =?utf-8?B?WEJRZjlURXBVOEhPWldYem5oSmR6VFlFN1YwNUtqS0tFU0EzaUZvRjNYQXND?=
 =?utf-8?B?NUREYVpEWVNXZ0NIcTJsNGRzdGIrbUQzUm1pRFhKZ3JKREh0anYvQVVFdTMy?=
 =?utf-8?B?aGNkVUhtSm1SWVJ5SDRlWVdLQ296TjNCamVnYWFaYWkybWpDaXMzQXJQZFB2?=
 =?utf-8?B?bk9xOVAzZC9WVUVpdzF2N3JjOUxiYjRNNmFPczNiNk1BYmhNZVd6c2NOWW9k?=
 =?utf-8?B?YkIvZHNnUTlTSFJSUjBDVTN6ZjVRa2tubm85emp1WlgvRlI0NXlMZWVvTm52?=
 =?utf-8?B?RjhhVkJQRm1EK2IrVUJDZjN4RGZTUGxYa3dBVjM0aDFYZkFla21CRDBtYTAw?=
 =?utf-8?B?anN6WXZyenk4TlpHOWpLVXd5ODc0OU1zM1RIczRYNzB5bDNRQ1N0cHdBd2oz?=
 =?utf-8?B?MDI1V0tIellBNDRvS00yNHlGajM4eURCTHdzejlkUzUxVWc2c1MzVXArZnpa?=
 =?utf-8?B?NW1UanNCekJrYjVlL3JUeU9vcElLbWFMQzZ1NnBGSS9OaVB6SFZidUZHRjJP?=
 =?utf-8?B?amNKNWVrZm1LU1ZkcnJta3pkUkZON045UERQV1ZjS05Mb2xlbEFwQ1FQalcr?=
 =?utf-8?B?S0JqcVVVVEZzNHZrVTFacHBTNTVmZjR0SFZvRm1KaGJTbFVpdytjR09YRkNQ?=
 =?utf-8?B?b1BmdDhUK0QwRHE3MDUrUFVuR2hoVUxuQk05MFdlajc2ckxtM2c3UDY2akhn?=
 =?utf-8?B?eWpGOUVGUGZVY29DaHFCbGNrdXphSnJmaGVXdXd0dTc4QU8xbEMzZnVGMzZE?=
 =?utf-8?B?aTdUVmVXb2xjclhUQis5MG5vTVFrRWowZm5aQUJsU2RtWlE3YVlSQk91VnF4?=
 =?utf-8?B?YmVCcUFmcUpxSENDWHgrTU1xazFma1lGdkZVV0JJeC9IR05zL2VCaVNheWxm?=
 =?utf-8?B?aXNrL0hSek1uNGNWWXRxR004R1pqYU84dmZ3TFA0SGdHSHpXZXhaUmhuQ2p2?=
 =?utf-8?B?djZVT0o0NU91cmdMWm5Wd0NHNUhibHcweXVrSFZQQ3V3VFcyajFCeVBxK1VO?=
 =?utf-8?B?UDM5WVlZT29FR0RpaktzQWYxVmVOaG4rcmVGYkhMRklIQXVMTUlkbFFTTmxy?=
 =?utf-8?B?TCtTdWVlbkJwQUIyZVRnV0tmRlRXK1RYQms4SDI3bzRuaWt5RVNRclllNnZ0?=
 =?utf-8?B?cE1xR0wza2xJRW1sanNURXFYTUp0c25lREJPS2lIN3BvVDJrZG85TWh1S3Nt?=
 =?utf-8?B?MjRrUHVwN3VLVVhyZk0ySitqaFh3Qmp5d3RvaUV4ditYU3BLMGg4RWhSZHAz?=
 =?utf-8?B?V2hDMjYwcjcwNkFNMVZNMVFRTllZYklHYnh1bkcxU21HRlBRMjZ2Q1hMNk4v?=
 =?utf-8?B?eHlhc2pMS0tOOFJiYkFyWDIwU0RSeTlYcnl5TElTSklWZDBVM2hEZ1AxMVBO?=
 =?utf-8?B?dzVvUHFkSVZzYXg5YUluYm9JM3BMQzhWUGZNbHEzb1pXWWtwZnNSUUQwanhh?=
 =?utf-8?B?YkJmNFQ5RnVCeDRCd3pDNFFBSXJkTFFPWkF3Ymw5KzA2TGNzWDZJdSthbzdo?=
 =?utf-8?Q?my2oWNYiBN0FdYq3Lv8UGtn+R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09bc5df-edb2-4130-898a-08dae170b050
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2022 03:25:33.6844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mR++2HHKwmjfryreh7zpJI5VQ6Tvft+DZtYR8ISZ6RB9Evnl1BfmhPYLW13Sfssuwy+1EeRwOjWe0gtnnrgl+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhA
ZGVueC5kZT4NCj4gU2VudDogMjAyMuW5tDEy5pyIMTjml6UgMzo0Nw0KPiBUbzogSG9uZ3hpbmcg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7DQo+IGEuZmF0b3Vt
QHBlbmd1dHJvbml4LmRlOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsLnN0YWNoQHBlbmd1dHJv
bml4LmRlOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
OyByb2JoQGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGFsZXhhbmRlci5zdGVp
bkBldy50cS1ncm91cC5jb207DQo+IHJpY2hhcmQubGVpdG5lckBsaW51eC5kZXYNCj4gQ2M6IGxp
bnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUkVTRU5EIHYxMiA0LzRdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBBZGQgaS5N
WDhNUCBQQ0llDQo+IFBIWSBzdXBwb3J0DQo+IA0KPiBPbiAxMC8xMy8yMiAwMzo0NywgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+IFsuLi5dDQo+IA0KPiA+IEBAIC0yMzgsNiAr
MjUxLDE0IEBAIHN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCQlyZXR1cm4gUFRSX0VSUihpbXg4X3BoeS0+cmVzZXQp
Ow0KPiA+ICAgCX0NCj4gPg0KPiA+ICsJaWYgKGlteDhfcGh5LT5kcnZkYXRhLT52YXJpYW50ID09
IElNWDhNUCkgew0KPiA+ICsJCWlteDhfcGh5LT5wZXJzdCA9DQo+ID4gKwkJCWRldm1fcmVzZXRf
Y29udHJvbF9nZXRfZXhjbHVzaXZlKGRldiwgInBlcnN0Iik7DQo+ID4gKwkJaWYgKElTX0VSUihp
bXg4X3BoeS0+cGVyc3QpKQ0KPiA+ICsJCQlkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihpbXg4
X3BoeS0+cGVyc3QpLA0KPiANCj4gSSBqdXN0IG5vdGljZSB0aGlzICwgYXJlIHdlIG1pc3Npbmcg
cmV0dXJuIGhlcmUgPw0KPiANCj4gVGhhdCBpcyAuLi4gcmV0dXJuIGRldl9lcnJfcHJvYmUoLi4u
KSA/DQoNCk9vaCwgaXQncyBteSBmYXVsdC4gVGhhbmtzIGZvciB5b3VyIHJlbWluZGVyLg0KT25l
IHJldHVybiBzaG91bGQgYmUgaGVyZS4NCi0gICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnJf
cHJvYmUoZGV2LCBQVFJfRVJSKGlteDhfcGh5LT5wZXJzdCksDQorICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoaW14OF9waHktPnBlcnN0KSwN
CkhpIFZpbm9kIEB2a291bEBrZXJuZWwub3JnOg0KU2hvdWxkIEkgcmUtc3VtbWl0IG9uZSBmaXgg
cGF0Y2g/DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gPiArCQkJCSAgICAg
ICJGYWlsZWQgdG8gZ2V0IFBDSUUgUEhZIFBFUlNUIGNvbnRyb2xcbiIpOw0KPiA+ICsJfQ0KPiAN
Cj4gWy4uLl0NCg==
