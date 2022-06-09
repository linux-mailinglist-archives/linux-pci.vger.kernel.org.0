Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1A544530
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 09:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiFIHyh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiFIHyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 03:54:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4A30A;
        Thu,  9 Jun 2022 00:54:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha9cdqQkk5Na4adfweShsaVtpUvISZOve/3g3tBX02mFCw6loz+U9972sAHFNOwIoemBx8Amg7NA0jV4BEW+gVdioUbXdbtbovRr3jiFP/kMnjHnAZHF6uUnV6HwWKp5J3DITP+IJyQfxMwl1WIaCMQEF9RhFiWbpMlzNyiGZLvCr6iOs8DPX12tzn4LGRIfTJrQusJCkUDdw5LoIWMEx6TkH1E1lmG7bkmMtu7Kyms0Cjz9m40nFyT5uNNZjrUBVblbWTnJLbpW12v9HuUovslpxvwkSimUZJTfJb7nfuEb/1QMcVwN6cCKULT0+43TQF6lMV7OLzINznlJsdoveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI+2wZEc1ghzPOvZ/zOB4+R2HGsF2IXxObh8apjEU/Q=;
 b=RSGsgCxqtfTJDsnB8Snya7r5hLAmVWBM/k6IXUSEgqTXUY6Y6PoDXUKl0a9MbaaVl8eF3CkqYd5oh2SwI6TM+7cZ58kIANVRLoBgXHBwP6XUUNzEhIAVkxUxGpp4kJATbHWe02WzlewfJ++HfXS1x5XZvwzMJLds/902AVMai93eBcrhUGTfnIisSoyqXtkKF0RtIVzJFeDXY4MEaPBMC+83GDAZh7PDK5BSHxHatkqTqhgenq2npmeUESIC5NfzuCXZB/uQQmE8B3sJIdICT2HsxDhigS8QJX9QQb4gvuY9Rf7PG/dOCO0DiKyxywT4qBzuCVbgOCAxXQkveUUpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI+2wZEc1ghzPOvZ/zOB4+R2HGsF2IXxObh8apjEU/Q=;
 b=TQuZygNt7Sj5APEKONoGkQOhwWHTVFglph+HiBcs58AHJJxgWg2S5haEGRITICd5H/z0mFj5oT4OTPLV2a5F4C94w/idvB7zubB+FxeC3VkwsoFTUv9LNtUqIRrVHaaYHDoF6DFKz0Lstfh/EuiS8ADoITL2H+sOlwaiQKLBfRM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB6PR04MB3207.eurprd04.prod.outlook.com (2603:10a6:6:6::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Thu, 9 Jun 2022 07:54:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 07:54:32 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Topic: [PATCH v9 5/8] PCI: imx6: Refine the regulator usage
Thread-Index: AQHYYOzgY7AYlEljsUCdTBhQfAYNj61FUGwAgAAKrlCAAY1VAIAAAR2Q
Date:   Thu, 9 Jun 2022 07:54:32 +0000
Message-ID: <AS8PR04MB8676A89DEDDD9EDECCC925208CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-1-git-send-email-hongxing.zhu@nxp.com>
         <1651801629-30223-6-git-send-email-hongxing.zhu@nxp.com>
         <2427cef355dc1b9d1667a2c80448d2e23b97c447.camel@pengutronix.de>
         <AS8PR04MB8676708D899DCE93F14A28DB8CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <ce3bf1e3ea155a45bd903c1506ed433fdc3026e3.camel@pengutronix.de>
In-Reply-To: <ce3bf1e3ea155a45bd903c1506ed433fdc3026e3.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f5e3e28-8427-4849-4ea6-08da49ed49de
x-ms-traffictypediagnostic: DB6PR04MB3207:EE_
x-microsoft-antispam-prvs: <DB6PR04MB3207226490685CECA0C24DDF8CA79@DB6PR04MB3207.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fr/iUNcLxfJzpiXlofY5vXuK6ukvaW/n4AfPveXpyEB6rc2N3I3WWg3pB+ZzKUHRG/wVG0JkMKIeQvoyELyoz+Ob3rjTNwc3JsOB5kUc+2QSM0SI1/+3TisY0CldNcGU2yPt4slqKlH6bSb2mM0/3VKatzqpECyhZUu8R4U7M/tN/k1yQ1aJTqMQv4k44SGdScABfgTjzXX/DLtfdf0wgNeiHmMIIO8vsRuJih0dYCGXP962xuwl0McnLyC56UTKufgxi9RwwQeoTIA9iMHFiWzNqdXczaNUxxixgOJ3PiiMr0Mb9b5UiZh2b5QG4iE/FAFa8JvoR77WR3kao1oZCBePmZTkVQ+aTLAf379QmgfYNz21Wy1A0JKEuB7uIV51kEPbEBmL+B9aQZ/yvxFHZZljk3iLOPpRIm1XZfO7hR5q/vFDJjVDmXr4/k1y824QOqKa/+LCK/UHAyYYH238EhcQulU2t579WDj+ZzTH4fsBsmBrww7vp+2Ekv957rhyh5p5aiR8MiHGVvV6hJw4VzQBggaNWJoSyiuuld6bewjAjvz5r38OG4ZAjnAxYHWKuEXa6setYIVARxqMOnDuvx1nhS5DSe8F2AFvhExOQ6jta8tbuZoQh/fSiX5+HuryVkWJwTXp8PQuTlOWpw6QoQXmNT65ASJIuc8ekhaWNVvM4hF58JIq13zT9+aOnVABWiUSsLWjPgfSX7j9gLu6fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(2906002)(66556008)(66946007)(66446008)(66476007)(64756008)(7696005)(4326008)(6506007)(52536014)(8676002)(53546011)(8936002)(110136005)(33656002)(76116006)(54906003)(316002)(44832011)(122000001)(5660300002)(38100700002)(508600001)(86362001)(7416002)(71200400001)(38070700005)(9686003)(26005)(55016003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFdyWkcvdkhyVllvTDh1SENrczEwYmtmTExhMkZBSVdkMEQ2TXNxZU1hQUNj?=
 =?utf-8?B?SnJvVU5kSlB0L1lxQ0F1SEV2MDdzK2c0VFJYc1VSVHRnNGp0N2pWK2ZEN2dM?=
 =?utf-8?B?SVV3dDNsZzZoSWtnTGYzTEtOdjMxZTVIYkJkcy9SMVJwMWlUR1czR2NvRmhv?=
 =?utf-8?B?aExFQnk5aE0rRXdvaXhGNUd1eTlFeUd0NUV2N0ZyaUkyVzlab0EwdGtVZFA4?=
 =?utf-8?B?OUFZNktmQk96Z3BaU1NpZXgvY1hQdkVMTUtuSTdEMWoyMlVOb0hiRExoRXRt?=
 =?utf-8?B?eEk1SUF6bWt4Zk1iMFVXUUFmN0hQeDhHWnlRaXRYeldlUXpyMVNueW14cjdp?=
 =?utf-8?B?cTdwc01EVFpSTXJtSXdKZXMwZDcwcDFlVXJUa2c1aG0yb3ExbEZnd2tBYTFH?=
 =?utf-8?B?L3lVUyt5TlBGSWM3VFp5TDA2cjM5R2NRNUUxTTNhbkdCZHlPN3VIVWcvZ0hx?=
 =?utf-8?B?ajZ4RzVBZmNuS3hYbVlLRDF1WlVQN1M2TVdpSXVrVVp1MlRLUngrZTU5b3dE?=
 =?utf-8?B?NWlnUUViU0QrYzk3bTMyaXdMZlpWM1dRYVYwdXp3TUl1ZVBjMyszR2t2UlZq?=
 =?utf-8?B?cFBOUUtPU1pFSE9QVTdmRzIvalAxODFrZmp1WVIxd2JvOFF2MS9sTWQrd01D?=
 =?utf-8?B?d1kwVndCOUtUY0k3dEpIeCtRNVZBcWY5NWsxRkhvVDNFcURISnVQVWxSWXZo?=
 =?utf-8?B?TlZ0VTErQVE4aFFhQTNac3F2cHh4VTNyQndwUGFtQmdKblkyWm0xelhzSURo?=
 =?utf-8?B?NlRwZlkvZjZPQkZjRDVFRnBMZjJ6cUdTTVVSYW9FL2MxKzVDbGdVU0tSVnAy?=
 =?utf-8?B?UFUwb2hCUW5MRW9vZW11RXdnQ0JEQVE0Z3NEU3ZpejFUQ3NYbHFKNENWZFFG?=
 =?utf-8?B?WTV1eDYvaWp4M1pML0hwMCtJVElvVitEanlqNjVmNzBXWmJ1WFZzTmxGcVF6?=
 =?utf-8?B?Q3VJaVpRRzh1QVBPK1FFNTRtVm11cGxiZnVwbkRZT3piZDBneU1SVDc1TmRp?=
 =?utf-8?B?MlVWTTNwbktmNWNUajRpajVYUWxMOHd1SEV0STlYQzZueEVVUlFnOHVFbnky?=
 =?utf-8?B?WTFKUmw5ZThwTGl4Z0Yxa3U0WVhxMU5yTENmT2pvZVNRUlNIbzRnOVFhRGdU?=
 =?utf-8?B?QTBJbGhVNTNWZlJ1c1dRd0dQNmdJUUdHM2FnampwSHpSUUJRb1UybnRpMFR1?=
 =?utf-8?B?aXFTeU1kaGIxMFVCSkFSeENYNVV2eDJuQkVmTTNOeU0ySWFJVFUzQWx1cEw1?=
 =?utf-8?B?VTdSMmhXWnh6RWlzN3A3RkxRZzhQN3psMExwSlpQWC9sM2FzektJM3d4dlAr?=
 =?utf-8?B?NFZZajYzUlVtTERvUE5rYTUyTGRIUW5KZjZUNjA0d1NkQi9vMFR2ejRtd3pY?=
 =?utf-8?B?cjJtckEzYkt2WVRYMVdJTE95NHd0ZUxneVFoc1V3SkFHZGk4Lzc2VWVhaFFh?=
 =?utf-8?B?b0R5TllCYU5jTUI5NVYvSFBpd3FZVERITjNZVVJERXhhOVdZQVVjbWVtVDNF?=
 =?utf-8?B?QU1uQWdpaHZXbzg5V0lybGN5eXFKQllBNVcrL2EyV1Y0VGtIZ0wxdGczSGo3?=
 =?utf-8?B?VzVpaVRVL2FLSDZabTRCc0hsbXpVZDJIRmEyZ04vOUZDUXBOanhtdGlXeEx2?=
 =?utf-8?B?ZWJ0Z3lWOTIzdXhLTWQwTlRmR0crOU1WclNic3BRb0JFWDRQNXYwYjFzYkVW?=
 =?utf-8?B?blZYQ2JUd1l4OFFZdjcrN3dZRjdRQVpnaTdLeG1nZmczQnprVWRCa0NjYnRD?=
 =?utf-8?B?aVRGU0JhaFlDK1IxcXF3emk1TG5BU1N6OEw3cXRHbGxKTnUyR2kwZzAzMnA3?=
 =?utf-8?B?STJXYTZiWXpVMjRJRGRkanpPaUozendPOTNhc2FqYjZUT3Q4dUt2ckZvb0xX?=
 =?utf-8?B?bkhCQUNWZUdwV216c0ZJWUdtVm01VnBob1VNaEtrbm5DQVNHdXRwaGdhREhs?=
 =?utf-8?B?RlVnWGNZeXlGQlF2MmpjK3FuTW5kZ2ZtMGJDbjB6Z0ZBR3B4R2NmKzRvK2pU?=
 =?utf-8?B?NTJLYU5BU3pxS3RScjB2WVhBbS84UXVGMFRxeldVc2N4YnhzV0ZOWVR2YXdD?=
 =?utf-8?B?dkVlM0ljekVrZ1UyZlZTWUg2bFM3a3d0V3BYNlljVHBzSzRrNHVuWDl5R0FV?=
 =?utf-8?B?TExCTHI4dDQwa0puQm1RdGdNY0lyRkp1N0tubXdMamhiT0VpeUVvdXFvL0pk?=
 =?utf-8?B?OG1NS3cyZklWVkdGYURoeWN3eG5ISmZKb1V4S0gzTU1YRFNlcFg1dUtLc3cx?=
 =?utf-8?B?NHZ5Yzd3Qi80aXZSdVdNdk1rTjVVUVVaWWw1eVhsZ1IrTEx0NUpNQ1dtRitO?=
 =?utf-8?B?VVhoV2Y4YWV3WURmZ29IRzZKelJvQ09VdVJRY3o2V2NzMmpPbm5mdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5e3e28-8427-4849-4ea6-08da49ed49de
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 07:54:32.1416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7FEiQ93fxuX/8eBZdhs76jwOGh1Ww2QoVksn36kRU7wbGIMpHk/7p3hV7sMj/uLB9iPtRy4T8bfJealUT/HBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDbmnIg55pelIDE1OjQ3DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gcm9iaCtkdEBrZXJuZWwub3JnOyBicm9vbmllQGtlcm5lbC5vcmc7IGxvcmVuem8ucGllcmFs
aXNpQGFybS5jb207DQo+IGppbmdvb2hhbjFAZ21haWwuY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA1Lzhd
IFBDSTogaW14NjogUmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UNCj4gDQo+IEFtIERvbm5lcnN0
YWcsIGRlbSAwOS4wNi4yMDIyIHVtIDA2OjE3ICswMDAwIHNjaHJpZWIgSG9uZ3hpbmcgWmh1Og0K
PiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEx1Y2FzIFN0YWNo
IDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4gU2VudDogMjAyMuW5tDbmnIg45pelIDE1
OjI3DQo+ID4gPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxn
YWFzQGdvb2dsZS5jb207DQo+ID4gPiByb2JoK2R0QGtlcm5lbC5vcmc7IGJyb29uaWVAa2VybmVs
Lm9yZzsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gPiA+IGppbmdvb2hhbjFAZ21haWwu
Y29tOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gPiBmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4
LmNvbQ0KPiA+ID4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA+ID4gPGxp
bnV4LWlteEBueHAuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA1LzhdIFBDSTog
aW14NjogUmVmaW5lIHRoZSByZWd1bGF0b3IgdXNhZ2UNCj4gPiA+DQo+ID4gPiBBbSBGcmVpdGFn
LCBkZW0gMDYuMDUuMjAyMiB1bSAwOTo0NyArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+
ID4gPiBUaGUgZHJpdmVyIHNob3VsZCB1bmRvIGFueSBlbmFibGVzIGl0IGRpZCBpdHNlbGYuIFRo
ZSByZWd1bGF0b3INCj4gPiA+ID4gZGlzYWJsZSBzaG91bGRuJ3QgYmUgYmFzaW5nIGRlY2lzaW9u
cyBvbiByZWd1bGF0b3JfaXNfZW5hYmxlZCgpLg0KPiA+ID4gPg0KPiA+ID4gPiBUbyBrZWVwIHRo
ZSBiYWxhbmNlIG9mIHRoZSByZWd1bGF0b3IgdXNhZ2UgY291bnRlciwgZGlzYWJsZSB0aGUNCj4g
PiA+ID4gcmVndWxhdG9yIGp1c3QgYmVoaW5kIG9mIGlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNl
dCgpIGluIHJlc3VtZQ0KPiA+ID4gPiBhbmQNCj4gPiA+IHNodXRkb3duLg0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2
LmMgfCAxOSArKysrKysrLS0tLS0tLS0tLS0tDQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IGIvZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiBpbmRleCA3MDA1YTc5
MTAwMDMuLjNjZTM5OTNkNTc5NyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiA+IEBAIC0zNjksOCArMzY5LDYgQEAgc3RhdGljIGlu
dCBpbXg2X3BjaWVfYXR0YWNoX3BkKHN0cnVjdCBkZXZpY2UNCj4gPiA+ID4gKmRldikNCj4gPiA+
ID4NCj4gPiA+ID4gwqBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3Ry
dWN0IGlteDZfcGNpZQ0KPiA+ID4gPiAqaW14Nl9wY2llKQ0KPiA+ID4gPiB7DQo+ID4gPiA+IC0J
c3RydWN0IGRldmljZSAqZGV2ID0gaW14Nl9wY2llLT5wY2ktPmRldjsNCj4gPiA+ID4gLQ0KPiA+
ID4gPiDCoAlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiA+ID4gPiDC
oAljYXNlIElNWDdEOg0KPiA+ID4gPiDCoAljYXNlIElNWDhNUToNCj4gPiA+ID4gQEAgLTQwMCwx
NCArMzk4LDYgQEAgc3RhdGljIHZvaWQNCj4gPiA+ID4gaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jl
c2V0KHN0cnVjdA0KPiA+ID4gaW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gPiA+IMKgCQkJCSAg
IElNWDZRX0dQUjFfUENJRV9SRUZfQ0xLX0VOLCAwIDw8IDE2KTsNCj4gPiA+ID4gwqAJCWJyZWFr
Ow0KPiA+ID4gPiDCoAl9DQo+ID4gPiA+IC0NCj4gPiA+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNp
ZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtDQo+ID4gPiA+ID52cGNpZSkgPiAw
KSB7DQo+ID4gPiA+IC0JCWludCByZXQgPSByZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZw
Y2llKTsNCj4gPiA+ID4gLQ0KPiA+ID4gPiAtCQlpZiAocmV0KQ0KPiA+ID4gPiAtCQkJZGV2X2Vy
cihkZXYsICJmYWlsZWQgdG8gZGlzYWJsZSB2cGNpZQ0KPiA+ID4gPiByZWd1bGF0b3I6ICVkXG4i
LA0KPiA+ID4gPiAtCQkJCXJldCk7DQo+ID4gPiA+IC0JfQ0KPiA+ID4gPiDCoH0NCj4gPiA+ID4N
Cj4gPiA+ID4gwqBzdGF0aWMgdW5zaWduZWQgaW50IGlteDZfcGNpZV9ncnBfb2Zmc2V0KGNvbnN0
IHN0cnVjdCBpbXg2X3BjaWUNCj4gPiA+ID4gKmlteDZfcGNpZSkgQEAgLTU4MCw3ICs1NzAsNyBA
QCBzdGF0aWMgaW50DQo+ID4gPiBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3Qg
aW14Nl9wY2llICppbXg2X3BjaWUpDQo+ID4gPiA+IMKgCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBj
aS0+ZGV2Ow0KPiA+ID4gPiDCoAlpbnQgcmV0LCBlcnI7DQo+ID4gPiA+DQo+ID4gPiA+IC0JaWYg
KGlteDZfcGNpZS0+dnBjaWUgJiYgIXJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0NCj4g
PiA+ID4gPnZwY2llKSkgew0KPiA+ID4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4g
PiA+IMKgCQlyZXQgPSByZWd1bGF0b3JfZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ID4g
PiDCoAkJaWYgKHJldCkgew0KPiA+ID4gPiDCoAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVu
YWJsZSB2cGNpZQ0KPiA+ID4gPiByZWd1bGF0b3I6ICVkXG4iLCBAQA0KPiA+ID4gLTY1Myw3DQo+
ID4gPiA+ICs2NDMsNyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9kZWFzc2VydF9jb3JlX3Jlc2V0
KHN0cnVjdA0KPiA+ID4gPiBpbXg2X3BjaWUNCj4gPiA+ICppbXg2X3BjaWUpDQo+ID4gPiA+IMKg
CXJldHVybiAwOw0KPiA+ID4gPg0KPiA+ID4gPiDCoGVycl9jbGtzOg0KPiA+ID4gPiAtCWlmIChp
bXg2X3BjaWUtPnZwY2llICYmIHJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0NCj4gPiA+
ID4gPnZwY2llKSA+IDApIHsNCj4gPiA+ID4gKwlpZiAoaW14Nl9wY2llLT52cGNpZSkgew0KPiA+
ID4gPiDCoAkJcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+ID4g
PiA+IMKgCQlpZiAocmV0KQ0KPiA+ID4gPiDCoAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGRp
c2FibGUgdnBjaWUNCj4gPiA+ID4gcmVndWxhdG9yOiAlZFxuIiwgQEANCj4gPiA+IC0xMDI2LDYN
Cj4gPiA+ID4gKzEwMTYsOSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9yZXN1bWVfbm9pcnEoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiA+ID4gPiDCoAkJcmV0dXJuIDA7DQo+ID4gPiA+DQo+ID4gPiA+
IMKgCWlteDZfcGNpZV9hc3NlcnRfY29yZV9yZXNldChpbXg2X3BjaWUpOw0KPiA+ID4gPiArCWlm
IChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+ID4gPiArCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2X3Bj
aWUtPnZwY2llKTsNCj4gPiA+ID4gKw0KPiA+ID4gVGhpcyBvbmUgbG9va3MgbWlzcGxhY2VkLiBT
dXJlbHkgeW91IHdhbnQgdGhlIHJlZ3VsYXRvciB0byBiZSBvbg0KPiA+ID4gd2hlbiByZXN1bWlu
ZyB0aGUgUENJZSBzdWJzeXN0ZW0uIElzbid0IHRoaXMganVzdCBwYXBlcmluZyBvdmVyIGENCj4g
PiA+IHdyb25nIHVzYWdlIGNvdW50IGhlcmUsIGJlY2F1c2UgdGhlcmUgaXMgbm8gcmVndWxhdG9y
X2Rpc2FibGUgaW4NCj4gPiA+IGlteDZfcGNpZV9zdXNwZW5kX25vaXJxLCB3aGVyZSBJIHdvdWxk
IGV4cGVjdCB0aGlzIHRvIGhhcHBlbj8NCj4gPiA+DQo+ID4gSGkgTHVjYXM6DQo+ID4gVGhhbmtz
IGZvciB5b3VyIGNvbW1lbnRzLg0KPiA+IFRoZXJlIHdhcyBvbmUgcmVndWxhdG9yX2Rpc2FibGUo
KSBvcGVyYXRpb24gYXQgdGhlIGVuZCBvZiB0aGUNCj4gPiDCoGlteDZfcGNpZV9hc3NlcnRfY29y
ZV9yZXNldCgpIGZ1bmN0aW9uIGJlZm9yZS4NCj4gPiBXaGVuIGNyZWF0ZSB0aGUgNS84IHBhdGNo
LCBJIGZvbGxvdyB0aGUgc2FtZSBiZWhhdmlvciB0byBkaXNhYmxlIHRoZQ0KPiA+IHJlZ3VsYXRv
ciBqdXN0IGJlaGluZCB0aGUgaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgZnVuY3Rpb24u
DQo+ID4NCj4gPiBZZXMsIGl0IGlzLiBJbXg2X3BjaWVfc3VzcGVuZF9ub2lycSBkb2Vzbid0IGhh
dmUgdGhlDQo+ID4gcmVndWxhdG9yX2Rpc2FibGUuDQo+ID4gVGhlIHJlZ3VsYW9yX2VuYWJsZSBp
cyBjb250YWluZWQgaW4gaW14Nl9wY2llX2RlYXNzZXJ0X2NvcmVfcmVzZXQoKS4NCj4gPiBCb3Ro
IG9mIHRoZSByZWd1bGF0b3JfZGlzYWJsZSBhbmQgcmVndWxhdG9yX2VuYWJlIGFyZSBpbnZva2Vk
IG9uY2UgaW4NCj4gPiDCoGlteDZfcGNpZV9yZXN1bWVfbm9pcnEuDQo+ID4gU28sIHRoZSByZWd1
bGF0b3IgaXMgb24gYW5kIGhhcyBhIGJhbGFuY2VkIHVzYWdlIGNvdW50IGFmdGVyIHJlc3VtZS4N
Cj4gPg0KPiANCj4gWWVhLCBteSBhcmd1bWVudCBpcyB0aGF0IHdoZW4gd2UgYXJlIG1vdmluZyBh
cm91bmQgdGhlIHJlZ3VsYXRvciBoYW5kbGluZw0KPiBhbnl3YXlzLCB3ZSBzaG91bGQgbW92ZSB0
aGUgcmVndWxhdG9yX2Rpc2FibGUgaW50byB0aGUgc3VzcGVuZCBmdW5jdGlvbi4gSXQncw0KPiB0
aGUgcmlnaHQgdGhpbmcgdG8gZG86IHdlIGRvbid0IHdhbnQgdGhlIGJ1cyB0byBiZSBwb3dlcmVk
IHdoZW4gdGhlIHN5c3RlbSBpcw0KPiBpbiBzdXNwZW5kIGFuZCB3aGlsZSB0aGUgdXNlLWNvdW50
IGlzIGNvcnJlY3QsIGl0J3MgY29uZnVzaW5nIHRvIHJlYWQgdGhlIHJlc3VtZQ0KPiBmdW5jdGlv
biBvdGhlcndpc2UuDQo+IA0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5Lg0KVW5kZXJzdGFu
ZC4gSSB3b3VsZCBtb3ZlIHRoZSByZWd1bGF0b3JfZGlzYWJsZSBhdCB0aGUgZW5kIG9mIHRoZSBz
dXNwZW5kDQogZnVuY3Rpb24gaWYgeW91J3JlIGZpbmUgd2l0aCBpdC4NCg0KQmVzdCBSZWdhcmRz
DQpSaWNoYXJkIFpodQ0KDQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQoNCg==
