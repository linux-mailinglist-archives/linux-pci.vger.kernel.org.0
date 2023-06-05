Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D7722187
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFEI4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFEI4j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 04:56:39 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBF7114;
        Mon,  5 Jun 2023 01:56:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cn6dzajy56UYMolcrmDw18YYt2/s7pNM+2Q50tIey5qoVxeUBRoF9XCHRi4KGNkt+9vGwb831V19JvQT/3kFNyl0ArpRxuZ/nE/zRhvdrnfyKpWTQjhAI+xxE13q9c7ZWZQAIBI1wra+VD9Sv7ISFpOJIUZNQTpzAMqXsKT+zOYWpDcWVtqf6VcqQOkpkWCPPt10cE45d3LydamDqJsXIbVgeXzNxbcW4UnztUJyBgM5v3+1aAMO11PO7AvnVuJkpsRqA1deQ62+DzpxsLULgrfrjjCS1bS85KSNziwBYQn7DObuR0w3AKg3qapVlcQgCv5jKuH655Zb6rey+JeKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/QvpsjZYAt751AvKqHSuiw/TEkhnu3KAKDDjZtKv14=;
 b=aHzjvfNabtfImNnxlKqyalSu5Xo6nPCxDdfI/109qAL7dnOz5LCBx0JxwJ+jMWsNymrU9boqIboRsd066FWVxp2t9WY6Ix18noCusZ2ZQnuPsMOSFyAcJiBWvbfksjLKcxrpHOG7bGySwkqQAMrBw82/bWiTXRnjYcyk3+HIVqFa3GVt5TrLO8V1JpUdXnW26PB6tSbjuIEfg3fdMmloSDTuOn38M9C5OfdIL2Wri+NKIgOGV5aMcja6bBPg30eydMu3Oi92Zgd3fwn2scZssrundPah+2F6filLVWiyuz5ZhR00Q0MP7YRjHobkSOPRIzCVBKbTYYW2Ywn8O94z+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/QvpsjZYAt751AvKqHSuiw/TEkhnu3KAKDDjZtKv14=;
 b=lUvP9DILFm48TT5Z0Bo19qNWWlsmip8TQqJfYI6FF3ofqdcJMWhN5W/vl2oFBRCbJyCz4WyeYuyP313G9Mb9nR6ILEaGZXcXHaWK4mHTFUavcXbO1siha2AQC5uwIQb30gsNY0BrD0l8JrziiTVFppBOYptJrYbb5AWAeanL8SE=
