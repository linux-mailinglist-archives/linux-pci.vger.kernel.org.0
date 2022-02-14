Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9924B4041
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 04:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiBND0J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 22:26:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiBND0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 22:26:09 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60057.outbound.protection.outlook.com [40.107.6.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBB51928E;
        Sun, 13 Feb 2022 19:26:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETZKI6s9De+3dTZupsEowChP/W8+Flm6DWQ1Kw5OKS+H8qqkoXxbkNXyGVKABWJhiH783Xk8RevttdgNRp1Cv9bmAjHKwGHsD9cwRUcyQppPs4kDcvR06rbUzuBwG2199GM94m+A9rmzue9rZr7axq2QqqUF8cAz0ExTG7SmNPh7FgSjjP2CwCXWo32iqGoUWDPkx2rAeCve42wY/4nMaIhZwroWoTOij8g/Z89qA8W2AHFTnPu7/fEwwOG7myQkgCm7nAnetgJfEoU6NgvPBCXLrCZZ9kTb0lkzb3yN6Jvk3GGnfYjB5riewdyaY5Ki9eg2Nq4QRY+m5G5zQFqAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wlia0Madg9HPp8L2hhPZ+AHZZiihlN4UhJt0r06N90=;
 b=BMWjCu/pgC31yIiznArUgnvR2CDmkyplYtksZKU0SgnamClduqqiqN6yHrEJq+KaZ4rvRhwvfWIEuz9jP0KsZWTJyf+Q/ypUeBOR90YM27iq0ZWFYBN5csep0QRr/Hta6Ccb1EersnWkj7+Rll/SYI1Ml+IBaFCY8SE/VyMQeU28y/BB8RmdxilsLAKpBax56y/8pOqJp+IQcpX9zTj677QuEEYRbTmqqjysXlar6wReMXG4FEZLlEftaszUuum84/dXVO2PtdRMw0VqguGW7zSNW33LlJMxAvcizdNHaxBmfZu71314L7S6Rhp/LdJ0Ozmv81SMFQKsBd5mBb1P+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wlia0Madg9HPp8L2hhPZ+AHZZiihlN4UhJt0r06N90=;
 b=fzabDIAwKv1nDUaaWbSswb14DvCESGJq+MK7/NvCJW72xYMuKsKWZTUEet+cnjRzxhbdCHk4MLo5Lp7kzm4ffwzYWYnoTWq0Jg/s+L25g2AzrfdPZDOpWP84dBCbYmvdUq3d/Q86j2IX+Qp+4N9HfrkmyhkVCsHFIPQYL3Hroo0=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB6212.eurprd04.prod.outlook.com (2603:10a6:208:148::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Mon, 14 Feb
 2022 03:25:59 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 03:25:59 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v6 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
Thread-Topic: [PATCH v6 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
Thread-Index: AQHYHJ/teu7Oi23t10WHRSJcL+zeZayOkAgAgAPFdvA=
Date:   Mon, 14 Feb 2022 03:25:59 +0000
Message-ID: <AS8PR04MB86765D951EF2D7B106125A2C8C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
 <1644290735-3797-4-git-send-email-hongxing.zhu@nxp.com>
 <20220211163012.GB287827@francesco-nb.int.toradex.com>
In-Reply-To: <20220211163012.GB287827@francesco-nb.int.toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87876cfe-45b8-4909-8ffc-08d9ef69b842
x-ms-traffictypediagnostic: AM0PR04MB6212:EE_
x-microsoft-antispam-prvs: <AM0PR04MB621237F14E517E2405BB96668C339@AM0PR04MB6212.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OhreKCMdfzZlAkaoB8C3qe9TQxeauzcs8lGdPfTKjcVi1OG6eVYhHWpkrtvtLrh1112lg4uKM9w7SAKfAzUXhRpL5+dEC6deZHA9DsGGMlz5y+QGhb4x6J6fsRexI413mNROh4YeUp/EYWDahCO+qljLFdRIUdx8PkpZP/oezeSvSK7hvY+A5Hh6mBGw3d8tIwE7vaKiMvRcEIhHknW9dilj2+0EfbIfB01NuRHqj/yfK6PpXLAA0/FFAyf4kZBJvYB9GAPVo+5uafhixNY6RuSH0wQpAMl3BMBIOTir6/Qwr+QNNhEujfg2XbUciVnX/DqvyL+cijgfBKgeZ+ekXRy2usiOoGHTx0jI5a6KcPJEHdE2mrRC9EqfjQQl7Nf3KS5CDh4AJekjyfcVmtnlYMCrkRvCuaOzVPFdzozfTEhqYXbbKJov7Ibp4zatjxT7cx1GIUr3f6qkAhmV50lMXZGX1ALxAZewkaHBLc27X3OJAbAy/AXQlygw5TWiDtZhSRzYLbevkq5ir/gl/N+mnfLFYzVzjcEyjdxi3f9dJtbUDBKAJQWilFK0LgDBwyA3rUCKG/GTVQezMI18sbn9ZBjLZ2ZOgyDpAXf5G8Ln/pJF/dX1TbPS+Tfx/itr+Ix4XkVO+4qY0s97+qU1apA3flfhSIyuZD2Bc0NKWIRf/Uyo06T2BdcNWDrohpDbGFSl/mdsG5mqysVsQUMsZbOLOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(9686003)(5660300002)(53546011)(76116006)(55016003)(66556008)(66476007)(66946007)(64756008)(186003)(26005)(7416002)(66446008)(33656002)(54906003)(71200400001)(44832011)(122000001)(38100700002)(52536014)(2906002)(83380400001)(316002)(86362001)(8676002)(508600001)(4326008)(6916009)(8936002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?enBGaXBTbWJPYWRHZTJ2MWVjcHhVeTVPTVR6Z0E3bHh3MXdLdjdIOWdESks2?=
 =?gb2312?B?T3E5YS96NEdTdHc4Y1dBeXZIQ3ZGWGNQQ0tBZXdQMmU1MGdjQ2MyR1RWa1pK?=
 =?gb2312?B?VTc1cHhLYk8wS3VTSVhiclZmay9TRWRXUDRod0dQS0daaFYzajgzd0FzaFc2?=
 =?gb2312?B?RGxLcDFyYUUrMDE2M1JBUm5ra2c1RTQyVlVQYWRqWnh0YUtFZUd3aENXOE5R?=
 =?gb2312?B?MUFPa20waG1nTXVtN0V3RTR1ckxoSXBSNHh4NE83YkhQTWxhOGMvdHI0dXlE?=
 =?gb2312?B?QXRobk9Lc21Rc3d0MEtLZ0thZ0pJaFpGM2pkeWh6S1VadEozRzc5N1ZvOVVI?=
 =?gb2312?B?MFRTQndaNUNSak8xSDVvNjRpa0h0TDJuZy9mMHppV080YWJlZ3JSdVZ2R3dE?=
 =?gb2312?B?K2IrOVVXZnIrTzI1c0dQWXhvN0lPWEhaaW1Uc3FqSU44L3dyNjB4Wm45VXhT?=
 =?gb2312?B?QXp1NmFPUjlabDc3Wlc4ZE0vVWgrYm5odnZSdUtKcHdUanNOLzltaHNsUHUr?=
 =?gb2312?B?VnhGQjdQRXpIaGRydXpxK1ZUL1hCbGZ0RlNCQkV5ajFjTXVNWkxENTIvL1hN?=
 =?gb2312?B?b0ZXY2NCSlh0U3dBN1ZpaHdtSHZZWmRsM1RqSG1jZ09tamo4R3R3TWJEY3V4?=
 =?gb2312?B?MjVENHVKRWF2RGYvY1hNMDVoMXpvL1FQcldvaGxRamU5czRmNGRSMitrRXRq?=
 =?gb2312?B?dmxPNy9xejQ5a1o3YjYrNlpSL3FhQkNiZnVvN0tNVS9wVXM5b1JCbmZFTFpD?=
 =?gb2312?B?N09YUE9UZ1FIM0FGT0tPUk52QllXQTZUQmhXMFpPSmcvRnBvbmVHU08rQ0VV?=
 =?gb2312?B?L3h0WnRBQnMva0c2ZFZqcFQxR1hzRHhFTENJMGxIQ3VVUjIwcHV5K2tqdzhq?=
 =?gb2312?B?eHRNS1Q1c0VqRjdYQWZjRkJtQ2pKSkVrVG1LQUkvVWlsTngzK2tpU25lN2xB?=
 =?gb2312?B?Mkd5ODgzRE5ZN3JkYUR6dEo0VHNDRlh6QThuK1hkc2NnWmF6bTBtbUdadlV0?=
 =?gb2312?B?eFJKYm8rb1MwNS96V04rQmwyUjJwaGlWOVdhV0k3d25aTk50Y20zMUZwejFy?=
 =?gb2312?B?ZFdwODFhY0l6MFgxcmlUcnppcU90QVNDdFR2STNyUFhpZGlZTnJxeXdJSEdu?=
 =?gb2312?B?T3FsdHg0VExSSnAwK3dicTRCaHNOQVhxUm5rSkpRUnB1WFlGQUlmUiswRnky?=
 =?gb2312?B?bnJUUXJLTWZ6dlE0OXlBOFIwRFE3aWpLVkttOENTbkhicU8wL1hVcjI5UWVC?=
 =?gb2312?B?bFQvTWRBd2QwODNMcG9XTlRXb0JTMktQZTRPOW9QNDdZZk5nTFlDRm9PVStI?=
 =?gb2312?B?aXRCRHI2b1lRUzJ4THVpSDlIVkNsa1Jpd3ZidkRjcmMrbk5BYjFMTzhkMGdK?=
 =?gb2312?B?YlBxcklBRDBETFFXWTRKQ09LKzIzY1IvdmQ3UkIrMlptWXl4NUxwbTNQaW9J?=
 =?gb2312?B?RzlscGJhdjVRMnNVdTNYeFNjeWtRejc5U1hCNWFqRHZnWnhiSndSNmpuMUVT?=
 =?gb2312?B?T1JqaWl3WFpubDlYemE2N0V1SHRwa2pETHNJaW5tbzBkNTdSUCtKd3RUaHor?=
 =?gb2312?B?THRURXZ0RHNBTU1sL1Naamx2Z00yc2RXanJxOGdQR0lHREtYeUo5dTVJYnFE?=
 =?gb2312?B?MWZQemNxZFM4Y0dXS1l0WkRFay9TZDFBenBSUm1hZW1uOSsrOGJObXJ3aTVJ?=
 =?gb2312?B?cEZ2Umh3dnU0VG93b1FaTk9oRzBmRlRTZGdXY2h2eTU5NzFzcXpDcFJIV3Ey?=
 =?gb2312?B?Ym1Nano2MERSd2V4SWtSY2FyWmZSb3pTWGdhem1YZUlGc0VTN2drRTkzeFJp?=
 =?gb2312?B?cVgvaFVNaEdSNFRlcTJPQ1YvcEtKZTdMN0pOSm15a0JIQjBSUjhBUHM3QXdQ?=
 =?gb2312?B?dG9pdmNrRkVhcEdsTHdTb1hpK1pxUHZOSmNKcWVaVk5Wb2ZMN0pkSXJ4bUFp?=
 =?gb2312?B?TEM5SHU3M05kYTB5Z09sVFpXUXVtZCtWL2xUY3g3YWJxblp0NG9kVGFDTmlI?=
 =?gb2312?B?TTYvWGJoMXUxWTlObUJFMzV0VTcyWXppclNCSnR4WituSCtXUnJrV3ZLaWZu?=
 =?gb2312?B?YUlKczJjOXFzMzJ5aEZxQTNhT1FMLzU0a2VGTmVmcUE5bUVBelNNZlllQVpt?=
 =?gb2312?B?Wm51b0hDekNwTHU1bzdldXBoei9leVhwUmRlUGZKcXRmRk5xZnc4N0dseHJG?=
 =?gb2312?B?c2c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87876cfe-45b8-4909-8ffc-08d9ef69b842
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 03:25:59.0829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UmxeQd0arHywpGcNLGt7hMAxmQ6Xb/46lisjRo1YU1432oKyuWDS4yZzs2woLY1FPTnxfgwdygku5JDa0yHXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFNlbnQ6IDIwMjLE6jLUwjEyyNUgMDoz
MA0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3Rh
Y2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IGJyb29uaWVAa2VybmVsLm9y
ZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgamluZ29vaGFuMUBnbWFpbC5jb207IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJv
bml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMy84XSBQQ0k6IGlteDY6IE1vdmUgaW14
Nl9wY2llX2Nsa19kaXNhYmxlKCkgZWFybGllcg0KPiANCj4gSGVsbG8gUmljaGFyZCwNCj4gDQo+
IE9uIFR1ZSwgRmViIDA4LCAyMDIyIGF0IDExOjI1OjMwQU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdy
b3RlOg0KPiA+IEp1c3QgbW92ZSB0aGUgaW14Nl9wY2llX2Nsa19kaXNhYmxlKCkgdG8gYW4gZWFy
bGllciBwbGFjZSB3aXRob3V0DQo+ID4gZnVuY3Rpb24gY2hhbmdlcywgc2luY2UgaXQgd291bGRu
J3QgYmUgb25seSB1c2VkIGluDQo+IGlteDZfcGNpZV9zdXNwZW5kX25vaXJxKCkgbGF0ZXIuDQo+
IA0KPiBJbiB3aGljaCBwYXRjaCBhcmUgeW91IGdvaW5nIHRvIHVzZSBpbXg2X3BjaWVfY2xrX2Rp
c2FibGUoKT8gSSBjb3VsZCBub3Qgc2VlIGl0DQo+IGluIHRoaXMgcGF0Y2ggc2VyaWVzLg0KSGkg
RnJhbmNlc2NvOg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NClRoZSBpbXg2X3BjaWVfY2xrX2Rp
c2FibGUoKSB3b3VsZCBiZSBpbnZva2VkIGluIGlteDZfcGNpZV9ob3N0X2V4aXQoKSBpbiAjNw0K
IHBhdGNoIGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IEZyYW5j
ZXNjbw0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56
aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYyB8IDQ3DQo+ID4gKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggM2NhMmVlZjM5
NjE3Li5lMTU3ZjBiZWMzN2UgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiBAQCAtNTMzLDYgKzUzMywyOSBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9j
bGtfZW5hYmxlKHN0cnVjdCBpbXg2X3BjaWUNCj4gKmlteDZfcGNpZSkNCj4gPiAgCXJldHVybiBy
ZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBpbXg2X3BjaWVfY2xrX2Rpc2FibGUo
c3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSB7DQo+ID4gKwljbGtfZGlzYWJsZV91bnByZXBh
cmUoaW14Nl9wY2llLT5wY2llKTsNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3Bj
aWUtPnBjaWVfcGh5KTsNCj4gPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUtPnBj
aWVfYnVzKTsNCj4gPiArDQo+ID4gKwlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFu
dCkgew0KPiA+ICsJY2FzZSBJTVg2U1g6DQo+ID4gKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlt
eDZfcGNpZS0+cGNpZV9pbmJvdW5kX2F4aSk7DQo+ID4gKwkJYnJlYWs7DQo+ID4gKwljYXNlIElN
WDdEOg0KPiA+ICsJCXJlZ21hcF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElP
TVVYQ19HUFIxMiwNCj4gPiArCQkJCSAgIElNWDdEX0dQUjEyX1BDSUVfUEhZX1JFRkNMS19TRUws
DQo+ID4gKwkJCQkgICBJTVg3RF9HUFIxMl9QQ0lFX1BIWV9SRUZDTEtfU0VMKTsNCj4gPiArCQli
cmVhazsNCj4gPiArCWNhc2UgSU1YOE1ROg0KPiA+ICsJCWNsa19kaXNhYmxlX3VucHJlcGFyZShp
bXg2X3BjaWUtPnBjaWVfYXV4KTsNCj4gPiArCQlicmVhazsNCj4gPiArCWRlZmF1bHQ6DQo+ID4g
KwkJYnJlYWs7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIGlteDdk
X3BjaWVfd2FpdF9mb3JfcGh5X3BsbF9sb2NrKHN0cnVjdCBpbXg2X3BjaWUNCj4gPiAqaW14Nl9w
Y2llKSAgew0KPiA+ICAJdTMyIHZhbDsNCj4gPiBAQCAtOTY1LDMwICs5ODgsNiBAQCBzdGF0aWMg
dm9pZCBpbXg2X3BjaWVfcG1fdHVybm9mZihzdHJ1Y3QgaW14Nl9wY2llDQo+ICppbXg2X3BjaWUp
DQo+ID4gIAl1c2xlZXBfcmFuZ2UoMTAwMCwgMTAwMDApOw0KPiA+ICB9DQo+ID4NCj4gPiAtc3Rh
dGljIHZvaWQgaW14Nl9wY2llX2Nsa19kaXNhYmxlKHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNp
ZSkgLXsNCj4gPiAtCWNsa19kaXNhYmxlX3VucHJlcGFyZShpbXg2X3BjaWUtPnBjaWUpOw0KPiA+
IC0JY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9waHkpOw0KPiA+IC0JY2xr
X2Rpc2FibGVfdW5wcmVwYXJlKGlteDZfcGNpZS0+cGNpZV9idXMpOw0KPiA+IC0NCj4gPiAtCXN3
aXRjaCAoaW14Nl9wY2llLT5kcnZkYXRhLT52YXJpYW50KSB7DQo+ID4gLQljYXNlIElNWDZTWDoN
Cj4gPiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9wY2llLT5wY2llX2luYm91bmRfYXhp
KTsNCj4gPiAtCQlicmVhazsNCj4gPiAtCWNhc2UgSU1YN0Q6DQo+ID4gLQkJcmVnbWFwX3VwZGF0
ZV9iaXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEyLA0KPiA+IC0JCQkJICAg
SU1YN0RfR1BSMTJfUENJRV9QSFlfUkVGQ0xLX1NFTCwNCj4gPiAtCQkJCSAgIElNWDdEX0dQUjEy
X1BDSUVfUEhZX1JFRkNMS19TRUwpOw0KPiA+IC0JCWJyZWFrOw0KPiA+IC0JY2FzZSBJTVg4TVE6
DQo+ID4gLQljYXNlIElNWDhNTToNCj4gPiAtCQljbGtfZGlzYWJsZV91bnByZXBhcmUoaW14Nl9w
Y2llLT5wY2llX2F1eCk7DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQlkZWZhdWx0Og0KPiA+IC0JCWJy
ZWFrOw0KPiA+IC0JfQ0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgaW50IGlteDZfcGNpZV9z
dXNwZW5kX25vaXJxKHN0cnVjdCBkZXZpY2UgKmRldikgIHsNCj4gPiAgCXN0cnVjdCBpbXg2X3Bj
aWUgKmlteDZfcGNpZSA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+IC0tDQo+ID4gMi4yNS4x
DQo+ID4NCg==
