Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1300E639FCA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Nov 2022 03:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiK1CxK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Nov 2022 21:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK1CxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Nov 2022 21:53:01 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2128.outbound.protection.outlook.com [40.107.114.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C85F59;
        Sun, 27 Nov 2022 18:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQ0/51UaQY63K6myM1AYwydJ6xB/OsJnOKz4UdyLs51dA2uEnWC9yMQyEhDY/X86TZaMRYvbao64bqynP0ZjfTCj8Rehx/iy+RO8BunP02GW7+2utYQItUhVrB1D0dtaE7ZhuUlCPH97qmvet1CjvVQb05ImQmW1ywlHKtrapwYw6+kwRG8x30+HYGy1W+NCC2fgixXKPuKRce05hyitkteURy3kJQlL5NJ4KeqApS1QNZpzfRzXS35byFalGZ8P567SbFA8NPi1VXOSDN1VG3ojh22c4ur+r7aWA8/xwZxHKnBai5/XETnZdLaIGpNg888Np9Dlcn+oh9nnSbhrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu5dut4Q7fH+PgGrTTvexzHHubcMK01lill5fyrbfIU=;
 b=WFhjWCJ6IaW1i6+MCkLqQrJPy+QQ7SKpaPEkbPF59atgAxU0l6t/t5yHCKFYWW4iJqtBH11h1bq/0hSwySM52HgGLjeVrhqmtIAvqEsCAbWmypXQY0GoKQIaL7uYF2TDZvtrOu456WJvx/VwHpLSCsiCKuLICla/2DRAoRSukskIJtdQHFDw8moZqrk5cYWpcxnSKlC780VFxxZ2TqNu7xZhOCz++uZNIYCYhnjTDEMvktb2w0TIOeTDZ2BvB9STqyC5Ur/EeYiZWOAYuXwx6L8mI5uOXLMSIwcHniMSdPkcM3epM5E7V1A+A3uorBqALWEPWFhmmdWOZThwg0Brvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu5dut4Q7fH+PgGrTTvexzHHubcMK01lill5fyrbfIU=;
 b=lCIMJJPAVTS4iSkhdJx9x0M7wjNvK8NXO1s9BE+tHbckzZRaIc62cGzjg5WcJB/4p/2Q1MksP/HVsiYl8jcEVhJR1TsuB3bZGeNfcmc88e69wXAFtZouhX4atsg0zKMU073UcRHHlJpg7SRU1GkteXFfUddp64RJMNplcCeXhlw=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB8384.jpnprd01.prod.outlook.com
 (2603:1096:604:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 02:52:57 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::cd89:4a4b:161e:b78d%9]) with mapi id 15.20.5857.022; Mon, 28 Nov 2022
 02:52:56 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "Sergey.Semin@baikalelectronics.ru" 
        <Sergey.Semin@baikalelectronics.ru>
Subject: RE: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Topic: [PATCH v7 5/9] PCI: dwc: Avoid reading a register to detect
 whether eDMA exists
Thread-Index: AQHY/ab1Tv+LcLa0Z0uhVdCr0bfU4q5K+PQAgAiDNgCAACHrwA==
Date:   Mon, 28 Nov 2022 02:52:56 +0000
Message-ID: <TYBPR01MB5341932B42719E026AA16D40D8139@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20221121124400.1282768-1-yoshihiro.shimoda.uh@renesas.com>
 <20221121124400.1282768-6-yoshihiro.shimoda.uh@renesas.com>
 <20221122135550.GD157542@thinkpad>
 <20221127235532.u7q7oou36wymkpyf@mobilestation>
