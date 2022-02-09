Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81E64AE6B7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 03:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiBICkQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 21:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiBIBOB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 20:14:01 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80088.outbound.protection.outlook.com [40.107.8.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ED9C061576;
        Tue,  8 Feb 2022 17:14:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9vPNnHkQPxXWU/V5iyhYF/dOFNO1frUjz8GhDElEAtmG65FrN7ib2KQN2/OO6hFTYXnNUspHfot+nRnLqcplADgE9Udj+x1///RUAlHIj7j7Zeu0JMq24NbI3oB1qXGsmwfwTIpGI4UUPyCHUTkuyiilicAcxxMuEoAJW4lWjfURwQuM2QLJOqGEvBA/q0JsZFD94UTlH2wVYDZkuRNkh3bcWFJ34pvK0IsGrWyay5tjY4uNTHbXIf3xV4n4p0JuPXoFOW+W90r9AR0VhSjfZrfZVsoXsweTOBV6/33zHwerBcitwneOKy89hPicx3PdYrc0K/ndvU2+67PukdFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQXZrJjDho3CkfGMiQTeSwc6PyT79kFoINEEA897ics=;
 b=cNQ2EFF7vC4nlT1rWyB9dtDdtuKR4ekHEKg91RkoOo5YxqjJ+AwJ6sML57cZGd07fGNnAbkB+mc2z3LOe+7Tynofw9ZyO7wChL78602eGDku4Ou5eaIxyaPnlyqs63qzXnlWr+2nKdlvMQfU71Jg7hDVC2p1NRb7YHLb3T60eDYz75bsuMdFq/dmNg7PnlNEEDoGUuA4xCpagcEXG+BgV4hoIP9MCJNU8G8J6bUe9HRLnTkjHoI8J8b3lLmef9in3Rtw6bxke3ub2cdM/N36s4+UhswdoWc7+rVS42dYZ8i824ijXkJe+E19CSlBE1DSQAA0aNxEk3RANeBQZuSzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQXZrJjDho3CkfGMiQTeSwc6PyT79kFoINEEA897ics=;
 b=ZWrcOE6SZ2rtet19WZBHFWilK/j283NUy0q5T1IvTAgV1FulZVldseDeS/ynELya8kRSEZtdHw/oW+ThuxQshKR1bM+a86ZwHf7TfewpjyEXJSvq5QMnFbdLZXBUzj1FWmQ5tJpeP8IufsWpHEtLzt1uQvChkFtwOuR6LQecM50=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB7PR04MB4731.eurprd04.prod.outlook.com (2603:10a6:10:15::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 01:13:57 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::3d1c:b479:1c58:199%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 01:13:57 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8mq-evk: Add the second pcie port support
Thread-Topic: [PATCH] arm64: dts: imx8mq-evk: Add the second pcie port support
Thread-Index: AQHYHL478A5x4pYXYk2bRHRRI0RDl6yJx8GAgAChFkA=
Date:   Wed, 9 Feb 2022 01:13:57 +0000
Message-ID: <AS8PR04MB86761F289DE7261AA6560F178C2E9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1644303749-4610-1-git-send-email-hongxing.zhu@nxp.com>
 <20220208152911.GA477654@bhelgaas>
In-Reply-To: <20220208152911.GA477654@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9473ab2-8c21-4c16-aae8-08d9eb6972a4
x-ms-traffictypediagnostic: DB7PR04MB4731:EE_
x-microsoft-antispam-prvs: <DB7PR04MB473172A9048CBE0ECEAE2A9D8C2E9@DB7PR04MB4731.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UEYWtaCJYAcZa3FxcPL/4d7njrQA0obmOWNKKD7d0pmTO8K9MQ62oMI6PQQLQ5rqduZLMpi4aAGzS2qa312R/JAMhPvMgtc6uSpZTSLeEhjeJvFFgs2hkLB4k7zVeGcPMD+WFY1iEzyGXY6WdLTiwgsaQcryC2V3OBn1pOqA4qNfkUWf8wlC6fPiHDUvKDX2kr42nw0UtZjRO+pz1JbLvaUA/7Ew8B6mIP74Nl/1tPRHI3iqMqiLwyT15WCW96d7fyxlaG52aAhZHTiYu3rdqdndLqHs3IVVicisPX3Hd7wKy0wT9foO3JR2izVaudlmaCQgx8PQQZchyQNgNEj8DFBfqikVWC1adzfuRpfIRxRSaZsFcaHIJBA7V/W1VWCprnjJSWLokUwhc272s6lhk2s5hKXjpdFTatIk8Ex1Lu13VgSw9H3963QZuFNyiFjFRc9or0Ai9iBwC5v5p9mwSo2UePn/96T41jphFsfoR2XZ47MXFJz7O9kcXNOUt55S5fLzZkhNHEOg3CJwTV/7tYT4m+ayEjLDdfWIRC/AO//oTqCCuYPueaEyLCqn96f9kF4UYFaH9SWqcx2ICn+kxnggUidInr70/GSr5pESaqrPjUB84zvG2ydpeIxnYNYt4DNfe3P/qe0TEh5yE1+6KcHYsLAewUu82lYxU2WsepjpMq14nb4gS/hnhHJTjTIRci/eBjM2+BjTyD2pH8/e+1DPwJOyqfbAuK41bvGLoqY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66446008)(66476007)(66556008)(8676002)(64756008)(122000001)(66946007)(76116006)(53546011)(7696005)(4744005)(508600001)(6506007)(54906003)(316002)(6916009)(9686003)(2906002)(186003)(26005)(83380400001)(38070700005)(38100700002)(33656002)(86362001)(55016003)(8936002)(52536014)(71200400001)(5660300002)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UDc5Q1RmWmJxTG5ITWU3SWgxTG5kOGlQbjBycDVHZUw5VnN3RVNHWVo3ZnA3?=
 =?gb2312?B?SnJGK2FqLytSV0VHYjQ5WENYZWZVc29vUDA5ZUZoQkEyL0xISXliREJMY0hB?=
 =?gb2312?B?ZnFBZkt6N1pYVUVqbEhXMEJCNTdTTGN6UUhxcndOMHBFQ09vYnUzTU4ySTZU?=
 =?gb2312?B?VktsdzNQMTFGVXgxRVhOT2o3ZzN1cnpLekVTT1pVYk5GaE5IRzIxTkJXbzlI?=
 =?gb2312?B?NDVxRi9weVJlZkR5WGpqdDQ0M0E1RVZxM3U5ZHdwMVM1Vk1iQ2trbFFyYXFD?=
 =?gb2312?B?blhaLzBJVk5iaitGZ1h4WU5aK3J5V0cyRnNPUy8rQUZLRFJteUViUStXL2Vq?=
 =?gb2312?B?dzAreDFWdDd2MCt5TjVIMFdEVktvdEZnVE5GbWhDTEhDNU5CV2RNczloNkxW?=
 =?gb2312?B?Y0tGVXhwd3NHTHVLbVpmWElpYTdMY2VtaEE0VXJVUEFEM3oyUEV1TndQSko3?=
 =?gb2312?B?WFpwL045Q2IvN1VYbGxtaEZyY0x6SE85VjdYeHJLZ3BXNkcrSlNVOUg2RUVH?=
 =?gb2312?B?OEJJUDlyemU3U2FMUlQ4RWJLQ2tXbjRZT1l3alBST2hpbnVId2JYS1pwS3dk?=
 =?gb2312?B?K0FkeW1NREk1NVliQmdMa0QxY2piVWxTUUxBanhqSjk5RnkwazBGZTJucHJP?=
 =?gb2312?B?TEpjc1QwWDYzUUVORmd2SjlONWJ5NmZuZm50V2JSdHdmUkJVTEU2Zi85WW15?=
 =?gb2312?B?cnliVC9OcUxDSDdRaksvZmVZblJkL2c2cTN0d0dVOVBBRlQrSG9HbXgyUVN1?=
 =?gb2312?B?YVVxa1ZJOWpZamZYdDNGdmI1VzgvbXBOdXlpWS9CckZzLzhZb2s5K0R1VGxp?=
 =?gb2312?B?MklwWCt5YTMrdGlwa1Z6dFh0NFQ2eVQxZWdhbVhENjhSbXhGVUhmWkdjMXoz?=
 =?gb2312?B?LzhwbnRwRm1WTjR3OVpDcjFubWQrVmUrQzdXQ09aTDMrZ1VsS2VMTnVjTXV1?=
 =?gb2312?B?N2c5RFZQVkQzaXh0YzVSK1RLWmhDMjdVY2tRQVdXK2plWXBqdzdKbGRURzVX?=
 =?gb2312?B?NW16ai9UN0xCWVVBQjU5NTM2dWoveENHT0RHUE5RdEkrb2tISEt5MjViTG1i?=
 =?gb2312?B?WDh1ZnlNQUcydTJnQUIzdTBmUG1HUGd4VWRoek5WNFNMak5aZVpTL0hrdmtD?=
 =?gb2312?B?NjdMN0gyUHJaKzNJeFVmSjNha3Yzdzdhb1lzWjVpeVQ1U1VBUHB3N1RwQ0k3?=
 =?gb2312?B?R0c0dm80YUxYVnNGMlRUVGxVUFc0QmhBalV6MEdKTkdVREdFcHNzcW1ObGlB?=
 =?gb2312?B?alhtTnZhR2tDbVQ3ZTg3SWFXb05yeEJLQjFpdFBHa3MwYVdkWk55b3V2VXd5?=
 =?gb2312?B?RUhmZXp3YTZoYkJBRVdHQ2IvRTNZOTZld0w2V0ZHMkhtTyt5bUdnVTVjUFBF?=
 =?gb2312?B?NzlkcHpySFJLK25kNnhiRmozcTFZT1UzTEhxQ0crTUwwTGpNYkxER0NmV0xN?=
 =?gb2312?B?SUVjQXB1dTg2eFpPN1hpY0dQL1d3RXN0T2ZtODZzUHNkR09zZUNtVVBsZWQx?=
 =?gb2312?B?ZDdMZU5SVVZGYjlkM1l4N3Ztd3NYRGpydU41YnVObk1sczRPMnJLZ0NycDhy?=
 =?gb2312?B?OHFiQ0k1djRSYnVMcDBDaXh4Qm1zOVlVMlR6SWxDMmtaby9zOC93djE2bDhO?=
 =?gb2312?B?TnlqNmd4NHBRcmJRMmUyaW1sdktmcnA2UW5pMlgwOGRGMFdsZ3F6Um1nQlZ6?=
 =?gb2312?B?WWllSVVlREllSjVLQ2dRbFVqeVhFSUFGZlF1bnlaeCtXOEt3eVBaNEtsaVJn?=
 =?gb2312?B?bmlSYW41ZytLaEVMTmlvRU5sKzFoR3hCRk55eVNFWmM0dlZabmRIa0Y1b1Vi?=
 =?gb2312?B?cndkbkhWeXpleVU3dWE3STZnR0xOYzdlT3NWYUdxeUxBclduWXJkL2lqdERD?=
 =?gb2312?B?cHA3MXJhdy9hNzlPb3MvenJDOHRoTVg1MEJZOGYzWkFTTENpT2JQWW4wdjBv?=
 =?gb2312?B?RTlaenFRSVlqRnpINFVpeVJHZ0V2VVBjOTZrNmdPRE4zYTY2UDFMd0VYaVg1?=
 =?gb2312?B?OG4xZnlLaW1WaDdqb09xaGJRT1BERVBycWJDZDhncFJkZkozNmNDUmJ6UHJO?=
 =?gb2312?B?cTE0eWdNSVlGWWVxNGNRL3gxYUl5ek5iRmZCeEJEd3BpL2ZkR3dPMGVCR3dy?=
 =?gb2312?B?TGl4bmRNcHpwd01aR3ZvY00wNEdoaENIaWdOQmJhc2FLN3FYSnlHMkFReDdx?=
 =?gb2312?B?R3c9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9473ab2-8c21-4c16-aae8-08d9eb6972a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 01:13:57.6186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5daQTPlncsKxZTWqt/YA28fLRm6ub4PFCK5JwGPEbwlfbouVfFMAp4nzl672nRkymeVNnfIMdO936IKJvPQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jLUwjjI1SAyMzoyOQ0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBhcm02NDogZHRzOiBpbXg4bXEtZXZr
OiBBZGQgdGhlIHNlY29uZCBwY2llIHBvcnQNCj4gc3VwcG9ydA0KPiANCj4gSW4gc3ViamVjdDoN
Cj4gDQo+IHMvQWRkIHRoZS9BZGQvDQo+IHMvcGNpZS9QQ0llLw0KPiANCj4gT24gVHVlLCBGZWIg
MDgsIDIwMjIgYXQgMDM6MDI6MjlQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gRW5h
YmxlIHRoZSBzZWNvbmUgUENJZSBwb3J0IHN1cHBvcnQgb24gaS5NWDhNUSBFVksgYm9hcmQuDQo+
IA0KPiBzL3NlY29uZS9zZWNvbmQvDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcXVpY2tseSByZXZp
ZXcuDQpXb3VsZCBiZSBjaGFuZ2VkIGEgbW9tZW50IGxhdGVyLg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkDQo=
