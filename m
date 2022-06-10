Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89726545CA7
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbiFJGvs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiFJGvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 02:51:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D823142;
        Thu,  9 Jun 2022 23:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND8mSr5yq2Zfsk1FPbpif6q8KCUjf734gk4LUMu0JACJBmVKDHSgjkkeKoaO1ZoLbei9onpt/EUfko+mAcsQOSSK38B6rSlluCleJDIiI9osvhsbOsUNGrwVtdH3hAHCsv488SNYYCumQFNSZVRWIY85MxWEqy3bDy0UN7AP6GMaAatBgXjgbYrbnrLsju1NWNExGLGj9V+DkRUbLYs/A2e++6uLWId/GyhJ4EYwb5ZBLgNbgPow0unu6rM9ofLrkGCZU1UZ5tR7/Hr7cv7ZrptKdurmgucndhl0KedrsrexOI8ZWgNUcrLAsNKmFaC3I3A8Drr8r44qGHB44XQ84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gip2Lj0egGJb/XGqo9jm92CW+if8lViiZ0MNnc8J5N0=;
 b=UtH7vdh/5notGfz6oGlKQqNgNc18gGkzFe7jXDIQlTEBtFZUJQ7jUMGvGmCXP2RoTux/PmRdGi4lyqqW/n0NQ9B7rzdb41sP8SW3OSE3BaebMXQLjU3MIdGUuFHIx3uquS06vK9yXNm8n/aCp824H7SFmRrEbKTk0+c064annlhqSuinw/qPQLAfnQDshcx84alUfTPXxvbh1XhKm1A9VchMTfENSauaZyAeZTIcNm/j/NLaOjdhA6YLL3KtvpxpMzI4XuOZZXPjBI5mx3tK+7Irwx8ST0D5ajLuHEJbQhn+eB+ncjyZ9q6XTL/r00s1b3OWQckQJZ1bdLr5eDIkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gip2Lj0egGJb/XGqo9jm92CW+if8lViiZ0MNnc8J5N0=;
 b=QMEDj1Pw5a/ZdfnkkOmp6PYDmY3QFtpfw7RJDJJN8tliI2IG8C+weNbYB9Up72orC0Wse+KW5mjxBBftmkm0j0y+fVfUUtQ2CDO0v/fdCvyJHCPWsmcprNTwwypgLbfTDe4J8tFCHd2cyMcnceIONbnpWKDTR1hIhrOOWcVgid8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Fri, 10 Jun
 2022 06:51:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 06:51:41 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Thread-Topic: [PATCH v9 7/8] PCI: imx6: Move the phy driver callbacks to the
 proper places