Received: from SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 by SJ2PR12MB8845.namprd12.prod.outlook.com (2603:10b6:a03:538::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 08:55:35 +0000
Received: from SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::4463:2ddb:bf44:1af5]) by SN7PR12MB7201.namprd12.prod.outlook.com
 ([fe80::4463:2ddb:bf44:1af5%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:55:35 +0000
From:   "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
Subject: RE: [PATCH v4 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Thread-Topic: [PATCH v4 2/3] dt-bindings: PCI: xilinx-xdma: Add YAML schemas
 for Xilinx XDMA PCIe Root Port Bridge
Thread-Index: AQHZk5tcUi1HuVSwVUWvI9X7loxfOK972n+AgAAU/vA=
Date:   Mon, 5 Jun 2023 08:55:34 +0000
Message-ID: <SN7PR12MB72012A6CF6F4D9D10179D0E48B4DA@SN7PR12MB7201.namprd12.prod.outlook.com>
References: <20230531083825.985584-1-thippeswamy.havalige@amd.com>
 <20230531083825.985584-3-thippeswamy.havalige@amd.com>
 <a2086bb1-160e-1dee-a686-ffdaf3422595@linaro.org>
In-Reply-To: <a2086bb1-160e-1dee-a686-ffdaf3422595@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7201:EE_|SJ2PR12MB8845:EE_
x-ms-office365-filtering-correlation-id: 59d907c5-b34d-4b32-a18c-08db65a2a036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hwpu4HZxvo4it11YP0yelYCqluyrPWXVPrHWADTY2YwwavdRYOks42gSXAdnHDROgBfiLS43t9tXUFyJ3WiXEoIgzgAKzdJi6qvTNCJk6W8lTWbCo8lUEI71Ij3lKL5UnrlvpAEFLpTsfqjXXi6moqbJFQZIQjyKlc2is4lIktMtcdk16RVtbuFnZrp3CcCvjfH69EakJ0FZrIeDJ9qcpzInxXvTB2d9GAb+VB6MNCd0zDGMzYEKcgfDBvFPcXUwFlevq7Ox0S0SSVtxC10Bt/mE/BNgHuqfTe+sO0dnfNtZ5hzXuW17VfiGCp53W/d/vtwArr5L53YsFqrt7PNmL4qnmiB6MZRX0lvFGGukiM8l215eSnc6ip4+Nhoj6vqPVFOSkSzCPIXv+k+7DI9euF4FwIVgsHtVa+10jMXeq9wXKuVaL5fiQ8Pq3HKafSuRILhbj1FWKZH/TvTuN5o8w7nnSISx+9t77vthY1X2MdcxWKVr9bfImwMp9zGJ9feEIVzlol4NaVp62e/sRrA6x1+3nVYTfsg4oXWxcuqAHXaOcaa0wgcLBCCBFt+rZPRnHAlqJSxTY2RMXMolc5QF4CwCW7fYsGaHvQCmWOyL8ZqqzA+TiU9gtOr9ikg6WISn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199021)(26005)(110136005)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(38100700002)(122000001)(83380400001)(478600001)(7696005)(71200400001)(2906002)(9686003)(53546011)(6506007)(41300700001)(38070700005)(316002)(55016003)(33656002)(8676002)(8936002)(186003)(52536014)(5660300002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OElGTlljeURpaVBlaXlVVHdZaStMTjZaWUhKTTdUOEZEeThNR3p0a3pQS0Ns?=
 =?utf-8?B?RjdkMmZuZkhZbkZ2RTNaelVyaHdBWXN0d014eU9rUWN2V2sxbmlDdEhtejVU?=
 =?utf-8?B?ZlFTSjc1RCtEekZWUmlNbG8zOFpOZmZmakc3VVhqLzluTWpDbDNhNmdqUzVs?=
 =?utf-8?B?VEZHQUhlQXBhb1hRV3lnUmp4ZTRjcWtsazNwVU1jZkNWK2hOYWZUSkpSNXZo?=
 =?utf-8?B?M2lTazUvV25MZHJFbHZRUlVIbmEyMjRyVU1IWE4vMjRFQ2tGaVlISnM3NlVy?=
 =?utf-8?B?VmVLbUdOZXRjTWdSNnlPdE4wZWdwMFNudm02UVpYaUlwckRIZk84R3o4bWNJ?=
 =?utf-8?B?K3h5R1hwSjBaanp6cEZacGtvdUY1MFVLQnozSWFReDh1VmYyL0U4R3lZc0hG?=
 =?utf-8?B?R09CV2oyL29rcE9DbjhrK3ZiNTIyMjVmMWs0Zy92R2ZKaWQ3bXEyMVA5MDZB?=
 =?utf-8?B?V2xXSnlqQnRqWElkQmlYR3pVSFpaODhFcUM2UnRGUnIvZWZyNUNhdUdXNFRY?=
 =?utf-8?B?ejk3TzBzK0VEYVdkNmM0TGNhS3dOekV5ZXhxS3NOMC84MnZsMy9QTzZkQWpB?=
 =?utf-8?B?TFFEZW5pMWREVndqZFhLK1QvaTFRcEUwcWhVSjkyZjA5WUt2SnBlTjVqZG1P?=
 =?utf-8?B?WDYvRE1qSWwwY2ZkekNYT2pZYlhFdlZ0VjVweG1JdGtFOENEMmFlUjFOOHpn?=
 =?utf-8?B?RTJPWnVhR0ZHdW5BUnVtZGxkZkw1bm4vd0J6ZWZzVnZRZ3FZZ0pyd1Q5LzVJ?=
 =?utf-8?B?U3JFb09TTzJzZGNOeU5oN1QwNDI5ejhXaUdTbVBZVWE1T0dJQ05KT1FmTUJH?=
 =?utf-8?B?SWIzYVV1dEZQZmphVXluYTdZNmtSQ2RDMytNSC9wQTFHSjBuNTI3TVNBTjlq?=
 =?utf-8?B?M3RJUitRMGhQZ3k5OVhGckdxR0FxdDNZRGgySFJxWDd5R3NqNlViOWZkQnpt?=
 =?utf-8?B?SjNZSkttSHE3KzVTdEMzYnRBUTdTM3VPNmt2S3lvS2huMUNuS0JJK2QzMDRS?=
 =?utf-8?B?SkxmYUZ4NlUvUk83eHJQaTRFc1o5S2RXOXFpRlVuTjB5aDdTVWtZdzlRd0Vj?=
 =?utf-8?B?T05ibzJmTitocUl6eHcva3hHSnhtN0ZNbVYzT2tvS096THNYS2xaM3JONTRo?=
 =?utf-8?B?VjRxNkFEMGt3bDAzSXJ4UXcxdWVOaVhDT09rUVppUWVoU0c3MTFGblp0Um1S?=
 =?utf-8?B?aXZPa0xVcUNLbUowMFJKc0xkRHBEQUtkbnlSNHkvOVR6WllWUnpFTGJvZE40?=
 =?utf-8?B?WGVBdVNyVC9PdkU0Q2ZDdFB5a3dWZWpSTkdXN2VkTlg0UXRRS0l2WmNTYklK?=
 =?utf-8?B?anlLUWxwU3FJekxJWjNjcExza2liRHBHUm5XYUM3eHpIalpncnlvWWc1alNG?=
 =?utf-8?B?eHV3bGF3cVdDNmlJWkFRL1dpZngwdzU5QlZ6QTdubEtMQWFrQXpJdmZKNVJv?=
 =?utf-8?B?Rk1wMi9UdEpTcVFtKzlPbjUxRmd3MmZqaGIrRW1uaXhRQVkvakkrR1YyNjls?=
 =?utf-8?B?SU96VWtpWklMMUxRWjlvNVdNNnVFcEhrZ1cxNzdGL1pKN3o0bVNYRk9tN211?=
 =?utf-8?B?N2pvRGV0ckxlL3pEbTFaTllyRnJJY0Fodm5ldDVFNlZqRndmUnBWOVNESlU5?=
 =?utf-8?B?M1lzSWlnc2FJRDZtSVVsaklGR0VZMzVrWVRNM2FmaFhVQ2dTeGtIZ1FsUE02?=
 =?utf-8?B?M3QzNUxlMDUrUFNBaXpsRGFNbDM2U29ZanZRQ3ZvTG1Fd0g3YngzMEQ0U1pT?=
 =?utf-8?B?NXh3ZmY2ckI4L05PUUluSFBuN1RxVFZTUmZOT1pla053b0lQcHZxblhzb0Q2?=
 =?utf-8?B?V2licC9mK1ZBdGgwTDVIODExbmFiUUJ3aXRZbFNla2l4ZXovMmRGdjhXVVIx?=
 =?utf-8?B?dEkrTnZQN3R2RzZRaUFvbGdRQk5wSnpjb2puMEUyWXBNNlBYQ0tUVmZjeWZR?=
 =?utf-8?B?Yi9uTkI2alE0UlpiQ1hEblF4ZmtpZGxxM2JUUjlTdkNZZzBVN21KZDFnblUy?=
 =?utf-8?B?TWJDT24xZUVEdEw2bFppMzFNenFWbFhyMnZiY1ZFNGNFN0JoK3haTU9RQk93?=
 =?utf-8?B?K1NQQlp3TGszVUNnRU5XZHRob1czYmE1V1ZsRkVFaDBvbjIrajZPNU95andz?=
 =?utf-8?Q?Xa8A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d907c5-b34d-4b32-a18c-08db65a2a036
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 08:55:34.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1OlLzY56knEqw+6703ijc1Jylwt8x/C4PT53p74JDwu+cDDQRiL0ItzNOAW9gdgSSKEYZPhnHArjLCbowt8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8845
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpSZWdhcmRzLA0KVGhpcHBlc3dhbXkgSA0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5r
b3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDUsIDIwMjMgMTowOSBQ
TQ0KPiBUbzogSGF2YWxpZ2UsIFRoaXBwZXN3YW15IDx0aGlwcGVzd2FteS5oYXZhbGlnZUBhbWQu
Y29tPjsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBwY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmcNCj4gQ2M6IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gR29nYWRhLCBCaGFyYXQg
S3VtYXIgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT47IFNpbWVrLCBNaWNoYWwNCj4gPG1p
Y2hhbC5zaW1la0BhbWQuY29tPjsgWWVsZXN3YXJhcHUsIE5hZ2FyYWRoZXNoDQo+IDxuYWdhcmFk
aGVzaC55ZWxlc3dhcmFwdUBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvM10g
ZHQtYmluZGluZ3M6IFBDSTogeGlsaW54LXhkbWE6IEFkZCBZQU1MIHNjaGVtYXMNCj4gZm9yIFhp
bGlueCBYRE1BIFBDSWUgUm9vdCBQb3J0IEJyaWRnZQ0KPiANCj4gT24gMzEvMDUvMjAyMyAxMDoz
OCwgVGhpcHBlc3dhbXkgSGF2YWxpZ2Ugd3JvdGU6DQo+ID4gQWRkIFlBTUwgZHRzY2hlbWFzIG9m
IFhpbGlueCBYRE1BIFNvZnQgSVAgUENJZSBSb290IFBvcnQgQnJpZGdlIGR0DQo+ID4gYmluZGlu
Zy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRoaXBwZXN3YW15IEhhdmFsaWdlIDx0aGlwcGVz
d2FteS5oYXZhbGlnZUBhbWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJoYXJhdCBLdW1hciBH
b2dhZGEgPGJoYXJhdC5rdW1hci5nb2dhZGFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiBjaGFuZ2Ug
aW4gdjQ6DQo+IA0KPiANCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsN
Cj4gPiArZXhhbXBsZXM6DQo+ID4gKw0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4gPiArICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArDQo+ID4g
KyAgICBzb2Mgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAg
ICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgIHBjaWVAYTAwMDAwMDAgew0KPiA+
ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gInhsbngseGRtYS1ob3N0LTMuMDAiOw0KPiA+ICsg
ICAgICAgICAgICByZWcgPSA8MHgwIDB4YTAwMDAwMDAgMHgwIDB4MTAwMDAwMDA+Ow0KPiA+ICsg
ICAgICAgICAgICByYW5nZXMgPSA8MHgyMDAwMDAwIDB4MCAweEIwMDAwMDAwIDB4MCAweEIwMDAw
MDAwIDB4MA0KPiA+ICsgMHgxMDAwMDAwPiwNCj4gDQo+IElmIHRoZXJlIGlzIGdvaW5nIHRvIGJl
IHJlc2VuZCwgdXNlIGxvd2VyLWNhc2UgaGV4IGV2ZXJ5d2hlcmUuDQo+IA0KPiBPdGhlcndpc2Us
IGl0J3MgZmluZToNCi1BZ3JlZWQsIGxsIHVwZGF0ZSB0aGlzIGluIG5leHQgcGF0Y2guDQo+IA0K
PiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBs
aW5hcm8ub3JnPg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
