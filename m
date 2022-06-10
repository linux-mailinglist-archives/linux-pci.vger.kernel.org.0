Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CF9545CE0
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 09:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbiFJHJn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 03:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346348AbiFJHJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 03:09:41 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20054.outbound.protection.outlook.com [40.107.2.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548D9323416;
        Fri, 10 Jun 2022 00:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Al3wpXx8ryE5KBwOLGjZSFbmxToQQ0KnlmMg6BJWk99jhWSkCcPk1SWWaDmijc6p+qNo8hk5U68+G8zQ7fPtFTXsygs9K5e7TQCqvUePShVYzy12WS5qwSymlFsg+h5cxV2PfYntXSsu/4RNXElP3EyR7vhV0xc9IbpDGc9RQvZuv+FqosHi1+f41WYuvWqLx2LhpRyIVYF4YOsNwQwXOPhc8bZ8Nd/X+ZrKf7E6FajjsipgHxIAzE7PKLGMAFLEkO2ZsHlNqH23899702a1n1FMvS9R/KoWUuc68J3P89LzzV//0Pb5UCxPgk4zOrQzVdginxqrsY3njvz7jdFz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXJTOIdWWL2Oe9ThTevYBEhMCyLCVjsWk1DiQmQ+dIY=;
 b=jZeWvdfRfXuaaJ6GRDKkS+ZHKzqDH/NhDlbdYx/qLF+vLwqhKeOdK4BsiBc3DXkKhIHacEmGj9SOZhTT9N9ULvXQWac84fbS1h3a/zYLkGZy8QpHG3j0eR0BXpK6MMP23NOATbA2eqnMOgRSxWt1BIEAzTb3AdVPHTqeva+5/mqzWeyr1WE+N4fxmgg0gJ0zg9pcnezzS+cygIXlUU4YCroAtjVB07FhfOpB1X9RQazsLdSpqyT2n/heE5XExZpd5YVHN1N8ud+fE9IR05MwLpbjsEaiIODHkcB9B9xrxlBIJ8pqDNvxBDREiUiEpfAAzuSDoZxxeh6sU/lDf3CaKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXJTOIdWWL2Oe9ThTevYBEhMCyLCVjsWk1DiQmQ+dIY=;
 b=eHmkmYMVFBoxzv0IcZmOKelqnrW5kxfbkXDoHAox7jKzOCmUhfhehWy6BG9g1ZQ0QTCMxX3X+5iUHFobqm5/J7oiEuiNkdJk3J3O/zmuxsG4RXWdnurkgai7VOy9o+M2DxsTGdAr3tgIKdwctANL0GhI9f+qgaQEvEbAoG7GoqA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB5352.eurprd04.prod.outlook.com (2603:10a6:20b:95::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 07:09:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 07:09:35 +0000
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
Subject: RE: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYYOzgY7AYlEljsUCdTBhQfAYNj61GEJ+AgACFwmCAAPIXgIAA4sKw
Date:   Fri, 10 Jun 2022 07:09:35 +0000
Message-ID: <AS8PR04MB86767131E8EA4AA6AC38192A8CA69@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB8676EFCB2BA9C1DD0F33C4FA8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220609172005.GA514802@bhelgaas>
In-Reply-To: <20220609172005.GA514802@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e83d41a-e3d7-402f-2416-08da4ab02d32
x-ms-traffictypediagnostic: AM6PR04MB5352:EE_
x-microsoft-antispam-prvs: <AM6PR04MB535279C075CD9A5B0F5216C88CA69@AM6PR04MB5352.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mH5IHo5vLL+6hx50OhrG8xO8jFiygOfTeEEU5AzShegJFtwESGsjcA4PN/VeblWR94nLfo5URc752gXUPdaRQ8wBtRbQyZxaFcYCb1mCFSD9Kl+IAQ9um26tzRcBdNmTJVR8pDAmNu7iZ1I/5SzAQ5WuGfAXQmbg+8Km7vu/4NJ9xGlCHzuV/NSZgtIuFfBk3OJlSb87Mv1ZFxSIepkQI6fyQuYgpKNTzTfiT9ykVbQuBqVB6Cq17ZH0jerKA5VGqLBapbXiFxHL52WUSCO1U8Cu36I7Mus90f2n/WO7xdyjJjKt2/chwkcvk3GSS4AIZ/em9rSqmaAVYLYQ5fC87vEN13IasAd0lO0ZrT8BpdZB0o796Buey40SP3g2Mfb9ROjMQVnuFu4SqQutU/e3GiTF4A5DJn0Md/+OgssutvWWBEvvbOqmJLz03X6/90D2mihGG18chLPmmnScXWpqwCGXmogGKgdUVC849P0xIhcVGWZq4dRSlxePGHcT/hSDFXh4VfMPzrbKG0isyAH+yJIz6IGgl0UJh69r8Bj5cknmNx+UDy5jGHNHZONc+5XpLTNrx67SW1dx74AaCb45tJ/53Uiq0Mc2iJuRl1Og6WyNiiCdzSCgLbd1eBW8a+UYscb0bbJl2L9u1xdTl8LNsoPu4JqnmOX3pOMjjPestUPsgnqfSOSbvqy+HwuxpkfUQbP9bzhFDCLdZJcPezWqkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(186003)(52536014)(508600001)(54906003)(38100700002)(8936002)(55016003)(66556008)(8676002)(66946007)(66446008)(66476007)(64756008)(4326008)(7416002)(5660300002)(2906002)(316002)(83380400001)(76116006)(38070700005)(33656002)(71200400001)(26005)(122000001)(7696005)(6506007)(53546011)(9686003)(86362001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2FxVEd2WkdQNU0rNjdMYnltQXNGcFp6dWJaRDFKbnFyZVBvQmdtZklOb2dS?=
 =?utf-8?B?R0RoNis2Z2xYVXpycnViQ1V5RDA5dTl1UUZVdDl4RU42ZDNiZnRrMFZtcUZP?=
 =?utf-8?B?N1lKTTRMRW1pSi9xM04yL3M0MnJZV0JRWDlkd29rTkY1TWpPYXNPbnVyRG9a?=
 =?utf-8?B?VWN6WHRGNnYxU2I1SUcxRmk0WU9QVmJKcTB4czNqbS9ZV09tdHhKRWJ0RXRR?=
 =?utf-8?B?NGJ4eXRPNzd5Mjk1U1plR0JoUFFWcEFlVGgyclh4QmFuMWs2ZGVFSmtWcVFs?=
 =?utf-8?B?OWlyYlh0dEJhK2JWMWJobjFqUnc5dkI0TmZQcFNkd1FnQ1VocmQ2cHRpbGta?=
 =?utf-8?B?SElla2lqMjBVbFVGY0tIQVBUSnV3N1JkOGI1UVh3eDRvYlRpaGhNK0FnT0lI?=
 =?utf-8?B?QWlLdkw2T1F1TnJ5MzFhcmF4UEFDRUVVem9qQW1oNktaY2VqcllzZkM5cjJm?=
 =?utf-8?B?N0ZYZURBZmlOTnZ2YTQ3Z3VScDZ4VHZYTy9jOWl6YUJLRnAyZTJ2NWZQMFhI?=
 =?utf-8?B?ME5mN21tWWZxa0J4dUhVZ0NKd0c2Myt5b2FzL2RYSEVRWExSa284NmpaQ3hv?=
 =?utf-8?B?ZlNzVlBJUmhSRDB0Ti9uZUFXRHppd2Z3WnpucXk3b2JkdnhXbXE5bk1zQ3Az?=
 =?utf-8?B?MXYzYXgrcU44UEVsL2twLzJHOTByeW1pWkVISjM5T2Z4T3JpdTVzbVpTRS9i?=
 =?utf-8?B?dWYvYWlxT1ZoNy9hSnk3VDAxbTBDQVFIcmVLTVA5cHJXWWhwQWdkSGlUcGU3?=
 =?utf-8?B?S0FBSjRWOXhVSktkTE9WVE1qSnEwTUtTMVNqVzdBQ3o3Q2ttRjltOXlTSnBR?=
 =?utf-8?B?dHZvbzdmRXdsRXFzZE1CVVMxZEsrTVJmUDRiakd1d1ZHR2s4eStXOEsrekFu?=
 =?utf-8?B?Tnk3Q1hiNGdOR211MG1ibGpZQkM0bW42aVJaM0JWdlZZNTJiM0FtejBIanRH?=
 =?utf-8?B?M0V6Rjh0Ujc5QkN5Q3cralNwd2FPZE9qT1hJbGhNcXBGTUg2U2lpc2E0aEJr?=
 =?utf-8?B?b08yQmoyalhGcldEMFBtZFlXb2dNZ2NSODl3NDFmREt1MmtwZXRSTkZkWE8z?=
 =?utf-8?B?aWNuWUR5RWhsdkZ4S3VTcXQ0NlZaQlBhRE8xVkczcm1admg5WUt2VEFGZEVl?=
 =?utf-8?B?cDdRaVlqVm5tQU5mQTNwc293Z3lza2tKYUtlWWpwWlljUEQ2QWlLK3FWc0NI?=
 =?utf-8?B?bHE5NEFNVHRsbytETnBVRDlkMVhDMTI2UHh1WUhNSHFaNzdrM0pNS2pXUXpZ?=
 =?utf-8?B?a3RpVzNMNHpld0lVOGI5UmJPZmJ6SkdnUDBhem13TDYvYjh4cThQRm9SSnkr?=
 =?utf-8?B?UjNtckJiNDZQL05hSHh2azhxdHRWd3FrVW9HeDk5eExYZXJZOGd5emhDWkhz?=
 =?utf-8?B?TndKeFBkc25pSitXbWllRmthRmcyRzFDN0h5OU5jWnFGSldjTVFjaDRXZ3Fq?=
 =?utf-8?B?d1B4ME0zYWVObnhlMXdIenA4aGRZUnJxZklUQlFxQVgxbkpXWGxkZmlDOEM5?=
 =?utf-8?B?NmxONkFwU0tqLzVZRlV5VzNNQjhXVkxSWE1WQ1JvWHkrUk5SU2V5dHBGNDhz?=
 =?utf-8?B?K3JhekFlaUpGdzYxd0Y3RGtmeDdZNENIaVNLUlNGR2hYUFVGNWZXSlNTMWhs?=
 =?utf-8?B?ZnBHSk1qVlc5c0VIakV6TGQzdDdqYk8yMisvS3p3dFJERDlxblNyY09iUkJG?=
 =?utf-8?B?YXphNFk5WDJXbi8zZ2VrVHlod0t0OExOUVZYcW9wYnpId0dsM0FJejlnWDdk?=
 =?utf-8?B?dEFpcmVuZnRHbGU4SDNDUVYyN21yb2dqeUZPYU1PSDRqOTc5b1g3WitQWUNm?=
 =?utf-8?B?WDJPVG12QjlldERtMzFVWHk0T1ljNDY3bWpQL2FsWW0wdnlSaVRRK1R3WHM3?=
 =?utf-8?B?SEh0T3dXdmVDRzBXdlV4bEt3S1k4YTRlWURnWk9OMGR2cnlYVUZITTNvSFA4?=
 =?utf-8?B?R3Bsa2lNQUFmcllGdUFLNWNnTER6N0J1MzhnczAyaGplSkJkNU5CYXBpOTho?=
 =?utf-8?B?TnF6dTFranlvUnJXOGJJQlZ2djFxQkRveVpKQWxWdXQ0blpUUXlWaDdEeUFU?=
 =?utf-8?B?WXhUSlVLbUcrUXgzOXgvdmU5dmljVXBIakM3dU12SHFoazF4UXFQUGswU1gx?=
 =?utf-8?B?ZWxkTW04b2s3SVRuLzVHVkhBNHNsa29USlB5Uk5pa2FDY2dYOHBGQmk1bTFq?=
 =?utf-8?B?YXQvQ1RadVMwRGtGVGUrQWVhSy83dnlVUnVlUTlWejU1dGtBaWJHbjdqQTlM?=
 =?utf-8?B?WG9jbXA0SmJtOUE2eC84S1dxajJzUVFKR2NoZjRRWE91Si85TGdOcHlxN1oz?=
 =?utf-8?B?UktXQ2gvWFhxUjNiT0xOMUYzZkRpVkZQZ2tGWHNDZFN4VzRxNGxjUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e83d41a-e3d7-402f-2416-08da4ab02d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 07:09:35.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HsMSzNGHibdqYSeZDIwAMyAqODPlo9EAb7F8jSS0YYwBEYw/Zkf514Il1Me18NZQM/ZjNn5Gu4xPtR0L6q7Rxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5352
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLlubQ25pyIMTDml6UgMToyMA0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9u
aXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYnJvb25p
ZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBqaW5nb29oYW4xQGdtYWls
LmNvbTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNv
bTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjkgNS84XSBQQ0k6IGlteDY6IFJlZmluZSB0aGUgcmVndWxhdG9yIHVz
YWdlDQo+IA0KPiBPbiBUaHUsIEp1biAwOSwgMjAyMiBhdCAwNjoxOTo0N0FNICswMDAwLCBIb25n
eGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogMjAy
MuW5tDbmnIg55pelIDI6NTUNCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBu
eHAuY29tPg0KPiA+ID4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2ds
ZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPiA+IGJyb29uaWVAa2VybmVsLm9yZzsgbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207DQo+ID4gPiBmZXN0
ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOw0KPiA+ID4gbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJv
bml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjkgNS84XSBQQ0k6IGlteDY6IFJlZmluZSB0aGUgcmVndWxhdG9y
IHVzYWdlDQo+ID4gPg0KPiA+ID4gT24gRnJpLCBNYXkgMDYsIDIwMjIgYXQgMDk6NDc6MDZBTSAr
MDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiA+IFRoZSBkcml2ZXIgc2hvdWxkIHVuZG8g
YW55IGVuYWJsZXMgaXQgZGlkIGl0c2VsZi4gVGhlIHJlZ3VsYXRvcg0KPiA+ID4gPiBkaXNhYmxl
IHNob3VsZG4ndCBiZSBiYXNpbmcgZGVjaXNpb25zIG9uIHJlZ3VsYXRvcl9pc19lbmFibGVkKCku
DQo+IA0KPiBUaGUgZHJpdmVyIHNob3VsZCBkaXNhYmxlIHRoaW5ncyBpZiBhbiBlcnJvciBvY2N1
cnMgYWZ0ZXIgaXQgaGFzIGVuYWJsZWQNCj4gc29tZXRoaW5nLCBvciBpZiBpdCBlbmFibGVkIHNv
bWV0aGluZyBkdXJpbmcgcHJvYmUgYW5kIHdlJ3JlIG5vdyBkZXRhY2hpbmcNCj4gdGhlIGRyaXZl
ci4gIFRoYXQgZG9lc24ndCBsb29rIGxpa2UgdGhlIGNhc2UgaGVyZS4NCj4gDQo+ID4gPiA+IFRv
IGtlZXAgdGhlIGJhbGFuY2Ugb2YgdGhlIHJlZ3VsYXRvciB1c2FnZSBjb3VudGVyLCBkaXNhYmxl
IHRoZQ0KPiA+ID4gPiByZWd1bGF0b3IganVzdCBiZWhpbmQgb2YgaW14Nl9wY2llX2Fzc2VydF9j
b3JlX3Jlc2V0KCkgaW4gcmVzdW1lDQo+ID4gPiA+IGFuZCBzaHV0ZG93bi4NCj4gPiA+DQo+ID4g
PiBJbiBzdWJqZWN0LCAiUmVmaW5lIiBkb2Vzbid0IHRlbGwgbWUgYW55dGhpbmcgYWJvdXQgd2hh
dCdzIGhhcHBlbmluZyBoZXJlLg0KPiA+DQo+ID4gVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0K
PiA+IEhvdyBhYm91dCB0aGUgZm9sbG93aW5nIG9uZT8NCj4gPiBQQ0k6IGlteDY6IERvIHJlZ3Vs
YXRvciBkaXNhYmxlIHdpdGhvdXQgdGhlIHJlZ3VsYXRvcl9pc19lbmFibGVkIGNoZWNrDQo+IA0K
PiBUaGF0J3MgdG9vIGxvdy1sZXZlbCwgbGlrZSBkZXNjcmliaW5nIHRoZSBDIGNvZGUgbGluZSBi
eSBsaW5lLg0KPiBJJ20gaG9waW5nIGZvciBzb21ldGhpbmcgYWJvdXQgdGhlIHB1cnBvc2UgZm9y
IHRoZSBwYXRjaCBzbyAiZ2l0IGxvZyAtLW9uZWxpbmUiDQo+IGNhbiB0ZWxsIGEgY29oZXJlbnQg
c3RvcnkuDQo+IA0KPiBBcHBhcmVudGx5IHRoaXMgaXMgYWJvdXQgZGlzYWJsaW5nIHRoZSBwb3dl
ciByZWd1bGF0b3Igd2hlbiB0aGUgc2xvdCBpc24ndCBiZWluZw0KPiB1c2VkLCBzbyBtYXliZSBp
dCBjb3VsZCBzYXkgc29tZXRoaW5nIGFib3V0IHRoYXQuDQo+IA0KPiAgICQgZ2l0IGdyZXAgLUVw
ICJyZWd1bGF0b3JfKGVufGRpcylhYmxlIiBkcml2ZXJzL3BjaS9jb250cm9sbGVyLw0KPiANCj4g
c2hvd3MgdGhhdCBpbiBvdGhlciBkcml2ZXJzLCB0aGlzIGJlaW5nIGRvbmUgaW4NCj4gcHJvYmUv
cmVtb3ZlL3N1c3BlbmQvcmVzdW1lLXR5cGUgcGF0aHMuICBpbXg2IHNob3VsZCBiZSBzaW1pbGFy
Lg0KPiANCkdvdCB0aGF0LCB0aGFua3MgYSBsb3QuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBa
aHUNCg0KPiBCam9ybg0K
