Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7A55443B3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 08:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiFIGTD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 02:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbiFIGTB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 02:19:01 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AF1217889;
        Wed,  8 Jun 2022 23:19:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/PXRnD13JJyPpPNUS8HWrMD39TBxefSyVKqE56NxZQ29HMH/AgZ/6FRp+L0LQEZViWGAoDYDp+5oVDCQ4KzAv0CIsrbHTQoHcoHG3OOIDfPW1DUhbk87SiadPXEwCWGVwGtRrwCaVD65rtveAWDklsTp9VqwaM3SZTbuprsTqfUzGwFQ+2IsDaXQqdn0ioKLA/U7tpT0wm3w1VhgQhztyhHfWKzNwjCq2iBBxOP8hqEITdIeOTZKO3l5F2ppGzm5MHa5ZQCWkbbBgBHjNt9s4dNWFQUXvXokckzc/Sd3UiLFCfQKefoHOnQ9YiZWcwibw1BLZeE/fr4/aVNXoYJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Lt+GA4K3mitgv6Ysv3Mma5wODftxCSjW/9qTo5yxZE=;
 b=nvNPau+lwn5Uq4FLuGGGq+1I0zmFx2ig+mISs04UVEV3ISCd0oXDkmzjbQDe0yB0tjhW/Y4ZPiVp0Ifh8MelssSakqG7bowKTThxeNX0uVOuvspPDcaMoExf3MgQPZrsv6fTY2YqN6lKZWiNDx3qoqo3/hsaPHty8cHkA3CsEqcblRmnciN3Pw8iiEcQ0uOriHmFC5VJQl4cByCbQhEK3H7+FHtaov+zlOsv4JFk3s4OJLvQyrqWdJauhL1HlVo8Zl0nNrvf0v5Wr36bJn/2/k/IRhlsK+hYVKSAg7CUm1PpQzvy811JHbMQ5hmKZG/CIoTSToIcRbFWMoRFnEXTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Lt+GA4K3mitgv6Ysv3Mma5wODftxCSjW/9qTo5yxZE=;
 b=dHtlw6lM4eiRX872TaionFQTBcxQx6wtXGTD9q4vpwfEwbQri9TQaMTvCqiVrJlo0tsxbwPEExyQGdGq8qPLo69g2BSQoorU3VKgbEIGUdVdIgTdu6gPPxAFRfg+XUUlR982cMTE6CQFlGHGxgvUyobAPpbwJGCoWQ3lmkwVf0g=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7888.eurprd04.prod.outlook.com (2603:10a6:102:b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 06:18:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::983c:b5ce:91b1:447e%9]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 06:18:58 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCH v9 1/8] PCI: imx6: Encapsulate the clock enable into one
 standalone function
Thread-Topic: [PATCH v9 1/8] PCI: imx6: Encapsulate the clock enable into one
 standalone function
Thread-Index: AQHYYOzdzR9XFEvzm0OnpPToWVGEMq1GD8UAgACFTkA=
Date:   Thu, 9 Jun 2022 06:18:58 +0000
Message-ID: <AS8PR04MB8676AB0F1EB109B3EDC87E818CA79@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1651801629-30223-2-git-send-email-hongxing.zhu@nxp.com>
 <20220608185150.GA410588@bhelgaas>
