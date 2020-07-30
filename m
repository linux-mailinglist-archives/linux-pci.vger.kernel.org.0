Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD9A2332BE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jul 2020 15:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG3NMD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 09:12:03 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:38241
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgG3NMC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jul 2020 09:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDGAetWc2EFrSKgTZe8MkXrmChfueWayKCZjMdmSCi4CCL8jzOu084vngmNeR13GDm8qXQ6jQEEuqJ9HZtm3C2bByJ2tm8stqHqB4RhPOSgu7FuNPqVdnW/9x63MGCvHmgWb05qODpM7zMDUVSSnLQc3uCtTBcWPMC9y06qOkZYI22ArdH5x7Y9A4cM+4gSXwc7v7c8fJtPDKH9HUaNH4y4E0pPOeTwSiJJZuer5FAYy6tK8I5ct62c65f0DwS77djn0LoSBuEH2QMCeiGjKjdeg9jGH9rM4oKB5KHicGhwu31wZmGyYomejy/MY6edUdl0McPiUpj8c3MyrEfSyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C1oLfOCR8N6gwY9Qa05FgwxLZ/nAipOKdDwmCHDh6E=;
 b=FugYFSeiBGz/Vk0M4Ma6F8bMBRbtzlNJJYJW6vkpT6pR/q3fDzhmPGiR1e3oBGyyIuY1txacEaLKejnWEysj+0a+mgLYTU4cmECl4KluIe1fAMW++8mCCCJbIcKi6h+URjGXZ6mP8U79v+IF3wiNu8a6o6ttdKl113Grj2Tg6mfPm21gX5ogVL2UiLiqM41ZRAykI1Otl7dw+vY/Bzaq1ooLgMlauYJTwz2iHOOpuwNyBjMeeF6tSvLq9RAdYec+Ojn3vsa37OTJx8Uy03M0uvkh7EDF6WALyt7WivHL9QCwtmuhR20czkS47BSdnbz+I1FndZgs+G2iyJ+0DstL2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C1oLfOCR8N6gwY9Qa05FgwxLZ/nAipOKdDwmCHDh6E=;
 b=LFalL2UA7Ecc8h57ewPM6oSy+iX18TdqR6pbtf1m3iDZBzOVC4Ymdp2GtlsSQE/qtbfWKKBD9bf2BRBED/1dQhaVEGx+lTRNTtvZjTHHwNqEN0z6EPXYkdSub730VrpKeTKbJw9czLZujx4bRWnQkaQae42XLy/+j4ef1AoEslM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR0401MB2374.eurprd04.prod.outlook.com (2603:10a6:4:4c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 30 Jul
 2020 13:11:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::49f8:20ce:cf20:80b3%6]) with mapi id 15.20.3216.034; Thu, 30 Jul 2020
 13:11:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
Thread-Index: AQHWXqG4Y4oLO+dW6EKGCbyaa2afQ6keu+gAgAAGD4CAAK2XAIAAVqoAgABiDOA=
Date:   Thu, 30 Jul 2020 13:11:56 +0000
Message-ID: <DB3PR0402MB3916989C4B9F4CD76FBF109FF5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1595254921-26050-1-git-send-email-Anson.Huang@nxp.com>
         <1595254921-26050-3-git-send-email-Anson.Huang@nxp.com>
         <CAL_JsqLXGduym51-Ej8Td4yOyP-UfGP-WCh2xeP_V90Yabm4XA@mail.gmail.com>
         <0cdecff564215de6711ca04e063fa696a160fad9.camel@pengutronix.de>
         <DB3PR0402MB391605E5B4F5E03F1E27B67DF5710@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <0b541063e66e29b1dd0dad70f77a18a8591f224b.camel@pengutronix.de>
