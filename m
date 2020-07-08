Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D47218A92
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgGHO70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 10:59:26 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:11970 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729948AbgGHO70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594220365; x=1625756365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zlO9e+p2Z5JkXzCMtcipJaeTOHC6wswv8m/Q9Kl1vZw=;
  b=wPYLj2wwyiQanpzM5uZm9Nh8YliG4tnPevzceJu0xuxa75fDrfPKruq6
   Aw9WXmSQDWc64jITx/pSh6r8SZ8/GZjgKhX2rN1nlw1WoZPsr8ELIUTE8
   hxoX0P+AK4dI7ygw0fsCRK6nnUQzmXGdumNjsViF66s7PUs5ZQHWwQ8/W
   iyNFQOHpmFtcf67NGtnMKSUlrkTGwNrkPdyczS/wdVZxGN2MXYFpqwhOX
   qzrtQ/DScBapTzoAisXFTfSa4lgC4TNQ+PmSkvgHu4b5g/uCitI8u6WP0
   dyDizVNLRfoeMh7gzxq6P23qjaZhu/t578mH1bMAbHaAg3cOtV3kCbfqA
   g==;
IronPort-SDR: T55Psg89Uz4jJ6lZix81AlG3zNIeUR0hsEob3g69M5t2Z+Hj5rjqpbCcQtfEwBqG2E5SNaeVzm
 GaUESOkQ+1NOBM5A0eA2oFc91It2onr3NVKbRtypsORjXx9LQ6/ZC4MtpyHHe6QNAgYiPJNa+d
 TrXl4CVOZLic6jmwYhnJz3GqIPwS8SMmrfKYyh1Zn1f47gqMIu3u8zIsyerGkuxvz5gV3qwB5A
 AV8DneIzJAFgOxI3JstFKRycPU/JBaw0Q68byYPm7X1JD8irvaTUCtTKpMclWycS++qrngdSNd
 o5A=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="79156214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 07:59:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 07:58:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 8 Jul 2020 07:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYfCnierFTqpwbhKdCVvdrImxwrnxott508LqMXobuZjj+rlR47fAgvbeuK6JeBiIgp9zRCOaHb516VGcEc1600Y3qZGUCoRMY5awlX5M/NkCWQ34boZSwCsi/IQ0oht6iIPVeebYI/fdUeJdbsdE0dpo6NXFHBKnPf4mPakx8LTkQ+ixBomKrG+fWpTdL3jxoo2WFLpNt93Yd7/jMg6AtD49CHsHq9tyuzIhdFOQgsOwKeAWOQtnaTJ1b1EdRD5z/ZRTRIdc/WXBzEya43B/udU+IuIh6wVD7MNW6sM8KkkaO0DuKO3Td9L9YBJJOTb3+uxdGbSx/0H8HbRs/D3wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlO9e+p2Z5JkXzCMtcipJaeTOHC6wswv8m/Q9Kl1vZw=;
 b=DWuffVuBjT+RHN2MtfuKqygbv5lam2elh0qGXpZ9ZD2/rWL37DutU81tokebf7yjXYAz9jZi7D2or4reWZHBHjpa5fU80LCJyPV9C67i6HvTPe1NRwbL0M5VLfq9NcwfgV4dAOesVEvV8nzXrkSwaE4vAQ7Gwb5TngTNHMpdhCO8mHTB2ubn3mxuZD+zp1PnCt2AKu7rlyzKjSgF/aU7QCRU3iPwC8i8bj6ewLwtUxnXk82rYCNnpBmpF5gj3CNsaVCTocc+oLO5NZA4X17JVVzao+CnXd8ZB2G8CoBolD+W5Hgi7bxyV5mOYCe+gCMGX3UiGiIMRHmw3KV37Vw6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlO9e+p2Z5JkXzCMtcipJaeTOHC6wswv8m/Q9Kl1vZw=;
 b=U5U69IXUJPQicIjr12VM3sxb9dZrJkfMxbUvBX92fkQ2fWVVYXFmzIt5ZKKMWQtihy0UQQyx/SfLaMS91iS8C1pkMTInLmQ4jLWl9qwCoq+O3c+K6WCzaWg13vd+GMrQG7O0mn728sm90QLOYtrt9yoGclOZ27Q8Hfo3+SuPlHg=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB2946.namprd11.prod.outlook.com (2603:10b6:208:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 14:59:22 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12%7]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 14:59:22 +0000
From:   <Daire.McNamara@microchip.com>
To:     <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <Daire.McNamara@microchip.com>
Subject: [PATCH v13 1/2] dt-bindings: PCI: microchip: Add Microchip PolarFire
 host binding
