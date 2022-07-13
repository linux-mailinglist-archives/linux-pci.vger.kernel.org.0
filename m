Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90265736A1
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 14:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiGMMwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 08:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiGMMwk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 08:52:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA3C37F9C;
        Wed, 13 Jul 2022 05:52:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQLZStcNqeRO8QmFlczHXIuYEAftSnFE+11FbnIZqQzabJebFkNZzlhtlSAvJl8fqypVEzGsBUmXbYGJvus8GdlqOt8rgK8S0+2gfvRlO6pPzDP7RYvypm/Lr/QrxkVCcCDWYb+qvOhil3aL0paWCeZZF5kfJJMZXBhA9a5rtQLWeOnafY12LZDZt7tQRyKHV0bJnMQcAVhg47LCfGlI1N4U4UV6vpdMq/SnLuB3cXbx4K1+57kCZdqb/pues1sd8Sbl3wsx5qfjuY7frYQHSzMZV7qD1ZLRFFgvtl6PiE1bvC3upD5CMypktegsiK2ObDpcqJxC764PIUWCxVVdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be/oINFEYWcmKXv4ZPPOS3kYk01C21VDrauDgXirrsE=;
 b=atVWjDmifmJJizldU0MsdyRmFG3kzRqTTLHgYlmHrSllKU0s981WSeCAwC3C4n1+0MawS4QBP7PzhWQxJXwRFWqiH94vr7eKTFWtVUsomyimCInZjEwv408DanG2Deryf9ZXKnsPN3Ip1IXCwMGBoxtA9vIw5fSUis6fpLJpnSgHhwPdHEh+a42SHmEEgA05qbj/DNckBDJp6IeRNFTvx3gMW/meCp2fNnxSqA4RS4Av4BICRoWu3zDdsIJDtJ6MyykFcVJWH3krolddLI5EzHBN4IxAjJLxuExOf/OwGW+/3blxhcZFIu0OXRNYkAe/FH5ggO1NY3sAZPhK2ffdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Be/oINFEYWcmKXv4ZPPOS3kYk01C21VDrauDgXirrsE=;
 b=QSJRnOFBQylcLCuIWF4ODLNK27JzUITpzSfbuOgu0Kia8offFcq4l7r3siynl0gwy3v58oxnbba80NE1w/frVYWbsOpftHelQLSh6IaCQDSg44e9RaroZj74fgEX8od3LRPILLLlK4qg+AR5Rt81rOR0wHGmfPaoRJionhL5D0Q=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VE1PR04MB6704.eurprd04.prod.outlook.com (2603:10a6:803:128::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 12:52:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 12:52:32 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 14/17] PCI: imx6: Do not hide phy driver callbacks and
 refine the error handling
Thread-Topic: [PATCH v14 14/17] PCI: imx6: Do not hide phy driver callbacks
 and refine the error handling
Thread-Index: AQHYjPxRR2VrUUjfUkSsDg0hZCCmz618E4uAgAAZiQCAAA00AIAADBSg
Date:   Wed, 13 Jul 2022 12:52:31 +0000
Message-ID: <AS8PR04MB8676BC6BE5415AD37EF833A08C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-15-git-send-email-hongxing.zhu@nxp.com>
         <4f49f28d15ad859e34aeeb714b5ddd5d6eba4b4a.camel@pengutronix.de>
         <AS8PR04MB8676435692989AE1C4082C998C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <5bb33ccf17f89cd398342922af6fd7a04f015c07.camel@pengutronix.de>
