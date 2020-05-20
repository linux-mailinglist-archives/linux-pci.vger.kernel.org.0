Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6281DB203
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 13:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgETLnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 07:43:47 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:58226 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgETLnq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 07:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589975025; x=1621511025;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=2ChmDyqOD5shMER9Cc6SOKnul7BS0X9ukO4f5gQ2tFc=;
  b=V/VtpAw8frmpWGB53KOisHkazDUNtTXhJBbf1z7BdWG8ZbBJ/Dsvu9KD
   zwquTewAr/2eRYNk87mV2lt0F5NVScMsop79FKWgl7TGjFmAZ0qGRVxai
   hlB733dT+WvOt4YvnasvLCXXzjIT0zRtLsJCFCeMHGO+Rg4JEjd7iKspS
   FRgBXMbc9wZyrc6QS9yTCZ1iIzxkxQQp+Dt0gI9V13KfrO5U0RdhuFnWs
   Tr0SqMJNU4PewX/Gl6dbus9g7xBEH/mepIMVc2ZH5u9ISkr0tRq8v4zOa
   wtQQbOT0CskikScHiz5hFnyOfSqGphPLSVUbwxOaPmr0Uo3UefG8Lzood
   g==;
IronPort-SDR: 4NKn7NOcU02UVr1cbAr++1trrAPBABl4tZv5TVGtSxzTJ0jIUJRk76tl/tUfGQG0uQsSF2HuQb
 nUYR/neOWVtwAdOI/27PCcgZLPAkLGUsAlxglR9Y1BCemSknfqiNJBSsB2antMUoNlTsshE5k9
 1bqbhRv+g8v8R1poNADhdcR5y3GIWGCi/oa31nFx1Wq2wcITN22B+m1Ffq2mf7bDxjBXSD/Qgm
 OmfmWv3ehDSU3gNVKw4r2IozrzIbwKejHxAcD1OAbPj5F7VLNE91/+lNcwLJ34bP9rxYYu1WV/
 w68=
X-IronPort-AV: E=Sophos;i="5.73,413,1583218800"; 
   d="scan'208";a="75865105"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 May 2020 04:43:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 May 2020 04:43:44 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 20 May 2020 04:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAiUGh4XgNDPl+ScCRIVYBIhcB47pw+fmyqGNpChbOSOXqzUbcIp0epDRhDn2+YU4jKZufLZQYCOXnTJRGlXc0QrrJrAKIgGgvVQ7SU6NOW2CzxrypwFJx0puykXeLUvztxTMPtKTmahjrn57fF9s3oPQcogCkQHxdfdICvRynswALPk20hgIZ/euzjx3cpLHXs3zvle0RFxY2vmW6KQVWmE5dToReBlOY1LGQN6kT68XsitlxrbWivEVsceSwcuT52ooBIDUAOTL3vsQby4pSq9pmj58ukHy4BNMpmUlomFlV5W8Tx+PJDTamN/2wkxBN7aFGLOJHZdMlCclLC8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ChmDyqOD5shMER9Cc6SOKnul7BS0X9ukO4f5gQ2tFc=;
 b=JFT/nbzioevowIjk9WTI1HPDJ31C9FZAlIVsJdYvWfniX/KA/VhFFTy4J6DjcFiYOW+ifIFVYHlbUDXCgY9oKsPgBHHJFT2K0zSUVeGAAnQt5BYe2ALzgDaVqm+JorcTTHY4U18/BSq37sBIYuKKUvIdzGXdiXyDqNCsdN7OHuynpXPQSpQ2LhJTGmYUGhtx1pIk5fNcX7SJBdIMpgYs4G4dsGuW0r5QC+BN+EUqhzzDjhNSObH4oStcf4AryIIygEgAPZKLzqvRmeZomYWbTU2EPgT3JjlWqLQCz7NqfxGE7CfgG9aHhJQqTfbOLoGEUQnaqoiG7pKKlsWz96FzCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ChmDyqOD5shMER9Cc6SOKnul7BS0X9ukO4f5gQ2tFc=;
 b=s9UgaaP0TMxgHYeNPEvvoiz7DZwOvh8zSidtwFfQBcpr57ehRELgQ7OWLIZQCaKl0BnyEovByoFkf/sb3XalNlfFHXboEMHNVTq/lgsq0fPf3nF54qVlNnJGTLALqmcpE7cpzwDlD9JQLYKXIoCrEi/WX0pAnXRiAxQTiZE7l0c=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB3872.namprd11.prod.outlook.com (2603:10b6:208:13f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 11:43:43 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3021.024; Wed, 20 May 2020
 11:43:43 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh-dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v9 0/2] PCI: Microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v9 0/2] PCI: Microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWLpvp1ZBYgsGiuUWn27zXTFm/xA==
