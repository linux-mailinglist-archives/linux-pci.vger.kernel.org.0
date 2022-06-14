Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531FE54A35B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 03:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241423AbiFNBAx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 21:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiFNBAw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 21:00:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80051.outbound.protection.outlook.com [40.107.8.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93A2D1E7;
        Mon, 13 Jun 2022 18:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO4oDKwww/xIeJ/nC5AHGxidKlQU5kQLLVb5guFwFXaMqyBiDWY0I0qHbwtYQBbTwfniSNDXWm3sZuz1Ju6NkRS8NxcAMIeIE7o1cuEcI7ZuAicBIGhvYlR/m3r6P52mkZogkeBBieVzP5BMZY2++LQKk0MYzC4QCZa5iNw1c/pkcUW7LRObq8LL3t8xbiT15LdbhKh2rZEpwDYO0UW2l5L5FwVJUGV6iRKYqA4LoNpBB3zdasrPI1nqznn4NXJuBijePLKQo0ay8Fvjinv5S1sLidjYKGzSeXp5Dz96ONdmee+9d5F5hWNYftwapXKqB3L2MBmOzoY4qT+ZuhAanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw12oSI+gVmEiHxi6HUzNqcLYFy5lwUjk+P26HmA1ZM=;
 b=jxomwTy6BkT/JZSkoWpRBhxYFostOakUqlwBfleGL4gqHYxJiIZ2Hd3gPj5oSk8cC+GHJXmYYDUH7j2Jw36k0UGcwyXmjwS70HiIvFpGiOx2bmyrJQin2dCXRM7M+/+8oTVyBItO6a0hcbz9Eo+bgl0luoQzZ6MDqoSZDMerAiiAyYa6vUFVdnrzYFC4hhNnu6Jl4a0F6Gd9CtpvE+YX0vybHJC+Bms/Uw/cqXlyvOiLK1HqPBGE8jf1zi3Z6UErfgYgrNk2CHzjlg3tyRJbO+IN0eAyZC4fOPxq7xKa9mHo3oZAP9aXOOnk+CDR27iFq9x4DG4ap1wB3ijsNuY1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw12oSI+gVmEiHxi6HUzNqcLYFy5lwUjk+P26HmA1ZM=;
 b=gmAOQvrFHFMAuuJprm2oYQVTLaSwpZMQU4rVYHfSb4OfLKnml2zr7TVkZ7pm09AJrAaBdgbe3BbO4+wjvF0TAcfc+9VX99j+8vHtOCtSKuVMhvZfwgf54WQwlNeTSOLgylILkyZreqpqEhlBjbVSbJFFAubbDMSQyH2dR+P+3co=
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com (2603:10a6:10:2dc::14)
 by DB8PR04MB6537.eurprd04.prod.outlook.com (2603:10a6:10:10c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 01:00:48 +0000
Received: from DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::8589:5e05:4fcc:ccf4]) by DU2PR04MB8677.eurprd04.prod.outlook.com
 ([fe80::8589:5e05:4fcc:ccf4%9]) with mapi id 15.20.5332.021; Tue, 14 Jun 2022
 01:00:48 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v10 0/7] PCI: imx6: refine codes and add the error
 propagation
Thread-Topic: [PATCH v10 0/7] PCI: imx6: refine codes and add the error
 propagation
Thread-Index: AQHYfwVJdXlveKI8OEWYcdB0H17Ay61NzdiAgABIAkA=
Date:   Tue, 14 Jun 2022 01:00:47 +0000
Message-ID: <DU2PR04MB8677C097D892FEDEE2269CDE8CAA9@DU2PR04MB8677.eurprd04.prod.outlook.com>
References: <1655110538-10914-1-git-send-email-hongxing.zhu@nxp.com>
 <20220613204123.GA716053@bhelgaas>
