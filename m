Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBD631899
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 03:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKUCYj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Nov 2022 21:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKUCYi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Nov 2022 21:24:38 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70058.outbound.protection.outlook.com [40.107.7.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4342A957;
        Sun, 20 Nov 2022 18:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an1hpREtrwjPGuoA4X4aT+LLv/FLFm694wTe/PtfV/Pk2bkNB6CcXeQvyjJ3XmohJU9BgVOgi/MQXEFRKTokOzF1dCZS8EkCkdJCPH7lrue7DuSwEA58Pp95zZLGh2g6mKST2TXAA/YV3mEI0hJQio2MXgypdpCx+mQP1HxCQ/DUdEL+FdXubk1WYRlfbs9/txmf+/qNZ5ofhazQ6CU25yS3z7qO7KkC2oluHQBZ2GhPeovVcwtBp9irUJB5e/g1PYmXbGv7Uui/wX6H4eSZWzhZs9C/SU9FkxC/SITmi648rpnYmMst/EZyHPf41+Kfgq2845KkHcMA7XTM8Z9I4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahBr4t2Fhm3bvdQt5S049zqrSwTLn/ECPO/sPYlJleA=;
 b=bKFfP+X9d62lJvdQZ9ISOyV8zuImHih6YZaV5yUQTFGVkPn9cWCHlgKZABWslWX4+flIUggb4VJQQ+Fy2VC73BcE1wb7bk4BfiIK6HuS1suU5aI2NCogO7SI1XLQz2fAcWk5inXXDQlI7/j6AlV5zZ1I2QfZFnPUS8QI812ZF5k1OifyS/AF307foi2i5eGPOIBBrxC40pphYdZsgDkv5nJQMhfX7gaWcNkRyAo/w1vhM/ltFnsgdqZgBET8LZ4allKcWsmS6FkFvDirqgv8UaJYvOsVmOf4tWrNDSaQurEmf6pdOpL9doWIdmhS0WjtjSQfeUOV1aly3fv1CQL7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahBr4t2Fhm3bvdQt5S049zqrSwTLn/ECPO/sPYlJleA=;
 b=bdKrGXSPCTVYQvQ4mMGRHFJgwwLxKQkqaNayThsFnTg9BYxRtGhyxtM/6qabdrSvNTZ9JNK0PfqaZqDuu0PZE4x1nZSXqa6ACpd5o6moziFgDgbsjntzxshboRvzSnTuWCsySrN1TC1nDWjqc2tH8QI+ERDWy+BI8CQPMa31xYM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB9709.eurprd04.prod.outlook.com (2603:10a6:102:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Mon, 21 Nov
 2022 02:24:32 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 02:24:32 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "marex@denx.de" <marex@denx.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Topic: [PATCH v2] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Index: AQHY+vxnXue4lENJ1keLvz2yS/EdZa5EhISAgAQkE1A=
Date:   Mon, 21 Nov 2022 02:24:32 +0000
Message-ID: <AS8PR04MB86761612418538867E332AA38C0A9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1668740199-31956-1-git-send-email-hongxing.zhu@nxp.com>
 <dda2cd20b823b002e4b2dccb69741707785a2474.camel@pengutronix.de>
In-Reply-To: <dda2cd20b823b002e4b2dccb69741707785a2474.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA4PR04MB9709:EE_
x-ms-office365-filtering-correlation-id: f4e586dc-6a7e-4df9-14a4-08dacb678669
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7qqmQw7i7Q9lqEJt/qAiMxHoQg/MabRV4RyXyZUd34TNNsD5niA+545Wy6BcgFLfgI7JZu8mfcBYCXtnzcOI83PFDS4xp4FKzGl64mhh3ufBzvslSavc3zfAGl+TGeUeyDqe/o6+i8HC/IO+xoYgwwwxervxfOqEJRfGuVTyIbhW6cZUGvtAslVPA8ONHSWj85dTSuHNJQjj8EFU9pmEfC8uR2JbkJFthfnY5FsYbNILqZAM7mA5PD/SxPhZKtFeD8ooFAELGda+HawnbtqwHRQTla3QUbYs2/6rLz9s+sZXShlhK+KxA7Z0WTz3E7+cMOHH+ZbK0aLDJbFaBrMeNXGYmUcYbLRXhIsdAmb+wgPI1G7NgqLXHuusmRpLGUgVkQrmWQQxE9ATDLgxycSsImC/rjbPTf2+Lc/BxlvsIY9duucxx7Q5H/79fczJY1ZNG7bg2LvtDAz04eYkyx/yyq+9bQ8f8/XKOazb+K/yd+eaqNFSjdv4LlXeOeZduUMXVN/D3sHYhCVuJ7AO+kplE4uMYO9Ecw58ekW5vMrymywwVbM7h2Dy0SViYpklgY+MTSvDUg2ej6/ykKDsMlqL98M4pJnN9IIXS7tpbLutHV6ehHRDc1EN1POv5ZOIcvKwRr1/zGR25Bu/5EstIjXggxu9iLnYYexnZWVG6acJZPMXycNO2aL8oeNBdWADEDYE72HA4ehMGvM7tDjEIXsds1afOMmGkFAYNdEqOu81w+j4eLkCunkt/TNHlLYcpuJ7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(84040400005)(451199015)(2906002)(33656002)(7416002)(8936002)(4326008)(5660300002)(9686003)(26005)(44832011)(53546011)(6506007)(7696005)(52536014)(41300700001)(86362001)(76116006)(66556008)(66476007)(66446008)(66946007)(64756008)(8676002)(55016003)(54906003)(110136005)(122000001)(45080400002)(478600001)(38070700005)(316002)(38100700002)(966005)(83380400001)(71200400001)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bVlLTDNXRTMwcTJMSjJBL2x5UFhqdnFyeURXTXRlUkdkOGllY3JoSkhOekt3?=
 =?gb2312?B?R1VESnYvV042UUJsUXU2TkREbmdTeEI2MGMyNktVRldsbUgxVVFXdTFEZTFY?=
 =?gb2312?B?UmU3dnBwNGg1NUprSHQ2bW5XaytrR1BxZUQ4U1o3bWNNZTIxVVl0Syt5aUQy?=
 =?gb2312?B?UUZRckxZMnp5SHZVU0hZM2dTR001YUNNd3ByYzJ3bkhndUd4UU1rSWdVTHpW?=
 =?gb2312?B?VTVIME1tVzdHOGdMeERQYjdOOU5vNmtENDdmbUV5T1dXcWNoZEo5UVh4SU9Q?=
 =?gb2312?B?bHhOVDdnc09UTm14R0NTSWdGMjJpSldrRlo4TGIycjdnVElyZU91cjNaKzhs?=
 =?gb2312?B?ZXZQRy9tWDNTNjl1ODlDMCszMThVbG5ya3hOcmo5SUlMRDVMVUprTG5PaVZH?=
 =?gb2312?B?QXhhRFNvekp1WWxWUDYwUWdmNlJwOURZdmxXdHRpcjFldG1odVJ6VlBmd28w?=
 =?gb2312?B?QXg4OTVFdnoyTG03WkJKMUs1UkRRcndsdFFtSytsRlZmWkxldXFrSXVzdDNN?=
 =?gb2312?B?TURBTVNMdVZvWlZ1R0xYc0ZrZCtEejBOY2REKytUV3RxamJ4SHJrbTUxdmlC?=
 =?gb2312?B?M1hwWXBjSHl4Z2o0R20zYnUzVDFWeXorQmFMbW15YnRWWHJZTElndUErdkZ3?=
 =?gb2312?B?UU1pUTVzZytZcHJpcVNNeGRYSGVYdWJLUVh6SUFFK2I1MndQTWhJNUtNdkhX?=
 =?gb2312?B?bEs3eHRQRzlXeEtxNytHZGZQQkRqNis5Wk1TWHdEelgvSTJ4cHZQZHgxbXpm?=
 =?gb2312?B?NVo4aTB1WitaOW11SzRDTm95d2M2T3FJaGJocENBTXd4bWozN1VJVUlYZnlS?=
 =?gb2312?B?WVVZOUNna2tCMUxlNUFFQUJnKzhzTU1JWnBEZ0lYRjBCYU1tM2UvZ0FzNS80?=
 =?gb2312?B?MTBFK3pDVnFIRHdFVG5hR2xpZFVaQ3J4cVN3cUw5UXRaOGpFajZuVEVNTXk4?=
 =?gb2312?B?aVFSbjFZbkY2VFlKaUkrWjZVdWU3Sm5VYVVma1BUTndmVExJRjB2UlRrWDVa?=
 =?gb2312?B?c0RGekVsbDdZQUFHa09DazVTbnRyWXRLSTIrVjl1UlVjWkk5dnFZQVNhUjB5?=
 =?gb2312?B?L3Vna29NdzhYS2c2UCtzR3I4Vk1ENFNsNHRicUNkSmZleWRvazNRVEJNMmZP?=
 =?gb2312?B?QmNobFhvWmxtV0luOGZxZU5KYmRQeThkZldmQmVQSjBNWnlGcVBMMDBQdWRn?=
 =?gb2312?B?ZWhybnM2cTFIcEhqeHlabVpZUlo1MHZ1TU85SnQrTHNJQWNjNFF1OGw4a0NI?=
 =?gb2312?B?NGIrUjVYSDYxZ09sRHFvMjNVSitZOWxEYlUxRldwelFuS3d5NW1KWUFJR1Fz?=
 =?gb2312?B?VnhGMXNIb2ZqNE5DUFN4ajRMdSs2YTNiTitwbWh2V1NCakFRSzFiNW1vVnJ6?=
 =?gb2312?B?RE5hTzFlYjFCbHZhTDQ2Q3E0NnR3MWxGNm1FalpsTXJhVnZlRk1sS0ZDSWVh?=
 =?gb2312?B?SGdKSCtDYTBBMnl2d1djTHdzdjd5SXR1R3g5SW1JZDZldWVRZytWbllNbWR0?=
 =?gb2312?B?c3AxbU1wMlh4UmdSWmNSTWQvbkpmSXlEdW91SDNjSVdEZnRUZk0vL3ZFMFIz?=
 =?gb2312?B?VU9mVTVVRm5nZjV1Q0drQzdORkxuMWNGSFpZdHdTOS9hVUt1cmx2N3U3eXI3?=
 =?gb2312?B?K2lVYlBJUXdUVlhZUFNmaXVGc0drYk9mUUN3MUpVcUlSbm40OFppMUtVMFBj?=
 =?gb2312?B?ZERrWjN3aEF2a1JWazhmWXh4dkQ0QndRWkhINzJiY25pbkF0emI4M2JVNDFs?=
 =?gb2312?B?NXpoTlRSMFNyd1VpU1BrdFF4TXpJcmxVVlI5ZmVKa2JsNVpZMDIyc3JNdnVn?=
 =?gb2312?B?Z1R0WVM5U29MbEZJdkpWa1VmeFpJZGJmUjErcDF0OFYzUk9ScFVMc3lYMlZE?=
 =?gb2312?B?U1hPVjgzY0trMnJ3WVJnVFUrVXJUa2JkODFCblNvcStOeWNkYmJqQ0VoQlNM?=
 =?gb2312?B?QzFRSi9XN21lcnRQZnlxTmlQVnhhUVhSQ1BNQjNtSlozWCtsV1JKMGpLRDhJ?=
 =?gb2312?B?REI5YmRWSjk2bVpPcVFwUFNhNUI5UktQK1dXNjh6ZGJUa3gvVDU4eFNTN1kz?=
 =?gb2312?B?NVBjSzVkNSttM2tSQXFvZ0lqU2NuZVNyUkR4eGJIZFBobHhCUDM2RTFjOStE?=
 =?gb2312?Q?UnrNEAHVrZaJGcQvvnc0BSW2f?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e586dc-6a7e-4df9-14a4-08dacb678669
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:24:32.3138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFONf3byP8zLUTIaRTkyYDzZJ5OBYqN8ZEDrSIXdkoEg162lRpgvjR9nvNUghq6e7Hcc3wEmt/7rrxgoyPQ+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9709
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMsTqMTHUwjE4yNUgMTk6MDINCj4gVG86IEhv
bmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBNYXJjZWwgWmlzd2lsZXINCj4gPG1h
cmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47IG1hcmV4QGRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdv
cmtzLmNvbTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNv
bTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNv
bTsgcmljaGFyZC5sZWl0bmVyQGxpbnV4LmRldg0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHYyXSBzb2M6IGlteDogaW14OG1wLWJsay1jdHJsOiBBZGQgUENJZSBT
WVNQTEwNCj4gY29uZmlndXJhdGlvbnMNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbSAxOC4xMS4yMDIy
IHVtIDEwOjU2ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQWRkIFBDSWUgU1lTUExM
IGNvbmZpZ3VyYXRpb25zLCB0aHVzIHRoZSBpbnRlcm5hbCBTWVNQTEwgY2FuIGJlIHVzZWQNCj4g
PiBhcyBpLk1YOE1QIFBDSWUgcmVmZXJlbmNlIGNsb2NrLg0KPiA+DQo+ID4gVGhlIGZvbGxvd2lu
ZyBwcm9wZXJ0aWVzIG9mIFBIWSBkdHMgbm9kZSBzaG91bGQgYmUgY2hhbmdlZCBhY2NvcmRpbmds
eS4NCj4gPiAgIC0gU2V0ICdmc2wscmVmY2xrLXBhZC1tb2RlJyBhcyAnPElNWDhfUENJRV9SRUZD
TEtfUEFEX09VVFBVVD4nLg0KPiA+ICAgLSBDaGFuZ2UgJ2Nsb2NrcycgdG8gJzwmY2xrIElNWDhN
UF9DTEtfSFNJT19BWEk+Jy4NCj4gDQo+IFRoaXMgaXMgc3RpbGwgbm90IHdoYXQgSSBtZWFudC4g
VGhlcmUgaXMgbm8gZGlyZWN0IHJlbGF0aW9uIGJldHdlZW4gdGhlIFBDSWUgUEhZDQo+IGRvbWFp
biBiZWluZyBwb3dlcmVkIHVwIGFuZCB0aGUgUENJZSBQTEwgYmVpbmcgbmVlZGVkLiBUaGUgUExM
IHJlYWxseSBvbmx5DQo+IG5lZWRzIHRvIGJlIGFjdGl2ZSB3aGVuIHRoZSByZWZlcmVuY2UgY2xv
Y2sgaXNuJ3Qgc291cmNlZCBleHRlcm5hbGx5LiBTbyB0aGUNCj4gSFNJTyBibGstY3RybCBzaG91
bGQgZXhwb3NlIGEgcHJvcGVyIGNsb2NrIGZvciB0aGUgUExMLiBBcyB0aGUgUExMIGlzIGVmZmVj
dGl2ZWx5DQo+IGZpeGVkIHJhdGUgaXQgc2hvdWxkIGJlIGVub3VnaCB0byBleHBvc2UgZ2V0X3Jh
dGUsIHByZXBhcmUgYW5kIHVucHJlcGFyZSBjbGsNCj4gb3BzLg0KPiANCj4gVGhlIFBIWSBzaG91
bGQgdGhlbiBwb2ludCBhdCB0aGUgYmxrLWN0cmwgYXMgdGhlIHJlZmVyZW5jZSBjbG9jayBzb3Vy
Y2UuDQpIaSBMdWNhczoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NClVuZGVyc3RhbmQgd2hh
dCdyZSB5b3VyIG1lYW5zLg0KQ2FuIHlvdSBoZWxwIHRvIHByb3ZpZGUgc29tZSBzcGVjaWZpYyBw
c2V1ZG8gZXhhbXBsZSBjb2RlcyB0byBsZXQgYmxrLWN0cmwNCiBleHBvc2Ugc3VjaCBraW5kIG9m
IGNsb2NrIHRvIFBDSWUgUEhZIG1vZHVsZT8NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
PiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNo
YXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gdjEtPnYyOg0KPiA+
IFJlZmVyIHRvIEx1Y2FzJyBjb21tZW50cywgZG9uJ3QgZXhwb3NlIElNWDhNUF9DTEtfSFNJT19S
T09UIHRvIGR0cw0KPiBub2RlLg0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rp
b24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdGMNCj4gPg0KPiBod29yay5vemxh
YnMub3JnJTJGcHJvamVjdCUyRmxpbnV4LXBjaSUyRnBhdGNoJTJGMTY2NjU5MDE4OS0xMzY0LTEt
Z2kNCj4gdA0KPiA+DQo+IC1zZW5kLWVtYWlsLWhvbmd4aW5nLnpodSU0MG54cC5jb20lMkYmYW1w
O2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLg0KPiB6aHUlDQo+ID4NCj4gNDBueHAuY29tJTdDNGU1
NTkwMzBiMTNkNDA4ZjY2YzEwOGRhYzk1NDYzOTMlN0M2ODZlYTFkM2JjMmI0YzYNCj4gZmE5MmNk
OTkNCj4gPg0KPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYzODA0MzY2MTUzNzcxMDc3MiU3Q1Vua25v
d24lN0NUV0ZwYkdaDQo+IHNiM2Q4ZXlKV0lqbw0KPiA+DQo+IGlNQzR3TGpBd01EQWlMQ0pRSWpv
aVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwDQo+IDAlN0MlDQo+
ID4NCj4gN0MlN0MmYW1wO3NkYXRhPUdONVduek5XMW9jbGg3WkpGVVVLM0I2OFFZQXFSTXc2a1B2
MG9FZ1BtRlkNCj4gJTNEJmFtcDtyZXMNCj4gPiBlcnZlZD0wDQo+ID4NCj4gPiBVc2UgPCZjbGsg
SU1YOE1QX0NMS19IU0lPX0FYST4gYXMgcmVmZXJyZW5jZSBjbG9jayBzb3VyY2Ugd2hlbg0KPiA+
IGludGVybmFsIGNsb2NrIG1vZGUgaXMgdXNlZCBieSBpLk1YOE1QIFBDSWUgbW9kdWxlLg0KPiA+
DQo+ID4gVmVyaWZpZWQgb24gaS5NWDhNUCBFVksgYm9hcmQgd2l0aCByZW1vdmluZyBSMTMxL1Ix
MzIvUjEzNy9SMTM4LCBhbmQNCj4gPiBwb3B1bGF0aW5nIFIxMzUvUjEzNi4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9zb2MvaW14L2lteDhtcC1ibGstY3RybC5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxrLWN0cmwuYw0KPiA+IGIvZHJp
dmVycy9zb2MvaW14L2lteDhtcC1ibGstY3RybC5jDQo+ID4gaW5kZXggMGUzYjZiYTIyZjk0Li41
YWQyMGE4ZWEyNWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvaW14L2lteDhtcC1ibGst
Y3RybC5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvaW14L2lteDhtcC1ibGstY3RybC5jDQo+ID4g
QEAgLTIxLDYgKzIxLDE2IEBADQo+ID4gICNkZWZpbmUgIFVTQl9DTE9DS19NT0RVTEVfRU4JQklU
KDEpDQo+ID4gICNkZWZpbmUgIFBDSUVfUEhZX0FQQl9SU1QJQklUKDQpDQo+ID4gICNkZWZpbmUg
IFBDSUVfUEhZX0lOSVRfUlNUCUJJVCg1KQ0KPiA+ICsjZGVmaW5lIEdQUl9SRUcyCQkweDgNCj4g
PiArI2RlZmluZSAgUF9QTExfTUFTSwkJR0VOTUFTSyg1LCAwKQ0KPiA+ICsjZGVmaW5lICBNX1BM
TF9NQVNLCQlHRU5NQVNLKDE1LCA2KQ0KPiA+ICsjZGVmaW5lICBTX1BMTF9NQVNLCQlHRU5NQVNL
KDE4LCAxNikNCj4gPiArI2RlZmluZSAgUF9QTEwJCQkoMHhjIDw8IDApDQo+ID4gKyNkZWZpbmUg
IE1fUExMCQkJKDB4MzIwIDw8IDYpDQo+ID4gKyNkZWZpbmUgIFNfUExMCQkJKDB4NCA8PCAxNikN
Cj4gPiArI2RlZmluZSBHUFJfUkVHMwkJMHhjDQo+ID4gKyNkZWZpbmUgIFBMTF9DS0UJCUJJVCgx
NykNCj4gPiArI2RlZmluZSAgUExMX1JTVAkJQklUKDMxKQ0KPiA+DQo+ID4gIHN0cnVjdCBpbXg4
bXBfYmxrX2N0cmxfZG9tYWluOw0KPiA+DQo+ID4gQEAgLTg2LDYgKzk2LDE4IEBAIHN0YXRpYyB2
b2lkIGlteDhtcF9oc2lvX2Jsa19jdHJsX3Bvd2VyX29uKHN0cnVjdA0KPiBpbXg4bXBfYmxrX2N0
cmwgKmJjLA0KPiA+ICAJY2FzZSBJTVg4TVBfSFNJT0JMS19QRF9QQ0lFX1BIWToNCj4gPiAgCQly
ZWdtYXBfc2V0X2JpdHMoYmMtPnJlZ21hcCwgR1BSX1JFRzAsDQo+ID4gIAkJCQlQQ0lFX1BIWV9B
UEJfUlNUIHwgUENJRV9QSFlfSU5JVF9SU1QpOw0KPiA+ICsNCj4gPiArCQkvKiBTZXQgdGhlIFBM
TCBjb25maWd1cmF0aW9ucywgUCA9IDEyLCBNID0gODAwLCBTID0gNC4gKi8NCj4gPiArCQlyZWdt
YXBfdXBkYXRlX2JpdHMoYmMtPnJlZ21hcCwgR1BSX1JFRzIsDQo+ID4gKwkJCQkgICBQX1BMTF9N
QVNLIHwgTV9QTExfTUFTSyB8IFNfUExMX01BU0ssDQo+ID4gKwkJCQkgICBQX1BMTCB8IE1fUExM
IHwgU19QTEwpOw0KPiA+ICsJCXVkZWxheSgxKTsNCj4gPiArDQo+ID4gKwkJcmVnbWFwX3VwZGF0
ZV9iaXRzKGJjLT5yZWdtYXAsIEdQUl9SRUczLCBQTExfUlNULCBQTExfUlNUKTsNCj4gPiArCQl1
ZGVsYXkoMTApOw0KPiA+ICsNCj4gPiArCQkvKiBTZXQgMWInMSB0byBwbGxfY2tlIG9mIEdQUl9S
RUczICovDQo+ID4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKGJjLT5yZWdtYXAsIEdQUl9SRUczLCBQ
TExfQ0tFLCBQTExfQ0tFKTsNCj4gPiAgCQlicmVhazsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4gIAkJ
YnJlYWs7DQo+IA0KDQo=
