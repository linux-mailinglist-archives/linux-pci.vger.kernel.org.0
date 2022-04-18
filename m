Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EED4504BE1
	for <lists+linux-pci@lfdr.de>; Mon, 18 Apr 2022 06:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiDRE46 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Apr 2022 00:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiDRE4z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Apr 2022 00:56:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5484183A0;
        Sun, 17 Apr 2022 21:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0hFUvzVJfz58qhG8Dvov6lZ2/YUjKGXcA3xv9LbYPSOogG4n+hy5Ho6ospttuGRUIozisq8/gmcjItm9cOeP12VG1gM33w3WRmAUMNm+ycys2dR5rOpV2JAICzCRLrHyyLz/xflAcxfsDyDxOQKsx8LR5FakOCyXd6tYIA+3XxeLBzLz4Ih0eBee0ErRL/kcIzuo7JNKqHKpwgVFabIDds+I8ytOsCswxBaDLmfNEvyTn8WoIN4AnkzwcAmD05SWqvHWEVeMsF6Gmay32DzwIiHhblwPBiY90A/OlkCuH6KT6r4TFxRmed9T2IeQH3yKsgSbKv3NEVZn79pG1B7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgBYOll2ZzJIN3PW2QIXl01r9CNiGm2iWc/QliUKaUk=;
 b=VG30SfMpxTt+mJpKaWfo2Tmu4V2om2AX4pR8i/DShgyGm+S9TQaOkMru3b1V+hffgQrqb2EvXP0vdIv22MZWl2RhSOBokuHfc6okxncCqTEupSCyeWAvECdTtf6JJwh0ZC3JjFQvsax/2HmnobQXHw+RiW0b4kfMOTwlAI6FJoklmqpwpJiXhLa/xBQaOLRo0gjg56Cs8QgIe3A48p0/5lrAfsZrQLuj58mvexv/TEc/ZEadBkzGYAtTdC9PLAxDCrPnOm5o99UG0wdN3mjS/75YSu2x/EDk61Q8sSXAXSNDxzyOsLOwnq6OAkguE8kJZ1Lmt/mySTZpddSKXrSsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgBYOll2ZzJIN3PW2QIXl01r9CNiGm2iWc/QliUKaUk=;
 b=QgIfoBBlafMx12t2Djx3h9iiIz6PGbc4lfONqxoHdYxA1whGWKtXCDQpIxF1xptJ4EkzeX28MxAhAMbYxv2f5/FJM1Lsb1aqC2+eOym6yt8ASKcghGgXMibHzDZxgiKy3jpM1/IuD8Jv7CY6OhwxlKvPMImtVWTATb18vJyuAnQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0402MB3433.eurprd04.prod.outlook.com (2603:10a6:7:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 04:54:01 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ecea:cb09:5ff2:1800%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 04:54:01 +0000
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
Subject: RE: [PATCH v2 0/7] Add the iMX8MP PCIe support
Thread-Topic: [PATCH v2 0/7] Add the iMX8MP PCIe support
Thread-Index: AQHYMgQJVjtpqun8b0KM+ThJT0OxrazwHQmAgAUxzIA=
Date:   Mon, 18 Apr 2022 04:54:01 +0000
Message-ID: <AS8PR04MB8676782510B7727F451A98398CF39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <6221c3d0da08ef15f572593d67fd0e9c7ba03ab0.camel@pengutronix.de>
In-Reply-To: <6221c3d0da08ef15f572593d67fd0e9c7ba03ab0.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64f60c9e-d572-4aa0-8fe8-08da20f774ec
x-ms-traffictypediagnostic: HE1PR0402MB3433:EE_
x-microsoft-antispam-prvs: <HE1PR0402MB3433E35974EE62531B4B422B8CF39@HE1PR0402MB3433.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nEZW7jOhD9a17tqWgGBcKxJRnjxmXiN7qHo8+LsO4wjG+g0v1NB5CNBuRJMyUpkrWSwxiIJkEoKuadh0I6MmptsQHFZq8qClZQSUY9KXi4pDGPS45MXz/VCm638SLvlIQ9X+bdohPhkPGYPDU0YYCNCjNepkEPhzq1BcUF8X6Uj+GaXgR9vTn5pwxlC6PhQj2w3wQS8MmX+Oc2A7Kr25DLnr7GND9GqQVzKngWjZC0ZDRuqDBkSRvML26ljQlIC3M6m+SZSQrHB5BXWAP9bkcV0cDWvhEnodTG+SwG6zlwXvJL3pH4pl2Oh4TSVoMw1lZTEINAP8wAByS34ypCCitm3v22Z7V/deVD1Vw7MbzC01chqkjCd49WGj0bzpYIIGEzDjLuMSPnh1WIBY1ev/MWDNcgm3r6mTTJ4TyYvEOwr6WwLtTt8HqsnQ5MZcA0mH7CUb4+pfHMiCFrjJvZzlpyi2PtVR4cvDLbLZS+EbJ9npxIedh1IEuGb3oaAmk1jhAxa648K2zEN6JwfgJR22/bZpzWGaJPh1ZuAbnzaVhCQtnfAOFtd8p+TkrlQLjViS/hR1FOPg87CUltreK05eq5gc33pAqDQDQ+M3l1C9JSCYLvbO+sT2G9cFoOO+6FhHtSxvyL6f9UpWuVCCqgtSWK8EpIbXyaSY+nPhsuIhTQqcaIxGEcHIQW1FJO0RLPNxhvj0gKQmIF96HOCpYdFKuVWGjClrxm/y9qkCWsypCo42Zh9VSrT4YNiPt/NU+0p+OZi+k0v2fI6PfrNPXWKUe0tIUq4kG9dRrMYUCJWIsX+oZj+q0tt16iiyuzoanH1B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(33656002)(38070700005)(508600001)(110136005)(83380400001)(186003)(26005)(9686003)(53546011)(6506007)(122000001)(45080400002)(38100700002)(44832011)(7416002)(7696005)(2906002)(5660300002)(54906003)(71200400001)(8936002)(4326008)(52536014)(76116006)(316002)(66946007)(66446008)(64756008)(55016003)(8676002)(66476007)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MWY3dkhRdkxvM2Q2QjZiYzl6aEo4ejNYYVZTbHY5UVdwN0tGWUdiSGUwQjBq?=
 =?gb2312?B?QVJjdUdLeCtIcThwbytDeGRndWorVHIxdzBESDFSQ2RxZW9MbS9RdUZiOXJ1?=
 =?gb2312?B?V1JhcVUwVTBMVUdjRGU0MGs2TmZib1RUSjdCbm9vYzFCdTlYMG4vaDZhUTE0?=
 =?gb2312?B?NVpQd21JTkV0Ym1GNjdvMHVqNU05NEdXVlJQN2c4VEEremZYbG4vSG5yVjl2?=
 =?gb2312?B?ZWtLWlo4bENvTjI2a3Rib0FRQ0xGRFRQMk50RXJjM0dQaHl5N25SZzRYaFlB?=
 =?gb2312?B?ZytSeEFOWVJvSjUyYlc2OUN5SzBpbW1wcnhIRkVnU24wU0hUaWwrZUxxa3dX?=
 =?gb2312?B?SFpualhFcWFseFhzNjN0U0UzZkRsNStQSVN5MW5ZZitIZTF3NWVrNDhMYTRr?=
 =?gb2312?B?OS9qNkZQUlg3dVF5ZXdIMlBoSklrclpmcjRrNWIvOFRNaStvcnBjOGdkNVBF?=
 =?gb2312?B?Zjh1bU43bzNXekpIWHJUcWwxS3lxdEd2ZG9xTCtleXVCcDZQT2RaQWZOYTZF?=
 =?gb2312?B?VWZ6OTg4c3lrRHV1aUoyTFU0VkJQYTRoVGQvTERJUVJ3MWU0QjVvb2pRemFU?=
 =?gb2312?B?NFRKZkwyOXVCbXE3LzYvaUY0cW9tekZzY2ljMkNHcHdmRnZHOWdHN2xsaCtF?=
 =?gb2312?B?RzBUeFI0QzVBSlkxdzRPZmhwaS8xVDNKMVBVNjB0WmIyMGR4WDBtcHdqd1ZK?=
 =?gb2312?B?KytzQWVZTWhZSURiZHB0Qy9oM1VZYk40ZURIQldvaEZrR1JxYTZ5SE1mVGJ6?=
 =?gb2312?B?MTJrU2dvcnJ3d3ZxY01vdCt6c0psVVo0VGtCeU9adVdkaGIzL1MyV0R0dEFM?=
 =?gb2312?B?aGNmU01NTk1wL2g1aUhpbnhkQUFkcjdVMUUrNGtCTjIyVTRSb2thay9vNzJK?=
 =?gb2312?B?Q01HMVBaMDFhc0Q1YytuMkRkTktkWWcxblZvNnh3enNBVloyT1pNWlhYZVVW?=
 =?gb2312?B?aHdMQ1RUTXdnTjNuZmcyT0Z4QXgzRkxsR2daazVjd09jTjVJVkVXdHZZVEZV?=
 =?gb2312?B?VjVPYkxYZXNsc2l3U3k1S3FPL1N6SkpPYWlvNHBETm11bWMrbTJYVzUyd3Ri?=
 =?gb2312?B?d3VpV0Y4YU4xRENzMzhVbjF4Z2ZPNmREUWZxQzZQSWhQVGs3aW9NWnFxR0E5?=
 =?gb2312?B?bHI5NlBnc1pUVktWdDRhN0ErS2dtMk1RbTVBbnc1NjMwcUdBd2xBZVpUOWd5?=
 =?gb2312?B?R2l5d2t3NzlYeWdJUU9uSFdsK2RXakk4MkhyS1VLVENXc0tPblVLNC91dllC?=
 =?gb2312?B?cS9tbkFFYnpMcXROV2RxdFNNZmVudDRMRjlyWUhSb1A4OE4xWk5wYmg3OU9u?=
 =?gb2312?B?ZTVEc0xBTXErRXcxWjdFYko3LzRrcXdsd3Z2WmVSZTNJdENrcCt5NVhYRnlt?=
 =?gb2312?B?ck5mdVFmeVNUcHl2QmtQUWk2TTRsYUhKaUJ1dWRBYUdCZWhaTjZwQUpvUEcx?=
 =?gb2312?B?TVg5ZGw3Nm0xTjk3TGN4Vnc0d3pRUytLSWwvTVZxSGhEODRhYlRFczB5dFF0?=
 =?gb2312?B?aE9wcnNaR21rekpmNE85R0lFUlcvREl2cUswdktsUG1wNUJ4SHQ5bEZyUmNa?=
 =?gb2312?B?WXlnWjk2U1VnaVpIdDYwTFo0T0hIeW5EMHZQa1ZkNE4zejNCSWhNQXdMQXgv?=
 =?gb2312?B?N0xUNUZ0K3g5RXJxejZTVGxxNEVtTnA5eXRvbERxdWNONVJkeHNHcXY0eUw3?=
 =?gb2312?B?dW9VWEhzYUtvcCs5MmxnVXlKdU5MSzMwK0l0Yzg0aDJUc2pqT251bG1OaU1F?=
 =?gb2312?B?V2pLbnF2d1BINVRpSWt6WGUyVlhNRFRYMnV0YmIxVHNQR0NPcWF2UmpnRHFW?=
 =?gb2312?B?dnBocmU2M1pVdmZLN2NYZTgxS2h5RGtnVGJzY0tzYUZPWDFLWDU0aml3bU1a?=
 =?gb2312?B?WkJQbTNYblpBdW0vNWltdGJGUlk1NTdSWlFYYkc5WFd5NFAyeVkvem9YY1ZW?=
 =?gb2312?B?TG5DS2xtLzl6dVA1TWc0dzlyV1JQQkQ1RlpNUUpzY01xNStiQzVERGQwSGw3?=
 =?gb2312?B?WGhST01PRkJhN1BUT1hsSE5qZm1tdEZ2WXh3NW9BODhrQVVFaUdSR0N1YkJG?=
 =?gb2312?B?T1hxT0dOem5wb2d3MXdQVnBlZG91Sjl2RVlCdnhrcHpZWWpZaTRuSFg0Qk85?=
 =?gb2312?B?dUIxazVJclFRNDF5bXMwaGd4djJtOTQvejROU0dsY0RpZG5HSG9PRW15NmtF?=
 =?gb2312?B?UG0yc284Rm9iTTgwbS8vTUhadXQyVlFEV3ZsYmZHclhtR2Q4Y21sUEN0eC9k?=
 =?gb2312?B?NzkxY2hTeDFvL3lKM2FYcmZ6anh2S1BRbkNpL0pkK3ZVYWp1WDVzcGdoK3F2?=
 =?gb2312?B?UDBYYU1LejdlR2syVHJYdGZDSWxucWFaVUtldVdJcG01dVVSNlQyZz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f60c9e-d572-4aa0-8fe8-08da20f774ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 04:54:01.5924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S/FhXeXvhTxGmrEbCOFBOksQHA4tqjLmEEoczJmQkKBRhs/aAt+A7LXZXMyXm7tFUIpkys1l9P0dasYco1Ly1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3433
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMsTqNNTCMTXI1SA0OjQ1DQo+IFRvOiBIb25n
eGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsN
Cj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBr
ZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyB2a291bEBrZXJuZWwub3JnOyBhbGV4
YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tDQo+IENjOiBsaW51eC1waHlAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1p
bXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAvN10g
QWRkIHRoZSBpTVg4TVAgUENJZSBzdXBwb3J0DQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gSSBk
aWRuJ3QgZ2V0IGFyb3VuZCB0byBzZWUgd2hhdCdzIHdyb25nIHdpdGggdGhlIFBDSWUgb24gbXkg
RVZLLCBzbyBJIHdhc24ndA0KPiBhYmxlIHRvIGRvIGFueSByZXdvcmtzIHRvIHRoZSBzZXJpZXMu
IEFzIEkgd2lsbCBiZSBvbiB2YWNhdGlvbiBmcm9tIHRvbW9ycm93DQo+IHVudGlsIEFwci4gMjV0
aCwgSSdsbCBqdXN0IGxlYXZlIHNvbWUgbW9yZSBjb21tZW50cyBvbiB0aGlzIHNlcmllcyBmb3Ig
eW91cg0KPiBjb25zaWRlcmF0aW9uLg0KSGkgTHVjYXM6DQpHb3QgdGhhdCwgdGhhbmtzLg0KSGF2
ZSBhIGdvb2QgaG9saWRheS4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiBS
ZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gQW0gTW9udGFnLCBkZW0gMDcuMDMuMjAyMiB1bSAxNzow
NyArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IEJhc2VkIG9uIHRoZSBpLk1YOE1QIEdQ
QyBhbmQgYmxrLWN0cmwgcGF0Y2gtc2V0WzFdIGlzc3VlZCBieSBMdWNhcyBhbmQNCj4gPiB0aGUg
Zm9sbG93aW5nIGNvbW1pdHMuDQo+ID4gICAtIG9uZSBjb2RlcyByZWZpbmUgcGF0Y2gtc2V0WzVd
Lg0KPiA+ICAgLSB0d28gRml4ZXNbMl0sWzNdLg0KPiA+ICAgLSBvbmUgYmluZGluZyBjb21taXRb
NF0uDQo+ID4gICAtIHNvbWUgZHRzIGNoYW5nZXMgaW4gU2hhd24ncyBnaXQgaWYgeW91IHdhbnQg
dG8gdGVzdCBQQ0llIG9uIGkuTVg4TU0NCj4gRVZLLg0KPiA+ICAgICBiNGQzNmMxMGJmMTcgYXJt
NjQ6IGR0czogaW14OG1tLWV2azogQWRkIHRoZSBwY2llIHN1cHBvcnQgb24NCj4gaW14OG1tIGV2
ayBib2FyZA0KPiA+ICAgICBhYWViYTZhOGUyMjYgYXJtNjQ6IGR0czogaW14OG1tOiBBZGQgdGhl
IHBjaWUgc3VwcG9ydA0KPiA+ICAgICBjZmM1MDc4NDMyY2EgYXJtNjQ6IGR0czogaW14OG1tOiBB
ZGQgdGhlIHBjaWUgcGh5IHN1cHBvcnQNCj4gPg0KPiA+IFNvcnJ5IGFib3V0IHRoYXQgdGhlcmUg
bWF5IGJlIHNvbWUgY29uZmxpY3Rpb25zIHdoZW4gZG8gdGhlIGNvZGVzIG1lcmdlLg0KPiA+IEkn
bSB3YWl0aW5nIGZvciB0aGUgYWNrIG5vdywgYW5kIHdpbGwgcmUtYmFzZSB0aGVtIGluIGEgcHJv
cGVyIHNlcXVlbmNlIGxhdGVyLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMgcGF0Y2hlcyBhZGQgdGhl
IGkuTVg4TVAgUENJZSBzdXBwb3J0IGFuZCB0ZXN0ZWQgb24gaS5NWDhNTQ0KPiA+IEVWSyBhbmQg
aS5NWDhNUCBFVmsgYm9hcmRzLiBUaGUgUENJZSBOVk1FIHdvcmtzIGZpbmUgb24gYm90aCBib2Fy
ZHMuDQo+ID4NCj4gPiAtIGkuTVg4TVAgUENJZSBQSFkgaGFzIHR3byByZXNldHMgcmVmZXIgdG8g
dGhlIGkuTVg4TU0gUENJZSBQSFkuDQo+ID4gICBBZGQgb25lIG1vcmUgUEhZIHJlc2V0IGZvciBp
Lk1YOE1QIFBDSWUgUEhZIGFjY29yZGluZ2x5Lg0KPiA+IC0gQWRkIHRoZSBpLk1YOE1QIFBDSWUg
UEhZIHN1cHBvcnQgaW4gdGhlIGkuTVg4TSBQQ0llIFBIWSBkcml2ZXIuDQo+ID4gICBBbmQgc2hh
cmUgYXMgbXVjaCBhcyBwb3NzaWJsZSBjb2RlcyB3aXRoIGkuTVg4TU0gUENJZSBQSFkuDQo+ID4g
LSBBZGQgdGhlIGkuTVg4TVAgUENJZSBzdXBwb3J0IGluIGJpbmRpbmcgZG9jdW1lbnQsIERUUyBm
aWxlcywgYW5kIFBDSWUNCj4gPiAgIGRyaXZlci4NCj4gPg0KPiA+IE1haW4gY2hhbmdlcyB2MS0t
PnYyOg0KPiA+IC0gSXQncyBteSBmYXVsdCBmb3JnZXQgaW5jbHVkaW5nIFZpbm9kLCByZS1zZW5k
IHYyIGFmdGVyIGluY2x1ZGUgVmlub2QNCj4gPiAgIGFuZCBsaW51eC1waHlAbGlzdHMuaW5mcmFk
ZWFkLm9yZy4NCj4gPiAtIExpc3QgdGhlIGJhc2VtZW50cyBvZiB0aGlzIHBhdGNoLXNldC4gVGhl
IGJyYW5jaCwgY29kZXMgY2hhbmdlcyBhbmQgc28gb24uDQo+ID4gLSBDbGVhbiB1cCBzb21lIHVz
ZWxlc3MgcmVnaXN0ZXIgYW5kIGJpdCBkZWZpbml0aW9ucyBpbiAjMyBwYXRjaC4NCj4gPg0KPiA+
IFsxXWh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRnANCj4gPg0KPiBhdGNod29yay5rZXJuZWwub3JnJTJGcHJvamVjdCUyRmxp
bnV4LWFybS1rZXJuZWwlMkZjb3ZlciUyRjIwMjIwMjI4MjANCj4gMQ0KPiA+DQo+IDczMS4zMzMw
MTkyLTEtbC5zdGFjaCU0MHBlbmd1dHJvbml4LmRlJTJGJmFtcDtkYXRhPTA0JTdDMDElN0Nob25n
eA0KPiBpbmcuDQo+ID4NCj4gemh1JTQwbnhwLmNvbSU3QzNlODcxMGI0NWZjZDQ1MTYxNDU5MDhk
YTFlNTdhZDliJTdDNjg2ZWExZDNiYzINCj4gYjRjNmZhOTINCj4gPg0KPiBjZDk5YzVjMzAxNjM1
JTdDMCU3QzElN0M2Mzc4NTU2NTkxNjIxNDU5MDYlN0NVbmtub3duJTdDVFdGDQo+IHBiR1pzYjNk
OGV5Sg0KPiA+DQo+IFdJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsx
aGFXd2lMQ0pYVkNJNk1uMCUzRCU3DQo+IEMzMDAwDQo+ID4NCj4gJmFtcDtzZGF0YT1wNzU4WnZ6
RDl3U2gyM0JjejI5ZSUyQmJ2Vmk2QmZtdkRxSWdoNHl6UjNBQ3MlM0QmYW0NCj4gcDtyZXNlcnYN
Cj4gPiBlZD0wDQo+ID4gWzJdaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcA0KPiA+DQo+IGF0Y2h3b3JrLm96bGFicy5vcmcl
MkZwcm9qZWN0JTJGbGludXgtcGNpJTJGcGF0Y2glMkYxNjQ2Mjg5Mjc1LTE3ODEzLQ0KPiAxDQo+
ID4NCj4gLWdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0MG54cC5jb20lMkYmYW1wO2RhdGE9
MDQlN0MwMSU3Q2hvbmd4aQ0KPiBuZy4NCj4gPg0KPiB6aHUlNDBueHAuY29tJTdDM2U4NzEwYjQ1
ZmNkNDUxNjE0NTkwOGRhMWU1N2FkOWIlN0M2ODZlYTFkM2JjMg0KPiBiNGM2ZmE5Mg0KPiA+DQo+
IGNkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNzg1NTY1OTE2MjE0NTkwNiU3Q1Vua25vd24lN0NU
V0YNCj4gcGJHWnNiM2Q4ZXlKDQo+ID4NCj4gV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVN
eklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTcNCj4gQzMwMDANCj4gPg0KPiAmYW1w
O3NkYXRhPVBLYTBiaGpmZ2clMkI3NEt0S1lFdE1MdGFyJTJCTWt3Nm9kM0laa2tqZDVVNmZNJTNE
JmENCj4gbXA7cmVzZQ0KPiA+IHJ2ZWQ9MA0KPiA+IFszXWh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnANCj4gPg0KPiBhdGNo
d29yay5vemxhYnMub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBjaSUyRnBhdGNoJTJGMTY0NTY3MjAx
My04OTQ5LTENCj4gLQ0KPiA+DQo+IGdpdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0MG54cC5j
b20lMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q2hvbmd4aQ0KPiBuZy56DQo+ID4NCj4gaHUlNDBueHAu
Y29tJTdDM2U4NzEwYjQ1ZmNkNDUxNjE0NTkwOGRhMWU1N2FkOWIlN0M2ODZlYTFkM2JjMg0KPiBi
NGM2ZmE5MmMNCj4gPg0KPiBkOTljNWMzMDE2MzUlN0MwJTdDMSU3QzYzNzg1NTY1OTE2MjE0NTkw
NiU3Q1Vua25vd24lN0NUV0ZwDQo+IGJHWnNiM2Q4ZXlKVw0KPiA+DQo+IElqb2lNQzR3TGpBd01E
QWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMw0KPiAw
MDAmDQo+ID4NCj4gYW1wO3NkYXRhPXdDbkFacUgyMkNXUkJjJTJCTkpPVGRmRlVFY0djYjlKdHpp
SVZKc1VNU1hWYyUzRCZhbXANCj4gO3Jlc2VydmUNCj4gPiBkPTANCj4gPiBbNF1odHRwczovL2V1
cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZw
DQo+ID4NCj4gYXRjaHdvcmsub3psYWJzLm9yZyUyRnByb2plY3QlMkZsaW51eC1wY2klMkZwYXRj
aCUyRjE2NDYyOTM4MDUtMTgyNDgtDQo+IDENCj4gPg0KPiAtZ2l0LXNlbmQtZW1haWwtaG9uZ3hp
bmcuemh1JTQwbnhwLmNvbSUyRiZhbXA7ZGF0YT0wNCU3QzAxJTdDaG9uZ3hpDQo+IG5nLg0KPiA+
DQo+IHpodSU0MG54cC5jb20lN0MzZTg3MTBiNDVmY2Q0NTE2MTQ1OTA4ZGExZTU3YWQ5YiU3QzY4
NmVhMWQzYmMyDQo+IGI0YzZmYTkyDQo+ID4NCj4gY2Q5OWM1YzMwMTYzNSU3QzAlN0MxJTdDNjM3
ODU1NjU5MTYyMTQ1OTA2JTdDVW5rbm93biU3Q1RXRg0KPiBwYkdac2IzZDhleUoNCj4gPg0KPiBX
SWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZN
bjAlM0QlNw0KPiBDMzAwMA0KPiA+DQo+ICZhbXA7c2RhdGE9VTIyMU51SWhlZSUyRkY5WWYlMkIy
OHBGd1ZsZzhmaTNtNjk0cWJkZlBacyUyQkhFdyUzDQo+IEQmYW1wO3JlDQo+ID4gc2VydmVkPTAN
Cj4gPiBbNV1odHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZwDQo+ID4NCj4gYXRjaHdvcmsub3psYWJzLm9yZyUyRnByb2plY3Ql
MkZsaW51eC1wY2klMkZjb3ZlciUyRjE2NDU3NjA2NjctMTA1MTAtDQo+IDENCj4gPg0KPiAtZ2l0
LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSUyRiZhbXA7ZGF0YT0wNCU3QzAxJTdD
aG9uZ3hpDQo+IG5nLg0KPiA+DQo+IHpodSU0MG54cC5jb20lN0MzZTg3MTBiNDVmY2Q0NTE2MTQ1
OTA4ZGExZTU3YWQ5YiU3QzY4NmVhMWQzYmMyDQo+IGI0YzZmYTkyDQo+ID4NCj4gY2Q5OWM1YzMw
MTYzNSU3QzAlN0MxJTdDNjM3ODU1NjU5MTYyMTQ1OTA2JTdDVW5rbm93biU3Q1RXRg0KPiBwYkda
c2IzZDhleUoNCj4gPg0KPiBXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJ
NklrMWhhV3dpTENKWFZDSTZNbjAlM0QlNw0KPiBDMzAwMA0KPiA+DQo+ICZhbXA7c2RhdGE9OUtI
em9xNmtNRkFMJTJGVm5HNkdNdlklMkZkYmZ6YU9sWmY5eTRZJTJGdVZyRUtWNCUzDQo+IEQmYW1w
O3JlDQo+ID4gc2VydmVkPTANCj4gPg0KPiA+IE5PVEU6DQo+ID4gQmFzZWQgZ2l0DQo+ID4gPGdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9scGllcmFsaXNpL3Bj
aS5naXQ+DQo+ID4gQmFzZWQgYnJhbmNoIDxwY2kvaW14Nj4NCj4gPg0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbCAgICB8ICAgMSAr
DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2ll
LXBoeS55YW1sIHwgICA0ICstDQo+ID4gYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1wLWV2ay5kdHMgICAgICAgICAgICAgICAgIHwgIDU1DQo+ICsrKysrKysrKysrKysrKysrKysr
KysNCj4gPiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaSAgICAgICAg
ICAgICAgICAgICAgfCAgNDYNCj4gKysrKysrKysrKysrKysrKysrLQ0KPiA+IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgICAgICAgICAgICB8ICAxOQ0K
PiArKysrKysrLQ0KPiA+IGRyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUu
YyAgICAgICAgICAgICAgICAgICB8IDIwNQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICsrKystLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+IGRyaXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMSArDQo+ID4gNyBmaWxlcyBjaGFuZ2VkLCAyODYgaW5zZXJ0aW9ucygr
KSwgNDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBbUEFUQ0ggdjIgMS83XSByZXNldDogaW14Nzog
QWRkIHRoZSBpTVg4TVAgUENJZSBQSFkgUEVSU1Qgc3VwcG9ydA0KPiA+IFtQQVRDSCB2MiAyLzdd
IGR0LWJpbmRpbmc6IHBoeTogQWRkIGlNWDhNUCBQQ0llIFBIWSBiaW5kaW5nIFtQQVRDSCB2Mg0K
PiA+IDMvN10gcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IEFkZCBpTVg4TVAgUENJZSBQSFkg
W1BBVENIIHYyIDQvN10NCj4gPiBkdC1iaW5kaW5nczogaW14NnEtcGNpZTogQWRkIGlNWDhNUCBQ
Q0llIGNvbXBhdGlibGUgW1BBVENIIHYyIDUvN10NCj4gPiBhcm02NDogZHRzOiBpbXg4bXA6IGFk
ZCB0aGUgaU1YOE1QIFBDSWUgc3VwcG9ydCBbUEFUQ0ggdjIgNi83XSBhcm02NDoNCj4gPiBkdHM6
IGlteDhtcC1ldms6IEFkZCBQQ0llIHN1cHBvcnQgW1BBVENIIHYyIDcvN10gUENJOiBpbXg2OiBB
ZGQgdGhlDQo+ID4gaU1YOE1QIFBDSWUgc3VwcG9ydA0KPiANCg0K
