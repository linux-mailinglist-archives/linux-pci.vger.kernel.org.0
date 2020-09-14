Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1585268DAE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgINObC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:31:02 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:46928 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgINOaW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600093821; x=1631629821;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YuPKZCwUiBnSOCYoYn+pCAHHeb8IXKaHkxN3RDCIFtc=;
  b=aRJE1P0uBb3cPisdEssHP8fSdfiLVn9ASF+wMAtkcmHuu59np6XmCw22
   9nnuLazYPOJBmn3IL8pz//YkKkmnqPw+BNhurWaF8mMS55aRIDTE+6gnI
   toMd85rCO9KoFn8O8OHzoXIek+zt6Apg58l6NVdbWh1swM02PPuLcY0k4
   VeC/4lC0NvESaentQJC/ayDh0D1OyDFZCzPj6JmkXgK+bLrz0WOj8v2U4
   Yjx8Fez/KEvhjZ5qKiSTwpu9ulMXiEGYKXKVLNo7VGCeegDJGgRGcfxUM
   FmGKzX9wZgx1W+XG7iEE2ru1HObULw1swhGAFbwCjZkYJWXeQm06Fvbzu
   A==;
IronPort-SDR: R7SE6Kxnc3D5HBvBwlQPNW3j6UXlyVeKicXo8rZGvZkbcswGsrQ779gGOZDm1hGoRLVgdBKFh8
 LXpzmylVn9nCZe84BuWHGqH8s3SIgDgE9MAJ0vD+0xkmvWWBJd2ub2TZOuT72YzTadJBOOB++N
 WrLeC+jahoMVqUhYXv22GFzhmDJzn7w6hT++urhOG+g3pubvXkVE36jr3trxkJJA6HwGYMu+9A
 z1bJJgo73u1ZcgtTXdaAZ+PzpQKAOHM52JNVXso1zWeUE1OychGaMSk873iY8RYl83L8kzlEEL
 KIg=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="95649551"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:29:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:29:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 14 Sep 2020 07:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oav2fSOQ/2aus4X3hz/ScP+NlkSz4J79Yn5Y6j7UB6kmKhSkPeVD3rns0K5tYyM5AjI8aLC3vJrZiWdpsE+wnCHIYN+4RuJ6WqUzgDtZKn9U41FQUbvhba8a/bxDMYu+FxpmAxo7j2i1iEh6ARGUcV1GEs7LQvGVGS+jFosDkPftJlXxr2XcACwH7q+nkHAz3qaKeewNHcVHY4AFlW2irBat+wMQt5de6N2rp/7RAOZ4ZjTt4nFSBj9FdccsOGcT3aN4j4jtVyzbeFhLMS4dEw/HM0iLIoB4DyOdJZmysGrE8VwamixTHGWovJg31LguiLj/+M9aWyLI72MXD7TwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuPKZCwUiBnSOCYoYn+pCAHHeb8IXKaHkxN3RDCIFtc=;
 b=Q+yD4DW2WBIwxrqwxVLeCqjkryA9ip0M3o4LJq+zuMOGT57gAL5MJYW0Eij2gszj83jvTU6q96TyLssI+3QOzFfWiAbrrfX3nPlW1dAHA+YePm4O3r578+gipnfSioQu5ks/jc8MLxnHP6tukJn7HRb0hnvyaoYIyrn3tq8ytic4/Qzo7imI0zW3lmwiVakP/AYFDNnnmFoQUqVxR+BaXJ9S7akPz/SGj8VLMiwjaPZ0CwBidIMsIrWJBjoi9OK9lFUK2YE4bAf+zgW9jM02Uwl15ONqjbSbUEEh0qTTr9OhlI4huB7mjYbRzTF6ojCpAv4oPWLjRQD9ATvnU+AtVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuPKZCwUiBnSOCYoYn+pCAHHeb8IXKaHkxN3RDCIFtc=;
 b=CKcJPM3jrCkrz6LBKCaUIx6dhCWJSnwsN9on9Jkl+yyEPAlZ43UruSEEMy133RkI0arKrICvmU7VOgui1KfW1RFXXmLzofsrmnlOYsoTZTBE0bhQ+HizA9RUGSFG/F70QTJhNWa3LCzJlQNPU/pySBZ+lJJE3/IAmQ77OltJ+uU=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:29:56 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::38d4:de41:43a4:4642]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::38d4:de41:43a4:4642%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:29:56 +0000
From:   <Daire.McNamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: Re: [PATCH v16 1/3] PCI: Call platform_set_drvdata earlier in
 devm_pci_alloc_host_bridge
Thread-Topic: [PATCH v16 1/3] PCI: Call platform_set_drvdata earlier in
 devm_pci_alloc_host_bridge
