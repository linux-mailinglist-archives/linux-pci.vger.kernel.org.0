Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770BB5A2145
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbiHZG4o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 02:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbiHZG4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 02:56:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B094BCCFD;
        Thu, 25 Aug 2022 23:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIXhWk/NIkFawDx1RzeBkN/3Sn9qAjWx/u28D8q8GmiEPxd2K08H2Hfhba/VvPiBNL03Hmt+D0NAGnw69F/PoC2KW3comEekOJIFCbKaQka1Bkz9YXWA8QlJAA2RSTW+c38e9Yat7OyYgG7vKQUSZljtbqO5G+r7/tczI81oRCFqp2xh2T6nZGJGKhMreEXk9NzKZI/JBRKfL5hGMGFUvyeyK/zeOMi3fbyrJtHuJIirHcSvlOa5t3+E7Cmnh2TkR0sxe7yg55wBVrRg6meqiclQGI7O3jqMp848/R0zez50Q9O4zbFdkSAoczHy6HMDvDGdHsF4Dasrsst1nwQXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3G4/PK5IWVISmFM7Ncm0sB5rIU2c5M5PMCwGzVDOd60=;
 b=IUDr0wbRvxeUYG1MdATU+f4tXHn0dO/3fyJlUEvX0ZeKX+VmFfY77L5DPOet8UPxRX6t5/NYHZgX6Jylqzp3p9qXg4XDUkESlONGITC4bsT1SqpLRHX8mgWa24DmmZAuDbep5RAtAuIhTHc62wCpPW4AI9/JqtdSx3th6CLyPaqlF3OUlnK+xROJ0IH8vgFSQKC8+f84scGQk+QBmi6mdAIZGmYjbpxxsV++DCbVSW+WR2KdLuiP3NgvAwKtzE9mZ1UimfmEa4nE9W+D5k66+uLxQQovznnAzMAX0lc64K33eN9p5Z64j21aSm75XMR5JhefqM9jlcqHMQKFS93TXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3G4/PK5IWVISmFM7Ncm0sB5rIU2c5M5PMCwGzVDOd60=;
 b=iQN+lRtlHXZO8qMunxy46XLfkumiLBVYEpwkW8GDN0Oy3fFxITuxdEM+KpcfgzAO8CTcrMMMD457BCzpk0ZZ86hzt/WI1EZe4olg8rgC3PCiTs/7kI+QWHYjVYh8GeX1mvYtWuySulHoymnPCpi7a9jDD0hqlwggWcH2chwCLJg=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 06:56:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 06:56:38 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v3 0/6] Add the iMX8MP PCIe support
Thread-Topic: [PATCH v3 0/6] Add the iMX8MP PCIe support
Thread-Index: AQHYstLfaP14T4wF40K69XTShRcol63AwsSAgAAJT0A=
Date:   Fri, 26 Aug 2022 06:56:38 +0000
Message-ID: <AS8PR04MB8676979F7058D844881A924F8C759@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1660806153-29001-1-git-send-email-hongxing.zhu@nxp.com>
 <4384717.iIbC2pHGDl@steina-w>
