Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99518272E2F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 18:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgIUQq5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 12:46:57 -0400
Received: from mail-eopbgr60048.outbound.protection.outlook.com ([40.107.6.48]:39893
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729753AbgIUQqz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 12:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=manWlXs8WX3U9Bws5IhZpMbYH5WSWHrLXLN3sm4hzeQBsj/8QUOihLZgDN2scj5q89sVdboxhaCwlgBbfDCkoQLy25jbvJgOGPg1trNdj00hB90k6J2KIP6no5H5Q6Xuw0mUNGbfqMYTvfcKCWSGDTo4Qrwq7e6FGBCPrwITdTSZw3YdYWsxdedzTmToRapWiZBZhzqo2SJoHfhaJ1nYfKJm5eB4QGybOCaetRZNGETLfn2UPQBBSGPXxrm/zQyRIK7sCWK66soDZAmawd6myPKPwkInQnqnbmhNyGCUlg/RDkvHxKQ6l4hC09Q+WNlKuxnOFzGkf4/LuEpMbjrQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqkgC9i1xJeqEt3NBneZEd2oaJwOIXsUpk6dKUuYqQU=;
 b=Fy6z66bHLaEzijwFlHMO+DzIiw/pmXZoGaSUapBW5WVHTRqCjsL7+MvvLnWckQ/JrVYJtqeS0HTLV+Y589GeCfGq2TyT4yh2oD5CEt1QJyrGi5ZzXkHMfMcA3RTLIEzIQzmMSpbPhi0FlvD//KAg6OV+ZxsBYcQ43NYm2XQOoc91CeyGGFLS0LGF7WX0iH+xsUr4LLh37cuJH2lNH48WyiZISylIZ9B9TG/Ly/xUmYtdgpVkpeM63feBCQO5R56SbCBBoF1jYzPcB0LAHmxg29HOgL0opd6qLfC9Jy08A/yTpUI03rvqS/GWzNS+mvzRkmCK8GX1MLf7xRblrN/19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqkgC9i1xJeqEt3NBneZEd2oaJwOIXsUpk6dKUuYqQU=;
 b=bA1A2icwn+0MT2z89SDGoEu9iV/UMeHqLPC8m6oNQPO9WaRh5aecJTRAmZxa+ty6a2dtUK3TzSQjY4EtBLBu5OkqSAjrFEe+u424n29bu/DyM9hMC2b3ltWZdsA8u/ejxTahVwXQnGpfH8UxBdEzFHyIrXf4X8TK6wU0ICxzNYc=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2553.eurprd04.prod.outlook.com (2603:10a6:3:83::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 16:46:50 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 16:46:50 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>
Subject: RE: [PATCH 6/7] dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
Thread-Topic: [PATCH 6/7] dts: arm64: ls1043a: Add SCFG phandle for PCIe nodes
Thread-Index: AQHWhNowN+e9xxoQB0q+grgB9hqReqlzKTaAgAA6GRA=
Date:   Mon, 21 Sep 2020 16:46:50 +0000
Message-ID: <HE1PR0402MB3371932AF9B98759D096B65B843A0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-7-Zhiqiang.Hou@nxp.com> <20200921131646.GC25428@dragon>
In-Reply-To: <20200921131646.GC25428@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98964309-6d66-450c-7737-08d85e4df02c
x-ms-traffictypediagnostic: HE1PR0401MB2553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0401MB25532C6540CD9965478A06DE843A0@HE1PR0401MB2553.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xlXgsQg/g97ftNNNgI5aXG1nqOWh/IoHFsc6lobuwDkClUSrffP9NjegL5asCxYEnuyK0I4AFYySepPxX1sylLow/GvZ6FXe0PKnkUDyOm1Asmyf2Cn1cwBXXdBvZIs6H9HDnmPLBAOEIkDzqss81jZc/99tOAbkX9VDPvVe3bhQD5Gs+xToLS1MKsz6jV3y0ziWkTSXo4f6Uf+1eDRyx2kiWl7uRwVEAUtSAXffsWXGx6wRrqumj5d4RAqVCYiwm5yp57vzA69upMh6CoPXrcWq3yLRJ+vcaH1+xvwV4MoX9jtBc2I1I24tMvf8gJwBIhhXkIbZ4UAKKh1gKccwdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(53546011)(2906002)(6506007)(54906003)(55016002)(83380400001)(7696005)(4744005)(9686003)(26005)(52536014)(316002)(76116006)(66446008)(66476007)(186003)(66946007)(8936002)(5660300002)(86362001)(478600001)(71200400001)(66556008)(8676002)(64756008)(6916009)(4326008)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GWVm2uoGhR+yjUUhVa37z3U13zt7swZ+jsWS49XSqTzaLyosaXDy90iQnxE5egac9io0giPWC3dmZPf0TQQMARv1TueuO+OG0r/w87TqdYPdbRDz7UiHGaj/H1hTZpNaPflvjKb6VKVszT5gFIE8JlhfQOkmyTrts1q6ozh/hseqLoaWEQeY8QDcA/Ug7NfyEUUXcoxVQdfktNJhbswfVWSPnqZg9/+iO7A7Gp8zSZvslIPKZ+k1juu3mmqxieLe5jrUrPrCL9xUV/jIFjNABkyvR56UEZXYxeISCGM2gjvsw8vfAYuz0W8mTB2GLJsVwUmqIZZWG131tGH95H3R03lJfMkfb7ZjWGAGoih0LJPYR0/AQrI5EJDgJ87IdUULGcyW8x8Do7TpCQVek0UqFCghWhJR4UshASotAF3EZMhfADa6+IlheWnPbh7uf0YFCg2kgG3g72W9aAwS3fXW2K1yLuFt6PMNuz4fGulKkaQqm1QTNVQhA65JixTW7oQg80Swz2p4EwUekGV5+6tq+9/At1+JeaiTbLZ3Pty+stQLCf2/X8iev7Rl3REiylwjgtWzQsoBq8t2lPKEe9a4QqZ5r+GEB78fuy/qH8R01H8iBSAtlUPvy24SSJDhSot5db4LTmFAfrdc49H7AFWZdw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98964309-6d66-450c-7737-08d85e4df02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 16:46:50.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PqD49uIYCfxPyNQpGEXmP+bT8X7+8xGBbgX00Zn/zI2USWf6rgnuGtAYYEa1UtC07rEmOsyjeUxWpst+t23AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2553
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU2hhd24sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+IFNlbnQ6IDIwMjDE6jnUwjIxyNUgMjE6MTcNCj4gVG86IFoucS4gSG91IDx6aGlxaWFu
Zy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IExlbyBMaSA8bGVveWFuZy5s
aUBueHAuY29tPjsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gZ3VzdGF2by5waW1lbnRl
bEBzeW5vcHN5cy5jb207IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsNCj4gTWlu
Z2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNi83XSBkdHM6IGFybTY0OiBsczEwNDNhOiBBZGQgU0NG
RyBwaGFuZGxlIGZvciBQQ0llDQo+IG5vZGVzDQo+IA0KPiBPbiBNb24sIFNlcCAwNywgMjAyMCBh
dCAwMTozODowMFBNICswODAwLCBaaGlxaWFuZyBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91IFpo
aXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0KPiA+IFRoZSBMUzEwNDNBIFBDSWUg
Y29udHJvbGxlciBoYXMgc29tZSBjb250cm9sIHJlZ2lzdGVycyBpbiBTQ0ZHIGJsb2NrLA0KPiA+
IHNvIGFkZCB0aGUgU0NGRyBwaGFuZGxlIGZvciBlYWNoIFBDSWUgY29udHJvbGxlciBEVCBub2Rl
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhw
LmNvbT4NCj4gDQo+ICdhcm02NDogZHRzOiAuLi4nIGZvciBzdWJqZWN0IHByZWZpeC4NCg0KV2ls
bCBjb3JyZWN0IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KUmVnYXJkcywNClpoaXFpYW5nDQoNCj4g
DQo+IFNoYXduDQo=
