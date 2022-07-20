Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A57657AF36
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 05:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242232AbiGTDKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 23:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbiGTDKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 23:10:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707D47171D;
        Tue, 19 Jul 2022 20:07:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE+iZURHHUp9cMTyIydkAX9MQuLW9hAncZtDis10Cdk3qHAh4M26P6E3wMCYbRCPjaAgkqgZiP+An4VLChvsKxBoEr+IctmQLPhV1QbEUEv3KD5wI6nO46TAooFOthiTq3026oleoqsx4ermIhsgCFWYdH4pptgCdJfmtpOvVA7myMwoEov5ZHk5tpzzx6wawY0HGB6/J/JyKIex+MQ6S4TzAWNmKBpulhMDvqdpVZcRlxNFp+/t3yKbp+T3EL/iP0z55fEV2Zg+cI5t0PRS/MeZ9xHPN3Xbx/B+QEWNEzwDOunJ6Ye+4SKa9CtNVuTItFqN16kbcJCr3xiHsNUTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTCHHkOFVu5zZnR568P9Lt+SyeEQ3duQk0C0RN4L/zk=;
 b=I0ITJAk5IzbAJITqWlnbVjXRsPcnMvXFfK7BYpFKbO9tVuqGos9D2ZhOUoDRz6MnEuS0mXNVwRHa5MNaiiwOgV+XygnD0rsZX81TM9Czn6vmapuVb7LeeSfUWveCXLbgYc4KCHmanbTs0iE9Qci9GeMy2shAu0aWsXTDIhmXBDTml1d4QumdCY3s3G8W0NIiTrn4aYCq+maHisI0Mhcaub2AJKMGUtMMLN7zaP01/5trjMLUSN7872ghsYCxVOFnDzavzvQbnepV1ivJsi7FOP1+s5KvBjOWLShZrLUWMcTlJz5up050piAjpTfg2WL54aXpk4W/9OZawgymVDYLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTCHHkOFVu5zZnR568P9Lt+SyeEQ3duQk0C0RN4L/zk=;
 b=QpzSgKMkScGFrQrlKHn+LF/ewbyBNOtySXmp7X5vXbAnyWUqkDqcdO4DR8w90hJUP9BkjIsRr7YPaucSt73o849ZEgx20Bc7vDDmstrIDPMkZ7GVl8WjDEorhU9v9YpPgJFHsfHsNBK7BuVeblfYl0xaBjuvWowV+dsFzO8b644=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB4467.eurprd04.prod.outlook.com (2603:10a6:208:78::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 03:07:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%9]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 03:07:40 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     "tharvey@gateworks.com" <tharvey@gateworks.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC 2/2] PCI: imx6: Support more than Gen2 speed link mode
Thread-Topic: [RFC 2/2] PCI: imx6: Support more than Gen2 speed link mode
Thread-Index: AQHYapxdhAuqFs2pP02KMI8xGlwwK62G0pqAgAAJ42CAABdN8A==
Date:   Wed, 20 Jul 2022 03:07:40 +0000
Message-ID: <AS8PR04MB86764F9B34B88A0950241F668C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
 <1652866528-13220-2-git-send-email-hongxing.zhu@nxp.com>
 <CAJ+vNU0FM_zs9nQ6rX=xNJzsgaH=5WOeNDNCS9rs5VF2Av5eRQ@mail.gmail.com>
 <AS8PR04MB8676EF521BAD0F98AE6CA9DD8C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676EF521BAD0F98AE6CA9DD8C8E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 495100a2-53fe-43e3-5b42-08da69fd0212
