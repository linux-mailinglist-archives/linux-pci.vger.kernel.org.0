Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52C6504C10
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 06:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiDRE6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 00:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiDRE6Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 00:58:16 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197FAE72;
        Sun, 17 Apr 2022 21:55:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHgNs4ksasFU7ahARVm+F80DcIwRjnbPskVXooeVYMo3+wlYoFecHWCPkMj9MwKGO2RxsZKL8BCr0BoOckWX+XAsdn9N4JSgXCx3YeCXf9Awy1/TofNPWKmW/LOlbI5swjpxpOG47pJ47y98HjOzXU8p4ANLwCgeNONCvI7+AKWtgI+PB4JxwUexzcnkI3DUS+R1o/KhHK4VWXAclw8b42c/hZnI+M7N5xee0g59e7A1Tqnt+GDMeMwZqBEGROvk/5zO0jUX619ytH5PS7Z5ra6TmXYWemTa4oD2VtKJ/y/WQWF8bg4CabMHfYb76sT+qGkRXV8axQyPWDGXJX7bRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaDVgo+e6rUG9oblkyVpAdPMxvEnMCXx/WwpBI1g40Y=;
 b=ngd2WkHyxeJ74WUL7zrtOLqhDcjftWPtbxiXLorBxn+1I2SBgfaeSkGip3EJz6xoRKq59J9WVGrJ5z9eJF69jGN6UHPIZLBqgD6YjuWx3WiYQt0coYvqdbdo1JK8Zgs5L7NA3vMDaJSakYKykqvXdJN/WGIJCmQs4V6cOl+r2ItWRstKmhnaFq4LJvxpJH13qP7TQ70pkucI+35eI36y2Tvh3rRuThjISe4xXp3vRB4flFHkO3b3sHy4OpEwRJxzZ9eFRdKsgSLfEO4ZFdRVsvhXD4WUlwJOwxoISCf9cdLbkLPN6VcmWusvcZcDDKxf1o7SbliIGrWmi7cUS/RyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaDVgo+e6rUG9oblkyVpAdPMxvEnMCXx/WwpBI1g40Y=;
 b=Z6TwESdkt/MXSJQEbsWrUpytMP84eLUIICYvTBr9iq/TOp+0u2h9B8fP4UiLxR/zAWAV2rVAqytOKWeB7rM4cJR8ajIi25OHQs/J/RWALtLnrfOGGB5dl4p0bRO7PJbYf4u+sqqfEn7gwbMXAzjBtJmFqz/cDgSs6stBOZfo64o=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0401MB2555.eurprd04.prod.outlook.com (2603:10a6:3:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 04:55:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 04:55:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
Thread-Topic: [PATCH v2 5/7] arm64: dts: imx8mp: add the iMX8MP PCIe support
Thread-Index: AQHYMgQNwI/KYMhc8E25YFV+OIGtzKzwIfuAgAUuK7A=
Date:   Mon, 18 Apr 2022 04:55:33 +0000
Message-ID: <AS8PR04MB8676F9A410442049E3DCA1F68CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
         <1646644054-24421-6-git-send-email-hongxing.zhu@nxp.com>
 <fc2c6ddbf55723ac4c0f366e5a6131afafe546aa.camel@pengutronix.de>
In-Reply-To: <fc2c6ddbf55723ac4c0f366e5a6131afafe546aa.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58d36841-17cb-442f-7c5b-08da20f7abba
x-ms-traffictypediagnostic: HE1PR0401MB2555:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB255524E505B5D5235CF1F1DE8CF39@HE1PR0401MB2555.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SyglPDA3Pp6nCmuwED+O8QJEA9Y8vU718xiUfI6ap7LZ3BJ9nEdT/8UeudVARwou1Z+QU5gR0iTu2gvoGRDWKt9gxg1BTyZpEdD1CFamwpp1pVV3ryoKSqFsCtqAR2GeJqznFSAUpboryhItL/1ywZ1Z32O/bFZlILrLWQi/8fKvIqgJ1eMxiVdnf2qWR0yd5cXb4OQ6s06x3Z5SxJHC0KcuL9U963A63cBSofg6JCvKibdQS4NVNhsKvMrOPF2+US30AAPVHHsl93/33mmoNHN66d8qmWYeQ/z8Gp9BoxWiQopYKyQCP0TIO9K3jnoXdqYc1caeObhFcSH3fSIoXFV6OoKl0XOyd3tELP0UcoilZDA7w/0BxbIcJrYNAjE51hK6PTjeaTbBs3hWen+GaDv8XFbevM6iW1AhwAv7gU1uF2mtBd++sVL7Lfo7LfBDg8uQAV/5T/wqFJF+2f4tFLROlmMbWErK5neBU1bH+6MU8a5SCoM+hSgOfj1hwDf2zEXa36YyfnwHguwARlMuRiCwRhInsymaA9qe1wI25TfFAyjUAv1Ia9qDhlR9vA/SM3pAzfhMaswP4k+WcdAWP9zAAv1iSEvLSPwh/4NM8j1kLvd+80Em5T8ptbdyNQXC+8NifjhX1dUYjFbbAqBzZ1kA2vBMZahlmXTWIKMDxDx1KOWfEWp7wYl+RHYeertaxKyWLg4pNi09PobBJHOV4guketM99rG3j/wWTaxcEDI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(316002)(26005)(6506007)(54906003)(110136005)(7416002)(5660300002)(52536014)(8936002)(33656002)(7696005)(53546011)(186003)(9686003)(2906002)(86362001)(122000001)(71200400001)(44832011)(38100700002)(38070700005)(508600001)(55016003)(64756008)(8676002)(4326008)(66446008)(76116006)(66556008)(66946007)(66476007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk1KRnQ1Z2syM2ZOSENYY2xlblhHbG1ESFBqeW1wWHE1N09TNGt1cWVhSWlo?=
 =?utf-8?B?MENJQkRPcHNGbkZyS3B6T3QxeFo4L1VHOWluckExOGU3b3FxeC95QWt0ayt4?=
 =?utf-8?B?WTFmMHdPS1E0TmdNRWl2TWhiNWxIclRHbEZxNllYZTNidUl6SlJOTW5SYXBu?=
 =?utf-8?B?RlBDcGtGbGZuSU14b0g4bG9VTnZ1UzBPd3lHMnVmOTJadmw5aldSc2lPNG5i?=
 =?utf-8?B?cGw3VGFmRXdQcDY5OWdFOWZOTXBrQlRXR205Z0thYnN4SjYzTHZtcTlHZTEz?=
 =?utf-8?B?cVF0dW5HSGtYS1R1aTVhOVlKWnBKWjJLUW1VU29Mc2NBanN3TVh0MU45Mm1F?=
 =?utf-8?B?MVJQdlpPaENxbVNveGZwekhSRHQrSFd4alVEY2RWM25ocW9ROFRsQmNlTHNS?=
 =?utf-8?B?aGd4b3krUUd6MUZmNU5rYkROakF3Rmt5YU1ISU5nbENMRTIwVVg5T2JnSzhU?=
 =?utf-8?B?bVdyVlNNczcvSnlrdDVhbnNGeHVjMmVBYm9CenM5bHBSZi8wdlo4aVlyTS9l?=
 =?utf-8?B?Q2gyQmFycmtmaW1sM25yNGx0YS9SdWp6VGpEOUluZTR5WkMwN2VxUzdwVDlM?=
 =?utf-8?B?RUQwSytueWxRWDVia1Q5bndBdTlmT203LzJ2WmxlcHF2eDlsSlNUUGV1NjNP?=
 =?utf-8?B?Z0RGMDZWclBldlhPZmdHc0U3cm5MMm51MjdWV0JmOWl3RXkrVzhYVmtvbm1W?=
 =?utf-8?B?b2lWQmZyeFFxYXJkNTBXcmZNNDE5WHNUOS9QRGpyWVVnM3Y5ZUlMQ0hKRk9D?=
 =?utf-8?B?MTcrM0hmUGk4MjRkZW95QzFrUmxwWHZlVXk3eWFUNjRDZDlCc1FuMnNHQXp5?=
 =?utf-8?B?aEtLZmJ3K0N0UXlKSXJqUC9GMHVESFhTRUVGYkZIQnU5cHhVa0N3N3VjUFMr?=
 =?utf-8?B?a3BJWHJDdkZsdHpnU0ZLeU1WcUFkODEwdHY4NjFCN21ndDI4T2lOSXNETDY4?=
 =?utf-8?B?ZStZaW9aWmY2OWtHY2g5ZkVsamlkKzFDWTJ6VUowTmp5ZmlCRHNYVW9oOWNm?=
 =?utf-8?B?UEIydys4N3gra2lvUHhyV3lJM1M2NExZZDN6Q1VpTnAyWDhwbXRSOUpOUDNi?=
 =?utf-8?B?bFhPZE03dlVjVGM3UmVqcTZaY1U3S0pLM29qWElJZmhVaHJ4K1ZTRGIwVzdo?=
 =?utf-8?B?YVVlU2dsNWY1eXVGMUhCMnJwcEwrMExxNzg0M3BVeHAxZmxjMTNMVDVtb3g4?=
 =?utf-8?B?K1A2ejE2Vmc2czdibklUMktuYkp3bWtnM3B2VWR5SzJ0RkV0MHMzYVhCZFRK?=
 =?utf-8?B?SnRSZ1BpYTF1NEtsK2VWWG91bnJJZStHMG5NQ0xVMXlZcTFCbUgvSWJwZHk3?=
 =?utf-8?B?UkFwazUwYVo5dGFRK3ZJVUkwUmR3TGx2eTR4NE8vb3BLb2tBYTJDdUVKRGNW?=
 =?utf-8?B?eDg2UzI5YWtrUDBTOXlOQ0NuTGJKSkZEMStUeGdTRkJsY1R2eVV4bzBScWph?=
 =?utf-8?B?ZzhPc20yVURLOXVsc2RkRTBCUzNTNUhZazFzUUp4azJUUXdEZDVUMUljNytN?=
 =?utf-8?B?K0taa1A0K1JCSVA4cnNLeHREV0RHZmRUYkhXMlBZV3VVYkd1bnlodldERUxW?=
 =?utf-8?B?VllpbnJTek15cDgwNnVZZGZIMVdPeTFoYjVVMms1U3BaSnM5VUluZ0lJWEE1?=
 =?utf-8?B?Wk1mRXFmYmxNWS9aNXhBSWk0dFFzc1I5VUk4Vzl5N2RyUDhQc2RTT2FwVVNJ?=
 =?utf-8?B?T21zK2NjV204eTJBd2JoTUJWMXRuV3FIWVF3dmg4a3Rxa2MxdHJqVXl3VmRQ?=
 =?utf-8?B?SW83MlFTb3pkYlZ2QWpWMjRrUlZOSjlqNmcxLzA2ek9pS3Fxc2dLNWdPVFVI?=
 =?utf-8?B?TnFpVU1qNndPM0hIekF3UDhCMThSdC9KeXprWFJjVWQrTVlIUVdZcGEyMzJT?=
 =?utf-8?B?cU5hdUlNSDd1ek9lYTFYWTVYR1c0ZTdiYWdXNGNId3JLV0s3cUtzSEpCc2NJ?=
 =?utf-8?B?RG0yTEV2eFJSYk10bTZMblA2VGpXMVkrSzhTMmdyR3lKNnRnR3I1UDJpUTlP?=
 =?utf-8?B?RmNhNDRQbjliZDF6dW5PQWx1c25rZ2QrbTVlZGRrb2g4WXNZYnhiZWV0VEp3?=
 =?utf-8?B?SjdVVTVTZC91bEMyTUFOZDFhNVB2TVVQZVZTemNqMGYxTGJxYnRYUGJIUHl4?=
 =?utf-8?B?Mkgwc0FGajJiRGpTODJSUWlud2tyWlBFYUNDU1VDNnZpZFFxaVh5QWpweGtL?=
 =?utf-8?B?Y1hCWUdjTzRSeUo1YkIraG5Rais3bXh5RzhJY0lES09GYUltcTJ3elBFUWg3?=
 =?utf-8?B?WVZheUpNTTRHOUVQUlBKTTVRclFNUTVoVjFXbjNOYThhclBtYS92TDdDNTB1?=
 =?utf-8?B?bTVNZ1JveEh1YmtmRkYzOVUyMDdmWDhEWE1hTUVZa3loMngyWFIyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d36841-17cb-442f-7c5b-08da20f7abba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 04:55:33.5389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smr3m14gWgeBVnW9nqPZYD7dMUVQwcqcBAaEbn6KJZdxqCQkdD8tHD+1COGffYc0ViOG70iIyI2ld13IU/tfMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDTmnIgxNeaXpSA1OjAzDQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5k
ZTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9i
aEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tDQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51
eC1pbXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDUv
N10gYXJtNjQ6IGR0czogaW14OG1wOiBhZGQgdGhlIGlNWDhNUCBQQ0llDQo+IHN1cHBvcnQNCj4g
DQo+IEFtIE1vbnRhZywgZGVtIDA3LjAzLjIwMjIgdW0gMTc6MDcgKzA4MDAgc2NocmllYiBSaWNo
YXJkIFpodToNCj4gPiBBZGQgdGhlIGkuTVg4TVAgUENJZSBzdXBwb3J0Lg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0K
PiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSB8IDQ2DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+IGIvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1wLmR0c2kNCj4gPiBpbmRleCBiNDBhNTY0NmYyMDUuLmU3YjNkODAyOWUz
NCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAu
ZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNp
DQo+ID4gQEAgLTUsNiArNSw3IEBADQo+ID4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Ns
b2NrL2lteDhtcC1jbG9jay5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvaW14
OG1wLXBvd2VyLmg+DQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9pbXg4bXAtcmVz
ZXQuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+ICAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvaW5wdXQvaW5wdXQuaD4NCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPiBAQCAtMzc1LDcgKzM3Niw4
IEBAIGlvbXV4YzogcGluY3RybEAzMDMzMDAwMCB7DQo+ID4gIAkJCX07DQo+ID4NCj4gPiAgCQkJ
Z3ByOiBpb211eGMtZ3ByQDMwMzQwMDAwIHsNCj4gPiAtCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtcC1pb211eGMtZ3ByIiwgInN5c2NvbiI7DQo+ID4gKwkJCQljb21wYXRpYmxlID0gImZzbCxp
bXg4bXAtaW9tdXhjLWdwciIsDQo+ID4gKwkJCQkJICAgICAiZnNsLGlteDZxLWlvbXV4Yy1ncHIi
LCAic3lzY29uIjsNCj4gPiAgCQkJCXJlZyA9IDwweDMwMzQwMDAwIDB4MTAwMDA+Ow0KPiA+ICAJ
CQl9Ow0KPiA+DQo+ID4gQEAgLTk2NSw2ICs5NjcsMTcgQEAgYWlwczQ6IGJ1c0AzMmMwMDAwMCB7
DQo+ID4gIAkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiA+ICAJCQlyYW5nZXM7DQo+ID4NCj4gPiAr
CQkJcGNpZV9waHk6IHBjaWUtcGh5QDMyZjAwMDAwIHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhtcC1wY2llLXBoeSI7DQo+ID4gKwkJCQlyZWcgPSA8MHgzMmYwMDAwMCAweDEwMDAw
PjsNCj4gPiArCQkJCXJlc2V0cyA9IDwmc3JjIElNWDhNUF9SRVNFVF9QQ0lFUEhZPiwNCj4gPiAr
CQkJCQkgPCZzcmMgSU1YOE1QX1JFU0VUX1BDSUVQSFlfUEVSU1Q+Ow0KPiA+ICsJCQkJcmVzZXQt
bmFtZXMgPSAicGNpZXBoeSIsICJwZXJzdCI7DQo+ID4gKwkJCQlwb3dlci1kb21haW5zID0gPCZo
c2lvX2Jsa19jdHJsDQo+IElNWDhNUF9IU0lPQkxLX1BEX1BDSUVfUEhZPjsNCj4gPiArCQkJCSNw
aHktY2VsbHMgPSA8MD47DQo+ID4gKwkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJCQl9
Ow0KPiA+ICsNCj4gPiAgCQkJaHNpb19ibGtfY3RybDogYmxrLWN0cmxAMzJmMTAwMDAgew0KPiA+
ICAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1wLWhzaW8tYmxrLWN0cmwiLCAic3lzY29uIjsN
Cj4gPiAgCQkJCXJlZyA9IDwweDMyZjEwMDAwIDB4MjQ+Ow0KPiA+IEBAIC05ODAsNiArOTkzLDM3
IEBAIGhzaW9fYmxrX2N0cmw6IGJsay1jdHJsQDMyZjEwMDAwIHsNCj4gPiAgCQkJfTsNCj4gPiAg
CQl9Ow0KPiA+DQo+ID4gKwkJcGNpZTogcGNpZUAzMzgwMDAwMCB7DQo+ID4gKwkJCWNvbXBhdGli
bGUgPSAiZnNsLGlteDhtcC1wY2llIjsNCj4gPiArCQkJcmVnID0gPDB4MzM4MDAwMDAgMHg0MDAw
MDA+LCA8MHgxZmYwMDAwMCAweDgwMDAwPjsNCj4gPiArCQkJcmVnLW5hbWVzID0gImRiaSIsICJj
b25maWciOw0KPiA+ICsJCQkjYWRkcmVzcy1jZWxscyA9IDwzPjsNCj4gPiArCQkJI3NpemUtY2Vs
bHMgPSA8Mj47DQo+ID4gKwkJCWRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKwkJCWJ1cy1yYW5n
ZSA9IDwweDAwIDB4ZmY+Ow0KPiA+ICsJCQlyYW5nZXMgPSAgPDB4ODEwMDAwMDAgMCAweDAwMDAw
MDAwIDB4MWZmODAwMDAgMA0KPiAweDAwMDEwMDAwIC8qIGRvd25zdHJlYW0gSS9PIDY0S0IgKi8N
Cj4gPiArCQkJCSAgIDB4ODIwMDAwMDAgMCAweDE4MDAwMDAwIDB4MTgwMDAwMDAgMA0KPiAweDA3
ZjAwMDAwPjsgLyogbm9uLXByZWZldGNoYWJsZSBtZW1vcnkgKi8NCj4gPiArCQkJbnVtLWxhbmVz
ID0gPDE+Ow0KPiA+ICsJCQludW0tdmlld3BvcnQgPSA8ND47DQo+ID4gKwkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAxNDAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKwkJCWludGVycnVwdC1u
YW1lcyA9ICJtc2kiOw0KPiA+ICsJCQkjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0KPiA+ICsJCQlp
bnRlcnJ1cHQtbWFwLW1hc2sgPSA8MCAwIDAgMHg3PjsNCj4gPiArCQkJaW50ZXJydXB0LW1hcCA9
IDwwIDAgMCAxICZnaWMgR0lDX1NQSSAxMjYNCj4gSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+ID4g
KwkJCQkJPDAgMCAwIDIgJmdpYyBHSUNfU1BJIDEyNSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4g
PiArCQkJCQk8MCAwIDAgMyAmZ2ljIEdJQ19TUEkgMTI0IElSUV9UWVBFX0xFVkVMX0hJR0g+LA0K
PiA+ICsJCQkJCTwwIDAgMCA0ICZnaWMgR0lDX1NQSSAxMjMgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+ID4gKwkJCWZzbCxtYXgtbGluay1zcGVlZCA9IDwzPjsNCj4gDQo+IEkgYmVsaWV2ZSB0aGF0
IGlteDZfcGNpZV9zdGFydF9saW5rIGRvZXMgbm90IHByb3Blcmx5IGhhbmRsZSBHZW4zIHNwZWVk
cy4NCkdvb2QgY2F1Z2h0Lg0KVGhlIGFjY29yZGluZyBsaW5rX2dlbiBjb25kaXRpb24gc2hvdWxk
IGJlIGNoYW5nZWQgaW4gZHJpdmVyIHRvby4NCldvdWxkIGJlIGNoYW5nZWQgaW4gbmV4dCB2ZXJz
aW9uLg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBSZWdhcmRz
LA0KPiBMdWNhcw0KPiANCj4gPiArCQkJbGludXgscGNpLWRvbWFpbiA9IDwwPjsNCj4gPiArCQkJ
cG93ZXItZG9tYWlucyA9IDwmaHNpb19ibGtfY3RybCBJTVg4TVBfSFNJT0JMS19QRF9QQ0lFPjsN
Cj4gPiArCQkJcmVzZXRzID0gPCZzcmMgSU1YOE1QX1JFU0VUX1BDSUVfQ1RSTF9BUFBTX0VOPiwN
Cj4gPiArCQkJCSA8JnNyYyBJTVg4TVBfUkVTRVRfUENJRV9DVFJMX0FQUFNfVFVSTk9GRj47DQo+
ID4gKwkJCXJlc2V0LW5hbWVzID0gImFwcHMiLCAidHVybm9mZiI7DQo+ID4gKwkJCXBoeXMgPSA8
JnBjaWVfcGh5PjsNCj4gPiArCQkJcGh5LW5hbWVzID0gInBjaWUtcGh5IjsNCj4gPiArCQkJc3Rh
dHVzID0gImRpc2FibGVkIjsNCj4gPiArCQl9Ow0KPiA+ICsNCj4gPiAgCQlncHUzZDogZ3B1QDM4
MDAwMDAwIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJ2aXZhbnRlLGdjIjsNCj4gPiAgCQkJcmVn
ID0gPDB4MzgwMDAwMDAgMHg4MDAwPjsNCj4gDQoNCg==
