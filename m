Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A23C1E2479
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgEZOtY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 10:49:24 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:7586 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEZOtY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 10:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590504563; x=1622040563;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=utPZfONMB8psloQX6u69HKsZLbUl9vddzki9MRUTGn4=;
  b=tSppjyesRwKoPmlqQ/8OuyyFzrXIJd7BMzT/W1ZJ/TTBGCSYCJJTq4I6
   rdUOxuvkzwf6M6JwtDEbpf1n3MgUyLwwSqVkdvx0AbQ+496J0Fi9zEJxm
   OmE4XbGaMGsfKJ9HG7+OAbkmips7sM1Oe2brRUJmS9fYy8GfNay+KXO27
   xEzhrVb2ckSBJUwr1eIrDz9lWUAViqqGvu77PR6gPm0daUicWNwCnaRvb
   8nfIMhK/AO+Y3wBPsN6fIc5YGo373WHgqJSnHyQDYuKiBErSPaUQSZbCB
   qytgaQYx3geBBNBJX0+rRX+6+09Kb4YPWpv1J+m07Mlx52zz9fLue6mXJ
   g==;
IronPort-SDR: fkSZ3KXkSDmkXieJMfO6F4j5LiFVEuNaIq02Ynsmcgoj3HIPsAYYYk5v4xWrFWzMHJoTsAsXcu
 mgxav+blb0zYe33oSEQRAJdcxPYnNwciN0OA/ZrIvXJljQFckmmffjiFkopUkwmxu4IdJdxI/P
 PBbQ6NjO/8S5G5IDWf9iJpYFvxUB0EYsQid0DXYTiB1BNR00jzcHfbYUXmHSqgJenu2Cn/ChNB
 Y5lldrjMDnsVOx1FpgbDfTx/LNmUPn2ljDSWWC1gC4l/PgDoWOz4sf3SbNUZgNWUiz2BydoHvn
 MEQ=