In-Reply-To: <0b541063e66e29b1dd0dad70f77a18a8591f224b.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.18.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ebfad9d-1693-4d76-3c68-08d8348a22e7
x-ms-traffictypediagnostic: DB6PR0401MB2374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB237460BC037C520766424CCAF5710@DB6PR0401MB2374.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qV88s9LDzM2sGCa9cDj2qSUe6Gu5yPrlYOdkQDfzyxzxRigxBch1Uelm6SEOdrrg9tLnE+r6jR67apWQS6Q705YIl4d4GG2mpLH7JSSNzyIL5K3KHX8hp10STbBEyMRrHgcQMRIsV8aFA0eZavrcPcJXWj97kTI+Y8c2lLYgKe0okDYLtFA3sjVBaoUjStm50pW+d5P8ozB6VjWmIGVNY1hCVqoQhdKc5Hn1VJdYGs6lMM+7t2ojFyL8dVd8BZgqIrvG4CCUdlq97jLbae+sDO1zsfNcZZk+98EVIAiOAVxrgw2z5jjPZuS/5NwCWRTPGWHmmLdtrsFTUkCGi6eIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(86362001)(4326008)(44832011)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(53546011)(83380400001)(5660300002)(9686003)(2906002)(6506007)(55016002)(52536014)(7416002)(478600001)(71200400001)(54906003)(8936002)(26005)(33656002)(110136005)(7696005)(8676002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ucmif+q8wfLbE33i9FfQtVnfhltjSWdPWKKiUChZQPmgrE8v7U2egbGMgd3fzk+/kXX4VaboDDV3BRXPu69Ys6TN2JHXLvN6L8mQhte5stXEnC58Ta4CjY9mAE9edXNTghFHE3Jy7ON8+4X96fTTb+qDHkH1a1MFDy80LivHp4W06uKjh08WGtJ78WDEcGWnq/PKAkmok1aRfeDMlds+pJG6jFnkgmA9883uva+VqJHaJAMVvxrKgv1zQe7sqefrlEulHrFsyD8t0mXGmAiqGiMXXYYeLWWTLnrexKuRjtftitXXjJL22NOG2DbEsdjcQV++lwR2b3rZGTFMMkc1sLghk8pEy+AbkVRcM8VIvSM//m1T82XkiGHW3r3rc3N/c+EoraH47XtNPI9GINUE1mJEOMRUeosCbMINcIy+EKcmM5X/HrYuiFdDKAFKgk9K99KCz12xwaEU9DP0OUcgA/BnXB8BYAqK3xbnAtRJLrSQkGesffLyLQ5uuBam+lEE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebfad9d-1693-4d76-3c68-08d8348a22e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 13:11:56.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UnmpXMLmvEYKZyeUmbHSDxdoE1dwg5E1Rxjhch87OlbIddBXM3YzpKlO5lkbCXsamexTNGDOkLqvmfeNlD0T0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2374
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIFBoaWxpcHANCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMy8zXSBwY2k6IGlteDog
U2VsZWN0IFJFU0VUX0lNWDcgYnkgZGVmYXVsdA0KPiANCj4gSGkgQW5zb24sDQo+IA0KPiBPbiBU
aHUsIDIwMjAtMDctMzAgYXQgMDI6MTEgKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEhp
LCBQaGlsaXBwL1JvYg0KPiA+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDMvM10gcGNp
OiBpbXg6IFNlbGVjdCBSRVNFVF9JTVg3IGJ5IGRlZmF1bHQNCj4gPiA+DQo+ID4gPiBPbiBXZWQs
IDIwMjAtMDctMjkgYXQgMDk6MjYgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4gPiBP
biBNb24sIEp1bCAyMCwgMjAyMCBhdCA4OjI2IEFNIEFuc29uIEh1YW5nDQo+IDxBbnNvbi5IdWFu
Z0BueHAuY29tPg0KPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gaS5NWDcgcmVzZXQgZHJpdmVyIG5v
dyBzdXBwb3J0cyBtb2R1bGUgYnVpbGQgYW5kIGl0IGlzIG5vIGxvbmdlcg0KPiA+ID4gPiA+IGJ1
aWx0IGluIGJ5IGRlZmF1bHQsIHNvIGkuTVggUENJIGRyaXZlciBuZWVkcyB0byBzZWxlY3QgaXQN
Cj4gPiA+ID4gPiBleHBsaWNpdGx5IGR1ZSB0byBpdCBpcyBOT1Qgc3VwcG9ydGluZyBsb2FkYWJs
ZSBtb2R1bGUgY3VycmVudGx5Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
QW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gTm8gY2hhbmdlLg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL2R3Yy9LY29uZmlnIHwgMSArDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL0tjb25maWcNCj4gPiA+ID4gPiBpbmRleCAwNDRhMzc2Li5iY2Y2M2NlIDEwMDY0NA0K
PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiA+
ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gPiA+ID4g
QEAgLTkwLDYgKzkwLDcgQEAgY29uZmlnIFBDSV9FWFlOT1MNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ICBjb25maWcgUENJX0lNWDYNCj4gPiA+ID4gPiAgICAgICAgIGJvb2wgIkZyZWVzY2FsZSBpLk1Y
Ni83LzggUENJZSBjb250cm9sbGVyIg0KPiA+ID4gPiA+ICsgICAgICAgc2VsZWN0IFJFU0VUX0lN
WDcNCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyB3aWxsIGJyZWFrIGFzIHNlbGVjdCB3aWxsIG5vdCBj
YXVzZSBhbGwgb2YgUkVTRVRfSU1YNydzDQo+ID4gPiA+IGRlcGVuZGVuY2llcyB0byBiZSBtZXQu
IEl0IGFsc28gZG9lc24ndCBzY2FsZS4gQXJlIHlvdSBnb2luZyB0byBkbw0KPiA+ID4gPiB0aGUg
c2FtZSB0aGluZyBmb3IgY2xvY2tzLCBwaW5jdHJsLCBncGlvLCBldGMuPw0KPiA+ID4gPg0KPiA+
ID4gPiBZb3Ugc2hvdWxkIG1ha2UgdGhlIFBDSSBkcml2ZXIgd29yayBhcyBhIG1vZHVsZS4NCj4g
PiA+DQo+ID4gPiBPaCwgYWxzbyBQQ0lfSU1YNiBpcyB1c2VkIG9uIChzdXJwcmlzZSkgaS5NWDYs
IHdoaWNoIGRvZXNuJ3QgbmVlZA0KPiA+ID4gUkVTRVRfSU1YNyBhdCBhbGwuDQo+ID4gPg0KPiA+
ID4gSG93IGFib3V0IGhpZGluZyB0aGUgUkVTRVRfSU1YNyBvcHRpb24gYW5kIHNldHRpbmcgaXQg
ZGVmYXVsdCB5IGlmDQo+ID4gPiBQQ0lfSU1YNiBpcyBlbmFibGVkLCBhcyBhbiBpbnRlcmltIHNv
bHV0aW9uPw0KPiA+DQo+ID4gTGlrZSBiZWxvdywgUkVTRVRfSU1YNyBpcyBhbHJlYWR5IGRlZmF1
bHQgeSB3aGVuIFNPQ19JTVg3RCwgbm93IGFkZGVkDQo+ID4gUENJX0lNWDYsIGxldCBtZSBrbm93
IGlmIGl0IGlzIE9LIGZvciB5b3UsIHRoZW4gSSB3aWxsIHNlbmQgbmV3IHBhdGNoIGZvcg0KPiBy
ZXZpZXcuDQo+ID4NCj4gPiArKysgYi9kcml2ZXJzL3Jlc2V0L0tjb25maWcNCj4gPiBAQCAtNjgs
NyArNjgsNyBAQCBjb25maWcgUkVTRVRfSU1YNw0KPiA+ICAgICAgICAgdHJpc3RhdGUgImkuTVg3
LzggUmVzZXQgRHJpdmVyIg0KPiANCj4gSSB3YXMgdGhpbmtpbmcgc29tZXRoaW5nIGxpa2UNCj4g
DQo+IAl0cmlzdGF0ZSAiaS5NWDcvOCBSZXNldCBEcml2ZXIiIGlmIENPTVBJTEVfVEVTVCB8fCAh
UENJX0lNWDYNCj4gDQo+ID4gICAgICAgICBkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiA+ICAgICAg
ICAgZGVwZW5kcyBvbiBTT0NfSU1YN0QgfHwgKEFSTTY0ICYmIEFSQ0hfTVhDKSB8fA0KPiBDT01Q
SUxFX1RFU1QNCj4gPiAtICAgICAgIGRlZmF1bHQgeSBpZiBTT0NfSU1YN0QNCj4gPiArICAgICAg
IGRlZmF1bHQgeSBpZiAoU09DX0lNWDdEIHx8IFBDSV9JTVg2KQ0KPiANCj4gWWVzLCBhbHRob3Vn
aCB3aXRob3V0IHRoZSBhYm92ZSBJIHRoaW5rIGl0IGNvdWxkIHN0aWxsIGJlIGRpc2FibGVkIG1h
bnVhbGx5IG9yDQo+IHZpYSBvbGRjb25maWcuDQoNClRoZW4gc2hvdWxkIEkgc2VuZCBhIG5ldyB2
ZXJzaW9uIHdpdGggYmVsb3c/IEFzIHdlIGFscmVhZHkgZGlkIGl0IHRoaXMgd2F5IGZvciBpLk1Y
N0QsDQphZGRpbmcgaXQgZm9yIGkuTVg2IG1ha2VzIG1vcmUgc2Vuc2U/DQoNCisgICAgICAgZGVm
YXVsdCB5IGlmIChTT0NfSU1YN0QgfHwgUENJX0lNWDYpDQoNClRoYW5rcywNCkFuc29uDQoNCg==