In-Reply-To: <4384717.iIbC2pHGDl@steina-w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebc10df6-303e-4147-7b94-08da87301f6a
x-ms-traffictypediagnostic: PAXPR04MB8718:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LC7PtUDK4uAdw14iY8uL+tDRzA4AT/VKbLojF/lUesx1uEcYuSN71an7t89KyD5kl1SwUSmAyv/u5dunUCMy6k/Xwieo9OpymC4UoQ6C0zBVIDXHiW9/SgsAYY7WgMEBSOPshD7oWocN376V3W1gj8B4WiZWzC85Se3cxeOdn16S71BFDSqJsQTn25zN6Zs4MksA8uWOlvNJMhdPiY8h2TGfz6Xnf7JtePTU8pKxMmJtf9DYPdweuS6k4LlPeFSFXZX1ARSmtp+an0JSLTMFnBrv7KY2s0vJXYszyCsl0QHHKh4B6bKQOYAcyIwN0P3xjYvKcvFleeqtkO0RgqJ+AjzliO9dpF2Pc1BxTQc0OCUIRcUBkmCwCH/wZ+0d1OXlgnizJkdaRvnYNApxACw/omgzLHCYNsTgIy5Swv2XgOlP51OUHuB/filno7oIuzcKiDWcb3Xt23C6Ue8U21R3rCcVK18bC+uvHu3HmdWuXrgYeBUZTuFQBKU+1hlDAX7rMcn3M/FrT8/rtULcc5t8IXPMb5QcswJB8A2Pb7ROn0xnNiJ0/bfVOPr+oBYupXIc7T3ezeiSqenRi3N6FFNFY2IZ7qZeI4Nv1jpZjWTBcflW+A4S2NPsIzlUsElio8rgb+97RUb7XfdsKpLccKHnRkAoxq4Ta97TVjc8ARBmmlr7sK7s8gOW6+E2XB2Hx5PCmdzREr/IOTdTklGxeoi46RZBcdxJrNvAid6lmIVyAQNJL/aBP9TD57tVIfCI7k1wP3YNf2OrY1zugCYmiAKE28vM/E7UVZek+uKCauJpg0k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(66476007)(52536014)(66446008)(66556008)(76116006)(66946007)(54906003)(55016003)(478600001)(5660300002)(8676002)(38100700002)(122000001)(4326008)(8936002)(6916009)(316002)(44832011)(7416002)(41300700001)(64756008)(26005)(53546011)(7696005)(2906002)(186003)(83380400001)(33656002)(6506007)(86362001)(71200400001)(38070700005)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?QUNyVGhuckYwMjBpMUwxem16SHEzUjIreWQwK0JVbXNUNmU2ZzZTQnBOb2h0?=
 =?gb2312?B?WFcrOHAwSkVNZ21Qb3NRVW9kNmh3VEtDZkg4Vkh3eFVNK1dkdFNXbTRBaGZM?=
 =?gb2312?B?eDI0ejVDc3hyRkNFYzdpTmt6dDJFVzl6ZUJJRFg4NTJ2dXBJMVVHaE9IM0Jk?=
 =?gb2312?B?aktIRTVXUlVIaU5XS1FYQm9zZVdZRVRUSUk1b0VRV0hyNm9sVWg4K2s4aWcv?=
 =?gb2312?B?ODFKTnMwRmt3YlhzRzlKNWtJem84aW5kY2oyckxTRlViMWNhZVI1dkhVU1J2?=
 =?gb2312?B?OEUrMDRORTNoZG5sQ0x0aUg1eUsxK3lhTm8zYmVuYUxFWnE3YXJKUWoySzY3?=
 =?gb2312?B?cHFMWVcvb0RadlJkN2JQc1BMNm90YzVUN0FpZ20vMkRCSy9wRTVXSnowd0gx?=
 =?gb2312?B?bEpEZDhoK1UvVGxha05lb3owb2RXamdkbVVmekV5aGtnTVhHNjRMU0hzTkxl?=
 =?gb2312?B?a3lWaGFkVytpTUI2MWxBNnc0Zm1aT09tbHh2bXJBSHFHTEV5YnB1TTd5aXZx?=
 =?gb2312?B?RGdCaFlFaXF6TExCdUtaNCtveFhkejVNNVJzcFVDb1lnd21XS2l2eU1MaFd2?=
 =?gb2312?B?c3JDU0NRajRRRDBUWjlRYzFOVms4NEdKTzdEck9neUFRc1Z2UkRYOFh0clpl?=
 =?gb2312?B?dUFZRU1wUjROQ0RUSDJZZWZaRi9Bazh4Zzl4cDVMdjU4UXFpUWJZY2k0MVEw?=
 =?gb2312?B?Ly9zUllmemFwS25tWk9EcHMvMmx5V0hTemJFbnZrc1ZzS1lFNWVIeTJvZXVk?=
 =?gb2312?B?SS95MzNnSUZvM3R1Ui9kY0l0djZIZmY0ek11K3dSOFluU2dISHJYVzR2TEs5?=
 =?gb2312?B?VVNJS1NyWFZtNm9lZWVlcUYweXpIK092OGRHS0RQOXVrSDd4djJjVTVEYmIx?=
 =?gb2312?B?Q0FmV04yOGI1d0gyYW82K0o1NENIUVpscTJQQkl1VSsrUDc0OG5CWGJ1NmRF?=
 =?gb2312?B?NXB4QmNDSmlZUGlqWXdGYUtTUzROWEZrYXlOZW55UGhFb1lYQzI3WGt5UXFP?=
 =?gb2312?B?UStqZkwvZ0tHMS9BcE5yaTBzU3NXdlNMbThicnJKVGI3UFA1R2l2QW5BUkhx?=
 =?gb2312?B?QUJpS1N0N25ndDV4MG50T3JGMUlmdHFCRXpPeHV4Y25ZT3V3dXYzeEwwa1h6?=
 =?gb2312?B?S1M1SDNnTXlWNHYyWGNPTzBmUVV0cVVCS1dOaFNia2xrQ2lvc005SnJqdkF6?=
 =?gb2312?B?MnViQzl0SHZQOGVRYkhiaUNPY3NwbE9sSnZKN3Btdzdla1BZNHNXdmhhaENV?=
 =?gb2312?B?MUhIS3Z5QnFxZzR5OTBtRW8xQnRudUlnRGFSUGx1bDZpbXFETjV4U05iMGRp?=
 =?gb2312?B?RWpuTHZzeFYxNUZ3eE1nUHpGT29PYStMenFXMTI0ZXhoM3lBQXUrOHN6RVdH?=
 =?gb2312?B?SzZQRi9SaW1KTithRW9Qd2ZLYXNERVZGdisySlJsRFNCMkp3QTB6aVdHT2Vq?=
 =?gb2312?B?TER4c0tKZHFxVWVaTHdEeVp3ZnpNb2FyUG9naVJwQXJmWEpLUEtOWUpCUGNr?=
 =?gb2312?B?aVVrbGtodVZtelZRTUtHSERhejdhYS9ETmdEcGRmRmJTNFNsS3A2UjkvOXJC?=
 =?gb2312?B?N3hHQzJTdlh6OTFaU3gyVHVkcWNYS05RTm9RZUk0eVNOTmRDQkU2RFdIdytJ?=
 =?gb2312?B?MW41UUx3UFo0bjF5WW1Ed1VPTjZFQTFONzhoSTJhYlYwUmVaSzFzeHlhUXh0?=
 =?gb2312?B?bkdaWFltVDlKZ0xYNTRLY1RTd0F2MTI3UEJ0Y1JDNXp1MkJ4NHVpaWxXNnZY?=
 =?gb2312?B?RlNZc2VocDl1RGFqa1RqaDJRMEl3U1BadG5uZ1F6ZEt4a3l3Z3czYUdKaHp6?=
 =?gb2312?B?WW1wRHpQdjZFYTNSY0s0and4dldUQXZZUU51V1IvdnRNWGtEdGxGNXZ4RktB?=
 =?gb2312?B?TUtGZkNOeEU1V2ZKNFd5SzdTYmlBQkpBLzRSa0kzTldDUVQ0SFR1eFV4Uk1T?=
 =?gb2312?B?YzNyWVdPcTlrSjA5Q0hrdmtFbk5teEZXZFlBb0w2ck5NajQ5RGM0ZXFRR3ZK?=
 =?gb2312?B?M1I1WkhRYmE1alNaNVA5VnhOeTZyYlAzbCtBQlN3TU1uZzY5am1vb3N6a2Fq?=
 =?gb2312?B?dHpMM1FLTHUydVVlbUh6RlE2d241VUY2aWhlajV2NEpwWjF0TlR1K2FxRzBT?=
 =?gb2312?Q?q1ldyZe7qcjqjDddLDQvPdFXu?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc10df6-303e-4147-7b94-08da87301f6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 06:56:38.1286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuyM1AwR8Rk8JQ6kT0d3ogZtCqj8aOnGrnaRXRCXgIYJzKVCEREy5VP6WaCwvmBM5pS11XAtn58NN4PGoWsfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4YW5kZXIgU3RlaW4gPGFs
