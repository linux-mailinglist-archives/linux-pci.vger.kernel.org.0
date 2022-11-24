Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0737A637E89
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 18:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKXRti (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 12:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXRtg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 12:49:36 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D028C1F77;
        Thu, 24 Nov 2022 09:49:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBqY8I5N709Y+Oyk+pkEEx87gU29Dowkv35FzSXbD6MddmwSWJ05g+5HiOYqd8eDMXIrwUoFfVFGGSLNtHPpI5Jr+KTqfBx7bJKitFWxr80J+kBYxrHQB3R8qgVkKB4EO8pD2qu3LMAdUyLsFsX7hZ6dpMwn+F79HyuM/fNL+QtXi+aR9VRvUjGG9FmPAZlVaSm6ER3xE/A/9sr08rI5sxntW7TZ961/ZSJ+5PrDNdqLi1EP7pAdd+138PFLP5tD2se81U17UNNySBj9DUnMH3OhSfOd2seUOuL3L3UyAEDcJddm1R5qj3fbkLyZsgmplbs2YJNAmMEArGUSnu2+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIL9govv2LR/o8J7p+wV6rRJ0PZ+tagL527vk6yQ+lE=;
 b=ht2FhOVZ22bVY50Oaf1spr8w0A0B/6tMwVGPak+/YK7pKB39AY8aiT+2r+qBaJ59ZfCizQwTuE+d9h8m+DhXohq/QVttVd/QmvYtLtYMpveIDLSxgyulnwk/wETFjsPFAUJNQ9M+6as+7cRy7rO+sJkTXGEnf+tZbFMRLKSGvrhvmK7LRleqZ/d4kjz7o/SXTQ/KdTZOPdI2NRYCdCkF9SPFLz8xwGpJ+9zVq0wljhIBxPgSVkkHa+MfRztnqZJvjHWyXyJeih946q6u3qAMYvjgqqDFWM41sC+/upL0SNu0rllMMia8dIOtzb6FXVnw8HoXqNtWuHQNsVyqyr7i7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIL9govv2LR/o8J7p+wV6rRJ0PZ+tagL527vk6yQ+lE=;
 b=C4JgjWLzL6Lebw9ux46YSXAYZQfck0n2UMrkziYRLF3hhV02JLz6Go2F544vfMYAP63d5WMKnJxYmh6M+h/aeeLJ7d8S7hk+csR759I+yO2zjOnw/3rOvP8qoE6arU/3pRdIxwx1kABYy/exCi3Hxa1KHRSumItIX892dQoiQB4=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB8PR04MB7003.eurprd04.prod.outlook.com (2603:10a6:10:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 17:49:33 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5834.015; Thu, 24 Nov
 2022 17:49:32 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        "jdmason@kudzu.us" <jdmason@kudzu.us>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kishon@ti.com" <kishon@ti.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>, "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "lznuaa@gmail.com" <lznuaa@gmail.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: RE: [EXT] Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change
 doorbell register offset calc mathod
Thread-Topic: [EXT] Re: [PATCH v13 1/2] PCI: endpoint: pci-epf-vntb: change
 doorbell register offset calc mathod
Thread-Index: AQHY/8jAG9vNVXWRjUy04adMBun1ma5NzBqAgACIIDA=
Date:   Thu, 24 Nov 2022 17:49:32 +0000
Message-ID: <HE1PR0401MB233169E8D223BC8809BB3DB8880F9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20221124055036.1630573-1-Frank.Li@nxp.com>
 <20221124055036.1630573-2-Frank.Li@nxp.com> <20221124091921.GD5119@thinkpad>
In-Reply-To: <20221124091921.GD5119@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|DB8PR04MB7003:EE_
x-ms-office365-filtering-correlation-id: 70a2c47f-cdd2-4983-a9ae-08dace443e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iilQgCd+GCkTZ/mYKtVrEnTiR1JsCuVJmpKm2ZBfCTt/elcQilAmAgRwvXwP1YPQ4VlyUtmhEIf9GoMYyrd4PFVH6piPg+jVxa+3ADPXgbnjnAyY2qJ7v6tj/GNferib8OMdOQBAWKX9AypvONAkwM1uVEw9EvzoJo7fHJRiVEdMv1DDnzVIwO35za9PbH5MRskf4g3C0guEPfhW1QZLURtqcbD/4rg5yOidnO+0puCDh5jkgq6B+Av+U6DjynlvUBY+C4c+s9XG9WHuvncdqw4+0oRny0rOqknXy/ZDhIyX93gFzbwNjm2CAV2lhqVYbqjKPYN3xIMLSkifigDcr9QmmxNq2/iS71lhm/xrnLVgBOj82KCZEhEF7eniCwo8Q9UWyyQWNYPAOSllZcUVBh8m0zmAzCR0hG7BW3c9C+hwC0M9YQpsuVx4PRjL4GrNN4bSVhwXO1pfSZKSfg0/uJVfNZ1D0Jqo7Vcf48YIA7fPpUuOz14vLWV9X8Ffurie6BpnMpdO5wavGXPG0QEHwKI7yhNu4HWB4CPybCSVdvtwv7geMgrJSCTH/okCjhSTn1J0ZBhF1QqbHgNjKTdXxwoVuB9M/zQCHL0xWEKdTs8Kz3vzDvCdKMtLhz+GeDDpzPUzKp378QskRU1mBUTs/PSsAdmYeG1LV3QzI53D/lT9U6q6J7uujC/CWeRJ00cl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(83380400001)(41300700001)(5660300002)(7416002)(44832011)(186003)(52536014)(8936002)(38100700002)(33656002)(86362001)(55016003)(122000001)(2906002)(38070700005)(55236004)(53546011)(7696005)(6506007)(9686003)(26005)(316002)(6916009)(54906003)(71200400001)(4326008)(66446008)(478600001)(66556008)(66476007)(64756008)(66946007)(76116006)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGJlNnV0MHlpVjdzZ2JncUZHT2ZYeS9aam93bzUrRlJuOHpwTFA1N3RuaTdn?=
 =?utf-8?B?WCtFVFRWL0RibVBVekozdStlaXQxNVQrdUFYWjJkTUloNUttNzFmL3pMWnRl?=
 =?utf-8?B?Y3lYUEZGclE0M1h6a1huVVl4TTdJbWhtcjFnWWpsRFg4UytBdmtoeHN1cGxU?=
 =?utf-8?B?ZGpESmg1SS9CRExvUjhpRG5OOEZ3ZXBCVGN2RjJiOVUzbEF1Mmdod0VYK2Vl?=
 =?utf-8?B?UkM5bWRVcWh2S0ROQk5CbzNialRrby9IdTlDWXZCeGZCUXJSUUZIZjdiWEJ5?=
 =?utf-8?B?TzE2SHRvMGgxSnVyamovMkFDMGNmNkNHeGVFTGRqR0pYZmxudDI0dnBMMkxx?=
 =?utf-8?B?TWIwcFluS21SUlBGZ2ptakIrZmdYVXJJQTd2TXgrd0x5R01CQjB3RnI1OHNi?=
 =?utf-8?B?QTRXbUdYSDI4eDdRSkpUbkwzclhwYzFsc2l4d3VQTDA0T21rN1NXRGd5M21U?=
 =?utf-8?B?VTg3SHUxS1cyS1dTUUtqbVNNWkowUFBpcVVwR1pOZklYY2ptZXBEZmVlcTBl?=
 =?utf-8?B?c1NDYUh0OEcyaHJpZmpXclMrU2ZLL1hZOXFxSmpkSnJjSXhRTGdzWUh6VThJ?=
 =?utf-8?B?SVdpVmhybUhobVAvZlhsWGRSeGgwTm5oYk5WQTR3TzR4VHViZHlEVUxXMG5J?=
 =?utf-8?B?VDlxdWM0N1MwNGp4ZGtkclJ0Zkk5dDJPZm5nZFRPZmZvZ0ZPS1MxWnd0UTZZ?=
 =?utf-8?B?NWdWVUdYdlFpUDV0c3EwaU5vVWtBMmhFcUgzWllNU3lSTUQ0ZWNPb1V0TTFi?=
 =?utf-8?B?ME9vV2dlZEF6bmtwQkNYcVQvWm5GV2tQUnBLZ0VKaVU1Y0hYSTk3a3FFQU54?=
 =?utf-8?B?anh1QmNseTJEVHNqc1VDS3cyVkJRV3pDd2hMdlI1TGErbzlleUpuNGVraFdE?=
 =?utf-8?B?Sytra0F4Vk94R1pRTGxteWh1amhMd3ptYXlUenNCNktRMGozSUZmWTZaanYw?=
 =?utf-8?B?bjB4SXp0OFVhZUZjOGtxYmlRMnNJcHdwN2tJSElrVk5adU5lUUpXMVVyTyt3?=
 =?utf-8?B?Z2lpT3RJbjBTZ2dFM0k5QXh1YXc1TUFCMm95dVFNYWdSZVYydk5ST0ZIQWVS?=
 =?utf-8?B?eGs3RG1pTitOeHg1M2kwZGx3WjRLYVZqODVqd21odzRSSndSWHMyaUVrU0Rk?=
 =?utf-8?B?QzJhakY0TWRqRmlUbFd3cnZoRGliMGZhK0JaK2R2b1lCZ2JjVGx1aHgvSkJI?=
 =?utf-8?B?V1BzeWVmbVJjdmJRWmhRZGRJaGhURWsvMG5wbURieHBIalZ0RDlXWXlhT2xs?=
 =?utf-8?B?Ym9DaVduSzZWVzZXWHVIZjdnYTFNU2J4UnNST3FLeUpGL2JQcHFBUHhMSXI3?=
 =?utf-8?B?Z25vZCtEem4rT3dvVlFZWUplN3J1SmZ6T1VLckhUbC9uWkRrMS9QbXpCOVR3?=
 =?utf-8?B?aHZVazRRTm1qSURlYnpWSXQxaEE3NmxNT3BlZ2traTFpQWhRUDJsQjRycTN4?=
 =?utf-8?B?Z0hEODR1TFZPVkNmWVQzbmxORDA2NzBuOGgwbjhROU42UXZWT0huR2tpVVFP?=
 =?utf-8?B?UzhwR2JZUlZqSnFYdlVqd1o4WmJ4MHp4Wm11UVBvbnFWdHE4aVFGbWZrUG5q?=
 =?utf-8?B?MHI0dnFINUVsREFVSkErVVR0cFBNZFRXSDNkR1FqV2w5N2hidVlGV0w2Y1Vq?=
 =?utf-8?B?VGxHQlhWYjBIYlg0c3Nzb1k4RFdpdUVHVDZjUEhPTk9NVDcrOVJicHJOYTkr?=
 =?utf-8?B?Y21RUTVod0dHcEZMdGpRSkV3SXZ1S0htWXpVVHdhWjFma2VXNm9vbEEvREdJ?=
 =?utf-8?B?Y005M01JRHBvb3hBaXhYK2pIN2k1WHJKeXFaZWQrNWp2OVNDMTY2Y3A5cE11?=
 =?utf-8?B?a280VzhPL1MyVGNVZUo1VFpUQnpDa21XRzR5VkhSQmlCNDNGVC91dWNLdWVj?=
 =?utf-8?B?aHQ3bExBaTRIUHJOZktwTWhlQ1J0STBHNTU5L0FVRkU1dDhJb3c0Qkl0elhp?=
 =?utf-8?B?NWUxazBaT1FtMHI2MUxLdkRMcVE1dGZWelRIcDU5Z0thRUxRTjJGbjRYbkV6?=
 =?utf-8?B?SU9sVjNFMEd4MnVJelhlejJiL3dVVEpOU0dXcm5kWnNOZTNvRzVRb1FOM2V5?=
 =?utf-8?B?VjJKbVlEOUgrcWxTZkFRNVYrdXNNamtzaVQwbit4LzZjSGFvbU5DWGkxUWlw?=
 =?utf-8?Q?FNWE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a2c47f-cdd2-4983-a9ae-08dace443e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 17:49:32.5538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QA6u/q/hSYFPvckezRE+e8OyFGfDvpzpLtgSbGtNhdknJWhlGBjFHvdibMx5pb4txs8IgunkAP1L9mSPvpLp7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7003
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIE5vdmVtYmVyIDI0LCAyMDIyIDM6MTkgQU0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPg0KPiBDYzogbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBBaXNoZW5nIERvbmcgPGFpc2hl
bmcuZG9uZ0BueHAuY29tPjsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gaW14QGxpc3RzLmxpbnV4LmRldjsg
amRtYXNvbkBrdWR6dS51czsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBraXNob25AdGkuY29t
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGt3QGxpbnV4LmNvbTsgbGludXgt
DQo+IGFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOw0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBsem51YWFAZ21h
aWwuY29tOyBtYXpAa2VybmVsLm9yZzsNCj4gbnRiQGxpc3RzLmxpbnV4LmRldjsgUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHRnbHhAbGludXRyb25peC5kZQ0KPiBTdWJq
ZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxMyAxLzJdIFBDSTogZW5kcG9pbnQ6IHBjaS1lcGYtdm50
YjogY2hhbmdlDQo+IGRvb3JiZWxsIHJlZ2lzdGVyIG9mZnNldCBjYWxjIG1hdGhvZA0KPiANCj4g
Q2F1dGlvbjogRVhUIEVtYWlsDQo+IA0KPiBPbiBUaHUsIE5vdiAyNCwgMjAyMiBhdCAxMjo1MDoz
NUFNIC0wNTAwLCBGcmFuayBMaSB3cm90ZToNCj4gPiBJbiBkcml2ZXJzL250Yi9ody9lcGYvbnRi
X2h3X2VwZi5jDQo+ID4gbnRiX2VwZl9wZWVyX2RiX3NldCgpDQo+ID4gew0KPiA+ICAgIC4uLg0K
PiA+ICAgIGRiX29mZnNldCA9IHJlYWRsKG5kZXYtPmN0cmxfcmVnICsgTlRCX0VQRl9EQl9PRkZT
RVQoaW50ZXJydXB0X251bSkpOw0KPiA+ICAgIHdyaXRlbChkYl9kYXRhLCBuZGV2LT5kYl9yZWcg
KyAoZGJfZW50cnlfc2l6ZSAqIGludGVycnVwdF9udW0pICsNCj4gPiAgICAgICAgICAgICAgICBk
Yl9vZmZzZXQpOw0KPiA+ICAgIC4uLg0KPiA+IH0NCj4gPg0KPiA+IFRoZSBkb29yIHJlZ2lzdGVy
IG9mZnNldCdzIGZvcm11bGFyIGlzDQo+ID4gICAgICAgb2Zmc2V0ID0gZGJfZW50cnlfc2l6ZSAq
IGludGVycnVwdF9udW0gKyBkYl9vZmZzZXRbaW50ZXJydXB0X251bWJlcl0NCj4gDQo+IFlvdSBk
aWQgbm90IG1lbnRpb24gdGhlIERCIEJBUiBoZXJlLiBXaXRob3V0IHRoYXQsIHRoaXMgY2FsY3Vs
YXRpb24gZG9lc24ndA0KPiBtYWtlIHNlbnNlLg0KDQpEb29yYmVsbCByZWdpc3RlciBvZmZzZXQg
c2hvdWxkIG1lYW5zIEJhc2Ugb24gREIgQkFSLiANCkhvdyBhYm91dCAiVGhlIGZvcm11bGEgb2Yg
IGRvb3IgcmVnaXN0ZXIgb2Zmc2V0IHJlZmVyIHRvIERCIEJBUiI/DQoNCj4gDQo+ID4NCj4gPiBQ
cmV2aW91cyBkYl9lbnRyeV9zaXplIGlzIDQsIGFsbCBkYl9vZmZzZXQgaXMgMC4NCj4gDQo+IHMv
UHJldmlvdXMvUHJldmlvdXNseQ0KPiANCj4gPiAgICAgICBpcnEgfCBvZmZzZXQNCj4gPiAgICAg
ICAgLS0tLS0tLS0tLS0tLS0NCj4gPiAgICAgICAgICAwICAgICAwDQo+ID4gICAgICAgICAgMSAg
ICAgNA0KPiA+ICAgICAgICAgIDIgICAgIDgNCj4gPiAgICAgICAgIC4uLg0KPiA+DQo+ID4gQ2hh
bmdlIHRvIGRiX2VudHJ5X3NpemUgaXMgMCBhbmQgZGJfb2Zmc2V0IGlzIDAsIDQsIDgsIC4uLg0K
PiA+IFNvIHdlIGNhbiBnZXQgdGhlIHNhbWUgbWFwIHZhbHVlIGJldHdlZW4gaXJxIGFuZCBvZmZz
ZXQuIFRoaXMgd2lsbCBiZQ0KPiA+IGNvbnZlbmllbmNlIGZvciBoYXJkd2FyZSBkb29yYmVsbCBy
ZWdpc3RlciBtZW1vcnkgbWFwLg0KPiA+DQo+IA0KPiBJbiB5b3VyIGlycS1pbXgtbXUtbXNpLmMg
ZHJpdmVyLCB0aGUgbXNpX2FkZHJlc3MgaXMgY2FsY3VsYXRlZCBhczoNCj4gDQo+IGBgYA0KPiB1
NjQgYWRkciA9IG1zaV9kYXRhLT5tc2lpcl9hZGRyICsgNCAqIGRhdGEtPmh3aXJxOw0KPiBgYGAN
Cj4gDQo+IFNvIHRoZSBNU0kgYWRkcmVzc2VzIGl0c2VsZiBhcmUgb2YgNCBieXRlcyB3aWR0aC4g
U28gdGhlIG9mZnNldHMgd2lsbCBiZQ0KPiBzZXBhcmF0ZWQgYnkgOCBieXRlcyBsaWtlLCAwLCA4
LCAxNiwuLi4gYW5kIHRoaXMgd29uJ3QgbWF0Y2ggdGhlIE1TSSBhZGRyZXNzZXMNCj4gYXMgdGhl
eSBhcmUgNCBieXRlcyBhcGFydC4NCg0KQWRkciBpcyBhYnNvbHV0ZSBwaHlzaWNhbCBJTyBhZGRy
ZXNzLCB3aGljaCBpbmNyZWFzZWQgYnkgNC4gQnV0IGl0IGRvZXNuJ3QgbWF0dGVyLg0KSXQgc2hv
dWxkIGJlIG9rYXkgaWYgcmFuZ2UgaXMgYmV0d2VlbiAyXjMyLg0KDQo+IA0KPiBTbyB5b3Ugd2Fu
dCB0byBjaGFuZ2UgdGhlIG9mZnNldCB0byAwLCA0LCA4LC4uLiBieSB6ZXJvaW5nIGRiX2VudHJ5
X3NpemUsDQo+IHJpZ2h0Pw0KDQpJIHdhbnQgdG8gZGlyZWN0bHkgdXNpbmcgZGJfb2Zmc2V0W2ly
cV0gdmFsdWUgYXMgb2Zmc2V0LiBJdCB3aWxsIGJlIHNpbXBsZS4gDQoNCkkgYW0gbm90IHN1cmUg
d2h5IG50Yl9od19lcGYuYyB1c2UgYmVsb3cgZm9ybXVsYXIuICAgDQogIkRiX29mZnNldFtpcnFd
ICsgaXJxICogZGJfZW50cnlfc2l6ZSINCg0KRGJfZW50cnlfc2l6ZSA9IDAgd2lsbCBiZSBzaW1w
bGUsICBhbGwgb2Zmc2V0IHdpbGwgYmUgY29udHJvbGxlZCBieSBkYl9vZmZzZXRbXQ0KDQpZb3Ug
Y2FuIHNhdmUgZGJfb2Zmc2V0W10gYXMgMCwgNCwgOC4uLiBvciAwLCA4LCAxNiBhcyBuZWVkcy4N
Cg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5j
IHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL3BjaS1lcGYtdm50Yi5jDQo+IGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3Bj
aS1lcGYtdm50Yi5jDQo+ID4gaW5kZXggMDQ2OThlNzk5NWE1Li4wZDc0NDk3NWY4MTUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5j
DQo+ID4gKysrIGIvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5j
DQo+ID4gQEAgLTQ2MSwxMSArNDYxLDExIEBAIHN0YXRpYyBpbnQgZXBmX250Yl9jb25maWdfc3Bh
ZF9iYXJfYWxsb2Moc3RydWN0DQo+IGVwZl9udGIgKm50YikNCj4gPiAgICAgICBjdHJsLT5udW1f
bXdzID0gbnRiLT5udW1fbXdzOw0KPiA+ICAgICAgIG50Yi0+c3BhZF9zaXplID0gc3BhZF9zaXpl
Ow0KPiA+DQo+ID4gLSAgICAgY3RybC0+ZGJfZW50cnlfc2l6ZSA9IHNpemVvZih1MzIpOw0KPiA+
ICsgICAgIGN0cmwtPmRiX2VudHJ5X3NpemUgPSAwOw0KPiA+DQo+ID4gICAgICAgZm9yIChpID0g
MDsgaSA8IG50Yi0+ZGJfY291bnQ7IGkrKykgew0KPiA+ICAgICAgICAgICAgICAgbnRiLT5yZWct
PmRiX2RhdGFbaV0gPSAxICsgaTsNCj4gPiAtICAgICAgICAgICAgIG50Yi0+cmVnLT5kYl9vZmZz
ZXRbaV0gPSAwOw0KPiA+ICsgICAgICAgICAgICAgbnRiLT5yZWctPmRiX29mZnNldFtpXSA9IHNp
emVvZih1MzIpICogaTsNCj4gDQo+IElmIG15IGFib3ZlIHVuZGVyc3RhbmRpbmcgaXMgY29ycmVj
dCwgdGhlbiB5b3UgY291bGQganVzdCByZWFzc2lnbg0KPiAiZGJfZW50cnlfc2l6ZSIgaW4gZXBm
X250Yl9lcGNfbXNpX2luaXQoKS4NCg0KWWVzLCB0aGF0J3Mgb25lIG1ldGhvZC4NCkkgd2FudCB0
byB1c2Ugb25lIG1ldGhvZCB0byBjYWxjIGRiIG9mZnNldCBmb3IgYm90aCBzb2Z0d2FyZSBwb2xs
aW5nDQphbmQgTVNJLiAgU28gb3ZlcmFsbCBsb2dpYyBzaG91bGQgYmUgc2ltcGxlLiANCg0KRnJh
bmsgTGkNCg0KPiANCj4gVGhhbmtzLA0KPiBNYW5pDQo+IA0KPiA+ICAgICAgIH0NCj4gPg0KPiA+
ICAgICAgIHJldHVybiAwOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gDQo+IC0tDQo+IOCu
ruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
