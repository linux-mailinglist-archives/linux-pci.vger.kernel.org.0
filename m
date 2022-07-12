Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A4570F78
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 03:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiGLBaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 21:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGLBaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 21:30:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF568C76F;
        Mon, 11 Jul 2022 18:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDTMVT9x5D+TY0+pHS/jtYJLFP+12cmOEswFdUfMxetLiNqnid7qOqnvnhpu4vCb2J7f1EihtzHjXZo0zgg/lj4nK6riEgxaeyy+QKfnaEX+bdE+1n0wB/4kwBY174bYNT0KBHctlZaPpmklVYi3xlRgJRKrZjIEcUx8QYW6wc171S/GhHp8E5ehgwps/LR34AkBhgwXvsY/O/4w3BnbkvzYLOJ7hZWXNOUgYxkhOQhMJGVuev7paJ1sigJITuaHkUgwVXocUF6+LImYa73xIt1OkYe4JuDmNpOW6ggaokl+mTo6vjb1/XRbLP/o8ANvj9N67XZEIwW3x2ozjCjIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTzgcS06jSmtxMna6Jicx+P6FnO+yhOZZeLQ2UYJIuY=;
 b=PoUmxJOwTQXMxttOPrhsWj3cpCIVTexgTFQbiVxpIejZEw74mMBZ1b1kbyyzBIvA0TdzbthTcbrJY29xsskWPCPYqJy5Q4Sp8tLgRWy07iqtdKpPAn4KL+vwaSA8tv39uLivgiXQmKRk6j5qe94jIHL1S0s5schTNb4Ckdp9uW4g+UzY2bJj8CoeQhaJFVMw2JbQyqpWXT1yWjwJR4w3PnjH0qLqkDhN2/yjl8JANFgGTkZnpzbU4Tiwp/kpm6WdQEG8vlyGA3KK5NoiYIEIw4BlWTbOHpQ92Ja3V+bBnTn3rscT4nw4otHz1kfvFSumyV3/JozBf8cTUe+WZxQySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTzgcS06jSmtxMna6Jicx+P6FnO+yhOZZeLQ2UYJIuY=;
 b=Bc4TxCBd5EXTnvioZeQ5zieaztpIFaIk2IVioTTvH1GHh9YpaIviqeYVkDtvsHB15kZRiry0uiot7r+QJl3fwSgrcWs9o51wFp56p+6hBEni0jLIhxdqAkh4yLtWdgHFCpeUDxwi2JKs6p68dCAIqK7+k9CQ5jtgF85tPOc7x28=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8563.eurprd04.prod.outlook.com (2603:10a6:20b:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Tue, 12 Jul
 2022 01:30:03 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::460:6674:ddf6:3a8d]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::460:6674:ddf6:3a8d%6]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 01:30:02 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [RFC 1/2] PCI: imx6: Make sure the DBI register can be changed
Thread-Topic: [RFC 1/2] PCI: imx6: Make sure the DBI register can be changed
Thread-Index: AQHYapxbcPvd11xJjk6STSPl4cf0eK16EqmAgAAwzRA=
Date:   Tue, 12 Jul 2022 01:30:02 +0000
Message-ID: <AS8PR04MB8676FA05BEEE264A9FE1F6538C869@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1652866528-13220-1-git-send-email-hongxing.zhu@nxp.com>
 <20220711221701.GA697090@bhelgaas>
