Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946215A5A6D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 05:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiH3Drs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 23:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiH3Drr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 23:47:47 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00087.outbound.protection.outlook.com [40.107.0.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C26910A5;
        Mon, 29 Aug 2022 20:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYOkEPRe68hdeaC38f9zSwnuYusaO0518R+6Y+IK26HkpINt9WbnSpBw09mdcMXI9PBIEjXxk3LkYZs6WmTUkX+mQGjWg546ADAwk3tuQ6r4kz7L9h5yfETAvYdcOCRD4RgJ5BZp1+kFj+kfM0xsiHJ/ZDcWD6zFKRi9yU/uo6OHGS+SiBLpvfKR17zgW70j1JwNH2b1pWdLpaeIAd1A0wyuXqgjxir/hwqCwa7/UIRSBkw+f5qleRnCGdzQophxQAf7mH+lldbF9U2d67ODMuO2Wt0UYRcouQHo8KbJETHtv4kd/QA4RSp1DArez+eDkBmv/5CASbcRxnzUIlMVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzLTJLwJS9Ro7Cnzg2J0qyFVCTSfU4utBO0jpWJL5Jw=;
 b=QsdSJ/Wmp/L1MuUMN0BBDHH3UEwqh1UOQw2/UBfp+YUy6XJ5ELMsgRWm4to9I//uHnDVLJsQby1wL6VqZ169PI9RcgLhyKnMKDLQ2zzszF1bOUX+zB4CCgSkj3FQLx89sciOaDg93P3yPNmFeecvXRPsN+3eJjI2OzXmueE4QNm7Tkeb48oKFflvUhYjB8J5eChDly43LIflBn0ahsmAjkxM30HTF/riLLnIrmvAnz9Do05siZvlck9ugysWGYwldSDeB87O5BebeWJwprX9JQeo38vKXerNxzZrZmI5Dbvkbxbh5PJXceGWVJeLYxRpzs61YaSB+NHimB7IkYQSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzLTJLwJS9Ro7Cnzg2J0qyFVCTSfU4utBO0jpWJL5Jw=;
 b=B6d93+xAKp+0ImyxYt1Da/RcXsKZS8E1o5NcimJQZ9of+ssr817S081Nn+vQB+kdMN97zZ2Sek/CGCb2Gk9ixcNrfB/gGCU1wj21BzYKkEjm+flYEjEZCQBCO8f2D5Sb5MCwDKwa9JKP0vKPAxUp8qA082n2Qfq+BAjAKcoXY18=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB9497.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 03:47:42 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::13c:5622:af8a:b2da%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:47:42 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Topic: [PATCH v1 0/2] Fix the wrong order of phy callbacks
Thread-Index: AQHYtisJvWRatmeqJkC37ps54LPbAa3FdjaAgAFfrrA=
Date:   Tue, 30 Aug 2022 03:47:42 +0000
Message-ID: <AS8PR04MB86767CFA73F8C639EDD16A298C799@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1661173856-1192-1-git-send-email-hongxing.zhu@nxp.com>
 <e6d5f688-f4c3-6094-91f6-a160b601c07d@pengutronix.de>
In-Reply-To: <e6d5f688-f4c3-6094-91f6-a160b601c07d@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b3718b3-72b4-4439-1214-08da8a3a64b1
x-ms-traffictypediagnostic: DB9PR04MB9497:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kV4lkFE0TRJbTM+6q9cwWQzfJa4RyDVOJIx44o/tWr1sArGvIQBjOf0QuVj3r/UZWGQma/5to8jyyLAofXL9l0p0pKPXzYOC651a04S0cJ1bZLmpQ1KEqNOnj/Bdj0pFJ0kTHuMACixQKVuIMbkv1jNSoOzmiRqum6WKxn1cOQkrZypwT8UPXqUNNMDBnFBN9FTas4YUIrVMALnE2523GIFRamkf/ytR163iBb4C4cuFp/EYg2lpjlkMYgCFeVa8+nKs9HdJiYIkXV43Y2KJ7wJgiAtJLAU8QkUpYrrh87vbtFFzhuqwgcE9Tr4/4xKQ3H4MZOV7ZtIX2sI3mD+I2Z4+YaHjQJqrZ3HncShTZuja8x6dRW54x6YA+GYDybrsNcaGf5uLY3h7CyRbm93s6qdvUmSytm7zqW5kx2/cpi7pym2dSwyT78D9e07AMJdbeSNVAHq2DzUxS98pgXdLlibx48oE/dHGO0ntJM+TphIHaAmIWAdcxfzCih7XJ+Bhqn1+FTJDBY9os2mK6sA+qqCAJ5aqJtVDVyIsEsxVtpaTPzP+TRHMOa9Urt9WmDGlaCDY02Y1EdpJIb31v51S6goPsL7X3XBxkb2NK3j8UMgL5eismGNCDcIkQfPwnexddCe+5wwyUMyAUhPHNkXInyiyGotKxHIrOUiMr2yyQH7/pk1Ma7t6P5IIy02BnvKzTMIxBOvXptVBbxvm6v1v1HkUpxLQy/E8YGAB4BzH7O88+v5SXysCN8J0VzWd+EAJyzVNfC8N6OGqeJIQRmTT4jFnsHInNgujuWHVu/SUiPg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(4326008)(66946007)(5660300002)(41300700001)(316002)(110136005)(54906003)(478600001)(7416002)(8676002)(66556008)(66446008)(64756008)(52536014)(966005)(76116006)(66476007)(45080400002)(86362001)(71200400001)(38070700005)(55016003)(8936002)(6506007)(26005)(53546011)(186003)(33656002)(7696005)(38100700002)(9686003)(44832011)(2906002)(122000001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZEhzbWU2dXhUejBYRVUzSVhOZ0JaNGprbEE5NDBhZWMzcEtrd1lTZm9ZT01q?=
 =?gb2312?B?OERIWUswbjE2Z3JSL1hOMEtmRUg1dG5sakU3Z2wrL2xTaFc2UElHdFFLcVB0?=
 =?gb2312?B?ZUtjbytzQmJQQmV6eWhTK2dQTStHTVNWdmM4RWJtRTE2NXBXVklKSG9xRi9w?=
 =?gb2312?B?MDl4RkhRajZlNjI3QlRkUm1QYzNPTFp1TGtUKzR3S2dKY0QyamhNMU5FdVlo?=
 =?gb2312?B?UEJkWHBVRHl4Slg0b3ljNGNzcWtscldXMHRwd0QrLy95dzgvQUxyMExDUkgy?=
 =?gb2312?B?RWpmWEhJcXlncFkyekJhck1KKzRmdXBRWnNkOW5sc0RnYmNqOWs2cXRRcERo?=
 =?gb2312?B?SjVkQVYxOE9pMnR3Qnd2YUlZM20vSm5VT0Y2VCtSczBjZGV1VDdTNko5Zmdn?=
 =?gb2312?B?T2NvZ0Z2NUp6R1dtaDZCR0JHVDZWeXg3eGlkM0R5d1ZhTFJHR1k4eGlyUlpX?=
 =?gb2312?B?eS9JY3NUc1J4QkJBaktpY3RrN2luVng5Zmpma3hBRklYWmwyMFFlcFR1UWs5?=
 =?gb2312?B?SmhmcUFXOXE0cy9qeG5BOTJjN3FiQlhEdVNqM3ZkVVdUQ1J0VEd1Njhqc2ha?=
 =?gb2312?B?U0ozWGh5dTdoT2ZIeHVwblMvdUxibld0WWNzZHhvK00yRVBRZVREcTczZVpL?=
 =?gb2312?B?MzdaT2pwamtmNUZnRElmbVFZd2Z2bGFaNUtLNWZZYUw0OEFkdUcydkI3MVlr?=
 =?gb2312?B?Z3FwOTgrbWZrUVZKZ0lvUWttZXVCQldhMzgxODNyZUdoSU14cnpJT1FodzBI?=
 =?gb2312?B?eGQ0U0tUWG44bWlBY05PS1ZmcGZKZytmMit3YXZlb1p6d0RkckdVYXpuQ0Jl?=
 =?gb2312?B?Z24yWmtmaUl0b3ozbnBnK2pnNDc3THU4ZlorajlocWUzK2N0Q29NSHVtZWhl?=
 =?gb2312?B?dmFCdFFaVkptaHNQN3BjUWhVR3FLVmxjaytieVhlUUVSQmZjWmpIRTFHRFBB?=
 =?gb2312?B?aEVHQ2tucnROeHNhcFVzcTB1YlA1ekVWZmdSQUVzWnFET1MvV3RHWFkvTU5O?=
 =?gb2312?B?aGpWNzJnYTMxSXdGaWpOdElTaXVVa1oxTlI4dFJrSWpMZVdRY3R6WHZMcGRi?=
 =?gb2312?B?SjVOeTRkRlpXaU5aZG42akU2K3VDbEI5Y0lCL0VZZTFiWU9nTnN6S3pOSW4r?=
 =?gb2312?B?YmJuMFh6T0xJcnFDNjR4VkthaFZGWnN0M0Rzd09oSjF1T0JTMkxXdXE3WERo?=
 =?gb2312?B?NkFRQ0ZzRXk5N2tKRXJDa0lVbm1LTnNyZXk4bng0YUdYVXBSWWFNR3lCZGZw?=
 =?gb2312?B?eWlaWTZSMi9zZDgwNWhoaUVOeFBURWxidXlqYXkzcjliS3JwaG9xdWYxTGgv?=
 =?gb2312?B?MHM5Y3BHQ2NJS2tBRjFNKzI1bTJ3TDlVdG1iTDhnbXpmNXN5Z2xDYVlFWS9u?=
 =?gb2312?B?R21BTlhiVHJsL1A3NGVKTmZyWHVrV2ladkcyMHh3emhNajRFaDVnQm5RaDR0?=
 =?gb2312?B?bTJ6MWtqSGR4R2QvK0xnMU1taGVQalVZYUNiN2JUNjlkYXdtenVpVncvRDUv?=
 =?gb2312?B?aTI3d3c3NUdoK1BpWWNGZTNDSDlCanlzTi9oc1pIajFpcVl5RUQwOWdDQlV4?=
 =?gb2312?B?dndIZXdEb0NkY1NxUGJQdm1WcWJDcUdBMGkzSnlDdGh5cGJaUzB3Y2E1NTE4?=
 =?gb2312?B?LzN2Wk5jQUo1NmZEdThJcmRkZ2pLekhjQUJUVDBJNVZEcm55R29helN6OEd3?=
 =?gb2312?B?ekx0WWNBdUs0cm96RHJEWTJVbkphcFI1WUh5UEZWbG5USktoWnBEWmtPSlRt?=
 =?gb2312?B?Rnhzd3BVbEV1TzY0TkpOS0NVekk4aUlFcFk5Mjd1Umx0NkNFSHd4eGNycTdZ?=
 =?gb2312?B?aDdHVnBtSzBBVUpISkhWRGdCL2tSUE1NTzJ2V0RDdGl1cnVSSWxCRVQ5MlF6?=
 =?gb2312?B?WXlMeWc3anpRNFNiL0grTnNYTHl1aWdSbzBxeXJJckJIc3dHR0VFTURxMkJx?=
 =?gb2312?B?ZzdVSVNqN1YvUExGZERZanB6OUpodEtQTTFRQnhDVDVNNkFyTnFGazRjQy81?=
 =?gb2312?B?UGIrdHJoSGpZZUxLbityU25qNVZYRGlTeUhiWDRPK29hd3BSUU9rVVcvdXFT?=
 =?gb2312?B?Q2YrZmtGTHJjcDJVb0V6OFRCQjJWOUdVRENsaXFVeldTOHpvMndtZDlEcFpL?=
 =?gb2312?Q?ju8uUbuiHOgRpg47A3Ni9ZT1d?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3718b3-72b4-4439-1214-08da8a3a64b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 03:47:42.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZ7JInxdwUnAsNun6HdFvN+1XMgznu31UsxSgkWsV/VgwUMQn1e4paZLlFM0aqk347Lx3RJMUbXWW3AHXNaKWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFobWFkIEZhdG91bSA8YS5m
YXRvdW1AcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjLE6jjUwjI5yNUgMTQ6MzQNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4
LmRlOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyB2
a291bEBrZXJuZWwub3JnOyBNYXJjZWwNCj4gWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3Jh
ZGV4LmNvbT47IGtpc2hvbkB0aS5jb20NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14
QG54cC5jb20+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MSAwLzJdIEZpeCB0aGUgd3Jvbmcgb3JkZXIgb2YgcGh5IGNhbGxiYWNr
cw0KPiANCj4gSGksDQo+IA0KPiBPbiAyMi4wOC4yMiAxNToxMCwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gUmVmZXIgWzFdLCBwaHlfaW5pdCgpIG11c3QgYmUgY2FsbGVkIGJlZm9yZSBwaHlfcG93
ZXJfb24oKS4NCj4gPiBUaGlzIHNlcmllcyB1c2VkIHRvIGZpeCB0aGUgd3Jvbmcgb3JkZXIgb2Yg
dGhlIHBoeV9pbml0KCkgYW5kDQo+ID4gcGh5X3Bvd2VyX29uKCksIGludHJvZHVjZWQgYnkgY29t
bWl0IDFhYTk3YjAwMjI1OCAoInBoeTogZnJlZXNjYWxlOg0KPiA+IHBjaWU6IEluaXRpYWxpemUg
dGhlIGlteDggcGNpZSBzdGFuZGFsb25lIHBoeSBkcml2ZXIiKSBUZXN0ZWQgb24gaS5NWDhNTSBF
VksNCj4gYm9hcmQgd2hlbiBvbmUgTlZNRSBkZXZpY2UgaXMgdXNlZC4NCj4gPg0KPiA+IFsxXWh0
dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUz
QSUyRiUyRmcNCj4gPg0KPiBpdC5rZXJuZWwub3JnJTJGcHViJTJGc2NtJTJGbGludXglMkZrZXJu
ZWwlMkZnaXQlMkZ0b3J2YWxkcyUyRmxpbnV4LmdpDQo+ID4NCj4gdCUyRnRyZWUlMkZkcml2ZXJz
JTJGcGh5JTJGcGh5LWNvcmUuYyUzRmlkJTNEdjUuMTktcmMxJTIzbjIzMyZhbXA7DQo+IGRhdGEN
Cj4gPg0KPiA9MDUlN0MwMSU3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0MzMjc3NjFiYWM1Yjk0
MDdkOTc3MDA4ZGE4OQ0KPiA4ODZiMTUlNw0KPiA+DQo+IEM2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3OTczNTE2MjU0NjU2OTgNCj4gNSU3Q1Vua25vDQo+ID4N
Cj4gd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhDQo+IFd3aUwNCj4gPg0KPiBDSlhWQ0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3
QyZhbXA7c2RhdGE9NlNua1JkTEFYMnRMcDFpR2dFNzhkDQo+IEpBbSUyQkxPZg0KPiA+IExMcEFO
ZlIxZTR4SVlGWSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gW1BBVENIIHYxIDEvMl0gUENJ
OiBpbXg2OiBGaXggdGhlIHdyb25nIG9yZGVyIG9mIHBoeV9pbml0KCkgYW5kIFtQQVRDSA0KPiA+
IHYxIDIvMl0gcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IEZpeCB0aGUgd3Jvbmcgb3JkZXIg
b2YNCj4gDQo+IFRoaXMgaW50cm9kdWNlcyBhbiBpbnRlcm1pdHRlbnQgYnJlYWthZ2UuIENhbiB5
b3Ugc3F1YXNoPw0KDQpIaSBBaG1hZDoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCkRvIHlv
dSBtZWFuIHRvIHNxdWFzaCB0aGlzIGZpeCB0byB0aGUgcHJldmlldyBzZXJpZXM/DQpJJ20gYWZy
YWlkIHRoYXQgaXQncyBub3QgZWFzeSB0byBkbyB0aGF0Lg0KQmVjYXVzZSB0aGVyZSBhcmUgYSBs
b3Qgb2YgcGNpLWlteDYgY29kZSBjaGFuZ2VzIGFmdGVyIA0KY29tbWl0OiAxYWE5N2IwMDIyNTgg
KCJwaHk6IGZyZWVzY2FsZTogcGNpZTogSW5pdGlhbGl6ZSB0aGUgaW14OCBwY2llIHN0YW5kYWxv
bmUgcGh5IGRyaXZlciIpLg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiA+DQo+
ID4NCj4gDQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPiB8DQo+IFN0ZXVlcndhbGRlciBTdHIuIDIxICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwJTNBJTJGJTJGd3d3LnBlDQo+IG5ndXRyb25peC5kZSUyRiZhbXA7ZGF0YT0wNSU3QzAx
JTdDaG9uZ3hpbmcuemh1JTQwbnhwLmNvbSU3QzMyNzcNCj4gNjFiYWM1Yjk0MDdkOTc3MDA4ZGE4
OTg4NmIxNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjMNCj4gNSU3QzAlN0MwJTdD
NjM3OTczNTE2MjU0NjU2OTg1JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5Sg0KPiBXSWpvaU1D
NHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0Ql
Nw0KPiBDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9aGFzT3RYNzclMkZlYTV5TGJWOEM3d09mZFpT
dEY1ZXJIT0w1OA0KPiBaZjZaWmJvNCUzRCZhbXA7cmVzZXJ2ZWQ9MCAgfA0KPiAzMTEzNyBIaWxk
ZXNoZWltLCBHZXJtYW55ICAgICAgICAgICAgICAgICAgfCBQaG9uZToNCj4gKzQ5LTUxMjEtMjA2
OTE3LTAgICAgfA0KPiBBbXRzZ2VyaWNodCBIaWxkZXNoZWltLCBIUkEgMjY4NiAgICAgICAgICAg
fCBGYXg6DQo+ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCg==