In-Reply-To: <20221127235532.u7q7oou36wymkpyf@mobilestation>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB8384:EE_
x-ms-office365-filtering-correlation-id: c072c71f-aa60-41cd-bf0a-08dad0eba74c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r8HeUBynZaSDDEXUrVJHP1ph0F9/IWIzgzddMyh3SePfBKsBiCWKhZd/2H9TTuPEacjQK19SNFEx94/MaAPZ7ByafeDrxcfM5+JUIvSBExcRsJXDMwGRkS8/etXdGsmjXF5+GMrV8UqUfveFwN7L7QF7AWPqONxzOdi/oiTcC6DyTnLkXo/Sb2n9Y7fwmzrWchxaBl6ABKDNpo+wEqRW5Us5g8xUKvE1uv56ZuauWEnzS+OdRBL0byxGs9jfmh5O8WHsdopYB37ApRVjJf/1SAa4EWrk5P2Dq4GiXAm11BEs422dAmoQ6+lB8M9Uift4nIE7Ud80VMFszo/B9ckP5II3T5qoRhHSZljb49tqmt3Fc6kkxANph9wIBjo0KQJqSXH/t2o29DtuuXZhdpg5s6aJPqTNZq4v9w4z9tzzrlS1OUIcRuliI578DSxp1PPu7UjGrccxRQuCn8+0Eedwl3CKfwZMiMyZQiGd5ypmB2dFqCNz0ZVfY21mQEQEvRp58sR/h4qfxBORc/iSR9BLnLZa0USkFwZeB+YqnOfrzL1ZHX+5fAGhZQaAHhpKi07nUnvXjCLjiEnJuWEkZia/Obnt/q0LiLciyZKJzWy8OUyvQQrOhhRlVOsyVirJ7x8FRpIsS+EAw6xMMzsMAuOSC+H27Sryh5G763tKbahAu7QW/quZMArnUglcXZZ+HTF5ZO0bfvUK/TyKctO6JOILZdjM2bV9BktjGbaxB9yoZwg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199015)(9686003)(55016003)(38070700005)(86362001)(33656002)(966005)(54906003)(110136005)(71200400001)(6506007)(7696005)(478600001)(7416002)(5660300002)(52536014)(8936002)(64756008)(41300700001)(2906002)(4326008)(316002)(66446008)(66556008)(76116006)(8676002)(66476007)(66946007)(38100700002)(122000001)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REpWR1F0dG1TOHdVNEp4WmtVWEJwYXhQNUpVSDhtMkZ0T2ZyN1J6OTBQYTRM?=
 =?utf-8?B?YlhOWXdxb1BrM21sbEhlRzMwc3V0RkNTNG5zT0hXYm1uSUlxckJIaE1QSnZx?=
 =?utf-8?B?L2RzSDhnT2NZZjI0QmF6ODFhT05yV3g4WVAxQmEzTmZha2IrNnhXVDZsUW1l?=
 =?utf-8?B?ZXYzdlRSbHpIa0VQN3MvVVNCd3FzYytOVW91eVJQK20zNEkzZXZ2SzIwWlpD?=
 =?utf-8?B?N2Y4Zno1Q1cxdllIZm1HNXQwM1RkcWZhK1oxelNLZ3UrbGlxZUR4U0dKNkNL?=
 =?utf-8?B?d1ZkTTI3ZzJ5RHJRclJrY1lpS0JXZVVWQ1NoQkQvckVIdmtURDBUY0pxa1FB?=
 =?utf-8?B?bnZXY1lYTDNLQUVHWXE3Y0hzdm5xaWNENEJ4K25pT0Y5Wkd3K3ZOMzZ0K3Qw?=
 =?utf-8?B?VUhFNkNDbkdjUmZHZHpQR3pGVldUK0IySFpKcVRIOHg4MEM4QTBJSkZwYkth?=
 =?utf-8?B?RkQ4OWxRVCtIZWtQMTdCK0tNTlNQb001NE1uSGcxbkl2QWVUWjFEUEZhVk1B?=
 =?utf-8?B?Y3RuVXp1WkxiV0k1R3FMK2xwRW9oSWEzQ1N1ZFUxcHhBM1VsdnNySkNReFRV?=
 =?utf-8?B?NkJ5YlY5SFRFNEtIQ2tOdm5NSjNvTll5cXZmSVMwMjVjMkxzMS9VV204b3Q4?=
 =?utf-8?B?SHQ4aGt5QVllcUFzM3ZDR1RCVW13OEZFdnFNdHVHNHVBTmNtTVFqdDN5M1JI?=
 =?utf-8?B?cVl0VXdWbUFjcmdtTUtWaFNKU0pGaU5RL28yeWlVcURXUXo3N2Nobzh4TEhr?=
 =?utf-8?B?UTVxSHd1RGllbnFUT0swcWt5QW11WjVMcVRoRFQvSjJMcHJhYURhRzgxazlt?=
 =?utf-8?B?K3NtWGh3VzZRdHE3MkI4M0N5NzJpbk5TdnJ2eGRnRVhNaFpJQXppN2xRekNn?=
 =?utf-8?B?dExYOWtzRVY3SUhOajg2NlJ2MVR5MTFjb2swSmd2TmZIOHl4aG8zN1pzN2Mv?=
 =?utf-8?B?N1J6R0UyYnJRK3lNMS9KWnBBTGovWk9hZ0VKMXhYVHE2SjBjNHc0Qy80c3Rt?=
 =?utf-8?B?Vk5YdlA0QlN4NjNnRkcyZG5kV1J6MDNoaC9hc0lwSWI0UHZLNVYwNHJGSHhX?=
 =?utf-8?B?Q0o2TGlLaTJsc0tGSWc5RTRIMlhTVWJyREdKMzBMZUNDNGxBd1V5QnJITUxW?=
 =?utf-8?B?R2JPVUZLU2ZtWUpZRDFaaEdhSnVKbHJ1ci9TVVdPOVpNOVNJeDZlREtGY0c2?=
 =?utf-8?B?TXlteWEzSFZ2Wk9WbmhBMndPZ3RaTTN0U2JxRXM5U2lnNGFYQTdMeHVXTW0w?=
 =?utf-8?B?d2pPQ01mVTNlZWFNK1B4U1pXZU9RUDM3NThHcWRvcU0vN3NXbVFwS0NMeFhj?=
 =?utf-8?B?SG1JL0lLcW5YNGJOTGVqY2tUS2VkTGQ2NlVEWEIyMWw5aWpQeHlnRnZabkJ0?=
 =?utf-8?B?QU1EN2IxVXRmRUM2T1lkVEhPcVBOZlRCS1QraUtwT0VxTTFCUnlwYi8vWEtQ?=
 =?utf-8?B?b21rMXNQdlZBeVQyL3QrSTA4bjVqblc2YTFBMmxsMlpEVVM0RGhUbDVoM0lV?=
 =?utf-8?B?cmZTbndHekJWUlVUaEJuTkg5Nnk2MmY4VE5xamdPbmREVUNXeWlLNDNRUkdB?=
 =?utf-8?B?cGhQNWxBSmltS1BVWjR2NWQvN3Y3U2gzYm9FKzJKRHBJYXcwTWVKZDdhUDFv?=
 =?utf-8?B?VlVEaVZZM21SY3hBbVU5US9UbDhUblVJOHNKTVZqbGRIQUhBUjRQUC9QNTJN?=
 =?utf-8?B?Um9pcWczR2I0SVJUNm5qN3VuM2pnU2hmZS8yUVkvMzBUTjFzVnpsemw2bkNw?=
 =?utf-8?B?RGdzenEvS3laWTU2VDNFSER1ZE10U1NBMnlicStXYXdYd2hBT1N5eGhuRURt?=
 =?utf-8?B?eXRob2RMckNERDZsRHhPR0x2cWlKbGpiMmQ2c1o0M3NReWszYkViR0I1Tlky?=
 =?utf-8?B?Y3pSQ2p6U2VSbVBhN3h6Rlg3MDVGT1dUaU0xSEJqY0JLc1d3emxQQko3aE9H?=
 =?utf-8?B?cGNTTXVNK1dXa2xDa1ZnQzhNNXAyL3VYWEJES2ZRQ2lGdXlRSmZQLzUzWTZT?=
 =?utf-8?B?Ry9rdkFrZVVjNXljMFNsL0RyZklDOGR3UFNVa3ZpRENwdTlBbHlTd1hXTGxt?=
 =?utf-8?B?U3NKMXkrNkN5Sk0rU1FHRjFOMHVlL1NsTlF4eWIzRkwyU1FNMXFSNmRxNFkx?=
 =?utf-8?B?cjQvOXFtUU1pQ0VYMStQZ09QaFBiVHA5eGdIZHZmYnJGaWJ0Z2JsR1pFYjQ2?=
 =?utf-8?B?cDhzVlVaUGZxaXE2dS8wWUFCZUMwd3JQRUlsSTJmZ3F0TTN1Wld3cGlrRk9o?=
 =?utf-8?B?VENXaG1iVUZDdFlrWHFWbGFqaGxnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c072c71f-aa60-41cd-bf0a-08dad0eba74c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2022 02:52:56.8438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KChBIa01MgAa3mgstQRFojPKieGuEN0/GswPoHJme1rLqtVUmrymOhpi6NU12fdL6HCgggQlDqSd1wlqaVih9qAUbR36ccxlGH/QjmM1eO5sv3jbfM/RmjoP9lHZ4Amg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2VyZ2UsDQoNCj4gRnJvbTogU2VyZ2UgU2VtaW4sIFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIg
