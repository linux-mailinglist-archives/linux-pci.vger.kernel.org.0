Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520A15EF02E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Sep 2022 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiI2ISW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Sep 2022 04:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiI2ISV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Sep 2022 04:18:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1137C13E7F9;
        Thu, 29 Sep 2022 01:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUED6c4xv37OQfLRzHOnvloCvL4jR62nxaQQD5kCqAH7FgfnBaX6Ga2mnaR5zlWuZS1NX8Nte8KzQPA9ElG65/Cdh7J0vfOuahcA8s2lv2rZ/2lWsNbbMR1h5lctnNiH5Al5okD+V18/X1WGHqUBmsxWCl97gS6wzBIALg5Ui5+HoULdk8K27dyVYnvILwO3wYkKzWIDlf+LzYMxmhh4BZpjo5qdRbsowvWBWEBKiA7yeS66QARh3XxcfB3JIdIiqJLzovvUUhe+jgp1Eskckunelor4awKxgU+I9ALfg4zwDIXRT6n5upSrjx53m7tGeNnK1nmxzU6HgbpxndThyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVyXf4a7r+8xSkrA/DMlKaEy66oWSi6nAyi9lcIOqus=;
 b=Sy1AKjBN3Tx/mgklO3U2iZYWl7gGugzoS2xgs9YToBfIygWKZi/cdRbg5jYEU2b9n7Sc06hNWYWThjXiFlso7eVUyQBrzwTE24tlQwiCJbJKYYHW5G9MR0Eoaat83l2VEE1DxvHCxm2//ddQIwfbAYSjGNxVzZ7j35BceVo6Esz3693fcWvfiXQTv+RXWj2yFpJCFOZnP+1mtQG5iF2ysF7cFmLnVldan/pYHB08rp1VNxcvSCLEsFThFUdGkz12+ciI3K1BuuqGvSqG9Y+2VIlecUUnRwYtM5I5l9kUo7QtxMDtmHsBsOw/Nw1ayLsS6/ft1pqosX2rQDN/wmnCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVyXf4a7r+8xSkrA/DMlKaEy66oWSi6nAyi9lcIOqus=;
 b=ooB27lpblGEx47JtzFQ7leNNT9jHnhP4q2hP44hNAku5HEVVzGa/w0xfK/WkQsA9AoKpXUP5V+9U+wwGF6GYxCsZVYKwAUphlTcYifDP+66Srod/zYrOlAziYJdFL4bsrQH0tyXBGApg9eBd5JbBWm1TRBXnEue1qciTQ/E4CnU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7053.eurprd04.prod.outlook.com (2603:10a6:800:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 08:18:15 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::1abe:67d2:b9fe:6b63%3]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 08:18:15 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 3/4] phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe
 PHY driver
Thread-Topic: [PATCH v9 3/4] phy: freescale: imx8m-pcie: Refine i.MX8MM PCIe
 PHY driver
Thread-Index: AQHY0XWdVx9Nh5cv9Um6mVF3roIvHq3193SAgAAbPxA=
Date:   Thu, 29 Sep 2022 08:18:15 +0000
Message-ID: <AS8PR04MB8676F35B76DEE25B30BDCC698C579@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1664174463-13721-1-git-send-email-hongxing.zhu@nxp.com>
 <1664174463-13721-4-git-send-email-hongxing.zhu@nxp.com>
 <YzU747XfZ049pMx0@matsya>
