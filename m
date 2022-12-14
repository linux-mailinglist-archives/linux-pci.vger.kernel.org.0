Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16B664C250
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 03:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiLNCms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 21:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbiLNCmp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 21:42:45 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2055.outbound.protection.outlook.com [40.107.215.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BEECE9;
        Tue, 13 Dec 2022 18:42:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0+PqCBbBJc/WDBGlwVCOf0IY84Zc7q7cDpmQLG0jlzwDdByz4IIoxe/DNkGN3LLcMmDU3bPHchnzC6p7w4baNPXncwhKzHI8mUm1eK91nbFYK5NAngiYqx4PHyPi5iWyXgIXzsUPC+7ERWViwSCTFo6DDe+7MTPMqcufcRC8wrWvFycXbo+QEAG8y8ZQTgljDe/7kLS8ZcuG6adCyMZRCqvm50c1JrXCAJ347suUwA81Fk84xhowAjTlVtJQzmTxdbFGQSuiI206yjA8ATx0sYlpLT3AeZQ+pHizYJyRsKwZqduA0SL4+moUGqz10ZrXffZs0dDDLgU5brbDBPCjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dg2GEQuCbowR+Xm6EbSC5QlpglhIS8YVWHPwX3ekKI=;
 b=USm84CElyg6DnqHwIgbLI34FhLRCAuBfWXGKRlBGu8hqoDvhDNBX8FOVUpzgYDgTYPIsrIt4GHG0je8fcLBG/74vzO1aJKhmssn84hKnWEh9df3vgT0ppim1N7NtYEDnDSNI5xzrrUEglEcKuqXjmyp03iC+vvg+RRGU6T7MmOEuXWKKZU21vS6aQ8GHXnDw8vLQbAhXYW4iXeEuSiFotLBFqtYjQNfXEcQl54J2k+S2itPDvVSDge70V4Vi9+1a+FebieyQYJ8DvMasVekloAuT9mjgTzL3b2qARHPXGnPzypjqr5MZ+RA0HoryWFiPpSGqerkXOj2HD+1M4mWCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dg2GEQuCbowR+Xm6EbSC5QlpglhIS8YVWHPwX3ekKI=;
 b=aUlneYlBvs2wrOwFU/bQW6KoZfQhp4ZdcYW3gNphjKUWv1xOyCR8rLgq7Aar/3N4s0YSBVJqHHaHFKYYyvWGBi+4ElRMEYXXGWlGsDa3Fxbip9ZBCtW497Rr3+BtNFJDFkrXp53x30Nc+9z/uecS4PM+IBUS+B/CNV1ULmRGGfT1ssXOXxrv0aqRuXjUhgbh1xgDdCscP3qBVGptOAfj0qDDEekOaIzScGlZBQ8Eo2pKxPuiKnqB06LidjOjyL2r0MbAY1rkLAQMZi7xsTJrEuwrhFkMkrr+MmMp0d7O7zfHx+5TgYTnYXqwVgxvTQFxlXQil13SUZEoYumu9tPxJA==
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com (2603:1096:301:2b::5)
 by KL1PR0601MB5447.apcprd06.prod.outlook.com (2603:1096:820:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 02:42:36 +0000
Received: from PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::dbda:208a:7bdb:4edf]) by PSAPR06MB3942.apcprd06.prod.outlook.com
 ([fe80::dbda:208a:7bdb:4edf%8]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 02:42:36 +0000
From:   Liming Wu <liming.wu@jaguarmicro.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "398776277@qq.com" <398776277@qq.com>
Subject: RE: [PATCH] PCI/IOV: Expose error return to dmesg
Thread-Topic: [PATCH] PCI/IOV: Expose error return to dmesg
Thread-Index: AQHZDsszYjQ+53GopUaS8VK+5B1xya5rhXcAgAAIcECAACSggIAA+XPg
Date:   Wed, 14 Dec 2022 02:42:36 +0000
Message-ID: <PSAPR06MB394213632342F7F4D437FF85E1E09@PSAPR06MB3942.apcprd06.prod.outlook.com>
References: <20221213081607.1641-1-liming.wu@jaguarmicro.com>
 <Y5g/eo3Z7xy3COzn@unreal>
 <PSAPR06MB3942A2CFB519F5F3BB6DE6B7E1E39@PSAPR06MB3942.apcprd06.prod.outlook.com>
 <Y5hlR9Otgvf9b6zF@unreal>
In-Reply-To: <Y5hlR9Otgvf9b6zF@unreal>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB3942:EE_|KL1PR0601MB5447:EE_
x-ms-office365-filtering-correlation-id: 1d70f0b9-c7fa-4e6b-9e2a-08dadd7cdc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5po2Exh++SBKdNhGsdNlc0hFBJ4mdiLhhfb8VsquDPILrO1JxipyQN/KWru87uBLSjWgJMB3rIcaG0LQTCc36vJoUbQHJfpWGrZJzo5V08knolOAmo21WvnO2TaV+uyX3sY/9jKDhMWlou38f3b1nJUwslNO73nbhvTeTPKA2SFkd0q2tCL53d2SF71sUceUgcngO0VIGr12DbxGQ1L66dCTwObL30RF2PtmbXYT2202N627TBesO3s8MV+4bWjsQIg65q7sTLgLJILqty5VXAPLPL1Kgks9Zt6+ovN7xC8fhZ8AkFiEAvJtemAZhfMm3+j5Sm96RRkNm59dtscAPTvEIC6vqpuR9HaXm7nTAo27fx+L5hj04GhqpQTJN8QjHCL2zKmqjQagztWFbbsF0cvV+9N6xVYf5QxK15Y1MJ1Z5ZHAY47tNl7tJ7jg67V8dCw81kO6fmyX+TY9rzLjbbmBZazQSnuN80scNQfzealh205HZyOOUfGd5J3+2U/IWgncQbHxyrxwxsP5idbAhu/3ylot3tbU+whlXawZodRyMFY45uEW+bCn4Mqd62f59CaXKTJQMYX8HibKquRBi1XoqeFOsty5FvNigB5lV4yR1pwibIpTSiVq/LMcevuJ8Vp5bZqI1ElWeZCovU56vXbRSFVg3moyKHfeqTzd85n9WX5qa+qzZYL/8NGtCS52FgS2GrmbTLPvlNQci4z0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB3942.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39840400004)(136003)(396003)(451199015)(71200400001)(478600001)(41300700001)(38100700002)(122000001)(86362001)(7696005)(26005)(6506007)(9686003)(186003)(66946007)(8676002)(4326008)(8936002)(55016003)(2906002)(66556008)(66446008)(76116006)(64756008)(53546011)(33656002)(316002)(38070700005)(44832011)(5660300002)(66476007)(83380400001)(52536014)(54906003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?eld2enRXckdtM1RuTnZKdWwwQ1NtYk5QSDZEaWMwYzZmdUIzelNtMnRKQjBJ?=
 =?gb2312?B?ZUhrM25qdDhIZCtQbkRMMmhQV3E1dXZLK0lIMklVRE9POWM1Z1lhcVZTYXB5?=
 =?gb2312?B?emNMT1FsdEVraG5LNml5djhhK2dSUFhuVmpmOXJvTys4THF4cFhEM2JteUp3?=
 =?gb2312?B?S1pjWlRkTE1OQzJnUEVINjJiY3ZtdjhocjB2QUFHNFc4dVVSWHRoVUdUaVRT?=
 =?gb2312?B?Wlloa2R2N2tGbW0wdGRrdHNaeWk3Sm55VjRHSjI4ZWFqSFEycVFtcStya3hG?=
 =?gb2312?B?eTBnc3pyK1VGMEdDVThnNy91OWFCU3lET3pPcHppU0o2QzZuT0dscjZtVlVk?=
 =?gb2312?B?c1NIR2MzQnd4NlZrVkVkOHBLRTE3dytmSVNXWEJmVDJTQVpENVBXS2MzWVhp?=
 =?gb2312?B?ZVRRcmplYjMvQ003RVUvSm1vT2xTMTVFdVZLL01lelZrY3J2My9HQzRreCtT?=
 =?gb2312?B?MWx5d2YvczhRM3ZTMWpiMmJSM0dXVTR3OEh1MHAvOFhpR3BFcTNKeHdadUxv?=
 =?gb2312?B?KzBpOU8rMVV1QmZHQ0lXOGErMHY1RVNZUksyU2JTVjRRTDVYYmRYcWgrMjl6?=
 =?gb2312?B?bEhKVm8zZW02eEptbjNzZHVXdEFGbmNFL3pBajkzeWh2WGZGMys0MG15VHRW?=
 =?gb2312?B?N1dhVk1MaHVpeTJQeG1qaW9kTUVuaUx4d2xkN0Z0cUw1QTQ2bTlqY1JOdUgy?=
 =?gb2312?B?RkdSYnk0Rk4xMldRYmExdTVNaDVadGVyZi9TSFBIdU8rR1RlTXdWZ0p6UDRP?=
 =?gb2312?B?bUJiSTgyWlpQbkk4M043bzB3U3B5cCtaZHhVbitFdFZQY0xlSHZqbVdZUUlJ?=
 =?gb2312?B?RnkrVDhpaUVKU0E1NnBzOWh5RUs3eFRPN2I2eTFyN05zSFp0QlJDQVpNa3h0?=
 =?gb2312?B?OVZ5dUkyTDNpYUtNWW1JMHRGNkIzUkxWT2oxYjN6ZVAyLytTeTBHdmo3YytD?=
 =?gb2312?B?UG9Ia3M0QTdmRnB0bmdrdUtHQzhJQmVBZkN6TFZXU2JIRTFNNXFsL0ZucDJZ?=
 =?gb2312?B?TDhwOXFuWGZiRDNYemVibW1Ga0tub2VqY1lPNEtUYnNjU2J2NjlDbzhwRmJT?=
 =?gb2312?B?VGxRdi84c1FMaFYyeWVXVzNlWHBac2xpbXM5eThQQ2kvaUxpMlZFTG12dkx1?=
 =?gb2312?B?cnNXUWJzWHp4ekJ0ZTRkVzZCQkMyL1o1Q21YZGRlelJDamxYSWFyY05KZDZp?=
 =?gb2312?B?ZWtZaVpob0hIOFAxTG1nT0xuOTYyWGJmU2tEWUF3OTBtRmM2ZVJlb1U4aWN0?=
 =?gb2312?B?bVVZVEN3MFZMWlpYbTZGVjJPSm0rL0kyRy8zc3ovUUhScjBkSTJGV1IxdXFY?=
 =?gb2312?B?V0xCaWRyUW5RSzN3K1ZiOTg2LzF1YWk0T2Q1YzFsNnk1RUloY25vN1UyWFJO?=
 =?gb2312?B?Z2xnY0tTazFtd2gxeGNuL08xTkV4bnBiL3hOb2g2eGVFSnRCSy83aUVOM3JP?=
 =?gb2312?B?bGhaa0JyYVhmMFIweDN3M25wdm5BWFJWWTNhcld1cERLeitmMENEQktnWGdi?=
 =?gb2312?B?WXN1SDVsT2p5L3FFZHlqbWVVdFVEZkRSaFhTeFQ5TGhSSGZWQXBLcFJRcmgy?=
 =?gb2312?B?NGRLNU8wQmsyNnJWNXVja3hqSXJFZHV2NjRkOTlEbW40b2xsa0g3U21kUzNa?=
 =?gb2312?B?WVlZell0Q3BPNFNKYi95eGpLdzZSQ2dnUFVFMnFmMGxoQ2g5UGoxZVhRdE1j?=
 =?gb2312?B?YW53cEtuT0NrTFByWWQrMjJQd25UZTc0WDBYSVcwRzdGZjNLOHFub01FZUM0?=
 =?gb2312?B?MHpKVGlldWZCUjdDdUo2UjR6SWZYOW5SN1FHeHdILzNwVER4S2lDWlg3QkNJ?=
 =?gb2312?B?YkNGZWpWQXEwbUJoVkhwSzAya245LzJhVHhUY3NsVW96UXBlaXlIT2hrNHBB?=
 =?gb2312?B?Y2t1TklsS2ZwYTlrTnhZTnh6VGp3NXdBZE5uZTc5MWJhQzRHYnJXcm1jejND?=
 =?gb2312?B?SzJxcXI0NSt6UExxV1lwMWk2anB4VEpFWkp0bkJoMFNOREFLVXc0NGtENWox?=
 =?gb2312?B?ZW9BWHA0Q1AzRDVYeEowSjVMdzQvdFY0ZnYzOXZnREE2UUdMMTM1K21FS3BC?=
 =?gb2312?B?d2t1MEI0MDNiRE1iYXlER25taThMMjZDYnR6aW90UlkySldMTks0Z24xbkt3?=
 =?gb2312?B?aFRZL3NSK0hTTFFhMVlGcUNMbDh0RGI1MHZWdGR0aENEcHpwZXVpMXNpcU9x?=
 =?gb2312?B?MEE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB3942.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d70f0b9-c7fa-4e6b-9e2a-08dadd7cdc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 02:42:36.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LdNTxXERnTeAFhNLHK75S6fBVmcfPtznEcS8SYEzkLu5soy4yqJ9uZVX+71/DcL1Jy38i7ziMKtf5w3N+9lrhhz6MvVaUi79MbZRXJpqlc0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5447
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVvbiBSb21hbm92c2t5
IDxsZW9uQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEzLCAyMDIyIDc6
NDMgUE0NCj4gVG86IExpbWluZyBXdSA8bGltaW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4NCj4gQ2M6
IGJoZWxnYWFzQGdvb2dsZS5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgMzk4
Nzc2Mjc3QHFxLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0kvSU9WOiBFeHBvc2UgZXJy
b3IgcmV0dXJuIHRvIGRtZXNnDQo+IA0KPiBPbiBUdWUsIERlYyAxMywgMjAyMiBhdCAxMTozMzoy
N0FNICswMDAwLCBMaW1pbmcgV3Ugd3JvdGU6DQo+ID4gSEksDQo+ID4NCj4gPiBUaGFua3MgZm9y
IHJldmlldyBpdC4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+
IEZyb206IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogVHVl
c2RheSwgRGVjZW1iZXIgMTMsIDIwMjIgNTowMiBQTQ0KPiA+ID4gVG86IExpbWluZyBXdSA8bGlt
aW5nLnd1QGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBs
aW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiA+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyAzOTg3NzYyNzdAcXEuY29tDQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0kvSU9WOiBFeHBvc2UgZXJyb3IgcmV0dXJuIHRvIGRt
ZXNnDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBEZWMgMTMsIDIwMjIgYXQgMDQ6MTY6MDdQTSArMDgw
MCwgTGltaW5nIFd1IHdyb3RlOg0KPiA+ID4gPiBUaGVyZSBhcmUgbWFueSBlcnJvcnMgcmV0dXJu
ZWQgZHVyaW5nIHRoZSBpbml0aWFsaXphdGlvbiBvZiBzcmlvdiwNCj4gPiA+ID4gc3VjaCBhcyAt
RUlPLy1FTk9NRU0sIGJ1dCB0aGV5IGFyZSBub3QgZXhwb3NlZCB0byBkbWVzZy4NCj4gPiA+ID4g
TGV0J3MgZXhwb3NlIHRoZSByZWFsIGVycm9ycyB0byB0aGUgdXNlci4NCj4gPiA+DQo+ID4gPiBQ
bGVhc2UgcHJvdmlkZSBtb3RpdmF0aW9uLiBJdCBpcyBwcmV0dHkgZWFzeSB0byBzZWUgd2hhdCB3
ZW50IHdyb25nDQo+ID4gPiBldmVuIHdpdGhvdXQgaW5mbyBwcmludCBpbiBkbWVzZy4NCj4gPiBU
aGUgYmFja2dyb3VuZCBpcyB0aGF0IHdlIHVzZSBvdXIgc21hdCBuaWMgaW4gdGhlIEFSTTY0IGFy
Y2hpdGVjdHVyZQ0KPiA+IHNlcnZlciBUaGUgZm9sbG93aW5nIGNvZGUgaW4gdGhlIHNyaW92X2lu
aXQoKSBmdW5jdGlvbiB0aHJldyBhbg0KPiA+IGV4Y2VwdGlvbg0KPiA+DQo+ID4gaWYgKHJlc291
cmNlX3NpemUocmVzKSAmIChQQUdFX1NJWkUgLSAxKSkgew0KPiA+DQo+ID4gVGhlIHJlc291cmNl
IHNpemUgb2J0YWluZWQgZnJvbSBzbWF0IG5pYyBpcyA0MDk2KGl0J3MgaW5jb3JyZWN0bHkgc2V0
IHRvIGEgZml4ZWQNCj4gdmFsdWUgaW4gbmljKS4NCj4gPiAgQnV0IHRoZSBQQUdFX1NJWkUgaXMg
NjU1MzYsDQo+ID4gc28gc3Jpb3ZfaW5pdCgpICBleGl0cywgYnV0IHRoZSByZWxldmFudCBleGNl
cHRpb24gaW5mb3JtYXRpb24gaXMgbm90IGZvdW5kIGluDQo+IGRtZXNnLg0KPiANCj4gSXQgaXMg
bm90IG1vdGl2YXRpb24sIGJ1dCBzdW1tYXJpemluZyBIVyBidWcgZm91bmQgZHVyaW5nIGRldmlj
ZSBicmluZ3VwLg0KPiBXaHkgc2hvdWxkIHdlIChhcyB1c2Vycykgc2VlIHRoaXMgcHJpbnQgaW4g
dXBzdHJlYW0ga2VybmVsPw0KQWdyZWVkLg0KDQo+ID4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gYWRk
aXRpb24sIC1FTk9ERVYgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UgYW5kIGlzIG5vdCByZXR1cm5l
ZA0KPiA+ID4gPiBqdXN0IGxpa2UgYW55IG90aGVyIGNhcGFiaWxpdGllcy4NCj4gPiA+ID4NCj4g
PiA+ID4gU2lnbmVkLW9mZi1ieTogTGltaW5nIFd1IDxsaW1pbmcud3VAamFndWFybWljcm8uY29t
Pg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL2lvdi5jICAgfCA5ICsrKysrKy0t
LQ0KPiA+ID4gPiAgZHJpdmVycy9wY2kvcGNpLmggICB8IDIgLS0NCj4gPiA+ID4gIGRyaXZlcnMv
cGNpL3Byb2JlLmMgfCA2ICsrKysrLQ0KPiA+ID4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvaW92LmMgYi9kcml2ZXJzL3BjaS9pb3YuYyBpbmRleA0KPiA+ID4gPiA5NTIy
MTc1NzIxMTMuLjUxOWFhMmI0ODIzNiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kv
aW92LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvaW92LmMNCj4gPiA+ID4gQEAgLTc2Nyw4
ICs3NjcsMTEgQEAgc3RhdGljIGludCBzcmlvdl9pbml0KHN0cnVjdCBwY2lfZGV2ICpkZXYsIGlu
dCBwb3MpDQo+ID4gPiA+ICAJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgcG9zICsgUENJX1NS
SU9WX0NUUkwsIGN0cmwpOw0KPiA+ID4gPg0KPiA+ID4gPiAgCXBjaV9yZWFkX2NvbmZpZ193b3Jk
KGRldiwgcG9zICsgUENJX1NSSU9WX1RPVEFMX1ZGLCAmdG90YWwpOw0KPiA+ID4gPiAtCWlmICgh
dG90YWwpDQo+ID4gPiA+ICsJaWYgKCF0b3RhbCkgew0KPiA+ID4gPiArCQlwY2lfaW5mbyhkZXYs
ICJTUi1JT1YgY2FwYWJpbGl0eSBpcyBlbmFibGVkIGJ1dCBoYXMgJWQgVkZzKVxuIiwNCj4gPiA+
ID4gKwkJCXRvdGFsKTsNCj4gPiA+DQo+ID4gPiB0b3RhbCBpcyBhbHdheXMgMCBpbiB0aGlzIHBy
aW50Lg0KPiA+IFNwZWMgZGVzY3JpYmUgUENJX1NSSU9WX1RPVEFMX1ZGIHJlZyAoVG90YWwgVmly
dHVhbCBGdW5jdGlvbnMpIGFzIGJlbG93Og0KPiA+IEluZGljYXRlcyB0aGUgbWF4aW11bSBudW1i
ZXIgb2YgVmlydHVhbCBGdW5jdGlvbnMgKFZGcykgdGhhdCBjYW4gYmUNCj4gPiBhc3NvY2lhdGVk
IFdpdGggdGhlIFBoeXNpY2FsIEZ1bmN0aW9uIChQRikuDQo+ID4gVGhpcyB2YWx1ZXMgaXMgSFdJ
bml0IGluIFNpbmdsZSBSb290IG1vZGUgYW5kIG11c3QgY29udGFpbiB0aGUgc2FtZQ0KPiA+IHZh
bHVlcyBhcyBJbml0aWFsVkZzIEluIE11bHRpLVJvb3QgbW9kZSwgdGhlIE11bHRpLVJvb3QgUENJ
IE1hbmFnZXIoTVItUENJTSkNCj4gY2FuIGNoYW5nZSB0aGlzIHZhbHVlcy4NCj4gPg0KPiA+IEkg
ZG9uJ3QgdGhpbmsgdG90YWwgaXMgYWx3YXlzIDAgaW4gdGhpcyBwcmludCBmb3IgaXQgaGFzIGJl
ZW4gY29uZmlybWVkIHRvIGhhdmUgIFNSLQ0KPiBJT1YgY2FwYWJpbGl0eSBFbmFibGVkLg0KPiAN
Cj4gWW91IGFkZGVkIHByaW50IHVuZGVyIGlmKCF0b3RhbCkgY29uZGl0aW9uLiBUaGUgIlNSLUlP
ViBjYXBhYmlsaXR5IGlzIGVuYWJsZWQgYnV0DQo+IGhhcyAlZCBWRnMiIHdpbGwgYWx3YXlzIHBy
aW50ICJTUi1JT1YgY2FwYWJpbGl0eSBpcyBlbmFibGVkIGJ1dCBoYXMgMCBWRnMiDQpZZXOjrCBJ
IGp1c3Qgd2FudCB0byBzaG93IHRoaXMgdG8gdXNlcnMuICBWRnMgb2YgMCBpcyBub3Qgbm9ybWFs
LiANCkEgbWVzc2FnZSBpcyBkaXNwbGF5ZWQgaW5kaWNhdGluZyB0aGF0IHRoZSBoYXJkd2FyZSBT
ZXR0aW5ncyBtYXkgYmUgaW5jb3JyZWN0Lg0KDQo+ID4NCj4gPiBNeSBhcm02NCBTZXJ2ZXIgZG1l
c2cgYXMgZm9sbG93Og0KPiA+ICMgZG1lc2cgLVQgfGdyZXAgLUIgMSAtaSB0b3RhbF92Zg0KPiA+
IFtUdWUgRGVjIDEzIDA0OjAyOjM0IDIwMjJdIHBjaSAwMDAwOjA3OjAwLjA6IHJlZyAweDE4OiBb
bWVtDQo+ID4gMHg4MDAwMWMwMDAwMC0weDgwMDAxYzAwZmZmIDY0Yml0IHByZWZdIFtUdWUgRGVj
IDEzIDA0OjAyOjM0IDIwMjJdDQo+ID4gZHJpdmVycy9wY2kvaW92LmM6IDYzMiBbaW5mb106IHJl
YWQgUENJX1NSSU9WX1RPVEFMX1ZGIDI1NQ0KPiA+IC0tDQo+ID4gW1R1ZSBEZWMgMTMgMDQ6MDI6
MzQgMjAyMl0gcGNpIDAwMDA6MDg6MDAuMDogcmVnIDB4MTg6IFttZW0NCj4gPiAweDgwMDAxYTAw
MDAwLTB4ODAwMDFhMDBmZmYgNjRiaXQgcHJlZl0gW1R1ZSBEZWMgMTMgMDQ6MDI6MzQgMjAyMl0N
Cj4gPiAtLQ0KPiA+IFtUdWUgRGVjIDEzIDA0OjAyOjM0IDIwMjJdIHBjaSAwMDAwOmRkOjAwLjA6
IHJlZyAweDE4OiBbbWVtDQo+ID4gMHg0MDAxMjAwMDAwMDAtMHg0MDAxMjAwZmZmZmYgNjRiaXQg
cHJlZl0gW1R1ZSBEZWMgMTMgMDQ6MDI6MzQgMjAyMl0NCj4gPiBkcml2ZXJzL3BjaS9pb3YuYzog
NjMyIFtpbmZvXTogcmVhZCBQQ0lfU1JJT1ZfVE9UQUxfVkYgMA0KPiA+DQo+ID4gPg0KPiA+ID4g
PiAgCQlyZXR1cm4gMDsNCj4gPiA+ID4gKwl9DQo+ID4gPiA+DQo+ID4gPiA+ICAJcGNpX3JlYWRf
Y29uZmlnX2R3b3JkKGRldiwgcG9zICsgUENJX1NSSU9WX1NVUF9QR1NJWkUsICZwZ3N6KTsNCj4g
PiA+ID4gIAlpID0gUEFHRV9TSElGVCA+IDEyID8gUEFHRV9TSElGVCAtIDEyIDogMDsgQEAgLTg5
OSwxMyArOTAyLDEzIEBADQo+ID4gPiA+IGludCBwY2lfaW92X2luaXQoc3RydWN0IHBjaV9kZXYg
KmRldikNCj4gPiA+ID4gIAlpbnQgcG9zOw0KPiA+ID4gPg0KPiA+ID4gPiAgCWlmICghcGNpX2lz
X3BjaWUoZGV2KSkNCj4gPiA+ID4gLQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gPiA+ICsJCXJldHVy
bjsNCj4gPiA+DQo+ID4gPiBQbGVhc2UgYXQgbGVhc3QgY29tcGlsZSBwYXRjaGVzIGJlZm9yZSB5
b3Ugc2VuZCB0aGVtLg0KPiA+IE9LLCB0aGFua3MuDQo+ID4gSG93IGFib3V0IHJldHVybiAwLCBv
ciBhbnkgb3RoZXIgc3VnZ2VzdGlvbnMuDQo+IA0KPiBEcm9wIHRoZSBwYXRjaCBhbmQgbGVhdmUg
dGhpcyBjb2RlIGFzIGlzLg0KT0ssIFRoYW5rcw0KDQoNCg==
