Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD1A4B6317
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 06:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiBOFup (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 00:50:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiBOFui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 00:50:38 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1880209;
        Mon, 14 Feb 2022 21:50:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWokhGZg+JvAHsEX38ckbHPiOFwDVfu/iLXqZHOjEt2zxnrhM+yklUWI/1LoIwLo/0FGZJfU17FWt+EWlK1W//P0SyglQN1MAw8CJWIF7FG1RHPn/X/aBYnWk6fAc/DAoU4wKSopyKOuRDM/VvkYveaB3yo9IHQUQEndILSrmCBtp4rsAvkoO45UAiY1aWx/rf0S1zbaTedGlmXtwruwXHKtSQnLJK8eJKTRvkEp+kdyB4J4KTlsedRZlkt6pQYn8L4aGswBU+ZrK1Hbj45VoO/0GVRZ3HCUs/JguzHSn1VWUzt+jpBwX+I7I5GpuY9EAipUmw1GSQryYycH/NL7Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkdYSzIU+JdcNN+23z7fgnKmO5vJ0G+LqnedAAXZYpA=;
 b=e4En8wZ0c3bXuKtGMIU/feJ0ZJGi7YmbT9ijtJttlkROrYyWyGUzh4/OhRJXMjZVcGJSHHND5oM4l3rGGpVL6AIGc+ho07a58WyNbs/9Cg0O9q7D31nUZMWCD11cYQXJuddL2yEUsfRtku3B4ZCEISyAtCsclRZCTwChKzfAMIxFUx+Ob8CsoyhKEBt9zk+QJL8W/jyv4mqB95a1NveIBC2HE8gqhR+RFe2OPMmNPouJPoMaMbEhI/qPRG+4jtMatmaC/0CJ67xlsNAuLD0FWX9bSSm+wA8IPP6jylGYXhpui3pcdMlJK9zyhxw/HhljiP2FGXj55KqJEv+wQgQmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkdYSzIU+JdcNN+23z7fgnKmO5vJ0G+LqnedAAXZYpA=;
 b=Q2bf7YXcBHHktQtqFRw7EWw9UqitjSMTL9aup9z7iw9x/FMPIw5HNk2wiWTFblOTDh3+nopdrjwvpfBTwAp+XiDeMz3OUQXZBtjM+rkcS+s63sS4fDmrhh7L8/t5WOmLIcIOWdXpAURVVdpg//3OPkUmreIpL2wEJ1NASHzH4JA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB6152.eurprd04.prod.outlook.com (2603:10a6:20b:b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 15 Feb
 2022 05:50:25 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%7]) with mapi id 15.20.4975.018; Tue, 15 Feb 2022
 05:50:25 +0000
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
Thread-Index: AQHYHx4Al/jcwVa94ECJzobIRwmI7ayQ5wwAgAFbLQCAAd7bUA==
Date:   Tue, 15 Feb 2022 05:50:25 +0000
Message-ID: <AS8PR04MB86768072C3451DDC099624CD8C349@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644564779-8448-1-git-send-email-hongxing.zhu@nxp.com>
 <20220213043143.GN4909@dragon>
 <AS8PR04MB86766395B896FB1F398B81718C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86766395B896FB1F398B81718C339@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e57b2eee-08b3-4a3d-b1f0-08d9f0471057