In-Reply-To: <20220608185150.GA410588@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7fa9c35-a7fd-4798-9025-08da49dff052
x-ms-traffictypediagnostic: PA4PR04MB7888:EE_
x-microsoft-antispam-prvs: <PA4PR04MB788864A99BD32556268535C98CA79@PA4PR04MB7888.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UWrj53T8kP5MJ1Qbq9k50iqXJu71A5BvBOU7deISnbGlfgqOTbwJ7m1br4xuynepMh9JOcP28oyuvp4SBoUmapykatsfanP/yHD6AmM333l/2JeZDQb9tMyLjBWx9EswoFc4IgcMA4Elv1Pu8IWHe4+aWHD1aT3Oyqv3F2Ujv4JyyrnefywlD9Q7Zk83CjOH0QLtewW7LYiAtcuAnPQPYqRpR2C2ONHU1sTRbBwj3ju5yzvlaDu0G4xwP6yYGISZOSPUXgojYPfMEsAd9v3yr5E/u6+DUaom00hMiqQo/e8qzsP5uBs2Ecw4ymsMSjME1E8kLx9JUtREgGZsUIS3QB+edEUWp9wsjkCU7iMwVEF4dELhSsOO26kS5JAV2nIJumwbcArpUDfFrlF08Be1b6BvvGss2rsBDAhBfbs1JGF/YYB9gMY2mLvfKbFFbkD6uQceL+YaWsmJu8H2SXiK97xpf4AKNsyGYwdB24y3yiqMJK7nEhzdWnFMYFZyP4E7AkIGTC5dli8Un9OjWBIk2taS4BEmVTwu5UlD19FBxsiS2FPlMDrzRjwIR1S9zyFM4Ssg9O0CueHRwte2wLkjTnn71HQKao/xUgnzQCtJnz+XqtzUL8dYsh4c4qT4ndx79XqXBucBj3HzNrWTdTCjZkOMwQWtJ7KGAWEKIHjFRh0ZKGckR2eJksFP2rlCBjvdXIbj2NvHWd/NC8d54P4dUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(33656002)(316002)(38100700002)(4326008)(8676002)(122000001)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(54906003)(6916009)(71200400001)(44832011)(186003)(83380400001)(4744005)(53546011)(7696005)(2906002)(6506007)(7416002)(9686003)(26005)(508600001)(52536014)(55016003)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RXg2ZjY0VTJlbHBBbTlqZmdwMVBnYi9LcHdMYmxtV2VPczJCUTdiODNXakNs?=
 =?gb2312?B?dXlQRXZMS2tXTFJIL2IwbWk1WUowVUZIUlhGbUxZMTU5SWhHdEIxMnptOWJa?=
 =?gb2312?B?RFhIQkt2U3RkQU54ZHJHTlUrSzZ0UEtnalZ1ZmUzZTZFTEtKc3N4MDlLM0Zq?=
 =?gb2312?B?Uit3cTJEQVBBYWl6eUIyVFJQL2hocFBYOVNlV3kxeWdnU3dsakRHTmdCYVhK?=
 =?gb2312?B?U1JUZUgxRGFKUytKUUJ6T2ZZUHd6bVdOcGhZUXp1bzc1K0NuOFZoZnRTR0ph?=
 =?gb2312?B?WUFTUWxDRGx5bldJS1JMaWY1V3E4NDdiWkdYU0lKTGxlbE9QMVMyaSttQUZ5?=
 =?gb2312?B?N3I4NS9QczcxVGVZU2d2YjdWbERXR0lhcWU1V1JBWHhSeWZJdzJIa0hUTU51?=
 =?gb2312?B?bTF0aDRaY2FBNFh6MjJFcDJyMEh1cyszOTdZVTI5Tmt0ZnFaMFdSQWNMQUNR?=
 =?gb2312?B?QjVSekNFZ2VIdXhwWXdob2c2NE9oR25BVmZabWR5aTMwYkE5ZmJHMHV3a0V6?=
 =?gb2312?B?MGJSelJCWTVaV0pyQU1jOFlBam5obFdJWVdDMllEL2RkYzRMbldwakUyK1FH?=
 =?gb2312?B?NFRQRHI0QnFyVU9Mbzc0dVFBQ1ZHTFpEbG1nQWFicEovVzNDT2h1RWNubFU4?=
 =?gb2312?B?MjM4TVIxZkxrdEE3ZHpPU1NtZU8xM2F6MW1oYklrUy9SUEdjSjdVWTJBcVR3?=
 =?gb2312?B?QUZzSXlyVVhUZFpVSDd3OUE2T3M5cHZvb2ZjWGFLUFlQc3lwUHkvU3hlZjVK?=
 =?gb2312?B?UkdYb0I1UWVxR05mL3pSWG82TGIvT0x2MHh1ZHlXLzA1YndSbStOVzN1YXlw?=
 =?gb2312?B?cjJFaUlFRkV2RTAyTGlDZ3NEcVNSaGZHcTBrWGxMUDJUV3pEdHgvQmlpSERh?=
 =?gb2312?B?ZFQ3cU5MOXBseFQ3YnNNcFMwbjBTYUlyQkpYek1iNHROK2lrZXhyUFBMZjRl?=
 =?gb2312?B?MmkydGxLOEFjLzhBNFJpVjZsUytkWFVVb2xPWHBoNHFIeDBwT0g2MitGWWNN?=
 =?gb2312?B?K2s0VGhmbG9Xd0hHdEQreTRyaFR2ZGxVTjNVQzNkRGppQm9lTWx0YlJ0cDBH?=
 =?gb2312?B?c0R4RnBXZnFqQk5mYWQ0SklxSlhVTG1xWk4zeFUrRUE5ZUpZRTdkR1VzK2NM?=
 =?gb2312?B?SDZ0a2U3ZHFQbGNUQnp0WkF1MWVrSEZpQVI2MEltOXBpTk50bUxWd3pCNWF6?=
 =?gb2312?B?Q2w2T2J4YlhMNkdLS3RxbTVWMlB4QXl6SnJpbEFpSnQ3L3Arbm1oSmFqaHE5?=
 =?gb2312?B?K0tRdy8rRUpVWnI2ellVTW9Md2FSUGJDT0tJVXJZell2dFZqKzlHbzN1eGZv?=
 =?gb2312?B?K3hNZ3FjZTRxUGxQYU82ckJNN1V4ZTJ1RVRGOTZxR1FqVm1hVjBTV29WOGda?=
 =?gb2312?B?Q0szUWZsOXRCdmdSemRpeHRZbTE5L0R5TmoyU0ovYWpRREZySHlhc2w4ME5J?=
 =?gb2312?B?RlhGWkdHWGQyVUI3cVhRWEZWc1g1d3FkdzlOSUYwaW84aFJDY1RUUm1Sb3N5?=
 =?gb2312?B?eGN1UzJ1TXF3c01aR01xdTNUOUJtRlRYNlYxdEVGb2tVVmtVb3JINTJCVTZK?=
 =?gb2312?B?eXAxZ0wyTWdpa3VkWW1iUzBqa0J6QnovNVZzdEFMZXpuR3dMSTh5TURBcjRJ?=
 =?gb2312?B?S2J0VnMya05ZVTNhZjAwa1piS2FUZExwZG12QWJUWWIrcGczS0tPb1RUdGZZ?=
 =?gb2312?B?SEFKNGRlT3BhQThLNjlzS1BnYmhSSVEwSGZhRGR1YWtKRzN0bXVpTGdwNnFa?=
 =?gb2312?B?YWtLYldHekxYbm0zR3JNc1hmZXFrRWRWOE1MY3ZXTEZGaGl1VVIweEs5Q3RL?=
 =?gb2312?B?YkZNRlYvV1h0Z2FSbTZEdXBXRi94eXQ2Y1JZdWNqYUE1MFpVUTQ3MWF2Znox?=
 =?gb2312?B?Y29PdnFwUGtXNnQ0WE83SVVjcnFxUlJvczRBU2JzbGN1UWtLNHAyVzhIVkNU?=
 =?gb2312?B?QkRWbWg5SXJHdU1mVkVXdElZNVByREIvNzJsMG5HdWhUWWcvSmZQeTdMSWdo?=
 =?gb2312?B?dFRlNHZ6dlUyTS8vSzBVWkJUTGx2K1ZObVM1YmZDTkhibUF4Mzc1SGozeFp1?=
 =?gb2312?B?R0NZajdzaTFOV1NjTVJMYUNIa2l4UTRKRlNDUGp5ekpJVjV4VU0zWXRocEY1?=
 =?gb2312?B?cHloUC81bzhSRGZDS1FSSTRXancxUzBUWGFmd0tKNTF4YWw2TE5vcU10TTlF?=
 =?gb2312?B?UDR5bDFuT09KMSttNkd4QnJKdEsrZ1NxTWdPRXNPOTl2bVZaTWsvdjVNM3Ni?=
 =?gb2312?B?Mm0zTURsZlluUFFCb3AvQktaNC9qYW9YT2p2MUJwWEVkVXNiUStRMEEvazZn?=
 =?gb2312?B?TnFSbGxReU5tNkdNQTNXOUFMRVR3M3B2UlRydGVkRTRCVTA5b2kxQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fa9c35-a7fd-4798-9025-08da49dff052
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 06:18:58.4667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/PdNFZ9KfO+zbWZWHSpPikxA+VuLt9JgpMXlDbNW2P6oair8yRaqcQuQlONNTbBYbdN59vkmHR7ZeekRoKB2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjnI1SAyOjUyDQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogbC5zdGFjaEBwZW5ndXRyb25peC5k
ZTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBicm9vbmllQGtl
cm5lbC5vcmc7IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29t
Ow0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOw0K
PiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2OSAxLzhdIFBDSTogaW14NjogRW5jYXBzdWxhdGUgdGhlIGNsb2NrIGVuYWJs
ZSBpbnRvIG9uZQ0KPiBzdGFuZGFsb25lIGZ1bmN0aW9uDQo+IA0KPiBPbiBGcmksIE1heSAwNiwg
MjAyMiBhdCAwOTo0NzowMkFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBObyBmdW5j
dGlvbiBjaGFuZ2VzLCBqdXN0IGVuY2Fwc3VsYXRlIHRoZSBpLk1YIFBDSWUgY2xvY2tzIGVuYWJs
ZQ0KPiA+IG9wZXJhdGlvbnMgaW50byBvbmUgc3RhbmRhbG9uZSBmdW5jdGlvbg0KPiANCj4gU2lu
Y2UgdGhlcmUncyBhbm90aGVyIHJldiBjb21pbmcgZm9yIG90aGVyIHJlYXNvbnMsIG1heWJlIG1l
bnRpb24gdGhlIG5hbWUNCj4gb2YgdGhlICJvbmUgc3RhbmRhbG9uZSBmdW5jdGlvbi4iDQo+IA0K
PiBzL2Nsb2NrcyBlbmFibGUvY2xvY2sgZW5hYmxlLyBhYm92ZQ0KT2theSwgdGhhbmtzLg0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCg==
