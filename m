Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4755E98B9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 07:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiIZFSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 01:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiIZFSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 01:18:04 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130052.outbound.protection.outlook.com [40.107.13.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0A2A941;
        Sun, 25 Sep 2022 22:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7YsoB7Uudk8ZXb4fTPT1H4orJdUvC3culupGM9GRwJo/4ETga1/Jr04CRRHflmRBjhZafLNtX5iSf5ORj5QHATfZE9W+Bq4aSeQwnPbIfYzyh5eQB8I/36SANcVX1dGxehvDtmSsXY9PHRSHiN2yi/5nE7mQcbo/K5iKcPwMPDjrqyF8F2s8kJM08OVrp2EawUjQP0/wcVRsTr9Dt2yHp0SGkjVfLv56b20gcJnflrlPz3ZdEZspVvEwX5RJLZXbURDWXuij5hoejfyMbS6E1Xk9U7RqmeOuLwqyP77yVEDLsSVdQtWELOMVYkxRvjLMSOP35Y6IyqRPhLo0zhW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8SoGQ6NwP5aUg6ZR2Vasu/IiQbAtUcq9wc1K4GXVL4=;
 b=d6ELPwRBPkRKZoUxooF16STR5qwYxA+8f7/sFqimuPUsMUdyof+28EcDTYrjSNV2Ni7I5pIqgO7cbbd+OUhqtQVxmch1fhCGNLCXcIHpgxFagJB7H6HcysVktWG/7OldYYlWMOBW7fJ2aTN89xT5mCkTLwKM/BSpv1YvWN9O/8yTi9QMjn7qXmIen8d4BPP+gVE/Z45HGqkKGxiEeIYtER61hnrOG3MWZ9zfSjg0qivKO5qXfWvvmgGD+7flKKaf/h3TkEotUkV7kBMNhZcDDcfam4ItxGQJlMlXlo2rcivME4dBgePKJMco9xufz9vfU9c33fcNatahS9FaDnrHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8SoGQ6NwP5aUg6ZR2Vasu/IiQbAtUcq9wc1K4GXVL4=;
 b=rW+7Io1s2ThYgghlbFti7IcvTm9v0hl/ggg/0wNiMK/WuHHZfIjnByYWid3CAp9LoFdT8Gd0nGQGTVaRcF9ZKyzLWPWjltv0zMrpWkTaqdMe0FJUBtzMzi8UIIfOepM9auWHwVfRFbHvcm/92JzNlw5H1OC1LJpSZFg6dYeh6Q8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 05:17:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::8574:efa7:38c8:3c05%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 05:17:56 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>, "kw@linux.com" <kw@linux.com>,
        Frank Li <frank.li@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/14] Add iMX PCIe EP mode support
Thread-Topic: [PATCH v3 0/14] Add iMX PCIe EP mode support
Thread-Index: AQHYzxVU1WyH3im2akuuETLjJICODK3tCaQAgAQlE1A=
Date:   Mon, 26 Sep 2022 05:17:56 +0000
Message-ID: <AS8PR04MB8676F3FF81487FF00B3C85638C529@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
 <20220923135348.GA1387145@bhelgaas>
