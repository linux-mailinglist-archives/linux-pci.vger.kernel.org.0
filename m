Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39756EC4D1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 07:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjDXF1V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 01:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDXF1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 01:27:12 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2090.outbound.protection.outlook.com [40.107.114.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB7C26AD;
        Sun, 23 Apr 2023 22:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qkv3BAf6I4k5i0EPs1a+Nmd56LhnHNiS5ZJ3xbLO9Or1q43b53QYt+C0IPFMEYDrGtrF5dauVzAQgvTQJzy90P8yxR0azCXGOJW8SMhdxz8945lmyjHTqg/IA4WIvrUQp09lj+y+/LzX+0j1pa3YOuA/T9iEYEUD3wOPuQO/bC216u8PBXgB/Y8wP79d1L2C4IZJwSKbnb4CxhRorSfV46qpbC7liw2PsiQhOPO74ZA95EJY7SEFvtTHio2d05MUACMJL2Q8RUfuP206uuayND/zJzvdvKCyKKgcA9U55dIfuSmJgo0+VNq1rWeR+CqimNq7qtXjb5VYMt8I3DkIFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FrpHCgzhl039MqJkyREuKe+YczaQxH9bAdZBmUdDJlg=;
 b=LdRwV0n4sVBL6R5TlU2wJkoMO2q3NBDemp4YOLYTiLEBbfyN9Drr1w4LLKT4xUGNC0Us4cUbza1Koj5r2k1ktmEHYIZS4ooBpVb50KN6azrlg56iI+khMKCfNUMOVr68zDN7ONTEFQuekiskiZSOrJvOIOqjim31Jg3tWRH0vtne1M5vnsncCkCsi3zGdGKXsW/aM707I/6YfgULP4Dq93KgxYZy6f8dqC1D/NKYRnoNaquEk0+wIddxGo72xR+QUYr3FaFfpm3W7v7r983Le/FUFiVXmG45bEvmwdmYsypuWWrqHkILnL73MhGnWkZPyp4HjzrlgjbersAMKKOckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrpHCgzhl039MqJkyREuKe+YczaQxH9bAdZBmUdDJlg=;
 b=eG4ym+BnBdalVxWm1Y/ys3Jqzm4O/LUiQmJjlufW5GQa/Q1AO4nD4dyxwlXejCMPQoO1Zv8t72a417FMYTT9o1hNPG8/PrWt/n6OWEDYCm61ypo0ub/yBeEfF40TzNy+sFTr51o1SZAigAiiMpc//x++W/gxqjBCxTiqrKWKD0c=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OS3PR01MB9962.jpnprd01.prod.outlook.com
 (2603:1096:604:1e1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 05:27:07 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 05:27:07 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
CC:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@kernel.org" <kishon@kernel.org>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v13 11/22] PCI: dwc: Add dw_pcie_link_set_max_width()
Thread-Topic: [PATCH v13 11/22] PCI: dwc: Add dw_pcie_link_set_max_width()
Thread-Index: AQHZcfCxtFGU1sf/AkSDIX0IItRMi683PYCAgAK5GbA=
Date:   Mon, 24 Apr 2023 05:27:07 +0000
Message-ID: <TYBPR01MB5341BB39FE25D4C93A408469D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-12-yoshihiro.shimoda.uh@renesas.com>
 <20230422115053.GH4769@thinkpad>
In-Reply-To: <20230422115053.GH4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OS3PR01MB9962:EE_
x-ms-office365-filtering-correlation-id: d34de9e3-9fd1-4e41-625b-08db44848baa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IT11g1HP4ZINU1flvjSKqRx7tU+O3xEjmW4rQpzaot09xeBmBh7TnQq/mcMyI7KQt1EQdsfGWD6ECGdae8IeBKNtd/VwhYmVRIGiW4e1gVzp2WjVF7VJ5I01HgwhsqCkvGojMr1SD4fwgScQS/dbjc8WKf2jjuWn2NQGM3k5DFKYdv7RF7uJhOL7Ola3XmOLPyGkrDWvLE5WJ0Uk+tK1UYVfA+G9oDFbdTe5n4M/lOq5oc/HZ50xWqMqgc69OUEir4/JIpgqAxfNI1lF0O+e1wPogrMDJka4bea4OaJMSLJK2m+gGqqtDUcrl8/K9jHcRPFwvDs2lM14BG6IRlRI9tLnpX9sy13Xg9WlTqPkE1sC8KD6+poJlXTMgVNQSSJYOy0IxUl4Ot7dg0rs0zT0ZfIBoSlLJc9oy1dI8c+a8Ev22iP3Qdjs6+046fOR3V25wk340T758c7eXPe/wl9MLsMc0c7CFuB735vD3PeniYur3PgjcDwVdvbAUWVTT4li3A0k4MXJizDN6ahS3dmgZWe1JM14qownTgyOsZytngULS1zZCXvJbrcQ2PEfzswikdrxjRwrOG9quMxHfiYOPBBtGoDsQMKThZytHvyGsEkUeKDG1raGW2eH7TCjzjrS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199021)(2906002)(7696005)(71200400001)(55016003)(9686003)(6506007)(186003)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(8676002)(8936002)(316002)(41300700001)(6916009)(4326008)(478600001)(5660300002)(52536014)(7416002)(54906003)(38070700005)(38100700002)(122000001)(86362001)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21QcnNodUN3SHNmbDI3Z3BDQ2lveko2SzZYUnk1TzJlcTIxVGRzcnVOM2Iw?=
 =?utf-8?B?eTJ4endhaFNKemhqYmNxVEplK3kyWDV4dEgxSktSMTQxbFNlZkhHZWh2MWk1?=
 =?utf-8?B?U3lWS3V4K0FNU2V2d2ZNQjJ4M2R0UllPekoyWGIwMU0yU01aZndROHc4dzMr?=
 =?utf-8?B?WThPdTQvNy9CVHlybmxESU5iaE9YYjFEdmV4d3oxRVZCaWwvalVOVFJzV2dk?=
 =?utf-8?B?NFJGTjE4ZTIwdnNrc1NhdDhwckIvWmJETWlvV1RObnhBZmtJemdRQmluc0lh?=
 =?utf-8?B?Q2pjdDU0M0xGcXhBU2ROY1ZpNkY1NFkwZXZabTlYWFF2cU5FcTQ4ZFJ0bHVK?=
 =?utf-8?B?OTc2QktJMUE5TEMyM1pTakFXUFdkc21sMmJmVjdRUEZJQWlTSlpqVm1FMExi?=
 =?utf-8?B?OVQ2ZlFVeDR2RitMWlpEdFRNa2s2VkNuaE5kY2gvTDRjV2U0TUlsVC8rRmRk?=
 =?utf-8?B?OWxGMExBWUc5b2l1NitJRWtSbDhub1JUZHR1Y01wQy9VT0lRT096TUpsQlcx?=
 =?utf-8?B?TEM1RTNGejh5eFYrNWJlTmJicysreU9PRUZZU3NOSmsrT045M2VoTHh5VnlE?=
 =?utf-8?B?ZWw4Q1pENFZQK3JLOUFJL1hGa2FERDZMejJOQlBDeGtBVXRmVXlSWkgzVTZk?=
 =?utf-8?B?VDBETkUrQmtBMmJqaFAxZitYYnZKaWhhdUsrUWNsby91WG1GVTNzMmh5ZEFj?=
 =?utf-8?B?Rkk1TkJKc0NFUkxuOXM1eDBtNzRoKzRvc1ZvSlhqVDFiTmEzd0VKcVdJMzBF?=
 =?utf-8?B?SW1mbTBxUjM0OGoxdnJBWlFlT0Q2aXlmV1VmVTdOS3RhWDRiVWxHYXp2OFRV?=
 =?utf-8?B?WWJOTkQ0K1BCY044VlRtd1ZTS293b3BCK0pJWHlzNzZuR2dYREhVQ1JFS3I3?=
 =?utf-8?B?WTRrSjdpSHYvNUM4YkdzeGJGTTRjRUE5VWZjck1QWnozNlBVZ01iMjg2dzl6?=
 =?utf-8?B?VFYxYzZTTWFpMlo3OStYcGR5eFJqd0pQZ2VvRzZvVVlqS0h0SFhIZW8xNUZW?=
 =?utf-8?B?WnQyU0FVZzVWR0hNTlBNRFEyc2MyZ1FpZFlLeHRZOXc3V2xMdXJQNnN6K3hU?=
 =?utf-8?B?N0I5dUIrOTZkZjEyMGROV2hrVDlyVHdaaUpzNzNQVUFmVmhmdURBOGd1UU1E?=
 =?utf-8?B?ZDE2TVU1R2JjZWF1UzB1OHU1TXpqbUdtd0ZFUFFPREhheENDT0hFSDMrd0NB?=
 =?utf-8?B?TEI2Y3BIeEg2dExHcTBUbzhrdGZyQjhBZTB6M1ZHY2NXYlVsS2lyckR3SHQ5?=
 =?utf-8?B?RytBeUJrWGE3NENiZklGaytibGd0elp3TnV0aWZNdkliRTduSUdWRklDNlBZ?=
 =?utf-8?B?eFlWazBDQTEwSi9BOHJPNjdYaTVZeUh0MTlURk5aSDN5aTN5NVFNbWh5Rm5h?=
 =?utf-8?B?Q0cxZXRtN0kyMHcybmhHU090akgwTGpmSGFoT0RQUlkwcHZZSXhLSmF1VUcw?=
 =?utf-8?B?OS9MbXB1Q0pMemdlWklCbE1yZXZNL0g4VEUzVzB1eFp6VCtYRk14SFBkamNk?=
 =?utf-8?B?d2N0dzZmV0Rhd2JSRldEMlQwdUo5WkV3eStrMzZBM1RzbjNGallYd2RFVlAy?=
 =?utf-8?B?eEFmTERzZFJLYVNTRHkrK2tMbGZUdkgrc3dReHFUL2lFYXd1SXQxWFFyL0gy?=
 =?utf-8?B?Q2hBd1hKemQwb29GTzF2Y1lONDI5M2tsL2FQeUlhNmFCdSs4dWIyNUVWa0Y0?=
 =?utf-8?B?Z3Bad0ZxYUg4bGNiUmdOb2RrL3VJa3lxeDJBTFQ2djlvS2p4ZEVCVGwwM0Zl?=
 =?utf-8?B?UVRjbTNYYWh5UE5TSFN5QlJxbktBSy9OZjJaeVNXR2ZnZUJ6QzI2a2I3ak1z?=
 =?utf-8?B?SXRGWGFrOGJNcmJTMmFPQytkSEk1N1dJeDhOKzRCM2NxMjUzVEcrazRlL1B0?=
 =?utf-8?B?ODh0d05lR0ZXeVhDNFZCUklHK0lMWlhlcFpsNEtKVFk3YThXUWI4aVRFNnRk?=
 =?utf-8?B?cVg2UzBRdGVpYkp3bEh3VldqNGZaRDhyTnF3S0VSOWxaVlhya2pVak40Y2xE?=
 =?utf-8?B?N1JQbVdKcHI5Z255NUEvZndzWjZSTThrNHViS0ZGN1hpNm00dSt3MG81djFt?=
 =?utf-8?B?NEpwU2xLbEw3YktGNFhzQ2V3bmxpeFFvZTZBZFNCTm91MHhuejNoaWZPR0w1?=
 =?utf-8?B?dGhNQ3J1dzBZZHFtMEZSWFdENlVsVUVlWlpXMmtKSTZhUDlsK21qWnJRcytU?=
 =?utf-8?B?SStGd1hFZlFwL0QxckFyWlpacUUvRndNWVhKeHA0NEo0Sm5DaFZOY0cyWDZY?=
 =?utf-8?B?V2FNOTQ2NC9KcGk3c2JPNDdYdUhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34de9e3-9fd1-4e41-625b-08db44848baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 05:27:07.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8+OV+1lzHvm8vGxh2qrc52U5vxo5nzSYYTEdnvzTQGs4YFAqzZTUdD6PS1G0nB03FZjrSlgVCnD9huKKVNvadsZ6HkuEZVmlUQTe2ATpsE9A+XS8LY89NFgaYzWNDHu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9962
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFNh
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyA4OjUxIFBNDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAy
MyBhdCAwOToyMzo1MlBNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBUbyBp
bXByb3ZlIGNvZGUgcmVhZGFiaWxpdHksIGFkZCBkd19wY2llX2xpbmtfc2V0X21heF93aWR0aCgp
Lg0KPiA+IFRoZSBvcmlnaW5hbCBjb2RlIHdyaXRlcyB0aGUgUENJRV9QT1JUX0xJTktfQ09OVFJP
TCByZWdpc3RlciB0d2ljZQ0KPiA+IGlmIHRoZSBwY2ktPm51bV9sYW5lcyBpcyBub3QgemVyby4g
QnV0LCBpdCBzaG91bGQgYXZvaWQgdG8gd3JpdGUNCj4gPiB0aGUgcmVnaXN0ZXIgdHdpY2UuIFNv
LCByZWZhY3RvciBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvc2hpaGlybyBTaGltb2Rh
IDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCA2NSArKysrKysrKysrLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2ln
bndhcmUuYw0KPiA+IGluZGV4IDY5MzU4ZGMyMDJmMC4uYzc2ZmE3OGM2NDY4IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiBA
QCAtNzM3LDYgKzczNywzOSBAQCBzdGF0aWMgdm9pZCBkd19wY2llX2xpbmtfc2V0X21heF9zcGVl
ZChzdHJ1Y3QgZHdfcGNpZSAqcGNpLCB1MzIgbGlua19nZW4pDQo+ID4gIAlkd19wY2llX3dyaXRl
bF9kYmkocGNpLCBvZmZzZXQgKyBQQ0lfRVhQX0xOS0NBUCwgY2FwIHwgbGlua19zcGVlZCk7DQo+
ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBkd19wY2llX2xpbmtfc2V0X21heF93aWR0aChz
dHJ1Y3QgZHdfcGNpZSAqcGNpLCB1MzIgbnVtX2xhbmVzKQ0KPiA+ICt7DQo+ID4gKwl1MzIgdmFs
Ow0KPiA+ICsNCj4gPiArCS8qIFNldCB0aGUgbnVtYmVyIG9mIGxhbmVzICovDQo+ID4gKwl2YWwg
PSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9MSU5LX0NPTlRST0wpOw0KPiA+ICsJ
dmFsICY9IH5QT1JUX0xJTktfRkFTVF9MSU5LX01PREU7DQo+ID4gKwl2YWwgfD0gUE9SVF9MSU5L
X0RMTF9MSU5LX0VOOw0KPiA+ICsNCj4gPiArCS8qIE1hc2sgTElOS19NT0RFIGlmIG51bV9sYW5l
cyBpcyBub3QgemVybyAqLw0KPiA+ICsJaWYgKG51bV9sYW5lcykNCj4gPiArCQl2YWwgJj0gflBP
UlRfTElOS19NT0RFX01BU0s7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChudW1fbGFuZXMpIHsNCj4g
PiArCWNhc2UgMToNCj4gPiArCQl2YWwgfD0gUE9SVF9MSU5LX01PREVfMV9MQU5FUzsNCj4gPiAr
CQlicmVhazsNCj4gPiArCWNhc2UgMjoNCj4gPiArCQl2YWwgfD0gUE9SVF9MSU5LX01PREVfMl9M
QU5FUzsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgNDoNCj4gPiArCQl2YWwgfD0gUE9SVF9M
SU5LX01PREVfNF9MQU5FUzsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgODoNCj4gPiArCQl2
YWwgfD0gUE9SVF9MSU5LX01PREVfOF9MQU5FUzsNCj4gPiArCQlicmVhazsNCj4gPiArCWRlZmF1
bHQ6DQo+ID4gKwkJZGV2X2RiZyhwY2ktPmRldiwgIlVzaW5nIGgvdyBkZWZhdWx0IG51bWJlciBv
ZiBsYW5lc1xuIik7DQo+ID4gKwkJcmV0dXJuOw0KPiANCj4gSGVyZSB5b3UgYXJlIG5vdCB1cGRh
dGluZyB0aGUgTElOS19DT05UUk9MIHJlZ2lzdGVyLiBZb3Ugc2hvdWxkIGJyZWFrIGluc3RlYWQg
b2YNCj4gcmV0dXJuaW5nLg0KDQpPb3BzLiBJJ2xsIHVzZSAiYnJlYWs7IiBoZXJlLCBub3QgcmV0
dXJuOyBvbiB2MTMuDQoNCj4gPiArCX0NCj4gDQo+IE5ld2xpbmUgaGVyZS4NCg0KSSBnb3QgaXQu
DQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4gLSBNYW5pDQo+IA0KPiA+
ICsJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9QT1JUX0xJTktfQ09OVFJPTCwgdmFsKTsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgZHdfcGNpZV9saW5rX3NldF9tYXhfbGlu
a193aWR0aChzdHJ1Y3QgZHdfcGNpZSAqcGNpLCB1MzIgbnVtX2xhbmVzKQ0KPiA+ICB7DQo+ID4g
IAl1MzIgdmFsOw0KPiA+IEBAIC0xMDQwLDM2ICsxMDczLDYgQEAgdm9pZCBkd19wY2llX3NldHVw
KHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4gIAkJZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJ
RV9QTF9DSEtfUkVHX0NPTlRST0xfU1RBVFVTLCB2YWwpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gLQl2
YWwgPSBkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9MSU5LX0NPTlRST0wpOw0KPiA+
IC0JdmFsICY9IH5QT1JUX0xJTktfRkFTVF9MSU5LX01PREU7DQo+ID4gLQl2YWwgfD0gUE9SVF9M
SU5LX0RMTF9MSU5LX0VOOw0KPiA+IC0JZHdfcGNpZV93cml0ZWxfZGJpKHBjaSwgUENJRV9QT1JU
X0xJTktfQ09OVFJPTCwgdmFsKTsNCj4gPiAtDQo+ID4gLQlpZiAoIXBjaS0+bnVtX2xhbmVzKSB7
DQo+ID4gLQkJZGV2X2RiZyhwY2ktPmRldiwgIlVzaW5nIGgvdyBkZWZhdWx0IG51bWJlciBvZiBs
YW5lc1xuIik7DQo+ID4gLQkJcmV0dXJuOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCS8qIFNldCB0
aGUgbnVtYmVyIG9mIGxhbmVzICovDQo+ID4gLQl2YWwgJj0gflBPUlRfTElOS19NT0RFX01BU0s7
DQo+ID4gLQlzd2l0Y2ggKHBjaS0+bnVtX2xhbmVzKSB7DQo+ID4gLQljYXNlIDE6DQo+ID4gLQkJ
dmFsIHw9IFBPUlRfTElOS19NT0RFXzFfTEFORVM7DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQljYXNl
IDI6DQo+ID4gLQkJdmFsIHw9IFBPUlRfTElOS19NT0RFXzJfTEFORVM7DQo+ID4gLQkJYnJlYWs7
DQo+ID4gLQljYXNlIDQ6DQo+ID4gLQkJdmFsIHw9IFBPUlRfTElOS19NT0RFXzRfTEFORVM7DQo+
ID4gLQkJYnJlYWs7DQo+ID4gLQljYXNlIDg6DQo+ID4gLQkJdmFsIHw9IFBPUlRfTElOS19NT0RF
XzhfTEFORVM7DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQlkZWZhdWx0Og0KPiA+IC0JCWRldl9lcnIo
cGNpLT5kZXYsICJudW0tbGFuZXMgJXU6IGludmFsaWQgdmFsdWVcbiIsIHBjaS0+bnVtX2xhbmVz
KTsNCj4gPiAtCQlyZXR1cm47DQo+ID4gLQl9DQo+ID4gLQlkd19wY2llX3dyaXRlbF9kYmkocGNp
LCBQQ0lFX1BPUlRfTElOS19DT05UUk9MLCB2YWwpOw0KPiA+IC0NCj4gPiArCWR3X3BjaWVfbGlu
a19zZXRfbWF4X3dpZHRoKHBjaSwgcGNpLT5udW1fbGFuZXMpOw0KPiA+ICAJZHdfcGNpZV9saW5r
X3NldF9tYXhfbGlua193aWR0aChwY2ksIHBjaS0+bnVtX2xhbmVzKTsNCj4gPiAgfQ0KPiA+IC0t
DQo+ID4gMi4yNS4xDQo+ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCv
jSDgrprgrqTgrr7grprgrr/grrXgrq7gr40NCg==
