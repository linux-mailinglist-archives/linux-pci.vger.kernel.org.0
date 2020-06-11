Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CDC1F6D51
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgFKSRI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 14:17:08 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:39081 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgFKSRI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2020 14:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591899427; x=1623435427;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=bHEWGZ17qB78FQWauW/e96EEpjze5BeG437vRJ1kzoY=;
  b=fklXI7dWFfZ1jjvukKJPpnt4afFPMrjxkuSs1DHgLAGu2beIvttB/s1Q
   D6Qu+5s0WqOPpnnE7AZoKOBF/Eh3seN8u8SYjN5yqbWc6p2ow/qg4OCbM
   Wy2eWRTNB93axIbQcsFcakIQtWUHaszk1fuaXOlTmmOYZpjewx5mKYw/U
   ryCk9wuG5aHyTy878CfIwXEyhzsgN06gXFoJAWCWkJph59IL7TiZ/LX+1
   Vy4QpXxCjPLuMAhd8hMFC2TSnkmH24Dr9DQaURceYmQtzUNjWuecJfEty
   ep9pncYkOUJ4lsaG1+hLBrpRmps9mgqnk6LbRIyg9sDMxxe47dBE4a8vm
   g==;
IronPort-SDR: vbuA/frDkzSEQUeOfzGAJ2QAX9hjrKdHtd5elwL6R+7Vv7c699AmwX5vwa8ccuREq30JF3G/c+
 CMfEixDeaif+nsQPXwsW5nIA45/xyAjzwd0Wn6WdmMQH10orygdHSS+w4nWoFDmQnEco0bdAEA
 3oW6G2Rgw+C1Ffy68knPUKNfHnsW3fluqE43IE2qaVMVLRl+CvNlYTkFt9+6osVA3yYbua0R07
 5lnNaNvxq4Vo39K23XPGb843ZKWprRQMqGlCY+s5BAFKKMFlDJajpGZ7pl2pshbRAZBYCKONgI
 IlQ=