x-ms-traffictypediagnostic: AM0PR04MB4467:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Puu/L3QHfH2y19q26ktR1M1VxdbBKIK6dpcJYATm+4JPbMc/F9CQfwxcatvHUwCqnMbHKRCtUPPBgASQ3ELB1FovayRCaYL95THzNpb00t5WcjeE/kNLbDhZMDuhtPyU8TXxiyRD8D2Lmm1WP/UDLq42A4hmyZIchkg7lwAVFj/ix0+KajG6mAVkQyiuDE/9oQtfcPXb23rvYcUISQvXv1tHi+goDS3MM3bBoaeA0L2QHS8dUJqXet/zr08ISYVRzeu1G2Y+esr9ArM7AAS7o58iH48C1OUzbp43d8z8Cith8HwphTw/7IuIPcSLXgk4DrfwAPxBpIZM2FSU1+Sz33QWWLgIRFSZQHG1vDRUCHLeR6qMDyjVTEzHu+PN0QbNaoEbp9BzrRLX5SkS6smBojK1mP+UlIMzU1oyrAmAgOG7mTJ0JnK1y0ONWsl5Ba7+zFBIkDuVr9RGj65IrKb2s82mz2fNal5r3iNTlM4jhlkw6rWFW3tjYZVbifRuaucxVDRgxV2yHUqVWAgtRsC5I2Zov3ftwg6ZYQv8iuh06jroGxHHClGzCGMDRCbqG2Y36pCC8XLk9IyEWMD4q00hFkdz2IxtEy92sofc8af/xcxljo6fV1K+x1V4XTJ2phEXkCyHaOizQA2xpr3DBRV0AugMMotcuuwwfiIYsBMCJDLpSCHJ3D/VjWi5jxYcYeAJ0g4WCBS+VFOdPwBDq6RqxaQPlD1LW/+Hm65C2D6hH39jOIoXtMSonDGG6DNVHjxZOcSW4oeC1sHGsRVWUKOlcjNlSRTu19B3QWz06BOMoAtcdrkURgQam/yZhpI6WwBo3mX4o360ofm1dSOBz57T+sCbQJu7XehbOzBiUmczpsOoyfrAOZ+i9AlLzkj/5xDq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(44832011)(38100700002)(122000001)(55016003)(38070700005)(71200400001)(5660300002)(316002)(6916009)(54906003)(2906002)(45080400002)(86362001)(9686003)(478600001)(8676002)(66476007)(2940100002)(53546011)(83380400001)(76116006)(66946007)(66446008)(186003)(4326008)(66556008)(52536014)(8936002)(966005)(64756008)(7696005)(26005)(6506007)(41300700001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VkpXRmRJR203dFcxRUJuNzVzbGdQZExFbWVRTHg5YXFJOG5rZVc2R2NVelIv?=
 =?gb2312?B?V2U3c2tmeFJCUGZSNTVGUCtyRnhjc09tUkRwQkMxWktKN3dPUFQ0RmdpVGVZ?=
 =?gb2312?B?VFFMZXN1dXYrclNBWlh1WFltSjl1SUN2VXZ6Z2hkZXpNczg5ZWZyWVhyVWlL?=
 =?gb2312?B?VzRjcWZXejZsRnFBdFh5US9yNjFoY09hZVVsSTU3bkJUalM3Rlg0YThaVEVT?=
 =?gb2312?B?Wmk0OUV2YkZCSU01Q1BRMDk0SXovc2xkQnFmeEx3dDZoNVRVWmxUSEYvOXM4?=
 =?gb2312?B?MnM3YUxidE0zN01LS3pRaW1ZTzVaTnZjcWVzUVJISFdYSTliT2R4Y1M0cFVF?=
 =?gb2312?B?MHhwd1lyL2hNR1lhU0pvQ29VYjBmT3Jqclg1TjdMbGdTVXdkTlBFYWxsWThn?=
 =?gb2312?B?ZVdNeXdiQ1IxTEF3SGlLTWdWd3VYNUYyajdKQjkzV2IyaEM3SVdzY080SThJ?=
 =?gb2312?B?ZHovbHNpL2pnY0VkeUF0alFxVWRGNzZEbEVaeCtIaStWWkxQTmh0YmZTS2RN?=
 =?gb2312?B?eHhmN040VUNpRlN2Rlh6VGdYVzI3UElUeElscHhMOGN3UElZbmZ4alBvS0pF?=
 =?gb2312?B?TzkzeVQ4OGRpM0RsbGUyZlcwZUJVeUxXNUtKK3N4bVNGNzByTDBRdW4vem80?=
 =?gb2312?B?N213bkpLNlpJU2IrdlZxVk1UK1V6OUkrUWY0ekpNOGd1QnJKdDZsL0dVcW9h?=
 =?gb2312?B?MUZLL3owZHZvN2NYTHRjTFRkeW44N00vK2cxTTl0SHlUOU1FN1NyRU1MbE1k?=
 =?gb2312?B?d3UzOUxtRGlpaStTbVdvdjkwUlI4dXVRUVM5TTFwWEl1RnBNZEEvSnZRcldh?=
 =?gb2312?B?REZBck5SRlBFRW1GQ0RLRGlUUytlYmVlbDNyeDVJOHpUblVYZzdnK09xMU9m?=
 =?gb2312?B?RFRmKzFvOFMwcWlwd3lvYmx2d1hUNi9nMG5Bbi9OSVZEdmZzbHp0WGltU09Y?=
 =?gb2312?B?RDZ3bFZ1RG9QQ3gxRVZEaktOY0ZReXk5RkM1NjBocy9JNlhQZnVUWE4rMVIx?=
 =?gb2312?B?RE9qeFdVWUlsZXBEdWwrcitDejNBZDBWQUE2NVF2MkVRVWtqQzhsc2w2OTBi?=
 =?gb2312?B?VFRFeHMwVVovOVJIVWZaTzIzWnJnd1dOK1R2cmZwb1MyUWZWdHNCZk5Pd0Fx?=
 =?gb2312?B?RmxsR3VaaFZlbkJEbUY0VnZ3ZGVmaVRwQ1dBbGJnUXpXd0ZmQjhRZ0dGUC9O?=
 =?gb2312?B?T0M0dzZjN1lpUmJuMXE4RFN6Y1AwTDk5ZjJIekZIa3ZvYWxPZ1BaT04zTGpt?=
 =?gb2312?B?c2pEYTN0UldxUlZ5UStmc1RxY2dPYis5ZmNoOWhkTGxORGhSd3VWb2M3OFo1?=
 =?gb2312?B?cCtRMURnK0p0NEtyd0hWU29MOHc5VytUU0kvOHJ0cmtPYnU2SCtObTFkVVB0?=
 =?gb2312?B?aHk2bWNiUjJMeHdYLzc2K0tvMU52SmJtZ2xDQUdxVHNjVkFiWWpwTXY1a3p2?=
 =?gb2312?B?RUY2eG9RZXJPMWFCOGxoZ0ZtVkZic0gzY0RqN09BdDN2YXJDOVhkb0FHdUlT?=
 =?gb2312?B?TWRaNTlQYWxMQ3hTNEhUZmFTQ1FGdnB0RmhFbGVyNndibWpad0tBU2c1L3N6?=
 =?gb2312?B?QTVHLzJPeDE2dndPd1VjTFUvVHdVMEVWM1VRaGpqa0hPSVJSYlJwcnpVSVlu?=
 =?gb2312?B?MEdiTVlGMEhWVW13UTMxZTBwc1ZMOWJ3d2NuWk9VeGU1TGhHem1CVDZkcjNZ?=
 =?gb2312?B?dTVTL2xETkxlK3JmRmhFaDlROFRQYkFCTkFXN2UrMGt5NFZQMmcvOTlTMTBY?=
 =?gb2312?B?bE5xb05pdXRGd0JtcUJEeWRTTE1CSWplWFVjMGhMZ2lBRVdhM0xPa0xrdTk2?=
 =?gb2312?B?WFVQZEY4UnFqV3M3QndTT3plQWZyL3BqaGJxNVV2eks2MzBUQktEL0pJZzZj?=
 =?gb2312?B?S3pLdFFrWmEvck5GbkxMbytmZWJqN01QLzhlMjlNTEZCbUViUHNseHpGMXgr?=
 =?gb2312?B?VEFOY0MrMjExZVRrdUVVV1hJQ2ZLdUFFYi9xUXFBVktZWkVZWXRZNHFyQ1dm?=
 =?gb2312?B?dVA4WVVIbDRlaE5kczNOU2NCUWFSbmpVYUtqV1FJbm9OZFBIZ3lHc3ErYmZl?=
 =?gb2312?B?ZUxZVndRa1NTMG1ZL0k0L2tjZld5cmUzbndmYWJYejBuaVVpM3BMRVhzMFIw?=
 =?gb2312?Q?4n2MdnUqFGSTi9Ax0VrXLrAnJ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 495100a2-53fe-43e3-5b42-08da69fd0212
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 03:07:40.8433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F/Q1AnlUuf+m74Y165+CX0djFDpsWI3WBosEOnvptwWTdTKkUiCWLyWPQMf635CZ9Y9LVMPWVcCuJnhmFWyfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4467
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiBTZW50OiAyMDIyxOo31MIyMMjVIDk6NDQNCj4gVG86IHRoYXJ2
ZXlAZ2F0ZXdvcmtzLmNvbQ0KPiBDYzogTHVjYXMgU3RhY2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBMb3JlbnpvDQo+IFBpZXJhbGlzaSA8bG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbT47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47DQo+
IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEFSTSBNYWlsaW5nIExpc3QNCj4gPGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG9wZW4gbGlzdA0KPiA8bGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZz47IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4
LmRlPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6
IFtSRkMgMi8yXSBQQ0k6IGlteDY6IFN1cHBvcnQgbW9yZSB0aGFuIEdlbjIgc3BlZWQgbGluayBt
b2RlDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogVGltIEhh
cnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KPiA+IFNlbnQ6IDIwMjLE6jfUwjIwyNUgODo1
OQ0KPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IENjOiBM
dWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT47IGJoZWxnYWFzQGdvb2dsZS5jb207
IExvcmVuem8NCj4gPiBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBGYWJp
byBFc3RldmFtDQo+ID4gPGZlc3RldmFtQGdtYWlsLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IExpbnV4IEFSTSBNYWlsaW5nDQo+ID4gTGlzdCA8bGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnPjsgb3BlbiBsaXN0DQo+ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBTYXNjaGEgSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25peC5kZT47DQo+ID4gZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1JGQyAyLzJdIFBD
STogaW14NjogU3VwcG9ydCBtb3JlIHRoYW4gR2VuMiBzcGVlZCBsaW5rDQo+ID4gbW9kZQ0KPiA+
DQo+ID4gT24gV2VkLCBNYXkgMTgsIDIwMjIgYXQgMjo0OSBBTSBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gU3VwcG9ydCBtb3JlIHRo
YW4gR2VuMiBzcGVlZCBsaW5rIG1vZGUsIHNpbmNlIGkuTVg4TVAgUENJZSBzdXBwb3J0cw0KPiA+
ID4gdXAgdG8gR2VuMyBsaW5rIHNwZWVkLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA0ICsrLS0NCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+IGluZGV4IDMwNjQx
ZDJkZGExNC4uMzcwMTJmOWEzM2EwIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gQEAgLTgwOSw4ICs4MDksOCBAQCBzdGF0aWMgaW50IGlt
eDZfcGNpZV9zdGFydF9saW5rKHN0cnVjdCBkd19wY2llDQo+ID4gPiAqcGNpKQ0KPiA+ID4NCj4g
PiA+ICAgICAgICAgZHdfcGNpZV93YWl0X2Zvcl9saW5rKHBjaSk7DQo+ID4gPg0KPiA+ID4gLSAg
ICAgICBpZiAocGNpLT5saW5rX2dlbiA9PSAyKSB7DQo+ID4gPiAtICAgICAgICAgICAgICAgLyog
QWxsb3cgR2VuMiBtb2RlIGFmdGVyIHRoZSBsaW5rIGlzIHVwLiAqLw0KPiA+ID4gKyAgICAgICBp
ZiAocGNpLT5saW5rX2dlbiA+IDEpIHsNCj4gPiA+ICsgICAgICAgICAgICAgICAvKiBBbGxvdyBm
YXN0ZXIgbW9kZXMgYWZ0ZXIgdGhlIGxpbmsgaXMgdXAuICovDQo+ID4gPiAgICAgICAgICAgICAg
ICAgZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsNCj4gPiA+ICAgICAgICAgICAgICAgICB0bXAg
PSBkd19wY2llX3JlYWRsX2RiaShwY2ksIG9mZnNldCArDQo+IFBDSV9FWFBfTE5LQ0FQKTsNCj4g
PiA+ICAgICAgICAgICAgICAgICB0bXAgJj0gflBDSV9FWFBfTE5LQ0FQX1NMUzsNCj4gPiA+IC0t
DQo+ID4NCj4gPiBSaWNoYXJkLA0KPiA+DQo+ID4gSSBub3RpY2VkIHRoYXQgeW91ciBpbXg4bXAg
cGNpZSBzZXJpZXMgWzFdIHdpbGwgZm9yY2UgdGhlIGlteDhtcCB0bw0KPiA+IGxpbmsgb25seSBh
dA0KPiA+IGdlbjEgc3BlZWRzIHVubGVzcyBzdXBwb3J0IGxpa2UgdGhlIGFib3ZlIGlzIGFkZGVk
LiBJIGJlbGlldmUgeW91DQo+ID4gd291bGQgYWxzbyBuZWVkIHRoZSBmb2xsb3dpbmc6DQo+ID4g
LSAgICAgICAgICAgICAgIHRtcCB8PSBQQ0lfRVhQX0xOS0NBUF9TTFNfNV8wR0I7DQo+ID4gKyAg
ICAgICAgICAgICAgIHRtcCB8PSBwY2ktPmxpbmtfZ2VuOw0KPiA+DQo+ID4gV2hlbiBJIHVzZWQg
dGhpcyBhbG9uZyB3aXRoIHlvdXIgaW14OG1wIHNlcmllcyBob3dldmVyIEkgb25seSBnZXQgYSBn
ZW4xDQo+IGxpbmsuDQo+ID4NCj4gPiBIYXZlIHlvdSBtYWRlIGFueSBwcm9ncmVzcyBvbiBhIHYz
IG9mIHlvdXIgaW14OG1wIHNlcmllcz8NCk1pc3Npbmcgb25lIGluIHByZXZpb3VzIHJlcGx5Lg0K
SSBzdGlsbCBkaWRuJ3Qga25vdyBob3cgdG8gZW5jYXBzdWxhdGUgdGhlIFBMTCBiaXRzIHJlbGF0
ZWQgb3BlcmF0aW9ucyBvZg0KIEhTSU9NSVggdG8gb25lIGNsb2NrIHN1Z2dlc3RlZCBieSBMdWNh
cyBbMV0uDQpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXBj
aS9wYXRjaC8xNjQ2NjQ0MDU0LTI0NDIxLTQtZ2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1QG54
cC5jb20vDQpJJ20gcHJlcGFyZSB0aGUgaS5NWCBFUCBSQyBwYXRjaC1zZXQgcmV2aWV3aW5nLCBh
bmQgcGxhbiB0byBsb29rIGF0IGkuTVg4TVANCiBzZXJpZXMgYWZ0ZXIgdGhlIEVQIFJDIHBhdGNo
LXNldCBpcyBzZXR0bGUgZG93bi4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiA+DQo+
ID4gRG8geW91IGtub3cgaWYgdGhlIGRvd25zdHJlYW0gTlhQIHZlbmRvciBrZXJuZWwgWzJdIHN1
cHBvcnRzIGlteDhtcA0KPiA+IEdlbjMgbGlua3M/DQo+IEhpIFRpbToNCj4gVGhhbmtzIGZvciB5
b3VyIHRpbWVseSByZW1pbmRlci4gSSBqdXN0IHdhcyBwdXp6bGVkIGEgd2hpbGUgd2h5IG9ubHkg
R2VuMSBpcw0KPiBsaW5rZWQgdXAgb24gaS5NWDhNUC4NCj4gUm9vdCBjYXVzZSBpcyB0aGF0IEkg
Zm9yZ2V0IG1lcmdlIHNvbWUgbG9jYWwgY2hhbmdlcyB0byB0aGUgdXAtc3RyZWFtIGNvZGVzLg0K
PiBCVFcsIHRoZSBsb2NhbCBjb2RlcyBzdXBwb3J0cyB0aGUgR2VuMyBsaW5rIG9uIGkuTVg4TVAg
QTEgY2hpcCBvciBsYXRlci4NCj4gU2luY2UgdGhlIEEwIGNoaXAgUENJZSBvbmx5IHN1cHBvcnRz
IHVwIHRvIEdlbjIgbGluayBzcGVlZC4NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiBSaWNoYXJkIFpo
dQ0KPiANCj4gPg0KPiA+IEJlc3QgUmVnYXJkcywNCj4gPg0KPiA+IFRpbQ0KPiA+IFsxXQ0KPiA+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRnBhdGMNCj4gPiBodw0KPiA+DQo+IG9yay5rZXJuZWwub3JnJTJGcHJvamVjdCUy
RmxpbnV4LXBjaSUyRmxpc3QlMkYlM0ZzZXJpZXMlM0Q2MjA4ODclMjZzdGENCj4gPg0KPiB0ZSUz
RComYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M5YzdiMTFmMjU5
OQ0KPiA+DQo+IDY0NWY2MmRkNjA4ZGE2OWViMTQ1NSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5
YzVjMzAxNjM1JTdDMCU3DQo+ID4NCj4gQzAlN0M2Mzc5Mzg3NTU2Mjk5NjIzMDclN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzQNCj4gPg0KPiB3TGpBd01EQWlMQ0pRSWpvaVYybHVN
eklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3DQo+ID4NCj4gQyU3QyU3
QyZhbXA7c2RhdGE9STNQd25STzU2alY3eUtXMEFsMTZDJTJGJTJGWTVHdXBpeUlpZmRLJTJGRTIN
Cj4gPiAyQWlTcyUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+IFsyXQ0KPiA+DQo+IGh0dHBzOi8vZXVy
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnNv
dXJjZS4NCj4gPg0KPiBjb2RlYXVyb3JhLm9yZyUyRmV4dGVybmFsJTJGaW14JTJGbGludXgtaW14
JTJGJmFtcDtkYXRhPTA1JTdDMDElNw0KPiA+DQo+IENob25neGluZy56aHUlNDBueHAuY29tJTdD
OWM3YjExZjI1OTk2NDVmNjJkZDYwOGRhNjllYjE0NTUlN0M2OA0KPiA+DQo+IDZlYTFkM2JjMmI0
YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3OTM4NzU1NjI5OTYyMzA3JTcNCj4gPg0K
PiBDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUDQo+ID4NCj4gaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0Ml
N0MmYW1wO3NkYXRhPVBVdWwlMkY4Yg0KPiA+IDYlMkZ0UmpKTUhPT0hjbTdKYjFCWHdHaSUyRlZu
TG5XbUtDZU5lbzQlM0QmYW1wO3Jlc2VydmVkPTANCg==
