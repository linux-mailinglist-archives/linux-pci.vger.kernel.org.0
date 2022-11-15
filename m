Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76227628FDE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Nov 2022 03:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiKOCZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 21:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiKOCZU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 21:25:20 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935CFE4D;
        Mon, 14 Nov 2022 18:25:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACe0frC3D+acdWVaMZ5XhJAaqz6B0/6JxUqFWyNtjlmfYPkgnHRCW1QqQgejZdpv8vA01/OshiqAiz06r5UjMyGKaP8zkfsVibMLYNMzJJA2z2a/6mV3hdi4EcAqLbXVFDwreBwyHShdn1g6/IPX9lG56m/0ve5oDEnkmNawkfm63iOpH22minEohURWhfkvyixRON9p2by7QpmVyMonREUZZMu5Ckfasyhig2ZQ3LoIoJxZczeQOuYush4HFFIitu4ZgNRFgT0KfYNQuNc7n4fOX8Y/mu9+m1Pwbb0cFGYGZkrnbgWRByWcar78MPkUvWGUrTKfWYc809mD0JCKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNP1q8OjSR2zaneVtY1HA6RM24xSeKbxSbqDUbyhQ7k=;
 b=D+s6xUQF2rc4VBNrQ5zmWZZy1bpkf7Nq4h35HwYcEGl3xzydy7ocOQTOsKl26RVfScbXbjRYoF4j0dgJFKZK36jbBFWs4FfwBvliNw9qDNI95SKUYuqj2Uh0MbffVlQ5ARezvJFFQyVgaTNEQ6mwnDTA5iLKc7+BiNa3sxcjuzWxlz4YTDdxodFxfsUpy55kci3GS7kDlInt/QVAzEVs0FnoA1pS2xJcy26oY2MK+RJ+C5u0g2kUKweovhKZ3PegA/lr1jPatkjWO/zW3chzVj5COTAlw5uGdDB2nSjqaR5kIDEf5Y06SSlKrWea4q2Qe2y7C+X8s7CtIAMTLYEesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNP1q8OjSR2zaneVtY1HA6RM24xSeKbxSbqDUbyhQ7k=;
 b=JOXH+D0pzsjt/W4CHUvcrLAU4d74xozFYJKPsiI+ksnMFZjepw1HKb9G3bjoXZa1Nlc9A3TRfZiKE+Z29q3jruhtXU5+bAqY1rwEPeIsosxhKB2R/fP/BxomL826aDsHW+LSKqsQeeeoYsIMRzltBUBuGO5TsjtEwJgDGtcTlZI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8331.eurprd04.prod.outlook.com (2603:10a6:10:244::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 02:25:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 02:25:13 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "marex@denx.de" <marex@denx.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: RE: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Topic: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Index: AQHY525Z8iyK/13unkqieo1kWL6laq4lFqkAgAS214CAAQ+6AIAUgtVA
Date:   Tue, 15 Nov 2022 02:25:13 +0000
Message-ID: <AS8PR04MB867694E27FE6DD87BA9EAE358C049@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
         <20221029084514.GT125525@dragon>
 <ae0fd778eb31416eedb248e2cd4faef576174937.camel@pengutronix.de>
 <AS8PR04MB8676B7207B48F94BF12C88EE8C399@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676B7207B48F94BF12C88EE8C399@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DB9PR04MB8331:EE_
x-ms-office365-filtering-correlation-id: e02888cd-bf9a-45b6-fc70-08dac6b0a063
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtJW20gbesI5ztBOEVczNgwt2MuTwGyF3zPF2cOCRRz6dPlqKw8cUoZLFvJw2ZAxYY6WHzQg88zMXWtVOHMyOUpbjTaGqunsk9BPP7FU99e9rGDK+yDLgoVYaXi2IYHBJ4gM2XHX/0Uh+P21WDLu9rbWTFnm6D04vTz21lpwPm98HOtONIhYP03aBR8f7cHtz7HWxmW2A0VT2c2L80VPowyazSHOeo/Nxn3ld9Q+qy7Ir43V72zvZV3RNrcdviRtx5VdewMz+R9dSatd3G8L2IoEOEOr6HDnFF2pMosYfAflpGzepP8YNY1ggXCCSDjLXVUueVryZjyMd+snQKq6CTB4hirCIGEkHm6EZwD/wQ+PGdSla+MyPqYDmsdH9Q+heudFohI74p93ooN4JDAhOIbmHjZOy3BtIINmq8rn9U5LjH5KWbnAeuhd4XUWcllT1cjf1n+Cj8UXlye0xGabguV0uyyWIBXK2E0iNhyzy8XDhheEbVRSw4R9d+xCXK6CiH2AdyLcMO7NbqjN6e8ilWMAAfxSSV6Fk6UasczgSzlc5etmAIZ5mXUZqsZ/X+pBFz03wojiq5uUPqhJNcTXlcDNSXpDy0gUUPHduUcqZK4Zy0EPd46TNG/lZ0eBSS6iQ7MH2zvK7gcrMuSu/EXC4kTLrQktMKbrnN32TMEhdfg4RZlYshwGD87MduXgoZGhpBsh5x7nePQAohJNRz59P6q6J1euUK+IZWDv0Jo+1frw7r93aDuNZ53lO5sBxvI2W9kXH2qfjDw1Phj6n1/3qeVSfu/zBCpMqAquTa32aSI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(52536014)(8936002)(38070700005)(478600001)(7696005)(33656002)(5660300002)(2906002)(122000001)(54906003)(110136005)(316002)(71200400001)(55016003)(64756008)(86362001)(66446008)(7416002)(66476007)(76116006)(66556008)(66946007)(186003)(41300700001)(4326008)(8676002)(26005)(9686003)(83380400001)(53546011)(44832011)(38100700002)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3pueW5OWjE5RTYwdHpJKzQ5SVdWRm5JQ1BLcjlYL21mRFdWWmRoVjk1b3NT?=
 =?utf-8?B?cVNaREtrWGFtRWoyZTIvVVZSV050RnlXbFpCSXZ5cDQ1c0VFeTNSMXpYZkl1?=
 =?utf-8?B?S1hKejNOWVBrY205czhRMWY3UzNUZlJEeGlCb2xHUzVCdGpuTHVjNFNEWmxH?=
 =?utf-8?B?Qys4NFVNdy9Wa3lXVnVLWno5NUhjdGY0Q3FzbWlVT2ovazFXS3BPamlSWTRo?=
 =?utf-8?B?ZTJnNHAralc0UVZxeDNGTmJ4Z2hseFlKSVJYOFlENG5od0NhNnY0TXM1Kysy?=
 =?utf-8?B?ZnNIQjBYTzkrOUppUTBqdzJkbzJXeGlNYnRUVm4wK2hvZHNPTUFoVEFQMnVp?=
 =?utf-8?B?Wm5NWmREK2tvUjBMY0UyWVdBeFRORHNHV1hqQkVqMjNoKy9jTHd3TlRQNDkr?=
 =?utf-8?B?N1NMQU1SZFhPREhSOTM0S0wxQWtLdnhzbFkyaVQrWW9scnhaNXRKekhyTStm?=
 =?utf-8?B?RUtCNFNJbXZiYjJ3Z3E2bVVab0x0cVJmeTFMdmIvMWQxNEVtamNta0gvditj?=
 =?utf-8?B?c3NCd1l3NXpjaHVNbGw2TCtvNFVvcVFlaWRxYm14a3Rhc2tXNTRFT0k0c0dL?=
 =?utf-8?B?NkM0U3NSQnNTNzkxZ0dzLzBWalg5aEdCYnFlN1kySDFqcTc3Yy9DZ25nNGxN?=
 =?utf-8?B?R2tXWjdlRGxQekRvdE1xWGpmbUx5MHJ5RG5xc0JENnRiZ1ZEVkFUcGRteXc4?=
 =?utf-8?B?QTVnMUhqQU9PUjd5aWR2WVlVWUhPM2tnQTJ4VmdQTjByTzdTRitmVk5tWGx5?=
 =?utf-8?B?aGVrTHBMa2RzTmliaWtYNzJqeXBuZVZwekZsc2FtdnJlazI4M2NQdW1UTVY5?=
 =?utf-8?B?MEMxcGdhVjVaRmJuN0hlWFBIUTNoaEk5aTRHaVRLREd3WkRmWDc2RnY3dXo2?=
 =?utf-8?B?dTFEMkREOUVmYXJTODVkSFgvRlpKQXVEczNsYWJjVU9iYk9EdTUvYndYV2xH?=
 =?utf-8?B?Nm9nYVpoM2FpY0orb3h2Z3NSME13cEZDem55RHh1ZUZDSjgydXBxWFJHSUdT?=
 =?utf-8?B?Z1RCMWFDK3NCUEF5eEcyblVCZlBieFZjbmhlcTMycW1OODlLU080VStidTZs?=
 =?utf-8?B?YUYrc2ZwWWlQSFlrQU5YaXZ0YjZGTjFSZVg2VFJxUDlCak5OY2dnU25HVEpG?=
 =?utf-8?B?QUc5TFVjTzFSZWVGU2YxRTZXTnFtSVduem1JaURvUDVYa1RLR2twck5RQldx?=
 =?utf-8?B?TUJTTUJadUF5WVpIYVdzRndkQlFpRC8rNGhCSGIrR2hiZTZQRG0xQmxMb1Jv?=
 =?utf-8?B?QmRucm90bWlsTjllU05XK2FYa1l5QWF2VFFuWkdaSC9VY3NRL1BEWWRrSGFT?=
 =?utf-8?B?eExEZzl2cTFtZDJEU0JPbXFrajdSVVpQZ3B3aEhJb2d0VjhXUU1HcG5wZGNr?=
 =?utf-8?B?TytFblkzeThsWTBFcVdQRjYxeE9BSjRKZHREcWFMQ04zVHpjT0VmeXhTN1Bs?=
 =?utf-8?B?Y0tJVzdReUJkUk9WaWxrTjFkTjhjMHRSdVZBY3Z4K3piZzFzS2FkZ1ZiY0Y0?=
 =?utf-8?B?SDIzUXBVSWhPMXdJbWZSWCs2cWd4WG1DWVY0WFZZNjZwTFY3bUIyZWVYNXVK?=
 =?utf-8?B?dFAxV0lUTzBiTzRFNGFTbGlad0hUTWFTMWtnbjc2NHVSNjdjSHlVU3Q2MDNJ?=
 =?utf-8?B?MGo5b0NUUThUc1IzK3lYdEVTMTZpNXNUcldsbnNzREpKU1N1Qk9pUVhCZ2VI?=
 =?utf-8?B?blJSRngwb1RMeEREVUVvN1lJdUxZNVJ5Vld0dUUxQXZGR2cvd3BXalZ1VmNJ?=
 =?utf-8?B?ZC9ZeDV2QlU4eWl1TmZLTjdnMWcxU1ErSU9DbjhJSmtMcmFkZkE2K0t4L0NY?=
 =?utf-8?B?a2FDS2FTd2YreGdhVkh0VVlESC8wSzNLcXBQS01qNTFEMkk1VFp4RGNuN0ZH?=
 =?utf-8?B?c3FJZ0xYcUdlNDJoY24xcnBPY2M3ZGF3blNJMnUwZDFlenk3Ykp6SUIxWVBm?=
 =?utf-8?B?emIrY2gzN0RtVUpqR0NGTDVidU9qWnBETHh5WHVWbmZLT040VzI4bExlSU5w?=
 =?utf-8?B?eWM2U0pRazJWQjY4NEMrLzQ2OFhHVGQ4eFVMVVVUWTIwT1dTd01ZU051THdX?=
 =?utf-8?B?c1pDVnJQbXRGdFB3ZXhTRnU0YWlRWk94cTk1RTh4bHVNWHdtR1E1cDJwZk41?=
 =?utf-8?Q?CwO9jUSNqMeihtnJRHfI+0LU1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02888cd-bf9a-45b6-fc70-08dac6b0a063
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 02:25:13.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7rgmEe9zuVsFpg8ptVRpYTErgu5x38482Ja+Lknzmaw1pGmMuvkcjAw/oTXyaTBMSTP9RC4nT98A99+f3aTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8331
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyMuW5tDEx5pyIMuaXpSA5OjQ2DQo+IFRvOiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5n
dXRyb25peC5kZT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gQ2M6IG1hcmV4
QGRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgdmtvdWxAa2VybmVsLm9yZzsNCj4gYmhl
bGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gYWxleGFuZGVy
LnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgcmljaGFyZC5sZWl0bmVyQGxpbnV4LmRldjsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPjsNCj4gbWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tDQo+IFN1YmplY3Q6IFJF
OiBbUEFUQ0ggdjFdIHNvYzogaW14OiBpbXg4bXAtYmxrLWN0cmw6IEFkZCBQQ0llIFNZU1BMTA0K
PiBjb25maWd1cmF0aW9ucw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+IFNlbnQ6IDIw
MjLlubQxMeaciDHml6UgMTY6NDUNCj4gPiBUbzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwu
b3JnPjsgSG9uZ3hpbmcgWmh1DQo+ID4gPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IENjOiBt
YXJleEBkZW54LmRlOyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IHZrb3VsQGtlcm5lbC5vcmc7DQo+
ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gPiBh
bGV4YW5kZXIuc3RlaW5AZXcudHEtZ3JvdXAuY29tOyByaWNoYXJkLmxlaXRuZXJAbGludXguZGV2
Ow0KPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gc29j
OiBpbXg6IGlteDhtcC1ibGstY3RybDogQWRkIFBDSWUgU1lTUExMDQo+ID4gY29uZmlndXJhdGlv
bnMNCj4gPg0KPiA+IEhpIFNoYXduLCBSaWNoYXJkLA0KPiA+DQo+ID4gQW0gU2Ftc3RhZywgZGVt
IDI5LjEwLjIwMjIgdW0gMTY6NDUgKzA4MDAgc2NocmllYiBTaGF3biBHdW86DQo+ID4gPiBPbiBN
b24sIE9jdCAyNCwgMjAyMiBhdCAwMTo0MzowOVBNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToN
Cj4gPiA+ID4gQWRkIFBDSWUgU1lTUExMIGNvbmZpZ3VyYXRpb25zLCB0aHVzIHRoZSBpbnRlcm5h
bCBTWVNQTEwgY2FuIGJlDQo+ID4gPiA+IHVzZWQgYXMgaS5NWDhNUCBQQ0llIHJlZmVyZW5jZSBj
bG9jay4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIGZvbGxvd2luZyBwcm9wZXJ0aWVzIG9mIFBIWSBk
dHMgbm9kZSBzaG91bGQgYmUgY2hhbmdlZCBhY2NvcmRpbmdseS4NCj4gPiA+ID4gICAtIFNldCAn
ZnNsLHJlZmNsay1wYWQtbW9kZScgYXMgJzxJTVg4X1BDSUVfUkVGQ0xLX1BBRF9PVVRQVVQ+Jy4N
Cj4gPiA+ID4gICAtIENoYW5nZSAnY2xvY2tzJyB0byAnPCZjbGsgSU1YOE1QX0NMS19IU0lPX1JP
T1Q+Jy4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiA+ID4NCj4gPiA+IEFwcGxpZWQsIHRoYW5rcyENCj4gPg0KPiA+
IFNvcnJ5IGZvciB0aGUgbGF0ZSByZXBseSwgYnV0IEknbSBub3QgcmVhbGx5IGhhcHB5IHdpdGgg
dGhlIGZhY3QgdGhhdA0KPiA+IHRoZSBQTEwgaXMgbm93IHVuY29uZGl0aW9uYWxseSBlbmFibGVk
LCBldmVuIHRob3VnaCBpdCBpcyBvbmx5IG5lZWRlZA0KPiA+IHdoZW4gdGhlcmUgaXMgbm8gZXh0
ZXJuYWwgcmVmZXJlbmNlIGNsb2NrIHNvdXJjZS4NCj4gPiBJIGZlYXIgdGhhdCB0aGlzIHdpbGwg
YmUgaGFyZCB0byBjb3JyZWN0IGxhdGVyIG9uIGFzIHRoZSBEVA0KPiA+IGFic3RyYWN0aW9uIGlz
IHdyb25nLCBhcyBJTVg4TVBfQ0xLX0hTSU9fUk9PVCBpcyBOT1QgdGhlIHJlZmVyZW5jZQ0KPiA+
IGNsb2NrIGZvciB0aGUgUEhZLCBidXQgdGhlIFBMTCBnZW5lcmF0ZWQgY2xvY2ssIHdoaWNoIGlz
bid0IHByb3Blcmx5IGV4cG9zZWQNCj4gd2l0aCB0aGlzIHNlcmllcy4NCj4gSGkgTHVjYXM6DQo+
IEZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KPiANCj4gSU1ITywgSSdt
IG5vdCBzdXJlIGl0J3MgcHJvcGVyIG9yIG5vdCB0byBkZXNjcmliZSB0aGUgaGFyZHdhcmUgbG9n
aWMgaW4gIHRoZQ0KPiBQSFkgbm9kZSB3aGVuIGludGVybmFsIFNZU1BMTCBpcyB1c2VkIGFzIFBD
SWUgUEhZIHJlZmVyZW5jZSBjbG9jay4NCj4gU28sIEknbSB0cnlpbmcgdG8gZ2V0IHNvbWUgc3Vn
Z2VzdGlvbnMgYW5kIHVzZWQgdG8gc2VuZCBvdXQgYW4gZW1haWwgdG8gIHlvdQ0KPiBhbmQgTWFy
Y2VsIG9uIFNlcDIwLg0KPiANCj4gT2theSwgaWYgeW91IHRoaW5rIGl0J3Mgbm90IGNvcnJlY3Qg
dG8gZXhwb3NlIElNWDhNUF9DTEtfSFNJT19ST09UIGNsb2NrDQo+IG91dC4NCj4gV2hpY2ggY2xv
Y2sgeW91IGFyZSBwcmVmZXIgdG8gdXNlIGFzIFBIWSByZWZlcmVuY2UgY2xvY2sgaGVyZT8NCj4g
DQo+IFRoYW5rcy4NCj4gDQo+IEJlc3QgUmVnYXJkcw0KPiBSaWNoYXJkIFpodQ0KPiA+DQo+ID4g
SSdtIG5vdCBoYXBweSB0byBzZWUgdGhpcyBnb2luZyBpbiBpbiB0aGUgY3VycmVudCBzdGF0ZSBh
bmQgaWYgbm90IHRvbw0KPiA+IGxhdGUgd291bGQgbGlrZSB0byBhc2sgU2hhd24gdG8gcmVtb3Zl
IGl0IGZyb20gdGhlIHRyZWUgYWdhaW4uDQpIaSBMdWNhczoNClJlZmVyIHRvIHRoZSAiUmVmZXJl
bmNlIENsb2NrIFNlY3Rpb24iIG9mIGkuTVg4TVAgUENJZSBQSFkgZG9jdW1lbnQuDQpJX3BsbF9y
ZWZjbGtfZnJvbV9zeXNwbGwgY2xvY2sgaXMgdXNlZCBhcyByZWZlcmVuY2UgY2xvY2sgd2hlbiBJ
bm5lciBjaGlwDQogY2xvY2sgbW9kZSBpcyB1c2VkLg0KDQpJbiB0aGUgY3VycmVudCBjb2Rlcywg
SU1YOE1QX0NMS19IU0lPX0FYSSBpcyBzb3VyY2UgZnJvbSBzeXNfcGxsMiBjbG9jay4NCmlzIGl0
IHJlYXNvbmFibGUgdGhhdCB1c2UgaXQgYXMgUENJZSByZWZlcmVuY2UgY2xvY2sgaW4gdGhpcyBz
Y2VuYXJpbyBoZXJlPw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gPg0KPiA+IFJl
Z2FyZHMsDQo+ID4gTHVjYXMNCg0K