ZXhhbmRlci5zdGVpbkBldy50cS1ncm91cC5jb20+DQo+IFNlbnQ6IDIwMjLE6jjUwjI2yNUgMTQ6
MjINCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBwLnph
YmVsQHBlbmd1dHJvbml4LmRlOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBiaGVsZ2Fhc0Bnb29n
bGUuY29tOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyByb2JoQGtlcm5lbC5vcmc7IHNo
YXduZ3VvQGtlcm5lbC5vcmc7DQo+IHZrb3VsQGtlcm5lbC5vcmc7IG1hcmV4QGRlbnguZGU7IGxp
bnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjMgMC82XSBBZGQgdGhlIGlNWDhNUCBQQ0llIHN1cHBvcnQNCj4gDQo+IEFt
IERvbm5lcnN0YWcsIDE4LiBBdWd1c3QgMjAyMiwgMDk6MDI6MjcgQ0VTVCBzY2hyaWViIFJpY2hh
cmQgWmh1Og0KPiA+IEJhc2VkIG9uIHRoZSA2LjAtcmMxIG9mIHRoZSBwY2kvbmV4dCBicmFuY2gu
DQo+ID4gVGhpcyBzZXJpZXMgYWRkcyB0aGUgaS5NWDhNUCBQQ0llIHN1cHBvcnQgYW5kIGhhZCBi
ZWVuIHRlc3RlZCBvbg0KPiA+IGkuTVg4TVAgRVZLIGJvYXJkIHdoZW4gb25lIFBDSWUgTlZNRSBk
ZXZpY2UgaXMgdXNlZC4NCj4gPg0KPiA+IC0gaS5NWDhNUCBQQ0llIGhhcyByZXZlcnNlZCBpbml0
aWFsIFBFUlNUIGJpdCB2YWx1ZSByZWZlciB0bw0KPiA+IGkuTVg4TVEvaS5NWDhNTS4gQWRkIHRo
ZSBQSFkgUEVSU1QgZXhwbGljaXRseSBmb3IgaS5NWDhNUCBQQ0llIFBIWS4NCj4gPiAtIEFkZCB0
aGUgaS5NWDhNUCBQQ0llIFBIWSBzdXBwb3J0IGluIHRoZSBpLk1YOE0gUENJZSBQSFkgZHJpdmVy
Lg0KPiA+ICAgQW5kIHNoYXJlIGFzIG11Y2ggYXMgcG9zc2libGUgY29kZXMgd2l0aCBpLk1YOE1N
IFBDSWUgUEhZLg0KPiA+IC0gQWRkIHRoZSBpLk1YOE1QIFBDSWUgc3VwcG9ydCBpbiBiaW5kaW5n
IGRvY3VtZW50LCBEVFMgZmlsZXMsIGFuZCBQQ0llDQo+ID4gICBkcml2ZXIuDQo+ID4NCj4gPiBN
YWluIGNoYW5nZXMgdjItLT52MzoNCj4gPiAtIEZpeCB0aGUgc2NoZW1hIGNoZWNraW5nIGVycm9y
IGluIHRoZSBQSFkgZHQtYmluZGluZyBwYXRjaC4NCj4gPiAtIEluc3BpcmVkIGJ5IEx1Y2FzLCB0
aGUgUExMIGNvbmZpZ3VyYXRpb25zIG1pZ2h0IG5vdCByZXF1aXJlZCB3aGVuDQo+ID4gICBleHRl
cm5hbCBPU0MgaXMgdXNlZCBhcyBQQ0llIHJlZmVycmVuY2UgY2xvY2suIEl0J3MgdHJ1ZS4gUmVt
b3ZlIGFsbA0KPiA+ICAgdGhlIEhTSU8gUExMIGJpdCBtYW5pcHVsYXRpb25zLCBhbmQgUENJZSB3
b3JrcyBmaW5lIG9uIGkuTVg4TVAgRVZLDQo+IGJvYXJkDQo+ID4gICB3aXRoIG9uZSBOVk1FIGRl
dmljZSBpcyB1c2VkLg0KPiA+IC0gRHJvcCB0aGUgIzQgcGF0Y2ggb2YgdjIsIHNpbmNlIGl0IGhh
ZCBiZWVuIGFwcGxpZWQgYnkgUm9iLg0KPiA+DQo+ID4gTWFpbiBjaGFuZ2VzIHYxLS0+djI6DQo+
ID4gLSBJdCdzIG15IGZhdWx0IGZvcmdldCBpbmNsdWRpbmcgVmlub2QsIHJlLXNlbmQgdjIgYWZ0
ZXIgaW5jbHVkZSBWaW5vZA0KPiA+ICAgYW5kIGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3Jn
Lg0KPiA+IC0gTGlzdCB0aGUgYmFzZW1lbnRzIG9mIHRoaXMgcGF0Y2gtc2V0LiBUaGUgYnJhbmNo
LCBjb2RlcyBjaGFuZ2VzIGFuZCBzbyBvbi4NCj4gPiAtIENsZWFuIHVwIHNvbWUgdXNlbGVzcyBy
ZWdpc3RlciBhbmQgYml0IGRlZmluaXRpb25zIGluICMzIHBhdGNoLg0KPiA+DQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9mc2wsaW14OC1wY2llLXBoeS55YW1sIHwg
IDE2DQo+ICsrKysrKystLQ0KPiA+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cC1ldmsuZHRzICAgICAgICAgICAgICAgICB8ICA1Mw0KPiA+ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNpDQo+
ID4gICAgICAgICAgICAgICAgfCAgNDYgKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAxNw0KPiA+ICsrKysrKysrKy0gZHJpdmVycy9waHkvZnJlZXNjYWxlL3BoeS1mc2wtaW14
OG0tcGNpZS5jDQo+IHwNCj4gPiAxNTANCj4gPg0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+IC0tLS0tLQ0KPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tDQo+ID4gLS0tLS0tLSBkcml2ZXJzL3Jlc2V0L3Jlc2V0LWlteDcuYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiAxICsNCj4gPiA2IGZpbGVzIGNoYW5nZWQsIDIzMiBp
bnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+ICBbUEFUQ0ggdjMgMS82XSBy
ZXNldDogaW14NzogQWRkIHRoZSBpTVg4TVAgUENJZSBQSFkgUEVSU1Qgc3VwcG9ydA0KPiA+IFtQ
QVRDSCB2MyAyLzZdIGR0LWJpbmRpbmc6IHBoeTogQWRkIGlNWDhNUCBQQ0llIFBIWSBiaW5kaW5n
ICBbUEFUQ0ggdjMNCj4gPiAzLzZdIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBBZGQgaU1Y
OE1QIFBDSWUgUEhZICBbUEFUQ0ggdjMgNC82XQ0KPiA+IGFybTY0OiBkdHM6IGlteDhtcDogYWRk
IHRoZSBpTVg4TVAgUENJZSBzdXBwb3J0ICBbUEFUQ0ggdjMgNS82XSBhcm02NDoNCj4gPiBkdHM6
IGlteDhtcC1ldms6IEFkZCBQQ0llIHN1cHBvcnQgIFtQQVRDSCB2MyA2LzZdIFBDSTogaW14Njog
QWRkIHRoZQ0KPiA+IGlNWDhNUCBQQ0llIHN1cHBvcnQNCj4gDQo+IE9uIFRRTWE4TVB4bCArIE1C
YThNUHhMOg0KPiBUZXN0ZWQtYnk6IEFsZXhhbmRlciBTdGVpbiA8YWxleGFuZGVyLnN0ZWluQGV3
LnRxLWdyb3VwLmNvbT4NCg0KVGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+
IA0KPiANCg0K
