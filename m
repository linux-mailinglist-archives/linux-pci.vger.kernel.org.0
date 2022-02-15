Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB184B6173
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 04:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiBODQ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 22:16:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiBODQ4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 22:16:56 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60050.outbound.protection.outlook.com [40.107.6.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252B5F31;
        Mon, 14 Feb 2022 19:16:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhkjWtfaf0K8FpY1XVLm8PPHf1r+haIQXYjJe7Pex/YF4h6FP1tE/TPgpTnRHrTdBvmygYaDMiPrPtygVgk2JGyFk9zpqh0zJHBikFtiMcZlPoIlijMcqnwEvLd9iQRZadB7LaSvqXBrtGUO8s1CvWd9cON+JhELabqvgSNM6uh+MOKhFWlStdIgf8dSSMZ3wQRVFXNJQ8JBqPr+7f9nA0Jv1rjahVU3gHisuUuNqYZpWRpElUZOIoZ1jnMuOElj4fQKv+wiGG4XoEEaxUXK7C5F+E2k2msJhUngbnDrEVV51nXp5btt2k8Ic24YBu99Q3OuRzYiGJEHHi8otA+RqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfPJemHUPwJg3Lw10Mdzx9yA+KF8DeLLZdGvojWugic=;
 b=bNthXemHI5Ds2mE+TQXY+2tztYDzX5YfY9D6QahbHTdLWv1tmhnZ3FlJbUP+FyfhcmXdDas1cZqUGQY2pPbcZG/NlQh84122Op/0JRPcgZuitc5bmjH/8ocvWsOurTZ6T2dBhYju5OK6WhRpo9jjdoG1QkKvf5oBOUExEBR+6bv3oDSNKrpWGjKrdgl20uoAwcRfpXUvukcKk6zWhz7RF5TDLMpSrstQz+cxqskQsSRiwIeYFC3xO+lsWpdjlFKUVY7cPf0WqdlzIfIkTRNxBE6/j4N98nG8NAFHWIJuyC+KKUkquPyjXx5xIeP4XEioSr2HzqxvddyZA2u96j7c7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfPJemHUPwJg3Lw10Mdzx9yA+KF8DeLLZdGvojWugic=;
 b=dzHVOl0IJm8ZCsEQ+y3e+2zRxcI7x5K9daR5d8DRntBRyA4GuiViYZMXsgYzp93VzllYZiVbOngu8oqm3DpuEy1qKJ5GB+3Szc6dcq4nwm0furVimplvb0Iet1lN829jXkkKauwMZEzpgMIrBLT864lhh7hxfTEyXD+0GjU1vsU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB4385.eurprd04.prod.outlook.com (2603:10a6:208:74::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 03:16:37 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 03:16:37 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Topic: [RFC 2/2] PCI: imx6: Enable imx6qp pcie power management support
Thread-Index: AQHYHYduLICm7+FWyEagAyZved6iF6yLWpYAgACtzBCAAVDwAIAAOJIQgAECyQCABU9zIA==
Date:   Tue, 15 Feb 2022 03:16:37 +0000
Message-ID: <AS8PR04MB86760E0FD82440CF718551A38C349@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB8676C19FBD01547BDF80CFC68C309@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <20220211165318.GA714416@bhelgaas>
In-Reply-To: <20220211165318.GA714416@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c97ca37-0e67-489c-4263-08d9f031940e
x-ms-traffictypediagnostic: AM0PR04MB4385:EE_
x-microsoft-antispam-prvs: <AM0PR04MB43856875A5C6C950C58F026C8C349@AM0PR04MB4385.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yEqWwlMiesXafChhJZXJRlDIH08xXVcSGnFGUAV2pu1sM6Y69E3CFSR09OsyzwBLUp0uOME6CDKYM6xGCYpH/JFzkwqdT2mU3iHQ1A0wEDN8jKUvd+hH8cExykQ+g/RczyyqPLmBMs0X+lqQMUGYXSKyP+WLFRWuJfJLTWVqTEmx/FJn9ufgZTn1RpSZzH4/orXpcvqt++/GdiV6k++WMDc5uZ1OLTh0ZNyJ4qalhR4HmU3ckx1ht0N1ZUtapPV8ap0GpfJxgpHlpexBFnTk7jrPUkvGVP8dPNyA/JY1t+1BLB1bWmjHDKJtej/0Ly2l4oRp58YXIVykXEt3mZvVAE49fRnh2tRut+4vWDbRbcRO51+i2K2/gGZtlwLO9QddSaFSAbyN2GJs0WBWGdVYi4XmQT3zLn+M/EwKB27rg3k2CLVM5p5ddr1dQYlhGz7iWdQu7YET8TCalSjxT0FCebBTP2CLc2751Qn5HxK8YodYdbxY1mrVcgprqgC85DCFZSbOORXFZOXlklP/58mbTna0v6M1u6Tvglo9rTDcSc+O3fhBFoNKBbJN/yK7dRPkZ0LPdACfO4fsnMUQOEz43oW+vtzcpZvGdlSdEQQyHQmHWu8mAZH9coXfCYaeZ1Omd/ZWNCdIVuE2x04FBdjQ2CTDRvehKj7lDZm1VewOTkD0SUfOdKOYuzNcfJDwZB40rlOS/tPHj7BZUh3siJsxEKpUzSdUa8OjPnolgKI3Qc1nzrbWPLpIS2E+bUy7B7xHNUmT0b50uB1u0vAj3IsLTXzQhhutJ1bwj/oLqcku9po75vX6SByBZ8Q4kc01Sk4z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(2906002)(55016003)(44832011)(186003)(26005)(86362001)(38070700005)(83380400001)(52536014)(76116006)(54906003)(7696005)(316002)(33656002)(66946007)(508600001)(6506007)(38100700002)(66446008)(64756008)(66476007)(4326008)(8676002)(66556008)(71200400001)(5660300002)(53546011)(966005)(7416002)(45080400002)(6916009)(122000001)(8936002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QW0rOS9zZUVlNW0wbUF4WWpqNEZoZGtsTmlPWk9VWDhCRzFOaWQrcUlsYXRH?=
 =?gb2312?B?dXZBWElBYWhyVGhjNVRHaC9ERUREOStHdHovcGF2SjRTS3RzYkdnSnhOcHFU?=
 =?gb2312?B?Q0xyelArbTlxZ1lTTmFJdTc2UlRtR1NocFBNbWxBd3Q2VGowVlNoc2EwdHo0?=
 =?gb2312?B?b1pzMlZIYmRhVlF2djZWdy9CdFZHQWFJenp5LytwZERIUUV6Rld1bFdoVG5P?=
 =?gb2312?B?eURvSjdMZHBHYVF6ZjF5SWF4VVIyaFhZVGtPY1R6UTZzS0NmUUxZZU5PYVVW?=
 =?gb2312?B?aWd6eEsyVThWc3lPRmQycC9uS0Q5czJXeG10bUd1V2Q4KzBHWjlkUGl1cjly?=
 =?gb2312?B?QXV1V0FhdFNGYkJYZjg0aEdmSDBxQ25ZMHZrVlJJUHJLMUJiZENlSC9xc0tC?=
 =?gb2312?B?WnVCcStWZ0JrakY0WXNva1dGamQwZ0JUNnF3R2dSZmc1YkMvWXpScmVRcWFx?=
 =?gb2312?B?cm80cEpBSTJBeG4yOEEvY1hoblV1TUNqSkpkcTBwU2xTTUpjOFYrTTh6NUI4?=
 =?gb2312?B?TmtuZmdObnYzK2xKQUtNRUtaR1NUNWYvZ3d3MnZmVmk2LzRSYW9PVHJKUXNt?=
 =?gb2312?B?STdrNHpsVlV4U0N5a3hWZE5XSnNNeTh4NWd0K2RTTEdHUzZxbXo2YjJ0TGtI?=
 =?gb2312?B?U3k2M2dxQWpsUE5wcVhVTGsvOXcvL1lZbHB5aUhuNG82WjNPVzlsT2t2OGZU?=
 =?gb2312?B?bXFIeG5ocEljMDVMbStETWNsTUN6Ni9qVzl1WUFEQm9FS24rNEhVeEYzc1RP?=
 =?gb2312?B?elhCWU9YZFZDT3NXOGRWODBCUjVhYTBna3pDWUxzNWViQWN2QkZLL2xkVnFZ?=
 =?gb2312?B?dUx2N3A4YTBSWXZES2NMLy9jbTJDYkRpNnhMTFV2WWgwaFFhK0M4N20vMFhC?=
 =?gb2312?B?TDNWeUkyRms1Y2xDUkpaMTN4T3E0L0l5MGtYaEtWQXJrcTh3bStyNDh6Y3hP?=
 =?gb2312?B?N1c4a0VReTNJV1RBM1doZzJzcXp0bW5rdWE1SFhSZVZ1Mkd2ZkxHbDA3MEFj?=
 =?gb2312?B?M0dZQWdSelZrR3NMQnUwSUN4N1Q3bTJZVjZ3bWQrL0tvQ2dLSmF2NEhZZVFu?=
 =?gb2312?B?Qk9QUnNIRmZtb0taUkdnNTM2VkN4VG5Lc0o5elJYbXNXL2J1Q2JiRWk5TWpl?=
 =?gb2312?B?Nm04OCsrWVBrWFZRdm1YdldQYXBUOTRUWWdETktqQ0JSb01rZ1VlSCtvUVBK?=
 =?gb2312?B?Tno2YlZvTmthS1lUb1k4K1BKT0hxeDdsTUg4MUZsT1Y0TXR4dFYveEFnK0Zl?=
 =?gb2312?B?T1NxN0U0YmJHbjVHdzQ2a0hDZysyVm8rSmR3VFBma3ZPYXZWSkRmd3JSK0RV?=
 =?gb2312?B?NlpYcHNJMFV4VmRzNnZncjBnUmVrYUtGRU9xOUptTStvdDRBTVVpYUxmZUpW?=
 =?gb2312?B?QTczcXZaeEM5TkIvWnZoUVUrdld1Q1BCWGthblU4VEUxUlUxYllaaVZiYWl1?=
 =?gb2312?B?ZFVsSWxpNVZxbzg1RGhQVTFkOHJLR01lRTllTVIzYVM1SWxwQzVFb0NXdFNh?=
 =?gb2312?B?RE03aWovdGhNTnBRWnlFeFFhcUZkdVFTUlRtOWpCZVQ3TVU0c0JGVnNveXE0?=
 =?gb2312?B?VFVTbWNYRE9DMDh3RnhxY0I5eW8zNU5oV2VjazVZMFhCS1lteW1neGZETi96?=
 =?gb2312?B?aS9jT0ViTzdXeVNwR01uK042eWE5S0lRYmZpL0NXQkJHemRNL0FkeVZnYVpW?=
 =?gb2312?B?WWN1TjJuS1IvdE03b0ozTXh4Y2VWQ0dobWx2dkFUWGhObTIrOExsT1VBa1M4?=
 =?gb2312?B?a2VFNjFHYXVrdnI5WTlVd2o0SFYvdU01Y3RQSmE2Qi9mQlJQVGJjU2NYbldG?=
 =?gb2312?B?ZzBabHBwSnFlL3RDMkNYRW5TRVhiaHFvdXc3OE10T1MrOG5OSG5pUE1tU3F0?=
 =?gb2312?B?a25zaXlodEpTcUZzdi90bzUrQnFVQnpuSlc5QlkvTDZaNWFTU0h5c1hveUt4?=
 =?gb2312?B?UGxjeGZVR3BDaHgrdHJMQ3NyNmpNTFg2NVN5QXczYy8vTTdzQXIzVzExMlAr?=
 =?gb2312?B?c0VRM0NrUkg3RForZElqNDRvRWNHSmJiRklwQmFJWnhhZWxaU05UQ1JUZ1Zw?=
 =?gb2312?B?NC9WQ2dSWGpJN1BPVE96b0cvd0k2KzY4K0hlaVlCUGtHU2JjbnN1N2lLaUIr?=
 =?gb2312?B?NDJ4T3B6TlhSZXpCSG9PQWQ4akp0MEx0aTF3eVByRnIvVEZZVmVSR2Q2V3d3?=
 =?gb2312?B?OUE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c97ca37-0e67-489c-4263-08d9f031940e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 03:16:37.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqLTf6Y9dzo6G80mzaCTDPgHEmbtl2Qm1+X4wFvRlfcKaalRnnXe3gMKZX+GvNTgew5ineMqwLmlCpZK72Milw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4385
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjEyyNUgMDo1Mw0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsgUmFmYWVsIEouIFd5c29ja2kNCj4gPHJqd0Byand5c29ja2kubmV0Pg0KPiBTdWJqZWN0
OiBSZTogW1JGQyAyLzJdIFBDSTogaW14NjogRW5hYmxlIGlteDZxcCBwY2llIHBvd2VyIG1hbmFn
ZW1lbnQNCj4gc3VwcG9ydA0KPiANCj4gWytjYyBSYWZhZWwsIGJlZ2lubmluZyBvZiB0aHJlYWQ6
DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRmxvcmUua2VyDQo+IG5lbC5vcmclMkZyJTJGMTY0NDM5MDE1Ni01OTQwLTIt
Z2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1JTQwbnhwLmNvbQ0KPiAmYW1wO2RhdGE9MDQlN0Mw
MSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NhNDBjMmEzZDdjMDM0OTdmOGMNCj4gZjIwOGQ5
ZWQ3ZjA0NjMlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjMN
Cj4gNzgwMTk1MjA3NjM2NzkxOCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TUQNCj4gQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNE
JTdDMzAwMCZhbXA7c2RhdGE9DQo+IEJuem9TYmI5MkhFdyUyQlFBTXNweUNUNzI3ODdhRlVobVBp
WlgyWlZBenRKbyUzRCZhbXA7cmVzZXJ2ZWQNCj4gPTBdDQo+IA0KPiBPbiBGcmksIEZlYiAxMSwg
MjAyMiBhdCAwMjowNToyNEFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fh
c0BrZXJuZWwub3JnPg0KPiA+ID4gU2VudDogMjAyMsTqMtTCMTHI1SA2OjA1DQo+ID4gPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiA+IENjOiBsLnN0YWNoQHBl
bmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4gbG9yZW56by5waWVyYWxp
c2lAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiA+IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGlu
dXgtaW14DQo+ID4gPiA8bGludXgtaW14QG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1JG
QyAyLzJdIFBDSTogaW14NjogRW5hYmxlIGlteDZxcCBwY2llIHBvd2VyDQo+ID4gPiBtYW5hZ2Vt
ZW50IHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBPbiBUaHUsIEZlYiAxMCwgMjAyMiBhdCAwMzoyMzox
OUFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiA+ID4gPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxnYWFzQGtlcm5l
bC5vcmc+DQo+ID4gPiA+ID4gU2VudDogMjAyMsTqMtTCOcjVIDIzOjM3DQo+ID4gPiA+ID4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiA+ID4gQ2M6IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+ID4gPiA+ID4gbG9yZW56
by5waWVyYWxpc2lAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiA+ID4gPiBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+ID4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1
dHJvbml4LmRlOw0KPiA+ID4gPiA+IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+
ID4gPiA+ID4gU3ViamVjdDogUmU6IFtSRkMgMi8yXSBQQ0k6IGlteDY6IEVuYWJsZSBpbXg2cXAg
cGNpZSBwb3dlcg0KPiA+ID4gPiA+IG1hbmFnZW1lbnQgc3VwcG9ydA0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gT24gV2VkLCBGZWIgMDksIDIwMjIgYXQgMDM6MDI6MzZQTSArMDgwMCwgUmljaGFyZCBa
aHUgd3JvdGU6DQo+ID4gPiA+ID4gPiBpLk1YNlFQIFBDSWUgc3VwcG9ydHMgdGhlIFJFU0VUIGxv
Z2ljLCB0aHVzIGl0IGNhbiBzdXBwb3J0IHRoZQ0KPiA+ID4gPiA+ID4gTDIgZXhpdCBieSB0aGUg
cmVzZXQgbWVjaGFuaXNtLg0KPiA+ID4gPiA+ID4gRW5hYmxlIHRoZSBpLk1YNlFQIFBDSWUgc3Vz
cGVuZC9yZXN1bWUgb3BlcmF0aW9ucyBzdXBwb3J0Lg0KPiA+ID4NCj4gPiA+ID4gPiBXaGF0IGRv
ZXMgIkwyIGV4aXQgYnkgcmVzZXQgbWVjaGFuaXNtIiBtZWFuPyAgSXMgdGhpcyBhbg0KPiA+ID4g
PiA+IGkuTVg2LXNwZWNpZmljIHRoaW5nPyAgSWYgbm90LCBjYW4geW91IHBvaW50IG1lIHRvIHRo
ZSByZWxldmFudA0KPiA+ID4gPiA+IHBhcnQgb2YgdGhlIFBDSWUgc3BlYz8NCj4gPiA+ID4NCj4g
PiA+ID4gTm8sIGl0J3Mgbm90IGkuTVg2IHNwZWNpZmljIHRoaW5nLiBpLk1YNlEvREwgZG9lc24n
dCBoYXZlIHRoZQ0KPiA+ID4gPiBzZWxmLXJlc2V0IG1lY2hhbmlzbS4gIFRodXMsIGl0IGNhbid0
IHJlc2V0IGl0c2VsZiB0byBhbg0KPiA+ID4gPiBpbml0aWFsaXplZCBzdGF0IHdoZW4gbGluayBl
eGl0IGZyb20gdGhlIEwyIG9yIEwzIHN0YXRzLiAgaS5NWDZRUA0KPiA+ID4gPiBQQ0llIGhhcyB0
aGUgc2VsZi1yZXNldCBtZWNoYW5pc20sIGFuZCBpdCBjYW4gcmVzZXQgaXRzZWxmIHdoZW4NCj4g
PiA+ID4gbGluayBleGl0IGZyb20gTDIgb3IgTDMgc3RhdHMuICBUaGUgY29tbWl0IGRlc2NyaXB0
aW9uIG1pZ2h0IG5vdA0KPiA+ID4gPiBhY2N1cmF0ZS4gIEhvdyBhYm91dCBjaGFuZ2UgdGhlbSB0
byAiaS5NWDZRUCBQQ0llIHN1cHBvcnRzIHRoZQ0KPiA+ID4gPiBSRVNFVCBsb2dpYywgdGh1cyBp
dCBjYW4gcmVzZXQgaXRzZWxmIHRvIHRoZSBpbml0aWFsaXplZCBzdGF0IHdoZW4gZXhpdCBmcm9t
IEwyDQo+IG9yIEwzIHN0YXRzLiINCj4gPiA+DQo+ID4gPiBVZ2gsIEkgaGF2ZSBhbGwgc29ydHMg
b2YgcXVlc3Rpb25zIG5vdywgYnV0IEkgZG9uJ3QgdGhpbmsgSSB3YW50IHRvDQo+ID4gPiBrbm93
IG11Y2ggbW9yZSBhYm91dCB0aGlzIDspDQo+ID4gPg0KPiA+ID4gU2VlbXMgbGlrZSB0aGlzIGRl
dmljZSByZXF1aXJlcyBzb2Z0d2FyZSBhc3Npc3Qgd2hlbiBicmluZ2luZyB0aGUNCj4gPiA+IGxp
bmsgb3V0IG9mIEwyIG9yIEwzLiAgSXMgdGhhdCBhbGxvd2VkIHBlciBQQ0llIHNwZWMsIG9yIGlz
IHRoaXMgYW4NCj4gPiA+IGVycmF0dW0/DQo+ID4gPg0KPiA+ID4gRG9lcyB0aGlzIG1lYW4gdGhl
IGRyaXZlciBuZWVkcyB0byBiZSBpbnZvbHZlZCB3aGVuIHdlIHRha2UgYSBkZXZpY2UNCj4gPiA+
IG91dCBvZiBEMyAod2hlcmUgdGhlIGxpbmsgd2FzIGluIEwyIG9yIEwzKT8NCj4gPg0KPiA+IFll
cywgdGhlIFNXIHNob3VsZCBiZSBpbnZvbHZlZCB3aGVuIGJyaW5naW5nIHRoZSBsaW5rIG91dCBv
ZiBMMiBvciBMMy4NCj4gPiBJIGxvb2tlZCB0aHJvdWdoIHRoZSBTUEVDLCBkaWRuJ3QgZmluZCB0
aGF0IHRoZXkgYXJlIGZvcmJpZGRlbiBieQ0KPiA+IFNQRUMuICBJdCBtaWdodCBiZSBhIGRlc2ln
biBsaW1pdGF0aW9uLCBJIHRoaW5rLg0KPiANCj4gT0suICBJIGRvbid0IHVuZGVyc3RhbmQgYWxs
IHRoZSBkZXRhaWxzIG9mIEwyIGFuZCBMMywgc28gSSdsbCB0YWtlIHlvdXIgd29yZCBmb3IgaXQN
Cj4gdGhhdCB0aGlzIGlzIGFsbG93ZWQgYnkgc3BlYy4NCj4gDQo+IFRoZSBjYXNlIEkgd2FzIHdv
bmRlcmluZyBhYm91dCBpcyB3aGVuIHNvZnR3YXJlIHB1dHMgYSBkZXZpY2UgaW4gRDNob3QsDQo+
IHdoaWNoIGNhbiBiZSBkb25lIHZpYSBwY2lfc2V0X3Bvd2VyX3N0YXRlKCksIHdpdGhvdXQgYW55
IGhlbHAgZnJvbSB0aGUgaW14Ng0KPiBkcml2ZXIuICBXaGF0IHN0YXRlIHdpbGwgdGhlIGxpbmsg
YmUgaW4sIGFuZCBjYW4gd2UgYWxzbyBwdXQgdGhlIGRldmljZSBiYWNrIGluDQo+IEQwIHdpdGhv
dXQgaGVscCBmcm9tIGlteDY/DQpIaSBCam9ybjoNClJlZ2FyZGluZyBteSB1bmRlcnN0YW5kLCBp
Lk1YNlFQIFBDSWUgd291bGQgYnJvYWRjYXN0IHRoZSBQTUUgbWVzc2FnZSwNCiBoYW5kc2hha2Ug
d2l0aCByZW1vdGUgRVAsIGxldCBsaW5rIHN0YXRlIHRvIGJlIEwxIG9yIEwyL0wzLiBUaGVuLCB0
aGUgRVANCiBkZXZpY2UgZHJpdmVyIHdvdWxkIHB1dCB0aGUgZGV2aWNlIGludG8gRDMgbW9kZSBh
Y2NvcmRpbmdseS4NCg0KU2luY2UgaS5NWCBQQ0llIGRvZXNuJ3Qgc3VwcG9ydCB0aGUgTDIgYW5k
IHRoZSBiZWFjb24gdG8gZXhpdCB0aGUgTDIgbGluaw0KIHBvd2VyIHN0YXRlLiBUaGUgcmVzZXQg
YW5kIGxpbmsgcmV0cmFpbmluZyB3b3VsZCBiZSBkb25lIHRvIHJlLXNldHVwIHRoZQ0KIGxpbmsg
d2hlbiBleGl0IHRoZSBMMyBsaW5rIHBvd2VyIHN0YXRlLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hh
cmQNCj4gDQo+IFNlYyA1LjMuMiBzYXlzIEwxIGlzIGEgcGVybWlzc2libGUgbGluayBzdGF0ZSBm
b3IgRDNob3QsIHNvIG1heWJlIEwyIGFuZCBMMyBhcmUNCj4gbm90IGludm9sdmVkIGluIHRoaXMg
Y2FzZS4NCj4gDQo+IEJqb3JuDQo=
