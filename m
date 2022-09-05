Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA085AD381
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 15:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiIENNs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 09:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiIENNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 09:13:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2099.outbound.protection.outlook.com [40.107.113.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA63C16A;
        Mon,  5 Sep 2022 06:13:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAHyz2/fgYFiD79+YY569hZ8CyKAYDnBDy8EVaPPmhNLvgryszo5OnsbFSmh9NmPo1jSnODKvk9nsothD1R8TmUagX4aYPdBReAxxwS4u7FdnG4yj8zITVmI10eArB1UkMaOt6RHcIxZijNVQm9ic3XCII0Cm0N7ZS54nlzyYAE15Fryf3F0wDoUpBAQs9YS+kKcpdW88kgBQZc1nwku8nhpKtNbdlKzMmzAOJiRG9r3WSwBhuLvFW/gZjMyxM9JjIO2JjO13HYVXlBJ0meR3Bt/d/t5IaoR4iUO8XndVY03wzidUg1HhABC3a7aP1LGUezi8zbRsexIcMqhCLengQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILBuemEbWNTarQVUtx8FjjwLF4Yi1gskG0cFft1RJH4=;
 b=LiZo9B5+0F4Nu52eu2/kCYvC+k7vwDUjD7SaDYjimmQmpxN4ZJrKJq15GlgGyyV85UN8xAwaC0k2cfmYbbUBJ0Xo52CFTk0sue+P17KQWmtfuhyQAcNYTBt9G52dPbIcZtOwo36Ap0qY5xF9jY4t6lBY+6Brvd4tmOtDbI7/fq+HC+dzx/r+xwjNIU3iQJTlku56hnJN6ol+ll8DFCCiCQSMARQhT7rmD66CVXJNPtXvpS53Jiw+MqAlGVdViN9mCffYKIVF8cZ+Azlu25JDrVpVAxx4MWjP+SwIFvnZ3DGjjVAEKQsxGT0W8+M7l4+5sx7BNNkP8hgv4tyWPWulFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILBuemEbWNTarQVUtx8FjjwLF4Yi1gskG0cFft1RJH4=;
 b=ACDDL0i7Utp5uIycplBLk1x7CPdRq7WGcSbh5xKtoIMOEDz1d520hZZfwoBtppk6eFm/RNrH6Ma5tfQnpbVO8BXFPQ1rJtU2psXP1J0rVxZ58384fCIVTa5C71H0O81m+Bphf6TMytKA8cDuPz/nJrLuRSDHN2rqQJsgadQ5PFs=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB5638.jpnprd01.prod.outlook.com
 (2603:1096:604:c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 13:13:43 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::307d:7cc:2021:f45f]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::307d:7cc:2021:f45f%8]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 13:13:43 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>
Subject: RE: [PATCH v5 07/12] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Topic: [PATCH v5 07/12] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Index: AQHYwPb3wW5eALtDvkizyp7ZfFF2+q3QhCUAgABMVJA=
Date:   Mon, 5 Sep 2022 13:13:43 +0000
Message-ID: <TYBPR01MB534189CCA490F4A2BF9395D9D87F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220905071257.1059436-1-yoshihiro.shimoda.uh@renesas.com>
 <20220905071257.1059436-8-yoshihiro.shimoda.uh@renesas.com>
 <e615a35a-c052-aeff-8cfd-3efae677d48a@gmail.com>
