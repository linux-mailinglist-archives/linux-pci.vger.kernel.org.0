Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6169617849
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 09:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiKCIFf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 04:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKCIFe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 04:05:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60078.outbound.protection.outlook.com [40.107.6.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3C3116C;
        Thu,  3 Nov 2022 01:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOpXjxXCFbu4L1boYBphEULJMNrWvHx0IRNdVM7M+6bM0YgccsIJo2mb+oJLcxzWmqj4+u9ZEC5zK4qbclSQoAQT/jGWepaX2n9jJFZ9temprFWHIH0tMjUyOku1pXWDF0XUmE723Hj1fZE2NvqhbobMrT9IG1lGpQvArUZ5mMQtkLsYmFRqm+QNC72UJlGK4lhApKnwi5acEqfExR/hImO4JKuPAoz9oSnsBnrh3ljDzp54X/p1tqWHj88IXbfQAA1OhO8/DYTOBQWr7Xkj+8cnOEhEjVyiK+UW+9iqrFR2yaH0LhOA1cjlEcDmRgx7dWZSO2tVAIahuvCb97TrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjneVe6/d575kZ1XVhNRo8en1PIvhJiA8wF4OMCfwFM=;
 b=JyGnt3QHlkDQ6KOktyH3qrlFDr46N1+1oMcSEX1ksSGczZl3iVZKXSXXqXGZxo+flKnRrUmW6lu6unjPjCJIWvLGpcCPTuhWVND03SgAy8i0bGpaJvJleXgvccSXKVbVQ0fjqsqWHReyAm3L5Hdgh58aLZEfH3ZURYLNKIXP9ETrT8Gah02dQx5zgfhUDFcTvULg8ODMxHA3aunUuJyYVLSTj0OGg2oMtKnXID3Zn9zRF4ZaTJAVDxdQR7MuG2Mp4r0NjBMYVIMmAGhh/8fD2SDeczpGRkr/rs8u1IVm0Ez8YkkfQ4MgUE7jCbJphJBp8ZDwuhlZMtKrc/Nu4Rz/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjneVe6/d575kZ1XVhNRo8en1PIvhJiA8wF4OMCfwFM=;
 b=dPbuJ9JoYru3SHumd0CcPG309wuvndBJtW9hZbSWBtFNSPe0Jwv5LHx23PbunKkWDjufXl+x3uWdf+4KAFdz/CMHUYI0y/jdR7seGlsvAAxkhas/0tTYpdaAh5KDcv/jp18JziPdfKBoVtQC68UkanjedPbXkM/gBSJqr51gMpY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7197.eurprd04.prod.outlook.com (2603:10a6:800:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 08:05:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 08:05:27 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
Thread-Topic: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
Thread-Index: AQHY702b+QfiU75Jy0iV08bNcaBQXq4sxpYAgAALjtA=
Date:   Thu, 3 Nov 2022 08:05:27 +0000
Message-ID: <AS8PR04MB8676B8B896C3A4F2F4BAF6D28C389@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
 <ff2f43f9-b04e-a224-02c2-d446a68c5337@pengutronix.de>
In-Reply-To: <ff2f43f9-b04e-a224-02c2-d446a68c5337@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|VI1PR04MB7197:EE_
x-ms-office365-filtering-correlation-id: 63d7df9f-a2f7-4073-114e-08dabd722b1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2WSty2a2TD7/Y2dQAyph1NRNIKVRldbPr9c8jhBWKazZ5pQkGfPApY5P6fJKo+T3muMeAp5HNZUoAEjir1LG99uTxL+MA2na+7oD6NRK/ccyxYqZL7QuCg9TFYxm6D3Me9XzeMPIz+G7mgbbuq1SuWR3SJGCdyLGoqGq7yZOYhV+W7a02CRFdFIna7qYXZApTgKETDnRMQtEtytgv7FYbNikC7puA5LR8R4ymVfeEFotY6f3C8ATsjFui01W6ANbuWFa9x/3pZ/mTzrZT5VBOpjiMhcHGusu4AU8NKFLvOohvb3yE/zLrPp7T0/Ykn2WFsFpxZc+Pe0iG4V6ScRNXoK/QgagTZ16qymBKxJ0vadCCrl/ov4FzXtklR54jh2ikEN6q0aC8B0QVH2qj2R9/emgS2t/I14TNfto1YCxH4gQiZ8nqi0WaSrEJ5smbsl60Es92xN0xTYEhC5JXi8tKjQiUuRJ7OVogIPZMRO539EdfHWJtmxanUxfgf//dKRiqwdvOMk7HYj8iSetLguMfRUXb62hQ1BYhRGjmVLapt1zN8p2SROKFyAq4lX/2fVjXs98nlbSgO0UKevV7BXno1Nm2Wd9ZwCEZOKRsGUngma5J4bfOOUIsvA4ojy333wTilpaddah54qzoL/6JymjtoVPLd2W5xhz2MEY1RCwtvdSRBUX0bHJgvOmPgBiCkTxTxAL8Yao5rYSGRHNoCJe1ppuZJKeuSiutd+ZwNBjxnRNEXSM+iFbv1qExFdkluDBbGfFktq3gsQeG0GuGnRXJnEBGDbGJqWijFe0z420tFM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(2906002)(83380400001)(33656002)(66446008)(55016003)(8676002)(66476007)(53546011)(66556008)(41300700001)(52536014)(26005)(4326008)(9686003)(38070700005)(86362001)(64756008)(316002)(54906003)(122000001)(38100700002)(110136005)(44832011)(45080400002)(5660300002)(6506007)(66946007)(478600001)(7696005)(76116006)(71200400001)(186003)(8936002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?L3I4RisrTG1tNDM4S3AwUE9JQ3R3Y0lmODFLTHR5UVhYSUhJQ2NhbWpBV0h4?=
 =?gb2312?B?djZPVnFSQ1RRVUR6cGwzanhzekZaeEU3S2FkTGVQemt6VXlTY3J2dWN2ak1P?=
 =?gb2312?B?QnpnZDdUaFByM2trOWNBTHlFZndmejhXTUdHTkIrRm93NXBWVWhuZGZURTll?=
 =?gb2312?B?aU04SVBYRGIyQkl4c2pBVGlnRU1hQmFLUTZPdlpjV1hlT1QrbGVoNGdza1Zp?=
 =?gb2312?B?MGJwcEJBdHlyaFFLOGtUOVhpVzdkaEdXeTR0QjBvMDQxNEdzS0xWdlh6RmRI?=
 =?gb2312?B?NzU5VlFoRVIweU5wVzQ3QXllQUtydDdDMmw4SjhoZ2J2ZjFTU0h6REEzbFpw?=
 =?gb2312?B?REZmd2tlL2JJdmF1MDNTZ0JEMDNuZWM1QWFXYlFFSktWZllNVXM1UUNVb2g4?=
 =?gb2312?B?Zm15ZGdJYkh0QnlyalNiSXRSZ2dDcU5nMkpxV3NEVEhLcy9Tb0pCMFN3cmhL?=
 =?gb2312?B?L004eGUzVkpmNnp0TmJVaWhSYjlJRkt2dDI5STZzUE5IOE0wQlMxVHgybW5i?=
 =?gb2312?B?aFo5NW81dmZBSU04MEdtMTdURitHTmJzMW5GRmJadC9veWJtdDN2aGNGWG43?=
 =?gb2312?B?MDM0VXNLRCtCd045bGxtMHNqUXRITGl0S2ZMNmRNSFFkUEZwS0VwN2FKcUlD?=
 =?gb2312?B?VE13OWFhWEhKNnYyV0M3dzdabjFyaTJQQm1HM1BKamhETWdaS3NLVjJwMEVx?=
 =?gb2312?B?RUE2OHBUR2ZyVUkxLzRLejlWUWhobjNVY25jRG5nUEcrTkhiYVA0OTFGdzh4?=
 =?gb2312?B?dzBkakRQc2xUVVBaMU1oMzkwYTRBR2xpQnd5YU04bGdZNVVadExaZW95bVBZ?=
 =?gb2312?B?MlBuR2sxWlhXclRROHQ3V0sxMXdPc3k1cFNZTDE4K3Y5WmEweUJXdEdDMTh4?=
 =?gb2312?B?NEovQlN4cHFEQVJlV1d1aGRuZWtaK3o5Z0JGS29xMkY1MkxpRFZpUHVSMGMr?=
 =?gb2312?B?Tms5eWttQlA0d0k2dThyZDVkMmNvZGpOU1FUZmZ2RnZlbnBmVHgxZVJ1QSti?=
 =?gb2312?B?OEg1VDNKVUJIK3ZwK2x4TFFudjBtV0pkS2sxRjdROTczTkdqaXUybUZtclVR?=
 =?gb2312?B?bkJhc3dGQlpyNUZvSTVNZ0RlZVRmbDJBeHorM2hRY1JUU0FQSHk1R0JFNFYv?=
 =?gb2312?B?M3lSRTZKNTJQYWFuajJ0RGN6M0FoQzlQeGZya2JUZDZtY1N4a1drZGdKQ1Mv?=
 =?gb2312?B?WHJxTllUeVFQcjNacEJsRXpXRDNxc2lGM0lha3FDM3kzeFNRMnRiVGFuZXQz?=
 =?gb2312?B?RUEyUTB4Z3lmSEJSZEhDb2RLVnh5REx2N2pXMVA2NWFsWG9wcWtUQ0MvazR5?=
 =?gb2312?B?L1BRVElLL3NRSUlua0UrR0RjZ3FTTWl2WnAxc0YwS1ZDNUVLbVpwWkVRNlMr?=
 =?gb2312?B?bXJISWlhbzRSWWlFYXFib3RMNlNlcWxvdTNrY2l3UzVpUXpGdmNIOFZKVUJ6?=
 =?gb2312?B?UHhmSDdtRXFlYXRCZDBQYWRYZmdIQm0ybDhWSFQrdVhrZzVpRFdpci9YOFBa?=
 =?gb2312?B?MmFYQUYwNkxEZFN4SmV0RmFodHc5R25iTUVnQzVEUUhZODNtdi9ab1REVnNw?=
 =?gb2312?B?SVk2aTJBRXdMMU55aS9YM0tsbG45dDQveXc3WGpQZWNUTW85bkNjZTkwU0Q1?=
 =?gb2312?B?TlMwVEVDdGl0RWVBWElYZkQwV2QzaHk2MDBpbFNsL29oa1BhR1lJa3pRUGtQ?=
 =?gb2312?B?L2l3a3V4UlJLcHQraGlxMEx0MUh4bVhZT3VtaDI4cURvZ0R4ZmNXaFYrRUhJ?=
 =?gb2312?B?Sis4WmZQY09qYklRaXVLelhhamdycmFLUWxYRHlGcjB5emh2b0VEM0oveTdJ?=
 =?gb2312?B?VEgrbVB0NGR1R05LM0ExeUttTi9Ed2poc1VtY1kyU2pJeUtzQmZ4a3JJcTJ6?=
 =?gb2312?B?K3VEaE5mSWtYcU5FOXlSMG5NNFFhNmJobDhBSXpqM1YwcmluaGg1YTA1dDNx?=
 =?gb2312?B?Yk9OSkZPRVAyMStqaFQxUlVGTE5PeDlRWm5UV245WThNZTd2VHNwakhvS1Va?=
 =?gb2312?B?V3hUYTBBOHFkR3B0b1JNUTkxQWxjNTg1Uy8zV05vS1kvNW15NmRoaGhSR3ll?=
 =?gb2312?B?dXA4QUN6YzdyRzN6Qm40WW5zQ0RJaWRUTW5EZUVGTGxmeDRITy9UbS9WVU1s?=
 =?gb2312?Q?johVqrDs0Y6VxWmkBkMPMe+jP?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d7df9f-a2f7-4073-114e-08dabd722b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 08:05:27.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzjH4PVWqbIbSgGxyvU2Lu9/fvUWc/sj3iSxmxKWryRbv5IJldooK6NwEa1eIfM/V9B4SQiPyyUX5Qy1ytiDXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWhtYWQNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWhtYWQgRmF0b3VtIDxhLmZhdG91bUBwZW5ndXRy
b25peC5kZT4NCj4gU2VudDogMjAyMsTqMTHUwjPI1SAxNTowNQ0KPiBUbzogSG9uZ3hpbmcgWmh1
IDxob25neGluZy56aHVAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7DQo+IGJoZWxn
YWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gQ2M6IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4
LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxXSBQQ0k6IGlteDY6IEtlZXAgdGhlIEdQSU8gcmVndWxhdG9yIGFsd2F5cyBvbg0KPiANCj4g
SGVsbG8gUmljaGFyZCwNCj4gDQo+IE9uIDAzLjExLjIyIDA3OjA4LCBSaWNoYXJkIFpodSB3cm90
ZToNCj4gPiBTaW5jZSB2cGNpZSByZWd1bGF0b3IgaXMgb25lIEdQSU8gcmVndWxhdG9yLCB1c2Vk
IHRvIGNvbnRyb2wgdGhlDQo+ID4gVlBDSWVfM1YzIGFuZCBwb3dlciB1cCByZW1vdGUgUENJZSBF
UCBkZXZpY2UuDQo+IA0KPiBSZWd1bGF0b3IgbmVlZCBub3QgYmUgYSBHUElPIHJlZ3VsYXRvci4g
SSdkIGRyb3AgdGhpcyBmcm9tIHRoZSB0aXRsZS4NCj4gDQpHb3QgdGhhdCwgdGhhbmtzLg0KDQo+
ID4gU29tZSBXSUZJIG1vZHVsZXMgbG9hZCB0aGVpciBmaXJtd2FyZSBvbmNlIGluIHByb2JlLCBh
bmQgY2FuJ3QgYmUNCj4gPiBwb3dlcmVkIG9mZiBkdXJpbmcgc3VzcGVuZC4gT3RoZXJ3aXNlLCB0
aGVzZSBXSUZJIG1vZHVsZXMgd291bGRuJ3QgYmUNCj4gPiBmdW5jdGlvbmFsIGFueW1vcmUgYWZ0
ZXIgcmVzdW1lIGJhY2suDQo+IA0KPiBUaGUgYnJjbWZtYWMgT1RPSCwgcmVwcm9iZXMgd2hlbiBy
ZXN1bWluZyBmcm9tIHN1c3BlbmQuIEJlZm9yZSB0aGlzIHBhdGNoLA0KPiBBRkFJVSwgaXQgc2hv
dWxkJ3ZlIGJlZW4gcG9zc2libGUgZm9yIHRoZSBFUCB0byBnbyBpbnRvIEQzY29sZCBkdXJpbmcg
c3VzcGVuZC4NCj4gVGhpcyBtYXkgbm8gbG9uZ2VyIGJlIHBvc3NpYmxlIHdoZW4gd2Uga2VlcCB2
cGNpZSBwb3dlcmVkLg0KPiANCk9oLCB1bmRlcnN0b29kLiBJbiB0aGUgb3RoZXIgd29yZHMsIHRo
ZSBFUCB3b3VsZG4ndCBiZSBpbiBEMyBtb2RlIHdoZW4gdnBjaWUNCiBpcyBhbHdheXMgcG93ZXJl
ZCBvbiwgcmlnaHQ/DQpUaGFua3MgZm9yIHlvdXIgZGV0YWlsZWQgZXhwbGFpbnMuDQoNCj4gPiBT
bywga2VlcCB0aGlzIHJlZ3VsYXRvciBhbHdheXMgb24gaW4gdGhlIHByb2JlLg0KPiA+DQo+ID4g
Rml4ZXM6IGE0YmI3MjBlZWIxZSAoIlBDSTogaW14NjogVHVybiBvZmYgcmVndWxhdG9yIHdoZW4g
c3lzdGVtIGlzIGluDQo+ID4gc3VzcGVuZCBtb2RlIikNCj4gDQo+IFByaW9yIHRvIGE0YmI3MjBl
ZWIxZSwgdnBjaWUgd2FzIGJyaWVmbHkgdG9nZ2xlZCBkdXJpbmcgUENJZSBjb3JlIHJlc2V0DQo+
IHNlcXVlbmNlLCBzbyBhZm9yZW1lbnRpb25lZCBXaUZpIG1vZHVsZXMgdGhhdCBkb24ndCByZXBy
b2JlIG92ZXIgcmVzdW1lDQo+IHNob3VsZCd2ZSBiZWVuIGJyb2tlbiBieSB0aGF0IHRvbz8gSWYg
c28sIEkgZG9uJ3Qgc2VlIGhvdyBpdCBmaXhlcyB0aGF0IGNvbW1pdA0KPiBhcyBldmVyeXRoaW5n
IHRoYXQgaXMgYnJva2VuIG5vdyB3YXMgYnJva2VuIGJlZm9yZSB0aGF0IGNvbW1pdCBhcyB3ZWxs
LiBBZnRlcg0KPiB0aGlzIHBhdGNoIGhvd2V2ZXIsIG1vZHVsZXMgdGhhdCBjYW4gYWNjZXB0IHZw
Y2llIGJlaW5nIHRvZ2dsZWQgY2FuJ3QgYmVuZWZpdA0KPiBmcm9tIHNvbWUgb2YgdGhlIHBvd2Vy
IHNhdmluZy4NClRoZSBXSUZJIG1vZHVsZXMgdGhhdCBkb24ndCByZS1wcm9iZSBvdmVyIHJlc3Vt
ZSBhcmUgYWx3YXlzIGJyb2tlbiwgaWYgdGhlDQogdnBjaWUgaXMgdG9nZ2xlZCBkdXJpbmcgc3Vz
cGVuZC9yZXN1bWUsIEkgdGhpbmsuDQoNCkJUVywgaXMgdGhlIHJlLXByb2JlIG92ZXIgcmVzdW1l
IG1hbmRhdG9yeSByZXF1aXJlbWVudHMgZm9yIEVQIGRldmljZXMNCihmb3IgZXhhbXBsZSwgV0lG
SSBtb2R1bGVzKT8NCkknbSBjdXJpb3VzIHRoYXQgaG93IHRoZSBXSUZJIHJlbW90ZSB3YWtlIHVw
IGdvaW5nIG9uIGlmIHRoZSBXSUZJIG1vZHVsZQ0KIGlzIHRvdGFsbHkgcG93ZXJlZCBvZmYuDQoN
Cj4gDQo+IFdoeSBjYW4ndCB1c2VycyB3aXRoIHRoaXMgaXNzdWUgdXNlIGEgcmVndWxhdG9yLWFs
d2F5cy1vbiByZWd1bGF0b3IgaW5zdGVhZD8NClllcywgeW91J3JlIHJpZ2h0Lg0KT25lIHJlZ3Vs
YXRvci1hbHdheXMtb24gcmVndWxhdG9yIGlzIGEgZ29vZCBpZGVhLg0KDQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyB8IDI0ICsrKysrKysrLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNiBk
ZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14
Ni5jDQo+ID4gaW5kZXggMjYxNjU4NWNhNWY4Li45NGE4OWJiZjM4MWQgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtOTI2LDIyICs5MjYsMTMg
QEAgc3RhdGljIGludCBpbXg2X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2llX3JwDQo+ICpw
cCkNCj4gPiAgCXN0cnVjdCBpbXg2X3BjaWUgKmlteDZfcGNpZSA9IHRvX2lteDZfcGNpZShwY2kp
Ow0KPiA+ICAJaW50IHJldDsNCj4gPg0KPiA+IC0JaWYgKGlteDZfcGNpZS0+dnBjaWUpIHsNCj4g
PiAtCQlyZXQgPSByZWd1bGF0b3JfZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+IC0JCWlm
IChyZXQpIHsNCj4gPiAtCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxlIHZwY2llIHJl
Z3VsYXRvcjogJWRcbiIsDQo+ID4gLQkJCQlyZXQpOw0KPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+
IC0JCX0NCj4gPiAtCX0NCj4gPiAtDQo+ID4gIAlpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQo
aW14Nl9wY2llKTsNCj4gPiAgCWlteDZfcGNpZV9pbml0X3BoeShpbXg2X3BjaWUpOw0KPiA+DQo+
ID4gIAlyZXQgPSBpbXg2X3BjaWVfY2xrX2VuYWJsZShpbXg2X3BjaWUpOw0KPiA+ICAJaWYgKHJl
dCkgew0KPiA+ICAJCWRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGVuYWJsZSBwY2llIGNsb2Nrczog
JWRcbiIsIHJldCk7DQo+ID4gLQkJZ290byBlcnJfcmVnX2Rpc2FibGU7DQo+ID4gKwkJcmV0dXJu
IHJldDsNCj4gPiAgCX0NCj4gPg0KPiA+ICAJaWYgKGlteDZfcGNpZS0+cGh5KSB7DQo+ID4gQEAg
LTk3NCw5ICs5NjUsNiBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9ob3N0X2luaXQoc3RydWN0IGR3
X3BjaWVfcnANCj4gKnBwKQ0KPiA+ICAJCXBoeV9leGl0KGlteDZfcGNpZS0+cGh5KTsNCj4gPiAg
ZXJyX2Nsa19kaXNhYmxlOg0KPiA+ICAJaW14Nl9wY2llX2Nsa19kaXNhYmxlKGlteDZfcGNpZSk7
DQo+ID4gLWVycl9yZWdfZGlzYWJsZToNCj4gPiAtCWlmIChpbXg2X3BjaWUtPnZwY2llKQ0KPiA+
IC0JCXJlZ3VsYXRvcl9kaXNhYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+ICAJcmV0dXJuIHJl
dDsNCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTk5MSw5ICs5NzksNiBAQCBzdGF0aWMgdm9pZCBpbXg2
X3BjaWVfaG9zdF9leGl0KHN0cnVjdCBkd19wY2llX3JwDQo+ICpwcCkNCj4gPiAgCQlwaHlfZXhp
dChpbXg2X3BjaWUtPnBoeSk7DQo+ID4gIAl9DQo+ID4gIAlpbXg2X3BjaWVfY2xrX2Rpc2FibGUo
aW14Nl9wY2llKTsNCj4gPiAtDQo+ID4gLQlpZiAoaW14Nl9wY2llLT52cGNpZSkNCj4gPiAtCQly
ZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29wcyBpbXg2X3BjaWVfaG9zdF9vcHMgPSB7
IEBADQo+ID4gLTEyNjMsNiArMTI0OCwxMyBAQCBzdGF0aWMgaW50IGlteDZfcGNpZV9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAJCWlmIChQVFJfRVJSKGlteDZf
cGNpZS0+dnBjaWUpICE9IC1FTk9ERVYpDQo+ID4gIAkJCXJldHVybiBQVFJfRVJSKGlteDZfcGNp
ZS0+dnBjaWUpOw0KPiA+ICAJCWlteDZfcGNpZS0+dnBjaWUgPSBOVUxMOw0KPiA+ICsJfSBlbHNl
IHsNCj4gPiArCQlyZXQgPSByZWd1bGF0b3JfZW5hYmxlKGlteDZfcGNpZS0+dnBjaWUpOw0KPiA+
ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gZW5hYmxlIHZw
Y2llIHJlZ3VsYXRvcjogJWRcbiIsDQo+ID4gKwkJCQlyZXQpOw0KPiA+ICsJCQlyZXR1cm4gcmV0
Ow0KPiA+ICsJCX0NCj4gDQo+IFNob3VsZG4ndCB0aGUgcmVndWxhdG9yIGVuYWJsZSBiZSB1bmRv
bmUgaWYgdGhlIHByb2JlIGxhdGVyIGZhaWxzPw0KPiANClllcywgaXQncyByZXF1aXJlZC4NClRo
YW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cy4NCg0KUmljaGFyZCBaaHUNCkJlc3QgUmVnYXJk
cw0KPiBDaGVlcnMsDQo+IEFobWFkDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfA0KPiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3LnBlDQo+IG5ndXRyb25peC5kZSUyRiZh
bXA7ZGF0YT0wNSU3QzAxJTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzA2ZjUNCj4gMzYzMzQy
Yzk0NjRiY2E1YTA4ZGFiZDY5YmRiNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1
DQo+ICU3QzAlN0MwJTdDNjM4MDMwNTU5MDk0ODc1MTk1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNk
OGV5SlcNCj4gSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dp
TENKWFZDSTZNbjAlM0QlN0MzDQo+IDAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9MzZmcHZlVkJnS3Jh
WUllRUpqTVNpUEExMGF6QmZoaEhyTlZZVGFvY04NCj4gblElM0QmYW1wO3Jlc2VydmVkPTAgIHwN
Cj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhvbmU6DQo+
ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwgSFJBIDI2
ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQoNCg==
