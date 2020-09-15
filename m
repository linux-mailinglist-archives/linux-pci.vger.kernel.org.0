Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F763269E5E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Sep 2020 08:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgIOGWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 02:22:19 -0400
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:65346
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbgIOGWQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 02:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhQXhreAam5xcAuSxTzRwk4ncAu72mNvpmbbfz1LQ77N0g6NwshEbTi8G1uNxljZ4ElzSncz/qFtmFFkD5mgaAtVBPDIJRnZSLlYDMcLNpUzjKpo9Ol2mlMUTUJUk4Eni/RocjTsFgYgHty2KwN6TwZaapgs6VwUsFevLKUg58iY6l0cM5JwFLjlXFZTXXUFa8Rb+5urg/cRHG7nENnPYE80VEuePUAndmWmLCiSPY/dzAbKTp3hngFuJrNlkUTLr1GcltSwzUKyUqHYpYsiCX83b5GIok/kluXjNEVySK/l4m9Q6mx+/J7ieiepdSHvRdg0EfFVtVPY1wAk8LrhOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXeU/0VsJkIBmEBhrVtJJMC7t0T5f/DOI7CKH4RQkxc=;
 b=WaXGCL5NMVODBx9a7AgB4gAtfsamNm02kKJsu7Dw+gpPpNvDf95WUgo6prcOCOK9t9chyU9c3p6mYNISYZpl6Ku/usNudmMK/2wZEjYnZA3BEkX1L/njBJOrTufqmI+IdgGkfaowK+Errikx5u7RPVa6srAiYA0505H/OxB8EkUZxVER25C/KWGTHZ/s1PldmErFxpdNuswEH5WrVFY7yfGdRRenP2H6OZN3KosfI8hCBVmimpIKiwj8IXNSbciLhuMK8nCW9DP6nltNCa2t08lEkKNnKv8FU+ZpvCXxUGmEz4wM0P6g9SAZwM6DPhzFoUODjDpclXMe3Yua+Ky30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXeU/0VsJkIBmEBhrVtJJMC7t0T5f/DOI7CKH4RQkxc=;
 b=oHuE0uI2crsKc9Hhswkf8Bj5Vum7o4aRxjbGihwq3DJaLf5PQAj88QDiVrIHPIix0wRSA30dFsg6dZK/WXXfLjaXEpFphMvIP472YPy7SyXdbf9C/APOJm3UD2GXMwEfmHeYzOIyBNtYMn+ZhTu7erxFWHpJ6fSUXU976Opcmew=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3513.eurprd04.prod.outlook.com (2603:10a6:7:87::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.19; Tue, 15 Sep
 2020 06:22:10 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 06:22:10 +0000
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
Subject: RE: [PATCH 2/7] PCI: layerscape: Change to use the DWC common link-up
 check function
Thread-Topic: [PATCH 2/7] PCI: layerscape: Change to use the DWC common
 link-up check function
Thread-Index: AQHWhNorVJwSS0SST0alZtlNLjNSpKlo8uEAgAAjpSA=
Date:   Tue, 15 Sep 2020 06:22:08 +0000
Message-ID: <HE1PR0402MB3371B5DC2E034A6F59CABB7484200@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
 <20200907053801.22149-3-Zhiqiang.Hou@nxp.com> <20200915011944.GB640859@bogus>
In-Reply-To: <20200915011944.GB640859@bogus>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2c0b3e4-eef0-4a8e-419d-08d8593fad76
x-ms-traffictypediagnostic: HE1PR0402MB3513:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB3513270A297639DE876079DC84200@HE1PR0402MB3513.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvWEKgTem2Y4UbtzEqdR2FrJmh6uGdWebrlBKm4YiVJUhewmkKyx0XWlMZKTdiJnAMEJSmuw/G5FAM6uwXCodOZppMpE04yKgqTW79uNNEPzR7GhWw3C73BlNOvt+L4dFQjSFFYPHLSie5+XV7eRhW/S1AWvGkC+v9csu09sOgBAWM8pli7tzbOOo7UibXka9eBtchd2POhVWjiOrM4FF68248cBlD1NzedRGLnWnLwnfvwi8o1NtwqUldF2BARQdLMEwB8RtNuCDXeAvAx5+eONM+4m2a7EQ6XhDYEaPAmGTI+XWq0MMfMn612XOQo/YCNiP6RUZXUq6m5KVOh0LmWeeow2yg7mqB4jwzeoznYLdZgWyUfSid0ukiSRTHbC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(5660300002)(4326008)(83380400001)(55016002)(478600001)(71200400001)(66476007)(9686003)(64756008)(6506007)(53546011)(66946007)(7696005)(76116006)(8676002)(8936002)(186003)(66446008)(26005)(66556008)(86362001)(2906002)(54906003)(33656002)(6916009)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: V+zXsTCWN/5l0FhkeZLKPiJdg+xkQrWMtAU1P99drpizr5w25QTyv3xNw/bIxbpbMTUl1BknIWElWqdykUgl3cw9akbOJfarRfQrKCgmZUcJYEf3PTuH1MdrStfx+yeXBYU9OVYGRnf5i57AGf1ajYracoHJKi60w8y7E7tFjt+2SH4Ix6pcypn5qNIKQlus5eMks6bUGrMN146947JY3+0XqTBJwxyctevu3N/9zHo1P+oGyWKYRtCRHL+QKr2m9I5len10LF5m/SU9H4qXI7DXnuj7ViUnzxQhvIb+MRNj1ufqb9VjcRZsCAc7OOLwWz1F0n9EEGSowttq62yLCMwEl/mTlns+EivVtFkwwonvqrKjigAs4vY1AwIB80Bv1eH8eh4BtVPaVWzRk0uELHbD8pVIIKA9mA2stoNW2Bkb8EZw9Fg+AGrGSFULU7edln3wydlKpIR/LnK47v+vCg3R2NuvssLVTHfJTjURNVHpN398EldtZ3qQZ3xha1+lgUSM9i+n5tjkU6kh2fc09PQGvsbJa97+t9wbxpW4H9SA1WZSdWSlMchVcKyT6mRDLLxMgbtXIeKDTGRoJuto3tZIbzXiCos4MkpOBjIJVJYFKZ4KzFFF4lqM8lE12LnVUrqoxtOsqocQKwZkjAZlAA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c0b3e4-eef0-4a8e-419d-08d8593fad76
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 06:22:09.8716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBD4iq3cNda0i0XtAFpYUIqZKuivfLR5GfoS+5eTDozYOptedBFAfja/7xUb/gQ5KOQf0z2HYeXv+jX25ne9Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3513
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+
IFNlbnQ6IDIwMjDE6jnUwjE1yNUgOToyMA0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBu
eHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJoZWxnYWFzQGdv
b2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAu
Y29tPjsNCj4gbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgZ3VzdGF2by5waW1lbnRlbEBzeW5v
cHN5cy5jb207IE0uaC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAuY29tPjsgTWluZ2thaSBI
dSA8bWluZ2thaS5odUBueHAuY29tPjsgUm95IFphbmcNCj4gPHJveS56YW5nQG54cC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi83XSBQQ0k6IGxheWVyc2NhcGU6IENoYW5nZSB0byB1c2Ug
dGhlIERXQyBjb21tb24NCj4gbGluay11cCBjaGVjayBmdW5jdGlvbg0KPiANCj4gT24gTW9uLCBT
ZXAgMDcsIDIwMjAgYXQgMDE6Mzc6NTZQTSArMDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+
IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBUaGUg
Y3VycmVudCBMYXllcnNjYXBlIFBDSWUgZHJpdmVyIGRpcmVjdGx5IHVzZXMgdGhlIHBoeXNpY2Fs
IGxheWVyDQo+ID4gTFRTU00gY29kZSB0byBjaGVjayB0aGUgbGluay11cCBzdGF0ZSwgd2hpY2gg
dHJlYXRzIHRoZSA+IEwwIHN0YXRlcyBhcw0KPiA+IGxpbmstdXAuIFRoaXMgaXMgbm90IGNvcnJl
Y3QsIHNpbmNlIHRoZXJlIGlzIG5vdCBleHBsaWNpdCBtYXAgYmV0d2Vlbg0KPiA+IGxpbmstdXAg
c3RhdGUgYW5kIExUU1NNLiBTbyB0aGlzIHBhdGNoIGNoYW5nZXMgdG8gdXNlIHRoZSBEV0MgY29t
bW9uDQo+ID4gbGluay11cCBjaGVjayBmdW5jdGlvbi4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLmMgfCAxNDENCj4gPiArKy0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTMx
IGRlbGV0aW9ucygtKQ0KPiANCj4gSUlSQywgdGhlIGNvbW1vbiBmdW5jdGlvbiB1c2VzIGEgZGVi
dWcgcmVnaXN0ZXIuIEkndmUgYmVlbiB3b25kZXJpbmcgZG8NCj4gdGhlIGNvbW1vbiBQQ0llIGNv
bmZpZyBzcGFjZSByZWdpc3RlcnMgbm90IHdvcmsgb24gRFdDPyBJZiB5b3UgaGF2ZSBhbg0KPiBh
bnN3ZXIsIHRoYXQgd291bGQgYmUgZ3JlYXQgZm9yIHNvbWUgcG90ZW50aWFsIGFkZGl0aW9uYWwg
Y2xlYW51cHMuDQo+IA0KDQpZb3UncmUgcmlnaHQgaXQgdXNlcyBhIHBvcnQgZGVidWcgcmVnaXN0
ZXIsIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhlIExpbmsgc3RhdHVzDQpSZWdpc3RlciBvZiBjb21t
b24gUENJZSBjb25maWcgc3BhY2Ugd29ya3Mgb3Igbm90IG9uIERXQy4NCg0KR3VzdGF2bywgY2Fu
IHlvdSBoZWxwIGFuc3dlciB0aGlzIHF1ZXJ5Pw0KDQpSZWdhcmRzLA0KWmhpcWlhbmcNCg0KPiBF
aXRoZXIgd2F5LA0KPiANCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+DQo=
