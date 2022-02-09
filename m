Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86D04AE839
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 05:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345859AbiBIEH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 23:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346947AbiBIDjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 22:39:00 -0500
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50071.outbound.protection.outlook.com [40.107.5.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249F3C043185;
        Tue,  8 Feb 2022 19:32:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEsskcW73hlSJSXEHAZtxdKIbVoZOsd3rB/8j/Xurf78OfJatpk86zPvkAy7G6zgselWXZUfbwsqKm/gSRFAcmp79tVzqRR4wwCcUJ4M3jOeU6KxMYxi4hTMMYQ/Up/WuY34XM5GZlRfhHXnnOAVKDtL16nA73oDz+s1aBrExN9EvXf2eRvbPsi7S/JPVpOh6VYbXs3hl7OY1NJj1DqHabFrmRqV8AT/MCsQSwdHbU1QOQbtUygKFWU+JZwr6rpzHQOAnmAZ4torE1OkxXqZ7zw4xXN0SJXUWyZpTu430u2/PM9fuN6T6DdyRON2jRF2FqeOYR7ON/nAAM25O/kRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne0Q0UV2pPr6kfcS2VcHwIlXgTwyxC+UQ2wdOmmJHxk=;
 b=DrCFWKjmcjM//Hhy5JYYMN31f+YrMcHNhME3XFEgXmpiq4BoHcX/525G9sJkJGFVhllHuK0C/k0+z1cPzTkszJaj3q5A/LzKaGi1rwjsuoaaDOkdaqiuZgjUeqHJwWPunbptyVSeYe8I89BgDdjXYpRuxbPy8byYKLD9kcLGVfakYrYJQFjlHCK9vey6iHhZbYNPnytfolemProhBZ9k08HN1u5PoXGnBC7qOO4VoR2MIhA5hgRlRt4FtsKCm0eCDGnknylqIo2oQ7VEyv5bsAleO+wCYM2kEJW1d1MtwVeqLf6fo+LiD1pSxqPsC0H5Y2Lu6oAehELKpMDDZjyeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne0Q0UV2pPr6kfcS2VcHwIlXgTwyxC+UQ2wdOmmJHxk=;
 b=g4rJ2hmrnpMRGTAvz/ZT5AEb/GmcQBG2Q8EygrGDXRaYftukjQCtZ81l1H79ofaXdkycxab9G9XqLfT/2yrwv8bCaSEjrzmwWjhoLLcfiilEVhJRdSUUu6i0/JphZ3C+v9Zvph2KIjz35bSd4w0+utBa1sc1ryte5X+bOqJ2oFA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR0401MB2271.eurprd04.prod.outlook.com (2603:10a6:800:29::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 03:32:37 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 03:32:36 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: RE: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Thread-Topic: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Thread-Index: AQHYHJ/wB6FDrGW4OkqWfAdQ8Vl2IayJbrgAgAEFCiCAAATtAIAAD0cg
Date:   Wed, 9 Feb 2022 03:32:36 +0000
Message-ID: <AS8PR04MB86767724B3AE9F450BB50E508C2E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-8-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5ALthc7zZEYZX2YHam2f3C1RmOr4CHLRjHSip7-44tL6Q@mail.gmail.com>
 <AS8PR04MB86768828ED6B984C674CE2298C2E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <CAOMZO5CUbY_SyjDpnFd-EPy+K+MYA6nn=hk_XpZnAFdJP53CFQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CUbY_SyjDpnFd-EPy+K+MYA6nn=hk_XpZnAFdJP53CFQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3533fb3-7e0a-4f40-73d3-08d9eb7cd151
x-ms-traffictypediagnostic: VI1PR0401MB2271:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB2271740460AFEA4F3E47EEC78C2E9@VI1PR0401MB2271.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eyr4uHsFA1PIL7nw+O6llTLxCinynkeKwbTC4xdvYn0X6qtBy4yaBsxMLg9gR1pLGt+Ad8LLvLcsbf6xRlOo45RK0ZwhXlhk2aNxktg3hEcv9WdpssC4qarLm9RPBQzyb3/ZeztOlzgNeXT9LDHkjNVokxcICnJHbaAnx+ynjIaNxU7Ed21e/U3MaoS8aqkjzqJoeJyUclQkFkr/5DIys45RxI2prhgjGdCXuIc5IsV10vp6jShdOHi/UDQOHEiwPRcQ2fJffSqIZyBXlxqPWDEUb1ZXqQYYQCe5ZBW8GqJNeg4Qr0dKGpiMwRC2EBBJj2w8x1YJuVEnYTqWvZD363P7EHxN9oDObxLLwED67xoVQXQB+pLv1ppk76Rl6BbmZNMMWC+BoPG0DtYvLQfYbSY9k8tcmulHi5EQgsDfz/A+gmN7iBegs1q++tP4pIZxZu5MNtL2szYjd4UR2jVHjX7kEVUF6O/f6JhaicAKJbe2Cw7x9ZdW8T8Onlz6Fx/zTzgmvS6hCSEJH6VUSbpAHPoXh8eQruNRVLd2yVl5TSbkYaMBylvfI5Rf03Wk3eyMNpfsGd62IZ8i/JGJcp7kJIOaR3j9XOUS1zS+3Vh7NhaZ4f/QFYc7Lz/JqtcMuU306GeYPFb2F2KQUOxnLoWxWd4sneghmR19bxuiuATd82oUBsgQKXrLk1GlljBBS2fF8ezCIkLYGvHcEoNpWNOncA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6916009)(9686003)(52536014)(38100700002)(55016003)(33656002)(5660300002)(8936002)(53546011)(7696005)(6506007)(2906002)(71200400001)(316002)(54906003)(38070700005)(8676002)(76116006)(66946007)(66446008)(66556008)(508600001)(66476007)(64756008)(4326008)(7416002)(83380400001)(44832011)(26005)(186003)(122000001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjByKzBIbWVpbU9uRld4VzIrS0VFSjU5azl6VXpUc1ZTNDFCbGhtK09sb3Bo?=
 =?utf-8?B?MmhNdms3MTExVWVZODBXSVh4bzFjM3p2T3NHU0FXZGtHaU16NFJwcWl4TnRU?=
 =?utf-8?B?VEdwZStjOFNzWHM2ZTNBQkR3Ujg4STZndy9MblowK2VFVlZSeXlFdVlwK3Ra?=
 =?utf-8?B?OHZLUnNDUk9IL2t6U2RuSzJBMjlTSUVzS25LbHI2MjVtSzdvYkxhaDNDWExN?=
 =?utf-8?B?b2wydXRNV1ZSQ1pLV2pNVU1hM1pHd0pDeDNackdIKy90YldkWVpDVmZlMUpO?=
 =?utf-8?B?Z0VraW9KMEFNZlhBTTE2Qk1KNzFBQk5lRVVmcEk3QjZZQU53MjNoTzhGTG9n?=
 =?utf-8?B?S2E5Y1I5MW84ZjVXS25BVjl0cjVZYkxjSkIwYTJZeHMwMkJwMkd2NmNlUk1I?=
 =?utf-8?B?TE5UN1gyQm9VOVdrOXA2RUlOM2NmM2ROdTk4Sm9teTUzOHNCTWhHbnhwOWtj?=
 =?utf-8?B?Tno5VSs4NGN6T2E0U1VPZEJCbmczY1Q5UnpQZnVEVXA5Zi9UdUp1d2ppZ1Mx?=
 =?utf-8?B?QjNjVWx4cVpRczh1N3poTkRuTHVBbHZhTUhrenJTOUViK0JoUmtWL2ZIVllC?=
 =?utf-8?B?WlB2bStaOFE2UTZFa25HeXpVMC8xVFBESmhCWFN6WDRsVElLRlZOcVN4SGVr?=
 =?utf-8?B?L0pwSHJ2YVZqNk5jNVpjUVh4QjYzdGlwT3FZK21qZ3c4ekVyUGFncFE4ejlF?=
 =?utf-8?B?cXpGMitSaWJzaDN3UXVQektIUmp0S29IL1gvdkkxdHQ5UjBjUmJhamtteEFU?=
 =?utf-8?B?NVpoNHBVUkR5S0plVTlwTzVSWWVQMUNWbEc1ZXNBb2ZUMzM3Y3lKYjR5MU1i?=
 =?utf-8?B?S0lKN3RVR1ZoMlVtTzVmcDhGRC92dXhxZTVDREpRd05oaVMrSUtORVdKYy91?=
 =?utf-8?B?OUxyVFJLUCtVRTY5bDVSVzBqRXJaemxrNGRIU2pGdTFtR1VUZWFIY2JTbHdC?=
 =?utf-8?B?ekpycHE1SDl5d2xuaGUycHNmeTlYUFkzenNtcXZGUWVHYUdRS0hpNVZweno2?=
 =?utf-8?B?Zml2Um5HMHhDWWxHcE1ZYzNUbHF2MW1Nc3R6TzZ6K3FDc25ma0hTL3YwMXVn?=
 =?utf-8?B?ZWx5bW9ycWFMcmpQYUlMdzAwOVJGSlNwL2x3L1BiSzlYM3lGeDRlL2ZBa2tN?=
 =?utf-8?B?OVhEbUYxV1VTYlYwK2E1Z1FhYVg2K00razcxUk01MWZOOFRoYmxSN2k0NlNQ?=
 =?utf-8?B?c2hHbDBkSDhsRTBYQ1gycFptYTlKZytKY0VieWJPaUh1Q0dLdlNoMnZIeUJD?=
 =?utf-8?B?a0FhVm5sekpGbmpzWFB2d3pISVRoWGZ0cEgyMjZiMzVRazh4OVVyNXBOQjZL?=
 =?utf-8?B?U1E0NUxIMFVQWHBrVi9qYzBRZWJTVFo2RDR4OExva0FHVEVyUlNEWjZWNENC?=
 =?utf-8?B?Ukw2WGlIdkdhaVY2eTlZY3BzMTV3Si9ybDVUU3dMOHlmeHNxN0ZuQXNuUmFN?=
 =?utf-8?B?VmZid0JsclVyRndjcmRIUFdsRlc3aVl5Zi9GcjdZT1haY24rUFRrck1lTUhW?=
 =?utf-8?B?V05hQkdYU1cxdDI4R21mV0ZlRWxIRU1xbXFXcUJMU25wSjhGc3lPQzh4Q2p2?=
 =?utf-8?B?N1hCcXZob2JLTVlub1FOUkhWV3E1NHo1bEptQUdkaWhXSWQwM2xHQXcrWi9a?=
 =?utf-8?B?a1lPa3EvRC83WmVTaGNiOXRsVkVMb3dSUVdBM3JLVHVlU21qQ2NJMWUvQi96?=
 =?utf-8?B?c3U4WHBYUEM1V0lsTEd3b3FLbTZQZ0dteVF2MkVpY3hFaW1kS3EvQ3ZiZmZG?=
 =?utf-8?B?VFhFb2I3c2lHVFp1bmhaSzdZR3hlVUhNNHE1V1RKaFJGNm9acVVtdUtlK2lW?=
 =?utf-8?B?SE9BeXNXWjBpVThTV3p4N1hHS0VEZlNpclJjNlE5RHJMZkdSYmRUVGFWL05h?=
 =?utf-8?B?MzV6Y0ZkWXZrRG1OZVhMbS9nZ013Ritic0k0VmY4SzBYK2dFbEhUQkp3dUNK?=
 =?utf-8?B?ZitLdjJ1dDFqNlNJc1ZDUHdxNUs4dzVpdDRLVWdkTFpjSDJvekF4UTk3cmtW?=
 =?utf-8?B?QWtvQkgrWEhiRGVHdFRTYUhyV3NsRVRsSkM2Ui90T3FuUTdkdWdpc3Frclo4?=
 =?utf-8?B?MTZnUi9VTStIQ1h6OW00cDMxdnA2b2RaNE1vVEJsSnNZNHJwV1ovYlRrOUJW?=
 =?utf-8?B?WDdhTkRMMlJSNSt1Z0QyMXBJY2dhb3lJYnl5MU1NZmwxNmZ5L0F2NlFVNEVV?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3533fb3-7e0a-4f40-73d3-08d9eb7cd151
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 03:32:36.9259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FW4nZpjnxL/miZDmr4k4gs60pZDVI7/q33BTKVBrFAlRq+xbP4LDDH6AzABkZt7V6QyOAzh8ZgXjyOxYR4hTVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2271
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjLlubQy5pyIOeaXpSAxMDowMg0KPiBUbzogSG9u
Z3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEx1Y2FzIFN0YWNoIDxsLnN0
YWNoQHBlbmd1dHJvbml4LmRlPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xlLmNv
bT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpDQo+
IDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgSmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFp
bC5jb20+Ow0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgbW9kZXJhdGVkDQo+IGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMg
QVJNIEFSQ0hJVEVDVFVSRQ0KPiA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
PjsgbGludXgta2VybmVsDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgU2FzY2hh
IEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYg
Ny84XSBQQ0k6IGlteDY6IERpc2FibGUgZW5hYmxlZCBjbG9ja3MgYW5kIHJlZ3VsYXRvcnMNCj4g
YWZ0ZXIgbGluayBpcyBkb3duDQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gT24gVHVlLCBGZWIg
OCwgMjAyMiBhdCAxMDo1NiBQTSBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiB3cm90ZToNCj4gDQo+ID4gRG8geW91IG1lYW4gdGhhdCB3ZSBzaG91bGQgaWdub3JlIHRoZSBy
ZXR1cm4gb2YgZHdfcGNpZV9ob3N0X2luaXQoKQ0KPiA+IGFuZCBmaW5pc2ggdGhlIF9wcm9iZSB3
aXRob3V0IGFuIGVycm9yIHJldHVybj8NCj4gDQo+IFllcywgd2Ugc2hvdWxkIG5vdCByZXR1cm4g
YW4gZXJyb3Igb24gcHJvYmUgaWYgdGhlIGxpbmsgaXMgZG93bi4NCj4gDQo+IFRoYW5rcw0KSGkg
RmFiaW86DQpSZWdhcmRpbmcgbXkgdW5kZXJzdGFuZCwgdGhlIHN1c3BlbmQvcmVzdW1lIGNhbGxi
YWNrcyB3b3VsZCBiZSBob29rZWQgaWYgdGhlDQogcHJvYmUgaXMgY29tcGxldGUgc3VjY2Vzc2Z1
bGx5LiBUaGVyZSB3b3VsZCBiZSBleHRyYSBtb3JlIHRoYW4gMTAwbXMgZGVsYXkNCiBpbiBldmVy
eSBzeXN0ZW0gcmVzdW1lIG9wZXJhdGlvbnMuDQpJJ20gYWZyYWlkIHRoYXQgaXQgd291bGQgYnJp
bmcgYmFkIGV4cGVyaWVuY2UgZm9yIHRoZSBwb3dlciBtYW5hZ2VtZW50Lg0KDQpJcyB0aGVyZSBh
IHBvbGljeSB0aGF0IHdlIHNob3VsZCBvYmV5LCBhbmQgbGV0IHRoZSBwcm9iZSBjb21wbGV0ZSB3
aXRob3V0DQphbiBlcnJvciByZXR1cm4/DQpJZiB5ZXMsIEkgY2FuIGZvbGxvdyB5b3VyIHN1Z2dl
c3Rpb24sIHdvdWxkbid0IHJldHVybiBhbiBlcnJvciBvbiBwcm9iZSB3aGVuDQpsaW5rIGlzIGRv
d24uDQoNClRoYW5rcy4NCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg==