Thread-Topic: [PATCH v13 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Thread-Index: AQHWVThdDFwQcmCCQk62lxQpMGxvMA==
Date:   Wed, 8 Jul 2020 14:59:22 +0000
Message-ID: <c769cbe749bc815922d5da3ece0f378bc01f532a.camel@microchip.com>
References: <56d2a9855f93455c6150b92682178c93fe70ed72.camel@microchip.com>
In-Reply-To: <56d2a9855f93455c6150b92682178c93fe70ed72.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43fb7a6e-805f-4ee2-7b7f-08d8234f7fc9
x-ms-traffictypediagnostic: BL0PR11MB2946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB29468DE28429FF3752358FD296670@BL0PR11MB2946.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Di1L3WYmKHmI6gCYWTzKsNC7dqLB0L0DgCNFnE53Ds1GZh+p8ToW0N83fiUCp1AXQrCG0JbIPVaW4bo5gudle3pR/L1Ri5u8xMvM2v5xv93aW1fkuRKFV4daLKxtfOWGU/AWax5/ffUXOCAlNKy/liQNsBo4ly+M0OHwd+FJ18+KfDFNWCLQPL68uquIwipiYZAm8XMGOC0IMCRKKwL+bXuK+e3iO4SfqY5v2YltlgZvupJylxe1IPYYim2EsAdvmkjF73BfvgytviZoODxKgZ007m+j+18MMZbfALG1fxBxUPoibLYbUbHMal4EMIvoVgu3Ja8plp0MT9O9uJuvUOJ8oddx1hIaTuuG+yqMyN/8dQna9PpXX1GmNpVju6KJtmjcAWOjwvhQ8XdZcOGKOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(8676002)(8936002)(316002)(6486002)(2616005)(71200400001)(478600001)(5660300002)(76116006)(66946007)(66556008)(66476007)(91956017)(66446008)(64756008)(186003)(2906002)(4326008)(26005)(110136005)(966005)(36756003)(54906003)(86362001)(6512007)(107886003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WnW9gq2cFwgMVLWJqK/nfFk8YlnIRCUulYnFrwwxRo4w2M9KtmD7SmWx9GEeNP9Q7zbg8mKPc3nHnrsfnF853bjBoDQGNNEqbJeoxG9Fsejs8mFk0fWmNzrNwDDS0CeIXW4l7nS/dhIC2B4gcBKMJKWC3C7tR7d072Nzs0RTvFyYBXJGFTuDpC2RkvCzIY4ecJ8bHpmlDA9wh3UuUPqRfw2hpUHsprlyjoM8fsLTPYDY5ICioGjP5ecq6vOtSfI7ntbnFbb4yVrY8NludhKEb9KNGiVzawRYxkNWP3kOnBPLfgzspgqNBM5ULwNRtFSbDX/pHM7SuZ2gjQ1neIBuI3M2TTKUd9ruvq7diigIOXfsJGr2UcwRxFUSQmRnNNS24eiI7TOU5aE/N99fZdfJJbAgq7djhjvbMAImZFpr1fIPrH00nGwGJrdwAKfweh6ornfr4vbb2Afqv+uu1QqNp73yrcb1yfbfjGKze7ZMqjNLrCf5t+E9JuHl/Q5fW33V
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8B3F2FE3DA61948B444DC855BC16175@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fb7a6e-805f-4ee2-7b7f-08d8234f7fc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 14:59:22.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdeWHKFryxo7EgmYmxi2/diNt8zhjXCeA1X+Zik1uj+8fmFmuZ7ZtQrawveroEJ3mljWOh+Dw3xOCB7JoIDH/n1DpcGhMZ7mZZ/yiNrt8hI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2946
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgTWljcm9jaGlwIFBvbGFyRmlyZSBQQ0ll
IGNvbnRyb2xsZXINCndoZW4gY29uZmlndXJlZCBpbiBob3N0IChSb290IENvbXBsZXgpIG1vZGUu
DQoNClNpZ25lZC1vZmYtYnk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2No
aXAuY29tPg0KLS0tDQogLi4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwg
ICAgIHwgOTMgKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRp
b25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9z
dC55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5iNTU5NDE4
MjZiNDQNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQpAQCAtMCwwICsxLDkzIEBADQorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQor
JVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wY2kv
bWljcm9jaGlwLHBjaWUtaG9zdC55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBNaWNyb2NoaXAgUENJZSBSb290
IFBvcnQgQnJpZGdlIENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MNCisNCittYWludGFp
bmVyczoNCisgIC0gRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+
DQorDQorYWxsT2Y6DQorICAtICRyZWY6IC9zY2hlbWFzL3BjaS9wY2ktYnVzLnlhbWwjDQorDQor
cHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBtaWNyb2NoaXAscGNpZS1o
b3N0LTEuMCAjIFBvbGFyRmlyZQ0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMg0KKw0KKyAg
cmVnLW5hbWVzOg0KKyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBjZmcNCisgICAgICAtIGNv
bnN0OiBhcGINCisNCisgIGludGVycnVwdHM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0
ZW1zOiAyDQorICAgIGl0ZW1zOg0KKyAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgaG9zdCBjb250
cm9sbGVyDQorICAgICAgLSBkZXNjcmlwdGlvbjogYnVpbHRpbiBNU0kgY29udHJvbGxlcg0KKw0K
KyAgaW50ZXJydXB0LW5hbWVzOg0KKyAgICBtaW5JdGVtczogMQ0KKyAgICBtYXhJdGVtczogMg0K
KyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBwY2llDQorICAgICAgLSBjb25zdDogbXNpDQor
DQorICByYW5nZXM6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBkbWEtcmFuZ2VzOg0KKyAgICBt
YXhJdGVtczogMQ0KKw0KKyAgbXNpLWNvbnRyb2xsZXI6DQorICAgIGRlc2NyaXB0aW9uOiBJZGVu
dGlmaWVzIHRoZSBub2RlIGFzIGFuIE1TSSBjb250cm9sbGVyLg0KKw0KKyAgbXNpLXBhcmVudDoN
CisgICAgZGVzY3JpcHRpb246IE1TSSBjb250cm9sbGVyIHRoZSBkZXZpY2UgaXMgY2FwYWJsZSBv
ZiB1c2luZy4NCisNCityZXF1aXJlZDoNCisgIC0gcmVnDQorICAtIHJlZy1uYW1lcw0KKyAgLSBk
bWEtcmFuZ2VzDQorICAtICIjaW50ZXJydXB0LWNlbGxzIg0KKyAgLSBpbnRlcnJ1cHRzDQorICAt
IGludGVycnVwdC1tYXAtbWFzaw0KKyAgLSBpbnRlcnJ1cHQtbWFwDQorICAtIG1zaS1jb250cm9s
bGVyDQorDQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAg
LSB8DQorICAgIHNvYyB7DQorICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQorICAg
ICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQorICAgICAgICAgICAgcGNpZTA6IHBjaWVAMjAz
MDAwMDAwMCB7DQorICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxw
Y2llLWhvc3QtMS4wIjsNCisgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDIwIDB4MzAwMDAw
MDAgMHgwIDB4NDAwMDAwMD4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgyMCAweDAg
MHgwIDB4MTAwMDAwPjsNCisgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJjZmciLCAi
YXBiIjsNCisgICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gInBjaSI7DQorICAgICAg
ICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCisgICAgICAgICAgICAgICAgICAg
ICNzaXplLWNlbGxzID0gPDI+Ow0KKyAgICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxs
cyA9IDwxPjsNCisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MzI+Ow0KKyAgICAg
ICAgICAgICAgICAgICAgaW50ZXJydXB0LW1hcC1tYXNrID0gPDB4MCAweDAgMHgwIDB4Nz47DQor
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWUwIDA+LA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAyICZwY2llMCAxPiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgMyAmcGNpZTAgMj4s
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDQgJnBjaWUwIDM+
Ow0KKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYzA+Ow0KKyAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQorICAgICAgICAgICAgICAg
ICAgICBtc2ktcGFyZW50ID0gPCZwY2llMD47DQorICAgICAgICAgICAgICAgICAgICBtc2ktY29u
dHJvbGxlcjsNCisgICAgICAgICAgICAgICAgICAgIGJ1cy1yYW5nZSA9IDwweDAwIDB4N2Y+Ow0K
KyAgICAgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4MDMwMDAwMDAgMHgwIDB4NDAwMDAwMDAg
MHgwIDB4NDAwMDAwMDAgMHgwIDB4MjAwMDAwMDA+Ow0KKyAgICAgICAgICAgICAgICAgICAgZG1h
LXJhbmdlcyA9IDwweDAyMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4MSAw
eDAwMDAwMDAwPjsNCisgICAgICAgICAgICB9Ow0KKyAgICB9Ow0KLS0gDQoyLjE3LjENCg0K
