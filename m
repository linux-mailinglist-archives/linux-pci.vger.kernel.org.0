Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A8F54D841
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 04:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350614AbiFPCXv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 22:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350500AbiFPCXu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 22:23:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D47A48E76;
        Wed, 15 Jun 2022 19:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8z6KoDN4DoFga5WUXZ+oL9aO5UCcTutw7b50TBjHYdVgXq3tUt00kSGBkh27NQCZ9d3apLAntS2XZXi3OyE3g9/RDPNCex+xQXzJ6Vj4GiYWuWvSjYrf2wOksGXj7yannCHdHOTvwI1sbhzYRZF1dTmxxeDHpkafBc4cxl5bnGykHoorCPaNZNBc0UPgnk4LvJTwyiayAW9v9OhSfW2mXEr/3gCfVTFhPPb/GQye/XSocIqzy/8EZfmRUeODXuwOx10pJlrl4cXRnb5GVJJWOh6IORNW/CsCUpUfVBQCeevK81BwJxeDk3KR/yN5A924Mxz1FgEu5Sc5ORmxs6h1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbe/lMIojvJvVobk3STq0jTWiqStoQzk6bAzXTYMrxA=;
 b=IZ5F3bAnmFZh/lokqhMqqXfp3fsCT9YyuJC6SXEn6K9qj6OpoF8pBSybst0eqZ867vvH0uUXIcMHvdxCt8Pci6UsZiDp8x1KIPW1xhgOmSwL/2KjeK1WpU5E0SfeoW7vCvPs5mLgacQgsm7PIlpAIackWkhl9+lBvKEMVRTHUNjWG2h299E7MPU5W6yQJP/IrpldwcIcIog5348UJxd2Uvm1bt+Xwr4fUyUC4Le/D3czBfE6f0xJWRPtVkHCPFqWbA0Zt7zOImI8aYq1Obr10ouYtWDc7OgZM7rfFdZg5AiuEFXc00fz+oFCvi4TAu9HrRLojHPbAEWCMCEWt1rAGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbe/lMIojvJvVobk3STq0jTWiqStoQzk6bAzXTYMrxA=;
 b=KEVKGbkhGFBy0IYldyW3e/UrnBZJAr4JOEQqBbAcbhyYrRgDNKEyWGRWSnX32zCSqxMXO4S+vScEnuQE9TmtWTBHzQ8jJEUARHkXmFWwRZJyIpNe6nwO+4rkqccAa7SkdVD78DgB2XiEti8cm8fcwFAq3JGeJ9GmCMZoG5jp/fU=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by HE1PR0401MB2474.eurprd04.prod.outlook.com (2603:10a6:3:81::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 02:23:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%6]) with mapi id 15.20.5353.013; Thu, 16 Jun 2022
 02:23:45 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v12 03/13] PCI: imx6: Move imx6_pcie_enable_ref_clk()
 earlier
Thread-Topic: [PATCH v12 03/13] PCI: imx6: Move imx6_pcie_enable_ref_clk()
 earlier
Thread-Index: AQHYgQ3ozjmiTynQvkuidXrHLSBAYK1RRB/A
Date:   Thu, 16 Jun 2022 02:23:45 +0000
Message-ID: <AS8PR04MB867662CB1AD855D1C5E02C0C8CAC9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20220615231551.1054753-1-helgaas@kernel.org>
 <20220615231551.1054753-4-helgaas@kernel.org>
