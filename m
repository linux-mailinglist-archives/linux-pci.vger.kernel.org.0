Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4564C177
	for <lists+linux-pci@lfdr.de>; Wed, 14 Dec 2022 01:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbiLNArN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Dec 2022 19:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbiLNArM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Dec 2022 19:47:12 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2087.outbound.protection.outlook.com [40.107.15.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB9A24BD2
        for <linux-pci@vger.kernel.org>; Tue, 13 Dec 2022 16:47:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdHEYoW6aKS4m3ioBwqM63c/hn10KShRllaL0LhqeHTkCAGkOZbZh+75FaUk+zsr8/TQjb+m+sCLvW3PK3auBsBtsqKdsDpTIAu3eQG8hf/+3+e13M/ELukPi2MUTiZz4Z7O5H+hnjzKJkji1ggj50NWzgqCcLqsYpQAE5Lfe6H4312M66zSp/kARtnMkPqXj5kP3n2E1z/hFY8QIM2d3NdOwEzwLKK/O1ZuCFnYYcHLvzbEfAvwBeObRNRFdHKgOLJbA+f5aoNWlmsoIpw3xSAjmB5cxTMqSDvuY0NZH7xK6iiyt4HEfzdSI8t/bPLaaGSgKzlgIPK+bXOUJGWzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hokOnp9Xrga+CB1ctwSW3btP5kdmhtG9zyikTKqpnU0=;
 b=Thxop+pa7wVjDvWhFa1yBQKDqZkS2ZVjEURpeKBisJHRLcbnJfR6K+ftwweGSSPCF8zj+V9e25/3QWrBBraS2dabFg8tY1QyERlzdIw27Hq3eWPKBIe9QQfqOSpzKs1ZxEgDt0djMpweYmM9Ko5jJaAhcAcbgjE2oisAAK0HUhkq/l8VfVU2ycBFDLqvefuVDPZFvPoOw8qPa6NFS47xx9A4/5q12+4BpiN330baaLUgTvj/l3WuWj4owiXsrkRMy4IZrEEDXiVav3cMIiW8xVM2NFCHrLGUhT9JrXYhNzHwuM+IPeFpJAcGl7Juo2ernSH2gtd+jwebIoMajg+RWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hokOnp9Xrga+CB1ctwSW3btP5kdmhtG9zyikTKqpnU0=;
 b=khW1zFAb0HJBF4u/hnlLbVJA0lLz6qyl5xf7k1mgYnPbDP37yzh89Uwha6LgorVFlYyCrMAkULUO6dC/VNqvoqr6OoyZgdHEhCKy2h3pJk0euQmS7+4UsXUhM7RbZKcAfbI7huX7wEmEKuY99erfbicC/gI3DkWWJ4nvZYgEsjM=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AM0PR04MB6803.eurprd04.prod.outlook.com (2603:10a6:208:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 14 Dec
 2022 00:47:08 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::203a:e5da:a4a:7663%12]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 00:47:08 +0000
From:   Frank Li <frank.li@nxp.com>
To:     "bjorn@helgaas.com" <bjorn@helgaas.com>, Zhi Li <lznuaa@gmail.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [EXT] Re: [PATCH v2 3/4] PCI: endpoint: Support NTB transfer
 between RC and EP
Thread-Topic: [EXT] Re: [PATCH v2 3/4] PCI: endpoint: Support NTB transfer
 between RC and EP
Thread-Index: AQHYKAio+bOIJcDpcUqpzZv3HaVt4K5uUGgAgAACZICAAAM/AIAABKFQ
Date:   Wed, 14 Dec 2022 00:47:07 +0000
Message-ID: <HE1PR0401MB233104FC6C4D79D44BA96C3788E09@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20220222162355.32369-4-Frank.Li@nxp.com>
 <20221214000848.GA221546@bhelgaas>
 <CAHrpEqSGySHDET3YPu3czzoMBmCRJsgGgU4s3GWWbtruFLVHaA@mail.gmail.com>
 <CABhMZUXcTst3F1jvpa6ijWgVDnX4k-s8c3m=zBoaEiQaj_Xu1w@mail.gmail.com>
In-Reply-To: <CABhMZUXcTst3F1jvpa6ijWgVDnX4k-s8c3m=zBoaEiQaj_Xu1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|AM0PR04MB6803:EE_
x-ms-office365-filtering-correlation-id: bf6e9677-c687-4a69-84e6-08dadd6cba6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irQZs3Xl1qUT9VX+fGORWihRczqtuRcchFdCW1w5LRQ88gH1I80KQPHFZLhsY/T96HHj7P0YOa7q0wok4pI60wmNF01VPRf2vO5XXFipfjfYqnvlrHwUtatsGKGcn0qTYcJuD7OpBK4WncOAfjDh6Rswf91f+f89PtpYql3Cso4a9ChmGcszTUjwJkOSvPihO8PAXLQ09R6SbuYgdNUkNFMSKuz3XpFplw7DGmF6LoPfXfpHrh0eOfRXzpBD/K69fiAIHswo/j0MkYqdD1pQJCtW7C8aG0oXpSGe303xvdP6JlKc7Ba37Iltyz58ODdhqIr1wBCg5KDjDLy1J49hhkwOAHXa0MRgCELtvm5a7oEqg6fzBgsAXJWp97pPZfUP0nYMNg0HOegETIBlfZhMG9ofEfyfclnkxwvbIZVR42TcBUGtYlJg2EjyYEZKd0Wdivk5s+122SI5F0hsWxW3WIR6/+m0vCKjASYrQj6yoEp8rCtG7UCQbuXrTw2nk6LxX879ZO1rG7XqAdIPT6yXonJLNuoi970gFWu2QHl9ER5YyT+VIYMr8qjf74Z2tI1NjOmBHGd9PHvGSNk6FebXz0LufmicqWAurfO2VwlEz52MltU0rKEl1hpbQcX8R4xoOIpDo6E3L8HxYpJ/VgEGmkEEQL4QKm+8L9MJhElzqdQwbB5iz29/HOgULmkisN+O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199015)(110136005)(8676002)(41300700001)(4326008)(8936002)(316002)(66946007)(86362001)(7696005)(52536014)(26005)(53546011)(55236004)(64756008)(76116006)(66476007)(478600001)(66446008)(66556008)(83380400001)(122000001)(38070700005)(55016003)(71200400001)(186003)(6506007)(38100700002)(33656002)(9686003)(54906003)(2906002)(7416002)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QW1rK0FIZlJKRnkrbkxpd1NCNjhxQ3E2VzhvZk50RFFEamV1V0kzY0tTMlVV?=
 =?utf-8?B?WmxzWVdndEpGNHZQNU1EMFJqWmNRMHcrVWR3c2RsYlQxOHB2U0hVd1FrblJh?=
 =?utf-8?B?SkF5ejdwSjI3U0VNK2tkSUN6azhRdlBDay84aDhMMGFWVVI3UVRSVzQ3L1Bo?=
 =?utf-8?B?VXBzZDd1OXM5Y3Q5b2Zsajk4Q05KMjZNK3FibitHYllqVWtPY3dSTkxRdGwx?=
 =?utf-8?B?QzhNSFRsOHlUZFdSYWpyTWh1cXNhVmZNN1JNQURzRENEeDVVNDNEcXhCMnJB?=
 =?utf-8?B?SE1RVzVVTHYrRVQzbmFlZHJmNzRwdHBwZ1NTeWJYcVJLTjczOThlZXZNUXRs?=
 =?utf-8?B?V2RUaklLd0c5UVFmRkl0YTM0Qm1mR08vRlJmOUFxQWh5MFJXUmNYajRJM1k1?=
 =?utf-8?B?R0cyZ2FYNldtc3lqdnYvc2FaSUpUa01LQU55V2E4NTlaK25uMmtyRS9jbzJx?=
 =?utf-8?B?UFVNMTl2VkJNQzV5S1NmVFlVMytvRkVTQ1A5YjAyWXViMVNwRndOYzlKVmRa?=
 =?utf-8?B?M0FWelpwWU5CbURIaFlBL3FoU0xtelhjVmpJZXBQVEVYWkdDV0hVdEVDT3hi?=
 =?utf-8?B?bVJKSTZ1blNoQndoYTRUVG1rK2g2R2xyUW5PMzc2cTJaa2ltRGZUNjJ6Qmxq?=
 =?utf-8?B?UGFrekNtSTVodWdhYW9xd25TSTZwQUVXK1kwVm1mT0U4dVh3d2FFcjNYSFJo?=
 =?utf-8?B?UTk3MzhYY1pJL0pzZjZJak1WRGJaSEphMFQ3Sjl2b1hkSjdWY1BlMUxEY1Ur?=
 =?utf-8?B?c1Y4eGE0aEFVTXFQNzM5Vm9SUjltUDNTV2QwV2JlVEttRmxYVWlBSDVkNzBy?=
 =?utf-8?B?cWVBblBvVlJCRUpMVCt3RFVlYlFqSllDZmk0Rkl2WjBrSDhaUFVGS0RSUnhz?=
 =?utf-8?B?K0pWVlBEQWV6UEtHQzhOUXNLMzdxU1dJcCtsNHBheHI4cEN3WGt6Tk1uYXhJ?=
 =?utf-8?B?NUNER2dkbWV0dVJBb1JsVkw2L3ZxaUFmaGxFcFVDNkwyVkIwYUVRbkMwajdS?=
 =?utf-8?B?akQyNS8vakNYUkxyQ2NML1ZmSnVONktSU00vNDFpOFJXNzhPOURGSEhOVlM5?=
 =?utf-8?B?Y1hmdHIzMkpSeXFZVGpJSTBaU29idFdOQUdscStmN0dpYlNUY0c2L1hLejZD?=
 =?utf-8?B?NTdlRHV0OXhHcDFSTFF0M01hd2lJSHJoZitNYzRPMk5JS0MvNmY1b2Z4WjNY?=
 =?utf-8?B?cXZ6aVU2VEwwUlNnVVVZaU1HaHFhbmVjeFR3WmxpbWhzZnB0eUN0WGxpSXZC?=
 =?utf-8?B?QlVSUWhMKzkvRUdoSmlmcWhMTWZpN1Z5T2h4M1JtblVxcDdQa1NmaXhaN25s?=
 =?utf-8?B?OCtQVklMTHB4alZ6LzVsZzJYUWZ0V3YyVzQwYTZ6YlFPZXpOSDZ6VmlENjFh?=
 =?utf-8?B?TEQvTjI0c1k4elVBYjVEaWpyS29EQVQ4TjBmWnhrYVVkeXA1L3FNTTFQZlFG?=
 =?utf-8?B?bkZlN3l4SU94L0k5MEF4M2E2eitMWFgxZlpSVEJaLzYzSVZkQWRBaEpPeDZF?=
 =?utf-8?B?NGR4bTVOd0NCcmNuV29sRnF2Q1hNRzFIckJoSnc0K0Y5V2FQc3daNXErWTYr?=
 =?utf-8?B?YkNaRGZaekZBL0dqWUpwZldRckNzQk5GOHIvdlF0Y0FOcGYySDlvcVY4ZE1n?=
 =?utf-8?B?cHBucFVaejB1NWFJazBDUXhFZHBDZFU1NFpjMmMrMnRHc3FVTi9lTlY3VzBY?=
 =?utf-8?B?SmtVak9FS3RjNjhxQnRTMFlNakNDTEhCb3ZDekFWM1cza1ZjaGVDeUZZemdU?=
 =?utf-8?B?bWNSTUNsVkk3QjcrN0xYRlU4MVhta3MxYnVFOW96ZFV0QTZpWGxYVEVIRVF2?=
 =?utf-8?B?U2tkQUdYYkE2SEZPT0lvVjdFZFFlSnRnS0RWU1kzeUhWL2p1UEZIaGRxOVJP?=
 =?utf-8?B?d2MzWlRqTXVyN2hnY09yVWRqc3E5MWZ0eURpNzh5Zng3L21jNm9oandteW5n?=
 =?utf-8?B?aURTWjdicVkzNURSd0NEUnJpRTlhOHZ5TVV3aWJPbGZvU1RLbmRsUTgxYXpy?=
 =?utf-8?B?ZktGNWxqaEVsOHJBcEYvTy9nWnQ1RWI3Q0FYSS9pQ0RFN2hMLzR1bFNKN0Ew?=
 =?utf-8?B?ZG4yLzYwSC9udFpWZ3FyOG0vRVRocmdqb1ZlV2gwd1prc2lwQlUvNjZVTkto?=
 =?utf-8?Q?Pfes=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6e9677-c687-4a69-84e6-08dadd6cba6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 00:47:07.9849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wy2YbIOBaLKvWZ0XPNGwyv/uC7Mwrf1tGzdsDwjqBrvKGHWkxwtVp5MnXIHhTPgIs+RTlp0VWFmXICEPhYp0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6803
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8
Ympvcm4uaGVsZ2Fhc0BnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEzLCAy
MDIyIDY6MjkgUE0NCj4gVG86IFpoaSBMaSA8bHpudWFhQGdtYWlsLmNvbT4NCj4gQ2M6IEJqb3Ju
IEhlbGdhYXMgPGhlbGdhYXNAa2VybmVsLm9yZz47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
PjsNCj4gYWxsZW5iaEBnbWFpbC5jb207IGRhdmUuamlhbmdAaW50ZWwuY29tOw0KPiBndXN0YXZv
LnBpbWVudGVsQHN5bm9wc3lzLmNvbTsgSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT47DQo+IGpkbWFzb25Aa3VkenUudXM7IGppbmdvb2hhbjFAZ21haWwuY29tOyBraXNob25Aa2Vy
bmVsLm9yZzsNCj4ga3dAbGludXguY29tOyBsaW51eC1udGJAZ29vZ2xlZ3JvdXBzLmNvbTsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbQ0KPiBT
dWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYyIDMvNF0gUENJOiBlbmRwb2ludDogU3VwcG9ydCBO
VEIgdHJhbnNmZXINCj4gYmV0d2VlbiBSQyBhbmQgRVANCj4gDQo+IENhdXRpb246IEVYVCBFbWFp
bA0KPiANCj4gT24gVHVlLCBEZWMgMTMsIDIwMjIgYXQgNjoxNyBQTSBaaGkgTGkgPGx6bnVhYUBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+IE9uIFR1ZSwgRGVjIDEzLCAyMDIyIGF0IDY6MDggUE0gQmpv
cm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiB3cm90ZToNCj4gPj4gT24gVHVlLCBG
ZWIgMjIsIDIwMjIgYXQgMTA6MjM6NTRBTSAtMDYwMCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4+DQo+
ID4+ID4gKyAqICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSsgQmFzZQ0KPiA+PiA+ICsgKiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8DQo+ID4+ID4gKyAqIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4gPiArICogfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+PiA+ICsgKiB8ICAgICAgICAg
IENvbW1vbiBDb250cm9sIFJlZ2lzdGVyICAgICAgICAgICAgICAgICB8DQo+ID4+ID4gKyAqIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4g
PiArICogfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPiA+PiA+ICsgKiB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+ID4+ID4gKyAqICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsgQmFzZStzcGFuX29mZnNldA0KPiA+PiA+ICsgKiB8ICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4+ID4gKyAqIHwg
ICAgUGVlciBTcGFuIFNwYWNlICAgIHwgICAgU3BhbiBTcGFjZSAgICAgICAgICAgIHwNCj4gPj4g
PiArICogfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
fA0KPiA+PiA+ICsgKiB8ICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICB8DQo+ID4+ID4gKyAqICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSsgQmFzZStzcGFuX29mZnNldA0KPiA+PiA+ICsgKiB8ICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICArc3Bhbl9jb3Vu
dCAqIDQNCj4gPj4gPiArICogfCAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiA+PiA+ICsgKiB8ICAgICBTcGFuIFNwYWNlICAgICAgICB8ICAgUGVl
ciBTcGFuIFNwYWNlICAgICAgICB8DQo+ID4+ID4gKyAqIHwgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPj4gPiArICogKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KPiA+Pg0KPiA+PiBBcmUgdGhl
c2UgY29tbWVudHMgc3VwcG9zZWQgdG8gc2F5ICpzcGFkKiwgaS5lLiwgc2NyYXRjaHBhZCBzcGFj
ZSwNCj4gPj4gaW5zdGVhZCBvZiAic3BhbiIsIHRvIGNvcnJlc3BvbmQgd2l0aCBzcGFkX29mZnNl
dCBhbmQgc3BhZF9jb3VudA0KPiA+PiBiZWxvdz8NCj4gPg0KPiA+IFN0cmFuZ2UsIEkgcmVjZWl2
ZWQgc29tZSBvZiB5b3VyIGNvbW1lbnRzIG9uIHRoZSB2ZXJ5IG9sZCBwYXRjaGVzLg0KPiANCj4g
V2hhdCdzIHN0cmFuZ2UgYWJvdXQgaXQ/ICBJIHdlbnQgdG8gdGhlIHRyb3VibGUgdG8gbG9vayB1
cCB0aGUgcGF0Y2gNCj4gdGhhdCBpbnRyb2R1Y2VkIHRoZSB0aGluZyBJJ20gYXNraW5nIGFib3V0
LiAgSSBzZW50IHRoZSBlbWFpbCBhIGZldw0KPiBtaW51dGVzIGFnby4gIFRoZSBxdWVzdGlvbiBz
dGlsbCBhcHBsaWVzIHRvIHRoZSBjdXJyZW50IHRyZWUuDQoNCk9rYXksIEkgZG9lc24ndCByZWFs
aXplZCB5b3UgYXJlIHRhbGtpbmcgYWJvdXQgY3VycmVudCB0cmVlIGFsc28uIA0KTGV0IG1lIHNl
bmQgcGF0Y2ggdG8gZml4IHRoaXMgc29vbi4NCg0KQmVzdCByZWdhcmRzDQpGcmFuayBMaQ0KDQo+
IA0KPiBQbGVhc2UgdXNlIHBsYWluIHRleHQgZW1haWwgb24gdGhlIExpbnV4IG1haWxpbmcgbGlz
dHMuDQo+IA0KPiBCam9ybg0K
