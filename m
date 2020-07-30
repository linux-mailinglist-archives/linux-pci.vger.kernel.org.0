Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7F42329D0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 04:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG3CLH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 22:11:07 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:40007
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbgG3CLH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 22:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFjHOEn1eiVQ6stD+fOScQVgor2BUAYb/UOUNNnNYtQ1B8E0REa5dE8QIFxgq3T1LGgJ8VKO8sptCgYqdE7cHdmAuiPUh5oQSO84PZSFWjDis4tmrDnFglww0i8ZjFmMraKPpq5Hid83YC/RlRO+dAoNVUh7iiLpH94xTpHue+VR20cDKrkvB7LvANaqXQSwGUmHVmWqvJ/O/cEANq9ylLMjPxs5E44ZNQnBT9TvdWDuWVIBU8H1MJX9aFKHNgiAXX3rbIIdEOS05vA0kqFL+Hyl0VAF5V7uTAn/v44tlx6Re58HCxtzeR7K6zCJBf47uuGtgUlFkeymVhVa2D8cbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjP2R74ysHN7bzpaUOqEFLOb6gF5vOgnoxVvLWCgTf8=;
 b=EDrYqw8yjA7+J6VAefP4lwMOWZMQNGNVP578apX9IpanHocyMeGl9Ye6gfd5L/lUBdwcJveDVgSLWwID+ZvKCx3g2JKa/JaO936mTn4LNKP/uNce6qcsnGwhPXB9JaFObZGydsOTG8uZ0tsOSn9yYaahXoGqqF5pxOO6tMNgPK7y8lapkio/4UHJ5kL7YhISHtIbfLmbCqWBeWLsCeZnbSZsJVkGBlaD9JSVP87G3V6fQO5pWK94hrJC2RbxKxxT5eGjtlqBtnr+51hrmElLFQ9EbVdqM/4DV59HrHO1LVKLKPMRmArBLZlUuUI7iR2qgJ38oZf72VgmKzbGkICf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjP2R74ysHN7bzpaUOqEFLOb6gF5vOgnoxVvLWCgTf8=;
 b=njXcN5fNKjUeuzwwAgtcpBUuYgu6ZeJzN19EOsA3If3tSz38KPqcaTKU8aGazPN6IDqj7u9mud1kQWDxAIYWx8fBhdq7BxKX2w0gIVypwWRnC+dQJ5BkLMnahPrw1KY0fkOmTc+Lj5WJmFm5AP1rQMyzTu94LDSLlrUrWrVoWtw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB7PR04MB4939.eurprd04.prod.outlook.com (2603:10a6:10:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Thu, 30 Jul
 2020 02:11:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3%6]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 02:11:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
Thread-Topic: [PATCH V3 3/3] pci: imx: Select RESET_IMX7 by default
Thread-Index: AQHWXqG4Y4oLO+dW6EKGCbyaa2afQ6keu+gAgAAGD4CAAK2XAA==
Date:   Thu, 30 Jul 2020 02:11:02 +0000
Message-ID: <DB3PR0402MB391605E5B4F5E03F1E27B67DF5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
         <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
         <CAL_JsqLXGduym51-Ej8Td4yOyP-UfGP-WCh2xeP_V90Yabm4XA@mail.gmail.com>
 <0cdecff564215de6711ca04e063fa696a160fad9.camel@pengutronix.de>
