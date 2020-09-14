Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D93268DA6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgINO3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:29:35 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56823 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgINO2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600093734; x=1631629734;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=XF1nb8YRTSj0xzwe1U0NMoCwpF6R+tdM26R+Dp/88ek=;
  b=Zmlo7kEGTzNOYKM2tTBk5E8iD9QTHZBHt5uzj1sqdTVFCcfyYIO+ci8F
   UnDyXrcRoBJD0WGlusyd5y+xZ1unYH+GJTM1maISbUGHJMtjIJW8F+L3u
   aBCIElD/qxV6UHffplEm+s7qXKArq1z6bdi6m0PcqktiLfv8R+wuuNkan
   Lluv7F93qyETO4dzLvN3kzfbqfV60eKAYiqmBjbBq8Np7vVLsncg5tDMV
   x7AV3DoPJkpe1btoCwB4BMop/6F7FY5zMNt0JsyqQzUwuuSQO+uHMZKXt
   PoD9+3SghS3HhOHzUkv4Rb1u0c74fc1g1lWAoWvbuXQwkS5DHhtATXaiJ
   g==;
IronPort-SDR: yAZNSRYVyOxePGOuUq2xSVj7hj5CKdZk0edaSSBaRy4lZpbTtnIeKhQXAms54y0u9mkZDqDDF9
 Wk9Y8u8yXIbac+ctX9mKKu8uxY0SbNeN2Fq1ER2EEnTBcnyVBstu3OHqcjSzxfDZ4Vp3lqT8NR
 RWlWrDwgn2x/FqCSznhaAA+Tsy9045mYm6yrEzhAQItlSvi9c0DileUI1YSNsg7SuvDNpc4sxQ
 RBAoD+fP16Ktiz9jU1Zii7jDrS27eXtbIJG3+Phmux9NKNUKXNgKwnNnFgxbgfHbSkm+mWBrnK
 NSk=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="88995069"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:28:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:28:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 14 Sep 2020 07:28:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcddGnuDuyceK19m60VeSvUYGu6A9tZUnVgF6e4zn4LhXyR2XIg0RxwCakhXrdALreHHdm/+IX/Xnsustj9Y/NR+6uox/MCcy47hPdPpugQrbGqmR4DaG1k9yBMYJrXIFZYKPGOIbYO3EeN3QmFuSMKP1oikCjW8uMAEV4pz+XmfGojAi4NB/IXtzPJ2V1A+RBWxU8hJZrKLr7h+F0bgjeciIalgYqumowdPXlzb0CUQI7oVWoN1uHFZtvmVTdSgoK8HvH+S9yGCdPiWKfyMTuPHw/TdOSli6Shglv3ArQ/M24D09Fga6s3kVlq4sTfV2p2o6FvOdzy424MfvsZBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF1nb8YRTSj0xzwe1U0NMoCwpF6R+tdM26R+Dp/88ek=;
 b=bFTk4ewmlXw/3a0t/hHQOWrm4Cy0BIq2b9t2FRgyjsLZxx2puF0j2ewUgCKjkbPIB0B56Cu+vbfBXJ5EGF/V8pSu0PI5H0Vs55mO8snB5/botlAS04HqHh1qDF/uqX8v5ol6ffwwFYJKQVabvMtXoOLP8GDuz5NGmpagweV2TqVqKMhGeSNNTvhNc95zCD8ZqdtmSdyRxgo9oMsRJSQJNanDR92H2qpDcMcCQhynQvLPNVc6L6DMNEY6eioZHEf9KZC7Nbx/npu1pWeR7AQmc9O0UuGnUADLNvbNNwJ78mZeAQJnN1TcjP8lWPfRWHDLxde94DOtE+HFROqwPIyawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XF1nb8YRTSj0xzwe1U0NMoCwpF6R+tdM26R+Dp/88ek=;
 b=iAaoLTXZZlr2W6x/IPu/U8ZWaF69HPmyjapU0WOt5aPvahysWOExP3nARbxlL5KLXMConvkH/oRVXkFmdZGnCwsHVu89rwWLywbit7to5pmluIROTa5Bco5ebT1R+YCM9gnEHtiw/tCPoYPwvtbJn1FNWiF6ekxati3ey8x8H74=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:28:50 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::38d4:de41:43a4:4642]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::38d4:de41:43a4:4642%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:28:50 +0000