In-Reply-To: <e615a35a-c052-aeff-8cfd-3efae677d48a@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28bdd0d0-da81-4da1-9447-08da8f407529
x-ms-traffictypediagnostic: OS3PR01MB5638:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YAr96tPaw6RPBzudAZPn5Y60mwptHPQcR8qhBbLNTYl7OH+c+B1gAO5JvO45Vih2G8fvNHZNLdtonmzwgrostBJ36ZFr1HSGZMjG/uq+hElThHTkK8K/0phAUohU/ZsCuH/f1iSFDsiVp0EmxZPjRVFTiU09G5dN1p0t9dosEo8zgTPXjjMpswKbcP9uGxyFJKKA3B1LNE/3OSzwdbP9jOBI1fbdQ6fRXzl4bId47F93deiOVl1KkxbbjUTjSrU9A2K0A6yNBPVtthMkMZs2Y5BqgitBp4ePXOG97CmFgd5WgLdXCnqXSC0owqWqFMgw52BOdYgmpPKk70kuXoNQbyhjDrXvcO4YVQ0KM00d8/V7sQQUZtpdrkYe5Z301Z4qj5MJ8/jn8GP1rsz81qpIsXO10FYLjz7Jkdh6HIgoCCDPuNQ5E25xaAM+5CnyZBSajzKY/nPQtx7vQNY2ardp4pfbGwj7ReNipfFYth1u0Mby3LnhPanrhMMxz2HpDYq9R1S+cx73FPue+tb576uB0+b99GLy6jFdmFLZvkX2RHfOS5R0sYwdo97YhO4n3K6QqYmSMpdHDkn+V4izp9dHpmTra68Dx8jcIzOlKsMvKH5GsH0p2Hf3yIEbct+WueFiyZHUpA3tsoA1n7xZAWeCVaNj+vmHPq29fmyN4p8GgHEjOV41GQGtiq1cX3oIeVaRJg6HH2+AwEz81SPFUboXpBHIXRoCKso6sJKjvqk5J+7mWNb51V+pgufYOoDErls+Ypg4krcjhkSzdJ/xK9j7Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(55016003)(6916009)(54906003)(316002)(9686003)(86362001)(38070700005)(2906002)(122000001)(38100700002)(8936002)(5660300002)(7416002)(66446008)(64756008)(8676002)(33656002)(4326008)(83380400001)(66476007)(66946007)(76116006)(71200400001)(41300700001)(186003)(6506007)(478600001)(52536014)(66556008)(53546011)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEFIQ01aOTRON1J5Wm9xTjZ0QUFYVE44cjZtVVF2Q1lJcExuOWwzc3Z3bTRS?=
 =?utf-8?B?QmowcHdPcHgzTEJWR1FEaE1tUXlnQVFqTmwrOVRudVJjVlRwNU05SlkvNlBC?=
 =?utf-8?B?bW5BQUtHWXJROWRNdEFiUVJKSU56bHRHTFY0eEFLWElYdTc2eHdWZlVudFJv?=
 =?utf-8?B?dnYyOTY5QWtZR1hybXhobTVaZmpsNnFUSksrZjl6TXQrRGZHZWNrWHozZEJm?=
 =?utf-8?B?SFhvNThPbTlsZUVteUhyd0orWERUVCt0VytlNGxybXNWaEhHQVJ1dm4zdGYr?=
 =?utf-8?B?OHE5Vk5QcGxJNHdJaXJhNTR6QVNrMXVnT2hXSzNzNnhsSE1hbXd4d1BQdmQw?=
 =?utf-8?B?dkxGZzI2U1RYUDNERHIrZTNMRDd4ZEpuL01oMW1TSjI2N2pqWFRqOTdMOVpN?=
 =?utf-8?B?RHVjbXpYcXByYnJldEV0Z2lPRWM0RWZvczVKSzc3aTR0MmxmdFFGekpETVlQ?=
 =?utf-8?B?TFhnbnZRQnFETmRFbkNQOGhPS3VWU011OTBEUVllUkYwbVRkQzQ5VmttTUtV?=
 =?utf-8?B?L3ZSNGltUEw4R0NrL3Jacm9NcWx3bi9BVEJhQXVESFhQRkptOUNKMkMxNXow?=
 =?utf-8?B?SjUrNVdJQXkrc3RtSU5SN0xCTVVDTVZwT2k1ZFhqeWRMcG1MTGwrSTcxTzZk?=
 =?utf-8?B?bU9zMEpFNXJTUXdiTHVjeE13VlU3UlFqWUlYM3dwNmRuM3lPYk9zTWdVVkx1?=
 =?utf-8?B?OHBNN2oyWlJxR21WOUpyT3JMNTRyOVVZVTJhanB4a3E3WG9XQ2sxSTZzcGd4?=
 =?utf-8?B?d2ZEM3NDeEVGT0RNSEpBUzlTZ2xRbEpEUXV3SUQzTExISVJ3aEJFUVlaY1pk?=
 =?utf-8?B?cjQ2UVRadXFjbEh6Y3FSRnhIbHhhZTR2TDdtZHFHS20vQmJyeE5GVEJ1cis0?=
 =?utf-8?B?QlZvZVJTeEpXdVpPeW1XSzY2YllGWDVhY1ErSm5VNUU4c0pWY2RWVmtDcitK?=
 =?utf-8?B?Uy82VkVSQXphcjA4QTk5K1A1VDBnWmpwalZLRnUrMnBqNTVYUjNNaThDNWpG?=
 =?utf-8?B?Tm9hSWlyZVhVT0VvSDQzazdwdXRDNkFSL3RFeWZKU1pGdVdUazNYSW84MExU?=
 =?utf-8?B?N2RlLzhLV0tIczNHVGtHWElySVBCY0lTbFJ3SjFLNHlrQjhYNFljM0V3NENI?=
 =?utf-8?B?QXBZLzI0U2xZSlIzQVBEZ2h0Q0RNdVB2NXhFOVJuaU9iK1hzTDRuNm1RQWs2?=
 =?utf-8?B?VTJPTFlDK2ZobTVIQk01endKaCtVbnNPcFh0aGlFdUFMWHc4MnlRdWpENERC?=
 =?utf-8?B?dTk0ZXE2dUdRbkxFb2JpeTk2RTdkQThpaTU3T05tMkNIZ1p0aDZ3UkFEWW5K?=
 =?utf-8?B?ZGd0djA0VjdiOTg4NVVRUDB5RjVtdGd2SFpoYlhDbkprOUI0R0cwL29lakRP?=
 =?utf-8?B?cldXTkJOOHZEV3VBUGc5dDFrejJDM3pRTGhpa09odHFMYmhibEFIekwrMzUr?=
 =?utf-8?B?eTE1bUlGVVkxNlBnaU5IT3FoakIwK2VENk5vSjFmZC9BMytrck5vazVOWG0y?=
 =?utf-8?B?cjVTeDIwRlZPaWlMaXJiNk5vWXgrT1cySzVvK0FlRm0xNFRnWlZOMHFIUnZq?=
 =?utf-8?B?RVhSaTZDRHRFTDl6ckZPdmJ4S2lNZ252cTdPZkJ0SjUycWd3cEVzWWpIUEp6?=
 =?utf-8?B?VHpMVS8ySVFGcm5RSHh3OFZqbnZ0WVRiWWpGNEFuY1pWMmR2YTAvajhJeVN2?=
 =?utf-8?B?RmpGd3RoTU9rL1I1Z3R2Zkp0V0tYMFBCenBLT0tRUXhGWHNMSmsrZ2hGK0R5?=
 =?utf-8?B?ZUlxVUFHeDU2ckZYZFNTTjNpeGg1VGpBTGxTR1RKUkFLM0pyU1dtWHRDQjBx?=
 =?utf-8?B?dUsrWDRFcGZKV3ZHUDZlbnlwc3lYeVRwWVBxR29BajFJWHZYdjh4MEFWNFFp?=
 =?utf-8?B?VldXNThpVmpZeis5Z2h4Rkl1MjFyRnJFa09nSDJjRDhSK3Z2YjNoQ2RsU2Fj?=
 =?utf-8?B?dUhObnNHejVCVEpMbWxSakV0Q05YUjJaaGVIeDdQZ1ZhSFNNeXJvQnEvdFRL?=
 =?utf-8?B?L0Q5Zkp5S0hOaHgxSndZdVBFblRTQ0c2ZmtucFdZSVVKdjlySEJ2YWVoOHNo?=
 =?utf-8?B?M2dSYTVqY2VQekIvWjVEamxCUkxuUjRiWlBudlY2eUNkbGkvL1FlR2JicGdy?=
 =?utf-8?B?ZzVtOE9QcXJsVmtYbUsrVUVVT1YzRkk5V3J6SkM0bTRDQStxZ1hoSnlqS0di?=
 =?utf-8?B?bWZjbXhEQnNacmhEY2QrY0g3ZXM2S0kwSnZDY215c0ZrSldGeENOazdkQ0pt?=
 =?utf-8?B?Y3p1d0IwNzJVVVQySnVoYlN4ZFN3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bdd0d0-da81-4da1-9447-08da8f407529
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 13:13:43.2528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OQayb7xAlFom2OI+djNeLYBxmaONGu0856ZRLIII7s7yQNbm3ngtw5OPmTvqwOvoonUKCOnnGZExkVf3YW+geyC9q6JhVWPA4m8tWDjLRDq9Av0dwuEUkb0sFMpU/WpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5638
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGVsbG8gU2VyZ2VpLXNhbiwNCg0KPiBGcm9tOiBTZXJnZWkgU2h0eWx5b3YsIFNlbnQ6IE1vbmRh
eSwgU2VwdGVtYmVyIDUsIDIwMjIgNTo0MCBQTQ0KPiANCj4gSGVsbG8hDQo+IA0KPiBPbiA5LzUv
MjIgMTA6MTIgQU0sIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiANCj4gPiBTaW5jZSByZWFk
aW5nIHZhbHVlIG9mIFBDSUVfRE1BX1ZJRVdQT1JUX0JBU0UgKyBQQ0lFX0RNQV9DVFJMIHdhcw0K
PiA+IDB4MDAwMDAwMDAgb24gb25lIG9mIFNvQ3MgKFItQ2FyIFM0LTgpLCBpdCBjYW5ub3QgZmlu
ZCB0aGUgZURNQS4NCj4gPiBTbywgZGlyZWN0bHkgcmVhZCB0aGUgZURNQSByZWdpc3RlciBpZiBl
ZG1hLnJlZF9iYXNlIGlzIG5vdCB6ZXJvLg0KPiANCj4gICAgcy9yZWQvcmVnLz8NCg0KVGhhbmsg
eW91IGZvciB5b3VyIHJldmlldyEgSSdsbCBmaXggaXQuDQoNCkJlc3QgcmVnYXJkcywNCllvc2hp
aGlybyBTaGltb2RhDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9z
aGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIHwgNCArKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IGluZGV4IDcyZjk2
MjBhMzc0ZC4uMDhmOTFhNmJiZTRiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiBAQCAtODQ0LDggKzg0NCw3IEBAIHN0YXRp
YyBpbnQgZHdfcGNpZV9lZG1hX2ZpbmRfY2hpcChzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KPiA+ICB7
DQo+ID4gIAl1MzIgdmFsOw0KPiA+DQo+ID4gLQl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ks
IFBDSUVfRE1BX1ZJRVdQT1JUX0JBU0UgKyBQQ0lFX0RNQV9DVFJMKTsNCj4gPiAtCWlmICh2YWwg
PT0gMHhGRkZGRkZGRiAmJiBwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCj4gPiArCWlmIChwY2ktPmVk
bWEucmVnX2Jhc2UpIHsNCj4gPiAgCQlwY2ktPmVkbWEubWYgPSBFRE1BX01GX0VETUFfVU5ST0xM
Ow0KPiA+DQo+ID4gIAkJdmFsID0gZHdfcGNpZV9yZWFkbF9kbWEocGNpLCBQQ0lFX0RNQV9DVFJM
KTsNCj4gWy4uLl0NCj4gDQo+IE1CUiwgU2VyZ2V5DQo=
