Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18974678F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jul 2023 04:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGDC3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 22:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGDC3V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 22:29:21 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2052.outbound.protection.outlook.com [40.107.22.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17071184;
        Mon,  3 Jul 2023 19:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3U3RaATzJhiQoBQ6yTbGbB284qvTOJsQGMSMVwBdjmfht7IrgE1oQ9iii9lJ8c1DPvturYUDQuy2zizX56nRYPONyYGYLuTeSRB3/EM+Q9i0VIlaoNoDgooBxJ/n75iaIQoPfTfVEDe3dpINSp5DVhvX+KHthX+lwQKqPlFghE21w7eAn71CKJbmM2j8LvJI1unwjVRJP5DtfhLZLrxvdbd3wepqRPqyl2gAgVOhyyLX5nBB0KflHbDZTtnHoRetGCvFFaNjI/FRme0UcDx/HDzq0A/pOxHtWPXnm4St0jXKPSUmxApehcurOlrpI1hgtaSfpA7ybuUpuAVrR2nHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBYuD+x/diYuM28X21juk/OkUx7xQUtnBr0C/HzsLPY=;
 b=FNXE1tfBF+xOuTtDwWgydLqqhShpLNbPXCdndVj045zRXaHNmI5jdeiFbzM01JE9g4YMy7KvW6IgkyRM3iIlguqEU+hk5BpBt7/9tlkHjVePoklvI5kP3/1An7MYB7zgKsEAeVuOSXvW+EolYxnJXtl49H0IatDwozK3sSm7xqnSbg9zF/wMJWaBwrlanwyDRMdOm7ExIutT0OWcHZAzFNx4OmerJP8ypfWvC7cDCt20iHF/pNJdEsWveppugFCzIILprNA1IQWZYBoMvie9jAg/Rl08/Ntd7Mq9QMu8S3tRajsLJxwHDhPucJhdZjSUix71Wt9Lv/oGVrwTWCfc8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBYuD+x/diYuM28X21juk/OkUx7xQUtnBr0C/HzsLPY=;
 b=L/QaKrJaN4WH5rEvqFujT3u5dbXSuuW5RR64UTLxk9xaN0iRBzMFo95FsqaJGDNFqAPPOjGUP1EFo6PJJwg2IOseuM59oYPRMdjCh6Dz3ukaToCsQArNQCzCKfOT1TC43BGq2jelK0vIlC9renY6s2j/AoY+vLl0CKLfDhddaUQ=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7905.eurprd04.prod.outlook.com (2603:10a6:20b:235::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 02:29:17 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::217c:e9d6:8dc3:8f02]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::217c:e9d6:8dc3:8f02%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 02:29:17 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Mark Brown <broonie@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: dwc: Provide deinit callback for i.MX
Thread-Topic: [PATCH] PCI: dwc: Provide deinit callback for i.MX
Thread-Index: AQHZrcukz4ExPJfs50Og19gu8zTriq+o3AZA
Date:   Tue, 4 Jul 2023 02:29:17 +0000
Message-ID: <AS8PR04MB86765700A18C1F55E2C47EB78C2EA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org>
In-Reply-To: <20230703-pci-imx-regulator-cleanup-v1-1-b6c050ae2bad@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7905:EE_
x-ms-office365-filtering-correlation-id: 5ff5c52a-688f-4816-4a22-08db7c367736
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yv+Gyb4qcsUEq540wYENDZLD3v5jmBiHJ0e18RyZWFyViPDnce30lV19FKgD5+2NCflr/VfPCuFrIkuKoHIRxz+UyDQOzlf7QyqK/WQZSN8dolg05LdBRo+MsyR+gmmpJxhw0uoABTXMvKFD20nr3fWOd7RI895OfCxVeOhsu+adgj9bUNzOiED/VOFkft0cf3MBSunt9I1nk00e38PtR1QUeYeLXvJJRJ6I/hlbUULvMmXh8RajTfa8g1RW12Yk1sMbqEa+7rj8nWAK55FxrkEWXMg2MrtUtaC7dQf8s1YqZdirSE5UQn5BDaWq+Os91VXyMyWxurBNHOPB1jHrGh5ceu7eFJTQaMwRKxCScWPWXerjQI8lqL/OKUBYHDmnZRHQlIJjS/67ZhYOkFOCZIewzt7pxI6EJoj4llGOAlkmsfe+WIeAhJ6JoEZ0/znyXvbznMeo7slfRxHoVTX2aKcO8LaB/0EhDuyCXpPm3n3n5/0pe2UaGUFOVS3bOQNWCfu+iHw5/AS3MmEcNHNVf0UmA7HrnEydL0bxNQQIPmM1L5C0jFZskuMO7LpVbTyDGHRiDSy2b0oJZBn2JlwBnabJr/2TaITjdyGfS27jlU1P1E0uksQ0p5b3HlEdrT0tieLqz/qkT47FnQuioD9Vxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(54906003)(110136005)(2906002)(478600001)(26005)(9686003)(41300700001)(33656002)(86362001)(7696005)(8676002)(52536014)(8936002)(5660300002)(71200400001)(7416002)(44832011)(316002)(66476007)(66446008)(64756008)(38100700002)(66556008)(4326008)(66946007)(55016003)(6636002)(122000001)(38070700005)(53546011)(6506007)(921005)(76116006)(186003)(66574015)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxUQ1FoOWM5czlDVDZhbitDc0p5b2hYVGtGM3pyRjRaa3Q3d0dZYmhUYTgr?=
 =?utf-8?B?b2hDNGd0MEZzaEhiNGZHOWxMVmUwTDZodmVvaW1aWWwraGJUb1Q5MXd5THFk?=
 =?utf-8?B?UFZLNGpLYXFFbi85endsU0k5cXpSWHJPaDY1aysvTG9OS0NqVnpVRmFvejRV?=
 =?utf-8?B?NzZnK1pJT0F4TjZsYzZBbVhoMis1MWUxWTU1T3ZRY3VxZ1hCaWw1ajc0Q01s?=
 =?utf-8?B?TE9TUzlTa3VsTURIVWtDeUVORWxtM1RuTytIeFVSZmJ4Umc2MXY2QmI3Vlov?=
 =?utf-8?B?SGFUeFl6Zk5taTVCbGJkWno2ZXRsVTBtaFpuUDJ2NmZRVmFSc0ZSaVFqR1hR?=
 =?utf-8?B?S3pkUTdVVzMwQXU2aTR5enFOUC9WeHo2SVJFSEtTa1ZrVHZmN1lHZlJ4SlY0?=
 =?utf-8?B?Z1R1Wkxtb3lMblA4SXE0M3VJNzFJWk5DelVTVTdGRGJGY2F4SkpHN3pJQWEz?=
 =?utf-8?B?V0lsMFFMZys4NW9DMTJnd1hKa1lpaTVUU2hLanRzVkExbjVrZDczdStLelM4?=
 =?utf-8?B?a1k2czcrd2tjTGkvVWxtRE9mMDU3SHlGemRLT203c2dzNG8rTE5La2JXVDdo?=
 =?utf-8?B?aTEvcGxUazVqTzNYVUtNbk1iQW5OWHUxUytEZ21lNEptVk4xZmliSjZHRVpm?=
 =?utf-8?B?K2dxSVNWVkdOV09iTjZNM3NDc1JBcDlyZXFFaWlLc2JHSEFMcDlScmlvSEpt?=
 =?utf-8?B?WEdYUGN4cmY0ZW10MnFXN3RMNjFRS2p0T1JwSXFNeW1kckJoRUwraWoxQUtv?=
 =?utf-8?B?WHFZMjNDQXFva3ZtRzFndUtyZ1BzVlpOelc2L2RlcHNITy9kUXUyWk52UUVl?=
 =?utf-8?B?MFQ4RTlodzREU0wvZjRJRWl4UDhPN2xlK0tjMWV6TjBQM1RpdmdtSXdqWDlq?=
 =?utf-8?B?NWFHN2dZWE1Wb05jQjhVTjErZHhaazZhZXdpYm5ZdzZ0NTEzaVhFRHlEOUY1?=
 =?utf-8?B?dkFtUFhUUk1jb3FSbVFWeWl3dVJYeFZ3M3FvNkdkK2R3VkRsTDA1a0U4a25J?=
 =?utf-8?B?bEFVRFVmMFAyd0lSVzVNTGF4Q3R0WS9WL2RsdWRqVmlqYmo5N2Eza0xQVWVM?=
 =?utf-8?B?Rmw4K3cyK1hVbitHSWVuMS9jTHRScll1bXZoYktRV2dXZGhHV0NnNmJpQ2ps?=
 =?utf-8?B?dndFSmtsSHhjT3BYdGdwODRIUCs2OU8wZnFXUkljVHJXOVVONVZ1VFpBRUlZ?=
 =?utf-8?B?SUpUeS81MmJuTUQzSEhKUWQyZ25QL09jVmRnK0lubHVmQURNbjMzTU1nbE1Q?=
 =?utf-8?B?clhYb1JTUlRxWTFkL08xZlREUm52eStGRFAzREh3aW9oT0UyckxzK2Nvcnpn?=
 =?utf-8?B?RGRnUFd5SHJXOFdxUkZsSUtUZ1locjhMdFN2RWlsUmdPNTkvcnJoamdRQWIy?=
 =?utf-8?B?Nkx4eE1RR2U0TU1XbWdWZVFqMi9pejhKU09mLzhkWi9CakxSR3YwMFljT1g1?=
 =?utf-8?B?RzI2NWpPOGozdDZTNXFWTitYemgxMnk3QXNSWmk0ek9iN0s3OXpTVDNJMW40?=
 =?utf-8?B?cDBnNmNiam1TVExjYnhLUmEvODhHN3hTR00zaWF1ZHViQ2V2NEVjRVY0Q3VM?=
 =?utf-8?B?dUdFMTF2VFh6T0RJNTliMXNSc1JjQk56UHlLTEwvN3p3b2ppRGpYSVpOWlBO?=
 =?utf-8?B?cS9VY2hqT2gxSEhuTE5EV09LYnNrS3JGeTVQb2VXUW1ZZjl3Z2xTNGtLM2Jr?=
 =?utf-8?B?Q3BQLy9tMG1HSllOcWt3TVAzRXlRMkxxeHVUZUoyVjFHUVk3RXZwT2pKWDBJ?=
 =?utf-8?B?UXJnVFhRRXVBSS9aVzdmbStaYkNlSUtxTjhLQngwWHdpZGc3L3hoaHJIYmR2?=
 =?utf-8?B?ZHdIblAvdUdFNU9WSmUyMVg2amI0cVNZRDB0NjJHSXJkRkJQZ1BIWkpGcWpn?=
 =?utf-8?B?V2JCT25HL0V3NnR3eEpFQUozYVNuK1ZZc0htU0NpWURVeUNGNGRhWFdmM2Zp?=
 =?utf-8?B?aDlEazVxWE9YSW1UUEVvVlRTUFBrS3AzbzRITjdMSE8zVWFXanFMbVgzTjRa?=
 =?utf-8?B?U3ozVE9HK3VuZXRweU5kb3dVN0g2c3VtdGEwSWRWUEswdHZtVHo1WWRYWHFG?=
 =?utf-8?B?YWpud29GNU1ZTm1OOE5IdDk2NGtHc0ZBNTJIYlUxOUlKMjhMU2hMUnA4QWc0?=
 =?utf-8?Q?N9VmsvFIYVqASC4YWf/14Vjmp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff5c52a-688f-4816-4a22-08db7c367736
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 02:29:17.3118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfRJShazZBdmFKNgHB4Pkldga4nvVMbuqAGqyiK1WBmU6jHtJRhnOdKD2a3nGf/v9Bqx8CXMXFX90h2XgxFt1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7905
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjPlubQ35pyINOaXpSAwOjIzDQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgTHVjYXMgU3RhY2gNCj4gPGwuc3RhY2hAcGVu
Z3V0cm9uaXguZGU+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bHBpZXJhbGlzaUBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mDQo+IFdpbGN6ecWEc2tpIDxrd0BsaW51eC5jb20+OyBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IFNo
YXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0KPiA8cy5oYXVlckBw
ZW5ndXRyb25peC5kZT47IFBlbmd1dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+Ow0KPiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+OyBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6
IFtQQVRDSF0gUENJOiBkd2M6IFByb3ZpZGUgZGVpbml0IGNhbGxiYWNrIGZvciBpLk1YDQo+IA0K
PiBUaGUgaS5NWCBpbnRlZ3JhdGlvbiBmb3IgdGhlIERlc2lnbldhcmUgUENJIGNvbnRyb2xsZXIg
aGFzIGEgX2hvc3RfZXhpdCgpDQo+IG9wZXJhdGlvbiB3aGljaCB1bmRvZXMgZXZlcnl0aGluZyB0
aGF0IHRoZSBfaG9zdF9pbml0KCkgb3BlcmF0aW9uIGRvZXMgYnV0IGRvZXMNCj4gbm90IHdpcmUg
dGhpcyB1cCBhcyB0aGUgaG9zdF9kZWluaXQgY2FsbGJhY2sgZm9yIHRoZSBjb3JlLCBvciBjYWxs
IGl0IGluIGFueSBwYXRoIG90aGVyDQo+IHRoYW4gc3VzcGVuZC4gVGhpcyBtZWFucyB0aGF0IGlm
IHdlIGV2ZXIgdW53aW5kIHRoZSBpbml0aWFsIHByb2JlIG9mIHRoZSBkZXZpY2UsDQo+IGZvciBl
eGFtcGxlIGJlY2F1c2UgaXQgZmFpbHMsIHRoZSByZWd1bGF0b3IgY29yZSBjb21wbGFpbnMgdGhh
dCB0aGUgcmVndWxhdG9ycyBmb3INCj4gdGhlIGRldmljZSB3ZXJlIGxlZnQgZW5hYmxlZDoNCj4g
DQo+IGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogaUFUVTogdW5yb2xsIFQsIDQgb2IsIDQgaWIs
IGFsaWduIDY0SywgbGltaXQgMTZHDQo+IGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogUGh5IGxp
bmsgbmV2ZXIgY2FtZSB1cCBpbXg2cS1wY2llIDMzODAwMDAwLnBjaWU6DQo+IFBoeSBsaW5rIG5l
dmVyIGNhbWUgdXANCj4gaW14NnEtcGNpZTogcHJvYmUgb2YgMzM4MDAwMDAucGNpZSBmYWlsZWQg
d2l0aCBlcnJvciAtMTEwIC0tLS0tLS0tLS0tLVsgY3V0DQo+IGhlcmUgXS0tLS0tLS0tLS0tLQ0K
PiBXQVJOSU5HOiBDUFU6IDIgUElEOiA0NiBhdCBkcml2ZXJzL3JlZ3VsYXRvci9jb3JlLmM6MjM5
Ng0KPiBfcmVndWxhdG9yX3B1dCsweDExMC8weDEyOA0KPiANCj4gV2lyZSB1cCB0aGUgY2FsbGJh
Y2sgc28gdGhhdCB0aGUgY29yZSBjYW4gY2xlYW4gdXAgYWZ0ZXIgaXRzZWxmLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KUmV2aWV3ZWQtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NClRoYW5rcy4NCg0KQmVzdCBSZWdh
cmRzDQpSaWNoYXJkIFpodQ0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpLWlteDYuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gaW5kZXggNTI5MDZmOTk5
ZjJiLi5lNDk0MmJkMjU5OGQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaS1pbXg2LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlt
eDYuYw0KPiBAQCAtMTAzOSw2ICsxMDM5LDcgQEAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2hvc3Rf
ZXhpdChzdHJ1Y3QgZHdfcGNpZV9ycA0KPiAqcHApDQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBkd19wY2llX2hvc3Rfb3BzIGlteDZfcGNpZV9ob3N0X29wcyA9IHsNCj4gIAkuaG9zdF9pbml0
ID0gaW14Nl9wY2llX2hvc3RfaW5pdCwNCj4gKwkuaG9zdF9kZWluaXQgPSBpbXg2X3BjaWVfaG9z
dF9leGl0LA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzIGR3
X3BjaWVfb3BzID0gew0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiA2OTk1ZTJkZTY4OTFjNzI0
YmZlYjJkYjMzZDdiODc3NzVmOTEzYWQxDQo+IGNoYW5nZS1pZDogMjAyMzA3MDMtcGNpLWlteC1y
ZWd1bGF0b3ItY2xlYW51cC1hMTdjOGZkMTVlYzUNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0N
Cj4gTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPg0KDQo=