In-Reply-To: <YzU747XfZ049pMx0@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI1PR04MB7053:EE_
x-ms-office365-filtering-correlation-id: 9e635949-1453-49e9-3299-08daa1f3287a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QCW1d4YQ/2ovcsDAMPl4uimzodvHGuliN7BtGLtxO+n8ryMLQxClXJaszBHlo+QJBFRhYfMSl0UXD/aRGJAbF5TiYWIV+ITGyblpssPkaVndn/EaCVzJw3YfABoUwwOm7XNeY9072e3xW+jJpzajqTVH0A/Wb9wlzFrt0IunQdhj5eY+6leYL1ucrgd0pYUUgNrd2zjSfADT3YGxik3Yfy78T4er211q4F9kfYwRBIMZOavCI6A0RjfPmYqdUwtH0i8SRbTqy84bwXFbXlgNNz56U8TGs5uj8pdzbTu64aCwPZQ/YP0cfhMpjPWqeknU0FBmbwzPsNRQflzn/gPQmOsKl+V/THrzCBDAkMzwoZ04JGoO2joWomBVHecUnwLLwfXppiBHGM5pHWHL7RAjFuAV6ZNwGdC5nMLuHljKWSxwXJyVVhhyolkOeFPsQ/oNYPKXs1tmxfDyF3FvrEh/JhS1FJ8TzrPTNuHEBsZwGdcnly+HY0rapQEMTEp7SVBKMRDcg+fG8QFPkKjGO6h44bvYGgh+3pferbbq46ptnHgaLV+Z7RoeEEYJzyuvVICwgPJK8GL0JnfN+u2lnjikh86/MLJuo9mG1akc43Wy1NMwHYRd/VZciE23BS78g9E6wBb/q3IdvZ8DfgNYLeS5cN8HD5bRK3jniwVZGPwzUKC5azggsBkjRBgtgiwTvprkCQ/011gBN5OZI03k5XRBUeP7irUrA6eQHoLLSOabEJVtQ6NGHNpP7+i1yuYvCtbwnJu1JG3DDimWqCIR1QwKoStYOwlkI5xXEa5znsXHitI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199015)(478600001)(71200400001)(53546011)(6506007)(7696005)(316002)(33656002)(52536014)(6916009)(122000001)(38070700005)(2906002)(54906003)(83380400001)(38100700002)(9686003)(26005)(55016003)(64756008)(4326008)(41300700001)(8936002)(8676002)(186003)(66556008)(5660300002)(7416002)(44832011)(66446008)(66476007)(86362001)(66946007)(76116006)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UWFvSGFLVUNtZU5PV1c5amVVV3hWVlErNXBzS1BqbkdUZjJQNCt1czJXeHdN?=
 =?gb2312?B?TnZCMGh1MFRyeERQR1NIWTVuU3RwTzZxNlVRL1lHK01yWGVOQVRqbEs0VFg0?=
 =?gb2312?B?Q1ExNVMrRWIwcjFvRUFuSjdpUXBpN3VlUWk1ZEJZaHByMU9iYVpPYTliWmRt?=
 =?gb2312?B?a2tsQ0Fxa2xGc1BZSE1zaXpoRjVnVFlXRHJ6djlQOGlTM0NMcW5JQmdncjJW?=
 =?gb2312?B?N2ZqRVU2MWFOaUsyVnpWYTBFcEtUdkp5ekFvZjRwY1ZDN00yeXVtb2R4RDFq?=
 =?gb2312?B?dHFJc1lTZ2NPYWFiT0d6MThSb0RIL2JVa2tpVXA2NnBMMWkxSE0vSUdWQnhy?=
 =?gb2312?B?QVd3Z1dXVlkxeHJWK2pjMEVLQ3hHa21QOXlRSWpFUFB6Y015TnlPVlB2NExJ?=
 =?gb2312?B?VHNsajFnZkNuWkpyWGlUTisvRW5URmhkZGo5K3ZKVWl0MEE5cFNXQnlTQ0Ez?=
 =?gb2312?B?cm11T0RNdUtFMC9LbEJYamFvbVNJZnl0ZTBSUzlyYnJ6UVUzUzJsR3ZiTnNq?=
 =?gb2312?B?ZmxUaThLYit3VDJOaysvcGxvWFRaRkc1RkVHdkhlOXpmL29oNC9pZTMvSnJs?=
 =?gb2312?B?MWFzZzZIYk1jL2wrSGRWaTdQN09ieDRtdXpPWWpySzhOb2d4cm9zTUt1OTM4?=
 =?gb2312?B?RzFNeU9yZjFKeEczMXVKMGROTmJkTDEyb0NlUURuY3IwQVViRHJjR1FrcDhi?=
 =?gb2312?B?ZTJMY1pqY2RibmRMa2lrZVhSYzVDV1hHTVBkcFJ1SERCN2tMbUl6Z2lJWUJD?=
 =?gb2312?B?VmhROW1WY3h1dGoyT1BWWjF4YlZub0I2cFNDNVRkakVKNXZjN1FuV3BOcjZO?=
 =?gb2312?B?OG5BR21Xc2Q2WHJsMUR1R0pCMmJuTmJ2UEMwRUkyd2tzaklDelhyQ3gwcEtJ?=
 =?gb2312?B?K0lKU2gxUzM1d3hFNFhRSU1Ga05rcHlidENhRVYwSms0Z3NUNjViMTltY3RJ?=
 =?gb2312?B?c3ZsMGtUM2RJVEk3YkVQek9vTzgrMTQ2Q1NyWHhybVQxY2EvMGtReENJOUVL?=
 =?gb2312?B?eENQYW1DR1lodUc1b1luOHU2dnllTzBLNm9ORUpIaHlYaUhSZ255UDFVM1pv?=
 =?gb2312?B?b1JRVXVsR3htdk5Xb3ZZbStGL3lqNWtWVGo1OUZtY2dtaHV3YzlLSllOTnRw?=
 =?gb2312?B?ZmlwUTd5ZTZIZXo0bStGMU5EbU8vRkdYbVkzOFAyVjdrdlJ5NDdVRDBma3E2?=
 =?gb2312?B?UmtRUHhyNmprcXl5V2ExblF6WnhkYnlla0V1TGIrQnVINkVxeUtTbi9YeGh4?=
 =?gb2312?B?MGlISkd6S2V5dFNxOXRPWTVCdDczNFI5MG1wRVhXOEhTQk1SNzVCVVNSM1Ex?=
 =?gb2312?B?aXZlV1BJelpnNHJuY0cvN1JjcmQwRXcwRFBRMjdpcisrelVFb1k5MWR1YVgz?=
 =?gb2312?B?K2hzeXRzUzM4bEd1NEpxTFhJR0U5NkhXRkMrZ2JINk5LeWtTWTdiRllUL3F2?=
 =?gb2312?B?MmwzeVZPQ25yeDRkYTU4U1pzUWVXcUNYbTlRSFNOZzliSkwxcGtqV3RCWTdl?=
 =?gb2312?B?RThvRjRnWXdMMjlWOGdHYmgraXFYclpSc1V6L3BYcUFKTTBKTzdvcEszWFRo?=
 =?gb2312?B?eGoyRlBQQkp2SlJFSmpNVUZvTWR3QlQxaDdFVjlIWG1vaGlmNFFxRVYxclFi?=
 =?gb2312?B?YTMzLzUvaWZxWU9ZS2lyMEdTdjFKSlJoeXRNZkkrMnRDSGhzUDJKSGplS2lx?=
 =?gb2312?B?ckJwNU44Yk92cEFtT09HTnIwc3VFamtBTTVXRkxwMUlpQ3BWcWlTTkV5MXk3?=
 =?gb2312?B?M1U4Z3l2VzNZcjYzSkJ1b0o2NFJWeXEwUEE0aC9Cc0UxTnE1SFA2Uk5JamF2?=
 =?gb2312?B?SUNUMnhRN1ZhREg0T3ZKemkvT1hucTc5bGs2cWRPMHZmQVZxUlljLzdpSDA4?=
 =?gb2312?B?ejNWbE9vSm1zZDNGNExXWFB5RHkwUnBPUXUyS0x2NFNNS2tXQmE0NWZicXMz?=
 =?gb2312?B?NzhUSkJpM3orOU4wYS9kTTBCZjQwbGVZR2cvZGlDQ1RxellLT2pBRU5FNUJX?=
 =?gb2312?B?NHhqSDFtYlJhYXFLV1RxTkRLRW4yRUVWbHJRRnpnTHkyeEY5ZFVNVmc1MU9H?=
 =?gb2312?B?Q1FJTjgya1FZTHA1NHIvWUNTc0VIT2dLVTlqdDR5c3ZBdG1oc1Zka01Wd2Na?=
 =?gb2312?Q?LBiFMyKmUKA75BzdefZ0iHFJN?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e635949-1453-49e9-3299-08daa1f3287a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 08:18:15.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8OSMEsUrjRKIloLZs/gJ1ydHVfBia639bRjElMfC8ZVCda5M5jfPh05zqG2LwxTsbby+626QlI0kA7y/gkGw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaW5vZCBLb3VsIDx2a291bEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo51MIyOcjVIDE0OjMyDQo+IFRvOiBIb25neGluZyBa
aHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogcC56YWJlbEBwZW5ndXRyb25peC5kZTsg
bC5zdGFjaEBwZW5ndXRyb25peC5kZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0K
PiBhbGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyBtYXJleEBkZW54LmRlOyByaWNoYXJk
LmxlaXRuZXJAbGludXguZGV2Ow0KPiBsaW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY5IDMvNF0gcGh5OiBmcmVlc2Nh
bGU6IGlteDhtLXBjaWU6IFJlZmluZSBpLk1YOE1NIFBDSWUNCj4gUEhZIGRyaXZlcg0KPiANCj4g
T24gMjYtMDktMjIsIDE0OjQxLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBUbyBtYWtlIGl0IG1v
cmUgZmxleGlibGUgYW5kIGVhc3kgdG8gZXhwYW5kLiBSZWZpbmUgaS5NWDhNTSBQQ0llIFBIWQ0K
PiA+IGRyaXZlci4NCj4gPiAtIFVzZSBncHIgY29tcGF0aWJsZSBzdHJpbmcgdG8gYXZvaWQgdGhl
IGNvZGVzIGR1cGxpY2F0aW9ucyB3aGVuIGFkZA0KPiA+ICAgYW5vdGhlciBwbGF0Zm9ybSBQQ0ll
IFBIWSBzdXBwb3J0Lg0KPiA+IC0gUmUtb3JhbmdlIHRoZSBjb2RlcyB0byBsZXQgaXQgbW9yZSBm
bGV4aWJsZSBhbmQgZWFzeSB0byBleHBhbmQuDQo+ID4gTm8gZnVuY3Rpb25zIGNoYW5nZXMgYmFz
aWNseS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRy
b25peC5kZT4NCj4gPiBUZXN0ZWQtYnk6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPiA+
IFRlc3RlZC1ieTogUmljaGFyZCBMZWl0bmVyIDxyaWNoYXJkLmxlaXRuZXJAc2tpZGF0YS5jb20+
DQo+ID4gVGVzdGVkLWJ5OiBBbGV4YW5kZXIgU3RlaW4gPGFsZXhhbmRlci5zdGVpbkBldy50cS1n
cm91cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJv
bml4LmRlPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4
bS1wY2llLmMgfCAxMDgNCj4gPiArKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDY4IGluc2VydGlvbnMoKyksIDQwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGh5L2ZyZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYw0KPiA+IGIv
ZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+ID4gaW5kZXggMjM3
N2VkMzA3YjUzLi45NzUyODE4ZmU5OTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvZnJl
ZXNjYWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+ID4gKysrIGIvZHJpdmVycy9waHkvZnJlZXNj
YWxlL3BoeS1mc2wtaW14OG0tcGNpZS5jDQo+ID4gQEAgLTExLDYgKzExLDcgQEANCj4gPiAgI2lu
Y2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNj
b24vaW14Ny1pb211eGMtZ3ByLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGh5
L3BoeS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiBAQCAtNDUsNiArNDYsMTUgQEANCj4gPiAgI2Rl
ZmluZSBJTVg4TU1fR1BSX1BDSUVfU1NDX0VOCQlCSVQoMTYpDQo+ID4gICNkZWZpbmUgSU1YOE1N
X0dQUl9QQ0lFX0FVWF9FTl9PVkVSUklERQlCSVQoOSkNCj4gPg0KPiA+ICtlbnVtIGlteDhfcGNp
ZV9waHlfdHlwZSB7DQo+ID4gKwlJTVg4TU0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1Y3Qg
aW14OF9wY2llX3BoeV9kcnZkYXRhIHsNCj4gPiArCWVudW0JCWlteDhfcGNpZV9waHlfdHlwZSB2
YXJpYW50Ow0KPiA+ICsJY29uc3QgY2hhcgkqZ3ByOw0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3Ry
dWN0IGlteDhfcGNpZV9waHkgew0KPiA+ICAJdm9pZCBfX2lvbWVtCQkqYmFzZTsNCj4gPiAgCXN0
cnVjdCBjbGsJCSpjbGs7DQo+ID4gQEAgLTU1LDYgKzY1LDcgQEAgc3RydWN0IGlteDhfcGNpZV9w
aHkgew0KPiA+ICAJdTMyCQkJdHhfZGVlbXBoX2dlbjE7DQo+ID4gIAl1MzIJCQl0eF9kZWVtcGhf
Z2VuMjsNCj4gPiAgCWJvb2wJCQljbGtyZXFfdW51c2VkOw0KPiA+ICsJY29uc3Qgc3RydWN0IGlt
eDhfcGNpZV9waHlfZHJ2ZGF0YQkqZHJ2ZGF0YTsNCj4gPiAgfTsNCj4gPg0KPiA+ICBzdGF0aWMg
aW50IGlteDhfcGNpZV9waHlfaW5pdChzdHJ1Y3QgcGh5ICpwaHkpIEBAIC02NiwzMSArNzcsMTcg
QEANCj4gPiBzdGF0aWMgaW50IGlteDhfcGNpZV9waHlfaW5pdChzdHJ1Y3QgcGh5ICpwaHkpDQo+
ID4gIAlyZXNldF9jb250cm9sX2Fzc2VydChpbXg4X3BoeS0+cmVzZXQpOw0KPiA+DQo+ID4gIAlw
YWRfbW9kZSA9IGlteDhfcGh5LT5yZWZjbGtfcGFkX21vZGU7DQo+ID4gLQkvKiBTZXQgQVVYX0VO
X09WRVJSSURFIDEnYjAsIHdoZW4gdGhlIENMS1JFUSMgaXNuJ3QgaG9va2VkICovDQo+ID4gLQly
ZWdtYXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4g
PiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX0FVWF9FTl9PVkVSUklERSwNCj4gPiAtCQkJICAgaW14
OF9waHktPmNsa3JlcV91bnVzZWQgPw0KPiA+IC0JCQkgICAwIDogSU1YOE1NX0dQUl9QQ0lFX0FV
WF9FTl9PVkVSUklERSk7DQo+ID4gLQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14OF9waHktPmlvbXV4
Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX0FVWF9FTiwN
Cj4gPiAtCQkJICAgSU1YOE1NX0dQUl9QQ0lFX0FVWF9FTik7DQo+ID4gLQlyZWdtYXBfdXBkYXRl
X2JpdHMoaW14OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4gPiAtCQkJICAgSU1Y
OE1NX0dQUl9QQ0lFX1BPV0VSX09GRiwgMCk7DQo+ID4gLQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14
OF9waHktPmlvbXV4Y19ncHIsIElPTVVYQ19HUFIxNCwNCj4gPiAtCQkJICAgSU1YOE1NX0dQUl9Q
Q0lFX1NTQ19FTiwgMCk7DQo+ID4gLQ0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5
LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gLQkJCSAgIElNWDhNTV9HUFJfUENJRV9S
RUZfQ0xLX1NFTCwNCj4gPiAtCQkJICAgcGFkX21vZGUgPT0gSU1YOF9QQ0lFX1JFRkNMS19QQURf
SU5QVVQgPw0KPiA+IC0JCQkgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19FWFQgOg0KPiA+IC0J
CQkgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19QTEwpOw0KPiA+IC0JdXNsZWVwX3JhbmdlKDEw
MCwgMjAwKTsNCj4gPiAtDQo+ID4gLQkvKiBEbyB0aGUgUEhZIGNvbW1vbiBibG9jayByZXNldCAq
Lw0KPiA+IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENf
R1BSMTQsDQo+ID4gLQkJCSAgIElNWDhNTV9HUFJfUENJRV9DTU5fUlNULA0KPiA+IC0JCQkgICBJ
TVg4TU1fR1BSX1BDSUVfQ01OX1JTVCk7DQo+ID4gLQl1c2xlZXBfcmFuZ2UoMjAwLCA1MDApOw0K
PiA+ICsJc3dpdGNoIChpbXg4X3BoeS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ICsJY2FzZSBJ
TVg4TU06DQo+ID4gKwkJLyogVHVuZSBQSFkgZGUtZW1waGFzaXMgc2V0dGluZyB0byBwYXNzIFBD
SWUgY29tcGxpYW5jZS4gKi8NCj4gPiArCQlpZiAoaW14OF9waHktPnR4X2RlZW1waF9nZW4xKQ0K
PiA+ICsJCQl3cml0ZWwoaW14OF9waHktPnR4X2RlZW1waF9nZW4xLA0KPiA+ICsJCQkgICAgICAg
aW14OF9waHktPmJhc2UgKyBQQ0lFX1BIWV9UUlNWX1JFRzUpOw0KPiA+ICsJCWlmIChpbXg4X3Bo
eS0+dHhfZGVlbXBoX2dlbjIpDQo+ID4gKwkJCXdyaXRlbChpbXg4X3BoeS0+dHhfZGVlbXBoX2dl
bjIsDQo+ID4gKwkJCSAgICAgICBpbXg4X3BoeS0+YmFzZSArIFBDSUVfUEhZX1RSU1ZfUkVHNik7
DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCWlmIChwYWRfbW9kZSA9PSBJTVg4
X1BDSUVfUkVGQ0xLX1BBRF9JTlBVVCB8fA0KPiA+ICAJICAgIHBhZF9tb2RlID09IElNWDhfUENJ
RV9SRUZDTEtfUEFEX1VOVVNFRCkgeyBAQCAtMTE4LDE1DQo+ICsxMTUsMzcgQEANCj4gPiBzdGF0
aWMgaW50IGlteDhfcGNpZV9waHlfaW5pdChzdHJ1Y3QgcGh5ICpwaHkpDQo+ID4gIAkJICAgICAg
IGlteDhfcGh5LT5iYXNlICsgSU1YOE1NX1BDSUVfUEhZX0NNTl9SRUcwNjUpOw0KPiA+ICAJfQ0K
PiA+DQo+ID4gLQkvKiBUdW5lIFBIWSBkZS1lbXBoYXNpcyBzZXR0aW5nIHRvIHBhc3MgUENJZSBj
b21wbGlhbmNlLiAqLw0KPiA+IC0JaWYgKGlteDhfcGh5LT50eF9kZWVtcGhfZ2VuMSkNCj4gPiAt
CQl3cml0ZWwoaW14OF9waHktPnR4X2RlZW1waF9nZW4xLA0KPiA+IC0JCSAgICAgICBpbXg4X3Bo
eS0+YmFzZSArIFBDSUVfUEhZX1RSU1ZfUkVHNSk7DQo+ID4gLQlpZiAoaW14OF9waHktPnR4X2Rl
ZW1waF9nZW4yKQ0KPiA+IC0JCXdyaXRlbChpbXg4X3BoeS0+dHhfZGVlbXBoX2dlbjIsDQo+ID4g
LQkJICAgICAgIGlteDhfcGh5LT5iYXNlICsgUENJRV9QSFlfVFJTVl9SRUc2KTsNCj4gPiArCS8q
IFNldCBBVVhfRU5fT1ZFUlJJREUgMSdiMCwgd2hlbiB0aGUgQ0xLUkVRIyBpc24ndCBob29rZWQg
Ki8NCj4gPiArCXJlZ21hcF91cGRhdGVfYml0cyhpbXg4X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhD
X0dQUjE0LA0KPiA+ICsJCQkgICBJTVg4TU1fR1BSX1BDSUVfQVVYX0VOX09WRVJSSURFLA0KPiA+
ICsJCQkgICBpbXg4X3BoeS0+Y2xrcmVxX3VudXNlZCA/DQo+ID4gKwkJCSAgIDAgOiBJTVg4TU1f
R1BSX1BDSUVfQVVYX0VOX09WRVJSSURFKTsNCj4gPiArCXJlZ21hcF91cGRhdGVfYml0cyhpbXg4
X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjE0LA0KPiA+ICsJCQkgICBJTVg4TU1fR1BSX1BD
SUVfQVVYX0VOLA0KPiA+ICsJCQkgICBJTVg4TU1fR1BSX1BDSUVfQVVYX0VOKTsNCj4gPiArCXJl
Z21hcF91cGRhdGVfYml0cyhpbXg4X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjE0LA0KPiA+
ICsJCQkgICBJTVg4TU1fR1BSX1BDSUVfUE9XRVJfT0ZGLCAwKTsNCj4gPiArCXJlZ21hcF91cGRh
dGVfYml0cyhpbXg4X3BoeS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjE0LA0KPiA+ICsJCQkgICBJ
TVg4TU1fR1BSX1BDSUVfU1NDX0VOLCAwKTsNCj4gPg0KPiA+IC0JcmVzZXRfY29udHJvbF9kZWFz
c2VydChpbXg4X3BoeS0+cmVzZXQpOw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5
LT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTQsDQo+ID4gKwkJCSAgIElNWDhNTV9HUFJfUENJRV9S
RUZfQ0xLX1NFTCwNCj4gPiArCQkJICAgcGFkX21vZGUgPT0gSU1YOF9QQ0lFX1JFRkNMS19QQURf
SU5QVVQgPw0KPiA+ICsJCQkgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19FWFQgOg0KPiA+ICsJ
CQkgICBJTVg4TU1fR1BSX1BDSUVfUkVGX0NMS19QTEwpOw0KPiA+ICsJdXNsZWVwX3JhbmdlKDEw
MCwgMjAwKTsNCj4gPiArDQo+ID4gKwkvKiBEbyB0aGUgUEhZIGNvbW1vbiBibG9jayByZXNldCAq
Lw0KPiA+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDhfcGh5LT5pb211eGNfZ3ByLCBJT01VWENf
R1BSMTQsDQo+ID4gKwkJCSAgIElNWDhNTV9HUFJfUENJRV9DTU5fUlNULA0KPiA+ICsJCQkgICBJ
TVg4TU1fR1BSX1BDSUVfQ01OX1JTVCk7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChpbXg4X3BoeS0+
ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ICsJY2FzZSBJTVg4TU06DQo+ID4gKwkJcmVzZXRfY29u
dHJvbF9kZWFzc2VydChpbXg4X3BoeS0+cmVzZXQpOw0KPiA+ICsJCXVzbGVlcF9yYW5nZSgyMDAs
IDUwMCk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCS8qIFBvbGxpbmcgdG8g
Y2hlY2sgdGhlIHBoeSBpcyByZWFkeSBvciBub3QuICovDQo+ID4gIAlyZXQgPSByZWFkbF9wb2xs
X3RpbWVvdXQoaW14OF9waHktPmJhc2UgKw0KPiA+IElNWDhNTV9QQ0lFX1BIWV9DTU5fUkVHMDc1
LCBAQCAtMTU3LDYgKzE3NiwxOSBAQCBzdGF0aWMgY29uc3QNCj4gc3RydWN0IHBoeV9vcHMgaW14
OF9wY2llX3BoeV9vcHMgPSB7DQo+ID4gIAkub3duZXIJCT0gVEhJU19NT0RVTEUsDQo+ID4gIH07
DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBpbXg4X3BjaWVfcGh5X2RydmRhdGEgZHJ2
ZGF0YVtdID0gew0KPiA+ICsJW0lNWDhNTV0gPSB7DQo+ID4gKwkJLnZhcmlhbnQgPSBJTVg4TU0s
DQo+ID4gKwkJLmdwciA9ICJmc2wsaW14OG1tLWlvbXV4Yy1ncHIiLA0KPiA+ICsJfSwNCj4gPiAr
fTsNCj4gDQo+IFBscyBkcm9wIHRoZSBhcnJheS4uLg0KPiANCj4gc3RhdGljIGNvbnN0IHN0cnVj
dCBpbXg4X3BjaWVfcGh5X2RydmRhdGEgaW14OG1tX2RydmRhdGEgPSB7DQo+ICAgICAgICAgLnZh
cmlhbnQgPSBJTVg4TU0sDQo+ICAgICAgICAgLmdwciA9ICJmc2wsaW14OG1tLWlvbXV4Yy1ncHIi
LA0KPiB9Ow0KPiANCg0KT2theSwgdGhhbmtzLg0KPiANCj4gDQo+ID4gKw0KPiA+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBpbXg4X3BjaWVfcGh5X29mX21hdGNoW10gPSB7DQo+
ID4gKwl7LmNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1wY2llLXBoeSIsIC5kYXRhID0gJmRydmRh
dGFbSU1YOE1NXSwgfSwNCj4gDQo+IFNvIHRoaXMgYmVjb21lczoNCj4gDQo+ICAgICAgICAgey5j
b21wYXRpYmxlID0gImZzbCxpbXg4bW0tcGNpZS1waHkiLCAuZGF0YSA9ICZpbXg4bW1fZHJ2ZGF0
YSB9LA0KPiANCj4geW91IGNhbiBkZWZpbmUgbmV3IHN0cnVjdHMgZm9yIG5ld2VyIFNvQ3MNCg0K
T2theSwgd291bGQgZm9sbG93IHRoaXMgd2F5LiBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmlj
aGFyZCBaaHUNCg0KPiANCj4gPiArCXsgfSwNCj4gPiArfTsNCj4gPiArTU9EVUxFX0RFVklDRV9U
QUJMRShvZiwgaW14OF9wY2llX3BoeV9vZl9tYXRjaCk7DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50
IGlteDhfcGNpZV9waHlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgIHsNCj4g
PiAgCXN0cnVjdCBwaHlfcHJvdmlkZXIgKnBoeV9wcm92aWRlcjsNCj4gPiBAQCAtMTY5LDYgKzIw
MSw4IEBAIHN0YXRpYyBpbnQgaW14OF9wY2llX3BoeV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+ICAJaWYgKCFpbXg4X3BoeSkNCj4gPiAgCQlyZXR1cm4gLUVOT01F
TTsNCj4gPg0KPiA+ICsJaW14OF9waHktPmRydmRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoZGV2KTsNCj4gPiArDQo+ID4gIAkvKiBnZXQgUEhZIHJlZmNsayBwYWQgbW9kZSAqLw0KPiA+
ICAJb2ZfcHJvcGVydHlfcmVhZF91MzIobnAsICJmc2wscmVmY2xrLXBhZC1tb2RlIiwNCj4gPiAg
CQkJICAgICAmaW14OF9waHktPnJlZmNsa19wYWRfbW9kZSk7DQo+ID4gQEAgLTE5NCw3ICsyMjgs
NyBAQCBzdGF0aWMgaW50IGlteDhfcGNpZV9waHlfcHJvYmUoc3RydWN0DQo+ID4gcGxhdGZvcm1f
ZGV2aWNlICpwZGV2KQ0KPiA+DQo+ID4gIAkvKiBHcmFiIEdQUiBjb25maWcgcmVnaXN0ZXIgcmFu
Z2UgKi8NCj4gPiAgCWlteDhfcGh5LT5pb211eGNfZ3ByID0NCj4gPiAtCQkgc3lzY29uX3JlZ21h
cF9sb29rdXBfYnlfY29tcGF0aWJsZSgiZnNsLGlteDZxLWlvbXV4Yy1ncHIiKTsNCj4gPiArCQkg
c3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJsZShpbXg4X3BoeS0+ZHJ2ZGF0YS0+Z3By
KTsNCj4gPiAgCWlmIChJU19FUlIoaW14OF9waHktPmlvbXV4Y19ncHIpKSB7DQo+ID4gIAkJZGV2
X2VycihkZXYsICJ1bmFibGUgdG8gZmluZCBpb211eGMgcmVnaXN0ZXJzXG4iKTsNCj4gPiAgCQly
ZXR1cm4gUFRSX0VSUihpbXg4X3BoeS0+aW9tdXhjX2dwcik7IEBAIC0yMjIsMTIgKzI1Niw2IEBA
DQo+IHN0YXRpYw0KPiA+IGludCBpbXg4X3BjaWVfcGh5X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ID4gIAlyZXR1cm4gUFRSX0VSUl9PUl9aRVJPKHBoeV9wcm92aWRlcik7
ICB9DQo+ID4NCj4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14OF9wY2ll
X3BoeV9vZl9tYXRjaFtdID0gew0KPiA+IC0Jey5jb21wYXRpYmxlID0gImZzbCxpbXg4bW0tcGNp
ZS1waHkiLH0sDQo+ID4gLQl7IH0sDQo+ID4gLX07DQo+ID4gLU1PRFVMRV9ERVZJQ0VfVEFCTEUo
b2YsIGlteDhfcGNpZV9waHlfb2ZfbWF0Y2gpOw0KPiA+IC0NCj4gPiAgc3RhdGljIHN0cnVjdCBw
bGF0Zm9ybV9kcml2ZXIgaW14OF9wY2llX3BoeV9kcml2ZXIgPSB7DQo+ID4gIAkucHJvYmUJPSBp
bXg4X3BjaWVfcGh5X3Byb2JlLA0KPiA+ICAJLmRyaXZlciA9IHsNCj4gPiAtLQ0KPiA+IDIuMjUu
MQ0KPiANCj4gLS0NCj4gflZpbm9kDQo=