Date:   Wed, 20 May 2020 11:43:43 +0000
Message-ID: <d7b32f86783f0e4883dbf917146f1c2bdb9f9589.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d60a0b58-b255-491e-02f4-08d7fcb30c66
x-ms-traffictypediagnostic: MN2PR11MB3872:
x-microsoft-antispam-prvs: <MN2PR11MB38729E42DFC05802CD11D34496B60@MN2PR11MB3872.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: blirjKjeuA6ZVsBBLm8fAngoKI5dhFHtCKGP7Q1dWoXOr/mUCu+XQSRHrHRKvqTeTzEMMi5xO7Mzs5QtVw8bYuIp7Ckp3Youx7UsNfz6Vm+RU8HtNfYcZCxz7XCEjeS4rfOe23pO2Lt+SR9aWbwZ4lTARjfEDG1K2pUglLXll13asy1p1GfYOaRc4a3qmCcTNILChzZUxv2yUPi8I5RMArBzL6BPNbgWTETHZaiZYhXQalIth0pUlr2Z7n95ir57PDnEbaEflLJ5FQ9JYFgGVFKnZEnVDEH6oH5wFLso0R2skZR0/JGLKpLIBaAdaWt6tM94EPnWiyBN0tWy/qfnCFKDptzpQ3OueERYjuUzj4Kg8rb12vChZ9zKZbut0Q0CxbU1NI6tHXPNMSnZfIjTq5RYOAi6jszBOwxaZMAwC5+hf8TgUl6ylmBtq37pdagg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(110136005)(66476007)(316002)(66946007)(66446008)(64756008)(66556008)(76116006)(91956017)(2906002)(5660300002)(26005)(71200400001)(6506007)(186003)(2616005)(6486002)(8676002)(8936002)(36756003)(86362001)(6512007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tVkyjC5cp8JnK0bJEGgb/W4+MtFaoPqF6lPbLdD3Fflj9eZf5qYn+0iptEbR6k253uZN/3CYc5JjCckUT48T67oCUEjfwoefrYreorv9eF117h6B0IJXT7trsaPjwMg8CL5TsS1MT6dPWISed42OKPw1ewcHLUqzkcFupvA5TrMXAaYLCfZvbKuY8MJUzrLRpGXu5iOzCMTsrDYe0R4h8N3o3FZ1XbKtZlcO1xxUC6ishg8jvG6oY9SQiMpxTq/WH1AXemG69FpfoKj3CbjlbcnFYzMoLr+rraOUmPELJ15Fc55qLjDzPnAgJlm7KMZgMGEWWzDRiyBo1Kjjes85KJhUq9D0j/NKjES/GGTH/ySM44tYYx6dLGmyqd5sATlQ/hOJe7qsu8CbC+6eF9ERj58otQfAkRNImBa5MjEeW3NmGYoepmvJGQfzqzx5lHCqGD97PRHfHj0djND3+mbOKh9/so+psdKpVqkzhoMwgFGLYPNIilJDYy8iLqHNAu/s
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AE6A554F1B92B4E8BBA1211018B306A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d60a0b58-b255-491e-02f4-08d7fcb30c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 11:43:43.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2Gl+Hc030PvzTjsgknpzs1uL+6xlIwFtgKCz5qVsAF2la2s9TK1xw+YrED2Z6LG2rEczo1FnwQRQwZbgUg2AUdL6xhPdzohGShUGtO1NXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3872
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpUaGlzIHY5IHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgdGhlIE1pY3JvY2hpcCBQQ0llIFBvbGFy
RmlyZSBQQ0llDQpjb250cm9sbGVyIHdoZW4gY29uZmlndXJlZCBpbiBob3N0IChSb290IENvbXBs
ZXgpIG1vZGUuDQoNClVwZGF0ZXMgc2luY2Ugdjg6DQoqIFJlZmFjdG9yZWQgYXMgcGVyIFJvYiBI
ZXJyaW5nJ3MgY29tbWVudHM6DQogIC0gYmluZGluZ3MgaW4gc2NoZW1hIGZvcm1hdA0KICAtIEFk
anVzdGVkIGxpY2VuY2UgdG8gR1BMdjIuMA0KICAtIFJlZmFjdG9yZWQgYWNjZXNzIHRvIGNvbmZp
ZyBzcGFjZSBiZXR3ZWVuIGRyaXZlciBhbmQgY29tbW9uIGVDQU0gY29kZQ0KICAtIEFkb3B0ZWQg
cGNpX2hvc3RfcHJvYmUoKQ0KICAtIE1pc2NlbGxhbm91cyBvdGhlciBpbXByb3ZlbWVudHMNCg0K
VXBkYXRlcyBzaW5jZSB2NzoNCiogQnVpbGQgZm9yIDY0Yml0IFJJU0NWIGFyY2hpdGVjdHVyZSBv
bmx5DQoNClVwZGF0ZXMgc2luY2UgdjY6DQoqIFJlZmFjdG9yZWQgdG8gdXNlIGNvbW1vbiBlQ0FN
IGRyaXZlcg0KKiBVcGRhdGVkIHRvIENPTkZJR19QQ0lFX01JQ1JPQ0hJUF9IT1NUIGV0Yw0KKiBG
b3JtYXR0aW5nIGltcHJvdmVtZW50cw0KKiBSZW1vdmVkIGNvZGUgZm9yIHNlbGVjdGlvbiBiZXR3
ZWVuIGJyaWRnZSAwIGFuZCAxDQoNClVwZGF0ZXMgc2luY2UgdjU6DQoqIEZpeGVkIEtjb25maWcg
dHlwbyBub3RlZCBieSBSYW5keSBEdW5sYXANCiogVXBkYXRlZCB3aXRoIGNvbW1lbnRzIGZyb20g
Qmpvcm4gSGVsZ2Fhcw0KDQpVcGRhdGVzIHNpbmNlIHY0Og0KKiBGaXggY29tcGlsZSBpc3N1ZXMu
DQoNClVwZGF0ZXMgc2luY2UgdjM6DQoqIFVwZGF0ZSBhbGwgcmVmZXJlbmNlcyB0byBNaWNyb3Nl
bWkgdG8gTWljcm9jaGlwDQoqIFNlcGFyYXRlIE1TSSBmdW5jdGlvbmFsaXR5IGZyb20gbGVnYWN5
IFBDSWUgaW50ZXJydXB0IGhhbmRsaW5nIGZ1bmN0aW9uYWxpdHkNCg0KVXBkYXRlcyBzaW5jZSB2
MjoNCiogU3BsaXQgb3V0IERUIGJpbmRpbmdzIGFuZCBWZW5kb3IgSUQgdXBkYXRlcyBpbnRvIHRo
ZWlyIG93biBwYXRjaA0KICBmcm9tIFBDSWUgZHJpdmVyLg0KKiBVcGRhdGVkIENoYW5nZSBMb2cN
Cg0KVXBkYXRlcyBzaW5jZSB2MToNCiogSW5jb3Jwb3JhdGUgZmVlZGJhY2sgZnJvbSBCam9ybiBI
ZWxnYWFzDQoNCkRhaXJlIE1jTmFtYXJhICgyKToNCiAgUENJOiBNaWNyb2NoaXA6IEFkZCBob3N0
IGRyaXZlciBmb3IgTWljcm9jaGlwIFBDSWUgY29udHJvbGxlcg0KICBQQ0k6IE1pY3JvY2hpcDog
QWRkIGhvc3QgZHJpdmVyIGZvciBNaWNyb2NoaXAgUENJZSBjb250cm9sbGVyDQoNCiAuLi4vYmlu
ZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCAgICAgfCAgOTQgKysrDQogZHJpdmVy
cy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jICB8IDY2NCArKysrKysrKysrKysr
KysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDc2OCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBj
aWUtaG9zdC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1taWNyb2NoaXAtaG9zdC5jDQoNCg0KYmFzZS1jb21taXQ6IGMwY2MyNzExNzNiMmUxYzJk
OGQwY2VhZWYxNGU0ZGZhNzllZWZjMGQNCi0tIA0KMi4xNy4xDQoNCg==
