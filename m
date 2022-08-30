Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B65A59A1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 04:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH3C64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 22:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiH3C6x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 22:58:53 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10069.outbound.protection.outlook.com [40.107.1.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF9A2212;
        Mon, 29 Aug 2022 19:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIH78+wGXmfdkmTMghKpiHj++agGFk+AH4mTWt6FqJvmC5FK3Xz5Bykg/6g6e//scbfZwgz8kHnS8jPfjP1EWN/FbJgJwriJKFzGIM1nnpA+iyJnbPCf98wD7QqwAoE5RM5dCPv4iePVgNbaf/oBcSGgeH4T++YwLATtvqASZtuRIm7cN0PYaQimzlgwMTPprMiKghTiNNmsqIc0qR1h+4f6te03DDGvkhZarQrFRwER0YL/pguCn5OTLZGQwuEtgS+Gc/ZVYFhlAAFh0Uo3LfroRrOsWgeUyXoZEPG8004mW+nStG4hsJovdXZaR06J2fPWfWNyhEfRjpGUmJv45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6Vl5AtXoo0+5PtRUIFAb6icVGa5ZXI2EpLpjH2PP9w=;
 b=LP9yAq7TPScQD5ed+iomTZtgWsOU1Pl5JlLbm/6zWXqlnOz4tV03oVUNJgYmExJ5P0s7Idda4TGzmdkPtJTsbKgbYNCl1PoDz8Anvz7mKMPhew4Oaj0ufQIvyn+naCoqTB8fZPFlTP7oe7fWIAUF5o3yy0zjHRreI9sEgv29LD1mcFTzvzQWr9cjTE5dJDyAdxDMwDGwA1pPjdRchvMD8M/DGBnk1bQ8BEAXk34JUc5l7l9opkPgtilaIbsQGBZCqhZ+z0dRRrO2MVL5SkJ//7udO79664hOU2Jia5xi5VIwyOdb3cMTpXsls+bxXUzATExToOnrJ9RyLHGLSSi7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6Vl5AtXoo0+5PtRUIFAb6icVGa5ZXI2EpLpjH2PP9w=;
 b=r50Mu+brhWjTJuQ6+WE/HFPklb4XevMcVQjW6y+3vgGCVfD39ZuMj0ZwTtaWlq9qpF9mUPc3kl9SbLcc8BPaZwiER3wIeg7pggKWYmn4btz8HG7Y5dDu8JNqT9/yDPPU6Mt4rPMbmcKkWEZnLjCiy5L3Ft8RqFvGGhDkohn7lIA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7380.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 02:58:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 02:58:44 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v4 0/6] Add iMX8MP PCIe support
Thread-Topic: [PATCH v4 0/6] Add iMX8MP PCIe support
Thread-Index: AQHYu4Hu08U8y45hSEKj6wR6lhsy2a3F/qWAgAC8HYA=
Date:   Tue, 30 Aug 2022 02:58:44 +0000
Message-ID: <AS8PR04MB867602341382CB5D63379DC88C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661760917-9558-1-git-send-email-hongxing.zhu@nxp.com>
 <c668fff254b9f56b699a2714bb8c016e3b0cc5b5.camel@pengutronix.de>