In-Reply-To: <5bb33ccf17f89cd398342922af6fd7a04f015c07.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a79c06e-8518-424b-370f-08da64ce8d1d
x-ms-traffictypediagnostic: VE1PR04MB6704:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YXlCY3g4jiuOa1D6zHT49L/DGl3OEc9kRcpuKG+GCoY3m2WfCfdu5Zm5WTAMFenQcWZ560y7DjYuclJbsWHvcwg19qoNpjeDjVlnvYpGehGsO0pIOcPHroG3bU/FkhFzNJitHdTS1WX2Pg3DT1XgbVvyC/Z+FvkMDND+OoglTZEIA0/c3JkGWT1YLpdZndRNR8R2ANF+xTgsCmvEk3brEldHqHrQh3mNS4Lpe9aA0dZM3vHCZjirjd0oX15HxucUi4vylFIQyBCgSCpqTYzSuEj0hykf3LgFSWFcuz1AfcPQgCdXYjAQcznARqK7/eA1Ohichxh82wEjLsy2hg2ylIJzfRo88mng8iMNRkhwsREnvxvkTxj0wz+Y+0vh2rtmhmYnXxP6/dgwxh/c8bHVUSty/oqgeKB1dGdOiJxVOnd0FLZlW71vUz3fX1CNHhG8Njm3aK1+8EOl/rdg1woZAy1aTowwOSH4fLV4ddonjDiz9JW5RJjvoa/O27hHmoYStKvqgArp5AgMC6K6AktHXXAP+xfoN1Y6Wmevd7FoxV4SfE5goqgIUDZUAz9yS0tcKLI9u8I/qdqJAqbzXjdwSTzFZ1/BPouCRjPMVL+y1EMkL/MsCOHpgUpQAm6eY7j1YBJHJU/Rxcr6dVe79zszg7b1KsGMA/6bYMA00SJXttjWUiz3EZugVcMy0NmnCg24fOMv8Kk84pZfADmyGzMmhzCJhPr0E00JlnTwtfumnN0Y/clhzsDFseHhh6TRl7e99GeXmUK+kuTTv0e0xt62st0K5h0j+c8eRR+8Ly1QPJmJtNuVKUYmFPuEhVW9WP6Q6EzyTPScnghq5ssC/ZOqFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(38070700005)(316002)(110136005)(55016003)(122000001)(83380400001)(38100700002)(966005)(54906003)(41300700001)(71200400001)(64756008)(8676002)(7696005)(66446008)(186003)(6506007)(66556008)(53546011)(86362001)(8936002)(9686003)(7416002)(2906002)(66476007)(44832011)(26005)(5660300002)(66946007)(76116006)(52536014)(33656002)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHFMbVNDbGJ0RnBRS2pGQmZCMHdLNEFQT1AveWtpRThGaTZvdnlBcFlMNGNB?=
 =?utf-8?B?Zkl2bWdrb2VQS090UFduMGFUSkovZ21QSnBlY28rSEVBdTEwa2N6UnpqdVVV?=
 =?utf-8?B?RzM5SDNrVktDaG5ha0pUVEFsR00wUHNETE1DSDh1QW1LTVVFbXFnL2Yycm1T?=
 =?utf-8?B?cGNPdm9QVGhmYWNkaHpWVy9jaFM2cG1FLzhVc1JvcXpOOVZpNFcrRXFrcXhx?=
 =?utf-8?B?bll6NFQ2V2J1STlnN2VlVVdycGh3TThicUpEQmlpcmNLOXhEMlBmZ3VaaW1X?=
 =?utf-8?B?bGcwOHEvVFR3TGRqKzh6Z0lDRCt4SG1aaDVhQm9Ram5BcWxCMTVqQUtNM1JS?=
 =?utf-8?B?WjlvUW5VY1lSblBCTlJOMUNQZEM2bWFkbVZRODZYcnduaC9HbDNPYnQzdGtU?=
 =?utf-8?B?ZXoxOVR0a0RxZjI0cFYzRGRhQlRvRHU5WXFlZXpScGgrMzI2QzRObTB4RWEw?=
 =?utf-8?B?eXRwS0tXVDVmWEdyc21hdy9DbFpKQmtRTGl6KzlmcWZibTJmOHBMQ0Z1TFpZ?=
 =?utf-8?B?V2FIK1hDc1I5ZVBsZVhyQ25EakpOd0M3cWxEYm9yTkFIdkdpemN2cUNjclBo?=
 =?utf-8?B?ZGlvcUpQUWkrSENOM0R2TmhYR0lLYVBzcERQeWZVbEtVbnI2NjlOWXkyZmdY?=
 =?utf-8?B?V3V1V1ViSGJZY3RKOStYMWF1bVVlVjlqUXl4T2E3SDZJUDNQVTY5ZzN2VnpQ?=
 =?utf-8?B?d1NyZFNGaVZZNTFoT0VUeThnYXNleTZtc3FzbkxiNUlLaVVSZnhPOXY4dHNu?=
 =?utf-8?B?ZFkvNEZxL2hRb2dyWlJYdE9ha1Aza3N2S1AxNXJuRmFNalU4aWoxRTlOWHRX?=
 =?utf-8?B?dU9kemFNbUF0d3N2TDY2VnZDZzVtTjNSck8vcHpmS3ZVRWJGeVgzcFN5NEZN?=
 =?utf-8?B?MW9IeFZRUjJWZnMyWkFQa2RKUXZzaFdOeUdHZktha1QwK1VSTFVuN3VnUkZv?=
 =?utf-8?B?Ri9qWFdLbHBKZWRya2c2R2FYSVd4dGNaeEhZYWVKYUg3Q2pBbEMvTWZZdERm?=
 =?utf-8?B?c2ZuWFcrWXhwajdXaEp2cVJTZncyQlFiOU5KOEF4RGo3NWFkRHV3a3lBWlVi?=
 =?utf-8?B?a0RrVU0zUDhWWEJHRHhsVHorWHVZWU04d2JvMTk5djVMbmhZVUluYzVvMDA0?=
 =?utf-8?B?UDNyMDl6eXExU2dsVmhxN2c1Qit4RC9DcmtSU3hzU1p0dTBNcDROeTBUa29G?=
 =?utf-8?B?c2VpTEptenQvU21ZSDlueWZoa0VvMWN4aDRWZGs5a1UxSno1bGx5M0NvQkdH?=
 =?utf-8?B?T0E5KzArSXd0WGFxbzUxYS9vYUNwOHJhMXJYWnE2dVJ6azE3bVlycStjcTM2?=
 =?utf-8?B?ZXBBbzVybWxQaUwwbG1EUGhoOTlEdGNFUW1URzlUbXFLQVYrWjAvM2c0OVZS?=
 =?utf-8?B?bWM3TDBPRzBXaGFJd1B0UVc2SXdENy9LcW5IMUhGR2hHeEVjU21BUk1pSlRZ?=
 =?utf-8?B?R2hlTEQ3cC9rRVc0TTVPT2VvK2RZaE5lUE1yZ1AxU1hQZksvYWMzc09VNmQ3?=
 =?utf-8?B?ZXYvdjZaNU0wY1VjWGdONXNsay9UOERZZlVHZjRTTEpYZmZaSWxMOU96SjMw?=
 =?utf-8?B?bHFjK0xoMVVPRHZJL01ybnBwNG9LeEFMNFhYZVZ6RE4vVSt4eXV0RnVweWc1?=
 =?utf-8?B?RkR0VG5Ic1JXZ1J2U1R4bFVjaml2cWYvbC9JUXJCaDQvWjBtRE9aakQxN0ls?=
 =?utf-8?B?MGcyRUJsU0FyWWxoMGlUWVd6Z0Q5RmQyRWJmNXQ1b2Y2Ynh5Qys2Z3JXcktH?=
 =?utf-8?B?bjhRQzRjZUFzQ2dnVW5EQk1UeGpmYWQ5VHpPaGN0WHd2WGhmNENub1NxaTNv?=
 =?utf-8?B?elhrK3NoOGxVQTloSStiSlZCWlhyeGhNemhRZHF0cHJ2M2xYOTdvRzA2Sjkr?=
 =?utf-8?B?ZzdERDFqWGVGNFhaUnZXaWZhTnRzS3lxQ1doZkkxY1J0Q3FFakhaVnJ1OWoz?=
 =?utf-8?B?aTJpdlcxNWx1eW9YNHJQZXRrUTBVQjV0RWZtTDQrMk5sL2t4bFZFN2dISnQv?=
 =?utf-8?B?UEFwK0lsaDlZRy9DNXRZbnB6QlkvbUFZOG1ONklRUW92d1FZNjFMS3lwYnJi?=
 =?utf-8?B?ZTYwaVZUQ1NRa0Q4cGEwejZOcVZ4VTVDVXRHQ1d3bFprU1ZxMzU0TklSMHQ2?=
 =?utf-8?Q?sJZG8DUchf1jYV+h6vU380DA4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a79c06e-8518-424b-370f-08da64ce8d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 12:52:31.9420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTqcn6UqkvjrUfQZDDJt7ekcjetQn+7F8a2Whokr62l2wfjlEOefs3iJkIebmWVQj9Vnbyn1fCMs95YcwhHaPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDfmnIgxM+aXpSAxOToxNw0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTQvMTddIFBDSTogaW14NjogRG8gbm90IGhp