x-ms-traffictypediagnostic: AM6PR04MB6152:EE_
x-microsoft-antispam-prvs: <AM6PR04MB615264F55EB4701546C3F7F78C349@AM6PR04MB6152.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KkSVyPC490/nZDjww3p2fSIkTnb+MO6nFpPyxQjeHesONIUMwZML/Knc0M9B4bUbfFhAwp5dmA/vBEwwrrr3cbqVKJ/8DpfDidRKi5Z6TIvU62cTx1Hyt3gcGANqi6aQZp5bRwPcYkTFDQRBE25XB7H5+7yDzNoXPS6E4aQce7onU6VIkxd9eW3QD7Y5dNGBNffE4CiB01gDgnnpd0oYMDGSuh9Y3QUIgNlRLezS6dlvSO8sK83ODVdGao8JW1HlHQO5s/U39wMOBRrqfa3TGCBvGPxXFqaEU+x1E0kq6gjbV9Zgp3ZatCdKWAjo/bYjG7KqwDC9duGUUf8CUgYHaKIvEnCSGK3ShPYEFl0poTkXrLglI/JzHafmoOwxVVKVUIre6tHvpO/8gto/dEuFWaJzX59cm4H079J6m1DfqrkbtjXTyrlB1zvGFS7+aFb+becZ1rdx7JWfMWRdklygASVKDlJSRy7c+pe/ZQYa+rZsPXrF+tXl7Vef6FNA0yZ6YGFZcjVaPkFtXOk5t1nkUT7JGic76NYh0Gh3CsEtQFRLpvtd2GTw2BBJCVJREhp1DMQhdQXRUFtCrk6R8YPZgGh4wZDU4yWDKktEgWY+vA1SDXZuFl7EQLCFpA6BYDGk7DTSvQIlhYpU6e6kaXS+9jzl2J5aMCkoFo94zceLWE2g3konQd+k0xdHgn+hjqZJhVrqwirnvRyl0llHh3Rhh2hJa3oUy+uTCy5SUT9qKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(5660300002)(83380400001)(38100700002)(33656002)(52536014)(122000001)(316002)(6916009)(54906003)(186003)(26005)(64756008)(66556008)(66946007)(66446008)(66476007)(76116006)(53546011)(71200400001)(8936002)(9686003)(8676002)(86362001)(55016003)(4326008)(6506007)(38070700005)(2906002)(7696005)(508600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MmVGRkVhMEFtL24xSm9lc2VVRWxNVXExVkVoci9GZVAvTFE0ZE41TzFsOXFZ?=
 =?gb2312?B?YWFUR2ZGdVNVc1VWeWozd3pTZmVKZ01OYWJOS1ZXWmoxRzJIK3JwZlRaclg2?=
 =?gb2312?B?bVU4QytlQTg2L0E0eDhyTGdwbTR0cGVMemZQYjRFckkxMEgrYWZRTVRESnc5?=
 =?gb2312?B?cXNxN3h5L3dYQ0M1Zk5CYm1VZ09ZVXBDNEx6TkNveWo2YUVOQUpnVUUxcm4x?=
 =?gb2312?B?SU5YOUdjdnNVeG1hUkhpV0t2anJyY2lJWjJkdGNPT0F4bWw3S1NySjg5eGZp?=
 =?gb2312?B?bmlzWDNkTEhsaUJ6cWhvRjcrbDRJMWUyOHZpSHhlRVdqTzNJZzZJd295aWVs?=
 =?gb2312?B?d3FiTDFOK2FPMS93NjgwcFdTRlpnQUx3RklPcWcybHBpZitaQ1lCVGhKYmFC?=
 =?gb2312?B?WXI5QVg1bGxubHNQWGpxU3BvMTBEUDRxRGh0cTBrU3laWmVKRlJBWU5QdzFl?=
 =?gb2312?B?bStmVUZ1bU1VRklXTmxoSnI5MHVqVEJJQlRPK1lrTDRsSGFEMGxnSklYS3lV?=
 =?gb2312?B?MVBRdjBTeEZYUVRKeml4SndKNkUrSEszbWlMZ25xWHR1c1k1aDZyeVJLZDR0?=
 =?gb2312?B?ajdXekt4RnB1VWlHdUt3dndzSzZoczRjczJjZGFRVldjNWJzZE1SZUozYUF5?=
 =?gb2312?B?TCtTVGc2R3plcjZURmVwTlhBaUlKSjRtMTArVVpDVW16MnFkWVhZVjlHM1oz?=
 =?gb2312?B?Y2kxQmFralhidEdKWWJjek1OTTZvR0JXUWZoaHlFeWFNN3J6MlIwV3VSdG5E?=
 =?gb2312?B?L2ppUXRXRjU5aElqV0NFMmVuUy8yNTV2UTV3bUxicWRNeGNzd0h0RUVtWkhH?=
 =?gb2312?B?bzhEdmlQRUJ1OUFEVGpoZ2U1cFE5U0JJWnBEbnE4TVFib0dyTXNrKzJrcHRT?=
 =?gb2312?B?bERNUUtOdGI2S2VvMmJHOFdEWjdRUGpDTVBmdHJuRG9PWjVGbEVJR0xVQXpX?=
 =?gb2312?B?RmVBTXo4VWROUlJ0ODhmaDB3eU53NGhGQ0FhcTRNY2R6Zkl3ZGErSlY2Mi9P?=
 =?gb2312?B?S3JMVFNjS0wxNVhqQ3BsYVNEV2QzWmZDSWxlbnlJQ000c3ptQ2hjWWl5VFlN?=
 =?gb2312?B?RStDVVN6Rk1ZOEtnQXF3elFjRzdMTWZUREcyZHdUU0oyTjJDM3NaQStiWUh6?=
 =?gb2312?B?ZFVMWnlURlJCZmJuc0p3Z0Naci8vNG5oWE1mNjhDaWVTRmxaR2VNeGI1Yk5Q?=
 =?gb2312?B?em1jMlZ6L011UzV5dlRoaXExbHp1Z3lyelUrbUxEWUVUbTlyd2d6YlYzRStV?=
 =?gb2312?B?OHZQT0x2Mk52cDJRMWVJNXhWeGcxZ1dPUURFNVZEc1dFWDJ5dWM1a0tlTnNE?=
 =?gb2312?B?TllWdi9sT0NycytWOTFlZ0V4a1dRR3E0VDYrSXdGb252VUNWTFBxcjZaQUpL?=
 =?gb2312?B?emtWdW9KS1BqSXFDNW0vR1c1cUd3ZFM0TDBLdUZ6dXZ4M2w1QVZTRTJiR3pO?=
 =?gb2312?B?QmZlSTM4UjBFbE02YmlPK2tLcUJadGRjcGtsMUoyOU5GQkN0NHV1Z2FOa0Vz?=
 =?gb2312?B?U2tNVHNpdFhpRkZ4NzkvK3Q1TTJvVk0vTEY3OUJCdjBRTXQvNVFDRXlMWUNH?=
 =?gb2312?B?NnBGMXBjOTd5VUdMS3NXdW9uZmxNRXp0bkU5WWNRbDk4ekFkdHltWW4wejgy?=
 =?gb2312?B?NjJYUWNKUmI2d2dpaVJMTVNBUy9vUE1UYXlKRDZneWJPcHF1aG43UEt6Uzdk?=
 =?gb2312?B?MmN3dUlZUEZNODBDK0N2ZEFlWjJGb0R6U29sV2JvUkNjb0xOQTd5bmxhMnNv?=
 =?gb2312?B?ZW50ZVdnSGx6VjFGTkNuNlNUZTVzV0NrKzFpc3haT2FEWTd3SWFLVWlGRndF?=
 =?gb2312?B?VmFyVGdLVzA3UkNpeEt5czVSYkpzaWdiYVRiYXFITDNMTk1iNmxVbHdiK0dz?=
 =?gb2312?B?bUlVbk81QkUrUEFscEhBdXd6eU5LdFQ0Uy9Gc016QllwOFNEamlZa28wSUxK?=
 =?gb2312?B?WVMwbHkyMmJhNlo4NVc5WkNLYmlrdHZIWGFqV01jZWp4c01ZdXI1ekJ3TWlp?=
 =?gb2312?B?dnMycXJrVXBJaXpnSHlsaituMTNHM0w3NCt4eWZHWG52Y1pDTHY4NlZQajRH?=
 =?gb2312?B?MHVaK0dyTnlrRkFpTG03Q3RweS9OMWRTWGw2NVFvMm13dXl0RTNsT1ZDYlVk?=
 =?gb2312?B?OHI1M2M4UjJNWnRNWFZRdXVDeWFHaVhubWxYOC9SOTREU2kyYVl1aVFVTXJw?=
 =?gb2312?B?WWc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57b2eee-08b3-4a3d-b1f0-08d9f0471057
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 05:50:25.6381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1mWfGmyyi2V56FJZZIbpsjhjsG75QT5FrRo2GwbNLPXIGb0vExxL+DRxJPVY23KMFFi8genzEWK9IUGe3Hh0LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6152
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUNCj4gU2Vu
dDogMjAyMsTqMtTCMTTI1SA5OjE5DQo+IFRvOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+IENjOiBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0K
PiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAxLzJdIEFSTTogZHRzOiBp
bXg2cXAtc2FicmVzZDogRW5hYmxlIFBDSWUgc3VwcG9ydA0KPiANCj4gPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4N
Cj4gPiBTZW50OiAyMDIyxOoy1MIxM8jVIDEyOjMyDQo+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGJoZWxn
YWFzQGdvb2dsZS5jb207DQo+ID4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4ga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjIgMS8yXSBBUk06IGR0czogaW14NnFwLXNhYnJlc2Q6IEVuYWJsZSBQQ0llDQo+ID4g
c3VwcG9ydA0KPiA+DQo+ID4gT24gRnJpLCBGZWIgMTEsIDIwMjIgYXQgMDM6MzI6NThQTSArMDgw
MCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gPiBJbiB0aGUgaS5NWDZRUCBzYWJyZXNkIGJvYXJk
KHNjaC0yODg1NykgZGVzaWduLCBvbmUgZXh0ZXJuYWwNCj4gPiA+IG9zY2lsbGF0b3IgaXMgdXNl
ZCBhcyB0aGUgUENJZSByZWZlcmVuY2UgY2xvY2sgc291cmNlIGJ5IHRoZSBlbmRwb2ludCBkZXZp
Y2UuDQo+ID4gPg0KPiA+ID4gSWYgUkMgdXNlcyB0aGlzIG9zY2lsbGF0b3IgYXMgcmVmZXJlbmNl
IGNsb2NrIHRvbywgUExMNihFTkVUIFBMTCkNCj4gPiA+IHdvdWxkIGhhcyB0byBiZSBpbiBieXBh
c3MgbW9kZSwgYW5kIEVORVQgY2xvY2tzIHdvdWxkIGJlIG1lc3NlZCB1cC4NCj4gPiA+DQo+ID4g
PiBUbyBrZWVwIHRoaW5ncyBzaW1wbGUsIGxldCBSQyB1c2UgdGhlIGludGVybmFsIFBMTCBhcyBy
ZWZlcmVuY2UNCj4gPiA+IGNsb2NrIGFuZCBhbHdheXMgZW5hYmxlIHRoZSBleHRlcm5hbCBvc2Np
bGxhdG9yIGZvciBlbmRwb2ludCBkZXZpY2UNCj4gPiA+IG9uIGkuTVg2UVAgc2FicmVzZCBib2Fy
ZC4NCj4gPiA+DQo+ID4gPiBOT1RFOiBUaGlzIHJlZmVyZW5jZSBjbG9jayBzZXR1cCBpcyB1c2Vk
IHRvIHBhc3MgdGhlIEdFTjIgVFgNCj4gPiA+IGNvbXBsaWFuY2UgdGVzdHMsIGFuZCBpc24ndCBy
ZWNvbW1lbmRlZCBhcyBhIHNldHVwIGluIHRoZSBlbmQtdXNlciBkZXNpZ24uDQo+ID4NCj4gPiBJ
IGRvIG5vdCBxdWl0ZSBmb2xsb3cuICBUaGUgY29tbWl0IGxvZyBpcyBhbGwgdGFsa2luZyBhYm91
dCBleHRlcm5hbA0KPiA+IG9zY2lsbGF0b3IgcmVmZXJlbmNlIGNsb2NrLCB3aGlsZSBjb2RlIGlz
IHBsYXlpbmcgJ3ZnZW4zJyByZWd1bGF0b3IuDQpIaSBTaGF3bjoNCkkgYWRkZWQgdGhlIHZnZW4z
IHVzYWdlIGRlc2NyaXB0aW9uIGluIHRoZSBjb21taXQgbG9nLCBhbmQgaGFzIHNlbnQgb3V0IHRo
ZSB2Mw0KIHNlcmllcy4NClBsZWFzZSBoZWxwIHRvIHRha2UgbG9vayBvbiBpdC4gVGhhbmtzIGlu
IGFkdmFuY2VkLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gSGkgU2hhd246DQo+
IFRoZSB2Z2VuMyBpcyB0aGUgcG93ZXItc3VwcGx5IHVzZWQgdG8gcG93ZXIgdXAgdGhlIGV4dGVy
bmFsIE9TQyBjaXJjdWl0IG9uDQo+IHRoZSBib2FyZC4NCj4gU2V0IHZnZW4yIGFsd2F5cyBvbiB0
byB0b2dnbGUgdGhlIGV4dGVybmFsIE9TQyBhbmQgcHJvdmlkZSB0aGUgUkVGIGNsb2NrICBmb3IN
Cj4gRVAgZGV2aWNlIG9uY2UgdGhlIGJvYXJkIGlzIHBvd2VyZWQgdXAuDQo+IA0KPiBUaGFua3Mu
DQo+IEJlc3QgUmVnYXJkcw0KPiBSaWNoYXJkDQo+ID4NCj4gPiBTaGF3bg0KPiA+DQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzIHwg
OCArKysrKysrLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnFwLXNhYnJlc2QuZHRzDQo+ID4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNk
LmR0cw0KPiA+ID4gaW5kZXggNDgwZTczMTgzZjZiLi4wODNjZjkwYmNhYjUgMTAwNjQ0DQo+ID4g
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cXAtc2FicmVzZC5kdHMNCj4gPiA+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNkLmR0cw0KPiA+ID4gQEAgLTUwLDggKzUw
LDE0IEBAIE1YNlFETF9QQURfU0QzX0RBVDdfX1NEM19EQVRBNw0KPiA+IAkweDE3MDU5DQo+ID4g
PiAgCX07DQo+ID4gPiAgfTsNCj4gPiA+DQo+ID4gPiArJnZnZW4zX3JlZyB7DQo+ID4gPiArCXJl
Z3VsYXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KPiA+ID4gKwlyZWd1bGF0b3ItbWF4
LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiA+ICsJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4g
PiA+ICt9Ow0KPiA+ID4gKw0KPiA+ID4gICZwY2llIHsNCj4gPiA+IC0Jc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4gPiA+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiA+ID4gIH07DQo+ID4gPg0KPiA+ID4g
ICZzYXRhIHsNCj4gPiA+IC0tDQo+ID4gPiAyLjI1LjENCj4gPiA+DQo=