X-IronPort-AV: E=Sophos;i="5.73,437,1583218800"; 
   d="scan'208";a="76370265"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2020 07:49:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 May 2020 07:49:24 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 26 May 2020 07:49:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lq9dVvo2yQsMrjs0W6NnBkeghl+2q84rhCf7FPOW5mIfycNmCE2pBhtxH79naf/pdaVVbcKt7bjBPc8C5TLGyAbfyP/tUQB0VLSlzYsJkjNHoeJ7TUiJmM90bxXrDaMzutktqWGcicmEOdHV2j1CsAR6TeNKYQDjnUM70bsikseklqoPLWjz7o6Si2e26h0Jrmavb+yVffes1NnZDzefo0ZtsL1uo6fnhDHypfy/idWr+1uUjFjyH+Kz0SI7z+dekrGcxLWB4232mJTzVTahzwzymstH7gLbgzZH8KYKaT3w3zjBDCojhDBRw6cXssmMA6aO1d9QmZrudEJ3Usyd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utPZfONMB8psloQX6u69HKsZLbUl9vddzki9MRUTGn4=;
 b=a49GRovPu9ofdHheSA6xlHp54IymXbvyubZJU0YAzZKwJuxrjroT+S8tgMRfrWDB64i4DEsPTSo3yXo4krV1dQWl4Ko/Eg2lGBoOib4O6XXO10VzPc8B0yU2UJat2KkxIEIDCrNc9bSYfesfvj6Kz5U82gURoxLCoE61brFeIVB0iHWt+C/PpqIbRpNaFgfKIXwNHtuxkX7/OsU3qV9MTgUDNXBvp8wBhSdcLWJfUT2U3c8XByp+2U0W0fooK0QYVlNhfOHX/JuMTAtbzrGkRT6Ntw9iKGKGZyh4wnWSif8LhPngTlqu95ZhtH4lVLhMKIhda371SJijtMd7labOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utPZfONMB8psloQX6u69HKsZLbUl9vddzki9MRUTGn4=;
 b=HJy3CUs0/YhrHNYRBPeP5aUxBS06xpGK9vsCxqOvs+6frN08RmeeIW3MYbcK9ODzkLpsTtutoJxz0o4P70EowjnT+N/Acw2UmMB3/Ia1qfmGeXpke918wBRAw7hENnPZpaY4LE4p/1WODKGjkdll3UiQzznpPpg83eNvptP/+bA=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB3966.namprd11.prod.outlook.com (2603:10b6:208:13f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Tue, 26 May
 2020 14:49:20 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 14:49:20 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v10 0/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v10 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWM2zWk2vQFmiyF0Cxp8HUIwYe8w==
Date:   Tue, 26 May 2020 14:49:20 +0000
Message-ID: <930a4f34fd11be89bc66cfa35b249c9b685aa8c2.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66a78ff3-45fd-4bb4-8fe1-08d80183f937
x-ms-traffictypediagnostic: MN2PR11MB3966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB39662D69F8B43D1F66B5C7BE96B00@MN2PR11MB3966.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5uGbaOtpioaQl4bRsELRAZOhla05Tw4FouwtMbbd2NlL1/PqA8u6AClrPe1Fug0zWRFYO2W67FAbY24Yh0kdKNR7JUYaNumeFKRoSAVaz3Iwbjk6rTEDLvVbZfuHlE99x4MejRlO9gJadXO0bsfrjK8w/9GQ82w33+mOZ4FIEloydlO/OT4LgXDOjjXre9QDW7nnSrkBdXyco/QJL52L4sXgvLOcEilWksafERPr49mAYV4wIZhEaaUVvfIGkr+PQC4Kq8k+qYDE0Byj6Zr8MCAl16MIur1qkBR+Yvm9xio3vSqNzgkqTNUwVpUH0IN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(366004)(39850400004)(396003)(64756008)(66446008)(66556008)(91956017)(76116006)(6512007)(66946007)(4326008)(66476007)(8936002)(26005)(8676002)(6506007)(186003)(316002)(71200400001)(110136005)(478600001)(2906002)(86362001)(5660300002)(2616005)(6486002)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7cUCYzzJCDX+X5UW38CjMv/fQ02L3EDLNmRhFT/gSMm3QCTjg2/zH6Nn68lQHcEZYygQ1Cu1cQYDpI4aMlDbckmfvT6iKkl4mr7gT64XhQKEMXAGFAiKOpMsDSPZv33soGpMer/R2pSxS959H0WClPeaYNF/eXs9XonAqcmNLR/iyeFwr2K3P+EHgvJfIZqQVnhiJX2gpdjHbnVk6d4c9MuqyhauzwXlpze+kjyAO7DlWTGTEZDH2rgnVRKwiO8GfbNJp5/1sUsaYaqmKags+HTiNXDhW7D1IQSGQivUUK6fUvUr5BedBfddyJ8MuivLyBQ0E9EWpfGT/xVHoO0PYwfQiSPH4dVrsDkcti3CQhWxVDF1S84BNDWCN92hXnStCHyQq88/0jyAJLcpfJ9EhsIFURm3g/usMgcYf3JLNB73RcVT31lxgg7tOuWkMDHznGR3IGtWIlljvyv4ZZq5tAZP8yh7M53MEkEfFPuDJn/PUVNSKbRSgM/7DbQbH4wZ
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D60C669D4FD4442873AF248F63CE0A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a78ff3-45fd-4bb4-8fe1-08d80183f937
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 14:49:20.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tHYCwK8cvMLsLj1Ibz6qxqD4GBX801z/1Qzo2f0UPKMVf8/31ZOZOOQ1XND5TqUT1mSnb9w3fDwq62ploo8NYEE2FQCeYYwrj/uH8q0OCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3966
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyB2MTAgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUgTWljcm9jaGlwIFBDSWUgUG9sYXJG
aXJlIFBDSWUNCmNvbnRyb2xsZXIgd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxl
eCkgbW9kZS4NCg0KVXBkYXRlcyBzaW5jZSB2OToNCiogQWRqdXN0ZWQgY29tbWl0IGxvZ3MNCiog
bWFrZSBkdF9iaW5kaW5nc19jaGVjayBub3cgcGFzc2VzDQoNClVwZGF0ZXMgc2luY2Ugdjg6DQoq
IFJlZmFjdG9yZWQgYXMgcGVyIFJvYiBIZXJyaW5nJ3MgY29tbWVudHM6DQogIC0gYmluZGluZ3Mg
aW4gc2NoZW1hIGZvcm1hdA0KICAtIEFkanVzdGVkIGxpY2VuY2UgdG8gR1BMdjIuMA0KICAtIFJl
ZmFjdG9yZWQgYWNjZXNzIHRvIGNvbmZpZyBzcGFjZSBiZXR3ZWVuIGRyaXZlciBhbmQgY29tbW9u
IGVDQU0gY29kZQ0KICAtIEFkb3B0ZWQgcGNpX2hvc3RfcHJvYmUoKQ0KICAtIE1pc2NlbGxhbm91
cyBvdGhlciBpbXByb3ZlbWVudHMNCg0KVXBkYXRlcyBzaW5jZSB2NzoNCiogQnVpbGQgZm9yIDY0
Yml0IFJJU0NWIGFyY2hpdGVjdHVyZSBvbmx5DQoNClVwZGF0ZXMgc2luY2UgdjY6DQoqIFJlZmFj
dG9yZWQgdG8gdXNlIGNvbW1vbiBlQ0FNIGRyaXZlcg0KKiBVcGRhdGVkIHRvIENPTkZJR19QQ0lF
X01JQ1JPQ0hJUF9IT1NUIGV0Yw0KKiBGb3JtYXR0aW5nIGltcHJvdmVtZW50cw0KKiBSZW1vdmVk
IGNvZGUgZm9yIHNlbGVjdGlvbiBiZXR3ZWVuIGJyaWRnZSAwIGFuZCAxDQoNClVwZGF0ZXMgc2lu
Y2UgdjU6DQoqIEZpeGVkIEtjb25maWcgdHlwbyBub3RlZCBieSBSYW5keSBEdW5sYXANCiogVXBk
YXRlZCB3aXRoIGNvbW1lbnRzIGZyb20gQmpvcm4gSGVsZ2Fhcw0KDQpVcGRhdGVzIHNpbmNlIHY0
Og0KKiBGaXggY29tcGlsZSBpc3N1ZXMuDQoNClVwZGF0ZXMgc2luY2UgdjM6DQoqIFVwZGF0ZSBh
bGwgcmVmZXJlbmNlcyB0byBNaWNyb3NlbWkgdG8gTWljcm9jaGlwDQoqIFNlcGFyYXRlIE1TSSBm
dW5jdGlvbmFsaXR5IGZyb20gbGVnYWN5IFBDSWUgaW50ZXJydXB0IGhhbmRsaW5nIGZ1bmN0aW9u
YWxpdHkNCg0KVXBkYXRlcyBzaW5jZSB2MjoNCiogU3BsaXQgb3V0IERUIGJpbmRpbmdzIGFuZCBW
ZW5kb3IgSUQgdXBkYXRlcyBpbnRvIHRoZWlyIG93biBwYXRjaA0KICBmcm9tIFBDSWUgZHJpdmVy
Lg0KKiBVcGRhdGVkIENoYW5nZSBMb2cNCg0KVXBkYXRlcyBzaW5jZSB2MToNCiogSW5jb3Jwb3Jh
dGUgZmVlZGJhY2sgZnJvbSBCam9ybiBIZWxnYWFzDQoNCkRhaXJlIE1jTmFtYXJhICgyKToNCiAg
UENJOiBtaWNyb2NoaXA6IEFkZCBob3N0IGRyaXZlciBmb3IgTWljcm9jaGlwIFBDSWUgY29udHJv
bGxlcg0KICBQQ0k6IG1pY3JvY2hpcDogQWRkIGhvc3QgZHJpdmVyIGZvciBNaWNyb2NoaXAgUENJ
ZSBjb250cm9sbGVyDQoNCiAuLi4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFt
bCAgICAgfCAgOTMgKysrDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAg
ICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAg
ICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9z
dC5jICB8IDY2NCArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDc2NyBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQoNCg0KYmFzZS1j
b21taXQ6IGMwY2MyNzExNzNiMmUxYzJkOGQwY2VhZWYxNGU0ZGZhNzllZWZjMGQNCi0tIA0KMi4x
Ny4xDQoNCg==
