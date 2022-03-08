Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60D4D0D6E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Mar 2022 02:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239968AbiCHBUy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 20:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbiCHBUx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 20:20:53 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4153701C;
        Mon,  7 Mar 2022 17:19:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkldsbVODyyTjj1rdAL1YcMUixh1GPNHMEq+O7J7+gWlqUVJEGkTG76TsxZBzT6u4AucTBuM+fOcil7JsR8lb5HnSY3HhnX1Q0a6yAcgvMT2P2bzAMhjTuCt52I2ucJ2uAhRvwd1igdaQ79iptgYXjeAAuFh5tQtwO491vzVzL26WhYfcAuRB/Be5mB0oP2+6QKITxffz/P2gJBEbkcYP3P4DCCOAGTGQesZaREu2PvdORCELfH3m1qfgK9tIbHzhbysD680GkxKy420HaYptRWim6318vIcDNMqAry012fPGdXVWnO46Vfo4mnzM+7EC9Z86/Plt6bof4F9lHVc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSwnOdOFXKtIlGNGjmdlWglT7lTiNqMqDIU8Dtfdkw0=;
 b=JRFMNwf4mbhFfRnm1ewFBE7b9MYUk2W143ZzQAH4S2hgOwTfYP7HKmOxQKqSz4LEaw0WLc0vdnurdI1meEEg2M2Aox09EHNZQGZLQYY8NpUDJ4WkNFezhVh22ZK1nyavddeQrGwG/pzbhZZ7Xduu45xEVlxkVJ4DU84xZDh3VU6Z9i93vb3dNoKMLwrFTYBj39ysIVorkQ5QIt8ossIipLnzU0E/brmUGNVrp8KKp1wF9vw3vstRCOdREYugwFg9rr07RF6tXzVKJuMKSz9/5Zm7ZUHfM07X6UpK4lxkPIcLmJyxR8z6sJWTswEnMxMhccF2qR3YHsVmWZQFIS9Xow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSwnOdOFXKtIlGNGjmdlWglT7lTiNqMqDIU8Dtfdkw0=;
 b=QvzCw11TB+1i9hmSl6KOZWnjlfnuCeaExE6H0EHV8IVeWPiX8va4nnsiyBlwsRcshgPz+fEAwdVvfpg+ZgNrupcyeR5MJYSZ09rErvqcmykYypbUC8W53vqSKKBXEMFOKWm0y8MczC5co/O0FTE0YeQFgeswIffLNaBiYTgKIdk=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 01:19:54 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f4f1:fe49:d19e:4770%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 01:19:54 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: (subset) [PATCH v4 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe
 support
Thread-Topic: (subset) [PATCH v4 1/2] ARM: dts: imx6qp-sabresd: Enable PCIe
 support
Thread-Index: AQHYJu4ruxJawa+vt0yMCXDCniTOhayz2eGAgADqgfA=
Date:   Tue, 8 Mar 2022 01:19:54 +0000
Message-ID: <AS8PR04MB86766C54D8EE380B0F603C3C8C099@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
 <164665133421.20091.3372213554169695625.b4-ty@arm.com>
In-Reply-To: <164665133421.20091.3372213554169695625.b4-ty@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 688292a6-e597-4775-55be-08da00a1c099
x-ms-traffictypediagnostic: AS8PR04MB8690:EE_
x-microsoft-antispam-prvs: <AS8PR04MB8690E7BE0E24B75E662082578C099@AS8PR04MB8690.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z86+9EncD+O35ufoyCTbdj+WOENTmizLiy3BxzrTe4r02pjrGsDPEETPxURtiP1LezzvCSa46TyLwBsOW/L7H7OqV22JblW16BqmUJEsxoBFifFZq5lG0oA+zLgndoWq6AS766zVnWBIhUVrzQS60AfBmLtp9L00ntCOE6rCFbL1hKt6WU7XP2cUdkRMCaXdl9xM8YGEB6iLjRG1zMmhfeM3IvTcyHH5rinsg4dm12sU9AV8NECOl2toiCbYzOlIujSxTPJ2bf/+KTRx55rqInyGTCRXu1KUAoVynDciIt/NAvNyveZoIDrWpRuBP0iR/aUTWVrvHc7rPSGL3YapRUVZGbI+5h31q0d+5aV/tJPtawl62/w1UWshcWHNcjfbgwqtrAWkEtVGLDYt8b53Lx1WzqPaba1L12lGzWVNGTVbsfXJzs78u42aH+lm6WszDhOfinoz3j4qJKBXHd7JYmcqa9N5biAKR/Z3tfp9eiBWt0yeZx52qMsEa7Po1fNfvQbvcr+W6jKSJq9POU8Fu+rr3HbxUFCFyRcHLNPlHXwillJvkVTlo5buMnVtnwgJnezhjI8e32IBadUQ1cQ+hRnBGB3oTGRfQd/oKavTGsyWrSzE8qFQNwfx5w2QyAL9aqSOiabCq8xQF4nmeRhKoEB34Ldj+hOkVA+bXFzj9Ovih6tXJXoY2Yq1sBESYreSXeCN3t1xh2dz91CELxT6AflQYowFUBdN/KyxIX+t66lti8LFJdM7ZjRsWO1uDBfR/yEtZHJiHaHTdY5Hbd+2mTBpmfVu8U8an/9hnJWMwUPTWdSJ2fXufiBAkrfw5phO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(52536014)(8936002)(38100700002)(122000001)(38070700005)(186003)(83380400001)(26005)(9686003)(966005)(53546011)(71200400001)(7696005)(6506007)(508600001)(45080400002)(54906003)(110136005)(316002)(66446008)(66476007)(76116006)(66946007)(4326008)(66556008)(8676002)(64756008)(55016003)(2906002)(86362001)(44832011)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bEx3QXBBTmc1MWlqZE9NL3dZNWQxUkZiTEtLT0doTDN1bXJTbFU2OU1ETlBh?=
 =?gb2312?B?UHUxM2FFZ2FQd0pxcW1JUGlvWFhvMmtmYTllTzJNVTFiYm1vRWxhUGVGMUlX?=
 =?gb2312?B?TkM5R0NhVWRTaitzNXo4V2V4ZkJCc2RHTFMvcmszUE96OU9NMWlDRGp4UGJY?=
 =?gb2312?B?M05LRE9TazFsZTN4NHdXKzVPTEdqMEllV0dvb0lvWDlaSDRPRGFtUThUeVhH?=
 =?gb2312?B?M3AvOW0wWnN5Q0dhQXlUQ0Q2cnY1Tko0L3RzbFhUS2RvcWdDV0Z4R2J3Vi8w?=
 =?gb2312?B?ZitXMEtnZHIwZUtlT1lQb0hlUmxNSmc3R2FwakZ2TFQxQm1LTVZRMHNGYUpW?=
 =?gb2312?B?UTFwT3FHdjBTOU1GcmNtTzFHMFJjcEw2YnZ6OGM0NEhoZ1ZXT1hQbVArRXJE?=
 =?gb2312?B?SkJUYlVUTm5DbEJTYnUvQWwxVkdqQXIzOThtVDI0cTNPdjdCaE5na0txOU50?=
 =?gb2312?B?TytzTGY0QUluNVBLSXJHZm13dWdvSDhyc0YvWjlVV1B0dXo3SDl1d2hJWUtn?=
 =?gb2312?B?U1NvajZ4TE5XWFE5dnlBeGNMMUJHdnUrdjhoWkJzbkJkemlVeklBMmMxYVhO?=
 =?gb2312?B?a2RtYllmZnJMbjFFZTRaQStKcXNycENETWR6QThCbWFTN003NmZTWWpJS3FI?=
 =?gb2312?B?WnlJbnpXRTBYcXE3K0VWOFBMa3JjV1ZpYkU1cENtamhFSm5ubWJGa3lpYUd6?=
 =?gb2312?B?emh6UVErY1VnKzdGTGxvU28wQ0FIcVZVTWg0bkNPckkzZ2Y1bG5nbFl0bXl2?=
 =?gb2312?B?MnJ6NjFnUTNEVkZOV1Rid3N2VEZBQ3dGakdNUjFhV1ZvSG5RcDJLaXpsV1Fa?=
 =?gb2312?B?TXBJYTc1djZQaCtGTi80bFUvaG5wUHZzbHlFbkNjZmFaN2lKUndlUXBhclh5?=
 =?gb2312?B?TTFhd2l6OGlwdU5JU0VVVllwR3QzWGNLY1hTeXV0VFMvLzVOUWZvRGd6NkFt?=
 =?gb2312?B?QmhXalVyRU9UckIyQzh6Z2V1UGxnZkM0aFB6NTZndTMyMGdINUdLL25WTzk1?=
 =?gb2312?B?bkUxN2VHZyt1S0tNUThHK3kwYk10eUFabXE3UWY0TUlHWjI4TnFuOW84THhD?=
 =?gb2312?B?N3JoVVhwcTY4ck1uU2xZYW1rMFVBcm1DY3BQTk43ZDFZYzdpNDl6anY5ZnQ4?=
 =?gb2312?B?TFFGV09BdjdqcmF3WFFHZnplbnRyaVFwM252bkZHTHdGVHptQlJIeHIxZWc2?=
 =?gb2312?B?KzJRU3hKSm5RSG42UXNDZ2ZEU2NxNHpqeWFZZGlnc0MrL0c1WWwzL0xESFk2?=
 =?gb2312?B?QW9wWVVTSzNOQjI0UW5BdGc3OUVFSkhiZmVRaDRNREtmbWFRTVlwRUliSXZJ?=
 =?gb2312?B?aE5ieTZwR0g3NDBPWklFMXpvS3hBVDhYaVliYVJ2V0h2R1RZUlg0VGxKNkI3?=
 =?gb2312?B?cXk1ZVBsYjdrVUtYRWxSaEt5VC9NcjUxd0d2RHZucVQxak96MElGc3JsVFBm?=
 =?gb2312?B?L09hWWUyQUJaN1Y5STRmV0haWTZzVThoUEUzWUIybHZ0TWZjeFpnS2IzNnVP?=
 =?gb2312?B?TTVpMlpaZ3Q5a0pnYTU5TktRbW4yRlpETmM2T3N3TFlWbDN1VXU0TSt3c0lr?=
 =?gb2312?B?NFRyTjlpVTQ4M0h0UTVRNkFNT2NmVXU2dkNBQTlMQU00eHhFSUlzYWxuV2dy?=
 =?gb2312?B?TFI0bHBOVE04bU10ZzBBWW91bG9VWTg0a0dkQWYzcDJJcFdzbWQ3TEdCQnNx?=
 =?gb2312?B?Wk9lVGJhUER0OE56a3h6azZiQ2JYNmdyUHlnd3FPaHVuM1B1ZE5ETWgyeUpJ?=
 =?gb2312?B?TFdFcGkvek1kT3pRbjVPMENqZTMyZlNCWlRWNy9xemUrcEg2YzVZWVZNcjlB?=
 =?gb2312?B?QkxlcUFMN2JNMEhiODRES0d5R1ZPZUk2dGR2aGlxTVNLdlZOM0xCNEpXTFlq?=
 =?gb2312?B?UEhPVDJtUGhQTkkzTW00R29rbVN1dWM0d1NEM21vaFhmNUNPQ0NqYVpSQ0l6?=
 =?gb2312?B?RGsxYXQvOWg4MHk5RTc2VlBxYTA2RS9taXA5bFdMRmZXWUxRMzhBTUR3TUZY?=
 =?gb2312?B?SlorT1AwZVJtMytXSkxSNnhHYjNPa0ZqMWplU3NJd1MrQStpd05QWEhyZ1pq?=
 =?gb2312?B?UjB4aFFvT0lOQ1pvVFVmVmlYeEhUQnJFOU5NaDFHSmgwTVM4WXBuNUdpL3hE?=
 =?gb2312?B?OGJQZHN6WTlrSWtIaXN1TTNLV2VlTTBid0twOS9yWWRmUDcyVHNlclF2ZlNQ?=
 =?gb2312?B?cEE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688292a6-e597-4775-55be-08da00a1c099
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 01:19:54.6898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59So7Om925bFK8/T73++QeBLNpJOGXaytLme/5Oh1K3MUMN2fRJNi5EbGg3OHJsFeT52FHqOFAcClolTHc+KcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAyMsTqM9TCN8jVIDE5OjEwDQo+
IFRvOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAu
Y29tPjsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZQ0KPiBD
YzogTG9yZW56byBQaWVyYWxpc2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+OyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IChzdWJz
ZXQpIFtQQVRDSCB2NCAxLzJdIEFSTTogZHRzOiBpbXg2cXAtc2FicmVzZDogRW5hYmxlIFBDSWUN
Cj4gc3VwcG9ydA0KPiANCj4gT24gTW9uLCAyMSBGZWIgMjAyMiAxNDozMzo1NiArMDgwMCwgUmlj
aGFyZCBaaHUgd3JvdGU6DQo+ID4gSW4gdGhlIGkuTVg2UVAgc2FicmVzZCBib2FyZChzY2gtMjg4
NTcpIGRlc2lnbiwgb25lIGV4dGVybmFsDQo+ID4gb3NjaWxsYXRvciBpcyBwb3dlcmVkIHVwIGJ5
IHZnZW4zIGFuZCB1c2VkIGFzIHRoZSBQQ0llIHJlZmVyZW5jZSBjbG9jaw0KPiA+IHNvdXJjZSBi
eSB0aGUgZW5kcG9pbnQgZGV2aWNlLg0KPiA+DQo+ID4gSWYgUkMgdXNlcyB0aGlzIG9zY2lsbGF0
b3IgYXMgcmVmZXJlbmNlIGNsb2NrIHRvbywgUExMNihFTkVUIFBMTCkNCj4gPiB3b3VsZCBoYXMg
dG8gYmUgaW4gYnlwYXNzIG1vZGUsIGFuZCBFTkVUIGNsb2NrcyB3b3VsZCBiZSBtZXNzZWQgdXAu
DQo+ID4NCj4gPiBbLi4uXQ0KPiANCj4gSSBza2lwcGVkIHBhdGNoKDEpIHNpbmNlIHdlIGRvbid0
IGFwcGx5IGR0cyBjaGFuZ2VzLCB0aG9zZSBzaG91bGQgZ28gdmlhDQo+IHJlc3BlY3RpdmUgcGxh
dGZvcm0gbWFpbnRhaW5lcnMuDQpVbmRlcnN0YW5kLCB0aGFua3MgZm9yIHlvdXIgaGVscC4NCg0K
QmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gWzIvMl0gUENJOiBpbXg2OiBFbmFibGUg
aS5NWDZRUCBQQ0llIHBvd2VyIG1hbmFnZW1lbnQgc3VwcG9ydA0KPiANCj4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGZ2l0
Lmtlcm4NCj4gZWwub3JnJTJGbHBpZXJhbGlzaSUyRnBjaSUyRmMlMkZmODFkZDA0M2VjJmFtcDtk
YXRhPTA0JTdDMDElN0Nob25nDQo+IHhpbmcuemh1JTQwbnhwLmNvbSU3Q2M2YWIxYjljZjE4NzQ0
Yjk1MTYxMDhkYTAwMmIwNmYzJTdDNjg2ZWExZA0KPiAzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2Mzc4MjI0ODIwNTgyNTI3MjglN0NVbmtuDQo+IG93biU3Q1RXRnBiR1pzYjNk
OGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxDQo+IGhhV3dp
TENKWFZDSTZNbjAlM0QlN0MzMDAwJmFtcDtzZGF0YT05cFVBbTNGWVV0YkthYm5oaUQ3YVYwdg0K
PiBtUHJCQ3dhJTJGN3UyR0JRTGF4QlowJTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KPiBUaGFua3Ms
DQo+IExvcmVuem8NCg==
