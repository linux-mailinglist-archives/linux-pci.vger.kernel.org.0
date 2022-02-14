Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19B4B3EDA
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 02:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238989AbiBNBS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Feb 2022 20:18:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBNBS7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Feb 2022 20:18:59 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60064.outbound.protection.outlook.com [40.107.6.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F00D527DC;
        Sun, 13 Feb 2022 17:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWItzQGk5V1eM2encOutpYeXJQpFc/eKEh/KHuUzrnbbJD4Lmc3uEuR6Kj7VexYzPBVqigYd7LrGDQ5iLgXmSymzpJDOmwixyS4Lw7Idy9v48NplEacRbclTowbyqy257jnr3k++o/O7Gue/qTMOBdoCQn0q6X30tPmymSJsy4MJxMP2OSOU63Y5nzkRCBq7pDE7mgLqf23v8/MCUhRFTpforCWVrVcvg7WdSsXcJLUgdQZIYTFwebg26QxyfA82eqmr/F2VWpaJy24c3ThjpzwmZAIHZZI9IcI1PwV6n2jKjz+bs8hOkWjaHjrS8k/eylQ2kFzKKmqQ5NFTrzoSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zakRBcW+1rfmmyGZUaHjS9jx5CGYKW2X+ohvPvb9AgQ=;
 b=Jr0PEsixOBqpAfy/9cPLYCUFMgxBJX8grPybdHSb+d0PGk0QphHp2cetYzeSbmz/iDviJcUyd1amTiQnVn8kZsLhDRPDYfFiqgIddnsepWor+rWnM5EmAX2r74TUQuwqDqdT7qoZOvwPZ8RJXj9gyWKZaGvp4R8+trLZOKu1mfHfSmnTP57XxLKT+35+c86gQjSnEWnEXC7Rx3DLVcUWqhT/UcpplsM3EsO0hV/8OEJhTQKMBwhhV/vyvz+zUKhLdjQD4l6RMgwTrcuyRQqzhg9YJJmo9vdLOjpDFgDZqgNRyxnhfaMbCyqTMqeHvIpCQlevJweHXcd9L7rtXMIO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zakRBcW+1rfmmyGZUaHjS9jx5CGYKW2X+ohvPvb9AgQ=;
 b=WWiIzTGDk0vFYKxBj2jQfwX2UoBdVn5xefdD5Ik+HritcWmD6xGW41xQY6HmNoXiDHU6Z0yTC64EaTONEj0RAOKsZavF4tsq7Ll0B3dzsD22hGSTHwvNYMBsCUuQkaPWxupfNQZMkOeoOBJh+q4XDHWCqjcx5KwR3LAY1WyoaTY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB9224.eurprd04.prod.outlook.com (2603:10a6:102:2a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 01:18:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Mon, 14 Feb 2022
 01:18:49 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Thread-Topic: [PATCH v2 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe support
Thread-Index: AQHYHx4Al/jcwVa94ECJzobIRwmI7ayQ5wwAgAFbLQA=
Date:   Mon, 14 Feb 2022 01:18:49 +0000
Message-ID: <AS8PR04MB86766395B896FB1F398B81718C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644564779-8448-1-git-send-email-hongxing.zhu@nxp.com>
 <20220213043143.GN4909@dragon>
In-Reply-To: <20220213043143.GN4909@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94fa9405-bee1-4c98-052e-08d9ef57f49d
x-ms-traffictypediagnostic: PA4PR04MB9224:EE_
x-microsoft-antispam-prvs: <PA4PR04MB9224CC9129B4CDFD5D5EA3C48C339@PA4PR04MB9224.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j4UVMHwACrB/rqVDez3Fari3VWflRaFtIjRQdoZUWsJ56qbIQxAoeIxBk7fHEdGs6uXjORx990tAWVgoLbwMkcPu1pqLCoPI2QiYgPc9+aoLeywk0PvnSDw26yA4xj2/cksp+pYEjfTVbx2UV201lzEsltFIi8OSTxuOZYnzaIiN1lZEKz/B2Pb4ic6grjOL7CiY+Ve4eogVVdJ8Ea2UH+lbYg78sH4eKlAvO/pnI6lqU/cEd1K1vpy/5eYTWoUOLNW/1ku/W7w9WqkYrqQPMldWl/i8UQ5YBrC3yJ+4b6sfxAJzdjVkCljJKYNTMcsaiqdxPc8xIzAahHF1UqxY+G6t6qv54nHPBtlEemzXnYUI7trT5tHacWrUB16zeK9Gu4bdm/3JCBYRtw5Fizhmr9LDFZBTbwCY48wFpDSazIPoNwLLlAAxlgB5BLlDByNQn5Yz0QbaNSEUSOO8C/dE7ayMG7xkMu3nET1zQfNiAQ8D1ZMeVsJ1R/b7brZYJfYfn7GUpL6ePvdXFBcIeKrsHctmc3pLkxGvsWoGYTBxreyUiBrPkzLTMfmQp6/6kKpFcPZ9BgsDaP3iPW3/FmTZsRCXQzVbwpu8ov3x8UtC6iaKTJBzJB4/thhV+uTRm9kyi/ZQYG8HMYeEXJeqaTkWBfaEXP0ndWrBBmmVGVEFNTyLC7fuMc3cPJgAJXITxXyQA2r10R1mNY3cqwCC3MQgK1pui/EouZ6hHQLtrmB+fMc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(316002)(6916009)(54906003)(33656002)(66946007)(66556008)(8676002)(66446008)(64756008)(66476007)(186003)(26005)(4326008)(76116006)(52536014)(2906002)(38100700002)(6506007)(7696005)(5660300002)(55016003)(8936002)(71200400001)(53546011)(122000001)(38070700005)(44832011)(508600001)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b1FJRTdmalpWbG53cnlmQWhNKytPVk4raG15cVdSL2NaRndIUTZGaUdtdlVU?=
 =?gb2312?B?R1lRNEh2ajJtRDRpWjJpNmovdmQ5NzF1NndKdHR3QjBLOWQ1c1BMZnlwbHdW?=
 =?gb2312?B?SzdBQTUrSWV4ZFVLOVJxUGNRbHUza2VKUkhTRHlwTkc2QTVLT0dnS0Z4dkpQ?=
 =?gb2312?B?RjF4eDBHMmJxOU54eUdiNFg3VDF5eHdzZXYzeG1Wczl5N3REU3JYU3k2ei9B?=
 =?gb2312?B?SVhFVHhDQ1VDc3hlN3JVTitta1hCcGsrb1FXZDJWM05KUnBxVFIxeW96Y0FY?=
 =?gb2312?B?bGxZSDZRb1RHTVkzLzQ5S3BGSkNBcFUxMnlCUzlENCtkTERnNDJTNWtVSjJQ?=
 =?gb2312?B?aTF2ZDNpUXArQXJyNHlNa2c2WGpDTmJvZFpzaUNIaG9BVTNnZ3dvalc0QTha?=
 =?gb2312?B?RFZOYjRUci84dkZHcWtMOFJkVWlGUzNTempmRXkyOGxkSWZ4aXpjdW9EZWhY?=
 =?gb2312?B?dTBXTEJ2LzlpblJYRkdPQ1R1eHFVUllDaFY1aGpGbzdtamp2d2VWRTU0U3JO?=
 =?gb2312?B?VmJHNTdFWm44Ukd1bGFDb0hrQXhnT2hTVlB6Q2laTjVYWi85K1E1QmJCQnp4?=
 =?gb2312?B?RGk1NVlaRmFxbSs5TnMxSHh4dXF0U1F1dTB0K0QranU1N0RTZHh4UEJrcTFE?=
 =?gb2312?B?ZXVYLzV6RVBhZUNOQllqaDYwOU1DM3lrTW1PVG85YTNqcE5oeFlBR2tCRlp1?=
 =?gb2312?B?ZmdvL2VGdzVRNHM5bkhXcjdmamNkQ05UUC8wWCtNTElkSjBFM2lUdHk1M01W?=
 =?gb2312?B?UENXL3llaTlVR1VPNzg4d3NsWkZoblRrZ0s1Umdid0lXUTRsWGlUWG1LdTBZ?=
 =?gb2312?B?bDZUb0NuS25VRG5QbWVBV1hJeEk5Y281VmJGalQvZW93aWd1NGJ3RE0waWNL?=
 =?gb2312?B?bmpERjQzbSs3Y0JabVNRY0dZZmN5OWMvVSsvNWthTUlwcXl2MEFIYnBtOWNW?=
 =?gb2312?B?a21nQXhlOXdPeUhML3hQbVJXdnhDRGJkRDM2d3pZY1ZkKzFScCtJOHdVRWJz?=
 =?gb2312?B?R0pRL0huaXR6K0lvTnVzSzF3V2RreGhtcWoxY0pkaFVJZ1JLU0dsKzNORHlV?=
 =?gb2312?B?em4zWGo4MEhxNVpWUitMeHRmbXVWM1ExaDBsQTEwV3dQNUlEZ1p6NzVUdHhl?=
 =?gb2312?B?YkVHN24xbjhpYVY2c2RKRUNiTm1KbHdYUkdjTk9SYTU0b21tUWRCZTY3MkFM?=
 =?gb2312?B?WnJQS0RaQUc4NVRYNlhFZ3ZLb1VCN2tSV2FOQ21OZHg5L2pTam5WZUMwbFYv?=
 =?gb2312?B?WlFscDIweGN1QzVOMzQzVGlGbnRYTHlYTHNyei9OYlVqSnFCRjk0UG5qMU5L?=
 =?gb2312?B?cXNwWk1rdHJLS1hVdWxhUXgxbWNXaUpobnBBVmQxZkRwVmEwcVRNaDBzVTV0?=
 =?gb2312?B?YnF5bThiM0xpcTVsdUlHb29PRXJ6ZXowcWVvcDNla0UvMU41dEZlYmIvcEhE?=
 =?gb2312?B?MkNIbXFlMFNKL0trcVRIYmNFNFd1STZXS2M1dUs0cUxuOGpTWkZTK0RicEU1?=
 =?gb2312?B?UUZJbjNrQVQvcXY1aElMZEhMeEduTzZjRXVaU294MGdrSVRsdFhrTzNqTVFv?=
 =?gb2312?B?WkgxWTg3aHNYR2JraGNjaDBLSnNBWld4ZElqU0pYUnF0YUVoZ2NDUWNxeFho?=
 =?gb2312?B?aWFacUFOdjZ3UjRQbWUvWXNBRjJiQ1FodFh5MDBxWldjdTVtUk9kcDhzcFZI?=
 =?gb2312?B?cEVMNU5IMEs0S2hRRDZEMjgyck5NUlhyRW5EdTFHRTB5TUVPN05xTEZqcVdD?=
 =?gb2312?B?ZTIvWkUyZUNRYzY4amthMExOUUZ3Qjd6ZWJrZER4ZzRmajdkRERVSnE0Kzhs?=
 =?gb2312?B?dkxOMWpBVWdvUEFCRmtLa1o5SHcvdm84UTNGV0VPa2M0UUZXWnN1SUxpbytK?=
 =?gb2312?B?WFpYNzM4UUpqdEdrL3JQT0pSYUszUThxSVRCTlhNUXVGYUY3TUJEdEZneDdZ?=
 =?gb2312?B?ZzdoSGVyM0pwcVN5MUFKZVFvRlpnTVZyRFNBcE9pcUdWRkpabWxRNHF5d0JF?=
 =?gb2312?B?TTg1R3A4SGlKZnhQblBFSUtUcXo2Ny9NcXlTNUhQMFk2R0NvUWlNY3hWdkpz?=
 =?gb2312?B?RzlaamlYclBzMFBybWlVc1k5NmVvYUZoZHdtL2wyK0tRcmFRTEZRTTBaeEtF?=
 =?gb2312?B?SzFMbUx4L29oUU1QZWkyRVl3V3ZZN3RKN2xKODM1em0wZVIvdS9iMVZUOXUz?=
 =?gb2312?B?b1E9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fa9405-bee1-4c98-052e-08d9ef57f49d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 01:18:49.3822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDedIjs+DnP3Mi884wH5Ts5yMUVGWiXpUoRk3wgWJRVCcrjOFCeYW+o837LjpBjaG+5di/Iy1BuItMCLmYiOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjEzyNUgMTI6MzINCj4gVG86IEhvbmd4aW5n
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRl
OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBsaW51
eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAxLzJdIEFSTTogZHRzOiBpbXg2cXAtc2FicmVzZDogRW5hYmxlIFBDSWUgc3VwcG9y
dA0KPiANCj4gT24gRnJpLCBGZWIgMTEsIDIwMjIgYXQgMDM6MzI6NThQTSArMDgwMCwgUmljaGFy
ZCBaaHUgd3JvdGU6DQo+ID4gSW4gdGhlIGkuTVg2UVAgc2FicmVzZCBib2FyZChzY2gtMjg4NTcp
IGRlc2lnbiwgb25lIGV4dGVybmFsDQo+ID4gb3NjaWxsYXRvciBpcyB1c2VkIGFzIHRoZSBQQ0ll
IHJlZmVyZW5jZSBjbG9jayBzb3VyY2UgYnkgdGhlIGVuZHBvaW50IGRldmljZS4NCj4gPg0KPiA+
IElmIFJDIHVzZXMgdGhpcyBvc2NpbGxhdG9yIGFzIHJlZmVyZW5jZSBjbG9jayB0b28sIFBMTDYo
RU5FVCBQTEwpDQo+ID4gd291bGQgaGFzIHRvIGJlIGluIGJ5cGFzcyBtb2RlLCBhbmQgRU5FVCBj
bG9ja3Mgd291bGQgYmUgbWVzc2VkIHVwLg0KPiA+DQo+ID4gVG8ga2VlcCB0aGluZ3Mgc2ltcGxl
LCBsZXQgUkMgdXNlIHRoZSBpbnRlcm5hbCBQTEwgYXMgcmVmZXJlbmNlIGNsb2NrDQo+ID4gYW5k
IGFsd2F5cyBlbmFibGUgdGhlIGV4dGVybmFsIG9zY2lsbGF0b3IgZm9yIGVuZHBvaW50IGRldmlj
ZSBvbg0KPiA+IGkuTVg2UVAgc2FicmVzZCBib2FyZC4NCj4gPg0KPiA+IE5PVEU6IFRoaXMgcmVm
ZXJlbmNlIGNsb2NrIHNldHVwIGlzIHVzZWQgdG8gcGFzcyB0aGUgR0VOMiBUWA0KPiA+IGNvbXBs
aWFuY2UgdGVzdHMsIGFuZCBpc24ndCByZWNvbW1lbmRlZCBhcyBhIHNldHVwIGluIHRoZSBlbmQt
dXNlciBkZXNpZ24uDQo+IA0KPiBJIGRvIG5vdCBxdWl0ZSBmb2xsb3cuICBUaGUgY29tbWl0IGxv
ZyBpcyBhbGwgdGFsa2luZyBhYm91dCBleHRlcm5hbCBvc2NpbGxhdG9yDQo+IHJlZmVyZW5jZSBj
bG9jaywgd2hpbGUgY29kZSBpcyBwbGF5aW5nICd2Z2VuMycgcmVndWxhdG9yLg0KSGkgU2hhd246
DQpUaGUgdmdlbjMgaXMgdGhlIHBvd2VyLXN1cHBseSB1c2VkIHRvIHBvd2VyIHVwIHRoZSBleHRl
cm5hbCBPU0MgY2lyY3VpdCBvbg0KIHRoZSBib2FyZC4NClNldCB2Z2VuMiBhbHdheXMgb24gdG8g
dG9nZ2xlIHRoZSBleHRlcm5hbCBPU0MgYW5kIHByb3ZpZGUgdGhlIFJFRiBjbG9jaw0KIGZvciBF
UCBkZXZpY2Ugb25jZSB0aGUgYm9hcmQgaXMgcG93ZXJlZCB1cC4NCg0KVGhhbmtzLg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkDQo+IA0KPiBTaGF3bg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzIHwgOCArKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+ID4gYi9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2cXAtc2FicmVzZC5kdHMNCj4gPiBpbmRleCA0ODBlNzMxODNmNmIuLjA4
M2NmOTBiY2FiNSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cXAtc2Fi
cmVzZC5kdHMNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cXAtc2FicmVzZC5kdHMN
Cj4gPiBAQCAtNTAsOCArNTAsMTQgQEAgTVg2UURMX1BBRF9TRDNfREFUN19fU0QzX0RBVEE3DQo+
IAkweDE3MDU5DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZ2Z2VuM19yZWcgew0KPiA+
ICsJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47DQo+ID4gKwlyZWd1bGF0b3It
bWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiArCXJlZ3VsYXRvci1hbHdheXMtb247DQo+
ID4gK307DQo+ID4gKw0KPiA+ICAmcGNpZSB7DQo+ID4gLQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+DQo+ID4gICZzYXRhIHsNCj4gPiAt
LQ0KPiA+IDIuMjUuMQ0KPiA+DQo=