Thread-Index: AQHYYOzlA5pwlzpYQUSX/QC6T/qeLK1GEXcAgACKSxCAAN2QAIAA8clw
Date:   Fri, 10 Jun 2022 06:51:41 +0000
Message-ID: <AS8PR04MB8676D48C33E9C7A375CA34938CA69@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB86768DB1E04AAE3D63E8BE618CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220609162552.GA514635@bhelgaas>
In-Reply-To: <20220609162552.GA514635@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 345d7862-246a-4576-26f7-08da4aadad01
x-ms-traffictypediagnostic: VI1PR04MB7197:EE_
x-microsoft-antispam-prvs: <VI1PR04MB7197C62065680E1962F2276D8CA69@VI1PR04MB7197.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KOhFsSSlAfGzhvakfX0lDh3SrThF6FshbaKv4qWcgMBj1qElpPyMr9srWTND2sPYXmlpjHmGD0DfIfMkMOeKS8SO77M62Lq8EEq91Z7QQkpb2xdV6Qbp1cnIepEN0tOEuCaStane9PZSHa7en6tXDepMFUDE5odt83rcvSPHERz1AH1zEaB0zNZyilY23bjXzctPAKEBNl3WMQIWLY3yyMBbGGpbRA5rPkBEAtlWePYtXbHmMMMASbqGBfVsYCCiDa4KKWkqIU6TAMe4Md7nJ5n85uEHv91v16tIU/i3IUo2zv5lAm1shX54O1wr+zQIibLKQEw/pCAiKsVnQSnwTthDycFJ52OP8aRJdYqIWNrrSkDLBLoxRJKzemX63hcJX40h+u46PSNowq4T9ACX9GP7wRyVgmLu0OHmfhREefZf6j15maUZenWU2rtXPLxKbSqlpEoHurqh7avSlKJ7V8vekcqL3AdtRATHOZfYRkVRhn93mpees2ckf57xfCEKdHkxjt3CZ9+nydAVejCZ6GeZXaMKqkT1j0w7la383MgCXZx/aXwh+VutzCObfM2sVDIIZDDZHWncEOJ4rAEhkGNDRYUPYCkXW9qR68JxMpXZeN+0ntv5+Qtc5i5CjFih6Giy30t36W0bwCIKghXyRofOf9o++hZ508vdBa8TA//QmMbhA2KCpRgKh0xobul2j8+aFqcgXGa4Tv/dmhHZqemhR3BIsP7l2kyXFzirCTWWHj5JF8qWqiwO7q/UYCMzA3xu13RAYMgUwiUJwb9p0aOV/Vq7ScJoX52QpFWZiBo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(64756008)(8676002)(4326008)(8936002)(2906002)(66446008)(52536014)(66476007)(66556008)(53546011)(26005)(186003)(966005)(83380400001)(76116006)(66946007)(33656002)(71200400001)(508600001)(5660300002)(7416002)(316002)(6916009)(122000001)(45080400002)(54906003)(38100700002)(38070700005)(44832011)(86362001)(6506007)(55016003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZDhnUTd5UXFBcGRweHNMSXBGMlFiZUxvbjNwS2lBN1lmNmpvOU4yaDhkN2Nj?=
 =?gb2312?B?a1ZGNHZEbzZoRWZqbWpqK09mcjV3WVlBWFdaTnMzbnJsdy8yVWNkWi95MGRh?=
 =?gb2312?B?ZkN4a0orNkFxd3YzNUtBbFptYmVwV1hIZ2tudFpsNnA2TVRqcXVRNXdueUNO?=
 =?gb2312?B?UDJpRnBwK1VDM1ZNSmtQcldLclFreGZ0MGpURjF5L1BOUEJvMXVlQ0Foc0Zh?=
 =?gb2312?B?UitDUkJmc1F3blpRQWtMbDFBKzFYWVpQd015L0l3WGxYZ1NUajZ5Y0hHRW9h?=
 =?gb2312?B?RDFGY05PRzlvWDdhY0MvL0wvSWRUUGM2cjN5N3RQc3pCVTA4MUZ5WEY3SXR0?=
 =?gb2312?B?aDRNMndvNEYvUEJ5ejRabUFId0ROUHFpWmd1enhLRzdoTXZoQlJZc0ZzV21p?=
 =?gb2312?B?Q20rRms2NGZYZ0g5bUo3S1FYMGtzU2VrT2Y2MjhHMnBFN1hxYXJ1ejJJTkYy?=
 =?gb2312?B?UG5jYkViWU05cThEZWcyazcxdGpRWmF4dEZvUTc0d1lVb2xqQStKb1g3b0da?=
 =?gb2312?B?a0lkTGtwTE9kODFyRW1IQVlMNDdNVldVbnZWYy9rNHBYN2VBVzZ1eU13enh3?=
 =?gb2312?B?MXNIRG5ZeGhWMzgvekdrYjBoejQ1czh0Vk11Ri91Vk9sV2V4ZFd6T2tqcmFv?=
 =?gb2312?B?ZnlUTHc4ZU01bk9CblEyUnVFVXRxS1lVZ0w2bXZidjJZdGlwNjRDc3cvVHF2?=
 =?gb2312?B?bnc5UmVaT3AxemZBQTMrL3JoeDlYZVNuQnNvRlJBVmRTTHR4MmFCWkMyd2NU?=
 =?gb2312?B?ZW1CaGZncTBidkEzUXMxTU42UkxIWWJWOXlLZW43cnlkMCsvWnJkdWswN05w?=
 =?gb2312?B?RkMybVZScjRIQjkvL3I0UDN5Y1VIWTViUitZV09wenY4aFZXYmpCVW4ySDVp?=
 =?gb2312?B?dXA4S2JCMWJ0OGREbkdJZmpXYU10Tk5RdGxPUUkzVTZWNE15TzRzcm9tMVIx?=
 =?gb2312?B?c2Ztd3RRakFvVjJKbXR1anVGOWhZWkxFVE9INTJIZEQ3NDA5blQxUXB4eU03?=
 =?gb2312?B?WWUwNjZFRGNJWkd3ZUJFaDVuREoycCswQjMrUjZEWFN5YVdjOVhqWmJETXln?=
 =?gb2312?B?b29sV013OURRcU5lZWhpNDk1Q0JIRlRLK0ZmS2RzQTNEOWxYQlp2eHE4MStI?=
 =?gb2312?B?QmoxVGV1MWRYYUkrS3VGTEVkL09mMVdEODdGYnpOeGtPNG14Sks2ZmtiT2li?=
 =?gb2312?B?VE1NalUyME52RHpxdHJWa2dxdnhRcXdNa1hveGE1eUpQZi9ZZ3RwWXZRMTJH?=
 =?gb2312?B?ZEVSYloxaC9UWmlHZ1BXOERvMU9ld1p5a1pFWkh0VmFDd0l2VDZQbnZpU2Rl?=
 =?gb2312?B?U1hoL3RNY2dVeG1nQVRZY3kyaW04ZXd0TDZXcHh4ZFpFS05VdHhod1lBZUVD?=
 =?gb2312?B?YkFsNS9CSitpQ0FpalBQdjJLRjZnTFNpNzhCZ1hIWTdYU2tTcENKRWF1cFBE?=
 =?gb2312?B?N0lTaHg2YnhMR3dUdnU0ejFYQ2pReW1hNzJHYnE4citSVkRscWJGMXJlTHZW?=
 =?gb2312?B?TncydW9aQm9hb2JnaCthdUEwWENCUForOTRXblFSNGt0ODlOem1PaW16L2Q1?=
 =?gb2312?B?VGN0alNxNFpGQW5BLyttSEtwbktiN0JqZUFQdWY1YkZaL2Y5RDBDZ1E1NjdC?=
 =?gb2312?B?TUZVbjgwak9rV1BJMVc2bFJnNy8zMVdrZW9UK0l6RWUyOUtOYVM3ZWZQSjh6?=
 =?gb2312?B?eTFlSDJEQWhaaCtVQkRwNEhZVUdmc1FZelJkdnYyMDJ2Z280M2gyYksvUWwv?=
 =?gb2312?B?WHJjT2E1Zm5GSzRUQ1lNRzVzemMwVFBjNFRqRmN4T3R5YXUwWFJVcnhiYzFj?=
 =?gb2312?B?ZmNsbENheTZZZzU5WmJOYlY2c3dib0krVXRYVnV3Y095MmErczNPUnRGa1ZG?=
 =?gb2312?B?SWcwQmdXNytzUWRtUUR0Sy9sZE5ISVQ4enN5SjZjWVlCSXdGdnh0aHE4RzB6?=
 =?gb2312?B?cjNNclpzOVlvN0hyWFA2S3RWeDYxUEVRMVN4NlhXY3A0ZUh3ZFdiVXIvNnNz?=
 =?gb2312?B?aFRuNVFUcXJPMHo0RklDK1ZTVXpBNWdRYjAwRGgvSGRUZmJWUXZIWDIyVFBz?=
 =?gb2312?B?ZERvRzZZUUE5aUNZYW1uY0VaMGYxMlpmSHMzRlRaT3BXRFBIZDhmUUlmNGRS?=
 =?gb2312?B?Z2JFclhsdWJKMHk0VUppMVFGNWZlTHRycDNuMXBYTVZPZ3oycllZS0MxcnlL?=
 =?gb2312?B?RTVua3pXSUcvbm0xcTFRaWRGOGZIdzF4OXNocGdUQlBselNMeUwxdVREZkN1?=
 =?gb2312?B?LzBxU0llQnFCejdDeXdFMHFVdFI5RHByRFRNbW5GYnhaRnc1MTZTK21jTTha?=
 =?gb2312?B?aWRMT3A3bGlXTDZiSVc0bTZuOHhCU1ZTTlZwWUMrS2pPengyNWV4dz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345d7862-246a-4576-26f7-08da4aadad01
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 06:51:41.8209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5JMeTU2zwBC1KBki/rD2oiuqDsXMzcMaPOzry2gezyE24nv/iF4Utmdg3PxSCXgXboQyFFttqTcb4LS8M2Zaow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjEwyNUgMDoyNg0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYnJvb25pZUBr
ZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBqaW5nb29oYW4xQGdtYWlsLmNv
bTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNvbTsN
Cj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjkgNy84XSBQQ0k6IGlteDY6IE1vdmUgdGhlIHBoeSBkcml2ZXIgY2FsbGJh
Y2tzIHRvIHRoZQ0KPiBwcm9wZXIgcGxhY2VzDQo+IA0KPiBPbiBUaHUsIEp1biAwOSwgMjAyMiBh
dCAwNjoyMDoxNkFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJu
ZWwub3JnPg0KPiA+ID4gU2VudDogMjAyMsTqNtTCOcjVIDI6NTgNCj4gPiA+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPiA+IGJy
b29uaWVAa2VybmVsLm9yZzsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBn
bWFpbC5jb207DQo+ID4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tOw0KPiA+ID4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA+IDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNy84XSBQQ0k6IGlteDY6
IE1vdmUgdGhlIHBoeSBkcml2ZXIgY2FsbGJhY2tzDQo+ID4gPiB0byB0aGUgcHJvcGVyIHBsYWNl
cw0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTWF5IDA2LCAyMDIyIGF0IDA5OjQ3OjA4QU0gKzA4MDAs
IFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+ID4gPiBUbyBtYWtlIGl0IG1vcmUgcmVhc29uYWJsZSwg
bW92ZSB0aGUgcGh5X3Bvd2VyX29uL3BoeV9pbml0DQo+ID4gPiA+IGNhbGxiYWNrcyB0byB0aGUg
cHJvcGVyIHBsYWNlcy4NCj4gPiA+ID4gLSBtb3ZlIHRoZSBwaHlfcG93ZXJfb24oKSBvdXQgb2Yg
aW14Nl9wY2llX2Nsa19lbmFibGUoKS4NCj4gPiA+ID4gLSBtb3ZlIHRoZSBwaHlfaW5pdCgpIG91
dCBvZiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLg0KPiA+ID4NCj4gPiA+IEknbSBu
b3Qgc3VyZSB3aGF0ICJtYWtlIGl0IG1vcmUgcmVhc29uYWJsZSIgaXMgdGVsbGluZyBtZS4gIElu
DQo+ID4gPiBzdWJqZWN0IGxpbmUgYW5kIGNvbW1pdCBsb2csIHBsZWFzZSBzYXkgc29tZXRoaW5n
IG1vcmUgc3BlY2lmaWMgdGhhbg0KPiA+ID4gInRoZSBwcm9wZXIgcGxhY2VzLiINCj4gPiA+DQo+
ID4gPiBJdCdzIHByb2JhYmx5IG1vcmUgaW1wb3J0YW50IHRvIHNheSB3aGVyZSB0aGV5IGFyZSBt
b3ZpbmcgKnRvKiB0aGFuDQo+ID4gPiB3aGVyZSB0aGV5J3JlIG1vdmluZyAqb3V0IG9mKi4NCj4g
DQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+IEluIGFub3RoZXIgcmV2aWV3IGxv
b3AgbGlzdGVkIGJlbG93LCBMdWNhcyB1c2VkIHNhaWQgdGhhdCBpdCdzIG5vdA0KPiA+IGdvb2Qg
dG8gaGlkZSBQSFkgaW5pdCBpbiBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoKSBTbywgSSBt
YWtlIGENCj4gPiB0cnkgdG8gbW92ZSB0aGUgcGh5X2luaXQoKSBvdXQgb2YgaW14Nl9wY2llX2Fz
c2VydF9jb3JlX3Jlc2V0KCkuDQo+ID4gQW5kIG1vdmUgcGh5X3Bvd2VyX29uKCkgb3V0IG9mIGlt
eDZfcGNpZV9jbGtfZW5hYmxlKCkgYWNjb3JkaW5nbHkuDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Yw0KPiA+
DQo+IGh3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJGcGF0Y2glMkYxNjQ2
Mjg5Mjc1LTE3ODEzLTEtZw0KPiBpDQo+ID4NCj4gdC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0
MG54cC5jb20lMkYmYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nDQo+IC56aHUNCj4gPiAlNDBu
eHAuY29tJTdDMDA5NGNiNTAzYmQ2NGQ5ZDhjMDAwOGRhNGEzNGJiYzglN0M2ODZlYTFkM2JjMmIN
Cj4gNGM2ZmE5MmNkOQ0KPiA+DQo+IDljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNzkwMzg4NzU5ODEy
NTQ1MSU3Q1Vua25vd24lN0NUV0ZwYkcNCj4gWnNiM2Q4ZXlKV0lqDQo+ID4NCj4gb2lNQzR3TGpB
d01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAN
Cj4gMDAlN0MNCj4gPiAlN0MlN0MmYW1wO3NkYXRhPW50YmpBdjZzM00wbVVJOHVDQVVYMjNIaVBO
QmxndldLbEFhdzdsQWglMkYNCj4gcEUlM0QmYW1wOw0KPiA+IHJlc2VydmVkPTAgT2theSwgSSB3
b3VsZCBzcGVjaWZpYyB0aGF0IHRoZXkgYXJlIG1vdmluZyAqdG8qIGxhdGVyLg0KPiA+DQo+ID4g
PiA+IEluIG9yZGVyIHRvIHNhdmUgcG93ZXIgY29uc3VtcHRpb24sIHR1cm4gb2ZmIHRoZSBjbG9j
a3MgYW5kDQo+ID4gPiA+IHJlZ3VsYXRvcnMgd2hlbiB0aGUgaW14Nl9wY2llX2hvc3RfaW5pdCgp
IHJldHVybiBlcnJvci4NCj4gPiA+DQo+ID4gPiBJcyB0aGUgcG93ZXIgc2F2aW5ncyB0aGUgKnJl
YXNvbiogZm9yIHRoaXMgY2hhbmdlPyAgSSBjYW4ndCB0ZWxsDQo+ID4gPiBmcm9tIHRoZSBjb21t
aXQgbG9nLg0KPiA+DQo+ID4gVGhlIGVycm9yIGhhbmRsaW5nIG9mIHRoZSBpbXg2X3BjaWVfaG9z
dF9pbml0KCkgaXMgbm90IG1lbnRpb25lZCBpbg0KPiA+IHRoZSBzdWJqZWN0LiAgU2hvdWxkIEkg
c3BsaXQgdGhlc2UgY2hhbmdlcyBpbnRvIHR3byBwYXRjaGVzPw0KPiANCj4gSWYgdGhleSBjYW4g
YmUgc3BsaXQsIHRoZXkgcHJvYmFibHkgc2hvdWxkIGJlIHNwbGl0Lg0KR290IHRoYXQsIHRoYW5r
cyBhIGxvdC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
