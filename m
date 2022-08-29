Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9476B5A44C1
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiH2IOq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 04:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiH2IOi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 04:14:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70075.outbound.protection.outlook.com [40.107.7.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEE55084;
        Mon, 29 Aug 2022 01:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+n3ghQJFg0qXNU9qz2kAnAUmt+OvzUZiL6LmgATSIROnaVlT5lPTQlBfokfh34D4Gu2ibVM1fFabm03ZwPsriNwnQG/i58+s5l+BDmhSXd8sC/g5Zlpq1YfU7DsbC00Kc2ZMCYkS+vXatLP9co7orFBfobVbiQk4zp80LKPLHA+7gAqwgn5/X1tTHMSOJ808F9WrLidOkalpg7qJo1/cVSQlGxop27NnPW6yscIY8Ca7jOnw6PixqrN7cQG2ALMIfv72BqNOjzpjAP7j+SiiJuD+i8y3tVMJ7Tj5E7V80puu+zV2J4JHb6Ax3NXvlNgGQb4I0iECvzxR3hOff+BoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh8adSJpQtjcTv7nyFoexmv5CYAz91tllFrK/PNhdXU=;
 b=E1kP3mknk6+yRdHE8sgV3YwQgh+XwaVTep3dmTXfZqbWzZcK5xRSXNaqCZXQWO40j2oEzUkfDgHEMU7BnR9V4YE6FK5JDebk4SXb5jvxaohBQBXiTLZyGDI1Jdr8K6f6PNAlO1K8IDOQxG8B2KSsaqzWip1P282wfafZf7YgyzJZaPgZ28PUEY/V7JKDCqfb9kDiQuikXKpf/48RcOoi0groxt/6XXxMrwlZTEvk/tGwEtTttZgSaHxAvWDTB4sxIbZO1kkHBFFTFqav3tCV5SmUysRS39ym7x8rH6ix828hyNdBasLlgy4eFHsf5Y7NFmDxRzrHXu2mr/XOSzd9qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gh8adSJpQtjcTv7nyFoexmv5CYAz91tllFrK/PNhdXU=;
 b=VRAzQmFUv2U/A6gmyCIXSO//AqSzUGx0iQ/4nMMd7T4xwD5UAr6b6j43/15Jky35DbYxQBxt7BuY7nZia2ylizKUfyOsCp2jz4glrKznV1KR74dBmsCquhS0qhfF/fsTqEefWWCFBuKDjXsSBqv1FYqFP/IZxLeymIYrz7IipXs=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 08:14:33 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 08:14:33 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "marex@denx.de" <marex@denx.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST support
Thread-Topic: [PATCH v3 1/6] reset: imx7: Add the iMX8MP PCIe PHY PERST
 support
Thread-Index: AQHYstLgBFLirUeLGU22SE2/uWNoMa20WZmAgAAh0YCAERxqAIAAAE5w
Date:   Mon, 29 Aug 2022 08:14:33 +0000
Message-ID: <AS8PR04MB86766307034A158B2629681F8C769@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <1660806153-29001-2-git-send-email-hongxing.zhu@nxp.com>
 <ddbcd90419e9bb4ce7c5b7b3055ee3227c179321.camel@pengutronix.de>
 <AS8PR04MB867626BC5C32AA75466BB9E78C6D9@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <Ywx0WorLvPrXGVt9@lpieralisi>
In-Reply-To: <Ywx0WorLvPrXGVt9@lpieralisi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dac05c99-9cff-430a-55b5-08da8996817e
x-ms-traffictypediagnostic: AM6PR04MB6630:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHj4RDUSm/TaPkS/OT8HXCAjkdqhwJhuLNL8eeOfKAs/C2HKI3EouP3QbJwVquuHJEKu0+/YyAQCpkr+Rj8ZSVoOfYDO7KMV5OHBa8AB4SYFkphZEVvpiM6DwuqwkEdz2qdObjzoeQHrm9bovutz1FlmivbjpCFVU5L2l7reN/jJ8iLveUCEKHI3hdGVf/fGc/UJXRXJG+1OK/H0AyYaJ/Dk9WSJxvZDsbHJZCPe+RqASQdeEcPpmcEOTxMLOzv4q4ooZ4lbSuQ/ywSyCICUFQ+PbPzPBMZ5xQ8vie4/rq7APWEwn0Kr+aTHbd1D+GmFuKyexYFWnUBAgeZYvT07JBk7E8zFoQDxnE9f2OhaRSVgW7RAoryhEl+sLjvadn0ll7NC7mdI1jtolZt8/WGadGJZ4Pg1O0AogIWrDyhV+MfWlA1jqlQYvWTOKXDlia8y4sq6KA3NnhtX+BgvlpgugmT4C809GfQL16krpdOE+QdyxBaJMSI24LSmysT6CTY2KA3mWMsfn7IxDIRhHHCiorbsea3exJzfaECiVdDaXxIjXjctpzTj9k3u+EJrvbNBeEe7AQxbPWBFZfxSk6EVGqHfHJ2JneNj8cRSri3cp0jXktKGa5NEjtRUgNzA9oz9uEfPRhuHqWiRYA2YBW160c9uK0ZSNpzJJM516XzfI6GPRjG/l3F9zVU2tLII27yykFy4ANQkQtW7aTPh2PsF2O4x8rf7Dgl3eim6dqfHnfEn+BoE38C2E7ZIwu6vGjK3z8TyZmfYH1r5xB2/X5N8SS4Y0cRkZYCiyGmPo7k2Cgm3N6vDSket/AqNqQbOkzcJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(6506007)(7696005)(53546011)(6916009)(41300700001)(54906003)(478600001)(316002)(71200400001)(966005)(45080400002)(38100700002)(122000001)(86362001)(38070700005)(26005)(83380400001)(9686003)(44832011)(186003)(33656002)(55016003)(2906002)(5660300002)(64756008)(76116006)(52536014)(8676002)(66946007)(4326008)(66556008)(8936002)(66476007)(7416002)(66446008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QmJGazVFWGNZek5kNG1zQ2NQSHI5T1g5ajVZTy9NeWRMTzlmVFRlVU9Cdng1?=
 =?gb2312?B?V3Vrb0xnSXNjUDFETzBuU2NWVy9GcGQzb0pCbEFpS0ZFclg3MTY0TEk0VFBt?=
 =?gb2312?B?OTVNYU16cVM0T3VZdWZLQlRMVFNmQStJc3ZkcUFKMUU0MTU5SVVuenI3YUVw?=
 =?gb2312?B?SUNWZ2tCRWkwdkhHRGZjNWVpaFVweXgrUmIvRmMrdzBrSHEzOFgyQWNhQksv?=
 =?gb2312?B?a0ptNjZ0dmFtTm83VlI5Rjc4RCtUc1NXUmg4RG1RNGZmZnVZYUpRN29LWjZ2?=
 =?gb2312?B?amZ1MC9VNnVXNnB3MWNjTUgxcXVoYVVkYlBSQ3FoVGVLbEV6a2cxSmJrQ0Jj?=
 =?gb2312?B?aVRiRlZuWCtzVjE5WlY5L3ArdWQ2NUFNNWo4blJITXZrdWRaZTJSTkRMNlNs?=
 =?gb2312?B?TWhDVHBvTGZ3eXBoajRQMUhlU1NHNDRrdm9zNHhwTFkzbHR6TXgxc1p5SE9k?=
 =?gb2312?B?Y1YrbHZIYnlrOFA1N1VQNzdGbkh2QVdCR3lzWTZkYzVLQWxjaEJITk81Tmxh?=
 =?gb2312?B?MkRkakhrd1l5anUxSEZXbmRVMmZ6MnBBSDh1L1ZHOWlqcWV4eVFKMVdJK1lR?=
 =?gb2312?B?UXpsalh0OHNDbS8ya2RZT2ZoZ0RGMUI1ZnRuUE5IcHd0dFdDS0pwdXNMam1h?=
 =?gb2312?B?SVFSMzBZQVFTcWNUdVlBd3BPZDFqKzk0UGlEZ1FGQVZKanN6RG5VVWFoaG1I?=
 =?gb2312?B?cnFGVllmNDAxKzI3U0dsR1hHa1hjMms4azNUV20weWhIOFBTYkZ3UHJhTGQx?=
 =?gb2312?B?MHE4c3dpVTEvNEg4UjRxUjh1NDFhdW9yUnFlVkV1akdWSy9XNit0eVlialhX?=
 =?gb2312?B?cjdVUlJFb0ZVUXpLLzRYaFBDU2ZRcW8wQXlvUG8zcnByay9TamYzb05FTUlU?=
 =?gb2312?B?R3F5T2wrSlFIOUx5S0NTOUVhYVJKS0VpUW1VNHJlWEhHNTV1VWp4RUhiRENu?=
 =?gb2312?B?MEV6dmpRa2NrNnJXVlBuR20yekp0WUIrVFFSRi95cTBaYjlvNmVrSDJuOUVZ?=
 =?gb2312?B?NGhWd2U4bEVYWGJ5Tk9jUzVEUkxPTEZWaVBSVTZrODZsVVRBYXFyWUMxb011?=
 =?gb2312?B?dEIxUUlrN2FvMzFkcG9ibEtSNXNxYy9ubzljN1VBT2Z4OHZOcEgvNFh0eVpX?=
 =?gb2312?B?b1o4eU5nWnY2bjZXdWN0T0dHRmFySDkrdnNEbk56dnEvYkRuNWdJTHZCaWho?=
 =?gb2312?B?dkxkREhDczVtaFVESWtPVHpoZDV6Um8wM25kOXlwQzlxTWZQcUJpTTZ0Q3Z2?=
 =?gb2312?B?anJmM1UxRG5hdXFWZUJyUVAyWWhnSGRCdFA4VDRYU0xQVjVuNzVSQVZ4Z1FP?=
 =?gb2312?B?ZDg4RGtaRjlJdGN5dmtTM1NMSUJDTjNURkg0ZzhVL3dwVHhEbi9sbzlsc1k2?=
 =?gb2312?B?UzFWWW9sMjQzZjBDcDhLMkJHaVRjcWE4dnBrdFJEb05yRWRTdUVIOWFYbVI0?=
 =?gb2312?B?Zk03dXowRmlJRFVkS00yekRIai9GbTJNYXBrLzhma05yekZIYmI1QzRuTTlr?=
 =?gb2312?B?QlQzNit2dmhGR0VLekpNQzVFZWtPUXpFNENvelBscmgrUWx6RUZUc0czcWRa?=
 =?gb2312?B?RkRsZUpzdjM2SmZIZEZRSzF2dHFwVHBySlVXUTljTDFlUzBSZkg5OStjNGlx?=
 =?gb2312?B?dHZ3TU0yeXNtY3hxOEYvQmZNWXJnMUdkTDlqWTN2T2ZZaUZlTnJXZVVpZ1BC?=
 =?gb2312?B?ankraTZBTjhXanZlbjdManA2am55dk1KUGdaanJzMFpLeDVZQ3ZYWHgxZDdv?=
 =?gb2312?B?enRCK0M1U21pMzBBQVd6bkdaajhnOXpha0tFQk12bUJ4M2tmT1JrVU1RbHpw?=
 =?gb2312?B?dE9EeGZ4U04xM1NDeVN1NHZuWXJrN2oxKzNaSHQvZHVpcGhTbHJFZGVlZGJX?=
 =?gb2312?B?WlNyTWN3cUF6SDFhSzRKbWRzcmtoem9pdHI3UDdDZHpjVGxPdmhFMGZlOEJq?=
 =?gb2312?B?SC9ycGxIM0ptMzBsWVQxbFFWZlN1VjlVR0JCSkQyMDlFUFVYUUlLOVJweXNX?=
 =?gb2312?B?MWpuZ2I5YVdna0hOL1V2enBqQWs3ZThRbldtMTR5cDRNQ2IvYzEyS1QwZlJk?=
 =?gb2312?B?VERyMGkzOHlDUDR4UTgxc3lJRDdXZStGNFBBZ3FQNHNBY3BxeHlhaWdudlFw?=
 =?gb2312?Q?1EKFbhBcqW9uqDtwBrZh/KXn9?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac05c99-9cff-430a-55b5-08da8996817e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 08:14:33.6348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: INKosNjc974l2uwxVB+f0CStNhvTY+HQgGWZlvbtaw2TS+YXmdDh+K9ZhMAsKv7z8d4yEkU3kgX2PUPEhW0tig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6630
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
bHBpZXJhbGlzaUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIyxOo41MIyOcjVIDE2OjEwDQo+IFRv
OiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogUGhpbGlwcCBaYWJl
bCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGJo
ZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVs
Lm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsgYWxleGFuZGVy
LnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsNCj4gbWFyZXhAZGVueC5kZTsgbGludXgtcGh5QGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwt
bGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MyAxLzZdIHJlc2V0OiBpbXg3OiBBZGQgdGhlIGlNWDhNUCBQQ0llIFBIWSBQRVJTVA0KPiBzdXBw
b3J0DQo+IA0KPiBPbiBUaHUsIEF1ZyAxOCwgMjAyMiBhdCAxMDo1MzoyNEFNICswMDAwLCBIb25n
eGluZyBaaHUgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4g
RnJvbTogUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gPiA+IFNlbnQ6
IDIwMjLE6jjUwjE4yNUgMTY6NTENCj4gPiA+IFRvOiBIb25neGluZyBaaHUgPGhvbmd4aW5nLnpo
dUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGJoZWxnYWFzQGdvb2ds
ZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHZrb3VsQGtlcm5lbC5vcmc7DQo+ID4gPiBhbGV4YW5kZXIu
c3RlaW5AZXcudHEtZ3JvdXAuY29tOyBtYXJleEBkZW54LmRlDQo+ID4gPiBDYzogbGludXgtcGh5
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4g
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1
dHJvbml4LmRlOyBkbC1saW51eC1pbXgNCj4gPiA+IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiA+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS82XSByZXNldDogaW14NzogQWRkIHRoZSBpTVg4TVAg
UENJZSBQSFkNCj4gPiA+IFBFUlNUIHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBIaSBSaWNoYXJkLA0K
PiA+ID4NCj4gPiA+IE9uIERvLCAyMDIyLTA4LTE4IGF0IDE1OjAyICswODAwLCBSaWNoYXJkIFpo
dSB3cm90ZToNCj4gPiA+ID4gT24gaS5NWDcvaU1YOE1NL2lNWDhNUSwgdGhlIGluaXRpYWxpemVk
IGRlZmF1bHQgdmFsdWUgb2YgUEVSU1QNCj4gPiA+ID4gYml0KEJJVDMpIG9mIFNSQ19QQ0lFUEhZ
X1JDUiBpcyAxYicxLg0KPiA+ID4gPiBCdXQgaS5NWDhNUCBoYXMgb25lIGludmVyc2VkIGRlZmF1
bHQgdmFsdWUgMWInMCBvZiBQRVJTVCBiaXQuDQo+ID4gPiA+DQo+ID4gPiA+IEFuZCB0aGUgUEVS
U1QgYml0IHNob3VsZCBiZSBrZXB0IDFiJzEgYWZ0ZXIgcG93ZXIgYW5kIGNsb2NrcyBhcmUgc3Rh
YmxlLg0KPiA+ID4gPiBTbyBhZGQgdGhlIGkuTVg4TVAgUENJZSBQSFkgUEVSU1Qgc3VwcG9ydCBo
ZXJlLg0KPiA+ID4NCj4gPiA+IHRoZSBkZXNjcmlwdGlvbiBpcyBnb29kIG5vdy4gSXQgd291bGQg
YmUgbmljZSBpZiB0aGlzIGNvdWxkIGFsc28gYmUNCj4gPiA+IG1lbnRpb25lZCBpbiB0aGUgUmVm
ZXJlbmNlIE1hbnVhbC4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgcmVwbGFjZSAiYWRkIiB3aXRoICJm
aXgiIGluIHRoZSBzdWJqZWN0LCBhcyBJIHJlcXVlc3RlZCBlYXJsaWVyOg0KPiA+ID4gInJlc2V0
OiBpbXg3OiBGaXggaS5NWDhNUCBQQ0llIFBIWSBQRVJTVCBzdXBwb3J0Ii4NCj4gPiA+DQo+ID4g
PiBBbmQgYWRkIGEgZml4ZXMgbGluZToNCj4gPiA+DQo+ID4gPiBGaXhlczogZTA4NjcyYzAzOTgx
ICgicmVzZXQ6IGlteDc6IEFkZCBzdXBwb3J0IGZvciBpLk1YOE1QIFNvQyIpDQo+ID4gPg0KPiA+
ID4gV2l0aCB0aG9zZSB0d28gY2hhbmdlcywNCj4gPiA+IFJldmlld2VkLWJ5OiBQaGlsaXBwIFph
YmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiA+ID4NCj4gPiBIaSBQaGlsaXBwOg0KPiA+
IE9rYXksIHdvdWxkIGJlIGNoYW5nZWQgaW4gbmV4dCB2ZXJzaW9uLg0KPiANCj4gQUZBSUNTIHRo
ZXJlIGlzIHN0aWxsIGEgcGVuZGluZyBjb21tZW50IG9uIHBhdGNoICgyKSBidXQgSSB3aWxsIG1h
cmsgdGhpcyBhcw0KPiAiQ2hhbmdlcyByZXF1ZXN0ZWQiIGFuZCB3YWl0IGZvciB0aGUgbmV4dCB2
ZXJzaW9uLg0KPiANCkhpIExvcmVuem86DQpUaGFua3MgZm9yIHlvdXIga2luZGx5IGhlbHAuDQpJ
IGhhZCBwcmVwYXJlZCB0aGUgdjQgdmVyc2lvbi4gQW5kIEkgYWxzbyBwaW5nZWQgTHVjYXMgcHJp
dmF0ZWx5IGFuZCBob3BlDQogaGUgY2FuIHRha2UgYSBsb29rIGF0IGl0LiBUaHVzLCBJIGNhbiBh
ZGQgaGlzIGFjayBpbiB2NCBzZXJpZXMuDQoNCkFueXdheSwgSSB3b3VsZCBpc3N1ZSB0aGUgdjQg
c2VyaWVzIHRvbW9ycm93Lg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IExvcmVuem8N
Cj4gDQo+ID4gVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCj4gPg0KPiA+IEJlc3QgUmVnYXJkcw0K
PiA+IFJpY2hhcmQgWmh1DQo+ID4NCj4gPiA+IHJlZ2FyZHMNCj4gPiA+IFBoaWxpcHANCj4gPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+ID4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHAlM0ElMkYlMkZsaXN0cw0KPiA+IC5pbmZyYWRlYWQub3JnJTJGbWFpbG1h
biUyRmxpc3RpbmZvJTJGbGludXgtYXJtLWtlcm5lbCZhbXA7ZGF0YT0wNSU3DQo+IEMwDQo+ID4N
Cj4gMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NkMDQ3MGNlNzU3ZTY0ZTZlN2M2YTA4ZGE4
OTk1ZTY4OSUNCj4gN0M2ODZlYTENCj4gPg0KPiBkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM3OTczNTc0MTY2NjgyOTIwJTdDVW5rDQo+IG5vd24lN0NUVw0KPiA+DQo+IEZw
Ykdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhh
V3dpTENKWFYNCj4gQ0k2DQo+ID4NCj4gTW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9
TEU0aTVPUTAzWFYwdFVvJTJGV0ltOEw5bQ0KPiBOeDdaTlpNVWhmcG8NCj4gPiBMamk0JTJCRFJN
JTNEJmFtcDtyZXNlcnZlZD0wDQo=