ZGUgcGh5IGRyaXZlciBjYWxsYmFja3MgYW5kDQo+IHJlZmluZSB0aGUgZXJyb3IgaGFuZGxpbmcN
Cj4gDQo+IEFtIE1pdHR3b2NoLCBkZW0gMTMuMDcuMjAyMiB1bSAxMDo1NyArMDAwMCBzY2hyaWVi
IEhvbmd4aW5nIFpodToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBG
cm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gPiA+IFNlbnQ6IDIw
MjLlubQ35pyIMTPml6UgMTY6NTkNCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gPiA+IHJvYmgrZHRAa2VybmVsLm9y
ZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOw0KPiA+ID4g
ZmVzdGV2YW1AZ21haWwuY29tOyBmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbQ0KPiA+ID4g
Q2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA+ID4gPGxpbnV4LWlteEBueHAu
Y29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTQvMTddIFBDSTogaW14NjogRG8g
bm90IGhpZGUgcGh5IGRyaXZlcg0KPiA+ID4gY2FsbGJhY2tzIGFuZCByZWZpbmUgdGhlIGVycm9y
IGhhbmRsaW5nDQo+ID4gPg0KPiA+ID4gQW0gRnJlaXRhZywgZGVtIDAxLjA3LjIwMjIgdW0gMTE6
MjUgKzA4MDAgc2NocmllYiBSaWNoYXJkIFpodToNCj4gPiA+ID4gLSBNb3ZlIHRoZSBwaHlfcG93
ZXJfb24oKSB0byBob3N0X2luaXQgZnJvbQ0KPiA+ID4gPiBpbXg2X3BjaWVfY2xrX2VuYWJsZSgp
Lg0KPiA+ID4gPiAtIE1vdmUgdGhlIHBoeV9pbml0KCkgdG8gaG9zdF9pbml0IGZyb20NCj4gPiA+
ID4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPiA+ID4NCj4gPiA+ID4gUmVm
aW5lIHRoZSBlcnJvciBoYW5kbGluZyBpbiBpbXg2X3BjaWVfaG9zdF9pbml0KCkgYWNjb3JkaW5n
bHkuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGlu
Zy56aHVAbnhwLmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8Ymhl
bGdhYXNAZ29vZ2xlLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IMKgZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDM0ICsrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ID4g
PiAtLS0tLS0NCj4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMTMg
ZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gPiA+ID4gaW5kZXggNWEwNmZiY2E4MmQ2Li4wYjJhNTI1NmZiMGQg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0K
PiA+ID4gPiBAQCAtNjM5LDE0ICs2MzksNiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9jbGtfZW5h
YmxlKHN0cnVjdA0KPiA+ID4gPiBpbXg2X3BjaWUNCj4gPiA+ICppbXg2X3BjaWUpDQo+ID4gPiA+
IMKgCQlnb3RvIGVycl9yZWZfY2xrOw0KPiA+ID4gPiDCoAl9DQo+ID4gPiA+DQo+ID4gPiA+IC0J
c3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4gPiA+ID4gLQljYXNlIElN
WDhNTToNCj4gPiA+ID4gLQkJaWYgKHBoeV9wb3dlcl9vbihpbXg2X3BjaWUtPnBoeSkpDQo+ID4g
PiA+IC0JCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBwb3dlciBvbg0KPiA+ID4gPiBQSFlcbiIp
Ow0KPiA+ID4gPiAtCQlicmVhazsNCj4gPiA+ID4gLQlkZWZhdWx0Og0KPiA+ID4gPiAtCQlicmVh
azsNCj4gPiA+ID4gLQl9DQo+ID4gPiA+IMKgCS8qIGFsbG93IHRoZSBjbG9ja3MgdG8gc3RhYmls
aXplICovDQo+ID4gPiA+IMKgCXVzbGVlcF9yYW5nZSgyMDAsIDUwMCk7DQo+ID4gPiA+IMKgCXJl
dHVybiAwOw0KPiA+ID4gPiBAQCAtNzIzLDEwICs3MTUsNiBAQCBzdGF0aWMgaW50DQo+ID4gPiA+
IGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdA0KPiA+ID4gaW14Nl9wY2llICpp
bXg2X3BjaWUpDQo+ID4gPiA+IMKgCWNhc2UgSU1YOE1ROg0KPiA+ID4gPiDCoAkJcmVzZXRfY29u
dHJvbF9kZWFzc2VydChpbXg2X3BjaWUtDQo+ID4gPiA+ID5wY2llcGh5X3Jlc2V0KTsNCj4gPiA+
ID4gwqAJCWJyZWFrOw0KPiA+ID4gPiAtCWNhc2UgSU1YOE1NOg0KPiA+ID4gPiAtCQlpZiAocGh5
X2luaXQoaW14Nl9wY2llLT5waHkpKQ0KPiA+ID4gPiAtCQkJZGV2X2VycihkZXYsICJ3YWl0aW5n
IGZvciBwaHkgcmVhZHkNCj4gPiA+ID4gdGltZW91dCFcbiIpOw0KPiA+ID4gPiAtCQlicmVhazsN
Cj4gPiA+ID4gwqAJY2FzZSBJTVg3RDoNCj4gPiA+ID4gwqAJCXJlc2V0X2NvbnRyb2xfZGVhc3Nl
cnQoaW14Nl9wY2llLQ0KPiA+ID4gPiA+cGNpZXBoeV9yZXNldCk7DQo+ID4gPiA+DQo+ID4gPiA+
IEBAIC03NjIsNiArNzUwLDcgQEAgc3RhdGljIGludA0KPiA+ID4gPiBpbXg2X3BjaWVfZGVhc3Nl
cnRfY29yZV9yZXNldChzdHJ1Y3QNCj4gPiA+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ID4g
PiDCoAkJdXNsZWVwX3JhbmdlKDIwMCwgNTAwKTsNCj4gPiA+ID4gwqAJCWJyZWFrOw0KPiA+ID4g
PiDCoAljYXNlIElNWDZROgkJLyogTm90aGluZyB0byBkbyAqLw0KPiA+ID4gPiArCWNhc2UgSU1Y
OE1NOg0KPiA+ID4gPiDCoAkJYnJlYWs7DQo+ID4gPiA+IMKgCX0NCj4gPiA+ID4NCj4gPiA+ID4g
QEAgLTkxMywxNyArOTAyLDM2IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX2hvc3RfaW5pdChzdHJ1
Y3QNCj4gPiA+ID4gcGNpZV9wb3J0DQo+ID4gPiAqcHApDQo+ID4gPiA+IMKgCQkJcmV0dXJuIHJl
dDsNCj4gPiA+ID4gwqAJCX0NCj4gPiA+ID4gwqAJfQ0KPiA+ID4gPiArCWlmIChpbXg2X3BjaWUt
PnBoeSkgew0KPiA+ID4gPiArCQlyZXQgPSBwaHlfcG93ZXJfb24oaW14Nl9wY2llLT5waHkpOw0K
PiA+ID4gPiArCQlpZiAocmV0KSB7DQo+ID4gPiA+ICsJCQlkZXZfZXJyKGRldiwgInBjaWUgcGh5
IHBvd2VyIHVwDQo+ID4gPiA+IGZhaWxlZC5cbiIpOw0KPiA+ID4gPiArCQkJZ290byBlcnJfcmVn
X2Rpc2FibGU7DQo+ID4gPiA+ICsJCX0NCj4gPiA+ID4gKwl9DQo+ID4gPiA+DQo+ID4gPiA+IMKg
CXJldCA9IGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0KGlteDZfcGNpZSk7DQo+ID4gPiA+
IMKgCWlmIChyZXQgPCAwKSB7DQo+ID4gPiA+IMKgCQlkZXZfZXJyKGRldiwgInBjaWUgZGVhc3Nl
cnQgY29yZSByZXNldCBmYWlsZWQ6DQo+ID4gPiA+ICVkXG4iLCByZXQpOw0KPiA+ID4gPiAtCQln
b3RvIGVycl9yZWdfZGlzYWJsZTsNCj4gPiA+ID4gKwkJZ290byBlcnJfcGh5X29mZjsNCj4gPiA+
ID4gwqAJfQ0KPiA+ID4gPg0KPiA+ID4gPiArCWlmIChpbXg2X3BjaWUtPnBoeSkgew0KPiA+ID4g
PiArCQlyZXQgPSBwaHlfaW5pdChpbXg2X3BjaWUtPnBoeSk7DQo+ID4gPiA+ICsJCWlmIChyZXQp
IHsNCj4gPiA+ID4gKwkJCWRldl9lcnIoZGV2LCAid2FpdGluZyBmb3IgcGh5IHJlYWR5DQo+ID4g
PiA+IHRpbWVvdXQhXG4iKTsNCj4gPiA+ID4gKwkJCWdvdG8gZXJyX2Nsa19kaXNhYmxlOw0KPiA+
ID4gPiArCQl9DQo+ID4gPiA+ICsJfQ0KPiA+ID4NCj4gPiA+IFdvdWxkbid0IGl0IGJlIG1vcmUg
bG9naWNhbCB0byBwdXQgdGhpcyBpbnRvIGlteDZfcGNpZV9pbml0X3BoeSgpPw0KPiA+ID4NCj4g
PiBCZWZvcmUgYWRkaW5nIGkuTVg4TU0gUENJZSBzdXBwb3J0LCB0aGUgaW14Nl9wY2llX2luaXRf
cGh5KCkgb25seQ0KPiA+IHRvdWNoZXMgdGhlDQo+ID4gwqBHUFIgcmVnaXN0ZXJzLiBQQ0llIGNs
b2NrcyBhbmQgc28gb24gYXJlIG5vdCByZXF1aXJlZCBpbiB0aGlzIGNhc2UuDQo+ID4gQnV0IHBo
eV9pbml0KCkgdXNlZCBieSBpLk1YOE1NIFBDSWUgdG91Y2hlcyBub3Qgb25seSB0aGUgR1BSIHJl
Z2lzdGVycw0KPiA+IGJ1dA0KPiA+IMKgYWxzbyB0aGUgUEhZJ3MgcmVnaXN0ZXJzLg0KPiA+IFRo
ZSBjbG9ja3Mgc2hvdWxkIGJlIG9uIGFuZCByZXNldHMgb2YgUEhZIHNob3VsZCBiZSBjb25maWd1
cmVkDQo+ID4gcHJvcGVybHkgd2hlbg0KPiA+IMKgcGh5X2luaXQoKSBpcyBpbnZva2VkLg0KPiA+
IFNvLCBwaHlfaW5pdCgpIGlzIHBsYWNlZCBiZWhpbmQgb2YgaW14Nl9wY2llX2RlYXNzZXJ0X2Nv
cmVfcmVzZXQoKQ0KPiA+IGhlcmUuDQo+IA0KPiBUaGUgUEhZIGRyaXZlciBzaG91bGQgYmUgc2Vs
Zi1jb250YWluZWQgZW5vdWdoIHRvIG5vdCBjYXJlIGFib3V0IHRoZSBzdGF0ZSBvZg0KPiB0aGUg
Y29udHJvbGxlciBoZXJlLCBubz8gSXQgc2hvdWxkIHNldCBhbGwgdGhlIG5lY2Vzc2FyeSBHUFJz
IGFuZCBlbmFibGUgY2xvY2tzDQo+IGFzIG5lZWRlZCBvbiBpdHMgb3duLiBJcyB0aGlzIG5vdCB0
aGUgY2FzZSB3aXRoIHRoZSBjdXJyZW50IGNvZGU/DQo+IA0KPiBBbHNvIFBIWSBpbml0IHNob3Vs
ZCBiZSBjYWxsZWQgYmVmb3JlIFBIWSBwb3dlci1vbiwgdG8gbWFrZSB0aGluZ3Mgc3ltbWV0cmlj
DQo+IHdpdGggdGhlIHNodXRkb3duIHBhdGhzIHdoaWNoIGRvIHBoeV9wb3dlcl9vZmYoKSBmaXJz
dCwgdGhlbiBwaHlfZXhpdCgpLg0KPiANClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NClllcywg
YWdyZWUgd2l0aCB0aGF0IFBIWSBkcml2ZXIgc2hvdWxkIGJlIHNlbGYtY29udGFpbmVkIGVub3Vn
aC4NCkkgbWlzLXVuZGVyc3Rvb2QgdGhlIHNlcXVlbmNlIG9mIHBoeV9pbml0KCkgYW5kIHBoeV9w
b3dlcl9vbigpIHdoZW4gSSBhZGQNCiB0aGUgUEhZIGRyaXZlci4gVGhlIHBoeV9pbml0KCkgaXMg
cmVsaWVkIG9uIHRoZSBwaHlfcG93ZXJfb24oKSBoZXJlLg0KU28sIEkgaGF2ZSB0byBwbGFjZSB0
aGUgcGh5X2luaXQoKSBiZWhpbmQgcGh5X3Bvd2VyX29uKCkgY3VycmVudGx5Lg0KSSB0aGluayB0
aGUgcGh5X2luaXQoKSBjYW4gYmUgcGxhY2VkIGluIGlteDZfcGNpZV9pbml0X3BoeSgpIHdoZW4g
dGhlIG9yZGVyDQogaXNzdWUgaXMgZml4ZWQuDQoNCkJUVywgQmpvcm4gaGFkIG5vdGljZWQgbWUg
dGhpcyBpc3N1ZSB0b28gWzFdLiBTaW5jZSBpdCdzIGEgYnVnLCBJIHdvdWxkIGlzc3VlDQogYW5v
dGhlciBzdGFuZGFsb25lIGJ1ZyBmaXggY29tbWl0cyB0byByZXNvbHZlIHRoaXMgaXNzdWUgbGF0
ZXIuDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9w
YXRjaC8xNjU1NDYxODc0LTE2OTA4LTExLWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodUBueHAu
Y29tLw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gUmVnYXJkcywNCj4gTHVjYXMN
Cg0K
