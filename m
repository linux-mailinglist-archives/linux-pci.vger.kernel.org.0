Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBF324A413
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgHSQaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 12:30:35 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:23712 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSQab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2020 12:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1597854631; x=1629390631;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=nosNoKWfuKLgEIBPWZvOhG/88cX1NBO2W7lv0+tQgNg=;
  b=Caa2YPnnGdHWFpbpdz3zH00lHPXV/ge208Ivyr6qJUagJ0z3ZhVez5v+
   H2htfYLa9kz1lqy8RetUaitbGkxzATEEsYv2c2SIWkFT5VI3egHWLKlnO
   rGS0BpsWKS405dWaQ/U60J85U1aBNqAPD8Ncw95b2Ai8ogOjyGE9iPZJC
   cQ1j1Ttr5H9Mh1NTu09i8p+R6bdKNXKO7IF1FzY4priZkwwQRCO9FpJF5
   0Q/iaNsqlJ8SoHdhFqGcZae0BjnurXX8FIdgnwQ6RMyuvH9lNc+0pcqmi
   ktfz5MxivzHeSc15ewvsbODh5983Ip9i9HNMfG2n1hpbUYnrd6EAdPwkG
   w==;
IronPort-SDR: 7J0AK5LaJeirP5P+Q4VErvAMqinUNPcVYdKG1T6a7p8I/lsyZYYvomkjfYbCaadWlRyhB5oEN5
 bdlOiCso0yTBK1H2+Rf8/WhIDEyqlJJqqKKn5qj/EBGzsBDzRaZv9o3iEgW1k8jUWx7VbMa2C9
 pqxHFLj4jOcdN2Hxg42AcdwgmQXGfRVn5GkQbfTCOxibAK3GFaP9UBAgU7bd0yexWxxXGjA/IM
 Qiv8T213aotNjkMpaomYAj+7ohArBOPp05Kdc2+RJm3I34rV0wPQsDe8LbgjEEGZA7K0GHESjW
 aIM=
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="87760977"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2020 09:30:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 09:29:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 19 Aug 2020 09:30:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7Evu/JYmNouWgyqWiCD8wbos9LgPiFidJqMaBWqSbmXdgmiJk2Y/qaLlvjOLCzQDGdVR6yHWgjMrcNGgTyneY9pbq8cDf2wK+DIwAhN8WzZdbqWgfQwqQVYnd0UHN5O6B1npFg9PxC3YGoq371gDwYnFv0ZloVnxmg2uBvxkRTq5UpVcm+Gtt2DlGYA403DpkNnJLYJ57U9N/vUlcvie7KgjSXBoPsrrMk8QJdj8jKe2qa9ojprYIuVyl5RQhHy9lxxaWZL4ZS0ILNZGOAa0yrl32Fkj6qjGkGt3bJcvxcyNv0+s9CHS69l+aPqlUi6DSqcCpoHM1updLiaH/5mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nosNoKWfuKLgEIBPWZvOhG/88cX1NBO2W7lv0+tQgNg=;
 b=JuoBewNGeTww3wwVcQU6srAlHZ/apjEOj9+e2ZMwdEAPSd7APOYzz9pEnK0Ei5SQgqLk8PzlotkYP3Yo3dDpM6HD56y4ubReJAGhY14Z0i6KdHNbO2vnLIBgZIErwJI6ibFHoMqwBmnhONLJ2NIFOze5rVtfFnE8m6/qInM00XqDmgxaGnMF3v3xUuqj0lS6o/Ozt24hP4TxFQqLcDJOi5Bcs1tHcowyFpKwFF8sQcwobayX6DVS6mjliPSHDU5FEBJJznOsl6mcmzFyn9Ma72I8Cjb4rfA5XZnB7Y0sirnLSQIKRV/db3b7re9xHsquYEM4YVmlZUDEs+XqFIPAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nosNoKWfuKLgEIBPWZvOhG/88cX1NBO2W7lv0+tQgNg=;
 b=E1tz4qidg9WkuzpeCsd934gFQez0ueWOcf/rzzGEmoXMAxG+nHXEo5Jmbcche1GMz3TFAcDXU3x6XpKRTEmSHF03wMyhMSc8CihOtmKnxBlzJMkNr1N+6bdcc1+1zMZQ62HpO/8C4ZXz6RiIWYaQLEkbVmIQY9rRpQrEgK9BSWw=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB2916.namprd11.prod.outlook.com (2603:10b6:208:72::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 16:30:28 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12%7]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 16:30:28 +0000
