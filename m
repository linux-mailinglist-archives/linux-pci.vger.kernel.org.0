Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B957C41C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiGUGFx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 02:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiGUGFw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 02:05:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1964ED11B;
        Wed, 20 Jul 2022 23:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rqrk/2WgyvXuIAYOLANmy4fSfEOm+TugF30om8qSu+2RcTSKOgroxkz5mzoGh8O1VD8zdPgvJ3onZTGMhVtacxi6DPWTObS6vLi+aHGy1DRBU6KIAzwWlbThPKgL0gEcZGzmO8GYS2XZ1FoZIjGoV3iqNzNxG7apuPfeZ+hQqABG9GqwenH+1/ZokO/h9hGH3qJ2ALwtP6OL2nvs1PXr2MWboD4WsTrY/czHIcS4TmmaWZgn1bg6bWIPwd5ztchgSjL0wjRBncj/kKoOMl5vHWruY0Pv8UYKI1JVT4M4sFFj4oY0prt/aVAlZM+LJcd6lcFJP9arG1r23p6sJt7l/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oToCHwslArTAIzEZQH1ZFL+w+EIbbE5DH2oCISl6lrY=;
 b=G74a/5lbUJX8UJ5ZoDNXe2DOk04xDtzvj89zyHi9vsrq73e2YRinONSuCe8/RRWaQnOOu00afdIYM59BKAkadkVnt0VwS89HzExxiGfQlU9CViSSqPn+z1WBgEGMP38Nit4t+wvmJtWaHzfo/hVR+XNM3F3dkjHCiMlDM5lFffivtpL04ENg8TRg367z7GMQ45c8WeNJliHQLpJMDtCLOwgAkE+ca40aSG2GKiOY++D8oR/39OmqbE75+A+Q3fV3dEr6D54SgWUokyLWxKMIDHNosQsu11pbwPg70bbcUpmjKupkw8bl+e4bA7OeFrTu0yOsMw2xsDTGjVTOlAI3fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oToCHwslArTAIzEZQH1ZFL+w+EIbbE5DH2oCISl6lrY=;
 b=UlklSUdX3HRr9jbwfUxn1NhcOU43pYtm6jNppvufg9ZOSHy+0tNTNlM+hR4pJQ8/1S3VHSiq4D1yAqYNlkaCbGNJofChRo4fibyNjlEgwDt8Je+TDH9S/dymnpWBSOmJfZu/04dZLKPQg3wwaz9PV5T+JAeeIyHOZg21eyoIXUY=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB8PR04MB6444.eurprd04.prod.outlook.com (2603:10a6:10:102::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 06:05:46 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::75c6:afbf:7972:6c6f%8]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 06:05:45 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2] PCI: imx6: Support more than Gen2 speed link mode
Thread-Topic: [PATCH v2] PCI: imx6: Support more than Gen2 speed link mode
Thread-Index: AQHYm+qnks82OVHeaUCuP2slpV9ylK2Hw+WAgACRYYA=
Date:   Thu, 21 Jul 2022 06:05:45 +0000
Message-ID: <AS8PR04MB8676A571079D8DF4C22B84558C919@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1658287576-26908-1-git-send-email-hongxing.zhu@nxp.com>
 <20220720211541.GA1658730@bhelgaas>