In-Reply-To: <0cdecff564215de6711ca04e063fa696a160fad9.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 750b55df-b644-4e95-8d66-08d8342dcf1a
x-ms-traffictypediagnostic: DB7PR04MB4939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4939A70D5C51DFBC51663BB2F5710@DB7PR04MB4939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjyaU5K0E8VPtkyI5A/tVZi6mbF5ujIGJfvc3On4n195R6WZjJCn7XIROsmjSuKOiUYxHfZmXPsK8omNZW0o1QdWh78lt9rSjuezVr6JKKZ5VmJizMVrkj9H3eUHUxrWQMlIIBMVrKXjd6BMGkdLOSgKuPgpwjdPa7t3SpKYrZJQ5ZLyW670f9/DajLRJcNMLuGiexprARgjxZIANwzROJff8rZeFPG7KEzIKhQklzMUlrIVZZ9cXJ3E5jV1x5f7i67phKvZm4/zKMgDJgKbKM+07XUm4wgu2Si24hQ+o9DJehcqTRuoPhwtW+WfP/AmnJc5GOpqdqWQfXbvrZZgaA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(9686003)(86362001)(110136005)(7416002)(55016002)(53546011)(6506007)(33656002)(71200400001)(316002)(2906002)(44832011)(54906003)(64756008)(66556008)(66476007)(66446008)(52536014)(83380400001)(7696005)(66946007)(76116006)(478600001)(4326008)(186003)(8936002)(8676002)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Br6e/hGJVVHF8G89eulbS5I+KoyHmp1Hzi/jkR81usWH6m/kKkrjNBCr8K0qU6Ma+wuikCm37oCWR2oucwpGlPNYw+wYlUxxSbsFh2LY9zGtqVoEeFgU+zgv95DxlHhgo6KJaXD7QvgmIkF0WK2yVj9lj1l4iuGA/bDqpWlN9P13LsSn6J6d4SOBefXZMtH/tu5uRgZBsV2Zs6AwhPBtPYfoZLaaI05nO+q39mtcVcc5Nn3Tah/tiWugf9Ysopd31R8i1R6zR/06a4DKQu9gkvhYZdUlQ4R7MytfHiDbaMcUpZOXV/edjP9JYIhVuoGyOo7pVckeseH99KRmr8TjmW7Q2+w5D4KWacuvw7uuomD29Tc6eJX42ljMIJZOku6qecdBYb3G4X0LoR08PLm4YX8YPX6pqV9gELMajTGvz6wyBZvNeEzliDkGPM9vSBQ3d+H5qVsMxzxllIkJKd0lfqG5AD3ClXaKgu0yBJghsISqFRTSrDpkEP8Bw0P+1ElB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b55df-b644-4e95-8d66-08d8342dcf1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 02:11:02.3453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpqmY6NwmWNEyMDk5x/MjOJLvD0BBx1BP9QRI/3Ml6kK6o1D1XJfkIjY7O3n/I6+qEQI61DPlp23t5JpfVrqtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4939
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIFBoaWxpcHAvUm9iDQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDMvM10gcGNpOiBp
bXg6IFNlbGVjdCBSRVNFVF9JTVg3IGJ5IGRlZmF1bHQNCj4gDQo+IE9uIFdlZCwgMjAyMC0wNy0y
OSBhdCAwOToyNiAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gT24gTW9uLCBKdWwgMjAs
IDIwMjAgYXQgODoyNiBBTSBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gd3Jv
dGU6DQo+ID4gPiBpLk1YNyByZXNldCBkcml2ZXIgbm93IHN1cHBvcnRzIG1vZHVsZSBidWlsZCBh
bmQgaXQgaXMgbm8gbG9uZ2VyDQo+ID4gPiBidWlsdCBpbiBieSBkZWZhdWx0LCBzbyBpLk1YIFBD
SSBkcml2ZXIgbmVlZHMgdG8gc2VsZWN0IGl0DQo+ID4gPiBleHBsaWNpdGx5IGR1ZSB0byBpdCBp
cyBOT1Qgc3VwcG9ydGluZyBsb2FkYWJsZSBtb2R1bGUgY3VycmVudGx5Lg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiBObyBjaGFuZ2UuDQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9LY29uZmlnIHwgMSArDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL0tjb25maWcNCj4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0K
PiA+ID4gaW5kZXggMDQ0YTM3Ni4uYmNmNjNjZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL0tjb25maWcNCj4gPiA+IEBAIC05MCw2ICs5MCw3IEBAIGNvbmZpZyBQQ0lfRVhZ
Tk9TDQo+ID4gPg0KPiA+ID4gIGNvbmZpZyBQQ0lfSU1YNg0KPiA+ID4gICAgICAgICBib29sICJG
cmVlc2NhbGUgaS5NWDYvNy84IFBDSWUgY29udHJvbGxlciINCj4gPiA+ICsgICAgICAgc2VsZWN0
IFJFU0VUX0lNWDcNCj4gPg0KPiA+IFRoaXMgd2lsbCBicmVhayBhcyBzZWxlY3Qgd2lsbCBub3Qg
Y2F1c2UgYWxsIG9mIFJFU0VUX0lNWDcncw0KPiA+IGRlcGVuZGVuY2llcyB0byBiZSBtZXQuIEl0
IGFsc28gZG9lc24ndCBzY2FsZS4gQXJlIHlvdSBnb2luZyB0byBkbyB0aGUNCj4gPiBzYW1lIHRo
aW5nIGZvciBjbG9ja3MsIHBpbmN0cmwsIGdwaW8sIGV0Yy4/DQo+ID4NCj4gPiBZb3Ugc2hvdWxk
IG1ha2UgdGhlIFBDSSBkcml2ZXIgd29yayBhcyBhIG1vZHVsZS4NCj4gDQo+IE9oLCBhbHNvIFBD
SV9JTVg2IGlzIHVzZWQgb24gKHN1cnByaXNlKSBpLk1YNiwgd2hpY2ggZG9lc24ndCBuZWVkDQo+
IFJFU0VUX0lNWDcgYXQgYWxsLg0KPiANCj4gSG93IGFib3V0IGhpZGluZyB0aGUgUkVTRVRfSU1Y
NyBvcHRpb24gYW5kIHNldHRpbmcgaXQgZGVmYXVsdCB5IGlmDQo+IFBDSV9JTVg2IGlzIGVuYWJs
ZWQsIGFzIGFuIGludGVyaW0gc29sdXRpb24/DQoNCkxpa2UgYmVsb3csIFJFU0VUX0lNWDcgaXMg
YWxyZWFkeSBkZWZhdWx0IHkgd2hlbiBTT0NfSU1YN0QsIG5vdyBhZGRlZCBQQ0lfSU1YNiwNCmxl
dCBtZSBrbm93IGlmIGl0IGlzIE9LIGZvciB5b3UsIHRoZW4gSSB3aWxsIHNlbmQgbmV3IHBhdGNo
IGZvciByZXZpZXcuDQoNCisrKyBiL2RyaXZlcnMvcmVzZXQvS2NvbmZpZw0KQEAgLTY4LDcgKzY4
LDcgQEAgY29uZmlnIFJFU0VUX0lNWDcNCiAgICAgICAgdHJpc3RhdGUgImkuTVg3LzggUmVzZXQg
RHJpdmVyIg0KICAgICAgICBkZXBlbmRzIG9uIEhBU19JT01FTQ0KICAgICAgICBkZXBlbmRzIG9u
IFNPQ19JTVg3RCB8fCAoQVJNNjQgJiYgQVJDSF9NWEMpIHx8IENPTVBJTEVfVEVTVA0KLSAgICAg
ICBkZWZhdWx0IHkgaWYgU09DX0lNWDdEDQorICAgICAgIGRlZmF1bHQgeSBpZiAoU09DX0lNWDdE
IHx8IFBDSV9JTVg2KQ0KDQpUaGFua3MsDQpBbnNvbg0KDQo=