In-Reply-To: <20220711221701.GA697090@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7823103-004f-452d-5655-08da63a60b24
x-ms-traffictypediagnostic: AS8PR04MB8563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LdYOfVdjl5dFJNyyp+9QBJyuLSa88Gl8jZ3OVV99wq9y/1wctZImEXDFPMB3dyiDClxtW1H0ji1JwShW5UlytZrs6uiggeJGfkCseEvvHpQ0ftk1MUXgRgPmtmwv1uArRzLYg9meNpM4jB2WwAkWim+Ksx4RpWzo/g23RsW5OaOxIOrNMZLIn6H5WKq6UPQw0nfq0LKLj8yQwKVVbWbrGGw4naINzmTvRZVsOtlh0a7qQBUbZbZ++56O2dAbXg6ThUxxqwL1hhs0oHk8xv7QnTPpdNyl9LwQw4RzgCCUw1CNwtzoKrbnn+T3uu49vh1gvY92m/JoGd55/dFCxewPBYsawyxA/lLqN/wMqx9XN2DxwObwsOGnEGOIFnnVYa7lE/GiVvTjq/55+TXDGlSe1VP2enT/TUWs/NxtRrJr8jOBqRldkKVPnhPN90SpZuNqhPff/mZLfkiFrMpTb1v1T+Wpea7yD6lQ42huQEcXcogw73HVFZgCr27fSAmHIj6/466/QzLsuEpcXPy+4tbXXCYQgHQiBeEj5w3Hhrk+SVUb2pk0te9EETd3XXzdt+qBRntJAUUVpyEvGg/txUoZxdkvxWUVYhqU6O4D156HyQbq10H3iE/OtKbKShIt0D8TOrHjR0x7G/6EVOkRuWOXOx1cb5pk8Jcfx6TP3PmvSyVY82riuZZv0MMzKrtZ5hzj3skJwDWD+U4/Ypmhn3wq32vHOsurxJWOMcuPRykVpIJG9oVgEcDJhN+eZ2jOHyXCLupqQO2OPvOrWjbURDKier/CUk3uV/82SIwp54Wwg+uoJfKUmW0sMP1TDktyd+lhZ4zpoqEkRIEZQxHZYCSsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(53546011)(966005)(5660300002)(26005)(7696005)(6506007)(38070700005)(9686003)(45080400002)(6916009)(478600001)(54906003)(316002)(33656002)(71200400001)(41300700001)(66476007)(8676002)(55016003)(64756008)(186003)(83380400001)(66556008)(66446008)(4326008)(66946007)(86362001)(76116006)(52536014)(44832011)(38100700002)(122000001)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SytLTi9ndXZyUndDSzdtc0Vsb01ZSWZsdFl6a3NRRTYrMmEwRFBvWldCTk9m?=
 =?gb2312?B?eUxiS2Vjdy9MT3F3WUhBeFlsRlo0Qy85eTErNXNEd24wQlJwMUdpZURXY0NH?=
 =?gb2312?B?d3M2clcwbUNOQ0V5eVVBdTFTRXZaNTlQTWUrekZWdFNJa0ZSZmw5T1dYSnhG?=
 =?gb2312?B?RUFjeUowV0YrMC81dUNNd09mTVpJVFh5b1g5YWpyVkoybllBOUZ6akFQLzVJ?=
 =?gb2312?B?aHlETjJJRlBSMlMwU1ZPaEpvV2JQdnhySVUzT2kvNjFMQXgydG0rSEhQdkdF?=
 =?gb2312?B?N3ZPLytpeE1SL3RMc2xrazlPbFYrV25VNmhMSis4Q0wzdnlwSThuQ256ZXZs?=
 =?gb2312?B?aW42c1dXb3cwdnJXQnZ3OUFGaVErVlFaSjhtSU5QelVVRzNzeHh0UTd0VUVn?=
 =?gb2312?B?NmhrdVZWK3UvRU1iNWp6ZUNRVXVhZnVPRzZOYTZ5NTBsSkNVSUhqLzJ0TytP?=
 =?gb2312?B?WmtZcnVqWE1ZM2F2SEVPSkNhNlY2MklBM1VYVFFrQlFYY1pUYmx3VUgyZmRq?=
 =?gb2312?B?ZU9VamRLYUtOMGY0T1lnT1Zrcm9JclhXUEh3V3ErQlc5VWxjQlBFNEk4N3BV?=
 =?gb2312?B?QzF0WWsyd1h1aHhDK0U1dDZWK3RYU3JkUUMvVGNZdjRaZDJjNW0zZkJsczFu?=
 =?gb2312?B?Y0NrSkZqOHkyTEIrQXJ6SkJFVUk2UTg1Nm9LamZrWUdkcVJBWG4wd0R5UW8y?=
 =?gb2312?B?b1hBMFE4N2hEYkFXVWtSN2lMT29jMjA5VHkveXBKSmdQRWZkNndURDVUUEV2?=
 =?gb2312?B?ajhzN3REaUlvVEVZK3ZZS0VlUytFTU4xNUNkVnlIS3ZyQ2FaRjBVTHFwRUw4?=
 =?gb2312?B?RHBmdzNVb1JWeWV3Z0hJM2lYREpaaG4vOXNvZ3dhdDRobXQrY0pTMklhMWpX?=
 =?gb2312?B?azB1Qkt2MGhOMUh3RG1ZdHBmVHhCRmRCTG8zbkxoeXNwYTY1RXcyUXQ1aFhi?=
 =?gb2312?B?VDB4dzNhNElCdFNvM0ZWbWZtRkNZdHQrTGpaQ3FOeGMwSlRVZTZZc3RDMTM3?=
 =?gb2312?B?YkJpS2lIbDFSTDdJR0ZZenlOdUhLNDg0dmR2Rk1UMGdaNnduYWdtM2tDUTRr?=
 =?gb2312?B?bXc3dWgyWXpPRVAwZHhWZ0FGRUFOUUVyeE5paWl2aW5XZ3pYZEJ4YVdaRUFq?=
 =?gb2312?B?RFVocFMrcjUzek03ZWlBRk1NZkZteXVpSmZLZ1ZtMjFvRkJyNTZpdGxzT0dp?=
 =?gb2312?B?Tm1GMStkSlBPdGRjbW1maW13d244eHZYTThZeGp2aE5nU1BPYjhQM1N0Y1Y0?=
 =?gb2312?B?UDUrR0NaaDRWSERMSWpIZms1V05DaExPcFhaTlVTOG9iRnA5NlBEUWRtSXJE?=
 =?gb2312?B?S0NYQVpsYi9ZT3ZDTS9yak9GWWJFMmM0Rk1ydHZTR2Zya21HRzQ0cFRVTkQ0?=
 =?gb2312?B?bUFXbUk5algwVytJL2JodGFvYTQxeTNHK3FtZzRlY0I0MFlLZkQya0RzQlAr?=
 =?gb2312?B?dmVQSWFzVG93N1dYSTNiMnMzeGZReUNRd0l1bXgxMEd3VTZ2dGVtUVlpclRZ?=
 =?gb2312?B?OFE1YW1qNHp1cEZrTUx3dERkTEtra2g1Y0cxWjBneHp4V1BXS2MxNlViN2xn?=
 =?gb2312?B?L21VeWhRcG5GZlM4eWxwNWYvWVM1TFlTVEk0STNLcUJUNzh5NTR5dXoraUZi?=
 =?gb2312?B?UXNjTUhNUE1jOVhmQ0krQmdFNE15WVZtdkNlU24yUWdwSFZHeWJSNjFzcjZv?=
 =?gb2312?B?WmQ1UW5xRVYxVzNZOWQxaWRBZkdqN0VoaEFqSUwwWDFMd0EvZHNhb1ZvREJH?=
 =?gb2312?B?RFhNVlpETDJTMkdKa2VWOENFVUdWaVdZUWhDRVgzend2K21mcVBqK2dGbnRO?=
 =?gb2312?B?QlBiOTg5ZkNsRnBtRG96OXR4bWUrQVpPZEhmQ3psYjhXUWlGMmNNSWNaVnhV?=
 =?gb2312?B?WDFMWHZIRXZnRCtISVZ4RnRNaUMzTHh6TDh1UjRmTUJscE44NkFKdG41T1lx?=
 =?gb2312?B?TTlrODhoNEt2Rzd0VG1RNFByK0p2UGVXZmN4RmRUL1h4NWJRcElwTlkxRmNs?=
 =?gb2312?B?NmxvUE9tRHBuWHBXSHJCRkw1dXRQdEg2YUtkL3lZNnNtNWVhVGt3OFFRbjJX?=
 =?gb2312?B?OTZ1d1VsS3lSRGo0a09tMmFYbmZwYUovRkp4a3ZwVGg3dStsdmFkWitFTnlk?=
 =?gb2312?Q?IYa6Gt5VlrihBi4V1ttUKB4cm?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7823103-004f-452d-5655-08da63a60b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 01:30:02.8685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvxajxUVaig5nBzyxUX8xOSIoxmq73Tq7qd5rqaAkWWCLcvcNrAn15vIEjjYPaElbrvHk0JFeKyEb3HQ3pv7rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8563
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
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jfUwjEyyNUgNjoxNw0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGZl
c3RldmFtQGdtYWlsLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Ow0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIDEvMl0gUENJOiBpbXg2OiBNYWtlIHN1cmUgdGhlIERC
SSByZWdpc3RlciBjYW4gYmUgY2hhbmdlZA0KPiANCj4gSGkgUmljaGFyZCwNCj4gDQo+IE9uIFdl
ZCwgTWF5IDE4LCAyMDIyIGF0IDA1OjM1OjI3UE0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0K
PiA+IFRoZSBQQ0lFX0RCSV9ST19XUl9FTiBiaXQgc2hvdWxkIGJlIHNldCB3aGVuIHdyaXRlIHNv
bWUgREJJIHJlZ2lzdGVycy4NCj4gPiBUbyBtYWtlIHN1cmUgdGhhdCB0aGUgREJJIHJlZ2lzdGVy
cyBhcmUgd3JpdGFibGUsIHNldCB0aGUNCj4gPiBQQ0lFX0RCSV9ST19XUl9FTiBwcm9wZXJseSB3
aGVuIHRvdWNoIHRoZSBEQkkgcmVnaXN0ZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2ktaW14Ni5jDQo+ID4gaW5kZXggNjYxOWUzY2FmZmUyLi4zMDY0MWQyZGRhMTQgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtNzk3LDEwICs3
OTcsMTIgQEAgc3RhdGljIGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZQ0K
PiAqcGNpKQ0KPiA+ICAJICogc3RhcnRlZCBpbiBHZW4yIG1vZGUsIHRoZXJlIGlzIGEgcG9zc2li
aWxpdHkgdGhlIGRldmljZXMgb24gdGhlDQo+ID4gIAkgKiBidXMgd2lsbCBub3QgYmUgZGV0ZWN0
ZWQgYXQgYWxsLiAgVGhpcyBoYXBwZW5zIHdpdGggUENJZSBzd2l0Y2hlcy4NCj4gPiAgCSAqLw0K
PiA+ICsJZHdfcGNpZV9kYmlfcm9fd3JfZW4ocGNpKTsNCj4gDQo+IFdoYXQncyB0aGUgc3RhdHVz
IG9mIHRoaXMgcGF0Y2g/ICBJIGRvbid0IHNlZSB0aGlzIGNoYW5nZSBpbmNsdWRlZCBpbiB5b3Vy
IHYxNA0KPiBzZXJpZXMgWzFdLiAgVGhhdCBzZXJpZXMgaGFzIGEgbG90IG9mIGlteDYgdXBkYXRl
cywgc28gSSB3b3VsZCBoYXZlIHRob3VnaHQNCj4geW91J2QgaW5jbHVkZSB0aGlzIGNoYW5nZSBp
biBpdC4gIE9yIG1heWJlIHRoaXMgY2hhbmdlIHR1cm5lZCBvdXQgbm90IHRvIGJlDQo+IG5lZWRl
ZD8NCkhpIEJqb3JuOg0KVGhhbmtzIGZvciB5b3VyIGtpbmRseSBoZWxwLg0KVGhlIHYxNCBzZXJp
ZXNbMV0gaGFkIGJlZW4gcmV2aWV3aW5nIGZvciBhIHF1aXRlIHRpbWUuIEknbSBhZnJhaWQgdGhh
dA0KIHRoaXMgc2VyaWVzIG1pZ2h0IG1pc3MgdGhlIEw1LjIwIG1lcmdlIHdpbmRvdyBpZiBJIGFk
ZCBuZXcgcGF0Y2gNCiBpbnRvIGl0IGZyb20gdGltZSB0byB0aW1lLg0KSWYgeW91IGRvbid0IHRo
aW5rIHNvLCBJIGNhbiBtZXJnZSB0aGUgZmlyc3Qgb25lLCBhbmQgcmUtaXNzdWUgdGhlIHYxNSBh
DQptb21lbnQgbGF0ZXIuDQo+IA0KPiBXaGF0IGFib3V0IHRoZSAyLzIgcGF0Y2g/DQppLk1YOE1Q
IFBDSWUgc3VwcG9ydHMgdGhlIFBDSWUgR0VOMyBzcGVlZCwgdGhlIHNlY29uZCBwYXRjaCBpcyB1
c2VkIHRvIGV4dGVuZA0KIHRoZSBsaW5rIHNwZWVkIHN1cHBvcnQgY2FwYWJpbGl0eSwgYW5kIHBy
ZXBhcmVkIGZvciBpLk1YOE1QIFBDSWUgc3VwcG9ydC4NCkkgYXNzdW1lZCB0aGF0IHRoZXNlIHR3
byBwYXRjaGVzIGNhbiBiZSBjb250YWluZWQgaW4gaS5NWDhNUCBQQ0llIHN1cHBvcnQNCnBhdGNo
LXNldCBiZWZvcmUuDQoNCj4gDQo+IFRoZXkncmUgYm90aCBtYXJrZWQgIlJGQyIgd2hpY2ggaXMg
c29tZXRpbWVzIGEgaGludCB0aGF0IHRoZSBhdXRob3IgaXNuJ3QNCj4gcmVhbGx5IGNvbW1pdHRl
ZCB0byB0aGUgcGF0Y2gsIHNvIHNvbWV0aW1lcyB0aGV5IGRvbid0IGdldCB0aGUgYXR0ZW50aW9u
IHRoZXkNCj4gZGVzZXJ2ZS4NCj4gDQpJIHNlZS4gV291bGQgcmVtb3ZlIHRoZSAiUkZDIiB3aGVu
IGlzc3VlIHRoZSBwYXRjaCBuZXh0IHRpbWUuDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmlj
aGFyZCBaaHUNCg0KPiBCam9ybg0KPiANCj4gWzFdDQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvcmUua2VyDQo+IG5l
bC5vcmclMkZyJTJGMTY1NjY0NTkzNS0xMzcwLTEtZ2l0LXNlbmQtZW1haWwtaG9uZ3hpbmcuemh1
JTQwbnhwLmNvbQ0KPiAmYW1wO2RhdGE9MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20l
N0M2MmU5ZDA3MDMxMzA0ODU4OQ0KPiA5MDMwOGRhNjM4YjE4YjQlN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDDQo+IDYzNzkzMTc0NjMxMDE4ODc3NCU3Q1Vua25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3DQo+IE1EQWlMQ0pRSWpvaVYybHVNeklp
TENKQlRpSTZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyUNCj4gN0MmYW1wO3Nk
YXRhPU96MlpnZGNoMGdJMlFkNjZBaU01aVdtcDIzdXduMVNrSDA3Z0RBUWhHUVklM0QNCj4gJmFt
cDtyZXNlcnZlZD0wDQo+IA0KPiA+ICAJdG1wID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBvZmZz
ZXQgKyBQQ0lfRVhQX0xOS0NBUCk7DQo+ID4gIAl0bXAgJj0gflBDSV9FWFBfTE5LQ0FQX1NMUzsN
Cj4gPiAgCXRtcCB8PSBQQ0lfRVhQX0xOS0NBUF9TTFNfMl81R0I7DQo+ID4gIAlkd19wY2llX3dy
aXRlbF9kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NBUCwgdG1wKTsNCj4gPiArCWR3X3Bj
aWVfZGJpX3JvX3dyX2RpcyhwY2kpOw0KPiA+DQo+ID4gIAkvKiBTdGFydCBMVFNTTS4gKi8NCj4g
PiAgCWlteDZfcGNpZV9sdHNzbV9lbmFibGUoZGV2KTsNCj4gPiBAQCAtODA5LDYgKzgxMSw3IEBA
IHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUNCj4gPiAqcGNp
KQ0KPiA+DQo+ID4gIAlpZiAocGNpLT5saW5rX2dlbiA9PSAyKSB7DQo+ID4gIAkJLyogQWxsb3cg
R2VuMiBtb2RlIGFmdGVyIHRoZSBsaW5rIGlzIHVwLiAqLw0KPiA+ICsJCWR3X3BjaWVfZGJpX3Jv
X3dyX2VuKHBjaSk7DQo+ID4gIAkJdG1wID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBvZmZzZXQg
KyBQQ0lfRVhQX0xOS0NBUCk7DQo+ID4gIAkJdG1wICY9IH5QQ0lfRVhQX0xOS0NBUF9TTFM7DQo+
ID4gIAkJdG1wIHw9IFBDSV9FWFBfTE5LQ0FQX1NMU181XzBHQjsNCj4gPiBAQCAtODIxLDYgKzgy
NCw3IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3BjaWUgKnBj
aSkNCj4gPiAgCQl0bXAgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfTElOS19XSURUSF9T
UEVFRF9DT05UUk9MKTsNCj4gPiAgCQl0bXAgfD0gUE9SVF9MT0dJQ19TUEVFRF9DSEFOR0U7DQo+
ID4gIAkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9MSU5LX1dJRFRIX1NQRUVEX0NPTlRS
T0wsIHRtcCk7DQo+ID4gKwkJZHdfcGNpZV9kYmlfcm9fd3JfZGlzKHBjaSk7DQo+ID4NCj4gPiAg
CQlpZiAoaW14Nl9wY2llLT5kcnZkYXRhLT5mbGFncyAmDQo+ID4gIAkJICAgIElNWDZfUENJRV9G
TEFHX0lNWDZfU1BFRURfQ0hBTkdFKSB7DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBs
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGbGlzdHMNCj4gPiAuaW5mcmFkZWFkLm9yZyUyRm1h
aWxtYW4lMkZsaXN0aW5mbyUyRmxpbnV4LWFybS1rZXJuZWwmYW1wO2RhdGE9MDUlNw0KPiBDMA0K
PiA+DQo+IDElN0Nob25neGluZy56aHUlNDBueHAuY29tJTdDNjJlOWQwNzAzMTMwNDg1ODk5MDMw
OGRhNjM4YjE4YjQlDQo+IDdDNjg2ZWExDQo+ID4NCj4gZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMCU3QzYzNzkzMTc0NjMxMDE4ODc3NCU3Q1Vuaw0KPiBub3duJTdDVFcNCj4gPg0K
PiBGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJ
azFoYVd3aUxDSlhWDQo+IENJNg0KPiA+DQo+IE1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3Nk
YXRhPW1HNml4OFZxcVdvY3BwNjJHSVd4Z1FPcEUNCj4geFNDTURKaXZ0byUyDQo+ID4gQm1xZ09a
SHMlM0QmYW1wO3Jlc2VydmVkPTANCg==