From:   <Daire.McNamara@microchip.com>
To:     <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v15 0/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v15 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWdkYMoWLOV167sUGWIi7KCE8oVg==
Date:   Wed, 19 Aug 2020 16:30:27 +0000
Message-ID: <954a9f86bbfe929bc37653f1e616e8acff8b4bd8.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [87.42.139.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beaec58e-4f45-4b9c-1fb4-08d8445d2ecf
x-ms-traffictypediagnostic: BL0PR11MB2916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB29161F3047D77BAA776465A3965D0@BL0PR11MB2916.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pS5qpKPCf219sJQEK4SMeq9pC2WDGBWgYGa0ny71LTndbqZSxkwkrtqBjfLcgo6mIjUONOo2PQn7zrqhaiXDiOUgENgcZH1rmrui57tq6IlRUITZhc7JrHcWHFdUunc0eRCoA6FeX2uSh+w9B09oVwXXv6PrHbb1qAPLpDfwHIRNKe8YnlVujx1TumwcpYTUCKpMobZ1kML2QT+dlgsM2D6c5A/ddT3XcfScgAKEtCqfXK2XnSYcdYHKExVrQbqDgehpeREseYq2oTVNPUcby10Bhp/2kdSHErqe/UHftERp6LuEjqMnnPrNoQfaeb+J6Bh6tDhsjvQB++/KfHRvCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(91956017)(64756008)(36756003)(83380400001)(6506007)(66446008)(66476007)(5660300002)(66556008)(186003)(6486002)(8936002)(2616005)(8676002)(2906002)(26005)(110136005)(4326008)(6512007)(71200400001)(76116006)(66946007)(316002)(86362001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ID/BYCE52WP8sU0SjbcQz6sJoMe9NF+euLVbbpeoGwau9b+f3U1NHvVY30G7ABoLeHohkCLBcdm+YipS+Q6akkWAfucpnTeVH9v+fBWNTGYMyDq5acLD30RViEG9c5xq3d9XsyiLZhO0hlVwPmgia+0Ea0oyiajDXhm8u96CDjgmGIqjS5WnvPg+w0eEl6en8ZsDHNz2iXfFEXDW8giQY4Ees92cszoTR2hBzg4IFE8mA/eTxFn+wq44w0B3DxGyzmhkIZKsQ6zGuhFpSb0WTS4EHwKYHxeG4PCfP/UBry3ZmAF+7qlOKk35NysNv62G895Stgv2eEt5NwVO/Xn+L3uk6qhJEmjYqkLWJa2oNwAo2Uvm6VDgqNRvGp/Jf+s+1zvLbZR/KOawMfn1c6T1OFvidnN4CknzEBAqqqL0tZtrbuj1UMta/1LjZXkWgxvGRgqC0TVACIWiv1K/Fkd9LKYeFQxg0/yjpGK/58Rq9jEB2Z1zb+62mZRooeyrE2fDhsBFwr1UN4OgoMMAu7iVkoNciS3iWbwofh6609dWqsqpeo37i9b2TWvjsZz3TyVZBbOG7b/XfIVOz5uhWkZCsyGJA5lPEZt61yUXxxDzi5r2PUqxufAWhvLPsFrVMmQxGiMxQgdIpahPq6kUPqbN5Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA7696749071604D9B3F54811C12A5C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beaec58e-4f45-4b9c-1fb4-08d8445d2ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 16:30:28.0358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ar5FOnBIUQKJOFA87YS6augkLaqzni/66ioTp/1OyPpFv8Mk/QMhAVN7NhFJtFOjpBatanFKZd9gqAuZyKCNw0i5bxrTmGoYbd+20qEgmag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2916
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyB2MTUgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUgTWljcm9jaGlwIFBDSWUgUG9sYXJG
aXJlIFBDSWUNCmNvbnRyb2xsZXIgd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxl
eCkgbW9kZS4NCg0KVXBkYXRlcyBzaW5jZSB2MTQ6DQoqIFJlbW92ZWQgY2ZnX3JlYWQvY2ZnX3dy
aXRlIGlubGluZSBmdW5jdGlvbnMNCiogVXBkYXRlZCB0byBpcnFfZGF0YV9nZXRfaXJxX2NoaXBf
ZGF0YSgpDQoqIFVwZGF0ZWQgdG8gdXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgp
DQoqIFJlcGxhY2VkIG9mX3BjaV9yYW5nZSBwYXJzaW5nIHRvIHNldHVwIHdpbmRvd3MgdmlhIGJy
aWRnZSBwb2ludGVyLg0KDQpVcGRhdGVzIHNpbmNlIHYxMzoNCiogUmVmYWN0b3JlZCB0byB1c2Ug
cGNpX2hvc3RfY29tbW9uX3Byb2JlKCkNCg0KVXBkYXRlcyBzaW5jZSB2MTI6DQoqIENhcGl0YWxp
c2VkIGNvbW1pdCBtZXNzYWdlcy4gIFVzZSBzcGVjaWZpYyBzdWJqZWN0IGxpbmUgZm9yIGR0LWJp
bmRpbmdzDQoNClVwZGF0ZXMgc2luY2UgdjExOg0KKiBBZGp1c3RlZCBzbyB5YW1sIGZpbGUgcGFz
c3NlcyBtYWtlIGR0X2JpbmRpbmdfY2hlY2sNCg0KVXBkYXRlcyBzaW5jZSB2MTA6DQoqIEFkanVz
dGVkIGRyaXZlciBhcyBwZXIgUm9iIEhlcnJpbmcncyBjb21tZW50cywgbm90YWJseToNCiAgLSB1
c2UgY29tbW9uIFBDSV9NU0lfRkxBR1MgZGVmaW5lcw0KICAtIHJlZHVjZSBzdG9yYWdlIG9mIHVu
bmVjZXNzYXJ5IHZhcnMgaW4gbWNfcGNpZSBzdHJ1Y3QNCiAgLSBzd2l0Y2hlZCB0byByZWFkL3dy
aXRlIHJlbGF4ZWQgdmFyaWFudHMNCiAgLSBleHRlbmRlZCBsb2NrIGluIG1zaV9kb21haW5fYWxs
b2Mgcm91dGluZQ0KICAtIGltcHJvdmVkIDMyYml0IHNhZmV0eSwgc3dpdGNoZWQgZnJvbSBmaW5k
X2ZpcnN0X2JpdCgpIHRvIGlsb2cyKCkNCiAgLSByZW1vdmVkIHVubmVjZXNzYXJ5IHR3aWRkbGUg
b2YgZUNBTSBjb25maWcgc3BhY2UNCg0KVXBkYXRlcyBzaW5jZSB2OToNCiogQWRqdXN0ZWQgY29t
bWl0IGxvZ3MNCiogbWFrZSBkdF9iaW5kaW5nc19jaGVjayBwYXNzZXMNCg0KVXBkYXRlcyBzaW5j
ZSB2ODoNCiogUmVmYWN0b3JlZCBhcyBwZXIgUm9iIEhlcnJpbmcncyBjb21tZW50czoNCiAgLSBi
aW5kaW5ncyBpbiBzY2hlbWEgZm9ybWF0DQogIC0gQWRqdXN0ZWQgbGljZW5jZSB0byBHUEx2Mi4w
DQogIC0gUmVmYWN0b3JlZCBhY2Nlc3MgdG8gY29uZmlnIHNwYWNlIGJldHdlZW4gZHJpdmVyIGFu
ZCBjb21tb24gZUNBTSBjb2RlDQogIC0gQWRvcHRlZCBwY2lfaG9zdF9wcm9iZSgpDQogIC0gTWlz
Y2VsbGFub3VzIG90aGVyIGltcHJvdmVtZW50cw0KDQpVcGRhdGVzIHNpbmNlIHY3Og0KKiBCdWls
ZCBmb3IgNjRiaXQgUklTQ1YgYXJjaGl0ZWN0dXJlIG9ubHkNCg0KVXBkYXRlcyBzaW5jZSB2NjoN
CiogUmVmYWN0b3JlZCB0byB1c2UgY29tbW9uIGVDQU0gZHJpdmVyDQoqIFVwZGF0ZWQgdG8gQ09O
RklHX1BDSUVfTUlDUk9DSElQX0hPU1QgZXRjDQoqIEZvcm1hdHRpbmcgaW1wcm92ZW1lbnRzDQoq
IFJlbW92ZWQgY29kZSBmb3Igc2VsZWN0aW9uIGJldHdlZW4gYnJpZGdlIDAgYW5kIDENCg0KVXBk
YXRlcyBzaW5jZSB2NToNCiogRml4ZWQgS2NvbmZpZyB0eXBvIG5vdGVkIGJ5IFJhbmR5IER1bmxh
cA0KKiBVcGRhdGVkIHdpdGggY29tbWVudHMgZnJvbSBCam9ybiBIZWxnYWFzDQoNClVwZGF0ZXMg
c2luY2UgdjQ6DQoqIEZpeCBjb21waWxlIGlzc3Vlcy4NCg0KVXBkYXRlcyBzaW5jZSB2MzoNCiog
VXBkYXRlIGFsbCByZWZlcmVuY2VzIHRvIE1pY3Jvc2VtaSB0byBNaWNyb2NoaXANCiogU2VwYXJh
dGUgTVNJIGZ1bmN0aW9uYWxpdHkgZnJvbSBsZWdhY3kgUENJZSBpbnRlcnJ1cHQgaGFuZGxpbmcg
ZnVuY3Rpb25hbGl0eQ0KDQpVcGRhdGVzIHNpbmNlIHYyOg0KKiBTcGxpdCBvdXQgRFQgYmluZGlu
Z3MgYW5kIFZlbmRvciBJRCB1cGRhdGVzIGludG8gdGhlaXIgb3duIHBhdGNoDQogIGZyb20gUENJ
ZSBkcml2ZXIuDQoqIFVwZGF0ZWQgQ2hhbmdlIExvZw0KDQpVcGRhdGVzIHNpbmNlIHYxOg0KKiBJ
bmNvcnBvcmF0ZSBmZWVkYmFjayBmcm9tIEJqb3JuIEhlbGdhYXMNCg0KRGFpcmUgTWNOYW1hcmEg
KDIpOg0KICBkdC1iaW5kaW5nczogUENJOiBtaWNyb2NoaXA6IEFkZCBNaWNyb2NoaXAgUG9sYXJG
aXJlIGhvc3QgYmluZGluZw0KICBQQ0k6IG1pY3JvY2hpcDogQWRkIGhvc3QgZHJpdmVyIGZvciBN
aWNyb2NoaXAgUENJZSBjb250cm9sbGVyDQoNCkRhaXJlIE1jTmFtYXJhICgyKToNCiAgZHQtYmlu
ZGluZ3M6IFBDSTogbWljcm9jaGlwOiBBZGQgTWljcm9jaGlwIFBvbGFyRmlyZSBob3N0IGJpbmRp
bmcNCiAgUENJOiBtaWNyb2NoaXA6IEFkZCBob3N0IGRyaXZlciBmb3IgTWljcm9jaGlwIFBDSWUg
Y29udHJvbGxlcg0KDQogLi4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwg
ICAgIHwgIDkzICsrKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAg
ICAgICB8ICAgOSArDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9NYWtlZmlsZSAgICAgICAgICAg
ICAgIHwgICAxICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3Qu
YyAgfCA1NjAgKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA2NjMgaW5zZXJ0
aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KDQoNCmJhc2UtY29t
bWl0OiAxODQ0NWJmNDA1Y2IzMzExMTdiYzk4NDI3YjFiYTZmMTI0MThhZDE3DQotLSANCjIuMTcu
MQ0KDQo=
