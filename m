Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27815734D4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiGMLBA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 07:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiGMLA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 07:00:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37B0F788C;
        Wed, 13 Jul 2022 04:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiPYoMh/O/rsCYRm/oE9HgB7WzWhzI9a+fNDrByu6zzgs1Y9/npxaCUjfUI9IuGHY+Ep82IpF1P143UxP33mpkfqTgcXLl6S5Eqqwnisp4aLX9rl763tRs6qZKJM6RfvSiqNxYly/etzgvFKcAuvvtaIOld8fg1msz8uwRgYvcXGWJ78lrv69beUJm+5Ap4EkdyX/toi9syyRt6lF3AzfWlwcheaixVUS+JWI1a7MPlZ7hXaGDOjC1DxVRozPnNMFLDpBLmhDTnurRnewKq7Ds1NYkoGrCj9JrKtDbxqUMyrjifyibm7C+U8KUlVMGlMvefLsTKHLA5K0mWgSMCFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPum2U4+oiVapKbVvdHC0L3mXUjHj9s2uppMBDcYh+M=;
 b=Wd8s0Pz2tJiVAocvRyaTMzxu96JxF+N2lXyRWrte+srCgdWC8+2DVhOPJp61Ea056ExwKovQ92hI8RXgq78/o0xcVsQ7mUisutVFbLUgNGnyuO0z3sUp3JDoSiVm5BJz+GD+bPycJymioA03IjOvaPBdb/p6l+6Jvwx5E1ZAujPoxXfjBLGYlbbJpxbv7ZCb8L7vsBP5jgBtFUPjBWNFYi0fHMxQUgJ24zrR54KXren73n4aMT4ozaPX8VTQHzXfjg6w2gINcMWo4huCD6e6DavuP/dym8jic1O10eom65xBBGDC5baeMm9ASfq1cNIBK8ZUSGVYDr/4O4E8+N4DWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPum2U4+oiVapKbVvdHC0L3mXUjHj9s2uppMBDcYh+M=;
 b=aLQTw5lTlkHx6NBcSdqGZ8SS/hZQSgakXJdyPl3oT/M2vmTgmluRgKS3aIXD/dV62WZ4T3QWW7UuIGJjjgsiORcEayLRHLcTvDbWfTOnOgqQTxs7GHF7M+Onj7CiOeB83wwZqLjB0PH46ukViUdB/9JKQuW6VPurOBxwPE3jO3k=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM5PR0401MB2563.eurprd04.prod.outlook.com (2603:10a6:203:36::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 11:00:56 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 11:00:56 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v14 16/17] PCI: imx6: Move the imx6_pcie_ltssm_disable()
 earlier
Thread-Topic: [PATCH v14 16/17] PCI: imx6: Move the imx6_pcie_ltssm_disable()
 earlier
Thread-Index: AQHYjPxSPiRnYIdXyEu64qyY7Si9pq18FRwAgAAOPTA=
Date:   Wed, 13 Jul 2022 11:00:56 +0000
Message-ID: <AS8PR04MB867670A1741509AACE7360258C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-17-git-send-email-hongxing.zhu@nxp.com>
 <c090c39d171b3bd248dc613c120660f07efc6b6c.camel@pengutronix.de>
