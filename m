Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0EC269CA4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 05:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgIODjk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 23:39:40 -0400
Received: from mail-am6eur05on2059.outbound.protection.outlook.com ([40.107.22.59]:23488
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbgIODji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 23:39:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boYqbj51EluemcPuIha5h3J28UeF9v+Q8OXWcT39AyK2waET0QkJ/kOm+Jqdzlunxkc0q+6jzut1B204jOKV0K6AiQjLuLrcIEqa/TPyfEs+3WZCYaPIE6n7sdhGeVRn/oKQ2Qeb0HO/ee8CTeN4Z5EUZez0vQg4jXiLXhxOzyZR0gZzgifCHQoY4MfcDpHKPhcDHJmgNAsfHd6mX+tMkiBP66Gf6R92RiIT9ruFwplS/vBX/LTrSr4BeigXzA5wstwFAMd9295gAJKWZJ9F2Lix5iXljOLi6IX1amk/b3f0t0r+LKSRnYSfeDTCQEr7fLUBMFz2xsRYzCgRxtcT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k88uhHgqxhMlAaryXXH/zo1IXdH0Q20Zx1jQ0ggORB0=;
 b=nGzJbk5kO8hVnknPSLDrueALtynwNjtiEY/enSM2cLiYPBajM0zl0hvln/cXAaY4jhdwpGLB+MsKD+b8xhAxwRarraauZjlKUfezMj2vVZ1Xgy+74BRG8QejYx7nxBpuAQrKQuSADpvjMbYKv678gnMEPXNiYMNvvO2e+h5l7Z0VihaBAunqSXvfpgTjvkMwCirhPNIKZncbNRYf3LinyBD0wC+2xlElBkvLO/pxRr6wnpGt9x4MEz7CAr2UjE6T+b84oDitOD/UleVoCGZl/1v13Q+f8swDyZUSd536rl+JzCkB31YA4ioG5oOaU8N3IZL3qktcZt5RUFuzh9RwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k88uhHgqxhMlAaryXXH/zo1IXdH0Q20Zx1jQ0ggORB0=;
 b=YxVcmbvwMDYkujvVKey5kfR5brchfGeSJH9mEGdMS9TXJqeqQ5qSSrS329US1SD5DZIFagVi4D+pyVpH1L7sAbn/UjslgXaRvi06N5FXvsUz6kB6KGVNRFTb4FuUCztl7wBGDOYhdW7uUik57ABMkWFkqmzJA3KLFhDzbI5Wieo=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR04MB3081.eurprd04.prod.outlook.com (2603:10a6:7:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 03:39:34 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 03:39:34 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH 5/7] dt-bindings: pci: layerscape-pci: Update the
 description of SCFG property
Thread-Topic: [PATCH 5/7] dt-bindings: pci: layerscape-pci: Update the
 description of SCFG property
Thread-Index: AQHWhNow7GLPj4js/k6DpyxHQzXq1Klo9hEAgAAjrhA=
Date:   Tue, 15 Sep 2020 03:39:34 +0000
Message-ID: <HE1PR0402MB33719DC0B6E0DE849ED870FF84200@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-6-Zhiqiang.Hou@nxp.com> <20200915013108.GA668381@bogus>
In-Reply-To: <20200915013108.GA668381@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16dbd8e9-b251-40ff-fbb1-08d85928f6ad
x-ms-traffictypediagnostic: HE1PR04MB3081:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR04MB3081F47FE0E122EABB970B7584200@HE1PR04MB3081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOF4koBnvbrTLs4CB0HmKGBN13cKm5IdumdY4cSCd1YaNX5O6eqCX0jgE8r0bAnPOfNV8W4aAMdI4Vb9G8J1RciNx43CdEeIvKbYYYMGNY5AGC/rTV/zy1VN/dwCIxwwZ5m6laDPpZoMxGfZep/HlxKTbmNX0rfdidEahtghrBGLCMraR3Ad1NOUWD8opdgA0gW6zWVhl8HgHkD27feQXLpib75lgQwk3T2OuL5JvkBn5tS+7JXi/VNvspo5LHVnr/kM6j+p9V40r2FwpX+QQJyVGaLYcbCQutXJGh8qU6ysewQOf5nFOKVXKdX6oQc3oLfEPsNK1i69Omh9+IlXfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(5660300002)(71200400001)(316002)(54906003)(4326008)(33656002)(9686003)(4744005)(55016002)(83380400001)(52536014)(8936002)(66476007)(66946007)(76116006)(53546011)(8676002)(86362001)(15650500001)(66556008)(7696005)(26005)(478600001)(64756008)(186003)(66446008)(6506007)(6916009)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: guF54ZmE9kAUmOfxMrLL8Yelivn57DJS/UiUCvK64sjl7G2DxHTvIKNfaVS8nd1efafiOvwcyJxz0M7k+K1T1lYKAt5NpgLoh4j319tIAntltbUNpKos46DHrBZ8+OFK05U45aipGvDaIwQnycF/I3ZDTFdaK+atJ/BqJA4r8otncvFxAXSskvqyJdSE8bDRXHQF3+i5QILFPVYqolc5v1iLbkaSoU0zb7daLZu5i8/iqZ2zsL1Z/aPT3d8obLWVth4JS5TSKJf99pbnxs5Kjaw47Aq0r7gYMFnKK7n03CEKcmVCmcgCJPMXNYJxsyLqy2c9nbJmre+Xh+jl13YsH2HzFy/C9XhuqHaj4BGiX3IlYBga6dAMgKod7/6SisCUAbmPaVJjFlsqT0AwFk+TqeF9UqV0OuejgOB350QNflIhydN8WZ4Ltq9sT05+2yS40WCmf+KlXRwdE8tcLalPCLqksOjllT6jFnVh6kE3SYN4G3BB4KmfdFDkrdREx5x/5nKuP3del+Uun3y6rpemuEDNa+2WZMCpxqzOjWMCmpSQ7T9OuwF6bSWcMJNGrvAp2JTvwQuZVm5wOds2+ITbXUvQnV8VCJ8nkLybojvSuNl3cFwgrkzPoH7ij2RHaNBueryqX/PFOIyDIeF4W4c4cQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16dbd8e9-b251-40ff-fbb1-08d85928f6ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 03:39:34.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VE2DJjkt/++ESDYv7uVnArZ2XeYkcvQYIVC4oesF6j/Wra/FVM9P6bxV05Wdxolbh4qGSkxxr3GYsLUkDVTcIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3081
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IGFuZCBhY2shDQoNClJlZ2Fy
ZHMsDQpaaGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjDE6jnUwjE1yNUgOTozMQ0K
PiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTS5oLiBMaWFuDQo+
IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgTWluZ2th
aSBIdQ0KPiA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+
Ow0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+
IGJoZWxnYWFzQGdvb2dsZS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCA1LzddIGR0LWJpbmRpbmdzOiBwY2k6IGxheWVyc2NhcGUtcGNpOiBVcGRh
dGUgdGhlDQo+IGRlc2NyaXB0aW9uIG9mIFNDRkcgcHJvcGVydHkNCj4gDQo+IE9uIE1vbiwgMDcg
U2VwIDIwMjAgMTM6Mzc6NTkgKzA4MDAsIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBI
b3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVXBkYXRlIHRoZSBk
ZXNjcmlwdGlvbiBvZiB0aGUgc2Vjb25kIGVudHJ5IG9mICdmc2wscGNpZS1zY2ZnJw0KPiA+IHBy
b3BlcnR5LCBhcyB0aGUgTFMxMDQzQSBQQ0llIGNvbnRyb2xsZXIgYWxzbyBoYXMgc29tZSBjb250
cm9sDQo+ID4gcmVnaXN0ZXJzIGluIFNDRkcgYmxvY2ssIHdoaWxlIGl0IGhhcyAzIGNvbnRyb2xs
ZXJzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9sYXllcnNjYXBlLXBjaS50eHQgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+IA0KPiBBY2tlZC1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4NCg==