In-Reply-To: <20220615231551.1054753-4-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04d95530-179c-4937-950b-08da4f3f3cfc
x-ms-traffictypediagnostic: HE1PR0401MB2474:EE_
x-microsoft-antispam-prvs: <HE1PR0401MB2474ACA4C093C886027CD6EC8CAC9@HE1PR0401MB2474.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6MbS+lveTmK/zWOaW91FjavvkV5dKYPqjEjOaOxxyxugaO2Mojkjvk5jOvWRVNk+9yb1i/q7U+wgvQvvRQ8aWJgDsvz11necXSMDtWmXf2bSfSWsJsAOI3cbngmU82zYBKRaYNpIdLUStPohj2/vysRKjI/mIbtz8UtQkSYKT6P/S0bUGrDjIV1YeDVHrXleM/Yv6pUs7j6CxTqiykViLw5J6o4PpvQsJgsbz3b6j23b1DiI3fsLC5e5XaP6TqAoOIVIxQaHkcCZ0otEToiAXXmLghRAs7b9cBZGEL2IvYU6fNk93LBb2UmY/9iqRlm6pfoMPvFXjR7BGcdDMpRCd9QtFUWKfFDmiI98/KRI/xFtUDyyikZXA907jvEzV8MthSv6048foA3OkaYOsGAR3FJiEiv+AULchhheR77uTzAkDVjhTkyWej4ytZZFIOqiSIEBGqEiyhFqiMwZth8mO6QPiXp8Ye1ZgVW24dKOJVyA02Awn1dzVCxu4mUXWmUN/MjFQ+TGQ63l+Lx3P6GeUo9BmIYp5ggvJXF0AxYDdw0K+gX19+s9OrZ9lZ30rJhO5QApQMFDlvwZZEr+zDhiGQiG97F7LZ1kimzd3IHpiC7NjRx8xnB7w9dLWEjyz+Qn74rSoW8zzgBfTPod+XXvnNm8MTxpGHY3ZM1Lncfzo7RMr9ldaMdyz3CWWIuioSNyqGH9rE5oDn2/Djafdx4YA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(38100700002)(2906002)(26005)(6506007)(86362001)(52536014)(508600001)(8936002)(53546011)(33656002)(7696005)(9686003)(7416002)(5660300002)(44832011)(83380400001)(38070700005)(64756008)(66446008)(186003)(122000001)(55016003)(8676002)(66556008)(66476007)(4326008)(54906003)(66946007)(110136005)(316002)(76116006)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RVdpQVdweEUwczU4SDR5cHZwTmc1aDA4WTR0U05rRUJsWFFxS0hWSVVxR2Y0?=
 =?gb2312?B?c0lNWDRKY0p0N1Q2Q1RhZk5OTDQzTzU2a3lnVUlCV3RqSk82VWtQU3l2bDh6?=
 =?gb2312?B?T1pCUE5ScWtTaElzQlV4bU5EZXRyekRUeWZUSmdGTXFMNkRtV2cvTmJkNlFB?=
 =?gb2312?B?NnlKNHk4Vk5mOWcwMXpYbCtWVzl4MG52SFhjc3NjOWVlZ3VoeEFHRklPbEcz?=
 =?gb2312?B?T0l6OE9ydGY1MjN2NWRkM1ZzRCs2UUpuVEZyZU5ycEhmZGdoMXdZZmx3cU1U?=
 =?gb2312?B?RHFqUkorNmh6RkZ0TER5Z0twSmpqNEZGNVlEaFR0NHBUY0xQYUJZMGh4VUhQ?=
 =?gb2312?B?Uk5iZTdrd2FsMUJ1YWg5czI0OVpIaEx0dU1vUGNaZ0pmcEhtOXFTNkVIVjho?=
 =?gb2312?B?RW9hRGhUWGtvRzdwTklFdWJOajZBdjNEY0hDZEpsU1UxK1psRkNRa1VaUHRt?=
 =?gb2312?B?S3VLbElJL2IvRzhxekFDWUc0U2c5bkd1RGpmTTdiaE4zQkVYRDRmSm1DSnlG?=
 =?gb2312?B?RElDTFVRbzRNZktOTzhhRFM3a1hDd2U5eUt2VkFZMm5SdkU4bUU2eUV2aUIx?=
 =?gb2312?B?UVpmWldpVmNvWDFXVWNQTzFRTFZ6NVFwNTZ4Q0dvenFkRFFoY3A2TDZ5Z2ND?=
 =?gb2312?B?Yjl0OVJuVDloeFVpZVA0b1o3SmlvQkJTZDU3aW9hN1JIV090L0tWOFdZbjgz?=
 =?gb2312?B?SDkyY0VKTEhCcXNzQTJzNDhTTWNtTEhwVzRmY1k2R2RDTDRsNTQ5bVpOR2Qr?=
 =?gb2312?B?YmQwcnZZci9FYythbEtWY2M1STlTSXpWRjBYU1JSZHNYREc5OWdXVTBidUtx?=
 =?gb2312?B?QTEyY2VLaVVJS0JlWTA4NmlDeVppN2pvVkVIenB3ZkZ6SzdDRWZBMlBSSkJL?=
 =?gb2312?B?aExIbVlVb1h5UmRybU9leHpvME5VTDF3UGhtRlQ2Z1R3b2tsemgvclBoS0py?=
 =?gb2312?B?Q2cxclh1RnEzRHFveXc2TndlYXFyRnE0cTRjd0VkS3FTenA3enNLNG9xd2lH?=
 =?gb2312?B?dVo1SjV1UlVYUTQrdjBJemF6Q21ic2krWVA3NStrdkRBays3UDEvbHJjZmJh?=
 =?gb2312?B?aVVNMEQ1R01jVjMxMUhYd29RL1pVTkdvaUFXaFZ6djJEN1FUZzBMQVJxandR?=
 =?gb2312?B?YTIweS9zY1dxeTJLanlyRmE5YkJrUWxsSTdLUTNoR0lPSWcwVitQQ09NaGx3?=
 =?gb2312?B?eHpsVEZFTk44L2Jyc0Nlamx2aWpHNzEwL0xVaVVPU2VGRGVabnZmbS84R25N?=
 =?gb2312?B?MHY5T3pjd2VZVmlFZ2c4WFlFQjBEMUtwK0tvZXBndEViQVo1cExHMWZVSVJw?=
 =?gb2312?B?WWZYREZ0Y2kvK25rbjJTeS9QVEpnYjFQTThFWWlKUzFkQ3IrRm9WU2tKUTFy?=
 =?gb2312?B?QzM0dm4zbkNPNmEzZThTbjlxWlJTSkQzd21weUxxZElkWExkRGk4WFpMNFVq?=
 =?gb2312?B?dmhkM3lqNFdNaGJDM0ZxRzkvUXJuMHdRWUJNTSswbHRLR0Yrb2tGSHhHY0tm?=
 =?gb2312?B?aW5raGNCRUFMYXJZOFVyT0hpMVErdjFJUjRmUkRNRGRSTEFUeDZiODJ2eVVj?=
 =?gb2312?B?bGRuWnZSTlpLb0xoN0RNUnVlcU9vVXE3M2tPMmMvZXFFMGh3M01jQ1N0dnFS?=
 =?gb2312?B?WlhacUdHeDdxV1F2bnY3YVgwUUhYSmxlazY3YUpQVVdVYy9YcnZoSksxaTQv?=
 =?gb2312?B?bDN5MkFRVXJzLzdiQTh4ekZLRXdmS2pNZis1VlJ2cmRqcEZ2VE5EWndjTE9u?=
 =?gb2312?B?bVZGcjJ3VW50Unl5QklyTGQzMTV6MzFZV01jRVdOd2ZZdUlrcHhnUExqb25W?=
 =?gb2312?B?QlBFS3ZJUzM3QTc0RldwL0Nvb3RUSjVuUW5tUUQrc2QrcUhtTmhOUjBFQmtx?=
 =?gb2312?B?SllSMm9nUmRBbmh3dXcyZmRtYkNlc1pIUVRHdFBsS2JkODY3UXplZW1Lb1ZK?=
 =?gb2312?B?TnlLamJZSkpoTEp1aWJQSHlBeVJlNkRZRVNPbmtKOEFsc2x2VGoxb0VIS2FW?=
 =?gb2312?B?V0lYSmIxMlFTblc5QkFSRjZoekcxWmRZVFlHRndmZ3RaNUJqckRRMno0SDFi?=
 =?gb2312?B?d0NGcXlDc1ZKNUw3aGxhRWZ1c0RkK3B5WlVQaW8yL2hWQ09kMHJQMDhWcnZM?=
 =?gb2312?B?SU5iVUhmSWk0K0t1ZE9RRkM5U0dhR0FaSGRzZ0dLdlJFL1BZU3VzOGdva2Z4?=
 =?gb2312?B?dS9LUU1LQjZmS1RGNlhRa3k3d3NaWlRCTDB6cy9xUXRRUzBVYkNmU2FpNExM?=
 =?gb2312?B?dWVsN1ZNbGw1N1VCV0wwdmFYUW1OWTc3U2xVTE5kUENMbUhVbEZwWEg5d3lP?=
 =?gb2312?B?Qm5iZHJsRFgrVy9Fc1EwTlZaTklJa0JzTlRaVDZrV2RTWER1Rm9CUT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d95530-179c-4937-950b-08da4f3f3cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 02:23:45.0598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AwH6ks6ofW0XM8E3UZt0zkq79XMh+ucLz1v2mfmcEPy6GtoR0Rb1p1U7Oi5I6J80Ltn2fh2rfw3N0vnbrGPfEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2474
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjE2yNUgNzoxNg0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IEx1Y2FzIFN0YWNoDQo+IDxsLnN0YWNoQHBl
bmd1dHJvbml4LmRlPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1hcmsgQnJv
d24NCj4gPGJyb29uaWVAa2VybmVsLm9yZz47IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsg
RnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjEyIDAzLzEzXSBQ
Q0k6IGlteDY6IE1vdmUgaW14Nl9wY2llX2VuYWJsZV9yZWZfY2xrKCkNCj4gZWFybGllcg0KPiAN
Cj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gDQo+IE1vdmUg
aW14Nl9wY2llX2VuYWJsZV9yZWZfY2xrKCkgZWFybGllciBzbyBpdCdzIG5vdCBpbiB0aGUgbWlk
ZGxlIGJldHdlZW4NCj4gaW14Nl9wY2llX2Fzc2VydF9jb3JlX3Jlc2V0KCkgYW5kIGlteDZfcGNp
ZV9kZWFzc2VydF9jb3JlX3Jlc2V0KCkuICBObw0KPiBmdW5jdGlvbmFsIGNoYW5nZSBpbnRlbmRl
ZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5j
b20+DQpBY2tlZC1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KDQpCZXN0
IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpLWlteDYuYyB8IDk2ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDQ4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+IGluZGV4IGU2M2ViNjM4MDAyMC4uYTZk
MmI5MDdkNDJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2kt
aW14Ni5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4g
QEAgLTUyMCw1NCArNTIwLDYgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfYXR0YWNoX3BkKHN0cnVj
dCBkZXZpY2UgKmRldikNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgdm9pZCBp
bXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSAt
ew0KPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNpLT5kZXY7DQo+IC0NCj4g
LQlzd2l0Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiAtCWNhc2UgSU1YN0Q6
DQo+IC0JY2FzZSBJTVg4TVE6DQo+IC0JCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGlteDZfcGNpZS0+
cGNpZXBoeV9yZXNldCk7DQo+IC0JCWZhbGx0aHJvdWdoOw0KPiAtCWNhc2UgSU1YOE1NOg0KPiAt
CQlyZXNldF9jb250cm9sX2Fzc2VydChpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiAtCQlicmVh
azsNCj4gLQljYXNlIElNWDZTWDoNCj4gLQkJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDZfcGNpZS0+
aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEyLA0KPiAtCQkJCSAgIElNWDZTWF9HUFIxMl9QQ0lFX1RF
U1RfUE9XRVJET1dOLA0KPiAtCQkJCSAgIElNWDZTWF9HUFIxMl9QQ0lFX1RFU1RfUE9XRVJET1dO
KTsNCj4gLQkJLyogRm9yY2UgUENJZSBQSFkgcmVzZXQgKi8NCj4gLQkJcmVnbWFwX3VwZGF0ZV9i
aXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjUsDQo+IC0JCQkJICAgSU1YNlNY
X0dQUjVfUENJRV9CVE5SU1RfUkVTRVQsDQo+IC0JCQkJICAgSU1YNlNYX0dQUjVfUENJRV9CVE5S
U1RfUkVTRVQpOw0KPiAtCQlicmVhazsNCj4gLQljYXNlIElNWDZRUDoNCj4gLQkJcmVnbWFwX3Vw
ZGF0ZV9iaXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEsDQo+IC0JCQkJICAg
SU1YNlFfR1BSMV9QQ0lFX1NXX1JTVCwNCj4gLQkJCQkgICBJTVg2UV9HUFIxX1BDSUVfU1dfUlNU
KTsNCj4gLQkJYnJlYWs7DQo+IC0JY2FzZSBJTVg2UToNCj4gLQkJcmVnbWFwX3VwZGF0ZV9iaXRz
KGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEsDQo+IC0JCQkJICAgSU1YNlFfR1BS
MV9QQ0lFX1RFU1RfUEQsIDEgPDwgMTgpOw0KPiAtCQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14Nl9w
Y2llLT5pb211eGNfZ3ByLCBJT01VWENfR1BSMSwNCj4gLQkJCQkgICBJTVg2UV9HUFIxX1BDSUVf
UkVGX0NMS19FTiwgMCA8PCAxNik7DQo+IC0JCWJyZWFrOw0KPiAtCX0NCj4gLQ0KPiAtCWlmIChp
bXg2X3BjaWUtPnZwY2llICYmIHJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUp
ID4gMCkgew0KPiAtCQlpbnQgcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNp
ZSk7DQo+IC0NCj4gLQkJaWYgKHJldCkNCj4gLQkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGRp
c2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxuIiwNCj4gLQkJCQlyZXQpOw0KPiAtCX0NCj4gLQ0K
PiAtCS8qIFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElPLiAqLw0KPiAtCWlm
IChncGlvX2lzX3ZhbGlkKGlteDZfcGNpZS0+cmVzZXRfZ3BpbykpDQo+IC0JCWdwaW9fc2V0X3Zh
bHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+cmVzZXRfZ3BpbywNCj4gLQkJCQkJaW14Nl9wY2llLT5n
cGlvX2FjdGl2ZV9oaWdoKTsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGludCBpbXg2X3BjaWVfZW5h
YmxlX3JlZl9jbGsoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSAgew0KPiAgCXN0cnVjdCBk
d19wY2llICpwY2kgPSBpbXg2X3BjaWUtPnBjaTsNCj4gQEAgLTYyOCw2ICs1ODAsNTQgQEAgc3Rh
dGljIGludCBpbXg2X3BjaWVfZW5hYmxlX3JlZl9jbGsoc3RydWN0IGlteDZfcGNpZQ0KPiAqaW14
Nl9wY2llKQ0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgaW14Nl9w
Y2llX2Fzc2VydF9jb3JlX3Jlc2V0KHN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSkgew0KPiAr
CXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+cGNpLT5kZXY7DQo+ICsNCj4gKwlzd2l0
Y2ggKGlteDZfcGNpZS0+ZHJ2ZGF0YS0+dmFyaWFudCkgew0KPiArCWNhc2UgSU1YN0Q6DQo+ICsJ
Y2FzZSBJTVg4TVE6DQo+ICsJCXJlc2V0X2NvbnRyb2xfYXNzZXJ0KGlteDZfcGNpZS0+cGNpZXBo
eV9yZXNldCk7DQo+ICsJCWZhbGx0aHJvdWdoOw0KPiArCWNhc2UgSU1YOE1NOg0KPiArCQlyZXNl
dF9jb250cm9sX2Fzc2VydChpbXg2X3BjaWUtPmFwcHNfcmVzZXQpOw0KPiArCQlicmVhazsNCj4g
KwljYXNlIElNWDZTWDoNCj4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDZfcGNpZS0+aW9tdXhj
X2dwciwgSU9NVVhDX0dQUjEyLA0KPiArCQkJCSAgIElNWDZTWF9HUFIxMl9QQ0lFX1RFU1RfUE9X
RVJET1dOLA0KPiArCQkJCSAgIElNWDZTWF9HUFIxMl9QQ0lFX1RFU1RfUE9XRVJET1dOKTsNCj4g
KwkJLyogRm9yY2UgUENJZSBQSFkgcmVzZXQgKi8NCj4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKGlt
eDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjUsDQo+ICsJCQkJICAgSU1YNlNYX0dQUjVf
UENJRV9CVE5SU1RfUkVTRVQsDQo+ICsJCQkJICAgSU1YNlNYX0dQUjVfUENJRV9CVE5SU1RfUkVT
RVQpOw0KPiArCQlicmVhazsNCj4gKwljYXNlIElNWDZRUDoNCj4gKwkJcmVnbWFwX3VwZGF0ZV9i
aXRzKGlteDZfcGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEsDQo+ICsJCQkJICAgSU1YNlFf
R1BSMV9QQ0lFX1NXX1JTVCwNCj4gKwkJCQkgICBJTVg2UV9HUFIxX1BDSUVfU1dfUlNUKTsNCj4g
KwkJYnJlYWs7DQo+ICsJY2FzZSBJTVg2UToNCj4gKwkJcmVnbWFwX3VwZGF0ZV9iaXRzKGlteDZf
cGNpZS0+aW9tdXhjX2dwciwgSU9NVVhDX0dQUjEsDQo+ICsJCQkJICAgSU1YNlFfR1BSMV9QQ0lF
X1RFU1RfUEQsIDEgPDwgMTgpOw0KPiArCQlyZWdtYXBfdXBkYXRlX2JpdHMoaW14Nl9wY2llLT5p
b211eGNfZ3ByLCBJT01VWENfR1BSMSwNCj4gKwkJCQkgICBJTVg2UV9HUFIxX1BDSUVfUkVGX0NM
S19FTiwgMCA8PCAxNik7DQo+ICsJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCWlmIChpbXg2X3Bj
aWUtPnZwY2llICYmIHJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpID4gMCkg
ew0KPiArCQlpbnQgcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUoaW14Nl9wY2llLT52cGNpZSk7DQo+
ICsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUg
dnBjaWUgcmVndWxhdG9yOiAlZFxuIiwNCj4gKwkJCQlyZXQpOw0KPiArCX0NCj4gKw0KPiArCS8q
IFNvbWUgYm9hcmRzIGRvbid0IGhhdmUgUENJZSByZXNldCBHUElPLiAqLw0KPiArCWlmIChncGlv
X2lzX3ZhbGlkKGlteDZfcGNpZS0+cmVzZXRfZ3BpbykpDQo+ICsJCWdwaW9fc2V0X3ZhbHVlX2Nh
bnNsZWVwKGlteDZfcGNpZS0+cmVzZXRfZ3BpbywNCj4gKwkJCQkJaW14Nl9wY2llLT5ncGlvX2Fj
dGl2ZV9oaWdoKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgaW14Nl9wY2llX2RlYXNzZXJ0
X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAqaW14Nl9wY2llKSAgew0KPiAgCXN0cnVjdCBk
d19wY2llICpwY2kgPSBpbXg2X3BjaWUtPnBjaTsNCj4gLS0NCj4gMi4yNS4xDQoNCg==