MjgsIDIwMjIgODo1NiBBTQ0KPiANCj4gT24gVHVlLCBOb3YgMjIsIDIwMjIgYXQgMDc6MjU6NTBQ
TSArMDUzMCwgTWFuaXZhbm5hbiBTYWRoYXNpdmFtIHdyb3RlOg0KPiA+ICsgU2VyZ2UgKHdobyBh
dXRob3JlZCBFRE1BIHN1cHBvcnQpDQo+IA0KPiBUaGFua3MgQE1hbmkuIEl0J3Mgc3RyYW5nZSB0
byBzZWUgYSBmaXggZm9yIGEgcGF0Y2ggd2hpY2ggaGFzbid0IGJlZW4gZXZlbg0KPiBtZXJnZWQg
aW4geWV0IGFuZCBtaXNzIHRoZSBwYXRjaCBhdXRob3IgaW4gdGhlIENjIGxpc3QuKQ0KPiANCj4g
QFlvc2hpaGlybywgb24gdGhlIG5leHQgcGF0Y2hzZXQgcmV2aXNpb25zIHBsZWFzZSBkb24ndCBm
b3JnZXQgdG8gYWRkDQo+IG15IGVtYWlsIGFkZHJlc3MgdG8gdGhlIGNvcHkgbGlzdC4NCg0KU3Vy
ZSEgSSdsbCBhZGQgeW91ciBlbWFpbCBhZGRyZXNzIG9uIHRoZSBuZXh0IHBhdGNoc2V0IHJldmlz
aW9ucy4NCg0KPiA+IFRoYW5rcywNCj4gPiBNYW5pDQo+ID4NCj4gPiBPbiBNb24sIE5vdiAyMSwg
MjAyMiBhdCAwOTo0Mzo1NlBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiA+
IFNpbmNlIHJlYWRpbmcgdmFsdWUgb2YgUENJRV9ETUFfVklFV1BPUlRfQkFTRSArIFBDSUVfRE1B
X0NUUkwgd2FzDQo+ID4gPiAweDAwMDAwMDAwIG9uIG9uZSBvZiBTb0NzIChSLUNhciBTNC04KSwg
aXQgY2Fubm90IGZpbmQgdGhlIGVETUEuDQo+ID4gPiBTbywgZGlyZWN0bHkgcmVhZCB0aGUgZURN
QSByZWdpc3RlciBpZiBlZG1hLnJlZ19iYXNlIGlzIG5vdCB6ZXJvLg0KPiA+ID4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5l
c2FzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jIHwgNCArKy0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+ID4gaW5kZXggNjM3ZDAxODA3YzY3Li4y
Y2M4NTg0ZGE2ZjQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiA+IEBAIC04MzYsOCArODM2LDcgQEAgc3RhdGljIGlu
dCBkd19wY2llX2VkbWFfZmluZF9jaGlwKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gPiAgew0K
PiA+ID4gIAl1MzIgdmFsOw0KPiA+ID4NCj4gDQo+ID4gPiAtCXZhbCA9IGR3X3BjaWVfcmVhZGxf
ZGJpKHBjaSwgUENJRV9ETUFfVklFV1BPUlRfQkFTRSArIFBDSUVfRE1BX0NUUkwpOw0KPiA+ID4g
LQlpZiAodmFsID09IDB4RkZGRkZGRkYgJiYgcGNpLT5lZG1hLnJlZ19iYXNlKSB7DQo+ID4gPiAr
CWlmIChwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCj4gPiA+ICAJCXBjaS0+ZWRtYS5tZiA9IEVETUFf
TUZfRURNQV9VTlJPTEw7DQo+ID4gPg0KPiA+ID4gIAkJdmFsID0gZHdfcGNpZV9yZWFkbF9kbWEo
cGNpLCBQQ0lFX0RNQV9DVFJMKTsNCj4gPiA+IEBAIC04NDUsNiArODQ0LDcgQEAgc3RhdGljIGlu
dCBkd19wY2llX2VkbWFfZmluZF9jaGlwKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gPiAgCQlw
Y2ktPmVkbWEubWYgPSBFRE1BX01GX0VETUFfTEVHQUNZOw0KPiA+ID4NCj4gPiA+ICAJCXBjaS0+
ZWRtYS5yZWdfYmFzZSA9IHBjaS0+ZGJpX2Jhc2UgKyBQQ0lFX0RNQV9WSUVXUE9SVF9CQVNFOw0K
PiA+ID4gKwkJdmFsID0gZHdfcGNpZV9yZWFkbF9kYmkocGNpLCBQQ0lFX0RNQV9WSUVXUE9SVF9C
QVNFICsgUENJRV9ETUFfQ1RSTCk7DQo+IA0KPiBMb29rIHdoYXQgeW91IHN1Z2dlc3QgaGVyZToN
Cj4gPCB1MzIgdmFsOw0KPiA8IC4uLg0KPiA8IGlmIChwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCj4g
PCAJLi4uDQo+IDwgfSBlbHNlIGlmICh2YWwgIT0gMHhGRkZGRkZGRikgew0KPiA8IAkuLi4NCj4g
PCB9IGVsc2Ugew0KPiA8IC4uLg0KPiANCj4gSXQgd291bGQgYmUgc3RyYW5nZSBpZiB5b3VyIGNv
bXBpbGVyIGRpZG4ndCB3YXJuIGFib3V0ICd2YWwnIGJlaW5nIHVzZWQNCj4gdW5pbml0aWFsaXpl
ZCBoZXJlLCB3aGljaCBpbiBpdHMgdHVybiB3b3VsZCBpbnRyb2R1Y2UgYSByZWdyZXNzaW9uIGZv
cg0KPiB0aGUgcGxhdGZvcm1zIHdpdGggdGhlIGluZGlyZWN0bHkgYWNjZXNzaWJsZSBlRE1BIHJl
Z2lzdGVycy4NCg0KWW91J3JlIGNvcnJlY3QuIEl0J3Mgc3RyYW5nZS4gSSBkb24ndCBrbm93IHdo
eSBteSB1c2luZyBjb21waWxlciBbMV0gZGlkbid0DQp3YXJuIGFib3V0IHRoZSAndmFsJyB0aG91
Z2guLi4NCg0KWzFdDQpodHRwczovL21pcnJvcnMuZWRnZS5rZXJuZWwub3JnL3B1Yi90b29scy9j
cm9zc3Rvb2wvZmlsZXMvYmluL3g4Nl82NC8xMS4xLjAveDg2XzY0LWdjYy0xMS4xLjAtbm9saWJj
LWFhcmNoNjQtbGludXgudGFyLnh6DQoNCj4gQW55d2F5IHlvdSBjYW4ndCBqdXN0IGRyb3Agc29t
ZXRoaW5nIHdoYXQgZGlkbid0IHdvcmsgZm9yIHlvdQ0KPiBoYXJkd2FyZS4gVGhlIG1ldGhvZCB5
b3Ugc3VnZ2VzdCB0byBmaXggaGVyZSB3b3JrcyBmaW5lIGZvciBtdWx0aXBsZQ0KPiBEVyBQQ0ll
IElQLWNvcmVzLiBKdWRnaW5nIGJ5IHRoZSBIVyBtYW51YWxzIGl0IHNob3VsZCB3b3JrIGF0IGxl
YXN0IHVwDQo+IHRvIHY1LjMwYS4gQXJlIHlvdSBzdXJlIHRoYXQgeW91ciBjb250cm9sbGVyIGlz
IG9mIHY1LjIwYT8gSSBzZWUgeW91DQo+IG92ZXJ3cml0ZSB0aGUgSVAtY29yZSB2ZXJzaW9uIGZv
ciB0aGUgUENJZSBob3N0IGRyaXZlciBvbmx5LiBXaHkgaXMNCj4gdGhhdCBuZWNlc3Nhcnk/IERv
ZXMgdGhlIHZlcnNpb24gYXV0by1kZXRlY3Rpb24gcHJvY2VkdXJlIHdvcmsNCj4gaW5jb3JyZWN0
bHkgZm9yIHlvdT8NCg0KVGhhbmsgeW91IGZvciBwb2ludGVkIGl0IG91dCEgSSByZWFsaXplZCB0
aGF0IG92ZXJ3cml0aW5nIHRoZSBJUC1jb3JlDQpWZXJzaW9uIHdhcyBub3QgbmVlZGVkLiBTbywg
SSdsbCBkcm9wIGl0IG9uIHY4Lg0KLS0tDQojZGVmaW5lIERXQ19WRVJTSU9OICAgICAgICAgICAg
IDB4NTIwYQ0KLi4uDQpzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXJfZ2VuNF9wY2llX2Rldm1f
YWxsb2Moc3RydWN0IGRldmljZSAqZGV2KQ0Kew0KLi4uDQoJcmNhci0+ZHcudmVyc2lvbiA9IERX
Q19WRVJTSU9OOw0KLS0tDQoNCj4gV2hhdCBkb2VzIHRoZSBkYmkrMHg4ZjggQ1NSIGNvbnRhaW4g
aW4gdGhlIGhvc3QNCj4gYW5kIEVQIHJlZ2lzdGVycyBzcGFjZT8gU2ltaWxhcmx5IGNvdWxkIHlv
dSBhbHNvIHByb3ZpZGUgYSBjb250ZW50IG9mDQo+IHRoZSArMHg5NzggcmVnaXN0ZXI/DQoNClRo
ZSBkYmkrMHg4ZjggYW5kIHRoZSArMHg5NzggcmVnaXN0ZXJzJyB2YWx1ZXMgYXJlIDB4MDAwMDAw
MDAuDQotLS0tLS0tLS0tLS0tLS0gKHNvcnJ5LCByZXBsYWNlIHRhYnMgd2l0aCBzcGFjZXMuLi4p
LS0tLS0tLS0tLS0tLS0tDQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUuYw0KKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLmMNCkBAIC04NDMsNiArODQzLDEwIEBAIHN0YXRpYyBpbnQgZHdfcGNpZV9lZG1hX2ZpbmRf
Y2hpcChzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KIHsNCiAgICAgICAgdTMyIHZhbDsNCg0KKyAgICAg
ICBkZXZfaW5mbyhwY2ktPmRldiwgIiVzOiArMHg4ZjggPSAlMDh4LCArMHg5NzggPSAlMDh4XG4i
LCBfX2Z1bmNfXywNCisgICAgICAgICAgICAgICBkd19wY2llX3JlYWRsX2RtYShwY2ksIDB4OGY4
KSwNCisgICAgICAgICAgICAgICBkd19wY2llX3JlYWRsX2RtYShwY2ksIDB4OTc4KSk7DQorDQog
ICAgICAgIGlmIChwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCiAgICAgICAgICAgICAgICBwY2ktPmVk
bWEubWYgPSBFRE1BX01GX0VETUFfVU5ST0xMOw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQotLS0tLSBPdXRwdXQg
LS0tLS0NCiMgZG1lc2cgfCBncmVwIGVkbWENClsgICAgMS4xMDg3MDldIHBjaWUtcmNhci1nZW40
IGU2NWQwMDAwLnBjaWU6IGR3X3BjaWVfZWRtYV9maW5kX2NoaXA6ICsweDhmOCA9IDAwMDAwMDAw
LCArMHg5NzggPSAwMDAwMDAwMA0KLS0tLS0tLS0tLS0tLS0tLS0tDQoNClNvLCBzaG91bGQgSSBj
aGFuZ2UgdGhlIGNvbmRpdGlvbiBsaWtlIGJlbG93Pw0KDQotLS0NCi0JaWYgKHZhbCA9PSAweEZG
RkZGRkZGICYmIHBjaS0+ZWRtYS5yZWdfYmFzZSkgew0KKwlpZiAoKHZhbCA9PSAweEZGRkZGRkZG
IHx8IHZhbCA9PSAweDAwMDAwMDAwKSAmJiBwY2ktPmVkbWEucmVnX2Jhc2UpIHsNCi4uLg0KLQl9
IGVsc2UgaWYgKHZhbCAhPSAweEZGRkZGRkZGKSB7DQotCX0gZWxzZSBpZiAoISh2YWwgPT0gMHhG
RkZGRkZGRiB8fCB2YWwgPT0gMHgwMDAwMDAwMCkpIHsNCi0tLQ0KDQpCZXN0IHJlZ2FyZHMsDQpZ
b3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC1TZXJnZXkNCj4gDQo+ID4gPiAgCX0gZWxzZSB7DQo+ID4g
PiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiA+ICAJfQ0KPiA+ID4gLS0NCj4gPiA+IDIuMjUuMQ0K
PiA+ID4NCj4gPg0KPiA+IC0tDQo+ID4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCu
pOCuvuCumuCuv+CuteCuruCvjQ0K