In-Reply-To: <c668fff254b9f56b699a2714bb8c016e3b0cc5b5.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49516518-0c1d-4a82-4de3-08da8a338d7f
x-ms-traffictypediagnostic: AM8PR04MB7380:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnenWlzkW6YEIisih79YsCNp6juF0wJh9YUaUZ52qwecdwmDvz1EGGQtRBUNQzMW+A3n+0GMzGQ8Jj7MDZGBJgsbq23JbtOzOU/vcUC3gUxsu4+vsJSnuKBRPNWB0diOyvAtl4mTctuah4r8IFTwuBoNV8MDR42PZPnix1zNoR7qOz6p5ilqtImHagAnJdxbB5ju39Uq2pJZvkGIHNkjz2eQSAUZY5PY7pfZQQiFCEI/OOp0PXfjmU0tuqk5i4GGGvSBZdgiBAGRDIHtEmqnmCp+MrtWdr5kZx/7EfGesiIq09cZHrnVFd732MhUvZH0g9+c9rswhEAcJmz5tqe36WoucH8d1uFT7zJhiF8Eahp3bXx4nXe/mCrLRI3oJiTHX6rJj6S5WrLlYlt7KUyh0+ESVh3GmRM/w0Z4P/zkRbvwc2U5m2j5QKTLIDIrDtSfj67FR1uiNbCL22Z4XLCrL07OvrRQeTPadPfYXYWA/u2LyHcQLWu6VSHbceOm+f1GszmC2hyqXb2HHe2ukbqJl2XO4K0DSxEmIfl0rZ2uBz2fEXqYeN3jflJjGXRK3jdL/zKcSNcAxUNqDuxWL05zXVxeL9TzoVx/WnLdj1Wsj8+rSCecNTrCUYeC/QbyT4Cs9kQrd10AXbDeomNeXf1WEHE/vkKLWrBXjPae+NdLdI9u8GR7CURjw9VaMq2UcTUT3Q2PuTJ5/T5ha/1h0OYtsfU96HDHFjEKSP+Dm6lyB3O1oyMq32h2B0euAx6UgDdZ/4XhWYGnN+qifw/lTF+gF7DMNLPPq1g8kQGtJD30as8Xnchxhzbl17D6GLvZHLt/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(64756008)(76116006)(66446008)(66946007)(2906002)(53546011)(66556008)(66476007)(52536014)(8676002)(8936002)(33656002)(4326008)(6506007)(7416002)(41300700001)(7696005)(186003)(5660300002)(44832011)(55016003)(83380400001)(86362001)(478600001)(921005)(110136005)(9686003)(26005)(122000001)(38100700002)(54906003)(316002)(71200400001)(38070700005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cS9PUlhlVHRIR3BvOVB5cVNhem5MeGlCS1J4UUkwMCtiMzRxUmJWY08wNW8z?=
 =?utf-8?B?YUlZSGtDV0JNU0NKSWQ2MjBFUHVrVUlHUWR2dnBSWTIrU1BqbXFicjBLeXlk?=
 =?utf-8?B?OFBGdDhmQUtUdS9PMWZabXlFaDk4ajR0MWFwQkZ1RlgzUldLd2oyVC9IT2N5?=
 =?utf-8?B?eGZKSDNPb09sOGFBVXRmUS91Y2o2M2ZTYWxZVUtIM0lrVDR1RFIzZ0plUGVk?=
 =?utf-8?B?WkgwVms1Ulo0c2U5NHlkS281YUNUdWVxT0prZXNyckpBOFlha3J5cXJhMnZF?=
 =?utf-8?B?b3d0OEFlZ2xqdlo1aUJaMWxjUGNRVFEweWhsZDRhamhIRzNWMVZxYTczN1dr?=
 =?utf-8?B?d29qUzNkNER5cWFOQzVsVU1qNXJsK0ROU0V2OHZmSThLSWtnSUI2TVp6SlF3?=
 =?utf-8?B?SE1zS2krb1RyZlVDejQ4QVF4NEUvT25rVDdNK0xOMmc2azVwaS8xbEFtMkR1?=
 =?utf-8?B?dnh2OEZ4eGVDSlI1bk9OY3VFVWpRL0RRT1ZKeTVEUVpzeDJiSzdBaVVncnk3?=
 =?utf-8?B?YlVacnkwbkZ4YXJkdllnUmZnaTNDWEFjTGNZTnBYS3NOSjRMSTVpRUl5ckJr?=
 =?utf-8?B?OVhaOWVMQTliczhESWNsQjhkalBqZXMycllQK3I2TkdDSmhjbng2WXJBZWlk?=
 =?utf-8?B?ckVVWkRWUEd0WTVVU2hPU0hJMVFtbnFGK2w5dWRZMVdwRjRjVWxWNFMvU0Vj?=
 =?utf-8?B?MkNzdk9rWFBrUEV4ZFVZNXJUemM1MmZwZ3JMSkxZK1BvQktHYWxaUUlhYUZy?=
 =?utf-8?B?bStNNUFaQzMrS3pzS0N6N1MxanQxUUI1OFErTXBCZ1ExZ21LenZoU0hjc2Vo?=
 =?utf-8?B?aTRZVVVYbUR6TU1ac1lIQ3hSZzk4UExXR3NSL3BXclIyVXJQNkNZVDV2NmpO?=
 =?utf-8?B?Y3Z6SmNhS2dVTk9OODlkMmxkYVdhemFsM00rcnFFOXladUFOYWM1MVhzVzBV?=
 =?utf-8?B?RFBsREhxMXpVOEhUamI1UDlXOXRFay9EV0RlRmw0b0krNkJLZFlWQnpoOHlh?=
 =?utf-8?B?anVsaUhHUkRHTjZXM2VoTndneFFCM01vTW1jMEd5L2tWd0M5YVFlZXJYWHhs?=
 =?utf-8?B?U0w3Z0RrS2xuTXJ0QUFKUDE3N1h6L01jSFBNZTFMRXUwb0J0d1NDSkJsQXdy?=
 =?utf-8?B?RzR4RERHTExHQ2dZeDZtK3VlKzYxRzJjNVVzN1RwbmlXdkJobnYyQjNCeTJI?=
 =?utf-8?B?SERJZTVPWTg2aFZMWUI5WDg2c0dCUklNWUhubjdoZ1V6RTJmQ2FNVWNCbzFV?=
 =?utf-8?B?dk5veHJIT3dzY1pFSHJWQW1DekZicE5mUTdHMW56TmRQZUJKa01oajZkdGEz?=
 =?utf-8?B?eDVaQk5OODFLYzk0TEtVbS9YTmljRWNVYll1RlVlbnIxUGU3Ymw5NG1TZDdp?=
 =?utf-8?B?K3dzRHlzZ1JQSzBMekw5SWt4azZnb0hCV0xqUVBUd2s2VWlVUGtrenBDK1JJ?=
 =?utf-8?B?bTU4dnUrNUlyNHV1T3JQUE1tMjdBVnJOa1hyMWFGU0NRcHRUUndrYUxCMDF4?=
 =?utf-8?B?Vy85TVdBN3hiRCtoU2h4Tk9KQkxaYTE1VXYyNmx3UGZvbHBiTkM5YU1UbGhF?=
 =?utf-8?B?SktLR1Z2YVRLcXVZMlBnV29YQnRwY2ZDdjhYZ1R0N3VFQjZCNEUrS0liK1Rr?=
 =?utf-8?B?RUZiWWJmeUV5VWlwb1UvMHZXUXR0aWdWR3FvdTJVZ0ZPMXFWZGxNOU84Wml6?=
 =?utf-8?B?dzFTWUlVYXFEeUtGUHpMakxUVHdhSGZzZE5mZFVlK3NhYmwyS2srZGRqdkR5?=
 =?utf-8?B?Wm4xZWZpWCtMZ0dRVkE0blpHWk4zUHpibE5qZ2xGMjd0WE5KU1ZsZkcxdWVU?=
 =?utf-8?B?NzNoejlPdDRveW1xNWRoaVUweFQxUldRS2F0d1QveUppZGptbytRdXZwL1JS?=
 =?utf-8?B?R3l6TlVDcW5IUDN5d29WbHpwSkt0R2ErYnhBZmlTKzI3YlRyK1JrTXF3cEd0?=
 =?utf-8?B?cG84WnhQMitJdkc4T2wxS2dWVlFGL1FTNnBRci9aS0dqMURUUnJHNkIxamdl?=
 =?utf-8?B?Q1NGbnpSL0tIK1hvZEJKK1orZzVlUXY2OWN2Q1dVOWdyVHRheVF6QWFaTWJY?=
 =?utf-8?B?TWpxZnRvN2Vjcm1tL1JWTnAvRmxORUpOaG4ydTFDZFdwTHRSeWF2K1NmMjZm?=
 =?utf-8?Q?nlH153y3eC3Q9KgRM2AN2D/k2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49516518-0c1d-4a82-4de3-08da8a338d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 02:58:44.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOr0SwACvShP1RnCsA27vJb8gCeNWbvitPx94F2Igjc/AvTAN9RyAe81rWMM94rXtiRpnzAI73/vWFeHIeZMXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDjmnIgyOeaXpSAyMzoyMA0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJv
YmhAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsg
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsNCj4gbWFyZXhAZGVueC5kZTsgcmljaGFy
ZC5sZWl0bmVyQGxpbnV4LmRldg0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzZdIEFkZCBpTVg4
TVAgUENJZSBzdXBwb3J0DQo+IA0KPiBIaSBSaWNoYXJkLA0KPiANCj4gaW5zdGVhZCBvZiByZXZp
ZXcgY29tbWVudHMgSSBzZW50IHlvdSBhIHR3byBwYXRjaGVzIHRvIHJld29yayB0aGluZ3MgbW9y
ZSB0bw0KPiBteSBsaWtpbmcuIEhvcGUgeW91IGFncmVlIHdpdGggdGhlIGFwcHJvYWNoLg0KPiAN
Cj4gT25lIHF1ZXN0aW9uLCB0aG91Z2g6IGRpZCB5b3UgdGVzdCB0aGlzIHdpdGggZGV2aWNlcyB3
aXRoIEdlbjIvMyBzcGVlZHM/IFRoZQ0KPiBNYXJ2ZWxsIFdpRmkgbW9kdWxlIG9uIG15IEVWSyBi
b2FyZCBvbmx5IGxpbmtzIHdpdGggR2VuMSwgd2hpbGUgaXQgY2xhaW1zDQo+IEdlbjIgc3BlZWQg
aW4gdGhlIExua0NhcCByZWdpc3Rlci4gSG93ZXZlciwgaXQgZG9lcyBzZWVtIHRvIGNvbWUgdXAg
d2l0aA0KPiBHZW4xIGFzIHRoZSB0YXJnZXQgbGluayBzcGVlZCBpbiBMbmtDdGwyLCBzbyBtYXli
ZSB0aGUgZGV2aWNlIGlzIGF0IGZhdWx0IGhlcmUuDQpIaSBMdWNhczoNClRoYW5rcyBmb3IgeW91
ciBoZWxwIG9uIHRoaXMgc2VyaWVzLg0KSSdtIGFncmVlIHdpdGggeW91ciBhcHByb2FjaCwgYW5k
IGxldCBibGstY3RybCBkcml2ZXIgZG8gdGhlIGhzaW9taXggcmVzZXRzLg0KQ2FuIEkgaW5jbHVk
ZSB0aGUgIzEgcGF0Y2ggaW50byB0aGlzIHNlcmllcywgYW5kIHJlYmFzZSB0aGUgMiMgZml4dXAh
IHBhdGNoDQogaW50byB0aGUgcGh5IGNoYW5nZXMgcGF0Y2ggd2l0aCB5b3VyIHNpZ24tb2ZmPw0K
DQpZZXMsIEkgZGlkIHRoZSBHZW4zIE5WRU0gZGV2aWNlIHRlc3RzIG9uIGkuTVg4TVAgRVZLIGJv
YXJkLg0KVGhlIEdlbjMgd29ya3MgZmluZS4NCkxvZ3M6DQoiDQpbICAgIDEuODA4MDMzXSBwaHkg
cGh5LTMyZjAwMDAwLnBjaWUtcGh5LjE6IHBoeV9wb3dlcl9vbiB3YXMgY2FsbGVkIGJlZm9yZSBw
aHlfaW5pdA0KWyAgICAxLjgyMjYwOV0gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBpQVRVIHVu
cm9sbDogZW5hYmxlZA0KWyAgICAxLjgzNjYyMF0gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBp
QVRVIHJlZ2lvbnM6IDQgb2IsIDQgaWIsIGFsaWduIDY0SywgbGltaXQgMTZHDQpbICAgIDEuOTUw
NDI3XSBpbXg2cS1wY2llIDMzODAwMDAwLnBjaWU6IFBDSWUgR2VuLjEgeDEgbGluayB1cA0KWyAg
ICAyLjA1ODEzOF0gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBQQ0llIEdlbi4zIHgxIGxpbmsg
dXANClsgICAgMi4wNjM3MzFdIGlteDZxLXBjaWUgMzM4MDAwMDAucGNpZTogTGluayB1cCwgR2Vu
Mw0KWyAgICAyLjA2ODYxOV0gaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBQQ0llIEdlbi4zIHgx
IGxpbmsgdXANCiINCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gUmVnYXJkcywN
Cj4gTHVjYXMNCj4gDQo+IEFtIE1vbnRhZywgZGVtIDI5LjA4LjIwMjIgdW0gMTY6MTUgKzA4MDAg
c2NocmllYiBSaWNoYXJkIFpodToNCj4gPiBCYXNlZCBvbiB0aGUgNi4wLXJjMSBvZiB0aGUgcGNp
L25leHQgYnJhbmNoLg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgdGhlIGkuTVg4TVAgUENJZSBzdXBw
b3J0IGFuZCB0ZXN0ZWQgb24gaS5NWDhNUCBFVksNCj4gPiBib2FyZCB3aGVuIG9uZSBQQ0llIE5W
TUUgZGV2aWNlIGlzIHVzZWQuDQo+ID4NCj4gPiAtIGkuTVg4TVAgUENJZSBoYXMgcmV2ZXJzZWQg
aW5pdGlhbCBQRVJTVCBiaXQgdmFsdWUgcmVmZXIgdG8NCj4gaS5NWDhNUS9pLk1YOE1NLg0KPiA+
ICAgQWRkIHRoZSBQSFkgUEVSU1QgZXhwbGljaXRseSBmb3IgaS5NWDhNUCBQQ0llIFBIWS4NCj4g
PiAtIEFkZCB0aGUgaS5NWDhNUCBQQ0llIFBIWSBzdXBwb3J0IGluIHRoZSBpLk1YOE0gUENJZSBQ
SFkgZHJpdmVyLg0KPiA+ICAgQW5kIHNoYXJlIGFzIG11Y2ggYXMgcG9zc2libGUgY29kZXMgd2l0
aCBpLk1YOE1NIFBDSWUgUEhZLg0KPiA+IC0gQWRkIHRoZSBpLk1YOE1QIFBDSWUgc3VwcG9ydCBp
biBiaW5kaW5nIGRvY3VtZW50LCBEVFMgZmlsZXMsIGFuZCBQQ0llDQo+ID4gICBkcml2ZXIuDQo+
ID4NCj4gPiBNYWluIGNoYW5nZXMgdjMtLT52NDoNCj4gPiAtIFJlZ2FyZGluZyBQaGlsbGlwJ3Mg
c3VnZ2VzdGlvbnMsIGFkZCBmaXggdGFnIGludG8gdGhlIGZpcnN0IGNvbW1pdC4NCj4gPiAtIEFk
ZCBSZXZpZXdlZCBhbmQgVGVzdGVkIHRhZ3MuDQo+ID4NCj4gPiBNYWluIGNoYW5nZXMgdjItLT52
MzoNCj4gPiAtIEZpeCB0aGUgc2NoZW1hIGNoZWNraW5nIGVycm9yIGluIHRoZSBQSFkgZHQtYmlu
ZGluZyBwYXRjaC4NCj4gPiAtIEluc3BpcmVkIGJ5IEx1Y2FzLCB0aGUgUExMIGNvbmZpZ3VyYXRp
b25zIG1pZ2h0IG5vdCByZXF1aXJlZCB3aGVuDQo+ID4gICBleHRlcm5hbCBPU0MgaXMgdXNlZCBh
cyBQQ0llIHJlZmVycmVuY2UgY2xvY2suIEl0J3MgdHJ1ZS4gUmVtb3ZlIGFsbA0KPiA+ICAgdGhl
IEhTSU8gUExMIGJpdCBtYW5pcHVsYXRpb25zLCBhbmQgUENJZSB3b3JrcyBmaW5lIG9uIGkuTVg4
TVAgRVZLDQo+IGJvYXJkDQo+ID4gICB3aXRoIG9uZSBOVk1FIGRldmljZSBpcyB1c2VkLg0KPiA+
IC0gRHJvcCB0aGUgIzQgcGF0Y2ggb2YgdjIsIHNpbmNlIGl0IGhhZCBiZWVuIGFwcGxpZWQgYnkg
Um9iLg0KPiA+DQo+ID4gTWFpbiBjaGFuZ2VzIHYxLS0+djI6DQo+ID4gLSBJdCdzIG15IGZhdWx0
IGZvcmdldCBpbmNsdWRpbmcgVmlub2QsIHJlLXNlbmQgdjIgYWZ0ZXIgaW5jbHVkZSBWaW5vZA0K
PiA+ICAgYW5kIGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnLg0KPiA+IC0gTGlzdCB0aGUg
YmFzZW1lbnRzIG9mIHRoaXMgcGF0Y2gtc2V0LiBUaGUgYnJhbmNoLCBjb2RlcyBjaGFuZ2VzIGFu
ZCBzbyBvbi4NCj4gPiAtIENsZWFuIHVwIHNvbWUgdXNlbGVzcyByZWdpc3RlciBhbmQgYml0IGRl
ZmluaXRpb25zIGluICMzIHBhdGNoLg0KPiA+DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sIHwgIDE2DQo+ICsrKysrKystLQ0K
PiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzICAgICAgICAg
ICAgICAgICB8ICA1Mw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+IGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpICAgICAgICAgICAgICAgICAgICB8
ICA0Ng0KPiArKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE3DQo+ICsrKysr
KysrKy0NCj4gPiBkcml2ZXJzL3BoeS9mcmVlc2NhbGUvcGh5LWZzbC1pbXg4bS1wY2llLmMgICAg
ICAgICAgICAgICAgICAgfCAxNTANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAtLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgIDEgKw0KPiA+IDYgZmlsZXMgY2hhbmdlZCwgMjMyIGluc2VydGlvbnMoKyksIDUx
IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gW1BBVENIIHY0IDEvNl0gcmVzZXQ6IGlteDc6IEZpeCB0
aGUgaU1YOE1QIFBDSWUgUEhZIFBFUlNUIHN1cHBvcnQNCj4gPiBbUEFUQ0ggdjQgMi82XSBkdC1i
aW5kaW5nOiBwaHk6IEFkZCBpTVg4TVAgUENJZSBQSFkgYmluZGluZyBbUEFUQ0ggdjQNCj4gPiAz
LzZdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBBZGQgaU1YOE1QIFBDSWUgUEhZIFtQQVRD
SCB2NCA0LzZdDQo+ID4gYXJtNjQ6IGR0czogaW14OG1wOiBBZGQgaU1YOE1QIFBDSWUgc3VwcG9y
dCBbUEFUQ0ggdjQgNS82XSBhcm02NDogZHRzOg0KPiA+IGlteDhtcC1ldms6IEFkZCBQQ0llIHN1
cHBvcnQgW1BBVENIIHY0IDYvNl0gUENJOiBpbXg2OiBBZGQgaU1YOE1QIFBDSWUNCj4gPiBzdXBw
b3J0DQo+IA0KDQo=