From:   <Daire.McNamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <Daire.McNamara@microchip.com>
Subject: [PATCH v16 0/3] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v16 0/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWiqNdYqcOm0u3eUqEAybR3sCfZg==
Date:   Mon, 14 Sep 2020 14:28:50 +0000
Message-ID: <6bd2bce1-1241-e2e1-cab7-c48813584248@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [88.87.191.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8eb5876-e510-4bf4-a78c-08d858ba8005
x-ms-traffictypediagnostic: MN2PR11MB4630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB46307DFE2F79345F5DE9BDCA96230@MN2PR11MB4630.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYs6IubEUdfymfb3/QX7j/ov4q3Knrj8pACyxpey6BQh6Kt+vYOMHRX07ao0NgTPGto4oNU6MsjHy0uZZN5T0CFfbPwdmZ9wXQ7axl54ShTkxImS0HweKQYaQ1LSDFwwPUrhYZyhHQLoKMDhgoXLVclUp8xIeBj3cXCj5pkO4n0RIvD7quVin9T2K+Nm9TePdx8ylWnoN5F+8bm8PqpoGiSZ7MpzotNcoiqe+Bt35jIF2AsftN0+rt4DCfB8WTOF95FjS42oJXDM9TWxWabLwEH2X9JtlwIoctqZ6Txj2Fi3wCe6oSBvFXa3SOxT/PBMlWaVbX3dQOJlu/Lt7ZhMIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(8936002)(71200400001)(76116006)(2906002)(91956017)(6512007)(110136005)(6486002)(31696002)(26005)(186003)(86362001)(36756003)(478600001)(31686004)(6506007)(66476007)(4326008)(316002)(83380400001)(54906003)(66446008)(64756008)(8676002)(107886003)(66556008)(5660300002)(2616005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: F+JaICPUrQuP2NTi85Fka+Cpk7qIb2RhJt+rQgI8RCu7CvFqMBkW29yTTnzFXhXEYn0j2KmfJUatok08PvYHqIUtwVvcfI++I7FxI0LiVP+klwyNXuG7JHr2/tFnunhhQH//NtiHHM5Mx3SvEXRhJK8gYOCGTXdXOkEHf3c1c1iSzf4A8Slei9fGeDz5qYK7vffytbqUMlQ9tt6NkoE6baA6cX0axVDl3JtxkWs8oUKayscxiT/RSzz43BzQV88JqLRFRlkbdCOEE7d3hsDZe4wREVws/zsB0bV6GWi7Zv/pPnzmzn+wrN2zciU4FMTMVxHJ6D16gZEdgQ4LCuyI0NHYMCavlydfXdjjZAKS/p5uBGx6YicKuA8MonCy5Cr5QSD5QhDLtvLnnQaBWptBDmXAfe3AOEKE32ELFu/2aT+uV8/ztou6C0C9X3FmmVOYPdGviYwsKM7UFllzPuVa8fSBUmzQwekjyCNuR8HIx0wHf+mzNRdjKtpOO5rXiniMPoNkaprUAC2kgn/hsw5L96WgeTzeQ7lpqcK1LYGaZEWmTzVg956tG0lmcEgR0MXSRcZFCeIv1ybjbGORWmH1dHA2m+zg11Em+La9RVeju9jDlBRjjG7zFPLdW+gwnueaPsBemjb9lwux7BK/RoXX5Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A7E886C77585E408106DAE32E799A0D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8eb5876-e510-4bf4-a78c-08d858ba8005
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 14:28:50.6431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8QFp8w8IxBLO/sGNdUXbnh47Fiqj62Uy53gA3dV46DpsFmI8CswHe+pikucirQscrX0SjT9gbR1D37v8j0DHdVsFgD0c27yfbUz5tHJUZNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIE1pY3JvY2hpcCBQQ0llIFBvbGFy
RmlyZSBQQ0llDQpjb250cm9sbGVyIHdoZW4gY29uZmlndXJlZCBpbiBob3N0IChSb290IENvbXBs
ZXgpIG1vZGUuDQoNClVwZGF0ZXMgc2luY2UgdjE1Og0KKiBDYWxsIHBsYXRmb3JtX3NldF9kcnZk
YXRhIGVhcmxpZXIgaW4gZGV2bV9wY2lfYWxsb2NfaG9zdF9icmlkZ2UoKQ0KKiBVc2UgaG9zdF9j
b21tb25fcHJvYmUoKSBhbmQgYW4gaW5pdCBmdW5jdGlvbiB0byBzZXQgdXAgaHcgd2luZG93cw0K
KiBzdGF0dXMgaXMgdTMyIGluIG1jX3BjaWVfaXNyKCkNCiogUmVtb3ZlZCBtYXNrIHZhciBpbiBt
Y19tYXNrX2ludHhfaXJxKCksIG1jX3VubWFza19pbnR4X2lycSgpDQoqIGlycSB2YXIgaXMgbm93
IHNpZ25lZCBpbiBtY19wbGF0Zm9ybV9pbml0KCkNCg0KVXBkYXRlcyBzaW5jZSB2MTQ6DQoqIFJl
bW92ZWQgY2ZnX3JlYWQvY2ZnX3dyaXRlIGlubGluZSBmdW5jdGlvbnMNCiogVXBkYXRlZCB0byBp
cnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YSgpDQoqIFVwZGF0ZWQgdG8gdXNlIGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZSgpDQoqIFJlcGxhY2VkIG9mX3BjaV9yYW5nZSBwYXJzaW5nIHRv
IHNldHVwIHdpbmRvd3MgdmlhIGJyaWRnZSBwb2ludGVyLg0KDQpVcGRhdGVzIHNpbmNlIHYxMzoN
CiogUmVmYWN0b3JlZCB0byB1c2UgcGNpX2hvc3RfY29tbW9uX3Byb2JlKCkNCg0KVXBkYXRlcyBz
aW5jZSB2MTI6DQoqIENhcGl0YWxpc2VkIGNvbW1pdCBtZXNzYWdlcy4gIFVzZSBzcGVjaWZpYyBz
dWJqZWN0IGxpbmUgZm9yIGR0LWJpbmRpbmdzDQoNClVwZGF0ZXMgc2luY2UgdjExOg0KKiBBZGp1
c3RlZCBzbyB5YW1sIGZpbGUgcGFzc3NlcyBtYWtlIGR0X2JpbmRpbmdfY2hlY2sNCg0KVXBkYXRl
cyBzaW5jZSB2MTA6DQoqIEFkanVzdGVkIGRyaXZlciBhcyBwZXIgUm9iIEhlcnJpbmcncyBjb21t
ZW50cywgbm90YWJseToNCiAgLSB1c2UgY29tbW9uIFBDSV9NU0lfRkxBR1MgZGVmaW5lcw0KICAt
IHJlZHVjZSBzdG9yYWdlIG9mIHVubmVjZXNzYXJ5IHZhcnMgaW4gbWNfcGNpZSBzdHJ1Y3QNCiAg
LSBzd2l0Y2hlZCB0byByZWFkL3dyaXRlIHJlbGF4ZWQgdmFyaWFudHMNCiAgLSBleHRlbmRlZCBs
b2NrIGluIG1zaV9kb21haW5fYWxsb2Mgcm91dGluZQ0KICAtIGltcHJvdmVkIDMyYml0IHNhZmV0
eSwgc3dpdGNoZWQgZnJvbSBmaW5kX2ZpcnN0X2JpdCgpIHRvIGlsb2cyKCkNCiAgLSByZW1vdmVk
IHVubmVjZXNzYXJ5IHR3aWRkbGUgb2YgZUNBTSBjb25maWcgc3BhY2UNCg0KVXBkYXRlcyBzaW5j
ZSB2OToNCiogQWRqdXN0ZWQgY29tbWl0IGxvZ3MNCiogbWFrZSBkdF9iaW5kaW5nc19jaGVjayBw
YXNzZXMNCg0KVXBkYXRlcyBzaW5jZSB2ODoNCiogUmVmYWN0b3JlZCBhcyBwZXIgUm9iIEhlcnJp
bmcncyBjb21tZW50czoNCiAgLSBiaW5kaW5ncyBpbiBzY2hlbWEgZm9ybWF0DQogIC0gQWRqdXN0
ZWQgbGljZW5jZSB0byBHUEx2Mi4wDQogIC0gUmVmYWN0b3JlZCBhY2Nlc3MgdG8gY29uZmlnIHNw
YWNlIGJldHdlZW4gZHJpdmVyIGFuZCBjb21tb24gZUNBTSBjb2RlDQogIC0gQWRvcHRlZCBwY2lf
aG9zdF9wcm9iZSgpDQogIC0gTWlzY2VsbGFub3VzIG90aGVyIGltcHJvdmVtZW50cw0KDQpVcGRh
dGVzIHNpbmNlIHY3Og0KKiBCdWlsZCBmb3IgNjRiaXQgUklTQ1YgYXJjaGl0ZWN0dXJlIG9ubHkN
Cg0KVXBkYXRlcyBzaW5jZSB2NjoNCiogUmVmYWN0b3JlZCB0byB1c2UgY29tbW9uIGVDQU0gZHJp
dmVyDQoqIFVwZGF0ZWQgdG8gQ09ORklHX1BDSUVfTUlDUk9DSElQX0hPU1QgZXRjDQoqIEZvcm1h
dHRpbmcgaW1wcm92ZW1lbnRzDQoqIFJlbW92ZWQgY29kZSBmb3Igc2VsZWN0aW9uIGJldHdlZW4g
YnJpZGdlIDAgYW5kIDENCg0KVXBkYXRlcyBzaW5jZSB2NToNCiogRml4ZWQgS2NvbmZpZyB0eXBv
IG5vdGVkIGJ5IFJhbmR5IER1bmxhcA0KKiBVcGRhdGVkIHdpdGggY29tbWVudHMgZnJvbSBCam9y
biBIZWxnYWFzDQoNClVwZGF0ZXMgc2luY2UgdjQ6DQoqIEZpeCBjb21waWxlIGlzc3Vlcy4NCg0K
VXBkYXRlcyBzaW5jZSB2MzoNCiogVXBkYXRlIGFsbCByZWZlcmVuY2VzIHRvIE1pY3Jvc2VtaSB0
byBNaWNyb2NoaXANCiogU2VwYXJhdGUgTVNJIGZ1bmN0aW9uYWxpdHkgZnJvbSBsZWdhY3kgUENJ
ZSBpbnRlcnJ1cHQgaGFuZGxpbmcgZnVuY3Rpb25hbGl0eQ0KDQpVcGRhdGVzIHNpbmNlIHYyOg0K
KiBTcGxpdCBvdXQgRFQgYmluZGluZ3MgYW5kIFZlbmRvciBJRCB1cGRhdGVzIGludG8gdGhlaXIg
b3duIHBhdGNoDQogIGZyb20gUENJZSBkcml2ZXIuDQoqIFVwZGF0ZWQgQ2hhbmdlIExvZw0KDQpV
cGRhdGVzIHNpbmNlIHYxOg0KKiBJbmNvcnBvcmF0ZSBmZWVkYmFjayBmcm9tIEJqb3JuIEhlbGdh
YXMNCg0KRGFpcmUgTWNOYW1hcmEgKDIpOg0KICBkdC1iaW5kaW5nczogUENJOiBtaWNyb2NoaXA6
IEFkZCBNaWNyb2NoaXAgUG9sYXJGaXJlIGhvc3QgYmluZGluZw0KICBQQ0k6IG1pY3JvY2hpcDog
QWRkIGhvc3QgZHJpdmVyIGZvciBNaWNyb2NoaXAgUENJZSBjb250cm9sbGVyDQoNCkRhaXJlIE1j
TmFtYXJhICgzKToNCiAgUENJOiBDYWxsIHBsYXRmb3JtX3NldF9kcnZkYXRhIGVhcmxpZXIgaW4g
ZGV2bV9wY2lfYWxsb2NfaG9zdF9icmlkZ2UNCiAgZHQtYmluZGluZ3M6IFBDSTogbWljcm9jaGlw
OiBBZGQgTWljcm9jaGlwIFBvbGFyRmlyZSBob3N0IGJpbmRpbmcNCiAgUENJOiBtaWNyb2NoaXA6
IEFkZCBob3N0IGRyaXZlciBmb3IgTWljcm9jaGlwIFBDSWUgY29udHJvbGxlcg0KDQogLi4uL2Jp
bmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwgICAgIHwgIDkzICsrKw0KIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgOSArDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5jICAgICAgfCAgIDQgKy0NCiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYyAgfCA1NDEgKysrKysrKysrKysr
KysrKysrDQogNSBmaWxlcyBjaGFuZ2VkLCA2NDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCg0KDQpiYXNlLWNvbW1pdDog
N2ZlMTAwOTZjMTUwOGM3ZjAzM2QzNGQwNzQxODA5ZjhlZWNjMWVkNA0KcHJlcmVxdWlzaXRlLXBh
dGNoLWlkOiBiOThhYmMxYWQ0MTI2OTJhOTVlM2ViM2Y3YWRmYWZmMjE0NzUwMjgyDQpwcmVyZXF1
aXNpdGUtcGF0Y2gtaWQ6IGI3N2Y0ZWVhNDA5MDMwNGI1YzExM2U0Y2NjMjllNjRmYzgyY2RjNDUN
Ci0tIA0KMi4yNS4xDQoNCg==
