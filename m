Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E195269C9D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 05:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgIODjO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 23:39:14 -0400
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:41920
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbgIODjN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 23:39:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9S3CreG1QD/S7ZQErVWv0gEGDt2F8Cjb51w9+Hey2tmNgJ4sDiS1vg9eLmoHi4AQjCQymBGMTJz0+3fpsBluhMsoQGm8TflbtuI/nCJTwYVS2MBstNOXdX3weR4K4qtZw4v/km4az09jOAyNkQd8kvJ+5wCUfU4tJbEq1S+H9jsnn6dHsnp6p4xUdIfXSAF64f4JqRIKkmmCf8TsDOYFfEEhtFpxcNfm04+rQdJ5LPTWoCT846DHO7D03PVrcx9/238SbF3PBIw/fTcV25RhlxhL8jRJZ49oHy2tLf8jjKG0WuSh9R4YkTrdHTGIfd6T5kaFFoBYLPt8sqnE0CKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75LJrgYg5mk7bvvVfzkESxZ9jl09lNK+/pt5vuhdEKg=;
 b=hf666DmTEDI7wcsxhu8RBFNjVhMtWoZQkwUnq2+OxoRiwXJHix4vsEB2ixR655bTkHt2dcKyYg3dJ/JpBL6CTBRnUihn+f3S/br2EbBdPsyNws2hWvZbcHcm+/fdP/rsq2Gw3y38pdOvHfHpDt9tLGHRINNeI/JoF0oG1nDzY9mGcgOkZV8WNdBgtMHRdeNAfHFB+nw5KBF++wzJCY43n6Z2rCS+O0J4VsCwsJgnOhXSkZXt/6JQ+T8ECsQ6v2M0878z0l5BelXUwItrVawa5HNCmyl65NXZMJdFWMRqNmpHUrzsIlil1BV02LHiqXZKua41QxS5CU5qEx1lYGWHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75LJrgYg5mk7bvvVfzkESxZ9jl09lNK+/pt5vuhdEKg=;
 b=KZS+xIr0VbhQy8EnI9MC9hb24ZuNLr5tAfHxY/ApO7G/bMAY7u5r8xCspxMFDXzMrqaZ3jloT14dRE07IFHWVKQLECbwAsyzY2zQBFwv50lLnNzgYQOYy4NNL1lFAmMpP5GHguk3qUoUVlk14CGGcf5Q2TT34IH8fjJBOtxSmg8=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3081.eurprd04.prod.outlook.com (2603:10a6:7:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 03:39:08 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 03:39:08 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Thread-Topic: [PATCH 1/7] PCI: dwc: Fix a bug of the case dw_pci->ops is NULL
Thread-Index: AQHWhNorf38ULZ61u0GuKdLTkLaVfqlo8fSAgAAnD2A=
Date:   Tue, 15 Sep 2020 03:39:08 +0000
Message-ID: <HE1PR0402MB33719CDE2C2C3E1677E0919884200@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-2-Zhiqiang.Hou@nxp.com> <20200915011625.GA640859@bogus>
In-Reply-To: <20200915011625.GA640859@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6522a685-7b10-4c43-1004-08d85928e74b
x-ms-traffictypediagnostic: HE1PR04MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB3081F4E63C6015C368479A1184200@HE1PR04MB3081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tt6lYbm5V8bLk528gvDtV/kwTW4Gks+IhLMaQpSiJLFB6eDdx3omGoiQOsRnhQKMncLPtQ7x/cPdYg0JuLFzriazKnXBV/T764RUaVKPpGlEcMoExRIwdRLru9gOVN7EowTomkuNSvssfAbpqTJBqFjWsgdQU2JGLImDS5ql6GkSiOpwOVr5/ZCQUde2I774prpfdJFxblE6zLJMdziJlbIc/6yqBDA+mxh6mvHkRfUbNb4ozXiuShb+wchRG6tIBMLdrbwAzVuJSD5T/88Ec/FdyZPWwjrQcxlizdSnYLaRBceV/D8fbXHdMddTmbNYMCt4GImKzE/LYQWfi3bquA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(5660300002)(71200400001)(316002)(54906003)(4326008)(33656002)(9686003)(4744005)(55016002)(83380400001)(52536014)(8936002)(66476007)(66946007)(76116006)(53546011)(8676002)(86362001)(66556008)(7696005)(26005)(478600001)(64756008)(186003)(66446008)(6506007)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bnBQglwz1KjwgjA46iEXFoiScqTtYeIeTnGEpfrWYnJGKWzpJPF5+FW1NA8soKfGsWmhhkUVq6AwSGtlEi2XSmHS7/t9wQ9l9PvNfsm+7ipGsBppgak44gkP8Oq82wIgdx6IXn1Ihd+lS6kl3WkG4IUsbsxJboOvhagKcjcTQiDT2bXFW97r7d/YEpudFxgNuYUYoemBIaHWuXo+hYai7TZ2ShMvFwxZwxASJfLTqpbeVtxg/0DvL1BaBHVml5FIbg5YzT3pzuQZJutgRtHbnMPIjlMfko6o+xOwnsmJglSWLS4k5Fv6W+UllmYu8Ax/wiKPU2JqBc6QGr76WaMDWkJJV9NG7PcH3Gxa4IygmcOZgcAxBfytns8jBZmkfYHQ73PvIppuufqlRbWv67X965aCrKtjMR2r74guqJumU+2Z1AXQJjkw0vgid13VVeTapal/oDAEDoWGoy4oguFRftP1eXieeu6LlpOyv4Tnt0ksm6uaa5/qsX1BThM1CxbxQ0tyiBwOE4NBdZk/u13xsS3/oP9Snnw5rXqcZuvNsoTnwnCbxNopzt88FPtF1HJLjPjezvyl840lS2WJH+kk2XAuNGjKFC/hNL3pzVRjLdQFBAN9DH1+VqiLC1RWhwvL3MTZMhaMN5PHGW/yZIVkEg==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6522a685-7b10-4c43-1004-08d85928e74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 03:39:08.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oPDWtZ3X1wk+3xuX6zly8ywb1UZm53/nE0pa5xixjGcCwqgxxmzKD98j/NsYpjdeSAIDRGdJ+/NMyLestjeTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpSZWdhcmRzLA0KWmhp
cWlhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIwxOo51MIxNcjVIDk6MTYNCj4gVG86IFou
cS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207
IGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tOyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxp
YW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IFJveSBaYW5nDQo+
IDxyb3kuemFuZ0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvN10gUENJOiBkd2M6
IEZpeCBhIGJ1ZyBvZiB0aGUgY2FzZSBkd19wY2ktPm9wcyBpcyBOVUxMDQo+IA0KPiBPbiBNb24s
IFNlcCAwNywgMjAyMCBhdCAwMTozNzo1NVBNICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+
ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IFRo
ZSBkd19wY2ktPm9wcyBtYXkgYmUgYSBOVUxMLCBhbmQgZml4IGl0IGJ5IGFkZGluZyBvbmUgbW9y
ZSBjaGVjay4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jIHwgMTIgKysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBSZXZpZXdlZC1ieTogUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIG1heSBjb25mbGlj
dCB3aXRoIG15IDQwIHBhdGNoIGNsZWFuLXVwIHNlcmllcy4NCj4gDQo+IFJvYg0K
