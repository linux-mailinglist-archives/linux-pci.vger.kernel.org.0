Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9268B5A8AA3
	for <lists+linux-pci@lfdr.de>; Thu,  1 Sep 2022 03:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiIAB2U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 21:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiIAB2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 21:28:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8904C136B39;
        Wed, 31 Aug 2022 18:28:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etLctldf2pIK/7tpiAIsmgRBoEDhh7VzYQ5QzG0S71VOsdjlAm9kUnExIZavATvmY8uyFmItjZKVejN0UcBoX/Ds6Thgqa8yAY21QGzaqu0STpo0y5ADoIZwdN+txlpb9h/OtL3kPiYtUA2LwZ/FPUCHD0WNPavl1vAkq9ZmXS2+sy0mytB1mKNcz9yJf4LW0ytPjcynZ4Xf4rgrQk4J7xs09CFFcUVUMO9weU5zNViJNntOlMOKhKvvO8IYzUrYVku2LvIDXrrjnsU4G2Dd4aAYSV/pgpNXJBJlXuYXvTACfyR9dYb0icTOadvhO1H8bNcLLVEZzA06n3AylR/MpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTpoH630DeJtwR0bev24nKsE3PgkYiV3VEvDpsvUgdo=;
 b=PLPsuZIRPz48qFh23mUOfBKUIT/K7MSKKqUUMqFHFnZ+C0JVDLGbktFxYX6ImaSZYEnSHTF499TU2FfGXbH3TWuFmhj2u9GL03syk2RN04jJeFDSRoJHObb254G3AlGAym2T13fuYScjC2gErSda5i4XNKd1A3zxrlmc4xGU0GOPKMod2S5qiLJZltZq0cG2Ohg/GGwU2BecW3YdsIXqdpXxHX1rXEtXM1sjYvARL9iU0eDvs1VQBiWg/QcuL4+PxTf0MG4HgBwgBUaQHnfi+QKqFVxvLrXs26Umyiz4J0cfLfYdNPYFH/dNBCfZnpsIvempDCFNM36f8HvfM/GqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTpoH630DeJtwR0bev24nKsE3PgkYiV3VEvDpsvUgdo=;
 b=jOp/C330+eHg6ydcYYVDNu8nV8eYYB6m0+w/jBi8jz8zt/1TdVpySGSroOYd9fZo73qnVahFYls1XizERQrDKAc9KAKzZO0+8VlEQPmogO1zI5PT4vINjof2K1RNKG6bD1W5G/BhclTKaNO+KKr44YWw7/Jh3jTo1hcMjPd/L6Y=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB5203.eurprd04.prod.outlook.com (2603:10a6:208:c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 01:28:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 01:28:13 +0000
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
Subject: RE: [PATCH v5 5/7] soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets
Thread-Topic: [PATCH v5 5/7] soc: imx: imx8mp-blk-ctrl: handle PCIe PHY resets
Thread-Index: AQHYvEcLSEFoA8/il0muMDWuCqcZnq3IsQWAgAEZvJA=
Date:   Thu, 1 Sep 2022 01:28:13 +0000
Message-ID: <AS8PR04MB86765B884C1CAA5B7441A72F8C7B9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661845564-11373-1-git-send-email-hongxing.zhu@nxp.com>
         <1661845564-11373-6-git-send-email-hongxing.zhu@nxp.com>
 <cbf7cc48acb1c772bea8594aa4017f56b4d1074e.camel@pengutronix.de>
In-Reply-To: <cbf7cc48acb1c772bea8594aa4017f56b4d1074e.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9623e87e-0c71-4e4e-cee3-08da8bb93d1d
x-ms-traffictypediagnostic: AM0PR04MB5203:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YwSQRgIAadhgfyiT2A31A0psp+FEswZhsfPesixyCj67xwaGkJEVK1eK5zs34JuOPaDaIM7fWvnWSB7/sG81dA65xsVTjC4Xz/d17Qcv9Z6vKGDP17jvX8xvTQxqsFaovi91A0kxdsp/at7Iex43iisOsv3FhcQ+z/5FSo97/ZBveuwDT7r74c5aPDmlGJURZd/0WoZ3BJuFyGd/TZmnBUzLtKHfMMaua/cj8NSYESSV31OdS6vBL1FbUx8VB4+6g5vlQ/sYscJIRkTOtcK6iriRtPluUZWdrbDeOPwq8QPyjy5kMj1SRTJgDqAIzSxPCT6HhyMRmft0EbCKrI3YW55EiVUl3eTkpuSjnMoKfFNT87VRNJF9dxthLqY66HDNp05rvSvjnflU1osD60P0FM9ryZVsi+d98VCSNMNQzfzDS14EQ3GulxvbUotk9PsFapO+CCyQnu3g1U29JbypKW4W7R50yIPu+GtZik2Y4v04IrwuTckism+CBBDa2wXHU6KE+zXzs2QTOxwwhyEMS5vsXcx+nlCCf/jVLXyWdwztfXe0F271V7z+dF3X+X+lqNJ7CAwX7j3D4KU3SgZ1OaAzdymbrp3itkKDvYlyIQcO0XZ6sYrgY8ohPk4yZ34qoamTAEyyWGHa7Y8Z0i6Wfb44ZMNqyMbMILstGs9u2k2jS8fKXvkTuJucjnduE0s6b2XZV7bOGOQE5b0/xQqijcxuGSmfxTbX6eKS33tiuW+w+dGrEAxxhc6t5Tm36ZTo568kNvIcSBwBSDvMF+V0W48voth6AiALAci7iuWAAUBxD7caa3f5qZb7DK2qFTPE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(55016003)(4326008)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(8676002)(7416002)(7696005)(54906003)(110136005)(316002)(53546011)(6506007)(33656002)(41300700001)(71200400001)(44832011)(478600001)(9686003)(26005)(38100700002)(921005)(86362001)(186003)(52536014)(5660300002)(2906002)(122000001)(8936002)(38070700005)(83380400001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGJTTnV2cDlWVXo2cXZ1RTg2aGFUeVVxcXBhRStHMm5IU1ZSUzFwR0N1aHNR?=
 =?utf-8?B?cGQ5MU9xOUg1VkRic3hwMWViSmQ0NHdHUHFLYldwaDhJM29NRTA1bktnaFFT?=
 =?utf-8?B?b3pmdnY0NUZnb1M1NTNDcGwrMGIvbDd3RWtBQk9LSE9WeWdYYTNzOWxPeDJ4?=
 =?utf-8?B?L3RWaDdOaXpiRGtqNVhvcEplRUFwNWF0SDd0WTM4RGxFRHRmS3FOMU94akxT?=
 =?utf-8?B?WVNFMTJwNXVSRmQrZHE3RVpIUDNmSVJONU5naGxOMllFQzFGSzdSUk54NXpn?=
 =?utf-8?B?MkZWUFlJR0J3MnZYajVqZ2dJWTE1NGRtS0tUVm10dGxiYmpTd2NHUGpxb2k3?=
 =?utf-8?B?U1NNOHdXdk80Uk16Z1RBV1RYMFU2RHFUeXB5RXBxZ25TVzB1U0FpaE14ZUVq?=
 =?utf-8?B?MTMrNGU1Ukh0REFjQ1hRQytSbDM1NnBibzhodldHU0hpc3VTYk5EdFBxaGRD?=
 =?utf-8?B?OXU4Sk9GRWsvbzhUN2JZWUxlVFZjanNFNTd1anQ3VllNTGlES2NSR1VYUHlE?=
 =?utf-8?B?ejhnUHl0UTRyYmVrcCtiaVJvODJzT1cxVmpVT2MxWWJ1WFhMYWthTDFDYzVP?=
 =?utf-8?B?T1l2MWtuckJYUXJtNFlpTWErcmQ1SllBcWs5a3hTc01WdlgweVVYdFZad2RD?=
 =?utf-8?B?NmFLWW50UkIrdWxGM1dDbElTbGw5dWlRbUQxSXNvRGNOT0dhWGdoNGRNOXNz?=
 =?utf-8?B?dEQ0RFArWE5uZHFmYVNBNGlIVzFIMUxZZDltNyt6STk1NG40K2xqcGUzdlpP?=
 =?utf-8?B?a3YzenFTR093c21YZjBzcTNDTW1tRTdibUdNTDJ1NjF3c2t0YmJkZXZ6Zjdm?=
 =?utf-8?B?QkFzV3hZNWN3Nmt4T2piYXFPczVVU0tXYldiMFJpVW1jbVUwMTZXOVdJUXhU?=
 =?utf-8?B?ODljWWRKMUFITWYyTFJpZytMcVJFTmlvd25DejhsazQwN3NvbXp0UUJ4VXhp?=
 =?utf-8?B?NERmMWFCbW5maldmeXZLQVZJVVloUEs4ZnljZ2lWMVpSQWhDREhzYzNKVE9N?=
 =?utf-8?B?ejVwRUVWMVlwdVJlZkp5TlZYaVZyRWxBUzBaN1hQZzJYaGJvaWpnUVpXYzBo?=
 =?utf-8?B?V05ZaG5GYXlYSU05VGczaStXQmdTUGs3aitsRTFib29vd25GcUpWWkszV2Nq?=
 =?utf-8?B?aXk2WS9VZFUzRW0wRTM3NmZtRUJTYlk3SmFvSjZtMjNDYTVQNzZFT1FDVHJ6?=
 =?utf-8?B?TUVDVkdDb0FEaFByaTgzeEJ3K2VUMnBOdnEzUXpnK2lyVVZmMmFYaVdReWNs?=
 =?utf-8?B?bnZhVXYzbFF0TEVDcEQ4NENpRVhieXZ5b3p3bEY3Q1U0T2tEc2c4S0lEaWd0?=
 =?utf-8?B?S3ZVODFteUNwQzB3bFJMbDBFbWFIS2p1dWtkSStvYmNGdzN6Z1Y2VUY2azVo?=
 =?utf-8?B?cG9DVWpPN2tBb1F5TVdad3g5VXJ6ckkwNTFzcUFhMlFhcW9KT1dSNkVwYXo2?=
 =?utf-8?B?bThLMTBBa0pGVjBZMWYrdXRWZFlyRTlDWGlFZ0l6ZThPVzdwNmUwKzJLdnNo?=
 =?utf-8?B?dmlpdWF4Yk93WHZpQUo4WmxjTHlwT09xTVNoYnM4ejBhaFZVYUdLMjRwS0Q0?=
 =?utf-8?B?aGYrVkRQNnYwVVFGVXVIS1dSWkxRaElGQWJSc2dtTTB4RUJONVJFL0pnZnBQ?=
 =?utf-8?B?bHZRdW9xNVFEcXNaQ0ZGb1BLVVI4NkF2VVlsL1hzY0JCNWUycm9rU1IrUGhj?=
 =?utf-8?B?Unp6UWNKNjVXYjdNN05JZjRVUlprK0pGY2RtYWFJYmZmeDJZWUY3QU9oYUZt?=
 =?utf-8?B?U3M3enlqdlR3VkZYWTJleU1xd2FyaURJWGtzd3QyRi8rTThCYUw0V01xM3pi?=
 =?utf-8?B?K2Y2UWtsQlY1b29iM0pLZGVVSGQwTEtRVzJMMWJDT0pMSGhqcW1ZeHRWa0c2?=
 =?utf-8?B?L3ExZGFVTTFDR0pBQ2RFeEdQM1F5b3l3SDBCSXNldU10Q0l2S0lXNmRoQXB0?=
 =?utf-8?B?dzJKWTdNQkdWZytaVlcrUGNzbzBadVUwUGtWVEN3MXA3UUJNUk5xcGpUK3VE?=
 =?utf-8?B?MFQ3VDBIUkVXTTNTKy9QUGZOTzZzQm02VW9Vcmc4NEdYSmlNT2tBaS85NzEw?=
 =?utf-8?B?dUJSQTdjWmFFQTBST085RUxDVkZEMkZiN09TL01iODEyY2s5TktUNXFCV0Vs?=
 =?utf-8?Q?5rbUk5cQGi//cATjjUtaujLlx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9623e87e-0c71-4e4e-cee3-08da8bb93d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 01:28:13.6608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jkKs0gWc0AFx6NE9SMEqDgqEMiPvrtXvgWyHFdzE4xkCZsVFvZbNldKGTkdztOWyMD0VxOCrTgZyi9XUsamEng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5203
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDjmnIgzMeaXpSAxNjozNw0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHJv
YmhAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgdmtvdWxAa2VybmVsLm9yZzsg
YWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsNCj4gbWFyZXhAZGVueC5kZTsgcmljaGFy
ZC5sZWl0bmVyQGxpbnV4LmRldg0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxs
aW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzddIHNvYzogaW14
OiBpbXg4bXAtYmxrLWN0cmw6IGhhbmRsZSBQQ0llIFBIWSByZXNldHMNCj4gDQo+IEFtIERpZW5z
dGFnLCBkZW0gMzAuMDguMjAyMiB1bSAxNTo0NiArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0K
PiA+IEZyb206IEx1Y2FzIFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPg0KPiA+DQo+ID4g
RGVzc2VydCB0aGUgUEhZIHJlc2V0IHdoZW4gcG93ZXJpbmcgdXAgdGhlIGRvbWFpbiBhbmQgcHV0
IGl0IGJhY2sgaW50bw0KPiA+IHJlc2V0IHdoZW4gdGhlIGRvbWFpbiBpcyBwb3dlcmVkIGRvd24u
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMdWNhcyBTdGFjaCA8bC5zdGFjaEBwZW5ndXRyb25p
eC5kZT4NCj4gDQo+IEFjY29yZGluZyB0byBwYXRjaCBzdWJtaXNzaW9uIGd1aWRlbGluZXMgeW91
IG5lZWQgdG8gYWRkIHlvdXIgb3duIHNpZ24tIG9mZg0KPiB3aGVuIGludGVncmF0aW5nIHRoaXMg
cGF0Y2ggaW50byB5b3VyIHNlcmllcy4gUGxlYXNlIGFkZCBpbiB0aGUgbmV4dCByZXZpc2lvbi4N
Cg0KT2theSwgdGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBSZWdh
cmRzLA0KPiBMdWNhcw0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvaW14L2lteDhtcC1i
bGstY3RybC5jIHwgMTAgKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2lteC9pbXg4bXAtYmxr
LWN0cmwuYw0KPiA+IGIvZHJpdmVycy9zb2MvaW14L2lteDhtcC1ibGstY3RybC5jDQo+ID4gaW5k
ZXggNGNhMmVkZTY4NzFiLi42YzkzOWQ2OGJhOWEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9z
b2MvaW14L2lteDhtcC1ibGstY3RybC5jDQo+ID4gKysrIGIvZHJpdmVycy9zb2MvaW14L2lteDht
cC1ibGstY3RybC5jDQo+ID4gQEAgLTE4LDYgKzE4LDggQEANCj4gPiAgI2RlZmluZSBHUFJfUkVH
MAkJMHgwDQo+ID4gICNkZWZpbmUgIFBDSUVfQ0xPQ0tfTU9EVUxFX0VOCUJJVCgwKQ0KPiA+ICAj
ZGVmaW5lICBVU0JfQ0xPQ0tfTU9EVUxFX0VOCUJJVCgxKQ0KPiA+ICsjZGVmaW5lICBQQ0lFX1BI
WV9BUEJfUlNUCUJJVCg0KQ0KPiA+ICsjZGVmaW5lICBQQ0lFX1BIWV9JTklUX1JTVAlCSVQoNSkN
Cj4gPg0KPiA+ICBzdHJ1Y3QgaW14OG1wX2Jsa19jdHJsX2RvbWFpbjsNCj4gPg0KPiA+IEBAIC03
NSw2ICs3NywxMCBAQCBzdGF0aWMgdm9pZCBpbXg4bXBfaHNpb19ibGtfY3RybF9wb3dlcl9vbihz
dHJ1Y3QNCj4gaW14OG1wX2Jsa19jdHJsICpiYywNCj4gPiAgCWNhc2UgSU1YOE1QX0hTSU9CTEtf
UERfUENJRToNCj4gPiAgCQlyZWdtYXBfc2V0X2JpdHMoYmMtPnJlZ21hcCwgR1BSX1JFRzAsDQo+
IFBDSUVfQ0xPQ0tfTU9EVUxFX0VOKTsNCj4gPiAgCQlicmVhazsNCj4gPiArCWNhc2UgSU1YOE1Q
X0hTSU9CTEtfUERfUENJRV9QSFk6DQo+ID4gKwkJcmVnbWFwX3NldF9iaXRzKGJjLT5yZWdtYXAs
IEdQUl9SRUcwLA0KPiA+ICsJCQkJUENJRV9QSFlfQVBCX1JTVCB8IFBDSUVfUEhZX0lOSVRfUlNU
KTsNCj4gPiArCQlicmVhazsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4gIAkJYnJlYWs7DQo+ID4gIAl9
DQo+ID4gQEAgLTkwLDYgKzk2LDEwIEBAIHN0YXRpYyB2b2lkIGlteDhtcF9oc2lvX2Jsa19jdHJs
X3Bvd2VyX29mZihzdHJ1Y3QNCj4gaW14OG1wX2Jsa19jdHJsICpiYywNCj4gPiAgCWNhc2UgSU1Y
OE1QX0hTSU9CTEtfUERfUENJRToNCj4gPiAgCQlyZWdtYXBfY2xlYXJfYml0cyhiYy0+cmVnbWFw
LCBHUFJfUkVHMCwNCj4gUENJRV9DTE9DS19NT0RVTEVfRU4pOw0KPiA+ICAJCWJyZWFrOw0KPiA+
ICsJY2FzZSBJTVg4TVBfSFNJT0JMS19QRF9QQ0lFX1BIWToNCj4gPiArCQlyZWdtYXBfY2xlYXJf
Yml0cyhiYy0+cmVnbWFwLCBHUFJfUkVHMCwNCj4gPiArCQkJCSAgUENJRV9QSFlfQVBCX1JTVCB8
IFBDSUVfUEhZX0lOSVRfUlNUKTsNCj4gPiArCQlicmVhazsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4g
IAkJYnJlYWs7DQo+ID4gIAl9DQo+IA0KDQo=