In-Reply-To: <20220923135348.GA1387145@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|GV1PR04MB9056:EE_
x-ms-office365-filtering-correlation-id: a886af1c-5c34-4fb3-95ac-08da9f7e78c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqvchIL6g7GG8J20PnforogAU8TmB4WHsZ5lwgTeTQfr40dyOLPB6O47o+2K44Mk8ewXzPF+DdxZyrsslo+PLQGE2XEAAEIzyw6RYs3Kr/u8SdCRb8dSbnUXNCxaxDp2Zj74EhPJA12LD48sL0J5KG5kQh06nTnXJ7xTMAPrccz+XWHovCtkOC8E1nA/xd3oeu6eitti8wyy7f6kXpZKLJ6ULPR5/tn6Fjey8Y57kADyyFYiHMyhmFv+YWx24gzDZrdQukTEqpC6K1boClNrID3pL3MP3vguGObDzlLVhj0SnHIN/gKrH9i+EPTJzLpc2N7ffjuBr65p4JVnzLeB1RFhr0K+qdW4lvdPTHEMzl21ipCaszyGZ9Zw8Wbi0kkGlTkG7dpWU8hSSge82u/BAD2c91p4hcqoig7MXYtO7cki2r4Mjx2AlHWeXhdPTacotFvXLQp/KccAtmSHgpryzpTZnxI68wyITEb0YDjZLk5H9EwLfuOV8wgyG985JM1g9BNDJ3RksvQIq6A7Q1yMl4niCdhlxDmFX9UJl4ZoTi5maBGArZ2riIR+IlRcxx9P5TIHMEI429pWkih1SXF7YUO6OCPCVwaD68YRSn8E1EipRdoT+0N5m3DDA89YqFJVhlL1fLPz6ePQnvvzTeDyqLIokgMTMk3kivGaVoQxOlgCrvFwk7fmYGUobWA3XYgRfsrzlGF+2A5CHM5zhlGDXuFg855c5z+47aUKEj50IB00/X4Mm7eK4tB8ly68CldorVszakYce7Mn45Q3altR8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(54906003)(71200400001)(6916009)(316002)(478600001)(83380400001)(76116006)(66946007)(66556008)(8676002)(4326008)(66476007)(64756008)(66446008)(41300700001)(7696005)(52536014)(6506007)(5660300002)(9686003)(53546011)(7416002)(44832011)(26005)(38070700005)(2906002)(8936002)(33656002)(186003)(122000001)(38100700002)(55016003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d2I3R1kxUEN5QzlraEJtM09OYzR0MGYrYjdMcVVBSFBvYnRidWFQR2dlZlFT?=
 =?gb2312?B?NmF4dXJlUUljdVlVYWpISHlXNkdkWU55VHB4WkJtVjIxVnJxZkZHMTBXY0VR?=
 =?gb2312?B?Zk9WcEYyd2RiQTdnRzA5MFdBK2RmODBFVFJtY1J6VExNRVJicmwzNTNIa3lp?=
 =?gb2312?B?WHJ5dTNiU0JaYXZFNkJ0THZJbWJwOVNqaUk1bmZuYW1yVHN0VEkvQnRHaE44?=
 =?gb2312?B?OHFoMEtrV3FLaTlLYTJ5UnRsMGhDSHViUWsrRTdJd1lkaFhzQUVianQzYlN1?=
 =?gb2312?B?RGE4Ri83ME9sQXhjRXVIZGtlaGdYMncxcHdCRjNzc1RrbVFGK21wZ0llU2JO?=
 =?gb2312?B?Zi9sYVMvdE5hMithSnNFVk5aVnRIWUVjaE93YmRuL0txSFBIUi9nTEN3QnZB?=
 =?gb2312?B?VXVwMnMvVGR5WmJEemRmajNoS2tkRHRaWTdscHBEdytzTUJSUVQ0RXlBV2ha?=
 =?gb2312?B?ODJIOC94WkJVb0RTRFVaNHhqUGo5dXdHdlpmQ21XZG1MSUhwSVp2TUt6WXNZ?=
 =?gb2312?B?blg0c2N4OExLUTVsSEtvM2h2d1B6b0dHU1Rkbi9BbE1wbkJxRldFaFFxTzRD?=
 =?gb2312?B?TC8rSFBqd0l5WURVSVJPVUNnbTIxclliTjdtZ0RMNW9SRHZQMXlkRWR6eURx?=
 =?gb2312?B?RzdUempDTGt4aFc0Uk16TGFjbVdRb2JkYmU0T0k3Z2FHUnJoOHZGRlY2VzA5?=
 =?gb2312?B?ckIreno5MHdVQTRWRXJFK2xiYnFBUnlrOFQxV25RQnFOUmk0NWpEYkhCektF?=
 =?gb2312?B?U2JoTDJVN3NPRDljUUg3ektlcklKTVRuK1NsbHRPTXlTQy9ObllEOVZmNDN6?=
 =?gb2312?B?SWViUzUwWlVETlFBUnBOZzF1Vm5NblhJZ09YQ1pjaWdhdmIraFl1a2hCZ0Nz?=
 =?gb2312?B?ak1lcnJ5NmlycGFnS1Q3ek8xTTNHUDNXc0Q0amNLK1ZjV0c2aGp1bGJTWmI4?=
 =?gb2312?B?TVdCRFJuWkpRUTMxaWtlYmlrZFpGT051aU1JTFhWZ0ZvMmlhTGFIOE9xSnRp?=
 =?gb2312?B?aDRSODNhSGM2L1hkUXZiMGtVT1NKV1hyWWE1S05LbEd5a3l0bVBqNzdmVG81?=
 =?gb2312?B?RE42eUkwemRiQ0x3L1c5MEZ0aHJSdEF3WC80Nnp2VEhPRDJjUjVuQlZ4TkZY?=
 =?gb2312?B?d0dTVGMrYnVYNXgwRW1iNzREYlpnQ3FSVnlYSWJwdkVXUWtwY2lBc290U045?=
 =?gb2312?B?bmNlVEp2aXR2NTliMHFiUUJVRjBVWW1sUmJ3ZkxqclBmb1VsRXRhYkFyS2g3?=
 =?gb2312?B?TzJLeDZ3ZlVsQnBWK2F0S1Y4WkVqMlJFelo3VDJ5WGptWXlNTFhQWVM4dmZq?=
 =?gb2312?B?dGxXZ3lnRjdGL1hJSDJycStzSFI3eEh3c2dBSG9aU2xHeGgrVXRDeURxR1lw?=
 =?gb2312?B?dHNMcnM1VlpQYWRYbkY0dkVoTlRBdEp0M2FxQ3FJYjV5RG9Na1NFbC9uR0dT?=
 =?gb2312?B?a0Vna01HMjRHKzR2c3IxRTZkeStHRDJDeDhyc1pEVCtnS0VHSC9UeXBGblhJ?=
 =?gb2312?B?ZmJycndtTkh3OU1rRjJqZEswT0p1ek9SNnhmL2Y4K29LM3UyaTMwQXFEKzJ3?=
 =?gb2312?B?QW9QMFJYUGxrM1N2bm84Qm1BNnMvcEhnRFhsNzlSRFZ6bURUZU1wR3NIbUEz?=
 =?gb2312?B?RUVzSU1TZUZhaVBqbjlBQkcxTGJWdzRqb2RrL2l3VjQxNG10L1pRa3JsbHFv?=
 =?gb2312?B?SmVVVzRyMGx2dS9LaTZPOEFCYWZKZkNxRzdWaWRxbU1SZ0lVYWk5enZuUjk3?=
 =?gb2312?B?L3BZeUhaUjZpUDZjSnROVnpZWkNmVXJyS0pwWHZucUhNUFRZdmRYNS9hQ3Fl?=
 =?gb2312?B?emxqeG8vTzArNDZVaG5LMTAwQnVDK2ZKMzNUUVh6YWtYb2lUWXZiSUZuNzhL?=
 =?gb2312?B?WE5Ma1BMOFkvZ2JiWkEwN1F0bjRXZ2lKSUhPUmlQdm5KU2VDNFE1VUI4WFd4?=
 =?gb2312?B?NDFodVFvdEE3OGJMMkJtSEJXSVRjY1BHWUQvL2czcDQ5T3BKQWJzR1ZLVFhT?=
 =?gb2312?B?TzZlUUxaTzBEZUV6aTQ0YUNVSExDREdqbjBKSVVJMUhkN1JGNklXeUxWOXg3?=
 =?gb2312?B?YWliTEpwN3l5WjJDK2hveW04dkIvelh4eXNwaUVPNHQyUVFJQ3VHcUJrOW1J?=
 =?gb2312?Q?6QihwSztl2+aqcinhtRIBTn45?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a886af1c-5c34-4fb3-95ac-08da9f7e78c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 05:17:56.6920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsfKNDn4sQ2MOqjT1jydTjXyXVRWuE26BC6K7oQ+deT11kmRgq51oDZ6iaFLoB8oLSQwNdGn2nCV6+EsY7BA1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jnUwjIzyNUgMjE6NTQNCj4gVG86IEhvbmd4
aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxvcmVuem8u
cGllcmFsaXNpQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IGtpc2hvbkB0aS5jb207DQo+
IGt3QGxpbnV4LmNvbTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtl
cm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC8xNF0gQWRkIGlNWCBQQ0llIEVQIG1vZGUg
c3VwcG9ydA0KPiANCj4gT24gRnJpLCBTZXAgMjMsIDIwMjIgYXQgMDI6MDY6NDZQTSArMDgwMCwg
UmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gaS5NWCBQQ0llIGNvbnRyb2xsZXIgaXMgb25lIGR1YWwg
bW9kZSBQQ0llIGNvbnRyb2xsZXIsIGFuZCBjYW4gd29yaw0KPiA+IGVpdGhlciBhcyBSQyBvciBF
UC4NCj4gPiBUaGlzIHNlcmllcyBhZGQgdGhlIGkuTVggUENJZSBFUCBtb2RlIHN1cHBvcnQuIEFu
ZCBoYWQgYmVlbiB2ZXJpZmllZA0KPiA+IG9uIGkuTVg4TVEgRVZLLCBpLk1YOE1NIEVWSyBhbmQg
aS5NWDhNUCBFVksgYm9hcmRzLg0KPiA+IEluIHRoZSB2ZXJpZmljYXRpb24sIG9uZSBFVksgYm9h
cmQgdXNlZCBhcyBSQywgdGhlIG90aGVyIG9uZSB1c2VkIGFzIEVQLg0KPiA+IFVzZSB0aGUgY3Jv
c3MgVFgvUlggZGlmZmVyZW50aWFsIGNhYmxlIGNvbm5lY3QgdGhlIHR3byBQQ0llIHBvcnRzIG9m
DQo+ID4gdGhlc2UgdHdvIEVWSyBib2FyZHMuDQo+ID4NCj4gPiArLS0tLS0tLS0tLS0rICAgICAg
ICAgICAgICAgICstLS0tLS0tLS0tLS0rDQo+ID4gfCAgIFBDSWUgVFggfDwtLS0tLS0tLS0tLS0t
LT58UENJZSBSWCAgICAgfA0KPiA+IHwgICAgICAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgIHwNCj4gPiB8RVZLIEJvYXJkICB8ICAgICAgICAgICAgICAgIHxFVksgQm9hcmQgICB8
DQo+ID4gfCAgICAgICAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgfA0KPiA+IHwg
ICBQQ0llIFJYIHw8LS0tLS0tLS0tLS0tLS0+fFBDSWUgVFggICAgIHwNCj4gPiArLS0tLS0tLS0t
LS0rICAgICAgICAgICAgICAgICstLS0tLS0tLS0tLS0rDQo+ID4NCj4gPiBNYWluIGNoYW5nZXMg
ZnJvbSB2MiAtPiB2MzoNCj4gPiAtIEFkZCB0aGUgaS5NWDhNUCBQQ0llIEVQIHN1cHBvcnQsIGFu
ZCB2ZXJpZmllZCBvbiBpLk1YOE1QIEVWSyBib2FyZC4NCj4gPiAtIFJlYmFzZSB0byBsYXRlc3Qg
cGNpL25leHQgYnJhbmNoKHRhZzogdjYuMC1yYzEgcGx1cyBzb21lIFBDSWUgY2hhbmdlcykuDQo+
IA0KPiBUaGlzIGRvZXNuJ3QgYXBwbHkgY2xlYW5seSBvbiBlaXRoZXIgdjYuMC1yYzEgb3IgbXkg
Im5leHQiIGJyYW5jaC4NCj4gSXQncyBiZXN0IHRvIGJhc2UgeW91ciBicmFuY2ggb24gbXkgIm1h
aW4iIGJyYW5jaCAoY3VycmVudGx5IHY2LjAtcmMxKSBiZWNhdXNlDQo+IHRoYXQncyBhbiB1bmFt
YmlndW91cyBiYXNlIHRoYXQgcmVtYWlucyBzdGFibGUgZm9yIHRoZSBlbnRpcmUgY3ljbGUuDQo+
IA0KPiBJZiB5b3VyIHNlcmllcyBhY3R1YWxseSAqZGVwZW5kcyogb24gc29tZXRoaW5nIHRoYXQn
cyBhbHJlYWR5IGJlZW4gbWVyZ2VkLA0KPiBzcGVjaWZ5IHRoYXQgYW5kIGluY2x1ZGUgdGhlIFNI
QTEgKG5vdCBqdXN0IHNvbWV0aGluZyB2YWd1ZSBsaWtlICJsYXRlc3QNCj4gcGNpL25leHQiIG9y
ICJ2Ni4wLXJjMSBwbHVzIHNvbWUgUENJZSBjaGFuZ2VzIikgc28gd2UgY2FuIGZpZ3VyZSBvdXQg
aG93IHRvDQo+IGhhbmRsZSBpdC4NClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpZZXMsIHNvbWUg
aS5NWDhNUCBQQ0llIHN1cHBvcnQgcGF0Y2hlcyBhcmUgcmVxdWlyZWQsIHNpbmNlIHRoZSBpLk1Y
OE1QDQpQQ0llIEVQIGlzIG5ldyBhZGRlZCBpbiB0aGUgdjMgc2VyaWVzLg0KV291bGQgcG9zdCB0
aGVtIGxhdGVyLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IEJqb3JuDQo=