In-Reply-To: <20220720211541.GA1658730@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 61ed3bd5-8ec6-4f17-22e2-08da6adf0d3c
x-ms-traffictypediagnostic: DB8PR04MB6444:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Gpz3W4LpFbdmgxZ7ergztodNEZ9YQGfTep6tG9A7ipPnMaiuBBggTNuKkmB2tZrGgK7UYIkoSBpiEMf37Bjg/7IODxOgw75sHtI/k405yaVlMYNk+2IhfrnUHvw+zinN/wetKEsH1tIDPs53tYpaUY3O8lPQmAX8Q2M6YQ8qyQrjw589MiE+ZmRKeg2ZU+/oDRhuB3qVzJBHHsHytn08SaKZaoEfdRAijRnseocyw37Wm2cr9KMBFRpyop4RhKWU/lYfW9W2tRm0qWm/V2KaFNM1qUqnX5IJFKDD4avbggUkIrPQDBc61Cv9pmYK+0R2VYYyWsTp8cYYSFuUN0LJE161bY9lOuiBAOVY2Itt1eePaefhwNkyRQ4iC7yw16F7BFuMWu1WEdKSa1kO/kOMyKV0NXS92UU7YFsTr7JUWqZo5C+hB57RUSSutAKsx0NElPErqR5bEfIQQ5ZeS30H3jcZmnlDXFEeGxu5BKMf9WX0E61L1LO2A1Ah1qpO4GGFOUZDutciP+Sf0PmN8hxlV27wnBGhb7N/z5vYdRNix4RvcHsiPV6XBPB/llBgEtC/8R6CGVconB2r/h215LEDIOkV0wncsei7cS6Y68XCSQ30njdK5G+4AQl70jeS2xGcX+8DDQRIa5WDW7hF7SJCmiANG0hh5/E0QZfaCVGCckoa5IyebAGv9y7QiwxKkuq/yScz4rI3ToR7l+2YgxWUsEV57W5TzXuH0kCU50krLKNMAQl1DDuzlLOZn1DaYQv0Z6q5K1i1SNSVQBQvTABWjBc+QXLZOcCWoyFFI3NX6qJ5yw4zaFAIpvqDPY5A4N6FIB38xmT8l8HhCYXiC30ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(5660300002)(8936002)(33656002)(6506007)(6916009)(316002)(8676002)(52536014)(55016003)(66556008)(44832011)(66476007)(2906002)(45080400002)(76116006)(54906003)(7696005)(9686003)(186003)(38100700002)(478600001)(4326008)(66446008)(53546011)(86362001)(38070700005)(122000001)(83380400001)(66946007)(71200400001)(41300700001)(64756008)(26005)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?LzV6cE1FOElhKzlqZisrWkFoQ1lDbDdGWHYwby9ocEt6bjRlZDdiYkZrZit2?=
 =?gb2312?B?TW1FNFFTMUNuUG5pRVlIcCsrSkxXelFyMlVYMnMva2F0Kyt2UHpjYklKR0Fa?=
 =?gb2312?B?UFAzK0l5aHRwaWFFc21KdmhzVzdvUmVsNWtWL0VTc2l4WmcxdUFlMmo2SzM4?=
 =?gb2312?B?bm94NkFXN0NsUHh6MkRtYlRSMnpqcW5FVldGUEJRTHQzb0J1eGRQdmMraGhq?=
 =?gb2312?B?RTFkTmRUL0FNYjc5UVVHRFBwYkNLZWpwMFViRWJPaGFpemdpQlcrTWZTbWts?=
 =?gb2312?B?NW41LzN5UiswMldYQjZUVWJBLzdlbUJpVmViZzRKM2h6RU91dUo5blRlUzZk?=
 =?gb2312?B?SU85MFFJQlFHWUhJZ2Q2RUlBNGlza0REcXlwcE45OFpseHo2UEZpRi90OEZN?=
 =?gb2312?B?ZW1EYWdrOHl3NjBkcVNUS2E3Q2NIdjlsNmtsL1BPdzNuSThKU0RUY1hET0NB?=
 =?gb2312?B?RlU3aUwxNmpNdG4xMU1nbTJMeERtWmRIdGorZTh1MWxqUkVBZHI4RU9lRTJ2?=
 =?gb2312?B?czFNV0hTODRGL3dmTHF6M2ZCeGVhc3c4QkdGL3hYT2FKS3VaMXhDSkRnbUha?=
 =?gb2312?B?T1hudzQ1QmxSeGJ4b3J1MDFpSFNiM0d3dkFES01vRVJYK3RTRmFPV2c1MUU5?=
 =?gb2312?B?NVNuT0xJeTc2VERWakoxM2p2aGkvaS9yNEQrSU1Ib3hjaENta0R1NTh6Vyt5?=
 =?gb2312?B?YUZ2WGJQOXhoSFNXOXl5dW1LS0dqQUpjakpXTGpkWkQ4Z1ZLU0xaOGVwcFZv?=
 =?gb2312?B?WTkvemJEN1JheFUwV0RSMXY4aWI3M2RST3A1RDFsUkFDdkVxNGpSK0lUYlZY?=
 =?gb2312?B?eHdpLytrcWJ6WmJTOC83SGJKNWRZNlBpZG44U28wRzlMU1BYZUVyZEZSVXBH?=
 =?gb2312?B?VGs5bGd0U2dJYlV3bm9meGxKWndpUWNnanpkWFJNajNveVpubUl0cFRHRFlh?=
 =?gb2312?B?VFpaZk0xYVRKanNHeDlISWk0c2pSQWRQb0c1UDNJMURlTVphWnJzbzg3ZDls?=
 =?gb2312?B?RFZoUTQ0R0QybVMyQm54aHVPYUwwL1JFa3NpRWpQV0UrOFdWMndvUGZxbEpn?=
 =?gb2312?B?bStyQ2p1QXNlcG50ZkhIQkh3THFEa1NETEZtVCsyOHFhRThqL3JIRzdCVnhH?=
 =?gb2312?B?N01qaE1BdlB0Q1ZkblZ0Rk5lNUlCbGRkME81dU9uMHk4S1ZPRDJ0Q0xaTUZm?=
 =?gb2312?B?MmphY0M4YU0rSUE1a3NXL21XcnMrbkhaSVVKbk5xaldvQkpFVlVmcGE2ZUxQ?=
 =?gb2312?B?bTlCRXFWSFJqdTR6RXg5bmJqdDlMc2ZPU2pJczdIdDhFcGdoTXdCU3ZpWjNC?=
 =?gb2312?B?UWFjdWxITjRlVVcxWUpBZ0FCV1pXSW9HUTlDbGduOTlhL1NkUXlDc2lMU29r?=
 =?gb2312?B?YjR1a3Y5VVlyanNzRzBvTUlHT0M4L3pNZzgxL3pYZTBTNEVJNTUzc3J5Z1Bl?=
 =?gb2312?B?S243RnB6RnBNSWZBNCtwR09pdmY1eC9udGQwNlpaZ0pVMVljRDAyd2RuT3VV?=
 =?gb2312?B?SHpIVmRzZytPZGkyTjFTdEF0T3FjdE9EQy94NS9icDBNS29EU1ptaWFzWG85?=
 =?gb2312?B?aXRPbFdjM2J1OHlSNWRFODB6TDFPeGdsdCt4cFBpV2grOUVvOXhVRndpcmhR?=
 =?gb2312?B?M0hPUENleW9XSmtmQjBSeGpLOTBYdzFjTFZPVVZSRktybWMxUmRKRkNZUUZQ?=
 =?gb2312?B?alVpdklOYStmbUlWWFg2RE1kTzBNWmdYekN5OEk0aUFJcXdoelpLQlZvc3Vo?=
 =?gb2312?B?YzM1c25HVnRqbFdrTXhZMEt2M2Zmdmo5R1NwcXhXL3pHY0JBamxkb0grVzhZ?=
 =?gb2312?B?MTZVZHJJeldFZkR3eHdDbm5VSU05ZXQ5NTRkRkdWTnoxaS9abG5tVWlFTGlM?=
 =?gb2312?B?YzFZT1d1Zm5zTjQwVFg0eStyaXd2VXg4dVRHQlFhaGJ6T2k0OGQxYlU4R3pL?=
 =?gb2312?B?UkFkYS9POXRJeXBZZzVaa0pXdkNkbFdvL09tYm5mMi9pYmFMcHVDR2FWZk82?=
 =?gb2312?B?am1kL1Uwck40WEsvUlBCQlFMZTg0S3F3bXhFSEJiU05VMlMrZ2ZtSDEwdFJt?=
 =?gb2312?B?RXptU2QwVXNTbU9VNlhEeFdRZFhTTVVQSTdlOGxPVVpqRVN3NlFTb0NiWmRp?=
 =?gb2312?Q?eIzdMVn2AuD0/lUxalWZQXuOr?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ed3bd5-8ec6-4f17-22e2-08da6adf0d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:05:45.7549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ABuobBwNyNXpFU5QJTXBbYdzr0NZJHMaC9BCjvazgSrSBIvUzAdmPtFTAzx2ybVZQgmxA4sF8A6BHk/dDGtlfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6444
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjLE6jfUwjIxyNUgNToxNg0KPiBUbzogSG9uZ3hp
bmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IGwuc3RhY2hAcGVuZ3V0cm9uaXgu
ZGU7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IHRo
YXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogaW14NjogU3VwcG9ydCBt
b3JlIHRoYW4gR2VuMiBzcGVlZCBsaW5rIG1vZGUNCj4gDQo+IE9uIFdlZCwgSnVsIDIwLCAyMDIy
IGF0IDExOjI2OjE2QU0gKzA4MDAsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IFN1cHBvcnQgbW9y
ZSB0aGFuIEdlbjIgc3BlZWQgbGluayBtb2RlLCBzaW5jZSBpLk1YOE1QIFBDSWUgc3VwcG9ydHMg
dXANCj4gdG8NCj4gPiBHZW4zIGxpbmsgc3BlZWQuDQo+ID4NCj4gPiBMaW5rOg0KPiBodHRwczov
L2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYl
MkZsb3JlLmtlcg0KPiBuZWwub3JnJTJGciUyRjE2NTI4NjY1MjgtMTMyMjAtMi1naXQtc2VuZC1l
bWFpbC1ob25neGluZy56aHUlNDBueHAuY28NCj4gbSZhbXA7ZGF0YT0wNSU3QzAxJTdDaG9uZ3hp
bmcuemh1JTQwbnhwLmNvbSU3Q2ViN2Q2NjhlNWI3ZDQ2OQ0KPiA4ZTYyYzA4ZGE2YTk1MDJhOCU3
QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlDQo+IDdDNjM3OTM5NDg1
NDc3MzY3Nzg4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQQ0KPiB3TURB
aUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwJTdD
JTdDDQo+ICU3QyZhbXA7c2RhdGE9cnVxN2NPaTd1QU9xNnFPRnRqMU9YcGk2RVZnZU5UREZvek9I
Sm5acGdhOCUzRCZhDQo+IG1wO3Jlc2VydmVkPTANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVs
Z2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gDQo+IFlvdSBzaG91bGQgbm90IHBvc3QgcGF0
Y2hlcyB3aXRoIG15IHNpZ25lZC1vZmYtYnkuDQo+IA0KT2theSwgZ290IHRoYXQuDQoNCj4gSSBh
ZGQgbXkgc2lnbmVkLW9mZi1ieSB0byBwYXRjaGVzIHdoZW4gSSBtZXJnZSB0aGVtLg0KPiANCj4g
SSBhcHBsaWVkIHRoaXMgdG8gcGNpL2N0cmwvaW14NiwgcmVwbGFjaW5nIHRoZSB2MSBwYXRjaCwg
dGhhbmtzIQ0KPiANClRoYW5rcyBhIGxvdCBmb3IgeW91ciBraW5kbHkgaGVscC4NCg0KQmVzdCBS
ZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmcm9tIHYxOg0KPiA+
IC0gVGhlIFN1cHBvcnRlZCBMaW5rIFNwZWVkcyBvZiB0aGUgUENJX0VYUF9MTktDQVAgc2hvdWxk
IGJlIHJlLWNvbmZpZ3VyZWQNCj4gdG9vLg0KPiA+IC0gV2hlbiBvbmx5IEdlbjEgaXMgZW5hYmxl
ZCwgcmVmaW5lIHRoZSBkZXZfaW5mbyBhY2NvcmRpbmdseS4NCj4gPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jIHwgOCArKysrLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggZTFiYTExZGFi
YWE4Li5iNjY4NzZmN2VmZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpLWlteDYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aS1pbXg2LmMNCj4gPiBAQCAtODQ0LDEyICs4NDQsMTIgQEAgc3RhdGljIGludCBpbXg2X3BjaWVf
c3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZQ0KPiAqcGNpKQ0KPiA+ICAJaWYgKHJldCkNCj4gPiAg
CQlnb3RvIGVycl9yZXNldF9waHk7DQo+ID4NCj4gPiAtCWlmIChwY2ktPmxpbmtfZ2VuID09IDIp
IHsNCj4gPiAtCQkvKiBBbGxvdyBHZW4yIG1vZGUgYWZ0ZXIgdGhlIGxpbmsgaXMgdXAuICovDQo+
ID4gKwlpZiAocGNpLT5saW5rX2dlbiA+IDEpIHsNCj4gPiArCQkvKiBBbGxvdyBmYXN0ZXIgbW9k
ZXMgYWZ0ZXIgdGhlIGxpbmsgaXMgdXAgKi8NCj4gPiAgCQlkd19wY2llX2RiaV9yb193cl9lbihw
Y2kpOw0KPiA+ICAJCXRtcCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VY
UF9MTktDQVApOw0KPiA+ICAJCXRtcCAmPSB+UENJX0VYUF9MTktDQVBfU0xTOw0KPiA+IC0JCXRt
cCB8PSBQQ0lfRVhQX0xOS0NBUF9TTFNfNV8wR0I7DQo+ID4gKwkJdG1wIHw9IHBjaS0+bGlua19n
ZW47DQo+ID4gIAkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgb2Zmc2V0ICsgUENJX0VYUF9MTktD
QVAsIHRtcCk7DQo+ID4NCj4gPiAgCQkvKg0KPiA+IEBAIC04ODQsNyArODg0LDcgQEAgc3RhdGlj
IGludCBpbXg2X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICAJCWlm
IChyZXQpDQo+ID4gIAkJCWdvdG8gZXJyX3Jlc2V0X3BoeTsNCj4gPiAgCX0gZWxzZSB7DQo+ID4g
LQkJZGV2X2luZm8oZGV2LCAiTGluazogR2VuMiBkaXNhYmxlZFxuIik7DQo+ID4gKwkJZGV2X2lu
Zm8oZGV2LCAiTGluazogT25seSBHZW4xIGlzIGVuYWJsZWRcbiIpOw0KPiA+ICAJfQ0KPiA+DQo+
ID4gIAlpbXg2X3BjaWUtPmxpbmtfaXNfdXAgPSB0cnVlOw0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+
ID4NCj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+ID4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPg0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmxpc3RzLmluZnINCj4gYWRl
YWQub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGbGludXgtYXJtLWtlcm5lbCZhbXA7ZGF0YT0w
NSU3QzAxJQ0KPiA3Q2hvbmd4aW5nLnpodSU0MG54cC5jb20lN0NlYjdkNjY4ZTViN2Q0Njk4ZTYy
YzA4ZGE2YTk1MDJhOCU3Qw0KPiA2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MwJTdDNjM3OTM5NDg1NDc3MzY3Nzg4DQo+ICU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpX
SWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQw0KPiBKQlRpSTZJazFoYVd3aUxDSlhW
Q0k2TW4wJTNEJTdDMzAwMCU3QyU3QyU3QyZhbXA7c2RhdGE9S1RsNmZ5YTANCj4gbElVJTJGdHZa
T0I5diUyQnhFZ2FBaGhZbzQ1Slpxd3AwQ2Z6N3FzJTNEJmFtcDtyZXNlcnZlZD0wDQo=
