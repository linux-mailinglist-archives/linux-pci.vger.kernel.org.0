Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7060FC10
	for <lists+linux-pci@lfdr.de>; Thu, 27 Oct 2022 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbiJ0PeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Oct 2022 11:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbiJ0PeP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Oct 2022 11:34:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A7188A94;
        Thu, 27 Oct 2022 08:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHot0ogoYa7kFatjYgpdtuk3nlsG/8WCVXwRhNtBMA5EGk2rLTjJpDpuJ2B/EYgFxXIGr9yea7eJGMleZo2fG9FZWF1cAWYisvebNq2IgDpJYcZOKzffWC3bz22LZpFq/CAOff2uGNO2rBDT++fL8rz6hHMDjP8ect4sZ5rNLdWGFUQ+p1fL839m8kxOBvE7oIvRHRuKvfL/c0vwgnmynmdqJ61J+PLGa7xfJz3cV8Qu+JNscnq3TWz8FZzNFTJnu3giYAA4MX+ShTS+S9r318tc7Gt3YihqwMhHnpD1VO6nlF3swci+tCHM3eDWhsARs0ZlZpAi8LUVSHdrtI5wXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUzyFmX2SqSAks1JQ+QAg1EL976p94VlZau9j0eD3xs=;
 b=ZNKu7L+Hmp1pWW6pmiJvwc+z5fI637bygbaN/TwCmPBdx2sE8lxBKuBZ+6bL3yYBQLIcTFROhI1fWZP3+XvKhJPoWhdkP/i+KLo23QaIZTqSpTV3p5H0oJYTH1NX7sjim3j/a8rv3kVyXIRQFq/AveL5bZwj600I9g3PW7OSByKu693+Mt0oVL8GJn3l4UPQk/nxzQLWJOEI2OMWn5ESNPwneArMWcUhxbQ2ElO8r/OC6fke4dirhbXzRfhWsWgCN+RbAfAQY3uutocWGkyGretWmdf6sepp42jSjceaZWdczXaoOdFbbe1RsH/Qdtelr5EcH5czsru1rmQ43kkJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUzyFmX2SqSAks1JQ+QAg1EL976p94VlZau9j0eD3xs=;
 b=nxty9R/CJdRrTp8KAZM33hEbeo9amvel679trNJ7CxMOrzdw8LUF6cEJyO8kKzv6MXD8vEwgIX2VkBGoe1Lobpt1AG63PliVDEsG+4mbiCyhUyHeNSn5uqcEO8GSUdHmcsScUnxAf14LdP6XU5N9JXDt53tLJWelAel2VKQC69M=
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by PAXPR04MB9350.eurprd04.prod.outlook.com (2603:10a6:102:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 15:34:11 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::44bb:8387:8f4b:6a28%10]) with mapi id 15.20.5746.028; Thu, 27 Oct
 2022 15:34:11 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Shunsuke Mie <mie@igel.co.jp>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "ntb@lists.linux.dev" <ntb@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Topic: [EXT] Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check
 for no epc alignment constraint
Thread-Index: AQHY6H0/bvuG5O/HGUqsNICaEl4Piq4fRolwgAIzcoCAANaFIIAAC4kAgAABBFA=
Date:   Thu, 27 Oct 2022 15:34:11 +0000
Message-ID: <HE1PR0401MB233111DEC8F76341029183F188339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
References: <20220922092357.123732-1-mie@igel.co.jp>
 <20221025142143.GA109941@thinkpad>
 <HE1PR0401MB233126D2C7410EC5F6C3976488319@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5qjnbZMzFJt8kBtQz6FHc_QQYw7=fZp8kK87mZ-t75z+g@mail.gmail.com>
 <HE1PR0401MB23319EE329D62420919740C688339@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <20221027151220.GC76627@thinkpad>