In-Reply-To: <c090c39d171b3bd248dc613c120660f07efc6b6c.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c5e1469-47ad-4172-5186-08da64bef617
x-ms-traffictypediagnostic: AM5PR0401MB2563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJggAGh5VhHbINQ8cTHiz1aL10eDHmgeA+Zhj+P48vpUyIQapiYnMilxmRgIIa3xFLA48+6zp9PgMa3pvAIgsYg43mccMMod8YOVarsAv3UZHbz8L15emOREU7q33oUUd8WucOJsHoBABen5eyRa+Ha+3OmTzJwmRw331w8rVUqEnjlDy3sRgMp/v+nmbHhyBCxGRKFz/1p+0IWw2oHKwB+Qmst1Nd/4x+UcNh+fdyGh5wnPzz/S6QSD5uZTgWK88Ya2SLKvCETVm1oq/r/hZ/y2zulgTvdcAcEzPu0Bs3KS0ujXYb6VeXl8WRgWJBY3WmMB0ZxC2NrR2SWK+Pv6JfRaOHaDjnWRBdtP2BYmEBfSY/5jFgJRL+20PaJkmKEFkRxasfwKNJchnp0Y+YXw29Lgy26oBLxja3Tfd1MhlfwRPn2VI4uxyf/jXi+/YJBwqaqjIqmYUwLqYbsbG+16eOargkzu/iaA5/npRx48wVOLxrlU2fMMomErpz5SPK9H857PzIjOHtIKCi4Pu0kC+Dbn/hSWzfQHMmbj7/yfplFaOTsNJS4Ya8S5MkJ+uasCqzhs+F+0bOULrh+JEz/LaxaIEG58fZyGJ6mFlRxNcxERkQAevkNIgSKmo3PED1AqZvES2TAWVQU0o+s+5DFPDslmPFJkurUTLknGKlY6sbyfFdkXCeOJrgbmu7kAi87CTeaVDBCPrkUnwyjBGjI991UGDo5lL1910eO2D78Ujj+QfKTtjhtqkbWUyT6+G0AWF5r2oWSDEHkFXUkdG48g7mU/hdycU3vIjqhwxjCSklPYxX+QBtFx6Qq+yDvWMh97
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(38100700002)(478600001)(9686003)(110136005)(71200400001)(33656002)(76116006)(41300700001)(7696005)(6506007)(26005)(53546011)(66556008)(4326008)(66476007)(54906003)(316002)(66446008)(66946007)(64756008)(186003)(8676002)(55016003)(44832011)(2906002)(52536014)(7416002)(5660300002)(8936002)(86362001)(122000001)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1ExY2hxdjIzY2lKMWt2NHIrc05hVE04QkRadFVkS2pWYy9saEZreFJ1OVRm?=
 =?utf-8?B?Qm84Y08wZTNJUWMxSENOWUg1TlhVYlBlaGUrVlJxOEhOaGQ2U09BRG5ZUjJH?=
 =?utf-8?B?bGhiS3kwSnl1TzlCYkZidHZjbnpqdUV4VkJuMHI3dFUxNG9IbXhtYkRMVC9V?=
 =?utf-8?B?b1JmVVNHQUMyZDBHUkg4YVFVaXJybUhpNTBxd09Ea3JDa0lleENXWGpSK3Q2?=
 =?utf-8?B?RWsvTjBTbGxETEd4RGZRczYrdVdBZWFtR0hDZzJoUVhPQUI3Rm5HYmlrSHpP?=
 =?utf-8?B?bHVBckxIc0FpSFdtd1pxNWg1ZTJUUXE4WXQxS2JyQmlJM2p4a1dDcmluWU1p?=
 =?utf-8?B?SXhOR2V4UXFSd213eWF4RkxCR1l0dGFoZGl1WWVqdmhYR0Nlb0Qrai8vbUh1?=
 =?utf-8?B?RHVNNitzUmxzZ2MwODIzMUVXZ2NiV3FFaDQ4emVTRkdCWktDd1Y0ZzRBU0pU?=
 =?utf-8?B?V0ovU0phWm1MbUN2ckU1eVFqVnB6K1VrS2hBZFlrOWx6dmlueWFqcUJhUlR0?=
 =?utf-8?B?Z081am1rNG0xMUgrZkZ1TVAwdTJyOVdUNXJvdVBwS3V0YndUU2p3ZGF4d3ZK?=
 =?utf-8?B?Vi9jRGk3ZHozaXZ5UnYvekxDell0ZlRiUGoyV3Zoam1iZUhUeDFCWUJFR2dx?=
 =?utf-8?B?ZjJXTTZ4U0g2eng4eHJJZHRndDdLMW5kOHNoOGJjVjdrcHh3bnN6N1ZYOUNC?=
 =?utf-8?B?QnBxZUpITm1MMHJ0ZXgwTDVwaFd1bnBrUHZoSXBaM3Z2NWorQ0s1TUh4d2NS?=
 =?utf-8?B?TnV1N0tXRWJQenBIc1g4SHZIRUwvd2lTcExCQmVXZGw4Y0s5bWQxME1CSWtE?=
 =?utf-8?B?RHQyb1NtRHl2QWxyamxEcCthYzVlWXpxZmx4OG9zUWVNd1ppV1laVTNWV1hN?=
 =?utf-8?B?aTZWMVRwaGl1d0xPMDEyeTUwb1BmVnNsZVdqSWpnU09WRSt5YTJvNVpkTU8r?=
 =?utf-8?B?bnhVVVpWdC95N1p5WXc0M2VMV29EWU5ybmI1bDNGUSsrQ1BEbEVEL2d3OHI4?=
 =?utf-8?B?Yi9NTk9yUXpsZ2VSM24rS2tUR0cxS29xejZISDZ5WFNEMEFuZEc3SmdoRlF2?=
 =?utf-8?B?UFBBaCtFYi9keXFyeGZnUDRwTTdWeHN4RlBlTENvNUVkd2tTbjFBMDY2WGpV?=
 =?utf-8?B?NkJTMVdxTHVobkRYS2lUTjZIVTNsMG04SkNYNjMycWthTENDWVA4L2FaSDNB?=
 =?utf-8?B?NVNlK2lXRDlsWnFhZDZQTjFFMjRjV0xXUStQZVVrUytJOE93ZzdxempramtR?=
 =?utf-8?B?ZVpqc05aTmNVQkxWTy9lL1p2ZnliZkphamdxWThZVnorM2tDblpCby9mWmdw?=
 =?utf-8?B?VUxYbUlydWR6UHhNVExjSTAxRDl1VW95bmtGaXJTeklvdEo0U3o2SldvUEVx?=
 =?utf-8?B?MkZMTXl6aHpXOXMvUWZDdzBtSkt5WXhoUUlpNG1jUWZCVkduZTFNWitibVdm?=
 =?utf-8?B?cWcra21WSXQxWDdrbHhQdE96K1lnMmN4UW5MUGp0d3JNZVRWWjhqMk9PVHZo?=
 =?utf-8?B?Rk43YjA3NXkwL0hnTC9TQjUzeEhzaGhRSXhvV0ZSdERZVEgvNVk0dEw4aHFE?=
 =?utf-8?B?R0ZQS3NLUDloVHh6ZndsbVgyZXJFTlRFbzU4WW1VcFZ3K3dzRmxQWHFwaWM1?=
 =?utf-8?B?WTZKOUNYSkx5R1NyRWZHT1hDd0dJaWF2R0FHM25HRW5wS3hXcjhRNHBJKyta?=
 =?utf-8?B?Y3RGWmF1V2NhYndMYlhSQ2l4S2pzbm5YUW1Rc3JJbG9FOXdObmtZT2lTOXBP?=
 =?utf-8?B?SVZCWWVvdnpRVW0rZWtjOTNkbitQeTlST1BybHlLaVp2MTVQYzZNUWptNW8y?=
 =?utf-8?B?S3I4eEoyK21sbXVGQk1zb0NHWFhrdmorV1VacTRaL2dKd25xYnVaeE9KbFh5?=
 =?utf-8?B?VE9UN0NkdmhNZFNEdnBHeG0vdjY2bjFGa20xZHpsZXNnN1FlWmtZRUZ3SjZM?=
 =?utf-8?B?MFJ5ZlRCc2RSODlsSzBPdzRHaU9hR2Jib0N3MGYzVEw3VlVPQlluUi9DUTdE?=
 =?utf-8?B?d0xpTnVRdUgrRkkwVVViZ2pPR3RMaktYODcxditpNHA2S0d1b3lQNTYzK2RM?=
 =?utf-8?B?T1pmOFZpcENnWk5qeUdpallOZlRCQkYyWHUxMFZBNG51S1J6WXJYMWdFRFNN?=
 =?utf-8?Q?I8pTGhE7uP+sa1UofHy3MfV3k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5e1469-47ad-4172-5186-08da64bef617
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 11:00:56.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cenJErB4nNQ0PARYfHVlF6DFiVpUZFUH4tquS1kYqgNdDqFlqSxKKEqq3HLKC9cryL8OGuvTxXly1B07/79RQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2563
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDfmnIgxM+aXpSAxNzowNA0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTYvMTddIFBDSTogaW14NjogTW92ZSB0aGUg
aW14Nl9wY2llX2x0c3NtX2Rpc2FibGUoKQ0KPiBlYXJsaWVyDQo+IA0KPiBBbSBGcmVpdGFnLCBk
ZW0gMDEuMDcuMjAyMiB1bSAxMToyNSArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IE1v
dmUgdGhlIGlteDZfcGNpZV9sdHNzbV9kaXNhYmxlKCkgZWFybGllciBhbmQgcGxhY2UgaXQganVz
dCBiZWhpbmQNCj4gPiB0aGUgaW14Nl9wY2llX2x0c3NtX2VuYWJsZSgpLCBzaW5jZSBpdCBtaWdo
dCBub3QgYmUgb25seSB1c2VkIGJ5DQo+ID4gc3VzcGVuZCBjYWxsYmFjayBkaXJlY3RseS4NCj4g
PiBUbyBiZSBzeW1tZXRyaWMgd2l0aCBpbXg2X3BjaWVfbHRzc21fZW5hYmxlKCksIGFkZCB0aGUg
SU1YNlEgc3dpdGNoDQo+ID4gY2FzZSBpbiB0aGUgaW14Nl9wY2llX2x0c3NtX2Rpc2FibGUoKS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8
IDM5DQo+ID4gKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNzlhMDVlMTkwMDE2Li4xY2Y4
YmY5MDM1ZjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMN
Cj4gPiBAQCAtODA1LDYgKzgwNSwyNiBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfbHRzc21fZW5h
YmxlKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gPiAgCX0NCj4gPiAgfQ0KPiA+DQo+ID4gK3N0
YXRpYyB2b2lkIGlteDZfcGNpZV9sdHNzbV9kaXNhYmxlKHN0cnVjdCBkZXZpY2UgKmRldikgew0K
PiA+ICsJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlhbnQpIHsNCj4g
PiArCWNhc2UgSU1YNlE6DQo+ID4gKwljYXNlIElNWDZTWDoNCj4gPiArCWNhc2UgSU1YNlFQOg0K
PiA+ICsJCXJlZ21hcF91cGRhdGVfYml0cyhpbXg2X3BjaWUtPmlvbXV4Y19ncHIsIElPTVVYQ19H
UFIxMiwNCj4gPiArCQkJCSAgIElNWDZRX0dQUjEyX1BDSUVfQ1RMXzIsIDApOw0KPiA+ICsJCWJy
ZWFrOw0KPiA+ICsJY2FzZSBJTVg3RDoNCj4gPiArCWNhc2UgSU1YOE1NOg0KPiA+ICsJCXJlc2V0
X2NvbnRyb2xfYXNzZXJ0KGlteDZfcGNpZS0+YXBwc19yZXNldCk7DQo+ID4gKwkJYnJlYWs7DQo+
IFRoaXMgaXMgbWlzc2luZyB0aGUgSU1YOE1RIGNhc2UuDQpIaSBMdWNhczoNCkdvb2QgY2F1Z2h0
LiBJIGp1c3QgbW92ZSB0aGUgZnVuY3Rpb24gcGxhY2UsIGJ1dCBmb3JnZXQgdG8gbWFrZSBhIGRv
dWJsZSBjaGVjaw0Kb24gdGhlIGNvbnRlbnRzIGFjY29yZGluZ2x5Lg0KDQo+IA0KPiA+ICsJZGVm
YXVsdDoNCj4gPiArCQlkZXZfZXJyKGRldiwgImx0c3NtX2Rpc2FibGUgbm90IHN1cHBvcnRlZFxu
Iik7DQo+IA0KPiBEcm9wIHRoZSBkZWZhdWx0LCB3ZSB3YW50IGEgY29tcGlsZSB0aW1lIHdhcm5p
bmcgaWYgYSB2YXJpYW50IGlzbid0IGNvdmVyZWQgYnkNCj4gdGhpcyBzd2l0Y2ggc3RhdGVtZW50
Lg0KPiANCkdvdCB0aGF0LiBUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0K
PiBSZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3Rh
dGljIGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKSAgew0KPiA+
ICAJc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llID0gdG9faW14Nl9wY2llKHBjaSk7IEBAIC05
NDcsMjUgKzk2Nyw2DQo+ID4gQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkd19wY2llX29wcyBkd19w
Y2llX29wcyA9IHsgIH07DQo+ID4NCj4gPiAgI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiA+IC1z
dGF0aWMgdm9pZCBpbXg2X3BjaWVfbHRzc21fZGlzYWJsZShzdHJ1Y3QgZGV2aWNlICpkZXYpIC17
DQo+ID4gLQlzdHJ1Y3QgaW14Nl9wY2llICppbXg2X3BjaWUgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gPiAtDQo+ID4gLQlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0K
PiA+IC0JY2FzZSBJTVg2U1g6DQo+ID4gLQljYXNlIElNWDZRUDoNCj4gPiAtCQlyZWdtYXBfdXBk
YXRlX2JpdHMoaW14Nl9wY2llLT5pb211eGNfZ3ByLCBJT01VWENfR1BSMTIsDQo+ID4gLQkJCQkg
ICBJTVg2UV9HUFIxMl9QQ0lFX0NUTF8yLCAwKTsNCj4gPiAtCQlicmVhazsNCj4gPiAtCWNhc2Ug
SU1YN0Q6DQo+ID4gLQljYXNlIElNWDhNTToNCj4gPiAtCQlyZXNldF9jb250cm9sX2Fzc2VydChp
bXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiA+IC0JCWJyZWFrOw0KPiA+IC0JZGVmYXVsdDoNCj4g
PiAtCQlkZXZfZXJyKGRldiwgImx0c3NtX2Rpc2FibGUgbm90IHN1cHBvcnRlZFxuIik7DQo+ID4g
LQl9DQo+ID4gLX0NCj4gPiAtDQo+ID4gIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9wbV90dXJub2Zm
KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkgIHsNCj4gPiAgCXN0cnVjdCBkZXZpY2UgKmRl
diA9IGlteDZfcGNpZS0+cGNpLT5kZXY7DQo+IA0KDQo=
