Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1881F6D58
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFKSWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 14:22:12 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:7957 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKSWL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2020 14:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591899730; x=1623435730;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=bHEWGZ17qB78FQWauW/e96EEpjze5BeG437vRJ1kzoY=;
  b=2tBcAYL5uM0hYQTDAP9okhsMz1V+3JHbtpU3Yed97V6ecXd0Kanka3xI
   F5U1fDFGI0qUp5stjz7Kz5hcNK69gYRLZdi12NVEB0unYlLBTPRr27yU8
   Er9AjvOmlhPjvFMoLPr9/gZh7WAFLJo0ixK/CUiw+MFOPLLzA1115XoO0
   CgEnBTl0CjtGHREf/AkCQ5EJwwMJ6JF3u1Eq7ycGRr6OVcGquHkgrqAdI
   JJQS+8rXaU52Ft32MNjrHYRcrPGJmv9WzRU9LhGJbTYGW4ba6MvXxzQVp
   7zhiSos5cPbGTQz84SnzZmPCi2nbrSEo06/ycHqpo4bdlNWiIYS04QbS3
   g==;
IronPort-SDR: Crbf96qHEXwiUxLnURtXAxiEqJH/bFtlebZ+vrk4BsepKorTXuISwAQoxSNAAS1UzZZZjU/J1J
 PRVkYvSWkBefm7hDNGM6YaDq8Vp6BDNoTqD2+iPqtxbzLY+E9vfXwf15QSkdgyFu5/9wVkKCNS
 qvq4rCH6l/LWDaZ9FQxWodlu66Iw05yyk0ABr7cn/jH37IFpWWZ9kV+DH4CMJMg5tq5XwZbPq+
 LxAeVkGEPxYjiF7nIISybJcXjRvY0CZhS0uZmtR6eqaOBEvhD3zROznkxmcn0UDVzLxUi9KPmo
 bLg=
X-IronPort-AV: E=Sophos;i="5.73,500,1583218800"; 
   d="scan'208";a="83208457"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jun 2020 11:22:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 11 Jun 2020 11:22:10 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 11 Jun 2020 11:22:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTEU85GZlhLssP+2k/9hTep93cEV6yaRNxoYG0UzNLLbqYGZ9XiPElnIt76VZXIr9mCASNNQ5naDUdhK5qD/6SnWZhQdzYiaxs2uK58Uzh5BDpOF3iLbK5e3Wc2qxPGPFKemEvnQ2pWK+geCxHYGSKJLiDBNyAJvzzTPw9DI07g9x3j8GfjH5mLBBbCJeMxKI5YQvKMtNb5twHRZX2e50GfQ6UbHQ7Pd351eRetsd+Lr2ZYxv3nGVx0ylrdh1yilBkkP09NH1XKdi+EaXZWcUJli+H/AMmgsOYBU5BconeK5hpRKkpJQ/Fn362OzKmdkzBqi8avXNVOEyVwQcTDwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHEWGZ17qB78FQWauW/e96EEpjze5BeG437vRJ1kzoY=;
 b=mPllFKYeGoc2Nl90F1nVDHJePqh7AdWvD/STVVM3RPQe5DO1nM3n5utD3TJ3LKLm+rz7ETZ0D+HsjN0f2HQOvqYi1AaPPW0ua8k4bz7oIPGZqsGv+yRgMIF2DUTaF42YSXMNTidqBOoPpPD56J3i3yu++a62c/PnyeTs0dEDkDlYBRxyhfSsQdp9kYpspnpoTZcUPl++BMpd98iRWpl5TJukl+Mi1RP5k7Jsn8GLulk/tA9wO3zhId+vBbQVat/eshQzaPL8fbkTEOMfRjC6POlwlJDaBVWSN3Mv2MjcFMv95SlR/A4KYP3dGZjVCMW1/2LYclbgob7uNA60zQcd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHEWGZ17qB78FQWauW/e96EEpjze5BeG437vRJ1kzoY=;
 b=ZbYlX4OF1iNpTJBNuD1wxBHjGDC/hBpQ93RfDYD60IDTVZr6CJO49HI71YA+iITcOF+FB8f385LWWndhNDOjQSw63SLxKa9kRiOMLMlaQF+DRa1wyCLSNmCLphcLtxFA/p2FhVbRDMOdZ4oMvK57GfqxoOL5XNa9fjQNkC5FqYU=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Thu, 11 Jun
 2020 18:22:09 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 18:22:09 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v11 0/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v11 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWQB04zKeJ4gqmeESrAQR3OtfdiQ==
