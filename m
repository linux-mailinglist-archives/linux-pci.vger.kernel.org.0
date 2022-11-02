Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042E9615720
	for <lists+linux-pci@lfdr.de>; Wed,  2 Nov 2022 02:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKBBpn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 21:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKBBpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 21:45:39 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B437D1FFBA;
        Tue,  1 Nov 2022 18:45:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0NzJJwn9nl/Whw76JsGOL8ss8zf2fhKvgwziX8P1HAZeGFJW+GpGCR32mcuuDaWwO8wZKrSYThPo7NCTxRm2O1e8ccjtD7OeKPLMLX41UxFz1+f0/Yki6o+dgbPV/xsQNhf1mXcK1QzbllsuRQJG2QlXSdpI5+5ZRrjPCfeQg2AbvBffLkGDKNYlMOu3KZ/RS7csoPtDWl2Leq0UMgoyrtwwDdk3UdWI9R8VFEMsVJpoeLyPNiZhBwIOAMTNeBqFt1U9dPpJrj0LX8YF1hSEhSTBtJXS5rnbTVkJtpYcjkN82lRkM+19hOybubcnobjsWwROiHhSNZnmDj9Mcw0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=geFJcSfeU4Kgl8l12K0JZ/gMnJsouGMMTHxdQSgMFI4=;
 b=RRq3vOTZDkg0GEFXJj3YahNnpR+CYCa04xG+1j54JnxJF0gEcRyAbrFSfdkhReBhpueW8QU9ot8x5x4SRtU+CuoaFRqEOlx9cikSpLaeFGFBDBrnGMxd0Xhcn/YG1txfiI4PGCr88tUt26Q5eAmaz0IiiwwP/L/e8LPgjWEbfqBT3uAbdSmBNj5Nx5y/rwzFtU5zXA2g8iGQ8y7LtX773jeODUowyBcXBunriJgV4qfqUTIEDHi0CHRNW0SvG9mgKRvBYosDMycwuIGTSppxg9FS5hqQP4Ib/kR/cH0un2BYuvvO7TeS1yloYrrS2gyha9s/cfmByiGEZnSgJGfO1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=geFJcSfeU4Kgl8l12K0JZ/gMnJsouGMMTHxdQSgMFI4=;
 b=MwD78MYI3FpXAudf/SjlDcbS5UHuDTlKAC/v+QjE9xgh1gG9mRwr3UPiixOF7k5vFJaa6/Bf1BzqOylzMHuc0Eqvttg92lIgSGDXHaVrRlcHoqd8HXk7vWkxpop0nbq+bC9qVYocfa7XwLYSyd9gd/1CYcbQ5Yvtg2JUFo6lm5s=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8166.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Wed, 2 Nov
 2022 01:45:36 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::f135:ec2c:8528:d866%9]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 01:45:36 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "marex@denx.de" <marex@denx.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "richard.leitner@linux.dev" <richard.leitner@linux.dev>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: RE: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Topic: [PATCH v1] soc: imx: imx8mp-blk-ctrl: Add PCIe SYSPLL
 configurations
Thread-Index: AQHY525Z8iyK/13unkqieo1kWL6laq4lFqkAgAS214CAAQ+6AA==
Date:   Wed, 2 Nov 2022 01:45:36 +0000
Message-ID: <AS8PR04MB8676B7207B48F94BF12C88EE8C399@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1666590189-1364-1-git-send-email-hongxing.zhu@nxp.com>
         <20221029084514.GT125525@dragon>
 <ae0fd778eb31416eedb248e2cd4faef576174937.camel@pengutronix.de>