Thread-Index: AQHWiqOE33iyyXRmYkKgDsaKb23wBA==
Date:   Mon, 14 Sep 2020 14:29:56 +0000
Message-ID: <5f9c11ac-e511-11c2-e0c7-992aa960073e@microchip.com>
References: <6bd2bce1-1241-e2e1-cab7-c48813584248@microchip.com>
In-Reply-To: <6bd2bce1-1241-e2e1-cab7-c48813584248@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [88.87.191.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebb9e59c-5bf0-47d6-4d05-08d858baa70f
x-ms-traffictypediagnostic: MN2PR11MB4630:
x-microsoft-antispam-prvs: <MN2PR11MB463074532BACB16C55CCEFF096230@MN2PR11MB4630.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymMu2CLuOrJkVlOo6NPcKTyUkxkxiYPz93x1lmljV7LGEh6PeB5dW1/AMEAe3aJoyFYS8si72XpkD3Uxc6Xy9HMP8cNBW9BTpNApp+Ug8xPvVlUrlkx6CTcK8DqBpsbXJjXhO/F7+phV8P/ff1Z+jYDLTpBNh26Eo+BY9ueXHlogKWoRdirhHF+azViGwM/3nYS4RuURxu6M4oAshQE9R6EMgyy66fNBxdZdLL0IByxu3OBuvjydPQ67curiGftDb60WC+vIV1qAxfIZhRVddNfzlE3yh8lZK5nHfY9Jk6EYp0c518M2Z4079pX3SKf3ST8YrRBHbsKPh2MPgR42iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(8936002)(71200400001)(76116006)(2906002)(91956017)(6512007)(110136005)(6486002)(31696002)(26005)(186003)(86362001)(36756003)(478600001)(31686004)(6506007)(66476007)(4326008)(316002)(83380400001)(66446008)(64756008)(8676002)(66556008)(5660300002)(2616005)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bzQWO3yPs3k7utBZCPHvXtuSQaw1XK6sRyDW2HxmJY/c/rN4DjtYImhS2rROU8hQqI4d+Xl4Rt2/mexUFgXOh5iDlziuhO4DCtrPbkrRV69jM1SFguVSfztQlOyDyN+q1Gz5GOLvtLQa6rGkv3E9+8NzdkHLVwBoqyAjdr2WF9vYgOJ10IQ8lQSvNpNM4FzKRxym7G0s+a8JFnaQCup0TY0n235P/0XC7G3Jpg60N3O990eMw2P3W5hytlODOFwvW8xNscDwDFHIL5h+H1SoseLCcP4giKTq8U+vApwKhpXBgAGajIFUE1fmTxAvi3h/10ReQEPSICggV90Ca/bbX0KSmnbPlNh82Afv7JNBLfP56WJ6/G67liHdWIzhY+lvHrxpojAeSe8EG0xAlSYASnF3+yYjnng4GQcuNXhB9qIa8f19hBSrG7A8rMLPiCkZVZ3JbeFIFXrHxwRDxHgb9dTlA69Zujd51WJ8ceDtg8IkwlNzbMqSc9FuU5Si8sWeRbuQ91aRwI5rEDA6tjp2ydDgQ2LAic+xVBReg6/BJUlfgCU711wDUKEXXMtX77sMWseI/pWYKigt4g3U3l4TY5+mnxcE8J3193Hh2ol479Dyq0bHEdzAVC1ZvJu3493izR+PbMSY212oZRyhdl14DQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC2D1AFEA2661C40B1E35408E7776FB4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb9e59c-5bf0-47d6-4d05-08d858baa70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 14:29:56.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LzZRUr9rOHX2i8yImCPMpOwT6tK6TNxDLjpDY5jJhhjjHZNkW6CAk8MgdurlHZZURNPDOOospzHf5kNLt2yj2Rdrm21Onb2HQP+z8EmQzZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpNYW55IGRyaXZlcnMgY2FuIG5vdyB1c2UgcGNpX2hvc3RfY29tbW9uX3Byb2JlKCkgZGlyZWN0
bHkuDQpUaGVpciBoYXJkd2FyZSB3aW5kb3cgc2V0dXAgY2FuIGJlIG1vdmVkIGZyb20gdGhlaXIg
J2N1c3RvbScgcHJvYmUNCmZ1bmN0aW9ucyB0byBpbmRpdmlkdWFsIGRyaXZlciBpbml0IGZ1bmN0
aW9ucy4NCg0KU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1p
Y3JvY2hpcC5jb20+DQotLS0NCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1v
bi5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWhvc3QtY29t
bW9uLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1ob3N0LWNvbW1vbi5jDQppbmRleCA2
Y2UzNGExZGVlY2IuLjZhYjY5NGY4ZDI4MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpLWhvc3QtY29tbW9uLmMNCisrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWhvc3QtY29tbW9uLmMNCkBAIC02NCw2ICs2NCw4IEBAIGludCBwY2lfaG9zdF9jb21tb25fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKCFicmlkZ2UpDQogCQlyZXR1
cm4gLUVOT01FTTsNCiANCisJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgYnJpZGdlKTsNCisN
CiAJb2ZfcGNpX2NoZWNrX3Byb2JlX29ubHkoKTsNCiANCiAJLyogUGFyc2UgYW5kIG1hcCBvdXIg
Q29uZmlndXJhdGlvbiBTcGFjZSB3aW5kb3dzICovDQpAQCAtNzgsOCArODAsNiBAQCBpbnQgcGNp
X2hvc3RfY29tbW9uX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWJyaWRn
ZS0+c3lzZGF0YSA9IGNmZzsNCiAJYnJpZGdlLT5vcHMgPSAoc3RydWN0IHBjaV9vcHMgKikmb3Bz
LT5wY2lfb3BzOw0KIA0KLQlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBicmlkZ2UpOw0KLQ0K
IAlyZXR1cm4gcGNpX2hvc3RfcHJvYmUoYnJpZGdlKTsNCiB9DQogRVhQT1JUX1NZTUJPTF9HUEwo
cGNpX2hvc3RfY29tbW9uX3Byb2JlKTsNCi0tIA0KMi4yNS4xDQoNCg==
