Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58E6EC837
	for <lists+linux-pci@lfdr.de>; Mon, 24 Apr 2023 10:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDXI7s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Apr 2023 04:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjDXI7r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Apr 2023 04:59:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2129.outbound.protection.outlook.com [40.107.114.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14056E55;
        Mon, 24 Apr 2023 01:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdi80IzRe3dlWOCLwBjph8/CkRsytHUQe+34Ts39p1UDUiSsAgil3niqZxM6JbfMgIACKiv8pOBV4avnSrls1sgaYuvsLHAKWj/BDwBr5q4GepH2l1fFcNkB0oPn/XxAyfRMBS1XUv4uojGQ/fF+8LKRLOfvyC+Tk28qgZkiwl4CAMAzHC8iMqFX4bNSpqURHhv/fmzp2PjFvDO04uTG/zIsTAVhijUhddamd/+/iVFbt9FXXfskwW9WS/Ys2wiAFyh1rkIM+UYAL82ckBFgmAiom4E1ptPKDBrWtvW/0Qz8FUGEiLt2aeBEcxdaZXQombBFZkUJeH/bkBpLmtPCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXTzTg6ZVMrchm2SbFwUchg4lNvv80WS+FxAmYZSoTw=;
 b=VQAaxxHHP8J0VpPCvxnY976155XsjFCw8Ej/rSolkRuK7U5JBOgN+StgK2FMOcWYKDh5EB14GZgTc6fDfzgc/tk380ECmaK2p/3/7CQG1ZQxNHV2imQCgCt5I10hOBwozVSXRh3w9nOSUkMq4UxvqUKQIu4xk1zclnCobGGfuwz0bIkb03pJVTQqIbQXhcYjlEzCyCqpodlTM4t2Kl20ZYic3LTjoyCfGKNAJAZ2wi95pBeKQLgFpD48wSBZZIimzQbw4aB+vIC6q+WhkooIlSsHPZdW7v07ANEeCn3SsLeuUKietejPwaNWLScPlzlRM6KKVMs0hrx34burNkuy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXTzTg6ZVMrchm2SbFwUchg4lNvv80WS+FxAmYZSoTw=;
 b=ga8zV3XCO0AqD0LTSMqFnarcCafg1fYvLz4wYzCK/QYN5JZ/sZa+um+hqehc+TIHvGuuxNoE+aHdatoAmlH13/u9/e5kIIlnZniFzEK0xSmgJ8BEgK6me0KW9aOYBLHZ/MOsVRjlfUW7OWTajzw65NyXXq721z+y/uFXRezoLBM=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by OSZPR01MB8273.jpnprd01.prod.outlook.com
 (2603:1096:604:187::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 08:59:41 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::5198:fdcf:d9b1:6003%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 08:59:41 +0000
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
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v13 17/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Topic: [PATCH v13 17/22] dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe
 Host
Thread-Index: AQHZcfCx/Hnm9tYrTUyLLzKQoe1+OK83Y3QAgALKKUA=
Date:   Mon, 24 Apr 2023 08:59:41 +0000
Message-ID: <TYBPR01MB53414D9435EFA3C5546E4D19D8679@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
 <20230418122403.3178462-18-yoshihiro.shimoda.uh@renesas.com>
 <20230422140644.GN4769@thinkpad>
In-Reply-To: <20230422140644.GN4769@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|OSZPR01MB8273:EE_
x-ms-office365-filtering-correlation-id: af0eac6d-3dd7-41e9-d5f0-08db44a23d8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jftPFZQoQuZzNuSoeaptrSYrmCaKLKPdCbgW4hBbtOlCNUYMhtJe62gBuR28I2Kn9XSn52eN1VnawRwDFZOlUUsyd3cUDy3luyI9DPHbnI6NpRgxjOORGtMpqlRxo9EziM9gpRsFy0Ol0vmQvgPq7lZtLz8c/ORQOKK1IlZdYUAJc04mdqSdD63FZSd6jrBGqTqA1sozzwmFOgOW9TzPYrWvq1RdDVXVOsVw/cw3oPBdJnbjC+uhQieF4Lh0zKujXR/CRoWernrYrFW2MRSRVzCckhvQ0PfV1DXKCHgmbw7cKsPSX6DBvqKQKsRxrTN0Q8y6bSukUdjOwOqn/V+xwGEvHSuzo5vUxbfP/lr01H5lSfquhW3P2iyMUY0z6+jLhFvocH479PC02NFzzxaLEfXXXIMF+665HMx1SjGYzWEJnzeQ5jvwtUIVWXsi79He3GKmd47vZJ+kugWQI/byBgaM0zaSgP04ilkEmtjitqGUQbjs8osCHG2jOl8hY/Xh/1iZaWKdVSI4OUl2zyCoxDZ4zmWf0jdoftbh1iA7MYwoVCwyZoPnYfURCz+aV8RE215NLU34dVRgGxSZjCsgsBQfKcknepcLY5o3W2dPdtYZmlrE+jYOlGeH37+B6JpY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(186003)(6506007)(71200400001)(9686003)(7696005)(38100700002)(66946007)(5660300002)(66446008)(52536014)(66556008)(41300700001)(6916009)(4326008)(7416002)(8676002)(8936002)(66476007)(76116006)(54906003)(478600001)(2906002)(38070700005)(316002)(64756008)(86362001)(83380400001)(122000001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUwvR2JOOU5ZN0FnZFRFRk1nbUtOZ2t2NENRU3dzODV3OHhmcGxReDBJbDJJ?=
 =?utf-8?B?K3VrOHBIOWpOOUJpZ2xsOHRUQnR2Qlhpdm03aVllc0dJU1h3WkpGcXJiNWtN?=
 =?utf-8?B?ZUR3QmNadXkrVDQxNVlmYjBqNG1MMFpTOCtkcys5SHNDS1VGTGFnWVBidzVQ?=
 =?utf-8?B?Wm10K25BVndQM2N6eHhvZkJVcjB3SUZSN0ovSmw1eGNZVWsxdy9rTjNEZ3FM?=
 =?utf-8?B?Rm9tNzhQcFB4Ym1uNURRUFpaR2R3ZnlobTV4dVlUMUVzQU8xYkVPUEdkeEs4?=
 =?utf-8?B?MzBDQkRmRTRGVHQyQ2QvYlJlNHdMWEx2SHdDYkpOWHd6NUlhdmcxcHFZWTZ3?=
 =?utf-8?B?Z0tUM3pZTGpVcGtZdVRERmtKeVVhcm82cTBMdzVaajZFRkNwNWFEQUF3Rzdr?=
 =?utf-8?B?ajF2VVhiWDhSNVZNT0RtM2JXeGV4bGhWUTB5S2JkWmFuT0NlYy9EYnZ0VzJW?=
 =?utf-8?B?ZlRBbTVmY3d2RnFRS2M4cmtkOHNZc1h0U3ZBKzMzZzJLMTJSME90UVdOVTlh?=
 =?utf-8?B?cXQ0T3k1bUJPZUNXMXdlQ2tvazd0TjBLVmZpYXlybXd1TU5OQkRnaVQ2SEQ3?=
 =?utf-8?B?NEk1SURscWJXSmtXYnRiQ0VVYm1rbFZSaEJkTncra3dhVzJaL1ZTa2RlS1V4?=
 =?utf-8?B?QklWRGM2SjhrWGpTKy9qZjUvSVpic2oyWDQ5eHdXUjVkVDUxM3ZzVit4Wnhx?=
 =?utf-8?B?SHlOekxQMlVjdmdaby94eEl4eEVpUFhCN2dvanAweExhaFJYcFdnbEwxQXNL?=
 =?utf-8?B?S2hLN252bXFUdEZWQXlrNTVLVFh6bzJPdDZwMVM0QTJpZGh3NVNLcDFFMUxy?=
 =?utf-8?B?dzN6YTJYODVaOEd4SktLMkVzd214M0xUcW1LTXp4Skd3bE9aV2NFWHBqeWRy?=
 =?utf-8?B?OTB3bFNWbDhIdGhRM05iSEREV0t5WkpKRU9KT25sdFgrYmt6c0cwREFCN1JL?=
 =?utf-8?B?ckVyZC9GTFRPeEZMQzVjSXNxVFR6NzNBVlVkY0RabjN2aWNtN3RHZ2JmMm9r?=
 =?utf-8?B?TlBKZVpHRlppSFRhd1N5WU9xRmYvWGZ4cUIwK2RZTDd2NTZDTUlPMWVCWk9r?=
 =?utf-8?B?WHhjNTBCcklkU2JOdFJKYzBTdmdDRmZwdlZNL1BwYzlmanNOaDFadTRuTGI4?=
 =?utf-8?B?UzFoSDdCQkU3Y1JPNDVFMDdiSTcrY3Q3S05yWkdreW9MeU82bmFoMnVyUk85?=
 =?utf-8?B?MndsZlp2MzVUOEcyVFhSaUdiRWREcktWdmpqdlV0eXA2YTJsam9CRWtXNkJW?=
 =?utf-8?B?SVdqR3JrYXk1aVdVcVMzQ2R0eURqZGd0SjFRR0RodkFia3VPSGRKcWhIalRk?=
 =?utf-8?B?RFZjMHRYNHdjUjNtZ1UzeW1nVlgyZTU1MDVzQTRjU0tCcDQzOTdNaTZtT2xU?=
 =?utf-8?B?ei9jSmlFSFRvYStDV0phZms4SzBWOXRjdVV2cCtQcEZvKzY1TEZITlVIWDdv?=
 =?utf-8?B?WUVXVlZBMGIzUWRGOGFLWGx2ZklwZnp5Rm4zN2VtTW94VVBsZ2JSejFtSTJh?=
 =?utf-8?B?UEloVE9uM2J5ZkxMRmNMTjF6WGRZbVc0Y0RZVWoyZGdFOERaUnlvYnNoT3dR?=
 =?utf-8?B?Y29yRk1KWWJzWjNhYU55TmtseGFTTDZRbjNMUHR6L1lRK1pXNGhTaFl5RFFn?=
 =?utf-8?B?R0M1NktNek5uRUhVdnVnZzlUVjVNY1NNRlU2Ri9HWGVYNUZ3ditIMUo5VlBP?=
 =?utf-8?B?dGdna0pwb25SWWJwOWhtKzVheDh3SXFMZ3dFT0VUWUIrMXZjaGpmaTA4TFV1?=
 =?utf-8?B?RWlUbVNuYjBtWkdHbEZiYmdXOERGVG9jRFpRSDZic1p6MGtuVThuNSs2bllV?=
 =?utf-8?B?RFZidnVEOWVCUGpyc081OHFOWktOU05WVkR2emtGZlhvYk11amFGaUkyaWJr?=
 =?utf-8?B?ek40YWJuSnF1Szg3UXRQVmlENjRCMmhoMnFYVWhyQisveE50TXk3eWRBaEZl?=
 =?utf-8?B?QW9SOGJJOGM3b2VkT1lJOFpVK3pPOGNYenZCdDV0enRyZmxGTDJFdVdzdnNn?=
 =?utf-8?B?ZTZaY29lSEdtOWNSTFRrNmZsVzVoQStSem9udWJwbjV4S2NlamtZZzhiN1F1?=
 =?utf-8?B?Mlc5YkNodVFHeGlwS1FKYVRTR2UwRlpwYzN3Z0gyZFhORzNKaXA2YzlQemR5?=
 =?utf-8?B?aVNhMVdzNFFGUEswN1licFZ3UGYvUUgwTk4xZmc0NENVa2Jjcm96YzlnSmhF?=
 =?utf-8?B?czh4ajlwdVVHbTZGNG5USFlJNEpDZGtvSWFySjFlSXNhWXNLTHNBVU54TVRO?=
 =?utf-8?B?VS9IbnFQcFdpR2VpVXRBTWdNMGhnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0eac6d-3dd7-41e9-d5f0-08db44a23d8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 08:59:41.0955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2PhLOjhZbW6apqAVA4APuxXDjhSC6NgtGmAgiCzVO75tOyuc8RAQI5IglsQqDEea4viLPThObjkxVi2LoG5C4IWypInCR8UEqlJCUwgdACh3OEzEXWndHeeWnP3e1bS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8273
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
dHVyZGF5LCBBcHJpbCAyMiwgMjAyMyAxMTowNyBQTQ0KPiANCj4gT24gVHVlLCBBcHIgMTgsIDIw
MjMgYXQgMDk6MjM6NThQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4gRG9j
dW1lbnQgYmluZGluZ3MgZm9yIFJlbmVzYXMgUi1DYXIgR2VuNCBhbmQgUi1DYXIgUzQtOCAoUjhB
Nzc5RjApDQo+ID4gUENJZSBob3N0IG1vZHVsZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlv
c2hpaGlybyBTaGltb2RhIDx5b3NoaWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4NCj4gPiBS
ZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBSZXZpZXdlZC1i
eTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vYmluZGluZ3MvcGNpL3JjYXItZ2VuNC1wY2ktaG9zdC55YW1sICAgICAgfCAxMDkgKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKQ0KPiA+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9yY2FyLWdlbjQtcGNpLWhvc3QueWFtbA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcmNhci1nZW40LXBjaS1ob3N0LnlhbWwNCj4g
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3JjYXItZ2VuNC1wY2ktaG9z
dC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjYzNzM1M2MzZGY4Yg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3JjYXItZ2VuNC1wY2ktaG9zdC55YW1sDQo+ID4gQEAg
LTAsMCArMSwxMDkgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAt
b25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyMgQ29weXJpZ2h0IChDKSAyMDIyIFJlbmVzYXMg
RWxlY3Ryb25pY3MgQ29ycC4NCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+ICskaWQ6DQo8
c25pcCBVUkw+DQo+ID4gKyRzY2hlbWE6DQo8c25pcCBVUkw+DQo+ID4gKw0KPiA+ICt0aXRsZTog
UmVuZXNhcyBSLUNhciBHZW40IFBDSWUgSG9zdA0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+
ID4gKyAgLSBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5j
b20+DQo+ID4gKw0KPiA+ICthbGxPZjoNCj4gPiArICAtICRyZWY6IHNucHMsZHctcGNpZS55YW1s
Iw0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAg
aXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IHJlbmVzYXMscjhhNzc5ZjAtcGNpZSAgICMgUi1D
YXIgUzQtOA0KPiA+ICsgICAgICAtIGNvbnN0OiByZW5lc2FzLHJjYXItZ2VuNC1wY2llICAjIFIt
Q2FyIEdlbjQNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4SXRlbXM6IDYNCj4gPiAr
DQo+ID4gKyAgcmVnLW5hbWVzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6
IGRiaQ0KPiA+ICsgICAgICAtIGNvbnN0OiBkYmkyDQo+ID4gKyAgICAgIC0gY29uc3Q6IGF0dQ0K
PiA+ICsgICAgICAtIGNvbnN0OiBkbWENCj4gPiArICAgICAgLSBjb25zdDogYXBwDQo+ID4gKyAg
ICAgIC0gY29uc3Q6IGNvbmZpZw0KPiA+ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAg
bWF4SXRlbXM6IDQNCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0LW5hbWVzOg0KPiA+ICsgICAgaXRl
bXM6DQo+ID4gKyAgICAgIC0gY29uc3Q6IG1zaQ0KPiA+ICsgICAgICAtIGNvbnN0OiBkbWENCj4g
PiArICAgICAgLSBjb25zdDogc2Z0X2NlDQo+ID4gKyAgICAgIC0gY29uc3Q6IGFwcA0KPiA+ICsN
Cj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBwb3dl
ci1kb21haW5zOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgcmVzZXRzOg0K
PiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgbWF4LWxpbmstc3BlZWQ6DQo+ID4g
KyAgICBtYXhpbXVtOiA0DQo+ID4gKw0KPiA+ICsgIG51bS1sYW5lczoNCj4gPiArICAgIG1heGlt
dW06IDQNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsg
IC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9ja3MNCj4gPiArICAtIHBv
d2VyLWRvbWFpbnMNCj4gPiArDQo+ID4gK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4g
PiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJp
bmRpbmdzL2Nsb2NrL3I4YTc3OWYwLWNwZy1tc3NyLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL3I4YTc3OWYwLXN5c2MuaD4NCj4gPiArDQo+ID4gKyAgICBz
b2Mgew0KPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICNz
aXplLWNlbGxzID0gPDI+Ow0KPiA+ICsNCj4gPiArICAgICAgICBwY2llOiBwY2llQGU2NWQwMDAw
IHsNCj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJyZW5lc2FzLHI4YTc3OWYwLXBjaWUi
LCAicmVuZXNhcyxyY2FyLWdlbjQtcGNpZSI7DQo+ID4gKyAgICAgICAgICAgIHJlZyA9IDwwIDB4
ZTY1ZDAwMDAgMCAweDEwMDA+LCA8MCAweGU2NWQyMDAwIDAgMHgwODAwPiwNCj4gPiArICAgICAg
ICAgICAgICAgICAgPDAgMHhlNjVkMzAwMCAwIDB4MjAwMD4sIDwwIDB4ZTY1ZDUwMDAgMCAweDEy
MDA+LA0KPiA+ICsgICAgICAgICAgICAgICAgICA8MCAweGU2NWQ2MjAwIDAgMHgwZTAwPiwgPDAg
MHhmZTAwMDAwMCAwIDB4NDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgcmVnLW5hbWVzID0gImRi
aSIsICJkYmkyIiwgImF0dSIsICJkbWEiLCAiYXBwIiwgImNvbmZpZyI7DQo+ID4gKyAgICAgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KPiA+ICsgICAgICAgICAgICAjc2l6ZS1jZWxscyA9
IDwyPjsNCj4gPiArICAgICAgICAgICAgYnVzLXJhbmdlID0gPDB4MDAgMHhmZj47DQo+ID4gKyAg
ICAgICAgICAgIGRldmljZV90eXBlID0gInBjaSI7DQo+ID4gKyAgICAgICAgICAgIHJhbmdlcyA9
IDwweDgxMDAwMDAwIDAgMHgwMDAwMDAwMCAwIDB4ZmUwMDAwMDAgMCAweDAwNDAwMDAwDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAweDgyMDAwMDAwIDAgMHgzMDAwMDAwMCAwIDB4MzAwMDAw
MDAgMCAweDEwMDAwMDAwPjsNCj4gDQo+IERvIHlvdSBhY3R1YWxseSBuZWVkIHJlbG9jYXRhYmxl
ICgweDgpIGZsYWc/DQoNClRoYW5rIHlvdSBmb3IgcG9pbnRlZCBpdCBvdXQuIFRvIGJlIGhvbmVz
dCwgSSBkaWRuJ3QgY2hlY2sgbWVhbmluZyBvZiB0aGUgZmlyc3QgYXJndW1lbnQsDQphbmQgdGhl
IHZhbHVlIGNvbWVzIGZyb20gb3VyIEJTUCBjb2RlLi4uIFNvLCBJIGNoZWNrZWQgdGhlIGtlcm5l
bCBzb3VyY2UgY29kZSwgYW5kIEkgZm91bmQNCnRoZSBmbGFncyBhcmUgcGFyc2VkIGJ5IG9mX2J1
c19wY2lfZ2V0X2ZsYWdzKCkuIEFuZCB0aGVuLCBJIHJlYWxpemVkIHRoYXQgYml0IDMxIG9mDQp0
aGUgZmlyc3QgYXJndW1lbnQgaXMgY29tcGxldGVseSBub3QgbmVlZGVkLiBJJ20gbm90IHN1cmUg
d2hhdCBpcyB0aGUgcmVsb2NhdGFibGUgZmxhZywNCmJ1dCBhbnl3YXkgSSdsbCBmaXggdGhlIGZp
cnN0IHZhbHVlIGZyb20gMHg4WzEyXTAwMDAwMCB0byAweDBbMTJdMDAwMDAwIG9uIHYxMy4NCg0K
QmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KDQo+IC0gTWFuaQ0KPiANCj4gPiAr
ICAgICAgICAgICAgZG1hLXJhbmdlcyA9IDwweDQyMDAwMDAwIDAgMHg0MDAwMDAwMCAwIDB4NDAw
MDAwMDAgMCAweDgwMDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNf
U1BJIDQxNiBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgIDxHSUNfU1BJIDQxNyBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgIDxHSUNfU1BJIDQxOCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgIDxHSUNfU1BJIDQyMiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gPiArICAgICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gIm1zaSIsICJkbWEiLCAic2Z0X2Nl
IiwgImFwcCI7DQo+ID4gKyAgICAgICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4g
KyAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCj4gPiArICAgICAg
ICAgICAgaW50ZXJydXB0LW1hcCA9IDwwIDAgMCAxICZnaWMgR0lDX1NQSSA0MTYgSVJRX1RZUEVf
TEVWRUxfSElHSA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAgMCAwIDIgJmdp
YyBHSUNfU1BJIDQxNiBJUlFfVFlQRV9MRVZFTF9ISUdIDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMCAwIDAgMyAmZ2ljIEdJQ19TUEkgNDE2IElSUV9UWVBFX0xFVkVMX0hJR0gN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwIDAgMCA0ICZnaWMgR0lDX1NQSSA0
MTYgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgIGNsb2NrcyA9IDwmY3Bn
IENQR19NT0QgNjI0PjsNCj4gPiArICAgICAgICAgICAgcG93ZXItZG9tYWlucyA9IDwmc3lzYyBS
OEE3NzlGMF9QRF9BTFdBWVNfT04+Ow0KPiA+ICsgICAgICAgICAgICByZXNldHMgPSA8JmNwZyA2
MjQ+Ow0KPiA+ICsgICAgICAgICAgICBudW0tbGFuZXMgPSA8Mj47DQo+ID4gKyAgICAgICAgICAg
IHNucHMsZW5hYmxlLWNkbS1jaGVjazsNCj4gPiArICAgICAgICAgICAgbWF4LWxpbmstc3BlZWQg
PSA8Mj47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4gLS0NCj4gPiAyLjI1LjEN
Cj4gPg0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p4K+NIOCumuCupOCuvuCu
muCuv+CuteCuruCvjQ0K
