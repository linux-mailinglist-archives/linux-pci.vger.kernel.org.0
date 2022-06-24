Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4928E5590AA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 07:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiFXFFG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 01:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFXFFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 01:05:05 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30044.outbound.protection.outlook.com [40.107.3.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6FA4FC54;
        Thu, 23 Jun 2022 22:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LUkbS7dKSDIMeWbgseCB5/Y29fK4yH3pLvabN6Drb8tYzetwhTd2Einc/jkyYEv/3OWEwpsMxAF6o+XG5kfrmNWGkd8Ilg3jB2CTGEiSCNc6GjSHEx8BVeQeEoY4q4NL/elIa+7E+6zEBDxLL1DVC23KGP+AznwOKAuN1ME4er4ThJWPZ1ScDOaVj6B1oJg8u8QY1VGxcRfFTKk2SNgjSGH+UYQIuqzxeEhpSWJwVGuU7q8Kl76ttqBH/ZXFx+LUk10K7n+pUfnOBdrJhSkO8C3lwEL+gw22GLNkKWnjL4gOkGGeqO/N4JDvHH6HKyGolKycXrtLiH54ZBAOBXrtDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUfSlEP1sJRUNRRbVm4g8GYVa5g8Vpg0U8YW35SMqAI=;
 b=hXqyp3e8M7P9RkK9W940ipGTrPUz15I3vuV2BjyGyHsXwgrhoxkjYeP83NpIRjZfF4llmPgOE3j8Hj9AzFhWXzpoLO8aG93V47CqLzVXarJOlHujkvOQXuvA803f2n+DvWl1T6grcSFZPreX65Gyr8FbCG8TG/ZnR8qpesS8ztAKEw/ZfQu2r6pzh0YBpyeIKUVV7kT/61jHJYecCe4W+hg8JGnuIYesq0P/yHuvtvHFI1fq/W2WqTZb4LLCVAkVWKZ4uyXGLc0p1Pl+zLGyYvjxngaftJ27gi461dv55g4JkpWGgDpqvy5sM0OqakGxF+Swbxm+T+R7YLGVogzfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUfSlEP1sJRUNRRbVm4g8GYVa5g8Vpg0U8YW35SMqAI=;
 b=RygRXRebA0HoDKjJop4x2W6Pi3naTiaTo+U8SWuM9c9CuBi23xxiEVjW0a/gL5eeKqVRv1CWGIQFsv0IVP6V29WsTsT0YQ4s3snN4L/ptT713GYnCMcbPrfEGoXpP495lKma2xEahYgujgYmdeYvTk9xFk0qa2HsHUC+VxyOgZA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR0402MB3904.eurprd04.prod.outlook.com (2603:10a6:803:17::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 05:05:00 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::a0fa:978c:2b40:2cb7%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 05:05:00 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v13 10/15] PCI: imx6: Turn off regulator when system is in
 suspend mode
Thread-Topic: [PATCH v13 10/15] PCI: imx6: Turn off regulator when system is
 in suspend mode
Thread-Index: AQHYgjdcUQJgMZ5OO0yRoK73B1k2ea1dmj8AgABrJkA=
Date:   Fri, 24 Jun 2022 05:05:00 +0000
Message-ID: <AS8PR04MB8676C6B250ECFC44E120D8188CB49@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1655461874-16908-11-git-send-email-hongxing.zhu@nxp.com>
 <20220623221944.GA1481121@bhelgaas>
In-Reply-To: <20220623221944.GA1481121@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5596b6b-d70c-424b-8152-08da559f1735
x-ms-traffictypediagnostic: VI1PR0402MB3904:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ydGTnaAS8y1zNtG5czt4hW3vBBrs14RWtH0UA7f6VLirHE2eH9oj9BrM6dsThddhFn1d8JTy7qQvV1GQe61mHoA1FVc/RzHoQgohsKrv8mRsxbfY32HFCZQsff3KBadhgWwXAlMndtcB2WOJL/+Bg8L+B+C6HuJU8bFzW5Yl9K8rPoyW/fRQdbSXCBrOWyf6Hq+E69VpCq3ZRcKxF3UJTFLbUugiBJaapwupwgq1F0jHp1QzhZFphjvG/uPZKnuQywjsPn01IlmN69iuMUOaYw3/+vnYZxcbpyEmxpK+Uj3vARpH4tAsaG1sC7llEiRA+PzI1IXFc4MDUpygvGIgd7dJYadBGQwGZ8rHUK/gcGcr+G2jxbyVxL2p35e6DUldupSVJJzy5AR7rD2oTjfltxU7FF8m+9Ki4etGhQB1LFHKu1pV/Kc7S5kQUx6BS0lt29eAF2DXWqjGSXiVLzvVFuyBlCmc/sHxglfGrDMCHpfaVmPlFr4cH655vzsHGqPwlHyWnfDJ2H1nDJG6Uji0ZYOa26mTC82Zp+3SvfqrI4Z04Xu9PzLl7c995xOisFxMep4zzHOh5r/pgE+OGmPvvWmJ78ec7M7G3bN2OcWKKDNMuvht5lFUsWq3HrLAZJ4i6z5CTFAGbCL3uOBkffzeGlZTaWJ4cnopGFMa8jVCimia5NlScPN2whfYvQGHlSS51q3ygYiSzCYpsFaKQGsMLkLEYwz+Qxo1xU4LTzpGqOyVLIDlXqG4lDoPraRkiCt0j1ot0x2VBNdmUX+A903sbEFt6/NlkbkpvwrcpJgzqJiYSwwprFXbpm9NYLix97J0ITup0IMyoD5LuwghInMnEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(86362001)(6916009)(6506007)(8936002)(38100700002)(7696005)(45080400002)(26005)(38070700005)(186003)(122000001)(71200400001)(9686003)(41300700001)(53546011)(83380400001)(54906003)(7416002)(66946007)(316002)(15650500001)(44832011)(76116006)(52536014)(5660300002)(66556008)(55016003)(64756008)(33656002)(478600001)(66476007)(8676002)(2906002)(4326008)(966005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Vno1VzFqTzlqanhOQVdZQ1RKRFVHcWRoeFFXaUU2Tm5qNDR6cEhSTUpqT1JB?=
 =?gb2312?B?TWJ4aS9nYnFzeUZjVUZ3YzR2bTFrWjY4MEdUMkFBQ01ZZmswMVR0WC82d2w0?=
 =?gb2312?B?WDQ1ZWE5ZzJ3UjhqbVprRDhRYytVZU5jTFI0TVZRVHJyTGNHSS9GR3pFZk5H?=
 =?gb2312?B?MUs4TjdjUWVpcUdXUmQ1YklxY255aXRJQWM1Z0U0Y3QrWXRMRWljVzdtTTUw?=
 =?gb2312?B?d3BOK0VOSk5Pd3V4OFJ5V0FLbXUwR2t3V0twc0JTc2hOZVN5UW1EQkVYNWV3?=
 =?gb2312?B?NDNrTGdJbDhCbGRDeHFuZVlqUGRzdXRuakZMT2l0a0xuUkwwUmJrbXlnNGh3?=
 =?gb2312?B?MXNhNElqTEZMQUx5RjUwVGpQamZwUDZzYnZwU0V3ZEJGYTZYSS9KaEpBWDhX?=
 =?gb2312?B?eTNrb3RMc1EzK3dtWGpqOXVEWDZHa3kyYThXTDZGK1laMm5JY1V3aDRKTWNu?=
 =?gb2312?B?RCtVNkxSRnJyR1djaDJucHY4S1B6M1dUMEQvVUdqZWVRMHVlUVdxOEFIbExO?=
 =?gb2312?B?dEhKQXBNK0VCSkwza1dEYmxGYUQxN2xzYzloMGpBSko4dzBST1VpWU5Xa1Ex?=
 =?gb2312?B?aHYvOFJ6L0tmRG85d0w1UHdCQlFnUWh1RGZrQWEzVnpJVG5xdEJQYmhtcjdX?=
 =?gb2312?B?bU1FVFhZNHNUckgwQThmLzdzMmw3VHFwdXM2cnp3ajZaV2ZRZXdDZXFZdmht?=
 =?gb2312?B?bFVLaC90T1pKaGRQRk8xMU1KTWQvekNNdW9ObzVTSGZGRWxOV205WnF2N1ZG?=
 =?gb2312?B?L0ZxMktiYXg2WVIvVHc1TkNWM1VONWozaFhka1J6VmtKS3ovNnNRWWVMS2RH?=
 =?gb2312?B?cS9FdDJDd2IzSmMwYzEyWi9XUkc4TDdnSVVVeHJjdGVEcjJrNGkyTmZjM3Zp?=
 =?gb2312?B?WmxrcGJOM3dZYmZkb0pqZmMyUjZTaS8rU1V6UG5QNU1hc0pBdE1yWXkwSTNT?=
 =?gb2312?B?K29HWnN6WXRjT0ZtRlJLOUowNkpxc25IMUZaRVpuTklaK3FvVnhMSmNPQ01H?=
 =?gb2312?B?ak9ZMlRaN3hWaDBsd2hOVlJBWmlUU1ljU2xRVFhpK1g2YzdGR20rODBJYW1l?=
 =?gb2312?B?THFQZE9FalkwWkEwV1dsaVlLc3MxWE1tQjR0T2hVQW4yVGt6TGlmN1pEdlNS?=
 =?gb2312?B?V3NEb0JnWCtOWWZ3bExkMFpaSldERUVCZDVPZDEyWVA3citEa3VscTlvRnFR?=
 =?gb2312?B?QkVTSGprUEd6RFN3alk3aDg3SkRnQTh4ZEJXNkhUdGx1TlJWWVI5RWt5U3lw?=
 =?gb2312?B?QkZLalNGZEpXNG9FbEZwQUtBcFNiTUI2RGRkMXlrckRtZm4wV3VFOG1WTlVY?=
 =?gb2312?B?bm5TQiswSlREQUNyMEQxVmN5eWlPbXRKdWhnYm9obGM2ejlFaWhqK1QxTmZq?=
 =?gb2312?B?OGxCVlRscjMvdDIyTURjUStGYTR5c3A3ZGdzTWZMRDVUdUVmYkdIL1NxOE9u?=
 =?gb2312?B?WlJUUk5PUFFWQm4xODljMHpBdDhoWVJ3SGJyVVd1d2Y2S29kOGJyUWU5ci9V?=
 =?gb2312?B?OGZoQ09EYlliTmpsTGNtTlF4NmZ6cUJhdjBtakNNYXE4TmR0d3UzTk5wTlE1?=
 =?gb2312?B?UlV6d3RDSENOOU90dUlwU3NMR0ZYM1hJODBtM25hdk15THBQSnl3UTMwQ0hw?=
 =?gb2312?B?dHFOcklOYUwzUWc5OUF4ekNTTS9Yalk0N0s1dW96VWIzbmg5QmNPcFNTNU93?=
 =?gb2312?B?RDdqb2s4b0RZRmFML243R3RPZmtIRnU4UlJnYVJjK2t1cHVhVmJWZ0ZpTmk1?=
 =?gb2312?B?YUN6Q3RsSWN2VGJkRC9jKzJwbDcraG1yYjFMRHpIVk9lcVVSMFlRaTdCWUw1?=
 =?gb2312?B?WUFOVzV6TDhYSzAzVklZR2x1N0JOV2pndTRjZnAzcXo1cmRkMEYvYnp1aXVJ?=
 =?gb2312?B?UFN0Z0Zlc1kyZFc3NlB4R1dsTjJaczJKd1RQZGZpOFYvNDZXWWF0bm5iSUk5?=
 =?gb2312?B?MWZnanc3VHBnUjNheGdHT1E2TkFlaG42NWV1VGw4WTI1YXVDa2lSQ1Z4b081?=
 =?gb2312?B?eW40d3FKcVp3SXZiemR4bjhLWktHRU1DMjZ4SUhwYlZKZ0lQZC9Ga253MXBM?=
 =?gb2312?B?MVExQThDb2lrbTFYRGhyWG5JbDhSVFZnOVVUWElyS1hoSjNodE5YcitQZngy?=
 =?gb2312?Q?PpRF0Ani+5sw57B26mmwb2liY?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5596b6b-d70c-424b-8152-08da559f1735
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 05:05:00.3265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ogQ179gz0DBkfGAUJNaxi+sANziSJsXJyf+/aDhj9q5Y9wp9pkMr/9k1AAYijEvFqyNlIW19IjUBtMrFEnY1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3904
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jbUwjI0yNUgNjoyMA0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYnJvb25pZUBr
ZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBmZXN0ZXZhbUBnbWFpbC5jb207
DQo+IGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXguY29tOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14
IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTMgMTAvMTVdIFBD
STogaW14NjogVHVybiBvZmYgcmVndWxhdG9yIHdoZW4gc3lzdGVtIGlzIGluDQo+IHN1c3BlbmQg
bW9kZQ0KPiANCj4gT24gRnJpLCBKdW4gMTcsIDIwMjIgYXQgMDY6MzE6MDlQTSArMDgwMCwgUmlj
aGFyZCBaaHUgd3JvdGU6DQo+ID4gVGhlIGRyaXZlciBzaG91bGQgdW5kbyBhbnkgZW5hYmxlcyBp
dCBkaWQgaXRzZWxmLiBUaGUgcmVndWxhdG9yDQo+ID4gZGlzYWJsZSBzaG91bGRuJ3QgYmUgYmFz
aW5nIGRlY2lzaW9ucyBvbiByZWd1bGF0b3JfaXNfZW5hYmxlZCgpLg0KPiA+DQo+ID4gTW92ZSB0
aGUgcmVndWxhdG9yX2Rpc2FibGUgdG8gdGhlIHN1c3BlbmQgZnVuY3Rpb24sIHR1cm4gb2ZmIHJl
Z3VsYXRvcg0KPiA+IHdoZW4gdGhlIHN5c3RlbSBpcyBpbiBzdXNwZW5kIG1vZGUuDQo+ID4NCj4g
PiBUbyBrZWVwIHRoZSBiYWxhbmNlIG9mIHRoZSByZWd1bGF0b3IgdXNhZ2UgY291bnRlciwgZGlz
YWJsZSB0aGUNCj4gPiByZWd1bGF0b3IgaW4gc2h1dGRvd24uDQo+ID4NCj4gPiBMaW5rOg0KPiA+
IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRw
cyUzQSUyRiUyRmxvcmUNCj4gPiAua2VybmVsLm9yZyUyRnIlMkYxNjU1MTg5OTQyLTEyNjc4LTYt
Z2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcueiZhbXA7ZA0KPiBhdA0KPiA+DQo+IGE9MDUlN0MwMSU3
Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0M1NjMzZmExYmYzYzQ0M2UyMDNlMTA4ZGE1NQ0KPiA2
NjdkYzIlDQo+ID4NCj4gN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0Mw
JTdDNjM3OTE2MTk1OTI3NzI3Ng0KPiAwNCU3Q1Vua24NCj4gPg0KPiBvd24lN0NUV0ZwYkdac2Iz
ZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMQ0KPiBoYVd3
aQ0KPiA+DQo+IExDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9MUtiem4z
WFNWdnQzZ0dQckV5JTINCj4gQkVUOEVabjRJDQo+ID4gZHdTJTJCaFVaM0FhbFoyWVowJTNEJmFt
cDtyZXNlcnZlZD0wDQo+ID4gaHVAbnhwLmNvbQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCam9ybiBIZWxn
YWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgMTkgKysrKysrKy0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggMmI0MmMzN2Yx
NjE3Li5mNzJlYjYwOTc2OWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiBAQCAtNjcwLDggKzY3MCw2IEBAIHN0YXRpYyB2b2lkIGlteDZfcGNpZV9j
bGtfZGlzYWJsZShzdHJ1Y3QgaW14Nl9wY2llDQo+ID4gKmlteDZfcGNpZSkNCj4gPg0KPiA+ICBz
dGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0IGlteDZfcGNpZSAq
aW14Nl9wY2llKQ0KPiA+IHsNCj4gPiAtCXN0cnVjdCBkZXZpY2UgKmRldiA9IGlteDZfcGNpZS0+
cGNpLT5kZXY7DQo+ID4gLQ0KPiA+ICAJc3dpdGNoIChpbXg2X3BjaWUtPmRydmRhdGEtPnZhcmlh
bnQpIHsNCj4gPiAgCWNhc2UgSU1YN0Q6DQo+ID4gIAljYXNlIElNWDhNUToNCj4gPiBAQCAtNzAy
LDE0ICs3MDAsNiBAQCBzdGF0aWMgdm9pZCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQoc3Ry
dWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+
DQo+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2
X3BjaWUtPnZwY2llKSA+IDApIHsNCj4gPiAtCQlpbnQgcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUo
aW14Nl9wY2llLT52cGNpZSk7DQo+ID4gLQ0KPiA+IC0JCWlmIChyZXQpDQo+ID4gLQkJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIHRvIGRpc2FibGUgdnBjaWUgcmVndWxhdG9yOiAlZFxuIiwNCj4gPiAt
CQkJCXJldCk7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+ICAJLyogU29tZSBib2FyZHMgZG9uJ3QgaGF2
ZSBQQ0llIHJlc2V0IEdQSU8uICovDQo+ID4gIAlpZiAoZ3Bpb19pc192YWxpZChpbXg2X3BjaWUt
PnJlc2V0X2dwaW8pKQ0KPiA+ICAJCWdwaW9fc2V0X3ZhbHVlX2NhbnNsZWVwKGlteDZfcGNpZS0+
cmVzZXRfZ3BpbywNCj4gPiBAQCAtNzIyLDcgKzcxMiw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2ll
X2RlYXNzZXJ0X2NvcmVfcmVzZXQoc3RydWN0DQo+IGlteDZfcGNpZSAqaW14Nl9wY2llKQ0KPiA+
ICAJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpLT5kZXY7DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+
ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSAmJiAhcmVndWxhdG9yX2lzX2VuYWJsZWQoaW14Nl9w
Y2llLT52cGNpZSkpIHsNCj4gPiArCWlmIChpbXg2X3BjaWUtPnZwY2llKSB7DQo+ID4gIAkJcmV0
ID0gcmVndWxhdG9yX2VuYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KSB7
DQo+ID4gIAkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGVuYWJsZSB2cGNpZSByZWd1bGF0b3I6
ICVkXG4iLCBAQA0KPiAtNzk1LDcNCj4gPiArNzg1LDcgQEAgc3RhdGljIGludCBpbXg2X3BjaWVf
ZGVhc3NlcnRfY29yZV9yZXNldChzdHJ1Y3QgaW14Nl9wY2llDQo+ICppbXg2X3BjaWUpDQo+ID4g
IAlyZXR1cm4gMDsNCj4gPg0KPiA+ICBlcnJfY2xrczoNCj4gPiAtCWlmIChpbXg2X3BjaWUtPnZw
Y2llICYmIHJlZ3VsYXRvcl9pc19lbmFibGVkKGlteDZfcGNpZS0+dnBjaWUpID4gMCkgew0KPiA+
ICsJaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4gPiAgCQlyZXQgPSByZWd1bGF0b3JfZGlzYWJs
ZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgCQlpZiAocmV0KQ0KPiA+ICAJCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBkaXNhYmxlIHZwY2llIHJlZ3VsYXRvcjogJWRcbiIsIEBADQo+IC0xMDIy
LDYNCj4gPiArMTAxMiw5IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJCWJyZWFrOw0KPiA+ICAJfQ0KPiA+DQo+ID4gKwlpZiAo
aW14Nl9wY2llLT52cGNpZSkNCj4gPiArCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZw
Y2llKTsNCj4gPiArDQo+ID4gIAlyZXR1cm4gMDsNCj4gPiAgfQ0KPiANCj4gVGhlIHN1c3BlbmQg
YW5kIHJlc3VtZSBtZXRob2RzIHNob3VsZCBiZSBzeW1tZXRyaWMsIGFuZCB0aGV5IHNob3VsZA0K
PiAqbG9vayogc3ltbWV0cmljLg0KPiANCj4gaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoKSBkaXNh
YmxlcyB0aGUgcmVndWxhdG9yLCBzbw0KPiBpbXg2X3BjaWVfcmVzdW1lX25vaXJxKCkgc2hvdWxk
IGVuYWJsZSBpdC4NCj4gDQo+IGlteDZfcGNpZV9zdXNwZW5kX25vaXJxKCkgY2FsbHMgaW14Nl9w
Y2llX2Nsa19kaXNhYmxlKCkgdG8gZGlzYWJsZSBzZXZlcmFsDQo+IGNsb2Nrcy4gIGlteDZfcGNp
ZV9yZXN1bWVfbm9pcnEoKSBzaG91bGQgY2FsbA0KPiBpbXg2X3BjaWVfY2xrX2VuYWJsZSgpIHRv
IGVuYWJsZSB0aGVtLg0KPiANCj4gaW14Nl9wY2llX2Nsa19lbmFibGUoKSAqaXMqIGNhbGxlZCBp
biB0aGUgcmVzdW1lIHBhdGgsIGJ1dCBpdCdzIGJ1cmllZCBpbnNpZGUNCj4gaW14Nl9wY2llX2hv
c3RfaW5pdCgpIGFuZCBpbXg2X3BjaWVfZGVhc3NlcnRfY29yZV9yZXNldCgpLg0KPiBUaGF0IG1h
a2VzIGl0IGhhcmQgdG8gYW5hbHl6ZS4NCj4gDQo+IFdlIHNob3VsZCBiZSBhYmxlIHRvIGxvb2sg
YXQgaW14Nl9wY2llX3N1c3BlbmRfbm9pcnEoKSBhbmQNCj4gaW14Nl9wY2llX3Jlc3VtZV9ub2ly
cSgpIGFuZCBlYXNpbHkgc2VlIHRoYXQgdGhlIHJlc3VtZSBwYXRoIHJlc3VtZXMNCj4gZXZlcnl0
aGluZyB0aGF0IHdhcyBzdXNwZW5kZWQgaW4gdGhlIHN1c3BlbmQgcGF0aC4NCkhpIEJqb3JuOg0K
VGhhbmtzIGZvciB5b3VyIGtpbmRseSBoZWxwIHRvIHJldmlldyBpdC4NClllcywgaXQgaXMuIEl0
J3MgYmV0dGVyIHRvIGtlZXAgc3VzcGVuZC9yZXN1bWUgc3ltbWV0cmljIGFzIG11Y2ggYXMgcG9z
c2libGUuDQpJbiByZXN1bWUsIHRoZSBob3N0X2luaXQgaXMgaW52b2tlZCwgY2xvY2tzLCByZWd1
bGF0b3JzIGFuZCBzbyBvbiB3b3VsZCBiZQ0KaW5pdGlhbGl6ZWQgcHJvcGVybHkuIA0KVW5mb3J0
dW5hdGVseSwgdGhlcmUgaXMgbm8gYWNjb3JkaW5nIGhvc3RfZXhpdCgpIHRoYXQgY2FuIGJlIGNh
bGxlZCB0byBkbyB0aGUNCnJldmVyc2VkIGNsb2NrcywgcmVndWxhdG9ycyBkaXNhYmxlIG9wZXJh
dGlvbnMgaW4gdGhlIHN1c3BlbmQuDQpTbywgdGhlIGNsb2NrcyBhbmQgcmVndWxhdG9yIGRpc2Fi
bGUgYXJlIGV4cGxpY2l0bHkgaW52b2tlZCBpbiBzdXNwZW5kIGNhbGxiYWNrLg0KDQpIb3cgYWJv
dXQgdG8gZG8gdGhlIGluY3JlbWVudGFsIHVwZGF0ZXMgaWYgdGhlIC5ob3N0X2V4aXQgY2FuIGJl
IGFkZGVkIGxhdGVyPw0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCam9ybg0K
