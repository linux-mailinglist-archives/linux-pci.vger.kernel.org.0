Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3640C4C24C0
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 08:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiBXHvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 02:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiBXHvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 02:51:40 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10073.outbound.protection.outlook.com [40.107.1.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E62189A9B;
        Wed, 23 Feb 2022 23:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ+fmizOy1luA7N4eEW4oX07E1lQefVRbf7Th+RABlnKZoGAlCxWd3JYT3+iNqz8+OOuaGeQVtxl0ks00mqLGDJ6Cy6ZLeit/7uddFh9L6VtniMnMcWyPR3+uzKZVnv8zH8ickfS8Dxol/01CnYhCa4onm2xQzsCX6smx5JOFwUOTSKfU1tdnDww5kV05I3UxgqHwfqKOY0f5OL0oUnduFQvVMbjOXOjnBl+1Rdyo/mWTk+RAhkWr7t+OiT56Oa/7b8gunRrlXLB6xd73QK71YkRgMVsjkR5CClKtC/WT4DgSnVheYfYFtqObgwgwu9GL40bGcIixRwk5UyoJ3KfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RO7QOhpnalxCa97KbDbWQ4wJ/gz0o0Nl2nsXwnINIA=;
 b=ihF37xWB5zkOTSLseQAIwLtSo8vZZH0Q+6AuVobFRXcFnUBj9SFQqBOe+BEo4Hx7BSwCJyNUNGDsyynVsflW18Z+A9FmvjOm9PVOt/tagnbrQFuhwOvZb04LhUI/J/2KxKk+b1zyhVEaZ81lG63OHe3hcb41bQyf8zybKrn+urvdGjqacIFbnxX47MUNzz2X33sSEFhOD52cEimqNCioVSsuYjdkTmIQL2m4oTn5vXYt3gfOFYRniN5Eqjbfv5oxx7kaNzjPqPwDy3Yf4ZREeFNPTlRdZ8SwShQCviSFNY/E/8z93HViIIgNZROYwXMkf57PMlU162op7iqSswYeSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RO7QOhpnalxCa97KbDbWQ4wJ/gz0o0Nl2nsXwnINIA=;
 b=pVS0wZLkA88iS8uVGxmvy75HT817jiBNS/AxNg9xDIIZhIomtq1nmnIAJ1u68WkEPfzkm1b/QAXaLZ52+SjAr9soatCGZkAx85Bm9pXaCkU57qZUPd97u38NnygZZfcX3YsKcwTGmGepojN3U4X7889HPBZZfP9z4tYKTe572F8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB7PR04MB4044.eurprd04.prod.outlook.com (2603:10a6:5:1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 07:51:07 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 07:51:07 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
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
Subject: RE: [PATCH v7 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Thread-Topic: [PATCH v7 7/8] PCI: imx6: Disable enabled clocks and regulators
 after link is down
Thread-Index: AQHYIwHV7h1LKyc1202jRHmtHaQDcKyhdZ0AgADaonA=
Date:   Thu, 24 Feb 2022 07:51:07 +0000
Message-ID: <AS8PR04MB8676B0E4B7D18DA5CB2928628C3D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644992463-14467-8-git-send-email-hongxing.zhu@nxp.com>
 <20220223175016.GA140091@bhelgaas>
In-Reply-To: <20220223175016.GA140091@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5891e1d4-1887-4e27-9f54-08d9f76a6a59
x-ms-traffictypediagnostic: DB7PR04MB4044:EE_
x-microsoft-antispam-prvs: <DB7PR04MB404406D3B979D48E513CD1338C3D9@DB7PR04MB4044.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ztSCG8Y5dizk50Ng2JWValX6hE7UP6dPHC3OP397K6yCknsn9w+exPAq2EUxGt3YE+EVQMzebggiauQirEOdHVuWuZg1Dtzd6m+flztTQqdiwtFiuQImKajldMBK2v87EW9AI69tc6ubB4lobDWaiQ/D6WRmHxzVvYKI7qO4PyqViBqCELkWbNS54UXDR37ou5oRpbdW4YZ6jZTGbC+rRlvEoOLiFVGi2iDSdGX7pn7zQsBUXB+06UwFjKsi+kLWTkYM8Vt2KClfwQm1PqDoCBP4XVQARIMZmOAqXOaBgJodBtMv4OlG6jPCD3ngtOyd1j6Ur5nW8GmUKV05erwVFN7btLh52qdr6FsAyyG8tWK/zTK3AhBmmDQ9rxVPOp0wxrj+kdCRl5DiHN2Gv24ttW8L9hcZSQADR39j5oU9mPmml5XIttjqyRYUOq77my2O4RQHPAiGkAFPySu35EvPsrnmhHOwOzXVCW0V61ht9moKoIo4TCIegoKWQz+QOT8CYJaxMUzHphIRaln7zQy5frV2wgYERBufmXCdW22P/j/diQur/NkJlaFDQIJ8XIv8ofg15rH2LMZpcVziM+sQJvyUkc4BuEhtteco9AUssjQABziMKjtuy+Y6vRTzYhptxZxcbfylaw2+8tJtE6tYOnQHADMuiMPQrCV2vlRcfNNLcQPNG0/4tuObYLt9zUwoMSGtXbF57T3PPSBhBC4TVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(4326008)(38070700005)(64756008)(66946007)(8676002)(76116006)(86362001)(38100700002)(7416002)(66476007)(5660300002)(52536014)(66556008)(8936002)(122000001)(44832011)(2906002)(66446008)(26005)(186003)(71200400001)(53546011)(6506007)(7696005)(9686003)(508600001)(316002)(6916009)(83380400001)(54906003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RVRVYkU1alQrVkZia3dCc05DZWhuVDlySFNKOHRQRFVwblNtaXBjVlk0M0hh?=
 =?gb2312?B?ajIzOUw1WFBIZDUwM0V3aDJQL1d0KzNCakp3Q1Y5SHg5WVAyQ1RyR2pIdzNi?=
 =?gb2312?B?NCtBT05UaU1HWDNXMUpPc1FaMHpiNlFXY0Zla1E1RGVxSm5hZERobDRlYnE2?=
 =?gb2312?B?Qy9IbFIrU2RNbDJmUEM2Zzg4RmR6VTNjeExWR1BvRWRHZTZpSlhkaFZqN1JQ?=
 =?gb2312?B?MjJVVDNRVHRqMWJmSXg3TjBGOEFKVHluSm52NVdsZzlOYlhWMFlWdFA5UldB?=
 =?gb2312?B?eTZIL1U2WklZNVBYcSsrQytHWllrbTB5OWJlSjN0N3NzYzlVOGNIdjRZN0Nq?=
 =?gb2312?B?ZGliYmRDR0V0bTNXMmV4SlQ2UmJoTDdqekVwbUJWYU5pbWFXeUNJaGJnMnUx?=
 =?gb2312?B?QVJVdDk2VVhkTFMwK2JlZVNPcGR1bTg3QXdnYTgvMStKVzBwNWY2blpRMzdC?=
 =?gb2312?B?cDdIeU9JU3U1WjNzMG5uaHI0OWlLcXNsSE9wRkFlNllQL3VEMUwzaXBvdVJL?=
 =?gb2312?B?Zy9aamU0WWhXM3lyR2VVbDJtNEFnYzZXS3ZDV2NvcHlQeUdkQlE0UFBsMWRt?=
 =?gb2312?B?REg3dXpQWkk5VnVIc21mdmVLS2hGSXpwQWxMMURwV2MrQzV0RTZ6V3NPR2Rt?=
 =?gb2312?B?c1FNQmdLc0pDcTUyWlNQNk45aFpYL0hwbkRucXp3TGdxeVJaRkpWQUw0TzNU?=
 =?gb2312?B?eXVaeVpVbTFxa3hFMDJPTCsvM0ZhQ3NyTDdqK0NpMmF2c1hFZDVFRGc1SVlh?=
 =?gb2312?B?WlZ6OHc3ZDI0YUpmaFYxc3N5SS9OZ1dWbXhhQTYxSm5mbWplalZLejNPMWli?=
 =?gb2312?B?UHUyVnpWTUo3bTVzejR2Vms5bWQyTVMrVkhKaHFwNCs5MXlPdVRJK1o3MFlI?=
 =?gb2312?B?U1FtVUNOWHpxZ2Znc1d6UHZUKzBTUGxLQWhrUkdpTGpFWGl4S0I0aDRTSEkr?=
 =?gb2312?B?WHg0TW1KMjd5Y1ptSTlYeGZIUk9RckR5SzdMZUd3aUY5bWdvNG5QbzhoMHFq?=
 =?gb2312?B?OFZJZ29iVWhlUVB2Z3kyODRyZ0NEODY2WUlWSTZVZXI4NVB4ay92UDNOa1Nm?=
 =?gb2312?B?SkVDTWhGalZxU25NUkJZZUpFQ3IzZnV0R2pUU25ZSTRqS0tOUWlITU9oUC9D?=
 =?gb2312?B?YkFFK25HVVNpQTczemp2czJxZm9PR0s1T0RZMy9VR0xaU3FXcWo2eVhEU3lL?=
 =?gb2312?B?OUJTZjV3VEZLOHJwdjg3NzcxTi9vNVZ1dDBGSXVaRUpKVzRZLzhLYkRtL1A1?=
 =?gb2312?B?MHkrZWxpZFAreXVyamhQaUVqN2YyT0hCVEQrVU1BZTVVSUgyRkNCblRySTFj?=
 =?gb2312?B?b1BuNU1TK1dJdUEzWlJsemkyVFJpeDJQK3g4SHFMSFBsNnB0cGUyV1VPMGZh?=
 =?gb2312?B?M0R4OFlsTVpITVZvaDhmZkNNY0w0M2RmMFFOS3I1Q2ROTWNNMXdNQ2xoWno2?=
 =?gb2312?B?dW4wa1FMMWViaVl2YUZmNjl0TE5UU2lvWjFQUzhINFI3NDNKTmdUVjh1Y05p?=
 =?gb2312?B?bm9JUnd5dm9ZbldaWGNRdE5rUmF6N0JhZlpRcktPRTFteG1tN0hNQWgwOTRr?=
 =?gb2312?B?TWRFMCt2S2JEN1JVb0lSdEFNLzN4TjNDbEFHZ0tRbHhwZGkxOUp3ZWFkQkt3?=
 =?gb2312?B?UVZYa1M5cTVTQ3FMRjFXN2JrT29pNFova2RsNmNSS1VONDRDQjBwQVhUeW1U?=
 =?gb2312?B?S1N6Nmw0bHpGOWZPYUNPN1ZwSkdvVVpoc3dnSVU2UDY2K1AxOHF4bjg4NndQ?=
 =?gb2312?B?RHhDZ2doUmducEhzZVZYWWFvcit0R3FXRzlCWUNyK3pIWU1CbDBPTG4zdHNN?=
 =?gb2312?B?OGRXSzEzYzJmdHdQNGFIekxYbFdXcHg2ZDIwdUtsaEM2RFJvT202ZmlMb3hQ?=
 =?gb2312?B?clRjQVc2RjR3bTBMTHNRUS94dGdUUUtTRUR0eFVSS1dJU3ZzKzhsTEtGRzZS?=
 =?gb2312?B?dE1EZDJMQTUyZG45V2lpelVYVktlZzVRUHhWRGhqNnJvYmJuSEJwU2JPQTcz?=
 =?gb2312?B?REhuekJiYXROb3JKMmtTcFdnUFMrc1hNSVB5NklNazlKb1lURFFwREV5YTBJ?=
 =?gb2312?B?WDNuNElJSzh4WmRUNTVLNndFcW1LK2pqTm9VQkxseXJrVHNhOFdieUtqL3p2?=
 =?gb2312?B?ejBVb25wb0FlanR5R0cwd0Fmb1BjTUhqRGtUNHlvemVJNTVSa2VmOFUxRVB1?=
 =?gb2312?B?NlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5891e1d4-1887-4e27-9f54-08d9f76a6a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 07:51:07.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9O9w1UcfxF4G0rlAp7+tblq5P3vGciFGj/oZidtjWHCrtFK8YeD4jWTyx/AeUTsPjQ97K9wt3OSMP1tNxr3gFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4044
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjI0yNUgMTo1MA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDcvOF0gUENJ
OiBpbXg2OiBEaXNhYmxlIGVuYWJsZWQgY2xvY2tzIGFuZCByZWd1bGF0b3JzDQo+IGFmdGVyIGxp
bmsgaXMgZG93bg0KPiANCj4gSW4gc3ViamVjdCwNCj4gDQo+IHMvRGlzYWJsZSBlbmFibGVkIGNs
b2Nrcy9EaXNhYmxlIGNsb2Nrcy8NCk9rYXksIHdvdWxkIGJlIHVwZGF0ZWQgbGF0ZXIuDQpUaGFu
a3MuDQoNCj4gDQo+IE9uIFdlZCwgRmViIDE2LCAyMDIyIGF0IDAyOjIxOjAyUE0gKzA4MDAsIFJp
Y2hhcmQgWmh1IHdyb3RlOg0KPiA+IFNpbmNlIGkuTVggUENJZSBkb2Vzbid0IHN1cHBvcnQgdGhl
IGhvdC1wbHVnLCBhbmQgdG8gc2F2ZSBwb3dlcg0KPiA+IGNvbnN1bXB0aW9uIGFzIG11Y2ggYXMg
cG9zc2libGUuIFJldHVybiBlcnJvciBhbmQgZGlzYWJsZSB0aGUgZW5hYmxlZA0KPiA+IGNsb2Nr
cyBhbmQgcmVndWxhdG9ycyB3aGVuIGxpbmsgaXMgZG93biwuDQo+IA0KPiBNYXliZToNCj4gDQo+
ICAgU2luY2UgaS5NWCBQQ0llIGRvZXNuJ3Qgc3VwcG9ydCBob3QtcGx1ZywgcmVkdWNlIHBvd2Vy
IGNvbnN1bXB0aW9uDQo+ICAgYXMgbXVjaCBhcyBwb3NzaWJsZSBieSBkaXNhYmxpbmcgY2xvY2tz
IGFuZCByZWd1bGF0b3JzIGFuZCByZXR1cm5pbmcNCj4gICBlcnJvciB3aGVuIHRoZSBsaW5rIGlz
IGRvd24uDQpPa2F5Lg0KDQo+IA0KPiA+IEFkZCBhIG5ldyBob3N0X2V4aXQoKSBjYWxsYmFjayBm
b3IgaS5NWCBQQ0llIGRyaXZlciB0byBkaXNhYmxlIHRoZQ0KPiA+IGVuYWJsZWQgY2xvY2tzLCBy
ZWd1bGF0b3JzIGFuZCBzbyBvbiBpbiB0aGUgZXJyb3IgaGFuZGxpbmcgYWZ0ZXINCj4gPiBob3N0
X2luaXQgaXMgZmluaXNoZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMgfCAzMA0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5j
DQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXgg
MjQyZDhlZjczYzFlLi5mZTY3MWU4OGVjOTMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtODQ4LDcgKzg0OCw5IEBAIHN0YXRpYyBpbnQgaW14
Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gPiAgCS8qIFN0YXJ0IExU
U1NNLiAqLw0KPiA+ICAJaW14Nl9wY2llX2x0c3NtX2VuYWJsZShkZXYpOw0KPiA+DQo+ID4gLQlk
d19wY2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiArCXJldCA9IGR3X3BjaWVfd2FpdF9mb3Jf
bGluayhwY2kpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlnb3RvIGVycl9yZXNldF9waHk7DQo+
IA0KPiBUaGVzZSBsYWJlbHMgbG9vayB3cm9uZyBub3csIHNpbmNlIHlvdSBubyBsb25nZXIgcmVz
ZXQgdGhlIFBIWSBhdA0KPiBlcnJfcmVzZXRfcGh5Lg0KWW91J3JlIHJpZ2h0LiBXb3VsZCBiZSBy
ZXBsYWNlZCBieSAiZXJyX291dCIgbGF0ZXIuDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmlj
aGFyZCBaaHUNCg0KPiANCj4gPiAgCWlmIChwY2ktPmxpbmtfZ2VuID09IDIpIHsNCj4gPiAgCQkv
KiBBbGxvdyBHZW4yIG1vZGUgYWZ0ZXIgdGhlIGxpbmsgaXMgdXAuICovIEBAIC04ODQsNyArODg2
LDkgQEANCj4gPiBzdGF0aWMgaW50IGlteDZfcGNpZV9zdGFydF9saW5rKHN0cnVjdCBkd19wY2ll
ICpwY2kpDQo+ID4gIAkJfQ0KPiA+DQo+ID4gIAkJLyogTWFrZSBzdXJlIGxpbmsgdHJhaW5pbmcg
aXMgZmluaXNoZWQgYXMgd2VsbCEgKi8NCj4gPiAtCQlkd19wY2llX3dhaXRfZm9yX2xpbmsocGNp
KTsNCj4gPiArCQlyZXQgPSBkd19wY2llX3dhaXRfZm9yX2xpbmsocGNpKTsNCj4gPiArCQlpZiAo
cmV0KQ0KPiA+ICsJCQlnb3RvIGVycl9yZXNldF9waHk7DQo+ID4gIAl9IGVsc2Ugew0KPiA+ICAJ
CWRldl9pbmZvKGRldiwgIkxpbms6IEdlbjIgZGlzYWJsZWRcbiIpOw0KPiA+ICAJfQ0KPiA+IEBA
IC04OTcsNyArOTAxLDYgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3Qg
ZHdfcGNpZSAqcGNpKQ0KPiA+ICAJZGV2X2RiZyhkZXYsICJQSFkgREVCVUdfUjA9MHglMDh4IERF
QlVHX1IxPTB4JTA4eFxuIiwNCj4gPiAgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9S
VF9ERUJVRzApLA0KPiA+ICAJCWR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9QT1JUX0RFQlVH
MSkpOw0KPiA+IC0JaW14Nl9wY2llX3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+ICAJcmV0dXJu
IHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTkyMSw4ICs5MjQsMjkgQEAgc3RhdGljIGludCBp
bXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBwY2llX3BvcnQgKnBwKQ0KPiA+ICAJcmV0dXJuIDA7
DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBpbXg2X3BjaWVfaG9zdF9leGl0KHN0cnVj
dCBwY2llX3BvcnQgKnBwKSB7DQo+ID4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNp
ZV9mcm9tX3BwKHBwKTsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaS0+ZGV2Ow0KPiA+
ICsJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gdG9faW14Nl9wY2llKHBjaSk7DQo+ID4g
Kw0KPiA+ICsJaW14Nl9wY2llX3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+ICsJaW14Nl9wY2ll
X2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7DQo+ID4gKwlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0
YS0+dmFyaWFudCkgew0KPiA+ICsJY2FzZSBJTVg4TU06DQo+ID4gKwkJaWYgKHBoeV9wb3dlcl9v
ZmYoaW14Nl9wY2llLT5waHkpKQ0KPiA+ICsJCQlkZXZfZXJyKGRldiwgInVuYWJsZSB0byBwb3dl
ciBvZmYgcGh5XG4iKTsNCj4gPiArCQlicmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJYnJl
YWs7DQo+ID4gKwl9DQo+ID4gKwlpZiAoaW14Nl9wY2llLT52cGNpZSkNCj4gPiArCQlyZWd1bGF0
b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBkd19wY2llX2hvc3Rfb3BzIGlteDZfcGNpZV9ob3N0X29wcyA9IHsNCj4g
PiAgCS5ob3N0X2luaXQgPSBpbXg2X3BjaWVfaG9zdF9pbml0LA0KPiA+ICsJLmhvc3RfZXhpdCA9
IGlteDZfcGNpZV9ob3N0X2V4aXQsDQo+ID4gIH07DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBkd19wY2llX29wcyBkd19wY2llX29wcyA9IHsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+
DQo=