In-Reply-To: <20220613204123.GA716053@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c44e21a1-96c8-45f3-28b4-08da4da1518f
x-ms-traffictypediagnostic: DB8PR04MB6537:EE_
x-microsoft-antispam-prvs: <DB8PR04MB653772AC59C127BBA9C584478CAA9@DB8PR04MB6537.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jg9Q/AHdoRelNYeeyG/nzmH//5NYXLaazLVwfWqjv4NTfJ6BcBSNdCnBQF7eIRPbrbSPzWEi3SOc48ccL+wfkJSL3nFdgwUTuWlEdtyeaRDCV9tm2IQSKE/BcpK+MQRB3596UpbR9Ey99LDpCbuycCJf9Wqwj5SsLI5oeaK90139ml5AgkvesJfQ2ghyMY9S47Iw2t4X0DdLCKU+2h435j8TGeXrQ0WUFCBQKGl9aZVI6TuYXy3vYlaKOl3/1mhzuohr+wVS11Ca97WgVikTb7blbi1u5nEinkbPrxxUcmzv+6+XFMzZ45wLoxNNfO2syOHUXBpgQssz31pyvgDM9tFtD2Y51ZezUzRSRG+QINYbgP98UF6S6DtGq1MLJPUSo4elYYoKT+p3tY/n/SllMV9YVA6XPeQmZ6JdEljJgF5IOP5jsdXXNW4lIuARpIxUs9iZIc9V5FxMRkjbMJymar749Rlwo6Nj+izIsyjOXDKT9bqJMIM2cGvsXjryUFagxRBhIU6+LVPNhwFcJDc3+/C0S9caSudJdq3Q7Y7k5eBNB3tcKKW5e+H0qEUV8h03YFaXvAuRJyMGTF6o4FE98+Lg2A3SSL4GRSvJ6+f6xF/z3jkp64u8oKx1kQRuK+9GvdNhURvn6GE+/v6fXxPjaM8eNe2J9BmAs55pcu6iSJ7e3W7Ht5yHz7iUEVleBUG6EUgxWv2vGFsCAZXCAqRzi8/Mat9U0F6R+lZFiUh5nz5nvxU1hYZop6uPFTONxV3SnXpLYopGCc2/MiMn95ntnMWc0IRTcPp9MixUH3pawsA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8677.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(54906003)(6916009)(26005)(316002)(7416002)(6506007)(38100700002)(53546011)(7696005)(71200400001)(508600001)(86362001)(44832011)(66446008)(5660300002)(33656002)(122000001)(45080400002)(186003)(966005)(55016003)(83380400001)(9686003)(76116006)(38070700005)(8676002)(64756008)(4326008)(66556008)(66476007)(52536014)(2906002)(66946007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dWZ4QXJIQnVtQmQybVM5dEgvSjROVWZsMTBTeVZLWm9wSnZZY1d1YlpVeDVY?=
 =?gb2312?B?RWpJdlRjYmdaYVJ2Skk5ek1QWnhlNkt4TmhOSUhaS3M5MUJPQ09wWFhpMC9k?=
 =?gb2312?B?VEs1dm5SZ3ZHZ3kxUERxNTlmdWNmU0RqK1FUVXA4Y2FHbjhBVURNS2lVZXV4?=
 =?gb2312?B?aHduWWtmSk1IQ0F2c1doQUFvNExLUUpYbDFzWEhUTWhiR2diVWxFdnZpWWNW?=
 =?gb2312?B?dWxGZlhLaDhBRlg1amZUSjVKbVZKVzFrU1pvUFBXZGcrSndSSkJhUC9ZUzk0?=
 =?gb2312?B?VzVIUlNpSU0wWXluTXpOcytNdEZUV3RacGdMb1l3TzJMZmhqSlQ0OFVtNHlV?=
 =?gb2312?B?eGp3MUFKaTBBUWtBUWxhNEJucFplT1JSbWhPaWdNRnp6MU1UQVlvN1haclhk?=
 =?gb2312?B?T0JFZ3c3WEpJTXBDWDRZeHZVd0IwR2RNVkJLL1B0VnF4NWk4cnVvVzlJU0hI?=
 =?gb2312?B?aXE0a3ZhNDk3RkVOT25DQ2duRllDTHhOMUNRdUIvMlRCdmdEYmNpRUlLTGYx?=
 =?gb2312?B?QXVwOWxnU0wyZVdkKzI2ZVlsZUdFRWVrWFZ2SlM4ai92aGJZcTNrdEZ3NnRq?=
 =?gb2312?B?bVhWN0liL3hSNWUxcWNuOUUyaDJ3THFkOHJhR1g3VmljT3RaNzhjOGlESDdE?=
 =?gb2312?B?ZzNzVUx4SnA4L2ZzKzQvbzdzY0FxMEMzc2tZUmtxZHNYNHpsQUN1aG1ZbzRU?=
 =?gb2312?B?Q211TWh6L3lPODZ3YW9hNWFkRGczL2lwdjluUHYydDR0VUs4djY0S3VoOTY2?=
 =?gb2312?B?a1hxM2FoN2NnVWJGZnNwWHZMUlZyWFJrdlZkeVNDeHF4Z3NWbm5mOTV1SGVQ?=
 =?gb2312?B?OGcydFUyNHhaMEFuSXNmN28reVBwcmVQdGNxRW1yR04wdVpqREhmTmcvOG1E?=
 =?gb2312?B?RDBwaDV4U1dvUER5eTRuZE9BYW9DOFRNMDh1WVVVb1lzLzFIWW5idkdTNUhX?=
 =?gb2312?B?YkdOZDJ5L01SYytZRE9ZZjJzbUdWNWx0OUNrclZqNGxGQy9jS1NEc3ppRERN?=
 =?gb2312?B?WXh6aktCOStKVmdieHE5bUxDNGJNVmZUaXJJNnorbHVCTXJnai9zQlV2R3U3?=
 =?gb2312?B?MHpoZExoczlwVmtaRG1VTngrSlhSTE1Ka1l1QnBPUlI2Y0hTM1huZ2U0d2tR?=
 =?gb2312?B?ckhrZ2I4YWFrc3pSK21YNGpGTDRsWGkwRjFvYi9KS1ZLajZKRHM2MDdiRUxN?=
 =?gb2312?B?VVhsMHpPRnhXVThXaDZWYmxBb1ppTTI1d2prN2pGSjVudUtVeGtDMHB5cm5t?=
 =?gb2312?B?UG8ySzR4cmpMZ0xrNmYwV1hCc0duZ1JnVVZWQjJjS1pxWndYOXkrcldRNVl4?=
 =?gb2312?B?SllRRTM4cDNSTm84RTJxRTJ3UGxyd083bG94RjFTb2ZUU2EzZ2NXcXdVSVpS?=
 =?gb2312?B?YVYwWTNNdWlZb1dESjNCNlVjSkNadFJQUEtlRHZjY1VrMFByMWx4MlFDMnhs?=
 =?gb2312?B?NWJWZmJVNE9QM3U3ZkIvK2tPT2lNQVNCakFGUXdaWU1JWXZhM0ZZbGlieEdk?=
 =?gb2312?B?bEF2M1NIZXRsdXRRRFFoekVud1orMk1xK2pwTkRXNFJIck1CY3libVVJbWNR?=
 =?gb2312?B?Snp6bmErcmxMekROYmdiMmxCdE1YOFFtRDcxd09aSHpzdE5sNjdvN2ZORERa?=
 =?gb2312?B?YjM0UHV4Z1h6UkxiL3BBS29qK2EyOWF1K0RRYmxLOXlRY0dueTlzUjEvRkU5?=
 =?gb2312?B?Lzlvc0xicHRRTFM5UTJicFE5UUo3OWZmdVRuRm40cEd2RGhwa0lOa2p4QkZP?=
 =?gb2312?B?QU9JWklTWloxTXpGeGVLQSt5ekxoZ0FDNXpIYzVqdThXcmwyOXd1ZjJiY2dC?=
 =?gb2312?B?dkhtVzYxc09nazVHb3NnL3dPalJ6aENzU082UFhsdXBSSzIrRDkvNHdXaUU5?=
 =?gb2312?B?Y281dE8zU0lwdnovMlZOb2kwMjlaQmNOSitIM0t2OFpvTTJ3RnFGaU1TWUg2?=
 =?gb2312?B?R2QxNUFTeFNJR2w1dGVibU1KbDZCMEZLOEQyVHlMZ0ZrZDNFdnMzT0FaRHpV?=
 =?gb2312?B?dWVtenpNekQ0VnlKOXdxWGhxL1d4MXRlWTY5TUFzSWtLNHpZRWxWdVE1OGdD?=
 =?gb2312?B?TmFveGlVT0JtYlp6aEYyY25aSXMveTVGV3krVXlMNDlrdlFIakZXR3FZS2NG?=
 =?gb2312?B?dHVxZHR1SlNpaWhzQXVmTjhpemc1cnZjZk1hcXRaMXNQak05blR2RmNJcXdC?=
 =?gb2312?B?TXVHVTB3emdud2tQYUlLMGg5bThrWWlXM2Q2SWNHWDViSzVWUWJaZDFaYlM5?=
 =?gb2312?B?SDhlUDZWUEFJeE9IVWdMQTMxY2ZQOHFoeG5aTmgwcGhkR0VmaTd0UVFvWDRh?=
 =?gb2312?B?L0p6K2NYajBvaGQydzVNdGFLRlRNNXppUmdpT21nM3dHbHlDbk5Edz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8677.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c44e21a1-96c8-45f3-28b4-08da4da1518f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 01:00:47.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNfBzCW76AWLNlOZ88OM4YOD/5Ips/j4AzYMiZgFkl0kEXdOS6zoa90XBRGfkbDp8XnFvsSW3RAKyY+26On11g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE0yNUgNDo0MQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYnJvb25pZUBr
ZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAgMC83XSBQQ0k6
IGlteDY6IHJlZmluZSBjb2RlcyBhbmQgYWRkIHRoZSBlcnJvcg0KPiBwcm9wYWdhdGlvbg0KPiAN
Cj4gT24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMDQ6NTU6MzFQTSArMDgwMCwgUmljaGFyZCBaaHUg
d3JvdGU6DQo+ID4gVGhpcyBzZXJpZXMgcGF0Y2hlcyByZWZpbmUgcGNpLWlteDYgZHJpdmVyIGFu
ZCBkbyB0aGUgZm9sbG93aW5nIG1haW4gY2hhbmdlcy4NCj4gPiAtIEVuY2Fwc3VsYXRlIHRoZSBj
bG9jayBlbmFibGUgaW50byBvbmUgc3RhbmRhbG9uZSBmdW5jdGlvbg0KPiA+IC0gQWRkIHRoZSBl
cnJvciBwcm9wYWdhdGlvbiBmcm9tIGhvc3RfaW5pdCBhbmQgcmVzdW1lDQo+ID4gLSBUdXJuIG9m
ZiByZWd1bGF0b3Igd2hlbiB0aGUgc3lzdGVtIGlzIGluIHN1c3BlbmQgbW9kZQ0KPiA+IC0gTGV0
IHRoZSBwcm9iZSBzdWNjZXNzZnVsbHkgd2hlbiBsaW5rIG5ldmVyIGNvbWVzIHVwDQo+ID4gLSBE
byBub3QgaGlkZSB0aGUgcGh5IGRyaXZlciBjYWxsYmFja3MgaW4gY29yZSByZXNldCBhbmQgY2xr
X2VuYWJsZS4NCj4gDQo+IFRoaXMgZG9lc24ndCBhcHBseSBvbiB2NS4xOS1yYzEgZm9yIG1lLiAg
QW0gSSBtaXNzaW5nIHNvbWV0aGluZzoNCkhpIEJqb3JuOg0KVGhlIFYxMCBwYXRjaCBiYXNlZCBv
biBTaGF3bidzIGZvci1uZXh0IGJyYW5jaC4NCkkgd291bGQgcmViYXNlZCB0aGVtIG9uIHY1LjE5
LXJjMSBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IA0KPiAgIDAzOjM4
OjA2IH4vbGludXggKG1haW4pJCBnaXQgY2hlY2tvdXQgLWIgd2lwL3JpY2hhcmQtaW14Ni1wb3dl
ci12MTANCj4gdjUuMTktcmMxDQo+ICAgU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd3aXAvcmlj
aGFyZC1pbXg2LXBvd2VyLXYxMCcNCj4gICAwMzozODoxNCB+L2xpbnV4ICh3aXAvcmljaGFyZC1p
bXg2LXBvd2VyLXYxMCkkIGI0IGFtIC1vbS8NCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJv
dGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXINCj4gbmVsLm9y
ZyUyRnIlMkYxNjU1MTEwNTM4LTEwOTE0LTEtZ2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1JTQw
bnhwLmNvDQo+IG0mYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1
YzJkYmJlODE3Yjk0ZjkwDQo+IDkxOTUwOGRhNGQ3ZDE2YmIlN0M2ODZlYTFkM2JjMmI0YzZmYTky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTcNCj4gQzYzNzkwNzQ5Njg5NzMwNjMxMyU3Q1Vua25vd24l
N0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3DQo+IE1EQWlMQ0pRSWpvaVYybHVNeklpTENK
QlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyUNCj4gN0MmYW1wO3NkYXRh
PWJDTWhiQnhSTlY4RDBsblZCeFVSVUZSYnRNTkFEVXhaSnE0d1p6NDdyS1klM0QmDQo+IGFtcDty
ZXNlcnZlZD0wDQo+ICAgTG9va2luZyB1cA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcg0KPiBuZWwub3Jn
JTJGciUyRjE2NTUxMTA1MzgtMTA5MTQtMS1naXQtc2VuZC1lbWFpbC1ob25neGluZy56aHUlMjU0
MG54cC4NCj4gY29tJmFtcDtkYXRhPTA1JTdDMDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdD
NWMyZGJiZTgxN2I5NGYNCj4gOTA5MTk1MDhkYTRkN2QxNmJiJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwJTdDMA0KPiAlN0M2Mzc5MDc0OTY4OTczMDYzMTMlN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGoNCj4gQXdNREFpTENKUUlqb2lWMmx1TXpJaUxD
SkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlNw0KPiBDJTdDJmFtcDtzZGF0
YT1zM0ZWTGl3Sm5lUWxRUFYxS0tqNGNQSjJqRCUyRnRLdWRrcVA0d2QwTEFDZ0klM0QNCj4gJmFt
cDtyZXNlcnZlZD0wDQo+ICAgQW5hbHl6aW5nIDkgbWVzc2FnZXMgaW4gdGhlIHRocmVhZA0KPiAg
IENoZWNraW5nIGF0dGVzdGF0aW9uIG9uIGFsbCBtZXNzYWdlcywgbWF5IHRha2UgYSBtb21lbnQu
Li4NCj4gICAtLS0NCj4gICAgIFtQQVRDSCB2MTAgMS83XSBQQ0k6IGlteDY6IEVuY2Fwc3VsYXRl
IHRoZSBjbG9jayBlbmFibGUgaW50byBvbmUNCj4gc3RhbmRhbG9uZSBmdW5jdGlvbg0KPiAgICAg
W1BBVENIIHYxMCAyLzddIFBDSTogaW14NjogQWRkIHRoZSBlcnJvciBwcm9wYWdhdGlvbiBmcm9t
IGhvc3RfaW5pdA0KPiAgICAgW1BBVENIIHYxMCAzLzddIFBDSTogaW14NjogTW92ZSBpbXg2X3Bj
aWVfY2xrX2Rpc2FibGUoKSBlYXJsaWVyDQo+ICAgICBbUEFUQ0ggdjEwIDQvN10gUENJOiBpbXg2
OiBEaXNhYmxlIGlNWDZRREwgUENJZSBSRUYgY2xvY2sgd2hlbiBkaXNhYmxlDQo+IFBDSWUgY2xv
Y2tzDQo+ICAgICBbUEFUQ0ggdjEwIDUvN10gUENJOiBpbXg2OiBUdXJuIG9mZiByZWd1bGF0b3Ig
d2hlbiB0aGUgc3lzdGVtIGlzIGluDQo+IHN1c3BlbmQgbW9kZQ0KPiAgICAgW1BBVENIIHYxMCA2
LzddIFBDSTogaW14NjogTWFyayB0aGUgbGluayBkb3duIGFzIG5vbmUgZmF0YWwgZXJyb3INCj4g
ICAgIFtQQVRDSCB2MTAgNy83XSBQQ0k6IGlteDY6IERvIG5vdCBoaWRlIHBoeSBkcml2ZXIgY2Fs
bGJhY2tzIGFuZCByZWZpbmUgdGhlDQo+IGVycm9yIGhhbmRsaW5nDQo+ICAgLS0tDQo+ICAgVG90
YWwgcGF0Y2hlczogNw0KPiAgIC0tLQ0KPiAgIENvdmVyOg0KPiBtL3YxMF8yMDIyMDYxM19ob25n
eGluZ196aHVfcGNpX2lteDZfcmVmaW5lX2NvZGVzX2FuZF9hZGRfdGhlX2Vycm9yXw0KPiBwcm9w
YWdhdGlvbi5jb3Zlcg0KPiAgICBMaW5rOg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsb3JlLmtlcg0KPiBuZWwub3Jn
JTJGciUyRjE2NTUxMTA1MzgtMTA5MTQtMS1naXQtc2VuZC1lbWFpbC1ob25neGluZy56aHUlNDBu
eHAuY28NCj4gbSZhbXA7ZGF0YT0wNSU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzVj
MmRiYmU4MTdiOTRmOTANCj4gOTE5NTA4ZGE0ZDdkMTZiYiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5YzVjMzAxNjM1JTdDMCU3QzAlNw0KPiBDNjM3OTA3NDk2ODk3MzA2MzEzJTdDVW5rbm93biU3
Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXcNCj4gTURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdDJTdDJQ0KPiA3QyZhbXA7c2RhdGE9
YkNNaGJCeFJOVjhEMGxuVkJ4VVJVRlJidE1OQURVeFpKcTR3Wno0N3JLWSUzRCYNCj4gYW1wO3Jl
c2VydmVkPTANCj4gICAgQmFzZTogbm90IHNwZWNpZmllZA0KPiAJIGdpdCBhbQ0KPiBtL3YxMF8y
MDIyMDYxM19ob25neGluZ196aHVfcGNpX2lteDZfcmVmaW5lX2NvZGVzX2FuZF9hZGRfdGhlX2Vy
cm9yXw0KPiBwcm9wYWdhdGlvbi5tYngNCj4gICAwMzozODoyNyB+L2xpbnV4ICh3aXAvcmljaGFy
ZC1pbXg2LXBvd2VyLXYxMCkkIGdpdCBhbQ0KPiBtL3YxMF8yMDIyMDYxM19ob25neGluZ196aHVf
cGNpX2lteDZfcmVmaW5lX2NvZGVzX2FuZF9hZGRfdGhlX2Vycm9yXw0KPiBwcm9wYWdhdGlvbi5t
YngNCj4gICBBcHBseWluZzogUENJOiBpbXg2OiBFbmNhcHN1bGF0ZSB0aGUgY2xvY2sgZW5hYmxl
IGludG8gb25lIHN0YW5kYWxvbmUNCj4gZnVuY3Rpb24NCj4gICBlcnJvcjogcGF0Y2ggZmFpbGVk
OiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jOjUzOQ0KPiAgIGVycm9yOiBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jOiBwYXRjaCBkb2VzIG5vdCBhcHBs
eQ0KPiAgIFBhdGNoIGZhaWxlZCBhdCAwMDAxIFBDSTogaW14NjogRW5jYXBzdWxhdGUgdGhlIGNs
b2NrIGVuYWJsZSBpbnRvIG9uZQ0KPiBzdGFuZGFsb25lIGZ1bmN0aW9uDQo+ICAgaGludDogVXNl
ICdnaXQgYW0gLS1zaG93LWN1cnJlbnQtcGF0Y2gnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+
ICAgV2hlbiB5b3UgaGF2ZSByZXNvbHZlZCB0aGlzIHByb2JsZW0sIHJ1biAiZ2l0IGFtIC0tY29u
dGludWUiLg0KPiAgIElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBh
bSAtLXNraXAiIGluc3RlYWQuDQo+ICAgVG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFu
ZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAtLWFib3J0Ii4NCg0K