In-Reply-To: <ae0fd778eb31416eedb248e2cd4faef576174937.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8166:EE_
x-ms-office365-filtering-correlation-id: 161cfe6e-6e6e-4c5e-79ae-08dabc73f014
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7boT3ABPcxHx6e5/X4IArv13rlFR0a50i7BqBQ+QxdLOuUyaW9J9PB9gMD4Ihdb8hlo6VTSON2N0NGDRq41/9vSWYQOYd2/toUjJ2nwnEfVOxBziPDDGIjrQT4mAeG5s65Wt+7CbM9m+4JPvEDVtaAHvIr+/d7SZ2yAVpJist/yVrHlRrQGbjx5KfhxJSseawxD+x2HRIKS2U5A15H4BtNkxb/CGQfYfpJPYJv3FijniUnNAeZ7I79seabSTmYWu9DX0fpoZcOEMQsfUe7Bm9vEtUUjl4A4tytPOLWj/+6AwDLA7n4qUJ9nijxhT+cL3qvec2jmf3Js0R8nC47yMZCN3tqLYRTHhXpiCsXm8s5FDrMFRzIXyBw7Rhmd8lYGVzxBy7lxqlFZ/4nnSkRkSz6iu6YDpJLN8FjxPdgctR4ujBvI4jIRj+2sJvHRsRV2D+mi7EJy8KxnG0+Um1WSXjO+QZ5aOnUonxwnrBJwR70dYfVgeWzYALKlsIBknkfVyHTOFy72HwPzS63IlXVb/LuhEhb6KiLz7kq/z8f0QJizexjs+4LhrQjx4JRvV8RiiWkduj5U6T++V6gUk4t5Ds9w6LJakwFwmlV6TRro2LoHlOkStwkyLP3PiYYjv6hwRKyVMJ0x7cwsmPo7kfUJHLNn8L37pXiXR3w3QhlCgIq2WJQaCCEs9dGn7qZTJxuuzDkfNJ33H1bZ1OjFjtfIJmrwrR8QfC0sEIpsv239KqJ3OyAblXXhi95+v7vOiExg3u0OiBES6GI4y7Wy8Dvl6dT++u9FI+wvw3wUbRCFT2M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199015)(54906003)(53546011)(26005)(6506007)(9686003)(478600001)(7696005)(76116006)(7416002)(66556008)(38070700005)(2906002)(64756008)(38100700002)(8936002)(52536014)(122000001)(41300700001)(66476007)(8676002)(66446008)(4326008)(186003)(66946007)(5660300002)(55016003)(83380400001)(86362001)(44832011)(110136005)(71200400001)(316002)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVOaDNnbm93RWJjdkVUOHAxUlhsOEd0VEMzZEN5OEhUQXM5aVJJNzVSK0VB?=
 =?utf-8?B?U2oxRHI2dys3d2JLMXNqa1kzblBoYi9VdVgzKzdCbEl0Q3UxS0E1UFpUTVc5?=
 =?utf-8?B?bE1UTFhaUjN4Z1BSd0FwcGVqdXpOUDZQR25YamR0TWxXTlN4Wmg3dG5wSGdi?=
 =?utf-8?B?MEs2eHlsT2V6bWExTHNRSm9RQlRwUXFjN0xvRCsvbS8weXBPQ01sWElabTJR?=
 =?utf-8?B?OGk0cElMWnlJMmplanU1Q21rczZKSzkxMWR3MkFxaThDSkxZYlZVSGwwSWpT?=
 =?utf-8?B?cFFlZEFuenBtVTYrZnBHRWJ0ajQvaHdoL1kvOTdXK1NET3RSY05RY0V6TnlI?=
 =?utf-8?B?VCsvU3MyRVhBcDVuYVBUaHkwS1NMWWNFZTByWnRLaGc4bDU2VHJsZWtxTUw5?=
 =?utf-8?B?QVVEdEJXSFBTWG5ob0Y2T1czSzhPTDNrNldEVFBpUTBGVFdoajI3bWU1R25m?=
 =?utf-8?B?R0RXWHEyTnB2VWF0NHpHR0gzT1E5VitqdzBCOE95SlFDL3pkbnRjeWh5SjlO?=
 =?utf-8?B?MlFLTGhBMmxuOGYveGdqMllZK3d0eFp4aExDeEFjbGkvV2NNTXlleFVnbU1w?=
 =?utf-8?B?YTJta0hoRVIxWFJINHBkenlCSisvQUNoTE9sM3dReWJ4cHY1bG00MHZhYWda?=
 =?utf-8?B?eGpSaFhnU0ozSHBmZzNJbC82YktBSng0VVova1ZQZDlDZUxRYnZ3eW5ROEE1?=
 =?utf-8?B?ZGZKclM4b3kwT3diaGN6MW40TlN5SDhuTGZXQmJIOFk5Z3FMcEtyVTdXelZW?=
 =?utf-8?B?T21RbVc3V3hXc0x0WU5NcmVZNmFQSyt5QnhwT0VYbDlWYkgzeWpFblFHUU84?=
 =?utf-8?B?ZmhweVgwK2YwelR1QjNNVDYxZS9OQ2RXN0VoMHZpNDFqU0JTbm9ZSWpzUDFT?=
 =?utf-8?B?NlVwRml3Z3ZrSUc4T25tcUZ4ZUN5RndPRkdXVGhOMEdiOGVSNVkvcmxPNDZZ?=
 =?utf-8?B?MU53MDVXNDRmU3JiYm9LWnZHNXYweDVGQ0laK01iQmZUZjA1UWRNZDI3YWRr?=
 =?utf-8?B?aHJtTkM0Q1BEMllHREVza09xUjBieEVIQU9HMVNQdnJkL0JHT3VqbDNzYUZn?=
 =?utf-8?B?aUJGTVhNUllibTFaWXE0ZVhKU3JjdDduQ05WZnkzcW1MZHpDWldwSDkrRlIx?=
 =?utf-8?B?QjYxVzN2VkdqVjJVbTAxYVZmVmtSLy81T1UvZnY4WkZWRWtDUERqWTZCWDNi?=
 =?utf-8?B?L2E5bDlDNVBYaXJkMEw2Z3pIYzBET3lPMm4yYnZ4V0J2dWVRamYrYVVmeG92?=
 =?utf-8?B?aVk3OStSR1lEZ3Q4bzh0N3djT0d0K3ZFb1FvZlJxSldwSnRBZk1XMnNWSWtT?=
 =?utf-8?B?ZENTR2tscWduOWFFOSszWGpzZ21rTksyNDczdGJESjJNUE83bWp1T2ZNV3FM?=
 =?utf-8?B?aUw3Sjl4ZHRpT3BEREpnMW03U25mN0ZyMkM2UWhJYk5xVTBlanh1WlBPN0ps?=
 =?utf-8?B?ZHJBeW0rTldYb0tLcURkYnJGWHc1VzR2RzBBUlhzbVhLakFoZC9zWkhFOXR4?=
 =?utf-8?B?VmFCcDlUV2VQU0U5cW9sajExclpnUWRBcTIvZmVMTEpQMHlsaSs1NGU0TG44?=
 =?utf-8?B?cUhiVlJ1K2ZlUFRRcWFERnJFZXFWV0Fnd25XeG85R2RkNFZmRDZqUFU2L21s?=
 =?utf-8?B?OFNQR3hWK0Z5MHFjdzhYWWRxc3RuWmNUd2ZzUWVJUGdYWG0wMFdrVThMb3B2?=
 =?utf-8?B?MC9kUk53Q2ZhVHBJb0xRSWVUd2l2UGtXVSt0dlowZmxPQlVpeVJFbXdna3Q3?=
 =?utf-8?B?Y2phMXRoRGo2N0xzbUM0QmxHV0NqbmhjMHYzSWRhRldUMDgrbkJoV3BESGx6?=
 =?utf-8?B?Z1lZNXRFWkVqNnE1UHpjK0xROGI5RllmWCtVcktzUWNSakhsMnN3WFpYRm4v?=
 =?utf-8?B?MFZlaWplbm53UU1lYjliQUhnb2xCenJWWk1ua0J5VStFTVlSMW5RR0J1SmVE?=
 =?utf-8?B?elBkQjUyRlhOM3hYdGE4Q05BdGtrZitqM1hGRXZEYjI3OVd1WHlNSHltblVk?=
 =?utf-8?B?eGFtdlphZTFJRnk4bHdlTXdIb2Vua2NrNmNzUkYyVFphcXVrZkRPYXNOSExm?=
 =?utf-8?B?R1BUWTlqNEdUNnN2bE9DSXBSQzZPUDlMb0VJVWwxYURqc3p6Q3JqNURHb3Jh?=
 =?utf-8?Q?Gd8sSnrwcp1bshJAECPeLc95V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161cfe6e-6e6e-4c5e-79ae-08dabc73f014
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 01:45:36.1168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y0crazZCbdjPN5KpfPg/n2wP8jlcJQmEhpUeSzFzx56XCKEJ0lFM4pngaMZQGKrhGigymx5ACn418rQ8oLBCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMuW5tDEx5pyIMeaXpSAxNjo0NQ0KPiBUbzog
U2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgSG9uZ3hpbmcgWmh1DQo+IDxob25neGlu
Zy56aHVAbnhwLmNvbT4NCj4gQ2M6IG1hcmV4QGRlbnguZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNv
bTsgdmtvdWxAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsNCj4gYWxleGFuZGVyLnN0ZWluQGV3LnRxLWdyb3VwLmNvbTsgcmljaGFy
ZC5sZWl0bmVyQGxpbnV4LmRldjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1dHJvbml4
LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxXSBzb2M6IGlteDogaW14OG1wLWJsay1jdHJsOiBBZGQgUENJZSBTWVNQTEwNCj4gY29u
ZmlndXJhdGlvbnMNCj4gDQo+IEhpIFNoYXduLCBSaWNoYXJkLA0KPiANCj4gQW0gU2Ftc3RhZywg
ZGVtIDI5LjEwLjIwMjIgdW0gMTY6NDUgKzA4MDAgc2NocmllYiBTaGF3biBHdW86DQo+ID4gT24g
TW9uLCBPY3QgMjQsIDIwMjIgYXQgMDE6NDM6MDlQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6
DQo+ID4gPiBBZGQgUENJZSBTWVNQTEwgY29uZmlndXJhdGlvbnMsIHRodXMgdGhlIGludGVybmFs
IFNZU1BMTCBjYW4gYmUgdXNlZA0KPiA+ID4gYXMgaS5NWDhNUCBQQ0llIHJlZmVyZW5jZSBjbG9j
ay4NCj4gPiA+DQo+ID4gPiBUaGUgZm9sbG93aW5nIHByb3BlcnRpZXMgb2YgUEhZIGR0cyBub2Rl
IHNob3VsZCBiZSBjaGFuZ2VkIGFjY29yZGluZ2x5Lg0KPiA+ID4gICAtIFNldCAnZnNsLHJlZmNs
ay1wYWQtbW9kZScgYXMgJzxJTVg4X1BDSUVfUkVGQ0xLX1BBRF9PVVRQVVQ+Jy4NCj4gPiA+ICAg
LSBDaGFuZ2UgJ2Nsb2NrcycgdG8gJzwmY2xrIElNWDhNUF9DTEtfSFNJT19ST09UPicuDQo+ID4g
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29t
Pg0KPiA+DQo+ID4gQXBwbGllZCwgdGhhbmtzIQ0KPiANCj4gU29ycnkgZm9yIHRoZSBsYXRlIHJl
cGx5LCBidXQgSSdtIG5vdCByZWFsbHkgaGFwcHkgd2l0aCB0aGUgZmFjdCB0aGF0IHRoZSBQTEwg
aXMNCj4gbm93IHVuY29uZGl0aW9uYWxseSBlbmFibGVkLCBldmVuIHRob3VnaCBpdCBpcyBvbmx5
IG5lZWRlZCB3aGVuIHRoZXJlIGlzIG5vDQo+IGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayBzb3Vy
Y2UuDQo+IEkgZmVhciB0aGF0IHRoaXMgd2lsbCBiZSBoYXJkIHRvIGNvcnJlY3QgbGF0ZXIgb24g
YXMgdGhlIERUIGFic3RyYWN0aW9uIGlzIHdyb25nLCBhcw0KPiBJTVg4TVBfQ0xLX0hTSU9fUk9P
VCBpcyBOT1QgdGhlIHJlZmVyZW5jZSBjbG9jayBmb3IgdGhlIFBIWSwgYnV0IHRoZSBQTEwNCj4g
Z2VuZXJhdGVkIGNsb2NrLCB3aGljaCBpc24ndCBwcm9wZXJseSBleHBvc2VkIHdpdGggdGhpcyBz
ZXJpZXMuDQpIaSBMdWNhczoNCkZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRz
Lg0KDQpJTUhPLCBJJ20gbm90IHN1cmUgaXQncyBwcm9wZXIgb3Igbm90IHRvIGRlc2NyaWJlIHRo
ZSBoYXJkd2FyZSBsb2dpYyBpbg0KIHRoZSBQSFkgbm9kZSB3aGVuIGludGVybmFsIFNZU1BMTCBp
cyB1c2VkIGFzIFBDSWUgUEhZIHJlZmVyZW5jZSBjbG9jay4NClNvLCBJJ20gdHJ5aW5nIHRvIGdl
dCBzb21lIHN1Z2dlc3Rpb25zIGFuZCB1c2VkIHRvIHNlbmQgb3V0IGFuIGVtYWlsIHRvDQogeW91
IGFuZCBNYXJjZWwgb24gU2VwMjAuDQoNCk9rYXksIGlmIHlvdSB0aGluayBpdCdzIG5vdCBjb3Jy
ZWN0IHRvIGV4cG9zZSBJTVg4TVBfQ0xLX0hTSU9fUk9PVCBjbG9jaw0KIG91dC4NCldoaWNoIGNs
b2NrIHlvdSBhcmUgcHJlZmVyIHRvIHVzZSBhcyBQSFkgcmVmZXJlbmNlIGNsb2NrIGhlcmU/DQoN
ClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KPiANCj4gSSdtIG5vdCBoYXBw
eSB0byBzZWUgdGhpcyBnb2luZyBpbiBpbiB0aGUgY3VycmVudCBzdGF0ZSBhbmQgaWYgbm90IHRv
byBsYXRlIHdvdWxkDQo+IGxpa2UgdG8gYXNrIFNoYXduIHRvIHJlbW92ZSBpdCBmcm9tIHRoZSB0
cmVlIGFnYWluLg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCg0K