Date:   Thu, 11 Jun 2020 18:22:09 +0000
Message-ID: <5e5d922b07c413b5cb482d63f0a13dd521e7b59f.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a9ff7e6-4905-4e8e-ce63-08d80e345a9c
x-ms-traffictypediagnostic: MN2PR11MB4630:
x-microsoft-antispam-prvs: <MN2PR11MB4630E70484648F40F7D4D23496800@MN2PR11MB4630.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrX+pgt0upUCtoG5r62yEt1Lr8Lg812gdryuFGUXsLwsKggP2GhsgDspmoyfdzpOxBej+yQRMBq2WbN9V9PVd066eK1+eGLr4rbaRxMYZZ3YNcGCz/YqYt0URKAX+wtwdrKrCAYDLkDH+ApN+ysIGdj9Vczr9kCDYLjaj34lkCvth2wSLfE6f679aE5hZQ2oJexj1TFVTYAdkQW7owufmnC1pZ+bfIMVFiofP34I1ajhoIMxDrSjg/T6docsvTlQ5FwXAzk9GxLBSlbB9U+fNeeaR1f2ZdymfLIi+aK+QxvHPfMYCG293+uH1Nd4OCWh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(110136005)(86362001)(2616005)(6486002)(83380400001)(316002)(478600001)(66556008)(66476007)(2906002)(71200400001)(6512007)(64756008)(66946007)(8676002)(66446008)(91956017)(6506007)(76116006)(8936002)(26005)(5660300002)(36756003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zczGlaD0KwB/rR61cJcxIKRT71T7tNDJ1LqVq+wQ5JyAPShA3Aa51Xy7MXpXRDTOHmrxaVHk5niepaFZn1wdKdlWkZcYEWV4FuVnpyiUkQJ4vuoYeYg+Ge8Vrp8+Ghg7OT5Nq+gPfK6QJ9FMaPEXXG867TMP3JeoCsLMnlWshxa1sYzXTBtRY6Z7wTHtJUoBw7KkuRM1Cii/I6Ch/zwZXJ8dJ7cohhTYrIxq5mmwU34PB7PN8za5w2qNsVPGyqQhmVGueM1asGN9ptEBZCeLwdNj/BjsfStngXpjG/p3F6naQP43pqlD1RwYuu9iAKMFc1KAco5bSZNWlymInFXH1CxTJzYAKS2Ts4aerfZgSMTmmxhadSgIZ15qJwRt/6f9+IOxyH9B2AujKyYBJGCjr4qqaP2cKF639UQm+l/TrxcCA0E6vygPPA3lSfN45oR+SHhlF5ldF8Rza6+3YlUueEvrRNDaB/idNoz+t+/xdApluCfum1fBthZe4u5Gvx21
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30860A71F4028145BE6B3A38426CF3E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9ff7e6-4905-4e8e-ce63-08d80e345a9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 18:22:09.3129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M5OYpiya3v9MU30RS3C+51LP93EdgHkrCy0XGEX/2B9MooJLQ7YDWEz9aIarki9su2Fgz6ZvxY8+ffFrdvXBY4/X7lx1VKXdLP0+5c+kcW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpUaGlzIHYxMSBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgUENJZSBQb2xh
ckZpcmUgUENJZQ0KY29udHJvbGxlciB3aGVuIGNvbmZpZ3VyZWQgaW4gaG9zdCAoUm9vdCBDb21w
bGV4KSBtb2RlLg0KDQpVcGRhdGVzIHNpbmNlIHYxMDoNCiogQWRqdXN0ZWQgZHJpdmVyIGFzIHBl
ciBSb2IgSGVycmluZydzIGNvbW1lbnRzLCBub3RhYmx5Og0KICAtIHVzZSBjb21tb24gUENJX01T
SV9GTEFHUyBkZWZpbmVzDQogIC0gcmVkdWNlIHN0b3JhZ2Ugb2YgdW5uZWNlc3NhcnkgdmFycyBp
biBtY19wY2llIHN0cnVjdA0KICAtIHN3aXRjaGVkIHRvIHJlYWQvd3JpdGUgcmVsYXhlZCB2YXJp
YW50cw0KICAtIGV4dGVuZGVkIGxvY2sgaW4gbXNpX2RvbWFpbl9hbGxvYyByb3V0aW5lDQogIC0g
aW1wcm92ZWQgMzJiaXQgc2FmZXR5LCBzd2l0Y2hlZCBmcm9tIGZpbmRfZmlyc3RfYml0KCkgdG8g
aWxvZzIoKQ0KICAtIHJlbW92ZWQgdW5uZWNlc3NhcnkgdHdpZGRsZSBvZiBlQ0FNIGNvbmZpZyBz
cGFjZQ0KDQpVcGRhdGVzIHNpbmNlIHY5Og0KKiBBZGp1c3RlZCBjb21taXQgbG9ncw0KKiBtYWtl
IGR0X2JpbmRpbmdzX2NoZWNrIHBhc3Nlcw0KDQpVcGRhdGVzIHNpbmNlIHY4Og0KKiBSZWZhY3Rv
cmVkIGFzIHBlciBSb2IgSGVycmluZydzIGNvbW1lbnRzOg0KICAtIGJpbmRpbmdzIGluIHNjaGVt
YSBmb3JtYXQNCiAgLSBBZGp1c3RlZCBsaWNlbmNlIHRvIEdQTHYyLjANCiAgLSBSZWZhY3RvcmVk
IGFjY2VzcyB0byBjb25maWcgc3BhY2UgYmV0d2VlbiBkcml2ZXIgYW5kIGNvbW1vbiBlQ0FNIGNv
ZGUNCiAgLSBBZG9wdGVkIHBjaV9ob3N0X3Byb2JlKCkNCiAgLSBNaXNjZWxsYW5vdXMgb3RoZXIg
aW1wcm92ZW1lbnRzDQoNClVwZGF0ZXMgc2luY2Ugdjc6DQoqIEJ1aWxkIGZvciA2NGJpdCBSSVND
ViBhcmNoaXRlY3R1cmUgb25seQ0KDQpVcGRhdGVzIHNpbmNlIHY2Og0KKiBSZWZhY3RvcmVkIHRv
IHVzZSBjb21tb24gZUNBTSBkcml2ZXINCiogVXBkYXRlZCB0byBDT05GSUdfUENJRV9NSUNST0NI
SVBfSE9TVCBldGMNCiogRm9ybWF0dGluZyBpbXByb3ZlbWVudHMNCiogUmVtb3ZlZCBjb2RlIGZv
ciBzZWxlY3Rpb24gYmV0d2VlbiBicmlkZ2UgMCBhbmQgMQ0KDQpVcGRhdGVzIHNpbmNlIHY1Og0K
KiBGaXhlZCBLY29uZmlnIHR5cG8gbm90ZWQgYnkgUmFuZHkgRHVubGFwDQoqIFVwZGF0ZWQgd2l0
aCBjb21tZW50cyBmcm9tIEJqb3JuIEhlbGdhYXMNCg0KVXBkYXRlcyBzaW5jZSB2NDoNCiogRml4
IGNvbXBpbGUgaXNzdWVzLg0KDQpVcGRhdGVzIHNpbmNlIHYzOg0KKiBVcGRhdGUgYWxsIHJlZmVy
ZW5jZXMgdG8gTWljcm9zZW1pIHRvIE1pY3JvY2hpcA0KKiBTZXBhcmF0ZSBNU0kgZnVuY3Rpb25h
bGl0eSBmcm9tIGxlZ2FjeSBQQ0llIGludGVycnVwdCBoYW5kbGluZyBmdW5jdGlvbmFsaXR5DQoN
ClVwZGF0ZXMgc2luY2UgdjI6DQoqIFNwbGl0IG91dCBEVCBiaW5kaW5ncyBhbmQgVmVuZG9yIElE
IHVwZGF0ZXMgaW50byB0aGVpciBvd24gcGF0Y2gNCiAgZnJvbSBQQ0llIGRyaXZlci4NCiogVXBk
YXRlZCBDaGFuZ2UgTG9nDQoNClVwZGF0ZXMgc2luY2UgdjE6DQoqIEluY29ycG9yYXRlIGZlZWRi
YWNrIGZyb20gQmpvcm4gSGVsZ2Fhcw0KDQpEYWlyZSBNY05hbWFyYSAoMik6DQogIFBDSTogbWlj
cm9jaGlwOiBBZGQgaG9zdCBkcml2ZXIgZm9yIE1pY3JvY2hpcCBQQ0llIGNvbnRyb2xsZXINCiAg
UENJOiBtaWNyb2NoaXA6IEFkZCBob3N0IGRyaXZlciBmb3IgTWljcm9jaGlwIFBDSWUgY29udHJv
bGxlcg0KDQogLi4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwgICAgIHwg
IDkzICsrKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8
ICAgOSArDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAgICAgIHwg
ICAxICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYyAgfCA2
ODMgKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA3ODYgaW5zZXJ0aW9ucygr
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KDQoNCmJhc2UtY29tbWl0OiBi
Mjk0ODJmZGU2NDljNzI0NDFkNTQ3OGE0ZWEyYzUyYzU2ZDk3YTVlDQotLSANCjIuMTcuMQ0KDQo=
