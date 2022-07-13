Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6882A5734C7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 12:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiGMK5b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiGMK51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 06:57:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616FFF5BA;
        Wed, 13 Jul 2022 03:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnSrfg0nhtFZmLpoHnUZwnmSoSXMNRRnnkfsrzfAyNFNjzho/7niXdFEpW02XTkW5Yvm0TcYkSl/oYiCSu2NuN3N08RFZg9ZUC3a5gETjy8YjkYWn0fsWqrKzgftMhARTTYpU3bhhkg58Jk3cvf+jiqtZp71rrcIscpqSY0IdtBB9MFqVOK4lURvi8hMPIFt1iX3QodK67Mlbj2zkrApa99KfUCDVSsRweo1Ebe7XrPp6hcWTrL06NvtQSmAqoUNWmEkRp3Q7/dR7sT/gcPReM2h08RI9BL5hhdRza0GWK6yYQX/KJUAb+UZ4hq1AI1MurnqF4SPtMLB8RZeV5MRCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9UzRHHNpTCA3oRfEjmR2IQ8H0W5gwNuPxfOpl5xqMo=;
 b=NW2aghHasgBaQbj2+nWFKVNWhmjhqeBZS9eXS/PUQ21XJSbOF6jG0fz+0dl3Fv5m19FIY8EFwk/ZSYzigf5jbpMLVVXf2MmAZxdVoVJ+Uj/AKEhC9Gk4f8aF/NkOxAjVK0TmUt5EH/6FMtR665c+EP81mqx3D7y3K6lNgtPEwBUEbTU9Qwv/rpYTf6qKTJHfzaCKQwTxlLUFzLnZ0RFW954aPaVjjtTztHSpRwyAH3VttvyhYB0x6ic4dG+kdGUbVQLw7xou3kLE6VRwr341HZ5dXN1tkJKFKREl/ABbq8UbyIcEXE3S18oreQhHff8Q763fH10F/4CWAjpIOs1aIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9UzRHHNpTCA3oRfEjmR2IQ8H0W5gwNuPxfOpl5xqMo=;
 b=jAj5X7WU8bmZAEvH0XRtaihADuCQ3OmDrHBPbRyxIwnA63MtQf+DvcGEGM7aD7Gr6GqiFVY5Je9HALa/BluO3CeWdxjI+iIgRu5dmdaOpokFCBsct5O4wXagXOt0dy8PmirhOuly2d80TP/0d+sqR+ecDTPYMMvaA38qYr1UeT4=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8522.eurprd04.prod.outlook.com (2603:10a6:20b:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 10:57:23 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 10:57:23 +0000
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
Subject: RE: [PATCH v14 13/17] PCI: imx6: Reduce resume time by only starting
 link if it was up before suspend
Thread-Topic: [PATCH v14 13/17] PCI: imx6: Reduce resume time by only starting
 link if it was up before suspend
Thread-Index: AQHYjPxQ9O9SAiqapkK/see2N+NUgK18EIMAgAAWQ9A=
Date:   Wed, 13 Jul 2022 10:57:23 +0000
Message-ID: <AS8PR04MB86760B1E09E3CD01C7DC19B68C899@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1656645935-1370-1-git-send-email-hongxing.zhu@nxp.com>
         <1656645935-1370-14-git-send-email-hongxing.zhu@nxp.com>
 <26d5e056c4b4779293b79012468f2ac821f4c06c.camel@pengutronix.de>
In-Reply-To: <26d5e056c4b4779293b79012468f2ac821f4c06c.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10ddbc14-22e2-45a8-e8bb-08da64be778b
x-ms-traffictypediagnostic: AM9PR04MB8522:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWXo8MthsNzxJ2Hlmv5pW/XL8fDwyl1MSkWGwStUeb7ap/ker/cBteRG2O3n/UBKmq7i+yc6UPjoqst2vwM9YDxgk+KAJN1fR/nVDmlNV4Bir+q9rRhxCQHwKkLviFjG3kYTNcvT8T4LlNumHDlGPcXLJ5bKnlihTAq3cp09G1+pVi5v3JRjcisNsj3jGdYodKyq5MB/hlO8m6Nglh5tM9SIhdCI5TT1vuMgViq2s7KZGKP0jQsQQw9y6Ac7bYhBE9yjXJOYbT2zTKVAdV7mbb3iIwBaq2U+z1F0+tF0mHgqG30YD0c+IAD1EOr2HyLSeJFFDRr2DkOhXncHGWXh1VpoCf+949jWePSwcginy4uZYZ2p4ChaTKfF7fe2fGUshaIYfnQF55YJbAdyUL+UItd3QL5Sa4WSbD6+4bCBV/a451ExJcz/H2nrY4Irsedd52hAR1zf9luskFUgIywXoUi9dv8lLh1WLyNKY1aU6KQOoEi/OxxhA1ldVX0XuRe6mSzHV01JV/E8K64cR7YYwOKL/KWw1I4qok3dsFrOpTJQrrh31Jrwc7hArNAN5/2szW1XxcorYRsiW++X78JZ2NdzWFVLq4+m1w/9c4wKFTw4WriwfSmnIZBW3JR1HDJ/kjoRkxDZ2DzyQf2AnR4j+AFKxphMnB6l7PNcbdm/d3Iq4i/GS3sJaFmh+wLrAPGyDXNUqm6xIZ8L0XBGI9tCpgZ2H0yFc8AMYCgfXCQB5AGvICrtn+DFEttiEi140Ye4amaCQDQtezy17A81DgzLMN6nYIHd959ujK3Pi0gjzJ1Dam/c2tyIk7xHsjtTUXWV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(2906002)(110136005)(41300700001)(54906003)(71200400001)(15650500001)(7696005)(53546011)(26005)(8936002)(52536014)(5660300002)(8676002)(316002)(64756008)(86362001)(33656002)(9686003)(4326008)(6506007)(7416002)(44832011)(66556008)(76116006)(186003)(83380400001)(66476007)(55016003)(66946007)(38100700002)(122000001)(38070700005)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmgzWllOcS8wa2VGeitSdHRGQS9NTzVZelA2Mi8xenc3TGNBeU1ZeTlLbU9O?=
 =?utf-8?B?TjRlTUk5eS9FdWpvRjJqTlREK25BaVBDUU1oMDYwYjVlWWN5NE52bStnaUhD?=
 =?utf-8?B?Z2pTam4yM1psNkpkQnpMVlBqMy9WYTBTRHJrelBjMTFPN1hpbndGT3VyNkpK?=
 =?utf-8?B?ZlNTQUczT01acW5MRUwremNHVHRsNGs5QnVMazB6V3lCTVpQT1ZNTUUzaDUy?=
 =?utf-8?B?MDRJMEIvWkdWanR6YXNhTm5iQmVYT1ZmK2dCR1VZQkNlbytKdFBHZkpqUzZ6?=
 =?utf-8?B?cG5jUzQrM2w5Y3NJcE94dTdlcWt4SytnYmRqNmdSRmdiZWNxNG5aaVpZcFdP?=
 =?utf-8?B?bTZTSENzdmhOVi82UGdLYWZLc2FHenlkOEhzOVNueldmOHpyUFhkTWlNS2xN?=
 =?utf-8?B?QjZzTXZmTkt0dXVoWTFoemNrTWpKNWIzV3JpTlJyOUdNeUFaNk9GY2VHYVlp?=
 =?utf-8?B?Qy9ITzU4MDZYcGxNeTNHQkJQVGR2RGtPTWhwYk1QOXBMaGRVQjhVdnZHVFZm?=
 =?utf-8?B?ZERiZG11bGVJN0tzT2pISUZuS0ZsbHExOXZmS0pybFZGbDdtOTE5MmtOaXoz?=
 =?utf-8?B?OU1xdnpLc2RncFhDWlo0SFRaVmxvdFFGTnF2Rk5ySThSQWFtNGdXc2tKTURU?=
 =?utf-8?B?Rmd0VTFNY0dkQmo5dllLRkNyUzYvaTdUQ2FodXdmL2V5RkRqUkVXQ2N4OWFr?=
 =?utf-8?B?L0pGbENEMWl4NHdNSzZLOFprWXJra0F3ZUtybEc0Ymt6WFRkOUEraFMwdUUv?=
 =?utf-8?B?MFIxaHRmOFJCdHFWZU90a2kyTUhxTmE1WU5XSjJPRVljeGhwNE5oS3UwVWpL?=
 =?utf-8?B?WnA1QnJhUnlSM2FOTWQ1U2dVa3dmNG9uZjRjbitVaDdkUjBOQjlEdE9zS3Rw?=
 =?utf-8?B?ZENiWGdVUVlrdW5xWVpoTUFJaXlNWWU3WWswZTBud1poSWsyVWFubHBteE1T?=
 =?utf-8?B?V1F1aFh1dU0ycTJsbTFwZWhwM3NiZHdxM0xEZ00zN3B2ckFQbHBOdUN2R0hj?=
 =?utf-8?B?R2J3Y2tsRlA5ZnRsaXM5R2pBREdPNm9acW82NVFkaENFcEU3UGhWTDVONlo3?=
 =?utf-8?B?T2NySFMwUWYrSWhiSUtVRWNiRDZZRGl3MGJuZVZ5eEkzelBDUnJhWEVpTlRB?=
 =?utf-8?B?ei9BdmJaVzJzZWJ3bVJZRU9ld0JVZnpZNDhIUHVYTVF0UlIySlh4QWZhLzRU?=
 =?utf-8?B?SnBoTWdFa3k0RWFIcnR2aFZJN2FMS3JockVUL2J1N0g2dFpKUG90aFlwMDRu?=
 =?utf-8?B?Z3JtMHZaTm14c1p2c0kyWldrWmlVSkpCRzVTK28wRFk0NHVnMzJrd20xNmFB?=
 =?utf-8?B?cFlNdUxUTFRYZ08yVGtSajlOSm1uaU1ETFhobC8zMlJSWGVhWXlUTW5zcDFF?=
 =?utf-8?B?QyswRzVBNG9McTJmWjNkOXBSU3F5M1RCNGxsMUhoRVZWSmJtSlRGbmNRZ3BC?=
 =?utf-8?B?N216c1N4Q2NmTldKM1AxMndKbk5mbTFwMmVYb0piOWZUdnZ0SHRCd2h0YzQy?=
 =?utf-8?B?Z1ZqdmtpQVpUNVM4Nkh4cnh5ZlZqRmdRL0hKUzRHS3JTSUJnSW5sNi9paytD?=
 =?utf-8?B?M05DN2xqU3MyQWVZTWFNNit2a2VXZ0hiMGlqS1ZyQndZSFpyYk15Zk03dzZZ?=
 =?utf-8?B?enRXaHZMNTRDd0gxOVE3NEN0Y2lJbWg0WVJERGhwdVRxMjRwSFhKdjVqdE9l?=
 =?utf-8?B?U2xyOGdKbjA1R2lIbVZqNTltRGhuVmswQStUVlgzSU9iSFh1RGJDU2JJVUJl?=
 =?utf-8?B?QnU1MDQ4UG10Z3hiZU8rL2RTRnQycmRXMTRsT29LTWdVa0Y2aVRheTEvWUdO?=
 =?utf-8?B?eUQvSXd1YU0vRlQxNmtwdDFZNVlqRUZrMitaNTZPNDNSTDZWcWpvY3RoZnp1?=
 =?utf-8?B?OHNNMU1WU2NRdVFyVmV3L21oTU15MW5XZXRTQ0NKNCtIYU5PSEVxaktIY3Vm?=
 =?utf-8?B?SlFGU0lrRFozNzJqQjhnSmQ1WnRDNm5nSnE1Ly9sdFlFaFFHdGl6WDhDc3B3?=
 =?utf-8?B?bG1pN0JaOUcveU9qQUw1bkVZZnFjUVliZEptS2RPaEpmUldiMDRFc29VWEp6?=
 =?utf-8?B?NkpabXVRNENOL0ErbC9lVGI5eFRQakRLdEhDT0ZnOFd1THp5MFQyR2tsRzRj?=
 =?utf-8?Q?qUYFyl+RSgiSwAEC8fIT4UJtv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ddbc14-22e2-45a8-e8bb-08da64be778b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 10:57:23.8411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTAZmTynOfw0lD6SifiUeX9hPnTPH9JIvT10ezfaOa17hlltFwpGDpGyEZ64nPaTLAinl58740/S7KiNgDGPqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8522
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
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDfmnIgxM+aXpSAxNjo0OA0KPiBUbzog
SG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgYnJvb25pZUBrZXJuZWwub3JnOyBsb3JlbnpvLnBpZXJh
bGlzaUBhcm0uY29tOw0KPiBmZXN0ZXZhbUBnbWFpbC5jb207IGZyYW5jZXNjby5kb2xjaW5pQHRv
cmFkZXguY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTQgMTMvMTddIFBDSTogaW14NjogUmVkdWNlIHJl
c3VtZSB0aW1lIGJ5IG9ubHkgc3RhcnRpbmcNCj4gbGluayBpZiBpdCB3YXMgdXAgYmVmb3JlIHN1
c3BlbmQNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbSAwMS4wNy4yMDIyIHVtIDExOjI1ICswODAwIHNj
aHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gQmVjYXVzZSBpLk1YIFBDSWUgZG9lc24ndCBzdXBwb3J0
IGhvdC1wbHVnIGZlYXR1cmUuICBJbiB0aGUgbGluayBkb3duDQo+ID4gc2NlbmFyaW8sIG9ubHkg
c3RhcnQgdGhlIFBDSWUgbGluayB0cmFpbmluZyBpbiByZXN1bWUgd2hlbiB0aGUgbGluayBpcw0K
PiA+IHVwIGJlZm9yZSBzeXN0ZW0gc3VzcGVuZCB0byBhdm9pZCB0aGUgbG9uZyBsYXRlbmN5IGlu
IHRoZSBsaW5rDQo+ID4gdHJhaW5pbmcgcGVyaW9kLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJq
b3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMgfCA4ICsrKysrLS0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+IGluZGV4IGUyMzZmODI0YzgwOC4u
NWEwNmZiY2E4MmQ2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaS1pbXg2LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gQEAgLTY3LDYgKzY3LDcgQEAgc3RydWN0IGlteDZfcGNpZSB7DQo+ID4gIAlzdHJ1
Y3QgZHdfcGNpZQkJKnBjaTsNCj4gPiAgCWludAkJCXJlc2V0X2dwaW87DQo+ID4gIAlib29sCQkJ
Z3Bpb19hY3RpdmVfaGlnaDsNCj4gPiArCWJvb2wJCQlsaW5rX2lzX3VwOw0KPiA+ICAJc3RydWN0
IGNsawkJKnBjaWVfYnVzOw0KPiA+ICAJc3RydWN0IGNsawkJKnBjaWVfcGh5Ow0KPiA+ICAJc3Ry
dWN0IGNsawkJKnBjaWVfaW5ib3VuZF9heGk7DQo+ID4gQEAgLTg4MSwxMSArODgyLDEzIEBAIHN0
YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUNCj4gKnBjaSkNCj4g
PiAgCQlkZXZfaW5mbyhkZXYsICJMaW5rOiBHZW4yIGRpc2FibGVkXG4iKTsNCj4gPiAgCX0NCj4g
Pg0KPiA+ICsJaW14Nl9wY2llLT5saW5rX2lzX3VwID0gdHJ1ZTsNCj4gPiAgCXRtcCA9IGR3X3Bj
aWVfcmVhZHdfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktTVEEpOw0KPiA+ICAJZGV2X2lu
Zm8oZGV2LCAiTGluayB1cCwgR2VuJWlcbiIsIHRtcCAmIFBDSV9FWFBfTE5LU1RBX0NMUyk7DQo+
ID4gIAlyZXR1cm4gMDsNCj4gPg0KPiA+ICBlcnJfcmVzZXRfcGh5Og0KPiA+ICsJaW14Nl9wY2ll
LT5saW5rX2lzX3VwID0gZmFsc2U7DQo+ID4gIAlkZXZfZGJnKGRldiwgIlBIWSBERUJVR19SMD0w
eCUwOHggREVCVUdfUjE9MHglMDh4XG4iLA0KPiA+ICAJCWR3X3BjaWVfcmVhZGxfZGJpKHBjaSwg
UENJRV9QT1JUX0RFQlVHMCksDQo+ID4gIAkJZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX1BP
UlRfREVCVUcxKSk7IEBAIC0xMDMyLDkgKzEwMzUsOA0KPiBAQA0KPiA+IHN0YXRpYyBpbnQgaW14
Nl9wY2llX3Jlc3VtZV9ub2lycShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIAkJcmV0dXJuIHJl
dDsNCj4gPiAgCWR3X3BjaWVfc2V0dXBfcmMocHApOw0KPiA+DQo+ID4gLQlyZXQgPSBpbXg2X3Bj
aWVfc3RhcnRfbGluayhpbXg2X3BjaWUtPnBjaSk7DQo+ID4gLQlpZiAocmV0IDwgMCkNCj4gPiAt
CQlkZXZfaW5mbyhkZXYsICJwY2llIGxpbmsgaXMgZG93biBhZnRlciByZXN1bWUuXG4iKTsNCj4g
PiArCWlmIChpbXg2X3BjaWUtPmxpbmtfaXNfdXApDQo+ID4gKwkJaW14Nl9wY2llX3N0YXJ0X2xp
bmsoaW14Nl9wY2llLT5wY2kpOw0KPiANCj4gV2hpbGUgdGhlIGNoYW5nZSBpdHNlbGYgaXMgY29y
cmVjdCwgdGhlIHJlbW92YWwgb2YgdGhlIHJldHVybiB2YWx1ZSBjaGVjayBzaG91bGQNCj4gYmUg
YWRkZWQgdG8gdGhlIHByZXZpb3VzIHBhdGNoLCBhcyB0aGF0J3MgdGhlIHBvaW50IHdoZXJlIHlv
dSBjaGFuZ2UgdGhpcw0KPiBmdW5jdGlvbiB0byBhbHdheXMgcmV0dXJuIDAsIHJlbmRlcmluZyB0
aGlzIGNoZWNrIHBvaW50bGVzcy4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NClllcywgaXQg
aXMuIEluZGVlZCB0aGUgcmV0dXJuIGNoZWNrIHNob3VsZCBiZSBjbGVhbmVkIHVwIGluIHRoZSAx
Mi8xNywgc2luY2UNCiBpbXg2X3BjaWVfc3RhcnRfbGluaygpIGFsd2F5cyByZXR1cm5zIDAuDQoN
CkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCj4g
DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+IA0KDQo=
