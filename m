Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCBE268DB9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 16:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgINObl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 10:31:41 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56989 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgINOav (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 10:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600093850; x=1631629850;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mOPO3mRWsy0zFJx4/mseJkajmcGc2uB7FSp1ZZyMLEg=;
  b=tXRNMFg/6xaQN7j4AjUGEGyw4mBvucW2ZVnkG6mNpn3x0NRnQZ5MSmRH
   oUvTgAjr0YUjWy7xM7+Yn3UpxsDQQZTeViPp7OKshkVZkq/fjMFsngzlR
   w1fi9VCLlg3IaUXLKfvARTVsEG5w8qi9RKzFPm9zIPEJV4RtwAf3nw84o
   3ZdbQrnqrsv4RkVVc/A4fnmFeptvyEsr93a+Tx/iLjaAMeHU9SPh/SusH
   POhW6iLwBemqUE8AwepH8Buvm+QXAHnSr2jbDlQFWuxOVlSCLgmaoHAD7
   YMNFJAtTH4VcpiK9YhcXCEB/JOK8hItg9FpU1JqnZ1gEd/r3hvPDq1FZn
   w==;
IronPort-SDR: kxo2PQGKfrC5E+E5gNsCso9U1ceYF/H3UOad5oWXZL9i3va9Sp0lSRpgz+UbT+Fz7NlPY7ry5i
 /N4KBAAmibzkL8KnZmzQssoCrmUJnsg/aSCb7B0A3vNxLqvQ0FO0ggNQmtzkpVgJ1Lm5BTjVRT
 9GtFl9ckyVEr9gb5VNCMi21h/ozPNYoEC7/fNuIYb9s/4RQER2OWXdTh+SBgDY4rHHHrKbVvVA
 9VFApMs0VId2DeK+xaGnxCNNrSIc+wqjMLkLbmIaecaiPsQYc3hGCCcKwvn2LOd1vU+ZGLzQck
 A+4=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="88995237"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:30:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:30:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 14 Sep 2020 07:30:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkrvZNBfEFuZ3DgPEbLpzGkvnLvd79+tZs0N451AguVFirx6JwS4nZop8RA2xhcuW9ux8XtYGMzx5KySXNUjRZ+Dnt3UK/99786g3TpWhyOJZYRmEDMDe7sJTH5lrkFU2xf+XvKESGpxii8xeECAYr/dpP8wx6aebp3bAi1b+WwDx1L1oxqFSMyzwPXgpyXRLYU22PKcZ+GiALcrB7hW0393Wui5InXYUsvEaw9odEaI1Jo/40YUir3yMiSQ6yMrXgXa4FJ7ChvmODVCoFjeq6gYJCKNU0y8i3GcGq9G3De1L6fv6SoFHl1mtgcWXKb1oieyyhvqd/oBx9jhQEJ3IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOPO3mRWsy0zFJx4/mseJkajmcGc2uB7FSp1ZZyMLEg=;
 b=Kk8vB7USqNgDjiUwH+icvWLodZWckWU5pMuaIyV2iCXLJugo58VkKCPzSauMdMi6PHABtWdOJ4qkDi4fuO2EC0tZqSMY7D/YXD4+tdDfmCMsrERyhOCACStkNptlmG9uEI3xIUAmn2vgGspUV9m5LRmuRtAxOmKaCT1GBEhXC311ivQC89a2zNTQYRK53KItNlu15oyS6doFx2MHpB5DgyuIW050L54tmCKmNFG+8ut7nAhV8KvrZaFZW+MEbh0ldp3kVDcMepKhNn8xA6Bs+hM7F7BIR4RT3pD6l0nEvQ/vacxmje4+rRht4+XwBDGj8d+ja+qo9bTjRb4Dmd96Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOPO3mRWsy0zFJx4/mseJkajmcGc2uB7FSp1ZZyMLEg=;
 b=BIfAu2OUrAyXqcdUgTTc19J+hHDna/UxvhCRCJ6pXmm36lc+PhvOlZ/CRHGSBbTO1VfIo4U2c1VgX0JGb8SSH/UQnawo7NSTAYZLjBzV6JvdrjSe4XovAi61PD5QyGQlaf3sOxxrDcsdBXKfv9pEPpn01KZC/ZSKNQH4dDhtvUU=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB3459.namprd11.prod.outlook.com (2603:10b6:208:69::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:30:38 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::38d4:de41:43a4:4642]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::38d4:de41:43a4:4642%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:30:38 +0000
From:   <Daire.McNamara@microchip.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <robh@kernel.org>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: Re: [PATCH v16 2/3] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Thread-Topic: [PATCH v16 2/3] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Thread-Index: AQHWiqOdSWWbCdLV9U24fK+YHFIgrg==
Date:   Mon, 14 Sep 2020 14:30:38 +0000
Message-ID: <2c2f0aa7-3ee4-1874-87e4-d224b192c6ed@microchip.com>
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
x-ms-office365-filtering-correlation-id: e2f31e21-9c8a-4a91-fa00-08d858bac05c
x-ms-traffictypediagnostic: BL0PR11MB3459:
x-microsoft-antispam-prvs: <BL0PR11MB345925020539E1F9B63D210696230@BL0PR11MB3459.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LBlei9Av7oSLlI3mrTE9D1SjD516/2ey6RAzNx88A+sGl9dP/QxRC7d6x20+5ojTQDS10T7rn/5+V+R8vcEhkIzCN6vu30gljMRwmBfDkOCiUVmvvgJb3q5G2xqNOddFs0mcNBwYDIvoIl5SqZdyRAn5/YWMurajN1aHyTmuu/jdoHzKudG3E64o6Bk8Aw/d5DwcpYP7yVb3tcqVluLXKK85HlfLN+7mZc4Le82M+PdH6y76ZhIf4Sua6FSmGXkadM4novtmyjhcE4yW2wf0lS+omOWLCQA4XuTxU3tSwCwct0/Jt7wEw6gfueDPcYJck73TZnItc6ocu2qqYdsQjHpnsdFqCl/t6PhESfk1osiUVGMvylw9LIt6PRL5NhMfgnOgV0xG0rxhmRrxEzQyGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(66446008)(36756003)(2906002)(86362001)(8936002)(966005)(110136005)(316002)(6486002)(4326008)(66946007)(2616005)(31686004)(64756008)(478600001)(66476007)(66556008)(6512007)(91956017)(31696002)(71200400001)(186003)(76116006)(8676002)(26005)(6506007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bJpzJSg+C8yW/8zyF99UgLnnGby/NkqFfl+iPlJzVWYyQXUAPLe1L6grcg4+CSx/r9PdzjgwUjuG+WflcPXAsGjWxWbk1d/fK3DCkfWAqE2mR6NcreO6B6rHHdY3XhV7PSl/aKII56puLUV+ECEpO/nyjqwtwY++PEGjoFJW3FU5N30QiH6Qvi49sp1d0e2nLta5nnU8Nf5ByeaVyfMnkgkn2yW8czy02TLr2SVk2eI4GaS4VXN0nw69qq5ZjI69pTXp9Im8aWdvtkztgyNw44tfAfLCoydrulV5QDw0w8HV2L+fsYTZH9bvnrEj8awwGPe/gWSt5Nj/q9qx9oMAHLjrVenK1dS1++DWS+1G2Gn5GE6zE53QmrpGD3MOj8+E4Z9dQb3hURVz+Jk/MacfQS8iLvhaR5Uwmyr9H4E0YrJ8lzcywQOSbAgcxtkexrfiygSiYy1LWtqeBjOYudxOOL5AnI+YjWI9gjKMT+WoSpRfJDWxlyD1s4ISau7kmSpTTOSgwxXjkzlZ8V/b4DtXFPaE/Qsy7Vn/n6Ls8mjapS35JON3vCfzRRbYfS6rkolbk+z9atQ0O4TNyg0heG565eBsRGv+SQ9NDCWEh4zCVMQdKBbeI2G8Yfr9yprmzICSTekYyXAcTkgWTkVRndt2Yw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A763D62CB3CC1148B7AB95B2EA1CF8BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f31e21-9c8a-4a91-fa00-08d858bac05c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 14:30:38.5146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaJvWKVTB2fR5fe4rk2xhLjsChy1TdPFsOTiox8wcmWnVHNKqDbPSOP/GOKp6OqF85R5qx/XDVKO+WSygf7OzZNJ0IN0tlTQfReorPETxyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3459
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpBZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBNaWNyb2NoaXAgUG9sYXJGaXJlIFBD
SWUgY29udHJvbGxlcg0Kd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxleCkgbW9k
ZS4NCg0KU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1pY3Jv
Y2hpcC5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFt
bCAgICAgfCA5MyArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDkzIGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1o
b3N0LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmI1NTk0
MTgyNmI0NA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCkBAIC0wLDAgKzEsOTMgQEANCisj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
CislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Bj
aS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1pY3JvY2hpcCBQQ0llIFJv
b3QgUG9ydCBCcmlkZ2UgQ29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KKw0KK21haW50
YWluZXJzOg0KKyAgLSBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNv
bT4NCisNCithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvcGNpL3BjaS1idXMueWFtbCMNCisN
Citwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgY29uc3Q6IG1pY3JvY2hpcCxwY2ll
LWhvc3QtMS4wICMgUG9sYXJGaXJlDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAyDQorDQor
ICByZWctbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGNmZw0KKyAgICAgIC0g
Y29uc3Q6IGFwYg0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4
SXRlbXM6IDINCisgICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBob3N0IGNv
bnRyb2xsZXINCisgICAgICAtIGRlc2NyaXB0aW9uOiBidWlsdGluIE1TSSBjb250cm9sbGVyDQor
DQorICBpbnRlcnJ1cHQtbmFtZXM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiAy
DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IHBjaWUNCisgICAgICAtIGNvbnN0OiBtc2kN
CisNCisgIHJhbmdlczoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGRtYS1yYW5nZXM6DQorICAg
IG1heEl0ZW1zOiAxDQorDQorICBtc2ktY29udHJvbGxlcjoNCisgICAgZGVzY3JpcHRpb246IElk
ZW50aWZpZXMgdGhlIG5vZGUgYXMgYW4gTVNJIGNvbnRyb2xsZXIuDQorDQorICBtc2ktcGFyZW50
Og0KKyAgICBkZXNjcmlwdGlvbjogTVNJIGNvbnRyb2xsZXIgdGhlIGRldmljZSBpcyBjYXBhYmxl
IG9mIHVzaW5nLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSByZWcNCisgIC0gcmVnLW5hbWVzDQorICAt
IGRtYS1yYW5nZXMNCisgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQorICAtIGludGVycnVwdHMNCisg
IC0gaW50ZXJydXB0LW1hcC1tYXNrDQorICAtIGludGVycnVwdC1tYXANCisgIC0gbXNpLWNvbnRy
b2xsZXINCisNCit1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQor
ICAtIHwNCisgICAgc29jIHsNCisgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCisg
ICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCisgICAgICAgICAgICBwY2llMDogcGNpZUAy
MDMwMDAwMDAwIHsNCisgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlw
LHBjaWUtaG9zdC0xLjAiOw0KKyAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MjAgMHgzMDAw
MDAwMCAweDAgMHg0MDAwMDAwPiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDIwIDB4
MCAweDAgMHgxMDAwMDA+Ow0KKyAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImNmZyIs
ICJhcGIiOw0KKyAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCisgICAg
ICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KKyAgICAgICAgICAgICAgICAg
ICAgI3NpemUtY2VsbHMgPSA8Mj47DQorICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNl
bGxzID0gPDE+Ow0KKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwzMj47DQorICAg
ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHgwIDB4MCAweDAgMHg3PjsN
CisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAgPSA8MCAwIDAgMSAmcGNpZTAgMD4s
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDIgJnBjaWUwIDE+
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAzICZwY2llMCAy
PiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgNCAmcGNpZTAg
Mz47DQorICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljMD47DQor
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCisgICAgICAgICAgICAg
ICAgICAgIG1zaS1wYXJlbnQgPSA8JnBjaWUwPjsNCisgICAgICAgICAgICAgICAgICAgIG1zaS1j
b250cm9sbGVyOw0KKyAgICAgICAgICAgICAgICAgICAgYnVzLXJhbmdlID0gPDB4MDAgMHg3Zj47
DQorICAgICAgICAgICAgICAgICAgICByYW5nZXMgPSA8MHgwMzAwMDAwMCAweDAgMHg0MDAwMDAw
MCAweDAgMHg0MDAwMDAwMCAweDAgMHgyMDAwMDAwMD47DQorICAgICAgICAgICAgICAgICAgICBk
bWEtcmFuZ2VzID0gPDB4MDIwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHgx
IDB4MDAwMDAwMDA+Ow0KKyAgICAgICAgICAgIH07DQorICAgIH07DQotLSANCjIuMjUuMQ0KDQo=