In-Reply-To: <20221027151220.GC76627@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HE1PR0401MB2331:EE_|PAXPR04MB9350:EE_
x-ms-office365-filtering-correlation-id: 1f001e95-71f2-4e37-2425-08dab830b239
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGqvS5SidGmg4G5344KystixC1eRhbTkNXREJnTL3oEK0OxVkAHQQgiLES5mKFAKuKrkPu6xMG/6+860mjy/k/fo+Zr6SRYs7KMnebuooVrzygIy6+QaABsfJoz+idHXwH5cw5K7V4uhC6PbKZy8QyrCf2vkUBN+MxY9LpZZ/lOzik8MY+OQbGImESLKuNRTh40MUlk03T4ZYvlgJl+vgZ7z79RVgYxwFllfFIqZ43xS5OzldXy8YyhI/E7qi+e+D1aTelJsNab/4gGRJP68JlXXEngesHSuBtE49IaZVyLPWsGoU1Nok/BBx26RcHlcH097tbyJZdcgd3M8821PUS0MvMKrH97dpstyMtiAYQAbvB2jQ5pm6MxOb4yK8k2Z4miIjAffFzQrEwfQUqsowY1Qzs0M/a0J/COROLsOGtL4lHAOqrR9Md7T5VshtlAbb4SLnDGguCsmm+AjWwg8OgcBNsszYkdkWbe+ebvWkYYcREYydTD7zNfGOgPOTO9XAvQRo1kcOyoLRMkGazQODJzRjjrzFAo+o4iBg2OaD/x6z83GPGzoj1PosOeFg4PJdJFVYBG5kNRGqatCPOABXb1+5Ib7bVrgxxmrJVzNzs1V/wwf931uCG4RL/sI8cVEzVDGkVzQmcKqC7iSCmvXrHE+AOj6JbARGy1Sh+7qTNnzj7eorRH+o1KWx/aX7XvdaPHqCogZxdRfbOtqs3/HXQ1RowSlLfnATQMyUO1zcbIJWhgN5Swdy1S45Pz2WaVn/xBSXwuYA6KZqfXQ2E0EuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(38100700002)(5660300002)(44832011)(52536014)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(7416002)(8676002)(8936002)(4326008)(38070700005)(83380400001)(122000001)(86362001)(33656002)(6916009)(54906003)(71200400001)(186003)(9686003)(316002)(478600001)(55016003)(7696005)(55236004)(41300700001)(53546011)(6506007)(2906002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWRrZFdFcWwzWmxKUUhvQmZKK2xjQWxSL0NMSWNFM3dZcnJoVnNISGEvV3Vx?=
 =?utf-8?B?bXJ0MktLdGZhWWhVN2RYd0ttUktVVm92MnZXTWgwUEVLNXhRRm9uZ2tZb0pK?=
 =?utf-8?B?dmlEOGROWWRrenRFNXVDUkx2VVZNWlFNOUIxUDZPRXI1M3JjZE9aaCswY3pI?=
 =?utf-8?B?NGFaUVVuUUgwMUY2RjZRTVprUlJId2NpMGpLekQvaTd6dlBGTm9qMGxNZE5T?=
 =?utf-8?B?dTVhTnNVb1JNRDRXL0NscjkrNlFvMFZrbnZTbEgrZy94a0VyakpaTUY1WDdK?=
 =?utf-8?B?UFBVZ1JnRjV0VWNUK0NEMDJsZ01mbXFPZk1UeHJkbDVrYVZaenVwcFc4dXE4?=
 =?utf-8?B?cUhGNG8rY0FWNFBJNGxOcGk1bkRHS0w1dGxMODVMRkEyVmRKcW5OTWNSMXBD?=
 =?utf-8?B?Uys2V1k1VGgrcjBNekxuMGJQemVmOTRjV1RWN2U5b0FxWjZhbTVGSXFRcDJk?=
 =?utf-8?B?eFVWTjlLcjBkTWJEWWw0N2J4bVM1UWxQc0xMYUVoSmd0TjJIblV3bXNWWWF4?=
 =?utf-8?B?M051ckY0UGVOeWVxU0lMNDg0UHBQc1YzWWpMWFYwWXhOMXI2K2JyVUZKMWVT?=
 =?utf-8?B?MHo1clB5QWhtYzNiZVRNWEtaTTlMaTlsTU16dE9RM3E4bnNMa3Fldzg3U2pN?=
 =?utf-8?B?UWxFajFLU0IxNVBKaEs0ZktPbG8xVk1aQ2JUMGlZQ2U4eDhCbFpSNkUzcjIw?=
 =?utf-8?B?L0hYY01La1YyOHpHcUZsQ3NjUTNoeFRWMkFKdEZzMmNIYVZYM0tpK1J5OGxw?=
 =?utf-8?B?Smp1WENlL0I4MHBvQUxaNFZOemdaNVA4YzhRUVVYVkZ1MHBvY1lSS1B5SGdl?=
 =?utf-8?B?M2RPWkJYV25GQ0dkZzkzOFNWaHdGeFNaUDBVNG1jQzRZT3FnN0tOTHJsM2xs?=
 =?utf-8?B?Y3lLYXRMSlJQRXJDem03SFN3TkNGTmlYbFpzVGdiNUVHWW5Tbi8xRnhQYm9B?=
 =?utf-8?B?SnIwbHVDMlI4Q3FnT1QvTDQvZ0grQ3JUSHNsZC9mOFVKaTRJcTUxSW5HR1A4?=
 =?utf-8?B?LzVKc05YeTJmME5JMEVVTjBOUCtjUWdEdHQ1a2hUL3d6SGViMkRJemJORjA4?=
 =?utf-8?B?OGxBeDV1SktORUxnUGcxd0VRT3ZLMkxuRkczNmo1eVFFV21ibmI3dUgwUTJt?=
 =?utf-8?B?QiswTkdRSnRCM2ZUTXVaTlRZWlJXLzg1Q3NNQkNERUdZYmh3V1lKMkFpY3ZE?=
 =?utf-8?B?QmFUMVloWlV0N1Z6ek1VUmFCa2V0L1k1OGgxYVNxN2F3MmVIRU54c01iTDdl?=
 =?utf-8?B?VlFhRG9raDFxbGtxZU9ZR1ZjeTFkNXV1di9ZeEgvZGF0NDhiSU1YUFZhWUlC?=
 =?utf-8?B?YTlRU1c1Nys3UXhXMHFSckNRL052cWZCcUJZMGFyL0FNa2IrNGZuV0Vnb0lZ?=
 =?utf-8?B?SlBxS2xEOENVcWxJaE5RY3RzVVdkb0JhTG12bFNXamZpQWdQUWtlclBqSHVT?=
 =?utf-8?B?VGF2WnRpNWxZN2c4YS95dUljUU54YVcrVittWVh4akxGdXZVWjE1Zzkxcisz?=
 =?utf-8?B?VGZwbjR3V005WFNxcUVrckhsbWdYU1JrZXZqMnFGcE9hTGhNczFnbnkwSjU2?=
 =?utf-8?B?T0QzVjVKU3VvazM3MTlLdkpGWThOVm5ZbUh2SmJ5ZnBabE84VEExaWgwZllv?=
 =?utf-8?B?a2dmTHNmc3pqQkRFODRuLzl0TjQ0d0tRNHVxWTRGUjR6VDJUU3BVZ0tFWmxY?=
 =?utf-8?B?UUFzSWpwUDBRQlc1ZkcvRGZmUjJSR2dVTHdsL2NLUGhFWG9oeDNhbTNrbG9F?=
 =?utf-8?B?TWkyTjdJRWJmaTM2RHJSd09HY3p0M1VINVFPcGJSSGNVTTRxblFjTDJVTE85?=
 =?utf-8?B?NWhWK0RzU3JzOTBhZkhJa1VxdCtscTF3V0hoOE9FWjZvbkxyWGI0eTZKbkdB?=
 =?utf-8?B?WGVOSno5a0FMQ2VYNmQwRmt3ZXhTMi9QSjJ2T0U0N25XZFU0VWZLaUNtR0JL?=
 =?utf-8?B?bjBCcGxldlVpc1NHUUVFQW1DY3ZFdS9CMm0zT2wzK0pKcWVSOWZ1bTVjcUda?=
 =?utf-8?B?bndaVWJtNWhXYWZoR053NjgvQUhFRmVWYTJRQStaaStoeDhEQ2M3UWZvZTRJ?=
 =?utf-8?B?RGZVNmxnaDJiL1pPS1FGK1VLcnhadytTa2w5blU2NWRFa3krZVFsdUlqZGpH?=
 =?utf-8?Q?SyS8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f001e95-71f2-4e37-2425-08dab830b239
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 15:34:11.4220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIPm6+Nst4Peaxe2I9nx1hA4isfvQwjK8PcFZHgTH/q5/5tWAtKu6qoEsYSkNmVQv01qpZ69Em/Z6ahj9MXb+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogVGh1cnNk
YXksIE9jdG9iZXIgMjcsIDIwMjIgMTA6MTIgQU0NCj4gVG86IEZyYW5rIExpIDxmcmFuay5saUBu
eHAuY29tPg0KPiBDYzogU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD47IEpvbiBNYXNvbiA8
amRtYXNvbkBrdWR6dS51cz47IERhdmUNCj4gSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPjsg
QWxsZW4gSHViYmUgPGFsbGVuYmhAZ21haWwuY29tPjsgS2lzaG9uDQo+IFZpamF5IEFicmFoYW0g
SSA8a2lzaG9uQHRpLmNvbT47IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5v
cmc+Ow0KPiBLcnp5c3p0b2YgV2lsY3p5xYRza2kgPGt3QGxpbnV4LmNvbT47IEJqb3JuIEhlbGdh
YXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5jb20+OyBudGJAbGlzdHMubGludXguZGV2OyBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYyXSBQQ0k6IGVuZHBvaW50OiBwY2ktZXBmLXss
dn1udGI6IGZpeCBhIGNoZWNrIGZvcg0KPiBubyBlcGMgYWxpZ25tZW50IGNvbnN0cmFpbnQNCj4g
DQo+IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gT24gVGh1LCBPY3QgMjcsIDIwMjIgYXQgMDI6
MzU6NTZQTSArMDAwMCwgRnJhbmsgTGkgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFNodW5zdWtlIE1pZSA8bWllQGlnZWwuY28u
anA+DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjYsIDIwMjIgODo0MyBQTQ0KPiA+
ID4gVG86IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiA+ID4gQ2M6IE1hbml2YW5uYW4g
U2FkaGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+OyBKb24NCj4gPiA+
IE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsgRGF2ZSBKaWFuZyA8ZGF2ZS5qaWFuZ0BpbnRlbC5j
b20+OyBBbGxlbg0KPiA+ID4gSHViYmUgPGFsbGVuYmhAZ21haWwuY29tPjsgS2lzaG9uIFZpamF5
IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT47DQo+ID4gPiBMb3JlbnpvIFBpZXJhbGlzaSA8bHBp
ZXJhbGlzaUBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIFdpbGN6ecWEc2tpDQo+ID4gPiA8a3dAbGlu
dXguY29tPjsgQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47DQo+ID4gPiBudGJA
bGlzdHMubGludXguZGV2OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtFWFRdIFJlOiBbUEFUQ0gg
djJdIFBDSTogZW5kcG9pbnQ6IHBjaS1lcGYteyx2fW50YjogZml4IGEgY2hlY2sNCj4gZm9yDQo+
ID4gPiBubyBlcGMgYWxpZ25tZW50IGNvbnN0cmFpbnQNCj4gPiA+DQo+ID4gPiBDYXV0aW9uOiBF
WFQgRW1haWwNCj4gPiA+DQo+ID4gPiBIaSBGcmFuaywNCj4gPiA+DQo+ID4gPiAyMDIy5bm0MTDm
nIgyNuaXpSjmsLQpIDE6MDcgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+Og0KPiA+ID4gPg0K
PiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
ID4gPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2
YW1AbGluYXJvLm9yZz4NCj4gPiA+ID4gPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI1LCAyMDIy
IDk6MjIgQU0NCj4gPiA+ID4gPiBUbzogU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD4NCj4g
PiA+ID4gPiBDYzogSm9uIE1hc29uIDxqZG1hc29uQGt1ZHp1LnVzPjsgRGF2ZSBKaWFuZw0KPiA8
ZGF2ZS5qaWFuZ0BpbnRlbC5jb20+Ow0KPiA+ID4gPiA+IEFsbGVuIEh1YmJlIDxhbGxlbmJoQGdt
YWlsLmNvbT47IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkNCj4gPiA+ID4gPiA8a2lzaG9uQHRpLmNv
bT47IExvcmVuem8gUGllcmFsaXNpIDxscGllcmFsaXNpQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YN
Cj4gPiA+ID4gPiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsgQmpvcm4gSGVsZ2FhcyA8Ymhl
bGdhYXNAZ29vZ2xlLmNvbT47DQo+ID4gPiA+ID4gbnRiQGxpc3RzLmxpbnV4LmRldjsgbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+ID4gPiA+ID4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2Ml0gUENJOiBlbmRwb2ludDog
cGNpLWVwZi17LHZ9bnRiOiBmaXggYSBjaGVjaw0KPiBmb3INCj4gPiA+IG5vDQo+ID4gPiA+ID4g
ZXBjIGFsaWdubWVudCBjb25zdHJhaW50DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBDYXV0aW9uOiBF
WFQgRW1haWwNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIFRodSwgU2VwIDIyLCAyMDIyIGF0IDA2
OjIzOjU3UE0gKzA5MDAsIFNodW5zdWtlIE1pZSB3cm90ZToNCj4gPiA+ID4gPiA+IFNvbWUgUENJ
IGVuZHBvaW50IGNvbnRyb2xsZXJzIGhhdmUgbm8gYWxpZ25tZW50IGNvbnN0cmFpbnRzLCBhbmQN
Cj4gdGhlDQo+ID4gPiA+ID4gPiBlcGNfZmVhdHVyZXMtPmFsaWduIGJlY29tZXMgMC4gSW4gdGhp
cyBjYXNlLCBJU19BTElHTkVEKCkgaW4NCj4gPiA+ID4NCj4gPiA+ID4gW0ZyYW5rIExpXSB3aHkg
bm90IHNldCBlcGNfZmVhdHVyZXMtPmFsaWduIDENCj4gPiA+ID4gbm8gYWxpZ25tZW50IGNvbnN0
cmFpbnRzIHNob3VsZCBtZWFuIGFsaWduIHRvIGJ5dGUuDQo+ID4gPiBJdCBpcyBvbmUgb2YgdGhl
IHNvbHV0aW9ucyB0b28gSSB0aGluay4gQnV0IGluIHRoYXQgY2FzZSwgIHdlIG5lZWQgdG8NCj4g
PiA+IHdyaXRlIGVwY19mZWF0dXJlcy0+YWxpZ24gPSAxIHRvIGFsbCBlcGMgZHJpdmVycywgZHdj
LCBxY29tLCByY2FyLA0KPiA+ID4gdGVncmEsIGFuZCBldGMuDQo+ID4gPg0KPiA+ID4gSSB0aGlu
ayB0aGF0IG15IGNoYW5nZSBpcyBiZXR0ZXIuDQo+ID4NCj4gPiBJIHRoaW5rIGl0IHNob3VsZCBi
ZSBiYXNlZCBvbiB3aGF0IG9yaWdpbmFsIHRlcm0gZGVmaW5lZC4NCj4gPiBJdCBzaG91bGQgYmUg
Zml4ZWQgYXQgd2hlcmUgbWFrZSBtaXN0YWtlLg0KPiA+DQo+IA0KPiAxYnl0ZSBpcyB0aGUgZGVm
YXVsdCBhbGlnbm1lbnQgdGhhdCBkcml2ZXJzIGNhbiBhc3N1bWUsIHdoeSBkbyB5b3Ugd2FudA0K
PiBkcml2ZXJzDQo+IHRvIHNldCB0aGVtIGV4cGxpY2l0bHkgd2hlbiB0aGV5IGRvIG5vdCB3YW50
IGFueSBzcGVjaWFsIGFsaWdubWVudD8NCg0KV2hhdCdzIGRlZmluaXRpb24gb2Ygbm90IGFsaWdu
bWVudCBieSBhbGlnbiB2YXJpYWJsZT8NClVzaW5nIGJvdGggMCBhbmQgMSBhcyBubyBhbGlnbm1l
bnQgaXMgbm90IGdvb2QgZW5vdWdoLiANCg0KSSBncmVwIHdob2xlIGtlcm5lbCBkcml2ZXIgZGly
ZWN0b3J5LCBub3Qgb25lIHVzZSANCglJZiAoYWxpZ24gJiYgSVNfQUxJR05FRCh4LCBhbGlnbikp
ICBzdGF0ZW1lbnQuICAgIA0KDQpUaGVyZSBhcmUgYSBjb21tb24gY29udmVudGlvbiwgYWxpZ24g
aXMgMl5uDQoNCg0KPiANCj4gSSB0aGluayB0aGlzIHBhdGNoIGlzIGZpbmUuDQo+IA0KPiBUaGFu
a3MsDQo+IE1hbmkNCj4gDQo+ID4gQXJlIHRoZXJlIG90aGVyIHBsYWNlIHVzZSBhbGlnbiA9PSAw
IG1lYW5zIG5vIGFsaWdubWVudCBpbiBrZXJuZWw/DQo+ID4NCj4gPiA+DQo+ID4gPiA+ID4gPiBl
cGZfbnRiX2NvbmZpZ19zcGFkX2Jhcl9hbGxvYygpIGRvZXNuJ3Qgd29yayB3ZWxsLiBDaGVjayBm
b3IgdGhpcw0KPiA+ID4gYmVmb3JlDQo+ID4gPiA+ID4gPiBJU19BTElHTkVEKCkuDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5j
by5qcD4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNhZGhh
c2l2YW0NCj4gPiA+ID4gPiA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+ID4gTWFuaQ0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiA+ID4gPiAqIEZp
eCB0aGUgY29tbWl0IG1lc3NhZ2UgaW4gcGhyYXNpbmdzIGFuZCB3b3Jkcy4NCj4gPiA+ID4gPiA+
IC0tLQ0KPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtbnRiLmMgIHwgMiArLQ0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvcGNp
L2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZudGIuYyB8IDIgKy0NCj4gPiA+ID4gPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rp
b25zL3BjaS1lcGYtbnRiLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1bmN0
aW9ucy9wY2ktZXBmLW50Yi5jDQo+ID4gPiA+ID4gPiBpbmRleCA5YTAwNDQ4YzdlNjEuLmY3NDE1
NWVlOGQ3MiAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2VuZHBvaW50L2Z1
bmN0aW9ucy9wY2ktZXBmLW50Yi5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9lbmRw
b2ludC9mdW5jdGlvbnMvcGNpLWVwZi1udGIuYw0KPiA+ID4gPiA+ID4gQEAgLTEwMjEsNyArMTAy
MSw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+IGVwZl9udGJfY29uZmlnX3NwYWRfYmFyX2FsbG9jKHN0
cnVjdA0KPiA+ID4gPiA+IGVwZl9udGIgKm50YiwNCj4gPiA+ID4gPiA+ICAgICAgIHBlZXJfc2l6
ZSA9IHBlZXJfZXBjX2ZlYXR1cmVzLT5iYXJfZml4ZWRfc2l6ZVtwZWVyX2Jhcm5vXTsNCj4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiAgICAgICAvKiBDaGVjayBpZiBlcGNfZmVhdHVyZXMgaXMgcG9w
dWxhdGVkIGluY29ycmVjdGx5ICovDQo+ID4gPiA+ID4gPiAtICAgICBpZiAoKCFJU19BTElHTkVE
KHNpemUsIGFsaWduKSkpDQo+ID4gPiA+ID4gPiArICAgICBpZiAoYWxpZ24gJiYgKCFJU19BTElH
TkVEKHNpemUsIGFsaWduKSkpDQo+ID4gPiA+ID4gPiAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgIHNwYWRfY291bnQgPSBudGItPnNw
YWRfY291bnQ7DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gPiA+ID4gYi9kcml2ZXJzL3BjaS9lbmRwb2lu
dC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gPiA+IGluZGV4IDBlYTg1ZTFkMjky
ZS4uNWUzNDZjMGEwZjA1IDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvZW5k
cG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdm50Yi5jDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJz
L3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bnRiLmMNCj4gPiA+ID4gPiA+IEBAIC00
MTgsNyArNDE4LDcgQEAgc3RhdGljIGludA0KPiBlcGZfbnRiX2NvbmZpZ19zcGFkX2Jhcl9hbGxv
YyhzdHJ1Y3QNCj4gPiA+ID4gPiBlcGZfbnRiICpudGIpDQo+ID4gPiA+ID4gPiAgICAgICBzaXpl
ID0gZXBjX2ZlYXR1cmVzLT5iYXJfZml4ZWRfc2l6ZVtiYXJub107DQo+ID4gPiA+ID4gPiAgICAg
ICBhbGlnbiA9IGVwY19mZWF0dXJlcy0+YWxpZ247DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
LSAgICAgaWYgKCghSVNfQUxJR05FRChzaXplLCBhbGlnbikpKQ0KPiA+ID4gPiA+ID4gKyAgICAg
aWYgKGFsaWduICYmICFJU19BTElHTkVEKHNpemUsIGFsaWduKSkNCj4gPiA+ID4gPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAg
c3BhZF9jb3VudCA9IG50Yi0+c3BhZF9jb3VudDsNCj4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
PiAyLjE3LjENCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+
IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCj4g
PiA+DQo+ID4gPiBCZXN0LA0KPiA+ID4gU2h1bnN1a2UNCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+Cu
teCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