X-IronPort-AV: E=Sophos;i="5.73,500,1583218800"; 
   d="scan'208";a="79774029"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jun 2020 11:17:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 11 Jun 2020 11:17:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 11 Jun 2020 11:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbc3I0NuuQkD8X16umWR7PB7dTYaYPfwnbHQlXxPk1bjDY8eTOFiuAXbFD4i+z2bGheFS2vPqMev/3+htsZnQr2PyiuMCyhDp5pu7jUQ3ZhbLNQANARpkevU2bRVgJtLToD8nTNAA2xeqFZ/2hmE0nobstdmAhp7HLochgL0WQtfw/AmM4PIi3b5s4uurcB9x1vT8UPjHXou5LBXonCqCd5NENSyujF2arMgP1XXrl+ON6TgpWlKBxtMxDJFUZuTD4t/MB+3Z4k/g3na/GHUKxVwWKnciZ/c1IYUwnpd5N7zEsDUb1weKNEyVNfM+mMtprCod+p33m3PWamJCj+2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHEWGZ17qB78FQWauW/e96EEpjze5BeG437vRJ1kzoY=;
 b=Gvm8HuJ6W1DpeXWVoW+eo0kpL3YngwA0KyLeEtszUhpfS5HTCkIiPIljV775XfPWsYr7T4LS0LSwzOVkSPCl5mLzS6/TWg6vnXC4L0sjUXk3vusAWKJLqAqpzbCZp1l6M+F8zU2Vwfu/lm6IulP13LnO2Dpmz33QD5xH7oaI/p2WZYb5Nk13Pd7XagNHqH+E6My9PYMQnEXXl3Aaq6WPfhoUhJFGku/0/vJOLGmQTWStpsjpFWyl7ndCLAiGy17xgCNVMExa8Fmpz8axDSBBYmfqaDLDJrj9FQB+E6LivkNR7Od9RXPhSOOKvAO/a2ap9Pg0Qwlhu4/fwxLBOqjLfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHEWGZ17qB78FQWauW/e96EEpjze5BeG437vRJ1kzoY=;
 b=ZoB6vJzGv7IRv+J41RKS21m3OZW8BElWz7SdSudZXZcgWrj2um0wRC9Ae9ru5Z7Pew9SylsPCJkO3we8hnfGPnq5RPFrAp2NIdew0fRZK/AAsXuIF46ud78zKxBguS3Cj257SKqBZ6/CksN6BAjCUfwOe9dL09qZ9NSwLq/nBX0=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4077.namprd11.prod.outlook.com (2603:10b6:208:13f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Thu, 11 Jun
 2020 18:17:04 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 18:17:03 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <rob+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: Subject: [PATCH v11 0/2] PCI: microchip: Add host driver for
 Microchip PCIe controller
Thread-Topic: Subject: [PATCH v11 0/2] PCI: microchip: Add host driver for
 Microchip PCIe controller
Thread-Index: AQHWQByBrGKbXifQ8kGNEYNcis07GA==
Date:   Thu, 11 Jun 2020 18:17:03 +0000
Message-ID: <d22fe0b64859b589ffc585380819901827094966.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 647c0917-4533-4552-4179-08d80e33a48d
x-ms-traffictypediagnostic: MN2PR11MB4077:
x-microsoft-antispam-prvs: <MN2PR11MB4077C2BAD002BC6FCEEE663F96800@MN2PR11MB4077.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SSmlWYoNFKBQZ3LEdVL9W70YkywshbrdN4Cuieb9do6pNUwqeUXQE4WMZgQkkh1qz+oWYBQAquDLhZ9BuEcEc1uFHGMf5TXoG/K6OfSkqH4YG2Yj8EXp402h9aJb0Db/F16MLS/frse23yv0WIi+BbBUjj9rSIO8PJuJzXJ+Es7ILe/yzr6LwDFDBEnExyUbhVUHwoOwwjBcFSiTFLh1jFB4p8l0jvzS2ck/7Y63Y2mSbz69o0MijRkYYincazW/5sWiLmYUhRXi25o8i/Jo1vEx1vm4TBYQEPRB0B7BdJmiRER402cU/rGrlaBwn88D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(136003)(396003)(376002)(346002)(66556008)(66476007)(64756008)(66446008)(6486002)(36756003)(76116006)(66946007)(91956017)(2616005)(86362001)(2906002)(71200400001)(26005)(186003)(478600001)(6506007)(316002)(8936002)(8676002)(4326008)(6512007)(110136005)(83380400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qGL48c4dqtFSBeCOXbOHYBNqJBluJEULDTuBwcukp1Ludh37ELu5jZj6dXR6Fv4+EyOxL3E7Zt/SDgyiPRdY1lQMQNhrV3bzLfOsf21Br+iKFZjglxOw4tpGFbxHQeQcr6fm92m5tkUYTNMgI1aj79md3hULk8g2RwDm+z/u1Ht1cY34mgbywVDMOltTuULInStsLXU9vLE/J3fPmVa+Y6D5orT9qxmDa/LsXvQ8WoQTPtQ3lBpPZicXfcFPI7hDVBW/RUKeW0OwoAkYW/8xdDWXIbmlLTIl8t4BTF0jg8AxKUAZ55aidEK2697iyYG3027oPs2f24+3sRf2DXKJ+8Ne3cqTJqnLz/C5ZTp3VJkHqg1PVfDPNWz0Q/Zkob+X1wt7DKn/OrGM1WE5oUp8W/EscPCVeB15mewbIRz7G5eRhREM9SKtkCX3EYQueI2kBaehvpPdkIJz2f2rz8TdncyR0DltVr0vlnnIfRrXDkU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9347371D70270743AFAF23203DFD1FA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 647c0917-4533-4552-4179-08d80e33a48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 18:17:03.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1TNX+07w8QTrW2bUFSWIddgZj+YJX/VEhH8DCIIAdPSGxbziSP6eUANZ5qwCQr6H5JKCPu0jwSPNLfZT05WOKtJCmwpBBFSU5AsgdAJBp5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4077
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
